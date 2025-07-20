object EqualizerSeriesEditor: TEqualizerSeriesEditor
  Left = 1629
  Top = 457
  Width = 249
  Height = 219
  Caption = 'EqualizerSeriesEditor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblDegradeInterval: TLabel
    Left = 48
    Top = 24
    Width = 79
    Height = 13
    Caption = 'DegradeInterval:'
  end
  object LblDownStep: TLabel
    Left = 74
    Top = 56
    Width = 53
    Height = 13
    Caption = 'DownStep:'
  end
  object UDDegradeInt: TUpDown
    Left = 169
    Top = 20
    Width = 16
    Height = 21
    HelpContext = 98
    Associate = edDegradeInt
    Min = 1
    Max = 5000
    Increment = 5
    Position = 1
    TabOrder = 0
  end
  object edDegradeInt: TEdit
    Left = 137
    Top = 20
    Width = 32
    Height = 21
    HelpContext = 98
    TabOrder = 1
    Text = '1'
    OnChange = edDegradeIntChange
  end
  object EdDownStep: TEdit
    Left = 137
    Top = 52
    Width = 48
    Height = 21
    HelpContext = 98
    TabOrder = 2
    Text = '1'
    OnChange = EdDownStepChange
  end
  object cbxDegradeHigh: TCheckBox
    Left = 88
    Top = 88
    Width = 97
    Height = 17
    Alignment = taLeftJustify
    Caption = 'DegradeHigh'
    TabOrder = 3
    OnClick = cbxDegradeHighClick
  end
end
