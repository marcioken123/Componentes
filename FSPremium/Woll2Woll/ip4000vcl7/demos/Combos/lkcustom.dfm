object CustomComboForm: TCustomComboForm
  Left = 318
  Top = 188
  Width = 355
  Height = 365
  Caption = 'Custom lookupcombo searching'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 19
    Top = 16
    Width = 18
    Height = 13
    Caption = 'Zip:'
  end
  object Label2: TLabel
    Left = 19
    Top = 48
    Width = 20
    Height = 13
    Caption = 'City:'
  end
  object wwDBRichEdit1: TwwDBRichEdit
    Left = 16
    Top = 120
    Width = 313
    Height = 201
    AutoURLDetect = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    PrintJobName = 'Delphi 5'
    TabOrder = 0
    EditorCaption = 'Edit Rich Text'
    EditorPosition.Left = 0
    EditorPosition.Top = 0
    EditorPosition.Width = 0
    EditorPosition.Height = 0
    MeasurementUnits = muInches
    PrintMargins.Top = 1
    PrintMargins.Bottom = 1
    PrintMargins.Left = 1
    PrintMargins.Right = 1
    RichEditVersion = 2
    Data = {
      F20100007B5C727466315C616E73695C616E7369637067313235325C64656666
      305C6465666C616E67313033337B5C666F6E7474626C7B5C66305C666E696C5C
      6663686172736574302054696D6573204E657720526F6D616E3B7D7D0D0A5C76
      6965776B696E64345C7563315C706172645C66305C6673323020496E666F506F
      776572203330303020616C6C6F777320796F7520746F20706572666F726D2074
      686520696E6372656D656E74616C20736561726368696E672072656D6F74656C
      7920696E7374656164206F66206C6F63616C6C792E202054686973207369676E
      69666963616E746C7920696D70726F7665732074686520706572666F726D616E
      6365206F66206C6F6F6B7570636F6D626F2773207768656E2074686579206172
      6520617474616368656420746F206120717565727920646174617365742E2020
      5768656E20612063686172616374657220697320747970656420696E746F2074
      686520636F6E74726F6C2C20796F752063616E20637573746F6D697A65207468
      6520616374696F6E20746861742074616B657320706C6163652E20205C706172
      0D0A5C7061720D0A496E207468652061626F76652064656D6F2C207374617274
      20747970696E6720696E2061206E756D62657220696E746F20746865207A6970
      2D636F646520636F6D626F2E5C7061720D0A7D0D0A00}
  end
  object wwDBNavigator1: TwwDBNavigator
    Left = 16
    Top = 80
    Width = 225
    Height = 25
    DataSource = DataSource2
    RepeatInterval.InitialDelay = 500
    RepeatInterval.Interval = 100
    object wwDBNavigator1First: TwwNavButton
      Left = 0
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Move to first record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1First'
      Enabled = False
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 0
      Style = nbsFirst
    end
    object wwDBNavigator1Prior: TwwNavButton
      Left = 25
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Move to prior record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Prior'
      Enabled = False
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 1
      Style = nbsPrior
    end
    object wwDBNavigator1Next: TwwNavButton
      Left = 50
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Move to next record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Next'
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 2
      Style = nbsNext
    end
    object wwDBNavigator1Last: TwwNavButton
      Left = 75
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Move to last record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Last'
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 3
      Style = nbsLast
    end
    object wwDBNavigator1Insert: TwwNavButton
      Left = 100
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Insert new record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Insert'
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 4
      Style = nbsInsert
    end
    object wwDBNavigator1Delete: TwwNavButton
      Left = 125
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Delete current record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Delete'
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 5
      Style = nbsDelete
    end
    object wwDBNavigator1Edit: TwwNavButton
      Left = 150
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Edit current record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Edit'
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 6
      Style = nbsEdit
    end
    object wwDBNavigator1Post: TwwNavButton
      Left = 175
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Post changes of current record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Post'
      Enabled = False
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 7
      Style = nbsPost
    end
    object wwDBNavigator1Cancel: TwwNavButton
      Left = 200
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Cancel changes made to current record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Cancel'
      Enabled = False
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 8
      Style = nbsCancel
    end
  end
  object wwDBLookupCombo2: TwwDBLookupCombo
    Left = 48
    Top = 44
    Width = 209
    Height = 21
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'CITY'#9'25'#9'CITY'#9'F'
      'ZIP'#9'10'#9'ZIP'#9'F'
      'STATE'#9'2'#9'STATE'#9'F')
    DataField = 'Zip'
    DataSource = DataSource2
    LookupTable = Query2
    LookupField = 'ZIP'
    Options = [loFixedDropDownHeight]
    TabOrder = 2
    AutoDropDown = False
    ShowButton = True
    UseTFields = False
    AllowClearKey = False
    ShowMatchText = True
    OnPerformCustomSearch = wwDBLookupCombo2PerformCustomSearch
  end
  object wwDBLookupCombo1: TwwDBLookupCombo
    Left = 48
    Top = 13
    Width = 209
    Height = 21
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'ZIP'#9'10'#9'ZIP'#9'F'
      'CITY'#9'25'#9'CITY'#9'F'
      'STATE'#9'2'#9'STATE'#9'F')
    DataField = 'Zip'
    DataSource = DataSource2
    LookupTable = Query1
    LookupField = 'ZIP'
    Options = [loFixedDropDownHeight]
    TabOrder = 3
    AutoDropDown = False
    ShowButton = True
    UseTFields = False
    AllowClearKey = False
    ShowMatchText = True
    OnPerformCustomSearch = wwDBLookupCombo1PerformCustomSearch
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 32
    Top = 296
  end
  object Query1: TQuery
    DatabaseName = 'InfoDemo5'
    SQL.Strings = (
      'select * from ip4zip')
    Left = 64
    Top = 296
    object Query1ZIP: TStringField
      FieldName = 'ZIP'
      Origin = 'INFODEMO5."ip4zip.DB".ZIP'
      Size = 10
    end
    object Query1CITY: TStringField
      FieldName = 'CITY'
      Origin = 'INFODEMO5."ip4zip.DB".CITY'
      Size = 25
    end
    object Query1STATE: TStringField
      FieldName = 'STATE'
      Origin = 'INFODEMO5."ip4zip.DB".STATE'
      Size = 2
    end
  end
  object DataSource2: TDataSource
    DataSet = Table1
    Left = 32
    Top = 264
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'InfoDemo5'
    TableName = 'Ip4cust.DB'
    Left = 64
    Top = 264
  end
  object Query2: TQuery
    DatabaseName = 'InfoDemo5'
    SQL.Strings = (
      'select * from ip4zip')
    Left = 144
    Top = 296
    object Query2ZIP: TStringField
      FieldName = 'ZIP'
      Origin = 'INFODEMO5."ip4zip.DB".ZIP'
      Size = 10
    end
    object Query2CITY: TStringField
      FieldName = 'CITY'
      Origin = 'INFODEMO5."ip4zip.DB".CITY'
      Size = 25
    end
    object Query2STATE: TStringField
      FieldName = 'STATE'
      Origin = 'INFODEMO5."ip4zip.DB".STATE'
      Size = 2
    end
  end
  object DataSource3: TDataSource
    DataSet = Query2
    Left = 112
    Top = 296
  end
end
