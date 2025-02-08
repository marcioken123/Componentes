unit Contnrs_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Contnrs' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Variants, TypInfo, LMDTypes, LMDSctClass, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, SysUtils, Classes, Contnrs, SysUtils_LMDSW, Classes_LMDSW;


{ Type wrappers }

type
  TObjectList_sw = class;
  TComponentList_sw = class;
  TClassList_sw = class;
  TOrderedList_sw = class;
  TStack_sw = class;
  TObjectStack_sw = class;
  TQueue_sw = class;
  TObjectQueue_sw = class;
  TCustomBucketList_sw = class;
  TBucketList_sw = class;
  TObjectBucketList_sw = class;

  TObjectList_sc = class of TObjectList;
  TObjectList_sw = class(TList_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TObjectList): OleVariant;
    class function FromVar(const AValue: OleVariant): TObjectList;
    class function ClassToVar(AClass: TObjectList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TObjectList_sc;
  end;

  TComponentList_sc = class of TComponentList;
  TComponentList_sw = class(TObjectList_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TComponentList): OleVariant;
    class function FromVar(const AValue: OleVariant): TComponentList;
    class function ClassToVar(AClass: TComponentList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TComponentList_sc;
  end;

  TClassList_sc = class of TClassList;
  TClassList_sw = class(TList_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TClassList): OleVariant;
    class function FromVar(const AValue: OleVariant): TClassList;
    class function ClassToVar(AClass: TClassList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TClassList_sc;
  end;

  TOrderedList_sc = class of TOrderedList;
  TOrderedList_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TOrderedList): OleVariant;
    class function FromVar(const AValue: OleVariant): TOrderedList;
    class function ClassToVar(AClass: TOrderedList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TOrderedList_sc;
  end;

  TStack_sc = class of TStack;
  TStack_sw = class(TOrderedList_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStack): OleVariant;
    class function FromVar(const AValue: OleVariant): TStack;
    class function ClassToVar(AClass: TStack_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStack_sc;
  end;

  TObjectStack_sc = class of TObjectStack;
  TObjectStack_sw = class(TStack_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TObjectStack): OleVariant;
    class function FromVar(const AValue: OleVariant): TObjectStack;
    class function ClassToVar(AClass: TObjectStack_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TObjectStack_sc;
  end;

  TQueue_sc = class of TQueue;
  TQueue_sw = class(TOrderedList_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TQueue): OleVariant;
    class function FromVar(const AValue: OleVariant): TQueue;
    class function ClassToVar(AClass: TQueue_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TQueue_sc;
  end;

  TObjectQueue_sc = class of TObjectQueue;
  TObjectQueue_sw = class(TQueue_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TObjectQueue): OleVariant;
    class function FromVar(const AValue: OleVariant): TObjectQueue;
    class function ClassToVar(AClass: TObjectQueue_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TObjectQueue_sc;
  end;

  TBucketItem_sw = class(TLMDRecordWrapper)
  private
    FValue: TBucketItem;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TBucketItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TBucketItem;
  end;

  TBucket_sw = class(TLMDRecordWrapper)
  private
    FValue: TBucket;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TBucket): OleVariant;
    class function FromVar(const AValue: OleVariant): TBucket;
  end;

  TCustomBucketList_sc = class of TCustomBucketList;
  TCustomBucketList_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomBucketList): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomBucketList;
    class function ClassToVar(AClass: TCustomBucketList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomBucketList_sc;
  end;

  TBucketListSizes_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TBucketListSizes): OleVariant;
    class function FromVar(const AValue: OleVariant): TBucketListSizes;
  end;

  TBucketList_sc = class of TBucketList;
  TBucketList_sw = class(TCustomBucketList_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBucketList): OleVariant;
    class function FromVar(const AValue: OleVariant): TBucketList;
    class function ClassToVar(AClass: TBucketList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBucketList_sc;
  end;

  TObjectBucketList_sc = class of TObjectBucketList;
  TObjectBucketList_sw = class(TBucketList_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TObjectBucketList): OleVariant;
    class function FromVar(const AValue: OleVariant): TObjectBucketList;
    class function ClassToVar(AClass: TObjectBucketList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TObjectBucketList_sc;
  end;


{ Unit wrapper }

type
  Contnrs_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TOrderedList_sacc = class(TOrderedList);
  TCustomBucketList_sacc = class(TCustomBucketList);

{ TObjectList_sw }

function TObjectList_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  case AArgsSize of
    0:
    begin
      Result := TObjectList_sw.ToVar(TObjectList_sc(AObj).Create());
    end;
    1:
    begin
      Result := TObjectList_sw.ToVar(TObjectList_sc(AObj).Create(Boolean(
        AArgs[0])));
    end;
  else
    WrongArgCountError('Create');
  end;
end;

function TObjectList_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add(AObject: TObject): Integer;

  Result := TObjectList(AObj).Add(TObject_sw.FromVar(AArgs[0]));
end;

function TObjectList_Extract_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Extract(Item: TObject): TObject;

  Result := TObject_sw.ToVar(TObjectList(AObj).Extract(TObject_sw.FromVar(
    AArgs[0])));
end;

function TObjectList_Remove_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Remove(AObject: TObject): Integer;

  Result := TObjectList(AObj).Remove(TObject_sw.FromVar(AArgs[0]));
end;

function TObjectList_IndexOf_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IndexOf(AObject: TObject): Integer;

  Result := TObjectList(AObj).IndexOf(TObject_sw.FromVar(AArgs[0]));
end;

function TObjectList_FindInstanceOf_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindInstanceOf(AClass: TClass; AExact: Boolean; ...

  case AArgsSize of
    1:
    begin
      Result := TObjectList(AObj).FindInstanceOf(TClass_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      Result := TObjectList(AObj).FindInstanceOf(TClass_sw.FromVar(AArgs[0]), 
        Boolean(AArgs[1]));
    end;
    3:
    begin
      Result := TObjectList(AObj).FindInstanceOf(TClass_sw.FromVar(AArgs[0]), 
        Boolean(AArgs[1]), Integer(AArgs[2]));
    end;
  else
    WrongArgCountError('FindInstanceOf');
  end;
end;

function TObjectList_Insert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Insert(Index: Integer; AObject: TObject);

  TObjectList(AObj).Insert(Integer(AArgs[0]), TObject_sw.FromVar(AArgs[1]));
end;

function TObjectList_First_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function First: TObject;

  Result := TObject_sw.ToVar(TObjectList(AObj).First());
end;

function TObjectList_Last_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Last: TObject;

  Result := TObject_sw.ToVar(TObjectList(AObj).Last());
end;

function TObjectList_OwnsObjects_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OwnsObjects: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TObjectList(AObj).OwnsObjects
  else
    TObjectList(AObj).OwnsObjects := Boolean(AArgs[0]);
end;

function TObjectList_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TObject read <getter> wri...

  if IsGet then
    Result := TObject_sw.ToVar(TObjectList(AObj).Items[Integer(AArgs[0])])
  else
    TObjectList(AObj).Items[Integer(AArgs[0])] := TObject_sw.FromVar(AArgs[1]);
end;

class function TObjectList_sw.GetTypeName: WideString;
begin
  Result := 'TObjectList';
end;

class function TObjectList_sw.GetWrappedClass: TClass;
begin
  Result := TObjectList;
end;

class procedure TObjectList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TObjectList_Add_si, Integer_sw, 1, False);
  AData.AddFunction('Extract', TObjectList_Extract_si, TObject_sw, 1, False);
  AData.AddFunction('Remove', TObjectList_Remove_si, Integer_sw, 1, False);
  AData.AddFunction('IndexOf', TObjectList_IndexOf_si, Integer_sw, 1, False);
  AData.AddFunction('FindInstanceOf', TObjectList_FindInstanceOf_si, Integer_sw, 1, True);
  AData.AddProcedure('Insert', TObjectList_Insert_si, 2, False);
  AData.AddFunction('First', TObjectList_First_si, TObject_sw, 0, False);
  AData.AddFunction('Last', TObjectList_Last_si, TObject_sw, 0, False);
  AData.AddProperty('OwnsObjects', TObjectList_OwnsObjects_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Items', TObjectList_Items_si, TObject_sw, True, True, 1, False, True);

  { Class members }

  AData.AddConstructor('Create', TObjectList_Create_si, 0, True);
end;

class function TObjectList_sw.ToVar(const AValue: TObjectList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TObjectList_sw.FromVar(const AValue: OleVariant): TObjectList;
begin
  Result := TObjectList(ConvFromVar(AValue, TObjectList));
end;

class function TObjectList_sw.ClassToVar(AClass: TObjectList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TObjectList_sw.ClassFromVar(
  const AClass: OleVariant): TObjectList_sc;
begin
  Result := TObjectList_sc(ConvClsFromVar(AClass, TObjectList));
end;

{ TComponentList_sw }

function TComponentList_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add(AComponent: TComponent): Integer;

  Result := TComponentList(AObj).Add(TComponent_sw.FromVar(AArgs[0]));
end;

function TComponentList_Extract_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Extract(Item: TComponent): TComponent;

  Result := TComponent_sw.ToVar(TComponentList(AObj).Extract(TComponent_sw.
    FromVar(AArgs[0])));
end;

function TComponentList_Remove_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Remove(AComponent: TComponent): Integer;

  Result := TComponentList(AObj).Remove(TComponent_sw.FromVar(AArgs[0]));
end;

function TComponentList_IndexOf_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IndexOf(AComponent: TComponent): Integer;

  Result := TComponentList(AObj).IndexOf(TComponent_sw.FromVar(AArgs[0]));
end;

function TComponentList_First_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function First: TComponent;

  Result := TComponent_sw.ToVar(TComponentList(AObj).First());
end;

function TComponentList_Last_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Last: TComponent;

  Result := TComponent_sw.ToVar(TComponentList(AObj).Last());
end;

function TComponentList_Insert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Insert(Index: Integer; AComponent: TComponent);

  TComponentList(AObj).Insert(Integer(AArgs[0]), TComponent_sw.FromVar(
    AArgs[1]));
end;

function TComponentList_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TComponent read <getter> ...

  if IsGet then
    Result := TComponent_sw.ToVar(TComponentList(AObj).Items[Integer(AArgs[0])])
  else
    TComponentList(AObj).Items[Integer(AArgs[0])] := TComponent_sw.FromVar(
      AArgs[1]);
end;

class function TComponentList_sw.GetTypeName: WideString;
begin
  Result := 'TComponentList';
end;

class function TComponentList_sw.GetWrappedClass: TClass;
begin
  Result := TComponentList;
end;

class procedure TComponentList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TComponentList_Add_si, Integer_sw, 1, False);
  AData.AddFunction('Extract', TComponentList_Extract_si, TComponent_sw, 1, False);
  AData.AddFunction('Remove', TComponentList_Remove_si, Integer_sw, 1, False);
  AData.AddFunction('IndexOf', TComponentList_IndexOf_si, Integer_sw, 1, False);
  AData.AddFunction('First', TComponentList_First_si, TComponent_sw, 0, False);
  AData.AddFunction('Last', TComponentList_Last_si, TComponent_sw, 0, False);
  AData.AddProcedure('Insert', TComponentList_Insert_si, 2, False);
  AData.AddProperty('Items', TComponentList_Items_si, TComponent_sw, True, True, 1, False, True);
end;

class function TComponentList_sw.ToVar(
  const AValue: TComponentList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TComponentList_sw.FromVar(
  const AValue: OleVariant): TComponentList;
begin
  Result := TComponentList(ConvFromVar(AValue, TComponentList));
end;

class function TComponentList_sw.ClassToVar(
  AClass: TComponentList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TComponentList_sw.ClassFromVar(
  const AClass: OleVariant): TComponentList_sc;
begin
  Result := TComponentList_sc(ConvClsFromVar(AClass, TComponentList));
end;

{ TClassList_sw }

function TClassList_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add(AClass: TClass): Integer;

  Result := TClassList(AObj).Add(TClass_sw.FromVar(AArgs[0]));
end;

function TClassList_Extract_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Extract(Item: TClass): TClass;

  Result := TClass_sw.ToVar(TClassList(AObj).Extract(TClass_sw.FromVar(
    AArgs[0])));
end;

function TClassList_Remove_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Remove(AClass: TClass): Integer;

  Result := TClassList(AObj).Remove(TClass_sw.FromVar(AArgs[0]));
end;

function TClassList_IndexOf_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IndexOf(AClass: TClass): Integer;

  Result := TClassList(AObj).IndexOf(TClass_sw.FromVar(AArgs[0]));
end;

function TClassList_First_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function First: TClass;

  Result := TClass_sw.ToVar(TClassList(AObj).First());
end;

function TClassList_Last_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Last: TClass;

  Result := TClass_sw.ToVar(TClassList(AObj).Last());
end;

function TClassList_Insert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Insert(Index: Integer; AClass: TClass);

  TClassList(AObj).Insert(Integer(AArgs[0]), TClass_sw.FromVar(AArgs[1]));
end;

function TClassList_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TClass read <getter> writ...

  if IsGet then
    Result := TClass_sw.ToVar(TClassList(AObj).Items[Integer(AArgs[0])])
  else
    TClassList(AObj).Items[Integer(AArgs[0])] := TClass_sw.FromVar(AArgs[1]);
end;

class function TClassList_sw.GetTypeName: WideString;
begin
  Result := 'TClassList';
end;

class function TClassList_sw.GetWrappedClass: TClass;
begin
  Result := TClassList;
end;

class procedure TClassList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TClassList_Add_si, Integer_sw, 1, False);
  AData.AddFunction('Extract', TClassList_Extract_si, TClass_sw, 1, False);
  AData.AddFunction('Remove', TClassList_Remove_si, Integer_sw, 1, False);
  AData.AddFunction('IndexOf', TClassList_IndexOf_si, Integer_sw, 1, False);
  AData.AddFunction('First', TClassList_First_si, TClass_sw, 0, False);
  AData.AddFunction('Last', TClassList_Last_si, TClass_sw, 0, False);
  AData.AddProcedure('Insert', TClassList_Insert_si, 2, False);
  AData.AddProperty('Items', TClassList_Items_si, TClass_sw, True, True, 1, False, True);
end;

class function TClassList_sw.ToVar(const AValue: TClassList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TClassList_sw.FromVar(const AValue: OleVariant): TClassList;
begin
  Result := TClassList(ConvFromVar(AValue, TClassList));
end;

class function TClassList_sw.ClassToVar(AClass: TClassList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TClassList_sw.ClassFromVar(
  const AClass: OleVariant): TClassList_sc;
begin
  Result := TClassList_sc(ConvClsFromVar(AClass, TClassList));
end;

{ TOrderedList_sw }

function TOrderedList_List_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property List: TList read <getter>;

  Result := TList_sw.ToVar(TOrderedList_sacc(TOrderedList(AObj)).List);
end;

function TOrderedList_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TOrderedList_sw.ToVar(TOrderedList_sc(AObj).Create());
end;

function TOrderedList_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Count: Integer;

  Result := TOrderedList(AObj).Count();
end;

function TOrderedList_AtLeast_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AtLeast(ACount: Integer): Boolean;

  Result := TOrderedList(AObj).AtLeast(Integer(AArgs[0]));
end;

class function TOrderedList_sw.GetTypeName: WideString;
begin
  Result := 'TOrderedList';
end;

class function TOrderedList_sw.GetWrappedClass: TClass;
begin
  Result := TOrderedList;
end;

class procedure TOrderedList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('List', TOrderedList_List_si, TList_sw, True, False, 0, True, False);
  AData.AddFunction('Count', TOrderedList_Count_si, Integer_sw, 0, False);
  AData.AddFunction('AtLeast', TOrderedList_AtLeast_si, Boolean_sw, 1, False);

  { Class members }

  AData.AddConstructor('Create', TOrderedList_Create_si, 0, False);
end;

class function TOrderedList_sw.ToVar(const AValue: TOrderedList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TOrderedList_sw.FromVar(const AValue: OleVariant): TOrderedList;
begin
  Result := TOrderedList(ConvFromVar(AValue, TOrderedList));
end;

class function TOrderedList_sw.ClassToVar(AClass: TOrderedList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TOrderedList_sw.ClassFromVar(
  const AClass: OleVariant): TOrderedList_sc;
begin
  Result := TOrderedList_sc(ConvClsFromVar(AClass, TOrderedList));
end;

{ TStack_sw }

class function TStack_sw.GetTypeName: WideString;
begin
  Result := 'TStack';
end;

class function TStack_sw.GetWrappedClass: TClass;
begin
  Result := TStack;
end;

class procedure TStack_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TStack_sw.ToVar(const AValue: TStack): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStack_sw.FromVar(const AValue: OleVariant): TStack;
begin
  Result := TStack(ConvFromVar(AValue, TStack));
end;

class function TStack_sw.ClassToVar(AClass: TStack_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStack_sw.ClassFromVar(const AClass: OleVariant): TStack_sc;
begin
  Result := TStack_sc(ConvClsFromVar(AClass, TStack));
end;

{ TObjectStack_sw }

function TObjectStack_Push_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Push(AObject: TObject): TObject;

  Result := TObject_sw.ToVar(TObjectStack(AObj).Push(TObject_sw.FromVar(
    AArgs[0])));
end;

function TObjectStack_Pop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Pop: TObject;

  Result := TObject_sw.ToVar(TObjectStack(AObj).Pop());
end;

function TObjectStack_Peek_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Peek: TObject;

  Result := TObject_sw.ToVar(TObjectStack(AObj).Peek());
end;

class function TObjectStack_sw.GetTypeName: WideString;
begin
  Result := 'TObjectStack';
end;

class function TObjectStack_sw.GetWrappedClass: TClass;
begin
  Result := TObjectStack;
end;

class procedure TObjectStack_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Push', TObjectStack_Push_si, TObject_sw, 1, False);
  AData.AddFunction('Pop', TObjectStack_Pop_si, TObject_sw, 0, False);
  AData.AddFunction('Peek', TObjectStack_Peek_si, TObject_sw, 0, False);
end;

class function TObjectStack_sw.ToVar(const AValue: TObjectStack): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TObjectStack_sw.FromVar(const AValue: OleVariant): TObjectStack;
begin
  Result := TObjectStack(ConvFromVar(AValue, TObjectStack));
end;

class function TObjectStack_sw.ClassToVar(AClass: TObjectStack_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TObjectStack_sw.ClassFromVar(
  const AClass: OleVariant): TObjectStack_sc;
begin
  Result := TObjectStack_sc(ConvClsFromVar(AClass, TObjectStack));
end;

{ TQueue_sw }

class function TQueue_sw.GetTypeName: WideString;
begin
  Result := 'TQueue';
end;

class function TQueue_sw.GetWrappedClass: TClass;
begin
  Result := TQueue;
end;

class procedure TQueue_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TQueue_sw.ToVar(const AValue: TQueue): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TQueue_sw.FromVar(const AValue: OleVariant): TQueue;
begin
  Result := TQueue(ConvFromVar(AValue, TQueue));
end;

class function TQueue_sw.ClassToVar(AClass: TQueue_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TQueue_sw.ClassFromVar(const AClass: OleVariant): TQueue_sc;
begin
  Result := TQueue_sc(ConvClsFromVar(AClass, TQueue));
end;

{ TObjectQueue_sw }

function TObjectQueue_Push_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Push(AObject: TObject): TObject;

  Result := TObject_sw.ToVar(TObjectQueue(AObj).Push(TObject_sw.FromVar(
    AArgs[0])));
end;

function TObjectQueue_Pop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Pop: TObject;

  Result := TObject_sw.ToVar(TObjectQueue(AObj).Pop());
end;

function TObjectQueue_Peek_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Peek: TObject;

  Result := TObject_sw.ToVar(TObjectQueue(AObj).Peek());
end;

class function TObjectQueue_sw.GetTypeName: WideString;
begin
  Result := 'TObjectQueue';
end;

class function TObjectQueue_sw.GetWrappedClass: TClass;
begin
  Result := TObjectQueue;
end;

class procedure TObjectQueue_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Push', TObjectQueue_Push_si, TObject_sw, 1, False);
  AData.AddFunction('Pop', TObjectQueue_Pop_si, TObject_sw, 0, False);
  AData.AddFunction('Peek', TObjectQueue_Peek_si, TObject_sw, 0, False);
end;

class function TObjectQueue_sw.ToVar(const AValue: TObjectQueue): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TObjectQueue_sw.FromVar(const AValue: OleVariant): TObjectQueue;
begin
  Result := TObjectQueue(ConvFromVar(AValue, TObjectQueue));
end;

class function TObjectQueue_sw.ClassToVar(AClass: TObjectQueue_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TObjectQueue_sw.ClassFromVar(
  const AClass: OleVariant): TObjectQueue_sc;
begin
  Result := TObjectQueue_sc(ConvClsFromVar(AClass, TObjectQueue));
end;

{ TBucketItem_sw }

function TBucketItem_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TBucketItem_sw.Create as IDispatch;
end;

function TBucketItem_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TBucketItem;

  // Implicit record copy method.
  Result := TBucketItem_sw.ToVar(TBucketItem(AObj));
end;

class function TBucketItem_sw.GetTypeName: WideString;
begin
  Result := 'TBucketItem';
end;

function TBucketItem_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TBucketItem_sw.Create;
  TBucketItem_sw(Result).FValue := FValue;
end;

class procedure TBucketItem_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TBucketItem_Copy_si, TBucketItem_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TBucketItem_Create_si, 0, False);
end;

class function TBucketItem_sw.ToVar(const AValue: TBucketItem): OleVariant;
var
  wrpr: TBucketItem_sw;
begin
  wrpr        := TBucketItem_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TBucketItem_sw.FromVar(const AValue: OleVariant): TBucketItem;
begin
  Result := TBucketItem_sw(ConvFromVar(AValue)).FValue;
end;

{ TBucket_sw }

function TBucket_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Count: Integer;

  if IsGet then
    Result := TBucket_sw(AObj).FValue.Count
  else
    TBucket_sw(AObj).FValue.Count := Integer(AArgs[0]);
end;

function TBucket_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TBucket_sw.Create as IDispatch;
end;

function TBucket_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TBucket;

  // Implicit record copy method.
  Result := TBucket_sw.ToVar(TBucket(AObj));
end;

class function TBucket_sw.GetTypeName: WideString;
begin
  Result := 'TBucket';
end;

function TBucket_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TBucket_sw.Create;
  TBucket_sw(Result).FValue := FValue;
end;

class procedure TBucket_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Count', TBucket_Count_si, Integer_sw);
  AData.AddFunction('Copy', TBucket_Copy_si, TBucket_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TBucket_Create_si, 0, False);
end;

class function TBucket_sw.ToVar(const AValue: TBucket): OleVariant;
var
  wrpr: TBucket_sw;
begin
  wrpr        := TBucket_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TBucket_sw.FromVar(const AValue: OleVariant): TBucket;
begin
  Result := TBucket_sw(ConvFromVar(AValue)).FValue;
end;

{ TCustomBucketList_sw }

function TCustomBucketList_BucketCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BucketCount: Integer read <getter> wri...

  if IsGet then
    Result := TCustomBucketList_sacc(TCustomBucketList(AObj)).BucketCount
  else
    TCustomBucketList_sacc(TCustomBucketList(AObj)).BucketCount := Integer(
      AArgs[0]);
end;

function TCustomBucketList_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TCustomBucketList(AObj).Clear();
end;

function TCustomBucketList_Assign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Assign(AList: TCustomBucketList);

  TCustomBucketList(AObj).Assign(TCustomBucketList_sw.FromVar(AArgs[0]));
end;

class function TCustomBucketList_sw.GetTypeName: WideString;
begin
  Result := 'TCustomBucketList';
end;

class function TCustomBucketList_sw.GetWrappedClass: TClass;
begin
  Result := TCustomBucketList;
end;

class procedure TCustomBucketList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('BucketCount', TCustomBucketList_BucketCount_si, Integer_sw, True, True, 0, True, False);
  AData.AddProcedure('Clear', TCustomBucketList_Clear_si, 0, False);
  AData.AddProcedure('Assign', TCustomBucketList_Assign_si, 1, False);
end;

class function TCustomBucketList_sw.ToVar(
  const AValue: TCustomBucketList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomBucketList_sw.FromVar(
  const AValue: OleVariant): TCustomBucketList;
begin
  Result := TCustomBucketList(ConvFromVar(AValue, TCustomBucketList));
end;

class function TCustomBucketList_sw.ClassToVar(
  AClass: TCustomBucketList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomBucketList_sw.ClassFromVar(
  const AClass: OleVariant): TCustomBucketList_sc;
begin
  Result := TCustomBucketList_sc(ConvClsFromVar(AClass, TCustomBucketList));
end;

{ TBucketListSizes_sw }

class function TBucketListSizes_sw.GetTypeName: WideString;
begin
  Result := 'TBucketListSizes';
end;

class procedure TBucketListSizes_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..7] of TLMDEnumerator = (
    (Name: 'bl2'; Value: Integer({$IFDEF LMDSCT_12}TBucketListSizes.{$ENDIF}bl2)),
    (Name: 'bl4'; Value: Integer({$IFDEF LMDSCT_12}TBucketListSizes.{$ENDIF}bl4)),
    (Name: 'bl8'; Value: Integer({$IFDEF LMDSCT_12}TBucketListSizes.{$ENDIF}bl8)),
    (Name: 'bl16'; Value: Integer({$IFDEF LMDSCT_12}TBucketListSizes.{$ENDIF}bl16)),
    (Name: 'bl32'; Value: Integer({$IFDEF LMDSCT_12}TBucketListSizes.{$ENDIF}bl32)),
    (Name: 'bl64'; Value: Integer({$IFDEF LMDSCT_12}TBucketListSizes.{$ENDIF}bl64)),
    (Name: 'bl128'; Value: Integer({$IFDEF LMDSCT_12}TBucketListSizes.{$ENDIF}bl128)),
    (Name: 'bl256'; Value: Integer({$IFDEF LMDSCT_12}TBucketListSizes.{$ENDIF}bl256))
  );
begin
  AEnums := @ENUMS;
  ACount := 8;
end;

class function TBucketListSizes_sw.ToVar(
  const AValue: TBucketListSizes): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBucketListSizes_sw.FromVar(
  const AValue: OleVariant): TBucketListSizes;
begin
  Result := TBucketListSizes(Integer(AValue));
end;

{ TBucketList_sw }

function TBucketList_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(ABuckets: TBucketListSizes);

  case AArgsSize of
    0:
    begin
      Result := TBucketList_sw.ToVar(TBucketList_sc(AObj).Create());
    end;
    1:
    begin
      Result := TBucketList_sw.ToVar(TBucketList_sc(AObj).Create(
        TBucketListSizes_sw.FromVar(AArgs[0])));
    end;
  else
    WrongArgCountError('Create');
  end;
end;

class function TBucketList_sw.GetTypeName: WideString;
begin
  Result := 'TBucketList';
end;

class function TBucketList_sw.GetWrappedClass: TClass;
begin
  Result := TBucketList;
end;

class procedure TBucketList_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', TBucketList_Create_si, 0, True);
end;

class function TBucketList_sw.ToVar(const AValue: TBucketList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBucketList_sw.FromVar(const AValue: OleVariant): TBucketList;
begin
  Result := TBucketList(ConvFromVar(AValue, TBucketList));
end;

class function TBucketList_sw.ClassToVar(AClass: TBucketList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBucketList_sw.ClassFromVar(
  const AClass: OleVariant): TBucketList_sc;
begin
  Result := TBucketList_sc(ConvClsFromVar(AClass, TBucketList));
end;

{ TObjectBucketList_sw }

function TObjectBucketList_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add(AItem: TObject; AData: TObject): TObject;

  Result := TObject_sw.ToVar(TObjectBucketList(AObj).Add(TObject_sw.FromVar(
    AArgs[0]), TObject_sw.FromVar(AArgs[1])));
end;

function TObjectBucketList_Remove_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Remove(AItem: TObject): TObject;

  Result := TObject_sw.ToVar(TObjectBucketList(AObj).Remove(TObject_sw.FromVar(
    AArgs[0])));
end;

function TObjectBucketList_Data_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Data[AItem: TObject]: TObject read <getter> writ...

  if IsGet then
    Result := TObject_sw.ToVar(TObjectBucketList(AObj).Data[TObject_sw.FromVar(
      AArgs[0])])
  else
    TObjectBucketList(AObj).Data[TObject_sw.FromVar(AArgs[0])] := TObject_sw.
      FromVar(AArgs[1]);
end;

class function TObjectBucketList_sw.GetTypeName: WideString;
begin
  Result := 'TObjectBucketList';
end;

class function TObjectBucketList_sw.GetWrappedClass: TClass;
begin
  Result := TObjectBucketList;
end;

class procedure TObjectBucketList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TObjectBucketList_Add_si, TObject_sw, 2, False);
  AData.AddFunction('Remove', TObjectBucketList_Remove_si, TObject_sw, 1, False);
  AData.AddProperty('Data', TObjectBucketList_Data_si, TObject_sw, True, True, 1, False, True);
end;

class function TObjectBucketList_sw.ToVar(
  const AValue: TObjectBucketList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TObjectBucketList_sw.FromVar(
  const AValue: OleVariant): TObjectBucketList;
begin
  Result := TObjectBucketList(ConvFromVar(AValue, TObjectBucketList));
end;

class function TObjectBucketList_sw.ClassToVar(
  AClass: TObjectBucketList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TObjectBucketList_sw.ClassFromVar(
  const AClass: OleVariant): TObjectBucketList_sc;
begin
  Result := TObjectBucketList_sc(ConvClsFromVar(AClass, TObjectBucketList));
end;

{ Contnrs_sw }

function Contnrs_TObjectList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TObjectList = class(TList);

  Result := TLMDUnitWrapper.TypeToVar(TObjectList_sw);
end;

function Contnrs_TComponentList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TComponentList = class(TObjectList);

  Result := TLMDUnitWrapper.TypeToVar(TComponentList_sw);
end;

function Contnrs_TClassList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TClassList = class(TList);

  Result := TLMDUnitWrapper.TypeToVar(TClassList_sw);
end;

function Contnrs_TOrderedList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOrderedList = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TOrderedList_sw);
end;

function Contnrs_TStack_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStack = class(TOrderedList);

  Result := TLMDUnitWrapper.TypeToVar(TStack_sw);
end;

function Contnrs_TObjectStack_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TObjectStack = class(TStack);

  Result := TLMDUnitWrapper.TypeToVar(TObjectStack_sw);
end;

function Contnrs_TQueue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TQueue = class(TOrderedList);

  Result := TLMDUnitWrapper.TypeToVar(TQueue_sw);
end;

function Contnrs_TObjectQueue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TObjectQueue = class(TQueue);

  Result := TLMDUnitWrapper.TypeToVar(TObjectQueue_sw);
end;

function Contnrs_TBucketItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBucketItem = record;

  Result := TLMDUnitWrapper.TypeToVar(TBucketItem_sw);
end;

function Contnrs_TBucket_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBucket = record;

  Result := TLMDUnitWrapper.TypeToVar(TBucket_sw);
end;

function Contnrs_TCustomBucketList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomBucketList = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TCustomBucketList_sw);
end;

function Contnrs_TBucketListSizes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBucketListSizes = (bl2, bl4, bl8, bl16, bl32, bl64,...

  Result := TLMDUnitWrapper.TypeToVar(TBucketListSizes_sw);
end;

function Contnrs_TBucketList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBucketList = class(TCustomBucketList);

  Result := TLMDUnitWrapper.TypeToVar(TBucketList_sw);
end;

function Contnrs_TObjectBucketList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TObjectBucketList = class(TBucketList);

  Result := TLMDUnitWrapper.TypeToVar(TObjectBucketList_sw);
end;

class function Contnrs_sw.GetUnitName: WideString;
begin
  Result := 'Contnrs';
end;

class procedure Contnrs_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TObjectList_sw, Contnrs_TObjectList_si);
  AData.AddType(TComponentList_sw, Contnrs_TComponentList_si);
  AData.AddType(TClassList_sw, Contnrs_TClassList_si);
  AData.AddType(TOrderedList_sw, Contnrs_TOrderedList_si);
  AData.AddType(TStack_sw, Contnrs_TStack_si);
  AData.AddType(TObjectStack_sw, Contnrs_TObjectStack_si);
  AData.AddType(TQueue_sw, Contnrs_TQueue_si);
  AData.AddType(TObjectQueue_sw, Contnrs_TObjectQueue_si);
  AData.AddType(TBucketItem_sw, Contnrs_TBucketItem_si);
  AData.AddType(TBucket_sw, Contnrs_TBucket_si);
  AData.AddType(TCustomBucketList_sw, Contnrs_TCustomBucketList_si);
  AData.AddType(TBucketListSizes_sw, Contnrs_TBucketListSizes_si);
  AData.AddType(TBucketList_sw, Contnrs_TBucketList_si);
  AData.AddType(TObjectBucketList_sw, Contnrs_TObjectBucketList_si);
end;

class function Contnrs_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Contnrs_sw);
end;

initialization
  RegisterUnitWrapper(Contnrs_sw);
  RegisterClassWrapper(TObjectList_sw);
  RegisterClassWrapper(TComponentList_sw);
  RegisterClassWrapper(TClassList_sw);
  RegisterClassWrapper(TOrderedList_sw);
  RegisterClassWrapper(TStack_sw);
  RegisterClassWrapper(TObjectStack_sw);
  RegisterClassWrapper(TQueue_sw);
  RegisterClassWrapper(TObjectQueue_sw);
  RegisterClassWrapper(TCustomBucketList_sw);
  RegisterClassWrapper(TBucketList_sw);
  RegisterClassWrapper(TObjectBucketList_sw);

end.
