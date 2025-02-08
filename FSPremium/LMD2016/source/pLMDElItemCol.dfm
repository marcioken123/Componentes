object ItemColDlg: TItemColDlg
  Left = 264
  Top = 192
  Width = 332
  Height = 381
  Caption = 'Item Properties Editor'
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
  object ElPageControl1: TElPageControl
    Left = 0
    Top = 0
    Width = 324
    Height = 305
    TabIndex = 0
    ActivePage = ElTabSheet1
    TabMarginRight = 25
    Align = alTop
    TabOrder = 2
    DockOrientation = doNoOrient
    object ElTabSheet1: TElTabSheet
      PageControl = ElPageControl1
      Caption = 'Text'
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
      object Label1: TElLabel
        Left = 8
        Top = 176
        Width = 227
        Height = 13
        Caption = 'Item columns text (multi-line text in run-time only):'
        Transparent = False
      end
      object Label13: TElLabel
        Left = 8
        Top = 94
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
      object FontBtn: TElGraphicButton
        Left = 289
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
      object ColTextMemo: TElMemo
        Left = 8
        Top = 192
        Width = 305
        Height = 81
        Cursor = crDefault
        ScrollBars = ssBoth
        ParentCtl3D = True
        TabOrder = 0
      end
      object HintEdit: TElMemo
        Left = 8
        Top = 110
        Width = 305
        Height = 57
        Cursor = crDefault
        ScrollBars = ssBoth
        ParentCtl3D = True
        TabOrder = 1
      end
      object TextEdit: TElMemo
        Left = 8
        Top = 30
        Width = 305
        Height = 57
        Cursor = crDefault
        ScrollBars = ssBoth
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentCtl3D = True
        ParentFont = False
        TabOrder = 2
      end
    end
    object ElTabSheet2: TElTabSheet
      PageControl = ElPageControl1
      Caption = 'Styles'
      Visible = False
      object Label16: TElLabel
        Left = 184
        Top = 232
        Width = 44
        Height = 22
        Caption = 'Overlay:'
        Transparent = False
        AutoSize = False
        Layout = tlCenter
      end
      object Label11: TElLabel
        Left = 271
        Top = 168
        Width = 21
        Height = 13
        Caption = '2nd:'
        Transparent = False
      end
      object Label10: TElLabel
        Left = 231
        Top = 168
        Width = 17
        Height = 13
        Caption = '1st:'
        Transparent = False
      end
      object Label7: TElLabel
        Left = 184
        Top = 208
        Width = 28
        Height = 21
        Caption = 'State:'
        Transparent = False
        AutoSize = False
        Layout = tlCenter
      end
      object Label6: TElLabel
        Left = 184
        Top = 184
        Width = 44
        Height = 18
        Caption = 'Normal:'
        Transparent = False
        AutoSize = False
        Layout = tlCenter
      end
      object Label3: TElLabel
        Left = 184
        Top = 154
        Width = 59
        Height = 13
        Caption = 'Item images:'
        Transparent = False
      end
      object OvIndex2Edit: TElEdit
        Left = 271
        Top = 232
        Width = 33
        Height = 21
        Cursor = crDefault
        AutoSelect = True
        ParentCtl3D = True
        TabOrder = 0
      end
      object OvIndexEdit: TElEdit
        Left = 231
        Top = 232
        Width = 32
        Height = 21
        Cursor = crDefault
        AutoSelect = True
        ParentCtl3D = True
        TabOrder = 1
      end
      object StIndex2Edit: TElEdit
        Left = 271
        Top = 208
        Width = 33
        Height = 21
        Cursor = crDefault
        AutoSelect = True
        ParentCtl3D = True
        TabOrder = 2
      end
      object Index2Edit: TElEdit
        Left = 271
        Top = 184
        Width = 33
        Height = 21
        Cursor = crDefault
        AutoSelect = True
        ParentCtl3D = True
        TabOrder = 3
      end
      object IndexEdit: TElEdit
        Left = 231
        Top = 184
        Width = 32
        Height = 21
        Cursor = crDefault
        AutoSelect = True
        ParentCtl3D = True
        TabOrder = 4
      end
      object StIndexEdit: TElEdit
        Left = 231
        Top = 208
        Width = 32
        Height = 21
        Cursor = crDefault
        AutoSelect = True
        ParentCtl3D = True
        TabOrder = 5
      end
      object ShowChecksCB: TElCheckBox
        Left = 8
        Top = 152
        Width = 164
        Height = 17
        Caption = 'Show Checkbox/RadioButton'
        TabOrder = 6
        OnClick = ShowChecksCBClick
      end
      object ColorsCB: TElCheckBox
        Left = 104
        Top = 8
        Width = 84
        Height = 17
        Hint = 
          'When checked, tree colors are used. When unchecked, item'#39's own c' +
          'olors are used.'
        Caption = 'Owner colors'
        TabOrder = 7
        OnClick = ColorsCBClick
      end
      object StylesCB: TElCheckBox
        Left = 8
        Top = 8
        Width = 82
        Height = 17
        Hint = 
          'When checked, tree settings are used. when unchecked, item'#39's fon' +
          't styles are used.'
        Caption = 'Owner styles'
        TabOrder = 8
        OnClick = StylesCBClick
      end
      object ColorsGB: TElGroupBox
        Left = 104
        Top = 32
        Width = 209
        Height = 105
        Caption = 'Item Colors'
        ParentColor = True
        TabOrder = 10
        object Label4: TElLabel
          Left = 8
          Top = 16
          Width = 24
          Height = 13
          Caption = 'Font:'
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
        object Label12: TElLabel
          Left = 112
          Top = 56
          Width = 86
          Height = 13
          Caption = 'Row Background:'
          Transparent = False
        end
        object UseBkColorCB: TElCheckBox
          Left = 8
          Top = 56
          Width = 86
          Height = 17
          Caption = 'Use BkColors'
          TabOrder = 0
        end
        object ColorCombo: TElColorCombo
          Left = 8
          Top = 32
          Width = 97
          Height = 21
          Cursor = crIBeam
          Options = [ccoNoColor, cco4BitColors, ccoSystemColors, ccoShowNames]
          SelectedColor = clWindowText
          DropDownCount = 16
          TabOrder = 1
          ParentColor = False
          DockOrientation = doNoOrient
          DoubleBuffered = False
        end
        object BkColorCombo: TElColorCombo
          Left = 112
          Top = 32
          Width = 89
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
        object RowBkColorCombo: TElColorCombo
          Left = 112
          Top = 76
          Width = 89
          Height = 21
          Cursor = crIBeam
          Options = [ccoNoColor, cco4BitColors, ccoSystemColors, ccoShowNames]
          SelectedColor = clWindow
          DropDownCount = 16
          TabOrder = 3
          ParentColor = False
          DockOrientation = doNoOrient
          DoubleBuffered = False
        end
      end
      object CBGroup: TElGroupBox
        Left = 8
        Top = 170
        Width = 169
        Height = 89
        Enabled = False
        ParentColor = True
        TabOrder = 9
        object Label8: TElLabel
          Left = 8
          Top = 32
          Width = 27
          Height = 13
          Caption = 'Type:'
          Transparent = False
          Alignment = taRightJustify
          AutoSize = False
          Enabled = False
          Layout = tlCenter
        end
        object Label9: TElLabel
          Left = 8
          Top = 64
          Width = 28
          Height = 13
          Caption = 'State:'
          Transparent = False
          Alignment = taRightJustify
          AutoSize = False
          Enabled = False
          Layout = tlCenter
        end
        object CBEnabledCB: TElCheckBox
          Left = 8
          Top = 8
          Width = 61
          Height = 17
          Caption = 'Enabled'
          Enabled = False
          TabOrder = 0
        end
        object CBTypeCombo: TElComboBox
          Left = 48
          Top = 32
          Width = 113
          Height = 21
          Cursor = crIBeam
          DropDownCount = 3
          Items.Strings = (
            '2-State CheckBox'
            '3-State CheckBox'
            'RadioButton')
          Style = csDropDownList
          ItemHeight = 13
          OnChange = CBTypeComboChange
          Enabled = False
          TabOrder = 1
          ParentColor = False
        end
        object CBStateCombo: TElComboBox
          Left = 48
          Top = 64
          Width = 113
          Height = 21
          Cursor = crIBeam
          DropDownCount = 3
          Items.Strings = (
            'Unchecked'
            'Checked'
            'Grayed')
          Style = csDropDownList
          ItemHeight = 13
          Enabled = False
          TabOrder = 2
          ParentColor = False
        end
      end
      object StylesGB: TElGroupBox
        Left = 8
        Top = 32
        Width = 89
        Height = 105
        Caption = 'Item Styles'
        ParentColor = True
        TabOrder = 11
        object BoldCB: TElCheckBox
          Left = 8
          Top = 59
          Width = 43
          Height = 17
          Caption = 'Bold'
          TabOrder = 2
        end
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
        object StrikeCB: TElCheckBox
          Left = 8
          Top = 80
          Width = 64
          Height = 17
          Caption = 'Strikeout'
          TabOrder = 3
        end
      end
    end
    object ElTabSheet3: TElTabSheet
      PageControl = ElPageControl1
      Caption = 'Misc'
      Visible = False
      object Label15: TElLabel
        Left = 184
        Top = 152
        Width = 84
        Height = 13
        Caption = 'Item'#39's border style'
        Transparent = False
      end
      object Label14: TElLabel
        Left = 184
        Top = 192
        Width = 22
        Height = 13
        Caption = 'Tag:'
        Transparent = False
        Layout = tlCenter
      end
      object StrikeLineColorCB: TElColorCombo
        Left = 202
        Top = 24
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
      object BorderStyleCombo: TElComboBox
        Left = 200
        Top = 168
        Width = 97
        Height = 21
        Cursor = crIBeam
        Hint = 'Color of strikeout line.'
        DropDownCount = 16
        Items.Strings = (
          'None'
          'Raised'
          'Flat'
          'Sunken')
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        ParentColor = False
      end
      object IndentEdit: TElEdit
        Left = 200
        Top = 124
        Width = 33
        Height = 21
        Cursor = crDefault
        AutoSelect = True
        ParentCtl3D = True
        TabOrder = 2
      end
      object HeightEdit: TElEdit
        Left = 200
        Top = 74
        Width = 33
        Height = 21
        Cursor = crDefault
        AutoSelect = True
        ParentCtl3D = True
        TabOrder = 3
      end
      object TagEdit: TElEdit
        Left = 200
        Top = 208
        Width = 33
        Height = 21
        Cursor = crDefault
        AutoSelect = True
        ParentCtl3D = True
        TabOrder = 4
      end
      object WholeLineCB: TElCheckBox
        Left = 184
        Top = 236
        Width = 72
        Height = 17
        Hint = 
          'Main tree text occupies whole line (from main tree column to the' +
          ' right)'
        Caption = 'Whole line'
        TabOrder = 5
      end
      object WordWrapCB: TElCheckBox
        Left = 8
        Top = 124
        Width = 134
        Height = 17
        Hint = 'When checked, multiline text will be word-wrapped.'
        Caption = 'Word wrap multiline text'
        TabOrder = 6
      end
      object CheckBox1: TElCheckBox
        Left = 8
        Top = 76
        Width = 117
        Height = 17
        Hint = 
          'When checked, text that starts with <html> is treated as HTML te' +
          'xt'
        Caption = 'Hint contains HTML'
        TabOrder = 7
        Visible = False
      end
      object SuppressLinesCB: TElCheckBox
        Left = 8
        Top = 244
        Width = 102
        Height = 17
        Hint = 'When checked, no tree lines are drawn for the item'
        Caption = 'Suppressed lines'
        TabOrder = 8
      end
      object IndentAdjustCB: TElCheckBox
        Left = 184
        Top = 104
        Width = 127
        Height = 17
        Hint = 
          'When checked item indentation is adjusted accoring to adjustment' +
          ' value.'
        Caption = 'Use indent adjustment'
        TabOrder = 9
        OnClick = IndentAdjustCBClick
      end
      object OwnHeightCB: TElCheckBox
        Left = 184
        Top = 56
        Width = 76
        Height = 17
        Caption = 'Own height'
        TabOrder = 10
        OnClick = OwnHeightCBClick
      end
      object MultilineCB: TElCheckBox
        Left = 8
        Top = 100
        Width = 126
        Height = 17
        Hint = 'When checked, item has multi-line text. '
        Caption = 'Contains multi-line text'
        TabOrder = 11
      end
      object SuppressButtonsCB: TElCheckBox
        Left = 8
        Top = 220
        Width = 116
        Height = 17
        Hint = 
          'When checked, no buttons will be displayed even when the item ha' +
          's children'
        Caption = 'Suppressed buttons'
        TabOrder = 12
      end
      object AllowEditCB: TElCheckBox
        Left = 8
        Top = 172
        Width = 67
        Height = 17
        Caption = 'Allow edit'
        TabOrder = 13
      end
      object HorZlineCB: TElCheckBox
        Left = 8
        Top = 148
        Width = 114
        Height = 17
        Caption = 'Draw horizontal line'
        TabOrder = 14
      end
      object StrikeOutCB: TElCheckBox
        Left = 184
        Top = 4
        Width = 73
        Height = 17
        Hint = 'When checked the item is striked out. '
        Caption = 'Striked out'
        TabOrder = 15
        OnClick = StrikeOutCBClick
      end
      object HtmlCB: TElCheckBox
        Left = 8
        Top = 52
        Width = 96
        Height = 17
        Hint = 
          'When checked, text that starts with <html> is treated as HTML te' +
          'xt'
        Caption = 'Contains HTML'
        TabOrder = 16
      end
      object HiddenCB: TElCheckBox
        Left = 8
        Top = 28
        Width = 56
        Height = 17
        Hint = 'When checked, the item is not visible'
        Caption = 'Hidden'
        TabOrder = 17
      end
      object EnabledCB: TElCheckBox
        Left = 8
        Top = 4
        Width = 61
        Height = 17
        Hint = 
          'When checked, the item is enabled. Disabled items don'#39't respond ' +
          'to mouse clicks and can'#39't be selected.'
        Caption = 'Enabled'
        TabOrder = 18
      end
      object ForcedBtnsCB: TElCheckBox
        Left = 8
        Top = 196
        Width = 93
        Height = 17
        Hint = 
          'When checked buttons will be displayed even when the item doesn'#39 +
          't have children'
        Caption = 'Forced buttons'
        TabOrder = 19
      end
    end
  end
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
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 240
    Top = 99
  end
end
