; ICD360S e.V. Mitglieder - Windows installer (Inno Setup 6)
;
; Compiled by .github/workflows/build-extras-platforms.yml with
;   ISCC.exe /DAppVersion="x.y.z" windows\installer.iss
;
; Two things this script guarantees beyond a plain Flutter bundle:
;   1. The Visual C++ runtime is always present. The build ships the MSVC CRT
;      DLLs app-local (see windows/CMakeLists.txt) AND this installer carries
;      vc_redist.x64.exe to repair the system-wide runtime when it is missing.
;   2. Unattended updates work. The app downloads this same EXE and runs it
;      with /VERYSILENT; the installer then closes the running app, upgrades
;      in place and relaunches it without any user interaction.

#define MyAppName "MitgliederPortal - ICD360S e.V"
#define MyAppExeName "icd360sev_mitglied.exe"
#define MyAppPublisher "ICD360S e.V."
#define MyAppURL "https://icd360s.de"
; Path is relative to this .iss file; CI drops the redist here before ISCC runs.
#define RedistFile "redist\vc_redist.x64.exe"
#define HaveRedist FileExists(AddBackslash(SourcePath) + RedistFile)

#ifndef AppVersion
  #define AppVersion "0.0.0"
#endif

[Setup]
; AppId ist auf den Namen festgenagelt, unter dem frueher installiert wurde.
; Inno leitet daraus den Deinstallations-Eintrag ab: waendert die Id mit dem
; Anzeigenamen, verliert jede bestehende Installation ihren Eintrag und ein
; Update installiert daneben statt darueber. Der Wert bleibt deshalb auf dem
; ALTEN Namen stehen, auch wenn die App jetzt anders heisst.
AppId=ICD360S e.V. Mitglieder
AppName={#MyAppName}
AppVersion={#AppVersion}
AppVerName={#MyAppName} {#AppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL=https://github.com/ICD360S-e-V/mitglieder/releases/latest
DefaultDirName={autopf}\MitgliederPortal
DefaultGroupName=MitgliederPortal - ICD360S e.V
DisableProgramGroupPage=yes
OutputDir=..
OutputBaseFilename=icd360sev_setup
SetupIconFile=runner\resources\app_icon.ico
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
ShowLanguageDialog=auto

; Windows 10 and 11, all builds. Flutter's Windows embedder does not run on
; anything older, and without this those machines install successfully and then
; fail at launch with an unreadable error instead of being told up front.
MinVersion=10.0
ArchitecturesInstallIn64BitMode=x64compatible
ArchitecturesAllowed=x64compatible

; Per-user install (%LocalAppData%\Programs). This is what makes unattended
; updates possible at all: no elevation means no UAC prompt to block a silent
; /VERYSILENT run started by the app itself.
PrivilegesRequired=lowest

; Restart Manager closes the running app so its files can be replaced; we
; relaunch it ourselves in [Run] rather than letting RM do it, because RM would
; restore it before the post-install steps finish.
CloseApplications=yes
RestartApplications=no
SetupMutex=ICD360SMitgliederSetupMutex

UninstallDisplayIcon={app}\{#MyAppExeName}
UninstallDisplayName={#MyAppName}

VersionInfoVersion={#AppVersion}
VersionInfoCompany={#MyAppPublisher}
VersionInfoDescription=MitgliederPortal - ICD360S e.V
VersionInfoProductName={#MyAppName}
VersionInfoProductVersion={#AppVersion}

[Languages]
; German first so it is what silent (auto-update) runs and non-German systems
; fall back to. `auto` keeps the language picker from appearing on machines
; whose system language already matches one of these.
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "..\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
#if HaveRedist
Source: "{#RedistFile}"; DestDir: "{tmp}"; Flags: deleteafterinstall; Check: VCRedistNeeded
#endif

[Icons]
Name: "{group}\ICD360S Mitglieder"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\Uninstall ICD360S Mitglieder"; Filename: "{uninstallexe}"
Name: "{autodesktop}\ICD360S Mitglieder"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Tasks]
Name: "desktopicon"; Description: "Desktop-Verknüpfung erstellen"; GroupDescription: "Zusätzliche Symbole:"

[Run]
#if HaveRedist
; System-wide VC++ runtime repair. The app itself does not need this (the CRT
; DLLs sit next to the EXE), so it is best-effort only: skipped when already
; present and skipped during silent auto-updates, where the UAC prompt that
; shellexec raises would defeat the point of an unattended install.
Filename: "{tmp}\vc_redist.x64.exe"; Parameters: "/install /passive /norestart"; StatusMsg: "Visual C++ Runtime wird installiert..."; Flags: shellexec waituntilterminated skipifsilent; Check: VCRedistNeeded
#endif

; Interactive install: offer to start the app.
Filename: "{app}\{#MyAppExeName}"; Description: "ICD360S Mitglieder starten"; Flags: nowait postinstall skipifsilent

; Silent install (auto-update path): relaunch without asking.
Filename: "{app}\{#MyAppExeName}"; Flags: nowait runasoriginaluser skipifnotsilent

[Code]
// True when the machine has no Visual C++ x64 redistributable at all, or one
// older than 14.30 (the VS 2022 RTM line).
//
// The whole 14.x family shares one registry key and one install slot - "2015",
// "2017", "2019", "2015-2022" and the current year-less "v14" branding are all
// the same runtime, binary compatible, newer replacing older. So this is a
// single version comparison, not one check per release.
//
// The threshold is deliberately NOT the version we bundle (14.51). The app
// never reads the system runtime - its CRT DLLs sit next to the EXE - so this
// exists only to repair machines that have nothing or something ancient.
// Raising it to 14.51 would fire a UAC prompt on every machine carrying a
// perfectly serviceable 14.4x, buying nothing.
//
// Reading from the 64-bit view explicitly: the installer process is 32-bit, so
// an unqualified HKLM read would land in Wow6432Node and always report
// "missing".
function VCRedistNeeded(): Boolean;
var
  Installed, Major, Minor: Cardinal;
begin
  Result := True;
  if not RegQueryDWordValue(HKLM64,
      'SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64', 'Installed', Installed) then
    Exit;
  if Installed <> 1 then
    Exit;
  if not RegQueryDWordValue(HKLM64,
      'SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64', 'Major', Major) then
    Exit;
  if not RegQueryDWordValue(HKLM64,
      'SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64', 'Minor', Minor) then
    Minor := 0;
  Result := (Major < 14) or ((Major = 14) and (Minor < 30));
end;

// Restart Manager handles the common case, but it only sees processes that
// hold a file open under {app}. A first-run app that has not touched its own
// directory yet, or one started from a stale copy, slips through and makes the
// file replacement fail with error 5 — the classic "update did nothing".
procedure StopRunningApp();
var
  ResultCode: Integer;
begin
  if Exec(ExpandConstant('{sys}\taskkill.exe'), '/F /IM {#MyAppExeName}', '',
          SW_HIDE, ewWaitUntilTerminated, ResultCode) then
    Sleep(800);
end;

function InitializeSetup(): Boolean;
begin
  StopRunningApp();
  Result := True;
end;

function InitializeUninstall(): Boolean;
begin
  StopRunningApp();
  Result := True;
end;
