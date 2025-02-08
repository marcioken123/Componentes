object fmDualEditDialog: TfmDualEditDialog
  Left = 0
  Top = 0
  Width = 320
  Height = 54
  TabOrder = 0
  DesignSize = (
    320
    54)
  object Value1Label: TLabel
    Left = 79
    Top = 6
    Width = 27
    Height = 13
    Alignment = taRightJustify
    Caption = 'Edit 1'
    FocusControl = eValue1
  end
  object Value2Label: TLabel
    Left = 79
    Top = 33
    Width = 27
    Height = 13
    Alignment = taRightJustify
    Caption = 'Edit 2'
    FocusControl = eValue2
  end
  object eValue2: TEdit
    Left = 112
    Top = 30
    Width = 205
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  object eValue1: TEdit
    Left = 112
    Top = 3
    Width = 205
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
end
