unit LMDArray;
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

LMDArray unit ()
----------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils,
  Windows,
  LMDRTLConst,
  LMDTypes,
  LMDProcs;

type
  TLMDArraySortCompare = function(Item1, Item2: TxListItem; Cargo: TxListItem): Integer;

  TLMDArrayDeleteEvent = procedure(Sender: TObject; Item: TxListItem) of object;

  TLMDArray = class
  protected
    FList: PPointerList;
    FCount: Integer;
    FCapacity: Integer;
    FAutoClearObjects: Boolean;
    FOnDelete: TLMDArrayDeleteEvent;
    function Get(Index: Integer): TxListItem; virtual;
    procedure Grow; virtual;
    procedure Put(Index: Integer; const Item: TxListItem); virtual;
    procedure SetCapacity(NewCapacity: Integer);
    procedure SetCount(NewCount: Integer);
    procedure TriggerDeleteEvent(const Item: TxListItem); virtual;
    class procedure Error(const Msg: string; Data: Integer);
    public
    constructor Create;
    destructor Destroy; override;
    procedure CheckRange(Index:Integer);
    function Add(const Item: TxListItem): Integer;
    procedure Clear;
    procedure Assign(AList: TLMDArray);
    procedure Delete(Index: Integer); virtual;
    procedure Exchange(Index1, Index2: Integer);
    function Expand: TLMDArray;
    function First: TxListItem;
    function IndexOf(const Item: TxListItem): Integer;
    function IndexOfFrom(StartIndex: integer; const Item: TxListItem): Integer;
    function IndexOfBack(StartIndex: integer; const Item: TxListItem): Integer;
    procedure Insert(Index: Integer; const Item: TxListItem);
    function Last: TxListItem;
    procedure Move(CurIndex, NewIndex: Integer);
    procedure MoveRange(CurStart, CurEnd, NewStart: integer);
    function Remove(const Item: TxListItem): Integer;
    procedure Pack;
    procedure Sort(Compare: TLMDArraySortCompare; const Cargo: TxListItem);
    property Capacity: Integer read FCapacity write SetCapacity default 0;
    property Count: Integer read FCount write SetCount default 0;
    property Items[Index: Integer]: TxListItem read Get write Put; default;
    property List: PPointerList read FList;
    property AutoClearObjects: Boolean read FAutoClearObjects write FAutoClearObjects default False; { Published }
    property OnDelete: TLMDArrayDeleteEvent read FOnDelete write FOnDelete;
  end;

implementation

type
  ELMDArrayError = class(Exception);

procedure RaiseOutOfBoundsError(Ind: integer);
begin
  raise ELMDArrayError.CreateFmt(SLMDListIndexOutOfBounds, [Ind]);
end;

class procedure TLMDArray.Error(const Msg: string; Data: Integer);

  function ReturnAddr: TxListItem;
  asm
    MOV     EAX,[EBP+4]
  end;

begin
  raise ELMDArrayError.CreateFmt(Msg, [Data])at ReturnAddr;
end;

constructor TLMDArray.Create;
begin
  inherited;
  FList := nil;
  FCount := 0;
  FCapacity := 0;
  FAutoClearObjects := FALSE;
  FOnDelete := nil;
end;

destructor TLMDArray.Destroy;
begin
  Clear;
  inherited;
end;

function TLMDArray.Add(const Item: TxListItem): Integer;
begin
  Result := FCount;
  if Result = FCapacity then Grow;
  FList[Result] := Item;
  Inc(FCount);
end;

procedure TLMDArray.Assign(AList: TLMDArray);
begin
  Clear;
  SetCapacity(AList.Capacity);
  SetCount(AList.Count);
  System.Move(AList.FList^[0], FList^[0], FCount);
  end;

procedure TLMDArray.Clear;
var
  I: integer;
  p: TxListItem;
  begin
  if Assigned(FOnDelete) then
    for i := 0 to Count - 1 do
      if FList[i] <> nil then
        TriggerDeleteEvent(FList[i]);
  if AutoClearObjects then
    for i := 0 to Count - 1 do
    begin
      p := Get(i);
      try
        if (P <> nil) and (TObject(P) is TObject) then TObject(P).Free;
      except
      end;
      end;
  SetCount(0);
  SetCapacity(0);
end;

procedure TLMDArray.CheckRange(Index:Integer);
begin
    if (Index < 0) or (Index >= FCount) then
      RaiseOutOfBoundsError(Index);
end;

procedure TLMDArray.Delete(Index: Integer);
begin
  CheckRange(Index);

  if Assigned(FList[Index]) then
    begin
      TriggerDeleteEvent(FList[Index]);
      if AutoClearObjects then
        try
          TObject(FList[Index]).Free;
        except
          FList[Index] := nil;
        end;
    end;

  Dec(FCount);
  if Index < FCount then
    System.Move(FList^[Index + 1], FList^[Index], (FCount - Index) * SizeOf(TxListItem))
    else
    FList[Index] := nil;

  if FCount < (FCapacity div 2) then
    SetCapacity(FCapacity div 2);
end;

procedure TLMDArray.Exchange(Index1, Index2: Integer);
 var Item: TxListItem;
begin
  CheckRange(Index1);
  CheckRange(Index2);

  if (Index1 >= FCount) then
    Count := Index1 + 1;
  if (Index2 >= FCount) then
    Count := Index2 + 1;

  Item := FList[Index1];
  FList[Index1] := FList[Index2];
  FList[Index2] := Item;
end;

function TLMDArray.Expand: TLMDArray;
begin
  if FCount = FCapacity then
    Grow;
  Result := Self;
end;

function TLMDArray.First: TxListItem;
begin
  CheckRange(0);
  Result := Get(0);
end;

function TLMDArray.Get(Index: Integer): TxListItem;
begin
  if (Index < 0) then RaiseOutOfBoundsError(Index);
  if (Index >= FCount) then
    Result := nil
  else
    Result := FList[Index];
end;

procedure TLMDArray.Grow;
 var Delta: Integer;
begin
  if FCapacity > 64 then
    Delta := FCapacity div 4
  else if FCapacity > 8 then
    Delta := 16
  else
    Delta := 4;
  SetCapacity(FCapacity + Delta);
end;

function TLMDArray.IndexOfFrom(StartIndex: integer; const Item: TxListItem): Integer;
begin
  if (StartIndex < 0) then
    RaiseOutOfBoundsError(StartIndex);
  if (StartIndex >= FCount) then
    Result := -1
  else
    begin
      Result := StartIndex;
      while (Result < FCount) and (FList[Result] <> Item) do
        Inc(Result);
      if Result = FCount then
        Result := -1;
    end;
end;

function TLMDArray.IndexOfBack(StartIndex: integer; const Item: TxListItem): Integer;
begin
  if (StartIndex < 0) then
    RaiseOutOfBoundsError(StartIndex);
  if (StartIndex >= FCount) then
    Result := FCount - 1
  else
    Result := StartIndex;
  while (Result >= 0) and (FList[Result] <> Item) do
    dec(Result);
end;

function TLMDArray.IndexOf(const Item: TxListItem): Integer;
begin
  Result := 0;
  while (Result < FCount) and (FList[Result] <> Item) do
    Inc(Result);
  if Result = FCount then
    Result := -1;
end;

procedure TLMDArray.Insert(Index: Integer; const Item: TxListItem);
begin
  if (Index < 0) or (Index > FCount) then
    RaiseOutOfBoundsError(Index);
  if FCount = FCapacity then
    Grow;
  if Index < FCount then
    System.Move(FList^[Index], FList^[Index + 1], (FCount - Index) * SizeOf(TxListItem));
    FList[Index] := Item;
  Inc(FCount);
end;

function TLMDArray.Last: TxListItem;
begin
  Result := Get(FCount - 1);
end;

procedure TLMDArray.MoveRange(CurStart, CurEnd, NewStart: integer);
var
  bs: integer;
  P: PChar;
  begin
  if CurStart <> NewStart then
  begin
    CheckRange(CurStart);
    CheckRange(CurEnd);
    CheckRange(NewStart);
    if ((NewStart >= CurStart) and (NewStart <= CurEnd)) then // vAd: shift without overhead diapasone
      RaiseOutOfBoundsError(NewStart);
    if CurStart > NewStart then
    begin
      bs := CurEnd - CurStart + 1;
      GetMem(P, bs * SizeOf(TxListItem));
        System.Move(FList^[CurStart], P^, BS * SizeOf(TxListItem));
        System.Move(FList^[NewStart], FList^[NewStart + BS], (CurStart - NewStart) * SizeOf(TxListItem));
        System.Move(P^, FList^[NewStart], BS * SizeOf(TxListItem));
        FreeMem(P);
      end else
    begin
      bs := CurEnd - CurStart + 1;
      GetMem(P, BS * SizeOf(TxListItem));
        System.Move(FList^[CurStart], P^, BS * SizeOf(TxListItem));
        System.Move(FList^[CurEnd + 1], FList^[CurStart], (NewStart - CurEnd) * SizeOf(TxListItem));
        NewStart := CurStart - 1 + NewStart - CurEnd;
        System.Move(P^, FList^[NewStart], BS * SizeOf(TxListItem));
        FreeMem(P);
      end;
  end;
end;

procedure TLMDArray.Move(CurIndex, NewIndex: Integer);
var
  Item: TxListItem;
begin
  if CurIndex <> NewIndex then
  begin
    if (NewIndex < 0) then
      RaiseOutOfBoundsError(NewIndex);
    if (NewIndex >= FCount) then
      Count := NewIndex + 1;

    Item := Get(CurIndex);

    { OLD CODE:
      //vAd: ??? вызовется .Free для Delete(CurIndex). В ElList для этого есть специальный intDelete. Кто то невнимательно переносил ?
      Delete(CurIndex);
      Insert(NewIndex, Item);
      {}
      //NEW CODE: меньше перемещений памяти:
      if NewIndex < CurIndex then
        // Shift Left
        System.Move(FList[NewIndex],
                    FList[NewIndex+1],
                    (CurIndex-NewIndex) * SizeOf(TxListItem))
      else
        // Shift Right
        System.Move(FList[CurIndex+1],
                    FList[CurIndex],
                    (NewIndex-CurIndex) * SizeOf(TxListItem));
      FList[NewIndex] := Item;
    end;
end;

procedure TLMDArray.Put(Index: Integer; const Item: TxListItem);
begin
  if (Index < 0) then
    RaiseOutOfBoundsError(Index);
  if (Index >= FCount) then
    Count := Index + 1;
  if FList[Index] <> Item then
  begin
    if Assigned(FList[Index]) then
      begin
        TriggerDeleteEvent(FList[Index]);
        if AutoClearObjects then
          try
            TObject(FList[Index]).Free;
          except
            FList[Index] := nil;
          end;
      end;
    FList[Index] := Item;
  end;
end;

function TLMDArray.Remove(const Item: TxListItem): Integer;
begin
  Result := IndexOf(Item);
  if Result <> -1 then
    Delete(Result);
end;

procedure TLMDArray.Pack;
 var I: Integer;
begin
  for I := FCount - 1 downto 0 do
    if Items[I] = nil then
      Delete(I);
end;

procedure TLMDArray.SetCapacity(NewCapacity: Integer);
begin
  if (NewCapacity < FCount)
    or
    (NewCapacity > MaxListSize)
    then
    RaiseOutOfBoundsError(NewCapacity);
  if NewCapacity <> FCapacity then
  begin
    ReallocMem(FList, NewCapacity * SizeOf(TxListItem));
      if NewCapacity > FCapacity then
      FillMemory(@FList[FCapacity], (NewCapacity - FCapacity) * SizeOf(TxListItem), 0);
      FCapacity := NewCapacity;
  end;
end;

procedure TLMDArray.SetCount(NewCount: Integer);
begin
  if (NewCount < 0)
     or
     (NewCount > MaxListSize)
     then
    RaiseOutOfBoundsError(NewCount);
  if NewCount > FCapacity then
    SetCapacity(NewCount);
  if NewCount > FCount then
    FillChar(FList^[FCount], (NewCount - FCount) * SizeOf(TxListItem), 0);
    FCount := NewCount;
end;

procedure QuickSort(const SortList: PPointerList;
   L, R: Integer; SCompare: TLMDArraySortCompare; const Cargo: TxListItem);
var
  I, J, rI, rJ: Integer;
  P, T: TxListItem;
begin
  repeat
    I := L;
    J := R;
    P := SortList[(L + R) shr 1];

    repeat
      rI := SCompare(SortList[I], P, Cargo);
      rJ := SCompare(SortList[J], P, Cargo);

      while rI < 0 do
      begin
        Inc(I);
        rI := SCompare(SortList[I], P, Cargo);
      end;

      while rJ > 0 do
      begin
        Dec(J);
        rJ := SCompare(SortList[J], P, Cargo);
      end;

      if I <= J then
      begin
        if (I <> J) and ((rI <> 0) or (rJ <> 0)) then
        begin
          T := SortList[I];
          SortList[I] := SortList[J];
          SortList[J] := T;
        end;

        Inc(I);
        Dec(J);
      end;
    until I > J;

    if L < J then QuickSort(SortList, L, J, SCompare, Cargo);

    L := I;
  until I >= R;
end;

procedure TLMDArray.Sort(Compare: TLMDArraySortCompare; const Cargo: TxListItem);
begin
  if (FList <> nil) and (Count > 0) then
    QuickSort(FList, 0, Count - 1, Compare, Cargo);
end;

procedure TLMDArray.TriggerDeleteEvent(const Item: TxListItem);
begin
  if (Assigned(FOnDelete)) then
    FOnDelete(Self, Item);
end;

end.
