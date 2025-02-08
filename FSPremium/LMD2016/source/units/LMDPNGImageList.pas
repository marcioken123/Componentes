unit LMDPNGImageList;
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

LMDPNGImageList unit - TLMDPNGImageList class (AH)
--------------------------------------------------
ImageList with WriteData and ReadData fix (Win32 only)

ToDo
----

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}
{$J+}
interface

uses
  Classes, SysUtils, Controls, Forms, Windows, Consts, CommCtrl, ImgList, Graphics, Types,
  intfLMDBase, LMDProcs, LMDGraphUtils, LMDTypes, LMDObjectList, LMDPNGImage;

type
  TLMDPNGImageList = class(TCustomImageList, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
    FPngList: TLMDObjectList;
    function GetPNGs(Index: Integer): TLMDPNGObject;
    function GetPngsByName(Index: TLMDString): TLMDPNGObject;
  protected
    function MaskedPNG(AImage, AMask: TBitmap): TLMDPNGObject;
    function MaskedColorPNG(AImage: TBitmap; AMaskColor: TColor): TLMDPNGObject;
    procedure ReadLeft(Reader : TReader);
    procedure ReadTop(Reader : TReader);
    procedure WriteLeft(Writer : TWriter);
    procedure WriteTop(Writer : TWriter);
    procedure DefineProperties(Filer : TFiler); override;
    function getLMDPackage:TLMDPackageID;
    procedure DoDraw(Index: Integer; Canvas: TCanvas; X: Integer; Y: Integer; Style: Cardinal; Enabled: Boolean = True); override;
  public
    procedure Assign(Source: TPersistent);override;
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    //<-- Added since LMDTools 2009 R2 // VB Jan 2009---
    function Draw(ACanvas:TCanvas; X, Y: integer; flags:Word; ListIndex:Integer): TRect;
    function DrawExt(ACanvas:TCanvas; ARect: TRect; flags:Word; Index:Integer): TRect;
    //-->
    procedure ReadImg(Stream : TStream);
    procedure WriteImg(Stream : TStream);
    function Add(Image, Mask: TBitmap): Integer; virtual;
    function AddMasked(AImage: TBitmap; AMaskColor: TColor): Integer; virtual;
    function AddPng(Image: TLMDPNGObject): Integer; virtual;
    function AddIcon(Image: TIcon): Integer; virtual;
    procedure Clear; virtual;
    procedure Delete(Index: Integer); virtual;
    procedure Insert(AIndex: Integer; AImage, AMask: TBitmap); virtual;
    procedure InsertIcon(AIndex: Integer; AImage: TIcon); virtual;
    procedure InsertMasked(AIndex: Integer; AImage: TBitmap; AMaskColor: TColor); virtual;
    procedure Move(CurIndex, NewIndex: Integer); virtual;
    procedure Replace(AIndex: Integer; AImage, AMask: TBitmap); virtual;
    procedure ReplaceIcon(AIndex: Integer; AImage: TIcon); virtual;
    procedure ReplaceMasked(AIndex: Integer; AImage: TBitmap; AMaskColor: TColor); virtual;
    function GetPNG(Index: Integer; Image: TLMDPNGObject): Boolean;
    function GetBitmap(Index: Integer; Image: TBitmap): Boolean;
    function GetPngFileNameByIndex(const AIndex: Integer): TLMDString;
    function Equal(IL : TLMDPNGImageList) : Boolean;
    function IndexOf(AObject: TLMDPNGObject): Integer;
    property PNG[Index: Integer]: TLMDPNGObject read GetPNGs;
    property PNGByName[Index: TLMDString]: TLMDPNGObject read GetPngsByName;
    function AddImage(Value: TCustomImageList; Index: Integer): Integer; reintroduce;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property Height;
    property Width;
    property OnChange;
  end;

implementation

function TLMDPNGImageList.AddImage(Value: TCustomImageList; Index: Integer): Integer;
var
  LImage: TLMDPNGObject;
  LBmp: TBitmap;
begin
  if Value <> nil then
  begin
    Result := Count;
    if Value is TLMDPNGImageList then
    begin
      LImage := TLMDPNGObject.Create;
      if (Value as TLMDPNGImageList).GetPNG(Index, LImage) then
        AddPng(LImage)
      else
        LImage.Free;
    end
    else
    begin
      LBmp := TBitmap.Create;
      if Value.GetBitmap(Index, LBmp) then
        Add(LBmp, nil);
      LBmp.Free;
    end;
  end
  else
    Result := -1;
end;

procedure TLMDPNGImageList.ReadLeft(Reader : TReader);
var
  i : LongInt;
begin
  i := DesignInfo;
  LongRec(i).Lo := Reader.ReadInteger;
  DesignInfo := i;
end;

procedure TLMDPNGImageList.ReadTop(Reader : TReader);
var
  i : LongInt;
begin
  i := DesignInfo;
  LongRec(i).Hi := Reader.ReadInteger;
  DesignInfo := i;
end;

function TLMDPNGImageList.getLMDPackage:TLMDPackageID;
begin
  result:=pi_LMD_RTLX;
end;

procedure TLMDPNGImageList.Replace(AIndex: Integer; AImage, AMask: TBitmap);
begin
  ImageList_Replace(Handle, AIndex, AImage.Handle, AMask.Handle);
  TLMDPNGObject(FPngList.Items[AIndex]).Assign(MaskedPNG(AImage, AMask));
end;

procedure TLMDPNGImageList.ReplaceIcon(AIndex: Integer; AImage: TIcon);
begin
  // todo;
end;

procedure TLMDPNGImageList.ReplaceMasked(AIndex: Integer; AImage: TBitmap; AMaskColor: TColor);
begin
  ImageList_Replace(Handle, AIndex, AImage.Handle, 0);
  TLMDPNGObject(FPngList.Items[AIndex]).Assign(MaskedColorPNG(AImage, AMaskColor));
end;

procedure TLMDPNGImageList.WriteLeft(Writer : TWriter);
begin
  Writer.WriteInteger(LongRec(DesignInfo).Lo);
end;

procedure TLMDPNGImageList.WriteTop(Writer : TWriter);
begin
  Writer.WriteInteger(LongRec(DesignInfo).Hi);
end;

procedure TLMDPNGImageList.DefineProperties(Filer : TFiler); { protected }
var
  Ancestor : TComponent;
  Info : Longint;

  function DoWrite : Boolean;
  begin
    {if Filer.Ancestor <> nil then
      Result := not (Filer.Ancestor is TElImageList) or
        not Equal(TElImageList(Filer.Ancestor))
    else}
      Result := Count > 0;
  end;

begin
  Info := 0;
  Ancestor := TComponent(Filer.Ancestor);
  if Ancestor <> nil then Info := Ancestor.DesignInfo;
  Filer.DefineProperty('Left', ReadLeft, WriteLeft,
    LongRec(DesignInfo).Lo <> LongRec(Info).Lo);
  Filer.DefineProperty('Top', ReadTop, WriteTop,
    LongRec(DesignInfo).Hi <> LongRec(Info).Hi);
  Filer.DefineBinaryProperty('Bitmap', ReadImg, WriteImg, DoWrite);
end;

procedure TLMDPNGImageList.Delete(Index: Integer);
begin
  ImageList_Remove (Handle, Index);
  FPngList.Delete(Index);
end;

destructor TLMDPNGImageList.Destroy;
begin
  FPngList.Free;
  inherited;
end;

function TLMDPNGImageList.Draw(ACanvas: TCanvas; X, Y: integer;
  flags: Word; ListIndex: Integer): TRect;
begin
  DoDraw(ListIndex, ACanvas, X, Y, flags, True);
  result := Rect(X, Y, X + Width, Y + Height);
end;

function TLMDPNGImageList.DrawExt(ACanvas:TCanvas; ARect: TRect; flags:Word; Index:Integer): TRect;
var
  i,j, he, wi, bh, bw: Integer;
  tmpByte: Byte;
  srcRect, tmpRect:TRect;
begin
  if (Index < 0) or (Index >= FPngList.Count) then
    exit;
  if IsRectEmpty(aRect) then
    exit;
  SetRectEmpty(result);
  srcRect := Rect(0, 0, Width, Height);
  //Todo: move the code calculating tempRect basing on srcRect and flags into
  //separate function in LMDGraphUtils and use it in LMDBmpDrawExt
  he := 0;
  wi := 0;
  with srcRect do
    begin
      bh := Bottom - Top;
      bw := Right - Left;
    end;
  tmpByte := 0;
  with aRect do
    begin
      if (flags and DSF_CENTER) = DSF_CENTER then
        begin
          tmpByte := 1;
          tmpRect := Rect(Left+((Right-Left)-bw) div 2, Top+((Bottom-Top)-bh) div 2, bw, bh);
        end;
      if flags and DSF_STRETCH=DSF_STRETCH then
        begin
          tmpByte := 2;
          he := (Bottom-Top);
          wi := (Right-Left);
          tmpRect := Rect(Left, Top, wi, he);
          if flags and DSF_KEEPRATIO=DSF_KEEPRATIO then
            with tmpRect do
              begin
                tmprect := LMDAffineRect(Rect(0,0,bw, bh), Rect(0,0, wi, he));
                inc(Left, aRect.Left);
                inc(Top, aRect.Top);
              end
          else
            begin
              if flags and DSF_KEEPHEIGHT=DSF_KEEPHEIGHT then
                tmpRect := Rect(Left, Top, wi, Round(wi/bw*bh));
              if flags and DSF_KEEPWIDTH=DSF_KEEPWIDTH then
                tmpRect := Rect(Left, Top, Round(he/bh*bw),he);
            end;
        end;
      if (flags and DSF_TILE) = DSF_TILE then
        begin
          tmpByte := 3;
          if (bh <> 0) and (bw <> 0) then
            begin
              he:=((Bottom - Top) div bh) + 1;
              wi:=((Right - Left) div bw) + 1;
            end;
        end;
      if tmpByte = 0 then
        tmpRect := Rect(aRect.Left, aRect.Top, bw, bh);
      if IsRectEmpty(tmpRect) then
        result := aRect
      else
        with tmpRect do
          result := Bounds(Left, Top, Right, Bottom);

      case tmpByte of
        0..2:
           TLMDPNGObject(FPngList.Items[Index]).Draw(ACanvas, Rect(tmpRect.Left, tmpRect.Top, tmpRect.Left + tmpRect.Right, tmpRect.Top + tmpRect.Bottom));
        3: for i:=0 to he do
             for j:=0 to wi do
               begin
                 tmpRect := Rect(Left+j*bw, Top+i*bh, Left+(j+1)*bw, Top+(i+1)*bh);
                 TLMDPNGObject(FPngList.Items[Index]).Draw(ACanvas, tmpRect);
               end;
       end;
    end;
end;

procedure TLMDPNGImageList.DoDraw(Index: Integer; Canvas: TCanvas; X, Y: Integer; Style: Cardinal; Enabled: Boolean);
begin
  if (Index >= 0) and (Index < FPngList.Count) then
    TLMDPNGObject(FPngList.Items[Index]).Draw(Canvas, Rect(X, Y, X + Width, Y + Height));
end;

{ DefineProperties }

procedure TLMDPNGImageList.ReadImg(Stream : TStream); { private }
var
  i, LCount: integer;
  LVersion: integer;
  LPNG: TLMDPNGObject;
begin
  // todo
  Stream.ReadBuffer(LVersion, SizeOf(LVersion));
  if LVersion = -5 then
  begin
    Stream.ReadBuffer(LCount, SizeOf(LCount));
    if LCount > 0 then
    begin
      FPngList.Clear;
      for i := 0 to LCount - 1 do
      begin
        LPNG := TLMDPNGObject.Create;
        LPNG.LoadFromStream(Stream);
        AddPng(LPNG);
      end;
    end;
  end;
  if (Count <> LCount) then
    raise EReadError.Create('Failed to load ElImageList');
end; { ReadData }

procedure TLMDPNGImageList.WriteImg(Stream : TStream); { private }
var
  i, LCount: integer;
begin
  // Version - for ElPack ImageList it's -4 - for png list - -5
  LCount := -5;
  try
    Stream.WriteBuffer(LCount, SizeOf(integer));
    LCount := Count;
    Stream.WriteBuffer(LCount, SizeOf(integer));

    for i := 0 to Count - 1 do
      TLMDPNGObject(FPngList.Items[i]).SaveToStream(Stream);

  except
    on E: Exception do MessageBox(0, PChar('Failed to write LMDPNGImageList: ' + E.Message), nil, 0);
  end;
end; { WriteData }

function TLMDPNGImageList.Equal(IL : TLMDPNGImageList) : Boolean;
var
  ThisImage, OtherImage : TMemoryStream;

  function EqualStreams(S1, S2 : TMemoryStream) : Boolean;
  begin
    Result := (S1.Size = S2.Size) and CompareMem(S1.Memory, S2.Memory, S1.Size);
  end;

begin
  result := false;
  exit;
  if (IL = nil) or (Count <> IL.Count) then
  begin
    Result := False;
    Exit;
  end;
  if (Count = 0) and (IL.Count = 0) then
  begin
    Result := True;
    Exit;
  end;
  ThisImage := TMemoryStream.Create;
  try
    WriteImg(ThisImage);
    OtherImage := TMemoryStream.Create;
    try
      IL.WriteImg(OtherImage);
      Result := EqualStreams(ThisImage, OtherImage);
    finally
      OtherImage.Free;
    end;
  finally
    ThisImage.Free;
  end;
end;

function TLMDPNGImageList.GetBitmap(Index: Integer; Image: TBitmap): Boolean;
begin
  Result := False;
  if Assigned(Image) then
  begin
    if (Index >= 0) and (Index < Count) then
    begin
      Result := True;
      TLMDPNGObject(FPNGList.Items[Index]).AssignTo(Image);
    end;
  end;
end;

function TLMDPNGImageList.GetPNG(Index: Integer; Image: TLMDPNGObject): Boolean;
begin
  Result := False;
  if Assigned(Image) then
  begin
    if (Index >= 0) and (Index < Count) then
    begin
      Result := True;
      Image.Assign(FPNGList.Items[Index]);
    end;
  end;
end;

function TLMDPNGImageList.GetPngFileNameByIndex(const AIndex: Integer): TLMDString;
var
  LPngChunk: TLMDPngChunk;
  LPng: TLMDPngObject;
begin
  Result := '';
  LPng := PNG[AIndex];
  if Assigned(LPng) then
  begin
    LPngChunk := LPng.Chunks.ItemFromClass(TLMDPNGChunkzTXT);
    if Assigned(LPngChunk) then
      Result := TLMDString(TLMDPNGChunkzTXT(LPngChunk).Text);
  end;
end;

function TLMDPNGImageList.GetPNGs(Index: Integer): TLMDPNGObject;
begin
  Result := nil;
  if (Index >= 0) and (Index < FPNGList.Count) then
    Result := FPNGList.Items[Index];
end;

function TLMDPNGImageList.GetPngsByName(Index: TLMDString): TLMDPNGObject;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FPngList.Count - 1 do
    if GetPngFileNameByIndex(i) = Index then
      Result := PNG[i];
end;

procedure TLMDPNGImageList.Clear;
begin
  FPngList.Clear;
  inherited;
end;

procedure TLMDPNGImageList.Insert(AIndex: Integer; AImage, AMask: TBitmap);
begin
  ImageList_Add(Handle, AImage.Handle, AMask.Handle);
  FPngList.Insert(AIndex, MaskedPNG(AImage, AMask));
end;

procedure TLMDPNGImageList.InsertIcon(AIndex: Integer; AImage: TIcon);
begin
  // todo ;
end;

procedure TLMDPNGImageList.InsertMasked(AIndex: Integer; AImage: TBitmap; AMaskColor: TColor);
begin
  ImageList_Add(Handle, AImage.Handle, AMaskColor);
  FPngList.Insert(AIndex, MaskedColorPNG(AImage, AMaskColor));
end;
function TLMDPNGImageList.IndexOf(AObject: TLMDPNGObject): Integer;
begin
  Result := FPngList.IndexOf(AObject);
end;

constructor TLMDPNGImageList.Create(AOwner : TComponent);
begin
  inherited;
  FPngList := TLMDObjectList.Create;
  FPngList.AutoClearObjects := True;
end;

function TLMDPNGImageList.Add(Image, Mask: TBitmap): Integer;
var
  LTempPNG: TLMDPNGObject;
begin
  if Mask = nil then
  begin
    LTempPNG := TLMDPNGObject.Create;
    LTempPNG.Assign(Image)
  end
  else
    LTempPNG := MaskedPNG(Image, Mask);

  Result := AddPng(LTempPNG);
end;

function TLMDPNGImageList.AddPng(Image: TLMDPNGObject): Integer;
var
  LTemp: TBitmap;
begin
  if Assigned(Image) then
  begin
    LTemp := TBitmap.Create;
    Image.AssignTo(LTemp);
    LTemp.Width := Width;
    LTemp.Height := Height;
    ImageList_Add(Handle, LTemp.Handle, 0);
    // Old code - creates new instance of TLMDPNGObject
    //FPngList.Add(TLMDPNGObject.Create);
    //TLMDPNGObject(FPngList.Last).Assign(Image);
    // New code - just adds exists image
    FPngList.Add(Image);
    Result := FPngList.Count - 1;
    LTemp.Free;
  end
  else
    Result := -1;
end;

function TLMDPNGImageList.AddIcon(Image: TIcon): Integer;
begin
  Result := 0;
end;

function TLMDPNGImageList.AddMasked(AImage: TBitmap; AMaskColor: TColor): Integer;
begin
  Result := AddPng(MaskedColorPNG(AImage, AMaskColor));
end;

function TLMDPNGImageList.MaskedColorPNG(AImage: TBitmap; AMaskColor: TColor): TLMDPNGObject;
var
  i, j: Integer;
  LScanAlpha: PByteArray;
begin
  Result := TLMDPNGObject.Create;
  Result.Assign(AImage);
  if Result.Header.ColorType = COLOR_PALETTE then
    Result.TransparentColor := AMaskColor
  else
  begin
    Result.CreateAlpha;

    for i := 0 to Result.Height - 1 do
    begin
      LScanAlpha := Result.AlphaScanline[i];
      for j := 0 to Result.Width - 1 do
      begin
        LScanAlpha^[j] := Integer((AImage.Canvas.Pixels[j, i] <> AMaskColor)) * 255;
      end;
    end;
  end;
end;

Function TLMDPNGImageList.MaskedPNG(AImage, AMask: TBitmap): TLMDPNGObject;
var
  i, j: integer;
  LScanRow: PByteArray;
begin
  Result := TLMDPNGObject.Create;
  Result.Assign(AImage);

  Result.CreateAlpha;

  if Assigned(AMask) then
  begin
    for i := 0 to Result.Height - 1 do
    begin
      LScanRow := Result.AlphaScanline[i];
      for j := 0 to Result.Width - 1 do
        LScanRow^[j] := (AMask.Canvas.Pixels[j, i] and 255);
    end;
  end;
end;

procedure TLMDPNGImageList.Move(CurIndex, NewIndex: Integer);
begin
  FPngList.Move(CurIndex, NewIndex);
end;

procedure TLMDPNGImageList.Assign(Source: TPersistent);
var
  i: integer;
  pngobj: TLMDPNGObject;
  srclist: TLMDPNGImageList;
begin
  if Source is TLMDPNGImageList then
  begin
    srclist :=  TLMDPNGImageList(Source);
    Clear;
    for i := 0 to srclist.count - 1 do
    begin
      pngobj := TLMDPNGObject.Create;
      pngobj.Assign(srclist.PNG[i]);
      AddPng(pngobj);
    end;
  end
  else
    inherited;
end;

end.

