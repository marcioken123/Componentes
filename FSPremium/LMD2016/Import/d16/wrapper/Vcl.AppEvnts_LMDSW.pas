unit Vcl.AppEvnts_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Vcl.AppEvnts' unit.
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
  LMDSctWrappers, LMDSctSysWrappers, Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.ActnList,
  Vcl.AppEvnts, Winapi.Windows_LMDSW, Winapi.Messages_LMDSW,
  System.SysUtils_LMDSW, System.Classes_LMDSW, Vcl.Controls_LMDSW,
  Vcl.Forms_LMDSW, Vcl.ActnList_LMDSW;


{ Type wrappers }

type
  TCustomApplicationEvents_sw = class;
  TApplicationEvents_sw = class;

  TCustomApplicationEvents_sc = class of TCustomApplicationEvents;
  TCustomApplicationEvents_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomApplicationEvents): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomApplicationEvents;
    class function ClassToVar(AClass: TCustomApplicationEvents_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomApplicationEvents_sc;
  end;

  TApplicationEvents_sc = class of TApplicationEvents;
  TApplicationEvents_sw = class(TCustomApplicationEvents_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TApplicationEvents): OleVariant;
    class function FromVar(const AValue: OleVariant): TApplicationEvents;
    class function ClassToVar(AClass: TApplicationEvents_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TApplicationEvents_sc;
  end;


{ Unit wrapper }

type
  AppEvnts_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TCustomApplicationEvents_sacc = class(TCustomApplicationEvents);

{ TCustomApplicationEvents_sw }

function TCustomApplicationEvents_OnActionExecute_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnActionExecute: TActionEvent read <ge...

  if IsGet then
    Result := TActionEvent_sw.ToVar(TCustomApplicationEvents_sacc(
      TCustomApplicationEvents(AObj)).OnActionExecute)
  else
    TCustomApplicationEvents_sacc(TCustomApplicationEvents(AObj)).
      OnActionExecute := TActionEvent_sw.FromVar(AArgs[0]);
end;

function TCustomApplicationEvents_OnActionUpdate_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnActionUpdate: TActionEvent read <get...

  if IsGet then
    Result := TActionEvent_sw.ToVar(TCustomApplicationEvents_sacc(
      TCustomApplicationEvents(AObj)).OnActionUpdate)
  else
    TCustomApplicationEvents_sacc(TCustomApplicationEvents(AObj)).
      OnActionUpdate := TActionEvent_sw.FromVar(AArgs[0]);
end;

function TCustomApplicationEvents_OnActivate_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnActivate: TNotifyEvent read <getter>...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomApplicationEvents_sacc(
      TCustomApplicationEvents(AObj)).OnActivate)
  else
    TCustomApplicationEvents_sacc(TCustomApplicationEvents(AObj)).OnActivate := 
      TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomApplicationEvents_OnDeactivate_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnDeactivate: TNotifyEvent read <gette...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomApplicationEvents_sacc(
      TCustomApplicationEvents(AObj)).OnDeactivate)
  else
    TCustomApplicationEvents_sacc(TCustomApplicationEvents(AObj)).OnDeactivate 
      := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomApplicationEvents_OnException_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnException: TExceptionEvent read <get...

  if IsGet then
    Result := TExceptionEvent_sw.ToVar(TCustomApplicationEvents_sacc(
      TCustomApplicationEvents(AObj)).OnException)
  else
    TCustomApplicationEvents_sacc(TCustomApplicationEvents(AObj)).OnException :=
      TExceptionEvent_sw.FromVar(AArgs[0]);
end;

function TCustomApplicationEvents_OnIdle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnIdle: TIdleEvent read <getter> write...

  if IsGet then
    Result := TIdleEvent_sw.ToVar(TCustomApplicationEvents_sacc(
      TCustomApplicationEvents(AObj)).OnIdle)
  else
    TCustomApplicationEvents_sacc(TCustomApplicationEvents(AObj)).OnIdle := 
      TIdleEvent_sw.FromVar(AArgs[0]);
end;

function TCustomApplicationEvents_OnHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnHelp: THelpEvent read <getter> write...

  if IsGet then
    Result := THelpEvent_sw.ToVar(TCustomApplicationEvents_sacc(
      TCustomApplicationEvents(AObj)).OnHelp)
  else
    TCustomApplicationEvents_sacc(TCustomApplicationEvents(AObj)).OnHelp := 
      THelpEvent_sw.FromVar(AArgs[0]);
end;

function TCustomApplicationEvents_OnHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnHint: TNotifyEvent read <getter> wri...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomApplicationEvents_sacc(
      TCustomApplicationEvents(AObj)).OnHint)
  else
    TCustomApplicationEvents_sacc(TCustomApplicationEvents(AObj)).OnHint := 
      TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomApplicationEvents_OnMessage_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnMessage: TMessageEvent read <getter>...

  if IsGet then
    Result := TMessageEvent_sw.ToVar(TCustomApplicationEvents_sacc(
      TCustomApplicationEvents(AObj)).OnMessage)
  else
    TCustomApplicationEvents_sacc(TCustomApplicationEvents(AObj)).OnMessage := 
      TMessageEvent_sw.FromVar(AArgs[0]);
end;

function TCustomApplicationEvents_OnMinimize_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnMinimize: TNotifyEvent read <getter>...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomApplicationEvents_sacc(
      TCustomApplicationEvents(AObj)).OnMinimize)
  else
    TCustomApplicationEvents_sacc(TCustomApplicationEvents(AObj)).OnMinimize := 
      TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomApplicationEvents_OnRestore_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnRestore: TNotifyEvent read <getter> ...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomApplicationEvents_sacc(
      TCustomApplicationEvents(AObj)).OnRestore)
  else
    TCustomApplicationEvents_sacc(TCustomApplicationEvents(AObj)).OnRestore := 
      TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomApplicationEvents_OnShowHint_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnShowHint: TShowHintEvent read <gette...

  if IsGet then
    Result := TShowHintEvent_sw.ToVar(TCustomApplicationEvents_sacc(
      TCustomApplicationEvents(AObj)).OnShowHint)
  else
    TCustomApplicationEvents_sacc(TCustomApplicationEvents(AObj)).OnShowHint := 
      TShowHintEvent_sw.FromVar(AArgs[0]);
end;

function TCustomApplicationEvents_OnShortCut_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnShortCut: TShortCutEvent read <gette...

  if IsGet then
    Result := TShortCutEvent_sw.ToVar(TCustomApplicationEvents_sacc(
      TCustomApplicationEvents(AObj)).OnShortCut)
  else
    TCustomApplicationEvents_sacc(TCustomApplicationEvents(AObj)).OnShortCut := 
      TShortCutEvent_sw.FromVar(AArgs[0]);
end;

function TCustomApplicationEvents_OnSettingChange_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnSettingChange: TSettingChangeEvent r...

  if IsGet then
    Result := TSettingChangeEvent_sw.ToVar(TCustomApplicationEvents_sacc(
      TCustomApplicationEvents(AObj)).OnSettingChange)
  else
    TCustomApplicationEvents_sacc(TCustomApplicationEvents(AObj)).
      OnSettingChange := TSettingChangeEvent_sw.FromVar(AArgs[0]);
end;

function TCustomApplicationEvents_OnModalBegin_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnModalBegin: TNotifyEvent read <gette...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomApplicationEvents_sacc(
      TCustomApplicationEvents(AObj)).OnModalBegin)
  else
    TCustomApplicationEvents_sacc(TCustomApplicationEvents(AObj)).OnModalBegin 
      := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomApplicationEvents_OnModalEnd_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnModalEnd: TNotifyEvent read <getter>...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomApplicationEvents_sacc(
      TCustomApplicationEvents(AObj)).OnModalEnd)
  else
    TCustomApplicationEvents_sacc(TCustomApplicationEvents(AObj)).OnModalEnd := 
      TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomApplicationEvents_Activate_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Activate;

  TCustomApplicationEvents(AObj).Activate();
end;

function TCustomApplicationEvents_CancelDispatch_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CancelDispatch;

  TCustomApplicationEvents(AObj).CancelDispatch();
end;

class function TCustomApplicationEvents_sw.GetTypeName: WideString;
begin
  Result := 'TCustomApplicationEvents';
end;

class function TCustomApplicationEvents_sw.GetWrappedClass: TClass;
begin
  Result := TCustomApplicationEvents;
end;

class procedure TCustomApplicationEvents_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('OnActionExecute', TCustomApplicationEvents_OnActionExecute_si, TActionEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnActionUpdate', TCustomApplicationEvents_OnActionUpdate_si, TActionEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnActivate', TCustomApplicationEvents_OnActivate_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnDeactivate', TCustomApplicationEvents_OnDeactivate_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnException', TCustomApplicationEvents_OnException_si, TExceptionEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnIdle', TCustomApplicationEvents_OnIdle_si, TIdleEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnHelp', TCustomApplicationEvents_OnHelp_si, THelpEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnHint', TCustomApplicationEvents_OnHint_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnMessage', TCustomApplicationEvents_OnMessage_si, TMessageEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnMinimize', TCustomApplicationEvents_OnMinimize_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnRestore', TCustomApplicationEvents_OnRestore_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnShowHint', TCustomApplicationEvents_OnShowHint_si, TShowHintEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnShortCut', TCustomApplicationEvents_OnShortCut_si, TShortCutEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnSettingChange', TCustomApplicationEvents_OnSettingChange_si, TSettingChangeEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnModalBegin', TCustomApplicationEvents_OnModalBegin_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnModalEnd', TCustomApplicationEvents_OnModalEnd_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProcedure('Activate', TCustomApplicationEvents_Activate_si, 0, False);
  AData.AddProcedure('CancelDispatch', TCustomApplicationEvents_CancelDispatch_si, 0, False);
end;

class function TCustomApplicationEvents_sw.ToVar(
  const AValue: TCustomApplicationEvents): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomApplicationEvents_sw.FromVar(
  const AValue: OleVariant): TCustomApplicationEvents;
begin
  Result := TCustomApplicationEvents(ConvFromVar(AValue, 
    TCustomApplicationEvents));
end;

class function TCustomApplicationEvents_sw.ClassToVar(
  AClass: TCustomApplicationEvents_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomApplicationEvents_sw.ClassFromVar(
  const AClass: OleVariant): TCustomApplicationEvents_sc;
begin
  Result := TCustomApplicationEvents_sc(ConvClsFromVar(AClass, 
    TCustomApplicationEvents));
end;

{ TApplicationEvents_sw }

class function TApplicationEvents_sw.GetTypeName: WideString;
begin
  Result := 'TApplicationEvents';
end;

class function TApplicationEvents_sw.GetWrappedClass: TClass;
begin
  Result := TApplicationEvents;
end;

class procedure TApplicationEvents_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('OnActionExecute', False);
  AData.AddPropertyRedecl('OnActionUpdate', False);
  AData.AddPropertyRedecl('OnActivate', False);
  AData.AddPropertyRedecl('OnDeactivate', False);
  AData.AddPropertyRedecl('OnException', False);
  AData.AddPropertyRedecl('OnIdle', False);
  AData.AddPropertyRedecl('OnHelp', False);
  AData.AddPropertyRedecl('OnHint', False);
  AData.AddPropertyRedecl('OnMessage', False);
  AData.AddPropertyRedecl('OnMinimize', False);
  AData.AddPropertyRedecl('OnModalBegin', False);
  AData.AddPropertyRedecl('OnModalEnd', False);
  AData.AddPropertyRedecl('OnRestore', False);
  AData.AddPropertyRedecl('OnShowHint', False);
  AData.AddPropertyRedecl('OnShortCut', False);
  AData.AddPropertyRedecl('OnSettingChange', False);
end;

class function TApplicationEvents_sw.ToVar(
  const AValue: TApplicationEvents): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TApplicationEvents_sw.FromVar(
  const AValue: OleVariant): TApplicationEvents;
begin
  Result := TApplicationEvents(ConvFromVar(AValue, TApplicationEvents));
end;

class function TApplicationEvents_sw.ClassToVar(
  AClass: TApplicationEvents_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TApplicationEvents_sw.ClassFromVar(
  const AClass: OleVariant): TApplicationEvents_sc;
begin
  Result := TApplicationEvents_sc(ConvClsFromVar(AClass, TApplicationEvents));
end;

{ AppEvnts_sw }

function AppEvnts_TCustomApplicationEvents_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomApplicationEvents = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TCustomApplicationEvents_sw);
end;

function AppEvnts_TApplicationEvents_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TApplicationEvents = class(TCustomApplicationEvents);

  Result := TLMDUnitWrapper.TypeToVar(TApplicationEvents_sw);
end;

class function AppEvnts_sw.GetUnitName: WideString;
begin
  Result := 'AppEvnts';
end;

class procedure AppEvnts_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TCustomApplicationEvents_sw, AppEvnts_TCustomApplicationEvents_si);
  AData.AddType(TApplicationEvents_sw, AppEvnts_TApplicationEvents_si);
end;

class function AppEvnts_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(AppEvnts_sw);
end;

initialization
  RegisterUnitWrapper(AppEvnts_sw);
  RegisterClassWrapper(TCustomApplicationEvents_sw);
  RegisterClassWrapper(TApplicationEvents_sw);

end.
