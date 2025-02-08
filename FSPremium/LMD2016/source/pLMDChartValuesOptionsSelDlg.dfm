object LMDChartValuesOptionsSelector: TLMDChartValuesOptionsSelector
  Left = 531
  Top = 383
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Chart values (data column) options'
  ClientHeight = 115
  ClientWidth = 408
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 15
    Width = 64
    Height = 13
    Caption = 'Column name'
  end
  object Label2: TLabel
    Left = 8
    Top = 49
    Width = 73
    Height = 13
    Caption = 'Column caption'
  end
  object lbFieldName: TLabel
    Left = 29
    Top = 85
    Width = 51
    Height = 13
    Caption = 'Field name'
    Visible = False
  end
  object btCancel: TButton
    Left = 249
    Top = 82
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 0
  end
  object btOK: TButton
    Left = 327
    Top = 82
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object RadioGroup1: TRadioGroup
    Left = 232
    Top = 8
    Width = 169
    Height = 65
    Caption = 'Value type'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Number'
      'Money'
      'Date(time)'
      'Label')
    TabOrder = 2
  end
  object edColCaption: TEdit
    Left = 88
    Top = 48
    Width = 137
    Height = 21
    TabOrder = 3
    Text = 'edColCaption'
  end
  object cbColName: TComboBox
    Left = 88
    Top = 13
    Width = 137
    Height = 21
    ItemHeight = 13
    TabOrder = 4
    Text = 'cbColName'
    Items.Strings = (
      'X Values'
      'X Labels'
      'Y Values'
      'Y Labels'
      'Z Values'
      'Z Labels')
  end
  object cbFieldName: TComboBox
    Left = 88
    Top = 82
    Width = 137
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 5
    Visible = False
    Items.Strings = (
      'X Values'
      'X Labels'
      'Y Values'
      'Y Labels'
      'Z Values'
      'Z Labels')
  end
end
