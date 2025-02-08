unit LMDRTFStorage;
{$I LMDCmps.inc}

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

LMDRTFStorage unit ()
--------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Controls, LMDRTFBase;

type
  TLMDRichStorage = class;

{*************************** TLMDRTFChangeLink  *******************************}
  TLMDRTFChangeLink = class
  private
    FSender: TLMDRichStorage;
    FOnChange: TNotifyEvent;
  public
    destructor Destroy; override;
    procedure Change; dynamic;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Sender: TLMDRichStorage read FSender write FSender;
  end;

{************************* TLMDRichStorageItem  *******************************}
  TLMDRichStorageItem = class(TCollectionItem)
  private
    FLines: TStrings;
    FName: string;
    FOnURLClick: TLMDRichURLClickEvent;
    FOnLinkClick: TLMDRichURLClickEvent;
    procedure SetName(aValue: string);
    procedure SetLines(aValue: TStrings);
    procedure LinesChange(Sender: TObject);
  protected
    function GetDisplayName: string; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure LoadTextProperty(Reader: TReader);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure DoLinkClick(aSender: TObject; const aURLText: string; aButton: TMouseButton); dynamic;
    procedure Assign(Source: TPersistent); override;
  published
    property Index;
    property Name: string read FName write SetName;
    property Lines: TStrings read FLines write SetLines;
    property OnURLClick: TLMDRichURLClickEvent read FOnURLClick write FOnURLClick;
    property OnLinkClick: TLMDRichURLClickEvent read FOnLinkClick write FOnLinkClick;
  end;

{************************* TLMDRichStorageItems *******************************}
  TLMDRichStorageItems = class(TOwnedCollection)
  private
    function GetStorage: TLMDRichStorage;
  protected
    function GetItem(Index: Integer): TLMDRichStorageItem;
    procedure SetItem(Index: Integer; const Value: TLMDRichStorageItem);
    procedure Update(Item: TCollectionItem); override;
    class function GetItemClass: TCollectionItemClass; virtual;
  public
    //constructor Create(aOwner: TComponent); reintroduce; virtual;
    function Add: TLMDRichStorageItem;
    property Items[Index: Integer]: TLMDRichStorageItem read GetItem write SetItem; default;
    property Storage: TLMDRichStorage read GetStorage;
  end;

{***************************** TLMDRichStorage  *******************************}
  TLMDRichStorage = class(TLMDRichComponent)
  private
    FClients: TList;
    function GetItems: TLMDRichStorageItems;
    function GetCount: Integer;
  protected
    FItems: TLMDRichStorageItems;
    procedure Change; override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure RegisterChanges(aValue: TLMDRTFChangeLink);
    procedure UnRegisterChanges(aValue: TLMDRTFChangeLink);
    property Count: Integer read GetCount;
  published
    property Items: TLMDRichStorageItems read GetItems write FItems;
  end;

implementation

uses
  SysUtils, LMDRTFRichEdit;

{************************* TLMDRTFChangeLink ********************************}
{------------------------------------------------------------------------------}

destructor TLMDRTFChangeLink.Destroy;
begin
  if Sender <> nil then Sender.UnRegisterChanges(Self);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}

procedure TLMDRTFChangeLink.Change;
begin
  if Assigned(OnChange) then
    OnChange(Sender)
end;

{************************* TLMDRichStorageItem ********************************}
{------------------------------------------------------------------------------}

procedure TLMDRichStorageItem.LinesChange(Sender: TObject);
begin
  TLMDRichStorageItems(Collection).Storage.Change
end;

{------------------------------------------------------------------------------}

procedure TLMDRichStorageItem.SetName(aValue: string);
begin
  if aValue <> FName then
    begin
      FName:= aValue;
      DisplayName:= GetDisplayName;
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDRichStorageItem.SetLines(aValue: TStrings);
begin
  FLines.Assign(aValue)
end;

{------------------------------------------------------------------------------}
function TLMDRichStorageItem.GetDisplayName: string;
begin
  if FName = '' then
    Result:= inherited GetDisplayName
  else
    Result:= FName;
end;

{------------------------------------------------------------------------------}

procedure TLMDRichStorageItem.Assign(Source: TPersistent);
var
  MS: TMemoryStream;
begin
  if  Source is TLMDRichStorageItem then
    begin
      FLines.Assign(TLMDRichStorageItem(Source).FLines);
      FName := TLMDRichStorageItem(Source).FName;
    end
  else
  if  Source is TStrings  then
    begin
      MS := TMemoryStream.Create;
      try
        TStrings(Source).SaveToStream(MS);
        MS.Position := 0;
        FLines.LoadFromStream(MS);
      finally
        MS.Free;
      end;
    end
  else
    inherited Assign(Source);
end;

{------------------------------------------------------------------------------}

constructor TLMDRichStorageItem.Create(Collection: TCollection);
begin
  inherited;
  FLines:= TStringList.Create;
  TStringList(FLines).OnChange:= LinesChange;
end;

{------------------------------------------------------------------------------}

destructor TLMDRichStorageItem.Destroy;
begin
  FreeAndNil(FLines);
  inherited;
end;

{************************* TLMDRichStorageItems *******************************}
{------------------------------------------------------------------------------}
function TLMDRichStorageItems.Add: TLMDRichStorageItem;
begin
  Result:= TLMDRichStorageItem(inherited Add)
end;

{------------------------------------------------------------------------------}
function TLMDRichStorageItems.GetStorage: TLMDRichStorage;
begin
  result:=TLMDRichStorage(Owner)
end;

{------------------------------------------------------------------------------}
function TLMDRichStorageItems.GetItem(Index: Integer): TLMDRichStorageItem;
begin
  Result:= TLMDRichStorageItem(inherited GetItem(Index))
end;

{------------------------------------------------------------------------------}
procedure TLMDRichStorageItems.Update(Item: TCollectionItem);
begin
  if Owner<>nil then
    Storage.Change
end;

{------------------------------------------------------------------------------}
procedure TLMDRichStorageItems.SetItem(Index: Integer; const Value: TLMDRichStorageItem);
begin
  inherited SetItem(Index, Value)
end;

{************************* TLMDRichStorage ************************************}
{------------------------------------------------------------------------------}
function TLMDRichStorage.GetItems: TLMDRichStorageItems;
begin
  if not Assigned(FItems) then
    FItems:= TLMDRichStorageItems.Create(Self, TLMDRichStorageItem);
  result:= FItems;
end;

{------------------------------------------------------------------------------}
function TLMDRichStorage.GetCount: Integer;
begin
  if Assigned(FItems) then
    Result:= FItems.Count
  else
    Result:= 0;
end;

{--------------------------- protected ----------------------------------------}
procedure TLMDRichStorage.Change;
var
  I: LongInt;
begin
  if csLoading in ComponentState then Exit;
  for I:= 0 to FClients.Count - 1 do
    TLMDRTFChangeLink(FClients[I]).Change;
end;

{---------------------------- public ------------------------------------------}
constructor TLMDRichStorage.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FClients:= TList.Create;
end;

{------------------------------------------------------------------------------}

destructor TLMDRichStorage.Destroy;
begin
  while FClients.Count > 0 do
    UnRegisterChanges(TLMDRTFChangeLink(FClients.Last));
  FreeAndNil(FClients);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}

procedure TLMDRichStorage.RegisterChanges(aValue: TLMDRTFChangeLink);
begin
  aValue.Sender:= Self;
  FClients.Add(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDRichStorage.UnRegisterChanges(aValue: TLMDRTFChangeLink);
var
  I: LongInt;
begin
  for i:= 0 to FClients.Count - 1 do
    if FClients[I] = aValue then
      begin
        aValue.Sender:= nil;
        FClients.Delete(I);
        Break;
      end;
end;

{------------------------------------------------------------------------------}

procedure TLMDRichStorageItem.DoLinkClick(aSender: TObject; const aURLText: string;
  aButton: TMouseButton);
begin
  if Assigned(FOnLinkClick) then OnLinkClick(aSender, aURLText, aButton);
end;

{------------------------------------------------------------------------------}
class function TLMDRichStorageItems.GetItemClass: TCollectionItemClass;
begin
  Result:= TLMDRichStorageItem
end;

{------------------------------------------------------------------------------}
procedure TLMDRichStorageItem.DefineProperties(Filer: TFiler);
begin
  inherited; { allow base classes to define properties }
  Filer.DefineProperty('Text', LoadTextProperty, nil, false);
end;

{------------------------------------------------------------------------------}
procedure TLMDRichStorageItem.LoadTextProperty(Reader: TReader);
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

end.
