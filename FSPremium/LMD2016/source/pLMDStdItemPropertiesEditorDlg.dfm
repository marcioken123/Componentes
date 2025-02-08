object LMDStdItemForm: TLMDStdItemForm
  Left = 322
  Top = 203
  Anchors = [akTop]
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  ClientHeight = 209
  ClientWidth = 341
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object Button1: TButton
    Left = 263
    Top = 6
    Width = 72
    Height = 24
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 263
    Top = 33
    Width = 72
    Height = 24
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object nb: TNotebook
    Left = 0
    Top = 0
    Width = 256
    Height = 209
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    OnPageChanged = nbPageChanged
    object TPage
      Left = 0
      Top = 0
      Caption = 'StringList'
      object LMDSimplePanel1: TPanel
        Left = 0
        Top = 0
        Width = 256
        Height = 78
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label5: TLabel
          Left = 12
          Top = 13
          Width = 32
          Height = 14
          Caption = 'Index: '
        end
        object IndexS: TLabel
          Left = 53
          Top = 13
          Width = 5
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 221
          Top = 36
          Width = 26
          Height = 14
          Caption = 'Ident:'
        end
        object Label8: TLabel
          Left = 221
          Top = 13
          Width = 90
          Height = 14
          Caption = 'External StringList:'
        end
        object Label9: TLabel
          Left = 12
          Top = 35
          Width = 35
          Height = 14
          Caption = 'Descr.:'
        end
        object LMDSimpleLabel4: TLabel
          Left = 12
          Top = 61
          Width = 32
          Height = 14
          Caption = 'Lines: '
        end
        object l: TLabel
          Left = 53
          Top = 61
          Width = 64
          Height = 12
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edS: TLMDShSpinEdit
          Left = 262
          Top = 33
          Width = 79
          Height = 22
          MaxValue = 65535
          MaxLength = 5
          TabOrder = 2
        end
        object descS: TEdit
          Left = 54
          Top = 33
          Width = 147
          Height = 22
          TabOrder = 1
        end
        object compressedS: TCheckBox
          Left = 119
          Top = 13
          Width = 82
          Height = 13
          Caption = 'Compre&ssed'
          TabOrder = 0
        end
      end
      object ToolBar1: TToolBar
        Left = 0
        Top = 78
        Width = 256
        Height = 30
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 31
        Caption = 'ToolBar1'
        EdgeBorders = [ebTop, ebBottom]
        Flat = True
        ShowCaptions = True
        TabOrder = 1
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Caption = '&File'
          DropdownMenu = mfile
          ImageIndex = 0
          Style = tbsDropDown
        end
        object ToolButton2: TToolButton
          Left = 46
          Top = 0
          Caption = '&Edit'
          DropdownMenu = editmenu
          ImageIndex = 1
          Style = tbsDropDown
        end
      end
      object Editor: TMemo
        Left = 0
        Top = 108
        Width = 256
        Height = 101
        Align = alClient
        HideSelection = False
        ScrollBars = ssBoth
        TabOrder = 2
        WordWrap = False
        OnChange = EditorChange
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Picture'
      object LMDLabel1: TLabel
        Left = 12
        Top = 12
        Width = 32
        Height = 14
        Caption = 'Index: '
      end
      object indexb: TLabel
        Left = 58
        Top = 12
        Width = 5
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LMDLabel4: TLabel
        Left = 12
        Top = 65
        Width = 74
        Height = 14
        Caption = 'Internal Picture:'
      end
      object LMDLabel5: TLabel
        Left = 11
        Top = 182
        Width = 53
        Height = 14
        Caption = 'External Id:'
      end
      object dimLabel: TLabel
        Left = 100
        Top = 129
        Width = 42
        Height = 14
        Caption = 'dimLabel'
      end
      object img: TImage
        Left = 101
        Top = 64
        Width = 105
        Height = 59
      end
      object LMDLabel2: TLabel
        Left = 10
        Top = 155
        Width = 57
        Height = 14
        Caption = 'Description:'
      end
      object Label4: TLabel
        Left = 12
        Top = 40
        Width = 42
        Height = 14
        Caption = 'PixelFmt:'
      end
      object edb: TLMDShSpinEdit
        Left = 101
        Top = 179
        Width = 108
        Height = 22
        MaxValue = 65535
        MaxLength = 5
        TabOrder = 4
      end
      object btnbChange: TButton
        Left = 24
        Top = 88
        Width = 53
        Height = 20
        Caption = '&Change'
        TabOrder = 2
        OnClick = btnWchangeClick
      end
      object compressedb: TCheckBox
        Left = 101
        Top = 15
        Width = 108
        Height = 13
        Caption = 'Compre&ssed'
        TabOrder = 0
      end
      object descb: TEdit
        Left = 101
        Top = 151
        Width = 107
        Height = 22
        TabOrder = 3
      end
      object cmbb: TComboBox
        Left = 101
        Top = 35
        Width = 107
        Height = 22
        Style = csDropDownList
        ItemHeight = 14
        TabOrder = 1
        Items.Strings = (
          'spfDefault'
          'spfMono'
          'spf4bit'
          'spf8bit'
          'spf16bit')
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Wave'
      object LMDSimpleLabel1: TLabel
        Left = 11
        Top = 12
        Width = 32
        Height = 14
        Caption = 'Index: '
      end
      object IndexW: TLabel
        Left = 67
        Top = 12
        Width = 5
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LMDSimpleLabel3: TLabel
        Left = 61
        Top = 161
        Width = 26
        Height = 14
        Caption = 'Ident:'
      end
      object LMDSimpleLabel5: TLabel
        Left = 12
        Top = 138
        Width = 73
        Height = 14
        Caption = 'External Wave:'
      end
      object LMDSimpleLabel2: TLabel
        Left = 97
        Top = 12
        Width = 35
        Height = 14
        Caption = 'Descr.:'
      end
      object edW: TLMDShSpinEdit
        Left = 101
        Top = 157
        Width = 79
        Height = 22
        MaxValue = 65535
        MaxLength = 5
        TabOrder = 3
      end
      object btnWchange: TButton
        Left = 10
        Top = 37
        Width = 53
        Height = 20
        Caption = '&Change'
        TabOrder = 1
        OnClick = btnWchangeClick
      end
      object descw: TEdit
        Left = 137
        Top = 9
        Width = 105
        Height = 22
        TabOrder = 0
      end
      object compressedw: TCheckBox
        Left = 137
        Top = 39
        Width = 99
        Height = 13
        Caption = 'Compre&ssed'
        TabOrder = 2
      end
      object pnlWave: TPanel
        Left = 10
        Top = 71
        Width = 239
        Height = 59
        BevelOuter = bvNone
        TabOrder = 4
        object Label1: TLabel
          Left = 3
          Top = 5
          Width = 69
          Height = 14
          Caption = 'Internal Wave:'
          Transparent = True
        end
        object Label2: TLabel
          Left = 4
          Top = 25
          Width = 24
          Height = 14
          Caption = 'Size:'
          Transparent = True
        end
        object Label3: TLabel
          Left = 128
          Top = 40
          Width = 19
          Height = 14
          Caption = 'Ch.:'
          Transparent = True
        end
        object Bevel1: TBevel
          Left = 3
          Top = 20
          Width = 229
          Height = 5
          Shape = bsTopLine
        end
        object format: TLabel
          Left = 110
          Top = 5
          Width = 3
          Height = 13
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object size: TLabel
          Left = 34
          Top = 25
          Width = 68
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
          Transparent = True
        end
        object bits: TLabel
          Left = 160
          Top = 25
          Width = 68
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
          Transparent = True
        end
        object Label23: TLabel
          Left = 128
          Top = 25
          Width = 15
          Height = 14
          Caption = 'Bit:'
          Transparent = True
        end
        object Channels: TLabel
          Left = 160
          Top = 40
          Width = 68
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
          Transparent = True
        end
        object Label7: TLabel
          Left = 4
          Top = 40
          Width = 17
          Height = 14
          Caption = 'SR:'
          Transparent = True
        end
        object samplerate: TLabel
          Left = 34
          Top = 40
          Width = 68
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
          Transparent = True
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Generic'
      object LMDGLabel1: TLabel
        Left = 12
        Top = 12
        Width = 32
        Height = 14
        Caption = 'Index: '
      end
      object indexg: TLabel
        Left = 58
        Top = 12
        Width = 5
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LMDGLabel4: TLabel
        Left = 12
        Top = 94
        Width = 63
        Height = 14
        Caption = 'Internal Data:'
      end
      object dimlabelg: TLabel
        Left = 9
        Top = 112
        Width = 236
        Height = 15
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LMDGLabel2: TLabel
        Left = 12
        Top = 39
        Width = 57
        Height = 14
        Caption = 'Description:'
      end
      object LMDGLabel5: TLabel
        Left = 12
        Top = 66
        Width = 53
        Height = 14
        Caption = 'External Id:'
      end
      object btngChange: TButton
        Left = 97
        Top = 91
        Width = 53
        Height = 20
        Caption = '&Change'
        TabOrder = 3
        OnClick = btnWchangeClick
      end
      object compressedg: TCheckBox
        Left = 97
        Top = 14
        Width = 99
        Height = 13
        Caption = 'Compre&ssed'
        TabOrder = 0
      end
      object descg: TEdit
        Left = 97
        Top = 34
        Width = 107
        Height = 22
        TabOrder = 1
      end
      object edg: TLMDShSpinEdit
        Left = 97
        Top = 62
        Width = 108
        Height = 22
        MaxValue = 65535
        MaxLength = 5
        TabOrder = 2
      end
      object clear: TButton
        Left = 156
        Top = 91
        Width = 53
        Height = 20
        Caption = 'Clear'
        TabOrder = 4
        OnClick = clearClick
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'ImageListItem'
      object Label10: TLabel
        Left = 6
        Top = 18
        Width = 35
        Height = 14
        Caption = 'Descr.:'
      end
      object lblWidth: TLabel
        Left = 6
        Top = 45
        Width = 30
        Height = 14
        Caption = 'Width:'
      end
      object Label11: TLabel
        Left = 6
        Top = 73
        Width = 40
        Height = 14
        Caption = 'AllocBy:'
      end
      object Label12: TLabel
        Left = 146
        Top = 45
        Width = 33
        Height = 14
        Caption = 'Height:'
      end
      object Label13: TLabel
        Left = 139
        Top = 74
        Width = 42
        Height = 14
        Caption = 'PixelFmt:'
      end
      object Maske: TCheckBox
        Left = 11
        Top = 123
        Width = 105
        Height = 17
        Caption = 'Masked'
        TabOrder = 6
      end
      object compress: TCheckBox
        Left = 11
        Top = 105
        Width = 105
        Height = 17
        Caption = 'Compre&ssed'
        TabOrder = 5
      end
      object ed3: TLMDShSpinEdit
        Left = 61
        Top = 69
        Width = 65
        Height = 22
        TabOrder = 3
      end
      object ed2: TLMDShSpinEdit
        Left = 61
        Top = 41
        Width = 65
        Height = 22
        MaxValue = 10000
        MaxLength = 4
        TabOrder = 1
      end
      object desc: TEdit
        Left = 61
        Top = 13
        Width = 188
        Height = 22
        TabOrder = 0
        Text = 'desc'
      end
      object LMDButton1: TButton
        Left = 101
        Top = 106
        Width = 149
        Height = 36
        Caption = 'Get Dimensions from &Bitmap'
        TabOrder = 7
        OnClick = btnWchangeClick
      end
      object cmb: TComboBox
        Left = 186
        Top = 71
        Width = 64
        Height = 22
        Style = csDropDownList
        ItemHeight = 14
        TabOrder = 4
        Items.Strings = (
          'spfDefault'
          'spfMono'
          'spf4bit'
          'spf8bit'
          'spf16bit')
      end
      object ed1: TLMDShSpinEdit
        Left = 186
        Top = 41
        Width = 65
        Height = 22
        MaxValue = 10000
        MaxLength = 4
        TabOrder = 2
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'BMP2IML'
      object Count: TLabel
        Left = 12
        Top = 38
        Width = 133
        Height = 14
        Caption = 'Number of items to convert:'
      end
      object Label14: TLabel
        Left = 12
        Top = 15
        Width = 55
        Height = 14
        Caption = 'Image Size:'
      end
      object lblsize: TLabel
        Left = 150
        Top = 15
        Width = 3
        Height = 14
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object mk: TCheckBox
        Left = 12
        Top = 60
        Width = 105
        Height = 17
        Caption = 'Masked'
        TabOrder = 1
      end
      object rows: TComboBox
        Left = 150
        Top = 35
        Width = 64
        Height = 22
        Style = csDropDownList
        ItemHeight = 0
        TabOrder = 0
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'AVI2IML'
      object lblframes: TLabel
        Left = 6
        Top = 34
        Width = 51
        Height = 14
        Caption = '0 frame(s)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object aviLoad: TButton
        Left = 8
        Top = 8
        Width = 75
        Height = 22
        Caption = 'Load AVI'
        TabOrder = 0
        OnClick = btnWchangeClick
      end
      object aviPlay: TButton
        Left = 87
        Top = 8
        Width = 75
        Height = 22
        Caption = 'Play'
        TabOrder = 1
        OnClick = btnWchangeClick
      end
      object Ani: TAnimate
        Left = 6
        Top = 48
        Width = 242
        Height = 150
        Active = False
        Repetitions = 1
        StopFrame = 26
        Timers = True
        Transparent = False
      end
      object btnConvert: TButton
        Left = 166
        Top = 8
        Width = 75
        Height = 22
        Caption = 'Convert'
        TabOrder = 2
        OnClick = btnConvertClick
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'WaveStandAlone'
      object Load: TButton
        Left = 11
        Top = 70
        Width = 55
        Height = 24
        Caption = 'Load'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnWchangeClick
      end
      object Save: TButton
        Left = 70
        Top = 70
        Width = 55
        Height = 24
        Caption = 'Save'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnWchangeClick
      end
      object Play: TButton
        Left = 131
        Top = 70
        Width = 55
        Height = 24
        Caption = 'Play'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = btnWchangeClick
      end
      object btnWClear: TButton
        Left = 191
        Top = 70
        Width = 55
        Height = 24
        Caption = 'Clear'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = btnWchangeClick
      end
    end
  end
  object editmenu: TPopupMenu
    OnPopup = editmenuPopup
    Left = 287
    Top = 117
    object Cut1: TMenuItem
      Caption = 'Cu&t'
      ShortCut = 16472
      OnClick = OnEditClick
    end
    object Copy1: TMenuItem
      Tag = 1
      Caption = '&Copy'
      ShortCut = 16451
      OnClick = OnEditClick
    end
    object Paste1: TMenuItem
      Tag = 2
      Caption = '&Paste'
      ShortCut = 16470
      OnClick = OnEditClick
    end
    object Delete1: TMenuItem
      Tag = 3
      Caption = '&Delete'
      ShortCut = 16430
      OnClick = OnEditClick
    end
    object N1: TMenuItem
      Caption = '-'
      OnClick = OnEditClick
    end
    object Selectall1: TMenuItem
      Tag = 4
      Caption = 'Select &all'
      ShortCut = 16449
      OnClick = OnEditClick
    end
  end
  object mfile: TPopupMenu
    Left = 318
    Top = 119
    object mnuOpen: TMenuItem
      Caption = '&Open'
      OnClick = btnWchangeClick
    end
    object mnuSave: TMenuItem
      Tag = 1
      Caption = '&Save'
      OnClick = btnWchangeClick
    end
  end
end
