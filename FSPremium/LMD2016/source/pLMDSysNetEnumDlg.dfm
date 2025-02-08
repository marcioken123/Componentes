object frmLMDSysEnumDlg: TfrmLMDSysEnumDlg
  Left = 398
  Top = 168
  AutoScroll = False
  Caption = 'Browse Network...'
  ClientHeight = 335
  ClientWidth = 394
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
  object btnUpdate: TButton
    Left = 310
    Top = 7
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Update'
    TabOrder = 0
    OnClick = btnUpdateClick
  end
  object btnClose: TButton
    Left = 310
    Top = 36
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 1
  end
  object nettv: TLMDSysNetTreeView
    Left = 7
    Top = 6
    Width = 295
    Height = 320
    Anchors = [akLeft, akTop, akRight, akBottom]
    Indent = 19
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object nenum: TLMDSysNetworkEnumerator
    DisplayControl = nettv
    Left = 253
    Top = 38
  end
end
