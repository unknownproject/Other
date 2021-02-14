unit Generator;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,umd5;

type
  TGeneratorForm = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GeneratorForm: TGeneratorForm;

implementation

{$R *.dfm}

procedure TGeneratorForm.Button1Click(Sender: TObject);
const
  PackType='send_chat_message';
  Salt='bkavjV3jjbjavj_dvVHDhz2';
var
  hash,sign,text:string;
begin
  text:='{"message":"test","to_player_id":0}';
  //hash:=md5('send_chat_message'+'bkavjV3jjbjavj_dvVHDhz2'+text);
  Edit2.Text:=hash;
  sign:=Copy(hash,4,3);
  Edit3.text:=Sign+'/'+PackType+'/2?'+Text+'?'
end;

end.
