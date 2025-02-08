object LMDShellCustomPathForm: TLMDShellCustomPathForm
  Left = 325
  Top = 205
  Width = 377
  Height = 439
  BorderIcons = [biSystemMenu]
  Color = clBtnFace
  Constraints.MinHeight = 280
  Constraints.MinWidth = 377
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 359
    Width = 369
    Height = 7
    Align = alBottom
    Shape = bsBottomLine
  end
  object Panel1: TPanel
    Left = 0
    Top = 366
    Width = 369
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object OkBtn: TButton
      Left = 178
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object CancelBtn: TButton
      Left = 258
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 369
    Height = 20
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object InstructionLabel: TLabel
      Left = 10
      Top = 0
      Width = 323
      Height = 20
      AutoSize = False
      Layout = tlBottom
      WordWrap = True
    end
  end
  inline LMDShellPathFrame1: TLMDShellPathFrame
    Top = 20
    Width = 369
    Height = 339
    Align = alClient
    TabOrder = 2
    inherited UpBtn: TSpeedButton
      Left = 337
      Top = 101
    end
    inherited DownBtn: TSpeedButton
      Left = 337
      Top = 133
    end
    inherited FirstBtn: TSpeedButton
      Left = 337
      Top = 76
    end
    inherited LastBtn: TSpeedButton
      Left = 337
      Top = 158
    end
    inherited PathListBox: TListBox
      Width = 324
      Height = 254
    end
    inherited DeleteBtn: TButton
      Left = 153
      Top = 305
    end
    inherited AddBtn: TButton
      Top = 305
    end
    inherited ReplaceBtn: TButton
      Top = 305
    end
    inherited PathEdit: TEdit
      Top = 277
      Width = 292
    end
    inherited BrowseBtn: TButton
      Left = 307
      Top = 274
    end
    inherited DelInvalidPathsBtn: TButton
      Left = 225
      Top = 305
    end
  end
end
