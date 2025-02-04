unit DBarcode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DB, DBCtrls, QuickRpt;
  
type
  //TStyle = (bsean13, bscode39, bsean8, bscodabar, bscode128a, bscode128b,
   //bsupca, bsupce, bscode25interleaved, bscode128c);

  TBarcodeStyle = (bsean13, bscode39, bsean8, bscodabar, bscode128a, bscode128b,
   bsupca, bsupce, bscode25interleaved, bscode128c);

  TBarcodeOption = (boShowText, boCheckCRC);
  TBarcodeOptions = set of TBarcodeOption;
  TBarcodeRotation = (brDefault);

  TDuckBarCode = class(TQRPrintable)
  private                           
    FOptions:		TBarcodeOptions;  
    FStyle: TBarcodeStyle;
  published
  	Property Alignment;
    Property Font;
    Property Options:		TBarcodeOptions Read FOptions Write FOptions default [boShowText];
    property Style: TBarcodeStyle read FStyle write FStyle;
  end;

  TDBDuckBarCode = class(TDuckBarCode)
  private
    FAlignment: TAlignment;
    FStyle: TBarcodeStyle;
    FRotation: TBarcodeRotation;
    FAddOn: string;
    FHeightMM: Double;
    FColorBar: TColor;
    FColorBK: TColor;
    FFont: TFont;
    FDensity: Integer;
    FBarWidthMM: Double;
    FBorderStyle: TBorderStyle;
    FDataField: string;
    FDataSource: TDataSource;
  published
    //property Style: TStyle read FStyle write FStyle;
  	Property Alignment;
		Property Style:		TBarcodeStyle Read FStyle Write FStyle;
    Property Rotation:	TBarcodeRotation Read FRotation Write FRotation;
    Property AddOn:		String Read FAddOn Write FAddOn;
    Property HeightMM:	Double Read FHeightMM Write FHeightMM;
    Property ColorBar:	TColor Read FColorBar Write FColorBar;
    Property ColorBK:		TColor Read FColorBK Write FColorBK;
    Property Font;
    Property Density:		Integer Read FDensity Write FDensity;
    Property BarWidthMM:	Double Read FBarWidthMM Write FBarWidthMM;
    Property Options;

    Property BorderStyle: TBorderStyle read FBorderStyle write FBorderStyle default bsSingle;
    Property Color;
    Property Ctl3D;
    Property DataField: string read FDataField write FDataField;
    Property DataSource: TDataSource read FDataSource write FDataSource;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('FSPremium', [TDuckBarCode, TDBDuckBarCode]);
end;

end.
