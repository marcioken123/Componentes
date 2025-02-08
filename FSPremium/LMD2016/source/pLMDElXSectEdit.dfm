object XSectEdit: TXSectEdit
  Left = 365
  Top = 206
  Width = 452
  Height = 396
  Caption = 'Editing Header Section'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label6: TLabel
    Left = 263
    Top = 118
    Width = 60
    Height = 13
    Caption = 'Ima&ge index:'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 325
    Width = 444
    Height = 2
    Align = alBottom
  end
  object GroupBox1: TGroupBox
    Left = 6
    Top = 4
    Width = 250
    Height = 214
    Caption = ' General '
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 21
      Width = 24
      Height = 13
      Caption = '&Text:'
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 9
      Top = 47
      Width = 25
      Height = 13
      Caption = '&Field:'
      Layout = tlCenter
    end
    object Label11: TLabel
      Left = 9
      Top = 75
      Width = 22
      Height = 13
      Caption = '&Hint:'
    end
    object Label8: TLabel
      Left = 9
      Top = 101
      Width = 26
      Height = 13
      Caption = 'St&yle:'
    end
    object Label7: TLabel
      Left = 9
      Top = 129
      Width = 105
      Height = 13
      Caption = 'Column &contents type:'
    end
    object Label9: TLabel
      Left = 9
      Top = 156
      Width = 63
      Height = 13
      Caption = '&Popup menu:'
    end
    object Label10: TLabel
      Left = 9
      Top = 183
      Width = 71
      Height = 13
      Caption = 'Pa&rent section:'
    end
    object VisCB: TElCheckBox
      Left = 177
      Top = 101
      Width = 55
      Height = 17
      Caption = ' Visible'
      TabOrder = 3
    end
    object TextEB: TElEdit
      Left = 41
      Top = 19
      Width = 201
      Height = 21
      Cursor = crDefault
      AutoSelect = True
      ParentCtl3D = True
      TabOrder = 0
    end
    object FieldEdit: TElEdit
      Left = 41
      Top = 45
      Width = 201
      Height = 21
      Cursor = crDefault
      AutoSelect = True
      ParentCtl3D = True
      TabOrder = 1
    end
    object HintEdit: TElEdit
      Left = 41
      Top = 72
      Width = 201
      Height = 21
      Cursor = crDefault
      AutoSelect = True
      ParentCtl3D = True
      TabOrder = 2
    end
    object StyleCombo: TElComboBox
      Left = 41
      Top = 99
      Width = 115
      Height = 21
      Cursor = crIBeam
      Items.Strings = (
        'Text (and image)'
        'Ownerdraw'
        'Image only '
        'Image index')
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
      ParentColor = False
    end
    object ColTypeCB: TElComboBox
      Left = 120
      Top = 126
      Width = 122
      Height = 21
      Cursor = crIBeam
      Items.Strings = (
        'Custom'
        'Text'
        'Integer'
        'Float'
        'Date & Time'
        'Date'
        'Time'
        'Picture'
        'Enumeration'
        'BLOB field'
        'Boolean'
        'Currency'
        'Memo')
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      ParentColor = False
    end
    object PopupCombo: TElComboBox
      Left = 90
      Top = 153
      Width = 152
      Height = 21
      Cursor = crIBeam
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 6
      ParentColor = False
    end
    object ParentCombo: TElComboBox
      Left = 90
      Top = 180
      Width = 152
      Height = 21
      Cursor = crIBeam
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 7
      ParentColor = False
    end
  end
  object GroupBox2: TGroupBox
    Left = 261
    Top = 4
    Width = 175
    Height = 103
    Caption = ' Bounds '
    TabOrder = 1
    object Label2: TLabel
      Left = 10
      Top = 21
      Width = 28
      Height = 13
      Caption = '&Width'
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 10
      Top = 48
      Width = 45
      Height = 13
      Caption = 'Mi&n width'
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 10
      Top = 75
      Width = 48
      Height = 13
      Caption = 'Ma&x width'
      Layout = tlCenter
    end
    object WidthEB: TElEdit
      Left = 66
      Top = 18
      Width = 100
      Height = 21
      Cursor = crDefault
      AutoSelect = True
      ParentCtl3D = True
      TabOrder = 0
    end
    object MinWidthEB: TElEdit
      Left = 66
      Top = 45
      Width = 100
      Height = 21
      Cursor = crDefault
      AutoSelect = True
      ParentCtl3D = True
      TabOrder = 1
    end
    object MaxWidthEB: TElEdit
      Left = 66
      Top = 72
      Width = 100
      Height = 21
      Cursor = crDefault
      AutoSelect = True
      ParentCtl3D = True
      TabOrder = 2
    end
  end
  object GroupBox3: TGroupBox
    Left = 171
    Top = 223
    Width = 265
    Height = 90
    Caption = ' Options '
    TabOrder = 7
    object ExpandableCB: TElCheckBox
      Left = 7
      Top = 15
      Width = 78
      Height = 17
      Caption = 'Expandable'
      TabOrder = 0
      OnClick = ExpandableCBClick
    end
    object ExpandedCB: TElCheckBox
      Left = 7
      Top = 33
      Width = 70
      Height = 17
      Caption = 'Expanded'
      TabOrder = 1
    end
    object FilterCB: TElCheckBox
      Left = 7
      Top = 51
      Width = 44
      Height = 17
      Caption = 'Filter'
      TabOrder = 2
      OnClick = FilterCBClick
    end
    object LookupCB: TElCheckBox
      Left = 95
      Top = 15
      Width = 58
      Height = 17
      Caption = 'Lookup'
      TabOrder = 3
      OnClick = LookupCBClick
    end
    object ClickCB: TElCheckBox
      Left = 95
      Top = 33
      Width = 65
      Height = 17
      Caption = 'Clickable'
      TabOrder = 4
    end
    object ClickSelCB: TElCheckBox
      Left = 95
      Top = 51
      Width = 81
      Height = 17
      Caption = 'Click selects'
      TabOrder = 5
    end
    object ResizeCB: TElCheckBox
      Left = 186
      Top = 15
      Width = 68
      Height = 17
      Caption = 'Resizable'
      TabOrder = 6
    end
    object PswCB: TElCheckBox
      Left = 186
      Top = 33
      Width = 68
      Height = 17
      Caption = 'Password'
      TabOrder = 7
    end
    object EditCB: TElCheckBox
      Left = 186
      Top = 51
      Width = 60
      Height = 17
      Caption = 'Editable'
      TabOrder = 8
    end
    object AutosizeCB: TElCheckBox
      Left = 7
      Top = 67
      Width = 62
      Height = 17
      Caption = 'Autosize'
      TabOrder = 9
    end
    object ShowSortMarkCB: TElCheckBox
      Left = 95
      Top = 67
      Width = 92
      Height = 17
      Caption = 'Show sortmark'
      TabOrder = 10
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 327
    Width = 444
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 8
    object FontBtn: TElGraphicButton
      Left = 6
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
    object ElPopupButton1: TElPopupButton
      Left = 279
      Top = 6
      Width = 75
      Height = 23
      Default = True
      ModalResult = 1
      Caption = 'OK'
      TabOrder = 0
    end
    object ElPopupButton2: TElPopupButton
      Left = 360
      Top = 6
      Width = 75
      Height = 23
      Cancel = True
      ModalResult = 2
      Caption = 'Cancel'
      TabOrder = 1
    end
  end
  object ImIndexEdit: TElEdit
    Left = 330
    Top = 116
    Width = 106
    Height = 21
    Cursor = crDefault
    AutoSelect = True
    ParentCtl3D = True
    TabOrder = 2
  end
  object ImAlignRG: TElRadioGroup
    Left = 262
    Top = 142
    Width = 89
    Height = 76
    Caption = ' &Image align '
    Items.Strings = (
      ' Left'
      ' Don'#39't draw'
      ' Right')
    TabOrder = 3
  end
  object SortRG: TElRadioGroup
    Left = 355
    Top = 142
    Width = 81
    Height = 76
    Caption = ' &Sort'
    Items.Strings = (
      ' None'
      ' Ascend'
      ' Descend')
    TabOrder = 4
  end
  object AlignRG: TElRadioGroup
    Left = 6
    Top = 223
    Width = 76
    Height = 90
    Caption = ' &Alignment '
    Items.Strings = (
      ' Left'
      ' Center'
      ' Right')
    TabOrder = 5
  end
  object LayoutRG: TElRadioGroup
    Left = 89
    Top = 223
    Width = 76
    Height = 90
    Caption = ' &Layout '
    Items.Strings = (
      ' Top'
      ' Center'
      ' Bottom')
    TabOrder = 6
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 72
    Top = 335
  end
end
