object LMDTemplateStorageForm: TLMDTemplateStorageForm
  Left = 13
  Top = 13
  BorderStyle = bsDialog
  Caption = 'Stored properties'
  ClientHeight = 397
  ClientWidth = 594
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 360
    Width = 594
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object OkBtn: TButton
      Left = 428
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
      Left = 512
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
    Width = 193
    Height = 360
    Align = alLeft
    HideSelection = False
    Indent = 19
    ReadOnly = True
    SortType = stBoth
    TabOrder = 1
    OnChange = ComponentsTreeChange
  end
  object Panel3: TPanel
    Left = 193
    Top = 0
    Width = 401
    Height = 360
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 65
      Height = 13
      Caption = 'Storage Path:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 52
      Height = 13
      Caption = 'Templates:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Splitter1: TSplitter
      Left = 0
      Top = 0
      Height = 360
    end
    object StoragePathEdit: TEdit
      Left = 88
      Top = 16
      Width = 228
      Height = 21
      BorderStyle = bsNone
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object TLCombo: TComboBox
      Left = 88
      Top = 40
      Width = 305
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnChange = TLComboChange
    end
    object AddBtn: TButton
      Left = 88
      Top = 64
      Width = 75
      Height = 25
      Caption = 'Add'
      TabOrder = 2
      OnClick = AddBtnClick
    end
    object LoadBtn: TButton
      Left = 168
      Top = 64
      Width = 75
      Height = 25
      Caption = 'Load'
      TabOrder = 3
      OnClick = LoadBtnClick
    end
    object BrowseFolderBtn: TButton
      Left = 320
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Browse...'
      TabOrder = 4
      OnClick = BrowseFolderBtnClick
    end
    object DeleteButton: TButton
      Left = 320
      Top = 64
      Width = 75
      Height = 25
      Caption = 'Delete'
      TabOrder = 5
      OnClick = DeleteButtonClick
    end
  end
end
