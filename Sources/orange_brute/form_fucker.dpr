program form_fucker;

uses
  Forms,
  Config in 'Config.pas' {Form2},
  Logs in 'Logs.pas' {Form3},
  ABOUT in 'ABOUT.pas' {AboutBox},
  Network in 'Network.pas' {Form4},
  Main in 'Main.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Form fucker [private edition]';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TForm4, Form4);
  Application.Run;

end.
