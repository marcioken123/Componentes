object LMDDBSearchFindForm: TLMDDBSearchFindForm
  Left = 545
  Top = 430
  ActiveControl = FindEdit
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Find'
  ClientHeight = 108
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object FindWhatLabel: TLabel
    Left = 9
    Top = 12
    Width = 49
    Height = 13
    Caption = 'Fi&nd what:'
  end
  object FindEdit: TEdit
    Left = 83
    Top = 8
    Width = 256
    Height = 21
    TabOrder = 0
  end
  object FindNextButton: TButton
    Left = 350
    Top = 43
    Width = 75
    Height = 25
    Caption = '&Find Next'
    Default = True
    TabOrder = 1
  end
  object CloseButton: TButton
    Left = 350
    Top = 73
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Close'
    ModalResult = 1
    TabOrder = 2
  end
  object BuildButton: TButton
    Left = 350
    Top = 6
    Width = 75
    Height = 25
    Caption = '&Build...'
    TabOrder = 3
  end
  object DirectionGroupBox: TGroupBox
    Left = 241
    Top = 38
    Width = 97
    Height = 60
    TabOrder = 4
    object UpRadioButton: TRadioButton
      Left = 8
      Top = 16
      Width = 41
      Height = 17
      Caption = '&Up'
      TabOrder = 0
    end
    object DownRadioButton: TRadioButton
      Left = 8
      Top = 35
      Width = 49
      Height = 17
      Caption = '&Down'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
  end
  object CriteriaGroupBox: TGroupBox
    Left = 83
    Top = 38
    Width = 140
    Height = 60
    Caption = 'Cr&iteria'
    TabOrder = 5
    object MathWholeCheckBox: TCheckBox
      Left = 6
      Top = 16
      Width = 129
      Height = 17
      Caption = 'Math &whole word only'
      TabOrder = 0
    end
    object MathCaseCheckBox: TCheckBox
      Left = 7
      Top = 35
      Width = 97
      Height = 17
      Caption = 'Match &case'
      TabOrder = 1
    end
  end
end
