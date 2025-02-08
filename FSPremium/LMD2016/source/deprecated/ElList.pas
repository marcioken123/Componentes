unit ElList;
{###############################################################################

ElList unit
-----------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils,
  Classes,
  Math,
  LMDDebugUnit,
  LMDElConst,
  LMDProcs,
  ElVCLUtils, // FreeAndNil, ElMemoryManager
  LMDTypes;

const
  AlignMem    =   $500; // Align at 1280 items

type
  TElListSortCompare = function(Item1,
                                Item2: TxListItem;
                                Cargo: TxListItem): Integer;

  TElListSortCompareEx = function(Item1,
                                  Item2: TxListItem;
                                  Cargo: TxListItem): Integer of object;

  TElListDeleteEvent = procedure (Sender: TObject; var Item: TxListItem) of object;

  {$ifdef CLR}
    TElPointerList = array of TxListItem;
  {$else}
    PElPointerList = ^TElPointerList;
    TElPointerList = array[0..MaxListSize - 1] of TxListItem;
  {$endif}

  {:
  }
  TElList = class (TPersistent)
  protected
    //FDestroyed: Boolean;
    FAutoClearObjects: Boolean;
    FCapacity: Integer;
    FCount: Integer;
    FList: {$ifdef CLR}TElPointerList{$else}PElPointerList{$endif};
    FOnDelete: TElListDeleteEvent;
    {$ifndef CLR}
    class procedure Error(const Msg: string; Data: Integer);
    {$endif}
    function Get(Index: Integer): TxListItem; virtual;
    procedure Grow; virtual;
    procedure Put(Index: Integer; const Item: TxListItem); virtual;
    procedure SetCapacity(NewCapacity: Integer);
    procedure SetCount(NewCount: Integer);
    procedure IntDelete(Index: Integer);
    procedure TriggerDeleteEvent(Item: TxListItem; Index: Integer); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure CheckRange(Index: Integer);
    function FastGet(Index: Integer): TxListItem;
    function Add(const Item: TxListItem): Integer;
    procedure Assign(Source : TPersistent); override;
    procedure Clear; virtual;
    procedure Delete(Index: Integer); virtual;
    procedure DeleteRange(StartIndex, EndIndex: Integer); virtual;
    procedure Exchange(Index1, Index2: Integer);
    function Expand: TElList;
    function First: TxListItem;
    function IndexOf(const Item: TxListItem): Integer;
    function IndexOfBack(StartIndex: integer; const Item: TxListItem): Integer;
    function IndexOfFrom(StartIndex: integer; const Item: TxListItem): Integer;
    procedure Insert(Index: Integer; const Item: TxListItem);
    function Last: TxListItem;
    procedure Move(CurIndex, NewIndex: Integer);
    procedure MoveRange(CurStart, CurEnd, NewStart: integer);
    procedure Pack;
    function Remove(const Item: TxListItem): Integer;
    procedure Sort(Compare: TElListSortCompare; const Cargo: TxListItem);
    procedure SortC(Compare: TElListSortCompareEx; const Cargo: TxListItem);
    property AutoClearObjects: Boolean read FAutoClearObjects write
        FAutoClearObjects;
    property Capacity: Integer read FCapacity write SetCapacity;
    property Count: Integer read FCount write SetCount;
    property Items[Index: Integer]: TxListItem read Get write Put; default;
    {$ifdef CLR}
      property List: TElPointerList read FList;
    {$else}
      property List: PElPointerList read FList;
    {$endif}
    property OnDelete: TElListDeleteEvent read FOnDelete write FOnDelete;
  end;

implementation

type
  EElListError = class (Exception)
  end;

  {$ifdef CLR}
  PElPointerList = TElPointerList;
  {$endif}

procedure RaiseOutOfBoundsError(Ind: integer);
begin
  raise EelListError.CreateFmt(SLMDListIndexOutOfBounds, [Ind]);
end;

procedure QuickSortC(SortList: PElPointerList; L, R: Integer;
  SCompare: TelListSortCompareEx; const Cargo: TxListItem);
var
  I, J : Integer;
  P, T : TxListItem;
begin
  repeat
    I := L;
    J := R;
    //vAd: old: P := SortList^[(L + R) shr 1];
    // remove all ^
    P := SortList[(L + R) shr 1];
    repeat
      while SCompare(SortList[I], P, Cargo) < 0 do
        Inc(I);
      while SCompare(SortList[J], P, Cargo) > 0 do
        Dec(J);
      if I <= J then
      begin
        if I <> J then
        begin
          T := SortList[I];
          SortList[I] := SortList[J];
          SortList[J] := T;
        end;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSortC(SortList, L, J, SCompare, Cargo);
    L := I;
  until I >= R;
end;

procedure QuickSort(SortList: PElPointerList; L, R: Integer;
  SCompare: TelListSortCompare; const Cargo: TxListItem);
var
  I, J : Integer;
  P, T : TxListItem;
begin
  repeat
    I := L;
    J := R;
    P := SortList[(L + R) shr 1];

    repeat

      // rI := SCompare(SortList^[I], P, Cargo);
      while SCompare(SortList[I], P, Cargo) < 0 do
        Inc(I);

      // rJ := SCompare(SortList^[J], P, Cargo);
      while SCompare(SortList[J], P, Cargo) > 0 do
        Dec(J);

      if I <= J then
      begin

        if I <> J then
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

{:
}
{:
}
{
*********************************** TElList ************************************
}
constructor TElList.Create;
begin
  inherited;
  FList := nil;
  FCount := 0;
  FCapacity := 0;
  FAutoClearObjects := FALSE;
  FOnDelete := nil;
  {$IFDEF LMD_DEBUGMESSAGES}
  LMDDebug('new TElList.Create:  '+IntToStr({$IFDEF CLR}self.GetHashCode{$ELSE}Integer(Self){$ENDIF}));
  {$ENDIF}
end;

destructor TElList.Destroy;
begin
  {if FDestroyed then
    //exit;
    FDestroyed := False;
  FDestroyed := True;{}
  {$IFDEF LMD_DEBUGMESSAGES}
  LMDDebug('TElList.Destoy run:  '+IntToStr({$IFDEF CLR}self.GetHashCode{$ELSE}Integer(Self){$ENDIF}));
  {$ENDIF}
  Clear;
  inherited;
  {$IFDEF LMD_DEBUGMESSAGES}
  LMDDebug('TElList.Destoy end:  '+IntToStr({$IFDEF CLR}self.GetHashCode{$ELSE}Integer(Self){$ENDIF}));
  {$ENDIF}
end;

function TElList.Add(const Item: TxListItem): Integer;
begin
  if FCount = FCapacity then
  begin
    Inc(FCapacity, Min(Count * 2 + 1, AlignMem));
    {$ifdef CLR}
      SetLength(FList, FCapacity);
    {$else}
      ReAllocMem(FList, FCapacity * SizeOf(TxListItem));
    {$endif}
  end;
  FList[FCount] := Item;
  Result := FCount;
  Inc(FCount);
end;

procedure TElList.Assign(Source : TPersistent);
begin
  if Source is TElList then
  begin
    Clear;
    SetCapacity(TElList(Source).Capacity);
    SetCount(TElList(Source).Count);
    if FCount > 0 then
       {$ifdef CLR}
         System.Array.Copy( TElList(Source).FList, FList, FCount );
       {$else}
         System.Move(TElList(Source).FList^[0], FList^[0], FCount * sizeof(TxListItem));
       {$endif}
  end else inherited;
end;

procedure TElList.Clear;
var
  I: Integer;
  {$IFDEF LMD_DEBUGMESSAGES}
  C, ph: Integer;
  {$ifndef CLR}
  ptr: pointer;
  {$else}
  ptr: TObject;
  {$endif}
  {$ENDIF}
  {$ifndef CLR}
  P: TxListItem;
  {$endif}
begin
  {$IFDEF LMD_DEBUGMESSAGES}
  LMDDebug('TElList.Clear run:  '+IntToStr({$IFDEF CLR}self.GetHashCode{$ELSE}Integer(Self){$ENDIF})+', Count='+IntToStr(FCount));
  ptr := nil;
  {$ENDIF}

  if (FCount>0) and Assigned(FList) then
  begin
    {$IFDEF LMD_DEBUGMESSAGES}
    C := FCount;
    ph :=0;
    {$ENDIF}
    for I := Count - 1 downto 0 do
    try
      {$IFDEF LMD_DEBUGMESSAGES}
      ph := 1;
      try
      ph := 2;
       ptr := FList[I];
      except
        ph := 3;
        ptr := nil;
        //LMDDebug('ERROR: TriggerDeleteEvent Index Access:  '+IntToStr(DWORD(Self))+', Index='+IntToStr(I)+ ', Count='+IntToStr(C));
      end;
      ph := 4;
      //LMDDebug('Before TriggerDeleteEvent :  '+IntToStr(DWORD(Self))+', Item='+IntToStr(DWORD(ptr))+', Index='+IntToStr(I)+ ', Count='+IntToStr(C));
      LMDDebug('Before TriggerDeleteEvent :  '+IntToStr({$IFDEF CLR}self.GetHashCode{$ELSE}Integer(Self){$ENDIF}));
      ph := 5;
      ptr := FList[I];
      ph := 6; // ERROR Access to Self
      {$ENDIF IFDEF LMD_DEBUGMESSAGES}
      TriggerDeleteEvent(FList[I], I);
    except
      {$IFDEF LMD_DEBUGMESSAGES}
      LMDDebug('ERROR: TElList.Clear:  '+IntToStr({$IFDEF CLR}self.GetHashCode{$ELSE}Integer(Self){$ENDIF})+', Item='+IntToStr(Integer(ptr))+', Index='+IntToStr(I)+ ', Count='+IntToStr(C)+
        ', phase='+IntToStr(ph));
      //raise;
      {$ENDIF}
    end;
    if AutoClearObjects then
      for I := FCount - 1 downto 0 do
      begin
        {$ifdef CLR}
          if Assigned(FList[i]) then
            try
              FList[i].Free;
            except
              FList[i] := nil;
            end;
        {$else}
          p := Get(i); // <=>: p := FList[Index];
          try
            if (P <> nil) and (TObject(P) is TObject) then
            begin
              FList[i] := nil;
              TObject(P).Free;
            end;
          except
          end;
        {$endif}
      end;
  end;

  // Don't call two routines for this. Just assign
  FCount := 0;
  FCapacity := 0;
  if Assigned(FList) then
  {$ifdef CLR}
    SetLength(FList, 0);
  {$else}
    ReallocMem(FList, 0);
  {$endif}

  {$IFDEF LMD_DEBUGMESSAGES}
  LMDDebug('TElList.Clear end:  '+IntToStr({$IFDEF CLR}self.GetHashCode{$ELSE}Integer(Self){$ENDIF}));
  {$ENDIF}
end;

procedure TElList.IntDelete(Index: Integer);
begin
  CheckRange(Index);
  Dec(FCount);
  if Index < FCount then
    {$ifdef CLR}
      SysArrayMove( FList, Index+1, Index, FCount-Index );
    {$else}
      System.Move(FList[Index + 1],
                  FList[Index],
                  (FCount - Index) * SizeOf(TxListItem));
    {$endif}
end;

procedure TElList.DeleteRange(StartIndex, EndIndex: Integer);
var i : integer;
begin
  CheckRange(StartIndex);
  CheckRange(EndIndex);
  if (EndIndex < StartIndex) then
    RaiseOutOfBoundsError(EndIndex);
  for i := EndIndex downto StartIndex do
    TriggerDeleteEvent(FList[I], I);
  if (FCount > EndIndex + 1) then
    {$ifdef CLR}
      SysArrayMove( FList, EndIndex + 1, StartIndex, (FCount - (EndIndex - StartIndex + 1)) );
    {$else}
      System.Move(FList[EndIndex + 1],
                  FList[StartIndex],
                  (FCount - (EndIndex - StartIndex + 1)) * SizeOf(TxListItem));
    {$endif}
  Dec(FCount, EndIndex - StartIndex + 1);
  if FCount < FCapacity shr 1 then
  begin
    FCapacity := FCapacity shr 1;
    {$ifdef CLR}
      SetLength(FList, FCapacity);
    {$else}
      ReAllocMem(FList, FCapacity * SizeOf(TxListItem));
    {$endif}
  end;
end;

procedure TElList.Delete(Index: Integer);
begin
  CheckRange(Index);

  if Assigned(FList[Index]) then
    begin
      TriggerDeleteEvent(FList[Index], Index);
      if AutoClearObjects then
        {$ifdef CLR}
        try
          TObject(FList[Index]).Free;
        except
          FList[Index] := nil;
        end;
        {$else}
        FreeAndNil(TObject(FList[Index]));
        {$endif}
    end;

  Dec(FCount);
  if FCount > Index then
    {$ifdef CLR}
      SysArrayMove( FList, Index + 1, Index, FCount - Index );
    {$else}
      System.Move(FList[Index + 1],
                  FList[Index],
                  (FCount - Index) * SizeOf(TxListItem));
    {$endif}
  if FCount < FCapacity shr 1 Then
  begin
    FCapacity := FCapacity shr 1;
    {$ifdef CLR}
      SetLength(FList, FCapacity);
    {$else}
      ReAllocMem(FList, FCapacity * SizeOf(TxListItem));
    {$endif}
  end;
end;

{$ifndef CLR}
class procedure TElList.Error(const Msg: string; Data: Integer);

  function ReturnAddr: TxListItem;
  asm
    MOV     EAX,[EBP+4]
  end;

begin
  raise EElListError.CreateFmt(Msg, [Data])at ReturnAddr;
end;
{$endif}

procedure TElList.CheckRange(Index: Integer);
begin
  if (Index < 0) or (Index >= FCount) then
    RaiseOutOfBoundsError(Index);
end;

procedure TElList.Exchange(Index1, Index2: Integer);
var
  Item: TxListItem;
begin
  CheckRange(Index1);
  CheckRange(Index2);

  Item := FList[Index1];
  FList[Index1] := FList[Index2];
  FList[Index2] := Item;
end;

function TElList.Expand: TElList;
begin
  if FCount = FCapacity then
  begin
    Inc(FCapacity, Min(Count * 2 + 1, AlignMem));
    {$ifdef CLR}
      SetLength( FList, FCapacity );
    {$else}
      ReallocMem(FList, FCapacity * SizeOf(TxListItem));
    {$endif}
  end;
  Result := Self;
end;

function TElList.First: TxListItem;
begin
  CheckRange(0);

  Result := FList[0];
end;

function TElList.FastGet(Index: Integer): TxListItem;
begin
  Result := Get(Index);
//  {$IFOPT R+}
//  if (Index < 0) or (Index >= FCount) then
//    RaiseOutOfBoundsError(Index);
//  {$ENDIF}
//  Result := FList[Index];
end;

function TElList.Get(Index: Integer): TxListItem;
begin
  //CheckRange(Index);
  if (Index < 0) or (Index >= FCount) then
    RaiseOutOfBoundsError(Index);

  Result := FList[Index];
end;

procedure TElList.Grow;
begin
  Inc(FCapacity, Min(Count * 2 + 1, AlignMem));
  {$ifdef CLR}
    SetLength( FLIst, FCapacity );
  {$else}
    ReAllocMem(FList, FCapacity * SizeOf(TxListItem));
  {$endif}
end;

function TElList.IndexOf(const Item: TxListItem): Integer;
{$ifdef CLR}
begin
  Result := 0;
  while (Result < FCount) and (FList[Result] <> Item) do
    Inc(Result);
  if Result = FCount then
    Result := -1;
end;
{$else}
// snippet of previous variant of code
//  while (Result < FCount) and (FList[Result] <> Item) do
//    Inc(Result);
//  if Result = FCount then
//    Result := -1;
  asm
//   preserve the EDI, ESI, ESP, EBP, and EBX registers, but
//       can freely modify the EAX, ECX, and EDX registers.
//       SCAS{B|W|D}    do{ if {AL|AX|EAX} = (!=) ) *(edi++) break; while (ecx--);
//       Адрес исходного массива задается в регистре ESI, а результирующего - в регистре EDI.
//       Количество элементов массива задается в регистре ECX.

//       Спрячем регистры
      PUSH    EDI
//       Загружаем данные для поиска
      MOV     EAX,self
      MOV     ECX,[EAX].FCount    // Длина

//       Проверим есть ли что искать.
      TEST    ECX,ECX
      JE      @@fail

      MOV     EDI,[EAX].FList    // Указатель на массив данных
      MOV     EAX,Item           // Элемент для сравнения
      MOV     EDX,EDI            // Пригодится на выходе

//       Ищем
      REPNE   SCASD
      JNE     @@fail

//       Нашли
      MOV     EAX,EDI            // EDI points of char after match
      SUB     EAX,EDX            // the difference is the correct index
      SHR     EAX, 2             // Разделим на 4 (SizeOf(Integer) получим порядковый номер
      JMP     @@exit

  @@fail:
      XOR     EAX,EAX   // Возвращаем -1
  @@exit:
      DEC     EAX       // Вернуть надо на 1 меньше
//       Вернем регистры
      POP     EDI
  end;
{$endif}

function TElList.IndexOfBack(StartIndex: integer; const Item: TxListItem): Integer;
begin
  CheckRange(StartIndex);

  Result := StartIndex;
  while (Result >= 0) and (FList[Result] <> Item) do
    dec(Result);
end;

function TElList.IndexOfFrom(StartIndex: integer; const Item: TxListItem): Integer;
begin
  CheckRange(StartIndex);

  Result := StartIndex;
  while (Result < FCount) and (FList[Result] <> Item) do
    Inc(Result);
  if Result = FCount then
    Result := -1;
end;

procedure TElList.Insert(Index: Integer; const Item: TxListItem);
begin
  if (Index < 0) or (Index > FCount) then
    RaiseOutOfBoundsError(Index);

  if FCount = FCapacity then
  Begin
    Inc(FCapacity, Min(Count * 2 + 1, AlignMem));
    {$ifdef CLR}
      SetLength( FList, FCapacity );
    {$else}
      ReAllocMem(FList, FCapacity * SizeOf(TxListItem));
    {$endif}
  End;
  // if Index < FCount then == Useless. See first line.
  {$ifdef CLR}
    SysArrayMove( FList, Index, Index+1, FCount-Index);
  {$else}
    System.Move(FList^[Index],
                FList^[Index + 1],
                (FCount - Index) * SizeOf(TxListItem));
  {$endif}
  FList[Index] := Item;
  Inc(FCount);
end;

function TElList.Last: TxListItem;
begin
  if FCount = 0 then
    Result := nil
  else
    Result := FList[FCount-1];
end;

procedure TElList.Move(CurIndex, NewIndex: Integer);
var
  Item: TxListItem;
begin
  if CurIndex <> NewIndex then
  begin
    CheckRange(CurIndex);
    CheckRange(NewIndex);

    Item := FList[CurIndex];

    {$ifdef CLR}
      if NewIndex<CurIndex then
        // Shift Left
        SysArrayMove( FList, NewIndex, NewIndex+1, CurIndex-NewIndex)
      else
        // Shift Right
        SysArrayMove( FList, CurIndex+1, CurIndex, NewIndex-CurIndex);
      FList[NewIndex] := Item;
    {$else}
      {//OLD CODE:
      IntDelete(CurIndex);
      Insert(NewIndex, Item);
      {}
      //NEW CODE: fewer of memory relocations
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

procedure TElList.MoveRange(CurStart, CurEnd, NewStart: integer);
var
  bs: Integer;
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
        System.Move(FList^[NewStart], FList^[NewStart + BS], (CurStart -
            NewStart) * SizeOf(TxListItem));
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
        System.Move(FList^[CurEnd + 1], FList^[CurStart], (NewStart - CurEnd) *
            SizeOf(TxListItem));
        NewStart := CurStart - 1 + NewStart - CurEnd;
        System.Move(P^, FList^[NewStart], BS * SizeOf(TxListItem));
        FreeMem(P);
      {$endif}
    end;
  end;
end;

procedure TElList.Pack;
var
  I: Integer;
begin
  for I := FCount - 1 downto 0 do
    if Items[I] = nil then
      Delete(I);
end;

procedure TElList.Put(Index: Integer; const Item: TxListItem);
begin
  CheckRange(Index);

  if Assigned(FList[Index]) then
    begin
      TriggerDeleteEvent(FList[Index], Index);
      if AutoClearObjects then
        {$ifdef CLR}
        try
         TObject(FList[Index]).Free;
        except
          FList[Index] := nil;
        end;
        {$else}
        FreeAndNil(TObject(FList[Index]));
        {$endif}
    end;

  FList[Index] := Item;
end;

function TElList.Remove(const Item: TxListItem): Integer;
begin
  Result := IndexOf(Item);
  // changed by chmv. if Result <> -1 then
  if Result >= 0 then
  begin
    TriggerDeleteEvent(FList[Result], Result);
    Dec(FCount);
    // if Index < FCount then == Useless. See above.
    {$ifdef CLR}
      SysArrayMove( FList, Result+1, Result, FCount - Result);
    {$else}
      System.Move(FList^[Result + 1],
                  FList^[Result],
                  (FCount - Result) * SizeOf(TxListItem));
    {$endif}
    if FCount < FCapacity shr 1 then
    begin
      FCapacity := FCapacity shr 1;
      {$ifdef CLR}
        SetLength( FList, FCapacity );
      {$else}
        ReAllocMem(FList, FCapacity * SizeOf(TxListItem));
      {$endif}
    end;
  end;
end;

procedure TElList.SetCapacity(NewCapacity: Integer);
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
      SetLength( FList, NewCapacity );
    {$else}
      ReallocMem(FList, NewCapacity * SizeOf(TxListItem));
    {$endif}
    FCapacity := NewCapacity;
  end;
end;

procedure TElList.SetCount(NewCount: Integer);
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
    {$ifdef CLR}
      System.Array.Clear( FList, FCount, NewCount - FCount );
    {$else}
      FillChar(FList^[FCount], (NewCount - FCount) * SizeOf(TxListItem), 0);
    {$endif}
  FCount := NewCount;
end;

procedure TElList.Sort(Compare: TElListSortCompare; const Cargo: TxListItem);
begin
  if {$ifndef CLR}
     (FList <> nil)
     and
     {$endif}
     (Count > 0)
  then
    QuickSort(FList, 0, Count - 1, Compare, Cargo);
end;

procedure TElList.SortC(Compare: TElListSortCompareEx; const Cargo: TxListItem);
begin
  if {$ifndef CLR}
     (FList <> nil)
     and
     {$endif}
     (Count > 0)
  then
    QuickSortC(FList, 0, Count - 1, Compare, Cargo);
end;

procedure TElList.TriggerDeleteEvent(Item: TxListItem; Index: Integer);

  { Triggers the OnDelete event. This is a virtual method (descendants of this
      component can override it). }

 {$IFDEF LMD_DEBUGMESSAGES}
 var
   cn, sit: string;
 {$ENDIF}

begin
  {$IFDEF LMD_DEBUGMESSAGES}
  cn := '-';
  sit := '-';
  LMDDebug('TElList.TriggerDeleteEvent');
  {$ENDIF}

  try

  if Assigned(FOnDelete) and Assigned(Item) then
  begin

    {$IFDEF LMD_DEBUGMESSAGES}
// EK: AV if Item is pointer to record (not object)    
//    try
//      cn := TObject(Item).ClassName;
//    except
//      cn := '???';
//    end;
//    sit := ' '+IntToStr({$IFDEF CLR}self.GetHashCode{$ELSE}Integer(Self){$ENDIF})+' Item=' + IntToStr(Integer(Item)) + ', Index = '+IntToStr(Index);

//    LMDDebug('TElList.TriggerDeleteEvent:' + sit +
//      ', ClassName: '+cn );
    {$ENDIF IFDEF LMD_DEBUGMESSAGES}

    FOnDelete(Self, Item);
    if Item = nil then
      FList[Index] := nil;
  end

  except
    on e:Exception{EInvalidPointer} do
    begin
      try
        if (Item = nil)and(Index>=0)and(Index<FCount)and(FList<>nil) then
          FList[Index] := nil;
      except
      end;
      {$IFDEF LMD_DEBUGMESSAGES}
      LMDDebug('ERROR: TElList.TriggerDeleteEvent:' + sit + ', ClassName: '+cn );
      //raise;
      {$ENDIF}
    end;
  end;

end;

end.
