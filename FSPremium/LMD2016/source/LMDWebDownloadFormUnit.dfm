object LMDWebDownload: TLMDWebDownload
  Left = 280
  Top = 228
  AutoScroll = False
  BorderIcons = []
  Caption = 'Download'
  ClientHeight = 168
  ClientWidth = 361
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 67
    Width = 51
    Height = 13
    Caption = 'Download:'
  end
  object DownloadLabel: TLabel
    Left = 90
    Top = 67
    Width = 266
    Height = 13
    AutoSize = False
  end
  object TransferLabel: TLabel
    Left = 9
    Top = 103
    Width = 68
    Height = 13
    Caption = 'Transfer rate:'
  end
  object CPSLabel: TLabel
    Left = 100
    Top = 103
    Width = 143
    Height = 13
    AutoSize = False
  end
  object Label2: TLabel
    Left = 9
    Top = 119
    Width = 49
    Height = 13
    Caption = 'Total size:'
  end
  object SizeLabel: TLabel
    Left = 100
    Top = 119
    Width = 143
    Height = 13
    AutoSize = False
  end
  object StopBtn: TButton
    Left = 275
    Top = 137
    Width = 80
    Height = 24
    Caption = '&Cancel'
    TabOrder = 0
    OnClick = StopBtnClick
  end
  object ProgressBar: TProgressBar
    Left = 9
    Top = 86
    Width = 345
    Height = 11
    Min = 0
    Max = 100
    TabOrder = 1
  end
  object CloseBtn: TButton
    Left = 191
    Top = 137
    Width = 77
    Height = 24
    Caption = 'Close'
    TabOrder = 2
    OnClick = CloseBtnClick
  end
  object CopyAnimate: TAnimate
    Left = 9
    Top = 8
    Width = 346
    Height = 56
    Active = False
    AutoSize = False
    Color = clBtnFace
    ParentColor = False
    StopFrame = 20
  end
end
