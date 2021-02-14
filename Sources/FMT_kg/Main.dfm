object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'FlashMemoryToolkit KeyGen'
  ClientHeight = 67
  ClientWidth = 180
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -9
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 11
  object Key: TEdit
    Left = 8
    Top = 9
    Width = 129
    Height = 19
    Enabled = False
    TabOrder = 0
    Text = '1111111111111111'
  end
  object Gen: TButton
    Left = 32
    Top = 34
    Width = 75
    Height = 25
    Caption = 'Gen'
    TabOrder = 1
    OnClick = GenClick
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 8
    Top = 32
  end
end
