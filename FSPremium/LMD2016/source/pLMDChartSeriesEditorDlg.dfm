object LMDChartSeriesEditorDlg: TLMDChartSeriesEditorDlg
  Left = 192
  Top = 110
  Width = 560
  Height = 291
  BorderStyle = bsSizeToolWin
  Caption = 'LMD Chart Series Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    552
    257)
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 8
    Top = 230
    Width = 58
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Series name'
  end
  object btOK: TButton
    Left = 467
    Top = 224
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btCancel: TButton
    Left = 379
    Top = 224
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 552
    Height = 217
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 145
      Top = 0
      Height = 217
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 145
      Height = 217
      Align = alLeft
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 96
        Height = 13
        Caption = 'Chart series type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lvSeriesType: TListView
        Left = 3
        Top = 32
        Width = 137
        Height = 174
        Columns = <
          item
            Caption = 'Name'
            Width = 80
          end
          item
            Caption = 'Description'
            Width = 100
          end>
        HideSelection = False
        Items.Data = {
          A90000000500000000000000FFFFFFFFFFFFFFFF00000000000000000B314420
          28582D617869732900000000FFFFFFFFFFFFFFFF00000000000000000C324420
          2858592D617869732900000000FFFFFFFFFFFFFFFF00000000000000000D3344
          202858595A2D617869732900000000FFFFFFFFFFFFFFFF00000000000000000E
          4F484C43202866696E616E63652900000000FFFFFFFFFFFFFFFF000000000000
          000006437573746F6D}
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = lvSeriesTypeClick
      end
    end
    object Panel3: TPanel
      Left = 148
      Top = 0
      Width = 404
      Height = 217
      Align = alClient
      TabOrder = 1
      DesignSize = (
        404
        217)
      object Label2: TLabel
        Left = 8
        Top = 8
        Width = 179
        Height = 13
        Caption = 'Chart series data (chart values)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 314
        Top = 168
        Width = 57
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Rows count'
      end
      object sgData: TStringGrid
        Left = 8
        Top = 32
        Width = 291
        Height = 175
        Anchors = [akLeft, akTop, akRight, akBottom]
        ColCount = 2
        FixedCols = 0
        RowCount = 4
        FixedRows = 3
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 0
      end
      object seRowCount: TLMDShSpinEdit
        Left = 314
        Top = 184
        Width = 81
        Height = 21
        MaxValue = 100000000
        MinValue = 1
        TabOrder = 1
        Value = 1
        OnChange = seRowCountChange
        Anchors = [akTop, akRight]
      end
      object btColOptions: TButton
        Left = 306
        Top = 33
        Width = 89
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Column options...'
        TabOrder = 2
        OnClick = btColOptionsClick
      end
    end
  end
  object edSeriesName: TEdit
    Left = 72
    Top = 225
    Width = 121
    Height = 21
    Anchors = [akLeft, akBottom]
    TabOrder = 3
    Text = 'edSeriesName'
  end
end
