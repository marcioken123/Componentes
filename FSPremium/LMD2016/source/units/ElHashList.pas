unit ElHashList;
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

ElHashList unit
---------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

 { TElHashList component. }

{$Q-}
{$RANGECHECKS OFF}
{$ALIGN ON}

interface

uses
  SysUtils,
  LMDTypes,
  LMDProcs,
  ElCRC32(*, ElMD5*);

type
  EElHashListError = class(Exception)
  end;

const
  MaxHashListSize = Maxint div 16;

type
  THash = array[1..4] of integer;
  PHash = ^THash;
  THashRecord = record
    Hash: PHash;
    ItemData : Pointer;
  end;
  PHashRecord = ^THashRecord;
  THashList = array[0..MaxHashListSize - 1] of PHashRecord;
  PHashList = ^THashList;
  TElHashList = class;

  TElHashType = (ehtMD5, ehtQuick, ehtCRC32);

  OnHashDeleteEvent = procedure(Sender : TElHashList; Data : pointer) of object;

  THashInsertDupesMode = (himInsert, himRaise, himReplace, himIgnore, himMove);

  TElHashList = class(TObject)
  private
    FAutoClearObjects : Boolean;
    FNoCase : boolean;
    FHashType : TElHashType;
    FList : PHashList;
    FCount : Integer;
    FCapacity : Integer;
    FOnDelete : OnHashDeleteEvent;
    FQuickHash : Boolean;
    FInsertDupesMode : THashInsertDupesMode;
    FRaiseOnAbsence : Boolean;

    procedure Grow;
    procedure SetCapacity(NewCapacity : Integer);
    function GetItem(Hash : string) : pointer;
    procedure SetQuickHash(newValue : Boolean);
    procedure SetHashType(newValue : TElHashType);
    procedure SetAutoClearObjects(newValue : Boolean);
  protected
    { Protected declarations }

    function CalcQuickHash(Hash : string) : Integer; virtual;
  public
    { Public declarations }
    destructor Destroy; override;
    procedure AddItem(Hash : string; Value : pointer);
    procedure DeleteItem(Hash : string);
    procedure InsertItem(Index : integer; Hash : string; Value : pointer);
    function GetIndex(Hash : string) : integer;
    procedure Clear;

    property Count : Integer read FCount; { Public }
    property Capacity : Integer read FCapacity; { Public }
    function GetByIndex(Index : integer) : pointer;
    constructor Create;

    property Item[Hash : string] : pointer read GetItem; { Public }
    property OnDelete : OnHashDeleteEvent read FOnDelete write FOnDelete;
    property QuickHash : Boolean read FQuickHash write SetQuickHash; { Public }
    property RaiseOnAbsence : Boolean read FRaiseOnAbsence write FRaiseOnAbsence default False; { Public }
    property InsertDupesMode : THashInsertDupesMode read FInsertDupesMode write FInsertDupesMode; { Public }
    property HashType : TElHashType read FHashType write SetHashType; { Public }
    property NoCase : boolean read FNoCase write FNoCase;
    property AutoClearObjects : Boolean read FAutoClearObjects write SetAutoClearObjects; { Published }
  end; { TElHashList }

implementation

//uses
//  ElVCLUtils;

procedure TElHashList.AddItem(Hash : string; Value : pointer); { public }
begin
  InsertItem(FCount, Hash, Value);
end; { AddItem }

procedure TElHashList.DeleteItem(Hash : string); { public }
var
  index : integer;
begin
  Index := GetIndex(Hash);
  if (index < 0) or (index >= FCount) then
    raise EElHashListError.Create('Hash not found.');
  if Assigned(FOnDelete) then
    FOnDelete(Self, FList^[Index]^.ItemData);

  if AutoClearObjects and (FList^[Index]^.ItemData <> nil) then
    TObject(FList^[Index]^.ItemData).Free;

  Dec(FCount);
  if Index < FCount then
    System.Move(FList^[Index + 1], FList^[Index], (FCount - Index) * SizeOf(Pointer));
    if FCount < (FCapacity div 2) then SetCapacity(FCapacity div 2);
end; { DeleteItem }

procedure TElHashList.InsertItem(Index : integer; Hash : string; Value : pointer); { public }
var
  P : PHashRecord;
  (*
  MD5 : TCrMD5;
  *)
  b : boolean;
  i : integer;
  h : integer;
begin
  if (Index < 0) or (index > FCount) then
    raise EElHashListError.Create('Invalid position for HashList.');
  New(P);
  if FNoCase then Hash := Uppercase(Hash);
  case FHashType of
    ehtQuick: P.Hash := Pointer(CalcQuickHash(Hash));
    ehtCRC32,
    ehtMD5: P.Hash := Pointer(CrcStr(Hash));
    (*
    ehtMD5 :
      begin
        New(P^.Hash);
        MD5 := TCrMD5.Create;
        MD5.InputType := SourceString;
        MD5.InputString := Hash;
        MD5.pOutputArray := @hashDigest(P^.Hash^);
        MD5.MD5_Hash;
        MD5.Free;
      end;
    *)
  end;
  i := 0;
  if FQuickHash or (FHashType = ehtCrc32) then
  begin
    if FQuickHash then
      h := CalcQuickHash(Hash)
    else
      h := CrcStr(Hash);
    while (i < FCount) and (TLMDPtrInt(FList^[i]^.Hash) <> h) do
    inc(i);
  end
  else
  begin
    while (i < FCount) and
      (not CompareMem(P.Hash, FList^[i]^.Hash, SizeOf(Integer) * 4)) do
      inc(i);
  end;
  b := i <> FCount;
  if b then
  begin
    case FInsertDupesMode of
      himIgnore: exit;
      himRaise: raise EElHashListError.Create('Duplicate entry.');
      himReplace:
        begin
          i := GetIndex(Hash);
          Dispose(P);
          P := FList[i];
          if assigned(FOnDelete) then FOnDelete(Self, P.ItemData);
          P.ItemData := Value;
          exit;
        end;
    end;
  end;
  P.ItemData := Value;
  if FCount = FCapacity then Grow;
  if Index < FCount then
    System.Move(FList^[Index], FList^[Index + 1],
      (FCount - Index) * SizeOf(Pointer));
    FList^[Index] := P;
  Inc(FCount);
end; { InsertItem }

function TElHashList.GetItem(Hash : string): Pointer; { public }
var
  i : integer;
begin
  if FNoCase then Hash := Uppercase(Hash);
  i := GetIndex(Hash);
  if i = -1 then
  begin
    if RaiseOnAbsence then
      raise EElHashListError.Create('Hash is absent.')
    else
      result := nil;
  end
  else
    result := FList^[i]^.ItemData;
end; { GetItem }

{$WARNINGS off}
function TElHashList.GetIndex(Hash : string) : integer; { public }
type
  TArray4Int = array [1..4] of Integer;
  TInt = packed record
     case boolean of
       true: (wInt: Integer);
       false: (wFirst, wSecond: Byte);
  end;
var
(*
  MD5 : TCrMD5;
*)

  arr : TArray4Int;
  i : integer;
  h : integer;
  function Compare4ByteArray(const Array1: TArray4Int; Array2: THash): boolean;
  var
    i: 0..3;
    LInt: TInt;

  begin
    Result := False;
    for i := 0 to 3 do
    begin
      LInt.wFirst := Array2[i * 2];
      LInt.wSecond := Array2[i * 2 + 1];
      if LInt.wInt <> Array1[i + 1] then
        exit;
    end;
    Result := True;
  end;
begin
  if NoCase then Hash := Uppercase(Hash);
  case FHashType of
    ehtQuick : h := CalcQuickHash(Hash);
    ehtCRC32,
    ehtMD5 : h := CrcStr(Hash);
    (*
    ehtMD5 :
      begin
        MD5 := TCrMD5.Create;
        MD5.InputType := SourceString;
        MD5.InputString := Hash;
        MD5.pOutputArray := @arr;
        MD5.MD5_Hash;
        MD5.Free;
      end;
    *)
  end;
  i := 0;
  if (FQuickHash) or (FHashType <> ehtMD5) then
  while (i < FCount) and (TLMDPtrInt(FList^[i]^.Hash) <> h) do
    inc(i)
  else
    while (i < FCount) and (not CompareMem(@Arr, FList^[i]^.Hash, SizeOf(Integer) * 4)) do
      inc(i);
  if i = FCount then
  begin
    if RaiseOnAbsence then
      raise EElHashListError.Create('Hash is absent.')
    else
      result := -1;
  end
  else
    result := i;
end; { GetIndex }
{$WARNINGS on}

procedure TElHashList.SetCapacity(NewCapacity : Integer);
begin
  if (NewCapacity < FCount) or (NewCapacity > MaxHashListSize) then
    raise EElHashListError.Create('Invalid ElHashList capacity.');
  if NewCapacity <> FCapacity then
  begin
    ReallocMem(FList, NewCapacity * SizeOf(Pointer));
    FCapacity := NewCapacity;
  end;
end;

procedure TElHashList.Grow;
var
  Delta : Integer;
begin
  if FCapacity > 64 then
    Delta := FCapacity div 4
  else if FCapacity > 8 then
    Delta := 16
  else
    Delta := 4;
  SetCapacity(FCapacity + Delta);
end;

procedure TElHashList.Clear; { public }
var
  J : Integer;
begin
  for j := 0 to FCount - 1 do // Iterate
  begin
    if Assigned(FOnDelete) then
      FOnDelete(Self, FList[j].ItemData);
    if AutoClearObjects and (FList[j].ItemData <> nil) then
    TObject(FList^[j]^.ItemData).Free;
    (*
    if FHashType = ehtMD5 then Dispose(FList^[j]^.Hash);
    *)
    Dispose(FList^[j]);
    end;
  FCount := 0;
  SetCapacity(0);
end; { Clear }

function TElHashList.GetByIndex(Index : integer) : pointer; { public }
begin
  if (Index < 0) or (Index >= FCount) then
    raise EElHashListError.Create('Invalid index.')
  else
    result := FList[Index].ItemData;
end; { GetByIndex }

procedure TElHashList.SetHashType(newValue : TElHashType);
begin
  if FHashType <> newValue then
  begin
    Clear;
    FHashType := newValue;
    FQuickHash := FHashType = ehtQuick;
  end;
end;

procedure TElHashList.SetQuickHash(newValue : Boolean);
begin
  if (FQuickHash <> newValue) then
  begin
    Clear;
    FQuickHash := newValue;
    FHashType := ehtQuick;
  end; { if }
end; { SetQuickHash }

function TElHashList.CalcQuickHash(Hash : string) : Integer; { protected }
var
  i : integer;
begin
  result := 0;
  for i := 1 to Length(Hash) do
    result := result * 5 + byte(Hash[i]);
end; { CalcQuickHash }

procedure TElHashList.SetAutoClearObjects(newValue : Boolean);
{ Sets data member FAutoClearObjects to newValue. }
begin
  if (FAutoClearObjects <> newValue) then
  begin
    FAutoClearObjects := newValue;
  end; { if }
end; { SetAutoClearObjects }

destructor TElHashList.Destroy;
begin
  Clear;
  FreeMem(FList, FCapacity);
  inherited Destroy;
end; { Destroy }

constructor TElHashList.Create;
begin
  inherited;
  FRaiseOnAbsence := False;
  FInsertDupesMode := himInsert;
end; { Create }

end.
