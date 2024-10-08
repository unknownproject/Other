object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'AntiBlacklist by unknown project'
  ClientHeight = 513
  ClientWidth = 634
  Color = 7124735
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -9
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 11
  object Lst: TLabel
    Left = 8
    Top = 7
    Width = 528
    Height = 11
    Caption = 
      '                  Current proxy list                            ' +
      '                  BlackList                                     ' +
      '                    Result'
  end
  object Load1: TButton
    Left = 8
    Top = 464
    Width = 201
    Height = 19
    Caption = 'Load proxy'
    TabOrder = 0
    OnClick = Load1Click
  end
  object Load2: TButton
    Left = 215
    Top = 464
    Width = 201
    Height = 19
    Caption = 'Load blacklist'
    TabOrder = 1
    OnClick = Load2Click
  end
  object Compare: TButton
    Left = 8
    Top = 487
    Width = 201
    Height = 19
    Caption = 'Compare'
    TabOrder = 2
    OnClick = CompareClick
  end
  object Lst1: TEdit
    Left = 8
    Top = 439
    Width = 201
    Height = 17
    Alignment = taCenter
    Color = 12581355
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object lst2: TEdit
    Left = 215
    Top = 439
    Width = 202
    Height = 17
    Alignment = taCenter
    Color = 12581355
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object Current: TMemo
    Left = 8
    Top = 24
    Width = 201
    Height = 409
    Alignment = taCenter
    Color = 50688
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object Blacklist: TMemo
    Left = 215
    Top = 24
    Width = 202
    Height = 409
    Alignment = taCenter
    Color = clRed
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 6
  end
  object Result: TMemo
    Left = 423
    Top = 24
    Width = 202
    Height = 409
    Alignment = taCenter
    Color = 33023
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 7
  end
  object Sort: TButton
    Left = 423
    Top = 487
    Width = 201
    Height = 19
    Caption = 'Sort'
    TabOrder = 8
    OnClick = SortClick
  end
  object DuplicateKill: TButton
    Left = 215
    Top = 487
    Width = 201
    Height = 19
    Caption = 'Duplicate kill'
    TabOrder = 9
    OnClick = DuplicateKillClick
  end
  object RsltName: TEdit
    Left = 423
    Top = 439
    Width = 202
    Height = 17
    Alignment = taCenter
    Color = 12581355
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
  end
  object SaveResult: TButton
    Left = 423
    Top = 464
    Width = 201
    Height = 19
    Caption = 'Save Result'
    TabOrder = 11
    OnClick = SaveResultClick
  end
end
