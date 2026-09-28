#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include "flutter_window.h"
#include "utils.h"

namespace {

// Die App laeuft nur EINMAL je Windows-Anmeldung.
//
// WARUM: Das Kreuz beendet die App nicht, es versteckt sie im Infobereich
// (DesktopPlatformService.onWindowClose). Wer sie danach ueber die
// Desktop-Verknuepfung, das Startmenue oder den Autostart wieder oeffnete,
// bekam einen ZWEITEN Prozess mit eigener WebSocket-Verbindung - und der
// Server stellt eine Fernwartungsanfrage jeder Verbindung des Mitglieds zu.
// Mit mehreren Kopien sah der Vorsitz bei der Fernwartung nur Schwarz.
//
// "Local\" gilt je Anmeldesitzung: zwei Benutzer am selben Rechner behalten
// jeder ihre eigene App. Debug getrennt von Release, damit `flutter run`
// neben der installierten App moeglich bleibt.
#ifdef NDEBUG
constexpr wchar_t kEinzelinstanz[] = L"Local\\ICD360S.Mitglieder.Einzelinstanz";
constexpr wchar_t kFensterMarke[] = L"ICD360S.Mitglieder.Hauptfenster";
#else
constexpr wchar_t kEinzelinstanz[] =
    L"Local\\ICD360S.Mitglieder.Einzelinstanz.Debug";
constexpr wchar_t kFensterMarke[] = L"ICD360S.Mitglieder.Hauptfenster.Debug";
#endif

BOOL CALLBACK MarkeSuchen(HWND fenster, LPARAM gefunden) {
  if (::GetPropW(fenster, kFensterMarke) == nullptr) {
    return TRUE;
  }
  *reinterpret_cast<HWND*>(gefunden) = fenster;
  return FALSE;
}

// Das Fenster der laufenden App - erkannt an kFensterMarke. Nicht am Titel
// (den setzt window_manager um) und nicht an der Fensterklasse: die heisst
// in JEDER Flutter-App FLUTTER_RUNNER_WIN32_WINDOW.
HWND LaufendesFenster() {
  HWND gefunden = nullptr;
  ::EnumWindows(MarkeSuchen, reinterpret_cast<LPARAM>(&gefunden));
  return gefunden;
}

// Holt die laufende App nach vorne - auch aus dem Infobereich.
void NachVorneHolen(HWND fenster) {
  // Nach vorne holen darf nur, wen der Benutzer gerade gestartet hat - also
  // dieser Prozess, nicht die laufende App. Das Recht weiterreichen, sonst
  // blinkt nur die Taskleiste.
  DWORD prozess = 0;
  ::GetWindowThreadProcessId(fenster, &prozess);
  ::AllowSetForegroundWindow(prozess);
  // Asynchron wie windowManager.show(): haengt die laufende App, bleibt
  // dieser Start nicht mit ihr haengen.
  ::ShowWindowAsync(fenster, ::IsIconic(fenster) ? SW_RESTORE : SW_SHOW);
  ::SetForegroundWindow(fenster);
}

// true: dieser Prozess ist die einzige App und startet.
// false: eine andere laeuft schon (und steht jetzt vorne) - beenden.
//
// Der Mutex bleibt bis zum Prozessende offen. Endet die App - auch durch
// Absturz, Taskmanager oder Update -, gibt Windows ihn frei; ein alter Name
// kann den naechsten Start also nie aussperren.
bool EinzigeInstanz() {
  HANDLE sperre = ::CreateMutexW(nullptr, TRUE, kEinzelinstanz);
  if (sperre == nullptr) {
    // Unerwartet, etwa fremde Rechte am Namen. Lieber zwei Kopien als gar
    // keine App.
    return true;
  }
  if (::GetLastError() != ERROR_ALREADY_EXISTS) {
    return true;
  }
  // Bis zu 5 s: Entweder die andere beendet sich gerade ("Beenden" im
  // Infobereich) - dann starten wir, sobald sie weg ist -, oder ihr Fenster
  // ist da - dann holen wir es nach vorne.
  for (int versuch = 0; versuch < 50; ++versuch) {
    const DWORD warten = ::WaitForSingleObject(sperre, 100);
    if (warten == WAIT_OBJECT_0 || warten == WAIT_ABANDONED) {
      return true;
    }
    const HWND fenster = LaufendesFenster();
    if (fenster != nullptr) {
      NachVorneHolen(fenster);
      ::CloseHandle(sperre);
      return false;
    }
  }
  ::CloseHandle(sperre);
  return false;
}

}  // namespace

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command) {
  // Attach to console when present (e.g., 'flutter run') or create a
  // new console when running with a debugger.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

  // Vor allem anderen: ein zweiter Start baut nichts auf, er holt nur die
  // laufende App nach vorne.
  if (!EinzigeInstanz()) {
    return EXIT_SUCCESS;
  }

  // Initialize COM, so that it is available for use in the library and/or
  // plugins.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  flutter::DartProject project(L"data");

  std::vector<std::string> command_line_arguments =
      GetCommandLineArguments();

  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  FlutterWindow window(project);
  Win32Window::Point origin(10, 10);
  Win32Window::Size size(1280, 720);
  if (!window.Create(L"MitgliederPortal - ICD360S e.V", origin, size)) {
    return EXIT_FAILURE;
  }
  window.SetQuitOnClose(true);
  // Ab jetzt findet ein zweiter Start dieses Fenster.
  ::SetPropW(window.GetHandle(), kFensterMarke, window.GetHandle());

  // ==========================================
  // SECURITY HARDENING
  // ==========================================

  // 1. DLL injection protection - remove CWD from DLL search path
  ::SetDllDirectoryW(L"");

  // 2. Heap corruption protection - terminate on corruption (anti-exploit)
  ::HeapSetInformation(NULL, HeapEnableTerminationOnCorruption, NULL, 0);

  // 3. ACG (Arbitrary Code Guard) — DISABLED.
  //
  // ProhibitDynamicCode=1 blocks every code page that wasn't on disk at
  // load time, which kills ANGLE's GL->D3D shader translator and Skia's
  // shader cache. With ACG on, EGL_CONTEXT_LOST (0x300E) fires on every
  // frame and the Flutter view never paints — the user only sees the
  // window chrome, which is exactly the white-window symptom reported.
  //
  // ACG is fundamentally incompatible with any GPU-accelerated framework
  // that JITs shaders (Flutter, Chromium-based shells, Electron, Unity,
  // anything that loads a graphics driver doing runtime codegen).
  //
  // The other five mitigations below (DLL injection block, heap
  // corruption termination, image-load policy, DEP, anti-debug) all
  // remain on; they don't touch JIT.

  // 4. Image Load Policy - block DLLs from network/low integrity
  PROCESS_MITIGATION_IMAGE_LOAD_POLICY imageLoadPolicy = {};
  imageLoadPolicy.NoRemoteImages = 1;
  imageLoadPolicy.NoLowMandatoryLabelImages = 1;
  ::SetProcessMitigationPolicy(ProcessImageLoadPolicy,
    &imageLoadPolicy, sizeof(imageLoadPolicy));

  // 5. DEP - force Data Execution Prevention
  PROCESS_MITIGATION_DEP_POLICY depPolicy = {};
  depPolicy.Enable = 1;
  depPolicy.Permanent = 1;
  ::SetProcessMitigationPolicy(ProcessDEPPolicy,
    &depPolicy, sizeof(depPolicy));

  // 6. Anti-debugging (release builds only)
  #ifdef NDEBUG
  BOOL remoteDebugger = FALSE;
  ::CheckRemoteDebuggerPresent(::GetCurrentProcess(), &remoteDebugger);
  if (remoteDebugger) {
    return EXIT_FAILURE;
  }
  #endif

  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }

  // "Beenden" im Infobereich (windowManager.destroy = PostQuitMessage) laesst
  // das Fenster noch stehen, bis die Engine abgebaut ist - es nimmt aber keine
  // Nachrichten mehr an. Ein Start in diesem Moment soll es nicht mehr nach
  // vorne holen wollen, sondern warten, bis diese Instanz weg ist.
  ::RemovePropW(window.GetHandle(), kFensterMarke);

  ::CoUninitialize();
  return EXIT_SUCCESS;
}
