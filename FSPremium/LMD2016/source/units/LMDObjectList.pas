unit LMDObjectList;

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

LMDObjectList unit ()
---------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils,
  Classes,
  Math,
  LMDTypes,
  LMDProcs,
  LMDRTLConst;

const
  AlignMem    =   $500; // Align at 1280 items

type
  TLMDListSortCompare = function(Item1,
                                Item2: TxListItem;
                                Cargo: TxListItem): Integer;

  TLMDListSortCompareEx = function(Item1,
                                  Item2: TxListItem;
                                  Cargo: TxListItem): Integer of object;

  TLMDListDeleteEvent = procedure (Sender: TObject; var Item: TxListItem) of object;

  TLMDObjectList = class (TPersistent)
  protected
    FAutoClearObjects: Boolean;
    FCapacity: Integer;
    FCount: Integer;
    FList: PPointerList;
    FOnDelete: TLMDListDeleteEvent;
    class procedure Error(const Msg: string; Data: Integer);
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
    function AddAndCheckDuplicates(const Item: TxListItem): Integer;
    procedure Assign(Source : TPersistent); override;
    procedure Clear; virtual;
    procedure Delete(Index: Integer); virtual;
    procedure DeleteRange(StartIndex, EndIndex: Integer); virtual;
    procedure Exchange(Index1, Index2: Integer);
    function Expand: TLMDObjectList;
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
    procedure Sort(Compare: TLMDListSortCompare; const Cargo: TxListItem);
    procedure SortC(Compare: TLMDListSortCompareEx; const Cargo: TxListItem);
    property AutoClearObjects: Boolean read FAutoClearObjects write
        FAutoClearObjects;
    property Capacity: Integer read FCapacity write SetCapacity;
    property Count: Integer read FCount write SetCount;
    property Items[Index: Integer]: TxListItem read Get write Put; default;
    property List: PPointerList read FList;
    property OnDelete: TLMDListDeleteEvent read FOnDelete write FOnDelete;
  end;

  TLMDInterfacedObjectList = class(TLMDObjectList, IInterface)
  private
    FOwnerInterface: IInterface;
  protected
    { IInterface }
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    procedure AfterConstruction; override;
  end;

implementation

type
  ELMDListError = class (Exception)
  end;

procedure RaiseOutOfBoundsError(Ind: integer);
begin
  raise ELMDListError.CreateFmt(SLMDListIndexOutOfBounds, [Ind]);
end;

procedure QuickSortC(SortList: PPointerList;
                     L, R: Integer; SCompare: TLMDListSortCompareEx; const Cargo: TxListItem);
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

procedure QuickSort(SortList: PPointerList;
                    L, R: Integer; SCompare: TLMDListSortCompare; const Cargo: TxListItem);
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

{
*********************************** TElList ************************************
}
constructor TLMDObjectList.Create;
begin
  inherited;
  FList := nil;
  FCount := 0;
  FCapacity := 0;
  FAutoClearObjects := FALSE;
  FOnDelete := nil;
end;

destructor TLMDObjectList.Destroy;
begin
  {if FDestroyed then
    //exit;
    FDestroyed := False;
  FDestroyed := True;{}
  Clear;
  inherited;
end;

function TLMDObjectList.Add(const Item: TxListItem): Integer;
begin
  if FCount = FCapacity then
  begin
    Inc(FCapacity, Min(Count * 2 + 1, AlignMem));
    ReAllocMem(FList, FCapacity * SizeOf(TxListItem));
  end;
  FList[FCount] := Item;
  Result := FCount;
  Inc(FCount);
end;

function TLMDObjectList.AddAndCheckDuplicates(const Item: TxListItem): Integer;
begin
  Result := IndexOf(Item);
  if Result < 0 then
    Result := Add(Item);
end;

procedure TLMDObjectList.Assign(Source : TPersistent);
begin
  if Source is TLMDObjectList then
  begin
    Clear;
    SetCapacity(TLMDObjectList(Source).Capacity);
    SetCount(TLMDObjectList(Source).Count);
    if FCount > 0 then
       System.Move(TLMDObjectList(Source).FList^[0], FList^[0], FCount * sizeof(TxListItem));
       end else inherited;
end;

procedure TLMDObjectList.Clear;
var
  I: Integer;
  P: TxListItem;
  begin
    if (FCount>0) and Assigned(FList) then
  begin
    for I := Count - 1 downto 0 do
    try
      TriggerDeleteEvent(FList[I], I);
    except
      raise;
    end;
    if AutoClearObjects then
      for I := FCount - 1 downto 0 do
      begin
        p := Get(i); // <=>: p := FList[Index];
          try
            if (P <> nil) and (TObject(P) is TObject) then
            begin
              FList[i] := nil;
              TObject(P).Free;
            end;
          except

          end;
        end;
  end;

  // Don't call two routines for this. Just assign
  FCount := 0;
  FCapacity := 0;
  if Assigned(FList) then
  ReallocMem(FList, 0);
  end;

procedure TLMDObjectList.IntDelete(Index: Integer);
begin
  CheckRange(Index);
  Dec(FCount);
  if Index < FCount then
    System.Move(FList[Index + 1],
                  FList[Index],
                  (FCount - Index) * SizeOf(TxListItem));
    end;

procedure TLMDObjectList.DeleteRange(StartIndex, EndIndex: Integer);
var i : integer;
begin
  CheckRange(StartIndex);
  CheckRange(EndIndex);
  if (EndIndex < StartIndex) then
    RaiseOutOfBoundsError(EndIndex);
  for i := EndIndex downto StartIndex do
    TriggerDeleteEvent(FList[I], I);
  if (FCount > EndIndex + 1) then
    System.Move(FList[EndIndex + 1],
                  FList[StartIndex],
                  (FCount - (EndIndex - StartIndex + 1)) * SizeOf(TxListItem));
    Dec(FCount, EndIndex - StartIndex + 1);
  if FCount < FCapacity shr 1 then
  begin
    FCapacity := FCapacity shr 1;
    ReAllocMem(FList, FCapacity * SizeOf(TxListItem));
    end;
end;

procedure TLMDObjectList.Delete(Index: Integer);
begin
  CheckRange(Index);

  if Assigned(FList[Index]) then
  begin
    TriggerDeleteEvent(FList[Index], Index);
    if AutoClearObjects then
      FreeAndNil(TObject(FList[Index]));
  end;

  Dec(FCount);
  if FCount > Index then
    System.Move(FList[Index + 1],
                  FList[Index],
                  (FCount - Index) * SizeOf(TxListItem));
    if FCount < FCapacity shr 1 Then
  begin
    FCapacity := FCapacity shr 1;
    ReAllocMem(FList, FCapacity * SizeOf(TxListItem));
  end;
end;

class procedure TLMDObjectList.Error(const Msg: string; Data: Integer);

  function ReturnAddr: TxListItem;
  asm
    MOV     EAX,[EBP+4]
  end;

begin
  raise ELMDListError.CreateFmt(Msg, [Data])at ReturnAddr;
end;

procedure TLMDObjectList.CheckRange(Index: Integer);
begin
  if (Index < 0) or (Index >= FCount) then
    RaiseOutOfBoundsError(Index);
end;

procedure TLMDObjectList.Exchange(Index1, Index2: Integer);
var
  Item: TxListItem;
begin
  CheckRange(Index1);
  CheckRange(Index2);

  Item := FList[Index1];
  FList[Index1] := FList[Index2];
  FList[Index2] := Item;
end;

function TLMDObjectList.Expand: TLMDObjectList;
begin
  if FCount = FCapacity then
  begin
    Inc(FCapacity, Min(Count * 2 + 1, AlignMem));
    ReallocMem(FList, FCapacity * SizeOf(TxListItem));
    end;
  Result := Self;
end;

function TLMDObjectList.First: TxListItem;
begin
  CheckRange(0);

  Result := FList[0];
end;

function TLMDObjectList.FastGet(Index: Integer): TxListItem;
begin
  {$IFDEF LMD_DEBUG}
  if (Index < 0) or (Index >= FCount) then
    RaiseOutOfBoundsError(Index);
  {$ENDIF}
  Result := FList[Index];
end;

function TLMDObjectList.Get(Index: Integer): TxListItem;
begin
  //CheckRange(Index);
  if (Index < 0) or (Index >= FCount) then
    RaiseOutOfBoundsError(Index);

  Result := FList[Index];
end;

procedure TLMDObjectList.Grow;
begin
  Inc(FCapacity, Min(Count * 2 + 1, AlignMem));
  ReAllocMem(FList, FCapacity * SizeOf(TxListItem));
  end;

function TLMDObjectList.IndexOf(const Item: TxListItem): Integer;
begin
  Result := 0;
  // TODO: rewrite in assembler
  while (Result < FCount) and (FList[Result] <> Item) do
    Inc(Result);
  if Result = FCount then
    Result := -1;
end;

function TLMDObjectList.IndexOfBack(StartIndex: integer; const Item: TxListItem): Integer;
begin
  CheckRange(StartIndex);

  Result := StartIndex;
  while (Result >= 0) and (FList[Result] <> Item) do
    dec(Result);
end;

function TLMDObjectList.IndexOfFrom(StartIndex: integer; const Item: TxListItem): Integer;
begin
  CheckRange(StartIndex);

  Result := StartIndex;
  while (Result < FCount) and (FList[Result] <> Item) do
    Inc(Result);
  if Result = FCount then
    Result := -1;
end;

procedure TLMDObjectList.Insert(Index: Integer; const Item: TxListItem);
begin
  if (Index < 0) or (Index > FCount) then
    RaiseOutOfBoundsError(Index);

  if FCount = FCapacity then
  Begin
    Inc(FCapacity, Min(Count * 2 + 1, AlignMem));
    ReAllocMem(FList, FCapacity * SizeOf(TxListItem));
    End;
  // if Index < FCount then == Useless. See first line.
  System.Move(FList^[Index],
                FList^[Index + 1],
                (FCount - Index) * SizeOf(TxListItem));
  FList[Index] := Item;
  Inc(FCount);
end;

function TLMDObjectList.Last: TxListItem;
begin
  if FCount = 0 then
    Result := nil
  else
    Result := FList[FCount-1];
end;

procedure TLMDObjectList.Move(CurIndex, NewIndex: Integer);
var
  Item: TxListItem;
begin
  if CurIndex <> NewIndex then
  begin
    CheckRange(CurIndex);
    CheckRange(NewIndex);

    Item := FList[CurIndex];

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
    end;
end;

procedure TLMDObjectList.MoveRange(CurStart, CurEnd, NewStart: integer);
var
  bs: Integer;
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
        System.Move(FList^[NewStart], FList^[NewStart + BS], (CurStart -
            NewStart) * SizeOf(TxListItem));
        System.Move(P^, FList^[NewStart], BS * SizeOf(TxListItem));
        FreeMem(P);
      end else
    begin
      bs := CurEnd - CurStart + 1;
      GetMem(P, BS * SizeOf(TxListItem));
        System.Move(FList^[CurStart], P^, BS * SizeOf(TxListItem));
        System.Move(FList^[CurEnd + 1], FList^[CurStart], (NewStart - CurEnd) *
            SizeOf(TxListItem));
        NewStart := CurStart - 1 + NewStart - CurEnd;
        System.Move(P^, FList^[NewStart], BS * SizeOf(TxListItem));
        FreeMem(P);
      end;
  end;
end;

procedure TLMDObjectList.Pack;
var
  I: Integer;
begin
  for I := FCount - 1 downto 0 do
    if Items[I] = nil then
      Delete(I);
end;

procedure TLMDObjectList.Put(Index: Integer; const Item: TxListItem);
begin
  CheckRange(Index);

  if Assigned(FList[Index]) then
    begin
      TriggerDeleteEvent(FList[Index], Index);
      if AutoClearObjects then
        FreeAndNil(TObject(FList[Index]));
    end;

  FList[Index] := Item;
end;

function TLMDObjectList.Remove(const Item: TxListItem): Integer;
begin
  Result := IndexOf(Item);
  // changed by chmv. if Result <> -1 then
  if Result >= 0 then
  begin
    TriggerDeleteEvent(FList[Result], Result);
    Dec(FCount);
    // if Index < FCount then == Useless. See above.
    System.Move(FList^[Result + 1],
                  FList^[Result],
                  (FCount - Result) * SizeOf(TxListItem));
    if FCount < FCapacity shr 1 then
    begin
      FCapacity := FCapacity shr 1;
      ReAllocMem(FList, FCapacity * SizeOf(TxListItem));
      end;
  end;
end;

procedure TLMDObjectList.SetCapacity(NewCapacity: Integer);
begin

  if (NewCapacity < FCount)
     or
     (NewCapacity > MaxListSize)
     then
    RaiseOutOfBoundsError(NewCapacity);

  if NewCapacity <> FCapacity then
  begin
    ReallocMem(FList, NewCapacity * SizeOf(TxListItem));
    FCapacity := NewCapacity;
  end;
end;

procedure TLMDObjectList.SetCount(NewCount: Integer);
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

procedure TLMDObjectList.Sort(Compare: TLMDListSortCompare; const Cargo: TxListItem);
begin
  if 
     (FList <> nil)
     and
     (Count > 0)
  then
    QuickSort(FList, 0, Count - 1, Compare, Cargo);
end;

procedure TLMDObjectList.SortC(Compare: TLMDListSortCompareEx; const Cargo: TxListItem);
begin
  if 
     (FList <> nil)
     and
     (Count > 0)
  then
    QuickSortC(FList, 0, Count - 1, Compare, Cargo);
end;

procedure TLMDObjectList.TriggerDeleteEvent(Item: TxListItem; Index: Integer);

  { Triggers the OnDelete event. This is a virtual method (descendants of this
      component can override it). }

begin
  try
  if Assigned(FOnDelete) and Assigned(Item) then
  begin
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
    end;
  end;

end;

{ TLMDInterfacedObjectList }

procedure TLMDInterfacedObjectList.AfterConstruction;
begin
  inherited;
  if GetOwner <> nil then
    GetOwner.GetInterface(IInterface, FOwnerInterface);
end;

function TLMDInterfacedObjectList.QueryInterface(const IID: TGUID; out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TLMDInterfacedObjectList._AddRef: Integer;
begin
  if FOwnerInterface <> nil then
    Result := FOwnerInterface._AddRef
  else
    Result := -1;
end;

function TLMDInterfacedObjectList._Release: Integer;
begin
  if FOwnerInterface <> nil then
    Result := FOwnerInterface._Release
  else
    Result := -1;
end;

end.
