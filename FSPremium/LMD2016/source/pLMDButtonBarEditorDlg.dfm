object frmLMDButtonBarEditorDlg: TfrmLMDButtonBarEditorDlg
  Left = 496
  Top = 191
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'TLMDButtonBar Editor'
  ClientHeight = 486
  ClientWidth = 504
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object s1: TLMDSpeedButton
    Tag = 1
    Left = 158
    Top = 4
    Width = 63
    Height = 22
    Caption = '&Section'
    OnClick = s1Click
    CtlXP = False
    FontFX.Style = tdSunken
    GroupIndex = 1
    Pressed = True
  end
  object s2: TLMDSpeedButton
    Tag = 2
    Left = 222
    Top = 4
    Width = 63
    Height = 22
    Caption = '&General'
    OnClick = s1Click
    CtlXP = False
    GroupIndex = 1
  end
  object pages: TLMDNoteBook
    Left = 146
    Top = 32
    Width = 352
    Height = 213
    TabOrder = 1
    ActivePage = Section
    object Section: TLMDNoteBookPage
      Left = 0
      Top = 0
      Width = 352
      Height = 213
      Bevel.BorderSides = [fsBottom, fsLeft, fsRight]
      Bevel.Mode = bmCustom
      object LMDGroupBox1: TLMDGroupBox
        Left = 0
        Top = 0
        Width = 352
        Height = 104
        CtlXP = False
        ParentColor = False
        Align = alTop
        Alignment = gcaLeftCenter
        Bevel.BorderSides = [fsBottom, fsLeft, fsRight]
        Bevel.Mode = bmWindows
        Bevel.StandardStyle = lsFrameInset
        Caption = 'Sections'
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clNavy
        CaptionFont.Height = -11
        CaptionFont.Name = 'Arial'
        CaptionFont.Style = [fsBold]
        CaptionFont3D.Style = tdSunken
        CaptionParentFont = False
        TabOrder = 0
        object LMDSimpleLabel3: TLMDSimpleLabel
          Left = 102
          Top = 46
          Width = 120
          Height = 15
          Caption = 'ListIndex current section:'
          Options = []
        end
        object LMDSimpleLabel7: TLMDSimpleLabel
          Left = 276
          Top = 46
          Width = 59
          Height = 15
          Caption = '(small/large)'
          Options = []
        end
        object btnSectionAdd: TLMDButton
          Left = 20
          Top = 9
          Width = 70
          Height = 23
          Caption = '&Add'
          TabOrder = 0
          OnClick = btnClick
          CtlXP = False
        end
        object btnSectionRename: TLMDButton
          Left = 20
          Top = 36
          Width = 70
          Height = 23
          Caption = '&Rename'
          TabOrder = 1
          OnClick = btnClick
          CtlXP = False
        end
        object btnSectionDelete: TLMDButton
          Left = 20
          Top = 64
          Width = 70
          Height = 23
          Caption = '&Delete'
          TabOrder = 2
          OnClick = btnClick
          CtlXP = False
        end
        object btnSectionFont: TLMDButton
          Left = 99
          Top = 9
          Width = 70
          Height = 23
          Caption = '&Font'
          TabOrder = 3
          OnClick = btnClick
          CtlXP = False
        end
        object btnSectionFont3D: TLMDButton
          Left = 176
          Top = 9
          Width = 70
          Height = 23
          Caption = 'Font3D'
          TabOrder = 4
          OnClick = btnClick
          CtlXP = False
        end
        object edImg: TLMDSpinEdit
          Left = 224
          Top = 42
          Width = 45
          Height = 21
          Bevel.Mode = bmWindows
          Caret.BlinkRate = 530
          CtlXP = False
          TabOrder = 5
          OnChange = edImgChange
          AutoSelect = True
          Alignment = taRightJustify
          CustomButtons = <>
          SpinBtnDiag = False
          MaxValue = 5000
          Value = 0
        end
        object chkParentFont: TLMDCheckBox
          Left = 103
          Top = 69
          Width = 75
          Height = 18
          CtlXP = False
          Caption = 'ParentFont'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          AutoSize = True
          TabOrder = 6
          OnChange = btnClick
        end
      end
      object LMDGroupBox2: TLMDGroupBox
        Left = 0
        Top = 111
        Width = 352
        Height = 102
        CtlXP = False
        ParentColor = False
        Align = alBottom
        Alignment = gcaLeftCenter
        Bevel.BorderSides = [fsBottom, fsLeft, fsRight]
        Bevel.Mode = bmWindows
        Bevel.StandardStyle = lsFrameInset
        Caption = 'Items'
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clNavy
        CaptionFont.Height = -11
        CaptionFont.Name = 'Arial'
        CaptionFont.Style = [fsBold]
        CaptionFont3D.Style = tdSunken
        CaptionParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object LMDSimpleLabel6: TLMDSimpleLabel
          Left = 20
          Top = 43
          Width = 84
          Height = 54
          MultiLine = True
          Caption = 'Use ButtonBar contextmenu to rename or delete items.'
          Options = []
        end
        object btnAddItem: TLMDButton
          Left = 21
          Top = 12
          Width = 70
          Height = 23
          Caption = 'Add Item'
          TabOrder = 0
          OnClick = btnClick
          CtlXP = False
        end
        object eigb: TLMDGroupBox
          Left = 112
          Top = 12
          Width = 231
          Height = 81
          CtlXP = False
          ParentColor = False
          Bevel.Mode = bmWindows
          Bevel.StandardStyle = lsFrameInset
          CaptionFont.Charset = DEFAULT_CHARSET
          CaptionFont.Color = clBlack
          CaptionFont.Height = -11
          CaptionFont.Name = 'MS Sans Serif'
          CaptionFont.Style = [fsBold]
          CaptionParentFont = False
          TabOrder = 1
          object LMDSimpleLabel8: TLMDSimpleLabel
            Left = 9
            Top = 18
            Width = 211
            Height = 41
            MultiLine = True
            Caption = 
              'Doubleclick on desired image in ImageList(s) or click buttons be' +
              'low to browse for bitmap files.'
            Options = []
          end
          object lgbtn: TLMDButton
            Left = 49
            Top = 50
            Width = 70
            Height = 23
            Caption = 'Large glyph'
            TabOrder = 0
            OnClick = lgbtnClick
            CtlXP = False
          end
          object sgbtn: TLMDButton
            Left = 125
            Top = 50
            Width = 70
            Height = 23
            Caption = 'Small glyph'
            TabOrder = 1
            OnClick = lgbtnClick
            CtlXP = False
          end
        end
      end
    end
    object General: TLMDNoteBookPage
      Left = 0
      Top = 0
      Width = 352
      Height = 213
      Bevel.Mode = bmCustom
      object LMDGroupBox3: TLMDGroupBox
        Left = 0
        Top = 0
        Width = 352
        Height = 145
        CtlXP = False
        ParentColor = False
        Align = alTop
        Alignment = gcaBottomRight
        Bevel.BorderSides = [fsBottom, fsLeft, fsRight]
        Bevel.Mode = bmWindows
        Bevel.StandardStyle = lsFrameInset
        Caption = 'ButtonBar - General Properties'
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clNavy
        CaptionFont.Height = -11
        CaptionFont.Name = 'Arial'
        CaptionFont.Style = [fsBold]
        CaptionFont3D.Style = tdSunken
        CaptionParentFont = False
        TabOrder = 0
        object LMDSimpleLabel4: TLMDSimpleLabel
          Left = 123
          Top = 56
          Width = 86
          Height = 15
          Caption = 'LargeItem Height:'
          Options = []
        end
        object LMDSimpleLabel5: TLMDSimpleLabel
          Left = 123
          Top = 83
          Width = 82
          Height = 15
          Caption = 'SmalItem Height:'
          Options = []
        end
        object btnFillObject: TLMDButton
          Left = 16
          Top = 16
          Width = 70
          Height = 23
          Caption = 'FillObject'
          TabOrder = 0
          OnClick = btnClick
          CtlXP = False
        end
        object btnFont: TLMDButton
          Left = 121
          Top = 16
          Width = 70
          Height = 23
          Caption = 'Font'
          TabOrder = 1
          OnClick = btnClick
          CtlXP = False
        end
        object btnBevel: TLMDButton
          Left = 16
          Top = 48
          Width = 70
          Height = 23
          Caption = 'Bevel'
          TabOrder = 2
          OnClick = btnClick
          CtlXP = False
        end
        object btnFont3D: TLMDButton
          Left = 194
          Top = 16
          Width = 70
          Height = 23
          Caption = 'Font3D'
          TabOrder = 3
          OnClick = btnClick
          CtlXP = False
        end
        object LMDCheckBox1: TLMDCheckBox
          Left = 16
          Top = 80
          Width = 105
          Height = 17
          CtlXP = False
          Caption = 'Transparent'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Flat = True
          TabOrder = 4
          OnChange = btnClick
        end
        object lih: TLMDSpinEdit
          Left = 220
          Top = 53
          Width = 45
          Height = 21
          Bevel.Mode = bmWindows
          Caret.BlinkRate = 530
          CtlXP = False
          TabOrder = 5
          OnChange = ihChange
          AutoSelect = True
          Alignment = taRightJustify
          CustomButtons = <>
          SpinBtnDiag = False
          MaxValue = 5000
          Value = 0
        end
        object sih: TLMDSpinEdit
          Left = 220
          Top = 80
          Width = 45
          Height = 21
          Bevel.Mode = bmWindows
          Caret.BlinkRate = 530
          CtlXP = False
          TabOrder = 6
          OnChange = ihChange
          AutoSelect = True
          Alignment = taRightJustify
          CustomButtons = <>
          SpinBtnDiag = False
          MaxValue = 5000
          Value = 0
        end
      end
    end
  end
  object bbar: TLMDButtonBar
    Left = 0
    Top = 0
    Width = 143
    Height = 486
    UseDockManager = False
    Align = alLeft
    Bevel.Mode = bmCustom
    PopupMenu = LMDButtonBarPopupMenu1
    Sections = <>
    FillObject.Style = sfBrush
    FillObject.Brush.Color = clAppWorkSpace
    OnItemClick = bbarItemClick
    OnSectionChanged = bbarSectionChanged
  end
  object LMDDlgButtonPanel1: TLMDDlgButtonPanel
    Left = 228
    Top = 445
    Width = 276
    Height = 42
    CtlXP = False
    Anchors = [akRight, akBottom]
    Bevel.Mode = bmCustom
    TabOrder = 2
    BtnAlign = baRightBottom
    object btnOK1: TLMDButton
      Left = 106
      Top = 9
      Width = 75
      Height = 24
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      CtlXP = False
    end
    object btnCancel1: TLMDButton
      Left = 191
      Top = 9
      Width = 75
      Height = 24
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      CtlXP = False
    end
  end
  object LMDGroupBox4: TLMDGroupBox
    Left = 152
    Top = 252
    Width = 345
    Height = 185
    CtlXP = False
    ParentColor = False
    Bevel.Mode = bmWindows
    Bevel.StandardStyle = lsFrameInset
    Caption = 'Image list settings for all section'
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clNavy
    CaptionFont.Height = -11
    CaptionFont.Name = 'MS Sans Serif'
    CaptionFont.Style = [fsBold]
    CaptionFont3D.Style = tdSunken
    CaptionParentFont = False
    TabOrder = 3
    object LMDSimpleLabel2: TLMDSimpleLabel
      Left = 185
      Top = 18
      Width = 75
      Height = 15
      Caption = 'Large image list'
      Options = []
    end
    object LMDSimpleLabel1: TLMDSimpleLabel
      Left = 17
      Top = 18
      Width = 73
      Height = 15
      Caption = 'Small image list'
      Options = []
    end
    object largelbx: TLMDImageListBox
      Left = 184
      Top = 62
      Width = 140
      Height = 115
      ItemHeight = 16
      TabOrder = 0
      OnDblClick = largelbxDblClick
      CtlXP = False
      Options = [lboImageListOrder, lboCheckImageNr, lboCalcHeight]
      ItemIndex = -1
      Layout.Alignment = agTopLeft
      ImagesOnly = True
    end
    object large: TLMDEdit
      Left = 184
      Top = 37
      Width = 140
      Height = 21
      Bevel.Mode = bmWindows
      Caret.BlinkRate = 530
      CtlXP = False
      TabOrder = 1
      CustomButtons = <
        item
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Index = 0
          DisplayName = 'TLMDSpecialButton'
        end>
      PasswordChar = #0
      ReadOnly = True
      Text = '(none)'
      OnBtnClick = smallBtnClick
    end
    object small: TLMDEdit
      Left = 17
      Top = 37
      Width = 140
      Height = 21
      Bevel.Mode = bmWindows
      Caret.BlinkRate = 530
      CtlXP = False
      TabOrder = 2
      CustomButtons = <
        item
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Index = 0
          DisplayName = 'TLMDSpecialButton'
        end>
      PasswordChar = #0
      ReadOnly = True
      Text = '(none)'
      OnBtnClick = smallBtnClick
    end
    object smalllbx: TLMDImageListBox
      Left = 17
      Top = 61
      Width = 140
      Height = 116
      ItemHeight = 16
      TabOrder = 3
      OnDblClick = largelbxDblClick
      CtlXP = False
      Options = [lboImageListOrder, lboCheckImageNr, lboCalcHeight]
      ItemIndex = -1
      Layout.Alignment = agTopLeft
      ImagesOnly = True
    end
  end
  object LMDButtonBarPopupMenu1: TLMDButtonBarPopupMenu
    Left = 8
    Top = 8
  end
  object opd: TOpenPictureDialog
    Left = 465
    Top = 8
  end
end
