{***********************************************************
                R&A Library
                   RAI2
       Copyright (C) 1998-99 R&A

       description : adapter unit - converts RAI2 calls to delphi calls

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib
************************************************************}
{$INCLUDE RA.INC}

unit RAI2_contnrs;

interface

uses RAI2;

  procedure RegisterRAI2Adapter(RAI2Adapter: TRAI2Adapter);

implementation

uses Classes, contnrs;


  { TObjectList }

{ constructor Create }
procedure TObjectList_Create(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TObjectList.Create);
end;

{ constructor Create(AOwnsObjects: Boolean) }
procedure TObjectList_CreateOwns(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TObjectList.Create(Args.Values[0]));
end;

{  function Add(AObject: TObject): Integer; }
procedure TObjectList_Add(var Value: Variant; Args: TArgs);
begin
  Value := TObjectList(Args.Obj).Add(V2O(Args.Values[0]));
end;

{  function Remove(AObject: TObject): Integer; }
procedure TObjectList_Remove(var Value: Variant; Args: TArgs);
begin
  Value := TObjectList(Args.Obj).Remove(V2O(Args.Values[0]));
end;

{  function IndexOf(AObject: TObject): Integer; }
procedure TObjectList_IndexOf(var Value: Variant; Args: TArgs);
begin
  Value := TObjectList(Args.Obj).IndexOf(V2O(Args.Values[0]));
end;

{  function FindInstanceOf(AClass: TClass; AExact: Boolean = True; AStartAt: Integer = 0): Integer; }
procedure TObjectList_FindInstanceOf(var Value: Variant; Args: TArgs);
begin
  Value := TObjectList(Args.Obj).FindInstanceOf(V2C(Args.Values[0]), Args.Values[1], Args.Values[2]);
end;

{  procedure Insert(Index: Integer; AObject: TObject); }
procedure TObjectList_Insert(var Value: Variant; Args: TArgs);
begin
  TObjectList(Args.Obj).Insert(Args.Values[0], V2O(Args.Values[1]));
end;

{ property Read OwnsObjects: Boolean }
procedure TObjectList_Read_OwnsObjects(var Value: Variant; Args: TArgs);
begin
  Value := TObjectList(Args.Obj).OwnsObjects;
end;

{ property Write OwnsObjects(Value: Boolean) }
procedure TObjectList_Write_OwnsObjects(const Value: Variant; Args: TArgs);
begin
  TObjectList(Args.Obj).OwnsObjects := Value;
end;

{ property Read Items[Integer]: TObject }
procedure TObjectList_Read_Items(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TObjectList(Args.Obj).Items[Args.Values[0]]);
end;

{ property Write Items[Integer]: TObject }
procedure TObjectList_Write_Items(const Value: Variant; Args: TArgs);
begin
  TObjectList(Args.Obj).Items[Args.Values[0]] := V2O(Value);
end;

  { TComponentList }

{  function Add(AComponent: TComponent): Integer; }
procedure TComponentList_Add(var Value: Variant; Args: TArgs);
begin
  Value := TComponentList(Args.Obj).Add(V2O(Args.Values[0]) as TComponent);
end;

{  function Remove(AComponent: TComponent): Integer; }
procedure TComponentList_Remove(var Value: Variant; Args: TArgs);
begin
  Value := TComponentList(Args.Obj).Remove(V2O(Args.Values[0]) as TComponent);
end;

{  function IndexOf(AComponent: TComponent): Integer; }
procedure TComponentList_IndexOf(var Value: Variant; Args: TArgs);
begin
  Value := TComponentList(Args.Obj).IndexOf(V2O(Args.Values[0]) as TComponent);
end;

{  procedure Insert(Index: Integer; AComponent: TComponent); }
procedure TComponentList_Insert(var Value: Variant; Args: TArgs);
begin
  TComponentList(Args.Obj).Insert(Args.Values[0], V2O(Args.Values[1]) as TComponent);
end;

{ property Read Items[Integer]: TComponent }
procedure TComponentList_Read_Items(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TComponentList(Args.Obj).Items[Args.Values[0]]);
end;

{ property Write Items[Integer]: TComponent }
procedure TComponentList_Write_Items(const Value: Variant; Args: TArgs);
begin
  TComponentList(Args.Obj).Items[Args.Values[0]] := V2O(Value) as TComponent;
end;

  { TClassList }

{  function Add(aClass: TClass): Integer; }
procedure TClassList_Add(var Value: Variant; Args: TArgs);
begin
  Value := TClassList(Args.Obj).Add(V2C(Args.Values[0]));
end;

{  function Remove(aClass: TClass): Integer; }
procedure TClassList_Remove(var Value: Variant; Args: TArgs);
begin
  Value := TClassList(Args.Obj).Remove(V2C(Args.Values[0]));
end;

{  function IndexOf(aClass: TClass): Integer; }
procedure TClassList_IndexOf(var Value: Variant; Args: TArgs);
begin
  Value := TClassList(Args.Obj).IndexOf(V2C(Args.Values[0]));
end;

{  procedure Insert(Index: Integer; aClass: TClass); }
procedure TClassList_Insert(var Value: Variant; Args: TArgs);
begin
  TClassList(Args.Obj).Insert(Args.Values[0], V2C(Args.Values[1]));
end;

{ property Read Items[Integer]: TClass }
procedure TClassList_Read_Items(var Value: Variant; Args: TArgs);
begin
  Value := C2V(TClassList(Args.Obj).Items[Args.Values[0]]);
end;

{ property Write Items[Integer]: TClass }
procedure TClassList_Write_Items(const Value: Variant; Args: TArgs);
begin
  TClassList(Args.Obj).Items[Args.Values[0]] := V2C(Value);
end;

  { TOrderedList }

{  function Count: Integer; }
procedure TOrderedList_Count(var Value: Variant; Args: TArgs);
begin
  Value := TOrderedList(Args.Obj).Count;
end;

{  function AtLeast(ACount: Integer): Boolean; }
procedure TOrderedList_AtLeast(var Value: Variant; Args: TArgs);
begin
  Value := TOrderedList(Args.Obj).AtLeast(Args.Values[0]);
end;

{  procedure Push(AItem: Pointer); }
procedure TOrderedList_Push(var Value: Variant; Args: TArgs);
begin
  TOrderedList(Args.Obj).Push(V2P(Args.Values[0]));
end;

{  function Pop: Pointer; }
procedure TOrderedList_Pop(var Value: Variant; Args: TArgs);
begin
  Value := P2V(TOrderedList(Args.Obj).Pop);
end;

{  function Peek: Pointer; }
procedure TOrderedList_Peek(var Value: Variant; Args: TArgs);
begin
  Value := P2V(TOrderedList(Args.Obj).Peek);
end;

  { TStack }

  { TObjectStack }

{  procedure Push(AObject: TObject); }
procedure TObjectStack_Push(var Value: Variant; Args: TArgs);
begin
  TObjectStack(Args.Obj).Push(V2O(Args.Values[0]));
end;

{  function Pop: TObject; }
procedure TObjectStack_Pop(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TObjectStack(Args.Obj).Pop);
end;

{  function Peek: TObject; }
procedure TObjectStack_Peek(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TObjectStack(Args.Obj).Peek);
end;

  { TQueue }

  { TObjectQueue }

{  procedure Push(AObject: TObject); }
procedure TObjectQueue_Push(var Value: Variant; Args: TArgs);
begin
  TObjectQueue(Args.Obj).Push(V2O(Args.Values[0]));
end;

{  function Pop: TObject; }
procedure TObjectQueue_Pop(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TObjectQueue(Args.Obj).Pop);
end;

{  function Peek: TObject; }
procedure TObjectQueue_Peek(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TObjectQueue(Args.Obj).Peek);
end;


procedure RegisterRAI2Adapter(RAI2Adapter: TRAI2Adapter);
begin
  with RAI2Adapter do
  begin
   { TObjectList }
    AddClass('contnrs', TObjectList, 'TObjectList');
    AddGet(TObjectList, 'Create', TObjectList_Create, 0, [0]);
    AddGet(TObjectList, 'CreateOwns', TObjectList_CreateOwns, 1, [varBoolean]);
    AddGet(TObjectList, 'Add', TObjectList_Add, 1, [varObject]);
    AddGet(TObjectList, 'Remove', TObjectList_Remove, 1, [varObject]);
    AddGet(TObjectList, 'IndexOf', TObjectList_IndexOf, 1, [varObject]);
    AddGet(TObjectList, 'FindInstanceOf', TObjectList_FindInstanceOf, 3, [varEmpty, varBoolean, varInteger]);
    AddGet(TObjectList, 'Insert', TObjectList_Insert, 2, [varInteger, varObject]);
    AddGet(TObjectList, 'OwnsObjects', TObjectList_Read_OwnsObjects, 0, [0]);
    AddSet(TObjectList, 'OwnsObjects', TObjectList_Write_OwnsObjects, 0, [0]);
    AddGet(TObjectList, 'Items', TObjectList_Read_Items, 1, [0]);
    AddSet(TObjectList, 'Items', TObjectList_Write_Items, 1, [1]);
   { TComponentList }
    AddClass('contnrs', TComponentList, 'TComponentList');
    AddGet(TComponentList, 'Add', TComponentList_Add, 1, [varObject]);
    AddGet(TComponentList, 'Remove', TComponentList_Remove, 1, [varObject]);
    AddGet(TComponentList, 'IndexOf', TComponentList_IndexOf, 1, [varObject]);
    AddGet(TComponentList, 'Insert', TComponentList_Insert, 2, [varInteger, varObject]);
    AddGet(TComponentList, 'Items', TComponentList_Read_Items, 1, [0]);
    AddSet(TComponentList, 'Items', TComponentList_Write_Items, 1, [1]);
   { TClassList }
    AddClass('contnrs', TClassList, 'TClassList');
    AddGet(TClassList, 'Add', TClassList_Add, 1, [varEmpty]);
    AddGet(TClassList, 'Remove', TClassList_Remove, 1, [varEmpty]);
    AddGet(TClassList, 'IndexOf', TClassList_IndexOf, 1, [varEmpty]);
    AddGet(TClassList, 'Insert', TClassList_Insert, 2, [varInteger, varEmpty]);
    AddGet(TClassList, 'Items', TClassList_Read_Items, 1, [0]);
    AddSet(TClassList, 'Items', TClassList_Write_Items, 1, [1]);
   { TOrderedList }
    AddClass('contnrs', TOrderedList, 'TOrderedList');
    AddGet(TOrderedList, 'Count', TOrderedList_Count, 0, [0]);
    AddGet(TOrderedList, 'AtLeast', TOrderedList_AtLeast, 1, [varInteger]);
    AddGet(TOrderedList, 'Push', TOrderedList_Push, 1, [varPointer]);
    AddGet(TOrderedList, 'Pop', TOrderedList_Pop, 0, [0]);
    AddGet(TOrderedList, 'Peek', TOrderedList_Peek, 0, [0]);
   { TStack }
    AddClass('contnrs', TStack, 'TStack');
   { TObjectStack }
    AddClass('contnrs', TObjectStack, 'TObjectStack');
    AddGet(TObjectStack, 'Push', TObjectStack_Push, 1, [varObject]);
    AddGet(TObjectStack, 'Pop', TObjectStack_Pop, 0, [0]);
    AddGet(TObjectStack, 'Peek', TObjectStack_Peek, 0, [0]);
   { TQueue }
    AddClass('contnrs', TQueue, 'TQueue');
   { TObjectQueue }
    AddClass('contnrs', TObjectQueue, 'TObjectQueue');
    AddGet(TObjectQueue, 'Push', TObjectQueue_Push, 1, [varObject]);
    AddGet(TObjectQueue, 'Pop', TObjectQueue_Pop, 0, [0]);
    AddGet(TObjectQueue, 'Peek', TObjectQueue_Peek, 0, [0]);
  end;    { with }
end;    { RegisterRAI2Adapter }

end.
