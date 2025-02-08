unit LMDHashTable;
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

LMDSedUtils unit (VT)
---------------------
This unit contains the utilities for LMD-Tools Syntax Edit packages.

Changes
-------
Release 8.0 (May 2007)
 - Initial Release

###############################################################################}

interface

uses
  Classes, LMDProcs, LMDTypes, LMDStrings;

type
  TLMDHashTable            = class;
  TLMDHashTableTraits      = class;
  TLMDHashTableTraitsClass = class of TLMDHashTableTraits;

  {*************************** TLMDHashTableTraits ****************************}

  TLMDHashUpdateAction = (uaDelete, uaNothing);

  TLMDHashTableTraits = class
  public
    class function BeforeAdd(AItem: TObject;
                             ATable: TLMDHashTable): Boolean; virtual;
    class function MakeHashI(AItem: TObject): Integer; virtual;
    class function MakeHashK(const AKey): Integer; virtual;
    class function Compare(const AKey; AItem: TObject): Boolean; virtual;
    class function OnUpdate(AItem: TObject): TLMDHashUpdateAction; virtual;
  end;

  {**************************** TLMDHashTableColl *****************************}

  TLMDHashTableColl = class
  public
    Item: TObject;
    Next: TObject;
  end;

  {****************************** TLMDHashTable *******************************}

  TLMDHashTableItemProc   = procedure(AItem: TObject) of object;
  TLMDHashTableItemProcEx = procedure(AItem: TObject;
                                      AUserData: TLMDDataTag) of object;

  TLMDHashTable = class
  private
    FTraits:     TLMDHashTableTraitsClass;
    FOwnItems:   Boolean;
    FItems:      array of TObject;
    FIndexMask:  Integer;
    FCount:      Integer;

    procedure Grow(AOldLength: Integer);
    procedure Rehash(AOldLength: Integer);
    procedure InsertItem(AItem: TObject);
    function  CreateColl(AItem, ANext: TObject): TLMDHashTableColl;
    function  DecodeEntry(ACur: TObject; out AItem, ANext: TObject;
                          out AIsCol: Boolean): Boolean;
  public
    constructor Create(ATraits: TLMDHashTableTraitsClass;
                       AOwnItems: Boolean = False);
    destructor Destroy; override;

    class function IntHash(AKey: Integer): Integer;
    class function PtrHash(AKey: Pointer): Integer;
    class function StrHash(const AKey: TLMDString): Integer;

    procedure Clear;
    function  Add(AItem: TObject): Boolean;
    function  Remove(const AKey): Boolean;
    function  Find(const AKey): TObject;
    procedure GetAll(AResult: TList); overload;
    procedure GetAll(AProc: TLMDHashTableItemProc); overload;
    procedure GetAll(AProc: TLMDHashTableItemProcEx;
                     AUserData: TLMDDataTag); overload;

    procedure Update;

    property Count: Integer read FCount;
  end;

implementation

uses
  SysUtils, Math, LMDRTLConst;

{************************* class TLMDHashTableTraits **************************}
{ ---------------------------------- public ---------------------------------- }

class function TLMDHashTableTraits.BeforeAdd(AItem: TObject;
  ATable: TLMDHashTable): Boolean;
begin
  Result := True;
end;

{ ---------------------------------------------------------------------------- }

class function TLMDHashTableTraits.MakeHashI(AItem: TObject): Integer;
begin
  Result := 0;
  Assert(False); // This method is not abstract only for
                 // C++ Builder compatibility.
end;

{ ---------------------------------------------------------------------------- }

class function TLMDHashTableTraits.MakeHashK(const AKey): Integer;
begin
  Result := 0;
  Assert(False); // This method is not abstract only for
                 // C++ Builder compatibility.
end;

{ ---------------------------------------------------------------------------- }

class function TLMDHashTableTraits.Compare(
  const AKey; AItem: TObject): Boolean;
begin
  Result := False;
  Assert(False); // This method is not abstract only for
                 // C++ Builder compatibility.
end;

class function TLMDHashTableTraits.OnUpdate(
  AItem: TObject): TLMDHashUpdateAction;
begin
  Result := uaNothing;
end;

{**************************** class TLMDHashTable *****************************}
{ --------------------------------- private ---------------------------------- }

procedure TLMDHashTable.Grow(AOldLength: Integer);
begin
  if AOldLength = 0 then
    SetLength(FItems, 4)
  else
    SetLength(FItems, AOldLength * 2);
  FIndexMask := High(FItems);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDHashTable.Rehash(AOldLength: Integer);
var
  i:         Integer;
  iscol:     Boolean;
  cur, next: TObject;
  itm:       TObject;
begin
  for i := AOldLength - 1 downto 0 do // More effective to go backward.
  begin
    cur       := FItems[i];
    FItems[i] := nil;

    while DecodeEntry(cur, itm, next, iscol) do
    begin
      InsertItem(itm);

      if iscol then
        cur.Free;
      cur := next;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDHashTable.InsertItem(AItem: TObject);
var
  idx: Integer;
begin
  idx := FTraits.MakeHashI(AItem) and FIndexMask;
  if FItems[idx] = nil then
    FItems[idx] := AItem
  else
    FItems[idx] := CreateColl(AItem, FItems[idx]);
end;

{ ---------------------------------------------------------------------------- }

function TLMDHashTable.CreateColl(AItem,
  ANext: TObject): TLMDHashTableColl;
begin
  Result      := TLMDHashTableColl.Create;
  Result.Item := AItem;
  Result.Next := ANext;
end;

{ ---------------------------------------------------------------------------- }

function TLMDHashTable.DecodeEntry(ACur: TObject; out AItem,
  ANext: TObject; out AIsCol: Boolean): Boolean;
begin
  Result := (ACur <> nil);
  if not Result then
    Exit;

  AIsCol := (ACur.ClassType = TLMDHashTableColl); // Faster than 'is'.
  if AIsCol then
  begin
    AItem := TLMDHashTableColl(ACur).Item;
    ANext := TLMDHashTableColl(ACur).Next;
  end
  else
  begin
    AItem := ACur;
    ANext := nil;
  end;
end;

{ ---------------------------------- public ---------------------------------- }

constructor TLMDHashTable.Create(ATraits: TLMDHashTableTraitsClass;
  AOwnItems: Boolean);
begin
  inherited Create;
  FTraits   := ATraits;
  FOwnItems := AOwnItems;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDHashTable.Destroy;
begin
  Clear;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

class function TLMDHashTable.IntHash(AKey: Integer): Integer;
begin
  Result := AKey;
  Result := Result + not (Result shl 9);
  Result := Result xor   (Result shr 14);
  Result := Result +     (Result shl 4);
  Result := Result xor   (Result shr 10);
end;

class function TLMDHashTable.PtrHash(AKey: Pointer): Integer;
type
  PPtrInts = ^TPtrInts;
  TPtrInts = packed record
    I1, I2: Integer;
  end;
var
  res: TLMDPtrInt;
begin
  res    := TLMDPtrInt(AKey);
  res    := res + not (res shl 9);
  res    := res xor   (res shr 14);
  res    := res +     (res shl 4);
  res    := res xor   (res shr 10);
  Result := PPtrInts(@res).I1 {$IFDEF LMDX64}xor TPtrInts(res).I2{$ENDIF};
end;

{ ---------------------------------------------------------------------------- }

class function TLMDHashTable.StrHash(const AKey: TLMDString): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Length(AKey) do
    Result := (Result shl 2) + Ord(AKey[i]);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDHashTable.Clear;
var
  i:         Integer;
  iscol:     Boolean;
  cur, next: TObject;
  itm:       TObject;
begin
  for i := 0 to High(FItems) do
  begin
    cur       := FItems[i];
    FItems[i] := nil;

    while DecodeEntry(cur, itm, next, iscol) do
    begin
      if iscol then
         cur.Free;
      if FOwnItems then
        itm.Free;
      cur := next;
    end;
  end;

  SetLength(FItems, 0);
  FIndexMask := 0;
  FCount     := 0;
end;

{ ---------------------------------------------------------------------------- }

function TLMDHashTable.Add(AItem: TObject): Boolean;
var
  oldlen: Integer;
begin
  Result := FTraits.BeforeAdd(AItem, Self);
  if not Result then
    Exit;

  oldlen := Length(FItems);
  if FCount = oldlen then
  begin
    Grow(oldlen);
    Rehash(oldlen);
  end;

  InsertItem(AItem);
  Inc(FCount);
end;

{ ---------------------------------------------------------------------------- }

function TLMDHashTable.Remove(const AKey): Boolean;
var
  idx:             Integer;
  iscol:           Boolean;
  prev, cur, next: TObject;
  itm:             TObject;
begin
  if FIndexMask = 0 then
  begin
    Result := False;
    Exit;
  end;

  idx  := FTraits.MakeHashK(AKey) and FIndexMask;
  cur  := FItems[idx];
  prev := nil;

  while DecodeEntry(cur, itm, next, iscol) do
  begin
    if FTraits.Compare(AKey, itm) then
    begin
      if prev = nil then
        FItems[idx] := next
      else
        TLMDHashTableColl(prev).Next := next;

      if iscol then
          cur.Free;
      if FOwnItems then
        itm.Free;

      Dec(FCount);
      Result := True;
      Exit;
    end;

    prev := cur;
    cur  := next;
  end;

  Result := False;
end;

{ ---------------------------------------------------------------------------- }

function TLMDHashTable.Find(const AKey): TObject;
var
  idx:       Integer;
  iscol:     Boolean;
  cur, next: TObject;
  itm:       TObject;
begin
  if FIndexMask = 0 then
  begin
    Result := nil;
    Exit;
  end;

  idx := FTraits.MakeHashK(AKey) and FIndexMask;
  cur := FItems[idx];

  while DecodeEntry(cur, itm, next, iscol) do
  begin
    if FTraits.Compare(AKey, itm) then
    begin
      Result := itm;
      Exit;
    end;

    cur := next;
  end;

  Result := nil;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDHashTable.GetAll(AResult: TList);
var
  i:         Integer;
  iscol:     Boolean;
  cur, next: TObject;
  itm:       TObject;
begin
  for i := 0 to High(FItems) do
  begin
    cur := FItems[i];
    while DecodeEntry(cur, itm, next, iscol) do
    begin
      AResult.Add(itm);
      cur := next;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHashTable.GetAll(AProc: TLMDHashTableItemProc);
var
  i:         Integer;
  iscol:     Boolean;
  cur, next: TObject;
  itm:       TObject;
begin
  for i := 0 to High(FItems) do
  begin
    cur := FItems[i];
    while DecodeEntry(cur, itm, next, iscol) do
    begin
      AProc(itm);
      cur := next;
    end;
  end;
end;
    
{------------------------------------------------------------------------------}

procedure TLMDHashTable.Update;
var
  i, idx:           Integer;
  iscol:            Boolean;
  cur, next, prev:  TObject;
  itm:              TObject;
  needRehash:       Boolean;
begin
  needRehash := False;

  for i := 0 to High(FItems) do
  begin
    cur  := FItems[i];
    prev := nil;

    while DecodeEntry(cur, itm, next, iscol) do
    begin
      if FTraits.OnUpdate(itm) = uaDelete then
      begin
        if prev = nil then
          FItems[i] := next
        else
          TLMDHashTableColl(prev).Next := next;

        if iscol then
          cur.Free;
        if FOwnItems then
          itm.Free;

        Dec(FCount);
      end
      else
      begin
        idx        := FTraits.MakeHashI(itm) and FIndexMask;
        needRehash := needRehash or (idx <> i);
        prev       := cur;
      end;

      cur := next;
    end;
  end;

  if needRehash then
    Rehash(Length(FItems));
end;

procedure TLMDHashTable.GetAll(AProc: TLMDHashTableItemProcEx;
  AUserData: TLMDDataTag);
var
  i:         Integer;
  iscol:     Boolean;
  cur, next: TObject;
  itm:       TObject;
begin
  for i := 0 to High(FItems) do
  begin
    cur := FItems[i];
    while DecodeEntry(cur, itm, next, iscol) do
    begin
      AProc(itm, AUserData);
      cur := next;
    end;
  end;
end;

end.
