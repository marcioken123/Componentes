unit LMDTextContainer;
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

LMDTextContainer unit (RM)
--------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Controls,LMDCustomComponent, LMDTextObject, LMDText;

type
  TLMDTextContainer = class;

  {*************************** TLMDTextChangeLink  ****************************}
  TLMDTextChangeLink = class
  private
    FSender:TLMDTextContainer;
    FOnChange:TNotifyEvent;
  public
    destructor Destroy; override;
    procedure Change; dynamic;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Sender: TLMDTextContainer read FSender write FSender;
  end;

  {************************* TLMDTextListItem  ********************************}
  TLMDTextListItem = class(TCollectionItem)
  private
    FLines      : TLMDStrings;
    FName       : string;
    // next version!
    {FOnLinkClick  : TLMDLinkClickEvent;
    FOnGetVariable: TLMDGetVariableEvent;}
    procedure SetName(aValue: string);
    procedure SetLines(aValue: TLMDStrings);
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
    property Lines: TLMDStrings read FLines write SetLines;
    {property OnLinkClick: TLMDLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnGetVariable: TLMDGetVariableEvent read FOnGetVariable write FOnGetVariable;}
  end;

  {************************* TLMDTextListItems *******************************}
  TLMDTextListItems = class(TCollection)
  private
    FOwner: TLMDTextContainer;
    function GetItem(Index: Integer): TLMDTextListItem;
    procedure SetItem(Index: Integer; const Value: TLMDTextListItem);
    function GetItemByName(index:String):Integer;
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
    procedure SetItemName(Item: TCollectionItem);override;
    function GetItemClass: TCollectionItemClass; virtual;
    function UniqueName: String;
  public
    constructor Create(aOwner: TComponent);
    function Add: TLMDTextListItem;
    property Items[Index: Integer]: TLMDTextListItem read GetItem write SetItem; default;
    property ItemByName[index:String]:Integer read GetItemByName;
    property TextContainer: TLMDTextContainer read FOwner;
  end;

  {***************************** TLMDTextContainer  ***************************}
  TLMDTextContainer = class(TLMDCustomComponent)
  private
    FClients: TList;
    FItems: TLMDTextListItems;
    function GetItems: TLMDTextListItems;
    function GetCount: Integer;
  protected
    public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure Change; override;
    procedure RegisterChanges(aValue: TLMDTextChangeLink);
    procedure UnRegisterChanges(aValue: TLMDTextChangeLink);
    function GetNamedIndex(const aValue:String):Integer;
    property Count: Integer read GetCount;
  published
    property About;
    property Items: TLMDTextListItems read GetItems write FItems;
    property OnChange;
  end;

implementation
uses
  sysutils
  {$IFDEF LMD_DEBUGTRACE}
   , dialogs;
  {$I C2.INC}
{$ELSE}
  ;
{$ENDIF}

const
  LMD_HTMLUNIQUEBASE='LMDTextSnip';

{************************* TLMDTextChangeLink *********************************}
{------------------------------------------------------------------------------}
destructor TLMDTextChangeLink.Destroy;
begin
  if Sender <> nil then Sender.UnRegisterChanges(Self);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDTextChangeLink.Change;
begin
  if Assigned(OnChange) then OnChange(Sender)
end;

{************************* TLMDTextListItem ***********************************}
{------------------------------ Private ---------------------------------------}
procedure TLMDTextListItem.SetName(aValue: string);
begin
  if aValue <> FName then
    begin
      FName:= aValue;
      DisplayName:= GetDisplayName;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTextListItem.SetLines(aValue: TLMDStrings);
begin
  FLines.Assign(aValue)
end;

{-------------------------- Protected -----------------------------------------}
function TLMDTextListItem.GetDisplayName: string;
begin
  if FName = '' then
    Result:= inherited GetDisplayName
  else
    Result:= FName;
end;

{------------------------------------------------------------------------------}
procedure TLMDTextListItem.LinesChange(Sender: TObject);
begin
  TLMDTextListItems(Collection).FOwner.Change
end;

{procedure TLMDTextListItem.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Text', LoadTextProperty, nil, false);
end;

procedure TLMDTextListItem.LoadTextProperty(Reader: TReader);
var
  S: TStringStream;
begin
  S:= TStringStream.Create(Reader.ReadString);
  try
    Lines.LoadFromStream(S);
  finally
    S.Free;
  end;
end;

{---------------------------  Public ------------------------------------------}
constructor TLMDTextListItem.Create(Collection: TCollection);
begin
  inherited;
  FLines:=TLMDStrings.Create;
  TLMDStrings(FLines).OnChange:= LinesChange;
end;

{------------------------------------------------------------------------------}
destructor TLMDTextListItem.Destroy;
begin
  FreeAndNil(FLines);
  inherited;
end;

{************************* TLMDTextListItems **********************************}
{--------------------------- Private ------------------------------------------}
procedure TLMDTextListItems.SetItem(Index: Integer; const Value: TLMDTextListItem);
begin
  inherited SetItem(Index, Value)
end;

{------------------------------------------------------------------------------}
function TLMDTextListItems.GetItem(Index: Integer): TLMDTextListItem;
begin
  Result:= TLMDTextListItem(inherited GetItem(Index))
end;

{--------------------------- Protected ----------------------------------------}
function TLMDTextListItems.GetOwner: TPersistent;
begin
  Result:= FOwner
end;

{------------------------------------------------------------------------------}
procedure TLMDTextListItems.Update(Item: TCollectionItem);
begin
  FOwner.Change
end;

{------------------------------------------------------------------------------}
procedure TLMDTextListItems.SetItemName(Item: TCollectionItem);
begin
  if (TLMDTextListItem(Item).Name='') or
     (GetItemByName(TLMDTextListItem(Item).Name)<>-1) then
    TLMDTextListItem(Item).Name:=UniqueName;
end;

{------------------------------------------------------------------------------}
function TLMDTextListItems.UniqueName: String;
var
  i:Integer;
  tmp:String;
begin
  result:='';i:=0;
  while result='' do
    begin
      tmp:=LMD_HTMLUNIQUEBASE+Inttostr(i);
      if ItemByName[tmp]>-1 then
        Inc(i)
      else
        result:=tmp;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDTextListItems.GetItemClass: TCollectionItemClass;
begin
  Result := TLMDTextListItem;
end;

{------------------------------------------------------------------------------}
function TLMDTextListItems.GetItemByName(index:String):Integer;
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
constructor TLMDTextListItems.Create(AOwner: TComponent);
begin
  inherited Create(GetItemClass);
  FOwner := aOwner as TLMDTextContainer;
end;

{------------------------------------------------------------------------------}
function TLMDTextListItems.Add: TLMDTextListItem;
begin
  Result:= TLMDTextListItem(inherited Add)
end;

{************************* TLMDTextContainer **********************************}
{----------------------------- Private ----------------------------------------}
function TLMDTextContainer.GetItems: TLMDTextListItems;
begin
  if not Assigned(FItems) then
    FItems:= TLMDTextListItems.Create(Self);
  result:= FItems;
end;

{------------------------------------------------------------------------------}
function TLMDTextContainer.GetCount: Integer;
begin
  if Assigned(FItems) then
    Result:= FItems.Count
  else
    Result:= 0;
end;

{--------------------------- protected ----------------------------------------}
procedure TLMDTextContainer.Change;
var
  i:Integer;
begin
  if csLoading in ComponentState then Exit;
  inherited Change;
  for i:=0 to FClients.Count-1 do
    TLMDTextChangeLink(FClients[i]).Change;
end;

{---------------------------- public ------------------------------------------}
constructor TLMDTextContainer.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FClients:= TList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDTextContainer.Destroy;
begin
  while FClients.Count > 0 do
    UnRegisterChanges(TLMDTextChangeLink(FClients.Last));
  FreeAndNil(FClients);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDTextContainer.RegisterChanges(aValue: TLMDTextChangeLink);
begin
  aValue.Sender:= Self;
  FClients.Add(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDTextContainer.UnRegisterChanges(aValue: TLMDTextChangeLink);
var
  i: Integer;
begin
  if FClients<>nil then
  for i:= 0 to FClients.Count - 1 do
    if FClients[I] = aValue then
      begin
        aValue.Sender:= nil;
        FClients.Delete(I);
        Break;
      end;
end;

{------------------------------------------------------------------------------}
function TLMDTextContainer.GetNamedIndex(const aValue:String):Integer;
begin
  result:=FItems.ItemByName[aValue];
end;
{------------------------------------------------------------------------------}
{procedure TLMDTextListItem.DoLinkClick(aSender: TObject; aURLText: string;
  aButton: TMouseButton);
begin
  if Assigned(FOnLinkClick) then OnLinkClick(aSender, aURLText, aButton);
end;}

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C1.INC}
{$ENDIF}
end.
