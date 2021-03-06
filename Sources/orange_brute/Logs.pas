unit Logs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RbDrawCore, RbButton, ComCtrls;

type
  TForm3 = class(TForm)
    Memo1: TMemo;
    SaveBtn: TRbButton;
    ClearBtn: TRbButton;
    SaveDialog1: TSaveDialog;
    procedure SaveBtnClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.ClearBtnClick(Sender: TObject);
begin
Memo1.Lines.Clear;
end;

procedure TForm3.SaveBtnClick(Sender: TObject);
begin
  SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName);
  SaveDialog1.Filter := 'Text files (*.txt)|*.txt';
  if SaveDialog1.Execute then
 Memo1.Lines.SaveToFile(''+SaveDialog1.FileName+'');
end;

end.
