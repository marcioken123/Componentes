object frmCustomiseDialog: TfrmCustomiseDialog
  Left = 63
  Top = 3
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Customise your dialog'
  ClientHeight = 421
  ClientWidth = 781
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  DesignSize = (
    781
    421)
  PixelsPerInch = 96
  TextHeight = 13
  object bOK: TButton
    Left = 698
    Top = 29
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
    OnClick = bOKClick
  end
  object bPreview: TButton
    Left = 698
    Top = 388
    Width = 75
    Height = 25
    Hint = 'Click to display a preview of how the dialog will look'
    Anchors = [akRight, akBottom]
    Caption = '&Preview'
    TabOrder = 3
    OnClick = bPreviewClick
  end
  object bCancel: TButton
    Left = 698
    Top = 60
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 681
    Height = 405
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'General'
      DesignSize = (
        673
        377)
      object Label1: TLabel
        Left = 3
        Top = 36
        Width = 56
        Height = 13
        Caption = '&Instruction:'
        FocusControl = eInstruction
      end
      object Label2: TLabel
        Left = 3
        Top = 113
        Width = 43
        Height = 13
        Caption = '&Content:'
        FocusControl = mContent
      end
      object Label5: TLabel
        Left = 3
        Top = 9
        Width = 24
        Height = 13
        Caption = '&Title:'
        FocusControl = eTitle
      end
      object Label27: TLabel
        Left = 79
        Top = 63
        Width = 29
        Height = 13
        Caption = 'Co&lor:'
        FocusControl = eMainInstructionColor
      end
      object Label28: TLabel
        Left = 284
        Top = 63
        Width = 25
        Height = 13
        Caption = 'Ico&n:'
      end
      object eInstruction: TEdit
        Left = 79
        Top = 33
        Width = 348
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
      end
      object mContent: TMemo
        Left = 79
        Top = 110
        Width = 348
        Height = 122
        Anchors = [akLeft, akTop, akRight]
        ScrollBars = ssBoth
        TabOrder = 8
        WordWrap = False
      end
      object gbOptions: TGroupBox
        Left = 3
        Top = 263
        Width = 425
        Height = 104
        Caption = ' &Options '
        TabOrder = 11
        object cbdoShowHelpLink: TCheckBox
          Left = 14
          Top = 22
          Width = 97
          Height = 17
          Caption = 'doShowHelpLink'
          TabOrder = 0
        end
        object cbdoRadioButtons: TCheckBox
          Left = 15
          Top = 48
          Width = 97
          Height = 17
          Caption = 'doRadioButtons'
          TabOrder = 1
        end
        object cbdoCommandLinks: TCheckBox
          Left = 14
          Top = 74
          Width = 102
          Height = 17
          Caption = 'doCommandLinks'
          TabOrder = 2
        end
        object cbdoCommandLinksNoIcon: TCheckBox
          Left = 136
          Top = 22
          Width = 140
          Height = 17
          Caption = 'doCommandLinksNoIcon'
          TabOrder = 3
        end
        object cbdoProgressBar: TCheckBox
          Left = 136
          Top = 48
          Width = 140
          Height = 17
          Caption = 'doProgressBar'
          TabOrder = 4
        end
        object cbdoProgressBarMarque: TCheckBox
          Left = 136
          Top = 74
          Width = 140
          Height = 17
          Caption = 'doProgressBarMarquee'
          TabOrder = 5
        end
        object cbdoTimer: TCheckBox
          Left = 304
          Top = 22
          Width = 97
          Height = 17
          Caption = 'doTimer'
          TabOrder = 6
        end
        object cbdoTopMost: TCheckBox
          Left = 304
          Top = 48
          Width = 97
          Height = 17
          Caption = 'doTopMost'
          TabOrder = 7
        end
        object cbdoModal: TCheckBox
          Left = 304
          Top = 74
          Width = 97
          Height = 17
          Caption = 'doModal'
          TabOrder = 8
        end
      end
      object gbFonts: TGroupBox
        Left = 434
        Top = 262
        Width = 236
        Height = 105
        Anchors = [akLeft, akTop, akRight]
        Caption = ' Fonts '
        TabOrder = 14
        object Panel1: TPanel
          Left = 2
          Top = 15
          Width = 232
          Height = 88
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object lInstructionFont: TLabel
            Left = 0
            Top = 0
            Width = 52
            Height = 13
            Cursor = 3123
            Align = alTop
            Caption = 'Instruction'
            Color = clBtnFace
            ParentColor = False
            OnClick = lInstructionFontClick
          end
          object lContentFont: TLabel
            Left = 0
            Top = 13
            Width = 39
            Height = 13
            Cursor = 3123
            Align = alTop
            Caption = 'Content'
            Color = clBtnFace
            ParentColor = False
            OnClick = lInstructionFontClick
          end
          object lMoreContentFont: TLabel
            Left = 0
            Top = 26
            Width = 66
            Height = 13
            Cursor = 3123
            Align = alTop
            Caption = 'More Content'
            Color = clBtnFace
            ParentColor = False
            OnClick = lInstructionFontClick
          end
        end
      end
      object cbShowVerification: TCheckBox
        Left = 3
        Top = 240
        Width = 108
        Height = 17
        Caption = 'S&how verification:'
        TabOrder = 9
      end
      object eVerification: TEdit
        Left = 112
        Top = 238
        Width = 316
        Height = 21
        TabOrder = 10
      end
      object eTitle: TEdit
        Left = 79
        Top = 6
        Width = 348
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object gbMainIcon: TGroupBox
        Left = 434
        Top = 0
        Width = 237
        Height = 233
        Caption = ' &Main Icon '
        TabOrder = 12
        DesignSize = (
          237
          233)
        object iMainIcon: TImage
          Left = 64
          Top = 18
          Width = 105
          Height = 62
          Center = True
        end
        object rgMainIcon: TRadioGroup
          Left = 8
          Top = 86
          Width = 221
          Height = 134
          Anchors = [akTop, akRight]
          Columns = 2
          Items.Strings = (
            'tdiNone'
            'tdiWarning'
            'tdiError'
            'tdiInformation'
            'tdiConfirmation'
            'tdiCustom'
            'tdiShield')
          TabOrder = 0
          OnClick = rgMainIconClick
        end
      end
      object cbUseDefaultFonts: TCheckBox
        Left = 434
        Top = 239
        Width = 236
        Height = 17
        Caption = '&Use default fonts'
        TabOrder = 13
      end
      object eMainInstructionColor: TEdit
        Left = 118
        Top = 60
        Width = 121
        Height = 21
        TabOrder = 2
      end
      object bbMainInstructionColor: TBitBtn
        Left = 245
        Top = 58
        Width = 27
        Height = 25
        Glyph.Data = {
          AA030000424DAA03000000000000360000002800000011000000110000000100
          1800000000007403000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0070707070707070707070
          7070707070707070707070707070707070707070707070707070707070707070
          707070707070707070007070702F7EB9107ADF1E5DD94958AB7070705E904D44
          AC315EB41E6EA031707070806D7E9A697FA04C93903A977B5980707070007070
          700198FF1693FF1F74FF0B3FFF7070704EC42423FE004ED60060C400707070A1
          6899DF6B9FF120D1C400D1903A97707070007070705EBEFF75CDFF2B9BFF006A
          FF7070709FC4698CFF745EFF1541D400707070AC7DACF5B3D0FF78E0F21ED19D
          4C9370707000707070E6BFA2B2E1FF41B2FF0086F6707070CE97A4DFE2DD62FF
          4D19EA007070709F8BA4D5DFDDF5B5D0DF6D9F98697F70707000707070B0926B
          A5A58550A8AE3D90A27070709B6F80AC7D879496597591387070706F7790778A
          B77F82AF85749879717D70707000707070707070707070707070707070707070
          7070707070707070707070707070707070707070707070707070707070707070
          70007070701C4DFA2540FF190EFF2100EB70707051D6BA3FFFFF07FFFF00E3FD
          707070E69000F1BD00F3A100D57400A06C39707070007070705E83FF7B91FF40
          48FF0700FF7070707FDDB79AFFFF47FFFF1BF6FF707070EA931DFFE04FFFCE25
          F69D00D08C0B70707000707070D3CEB8C7D2FF6F88FF0A33FF707070C7AF8ED2
          FFFF99FFFF48FAFF707070A4828BE6E2DBFFEB71FFC900E4B300707070007070
          70B7AE86ABB0B74B6FE83558C4707070A88475BDA6A678D8D84ACCD67070707D
          7694919CD3EACE56FFCC00AF9833707070007070707070707070707070707070
          7070707070707070707070707070707070707070707070707070707070707070
          707070707000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF00}
        TabOrder = 3
        OnClick = bbMainInstructionColorClick
      end
      object cbMultiline: TCheckBox
        Left = 253
        Top = 87
        Width = 68
        Height = 17
        Caption = 'Multiline:'
        TabOrder = 6
        Visible = False
      end
      object cbShowGlyph: TCheckBox
        Left = 167
        Top = 87
        Width = 80
        Height = 17
        Caption = 'Show Glyph'
        TabOrder = 7
      end
      object cbShowAtTop: TCheckBox
        Left = 79
        Top = 87
        Width = 82
        Height = 17
        Caption = 'Show at top'
        TabOrder = 5
      end
      object cboxMainInstructionIcon: TComboBox
        Left = 315
        Top = 60
        Width = 113
        Height = 21
        Style = csDropDownList
        TabOrder = 4
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'Buttons'
      ImageIndex = 7
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label18: TLabel
        Left = 3
        Top = 261
        Width = 39
        Height = 13
        Caption = '&Default:'
        FocusControl = cboxButtonsDefault
      end
      object Label19: TLabel
        Left = 3
        Top = 288
        Width = 36
        Height = 13
        Caption = 'C&ancel:'
        FocusControl = cboxButtonsCancel
      end
      object Label21: TLabel
        Left = 3
        Top = 63
        Width = 29
        Height = 13
        Caption = '&Color:'
        FocusControl = eButtonBarColor
      end
      object Label45: TLabel
        Left = 8
        Top = 21
        Width = 262
        Height = 30
        AutoSize = False
        Caption = 
          'You should not hide the Button Bar if your dialog has either a V' +
          'erification checkbox or Expando visible.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object gbCommonButtons: TGroupBox
        Left = 3
        Top = 87
        Width = 267
        Height = 165
        Caption = ' Common &Buttons '
        TabOrder = 3
        object cbcbYes: TCheckBox
          Left = 12
          Top = 21
          Width = 97
          Height = 17
          Caption = 'cbYes'
          TabOrder = 0
        end
        object cbcbNo: TCheckBox
          Tag = 1
          Left = 12
          Top = 44
          Width = 97
          Height = 17
          Caption = 'cbNo'
          TabOrder = 1
        end
        object cbcbOK: TCheckBox
          Tag = 2
          Left = 12
          Top = 67
          Width = 97
          Height = 17
          Caption = 'cbOK'
          TabOrder = 2
        end
        object cbcbCancel: TCheckBox
          Tag = 3
          Left = 12
          Top = 90
          Width = 97
          Height = 17
          Caption = 'cbCancel'
          TabOrder = 3
        end
        object cbcbAbort: TCheckBox
          Tag = 4
          Left = 12
          Top = 113
          Width = 97
          Height = 17
          Caption = 'cbAbort'
          TabOrder = 4
        end
        object cbcbRetry: TCheckBox
          Tag = 5
          Left = 12
          Top = 136
          Width = 97
          Height = 17
          Caption = 'cbRetry'
          TabOrder = 5
        end
        object cbcbIgnore: TCheckBox
          Tag = 6
          Left = 152
          Top = 21
          Width = 97
          Height = 17
          Caption = 'cbIgnore'
          TabOrder = 6
        end
        object cbcbAll: TCheckBox
          Tag = 7
          Left = 152
          Top = 44
          Width = 97
          Height = 17
          Caption = 'cbAll'
          TabOrder = 7
        end
        object cbcbNoToAll: TCheckBox
          Tag = 8
          Left = 152
          Top = 67
          Width = 97
          Height = 17
          Caption = 'cbNoToAll'
          TabOrder = 8
        end
        object cbcbYesToAll: TCheckBox
          Tag = 9
          Left = 152
          Top = 90
          Width = 97
          Height = 17
          Caption = 'cbYesToAll'
          TabOrder = 9
        end
        object cbcbHelp: TCheckBox
          Tag = 10
          Left = 152
          Top = 113
          Width = 97
          Height = 17
          Caption = 'cbHelp'
          TabOrder = 10
        end
        object cbcbClose: TCheckBox
          Tag = 11
          Left = 152
          Top = 136
          Width = 97
          Height = 17
          Caption = 'cbClose'
          TabOrder = 11
        end
      end
      object cboxButtonsDefault: TComboBox
        Left = 50
        Top = 258
        Width = 120
        Height = 21
        Style = csDropDownList
        DropDownCount = 15
        TabOrder = 4
        Items.Strings = (
          'cbYes'
          'cbNo'
          'cbOK'
          'cbCancel '
          'cbAbort'
          'cbRetry'
          'cbIgnore'
          'cbAll'
          'cbNoToAll'
          'cbYesToAll '
          'cbHelp'
          'cbClose')
      end
      object cboxButtonsCancel: TComboBox
        Left = 50
        Top = 285
        Width = 120
        Height = 21
        Style = csDropDownList
        DropDownCount = 15
        TabOrder = 5
        Items.Strings = (
          'cbYes'
          'cbNo'
          'cbOK'
          'cbCancel '
          'cbAbort'
          'cbRetry'
          'cbIgnore'
          'cbAll'
          'cbNoToAll'
          'cbYesToAll '
          'cbHelp'
          'cbClose')
      end
      object cbShowCommonButtons: TCheckBox
        Left = 3
        Top = 3
        Width = 267
        Height = 17
        Caption = '&Show Button Bar'
        TabOrder = 0
      end
      object eButtonBarColor: TEdit
        Left = 42
        Top = 60
        Width = 121
        Height = 21
        TabOrder = 1
        OnExit = eButtonBarColorExit
      end
      object bbColorDialog: TBitBtn
        Left = 169
        Top = 58
        Width = 27
        Height = 25
        Glyph.Data = {
          AA030000424DAA03000000000000360000002800000011000000110000000100
          1800000000007403000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0070707070707070707070
          7070707070707070707070707070707070707070707070707070707070707070
          707070707070707070007070702F7EB9107ADF1E5DD94958AB7070705E904D44
          AC315EB41E6EA031707070806D7E9A697FA04C93903A977B5980707070007070
          700198FF1693FF1F74FF0B3FFF7070704EC42423FE004ED60060C400707070A1
          6899DF6B9FF120D1C400D1903A97707070007070705EBEFF75CDFF2B9BFF006A
          FF7070709FC4698CFF745EFF1541D400707070AC7DACF5B3D0FF78E0F21ED19D
          4C9370707000707070E6BFA2B2E1FF41B2FF0086F6707070CE97A4DFE2DD62FF
          4D19EA007070709F8BA4D5DFDDF5B5D0DF6D9F98697F70707000707070B0926B
          A5A58550A8AE3D90A27070709B6F80AC7D879496597591387070706F7790778A
          B77F82AF85749879717D70707000707070707070707070707070707070707070
          7070707070707070707070707070707070707070707070707070707070707070
          70007070701C4DFA2540FF190EFF2100EB70707051D6BA3FFFFF07FFFF00E3FD
          707070E69000F1BD00F3A100D57400A06C39707070007070705E83FF7B91FF40
          48FF0700FF7070707FDDB79AFFFF47FFFF1BF6FF707070EA931DFFE04FFFCE25
          F69D00D08C0B70707000707070D3CEB8C7D2FF6F88FF0A33FF707070C7AF8ED2
          FFFF99FFFF48FAFF707070A4828BE6E2DBFFEB71FFC900E4B300707070007070
          70B7AE86ABB0B74B6FE83558C4707070A88475BDA6A678D8D84ACCD67070707D
          7694919CD3EACE56FFCC00AF9833707070007070707070707070707070707070
          7070707070707070707070707070707070707070707070707070707070707070
          707070707000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF00}
        TabOrder = 2
        OnClick = bbColorDialogClick
      end
    end
    object tsCustomBUttons: TTabSheet
      Caption = 'Custom Buttons'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        673
        377)
      object Label32: TLabel
        Left = 255
        Top = 330
        Width = 408
        Height = 44
        AutoSize = False
        Caption = 
          'To display your custom buttons as Command Link buttons make sure' +
          ' you set doCommandLinks in the DialogOptions property. Accessibl' +
          'e from the "General" page in this editor.'
        WordWrap = True
      end
      object lbCustomButtons: TListBox
        Left = 3
        Top = 3
        Width = 238
        Height = 371
        ItemHeight = 13
        TabOrder = 0
        OnClick = lbCustomButtonsClick
      end
      object pCustomButtonAddEdit: TPanel
        Left = 247
        Top = 74
        Width = 423
        Height = 258
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        TabOrder = 5
        object Label11: TLabel
          Left = 8
          Top = 11
          Width = 41
          Height = 13
          Caption = 'Caption:'
        end
        object Label12: TLabel
          Left = 8
          Top = 165
          Width = 62
          Height = 13
          Caption = 'ImageIndex:'
        end
        object Label13: TLabel
          Left = 8
          Top = 192
          Width = 62
          Height = 13
          Caption = 'ModalResult:'
        end
        object Label14: TLabel
          Left = 208
          Top = 165
          Width = 65
          Height = 13
          Caption = 'PictureIndex:'
        end
        object Label15: TLabel
          Left = 8
          Top = 86
          Width = 23
          Height = 13
          Caption = 'Hint:'
        end
        object iCustomButtonGlyph: TImage
          Left = 338
          Top = 8
          Width = 79
          Height = 69
          Hint = 'Double click to change image'
          Center = True
          Transparent = True
          OnDblClick = iCustomButtonGlyphDblClick
        end
        object Label29: TLabel
          Left = 8
          Top = 113
          Width = 47
          Height = 13
          Caption = 'Command'
        end
        object Label30: TLabel
          Left = 8
          Top = 127
          Width = 44
          Height = 13
          Caption = 'Link Hint:'
        end
        object Bevel1: TBevel
          Left = 8
          Top = 0
          Width = 409
          Height = 2
        end
        object bCustomButtonSave: TButton
          Left = 264
          Top = 227
          Width = 75
          Height = 25
          Hint = 'Save the custom button'
          Caption = 'Save'
          TabOrder = 11
          Visible = False
          OnClick = bCustomButtonSaveClick
        end
        object eCustomButtonCaption: TEdit
          Left = 72
          Top = 8
          Width = 260
          Height = 21
          TabOrder = 0
        end
        object cbCustomButtonCancel: TCheckBox
          Left = 72
          Top = 35
          Width = 81
          Height = 17
          Caption = 'Cancel'
          TabOrder = 1
        end
        object cbCustomButtonDefault: TCheckBox
          Left = 168
          Top = 35
          Width = 81
          Height = 17
          Caption = 'Default'
          TabOrder = 2
        end
        object eCustomButtonHint: TEdit
          Left = 72
          Top = 83
          Width = 345
          Height = 21
          TabOrder = 5
        end
        object eCustomButtonImageIndex: TEdit
          Left = 72
          Top = 162
          Width = 121
          Height = 21
          TabOrder = 7
        end
        object eCustomButtonPictureIndex: TEdit
          Left = 282
          Top = 162
          Width = 111
          Height = 21
          TabOrder = 8
        end
        object bCustomButtonCancel: TButton
          Left = 345
          Top = 227
          Width = 75
          Height = 25
          Caption = 'Cancel'
          TabOrder = 12
          Visible = False
          OnClick = bCustomButtonCancelClick
        end
        object mCommandLinkHint: TMemo
          Left = 72
          Top = 110
          Width = 345
          Height = 46
          TabOrder = 6
        end
        object cbElevelationRequired: TCheckBox
          Left = 72
          Top = 216
          Width = 121
          Height = 17
          Caption = 'Elevation Required'
          TabOrder = 10
        end
        object eCustomButtonModalResult: TComboBox
          Left = 72
          Top = 189
          Width = 121
          Height = 21
          DropDownCount = 15
          ItemIndex = 0
          TabOrder = 9
          Text = 'mrNone'
          Items.Strings = (
            'mrNone'
            'mrOk'
            'mrCancel'
            'mrAbort'
            'mrRetry'
            'mrIgnore'
            'mrYes'
            'mrNo'
            'mrAll'
            'mrNoToAll'
            'mrYesToAll')
        end
        object cbCustomButtonEnabled: TCheckBox
          Left = 72
          Top = 58
          Width = 81
          Height = 17
          Caption = 'Enabled'
          TabOrder = 3
        end
        object cbCustomButtonVisible: TCheckBox
          Left = 168
          Top = 58
          Width = 81
          Height = 17
          Caption = 'Visible'
          TabOrder = 4
        end
      end
      object bCustomButtonAdd: TButton
        Left = 255
        Top = 43
        Width = 75
        Height = 25
        Hint = 'Add a new Custom Button'
        Caption = 'Add'
        TabOrder = 2
        OnClick = bCustomButtonAddClick
      end
      object bCustomButtonDelete: TButton
        Left = 417
        Top = 43
        Width = 75
        Height = 25
        Action = aDeleteCustomButton
        TabOrder = 4
      end
      object bCustomButtonEdit: TButton
        Left = 336
        Top = 43
        Width = 75
        Height = 25
        Caption = 'Edit'
        TabOrder = 3
        OnClick = bCustomButtonEditClick
      end
      object pImageLists: TPanel
        Left = 255
        Top = -2
        Width = 415
        Height = 39
        BevelOuter = bvNone
        TabOrder = 1
        object Label43: TLabel
          Left = 4
          Top = 13
          Width = 39
          Height = 13
          Caption = 'Images:'
        end
        object Label44: TLabel
          Left = 192
          Top = 13
          Width = 75
          Height = 13
          Caption = 'Picture Images:'
        end
        object Bevel3: TBevel
          Left = 0
          Top = 37
          Width = 409
          Height = 2
        end
        object cboxCustomButtonImages: TComboBox
          Left = 49
          Top = 10
          Width = 136
          Height = 21
          Style = csDropDownList
          TabOrder = 0
        end
        object cboxCustomButtonPictureImages: TComboBox
          Left = 273
          Top = 10
          Width = 136
          Height = 21
          Style = csDropDownList
          TabOrder = 1
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Header'
      ImageIndex = 2
      DesignSize = (
        673
        377)
      object Label9: TLabel
        Left = 3
        Top = 26
        Width = 64
        Height = 13
        Caption = '&Header Text:'
        FocusControl = mHeaderText
      end
      object Label26: TLabel
        Left = 3
        Top = 131
        Width = 88
        Height = 13
        Caption = 'Background &Color:'
        FocusControl = eHeaderColor
      end
      object cbShowHeader: TCheckBox
        Left = 3
        Top = 3
        Width = 97
        Height = 17
        Caption = '&Show Header'
        TabOrder = 0
      end
      object mHeaderText: TMemo
        Left = 73
        Top = 26
        Width = 354
        Height = 39
        Anchors = [akLeft, akTop, akRight]
        ScrollBars = ssVertical
        TabOrder = 1
        WordWrap = False
      end
      object BitBtn1: TBitBtn
        Left = 206
        Top = 126
        Width = 27
        Height = 25
        Glyph.Data = {
          AA030000424DAA03000000000000360000002800000011000000110000000100
          1800000000007403000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0070707070707070707070
          7070707070707070707070707070707070707070707070707070707070707070
          707070707070707070007070702F7EB9107ADF1E5DD94958AB7070705E904D44
          AC315EB41E6EA031707070806D7E9A697FA04C93903A977B5980707070007070
          700198FF1693FF1F74FF0B3FFF7070704EC42423FE004ED60060C400707070A1
          6899DF6B9FF120D1C400D1903A97707070007070705EBEFF75CDFF2B9BFF006A
          FF7070709FC4698CFF745EFF1541D400707070AC7DACF5B3D0FF78E0F21ED19D
          4C9370707000707070E6BFA2B2E1FF41B2FF0086F6707070CE97A4DFE2DD62FF
          4D19EA007070709F8BA4D5DFDDF5B5D0DF6D9F98697F70707000707070B0926B
          A5A58550A8AE3D90A27070709B6F80AC7D879496597591387070706F7790778A
          B77F82AF85749879717D70707000707070707070707070707070707070707070
          7070707070707070707070707070707070707070707070707070707070707070
          70007070701C4DFA2540FF190EFF2100EB70707051D6BA3FFFFF07FFFF00E3FD
          707070E69000F1BD00F3A100D57400A06C39707070007070705E83FF7B91FF40
          48FF0700FF7070707FDDB79AFFFF47FFFF1BF6FF707070EA931DFFE04FFFCE25
          F69D00D08C0B70707000707070D3CEB8C7D2FF6F88FF0A33FF707070C7AF8ED2
          FFFF99FFFF48FAFF707070A4828BE6E2DBFFEB71FFC900E4B300707070007070
          70B7AE86ABB0B74B6FE83558C4707070A88475BDA6A678D8D84ACCD67070707D
          7694919CD3EACE56FFCC00AF9833707070007070707070707070707070707070
          7070707070707070707070707070707070707070707070707070707070707070
          707070707000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF00}
        TabOrder = 4
        OnClick = BitBtn1Click
      end
      object eHeaderColor: TEdit
        Left = 94
        Top = 128
        Width = 106
        Height = 21
        TabOrder = 3
        OnExit = eHeaderColorExit
      end
      object GroupBox1: TGroupBox
        Left = 73
        Top = 71
        Width = 355
        Height = 51
        Caption = ' Header Font '
        TabOrder = 2
        object lHeaderFont: TLabel
          Left = 2
          Top = 15
          Width = 132
          Height = 13
          Cursor = 3123
          Align = alClient
          Alignment = taCenter
          Caption = 'Click to change header font'
          Color = clBtnFace
          ParentColor = False
          Layout = tlCenter
          OnClick = lHeaderFontClick
        end
      end
      object rgIconSize: TRadioGroup
        Left = 433
        Top = 238
        Width = 239
        Height = 85
        Caption = ' Ic&on Size'
        Columns = 2
        Items.Strings = (
          'Small'
          'Medium'
          'Large')
        TabOrder = 7
        OnClick = rgIconSizeClick
      end
      object GroupBox4: TGroupBox
        Left = 434
        Top = 3
        Width = 237
        Height = 233
        Caption = ' &Icon '
        TabOrder = 6
        DesignSize = (
          237
          233)
        object iHeaderIcon: TImage
          Left = 64
          Top = 18
          Width = 105
          Height = 62
          Center = True
        end
        object rgHeaderIcon: TRadioGroup
          Left = 8
          Top = 86
          Width = 221
          Height = 134
          Anchors = [akTop, akRight]
          Columns = 2
          Items.Strings = (
            'tdiNone'
            'tdiWarning'
            'tdiError'
            'tdiInformation'
            'tdiConfirmation'
            'tdiCustom'
            'tdiShield')
          TabOrder = 0
          OnClick = rgHeaderIconClick
        end
      end
      object gbHeaderGradient: TGroupBox
        Left = 74
        Top = 155
        Width = 354
        Height = 168
        Caption = ' &Gradient '
        TabOrder = 5
        object Label40: TLabel
          Left = 21
          Top = 47
          Width = 56
          Height = 13
          Caption = 'Start Color:'
        end
        object Label42: TLabel
          Left = 21
          Top = 78
          Width = 50
          Height = 13
          Caption = 'End Color:'
        end
        object cbHeaderGradientEnabled: TCheckBox
          Left = 21
          Top = 21
          Width = 97
          Height = 17
          Caption = 'Enabled'
          TabOrder = 0
        end
        object eHeaderGradientStartColor: TEdit
          Left = 93
          Top = 44
          Width = 106
          Height = 21
          TabOrder = 1
          OnExit = eHeaderColorExit
        end
        object bbStartColor: TBitBtn
          Left = 205
          Top = 42
          Width = 27
          Height = 25
          Glyph.Data = {
            AA030000424DAA03000000000000360000002800000011000000110000000100
            1800000000007403000000000000000000000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0070707070707070707070
            7070707070707070707070707070707070707070707070707070707070707070
            707070707070707070007070702F7EB9107ADF1E5DD94958AB7070705E904D44
            AC315EB41E6EA031707070806D7E9A697FA04C93903A977B5980707070007070
            700198FF1693FF1F74FF0B3FFF7070704EC42423FE004ED60060C400707070A1
            6899DF6B9FF120D1C400D1903A97707070007070705EBEFF75CDFF2B9BFF006A
            FF7070709FC4698CFF745EFF1541D400707070AC7DACF5B3D0FF78E0F21ED19D
            4C9370707000707070E6BFA2B2E1FF41B2FF0086F6707070CE97A4DFE2DD62FF
            4D19EA007070709F8BA4D5DFDDF5B5D0DF6D9F98697F70707000707070B0926B
            A5A58550A8AE3D90A27070709B6F80AC7D879496597591387070706F7790778A
            B77F82AF85749879717D70707000707070707070707070707070707070707070
            7070707070707070707070707070707070707070707070707070707070707070
            70007070701C4DFA2540FF190EFF2100EB70707051D6BA3FFFFF07FFFF00E3FD
            707070E69000F1BD00F3A100D57400A06C39707070007070705E83FF7B91FF40
            48FF0700FF7070707FDDB79AFFFF47FFFF1BF6FF707070EA931DFFE04FFFCE25
            F69D00D08C0B70707000707070D3CEB8C7D2FF6F88FF0A33FF707070C7AF8ED2
            FFFF99FFFF48FAFF707070A4828BE6E2DBFFEB71FFC900E4B300707070007070
            70B7AE86ABB0B74B6FE83558C4707070A88475BDA6A678D8D84ACCD67070707D
            7694919CD3EACE56FFCC00AF9833707070007070707070707070707070707070
            7070707070707070707070707070707070707070707070707070707070707070
            707070707000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF00}
          TabOrder = 2
          OnClick = bbStartColorClick
        end
        object eHeaderGradientEndColor: TEdit
          Left = 93
          Top = 75
          Width = 106
          Height = 21
          TabOrder = 3
          OnExit = eHeaderColorExit
        end
        object bbEndColor: TBitBtn
          Left = 205
          Top = 73
          Width = 27
          Height = 25
          Glyph.Data = {
            AA030000424DAA03000000000000360000002800000011000000110000000100
            1800000000007403000000000000000000000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0070707070707070707070
            7070707070707070707070707070707070707070707070707070707070707070
            707070707070707070007070702F7EB9107ADF1E5DD94958AB7070705E904D44
            AC315EB41E6EA031707070806D7E9A697FA04C93903A977B5980707070007070
            700198FF1693FF1F74FF0B3FFF7070704EC42423FE004ED60060C400707070A1
            6899DF6B9FF120D1C400D1903A97707070007070705EBEFF75CDFF2B9BFF006A
            FF7070709FC4698CFF745EFF1541D400707070AC7DACF5B3D0FF78E0F21ED19D
            4C9370707000707070E6BFA2B2E1FF41B2FF0086F6707070CE97A4DFE2DD62FF
            4D19EA007070709F8BA4D5DFDDF5B5D0DF6D9F98697F70707000707070B0926B
            A5A58550A8AE3D90A27070709B6F80AC7D879496597591387070706F7790778A
            B77F82AF85749879717D70707000707070707070707070707070707070707070
            7070707070707070707070707070707070707070707070707070707070707070
            70007070701C4DFA2540FF190EFF2100EB70707051D6BA3FFFFF07FFFF00E3FD
            707070E69000F1BD00F3A100D57400A06C39707070007070705E83FF7B91FF40
            48FF0700FF7070707FDDB79AFFFF47FFFF1BF6FF707070EA931DFFE04FFFCE25
            F69D00D08C0B70707000707070D3CEB8C7D2FF6F88FF0A33FF707070C7AF8ED2
            FFFF99FFFF48FAFF707070A4828BE6E2DBFFEB71FFC900E4B300707070007070
            70B7AE86ABB0B74B6FE83558C4707070A88475BDA6A678D8D84ACCD67070707D
            7694919CD3EACE56FFCC00AF9833707070007070707070707070707070707070
            7070707070707070707070707070707070707070707070707070707070707070
            707070707000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF00}
          TabOrder = 4
          OnClick = bbEndColorClick
        end
        object rgHeaderGradientDirection: TRadioGroup
          Left = 21
          Top = 102
          Width = 316
          Height = 52
          Caption = ' Direction '
          Columns = 2
          Items.Strings = (
            'Horizontal'
            'Vertical')
          TabOrder = 5
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Footer'
      ImageIndex = 3
      DesignSize = (
        673
        377)
      object Label10: TLabel
        Left = 3
        Top = 26
        Width = 61
        Height = 13
        Caption = '&Footer Text:'
        FocusControl = mFooterText
      end
      object Label33: TLabel
        Left = 3
        Top = 131
        Width = 88
        Height = 13
        Caption = 'Background &Color:'
        FocusControl = eFooterBackgroundColor
      end
      object cbShowFooter: TCheckBox
        Left = 3
        Top = 3
        Width = 97
        Height = 17
        Caption = '&Show Footer'
        TabOrder = 0
      end
      object rgFooterIcon: TRadioGroup
        Left = 433
        Top = 3
        Width = 237
        Height = 119
        Anchors = [akTop, akRight]
        Caption = ' &Icon '
        Columns = 2
        Items.Strings = (
          'tdiNone'
          'tdiWarning'
          'tdiError'
          'tdiInformation'
          'tdiConfirmation'
          'tdiCustom'
          'tdiShield')
        TabOrder = 5
      end
      object mFooterText: TMemo
        Left = 70
        Top = 26
        Width = 356
        Height = 39
        Anchors = [akLeft, akTop, akRight]
        ScrollBars = ssVertical
        TabOrder = 1
        WordWrap = False
      end
      object GroupBox2: TGroupBox
        Left = 70
        Top = 71
        Width = 356
        Height = 51
        Caption = ' Footer Font '
        TabOrder = 2
        object lFooterFont: TLabel
          Left = 2
          Top = 15
          Width = 128
          Height = 13
          Cursor = 3123
          Align = alClient
          Alignment = taCenter
          Caption = 'Click to change footer font'
          Color = clBtnFace
          ParentColor = False
          Layout = tlCenter
          OnClick = lHeaderFontClick
        end
      end
      object eFooterBackgroundColor: TEdit
        Left = 97
        Top = 128
        Width = 106
        Height = 21
        TabOrder = 3
        OnExit = eFooterBackgroundColorExit
      end
      object BitBtn2: TBitBtn
        Left = 209
        Top = 126
        Width = 27
        Height = 25
        Glyph.Data = {
          AA030000424DAA03000000000000360000002800000011000000110000000100
          1800000000007403000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0070707070707070707070
          7070707070707070707070707070707070707070707070707070707070707070
          707070707070707070007070702F7EB9107ADF1E5DD94958AB7070705E904D44
          AC315EB41E6EA031707070806D7E9A697FA04C93903A977B5980707070007070
          700198FF1693FF1F74FF0B3FFF7070704EC42423FE004ED60060C400707070A1
          6899DF6B9FF120D1C400D1903A97707070007070705EBEFF75CDFF2B9BFF006A
          FF7070709FC4698CFF745EFF1541D400707070AC7DACF5B3D0FF78E0F21ED19D
          4C9370707000707070E6BFA2B2E1FF41B2FF0086F6707070CE97A4DFE2DD62FF
          4D19EA007070709F8BA4D5DFDDF5B5D0DF6D9F98697F70707000707070B0926B
          A5A58550A8AE3D90A27070709B6F80AC7D879496597591387070706F7790778A
          B77F82AF85749879717D70707000707070707070707070707070707070707070
          7070707070707070707070707070707070707070707070707070707070707070
          70007070701C4DFA2540FF190EFF2100EB70707051D6BA3FFFFF07FFFF00E3FD
          707070E69000F1BD00F3A100D57400A06C39707070007070705E83FF7B91FF40
          48FF0700FF7070707FDDB79AFFFF47FFFF1BF6FF707070EA931DFFE04FFFCE25
          F69D00D08C0B70707000707070D3CEB8C7D2FF6F88FF0A33FF707070C7AF8ED2
          FFFF99FFFF48FAFF707070A4828BE6E2DBFFEB71FFC900E4B300707070007070
          70B7AE86ABB0B74B6FE83558C4707070A88475BDA6A678D8D84ACCD67070707D
          7694919CD3EACE56FFCC00AF9833707070007070707070707070707070707070
          7070707070707070707070707070707070707070707070707070707070707070
          707070707000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF00}
        TabOrder = 4
        OnClick = BitBtn2Click
      end
    end
    object tsRadioBUttons: TTabSheet
      Caption = 'Radio Buttons'
      ImageIndex = 4
      DesignSize = (
        673
        377)
      object Label31: TLabel
        Left = 255
        Top = 330
        Width = 408
        Height = 44
        AutoSize = False
        Caption = 
          'For radio buttons to be visible on your dialog, make sure you in' +
          'clude doRadioButtons in the DialogOptions property. You can set ' +
          'this property on the "General" page of this editor.'
        WordWrap = True
      end
      object lbRadioButtons: TListBox
        Left = 3
        Top = 3
        Width = 238
        Height = 371
        ItemHeight = 13
        TabOrder = 0
        OnClick = lbRadioButtonsClick
      end
      object pRadioButtonsAddEdit: TPanel
        Left = 247
        Top = 34
        Width = 423
        Height = 167
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        TabOrder = 4
        object Label17: TLabel
          Left = 8
          Top = 22
          Width = 41
          Height = 13
          Caption = 'Caption:'
        end
        object Label20: TLabel
          Left = 8
          Top = 72
          Width = 30
          Height = 13
          Caption = 'Value:'
          Visible = False
        end
        object Bevel2: TBevel
          Left = 8
          Top = 1
          Width = 409
          Height = 2
        end
        object bRadioButtonsSave: TButton
          Tag = 1
          Left = 260
          Top = 139
          Width = 75
          Height = 25
          Caption = 'Save'
          TabOrder = 4
          Visible = False
          OnClick = bRadioButtonsSaveClick
        end
        object eRadioButtonCaption: TEdit
          Left = 78
          Top = 19
          Width = 260
          Height = 21
          TabOrder = 0
        end
        object cbRadioButtonEnabled: TCheckBox
          Left = 78
          Top = 46
          Width = 81
          Height = 17
          Caption = 'Enabled'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object cbRadioButtonChecked: TCheckBox
          Left = 174
          Top = 46
          Width = 81
          Height = 17
          Caption = 'Checked'
          TabOrder = 2
        end
        object Edit5: TEdit
          Left = 78
          Top = 69
          Width = 121
          Height = 21
          TabOrder = 3
          Visible = False
        end
        object bRadioButtonsCancel: TButton
          Tag = 1
          Left = 341
          Top = 139
          Width = 75
          Height = 25
          Caption = 'Cancel'
          TabOrder = 5
          Visible = False
          OnClick = bRadioButtonsCancelClick
        end
      end
      object bRadioButtonsAdd: TButton
        Left = 255
        Top = 3
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 1
        OnClick = bRadioButtonsAddClick
      end
      object bRadioButtonsDelete: TButton
        Left = 417
        Top = 3
        Width = 75
        Height = 25
        Action = aDeleteRadioButton
        TabOrder = 3
      end
      object bRadioButtonsEdit: TButton
        Left = 336
        Top = 3
        Width = 75
        Height = 25
        Caption = 'Edit'
        TabOrder = 2
        OnClick = bRadioButtonsEditClick
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Other'
      ImageIndex = 5
      object Label16: TLabel
        Left = 3
        Top = 7
        Width = 64
        Height = 13
        Caption = '&Dialog Width:'
        FocusControl = eDialogWidth
      end
      object Label4: TLabel
        Left = 3
        Top = 33
        Width = 61
        Height = 13
        Caption = 'Dialog &Color:'
        FocusControl = eDialogColor
      end
      object lBorderStyle: TLabel
        Left = 3
        Top = 60
        Width = 62
        Height = 13
        Caption = '&Border style:'
        FocusControl = cboxBorderStyle
        Visible = False
      end
      object eDialogWidth: TEdit
        Left = 80
        Top = 3
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object eDialogColor: TEdit
        Left = 80
        Top = 30
        Width = 121
        Height = 21
        TabOrder = 1
        OnExit = eDialogColorExit
      end
      object bbDialogColor: TBitBtn
        Left = 207
        Top = 28
        Width = 27
        Height = 25
        Glyph.Data = {
          AA030000424DAA03000000000000360000002800000011000000110000000100
          1800000000007403000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0070707070707070707070
          7070707070707070707070707070707070707070707070707070707070707070
          707070707070707070007070702F7EB9107ADF1E5DD94958AB7070705E904D44
          AC315EB41E6EA031707070806D7E9A697FA04C93903A977B5980707070007070
          700198FF1693FF1F74FF0B3FFF7070704EC42423FE004ED60060C400707070A1
          6899DF6B9FF120D1C400D1903A97707070007070705EBEFF75CDFF2B9BFF006A
          FF7070709FC4698CFF745EFF1541D400707070AC7DACF5B3D0FF78E0F21ED19D
          4C9370707000707070E6BFA2B2E1FF41B2FF0086F6707070CE97A4DFE2DD62FF
          4D19EA007070709F8BA4D5DFDDF5B5D0DF6D9F98697F70707000707070B0926B
          A5A58550A8AE3D90A27070709B6F80AC7D879496597591387070706F7790778A
          B77F82AF85749879717D70707000707070707070707070707070707070707070
          7070707070707070707070707070707070707070707070707070707070707070
          70007070701C4DFA2540FF190EFF2100EB70707051D6BA3FFFFF07FFFF00E3FD
          707070E69000F1BD00F3A100D57400A06C39707070007070705E83FF7B91FF40
          48FF0700FF7070707FDDB79AFFFF47FFFF1BF6FF707070EA931DFFE04FFFCE25
          F69D00D08C0B70707000707070D3CEB8C7D2FF6F88FF0A33FF707070C7AF8ED2
          FFFF99FFFF48FAFF707070A4828BE6E2DBFFEB71FFC900E4B300707070007070
          70B7AE86ABB0B74B6FE83558C4707070A88475BDA6A678D8D84ACCD67070707D
          7694919CD3EACE56FFCC00AF9833707070007070707070707070707070707070
          7070707070707070707070707070707070707070707070707070707070707070
          707070707000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF00}
        TabOrder = 2
        OnClick = bbDialogColorClick
      end
      object cboxBorderStyle: TComboBox
        Left = 80
        Top = 57
        Width = 154
        Height = 21
        Style = csDropDownList
        TabOrder = 3
        Visible = False
      end
      object GroupBox3: TGroupBox
        Left = 3
        Top = 84
        Width = 231
        Height = 53
        Caption = ' Border &Icons '
        TabOrder = 4
        object cbSystemMenu: TCheckBox
          Left = 8
          Top = 24
          Width = 101
          Height = 17
          Caption = 'AllowCancel'
          TabOrder = 0
        end
        object cbMinimize: TCheckBox
          Left = 115
          Top = 25
          Width = 101
          Height = 17
          Caption = 'AllowMinimize'
          TabOrder = 1
        end
      end
      object rgPosition: TRadioGroup
        Left = 3
        Top = 143
        Width = 231
        Height = 161
        Caption = ' &Position '
        Items.Strings = (
          'dpScreenCenter'
          'dpDesktopCenter'
          'dpMainFormCenter'
          'dpOwnerFormCenter'
          'dpDesigned')
        TabOrder = 5
      end
      object gbBorder: TGroupBox
        Left = 258
        Top = 2
        Width = 215
        Height = 111
        Caption = ' Border '
        TabOrder = 6
        object Label41: TLabel
          Left = 8
          Top = 48
          Width = 25
          Height = 13
          Caption = 'C&olor'
        end
        object lBorderWidth: TLabel
          Left = 8
          Top = 75
          Width = 28
          Height = 13
          Caption = '&Width'
        end
        object eBorderColor: TEdit
          Left = 49
          Top = 45
          Width = 121
          Height = 21
          TabOrder = 1
          OnExit = eDialogColorExit
        end
        object bbBorderColor: TBitBtn
          Left = 176
          Top = 43
          Width = 27
          Height = 25
          Glyph.Data = {
            AA030000424DAA03000000000000360000002800000011000000110000000100
            1800000000007403000000000000000000000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0070707070707070707070
            7070707070707070707070707070707070707070707070707070707070707070
            707070707070707070007070702F7EB9107ADF1E5DD94958AB7070705E904D44
            AC315EB41E6EA031707070806D7E9A697FA04C93903A977B5980707070007070
            700198FF1693FF1F74FF0B3FFF7070704EC42423FE004ED60060C400707070A1
            6899DF6B9FF120D1C400D1903A97707070007070705EBEFF75CDFF2B9BFF006A
            FF7070709FC4698CFF745EFF1541D400707070AC7DACF5B3D0FF78E0F21ED19D
            4C9370707000707070E6BFA2B2E1FF41B2FF0086F6707070CE97A4DFE2DD62FF
            4D19EA007070709F8BA4D5DFDDF5B5D0DF6D9F98697F70707000707070B0926B
            A5A58550A8AE3D90A27070709B6F80AC7D879496597591387070706F7790778A
            B77F82AF85749879717D70707000707070707070707070707070707070707070
            7070707070707070707070707070707070707070707070707070707070707070
            70007070701C4DFA2540FF190EFF2100EB70707051D6BA3FFFFF07FFFF00E3FD
            707070E69000F1BD00F3A100D57400A06C39707070007070705E83FF7B91FF40
            48FF0700FF7070707FDDB79AFFFF47FFFF1BF6FF707070EA931DFFE04FFFCE25
            F69D00D08C0B70707000707070D3CEB8C7D2FF6F88FF0A33FF707070C7AF8ED2
            FFFF99FFFF48FAFF707070A4828BE6E2DBFFEB71FFC900E4B300707070007070
            70B7AE86ABB0B74B6FE83558C4707070A88475BDA6A678D8D84ACCD67070707D
            7694919CD3EACE56FFCC00AF9833707070007070707070707070707070707070
            7070707070707070707070707070707070707070707070707070707070707070
            707070707000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF00}
          TabOrder = 2
          OnContextPopup = bbBorderColorContextPopup
        end
        object cbBorderVisible: TCheckBox
          Left = 8
          Top = 24
          Width = 97
          Height = 17
          Caption = '&Visible'
          TabOrder = 0
        end
        object eBorderWidth: TEdit
          Left = 49
          Top = 72
          Width = 121
          Height = 21
          TabOrder = 3
          Text = '1'
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Show More Content'
      ImageIndex = 6
      DesignSize = (
        673
        377)
      object Label6: TLabel
        Left = 3
        Top = 145
        Width = 55
        Height = 13
        Caption = 'Sh&ow Text:'
        FocusControl = eShowText
      end
      object Label7: TLabel
        Left = 3
        Top = 169
        Width = 50
        Height = 13
        Caption = '&Hide Text:'
        FocusControl = eHideText
      end
      object Label8: TLabel
        Left = 3
        Top = 245
        Width = 70
        Height = 13
        Caption = '&Footer Height:'
      end
      object Label3: TLabel
        Left = 3
        Top = 26
        Width = 70
        Height = 13
        Caption = '&More Content:'
        FocusControl = mMoreContent
      end
      object cbShowMoreShowing: TCheckBox
        Left = 79
        Top = 196
        Width = 121
        Height = 17
        Caption = 'Sho&wing'
        TabOrder = 4
      end
      object eShowText: TEdit
        Left = 79
        Top = 142
        Width = 185
        Height = 21
        TabOrder = 2
      end
      object eHideText: TEdit
        Left = 79
        Top = 169
        Width = 185
        Height = 21
        TabOrder = 3
      end
      object cbShowMoreShowInFooter: TCheckBox
        Left = 79
        Top = 219
        Width = 121
        Height = 17
        Caption = 'Show i&n footer'
        TabOrder = 5
      end
      object rgShowMoreFormat: TRadioGroup
        Left = 79
        Top = 270
        Width = 185
        Height = 90
        Caption = ' Form&at '
        Items.Strings = (
          'mfText'
          'mfRTF')
        TabOrder = 7
      end
      object rgShowMoreSource: TRadioGroup
        Left = 270
        Top = 270
        Width = 185
        Height = 90
        Caption = ' So&urce '
        Items.Strings = (
          'msDefault'
          'msStream'
          'msFile')
        TabOrder = 8
      end
      object eShowMoreFooterHeight: TEdit
        Left = 79
        Top = 242
        Width = 90
        Height = 21
        TabOrder = 6
      end
      object cbShowMore: TCheckBox
        Left = 3
        Top = 3
        Width = 126
        Height = 17
        Caption = '&Show more content'
        TabOrder = 0
      end
      object mMoreContent: TMemo
        Left = 79
        Top = 26
        Width = 376
        Height = 110
        Anchors = [akLeft, akTop, akRight]
        ScrollBars = ssBoth
        TabOrder = 1
        WordWrap = False
      end
    end
    object TabSheet9: TTabSheet
      Caption = 'Help Link'
      ImageIndex = 8
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label22: TLabel
        Left = 3
        Top = 9
        Width = 54
        Height = 13
        Caption = '&Label Text:'
        FocusControl = eHelpLinkLabelText
      end
      object Label23: TLabel
        Left = 3
        Top = 36
        Width = 67
        Height = 13
        Caption = '&Help Context:'
        FocusControl = eHelpLinkContext
      end
      object Label24: TLabel
        Left = 3
        Top = 63
        Width = 70
        Height = 13
        Caption = 'Help &Keyword:'
        FocusControl = eHelpLinkKeyword
      end
      object Label25: TLabel
        Left = 3
        Top = 90
        Width = 52
        Height = 13
        Caption = 'Help &Type:'
        FocusControl = cboxHelpLinkType
      end
      object lHelpLinkInfo: TLabel
        Left = 3
        Top = 152
        Width = 667
        Height = 41
        AutoSize = False
        Caption = 
          'Make sure you have doShowHelpLink in the DialogOptions if you wa' +
          'nt your help link to display in the dialog. Also if you want to ' +
          'write your own action for when the user clicks on the Help Link,' +
          ' then handle the OnHelpLinkClick event. Make sure you set the Ha' +
          'ndled parameter to True so the default behaviour also doesn'#39't ge' +
          't executed.'
        WordWrap = True
      end
      object lHelpLinkInfo1: TLabel
        Left = 3
        Top = 133
        Width = 67
        Height = 13
        Caption = 'lHelpLinkInfo1'
      end
      object eHelpLinkLabelText: TEdit
        Left = 79
        Top = 6
        Width = 297
        Height = 21
        TabOrder = 0
      end
      object eHelpLinkContext: TEdit
        Left = 79
        Top = 33
        Width = 57
        Height = 21
        TabOrder = 1
        OnKeyPress = eHelpLinkContextKeyPress
      end
      object eHelpLinkKeyword: TEdit
        Left = 79
        Top = 60
        Width = 145
        Height = 21
        TabOrder = 2
      end
      object cboxHelpLinkType: TComboBox
        Left = 79
        Top = 87
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 3
        Text = 'htKeyword'
        Items.Strings = (
          'htKeyword'
          'htContext')
      end
    end
    object tsProgress: TTabSheet
      Caption = 'Progress'
      ImageIndex = 9
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label34: TLabel
        Left = 3
        Top = 16
        Width = 42
        Height = 13
        Caption = '&Interval:'
      end
      object Label35: TLabel
        Left = 3
        Top = 43
        Width = 20
        Height = 13
        Caption = '&Min:'
      end
      object Label36: TLabel
        Left = 3
        Top = 72
        Width = 24
        Height = 13
        Caption = 'M&ax:'
      end
      object Label37: TLabel
        Left = 3
        Top = 96
        Width = 41
        Height = 13
        Caption = '&Position:'
      end
      object Label38: TLabel
        Left = 3
        Top = 125
        Width = 30
        Height = 13
        Caption = '&State:'
      end
      object Label39: TLabel
        Left = 3
        Top = 150
        Width = 26
        Height = 13
        Caption = 'S&tep:'
      end
      object eProgressInterval: TEdit
        Left = 51
        Top = 13
        Width = 121
        Height = 21
        TabOrder = 0
        Text = '100'
        OnKeyPress = eProgressStepKeyPress
      end
      object eProgressMin: TEdit
        Left = 51
        Top = 40
        Width = 121
        Height = 21
        TabOrder = 1
        Text = '0'
        OnKeyPress = eProgressStepKeyPress
      end
      object eProgressMax: TEdit
        Left = 51
        Top = 67
        Width = 121
        Height = 21
        TabOrder = 2
        Text = '0'
        OnKeyPress = eProgressStepKeyPress
      end
      object eProgressPosition: TEdit
        Left = 51
        Top = 93
        Width = 121
        Height = 21
        TabOrder = 3
        Text = '0'
        OnKeyPress = eProgressStepKeyPress
      end
      object eProgressStep: TEdit
        Left = 51
        Top = 147
        Width = 121
        Height = 21
        TabOrder = 5
        Text = '1'
        OnKeyPress = eProgressStepKeyPress
      end
      object cboxProgressState: TComboBox
        Left = 51
        Top = 120
        Width = 121
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 4
        Text = 'Normal'
        Items.Strings = (
          'Normal'
          'Paused'
          'Error')
      end
      object cbProgressUseNativeProgressBar: TCheckBox
        Left = 51
        Top = 174
        Width = 194
        Height = 17
        Caption = 'Use Native Progress Bar'
        TabOrder = 6
      end
    end
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = []
    Left = 723
    Top = 295
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 721
    Top = 191
  end
  object ColorDialog1: TColorDialog
    Color = clBtnFace
    Options = [cdFullOpen, cdAnyColor]
    Left = 723
    Top = 244
  end
  object ActionList1: TActionList
    Left = 722
    Top = 340
    object aDeleteCustomButton: TAction
      Caption = '&Delete'
      OnExecute = aDeleteCustomButtonExecute
      OnUpdate = aDeleteCustomButtonUpdate
    end
    object aDeleteRadioButton: TAction
      Caption = '&Delete'
      OnExecute = aDeleteRadioButtonExecute
      OnUpdate = aDeleteRadioButtonUpdate
    end
  end
end
