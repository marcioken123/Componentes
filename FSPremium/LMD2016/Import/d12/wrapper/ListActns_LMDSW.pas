unit ListActns_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'ListActns' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  SysUtils, Variants, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, Types, Classes, Controls, ActnList, ImgList, ListActns,
  Classes_LMDSW, Controls_LMDSW, ActnList_LMDSW, ImgList_LMDSW;


{ Type wrappers }

type
  TListControlItem_sw = class;
  TListControlItems_sw = class;
  TCustomListAction_sw = class;
  TCustomVirtualListAction_sw = class;
  TVirtualListAction_sw = class;
  TStaticListItems_sw = class;
  TListControlItemClass_sw = class;
  TCustomStaticListAction_sw = class;
  TStaticListAction_sw = class;
  TListActionLink_sw = class;

  TListControlItem_sc = class of TListControlItem;
  TListControlItem_sw = class(TCollectionItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TListControlItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TListControlItem;
    class function ClassToVar(AClass: TListControlItem_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TListControlItem_sc;
  end;

  TListItemsSortType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TListItemsSortType): OleVariant;
    class function FromVar(const AValue: OleVariant): TListItemsSortType;
  end;

  TListCompareEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    function Handler(List: TListControlItems; Item1: TListControlItem;
      Item2: TListControlItem): Integer;
  end;

  TListCompareEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TListCompareEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TListCompareEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TListCompareEvent;
  end;

  TListControlItems_sc = class of TListControlItems;
  TListControlItems_sw = class(TOwnedCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TListControlItems): OleVariant;
    class function FromVar(const AValue: OleVariant): TListControlItems;
    class function ClassToVar(AClass: TListControlItems_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TListControlItems_sc;
  end;

  TGetItemCountEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TCustomListAction; var Count: Integer);
  end;

  TGetItemCountEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetItemCountEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetItemCountEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetItemCountEvent;
  end;

  TItemSelectedEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TCustomListAction; Control: TControl);
  end;

  TItemSelectedEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TItemSelectedEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TItemSelectedEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TItemSelectedEvent;
  end;

  TCustomListAction_sc = class of TCustomListAction;
  TCustomListAction_sw = class(TCustomAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomListAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomListAction;
    class function ClassToVar(AClass: TCustomListAction_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomListAction_sc;
  end;

  TCustomVirtualListAction_sc = class of TCustomVirtualListAction;
  TCustomVirtualListAction_sw = class(TCustomListAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomVirtualListAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomVirtualListAction;
    class function ClassToVar(AClass: TCustomVirtualListAction_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomVirtualListAction_sc;
  end;

  TVirtualListAction_sc = class of TVirtualListAction;
  TVirtualListAction_sw = class(TCustomVirtualListAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TVirtualListAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TVirtualListAction;
    class function ClassToVar(AClass: TVirtualListAction_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TVirtualListAction_sc;
  end;

  TGetItemEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TCustomListAction; const Index: Integer;
      var Item: TListControlItem);
  end;

  TGetItemEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetItemEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetItemEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetItemEvent;
  end;

  TStaticListItems_sc = class of TStaticListItems;
  TStaticListItems_sw = class(TListControlItems_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStaticListItems): OleVariant;
    class function FromVar(const AValue: OleVariant): TStaticListItems;
    class function ClassToVar(AClass: TStaticListItems_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStaticListItems_sc;
  end;

  TListControlItemClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TListControlItemClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TListControlItemClass;
  end;

  TCustomStaticListAction_sc = class of TCustomStaticListAction;
  TCustomStaticListAction_sw = class(TCustomListAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomStaticListAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomStaticListAction;
    class function ClassToVar(AClass: TCustomStaticListAction_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomStaticListAction_sc;
  end;

  TStaticListAction_sc = class of TStaticListAction;
  TStaticListAction_sw = class(TCustomStaticListAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStaticListAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TStaticListAction;
    class function ClassToVar(AClass: TStaticListAction_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStaticListAction_sc;
  end;

  TListActionLink_sc = class of TListActionLink;
  TListActionLink_sw = class(TWinControlActionLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TListActionLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TListActionLink;
    class function ClassToVar(AClass: TListActionLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TListActionLink_sc;
  end;


{ Unit wrapper }

type
  ListActns_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TCustomListAction_sacc = class(TCustomListAction);

{ TListControlItem_sw }

function TListControlItem_Caption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Caption: string read <getter> write <setter>;

  if IsGet then
    Result := TListControlItem(AObj).Caption
  else
    TListControlItem(AObj).Caption := string(AArgs[0]);
end;

function TListControlItem_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImageIndex: TImageIndex read <getter> write <set...

  if IsGet then
    Result := TImageIndex_sw.ToVar(TListControlItem(AObj).ImageIndex)
  else
    TListControlItem(AObj).ImageIndex := TImageIndex_sw.FromVar(AArgs[0]);
end;

class function TListControlItem_sw.GetTypeName: WideString;
begin
  Result := 'TListControlItem';
end;

class function TListControlItem_sw.GetWrappedClass: TClass;
begin
  Result := TListControlItem;
end;

class procedure TListControlItem_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Caption', TListControlItem_Caption_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('ImageIndex', TListControlItem_ImageIndex_si, TImageIndex_sw, True, True, 0, False, False);
end;

class function TListControlItem_sw.ToVar(
  const AValue: TListControlItem): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TListControlItem_sw.FromVar(
  const AValue: OleVariant): TListControlItem;
begin
  Result := TListControlItem(ConvFromVar(AValue, TListControlItem));
end;

class function TListControlItem_sw.ClassToVar(
  AClass: TListControlItem_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TListControlItem_sw.ClassFromVar(
  const AClass: OleVariant): TListControlItem_sc;
begin
  Result := TListControlItem_sc(ConvClsFromVar(AClass, TListControlItem));
end;

{ TListItemsSortType_sw }

class function TListItemsSortType_sw.GetTypeName: WideString;
begin
  Result := 'TListItemsSortType';
end;

class procedure TListItemsSortType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'stNone'; Value: Integer({$IFDEF LMDSCT_12}TListItemsSortType.{$ENDIF}stNone)),
    (Name: 'stData'; Value: Integer({$IFDEF LMDSCT_12}TListItemsSortType.{$ENDIF}stData)),
    (Name: 'stText'; Value: Integer({$IFDEF LMDSCT_12}TListItemsSortType.{$ENDIF}stText)),
    (Name: 'stBoth'; Value: Integer({$IFDEF LMDSCT_12}TListItemsSortType.{$ENDIF}stBoth))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TListItemsSortType_sw.ToVar(
  const AValue: TListItemsSortType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TListItemsSortType_sw.FromVar(
  const AValue: OleVariant): TListItemsSortType;
begin
  Result := TListItemsSortType(Integer(AValue));
end;

{ TListCompareEvent_sh }

function TListCompareEvent_sh.GetHandler: TMethod;
var
  hdr: TListCompareEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

function TListCompareEvent_sh.Handler(List: TListControlItems;
  Item1: TListControlItem; Item2: TListControlItem): Integer;
var
  args: array[0..2] of OleVariant;
begin
  // function (List: TListControlItems; Item1: TListControlIte...

  args[0] := TListControlItems_sw.ToVar(List);
  args[1] := TListControlItem_sw.ToVar(Item1);
  args[2] := TListControlItem_sw.ToVar(Item2);
  Result := Integer(Self.Owner.RunProc(Self.ProcName, args));
end;

{ TListCompareEvent_sw }

class function TListCompareEvent_sw.GetTypeName: WideString;
begin
  Result := 'TListCompareEvent';
end;

class function TListCompareEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TListCompareEvent_sh;
end;

class function TListCompareEvent_sw.ToVar(
  const AValue: TListCompareEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TListCompareEvent_sw.FromVar(
  const AValue: OleVariant): TListCompareEvent;
begin
  Result := TListCompareEvent(ConvFromVar(AValue));
end;

class function TListCompareEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TListCompareEvent;
var
  hdlr: TListCompareEvent_sh;
begin
  hdlr   := TListCompareEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TListCompareEvent_sw));
  Result := hdlr.Handler;
end;

{ TListControlItems_sw }

function TListControlItems_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AOwner: TPersistent; ItemClass: TColle...

  Result := TListControlItems_sw.ToVar(TListControlItems_sc(AObj).Create(
    TPersistent_sw.FromVar(AArgs[0]), TCollectionItemClass_sw.FromVar(AArgs[1])));
end;

function TListControlItems_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add: TListControlItem;

  Result := TListControlItem_sw.ToVar(TListControlItems(AObj).Add());
end;

function TListControlItems_Sort_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Sort;

  TListControlItems(AObj).Sort();
end;

function TListControlItems_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[const Index: Integer]: TListControlItem re...

  Result := TListControlItem_sw.ToVar(TListControlItems(AObj).Items[Integer(
    AArgs[0])]);
end;

function TListControlItems_CaseSensitive_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CaseSensitive: Boolean read <getter> write <sett...

  if IsGet then
    Result := TListControlItems(AObj).CaseSensitive
  else
    TListControlItems(AObj).CaseSensitive := Boolean(AArgs[0]);
end;

function TListControlItems_SortType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SortType: TListItemsSortType read <getter> write...

  if IsGet then
    Result := TListItemsSortType_sw.ToVar(TListControlItems(AObj).SortType)
  else
    TListControlItems(AObj).SortType := TListItemsSortType_sw.FromVar(AArgs[0]);
end;

function TListControlItems_OnCompare_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCompare: TListCompareEvent read <getter> write...

  if IsGet then
    Result := TListCompareEvent_sw.ToVar(TListControlItems(AObj).OnCompare)
  else
    TListControlItems(AObj).OnCompare := TListCompareEvent_sw.FromVar(AArgs[0]);
end;

class function TListControlItems_sw.GetTypeName: WideString;
begin
  Result := 'TListControlItems';
end;

class function TListControlItems_sw.GetWrappedClass: TClass;
begin
  Result := TListControlItems;
end;

class procedure TListControlItems_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TListControlItems_Add_si, TListControlItem_sw, 0, False);
  AData.AddProcedure('Sort', TListControlItems_Sort_si, 0, False);
  AData.AddProperty('Items', TListControlItems_Items_si, TListControlItem_sw, True, False, 1, False, True);
  AData.AddProperty('CaseSensitive', TListControlItems_CaseSensitive_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('SortType', TListControlItems_SortType_si, TListItemsSortType_sw, True, True, 0, False, False);
  AData.AddProperty('OnCompare', TListControlItems_OnCompare_si, TListCompareEvent_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TListControlItems_Create_si, 2, False);
end;

class function TListControlItems_sw.ToVar(
  const AValue: TListControlItems): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TListControlItems_sw.FromVar(
  const AValue: OleVariant): TListControlItems;
begin
  Result := TListControlItems(ConvFromVar(AValue, TListControlItems));
end;

class function TListControlItems_sw.ClassToVar(
  AClass: TListControlItems_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TListControlItems_sw.ClassFromVar(
  const AClass: OleVariant): TListControlItems_sc;
begin
  Result := TListControlItems_sc(ConvClsFromVar(AClass, TListControlItems));
end;

{ TGetItemCountEvent_sh }

function TGetItemCountEvent_sh.GetHandler: TMethod;
var
  hdr: TGetItemCountEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGetItemCountEvent_sh.Handler(Sender: TCustomListAction;
  var Count: Integer);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TCustomListAction; var Count: Integer)...

  v_1 := Count;
  args[0] := TCustomListAction_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Count := Integer(v_1);
end;

{ TGetItemCountEvent_sw }

class function TGetItemCountEvent_sw.GetTypeName: WideString;
begin
  Result := 'TGetItemCountEvent';
end;

class function TGetItemCountEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetItemCountEvent_sh;
end;

class function TGetItemCountEvent_sw.ToVar(
  const AValue: TGetItemCountEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetItemCountEvent_sw.FromVar(
  const AValue: OleVariant): TGetItemCountEvent;
begin
  Result := TGetItemCountEvent(ConvFromVar(AValue));
end;

class function TGetItemCountEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TGetItemCountEvent;
var
  hdlr: TGetItemCountEvent_sh;
begin
  hdlr   := TGetItemCountEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetItemCountEvent_sw));
  Result := hdlr.Handler;
end;

{ TItemSelectedEvent_sh }

function TItemSelectedEvent_sh.GetHandler: TMethod;
var
  hdr: TItemSelectedEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TItemSelectedEvent_sh.Handler(Sender: TCustomListAction;
  Control: TControl);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TCustomListAction; Control: TControl) ...

  args[0] := TCustomListAction_sw.ToVar(Sender);
  args[1] := TControl_sw.ToVar(Control);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TItemSelectedEvent_sw }

class function TItemSelectedEvent_sw.GetTypeName: WideString;
begin
  Result := 'TItemSelectedEvent';
end;

class function TItemSelectedEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TItemSelectedEvent_sh;
end;

class function TItemSelectedEvent_sw.ToVar(
  const AValue: TItemSelectedEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TItemSelectedEvent_sw.FromVar(
  const AValue: OleVariant): TItemSelectedEvent;
begin
  Result := TItemSelectedEvent(ConvFromVar(AValue));
end;

class function TItemSelectedEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TItemSelectedEvent;
var
  hdlr: TItemSelectedEvent_sh;
begin
  hdlr   := TItemSelectedEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TItemSelectedEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomListAction_sw }

function TCustomListAction_Images_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Images: TCustomImageList read <getter>...

  if IsGet then
    Result := TCustomImageList_sw.ToVar(TCustomListAction_sacc(
      TCustomListAction(AObj)).Images)
  else
    TCustomListAction_sacc(TCustomListAction(AObj)).Images := 
      TCustomImageList_sw.FromVar(AArgs[0]);
end;

function TCustomListAction_Loading_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Loading: Boolean read <getter>;

  Result := TCustomListAction_sacc(TCustomListAction(AObj)).Loading;
end;

function TCustomListAction_OnGetItemCount_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnGetItemCount: TGetItemCountEvent rea...

  if IsGet then
    Result := TGetItemCountEvent_sw.ToVar(TCustomListAction_sacc(
      TCustomListAction(AObj)).OnGetItemCount)
  else
    TCustomListAction_sacc(TCustomListAction(AObj)).OnGetItemCount := 
      TGetItemCountEvent_sw.FromVar(AArgs[0]);
end;

function TCustomListAction_OnItemSelected_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnItemSelected: TItemSelectedEvent rea...

  if IsGet then
    Result := TItemSelectedEvent_sw.ToVar(TCustomListAction_sacc(
      TCustomListAction(AObj)).OnItemSelected)
  else
    TCustomListAction_sacc(TCustomListAction(AObj)).OnItemSelected := 
      TItemSelectedEvent_sw.FromVar(AArgs[0]);
end;

function TCustomListAction_Active_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Active: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomListAction(AObj).Active
  else
    TCustomListAction(AObj).Active := Boolean(AArgs[0]);
end;

function TCustomListAction_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Count: Integer read <getter>;

  Result := TCustomListAction(AObj).Count;
end;

function TCustomListAction_ItemIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ItemIndex: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomListAction(AObj).ItemIndex
  else
    TCustomListAction(AObj).ItemIndex := Integer(AArgs[0]);
end;

function TCustomListAction_Strings_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Strings[Index: Integer]: string read <getter> wr...

  if IsGet then
    Result := TCustomListAction(AObj).Strings[Integer(AArgs[0])]
  else
    TCustomListAction(AObj).Strings[Integer(AArgs[0])] := string(AArgs[1]);
end;

class function TCustomListAction_sw.GetTypeName: WideString;
begin
  Result := 'TCustomListAction';
end;

class function TCustomListAction_sw.GetWrappedClass: TClass;
begin
  Result := TCustomListAction;
end;

class procedure TCustomListAction_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Images', TCustomListAction_Images_si, TCustomImageList_sw, True, True, 0, True, False);
  AData.AddProperty('Loading', TCustomListAction_Loading_si, Boolean_sw, True, False, 0, True, False);
  AData.AddProperty('OnGetItemCount', TCustomListAction_OnGetItemCount_si, TGetItemCountEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnItemSelected', TCustomListAction_OnItemSelected_si, TItemSelectedEvent_sw, True, True, 0, True, False);
  AData.AddProperty('Active', TCustomListAction_Active_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Count', TCustomListAction_Count_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('ItemIndex', TCustomListAction_ItemIndex_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Strings', TCustomListAction_Strings_si, string_sw, True, True, 1, False, True);
end;

class function TCustomListAction_sw.ToVar(
  const AValue: TCustomListAction): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomListAction_sw.FromVar(
  const AValue: OleVariant): TCustomListAction;
begin
  Result := TCustomListAction(ConvFromVar(AValue, TCustomListAction));
end;

class function TCustomListAction_sw.ClassToVar(
  AClass: TCustomListAction_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomListAction_sw.ClassFromVar(
  const AClass: OleVariant): TCustomListAction_sc;
begin
  Result := TCustomListAction_sc(ConvClsFromVar(AClass, TCustomListAction));
end;

{ TCustomVirtualListAction_sw }

class function TCustomVirtualListAction_sw.GetTypeName: WideString;
begin
  Result := 'TCustomVirtualListAction';
end;

class function TCustomVirtualListAction_sw.GetWrappedClass: TClass;
begin
  Result := TCustomVirtualListAction;
end;

class procedure TCustomVirtualListAction_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Count', False);
end;

class function TCustomVirtualListAction_sw.ToVar(
  const AValue: TCustomVirtualListAction): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomVirtualListAction_sw.FromVar(
  const AValue: OleVariant): TCustomVirtualListAction;
begin
  Result := TCustomVirtualListAction(ConvFromVar(AValue, 
    TCustomVirtualListAction));
end;

class function TCustomVirtualListAction_sw.ClassToVar(
  AClass: TCustomVirtualListAction_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomVirtualListAction_sw.ClassFromVar(
  const AClass: OleVariant): TCustomVirtualListAction_sc;
begin
  Result := TCustomVirtualListAction_sc(ConvClsFromVar(AClass, 
    TCustomVirtualListAction));
end;

{ TVirtualListAction_sw }

class function TVirtualListAction_sw.GetTypeName: WideString;
begin
  Result := 'TVirtualListAction';
end;

class function TVirtualListAction_sw.GetWrappedClass: TClass;
begin
  Result := TVirtualListAction;
end;

class procedure TVirtualListAction_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Active', False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('HelpContext', False);
  AData.AddPropertyRedecl('Hint', False);
  AData.AddPropertyRedecl('Images', False);
  AData.AddPropertyRedecl('ItemIndex', False);
  AData.AddPropertyRedecl('ShortCut', False);
  AData.AddPropertyRedecl('SecondaryShortCuts', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnGetItem', False);
  AData.AddPropertyRedecl('OnGetItemCount', False);
  AData.AddPropertyRedecl('OnItemSelected', False);
  AData.AddPropertyRedecl('OnHint', False);
end;

class function TVirtualListAction_sw.ToVar(
  const AValue: TVirtualListAction): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TVirtualListAction_sw.FromVar(
  const AValue: OleVariant): TVirtualListAction;
begin
  Result := TVirtualListAction(ConvFromVar(AValue, TVirtualListAction));
end;

class function TVirtualListAction_sw.ClassToVar(
  AClass: TVirtualListAction_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TVirtualListAction_sw.ClassFromVar(
  const AClass: OleVariant): TVirtualListAction_sc;
begin
  Result := TVirtualListAction_sc(ConvClsFromVar(AClass, TVirtualListAction));
end;

{ TGetItemEvent_sh }

function TGetItemEvent_sh.GetHandler: TMethod;
var
  hdr: TGetItemEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGetItemEvent_sh.Handler(Sender: TCustomListAction;
  const Index: Integer; var Item: TListControlItem);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TCustomListAction; const Index: Intege...

  v_1 := TListControlItem_sw.ToVar(Item);
  args[0] := TCustomListAction_sw.ToVar(Sender);
  args[1] := Index;
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Item := TListControlItem_sw.FromVar(v_1);
end;

{ TGetItemEvent_sw }

class function TGetItemEvent_sw.GetTypeName: WideString;
begin
  Result := 'TGetItemEvent';
end;

class function TGetItemEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetItemEvent_sh;
end;

class function TGetItemEvent_sw.ToVar(const AValue: TGetItemEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetItemEvent_sw.FromVar(
  const AValue: OleVariant): TGetItemEvent;
begin
  Result := TGetItemEvent(ConvFromVar(AValue));
end;

class function TGetItemEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TGetItemEvent;
var
  hdlr: TGetItemEvent_sh;
begin
  hdlr   := TGetItemEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetItemEvent_sw));
  Result := hdlr.Handler;
end;

{ TStaticListItems_sw }

class function TStaticListItems_sw.GetTypeName: WideString;
begin
  Result := 'TStaticListItems';
end;

class function TStaticListItems_sw.GetWrappedClass: TClass;
begin
  Result := TStaticListItems;
end;

class procedure TStaticListItems_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TStaticListItems_sw.ToVar(
  const AValue: TStaticListItems): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStaticListItems_sw.FromVar(
  const AValue: OleVariant): TStaticListItems;
begin
  Result := TStaticListItems(ConvFromVar(AValue, TStaticListItems));
end;

class function TStaticListItems_sw.ClassToVar(
  AClass: TStaticListItems_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStaticListItems_sw.ClassFromVar(
  const AClass: OleVariant): TStaticListItems_sc;
begin
  Result := TStaticListItems_sc(ConvClsFromVar(AClass, TStaticListItems));
end;

{ TListControlItemClass_sw }

class function TListControlItemClass_sw.GetTypeName: WideString;
begin
  Result := 'TListControlItemClass';
end;

class function TListControlItemClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TListControlItem;
end;

class function TListControlItemClass_sw.ToVar(
  const AValue: TListControlItemClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TListControlItemClass_sw.FromVar(
  const AValue: OleVariant): TListControlItemClass;
begin
  Result := TListControlItemClass(ConvFromVar(AValue, TListControlItem));
end;

{ TCustomStaticListAction_sw }

function TCustomStaticListAction_OnGetItem_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnGetItem: TGetItemEvent read <getter> write <se...

  if IsGet then
    Result := TGetItemEvent_sw.ToVar(TCustomStaticListAction(AObj).OnGetItem)
  else
    TCustomStaticListAction(AObj).OnGetItem := TGetItemEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomStaticListAction_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items: TStaticListItems read <getter> write <set...

  if IsGet then
    Result := TStaticListItems_sw.ToVar(TCustomStaticListAction(AObj).Items)
  else
    TCustomStaticListAction(AObj).Items := TStaticListItems_sw.FromVar(
      AArgs[0]);
end;

class function TCustomStaticListAction_sw.GetTypeName: WideString;
begin
  Result := 'TCustomStaticListAction';
end;

class function TCustomStaticListAction_sw.GetWrappedClass: TClass;
begin
  Result := TCustomStaticListAction;
end;

class procedure TCustomStaticListAction_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Count', False);
  AData.AddProperty('OnGetItem', TCustomStaticListAction_OnGetItem_si, TGetItemEvent_sw, True, True, 0, False, False);
  AData.AddProperty('Items', TCustomStaticListAction_Items_si, TStaticListItems_sw, True, True, 0, False, False);
end;

class function TCustomStaticListAction_sw.ToVar(
  const AValue: TCustomStaticListAction): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomStaticListAction_sw.FromVar(
  const AValue: OleVariant): TCustomStaticListAction;
begin
  Result := TCustomStaticListAction(ConvFromVar(AValue, 
    TCustomStaticListAction));
end;

class function TCustomStaticListAction_sw.ClassToVar(
  AClass: TCustomStaticListAction_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomStaticListAction_sw.ClassFromVar(
  const AClass: OleVariant): TCustomStaticListAction_sc;
begin
  Result := TCustomStaticListAction_sc(ConvClsFromVar(AClass, 
    TCustomStaticListAction));
end;

{ TStaticListAction_sw }

class function TStaticListAction_sw.GetTypeName: WideString;
begin
  Result := 'TStaticListAction';
end;

class function TStaticListAction_sw.GetWrappedClass: TClass;
begin
  Result := TStaticListAction;
end;

class procedure TStaticListAction_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Active', False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('HelpContext', False);
  AData.AddPropertyRedecl('Hint', False);
  AData.AddPropertyRedecl('Images', False);
  AData.AddPropertyRedecl('ItemIndex', False);
  AData.AddPropertyRedecl('Items', False);
  AData.AddPropertyRedecl('ShortCut', False);
  AData.AddPropertyRedecl('SecondaryShortCuts', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnGetItem', False);
  AData.AddPropertyRedecl('OnItemSelected', False);
  AData.AddPropertyRedecl('OnHint', False);
  AData.AddPropertyRedecl('OnUpdate', False);
end;

class function TStaticListAction_sw.ToVar(
  const AValue: TStaticListAction): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStaticListAction_sw.FromVar(
  const AValue: OleVariant): TStaticListAction;
begin
  Result := TStaticListAction(ConvFromVar(AValue, TStaticListAction));
end;

class function TStaticListAction_sw.ClassToVar(
  AClass: TStaticListAction_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStaticListAction_sw.ClassFromVar(
  const AClass: OleVariant): TStaticListAction_sc;
begin
  Result := TStaticListAction_sc(ConvClsFromVar(AClass, TStaticListAction));
end;

{ TListActionLink_sw }

class function TListActionLink_sw.GetTypeName: WideString;
begin
  Result := 'TListActionLink';
end;

class function TListActionLink_sw.GetWrappedClass: TClass;
begin
  Result := TListActionLink;
end;

class procedure TListActionLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TListActionLink_sw.ToVar(
  const AValue: TListActionLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TListActionLink_sw.FromVar(
  const AValue: OleVariant): TListActionLink;
begin
  Result := TListActionLink(ConvFromVar(AValue, TListActionLink));
end;

class function TListActionLink_sw.ClassToVar(
  AClass: TListActionLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TListActionLink_sw.ClassFromVar(
  const AClass: OleVariant): TListActionLink_sc;
begin
  Result := TListActionLink_sc(ConvClsFromVar(AClass, TListActionLink));
end;

{ ListActns_sw }

function ListActns_TListControlItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListControlItem = class(TCollectionItem);

  Result := TLMDUnitWrapper.TypeToVar(TListControlItem_sw);
end;

function ListActns_TListItemsSortType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListItemsSortType = (stNone, stData, stText, stBoth);

  Result := TLMDUnitWrapper.TypeToVar(TListItemsSortType_sw);
end;

function ListActns_TListCompareEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListCompareEvent = function (List: TListControlItem...

  Result := TLMDUnitWrapper.TypeToVar(TListCompareEvent_sw);
end;

function ListActns_TListControlItems_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListControlItems = class(TOwnedCollection);

  Result := TLMDUnitWrapper.TypeToVar(TListControlItems_sw);
end;

function ListActns_TGetItemCountEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetItemCountEvent = procedure (Sender: TCustomListA...

  Result := TLMDUnitWrapper.TypeToVar(TGetItemCountEvent_sw);
end;

function ListActns_TItemSelectedEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TItemSelectedEvent = procedure (Sender: TCustomListA...

  Result := TLMDUnitWrapper.TypeToVar(TItemSelectedEvent_sw);
end;

function ListActns_TCustomListAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomListAction = class(TCustomAction);

  Result := TLMDUnitWrapper.TypeToVar(TCustomListAction_sw);
end;

function ListActns_TCustomVirtualListAction_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomVirtualListAction = class(TCustomListAction);

  Result := TLMDUnitWrapper.TypeToVar(TCustomVirtualListAction_sw);
end;

function ListActns_TVirtualListAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVirtualListAction = class(TCustomVirtualListAction);

  Result := TLMDUnitWrapper.TypeToVar(TVirtualListAction_sw);
end;

function ListActns_TGetItemEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetItemEvent = procedure (Sender: TCustomListAction...

  Result := TLMDUnitWrapper.TypeToVar(TGetItemEvent_sw);
end;

function ListActns_TStaticListItems_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStaticListItems = class(TListControlItems);

  Result := TLMDUnitWrapper.TypeToVar(TStaticListItems_sw);
end;

function ListActns_TListControlItemClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListControlItemClass = class of TListControlItem;

  Result := TLMDUnitWrapper.TypeToVar(TListControlItemClass_sw);
end;

function ListActns_TCustomStaticListAction_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomStaticListAction = class(TCustomListAction);

  Result := TLMDUnitWrapper.TypeToVar(TCustomStaticListAction_sw);
end;

function ListActns_TStaticListAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStaticListAction = class(TCustomStaticListAction);

  Result := TLMDUnitWrapper.TypeToVar(TStaticListAction_sw);
end;

function ListActns_TListActionLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListActionLink = class(TWinControlActionLink);

  Result := TLMDUnitWrapper.TypeToVar(TListActionLink_sw);
end;

class function ListActns_sw.GetUnitName: WideString;
begin
  Result := 'ListActns';
end;

class procedure ListActns_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TListControlItem_sw, ListActns_TListControlItem_si);
  AData.AddType(TListItemsSortType_sw, ListActns_TListItemsSortType_si);
  AData.AddType(TListCompareEvent_sw, ListActns_TListCompareEvent_si);
  AData.AddType(TListControlItems_sw, ListActns_TListControlItems_si);
  AData.AddType(TGetItemCountEvent_sw, ListActns_TGetItemCountEvent_si);
  AData.AddType(TItemSelectedEvent_sw, ListActns_TItemSelectedEvent_si);
  AData.AddType(TCustomListAction_sw, ListActns_TCustomListAction_si);
  AData.AddType(TCustomVirtualListAction_sw, ListActns_TCustomVirtualListAction_si);
  AData.AddType(TVirtualListAction_sw, ListActns_TVirtualListAction_si);
  AData.AddType(TGetItemEvent_sw, ListActns_TGetItemEvent_si);
  AData.AddType(TStaticListItems_sw, ListActns_TStaticListItems_si);
  AData.AddType(TListControlItemClass_sw, ListActns_TListControlItemClass_si);
  AData.AddType(TCustomStaticListAction_sw, ListActns_TCustomStaticListAction_si);
  AData.AddType(TStaticListAction_sw, ListActns_TStaticListAction_si);
  AData.AddType(TListActionLink_sw, ListActns_TListActionLink_si);
end;

class function ListActns_sw.ToVar(
  AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(ListActns_sw);
end;

initialization
  RegisterUnitWrapper(ListActns_sw);
  RegisterClassWrapper(TListControlItem_sw);
  RegisterClassWrapper(TListControlItems_sw);
  RegisterClassWrapper(TCustomListAction_sw);
  RegisterClassWrapper(TCustomVirtualListAction_sw);
  RegisterClassWrapper(TVirtualListAction_sw);
  RegisterClassWrapper(TStaticListItems_sw);
  RegisterClassWrapper(TCustomStaticListAction_sw);
  RegisterClassWrapper(TStaticListAction_sw);
  RegisterClassWrapper(TListActionLink_sw);
  RegisterEventWrapper(TypeInfo(TListCompareEvent), TListCompareEvent_sw);
  RegisterEventWrapper(TypeInfo(TGetItemCountEvent), TGetItemCountEvent_sw);
  RegisterEventWrapper(TypeInfo(TItemSelectedEvent), TItemSelectedEvent_sw);
  RegisterEventWrapper(TypeInfo(TGetItemEvent), TGetItemEvent_sw);

end.
