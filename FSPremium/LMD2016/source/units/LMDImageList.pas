unit LMDImageList;
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

LMDImageList unit (RM)
----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Graphics, LMDGraph, LMDCustomImageList, 
  LMDCustomContainer;

type

  TLMDDrawingStyle=(dsFocus, dsSelected, dsNormal, dsTransparent);
  TLMDImageType=(itImage, itMask);

  {****************************************************************************}
  {----------------------TLMDImageListItem-------------------------------------}
  TLMDImageListItem = class(TLMDListItem)
  private
    FAllocBy,
    FHeight,
    FUsed,
    FWidth:Integer;

    FPixelFormat:TLMDSavePixelFormat;

    FBKColor,
    FBlendColor:TColor;
    FDrawingStyle:TLMDDrawingStyle;

    FImage,
    FMask:TBitmap;
    FInfo:TList;

    FImageType:TLMDImageType;

    FMasked,
    FShareImages:Boolean;

    function GetCount:Integer;
    procedure SetInteger(Index:Integer; aValue:Integer);
    procedure SetMaskedState(aValue:Boolean);
    procedure BuildInfoList(aValue:Integer);
    procedure CreatePattern(aValue:TBitmap; aInt:byte);
    procedure ReadStream(Stream:TStream);
    procedure WriteStream(Stream:TStream);
    procedure ClearImageInfoList;

  protected
    function CheckImage(aValue:TBitmap):Boolean;
    procedure ConvertBmpToIML(aValue:TBitmap; Count:Integer; Masked:Boolean);
    procedure DefineProperties(Filer: TFiler);override;
    function  GetEmpty:Boolean;override;
    function  PrepareSpace:Integer;
    procedure ReadData(Stream:TStream);override;
    procedure ReadState(Reader: TReader);override;
    procedure WriteData(Stream:TStream);override;
    function  WriteFlag:Byte; override;
    procedure InitAttributes(aWidth:Integer=16; aHeight:Integer=16);

    {Properties, not made public until yet}
    property ShareImages:Boolean read FShareImages write FShareImages default false;
  public
    constructor Create(aOwner:TComponent);override;
    procedure Assign(Source:TPersistent);override;
    constructor CreateSize(AWidth, AHeight: Integer);
    destructor Destroy;override;
    procedure FreeData; override;

    {Resources}
    //function FileLoad(ResType: TResType; const Name:String; MaskColor: TColor): Boolean;
    //function GetResource(ResType: TResType; const Name:String; Width: Integer;
    //                     LoadFlags: TLoadResources; MaskColor: TColor): Boolean;
    //function ResourceLoad(ResType:TResType; const Name:String; MaskColor: TColor):Boolean;}

    {Create from Bitmap}
    function LoadFromBitmap(const FileName:string; Count:Integer; Masked:Boolean):Boolean;

    {direct access}
    procedure GetBitmap(Index:Integer; Image:TBitmap);
    procedure GetMaskBitmap(Index:Integer; MaskBmp:TBitmap);
    function GetImageBitmap:TBitmap;
    function GetImageMaskBitmap:TBitmap;
    function GetImageRect(Index:Integer):TRect;

    {imagelist functions}
    function Add(Image, Mask: TBitmap):Integer;
    function AddMasked(Image:TBitmap; MaskColor: TColor): Integer;
    procedure AddImages(aValue:TLMDImageListItem);
    procedure Clear;
    procedure Delete(Index: Integer);
    procedure Insert(Index:Integer; Image, Mask:TBitmap);
    procedure InsertImages(Index:Integer; aValue:TLMDImageListItem);
    procedure InsertMasked(Index:Integer; Image:TBitmap; MaskColor:TColor);
    procedure Move(OldIndex, NewIndex:Integer);
    procedure Replace(Index: Integer; Image, Mask: TBitmap);
    procedure ReplaceMasked(Index:Integer; Image: TBitmap; MaskColor: TColor);

    {i/o}
    procedure LoadFromFile(const Filename: string);
    procedure SaveToFile(const Filename: string);

    {Drawing}
    procedure Draw(Canvas: TCanvas; X, Y: Integer; Index: Integer);
    function DrawExt(Canvas:TCanvas; target:TRect; flags:Word; Index:Integer):TRect;

    {Extended Drawing}
    procedure ClipDraw(Canvas:TCanvas; target:TRect; flags:WORD;
                       pos:LongInt; transColor:TColor; index:Integer);

    {helper}
    function TransparentColor(Index:Integer):TColor;
    function GetColorAtPoint(aPoint: TPoint; Index:Integer): TColor;

    {properties, read only}
    property Count:Integer read GetCount;
    property Info:TList read FInfo;

    {properties for display}
    property BKColor:TColor read FBKColor write FBKColor default clNone;
    property BlendColor:TColor read FBlendColor write FBlendColor default clNone;
    property DrawingStyle: TLMDDrawingStyle read FDrawingStyle write FDrawingStyle default dsNormal;
    property ImageType:TLMDImageType read FImageType write FImageType default itImage;
    property PixelFormat:TLMDSavePixelFormat read FPixelFormat write FPixelFormat default spfDefault;
    property Compressed;
  published
    property AllocBy:Integer read FAllocBy write FAllocBy default 4;
    property Description;
    property Masked:Boolean read FMasked write SetMaskedState default false;
    property Height:Integer index 1 read FHeight write SetInteger default 16;
    property Width:Integer index 0 read FWidth write SetInteger default 16;
  end;

  {----------------------TLMDImageList-----------------------------------------}
  TLMDImageList = class(TLMDCustomImageList)
  private
    function GetList:TLMDImageListItem;
    function GetArrayItem(Index:Integer):TLMDImageListItem;
    function GetArrayNameItem(Index:String):TLMDImageListItem;
  protected
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function GetChildOwner: TComponent; override;
  public
    procedure Assign(Source:TPersistent);override;
    constructor Create(aOwner:TComponent);override;
    destructor Destroy;override;

    {helpers for components}
    {general}
    function BmpCanvas(index:Integer):TCanvas;override; {3.10}
    function ItemRect(index, item:Integer):TRect;override; {3.10}
    function Dimensions(index:Integer; tp:Byte):Integer;override;
    procedure GetBitmapItem(index, item:Integer; tb:TBitmap); override;
    function IsValidItem(index, item:Integer):Boolean;override;
    function ItemCount(index:Integer):Integer;override;
    function Masked(index:Integer):Boolean; override;
    function Palette(index:Integer):HPalette;override;
    function TransparentColor(index, item:Integer):TColor;override;
    function GetColorAtPoint(aPoint: TPoint; index, item:Integer): TColor; override;
    {Drawing}
    procedure Draw(Canvas: TCanvas; X, Y: Integer; ListIndex, Index: Integer);override;
    function DrawExt(Canvas:TCanvas; target:TRect; flags:Word; ListIndex, Index:Integer):TRect;override;
    {Extended Drawing}
    procedure ClipDraw(Canvas:TCanvas; target:TRect; flags:WORD;
                       pos:LongInt; transColor:TColor; ListIndex, index:Integer);override;

    {properties}
    property Item:TLMDImageListItem read GetList;

    {Array-> Eigenschaft}
    property Items[Index:Integer]:TLMDImageListItem read GetArrayItem;default;
    property ItemByName[Index:String]:TLMDImageListItem read GetArrayNameItem;
  published
    property DefaultCompressed;
    property DefaultPixelFormat;
  end;

function LMDIMLGetItem(const FileName:String; index:Integer; aItem:TLMDImageListItem):Boolean;

implementation

uses
  RtlConsts, Types, Consts, 
  LMDClass, LMDSysIn, LMDGraphUtils, LMDStreamUtils;

{Helper}
{------------------------------------------------------------------------------}
function LMDIMLGetItem(const FileName:String; index:Integer; aItem:TLMDImageListItem):Boolean;
begin
  result:=LMDListGetItemFromFile(FileName, icImageList, nil, index, aItem);
end;

{------------------------------------------------------------------------------}
procedure InvalidOperation(const Str: String);
begin
  raise EInvalidGraphicOperation.Create(Str);
end;

type
  TLMDImageInfo = record
  Offset: SmallInt;
    HasMask: Boolean;
    Reserved: Boolean;
  end;

  PLMDImageInfo = ^TLMDImageInfo;

function AllocImageInfo: PLMDImageInfo;
var
  Info: PLMDImageInfo;
begin

  New(Info);
  FillChar(Info^, sizeof(Info^), 0);

  Result := Info;
end;

procedure DisposeImageInfo(Info: PLMDImageInfo);
begin
  if Assigned(Info)  then
    Dispose(Info);
    end;

{************************ Object TLMDImageListItem ****************************}
{------------------------- Private --------------------------------------------}
function TLMDImageListItem.GetCount:Integer;
begin
  result:=FInfo.Count;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.SetInteger(Index:Integer; aValue:Integer);
begin
  case Index of
    0:if (aValue<>FWidth) and (aValue>0) then FWidth:=aValue else exit;
    1:if (aValue<>FHeight) and (aValue>0) then FHeight:=aValue else exit;
  end;
  Clear;
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.SetMaskedState(aValue:Boolean);
var
  tmp:Integer;
begin
  if aValue<>FMasked then
    begin
      if FMasked then
        begin
          FMask.Width:=0;
          FMask.Dormant;
        end
      else
        begin
          FMask.Width:=FImage.Width;
          FMask.Height:=FHeight;
          FMask.Monochrome:=True;
        end;
      tmp:=FInfo.Count;
      ClearImageInfoList;
      FMasked:=aValue;
      BuildInfoList(tmp);
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.BuildInfoList(aValue:Integer);
var
  i:Integer;
  info: PLMDImageInfo;
begin
  for i:=0 to Pred(aValue) do
    begin
      info := AllocImageInfo;
      info.Offset:=i*FWidth;
      info.HasMask:=FMasked;
      FInfo.Add(TObject(info));
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.CreatePattern(aValue:TBitmap; AInt:byte);
var
  i,j:Integer;
begin
  if (aValue=nil) or (aValue.Empty) or (FBlendColor=clNone) then exit;
  with aValue.Canvas do
    if aInt=0 then
      begin
        for i:=0 to aValue.Width do
          for j:=0 to aValue.Height do
           if (i mod 2=0) or (j mod 2=0) then
              Pixels[i,j]:=FBlendColor;
      end
    else
      for i:=0 to aValue.Width do
        for j:=0 to aValue.Height do
         if (i mod 2=0) xor (j mod 2=0) then
            Pixels[i,j]:=FBlendColor;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.ReadData(Stream:TStream);
var
  tmp:Byte;
begin

  tmp:=ReadStd(Stream);

  if tmp and ITF_BMPMono=ITF_BMPMono then
    FPixelFormat:=spfMono
  else
    if tmp and ITF_BMP16=ITF_BMP16 then
      FPixelFormat:=spf4Bit
    else
      if tmp and ITF_BMP256=ITF_BMP256 then
        FPixelFormat:=spf8Bit
      else
        if tmp and ITF_BMP65K=ITF_BMP65K then
          FPixelFormat:=spf16Bit
        else
          FPixelFormat:=spfDefault;

  {Header of a TLMDImageListItem}
  FHeight:=stReadInteger(Stream);
  FWidth:=stReadInteger(Stream);
  FAllocBy:=stReadInteger(Stream);
  FMasked:=Boolean(stReadByte(Stream));
  {-----------------------------------}
  ReadStream(Stream);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TLMDImageList then
    TLMDImageList(Reader.Parent).Add(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.ReadStream(Stream:TStream);
var
  count:LongInt;
begin

  Clear;
  Stream.ReadBuffer(Count, SizeOf(Count));
  if Count>0 then
    begin
      stReadBitmap(Stream, FImage, FCompressed);
      if FMasked then stReadBitmap(Stream, FMask, FCompressed) else FMask.Width:=0;
    end;
  FUsed:=FImage.Width;
  BuildInfoList(Count);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.WriteData(Stream:TStream);
begin
  WriteStd(Stream);
  {Header of TLMDImageListItem}
  stWriteInteger(Stream, FHeight);
  stWriteInteger(Stream, FWidth);
  stWriteInteger(Stream, FAllocBy);
  stWriteByte(Stream, Ord(FMasked));
  {-----------------------------------}
  WriteStream(Stream);
end;

{------------------------------------------------------------------------------}
function TLMDImageListItem.WriteFlag:Byte;
begin
  result:=inherited WriteFlag;
  case FPixelFormat of
    spfMono: result:=result or ITF_BMPMono;
    spf4Bit: result:=result or ITF_BMP16;
    spf8Bit: result:=result or ITF_BMP256;
    // 7.01
    spf16Bit: result:=result or ITF_BMP65K;
    // ---
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.WriteStream(Stream:TStream);
var
  Size:LongInt;
begin
  Size:=Count;
  Stream.Write(Size, SizeOf(Size));
  if Size>0 then
    begin
      FImage.Width:=Size*FWidth;
      FUsed:=FImage.Width;
      stWriteBitmap(Stream, FImage, FCompressed, LMDPixelFormatColors[FPixelFormat]);
      if FMasked then
        stWriteBitmap(Stream, FMask, FCompressed, LMDPixelFormatColors[spfMono]);
    end;
end;

{-------------------------- Protected -----------------------------------------}
function TLMDImageListItem.CheckImage(aValue:TBitmap):Boolean;
begin
  result:=false;
  if aValue=nil then exit;
  with aValue do
    if (Height=FHeight) and ((Width Mod FWidth)=0) then
      result:=True
    else
      InvalidOperation(SInvalidImageSize);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.ConvertBmpToIML(aValue:TBitmap; Count:Integer; Masked:Boolean);
var
  newImage, Mask:TBitmap;
begin
  Clear;
  FHeight:=aValue.Height;
  FWidth:=aValue.Width div Count;
  FMasked:=Masked;

  if Masked then
    begin
      NewImage:=TBitmap.Create;
      try
        Mask:=TBitmap.Create;
        try
          LMDBmpCreateMasks(aValue, Mask, NewImage, aValue.TransparentColor);
          FImage.Assign(NewImage);
          FMask.Assign(Mask);
        finally
          Mask.Free;
        end;
      finally
        NewImage.Free;
      end;
    end
  else
    begin
      FImage.Assign(aValue);
      FMask.Width:=0;
    end;

  FUsed:=FImage.Width;
  BuildInfoList(Count);
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Bitmap', ReadStream, nil, false);
  Filer.DefineBinaryProperty(IDS_INTERNAL, ReadData, WriteData, True);
end;

{------------------------------------------------------------------------------}
function TLMDImageListItem.GetEmpty:Boolean;
begin
  result:= (FInfo.Count=0);
end;

{------------------------------------------------------------------------------}
function TLMDImageListItem.GetImageBitmap:TBitmap;
begin
  result:=FImage;
end;

{------------------------------------------------------------------------------}
function TLMDImageListItem.GetImageMaskBitmap:TBitmap;
begin
  result:=FMask;
end;

{------------------------------------------------------------------------------}
function TLMDImageListItem.GetImageRect(Index:Integer):TRect;
var
  info: PLMDImageInfo;
begin
  Info := PLMDImageInfo(FInfo[Index]);
  Result := Bounds(info.Offset, 0, FWidth ,FHeight);
end;

{------------------------------------------------------------------------------}
function TLMDImageListItem.PrepareSpace: Integer;
var
  newW:LongInt;
  info: PLMDImageInfo;

begin
  Inc(FUsed, FWidth);

  if FUsed>FImage.Width then
    begin
      NewW:=FImage.Width+(FAllocBy*FWidth);
      if NewW>32768 then InvalidOperation(STooManyImages);
      FImage.Width:=NewW;
      if FMasked then FMask.Width:=FImage.Width;
    end;

  Result := FInfo.Count;
  info := AllocImageInfo;
  info.Offset := FWidth * Result;
  FInfo.Add(info);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.InitAttributes(aWidth:Integer=16; aHeight:Integer=16);
begin
  {Owner}
  FInfo := TList.Create;
  FImage := TBitmap.Create;
  FMask := TBitmap.Create;

  FUsed:=0;
  FAllocBy:=4;
  FBlendColor:=clNone;
  FBKColor:=clNone;
  FDrawingStyle:=dsNormal;
  FHeight:=aHeight;
  FImageType:=itImage;
  FShareImages:=False;
  FWidth:=aWidth;

  FImage.Height:=FHeight;
  FMask.Height:=FHeight;
  FMasked:=False;
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDImageListItem.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  InitAttributes;
end;

{------------------------------------------------------------------------------}
constructor TLMDImageListItem.CreateSize(aWidth, aHeight:Integer);
begin
  inherited Create(nil);
  InitAttributes(aWidth, aHeight);
  if (AHeight < 1) or (AWidth < 1) then
    InvalidOperation(SInvalidImageSize);
end;

{------------------------------------------------------------------------------}
destructor TLMDImageListItem.Destroy;
begin
  ClearImageInfoList;
  FInfo.Free;
  FImage.Free;
  FMask.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.Assign(Source:TPersistent);
var
  S: TLMDImageListItem;
begin
  if (Source is TLMDImageListItem) then
    begin
      S := TLMDImageListItem(Source);
      FCompressed:=S.Compressed;
      FDescription:=S.Description;
      FPixelFormat:=S.PixelFormat;
      FIdent:=S.Ident;
      {weitere Eigenschaften nicht vergessen!!!}
      FAllocBy:=S.AllocBy;
      FBKColor:=S.BKColor;
      FBlendColor:=S.BlendColor;
      FDrawingStyle:=S.DrawingStyle;
      FHeight:=S.Height;
      FImageType:=S.ImageType;
      FMasked:=S.Masked;
      FShareImages:=S.ShareImages;
      FWidth:=S.Width;
      Clear;
      AddImages(S);
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
function TLMDImageListItem.Add(Image, Mask:TBitmap):Integer;
begin
  result:=-1;
  if (Image=nil) and (Mask=nil) then
    begin
      result:=PrepareSpace;
      exit;
    end;

  if not CheckImage(Image) then exit;
  if FMasked and (Mask<>nil) then
    if not CheckImage(Mask) then exit;
  result:=PrepareSpace;
  Replace(Result, Image, Mask);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.AddImages(aValue:TLMDImageListItem);
var
  newW:Integer;
  i:Integer;
  info1, info2: PLMDImageInfo;

begin
  if (FWidth<>aValue.Width) or (FHeight<>aValue.Height) then
    InvalidOperation(SInvalidImageSize);

  if aValue.Count=0 then exit;

  BeginUpdate;
  newW:=FUsed+(aValue.Count*FWidth);
  if NewW>32768 then InvalidOperation(STooManyImages);

  if FImage.Width<newW then
    begin
      FImage.Width:=newW;
      if FMasked then FMask.Width:=FImage.Width;
    end;

  FImage.Canvas.CopyRect(Bounds(FUsed, 0, aValue.Count*FWidth, FHeight),
                         aValue.GetImageBitmap.Canvas,
                         Rect(0,0, aValue.Count*FWidth, FHeight));
  {BitBlt(FImage.Canvas.Handle, FUsed, 0, aValue.Count*FWidth, FHeight,
         aValue.GetImageBitmap.Canvas.Handle, 0,0, SRCCOPY);}

  if FMasked and aValue.Masked then
    FMask.Canvas.CopyRect(Bounds(FUsed, 0, aValue.Count*FWidth, FHeight),
                           aValue.GetImageMaskBitmap.Canvas,
                           Rect(0,0, aValue.Count*FWidth, FHeight));
    {BitBlt(FMask.Canvas.Handle, FUsed, 0, aValue.Count*FWidth, FHeight,
           aValue.GetImageMaskBitmap.Canvas.Handle, 0,0, SRCCOPY);}

  For i:=0 to Pred(aValue.Count) do
    begin
      info1 := PLMDImageInfo(aValue.Info[i]);
      info2 := AllocImageInfo;
      info2.HasMask:=info1.HasMask;
      info2.Reserved:=info1.Reserved;
      info2.Offset:=FInfo.Count*FWidth;
      FInfo.Add(TObject(info2));
    end;
  FUsed:=newW;
  EndUpdate(True);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.InsertImages(Index:Integer; aValue:TLMDImageListItem);
var
  i:Integer;
  b, m:TBitmap;

begin
  if (FWidth<>aValue.Width) or (FHeight<>aValue.Height) then
    InvalidOperation(SInvalidImageSize);

  if aValue.Count=0 then exit;

  b:=TBitmap.Create;
  if FMasked then m:=TBitmap.Create else m:=nil;
  BeginUpdate;
  try
    for i:=Pred(aValue.Count) downto 0 do
      begin
        aValue.GetBitmap(i, b);
        if FMasked then
          begin
            if aValue.Masked then
              begin
                aValue.GetMaskBitmap(i, m);
                Insert(Index, b, m);
              end
            else
             InsertMasked(Index, b, b.TransparentColor);
          end
        else
          Insert(Index, b, m);
      end
  finally
    b.Free;
    if m<>nil then m.Free;
    EndUpdate(True);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDImageListItem.AddMasked(Image:TBitmap; MaskColor:TColor):Integer;
begin
  result:=-1;
  if not CheckImage(Image) then exit;
  result:=PrepareSpace;
  ReplaceMasked(result, Image, MaskColor);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.Clear;
begin
  BeginUpdate;

  FImage.ReleaseHandle;
  FImage.Width:=0;
  FImage.Height:=FHeight;

  FImage.Monochrome:=False;
  if FMasked then
    begin
      FMask.Width:=0;
      FMask.Height:=FHeight;
      FMask.Monochrome:=True;
    end
  else
    begin
      FMask.Width:=0;
      FMask.Dormant;
    end;
  FUsed:=0;
  ClearImageInfoList;

  EndUpdate(False);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.Delete(Index:Integer);
var
  Info: PLMDImageInfo;
  //oldR: TRect;
  i: Integer;
begin
  if index>FInfo.Count-1 then exit;
  Info:= PLMDImageInfo(FInfo[Index]);

  if FUsed=FImage.Width then
    begin
      FImage.Width:=FImage.Width+(FAllocBy*FWidth);
      if FMasked then FMask.Width:=FImage.Width;
    end;

  with Info^ do

    begin
//      newR:=Rect(Offset, 0, FUsed, FHeight);
      Dec(FUsed, FWidth);
//      oldR:=Rect(Offset + FWidth, 0, FUsed, FHeight);
      FImage.Canvas.CopyRect(Bounds(Offset, 0, FUsed+FWidth, FHeight), FImage.Canvas,
                             Bounds(Offset+FWidth, 0, FUsed+FWidth, FHeight));
      if FMasked then
        FMask.Canvas.CopyRect(Bounds(Offset, 0, FUsed+FWidth, FHeight), FMask.Canvas,
                              Bounds(Offset+FWidth, 0, FUsed+FWidth, FHeight));
    end;

   if FInfo.Count>1 then
     For i:=index+1 to Pred(FInfo.Count) do
       begin
         info:= PLMDImageInfo(FInfo[i]);
         Dec(info.Offset, FWidth);
         FInfo[i] := TObject(info);
       end;

  DisposeImageInfo(PLMDImageInfo(FInfo[Index]));
  FInfo.Delete(Index);
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.Draw(Canvas:TCanvas; X, Y:Integer; Index:Integer);
var
  Info: PLMDImageInfo;
  bmp:TBitmap;

  procedure DrawTransparent(aCanvas:TCanvas; aBmp:TBitmap);
  var
    old:TCopyMode;
  begin
    old:=aCanvas.CopyMode;
    aCanvas.CopyMode:=cmSrcAnd;
    aCanvas.CopyRect(Bounds(x, y, FWidth, FHeight), FMask.Canvas, Bounds(info.Offset, 0, FWidth, FHeight));
    aCanvas.CopyMode:=cmSrcPaint;
    if aBmp<>nil then
      aCanvas.CopyRect(Bounds(x, y, FWidth, FHeight), aBmp.Canvas, Rect(0, 0, FWidth, FHeight))
    else
      aCanvas.CopyRect(Bounds(x, y, FWidth, FHeight), FImage.Canvas, Bounds(info.Offset, 0, FWidth, FHeight));
    aCanvas.CopyMode:=old;
  end;

begin
  Info := PLMDImageInfo(FInfo[Index]);

  with info^ do

    if FMasked and not (FImageType=itMask) then
      case FDrawingStyle of
        dsSelected, dsFocus:
          begin
            bmp:=TBitmap.Create;
            with Bmp.Canvas do
              try
                LMDBmpCreateFromRect(bmp, Rect(0,0,FWidth, FHeight), FBKColor);
                DrawTransparent(bmp.Canvas, nil);
                if FDrawingStyle=dsSelected then CreatePattern(bmp, 1) else CreatePattern(bmp, 0);
                Canvas.CopyRect(Bounds(x, y, FWidth, FHeight), bmp.Canvas, Rect(0,0, FWidth, FHeight));
              finally
                bmp.Free;
              end;
          end;
        dsNormal:
          if FBKColor=clNone then
            DrawTransparent(Canvas, nil)
          else
            begin
              bmp:=TBitmap.Create;
              try
                LMDBmpCreateFromRect(bmp, Rect(0,0,FWidth, FHeight), FBKColor);
                DrawTransparent(bmp.Canvas, nil);
                Canvas.CopyRect(Bounds(x, y, FWidth, FHeight), bmp.Canvas, Rect(0,0, FWidth, FHeight));
              finally
                bmp.Free;
              end;
            end;
        dsTransparent:
          DrawTransparent(Canvas, nil);
      end
    else
      if FMasked then
        Canvas.CopyRect(Bounds(x, y, FWidth, FHeight), FMask.Canvas, Bounds(Offset,0, FWidth, FHeight))
      else
        Canvas.CopyRect(Bounds(x, y, FWidth, FHeight), FImage.Canvas, Bounds(Offset,0, FWidth, FHeight))
end;

{------------------------------------------------------------------------------}
function TLMDImageListItem.DrawExt(Canvas:TCanvas; target:TRect; flags:Word; Index:Integer): TRect;
var
  Info: PLMDImageInfo;
begin
  SetRectEmpty(result);
  Info := PLMDImageInfo(FInfo[Index]);

  with info^ do

    if FMasked then
      begin
        flags:=flags or DSF_TRANSPARENCY_MASK;
        result:=LMDBmpDrawExt(Canvas, target, FImage.Canvas, Bounds(Offset, 0, FWidth ,FHeight ), flags,
                              0, 0, FMask.Canvas);
      end
    else
      result:=LMDBmpDrawExt(Canvas, target, FImage.Canvas, Bounds(Offset, 0, FWidth, FHeight ), flags,
                            FImage.Canvas.Pixels[Offset, FHeight-1] or $02000000, 0, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.ClipDraw(Canvas:TCanvas; target:TRect; flags:WORD;
                                     pos:LongInt; transColor:TColor; index:Integer);
var
  Info: PLMDImageInfo;
begin
  Info := PLMDImageInfo(FInfo[Index]);

  with info^ do

    if FMasked then
      begin
        flags:=flags or DSF_TRANSPARENCY_MASK;
        LMDBmpClipDrawExt(Canvas, target, FImage.Canvas, Bounds(Offset, 0, FWidth ,FHeight ), flags,
                      pos, 0, FMask.Canvas);
      end
    else
      LMDBmpClipDrawExt(Canvas, target, FImage.Canvas, Bounds(Offset, 0, FWidth, FHeight ), flags,
                        pos, transColor, nil);

end;

{------------------------------------------------------------------------------}
function TLMDImageListItem.TransparentColor(Index:Integer):TColor;
var
  info: PLMDImageInfo;
begin
  Info := PLMDImageInfo(FInfo[Index]);
  result:=FImage.Canvas.Pixels[info.Offset, FHeight-1];
end;

{------------------------------------------------------------------------------}
function TLMDImageListItem.GetColorAtPoint(aPoint: TPoint; Index:Integer): TColor;
var
  info: PLMDImageInfo;
begin
  Info := PLMDImageInfo(FInfo[Index]);

  with aPoint do
    result:=FImage.Canvas.Pixels[info.Offset+X, Y];
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.FreeData;
begin
  Clear;
end;

{------------------------------------------------------------------------------}
{function TLMDImageListItem.FileLoad(ResType: TResType; const Name:String; MaskColor: TColor): Boolean;
begin
  result:=False;
  if ResType<>rtBitmap then exit;
end;

{------------------------------------------------------------------------------}
{function TLMDImageListItem.GetResource(ResType: TResType; const Name:String; Width: Integer;
                                         LoadFlags: TLoadResources; MaskColor: TColor): Boolean;
begin
  result:=False;
  if ResType<>rtBitmap then exit;
end;

{------------------------------------------------------------------------------}
{function TLMDImageListItem.ResourceLoad(ResType:TResType; const Name:String; MaskColor: TColor):Boolean;
begin
  result:=False;
  if ResType<>rtBitmap then exit;
end;

{------------------------------------------------------------------------------}
function TLMDImageListItem.LoadFromBitmap(const FileName:string; Count:Integer; Masked:Boolean):Boolean;
var
  t:TBitmap;

begin
  result:=false;
  t:=TBitmap.Create;
  try
    t.LoadFromFile(FileName);
    {check if Bitmap not empty and parameter Count is valid}
    if not t.Empty and (t.Width mod Count = 0) then
      begin
        ConvertBmpToIML(t, Count, Masked);
        Description:=ExtractFileName(FileName);
      end
    else
      raise Exception.Create(format('%s: %s', [SFOpenError, FileName]));
    result:=True;
  finally
    t.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.GetBitmap(Index:Integer; Image:TBitmap);
var
  info: PLMDImageInfo;
begin
  if not Assigned(Image) then exit;
  Image.Width:=FWidth;
  Image.Height:=FHeight;
  Info := PLMDImageInfo(FInfo[Index]);

  Image.Canvas.CopyRect(Rect(0, 0, FWidth, FHeight), FImage.Canvas,
      Bounds(info.Offset,0, FWidth, FHeight));
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.GetMaskBitmap(Index:Integer; MaskBmp:TBitmap);
var
  info: PLMDImageInfo;
begin
  if not (FMasked and Assigned(FMask)) then exit;
  MaskBmp.Width:=FWidth;
  MaskBmp.Height:=FHeight;
  Info := PLMDImageInfo(FInfo[Index]);
  MaskBmp.Canvas.CopyRect(Rect(0, 0, FWidth, FHeight), FMask.Canvas,
      Bounds(info.Offset,0, FWidth, FHeight));
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.Insert(Index:Integer; Image, Mask:TBitmap);
var
  i:Integer;
  info: PLMDImageInfo;

begin
  if Index>=FInfo.Count then
    begin
      Add(Image, Mask);
      exit;
    end;

  if not CheckImage(Image) then exit;
  if FMasked and (Mask<>nil) then
    if not CheckImage(Mask) then exit;

  PrepareSpace;

  Info := PLMDImageInfo(FInfo[Index]);

  {Create Space on FImageBitmap}
  FImage.Canvas.CopyRect(Bounds(info.Offset+FWidth,  0, FUsed, FHeight), FImage.Canvas,
                         Bounds(info.Offset, 0, FUsed, FHeight));
  if FMasked then
     FMask.Canvas.CopyRect(Bounds(info.Offset+FWidth,  0, FUsed, FHeight), FMask.Canvas,
                           Bounds(info.Offset, 0, FUsed, FHeight));

  {update FInfo-Records}
  FInfo.Exchange(Pred(FInfo.Count), Index);

  For i:=Pred(FInfo.Count) downto Index do
    begin
      info := PLMDImageInfo(FInfo[i]);
      info.Offset:=i*FWidth;
      FInfo[i] := TObject(info);
    end;

  Replace(Index, Image, Mask);

end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.InsertMasked(Index:Integer; Image:TBitmap; MaskColor:TColor);
var
  Mask, NewImage:TBitmap;
begin
  if not CheckImage(Image) then exit;

  if not FMasked then
    begin
      Insert(Index, Image, nil);
      exit;
    end;

  NewImage:=TBitmap.Create;
  try
    Mask:=TBitmap.Create;
    try
      LMDBmpCreateMasks(Image, Mask, NewImage, MaskColor);
      Insert(Index, NewImage, Mask);
    finally
      Mask.Free;
    end;
  finally
    NewImage.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.LoadFromFile(const Filename: string);
var
  Stream: TStream;

  temp: String[8];

  aCount:LongInt;
begin
  Stream:=TFileStream.Create(Filename, fmOpenRead or fmShareDenyWrite);
  try

    Stream.Read(temp, sizeof(temp));

    if temp=LMD_ICINFO[icImageList] then
      begin
        {check - we load only first image-list, following value has no effect}
        Stream.Read(aCount, sizeof(aCount));
        stReadInteger(Stream);
        LoadFromStream(Stream)
      end
    else
      raise Exception.Create(format('%s: %s', [SFOpenError, ClassName]));
  finally
    Stream.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.Move(OldIndex, NewIndex:Integer);
var
  img, msk:TBitmap;
  info: PLMDImageInfo;
begin

  if OldIndex=NewIndex then exit;

  info := PLMDImageInfo(FInfo[OldIndex]);
  img:=TBitmap.Create;

  if FMasked then
    msk:=TBitmap.Create
  else
    msk:=nil;

  try
    with img do
      begin
        Width:=FWidth;
        Height:=FHeight;
        Canvas.CopyRect(Rect(0,0,FWidth, FHeight), FImage.Canvas,
                        Bounds(info.Offset, 0, FWidth, FHeight));
      end;

    if FMasked then
      with msk do
        begin
          Width:=FWidth;
          Height:=FHeight;
          MonoChrome:=True;
          Canvas.CopyRect(Rect(0,0,FWidth, FHeight), FMask.Canvas,
                          Bounds(info.Offset, 0, FWidth, FHeight));
        end;

    BeginUpdate;
    Delete(OldIndex);
    Insert(NewIndex, img, Msk);

    EndUpdate(True);
  finally
    msk.Free;
    img.Free;
  end;

end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.Replace(Index:Integer; Image, Mask:TBitmap);
var
  info: PLMDImageInfo;
begin

  if not CheckImage(Image) then exit;

  if FMasked and (Mask<>nil) then
    if not CheckImage(Mask) then exit;

  Info := PLMDImageInfo(FInfo[Index]);

  with Info^ do

    begin
      FImage.Canvas.CopyRect(Bounds(Offset, 0, FWidth, FHeight), Image.Canvas,
                             Rect(0,0, FWidth, FHeight));
      if FMasked then
        begin
          HasMask:=Assigned(Mask);
          if HasMask then
            begin
              FMask.Monochrome:=True;
              FMask.Canvas.CopyRect(Bounds(Offset, 0, FWidth, FHeight), Mask.Canvas,
                                    Rect(0,0, FWidth, FHeight));

            end
          else   {mask empty?}
            begin
              FMask.Canvas.Brush.Color:=clBlack;
              FMask.Canvas.FillRect(Bounds(Offset, 0, FWidth, FHeight));
            end;
        end;
    end;

  FInfo[Index]:= TObject(Info);
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.ReplaceMasked(Index:Integer; Image:TBitmap; MaskColor:TColor);
var
  Mask, NewImage:TBitmap;
begin
  if not CheckImage(Image) then exit;

  if not FMasked then
    begin
      Replace(Index, Image, nil);
      exit;
    end;

  NewImage:=TBitmap.Create;
  try
    Mask:=TBitmap.Create;
    try
      LMDBmpCreateMasks(Image, Mask, NewImage, MaskColor);
      Replace(Index, NewImage, Mask);
    finally
      Mask.Free;
    end;
  finally
    NewImage.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.SaveToFile(const filename:String);
var
  Stream: TStream;
  aCount:LongInt;
  begin
  Stream := TFileStream.Create(Filename, fmCreate);
  try
    {IML-Header
     ----------}
    aCount:=1;
//    LMDAnsiStringToStream(LMD_ICINFO[icImageList], Stream);
    Stream.Write(LMD_ICINFO[icImageList], sizeof(LMD_ICINFO[icImageList]));
    Stream.Write(aCount, sizeof(aCount));
    stWriteInteger(Stream, Stream.Position+sizeof(LongInt));
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListItem.ClearImageInfoList;
var
  i: integer;
begin
  if  Assigned(FInfo) then
    begin
      for i := 0 to FInfo.Count - 1 do
        DisposeImageInfo(PLMDImageInfo(FInfo[i]));

      FInfo.Clear;
    end;
end;

{********************** class TLMDImageList ***********************************}
{-------------------------- Private -------------------------------------------}
function TLMDImageList.GetArrayItem(Index:Integer):TLMDImageListItem;
begin
  result:=TLMDImageListItem(FList[Index]);
end;

{------------------------------------------------------------------------------}
function TLMDImageList.GetList:TLMDImageListItem;
begin
  result:=TLMDImageListItem(FList[FIndex]);
end;

{------------------------------------------------------------------------------}
function TLMDImageList.GetArrayNameItem(Index:String):TLMDImageListItem;
begin
  result:=TLMDImageListItem(ContentsByName[index]);
end;

{-------------------------- Protected -----------------------------------------}
procedure TLMDImageList.Assign(Source:TPersistent);
begin
  if (Source is TLMDImageList) then
    begin
      BeginUpdate;
      try
        Clear;
        AddList(TLMDImageList(Source));
        FDefault:=TLMDImageList(Source).DefaultCompressed;
        FDefaultPixel:=TLMDImageList(Source).DefaultPixelFormat;
        FIndex:=0;
      finally
        EndUpdate(True);
      end;
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageList.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  i: Integer;
begin
  for i:=0 to Pred(FList.Count) do
    Proc(TLMDImageListItem(FList[i]));
end;

{------------------------------------------------------------------------------}
function TLMDImageList.GetChildOwner: TComponent;
begin
  result:=self
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDImageList.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FListClass:=TLMDImageListItem;
  FListType:=icImageList;
  FIndex:=0;

  if not LMD_ICRegistered[FListType] then
    begin
      LMD_ICRegistered[FListType]:=True;
      RegisterClass(TLMDImageListItem);
    end;
end;

{------------------------------------------------------------------------------}
destructor TLMDImageList.Destroy;
begin
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDImageList.BmpCanvas(index:Integer):TCanvas;
begin
  result:=TLMDImageListItem(FList[index]).GetImageBitmap.Canvas;
end;

{------------------------------------------------------------------------------}
function TLMDImageList.ItemRect(index, item:Integer):TRect;
begin
  result:=TLMDImageListItem(FList[index]).GetImageRect(item);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageList.GetBitmapItem(index, item:Integer; tb:TBitmap);
begin
  if Assigned(tb) then TLMDImageListItem(FList[index]).GetBitmap(item, tb);
end;

{------------------------------------------------------------------------------}
function TLMDImageList.IsValidItem(index, item:Integer):Boolean;
begin
  result:=(index<FList.Count) and (item<TLMDImageListItem(FList[index]).Count) and
          (item>-1);
end;

{returns
 with:   tp=0 or
 height: tp=1 of item}
{------------------------------------------------------------------------------}
function TLMDImageList.Dimensions(index:Integer; tp:Byte):Integer;
begin
  result:=0;
  if index<FList.Count then
    case tp of
      0: result:=Items[index].Width;
      1: result:=Items[index].Height;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDImageList.ItemCount(index:Integer):Integer;
begin
  if index<FList.Count then result:=Items[index].Count else result:=-1;
end;

{------------------------------------------------------------------------------}
function  TLMDImageList.Masked(index:Integer):Boolean;
begin
  result:=Items[index].Masked;
end;

{------------------------------------------------------------------------------}
function TLMDImageList.Palette(index:Integer):HPalette;
begin
  result:=0;
  if index<FList.Count then
    result:=Items[index].GetImageBitmap.Palette;
end;

{------------------------------------------------------------------------------}
function TLMDImageList.TransparentColor(index, item:Integer):TColor;
begin
  result:=clWhite;
  if index<FList.Count then
    result:=Items[index].TransparentColor(item);
end;

{------------------------------------------------------------------------------}
function TLMDImageList.GetColorAtPoint(aPoint: TPoint; index, item:Integer): TColor;
begin
  result:=clWhite;
  if index<FList.Count then
    with aPoint do
      result:=Items[index].GetColorAtPoint(aPoint,Item);
end;

{Drawing}
{------------------------------------------------------------------------------}
procedure TLMDImageList.Draw(Canvas: TCanvas; X, Y: Integer; ListIndex, Index: Integer);
begin
  TLMDImageListItem(FList[ListIndex]).Draw(Canvas, x,y, index);
end;

{------------------------------------------------------------------------------}
function TLMDImageList.DrawExt(Canvas:TCanvas; target:TRect; flags:Word; ListIndex,
                                Index:Integer):TRect;
begin
  result := TLMDImageListItem(FList[ListIndex]).DrawExt(Canvas, target, flags, index);
end;

{Extended Drawing}
{------------------------------------------------------------------------------}
procedure TLMDImageList.ClipDraw(Canvas:TCanvas; target:TRect; flags:WORD;
                                  pos:LongInt; transColor:TColor; ListIndex, index:Integer);
begin
  TLMDImageListItem(FList[ListIndex]).ClipDraw(Canvas, target, flags, pos, transcolor, index);
end;

end.
