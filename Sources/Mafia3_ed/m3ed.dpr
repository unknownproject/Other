program m3ed;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  crc32 in 'crc32.pas',
  HTU in 'HTU.pas' {HTUForm},
  About in 'About.pas' {AboutForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Mafia 3 SaveGame Editor';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(THTUForm, HTUForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
