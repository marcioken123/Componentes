unit LMDStreamUtils;
{$I lmdcmps.inc}

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

LMDStreamUtils unit (RM)
------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Forms, Graphics, Controls, SysUtils,
  LMDClass, LMDGraph, LMDWave, LMDStrings, LMDProcs;

procedure LMDBmpSaveDIBStream(Stream:TStream; Bitmap: TBitmap; Colors: Integer);

{Writing Procedures}
procedure stWriteByte(Stream:TStream; aValue:Byte);
procedure stWriteInteger(Stream:TStream; aValue:LongInt);
procedure stWriteWord(Stream:TStream; aValue:Word);
procedure stWriteString(Stream:TStream; const aValue:String);
procedure stWriteStringList(Stream:TStream; aValue:TStrings; Compressed:Boolean);
procedure stWriteWave(Stream:TStream; aValue:TLMDWave; Compressed:Boolean);
procedure stWriteBitmap(Stream:TStream; aValue:TBitmap; Compressed:Boolean; Colors:Integer);

{Reading Functions/Procs}
function stReadInteger(Stream:TStream):LongInt;
function stReadByte(Stream:TStream):Byte;
function stReadWord(Stream:TStream):Word;
function stReadString(Stream:TStream):String;
procedure stReadStringList(Stream:TStream; aValue:TStrings; Compressed:Boolean);
procedure stReadWave(Stream:TStream; aValue:TLMDWave; Compressed:Boolean);
procedure stReadBitmap(Stream:TStream; aValue:TBitmap; Compressed:Boolean);

implementation

uses
  consts, LMDTypes, LMDUtils;

{------------------------------------------------------------------------------}
procedure LMDBmpInitInfoHeader(aBitmap: HBITMAP; var infoheader:TBitmapInfoHeader; Colors:Integer);
var
  bm:Windows.TBitmap;
begin
  GetObject(aBitmap, SizeOf(bm), @bm);
  with infoheader do
    begin
      biSize := SizeOf(infoheader);
      biWidth := bm.bmWidth;
      biHeight := bm.bmHeight;
      if Colors<>0 then
        case Colors of
          2: biBitCount := 1;
          16: biBitCount := 4;
          256: biBitCount := 8;
        end
      else
        biBitCount := BM.bmBitsPixel * BM.bmPlanes;
      if biBitCount in [16, 32] then biBitCount := 24;
      biPlanes := 1;
      biXPelsPerMeter := 0;
      biYPelsPerMeter := 0;
      biClrUsed := 0;
      biClrImportant := 0;
      biCompression := BI_RGB;
      biSizeImage := ((((biWidth * biBitCount) + 31) div 32) * 4)*biHeight;
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDBmpGetDIBInfo(Bitmap: HBITMAP; var InfoHeaderSize: Integer;
                           var ImageSize: Longint; Colors: Integer);
var
  infoheader: TBitmapInfoHeader;
begin
  LMDBmpInitInfoHeader(Bitmap, infoheader, Colors);
  with infoheader do
    begin
      case biBitCount of
        24: InfoHeaderSize := SizeOf(TBitmapInfoHeader);
        else
        InfoHeaderSize := SizeOf(TBitmapInfoHeader) + SizeOf(TRGBQuad) * (1 shl biBitCount);
        end;
    end;
  ImageSize := infoHeader.biSizeImage;
end;

{------------------------------------------------------------------------------}

function LMDBmpGetDIB(Bitmap: HBITMAP; Palette: HPALETTE; var BitmapInfo;
                      var Bits; Colors: Integer): Boolean;

var
  OldPal: HPALETTE;
  Focus: HWND;
  DC: HDC;
begin
  LMDBmpInitInfoHeader(Bitmap, TBitmapInfoHeader(BitmapInfo), Colors);
  OldPal := 0;
  Focus := GetFocus;
  DC:= GetDC(Focus);
  try
    if Palette <> 0 then
      begin
        OldPal := SelectPalette(DC, Palette, False);
        RealizePalette(DC);
      end;
      Result := GetDIBits(DC, Bitmap, 0, TBitmapInfoHeader(BitmapInfo).biHeight,
                          @Bits, TBitmapInfo(BitmapInfo), DIB_RGB_COLORS) <> 0;
      finally
    if OldPal <> 0 then SelectPalette(DC, OldPal, False);
    ReleaseDC(Focus, DC);
  end;
end;

{------------------------------------------------------------------------------}

function LMDBmpDIBFromBitmap(Src: HBITMAP; Pal: HPALETTE; Colors: Integer; var Length: Longint): Pointer;
var
  HeaderSize: Integer;
  ImageSize: Longint;
  FileHeader: PBitmapFileHeader;
  BI: PBitmapInfoHeader;
  Bits: Pointer;
begin
  if Src = 0 then
    raise Exception.Create(SInvalidBitmap);

  LMDBmpGetDIBInfo(Src, HeaderSize, ImageSize, Colors);
  Length := SizeOf(TBitmapFileHeader) + HeaderSize + ImageSize;
  GetMem(result, Length);
  try
    FillChar(Result^, Length, 0);
    FileHeader := Result;
    with FileHeader^ do
      begin
        bfType := $4D42;
        bfSize := Length;
        bfOffBits := SizeOf(FileHeader^) + HeaderSize;
      end;
    BI := PBitmapInfoHeader(TLMDPtrInt(FileHeader) + SizeOf(FileHeader^));
    Bits := Pointer(TLMDPtrUInt(BI) + TLMDPtrUInt(HeaderSize));
    LMDBmpGetDib(Src, Pal, BI^, Bits^, Colors);
  except
    FreeMem(Result, Length);
    raise;
  end;
end;

{------------------------------------------------------------------------------}
procedure LMDBitmapToDIBStream(Stream: TStream; Bitmap: HBITMAP; Pal: HPALETTE;
                               WriteLength: Boolean; Colors: Integer);
var
  Length: Longint;
  Data: Pointer;
  begin
  Data := LMDBmpDIBFromBitmap(Bitmap, Pal, Colors, Length);
  try
    if WriteLength then
      Stream.Write(Length, SizeOf(Length));
    Stream.Write(Data^, Length);
    finally
    FreeMem(Data, Length);
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDBmpSaveDIBStream(Stream:TStream; Bitmap: TBitmap; Colors: Integer);
begin
  if Bitmap.Monochrome then
    Colors := 2;
  LMDBitmapToDIBStream(Stream, Bitmap.Handle, Bitmap.Palette, False, Colors);
  Stream.Seek(0, soFromBeginning);
end;

{
********************************************************************************
* Routines for Internal Streaming System                                       *
* Used internally to guarantee 16/32bit compatibility with TLMDList/-Item      *
*                                                                              *
* In Delphi32 you SHOULD use TCollection and TCollectionItem, because          *
* streaming support is provided automatically!                                 *
********************************************************************************
}

{Writing Procedures}
{------------------------------------------------------------------------------}
procedure stWriteInteger(Stream:TStream; aValue:LongInt);
begin
  Stream.Write(aValue, sizeof(aValue));
end;

{------------------------------------------------------------------------------}

procedure stWriteString(Stream:TStream; const aValue:String);
var
  temp:Byte;

  L: integer;
begin
  L := Length(aValue);
  if  L > High(temp)  then   // AND NOT SIZEOF!!!!!
    L := High(temp);
  temp := L*sizeof(Char);
  Stream.Write(temp, sizeof(temp));

  Stream.Write(PChar(aValue)^, temp);

end;

{------------------------------------------------------------------------------}
procedure stWriteStringList(Stream:TStream; aValue:TStrings; Compressed:Boolean);
var
  oldpos, newpos:LongInt;
  tmp:TMemoryStream;
begin
  if Compressed then
    begin
      tmp:=TMemoryStream.Create;
      try
        aValue.SaveToStream(tmp);
        tmp.Position:=0;
        LMDSaveCompressedStream(tmp, Stream, tmp.size);
      finally
        tmp.Free;
      end;
    end
  else
    begin
      oldpos:=Stream.Position;
      Stream.Position:=oldpos+sizeof(LongInt);
      aValue.SaveToStream(Stream);
      newpos:=Stream.Position;
      Stream.Position:=OldPos;
      OldPos:=NewPos-(OldPos+sizeof(LongInt));
      Stream.Write(OldPos, sizeof(OldPos));
      Stream.Position:=newpos;
    end;
end;

{------------------------------------------------------------------------------}
procedure stWriteByte(Stream:TStream; aValue:Byte);
begin
  Stream.Write(aValue, sizeof(aValue));
end;

{------------------------------------------------------------------------------}
procedure stWriteWord(Stream:TStream; aValue:Word);
begin
  Stream.Write(aValue, sizeof(aValue));
end;

{------------------------------------------------------------------------------}
procedure stWriteWave(Stream:TStream; aValue:TLMDWave; Compressed:Boolean);
begin
  if Compressed then
    aValue.SaveCompressedToStream(Stream)
  else
    aValue.SaveToStreamEx(Stream);
end;

{------------------------------------------------------------------------------}
procedure stWriteBitmap(Stream:TStream; aValue:TBitmap; Compressed:Boolean; Colors:Integer);
var
  oldpos, newpos: LongInt;
  tmp: TMemoryStream;
begin
  if Compressed then
    begin
      tmp:=TMemoryStream.Create;
      try
        if colors=-1 then
          aValue.SaveToStream(tmp)
        else
          LMDBmpSaveDIBStream(tmp, aValue, Colors);
        tmp.Position:=0;
        LMDSaveCompressedStream(tmp, Stream, tmp.size);
      finally
        tmp.Free;
      end;
    end
  else
    if colors=-1 then
      begin
        {funny, but guarantees compatibility between 16&32bit)}
        oldpos := Stream.Position;
        Stream.Position := oldpos + sizeof(LongInt);
        aValue.SaveToStream(Stream);
        newpos := Stream.Position;
        Stream.Position := OldPos;
        OldPos := NewPos - (OldPos + sizeof(LongInt));
        Stream.Write(OldPos, sizeof(OldPos));
        Stream.Position := newpos;
        end
    else
      LMDBitmapToDIBStream(Stream, aValue.Handle, aValue.Palette, True, Colors);
end;

{Reading Functions/Procs}
{------------------------------------------------------------------------------}
function stReadInteger(Stream:TStream):LongInt;
begin
  Stream.Read(result, sizeof(result));
end;

{------------------------------------------------------------------------------}

function stReadString(Stream:TStream): String;
var
  size:Byte;
begin
  Stream.Read(size, sizeof(size));
  SetLength(Result, size div sizeof(char));
  Stream.Read(PChar(Result)^, Size);
end;

{------------------------------------------------------------------------------}
procedure stReadStringList(Stream: TStream; aValue:TStrings; Compressed:Boolean);
var
  Size: LongInt;
  tmp: TMemoryStream;
begin
  tmp := TMemoryStream.Create;

  try
    if Compressed then
      begin
        LMDLoadCompressedStream(Stream, tmp);
      end
    else
      begin
        Stream.Read(size, sizeof(Size));
        tmp.CopyFrom(Stream, Size);
      end;
    tmp.Position:=0;
    aValue.LoadFromStream(tmp);
  finally
    tmp.Free;
  end;
end;

{------------------------------------------------------------------------------}
function stReadByte(Stream:TStream):Byte;
begin
  Stream.Read(result, sizeof(result));
end;

{------------------------------------------------------------------------------}
function stReadWord(Stream:TStream):Word;
begin
  Stream.Read(result, sizeof(result));
end;

{------------------------------------------------------------------------------}
procedure stReadWave(Stream:TStream; aValue:TLMDWave; Compressed:Boolean);
begin
  if Compressed then
    aValue.LoadCompressedFromStream(Stream)
  else
    aValue.LoadFromStreamEx(Stream);
end;

{------------------------------------------------------------------------------}
procedure stReadBitmap(Stream:TStream; aValue:TBitmap; Compressed:Boolean);
var
  size:LongInt;
  tmp:TMemoryStream;
begin
  tmp:=TMemoryStream.Create;
  try
    if Compressed then
      begin
        LMDLoadCompressedStream(Stream, tmp);
      end
    else
      begin
        Stream.Read(size, sizeof(size));
        tmp.SetSize(Size);
        tmp.CopyFrom(Stream, Size);
      end;
    tmp.Position:=0;
    aValue.LoadFromStream(tmp);
  finally
    tmp.Free;
  end;
end;

end.
