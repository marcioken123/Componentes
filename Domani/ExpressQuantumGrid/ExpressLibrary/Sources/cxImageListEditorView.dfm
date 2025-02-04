object cxImageListEditorForm: TcxImageListEditorForm
  Left = 327
  Top = 272
  Anchors = [akLeft, akTop, akRight, akBottom]
  AutoScroll = False
  BorderIcons = [biSystemMenu]
  Caption = 'cxImageListEditorForm'
  ClientHeight = 287
  ClientWidth = 550
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btnOk: TButton
    Left = 303
    Top = 250
    Width = 75
    Height = 25
    Action = cxImageListEditor.actOk
    Anchors = [akRight, akBottom]
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 383
    Top = 250
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object btnApply: TButton
    Left = 463
    Top = 250
    Width = 75
    Height = 25
    Action = cxImageListEditor.actApply
    Anchors = [akRight, akBottom]
    TabOrder = 2
  end
  object gbSelectedImage: TGroupBox
    Left = 359
    Top = 7
    Width = 180
    Height = 231
    Anchors = [akTop, akRight, akBottom]
    Caption = 'Selected Image'
    TabOrder = 3
    object pbPreview: TPaintBox
      Left = 10
      Top = 15
      Width = 160
      Height = 160
      Anchors = [akLeft, akTop, akRight]
      OnMouseDown = pbPreviewMouseDown
      OnMouseMove = pbPreviewMouseMove
      OnPaint = pbPreviewPaint
    end
    object lbTransparentColor: TLabel
      Left = 9
      Top = 186
      Width = 87
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Transparent Color:'
    end
    object cbTransparentColor: TComboBox
      Left = 10
      Top = 201
      Width = 161
      Height = 21
      Anchors = [akLeft, akRight, akBottom]
      ItemHeight = 13
      TabOrder = 0
      OnChange = cbTransparentColorChange
      OnExit = cbTransparentColorExit
    end
  end
  object gbImages: TGroupBox
    Left = 12
    Top = 7
    Width = 340
    Height = 231
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Images'
    TabOrder = 4
    object lvImages: TListView
      Left = 10
      Top = 15
      Width = 320
      Height = 178
      Hint = 'Add image'
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <>
      Constraints.MinHeight = 150
      Constraints.MinWidth = 228
      DragMode = dmAutomatic
      HideSelection = False
      IconOptions.AutoArrange = True
      MultiSelect = True
      ReadOnly = True
      PopupMenu = pmCommands
      ShowColumnHeaders = False
      TabOrder = 0
      OnEndDrag = lvImagesEndDrag
      OnDragOver = lvImagesDragOver
      OnKeyDown = lvImagesKeyDown
      OnStartDrag = lvImagesStartDrag
    end
    object pnlToolBarSubstrate: TPanel
      Left = 10
      Top = 200
      Width = 151
      Height = 22
      Anchors = [akLeft, akBottom]
      BevelOuter = bvNone
      TabOrder = 1
      object tbCommands: TToolBar
        Left = 0
        Top = 0
        Width = 151
        Height = 22
        Align = alClient
        Caption = 'tbCommands'
        EdgeBorders = []
        Flat = True
        Images = cxImageListEditor.imglSmall
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object tbbAdd: TToolButton
          Left = 0
          Top = 0
          Action = cxImageListEditor.actAdd
        end
        object tbbReplace: TToolButton
          Left = 23
          Top = 0
          Action = cxImageListEditor.actReplace
        end
        object tbbDelete: TToolButton
          Left = 46
          Top = 0
          Action = cxImageListEditor.actDelete
        end
        object tbbClear: TToolButton
          Left = 69
          Top = 0
          Action = cxImageListEditor.actClear
        end
        object tbbExport: TToolButton
          Left = 92
          Top = 0
          Action = cxImageListEditor.actExport
        end
        object tbbImport: TToolButton
          Left = 115
          Top = 0
          Hint = 'Import images'
          Caption = '&Import'
          DropdownMenu = pmImageLists
          ImageIndex = 5
          OnClick = tbbImportClick
        end
      end
    end
  end
  object pmImageLists: TPopupMenu
    Left = 64
    Top = 40
  end
  object pmCommands: TPopupMenu
    Left = 152
    Top = 40
    object miAdd: TMenuItem
      Action = cxImageListEditor.actAdd
    end
    object miReplace: TMenuItem
      Action = cxImageListEditor.actReplace
    end
    object miDelete: TMenuItem
      Action = cxImageListEditor.actDelete
    end
    object miClear: TMenuItem
      Action = cxImageListEditor.actClear
    end
    object miExport: TMenuItem
      Action = cxImageListEditor.actExport
    end
    object miImport: TMenuItem
      Caption = '&Import'
      Hint = 'Load from another imagelist'
      ImageIndex = 5
    end
  end
end
