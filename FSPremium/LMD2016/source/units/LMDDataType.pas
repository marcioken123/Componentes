unit LMDDataType;
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

LMDDataType unit (VO)
---------------------

TLMDHashTable - hash table TLMDCustomStack is a stack for pointers.

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}
interface
uses
  Classes;

type

  { ************************************************************************** }
  TLMDAssociation = class (TCollectionItem)
  private
    FKey        : string;
  protected
  public
    constructor Create(aCollection : TCollection); override;
    property Key : string read FKey write FKey;
  end;

  TLMDAssociationClass = class of TLMDAssociation;

  { ************************************************************************** }
  TLMDMap = class (TCollection)
  private
    function GetItem(const index : string) : TLMDAssociation;
    function Find(const aKey: string; var Index: Integer): Boolean;
  protected
  public
    constructor Create(aItemClass: TLMDAssociationClass);
    destructor Destroy; override;
    function Add(const aKey : string) : TLMDAssociation;
    property Items[const index : string] : TLMDAssociation read GetItem; default;
  end;

  { ************************************************************************** }
  TLMDHashTable = class
  private
    FList       : TList;
    FMaxSize    : integer;
    FItemClass  : TLMDAssociationClass;
    FRand : array[0..255] of byte;
    procedure FillRand;
  protected
    function GetItem(const index : string) : TLMDAssociation;
  public
    constructor Create(aMaxSize : integer; aItemClass: TLMDAssociationClass);
    destructor Destroy; override;
    function Hash(const aKey : string) : integer; virtual;
    function Add(const aKey : string) : TLMDAssociation;
    function count : integer;
    procedure Clear;
    property Items[const index : string] : TLMDAssociation read GetItem; default;
  end;

  { ************************************************************************** }
  TLMDCustomStack = class (TPersistent)
  private
    FList : TList;
  protected
    function GetTop : pointer;
    procedure SetTop(aValue : pointer);
    public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Push(aItem : pointer);
    function Pop : pointer;
    property Top : pointer read GetTop write SetTop;
    function IsEmpty : boolean;
  end;

implementation
uses
  Sysutils;

{ ********************************* TLMDAssociation ************************** }
{---------------------------------- private -----------------------------------}
{---------------------------------- protected ---------------------------------}
{---------------------------------- public ------------------------------------}
constructor TLMDAssociation.Create(aCollection : TCollection);
begin
  inherited;
  FKey := '';
end;

{ ********************************* TLMDMap ********************************** }
{---------------------------------- private -----------------------------------}
function TLMDMap.GetItem(const index : string) : TLMDAssociation;
var
  idx : integer;
begin
  result := nil;
  if Find(index, idx) then
    result := TLMDAssociation(inherited GetItem(idx));
end;

{------------------------------------------------------------------------------}
function TLMDMap.Find(const aKey: string; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := AnsiCompareText(TLMDAssociation(Inherited GetItem(I)).Key, aKey);
    if C < 0 then L := I + 1 else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        L := I;
      end;
    end;
  end;
  Index := L;
end;

{---------------------------------- protected ---------------------------------}
{---------------------------------- public ------------------------------------}
constructor TLMDMap.Create(aItemClass: TLMDAssociationClass);
begin
  inherited Create(aItemClass);
end;

{------------------------------------------------------------------------------}
destructor TLMDMap.Destroy;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDMap.Add(const aKey : string) : TLMDAssociation;
var
  Item  : TLMDAssociation;
  index : integer;
begin
  if Count = 0 then
    Item := TLMDAssociation(inherited Add)
  else
    if Find(aKey, index) then
      Item := TLMDAssociation(inherited GetItem(index))
    else
      Item := TLMDAssociation(inherited Insert(index));

  Item.Key := aKey;
  result := Item;
end;

{ ********************************* TLMDHashTable **************************** }
{---------------------------------- private -----------------------------------}
function TLMDHashTable.GetItem(const index : string) : TLMDAssociation;
var
  idx : integer;
  aIndex: string;
begin
  aIndex := AnsiUpperCase(index);
  idx := Hash(aIndex);
  if (idx < FList.count) and assigned(FList[idx]) then
    result := TLMDMap(FList[idx])[index]
  else
    result := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDHashTable.FillRand;
var
  i : byte;
begin
  randomize;
  for i := 0 to 255 do
    begin
      FRand[i] := round(random(255));
    end;
end;

{---------------------------------- protected ---------------------------------}
function TLMDHashTable.Hash(const aKey : string) : integer;
var
  idx1  : byte;
  idx2  : byte;
  i     : integer;
begin
  if aKey = '' then result := 0
  else
    begin
      idx1 := ord(aKey[1]); idx2 := idx1 + 1;
      for i := 2 to Length(aKey) do
        begin
          idx1 := FRand[idx1 xor ord(aKey[i])];
          idx2 := FRand[idx2 xor ord(aKey[i])];
        end;
      result := (idx1 shl 8) or idx2;
      result := result mod FMaxSize;
    end;
end;

{---------------------------------- public ------------------------------------}
constructor TLMDHashTable.Create(aMaxSize : integer; aItemClass: TLMDAssociationClass);
begin
  inherited Create;
  FList := TList.Create;
  FMaxSize := aMaxSize;
  FItemClass := aItemClass;
  FillRand;
end;

{------------------------------------------------------------------------------}
destructor TLMDHashTable.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDHashTable.Add(const aKey : string) : TLMDAssociation;
var
  index : integer;
  Map   : TLMDMap;
  i     : integer;
  Key   : string;
begin
  Key := AnsiUpperCase(aKey);
  index := Hash(Key);
  if index < FList.count then
    if assigned(FList[index]) then
      Map := TLMDMap(FList[index])
    else
      begin
        Map := TLMDMap.Create(FItemClass);
        FList[index] := pointer(Map);
        end
  else
    begin
      Map := TLMDMap.Create(FItemClass);
      for i := FList.count to index do FList.Add(nil);
      FList[index] := pointer(Map);
      end;

    result := Map.Add(Key);
end;

{------------------------------------------------------------------------------}
function TLMDHashTable.Count : integer;
begin
  if  Assigned(FList) then
    result := FList.count
  else
    result := 0;
end;

{------------------------------------------------------------------------------}
procedure TLMDHashTable.Clear;
var
  i : integer;
begin
  for i := 0 to FList.count-1 do
    if assigned(FList[i]) then
      TLMDMap(FList[i]).Free;
  FList.Clear;
end;

{ ********************************* TLMDCustomStack ************************** }
{---------------------------------- private -----------------------------------}
{---------------------------------- protected ---------------------------------}
function TLMDCustomStack.GetTop : pointer;
begin
  result := nil;
  if IsEmpty then Exit;
  result := FList[FList.count-1];
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomStack.SetTop(aValue : pointer);

begin
  if IsEmpty then Exit;
  FList[FList.count-1] := aValue;
end;

{---------------------------------- public ------------------------------------}
constructor TLMDCustomStack.Create;
begin
  inherited;
  FList := TList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomStack.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomStack.Clear;
begin
  FList.Clear;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomStack.Push(aItem : pointer);

begin
  FList.Add(aItem);
end;

{------------------------------------------------------------------------------}
function TLMDCustomStack.Pop : pointer;
begin
  result := nil;
  if IsEmpty then Exit;
  result := FList[FList.count-1];
  FList.Delete(FList.count-1);
end;

{------------------------------------------------------------------------------}
function TLMDCustomStack.IsEmpty : boolean;
begin
  result := not Assigned(FList) or (FList.count = 0);
end;

end.
