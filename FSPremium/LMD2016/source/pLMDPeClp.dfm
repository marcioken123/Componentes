object lmdClipEditorDlg: TlmdClipEditorDlg
  Left = 206
  Top = 169
  ActiveControl = OK
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Clip-Editor'
  ClientHeight = 246
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 7
    Top = 4
    Width = 392
    Height = 201
    Shape = bsFrame
  end
  object Shape1: TShape
    Left = 12
    Top = 12
    Width = 309
    Height = 188
    Brush.Style = bsClear
  end
  object Shape2: TShape
    Left = 13
    Top = 13
    Width = 307
    Height = 186
    Brush.Style = bsClear
    Pen.Color = clWhite
  end
  object Label2: TLabel
    Left = 327
    Top = 149
    Width = 5
    Height = 13
  end
  object Label1: TLabel
    Left = 327
    Top = 175
    Width = 5
    Height = 13
  end
  object breite: TLabel
    Left = 327
    Top = 161
    Width = 50
    Height = 13
    AutoSize = False
    Caption = '150'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object hoehe: TLabel
    Left = 327
    Top = 187
    Width = 50
    Height = 13
    AutoSize = False
    Caption = 'size'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label3: TLabel
    Left = 7
    Top = 219
    Width = 3
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 110
    Top = 220
    Width = 3
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object OK: TBitBtn
    Left = 231
    Top = 212
    Width = 82
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Kind = bkOK
    Margin = 2
    Spacing = -1
  end
  object Cancel: TBitBtn
    Left = 317
    Top = 212
    Width = 82
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Kind = bkCancel
    Margin = 2
    Spacing = -1
  end
  object Load: TButton
    Left = 328
    Top = 12
    Width = 60
    Height = 19
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = LoadPClick
  end
  object Save: TButton
    Left = 328
    Top = 32
    Width = 60
    Height = 19
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = SavePClick
  end
  object Clear: TButton
    Left = 328
    Top = 52
    Width = 60
    Height = 19
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = ClearClick
  end
  object test: TButton
    Left = 328
    Top = 124
    Width = 60
    Height = 19
    Caption = '&Test'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = testClick
  end
  object rows: TComboBox
    Left = 48
    Top = 215
    Width = 50
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 6
    OnChange = cmbChange
  end
  object cols: TComboBox
    Left = 153
    Top = 215
    Width = 50
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 7
    OnChange = cmbChange
  end
  object lbitmap: TButton
    Left = 328
    Top = 77
    Width = 60
    Height = 19
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = LoadClick
  end
  object sbitmap: TButton
    Left = 328
    Top = 97
    Width = 60
    Height = 19
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = SaveClick
  end
  object FileDialog: TOpenDialog
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist]
    Left = 268
    Top = 7
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly]
    Left = 236
    Top = 9
  end
end
