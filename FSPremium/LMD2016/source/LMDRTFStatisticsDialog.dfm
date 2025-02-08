object LMDRTFStatisticsDlg: TLMDRTFStatisticsDlg
  Left = 8
  Top = 8
  BorderStyle = bsDialog
  Caption = 'Text statistics'
  ClientHeight = 195
  ClientWidth = 287
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poDefault
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 28
    Width = 269
    Height = 129
  end
  object Label1: TLabel
    Left = 8
    Top = 12
    Width = 48
    Height = 13
    Caption = 'Statistics :'
  end
  object Label2: TLabel
    Left = 16
    Top = 36
    Width = 30
    Height = 13
    Caption = 'Pages'
  end
  object Label3: TLabel
    Left = 16
    Top = 56
    Width = 31
    Height = 13
    Caption = 'Words'
  end
  object Label4: TLabel
    Left = 16
    Top = 76
    Width = 131
    Height = 13
    Caption = 'Characters (without spaces)'
  end
  object Label5: TLabel
    Left = 16
    Top = 96
    Width = 116
    Height = 13
    Caption = 'Characters (with spaces)'
  end
  object Label6: TLabel
    Left = 16
    Top = 116
    Width = 54
    Height = 13
    Caption = 'Paragraphs'
  end
  object Label7: TLabel
    Left = 16
    Top = 136
    Width = 25
    Height = 13
    Caption = 'Lines'
  end
  object lbPages: TLabel
    Left = 228
    Top = 36
    Width = 40
    Height = 13
    AutoSize = False
  end
  object lbWords: TLabel
    Left = 228
    Top = 56
    Width = 40
    Height = 13
    AutoSize = False
  end
  object lbChars1: TLabel
    Left = 228
    Top = 76
    Width = 40
    Height = 13
    AutoSize = False
  end
  object lbChars2: TLabel
    Left = 228
    Top = 96
    Width = 40
    Height = 13
    AutoSize = False
  end
  object lbPara: TLabel
    Left = 228
    Top = 116
    Width = 40
    Height = 13
    AutoSize = False
  end
  object lbLines: TLabel
    Left = 228
    Top = 136
    Width = 40
    Height = 13
    AutoSize = False
  end
  object Bevel2: TBevel
    Left = 172
    Top = 28
    Width = 13
    Height = 129
    Shape = bsLeftLine
  end
  object btnClose: TButton
    Left = 204
    Top = 164
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Close'
    Default = True
    ModalResult = 2
    TabOrder = 0
    OnClick = btnCloseClick
  end
end
