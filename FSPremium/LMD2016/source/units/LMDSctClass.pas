unit LMDSctClass;
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

LMDSctClass unit (YB)
---------------------------------
LMD Script Pack base classes unit.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Variants, VarUtils;

type
  PLMDVarArray = ^TLMDVarArray;
  TLMDVarArray = array[0..1024] of OleVariant;

 {************************** TLMDIdentifierHashTable *************************}

  TLMDIdentifierItem = class
  public
    Name:      WideString;
    Data:      TObject;
  end;

  TLMDIdentifierHashTable = class
  private
    FOwnItems:  Boolean;
    FItems:     array of TObject;
    FIndexMask: Integer;
    FCount:     Integer;

    procedure Grow(AOldLength: Integer);
    procedure Rehash(AOldLength: Integer);
    procedure InsertItem(AItem: TObject);
    function  CreateColl(AItem: TObject; ANext: TObject): TObject;
    function  DecodeEntry(ACur: TObject; out AItem, ANext: TObject;
                          out AIsCol: Boolean): Boolean;
    function  StrHash(const AKey: WideString): Integer;
  public
    constructor Create(AOwnItems: Boolean = False);
    destructor Destroy; override;

    procedure Clear;
    function  Add(AItem: TLMDIdentifierItem): Boolean;
    function  Remove(const AKey: WideString): Boolean;
    function  Find(const AKey: WideString): TLMDIdentifierItem;
    procedure GetAll(AResult: TList);

    property Count: Integer read FCount;
  end;

  {*************************** TLMDNameHashTable ******************************}

  TLMDNamedItem = class
  private
    FName: Integer;
    FNext: TLMDNamedItem;
  public
    constructor Create(const AName: Integer);
    property    Name: Integer read FName;
  end;

  TLMDNameHashTable = class
  private
    FOwnItems:  Boolean;
    FItems:     array of TLMDNamedItem;
    FIndexMask: Integer;
    FCount:     Integer;

    procedure      Grow(AOldLength: Integer);
    procedure      Rehash(AOldLength: Integer);
    procedure      InsertItem(AItem: TLMDNamedItem);
  public
    constructor Create(AOwnItems: Boolean = False);
    destructor Destroy; override;

    procedure Clear;
    function  Add(AItem: TLMDNamedItem): Boolean;
    function  Remove(const AKey: Integer): Boolean;
    function  Find(const AKey: Integer): TLMDNamedItem;
    procedure GetAll(AResult: TList);

    property Count: Integer read FCount;
  end;

{$IFNDEF LMDCOMP7}
resourcestring
  SInvalidVarCast = 'Invalid variant type conversion';
  SVarArrayCreate = 'Error creating variant or safe array';
  SVarBadType = 'Invalid variant type';
  SVarOverflow = 'Variant overflow';
  SVarArrayBounds = 'Variant or safe array index out of bounds';
  SVarArrayLocked = 'Variant or safe array is locked';
  SVarNotImplemented = 'Operation not supported';
  SOutOfMemory = 'Out of memory';
  SVarInvalid = 'Invalid argument';
  SVarUnexpected = 'Unexpected variant error';
  SInvalidVarOpWithHResultWithPrefix = 'Invalid variant operation (%s%.8x)'#10'%s';
{$ENDIF}

type
  EVariantTypeCastError = {$IFNDEF LMDCOMP7}class(EVariantError)
                          {$ELSE} Variants.EVariantTypeCastError{$ENDIF};
  EVariantArrayCreateError = {$IFNDEF LMDCOMP7}class(EVariantError)
                            {$ELSE} Variants.EVariantArrayCreateError{$ENDIF};

{****************** Routines to isolate VM from Variants unit *****************}

procedure VarResultCheck(AResult: HRESULT);
procedure VarCastError;
procedure VarInvalidOp;
procedure VarArrayCreateError;
function  TryGetCustomVarTypeName(AType: TVarType; out S: WideString): Boolean;
{$IFNDEF LMDCOMP7}
function  FindVarData(const V: Variant): PVarData;
{$ENDIF}

implementation

type
  TCollision = class
  public
    Item: TObject;
    Next: TObject;
  end;

{ ---------------------------------------------------------------------------- }

procedure VarResultCheck(AResult: HRESULT);

  {$IFNDEF LMDCOMP7}
  procedure _TranslateResult(AResult: HRESULT);
  begin
    case AResult of
      VAR_TYPEMISMATCH:  VarCastError;
      VAR_BADVARTYPE:    raise EVariantError.Create(SVarBadType);
      VAR_EXCEPTION:     VarInvalidOp;
      VAR_OVERFLOW:      raise EVariantError.Create(SVarOverflow);
      VAR_BADINDEX:      raise EVariantError.Create(SVarArrayBounds);
      VAR_ARRAYISLOCKED: raise EVariantError.Create(SVarArrayLocked);
      VAR_NOTIMPL:       raise EVariantError.Create(SVarNotImplemented);
      VAR_OUTOFMEMORY:   raise EVariantError.Create(SOutOfMemory);
      VAR_INVALIDARG:    raise EVariantError.Create(SVarInvalid);
      VAR_UNEXPECTED:    raise EVariantError.Create(SVarUnexpected);
    else
      raise EVariantError.CreateFmt(SInvalidVarOpWithHResultWithPrefix,
        [HexDisplayPrefix, AResult, SysErrorMessage(AResult)]);
    end;
  end;
  {$ENDIF}

begin
  {$IFDEF LMDCOMP7}
  Variants.VarResultCheck(AResult);
  {$ELSE}
  if AResult <> VAR_OK then
    _TranslateResult(AResult);
  {$ENDIF}
end;

{ ---------------------------------------------------------------------------- }

procedure VarCastError;
begin
  {$IFNDEF LMDCOMP7}
  raise EVariantTypeCastError.Create(SInvalidVarCast);
  {$ELSE}
  Variants.VarCastError;
  {$ENDIF}
end;

{-----------------------------------------------------------------------------}

procedure VarInvalidOp;
{$IFNDEF LMDCOMP7}
asm
        MOV     AL,System.reVarInvalidOp
        JMP     System.Error
end;
{$ELSE}
begin
  Variants.VarInvalidOp;
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }

procedure VarArrayCreateError;
begin
  {$IFNDEF LMDCOMP7}
  raise EVariantArrayCreateError.Create(SVarArrayCreate);
  {$ELSE}
  Variants.VarArrayCreateError;
  {$ENDIF}
end;
        
{ ---------------------------------------------------------------------------- }

{$IFNDEF LMDCOMP7}
function FindVarData(const V: Variant): PVarData;
begin
  Result := @TVarData(V);
  while Result.VType = varByRef or varVariant do
    Result := PVarData(Result.VPointer);        
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }

function TryGetCustomVarTypeName(AType: TVarType; out S: WideString): Boolean;
var
  hdr: TCustomVariantType;
begin
  Result := FindCustomVariantType(AType, hdr);
  if Result then
    S := Copy(hdr.ClassName, 2, MaxInt);
end;

{ ---------------------------------------------------------------------------- }

function IntHash(AKey: Integer): Integer;
begin
  Result := AKey;
  Result := Result + not (Result shl 9);
  Result := Result xor   (Result shr 14);
  Result := Result +     (Result shl 4);
  Result := Result xor   (Result shr 10);
end;

{ ---------------------------------------------------------------------------- }

{*************************** class TLMDNameHashTable **************************}
{ --------------------------------- private ---------------------------------- }
procedure TLMDIdentifierHashTable.Grow(AOldLength: Integer);
begin
  if AOldLength = 0 then
    SetLength(FItems, 4)
  else
    SetLength(FItems, AOldLength * 2);
  FIndexMask := High(FItems);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDIdentifierHashTable.Rehash(AOldLength: Integer);
var
  i:         Integer;
  iscol:     Boolean;
  cur, next: TObject;
  itm:       TObject;
begin
  for i := AOldLength - 1 downto 0 do // More effective to do backward.
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
procedure TLMDIdentifierHashTable.InsertItem(AItem: TObject);
var
  idx: Integer;
begin
  idx := StrHash(TLMDIdentifierItem(AItem).Name) and FIndexMask;
  if FItems[idx] = nil then
    FItems[idx] := AItem
  else
    FItems[idx] := CreateColl(AItem, FItems[idx]);
end;

{ ---------------------------------------------------------------------------- }
function TLMDIdentifierHashTable.CreateColl(AItem,
  ANext: TObject): TObject;
var
  coll: TCollision;
begin
  coll      := TCollision.Create;
  coll.Item := AItem;
  coll.Next := ANext;
  Result    := coll;
end;

{ ---------------------------------------------------------------------------- }
function TLMDIdentifierHashTable.DecodeEntry(ACur: TObject;
 out AItem, ANext: TObject; out AIsCol: Boolean): Boolean;
begin
  Result := (ACur <> nil);
  if not Result then
    Exit;

  AIsCol := (ACur.ClassType = TCollision); // Faster then 'is'.
  if AIsCol then
  begin
    AItem := TCollision(ACur).Item;
    ANext := TCollision(ACur).Next;
  end
  else
  begin
    AItem := ACur;
    ANext := nil;
  end;
end;

{ ---------------------------------- public ---------------------------------- }
constructor TLMDIdentifierHashTable.Create(AOwnItems: Boolean);
begin
  inherited Create;
  FOwnItems := AOwnItems;
  Grow(0);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDIdentifierHashTable.Destroy;
begin
  Clear;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDIdentifierHashTable.StrHash(const AKey: WideString): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Length(AKey) do
    Result := (Result shl 2) + Ord(AKey[i]);
end;

{-----------------------------------------------------------------------------}
procedure TLMDIdentifierHashTable.Clear;
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
  Grow(0);
  FCount := 0;
end;

{ ---------------------------------------------------------------------------- }
function TLMDIdentifierHashTable.Add(AItem: TLMDIdentifierItem): Boolean;
var
  oldlen: Integer;
begin
  Result := (Find(AItem.Name) = nil);
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
function TLMDIdentifierHashTable.Remove(const AKey: WideString): Boolean;
var
  idx:             Integer;
  iscol:           Boolean;
  prev, cur, next: TObject;
  itm:             TObject;
begin
  idx  := StrHash(AKey) and FIndexMask;
  cur  := FItems[idx];
  prev := nil;

  while DecodeEntry(cur, itm, next, iscol) do
  begin
    if (AKey = TLMDIdentifierItem(itm).Name) then
    begin
      if prev = nil then
        FItems[idx] := next
      else
        TCollision(prev).Next := next;

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
function TLMDIdentifierHashTable.Find(
  const AKey: WideString): TLMDIdentifierItem;
var
  idx:       Integer;
  iscol:     Boolean;
  cur, next: TObject;
  itm:       TObject;
begin
  idx := StrHash(AKey) and FIndexMask;
  cur := FItems[idx];

  while DecodeEntry(cur, itm, next, iscol) do
  begin
    if (AKey = TLMDIdentifierItem(itm).Name) then
    begin
      Result := TLMDIdentifierItem(itm);
      Exit;
    end;

    cur := next;
  end;

  Result := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDIdentifierHashTable.GetAll(AResult: TList);
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
      AREsult.Add(itm);
      cur := next;
    end;
  end;
end;

{**************************** class TLMDNameHashTable *****************************}
{ --------------------------------- private ---------------------------------- }
procedure TLMDNameHashTable.Grow(AOldLength: Integer);
begin
  if AOldLength = 0 then
    SetLength(FItems, 4)
  else
    SetLength(FItems, AOldLength * 2);
  FIndexMask := High(FItems);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDNameHashTable.Rehash(AOldLength: Integer);
var
  i:         Integer;
  cur, next: TLMDNamedItem;
begin
  for i := AOldLength - 1 downto 0 do // More effective to do backward.
  begin
    cur       := FItems[i];
    FItems[i] := nil;

    while cur <> nil do
    begin
      next := cur.FNext;
      InsertItem(cur);

      cur := next;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDNameHashTable.InsertItem(AItem: TLMDNamedItem);
var
  idx: Integer;
begin
  idx := IntHash(TLMDNamedItem(AItem).Name) and FIndexMask;
  if FItems[idx] = nil then
  begin
    AItem.FNext := nil;
    FItems[idx] := AItem;
  end
  else
  begin
    AItem.FNext := FItems[idx];
    FItems[idx] := AItem;
  end;
end;

{ ---------------------------------- public ---------------------------------- }
constructor TLMDNameHashTable.Create(AOwnItems: Boolean);
begin
  inherited Create;
  FOwnItems := AOwnItems;
  Grow(0);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDNameHashTable.Destroy;
begin
  Clear;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDNameHashTable.Clear;
var
  i:         Integer;
  cur, next: TLMDNamedItem;
begin
  for i := 0 to High(FItems) do
  begin
    cur       := FItems[i];
    FItems[i] := nil;

    while cur <> nil do
    begin
      next := cur.FNext;
      if FOwnItems then
        cur.Free;
      cur := next;
    end;
  end;

  SetLength(FItems, 0);
  Grow(0);
  FCount := 0;
end;

{ ---------------------------------------------------------------------------- }
function TLMDNameHashTable.Add(AItem: TLMDNamedItem): Boolean;
var
  oldlen: Integer;
begin
  Result := (Find(AItem.Name) = nil);
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
function TLMDNameHashTable.Remove(const AKey: Integer): Boolean;
var
  idx:             Integer;
  prev, cur, next: TLMDNamedItem;
begin
  idx  := IntHash(AKey) and FIndexMask;
  cur  := FItems[idx];
  prev := nil;

  while cur <> nil do
  begin
    next := cur.FNext;

    if AKey = cur.Name then
    begin
      if prev = nil then
        FItems[idx] := next
      else
        prev.FNext := next;

      if FOwnItems then
        cur.Free;

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
function TLMDNameHashTable.Find(const AKey: Integer): TLMDNamedItem;
var
  idx:       Integer;
  cur, next: TLMDNamedItem;
begin
  idx := IntHash(AKey) and FIndexMask;
  cur := FItems[idx];

  while cur <> nil do
  begin
    next := cur.FNext;

    if AKey = cur.Name then
    begin
      Result := cur;
      Exit;
    end;

    cur := next;
  end;

  Result := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDNameHashTable.GetAll(AResult: TList);
var
  i:     Integer;
  cur:   TLMDNamedItem;
begin
  for i := 0 to High(FItems) do
  begin
    cur := FItems[i];

    while cur <> nil do
    begin
      AResult.Add(cur);
      cur := cur.FNext;
    end;
  end;
end;

{***************************** TLMDNamedItem **********************************}

constructor TLMDNamedItem.Create(const AName: Integer);
begin
  FName := AName;
end;

end.

