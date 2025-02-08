object frmLMDRTFCharmapDialog: TfrmLMDRTFCharmapDialog
  Left = 348
  Top = 195
  BorderStyle = bsDialog
  Caption = 'Character map'
  ClientHeight = 303
  ClientWidth = 657
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblFont: TLabel
    Left = 12
    Top = 12
    Width = 27
    Height = 13
    Caption = 'Font :'
  end
  object lblCharSet: TLabel
    Left = 287
    Top = 12
    Width = 44
    Height = 13
    Caption = 'CharSet :'
    Visible = False
  end
  object CharTable: TPaintBox
    Left = 9
    Top = 32
    Width = 480
    Height = 264
    OnDblClick = CharTableDblClick
    OnMouseUp = CharTableMouseUp
    OnPaint = CharTablePaint
  end
  object CharZoom: TPaintBox
    Left = 522
    Top = 144
    Width = 123
    Height = 105
    OnPaint = CharZoomPaint
  end
  object cbCharSet: TComboBox
    Left = 352
    Top = 6
    Width = 154
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    Visible = False
    OnChange = cbFontChange
  end
  object ScrollBar: TScrollBar
    Left = 489
    Top = 32
    Width = 17
    Height = 264
    Kind = sbVertical
    PageSize = 0
    TabOrder = 1
    OnChange = CharTablePaint
  end
  object edSelChar: TEdit
    Left = 523
    Top = 255
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object btnOk: TButton
    Left = 548
    Top = 32
    Width = 75
    Height = 24
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 548
    Top = 61
    Width = 75
    Height = 24
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object btnHelp: TButton
    Left = 548
    Top = 98
    Width = 75
    Height = 24
    TabOrder = 5
    Visible = False
  end
  object cbFont: TLMDRichFontComboBox
    Left = 122
    Top = 7
    Width = 282
    Height = 21
    TabOrder = 6
    OnChange = cbFontChange
  end
end
