unit ElHTMLContainer;
{$I LMDCmps.INC}

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

ElHTMLContainer unit
--------------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Controls, ElComponent, LMDHTMLUnit, LMDTypes;

type
  TElHTMLContainer = class;

  {*************************** TElHTMLChangeLink  ****************************}
  TElHTMLChangeLink = class
  private
    FSender:TElHTMLContainer;
    FOnChange:TNotifyEvent;
  public
    destructor Destroy; override;
    procedure Change; dynamic;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Sender: TElHTMLContainer read FSender write FSender;
  end;

  {************************* TElHTMLListItem  ********************************}
  TElHTMLListItem = class(TCollectionItem)
  private
    FCaption: TLMDString;
    FName       : string;
    // next version!
    {FOnLinkClick  : TLMDLinkClickEvent;
    FOnGetVariable: TLMDGetVariableEvent;}
    procedure SetName(const aValue: string);
    procedure SetCaption(const aValue: TLMDString);
    procedure LinesChange(Sender: TObject);
  protected
    function GetDisplayName: string; override;
    //procedure DefineProperties(Filer: TFiler); override;
    //procedure LoadTextProperty(Reader: TReader);
  public
    constructor Create(Collection: TCollection); override;
    //procedure DoLinkClick(aSender: TObject; aURLText: string; aButton:TMouseButton); dynamic;
    destructor Destroy; override;
  published
    property Index;
    property Name: string read FName write SetName;
    property Caption: TLMDString read FCaption write SetCaption;
    {property OnLinkClick: TLMDLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnGetVariable: TLMDGetVariableEvent read FOnGetVariable write FOnGetVariable;}
  end;

{************************* TElHTMLListItems *******************************}
  TElHTMLListItems = class(TCollection)
  private
    FOwner: TElHTMLContainer;
    function GetItem(Index: Integer): TElHTMLListItem;
    procedure SetItem(Index: Integer; const Value: TElHTMLListItem);
    function GetItemByName(index:String):Integer;
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
    procedure SetItemName(Item: TCollectionItem);override;
    function UniqueName:String;
    function GetItemClass: TCollectionItemClass; virtual;
  public
    constructor Create(aOwner: TComponent);
    function Add: TElHTMLListItem;reintroduce;
    property Items[Index: Integer]: TElHTMLListItem read GetItem write SetItem; default;
    property ItemByName[index:String]:Integer read GetItemByName;
    property TextContainer: TElHTMLContainer read FOwner;
  end;

  {***************************** TElHTMLContainer  ***************************}
  TElHTMLContainer = class(TElComponent)
  private
    FClients: TList;
    FItems: TElHTMLListItems;
    function GetItems: TElHTMLListItems;
    function GetCount: Integer;
  protected
    function GetNamedIndex(aValue:String):Integer;
    public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure Change; override;
    procedure RegisterChanges(aValue: TElHTMLChangeLink);
    procedure UnRegisterChanges(aValue: TElHTMLChangeLink);
    property Count: Integer read GetCount;
    property ItemByName[index:String]:Integer read GetNamedIndex;
  published
    property About;
    property Items: TElHTMLListItems read GetItems write FItems;
    property OnChange;
  end;

implementation
uses
  SysUtils;

const
  EL_UNIQUEBASE='ElHTMLSnip';

{************************* TElHTMLChangeLink *********************************}
{------------------------------------------------------------------------------}
destructor TElHTMLChangeLink.Destroy;
begin
  if Sender <> nil then Sender.UnRegisterChanges(Self);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TElHTMLChangeLink.Change;
begin
  if Assigned(OnChange) then OnChange(Sender)
end;

{************************* TElHTMLListItem ***********************************}
{------------------------------ Private ---------------------------------------}
procedure TElHTMLListItem.SetName(const aValue: string);
begin
  if aValue <> FName then
    begin
      FName:= aValue;
      DisplayName:= GetDisplayName;
    end;
end;

{------------------------------------------------------------------------------}
procedure TElHTMLListItem.SetCaption(const aValue: TLMDString);
begin
  if aValue<>FCaption then
    begin
      FCaption:=aValue;
      LinesChange(nil);
    end;
end;

{-------------------------- Protected -----------------------------------------}
function TElHTMLListItem.GetDisplayName: string;
begin
  if FName = '' then
    Result:= inherited GetDisplayName
  else
    Result:= FName;
end;

{------------------------------------------------------------------------------}
procedure TElHTMLListItem.LinesChange(Sender: TObject);
begin
  TElHTMLListItems(Collection).FOwner.Change
end;

{---------------------------  Public ------------------------------------------}
constructor TElHTMLListItem.Create(Collection: TCollection);
begin
  inherited;
end;

{------------------------------------------------------------------------------}
destructor TElHTMLListItem.Destroy;
begin
  inherited;
end;

{************************* TElHTMLListItems **********************************}
{--------------------------- Private ------------------------------------------}
procedure TElHTMLListItems.SetItem(Index: Integer; const Value: TElHTMLListItem);
begin
  inherited SetItem(Index, Value)
end;

{------------------------------------------------------------------------------}
function TElHTMLListItems.GetItem(Index: Integer): TElHTMLListItem;
begin
  Result:= TElHTMLListItem(inherited GetItem(Index))
end;

{--------------------------- Protected ----------------------------------------}
function TElHTMLListItems.GetOwner: TPersistent;
begin
  Result:= FOwner
end;

{------------------------------------------------------------------------------}
procedure TElHTMLListItems.SetItemName(Item: TCollectionItem);
begin
  if (TElHTMLListItem(Item).Name='') or
     (GetItemByName(TElHTMLListItem(Item).Name)<>-1) then
    TElHTMLListItem(Item).Name:=UniqueName;
end;

{------------------------------------------------------------------------------}
function TElHTMLListItems.UniqueName: String;
var
  i:Integer;
  tmp:String;
begin
  result:='';i:=0;
  while result='' do
    begin
      tmp:=EL_UNIQUEBASE+Inttostr(i);
      if ItemByName[tmp]>-1 then
        Inc(i)
      else
        result:=tmp;
    end;
end;

{------------------------------------------------------------------------------}
procedure TElHTMLListItems.Update(Item: TCollectionItem);
begin
  FOwner.Change
end;

{------------------------------------------------------------------------------}
function TElHTMLListItems.GetItemClass: TCollectionItemClass;
begin
  Result := TElHTMLListItem;
end;

{------------------------------------------------------------------------------}
function TElHTMLListItems.GetItemByName(index:String):Integer;
var
  i:Integer;
begin
  result:=-1;
  for i:=0 to Count-1 do
    begin
       if Items[i].name=index then
         begin
           result:=i;
           break;
         end
    end;
end;

{--------------------------- Public -------------------------------------------}
constructor TElHTMLListItems.Create(AOwner: TComponent);
begin
  inherited Create(GetItemClass);
  FOwner := aOwner as TElHTMLContainer;
end;

{------------------------------------------------------------------------------}
function TElHTMLListItems.Add: TElHTMLListItem;
begin
  Result:= TElHTMLListItem(inherited Add);
end;

{************************* TElHTMLContainer **********************************}
{----------------------------- Private ----------------------------------------}
function TElHTMLContainer.GetItems: TElHTMLListItems;
begin
  if not Assigned(FItems) then
    FItems:= TElHTMLListItems.Create(Self);
  result:= FItems;
end;

{------------------------------------------------------------------------------}
function TElHTMLContainer.GetCount: Integer;
begin
  if Assigned(FItems) then
    Result:= FItems.Count
  else
    Result:= 0;
end;

{--------------------------- protected ----------------------------------------}
procedure TElHTMLContainer.Change;
var
  i:Integer;
begin
  if csLoading in ComponentState then Exit;
  inherited Change;
  for i:=0 to FClients.Count-1 do
    TElHTMLChangeLink(FClients[i]).Change;
end;

{---------------------------- public ------------------------------------------}
constructor TElHTMLContainer.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FClients:= TList.Create;
end;

{------------------------------------------------------------------------------}
destructor TElHTMLContainer.Destroy;
begin
  while FClients.Count > 0 do
    UnRegisterChanges(TElHTMLChangeLink(FClients.Last));
  FreeAndNil(FClients);
  FreeAndNil(FItems);  
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TElHTMLContainer.RegisterChanges(aValue: TElHTMLChangeLink);
begin
  aValue.Sender:= Self;
  FClients.Add(aValue);
end;

{------------------------------------------------------------------------------}
procedure TElHTMLContainer.UnRegisterChanges(aValue: TElHTMLChangeLink);
var
  i: Integer;
begin
  if FClients<>nil then
    for i:= 0 to FClients.Count - 1 do
      if FClients[i] = aValue then
        begin
          aValue.Sender:= nil;
          FClients.Delete(i);
          Break;
        end;
end;

{------------------------------------------------------------------------------}
function TElHTMLContainer.GetNamedIndex(aValue:String):Integer;
begin
  result:=FItems.ItemByName[aValue];
end;
{------------------------------------------------------------------------------}
{procedure TElHTMLListItem.DoLinkClick(aSender: TObject; aURLText: string;
  aButton: TMouseButton);
begin
  if Assigned(FOnLinkClick) then OnLinkClick(aSender, aURLText, aButton);
end;}

end.
