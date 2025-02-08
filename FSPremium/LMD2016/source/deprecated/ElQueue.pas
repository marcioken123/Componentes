unit ElQueue;
{###############################################################################

ElQueue unit
------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses

     classes,
     LMDTypes,
     LMDProcs,
     Windows,
     SysUtils

;

type
  EElQueueError = class(Exception)
  end;

  OnDiscardEvent = procedure(Sender : TObject; Item : TxListItem) of object;

type
  TElQueue = class(TObject)
  private
    {$ifdef CLR}
     FList :TObjectList;
    {$else}
     FList :PPointerList;
    {$endif}
    FCount : Integer;
    FCapacity : Integer;
    FOnDiscard : OnDiscardEvent;
  protected
    function Get(Index : Integer) : TxListItem;
    procedure SetCapacity(NewCapacity : Integer);
    procedure SetCount(NewCount : Integer);
  public
    destructor Destroy; override;
    function Add(Item : TxListItem) : Integer;
    procedure Delete(Index : Integer);
    procedure Clear;
    class procedure Error(const Msg : string; Data : Integer); virtual;
    procedure Exchange(Index1, Index2 : Integer);
    function First : TxListItem;
    function IndexOf(Item : TxListItem) : Integer;
    function Last : TxListItem;
    property Capacity : Integer read FCapacity write SetCapacity;
    property Count : Integer read FCount write SetCount;
    property Items[Index : Integer] : TxListItem read Get; default;
    {$ifdef CLR}
     property List : TObjectList read FList;
    {$else}
     property List : PPointerList read FList;
    {$endif}
    property OnDiscard : OnDiscardEvent read FOnDiscard write FOnDiscard;
  end;

implementation

destructor TElQueue.Destroy;
begin
  Clear;
  SetCapacity(0);
  inherited;
end;

function TElQueue.Add(Item : TxListItem) : Integer;
begin
  result := -1;
  if Capacity = 0 then exit;
  if FCount = FCapacity then
  begin
    if Assigned(FOnDiscard) then FOnDiscard(Self, Items[0]);
    Delete(0);
  end;
  Result := FCount;
  {$ifdef CLR}
   FList[Result] := Item;
  {$else}
   FList^[Result] := Item;
  {$endif}
  Inc(FCount);
end;

procedure TElQueue.Clear;
begin
  SetCount(0);
  //SetCapacity(0);
end;

procedure TElQueue.Delete(Index : Integer);
begin
  if (Index < 0) or (Index >= FCount) then raise EElQueueError.Create('Queue index out of bounds');
  Dec(FCount);
  if Index < FCount then
    {$ifdef CLR}
     //System.Array.Copy( FList, Index + 1, FList, Index, FCount - Index );
     SysArrayMove( FList, Index+1, Index,  FCount - Index );
    {$else}
     System.Move( FList^[Index + 1], FList^[Index], (FCount - Index) * SizeOf(TxListItem) );
    {$endif}
  if FCount < (FCapacity div 2) then SetCapacity(FCapacity div 2);
end;

class procedure TElQueue.Error(const Msg : string; Data : Integer);
{$ifndef CLR}
  function ReturnAddr : TxListItem;
  asm
          MOV     EAX,[EBP+4]
  end;
{$endif}
begin
  raise EListError.CreateFmt(Msg, [Data]) {$ifndef CLR} at ReturnAddr {$endif};
end;

procedure TElQueue.Exchange(Index1, Index2 : Integer);
var
  Item : TxListItem;
begin
  if (Index1 < 0) or (Index1 >= FCount) then raise EElQueueError.Create('Queue index out of bounds');
  if (Index2 < 0) or (Index2 >= FCount) then raise EElQueueError.Create('Queue index out of bounds');
  {$ifdef CLR}
   Item := FList[Index1];
   FList[Index1] := FList[Index2];
   FList[Index2] := Item;
  {$else}
   Item := FList^[Index1];
   FList^[Index1] := FList^[Index2];
   FList^[Index2] := Item;
  {$endif}
end;

function TElQueue.First : TxListItem;
begin
  Result := Get(0);
end;

function TElQueue.Get(Index : Integer) : TxListItem;
begin
  if (Index < 0) or (Index >= FCount) then raise EElQueueError.Create('Queue index out of bounds');
  {$ifdef CLR}
   Result := FList[Index];
  {$else}
   Result := FList^[Index];
  {$endif}
end;

function TElQueue.IndexOf(Item : TxListItem) : Integer;
begin
  Result := 0;
  while (Result < FCount) and (FList{$ifndef CLR}^{$endif}[Result] <> Item) do
    Inc(Result);
  if Result = FCount then Result := -1;
end;

function TElQueue.Last : TxListItem;
begin
  if FCount = 0 then
     result := nil
  else
    Result := Get(FCount - 1);
end;

procedure TElQueue.SetCapacity(NewCapacity : Integer);
begin
  {$ifndef CLR}
  if (NewCapacity > MaxListSize) then
    raise EElQueueError.Create('Queue index out of bounds');
  {$endif}
  if NewCapacity > FCapacity then
  begin
    {$ifdef CLR}
     SetLength(FList, NewCapacity);
    {$else}
     ReallocMem(FList, NewCapacity * SizeOf(TxListItem));
    {$endif}
    FCapacity := NewCapacity;
  end
  else if NewCapacity < FCapacity then
  begin

    {$ifdef CLR}
     //System.Array.Copy( FList, FCapacity - NewCapacity, FList, 0, NewCapacity );
     SysArrayMove( FList, 0, FCapacity - NewCapacity, NewCapacity );
    {$else}
     //procedure MoveMemory(Destination: TxListItem; Source: TxListItem; Length: DWORD);
     MoveMemory(FList, @(FList[FCapacity - NewCapacity]), (NewCapacity) * SizeOf(TxListItem));
    {$endif}

    {$ifdef CLR}
     Setlength(FList, NewCapacity);
    {$else}
     ReallocMem(FList, NewCapacity * SizeOf(TxListItem));
    {$endif}
    FCapacity := NewCapacity;
    if FCapacity = 0 then FList := nil;
  end;
end;

procedure TElQueue.SetCount(NewCount : Integer);
begin
  if (NewCount < 0)
     {$ifndef CLR}
     or (NewCount > MaxListSize)
     {$endif}
  then
    raise EElQueueError.Create('Queue index out of bounds');
  if NewCount > FCapacity then SetCapacity(NewCount);
  if NewCount > FCount then
    {$ifndef CLR}
     FillChar(FList^[FCount], (NewCount - FCount) * SizeOf(TxListItem), 0);
    {$endif}
  FCount := NewCount;
end;

end.
