unit LMDImageListConnector;
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

LMDImageListConnector unit ()
-----------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  SysUtils,
  Classes,
  graphics,
  imglist,
  LMDCustomImageList,
  LMDCustomContainer;

type

  TLMDImageListConnector= class;

  {****************************************************************************}
  {----------------------TLMDBorImageListItem----------------------------------}
  TLMDBorImageListItem = class (TCollectionItem)
  private
    FImageList  : TCustomImageList;
    FChangeLink : TChangeLink;
    FName       : String;
    procedure SetImageList(aValue:TCustomImageList);
    procedure SetName(aValue:String);
    function GetConnector:TLMDImageListConnector;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure ImageListChange(Sender:TObject);
    property Connector:TLMDImageListConnector read GetConnector;
  published
    property Name:String read FName write SetName;
    property ImageList:TCustomImageList read FImageList write SetImageList;
    property Index;
  end;

  {----------------------TLMDBorImageListItems---------------------------------}
  TLMDBorImageListItems = class (TCollection)
  private
    FConnector: TLMDImageListConnector;
    function GetItem(Index: Integer): TLMDBorImageListItem;
    procedure SetItem(Index: Integer; aValue:TLMDBorImageListItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem);override;
  public
    constructor Create(Connector: TLMDImageListConnector);
    destructor Destroy ; override;
    function Add: TLMDBorImageListItem;
    property Items[Index: Integer]: TLMDBorImageListItem read GetItem write SetItem; default;
  end;

    {----------------------TLMDImageListConnector--------------------------------}
  TLMDImageListConnector= class(TLMDCustomImageList)
  private
    FImageLists : TLMDBorImageListItems;
    FDummyItem  : TLMDListItem;
    procedure SetImageLists(aValue:TLMDBorImageListItems);
  protected
    function GetCount:Integer;override;
    function GetEmpty:Boolean;override;
    function GetItem(Index:Integer):TLMDListItem;override;
    procedure Notification(aComponent: TComponent;Operation: TOperation);override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
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

    property Contents[Index:Integer]:TLMDListItem read GetItem;
  published
    property ImageLists:TLMDBorImageListItems read FImageLists write SetImageLists;
  end;

implementation
uses
  RtlConsts, Types,
  LMDSysIn, LMDGraphUtils, LMDStreamUtils;

{*********************** TLMDBorImageListItem *********************************}
{------------------------- Private --------------------------------------------}
procedure TLMDBorImageListItem.SetImageList(aValue:TCustomImageList);
begin
  if FImageList<>nil then
    FImageList.UnRegisterChanges(FChangeLink);
  FImageList:=aValue;
  if FImageList <> nil then
    begin
      FImageList.RegisterChanges(FChangeLink);
      FImageList.FreeNotification(Connector);
    end;
  GetConnector.Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDBorImageListItem.SetName(aValue:String);
begin
  if aValue<>FName then
    begin
      FName:=aValue;
      DisplayName:=GetDisplayName;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBorImageListItem.GetConnector:TLMDImageListConnector;
begin
  result:=TLMDImageListConnector(TLMDBorImageListItems(Collection).GetOwner);
end;

{-------------------------- Protected -----------------------------------------}
procedure TLMDBorImageListItem.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
function TLMDBorImageListItem.GetDisplayName:String;
begin
  if FName='' then
    begin
      if FImageList<>nil then
        result:=FImageList.Name
      else
        result:=inherited GetDisplayName;
    end
  else
    result:=FName;
end;

{------------------------------------------------------------------------------}
procedure TLMDBorImageListItem.ImageListChange(Sender:TObject);
begin
  GetConnector.Change;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDBorImageListItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FChangeLink := TChangeLink.Create;
  FChangeLink.OnChange := ImageListChange;
end;

{------------------------------------------------------------------------------}
Destructor TLMDBorImageListItem.Destroy;
begin
  FChangeLink.OnChange:=nil;
  FChangeLink.Free;
  inherited Destroy;
end;

{*********************** TLMDBorImageListItems ********************************}
{------------------------- Private --------------------------------------------}
function TLMDBorImageListItems.GetItem(Index: Integer): TLMDBorImageListItem;
begin
  Result:=TLMDBorImageListItem(inherited GetItem(Index));
end;

{------------------------------------------------------------------------------}
procedure TLMDBorImageListItems.SetItem(Index: Integer;aValue:TLMDBorImageListItem);
begin
  inherited SetItem(Index, aValue);
end;

{-------------------------- Protected -----------------------------------------}
function TLMDBorImageListItems.GetOwner: TPersistent;
begin
  result:=FConnector;
end;

{------------------------------------------------------------------------------}
procedure TLMDBorImageListItems.Update(Item: TCollectionItem);
begin
  FConnector.Change;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDBorImageListItems.Create(Connector: TLMDImageListConnector);
begin
  inherited Create(TLMDBorImageListItem);
  FConnector := Connector;
end;

{------------------------------------------------------------------------------}
destructor TLMDBorImageListItems.Destroy ;
begin
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDBorImageListItems.Add: TLMDBorImageListItem;
begin
  Result := TLMDBorImageListItem(inherited Add);
end;

{*********************** TLMDImageListIConnector ******************************}
{------------------------- Private --------------------------------------------}
procedure TLMDImageListConnector.SetImageLists(aValue: TLMDBorImageListItems);
begin
  FImageLists.Assign(aValue);
end;

{------------------------------------------------------------------------------}
function TLMDImageListConnector.GetItem(index:Integer):TLMDListItem;
begin
  FDummyItem.Description:=FImageLists[index].Name;
  result:=FDummyItem;
end;

{-------------------------- Protected -----------------------------------------}
function TLMDImageListConnector.GetCount:Integer;
begin
  result:=FImageLists.Count;
end;

{------------------------------------------------------------------------------}
function TLMDImageListConnector.GetEmpty:Boolean;
begin
  result:=FImageLists.Count=0;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListConnector.Notification(aComponent: TComponent;Operation: TOperation);
var
  i:integer;
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (aComponent is TCustomImageList) then
    for i:=0 to FImageLists.Count-1 do
      if FImageLists[i].ImageList=aComponent then  FImageLists[i].ImageList:=nil;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDImageListConnector.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FDummyItem:=TLMDListItem.Create(self);
  FImageLists:=TLMDBorImageListItems.Create(self);
end;

{------------------------------------------------------------------------------}
destructor TLMDImageListConnector.Destroy;
begin
  FDummyItem.Free;
  FImageLists.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDImageListConnector.BmpCanvas(index:Integer):TCanvas;
begin
  result := nil;
end;

{------------------------------------------------------------------------------}
function TLMDImageListConnector.ItemRect(index, item:Integer):TRect;
begin
  result:=Types.Rect(0,0, FImageLists[index].ImageList.Width, FImageLists[index].ImageList.Height);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListConnector.GetBitmapItem(index, item:Integer; tb:TBitmap);
begin
  if Assigned(tb) then FImageLists[index].ImageList.GetBitmap(item, tb);
end;

{------------------------------------------------------------------------------}
function TLMDImageListConnector.IsValidItem(index, item:Integer):Boolean;
begin
  result:=(index<FImageLists.Count) and Assigned(FImageLists[index].ImageList) and (item<FImageLists[index].ImageList.Count) and
          (item>-1);
end;

{returns
 with:   tp=0 or
 height: tp=1 of item}
{------------------------------------------------------------------------------}
function TLMDImageListConnector.Dimensions(index:Integer; tp:Byte):Integer;
begin
  result:=0;
  if index<FImageLists.Count then
    case tp of
      0: result:=FImageLists[index].ImageList.Width;
      1: result:=FImageLists[index].ImageList.Height;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDImageListConnector.ItemCount(index:Integer):Integer;
begin
  if index<FImageLists.Count then result:=FImageLists[index].ImageList.Count else result:=-1;
end;

{------------------------------------------------------------------------------}
function  TLMDImageListConnector.Masked(index:Integer):Boolean;
begin
  result:=FImageLists[Index].ImageList.Masked;
end;

{------------------------------------------------------------------------------}
function TLMDImageListConnector.Palette(index:Integer):HPalette;
begin
  result:=0;
end;

{------------------------------------------------------------------------------}
function TLMDImageListConnector.TransparentColor(index, item:Integer):TColor;
var
  tmp:TBitmap;
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

{------------------------------------------------------------------------------}
function TLMDImageListConnector.GetColorAtPoint(aPoint: TPoint; index, item:Integer): TColor;
begin
  result:=clWhite;
end;

{Drawing}
{------------------------------------------------------------------------------}
procedure TLMDImageListConnector.Draw(Canvas: TCanvas; X, Y: Integer; ListIndex, Index: Integer);
begin
  FImageLists[ListIndex].ImageList.Draw(Canvas, x,y, index);
end;

{------------------------------------------------------------------------------}
function TLMDImageListConnector.DrawExt(Canvas: TCanvas; target: TRect; flags: Word; ListIndex,
                                Index: Integer): TRect;
var
  tmp: TBitmap;
begin
  tmp := TBitmap.Create;
  try
    GetBitmapItem(ListIndex, index, tmp);
    Result := LMDBmpDraw(Canvas, target, tmp, flags, tmp.TransparentColor);
  finally
    tmp.Free;
  end;
end;

{Extended Drawing}
{------------------------------------------------------------------------------}
procedure TLMDImageListConnector.ClipDraw(Canvas:TCanvas; target:TRect; flags:WORD;
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
