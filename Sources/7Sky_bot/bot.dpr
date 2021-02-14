program bot;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  Settings in 'Settings.pas' {SettingsForm},
  Chat in 'Chat.pas' {ChatWindow};

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.CreateForm(TChatWindow, ChatWindow);
  Application.Run;
  ReportMemoryLeaksOnShutdown:=True;
end.
