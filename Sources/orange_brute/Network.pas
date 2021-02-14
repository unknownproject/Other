unit Network;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm4 = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    UpDown1: TUpDown;
    TimeOut: TGroupBox;
    Edit3: TEdit;
    Edit4: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    OpenDialog1: TOpenDialog;
    procedure Edit1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses Main;

{$R *.dfm}

procedure TForm4.Edit1Click(Sender: TObject);
begin
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);
  OpenDialog1.Filter := 'Text files (*.txt)|*.txt|All files (*.*)|*.*';
  if OpenDialog1.Execute then
  begin
    Proxy.Clear;
    Proxy.LoadFromFile(OpenDialog1.FileName);
    Edit1.text := OpenDialog1.FileName;
  end;
end;

end.
