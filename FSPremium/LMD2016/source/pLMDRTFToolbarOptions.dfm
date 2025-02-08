object ToolbarOptionsForm: TToolbarOptionsForm
  Left = 8
  Top = 8
  BorderStyle = bsToolWindow
  Caption = 'Toolbar options'
  ClientHeight = 369
  ClientWidth = 337
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 321
    Height = 97
    Caption = 'Bar type'
    TabOrder = 0
    object Label1: TLabel
      Left = 187
      Top = 28
      Width = 124
      Height = 51
      AutoSize = False
      Caption = 
        'Checkboxes at category level in TreeView below have no functiona' +
        'lity.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object ToolBarRadioButton: TRadioButton
      Left = 8
      Top = 24
      Width = 137
      Height = 17
      Caption = 'Toolbar'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = ToolBarRadioButtonClick
    end
    object ActionBarRadioButton: TRadioButton
      Left = 8
      Top = 48
      Width = 161
      Height = 17
      Caption = 'ActionBar'
      Enabled = False
      TabOrder = 1
      OnClick = ToolBarRadioButtonClick
    end
    object MenuBarCheckBox: TCheckBox
      Left = 8
      Top = 72
      Width = 145
      Height = 17
      Caption = 'Create menu bar'
      Enabled = False
      TabOrder = 2
    end
  end
  object CancelButton: TButton
    Left = 256
    Top = 336
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object OKButton: TButton
    Left = 176
    Top = 336
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 112
    Width = 321
    Height = 217
    Caption = 'Bar items'
    TabOrder = 3
    object CheckListBox: TListView
      Left = 8
      Top = 16
      Width = 297
      Height = 193
      Checkboxes = True
      Columns = <
        item
          AutoSize = True
        end>
      ReadOnly = True
      RowSelect = True
      ParentShowHint = False
      ShowColumnHeaders = False
      ShowHint = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
end
