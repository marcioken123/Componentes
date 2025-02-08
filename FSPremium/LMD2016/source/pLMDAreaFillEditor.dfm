object LMDAreaFillEditor: TLMDAreaFillEditor
  Left = 277
  Top = 125
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Area fill editor'
  ClientHeight = 286
  ClientWidth = 187
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    187
    286)
  PixelsPerInch = 96
  TextHeight = 13
  object RadioGroup1: TRadioGroup
    Left = 11
    Top = 8
    Width = 166
    Height = 73
    Caption = 'Fill type'
    Columns = 2
    ItemIndex = 1
    Items.Strings = (
      'None'
      'Solid'
      'Gradient'
      'Image')
    TabOrder = 0
    OnClick = RadioGroup1Click
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 91
    Width = 169
    Height = 150
    ActivePage = tpSolid
    TabOrder = 1
    object tpSolid: TTabSheet
      Caption = 'Solid color'
      object pbSolidColor: TPaintBox
        Left = 8
        Top = 8
        Width = 65
        Height = 25
        OnPaint = pbSolidColorPaint
      end
      object btSolidColor: TButton
        Left = 80
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Color...'
        TabOrder = 0
        OnClick = btSolidColorClick
      end
    end
    object tpGradient: TTabSheet
      Caption = 'Gradient'
      ImageIndex = 1
      object pbGradientColor1: TPaintBox
        Left = 8
        Top = 8
        Width = 65
        Height = 25
        OnPaint = pbGradientColor1Paint
      end
      object pbGradientColor2: TPaintBox
        Left = 8
        Top = 40
        Width = 65
        Height = 25
        OnPaint = pbGradientColor2Paint
      end
      object Label1: TLabel
        Left = 8
        Top = 72
        Width = 27
        Height = 13
        Caption = 'Angle'
      end
      object Label2: TLabel
        Left = 8
        Top = 98
        Width = 45
        Height = 13
        Caption = 'Max LOD'
      end
      object btGradientColor1: TButton
        Left = 80
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Color...'
        TabOrder = 0
        OnClick = btGradientColor1Click
      end
      object btGradientColor2: TButton
        Left = 80
        Top = 40
        Width = 75
        Height = 25
        Caption = 'Color...'
        TabOrder = 1
        OnClick = btGradientColor2Click
      end
      object tbGradientAngle: TTrackBar
        Left = 40
        Top = 72
        Width = 121
        Height = 25
        Max = 360
        PageSize = 40
        Frequency = 20
        TabOrder = 2
        ThumbLength = 10
        OnChange = tbGradientAngleChange
      end
      object edMaxLOD: TEdit
        Left = 80
        Top = 96
        Width = 65
        Height = 21
        TabOrder = 3
        Text = '50'
      end
    end
    object tpImage: TTabSheet
      Caption = 'Image'
      ImageIndex = 2
      object Image1: TImage
        Left = 0
        Top = 0
        Width = 157
        Height = 72
        Stretch = True
      end
      object btImage: TButton
        Left = 4
        Top = 94
        Width = 75
        Height = 25
        Caption = 'Load...'
        TabOrder = 0
        OnClick = btImageClick
      end
      object rgImageMode: TRadioGroup
        Left = 86
        Top = 72
        Width = 72
        Height = 49
        ItemIndex = 0
        Items.Strings = (
          'Stretch'
          'Tile')
        TabOrder = 1
        OnClick = rgImageModeClick
      end
    end
  end
  object btCancel: TButton
    Left = 24
    Top = 251
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btOK: TButton
    Left = 103
    Top = 251
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object ColorDialog1: TColorDialog
    Left = 4
    Top = 163
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 92
    Top = 203
  end
end
