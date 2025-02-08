object LMDOSPropForm: TLMDOSPropForm
  Left = 352
  Top = 230
  BorderStyle = bsDialog
  Caption = 'Stored properties'
  ClientHeight = 397
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 360
    Width = 635
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object OkBtn: TButton
      Left = 212
      Top = 8
      Width = 75
      Height = 25
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = OkBtnClick
    end
    object CancelBtn: TButton
      Left = 296
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object ComponentsTree: TTreeView
    Left = 0
    Top = 0
    Width = 267
    Height = 360
    Align = alLeft
    HideSelection = False
    HotTrack = True
    Indent = 19
    ReadOnly = True
    RowSelect = True
    SortType = stBoth
    TabOrder = 1
    OnChange = ComponentsTreeChange
    OnDblClick = ComponentsTreeDblClick
  end
  object Panel2: TPanel
    Left = 267
    Top = 0
    Width = 56
    Height = 360
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    object ToBtn: TSpeedButton
      Left = 12
      Top = 32
      Width = 33
      Height = 33
      Caption = '>'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = ToBtnClick
    end
    object FromBtn: TSpeedButton
      Left = 12
      Top = 72
      Width = 33
      Height = 33
      Caption = '<'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = FromBtnClick
    end
    object ExclAdd: TSpeedButton
      Left = 12
      Top = 236
      Width = 33
      Height = 33
      Caption = '>'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = ExclAddClick
    end
    object ExclDel: TSpeedButton
      Left = 12
      Top = 276
      Width = 33
      Height = 33
      Caption = '<'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = ExclDelClick
    end
    object AllDelBtn: TSpeedButton
      Left = 12
      Top = 113
      Width = 33
      Height = 33
      Caption = '<<'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = AllDelBtnClick
    end
  end
  object Panel3: TPanel
    Left = 323
    Top = 0
    Width = 312
    Height = 360
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object Label1: TLabel
      Left = 76
      Top = 172
      Width = 161
      Height = 20
      Caption = 'Excluded Properties'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object PropListView: TListView
      Left = 0
      Top = 0
      Width = 312
      Height = 165
      Align = alTop
      Columns = <
        item
          Caption = 'Component'
          Width = 100
        end
        item
          Caption = 'Property'
          Width = 180
        end>
      ColumnClick = False
      HideSelection = False
      HotTrack = True
      ReadOnly = True
      RowSelect = True
      SortType = stText
      TabOrder = 0
      ViewStyle = vsReport
      OnSelectItem = PropListViewSelectItem
    end
    object ExcludedPropertiesList: TListView
      Left = 0
      Top = 200
      Width = 312
      Height = 160
      Columns = <
        item
          Caption = 'Property'
          Width = 180
        end>
      ColumnClick = False
      HideSelection = False
      HotTrack = True
      ReadOnly = True
      RowSelect = True
      SortType = stText
      TabOrder = 1
      ViewStyle = vsReport
      OnSelectItem = PropListViewSelectItem
    end
  end
end
