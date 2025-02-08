object LMDGlyphTextLayoutEditorDlg: TLMDGlyphTextLayoutEditorDlg
  Left = 301
  Top = 152
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'GlyphTextLayout-Editor'
  ClientHeight = 298
  ClientWidth = 422
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 5
    Top = 139
    Width = 414
    Height = 8
    Shape = bsBottomLine
  end
  object test: TLMDSpeedButton
    Left = 20
    Top = 17
    Width = 246
    Height = 114
    Caption = 'Test-Caption'
    ButtonLayout.Spacing = 1
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000010000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555777555
      5555555555000757755555575500005007555570058880000075570870088078
      007555787887087777755550880FF0800007708080888F7088077088F0708F78
      88077000F0778080005555508F0008800755557878FF88777075570870080088
      0755557075888070755555575500075555555555557775555555}
    FontFX.Style = tdSunken
  end
  object LMDSimpleLabel4: TLMDSimpleLabel
    Left = 275
    Top = 21
    Width = 127
    Height = 32
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -8
    Font.Name = 'Small Fonts'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    Caption = 
      'Test button doesn'#39't reflect current control settings. It demonst' +
      'rates GlyphTextLayout effects only. '
    Options = []
  end
  object ok: TButton
    Left = 337
    Top = 178
    Width = 77
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object cancel: TButton
    Left = 337
    Top = 205
    Width = 77
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object reset: TButton
    Left = 337
    Top = 242
    Width = 77
    Height = 24
    Caption = 'Reset'
    TabOrder = 2
    OnClick = resetClick
  end
  object nb: TPageControl
    Left = 7
    Top = 152
    Width = 324
    Height = 143
    ActivePage = TabSheet1
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = 'Alignment'
      object Label7: TLabel
        Left = 7
        Top = 16
        Width = 49
        Height = 13
        Caption = 'Alignment:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label8: TLabel
        Left = 7
        Top = 43
        Width = 80
        Height = 13
        Caption = 'AlignText2Glyph:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label3: TLabel
        Left = 7
        Top = 76
        Width = 42
        Height = 13
        Caption = '&Spacing:'
        FocusControl = spc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object LMDSimpleLabel1: TLMDSimpleLabel
        Left = 237
        Top = 10
        Width = 72
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -8
        Font.Name = 'Small Fonts'
        Font.Style = []
        MultiLine = True
        ParentFont = False
        Caption = 'Alignment for both Glyph and Caption'
        Options = []
      end
      object LMDSimpleLabel2: TLMDSimpleLabel
        Left = 237
        Top = 39
        Width = 81
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -8
        Font.Name = 'Small Fonts'
        Font.Style = []
        MultiLine = True
        ParentFont = False
        Caption = 'Alignment of Caption relative to Glyph'
        Options = []
      end
      object LMDSimpleLabel3: TLMDSimpleLabel
        Left = 150
        Top = 70
        Width = 69
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -8
        Font.Name = 'Small Fonts'
        Font.Style = []
        MultiLine = True
        ParentFont = False
        Caption = 'Space between Glyph and Caption'
        Options = []
      end
      object spc: TLMDShSpinEdit
        Left = 92
        Top = 70
        Width = 48
        Height = 21
        MaxValue = 255
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        MaxLength = 3
        ParentFont = False
        TabOrder = 2
        Value = 1
        OnChange = edchange
      end
      object cmb2: TComboBox
        Left = 91
        Top = 38
        Width = 143
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = cmbChange
        Items.Strings = (
          'taLeft'
          'taLeftTop'
          'taRight'
          'taRightTop'
          'taTop'
          'taTopLeft'
          'taBottom'
          'taBottomLeft')
      end
      object cmb: TComboBox
        Left = 91
        Top = 11
        Width = 143
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = cmbChange
        Items.Strings = (
          'agTopLeft'
          'agTopCenter'
          'agTopRight'
          'agCenterLeft'
          'agCenter'
          'agCenterRight'
          'agBottomLeft'
          'agBottomCenter'
          'agBottomRight')
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Offset'
      object Label5: TLabel
        Left = 14
        Top = 13
        Width = 82
        Height = 13
        Caption = 'Absolute Offset &X'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label6: TLabel
        Left = 14
        Top = 40
        Width = 82
        Height = 13
        Caption = 'Absolute Offset &Y'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object LMDSimpleLabel5: TLMDSimpleLabel
        Left = 179
        Top = 10
        Width = 109
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -8
        Font.Name = 'Small Fonts'
        Font.Style = []
        MultiLine = True
        ParentFont = False
        Caption = 'Absolute horizontal offset of caption in pixels'
        Options = []
      end
      object LMDSimpleLabel6: TLMDSimpleLabel
        Left = 179
        Top = 35
        Width = 99
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -8
        Font.Name = 'Small Fonts'
        Font.Style = []
        MultiLine = True
        ParentFont = False
        Caption = 'Absolute vertical offset of caption in pixels'
        Options = []
      end
      object capX: TLMDShSpinEdit
        Left = 113
        Top = 9
        Width = 48
        Height = 21
        MaxValue = 32767
        MinValue = -32768
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        MaxLength = 2
        ParentFont = False
        TabOrder = 0
        OnChange = edchange
      end
      object capY: TLMDShSpinEdit
        Left = 113
        Top = 36
        Width = 48
        Height = 21
        MaxValue = 32767
        MinValue = -32768
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        MaxLength = 2
        ParentFont = False
        TabOrder = 1
        OnChange = edchange
      end
    end
  end
end
