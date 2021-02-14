object MainForm: TMainForm
  Left = 150
  Top = 0
  ActiveControl = BoxOne
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = '                    [    7sky - Exosphere Tools v1.11     ]'
  ClientHeight = 261
  ClientWidth = 311
  Color = 1144302
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -9
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  PixelsPerInch = 96
  TextHeight = 11
  object Log: TMemo
    Left = 8
    Top = 8
    Width = 297
    Height = 73
    Alignment = taCenter
    Color = 13565951
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    WantReturns = False
  end
  object BoxOne: TGroupBox
    Left = 8
    Top = 155
    Width = 297
    Height = 100
    TabOrder = 1
    object Time: TLabel
      Left = 240
      Top = 14
      Width = 45
      Height = 11
      Alignment = taCenter
      Caption = 'Getting...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 16514043
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object PlayedLabel: TLabel
      Left = 3
      Top = 14
      Width = 37
      Height = 11
      Caption = 'Played:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Played: TLabel
      Left = 46
      Top = 14
      Width = 7
      Height = 11
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ArrowLabel: TLabel
      Left = 104
      Top = 6
      Width = 3
      Height = 11
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9764864
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object MutualLabel: TLabel
      Left = 94
      Top = 14
      Width = 87
      Height = 11
      Caption = 'Mutual selection: '
    end
    object Mutual: TLabel
      Left = 187
      Top = 14
      Width = 7
      Height = 11
      Caption = '0'
    end
    object TestMessage: TMemo
      Left = 3
      Top = 52
      Width = 289
      Height = 15
      TabOrder = 0
    end
    object Button1: TButton
      Left = 4
      Top = 73
      Width = 288
      Height = 22
      Caption = 'Send message'
      TabOrder = 1
      OnClick = Button1Click
    end
    object TotalOnline: TMemo
      Left = 3
      Top = 31
      Width = 289
      Height = 15
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Lines.Strings = (
        'Nothing')
      ParentFont = False
      TabOrder = 2
      WantReturns = False
    end
  end
  object Debug: TMemo
    Left = 8
    Top = 80
    Width = 297
    Height = 73
    Alignment = taCenter
    Color = 10412768
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object Button2: TButton
    Left = 311
    Top = 62
    Width = 75
    Height = 25
    Caption = 'Color'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 311
    Top = 8
    Width = 567
    Height = 17
    TabOrder = 4
    Text = 
      '{"infos":{"55507":{"id":55507,"name":"&#034;&#034;&#034;","rgb":' +
      '"02CC98","photo":"http://cs628519.vk.me/v628519190/1c098/FCg8kXG' +
      '3DSw.jpg#xp=5;yp=2","webcam":0,"sex":2,"city":831,"country":1,"a' +
      'ge":18},"993489":{"id":993489,"name":"Speshel","rgb":"FF33FF","p' +
      'hoto":"http://cs7002.vk.me/v7002333/10408/mxJQa5p7Hho.jpg#xp=5;y' +
      'p=3","webcam":0,"sex":2,"city":5,"country":1,"age":18},"1734329"' +
      ':{"id":1734329,"name":"RA'#173'shA?","rgb":"FAE61A","photo":"http://c' +
      's624219.vk.me/v624219279/46de3/5vwJ8gYiDGE.jpg#xp=5;yp=2","webca' +
      'm":0,"sex":2,"city":1,"country":1,"age":24},"1895899":{"id":1895' +
      '899,"name":"unknownproject","rgb":"FD4948","photo":"http://cs623' +
      '122.vk.me/v623122380/144da/CcXaGsA6Z18.jpg#yp=4;xp=5","webcam":0' +
      ',"sex":1,"city":1,"country":1,"age":25},"2200896":{"id":2200896,' +
      '"name":"quA?st.","rgb":"FF6B11","photo":"http://cs623424.vk.me/v' +
      '623424258/4b67a/F9Mg3ueLyLY.jpg#xp=10;yp=1","webcam":0,"sex":1,"' +
      'city":1,"country":1,"age":20},"2371109":{"id":2371109,"name":"?'#181 +
      'a'#8218#166'A?a'#8364#160'-A'#177'-`Ugarova","rgb":"68C6C3","photo":"http://cs629400.vk' +
      '.me/v629400837/26040/pq21GR5fbTw.jpg#xp=5;yp=2","webcam":0,"sex"' +
      ':1,"city":1,"country":1,"age":21},"2777868":{"id":2777868,"name"' +
      ':"#ST sto iz sta","rgb":"C7020B","photo":"http://cs628328.vk.me/' +
      'v628328239/3612a/4PW5-UFvDxE.jpg#yp=4;xp=10","webcam":0,"sex":1,' +
      '"city":1,"country":1,"age":18},"2780592":{"id":2780592,"name":"|' +
      '`ICHI ?? ????N'#8364' ????????|","rgb":"A5FEDA","photo":"http://cs6277' +
      '29.vk.me/v627729661/35032/zDnwppXPd8w.jpg#xp=5;yp=2","webcam":0,' +
      '"sex":1,"city":1,"country":1,"age":18},"2851135":{"id":2851135,"' +
      'name":"Zvyozdochka","rgb":"6BE100","photo":"http://cs628029.vk.m' +
      'e/v628029426/2dcfd/qnLYSj6w_6M.jpg#xp=8;yp=0","webcam":0,"sex":2' +
      ',"city":1,"country":1,"age":19},"3061924":{"id":3061924,"name":"' +
      'Little ?'#187'?'#177'N'#8218' Huligan","rgb":"C7020B","photo":"http://cs628629.v' +
      'k.me/v628629192/35290/g3TByuuCGmo.jpg#xp=5;yp=2","webcam":0,"sex' +
      '":2,"city":1,"country":1,"age":19}}}'
  end
  object Button3: TButton
    Left = 311
    Top = 31
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 5
    OnClick = Button3Click
  end
  object GameTimer: TTimer
    Enabled = False
    OnTimer = CurrentLocalTimeTimer
    Left = 29
    Top = 16
  end
  object LocalTimer: TTimer
    OnTimer = LocalTimerTimer
    Left = 149
    Top = 16
  end
  object MainMenu: TMainMenu
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    Left = 261
    Top = 16
    object N1: TMenuItem
      Caption = 'File'
      object Settings1: TMenuItem
        Caption = 'Settings'
        OnClick = Settings1Click
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Action1: TMenuItem
      Caption = 'Game'
      object Start1: TMenuItem
        Caption = 'Start'
        OnClick = Start1Click
      end
      object Stop1: TMenuItem
        Caption = 'Stop'
        Enabled = False
        OnClick = Stop1Click
      end
    end
    object Connection1: TMenuItem
      Caption = 'Connection'
      object Connect1: TMenuItem
        Caption = 'Connect'
        OnClick = Connect1Click
      end
      object Authorize1: TMenuItem
        Caption = 'Authorize'
        Enabled = False
        OnClick = Authorize1Click
      end
      object Disconnect1: TMenuItem
        Caption = 'Disconnect'
        Enabled = False
        OnClick = Disconnect1Click
      end
    end
    object Flood1: TMenuItem
      Caption = 'Flood'
      object Start2: TMenuItem
        Caption = 'Start'
        OnClick = Start2Click
      end
      object Stop2: TMenuItem
        Caption = 'Stop'
        Enabled = False
        OnClick = Stop2Click
      end
    end
    object N2: TMenuItem
      Caption = 'Other'
      object Bonus1: TMenuItem
        Caption = 'Bonus'
        OnClick = Bonus1Click
      end
      object Clearlogs1: TMenuItem
        Caption = 'Clear logs'
        OnClick = Clearlogs1Click
      end
    end
    object Chat1: TMenuItem
      Caption = 'Chat'
      object Start3: TMenuItem
        Caption = 'Start'
        OnClick = Start3Click
      end
      object Stop3: TMenuItem
        Caption = 'Stop'
        OnClick = Stop3Click
      end
      object Show: TMenuItem
        Caption = 'Show'
        OnClick = ShowClick
      end
    end
  end
  object TcpClient: TTcpClient
    BlockMode = bmNonBlocking
    OnReceive = TcpClientReceive
    Left = 152
    Top = 56
  end
  object FloodTimer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = FloodTimerTimer
    Left = 88
    Top = 16
  end
  object OpenDialog1: TOpenDialog
    Left = 211
    Top = 16
  end
  object ChatTimer: TTimer
    Enabled = False
    Interval = 10000
    Left = 136
    Top = 104
  end
end
