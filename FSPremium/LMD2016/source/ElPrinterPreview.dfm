object ElPrinterPreviewDlg: TElPrinterPreviewDlg
  Left = 54
  Top = 264
  Width = 640
  Height = 450
  ActiveControl = PagesPanel
  Caption = 'Print Preview'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poDefaultPosOnly
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Toolbar: TElToolbar
    Left = 0
    Top = 0
    Width = 632
    Height = 26
    BorderSides = [ebsLeft, ebsRight, ebsTop, ebsBottom]
    Align = alTop
    BevelOuter = bvNone
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    DockOrientation = doNoOrient
    BtnWidth = 21
    BtnHeight = 21
    BtnOffsHorz = 1
    BtnOffsVert = 1
    MinSize = 21
    object PrintBtn: TElToolButton
      Left = 26
      Top = 1
      Width = 24
      Height = 24
      Hint = 'Print ...'
      Wrap = False
      ButtonType = ebtButton
      NumLargeGlyphs = 1
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000008080000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000080800000000000BFBF
        BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
        BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF000000000000000000BFBF
        BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
        BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF0000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000000FFFF
        FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFF
        FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF000000000000000000BFBF
        BF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBF
        BF00FFFFFF00BFBFBF00FFFFFF000000FF00FFFFFF000000000000000000FFFF
        FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFF
        FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF0000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000008080000080
        80000080800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0000000000008080000080800000808000008080000080
        80000080800000000000FFFFFF0000000000000000000000000000000000FFFF
        FF0000000000FFFFFF0000000000008080000080800000808000008080000080
        80000080800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0000000000008080000080800000808000008080000080
        80000080800000000000FFFFFF000000000000000000FFFFFF00000000000000
        0000000000000000000000000000008080000080800000808000008080000080
        80000080800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
        FF00FFFFFF000000000000808000008080000080800000808000008080000080
        80000080800000000000FFFFFF0000000000BFBFBF00FFFFFF0000000000FFFF
        FF00000000000080800000808000008080000080800000808000008080000080
        80000080800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
        0000008080000080800000808000008080000080800000808000008080000080
        8000008080000000000000000000000000000000000000000000000000000080
        8000008080000080800000808000008080000080800000808000}
      NumGlyphs = 1
      Flat = True
      ShowText = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = PrintBtnClick
      ButtonID = 0
    end
    object ElToolButton2: TElToolButton
      Left = 76
      Top = 1
      Width = 5
      Height = 24
      Wrap = False
      ButtonType = ebtDivider
      NumLargeGlyphs = 1
      NumGlyphs = 1
      Flat = True
      ShowText = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ButtonID = 0
    end
    object OnePageBtn: TElToolButton
      Left = 82
      Top = 1
      Width = 24
      Height = 24
      Hint = 'One page'
      Wrap = False
      ButtonType = ebtButton
      NumLargeGlyphs = 1
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000C0C08000C0C0
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000C0C08000C0C080000000
        0000808080008080000080808000808000008080800080800000808080008080
        0000808080008080000080808000808000008080800000000000C0C080000000
        0000808000008080800080800000808080008080000080808000808000008080
        8000808000008080800080800000808080008080000000000000C0C080000000
        0000808080008080000080808000000000000000000000000000000000000000
        0000000000000000000080808000808000008080800000000000C0C080000000
        000080800000808080008080000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF000000000080800000808080008080000000000000C0C080000000
        000080808000808000008080800000000000FFFFFF0080000000800000008000
        0000FFFFFF000000000080808000808000008080800000000000C0C080000000
        000080800000808080008080000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF000000000080800000808080008080000000000000C0C080000000
        000080808000808000008080800000000000FFFFFF008000000080000000FFFF
        FF00FFFFFF000000000080808000808000008080800000000000C0C080000000
        000080800000808080008080000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF000000000080800000808080008080000000000000C0C080000000
        000080808000808000008080800000000000FFFFFF0080000000800000008000
        0000FFFFFF000000000080808000808000008080800000000000C0C080000000
        000080800000808080008080000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF000000000080800000808080008080000000000000C0C080000000
        0000808080008080000080808000000000000000000000000000000000000000
        0000000000000000000080808000808000008080800000000000C0C080000000
        0000808000008080800080800000808080008080000080808000808000008080
        8000808000008080800080800000808080008080000000000000C0C080000000
        0000808080008080000080808000808000008080800080800000808080008080
        0000808080008080000080808000808000008080800000000000C0C08000C0C0
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000C0C08000C0C08000C0C0
        8000C0C08000C0C08000C0C08000C0C08000C0C08000C0C08000C0C08000C0C0
        8000C0C08000C0C08000C0C08000C0C08000C0C08000C0C08000}
      NumGlyphs = 1
      Flat = True
      ShowText = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = OnePageBtnClick
      ButtonID = 0
    end
    object MultipageBtn: TElToolButton
      Left = 107
      Top = 1
      Width = 24
      Height = 24
      Hint = 'Multiple pages'
      Wrap = False
      ButtonType = ebtButton
      NumLargeGlyphs = 1
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000B8C088000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000B8C08800000000008080
        0000808080008080000080808000808000008080800080800000808080008080
        0000808080008080000080808000808000008080800000000000000000008080
        8000808000000000000000000000000000000000000080808000808000000000
        0000000000000000000000000000808080008080000000000000000000008080
        00008080800000000000FFFFFF00FFFFFF000000000080800000808080000000
        0000FFFFFF00FFFFFF0000000000808000008080800000000000000000008080
        80008080000000000000FFFFFF00FFFFFF000000000080808000808000000000
        0000FFFFFF00FFFFFF0000000000808080008080000000000000000000008080
        00008080800000000000FFFFFF00FFFFFF000000000080800000808080000000
        0000FFFFFF00FFFFFF0000000000808000008080800000000000000000008080
        8000808000000000000000000000000000000000000080808000808000000000
        0000000000000000000000000000808080008080000000000000000000008080
        0000808080008080000080808000808000008080800080800000808080008080
        0000808080008080000080808000808000008080800000000000000000008080
        8000808000000000000000000000000000000000000080808000808000000000
        0000000000000000000000000000808080008080000000000000000000008080
        00008080800000000000FFFFFF00FFFFFF000000000080800000808080000000
        0000FFFFFF00FFFFFF0000000000808000008080800000000000000000008080
        80008080000000000000FFFFFF00FFFFFF000000000080808000808000000000
        0000FFFFFF00FFFFFF0000000000808080008080000000000000000000008080
        00008080800000000000FFFFFF00FFFFFF000000000080800000808080000000
        0000FFFFFF00FFFFFF0000000000808000008080800000000000000000008080
        8000808000000000000000000000000000000000000080808000808000000000
        0000000000000000000000000000808080008080000000000000000000008080
        0000808080008080000080808000808000008080800080800000808080008080
        0000808080008080000080808000808000008080800000000000B8C088000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000B8C08800B8C08800B8C0
        8800B8C08800B8C08800B8C08800B8C08800B8C08800B8C08800B8C08800B8C0
        8800B8C08800B8C08800B8C08800B8C08800B8C08800B8C08800}
      NumGlyphs = 1
      Flat = True
      ShowText = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = MultipageBtnClick
      ButtonID = 0
    end
    object ElToolButton1: TElToolButton
      Left = 132
      Top = 1
      Width = 5
      Height = 24
      Wrap = False
      ButtonType = ebtDivider
      NumLargeGlyphs = 1
      NumGlyphs = 1
      Flat = True
      ShowText = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ButtonID = 0
    end
    object SaveBtn: TElToolButton
      Left = 51
      Top = 1
      Width = 24
      Height = 24
      Hint = 'Save current page'
      Wrap = False
      ButtonType = ebtButton
      NumLargeGlyphs = 1
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333370000000000000330CC07CCF880CC0330CC07CCF880CC0330CC08778880
        CC0330CC60000006CC0330CCCCCCCCCCCC0330C6000000006C0330C0FFFFFFFF
        0C0330C0FFFFFFFF0C0330C0FFFFFFFF0C0330C0FFFFFFFF0C033000FFFFFFFF
        000330C0FFFFFFFF0C0337000000000000033333333333333333}
      NumGlyphs = 1
      Flat = True
      ShowText = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = SaveBtnClick
      ButtonID = 0
    end
    object ElToolButton3: TElToolButton
      Left = 224
      Top = 1
      Width = 5
      Height = 24
      Wrap = False
      ButtonType = ebtDivider
      NumLargeGlyphs = 1
      NumGlyphs = 1
      Flat = True
      ShowText = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ButtonID = 0
    end
    object PrintSetupBtn: TElToolButton
      Left = 1
      Top = 1
      Width = 24
      Height = 24
      Wrap = False
      ButtonType = ebtButton
      NumLargeGlyphs = 1
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000008080000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000080800000000000BFBF
        BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
        BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF000000000000000000BFBF
        BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
        BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF0000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000000FFFF
        FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFF
        FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF000000000000000000BFBF
        BF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBF
        BF00FFFFFF00BFBFBF00FFFFFF000000FF00FFFFFF000000000000000000FFFF
        FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFF
        FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF0000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000008080000000000000000000000000000080800000808000008080000080
        8000000000000000000000808000008080000080800000808000008080000080
        8000000000000000000000000000000000000000000000808000008080000080
        8000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000808000008080000080800000808000008080000080
        8000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000808000008080000080800000808000008080000080
        8000000000000000000000808000008080000080800000808000008080000080
        8000000000000000000000000000000000000000000000808000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000008080000000000000000000000000000080800000808000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000008080000080800000808000008080000080800000808000}
      NumGlyphs = 1
      Flat = True
      ShowText = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = PrintSetupBtnClick
      ButtonID = 0
    end
    object PrevPageBtn: TElToolButton
      Left = 230
      Top = 1
      Width = 24
      Height = 24
      Hint = 'Previous page'
      Wrap = False
      ButtonType = ebtButton
      NumLargeGlyphs = 1
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
        FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
        00000000000000000000000000000000000000000000FF00FF00FF00FF000000
        0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
        000000000000000000000000000000000000FF00FF00FF00FF00FF00FF000000
        0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
        00000000000000000000000000000000000000000000FF00FF00FF00FF000000
        0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
        FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
        00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008080
        800000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        000000000000000000000000000000000000000000000000000000000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      NumGlyphs = 1
      Flat = True
      ShowText = False
      Caption = 'PrevPageBtn'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = PrevPageBtnClick
      ButtonID = 0
    end
    object ElToolButton5: TElToolButton
      Left = 330
      Top = 1
      Width = 5
      Height = 24
      Wrap = False
      ButtonType = ebtDivider
      NumLargeGlyphs = 1
      NumGlyphs = 1
      Flat = True
      ShowText = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ButtonID = 0
    end
    object NextPageBtn: TElToolButton
      Left = 305
      Top = 1
      Width = 24
      Height = 24
      Hint = 'Next page'
      Wrap = False
      ButtonType = ebtButton
      NumLargeGlyphs = 1
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF000000
        000000000000000000000000000000000000000000000000000000000000FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
        FF00000000000000000000000000000000000000000000000000000000000000
        0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF000000
        000000000000000000000000000000000000000000000000000000000000FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF0000000000000000000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00000000008080800000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      NumGlyphs = 1
      Flat = True
      ShowText = False
      Caption = 'NextPageBtn'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = NextPageBtnClick
      ButtonID = 0
    end
    object CloseBtn: TElGraphicButton
      Left = 336
      Top = 1
      Width = 52
      Height = 24
      Flat = True
      Layout = blGlyphTop
      LinkStyle = [fsUnderline]
      Caption = 'Close'
      Color = clBtnFace
      ParentColor = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = CloseBtnClick
      DockOrientation = doNoOrient
    end
    object PageSpin: TElSpinEdit
      Left = 255
      Top = 1
      Width = 49
      Height = 24
      Cursor = crIBeam
      TabStop = False
      Value = 1
      MinValue = 1
      UseCustomScrollBars = False
      BorderSides = [ebsLeft, ebsRight, ebsTop, ebsBottom]
      HideSelection = False
      OnChange = PageSpinChange
      AutoSize = False
      Flat = True
      LineBorderActiveColor = clBlack
      LineBorderInactiveColor = clBlack
      TabOrder = 0
    end
    object ScaleCombo: TElComboBox
      Left = 138
      Top = 1
      Width = 85
      Height = 24
      Cursor = crIBeam
      ButtonArrowColor = clBlack
      ItemHeight = 13
      VertScrollBarStyles.ButtonSize = 16
      VertScrollBarStyles.Width = 13
      HorzScrollBarStyles.ButtonSize = 16
      HorzScrollBarStyles.Width = 13
      UseCustomScrollBars = False
      AutoHistory = False
      AutoHistoryDirection = ahdFirst
      AutoHistoryLimit = 25
      AutoSize = False
      BorderSides = [ebsLeft, ebsRight, ebsTop, ebsBottom]
      OnChange = ScaleComboChange
      Flat = True
      LineBorderActiveColor = clBlack
      LineBorderInactiveColor = clBlack
      AltButtonWidth = 13
      TabOrder = 1
      ParentColor = False
      OnExit = ScaleComboExit
      OnKeyDown = ScComboKeyDown
      DockOrientation = doNoOrient
      DoubleBuffered = False
    end
  end
  object ScrollBox: TScrollBox
    Left = 0
    Top = 26
    Width = 632
    Height = 378
    Align = alClient
    Color = clBtnShadow
    ParentColor = False
    TabOrder = 1
    OnResize = ScrollBoxResize
    object PagesPanel: TElPanel
      Left = 120
      Top = 40
      Width = 217
      Height = 65
      BorderSides = [ebsLeft, ebsRight, ebsTop, ebsBottom]
      Align = alNone
      BevelOuter = bvNone
      Color = clBtnShadow
      TabOrder = 0
      DockOrientation = doNoOrient
      object MainPagePanel: TElPanel
        Left = 7
        Top = 8
        Width = 210
        Height = 297
        BorderSides = [ebsLeft, ebsRight, ebsTop, ebsBottom]
        OwnerDraw = True
        OnPaint = MainPagePanelPaint
        Align = alNone
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DockOrientation = doNoOrient
      end
    end
  end
  object StatusBar: TElStatusBar
    Left = 0
    Top = 404
    Width = 632
    Height = 19
    Panels = <>
    Bevel = epbNone
    Align = alBottom
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    DockOrientation = doNoOrient
    DoubleBuffered = False
  end
  object PrintDialog: TPrintDialog
    Options = [poPageNums]
    Left = 450
    Top = 168
  end
  object PrinterSetupDialog: TPrinterSetupDialog
    Left = 450
    Top = 112
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '*.emf'
    Filter = 'Enhanced Windows Metafiles (*.emf)|*.emf|All files (*.*)|*.*'
    Left = 402
    Top = 61
  end
  object ElHook1: TElHook
    Active = False
    DesignActive = False
    OnAfterProcess = ElHook1AfterProcess
    Left = 218
    Top = 37
  end
  object ElHook2: TElHook
    Active = True
    DesignActive = False
    Control = PagesPanel
    OnAfterProcess = ElHook2AfterProcess
    Left = 82
    Top = 64
  end
end
