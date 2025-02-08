object LMDCustImgListSelectDlg: TLMDCustImgListSelectDlg
  Left = 226
  Top = 147
  BorderStyle = bsDialog
  Caption = 'Select Image...'
  ClientHeight = 335
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 230
    Top = 10
    Width = 46
    Height = 14
    Caption = '&ListIndex:'
  end
  object LMDSimplePanel2: TPanel
    Left = 229
    Top = 32
    Width = 260
    Height = 298
    BorderWidth = 4
    TabOrder = 0
    object lv: TListBox
      Left = 5
      Top = 22
      Width = 250
      Height = 271
      Style = lbOwnerDrawFixed
      Align = alClient
      ItemHeight = 40
      TabOrder = 0
      OnDblClick = lbDblClick
      OnDrawItem = lbDrawItem
    end
    object Header: THeaderControl
      Left = 5
      Top = 5
      Width = 250
      Height = 17
      Enabled = False
      Sections = <
        item
          ImageIndex = -1
          Width = 38
        end
        item
          ImageIndex = -1
          Width = 38
        end
        item
          ImageIndex = -1
          Width = 174
        end>
    end
  end
  object cmb: TComboBox
    Left = 290
    Top = 5
    Width = 198
    Height = 22
    Style = csDropDownList
    ItemHeight = 14
    TabOrder = 1
    OnChange = cmbChange
  end
  object LMDSimplePanel1: TPanel
    Left = 4
    Top = 32
    Width = 220
    Height = 298
    BorderWidth = 4
    TabOrder = 2
    object ll: TListView
      Left = 4
      Top = 5
      Width = 210
      Height = 288
      Columns = <
        item
          Caption = 'Type'
          Width = 36
        end
        item
          Caption = 'N'
          Width = 30
        end
        item
          Caption = 'Name of ImageList'
          Width = 140
        end>
      ColumnClick = False
      GridLines = True
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = llClick
    end
  end
  object btnOk: TButton
    Left = 8
    Top = 4
    Width = 60
    Height = 24
    Caption = 'OK'
    Default = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 72
    Top = 4
    Width = 60
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 4
  end
  object Button2: TButton
    Left = 144
    Top = 4
    Width = 60
    Height = 24
    Caption = 'Clear'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = Button2Click
  end
  object ImageList1: TImageList
    Height = 64
    Width = 64
    Left = 348
    Top = 226
  end
end
