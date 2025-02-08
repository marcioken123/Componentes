object LMDRichfrmTabs: TLMDRichfrmTabs
  Left = 8
  Top = 8
  Anchors = [akTop]
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Tabs'
  ClientHeight = 216
  ClientWidth = 213
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poDefault
  Scaled = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object labTabPosition: TLabel
    Left = 4
    Top = 8
    Width = 66
    Height = 13
    Caption = 'Tab positions:'
  end
  object Bevel1: TBevel
    Left = 4
    Top = 180
    Width = 204
    Height = 9
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsTopLine
  end
  object ListBox: TListBox
    Left = 12
    Top = 48
    Width = 113
    Height = 125
    ItemHeight = 13
    TabOrder = 1
    OnClick = ListBoxClick
  end
  object btnSet: TButton
    Left = 133
    Top = 24
    Width = 70
    Height = 21
    Caption = 'Set'
    TabOrder = 2
    OnClick = btnSetClick
  end
  object btnDelete: TButton
    Left = 133
    Top = 49
    Width = 70
    Height = 21
    Caption = 'Delete'
    TabOrder = 3
    OnClick = btnDeleteClick
  end
  object btnDeleteAll: TButton
    Left = 133
    Top = 75
    Width = 70
    Height = 21
    Caption = 'Delete All'
    TabOrder = 4
    OnClick = btnDeleteAllClick
  end
  object btnCancel: TButton
    Left = 135
    Top = 188
    Width = 75
    Height = 22
    Anchors = [akTop, akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object btnOK: TButton
    Left = 55
    Top = 188
    Width = 75
    Height = 22
    Anchors = [akTop, akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 5
  end
  object MaskEdit: TMaskEdit
    Left = 4
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 0
    OnChange = MaskEditChange
    OnKeyPress = MaskEditKeyPress
  end
end
