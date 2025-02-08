object ElXSectionsPropDlg: TElXSectionsPropDlg
  Left = 338
  Top = 258
  Width = 512
  Height = 304
  Caption = 'ElHeader Sections editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 0
    Top = 233
    Width = 504
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object FontBtn: TElGraphicButton
      Left = 14
      Top = 6
      Width = 24
      Height = 23
      Hint = 'Customize font'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000EE0E0000EE0E0000000100000001000000000000A542
        1000BD6B290084848400FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00040404040404
        0404040404040404040404040404010101010101010101010101040404040404
        0404040404040404040404040404010101010104040401010101040404040404
        0101020404040401010404040404040404010102040404010104040404040404
        0404010101010101010404040404040404040401010204010104040004040400
        0404040401010201010404000304030004040404040101010104040300000003
        0404040404040101010404040004000404040404040404010104040400040004
        0404040404040404040404040300030404040404040404040404040404000404
        0404040404040404040404040404040404040404040404040404}
      ParentShowHint = False
      ShowHint = True
      OnClick = FontBtnClick
    end
    object Button1: TElPopupButton
      Left = 265
      Top = 8
      Width = 75
      Height = 25
      Default = True
      ModalResult = 1
      Caption = 'OK'
      TabOrder = 0
    end
    object Button2: TElPopupButton
      Left = 345
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      ModalResult = 2
      Caption = 'Cancel'
      TabOrder = 1
    end
    object Button3: TElPopupButton
      Left = 425
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Apply'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 504
    Height = 43
    Align = alClient
    AutoScroll = False
    BorderStyle = bsNone
    TabOrder = 1
    object GroupBox2: TElGroupBox
      Left = 0
      Top = 0
      Width = 504
      Height = 43
      Align = alClient
      Caption = 'Preview'
      ParentColor = True
      TabOrder = 0
      object TestHeader: TElXHeader
        Left = 3
        Top = 16
        Width = 498
        Height = 19
        RowHeight = 19
        AllowDrag = False
        Color = clBtnFace
        DockOrientation = doNoOrient
        DoubleBuffered = False
        Sections.Data = {F1FFFFFF00000000}
        Sections.Cells = {}
        OnMouseDown = TestHeaderMouseDown
        OnSectionDelete = TestHeaderSectionDelete
        OnSectionCreate = TestHeaderSectionCreate
        OnSectionCellClick = TestHeaderSectionCellClick
        OnSectionCellPostDraw = TestHeaderSectionCellPostDraw
      end
    end
  end
  object ElPanel1: TElPanel
    Left = 0
    Top = 43
    Width = 504
    Height = 190
    BorderType = fbtNone
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DockOrientation = doNoOrient
    object ElPanel2: TElPanel
      Left = 0
      Top = 0
      Width = 177
      Height = 190
      BorderSides = [ebsRight]
      BorderColorDkShadow = clBtnFace
      BorderColorShadow = clBtnFace
      BorderColorHighlight = clBtnFace
      BorderColorWindow = clBtnFace
      BorderType = fbtFramed
      Align = alLeft
      BevelOuter = bvNone
      BorderStyle = bsSingle
      BorderWidth = 2
      TabOrder = 0
      DockOrientation = doNoOrient
      object ElGroupBox1: TElGroupBox
        Left = 2
        Top = 2
        Width = 173
        Height = 79
        Align = alTop
        Caption = 'Header'
        Flat = True
        TabOrder = 0
        object ElLabel1: TElLabel
          Left = 8
          Top = 24
          Width = 50
          Height = 13
          Caption = 'RowCount'
        end
        object ElLabel2: TElLabel
          Left = 8
          Top = 48
          Width = 53
          Height = 13
          Caption = 'RowHeight'
        end
        object RowCountSE: TElSpinEdit
          Left = 80
          Top = 20
          Width = 82
          Height = 21
          Cursor = crIBeam
          Value = 1
          MinValue = 1
          UseCustomScrollBars = False
          OnChange = RowCountSEChange
          TabOrder = 0
        end
        object RowHeightSE: TElSpinEdit
          Left = 80
          Top = 44
          Width = 82
          Height = 21
          Cursor = crIBeam
          Value = 19
          UseCustomScrollBars = False
          OnChange = RowHeightSEChange
          TabOrder = 1
        end
      end
      object ElGroupBox2: TElGroupBox
        Left = 2
        Top = 81
        Width = 173
        Height = 107
        Align = alClient
        AutoDisableChildren = True
        Caption = 'Cell'
        Enabled = False
        Flat = True
        TabOrder = 1
        object ElLabel3: TElLabel
          Left = 8
          Top = 48
          Width = 21
          Height = 13
          Caption = 'Text'
          Enabled = False
        end
        object ElLabel4: TElLabel
          Left = 8
          Top = 24
          Width = 67
          Height = 13
          Caption = 'TextAlignment'
          Enabled = False
        end
        object CellEdit: TElEdit
          Left = 40
          Top = 44
          Width = 122
          Height = 21
          UseCustomScrollBars = False
          OnChange = CellEditChange
          OnPasteClipboardText = CellEditPasteClipboardText
          Enabled = False
          TabOrder = 0
        end
        object AlCB: TElComboBox
          Left = 80
          Top = 20
          Width = 82
          Height = 21
          Cursor = crIBeam
          Items.Strings = (
            'hsaLeft'
            'hsaCenter'
            'hsaRight')
          ItemIndex = 0
          Style = csDropDownList
          ItemHeight = 13
          UseCustomScrollBars = False
          OnChange = AlCBChange
          Text = 'hsaLeft'
          ButtonEnabled = False
          Enabled = False
          TabOrder = 3
          ParentColor = False
        end
        object MergeBtn: TElPopupButton
          Left = 8
          Top = 74
          Width = 75
          Height = 25
          Caption = 'Merge cells'
          Enabled = False
          TabOrder = 1
          OnClick = MergeBtnClick
        end
        object SplitBtn: TElPopupButton
          Left = 88
          Top = 74
          Width = 75
          Height = 25
          Caption = 'Split cells'
          Enabled = False
          TabOrder = 2
          OnClick = SplitBtnClick
        end
      end
    end
    object ElPanel3: TElPanel
      Left = 177
      Top = 0
      Width = 327
      Height = 190
      BorderType = fbtFramed
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 2
      TabOrder = 1
      DockOrientation = doNoOrient
      object GroupBox1: TElGroupBox
        Left = 2
        Top = 2
        Width = 323
        Height = 186
        Align = alClient
        Caption = 'Sections'
        Flat = True
        ParentColor = True
        TabOrder = 0
        object Panel1: TPanel
          Left = 3
          Top = 16
          Width = 156
          Height = 167
          Align = alClient
          BevelOuter = bvNone
          BevelWidth = 0
          Caption = 'Panel1'
          TabOrder = 0
          object SecList: TListBox
            Left = 0
            Top = 0
            Width = 156
            Height = 167
            Align = alClient
            ItemHeight = 13
            TabOrder = 0
            OnClick = SecListClick
            OnDblClick = SecListDblClick
            OnKeyPress = SecListKeyPress
          end
        end
        object Panel2: TPanel
          Left = 159
          Top = 16
          Width = 161
          Height = 167
          Align = alRight
          BevelOuter = bvNone
          BevelWidth = 0
          TabOrder = 1
          object AddBtn: TElPopupButton
            Left = 4
            Top = 6
            Width = 75
            Height = 25
            Caption = '&Add'
            TabOrder = 0
            OnClick = AddBtnClick
          end
          object DeleteBtn: TElPopupButton
            Left = 4
            Top = 72
            Width = 75
            Height = 25
            Caption = '&Delete'
            Enabled = False
            TabOrder = 2
            OnClick = DeleteBtnClick
          end
          object EditBtn: TElPopupButton
            Left = 4
            Top = 101
            Width = 75
            Height = 25
            Caption = '&Edit...'
            Enabled = False
            TabOrder = 1
            OnClick = EditBtnClick
          end
          object UpBtn: TElPopupButton
            Left = 84
            Top = 6
            Width = 75
            Height = 25
            Caption = 'Move &Up'
            Enabled = False
            TabOrder = 3
            OnClick = UpBtnClick
          end
          object DownBtn: TElPopupButton
            Left = 84
            Top = 35
            Width = 75
            Height = 25
            Caption = 'Move Dow&n'
            Enabled = False
            TabOrder = 4
            OnClick = DownBtnClick
          end
          object LoadBtn: TElPopupButton
            Left = 84
            Top = 72
            Width = 75
            Height = 25
            Caption = '&Load'
            TabOrder = 5
            OnClick = LoadBtnClick
          end
          object SaveBtn: TElPopupButton
            Left = 84
            Top = 101
            Width = 75
            Height = 25
            Caption = '&Save'
            TabOrder = 6
            OnClick = SaveBtnClick
          end
          object DuplicateBtn: TElPopupButton
            Left = 4
            Top = 35
            Width = 73
            Height = 25
            Caption = 'Du&plicate'
            Enabled = False
            TabOrder = 7
            OnClick = DuplicateBtnClick
          end
          object ReindexBtn: TElPopupButton
            Left = 4
            Top = 136
            Width = 75
            Height = 25
            Caption = '&Reindex'
            TabOrder = 8
            OnClick = ReindexBtnClick
          end
        end
      end
    end
  end
  object OpenDlg: TOpenDialog
    DefaultExt = '.Elh'
    Filter = 'ElHeader Sections (*.Elh)|*.Elh|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist]
    Left = 96
    Top = 240
  end
  object SaveDlg: TSaveDialog
    DefaultExt = '*.Elh'
    Filter = 'ElHeader files (*.Elh)|*.Elh|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist]
    Left = 128
    Top = 240
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 168
    Top = 241
  end
end
