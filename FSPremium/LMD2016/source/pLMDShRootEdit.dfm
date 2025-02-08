object RootPathEditDlg: TRootPathEditDlg
  Left = 395
  Top = 378
  BorderStyle = bsDialog
  Caption = 'Select Root Path'
  ClientHeight = 186
  ClientWidth = 465
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 300
    Top = 153
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 382
    Top = 153
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 6
    Top = 8
    Width = 450
    Height = 61
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    object cbFolderType: TComboBox
      Left = 12
      Top = 26
      Width = 432
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object rbUseFolder: TRadioButton
    Left = 16
    Top = 8
    Width = 155
    Height = 21
    Caption = 'Use Standard &Folder'
    TabOrder = 2
    OnClick = rbUseFolderClick
  end
  object GroupBox2: TGroupBox
    Left = 6
    Top = 76
    Width = 450
    Height = 70
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
    object ePath: TEdit
      Left = 12
      Top = 25
      Width = 400
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'C:\'
    end
    object rbUsePath: TRadioButton
      Left = 10
      Top = 0
      Width = 90
      Height = 21
      Caption = 'Use &Path'
      TabOrder = 1
      OnClick = rbUsePathClick
    end
    object btnBrowse: TButton
      Left = 417
      Top = 24
      Width = 23
      Height = 23
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 2
      OnClick = btnBrowseClick
    end
  end
end
