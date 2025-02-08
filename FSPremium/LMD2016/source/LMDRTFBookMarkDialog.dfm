object LMDRichfrmBookMarks: TLMDRichfrmBookMarks
  Left = 8
  Top = 8
  BorderStyle = bsDialog
  Caption = 'BookMarks'
  ClientHeight = 194
  ClientWidth = 231
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object FNameEditor: TEdit
    Left = 4
    Top = 4
    Width = 141
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    OnChange = FNameEditorChange
  end
  object FBookMarkList: TListBox
    Left = 12
    Top = 28
    Width = 133
    Height = 154
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 1
    OnClick = FBookMarkListClick
    OnDblClick = FBookMarkListDblClick
  end
  object btnNew: TButton
    Left = 152
    Top = 4
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'New'
    Default = True
    Enabled = False
    TabOrder = 2
    OnClick = btnNewClick
  end
  object btnDelete: TButton
    Left = 152
    Top = 32
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Delete'
    Enabled = False
    TabOrder = 3
    OnClick = btnDeleteClick
  end
  object btnSelect: TButton
    Left = 152
    Top = 60
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Select'
    Default = True
    Enabled = False
    TabOrder = 4
    OnClick = btnSelectClick
  end
  object btnClose: TButton
    Left = 152
    Top = 158
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Close'
    TabOrder = 5
    OnClick = btnCloseClick
  end
end
