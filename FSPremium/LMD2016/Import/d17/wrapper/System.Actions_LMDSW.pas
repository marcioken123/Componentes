unit System.Actions_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'System.Actions' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  System.Types, System.Variants, System.TypInfo, LMDTypes, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers, System.SysUtils, System.Classes,
  System.UITypes, System.Actions, System.SysUtils_LMDSW, System.Classes_LMDSW,
  System.UITypes_LMDSW;


{ Type wrappers }

type
  EActionError_sw = class;
  TContainedActionListClass_sw = class;
  TCustomShortCutList_sw = class;
  TContainedAction_sw = class;
  TContainedActionLink_sw = class;
  TContainedActionLinkClass_sw = class;
  TContainedActionClass_sw = class;
  TActionListEnumerator_sw = class;
  TContainedActionList_sw = class;

  EActionError_sc = class of EActionError;
  EActionError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EActionError): OleVariant;
    class function FromVar(const AValue: OleVariant): EActionError;
    class function ClassToVar(AClass: EActionError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EActionError_sc;
  end;

  TStatusAction_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TStatusAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TStatusAction;
  end;

  TContainedActionListClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TContainedActionListClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TContainedActionListClass;
  end;

  TCustomShortCutList_sc = class of TCustomShortCutList;
  TCustomShortCutList_sw = class(TStringList_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomShortCutList): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomShortCutList;
    class function ClassToVar(AClass: TCustomShortCutList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomShortCutList_sc;
  end;

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

  TContainedActionLink_sc = class of TContainedActionLink;
  TContainedActionLink_sw = class(TBasicActionLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TContainedActionLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TContainedActionLink;
    class function ClassToVar(AClass: TContainedActionLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TContainedActionLink_sc;
  end;

  TContainedActionLinkClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TContainedActionLinkClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TContainedActionLinkClass;
  end;

  TContainedActionClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TContainedActionClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TContainedActionClass;
  end;

  TActionListState_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TActionListState): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionListState;
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

  TContainedActionList_sc = class of TContainedActionList;
  TContainedActionList_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TContainedActionList): OleVariant;
    class function FromVar(const AValue: OleVariant): TContainedActionList;
    class function ClassToVar(AClass: TContainedActionList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TContainedActionList_sc;
  end;


{ Unit wrapper }

type
  Actions_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TContainedAction_sacc = class(TContainedAction);
  TContainedActionList_sacc = class(TContainedActionList);

{ EActionError_sw }

class function EActionError_sw.GetTypeName: WideString;
begin
  Result := 'EActionError';
end;

class function EActionError_sw.GetWrappedClass: TClass;
begin
  Result := EActionError;
end;

class procedure EActionError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EActionError_sw.ToVar(const AValue: EActionError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EActionError_sw.FromVar(const AValue: OleVariant): EActionError;
begin
  Result := EActionError(ConvFromVar(AValue, EActionError));
end;

class function EActionError_sw.ClassToVar(AClass: EActionError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EActionError_sw.ClassFromVar(
  const AClass: OleVariant): EActionError_sc;
begin
  Result := EActionError_sc(ConvClsFromVar(AClass, EActionError));
end;

{ TStatusAction_sw }

class function TStatusAction_sw.GetTypeName: WideString;
begin
  Result := 'TStatusAction';
end;

class procedure TStatusAction_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..12] of TLMDEnumerator = (
    (Name: 'saNone'; Value: Integer({$IFDEF LMDSCT_12}TStatusAction.{$ENDIF}saNone)),
    (Name: 'saTrivial'; Value: Integer({$IFDEF LMDSCT_12}TStatusAction.{$ENDIF}saTrivial)),
    (Name: 'saDefault'; Value: Integer({$IFDEF LMDSCT_12}TStatusAction.{$ENDIF}saDefault)),
    (Name: 'saRequiredEmpty'; Value: Integer({$IFDEF LMDSCT_12}TStatusAction.{$ENDIF}saRequiredEmpty)),
    (Name: 'saRequired'; Value: Integer({$IFDEF LMDSCT_12}TStatusAction.{$ENDIF}saRequired)),
    (Name: 'saValid'; Value: Integer({$IFDEF LMDSCT_12}TStatusAction.{$ENDIF}saValid)),
    (Name: 'saInvalid'; Value: Integer({$IFDEF LMDSCT_12}TStatusAction.{$ENDIF}saInvalid)),
    (Name: 'saWaiting'; Value: Integer({$IFDEF LMDSCT_12}TStatusAction.{$ENDIF}saWaiting)),
    (Name: 'saWarning'; Value: Integer({$IFDEF LMDSCT_12}TStatusAction.{$ENDIF}saWarning)),
    (Name: 'saUnused'; Value: Integer({$IFDEF LMDSCT_12}TStatusAction.{$ENDIF}saUnused)),
    (Name: 'saCalculated'; Value: Integer({$IFDEF LMDSCT_12}TStatusAction.{$ENDIF}saCalculated)),
    (Name: 'saError'; Value: Integer({$IFDEF LMDSCT_12}TStatusAction.{$ENDIF}saError)),
    (Name: 'saOther'; Value: Integer({$IFDEF LMDSCT_12}TStatusAction.{$ENDIF}saOther))
  );
begin
  AEnums := @ENUMS;
  ACount := 13;
end;

class function TStatusAction_sw.ToVar(const AValue: TStatusAction): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TStatusAction_sw.FromVar(
  const AValue: OleVariant): TStatusAction;
begin
  Result := TStatusAction(Integer(AValue));
end;

{ TContainedActionListClass_sw }

class function TContainedActionListClass_sw.GetTypeName: WideString;
begin
  Result := 'TContainedActionListClass';
end;

class function TContainedActionListClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TContainedActionList;
end;

class function TContainedActionListClass_sw.ToVar(
  const AValue: TContainedActionListClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TContainedActionListClass_sw.FromVar(
  const AValue: OleVariant): TContainedActionListClass;
begin
  Result := TContainedActionListClass(ConvFromVar(AValue, 
    TContainedActionList));
end;

{ TCustomShortCutList_sw }

function TCustomShortCutList_IndexOfShortCut_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function IndexOfShortCut(...); overload;

  Result := TCustomShortCutList(AObj).IndexOfShortCut(string(AArgs[0]));
end;

function TCustomShortCutList_ShortCuts_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShortCuts[Index: Integer]: System.Classes.TShort...

  Result := System.Classes_LMDSW.TShortCut_sw.ToVar(TCustomShortCutList(AObj).
    ShortCuts[Integer(AArgs[0])]);
end;

class function TCustomShortCutList_sw.GetTypeName: WideString;
begin
  Result := 'TCustomShortCutList';
end;

class function TCustomShortCutList_sw.GetWrappedClass: TClass;
begin
  Result := TCustomShortCutList;
end;

class procedure TCustomShortCutList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('IndexOfShortCut', TCustomShortCutList_IndexOfShortCut_si, nil, 1, False);
  AData.AddProperty('ShortCuts', TCustomShortCutList_ShortCuts_si, System.Classes_LMDSW.TShortCut_sw, True, False, 1, False, False);
end;

class function TCustomShortCutList_sw.ToVar(
  const AValue: TCustomShortCutList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomShortCutList_sw.FromVar(
  const AValue: OleVariant): TCustomShortCutList;
begin
  Result := TCustomShortCutList(ConvFromVar(AValue, TCustomShortCutList));
end;

class function TCustomShortCutList_sw.ClassToVar(
  AClass: TCustomShortCutList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomShortCutList_sw.ClassFromVar(
  const AClass: OleVariant): TCustomShortCutList_sc;
begin
  Result := TCustomShortCutList_sc(ConvClsFromVar(AClass, TCustomShortCutList));
end;

{ TContainedAction_sw }

function TContainedAction_SavedEnabledState_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property SavedEnabledState: Boolean read <gette...

  if IsGet then
    Result := TContainedAction_sacc(TContainedAction(AObj)).SavedEnabledState
  else
    TContainedAction_sacc(TContainedAction(AObj)).SavedEnabledState := Boolean(
      AArgs[0]);
end;

function TContainedAction_ActionList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionList: TContainedActionList read <getter> w...

  if IsGet then
    Result := TContainedActionList_sw.ToVar(TContainedAction(AObj).ActionList)
  else
    TContainedAction(AObj).ActionList := TContainedActionList_sw.FromVar(
      AArgs[0]);
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

function TContainedAction_DisableIfNoHandler_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DisableIfNoHandler: Boolean read <getter> write ...

  if IsGet then
    Result := TContainedAction(AObj).DisableIfNoHandler
  else
    TContainedAction(AObj).DisableIfNoHandler := Boolean(AArgs[0]);
end;

function TContainedAction_AutoCheck_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoCheck: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TContainedAction(AObj).AutoCheck
  else
    TContainedAction(AObj).AutoCheck := Boolean(AArgs[0]);
end;

function TContainedAction_Caption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Caption: string read <getter> write <setter>;

  if IsGet then
    Result := TContainedAction(AObj).Caption
  else
    TContainedAction(AObj).Caption := string(AArgs[0]);
end;

function TContainedAction_Checked_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Checked: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TContainedAction(AObj).Checked
  else
    TContainedAction(AObj).Checked := Boolean(AArgs[0]);
end;

function TContainedAction_Enabled_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Enabled: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TContainedAction(AObj).Enabled
  else
    TContainedAction(AObj).Enabled := Boolean(AArgs[0]);
end;

function TContainedAction_GroupIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GroupIndex: Integer read <getter> write <setter>;

  if IsGet then
    Result := TContainedAction(AObj).GroupIndex
  else
    TContainedAction(AObj).GroupIndex := Integer(AArgs[0]);
end;

function TContainedAction_HelpContext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HelpContext: THelpContext read <getter> write <s...

  if IsGet then
    Result := THelpContext_sw.ToVar(TContainedAction(AObj).HelpContext)
  else
    TContainedAction(AObj).HelpContext := THelpContext_sw.FromVar(AArgs[0]);
end;

function TContainedAction_HelpKeyword_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HelpKeyword: string read <getter> write <setter>;

  if IsGet then
    Result := TContainedAction(AObj).HelpKeyword
  else
    TContainedAction(AObj).HelpKeyword := string(AArgs[0]);
end;

function TContainedAction_HelpType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HelpType: THelpType read <getter> write <setter>;

  if IsGet then
    Result := THelpType_sw.ToVar(TContainedAction(AObj).HelpType)
  else
    TContainedAction(AObj).HelpType := THelpType_sw.FromVar(AArgs[0]);
end;

function TContainedAction_Hint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Hint: string read <getter> write <setter>;

  if IsGet then
    Result := TContainedAction(AObj).Hint
  else
    TContainedAction(AObj).Hint := string(AArgs[0]);
end;

function TContainedAction_Visible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Visible: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TContainedAction(AObj).Visible
  else
    TContainedAction(AObj).Visible := Boolean(AArgs[0]);
end;

function TContainedAction_ShortCut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShortCut: System.Classes.TShortCut read <getter>...

  if IsGet then
    Result := System.Classes_LMDSW.TShortCut_sw.ToVar(TContainedAction(AObj).
      ShortCut)
  else
    TContainedAction(AObj).ShortCut := System.Classes_LMDSW.TShortCut_sw.
      FromVar(AArgs[0]);
end;

function TContainedAction_SecondaryShortCuts_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SecondaryShortCuts: TCustomShortCutList read <ge...

  if IsGet then
    Result := TCustomShortCutList_sw.ToVar(TContainedAction(AObj).
      SecondaryShortCuts)
  else
    TContainedAction(AObj).SecondaryShortCuts := TCustomShortCutList_sw.FromVar(
      AArgs[0]);
end;

function TContainedAction_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImageIndex: System.UITypes.TImageIndex read <get...

  if IsGet then
    Result := System.UITypes_LMDSW.TImageIndex_sw.ToVar(TContainedAction(AObj).
      ImageIndex)
  else
    TContainedAction(AObj).ImageIndex := System.UITypes_LMDSW.TImageIndex_sw.
      FromVar(AArgs[0]);
end;

function TContainedAction_DoHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: string;
begin
  // function DoHint(var HintStr: string): Boolean;

  v_1 := string(AArgs[0]);
  Result := TContainedAction(AObj).DoHint(v_1);
  AssignRefParam(AArgs[0], v_1);
end;

function TContainedAction_OnHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnHint: THintEvent read <getter> write <setter>;

  if IsGet then
    Result := THintEvent_sw.ToVar(TContainedAction(AObj).OnHint)
  else
    TContainedAction(AObj).OnHint := THintEvent_sw.FromVar(AArgs[0]);
end;

function TContainedAction_StatusAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property StatusAction: TStatusAction read <getter> write ...

  if IsGet then
    Result := TStatusAction_sw.ToVar(TContainedAction(AObj).StatusAction)
  else
    TContainedAction(AObj).StatusAction := TStatusAction_sw.FromVar(AArgs[0]);
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

  AData.AddProperty('SavedEnabledState', TContainedAction_SavedEnabledState_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('ActionList', TContainedAction_ActionList_si, TContainedActionList_sw, True, True, 0, False, False);
  AData.AddProperty('Index', TContainedAction_Index_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('DisableIfNoHandler', TContainedAction_DisableIfNoHandler_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('AutoCheck', TContainedAction_AutoCheck_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Caption', TContainedAction_Caption_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Checked', TContainedAction_Checked_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Enabled', TContainedAction_Enabled_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('GroupIndex', TContainedAction_GroupIndex_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('HelpContext', TContainedAction_HelpContext_si, THelpContext_sw, True, True, 0, False, False);
  AData.AddProperty('HelpKeyword', TContainedAction_HelpKeyword_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('HelpType', TContainedAction_HelpType_si, THelpType_sw, True, True, 0, False, False);
  AData.AddProperty('Hint', TContainedAction_Hint_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Visible', TContainedAction_Visible_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ShortCut', TContainedAction_ShortCut_si, System.Classes_LMDSW.TShortCut_sw, True, True, 0, False, False);
  AData.AddProperty('SecondaryShortCuts', TContainedAction_SecondaryShortCuts_si, TCustomShortCutList_sw, True, True, 0, False, False);
  AData.AddProperty('ImageIndex', TContainedAction_ImageIndex_si, System.UITypes_LMDSW.TImageIndex_sw, True, True, 0, False, False);
  AData.AddFunction('DoHint', TContainedAction_DoHint_si, Boolean_sw, 1, False);
  AData.AddProperty('OnHint', TContainedAction_OnHint_si, THintEvent_sw, True, True, 0, False, False);
  AData.AddProperty('StatusAction', TContainedAction_StatusAction_si, TStatusAction_sw, True, True, 0, False, False);
  AData.AddProperty('Category', TContainedAction_Category_si, string_sw, True, True, 0, False, False);
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

{ TContainedActionLink_sw }

class function TContainedActionLink_sw.GetTypeName: WideString;
begin
  Result := 'TContainedActionLink';
end;

class function TContainedActionLink_sw.GetWrappedClass: TClass;
begin
  Result := TContainedActionLink;
end;

class procedure TContainedActionLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TContainedActionLink_sw.ToVar(
  const AValue: TContainedActionLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TContainedActionLink_sw.FromVar(
  const AValue: OleVariant): TContainedActionLink;
begin
  Result := TContainedActionLink(ConvFromVar(AValue, TContainedActionLink));
end;

class function TContainedActionLink_sw.ClassToVar(
  AClass: TContainedActionLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TContainedActionLink_sw.ClassFromVar(
  const AClass: OleVariant): TContainedActionLink_sc;
begin
  Result := TContainedActionLink_sc(ConvClsFromVar(AClass, 
    TContainedActionLink));
end;

{ TContainedActionLinkClass_sw }

class function TContainedActionLinkClass_sw.GetTypeName: WideString;
begin
  Result := 'TContainedActionLinkClass';
end;

class function TContainedActionLinkClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TContainedActionLink;
end;

class function TContainedActionLinkClass_sw.ToVar(
  const AValue: TContainedActionLinkClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TContainedActionLinkClass_sw.FromVar(
  const AValue: OleVariant): TContainedActionLinkClass;
begin
  Result := TContainedActionLinkClass(ConvFromVar(AValue, 
    TContainedActionLink));
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

{ TActionListState_sw }

class function TActionListState_sw.GetTypeName: WideString;
begin
  Result := 'TActionListState';
end;

class procedure TActionListState_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'asNormal'; Value: Integer({$IFDEF LMDSCT_12}TActionListState.{$ENDIF}asNormal)),
    (Name: 'asSuspended'; Value: Integer({$IFDEF LMDSCT_12}TActionListState.{$ENDIF}asSuspended)),
    (Name: 'asSuspendedEnabled'; Value: Integer({$IFDEF LMDSCT_12}TActionListState.{$ENDIF}asSuspendedEnabled))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
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

{ TActionListEnumerator_sw }

function TActionListEnumerator_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AActionList: TContainedActionList);

  Result := TActionListEnumerator_sw.ToVar(TActionListEnumerator_sc(AObj).
    Create(TContainedActionList_sw.FromVar(AArgs[0])));
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

  AData.AddFunction('MoveNext', TActionListEnumerator_MoveNext_si, Boolean_sw, 0, False);
  AData.AddProperty('Current', TActionListEnumerator_Current_si, TContainedAction_sw, True, False, 0, False, False);

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

{ TContainedActionList_sw }

function TContainedActionList_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnChange: TNotifyEvent read <getter> w...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TContainedActionList_sacc(
      TContainedActionList(AObj)).OnChange)
  else
    TContainedActionList_sacc(TContainedActionList(AObj)).OnChange := 
      TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TContainedActionList_OnExecute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnExecute: TActionEvent read <getter> ...

  if IsGet then
    Result := TActionEvent_sw.ToVar(TContainedActionList_sacc(
      TContainedActionList(AObj)).OnExecute)
  else
    TContainedActionList_sacc(TContainedActionList(AObj)).OnExecute := 
      TActionEvent_sw.FromVar(AArgs[0]);
end;

function TContainedActionList_OnUpdate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnUpdate: TActionEvent read <getter> w...

  if IsGet then
    Result := TActionEvent_sw.ToVar(TContainedActionList_sacc(
      TContainedActionList(AObj)).OnUpdate)
  else
    TContainedActionList_sacc(TContainedActionList(AObj)).OnUpdate := 
      TActionEvent_sw.FromVar(AArgs[0]);
end;

function TContainedActionList_GetEnumerator_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetEnumerator: TActionListEnumerator;

  Result := TActionListEnumerator_sw.ToVar(TContainedActionList(AObj).
    GetEnumerator());
end;

function TContainedActionList_Actions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Actions[Index: Integer]: TContainedAction read <...

  if IsGet then
    Result := TContainedAction_sw.ToVar(TContainedActionList(AObj).
      Actions[Integer(AArgs[0])])
  else
    TContainedActionList(AObj).Actions[Integer(AArgs[0])] := 
      TContainedAction_sw.FromVar(AArgs[1]);
end;

function TContainedActionList_ActionCount_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionCount: Integer read <getter>;

  Result := TContainedActionList(AObj).ActionCount;
end;

function TContainedActionList_State_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property State: TActionListState read <getter> write <set...

  if IsGet then
    Result := TActionListState_sw.ToVar(TContainedActionList(AObj).State)
  else
    TContainedActionList(AObj).State := TActionListState_sw.FromVar(AArgs[0]);
end;

function TContainedActionList_OnStateChange_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnStateChange: TNotifyEvent read <getter> write ...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TContainedActionList(AObj).OnStateChange)
  else
    TContainedActionList(AObj).OnStateChange := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

class function TContainedActionList_sw.GetTypeName: WideString;
begin
  Result := 'TContainedActionList';
end;

class function TContainedActionList_sw.GetWrappedClass: TClass;
begin
  Result := TContainedActionList;
end;

class procedure TContainedActionList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('OnChange', TContainedActionList_OnChange_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnExecute', TContainedActionList_OnExecute_si, TActionEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnUpdate', TContainedActionList_OnUpdate_si, TActionEvent_sw, True, True, 0, True, False);
  AData.AddFunction('GetEnumerator', TContainedActionList_GetEnumerator_si, TActionListEnumerator_sw, 0, False);
  AData.AddProperty('Actions', TContainedActionList_Actions_si, TContainedAction_sw, True, True, 1, False, True);
  AData.AddProperty('ActionCount', TContainedActionList_ActionCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('State', TContainedActionList_State_si, TActionListState_sw, True, True, 0, False, False);
  AData.AddProperty('OnStateChange', TContainedActionList_OnStateChange_si, TNotifyEvent_sw, True, True, 0, False, False);
end;

class function TContainedActionList_sw.ToVar(
  const AValue: TContainedActionList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TContainedActionList_sw.FromVar(
  const AValue: OleVariant): TContainedActionList;
begin
  Result := TContainedActionList(ConvFromVar(AValue, TContainedActionList));
end;

class function TContainedActionList_sw.ClassToVar(
  AClass: TContainedActionList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TContainedActionList_sw.ClassFromVar(
  const AClass: OleVariant): TContainedActionList_sc;
begin
  Result := TContainedActionList_sc(ConvClsFromVar(AClass, 
    TContainedActionList));
end;

{ Actions_sw }

function Actions_EActionError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EActionError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EActionError_sw);
end;

function Actions_TStatusAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStatusAction = (saNone, saTrivial, saDefault, saReq...

  Result := TLMDUnitWrapper.TypeToVar(TStatusAction_sw);
end;

function Actions_TContainedActionListClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TContainedActionListClass = class of TContainedActio...

  Result := TLMDUnitWrapper.TypeToVar(TContainedActionListClass_sw);
end;

function Actions_TCustomShortCutList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomShortCutList = class(TStringList);

  Result := TLMDUnitWrapper.TypeToVar(TCustomShortCutList_sw);
end;

function Actions_TContainedAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TContainedAction = class(TBasicAction);

  Result := TLMDUnitWrapper.TypeToVar(TContainedAction_sw);
end;

function Actions_TContainedActionLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TContainedActionLink = class(TBasicActionLink);

  Result := TLMDUnitWrapper.TypeToVar(TContainedActionLink_sw);
end;

function Actions_TContainedActionLinkClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TContainedActionLinkClass = class of TContainedActio...

  Result := TLMDUnitWrapper.TypeToVar(TContainedActionLinkClass_sw);
end;

function Actions_TContainedActionClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TContainedActionClass = class of TContainedAction;

  Result := TLMDUnitWrapper.TypeToVar(TContainedActionClass_sw);
end;

function Actions_TActionListState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionListState = (asNormal, asSuspended, asSuspend...

  Result := TLMDUnitWrapper.TypeToVar(TActionListState_sw);
end;

function Actions_TActionListEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionListEnumerator = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TActionListEnumerator_sw);
end;

function Actions_TContainedActionList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TContainedActionList = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TContainedActionList_sw);
end;

function Actions_CreateAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CreateAction(AOwner: TComponent; ActionClass: TB...

  case AArgsSize of
    2:
    begin
      Result := TBasicAction_sw.ToVar(System.Actions.CreateAction(TComponent_sw.
        FromVar(AArgs[0]), TBasicActionClass_sw.FromVar(AArgs[1])));
    end;
    3:
    begin
      Result := TBasicAction_sw.ToVar(System.Actions.CreateAction(TComponent_sw.
        FromVar(AArgs[0]), TBasicActionClass_sw.FromVar(AArgs[1]), string(
        AArgs[2])));
    end;
  else
    WrongArgCountError('CreateAction');
  end;
end;

function Actions_vDesignAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var vDesignAction: boolean;

  if IsGet then
    Result := System.Actions.vDesignAction
  else
    System.Actions.vDesignAction := boolean(AArgs[0]);
end;

function Actions_RegisterShortCut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function RegisterShortCut(ShortCut: TShortCut; Index: int...

  case AArgsSize of
    1:
    begin
      Result := System.Actions.RegisterShortCut(TShortCut_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      Result := System.Actions.RegisterShortCut(TShortCut_sw.FromVar(AArgs[0]), 
        integer(AArgs[1]));
    end;
  else
    WrongArgCountError('RegisterShortCut');
  end;
end;

function Actions_UnregisterShortCut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UnregisterShortCut(ShortCut: TShortCut): boolean;

  Result := System.Actions.UnregisterShortCut(TShortCut_sw.FromVar(AArgs[0]));
end;

function Actions_RegisteredShortCutCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function RegisteredShortCutCount: integer;

  Result := System.Actions.RegisteredShortCutCount();
end;

function Actions_RegisteredShortCut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function RegisteredShortCut(Index: integer): TShortCut;

  Result := TShortCut_sw.ToVar(System.Actions.RegisteredShortCut(integer(
    AArgs[0])));
end;

class function Actions_sw.GetUnitName: WideString;
begin
  Result := 'Actions';
end;

class procedure Actions_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(EActionError_sw, Actions_EActionError_si);
  AData.AddType(TStatusAction_sw, Actions_TStatusAction_si);
  AData.AddType(TContainedActionListClass_sw, Actions_TContainedActionListClass_si);
  AData.AddType(TCustomShortCutList_sw, Actions_TCustomShortCutList_si);
  AData.AddType(TContainedAction_sw, Actions_TContainedAction_si);
  AData.AddType(TContainedActionLink_sw, Actions_TContainedActionLink_si);
  AData.AddType(TContainedActionLinkClass_sw, Actions_TContainedActionLinkClass_si);
  AData.AddType(TContainedActionClass_sw, Actions_TContainedActionClass_si);
  AData.AddType(TActionListState_sw, Actions_TActionListState_si);
  AData.AddType(TActionListEnumerator_sw, Actions_TActionListEnumerator_si);
  AData.AddType(TContainedActionList_sw, Actions_TContainedActionList_si);
  AData.AddFunction('CreateAction', Actions_CreateAction_si, TBasicAction_sw, 2, True);
  AData.AddVariable('vDesignAction', Actions_vDesignAction_si, boolean_sw);
  AData.AddFunction('RegisterShortCut', Actions_RegisterShortCut_si, integer_sw, 1, True);
  AData.AddFunction('UnregisterShortCut', Actions_UnregisterShortCut_si, boolean_sw, 1, False);
  AData.AddFunction('RegisteredShortCutCount', Actions_RegisteredShortCutCount_si, integer_sw, 0, False);
  AData.AddFunction('RegisteredShortCut', Actions_RegisteredShortCut_si, TShortCut_sw, 1, False);
end;

class function Actions_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Actions_sw);
end;

initialization
  RegisterUnitWrapper(Actions_sw);
  RegisterClassWrapper(EActionError_sw);
  RegisterClassWrapper(TCustomShortCutList_sw);
  RegisterClassWrapper(TContainedAction_sw);
  RegisterClassWrapper(TContainedActionLink_sw);
  RegisterClassWrapper(TActionListEnumerator_sw);
  RegisterClassWrapper(TContainedActionList_sw);

end.
