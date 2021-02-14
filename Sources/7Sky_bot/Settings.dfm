object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsToolWindow
  Caption = 'Settings'
  ClientHeight = 100
  ClientWidth = 120
  Color = 33023
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -9
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 11
  object IntervalLabel: TLabel
    Left = 13
    Top = 8
    Width = 94
    Height = 11
    Caption = 'Interval [Seconds]'
  end
  object OKButton: TButton
    Left = 8
    Top = 82
    Width = 105
    Height = 15
    Caption = 'ok'
    TabOrder = 0
    OnClick = OKButtonClick
  end
  object IntervalEdit: TMemo
    Left = 8
    Top = 22
    Width = 105
    Height = 17
    Alignment = taCenter
    Color = 13565951
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 3618815
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Lines.Strings = (
      '60')
    ParentFont = False
    TabOrder = 1
    WantReturns = False
  end
  object FlooDInterval: TMemo
    Left = 8
    Top = 59
    Width = 105
    Height = 17
    Alignment = taCenter
    Lines.Strings = (
      '3')
    TabOrder = 2
    WantReturns = False
  end
  object PickEdit: TMemo
    Left = 8
    Top = 41
    Width = 105
    Height = 17
    Alignment = taCenter
    Lines.Strings = (
      '50')
    TabOrder = 3
  end
end
