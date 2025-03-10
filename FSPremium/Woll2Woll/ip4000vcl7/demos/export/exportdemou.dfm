object ExportForm: TExportForm
  Left = 208
  Top = 141
  Width = 592
  Height = 459
  Caption = 'ExportForm'
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
  object wwDBGrid1: TwwDBGrid
    Left = 0
    Top = 201
    Width = 584
    Height = 231
    ControlType.Strings = (
      'RichEdit;RichEdit;;F'
      'Logical;CheckBox;True;False'
      'Company Name;URL-Link;Company Name'
      'Payment Method;CustomEdit;wwRadioGroup2;F')
    Selected.Strings = (
      'Customer No'#9'7'#9'Customer~No'#9'F'
      'First'#9'7'#9'First'#9'F'#9'Customer Name'
      'Last'#9'7'#9'Last'#9'F'#9'Customer Name'
      'Invoice No'#9'6'#9'Invoice~No'#9'F'
      'Payment Method'#9'25'#9'Payment Method'#9'F'
      'Balance Due'#9'9'#9'Balance~Due'#9'F'
      'Purchase Date'#9'10'#9'Purchase Date'#9'F'
      'Total Invoice'#9'13'#9'Total Invoice'#9'F')
    MemoAttributes = [mSizeable, mWordWrap, mGridShow]
    IniAttributes.Delimiter = ';;'
    ExportOptions.ExportType = wwgetHTML
    ExportOptions.FileName = 'wwexportdemo.html'
    ExportOptions.HTMLBorderWidth = 4
    ExportOptions.Options = [esoShowHeader, esoShowFooter, esoDynamicColors, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
    ExportOptions.OutputWidthinTwips = 11520
    ExportOptions.TitleName = 'This is an example of an exported grid from Delphi saved as HTML'
    TitleColor = clNavy
    FixedCols = 0
    ShowHorzScrollBar = True
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    Align = alClient
    Color = 13739646
    DataSource = DataSource2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MultiSelectOptions = [msoShiftSelect]
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgFooter3DCells]
    ParentFont = False
    RowHeightPercent = 200
    TabOrder = 1
    TitleAlignment = taCenter
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWhite
    TitleFont.Height = -11
    TitleFont.Name = 'Times New Roman'
    TitleFont.Style = []
    TitleLines = 2
    TitleButtons = False
    UseTFields = False
    OnCalcCellColors = wwDBGrid1CalcCellColors
    OnCalcTitleAttributes = wwDBGrid1CalcTitleAttributes
    IndicatorIconColor = clYellow
    OnUpdateFooter = wwDBGrid1UpdateFooter
    FooterColor = clNavy
    FooterCellColor = clYellow
    FooterHeight = 23
    PadColumnStyle = pcsPlain
    PaintOptions.BackgroundDrawStyle = bdsStretch
    PaintOptions.AlternatingRowRegions = [arrDataColumns, arrActiveDataColumn]
    PaintOptions.AlternatingRowColor = clInfoBk
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 584
    Height = 201
    Align = alTop
    Caption = '`'
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 200
      Height = 199
      Align = alLeft
      BevelInner = bvLowered
      TabOrder = 0
      object BitBtn1: TBitBtn
        Left = 4
        Top = 4
        Width = 189
        Height = 25
        Hint = 
          'This export type preserves colors, fonts, and has many other'#13#10'en' +
          'hancements.  See Additional HTML Options groupbox on the right.'
        Caption = 'Export To HTML'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = BitBtn1Click
      end
      object BitBtn3: TBitBtn
        Left = 4
        Top = 29
        Width = 189
        Height = 25
        Hint = 
          'CSV is an excellent format that many spreadsheets'#13#10'and databases' +
          ' accept for importing.'
        Caption = 'Export To CSV (Comma Delimited)'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = BitBtn3Click
      end
      object BitBtn2: TBitBtn
        Left = 4
        Top = 54
        Width = 189
        Height = 25
        Hint = 
          'This export type is useful for viewing the text in a columnar fa' +
          'shion'#13#10'with padded spaces based on display width of the fields.'
        Caption = 'Export To Column Formatted Text'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = BitBtn2Click
      end
      object BitBtn4: TBitBtn
        Left = 4
        Top = 104
        Width = 189
        Height = 25
        Hint = 
          'Click here to export the grid'#39's data to a tab-delimited text fil' +
          'e.'#13#10'When saving to clipboard this is an excellent format for exc' +
          'el or'#13#10'other spreadsheet programs.'
        Caption = 'Export Tabbed Text'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = BitBtn4Click
      end
      object BitBtn5: TBitBtn
        Left = 4
        Top = 79
        Width = 189
        Height = 25
        Hint = 
          'Exporting to SYLK or SLK file for excel.'#13#10'This preserves formato' +
          'f fonts and colwidths.'
        Caption = 'Export to SYLK'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = BitBtn5Click
      end
      object wwRadioGroup2: TwwRadioGroup
        Left = 16
        Top = 152
        Width = 154
        Height = 32
        ShowBorder = False
        ShowGroupCaption = False
        Caption = 'wwRadioGroup2'
        Columns = 2
        Items.Strings = (
          'Visa'
          'MasterCard'
          'Discover'
          'AmEx')
        TabOrder = 5
        Values.Strings = (
          '0'
          '1'
          '2'
          '3')
      end
    end
    object Panel3: TPanel
      Left = 201
      Top = 1
      Width = 382
      Height = 199
      Align = alClient
      BevelInner = bvLowered
      TabOrder = 1
      object Label1: TLabel
        Left = 8
        Top = 120
        Width = 179
        Height = 13
        Caption = 'Desired Width in Inches (HTML Only):'
      end
      object GroupBox1: TGroupBox
        Left = 168
        Top = 5
        Width = 206
        Height = 108
        Caption = 'Additional HTML Options '
        TabOrder = 1
        object BestColumnFitCB: TwwCheckBox
          Left = 8
          Top = 15
          Width = 192
          Height = 18
          AlwaysTransparent = False
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          Frame.MouseEnterSameAsFocus = True
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          ShowFocusRect = False
          NullAndBlankState = cbUnchecked
          Caption = 'Best &Column Fit'
          Color = clBtnFace
          ParentColor = False
          TabOrder = 0
        end
        object ShowCheckboxCB: TwwCheckBox
          Left = 8
          Top = 33
          Width = 192
          Height = 18
          AlwaysTransparent = False
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          Frame.MouseEnterSameAsFocus = True
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          ShowFocusRect = False
          NullAndBlankState = cbUnchecked
          Caption = 'Show Checkbo&xes'
          Color = clBtnFace
          ParentColor = False
          TabOrder = 1
        end
        object ShowURLCB: TwwCheckBox
          Left = 8
          Top = 51
          Width = 192
          Height = 18
          AlwaysTransparent = False
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          Frame.MouseEnterSameAsFocus = True
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          ShowFocusRect = False
          NullAndBlankState = cbUnchecked
          Caption = 'Show &URL'
          Checked = True
          Color = clBtnFace
          ParentColor = False
          State = cbChecked
          TabOrder = 2
        end
        object ShowColorsCB: TwwCheckBox
          Left = 8
          Top = 69
          Width = 192
          Height = 18
          AlwaysTransparent = False
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          Frame.MouseEnterSameAsFocus = True
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          ShowFocusRect = False
          NullAndBlankState = cbUnchecked
          Caption = '&Show Calculated Colors'
          Checked = True
          Color = clBtnFace
          ParentColor = False
          State = cbChecked
          TabOrder = 3
        end
        object AlternatingCB: TwwCheckBox
          Left = 8
          Top = 88
          Width = 192
          Height = 18
          AlwaysTransparent = False
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          Frame.MouseEnterSameAsFocus = True
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          ShowFocusRect = False
          NullAndBlankState = cbUnchecked
          Caption = 'Show &Alternating Row Colors'
          Checked = True
          Color = clBtnFace
          ParentColor = False
          State = cbChecked
          TabOrder = 4
        end
      end
      object GroupBox2: TGroupBox
        Left = 4
        Top = 5
        Width = 161
        Height = 108
        Caption = 'Standard Export Options'
        TabOrder = 0
        object ExportSelectedCB: TwwCheckBox
          Left = 5
          Top = 87
          Width = 150
          Height = 18
          AlwaysTransparent = False
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          Frame.MouseEnterSameAsFocus = True
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          ShowFocusRect = False
          NullAndBlankState = cbUnchecked
          Caption = '&Export Selected Records'
          Color = clBtnFace
          ParentColor = False
          TabOrder = 4
        end
        object MultiselectCB: TwwCheckBox
          Left = 5
          Top = 69
          Width = 150
          Height = 18
          AlwaysTransparent = False
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          Frame.MouseEnterSameAsFocus = True
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          ShowFocusRect = False
          NullAndBlankState = cbUnchecked
          Caption = 'Enable &MultiSelection'
          Color = clBtnFace
          ParentColor = False
          TabOrder = 3
          OnClick = MultiselectCBClick
        end
        object ShowRecCB: TwwCheckBox
          Left = 5
          Top = 51
          Width = 150
          Height = 18
          AlwaysTransparent = False
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          Frame.MouseEnterSameAsFocus = True
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          ShowFocusRect = False
          NullAndBlankState = cbUnchecked
          Caption = 'Show &RecNo'
          Checked = True
          Color = clBtnFace
          ParentColor = False
          State = cbChecked
          TabOrder = 2
        end
        object ShowHeaderCB: TwwCheckBox
          Left = 5
          Top = 33
          Width = 150
          Height = 18
          AlwaysTransparent = False
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          Frame.MouseEnterSameAsFocus = True
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          ShowFocusRect = False
          NullAndBlankState = cbUnchecked
          Caption = 'Show &Header'
          Checked = True
          Color = clBtnFace
          ParentColor = False
          State = cbChecked
          TabOrder = 1
        end
        object ShowTitleCB: TwwCheckBox
          Left = 5
          Top = 14
          Width = 150
          Height = 18
          AlwaysTransparent = False
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          Frame.MouseEnterSameAsFocus = True
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          ShowFocusRect = False
          NullAndBlankState = cbUnchecked
          Caption = 'Show &Title'
          Checked = True
          Color = clBtnFace
          ParentColor = False
          State = cbChecked
          TabOrder = 0
        end
      end
      object wwDBEdit1: TwwDBEdit
        Left = 192
        Top = 118
        Width = 181
        Height = 19
        BorderStyle = bsNone
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusStyle = efsFrameSunken
        Frame.MouseEnterSameAsFocus = True
        Picture.PictureMaskFromDataSet = False
        Picture.PictureMask = '{0,1[0,1,2,3,4,5,6],2,3,4,5,6,7,8,9}'
        TabOrder = 2
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwRadioGroup1: TwwRadioGroup
        Left = 8
        Top = 152
        Width = 361
        Height = 39
        Frame.Enabled = True
        Frame.NonFocusBorders = []
        Frame.FocusStyle = efsFrameSunken
        Frame.MouseEnterSameAsFocus = True
        ButtonFrame.Enabled = True
        ButtonFrame.FocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
        ButtonFrame.FocusStyle = efsFrameSunken
        ButtonFrame.MouseEnterSameAsFocus = True
        Images = macgreenImageList
        GlyphImages = ImageList1
        Caption = 'Export Destination'
        Columns = 2
        Items.Strings = (
          'To Clipboard'
          'To File')
        TabOrder = 3
        Values.Strings = (
          '0'
          '1')
      end
    end
  end
  object wwDBComboBox1: TwwDBComboBox
    Left = 160
    Top = 160
    Width = 33
    Height = 21
    ShowButton = True
    Style = csDropDown
    MapList = True
    AllowClearKey = False
    DropDownCount = 8
    ItemHeight = 0
    Items.Strings = (
      'Visa'#9'0'
      'MasterCard'#9'1'
      'Discover'#9'2'
      'American Express'#9'3')
    Sorted = False
    TabOrder = 2
    UnboundDataType = wwDefault
    Visible = False
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 512
    Top = 16
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'InfoDemo5'
    TableName = 'Ip4cust.DB'
    Left = 544
    Top = 16
    object Table1CustomerNo: TIntegerField
      FieldName = 'Customer No'
    end
    object Table1Buyer: TStringField
      FieldName = 'Buyer'
      Size = 3
    end
    object Table1CompanyName: TStringField
      FieldName = 'Company Name'
      Size = 40
    end
    object Table1FirstName: TStringField
      FieldName = 'First Name'
      Size = 25
    end
    object Table1LastName: TStringField
      FieldName = 'Last Name'
      Size = 25
    end
    object Table1Street: TStringField
      FieldName = 'Street'
      Size = 60
    end
    object Table1City: TStringField
      FieldName = 'City'
      Size = 25
    end
    object Table1State: TStringField
      FieldName = 'State'
      Size = 25
    end
    object Table1Zip: TStringField
      FieldName = 'Zip'
      Size = 10
    end
    object Table1FirstContactDate: TDateField
      FieldName = 'First Contact Date'
    end
    object Table1PhoneNumber: TStringField
      FieldName = 'Phone Number'
    end
    object Table1Information: TMemoField
      FieldName = 'Information'
      BlobType = ftMemo
      Size = 80
    end
    object Table1RichEdit: TBlobField
      FieldName = 'RichEdit'
      Size = 80
    end
    object Table1RequestedDemo: TStringField
      FieldName = 'Requested Demo'
      Size = 3
    end
    object Table1Logical: TBooleanField
      FieldName = 'Logical'
    end
  end
  object ImageList1: TImageList
    Left = 49
    Top = 145
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001001000000000000008
      0000000000000000000000000000000000000000000000000000000000000000
      E07FEF3DFF7FFF7FFF7FFF7FFF7FE07F00000000000000000000000000000000
      000000000000EF3D0000EF3DEF3D0000000000000000EF3D0000EF3DEF3D0000
      0000FF7FFF7FFF7FFF7FFF7FFF7F0000E07FEF3DFF7FFF7FFF7FFF7FFF7FE07F
      00000000FF7F00000000FF7F0000000000000000000000000000000000000000
      E07FEF3DFF7FFF7FFF7FFF7FFF7FE07F00000000000000000000000000000000
      000000000000F75E0000F75EF75E0000000000000000F75E0000F75EF75E0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      E07FEF3DFF7FFF7FFF7FFF7FFF7FE07F00000000000000000000000000000000
      000000000000F75EF75EF75EF75E00000000FF7FFF7FFF7FFF7F0000FF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F007C007C007C007C007C007C007CFF7FFF7FFF7F
      FF7F000000000000000000000000000000000000000000000000000000000000
      E07FEF3DFF7FFF7FFF7FFF7FFF7FE07F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF7FFF7FFF7FFF7FFF7FFF7F0000E07FEF3DFF7FFF7FFF7FFF7FFF7FE07F
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EF3DEF3D00000000EF3D00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EF1EEF1E0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7F000000000000EF3DEF3DE07F00000000FF7FFF7FFF7FFF7FFF7FFF7F
      FF7F0000FF7FFF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7F0000FF7FFF7F
      FF7FFF7F0000FF7FFF7F0000FF7FFF7F007C007C007CFF7FFF7FFF7FFF7FFF7F
      FF7F000000000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7F000000000000EF3DE07FE07F00000000FF7FFF7FFF7FFF7FFF7FFF7F
      FF7F0000FF7FFF7FFF7FFF7FFF7FFF7F00000000FF7FFF7FFF7FFF7FFF7FFF7F
      00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F000000000000EF3DE07FE07F
      000000000000CB230474242801004B688F5F0000FF7F00000000FF7F00000000
      0000FF7F000000000000007C00000000EF3D0000FF7F00000000FF7F00000000
      F75E00001F001F001F00007C1F001F00000000001F001F001F00007C1F001F00
      0000EF1EEF1EEF1EEF1EEF1EEF1E0700FE3D0700000007000000F61E0000F61E
      0000EF3C003C071E003CEF3CEF1EEF1EEF1E0000FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7F00000000007C007C007C000000000000FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7F00000000007C007C007C00000000FF7FFF7FFF7FFF7F0000FF7FFF7F
      FF7FFF7F00000000FF7F007C007C007C007C007CFF7FFF7FFF7FFF7FFF7FFF7F
      FF7F4B220404C9034B220406C9228045E3410000FF7F0000000000000000FF7F
      0000FF7F0000007C007C007C007C007C00000000FF7F0000000000000000FF7F
      0000FF7F0000007C007C007C007C007C0000FF7F0000007C007C007C007C007C
      FF7F0000FF7F0000000000000000FF7F0000FF7F0000007C007C007C007C007C
      FF7F4362F045E945FA45F019FB45874404120000FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7F007C007C007C007C007C007C007C0000FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7F007C007C007C007C007C007C007CFF7F007C007C007C007C007C007C
      007CFF3FFF3FFF3FFF3FFF3FFF3FFF3F00000000003E003E003E000000000000
      0000000000000000000000000000000000000000FF7F00000000FF7F00000000
      0000000000000000007C007C007C000000000000FF7F00000000FF7F00000000
      0000000000000000007C007C007C00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FAD7F4B7D4B787623210835138F5F27040000FF7FFF7FFF7FFF7F0000FF7F
      FF7F000000000000007C007C007C000000000000FF7FFF7FFF7FFF7F0000FF7F
      FF7F000000000000007C007C007C000000000000FF7FFF7F007C007C007CFF7F
      FF7F0000FF7FFF7FFF7FFF7F0000FF7FFF7F0000FF7FFF7F007C007C007CFF7F
      FF7F320C6B0CA6415B05010000003407CB690000FF7F0000F75EFF7F0000FF7F
      000000000000EF3D007C007C007C000000000000FF7F0000F75EFF7F0000FF7F
      000000000000EF3D007C007C007C00000000FF7FFF7FEF3D007C007C007CFF7F
      FF7F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF7FFF7FFF7FFF7F00000000
      0000007C007C007C007C007C0000000000000000FF7FFF7FFF7FFF7F00000000
      0000007C007C007C007C007C000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FCB094B63E86DE97FFF2FBE2D630000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000210000022C001E10000000000000
      0000000000000000000000000000FF7FFF7FFF7F0000EE14FF7FFF7FFF7F2000
      FF7FF645E345887F31763F2FBB61332BB745424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FC00FF00FFFFFFFFFC00FF00FFFF0000
      FC00FF000000FFFFFC00FF0000F8FFFF0000000000F800F800000000FFFF0000
      000000000000FFFF00000000FFFFFFFF00230023FFFFFFFF0001000100000000
      00000000000000000023002300000000006300634C00000000C300C33E200000
      010701070000000003FF03FF0000000000000000000000000000000000000000
      000000000000}
  end
  object macgreenImageList: TImageList
    Height = 15
    Width = 15
    Left = 104
    Top = 144
    Bitmap = {
      494C01010200040004000F000F00FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000003C0000000F00000001001000000000000807
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F000000000000000000000000
      FF7FFF7FFF7FFF7FFF7F00000000000000000000CE39AD35AD35AD35AD353146
      000000000000000000000000000000000000A4268422842284228422E43A0000
      000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000
      000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7F00000000000000004A29AD35314694523146AD35CE391042000000000000
      0000000000000000241AA426E43A243FE42E8422A426A4320000000000000000
      00000000000000000000000000000000000000000000FF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
      104231463967BD77BD777B6F3967B5561042104200000000000000000000A426
      E43A845BE46FE46FE46F845B243FA426A432000000000000000000000000FF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F000000000000000000000000
      0000000000000000000000000000FF7FFF7F000000001042314639677B6F7B6F
      396739677B6FF75E314631460000000000000000A432E42EA453E45FE45FA453
      E45FE45F844BE42EE43200000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      000000000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F00003146104294523967F75EF75E396739673967F75E
      B5561042314600000000E432A426243F844B844BA453A453A453A453644B243F
      A432E4320000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000
      000000004A29104294529452B556B556B55694529452B55694521042AD350000
      0000241AE42EE432243F243F243F243F243F243F243F243FA42684220000FF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F000029251042
      314694523146945294523146945294523146AD354A2900000000E415E42EE42E
      E42EE432E432E432E432E432E432E4328422241A0000FF7FFF7FFF7FFF7FFF7F
      FF7FFF7F183E0D21C914C914183E30291800180010000108FF7FFF7F10000000
      000026102C000000960C210000022C0026100000E71CAD351042314631463146
      31463146314631463146AD35292500000000E415241AE42EE42EE42EE432E42E
      E42EE42EE42EE42E8422E4150000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F00004A292925CE39CE391042104231461042CE39CE39
      AD358C314A2900000000241A241A84228422A426E42EE42EE42EA42684228422
      241A241A0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7F0000292529254A29AD3510421042CE3910421042CE39AD354A29CE390000
      0000241AE415241A8422A426A426A426A426A4268422241A241AA4320000FF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F241AA426E43A243FE42E8422A426
      A432FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000AD35
      4A293146B556B556B556B556F75E31468C318C3100000000000000008422241A
      E432243F243F243F243F644BE4328422241A00000000A426243F844B844BA453
      A453A453A453644B243FA432E432FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FA432E42EA453E45FE45FA453000000000000CE391042F75E7B6F
      7B6F7B6FF75E3146CE39000000000000000000000000A426E42E644BE45FE46F
      E45F644BE432A426000000000000FF7FE42E8422E415FF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FE415E42EE42EE42EE432E432E432E432E432E432
      E4328422241AFF7FFF7F00000000000000008C311042F75EF75EB556AD35AD35
      000000000000000000000000000000008422A432644B845B243F842284220000
      000000000000FF7FFF7FFF7FFF7FFF7FA426E43A845BE46FE46FE46F845B243F
      A426A432FF7FFF7F241AFF7FFF7FFF7FFF7F241AA426E43A243FE42E8422A426
      A4320000000000000000000031462925A514E71CCE3900000000000000000000
      00000000000000000000E43A241AE415E415A43200000000000000000000FF7F
      FF7FFF7FE415E42EE42EE42EE432E432E432E432E432E432E4328422241AFF7F
      FF7FFF7F241AE42EE432243F243F243F243F243F243F243F243F424D3E000000
      000000003E000000280000003C0000000F000000010001000000000078000000
      0000000000000000000000000000000000000000FFFFFF00FFFFFFFDC45DC490
      F81FF03FFFFFFFF0F00FE01FFFFFFFF0E007C00F447E0440C007800F04454460
      80030007FFFFFFF080030007FFFFFFF080030007C42B446080030007FFFFC470
      80030007FFFFFFF080030007FFFFFFF0C007800F4C000000E00FC01FFFFFFFF0
      F01FE03C00000000F83FF07C0000000000000000000000000000000000000000
      000000000000}
  end
  object Table2: TTable
    Active = True
    DatabaseName = 'InfoDemo5'
    TableName = 'Ip4inv.DB'
    Left = 544
    Top = 48
    object Table2CustomerNo: TIntegerField
      FieldName = 'Customer No'
    end
    object Table2InvoiceNo: TFloatField
      FieldName = 'Invoice No'
    end
    object Table2PaymentMethod: TFloatField
      Alignment = taLeftJustify
      FieldName = 'Payment Method'
    end
    object Table2TotalInvoice: TCurrencyField
      FieldName = 'Total Invoice'
    end
    object Table2PurchaseDate: TDateField
      FieldName = 'Purchase Date'
    end
    object Table2BalanceDue: TCurrencyField
      FieldName = 'Balance Due'
    end
    object Table2First: TStringField
      FieldKind = fkLookup
      FieldName = 'First'
      LookupDataSet = Table1
      LookupKeyFields = 'Customer No'
      LookupResultField = 'First Name'
      KeyFields = 'Customer No'
      Lookup = True
    end
    object Table2Last: TStringField
      FieldKind = fkLookup
      FieldName = 'Last'
      LookupDataSet = Table1
      LookupKeyFields = 'Customer No'
      LookupResultField = 'Last Name'
      KeyFields = 'Customer No'
      Lookup = True
    end
  end
  object SumQuery: TwwQuery
    DatabaseName = 'InfoDemo5'
    ParamCheck = False
    SQL.Strings = (
      
        'select sum(ip4inv."balance due"),sum(ip4inv."Total Invoice") fro' +
        'm ip4inv')
    ValidateWithMask = True
    Left = 536
    Top = 160
    object SumQuerySUMOFbalancedue: TCurrencyField
      DisplayWidth = 10
      FieldName = 'SUM OF balance due'
    end
    object SumQuerySUMOFTotalInvoice: TCurrencyField
      DisplayWidth = 10
      FieldName = 'SUM OF Total Invoice'
    end
  end
  object wwDataSource1: TwwDataSource
    DataSet = SumQuery
    Left = 504
    Top = 160
  end
  object DataSource2: TDataSource
    DataSet = Table2
    Left = 512
    Top = 48
  end
end
