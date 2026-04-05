#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include "flutter_window.h"
#include "utils.h"

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command) {
  // Attach to console when present (e.g., 'flutter run') or create a
  // new console when running with a debugger.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
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
  if (!window.Create(L"icd360sev_mitglied", origin, size)) {
    return EXIT_FAILURE;
  }
  window.SetQuitOnClose(true);

  // ==========================================
  // SECURITY HARDENING
  // ==========================================

  // 1. DLL injection protection - remove CWD from DLL search path
  ::SetDllDirectoryW(L"");

  // 2. Heap corruption protection - terminate on corruption (anti-exploit)
  ::HeapSetInformation(NULL, HeapEnableTerminationOnCorruption, NULL, 0);

  // 3. ACG (Arbitrary Code Guard) - block shellcode injection
  PROCESS_MITIGATION_DYNAMIC_CODE_POLICY dynamicCodePolicy = {};
  dynamicCodePolicy.ProhibitDynamicCode = 1;
  ::SetProcessMitigationPolicy(ProcessDynamicCodePolicy,
    &dynamicCodePolicy, sizeof(dynamicCodePolicy));

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

  ::CoUninitialize();
  return EXIT_SUCCESS;
}
