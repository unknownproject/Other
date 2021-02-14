program the.pun.up.trn;

uses
  Forms,
  Main in 'Main.pas' {ThePunisher},
  ABOUT in 'ABOUT.pas' {AboutBox},
  train_lib in 'train_lib.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'The Punisher v.1.0 +20 Trainer';
  Application.CreateForm(TThePunisher, ThePunisher);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
