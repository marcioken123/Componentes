object LMDDistanceAndSizeEditor: TLMDDistanceAndSizeEditor
  Left = 266
  Top = 168
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Please define object positioning'
  ClientHeight = 312
  ClientWidth = 301
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object plArea: TPanel
    Left = 0
    Top = 0
    Width = 301
    Height = 190
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 41
      Top = 44
      Height = 102
      AutoSnap = False
      Color = clWhite
      MinSize = 1
      ParentColor = False
    end
    object Splitter2: TSplitter
      Left = 257
      Top = 44
      Height = 102
      Align = alRight
      AutoSnap = False
      Color = clWhite
      MinSize = 1
      ParentColor = False
    end
    object Splitter3: TSplitter
      Left = 1
      Top = 41
      Width = 299
      Height = 3
      Cursor = crVSplit
      Align = alTop
      AutoSnap = False
      Color = clWhite
      MinSize = 1
      ParentColor = False
    end
    object Splitter4: TSplitter
      Left = 1
      Top = 146
      Width = 299
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      AutoSnap = False
      Color = clWhite
      MinSize = 1
      ParentColor = False
    end
    object plBottomMargin: TPanel
      Left = 1
      Top = 149
      Width = 299
      Height = 40
      Align = alBottom
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      OnResize = plTopMarginResize
    end
    object plTopMargin: TPanel
      Left = 1
      Top = 1
      Width = 299
      Height = 40
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 1
      OnResize = plTopMarginResize
    end
    object plLeftMargin: TPanel
      Left = 1
      Top = 44
      Width = 40
      Height = 102
      Align = alLeft
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 2
      OnResize = plTopMarginResize
    end
    object plRightMargin: TPanel
      Left = 260
      Top = 44
      Width = 40
      Height = 102
      Align = alRight
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 3
      OnResize = plTopMarginResize
    end
    object plElement: TPanel
      Left = 44
      Top = 44
      Width = 213
      Height = 102
      Align = alClient
      Caption = 'Legend contents area'
      TabOrder = 4
      OnMouseDown = plElementMouseDown
      OnMouseMove = plElementMouseMove
      OnMouseUp = plElementMouseUp
    end
  end
  object plTools: TPanel
    Left = 0
    Top = 190
    Width = 301
    Height = 122
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      301
      122)
    object Label1: TLabel
      Left = 8
      Top = 6
      Width = 80
      Height = 13
      Caption = 'Margin values'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btOK: TButton
      Left = 216
      Top = 92
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btCancel: TButton
      Left = 136
      Top = 92
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object LMDMarginsEditor1: TLMDMarginsEditor
      Left = 56
      Top = 18
      Width = 185
      Height = 73
      DesignSize = (
        185
        73)
    end
  end
end
