object RelationsEditor: TRelationsEditor
  Left = 285
  Top = 213
  Width = 558
  Height = 369
  Caption = 'Relations'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 0
    Top = 292
    Width = 550
    Height = 2
    Align = alBottom
    Shape = bsTopLine
  end
  object panel1: TPanel
    Left = 0
    Top = 294
    Width = 550
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Button2: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = Button2Click
    end
  end
  object ElPanel1: TElPanel
    Left = 0
    Top = 0
    Width = 550
    Height = 292
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    DockOrientation = doNoOrient
    object ElLabel29: TElLabel
      Left = 320
      Top = 258
      Width = 70
      Height = 13
      Caption = 'Active on level'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ElLabel28: TElLabel
      Left = 176
      Top = 226
      Width = 86
      Height = 13
      Caption = 'Detail DisplayField'
      LightColor = clActiveBorder
      OutlineColor = clWindow
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ElLabel27: TElLabel
      Left = 176
      Top = 196
      Width = 49
      Height = 13
      Caption = 'DetailField'
      LightColor = clActiveBorder
      OutlineColor = clWindow
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ElLabel26: TElLabel
      Left = 176
      Top = 166
      Width = 69
      Height = 13
      Caption = 'Detail DataSet'
      LightColor = clActiveBorder
      OutlineColor = clWindow
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ElLabel25: TElLabel
      Left = 176
      Top = 46
      Width = 65
      Height = 13
      Caption = 'LevelCaption '
      LightColor = clActiveBorder
      OutlineColor = clWindow
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ElLabel24: TElLabel
      Left = 176
      Top = 136
      Width = 54
      Height = 13
      Caption = 'MasterField'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ElLabel20: TElLabel
      Left = 176
      Top = 106
      Width = 74
      Height = 13
      Caption = 'Master DataSet'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ActiveCB: TElCheckBox
      Left = 176
      Top = 16
      Width = 124
      Height = 17
      CheckAlignment = taLeftJustify
      State = cbChecked
      Checked = True
      Caption = 'Active                        '
      Enabled = False
      TabOrder = 0
      Color = clBtnFace
      ParentColor = False
      OnClick = ActiveCBClick
    end
    object ShowcaptionCB: TElCheckBox
      Left = 176
      Top = 72
      Width = 123
      Height = 17
      CheckAlignment = taLeftJustify
      Caption = 'Show caption            '
      Enabled = False
      TabOrder = 1
      Color = clBtnFace
      ParentColor = False
      OnClick = ShowcaptionCBClick
    end
    object MasterFieldCB: TElComboBox
      Left = 287
      Top = 128
      Width = 258
      Height = 21
      Cursor = crIBeam
      Style = csDropDownList
      ItemHeight = 13
      UseCustomScrollBars = False
      OnChange = MasterFieldCBChange
      Text = 'Ma'
      LineBorderActiveColor = clBlack
      LineBorderInactiveColor = clBlack
      ButtonEnabled = False
      Enabled = False
      TabOrder = 2
      ParentColor = False
    end
    object MasterDataSetCB: TElComboBox
      Left = 287
      Top = 98
      Width = 258
      Height = 21
      Cursor = crIBeam
      Style = csDropDownList
      ItemHeight = 13
      UseCustomScrollBars = False
      OnChange = MasterDataSetCBChange
      Text = 'Ma'
      LineBorderActiveColor = clBlack
      LineBorderInactiveColor = clBlack
      ButtonEnabled = False
      Enabled = False
      TabOrder = 3
      ParentColor = False
    end
    object ElPopupButton4: TElPopupButton
      Left = 118
      Top = 14
      Width = 35
      Height = 17
      Glyph.Data = {
        1A030000424D1A030000000000001A0200002800000010000000100000000100
        08000000000000010000E50E0000E50E0000790000007900000010630000006B
        0000086B00000073000008730000007B0000107B000000840000088400001084
        0000008C0000088C00000094000008940000009C0000089C000000A5000008A5
        000000AD000000B5000000BD000000C6000008C6000000CE000000D6000008D6
        000008630800087B0800107B080010840800008C0800088C0800009408001094
        0800009C080000A5080000AD080000B5080010BD080010C60800087B1000107B
        1000187B10001084100018841000088C1000188C1000109410001894100010D6
        100018D61000107B1800187B18001884180029841800108C1800188C1800218C
        18001094180018941800189C1800219C180010C6180018C6180018D61800187B
        210018842100189421002194210029A521001873290029AD290031DE290029E7
        290029843100298C3100398C310029D6310031D6310039AD390042A5420039DE
        420042DE42004AAD520052AD520052E752005AE75A0063AD630063E763006BEF
        63006B946B0073B56B006BDE6B0063E76B006BE76B0063EF6B007BB5730073B5
        7B007BDE7B007BB5840084BD84008CC69400A5E7A500CEEFBD00BDEFC600C6EF
        C600C6EFCE00CEEFCE00D6F7CE00D6E7D600DEE7D600D6EFD600DEEFD600CEE7
        DE00D6EFDE00DEEFDE00DEEFE700EFF7EF00F7F7F700FF00FF00FFFFFF007777
        77777777774F4F777777777777777777777777774F41464F7777777777777777
        7777774F345757414F7777777777777777774F34574B4C57334F777777777777
        774F29574105033657294F77777777774F2D57390507051B37572D4F7777774F
        3508440707070707074308384F774F393D0B0A1E1E1E1E0C0A0C0A3B3B4F2F12
        0E0E1F0A0E0C200C0D0C0E210E44777777771310121212102412777777777777
        7777251313131313132577777777777777773F1414141414143F777777777777
        7777521615161616165277777777777777775540171717174056777777777777
        77775C58585D5E5859627777777777777777122221100F0E201277777777}
      TabOrder = 4
      OnClick = ElPopupButton4Click
    end
    object ElPopupButton3: TElPopupButton
      Left = 81
      Top = 14
      Width = 35
      Height = 17
      Glyph.Data = {
        1A030000424D1A030000000000001A0200002800000010000000100000000100
        08000000000000010000E50E0000E50E0000790000007900000010630000006B
        0000086B00000073000008730000007B0000107B000000840000088400001084
        0000008C0000088C00000094000008940000009C0000089C000000A5000008A5
        000000AD000000B5000000BD000000C6000008C6000000CE000000D6000008D6
        000008630800087B0800107B080010840800008C0800088C0800009408001094
        0800009C080000A5080000AD080000B5080010BD080010C60800087B1000107B
        1000187B10001084100018841000088C1000188C1000109410001894100010D6
        100018D61000107B1800187B18001884180029841800108C1800188C1800218C
        18001094180018941800189C1800219C180010C6180018C6180018D61800187B
        210018842100189421002194210029A521001873290029AD290031DE290029E7
        290029843100298C3100398C310029D6310031D6310039AD390042A5420039DE
        420042DE42004AAD520052AD520052E752005AE75A0063AD630063E763006BEF
        63006B946B0073B56B006BDE6B0063E76B006BE76B0063EF6B007BB5730073B5
        7B007BDE7B007BB5840084BD84008CC69400A5E7A500CEEFBD00BDEFC600C6EF
        C600C6EFCE00CEEFCE00D6F7CE00D6E7D600DEE7D600D6EFD600DEEFD600CEE7
        DE00D6EFDE00DEEFDE00DEEFE700EFF7EF00F7F7F700FF00FF00FFFFFF007777
        777712200E0F1021221277777777777777776259585E5D58585C777777777777
        7777564017171717405577777777777777775216161616151652777777777777
        77773F1414141414143F77777777777777772513131313131325777777777777
        7777122410121212101377777777440E210E0C0D0C200C0E0A1F0E0E122F4F3B
        3B0A0C0A0C1E1E1E1E0A0B3D394F774F3808430707070707074408354F777777
        4F2D57371B05070539572D4F77777777774F29573603054157294F7777777777
        77774F33574C4B57344F7777777777777777774F415757344F77777777777777
        777777774F46414F777777777777777777777777774F4F77777777777777}
      TabOrder = 5
      OnClick = ElPopupButton3Click
    end
    object ElPopupButton2: TElPopupButton
      Left = 44
      Top = 14
      Width = 35
      Height = 17
      Caption = 'Del'
      TabOrder = 6
      OnClick = ElPopupButton2Click
    end
    object ElPopupButton1: TElPopupButton
      Left = 8
      Top = 14
      Width = 35
      Height = 17
      Caption = 'New'
      TabOrder = 7
      OnClick = ElPopupButton1Click
    end
    object DetailFieldCB: TElComboBox
      Left = 287
      Top = 188
      Width = 258
      Height = 21
      Cursor = crIBeam
      Style = csDropDownList
      ItemHeight = 13
      UseCustomScrollBars = False
      OnChange = DetailFieldCBChange
      Text = 'Ne'
      LineBorderActiveColor = clBlack
      LineBorderInactiveColor = clBlack
      ButtonEnabled = False
      Enabled = False
      TabOrder = 9
      ParentColor = False
    end
    object DetailDisplayCB: TElComboBox
      Left = 287
      Top = 218
      Width = 258
      Height = 21
      Cursor = crIBeam
      Style = csDropDownList
      ItemHeight = 13
      UseCustomScrollBars = False
      OnChange = DetailDisplayCBChange
      Text = 'Ne'
      LineBorderActiveColor = clBlack
      LineBorderInactiveColor = clBlack
      ButtonEnabled = False
      Enabled = False
      TabOrder = 10
      ParentColor = False
    end
    object DetailDataSetCB: TElComboBox
      Left = 287
      Top = 158
      Width = 258
      Height = 21
      Cursor = crIBeam
      Style = csDropDownList
      ItemHeight = 13
      UseCustomScrollBars = False
      OnChange = DetailDataSetCBChange
      Text = 'Ne'
      LineBorderActiveColor = clBlack
      LineBorderInactiveColor = clBlack
      ButtonEnabled = False
      Enabled = False
      TabOrder = 11
      ParentColor = False
    end
    object DenyDisplCB: TElCheckBox
      Left = 176
      Top = 256
      Width = 124
      Height = 17
      CheckAlignment = taLeftJustify
      Caption = 'DenyLookSetPosition'
      Enabled = False
      TabOrder = 12
      Color = clBtnFace
      ParentColor = False
      OnClick = DenyDisplCBClick
    end
    object CaptionEdit: TElEdit
      Left = 287
      Top = 38
      Width = 258
      Height = 21
      Text = 'Level...'
      LineBorderActiveColor = clBlack
      LineBorderInactiveColor = clBlack
      UseCustomScrollBars = False
      OnChange = CaptionEditChange
      Enabled = False
      TabOrder = 13
    end
    object ActiveLevelEdit: TElSpinEdit
      Left = 400
      Top = 256
      Width = 41
      Height = 21
      Cursor = crIBeam
      Value = -1
      MinValue = -1
      UseCustomScrollBars = False
      OnChange = ActiveLevelEditChange
      Enabled = False
      LineBorderActiveColor = clBlack
      LineBorderInactiveColor = clBlack
      TabOrder = 14
    end
    object ElListBox1: TListBox
      Left = 8
      Top = 32
      Width = 145
      Height = 249
      ItemHeight = 13
      TabOrder = 8
      OnClick = ElListBox1Click
    end
  end
end
