object LMDfrmBarSelectIMLDlg: TLMDfrmBarSelectIMLDlg
  Left = 629
  Top = 757
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Select ImageList...'
  ClientHeight = 196
  ClientWidth = 266
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 179
    Top = 12
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 179
    Top = 42
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object ln: TComboBox
    Left = 15
    Top = 9
    Width = 155
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    OnChange = lnChange
  end
  object btnClear: TButton
    Left = 180
    Top = 90
    Width = 75
    Height = 25
    Caption = '&Clear'
    TabOrder = 3
    OnClick = btnClearClick
  end
  object lb: TLMDImageLBox
    Left = 15
    Top = 35
    Width = 154
    Height = 151
    ItemHeight = 16
    TabOrder = 4
  end
end
