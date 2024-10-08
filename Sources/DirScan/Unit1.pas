unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, ComCtrls, IdAntiFreezeBase, IdAntiFreeze, Menus, Gauges, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    PageControl: TPageControl;
    ListTab: TTabSheet;
    OkTab: TTabSheet;
    FoundTab: TTabSheet;
    ForbiddenTab: TTabSheet;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    StatBox: TGroupBox;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Menu: TMainMenu;
    Action1: TMenuItem;
    Start1: TMenuItem;
    About1: TMenuItem;
    Pause1: TMenuItem;
    Resume1: TMenuItem;
    Stop1: TMenuItem;
    Gauge1: TGauge;
    Exit1: TMenuItem;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    HTTP: TNetHTTPClient;
    procedure Start1Click(Sender: TObject);
    procedure Stop1Click(Sender: TObject);
    procedure Resume1Click(Sender: TObject);
    procedure Pause1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  Test = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

var
  Form1: TForm1;
  Stop: integer;
  Thread: TThread;
  cnt:integer;
  Result: IHTTPResponse;
implementation

uses ABOUT;

{$R *.dfm}

{ Server response codes: }
{ HTTP/1.1 200 OK }
{ HTTP/1.1 206 Partial Content }
{ HTTP/1.1 403 Forbidden }
{ HTTP/1.1 302 Found }
{ HTTP/1.1 404 Not Found }


procedure Test.Execute;
var
  i:integer;
begin
  Form1.Start1.Enabled:=False;
  Form1.ListTab.Enabled:=False;
  Form1.Edit1.Enabled:=False;
  Form1.Pause1.Enabled:=True;
  Form1.Gauge1.Progress:=0;
  Form1.Gauge1.MaxValue:=Form1.Memo1.Lines.Count;
  Form1.HTTP.UserAgent:='Google Bot';
//  Form1.Idhttp1.Request.UserAgent:='Google Bot';
  cnt:=0;
  Stop:=0; //����������, ����� ����� ����������� ������ ��� �������
  for i := 0 to Form1.Memo1.Lines.Count do  //���������� ������
  begin
    Application.ProcessMessages;
    sleep(200);
  try
  //  Form1.IdHttp1.Get(Form1.Edit1.text+Form1.Memo1.Lines.Strings[i]); //������ � �������� ����� ������� ������ ������
    Result:=Form1.Http.Get(Form1.Edit1.text+Form1.Memo1.Lines.Strings[i]); //������ � �������� ����� ������� ������ ������
except
  end;
    if Stop=1 then
    begin
      Form1.Gauge1.Progress:=Form1.Gauge1.MaxValue;
      break;
    end;
  Synchronize(
  procedure
  begin
    inc(cnt);
    Form1.Label2.Caption:=IntToStr(cnt);
    Form1.Gauge1.Progress:=Form1.Gauge1.Progress+1;
    if Form1.Result.StatusText='Not Found' then
    //if Form1.Idhttp1.Response.ResponseText='HTTP/1.1 404 Not Found' then    //���� ����(�����) �� ������(�)
    begin
     //Memo1.Lines.Add('404 Not Found');
    end
    else
    if Form1.Result.StatusText='OK' then
//    if Form1.Idhttp1.Response.ResponseText='HTTP/1.1 200 OK' then  //���� ��� �������
    begin
      Form1.Memo2.Lines.Add(Form1.Edit1.Text+Form1.Memo1.Lines.Strings[i]);  //������� �����
    end
    else
    if Form1.Result.StatusText='Forbidden' then
 //   if Form1.Idhttp1.Response.ResponseText='HTTP/1.1 403 Forbidden' then    //����  ������ � �����(�����) ��������
    begin
      Form1.Memo4.Lines.Add(Form1.Edit1.Text+Form1.Memo1.Lines.Strings[i]);
    end
    else
    if Form1.Result.StatusText='Found' then
 //   if Form1.Idhttp1.Response.ResponseText='HTTP/1.1 302 Found' then    //���� ���� (�����) ������(�), �� ��� ����������
    begin
      Form1.Memo3.Lines.Add(Form1.Edit1.Text+Form1.Memo1.Lines.Strings[i]);
    end;
  end)
{    inc(cnt);
    Form1.Label2.Caption:=IntToStr(cnt);
    Form1.ProgressBar1.Position:=Form1.ProgressBar1.Position+1;
    if Form1.Idhttp1.Response.ResponseText='HTTP/1.1 404 Not Found' then    //���� ����(�����) �� ������(�)
    begin
     //Memo1.Lines.Add('404 Not Found');
    end
    else
    if Form1.Idhttp1.Response.ResponseText='HTTP/1.1 200 OK' then  //���� ��� �������
    begin
      Form1.Memo2.Lines.Add(Form1.Edit1.Text+Form1.Memo1.Lines.Strings[i]);  //������� �����
    end
    else
    if Form1.Idhttp1.Response.ResponseText='HTTP/1.1 403 Forbidden' then    //����  ������ � �����(�����) ��������
    begin
      Form1.Memo4.Lines.Add(Form1.Edit1.Text+Form1.Memo1.Lines.Strings[i]);
    end
    else
    if Form1.Idhttp1.Response.ResponseText='HTTP/1.1 302 Found' then    //���� ���� (�����) ������(�), �� ��� ����������
    begin
      Form1.Memo3.Lines.Add(Form1.Edit1.Text+Form1.Memo1.Lines.Strings[i]);
    end; }
  end;
  Form1.Start1.Enabled:=True;
  Form1.Edit1.Enabled:=True;
  Form1.ListTab.Enabled:=True;
  Form1.Pause1.Enabled:=False;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  AboutBox.Show;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  ExitProcess($7357);
end;

procedure TForm1.Pause1Click(Sender: TObject);
begin
  Thread.Suspend;
  Pause1.Enabled:=False;
  Resume1.Enabled:=True;
  Stop1.Enabled:=True;
end;

procedure TForm1.Resume1Click(Sender: TObject);
begin
  if Thread.Suspended=True then
  begin
    Thread.Resume;
    Pause1.Enabled:=True;
    Resume1.Enabled:=False;
    Stop1.Enabled:=False;
  end;
end;

procedure TForm1.Start1Click(Sender: TObject);
begin
  Thread:=Test.Create(true);
  Thread.FreeOnTerminate:=True;
  Thread.Priority:=TpNormal;
end;

procedure TForm1.Stop1Click(Sender: TObject);
begin
  if Thread.Suspended=True then
  begin
    Stop:=1;
    Thread.Terminate;
    Stop1.Enabled:=False;
    Resume1.Enabled:=False;
    Start1.Enabled:=True;
    Edit1.Enabled:=True;
    ListTab.Enabled:=True;
  end;
end;

end.
