object Form1: TForm1
  Left = 141
  Top = 50
  BorderStyle = bsSingle
  Caption = 'CoolComparer'
  ClientHeight = 598
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 89
    Align = alTop
    BevelOuter = bvNone
    Color = clWindow
    TabOrder = 0
    object StaticTextMainLabel: TStaticText
      Left = 16
      Top = 8
      Width = 58
      Height = 20
      Caption = 'Settings'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object StaticTextSubLabel: TStaticText
      Left = 32
      Top = 24
      Width = 633
      Height = 49
      AutoSize = False
      Caption = 'Set up the table...'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 89
    Width = 688
    Height = 490
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel2'
    TabOrder = 1
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 399
      Height = 490
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 399
        Height = 449
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = DataSource1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object ButtonOpen: TButton
        Left = 8
        Top = 456
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = '&Open'
        TabOrder = 1
        OnClick = ButtonOpenClick
      end
      object ButtonSearch: TButton
        Left = 88
        Top = 456
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Search!'
        TabOrder = 2
        OnClick = ButtonSearchClick
        OnEnter = ButtonSearchEnter
      end
      object ProgressBar1: TProgressBar
        Left = 184
        Top = 456
        Width = 209
        Height = 20
        Anchors = [akLeft, akBottom]
        Min = 0
        Max = 100
        TabOrder = 3
      end
    end
    object PageControl: TPageControl
      Left = 399
      Top = 0
      Width = 289
      Height = 490
      ActivePage = TabSettings
      Align = alRight
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Style = tsFlatButtons
      TabOrder = 1
      OnChange = PageControlChange
      object TabSettings: TTabSheet
        Caption = 'S&ettings'
        object LabelFields: TLabel
          Left = 16
          Top = 8
          Width = 33
          Height = 16
          Caption = '&Fields'
          FocusControl = ListBoxFields
        end
        object LabelPriorities: TLabel
          Left = 16
          Top = 144
          Width = 50
          Height = 16
          Caption = '&Priorities'
          FocusControl = ComboBoxPriorities
        end
        object LabelSearchSettings: TLabel
          Left = 16
          Top = 216
          Width = 90
          Height = 16
          Caption = '&Search Settings'
          FocusControl = ListBoxFields
        end
        object SpeedButton1: TSpeedButton
          Left = 192
          Top = 192
          Width = 23
          Height = 22
          Hint = 'Add the field to fields to be searched'
          Caption = '>>'
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton1Click
        end
        object SpeedButton2: TSpeedButton
          Left = 216
          Top = 192
          Width = 23
          Height = 22
          Hint = 'Remove field'
          Caption = '<<'
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton2Click
        end
        object SpeedButton3: TSpeedButton
          Left = 240
          Top = 192
          Width = 23
          Height = 22
          Hint = 'Clier fielda list'
          Caption = 'X'
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton3Click
        end
        object Label4: TLabel
          Left = 24
          Top = 392
          Width = 70
          Height = 16
          Caption = 'Points Avail:'
        end
        object Label5: TLabel
          Left = 24
          Top = 416
          Width = 85
          Height = 16
          Caption = 'Points Enough:'
        end
        object Label6: TLabel
          Left = 208
          Top = 392
          Width = 7
          Height = 16
          Caption = '0'
        end
        object ListBoxFields: TListBox
          Left = 16
          Top = 24
          Width = 249
          Height = 116
          IntegralHeight = True
          ItemHeight = 16
          TabOrder = 0
        end
        object ComboBoxPriorities: TComboBox
          Left = 16
          Top = 160
          Width = 249
          Height = 24
          Style = csDropDownList
          ItemHeight = 16
          TabOrder = 1
        end
        object ListViewFields: TListView
          Left = 16
          Top = 232
          Width = 250
          Height = 145
          Columns = <
            item
              Caption = 'Field'
              Width = 100
            end
            item
              Caption = 'Priority'
              Width = 100
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 2
          ViewStyle = vsReport
        end
        object Edit1: TEdit
          Left = 208
          Top = 416
          Width = 33
          Height = 24
          TabOrder = 3
          Text = '0'
        end
        object UpDown1: TUpDown
          Left = 241
          Top = 416
          Width = 19
          Height = 24
          Associate = Edit1
          Min = 0
          Max = 1000
          Position = 0
          TabOrder = 4
          Wrap = False
        end
      end
      object TabSearch: TTabSheet
        Caption = '&Search'
        ImageIndex = 1
        object LabelFieldsValues: TLabel
          Left = 16
          Top = 8
          Width = 139
          Height = 16
          Caption = 'Sea&rch Fields for Values'
          FocusControl = StringGridSearch
        end
        object StringGridSearch: TStringGrid
          Left = 16
          Top = 24
          Width = 249
          Height = 393
          ColCount = 2
          DefaultRowHeight = 21
          RowCount = 10
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowMoving, goColMoving, goEditing, goAlwaysShowEditor]
          TabOrder = 0
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 579
    Width = 688
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 560
    Top = 88
  end
  object Table1: TTable
    Left = 592
    Top = 88
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.db'
    Filter = 'DB databases|*.db'
    Title = 'Open'
    Left = 528
    Top = 88
  end
  object Comparer: TCoolComparer
    OnProgress = ComparerProgress
    Left = 624
    Top = 88
  end
end
