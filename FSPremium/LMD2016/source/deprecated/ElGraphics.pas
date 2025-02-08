unit ElGraphics;
{$I lmdcmps.inc}
{###############################################################################

ElGraphics unit
---------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

// Fast access to TBitmap pixels
// © Boris Novgorodov, Novosibirsk, mbo@mail.ru
// Alexey Radionov, Ulyanovsk
// 2003

interface

uses
  Windows, SysUtils, Math, Types, Classes,
  {$ifdef CLR} System.Drawing, System.Drawing.Drawing2D, {$endif}
  Graphics;

type
  TColorRGB = packed record
    R, G, B, A: Byte;
  end;
  PColorRGB = ^TColorRGB;

  // for 32bit bitmaps
  PColorBGRA = ^TColorBGRA;
  TColorBGRA = packed record
    Blue: Byte;
    Green: Byte;
    Red: Byte;
    Alpha: Byte;
  end;

  TLogPal = record
    palVersion: Word;
    palNumEntries: Word;
    palPalEntry: array[0..255] of TPaletteEntry;
  end;

  TSetPixelsMethod = procedure(X, Y: Integer; const Value: TColor) of object; register;
  TGetPixelsMethod = function(X, Y: Integer): TColor of object; register;

  TElFastBitmap = class
  private
    FBitmap: TBitmap;
    FWidth, FHeight: Integer;
    FBPP: Integer;
    {$ifndef CLR}
    FStart: Integer;
    FDelta: Integer;
    {$endif}
    FPixelFormat: TPixelFormat;
    FHPal: HPalette;
    {$ifndef CLR}
    FLogPal: TLogPal;
    FLastIndex: Integer;
    FLastColor: TColor;
    {$endif}
    FByPaletteIndex: Boolean;
    FTrackBitmapChange: Boolean;

    function GetPixels(X, Y: Integer): TColor;
    {$ifndef CLR}
    function GetPixels8(X, Y: Integer): TColor;
    function GetPixels8Index(X, Y: Integer): TColor;
    function GetPixels15(X, Y: Integer): TColor;
    function GetPixels16(X, Y: Integer): TColor;
    function GetPixels24(X, Y: Integer): TColor;
    function GetPixels32(X, Y: Integer): TColor;
    {$endif}

    procedure SetPixels(X, Y: Integer; const Value: TColor);
    {$ifndef CLR}
    procedure SetPixels8(X, Y: Integer; const Value: TColor);
    procedure SetPixels8Index(X, Y: Integer; const Value: TColor);
    procedure SetPixels15(X, Y: Integer; const Value: TColor);
    procedure SetPixels16(X, Y: Integer; const Value: TColor);
    procedure SetPixels24(X, Y: Integer; const Value: TColor);
    procedure SetPixels32(X, Y: Integer; const Value: TColor);
    {$endif}

    procedure SetBPP(const Value: Integer);
    procedure SetByPaletteIndex(const Value: Boolean);
    procedure SetTrackBitmapChange(const Value: Boolean);
    procedure BitmapChange(Sender: TObject);
  public
    SetPixel: TSetPixelsMethod;
    GetPixel: TGetPixelsMethod;

    constructor Create(ABitmap: TBitmap); overload;

    //установка соединени€ объекта с растром (DIB!)
    procedure Attach(Bmp: TBitmap);

    //вспомог. функци€ дл€ получени€ цвета из палитры
    function PalIndex(const Color: TColor): Integer;
    destructor Destroy; override;

    property Width: Integer read FWidth;
    property Height: Integer read FHeight;

    //BitsPerPixel
    property BPP: Integer read FBPP;

   //при установке в True дл€ режимов с палитрой вместо цвета работа идет с
   //индексом цвета в палитре
    property ByPaletteIndex: Boolean read FByPaletteIndex write
      SetByPaletteIndex;

    //основное свойство дл€ доступа к растру
    property Pixels[X, Y: Integer]: TColor read GetPixels write SetPixels;
    default;

    //позвол€ет отслеживать изменени€ критических дл€ доступа параметров растра:
    //размеров и цветового формата
    property TrackBitmapChange: Boolean read FTrackBitmapChange write
      SetTrackBitmapChange;
  end;

procedure ElDrawSmoothLine(ABitmap: TBitmap; AX1: Integer; AY1: Integer; AX2: Integer; AY2: Integer; AColor: TColor);
procedure DrawAntiAliasedLine(Canvas: TCanvas; x1, y1, x2, y2: Integer; color: tcolor; AWidth: Integer = 1);

implementation

{ TElFastBitmap }

constructor TElFastBitmap.Create(ABitmap: TBitmap);
begin
  inherited Create;
  Attach(ABitmap);
end;

procedure TElFastBitmap.Attach(Bmp: TBitmap);
{$IFDEF CLR}
// ToDo Alex
begin
end;
{$ELSE}
var
  DS: TDibSection;
begin
  FBPP := 0;
  FBitmap := Bmp;
  FWidth := FBitmap.Width;
  FHeight := FBitmap.Height;
  FPixelFormat := FBitmap.PixelFormat;
  case FPixelFormat of
    // дл€ подобных режимов все просто
    pf8bit: SetBPP(8);
    pf15bit: SetBPP(15);
    pf16bit: SetBPP(16);
    pf24bit: SetBPP(24);
    pf32bit: SetBPP(32);
    pfDevice, pfCustom:
    // а здесь проведем небольшое исследование
      begin
        if GetObject(FBitmap.Handle, SizeOf(DS), {$IFNDEF CLR}@{$ENDIF}DS) > 0 then
        // получим информационный заголовок растра
          with DS, dsBmih do
            case biBitCount of
              16: case biCompression of
                  BI_RGB: SetBPP(15);
                  BI_BITFIELDS:
        // анализируем стандартные маски доступа к цветовым составл€ющим
                    begin
                      if dsBitFields[1] = $7E0 then
                        SetBPP(16);
                      if dsBitFields[1] = $3E0 then
                        SetBPP(15);
                    end;
                end;
              32: case biCompression of
                  BI_RGB: SetBPP(32);
                  BI_BITFIELDS: if dsBitFields[1] = $FF0000 then
                      SetBPP(32);
                end;
            end;
      end;
  end;
  Assert(FBPP > 0, 'Bitmap format is not supported');
  if FHPal <> 0 then
    DeleteObject(FHPal);
  if FBPP <= 8 then
  begin
    //скопируем палитру во внутреннее поле, чтобы не обращатьс€ к FBitmap:
    FLogPal.palVersion := $300;
    FLogPal.palNumEntries := 1 shl FBPP;
    GetPaletteEntries(FBitmap.Palette, 0, FLogPal.palNumEntries,
      FLogPal.palPalEntry[0]);
    // создадим дл€ данной логической палитры и HPalette, что нам потребуетс€
    //при поиске ближайшего цвета
    FHPal := CreatePalette(PLogPalette(@FLogPal)^);
    FLastColor := $7FFFFFF;
  end;
  //базовый адрес блока данных
  FStart := Integer(FBitmap.Scanline[0]);
  //разность между адресами соседних строк развертки растра (обычно отриц.)
  FDelta := Integer(FBitmap.Scanline[1]) - FStart;
  if FTrackBitmapChange then
    FBitmap.OnChange := BitmapChange;
end;
{$ENDIF}

destructor TElFastBitmap.Destroy;
begin
  DeleteObject(FHPal);
  inherited;
end;

{$ifndef CLR}
procedure TElFastBitmap.SetPixels8(X, Y: Integer; const Value: TColor);
asm
  push ebx
  push esi
  imul ecx,[eax].FDelta
  mov esi,[ebp+8]  //Value
  add ecx,[eax].FStart    //FStart + FDelta * Y
  cmp esi,[eax].FLastColor
  jz @@TheSame
  mov [eax].FLastColor,esi  //запомним цвет
  push ecx
  push edx
  push eax
  push esi
  mov eax,[eax].FHPal
  push eax
  //сохран€ем регистры, нужные дл€ вызова функции параметра укладываем в стек
  //в пор€дке, необходимом дл€ соглашени€ stdcall
  call GetNearestPaletteIndex
  mov ebx,eax  //результат функции - индекс цвета
  pop eax
  pop edx
  pop ecx
  mov [eax].FLastIndex,ebx  //запомним индекс последнего цвета
  jmp @@SetCol
@@TheSame:
  mov ebx,[eax].FLastIndex
  //цвет с прошлого вызова осталс€ таким же, индекс его уже хранитс€ в поле FLastIndex
@@SetCol:
  pop esi
  mov [ecx+edx],bl
  //запишем байт индекса по вычисленному ранее адресу + X
  pop ebx
end;
{$ENDIF}
{$ifndef CLR}
procedure TElFastBitmap.SetPixels8Index(X, Y: Integer; const Value: TColor);
asm
  imul ecx,[eax].FDelta
  add ecx,[eax].FStart
  mov eax,[ebp+8]
  mov [ecx+edx], al   //PByte(FStart + FDelta * Y + X)^ := Value (т.е. индекс)
end;
{$ENDIF}

{$ifndef CLR}
procedure TElFastBitmap.SetPixels15(X, Y: Integer; const Value: TColor);
//PWord(FStart + FDelta * Y + (X Shl 1))^ :=
//((Value And $F8) Shl 7) or ((Value And $F800) Shr 6) or
//((Value And $FF0000) Shr 19);
asm
  imul ecx,[eax].FDelta
  add ecx,[eax].FStart
  mov eax,[ebp+$08]  //Value
  push esi
  mov esi,eax        //Self
  and esi, $F8       //маска
  shl esi, 7
  push edi
  mov edi,eax
  and edi, $F800
  shr edi, 6
  or esi,edi
  pop edi
  and eax, $FF0000
  shr eax, 19
  or eax,esi
  mov [ecx+edx*2],ax
  pop esi
end;
{$ENDIF}

{$ifndef CLR}
procedure TElFastBitmap.SetPixels16(X, Y: Integer; const Value: TColor);
//PWord(FStart + FDelta * Y + (X Shl 1))^ :=
//((Value And $F8) Shl 8) or ((Value And $FC00) Shr 5)
//or ((Value And $FF0000) Shr 19);
asm
  imul ecx,[eax].FDelta
  add ecx,[eax].FStart
  mov eax,[ebp+$08]  //Value
  push esi
  mov esi,[ebp+$08]
  and esi, $F8       //маска
  shl esi, 8
  push edi
  mov edi,[ebp+$08]
  and edi, $FC00
  shr edi, 5
  or esi,edi
  pop edi
  and eax, $FF0000
  shr eax, 19
  or eax,esi
  mov [ecx+edx*2],ax
  pop esi
end;
{$ENDIF}

{$ifndef CLR}
procedure TElFastBitmap.SetPixels24(X, Y: Integer; const Value: TColor);
//PRGBTriple(FStart + FDelta * Y + 3 * X)^ := PRGBTriple(@i)^
asm
  imul ecx,[eax].FDelta
  add ecx,[eax].FStart
  lea edx,[edx+edx*2]
  mov eax,[ebp+8]  //Value
  bswap eax
  shr eax, 8
  mov [ecx+edx],ax
  shr eax, 16
  mov [ecx+edx+2],al
end;
{$ENDIF}

{$ifndef CLR}
procedure TElFastBitmap.SetPixels32(X, Y: Integer; const Value: TColor);
//PInteger(FStart + FDelta * Y + (X Shl 2))^ := SwappedValue
asm
  imul ecx,[eax].FDelta
  add ecx,[eax].FStart
  mov eax, Value
  bswap eax
  shr eax, 8
  mov [ecx+4*edx],eax
end;
{$ENDIF}

procedure TElFastBitmap.SetPixels(X, Y: Integer; const Value: TColor);
begin
  if (X < FBitmap.Width) and (Y < FBitmap.Height) then
    SetPixel(X, Y, Value);
end;

function TElFastBitmap.GetPixels(X, Y: Integer): TColor;
begin
  Result := clNone;
  if (X < FBitmap.Width) and (Y < FBitmap.Height) then
    Result := GetPixel(X, Y);
end;

procedure TElFastBitmap.SetBPP(const Value: Integer);
{$IFDEF CLR}
// ToDo Alex
begin
end;
{$ELSE}
begin
  FBPP := Value;
  case FBPP of
    8: if FByPaletteIndex then
      begin
        SetPixel := SetPixels8Index;
        GetPixel := GetPixels8Index;
      end
      else
      begin
        SetPixel := SetPixels8;
        GetPixel := GetPixels8;
      end;
    15:
      begin
        SetPixel := SetPixels15;
        GetPixel := GetPixels15;
      end;
    16:
      begin
        SetPixel := SetPixels16;
        GetPixel := GetPixels16;
      end;
    24:
      begin
        SetPixel := SetPixels24;
        GetPixel := GetPixels24;
      end;
    32:
      begin
        SetPixel := SetPixels32;
        GetPixel := GetPixels32;
      end;
  end;
end;
{$ENDIF}

procedure TElFastBitmap.SetByPaletteIndex(const Value: Boolean);
begin
  if Value <> FByPaletteIndex then
  begin
    FByPaletteIndex := Value;
    SetBPP(FBPP); //переназначение метода доступа
  end;
end;

function TElFastBitmap.PalIndex(const Color: TColor): Integer;
{$IFDEF CLR}
// ToDo Alex
begin
  Result := 0;
end;
{$ELSE}
asm
  push edx
  mov eax,[eax].FHPal
  push eax
  call GetNearestPaletteIndex
end;
{$ENDIF}

{$ifndef CLR}
function TElFastBitmap.GetPixels15(X, Y: Integer): TColor;
asm
  imul ecx,[eax].FDelta
  add ecx,[eax].FStart
  movzx eax,word ptr [ecx+2*edx]  //PWord(FStart + FDelta * Y + (X * 2))^
  mov ecx,eax
  and ecx,$1F       //5 бит Blue
  imul ecx,541052   //масштабирование
  mov edx,eax
  and ecx,$FF0000   //маска Blue
  and edx,$3E0      //5 бит Green
  imul edx,135263
  and eax,$7C00
  shr edx,11
  imul eax,135263    //Red
  and edx,$FF00     //маска Green
  shr eax,24
  or eax,ecx
  or eax,edx
end;
{$ENDIF}

{$ifndef CLR}
function TElFastBitmap.GetPixels16(X, Y: Integer): TColor;
asm
  imul ecx,[eax].FDelta
  add ecx,[eax].FStart
  movzx eax,word ptr [ecx+2*edx] //PWord(FStart + FDelta * Y + (X * 2))^
  mov ecx,eax
  and ecx,$1F
  imul ecx,541052
  and ecx,$FF0000
  mov edx,eax
  and edx,$7E0
  imul edx,135263
  shr edx,12
  and eax,$F800
  and edx,$FF00
  imul eax,135263
  shr eax,24
  or eax,ecx
  or eax,edx
end;
{$ENDIF}

{$ifndef CLR}
function TElFastBitmap.GetPixels24(X, Y: Integer): TColor;
//PRGBTriple(@i)^ := PRGBTriple(FStart + FDelta * Y + 3 * X)^;
asm
  imul ecx,[eax].FDelta
  add ecx,[eax].FStart
  add ecx,edx
  movzx eax,WORD PTR [ecx+2*edx]
  bswap eax
  shr eax,8
  movzx ecx, BYTE PTR [ecx+2*edx+2]
  or eax,ecx
end;
{$ENDIF}

{$ifndef CLR}
function TElFastBitmap.GetPixels32(X, Y: Integer): TColor;
//SwappedValue := PInteger(FStart + FDelta * Y + 4 * X )^;
asm
  imul ecx,[eax].FDelta
  add ecx,[eax].FStart
  mov eax,[ecx + 4 * edx]
  bswap eax
  shr eax, 8
end;
{$ENDIF}

{$ifndef CLR}
function TElFastBitmap.GetPixels8(X, Y: Integer): TColor;
asm
  imul ecx, [eax].FDelta
  add ecx, [eax].FStart  //в ECX теперь номер цвета в палитре
  movzx ecx, BYTE PTR [ecx+edx]
  mov eax, DWORD PTR [eax+ecx*4+4].FLogPal
end;
{$ENDIF}

{$ifndef CLR}
function TElFastBitmap.GetPixels8Index(X, Y: Integer): TColor;
asm
  imul ecx,[eax].FDelta
  add ecx,[eax].FStart
  movzx eax, BYTE PTR [ecx+edx]
end;
{$ENDIF}

procedure TElFastBitmap.SetTrackBitmapChange(const Value: Boolean);
begin
  FTrackBitmapChange := Value;
  if Assigned(FBitmap) then
    if FTrackBitmapChange then
      FBitmap.OnChange := BitmapChange
    else
      FBitmap.OnChange := nil;
end;

procedure TElFastBitmap.BitmapChange(Sender: TObject);
begin
  if (FBitmap.Width <> FWidth) or (FBitmap.Height <> FHeight) or
    (FBitmap.PixelFormat <> FPixelFormat) then
      Attach(FBitmap);
end;

function AlphaPixel(ASrcColor, ADstColor: TColor; AAlphaLevel: Double): TColor;
{$IFDEF CLR}
begin
  Result := clNone;
end;
{$ELSE}
begin
   Result := clNone;
   AAlphaLevel := 1 - AAlphaLevel;
   with PColorRGB(@Result)^ do
   begin
     R := Round(PColorRGB(@ASrcColor)^.R * AAlphaLevel + ((1 - AAlphaLevel) * PColorRGB(@ADstColor)^.R));
     G := Round(PColorRGB(@ASrcColor)^.G * AAlphaLevel + ((1 - AAlphaLevel) * PColorRGB(@ADstColor)^.G));
     B := Round(PColorRGB(@ASrcColor)^.B * AAlphaLevel + ((1 - AAlphaLevel) * PColorRGB(@ADstColor)^.B));
     A := 0;
   end;
   Result := ColorToRGB(Result);
end;
{$ENDIF}

procedure ElDrawSmoothLine(ABitmap: TBitmap; AX1: Integer; AY1: Integer; AX2: Integer; AY2: Integer; AColor: TColor);
var
{$ifdef CLR}
  LGraph: System.Drawing.Graphics;
  LRGB: Integer;
{$else}
  x1, y1, x2, y2: Double;
  grad : Double;
  xd : Double;
  yd : Double;
  xgap : Double;
  xend : Double;
  yend : Double;
  yf : Double;
  brightness1 : Double;
  brightness2 : Double;
  x : Integer;
  ix1 : Integer;
  ix2 : Integer;
  iy1 : Integer;
  iy2 : Integer;
  WasExchange : Boolean;
  TmpReal : Double;
  LQuickPxl: TElFastBitmap;
{$endif}
begin
{$ifdef CLR}
  LGraph := System.Drawing.Graphics.FromHDC(IntPtr(Longint(ABitmap.Canvas.Handle)));
  LGraph.SmoothingMode := SmoothingMode.AntiAlias;
  LRGB := ColorToRGB(AColor);
  LGraph.DrawLine(System.Drawing.Pen.Create(System.Drawing.Color.FromARGB(GetRValue(LRGB),GetGValue(LRGB),GetBValue(LRGB))),
                  AX1, AY1, AX2, AY2);
  LGraph.Free;
{$else}
  x1 := AX1;
  y1 := AY1;
  x2 := AX2;
  y2 := AY2;
  AColor := ColorToRGB(AColor);
  LQuickPxl := TElFastBitmap.Create(ABitmap);
  try
    xd := x2 - x1;
    yd := y2 - y1;
    if (xd = 0) and (yd = 0) then
      Exit;

    if Abs(xd) > Abs(yd) then
      WasExchange := False
    else
    begin
      WasExchange := True;
      TmpReal := x1;
      x1 := y1;
      y1 := TmpReal;
      TmpReal := x2;
      x2 := y2;
      y2 := TmpReal;
      TmpReal := xd;
      xd := yd;
      yd := TmpReal;
    end;
    if x1 > x2 then
    begin
      TmpReal := x1;
      x1 := x2;
      x2 := TmpReal;
      TmpReal := y1;
      y1 := y2;
      y2 := TmpReal;
      xd := x2-x1;
      yd := y2-y1;
    end;
    grad := yd / xd;
    xend := Floor(x1 + 0.5);
    yend := y1 + grad * (xend-x1);
    xgap := 1 - Frac(x1 + 0.5);
    ix1 := Floor(x1 + 0.5);
    iy1 := Floor(yend);
    brightness1 := (1 - Frac(yend)) * xgap;
    brightness2 := Frac(yend) * xgap;
    if WasExchange then
    begin
      LQuickPxl[iy1, ix1] := AlphaPixel(LQuickPxl[iy1, ix1], AColor, Brightness1);
      LQuickPxl[iy1 + 1, ix1] :=  AlphaPixel(LQuickPxl[iy1 + 1, ix1], AColor, Brightness2);
    end
    else
    begin
      LQuickPxl[ix1, iy1] := AlphaPixel(LQuickPxl[ix1, iy1], AColor, Brightness1);
      LQuickPxl[ix1, iy1 + 1] := AlphaPixel(LQuickPxl[ix1, iy1 + 1], AColor, Brightness2);
    end;
    yf := yend + grad;
    xend := Floor(x2 + 0.5);
    yend := y2 + grad * (xend - x2);
    xgap := 1 - Frac(x2 - 0.5);
    ix2 := Floor(x2 + 0.5);
    iy2 := Floor(yend);
    brightness1 := (1 - Frac(yend)) * xgap;
    brightness2 := Frac(yend) * xgap;

    if WasExchange then
    begin
      LQuickPxl[iy2, ix2] := AlphaPixel(LQuickPxl[iy1, ix1], AColor, Brightness1);
      LQuickPxl[iy2 + 1, ix2] :=  AlphaPixel(LQuickPxl[iy2 + 1, ix2], AColor, Brightness2);
    end
    else
    begin
      LQuickPxl[ix2, iy2] := AlphaPixel(LQuickPxl[iy1, ix1], AColor, Brightness1);
      LQuickPxl[ix2, iy2 + 1] :=  AlphaPixel(LQuickPxl[ix2, iy2 + 1], AColor, Brightness2);
    end;

    x := ix1 + 1;

    while x <= ix2 - 1 do
    begin
      brightness1 := 1 - Frac(yf);
      brightness2 := Frac(yf);
      if WasExchange then
      begin
        LQuickPxl[Floor(yf), x] :=  AlphaPixel(LQuickPxl[Floor(yf), x], AColor, Brightness1);
        LQuickPxl[Floor(yf) + 1, x] := AlphaPixel(LQuickPxl[Floor(yf) + 1, x], AColor, Brightness2);
      end
      else
      begin
        LQuickPxl[x, Floor(yf)] := AlphaPixel(LQuickPxl[x, Floor(yf)], AColor, Brightness1);
        LQuickPxl[x, Floor(yf) + 1] := AlphaPixel(LQuickPxl[x, Floor(yf) + 1], AColor, Brightness2);
      end;
      yf := yf + grad;
      Inc(x);
    end;
  finally
    LQuickPxl.Free;
  end;
{$endif}
end;

procedure DrawAntiAliasedLine(Canvas: TCanvas; x1, y1, x2, y2: Integer; color: tcolor; AWidth: Integer = 1);
{$IFDEF CLR}
// ToDo Alex
begin
end;
{$ELSE}

type
  TIntArray = array[0..0] of integer;
  PIntArray = ^TIntArray;

var
  i: integer;
  ly, lx: Integer;
  CurrentX, CurrentY: Single;
  deltax, deltay: Single;
  l: Single;
  skipl: single;
  Bitmap: TBitmap;

function CrossFadeColor(FromColor, ToColor : TColor; Rate : Single) : TColor;
var
  r, g, b : byte;
begin
  r := Round(GetRValue(FromColor) * Rate + GetRValue(ToColor) * (1 - Rate));
  g := Round(GetGValue(FromColor) * Rate + GetGValue(ToColor) * (1 - Rate));
  b := Round(GetBValue(FromColor) * Rate + GetBValue(ToColor) * (1 - Rate));
  Result := RGB(b, g, r);
end;

procedure HPixel(x : single; y : integer);
var
  FadeRate : single;
  i: integer;
begin
  FadeRate:=x-trunc(x);
  with Bitmap do
  begin
    if (x >= 0) and (y >= 0) and (Height > y) and (Width > x) then
      PIntArray(bitmap.ScanLine[y])[trunc(x)] := CrossFadeColor(Color, PIntArray(bitmap.ScanLine[y])[trunc(x)], 1 - FadeRate);

    for I := 1 to AWidth - 1 do
    begin
      if (trunc(x) + I >= 0) and (y >= 0) and (Height > y) and (Width > trunc(x) + I) then
        PIntArray(bitmap.ScanLine[y])[trunc(x) + I] := RGB(GetBValue(Color), GetGValue(Color), GetRValue(Color));
    end;

    if (trunc(x) + AWidth >= 0) and (y >= 0) and (Height > y) and (Width > trunc(x) + AWidth) then
      PIntArray(bitmap.ScanLine[y])[trunc(x) + AWidth] := CrossFadeColor(Color, PIntArray(bitmap.ScanLine[y])[trunc(x) + AWidth], FadeRate);
  end;
end;

procedure VPixel(x : integer; y : single);
var
  FadeRate: single;
  i: Integer;
begin
  FadeRate := y - trunc(y);
  with bitmap do
  begin
    if (x >= 0) and (trunc(y) >= 0) and (height > trunc(y)) and (width > x) then
      PIntArray(bitmap.ScanLine[trunc(y)])[x] := CrossFadeColor(Color, PIntArray(bitmap.ScanLine[trunc(y)])[x], 1 - FadeRate);

    for I := 1 to AWidth - 1 do
    begin
      if (x >= 0) and (trunc(y) + I >= 0) and (height > trunc(y) + I) and (width > x) then
        PIntArray(bitmap.ScanLine[trunc(y) + I])[x] := RGB(GetBValue(Color), GetGValue(Color), GetRValue(Color));
    end;

    if (x >= 0) and (trunc(y) + AWidth >= 0) and (height > trunc(y) + AWidth) and (width > x) then
      PIntArray(bitmap.ScanLine[trunc(y) + AWidth])[x] := CrossFadeColor(Color, PIntArray(bitmap.ScanLine[trunc(y) + AWidth])[x], FadeRate);
  end;
end;

begin
  Canvas.Lock;
  try
    Bitmap := TBitmap.Create;
    if (x1 <> x2) or (y1 <> y2) then
    begin
      bitmap.PixelFormat := pf32Bit;
      currentx := x1;
      currenty := y1;
      lx := abs(x2 - x1);
      ly := abs(y2 - y1);

      Bitmap.Width := Round(lx);
      Bitmap.Height := Round(ly);

      Bitmap.Canvas.CopyRect(Rect(0, 0, Bitmap.Width, Bitmap.Height), Canvas, Rect(Min(X1, X2), Min(Y1, Y2), Max(X2, X1), Max(Y2, Y1)));

      if lx > ly then
      begin
        l := trunc(lx);
        deltay := (y2 - y1) / l;
        if x1 > x2 then
        begin
          deltax := -1;
          skipl := (currentx - trunc(currentx));
        end else
        begin
          deltax := 1;
          skipl := 1 - (currentx - trunc(currentx));
        end;
      end
      else
      begin
        l := trunc(ly);
        deltax := (x2 - x1) / l;
        if y1 > y2 then
        begin
          deltay := -1;
          skipl := (currenty - trunc(currenty));
        end
        else
        begin
          deltay := 1;
          skipl := 1 - (currenty - trunc(currenty));
        end;
      end;

      currentx := currentx + deltax * skipl;
      currenty := currenty + deltay * skipl;{}

      for i := 1 to trunc(l) do
      begin
        if lx > ly then
          VPixel(trunc(currentx), currenty)
        else
          HPixel(currentx, trunc(currenty));
        currentx := currentx + deltax;
        currenty := currenty + deltay;
      end;
    Canvas.Unlock;
    Canvas.CopyRect(Rect(Min(X1, X2), Min(Y1, Y2), Max(X2, X1), Max(Y2, Y1)), Bitmap.Canvas, Rect(0, 0, Bitmap.Width, Bitmap.Height));
    Canvas.Lock;
    end;
  finally
    Bitmap.Free;
    Canvas.Unlock;
  end;
end;
{$ENDIF}

end.
