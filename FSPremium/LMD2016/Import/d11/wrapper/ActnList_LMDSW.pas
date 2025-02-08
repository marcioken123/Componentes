unit ActnList_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'ActnList' unit.
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
  LMDSctSysWrappers, Types, Classes, Messages, ImgList, Contnrs, ActnList,
  Classes_LMDSW, Messages_LMDSW, ImgList_LMDSW, Contnrs_LMDSW;


{ Type wrappers }

type
  TContainedAction_sw = class;
  TContainedActionClass_sw = class;
  TActionListEnumerator_sw = class;
  TCustomActionList_sw = class;
  TActionList_sw = class;
  TShortCutList_sw = class;
  TCustomAction_sw = class;
  TAction_sw = class;
  TActionLink_sw = class;
  TActionLinkClass_sw = class;

  TContainedAction_sc = class of TContainedAction;
  TContainedAction_sw = class(TBasicAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TContainedAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TContainedAction;
    class function ClassToVar(AClass: TContainedAction_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TContainedAction_sc;
  end;

  TContainedActionClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TContainedActionClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TContainedActionClass;
  end;

  TActionListEnumerator_sc = class of TActionListEnumerator;
  TActionListEnumerator_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TActionListEnumerator): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionListEnumerator;
    class function ClassToVar(AClass: TActionListEnumerator_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TActionListEnumerator_sc;
  end;

  TActionEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Action: TBasicAction; var Handled: Boolean);
  end;

  TActionEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TActionEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TActionEvent;
  end;

  TActionListState_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TActionListState): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionListState;
  end;

  TCustomActionList_sc = class of TCustomActionList;
  TCustomActionList_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomActionList): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomActionList;
    class function ClassToVar(AClass: TCustomActionList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomActionList_sc;
  end;

  TActionList_sc = class of TActionList;
  TActionList_sw = class(TCustomActionList_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TActionList): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionList;
    class function ClassToVar(AClass: TActionList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TActionList_sc;
  end;

  TShortCutList_sc = class of TShortCutList;
  TShortCutList_sw = class(TStringList_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TShortCutList): OleVariant;
    class function FromVar(const AValue: OleVariant): TShortCutList;
    class function ClassToVar(AClass: TShortCutList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TShortCutList_sc;
  end;

  THintEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(var HintStr: string; var CanShow: Boolean);
  end;

  THintEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: THintEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): THintEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): THintEvent;
  end;

  TCustomAction_sc = class of TCustomAction;
  TCustomAction_sw = class(TContainedAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomAction;
    class function ClassToVar(AClass: TCustomAction_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomAction_sc;
  end;

  TAction_sc = class of TAction;
  TAction_sw = class(TCustomAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TAction;
    class function ClassToVar(AClass: TAction_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TAction_sc;
  end;

  TActionLink_sc = class of TActionLink;
  TActionLink_sw = class(TBasicActionLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TActionLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionLink;
    class function ClassToVar(AClass: TActionLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TActionLink_sc;
  end;

  TActionLinkClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TActionLinkClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionLinkClass;
  end;


{ Unit wrapper }

type
  ActnList_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TCustomActionList_sacc = class(TCustomActionList);
  TCustomAction_sacc = class(TCustomAction);

{ TContainedAction_sw }

function TContainedAction_ActionList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionList: TCustomActionList read <getter> writ...

  if IsGet then
    Result := TCustomActionList_sw.ToVar(TContainedAction(AObj).ActionList)
  else
    TContainedAction(AObj).ActionList := TCustomActionList_sw.FromVar(AArgs[0]);
end;

function TContainedAction_Index_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Index: Integer read <getter> write <setter>;

  if IsGet then
    Result := TContainedAction(AObj).Index
  else
    TContainedAction(AObj).Index := Integer(AArgs[0]);
end;

function TContainedAction_Category_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Category: string read <getter> write <setter>;

  if IsGet then
    Result := TContainedAction(AObj).Category
  else
    TContainedAction(AObj).Category := string(AArgs[0]);
end;

class function TContainedAction_sw.GetTypeName: WideString;
begin
  Result := 'TContainedAction';
end;

class function TContainedAction_sw.GetWrappedClass: TClass;
begin
  Result := TContainedAction;
end;

class procedure TContainedAction_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ActionList', TContainedAction_ActionList_si, TCustomActionList_sw, True, True, 0, False);
  AData.AddProperty('Index', TContainedAction_Index_si, Integer_sw, True, True, 0, False);
  AData.AddProperty('Category', TContainedAction_Category_si, string_sw, True, True, 0, False);
end;

class function TContainedAction_sw.ToVar(
  const AValue: TContainedAction): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TContainedAction_sw.FromVar(
  const AValue: OleVariant): TContainedAction;
begin
  Result := TContainedAction(ConvFromVar(AValue, TContainedAction));
end;

class function TContainedAction_sw.ClassToVar(
  AClass: TContainedAction_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TContainedAction_sw.ClassFromVar(
  const AClass: OleVariant): TContainedAction_sc;
begin
  Result := TContainedAction_sc(ConvClsFromVar(AClass, TContainedAction));
end;

{ TContainedActionClass_sw }

class function TContainedActionClass_sw.GetTypeName: WideString;
begin
  Result := 'TContainedActionClass';
end;

class function TContainedActionClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TContainedAction;
end;

class function TContainedActionClass_sw.ToVar(
  const AValue: TContainedActionClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TContainedActionClass_sw.FromVar(
  const AValue: OleVariant): TContainedActionClass;
begin
  Result := TContainedActionClass(ConvFromVar(AValue, TContainedAction));
end;

{ TActionListEnumerator_sw }

function TActionListEnumerator_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AActionList: TCustomActionList);

  Result := TActionListEnumerator_sw.ToVar(TActionListEnumerator_sc(AObj).
    Create(TCustomActionList_sw.FromVar(AArgs[0])));
end;

function TActionListEnumerator_GetCurrent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetCurrent: TContainedAction;

  Result := TContainedAction_sw.ToVar(TActionListEnumerator(AObj).GetCurrent());
end;

function TActionListEnumerator_MoveNext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MoveNext: Boolean;

  Result := TActionListEnumerator(AObj).MoveNext();
end;

function TActionListEnumerator_Current_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Current: TContainedAction read <getter>;

  Result := TContainedAction_sw.ToVar(TActionListEnumerator(AObj).Current);
end;

class function TActionListEnumerator_sw.GetTypeName: WideString;
begin
  Result := 'TActionListEnumerator';
end;

class function TActionListEnumerator_sw.GetWrappedClass: TClass;
begin
  Result := TActionListEnumerator;
end;

class procedure TActionListEnumerator_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('GetCurrent', TActionListEnumerator_GetCurrent_si, TContainedAction_sw, 0, False);
  AData.AddFunction('MoveNext', TActionListEnumerator_MoveNext_si, Boolean_sw, 0, False);
  AData.AddProperty('Current', TActionListEnumerator_Current_si, TContainedAction_sw, True, False, 0, False);

  { Class members }

  AData.AddConstructor('Create', TActionListEnumerator_Create_si, 1, False);
end;

class function TActionListEnumerator_sw.ToVar(
  const AValue: TActionListEnumerator): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionListEnumerator_sw.FromVar(
  const AValue: OleVariant): TActionListEnumerator;
begin
  Result := TActionListEnumerator(ConvFromVar(AValue, TActionListEnumerator));
end;

class function TActionListEnumerator_sw.ClassToVar(
  AClass: TActionListEnumerator_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TActionListEnumerator_sw.ClassFromVar(
  const AClass: OleVariant): TActionListEnumerator_sc;
begin
  Result := TActionListEnumerator_sc(ConvClsFromVar(AClass, 
    TActionListEnumerator));
end;

{ TActionEvent_sh }

function TActionEvent_sh.GetHandler: TMethod;
var
  hdr: TActionEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TActionEvent_sh.Handler(Action: TBasicAction; var Handled: Boolean);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Action: TBasicAction; var Handled: Boolean) of...

  v_1 := Handled;
  args[0] := TBasicAction_sw.ToVar(Action);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Handled := Boolean(v_1);
end;

{ TActionEvent_sw }

class function TActionEvent_sw.GetTypeName: WideString;
begin
  Result := 'TActionEvent';
end;

class function TActionEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TActionEvent_sh;
end;

class function TActionEvent_sw.ToVar(const AValue: TActionEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TActionEvent_sw.FromVar(const AValue: OleVariant): TActionEvent;
begin
  Result := TActionEvent(ConvFromVar(AValue));
end;

class function TActionEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TActionEvent;
var
  hdlr: TActionEvent_sh;
begin
  hdlr   := TActionEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TActionEvent_sw));
  Result := hdlr.Handler;
end;

{ TActionListState_sw }

class function TActionListState_sw.GetTypeName: WideString;
begin
  Result := 'TActionListState';
end;

class function TActionListState_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TActionListState);
end;

class function TActionListState_sw.ToVar(
  const AValue: TActionListState): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TActionListState_sw.FromVar(
  const AValue: OleVariant): TActionListState;
begin
  Result := TActionListState(Integer(AValue));
end;

{ TCustomActionList_sw }

function TCustomActionList_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnChange: TNotifyEvent read <getter> w...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomActionList_sacc(TCustomActionList(
      AObj)).OnChange)
  else
    TCustomActionList_sacc(TCustomActionList(AObj)).OnChange := TNotifyEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomActionList_OnExecute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnExecute: TActionEvent read <getter> ...

  if IsGet then
    Result := TActionEvent_sw.ToVar(TCustomActionList_sacc(TCustomActionList(
      AObj)).OnExecute)
  else
    TCustomActionList_sacc(TCustomActionList(AObj)).OnExecute := 
      TActionEvent_sw.FromVar(AArgs[0]);
end;

function TCustomActionList_OnUpdate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnUpdate: TActionEvent read <getter> w...

  if IsGet then
    Result := TActionEvent_sw.ToVar(TCustomActionList_sacc(TCustomActionList(
      AObj)).OnUpdate)
  else
    TCustomActionList_sacc(TCustomActionList(AObj)).OnUpdate := TActionEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomActionList_GetEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetEnumerator: TActionListEnumerator;

  Result := TActionListEnumerator_sw.ToVar(TCustomActionList(AObj).
    GetEnumerator());
end;

function TCustomActionList_Actions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Actions[Index: Integer]: TContainedAction read <...

  if IsGet then
    Result := TContainedAction_sw.ToVar(TCustomActionList(AObj).Actions[Integer(
      AArgs[0])])
  else
    TCustomActionList(AObj).Actions[Integer(AArgs[0])] := TContainedAction_sw.
      FromVar(AArgs[1]);
end;

function TCustomActionList_ActionCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionCount: Integer read <getter>;

  Result := TCustomActionList(AObj).ActionCount;
end;

function TCustomActionList_Images_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Images: TCustomImageList read <getter> write <se...

  if IsGet then
    Result := TCustomImageList_sw.ToVar(TCustomActionList(AObj).Images)
  else
    TCustomActionList(AObj).Images := TCustomImageList_sw.FromVar(AArgs[0]);
end;

function TCustomActionList_State_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property State: TActionListState read <getter> write <set...

  if IsGet then
    Result := TActionListState_sw.ToVar(TCustomActionList(AObj).State)
  else
    TCustomActionList(AObj).State := TActionListState_sw.FromVar(AArgs[0]);
end;

function TCustomActionList_OnStateChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnStateChange: TNotifyEvent read <getter> write ...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomActionList(AObj).OnStateChange)
  else
    TCustomActionList(AObj).OnStateChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TCustomActionList_sw.GetTypeName: WideString;
begin
  Result := 'TCustomActionList';
end;

class function TCustomActionList_sw.GetWrappedClass: TClass;
begin
  Result := TCustomActionList;
end;

class procedure TCustomActionList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('OnChange', TCustomActionList_OnChange_si, TNotifyEvent_sw, True, True, 0, True);
  AData.AddProperty('OnExecute', TCustomActionList_OnExecute_si, TActionEvent_sw, True, True, 0, True);
  AData.AddProperty('OnUpdate', TCustomActionList_OnUpdate_si, TActionEvent_sw, True, True, 0, True);
  AData.AddFunction('GetEnumerator', TCustomActionList_GetEnumerator_si, TActionListEnumerator_sw, 0, False);
  AData.AddProperty('Actions', TCustomActionList_Actions_si, TContainedAction_sw, True, True, 1, False);
  AData.AddProperty('ActionCount', TCustomActionList_ActionCount_si, Integer_sw, True, False, 0, False);
  AData.AddProperty('Images', TCustomActionList_Images_si, TCustomImageList_sw, True, True, 0, False);
  AData.AddProperty('State', TCustomActionList_State_si, TActionListState_sw, True, True, 0, False);
  AData.AddProperty('OnStateChange', TCustomActionList_OnStateChange_si, TNotifyEvent_sw, True, True, 0, False);
end;

class function TCustomActionList_sw.ToVar(
  const AValue: TCustomActionList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomActionList_sw.FromVar(
  const AValue: OleVariant): TCustomActionList;
begin
  Result := TCustomActionList(ConvFromVar(AValue, TCustomActionList));
end;

class function TCustomActionList_sw.ClassToVar(
  AClass: TCustomActionList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomActionList_sw.ClassFromVar(
  const AClass: OleVariant): TCustomActionList_sc;
begin
  Result := TCustomActionList_sc(ConvClsFromVar(AClass, TCustomActionList));
end;

{ TActionList_sw }

class function TActionList_sw.GetTypeName: WideString;
begin
  Result := 'TActionList';
end;

class function TActionList_sw.GetWrappedClass: TClass;
begin
  Result := TActionList;
end;

class procedure TActionList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Images');
  AData.AddPropertyRedecl('State');
  AData.AddPropertyRedecl('OnChange');
  AData.AddPropertyRedecl('OnExecute');
  AData.AddPropertyRedecl('OnStateChange');
  AData.AddPropertyRedecl('OnUpdate');
end;

class function TActionList_sw.ToVar(const AValue: TActionList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionList_sw.FromVar(const AValue: OleVariant): TActionList;
begin
  Result := TActionList(ConvFromVar(AValue, TActionList));
end;

class function TActionList_sw.ClassToVar(AClass: TActionList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TActionList_sw.ClassFromVar(
  const AClass: OleVariant): TActionList_sc;
begin
  Result := TActionList_sc(ConvClsFromVar(AClass, TActionList));
end;

{ TShortCutList_sw }

function TShortCutList_IndexOfShortCut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IndexOfShortCut(const Shortcut: TShortCut): Inte...

  Result := TShortCutList(AObj).IndexOfShortCut(TShortCut_sw.FromVar(AArgs[0]));
end;

function TShortCutList_ShortCuts_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShortCuts[Index: Integer]: TShortCut read <getter>;

  Result := TShortCut_sw.ToVar(TShortCutList(AObj).ShortCuts[Integer(
    AArgs[0])]);
end;

class function TShortCutList_sw.GetTypeName: WideString;
begin
  Result := 'TShortCutList';
end;

class function TShortCutList_sw.GetWrappedClass: TClass;
begin
  Result := TShortCutList;
end;

class procedure TShortCutList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('IndexOfShortCut', TShortCutList_IndexOfShortCut_si, Integer_sw, 1, False);
  AData.AddProperty('ShortCuts', TShortCutList_ShortCuts_si, TShortCut_sw, True, False, 1, False);
end;

class function TShortCutList_sw.ToVar(const AValue: TShortCutList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TShortCutList_sw.FromVar(
  const AValue: OleVariant): TShortCutList;
begin
  Result := TShortCutList(ConvFromVar(AValue, TShortCutList));
end;

class function TShortCutList_sw.ClassToVar(
  AClass: TShortCutList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TShortCutList_sw.ClassFromVar(
  const AClass: OleVariant): TShortCutList_sc;
begin
  Result := TShortCutList_sc(ConvClsFromVar(AClass, TShortCutList));
end;

{ THintEvent_sh }

function THintEvent_sh.GetHandler: TMethod;
var
  hdr: THintEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure THintEvent_sh.Handler(var HintStr: string; var CanShow: Boolean);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
  v_2: OleVariant;
begin
  // procedure (var HintStr: string; var CanShow: Boolean) of ...

  v_1 := HintStr;
  v_2 := CanShow;
  args[0] := MakeVarRef(v_1);
  args[1] := MakeVarRef(v_2);
  Self.Owner.RunProc(Self.ProcName, args);
  HintStr := string(v_1);
  CanShow := Boolean(v_2);
end;

{ THintEvent_sw }

class function THintEvent_sw.GetTypeName: WideString;
begin
  Result := 'THintEvent';
end;

class function THintEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := THintEvent_sh;
end;

class function THintEvent_sw.ToVar(const AValue: THintEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function THintEvent_sw.FromVar(const AValue: OleVariant): THintEvent;
begin
  Result := THintEvent(ConvFromVar(AValue));
end;

class function THintEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): THintEvent;
var
  hdlr: THintEvent_sh;
begin
  hdlr   := THintEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    THintEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomAction_sw }

function TCustomAction_SavedEnabledState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property SavedEnabledState: Boolean read <gette...

  if IsGet then
    Result := TCustomAction_sacc(TCustomAction(AObj)).SavedEnabledState
  else
    TCustomAction_sacc(TCustomAction(AObj)).SavedEnabledState := Boolean(
      AArgs[0]);
end;

function TCustomAction_DoHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: string;
begin
  // function DoHint(var HintStr: string): Boolean;

  v_1 := string(AArgs[0]);
  Result := TCustomAction(AObj).DoHint(v_1);
  AssignRefParam(AArgs[0], v_1);
end;

function TCustomAction_AutoCheck_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoCheck: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomAction(AObj).AutoCheck
  else
    TCustomAction(AObj).AutoCheck := Boolean(AArgs[0]);
end;

function TCustomAction_Caption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Caption: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomAction(AObj).Caption
  else
    TCustomAction(AObj).Caption := string(AArgs[0]);
end;

function TCustomAction_Checked_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Checked: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomAction(AObj).Checked
  else
    TCustomAction(AObj).Checked := Boolean(AArgs[0]);
end;

function TCustomAction_DisableIfNoHandler_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DisableIfNoHandler: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomAction(AObj).DisableIfNoHandler
  else
    TCustomAction(AObj).DisableIfNoHandler := Boolean(AArgs[0]);
end;

function TCustomAction_Enabled_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Enabled: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomAction(AObj).Enabled
  else
    TCustomAction(AObj).Enabled := Boolean(AArgs[0]);
end;

function TCustomAction_GroupIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GroupIndex: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomAction(AObj).GroupIndex
  else
    TCustomAction(AObj).GroupIndex := Integer(AArgs[0]);
end;

function TCustomAction_HelpContext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HelpContext: THelpContext read <getter> write <s...

  if IsGet then
    Result := THelpContext_sw.ToVar(TCustomAction(AObj).HelpContext)
  else
    TCustomAction(AObj).HelpContext := THelpContext_sw.FromVar(AArgs[0]);
end;

function TCustomAction_HelpKeyword_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HelpKeyword: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomAction(AObj).HelpKeyword
  else
    TCustomAction(AObj).HelpKeyword := string(AArgs[0]);
end;

function TCustomAction_HelpType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HelpType: THelpType read <getter> write <setter>;

  if IsGet then
    Result := THelpType_sw.ToVar(TCustomAction(AObj).HelpType)
  else
    TCustomAction(AObj).HelpType := THelpType_sw.FromVar(AArgs[0]);
end;

function TCustomAction_Hint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Hint: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomAction(AObj).Hint
  else
    TCustomAction(AObj).Hint := string(AArgs[0]);
end;

function TCustomAction_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImageIndex: TImageIndex read <getter> write <set...

  if IsGet then
    Result := TImageIndex_sw.ToVar(TCustomAction(AObj).ImageIndex)
  else
    TCustomAction(AObj).ImageIndex := TImageIndex_sw.FromVar(AArgs[0]);
end;

function TCustomAction_ShortCut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShortCut: TShortCut read <getter> write <setter>;

  if IsGet then
    Result := TShortCut_sw.ToVar(TCustomAction(AObj).ShortCut)
  else
    TCustomAction(AObj).ShortCut := TShortCut_sw.FromVar(AArgs[0]);
end;

function TCustomAction_SecondaryShortCuts_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SecondaryShortCuts: TShortCutList read <getter> ...

  if IsGet then
    Result := TShortCutList_sw.ToVar(TCustomAction(AObj).SecondaryShortCuts)
  else
    TCustomAction(AObj).SecondaryShortCuts := TShortCutList_sw.FromVar(
      AArgs[0]);
end;

function TCustomAction_Visible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Visible: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomAction(AObj).Visible
  else
    TCustomAction(AObj).Visible := Boolean(AArgs[0]);
end;

function TCustomAction_OnHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnHint: THintEvent read <getter> write <setter>;

  if IsGet then
    Result := THintEvent_sw.ToVar(TCustomAction(AObj).OnHint)
  else
    TCustomAction(AObj).OnHint := THintEvent_sw.FromVar(AArgs[0]);
end;

class function TCustomAction_sw.GetTypeName: WideString;
begin
  Result := 'TCustomAction';
end;

class function TCustomAction_sw.GetWrappedClass: TClass;
begin
  Result := TCustomAction;
end;

class procedure TCustomAction_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('SavedEnabledState', TCustomAction_SavedEnabledState_si, Boolean_sw, True, True, 0, True);
  AData.AddFunction('DoHint', TCustomAction_DoHint_si, Boolean_sw, 1, False);
  AData.AddProperty('AutoCheck', TCustomAction_AutoCheck_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('Caption', TCustomAction_Caption_si, string_sw, True, True, 0, False);
  AData.AddProperty('Checked', TCustomAction_Checked_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('DisableIfNoHandler', TCustomAction_DisableIfNoHandler_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('Enabled', TCustomAction_Enabled_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('GroupIndex', TCustomAction_GroupIndex_si, Integer_sw, True, True, 0, False);
  AData.AddProperty('HelpContext', TCustomAction_HelpContext_si, THelpContext_sw, True, True, 0, False);
  AData.AddProperty('HelpKeyword', TCustomAction_HelpKeyword_si, string_sw, True, True, 0, False);
  AData.AddProperty('HelpType', TCustomAction_HelpType_si, THelpType_sw, True, True, 0, False);
  AData.AddProperty('Hint', TCustomAction_Hint_si, string_sw, True, True, 0, False);
  AData.AddProperty('ImageIndex', TCustomAction_ImageIndex_si, TImageIndex_sw, True, True, 0, False);
  AData.AddProperty('ShortCut', TCustomAction_ShortCut_si, TShortCut_sw, True, True, 0, False);
  AData.AddProperty('SecondaryShortCuts', TCustomAction_SecondaryShortCuts_si, TShortCutList_sw, True, True, 0, False);
  AData.AddProperty('Visible', TCustomAction_Visible_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('OnHint', TCustomAction_OnHint_si, THintEvent_sw, True, True, 0, False);
end;

class function TCustomAction_sw.ToVar(const AValue: TCustomAction): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomAction_sw.FromVar(
  const AValue: OleVariant): TCustomAction;
begin
  Result := TCustomAction(ConvFromVar(AValue, TCustomAction));
end;

class function TCustomAction_sw.ClassToVar(
  AClass: TCustomAction_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomAction_sw.ClassFromVar(
  const AClass: OleVariant): TCustomAction_sc;
begin
  Result := TCustomAction_sc(ConvClsFromVar(AClass, TCustomAction));
end;

{ TAction_sw }

class function TAction_sw.GetTypeName: WideString;
begin
  Result := 'TAction';
end;

class function TAction_sw.GetWrappedClass: TClass;
begin
  Result := TAction;
end;

class procedure TAction_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('AutoCheck');
  AData.AddPropertyRedecl('Caption');
  AData.AddPropertyRedecl('Checked');
  AData.AddPropertyRedecl('Enabled');
  AData.AddPropertyRedecl('GroupIndex');
  AData.AddPropertyRedecl('HelpContext');
  AData.AddPropertyRedecl('HelpKeyword');
  AData.AddPropertyRedecl('HelpType');
  AData.AddPropertyRedecl('Hint');
  AData.AddPropertyRedecl('ImageIndex');
  AData.AddPropertyRedecl('ShortCut');
  AData.AddPropertyRedecl('SecondaryShortCuts');
  AData.AddPropertyRedecl('Visible');
  AData.AddPropertyRedecl('OnExecute');
  AData.AddPropertyRedecl('OnHint');
  AData.AddPropertyRedecl('OnUpdate');
end;

class function TAction_sw.ToVar(const AValue: TAction): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TAction_sw.FromVar(const AValue: OleVariant): TAction;
begin
  Result := TAction(ConvFromVar(AValue, TAction));
end;

class function TAction_sw.ClassToVar(AClass: TAction_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TAction_sw.ClassFromVar(const AClass: OleVariant): TAction_sc;
begin
  Result := TAction_sc(ConvClsFromVar(AClass, TAction));
end;

{ TActionLink_sw }

class function TActionLink_sw.GetTypeName: WideString;
begin
  Result := 'TActionLink';
end;

class function TActionLink_sw.GetWrappedClass: TClass;
begin
  Result := TActionLink;
end;

class procedure TActionLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TActionLink_sw.ToVar(const AValue: TActionLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionLink_sw.FromVar(const AValue: OleVariant): TActionLink;
begin
  Result := TActionLink(ConvFromVar(AValue, TActionLink));
end;

class function TActionLink_sw.ClassToVar(AClass: TActionLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TActionLink_sw.ClassFromVar(
  const AClass: OleVariant): TActionLink_sc;
begin
  Result := TActionLink_sc(ConvClsFromVar(AClass, TActionLink));
end;

{ TActionLinkClass_sw }

class function TActionLinkClass_sw.GetTypeName: WideString;
begin
  Result := 'TActionLinkClass';
end;

class function TActionLinkClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TActionLink;
end;

class function TActionLinkClass_sw.ToVar(
  const AValue: TActionLinkClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionLinkClass_sw.FromVar(
  const AValue: OleVariant): TActionLinkClass;
begin
  Result := TActionLinkClass(ConvFromVar(AValue, TActionLink));
end;

{ ActnList_sw }

function ActnList_TContainedAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TContainedAction = class(TBasicAction);

  Result := TLMDUnitWrapper.TypeToVar(TContainedAction_sw);
end;

function ActnList_TContainedActionClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TContainedActionClass = class of TContainedAction;

  Result := TLMDUnitWrapper.TypeToVar(TContainedActionClass_sw);
end;

function ActnList_TActionListEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionListEnumerator = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TActionListEnumerator_sw);
end;

function ActnList_TActionEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionEvent = procedure (Action: TBasicAction; var ...

  Result := TLMDUnitWrapper.TypeToVar(TActionEvent_sw);
end;

function ActnList_TActionListState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionListState = (asSuspended, asSuspendedEnabled);

  Result := TLMDUnitWrapper.TypeToVar(TActionListState_sw);
end;

function ActnList_TCustomActionList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomActionList = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TCustomActionList_sw);
end;

function ActnList_TActionList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionList = class(TCustomActionList);

  Result := TLMDUnitWrapper.TypeToVar(TActionList_sw);
end;

function ActnList_TShortCutList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TShortCutList = class(TStringList);

  Result := TLMDUnitWrapper.TypeToVar(TShortCutList_sw);
end;

function ActnList_THintEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THintEvent = procedure (var HintStr: string; var Can...

  Result := TLMDUnitWrapper.TypeToVar(THintEvent_sw);
end;

function ActnList_TCustomAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomAction = class(TContainedAction);

  Result := TLMDUnitWrapper.TypeToVar(TCustomAction_sw);
end;

function ActnList_TAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAction = class(TCustomAction);

  Result := TLMDUnitWrapper.TypeToVar(TAction_sw);
end;

function ActnList_TActionLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionLink = class(TBasicActionLink);

  Result := TLMDUnitWrapper.TypeToVar(TActionLink_sw);
end;

function ActnList_TActionLinkClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionLinkClass = class of TActionLink;

  Result := TLMDUnitWrapper.TypeToVar(TActionLinkClass_sw);
end;

function ActnList_CreateAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CreateAction(AOwner: TComponent; ActionClass: TB...

  Result := TBasicAction_sw.ToVar(ActnList.CreateAction(TComponent_sw.FromVar(
    AArgs[0]), TBasicActionClass_sw.FromVar(AArgs[1])));
end;

class function ActnList_sw.GetUnitName: WideString;
begin
  Result := 'ActnList';
end;

class procedure ActnList_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TContainedAction_sw, ActnList_TContainedAction_si);
  AData.AddType(TContainedActionClass_sw, ActnList_TContainedActionClass_si);
  AData.AddType(TActionListEnumerator_sw, ActnList_TActionListEnumerator_si);
  AData.AddType(TActionEvent_sw, ActnList_TActionEvent_si);
  AData.AddType(TActionListState_sw, ActnList_TActionListState_si);
  AData.AddType(TCustomActionList_sw, ActnList_TCustomActionList_si);
  AData.AddType(TActionList_sw, ActnList_TActionList_si);
  AData.AddType(TShortCutList_sw, ActnList_TShortCutList_si);
  AData.AddType(THintEvent_sw, ActnList_THintEvent_si);
  AData.AddType(TCustomAction_sw, ActnList_TCustomAction_si);
  AData.AddType(TAction_sw, ActnList_TAction_si);
  AData.AddType(TActionLink_sw, ActnList_TActionLink_si);
  AData.AddType(TActionLinkClass_sw, ActnList_TActionLinkClass_si);
  AData.AddFunction('CreateAction', ActnList_CreateAction_si, TBasicAction_sw, 2, False);
end;

class function ActnList_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(ActnList_sw);
end;

initialization
  RegisterUnitWrapper(ActnList_sw);
  RegisterClassWrapper(TContainedAction_sw);
  RegisterClassWrapper(TActionListEnumerator_sw);
  RegisterClassWrapper(TCustomActionList_sw);
  RegisterClassWrapper(TActionList_sw);
  RegisterClassWrapper(TShortCutList_sw);
  RegisterClassWrapper(TCustomAction_sw);
  RegisterClassWrapper(TAction_sw);
  RegisterClassWrapper(TActionLink_sw);
  RegisterEventWrapper(TypeInfo(TActionEvent), TActionEvent_sw);
  RegisterEventWrapper(TypeInfo(THintEvent), THintEvent_sw);

end.
