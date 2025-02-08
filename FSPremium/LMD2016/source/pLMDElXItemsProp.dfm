object XItemsPropDlg: TXItemsPropDlg
  Left = 345
  Top = 227
  Width = 389
  Height = 281
  Caption = 'ElXTree Items Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ItemsGB: TGroupBox
    Left = 0
    Top = 0
    Width = 381
    Height = 210
    Align = alClient
    Caption = 'Items'
    TabOrder = 0
    object Panel2: TPanel
      Left = 208
      Top = 15
      Width = 171
      Height = 193
      Align = alRight
      BevelOuter = bvNone
      BorderWidth = 3
      TabOrder = 1
      object NewItemBtn: TElPopupButton
        Left = 10
        Top = 0
        Width = 73
        Height = 25
        Caption = '&New Item'
        TabOrder = 0
        OnClick = NewItemBtnClick
      end
      object SubitemBtn: TElPopupButton
        Left = 10
        Top = 32
        Width = 73
        Height = 25
        Caption = 'New &Subitem'
        Enabled = False
        TabOrder = 1
        OnClick = SubitemBtnClick
      end
      object DeleteBtn: TElPopupButton
        Left = 10
        Top = 96
        Width = 73
        Height = 25
        Caption = '&Delete'
        Enabled = False
        TabOrder = 2
        OnClick = DeleteBtnClick
      end
      object SaveBtn: TElPopupButton
        Left = 90
        Top = 167
        Width = 73
        Height = 25
        Caption = 'S&ave'
        TabOrder = 3
        OnClick = SaveBtnClick
      end
      object LoadBtn: TElPopupButton
        Left = 10
        Top = 167
        Width = 73
        Height = 25
        Caption = '&Load'
        TabOrder = 4
        OnClick = LoadBtnClick
      end
      object EditBtn: TElPopupButton
        Left = 10
        Top = 128
        Width = 73
        Height = 25
        Caption = '&Edit ...'
        Enabled = False
        TabOrder = 5
        OnClick = EditBtnClick
      end
      object MoveRightBtn: TElPopupButton
        Left = 90
        Top = 32
        Width = 73
        Height = 25
        Caption = '   &>>'
        Enabled = False
        TabOrder = 6
        OnClick = MoveRightBtnClick
      end
      object MoveLeftBtn: TElPopupButton
        Left = 90
        Top = 0
        Width = 73
        Height = 25
        Caption = '&<<   '
        Enabled = False
        TabOrder = 7
        OnClick = MoveLeftBtnClick
      end
      object MoveDownBtn: TElPopupButton
        Left = 90
        Top = 96
        Width = 73
        Height = 25
        Caption = 'Move D&own'
        Enabled = False
        TabOrder = 8
        OnClick = MoveDownBtnClick
      end
      object MoveUpBtn: TElPopupButton
        Left = 90
        Top = 64
        Width = 73
        Height = 25
        Caption = 'Move &Up'
        Enabled = False
        TabOrder = 9
        OnClick = MoveUpBtnClick
      end
      object DuplicateBtn: TElPopupButton
        Left = 10
        Top = 64
        Width = 73
        Height = 25
        Caption = 'Du&plicate'
        Enabled = False
        TabOrder = 10
        OnClick = DuplicateBtnClick
      end
    end
    object XTree: TElXTree
      Left = 2
      Top = 15
      Width = 206
      Height = 193
      BorderColorWindow = clWindow
      Align = alClient
      AlwaysKeepSelection = False
      Style.FontSize = 8
      Style.FontStyles = []
      Style.FontName = 'MS Sans Serif'
      DoInplaceEdit = False
      DragAllowed = True
      DragTrgDrawMode = ColorRect
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      HeaderHeight = 19
      HeaderHotTrack = False
      HeaderSections.Data = {
        F1FFFFFF010000000000000000000000FFFFFFFF00000101010000000F000000
        000000001027000000000000DC5BBE050000000001000000FFFFFFFF00000100
        0000000000000000000100000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000010000000001000000000000
        000000000000}
      HeaderSections.Cells = {0000000001000000010000000000}
      HideHintOnTimer = True
      HorzScrollBarStyles.Width = 17
      IgnoreEnabled = True
      ItemIndent = 18
      LineHeight = 18
      LinesColor = clBtnShadow
      MultiSelect = False
      ParentFont = False
      PathSeparator = #0
      ShowLeafButton = False
      ShowRoot = True
      SortSection = -1
      SortType = stCustom
      StoragePath = '\Tree'
      TabOrder = 0
      TabStop = True
      VerticalLinesLong = False
      VertScrollBarStyles.ShowTrackHint = True
      VertScrollBarStyles.Width = 17
      OnItemFocused = XTreeItemFocused
      OnDragDrop = XTreeDragDrop
      OnDragOver = XTreeDragOver
      OnStartDrag = XTreeStartDrag
      OnDblClick = XTreeDblClick
      OnKeyDown = XTreeKeyDown
      FixedTopRowNum = 0
      FixedBottomRowNum = 0
      FixedColNum = 1
      GutterWidth = 15
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 210
    Width = 381
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object OKBtn: TElPopupButton
      Left = 73
      Top = 8
      Width = 75
      Height = 25
      Default = True
      ModalResult = 1
      Caption = 'OK'
      TabOrder = 0
      OnClick = OKBtnClick
    end
    object CancelBtn: TElPopupButton
      Left = 153
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      ModalResult = 2
      Caption = 'Cancel'
      TabOrder = 1
    end
    object ApplyBtn: TElPopupButton
      Left = 233
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Apply'
      TabOrder = 2
      OnClick = OKBtnClick
    end
  end
  object OpenDlg: TOpenDialog
    DefaultExt = '*.bwt'
    Filter = 'ElTree Items file (*.elt)|*.elt|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofShareAware]
    Title = 'ElTree Items load dialog'
    Top = 256
  end
  object SaveDlg: TSaveDialog
    DefaultExt = '*.bwt'
    Filter = 'ElTree Items file (*.elt)|*.elt|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist]
    Title = 'ElTree ITems save dialog'
    Left = 32
    Top = 256
  end
end
