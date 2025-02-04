object Form2: TForm2
  Left = 27
  Top = 107
  Width = 580
  Height = 322
  Caption = 'CabDecompressor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 5
    Top = 10
    Width = 73
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 5
    Top = 37
    Width = 564
    Height = 92
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Memo2: TMemo
    Left = 4
    Top = 170
    Width = 565
    Height = 92
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object Button2: TButton
    Left = 7
    Top = 141
    Width = 73
    Height = 25
    Caption = 'Start'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 83
    Top = 10
    Width = 73
    Height = 25
    Caption = 'Abort'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 84
    Top = 141
    Width = 73
    Height = 25
    Caption = 'Abort'
    TabOrder = 5
    OnClick = Button4Click
  end
  object ProgressBar1: TProgressBar
    Left = 160
    Top = 13
    Width = 407
    Height = 17
    Min = 0
    Max = 100
    TabOrder = 6
  end
  object ProgressBar2: TProgressBar
    Left = 162
    Top = 146
    Width = 407
    Height = 17
    Min = 0
    Max = 100
    TabOrder = 7
  end
  object CabDecompressor1: TCabDecompressor
    OnBeginDecompression = CabDecompressor1BeginDecompression
    OnEndDecompression = CabDecompressor1EndDecompression
    BeforeCopyFile = CabDecompressor1BeforeCopyFile
    AfterCopyFile = CabDecompressor1AfterCopyFile
    OnStatusChange = CabDecompressor1StatusChange
    Left = 477
    Top = 264
  end
  object CabDecompressor2: TCabDecompressor
    OnStatusChange = CabDecompressor2StatusChange
    Left = 509
    Top = 264
  end
end
