object LMDSedKeyBindingsDlg: TLMDSedKeyBindingsDlg
  Left = 368
  Top = 235
  Anchors = [akRight, akBottom]
  Caption = 'LMDSedKeyBindingsDlg'
  ClientHeight = 279
  ClientWidth = 486
  Color = clBtnFace
  Constraints.MinWidth = 490
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 167
    Top = 0
    Height = 279
    Align = alRight
  end
  object trCommands: TTreeView
    Left = 0
    Top = 0
    Width = 167
    Height = 279
    Align = alClient
    HideSelection = False
    HotTrack = True
    Indent = 19
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    OnChange = trCommandsChange
  end
  object Panel1: TPanel
    Left = 170
    Top = 0
    Width = 316
    Height = 279
    Align = alRight
    Constraints.MinHeight = 247
    TabOrder = 1
    DesignSize = (
      316
      279)
    object lbCurrentBinding: TLabel
      Left = 8
      Top = 5
      Width = 99
      Height = 13
      Caption = 'Current key bindings'
    end
    object lbNewBinding: TLabel
      Left = 140
      Top = 5
      Width = 78
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'New key binding'
    end
    object btnOk: TButton
      Left = 140
      Top = 245
      Width = 80
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Ok'
      Default = True
      ModalResult = 1
      TabOrder = 7
      OnClick = btnOkClick
    end
    object btnCancel: TButton
      Left = 227
      Top = 245
      Width = 80
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 8
    end
    object lsBindings: TListBox
      Left = 8
      Top = 24
      Width = 115
      Height = 105
      ItemHeight = 13
      TabOrder = 0
      OnClick = lsBindingsClick
      OnKeyDown = lsBindingsKeyDown
    end
    object btnDeleteBinding: TButton
      Left = 8
      Top = 135
      Width = 115
      Height = 25
      Caption = 'Delete binding'
      TabOrder = 1
      OnClick = btnDeleteBindingClick
    end
    object btnAddBinding: TButton
      Left = 140
      Top = 51
      Width = 80
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Add  binding'
      TabOrder = 4
      OnClick = btnAddBindingClick
    end
    object edCurrentBinding: TEdit
      Left = 140
      Top = 24
      Width = 148
      Height = 21
      TabStop = False
      Anchors = [akTop, akRight]
      TabOrder = 3
      OnKeyDown = edCurrentBindingKeyDown
      OnKeyPress = edCurrentBindingKeyPress
    end
    object btnClearBinding: TButton
      Left = 140
      Top = 80
      Width = 80
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Clear '
      TabOrder = 5
      OnClick = btnClearBindingClick
    end
    object btnResetDefault: TButton
      Left = 8
      Top = 164
      Width = 115
      Height = 25
      Caption = 'Reset to default'
      TabOrder = 2
      OnClick = btnResetDefaultClick
    end
    object btnResetAll: TButton
      Left = 8
      Top = 245
      Width = 115
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Reset all to defaults'
      TabOrder = 6
      OnClick = btnResetAllClick
    end
  end
end
