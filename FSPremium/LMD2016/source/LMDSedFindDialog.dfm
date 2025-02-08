object LMDSedFindDlg: TLMDSedFindDlg
  Left = 295
  Top = 160
  BorderIcons = [biSystemMenu]
  Caption = 'LMDSedFindDlg'
  ClientHeight = 250
  ClientWidth = 453
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 445
    Top = 0
    Width = 8
    Height = 250
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 8
    Height = 250
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
  end
  object Panel3: TPanel
    Left = 8
    Top = 0
    Width = 437
    Height = 250
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnOpts1: TPanel
      Left = 0
      Top = 53
      Width = 437
      Height = 61
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object grOptions: TGroupBox
        Left = 0
        Top = 0
        Width = 311
        Height = 61
        Align = alLeft
        Caption = 'Options'
        TabOrder = 0
        object cbCaseSensitive: TCheckBox
          Left = 8
          Top = 15
          Width = 123
          Height = 18
          Caption = '&Case sensitive'
          TabOrder = 0
        end
        object cbWholeWords: TCheckBox
          Left = 8
          Top = 36
          Width = 142
          Height = 19
          Caption = '&Whole words only'
          TabOrder = 1
        end
        object cbRegexps: TCheckBox
          Left = 156
          Top = 15
          Width = 151
          Height = 18
          Caption = 'Regular e&xpressions'
          TabOrder = 2
        end
        object cbConfirmReplace: TCheckBox
          Left = 156
          Top = 36
          Width = 148
          Height = 18
          Caption = '&Prompt on replace'
          TabOrder = 3
        end
      end
      object grDirection: TGroupBox
        Left = 315
        Top = 0
        Width = 122
        Height = 61
        Align = alClient
        Caption = 'Direction'
        Constraints.MinWidth = 122
        TabOrder = 1
        object cbBackward: TRadioButton
          Left = 7
          Top = 38
          Width = 73
          Height = 16
          Caption = '&Backward'
          TabOrder = 1
        end
        object cbForward: TRadioButton
          Left = 7
          Top = 16
          Width = 66
          Height = 17
          Caption = 'Forwar&d'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
      end
      object Panel4: TPanel
        Left = 311
        Top = 0
        Width = 4
        Height = 61
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 2
      end
    end
    object pnOpts2: TPanel
      Left = 0
      Top = 117
      Width = 437
      Height = 59
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 3
      object grStartFrom: TGroupBox
        Left = 234
        Top = 0
        Width = 203
        Height = 59
        Align = alClient
        Caption = 'Start from'
        TabOrder = 1
        object cbFromCursor: TRadioButton
          Left = 7
          Top = 17
          Width = 99
          Height = 20
          Caption = '&From cursor'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object cbFromTextStart: TRadioButton
          Left = 7
          Top = 40
          Width = 146
          Height = 16
          Caption = 'From text &start/end'
          TabOrder = 1
        end
      end
      object grBounds: TGroupBox
        Left = 0
        Top = 0
        Width = 230
        Height = 59
        Align = alLeft
        Caption = 'Bounds for replace all'
        TabOrder = 0
        object cbAllText: TRadioButton
          Left = 8
          Top = 18
          Width = 216
          Height = 19
          Caption = '&Global'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object cbSelection: TRadioButton
          Left = 8
          Top = 39
          Width = 214
          Height = 18
          Caption = '&Selection'
          TabOrder = 1
        end
      end
      object pnReplacePadding: TPanel
        Left = 230
        Top = 0
        Width = 4
        Height = 59
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 2
      end
    end
    object pnReplaceBtns: TPanel
      Left = 0
      Top = 211
      Width = 437
      Height = 39
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 4
      DesignSize = (
        437
        39)
      object btnReplace: TButton
        Left = 176
        Top = 7
        Width = 80
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'OK'
        Default = True
        ModalResult = 1
        TabOrder = 0
        OnClick = btnFindClick
      end
      object btnReplaceCancel: TButton
        Left = 358
        Top = 7
        Width = 80
        Height = 25
        Anchors = [akTop, akRight]
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 2
      end
      object btnReplaceAll: TButton
        Left = 272
        Top = 7
        Width = 80
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Replace &All'
        ModalResult = 1
        TabOrder = 1
        OnClick = btnReplaceAllClick
      end
    end
    object pnReplaceText: TPanel
      Left = 0
      Top = 27
      Width = 437
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      Caption = '/'
      TabOrder = 1
      DesignSize = (
        437
        26)
      object lblTextToReplace: TLabel
        Left = 0
        Top = 5
        Width = 66
        Height = 14
        Caption = '&Replace with:'
        FocusControl = edReplaceText
      end
      object edReplaceText: TComboBox
        Left = 88
        Top = 3
        Width = 349
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
    end
    object pnSearch: TPanel
      Left = 0
      Top = 0
      Width = 437
      Height = 27
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        437
        27)
      object lblTextToSearch: TLabel
        Left = 0
        Top = 9
        Width = 72
        Height = 14
        Caption = '&Text to search:'
        FocusControl = edTextToSearch
      end
      object edTextToSearch: TComboBox
        Left = 88
        Top = 5
        Width = 349
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
    end
    object pnSearchBtns: TPanel
      Left = 0
      Top = 176
      Width = 437
      Height = 35
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 5
      DesignSize = (
        437
        35)
      object btnFind: TButton
        Left = 267
        Top = 5
        Width = 80
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'OK'
        Default = True
        ModalResult = 1
        TabOrder = 0
        OnClick = btnFindClick
      end
      object btnFindCancel: TButton
        Left = 357
        Top = 5
        Width = 80
        Height = 25
        Anchors = [akTop, akRight]
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 1
      end
    end
    object Panel6: TPanel
      Left = 0
      Top = 114
      Width = 437
      Height = 3
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 6
    end
  end
end
