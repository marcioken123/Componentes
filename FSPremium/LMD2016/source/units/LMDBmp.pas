unit LMDBmp;
{$I lmdcmps.INC}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMDBmp unit ()
--------------
Contains bitmap manipulating routines
NOTE : all procedure are optimized for 24 Bit only!!

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Graphics
  ;

type
  ELMDWrongPixelFormat = class (Exception);
  ELMDWrongBmpSize = class (Exception);
  TLMDBrightness = -255..255;

  TLMDStepRGB = packed record
    r, g, b : Byte;
  end;
  PLMDStepRGB = ^TLMDStepRGB;
  PLMDStepArray = ^TLMDStepArray;
  TLMDStepArray = array[1..11000] of TLMDStepRGB;
  TLMDRGB = Record
    case Integer of
     0: (R, G, B, further : Byte);
     1 : ( all : LongInt);
  end;

  TLMDProgressEvent = procedure(RowNum: integer) of object;

  //grayscales a bitmap
  procedure LMDBmpGrayScale (bmp : TBitmap; const bmpRect : TRect;
    target : TBitmap; const targetPt : TPoint);
  //flips a bitmap horizontally
  procedure LMDBmpFlipHorizontal(bmp : TBitmap; const bmpRect : TRect; target : TBitmap; const targetPt : TPoint);overload;
  procedure LMDBmpFlipHorizontal(ASource: TBitmap; ATarget: TBitmap); overload;
  //flips a bitmap vertically
  procedure LMDBmpFlipVertical(bmp : TBitmap; bmpRect : TRect; target : TBitmap; const targetPt : TPoint);overload;
  procedure LMDBmpFlipVertical(ASource: TBitmap; ATarget: TBitmap); overload;
  // Rotate bitmap routines
  procedure LMDBmpRotate(const ASource: TBitmap; var ADest: TBitmap; AAngle: Real); overload;
  procedure LMDBmpRotate(const ASource: TBitmap; var ADest: TBitmap; AAngle: Real;
                         const AOldCenter: TPoint; var ANewCenter: TPoint); overload;
  //adds an alphablending bitmap to another bitmap
  procedure LMDBmpAlphaBlend (bmp1, bmp2 : TBitmap; const bmpRect : TRect;
                              const bmp2Pt : TPoint; target : TBitmap; Strength : Single;
                              const targetPt : TPoint);
  //inverts a bitmap
  procedure LMDBmpInvert (bmp : TBitmap; const bmpRect : TRect; target : TBitmap; const targetPt : TPoint);
  //adds brightness to a bitmap
  procedure LMDBMPBrightness (bmp : TBitmap; const bmpRect : TRect;
                              target : TBitmap; const targetPt : TPoint; brightness : TLMDBrightness);
  //adds brightness to a bitmap - for every pixel <> ec !!!
  procedure LMDBmpBrightnessEC (bmp : TBitmap; const bmpRect : TRect;
                                target : TBitmap; const targetPt : TPoint; brightness : TLMDBrightness;
                                ec: TColor);
  // creates Region from a SourceBitmap, aTransparentColor specifies transparent areas
  function LMDBmpCreateRgn(aSourceBitmap: TBitmap; aTransparentColor: TColor): HRGN;

implementation

uses
  Classes, Math, LMDTypes, LMDProcs; //Rect

{------------------------------------------------------------------------------}
function  IncAddr(P: Pointer; A: integer): Pointer;
begin
  Result := Pointer(TLMDPtrInt(P) + A);
end;

{------------------------------------------------------------------------------}
procedure PtrToBuf(P: Pointer; var Buf: array of byte; Len: integer);
begin
  CopyMemory (@Buf, P, Len);
end;

{------------------------------------------------------------------------------}
procedure BufToPtr(const Buf: array of byte; P: Pointer; Len: integer);
begin
  CopyMemory (P, @Buf, Len);
end;

// internal helpers
{------------------------------------------------------------------------------}
function checkPF(b : TBitmap; s : String) : Boolean;
begin
  result := (b.PixelFormat in [pf24Bit, pf32Bit]);
  if not result then
    raise ELMDWrongPixelFormat.Create ('Wrong PixelFormat in '+s+' bitmap!');
end;

{------------------------------------------------------------------------------}
function  int_GetGap(BMP: TBitmap; var Gap: integer): Boolean;
begin
  if  BMP.PixelFormat = pf24bit  then
    Gap := 3
  else
  if  BMP.PixelFormat = pf32bit  then
    Gap := 4
  else
    Gap := 0;

  Result := (Gap <> 0);
end;

{------------------------------------------------------------------------------}
function  CBounds(V: integer): integer;
begin
  if  V < 0 then
    Result := 0
  else
  if  V > 255 then
    Result := 255
  else
    Result := V;
end;

// LMD Bitmap routines

{ ---------------------------------------------------------------------------- }
procedure LMDBMPGrayScale (bmp : TBitmap; const bmpRect : TRect; target : TBitmap; const targetPt : TPoint);
var
  x, y, i : Integer;
  p, p2 : PtrToPixel;
  S, D: PLMDStepRGB;
  red, blue, green : Array[0..255] of Byte;
  ii: integer;

begin

{  //check for correct color depth
  if not checkPF (bmp,'Source') or not checkPF (target,'Target') then exit;
  //check for correct dimensions
  if not checkSize (bmp, bmpRect,'Source') or not checkSize (target, Rect (targetPt.X, targetPt.Y, targetPt.X + bmpRect.Right - bmpRect.Left, targetPt.Y + bmpRect.Bottom - bmpRect.Top),'Target') then exit;
}
  if  not int_GetGap(bmp, ii) then
    begin
      target.Assign(bmp);
      exit;
    end;

  if  target.PixelFormat <> bmp.PixelFormat then
    target.PixelFormat := bmp.PixelFormat;

  for x := 0 to 255 do
    begin
      red[x] := Round(x * 0.3);
      blue[x] := Round(x * 0.59);
      green[x] := Round(x * 0.11);
    end;

  for y := 0 to (bmpRect.Bottom - bmpRect.Top)-1 do
    begin
      p := IncAddr(bmp.ScanLine[y + bmpRect.Top], ii * bmpRect.Left);
      p2 := IncAddr(target.ScanLine[y + targetPt.Y], ii * targetPt.X);

      for x := 0 to bmpRect.Right - bmpRect.Left-1 do
        begin

          S := p;
          D := p2;

          i := red[S.r] + green[S.g] + blue[S.b];
          D.r := i;
          D.g := i;
          D.b := i;

          p := IncAddr(p, ii);
          p2 := IncAddr(p2, ii);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDBMPFlipVertical(ASource: TBitmap; ATarget: TBitmap); overload;
begin
  LMDBMPFlipVertical(ASource, Rect(0, 0, ASource.Width, ASource.Height + 1), ATarget, Point(0, 0));
end;

{ ---------------------------------------------------------------------------- }
procedure LMDBMPFlipVertical (bmp : TBitmap; bmpRect : TRect;
                              target : TBitmap; const targetPt : TPoint);
var
  width,
  height,
  y : Integer;
  p_s1, p_s2, p_t1, p_t2 : PtrToPixel;
  ii, LS: integer;
  L1, L2: array of byte;
begin

{  //check for correct color depth
  if not checkPF (bmp,'Source') or not checkPF (target,'Target') then exit;
  //check for correct dimensions
  if not checkSize (bmp, bmpRect,'Source') or not checkSize (target, Rect (targetPt.X, targetPt.Y, targetPt.X + bmpRect.Right - bmpRect.Left, targetPt.Y + bmpRect.Bottom - bmpRect.Top),'Target') then exit;
}
  if  not int_GetGap(bmp, ii) then
    begin
      target.Assign(bmp);
      exit;
    end;

  if  target.PixelFormat <> bmp.PixelFormat then
    target.PixelFormat := bmp.PixelFormat;

  dec (bmpREct.Bottom, 2);

  width := bmpRect.Right - bmpRect.Left;
  height := bmpRect.Bottom - bmpRect.Top;
  LS := width * ii;
  SetLength(L1, LS);
  SetLength(L2, LS);

  for y := 0 to height div 2 do
    begin
      //get pointer to line a to be exchanged
      p_s1 := IncAddr(bmp.ScanLine[bmpRect.Top + y], bmpRect.Left * ii);
      //get pointer to line b to be exchanged
      p_s2 := IncAddr(bmp.ScanLine[bmpRect.Bottom - y], bmpRect.Left * ii);
      //get pointer to destination bmp (for line b)
      p_t1 := IncAddr(target.ScanLine[targetPt.Y + y], targetPt.X * ii);
      //get pointer to destination bmp (for line a)
      p_t2 := IncAddr(target.ScanLine[targetPt.Y + height - y], targetPt.X * ii);

      PtrToBuf(p_s1, L1, LS);
      PtrToBuf(p_s2, L2, LS);
      BufToPtr(L1, p_t2, LS);
      BufToPtr(L2, p_t1, LS);
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDBMPFlipHorizontal(ASource: TBitmap; ATarget: TBitmap);overload;
begin
  LMDBMPFlipHorizontal(ASource, Rect(0, 0, ASource.Width, ASource.Height + 1), ATarget, Point(0, 0));
end;

{ ---------------------------------------------------------------------------- }
procedure LMDBMPFlipHorizontal (bmp : TBitmap; const bmpRect : TRect;
                                target : TBitmap; const targetPt : TPoint);overload;
var
  p_s1,
  p_s2,
  p_t1,
  p_t2 : PtrToPixel;
  x, y : Integer;
  ii: integer;
  L, R: array of byte;
begin

{  //check for correct color depth
  if not checkPF (bmp,'Source') or not checkPF (target,'Target') then exit;
  //check for correct dimensions
  if not checkSize (bmp, bmpRect,'Source') or not checkSize (target, Rect (targetPt.X, targetPt.Y, targetPt.X + bmpRect.Right - bmpRect.Left, targetPt.Y + bmpRect.Bottom - bmpRect.Top),'Target') then exit;
}

  if  not int_GetGap(bmp, ii) then
    begin
      target.Assign(bmp);
      exit;
    end;

  if  target.PixelFormat <> bmp.PixelFormat then
    target.PixelFormat := bmp.PixelFormat;

  SetLength(L, ii);
  SetLength(R, ii);

  for y := 0 to bmpRect.Bottom - bmpRect.Top -1 do
    begin
      p_s1 := IncAddr(bmp.ScanLine[bmpRect.Top + y], bmpRect.Left * ii);
      p_s2 := IncAddr(bmp.ScanLine[bmpRect.Top + y], (bmpRect.Right - ii) * ii);
      p_t1 := IncAddr(target.ScanLine[targetPt.Y + y], targetPt.X * ii);
      p_t2 := IncAddr(target.ScanLine[targetPt.Y + y], ((targetPt.X + (bmpRect.Right - bmpRect.Left)) - ii)  * ii);

      for x := 0 to (bmpRect.Right - bmpRect.Left) div 2 - 1 do
        begin
          PtrToBuf(p_s1, L, ii);
          PtrToBuf(p_s2, R, ii);
          BufToPtr(L, p_t2, ii);
          BufToPtr(R, p_t1, ii);

          p_s1 := IncAddr(p_s1,  ii);
          p_s2 := IncAddr(p_s2, -ii);
          p_t1 := IncAddr(p_t1,  ii);
          p_t2 := IncAddr(p_t2, -ii);
        end;

    end;
end;

{------------------------------------------------------------------------------}
procedure LMDBmpRotate(const ASource: TBitmap; var ADest: TBitmap; AAngle: Real);
var
  LNewCenter: TPoint;
begin
  LMDBmpRotate(ASource, ADest, AAngle, Point(ASource.Width div 2, ASource.Height div 2), LNewCenter);
end;

{------------------------------------------------------------------------------}
{
  Based on:
  (c) har*GIS L.L.C., 1999
    You are free to use this in any way, but please retain this comment block.
    Please email questions to jim@har-gis.com .
  Doc & Updates: http://www.efg2.com/Lab/ImageProcessing/RotateScanline.htm
  and http://www.efg2.com/Lab/Library/Delphi/Graphics/JimHargis_RotateBitMap.zip
}
procedure LMDBmpRotate(const ASource: TBitmap; var ADest: TBitmap; AAngle: Real;
                       const AOldCenter: TPoint; var ANewCenter: TPoint);
VAR
  cosTheta: Extended;
  sinTheta: Extended;

  LDist, Ldx, Ldy, LSin, LCos: Extended;

  i: Integer;
  iOriginal: Integer;
  iPrime: Integer;
  j: Integer;
  jOriginal: Integer;
  jPrime: Integer;

  NewWidth, NewHeight: Integer;
  nBytes, nBits: Integer;
  Oht, Owi, Rht, Rwi: Integer;

  RowRotatedB: TLMDRawMemory;      //1 byte
  RowRotatedW: TLMDRawMemory;      //2 bytes
  RowRotatedT: TLMDRawMemory; //3 bytes
  RowRotatedQ: TLMDRawMemory;   //4 bytes

  TransparentB: Byte;
  TransparentW: Word;
  TransparentT: TRGBTriple;
  TransparentQ: DWord;
  LOffset: Integer;
  LOffsetOrg: Integer;
  DIB: TDIBSection;
  LMem: TLMDRawMemory;
begin
  LMem := TLMDRawMemory.Create;
  RowRotatedB := TLMDRawMemory.Create;
  RowRotatedW := TLMDRawMemory.Create;
  RowRotatedW.OffsetSize := SizeOf(Word);
  RowRotatedT := TLMDRawMemory.Create;
  RowRotatedQ := TLMDRawMemory.Create;
  RowRotatedQ.OffsetSize := SizeOf(DWord);
  try
    with ASource do
    begin
      case pixelformat of
        pfDevice:
        begin
          nBits :=  GetDeviceCaps(Canvas.Handle, BITSPIXEL) + 1;
          if (nBits > 0) and (nBits mod 8 <> 0) then
            exit
          else
            nBytes := nBits div 8;
        end;
        pf1bit: nBytes:=0;
        pf4bit: nBytes:=0;
        pf8bit: nBytes:=1;
        pf15bit: nBytes:=2;
        pf16bit: nBytes:=2;
        pf24bit: nBytes:=3;
        pf32bit: nBytes:=4;

        pfCustom:
        begin
          GetObject(Handle, SizeOf(DIB), @DIB);
          nBits := DIB.dsBmih.biSizeImage;
          if (nBits > 0) and (nBits mod 8 <> 0) then
            Exit
          else
            nBytes := nBits div 8;
        end;
        else
          Exit;
      end;

      if nBytes=0 then
        PixelFormat := pf8bit;

      ADest.Assign(ASource);

      SinCos(AAngle, sinTheta, cosTheta);

      NewWidth  := Abs(Round(Height * sinTheta)) + Abs(Round(Width * cosTheta));
      NewHeight := Abs(Round(Width * sinTheta )) + Abs(Round(Height * cosTheta));

      if (Abs(AAngle) * Max(Width, Height)) > 1 then
      begin
        ADest.Width  := NewWidth;   //resize it for rotation
        ADest.Height := NewHeight;
        //iRotationAxis := width div 2;
        //jRotationAxis := height div 2;

        Rwi := NewWidth - 1; //right column index
        Rht := NewHeight - 1;//bottom row index
        Owi := Width - 1;    //transp color column index
        Oht := Height - 1;   //transp color row  index

        TransparentB := 0;
        TransparentW := 0;
        TransparentQ := 0;

        if nBytes in [2, 4] then
          LMem.OffsetSize := nBytes;
        LMem.Memory := Scanline[Oht];
        case nBytes of
          0,1: TransparentB := LMem[0];
          2: TransparentW := LMem.Word[0];
          3:
          begin
            TransparentT.rgbtBlue := LMem[0];
            TransparentT.rgbtGreen := LMem[1];
            TransparentT.rgbtRed := LMem[2];
          end;
          4: TransparentQ := LMem.DWord[0];
        end;//case *)

        for j := Rht downto 0 do
        begin

          case nBytes of  //1/6/00
            0,1:RowRotatedB.Memory := ADest.Scanline[j] ;
            2:  RowRotatedW.Memory := ADest.Scanline[j] ;
            3:  RowRotatedT.Memory := ADest.Scanline[j] ;
            4:  RowRotatedQ.Memory := ADest.Scanline[j] ;
          end;//case

          jPrime := 2*j - NewHeight + 1 ;

          for i := Rwi downto 0 do
          begin
            iPrime := 2 * i - NewWidth + 1;

            iOriginal := (Round(iPrime * CosTheta - jPrime * sinTheta ) - 1 + Width) div 2;
            jOriginal := (Round(iPrime * sinTheta + jPrime * cosTheta ) - 1 + Height) div 2 ;

            if (iOriginal >= 0) and (iOriginal <= Owi) and
               (jOriginal >= 0 ) and (jOriginal <= Oht) then
            begin
              LMem.Memory := ScanLine[joriginal];
              case nBytes of  //get pixel bytes according to pixel format   1/6/00
                0,1: RowRotatedB[i] := LMem[iOriginal];
                2: RowRotatedW[i] := LMem.Word[iOriginal];
                3:
                begin
                  LOffset := i * 3;
                  LOffsetOrg := iOriginal * 3;
                  RowRotatedT[LOffset] := LMem[LOffsetOrg];
                  RowRotatedT[LOffset + 1] := LMem[LOffsetOrg + 1];
                  RowRotatedT[LOffset + 2] := LMem[LOffsetOrg + 2];
                end;
                4: RowRotatedQ.DWord[i] := LMem.DWord[iOriginal];
              end;
            end
            else
            begin
              case nBytes of
                0,1:RowRotatedB[i] := TransparentB;
                2: RowRotatedW.Word[i] := TransparentW;
                3:
                begin
                  RowRotatedT[i] := TransparentT.rgbtBlue;
                  RowRotatedT[i + 1] := TransparentT.rgbtGreen;
                  RowRotatedT[i + 2] := TransparentT.rgbtRed;
                end;
                4: RowRotatedQ.DWord[i] := TransparentQ;
              end;
            end;
          end;
        end;
      end;

      Ldx := (AOldCenter.x - (Width div 2));  Ldy := (AOldCenter.y - (Height div 2));
      LDist := Hypot(Ldx, Ldy);
      if Abs(LDist) < 1 then
      begin
        LSin := 0.0;
        LCos := 1.0;
      end
      else
      begin
        LSin := Ldy / LDist;
        LCos := Ldx / LDist;
      end;

      ANewCenter.X := newWidth div 2 + Round(LDist * (cosTheta * LCos - SinTheta * LSin));
      ANewCenter.Y := newHeight div 2 - Round(LDist * (sinTheta * LCos + CosTheta * LSin));
    end;
  finally
    LMem.Free;
    RowRotatedB.Free;
    RowRotatedW.Free;
    RowRotatedT.Free;
    RowRotatedQ.Free;
  end;
end;

{ ---------------------------------------------------------------------------

    bmp1 -> source bitmap (image to be background)
    bmp2 -> second bitmap to be merged on background
    aRect -> area of bmp1 which shall be transformed
    bmp2Pt -> starting point in bmp2 where image rect shall be merged from (not:
              bmp2 must be of min size ptbmp2.X (Y) + (aRect.Right (Bottom) -
              aRect.Left (Top) !!
    target -> target bitmap where result shall be mapped to
    tragetPt -> starting of traget rect (see note for bmp2Pt)

 -------------------------------------------------------------------------- }
procedure LMDBMPAlphaBlend (bmp1, bmp2 : TBitmap; const bmpRect : TRect;
  const bmp2Pt : TPoint; target : TBitmap; Strength : Single; const targetPt : TPoint);
var
  x, y : Integer;
  rgb_1, rgb_2, rgb_3: PtrToPixel;
  vals : Array [-255..255] of Integer;
  ii: integer;
  s1, s2, R: PLMDStepRGB;

begin

  //check for correct color depth
  if not checkPF (bmp1,'Source 1') or not checkPF (bmp2,'Source 2') or not checkPF (target,'Target') then exit;

  //check for correct dimensions
{  if not checkSize (bmp1, bmpRect,'Source 1')
      or not checkSize (bmp2, Rect (bmp2Pt.X, bmp2Pt.Y, bmp2Pt.X + bmpRect.Right - bmpRect.Left, bmp2Pt.Y + bmpRect.Bottom - bmpRect.Top),'Source 2')
      or not checkSize (target, Rect (targetPt.X, targetPt.Y, targetPt.X + bmpRect.Right - bmpRect.Left, targetPt.Y + bmpRect.Bottom - bmpRect.Top),'Target') then
    exit;}

//  v1 := Round(Frac (FStrength) * 100);

  if  not int_GetGap(bmp1, ii) then
    begin
      bmp2.Assign(bmp1);
      exit;
    end;

  if  target.PixelFormat <> bmp1.PixelFormat then
    target.PixelFormat := bmp1.PixelFormat;

  for y := -255 to 255 do
    vals[y] := Round (Strength * y); //(FStrength * i) shr 8;

  for y := 0 to bmpRect.Bottom - bmpRect.Top - 1 do
    begin
      rgb_1 := IncAddr(bmp1.ScanLine[bmpRect.Top + y], bmpRect.Left * ii);
      rgb_2 := IncAddr(bmp2.ScanLine[bmp2Pt.Y + y], bmp2Pt.X * ii);
      rgb_3 := IncAddr(target.ScanLine[targetPt.Y + y], targetPt.X * ii);

      for x := 0 to bmpRect.Right - bmpRect.Left-1 do
        begin

          s1 := rgb_1;
          s2 := rgb_2;
          R  := rgb_3;

          R.r := vals[s1.r - s2.r] + s2.r;
          R.g := vals[s1.g - s2.g] + s2.g;
          R.b := vals[s1.b - s2.b] + s2.b;

          rgb_1 := IncAddr(rgb_1, ii);
          rgb_2 := IncAddr(rgb_2, ii);
          rgb_3 := IncAddr(rgb_3, ii);
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDBMPInvert (bmp : TBitmap; const bmpRect : TRect;
  target : TBitmap; const targetPt : TPoint);
var
  x, y : Integer;
  p, p2 : PtrToPixel;
  ii: integer;
  S, D: PLMDStepRGB;

begin
  if  not int_GetGap(bmp, ii) then
    begin
      target.Assign(bmp);
      exit;
    end;

  if  target.PixelFormat <> bmp.PixelFormat then
    target.PixelFormat := bmp.PixelFormat;

  for y := 0 to (bmpRect.Bottom - bmpRect.Top)-1 do
    begin
      p := IncAddr(bmp.ScanLine[y + bmpRect.Top], bmpRect.Left * ii);
      p2 := IncAddr(target.ScanLine[y + targetPt.Y], targetPt.X * ii);

      for x := 0 to bmpRect.Right - bmpRect.Left-1 do
        begin

          S := p;
          D := p2;

          D.r := 255 - S.r;
          D.g := 255 - S.g;
          D.b := 255 - S.b;

          p  := IncAddr(p, ii);
          p2 := IncAddr(p2, ii);
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDBmpBrightness (bmp : TBitmap; const bmpRect : TRect; target :
  TBitmap; const targetPt : TPoint; brightness : TLMDBrightness);

var
  x, y : Integer;
  MY, MX: integer;
  p, p2 : PtrToPixel;

  ii: integer;
  S, D: PLMDStepRGB;

begin
  if  not int_GetGap(bmp, ii) then
    begin
      target.Assign(bmp);
      exit;
    end;

  if  target.PixelFormat <> bmp.PixelFormat then
    target.PixelFormat := bmp.PixelFormat;

  MY := bmpRect.Bottom - bmpRect.Top;

  if  MY > (target.Height - targetPt.Y)  then
    MY := (target.Height - targetPt.Y);

  MX := bmpRect.Right - bmpRect.Left;

  if  MX > (target.Width - targetPt.X)  then
    MX := (target.Width - targetPt.X);

  for y := 0 to MY - 1 do
    begin
      p := IncAddr(bmp.ScanLine[y + bmpRect.Top], bmpRect.Left * ii);
      p2 := IncAddr(target.ScanLine[y + targetPt.Y], targetPt.X * ii);

      for x := 0 to MX - 1 do
        begin

          S := p;
          D := p2;

          D.r := CBounds(S.r + brightness);
          D.g := CBounds(S.g + brightness);
          D.b := CBounds(S.b + brightness);

          p := IncAddr(p, ii);
          p2 := IncAddr(p2, ii);
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDBmpBrightnessEC (bmp : TBitmap; const bmpRect : TRect;
  target : TBitmap; const targetPt : TPoint; brightness : TLMDBrightness; ec: TColor);
var
  x, y : Integer;
  ec_col2 : TLMDRGB;
  ec_col : TLMDStepRGB;
  p, p2 : PtrToPixel;

  ii: integer;
  S, D: PLMDStepRGB;

begin
  if  not int_GetGap(bmp, ii) then
    begin
      target.Assign(bmp);
      exit;
    end;

  if  target.PixelFormat <> bmp.PixelFormat then
    target.PixelFormat := bmp.PixelFormat;

  ec_col2.all := ColorToRGB (ec);
  ec_col.r := ec_col2.r;
  ec_col.b := ec_col2.b;
  ec_col.g := ec_col2.g;

  for y := 0 to (bmpRect.Bottom - bmpRect.Top) do
    begin
      p := IncAddr(bmp.ScanLine[y + bmpRect.Top], bmpRect.Left * ii);
      p2 := IncAddr(target.ScanLine[y + targetPt.Y], targetPt.X * ii);

      for x := 0 to (bmpRect.Right - bmpRect.Left) do
        begin

          S := p;
          D := p2;

          if (ec_col.r <> S.r) and (ec_col.b <> S.b) and (ec_col.g <> S.g) then
            begin
              D.r := CBounds(S.r + brightness);
              D.g := CBounds(S.g + brightness);
              D.b := CBounds(S.b + brightness);

            end;

          p := IncAddr(p, ii);
          p2 := IncAddr(p2, ii);
        end;
    end;
end;

{------------------------------------------------------------------------------}
function LMDBmpCreateRgn(aSourceBitmap:TBitmap; aTransparentColor:TColor):HRGN;
var
  transcolor: TRGBTriple;
  left, right,
  tmpw, tmps, i, j: Integer;
  Row: PtrToPixel;
  tmp: TBitmap;
  tmpRgn: HRGN;

  function  CheckPixel(P: PtrToPixel): Boolean;
  begin
    Result := CompareMem(@transcolor, P, 3);
  end;

begin
  result:=0;
  // check if correct format is available
  if aSourceBitmap.PixelFormat in [pf24bit, pf32bit] then
    begin
      tmp:=aSourceBitmap;
      with transcolor do
        begin
          rgbtBlue:=GetBValue(aTransparentColor);
          rgbtGreen:=GetGValue(aTransparentColor);
          rgbtRed:=GetRValue(aTransparentColor);
        end;
    end
  else
    begin
      tmp:=TBitmap.Create;
      tmp.HandleType := bmDIB;
      tmp.Assign(aSourceBitmap);
      tmp.Mask(aTransparentColor);
      tmp.PixelFormat:=pf24bit;  // work with TRGBTriples
      with transcolor do         // initialize to black color for b/w mask
      begin
        if (aTransparentColor = clWhite) then
        begin
          rgbtBlue:=255;
          rgbtGreen:=255;
          rgbtRed:=255;
        end
        else
        begin
          rgbtBlue:=0;
          rgbtGreen:=0;
          rgbtRed:=0;
        end;
      end;
    end;
  try
    if  not int_GetGap(tmp, tmps) then
      exit;

   tmpw:=tmp.Width-1;

    for i := 0 to tmp.Height-1 do
      begin
        left:=-1;
        Row := tmp.Scanline[i];
        for j:=0 to tmpw do
          begin
            if left<0 then
              if not CheckPixel(Row)  then
                left := j
              else
            else
              if CheckPixel(Row)  then
                begin
                  right:=j;
                  tmpRgn:=CreateRectRgn(left,i,right,i+1);
                  if result = 0 then
                    result:=tmpRgn
                  else
                    begin
                      CombineRgn(result, result, tmpRgn, RGN_OR);
                      DeleteObject(tmpRgn);
                    end;
                  left:=-1;
                end;
            Row := IncAddr(Row, tmps);
          end;
        if left>=0 then
          begin
            tmpRgn:=CreateRectRgn(left, i, tmpw, i + 1);
            if result=0 then
              result:=tmpRgn
            else
              begin
                CombineRgn(Result, result, tmpRgn, RGN_OR);
                DeleteObject(tmpRgn);
              end;
          end;
      end;
  finally
    // free only if we created it ourselves
    if  tmp <> aSourceBitmap  then
      tmp.Free;
  end;

end;

end.
