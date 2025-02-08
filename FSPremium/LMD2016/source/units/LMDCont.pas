unit LMDCont;
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

LMDCont unit (RM)
-----------------
Base class and helper methods for LMD container controls.

Changes
-------
Release 8.06 (March 2008)
+ LMDIMLItemIcon method

Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Graphics, Consts, Controls, Imglist,
  LMDGraphicList, LMDCustomImageList, LMDBitmapList, LMDImageList, LMDWaveList,
  LMDStringList, LMDCustomComponent, LMDBaseController;

const
  LMD_ICGLOBALBML:String='Global BitmapList';
  LMD_ICGLOBALIML:String='Global ImageList';

type
  {**************************** LMD Container *********************************}
  {------------------------ Class TLMDContainer -------------------------------}
  TLMDContainer=class(TLMDBaseController)
  private
    FBitmapList:TLMDBitmapList;
    FImageList:TLMDImageList;
    FWaveList:TLMDWavelist;
    FStringList:TLMDStringList;
    procedure SetBitmapList(aValue:TLMDBitmapList);
    procedure SetImageList(aValue:TLMDImageList);
    procedure SetStringList(aValue:TLMDStringList);
    procedure SetWaveList(aValue:TLMDWaveList);
  protected
    procedure GetChange(Sender:TObject);override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    {properties}
    property BitmapList:TLMDBitmapList read FBitmapList write SetBitmapList;
    property ImageList:TLMDImageList read FImageList write SetImageList;
    property StringList:TLMDStringList read FStringList write SetStringList;
    property WaveList:TLMDWaveList read FWaveList write SetWaveList;
    {missing
    -> RTF-List
    }

  end;

  {------------------------ Class TLMDContainerCtrl  --------------------------}
  TLMDContainerCtrl=class(TLMDCustomComponent)
  private
    FContainer:TLMDContainer; {at designtime - tmp.Object}
    FInternal:Byte;
    procedure ReadStream(Stream:TStream);
    procedure WriteStream(Stream:TStream);
  protected
    procedure DefineProperties(Filer:TFiler);override;
    procedure Notification(AComponent: TComponent;  Operation: TOperation);override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    property Container:TLMDContainer read FContainer;
  published
    property About;
  end;

var
  LMDContainer:TLMDContainer;

  {****************************** Helper Routines *******************************}
  // returns false when imagelist is a list of imagelists (--> TLMDImageList and -Connector)
  function LMDIsSingleItemImageList(aList:TCustomImageList):Boolean;
  // returns false when imagelist is a collection of imagelists (--> TLMDImageListConnector)
  function LMDIsCollectionImageList(aList:TCustomImageList):Boolean;

  {for properties}
  procedure LMDWriteGlobalIdent(Writer:TWriter; aList:TCustomImageList);
  function LMDReadGlobalIdent(Reader:TReader):TLMDCustomImageList;
  function LMDIsGlobalIdent(aList:TCustomImageList):Boolean;

  // 8.0 -> helper functions for handling VCL and LMD Imagelists at the same time
  // For one-dimensional imagelists only ListIndex parameter is evaluated
  // ****************************************************************************
  // --> check whether item is valid
  function LMDIMLIsValidItem(aList:TCustomImageList; ListIndex, ImageIndex:Integer):Boolean;
  // --> Retrieve from ImageList aList the item indexed by ListIndex/ImageIndex parameters
  procedure LMDIMLItemBitmap(aList:TCustomImageList; ListIndex, ImageIndex:Integer; tmp:TBitmap);
  // --> Retrieve from ImageList aList an icon indexed by ListIndex/ImageIndex parameters
  procedure LMDIMLItemIcon(aList:TCustomImageList; ListIndex, ImageIndex:Integer; tmp:TIcon);
  {Returns width or height of a particular item}
  function LMDIMLItemWidth(aList:TCustomImageList; ListIndex:Integer):Integer;
  function LMDIMLItemHeight(aList:TCustomImageList; ListIndex:Integer):Integer;
  {Returns  Rect for specified item}
  function LMDIMLItemRect(aList:TCustomImageList; ListIndex, ImageIndex:Integer):TRect;
  {Returns  palette for specified item}
  function LMDIMLPalette(aList:TCustomImageList; ListIndex:Integer):HPalette;
  {Returns  number of items in an imagelist (or sublist)}
  function LMDIMLCount(aList:TCustomImageList;ListIndex:Integer=-1):Integer;
  {Returns Transparent color for imagelist or particular item}
  function LMDIMLTransparentColor(aList:TCustomImageList;ListIndex:Integer;ImageIndex:Integer=0):TColor;
  {Returns masked state for imagelist or particular item}
  function LMDIMLMasked(aList:TCustomImageList;ListIndex:Integer):Boolean;
  {wraps ClipDraw feature of LMD imagelists}
  procedure LMDIMLClipDraw(Canvas:TCanvas; target:TRect; flags:WORD; pos:LongInt;
            transColor:TColor; aList:TCustomImageList; ListIndex, index:Integer);
  {wraps DrawExt feature of LMD imagelists}
  function LMDIMLDrawExt(Canvas:TCanvas; target:TRect; flags:Word; aList:TCustomImageList; ListIndex, Index:Integer):TRect;

  {wraps GetColorAtPoint feature of LMD imagelists}
  function LMDIMLGetColorAtPoint(aList:TCustomImageList; aPoint: TPoint; ListIndex, ItemIndex:Integer): TColor;

implementation
uses
  LMDCustomContainer, LMDImageListConnector, LMDGraphUtils;

{------------------------------------------------------------------------------}
function LMDIMLGetColorAtPoint(aList:TCustomImageList; aPoint: TPoint; ListIndex, ItemIndex:Integer): TColor;
begin
  if aList is TLMDCustomImageList then
    result:=TLMDCustomImageList(aList).GetColorAtPoint(aPoint, ListIndex, ItemIndex)
  else
    // ToDo RM
    result:=clNone
    ;
end;

{------------------------------------------------------------------------------}
procedure LMDIMLClipDraw(Canvas:TCanvas; target:TRect; flags:WORD; pos:LongInt;
          transColor:TColor; aList:TCustomImageList; ListIndex, index:Integer);
var
  tmp:TBitmap;
begin
  if not Assigned(aList) then exit;
  if aList is TLMDCustomImageList then
    TLMDCustomImageList(aList).ClipDraw(Canvas, target, flags, pos,transcolor, ListIndex, index)
  else
    begin
      if (ListIndex<0) or (ListIndex>=TCustomImageList(aList).Count) then exit;
      // surely not very optimized
      tmp:=TBitmap.Create;
      try
        TCustomImageList(aList).GetBitmap(ListIndex, tmp);
        LMDBmpClipDraw(Canvas, target, tmp, flags, pos, transColor);
      finally
        tmp.Free;
      end;
    end;
end;

{------------------------------------------------------------------------------}
function LMDIMLDrawExt(Canvas:TCanvas; target:TRect; flags:Word; aList:TCustomImageList; ListIndex, Index:Integer):TRect;
var
  tmp:TBitmap;
begin
  result := Rect(0, 0, 0, 0);
  if not Assigned(aList) then exit;
  if aList is TLMDCustomImageList then
    TLMDCustomImageList(aList).DrawExt(Canvas, target, flags, ListIndex, index)
  else
    begin
      if (ListIndex<0) or (ListIndex>=TCustomImageList(aList).Count) then exit;
      // surely not very optimized
      tmp:=TBitmap.Create;
      try
        TCustomImageList(aList).GetBitmap(ListIndex, tmp);
        result:=LMDBmpDraw(Canvas, target, tmp, flags, tmp.TransparentColor);
      finally
        tmp.Free;
      end;
    end;
end;

{------------------------------------------------------------------------------}
function LMDIMLTransparentColor(aList:TCustomImageList;ListIndex:Integer;ImageIndex:Integer=0):TColor;
begin
  result:=clNone;
  if not Assigned(aList) then exit;
  if aList is TLMDCustomImageList then
    result:=TLMDCustomImageList(aList).TransparentColor(ListIndex, ImageIndex)
  else
     aList.BkColor;
end;

{Returns  palette for specified item}
{------------------------------------------------------------------------------}
function LMDIMLPalette(aList:TCustomImageList; ListIndex:Integer):HPalette;
begin
  if aList is TLMDCustomImageList then
    result:=TLMDCustomImageList(aList).Palette(ListIndex)
  else
    // ToDo RM  --> not supported by TCustomImageList
    result:=0
end;

{------------------------------------------------------------------------------}
function LMDIMLIsValidItem(aList:TCustomImageList; ListIndex, ImageIndex:Integer):Boolean;
begin
  result:=false;
  if not Assigned(aList) then exit;

  // functionality already available for LMD ImageLists
  if aList is TLMDCustomImageList then
    result:=TLMDCustomImageList(aList).IsValidItem(ListIndex, ImageIndex)
  else
    // ListIndex is used because of compatibility to previous LMDTools versions.
    // we have to find out ourselves
    result:=(ListIndex>=0) and (ListIndex<aList.Count);
end;

{------------------------------------------------------------------------------}
procedure LMDIMLItemBitmap(aList:TCustomImageList; ListIndex, ImageIndex:Integer; tmp:TBitmap);
begin
  if not Assigned(aList) or not Assigned(tmp) then exit;
  // functionality already available for LMD ImageLists
  if aList is TLMDCustomImageList then
    TLMDCustomImageList(aList).GetBitmapItem(ListIndex, ImageIndex, tmp)
  else
    // ListIndex is used because of compatibility to previous LMDTools versions.
   TCustomImageList(aList).GetBitmap(ImageIndex, tmp);
end;

{------------------------------------------------------------------------------}
procedure LMDIMLItemIcon(aList:TCustomImageList; ListIndex, ImageIndex:Integer; tmp:TIcon);
var
  b:TBitmap;
begin
  if not Assigned(aList) or not Assigned(tmp) then exit;
  if aList is TLMDCustomImageList then
    begin
      b := TBitmap.Create;
      try
        b.Width :=  TLMDCustomImageList(aList).Dimensions(ListIndex, 0);
        b.Height := TLMDCustomImageList(aList).Dimensions(ListIndex, 0);
        LMDIMLItemBitmap(TLMDCustomImageList(aList), ListIndex, ImageIndex, b);
        LMDBitmap2Icon (b, tmp, TLMDCustomImageList(aList).TransparentColor(ListIndex, ImageIndex));
      finally
        b.Free;
      end;
    end
  else
    // ListIndex is used because of compatibility to previous LMDTools versions.
   TCustomImageList(aList).GetIcon(ImageIndex, tmp);
end;

{------------------------------------------------------------------------------}
function LMDIMLItemWidth(aList:TCustomImageList; ListIndex:Integer):Integer;
begin
  result:=0;
  if not Assigned(aList) then exit;
  if aList is TLMDCustomImageList then
    result:=TLMDCustomImageList(aList).Dimensions(ListIndex, 0)
  else
    result:=aList.Width;
end;

{------------------------------------------------------------------------------}
function LMDIMLItemHeight(aList:TCustomImageList; ListIndex:Integer):Integer;
begin
  result:=0;
  if not Assigned(aList) then exit;
  if aList is TLMDCustomImageList then
    result:=TLMDCustomImageList(aList).Dimensions(ListIndex, 1)
  else
    result := aList.Height;
end;

{Returns  Rect for specified item}
{------------------------------------------------------------------------------}
function LMDIMLItemRect(aList:TCustomImageList; ListIndex, ImageIndex:Integer):TRect;
begin
  result:=Rect(0,0,0,0);
  if not Assigned(aList) then exit;
  if aList is TLMDCustomImageList then
    result:=TLMDCustomImageList(aList).ItemRect(ListIndex, ImageIndex)
  else
    result:=Rect(0,0,aList.Width, aList.Height);
end;

{------------------------------------------------------------------------------}
function LMDIMLCount(aList:TCustomImageList;ListIndex:Integer=-1):Integer;
begin
  result := 0;
  if not Assigned(aList) then exit;
  if LMDIsSingleItemImageList(aList) then
    begin
      if aList is TLMDCustomImagelist then
        result:=TLMDCustomImageList(aList).Count
      else
        result:=aList.Count
    end
  else
    if ListIndex=-1 then
      result:=TLMDCustomImageList(aList).Count
    else
      result:=TLMDCustomImageList(aList).ItemCount(ListIndex);
end;

{------------------------------------------------------------------------------}
function LMDIMLMasked(aList:TCustomImageList;ListIndex:Integer):Boolean;
begin
  result:=false;
  if not Assigned(aList) then exit;
  if aList is TLMDCustomImageList then
    result:=TLMDCustomImageList(aList).Masked(ListIndex)
  else
    result:=aList.Masked;
end;

{------------------------------------------------------------------------------}
procedure LMDWriteGlobalIdent(Writer:TWriter; aList:TCustomImageList);
begin
  if aList=LMDContainer.BitmapList then 
    Writer.WriteString(String(LMD_ICInfo[icBitmap]));
  if aList=LMDContainer.ImageList then 
    Writer.WriteString(String(LMD_ICInfo[icImageList]));
end;

{------------------------------------------------------------------------------}
function LMDReadGlobalIdent(Reader:TReader):TLMDCustomImageList;
var
  tmp: String;
begin
  result:=nil;
  tmp:=Reader.ReadString;
  if AnsiString(tmp) = LMD_ICInfo[icBitmap] then 
    result:=LMDContainer.BitmapList;
  if AnsiString(tmp) = LMD_ICInfo[icImageList] then 
    result:=LMDContainer.ImageList;
end;

{------------------------------------------------------------------------------}
function LMDIsGlobalIdent(aList:TCustomImageList):Boolean;
begin
  result:=Assigned(aList) and ((aList=LMDContainer.BitmapList) or (aList=LMDContainer.ImageList));
end;

{------------------------------------------------------------------------------}
function LMDIsSingleItemImageList(aList:TCustomImageList):Boolean;
begin
  result:=Assigned(aList) and not ((aList is TLMDImageList) or (aList is TLMDImageListConnector));
end;

{------------------------------------------------------------------------------}
function LMDIsCollectionImageList(aList:TCustomImageList):Boolean;
begin
  result:=Assigned(aList) and (aList is TLMDImageListConnector);
end;

{************************ Class TLMDContainer *********************************}
{------------------------- Private---------------------------------------------}
procedure TLMDContainer.SetBitmapList(aValue:TLMDBitmapList);
begin
  FBitmapList.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDContainer.SetImageList(aValue:TLMDImageList);
begin
  FImageList.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDContainer.SetStringList(aValue:TLMDStringList);
begin
  FStringList.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDContainer.SetWaveList(aValue:TLMDWaveList);
begin
  FWaveList.Assign(aValue);
end;

{-------------------------- Public --------------------------------------------}
procedure TLMDContainer.GetChange(Sender:TObject);
begin
  if (csDesigning in ComponentState) and (self<>LMDContainer) then
    begin
      if Sender=FBitmapList then LMDContainer.BitmapList.Assign(FBitmapList);
      if Sender=FImageList then LMDContainer.ImageList.Assign(FImageList);
      if Sender=FWaveList then LMDContainer.WaveList.Assign(FWaveList);
      if Sender=FStringList then LMDContainer.StringList.Assign(FStringList);
    end;
 inherited GetChange(Sender);
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDContainer.Create(aOwner:TComponent);
begin
  inherited Create(AOwner);
  FBitmapList:=TLMDBitmapList.Create(self);
  FBitmapList.OnChange:=GetChange;
  FImageList:=TLMDImageList.Create(self);
  FImageList.OnChange:=GetChange;
  FStringList:=TLMDStringList.Create(self);
  FStringList.OnChange:=GetChange;
  FWaveList:=TLMDWavelist.Create(self);
  FWaveList.OnChange:=GetChange;
end;

{------------------------------------------------------------------------------}
destructor TLMDContainer.Destroy;
begin
  FBitmapList.OnChange:=nil;
  FImageList.OnChange:=nil;
  FStringList.OnChange:=nil;
  FWaveList.OnChange:=nil;
  FBitmapList.Free;
  FImageList.Free;
  FWaveList.Free;
  inherited Destroy;
end;

{************************ Class TLMDContainerCtrl *****************************}
{-------------------------  private --------------------------------------------}
procedure TLMDContainerCtrl.ReadStream(Stream:TStream);
begin
  case FInternal of
    1:FContainer.BitmapList.LoadFromStream(Stream);
    2:FContainer.ImageList.LoadFromStream(Stream);
    3:FContainer.WaveList.LoadFromStream(Stream);
    4:FContainer.StringList.LoadFromStream(Stream);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDContainerCtrl.WriteStream(Stream:TStream);
begin
  case FInternal of
    1:FContainer.BitmapList.SaveToStream(Stream);
    2:FContainer.ImageList.SaveToStream(Stream);
    3:FContainer.WaveList.SaveToStream(Stream);
    4:FContainer.StringList.SaveToStream(Stream);
  end;
end;

{-------------------------- protected -----------------------------------------}
procedure TLMDContainerCtrl.Notification(AComponent: TComponent;  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if csDesigning in ComponentState then
    if (aComponent=self) and (Operation = opRemove) and (FInternal<>255) then
      with LMDContainer do
        begin
          BitmapList.Clear;
          ImageList.Clear;
          WaveList.Clear;
          StringList.Clear;
        end;
end;

{------------------------------------------------------------------------------}
procedure TLMDContainerCtrl.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  FInternal:=1;
  Filer.DefineBinaryProperty(copy(FContainer.BitmapList.ClassName, 5, 30), ReadStream, WriteStream,
                             not FContainer.BitmapList.Empty);
  FInternal:=2;
  Filer.DefineBinaryProperty(copy(FContainer.ImageList.ClassName, 5, 30), ReadStream, WriteStream,
                             not FContainer.ImageList.Empty);
  FInternal:=3;
  Filer.DefineBinaryProperty(copy(FContainer.WaveList.ClassName, 5, 30), ReadStream, WriteStream,
                             not FContainer.WaveList.Empty);
  FInternal:=4;
  Filer.DefineBinaryProperty(copy(FContainer.StringList.ClassName, 5, 30), ReadStream, WriteStream,
                             not FContainer.StringList.Empty);
end;

{------------------------------------------------------------------------------}
constructor TLMDContainerCtrl.Create(aOwner:TComponent);
begin
  inherited Create(AOwner);
  FInternal:=0;
  {if csDesigning in ComponentState then
    if LMDCheckForSameClass(aOwner, self.ClassType, false) then
      begin
        FInternal:=255;
        raise LMDEOneInstError.Create(self.ClassName, 0);
      end;}

  if csDesigning in ComponentState then
    FContainer:=TLMDContainer.Create(self)
  else
    FContainer:=LMDContainer;
end;

{------------------------------------------------------------------------------}
destructor TLMDContainerCtrl.Destroy;
begin
  if csDesigning in ComponentState then FContainer.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
initialization
  {create global LMDApplication-Object}
  LMDContainer:=TLMDContainer.Create(nil);

finalization
  LMDContainer.Free;

end.

