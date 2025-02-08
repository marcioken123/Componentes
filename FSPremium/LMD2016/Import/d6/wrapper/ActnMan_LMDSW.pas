unit ActnMan_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'ActnMan' unit.
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
  LMDSctSysWrappers, Windows, Messages, SysUtils, Forms, Classes, Menus,
  ActnList, Graphics, ToolWin, ImgList, Controls, Buttons, ActnMan,
  Windows_LMDSW, Messages_LMDSW, SysUtils_LMDSW, Forms_LMDSW, Classes_LMDSW,
  Menus_LMDSW, ActnList_LMDSW, Graphics_LMDSW, ToolWin_LMDSW, ImgList_LMDSW,
  Controls_LMDSW, Buttons_LMDSW;


{ Type wrappers }

type
  TActionClientItemClass_sw = class;
  TActionClientsClass_sw = class;
  TActionBarsClass_sw = class;
  TActionBarItemClass_sw = class;
  TCustomActionManager_sw = class;
  TActionManager_sw = class;
  TActionListItem_sw = class;
  TActionListCollection_sw = class;
  TActionClientsCollection_sw = class;
  TActionClient_sw = class;
  TActionBarItem_sw = class;
  TActionBars_sw = class;
  TActionClientClass_sw = class;
  TActionClients_sw = class;
  TActionClientLinkClass_sw = class;
  TActionClientLink_sw = class;
  TActionClientItem_sw = class;
  TCustomActionClass_sw = class;
  TActionDragObject_sw = class;
  TCategoryDragObject_sw = class;
  TActionItemDragObject_sw = class;
  TCustomActionControlClass_sw = class;
  TCustomActionBar_sw = class;
  TCustomActionControl_sw = class;
  TXToolDockForm_sw = class;

  TActionClientItemClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TActionClientItemClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionClientItemClass;
  end;

  TActionClientsClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TActionClientsClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionClientsClass;
  end;

  TActionBarsClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TActionBarsClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionBarsClass;
  end;

  TActionBarItemClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TActionBarItemClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionBarItemClass;
  end;

  TCustomActionManager_sc = class of TCustomActionManager;
  TCustomActionManager_sw = class(TCustomActionList_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomActionManager): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomActionManager;
    class function ClassToVar(AClass: TCustomActionManager_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomActionManager_sc;
  end;

  TActionManager_sc = class of TActionManager;
  TActionManager_sw = class(TCustomActionManager_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TActionManager): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionManager;
    class function ClassToVar(AClass: TActionManager_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TActionManager_sc;
  end;

  TActionListItem_sc = class of TActionListItem;
  TActionListItem_sw = class(TCollectionItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TActionListItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionListItem;
    class function ClassToVar(AClass: TActionListItem_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TActionListItem_sc;
  end;

  TActionListCollection_sc = class of TActionListCollection;
  TActionListCollection_sw = class(TOwnedCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TActionListCollection): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionListCollection;
    class function ClassToVar(AClass: TActionListCollection_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TActionListCollection_sc;
  end;

  TActionProc_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(AClient: TActionClient);
  end;

  TActionProc_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TActionProc): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionProc;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TActionProc;
  end;

  TActionClientsCollection_sc = class of TActionClientsCollection;
  TActionClientsCollection_sw = class(TOwnedCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TActionClientsCollection): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionClientsCollection;
    class function ClassToVar(AClass: TActionClientsCollection_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TActionClientsCollection_sc;
  end;

  TBackgroundLayout_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TBackgroundLayout): OleVariant;
    class function FromVar(const AValue: OleVariant): TBackgroundLayout;
  end;

  TChangesAllowed_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TChangesAllowed): OleVariant;
    class function FromVar(const AValue: OleVariant): TChangesAllowed;
  end;

  TChangesAllowedSet_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TChangesAllowedSet): OleVariant;
    class function FromVar(const AValue: OleVariant): TChangesAllowedSet;
  end;

  TActionClient_sc = class of TActionClient;
  TActionClient_sw = class(TCollectionItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TActionClient): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionClient;
    class function ClassToVar(AClass: TActionClient_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TActionClient_sc;
  end;

  TActionBarItem_sc = class of TActionBarItem;
  TActionBarItem_sw = class(TActionClient_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TActionBarItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionBarItem;
    class function ClassToVar(AClass: TActionBarItem_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TActionBarItem_sc;
  end;

  TActionBars_sc = class of TActionBars;
  TActionBars_sw = class(TActionClientsCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TActionBars): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionBars;
    class function ClassToVar(AClass: TActionBars_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TActionBars_sc;
  end;

  TActionClientClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TActionClientClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionClientClass;
  end;

  TCaptionOptions_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TCaptionOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TCaptionOptions;
  end;

  TActionClients_sc = class of TActionClients;
  TActionClients_sw = class(TActionClientsCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TActionClients): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionClients;
    class function ClassToVar(AClass: TActionClients_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TActionClients_sc;
  end;

  TActionClientLinkClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TActionClientLinkClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionClientLinkClass;
  end;

  TActionClientLink_sc = class of TActionClientLink;
  TActionClientLink_sw = class(TActionLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TActionClientLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionClientLink;
    class function ClassToVar(AClass: TActionClientLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TActionClientLink_sc;
  end;

  TMergeRange_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TMergeRange): OleVariant;
    class function FromVar(const AValue: OleVariant): TMergeRange;
  end;

  TActionClientItem_sc = class of TActionClientItem;
  TActionClientItem_sw = class(TActionClient_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TActionClientItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionClientItem;
    class function ClassToVar(AClass: TActionClientItem_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TActionClientItem_sc;
  end;

  TCustomActionClass_sc = class of TCustomActionClass;
  TCustomActionClass_sw = class(TCustomAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomActionClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomActionClass;
    class function ClassToVar(AClass: TCustomActionClass_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomActionClass_sc;
  end;

  TActionDragObject_sc = class of TActionDragObject;
  TActionDragObject_sw = class(TDragObjectEx_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TActionDragObject): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionDragObject;
    class function ClassToVar(AClass: TActionDragObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TActionDragObject_sc;
  end;

  TCategoryDragObject_sc = class of TCategoryDragObject;
  TCategoryDragObject_sw = class(TActionDragObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCategoryDragObject): OleVariant;
    class function FromVar(const AValue: OleVariant): TCategoryDragObject;
    class function ClassToVar(AClass: TCategoryDragObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCategoryDragObject_sc;
  end;

  TActionItemDragObject_sc = class of TActionItemDragObject;
  TActionItemDragObject_sw = class(TDragObjectEx_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TActionItemDragObject): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionItemDragObject;
    class function ClassToVar(AClass: TActionItemDragObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TActionItemDragObject_sc;
  end;

  TCustomActionControlClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TCustomActionControlClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomActionControlClass;
  end;

  TBarOrientation_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TBarOrientation): OleVariant;
    class function FromVar(const AValue: OleVariant): TBarOrientation;
  end;

  TControlCreatedEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; var Control: TCustomActionControl);
  end;

  TControlCreatedEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TControlCreatedEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TControlCreatedEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TControlCreatedEvent;
  end;

  TGetControlClassEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TCustomActionBar; AnItem: TActionClient;
      var ControlClass: TCustomActionControlClass);
  end;

  TGetControlClassEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetControlClassEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetControlClassEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetControlClassEvent;
  end;

  TBarEdge_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TBarEdge): OleVariant;
    class function FromVar(const AValue: OleVariant): TBarEdge;
  end;

  TCustomActionBar_sc = class of TCustomActionBar;
  TCustomActionBar_sw = class(TToolWindow_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomActionBar): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomActionBar;
    class function ClassToVar(AClass: TCustomActionBar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomActionBar_sc;
  end;

  TCMItemMsg_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMItemMsg;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMItemMsg): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMItemMsg;
  end;

  TCustomActionControl_sc = class of TCustomActionControl;
  TCustomActionControl_sw = class(TGraphicControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomActionControl): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomActionControl;
    class function ClassToVar(AClass: TCustomActionControl_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomActionControl_sc;
  end;

  TXToolDockForm_sc = class of TXToolDockForm;
  TXToolDockForm_sw = class(TToolDockForm_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TXToolDockForm): OleVariant;
    class function FromVar(const AValue: OleVariant): TXToolDockForm;
    class function ClassToVar(AClass: TXToolDockForm_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TXToolDockForm_sc;
  end;


{ Unit wrapper }

type
  ActnMan_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TCustomActionManager_sacc = class(TCustomActionManager);
  TActionClientsCollection_sacc = class(TActionClientsCollection);
  TActionClient_sacc = class(TActionClient);
  TActionBarItem_sacc = class(TActionBarItem);
  TCustomActionBar_sacc = class(TCustomActionBar);
  TCustomActionControl_sacc = class(TCustomActionControl);

{ TActionClientItemClass_sw }

class function TActionClientItemClass_sw.GetTypeName: WideString;
begin
  Result := 'TActionClientItemClass';
end;

class function TActionClientItemClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TActionClientItem;
end;

class function TActionClientItemClass_sw.ToVar(
  const AValue: TActionClientItemClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionClientItemClass_sw.FromVar(
  const AValue: OleVariant): TActionClientItemClass;
begin
  Result := TActionClientItemClass(ConvFromVar(AValue, TActionClientItem));
end;

{ TActionClientsClass_sw }

class function TActionClientsClass_sw.GetTypeName: WideString;
begin
  Result := 'TActionClientsClass';
end;

class function TActionClientsClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TActionClients;
end;

class function TActionClientsClass_sw.ToVar(
  const AValue: TActionClientsClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionClientsClass_sw.FromVar(
  const AValue: OleVariant): TActionClientsClass;
begin
  Result := TActionClientsClass(ConvFromVar(AValue, TActionClients));
end;

{ TActionBarsClass_sw }

class function TActionBarsClass_sw.GetTypeName: WideString;
begin
  Result := 'TActionBarsClass';
end;

class function TActionBarsClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TActionBars;
end;

class function TActionBarsClass_sw.ToVar(
  const AValue: TActionBarsClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionBarsClass_sw.FromVar(
  const AValue: OleVariant): TActionBarsClass;
begin
  Result := TActionBarsClass(ConvFromVar(AValue, TActionBars));
end;

{ TActionBarItemClass_sw }

class function TActionBarItemClass_sw.GetTypeName: WideString;
begin
  Result := 'TActionBarItemClass';
end;

class function TActionBarItemClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TActionBarItem;
end;

class function TActionBarItemClass_sw.ToVar(
  const AValue: TActionBarItemClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionBarItemClass_sw.FromVar(
  const AValue: OleVariant): TActionBarItemClass;
begin
  Result := TActionBarItemClass(ConvFromVar(AValue, TActionBarItem));
end;

{ TCustomActionManager_sw }

function TCustomActionManager_Loading_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Loading: Boolean read <getter>;

  Result := TCustomActionManager_sacc(TCustomActionManager(AObj)).Loading;
end;

function TCustomActionManager_LoadFromFile_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromFile(const Filename: string);

  TCustomActionManager(AObj).LoadFromFile(string(AArgs[0]));
end;

function TCustomActionManager_LoadFromStream_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromStream(S: TStream);

  TCustomActionManager(AObj).LoadFromStream(TStream_sw.FromVar(AArgs[0]));
end;

function TCustomActionManager_ResetActionBar_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ResetActionBar(Index: Integer);

  TCustomActionManager(AObj).ResetActionBar(Integer(AArgs[0]));
end;

function TCustomActionManager_ResetUsageData_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ResetUsageData;

  TCustomActionManager(AObj).ResetUsageData();
end;

function TCustomActionManager_SaveToFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SaveToFile(const Filename: string);

  TCustomActionManager(AObj).SaveToFile(string(AArgs[0]));
end;

function TCustomActionManager_SaveToStream_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SaveToStream(S: TStream);

  TCustomActionManager(AObj).SaveToStream(TStream_sw.FromVar(AArgs[0]));
end;

function TCustomActionManager_ActionBars_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionBars: TActionBars read <getter> write <set...

  if IsGet then
    Result := TActionBars_sw.ToVar(TCustomActionManager(AObj).ActionBars)
  else
    TCustomActionManager(AObj).ActionBars := TActionBars_sw.FromVar(AArgs[0]);
end;

function TCustomActionManager_DefaultActionBars_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefaultActionBars: TActionBars read <getter>;

  Result := TActionBars_sw.ToVar(TCustomActionManager(AObj).DefaultActionBars);
end;

function TCustomActionManager_LinkedActionLists_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LinkedActionLists: TActionListCollection read <g...

  if IsGet then
    Result := TActionListCollection_sw.ToVar(TCustomActionManager(AObj).
      LinkedActionLists)
  else
    TCustomActionManager(AObj).LinkedActionLists := TActionListCollection_sw.
      FromVar(AArgs[0]);
end;

function TCustomActionManager_FileName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FileName: TFileName read <getter> write <setter>;

  if IsGet then
    Result := TFileName_sw.ToVar(TCustomActionManager(AObj).FileName)
  else
    TCustomActionManager(AObj).FileName := TFileName_sw.FromVar(AArgs[0]);
end;

function TCustomActionManager_PrioritySchedule_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PrioritySchedule: TStringList read <getter> writ...

  if IsGet then
    Result := TStringList_sw.ToVar(TCustomActionManager(AObj).PrioritySchedule)
  else
    TCustomActionManager(AObj).PrioritySchedule := TStringList_sw.FromVar(
      AArgs[0]);
end;

class function TCustomActionManager_sw.GetTypeName: WideString;
begin
  Result := 'TCustomActionManager';
end;

class function TCustomActionManager_sw.GetWrappedClass: TClass;
begin
  Result := TCustomActionManager;
end;

class procedure TCustomActionManager_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Loading', TCustomActionManager_Loading_si, Boolean_sw, True, False, 0, True, False);
  AData.AddProcedure('LoadFromFile', TCustomActionManager_LoadFromFile_si, 1, False);
  AData.AddProcedure('LoadFromStream', TCustomActionManager_LoadFromStream_si, 1, False);
  AData.AddProcedure('ResetActionBar', TCustomActionManager_ResetActionBar_si, 1, False);
  AData.AddProcedure('ResetUsageData', TCustomActionManager_ResetUsageData_si, 0, False);
  AData.AddProcedure('SaveToFile', TCustomActionManager_SaveToFile_si, 1, False);
  AData.AddProcedure('SaveToStream', TCustomActionManager_SaveToStream_si, 1, False);
  AData.AddProperty('ActionBars', TCustomActionManager_ActionBars_si, TActionBars_sw, True, True, 0, False, False);
  AData.AddProperty('DefaultActionBars', TCustomActionManager_DefaultActionBars_si, TActionBars_sw, True, False, 0, False, False);
  AData.AddProperty('LinkedActionLists', TCustomActionManager_LinkedActionLists_si, TActionListCollection_sw, True, True, 0, False, False);
  AData.AddProperty('FileName', TCustomActionManager_FileName_si, TFileName_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Images', False);
  AData.AddProperty('PrioritySchedule', TCustomActionManager_PrioritySchedule_si, TStringList_sw, True, True, 0, False, False);
end;

class function TCustomActionManager_sw.ToVar(
  const AValue: TCustomActionManager): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomActionManager_sw.FromVar(
  const AValue: OleVariant): TCustomActionManager;
begin
  Result := TCustomActionManager(ConvFromVar(AValue, TCustomActionManager));
end;

class function TCustomActionManager_sw.ClassToVar(
  AClass: TCustomActionManager_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomActionManager_sw.ClassFromVar(
  const AClass: OleVariant): TCustomActionManager_sc;
begin
  Result := TCustomActionManager_sc(ConvClsFromVar(AClass, 
    TCustomActionManager));
end;

{ TActionManager_sw }

class function TActionManager_sw.GetTypeName: WideString;
begin
  Result := 'TActionManager';
end;

class function TActionManager_sw.GetWrappedClass: TClass;
begin
  Result := TActionManager;
end;

class procedure TActionManager_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('FileName', False);
  AData.AddPropertyRedecl('ActionBars', False);
  AData.AddPropertyRedecl('LinkedActionLists', False);
  AData.AddPropertyRedecl('Images', False);
  AData.AddPropertyRedecl('PrioritySchedule', False);
  AData.AddPropertyRedecl('State', False);
  AData.AddPropertyRedecl('OnChange', False);
  AData.AddPropertyRedecl('OnExecute', False);
  AData.AddPropertyRedecl('OnUpdate', False);
end;

class function TActionManager_sw.ToVar(
  const AValue: TActionManager): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionManager_sw.FromVar(
  const AValue: OleVariant): TActionManager;
begin
  Result := TActionManager(ConvFromVar(AValue, TActionManager));
end;

class function TActionManager_sw.ClassToVar(
  AClass: TActionManager_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TActionManager_sw.ClassFromVar(
  const AClass: OleVariant): TActionManager_sc;
begin
  Result := TActionManager_sc(ConvClsFromVar(AClass, TActionManager));
end;

{ TActionListItem_sw }

function TActionListItem_ActionList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionList: TCustomActionList read <getter> writ...

  if IsGet then
    Result := TCustomActionList_sw.ToVar(TActionListItem(AObj).ActionList)
  else
    TActionListItem(AObj).ActionList := TCustomActionList_sw.FromVar(AArgs[0]);
end;

function TActionListItem_Caption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Caption: string read <getter> write <setter>;

  if IsGet then
    Result := TActionListItem(AObj).Caption
  else
    TActionListItem(AObj).Caption := string(AArgs[0]);
end;

class function TActionListItem_sw.GetTypeName: WideString;
begin
  Result := 'TActionListItem';
end;

class function TActionListItem_sw.GetWrappedClass: TClass;
begin
  Result := TActionListItem;
end;

class procedure TActionListItem_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ActionList', TActionListItem_ActionList_si, TCustomActionList_sw, True, True, 0, False, False);
  AData.AddProperty('Caption', TActionListItem_Caption_si, string_sw, True, True, 0, False, False);
end;

class function TActionListItem_sw.ToVar(
  const AValue: TActionListItem): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionListItem_sw.FromVar(
  const AValue: OleVariant): TActionListItem;
begin
  Result := TActionListItem(ConvFromVar(AValue, TActionListItem));
end;

class function TActionListItem_sw.ClassToVar(
  AClass: TActionListItem_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TActionListItem_sw.ClassFromVar(
  const AClass: OleVariant): TActionListItem_sc;
begin
  Result := TActionListItem_sc(ConvClsFromVar(AClass, TActionListItem));
end;

{ TActionListCollection_sw }

function TActionListCollection_ActionManager_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionManager: TCustomActionManager read <getter>;

  Result := TCustomActionManager_sw.ToVar(TActionListCollection(AObj).
    ActionManager);
end;

function TActionListCollection_ListItems_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ListItems[Index: Integer]: TActionListItem read ...

  if IsGet then
    Result := TActionListItem_sw.ToVar(TActionListCollection(AObj).
      ListItems[Integer(AArgs[0])])
  else
    TActionListCollection(AObj).ListItems[Integer(AArgs[0])] := 
      TActionListItem_sw.FromVar(AArgs[1]);
end;

class function TActionListCollection_sw.GetTypeName: WideString;
begin
  Result := 'TActionListCollection';
end;

class function TActionListCollection_sw.GetWrappedClass: TClass;
begin
  Result := TActionListCollection;
end;

class procedure TActionListCollection_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ActionManager', TActionListCollection_ActionManager_si, TCustomActionManager_sw, True, False, 0, False, False);
  AData.AddProperty('ListItems', TActionListCollection_ListItems_si, TActionListItem_sw, True, True, 1, False, True);
end;

class function TActionListCollection_sw.ToVar(
  const AValue: TActionListCollection): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionListCollection_sw.FromVar(
  const AValue: OleVariant): TActionListCollection;
begin
  Result := TActionListCollection(ConvFromVar(AValue, TActionListCollection));
end;

class function TActionListCollection_sw.ClassToVar(
  AClass: TActionListCollection_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TActionListCollection_sw.ClassFromVar(
  const AClass: OleVariant): TActionListCollection_sc;
begin
  Result := TActionListCollection_sc(ConvClsFromVar(AClass, 
    TActionListCollection));
end;

{ TActionProc_sh }

function TActionProc_sh.GetHandler: TMethod;
var
  hdr: TActionProc;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TActionProc_sh.Handler(AClient: TActionClient);
var
  args: array[0..0] of OleVariant;
begin
  // procedure (AClient: TActionClient) of object

  args[0] := TActionClient_sw.ToVar(AClient);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TActionProc_sw }

class function TActionProc_sw.GetTypeName: WideString;
begin
  Result := 'TActionProc';
end;

class function TActionProc_sw.GetScriptHandlerClass: TClass;
begin
  Result := TActionProc_sh;
end;

class function TActionProc_sw.ToVar(const AValue: TActionProc): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TActionProc_sw.FromVar(const AValue: OleVariant): TActionProc;
begin
  Result := TActionProc(ConvFromVar(AValue));
end;

class function TActionProc_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TActionProc;
var
  hdlr: TActionProc_sh;
begin
  hdlr   := TActionProc_sh(AScriptControl.GetEventHandler(AProcName, 
    TActionProc_sw));
  Result := hdlr.Handler;
end;

{ TActionClientsCollection_sw }

function TActionClientsCollection_ActionClients_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ActionClients[const Index: Integer]: T...

  if IsGet then
    Result := TActionClient_sw.ToVar(TActionClientsCollection_sacc(
      TActionClientsCollection(AObj)).ActionClients[Integer(AArgs[0])])
  else
    TActionClientsCollection_sacc(TActionClientsCollection(AObj)).
      ActionClients[Integer(AArgs[0])] := TActionClient_sw.FromVar(AArgs[1]);
end;

function TActionClientsCollection_ParentItem_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ParentItem: TActionClient read <getter...

  if IsGet then
    Result := TActionClient_sw.ToVar(TActionClientsCollection_sacc(
      TActionClientsCollection(AObj)).ParentItem)
  else
    TActionClientsCollection_sacc(TActionClientsCollection(AObj)).ParentItem := 
      TActionClient_sw.FromVar(AArgs[0]);
end;

function TActionClientsCollection_ActionManager_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionManager: TCustomActionManager read <getter>;

  Result := TCustomActionManager_sw.ToVar(TActionClientsCollection(AObj).
    ActionManager);
end;

function TActionClientsCollection_Customizable_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Customizable: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TActionClientsCollection(AObj).Customizable
  else
    TActionClientsCollection(AObj).Customizable := Boolean(AArgs[0]);
end;

class function TActionClientsCollection_sw.GetTypeName: WideString;
begin
  Result := 'TActionClientsCollection';
end;

class function TActionClientsCollection_sw.GetWrappedClass: TClass;
begin
  Result := TActionClientsCollection;
end;

class procedure TActionClientsCollection_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ActionClients', TActionClientsCollection_ActionClients_si, TActionClient_sw, True, True, 1, True, True);
  AData.AddProperty('ParentItem', TActionClientsCollection_ParentItem_si, TActionClient_sw, True, True, 0, True, False);
  AData.AddProperty('ActionManager', TActionClientsCollection_ActionManager_si, TCustomActionManager_sw, True, False, 0, False, False);
  AData.AddProperty('Customizable', TActionClientsCollection_Customizable_si, Boolean_sw, True, True, 0, False, False);
end;

class function TActionClientsCollection_sw.ToVar(
  const AValue: TActionClientsCollection): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionClientsCollection_sw.FromVar(
  const AValue: OleVariant): TActionClientsCollection;
begin
  Result := TActionClientsCollection(ConvFromVar(AValue, 
    TActionClientsCollection));
end;

class function TActionClientsCollection_sw.ClassToVar(
  AClass: TActionClientsCollection_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TActionClientsCollection_sw.ClassFromVar(
  const AClass: OleVariant): TActionClientsCollection_sc;
begin
  Result := TActionClientsCollection_sc(ConvClsFromVar(AClass, 
    TActionClientsCollection));
end;

{ TBackgroundLayout_sw }

class function TBackgroundLayout_sw.GetTypeName: WideString;
begin
  Result := 'TBackgroundLayout';
end;

class procedure TBackgroundLayout_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'blNormal'; Value: Integer({$IFDEF LMDSCT_12}TBackgroundLayout.{$ENDIF}blNormal)),
    (Name: 'blStretch'; Value: Integer({$IFDEF LMDSCT_12}TBackgroundLayout.{$ENDIF}blStretch)),
    (Name: 'blTile'; Value: Integer({$IFDEF LMDSCT_12}TBackgroundLayout.{$ENDIF}blTile)),
    (Name: 'blLeftBanner'; Value: Integer({$IFDEF LMDSCT_12}TBackgroundLayout.{$ENDIF}blLeftBanner)),
    (Name: 'blRightBanner'; Value: Integer({$IFDEF LMDSCT_12}TBackgroundLayout.{$ENDIF}blRightBanner))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TBackgroundLayout_sw.ToVar(
  const AValue: TBackgroundLayout): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBackgroundLayout_sw.FromVar(
  const AValue: OleVariant): TBackgroundLayout;
begin
  Result := TBackgroundLayout(Integer(AValue));
end;

{ TChangesAllowed_sw }

class function TChangesAllowed_sw.GetTypeName: WideString;
begin
  Result := 'TChangesAllowed';
end;

class procedure TChangesAllowed_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'caModify'; Value: Integer({$IFDEF LMDSCT_12}TChangesAllowed.{$ENDIF}caModify)),
    (Name: 'caMove'; Value: Integer({$IFDEF LMDSCT_12}TChangesAllowed.{$ENDIF}caMove)),
    (Name: 'caDelete'; Value: Integer({$IFDEF LMDSCT_12}TChangesAllowed.{$ENDIF}caDelete))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TChangesAllowed_sw.ToVar(
  const AValue: TChangesAllowed): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TChangesAllowed_sw.FromVar(
  const AValue: OleVariant): TChangesAllowed;
begin
  Result := TChangesAllowed(Integer(AValue));
end;

{ TChangesAllowedSet_sw }

class function TChangesAllowedSet_sw.GetTypeName: WideString;
begin
  Result := 'TChangesAllowedSet';
end;

class function TChangesAllowedSet_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TChangesAllowedSet);
end;

class function TChangesAllowedSet_sw.ToVar(
  const AValue: TChangesAllowedSet): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TChangesAllowedSet_sw.FromVar(
  const AValue: OleVariant): TChangesAllowedSet;
begin
  ConvFromVar(AValue, @Result);
end;

{ TActionClient_sw }

function TActionClient_OwningCollection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OwningCollection: TActionClientsCollec...

  Result := TActionClientsCollection_sw.ToVar(TActionClient_sacc(TActionClient(
    AObj)).OwningCollection);
end;

function TActionClient_HasBackground_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HasBackground: Boolean;

  Result := TActionClient(AObj).HasBackground();
end;

function TActionClient_Refresh_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Refresh;

  TActionClient(AObj).Refresh();
end;

function TActionClient_ActionBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionBar: TCustomActionBar read <getter> write ...

  if IsGet then
    Result := TCustomActionBar_sw.ToVar(TActionClient(AObj).ActionBar)
  else
    TActionClient(AObj).ActionBar := TCustomActionBar_sw.FromVar(AArgs[0]);
end;

function TActionClient_ChildActionBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ChildActionBar: TCustomActionBar read <getter> w...

  if IsGet then
    Result := TCustomActionBar_sw.ToVar(TActionClient(AObj).ChildActionBar)
  else
    TActionClient(AObj).ChildActionBar := TCustomActionBar_sw.FromVar(AArgs[0]);
end;

function TActionClient_HasItems_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HasItems: Boolean read <getter>;

  Result := TActionClient(AObj).HasItems;
end;

function TActionClient_ChangesAllowed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ChangesAllowed: TChangesAllowedSet read <getter>...

  if IsGet then
    Result := TChangesAllowedSet_sw.ToVar(TActionClient(AObj).ChangesAllowed)
  else
    TActionClient(AObj).ChangesAllowed := TChangesAllowedSet_sw.FromVar(
      AArgs[0]);
end;

function TActionClient_Color_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Color: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TActionClient(AObj).Color)
  else
    TActionClient(AObj).Color := TColor_sw.FromVar(AArgs[0]);
end;

function TActionClient_ContextItems_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ContextItems: TActionClients read <getter> write...

  if IsGet then
    Result := TActionClients_sw.ToVar(TActionClient(AObj).ContextItems)
  else
    TActionClient(AObj).ContextItems := TActionClients_sw.FromVar(AArgs[0]);
end;

function TActionClient_Background_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Background: TPicture read <getter> write <setter>;

  if IsGet then
    Result := TPicture_sw.ToVar(TActionClient(AObj).Background)
  else
    TActionClient(AObj).Background := TPicture_sw.FromVar(AArgs[0]);
end;

function TActionClient_BackgroundLayout_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BackgroundLayout: TBackgroundLayout read <getter...

  if IsGet then
    Result := TBackgroundLayout_sw.ToVar(TActionClient(AObj).BackgroundLayout)
  else
    TActionClient(AObj).BackgroundLayout := TBackgroundLayout_sw.FromVar(
      AArgs[0]);
end;

function TActionClient_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items: TActionClients read <getter> write <setter>;

  if IsGet then
    Result := TActionClients_sw.ToVar(TActionClient(AObj).Items)
  else
    TActionClient(AObj).Items := TActionClients_sw.FromVar(AArgs[0]);
end;

function TActionClient_Visible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Visible: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TActionClient(AObj).Visible
  else
    TActionClient(AObj).Visible := Boolean(AArgs[0]);
end;

class function TActionClient_sw.GetTypeName: WideString;
begin
  Result := 'TActionClient';
end;

class function TActionClient_sw.GetWrappedClass: TClass;
begin
  Result := TActionClient;
end;

class procedure TActionClient_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('OwningCollection', TActionClient_OwningCollection_si, TActionClientsCollection_sw, True, False, 0, True, False);
  AData.AddFunction('HasBackground', TActionClient_HasBackground_si, Boolean_sw, 0, False);
  AData.AddProcedure('Refresh', TActionClient_Refresh_si, 0, False);
  AData.AddProperty('ActionBar', TActionClient_ActionBar_si, TCustomActionBar_sw, True, True, 0, False, False);
  AData.AddProperty('ChildActionBar', TActionClient_ChildActionBar_si, TCustomActionBar_sw, True, True, 0, False, False);
  AData.AddProperty('HasItems', TActionClient_HasItems_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('ChangesAllowed', TActionClient_ChangesAllowed_si, TChangesAllowedSet_sw, True, True, 0, False, False);
  AData.AddProperty('Color', TActionClient_Color_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('ContextItems', TActionClient_ContextItems_si, TActionClients_sw, True, True, 0, False, False);
  AData.AddProperty('Background', TActionClient_Background_si, TPicture_sw, True, True, 0, False, False);
  AData.AddProperty('BackgroundLayout', TActionClient_BackgroundLayout_si, TBackgroundLayout_sw, True, True, 0, False, False);
  AData.AddProperty('Items', TActionClient_Items_si, TActionClients_sw, True, True, 0, False, False);
  AData.AddProperty('Visible', TActionClient_Visible_si, Boolean_sw, True, True, 0, False, False);
end;

class function TActionClient_sw.ToVar(const AValue: TActionClient): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionClient_sw.FromVar(
  const AValue: OleVariant): TActionClient;
begin
  Result := TActionClient(ConvFromVar(AValue, TActionClient));
end;

class function TActionClient_sw.ClassToVar(
  AClass: TActionClient_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TActionClient_sw.ClassFromVar(
  const AClass: OleVariant): TActionClient_sc;
begin
  Result := TActionClient_sc(ConvClsFromVar(AClass, TActionClient));
end;

{ TActionBarItem_sw }

function TActionBarItem_ActionBars_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ActionBars: TActionBars read <getter>;

  Result := TActionBars_sw.ToVar(TActionBarItem_sacc(TActionBarItem(AObj)).
    ActionBars);
end;

function TActionBarItem_AutoSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoSize: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TActionBarItem(AObj).AutoSize
  else
    TActionBarItem(AObj).AutoSize := Boolean(AArgs[0]);
end;

function TActionBarItem_GlyphLayout_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GlyphLayout: TButtonLayout read <getter> write <...

  if IsGet then
    Result := TButtonLayout_sw.ToVar(TActionBarItem(AObj).GlyphLayout)
  else
    TActionBarItem(AObj).GlyphLayout := TButtonLayout_sw.FromVar(AArgs[0]);
end;

class function TActionBarItem_sw.GetTypeName: WideString;
begin
  Result := 'TActionBarItem';
end;

class function TActionBarItem_sw.GetWrappedClass: TClass;
begin
  Result := TActionBarItem;
end;

class procedure TActionBarItem_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ActionBars', TActionBarItem_ActionBars_si, TActionBars_sw, True, False, 0, True, False);
  AData.AddPropertyRedecl('ActionBar', False);
  AData.AddProperty('AutoSize', TActionBarItem_AutoSize_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('GlyphLayout', TActionBarItem_GlyphLayout_si, TButtonLayout_sw, True, True, 0, False, False);
end;

class function TActionBarItem_sw.ToVar(
  const AValue: TActionBarItem): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionBarItem_sw.FromVar(
  const AValue: OleVariant): TActionBarItem;
begin
  Result := TActionBarItem(ConvFromVar(AValue, TActionBarItem));
end;

class function TActionBarItem_sw.ClassToVar(
  AClass: TActionBarItem_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TActionBarItem_sw.ClassFromVar(
  const AClass: OleVariant): TActionBarItem_sc;
begin
  Result := TActionBarItem_sc(ConvClsFromVar(AClass, TActionBarItem));
end;

{ TActionBars_sw }

function TActionBars_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AOwner: TPersistent; ItemClass: TColle...

  Result := TActionBars_sw.ToVar(TActionBars_sc(AObj).Create(TPersistent_sw.
    FromVar(AArgs[0]), TCollectionItemClass_sw.FromVar(AArgs[1])));
end;

function TActionBars_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add: TActionBarItem;

  Result := TActionBarItem_sw.ToVar(TActionBars(AObj).Add());
end;

function TActionBars_ActionBars_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionBars[const Index: Integer]: TActionBarItem...

  Result := TActionBarItem_sw.ToVar(TActionBars(AObj).ActionBars[Integer(
    AArgs[0])]);
end;

function TActionBars_HintShortCuts_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HintShortCuts: Boolean read <getter> write <sett...

  if IsGet then
    Result := TActionBars(AObj).HintShortCuts
  else
    TActionBars(AObj).HintShortCuts := Boolean(AArgs[0]);
end;

function TActionBars_SessionCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SessionCount: Integer read <getter> write <setter>;

  if IsGet then
    Result := TActionBars(AObj).SessionCount
  else
    TActionBars(AObj).SessionCount := Integer(AArgs[0]);
end;

function TActionBars_ShowHints_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShowHints: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TActionBars(AObj).ShowHints
  else
    TActionBars(AObj).ShowHints := Boolean(AArgs[0]);
end;

class function TActionBars_sw.GetTypeName: WideString;
begin
  Result := 'TActionBars';
end;

class function TActionBars_sw.GetWrappedClass: TClass;
begin
  Result := TActionBars;
end;

class procedure TActionBars_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TActionBars_Add_si, TActionBarItem_sw, 0, False);
  AData.AddProperty('ActionBars', TActionBars_ActionBars_si, TActionBarItem_sw, True, False, 1, False, True);
  AData.AddPropertyRedecl('Customizable', False);
  AData.AddProperty('HintShortCuts', TActionBars_HintShortCuts_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('SessionCount', TActionBars_SessionCount_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('ShowHints', TActionBars_ShowHints_si, Boolean_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TActionBars_Create_si, 2, False);
end;

class function TActionBars_sw.ToVar(const AValue: TActionBars): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionBars_sw.FromVar(const AValue: OleVariant): TActionBars;
begin
  Result := TActionBars(ConvFromVar(AValue, TActionBars));
end;

class function TActionBars_sw.ClassToVar(AClass: TActionBars_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TActionBars_sw.ClassFromVar(
  const AClass: OleVariant): TActionBars_sc;
begin
  Result := TActionBars_sc(ConvClsFromVar(AClass, TActionBars));
end;

{ TActionClientClass_sw }

class function TActionClientClass_sw.GetTypeName: WideString;
begin
  Result := 'TActionClientClass';
end;

class function TActionClientClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TActionClient;
end;

class function TActionClientClass_sw.ToVar(
  const AValue: TActionClientClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionClientClass_sw.FromVar(
  const AValue: OleVariant): TActionClientClass;
begin
  Result := TActionClientClass(ConvFromVar(AValue, TActionClient));
end;

{ TCaptionOptions_sw }

class function TCaptionOptions_sw.GetTypeName: WideString;
begin
  Result := 'TCaptionOptions';
end;

class procedure TCaptionOptions_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'coNone'; Value: Integer({$IFDEF LMDSCT_12}TCaptionOptions.{$ENDIF}coNone)),
    (Name: 'coSelective'; Value: Integer({$IFDEF LMDSCT_12}TCaptionOptions.{$ENDIF}coSelective)),
    (Name: 'coAll'; Value: Integer({$IFDEF LMDSCT_12}TCaptionOptions.{$ENDIF}coAll))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TCaptionOptions_sw.ToVar(
  const AValue: TCaptionOptions): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TCaptionOptions_sw.FromVar(
  const AValue: OleVariant): TCaptionOptions;
begin
  Result := TCaptionOptions(Integer(AValue));
end;

{ TActionClients_sw }

function TActionClients_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AOwner: TPersistent; ItemClass: TColle...

  Result := TActionClients_sw.ToVar(TActionClients_sc(AObj).Create(
    TPersistent_sw.FromVar(AArgs[0]), TCollectionItemClass_sw.FromVar(AArgs[1])));
end;

function TActionClients_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add: TActionClientItem;

  Result := TActionClientItem_sw.ToVar(TActionClients(AObj).Add());
end;

function TActionClients_VisibleCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VisibleCount: Integer;

  Result := TActionClients(AObj).VisibleCount();
end;

function TActionClients_ActionClients_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionClients[const Index: Integer]: TActionClie...

  if IsGet then
    Result := TActionClientItem_sw.ToVar(TActionClients(AObj).
      ActionClients[Integer(AArgs[0])])
  else
    TActionClients(AObj).ActionClients[Integer(AArgs[0])] := 
      TActionClientItem_sw.FromVar(AArgs[1]);
end;

function TActionClients_ActionManager_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionManager: TCustomActionManager read <getter>;

  Result := TCustomActionManager_sw.ToVar(TActionClients(AObj).ActionManager);
end;

function TActionClients_AutoHotKeys_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoHotKeys: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TActionClients(AObj).AutoHotKeys
  else
    TActionClients(AObj).AutoHotKeys := Boolean(AArgs[0]);
end;

function TActionClients_HideUnused_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HideUnused: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TActionClients(AObj).HideUnused
  else
    TActionClients(AObj).HideUnused := Boolean(AArgs[0]);
end;

function TActionClients_CaptionOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CaptionOptions: TCaptionOptions read <getter> wr...

  if IsGet then
    Result := TCaptionOptions_sw.ToVar(TActionClients(AObj).CaptionOptions)
  else
    TActionClients(AObj).CaptionOptions := TCaptionOptions_sw.FromVar(AArgs[0]);
end;

function TActionClients_SmallIcons_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SmallIcons: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TActionClients(AObj).SmallIcons
  else
    TActionClients(AObj).SmallIcons := Boolean(AArgs[0]);
end;

class function TActionClients_sw.GetTypeName: WideString;
begin
  Result := 'TActionClients';
end;

class function TActionClients_sw.GetWrappedClass: TClass;
begin
  Result := TActionClients;
end;

class procedure TActionClients_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TActionClients_Add_si, TActionClientItem_sw, 0, False);
  AData.AddFunction('VisibleCount', TActionClients_VisibleCount_si, Integer_sw, 0, False);
  AData.AddProperty('ActionClients', TActionClients_ActionClients_si, TActionClientItem_sw, True, True, 1, False, True);
  AData.AddProperty('ActionManager', TActionClients_ActionManager_si, TCustomActionManager_sw, True, False, 0, False, False);
  AData.AddProperty('AutoHotKeys', TActionClients_AutoHotKeys_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Customizable', False);
  AData.AddProperty('HideUnused', TActionClients_HideUnused_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('CaptionOptions', TActionClients_CaptionOptions_si, TCaptionOptions_sw, True, True, 0, False, False);
  AData.AddProperty('SmallIcons', TActionClients_SmallIcons_si, Boolean_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TActionClients_Create_si, 2, False);
end;

class function TActionClients_sw.ToVar(
  const AValue: TActionClients): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionClients_sw.FromVar(
  const AValue: OleVariant): TActionClients;
begin
  Result := TActionClients(ConvFromVar(AValue, TActionClients));
end;

class function TActionClients_sw.ClassToVar(
  AClass: TActionClients_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TActionClients_sw.ClassFromVar(
  const AClass: OleVariant): TActionClients_sc;
begin
  Result := TActionClients_sc(ConvClsFromVar(AClass, TActionClients));
end;

{ TActionClientLinkClass_sw }

class function TActionClientLinkClass_sw.GetTypeName: WideString;
begin
  Result := 'TActionClientLinkClass';
end;

class function TActionClientLinkClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TActionClientLink;
end;

class function TActionClientLinkClass_sw.ToVar(
  const AValue: TActionClientLinkClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionClientLinkClass_sw.FromVar(
  const AValue: OleVariant): TActionClientLinkClass;
begin
  Result := TActionClientLinkClass(ConvFromVar(AValue, TActionClientLink));
end;

{ TActionClientLink_sw }

class function TActionClientLink_sw.GetTypeName: WideString;
begin
  Result := 'TActionClientLink';
end;

class function TActionClientLink_sw.GetWrappedClass: TClass;
begin
  Result := TActionClientLink;
end;

class procedure TActionClientLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TActionClientLink_sw.ToVar(
  const AValue: TActionClientLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionClientLink_sw.FromVar(
  const AValue: OleVariant): TActionClientLink;
begin
  Result := TActionClientLink(ConvFromVar(AValue, TActionClientLink));
end;

class function TActionClientLink_sw.ClassToVar(
  AClass: TActionClientLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TActionClientLink_sw.ClassFromVar(
  const AClass: OleVariant): TActionClientLink_sc;
begin
  Result := TActionClientLink_sc(ConvClsFromVar(AClass, TActionClientLink));
end;

{ TMergeRange_sw }

class function TMergeRange_sw.GetTypeName: WideString;
begin
  Result := 'TMergeRange';
end;

class function TMergeRange_sw.ToVar(const AValue: TMergeRange): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TMergeRange_sw.FromVar(const AValue: OleVariant): TMergeRange;
begin
  Result := TMergeRange(Integer(AValue));
end;

{ TActionClientItem_sw }

function TActionClientItem_HasGlyph_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HasGlyph: Boolean;

  Result := TActionClientItem(AObj).HasGlyph();
end;

function TActionClientItem_InitiateAction_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure InitiateAction;

  TActionClientItem(AObj).InitiateAction();
end;

function TActionClientItem_Unused_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Unused: Boolean;

  Result := TActionClientItem(AObj).Unused();
end;

function TActionClientItem_ActionClients_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionClients: TActionClients read <getter>;

  Result := TActionClients_sw.ToVar(TActionClientItem(AObj).ActionClients);
end;

function TActionClientItem_ActionLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionLink: TActionClientLink read <getter> writ...

  if IsGet then
    Result := TActionClientLink_sw.ToVar(TActionClientItem(AObj).ActionLink)
  else
    TActionClientItem(AObj).ActionLink := TActionClientLink_sw.FromVar(
      AArgs[0]);
end;

function TActionClientItem_CheckUnused_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CheckUnused: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TActionClientItem(AObj).CheckUnused
  else
    TActionClientItem(AObj).CheckUnused := Boolean(AArgs[0]);
end;

function TActionClientItem_Control_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Control: TCustomActionControl read <getter> writ...

  if IsGet then
    Result := TCustomActionControl_sw.ToVar(TActionClientItem(AObj).Control)
  else
    TActionClientItem(AObj).Control := TCustomActionControl_sw.FromVar(
      AArgs[0]);
end;

function TActionClientItem_ParentItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParentItem: TActionClient read <getter>;

  Result := TActionClient_sw.ToVar(TActionClientItem(AObj).ParentItem);
end;

function TActionClientItem_Separator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Separator: Boolean read <getter>;

  Result := TActionClientItem(AObj).Separator;
end;

function TActionClientItem_ShortCutText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShortCutText: string read <getter>;

  Result := TActionClientItem(AObj).ShortCutText;
end;

function TActionClientItem_Action_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Action: TContainedAction read <getter> write <se...

  if IsGet then
    Result := TContainedAction_sw.ToVar(TActionClientItem(AObj).Action)
  else
    TActionClientItem(AObj).Action := TContainedAction_sw.FromVar(AArgs[0]);
end;

function TActionClientItem_Caption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Caption: string read <getter> write <setter>;

  if IsGet then
    Result := TActionClientItem(AObj).Caption
  else
    TActionClientItem(AObj).Caption := string(AArgs[0]);
end;

function TActionClientItem_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImageIndex: Integer read <getter> write <setter>;

  if IsGet then
    Result := TActionClientItem(AObj).ImageIndex
  else
    TActionClientItem(AObj).ImageIndex := Integer(AArgs[0]);
end;

function TActionClientItem_MergeIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MergeIndex: TMergeRange read <getter> write <set...

  if IsGet then
    Result := TMergeRange_sw.ToVar(TActionClientItem(AObj).MergeIndex)
  else
    TActionClientItem(AObj).MergeIndex := TMergeRange_sw.FromVar(AArgs[0]);
end;

function TActionClientItem_LastSession_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LastSession: Integer read <getter> write <setter>;

  if IsGet then
    Result := TActionClientItem(AObj).LastSession
  else
    TActionClientItem(AObj).LastSession := Integer(AArgs[0]);
end;

function TActionClientItem_ShowCaption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShowCaption: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TActionClientItem(AObj).ShowCaption
  else
    TActionClientItem(AObj).ShowCaption := Boolean(AArgs[0]);
end;

function TActionClientItem_ShowGlyph_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShowGlyph: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TActionClientItem(AObj).ShowGlyph
  else
    TActionClientItem(AObj).ShowGlyph := Boolean(AArgs[0]);
end;

function TActionClientItem_ShowShortCut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShowShortCut: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TActionClientItem(AObj).ShowShortCut
  else
    TActionClientItem(AObj).ShowShortCut := Boolean(AArgs[0]);
end;

function TActionClientItem_ShortCut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShortCut: TShortCut read <getter> write <setter>;

  if IsGet then
    Result := TShortCut_sw.ToVar(TActionClientItem(AObj).ShortCut)
  else
    TActionClientItem(AObj).ShortCut := TShortCut_sw.FromVar(AArgs[0]);
end;

function TActionClientItem_UsageCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property UsageCount: Integer read <getter> write <setter>;

  if IsGet then
    Result := TActionClientItem(AObj).UsageCount
  else
    TActionClientItem(AObj).UsageCount := Integer(AArgs[0]);
end;

class function TActionClientItem_sw.GetTypeName: WideString;
begin
  Result := 'TActionClientItem';
end;

class function TActionClientItem_sw.GetWrappedClass: TClass;
begin
  Result := TActionClientItem;
end;

class procedure TActionClientItem_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('HasGlyph', TActionClientItem_HasGlyph_si, Boolean_sw, 0, False);
  AData.AddProcedure('InitiateAction', TActionClientItem_InitiateAction_si, 0, False);
  AData.AddFunction('Unused', TActionClientItem_Unused_si, Boolean_sw, 0, False);
  AData.AddProperty('ActionClients', TActionClientItem_ActionClients_si, TActionClients_sw, True, False, 0, False, False);
  AData.AddProperty('ActionLink', TActionClientItem_ActionLink_si, TActionClientLink_sw, True, True, 0, False, False);
  AData.AddProperty('CheckUnused', TActionClientItem_CheckUnused_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Control', TActionClientItem_Control_si, TCustomActionControl_sw, True, True, 0, False, False);
  AData.AddProperty('ParentItem', TActionClientItem_ParentItem_si, TActionClient_sw, True, False, 0, False, False);
  AData.AddProperty('Separator', TActionClientItem_Separator_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('ShortCutText', TActionClientItem_ShortCutText_si, string_sw, True, False, 0, False, False);
  AData.AddProperty('Action', TActionClientItem_Action_si, TContainedAction_sw, True, True, 0, False, False);
  AData.AddProperty('Caption', TActionClientItem_Caption_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('ImageIndex', TActionClientItem_ImageIndex_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MergeIndex', TActionClientItem_MergeIndex_si, TMergeRange_sw, True, True, 0, False, False);
  AData.AddProperty('LastSession', TActionClientItem_LastSession_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('ShowCaption', TActionClientItem_ShowCaption_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ShowGlyph', TActionClientItem_ShowGlyph_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ShowShortCut', TActionClientItem_ShowShortCut_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ShortCut', TActionClientItem_ShortCut_si, TShortCut_sw, True, True, 0, False, False);
  AData.AddProperty('UsageCount', TActionClientItem_UsageCount_si, Integer_sw, True, True, 0, False, False);
end;

class function TActionClientItem_sw.ToVar(
  const AValue: TActionClientItem): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionClientItem_sw.FromVar(
  const AValue: OleVariant): TActionClientItem;
begin
  Result := TActionClientItem(ConvFromVar(AValue, TActionClientItem));
end;

class function TActionClientItem_sw.ClassToVar(
  AClass: TActionClientItem_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TActionClientItem_sw.ClassFromVar(
  const AClass: OleVariant): TActionClientItem_sc;
begin
  Result := TActionClientItem_sc(ConvClsFromVar(AClass, TActionClientItem));
end;

{ TCustomActionClass_sw }

class function TCustomActionClass_sw.GetTypeName: WideString;
begin
  Result := 'TCustomActionClass';
end;

class function TCustomActionClass_sw.GetWrappedClass: TClass;
begin
  Result := TCustomActionClass;
end;

class procedure TCustomActionClass_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TCustomActionClass_sw.ToVar(
  const AValue: TCustomActionClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomActionClass_sw.FromVar(
  const AValue: OleVariant): TCustomActionClass;
begin
  Result := TCustomActionClass(ConvFromVar(AValue, TCustomActionClass));
end;

class function TCustomActionClass_sw.ClassToVar(
  AClass: TCustomActionClass_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomActionClass_sw.ClassFromVar(
  const AClass: OleVariant): TCustomActionClass_sc;
begin
  Result := TCustomActionClass_sc(ConvClsFromVar(AClass, TCustomActionClass));
end;

{ TActionDragObject_sw }

function TActionDragObject_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TActionDragObject_sw.ToVar(TActionDragObject_sc(AObj).Create());
end;

function TActionDragObject_AddAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AddAction(AnAction: TContainedAction);

  TActionDragObject(AObj).AddAction(TContainedAction_sw.FromVar(AArgs[0]));
end;

function TActionDragObject_AddActionClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AddActionClass(AnActionClass: TCustomActionClass);

  TActionDragObject(AObj).AddActionClass(TCustomActionClass_sw.FromVar(
    AArgs[0]));
end;

function TActionDragObject_ActionCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionCount: Integer read <getter>;

  Result := TActionDragObject(AObj).ActionCount;
end;

function TActionDragObject_ActionManager_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionManager: TCustomActionManager read <getter...

  if IsGet then
    Result := TCustomActionManager_sw.ToVar(TActionDragObject(AObj).
      ActionManager)
  else
    TActionDragObject(AObj).ActionManager := TCustomActionManager_sw.FromVar(
      AArgs[0]);
end;

function TActionDragObject_Actions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Actions[Index: Integer]: TContainedAction read <...

  Result := TContainedAction_sw.ToVar(TActionDragObject(AObj).Actions[Integer(
    AArgs[0])]);
end;

class function TActionDragObject_sw.GetTypeName: WideString;
begin
  Result := 'TActionDragObject';
end;

class function TActionDragObject_sw.GetWrappedClass: TClass;
begin
  Result := TActionDragObject;
end;

class procedure TActionDragObject_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('AddAction', TActionDragObject_AddAction_si, 1, False);
  AData.AddProcedure('AddActionClass', TActionDragObject_AddActionClass_si, 1, False);
  AData.AddProperty('ActionCount', TActionDragObject_ActionCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('ActionManager', TActionDragObject_ActionManager_si, TCustomActionManager_sw, True, True, 0, False, False);
  AData.AddProperty('Actions', TActionDragObject_Actions_si, TContainedAction_sw, True, False, 1, False, False);

  { Class members }

  AData.AddConstructor('Create', TActionDragObject_Create_si, 0, False);
end;

class function TActionDragObject_sw.ToVar(
  const AValue: TActionDragObject): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionDragObject_sw.FromVar(
  const AValue: OleVariant): TActionDragObject;
begin
  Result := TActionDragObject(ConvFromVar(AValue, TActionDragObject));
end;

class function TActionDragObject_sw.ClassToVar(
  AClass: TActionDragObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TActionDragObject_sw.ClassFromVar(
  const AClass: OleVariant): TActionDragObject_sc;
begin
  Result := TActionDragObject_sc(ConvClsFromVar(AClass, TActionDragObject));
end;

{ TCategoryDragObject_sw }

function TCategoryDragObject_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(ACategory: string);

  Result := TCategoryDragObject_sw.ToVar(TCategoryDragObject_sc(AObj).Create(
    string(AArgs[0])));
end;

function TCategoryDragObject_Category_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Category: string read <getter>;

  Result := TCategoryDragObject(AObj).Category;
end;

class function TCategoryDragObject_sw.GetTypeName: WideString;
begin
  Result := 'TCategoryDragObject';
end;

class function TCategoryDragObject_sw.GetWrappedClass: TClass;
begin
  Result := TCategoryDragObject;
end;

class procedure TCategoryDragObject_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Category', TCategoryDragObject_Category_si, string_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TCategoryDragObject_Create_si, 1, False);
end;

class function TCategoryDragObject_sw.ToVar(
  const AValue: TCategoryDragObject): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCategoryDragObject_sw.FromVar(
  const AValue: OleVariant): TCategoryDragObject;
begin
  Result := TCategoryDragObject(ConvFromVar(AValue, TCategoryDragObject));
end;

class function TCategoryDragObject_sw.ClassToVar(
  AClass: TCategoryDragObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCategoryDragObject_sw.ClassFromVar(
  const AClass: OleVariant): TCategoryDragObject_sc;
begin
  Result := TCategoryDragObject_sc(ConvClsFromVar(AClass, TCategoryDragObject));
end;

{ TActionItemDragObject_sw }

function TActionItemDragObject_ClientItem_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ClientItem: TActionClientItem read <getter>;

  Result := TActionClientItem_sw.ToVar(TActionItemDragObject(AObj).ClientItem);
end;

class function TActionItemDragObject_sw.GetTypeName: WideString;
begin
  Result := 'TActionItemDragObject';
end;

class function TActionItemDragObject_sw.GetWrappedClass: TClass;
begin
  Result := TActionItemDragObject;
end;

class procedure TActionItemDragObject_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ClientItem', TActionItemDragObject_ClientItem_si, TActionClientItem_sw, True, False, 0, False, False);
end;

class function TActionItemDragObject_sw.ToVar(
  const AValue: TActionItemDragObject): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionItemDragObject_sw.FromVar(
  const AValue: OleVariant): TActionItemDragObject;
begin
  Result := TActionItemDragObject(ConvFromVar(AValue, TActionItemDragObject));
end;

class function TActionItemDragObject_sw.ClassToVar(
  AClass: TActionItemDragObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TActionItemDragObject_sw.ClassFromVar(
  const AClass: OleVariant): TActionItemDragObject_sc;
begin
  Result := TActionItemDragObject_sc(ConvClsFromVar(AClass, 
    TActionItemDragObject));
end;

{ TCustomActionControlClass_sw }

class function TCustomActionControlClass_sw.GetTypeName: WideString;
begin
  Result := 'TCustomActionControlClass';
end;

class function TCustomActionControlClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TCustomActionControl;
end;

class function TCustomActionControlClass_sw.ToVar(
  const AValue: TCustomActionControlClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomActionControlClass_sw.FromVar(
  const AValue: OleVariant): TCustomActionControlClass;
begin
  Result := TCustomActionControlClass(ConvFromVar(AValue, 
    TCustomActionControl));
end;

{ TBarOrientation_sw }

class function TBarOrientation_sw.GetTypeName: WideString;
begin
  Result := 'TBarOrientation';
end;

class procedure TBarOrientation_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'boLeftToRight'; Value: Integer({$IFDEF LMDSCT_12}TBarOrientation.{$ENDIF}boLeftToRight)),
    (Name: 'boRightToLeft'; Value: Integer({$IFDEF LMDSCT_12}TBarOrientation.{$ENDIF}boRightToLeft)),
    (Name: 'boTopToBottom'; Value: Integer({$IFDEF LMDSCT_12}TBarOrientation.{$ENDIF}boTopToBottom)),
    (Name: 'boBottomToTop'; Value: Integer({$IFDEF LMDSCT_12}TBarOrientation.{$ENDIF}boBottomToTop))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TBarOrientation_sw.ToVar(
  const AValue: TBarOrientation): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBarOrientation_sw.FromVar(
  const AValue: OleVariant): TBarOrientation;
begin
  Result := TBarOrientation(Integer(AValue));
end;

{ TControlCreatedEvent_sh }

function TControlCreatedEvent_sh.GetHandler: TMethod;
var
  hdr: TControlCreatedEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TControlCreatedEvent_sh.Handler(Sender: TObject;
  var Control: TCustomActionControl);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; var Control: TCustomActionCon...

  v_1 := TCustomActionControl_sw.ToVar(Control);
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Control := TCustomActionControl_sw.FromVar(v_1);
end;

{ TControlCreatedEvent_sw }

class function TControlCreatedEvent_sw.GetTypeName: WideString;
begin
  Result := 'TControlCreatedEvent';
end;

class function TControlCreatedEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TControlCreatedEvent_sh;
end;

class function TControlCreatedEvent_sw.ToVar(
  const AValue: TControlCreatedEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TControlCreatedEvent_sw.FromVar(
  const AValue: OleVariant): TControlCreatedEvent;
begin
  Result := TControlCreatedEvent(ConvFromVar(AValue));
end;

class function TControlCreatedEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TControlCreatedEvent;
var
  hdlr: TControlCreatedEvent_sh;
begin
  hdlr   := TControlCreatedEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TControlCreatedEvent_sw));
  Result := hdlr.Handler;
end;

{ TGetControlClassEvent_sh }

function TGetControlClassEvent_sh.GetHandler: TMethod;
var
  hdr: TGetControlClassEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGetControlClassEvent_sh.Handler(Sender: TCustomActionBar;
  AnItem: TActionClient; var ControlClass: TCustomActionControlClass);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TCustomActionBar; AnItem: TActionClien...

  v_1 := TCustomActionControlClass_sw.ToVar(ControlClass);
  args[0] := TCustomActionBar_sw.ToVar(Sender);
  args[1] := TActionClient_sw.ToVar(AnItem);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  ControlClass := TCustomActionControlClass_sw.FromVar(v_1);
end;

{ TGetControlClassEvent_sw }

class function TGetControlClassEvent_sw.GetTypeName: WideString;
begin
  Result := 'TGetControlClassEvent';
end;

class function TGetControlClassEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetControlClassEvent_sh;
end;

class function TGetControlClassEvent_sw.ToVar(
  const AValue: TGetControlClassEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetControlClassEvent_sw.FromVar(
  const AValue: OleVariant): TGetControlClassEvent;
begin
  Result := TGetControlClassEvent(ConvFromVar(AValue));
end;

class function TGetControlClassEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TGetControlClassEvent;
var
  hdlr: TGetControlClassEvent_sh;
begin
  hdlr   := TGetControlClassEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetControlClassEvent_sw));
  Result := hdlr.Handler;
end;

{ TBarEdge_sw }

class function TBarEdge_sw.GetTypeName: WideString;
begin
  Result := 'TBarEdge';
end;

class procedure TBarEdge_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'beLeft'; Value: Integer({$IFDEF LMDSCT_12}TBarEdge.{$ENDIF}beLeft)),
    (Name: 'beRight'; Value: Integer({$IFDEF LMDSCT_12}TBarEdge.{$ENDIF}beRight)),
    (Name: 'beEither'; Value: Integer({$IFDEF LMDSCT_12}TBarEdge.{$ENDIF}beEither))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TBarEdge_sw.ToVar(const AValue: TBarEdge): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBarEdge_sw.FromVar(const AValue: OleVariant): TBarEdge;
begin
  Result := TBarEdge(Integer(AValue));
end;

{ TCustomActionBar_sw }

function TCustomActionBar_Canvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Canvas: TCanvas read <getter>;

  Result := TCanvas_sw.ToVar(TCustomActionBar_sacc(TCustomActionBar(AObj)).
    Canvas);
end;

function TCustomActionBar_HRowCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property HRowCount: Integer read <getter>;

  Result := TCustomActionBar_sacc(TCustomActionBar(AObj)).HRowCount;
end;

function TCustomActionBar_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Items: TActionClients read <getter>;

  Result := TActionClients_sw.ToVar(TCustomActionBar_sacc(TCustomActionBar(
    AObj)).Items);
end;

function TCustomActionBar_PersistentHotKeys_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property PersistentHotKeys: Boolean read <gette...

  if IsGet then
    Result := TCustomActionBar_sacc(TCustomActionBar(AObj)).PersistentHotKeys
  else
    TCustomActionBar_sacc(TCustomActionBar(AObj)).PersistentHotKeys := Boolean(
      AArgs[0]);
end;

function TCustomActionBar_VRowCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property VRowCount: Integer read <getter>;

  Result := TCustomActionBar_sacc(TCustomActionBar(AObj)).VRowCount;
end;

function TCustomActionBar_FindFirst_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindFirst: TActionClientItem;

  Result := TActionClientItem_sw.ToVar(TCustomActionBar(AObj).FindFirst());
end;

function TCustomActionBar_FindFirstVisibleItem_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindFirstVisibleItem: TActionClientItem;

  Result := TActionClientItem_sw.ToVar(TCustomActionBar(AObj).
    FindFirstVisibleItem());
end;

function TCustomActionBar_FindLastVisibleItem_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindLastVisibleItem: TActionClientItem;

  Result := TActionClientItem_sw.ToVar(TCustomActionBar(AObj).
    FindLastVisibleItem());
end;

function TCustomActionBar_ActionManager_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionManager: TCustomActionManager read <getter...

  if IsGet then
    Result := TCustomActionManager_sw.ToVar(TCustomActionBar(AObj).
      ActionManager)
  else
    TCustomActionBar(AObj).ActionManager := TCustomActionManager_sw.FromVar(
      AArgs[0]);
end;

function TCustomActionBar_ActionClient_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionClient: TActionClient read <getter> write ...

  if IsGet then
    Result := TActionClient_sw.ToVar(TCustomActionBar(AObj).ActionClient)
  else
    TCustomActionBar(AObj).ActionClient := TActionClient_sw.FromVar(AArgs[0]);
end;

function TCustomActionBar_AllowHiding_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AllowHiding: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomActionBar(AObj).AllowHiding
  else
    TCustomActionBar(AObj).AllowHiding := Boolean(AArgs[0]);
end;

function TCustomActionBar_ContextBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ContextBar: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomActionBar(AObj).ContextBar
  else
    TCustomActionBar(AObj).ContextBar := Boolean(AArgs[0]);
end;

function TCustomActionBar_DesignMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DesignMode: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomActionBar(AObj).DesignMode
  else
    TCustomActionBar(AObj).DesignMode := Boolean(AArgs[0]);
end;

function TCustomActionBar_HorzMargin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HorzMargin: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomActionBar(AObj).HorzMargin
  else
    TCustomActionBar(AObj).HorzMargin := Integer(AArgs[0]);
end;

function TCustomActionBar_HorzSeparator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HorzSeparator: Boolean read <getter> write <sett...

  if IsGet then
    Result := TCustomActionBar(AObj).HorzSeparator
  else
    TCustomActionBar(AObj).HorzSeparator := Boolean(AArgs[0]);
end;

function TCustomActionBar_Orientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Orientation: TBarOrientation read <getter> write...

  if IsGet then
    Result := TBarOrientation_sw.ToVar(TCustomActionBar(AObj).Orientation)
  else
    TCustomActionBar(AObj).Orientation := TBarOrientation_sw.FromVar(AArgs[0]);
end;

function TCustomActionBar_ActionControls_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionControls[const Index: Integer]: TCustomAct...

  Result := TCustomActionControl_sw.ToVar(TCustomActionBar(AObj).
    ActionControls[Integer(AArgs[0])]);
end;

function TCustomActionBar_Spacing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Spacing: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomActionBar(AObj).Spacing
  else
    TCustomActionBar(AObj).Spacing := Integer(AArgs[0]);
end;

function TCustomActionBar_VertMargin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property VertMargin: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomActionBar(AObj).VertMargin
  else
    TCustomActionBar(AObj).VertMargin := Integer(AArgs[0]);
end;

function TCustomActionBar_VertSeparator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property VertSeparator: Boolean read <getter> write <sett...

  if IsGet then
    Result := TCustomActionBar(AObj).VertSeparator
  else
    TCustomActionBar(AObj).VertSeparator := Boolean(AArgs[0]);
end;

function TCustomActionBar_OnControlCreated_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnControlCreated: TControlCreatedEvent read <get...

  if IsGet then
    Result := TControlCreatedEvent_sw.ToVar(TCustomActionBar(AObj).
      OnControlCreated)
  else
    TCustomActionBar(AObj).OnControlCreated := TControlCreatedEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomActionBar_OnGetControlClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnGetControlClass: TGetControlClassEvent read <g...

  if IsGet then
    Result := TGetControlClassEvent_sw.ToVar(TCustomActionBar(AObj).
      OnGetControlClass)
  else
    TCustomActionBar(AObj).OnGetControlClass := TGetControlClassEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomActionBar_OnPaint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnPaint: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomActionBar(AObj).OnPaint)
  else
    TCustomActionBar(AObj).OnPaint := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TCustomActionBar_sw.GetTypeName: WideString;
begin
  Result := 'TCustomActionBar';
end;

class function TCustomActionBar_sw.GetWrappedClass: TClass;
begin
  Result := TCustomActionBar;
end;

class procedure TCustomActionBar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Canvas', TCustomActionBar_Canvas_si, TCanvas_sw, True, False, 0, True, False);
  AData.AddProperty('HRowCount', TCustomActionBar_HRowCount_si, Integer_sw, True, False, 0, True, False);
  AData.AddProperty('Items', TCustomActionBar_Items_si, TActionClients_sw, True, False, 0, True, False);
  AData.AddProperty('PersistentHotKeys', TCustomActionBar_PersistentHotKeys_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('VRowCount', TCustomActionBar_VRowCount_si, Integer_sw, True, False, 0, True, False);
  AData.AddFunction('FindFirst', TCustomActionBar_FindFirst_si, TActionClientItem_sw, 0, False);
  AData.AddFunction('FindFirstVisibleItem', TCustomActionBar_FindFirstVisibleItem_si, TActionClientItem_sw, 0, False);
  AData.AddFunction('FindLastVisibleItem', TCustomActionBar_FindLastVisibleItem_si, TActionClientItem_sw, 0, False);
  AData.AddProperty('ActionManager', TCustomActionBar_ActionManager_si, TCustomActionManager_sw, True, True, 0, False, False);
  AData.AddProperty('ActionClient', TCustomActionBar_ActionClient_si, TActionClient_sw, True, True, 0, False, False);
  AData.AddProperty('AllowHiding', TCustomActionBar_AllowHiding_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddProperty('ContextBar', TCustomActionBar_ContextBar_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('DesignMode', TCustomActionBar_DesignMode_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('HorzMargin', TCustomActionBar_HorzMargin_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('HorzSeparator', TCustomActionBar_HorzSeparator_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Orientation', TCustomActionBar_Orientation_si, TBarOrientation_sw, True, True, 0, False, False);
  AData.AddProperty('ActionControls', TCustomActionBar_ActionControls_si, TCustomActionControl_sw, True, False, 1, False, False);
  AData.AddProperty('Spacing', TCustomActionBar_Spacing_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('VertMargin', TCustomActionBar_VertMargin_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('VertSeparator', TCustomActionBar_VertSeparator_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('OnControlCreated', TCustomActionBar_OnControlCreated_si, TControlCreatedEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnGetControlClass', TCustomActionBar_OnGetControlClass_si, TGetControlClassEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnPaint', TCustomActionBar_OnPaint_si, TNotifyEvent_sw, True, True, 0, False, False);
end;

class function TCustomActionBar_sw.ToVar(
  const AValue: TCustomActionBar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomActionBar_sw.FromVar(
  const AValue: OleVariant): TCustomActionBar;
begin
  Result := TCustomActionBar(ConvFromVar(AValue, TCustomActionBar));
end;

class function TCustomActionBar_sw.ClassToVar(
  AClass: TCustomActionBar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomActionBar_sw.ClassFromVar(
  const AClass: OleVariant): TCustomActionBar_sc;
begin
  Result := TCustomActionBar_sc(ConvClsFromVar(AClass, TCustomActionBar));
end;

{ TCMItemMsg_sw }

function TCMItemMsg_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMItemMsg_sw(AObj).FValue.Msg
  else
    TCMItemMsg_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMItemMsg_Unused_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Unused: Integer;

  if IsGet then
    Result := TCMItemMsg_sw(AObj).FValue.Unused
  else
    TCMItemMsg_sw(AObj).FValue.Unused := Integer(AArgs[0]);
end;

function TCMItemMsg_Sender_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Sender: TCustomActionControl;

  if IsGet then
    Result := TCustomActionControl_sw.ToVar(TCMItemMsg_sw(AObj).FValue.Sender)
  else
    TCMItemMsg_sw(AObj).FValue.Sender := TCustomActionControl_sw.FromVar(
      AArgs[0]);
end;

function TCMItemMsg_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: Longint;

  if IsGet then
    Result := TCMItemMsg_sw(AObj).FValue.Result
  else
    TCMItemMsg_sw(AObj).FValue.Result := Longint(AArgs[0]);
end;

function TCMItemMsg_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMItemMsg_sw.Create as IDispatch;
end;

function TCMItemMsg_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMItemMsg;

  // Implicit record copy method.
  Result := TCMItemMsg_sw.ToVar(TCMItemMsg(AObj));
end;

class function TCMItemMsg_sw.GetTypeName: WideString;
begin
  Result := 'TCMItemMsg';
end;

function TCMItemMsg_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMItemMsg_sw.Create;
  TCMItemMsg_sw(Result).FValue := FValue;
end;

class procedure TCMItemMsg_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMItemMsg_Msg_si, Cardinal_sw);
  AData.AddField('Unused', TCMItemMsg_Unused_si, Integer_sw);
  AData.AddField('Sender', TCMItemMsg_Sender_si, TCustomActionControl_sw);
  AData.AddField('Result', TCMItemMsg_Result_si, Longint_sw);
  AData.AddFunction('Copy', TCMItemMsg_Copy_si, TCMItemMsg_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMItemMsg_Create_si, 0, False);
end;

class function TCMItemMsg_sw.ToVar(const AValue: TCMItemMsg): OleVariant;
var
  wrpr: TCMItemMsg_sw;
begin
  wrpr        := TCMItemMsg_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMItemMsg_sw.FromVar(const AValue: OleVariant): TCMItemMsg;
begin
  Result := TCMItemMsg_sw(ConvFromVar(AValue)).FValue;
end;

{ TCustomActionControl_sw }

function TCustomActionControl_GlyphPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property GlyphPos: TPoint read <getter> write <...

  if IsGet then
    Result := TPoint_sw.ToVar(TCustomActionControl_sacc(TCustomActionControl(
      AObj)).GlyphPos)
  else
    TCustomActionControl_sacc(TCustomActionControl(AObj)).GlyphPos := TPoint_sw.
      FromVar(AArgs[0]);
end;

function TCustomActionControl_CalcBounds_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CalcBounds;

  TCustomActionControl(AObj).CalcBounds();
end;

function TCustomActionControl_Keyed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Keyed;

  TCustomActionControl(AObj).Keyed();
end;

function TCustomActionControl_ActionBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionBar: TCustomActionBar read <getter>;

  Result := TCustomActionBar_sw.ToVar(TCustomActionControl(AObj).ActionBar);
end;

function TCustomActionControl_ActionClient_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionClient: TActionClientItem read <getter> wr...

  if IsGet then
    Result := TActionClientItem_sw.ToVar(TCustomActionControl(AObj).
      ActionClient)
  else
    TCustomActionControl(AObj).ActionClient := TActionClientItem_sw.FromVar(
      AArgs[0]);
end;

function TCustomActionControl_GlyphLayout_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GlyphLayout: TButtonLayout read <getter> write <...

  if IsGet then
    Result := TButtonLayout_sw.ToVar(TCustomActionControl(AObj).GlyphLayout)
  else
    TCustomActionControl(AObj).GlyphLayout := TButtonLayout_sw.FromVar(
      AArgs[0]);
end;

function TCustomActionControl_Margins_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Margins: TRect read <getter> write <setter>;

  if IsGet then
    Result := TRect_sw.ToVar(TCustomActionControl(AObj).Margins)
  else
    TCustomActionControl(AObj).Margins := TRect_sw.FromVar(AArgs[0]);
end;

function TCustomActionControl_Selected_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Selected: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomActionControl(AObj).Selected
  else
    TCustomActionControl(AObj).Selected := Boolean(AArgs[0]);
end;

function TCustomActionControl_Separator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Separator: Boolean read <getter>;

  Result := TCustomActionControl(AObj).Separator;
end;

function TCustomActionControl_ShowCaption_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShowCaption: Boolean read <getter>;

  Result := TCustomActionControl(AObj).ShowCaption;
end;

function TCustomActionControl_ShowShortCut_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShowShortCut: Boolean read <getter>;

  Result := TCustomActionControl(AObj).ShowShortCut;
end;

function TCustomActionControl_SmallIcon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SmallIcon: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomActionControl(AObj).SmallIcon
  else
    TCustomActionControl(AObj).SmallIcon := Boolean(AArgs[0]);
end;

function TCustomActionControl_Spacing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Spacing: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomActionControl(AObj).Spacing
  else
    TCustomActionControl(AObj).Spacing := Integer(AArgs[0]);
end;

function TCustomActionControl_TextBounds_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TextBounds: TRect read <getter> write <setter>;

  if IsGet then
    Result := TRect_sw.ToVar(TCustomActionControl(AObj).TextBounds)
  else
    TCustomActionControl(AObj).TextBounds := TRect_sw.FromVar(AArgs[0]);
end;

function TCustomActionControl_Transparent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Transparent: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomActionControl(AObj).Transparent
  else
    TCustomActionControl(AObj).Transparent := Boolean(AArgs[0]);
end;

class function TCustomActionControl_sw.GetTypeName: WideString;
begin
  Result := 'TCustomActionControl';
end;

class function TCustomActionControl_sw.GetWrappedClass: TClass;
begin
  Result := TCustomActionControl;
end;

class procedure TCustomActionControl_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('GlyphPos', TCustomActionControl_GlyphPos_si, TPoint_sw, True, True, 0, True, False);
  AData.AddProcedure('CalcBounds', TCustomActionControl_CalcBounds_si, 0, False);
  AData.AddProcedure('Keyed', TCustomActionControl_Keyed_si, 0, False);
  AData.AddProperty('ActionBar', TCustomActionControl_ActionBar_si, TCustomActionBar_sw, True, False, 0, False, False);
  AData.AddProperty('ActionClient', TCustomActionControl_ActionClient_si, TActionClientItem_sw, True, True, 0, False, False);
  AData.AddProperty('GlyphLayout', TCustomActionControl_GlyphLayout_si, TButtonLayout_sw, True, True, 0, False, False);
  AData.AddProperty('Margins', TCustomActionControl_Margins_si, TRect_sw, True, True, 0, False, False);
  AData.AddProperty('Selected', TCustomActionControl_Selected_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Separator', TCustomActionControl_Separator_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('ShowCaption', TCustomActionControl_ShowCaption_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('ShowShortCut', TCustomActionControl_ShowShortCut_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('SmallIcon', TCustomActionControl_SmallIcon_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Spacing', TCustomActionControl_Spacing_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('TextBounds', TCustomActionControl_TextBounds_si, TRect_sw, True, True, 0, False, False);
  AData.AddProperty('Transparent', TCustomActionControl_Transparent_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnClick', False);
end;

class function TCustomActionControl_sw.ToVar(
  const AValue: TCustomActionControl): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomActionControl_sw.FromVar(
  const AValue: OleVariant): TCustomActionControl;
begin
  Result := TCustomActionControl(ConvFromVar(AValue, TCustomActionControl));
end;

class function TCustomActionControl_sw.ClassToVar(
  AClass: TCustomActionControl_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomActionControl_sw.ClassFromVar(
  const AClass: OleVariant): TCustomActionControl_sc;
begin
  Result := TCustomActionControl_sc(ConvClsFromVar(AClass, 
    TCustomActionControl));
end;

{ TXToolDockForm_sw }

class function TXToolDockForm_sw.GetTypeName: WideString;
begin
  Result := 'TXToolDockForm';
end;

class function TXToolDockForm_sw.GetWrappedClass: TClass;
begin
  Result := TXToolDockForm;
end;

class procedure TXToolDockForm_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TXToolDockForm_sw.ToVar(
  const AValue: TXToolDockForm): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TXToolDockForm_sw.FromVar(
  const AValue: OleVariant): TXToolDockForm;
begin
  Result := TXToolDockForm(ConvFromVar(AValue, TXToolDockForm));
end;

class function TXToolDockForm_sw.ClassToVar(
  AClass: TXToolDockForm_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TXToolDockForm_sw.ClassFromVar(
  const AClass: OleVariant): TXToolDockForm_sc;
begin
  Result := TXToolDockForm_sc(ConvClsFromVar(AClass, TXToolDockForm));
end;

{ ActnMan_sw }

function ActnMan_CM_ITEMSELECTED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_ITEMSELECTED = <value>;

  Result := CM_ITEMSELECTED;
end;

function ActnMan_CM_ITEMCLICKED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_ITEMCLICKED = <value>;

  Result := CM_ITEMCLICKED;
end;

function ActnMan_CM_ITEMKEYED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_ITEMKEYED = <value>;

  Result := CM_ITEMKEYED;
end;

function ActnMan_CM_SCROLLCLICKED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_SCROLLCLICKED = <value>;

  Result := CM_SCROLLCLICKED;
end;

function ActnMan_CM_RESETBAR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_RESETBAR = <value>;

  Result := CM_RESETBAR;
end;

function ActnMan_CM_ENTERMENULOOP_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_ENTERMENULOOP = <value>;

  Result := CM_ENTERMENULOOP;
end;

function ActnMan_TActionClientItemClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionClientItemClass = class of TActionClientItem;

  Result := TLMDUnitWrapper.TypeToVar(TActionClientItemClass_sw);
end;

function ActnMan_TActionClientsClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionClientsClass = class of TActionClients;

  Result := TLMDUnitWrapper.TypeToVar(TActionClientsClass_sw);
end;

function ActnMan_TActionBarsClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionBarsClass = class of TActionBars;

  Result := TLMDUnitWrapper.TypeToVar(TActionBarsClass_sw);
end;

function ActnMan_TActionBarItemClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionBarItemClass = class of TActionBarItem;

  Result := TLMDUnitWrapper.TypeToVar(TActionBarItemClass_sw);
end;

function ActnMan_TCustomActionManager_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomActionManager = class(TCustomActionList);

  Result := TLMDUnitWrapper.TypeToVar(TCustomActionManager_sw);
end;

function ActnMan_TActionManager_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionManager = class(TCustomActionManager);

  Result := TLMDUnitWrapper.TypeToVar(TActionManager_sw);
end;

function ActnMan_TActionListItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionListItem = class(TCollectionItem);

  Result := TLMDUnitWrapper.TypeToVar(TActionListItem_sw);
end;

function ActnMan_TActionListCollection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionListCollection = class(TOwnedCollection);

  Result := TLMDUnitWrapper.TypeToVar(TActionListCollection_sw);
end;

function ActnMan_TActionProc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionProc = procedure (AClient: TActionClient) of ...

  Result := TLMDUnitWrapper.TypeToVar(TActionProc_sw);
end;

function ActnMan_TActionClientsCollection_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionClientsCollection = class(TOwnedCollection);

  Result := TLMDUnitWrapper.TypeToVar(TActionClientsCollection_sw);
end;

function ActnMan_TBackgroundLayout_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBackgroundLayout = (blNormal, blStretch, blTile, bl...

  Result := TLMDUnitWrapper.TypeToVar(TBackgroundLayout_sw);
end;

function ActnMan_TChangesAllowed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TChangesAllowed = (caModify, caMove, caDelete);

  Result := TLMDUnitWrapper.TypeToVar(TChangesAllowed_sw);
end;

function ActnMan_TChangesAllowedSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TChangesAllowedSet = set of TChangesAllowed;

  Result := TLMDUnitWrapper.TypeToVar(TChangesAllowedSet_sw);
end;

function ActnMan_TActionClient_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionClient = class(TCollectionItem);

  Result := TLMDUnitWrapper.TypeToVar(TActionClient_sw);
end;

function ActnMan_TActionBarItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionBarItem = class(TActionClient);

  Result := TLMDUnitWrapper.TypeToVar(TActionBarItem_sw);
end;

function ActnMan_TActionBars_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionBars = class(TActionClientsCollection);

  Result := TLMDUnitWrapper.TypeToVar(TActionBars_sw);
end;

function ActnMan_TActionClientClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionClientClass = class of TActionClient;

  Result := TLMDUnitWrapper.TypeToVar(TActionClientClass_sw);
end;

function ActnMan_TCaptionOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCaptionOptions = (coNone, coSelective, coAll);

  Result := TLMDUnitWrapper.TypeToVar(TCaptionOptions_sw);
end;

function ActnMan_TActionClients_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionClients = class(TActionClientsCollection);

  Result := TLMDUnitWrapper.TypeToVar(TActionClients_sw);
end;

function ActnMan_TActionClientLinkClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionClientLinkClass = class of TActionClientLink;

  Result := TLMDUnitWrapper.TypeToVar(TActionClientLinkClass_sw);
end;

function ActnMan_TActionClientLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionClientLink = class(TActionLink);

  Result := TLMDUnitWrapper.TypeToVar(TActionClientLink_sw);
end;

function ActnMan_TMergeRange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMergeRange = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TMergeRange_sw);
end;

function ActnMan_TActionClientItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionClientItem = class(TActionClient);

  Result := TLMDUnitWrapper.TypeToVar(TActionClientItem_sw);
end;

function ActnMan_TCustomActionClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomActionClass = class(TCustomAction);

  Result := TLMDUnitWrapper.TypeToVar(TCustomActionClass_sw);
end;

function ActnMan_TActionDragObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionDragObject = class(TDragObjectEx);

  Result := TLMDUnitWrapper.TypeToVar(TActionDragObject_sw);
end;

function ActnMan_TCategoryDragObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCategoryDragObject = class(TActionDragObject);

  Result := TLMDUnitWrapper.TypeToVar(TCategoryDragObject_sw);
end;

function ActnMan_TActionItemDragObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionItemDragObject = class(TDragObjectEx);

  Result := TLMDUnitWrapper.TypeToVar(TActionItemDragObject_sw);
end;

function ActnMan_TCustomActionControlClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomActionControlClass = class of TCustomActionCo...

  Result := TLMDUnitWrapper.TypeToVar(TCustomActionControlClass_sw);
end;

function ActnMan_TBarOrientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBarOrientation = (boLeftToRight, boRightToLeft, boT...

  Result := TLMDUnitWrapper.TypeToVar(TBarOrientation_sw);
end;

function ActnMan_TControlCreatedEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TControlCreatedEvent = procedure (Sender: TObject; v...

  Result := TLMDUnitWrapper.TypeToVar(TControlCreatedEvent_sw);
end;

function ActnMan_TGetControlClassEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetControlClassEvent = procedure (Sender: TCustomAc...

  Result := TLMDUnitWrapper.TypeToVar(TGetControlClassEvent_sw);
end;

function ActnMan_TBarEdge_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBarEdge = (beLeft, beRight, beEither);

  Result := TLMDUnitWrapper.TypeToVar(TBarEdge_sw);
end;

function ActnMan_TCustomActionBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomActionBar = class(TToolWindow);

  Result := TLMDUnitWrapper.TypeToVar(TCustomActionBar_sw);
end;

function ActnMan_TCMItemMsg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMItemMsg = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMItemMsg_sw);
end;

function ActnMan_TCustomActionControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomActionControl = class(TGraphicControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomActionControl_sw);
end;

function ActnMan_TXToolDockForm_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TXToolDockForm = class(TToolDockForm);

  Result := TLMDUnitWrapper.TypeToVar(TXToolDockForm_sw);
end;

function ActnMan_NotifyDesigner_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure NotifyDesigner(ActionBar: TCustomActionBar);

  ActnMan.NotifyDesigner(TCustomActionBar_sw.FromVar(AArgs[0]));
end;

function ActnMan_caAllChanges_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const caAllChanges = <value>;

  Result := LMDSetToVar(SizeOf(caAllChanges), caAllChanges);
end;

function ActnMan_cDefaultSchedule_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cDefaultSchedule: string = <value>;

  Result := cDefaultSchedule;
end;

class function ActnMan_sw.GetUnitName: WideString;
begin
  Result := 'ActnMan';
end;

class procedure ActnMan_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddConstant('CM_ITEMSELECTED', ActnMan_CM_ITEMSELECTED_si, nil, VarType(ActnMan.CM_ITEMSELECTED));
  AData.AddConstant('CM_ITEMCLICKED', ActnMan_CM_ITEMCLICKED_si, nil, VarType(ActnMan.CM_ITEMCLICKED));
  AData.AddConstant('CM_ITEMKEYED', ActnMan_CM_ITEMKEYED_si, nil, VarType(ActnMan.CM_ITEMKEYED));
  AData.AddConstant('CM_SCROLLCLICKED', ActnMan_CM_SCROLLCLICKED_si, nil, VarType(ActnMan.CM_SCROLLCLICKED));
  AData.AddConstant('CM_RESETBAR', ActnMan_CM_RESETBAR_si, nil, VarType(ActnMan.CM_RESETBAR));
  AData.AddConstant('CM_ENTERMENULOOP', ActnMan_CM_ENTERMENULOOP_si, nil, VarType(ActnMan.CM_ENTERMENULOOP));
  AData.AddType(TActionClientItemClass_sw, ActnMan_TActionClientItemClass_si);
  AData.AddType(TActionClientsClass_sw, ActnMan_TActionClientsClass_si);
  AData.AddType(TActionBarsClass_sw, ActnMan_TActionBarsClass_si);
  AData.AddType(TActionBarItemClass_sw, ActnMan_TActionBarItemClass_si);
  AData.AddType(TCustomActionManager_sw, ActnMan_TCustomActionManager_si);
  AData.AddType(TActionManager_sw, ActnMan_TActionManager_si);
  AData.AddType(TActionListItem_sw, ActnMan_TActionListItem_si);
  AData.AddType(TActionListCollection_sw, ActnMan_TActionListCollection_si);
  AData.AddType(TActionProc_sw, ActnMan_TActionProc_si);
  AData.AddType(TActionClientsCollection_sw, ActnMan_TActionClientsCollection_si);
  AData.AddType(TBackgroundLayout_sw, ActnMan_TBackgroundLayout_si);
  AData.AddType(TChangesAllowed_sw, ActnMan_TChangesAllowed_si);
  AData.AddType(TChangesAllowedSet_sw, ActnMan_TChangesAllowedSet_si);
  AData.AddType(TActionClient_sw, ActnMan_TActionClient_si);
  AData.AddType(TActionBarItem_sw, ActnMan_TActionBarItem_si);
  AData.AddType(TActionBars_sw, ActnMan_TActionBars_si);
  AData.AddType(TActionClientClass_sw, ActnMan_TActionClientClass_si);
  AData.AddType(TCaptionOptions_sw, ActnMan_TCaptionOptions_si);
  AData.AddType(TActionClients_sw, ActnMan_TActionClients_si);
  AData.AddType(TActionClientLinkClass_sw, ActnMan_TActionClientLinkClass_si);
  AData.AddType(TActionClientLink_sw, ActnMan_TActionClientLink_si);
  AData.AddType(TMergeRange_sw, ActnMan_TMergeRange_si);
  AData.AddType(TActionClientItem_sw, ActnMan_TActionClientItem_si);
  AData.AddType(TCustomActionClass_sw, ActnMan_TCustomActionClass_si);
  AData.AddType(TActionDragObject_sw, ActnMan_TActionDragObject_si);
  AData.AddType(TCategoryDragObject_sw, ActnMan_TCategoryDragObject_si);
  AData.AddType(TActionItemDragObject_sw, ActnMan_TActionItemDragObject_si);
  AData.AddType(TCustomActionControlClass_sw, ActnMan_TCustomActionControlClass_si);
  AData.AddType(TBarOrientation_sw, ActnMan_TBarOrientation_si);
  AData.AddType(TControlCreatedEvent_sw, ActnMan_TControlCreatedEvent_si);
  AData.AddType(TGetControlClassEvent_sw, ActnMan_TGetControlClassEvent_si);
  AData.AddType(TBarEdge_sw, ActnMan_TBarEdge_si);
  AData.AddType(TCustomActionBar_sw, ActnMan_TCustomActionBar_si);
  AData.AddType(TCMItemMsg_sw, ActnMan_TCMItemMsg_si);
  AData.AddType(TCustomActionControl_sw, ActnMan_TCustomActionControl_si);
  AData.AddType(TXToolDockForm_sw, ActnMan_TXToolDockForm_si);
  AData.AddProcedure('NotifyDesigner', ActnMan_NotifyDesigner_si, 1, False);
  AData.AddConstant('caAllChanges', ActnMan_caAllChanges_si, nil, varInteger);
  AData.AddConstant('cDefaultSchedule', ActnMan_cDefaultSchedule_si, string_sw);
end;

class function ActnMan_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(ActnMan_sw);
end;

initialization
  RegisterUnitWrapper(ActnMan_sw);
  RegisterClassWrapper(TCustomActionManager_sw);
  RegisterClassWrapper(TActionManager_sw);
  RegisterClassWrapper(TActionListItem_sw);
  RegisterClassWrapper(TActionListCollection_sw);
  RegisterClassWrapper(TActionClientsCollection_sw);
  RegisterClassWrapper(TActionClient_sw);
  RegisterClassWrapper(TActionBarItem_sw);
  RegisterClassWrapper(TActionBars_sw);
  RegisterClassWrapper(TActionClients_sw);
  RegisterClassWrapper(TActionClientLink_sw);
  RegisterClassWrapper(TActionClientItem_sw);
  RegisterClassWrapper(TCustomActionClass_sw);
  RegisterClassWrapper(TActionDragObject_sw);
  RegisterClassWrapper(TCategoryDragObject_sw);
  RegisterClassWrapper(TActionItemDragObject_sw);
  RegisterClassWrapper(TCustomActionBar_sw);
  RegisterClassWrapper(TCustomActionControl_sw);
  RegisterClassWrapper(TXToolDockForm_sw);
  RegisterEventWrapper(TypeInfo(TActionProc), TActionProc_sw);
  RegisterEventWrapper(TypeInfo(TControlCreatedEvent), TControlCreatedEvent_sw);
  RegisterEventWrapper(TypeInfo(TGetControlClassEvent), TGetControlClassEvent_sw);

end.
