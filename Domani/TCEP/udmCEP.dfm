object dmCEP: TdmCEP
  OldCreateOrder = False
  Left = 669
  Top = 404
  Height = 150
  Width = 215
  object sqlCEP: TSQLConnection
    ConnectionName = 'MSSQLConnection'
    DriverName = 'MSSQL'
    GetDriverFunc = 'getSQLDriverMSSQL'
    LibraryName = 'dbexpmss.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=MSSQL'
      'HostName='
      'DataBase='
      'User_Name='
      'Password='
      'BlobSize=-1'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'MSSQL TransIsolation=ReadCommited'
      'OS Authentication=False')
    VendorLib = 'oledb'
    Left = 38
    Top = 32
  end
  object qryCEP: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = sqlCEP
    Left = 96
    Top = 34
  end
end
