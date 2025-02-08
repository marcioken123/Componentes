unit LMDGraphicList;
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

LMDGraphicList unit ()
----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Graphics,
  LMDCustomImageList, LMDCustomContainer;

type

  {****************************************************************************}
  {----------------------TLMDGraphicListItem-----------------------------------}
  TLMDGraphicList= class;

  TLMDGraphicListItem = class (TCollectionItem)
  private
    FPicture  : TPicture;
    FName       : String;
    procedure SetPicture(aValue:TPicture);
    procedure SetName(aValue:String);
    function GetConnector:TLMDGraphicList;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure ImageListChange(Sender:TObject);
    property GraphicList:TLMDGraphicList read GetConnector;
  published
    property Name:String read FName write SetName;
    property Picture:TPicture read FPicture write SetPicture;
    property Index;
  end;

  {----------------------TLMDGraphicListItems---------------------------------}
  TLMDGraphicListItems = class (TCollection)
  private
    FConnector: TLMDGraphicList;
    function GetItem(Index: Integer): TLMDGraphicListItem;
    procedure SetItem(Index: Integer; aValue:TLMDGraphicListItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item:TCollectionItem); override;
  public
    constructor Create(Connector: TLMDGraphicList);
    destructor Destroy ; override;
    function Add: TLMDGraphicListItem;
    property Items[Index: Integer]: TLMDGraphicListItem read GetItem write SetItem; default;
  end;

  {----------------------TLMDGraphicList --------------------------------------}
  TLMDGraphicList= class(TLMDCustomImageList)
  private
    FImageList : TLMDGraphicListItems;
    FDummyItem  : TLMDListItem;
    procedure SetImageList(aValue:TLMDGraphicListItems);
  protected
    function GetCount:Integer;override;
    function GetEmpty:Boolean;override;
    function GetItem(Index:Integer):TLMDListItem;override;
    procedure Notification(aComponent: TComponent;Operation: TOperation);override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
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
    function Add(aValue:TLMDListItem=nil):Integer; override;
    {Extended Drawing}
    procedure ClipDraw(Canvas:TCanvas; target:TRect; flags:WORD;
                       pos:LongInt; transColor:TColor; ListIndex, index:Integer);override;

    property Contents[Index:Integer]:TLMDListItem read GetItem;
  published
    property Graphics:TLMDGraphicListItems read FImageList write SetImageList;
  end;

implementation
uses
  RtlConsts, Types,
  LMDSysIn, LMDGraphUtils, LMDStreamUtils;

{*********************** TLMDGraphicListItem **********************************}
{------------------------- Private --------------------------------------------}
procedure TLMDGraphicListItem.SetPicture(aValue:TPicture);
begin
  FPicture.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDGraphicListItem.SetName(aValue:String);
begin
  if aValue<>FName then
    begin
      FName:=aValue;
      DisplayName:=GetDisplayName;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDGraphicListItem.GetConnector:TLMDGraphicList;
begin
  result:=TLMDGraphicList(TLMDGraphicListItems(Collection).GetOwner);
end;

{-------------------------- Protected -----------------------------------------}
procedure TLMDGraphicListItem.Assign(Source: TPersistent);
begin
  if Source is TLMDGraphicListItem then
    begin
      FPicture.Assign(TLMDGraphicListItem(Source).Picture);
      FName:=TLMDGraphicListItem(Source).Name;
    end;
  //inherited Assign(Source);  //vb!!!
end;

{------------------------------------------------------------------------------}
function TLMDGraphicListItem.GetDisplayName:String;
begin
  if FName='' then
    result:=inherited GetDisplayName
  else
    result:=FName;
end;

{------------------------------------------------------------------------------}
procedure TLMDGraphicListItem.ImageListChange(Sender:TObject);
begin
  GraphicList.Change;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDGraphicListItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FPicture:=TPicture.Create;
  FPicture.OnChange:=ImageListChange;
end;

{------------------------------------------------------------------------------}
Destructor TLMDGraphicListItem.Destroy;
begin
  FPicture.OnChange:=nil;
  FPicture.Free;
  inherited Destroy;
end;

{*********************** TLMDGraphicListItems *********************************}
{------------------------- Private --------------------------------------------}
function TLMDGraphicListItems.GetItem(Index: Integer): TLMDGraphicListItem;
begin
  Result:=TLMDGraphicListItem(inherited GetItem(Index));
end;

{------------------------------------------------------------------------------}
procedure TLMDGraphicListItems.SetItem(Index: Integer;aValue:TLMDGraphicListItem);
begin
  inherited SetItem(Index, aValue);
end;

{-------------------------- Protected -----------------------------------------}
function TLMDGraphicListItems.GetOwner: TPersistent;
begin
  result:=FConnector;
end;

{------------------------------------------------------------------------------}
procedure TLMDGraphicListItems.Update(Item: TCollectionItem);
begin
  FConnector.Change;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDGraphicListItems.Create(Connector: TLMDGraphicList);
begin
  inherited Create(TLMDGraphicListItem);
  FConnector := Connector;
end;

{------------------------------------------------------------------------------}
destructor TLMDGraphicListItems.Destroy ;
begin
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDGraphicListItems.Add: TLMDGraphicListItem;
begin
  Result := TLMDGraphicListItem(inherited Add);
end;

{*********************** TLMDGraphicList **************************************}
{------------------------- Private --------------------------------------------}
procedure TLMDGraphicList.SetImageList(aValue: TLMDGraphicListItems);
begin
  FImageList.Assign(aValue);
end;

{------------------------------------------------------------------------------}
function TLMDGraphicList.GetItem(index:Integer):TLMDListItem;
begin
  FDummyItem.Description:=FImageList[index].Name;
  result:=FDummyItem;
end;

{-------------------------- Protected -----------------------------------------}
function TLMDGraphicList.GetCount:Integer;
begin
  result:=FImageList.Count;
end;

{------------------------------------------------------------------------------}
function TLMDGraphicList.GetEmpty:Boolean;
begin
  result:=FImageList.Count=0;
end;

{------------------------------------------------------------------------------}
procedure TLMDGraphicList.Notification(aComponent: TComponent;Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDGraphicList.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FDummyItem := TLMDListItem.Create(self);
  FImageList := TLMDGraphicListItems.Create(self);
end;

{------------------------------------------------------------------------------}
destructor TLMDGraphicList.Destroy;
begin
  FDummyItem.Free;
  FImageList.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDGraphicList.Add(aValue: TLMDListItem = nil): Integer;
begin
  if aValue=nil then
  begin
    result:= FImageList.Add.Index;
    Change;
  end
  else
    raise Exception.Create('TLMDGraphicList can not add TLMDListItem instances.');

end;

procedure TLMDGraphicList.Assign(Source: TPersistent);
var
  i: integer;
  obj: TLMDGraphicListItem;
  srclist: TLMDGraphicList;
begin
  if Source is TLMDGraphicList then
  begin
    srclist :=  TLMDGraphicList(Source);
    FImageList.Clear;
    for i := 0 to srclist.count - 1 do
    begin
      obj := FImageList.Add;
      obj.Assign(srclist.Graphics[i]);
    end;
  end
  else
    inherited;
end;

{------------------------------------------------------------------------------}
function TLMDGraphicList.BmpCanvas(index:Integer):TCanvas;
begin
  result := nil;
end;

{------------------------------------------------------------------------------}
function TLMDGraphicList.ItemRect(index, item:Integer):TRect;
begin
  SetRectEmpty(result);
  if isValidItem(index,0) then
    result:=Types.Rect(0,0, FImageList[index].Picture.Graphic.Width, FImageList[index].Picture.Graphic.Height);
end;

{------------------------------------------------------------------------------}
procedure TLMDGraphicList.GetBitmapItem(index, item:Integer; tb:TBitmap);
begin
  if isValidItem(index,0) then
    if (FImageList[index].Picture.Graphic is TBitmap) then
      tb.Assign(FImageList[index].Picture.Bitmap)
    else
      begin
        LMDBmpCreateFromRect(tb, ItemRect(index, 0), clWhite);
        tb.Canvas.Draw(0,0,FImageList[index].Picture.Graphic);
      end;
end;

{------------------------------------------------------------------------------}
function TLMDGraphicList.IsValidItem(index, item:Integer):Boolean;
begin
  result:=(index<FImageList.Count) and (FImageList[index].Picture.Graphic<>nil)
end;

{returns
 with:   tp=0 or
 height: tp=1 of item}
{------------------------------------------------------------------------------}
function TLMDGraphicList.Dimensions(index:Integer; tp:Byte):Integer;
begin
  result:=0;
  if (index>=FImageList.Count) or not isValidItem(index, 0) then exit;
  case tp of
    0: result:=FImageList[index].Picture.Width;
    1: result:=FImageList[index].Picture.Height;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDGraphicList.ItemCount(index:Integer):Integer;
begin
  result:=0;
  if isValidItem(index,0) then result:=1;
end;

{------------------------------------------------------------------------------}
function  TLMDGraphicList.Masked(index:Integer):Boolean;
begin
  result:=false;
end;

{------------------------------------------------------------------------------}
function TLMDGraphicList.Palette(index:Integer):HPalette;
begin
  result:=0;
  if isValidItem(index,0) and (FImageList[index].Picture.Graphic is TBitmap) then
    result:=FImageList[index].Picture.Bitmap.Palette;
end;

{------------------------------------------------------------------------------}
function TLMDGraphicList.TransparentColor(index, item:Integer):TColor;
var
  tmp:TBitmap;
begin
  result:=clNone;
  if isValidItem(index,0) then
    if (FImageList[index].Picture.Graphic is TBitmap) then
      result:=FImageList[index].Picture.Bitmap.TransparentColor
    else
      begin
        tmp:=TBitmap.Create;
        with tmp do
          try
            GetBitmapItem(index, item, tmp);
            result:=tmp.TransparentColor;
          finally
            tmp.Free;
          end;
      end;
end;

{------------------------------------------------------------------------------}
function TLMDGraphicList.GetColorAtPoint(aPoint: TPoint; index, item:Integer): TColor;
begin
  result:=clWhite;
end;

{Drawing}
{------------------------------------------------------------------------------}
procedure TLMDGraphicList.Draw(Canvas: TCanvas; X, Y: Integer; ListIndex, Index: Integer);
begin
  Canvas.Draw(x,y, FImageList[index].Picture.Graphic);
end;

{------------------------------------------------------------------------------}
function TLMDGraphicList.DrawExt(Canvas:TCanvas; target:TRect; flags:Word; ListIndex,
                                Index:Integer):TRect;
var
  tmp:TBitmap;
begin
  tmp:=TBitmap.Create;
  try
    GetBitmapItem(ListIndex, index, tmp);
    Result := LMDBmpDraw(Canvas, target, tmp, flags, tmp.TransparentColor);
  finally
    tmp.Free;
  end;
end;

{Extended Drawing}
{------------------------------------------------------------------------------}
procedure TLMDGraphicList.ClipDraw(Canvas:TCanvas; target:TRect; flags:WORD;
                                          pos:LongInt; transColor:TColor; ListIndex, index:Integer);
var
  tmp:TBitmap;
begin
  tmp:=TBitmap.Create;
  try
    GetBitmapItem(ListIndex, index, tmp);
    LMDBmpClipDraw(Canvas, target, tmp, flags, pos, transColor);
  finally
    tmp.Free;
  end;
end;

end.
