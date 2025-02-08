object LMDAboutDlg: TLMDAboutDlg
  Left = 470
  Top = 208
  ActiveControl = ok
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  ClientHeight = 474
  ClientWidth = 458
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
  OnShow = FormShow
  DesignSize = (
    458
    474)
  PixelsPerInch = 96
  TextHeight = 14
  object lblversion: TLabel
    Left = 14
    Top = 223
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
    Left = 14
    Top = 248
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
    Left = 16
    Top = 310
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
    Left = 15
    Top = 402
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
    Left = 14
    Top = 242
    Width = 324
    Height = 9
    Shape = bsTopLine
  end
  object lblwebsite: TLMDURLLabel
    Left = 137
    Top = 326
    Width = 148
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
  object lblsysinfo: TLabel
    Left = 14
    Top = 263
    Width = 3
    Height = 14
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object lblquestion: TLabel
    Left = 16
    Top = 357
    Width = 412
    Height = 14
    Caption = 
      'If you have any questions or suggestions regarding LMD VCL produ' +
      'cts send email to:'
  end
  object lblsupport: TLMDURLLabel
    Left = 157
    Top = 374
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
  object Bevel1: TBevel
    Left = 14
    Top = 296
    Width = 428
    Height = 9
    Shape = bsTopLine
  end
  object Bevel2: TBevel
    Left = 14
    Top = 425
    Width = 432
    Height = 9
    Shape = bsTopLine
  end
  object ok: TButton
    Left = 365
    Top = 441
    Width = 85
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 7
    Top = 5
    Width = 444
    Height = 204
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 1
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 440
      Height = 200
      Align = alClient
      AutoSize = True
    end
  end
  object Button1: TButton
    Left = 8
    Top = 443
    Width = 85
    Height = 25
    Hint = 'Copy component '#13#10'info to clipboard.'
    Anchors = [akRight, akBottom]
    Caption = 'Data2ClipBoard'
    TabOrder = 2
    OnClick = Button1Click
  end
  object btnReg: TButton
    Left = 365
    Top = 220
    Width = 85
    Height = 25
    Hint = 'Start Registration Utility.'
    Caption = 'Reg Utility'
    TabOrder = 3
    OnClick = btnRegClick
  end
  object Button2: TButton
    Left = 100
    Top = 443
    Width = 85
    Height = 25
    Hint = 'Options for all '#13#10'LMD Packages.'
    Caption = 'Settings...'
    TabOrder = 4
    OnClick = Button2Click
  end
end
