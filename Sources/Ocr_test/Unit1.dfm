object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 241
    Height = 185
    AutoSize = True
    Center = True
    IncrementalDisplay = True
    Stretch = True
  end
  object Button1: TButton
    Left = 8
    Top = 199
    Width = 75
    Height = 25
    Caption = 'TorgWM'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 255
    Top = 104
    Width = 378
    Height = 97
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object Button2: TButton
    Left = 96
    Top = 199
    Width = 75
    Height = 25
    Caption = 'WmSim'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 230
    Width = 75
    Height = 25
    Caption = 'DemonChange'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Ocr1: TOcr
    Left = 264
    Top = 8
  end
  object OpenDialog1: TOpenDialog
    Left = 320
    Top = 8
  end
  object HTTP: TIdHTTP
    IOHandler = SSL
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 376
    Top = 8
  end
  object SSL: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 408
    Top = 8
  end
end