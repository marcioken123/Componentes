Unit DBBarcode;

Interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DBarcode, DB, DBCtrls;

Type

	{ ---------- TDBDuckBarCode ---------- }
	TDBDuckBarCode = Class (TCustomControl)
  Private
  Protected
  	FBarcode:	TDuckBarcode;
     FDataLink:	TFieldDataLink;
		FPicture:	TPicture;
     FBorderStyle:	TBorderStyle;

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
     Procedure	SetDensity (Const Value: Integer);
     Function		GetDensity: Integer;
     Procedure	SetAlignment (Const Value: TAlignment);
     Function		GetAlignment: TAlignment;
     Procedure	SetBarWidth (Const Value: Double);
     Function		GetBarWidth: Double;
     Procedure	SetOptions (Const Value: TBarcodeOptions);
     Function		GetOptions: TBarcodeOptions;

     Function		GetDataField: String;
     Procedure	SetDataField (Const Value: String);
     Function		GetDataSource: TDataSource;
		Procedure	SetDataSource (Value: TDataSource);
     Procedure	SetPicture (Value: TPicture);
     Function		GetField: TField;
     Procedure	SetBorderStyle(Value: TBorderStyle);
     Procedure	DataChange(Sender: TObject);
     Procedure	CreateParams (var Params: TCreateParams); Override;
     Procedure	Loaded; Override;
     Procedure	Paint; Override;
  Public
  	Constructor	Create(owner: TComponent); Override;
		Destructor	Destroy; Override;
     Property		Barcode:	TDuckBarcode Read FBarcode;
     Function		Print (rLeft, rTop: Real): TRect;
     Function		PaintPoint (Canvas: TCanvas; pt: TPoint): TRect;
     Procedure	PaintRect (Canvas: TCanvas; Rc: TRect);

     property		Picture: TPicture read FPicture write SetPicture;
     property		Field: TField read GetField;
  Published
  	Property Alignment:	TAlignment Read GetAlignment Write SetAlignment;
		Property Style:		TBarcodeStyle Read GetStyle Write SetStyle;
     Property Rotation:	TBarcodeRotation Read GetRotation Write SetRotation;
     Property AddOn:		String Read GetAddOn Write SetAddOn;
     Property HeightMM:	Double Read GetHeightMM Write SetHeightMM;
     Property ColorBar:	TColor Read GetColor Write SetColor;
     Property ColorBK:		TColor Read GetColorBK Write SetColorBK;
     Property Font:			TFont Read GetFont Write SetFont;
     Property Density:		Integer Read GetDensity Write SetDensity;
     Property BarWidthMM:	Double Read GetBarWidth Write SetBarWidth;
     Property Options:		TBarcodeOptions Read GetOptions Write SetOptions
     							Default [boShowText, boCheckCRC];

     Property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
     Property Color;
     Property Ctl3D;
     Property DataField: string read GetDataField write SetDataField;
     Property DataSource: TDataSource read GetDataSource write SetDataSource;
	End;

Procedure Register;

Implementation

Procedure Register;
Begin
	RegisterComponents('DuckTech', [TDBDuckBarCode]);
End;

{ ---------- TDBDuckBarCode ---------- }
Constructor TDBDuckBarCode.Create(owner: TComponent);
Begin
	inherited Create(owner);
	FBarcode	:= TDuckBarcode.Create (Self);
  
  FPicture := TPicture.Create;
  Color		:= clWhite;
  ControlStyle := ControlStyle + [csOpaque, csReplicatable];
	if not NewStyleControls then
  	ControlStyle := ControlStyle + [csFramed];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FBorderStyle := bsSingle;
End;
Destructor TDBDuckBarCode.Destroy;
Begin
	FPicture.Free;
	FDataLink.Free;
  FDataLink := nil;
	FBarcode.Free;
  inherited Destroy;
End;
Procedure TDBDuckBarCode.SetStyle (Const Value: TBarcodeStyle);
Begin
	FBarcode.Style	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TDBDuckBarCode.GetStyle: TBarcodeStyle;
Begin
	Result	:= FBarcode.Style; 
End;
Procedure TDBDuckBarCode.SetRotation (Const Value: TBarcodeRotation);
Begin
	FBarcode.Rotation	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TDBDuckBarCode.GetRotation: TBarcodeRotation;
Begin
	Result	:= FBarcode.Rotation;
End;
Procedure TDBDuckBarCode.SetAddOn (Const Value: String);
Begin
	FBarcode.AddOn	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TDBDuckBarCode.GetAddOn: String;
Begin
	Result	:= FBarcode.AddOn;
End;
Procedure TDBDuckBarCode.SetHeightMM (Const Value: Double);
Begin
	FBarcode.HeightMM	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TDBDuckBarCode.GetHeightMM: Double;
Begin
	Result	:= FBarcode.HeightMM;
End;
Procedure TDBDuckBarCode.SetColor (Const Value: TColor);
Begin
	FBarcode.ColorBar	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TDBDuckBarCode.GetColor: TColor;
Begin
	Result	:= FBarcode.ColorBar;
End;
Procedure TDBDuckBarCode.SetColorBK (Const Value: TColor);
Begin
	FBarcode.ColorBK	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TDBDuckBarCode.GetColorBK: TColor;
Begin
	Result	:= FBarcode.ColorBK;
End;
Procedure TDBDuckBarCode.SetFont (Const Value: TFont);
Begin
	FBarcode.Font	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TDBDuckBarCode.GetFont: TFont;
Begin
	Result	:= FBarcode.Font;
End;
Procedure TDBDuckBarCode.SetDensity (Const Value: Integer);
Begin
	FBarcode.Density	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TDBDuckBarCode.GetDensity: Integer;
Begin
	Result	:= FBarcode.Density;
End;
Procedure TDBDuckBarCode.SetAlignment (Const Value: TAlignment);
Begin
	FBarcode.Alignment	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TDBDuckBarCode.GetAlignment: TAlignment;
Begin
	Result	:= FBarcode.Alignment;
End;
Procedure TDBDuckBarCode.SetBarWidth (Const Value: Double);
Begin
	FBarcode.BarWidthMM	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TDBDuckBarCode.GetBarWidth: Double;
Begin
	Result	:= FBarcode.BarWidthMM;
End;
Procedure TDBDuckBarCode.SetOptions (Const Value: TBarcodeOptions);
Begin
	FBarcode.Options	:= Value;
  Picture.Graphic	:= FBarcode.GetBitmap;
	Invalidate;
End;
Function TDBDuckBarCode.GetOptions: TBarcodeOptions;
Begin
	Result	:= FBarcode.Options;
End;
Function TDBDuckBarCode.GetDataField: String;
Begin
	Result	:= FDataLink.FieldName;
End;
Procedure TDBDuckBarCode.SetDataField (Const Value: String);
Begin
	FDataLink.FieldName := Value;
End;
Function TDBDuckBarCode.GetDataSource: TDataSource;
Begin
	Result := FDataLink.DataSource;
End;
Procedure TDBDuckBarCode.SetDataSource (Value: TDataSource);
Begin
	FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
End;
Function TDBDuckBarCode.GetField: TField;
Begin
	Result := FDataLink.Field;
End;
Procedure TDBDuckBarCode.SetBorderStyle(Value: TBorderStyle);
Begin
	if FBorderStyle <> Value then
	Begin
		FBorderStyle := Value;
		RecreateWnd;
	End;
End;
Procedure TDBDuckBarCode.SetPicture(Value: TPicture);
Begin
  FPicture.Assign(Value);
End;
Procedure TDBDuckBarCode.DataChange(Sender: TObject);
Begin
	Picture.Graphic	:= nil;
  if Assigned (FDataLink.Field) Then
  Begin
		FBarcode.Text		:= FDataLink.Field.AsString;
     Picture.Graphic	:= FBarcode.GetBitmap;
  End;
  Invalidate;
End;
Procedure TDBDuckBarCode.CreateParams(var Params: TCreateParams);
Begin
	inherited CreateParams(Params);
	With Params Do
	Begin
		if FBorderStyle = bsSingle Then
			if NewStyleControls and Ctl3D Then
				ExStyle := ExStyle or WS_EX_CLIENTEDGE
			Else
				Style := Style or WS_BORDER;
		WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
	End;
End;

Procedure TDBDuckBarCode.Loaded;
Begin
	inherited Loaded;
	if (csDesigning in ComponentState) then DataChange(Self);
End;
Procedure TDBDuckBarCode.Paint;
Var
	Size:			TSize;
	R:				TRect;
	S:				String;
	DrawPict:	TPicture;
	Form:			TCustomForm;
	Pal:			HPalette;
Begin
	With Canvas Do
	Begin
		Brush.Style := bsSolid;
		Brush.Color := Color;
     DrawPict				:= TPicture.Create;
     Try
			if csPaintCopy in ControlState then
     	Begin
           if Assigned (FDataLink.Field) Then
           Begin
        		FBarcode.Text		:= FDataLink.Field.AsString;
					DrawPict.Graphic	:= FBarcode.GetBitmap;
           End;
        End
        Else
        	DrawPict.Assign (Picture);
			SetRect(R, 0, 0, DrawPict.Width, DrawPict.Height);
			OffsetRect(R, (ClientWidth - DrawPict.Width) div 2,
            (ClientHeight - DrawPict.Height) div 2);
			StretchDraw(R, DrawPict.Graphic);
			ExcludeClipRect(Handle, R.Left, R.Top, R.Right, R.Bottom);
			FillRect(ClientRect);
			SelectClipRgn(Handle, 0);
     Finally
     	DrawPict.Free;
     End;
     Form := GetParentForm(Self);
    if (Form <> nil) and (Form.ActiveControl = Self) and
      not (csDesigning in ComponentState) and
      not (csPaintCopy in ControlState) then
    begin
      Brush.Color := clWindowFrame;
      FrameRect(ClientRect);
    end;
  End;
End;
Function TDBDuckBarCode.Print (rLeft, rTop: Real): TRect;
Begin
	Result	:= FBarcode.Print (rLeft, rTop);
End;
Function TDBDuckBarCode.PaintPoint (Canvas: TCanvas; pt: TPoint): TRect;
Begin
	Result	:= FBarcode.PaintPoint (Canvas, pt);
End;
Procedure TDBDuckBarCode.PaintRect (Canvas: TCanvas; Rc: TRect);
Begin
	FBarcode.PaintRect (Canvas, Rc);
End;
End.
