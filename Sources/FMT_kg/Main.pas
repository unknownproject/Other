unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TMainForm = class(TForm)
    Key: TEdit;
    Gen: TButton;
    Timer1: TTimer;
    procedure GenClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.GenClick(Sender: TObject);
begin
  Timer1.Enabled:=True;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
const
  init = $56F19ABC;
  sub = $41;
  fnl = $12AE5B61;
var
  i,Position,Shift,Result,FinalResult: integer;
  RandomValue,PT:string;
begin
  Timer1.Interval:=10;
  Position:=0; //�������� � ������� �������;
  Result:=0;
  Shift:=0;
  Randomize;
  RandomValue:=IntToStr(Random(9))+IntToStr(Random(9))+IntToStr(Random(9))+IntToStr(Random(9))
  +IntToStr(Random(9))+IntToStr(Random(9))+IntToStr(Random(9))+IntToStr(Random(9))
  +IntToStr(Random(9))+IntToStr(Random(9))+IntToStr(Random(9))+IntToStr(Random(9))
  +IntToStr(Random(9))+IntToStr(Random(9))+IntToStr(Random(9))+IntToStr(Random(9)); //���������� ������
  Key.Text:=RandomValue;
  for i := 0 to 15 do //���� ���������� ����� 16 ��� = ���-�� �������� � ���������
  begin
    Shift := init shl 1;
    PT := Copy(RandomValue, Position, 1);
    Result := StrToInt(PT) - sub;
    Result := Result * Shift;
    FinalResult := Result xor StrToInt(PT);
    inc(Position);
  end;
  if FinalResult = fnl then
  begin
    ShowMessage(RandomValue);
    Timer1.Enabled:=False;
  end;
end;

end.
