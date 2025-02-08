unit LMDBitmap;
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

LMDBitmap unit (RM)
-------------------
This unit implements a simple TBitmap class derived from TLMDBitmap which
mainly utilizes the built-in OLELoadPicture function. Allows us to load
GIF, JPEG, Icon or Bitmap Files without special VCL libs. In VCL.NET simply it
represents a simple TBitmap descendant, where same features are available
through ImageFormat property.

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface
uses
  Windows, Classes, Graphics, Consts
  ,AxCtrls, ActiveX, ComObj;

type
  TLMDBitmap = class(TBitmap)  // --> TOleGraphic
  private
    FPicture:IPicture;
    function GetMMHeight: Integer;
    function GetMMWidth: Integer;
  protected
    procedure Changed(Sender: TObject); override;
    function GetEmpty: Boolean; override;
    function GetHeight: integer; override;
    function GetWidth: integer; override;
    function GetPalette: HPALETTE; override;
    function GetTransparent: Boolean; override;
    procedure SetPalette(Value: HPALETTE); override;
    procedure SetHeight(Value: integer); override;
    procedure SetWidth(Value: integer); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure Draw(ACanvas: TCanvas; const Rect: TRect); overload; override;
    procedure Draw(ACanvas: TCanvas; aX, aY:Integer);reintroduce;overload;
    procedure LoadFromFile(const FileName: string); override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToStream(Stream: TStream); override;
    procedure LoadFromClipboardFormat(AFormat: Word; AData: THandle; APalette: HPALETTE); override;
    procedure SaveToClipboardFormat(var AFormat: Word; var AData: THandle; var APalette: HPALETTE); override;
    procedure LoadFromResourceName(Instance: THandle; const ResName: String);
    procedure LoadFromResourceID(Instance: THandle; ResID: Integer);

    property MMHeight: Integer read GetMMHeight;
    property MMWidth: Integer read GetMMWidth;
    property Picture: IPicture read FPicture write FPicture;
  published
  end
  ;

implementation
uses
  SysUtils, Types;

procedure InvalidOperation(const Str: string);
begin
  raise EInvalidGraphicOperation.Create(Str);
end;

{ ------------------------------ protected ------------------------------------}
procedure TLMDBitmap.Changed(Sender: TObject);
begin
end;

{ -----------------------------------------------------------------------------}
procedure TLMDBitmap.Assign(Source: TPersistent);
begin
  if Source is TLMDBitmap then
    FPicture := TLMDBitmap(Source).Picture
  else
    if Source is TOleGraphic then
      FPicture := TOleGraphic(Source).Picture
    else
      inherited Assign(Source);
end;

{ -----------------------------------------------------------------------------}
function TLMDBitmap.GetEmpty: Boolean;
var
  PicType: Smallint;
begin
  Result := (FPicture = nil) or (FPicture.get_Type(PicType) <> 0) or (PicType <= 0);
end;

{ -----------------------------------------------------------------------------}
function TLMDBitmap.GetHeight: integer;
var
  tmph: integer;
  LPixelsPerInch: Integer;
  lDC: HDC;
begin
  result:=0;
  if Assigned(FPicture) then
    begin
      FPicture.get_Height(tmph);
      lDC := GetDC(0);
      try
        LPixelsPerInch := GetDeviceCaps(lDC, LOGPIXELSY);
        Result := MulDiv(tmph, LPixelsPerInch, 2540);
      finally
        ReleaseDC(0, lDC);
      end;
    end;
end;

{ -----------------------------------------------------------------------------}
function TLMDBitmap.GetPalette: HPALETTE;
var
  LHandle: OLE_HANDLE;
begin
  Result := 0;
  if FPicture <> nil then
    begin
      FPicture.Get_HPal(LHandle);
      Result := HPALETTE(LHandle);
    end;
end;

{ -----------------------------------------------------------------------------}
function TLMDBitmap.GetTransparent: Boolean;
var
  Attr: Integer;
begin
  Result := False;
  if FPicture <> nil then
    begin
      FPicture.Get_Attributes(Attr);
      Result := (Attr and PICTURE_TRANSPARENT) <> 0;
    end;
end;

{ -----------------------------------------------------------------------------}
function TLMDBitmap.GetWidth: integer;
var
  tmpw:integer;
  lx:Integer;
  DC:HDC;
begin
  result:=0;

  if Assigned(FPicture) then
    begin
      DC:=GetDC(0);
      try
        FPicture.get_Width(tmpw);
        lx:=GetDeviceCaps(DC, LOGPIXELSY);
        result:=MulDiv(tmpw, lx, 2540);
      finally
        ReleaseDC(0, DC);
      end;
    end;
end;

{ -----------------------------------------------------------------------------}
function TLMDBitmap.GetMMHeight: Integer;
begin
  Result := 0;
  if FPicture <> nil then FPicture.get_Height(Result);
end;

{ -----------------------------------------------------------------------------}
function TLMDBitmap.GetMMWidth: Integer;
begin
  Result := 0;
  if FPicture <> nil then FPicture.get_Width(Result);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDBitmap.SetHeight(Value: integer);
begin
 InvalidOperation(sOleGraphic);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDBitmap.SetWidth(Value: integer);
begin
 InvalidOperation(sOleGraphic);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDBitmap.SetPalette(Value: HPALETTE);
begin
  if FPicture <> nil then OleCheck(FPicture.Set_hpal(Value));
end;

{ ------------------------------ public ---------------------------------------}
procedure TLMDBitmap.Draw(ACanvas: TCanvas; const Rect: TRect);
var
  DC: HDC;
  Pal: HPalette;
  RestorePalette: Boolean;
  PicType: SmallInt;
  {$IFDEF LMDCOMP18}
  hemf: OLE_HANDLE;
  {$ELSE}
  hemf: HENHMETAFILE;
  {$ENDIF}
begin
  if FPicture = nil then Exit;
  ACanvas.Lock;
  try
    DC := ACanvas.Handle;
    Pal := Palette;
    RestorePalette := False;
    if Pal <> 0 then
      begin
        Pal := SelectPalette(DC, Pal, True);
        RealizePalette(DC);
        RestorePalette := True;
      end;
    FPicture.get_Type(PicType);
    if PicType = PICTYPE_ENHMETAFILE then
      begin
        FPicture.get_Handle(hemf);
        PlayEnhMetafile(DC, hemf, Rect);
      end
    else
      OleCheck(FPicture.Render(DC, Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, 0, MMHeight, MMWidth, -MMHeight, Rect));
    if RestorePalette then
      SelectPalette(DC, Pal, True);
  finally
    ACanvas.Unlock;
  end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDBitmap.Draw(ACanvas: TCanvas; aX, aY: Integer);
begin
 Draw(ACanvas, Rect(aX, aY, aX+GetWidth, aY+GetHeight));
end;

{ -----------------------------------------------------------------------------}
procedure TLMDBitmap.LoadFromFile(const FileName: string);
var
  Stream : TFileStream;
begin
  Stream := TFileStream.Create (FileName, fmOpenRead or fmShareDenyNone);
  try
    LoadFromStream(Stream)
  finally
    Stream.Free
  end
end;

{ -----------------------------------------------------------------------------}
procedure TLMDBitmap.LoadFromStream(Stream: TStream);
begin
  OleCheck(OleLoadPicture(TStreamAdapter.Create(Stream), 0, True, IPicture, FPicture));
end;

{ -----------------------------------------------------------------------------}
procedure TLMDBitmap.LoadFromResourceName(Instance: THandle; const ResName: string);
var
  Stream: TCustomMemoryStream;
begin
  Stream := TResourceStream.Create(Instance, ResName, RT_RCDATA);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDBitmap.LoadFromResourceID(Instance: THandle; ResID: Integer);
var
  Stream: TCustomMemoryStream;
begin
  Stream := TResourceStream.CreateFromID(Instance, ResID, RT_RCDATA);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDBitmap.SaveToStream(Stream: TStream);
begin
  OleCheck((FPicture as IPersistStream).Save(TStreamAdapter.Create(Stream), True));
end;

{ -----------------------------------------------------------------------------}
procedure TLMDBitmap.LoadFromClipboardFormat(AFormat: Word; AData: THandle; APalette: HPALETTE);
begin
 InvalidOperation(sOleGraphic);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDBitmap.SaveToClipboardFormat(var AFormat: Word; var AData: THandle; var APalette: HPALETTE);
begin
 InvalidOperation(sOleGraphic);
end;

end.
