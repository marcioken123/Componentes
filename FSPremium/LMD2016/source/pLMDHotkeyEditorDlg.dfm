object LMDfrmHotkeyEditor: TLMDfrmHotkeyEditor
  Left = 243
  Top = 294
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Hotkey-Editor'
  ClientHeight = 120
  ClientWidth = 354
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object LMDGroupBox1: TGroupBox
    Left = 7
    Top = 14
    Width = 337
    Height = 71
    Caption = 'Specify Hotkey...'
    TabOrder = 0
    object LMDSimpleLabel1: TLabel
      Left = 12
      Top = 35
      Width = 37
      Height = 13
      Caption = 'Hotkey:'
    end
    object edHotkey: THotKey
      Left = 69
      Top = 30
      Width = 257
      Height = 22
      HotKey = 0
      InvalidKeys = [hcNone]
      Modifiers = []
      TabOrder = 0
    end
  end
  object Button1: TButton
    Left = 110
    Top = 91
    Width = 70
    Height = 24
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 186
    Top = 91
    Width = 70
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
