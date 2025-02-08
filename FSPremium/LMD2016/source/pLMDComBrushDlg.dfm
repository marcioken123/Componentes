object LMDComBrushEditorDlg: TLMDComBrushEditorDlg
  Left = 219
  Top = 150
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'TBrush-Editor'
  ClientHeight = 162
  ClientWidth = 301
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LMDDrawEdge1: TBevel
    Left = 6
    Top = 91
    Width = 212
    Height = 66
  end
  object Bevel1: TBevel
    Left = 7
    Top = 76
    Width = 288
    Height = 8
    Shape = bsBottomLine
  end
  object Label5: TLabel
    Left = 12
    Top = 102
    Width = 27
    Height = 13
    Caption = 'Color:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label1: TLabel
    Left = 12
    Top = 127
    Width = 26
    Height = 13
    Caption = 'Style:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object test: TShape
    Left = 70
    Top = 10
    Width = 147
    Height = 58
  end
  object btnColor: TSpeedButton
    Left = 184
    Top = 96
    Width = 23
    Height = 22
    Glyph.Data = {
      0E030000424D0E0300000000000036000000280000000D0000000E0000000100
      200000000000D802000000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000008080000080800000808000008080000080800000808000008080000000
      0000000000000000000000000000000000000080800000808000008080000080
      80000080800000808000008080000000000000FFFF00C0C0C00000FFFF00C0C0
      C00000FFFF000000000000000000008080000080800000808000008080000080
      800000000000C0C0C00000000000C0C0C00000FFFF00C0C0C00000FFFF00C0C0
      C00000000000008080000080800000808000008080000080800000000000FFFF
      000000000000C0C0C00000000000C0C0C00000FFFF0000000000008080000080
      8000008080000080800000000000C0C0C00000000000C0C0C000000000000000
      FF0000000000C0C0C00000FFFF00000000000080800000000000000000000000
      000000FFFF00C0C0C00000FFFF00C0C0C00000000000C0C0C00000FFFF00C0C0
      C000000000000000000000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0
      C00000FFFF00C0C0C00000000000C0C0C00000FFFF000000000000000000C0C0
      C000C0C0C00000000000C0C0C000C0C0C00000FFFF00C0C0C00000000000C0C0
      C00000000000C0C0C000000000000000000000FFFF0000000000800080000000
      0000C0C0C00000000000C0C0C000C0C0C00000000000C0C0C00000FFFF000000
      000000000000C0C0C000C0C0C00000000000C0C0C00000000000FF00FF000000
      000000FFFF00C0C0C00000FFFF0000000000008080000080800000000000C0C0
      C00000FFFF00C0C0C000C0C0C00000000000C0C0C000C0C0C00000FFFF000000
      000000808000008080000080800000808000000000000000000000FFFF00C0C0
      C00000FFFF00C0C0C00000000000000000000080800000808000008080000080
      8000008080000080800000808000000000000000000000000000000000000080
      800000808000008080000080800000808000}
    OnClick = btnColorClick
  end
  object cmb: TComboBox
    Left = 56
    Top = 125
    Width = 128
    Height = 21
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 0
    OnChange = cmbChange
  end
  object btnOK: TButton
    Left = 225
    Top = 93
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
    Left = 225
    Top = 120
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
  object cmbc: TLMDColorBox
    Left = 56
    Top = 97
    Width = 128
    Height = 22
    ItemHeight = 16
    TabOrder = 3
    OnChange = cmbcChange
  end
  object dlgColor: TColorDialog
    Ctl3D = True
    Left = 233
    Top = 27
  end
end
