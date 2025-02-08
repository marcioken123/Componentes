unit LMDBitmapList;
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

LMDBitmapList unit (RM)
-----------------------
TLMDBitmapList container component.

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Graphics, Consts, Controls, Imglist, 
  LMDClass, LMDGraph, LMDCustomImageList, LMDBaseController, LMDCustomContainer
  ;

type

  {****************************************************************************}
  {----------------------TLMDBitmapListItem------------------------------------}
  TLMDBitmapListItem = class(TLMDListItem)
  private
    FBitmap:TBitmap;
    FPixelFormat:TLMDSavePixelFormat;
    function GetBitmap:TBitmap;
    procedure SetBitmap(aValue:TBitmap);
  protected
    function  GetEmpty:Boolean;override;
    procedure DefineProperties(Filer: TFiler);override;
    procedure ReadData(Stream:TStream);override;
    procedure WriteData(Stream:TStream);override;
    function  WriteFlag:Byte; override;
    procedure ReadState(Reader: TReader);override;
  public
    constructor Create(aOwner:TComponent);override;
    destructor Destroy;override;
    procedure Assign(Source:TPersistent);override;
    procedure FreeData; override;
  published
    property Bitmap:TBitmap read GetBitmap write SetBitmap stored false;
    property Compressed;
    property Ident stored false;
    property Description stored false;
    property PixelFormat:TLMDSavePixelFormat read FPixelFormat write FPixelFormat default spfDefault;
  end;

  {----------------------TLMDBitmapList----------------------------------------}
  TLMDBitmapList=class(TLMDCustomImageList)
  private
    function GetArrayItem(Index:Integer):TLMDBitmapListItem;
    function GetArrayNameItem(Index:String):TLMDBitmapListItem;
    function GetBitmap:TBitmap;
  protected
  public
    constructor Create(aOwner:TComponent);override;
    destructor Destroy;override;
    {common helpers for components}
    function BmpCanvas(index:Integer):TCanvas;override; {3.10}
    function ItemRect(index, item:Integer):TRect;override; {3.10}
    function Dimensions(index:Integer; tp:Byte):Integer;override;
    function IsValidItem(index, item:Integer):Boolean;override;
    procedure GetBitmapItem(index, item:Integer; tb:TBitmap);override;
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
    property Item:TBitmap read GetBitmap;
    {Array-> Eigenschaft}
    property Items[Index:Integer]:TLMDBitmapListItem read GetArrayItem;default;
    property ItemByName[Index:String]:TLMDBitmapListItem read GetArrayNameItem;
  published
    property DefaultCompressed;
    property DefaultPixelFormat;
  end;

function LMDBMLGetItem(const FileName:String; index:Integer; aBitmap:TBitmap):Boolean;

implementation
uses
  RtlConsts, Types, LMDStrings, LMDProcs, LMDGraphUtils,
  LMDStreamUtils;

{wrapper}
{------------------------------------------------------------------------------}
function LMDBMLGetItem(const FileName:String; index:Integer; aBitmap:TBitmap):Boolean;
var
  t:TLMDBitmapListItem;
begin
  t:=TLMDBitmapListItem.Create(nil);
  try
    result:=LMDListGetItemFromFile(FileName, icBitmap, nil, index, t);
    aBitmap.Assign(t.Bitmap);
  finally
    t.Free;
  end;
end;

{********************** class TLMDBitmapListItem ******************************}
{-------------------------- Private -------------------------------------------}
procedure TLMDBitmapListItem.SetBitmap(aValue:TBitmap);
begin
  FBitmap.Assign(aValue);
end;

{------------------------------------------------------------------------------}
function TLMDBitmapListItem.GetBitmap:TBitmap;
var
  tmp:String;
begin
  result:=FBitmap;
  if (csDesigning in ComponentState) or (csLoading in ComponentState) then exit;

  if FBitmap.Empty then
    try
      BeginUpdate;
      if not (Owner is TLMDCustomContainer) then exit;
      with TLMDCustomContainer(Owner) do
        case Source of
          sdAppResource:
            {-> Palette-Handling is included...}
            FBitmap.LoadFromResourceID(hInstance, Ident);
          sdComponent:
            result:=FBitmap;
          sdLibResource:
            if FilePrefix in [ppSystem, ppWindows] then
              LMDBmpLoadFromFile(FileName, Ident, FBitmap)
            else
              begin
                if FilePrefix<>ppFixed then
                  tmp:=LMDCreatePathPrefix(FilePrefix,True)
                else
                  tmp:=LMDAnsiSlashAdd(ExtractFilePath(FileName));
                tmp := tmp + copy(ExtractFileName(FileName), 1,3) + inttostr(Ident) + LMDICGetItemSUFFIX(icBitmap, True);
                LMDBmpLoadFromFile(tmp, Ident, FBitmap)
              end;
          sdFile: {bml-File}
            LMDBMLGetItem(LMDCreatePathPrefix(FilePrefix,True)+FileName, Ident, FBitmap);
          sdPath:
            begin
              if FilePrefix<>ppFixed then
                tmp:=LMDCreatePathPrefix(FilePrefix,True)
              else
                tmp:=LMDAnsiSlashAdd(ExtractFilePath(FileName));
              tmp:=tmp+copy(ExtractFileName(FileName), 1,3)+inttostr(Ident)+LMDICGetItemSUFFIX(icBitmap, True);
              FBitmap.LoadFromFile(tmp);
            end;
        end;
    finally
      EndUpdate(false);
    end;
end;

{-------------------------- Protected -----------------------------------------}
procedure TLMDBitmapListItem.Assign(Source:TPersistent);
begin
  if (Source is TLMDBitmapListItem) then
    begin
      AssignStd(Source);
      FBitmap.Assign(TLMDBitmapListItem(Source).Bitmap);
      FPixelFormat:=TLMDBitmapListItem(Source).PixelFormat;
      exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
procedure TLMDBitmapListItem.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty(IDS_INTERNAL, ReadData, WriteData, True);
end;

{------------------------------------------------------------------------------}
function TLMDBitmapListItem.GetEmpty:Boolean;
begin
  result := (FBitmap = nil) or FBitmap.Empty;
end;

{------------------------------------------------------------------------------}
procedure TLMDBitmapListItem.ReadData(Stream:TStream);
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
  if tmp and ITF_DATA=ITF_DATA then
    stReadBitmap(Stream, FBitmap, FCompressed);
end;

{------------------------------------------------------------------------------}
procedure TLMDBitmapListItem.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TLMDBitmapList then
    TLMDBitmapList(Reader.Parent).Add(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDBitmapListItem.WriteData(Stream:TStream);
begin
  WriteStd(Stream);
  if not FBitmap.Empty then stWriteBitmap(Stream, FBitmap, FCompressed, LMDPixelFormatColors[FPixelFormat]);
end;

{------------------------------------------------------------------------------}
function TLMDBitmapListItem.WriteFlag:Byte;
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
  if not FBitmap.Empty then
    result:=result or ITF_DATA;
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDBitmapListItem.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FBitmap:=TBitmap.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDBitmapListItem.Destroy;
begin
  FBitmap.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDBitmapListItem.FreeData;
begin
  FBitmap.Free;FBitmap:=TBitmap.Create;
end;

{********************** class TLMDBitmapList **********************************}
{-------------------------- Private -------------------------------------------}
function TLMDBitmapList.GetBitmap:TBitmap;
begin
  result:=TLMDBitmapListItem(FList[FIndex]).Bitmap;
end;

{------------------------------------------------------------------------------}
function TLMDBitmapList.GetArrayItem(Index:Integer):TLMDBitmapListItem;
begin
  result:=TLMDBitmapListItem(FList[Index]);
end;

{------------------------------------------------------------------------------}
function TLMDBitmapList.GetArrayNameItem(Index:String):TLMDBitmapListItem;
begin
  result:=TLMDBitmapListItem(ContentsByName[index]);
end;

{-------------------------- Protected -----------------------------------------}
{-------------------------- Public --------------------------------------------}
constructor TLMDBitmapList.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FListClass:=TLMDBitmapListItem;
  FListType:=icBitmap;
  FIndex:=0;

  if not LMD_ICRegistered[FListType] then
    begin
      LMD_ICRegistered[FListType]:=True;
      RegisterClass(TLMDBitmapListItem);
    end;
end;

{------------------------------------------------------------------------------}
destructor TLMDBitmapList.Destroy;
begin
  inherited Destroy;
end;

{helper routines for components}
{------------------------------------------------------------------------------}
function TLMDBitmapList.BmpCanvas(index:Integer):TCanvas;
begin
  result:=Items[index].Bitmap.Canvas;
end;

{------------------------------------------------------------------------------}
function TLMDBitmapList.ItemRect(index, item:Integer):TRect;
begin
  result:=Types.Rect(0,0, Items[index].Bitmap.Width, Items[index].Bitmap.Height);
end;

{------------------------------------------------------------------------------}
procedure TLMDBitmapList.GetBitmapItem(index, item:Integer; tb:TBitmap);
begin
  if Assigned(tb) then tb.Assign(Items[index].Bitmap);
end;

{------------------------------------------------------------------------------}
function TLMDBitmapList.IsValidItem(index, item:Integer):Boolean;
begin
  result:=(index<FList.Count) and (not Items[index].Empty);
end;

{returns
 with:   tp=0 or
 height: tp=1 of item}
{------------------------------------------------------------------------------}
function TLMDBitmapList.Dimensions(index:Integer; tp:Byte):Integer;
begin
  result:=0;
  if index<FList.Count then
    case tp of
      0: result:=Items[index].Bitmap.Width;
      1: result:=Items[index].Bitmap.Height;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBitmapList.ItemCount(index:Integer):Integer;
begin
  result:=0;
  if (index<FList.Count) and not (Items[index].Empty) then result:=1;
end;

{------------------------------------------------------------------------------}
function TLMDBitmapList.Palette(index:Integer):HPalette;
begin
  result:=0;
  if index<FList.Count then result:=Items[index].Bitmap.Palette;
end;

{------------------------------------------------------------------------------}
function TLMDBitmapList.Masked(index:Integer):Boolean;
begin
  result:=False;
end;

{------------------------------------------------------------------------------}
function TLMDBitmapList.TransparentColor(index, item:Integer):TColor;
begin
  result:=clWhite;
  if index<FList.Count then
    result:=Items[index].Bitmap.TransparentColor;
end;

{------------------------------------------------------------------------------}
function TLMDBitmapList.GetColorAtPoint(aPoint: TPoint; index, item:Integer): TColor;
begin
  result:=clWhite;
  if index<FList.Count then
    with aPoint do
      result:=Items[index].Bitmap.Canvas.Pixels[X,Y];
end;

{Drawing}
{------------------------------------------------------------------------------}
procedure TLMDBitmapList.Draw(Canvas: TCanvas; X, Y: Integer; ListIndex, Index: Integer);
begin
  LMDBmpDraw(Canvas, Bounds(x,y, Items[ListIndex].Bitmap.Width, Items[ListIndex].Bitmap.Height),
             Items[ListIndex].Bitmap, 0, 0);
end;

{------------------------------------------------------------------------------}
function TLMDBitmapList.DrawExt(Canvas:TCanvas; target:TRect; flags:Word; ListIndex, Index:Integer):TRect;
begin
  result:=LMDBmpDraw(Canvas, target, Items[ListIndex].Bitmap, flags, Items[ListIndex].Bitmap.TransparentColor);
end;

{Extended Drawing}
{------------------------------------------------------------------------------}
procedure TLMDBitmapList.ClipDraw(Canvas:TCanvas; target:TRect; flags:WORD;
                                  pos:LongInt; transColor:TColor; ListIndex, index:Integer);
begin
  LMDBmpClipDraw(Canvas, target, Items[ListIndex].Bitmap, flags, pos, transColor);
end;

end.
