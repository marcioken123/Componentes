object frmTLMDHTMLEditor: TfrmTLMDHTMLEditor
  Left = 481
  Top = 433
  Width = 696
  Height = 505
  Caption = 'Simple HTML Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 37
    Align = alTop
    TabOrder = 0
    object btnOpen: TLMDSpeedButton
      Left = 7
      Top = 6
      Width = 27
      Height = 25
      OnClick = btnOpenClick
      ImageList = LMDImageList1
      NumGlyphs = 2
    end
    object btnSave: TLMDSpeedButton
      Left = 35
      Top = 6
      Width = 27
      Height = 25
      OnClick = btnSaveClick
      ImageList = LMDImageList1
      ImageIndex = 1
      NumGlyphs = 2
    end
    object btnCut: TLMDSpeedButton
      Left = 70
      Top = 6
      Width = 27
      Height = 25
      OnClick = btnCutClick
      ImageList = LMDImageList1
      ImageIndex = 4
      NumGlyphs = 2
    end
    object btnCopy: TLMDSpeedButton
      Left = 98
      Top = 6
      Width = 27
      Height = 25
      OnClick = btnCopyClick
      ImageList = LMDImageList1
      ImageIndex = 3
      NumGlyphs = 2
    end
    object btnPaste: TLMDSpeedButton
      Left = 126
      Top = 6
      Width = 27
      Height = 25
      OnClick = btnPasteClick
      ImageList = LMDImageList1
      ImageIndex = 6
      NumGlyphs = 2
    end
    object btnEditor: TLMDSpeedButton
      Left = 236
      Top = 6
      Width = 55
      Height = 25
      Caption = 'Editor'
      OnClick = btnEditorClick
      ImageIndex = 1
      NumGlyphs = 2
    end
    object LMDSpeedButton1: TLMDSpeedButton
      Left = 161
      Top = 6
      Width = 57
      Height = 25
      Caption = 'Font Color'
      OnClick = LMDSpeedButton1Click
      ImageIndex = 1
      NumGlyphs = 2
    end
    object LMDButton1: TLMDButton
      Left = 520
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 0
      CtlXP = False
    end
    object LMDButton2: TLMDButton
      Left = 600
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      CtlXP = False
    end
  end
  object tabs: TPageControl
    Left = 0
    Top = 37
    Width = 688
    Height = 434
    ActivePage = editor
    Align = alClient
    TabOrder = 1
    object editor: TTabSheet
      Caption = 'Edit'
      object HTMLEDIT: TLMDMemo
        Left = 145
        Top = 0
        Width = 535
        Height = 406
        Bevel.Mode = bmStandard
        Bevel.StandardStyle = lsLowered
        Caret.BlinkRate = 530
        TabOrder = 0
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = skVertical
        HorizScrollBar.Back.Style = sfBrush
        HorizScrollBar.Back.Brush.Color = clBlue
        HorizScrollBar.Bevel.Mode = bmStandard
        VertScrollBar.Back.Style = sfBrush
        VertScrollBar.Back.Brush.Color = clBlue
        VertScrollBar.Bevel.Mode = bmStandard
      end
      object taglb: TLMDTextListBox
        Left = 0
        Top = 0
        Width = 145
        Height = 406
        Align = alLeft
        ItemHeight = 16
        TabOrder = 1
        OnDblClick = taglbDblClick
        Items.Strings = (
          '<b>Standard Tags</b>'
          '  Font'
          '  Image'
          '  Table'
          '  Paragraph'
          '  LineBreak'
          '  Center'
          '  BlockQuote'
          '<b>Format Tags</B>'
          '  Bold'
          '  Italic'
          '  Strike'
          '  Underline'
          '  Subscript'
          '  Superscript'
          '<b>List Tags</B>'
          '  Ordered'
          '  UnOrdered'
          '<b>Link Tags</B>'
          '  Link'
          '  Mail'
          '<b>LMD Tags</b>'
          '  Repeat'
          '  Variable'
          '  Control')
        TextSettings.ParserClass = 'TLMDHTMLParser'
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Preview'
      ImageIndex = 1
      OnShow = TabSheet2Show
      object preview: TLMDTextScrollPanel
        Left = 0
        Top = 0
        Width = 680
        Height = 406
        Bevel.Mode = bmWindows
        Bevel.StandardStyle = lsWindowBorder
        Align = alClient
        TextSettings.ParserClass = 'TLMDHTMLParser'
        UseDockManager = False
        VertScrollBar.Back.Style = sfBrush
        VertScrollBar.Back.Brush.Color = clBlue
        VertScrollBar.Bevel.Mode = bmStandard
        HorizScrollBar.Back.Style = sfBrush
        HorizScrollBar.Back.Brush.Color = clBlue
        HorizScrollBar.Bevel.Mode = bmStandard
        WordWrap = True
        TextIndex = 0
        CheckContainerLinks = False
      end
    end
    object options: TTabSheet
      Caption = 'Options'
      ImageIndex = 2
      object LMDDockLabel1: TLMDDockLabel
        Left = 13
        Top = 19
        Width = 118
        Height = 19
        Alignment = agCenterLeft
        Caption = 'Preferred HTML-Editor:'
      end
      object fedit: TLMDFileOpenEdit
        Left = 132
        Top = 19
        Width = 402
        Height = 21
        Bevel.Mode = bmWindows
        Caret.BlinkRate = 530
        CtlXP = False
        TabOrder = 0
        CustomButtonWidth = 18
        FilenameOnly = False
      end
    end
  end
  object openDialog: TOpenDialog
    DefaultExt = '*.htm'
    Filter = 
      'HTML files|*.htm; *.html|Text files|*.txt|All knwown|*.htm; *.ht' +
      'ml; *.txt|All files|*.*'
    Left = 408
    Top = 8
  end
  object LMDImageList1: TLMDImageList
    Left = 469
    Top = 10
    object TLMDImageListItem
      Width = 32
      Internal = {
        211000000020000000040000000007000000B3040000AF040000400554424D76
        07000012760060280040E000401000400100788F040060003002040000020080
        000000300080800073006000B000F004478000C0C0C00390FF0000003000FFFF
        0073006000B0897300F0FF008800148FFF0010F800D400710112FFFF00B10041
        FF8501E0003002190000008802B6000008880400076108F00888887700117F05
        A0D3B100F00030080113777F00C00030020477070A0402888844035086880031
        77F88FF800000188012144001188FFFF0621770033B042001030050001A187F8
        88803305F1030887F801F0F810527F7F0F0561F088887F8F0320F70251888404
        0288200088F702207788848848844888888887F87F5054870B018000C0888808
        888702C27F17704F0430F48711097777780080870B0307003308887F02C1887F
        070F05AA00F00000F007007703200443840380F40560F70040879CD007014884
        00A109D00201000800D000307705128807373741114F0C20F4788888780A0087
        0FB0070130887F02C1FDCA09500E0F05E007010E080820F40EE10E100708FF7F
        044200213180C180131017D187880373730E0207E078FFF888870BFB895D0E13
        7F887F0590FF7F07020015047715000E0C1200040290C1411201051388444848
        840D008802D0F7F88888800701A8620E408701F1780E030F44447F0E010E200F
        BFB00EF0000883007F88870EF07777800EF133330887F82A121C078000053187
        F88880FFFFF4F00000F4878888871084F7777700708848444801D1887F777800
        8100080D31888008880E100530780E044F4807010730780BFB0010EB4101F001
        0000F0881C0300070107F1FF07020FF088887F2EF08C51130180F0000E0306D0
        F888FF1C414006F38877780660948A042000880E31880E1077880E02FFFF4421
        A08801F07718A7880FBF00100702FFFFFF0120802AC08888150004A124600200
        0F00FFF080F0070077F88787F7F8FF80FFE6D80E0012000EB087F71200063080
        004000318714E00081000008FB010071352005001C002CF04007010C11880BFB
        0000000805004400FF00F078FFFF070E080F08080008447F787F04887878777F
        770E034F4814D1F8887805208800089F1805F2887712420E1201120E100E0237
        3737290019F1F887882120800001C1000887770081777F070EF0808080880161
        80447FF78787871240800E00120187F888F73C30B04A03510807043533888800
        0008017188770811031ED0003238077030000D007F8701928888800222043007
        0E00000881000501447777787878205080F00F044444488845078714D1777888
        03C10000608888877F7715120C200112CAC20C200110077001D0070E008701D0
        07040888080801608811967FFF7807040008871C020A21808001C044050009D1
        7708C680FFFF0F02D187F888080101B080888000600200F8404C870530888000
        0888800800F0777808302A000B0020DAB0730E00FF7F7787FF05520230880012
        092088150308FA69070024003C30019003D08007008878045107000001408887
        14D452C88806E0800111888707030001F100407777016077F880003E0000BB00
        0008888777775220043001600039020000AECF00100802007700100211013008
        07010130787700D1030100D100813F4288880E0C05C001805F0003B129718001
        238887777800006388}
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '*.htm'
    Filter = 
      'HTML files|*.htm; *.html|Text files|*.txt|All knwown|*.htm; *.ht' +
      'ml; *.txt|All files|*.*'
    Left = 439
    Top = 9
  end
  object ini: TLMDIniCtrl
    Left = 392
    Top = 25
  end
  object colordlg: TColorDialog
    Ctl3D = True
    Options = [cdPreventFullOpen]
    Left = 357
    Top = 28
  end
end
