object DataGroupForm: TDataGroupForm
  Left = 192
  Top = 114
  Width = 544
  Height = 375
  Caption = 'Grouping by common data'
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
    Width = 536
    Height = 341
    DisableThemes = False
    LineStyle = glsSingle
    Selected.Strings = (
      'Company'#9'30'#9'Company'
      'OrderNo'#9'10'#9'OrderNo'
      'SaleDate'#9'18'#9'SaleDate'
      'ShipDate'#9'18'#9'ShipDate'
      'EmpNo'#9'10'#9'EmpNo'
      'ShipToContact'#9'20'#9'ShipToContact'
      'ShipToAddr1'#9'30'#9'ShipToAddr1'
      'ShipToAddr2'#9'30'#9'ShipToAddr2'
      'ShipToCity'#9'15'#9'ShipToCity'
      'ShipToState'#9'20'#9'ShipToState'
      'ShipToZip'#9'10'#9'ShipToZip'
      'ShipToCountry'#9'20'#9'ShipToCountry'
      'ShipToPhone'#9'15'#9'ShipToPhone'
      'ShipVIA'#9'7'#9'ShipVIA'
      'PO'#9'15'#9'PO'
      'Terms'#9'6'#9'Terms'
      'PaymentMethod'#9'7'#9'PaymentMethod'
      'ItemsTotal'#9'10'#9'ItemsTotal'
      'TaxRate_1'#9'10'#9'TaxRate_1'
      'Freight'#9'10'#9'Freight'
      'AmountPaid'#9'10'#9'AmountPaid')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 1
    ShowHorzScrollBar = True
    Align = alClient
    Color = clCream
    DataSource = DataSource1
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    OnTopRowChanged = wwDBGrid1TopRowChanged
    OnBeforeDrawCell = wwDBGrid1BeforeDrawCell
    OnAfterDrawCell = wwDBGrid1AfterDrawCell
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 64
    Top = 16
  end
  object Query1: TQuery
    Active = True
    DatabaseName = 'InfoDemo5'
    SQL.Strings = (
      'Select * from Customer,Orders'
      'Where Customer."CustNo"=Orders."CustNo"'
      'Order By Customer."CustNo"')
    Left = 96
    Top = 16
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'InfoDemo5'
    TableName = 'customer.db'
    Left = 144
    Top = 16
  end
end
