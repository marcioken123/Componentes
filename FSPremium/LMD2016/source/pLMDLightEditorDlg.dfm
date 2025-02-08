object LMDLightEditorDlg: TLMDLightEditorDlg
  Left = 244
  Top = 123
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'LMDLight-Editor'
  ClientHeight = 176
  ClientWidth = 308
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 4
    Top = 92
    Width = 295
    Height = 8
    Shape = bsBottomLine
  end
  object test: TLMDLight
    Left = 68
    Top = 13
    Width = 164
    Height = 70
    OnClick = testClick
  end
  object Label4: TLabel
    Left = 7
    Top = 113
    Width = 50
    Height = 13
    Caption = '&LightColor:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object LMDSimpleLabel1: TLMDSimpleLabel
    Left = 7
    Top = 134
    Width = 205
    Height = 42
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    Caption = 
      'LightControl displays disabled Color by default. Click on contro' +
      'l to switch between enabled and disabled colors.'
    Options = []
  end
  object pred: TComboBox
    Left = 70
    Top = 106
    Width = 139
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = predChange
  end
  object btnOK: TButton
    Left = 229
    Top = 106
    Width = 70
    Height = 22
    Caption = 'OK'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 229
    Top = 131
    Width = 70
    Height = 22
    Cancel = True
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 2
  end
end
