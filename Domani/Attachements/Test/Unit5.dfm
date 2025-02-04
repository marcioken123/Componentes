object Form1: TForm1
  Left = 103
  Top = 155
  BorderStyle = bsSingle
  Caption = 'CabCompressor'
  ClientHeight = 381
  ClientWidth = 524
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
    Left = 8
    Top = 3
    Width = 46
    Height = 22
    Caption = 'Start'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 2
    Top = 32
    Width = 520
    Height = 105
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object ProgressBar1: TProgressBar
    Left = 114
    Top = 5
    Width = 407
    Height = 17
    TabOrder = 2
  end
  object Button2: TButton
    Left = 58
    Top = 3
    Width = 49
    Height = 22
    Caption = 'Abort'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Memo2: TMemo
    Left = -1
    Top = 176
    Width = 520
    Height = 121
    Lines.Strings = (
      '')
    ScrollBars = ssBoth
    TabOrder = 4
  end
  object Button3: TButton
    Left = 5
    Top = 147
    Width = 49
    Height = 22
    Caption = 'Start'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 58
    Top = 147
    Width = 49
    Height = 22
    Caption = 'Abort'
    TabOrder = 6
    OnClick = Button4Click
  end
  object ProgressBar2: TProgressBar
    Left = 112
    Top = 149
    Width = 407
    Height = 17
    TabOrder = 7
  end
  object Edit1: TEdit
    Left = 3
    Top = 301
    Width = 57
    Height = 21
    TabOrder = 8
    Text = '0'
  end
  object Edit2: TEdit
    Left = 69
    Top = 301
    Width = 57
    Height = 21
    TabOrder = 9
    Text = '0'
  end
  object CabCompressor1: TCabCompressor
    OnBeginCompression = CabCompressor1BeginCompression
    OnEndCompression = CabCompressor1EndCompression
    OnPlaceFile = CabCompressor1PlaceFile
    OnOpenFile = CabCompressor1OpenFile
    OnReadFile = CabCompressor1ReadFile
    OnSeekFile = CabCompressor1SeekFile
    OnWriteFile = CabCompressor1WriteFile
    OnGetTempFile = CabCompressor1GetTempFile
    OnCloseFile = CabCompressor1CloseFile
    OnDeleteFile = CabCompressor1DeleteFile
    OnStatusChange = CabCompressor1StatusChange
    OnGetNextCab = CabCompressor1GetNextCab
    Left = 461
    Top = 300
  end
  object CabCompressor2: TCabCompressor
    OnCloseFile = CabCompressor2CloseFile
    OnStatusChange = CabCompressor2StatusChange
    Left = 493
    Top = 300
  end
end
