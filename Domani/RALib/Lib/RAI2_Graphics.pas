{***********************************************************
                R&A Library
                   RAI2
       Copyright (C) 1998-99 R&A

       description : adapter unit - converts RAI2 calls to delphi calls

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib
************************************************************}
{$INCLUDE RA.INC}

unit RAI2_Graphics;

interface

uses RAI2;

  procedure RegisterRAI2Adapter(RAI2Adapter: TRAI2Adapter);

implementation

uses Windows, Classes, Graphics, RAI2_Windows;


  { TFont }

{ constructor Create }
procedure TFont_Create(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TFont.Create);
end;

{  procedure Assign(Source: TPersistent); }
procedure TFont_Assign(var Value: Variant; Args: TArgs);
begin
  TFont(Args.Obj).Assign(V2O(Args.Values[0]) as TPersistent);
end;


{ property Read Handle: HFont }
procedure TFont_Read_Handle(var Value: Variant; Args: TArgs);
begin
  Value := Integer(TFont(Args.Obj).Handle);
end;

{ property Write Handle(Value: HFont) }
procedure TFont_Write_Handle(const Value: Variant; Args: TArgs);
begin
  TFont(Args.Obj).Handle := Value;
end;

{ property Read PixelsPerInch: Integer }
procedure TFont_Read_PixelsPerInch(var Value: Variant; Args: TArgs);
begin
  Value := TFont(Args.Obj).PixelsPerInch;
end;

{ property Write PixelsPerInch(Value: Integer) }
procedure TFont_Write_PixelsPerInch(const Value: Variant; Args: TArgs);
begin
  TFont(Args.Obj).PixelsPerInch := Value;
end;

{$IFDEF RA_D3H}
{ property Read Charset: TFontCharset }
procedure TFont_Read_Charset(var Value: Variant; Args: TArgs);
begin
  Value := TFont(Args.Obj).Charset;
end;

{ property Write Charset(Value: TFontCharset) }
procedure TFont_Write_Charset(const Value: Variant; Args: TArgs);
begin
  TFont(Args.Obj).Charset := Value;
end;
{$ENDIF RA_D3H}

{ property Read Color: TColor }
procedure TFont_Read_Color(var Value: Variant; Args: TArgs);
begin
  Value := TFont(Args.Obj).Color;
end;

{ property Write Color(Value: TColor) }
procedure TFont_Write_Color(const Value: Variant; Args: TArgs);
begin
  TFont(Args.Obj).Color := Value;
end;

{ property Read Height: Integer }
procedure TFont_Read_Height(var Value: Variant; Args: TArgs);
begin
  Value := TFont(Args.Obj).Height;
end;

{ property Write Height(Value: Integer) }
procedure TFont_Write_Height(const Value: Variant; Args: TArgs);
begin
  TFont(Args.Obj).Height := Value;
end;

{ property Read Name: TFontName }
procedure TFont_Read_Name(var Value: Variant; Args: TArgs);
begin
  Value := TFont(Args.Obj).Name;
end;

{ property Write Name(Value: TFontName) }
procedure TFont_Write_Name(const Value: Variant; Args: TArgs);
begin
  TFont(Args.Obj).Name := Value;
end;

{ property Read Pitch: TFontPitch }
procedure TFont_Read_Pitch(var Value: Variant; Args: TArgs);
begin
  Value := TFont(Args.Obj).Pitch;
end;

{ property Write Pitch(Value: TFontPitch) }
procedure TFont_Write_Pitch(const Value: Variant; Args: TArgs);
begin
  TFont(Args.Obj).Pitch := Value;
end;

{ property Read Size: Integer }
procedure TFont_Read_Size(var Value: Variant; Args: TArgs);
begin
  Value := TFont(Args.Obj).Size;
end;

{ property Write Size(Value: Integer) }
procedure TFont_Write_Size(const Value: Variant; Args: TArgs);
begin
  TFont(Args.Obj).Size := Value;
end;

{ property Read Style: TFontStyles }
procedure TFont_Read_Style(var Value: Variant; Args: TArgs);
begin
  Value := S2V(byte(TFont(Args.Obj).Style));
end;

{ property Write Style(Value: TFontStyles) }
procedure TFont_Write_Style(const Value: Variant; Args: TArgs);
begin
  TFont(Args.Obj).Style := TFontStyles(byte(V2S(Value)));
end;

  { TPen }

{ constructor Create }
procedure TPen_Create(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TPen.Create);
end;

{  procedure Assign(Source: TPersistent); }
procedure TPen_Assign(var Value: Variant; Args: TArgs);
begin
  TPen(Args.Obj).Assign(V2O(Args.Values[0]) as TPersistent);
end;

{ property Read Handle: HPen }
procedure TPen_Read_Handle(var Value: Variant; Args: TArgs);
begin
  Value := Integer(TPen(Args.Obj).Handle);
end;

{ property Write Handle(Value: HPen) }
procedure TPen_Write_Handle(const Value: Variant; Args: TArgs);
begin
  TPen(Args.Obj).Handle := Value;
end;

{ property Read Color: TColor }
procedure TPen_Read_Color(var Value: Variant; Args: TArgs);
begin
  Value := TPen(Args.Obj).Color;
end;

{ property Write Color(Value: TColor) }
procedure TPen_Write_Color(const Value: Variant; Args: TArgs);
begin
  TPen(Args.Obj).Color := Value;
end;

{ property Read Mode: TPenMode }
procedure TPen_Read_Mode(var Value: Variant; Args: TArgs);
begin
  Value := TPen(Args.Obj).Mode;
end;

{ property Write Mode(Value: TPenMode) }
procedure TPen_Write_Mode(const Value: Variant; Args: TArgs);
begin
  TPen(Args.Obj).Mode := Value;
end;

{ property Read Style: TPenStyle }
procedure TPen_Read_Style(var Value: Variant; Args: TArgs);
begin
  Value := TPen(Args.Obj).Style;
end;

{ property Write Style(Value: TPenStyle) }
procedure TPen_Write_Style(const Value: Variant; Args: TArgs);
begin
  TPen(Args.Obj).Style := Value;
end;

{ property Read Width: Integer }
procedure TPen_Read_Width(var Value: Variant; Args: TArgs);
begin
  Value := TPen(Args.Obj).Width;
end;

{ property Write Width(Value: Integer) }
procedure TPen_Write_Width(const Value: Variant; Args: TArgs);
begin
  TPen(Args.Obj).Width := Value;
end;

  { TBrush }

{ constructor Create }
procedure TBrush_Create(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TBrush.Create);
end;

{  procedure Assign(Source: TPersistent); }
procedure TBrush_Assign(var Value: Variant; Args: TArgs);
begin
  TBrush(Args.Obj).Assign(V2O(Args.Values[0]) as TPersistent);
end;

{ property Read Bitmap: TBitmap }
procedure TBrush_Read_Bitmap(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TBrush(Args.Obj).Bitmap);
end;

{ property Write Bitmap(Value: TBitmap) }
procedure TBrush_Write_Bitmap(const Value: Variant; Args: TArgs);
begin
  TBrush(Args.Obj).Bitmap := V2O(Value) as TBitmap;
end;

{ property Read Handle: HBrush }
procedure TBrush_Read_Handle(var Value: Variant; Args: TArgs);
begin
  Value := Integer(TBrush(Args.Obj).Handle);
end;

{ property Write Handle(Value: HBrush) }
procedure TBrush_Write_Handle(const Value: Variant; Args: TArgs);
begin
  TBrush(Args.Obj).Handle := Value;
end;

{ property Read Color: TColor }
procedure TBrush_Read_Color(var Value: Variant; Args: TArgs);
begin
  Value := TBrush(Args.Obj).Color;
end;

{ property Write Color(Value: TColor) }
procedure TBrush_Write_Color(const Value: Variant; Args: TArgs);
begin
  TBrush(Args.Obj).Color := Value;
end;

{ property Read Style: TBrushStyle }
procedure TBrush_Read_Style(var Value: Variant; Args: TArgs);
begin
  Value := TBrush(Args.Obj).Style;
end;

{ property Write Style(Value: TBrushStyle) }
procedure TBrush_Write_Style(const Value: Variant; Args: TArgs);
begin
  TBrush(Args.Obj).Style := Value;
end;

  { TCanvas }

{ constructor Create }
procedure TCanvas_Create(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TCanvas.Create);
end;

{  procedure Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); }
procedure TCanvas_Arc(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).Arc(Args.Values[0], Args.Values[1], Args.Values[2], Args.Values[3], Args.Values[4], Args.Values[5], Args.Values[6], Args.Values[7]);
end;

{  procedure BrushCopy(const Dest: TRect; Bitmap: TBitmap; const Source: TRect; Color: TColor); }
procedure TCanvas_BrushCopy(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).BrushCopy(Var2Rect(Args.Values[0]), V2O(Args.Values[1]) as TBitmap, Var2Rect(Args.Values[2]), Args.Values[3]);
end;

{  procedure Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); }
procedure TCanvas_Chord(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).Chord(Args.Values[0], Args.Values[1], Args.Values[2], Args.Values[3], Args.Values[4], Args.Values[5], Args.Values[6], Args.Values[7]);
end;

{  procedure CopyRect(const Dest: TRect; Canvas: TCanvas; const Source: TRect); }
procedure TCanvas_CopyRect(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).CopyRect(Var2Rect(Args.Values[0]), V2O(Args.Values[1]) as TCanvas, Var2Rect(Args.Values[2]));
end;

{  procedure Draw(X, Y: Integer; Graphic: TGraphic); }
procedure TCanvas_Draw(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).Draw(Args.Values[0], Args.Values[1], V2O(Args.Values[2]) as TGraphic);
end;

{  procedure DrawFocusRect(const Rect: TRect); }
procedure TCanvas_DrawFocusRect(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).DrawFocusRect(Var2Rect((Args.Values[0])));
end;

{  procedure Ellipse(X1, Y1, X2, Y2: Integer); }
procedure TCanvas_Ellipse(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).Ellipse(Args.Values[0], Args.Values[1], Args.Values[2], Args.Values[3]);
end;

{  procedure FillRect(const Rect: TRect); }
procedure TCanvas_FillRect(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).FillRect(Var2Rect(Args.Values[0]));
end;

{  procedure FloodFill(X, Y: Integer; Color: TColor; FillStyle: TFillStyle); }
procedure TCanvas_FloodFill(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).FloodFill(Args.Values[0], Args.Values[1], Args.Values[2], Args.Values[3]);
end;

{  procedure FrameRect(const Rect: TRect); }
procedure TCanvas_FrameRect(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).FrameRect(Var2Rect(Args.Values[0]));
end;

{  procedure LineTo(X, Y: Integer); }
procedure TCanvas_LineTo(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).LineTo(Args.Values[0], Args.Values[1]);
end;

{$IFDEF RA_D3H}
{  procedure Lock; }
procedure TCanvas_Lock(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).Lock;
end;
{$ENDIF RA_D3H}

{  procedure MoveTo(X, Y: Integer); }
procedure TCanvas_MoveTo(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).MoveTo(Args.Values[0], Args.Values[1]);
end;

{  procedure Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); }
procedure TCanvas_Pie(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).Pie(Args.Values[0], Args.Values[1], Args.Values[2], Args.Values[3], Args.Values[4], Args.Values[5], Args.Values[6], Args.Values[7]);
end;

{  procedure Polygon(const Points: array of TPoint); }
procedure TCanvas_Polygon(var Value: Variant; Args: TArgs);
begin
//  TCanvas(Args.Obj).Polygon(Args.Values[0]);
  NotImplemented('TCanvas.Polygon');
end;

{  procedure Polyline(const Points: array of TPoint); }
procedure TCanvas_Polyline(var Value: Variant; Args: TArgs);
begin
//  TCanvas(Args.Obj).Polyline(Args.Values[0]);
  NotImplemented('TCanvas.Polyline'); 
end;

{  procedure Rectangle(X1, Y1, X2, Y2: Integer); }
procedure TCanvas_Rectangle(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).Rectangle(Args.Values[0], Args.Values[1], Args.Values[2], Args.Values[3]);
end;

{  procedure Refresh; }
procedure TCanvas_Refresh(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).Refresh;
end;

{  procedure RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer); }
procedure TCanvas_RoundRect(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).RoundRect(Args.Values[0], Args.Values[1], Args.Values[2], Args.Values[3], Args.Values[4], Args.Values[5]);
end;

{  procedure StretchDraw(const Rect: TRect; Graphic: TGraphic); }
procedure TCanvas_StretchDraw(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).StretchDraw(Var2Rect(Args.Values[0]), V2O(Args.Values[1]) as TGraphic);
end;

{  function TextExtent(const Text: string): TSize; }
procedure TCanvas_TextExtent(var Value: Variant; Args: TArgs);
begin
//  Value := TCanvas(Args.Obj).TextExtent(Args.Values[0]);
  NotImplemented('TCanvas.TextExtent');
end;

{  function TextHeight(const Text: string): Integer; }
procedure TCanvas_TextHeight(var Value: Variant; Args: TArgs);
begin
  Value := TCanvas(Args.Obj).TextHeight(Args.Values[0]);
end;

{  procedure TextOut(X, Y: Integer; const Text: string); }
procedure TCanvas_TextOut(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).TextOut(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

{  procedure TextRect(Rect: TRect; X, Y: Integer; const Text: string); }
procedure TCanvas_TextRect(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).TextRect(Var2Rect(Args.Values[0]), Args.Values[1], Args.Values[2], Args.Values[3]);
end;

{  function TextWidth(const Text: string): Integer; }
procedure TCanvas_TextWidth(var Value: Variant; Args: TArgs);
begin
  Value := TCanvas(Args.Obj).TextWidth(Args.Values[0]);
end;

{$IFDEF RA_D3H}
{  function TryLock: Boolean; }
procedure TCanvas_TryLock(var Value: Variant; Args: TArgs);
begin
  Value := TCanvas(Args.Obj).TryLock;
end;

{  procedure Unlock; }
procedure TCanvas_Unlock(var Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).Unlock;
end;
{$ENDIF RA_D3H}

{ property Read ClipRect: TRect }
procedure TCanvas_Read_ClipRect(var Value: Variant; Args: TArgs);
begin
  Value := Rect2Var(TCanvas(Args.Obj).ClipRect);
end;

{ property Read Handle: HDC }
procedure TCanvas_Read_Handle(var Value: Variant; Args: TArgs);
begin
  Value := Integer(TCanvas(Args.Obj).Handle);
end;

{ property Write Handle(Value: HDC) }
procedure TCanvas_Write_Handle(const Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).Handle := Value;
end;

{$IFDEF RA_D3H}
{ property Read LockCount: Integer }
procedure TCanvas_Read_LockCount(var Value: Variant; Args: TArgs);
begin
  Value := TCanvas(Args.Obj).LockCount;
end;
{$ENDIF RA_D3H}

{ property Read PenPos: TPoint }
procedure TCanvas_Read_PenPos(var Value: Variant; Args: TArgs);
begin
  Value := Point2Var(TCanvas(Args.Obj).PenPos);
end;

{ property Write PenPos(Value: TPoint) }
procedure TCanvas_Write_PenPos(const Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).PenPos := Var2Point(Value);
end;

{ property Read Brush: TBrush }
procedure TCanvas_Read_Brush(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TCanvas(Args.Obj).Brush);
end;

{ property Write Brush(Value: TBrush) }
procedure TCanvas_Write_Brush(const Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).Brush := V2O(Value) as TBrush;
end;

{ property Read CopyMode: TCopyMode }
procedure TCanvas_Read_CopyMode(var Value: Variant; Args: TArgs);
begin
  Value := TCanvas(Args.Obj).CopyMode;
end;

{ property Write CopyMode(Value: TCopyMode) }
procedure TCanvas_Write_CopyMode(const Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).CopyMode := Value;
end;

{ property Read Font: TFont }
procedure TCanvas_Read_Font(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TCanvas(Args.Obj).Font);
end;

{ property Write Font(Value: TFont) }
procedure TCanvas_Write_Font(const Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).Font := V2O(Value) as TFont;
end;

{ property Read Pen: TPen }
procedure TCanvas_Read_Pen(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TCanvas(Args.Obj).Pen);
end;

{ property Write Pen(Value: TPen) }
procedure TCanvas_Write_Pen(const Value: Variant; Args: TArgs);
begin
  TCanvas(Args.Obj).Pen := V2O(Value) as TPen;
end;

  { TGraphic }

{  procedure LoadFromFile(const Filename: string); }
procedure TGraphic_LoadFromFile(var Value: Variant; Args: TArgs);
begin
  TGraphic(Args.Obj).LoadFromFile(Args.Values[0]);
end;

{  procedure SaveToFile(const Filename: string); }
procedure TGraphic_SaveToFile(var Value: Variant; Args: TArgs);
begin
  TGraphic(Args.Obj).SaveToFile(Args.Values[0]);
end;

{  procedure LoadFromStream(Stream: TStream); }
procedure TGraphic_LoadFromStream(var Value: Variant; Args: TArgs);
begin
  TGraphic(Args.Obj).LoadFromStream(V2O(Args.Values[0]) as TStream);
end;

{  procedure SaveToStream(Stream: TStream); }
procedure TGraphic_SaveToStream(var Value: Variant; Args: TArgs);
begin
  TGraphic(Args.Obj).SaveToStream(V2O(Args.Values[0]) as TStream);
end;

{  procedure LoadFromClipboardFormat(AFormat: Word; AData: THandle; APalette: HPALETTE); }
procedure TGraphic_LoadFromClipboardFormat(var Value: Variant; Args: TArgs);
begin
  TGraphic(Args.Obj).LoadFromClipboardFormat(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

{  procedure SaveToClipboardFormat(var AFormat: Word; var AData: THandle; var APalette: HPALETTE); }
procedure TGraphic_SaveToClipboardFormat(var Value: Variant; Args: TArgs);
begin
  TGraphic(Args.Obj).SaveToClipboardFormat(Word(TVarData(Args.Values[0]).VSmallInt), THandle(TVarData(Args.Values[1]).VInteger), HPALETTE(TVarData(Args.Values[2]).VInteger));
end;

{ property Read Empty: Boolean }
procedure TGraphic_Read_Empty(var Value: Variant; Args: TArgs);
begin
  Value := TGraphic(Args.Obj).Empty;
end;

{ property Read Height: Integer }
procedure TGraphic_Read_Height(var Value: Variant; Args: TArgs);
begin
  Value := TGraphic(Args.Obj).Height;
end;

{ property Write Height(Value: Integer) }
procedure TGraphic_Write_Height(const Value: Variant; Args: TArgs);
begin
  TGraphic(Args.Obj).Height := Value;
end;

{ property Read Modified: Boolean }
procedure TGraphic_Read_Modified(var Value: Variant; Args: TArgs);
begin
  Value := TGraphic(Args.Obj).Modified;
end;

{ property Write Modified(Value: Boolean) }
procedure TGraphic_Write_Modified(const Value: Variant; Args: TArgs);
begin
  TGraphic(Args.Obj).Modified := Value;
end;

{$IFDEF RA_D3H}
{ property Read Palette: HPALETTE }
procedure TGraphic_Read_Palette(var Value: Variant; Args: TArgs);
begin
  Value := Integer(TGraphic(Args.Obj).Palette);
end;

{ property Write Palette(Value: HPALETTE) }
procedure TGraphic_Write_Palette(const Value: Variant; Args: TArgs);
begin
  TGraphic(Args.Obj).Palette := Value;
end;

{ property Read PaletteModified: Boolean }
procedure TGraphic_Read_PaletteModified(var Value: Variant; Args: TArgs);
begin
  Value := TGraphic(Args.Obj).PaletteModified;
end;

{ property Write PaletteModified(Value: Boolean) }
procedure TGraphic_Write_PaletteModified(const Value: Variant; Args: TArgs);
begin
  TGraphic(Args.Obj).PaletteModified := Value;
end;

{ property Read Transparent: Boolean }
procedure TGraphic_Read_Transparent(var Value: Variant; Args: TArgs);
begin
  Value := TGraphic(Args.Obj).Transparent;
end;

{ property Write Transparent(Value: Boolean) }
procedure TGraphic_Write_Transparent(const Value: Variant; Args: TArgs);
begin
  TGraphic(Args.Obj).Transparent := Value;
end;
{$ENDIF RA_D3H}

{ property Read Width: Integer }
procedure TGraphic_Read_Width(var Value: Variant; Args: TArgs);
begin
  Value := TGraphic(Args.Obj).Width;
end;

{ property Write Width(Value: Integer) }
procedure TGraphic_Write_Width(const Value: Variant; Args: TArgs);
begin
  TGraphic(Args.Obj).Width := Value;
end;

  { TPicture }

{ constructor Create }
procedure TPicture_Create(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TPicture.Create);
end;

{  procedure LoadFromFile(const Filename: string); }
procedure TPicture_LoadFromFile(var Value: Variant; Args: TArgs);
begin
  TPicture(Args.Obj).LoadFromFile(Args.Values[0]);
end;

{  procedure SaveToFile(const Filename: string); }
procedure TPicture_SaveToFile(var Value: Variant; Args: TArgs);
begin
  TPicture(Args.Obj).SaveToFile(Args.Values[0]);
end;

{  procedure LoadFromClipboardFormat(AFormat: Word; AData: THandle; APalette: HPALETTE); }
procedure TPicture_LoadFromClipboardFormat(var Value: Variant; Args: TArgs);
begin
  TPicture(Args.Obj).LoadFromClipboardFormat(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

{  procedure SaveToClipboardFormat(var AFormat: Word; var AData: THandle; var APalette: HPALETTE); }
procedure TPicture_SaveToClipboardFormat(var Value: Variant; Args: TArgs);
begin
  TPicture(Args.Obj).SaveToClipboardFormat(Word(TVarData(Args.Values[0]).VSmallInt), THandle(TVarData(Args.Values[1]).VInteger), HPALETTE(TVarData(Args.Values[2]).VInteger));
end;

{  function SupportsClipboardFormat(AFormat: Word): Boolean; }
procedure TPicture_SupportsClipboardFormat(var Value: Variant; Args: TArgs);
begin
  Value := TPicture(Args.Obj).SupportsClipboardFormat(Args.Values[0]);
end;

{  procedure Assign(Source: TPersistent); }
procedure TPicture_Assign(var Value: Variant; Args: TArgs);
begin
  TPicture(Args.Obj).Assign(V2O(Args.Values[0]) as TPersistent);
end;

{ property Read Bitmap: TBitmap }
procedure TPicture_Read_Bitmap(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TPicture(Args.Obj).Bitmap);
end;

{ property Write Bitmap(Value: TBitmap) }
procedure TPicture_Write_Bitmap(const Value: Variant; Args: TArgs);
begin
  TPicture(Args.Obj).Bitmap := V2O(Value) as TBitmap;
end;

{ property Read Graphic: TGraphic }
procedure TPicture_Read_Graphic(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TPicture(Args.Obj).Graphic);
end;

{ property Write Graphic(Value: TGraphic) }
procedure TPicture_Write_Graphic(const Value: Variant; Args: TArgs);
begin
  TPicture(Args.Obj).Graphic := V2O(Value) as TGraphic;
end;

{$IFDEF RA_D3H}
{ property Read PictureAdapter: IChangeNotifier }
procedure TPicture_Read_PictureAdapter(var Value: Variant; Args: TArgs);
begin
  Value := TPicture(Args.Obj).PictureAdapter;
end;

{ property Write PictureAdapter(Value: IChangeNotifier) }
procedure TPicture_Write_PictureAdapter(const Value: Variant; Args: TArgs);
begin
//  TPicture(Args.Obj).PictureAdapter := Value;
  NotImplemented('TPicture.PictureAdapter');
end;
{$ENDIF RA_D3H}

{ property Read Height: Integer }
procedure TPicture_Read_Height(var Value: Variant; Args: TArgs);
begin
  Value := TPicture(Args.Obj).Height;
end;

{ property Read Icon: TIcon }
procedure TPicture_Read_Icon(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TPicture(Args.Obj).Icon);
end;

{ property Write Icon(Value: TIcon) }
procedure TPicture_Write_Icon(const Value: Variant; Args: TArgs);
begin
  TPicture(Args.Obj).Icon := V2O(Value) as TIcon;
end;

{ property Read Metafile: TMetafile }
procedure TPicture_Read_Metafile(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TPicture(Args.Obj).Metafile);
end;

{ property Write Metafile(Value: TMetafile) }
procedure TPicture_Write_Metafile(const Value: Variant; Args: TArgs);
begin
  TPicture(Args.Obj).Metafile := V2O(Value) as TMetafile;
end;

{ property Read Width: Integer }
procedure TPicture_Read_Width(var Value: Variant; Args: TArgs);
begin
  Value := TPicture(Args.Obj).Width;
end;

  { TMetafile }

{ constructor Create }
procedure TMetafile_Create(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TMetafile.Create);
end;

{  procedure Clear; }
procedure TMetafile_Clear(var Value: Variant; Args: TArgs);
begin
  TMetafile(Args.Obj).Clear;
end;

{  procedure LoadFromStream(Stream: TStream); }
procedure TMetafile_LoadFromStream(var Value: Variant; Args: TArgs);
begin
  TMetafile(Args.Obj).LoadFromStream(V2O(Args.Values[0]) as TStream);
end;

{  procedure SaveToFile(const Filename: String); }
procedure TMetafile_SaveToFile(var Value: Variant; Args: TArgs);
begin
  TMetafile(Args.Obj).SaveToFile(Args.Values[0]);
end;

{  procedure SaveToStream(Stream: TStream); }
procedure TMetafile_SaveToStream(var Value: Variant; Args: TArgs);
begin
  TMetafile(Args.Obj).SaveToStream(V2O(Args.Values[0]) as TStream);
end;

{  procedure LoadFromClipboardFormat(AFormat: Word; AData: THandle; APalette: HPALETTE); }
procedure TMetafile_LoadFromClipboardFormat(var Value: Variant; Args: TArgs);
begin
  TMetafile(Args.Obj).LoadFromClipboardFormat(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

{  procedure SaveToClipboardFormat(var AFormat: Word; var AData: THandle; var APalette: HPALETTE); }
procedure TMetafile_SaveToClipboardFormat(var Value: Variant; Args: TArgs);
begin
  TMetafile(Args.Obj).SaveToClipboardFormat(Word(TVarData(Args.Values[0]).VSmallInt), THandle(TVarData(Args.Values[1]).VInteger), HPALETTE(TVarData(Args.Values[2]).VInteger));
end;

{  procedure Assign(Source: TPersistent); }
procedure TMetafile_Assign(var Value: Variant; Args: TArgs);
begin
  TMetafile(Args.Obj).Assign(V2O(Args.Values[0]) as TPersistent);
end;

{$IFDEF RA_D3H}
{  function ReleaseHandle: HENHMETAFILE; }
procedure TMetafile_ReleaseHandle(var Value: Variant; Args: TArgs);
begin
  Value := Integer(TMetafile(Args.Obj).ReleaseHandle);
end;
{$ENDIF RA_D3H}

{ property Read CreatedBy: String }
procedure TMetafile_Read_CreatedBy(var Value: Variant; Args: TArgs);
begin
  Value := TMetafile(Args.Obj).CreatedBy;
end;

{ property Read Description: String }
procedure TMetafile_Read_Description(var Value: Variant; Args: TArgs);
begin
  Value := TMetafile(Args.Obj).Description;
end;

{ property Read Enhanced: Boolean }
procedure TMetafile_Read_Enhanced(var Value: Variant; Args: TArgs);
begin
  Value := TMetafile(Args.Obj).Enhanced;
end;

{ property Write Enhanced(Value: Boolean) }
procedure TMetafile_Write_Enhanced(const Value: Variant; Args: TArgs);
begin
  TMetafile(Args.Obj).Enhanced := Value;
end;

{ property Read Handle: HENHMETAFILE }
procedure TMetafile_Read_Handle(var Value: Variant; Args: TArgs);
begin
  Value := Integer(TMetafile(Args.Obj).Handle);
end;

{ property Write Handle(Value: HENHMETAFILE) }
procedure TMetafile_Write_Handle(const Value: Variant; Args: TArgs);
begin
  TMetafile(Args.Obj).Handle := Value;
end;

{ property Read MMWidth: Integer }
procedure TMetafile_Read_MMWidth(var Value: Variant; Args: TArgs);
begin
  Value := TMetafile(Args.Obj).MMWidth;
end;

{ property Write MMWidth(Value: Integer) }
procedure TMetafile_Write_MMWidth(const Value: Variant; Args: TArgs);
begin
  TMetafile(Args.Obj).MMWidth := Value;
end;

{ property Read MMHeight: Integer }
procedure TMetafile_Read_MMHeight(var Value: Variant; Args: TArgs);
begin
  Value := TMetafile(Args.Obj).MMHeight;
end;

{ property Write MMHeight(Value: Integer) }
procedure TMetafile_Write_MMHeight(const Value: Variant; Args: TArgs);
begin
  TMetafile(Args.Obj).MMHeight := Value;
end;

{ property Read Inch: Word }
procedure TMetafile_Read_Inch(var Value: Variant; Args: TArgs);
begin
  Value := TMetafile(Args.Obj).Inch;
end;

{ property Write Inch(Value: Word) }
procedure TMetafile_Write_Inch(const Value: Variant; Args: TArgs);
begin
  TMetafile(Args.Obj).Inch := Value;
end;

  { TBitmap }

{ constructor Create }
procedure TBitmap_Create(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TBitmap.Create);
end;

{  procedure Assign(Source: TPersistent); }
procedure TBitmap_Assign(var Value: Variant; Args: TArgs);
begin
  TBitmap(Args.Obj).Assign(V2O(Args.Values[0]) as TPersistent);
end;

{  procedure Dormant; }
procedure TBitmap_Dormant(var Value: Variant; Args: TArgs);
begin
  TBitmap(Args.Obj).Dormant;
end;

{  procedure FreeImage; }
procedure TBitmap_FreeImage(var Value: Variant; Args: TArgs);
begin
  TBitmap(Args.Obj).FreeImage;
end;

{  procedure LoadFromClipboardFormat(AFormat: Word; AData: THandle; APalette: HPALETTE); }
procedure TBitmap_LoadFromClipboardFormat(var Value: Variant; Args: TArgs);
begin
  TBitmap(Args.Obj).LoadFromClipboardFormat(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

{  procedure LoadFromStream(Stream: TStream); }
procedure TBitmap_LoadFromStream(var Value: Variant; Args: TArgs);
begin
  TBitmap(Args.Obj).LoadFromStream(V2O(Args.Values[0]) as TStream);
end;

{  procedure LoadFromResourceName(Instance: THandle; const ResName: String); }
procedure TBitmap_LoadFromResourceName(var Value: Variant; Args: TArgs);
begin
  TBitmap(Args.Obj).LoadFromResourceName(Args.Values[0], Args.Values[1]);
end;

{  procedure LoadFromResourceID(Instance: THandle; ResID: Integer); }
procedure TBitmap_LoadFromResourceID(var Value: Variant; Args: TArgs);
begin
  TBitmap(Args.Obj).LoadFromResourceID(Args.Values[0], Args.Values[1]);
end;

{$IFDEF RA_D3H}
{  procedure Mask(TransparentColor: TColor); }
procedure TBitmap_Mask(var Value: Variant; Args: TArgs);
begin
  TBitmap(Args.Obj).Mask(Args.Values[0]);
end;
{$ENDIF RA_D3H}

{  function ReleaseHandle: HBITMAP; }
procedure TBitmap_ReleaseHandle(var Value: Variant; Args: TArgs);
begin
  Value := Integer(TBitmap(Args.Obj).ReleaseHandle);
end;

{$IFDEF RA_D3H}
{  function ReleaseMaskHandle: HBITMAP; }
procedure TBitmap_ReleaseMaskHandle(var Value: Variant; Args: TArgs);
begin
  Value := Integer(TBitmap(Args.Obj).ReleaseMaskHandle);
end;
{$ENDIF RA_D3H}

{  function ReleasePalette: HPALETTE; }
procedure TBitmap_ReleasePalette(var Value: Variant; Args: TArgs);
begin
  Value := Integer(TBitmap(Args.Obj).ReleasePalette);
end;

{  procedure SaveToClipboardFormat(var Format: Word; var Data: THandle; var APalette: HPALETTE); }
procedure TBitmap_SaveToClipboardFormat(var Value: Variant; Args: TArgs);
begin
  TBitmap(Args.Obj).SaveToClipboardFormat(Word(TVarData(Args.Values[0]).VSmallInt), THandle(TVarData(Args.Values[1]).VInteger), HPALETTE(TVarData(Args.Values[2]).VInteger));
end;

{  procedure SaveToStream(Stream: TStream); }
procedure TBitmap_SaveToStream(var Value: Variant; Args: TArgs);
begin
  TBitmap(Args.Obj).SaveToStream(V2O(Args.Values[0]) as TStream);
end;

{ property Read Canvas: TCanvas }
procedure TBitmap_Read_Canvas(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TBitmap(Args.Obj).Canvas);
end;

{ property Read Handle: HBITMAP }
procedure TBitmap_Read_Handle(var Value: Variant; Args: TArgs);
begin
  Value := Integer(TBitmap(Args.Obj).Handle);
end;

{ property Write Handle(Value: HBITMAP) }
procedure TBitmap_Write_Handle(const Value: Variant; Args: TArgs);
begin
  TBitmap(Args.Obj).Handle := Value;
end;

{$IFDEF RA_D3H}
{ property Read HandleType: TBitmapHandleType }
procedure TBitmap_Read_HandleType(var Value: Variant; Args: TArgs);
begin
  Value := TBitmap(Args.Obj).HandleType;
end;

{ property Write HandleType(Value: TBitmapHandleType) }
procedure TBitmap_Write_HandleType(const Value: Variant; Args: TArgs);
begin
  TBitmap(Args.Obj).HandleType := Value;
end;
{$ENDIF RA_D3H}

{ property Read IgnorePalette: Boolean }
procedure TBitmap_Read_IgnorePalette(var Value: Variant; Args: TArgs);
begin
  Value := TBitmap(Args.Obj).IgnorePalette;
end;

{ property Write IgnorePalette(Value: Boolean) }
procedure TBitmap_Write_IgnorePalette(const Value: Variant; Args: TArgs);
begin
  TBitmap(Args.Obj).IgnorePalette := Value;
end;

{$IFDEF RA_D3H}
{ property Read MaskHandle: HBITMAP }
procedure TBitmap_Read_MaskHandle(var Value: Variant; Args: TArgs);
begin
  Value := Integer(TBitmap(Args.Obj).MaskHandle);
end;
{$ENDIF RA_D3H}

{ property Read Monochrome: Boolean }
procedure TBitmap_Read_Monochrome(var Value: Variant; Args: TArgs);
begin
  Value := TBitmap(Args.Obj).Monochrome;
end;

{ property Write Monochrome(Value: Boolean) }
procedure TBitmap_Write_Monochrome(const Value: Variant; Args: TArgs);
begin
  TBitmap(Args.Obj).Monochrome := Value;
end;

{$IFDEF RA_D3H}
{ property Read PixelFormat: TPixelFormat }
procedure TBitmap_Read_PixelFormat(var Value: Variant; Args: TArgs);
begin
  Value := TBitmap(Args.Obj).PixelFormat;
end;

{ property Write PixelFormat(Value: TPixelFormat) }
procedure TBitmap_Write_PixelFormat(const Value: Variant; Args: TArgs);
begin
  TBitmap(Args.Obj).PixelFormat := Value;
end;

{ property Read ScanLine[Integer]: Pointer }
procedure TBitmap_Read_ScanLine(var Value: Variant; Args: TArgs);
begin
  Value := P2V(TBitmap(Args.Obj).ScanLine[Args.Values[0]]);
end;
{$ENDIF RA_D3H}

{ property Read TransparentColor: TColor }
procedure TBitmap_Read_TransparentColor(var Value: Variant; Args: TArgs);
begin
  Value := TBitmap(Args.Obj).TransparentColor;
end;

{$IFDEF RA_D3H}
{ property Write TransparentColor(Value: TColor) }
procedure TBitmap_Write_TransparentColor(const Value: Variant; Args: TArgs);
begin
  TBitmap(Args.Obj).TransparentColor := Value;
end;

{ property Read TransparentMode: TTransparentMode }
procedure TBitmap_Read_TransparentMode(var Value: Variant; Args: TArgs);
begin
  Value := TBitmap(Args.Obj).TransparentMode;
end;

{ property Write TransparentMode(Value: TTransparentMode) }
procedure TBitmap_Write_TransparentMode(const Value: Variant; Args: TArgs);
begin
  TBitmap(Args.Obj).TransparentMode := Value;
end;
{$ENDIF RA_D3H}

  { TIcon }

{ constructor Create }
procedure TIcon_Create(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TIcon.Create);
end;

{  procedure Assign(Source: TPersistent); }
procedure TIcon_Assign(var Value: Variant; Args: TArgs);
begin
  TIcon(Args.Obj).Assign(V2O(Args.Values[0]) as TPersistent);
end;

{  procedure LoadFromStream(Stream: TStream); }
procedure TIcon_LoadFromStream(var Value: Variant; Args: TArgs);
begin
  TIcon(Args.Obj).LoadFromStream(V2O(Args.Values[0]) as TStream);
end;

{  function ReleaseHandle: HICON; }
procedure TIcon_ReleaseHandle(var Value: Variant; Args: TArgs);
begin
  Value := Integer(TIcon(Args.Obj).ReleaseHandle);
end;

{  procedure SaveToStream(Stream: TStream); }
procedure TIcon_SaveToStream(var Value: Variant; Args: TArgs);
begin
  TIcon(Args.Obj).SaveToStream(V2O(Args.Values[0]) as TStream);
end;

{ property Read Handle: HICON }
procedure TIcon_Read_Handle(var Value: Variant; Args: TArgs);
begin
  Value := Integer(TIcon(Args.Obj).Handle);
end;

{ property Write Handle(Value: HICON) }
procedure TIcon_Write_Handle(const Value: Variant; Args: TArgs);
begin
  TIcon(Args.Obj).Handle := Value;
end;


procedure RegisterRAI2Adapter(RAI2Adapter: TRAI2Adapter);
begin
  with RAI2Adapter do
  begin
   { TFontStyle }
    AddConst('Graphics', 'fsBold', fsBold);
    AddConst('Graphics', 'fsItalic', fsItalic);
    AddConst('Graphics', 'fsUnderline', fsUnderline);
    AddConst('Graphics', 'fsStrikeOut', fsStrikeOut);
   { TFontPitch }
    AddConst('Graphics', 'fpDefault', fpDefault);
    AddConst('Graphics', 'fpVariable', fpVariable);
    AddConst('Graphics', 'fpFixed', fpFixed);
   { TPenStyle }
    AddConst('Graphics', 'psSolid', psSolid);
    AddConst('Graphics', 'psDash', psDash);
    AddConst('Graphics', 'psDot', psDot);
    AddConst('Graphics', 'psDashDot', psDashDot);
    AddConst('Graphics', 'psDashDotDot', psDashDotDot);
    AddConst('Graphics', 'psClear', psClear);
    AddConst('Graphics', 'psInsideFrame', psInsideFrame);
   { TPenMode }
    AddConst('Graphics', 'pmBlack', pmBlack);
    AddConst('Graphics', 'pmWhite', pmWhite);
    AddConst('Graphics', 'pmNop', pmNop);
    AddConst('Graphics', 'pmNot', pmNot);
    AddConst('Graphics', 'pmCopy', pmCopy);
    AddConst('Graphics', 'pmNotCopy', pmNotCopy);
    AddConst('Graphics', 'pmMergePenNot', pmMergePenNot);
    AddConst('Graphics', 'pmMaskPenNot', pmMaskPenNot);
    AddConst('Graphics', 'pmMergeNotPen', pmMergeNotPen);
    AddConst('Graphics', 'pmMaskNotPen', pmMaskNotPen);
    AddConst('Graphics', 'pmMerge', pmMerge);
    AddConst('Graphics', 'pmNotMerge', pmNotMerge);
    AddConst('Graphics', 'pmMask', pmMask);
    AddConst('Graphics', 'pmNotMask', pmNotMask);
    AddConst('Graphics', 'pmXor', pmXor);
    AddConst('Graphics', 'pmNotXor', pmNotXor);
   { TBrushStyle }
    AddConst('Graphics', 'bsSolid', bsSolid);
    AddConst('Graphics', 'bsClear', bsClear);
    AddConst('Graphics', 'bsHorizontal', bsHorizontal);
    AddConst('Graphics', 'bsVertical', bsVertical);
    AddConst('Graphics', 'bsFDiagonal', bsFDiagonal);
    AddConst('Graphics', 'bsBDiagonal', bsBDiagonal);
    AddConst('Graphics', 'bsCross', bsCross);
    AddConst('Graphics', 'bsDiagCross', bsDiagCross);
   { TFont }
    AddClass('Graphics', TFont, 'TFont');
    AddGet(TFont, 'Create', TFont_Create, 0, [0]);
    AddGet(TFont, 'Assign', TFont_Assign, 1, [varEmpty]);
    AddGet(TFont, 'Handle', TFont_Read_Handle, 0, [0]);
    AddSet(TFont, 'Handle', TFont_Write_Handle, 0, [0]);
    AddGet(TFont, 'PixelsPerInch', TFont_Read_PixelsPerInch, 0, [0]);
    AddSet(TFont, 'PixelsPerInch', TFont_Write_PixelsPerInch, 0, [0]);
   {$IFDEF RA_D3H}
    AddGet(TFont, 'Charset', TFont_Read_Charset, 0, [0]);
    AddSet(TFont, 'Charset', TFont_Write_Charset, 0, [0]);
   {$ENDIF RA_D3H}
    AddGet(TFont, 'Color', TFont_Read_Color, 0, [0]);
    AddSet(TFont, 'Color', TFont_Write_Color, 0, [0]);
    AddGet(TFont, 'Height', TFont_Read_Height, 0, [0]);
    AddSet(TFont, 'Height', TFont_Write_Height, 0, [0]);
    AddGet(TFont, 'Name', TFont_Read_Name, 0, [0]);
    AddSet(TFont, 'Name', TFont_Write_Name, 0, [0]);
    AddGet(TFont, 'Pitch', TFont_Read_Pitch, 0, [0]);
    AddSet(TFont, 'Pitch', TFont_Write_Pitch, 0, [0]);
    AddGet(TFont, 'Size', TFont_Read_Size, 0, [0]);
    AddSet(TFont, 'Size', TFont_Write_Size, 0, [0]);
    AddGet(TFont, 'Style', TFont_Read_Style, 0, [0]);
    AddSet(TFont, 'Style', TFont_Write_Style, 0, [0]);
   { TPen }
    AddClass('Graphics', TPen, 'TPen');
    AddGet(TPen, 'Create', TPen_Create, 0, [0]);
    AddGet(TPen, 'Assign', TPen_Assign, 1, [varEmpty]);
    AddGet(TPen, 'Handle', TPen_Read_Handle, 0, [0]);
    AddSet(TPen, 'Handle', TPen_Write_Handle, 0, [0]);
    AddGet(TPen, 'Color', TPen_Read_Color, 0, [0]);
    AddSet(TPen, 'Color', TPen_Write_Color, 0, [0]);
    AddGet(TPen, 'Mode', TPen_Read_Mode, 0, [0]);
    AddSet(TPen, 'Mode', TPen_Write_Mode, 0, [0]);
    AddGet(TPen, 'Style', TPen_Read_Style, 0, [0]);
    AddSet(TPen, 'Style', TPen_Write_Style, 0, [0]);
    AddGet(TPen, 'Width', TPen_Read_Width, 0, [0]);
    AddSet(TPen, 'Width', TPen_Write_Width, 0, [0]);
   { TBrush }
    AddClass('Graphics', TBrush, 'TBrush');
    AddGet(TBrush, 'Create', TBrush_Create, 0, [0]);
    AddGet(TBrush, 'Assign', TBrush_Assign, 1, [varEmpty]);
    AddGet(TBrush, 'Bitmap', TBrush_Read_Bitmap, 0, [0]);
    AddSet(TBrush, 'Bitmap', TBrush_Write_Bitmap, 0, [0]);
    AddGet(TBrush, 'Handle', TBrush_Read_Handle, 0, [0]);
    AddSet(TBrush, 'Handle', TBrush_Write_Handle, 0, [0]);
    AddGet(TBrush, 'Color', TBrush_Read_Color, 0, [0]);
    AddSet(TBrush, 'Color', TBrush_Write_Color, 0, [0]);
    AddGet(TBrush, 'Style', TBrush_Read_Style, 0, [0]);
    AddSet(TBrush, 'Style', TBrush_Write_Style, 0, [0]);
   { TFillStyle }
    AddConst('Graphics', 'fsSurface', fsSurface);
    AddConst('Graphics', 'fsBorder', fsBorder);
   { TFillMode }
    AddConst('Graphics', 'fmAlternate', fmAlternate);
    AddConst('Graphics', 'fmWinding', fmWinding);
   { TCanvasStates }
    AddConst('Graphics', 'csHandleValid', csHandleValid);
    AddConst('Graphics', 'csFontValid', csFontValid);
    AddConst('Graphics', 'csPenValid', csPenValid);
    AddConst('Graphics', 'csBrushValid', csBrushValid);
   { TCanvas }
    AddClass('Graphics', TCanvas, 'TCanvas');
    AddGet(TCanvas, 'Create', TCanvas_Create, 0, [0]);
    AddGet(TCanvas, 'Arc', TCanvas_Arc, 8, [varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty]);
    AddGet(TCanvas, 'BrushCopy', TCanvas_BrushCopy, 4, [varEmpty, varEmpty, varEmpty, varEmpty]);
    AddGet(TCanvas, 'Chord', TCanvas_Chord, 8, [varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty]);
    AddGet(TCanvas, 'CopyRect', TCanvas_CopyRect, 3, [varEmpty, varEmpty, varEmpty]);
    AddGet(TCanvas, 'Draw', TCanvas_Draw, 3, [varEmpty, varEmpty, varEmpty]);
    AddGet(TCanvas, 'DrawFocusRect', TCanvas_DrawFocusRect, 1, [varEmpty]);
    AddGet(TCanvas, 'Ellipse', TCanvas_Ellipse, 4, [varEmpty, varEmpty, varEmpty, varEmpty]);
    AddGet(TCanvas, 'FillRect', TCanvas_FillRect, 1, [varEmpty]);
    AddGet(TCanvas, 'FloodFill', TCanvas_FloodFill, 4, [varEmpty, varEmpty, varEmpty, varEmpty]);
    AddGet(TCanvas, 'FrameRect', TCanvas_FrameRect, 1, [varEmpty]);
    AddGet(TCanvas, 'LineTo', TCanvas_LineTo, 2, [varEmpty, varEmpty]);
   {$IFDEF RA_D3H}
    AddGet(TCanvas, 'Lock', TCanvas_Lock, 0, [0]);
   {$ENDIF RA_D3H}
    AddGet(TCanvas, 'MoveTo', TCanvas_MoveTo, 2, [varEmpty, varEmpty]);
    AddGet(TCanvas, 'Pie', TCanvas_Pie, 8, [varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty]);
    AddGet(TCanvas, 'Polygon', TCanvas_Polygon, 1, [varEmpty]);
    AddGet(TCanvas, 'Polyline', TCanvas_Polyline, 1, [varEmpty]);
    AddGet(TCanvas, 'Rectangle', TCanvas_Rectangle, 4, [varEmpty, varEmpty, varEmpty, varEmpty]);
    AddGet(TCanvas, 'Refresh', TCanvas_Refresh, 0, [0]);
    AddGet(TCanvas, 'RoundRect', TCanvas_RoundRect, 6, [varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty]);
    AddGet(TCanvas, 'StretchDraw', TCanvas_StretchDraw, 2, [varEmpty, varEmpty]);
    AddGet(TCanvas, 'TextExtent', TCanvas_TextExtent, 1, [varEmpty]);
    AddGet(TCanvas, 'TextHeight', TCanvas_TextHeight, 1, [varEmpty]);
    AddGet(TCanvas, 'TextOut', TCanvas_TextOut, 3, [varEmpty, varEmpty, varEmpty]);
    AddGet(TCanvas, 'TextRect', TCanvas_TextRect, 4, [varEmpty, varEmpty, varEmpty, varEmpty]);
    AddGet(TCanvas, 'TextWidth', TCanvas_TextWidth, 1, [varEmpty]);
   {$IFDEF RA_D3H}
    AddGet(TCanvas, 'TryLock', TCanvas_TryLock, 0, [0]);
    AddGet(TCanvas, 'Unlock', TCanvas_Unlock, 0, [0]);
   {$ENDIF RA_D3H}
    AddGet(TCanvas, 'ClipRect', TCanvas_Read_ClipRect, 0, [0]);
    AddGet(TCanvas, 'Handle', TCanvas_Read_Handle, 0, [0]);
    AddSet(TCanvas, 'Handle', TCanvas_Write_Handle, 0, [0]);
   {$IFDEF RA_D3H}
    AddGet(TCanvas, 'LockCount', TCanvas_Read_LockCount, 0, [0]);
   {$ENDIF RA_D3H}
    AddGet(TCanvas, 'PenPos', TCanvas_Read_PenPos, 0, [0]);
    AddSet(TCanvas, 'PenPos', TCanvas_Write_PenPos, 0, [0]);
    AddGet(TCanvas, 'Brush', TCanvas_Read_Brush, 0, [0]);
    AddSet(TCanvas, 'Brush', TCanvas_Write_Brush, 0, [0]);
    AddGet(TCanvas, 'CopyMode', TCanvas_Read_CopyMode, 0, [0]);
    AddSet(TCanvas, 'CopyMode', TCanvas_Write_CopyMode, 0, [0]);
    AddGet(TCanvas, 'Font', TCanvas_Read_Font, 0, [0]);
    AddSet(TCanvas, 'Font', TCanvas_Write_Font, 0, [0]);
    AddGet(TCanvas, 'Pen', TCanvas_Read_Pen, 0, [0]);
    AddSet(TCanvas, 'Pen', TCanvas_Write_Pen, 0, [0]);
   {$IFDEF RA_D3H}
   { TProgressStage }
    AddConst('Graphics', 'psStarting', psStarting);
    AddConst('Graphics', 'psRunning', psRunning);
    AddConst('Graphics', 'psEnding', psEnding);
   {$ENDIF RA_D3H}
   { TGraphic }
    AddClass('Graphics', TGraphic, 'TGraphic');
    AddGet(TGraphic, 'LoadFromFile', TGraphic_LoadFromFile, 1, [varEmpty]);
    AddGet(TGraphic, 'SaveToFile', TGraphic_SaveToFile, 1, [varEmpty]);
    AddGet(TGraphic, 'LoadFromStream', TGraphic_LoadFromStream, 1, [varEmpty]);
    AddGet(TGraphic, 'SaveToStream', TGraphic_SaveToStream, 1, [varEmpty]);
    AddGet(TGraphic, 'LoadFromClipboardFormat', TGraphic_LoadFromClipboardFormat, 3, [varEmpty, varEmpty, varEmpty]);
    AddGet(TGraphic, 'SaveToClipboardFormat', TGraphic_SaveToClipboardFormat, 3, [varByRef, varByRef, varByRef]);
    AddGet(TGraphic, 'Empty', TGraphic_Read_Empty, 0, [0]);
    AddGet(TGraphic, 'Height', TGraphic_Read_Height, 0, [0]);
    AddSet(TGraphic, 'Height', TGraphic_Write_Height, 0, [0]);
    AddGet(TGraphic, 'Modified', TGraphic_Read_Modified, 0, [0]);
    AddSet(TGraphic, 'Modified', TGraphic_Write_Modified, 0, [0]);
   {$IFDEF RA_D3H}
    AddGet(TGraphic, 'Palette', TGraphic_Read_Palette, 0, [0]);
    AddSet(TGraphic, 'Palette', TGraphic_Write_Palette, 0, [0]);
    AddGet(TGraphic, 'PaletteModified', TGraphic_Read_PaletteModified, 0, [0]);
    AddSet(TGraphic, 'PaletteModified', TGraphic_Write_PaletteModified, 0, [0]);
    AddGet(TGraphic, 'Transparent', TGraphic_Read_Transparent, 0, [0]);
    AddSet(TGraphic, 'Transparent', TGraphic_Write_Transparent, 0, [0]);
   {$ENDIF RA_D3H}
    AddGet(TGraphic, 'Width', TGraphic_Read_Width, 0, [0]);
    AddSet(TGraphic, 'Width', TGraphic_Write_Width, 0, [0]);
   { TPicture }
    AddClass('Graphics', TPicture, 'TPicture');
    AddGet(TPicture, 'Create', TPicture_Create, 0, [0]);
    AddGet(TPicture, 'LoadFromFile', TPicture_LoadFromFile, 1, [varEmpty]);
    AddGet(TPicture, 'SaveToFile', TPicture_SaveToFile, 1, [varEmpty]);
    AddGet(TPicture, 'LoadFromClipboardFormat', TPicture_LoadFromClipboardFormat, 3, [varEmpty, varEmpty, varEmpty]);
    AddGet(TPicture, 'SaveToClipboardFormat', TPicture_SaveToClipboardFormat, 3, [varByRef, varByRef, varByRef]);
    AddGet(TPicture, 'SupportsClipboardFormat', TPicture_SupportsClipboardFormat, 1, [varEmpty]);
    AddGet(TPicture, 'Assign', TPicture_Assign, 1, [varEmpty]);
    AddGet(TPicture, 'Bitmap', TPicture_Read_Bitmap, 0, [0]);
    AddSet(TPicture, 'Bitmap', TPicture_Write_Bitmap, 0, [0]);
    AddGet(TPicture, 'Graphic', TPicture_Read_Graphic, 0, [0]);
    AddSet(TPicture, 'Graphic', TPicture_Write_Graphic, 0, [0]);
   {$IFDEF RA_D3H}
    AddGet(TPicture, 'PictureAdapter', TPicture_Read_PictureAdapter, 0, [0]);
    AddSet(TPicture, 'PictureAdapter', TPicture_Write_PictureAdapter, 0, [0]);
   {$ENDIF RA_D3H}
    AddGet(TPicture, 'Height', TPicture_Read_Height, 0, [0]);
    AddGet(TPicture, 'Icon', TPicture_Read_Icon, 0, [0]);
    AddSet(TPicture, 'Icon', TPicture_Write_Icon, 0, [0]);
    AddGet(TPicture, 'Metafile', TPicture_Read_Metafile, 0, [0]);
    AddSet(TPicture, 'Metafile', TPicture_Write_Metafile, 0, [0]);
    AddGet(TPicture, 'Width', TPicture_Read_Width, 0, [0]);
   { TMetafile }
    AddClass('Graphics', TMetafile, 'TMetafile');
    AddGet(TMetafile, 'Create', TMetafile_Create, 0, [0]);
    AddGet(TMetafile, 'Clear', TMetafile_Clear, 0, [0]);
    AddGet(TMetafile, 'LoadFromStream', TMetafile_LoadFromStream, 1, [varEmpty]);
    AddGet(TMetafile, 'SaveToFile', TMetafile_SaveToFile, 1, [varEmpty]);
    AddGet(TMetafile, 'SaveToStream', TMetafile_SaveToStream, 1, [varEmpty]);
    AddGet(TMetafile, 'LoadFromClipboardFormat', TMetafile_LoadFromClipboardFormat, 3, [varEmpty, varEmpty, varEmpty]);
    AddGet(TMetafile, 'SaveToClipboardFormat', TMetafile_SaveToClipboardFormat, 3, [varByRef, varByRef, varByRef]);
    AddGet(TMetafile, 'Assign', TMetafile_Assign, 1, [varEmpty]);
   {$IFDEF RA_D3H}
    AddGet(TMetafile, 'ReleaseHandle', TMetafile_ReleaseHandle, 0, [0]);
   {$ENDIF RA_D3H}
    AddGet(TMetafile, 'CreatedBy', TMetafile_Read_CreatedBy, 0, [0]);
    AddGet(TMetafile, 'Description', TMetafile_Read_Description, 0, [0]);
    AddGet(TMetafile, 'Enhanced', TMetafile_Read_Enhanced, 0, [0]);
    AddSet(TMetafile, 'Enhanced', TMetafile_Write_Enhanced, 0, [0]);
    AddGet(TMetafile, 'Handle', TMetafile_Read_Handle, 0, [0]);
    AddSet(TMetafile, 'Handle', TMetafile_Write_Handle, 0, [0]);
    AddGet(TMetafile, 'MMWidth', TMetafile_Read_MMWidth, 0, [0]);
    AddSet(TMetafile, 'MMWidth', TMetafile_Write_MMWidth, 0, [0]);
    AddGet(TMetafile, 'MMHeight', TMetafile_Read_MMHeight, 0, [0]);
    AddSet(TMetafile, 'MMHeight', TMetafile_Write_MMHeight, 0, [0]);
    AddGet(TMetafile, 'Inch', TMetafile_Read_Inch, 0, [0]);
    AddSet(TMetafile, 'Inch', TMetafile_Write_Inch, 0, [0]);
   {$IFDEF RA_D3H}
   { TBitmapHandleType }
    AddConst('Graphics', 'bmDIB', bmDIB);
    AddConst('Graphics', 'bmDDB', bmDDB);
   { TPixelFormat }
    AddConst('Graphics', 'pfDevice', pfDevice);
    AddConst('Graphics', 'pf1bit', pf1bit);
    AddConst('Graphics', 'pf4bit', pf4bit);
    AddConst('Graphics', 'pf8bit', pf8bit);
    AddConst('Graphics', 'pf15bit', pf15bit);
    AddConst('Graphics', 'pf16bit', pf16bit);
    AddConst('Graphics', 'pf24bit', pf24bit);
    AddConst('Graphics', 'pf32bit', pf32bit);
    AddConst('Graphics', 'pfCustom', pfCustom);
   { TTransparentMode }
    AddConst('Graphics', 'tmAuto', tmAuto);
    AddConst('Graphics', 'tmFixed', tmFixed);
   { TBitmap }
   {$ENDIF RA_D3H}
    AddClass('Graphics', TBitmap, 'TBitmap');
    AddGet(TBitmap, 'Create', TBitmap_Create, 0, [0]);
    AddGet(TBitmap, 'Assign', TBitmap_Assign, 1, [varEmpty]);
    AddGet(TBitmap, 'Dormant', TBitmap_Dormant, 0, [0]);
    AddGet(TBitmap, 'FreeImage', TBitmap_FreeImage, 0, [0]);
    AddGet(TBitmap, 'LoadFromClipboardFormat', TBitmap_LoadFromClipboardFormat, 3, [varEmpty, varEmpty, varEmpty]);
    AddGet(TBitmap, 'LoadFromStream', TBitmap_LoadFromStream, 1, [varEmpty]);
    AddGet(TBitmap, 'LoadFromResourceName', TBitmap_LoadFromResourceName, 2, [varEmpty, varEmpty]);
    AddGet(TBitmap, 'LoadFromResourceID', TBitmap_LoadFromResourceID, 2, [varEmpty, varEmpty]);
   {$IFDEF RA_D3H}
    AddGet(TBitmap, 'Mask', TBitmap_Mask, 1, [varEmpty]);
   {$ENDIF RA_D3H}
    AddGet(TBitmap, 'ReleaseHandle', TBitmap_ReleaseHandle, 0, [0]);
   {$IFDEF RA_D3H}
    AddGet(TBitmap, 'ReleaseMaskHandle', TBitmap_ReleaseMaskHandle, 0, [0]);
   {$ENDIF RA_D3H}
    AddGet(TBitmap, 'ReleasePalette', TBitmap_ReleasePalette, 0, [0]);
    AddGet(TBitmap, 'SaveToClipboardFormat', TBitmap_SaveToClipboardFormat, 3, [varByRef, varByRef, varByRef]);
    AddGet(TBitmap, 'SaveToStream', TBitmap_SaveToStream, 1, [varEmpty]);
    AddGet(TBitmap, 'Canvas', TBitmap_Read_Canvas, 0, [0]);
    AddGet(TBitmap, 'Handle', TBitmap_Read_Handle, 0, [0]);
    AddSet(TBitmap, 'Handle', TBitmap_Write_Handle, 0, [0]);
   {$IFDEF RA_D3H}
    AddGet(TBitmap, 'HandleType', TBitmap_Read_HandleType, 0, [0]);
    AddSet(TBitmap, 'HandleType', TBitmap_Write_HandleType, 0, [0]);
   {$ENDIF RA_D3H}
    AddGet(TBitmap, 'IgnorePalette', TBitmap_Read_IgnorePalette, 0, [0]);
    AddSet(TBitmap, 'IgnorePalette', TBitmap_Write_IgnorePalette, 0, [0]);
   {$IFDEF RA_D3H}
    AddGet(TBitmap, 'MaskHandle', TBitmap_Read_MaskHandle, 0, [0]);
   {$ENDIF RA_D3H}
    AddGet(TBitmap, 'Monochrome', TBitmap_Read_Monochrome, 0, [0]);
    AddSet(TBitmap, 'Monochrome', TBitmap_Write_Monochrome, 0, [0]);
   {$IFDEF RA_D3H}
    AddGet(TBitmap, 'PixelFormat', TBitmap_Read_PixelFormat, 0, [0]);
    AddSet(TBitmap, 'PixelFormat', TBitmap_Write_PixelFormat, 0, [0]);
    AddGet(TBitmap, 'ScanLine', TBitmap_Read_ScanLine, 1, [0]);
   {$ENDIF RA_D3H}
    AddGet(TBitmap, 'TransparentColor', TBitmap_Read_TransparentColor, 0, [0]);
   {$IFDEF RA_D3H}
    AddSet(TBitmap, 'TransparentColor', TBitmap_Write_TransparentColor, 0, [0]);
    AddGet(TBitmap, 'TransparentMode', TBitmap_Read_TransparentMode, 0, [0]);
    AddSet(TBitmap, 'TransparentMode', TBitmap_Write_TransparentMode, 0, [0]);
   {$ENDIF RA_D3H}
   { TIcon }
    AddClass('Graphics', TIcon, 'TIcon');
    AddGet(TIcon, 'Create', TIcon_Create, 0, [0]);
    AddGet(TIcon, 'Assign', TIcon_Assign, 1, [varEmpty]);
    AddGet(TIcon, 'LoadFromStream', TIcon_LoadFromStream, 1, [varEmpty]);
    AddGet(TIcon, 'ReleaseHandle', TIcon_ReleaseHandle, 0, [0]);
    AddGet(TIcon, 'SaveToStream', TIcon_SaveToStream, 1, [varEmpty]);
    AddGet(TIcon, 'Handle', TIcon_Read_Handle, 0, [0]);
    AddSet(TIcon, 'Handle', TIcon_Write_Handle, 0, [0]);
   { TFontData }
  end;    { with }
end;    { RegisterRAI2Adapter }

end.
