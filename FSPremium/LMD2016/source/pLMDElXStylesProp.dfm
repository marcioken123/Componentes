object NewStylesPropDlg: TNewStylesPropDlg
  Left = 211
  Top = 87
  Width = 693
  Height = 627
  BorderIcons = [biSystemMenu]
  Caption = 'StylesDefs'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TElPageControl
    Left = 0
    Top = 0
    Width = 685
    Height = 552
    Flat = True
    OnChanging = PageControl1Changing
    OnChange = PageControl1Change
    TabIndex = 0
    ActivePage = TabSheet1
    TabOrder = 0
    DockOrientation = doNoOrient
    object TabSheet1: TElTabSheet
      PageControl = PageControl1
      Caption = 'RootLevel'
      object Styles: TElGroupBox
        Left = 0
        Top = 0
        Width = 329
        Height = 527
        Align = alLeft
        ParentColor = True
        TabOrder = 0
        TransparentXPThemes = False
        object StylesCB: TElCheckBox
          Left = 8
          Top = 14
          Width = 82
          Height = 17
          Hint = 
            'When checked, tree settings are used. when unchecked, item'#39's fon' +
            't styles are used.'
          Flat = True
          FlatAlways = True
          Caption = 'Owner styles'
          TabOrder = 0
          OnClick = StylesCBClick
        end
        object ColorsCB: TElCheckBox
          Left = 104
          Top = 14
          Width = 84
          Height = 17
          Hint = 
            'When checked, tree colors are used. When unchecked, item'#39's own c' +
            'olors are used.'
          Flat = True
          FlatAlways = True
          Caption = 'Owner colors'
          TabOrder = 1
          OnClick = ColorsCBClick
        end
        object StylesGB: TElGroupBox
          Left = 8
          Top = 32
          Width = 89
          Height = 105
          ParentColor = True
          TabOrder = 2
          object BoldCB: TElCheckBox
            Left = 8
            Top = 59
            Width = 43
            Height = 17
            Flat = True
            FlatAlways = True
            Caption = 'Bold'
            TabOrder = 2
          end
          object ItCB: TElCheckBox
            Left = 8
            Top = 16
            Width = 44
            Height = 17
            Flat = True
            FlatAlways = True
            Caption = 'Italic'
            TabOrder = 0
          end
          object ULCB: TElCheckBox
            Left = 8
            Top = 37
            Width = 73
            Height = 17
            Flat = True
            FlatAlways = True
            Caption = 'Underlined'
            TabOrder = 1
          end
          object StrikeCB: TElCheckBox
            Left = 8
            Top = 80
            Width = 64
            Height = 17
            Flat = True
            FlatAlways = True
            Caption = 'Strikeout'
            TabOrder = 3
          end
        end
        object ColorsGB: TElGroupBox
          Left = 104
          Top = 32
          Width = 209
          Height = 105
          ParentColor = True
          TabOrder = 3
          object Label4: TElLabel
            Left = 8
            Top = 16
            Width = 24
            Height = 13
            Caption = 'Font:'
            Transparent = False
          end
          object Label12: TElLabel
            Left = 112
            Top = 56
            Width = 86
            Height = 13
            Caption = 'Row Background:'
            Transparent = False
          end
          object Label5: TElLabel
            Left = 112
            Top = 16
            Width = 85
            Height = 13
            Caption = 'Text Background:'
            Transparent = False
          end
          object UseBkColorCB: TElCheckBox
            Left = 8
            Top = 56
            Width = 86
            Height = 17
            Flat = True
            FlatAlways = True
            Caption = 'Use BkColors'
            TabOrder = 2
          end
          object ColorCombo: TElAdvancedComboBox
            Left = 8
            Top = 32
            Width = 81
            Height = 21
            AutoCompletion = False
            Ctl3D = True
            DropDownCount = 16
            Flat = True
            HandleDialogKeys = False
            HorizontalScroll = False
            ItemIndex = -1
            ItemHeight = 13
            ParentCtl3D = False
            TabOrder = 0
            Items.Strings = (
              'clAqua'
              'clBlack'
              'clBlue'
              'clDkGray'
              'clFuchsia'
              'clGray'
              'clGreen'
              'clLime'
              'clLtGray'
              'clMaroon'
              'clNavy'
              'clOlive'
              'clPurple'
              'clRed'
              'clSilver'
              'clTeal'
              'clWhite'
              'clYellow'
              'clActiveBorder'
              'clActiveCaption'
              'clAppWorkSpace'
              'clBackground'
              'clBtnFace'
              'clBtnHighlight'
              'clBtnShadow'
              'clBtnText'
              'clCaptionText'
              'clGrayText'
              'clHighlight'
              'clHighlightText'
              'clInactiveBorder'
              'clInactiveCaption'
              'clInactiveCaptionText'
              'clMenu'
              'clMenuText'
              'clScrollBar'
              'clWindow'
              'clWindowFrame'
              'clWindowText')
          end
          object RowBkColorCombo: TElAdvancedComboBox
            Left = 112
            Top = 72
            Width = 81
            Height = 21
            AutoCompletion = False
            DropDownCount = 16
            Flat = True
            HandleDialogKeys = False
            HorizontalScroll = False
            ItemIndex = -1
            ItemHeight = 13
            TabOrder = 1
            Items.Strings = (
              'clAqua'
              'clBlack'
              'clBlue'
              'clDkGray'
              'clFuchsia'
              'clGray'
              'clGreen'
              'clLime'
              'clLtGray'
              'clMaroon'
              'clNavy'
              'clOlive'
              'clPurple'
              'clRed'
              'clSilver'
              'clSkyBlue'
              'clMoneyGreen'
              'clTeal'
              'clWhite'
              'clYellow'
              'clActiveBorder'
              'clActiveCaption'
              'clAppWorkSpace'
              'clBackground'
              'clBtnFace'
              'clBtnHighlight'
              'clBtnShadow'
              'clBtnText'
              'clCaptionText'
              'clGrayText'
              'clHighlight'
              'clHighlightText'
              'clInactiveBorder'
              'clInactiveCaption'
              'clInactiveCaptionText'
              'clMenu'
              'clMenuText'
              'clScrollBar'
              'clWindow'
              'clWindowFrame'
              'clWindowText')
          end
          object BkColorCombo: TElAdvancedComboBox
            Left = 112
            Top = 32
            Width = 81
            Height = 21
            AutoCompletion = False
            DropDownCount = 16
            Flat = True
            HandleDialogKeys = False
            HorizontalScroll = False
            ItemIndex = -1
            ItemHeight = 13
            TabOrder = 3
            Items.Strings = (
              'clAqua'
              'clBlack'
              'clBlue'
              'clDkGray'
              'clFuchsia'
              'clGray'
              'clGreen'
              'clLime'
              'clLtGray'
              'clMaroon'
              'clNavy'
              'clOlive'
              'clPurple'
              'clRed'
              'clSilver'
              'clSkyBlue'
              'clMoneyGreen'
              'clTeal'
              'clWhite'
              'clYellow'
              'clActiveBorder'
              'clActiveCaption'
              'clAppWorkSpace'
              'clBackground'
              'clBtnFace'
              'clBtnHighlight'
              'clBtnShadow'
              'clBtnText'
              'clCaptionText'
              'clGrayText'
              'clHighlight'
              'clHighlightText'
              'clInactiveBorder'
              'clInactiveCaption'
              'clInactiveCaptionText'
              'clMenu'
              'clMenuText'
              'clScrollBar'
              'clWindow'
              'clWindowFrame'
              'clWindowText')
          end
        end
        object ShowChecksCB: TElCheckBox
          Left = 8
          Top = 152
          Width = 100
          Height = 17
          Flat = True
          FlatAlways = True
          Caption = 'Show Checkbox'
          TabOrder = 4
          OnClick = ShowChecksCBClick
        end
        object CBGroup: TElGroupBox
          Left = 8
          Top = 170
          Width = 169
          Height = 89
          Enabled = False
          ParentColor = True
          TabOrder = 5
          object Label7: TElLabel
            Left = 8
            Top = 32
            Width = 71
            Height = 13
            Caption = 'CheckBox field'
            Transparent = False
            Enabled = False
          end
          object CBEnabledCB: TElCheckBox
            Left = 8
            Top = 8
            Width = 61
            Height = 17
            Flat = True
            FlatAlways = True
            Caption = 'Enabled'
            TabOrder = 0
          end
          object CheckBoxCB: TElAdvancedComboBox
            Left = 8
            Top = 56
            Width = 145
            Height = 21
            AutoCompletion = False
            Enabled = False
            Flat = True
            HandleDialogKeys = False
            HorizontalScroll = False
            ItemIndex = -1
            ItemHeight = 13
            TabOrder = 1
          end
        end
        object Image1GB: TElGroupBox
          Left = 8
          Top = 312
          Width = 313
          Height = 89
          ParentColor = True
          TabOrder = 6
          object Label10: TElLabel
            Left = 64
            Top = 8
            Width = 17
            Height = 13
            Caption = '1st:'
            Transparent = False
            Enabled = False
          end
          object Label11: TElLabel
            Left = 208
            Top = 8
            Width = 21
            Height = 13
            Caption = '2nd:'
            Transparent = False
            Enabled = False
          end
          object Label24: TElLabel
            Left = 8
            Top = 24
            Width = 33
            Height = 13
            Caption = 'Normal'
            Transparent = False
            Enabled = False
          end
          object Label25: TElLabel
            Left = 8
            Top = 64
            Width = 25
            Height = 13
            Caption = 'State'
            Transparent = False
            Enabled = False
          end
          object ImageCB: TElAdvancedComboBox
            Left = 64
            Top = 24
            Width = 97
            Height = 21
            AutoCompletion = False
            Enabled = False
            Flat = True
            HandleDialogKeys = False
            HorizontalScroll = False
            ItemIndex = -1
            ItemHeight = 13
            TabOrder = 0
          end
          object StImageCB: TElAdvancedComboBox
            Left = 64
            Top = 56
            Width = 97
            Height = 21
            AutoCompletion = False
            Enabled = False
            Flat = True
            HandleDialogKeys = False
            HorizontalScroll = False
            ItemIndex = -1
            ItemHeight = 13
            TabOrder = 1
          end
          object Image2CB: TElAdvancedComboBox
            Left = 208
            Top = 24
            Width = 97
            Height = 21
            AutoCompletion = False
            Enabled = False
            Flat = True
            HandleDialogKeys = False
            HorizontalScroll = False
            ItemIndex = -1
            ItemHeight = 13
            TabOrder = 2
          end
          object StImage2CB: TElAdvancedComboBox
            Left = 208
            Top = 56
            Width = 97
            Height = 21
            AutoCompletion = False
            Enabled = False
            Flat = True
            HandleDialogKeys = False
            HorizontalScroll = False
            ItemIndex = -1
            ItemHeight = 13
            TabOrder = 3
          end
        end
        object Image0GB: TElGroupBox
          Left = 184
          Top = 232
          Width = 137
          Height = 81
          ParentColor = True
          TabOrder = 7
          object Label8: TElLabel
            Left = 8
            Top = 24
            Width = 36
            Height = 21
            Caption = 'Normal:'
            Transparent = False
            AutoSize = False
            Layout = tlCenter
          end
          object Label9: TElLabel
            Left = 8
            Top = 48
            Width = 28
            Height = 21
            Caption = 'State:'
            Transparent = False
            AutoSize = False
            Layout = tlCenter
          end
          object Label14: TElLabel
            Left = 48
            Top = 8
            Width = 17
            Height = 13
            Caption = '1st:'
            Transparent = False
          end
          object Label16: TElLabel
            Left = 88
            Top = 8
            Width = 21
            Height = 13
            Caption = '2nd:'
            Transparent = False
          end
          object IndexEdit: TElEdit
            Left = 48
            Top = 24
            Width = 33
            Height = 21
            Text = '-1'
            Flat = True
            LineBorderActiveColor = clBlack
            LineBorderInactiveColor = clBlack
            TabOrder = 0
          end
          object Index2Edit: TElEdit
            Left = 88
            Top = 24
            Width = 33
            Height = 21
            Text = '-1'
            Flat = True
            LineBorderActiveColor = clBlack
            LineBorderInactiveColor = clBlack
            TabOrder = 1
          end
          object StIndexEdit: TElEdit
            Left = 48
            Top = 48
            Width = 33
            Height = 21
            Text = '-1'
            Flat = True
            LineBorderActiveColor = clBlack
            LineBorderInactiveColor = clBlack
            TabOrder = 2
          end
          object StIndex2Edit: TElEdit
            Left = 88
            Top = 48
            Width = 33
            Height = 21
            Text = '-1'
            Flat = True
            LineBorderActiveColor = clBlack
            LineBorderInactiveColor = clBlack
            TabOrder = 3
          end
        end
        object ImagesGB: TElRadioGroup
          Left = 184
          Top = 170
          Width = 137
          Height = 63
          Caption = ' Item images '
          Flat = True
          FlatAlways = True
          ItemIndex = 0
          Items.Strings = (
            'User defined'
            'Table field')
          TabOrder = 8
          OnClick = ImagesGBClick
        end
        object PatternGB: TElGroupBox
          Left = 8
          Top = 432
          Width = 305
          Height = 81
          Enabled = False
          ParentColor = True
          TabOrder = 9
          object SpeedButton1: TElGraphicButton
            Left = 272
            Top = 12
            Width = 21
            Height = 21
            Hint = 'Add field in pattern'
            Caption = '+'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = SpeedButton1Click
          end
          object Label30: TElLabel
            Left = 8
            Top = 16
            Width = 41
            Height = 13
            Caption = 'Add field'
            Transparent = False
            Enabled = False
          end
          object PatternE: TElEdit
            Left = 8
            Top = 48
            Width = 289
            Height = 21
            AutoSize = False
            AlignBottom = False
            Text = '+'
            Flat = True
            LineBorderActiveColor = clBlack
            LineBorderInactiveColor = clBlack
            Multiline = True
            TabOrder = 1
          end
          object PatternCB: TElAdvancedComboBox
            Left = 80
            Top = 12
            Width = 193
            Height = 21
            AutoCompletion = False
            Enabled = False
            Flat = True
            HandleDialogKeys = False
            HorizontalScroll = False
            ItemIndex = -1
            ItemHeight = 13
            TabOrder = 0
          end
        end
        object UsePatternCB: TElCheckBox
          Left = 8
          Top = 408
          Width = 78
          Height = 17
          Flat = True
          FlatAlways = True
          Caption = 'Use Pattern'
          TabOrder = 10
          OnClick = UsePatternCBClick
        end
      end
      object Misc: TElGroupBox
        Left = 329
        Top = 0
        Width = 350
        Height = 527
        Align = alClient
        ParentColor = True
        TabOrder = 1
        TransparentXPThemes = False
        object Label15: TElLabel
          Left = 184
          Top = 160
          Width = 84
          Height = 13
          Caption = 'Item'#39's border style'
          Transparent = False
        end
        object EnabledCB: TElCheckBox
          Left = 8
          Top = 12
          Width = 61
          Height = 17
          Hint = 
            'When checked, the item is enabled. Disabled items don'#39't respond ' +
            'to mouse clicks and can'#39't be selected.'
          Flat = True
          FlatAlways = True
          Caption = 'Enabled'
          TabOrder = 0
        end
        object HiddenCB: TElCheckBox
          Left = 8
          Top = 36
          Width = 56
          Height = 17
          Hint = 'When checked, the item is not visible'
          Flat = True
          FlatAlways = True
          Caption = 'Hidden'
          TabOrder = 1
        end
        object HtmlCB: TElCheckBox
          Left = 8
          Top = 60
          Width = 96
          Height = 17
          Hint = 
            'When checked, text that starts with <html> is treated as HTML te' +
            'xt'
          Flat = True
          FlatAlways = True
          Caption = 'Contains HTML'
          TabOrder = 2
        end
        object MultilineCB: TElCheckBox
          Left = 8
          Top = 84
          Width = 126
          Height = 17
          Hint = 'When checked, item has multi-line text. '
          Flat = True
          FlatAlways = True
          Caption = 'Contains multi-line text'
          TabOrder = 3
        end
        object HorZlineCB: TElCheckBox
          Left = 8
          Top = 108
          Width = 114
          Height = 17
          Flat = True
          FlatAlways = True
          Caption = 'Draw horizontal line'
          TabOrder = 4
        end
        object AllowEditCB: TElCheckBox
          Left = 8
          Top = 132
          Width = 67
          Height = 17
          Flat = True
          FlatAlways = True
          Caption = 'Allow edit'
          TabOrder = 5
        end
        object ForcedBtnsCB: TElCheckBox
          Left = 8
          Top = 180
          Width = 93
          Height = 17
          Hint = 
            'When checked buttons will be displayed even when the item doesn'#39 +
            't have children'
          Flat = True
          FlatAlways = True
          Caption = 'Forced buttons'
          TabOrder = 6
        end
        object SuppressButtonsCB: TElCheckBox
          Left = 8
          Top = 204
          Width = 116
          Height = 17
          Hint = 
            'When checked, no buttons will be displayed even when the item ha' +
            's children'
          Flat = True
          FlatAlways = True
          Caption = 'Suppressed buttons'
          TabOrder = 7
        end
        object SuppressLinesCB: TElCheckBox
          Left = 8
          Top = 228
          Width = 102
          Height = 17
          Hint = 'When checked, no tree lines are drawn for the item'
          Flat = True
          FlatAlways = True
          Caption = 'Suppressed lines'
          TabOrder = 8
        end
        object IndentEdit: TElEdit
          Left = 200
          Top = 132
          Width = 33
          Height = 21
          Text = 'Al'
          Flat = True
          LineBorderActiveColor = clBlack
          LineBorderInactiveColor = clBlack
          TabOrder = 10
        end
        object IndentAdjustCB: TElCheckBox
          Left = 184
          Top = 112
          Width = 127
          Height = 17
          Hint = 
            'When checked item indentation is adjusted accoring to adjustment' +
            ' value.'
          Flat = True
          FlatAlways = True
          Caption = 'Use indent adjustment'
          TabOrder = 11
          OnClick = IndentAdjustCBClick
        end
        object HeightEdit: TElEdit
          Left = 200
          Top = 82
          Width = 33
          Height = 21
          Text = 'Al'
          Flat = True
          LineBorderActiveColor = clBlack
          LineBorderInactiveColor = clBlack
          TabOrder = 12
        end
        object OwnHeightCB: TElCheckBox
          Left = 184
          Top = 64
          Width = 76
          Height = 17
          Flat = True
          FlatAlways = True
          Caption = 'Own height'
          TabOrder = 13
          OnClick = OwnHeightCBClick
        end
        object StrikeOutCB: TElCheckBox
          Left = 184
          Top = 12
          Width = 73
          Height = 17
          Hint = 'When checked the item is striked out. '
          Flat = True
          FlatAlways = True
          Caption = 'Striked out'
          TabOrder = 15
          OnClick = StrikeOutCBClick
        end
        object Hints: TElGroupBox
          Left = 8
          Top = 301
          Width = 325
          Height = 184
          ParentColor = True
          TabOrder = 16
          object Label26: TElLabel
            Left = 8
            Top = 14
            Width = 41
            Height = 13
            Caption = 'Hint field'
            Transparent = False
            Enabled = False
          end
          object Label27: TElLabel
            Left = 8
            Top = 80
            Width = 39
            Height = 13
            Caption = 'Hint text'
            Transparent = False
          end
          object HintRG: TElRadioGroup
            Left = 180
            Top = 9
            Width = 137
            Height = 63
            Caption = ' Item hint  '
            Flat = True
            FlatAlways = True
            ItemIndex = 0
            Items.Strings = (
              'User defined'
              'Table field')
            TabOrder = 0
            OnClick = HintRGClick
          end
          object HintED: TElEdit
            Left = 8
            Top = 96
            Width = 309
            Height = 81
            AutoSize = False
            AlignBottom = False
            Text = 'Ta'
            Flat = True
            LineBorderActiveColor = clBlack
            LineBorderInactiveColor = clBlack
            Multiline = True
            ScrollBars = ssVertical
            TabOrder = 2
          end
          object HTMLCBL: TElCheckBox
            Left = 8
            Top = 58
            Width = 117
            Height = 17
            Flat = True
            FlatAlways = True
            Caption = 'Hint contains HTML'
            TabOrder = 3
          end
          object HintCB: TElAdvancedComboBox
            Left = 8
            Top = 30
            Width = 145
            Height = 21
            AutoCompletion = False
            Enabled = False
            Flat = True
            HandleDialogKeys = False
            HorizontalScroll = False
            ItemIndex = -1
            ItemHeight = 13
            TabOrder = 1
          end
        end
        object BorderStyleCombo: TElAdvancedComboBox
          Left = 200
          Top = 176
          Width = 81
          Height = 21
          AutoCompletion = False
          DropDownCount = 16
          Flat = True
          HandleDialogKeys = False
          HorizontalScroll = False
          ItemIndex = -1
          ItemHeight = 13
          Style = csDropDownList
          TabOrder = 9
          Items.Strings = (
            'None'
            'Raised'
            'Flat'
            'Sunken')
        end
        object StrikeLineColorCB: TElAdvancedComboBox
          Left = 200
          Top = 30
          Width = 81
          Height = 21
          AutoCompletion = False
          DropDownCount = 16
          Enabled = False
          Flat = True
          HandleDialogKeys = False
          HorizontalScroll = False
          ItemIndex = -1
          ItemHeight = 13
          TabOrder = 14
          Items.Strings = (
            'clAqua'
            'clBlack'
            'clBlue'
            'clDkGray'
            'clFuchsia'
            'clGray'
            'clGreen'
            'clLime'
            'clLtGray'
            'clMaroon'
            'clNavy'
            'clOlive'
            'clPurple'
            'clRed'
            'clSilver'
            'clTeal'
            'clWhite'
            'clYellow'
            'clActiveBorder'
            'clActiveCaption'
            'clAppWorkSpace'
            'clBackground'
            'clBtnFace'
            'clBtnHighlight'
            'clBtnShadow'
            'clBtnText'
            'clCaptionText'
            'clGrayText'
            'clHighlight'
            'clHighlightText'
            'clInactiveBorder'
            'clInactiveCaption'
            'clInactiveCaptionText'
            'clMenu'
            'clMenuText'
            'clScrollBar'
            'clWindow'
            'clWindowFrame'
            'clWindowText')
        end
      end
    end
    object TabSheet2: TElTabSheet
      PageControl = PageControl1
      Caption = 'Relations'
      Visible = False
      object ListStyle: TTabControl
        Left = 0
        Top = 0
        Width = 679
        Height = 527
        Align = alClient
        TabOrder = 0
        OnChange = ListStyleChange
        OnChanging = ListStyleChanging
        object Styles1: TElGroupBox
          Left = 4
          Top = 6
          Width = 342
          Height = 517
          Align = alClient
          ParentColor = True
          TabOrder = 0
          object StylesCB1: TElCheckBox
            Left = 8
            Top = 14
            Width = 82
            Height = 17
            Hint = 
              'When checked, tree settings are used. when unchecked, item'#39's fon' +
              't styles are used.'
            Flat = True
            FlatAlways = True
            Caption = 'Owner styles'
            TabOrder = 0
            OnClick = StylesCB1Click
          end
          object ColorsCB1: TElCheckBox
            Left = 104
            Top = 14
            Width = 84
            Height = 17
            Hint = 
              'When checked, tree colors are used. When unchecked, item'#39's own c' +
              'olors are used.'
            Flat = True
            FlatAlways = True
            Caption = 'Owner colors'
            TabOrder = 1
            OnClick = ColorsCB1Click
          end
          object StylesGB1: TElGroupBox
            Left = 8
            Top = 32
            Width = 89
            Height = 105
            ParentColor = True
            TabOrder = 2
            object BoldCB1: TElCheckBox
              Left = 8
              Top = 59
              Width = 43
              Height = 17
              Flat = True
              FlatAlways = True
              Caption = 'Bold'
              TabOrder = 2
            end
            object ItCB1: TElCheckBox
              Left = 8
              Top = 16
              Width = 44
              Height = 17
              Flat = True
              FlatAlways = True
              Caption = 'Italic'
              TabOrder = 0
            end
            object ULCB1: TElCheckBox
              Left = 8
              Top = 37
              Width = 73
              Height = 17
              Flat = True
              FlatAlways = True
              Caption = 'Underlined'
              TabOrder = 1
            end
            object StrikeCB1: TElCheckBox
              Left = 8
              Top = 80
              Width = 64
              Height = 17
              Flat = True
              FlatAlways = True
              Caption = 'Strikeout'
              TabOrder = 3
            end
          end
          object ColorsGB1: TElGroupBox
            Left = 104
            Top = 32
            Width = 209
            Height = 105
            Enabled = False
            ParentColor = True
            TabOrder = 3
            object Label20: TElLabel
              Left = 8
              Top = 16
              Width = 24
              Height = 13
              Caption = 'Font:'
              Transparent = False
            end
            object Label22: TElLabel
              Left = 112
              Top = 56
              Width = 86
              Height = 13
              Caption = 'Row Background:'
              Transparent = False
            end
            object Label21: TElLabel
              Left = 112
              Top = 16
              Width = 85
              Height = 13
              Caption = 'Text Background:'
              Transparent = False
            end
            object UseBkColorCB1: TElCheckBox
              Left = 8
              Top = 56
              Width = 86
              Height = 17
              Flat = True
              FlatAlways = True
              Caption = 'Use BkColors'
              TabOrder = 2
            end
            object ColorCombo1: TElAdvancedComboBox
              Left = 8
              Top = 32
              Width = 81
              Height = 21
              AutoCompletion = False
              Ctl3D = True
              DropDownCount = 16
              Flat = True
              HandleDialogKeys = False
              HorizontalScroll = False
              ItemIndex = -1
              ItemHeight = 13
              ParentCtl3D = False
              TabOrder = 0
              Items.Strings = (
                'clAqua'
                'clBlack'
                'clBlue'
                'clDkGray'
                'clFuchsia'
                'clGray'
                'clGreen'
                'clLime'
                'clLtGray'
                'clMaroon'
                'clNavy'
                'clOlive'
                'clPurple'
                'clRed'
                'clSilver'
                'clTeal'
                'clWhite'
                'clYellow'
                'clActiveBorder'
                'clActiveCaption'
                'clAppWorkSpace'
                'clBackground'
                'clBtnFace'
                'clBtnHighlight'
                'clBtnShadow'
                'clBtnText'
                'clCaptionText'
                'clGrayText'
                'clHighlight'
                'clHighlightText'
                'clInactiveBorder'
                'clInactiveCaption'
                'clInactiveCaptionText'
                'clMenu'
                'clMenuText'
                'clScrollBar'
                'clWindow'
                'clWindowFrame'
                'clWindowText')
            end
            object RowBkColorCombo1: TElAdvancedComboBox
              Left = 112
              Top = 72
              Width = 81
              Height = 21
              AutoCompletion = False
              DropDownCount = 16
              Flat = True
              HandleDialogKeys = False
              HorizontalScroll = False
              ItemIndex = -1
              ItemHeight = 13
              TabOrder = 1
              Items.Strings = (
                'clAqua'
                'clBlack'
                'clBlue'
                'clDkGray'
                'clFuchsia'
                'clGray'
                'clGreen'
                'clLime'
                'clLtGray'
                'clMaroon'
                'clNavy'
                'clOlive'
                'clPurple'
                'clRed'
                'clSilver'
                'clSkyBlue'
                'clMoneyGreen'
                'clTeal'
                'clWhite'
                'clYellow'
                'clActiveBorder'
                'clActiveCaption'
                'clAppWorkSpace'
                'clBackground'
                'clBtnFace'
                'clBtnHighlight'
                'clBtnShadow'
                'clBtnText'
                'clCaptionText'
                'clGrayText'
                'clHighlight'
                'clHighlightText'
                'clInactiveBorder'
                'clInactiveCaption'
                'clInactiveCaptionText'
                'clMenu'
                'clMenuText'
                'clScrollBar'
                'clWindow'
                'clWindowFrame'
                'clWindowText')
            end
            object BkColorCombo1: TElAdvancedComboBox
              Left = 112
              Top = 32
              Width = 81
              Height = 21
              AutoCompletion = False
              DropDownCount = 16
              Flat = True
              HandleDialogKeys = False
              HorizontalScroll = False
              ItemIndex = -1
              ItemHeight = 13
              TabOrder = 3
              Items.Strings = (
                'clAqua'
                'clBlack'
                'clBlue'
                'clDkGray'
                'clFuchsia'
                'clGray'
                'clGreen'
                'clLime'
                'clLtGray'
                'clMaroon'
                'clNavy'
                'clOlive'
                'clPurple'
                'clRed'
                'clSilver'
                'clSkyBlue'
                'clMoneyGreen'
                'clTeal'
                'clWhite'
                'clYellow'
                'clActiveBorder'
                'clActiveCaption'
                'clAppWorkSpace'
                'clBackground'
                'clBtnFace'
                'clBtnHighlight'
                'clBtnShadow'
                'clBtnText'
                'clCaptionText'
                'clGrayText'
                'clHighlight'
                'clHighlightText'
                'clInactiveBorder'
                'clInactiveCaption'
                'clInactiveCaptionText'
                'clMenu'
                'clMenuText'
                'clScrollBar'
                'clWindow'
                'clWindowFrame'
                'clWindowText')
            end
          end
          object ShowChecksCB1: TElCheckBox
            Left = 8
            Top = 144
            Width = 100
            Height = 17
            Flat = True
            FlatAlways = True
            Caption = 'Show Checkbox'
            TabOrder = 4
            OnClick = ShowChecksCB1Click
          end
          object CBGroup1: TElGroupBox
            Left = 8
            Top = 162
            Width = 169
            Height = 89
            Enabled = False
            ParentColor = True
            TabOrder = 5
            object Label1: TElLabel
              Left = 8
              Top = 32
              Width = 71
              Height = 13
              Caption = 'CheckBox field'
              Transparent = False
              Enabled = False
            end
            object CBEnabledCB1: TElCheckBox
              Left = 8
              Top = 8
              Width = 61
              Height = 17
              Flat = True
              FlatAlways = True
              Caption = 'Enabled'
              TabOrder = 0
            end
            object CheckBoxCB1: TElAdvancedComboBox
              Left = 8
              Top = 56
              Width = 145
              Height = 21
              AutoCompletion = False
              Enabled = False
              Flat = True
              HandleDialogKeys = False
              HorizontalScroll = False
              ItemIndex = -1
              ItemHeight = 13
              TabOrder = 1
            end
          end
          object ImagesGB1: TElRadioGroup
            Left = 184
            Top = 162
            Width = 137
            Height = 63
            Caption = 'Item images:'
            Flat = True
            FlatAlways = True
            ItemIndex = 0
            Items.Strings = (
              'User defined'
              'Table field')
            TabOrder = 6
            OnClick = ImagesGB1Click
          end
          object Image0GB1: TElGroupBox
            Left = 184
            Top = 228
            Width = 137
            Height = 81
            ParentColor = True
            TabOrder = 7
            object Label2: TElLabel
              Left = 8
              Top = 24
              Width = 36
              Height = 21
              Caption = 'Normal:'
              Transparent = False
              AutoSize = False
              Layout = tlCenter
            end
            object Label3: TElLabel
              Left = 8
              Top = 48
              Width = 28
              Height = 21
              Caption = 'State:'
              Transparent = False
              AutoSize = False
              Layout = tlCenter
            end
            object Label6: TElLabel
              Left = 48
              Top = 8
              Width = 17
              Height = 13
              Caption = '1st:'
              Transparent = False
            end
            object Label13: TElLabel
              Left = 88
              Top = 8
              Width = 21
              Height = 13
              Caption = '2nd:'
              Transparent = False
            end
            object IndexEdit1: TElEdit
              Left = 48
              Top = 24
              Width = 33
              Height = 21
              Text = '-1'
              Flat = True
              LineBorderActiveColor = clBlack
              LineBorderInactiveColor = clBlack
              TabOrder = 0
            end
            object Index2Edit1: TElEdit
              Left = 88
              Top = 24
              Width = 33
              Height = 21
              Text = '-1'
              Flat = True
              LineBorderActiveColor = clBlack
              LineBorderInactiveColor = clBlack
              TabOrder = 1
            end
            object StIndexEdit1: TElEdit
              Left = 48
              Top = 48
              Width = 33
              Height = 21
              Text = '-1'
              Flat = True
              LineBorderActiveColor = clBlack
              LineBorderInactiveColor = clBlack
              TabOrder = 2
            end
            object StIndex2Edit1: TElEdit
              Left = 88
              Top = 48
              Width = 33
              Height = 21
              Text = '-1'
              Flat = True
              LineBorderActiveColor = clBlack
              LineBorderInactiveColor = clBlack
              TabOrder = 3
            end
          end
          object Image1GB1: TElGroupBox
            Left = 8
            Top = 311
            Width = 313
            Height = 89
            ParentColor = True
            TabOrder = 8
            object Label17: TElLabel
              Left = 8
              Top = 24
              Width = 33
              Height = 13
              Caption = 'Normal'
              Transparent = False
              Enabled = False
            end
            object Label18: TElLabel
              Left = 8
              Top = 64
              Width = 25
              Height = 13
              Caption = 'State'
              Transparent = False
              Enabled = False
            end
            object Label19: TElLabel
              Left = 64
              Top = 8
              Width = 17
              Height = 13
              Caption = '1st:'
              Transparent = False
              Enabled = False
            end
            object Label23: TElLabel
              Left = 208
              Top = 8
              Width = 21
              Height = 13
              Caption = '2nd:'
              Transparent = False
              Enabled = False
            end
            object ImageCB1: TElAdvancedComboBox
              Left = 64
              Top = 24
              Width = 97
              Height = 21
              AutoCompletion = False
              Enabled = False
              Flat = True
              HandleDialogKeys = False
              HorizontalScroll = False
              ItemIndex = -1
              ItemHeight = 13
              TabOrder = 0
            end
            object StImageCB1: TElAdvancedComboBox
              Left = 64
              Top = 56
              Width = 97
              Height = 21
              AutoCompletion = False
              Enabled = False
              Flat = True
              HandleDialogKeys = False
              HorizontalScroll = False
              ItemIndex = -1
              ItemHeight = 13
              TabOrder = 1
            end
            object Image2CB1: TElAdvancedComboBox
              Left = 208
              Top = 24
              Width = 97
              Height = 21
              AutoCompletion = False
              Enabled = False
              Flat = True
              HandleDialogKeys = False
              HorizontalScroll = False
              ItemIndex = -1
              ItemHeight = 13
              TabOrder = 2
            end
            object StImage2CB1: TElAdvancedComboBox
              Left = 208
              Top = 56
              Width = 97
              Height = 21
              AutoCompletion = False
              Enabled = False
              Flat = True
              HandleDialogKeys = False
              HorizontalScroll = False
              ItemIndex = -1
              ItemHeight = 13
              TabOrder = 3
            end
          end
          object UsePatternCB1: TElCheckBox
            Left = 8
            Top = 400
            Width = 75
            Height = 17
            Flat = True
            FlatAlways = True
            Caption = 'UsePattern'
            TabOrder = 9
            OnClick = UsePatternCB1Click
          end
          object PatternGB1: TElGroupBox
            Left = 8
            Top = 415
            Width = 305
            Height = 81
            Enabled = False
            ParentColor = True
            TabOrder = 10
            object SpeedButton2: TElGraphicButton
              Left = 272
              Top = 12
              Width = 23
              Height = 22
              Hint = 'Add field in pattern'
              Caption = '+'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = SpeedButton2Click
            end
            object Label31: TElLabel
              Left = 8
              Top = 16
              Width = 41
              Height = 13
              Caption = 'Add field'
              Transparent = False
              Enabled = False
            end
            object PatternE1: TElEdit
              Left = 8
              Top = 48
              Width = 289
              Height = 21
              AutoSize = False
              AlignBottom = False
              Text = '+'
              Flat = True
              LineBorderActiveColor = clBlack
              LineBorderInactiveColor = clBlack
              Multiline = True
              TabOrder = 1
            end
            object PatternCB1: TElAdvancedComboBox
              Left = 80
              Top = 12
              Width = 193
              Height = 21
              AutoCompletion = False
              Enabled = False
              Flat = True
              HandleDialogKeys = False
              HorizontalScroll = False
              ItemIndex = -1
              ItemHeight = 13
              TabOrder = 0
            end
          end
        end
        object Misc1: TElGroupBox
          Left = 346
          Top = 6
          Width = 329
          Height = 517
          Align = alRight
          ParentColor = True
          TabOrder = 1
          object Label34: TElLabel
            Left = 184
            Top = 160
            Width = 84
            Height = 13
            Caption = 'Item'#39's border style'
            Transparent = False
          end
          object EnabledCB1: TElCheckBox
            Left = 8
            Top = 12
            Width = 61
            Height = 17
            Hint = 
              'When checked, the item is enabled. Disabled items don'#39't respond ' +
              'to mouse clicks and can'#39't be selected.'
            Flat = True
            FlatAlways = True
            Caption = 'Enabled'
            TabOrder = 0
          end
          object HiddenCB1: TElCheckBox
            Left = 8
            Top = 36
            Width = 56
            Height = 17
            Hint = 'When checked, the item is not visible'
            Flat = True
            FlatAlways = True
            Caption = 'Hidden'
            TabOrder = 1
          end
          object HtmlCB1: TElCheckBox
            Left = 8
            Top = 60
            Width = 96
            Height = 17
            Hint = 
              'When checked, text that starts with <html> is treated as HTML te' +
              'xt'
            Flat = True
            FlatAlways = True
            Caption = 'Contains HTML'
            TabOrder = 2
          end
          object MultilineCB1: TElCheckBox
            Left = 8
            Top = 84
            Width = 126
            Height = 17
            Hint = 'When checked, item has multi-line text. '
            Flat = True
            FlatAlways = True
            Caption = 'Contains multi-line text'
            TabOrder = 3
          end
          object HorZlineCB1: TElCheckBox
            Left = 8
            Top = 108
            Width = 114
            Height = 17
            Flat = True
            FlatAlways = True
            Caption = 'Draw horizontal line'
            TabOrder = 4
          end
          object AllowEditCB1: TElCheckBox
            Left = 8
            Top = 132
            Width = 67
            Height = 17
            Flat = True
            FlatAlways = True
            Caption = 'Allow edit'
            TabOrder = 5
          end
          object ForcedBtnsCB1: TElCheckBox
            Left = 8
            Top = 180
            Width = 93
            Height = 17
            Hint = 
              'When checked buttons will be displayed even when the item doesn'#39 +
              't have children'
            Flat = True
            FlatAlways = True
            Caption = 'Forced buttons'
            TabOrder = 6
          end
          object SuppressButtonsCB1: TElCheckBox
            Left = 8
            Top = 204
            Width = 116
            Height = 17
            Hint = 
              'When checked, no buttons will be displayed even when the item ha' +
              's children'
            Flat = True
            FlatAlways = True
            Caption = 'Suppressed buttons'
            TabOrder = 7
          end
          object SuppressLinesCB1: TElCheckBox
            Left = 8
            Top = 228
            Width = 102
            Height = 17
            Hint = 'When checked, no tree lines are drawn for the item'
            Flat = True
            FlatAlways = True
            Caption = 'Suppressed lines'
            TabOrder = 8
          end
          object IndentEdit1: TElEdit
            Left = 200
            Top = 132
            Width = 33
            Height = 21
            Text = 'Al'
            Flat = True
            LineBorderActiveColor = clBlack
            LineBorderInactiveColor = clBlack
            TabOrder = 10
          end
          object IndentAdjustCB1: TElCheckBox
            Left = 184
            Top = 112
            Width = 127
            Height = 17
            Hint = 
              'When checked item indentation is adjusted accoring to adjustment' +
              ' value.'
            Flat = True
            FlatAlways = True
            Caption = 'Use indent adjustment'
            TabOrder = 11
            OnClick = IndentAdjustCB1Click
          end
          object HeightEdit1: TElEdit
            Left = 200
            Top = 82
            Width = 33
            Height = 21
            Text = 'Al'
            Flat = True
            LineBorderActiveColor = clBlack
            LineBorderInactiveColor = clBlack
            TabOrder = 12
          end
          object OwnHeightCB1: TElCheckBox
            Left = 184
            Top = 64
            Width = 76
            Height = 17
            Flat = True
            FlatAlways = True
            Caption = 'Own height'
            TabOrder = 13
            OnClick = OwnHeightCB1Click
          end
          object StrikeOutCB1: TElCheckBox
            Left = 184
            Top = 12
            Width = 73
            Height = 17
            Hint = 'When checked the item is striked out. '
            Flat = True
            FlatAlways = True
            Caption = 'Striked out'
            TabOrder = 15
            OnClick = StrikeOutCB1Click
          end
          object GroupBox1: TElGroupBox
            Left = 8
            Top = 298
            Width = 313
            Height = 184
            ParentColor = True
            TabOrder = 16
            object Label28: TElLabel
              Left = 8
              Top = 13
              Width = 41
              Height = 13
              Caption = 'Hint field'
              Transparent = False
              Enabled = False
            end
            object Label29: TElLabel
              Left = 8
              Top = 80
              Width = 39
              Height = 13
              Caption = 'Hint text'
              Transparent = False
            end
            object HintRG1: TElRadioGroup
              Left = 168
              Top = 9
              Width = 137
              Height = 63
              Caption = ' Item hint  '
              Flat = True
              FlatAlways = True
              ItemIndex = 0
              Items.Strings = (
                'User defined'
                'Table field')
              TabOrder = 0
              OnClick = HintRG1Click
            end
            object HintED1: TElEdit
              Left = 8
              Top = 96
              Width = 297
              Height = 81
              AutoSize = False
              AlignBottom = False
              Text = 'Ta'
              Flat = True
              LineBorderActiveColor = clBlack
              LineBorderInactiveColor = clBlack
              Multiline = True
              ScrollBars = ssVertical
              TabOrder = 2
            end
            object HTMLCBL1: TElCheckBox
              Left = 8
              Top = 57
              Width = 117
              Height = 17
              Flat = True
              FlatAlways = True
              Caption = 'Hint contains HTML'
              TabOrder = 3
            end
            object HintCB1: TElAdvancedComboBox
              Left = 8
              Top = 29
              Width = 145
              Height = 21
              AutoCompletion = False
              Enabled = False
              Flat = True
              HandleDialogKeys = False
              HorizontalScroll = False
              ItemIndex = -1
              ItemHeight = 13
              TabOrder = 1
            end
          end
          object BorderStyleCombo1: TElAdvancedComboBox
            Left = 200
            Top = 176
            Width = 81
            Height = 21
            AutoCompletion = False
            DropDownCount = 16
            Flat = True
            HandleDialogKeys = False
            HorizontalScroll = False
            ItemIndex = -1
            ItemHeight = 13
            Style = csDropDownList
            TabOrder = 9
            Items.Strings = (
              'None'
              'Raised'
              'Flat'
              'Sunken')
          end
          object StrikeLineColorCB1: TElAdvancedComboBox
            Left = 200
            Top = 30
            Width = 81
            Height = 21
            AutoCompletion = False
            DropDownCount = 16
            Enabled = False
            Flat = True
            HandleDialogKeys = False
            HorizontalScroll = False
            ItemIndex = -1
            ItemHeight = 13
            TabOrder = 14
            Items.Strings = (
              'clAqua'
              'clBlack'
              'clBlue'
              'clDkGray'
              'clFuchsia'
              'clGray'
              'clGreen'
              'clLime'
              'clLtGray'
              'clMaroon'
              'clNavy'
              'clOlive'
              'clPurple'
              'clRed'
              'clSilver'
              'clTeal'
              'clWhite'
              'clYellow'
              'clActiveBorder'
              'clActiveCaption'
              'clAppWorkSpace'
              'clBackground'
              'clBtnFace'
              'clBtnHighlight'
              'clBtnShadow'
              'clBtnText'
              'clCaptionText'
              'clGrayText'
              'clHighlight'
              'clHighlightText'
              'clInactiveBorder'
              'clInactiveCaption'
              'clInactiveCaptionText'
              'clMenu'
              'clMenuText'
              'clScrollBar'
              'clWindow'
              'clWindowFrame'
              'clWindowText')
          end
        end
      end
    end
  end
  object Panel1: TElPanel
    Left = 0
    Top = 552
    Width = 685
    Height = 41
    Align = alBottom
    TabOrder = 1
    DockOrientation = doNoOrient
    object OKBtn: TElPopupButton
      Left = 249
      Top = 8
      Width = 75
      Height = 25
      Default = True
      ModalResult = 1
      Caption = '&OK'
      TabOrder = 0
      OnClick = OKBtnClick
    end
    object Button1: TElPopupButton
      Left = 337
      Top = 8
      Width = 75
      Height = 25
      DrawDefaultFrame = False
      Caption = 'Apply'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
end
