object AboutBox: TAboutBox
  Left = 200
  Top = 108
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 77
  ClientWidth = 210
  Color = 15724527
  Ctl3D = False
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clRed
  Font.Height = -9
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = True
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 11
  object Info: TMemo
    Left = 8
    Top = 8
    Width = 194
    Height = 65
    Alignment = taCenter
    Color = 14024682
    Lines.Strings = (
      'Coded by unknownproject'
      'Skype: Unknownproject'
      'ICQ: 9277601'
      'Email/Jabber: '
      'nknwn.project@gmail.com')
    ReadOnly = True
    TabOrder = 0
  end
end
