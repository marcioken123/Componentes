object frmLMDSysViewDlg: TfrmLMDSysViewDlg
  Left = 388
  Top = 287
  AutoScroll = False
  Caption = 'View Infos...'
  ClientHeight = 347
  ClientWidth = 631
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 544
    Top = 0
    Width = 87
    Height = 347
    Align = alRight
    Alignment = taRightJustify
    BevelOuter = bvNone
    TabOrder = 0
    object btnClose: TButton
      Left = 5
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Close'
      ModalResult = 2
      TabOrder = 0
    end
  end
  object lv: TLMDSysInfoListView
    Left = 0
    Top = 0
    Width = 544
    Height = 347
    Align = alClient
    TabOrder = 1
  end
end
