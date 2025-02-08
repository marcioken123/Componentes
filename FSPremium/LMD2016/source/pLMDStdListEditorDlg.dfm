object LMDStdListEditorDlg: TLMDStdListEditorDlg
  Left = 350
  Top = 186
  Width = 541
  Height = 427
  Anchors = [akRight, akBottom]
  BorderIcons = [biSystemMenu]
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  Scaled = False
  ShowHint = True
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 14
  object pnlMain: TPanel
    Left = 0
    Top = 31
    Width = 533
    Height = 342
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object header: THeaderControl
      Left = 0
      Top = 0
      Width = 533
      Height = 23
      Enabled = False
      Sections = <>
    end
    object lb: TListBox
      Left = 0
      Top = 23
      Width = 533
      Height = 282
      Style = lbOwnerDrawFixed
      Align = alClient
      ItemHeight = 16
      PopupMenu = pop
      TabOrder = 1
      OnClick = lbClick
      OnDblClick = lbDblClick
      OnDrawItem = lbDrawItem
    end
    object Panel1: TPanel
      Left = 0
      Top = 305
      Width = 533
      Height = 37
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object btnOk: TButton
        Left = 362
        Top = 7
        Width = 75
        Height = 24
        Anchors = [akRight, akBottom]
        Caption = 'OK'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ModalResult = 1
        ParentFont = False
        TabOrder = 0
      end
      object btnCancel: TButton
        Left = 441
        Top = 7
        Width = 75
        Height = 24
        Anchors = [akRight, akBottom]
        Cancel = True
        Caption = 'Cancel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ModalResult = 2
        ParentFont = False
        TabOrder = 1
        OnClick = fileactionClick
      end
    end
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 533
    Height = 31
    AutoSize = True
    Bands = <
      item
        Control = ToolBar1
        FixedBackground = False
        ImageIndex = -1
        MinHeight = 31
        Width = 533
      end>
    EdgeBorders = []
    object ToolBar1: TToolBar
      Left = 9
      Top = 0
      Width = 520
      Height = 31
      Align = alNone
      ButtonHeight = 26
      ButtonWidth = 32
      EdgeBorders = []
      Images = LMDActionsData.Icons
      TabOrder = 0
      Wrapable = False
      object btnLoad: TToolButton
        Left = 0
        Top = 2
        Hint = 'Open List'
        ImageIndex = 0
        Style = tbsDropDown
        OnClick = fileactionClick
      end
      object btnSave: TToolButton
        Left = 45
        Top = 2
        Hint = 'Save List'
        ImageIndex = 1
        OnClick = fileactionClick
      end
      object clear: TToolButton
        Left = 77
        Top = 2
        Hint = 'Clear List'
        ImageIndex = 2
        OnClick = PopupClick
      end
      object ToolButton3: TToolButton
        Left = 109
        Top = 2
        Width = 8
        Caption = 'ToolButton3'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object btnCut: TToolButton
        Left = 117
        Top = 2
        ImageIndex = 3
        OnClick = PopupClick
      end
      object btnCopy: TToolButton
        Left = 149
        Top = 2
        Caption = 'btnCopy'
        ImageIndex = 4
        OnClick = PopupClick
      end
      object btnPaste: TToolButton
        Left = 181
        Top = 2
        Caption = 'btnSave'
        ImageIndex = 5
        OnClick = PopupClick
      end
      object ToolButton7: TToolButton
        Left = 213
        Top = 2
        Width = 8
        Caption = 'ToolButton7'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object add: TToolButton
        Left = 221
        Top = 2
        Hint = 'Add new item'
        Caption = 'add'
        ImageIndex = 6
        OnClick = PopupClick
      end
      object addfast: TToolButton
        Left = 253
        Top = 2
        Hint = 'Add one or multiple items'
        Caption = 'addfast'
        ImageIndex = 7
        OnClick = PopupClick
      end
      object remove: TToolButton
        Left = 285
        Top = 2
        Hint = 'Remove item'
        ImageIndex = 8
        OnClick = PopupClick
      end
      object ToolButton1: TToolButton
        Left = 317
        Top = 2
        Width = 8
        Caption = 'ToolButton1'
        ImageIndex = 12
        Style = tbsSeparator
      end
      object up: TToolButton
        Left = 325
        Top = 2
        Hint = 'Move item up'
        ImageIndex = 9
        OnClick = PopupClick
      end
      object down: TToolButton
        Left = 357
        Top = 2
        Hint = 'Move item down'
        Caption = 'down'
        ImageIndex = 10
        OnClick = PopupClick
      end
      object btnMultiSelect: TToolButton
        Left = 389
        Top = 2
        Hint = 'Switch MultiSelect mode'
        Caption = 'test'
        ImageIndex = 11
        Style = tbsCheck
        OnClick = PopupClick
      end
      object ToolButton4: TToolButton
        Left = 421
        Top = 2
        Width = 8
        Caption = 'ToolButton4'
        ImageIndex = 13
        Style = tbsSeparator
      end
      object btnProp: TToolButton
        Left = 429
        Top = 2
        Hint = 'Display item properties'
        ImageIndex = 17
        OnClick = PopupClick
      end
      object playdiv: TToolButton
        Left = 461
        Top = 2
        Width = 8
        Caption = 'playdiv'
        ImageIndex = 13
        ParentShowHint = False
        ShowHint = False
        Style = tbsSeparator
        Visible = False
      end
      object play: TToolButton
        Left = 469
        Top = 2
        Hint = 'Play Wave'
        ImageIndex = 16
        Visible = False
        OnClick = PopupClick
      end
    end
  end
  object FileDialog: TOpenDialog
    DefaultExt = 'wvl'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist]
    Left = 90
    Top = 126
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly]
    Left = 62
    Top = 126
  end
  object fm: TLMDFMDrop
    Control = lb
    OnFMDragDrop = fmFMDragDrop
    Left = 109
    Top = 259
  end
  object pop: TPopupMenu
    Images = LMDActionsData.Icons
    OnPopup = PopupClick
    Left = 62
    Top = 71
    object Play1: TMenuItem
      Caption = '&Play'
      Visible = False
      OnClick = PopupClick
    end
    object N8: TMenuItem
      Caption = '-'
      Visible = False
    end
    object Add1: TMenuItem
      Caption = '&Add'
      ImageIndex = 6
      ShortCut = 16429
      OnClick = PopupClick
    end
    object Remove1: TMenuItem
      Caption = '&Remove'
      ImageIndex = 8
      ShortCut = 16430
      OnClick = PopupClick
    end
    object Clear1: TMenuItem
      Caption = '&Clear'
      ImageIndex = 2
      OnClick = PopupClick
    end
    object N1: TMenuItem
      Caption = '-'
      OnClick = PopupClick
    end
    object Up1: TMenuItem
      Caption = '&Up'
      ImageIndex = 9
      ShortCut = 16469
      OnClick = PopupClick
    end
    object Down1: TMenuItem
      Caption = '&Down'
      ImageIndex = 10
      ShortCut = 16452
      OnClick = PopupClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object prop: TMenuItem
      Caption = '&Properties'
      OnClick = PopupClick
    end
  end
  object MainMenu1: TMainMenu
    Images = LMDActionsData.Icons
    Left = 99
    Top = 73
    object File1: TMenuItem
      Caption = '&File'
      SubMenuImages = LMDActionsData.Icons
      object mnuLoad: TMenuItem
        Caption = '&Load List...'
        ImageIndex = 0
        OnClick = fileactionClick
      end
      object mnuSave: TMenuItem
        Caption = '&Save List...'
        ImageIndex = 1
        OnClick = fileactionClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object bmp2iml: TMenuItem
        Caption = 'Add items from Bitmap...'
        Visible = False
        OnClick = fileactionClick
      end
      object avi2iml: TMenuItem
        Caption = 'Add Items from AVI...'
        Visible = False
        OnClick = fileactionClick
      end
      object saveasbmp: TMenuItem
        Caption = 'Save Item as Bitmap...'
        Visible = False
        OnClick = fileactionClick
      end
      object cline: TMenuItem
        Caption = '-'
        Visible = False
      end
      object Quit1: TMenuItem
        Caption = '&Quit'
        OnClick = fileactionClick
      end
      object quit2: TMenuItem
        Caption = 'Quit and &Cancel'
        OnClick = fileactionClick
      end
    end
    object Edit1: TMenuItem
      Caption = '&Edit'
      object mnuCut: TMenuItem
        Caption = '&Cut'
        ImageIndex = 3
        ShortCut = 16472
        OnClick = PopupClick
      end
      object mnuCopy: TMenuItem
        Caption = '&Copy'
        ImageIndex = 4
        ShortCut = 16451
        OnClick = PopupClick
      end
      object mnuPaste: TMenuItem
        Caption = '&Paste'
        ImageIndex = 5
        ShortCut = 16470
        OnClick = PopupClick
      end
      object mnuDelete: TMenuItem
        Caption = '&Delete'
        ImageIndex = 8
        ShortCut = 16430
        OnClick = PopupClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Up2: TMenuItem
        Caption = '&Up'
        ImageIndex = 9
        ShortCut = 16469
        OnClick = PopupClick
      end
      object down2: TMenuItem
        Caption = '&Down'
        ImageIndex = 10
        ShortCut = 16452
        OnClick = PopupClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object mnuSelectAll: TMenuItem
        Caption = 'Select &All'
        ShortCut = 16449
        OnClick = PopupClick
      end
      object ClearAll1: TMenuItem
        Caption = 'Clear All'
        ImageIndex = 2
        OnClick = PopupClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object Properties1: TMenuItem
        Caption = '&Properties'
        OnClick = PopupClick
      end
    end
    object Tools1: TMenuItem
      Caption = '&Tools'
      object mnuAddFromFile: TMenuItem
        Caption = 'Add Items from List...'
        Visible = False
        OnClick = fileactionClick
      end
      object comp: TMenuItem
        Caption = 'Compressed &Status'
        object checkall: TMenuItem
          Caption = 'Check all'
          OnClick = PopupClick
        end
        object UnCheckAll: TMenuItem
          Caption = 'UnCheckAll'
          OnClick = PopupClick
        end
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object mnuMulti: TMenuItem
        Caption = '&MultiLine Mode'
        OnClick = PopupClick
      end
    end
  end
  object ini: TLMDIniCtrl
    Target = itRegistry
    Left = 69
    Top = 261
  end
  object mru: TLMDBaseMRUList
    MaxLength = 48
    Options = [moShowAccel, moSubIfEmpty, moSubClearOption]
    IniLink = ini
    IniUse = ioUseLink
    Section = 'PathList'
    ToolButton = btnLoad
    OnClick = mruClick
    OnClearListClick = PopupClick
    Left = 70
    Top = 291
  end
  object fp: TLMDFormPersistent
    IniLink = ini
    IniUse = ioUseLink
    Section = 'Data'
    IniKey = 'LMDStdListEditorDlg'
    Options = [foAutoCenter]
    TrackMinHeight = 427
    TrackMinWidth = 541
    Left = 112
    Top = 292
  end
end
