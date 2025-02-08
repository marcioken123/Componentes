unit ElArray;
{$I lmdcmps.inc}
{###############################################################################

ElArray unit
------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils,
  Windows,
  LMDTypes,
  LMDProcs,
  LMDElConst;

type
  TElArraySortCompare = function(Item1, Item2: TxListItem; Cargo: TxListItem): Integer;

  TElArrayDeleteEvent = procedure(Sender: TObject; Item: TxListItem) of object;

  TElArray = class
  protected
    FList: {$ifdef CLR}TObjectList{$else}PPointerList{$endif};
    FCount: Integer;
    FCapacity: Integer;
    FAutoClearObjects: Boolean;
    FOnDelete: TElArrayDeleteEvent;
    function Get(Index: Integer): TxListItem; virtual;
    procedure Grow; virtual;
    procedure Put(Index: Integer; const Item: TxListItem); virtual;
    procedure SetCapacity(NewCapacity: Integer);
    procedure SetCount(NewCount: Integer);
    procedure TriggerDeleteEvent(const Item: TxListItem); virtual;
    {$ifndef CLR}
    class procedure Error(const Msg: string; Data: Integer);
    {$endif}
  public
    constructor Create;
    destructor Destroy; override;
    procedure CheckRange(Index:Integer);
    function Add(const Item: TxListItem): Integer;
    procedure Clear;
    procedure Assign(AList: TElArray);
    procedure Delete(Index: Integer); virtual;
    procedure Exchange(Index1, Index2: Integer);
    function Expand: TElArray;
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
    procedure Sort(Compare: TElArraySortCompare; const Cargo: TxListItem);
    property Capacity: Integer read FCapacity write SetCapacity default 0;
    property Count: Integer read FCount write SetCount default 0;
    property Items[Index: Integer]: TxListItem read Get write Put; default;
    property List: {$ifdef CLR}TObjectList{$else}PPointerList{$endif} read FList;
    property AutoClearObjects: Boolean read FAutoClearObjects write FAutoClearObjects default False; { Published }
    property OnDelete: TElArrayDeleteEvent read FOnDelete write FOnDelete;
  end;

implementation

type
  EElArrayError = class(Exception);

procedure RaiseOutOfBoundsError(Ind: integer);
begin
  raise EElArrayError.CreateFmt(SLMDListIndexOutOfBounds, [Ind]);
end;

{$ifndef CLR}
class procedure TElArray.Error(const Msg: string; Data: Integer);

  function ReturnAddr: TxListItem;
  asm
    MOV     EAX,[EBP+4]
  end;

begin
  raise EElArrayError.CreateFmt(Msg, [Data])at ReturnAddr;
end;
{$endif}

constructor TElArray.Create;
begin
  inherited;
  FList := nil;
  FCount := 0;
  FCapacity := 0;
  FAutoClearObjects := FALSE;
  FOnDelete := nil;
end;

destructor TElArray.Destroy;
begin
  Clear;
  inherited;
end;

function TElArray.Add(const Item: TxListItem): Integer;
begin
  Result := FCount;
  if Result = FCapacity then Grow;
  FList[Result] := Item;
  Inc(FCount);
end;

procedure TElArray.Assign(AList: TElArray);
begin
  Clear;
  SetCapacity(AList.Capacity);
  SetCount(AList.Count);
  {$ifdef CLR}
    LMDMove(AList.FList, 0, FList, 0, FCount);
  {$else}
    System.Move(AList.FList^[0], FList^[0], FCount);
  {$endif}
end;

procedure TElArray.Clear;
var
  I: integer;
  {$ifndef CLR}
  p: TxListItem;
  {$endif}
begin
  if Assigned(FOnDelete) then
    for i := 0 to Count - 1 do
      if FList[i] <> nil then
        TriggerDeleteEvent(FList[i]);
  if AutoClearObjects then
    for i := 0 to Count - 1 do
    begin
      {$ifdef CLR}
        if Assigned(FList[i]) then
          try
            FList[i].Free;
          except
            FList[i] := nil;
          end;
      {$else}
      p := Get(i);
      try
        if (P <> nil) and (TObject(P) is TObject) then TObject(P).Free;
      except
      end;
      {$endif}
    end;
  SetCount(0);
  SetCapacity(0);
end;

procedure TElArray.CheckRange(Index:Integer);
begin
    if (Index < 0) or (Index >= FCount) then
      RaiseOutOfBoundsError(Index);
end;

procedure TElArray.Delete(Index: Integer);
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
    {$ifdef CLR}
      SysArrayMove( FList, Index+1, Index, FCount-Index )
    {$else}
      System.Move(FList^[Index + 1], FList^[Index], (FCount - Index) * SizeOf(TxListItem))
    {$endif}
  else
    FList[Index] := nil;

  if FCount < (FCapacity div 2) then
    SetCapacity(FCapacity div 2);
end;

procedure TElArray.Exchange(Index1, Index2: Integer);
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

function TElArray.Expand: TElArray;
begin
  if FCount = FCapacity then
    Grow;
  Result := Self;
end;

function TElArray.First: TxListItem;
begin
  CheckRange(0);
  Result := Get(0);
end;

function TElArray.Get(Index: Integer): TxListItem;
begin
  if (Index < 0) then RaiseOutOfBoundsError(Index);
  if (Index >= FCount) then
    Result := nil
  else
    Result := FList[Index];
end;

procedure TElArray.Grow;
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

function TElArray.IndexOfFrom(StartIndex: integer; const Item: TxListItem): Integer;
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

function TElArray.IndexOfBack(StartIndex: integer; const Item: TxListItem): Integer;
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

function TElArray.IndexOf(const Item: TxListItem): Integer;
begin
  Result := 0;
  while (Result < FCount) and (FList[Result] <> Item) do
    Inc(Result);
  if Result = FCount then
    Result := -1;
end;

procedure TElArray.Insert(Index: Integer; const Item: TxListItem);
begin
  if (Index < 0) or (Index > FCount) then
    RaiseOutOfBoundsError(Index);
  if FCount = FCapacity then
    Grow;
  if Index < FCount then
    {$ifdef CLR}
      SysArrayMove( FList, Index, Index+1, FCount-Index );
    {$else}
      System.Move(FList^[Index], FList^[Index + 1], (FCount - Index) * SizeOf(TxListItem));
    {$endif}
  FList[Index] := Item;
  Inc(FCount);
end;

function TElArray.Last: TxListItem;
begin
  Result := Get(FCount - 1);
end;

procedure TElArray.MoveRange(CurStart, CurEnd, NewStart: integer);
var
  bs: integer;
  {$ifdef CLR}
  Buff:TObjectList;
  {$else}
  P: PChar;
  {$endif}
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
      {$ifdef CLR}
        SetLength(Buff, bs);
        { System.Array: C#:
          public static void Copy(
            Array sourceArray,
            int sourceIndex,
            Array destinationArray,
            int destinationIndex,
            int length
         );}
        System.Array.Copy( FList, CurStart, Buff, 0, bs );
        System.Array.Copy( FList, NewStart, FList, NewStart + BS, CurStart - NewStart );
        System.Array.Copy( Buff,  0, FList, NewStart, bs);
        //SetLength(Buff, 0);
      {$else}
        GetMem(P, bs * SizeOf(TxListItem));
        System.Move(FList^[CurStart], P^, BS * SizeOf(TxListItem));
        System.Move(FList^[NewStart], FList^[NewStart + BS], (CurStart - NewStart) * SizeOf(TxListItem));
        System.Move(P^, FList^[NewStart], BS * SizeOf(TxListItem));
        FreeMem(P);
      {$endif}
    end else
    begin
      bs := CurEnd - CurStart + 1;
      {$ifdef CLR}
        SetLength(Buff, bs);
        System.Array.Copy( FList, CurStart, Buff, 0, bs );
        System.Array.Copy( FList, CurEnd+1, FList, CurStart, NewStart - CurEnd );
        NewStart := CurStart - 1 + NewStart - CurEnd;
        System.Array.Copy( Buff,  0, FList, NewStart, bs);
        //SetLength(Buff, 0);
      {$else}
        GetMem(P, BS * SizeOf(TxListItem));
        System.Move(FList^[CurStart], P^, BS * SizeOf(TxListItem));
        System.Move(FList^[CurEnd + 1], FList^[CurStart], (NewStart - CurEnd) * SizeOf(TxListItem));
        NewStart := CurStart - 1 + NewStart - CurEnd;
        System.Move(P^, FList^[NewStart], BS * SizeOf(TxListItem));
        FreeMem(P);
      {$endif}
    end;
  end;
end;

procedure TElArray.Move(CurIndex, NewIndex: Integer);
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

    {$ifdef CLR}
      if NewIndex<CurIndex then
        // Shift Left
        SysArrayMove( FList, NewIndex, NewIndex+1, CurIndex-NewIndex)
      else
        // Shift Right
        SysArrayMove( FList, CurIndex+1, CurIndex, NewIndex-CurIndex);
      FList[NewIndex] := Item;
    {$else}
      { OLD CODE:
      //vAd: ??? вызоветс€ .Free дл€ Delete(CurIndex). ¬ ElList дл€ этого есть специальный intDelete.  то то невнимательно переносил ?
      Delete(CurIndex);
      Insert(NewIndex, Item);
      {}
      //NEW CODE: меньше перемещений пам€ти:
      if NewIndex<CurIndex then
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
    {$endif}
  end;
end;

procedure TElArray.Put(Index: Integer; const Item: TxListItem);
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

function TElArray.Remove(const Item: TxListItem): Integer;
begin
  Result := IndexOf(Item);
  if Result <> -1 then
    Delete(Result);
end;

procedure TElArray.Pack;
 var I: Integer;
begin
  for I := FCount - 1 downto 0 do
    if Items[I] = nil then
      Delete(I);
end;

procedure TElArray.SetCapacity(NewCapacity: Integer);
begin
  if (NewCapacity < FCount)
    {$ifndef CLR}
    or
    (NewCapacity > MaxListSize)
    {$endif}
  then
    RaiseOutOfBoundsError(NewCapacity);
  if NewCapacity <> FCapacity then
  begin
    {$ifdef CLR}
      SetLength( FList, NewCapacity);
    {$else}
      ReallocMem(FList, NewCapacity * SizeOf(TxListItem));
      if NewCapacity > FCapacity then
      FillMemory(@FList[FCapacity], (NewCapacity - FCapacity) * SizeOf(TxListItem), 0);
      {$endif CLR}
    FCapacity := NewCapacity;
  end;
end;

procedure TElArray.SetCount(NewCount: Integer);
begin
  if (NewCount < 0)
     {$ifndef CLR}
     or
     (NewCount > MaxListSize)
     {$endif}
  then
    RaiseOutOfBoundsError(NewCount);
  if NewCount > FCapacity then
    SetCapacity(NewCount);
  if NewCount > FCount then
    {$ifdef CLR}//??? а надо ли ?
      System.Array.Clear( FList, FCount, NewCount - FCount );
    {$else}
      FillChar(FList^[FCount], (NewCount - FCount) * SizeOf(TxListItem), 0);
    {$endif}
  FCount := NewCount;
end;

procedure QuickSort(const SortList: {$ifdef CLR}TObjectList{$else}PPointerList{$endif};
   L, R: Integer; SCompare: TElArraySortCompare; const Cargo: TxListItem);
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

procedure TElArray.Sort(Compare: TElArraySortCompare; const Cargo: TxListItem);
begin
  if (FList <> nil) and (Count > 0) then
    QuickSort(FList, 0, Count - 1, Compare, Cargo);
end;

procedure TElArray.TriggerDeleteEvent(const Item: TxListItem);
begin
  if (Assigned(FOnDelete)) then
    FOnDelete(Self, Item);
end;

end.
