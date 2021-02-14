object Form4: TForm4
  Left = 0
  Top = 8
  ActiveControl = UpDown1
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Network Settings'
  ClientHeight = 218
  ClientWidth = 300
  Color = 10079487
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 283
    Height = 201
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 33
      Height = 13
      Caption = 'Proxy'
    end
    object Label2: TLabel
      Left = 151
      Top = 11
      Width = 46
      Height = 13
      Caption = 'Threads'
    end
    object Label5: TLabel
      Left = 112
      Top = 103
      Width = 52
      Height = 13
      Caption = '   Referer'
    end
    object Label6: TLabel
      Left = 112
      Top = 149
      Width = 60
      Height = 13
      Caption = 'UserAgent'
    end
    object Edit1: TEdit
      Left = 51
      Top = 8
      Width = 94
      Height = 19
      Color = 12581355
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Text = '127.0.0.1:8080'
      OnClick = Edit1Click
    end
    object Edit2: TEdit
      Left = 213
      Top = 8
      Width = 46
      Height = 19
      Alignment = taCenter
      Color = 12581355
      TabOrder = 1
      Text = '1'
    end
    object UpDown1: TUpDown
      Left = 259
      Top = 8
      Width = 16
      Height = 19
      Associate = Edit2
      Min = 1
      Max = 500
      Position = 1
      TabOrder = 2
    end
    object TimeOut: TGroupBox
      Left = 30
      Top = 35
      Width = 221
      Height = 62
      Caption = 'Timeout'
      TabOrder = 3
      object Label3: TLabel
        Left = 40
        Top = 13
        Width = 29
        Height = 13
        Caption = 'Read'
      end
      object Label4: TLabel
        Left = 136
        Top = 13
        Width = 46
        Height = 13
        Caption = 'Connect'
      end
      object Edit3: TEdit
        Left = 8
        Top = 27
        Width = 97
        Height = 19
        Alignment = taCenter
        Color = 12581355
        TabOrder = 0
        Text = '10000'
      end
      object Edit4: TEdit
        Left = 114
        Top = 27
        Width = 97
        Height = 19
        Alignment = taCenter
        Color = 12581355
        TabOrder = 1
        Text = '0'
      end
    end
    object Edit5: TEdit
      Left = 13
      Top = 122
      Width = 259
      Height = 19
      Color = 12581355
      TabOrder = 4
    end
    object Edit6: TEdit
      Left = 13
      Top = 168
      Width = 259
      Height = 19
      Color = 12581355
      TabOrder = 5
      Text = 
        'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gec' +
        'ko) Chrome/31.0.1650.63 Safari/537.36 OPR/18.0.1284.68'
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.txt'
    Left = 24
    Top = 40
  end
end
