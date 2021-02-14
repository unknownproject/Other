unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, umd5, ExtCtrls, jpeg, Buttons;

type
  TKgnForm = class(TForm)
    RegNumberEdit: TEdit;
    NameEdit: TEdit;
    TrialCodeEdit: TEdit;
    UnlockCodeEdit: TEdit;
    TrialReset: TLabel;
    UnlockCode: TLabel;
    RegNumber: TLabel;
    Name: TLabel;
    BackGrnd: TImage;
    procedure NameEditChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  KgnForm: TKgnForm;
const
  value = '25745-byjimminy-582552';
  value2 = '5821354-cadizzaboom-48548';
implementation

{$R *.dfm}

procedure TKgnForm.NameEditChange(Sender: TObject);
var
  Concat,Md5hash,trim,split,Concat2,Md5hash2,trim2,split2:string;
begin
  TrialCodeEdit.text:='';
  UnlockCodeEdit.text:='';
  if (length(RegNumberEdit.text) = 12) and (length(NameEdit.text) >= 3)
then
  begin
///////Trial reset generator//////////
    Concat:=RegNumberEdit.Text+NameEdit.Text+value; //������������ ������ ������ �� ��������� ������, ����� � ���������
    Md5hash:=md5(Concat); //�������� �� ��� md5 ���
    Trim:=AnsiUpperCase(Copy(Md5hash, 1,19)+(Copy(Md5hash, 32,1))); //��������� �� ���� ������ ������ 20 �������� = 19 � ������ + 1 � ����� � �������� � ������� �������
    Split:=Copy(Trim,1,4)+'-'+Copy(Trim,5,4)+'-'+Copy(Trim,9,4)+'-'+Copy(Trim,13,4)+'-'+Copy(Trim,17,4); //��������� ������ �� ����� � �������� ����� ������ 4 �������
    TrialCodeEdit.Text:=split; //TrialCodeEdit �������� �������� ���� ��� ������ ������
///////Trial reset generator//////////

///////Unlock code generator//////////
    Concat2:=RegNumberEdit.Text+NameEdit.Text+value2;
    Md5hash2:=md5(Concat2);
    Trim2:=AnsiUpperCase(Copy(Md5hash2, 1,19)+(Copy(Md5hash2, 32,1)));
    Split2:=Copy(Trim2,1,4)+'-'+Copy(Trim2,5,4)+'-'+Copy(Trim2,9,4)+'-'+Copy(Trim2,13,4)+'-'+Copy(Trim2,17,4);
    UnlockCodeEdit.Text:=split2;
///////Unlock code generator//////////
  end
  else
    exit;
end;
end.
