unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Ocr, PngImage, Jpeg, GifImg, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Ocr1: TOcr;
    Image1: TImage;
    OpenDialog1: TOpenDialog;
    HTTP: TIdHTTP;
    SSL: TIdSSLIOHandlerSocketOpenSSL;
    Memo1: TMemo;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Img: TPngImage;
  Img2: TJpegImage;
  ImgData: TMemoryStream;
  PostData: TStringList;
  Header: array [0..3] of ansichar;
  Captcha,Result: string;
begin
  ImgData:=TMemoryStream.Create;
  PostData:=TstringList.Create;
  PostData.Add('bonus_count=R337507343219');
  PostData.Add('n=1');
  Header:='';
  Http.Request.UserAgent:='Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:57.0) Gecko/20100101 Firefox/57.0';
try
  Http.Get('https://torgwm.ru/captcha.php',ImgData);
  ImgData.Position:=0; //� ������ �������
  ImgData.Read(Header,4); //��������� ���������
  if Header='����' then
  begin
    ImgData.SaveToFile('temp.jpg');
    Img2:=TJpegImage.Create;
    Img2.LoadFromFile('temp.jpg');
    Image1.Picture.Assign(Img2);
    Ocr1.Picture.Assign(Image1.Picture);
    Ocr1.DataPath:=ExtractFilePath(Application.ExeName+'/tessdata');
    Ocr1.Active := True;
    Captcha:=Trim(LowerCase(Ocr1.Text));
  end
  else
  if Header='�PNG' then
  begin
    ImgData.SaveToFile('temp.png');
    Img:=TPngImage.Create;
    Img.LoadFromFile('temp.png');
    Image1.Picture.Assign(Img);
    Ocr1.Picture.Assign(Image1.Picture);
    Ocr1.EngineMode:=emDefault;
    Ocr1.DataPath:=ExtractFilePath(Application.ExeName+'/tessdata');
    Ocr1.Active := True;
    Captcha:=Trim(LowerCase(Ocr1.Text));
  end;
  if Captcha <> '' then
  begin
    PostData.Add('bonus_code='+Captcha);
    Result:=Http.Post('https://torgwm.ru/bonus_pay.php',PostData);
    Memo1.Lines.Add(Result);
  end;
finally
  ImgData.Free;
  Img.Free;
end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Img: TPngImage;
  Img2: TJpegImage;
  ImgData: TMemoryStream;
  PostData: TStringList;
  Header: array [0..3] of ansichar;
  Captcha,Result: string;
begin
  ImgData:=TMemoryStream.Create;
  PostData:=TstringList.Create;
  PostData.Add('bonus_count=R337507343219');
  PostData.Add('n=1');
  Header:='';
  Http.Request.UserAgent:='Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:57.0) Gecko/20100101 Firefox/57.0';
try
  Http.Get('http://www.wmsim.ru/bonus/captcha.php',ImgData);
  ImgData.Position:=0; //� ������ �������
  ImgData.Read(Header,4); //��������� ���������
  if Header='����' then
  begin
    ImgData.SaveToFile('temp.jpg');
    Img2:=TJpegImage.Create;
    Img2.LoadFromFile('temp.jpg');
    Image1.Picture.Assign(Img2);
    Ocr1.Picture.Assign(Image1.Picture);
    Ocr1.DataPath:=ExtractFilePath(Application.ExeName+'/tessdata');
    Ocr1.Active := True;
    Captcha:=Trim(LowerCase(Ocr1.Text));
  end
  else
  if Header='�PNG' then
  begin
    ImgData.SaveToFile('temp.png');
    Img:=TPngImage.Create;
    Img.LoadFromFile('temp.png');
    Image1.Picture.Assign(Img);
    Ocr1.Picture.Assign(Image1.Picture);
    Ocr1.EngineMode:=emDefault;
    Ocr1.DataPath:=ExtractFilePath(Application.ExeName+'/tessdata');
    Ocr1.Active := True;
    Captcha:=Trim(LowerCase(Ocr1.Text));
  end;
    Memo1.text:=Captcha;
  if Captcha <> '' then
  begin
    Result:=Http.Get('https://www.wmsim.ru/bonus/validator.php?wmr_purse=R337507343219&wmr_captcha='+Captcha);
    Memo1.Lines.Add(Result);
  end;
finally
  ImgData.Free;
  Img.Free;
end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Img: TPngImage;
  Img2: TJpegImage;
  Img3: TGifImage;
  ImgData: TMemoryStream;
  PostData: TStringList;
  Header: array [0..3] of ansichar;
  Captcha,Result: string;
begin
  ImgData:=TMemoryStream.Create;
  PostData:=TstringList.Create;
  PostData.Add('bonus_count=R337507343219');
  PostData.Add('n=1');
  Header:='';
  Http.Request.UserAgent:='Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:57.0) Gecko/20100101 Firefox/57.0';
try
  Http.Get('http://m.fotostrana.ru/antispam/captcha/?type=3&mtime=0.37455000%201512117073',ImgData);
  ImgData.Position:=0; //� ������ �������
  ImgData.Read(Header,4); //��������� ���������
  if Header = 'GIF8' then
  begin
    ImgData.SaveToFile('temp.gif');
    Img3:=TGifImage.Create;
    Img3.LoadFromFile('temp.gif');
    Image1.Picture.Assign(Img3);
    Ocr1.Picture.Assign(Image1.Picture);
    Ocr1.DataPath:=ExtractFilePath(Application.ExeName+'/tessdata');
    Ocr1.Active := True;
    Captcha:=Trim(LowerCase(Ocr1.Text));
  end
  else
  if Header='����' then
  begin
    ImgData.SaveToFile('temp.jpg');
    Img2:=TJpegImage.Create;
    Img2.LoadFromFile('temp.jpg');
    Image1.Picture.Assign(Img2);
    Ocr1.Picture.Assign(Image1.Picture);
    Ocr1.DataPath:=ExtractFilePath(Application.ExeName+'/tessdata');
    Ocr1.Active := True;
    Captcha:=Trim(LowerCase(Ocr1.Text));
  end
  else
  if Header='�PNG' then
  begin
    ImgData.SaveToFile('temp.png');
    Img:=TPngImage.Create;
    Img.LoadFromFile('temp.png');
    Image1.Picture.Assign(Img);
    Ocr1.Picture.Assign(Image1.Picture);
    Ocr1.EngineMode:=emDefault;
    Ocr1.DataPath:=ExtractFilePath(Application.ExeName+'/tessdata');
    Ocr1.Active := True;
    Captcha:=Trim(LowerCase(Ocr1.Text));
  end;
    Memo1.text:=Captcha;
{  if Captcha <> '' then
  begin
    Result:=Http.Get('https://www.wmsim.ru/bonus/validator.php?wmr_purse=R337507343219&wmr_captcha='+Captcha);
    Memo1.Lines.Add(Result);
  end;  }
finally
  ImgData.Free;
  Img.Free;
end;
end;



end.
