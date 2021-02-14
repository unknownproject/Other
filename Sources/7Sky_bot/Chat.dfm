object ChatWindow: TChatWindow
  Left = 227
  Top = 108
  BorderStyle = bsToolWindow
  Caption = 
    '        =========================[      Chat Window      ]======' +
    '==================='
  ClientHeight = 537
  ClientWidth = 591
  Color = 11447982
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -9
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = True
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 11
  object ChatBorder: TBevel
    Left = 0
    Top = 0
    Width = 591
    Height = 537
    Align = alClient
    Shape = bsFrame
    ExplicitLeft = -6
    ExplicitTop = 8
    ExplicitHeight = 678
  end
  object ChatLog: TMemo
    Left = 8
    Top = 8
    Width = 577
    Height = 505
    Align = alCustom
    Color = 10412768
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object Msg: TEdit
    Left = 8
    Top = 515
    Width = 465
    Height = 17
    TabOrder = 1
  end
  object SendBtn: TButton
    Left = 479
    Top = 514
    Width = 106
    Height = 19
    Caption = 'Send message'
    TabOrder = 2
    OnClick = SendBtnClick
  end
  object Button1: TButton
    Left = 8
    Top = 538
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 591
    Top = 8
    Width = 434
    Height = 519
    Lines.Strings = (
      'Memo1')
    TabOrder = 4
  end
  object ChatTimer: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = ChatTimerTimer
    Left = 280
    Top = 216
  end
end
