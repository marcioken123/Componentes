object LargeGridEditForm: TLargeGridEditForm
  Left = 182
  Top = 172
  Width = 548
  Height = 178
  Caption = 'Controls larger than cells during editing'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object wwDBGrid1: TwwDBGrid
    Left = 0
    Top = 0
    Width = 540
    Height = 144
    DisableThemes = False
    Selected.Strings = (
      'FIRST_NAME'#9'20'#9'First Name'
      'LAST_NAME'#9'20'#9'Last Name'
      'RINTERESTS'#9'10'#9'Information'
      'ADDRESS_1'#9'20'#9'Address'#9'F'
      'ACCT_NBR'#9'10'#9'Acct No.'
      'CITY'#9'20'#9'CITY'
      'STATE'#9'2'#9'STATE'
      'ZIP'#9'5'#9'ZIP'
      'TELEPHONE'#9'12'#9'TELEPHONE'
      'DATE_OPEN'#9'10'#9'DATE_OPEN'
      'SS_NUMBER'#9'10'#9'SS_NUMBER'
      'PICTURE'#9'15'#9'PICTURE'
      'BIRTH_DATE'#9'10'#9'BIRTH_DATE'
      'RISK_LEVEL'#9'8'#9'RISK_LEVEL'
      'OCCUPATION'#9'20'#9'OCCUPATION'
      'OBJECTIVES'#9'10'#9'OBJECTIVES'
      'INTERESTS'#9'120'#9'INTERESTS'
      'IMAGE'#9'10'#9'IMAGE'
      'SEX'#9'6'#9'SEX'
      'EDUCATION'#9'10'#9'EDUCATION'
      'CREDRATING'#9'1'#9'CREDRATING'
      'MARRIED'#9'5'#9'MARRIED'
      'PAYMETHOD'#9'10'#9'PAYMETHOD'
      'BALANCEDUE'#9'10'#9'BALANCEDUE')
    IniAttributes.FileName = 'delphi32.ini'
    IniAttributes.SectionName = 'RecordViewDemoFormwwDBGrid1'
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    Color = clSkyBlue
    DataSource = wwDataSource1
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    object wwDBGrid1IButton: TwwIButton
      Left = 0
      Top = 0
      Width = 25
      Height = 20
      AllowAllUp = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333FFF333333333333000333333333
        3333777FFF3FFFFF33330B000300000333337F777F777773F333000E00BFBFB0
        3333777F773333F7F333000E0BFBF0003333777F7F3337773F33000E0FBFBFBF
        0333777F7F3333FF7FFF000E0BFBF0000003777F7F3337777773000E0FBFBFBF
        BFB0777F7F33FFFFFFF7000E0BF000000003777F7FF777777773000000BFB033
        33337777773FF733333333333300033333333333337773333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
    end
  end
  object wwDBRichEdit1: TwwDBRichEdit
    Left = 184
    Top = 64
    Width = 64
    Height = 16
    AutoURLDetect = False
    PrintJobName = 'Delphi 7'
    TabOrder = 1
    OnEnter = wwDBRichEdit1Enter
    EditorCaption = 'Edit Rich Text'
    EditorPosition.Left = 0
    EditorPosition.Top = 0
    EditorPosition.Width = 0
    EditorPosition.Height = 0
    MeasurementUnits = muInches
    PrintMargins.Top = 1.000000000000000000
    PrintMargins.Bottom = 1.000000000000000000
    PrintMargins.Left = 1.000000000000000000
    PrintMargins.Right = 1.000000000000000000
    RichEditVersion = 2
    Data = {
      BD0000007B5C727466315C6662696469735C616E73695C616E73696370673132
      35355C64656666305C6465666C616E67313033377B5C666F6E7474626C7B5C66
      305C666E696C204D532053616E732053657269663B7D7B5C66315C666E696C5C
      6663686172736574313737204D532053616E732053657269663B7D7D0D0A5C76
      6965776B696E64345C7563315C706172645C6C74727061725C66305C66733136
      20777744425269636845646974315C66315C72746C63685C7061720D0A7D0D0A
      00}
  end
  object wwDBEdit1: TwwDBEdit
    Left = 176
    Top = 96
    Width = 121
    Height = 21
    DisableThemes = False
    TabOrder = 2
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
    OnEnter = wwDBEdit1Enter
  end
  object wwDataSource1: TwwDataSource
    DataSet = wwTable1
    Left = 80
    Top = 64
  end
  object wwTable1: TwwTable
    Active = True
    DatabaseName = 'InfoDemo5'
    Filtered = True
    TableName = 'clients.DBF'
    ControlType.Strings = (
      'RINTERESTS;RichEdit;wwDBRichEdit1;T'
      'ADDRESS_1;CustomEdit;wwDBEdit1;F')
    PictureMasks.Strings = (
      'Buyer'#9'{Yes,No}'#9'T'#9'T')
    SyncSQLByRange = True
    NarrowSearch = False
    ValidateWithMask = True
    Left = 112
    Top = 64
  end
end
