object XItemColDlg: TXItemColDlg
  Left = 348
  Top = 229
  Width = 351
  Height = 382
  Caption = 'XItem Properties Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TElPopupButton
    Left = 87
    Top = 316
    Width = 75
    Height = 25
    Default = True
    ModalResult = 1
    Caption = 'OK'
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TElPopupButton
    Left = 167
    Top = 316
    Width = 75
    Height = 25
    Cancel = True
    ModalResult = 2
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = CancelBtnClick
  end
  object ElPageControl1: TElPageControl
    Left = 0
    Top = 0
    Width = 343
    Height = 305
    TabIndex = 0
    ActivePage = ElTabSheet1
    Align = alTop
    TabOrder = 2
    DockOrientation = doNoOrient
    object ElTabSheet1: TElTabSheet
      PageControl = ElPageControl1
      Caption = 'Text'
      object Label13: TElLabel
        Left = 8
        Top = 132
        Width = 46
        Height = 13
        Caption = 'Item hint: '
        Transparent = False
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TElLabel
        Left = 8
        Top = 12
        Width = 71
        Height = 13
        Caption = 'Item main text: '
        Transparent = False
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object FontBtn: TElGraphicButton
        Left = 305
        Top = 0
        Width = 24
        Height = 24
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
      object HintEdit: TElMemo
        Left = 8
        Top = 144
        Width = 321
        Height = 121
        Cursor = crDefault
        ScrollBars = ssBoth
        ParentCtl3D = True
        TabOrder = 0
      end
      object TextEdit: TElMemo
        Left = 8
        Top = 30
        Width = 321
        Height = 97
        Cursor = crDefault
        ScrollBars = ssBoth
        OnChange = TextEditChange
        ParentCtl3D = True
        TabOrder = 1
      end
    end
    object ElTabSheet2: TElTabSheet
      PageControl = ElPageControl1
      Caption = 'Item style'
      Visible = False
      object CheckBoxGB: TElGroupBox
        Left = 0
        Top = 210
        Width = 329
        Height = 65
        AutoDisableChildren = True
        Caption = 'Show Checkbox/RadioButton'
        CheckBoxChecked = False
        ParentColor = True
        ShowCheckBox = True
        TabOrder = 0
        OnClick = CheckBoxGBClick
        object Label8: TElLabel
          Left = 176
          Top = 12
          Width = 33
          Height = 21
          Caption = 'Type:'
          Transparent = False
          Alignment = taRightJustify
          AutoSize = False
          Enabled = False
          Layout = tlCenter
        end
        object Label9: TElLabel
          Left = 168
          Top = 36
          Width = 33
          Height = 21
          Caption = 'State:'
          Transparent = False
          Alignment = taRightJustify
          AutoSize = False
          Enabled = False
          Layout = tlCenter
        end
        object CBEnabledCB: TElCheckBox
          Left = 8
          Top = 24
          Width = 112
          Height = 17
          State = cbChecked
          Checked = True
          Caption = 'CheckBox enabled'
          Enabled = False
          TabOrder = 0
        end
        object CBTypeCombo: TElComboBox
          Left = 216
          Top = 12
          Width = 105
          Height = 21
          Cursor = crIBeam
          DropDownCount = 3
          Items.Strings = (
            '2-State CheckBox'
            '3-State CheckBox'
            'RadioButton')
          Style = csDropDownList
          ItemHeight = 13
          UseCustomScrollBars = False
          OnChange = CBTypeComboChange
          ButtonEnabled = False
          Enabled = False
          TabOrder = 1
          ParentColor = False
        end
        object CBStateCombo: TElComboBox
          Left = 216
          Top = 36
          Width = 105
          Height = 21
          Cursor = crIBeam
          DropDownCount = 3
          Items.Strings = (
            'Unchecked'
            'Checked'
            'Grayed')
          Style = csDropDownList
          ItemHeight = 13
          UseCustomScrollBars = False
          ButtonEnabled = False
          Enabled = False
          TabOrder = 2
          ParentColor = False
        end
      end
      object OwnStyleGB: TElGroupBox
        Left = -3
        Top = 8
        Width = 334
        Height = 201
        AutoDisableChildren = True
        Caption = 'Use own style'
        ShowCheckBox = True
        TabOrder = 1
        OnClick = OwnStyleGBClick
        object ColorsGB: TElGroupBox
          Left = 92
          Top = 38
          Width = 110
          Height = 137
          AutoDisableChildren = True
          Caption = 'Parent colors'
          ParentColor = True
          ShowCheckBox = True
          TabOrder = 1
          OnClick = ColorsGBClick
          object Label4: TElLabel
            Left = 6
            Top = 14
            Width = 24
            Height = 13
            Caption = 'Font:'
            Transparent = False
          end
          object Label5: TElLabel
            Left = 6
            Top = 54
            Width = 85
            Height = 13
            Caption = 'Text Background:'
            Transparent = False
          end
          object Label12: TElLabel
            Left = 6
            Top = 94
            Width = 86
            Height = 13
            Caption = 'Row Background:'
            Transparent = False
          end
          object ColorCombo: TElColorCombo
            Left = 6
            Top = 30
            Width = 97
            Height = 21
            Cursor = crIBeam
            Options = [ccoNoColor, cco4BitColors, ccoSystemColors, ccoShowNames]
            SelectedColor = clWindowText
            DropDownCount = 16
            TabOrder = 0
            ParentColor = False
            DockOrientation = doNoOrient
            DoubleBuffered = False
          end
          object BkColorCombo: TElColorCombo
            Left = 6
            Top = 71
            Width = 97
            Height = 21
            Cursor = crIBeam
            Options = [ccoNoColor, cco4BitColors, ccoSystemColors, ccoShowNames]
            SelectedColor = clWindow
            DropDownCount = 16
            TabOrder = 1
            ParentColor = False
            DockOrientation = doNoOrient
            DoubleBuffered = False
          end
          object RowBkColorCombo: TElColorCombo
            Left = 6
            Top = 110
            Width = 97
            Height = 21
            Cursor = crIBeam
            Options = [ccoNoColor, cco4BitColors, ccoSystemColors, ccoShowNames]
            SelectedColor = clWindow
            DropDownCount = 16
            TabOrder = 2
            ParentColor = False
            DockOrientation = doNoOrient
            DoubleBuffered = False
          end
        end
        object StylesGB: TElGroupBox
          Left = 6
          Top = 24
          Width = 83
          Height = 151
          AutoDisableChildren = True
          Caption = 'Font Styles'
          ParentColor = True
          TabOrder = 0
          object ItCB: TElCheckBox
            Left = 8
            Top = 16
            Width = 44
            Height = 17
            Caption = 'Italic'
            TabOrder = 0
          end
          object ULCB: TElCheckBox
            Left = 8
            Top = 37
            Width = 73
            Height = 17
            Caption = 'Underlined'
            TabOrder = 1
          end
          object BoldCB: TElCheckBox
            Left = 8
            Top = 59
            Width = 43
            Height = 17
            Caption = 'Bold'
            TabOrder = 2
          end
          object StrikeCB: TElCheckBox
            Left = 8
            Top = 80
            Width = 64
            Height = 17
            Caption = 'Strikeout'
            TabOrder = 3
          end
        end
        object StrikeLineColorCB: TElColorCombo
          Left = 98
          Top = 176
          Width = 97
          Height = 21
          Cursor = crIBeam
          Options = [ccoNoColor, cco4BitColors, ccoSystemColors, ccoShowNames]
          SelectedColor = clWindowText
          DropDownCount = 16
          TabOrder = 3
          ParentColor = False
          DockOrientation = doNoOrient
          DoubleBuffered = False
        end
        object ElGroupBox2: TElGroupBox
          Left = 206
          Top = 24
          Width = 121
          Height = 169
          AutoDisableChildren = True
          Caption = 'Borders'
          TabOrder = 4
          object Label15: TElLabel
            Left = 5
            Top = 16
            Width = 84
            Height = 13
            Caption = 'Item'#39's border style'
            Transparent = False
          end
          object Label19: TElLabel
            Left = 6
            Top = 56
            Width = 86
            Height = 13
            Caption = 'BorderSpaceColor'
            Transparent = False
          end
          object BorderStyleCombo: TElComboBox
            Left = 6
            Top = 32
            Width = 97
            Height = 21
            Cursor = crIBeam
            DropDownCount = 16
            Items.Strings = (
              'None'
              'Raised'
              'Flat'
              'Sunken'
              'Space')
            Style = csDropDownList
            ItemHeight = 13
            UseCustomScrollBars = False
            TabOrder = 0
            ParentColor = False
          end
          object BorderSpaceColorCB: TElColorCombo
            Left = 6
            Top = 72
            Width = 97
            Height = 21
            Cursor = crIBeam
            Options = [ccoNoColor, cco4BitColors, ccoSystemColors, ccoShowNames]
            SelectedColor = clWindow
            DropDownCount = 16
            TabOrder = 1
            ParentColor = False
            DockOrientation = doNoOrient
            DoubleBuffered = False
          end
          object BorderSidesCG: TElCheckGroup
            Left = 4
            Top = 104
            Width = 112
            Height = 60
            Caption = 'BorderSides'
            Columns = 2
            Items.Strings = (
              'Left'
              'Right'
              'Top'
              'Bottom')
            TabOrder = 2
          end
        end
        object StrikeOutCB: TElCheckBox
          Left = 6
          Top = 178
          Width = 92
          Height = 17
          Caption = 'Striked out line'
          TabOrder = 2
          OnClick = StrikeOutCBClick
        end
        object UseBkColorsCB: TElCheckBox
          Left = 100
          Top = 16
          Width = 86
          Height = 17
          State = cbChecked
          Checked = True
          Caption = 'Use BkColors'
          TabOrder = 5
        end
      end
    end
    object ElTabSheet3: TElTabSheet
      PageControl = ElPageControl1
      Caption = 'Cells'
      Visible = False
      object CellStyleGB: TElGroupBox
        Left = 0
        Top = 117
        Width = 337
        Height = 163
        Align = alBottom
        AutoDisableChildren = True
        Caption = 'Cell style'
        CheckBoxChecked = False
        Enabled = False
        TabOrder = 0
        object ElGroupBox5: TElGroupBox
          Left = 8
          Top = 14
          Width = 92
          Height = 94
          AutoDisableChildren = True
          Caption = 'Font Styles'
          Enabled = False
          ParentColor = True
          TabOrder = 0
          object CellItCB: TElCheckBox
            Left = 8
            Top = 16
            Width = 44
            Height = 17
            Caption = 'Italic'
            Enabled = False
            TabOrder = 0
          end
          object CellULCB: TElCheckBox
            Left = 8
            Top = 34
            Width = 73
            Height = 17
            Caption = 'Underlined'
            Enabled = False
            TabOrder = 1
          end
          object CellBoldCB: TElCheckBox
            Left = 8
            Top = 52
            Width = 43
            Height = 17
            Caption = 'Bold'
            Enabled = False
            TabOrder = 2
          end
          object CellStrikeCB: TElCheckBox
            Left = 8
            Top = 72
            Width = 64
            Height = 17
            Caption = 'Strikeout'
            Enabled = False
            TabOrder = 3
          end
        end
        object CellColorsGB: TElGroupBox
          Left = 103
          Top = 26
          Width = 106
          Height = 134
          AutoDisableChildren = True
          Caption = 'Parent colors'
          Enabled = False
          ParentColor = True
          ShowCheckBox = True
          TabOrder = 1
          OnClick = CellColorsGBClick
          object Label1: TElLabel
            Left = 4
            Top = 14
            Width = 24
            Height = 13
            Caption = 'Font:'
            Transparent = False
            Enabled = False
          end
          object Label17: TElLabel
            Left = 4
            Top = 52
            Width = 85
            Height = 13
            Caption = 'Text Background:'
            Transparent = False
            Enabled = False
          end
          object Label18: TElLabel
            Left = 4
            Top = 92
            Width = 86
            Height = 13
            Caption = 'Row Background:'
            Transparent = False
            Enabled = False
          end
          object CellColorCombo: TElColorCombo
            Left = 4
            Top = 28
            Width = 97
            Height = 21
            Cursor = crIBeam
            Options = [ccoNoColor, cco4BitColors, ccoSystemColors, ccoShowNames]
            SelectedColor = clWindowText
            DropDownCount = 16
            ButtonEnabled = False
            Enabled = False
            TabOrder = 0
            ParentColor = False
            DockOrientation = doNoOrient
            DoubleBuffered = False
          end
          object CellBkColorCombo: TElColorCombo
            Left = 4
            Top = 68
            Width = 97
            Height = 21
            Cursor = crIBeam
            Options = [ccoNoColor, cco4BitColors, ccoSystemColors, ccoShowNames]
            SelectedColor = clWindow
            DropDownCount = 16
            ButtonEnabled = False
            Enabled = False
            TabOrder = 1
            ParentColor = False
            DockOrientation = doNoOrient
            DoubleBuffered = False
          end
          object CellRowBkColorCombo: TElColorCombo
            Left = 4
            Top = 108
            Width = 97
            Height = 21
            Cursor = crIBeam
            Options = [ccoNoColor, cco4BitColors, ccoSystemColors, ccoShowNames]
            SelectedColor = clWindow
            DropDownCount = 16
            ButtonEnabled = False
            Enabled = False
            TabOrder = 2
            ParentColor = False
            DockOrientation = doNoOrient
            DoubleBuffered = False
          end
        end
        object CellStrikeLineColorCB: TElColorCombo
          Left = 4
          Top = 134
          Width = 97
          Height = 21
          Cursor = crIBeam
          Options = [ccoNoColor, cco4BitColors, ccoSystemColors, ccoShowNames]
          SelectedColor = clWindowText
          DropDownCount = 16
          ButtonEnabled = False
          Enabled = False
          TabOrder = 3
          ParentColor = False
          DockOrientation = doNoOrient
          DoubleBuffered = False
        end
        object ElGroupBox3: TElGroupBox
          Left = 212
          Top = 10
          Width = 120
          Height = 150
          AutoDisableChildren = True
          Caption = 'Borders'
          Enabled = False
          TabOrder = 4
          object Label3: TElLabel
            Left = 5
            Top = 12
            Width = 84
            Height = 13
            Caption = 'Item'#39's border style'
            Transparent = False
            Enabled = False
          end
          object Label20: TElLabel
            Left = 6
            Top = 50
            Width = 86
            Height = 13
            Caption = 'BorderSpaceColor'
            Transparent = False
            Enabled = False
          end
          object CellBorderStyleCombo: TElComboBox
            Left = 6
            Top = 26
            Width = 97
            Height = 21
            Cursor = crIBeam
            DropDownCount = 16
            Items.Strings = (
              'None'
              'Raised'
              'Flat'
              'Sunken'
              'Space')
            Style = csDropDownList
            ItemHeight = 13
            UseCustomScrollBars = False
            ButtonEnabled = False
            Enabled = False
            TabOrder = 0
            ParentColor = False
          end
          object CellBorderSpaceColorCB: TElColorCombo
            Left = 6
            Top = 64
            Width = 97
            Height = 21
            Cursor = crIBeam
            Options = [ccoNoColor, cco4BitColors, ccoSystemColors, ccoShowNames]
            SelectedColor = clWindow
            DropDownCount = 16
            ButtonEnabled = False
            Enabled = False
            TabOrder = 1
            ParentColor = False
            DockOrientation = doNoOrient
            DoubleBuffered = False
          end
          object CellBorderSidesCG: TElCheckGroup
            Left = 4
            Top = 86
            Width = 112
            Height = 60
            Caption = 'BorderSides'
            Columns = 2
            Enabled = False
            Items.Strings = (
              'Left'
              'Right'
              'Top'
              'Bottom')
            TabOrder = 2
          end
        end
        object CellUseBkColorsCB: TElCheckBox
          Left = 112
          Top = 8
          Width = 86
          Height = 17
          State = cbChecked
          Checked = True
          Caption = 'Use BkColors'
          TabOrder = 5
        end
        object CellStrikeOutCB: TElCheckBox
          Left = 8
          Top = 114
          Width = 92
          Height = 17
          Caption = 'Striked out line'
          Enabled = False
          TabOrder = 2
          OnClick = CellStrikeOutCBClick
        end
      end
      object CellTree: TElXTree
        Left = 0
        Top = 0
        Width = 337
        Height = 117
        BorderColorWindow = clWindow
        Align = alClient
        Style.FontSize = 8
        Style.FontStyles = []
        Style.FontName = 'MS Sans Serif'
        BarStyle = True
        BarStyleVerticalLines = True
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        HeaderHeight = 40
        HeaderSections.Data = {
          F1FFFFFF040000000000000000000000FFFFFFFF000001010100000000000000
          000000001027000000000000D09E4E060000000001000000FFFFFFFF00000100
          0000000000000000000100000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000010000000001000000000000
          0000000000000000000000000000FFFFFFFF0000010101000000D50000000000
          000010270000000100008024DE030100000001010000FFFFFFFF000001000000
          0000000000000001000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000900000043656C6C546578740001
          0000000000000000000000000000000000000000FFFFFFFF0000010100000000
          3E00000000000000102700000001010070B20E060200000001000000FFFFFFFF
          0000010000000000000000000001000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000001200000055736572
          20646566696E6564207465787400010000000000000000000000000000000000
          000000FFFFFFFF00000101000000003E000000000000001027000000010100F0
          EA10060300000001000000FFFFFFFF0000010000000000000000000001000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000A0000004F776E207374796C65000100000000000000000000
          0000}
        HeaderSections.Cells = {
          000000000100000001000000000008000000430065006C006C00540065007800
          7400010000000100000000001100000055007300650072002000640065006600
          69006E0065006400200074006500780074000100000001000000000109000000
          4F0077006E0020007300740079006C00650001000000010000000001}
        HeaderFlat = True
        HeaderWrapCaptions = True
        HorizontalLines = True
        HorzScrollBarStyles.Width = 17
        ItemIndent = 18
        LineHeight = 20
        LinesColor = clBtnShadow
        ParentFont = False
        QuickEditMode = True
        ShowColumns = True
        ShowLeafButton = False
        SortSection = -1
        StoragePath = '\Tree'
        StickyHeaderSections = True
        TabOrder = 1
        TabStop = True
        VertDivLinesColor = clBtnShadow
        VerticalLines = True
        VerticalLinesLong = False
        VertScrollBarStyles.ShowTrackHint = True
        VertScrollBarStyles.Width = 17
        BackGroundColor = clBtnFace
        OnInplaceEditorNeeded = CellTreeInplaceEditorNeeded
        OnItemSelectedChange = CellTreeItemSelectedChange
        FixedTopRowNum = 0
        FixedBottomRowNum = 0
        FixedColNum = 1
        GutterWidth = 0
      end
    end
    object ElTabSheet4: TElTabSheet
      PageControl = ElPageControl1
      Caption = 'Misc'
      Visible = False
      object Label14: TElLabel
        Left = 240
        Top = 212
        Width = 22
        Height = 13
        Caption = 'Tag:'
        Transparent = False
        Layout = tlCenter
      end
      object IndentEdit: TElEdit
        Left = 276
        Top = 178
        Width = 33
        Height = 21
        Cursor = crDefault
        AutoSelect = True
        UseCustomScrollBars = False
        ParentCtl3D = True
        TabOrder = 0
      end
      object HeightEdit: TElEdit
        Left = 276
        Top = 124
        Width = 33
        Height = 21
        Cursor = crDefault
        AutoSelect = True
        UseCustomScrollBars = False
        ParentCtl3D = True
        TabOrder = 1
      end
      object TagEdit: TElEdit
        Left = 276
        Top = 204
        Width = 33
        Height = 21
        Cursor = crDefault
        AutoSelect = True
        UseCustomScrollBars = False
        ParentCtl3D = True
        TabOrder = 2
      end
      object OwnHeightCB: TElCheckBox
        Left = 184
        Top = 124
        Width = 76
        Height = 17
        Caption = 'Own height'
        TabOrder = 3
        OnClick = OwnHeightCBClick
      end
      object IndentAdjustCB: TElCheckBox
        Left = 184
        Top = 156
        Width = 127
        Height = 17
        Caption = 'Use indent adjustment'
        TabOrder = 4
        OnClick = IndentAdjustCBClick
      end
      object WholeLineCB: TElCheckBox
        Left = 184
        Top = 244
        Width = 72
        Height = 17
        Caption = 'Whole line'
        TabOrder = 5
      end
      object SuppressLinesCB: TElCheckBox
        Left = 8
        Top = 244
        Width = 102
        Height = 17
        Caption = 'Suppressed lines'
        TabOrder = 6
      end
      object SuppressButtonsCB: TElCheckBox
        Left = 8
        Top = 220
        Width = 116
        Height = 17
        Caption = 'Suppressed buttons'
        TabOrder = 7
      end
      object ForcedBtnsCB: TElCheckBox
        Left = 8
        Top = 196
        Width = 93
        Height = 17
        Caption = 'Forced buttons'
        TabOrder = 8
      end
      object AllowEditCB: TElCheckBox
        Left = 8
        Top = 172
        Width = 67
        Height = 17
        Caption = 'Allow edit'
        TabOrder = 9
      end
      object HorZlineCB: TElCheckBox
        Left = 8
        Top = 148
        Width = 114
        Height = 17
        Caption = 'Draw horizontal line'
        TabOrder = 10
      end
      object WordWrapCB: TElCheckBox
        Left = 8
        Top = 124
        Width = 134
        Height = 17
        Caption = 'Word wrap multiline text'
        TabOrder = 11
      end
      object MultilineCB: TElCheckBox
        Left = 8
        Top = 100
        Width = 126
        Height = 17
        Caption = 'Contains multi-line text'
        TabOrder = 12
      end
      object HintHTMLCB: TElCheckBox
        Left = 8
        Top = 76
        Width = 117
        Height = 17
        Caption = 'Hint contains HTML'
        TabOrder = 13
        Visible = False
      end
      object HtmlCB: TElCheckBox
        Left = 8
        Top = 52
        Width = 96
        Height = 17
        Caption = 'Contains HTML'
        TabOrder = 14
      end
      object HiddenCB: TElCheckBox
        Left = 8
        Top = 28
        Width = 56
        Height = 17
        Caption = 'Hidden'
        TabOrder = 15
      end
      object EnabledCB: TElCheckBox
        Left = 8
        Top = 4
        Width = 61
        Height = 17
        Caption = 'Enabled'
        TabOrder = 16
      end
      object ElGroupBox1: TElGroupBox
        Left = 168
        Top = 4
        Width = 161
        Height = 113
        Caption = 'Item images:'
        TabOrder = 17
        object Label6: TElLabel
          Left = 8
          Top = 32
          Width = 44
          Height = 18
          Caption = 'Normal:'
          Transparent = False
          AutoSize = False
          Layout = tlCenter
        end
        object Label7: TElLabel
          Left = 8
          Top = 56
          Width = 28
          Height = 21
          Caption = 'State:'
          Transparent = False
          AutoSize = False
          Layout = tlCenter
        end
        object Label16: TElLabel
          Left = 8
          Top = 80
          Width = 44
          Height = 22
          Caption = 'Overlay:'
          Transparent = False
          AutoSize = False
          Layout = tlCenter
        end
        object Label10: TElLabel
          Left = 66
          Top = 16
          Width = 17
          Height = 13
          Caption = '1st:'
          Transparent = False
        end
        object Label11: TElLabel
          Left = 106
          Top = 16
          Width = 21
          Height = 13
          Caption = '2nd:'
          Transparent = False
        end
        object IndexEdit: TElEdit
          Left = 66
          Top = 32
          Width = 32
          Height = 21
          Cursor = crDefault
          AutoSelect = True
          UseCustomScrollBars = False
          ParentCtl3D = True
          TabOrder = 0
        end
        object StIndexEdit: TElEdit
          Left = 66
          Top = 56
          Width = 32
          Height = 21
          Cursor = crDefault
          AutoSelect = True
          UseCustomScrollBars = False
          ParentCtl3D = True
          TabOrder = 1
        end
        object OvIndexEdit: TElEdit
          Left = 66
          Top = 80
          Width = 32
          Height = 21
          Cursor = crDefault
          AutoSelect = True
          UseCustomScrollBars = False
          ParentCtl3D = True
          TabOrder = 2
        end
        object Index2Edit: TElEdit
          Left = 106
          Top = 32
          Width = 33
          Height = 21
          Cursor = crDefault
          AutoSelect = True
          UseCustomScrollBars = False
          ParentCtl3D = True
          TabOrder = 3
        end
        object StIndex2Edit: TElEdit
          Left = 106
          Top = 56
          Width = 33
          Height = 21
          Cursor = crDefault
          AutoSelect = True
          UseCustomScrollBars = False
          ParentCtl3D = True
          TabOrder = 4
        end
        object OvIndex2Edit: TElEdit
          Left = 106
          Top = 80
          Width = 33
          Height = 21
          Cursor = crDefault
          AutoSelect = True
          UseCustomScrollBars = False
          ParentCtl3D = True
          TabOrder = 5
        end
      end
    end
  end
  object ElTreeInplaceAdvancedEdit1: TElTreeInplaceAdvancedEdit
    Tree = CellTree
    Types = [sftText]
    OnBeforeOperation = ElTreeInplaceAdvancedEdit1BeforeOperation
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    CharCase = eecNormal
    Left = 248
    Top = 16
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 280
    Top = 67
  end
end
