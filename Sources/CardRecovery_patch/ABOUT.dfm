object AboutBox: TAboutBox
  Left = 200
  Top = 108
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 125
  ClientWidth = 161
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 145
    Height = 81
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 0
    object ProductName: TLabel
      Left = 31
      Top = 8
      Width = 74
      Height = 13
      Caption = 'CardRecovery  '
      IsControl = True
    end
    object Version: TLabel
      Left = 25
      Top = 27
      Width = 80
      Height = 13
      Caption = 'v5.30 Build 1206'
      IsControl = True
    end
    object Copyright: TLabel
      Left = 9
      Top = 46
      Width = 123
      Height = 13
      Caption = 'patch by unknown project'
      IsControl = True
    end
  end
  object OKButton: TButton
    Left = 42
    Top = 95
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = OKButtonClick
  end
end
