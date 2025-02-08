object LMDSysStringsDialog: TLMDSysStringsDialog
  Left = 245
  Top = 177
  Width = 538
  Height = 346
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
  object bvlMain: TBevel
    Left = 9
    Top = 8
    Width = 512
    Height = 267
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
  end
  object btnOk: TButton
    Left = 446
    Top = 280
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object memMain: TRichEdit
    Left = 15
    Top = 15
    Width = 496
    Height = 250
    Anchors = [akLeft, akTop, akRight, akBottom]
    HideScrollBars = False
    PlainText = True
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
end
