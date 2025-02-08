unit Vcl.ActnList_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Vcl.ActnList' unit.
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
  LMDSctWrappers, LMDSctSysWrappers, System.Classes, System.SysUtils,
  System.Actions, Winapi.Messages, Vcl.ImgList, Vcl.ActnList,
  System.Classes_LMDSW, System.SysUtils_LMDSW, System.Actions_LMDSW,
  Winapi.Messages_LMDSW, Vcl.ImgList_LMDSW;


{ Type wrappers }

type
  TCustomActionList_sw = class;
  TActionList_sw = class;
  TActionLink_sw = class;
  TActionLinkClass_sw = class;
  TShortCutList_sw = class;
  TCustomAction_sw = class;
  TAction_sw = class;

  TCustomActionList_sc = class of TCustomActionList;
  TCustomActionList_sw = class(TContainedActionList_sw)
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

  TActionLink_sc = class of TActionLink;
  TActionLink_sw = class(TContainedActionLink_sw)
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

  TShortCutList_sc = class of TShortCutList;
  TShortCutList_sw = class(TCustomShortCutList_sw)
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

{ TCustomActionList_sw }

function TCustomActionList_IsShortCut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TWMKey;
begin
  // function IsShortCut(var Message: TWMKey): Boolean;

  v_1 := TWMKey_sw.FromVar(AArgs[0]);
  Result := TCustomActionList(AObj).IsShortCut(v_1);
  AssignRefParam(AArgs[0], TWMKey_sw.ToVar(v_1));
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

  AData.AddFunction('IsShortCut', TCustomActionList_IsShortCut_si, Boolean_sw, 1, False);
  AData.AddProperty('Images', TCustomActionList_Images_si, TCustomImageList_sw, True, True, 0, False, False);
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

  AData.AddPropertyRedecl('Images', False);
  AData.AddPropertyRedecl('State', False);
  AData.AddPropertyRedecl('OnChange', False);
  AData.AddPropertyRedecl('OnExecute', False);
  AData.AddPropertyRedecl('OnStateChange', False);
  AData.AddPropertyRedecl('OnUpdate', False);
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

{ TShortCutList_sw }

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
  // Do not call inherited.
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

{ TCustomAction_sw }

function TCustomAction_Images_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Images: TCustomImageList read <getter>;

  Result := TCustomImageList_sw.ToVar(TCustomAction(AObj).Images);
end;

function TCustomAction_ActionList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionList: TCustomActionList read <getter> writ...

  if IsGet then
    Result := TCustomActionList_sw.ToVar(TCustomAction(AObj).ActionList)
  else
    TCustomAction(AObj).ActionList := TCustomActionList_sw.FromVar(AArgs[0]);
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

  AData.AddProperty('Images', TCustomAction_Images_si, TCustomImageList_sw, True, False, 0, False, False);
  AData.AddProperty('ActionList', TCustomAction_ActionList_si, TCustomActionList_sw, True, True, 0, False, False);
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

  AData.AddPropertyRedecl('AutoCheck', False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Checked', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('GroupIndex', False);
  AData.AddPropertyRedecl('HelpContext', False);
  AData.AddPropertyRedecl('HelpKeyword', False);
  AData.AddPropertyRedecl('HelpType', False);
  AData.AddPropertyRedecl('Hint', False);
  AData.AddPropertyRedecl('ImageIndex', False);
  AData.AddPropertyRedecl('SecondaryShortCuts', False);
  AData.AddPropertyRedecl('ShortCut', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnExecute', False);
  AData.AddPropertyRedecl('OnHint', False);
  AData.AddPropertyRedecl('OnUpdate', False);
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

{ ActnList_sw }

function ActnList_TCustomActionList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomActionList = class(TContainedActionList);

  Result := TLMDUnitWrapper.TypeToVar(TCustomActionList_sw);
end;

function ActnList_TActionList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionList = class(TCustomActionList);

  Result := TLMDUnitWrapper.TypeToVar(TActionList_sw);
end;

function ActnList_TActionLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionLink = class(TContainedActionLink);

  Result := TLMDUnitWrapper.TypeToVar(TActionLink_sw);
end;

function ActnList_TActionLinkClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionLinkClass = class of TActionLink;

  Result := TLMDUnitWrapper.TypeToVar(TActionLinkClass_sw);
end;

function ActnList_TShortCutList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TShortCutList = class(TCustomShortCutList);

  Result := TLMDUnitWrapper.TypeToVar(TShortCutList_sw);
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

class function ActnList_sw.GetUnitName: WideString;
begin
  Result := 'ActnList';
end;

class procedure ActnList_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TCustomActionList_sw, ActnList_TCustomActionList_si);
  AData.AddType(TActionList_sw, ActnList_TActionList_si);
  AData.AddType(TActionLink_sw, ActnList_TActionLink_si);
  AData.AddType(TActionLinkClass_sw, ActnList_TActionLinkClass_si);
  AData.AddType(TShortCutList_sw, ActnList_TShortCutList_si);
  AData.AddType(TCustomAction_sw, ActnList_TCustomAction_si);
  AData.AddType(TAction_sw, ActnList_TAction_si);
end;

class function ActnList_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(ActnList_sw);
end;

initialization
  RegisterUnitWrapper(ActnList_sw);
  RegisterClassWrapper(TCustomActionList_sw);
  RegisterClassWrapper(TActionList_sw);
  RegisterClassWrapper(TActionLink_sw);
  RegisterClassWrapper(TShortCutList_sw);
  RegisterClassWrapper(TCustomAction_sw);
  RegisterClassWrapper(TAction_sw);

end.
