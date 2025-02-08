object LMDAddSeriesDlg: TLMDAddSeriesDlg
  Left = 283
  Top = 181
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Add chart series'
  ClientHeight = 76
  ClientWidth = 241
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
    Left = 16
    Top = 16
    Width = 65
    Height = 13
    Caption = 'Series to add:'
  end
  object btCancel: TButton
    Left = 81
    Top = 46
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 0
  end
  object btOK: TButton
    Left = 159
    Top = 46
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 88
    Top = 16
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
  end
end
