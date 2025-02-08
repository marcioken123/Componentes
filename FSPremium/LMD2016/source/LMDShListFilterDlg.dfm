object LMDfrmShellListFilterDialog: TLMDfrmShellListFilterDialog
  Left = 504
  Top = 403
  ActiveControl = hcb
  BorderIcons = []
  BorderStyle = bsDialog
  ClientHeight = 195
  ClientWidth = 306
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 221
    Top = 17
    Width = 75
    Height = 24
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 221
    Top = 46
    Width = 75
    Height = 24
    Cancel = True
    ModalResult = 2
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 11
    Top = 12
    Width = 203
    Height = 75
    TabOrder = 2
    object Label1: TLabel
      Left = 10
      Top = 43
      Width = 185
      Height = 26
      AutoSize = False
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      WordWrap = True
    end
    object hcb: TComboBox
      Left = 11
      Top = 18
      Width = 179
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object rg: TRadioGroup
    Left = 10
    Top = 101
    Width = 203
    Height = 86
    TabOrder = 3
  end
end
