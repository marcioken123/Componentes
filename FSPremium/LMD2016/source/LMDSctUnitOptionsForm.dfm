object LMDUnitOptionsFrm: TLMDUnitOptionsFrm
  Left = 312
  Top = 215
  BorderStyle = bsSingle
  Caption = 'Options'
  ClientHeight = 157
  ClientWidth = 358
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 106
  TextHeight = 15
  object Bevel1: TBevel
    Left = 9
    Top = 9
    Width = 337
    Height = 104
    Shape = bsFrame
  end
  object Button1: TButton
    Left = 181
    Top = 121
    Width = 81
    Height = 27
    Caption = 'Ok'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 267
    Top = 121
    Width = 81
    Height = 27
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object cbIsSysLibDoc: TCheckBox
    Left = 26
    Top = 34
    Width = 302
    Height = 19
    Caption = 'Is system library unit'
    TabOrder = 2
  end
  object cbIsLocked: TCheckBox
    Left = 26
    Top = 60
    Width = 311
    Height = 19
    Caption = 'Is locked'
    TabOrder = 3
  end
end
