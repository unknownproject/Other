unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,winsock, ExtCtrls, Menus,Settings, Sockets, umd5, uJSON;

type
  TMainForm = class(TForm)
    Log: TMemo;
    LocalTimer: TTimer;
    GameTimer: TTimer;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    Settings1: TMenuItem;
    Action1: TMenuItem;
    Start1: TMenuItem;
    Stop1: TMenuItem;
    BoxOne: TGroupBox;
    Time: TLabel;
    Exit1: TMenuItem;
    PlayedLabel: TLabel;
    Played: TLabel;
    TcpClient: TTcpClient;
    Connection1: TMenuItem;
    Connect1: TMenuItem;
    Authorize1: TMenuItem;
    Disconnect1: TMenuItem;
    Flood1: TMenuItem;
    Start2: TMenuItem;
    Stop2: TMenuItem;
    FloodTimer: TTimer;
    Debug: TMemo;
    N2: TMenuItem;
    Bonus1: TMenuItem;
    Clearlogs1: TMenuItem;
    ArrowLabel: TLabel;
    MutualLabel: TLabel;
    Mutual: TLabel;
    OpenDialog1: TOpenDialog;
    TestMessage: TMemo;
    Button1: TButton;
    TotalOnline: TMemo;
    Chat1: TMenuItem;
    Start3: TMenuItem;
    Stop3: TMenuItem;
    ChatTimer: TTimer;
    Show: TMenuItem;
    Button2: TButton;
    Edit1: TEdit;
    Button3: TButton;
    procedure CurrentLocalTimeTimer(Sender: TObject);
    procedure LocalTimerTimer(Sender: TObject);
    procedure Start1Click(Sender: TObject);
    procedure Stop1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Settings1Click(Sender: TObject);
    procedure Connect1Click(Sender: TObject);
    procedure Authorize1Click(Sender: TObject);
    procedure Disconnect1Click(Sender: TObject);
    procedure Start2Click(Sender: TObject);
    procedure Stop2Click(Sender: TObject);
    procedure FloodTimerTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TcpClientReceive(Sender: TObject; Buf: PAnsiChar;
      var DataLen: Integer);
    procedure Bonus1Click(Sender: TObject);
    procedure Clearlogs1Click(Sender: TObject);
    procedure Start3Click(Sender: TObject);
    procedure Stop3Click(Sender: TObject);
    procedure ShowClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  type
  BonusThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

const
  Salt='gV8b_df1FffAAzV0C0-ZGf~__+Gf##1333100';
  //Unix start time
  UnixStartDate: TDateTime = 25569.0;

var
  MainForm: TMainForm;
  current:_SYSTEMTIME;
  Resp:string;
  PackID,Online,Boys,girls:integer;
  Game:string;
  PickCopy,PickText,Sign,Selected,RateSign,RateText:string;
  PickResp,RateResp,Result:string;
  SecThread: BonusThread;
implementation

uses Chat;

{$R *.dfm} {$ASSERTIONS ON}
type
  TCharSet = set of Char;

function StripNonConforming(const S: string;
  const ValidChars: TCharSet): string;
var
  DestI: Integer;
  SourceI: Integer;
begin
  SetLength(Result, Length(S));
  DestI := 0;
  for SourceI := 1 to Length(S) do
    if S[SourceI] in ValidChars then
    begin
      Inc(DestI);
      Result[DestI] := S[SourceI]
    end;
  SetLength(Result, DestI)
end;

function StripNonNumeric(const S: string): string;
begin
  Result := StripNonConforming(S, ['0'..'9'])
end;


function HexToStr(hex: string): string;
var
  i: Integer;
begin
  hex:= StringReplace(hex, ' ', '', [rfReplaceAll]);
  for i:= 1 to Length(hex) div 2 do
    Result:= Result + Char(StrToInt('$' + Copy(hex, (i-1) * 2 + 1, 2)));
end;

function DateTimeToUnix(ConvDate: TDateTime): Longint;
 begin
   //example: DateTimeToUnix(now);
  Result := Round((ConvDate - UnixStartDate) * 86400);
 end;

 function UnixToDateTime(USec: Longint): TDateTime;
 begin
   //Example: UnixToDateTime(1003187418);
  Result := (Usec / 86400) + UnixStartDate;
 end;



procedure BonusThread.Execute;
var
  Bonus,BonusResp:string;
begin
  Inc(PackID);
  Bonus:='2cc/bonus/'+IntToStr(PackID)+HexToStr('E1BC81')+'{}'+HexToStr('E1BC80');
  //BonusTimer.Interval:=1000*60*60*24; //24 hours [86 400 000 msecs]
try
  //TcpClient.Active:=True;
  MainForm.TcpClient.Sendln(Bonus,'');
  while Pos('bonus_get',BonusResp) = 0 do
  begin
    MainForm.TcpClient.WaitForData(1000); //ожидаем ответ сервера
    BonusResp:=MainForm.TcpClient.Receiveln('');
  end;
  if Pos('bonus_get',BonusResp) <> 0 then
  begin
    MainForm.Debug.Lines.Add('---------------------------------------------------------------------------');
    MainForm.Debug.Lines.Add(Copy(BonusResp,Pos('bonus_get',BonusResp)-2,50)); //выводим
    MainForm.Debug.Lines.Add('---------------------------------------------------------------------------');
    MainForm.Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
    +IntToStr(current.wMinute)+':'
    +IntToStr(current.wSecond)+'] -'+' Bonus for you');
  end;
except
    MainForm.Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
    +IntToStr(current.wMinute)+':'
    +IntToStr(current.wSecond)+'] -'+' NO BONUS');
  MainForm.TcpClient.Active:=False;
end;
end;


procedure TMainForm.Exit1Click(Sender: TObject);
var
  ExitCode:cardinal;
begin
  TcpClient.Active:=False;
  ExitCode:=00000000;
  ExitProcess(ExitCode);
end;

procedure TMainForm.FloodTimerTimer(Sender: TObject);
var
  Flood,FloodEnd,Resp:string;

begin
{  Flood := '2dc/send_chat_message/'+IntToStr(PackID)+HexToStr('E1 BC 81 7B 22 6D 65 73 73'
          +'61 67 65 22 3A 22 57 41 52 4E 49 4E 47 3A 20 49 4D 41 47 45 43 52 45 41 54 45 46 52 4F 4D 4A 50'
          +'45 47 28 29 3A 20 47 44 2D 4A 50 45 47 3A 20 4A 50 45 47 20 4C 49 42 52 41 52 59 20 52 45 50 4F'
          +'52 54 53 20 55 4E 52 45 43 4F 56 45 52 41 42 4C 45 20 45 52 52 4F 52 3A 20 20 49 4E 20 2F 48 4F'
          +'4D 45 2F 41 4C 45 58 4E 4F 44 2F 50 48 50 2F 53 4B 59 2F 49 4D 41 47 45 2E 50 48 50 20 4F 4E 20'
          +'4C 49 4E 45 20 35 39 57 41 52 4E 49 4E 47 3A 20 49 4D 41 47 45 43 52 45 41 54 45 46 52 4F 4D 4A'
          +'50 45 47 28 29 3A 20 47 44 2D 4A 50 45 47 3A 20 4A 50 45 47 20 4C 49 42 52 41 52 59 20 52 45 50'
          +'4F 52 54 53 20 55 4E 52 45 43 4F 56 45 52 41 42 4C 45 20 45 52 52 4F 52 3A 20 20 49 4E 20 2F 48'
          +'4F 4D 45 2F 41 4C 45 58 4E 4F 44 2F 50 48 50 2F 53 4B 59 2F 49 4D 41 47 45 2E 50 48 50 20 4F 4E'
          +'20 4C 49 4E 45 20 22 2C 22 74 6F 5F 70 6C 61 79 65 72 5F 69 64 22 3A 30 7D E1 BC 80'); 
FloodTimer.Interval:=StrToInt(Trim(SettingsForm.FlooDInterval.text))*1000; }
inc(PackID);
Flood := '5bc/voip_call/'+IntToStr(PackID)+HexToStr('E1 BC 81 7B 22 70 6C 61 79 65 72 5F 69 64 22 3A 34 37 37 35 35 37 7D E1 BC 80');
try
  TcpClient.Sendln(Flood,'');
//  Tcpclient.WaitForData(1000);
  Resp:=Tcpclient.Receiveln();
  Debug.Lines.Add(Resp);
except
end;
inc(PackID);
FloodEnd := 'c7c/voip_break/'+IntToStr(PackID)+HexToStr('E1 BC 81 7B 22 70 6C 61 79 65 72 5F 69 64 22 3A 34 37 37 35 35 37 7D E1 BC 80');
try
  TcpClient.Sendln(FloodEnd,'');
//  Tcpclient.WaitForData(1000);
  Resp:=Tcpclient.Receiveln();
  Debug.Lines.Add(Resp);
except
end;
end;

procedure TMainForm.LocalTimerTimer(Sender: TObject);
begin
  Application.ProcessMessages;
  GetLocalTime(current); //берем текущее локальное время
  Time.Caption:=IntToStr(current.wHour)+':'+IntToStr(current.wMinute)+':'+IntToStr(current.wSecond); //отображаем в реальном времени
end;

procedure TMainForm.Settings1Click(Sender: TObject);
begin
  SettingsForm.Show;
end;

procedure TMainForm.ShowClick(Sender: TObject);
begin
  ChatWindow.Show;
end;

procedure TMainForm.Start1Click(Sender: TObject);
begin
  Played.Caption:='0';
  Mutual.Caption:='0';
  Start1.Enabled:=False;
  Stop1.Enabled:=True;
  Settings1.Enabled:=False;
  GameTimer.Enabled:=True;
end;

procedure TMainForm.Start2Click(Sender: TObject);
begin
  FloodTimer.Enabled:=True;
  Start2.Enabled:=False;
  Stop2.Enabled:=True;
end;

procedure TMainForm.Start3Click(Sender: TObject);
begin
  ChatWindow.ChatTimer.Enabled:=True;
  Log.Lines.Add('Chat logger ON');
end;

procedure TMainForm.Stop1Click(Sender: TObject);
var
  Exit,ExitResp:string;
begin
  GameTimer.Enabled:=False;
  Start1.Enabled:=True;
  Settings1.Enabled:=True;
  Stop1.Enabled:=False;
  inc(PackID);
  Exit:='afd/del_game_join/'+IntToStr(PackID)+HexToStr('E1BC81')+'{"type":"pick"}'+HexToStr('E1BC80');
try
  TcpClient.Active:=True;
  TcpClient.Sendln(Exit,'');
//while pos('callback',ExitResp) = 0  do
  repeat
//  begin
    Application.ProcessMessages;
//    TcpClient.WaitForData(1000); //ожидаем ответ сервера
    ExitResp:=TcpClient.Receiveln();
  until pos('callback',ExitResp) <> 0;
//  end;
//if pos('callback',ExitResp) <> 0 then
//begin
//end;
except
  Debug.Lines.Add('Error');
  TcpClient.Active:=False;
end;
  Debug.Lines.Add('-------------------------------------------------------------------');
  Debug.Lines.Add(Copy(ExitResp,pos('callback',ExitResp)-2,52)); //выводим
  Debug.Lines.Add('-------------------------------------------------------------------');
  Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
  +IntToStr(current.wMinute)+':'
  +IntToStr(current.wSecond)+'] -'+' Game was exited');
end;

procedure TMainForm.Stop2Click(Sender: TObject);
begin
  FloodTimer.Enabled:=False;
  Start2.Enabled:=True;
  Stop2.Enabled:=False;
end;

procedure TMainForm.Stop3Click(Sender: TObject);
begin
  ChatWindow.ChatTimer.Enabled:=False;
  Log.Lines.Add('Chat logger OFF');
end;

procedure TMainForm.TcpClientReceive(Sender: TObject; Buf: PAnsiChar;
  var DataLen: Integer);
begin
  if Pos('send_online',Resp) <> 0 then
  begin
    Boys:=StrToInt(StripNonNumeric(Copy(Resp,Pos('send_online',Resp)+31,3)));
    Girls:=StrToInt(StripNonNumeric(Copy(Resp,Pos('send_online',Resp)+39,3)));
    Online:=Boys+Girls;
//    Arrow.Caption:='Online: '+IntToStr(Online)+' [ Boys - '+IntToStr(Boys)+' : '+'Girls - '+IntToStr(Girls)+' ]';
    TotalOnline.Lines.Text:='Online: '+IntToStr(Online)+' [ Boys - '+IntToStr(Boys)+' : '+'Girls - '+IntToStr(Girls)+' ]';
  end;
 end;

procedure TMainForm.Authorize1Click(Sender: TObject);
//begin
//  Thread:=BotThread.Create(False);
//  Thread.Priority:=tpNormal;
//  Thread.FreeOnTerminate:=True;
const
  SecsPerMin=60;
  MinsPerHour=60;
  HoursPerDay=24;
var
//  MDiD,StartTime,EndTime:string;
//  SecsCount,MinsCount,HoursCount,DaysCount:integer;
  Auth,AuthResp:string;
begin
  Authorize1.Enabled:=False;
  Disconnect1.Enabled:=True;
  PackID:=1;
  AuthResp:='';
//Auth:='a55/auth/1'+HexToStr('E1BC81')+'{"mode":1,"social_id":"4321380","config_version":7,"sn":1,"key":"e8516f598cbaef0c728684a694e69c03","device":"/vhp8-6q1l/o:_8/","social_ref":"4321380"}'+HexToStr('E1BC80');
Auth:='e99/auth/1'+HexToStr('E1BC81')+'{"social_ref":"0","fake":0,"device":"g2R!VJ2a.B-FckPo","social_id":"4321380","sn":1,"key":"ffe7ab9f30a4cae26a188e8ca8f5ad89","mode":1,"config_version":48}'+HexToStr('E1BC80');

//  Auth:=HexToStr('6434632F617574682F31E1BC817B2266616B65223A302C22736F6369616C5F6964223A2234333231333830222C22736E223A312C22636F6E6669675F76657273696F6E223A32362C226B6579223A2265'
//  +'38353136663539386362616566306337323836383461363934653639633033222C22736F6369616C5F726566223A2230222C22646576696365223A222B777A746F787179376E726A63323534222C226D6F6465223A317DE1BC80');
//Fake with fixed fake param
{  Auth:=HexToStr('3537652F617574682F31E1BC817B226B6579223A2236'+
                  '31343731393466656464346139646633643334383434'+
                  '313561306666643335222C2266616B65223A302C2273'+
                  '6F6369616C5F6964223A223134323239383637222C22'+
                  '636F6E6669675F76657273696F6E223A33372C22736E'+
                  '223A312C22736F6369616C5F726566223A2231343232'+
                  '39383637222C226D6F6465223A312C22646576696365'+
                  '223A223A7A6339733672712E3561662F3D2D2F227DE1BC80'); }
//fake with empty machine
{Auth:=HexToStr('37 34 64 2F 61 75 74 68 2F 31 E1 BC 81 7B 22 6B 65 79 22 3A 22 36'+
               '31 34 37 31 39 34 66 65 64 64 34 61 39 64 66 33 64 33 34 38 34 34'+
               '31 35 61 30 66 66 64 33 35 22 2C 22 66 61 6B 65 22 3A 30 2C 22 73'+
               '6F 63 69 61 6C 5F 69 64 22 3A 22 31 34 32 32 39 38 36 37 22 2C 22'+
               '63 6F 6E 66 69 67 5F 76 65 72 73 69 6F 6E 22 3A 33 37 2C 22 73 6E'+
               '22 3A 31 2C 22 73 6F 63 69 61 6C 5F 72 65 66 22 3A 22 31 34 32 32'+
               '39 38 36 37 22 2C 22 6D 6F 64 65 22 3A 31 2C 22 64 65 76 69 63 65'+
               '22 3A 22 22 7D E1 BC 80');}
try
  //TcpClient.Active:=True;
  TcpClient.Sendln(Auth,'');
//Сперва проверим наличие бана
{  while Pos('"time_begin"',AuthResp) = 0 do
  begin
    Application.ProcessMessages;
    TcpClient.WaitForData(1000); //ожидаем ответ сервера
    AuthResp:=TcpClient.Receiveln();
  end;
  if Pos('"time_begin"',AuthResp) <> 0 then
  begin
    Mdid:=StripNonNumeric(Copy(AuthResp,Pos('"moderator_id":',AuthResp)+15,7));
    StartTime:=Copy(AuthResp,Pos('"time_begin"',AuthResp)+13,10);
    EndTime:=Copy(AuthResp,Pos('"time_end"',AuthResp)+11,10);
    SecsCount:=StrToInt(EndTime)-StrToInt(StartTime); //считаем кол-во секунд
    MinsCount:=(Trunc(SecsCount/SecsPerMin)); //минут
    HoursCount:=(Trunc(MinsCount/MinsPerHour)); //часов
    DaysCount:=(Trunc(HoursCount/HoursPerDay)); //дней
    Debug.Lines.Add('-------------------------------------------------------------------');
    Debug.Lines.Add(AuthResp);
    Debug.Lines.Add('-------------------------------------------------------------------');
    Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
    +IntToStr(current.wMinute)+':'
    +IntToStr(current.wSecond)+'] -'+' You are banned from '+DateTimeToStr(UnixToDateTime(StrToInt(StartTime))));
    Log.Lines.Add('['+''+IntToStr(current.wHour)+':'+IntToStr(current.wMinute)+':'+IntToStr(current.wSecond)+'] -'+' by id'+MDid+'');
    Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
    +IntToStr(current.wMinute)+':'
    +IntToStr(current.wSecond)+'] -'+' for '+IntToStr(DaysCount)+' day(s)');
    Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
    +IntToStr(current.wMinute)+':'
    +IntToStr(current.wSecond)+'] -'+' Authorization failed');
  end;  }
//Потом попытаемся авторизоваться
//  while Pos('send_player_id',AuthResp) = 0 do
repeat
//  begin
    Application.ProcessMessages;
//    TcpClient.WaitForData(1000); //ожидаем ответ сервера
    AuthResp:=TcpClient.Receiveln();
//  end;
until Pos('send_player_id',AuthResp) <> 0;
//  if Pos('send_player_id',AuthResp) <> 0 then
//  begin
    Debug.Lines.Add('-------------------------------------------------------------------');
    Debug.Lines.Add(Copy(AuthResp,Pos('send_player_id',AuthResp)-2,45)); //выводим
    //Debug.Lines.Add(AuthResp);
    Debug.Lines.Add('-------------------------------------------------------------------');
    Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
    +IntToStr(current.wMinute)+':'
    +IntToStr(current.wSecond)+'] -'+' Successful authorization');
//  end;
//И наконец проверим наличие суточного бонуса
 while Pos('bonus_notify',AuthResp) = 0 do
 begin
    Application.ProcessMessages;
    TcpClient.WaitForData(1000); //ожидаем ответ сервера
    AuthResp:=TcpClient.Receiveln();
 end;
  if Pos('bonus_notify',AuthResp) <> 0 then
  begin
    Debug.Lines.Add('-------------------------------------------------------------------');
    Debug.Lines.Add(Copy(AuthResp,Pos('bonus_notify',AuthResp)-2,53)); //выводим
    Debug.Lines.Add('-------------------------------------------------------------------');
    Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
    +IntToStr(current.wMinute)+':'
    +IntToStr(current.wSecond)+'] -'+' Time to take your bonus');
  end;
except
  Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
  +IntToStr(current.wMinute)+':'
  +IntToStr(current.wSecond)+'] -'+' Authorization error');
  TcpClient.Active:=False;
end;
end;

procedure TMainForm.Bonus1Click(Sender: TObject);
var
  Bonus,BonusResp:string;
begin
  Inc(PackID);
  Bonus:='2cc/bonus/'+IntToStr(PackID)+HexToStr('E1BC81')+'{}'+HexToStr('E1BC80');
  //BonusTimer.Interval:=1000*60*60*24; //24 hours [86 400 000 msecs]
try
  //TcpClient.Active:=True;
  TcpClient.Sendln(Bonus,'');
  while Pos('bonus_get',BonusResp) = 0 do
  begin
    TcpClient.WaitForData(1000); //ожидаем ответ сервера
    BonusResp:=TcpClient.Receiveln('');
  end;
  if Pos('bonus_get',BonusResp) <> 0 then
  begin
    Debug.Lines.Add('---------------------------------------------------------------------------');
    Debug.Lines.Add(Copy(BonusResp,Pos('bonus_get',BonusResp)-2,50)); //выводим
    Debug.Lines.Add('---------------------------------------------------------------------------');
    Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
    +IntToStr(current.wMinute)+':'
    +IntToStr(current.wSecond)+'] -'+' Bonus for you');
  end;
except
    Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
    +IntToStr(current.wMinute)+':'
    +IntToStr(current.wSecond)+'] -'+' NO BONUS');
  TcpClient.Active:=False;
end;
end;

procedure TMainForm.Button1Click(Sender: TObject);
const
  Magic1='E1BC80';
  Magic2='E1BC81';
  Delim='/';
  //PackName='send_pm_message';
  PackName='send_chat_message';
  //PackName='send_regard';
  //PackName='edit_player_info';
  //PackName='buy_color';
  //PackName='transfer';
  //PackName='get_player_info_page';
  //PackName='enter_chat';
  //PackName='send_gift';
  //PackName='fin_mission';
  //PackName='get_pgifts';
  //PackName='clear_count_gifts_new';
var
  i:integer;
  Text,MessageText,Resp,Hash,FullPack:string;
begin
//  Debug.Lines.Add(LowerCase(Copy(md5('select_game_pickgV8b_df1FffAAzV0C0-ZGf~__+Gf##1333100{"picks_id":[2537047]}'),4,3)));
//    Text:='{"chat_id":100002}';
  //Text:='{"player_id":"100","invisible":true}';
 //Text:='{"info":{"about":"","city":"1","sex":"1","audio":-425118009,'
 //+'"name":"unknownproject","bdate":"1990-10-29","photo":"http://cs623122.vk.me/v623122380/144da/CcXaGsA6Z18.jpg#xp=5;yp=4","photos_ext":"","language":"1","autotext":""}}';
  //Text:='{"count":1,"player_id":"'+Edit2.Text+'","comment":"","gift_id":112}';
  //Text:='{"tasks":{"11":1,"15":300,"24":1,"29":1,"32":1,"34":1,"38":1}';
//for I := 0 to Flood.Lines.Count - 1 do
//  begin
//   Application.ProcessMessages;
//   Sleep(3000);
//   MessageText:=Flood.Lines.ValueFromIndex[i];
   inc(PackId);
  Text:='{"message":"'+Utf8ToAnsi(TestMessage.text)+'","to_player_id":0,"clear":0}';
  //Text:='{"to_player_id":2402280,"message":"'+MessageText+'"}';
  Hash:=LowerCase(Copy(md5(PackName+Salt+Text),4,3));
  FullPack:=Hash+Delim+PackName+Delim+IntToStr(PackID)+HexToStr(Magic2)+Text+HexToStr(Magic1);
try
  TcpClient.Active:=True;
  TcpClient.Sendln(FullPack,'');
  Resp:=TcpClient.Receiveln();
  Debug.Lines.Add(Resp);
except
  Log.Lines.Add('хуй');
end;
//end;
end;

procedure TMainForm.Button2Click(Sender: TObject);
const
  Magic1='E1BC80';
  Magic2='E1BC81';
  Delim='/';
var
  ColorPack,ColorResp,ColorParams,Hash,ColorText:string;
begin
  ColorPack:='edit_player_info';
  ColorParams:='{"info":{"substrate":"null","about":"testtesttesttesttesttesttesttesttest'+
  'testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest'+
  'testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest'+
  'testtesttesttesttesttesttesttesttest'+'"}}';
  Hash:=LowerCase(Copy(md5(ColorPack+Salt+ColorParams),4,3));
  ColorText:=Hash+Delim+ColorPack+Delim+IntToStr(PackID)+HexToStr(Magic2)+ColorParams+HexToStr(Magic1);
try
  TcpClient.Sendln(ColorText,'');
while Pos('send_players_info',ColorResp) = 0 do
begin
  Application.ProcessMessages;
  ColorResp:=TcpClient.Receiveln();
end;
except
end;
  Debug.Lines.Add(Copy(ColorResp,Pos('send_players_info',ColorResp),150));
end;

procedure TMainForm.Button3Click(Sender: TObject);
var
  json:TJsonObject;
  s:string;
begin
  S:=Edit1.text;
  json:=TJsonObject.create(s);
  ShowMessage(  json.getJsonObject('55507').getString('age') );
end;

procedure TMainForm.Clearlogs1Click(Sender: TObject);
begin
  Log.Lines.Clear;
  Debug.Lines.Clear;
  ChatWindow.ChatLog.Lines.Clear;
end;

procedure TMainForm.Connect1Click(Sender: TObject);
begin
  Connect1.Enabled:=False;
  Authorize1.Enabled:=True;
try
  Application.ProcessMessages;
//  TcpClient.RemoteHost:='178.159.255.207';
  TcpClient.RemoteHost:='31.186.103.18';
  TcpClient.RemotePort:='7009';
  TcpClient.Active:=True; //открываем соединение, устанавливая компонент в активный режим.
  Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
  +IntToStr(current.wMinute)+':'
  +IntToStr(current.wSecond)+'] -'+' Successful connection');
except
  Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
  +IntToStr(current.wMinute)+':'
  +IntToStr(current.wSecond)+'] -'+' Connection error');
  TcpClient.Active:=False;
end;
end;

procedure TMainForm.CurrentLocalTimeTimer(Sender: TObject); //здесь у нас будет основной код, который будет выполняться по таймеру с заданной задержкой
begin
  Inc(PackID);
  GameTimer.Interval:=StrToInt(Trim(SettingsForm.IntervalEdit.text))*1000;
  Game:='fd8/add_game_join/'+IntToStr(PackID)+HexToStr('E1BC81')+'{"type":"pick"}'+HexToStr('E1BC80');
  Resp:='';
  Sign:='';
  Selected:='';
  PickCopy:='';
  RateSign:='';
  RateResp:='';
  PickResp:='';
  Result:='';
//EnterWorkerThread; //выполняем код цикла в доп.потоке
try
  //Log.Lines.Clear;
  //Debug.Lines.Clear;
 // TcpClient.FreeOnRelease;
  TcpClient.Sendln(Game,'');  //отправляем пакет
  Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
  +IntToStr(current.wMinute)+':'
  +IntToStr(current.wSecond)+'] -'+' Waiting for the game');
//  While Pos('send_game_ready',Resp) = 0 do
//  begin
repeat
    Application.ProcessMessages;
    TcpClient.WaitForData(1000); //ожидаем ответ сервера
    Resp:=TcpClient.Receiveln(); //выводим
    PickResp:=Resp;
//  end;
   //Если мы получили пакет с таким заголовком, то это означает, что игра началась
until Pos('send_game_ready',PickResp) <> 0;
//  if Pos('send_game_ready',PickResp) <> 0 then
//  begin
    Debug.Lines.Add('------------------------    ['+''+IntToStr(current.wHour)+':'+IntToStr(current.wMinute)+':'+IntToStr(current.wSecond)+']    ------------------------');
    Debug.Lines.Add(Copy(PickResp,Pos('send_game_ready',PickResp)-2,46)); //выводим
    Debug.Lines.Add('-------------------------------------------------------------------');
    Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
    +IntToStr(current.wMinute)+':'
    +IntToStr(current.wSecond)+'] -'+' Game was started');
    inc(PackId);
    PickCopy:=(Copy(PickResp,Pos('send_game_ready',PickResp)+33,7)); //копируем 7 символов id, начиная с позиции, содержащей инфу.
    PickCopy:=StripNonNumeric(PickCopy);
    if PickCopy <> '1895899' then
    //if PickCopy <> '2402280' then
    begin
      //Assert(PickCopy <> '1895899');
      Sign:=LowerCase(Copy(md5('select_game_pick'+Salt+'{"picks_id":['+PickCopy+']}'),4,3));
      PickText:=Sign+'/select_game_pick/'+IntToStr(PackID)+HexToStr('E1BC81')+'{"picks_id":['+PickCopy+']}'+HexToStr('E1BC80');
    try
      //TcpClient.Active:=True;
      TcpClient.Sendln(PickText,'');
//      TcpClient.WaitForData(1000);
      Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
      +IntToStr(current.wMinute)+':'
      +IntToStr(current.wSecond)+'] -'+' Arrow goes to '+PickCopy);
    except
    end;
    end;
//    end;
  //////////////////////////////////////////////////////////////////
///  Выводим текущее кол-во игр
//  While Pos('"infos":{"1895899":{"count_games"',Resp) = 0 do
  //While Pos('"infos":{"2402280":{"count_games"',Resp) = 0 do
//  begin
repeat
    Application.ProcessMessages;
    TcpClient.WaitForData(1000); //ожидаем ответ сервера
    Resp:=TcpClient.Receiveln(); //выводим
//  end;
until Pos('{"infos":{"1895899":{"count_games"',Resp) <> 0;

//  if Pos('{"infos":{"1895899":{"count_games"',Resp) <> 0 then
  //if Pos('{"infos":{"2402280":{"count_games"',Resp) <> 0 then
//  begin
  //  Assert(Pos('{"infos":{"1895899":{"count_games"',Resp) <> 0);
    Resp:=Copy(Resp,Pos('{"infos":{"1895899":{"count_games"',Resp),43);
    //Resp:=Copy(Resp,Pos('{"infos":{"2402280":{"count_games"',Resp),43);
    Debug.Lines.Add('------------------------    ['+''+IntToStr(current.wHour)+':'+IntToStr(current.wMinute)+':'+IntToStr(current.wSecond)+']    ------------------------');
    Debug.Lines.Add(Resp); //выводим
    Debug.Lines.Add('-------------------------------------------------------------------');
    Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
    +IntToStr(current.wMinute)+':'
    +IntToStr(current.wSecond)+'] -'+' Game was finished');
    Played.Caption:=IntToStr(StrToInt(Played.Caption)+1); //обновляем кол-во игр
//  end;
    //////////////////////////////////////////////////////////////////
///  Дергаем пакет, содержащий выборы игроков по окончанию игры
//  while Pos('{"game":{"gplayers":{',Resp) = 0 do
//  begin
repeat
    Application.ProcessMessages;
    TcpClient.WaitForData(1000); //ожидаем ответ сервера
    Resp:=TcpClient.Receiveln(); //выводим
    RateResp:=Resp;
//  end;
until Pos('{"id":'+PickCopy+',"picks":[',RateResp) <> 0;
//  if Pos('{"id":'+PickCopy+',"picks":[',RateResp) <> 0 then   //выясняем, не выбрала ли нас жертва
//  begin
    Selected:=Copy(RateResp,Pos('{"id":'+PickCopy+',"picks":[',RateResp),31);
    Selected:=StripNonNumeric(Copy(Selected, Pos('"picks":[',Selected)+9,7));
    Debug.Lines.Add('------------------------    ['+''+IntToStr(current.wHour)+':'+IntToStr(current.wMinute)+':'+IntToStr(current.wSecond)+']    ------------------------');
    Debug.Lines.Add(Copy(Resp,Pos('"id":'+PickCopy+',"picks":[',RateResp),31)); //выводим
    Debug.Lines.Add('-------------------------------------------------------------------');
  if Selected = '1895899' then
  //if Selected = '2402280' then
    begin
      Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
      +IntToStr(current.wMinute)+':'
      +IntToStr(current.wSecond)+'] -'+' Yeah.Mutual selection');
      Mutual.Caption:=IntToStr(StrToInt(Mutual.Caption)+1); //обновляем кол-во взаимных выборов
      inc(PackID);
      RateSign:=LowerCase(Copy(md5('rate_game_kiss'+Salt+'{"rating":100,"player_id":'+PickCopy+'}'),4,3));
      RateText:=Ratesign+'/rate_game_kiss/'+IntToStr(PackID)+HexToStr('E1BC81')+'{"rating":100,"player_id":'+PickCopy+'}'+HexToStr('E1BC80');
    try
      //TcpClient.Active:=True;
      TcpClient.Sendln(RateText,'');
  //  while Pos('"type":3}}',Result) = 0 do
  //    begin
        Application.Processmessages;
        TcpClient.WaitForData(1000);
        Result:=TcpClient.Receiveln();
   //   end;
        Debug.Lines.Add('------------------------    ['+''+IntToStr(current.wHour)+':'+IntToStr(current.wMinute)+':'+IntToStr(current.wSecond)+']    ------------------------');
        Debug.Lines.Add(Copy(Result,Pos('"type":3}}',Result)-151,164)); //выводим
        Debug.Lines.Add('-------------------------------------------------------------------');
        Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
        +IntToStr(current.wMinute)+':'
        +IntToStr(current.wSecond)+'] - '+PickCopy+' got 100 points');
    except
    end;
    end;
//    end;
  except
  //Log.Lines.Add('Something wrong...');
  //TcpClient.Active:=False;
  //LeaveWorkerThread; //выходим из доп.потом по завершению цикла
end;
end;


procedure TMainForm.Disconnect1Click(Sender: TObject);
begin
//  Thread.Terminate;
  Disconnect1.Enabled:=False;
  Connect1.Enabled:=True;
try
  TcpClient.Active:=False;
  Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
  +IntToStr(current.wMinute)+':'
  +IntToStr(current.wSecond)+'] -'+' Connection was closed');
except
  Log.Lines.Add('['+''+IntToStr(current.wHour)+':'
  +IntToStr(current.wMinute)+':'
  +IntToStr(current.wSecond)+'] -'+' WTF!!!!!');
  TcpClient.Active:=False;
end;
end;

end.
