object LMDSedGotoLineDlg: TLMDSedGotoLineDlg
  Left = 557
  Top = 382
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Go to line'
  ClientHeight = 69
  ClientWidth = 187
  Color = clBtnFace
  Constraints.MaxHeight = 103
  Constraints.MaxWidth = 195
  Constraints.MinHeight = 101
  Constraints.MinWidth = 193
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
    Left = 0
    Top = 0
    Width = 187
    Height = 9
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
  end
  object Panel2: TPanel
    Left = 0
    Top = 36
    Width = 187
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      187
      29)
    object Panel3: TPanel
      Left = 182
      Top = 0
      Width = 5
      Height = 29
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
    end
    object btnOk: TButton
      Left = 9
      Top = 0
      Width = 80
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object Panel6: TPanel
      Left = 177
      Top = 0
      Width = 5
      Height = 29
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 3
    end
    object Button1: TButton
      Left = 98
      Top = 0
      Width = 80
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object Panel4: TPanel
    Left = 182
    Top = 9
    Width = 5
    Height = 23
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 3
  end
  object Panel5: TPanel
    Left = 0
    Top = 65
    Width = 187
    Height = 4
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
  end
  object Panel7: TPanel
    Left = 0
    Top = 9
    Width = 182
    Height = 23
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      182
      23)
    object lblCaption: TLabel
      Left = 9
      Top = 3
      Width = 51
      Height = 14
      Align = alCustom
      Caption = 'Go to line: '
    end
    object edtLine: TMaskEdit
      Left = 100
      Top = 0
      Width = 78
      Height = 22
      Anchors = [akLeft, akTop, akRight]
      EditMask = '0'
      MaxLength = 1
      TabOrder = 0
      Text = ' '
    end
  end
  object Panel8: TPanel
    Left = 0
    Top = 32
    Width = 187
    Height = 4
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
  end
end
