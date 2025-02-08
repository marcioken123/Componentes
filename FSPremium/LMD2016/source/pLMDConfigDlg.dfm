object LMDConfigDlg: TLMDConfigDlg
  Left = 490
  Top = 343
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  ClientHeight = 326
  ClientWidth = 615
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object pnlBottom: TPanel
    Left = 0
    Top = 294
    Width = 615
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      615
      32)
    object ok: TButton
      Left = 423
      Top = 0
      Width = 85
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = okClick
    end
    object Button2: TButton
      Left = 518
      Top = 0
      Width = 85
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 161
    Height = 294
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      161
      294)
    object tvCategories: TTreeView
      Left = 6
      Top = 8
      Width = 147
      Height = 277
      Anchors = [akLeft, akTop, akRight, akBottom]
      HideSelection = False
      Indent = 19
      MultiSelectStyle = []
      ReadOnly = True
      RightClickSelect = True
      TabOrder = 0
      OnChange = tvCategoriesChange
      Items.Data = {
        03000000210000000000000000000000FFFFFFFFFFFFFFFF0000000002000000
        0853657474696E6773280000000000000000000000FFFFFFFFFFFFFFFF000000
        00000000000F49444520496E746567726174696F6E2700000000000000000000
        00FFFFFFFFFFFFFFFF00000000000000000E536861726564204F7074696F6E73
        200000000000000000000000FFFFFFFFFFFFFFFF000000000000000007537570
        706F72741D0000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
        04496E666F}
    end
  end
  object Panel1: TPanel
    Left = 161
    Top = 0
    Width = 454
    Height = 294
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      454
      294)
    object Bevel1: TBevel
      Left = 0
      Top = 283
      Width = 447
      Height = 2
      Anchors = [akLeft, akRight, akBottom]
      Shape = bsTopLine
    end
    object nb: TNotebook
      Left = 1
      Top = 50
      Width = 443
      Height = 228
      Anchors = [akLeft, akTop, akRight, akBottom]
      PageIndex = 4
      TabOrder = 0
      OnPageChanged = nbPageChanged
      object TPage
        Left = 0
        Top = 0
        Caption = 'Info'
        object lblversion: TLabel
          Left = 6
          Top = 7
          Width = 4
          Height = 16
          Caption = ' '
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblversionExt: TLabel
          Left = 6
          Top = 32
          Width = 3
          Height = 14
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lbldesc: TLabel
          Left = 6
          Top = 107
          Width = 367
          Height = 14
          Caption = 
            'Visit our web site for latest updates and other related componen' +
            't packages:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lblcopyright: TLabel
          Left = 6
          Top = 150
          Width = 149
          Height = 14
          Caption = #169' by LMD Innovative, Germany'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object bv: TBevel
          Left = 6
          Top = 26
          Width = 324
          Height = 9
          Shape = bsTopLine
        end
        object LMDSysURLLabel1: TLMDURLLabel
          Left = 127
          Top = 123
          Width = 147
          Height = 14
          Cursor = crHandPoint
          Caption = 'http://www.lmdinnovative.com'
          Jump = 'http://www.lmdinnovative.com'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsUnderline]
          ParentFont = False
        end
        object lblComponent: TLabel
          Left = 6
          Top = 48
          Width = 3
          Height = 14
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lblvnumber: TLabel
          Left = 6
          Top = 36
          Width = 3
          Height = 14
          Caption = ' '
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object btnReg: TButton
          Left = 356
          Top = 150
          Width = 85
          Height = 25
          Hint = 'Click this button to '#13#10'start Registration Utility.'
          Caption = 'Reg Utility'
          TabOrder = 0
          OnClick = btnRegClick
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'IDE Integration'
        object Label4: TLabel
          Left = 13
          Top = 175
          Width = 165
          Height = 12
          Caption = 'Restart IDE to let changes take effect.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 15
          Top = 23
          Width = 206
          Height = 14
          Caption = 'Enable extended LMD property/OI editors...'
        end
        object globalbox: TCheckListBox
          Left = 14
          Top = 38
          Width = 200
          Height = 130
          IntegralHeight = True
          ItemHeight = 14
          Items.Strings = (
            'TBrush property editor'
            'TCaption property editor'
            'THint property editor'
            'TShortCut property Editor'
            'String property editor'
            'OI Font visualization'
            'OI Boolean visualization'
            'OI Set visualization'
            'TStrings property editor')
          TabOrder = 0
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'Shared Options'
        object lblLMDSettings: TLabel
          Left = 15
          Top = 18
          Width = 191
          Height = 14
          Caption = 'Specific component and expert settings'
        end
        object Label3: TLabel
          Left = 15
          Top = 91
          Width = 172
          Height = 12
          Caption = '* Restart IDE to let changes take effect.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object LMDBox: TCheckListBox
          Left = 15
          Top = 38
          Width = 407
          Height = 46
          IntegralHeight = True
          ItemHeight = 14
          Items.Strings = (
            'Install labeled controls'
            
              'Install design-time controls (controls which are used in designt' +
              'ime editors)'
            'Install Importer Expert [LMD ScriptPack]')
          TabOrder = 0
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'Support'
        object lblquestion: TLabel
          Left = 7
          Top = 16
          Width = 412
          Height = 14
          Caption = 
            'If you have any questions or suggestions regarding LMD VCL produ' +
            'cts send email to:'
        end
        object lblsupport: TLMDURLLabel
          Left = 189
          Top = 34
          Width = 105
          Height = 14
          Cursor = crHandPoint
          Caption = 'mail@lmdsupport.com'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsUnderline]
          ParentFont = False
        end
        object lblsite: TLabel
          Left = 8
          Top = 64
          Width = 107
          Height = 14
          Caption = 'LMD VCL SupportSite:'
        end
        object lmdurl1: TLMDURLLabel
          Left = 189
          Top = 63
          Width = 108
          Height = 14
          Cursor = crHandPoint
          Caption = 'www.lmdsupport.com'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsUnderline]
          ParentFont = False
        end
        object lblnews: TLabel
          Left = 8
          Top = 85
          Width = 81
          Height = 14
          Caption = 'LMD VCL Forum:'
        end
        object lmdurl2: TLMDURLLabel
          Left = 189
          Top = 84
          Width = 62
          Height = 14
          Cursor = crHandPoint
          Caption = 'forum.lmd.de'
          Jump = 'http://forum.lmd.de'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsUnderline]
          ParentFont = False
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'Settings'
        object Label2: TLabel
          Left = 8
          Top = 8
          Width = 165
          Height = 14
          Caption = 'Please select an option on the left.'
        end
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 9
      Width = 447
      Height = 32
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvLowered
      Color = 10485760
      TabOrder = 1
      DesignSize = (
        447
        32)
      object lblPageTitle: TLabel
        Left = 7
        Top = 7
        Width = 433
        Height = 25
        Anchors = [akLeft, akRight]
        AutoSize = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
    end
  end
end
