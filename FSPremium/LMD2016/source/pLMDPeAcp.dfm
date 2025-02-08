object LMDAniClipEditorDlg: TLMDAniClipEditorDlg
  Left = 624
  Top = 239
  ActiveControl = OK
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'AniClip-Editor'
  ClientHeight = 304
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 5
    Top = 6
    Width = 380
    Height = 291
  end
  object OK: TBitBtn
    Left = 392
    Top = 5
    Width = 84
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = OKClick
    Kind = bkOK
    Margin = 2
    Spacing = -1
  end
  object Cancel: TBitBtn
    Left = 392
    Top = 35
    Width = 84
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
  object book: TNotebook
    Left = 6
    Top = 7
    Width = 378
    Height = 270
    PageIndex = 1
    TabOrder = 2
    OnMouseMove = bookMouseMove
    object TPage
      Left = 0
      Top = 0
      Caption = 'Clip'
      object Label3: TLabel
        Left = 6
        Top = 225
        Width = 31
        Height = 13
        Caption = 'Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 6
        Top = 247
        Width = 29
        Height = 13
        Caption = 'Index:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 137
        Top = 226
        Width = 3
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 138
        Top = 248
        Width = 3
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object start: TLabel
        Left = 231
        Top = 227
        Width = 31
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0'
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object ende: TLabel
        Left = 231
        Top = 248
        Width = 31
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0'
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Bevel2: TBevel
        Left = 6
        Top = 18
        Width = 365
        Height = 200
      end
      object info: TLabel
        Left = 6
        Top = 5
        Width = 17
        Height = 13
        Caption = 'info'
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object ScrollBox1: TScrollBox
        Left = 7
        Top = 19
        Width = 363
        Height = 198
        TabOrder = 0
        OnMouseMove = bookMouseMove
        object img: TImage
          Left = 0
          Top = 0
          Width = 106
          Height = 35
          Cursor = crUpArrow
          AutoSize = True
          ParentShowHint = False
          ShowHint = True
          OnMouseDown = imgMouseDown
          OnMouseMove = imgMouseMove
        end
      end
      object name: TEdit
        Left = 44
        Top = 222
        Width = 75
        Height = 21
        MaxLength = 24
        TabOrder = 1
      end
      object index: TEdit
        Left = 44
        Top = 245
        Width = 75
        Height = 21
        MaxLength = 5
        TabOrder = 2
      end
      object bt: TButton
        Left = 300
        Top = 221
        Width = 57
        Height = 20
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = btClick
      end
      object bt1: TButton
        Left = 300
        Top = 244
        Width = 57
        Height = 20
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = btClick
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'List'
      object Label2: TLabel
        Left = 11
        Top = 234
        Width = 3
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object breite: TLabel
        Left = 69
        Top = 234
        Width = 50
        Height = 13
        AutoSize = False
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label1: TLabel
        Left = 11
        Top = 248
        Width = 3
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object hoehe: TLabel
        Left = 69
        Top = 248
        Width = 50
        Height = 13
        AutoSize = False
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label7: TLabel
        Left = 125
        Top = 248
        Width = 3
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 125
        Top = 234
        Width = 3
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object row: TLabel
        Left = 172
        Top = 234
        Width = 50
        Height = 13
        AutoSize = False
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object cols: TLabel
        Left = 172
        Top = 248
        Width = 50
        Height = 13
        AutoSize = False
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object bt2: TButton
        Left = 244
        Top = 239
        Width = 60
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btClick
      end
      object header: THeader
        Left = 5
        Top = 6
        Width = 366
        Height = 21
        Sections.Sections = (
          #0'55'#0'FrameNr'
          #0'53'#0'StartPic'
          #0'48'#0'EndPic'
          #0'40'#0'Name')
        TabOrder = 0
        OnSized = headerSized
      end
      object lb: TListBox
        Left = 5
        Top = 27
        Width = 364
        Height = 148
        Style = lbOwnerDrawFixed
        IntegralHeight = True
        ItemHeight = 16
        MultiSelect = True
        Sorted = True
        TabOrder = 1
        OnDrawItem = lbDrawItem
      end
      object bt3: TButton
        Left = 309
        Top = 239
        Width = 60
        Height = 24
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = btClick
      end
    end
  end
  object tab: TTabSet
    Left = 6
    Top = 276
    Width = 378
    Height = 19
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Tabs.Strings = (
      'Clip'
      'List')
    TabIndex = 0
    OnChange = tabChange
  end
  object Load: TButton
    Left = 393
    Top = 166
    Width = 84
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = LoadClick
  end
  object Save: TButton
    Left = 393
    Top = 192
    Width = 84
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = SaveClick
  end
  object loadclip: TButton
    Left = 393
    Top = 98
    Width = 84
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = loadclipClick
  end
  object clear: TButton
    Left = 393
    Top = 218
    Width = 84
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = clearClick
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'bmp'
    FileName = '*.pcl'
    Options = [ofOverwritePrompt, ofHideReadOnly]
    Left = 397
    Top = 267
  end
  object FileDialog: TOpenDialog
    DefaultExt = 'bmp'
    FileName = '*.pcl'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist]
    Left = 425
    Top = 268
  end
end
