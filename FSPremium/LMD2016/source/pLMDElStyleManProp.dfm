object frmLMDElStyleManProp: TfrmLMDElStyleManProp
  Left = 609
  Top = 194
  Width = 480
  Height = 466
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Style editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TElPanel
    Left = 0
    Top = 397
    Width = 472
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DockOrientation = doNoOrient
    DesignSize = (
      472
      35)
    object OkButton: TElPopupButton
      Left = 304
      Top = 5
      Width = 74
      Height = 25
      ModalResult = 1
      Caption = 'OK'
      TabOrder = 0
      Anchors = [akTop, akRight]
    end
    object CancelButton: TElPopupButton
      Left = 383
      Top = 5
      Width = 76
      Height = 25
      Cancel = True
      ModalResult = 2
      Caption = 'Cancel'
      TabOrder = 1
      Anchors = [akTop, akRight]
    end
    object ElPopupButton1: TElPopupButton
      Left = 224
      Top = 5
      Width = 74
      Height = 25
      Caption = 'Apply'
      TabOrder = 2
      OnClick = ElPopupButton1Click
      Anchors = [akTop, akRight]
    end
  end
  object ElToolBar1: TElToolBar
    Left = 0
    Top = 0
    Width = 472
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    BtnOffsHorz = 0
    BtnOffsVert = 0
    ShowCaption = True
    DockOrientation = doNoOrient
    DoubleBuffered = False
    object btnLoadFromFile: TElToolButton
      Left = 0
      Top = 0
      Width = 75
      Height = 24
      Caption = 'Load from file'
      OnClick = LoadClick
      ButtonID = 0
    end
    object btnSaveToFile: TElToolButton
      Left = 75
      Top = 0
      Width = 65
      Height = 24
      Caption = 'Save to file'
      OnClick = SaveClick
      ButtonID = 0
    end
    object ElToolButton3: TElToolButton
      Left = 140
      Top = 0
      Width = 6
      Height = 24
      ButtonType = ebtSeparator
      Enabled = False
      ButtonID = 0
    end
    object btnAddStyle: TElToolButton
      Left = 146
      Top = 0
      Width = 55
      Height = 24
      Caption = 'Add style'
      OnClick = btnAddStyleClick
      ButtonID = 0
    end
    object btnAddProp: TElToolButton
      Left = 201
      Top = 0
      Width = 72
      Height = 24
      Caption = 'Add property'
      Enabled = False
      OnClick = btnAddPropClick
      ButtonID = 0
    end
    object btnDelete: TElToolButton
      Left = 279
      Top = 0
      Width = 43
      Height = 24
      Caption = 'Delete'
      Enabled = False
      OnClick = btnDeleteClick
      ButtonID = 0
    end
    object ElToolButton7: TElToolButton
      Left = 273
      Top = 0
      Width = 6
      Height = 24
      ButtonType = ebtSeparator
      Enabled = False
      ButtonID = 0
    end
  end
  object LeftPanel: TElPanel
    Left = 0
    Top = 24
    Width = 207
    Height = 373
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    DockOrientation = doNoOrient
    object ElLabel1: TElLabel
      Left = 0
      Top = 0
      Width = 207
      Height = 13
      Caption = 'Available properties:'
      Align = alTop
    end
    object gridProps: TElTreeStringGrid
      Left = 0
      Top = 42
      Width = 207
      Height = 331
      ColCount = 2
      RowCount = 0
      DefaultRowHeight = -1
      AutoLineHeight = True
      IncrementalSearch = True
      Align = alClient
      AutoLookup = True
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      HeaderHeight = 17
      HeaderSections.Data = {
        F1FFFFFF020000000000000000000000FFFFFFFF000001010100000063000000
        00000000102700000001000018D5E9010000000001000000FFFFFFFF00000100
        0000000000000000000100000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000E00000050726F7065727479
        206E616D6500010000000000000000000000000000000000000000FFFFFFFF00
        00010101000000680000000000000010270000000100008C5030040100000001
        000000FFFFFFFF00000100000000000000000000010000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000000000E
        00000050726F706572747920747970650001000000000000000000000000}
      HeaderFlat = True
      HideFocusRect = True
      HorzScrollBarStyles.Width = 17
      LockHeaderHeight = False
      SortMode = smAddClick
      StoragePath = '\Tree'
      TabOrder = 0
      VertScrollBarStyles.ShowTrackHint = True
      VertScrollBarStyles.Width = 17
      OnItemFocused = gridPropsItemFocused
      OnDblClick = gridPropsDblClick
    end
    object Panel2: TPanel
      Left = 0
      Top = 13
      Width = 207
      Height = 29
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        207
        29)
      object ElEdit1: TElEdit
        Left = 8
        Top = 4
        Width = 192
        Height = 21
        CueBanner = 'Filter'
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnKeyPress = ElEdit1KeyPress
      end
    end
  end
  object ElSplitter1: TElSplitter
    Left = 207
    Top = 24
    Width = 5
    Height = 373
    ControlTopLeft = LeftPanel
    ControlBottomRight = ElPanel2
    Align = alLeft
    BevelOuter = bvNone
  end
  object ElPanel2: TElPanel
    Left = 212
    Top = 24
    Width = 260
    Height = 373
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    DockOrientation = doNoOrient
    object ElLabel2: TElLabel
      Left = 0
      Top = 0
      Width = 260
      Height = 13
      Caption = 'Assigned styles and properties:'
      Align = alTop
    end
    object gridStyles: TElTreeStringGrid
      Left = 0
      Top = 13
      Width = 260
      Height = 360
      ColCount = 2
      RowCount = 0
      DefaultRowHeight = -1
      AutoLineHeight = True
      IncrementalSearch = True
      Align = alClient
      AutoLookup = True
      ExplorerEditMode = True
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      HeaderHeight = 17
      HeaderSections.Data = {
        F1FFFFFF020000000000000000000000FFFFFFFF000001010100000061000000
        00000000102700000001000018D5E9010000000000000000FFFFFFFF00000100
        0000000000000000000100000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000140000005374796C652F5072
        6F7065727479206E616D65000100000000000000000000000000000000000000
        00FFFFFFFF00000101010000006B0000000000000010270000000100008C5030
        040100000001010000FFFFFFFF00000100000000000000000000010000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000012000000496E6865726974616E63652F56616C7565000100000000
        0000000000000000}
      HeaderFlat = True
      HideFocusRect = True
      HorzScrollBarStyles.Width = 17
      LockHeaderHeight = False
      ShowButtons = True
      ShowLines = True
      ShowRoot = True
      SortMode = smAddClick
      StoragePath = '\Tree'
      TabOrder = 0
      VertScrollBarStyles.ShowTrackHint = True
      VertScrollBarStyles.Width = 17
      OnInplaceEditorNeeded = gridStylesInplaceEditorNeeded
      OnItemFocused = gridStylesItemFocused
      OnCompareItems = gridStylesCompareItems
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '.els'
    Filter = 'Style files (*.els)|*.els'
    FilterIndex = -1
    Left = 352
    Top = 216
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.els'
    Filter = 'Style files (*.els)|*.els'
    Left = 384
    Top = 216
  end
  object inpComboEnum: TElTreeInplaceComboBox
    Tree = gridStyles
    Types = [sftEnum]
    OnBeforeOperation = inpComboEnumBeforeOperation
    OnAfterOperation = inpComboEnumAfterOperation
    InitiallyDropped = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 24
    Top = 216
  end
  object inpComboBoolean: TElTreeInplaceComboBox
    Tree = gridStyles
    Types = [sftEnum]
    OnBeforeOperation = inpComboBooleanBeforeOperation
    OnAfterOperation = inpComboBooleanAfterOperation
    InitiallyDropped = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 56
    Top = 216
  end
  object inpEditText: TElTreeInplaceEdit
    Tree = gridStyles
    Types = [sftText]
    OnBeforeOperation = inpEditTextBeforeOperation
    OnAfterOperation = inpEditTextAfterOperation
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 112
    Top = 216
  end
  object inpEditInt: TElTreeInplaceSpinEdit
    Tree = gridStyles
    Types = [sftNumber]
    DefaultValueAsText = '0'
    OnBeforeOperation = inpEditIntBeforeOperation
    OnAfterOperation = inpEditIntAfterOperation
    MaxValue = 100
    MinValue = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 64
    Top = 128
  end
  object inpEditFloat: TElTreeInplaceFloatSpinEdit
    Tree = gridStyles
    Types = [sftFloating]
    DefaultValueAsText = '0'
    OnBeforeOperation = inpEditFloatBeforeOperation
    OnAfterOperation = inpEditFloatAfterOperation
    MaxValue = 100
    Digits = 3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 112
    Top = 112
  end
  object inpComboColor: TElTreeInplaceColorCombo
    Tree = gridStyles
    Types = [sftEnum]
    OnBeforeOperation = inpComboColorBeforeOperation
    OnAfterOperation = inpComboColorAfterOperation
    InitiallyDropped = False
    Options = [ccoNoColor, cco4BitColors, ccoSystemColors, ccoCustomChoice, ccoShowNames]
    DialogOptions = [cdFullOpen]
    Left = 160
    Top = 120
  end
  object inpComboSet: TElTreeInplaceTreeComboEdit
    Tree = gridStyles
    Types = [sftEnum]
    OnBeforeOperation = inpComboSetBeforeOperation
    OnAfterOperation = inpComboSetAfterOperation
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TreeFont.Charset = DEFAULT_CHARSET
    TreeFont.Color = clWindowText
    TreeFont.Height = -11
    TreeFont.Name = 'MS Sans Serif'
    TreeFont.Style = []
    ShowImages = True
    Left = 88
    Top = 216
  end
  object ElFormPersist1: TElFormPersist
    Storage = ElIniFile1
    StoragePath = '\StyleEditorForm'
    PersistOptions = [epoState, epoPosition, epoProperties, epoSize]
    TopMost = False
    Left = 368
    Top = 168
    PropsToStore = {
      01000000010000000000090000004C65667450616E656C000000000101050000
      005769647468}
  end
  object ElIniFile1: TElIniFile
    BinaryMode = False
    Comment = ';'
    Delimiter = '\'
    Path = '\SOFTWARE'
    RegRoot = rrtHKEY_CURRENT_USER
    UseRegistry = True
    WarningMessage = 'Automatically generated file. DO NOT MODIFY!!!'
    TrimSpaces = False
    Left = 304
    Top = 216
  end
  object inpEditImage: TElTreeInplaceButtonEdit
    Tree = gridStyles
    Types = [sftText, sftMemo]
    OnBeforeOperation = inpEditImageBeforeOperation
    OnAfterOperation = inpEditImageAfterOperation
    OnButtonClick = ImageButtonClick
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 240
    Top = 88
  end
  object inpDTPick: TElTreeInplaceDateTimePicker
    Tree = gridStyles
    Types = [sftDateTime, sftDate, sftTime]
    OnBeforeOperation = inpDTPickBeforeOperation
    OnAfterOperation = inpDTPickAfterOperation
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ShowPopupCalendar = True
    Format = edfShortDateLongTime
    CalendarShowClock = True
    Left = 256
    Top = 129
  end
end
