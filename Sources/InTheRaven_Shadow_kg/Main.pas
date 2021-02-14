unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,StrUtils;

type
  TMainForm = class(TForm)
    Generate: TButton;
    Key1: TEdit;
    Key2: TEdit;
    Key3: TEdit;
    Key4: TEdit;
    procedure GenerateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

function ShiftLeft(Value: LongWord): LongWord; register; overload;
asm
  shl eax,5
end;

procedure TMainForm.GenerateClick(Sender: TObject);
const
  SpecString='QETYFIWCOPASBNGHJZURKDLXVM1234567890';
var
  Crc:integer;
  i,current:integer;
  DepOnSym:integer;
  SymPos:integer;
  FirstPart,Step5,SecondPart,FullKey:string;
  Step1,Step2,Step3,Step35,Step4:integer;
begin
  SecondPart:='';
  current:=0;
  DepOnSym:=0;
  crc:=$001773D8;
  SymPos:=Random(36); //� ������� ������� ������ �� ����������� ������� ��� �������
  FirstPart:=Copy(SpecString,SymPos,1)+Copy(SpecString,SymPos,1)+Copy(SpecString,SymPos,1)+Copy(SpecString,SymPos,1);
//����� �� ���������� �� ������ �������� ��, ����� ����� ����� �������� � ���� 35
  if (Pos('M',FirstPart) <> 0) or (Pos('0',FirstPart) <> 0)
  or (Pos('5',FirstPart) <> 0) or (Pos('Q',FirstPart) <> 0)
  or (Pos('A',FirstPart) <> 0) or (Pos('I',FirstPart) <> 0)
  or (Pos('H',FirstPart) <> 0) or (Pos('K',FirstPart) <> 0) then
  begin
    DepOnSym:=0;
  end
  else
  if (Pos('1',FirstPart) <> 0) or (Pos('6',FirstPart) <> 0)
  or (Pos('E',FirstPart) <> 0) or (Pos('W',FirstPart) <> 0)
  or (Pos('S',FirstPart) <> 0) or (Pos('J',FirstPart) <> 0)
  or (Pos('D',FirstPart) <> 0) then
  begin
    DepOnSym:=1;
  end
  else
  if (Pos('2',FirstPart) <> 0) or (Pos('7',FirstPart) <> 0)
  or (Pos('T',FirstPart) <> 0) or (Pos('C',FirstPart) <> 0)
  or (Pos('Z',FirstPart) <> 0) or (Pos('B',FirstPart) <> 0)
  or (Pos('L',FirstPart) <> 0) then
  begin
    DepOnSym:=2;
  end
  else
  if (Pos('3',FirstPart) <> 0) or (Pos('8',FirstPart) <> 0)
  or (Pos('Y',FirstPart) <> 0) or (Pos('O',FirstPart) <> 0)
  or (Pos('N',FirstPart) <> 0) or (Pos('U',FirstPart) <> 0)
  or (Pos('X',FirstPart) <> 0) then
  begin
    DepOnSym:=3;
  end
  else
  if (Pos('4',FirstPart) <> 0) or (Pos('9',FirstPart) <> 0)
  or (Pos('F',FirstPart) <> 0) or (Pos('P',FirstPart) <> 0)
  or (Pos('G',FirstPart) <> 0) or (Pos('R',FirstPart) <> 0)
  or (Pos('V',FirstPart) <> 0) then
  begin
    DepOnSym:=4;
  end;
 /////////////////////////////////////////////////////////////////////////////
  inc(crc,Sympos);
  for i := 0 to 11 do
  begin
    inc(current); //�������� � ������� (������ ������) �������
    Step1:=current+crc; //���������� � ���� crc �� ������ 4��
    Step2:=ShiftLeft(Step1); //��������
    Step3:=Step1+Step2; //��������� ���������� ����������
    Step35:=Step3-DepOnSym;
    Step4:=Step35 mod 36; //����� �� ���-�� �������� � SpecString � �������� �������
    Step5:=Copy(SpecString,Step4+1,1); //��������� ������ ������
    SecondPart:=SecondPart+Step5; //�������� ������ �����
  end;
  //� ����� ��, ����� ������� ����������� �������� ����
  if (Pos('1',FirstPart) <> 0) or (Pos('6',FirstPart) <> 0)
  or (Pos('E',FirstPart) <> 0) or (Pos('W',FirstPart) <> 0)
  or (Pos('S',FirstPart) <> 0) or (Pos('J',FirstPart) <> 0)
  or (Pos('D',FirstPart) <> 0) then
  begin
    FullKey:= FirstPart+Copy(SecondPart,12,1)+Copy(SecondPart,10,1)
    +Copy(SecondPart,8,1)+Copy(SecondPart,6,1)+Copy(SecondPart,4,1)
    +ReverseString(Copy(SecondPart,1,2))+Copy(SecondPart,3,1)
    +Copy(SecondPart,5,1)+Copy(SecondPart,7,1)+Copy(SecondPart,9,1)
    +Copy(SecondPart,11,1)
  end
  else
  if (Pos('3',FirstPart) <> 0) or (Pos('8',FirstPart) <> 0)
  or (Pos('Y',FirstPart) <> 0) or (Pos('O',FirstPart) <> 0)
  or (Pos('N',FirstPart) <> 0) or (Pos('U',FirstPart) <> 0)
  or (Pos('X',FirstPart) <> 0) then
  begin
    FullKey:=FirstPart+ReverseString(Copy(SecondPart,10,3))+ReverseString(Copy(SecondPart,6,3))
    +ReverseString(Copy(SecondPart,3,2))+ReverseString(Copy(SecondPart,1,2))
    +Copy(SecondPart,5,1)+Copy(SecondPart,9,1)
  end
  else
  begin
    FullKey:=FirstPart+ReverseString(SecondPart);
  end;
  Key1.text:=Copy(FullKey,1,4);
  Key2.text:=Copy(FullKey,5,4);
  Key3.text:=Copy(FullKey,9,4);
  Key4.text:=Copy(FullKey,13,4);
end;

end.
