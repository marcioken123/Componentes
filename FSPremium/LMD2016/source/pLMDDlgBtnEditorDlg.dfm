object LMDDlgButtonEditorDlg: TLMDDlgButtonEditorDlg
  Left = 465
  Top = 360
  BorderStyle = bsDialog
  Caption = 'LMDDlgButtonPanel-Editor'
  ClientHeight = 369
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ok: TButton
    Left = 354
    Top = 7
    Width = 77
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = okClick
  end
  object Button1: TButton
    Left = 354
    Top = 35
    Width = 77
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object nb: TLMDNoteBook
    Left = 4
    Top = 7
    Width = 341
    Height = 356
    TabOrder = 2
    ActivePage = LMDNoteBookPage1
    object LMDNoteBookPage1: TLMDNoteBookPage
      Left = 0
      Top = 0
      Width = 341
      Height = 356
      Bevel.Mode = bmStandard
      Bevel.StandardStyle = lsFrameInset
      object LMDDockLabel1: TLMDDockLabel
        Left = 9
        Top = 299
        Width = 46
        Height = 21
        Alignment = agCenterLeft
        Caption = 'Width:'
      end
      object LMDDockLabel2: TLMDDockLabel
        Left = 182
        Top = 298
        Width = 46
        Height = 21
        Alignment = agCenterLeft
        Caption = 'Height:'
      end
      object LMDSimpleLabel1: TLMDSimpleLabel
        Left = 74
        Top = 317
        Width = 191
        Height = 15
        Visible = False
        Caption = 'Add later here: Button Style settings etc.'
        Options = []
      end
      object chk: TLMDCheckGroup
        Left = 10
        Top = 32
        Width = 319
        Height = 121
        CtlXP = False
        ParentColor = False
        Bevel.Mode = bmStandard
        Bevel.StandardStyle = lsFrameInset
        BtnAlignment.Alignment = agCenterLeft
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clBlack
        CaptionFont.Height = -11
        CaptionFont.Name = 'MS Sans Serif'
        CaptionFont.Style = []
        CaptionOffset = 0
        Columns = 3
        Items.Strings = (
          'mbYes'
          'mbNo'
          'mbOk '
          'mbCancel'
          'mbAbort'
          'mbRetry'
          'mbIgnore,'
          'mbAll'
          'mbNoToAll'
          'mbYesToAll'
          'mbHelp')
        TabOrder = 1
        OnChange = chkChange
        OnClick = chkClick
        OnDblClick = okClick
        Value = -1
      end
      object rb1: TLMDRadioButton
        Left = 12
        Top = 9
        Width = 198
        Height = 22
        CtlXP = False
        Caption = 'Select Single Buttons....'
        Alignment.Alignment = agTopLeft
        Alignment.Spacing = 4
        Checked = False
        TabOrder = 0
      end
      object rb2: TLMDRadioButton
        Left = 12
        Top = 166
        Width = 212
        Height = 20
        CtlXP = False
        Caption = 'Select a predefined group of buttons....'
        Alignment.Alignment = agTopLeft
        Alignment.Spacing = 4
        Checked = False
        TabOrder = 2
      end
      object list2: TLMDRadioGroup
        Left = 11
        Top = 188
        Width = 203
        Height = 98
        CtlXP = False
        ParentColor = False
        Bevel.Mode = bmStandard
        Bevel.StandardStyle = lsFrameInset
        BtnAlignment.Alignment = agCenterLeft
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clBlack
        CaptionFont.Height = -11
        CaptionFont.Name = 'MS Sans Serif'
        CaptionFont.Style = []
        CaptionOffset = 0
        Items.Strings = (
          'Ok, Cancel, Help'
          'Ok, Cancel, Help (with Gap)'
          'Ok, Cancel'
          'Yes, No, Cancel'
          'Abort,Retry,Ignore')
        TabOrder = 3
        OnClick = list2Click
        OnDblClick = okClick
      end
      object ext1: TLMDSpinEdit
        Left = 56
        Top = 299
        Width = 100
        Height = 21
        Bevel.Mode = bmWindows
        Caret.BlinkRate = 530
        CtlXP = False
        TabOrder = 4
        AutoSelect = True
        CustomButtons = <>
        SpinBtnDiag = False
        MaxValue = 500
        Value = 0
      end
      object ext2: TLMDSpinEdit
        Left = 229
        Top = 298
        Width = 100
        Height = 21
        Bevel.Mode = bmWindows
        Caret.BlinkRate = 530
        CtlXP = False
        TabOrder = 5
        AutoSelect = True
        CustomButtons = <>
        SpinBtnDiag = False
        Value = 0
      end
      object chkr: TLMDCheckBox
        Left = 183
        Top = 330
        Width = 151
        Height = 20
        CtlXP = False
        Caption = 'Remove existing buttons'
        Alignment.Alignment = agTopLeft
        Alignment.Spacing = 4
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object chkr2: TLMDCheckBox
        Left = 11
        Top = 330
        Width = 140
        Height = 21
        CtlXP = False
        Caption = 'RightBottom Alignment'
        Alignment.Alignment = agTopLeft
        Alignment.Spacing = 4
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object rbal: TLMDRadioGroup
        Left = 238
        Top = 164
        Width = 91
        Height = 122
        CtlXP = False
        ParentColor = False
        Bevel.Mode = bmStandard
        Bevel.StandardStyle = lsFrameInset
        BtnAlignment.Alignment = agCenterLeft
        Caption = 'Align'
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clBlack
        CaptionFont.Height = -11
        CaptionFont.Name = 'MS Sans Serif'
        CaptionFont.Style = []
        Items.Strings = (
          'alNone'
          'alTop'
          'alBottom'
          'alLeft'
          'alRight'
          'Do not set')
        TabOrder = 8
      end
    end
    object LMDNoteBookPage2: TLMDNoteBookPage
      Left = 0
      Top = 0
      Width = 341
      Height = 356
      Bevel.Mode = bmStandard
      Bevel.StandardStyle = lsFrameInset
      object up: TLMDSpeedButton
        Left = 294
        Top = 47
        Width = 29
        Height = 26
        OnClick = btnClick
        ButtonLayout.AlignText2Glyph = taBottom
        ButtonLayout.Spacing = 0
        ImageList = LMDImageList1
        NumGlyphs = 2
        ButtonStyle = ubsFlat
      end
      object Down: TLMDSpeedButton
        Left = 294
        Top = 73
        Width = 29
        Height = 26
        Hint = 'Move item down'
        OnClick = btnClick
        ButtonLayout.AlignText2Glyph = taBottom
        ButtonLayout.Spacing = 0
        ImageList = LMDImageList1
        ImageIndex = 1
        NumGlyphs = 2
        ButtonStyle = ubsFlat
      end
      object lbl: TLabel
        Left = 14
        Top = 13
        Width = 63
        Height = 13
        Caption = 'Button Order:'
      end
      object lb: TLMDListBox
        Left = 15
        Top = 30
        Width = 272
        Height = 308
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        TabOrder = 0
        OnClick = lbClick
        OnDblClick = okClick
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clBlack
        HeaderFont.Height = -11
        HeaderFont.Name = 'MS Sans Serif'
        HeaderFont.Style = []
        HeaderSections = <
          item
            ImageIndex = -1
            Text = 'Name'
            Width = 100
          end
          item
            ImageIndex = -1
            Text = 'Caption'
            Width = 200
          end>
        ItemHeight = 16
        CtlXP = False
      end
    end
  end
  object LMDImageList1: TLMDImageList
    Left = 326
    Top = 37
    object TLMDImageListItem
      Width = 32
      Internal = {
        2110000000200000000400000000020000001501000011010000400554424D76
        020000127600602800404000401000400100788F040060003002040000020080
        000000300080800073006000B000F004478000C0C0C00390FF0000003000FFFF
        0073006000B0928800F0FF000000248878880013F800737777780092FFFFF891
        C90082807700728888FF008209900203888802034407010447CC8F0102844440
        010200500105041A020D4444041B020C8444346644400D6A020C880104777888
        00130100777800B00040FF73DDF80080010000B08888005000F3071001708F00
        400032020C8801F07D2C4801900B450605040501004401F08887050088001104
        0D88445E4A480171880415020001020305888400F288870116880012773C0077
        780082005600FC00001688}
    end
  end
end
