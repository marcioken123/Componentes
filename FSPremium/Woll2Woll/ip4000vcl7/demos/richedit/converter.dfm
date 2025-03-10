object RTFImportExportForm: TRTFImportExportForm
  Left = 115
  Top = 181
  Width = 544
  Height = 366
  Caption = 'Demo for Import/Export from RTF'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object wwDBRichEdit1: TwwDBRichEdit
    Left = 0
    Top = 0
    Width = 536
    Height = 273
    ScrollBars = ssVertical
    Align = alTop
    AutoURLDetect = False
    BorderStyle = bsNone
    Frame.Enabled = True
    PrintJobName = 'Delphi 6'
    TabOrder = 0
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
      990000007B5C727466315C6662696469735C616E73695C616E73696370673132
      35325C64656666305C6465666C616E67313033337B5C666F6E7474626C7B5C66
      305C666E696C5C666368617273657430204D532053616E732053657269663B7D
      7D0D0A5C766965776B696E64345C7563315C706172645C6C74727061725C6630
      5C6673313620777744425269636845646974315C7061720D0A7D0D0A00}
  end
  object OpenButton: TBitBtn
    Left = 312
    Top = 280
    Width = 89
    Height = 25
    Caption = 'Import'
    TabOrder = 1
    OnClick = OpenButtonClick
  end
  object SaveButton: TButton
    Left = 424
    Top = 280
    Width = 89
    Height = 25
    Caption = 'Export'
    TabOrder = 2
    OnClick = SaveButtonClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 313
    Width = 536
    Height = 19
    Panels = <
      item
        Width = 250
      end
      item
        Width = 100
      end
      item
        Width = 50
      end>
  end
  object OpenDialog1: TOpenDialog
    Left = 232
    Top = 280
  end
  object SaveDialog1: TSaveDialog
    Left = 272
    Top = 288
  end
end
