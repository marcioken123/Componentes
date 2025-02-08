object frmLMDSysOptionsEditor: TfrmLMDSysOptionsEditor
  Left = 796
  Top = 218
  Width = 342
  Height = 309
  ActiveControl = lb
  BorderIcons = [biSystemMenu]
  Caption = 'Select Options'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lb: TCheckListBox
    Left = 8
    Top = 6
    Width = 234
    Height = 259
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 0
  end
  object btnOK: TButton
    Left = 251
    Top = 6
    Width = 75
    Height = 25
    Anchors = [akRight]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 251
    Top = 37
    Width = 75
    Height = 25
    Anchors = [akRight]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnSelectAll: TButton
    Left = 251
    Top = 93
    Width = 75
    Height = 25
    Anchors = [akRight]
    Caption = 'Select &all'
    TabOrder = 3
    OnClick = btnSelectAllClick
  end
  object btnSelectNone: TButton
    Left = 251
    Top = 123
    Width = 75
    Height = 25
    Anchors = [akRight]
    Caption = '&Unselect all'
    TabOrder = 4
    OnClick = btnSelectAllClick
  end
end
