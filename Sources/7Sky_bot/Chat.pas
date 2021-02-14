unit Chat;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls,UMD5,StrUtils,Dialogs;

type
  TChatWindow = class(TForm)
    ChatBorder: TBevel;
    ChatLog: TMemo;
    ChatTimer: TTimer;
    Msg: TEdit;
    SendBtn: TButton;
    Button1: TButton;
    Memo1: TMemo;
    procedure ChatTimerTimer(Sender: TObject);
    procedure SendBtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  BotThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    procedure checking;
  end;

var
  ChatWindow: TChatWindow;
  Thread: BotThread;
  Resp:string;
const
  UnixStartDate: TDateTime = 25569.0;
implementation

uses Main;

{$R *.dfm}
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

//

procedure BotThread.checking;
begin
end;


procedure BotThread.Execute;
begin
end;


procedure TChatWindow.Button1Click(Sender: TObject);
begin
  Thread:=BotThread.Create(True);
  Thread.Priority := tpNormal;
  Thread.FreeOnTerminate:=True;
  Thread.Resume;
end;

procedure TChatWindow.ChatTimerTimer(Sender: TObject);
var
  Resp,ID,ChatMessage,CorrectTime,PinfoResp,Uname:string;
  RealTime:_SYSTEMTIME;
begin
  Resp:='';
  ID:='';
  ChatMessage:='';
  CorrectTime:='';
  PinfoResp:='';
  Uname:='';
  if ChatLog.Lines.Count >= 100 then
  begin
    ChatLog.Lines.Clear;
  end;
//  while Pos('send_players_info',PinfoResp) = 0 do
//  begin
repeat
  Application.ProcessMessages;
  PinfoResp:=MainForm.TcpClient.Receiveln();
until Pos('send_players_info',PinfoResp) <> 0;
//  if Pos('send_players_info',PinfoResp) <> 0 then
//  Begin
    //ID:=Copy(PinfoResp,Pos('"id":',PinfoResp)+5,Pos(',"name',PinfoResp)-Pos('"id":',PinfoResp)-5);
UName:=Utf8ToAnsi(Copy(PinfoResp,Pos('name',PinfoResp)+7,Pos('","tops_w',PinfoResp)-Pos('name',PinfoResp)-7));
//    break;
//  End;
//  end;
//будем вызывать только, если сграббили имя
//  while Pos ('send_chat_posts',Resp) = 0 do
//  begin
repeat
    Application.ProcessMessages;
    Resp:=MainForm.TcpClient.Receiveln();
until Pos ('send_chat_posts',Resp) <> 0;
//  if Pos ('send_chat_posts',Resp) <> 0 then
//  begin
    ID:=Copy(Resp,Pos('player_id',Resp)+11,Pos(',"message',Resp)-Pos('player_id',Resp)-11);
    GetLocalTime(RealTime);
    CorrectTime:=IntToStr(RealTime.whour)+':'+IntToStr(RealTime.wminute)+':'+IntToStr(RealTime.wsecond);
    ChatMessage:=Utf8ToAnsi(Copy(Resp,Pos('message',Resp)+10,Pos('","to_player_id',Resp)-Pos('message',Resp)-10));
//    break;
//  end;
//  end;
//14.10.2016 20:18:20
//if ID='2402280' then
  if ID='1895899' then
  begin
    ChatWindow.ChatLog.Lines.Add('['+CorrectTime+'] '+UName+' (Я): '+ChatMessage);
  end
  else
    ChatWindow.ChatLog.Lines.Add('['+CorrectTime+'] '+UName+' (id'+ID+'): '+ChatMessage);
  end;
  
procedure TChatWindow.SendBtnClick(Sender: TObject);
const
  Salt='gV8b_df1FffAAzV0C0-ZGf~__+Gf##1333100';
  Magic1='E1BC80';
  Magic2='E1BC81';
  Delim='/';
  PackName='send_chat_message';
var
  Text,{Resp,}Hash,FullPack:string;
begin
  inc(PackId);
  Text:='{"message":"'+AnsiToUtf8(Msg.Text)+'","to_player_id":0,"clear":0}';
  //Text:='{"to_player_id":2402280,"message":"'+MessageText+'"}';
  Hash:=LowerCase(Copy(md5(PackName+Salt+Text),4,3));
  FullPack:=Hash+Delim+PackName+Delim+IntToStr(PackID)+HexToStr(Magic2)+Text+HexToStr(Magic1);
try
  MainForm.TcpClient.Sendln(FullPack,'');
  Msg.Text:='';
//  Resp:=MainForm.TcpClient.Receiveln();
except
  MainForm.Log.Lines.Add('хуй');
end;
//end;
end;

end.
