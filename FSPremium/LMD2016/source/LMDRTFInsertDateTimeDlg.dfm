object frmLMDRichInsertDateTimeDlg: TfrmLMDRichInsertDateTimeDlg
  Left = 8
  Top = 8
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  ClientHeight = 179
  ClientWidth = 275
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Microsoft Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poDefault
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object AvailableFormatsLabel: TLabel
    Left = 8
    Top = 8
    Width = 3
    Height = 13
  end
  object ListBox: TListBox
    Left = 8
    Top = 25
    Width = 169
    Height = 145
    ItemHeight = 13
    TabOrder = 0
    OnClick = ListBoxClick
    OnDblClick = ListBoxDblClick
  end
  object btnOK: TButton
    Left = 190
    Top = 25
    Width = 75
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 190
    Top = 54
    Width = 75
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnHelp: TButton
    Left = 190
    Top = 97
    Width = 75
    Height = 24
    TabOrder = 3
    Visible = False
  end
end
