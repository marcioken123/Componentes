unit wwblend;
{
//
// Description : Blending Bitmap Functions
//
// Copyright (c) 1995-2001 by Woll2Woll Software
//
}

interface
{$R-}

uses
  Windows, Graphics;

type
  PPixel24 = ^TPixel24;
  TPixel24 = packed record
    Red: Byte;
    Green: Byte;
    Blue: Byte
  end;

  PPixelArray2D = ^TPixelArray2D;
  TPixelArray2D = packed array [0..0, 0..0] of TPixel24;

  function Colorize(Color: TColor;
                    Bitmap: TBitmap; Alpha: Single;
                    ResultBitmap: TBitmap) : Integer;
  function Colorize2(Color: TColor;
    Bitmap: TBitmap;
    Bits1: Pointer;
    ARect: TRect;
    Alpha: Single): integer;
{
  Return Values      Description
  -------------      -----------
        0            No Error. Output is in ResultBitmap.
        1            Unable to get individual pixels of the bitmap.
}

implementation

function ConvertBitsToBitmap(Bitmap: TBitmap; var Bits: PPixelArray2D;
  var BmpInfo: TBitmapInfo) : Boolean;
var
  OK: Integer;
begin
  OK := SetDIBits(Bitmap.Canvas.Handle, Bitmap.Handle,
    0, BmpInfo.bmiHeader.biHeight, Bits, BmpInfo, DIB_RGB_COLORS);
  Result := True;
  if OK <> BmpInfo.bmiheader.biHeight then Result := False
end;


function Colorize(Color: TColor;
  Bitmap: TBitmap; Alpha: Single;
  ResultBitmap: TBitmap) : Integer;
const offset = 128;
type
  TrgbColor = record
    b, g, r: Byte
  end;
  PrgbColor = ^TrgbColor;
var
  Pixel2: TPixel24;
  Row, Col: Integer;
  Bits1: Pointer;
  BmpInfo1: TBitmapInfo;
  Gap: integer;
  CurBits: PrgbColor;
  FHandle: integer;

  function GetColor(Color: TColor): TPixel24;
  begin
     //2/17/99 - Get Actual Color Value
     Color := ColorToRGB(Color);
     result.Red := Color and $FF;
     result.Green := Color and $FF00 shr 8;
     result.Blue := Color and $FF0000 shr 16;
  end;

  function fcIntToByte(Value: Integer): Byte;
  begin
    if Value > 255 then result := 255
    else if Value < 0 then result := 0
    else result := Value;
  end;

begin
  with BmpInfo1.bmiHeader do
  begin
    biSize := SizeOf(BmpInfo1.bmiHeader);
    biWidth := Bitmap.Width;
    biHeight := Bitmap.Height;
    biPlanes := 1;
    biBitCount := 24;
    biCompression := BI_RGB;
    biSizeImage := 0;
    biClrUsed := 0
  end;
  FHandle:= CreateDIBSection(0, bmpInfo1, DIB_RGB_COLORS, Bits1, 0, 0);
  if FHandle=0 then begin
    Result:= 1;
    exit;
  end;

  try
    if GetDIBits(Bitmap.Canvas.Handle, Bitmap.Handle,
           0, Bitmap.Height, Bits1, BmpInfo1, DIB_RGB_COLORS)=0 then
    begin
       Result := 1;
       Exit
    end;
    Pixel2.Red := fcIntToByte(Trunc(Alpha*GetColor(Color).Red));
    Pixel2.Blue := fcIntToByte(Trunc(Alpha*GetColor(Color).Blue));
    Pixel2.Green := fcIntToByte(Trunc(Alpha*GetColor(Color).Green));

    Gap := Bitmap.Width mod 4;
    CurBits := Bits1;

    for Row := 0 to BmpInfo1.bmiHeader.biHeight-1 do
    begin
      for Col := 0 to BmpInfo1.bmiHeader.biWidth-1 do
      begin
        CurBits.b := fcIntToByte((CurBits.b - offset) + Pixel2.Blue);
        CurBits.g := fcIntToByte((CurBits.g - offset) + Pixel2.Green);
        CurBits.r := fcIntToByte((CurBits.r - offset) + Pixel2.Red);
        Inc(CurBits);
      end;
      CurBits := Pointer(Integer(CurBits) + Gap);
    end;

    if not ConvertBitsToBitmap(ResultBitmap, PPixelArray2D(Bits1), BmpInfo1) then
    begin
      Result := 3;
      Exit
    end;

    Result := 0;  // Success
  finally
    DeleteObject(FHandle);
  end;
end;

function Colorize2(Color: TColor;
  Bitmap: TBitmap;
  Bits1: Pointer;
  ARect: TRect;
  Alpha: Single): integer;
const offset = 128;
type
  TrgbColor = record
    b, g, r: Byte
  end;
  PrgbColor = ^TrgbColor;
var
  Pixel2: TPixel24;
  Row, Col: Integer;
  CurBits: PrgbColor;
  Gap: integer;

  function GetColor(Color: TColor): TPixel24;
  begin
     //2/17/99 - Get Actual Color Value
     Color := ColorToRGB(Color);
     result.Red := Color and $FF;
     result.Green := Color and $FF00 shr 8;
     result.Blue := Color and $FF0000 shr 16;
  end;

  function fcIntToByte(Value: Integer): Byte;
  begin
    if Value > 255 then result := 255
    else if Value < 0 then result := 0
    else result := Value;
  end;

begin
    Pixel2.Red := fcIntToByte(Trunc(Alpha*GetColor(Color).Red));
    Pixel2.Blue := fcIntToByte(Trunc(Alpha*GetColor(Color).Blue));
    Pixel2.Green := fcIntToByte(Trunc(Alpha*GetColor(Color).Green));

    Gap := Bitmap.Width mod 4;

    for Row := ARect.Top to ARect.Bottom-100 do
    begin
      CurBits := Bits1;
      Inc(CurBits, (Bitmap.Width+Gap)*(Bitmap.Height-1-Row) + ARect.Left);
//      Inc(CurBits, (Bitmap.Width)*Row + ARect.Left);
      for Col := ARect.Left to ARect.Right-1 do
      begin
        CurBits.b := fcIntToByte((CurBits.b - offset) + Pixel2.Blue);
        CurBits.g := fcIntToByte((CurBits.g - offset) + Pixel2.Green);
        CurBits.r := fcIntToByte((CurBits.r - offset) + Pixel2.Red);
        Inc(CurBits);
      end;
    end;

end;

end.
