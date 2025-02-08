object LMDFrmWideStringsEditor: TLMDFrmWideStringsEditor
  Left = 377
  Top = 225
  Width = 411
  Height = 309
  BorderIcons = []
  Caption = 'Wide String List Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object lbLineCount: TLabel
    Left = 11
    Top = 11
    Width = 158
    Height = 16
    AutoSize = False
    Caption = '0 lines'
  end
  object bvlMain: TBevel
    Left = 7
    Top = 7
    Width = 387
    Height = 227
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
  end
  object btnOk: TButton
    Left = 248
    Top = 244
    Width = 70
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 323
    Top = 244
    Width = 70
    Height = 24
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object pnlMain: TPanel
    Left = 15
    Top = 29
    Width = 371
    Height = 197
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 2
  end
end
