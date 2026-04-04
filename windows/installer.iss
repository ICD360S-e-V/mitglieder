[Setup]
AppName=ICD360S e.V. Mitglieder
AppVersion={#AppVersion}
AppPublisher=ICD360S e.V.
AppPublisherURL=https://icd360s.de
DefaultDirName={autopf}\ICD360S Mitglieder
DefaultGroupName=ICD360S Mitglieder
OutputDir=..
OutputBaseFilename=icd360sev_setup
Compression=lzma2
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64compatible
UninstallDisplayIcon={app}\icd360sev_mitglied.exe
PrivilegesRequired=lowest

[Files]
Source: "..\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs

[Icons]
Name: "{group}\ICD360S Mitglieder"; Filename: "{app}\icd360sev_mitglied.exe"
Name: "{group}\Uninstall ICD360S Mitglieder"; Filename: "{uninstallexe}"
Name: "{autodesktop}\ICD360S Mitglieder"; Filename: "{app}\icd360sev_mitglied.exe"; Tasks: desktopicon

[Tasks]
Name: "desktopicon"; Description: "Desktop-Verknüpfung erstellen"; GroupDescription: "Zusätzliche Symbole:"

[Run]
Filename: "{app}\icd360sev_mitglied.exe"; Description: "ICD360S Mitglieder starten"; Flags: nowait postinstall skipifsilent
