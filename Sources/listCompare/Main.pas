unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Clipbrd,StrUtils;

type
  TMainForm = class(TForm)
    Lst: TLabel;
    Load1: TButton;
    Load2: TButton;
    Compare: TButton;
    Lst1: TEdit;
    lst2: TEdit;
    Current: TMemo;
    Blacklist: TMemo;
    Result: TMemo;
    Sort: TButton;
    DuplicateKill: TButton;
    RsltName: TEdit;
    SaveResult: TButton;
    procedure Load1Click(Sender: TObject);
    procedure Load2Click(Sender: TObject);
    procedure CompareClick(Sender: TObject);
    procedure DuplicateKillClick(Sender: TObject);
    procedure SortClick(Sender: TObject);
    procedure SaveResultClick(Sender: TObject);
  private
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}



procedure TMainForm.Load1Click(Sender: TObject);
begin
Application.ProcessMessages;
Current.Lines.LoadFromFile(ExtractFilePath(Application.ExeName)+''+lst1.text+'');
end;

procedure TMainForm.Load2Click(Sender: TObject);
begin
Application.ProcessMessages;
Blacklist.Lines.LoadFromFile(ExtractFilePath(Application.ExeName)+''+lst2.text+'');
end;

procedure TMainForm.SaveResultClick(Sender: TObject);
begin
Application.ProcessMessages;
Result.Lines.SaveToFile(ExtractFilePath(Application.ExeName)+''+RsltName.text+'');
ShowMessage('Result has been saved to file '+RsltName.text+'');
end;

procedure TMainForm.SortClick(Sender: TObject);
var
  t: TStringList;
begin

if Result.Lines.Count = 0 then
begin
ShowMessage('Are you idiot ?');
exit;
end;

  // �������
  t:=TStringList.Create;
  // ����������� ���������� t ������ �� Memo
  t.AddStrings(Result.lines);
  // ���������
  t.Sort;
  Result.Clear;
  // ����������� memo ��� ��������������� ������
  Result.Lines.AddStrings(t);
end;

procedure TMainForm.DuplicateKillClick(Sender: TObject);
var i,j:integer;
begin
if Result.Lines.Count = 0 then
begin
ShowMessage('Whatta fuck are you doing ?');
exit;
end;
For i:=Result.Lines.Count-1 downto 0 do
For j:=i-1 downto 0 do
If Result.Lines[i]=Result.Lines[j] then
Result.Lines.Delete(i);
end;

procedure TMainForm.CompareClick(Sender: TObject);
var
  S : String;
  i, j : Integer;
begin
//
if (Current.Lines.Count = 0) or (Blacklist.Lines.Count = 0) then
begin
ShowMessage('Nothing to compare');
exit;
end;
//
MainForm.lst1.Enabled:=False;
MainForm.lst2.Enabled:=False;
MainForm.RsltName.Enabled:=False;
MainForm.Load1.Enabled:=False;
MainForm.Load2.Enabled:=False;
MainForm.SaveResult.Enabled:=False;
MainForm.Compare.Enabled:=False;
MainForm.DuplicateKill.Enabled:=False;
MainForm.Sort.Enabled:=False;
//
begin
Application.ProcessMessages;
  Result.Clear;
  S := Current.text; //�����, � ������� ����� ��������� �����.
  for i := 0 to Blacklist.Lines.Count - 1 do //������� ���� ��������, ������� ���� ����� � S.
  begin
    j := 1; //��������� ������� ������.
    repeat
      //������� � ������� ������� ���������� ����� ���������.
      j := PosEx(Blacklist.Lines[i], S, j);
      //���� ��������� �������.
      if j > 0 then
      begin
        //��������� � Memo3 �������� � �������, �� ������� ������� ���������
        //� ���� ��� ���������.
        //Result.Lines.Add('Position ' + IntToStr(j) + ': ' + Blacklist.Lines[i]);
        Result.Lines.Add(''+ Blacklist.Lines[i]+'');
        //"�������������" ����� ��������� ���������. ��� ����, ����� �� ���������
        //�������� ���������� ����� ������ �� ��������� ���������.
        Inc(j, Length(Blacklist.Lines[i]));
      end;
    until j = 0; //���� ��������� �� �������, �� ������� �� �����.
  end;
end;
//
MainForm.lst1.Enabled:=true;
MainForm.lst2.Enabled:=true;
MainForm.RsltName.Enabled:=true;
MainForm.Load1.Enabled:=true;
MainForm.Load2.Enabled:=true;
MainForm.SaveResult.Enabled:=true;
MainForm.Compare.Enabled:=true;
MainForm.DuplicateKill.Enabled:=true;
MainForm.Sort.Enabled:=true;
//
end;

end.
