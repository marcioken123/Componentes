object frmStdActionList: TfrmStdActionList
  Left = 0
  Top = 0
  Caption = 'LMD Standard Actions List'
  ClientHeight = 402
  ClientWidth = 253
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object TreeView1: TTreeView
    Left = 0
    Top = 0
    Width = 253
    Height = 361
    Align = alClient
    Indent = 19
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 361
    Width = 253
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Button1: TButton
      Left = 8
      Top = 9
      Width = 75
      Height = 25
      Caption = 'O&K'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 89
      Top = 9
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object Button3: TButton
      Left = 170
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Help'
      TabOrder = 2
    end
  end
end
