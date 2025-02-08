object LMDRegExprForm: TLMDRegExprForm
  Left = 161
  Top = 151
  Width = 469
  Height = 495
  Caption = 'Regular expression'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 461
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 11
      Width = 90
      Height = 13
      Caption = 'Regular expression'
    end
    object edRegExpr: TEdit
      Left = 112
      Top = 8
      Width = 262
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object btUpdateExpr: TButton
      Left = 381
      Top = 7
      Width = 70
      Height = 24
      Anchors = [akTop, akRight]
      Caption = 'Update'
      TabOrder = 1
      OnClick = btUpdateExprClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 428
    Width = 461
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btLoadFile: TButton
      Left = 8
      Top = 2
      Width = 75
      Height = 24
      Caption = 'Load file...'
      TabOrder = 0
      OnClick = btLoadFileClick
    end
    object btSaveFile: TButton
      Left = 88
      Top = 2
      Width = 75
      Height = 24
      Caption = 'Save file...'
      TabOrder = 1
      OnClick = btSaveFileClick
    end
    object btOK: TButton
      Left = 303
      Top = 2
      Width = 70
      Height = 24
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 2
    end
    object btCancel: TButton
      Left = 379
      Top = 2
      Width = 70
      Height = 24
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 3
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 33
    Width = 461
    Height = 395
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Label2: TLabel
      Left = 18
      Top = 3
      Width = 80
      Height = 13
      Caption = 'Expression name'
    end
    object sgExpressions: TStringGrid
      Left = 8
      Top = 32
      Width = 366
      Height = 356
      Anchors = [akLeft, akTop, akRight, akBottom]
      ColCount = 2
      DefaultColWidth = 150
      DefaultRowHeight = 20
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
      TabOrder = 0
      OnClick = sgExpressionsClick
      OnDblClick = sgExpressionsDblClick
      OnSetEditText = sgExpressionsSetEditText
    end
    object btAddExpr: TButton
      Left = 381
      Top = 0
      Width = 70
      Height = 24
      Anchors = [akTop, akRight]
      Caption = 'Append'
      TabOrder = 1
      OnClick = btAddExprClick
    end
    object btRemove: TButton
      Left = 381
      Top = 34
      Width = 70
      Height = 24
      Anchors = [akTop, akRight]
      Caption = 'Remove'
      TabOrder = 2
      OnClick = btRemoveClick
    end
    object edExprName: TEdit
      Left = 112
      Top = 0
      Width = 262
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'txt'
    Filter = 'Text files (*.txt)|*.txt|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 176
    Top = 185
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text files (*.txt)|*.txt|All files (*.*)|*.*'
    Left = 216
    Top = 185
  end
end
