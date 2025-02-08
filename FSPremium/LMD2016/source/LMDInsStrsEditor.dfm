object LMDStringsEditorDialog: TLMDStringsEditorDialog
  Left = 245
  Top = 177
  ActiveControl = memMain
  BorderStyle = bsDialog
  ClientHeight = 260
  ClientWidth = 402
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
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
    Width = 386
    Height = 214
    Shape = bsFrame
  end
  object btnOk: TButton
    Left = 247
    Top = 231
    Width = 70
    Height = 24
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 322
    Top = 231
    Width = 70
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object memMain: TMemo
    Left = 15
    Top = 29
    Width = 370
    Height = 184
    ScrollBars = ssBoth
    TabOrder = 2
    WordWrap = False
    OnChange = memMainChange
  end
end
