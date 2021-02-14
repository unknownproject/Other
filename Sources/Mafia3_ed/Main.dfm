object MainForm: TMainForm
  Left = 0
  Top = 0
  ActiveControl = CheckSumBox
  BorderStyle = bsToolWindow
  Caption = 'Mafia 3 Savegame editor [Basic]'
  ClientHeight = 184
  ClientWidth = 220
  Color = 12711916
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clRed
  Font.Height = -9
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 11
  object MoneyBox: TGroupBox
    Left = 8
    Top = 0
    Width = 201
    Height = 57
    Caption = 'Money'
    TabOrder = 0
    object WalletLabel: TLabel
      Left = 38
      Top = 16
      Width = 31
      Height = 11
      Caption = 'Wallet'
    end
    object BankLabel: TLabel
      Left = 137
      Top = 16
      Width = 25
      Height = 11
      Caption = 'Bank'
    end
    object WalletEdit: TMemo
      Left = 8
      Top = 33
      Width = 90
      Height = 17
      Alignment = taCenter
      Color = 10412768
      Enabled = False
      Lines.Strings = (
        '00000000')
      MaxLength = 9
      TabOrder = 0
    end
    object BankEdit: TMemo
      Left = 104
      Top = 33
      Width = 90
      Height = 17
      Alignment = taCenter
      Color = 10412768
      Enabled = False
      Lines.Strings = (
        '00000000')
      MaxLength = 9
      TabOrder = 1
      WantReturns = False
    end
  end
  object CheckSumBox: TGroupBox
    Left = 8
    Top = 155
    Width = 202
    Height = 24
    TabOrder = 1
    object ChecksumLabel: TLabel
      Left = 86
      Top = 8
      Width = 56
      Height = 11
      Caption = 'Checksum: '
    end
    object ChecksumValue: TLabel
      Left = 141
      Top = 8
      Width = 56
      Height = 11
      Caption = '00000000'
    end
    object StatusLabel: TLabel
      Left = 5
      Top = 8
      Width = 63
      Height = 11
      Caption = 'Status: Iddle'
    end
  end
  object AmmoBox: TGroupBox
    Left = 8
    Top = 57
    Width = 201
    Height = 57
    Caption = 'Current ammo'
    TabOrder = 2
    object Ammo1Label: TLabel
      Left = 23
      Top = 15
      Width = 64
      Height = 11
      Caption = 'First weapon'
    end
    object Ammo2Label: TLabel
      Left = 110
      Top = 15
      Width = 76
      Height = 11
      Caption = 'Second weapon'
    end
    object Ammo1Edit: TMemo
      Left = 8
      Top = 32
      Width = 90
      Height = 17
      Alignment = taCenter
      Color = 10412768
      Enabled = False
      Lines.Strings = (
        '00000000')
      MaxLength = 2
      TabOrder = 0
      WantReturns = False
    end
    object Ammo2Edit: TMemo
      Left = 104
      Top = 32
      Width = 90
      Height = 17
      Alignment = taCenter
      Color = 10412768
      Enabled = False
      Lines.Strings = (
        '00000000')
      MaxLength = 2
      TabOrder = 1
    end
  end
  object MedBox: TGroupBox
    Left = 8
    Top = 115
    Width = 202
    Height = 41
    Caption = 'Medkits'
    TabOrder = 3
    object MedkitsEdit: TMemo
      Left = 8
      Top = 17
      Width = 185
      Height = 17
      Alignment = taCenter
      Color = 10412768
      Enabled = False
      Lines.Strings = (
        '00000000')
      TabOrder = 0
      WantReturns = False
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Mafia 3 SaveGames|*.sav'
    Left = 48
    Top = 39
  end
  object MainMenu: TMainMenu
    Left = 120
    Top = 40
    object File1: TMenuItem
      Caption = 'File'
      object Open1: TMenuItem
        Caption = 'Open'
        OnClick = Open1Click
      end
      object Save1: TMenuItem
        Caption = 'Save'
        Enabled = False
        OnClick = Save1Click
      end
    end
    object Checksum1: TMenuItem
      Caption = 'Checksum'
      object Get1: TMenuItem
        Caption = 'Get'
        Enabled = False
        OnClick = Get1Click
      end
      object Fix1: TMenuItem
        Caption = 'Fix'
        Enabled = False
        OnClick = Fix1Click
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object About1: TMenuItem
        Caption = 'About'
        OnClick = About1Click
      end
      object HowToUse1: TMenuItem
        Caption = 'How To Use'
        OnClick = HowToUse1Click
      end
    end
  end
  object OpenDialog2: TOpenDialog
    Filter = 'Mafia 3 SaveGames|*.sav'
    Left = 88
    Top = 40
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Mafia 3 SaveGames|*.sav'
    Left = 152
    Top = 40
  end
end
