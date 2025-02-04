Unit DBarQrp;

Interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
	DSGNINTF, Dialogs, DBarcode, DB, QuickRpt;
Type

	{ ---------- TQRDuckBarcode ---------- }
	TQRDuckBarcode = Class (TQRPrintable)
  Private
  Protected
  	FBarcode:	TDuckBarcode;
		FPicture:	TPicture;
     FDataField:	String;
     FDataSet:	TDataSet;
     FOnAfterPrint : TNotifyEvent;
     Procedure	SetStyle (Const Value: TBarcodeStyle);
     Function		GetStyle: TBarcodeStyle;
     Procedure	SetRotation (Const Value: TBarcodeRotation);
     Function		GetRotation: TBarcodeRotation;
     Procedure	SetAddOn (Const Value: String);
     Function		GetAddOn: String;
     Procedure	SetHeightMM (Const Value: Double);
     Function		GetHeightMM: Double;
     Procedure	SetColor (Const Value: TColor);
     Function		GetColor: TColor;
     Procedure	SetColorBK (Const Value: TColor);
     Function		GetColorBK: TColor;
     Procedure	SetFont (Const Value: TFont);
     Function		GetFont: TFont;
     Procedure	SetAlignment (Const Value: TAlignment);
     Function		GetAlignment: TAlignment;
     Procedure	SetBarWidth (Const Value: Double);
     Function		GetBarWidth: Double;
     Procedure	SetOptions (Const Value: TBarcodeOptions);
     Function		GetOptions: TBarcodeOptions;

     Procedure	SetPicture (Value: TPicture);
     Procedure	Paint; Override;
  Public
  	Constructor	Create(owner: TComponent); Override;
		Destructor	Destroy; Override;
     Property		Barcode:	TDuckBarcode Read FBarcode;
     Procedure	Print (OfsX, OfsY : integer); override;
     property		Picture: TPicture read FPicture write SetPicture;
  Published
     property Alignment:	TAlignment Read GetAlignment Write SetAlignment;
     property Style:		TBarcodeStyle Read GetStyle Write SetStyle;
     Property Rotation:	TBarcodeRotation Read GetRotation Write SetRotation;
     Property AddOn:		String Read GetAddOn Write SetAddOn;
     Property HeightMM:	Double Read GetHeightMM Write SetHeightMM;
     Property ColorBar:	TColor Read GetColor Write SetColor;
     Property ColorBK:		TColor Read GetColorBK Write SetColorBK;
     Property Font:			TFont Read GetFont Write SetFont;
     Property BarWidthMM:	Double Read GetBarWidth Write SetBarWidth;
     Property Options:		TBarcodeOptions Read GetOptions Write SetOptions
     							Default [boShowText, boCheckCRC];

     Property Color;
     Property DataField:	String read FDataField write FDataField;
     Property DataSet: 	TDataSet read FDataSet write FDataSet;
     property OnAfterPrint : TNotifyEvent Read FOnAfterPrint  Write FOnAfterPrint;
  End;

  { ---------- TQRBarcodeFieldProperty ---------- }
  TQRBarcodeFieldProperty = Class(TStringProperty)
     Public
		Procedure	GetValues(Proc: TGetStrProc); Override;
		Function		GetAttributes: TPropertyAttributes; Override;
  end;

Procedure Register;

Implementation
{$R DBarQrp.res}
Procedure Register;
Begin
	RegisterComponents('DuckTech', [TQRDuckBarcode]);
	RegisterPropertyEditor (TypeInfo(String), TQRDuckBarcode, 'DataField',
		TQRBarcodeFieldProperty);
End;

{ ---------- TQRBarcodeFieldProperty ---------- }
Function TQRBarcodeFieldProperty.GetAttributes : TPropertyAttributes;
Begin
  Result := [paValueList, paSortList];
End;
Procedure TQRBarcodeFieldProperty.GetValues(Proc: TGetStrProc);
Var
	i:					Integer;
  QRDuckBarcode:	TQRDuckBarcode;
Begin
	if not (GetComponent(0) is TQRDuckBarcode) Then Exit;
	QRDuckBarcode	:= TQRDuckBarcode (GetComponent(0));
  if QRDuckBarcode.DataSet = nil Then Exit;
	For i := 0 To QRDuckBarcode.DataSet.FieldCount - 1 Do
	Begin
//  	if QRDuckBarcode.DataSet.Fields[i].Visible Then
		Proc (QRDuckBarcode.DataSet.Fields[i].FieldName);
	End;
End;

{ ---------- TQRDuckBarcode ---------- }
Constructor TQRDuckBarcode.Create(owner: TComponent);
Begin
	inherited Create(owner);
	FBarcode	:= TDuckBarcode.Create (Self);
  FBarcode.Text		:= '0123456789012';
  FBarcode.Density	:= 1;

  FPicture := TPicture.Create;
  Color		:= clWhite;
End;
Destructor TQRDuckBarcode.Destroy;
Begin
	FPicture.Free;
	FBarcode.Free;
  inherited Destroy;
End;
Procedure TQRDuckBarcode.SetStyle (Const Value: TBarcodeStyle);
Begin
	FBarcode.Style	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TQRDuckBarcode.GetStyle: TBarcodeStyle;
Begin
	Result	:= FBarcode.Style; 
End;
Procedure TQRDuckBarcode.SetRotation (Const Value: TBarcodeRotation);
Begin
	FBarcode.Rotation	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TQRDuckBarcode.GetRotation: TBarcodeRotation;
Begin
	Result	:= FBarcode.Rotation;
End;
Procedure TQRDuckBarcode.SetAddOn (Const Value: String);
Begin
	FBarcode.AddOn	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TQRDuckBarcode.GetAddOn: String;
Begin
	Result	:= FBarcode.AddOn;
End;
Procedure TQRDuckBarcode.SetHeightMM (Const Value: Double);
Begin
	FBarcode.HeightMM	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TQRDuckBarcode.GetHeightMM: Double;
Begin
	Result	:= FBarcode.HeightMM;
End;
Procedure TQRDuckBarcode.SetColor (Const Value: TColor);
Begin
	FBarcode.ColorBar	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TQRDuckBarcode.GetColor: TColor;
Begin
	Result	:= FBarcode.ColorBar;
End;
Procedure TQRDuckBarcode.SetColorBK (Const Value: TColor);
Begin
	FBarcode.ColorBK	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TQRDuckBarcode.GetColorBK: TColor;
Begin
	Result	:= FBarcode.ColorBK;
End;
Procedure TQRDuckBarcode.SetFont (Const Value: TFont);
Begin
	FBarcode.Font	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TQRDuckBarcode.GetFont: TFont;
Begin
	Result	:= FBarcode.Font;
End;
Procedure TQRDuckBarcode.SetOptions (Const Value: TBarcodeOptions);
Begin
	FBarcode.Options	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TQRDuckBarcode.GetOptions: TBarcodeOptions;
Begin
	Result	:= FBarcode.Options;
End;
Procedure TQRDuckBarcode.SetAlignment (Const Value: TAlignment);
Begin
	FBarcode.Alignment	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TQRDuckBarcode.GetAlignment: TAlignment;
Begin
	Result	:= FBarcode.Alignment;
End;
Procedure TQRDuckBarcode.SetBarWidth (Const Value: Double);
Begin
	FBarcode.BarWidthMM	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TQRDuckBarcode.GetBarWidth: Double;
Begin
	Result	:= FBarcode.BarWidthMM;
End;
Procedure TQRDuckBarcode.SetPicture(Value: TPicture);
Begin
  FPicture.Assign(Value);
End;
{
Procedure TQRDuckBarcode.Paint;
Var
	R:				TRect;
Begin
	With Canvas Do
  Begin
		Brush.Color	:= ColorBK;
		Pen.Color	:= clBlack;
     Pen.Style	:= psSolid;
  	Rectangle(0, 0, Width - 1, Height - 1);
     if not Picture.Graphic.Empty Then
     Begin
			SetRect(R, 1, 1, Picture.Width, Picture.Height);
			OffsetRect(R, (ClientWidth - Picture.Width) div 2,
            (ClientHeight - Picture.Height) div 2);
			StretchDraw (R, Picture.Graphic);
     End;
  End;
End;
}
Procedure TQRDuckBarcode.Paint;
Var
	R:				TRect;
	Field:		TField;
Begin
	Field	:= nil;
	if FDataSet <> nil Then
  	if FDataSet.Active Then
     	if FDataField <> '' Then
  			Field	:= FDataSet.FieldByName (FDataField);

	With Canvas Do
  Begin
		Brush.Color	:= ColorBK;
		Pen.Color	:= clBlack;
     Pen.Style	:= psSolid;
  	Rectangle(0, 0, Width - 1, Height - 1);
     if Field <> nil Then
     	FBarcode.Text	:= Field.AsString
     Else
     	FBarcode.Text		:= '0123456789012';
     SetRect(R, 1, 1, Picture.Width, Picture.Height);
		FBarcode.PaintRectQReport (Canvas, R);
  End;
End;
Procedure TQRDuckBarcode.Print(OfsX, OfsY : integer);
Var
 CalcLeft,
 CalcTop,
 CalcRight,
 CalcBottom : Longint;
 Field : TField;
Begin
  Field	:= nil;
  if FDataSet <> nil then
  if FDataSet.Active then
  if FDataField <> '' then
  Field :=FDataSet.FieldByName (FDataField);
  if Field.AsString<>'' then
  with ParentReport.QRPrinter do
  begin
    CalcLeft:=XPos(OfsX + Size.Left);
    CalcTop:=YPos(OfsY + Size.Top);
    CalcRight:=XPos(OfsX + Size.Left + Size.Width);
    CalcBottom:=YPos(OfsY + Size.Top + Size.Height);
    FBarcode.Text:=Field.AsString;
    FBarcode.PaintRectQReport (Canvas,
    Rect(CalcLeft,CalcTop,CalcRight,CalcBottom));
  end;
  if(Assigned(FOnAfterPrint)) then FOnAfterPrint(Self);
End;

End.
