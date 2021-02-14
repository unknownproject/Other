unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TMainForm = class(TForm)
    Page: TPageControl;
    Flooder1: TTabSheet;
    PNLabel: TLabel;
    RNLabel: TLabel;
    PN: TEdit;
    RN: TEdit;
    GenerateBtn: TButton;
    Checker: TTabSheet;
    SN: TEdit;
    GenerateBtn2: TButton;
    SNLabel: TLabel;
    Flooder2: TTabSheet;
    RegInfo: TMemo;
    PatchBtn: TButton;
    OpenDialog1: TOpenDialog;
    function StrToHex(source: string): string;
    function HexToStr(hex: string): string;
    function dec2hex(dec: longint): string;
    function hex2dec(hex: string): longint;
    procedure GenerateBtnClick(Sender: TObject);
    procedure GenerateBtn2Click(Sender: TObject);
    procedure PatchBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  SerialNum: DWORD;
  a,b: DWORD;
  Buffer:Array [0..255] of char;

implementation

{$R *.dfm}

function TMainForm.StrToHex(source: string): string;
var
  i: Integer;
  c: Char;
  s: string;
begin
  s := '';
  for i:=1 to Length(source) do begin
    c := source[i];
    s := s +  IntToHex(Integer(c), 2) + '';
  end;
  result := s;
end;
 
function TMainForm.HexToStr(hex: string): string;
var
  i: Integer;
begin
  hex:= StringReplace(hex, '', '', [rfReplaceAll]);
  for i:= 1 to Length(hex) div 2 do
    Result:= Result + Char(StrToInt('$' + Copy(hex, (i-1) * 2 + 1, 2)));
end;

function TMainForm.dec2hex(dec: longint): string;
const
hexdigts: string[16] = '0123456789ABCDEF';
var
hex : string;
i, j: longint;
begin
if dec = 0 then hex := '0'
else
begin
hex := '';
i := 0;
while (1 shl ((i + 1) * 4)) <=dec do i := i + 1;
{ 16^n = 2^(n * 4) }
{ (1 shl ((i + 1) * 4)) = 16^(i + 1) }
for j := 0 to i do
begin
hex := hex + hexdigts[(dec shr ((i - j) * 4)) + 1];
{ (dec shr ((i - j) * 4)) = dec div 16^(i - j) }
dec := dec and ((1 shl ((i - j) * 4)) - 1);
{ dec and ((1 shl ((i - j) * 4)) - 1) = dec mod 16^(i - j) }
end;
end;
dec2hex := hex;
end;

function TMainForm.hex2dec(hex: string): longint;
function digt(ch: char): byte;
const
hexdigts: string[16] = '0123456789ABCDEF';
var
i: byte;
n: byte;
begin
n := 0;
for i := 1 to length(hexdigts) do
if ch = hexdigts[i] then n := i - 1;
digt := n;
end;
const
hexset: set of char = ['0'..'9', 'A'..'F'];
var
j    : longint;
error: boolean;
dec  : longint;
begin
dec := 0;
error := false;
for j := 1 to length(hex) do
begin
if not (upcase(hex[j]) in hexset) then error := true;
dec := dec + digt(upcase(hex[j])) shl ((length(hex) - j) * 4);
{ 16^n = 2^(n * 4) }
{ n shl ((length(hex) - j) * 4) = n * 16^(length(hex) - j) }
end;
if error then hex2dec := 0
else hex2dec := dec;
end;

procedure TMainForm.PatchBtnClick(Sender: TObject);
var
Division:Char;
MainProgrammFile:File of Byte;
File_size: longint;
begin
if OpenDialog1.Execute then
Assignfile(MainProgrammFile,'ICQ Flooder.exe');
Reset(MainProgrammFile);

Seek(MainProgrammFile,$000744A7);
BlockRead(MainProgrammFile,Division,1);
If Division=Char($90)
then
begin
ShowMessage('File already patched');
Closefile(MainProgrammFile);
exit;
end
else

CopyFile('ICQ Flooder.exe','ICQ Flooder.exe.bak', true ); //создаем резервную копию файла, который будем патчить
   Seek(MainProgrammFile,$000744A6); //ищем в программе нужное смещение
   Division:=Char($90); //задаем то, на что будем менять байт по этому смещению [NOP]
   Blockwrite(MainProgrammFile,Division,1); //применяем изменения
   Seek(MainProgrammFile,$000744A7);
   Division:=Char($90);
   Blockwrite(MainProgrammFile,Division,1);
Closefile(MainProgrammFile); //закрываем файл и сохраняем изменения
ShowMessage('Done');
end;

procedure TMainForm.GenerateBtn2Click(Sender: TObject);
begin

{Узнаем информацию о томе через функцию GetVolumeInformation.
Берем только серийный номер тома и переводим в hex + нуль байт, т.к. сама прога
добавляет его для соответствия длине = 10 символам.
$TNKSC4R и X5TYYR$JI - константы.
Если кому-то интересна работа вышеописанной функции - чтите гугл.}

GetVolumeInformation(Pchar('C:\'), Buffer, sizeof(Buffer), @SerialNum, a, b, nil, 0);
Sn.Text:='$TNKSC4R'+IntToHex(SerialNum,10)+'X5TYYR$JI';

end;

procedure TMainForm.GenerateBtnClick(Sender: TObject);
var
HexValue:string; //Определим строчную переменную, в которую сохраним наш персональный номер
Value1,Value2,Value3,Value4,Value5:integer; //В десятичном виде будет намного проще работать
Value6,Value7,Value8,Value9,Value10:integer;
Value11,Value12,Value13,Value14,Value15:integer;
Value16,Value17,Value18,Value19,Value20:integer;
Value21,Value22,Value23,Value24,Value25:integer;
Value26,Value27,Value28,Value29,Value30:integer;
begin

If length(Pn.text) < 30  //банальная защита от дурака
then
begin
ShowMessage('Wrong personal number');
exit;
end;

HexValue:=StrTohex(PN.text); //Преставили персональный номер в HEX

{Разбиение неоходимо, т.к. в конечной программе каждый символ обрабатывается отдельно
Для удобства я не стал лепить в кучу все 30 частей рег.номера, а разбил их на блоки по 5
Стоит заметить, что пройдя первый этап генерации программа сбрасывает индекс и
переходит к следующей пятерке, т.е. для нее каждый шестой символ будет являться первым,
соответственно и алгоритмы обработки каждого из пяти этих символов будут теми же, что и были ранее}

//Первая часть ключа//
Value1:=Hex2Dec(Copy(HexValue,1,2)); //Скопировали из полученной выше строки первые два символа (байт) и перевели в десятичный вид
Inc(Value1); //увеличили на единицу и получили таким образом первый символ рег.номера в десятичном виде
Value2:=Hex2Dec(Copy(HexValue,3,2)); //Аналогично, только взяли следующие два символа
Inc(Value2,2); //увеличили на два
Value3:=Hex2Dec(Copy(HexValue,5,2));
Inc(Value3,3); //увеличили на три
Value4:=Hex2Dec(Copy(HexValue,7,2));
Dec(Value4); //уменьшили на единицу
Value5:=Hex2Dec(Copy(HexValue,9,2));
Dec(Value5,2); //уменьшили на два
//Конец генерации первой части//

//Вторая часть ключа//
Value6:=Hex2Dec(Copy(HexValue,11,2));
Inc(Value6);
Value7:=Hex2Dec(Copy(HexValue,13,2));
Inc(Value7,2);
Value8:=Hex2Dec(Copy(HexValue,15,2));
Inc(Value8,3);
Value9:=Hex2Dec(Copy(HexValue,17,2));
Dec(Value9);
Value10:=Hex2Dec(Copy(HexValue,19,2));
Dec(Value10,2);
//Конец генерации второй части//

//Третья часть ключа//
Value11:=Hex2Dec(Copy(HexValue,21,2));
Inc(Value11);
Value12:=Hex2Dec(Copy(HexValue,23,2));
Inc(Value12,2);
Value13:=Hex2Dec(Copy(HexValue,25,2));
Inc(Value13,3);
Value14:=Hex2Dec(Copy(HexValue,27,2));
Dec(Value14);
Value15:=Hex2Dec(Copy(HexValue,29,2));
Dec(Value15,2);
//Конец генерации третьей части//

//Четвертая часть ключа//
Value16:=Hex2Dec(Copy(HexValue,31,2));
Inc(Value16);
Value17:=Hex2Dec(Copy(HexValue,33,2));
Inc(Value17,2);
Value18:=Hex2Dec(Copy(HexValue,35,2));
Inc(Value18,3);
Value19:=Hex2Dec(Copy(HexValue,37,2));
Dec(Value19);
Value20:=Hex2Dec(Copy(HexValue,39,2));
Dec(Value20,2);
//Конец генерации четвертой части//

//Пятая часть ключа//
Value21:=Hex2Dec(Copy(HexValue,41,2));
Inc(Value21);
Value22:=Hex2Dec(Copy(HexValue,43,2));
Inc(Value22,2);
Value23:=Hex2Dec(Copy(HexValue,45,2));
Inc(Value23,3);
Value24:=Hex2Dec(Copy(HexValue,47,2));
Dec(Value24);
Value25:=Hex2Dec(Copy(HexValue,49,2));
Dec(Value25,2);
//Конец генерации пятой части//

//Шестая часть ключа//
Value26:=Hex2Dec(Copy(HexValue,51,2));
Inc(Value26);
Value27:=Hex2Dec(Copy(HexValue,53,2));
Inc(Value27,2);
Value28:=Hex2Dec(Copy(HexValue,55,2));
Inc(Value28,3);
Value29:=Hex2Dec(Copy(HexValue,57,2));
Dec(Value29);
Value30:=Hex2Dec(Copy(HexValue,59,2));
Dec(Value30,2);
//Конец генерации шестой части//

RN.text:=HexToStr(Dec2Hex(Value1)
+(Dec2Hex(Value2)
+(Dec2Hex(Value3)
+(Dec2Hex(Value4)
+(Dec2Hex(Value5)
+(Dec2Hex(Value6)
+(Dec2Hex(Value7)
+(Dec2Hex(Value8)
+(Dec2Hex(Value9)
+(Dec2Hex(Value10)
+(Dec2Hex(Value11)
+(Dec2Hex(Value12)
+(Dec2Hex(Value13)
+(Dec2Hex(Value14)
+(Dec2Hex(Value15)
+(Dec2Hex(Value16)
+(Dec2Hex(Value17)
+(Dec2Hex(Value18)
+(Dec2Hex(Value19)
+(Dec2Hex(Value20)
+(Dec2Hex(Value21)
+(Dec2Hex(Value22)
+(Dec2Hex(Value23)
+(Dec2Hex(Value24)
+(Dec2Hex(Value25)
+(Dec2Hex(Value26)
+(Dec2Hex(Value27)
+(Dec2Hex(Value28)
+(Dec2Hex(Value29)
+(Dec2Hex(Value30)
)))))))))))))))))))))))))))))); //Собираем воедино и переводим куски рег.номера из десятичной в шестнадцатеричную форму и приводим к строчному типу
end;

end.
