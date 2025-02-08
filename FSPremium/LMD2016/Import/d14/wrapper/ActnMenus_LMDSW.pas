unit ActnMenus_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'ActnMenus' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Types, SysUtils, Variants, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, Windows, Messages, Classes, Contnrs, Buttons, Graphics,
  Forms, Controls, ActnList, ToolWin, ExtCtrls, StdCtrls, Menus, StdActns,
  ActnMan, ActnCtrls, ShadowWnd, ActnMenus, Windows_LMDSW, Messages_LMDSW,
  Classes_LMDSW, Contnrs_LMDSW, Buttons_LMDSW, Graphics_LMDSW, Forms_LMDSW,
  Controls_LMDSW, ActnList_LMDSW, ToolWin_LMDSW, ExtCtrls_LMDSW,
  StdCtrls_LMDSW, Menus_LMDSW, StdActns_LMDSW, ActnMan_LMDSW, ActnCtrls_LMDSW,
  ShadowWnd_LMDSW;


{ Type wrappers }

type
  TMenuStack_sw = class;
  TCustomPopupClass_sw = class;
  TCustomAddRemoveItemClass_sw = class;
  TActionBarStyleEx_sw = class;
  TCustomActionMenuBar_sw = class;
  TCustomMenuExpandBtn_sw = class;
  TCustomMenuExpandBtnClass_sw = class;
  TCustomActionPopupMenu_sw = class;
  TCustomizeActionToolBarClass_sw = class;
  TCustomizeActionToolBar_sw = class;
  TCustomizeActionLink_sw = class;
  TCustomizeActionClientItem_sw = class;
  TCustomMDIMenuButton_sw = class;
  TCustomActionMainMenuBar_sw = class;
  TActionMainMenuBar_sw = class;
  TCustomMenuItem_sw = class;
  TCustomMenuButton_sw = class;
  TCustomAddRemoveItem_sw = class;
  TMenuItemControlClass_sw = class;
  TAddRemoveItemClass_sw = class;
  TMenuButtonControlClass_sw = class;

  TMenuStack_sc = class of TMenuStack;
  TMenuStack_sw = class(TStack_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMenuStack): OleVariant;
    class function FromVar(const AValue: OleVariant): TMenuStack;
    class function ClassToVar(AClass: TMenuStack_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMenuStack_sc;
  end;

  TCustomPopupClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TCustomPopupClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomPopupClass;
  end;

  TCustomAddRemoveItemClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TCustomAddRemoveItemClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomAddRemoveItemClass;
  end;

  TActionBarStyleEx_sc = class of TActionBarStyleEx;
  TActionBarStyleEx_sw = class(TActionBarStyle_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TActionBarStyleEx): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionBarStyleEx;
    class function ClassToVar(AClass: TActionBarStyleEx_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TActionBarStyleEx_sc;
  end;

  TAnimationStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TAnimationStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TAnimationStyle;
  end;

  TMenuPopupEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Item: TCustomActionControl);
  end;

  TMenuPopupEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TMenuPopupEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TMenuPopupEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TMenuPopupEvent;
  end;

  TGetPopupClassEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; var PopupClass: TCustomPopupClass);
  end;

  TGetPopupClassEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetPopupClassEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetPopupClassEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetPopupClassEvent;
  end;

  TExitMenuEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TCustomActionMenuBar; Cancelled: Boolean);
  end;

  TExitMenuEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TExitMenuEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TExitMenuEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TExitMenuEvent;
  end;

  TCustomActionMenuBar_sc = class of TCustomActionMenuBar;
  TCustomActionMenuBar_sw = class(TCustomActionDockBar_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomActionMenuBar): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomActionMenuBar;
    class function ClassToVar(AClass: TCustomActionMenuBar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomActionMenuBar_sc;
  end;

  TCustomMenuExpandBtn_sc = class of TCustomMenuExpandBtn;
  TCustomMenuExpandBtn_sw = class(TCustomUtilityButton_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomMenuExpandBtn): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomMenuExpandBtn;
    class function ClassToVar(AClass: TCustomMenuExpandBtn_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomMenuExpandBtn_sc;
  end;

  TCustomMenuExpandBtnClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TCustomMenuExpandBtnClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomMenuExpandBtnClass;
  end;

  TCustomActionPopupMenu_sc = class of TCustomActionPopupMenu;
  TCustomActionPopupMenu_sw = class(TCustomActionMenuBar_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomActionPopupMenu): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomActionPopupMenu;
    class function ClassToVar(AClass: TCustomActionPopupMenu_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomActionPopupMenu_sc;
  end;

  TCustomizeActionToolBarClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TCustomizeActionToolBarClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomizeActionToolBarClass;
  end;

  TCustomizeActionToolBar_sc = class of TCustomizeActionToolBar;
  TCustomizeActionToolBar_sw = class(TCustomActionPopupMenu_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomizeActionToolBar): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomizeActionToolBar;
    class function ClassToVar(AClass: TCustomizeActionToolBar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomizeActionToolBar_sc;
  end;

  TCustomizeActionLink_sc = class of TCustomizeActionLink;
  TCustomizeActionLink_sw = class(TActionClientLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomizeActionLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomizeActionLink;
    class function ClassToVar(AClass: TCustomizeActionLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomizeActionLink_sc;
  end;

  TCustomizeActionClientItem_sc = class of TCustomizeActionClientItem;
  TCustomizeActionClientItem_sw = class(TActionClientItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomizeActionClientItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomizeActionClientItem;
    class function ClassToVar(AClass: TCustomizeActionClientItem_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomizeActionClientItem_sc;
  end;

  TMDIButtonStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TMDIButtonStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TMDIButtonStyle;
  end;

  TCustomMDIMenuButton_sc = class of TCustomMDIMenuButton;
  TCustomMDIMenuButton_sw = class(TSpeedButton_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomMDIMenuButton): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomMDIMenuButton;
    class function ClassToVar(AClass: TCustomMDIMenuButton_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomMDIMenuButton_sc;
  end;

  TCustomActionMainMenuBar_sc = class of TCustomActionMainMenuBar;
  TCustomActionMainMenuBar_sw = class(TCustomActionMenuBar_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomActionMainMenuBar): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomActionMainMenuBar;
    class function ClassToVar(AClass: TCustomActionMainMenuBar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomActionMainMenuBar_sc;
  end;

  TActionMainMenuBar_sc = class of TActionMainMenuBar;
  TActionMainMenuBar_sw = class(TCustomActionMainMenuBar_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TActionMainMenuBar): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionMainMenuBar;
    class function ClassToVar(AClass: TActionMainMenuBar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TActionMainMenuBar_sc;
  end;

  TMenuEdges_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TMenuEdges): OleVariant;
    class function FromVar(const AValue: OleVariant): TMenuEdges;
  end;

  TCustomMenuItem_sc = class of TCustomMenuItem;
  TCustomMenuItem_sw = class(TCustomActionControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomMenuItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomMenuItem;
    class function ClassToVar(AClass: TCustomMenuItem_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomMenuItem_sc;
  end;

  TCustomMenuButton_sc = class of TCustomMenuButton;
  TCustomMenuButton_sw = class(TCustomButtonControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomMenuButton): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomMenuButton;
    class function ClassToVar(AClass: TCustomMenuButton_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomMenuButton_sc;
  end;

  TCustomAddRemoveItem_sc = class of TCustomAddRemoveItem;
  TCustomAddRemoveItem_sw = class(TCustomMenuItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomAddRemoveItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomAddRemoveItem;
    class function ClassToVar(AClass: TCustomAddRemoveItem_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomAddRemoveItem_sc;
  end;

  TMenuItemControlClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TMenuItemControlClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TMenuItemControlClass;
  end;

  TAddRemoveItemClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TAddRemoveItemClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TAddRemoveItemClass;
  end;

  TMenuButtonControlClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TMenuButtonControlClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TMenuButtonControlClass;
  end;


{ Unit wrapper }

type
  ActnMenus_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TMenuStack_sacc = class(TMenuStack);
  TCustomActionMenuBar_sacc = class(TCustomActionMenuBar);
  TCustomMenuExpandBtn_sacc = class(TCustomMenuExpandBtn);
  TCustomizeActionToolBar_sacc = class(TCustomizeActionToolBar);
  TCustomMenuItem_sacc = class(TCustomMenuItem);
  TCustomMenuButton_sacc = class(TCustomMenuButton);

{ TMenuStack_sw }

function TMenuStack_Bars_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Bars[const Index: Integer]: TCustomAct...

  Result := TCustomActionMenuBar_sw.ToVar(TMenuStack_sacc(TMenuStack(AObj)).
    Bars[Integer(AArgs[0])]);
end;

function TMenuStack_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AMenu: TCustomActionMenuBar);

  Result := TMenuStack_sw.ToVar(TMenuStack_sc(AObj).Create(
    TCustomActionMenuBar_sw.FromVar(AArgs[0])));
end;

function TMenuStack_Push_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Push(Container: TCustomActionMenuBar);

  TMenuStack(AObj).Push(TCustomActionMenuBar_sw.FromVar(AArgs[0]));
end;

function TMenuStack_Pop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Pop: TCustomActionMenuBar;

  Result := TCustomActionMenuBar_sw.ToVar(TMenuStack(AObj).Pop());
end;

function TMenuStack_Peek_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Peek: TCustomActionMenuBar;

  Result := TCustomActionMenuBar_sw.ToVar(TMenuStack(AObj).Peek());
end;

class function TMenuStack_sw.GetTypeName: WideString;
begin
  Result := 'TMenuStack';
end;

class function TMenuStack_sw.GetWrappedClass: TClass;
begin
  Result := TMenuStack;
end;

class procedure TMenuStack_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Bars', TMenuStack_Bars_si, TCustomActionMenuBar_sw, True, False, 1, True, False);
  AData.AddProcedure('Push', TMenuStack_Push_si, 1, False);
  AData.AddFunction('Pop', TMenuStack_Pop_si, TCustomActionMenuBar_sw, 0, False);
  AData.AddFunction('Peek', TMenuStack_Peek_si, TCustomActionMenuBar_sw, 0, False);
  AData.AddPropertyRedecl('List', False);

  { Class members }

  AData.AddConstructor('Create', TMenuStack_Create_si, 1, False);
end;

class function TMenuStack_sw.ToVar(const AValue: TMenuStack): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMenuStack_sw.FromVar(const AValue: OleVariant): TMenuStack;
begin
  Result := TMenuStack(ConvFromVar(AValue, TMenuStack));
end;

class function TMenuStack_sw.ClassToVar(AClass: TMenuStack_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMenuStack_sw.ClassFromVar(
  const AClass: OleVariant): TMenuStack_sc;
begin
  Result := TMenuStack_sc(ConvClsFromVar(AClass, TMenuStack));
end;

{ TCustomPopupClass_sw }

class function TCustomPopupClass_sw.GetTypeName: WideString;
begin
  Result := 'TCustomPopupClass';
end;

class function TCustomPopupClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TCustomActionPopupMenu;
end;

class function TCustomPopupClass_sw.ToVar(
  const AValue: TCustomPopupClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomPopupClass_sw.FromVar(
  const AValue: OleVariant): TCustomPopupClass;
begin
  Result := TCustomPopupClass(ConvFromVar(AValue, TCustomActionPopupMenu));
end;

{ TCustomAddRemoveItemClass_sw }

class function TCustomAddRemoveItemClass_sw.GetTypeName: WideString;
begin
  Result := 'TCustomAddRemoveItemClass';
end;

class function TCustomAddRemoveItemClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TCustomAddRemoveItem;
end;

class function TCustomAddRemoveItemClass_sw.ToVar(
  const AValue: TCustomAddRemoveItemClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomAddRemoveItemClass_sw.FromVar(
  const AValue: OleVariant): TCustomAddRemoveItemClass;
begin
  Result := TCustomAddRemoveItemClass(ConvFromVar(AValue, 
    TCustomAddRemoveItem));
end;

{ TActionBarStyleEx_sw }

function TActionBarStyleEx_GetPopupClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetPopupClass(ActionBar: TCustomActionBar): TCus...

  Result := TCustomPopupClass_sw.ToVar(TActionBarStyleEx(AObj).GetPopupClass(
    TCustomActionBar_sw.FromVar(AArgs[0])));
end;

function TActionBarStyleEx_GetAddRemoveItemClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetAddRemoveItemClass(ActionBar: TCustomActionBa...

  Result := TCustomAddRemoveItemClass_sw.ToVar(TActionBarStyleEx(AObj).
    GetAddRemoveItemClass(TCustomActionBar_sw.FromVar(AArgs[0])));
end;

function TActionBarStyleEx_GetScrollBtnClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetScrollBtnClass: TCustomToolScrollBtnClass;

  Result := TCustomToolScrollBtnClass_sw.ToVar(TActionBarStyleEx(AObj).
    GetScrollBtnClass());
end;

class function TActionBarStyleEx_sw.GetTypeName: WideString;
begin
  Result := 'TActionBarStyleEx';
end;

class function TActionBarStyleEx_sw.GetWrappedClass: TClass;
begin
  Result := TActionBarStyleEx;
end;

class procedure TActionBarStyleEx_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('GetPopupClass', TActionBarStyleEx_GetPopupClass_si, TCustomPopupClass_sw, 1, False);
  AData.AddFunction('GetAddRemoveItemClass', TActionBarStyleEx_GetAddRemoveItemClass_si, TCustomAddRemoveItemClass_sw, 1, False);
  AData.AddFunction('GetScrollBtnClass', TActionBarStyleEx_GetScrollBtnClass_si, TCustomToolScrollBtnClass_sw, 0, False);
end;

class function TActionBarStyleEx_sw.ToVar(
  const AValue: TActionBarStyleEx): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionBarStyleEx_sw.FromVar(
  const AValue: OleVariant): TActionBarStyleEx;
begin
  Result := TActionBarStyleEx(ConvFromVar(AValue, TActionBarStyleEx));
end;

class function TActionBarStyleEx_sw.ClassToVar(
  AClass: TActionBarStyleEx_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TActionBarStyleEx_sw.ClassFromVar(
  const AClass: OleVariant): TActionBarStyleEx_sc;
begin
  Result := TActionBarStyleEx_sc(ConvClsFromVar(AClass, TActionBarStyleEx));
end;

{ TAnimationStyle_sw }

class function TAnimationStyle_sw.GetTypeName: WideString;
begin
  Result := 'TAnimationStyle';
end;

class procedure TAnimationStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'asNone'; Value: Integer({$IFDEF LMDSCT_12}TAnimationStyle.{$ENDIF}asNone)),
    (Name: 'asDefault'; Value: Integer({$IFDEF LMDSCT_12}TAnimationStyle.{$ENDIF}asDefault)),
    (Name: 'asUnFold'; Value: Integer({$IFDEF LMDSCT_12}TAnimationStyle.{$ENDIF}asUnFold)),
    (Name: 'asSlide'; Value: Integer({$IFDEF LMDSCT_12}TAnimationStyle.{$ENDIF}asSlide)),
    (Name: 'asFade'; Value: Integer({$IFDEF LMDSCT_12}TAnimationStyle.{$ENDIF}asFade))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TAnimationStyle_sw.ToVar(
  const AValue: TAnimationStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TAnimationStyle_sw.FromVar(
  const AValue: OleVariant): TAnimationStyle;
begin
  Result := TAnimationStyle(Integer(AValue));
end;

{ TMenuPopupEvent_sh }

function TMenuPopupEvent_sh.GetHandler: TMethod;
var
  hdr: TMenuPopupEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TMenuPopupEvent_sh.Handler(Sender: TObject;
  Item: TCustomActionControl);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TObject; Item: TCustomActionControl) o...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TCustomActionControl_sw.ToVar(Item);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TMenuPopupEvent_sw }

class function TMenuPopupEvent_sw.GetTypeName: WideString;
begin
  Result := 'TMenuPopupEvent';
end;

class function TMenuPopupEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TMenuPopupEvent_sh;
end;

class function TMenuPopupEvent_sw.ToVar(
  const AValue: TMenuPopupEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TMenuPopupEvent_sw.FromVar(
  const AValue: OleVariant): TMenuPopupEvent;
begin
  Result := TMenuPopupEvent(ConvFromVar(AValue));
end;

class function TMenuPopupEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TMenuPopupEvent;
var
  hdlr: TMenuPopupEvent_sh;
begin
  hdlr   := TMenuPopupEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TMenuPopupEvent_sw));
  Result := hdlr.Handler;
end;

{ TGetPopupClassEvent_sh }

function TGetPopupClassEvent_sh.GetHandler: TMethod;
var
  hdr: TGetPopupClassEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGetPopupClassEvent_sh.Handler(Sender: TObject;
  var PopupClass: TCustomPopupClass);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; var PopupClass: TCustomPopupC...

  v_1 := TCustomPopupClass_sw.ToVar(PopupClass);
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  PopupClass := TCustomPopupClass_sw.FromVar(v_1);
end;

{ TGetPopupClassEvent_sw }

class function TGetPopupClassEvent_sw.GetTypeName: WideString;
begin
  Result := 'TGetPopupClassEvent';
end;

class function TGetPopupClassEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetPopupClassEvent_sh;
end;

class function TGetPopupClassEvent_sw.ToVar(
  const AValue: TGetPopupClassEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetPopupClassEvent_sw.FromVar(
  const AValue: OleVariant): TGetPopupClassEvent;
begin
  Result := TGetPopupClassEvent(ConvFromVar(AValue));
end;

class function TGetPopupClassEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TGetPopupClassEvent;
var
  hdlr: TGetPopupClassEvent_sh;
begin
  hdlr   := TGetPopupClassEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetPopupClassEvent_sw));
  Result := hdlr.Handler;
end;

{ TExitMenuEvent_sh }

function TExitMenuEvent_sh.GetHandler: TMethod;
var
  hdr: TExitMenuEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TExitMenuEvent_sh.Handler(Sender: TCustomActionMenuBar;
  Cancelled: Boolean);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TCustomActionMenuBar; Cancelled: Boole...

  args[0] := TCustomActionMenuBar_sw.ToVar(Sender);
  args[1] := Cancelled;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TExitMenuEvent_sw }

class function TExitMenuEvent_sw.GetTypeName: WideString;
begin
  Result := 'TExitMenuEvent';
end;

class function TExitMenuEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TExitMenuEvent_sh;
end;

class function TExitMenuEvent_sw.ToVar(
  const AValue: TExitMenuEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TExitMenuEvent_sw.FromVar(
  const AValue: OleVariant): TExitMenuEvent;
begin
  Result := TExitMenuEvent(ConvFromVar(AValue));
end;

class function TExitMenuEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TExitMenuEvent;
var
  hdlr: TExitMenuEvent_sh;
begin
  hdlr   := TExitMenuEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TExitMenuEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomActionMenuBar_sw }

function TCustomActionMenuBar_AnimateDuration_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AnimateDuration: Integer read <getter>...

  if IsGet then
    Result := TCustomActionMenuBar_sacc(TCustomActionMenuBar(AObj)).
      AnimateDuration
  else
    TCustomActionMenuBar_sacc(TCustomActionMenuBar(AObj)).AnimateDuration := 
      Integer(AArgs[0]);
end;

function TCustomActionMenuBar_DelayItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DelayItem: TCustomActionControl read <...

  if IsGet then
    Result := TCustomActionControl_sw.ToVar(TCustomActionMenuBar_sacc(
      TCustomActionMenuBar(AObj)).DelayItem)
  else
    TCustomActionMenuBar_sacc(TCustomActionMenuBar(AObj)).DelayItem := 
      TCustomActionControl_sw.FromVar(AArgs[0]);
end;

function TCustomActionMenuBar_Expandable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Expandable: Boolean read <getter> writ...

  if IsGet then
    Result := TCustomActionMenuBar_sacc(TCustomActionMenuBar(AObj)).Expandable
  else
    TCustomActionMenuBar_sacc(TCustomActionMenuBar(AObj)).Expandable := Boolean(
      AArgs[0]);
end;

function TCustomActionMenuBar_Expanded_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Expanded: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomActionMenuBar_sacc(TCustomActionMenuBar(AObj)).Expanded
  else
    TCustomActionMenuBar_sacc(TCustomActionMenuBar(AObj)).Expanded := Boolean(
      AArgs[0]);
end;

function TCustomActionMenuBar_MouseControl_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MouseControl: TControl read <getter> w...

  if IsGet then
    Result := TControl_sw.ToVar(TCustomActionMenuBar_sacc(TCustomActionMenuBar(
      AObj)).MouseControl)
  else
    TCustomActionMenuBar_sacc(TCustomActionMenuBar(AObj)).MouseControl := 
      TControl_sw.FromVar(AArgs[0]);
end;

function TCustomActionMenuBar_ParentMenu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ParentMenu: TCustomActionMenuBar read ...

  if IsGet then
    Result := TCustomActionMenuBar_sw.ToVar(TCustomActionMenuBar_sacc(
      TCustomActionMenuBar(AObj)).ParentMenu)
  else
    TCustomActionMenuBar_sacc(TCustomActionMenuBar(AObj)).ParentMenu := 
      TCustomActionMenuBar_sw.FromVar(AArgs[0]);
end;

function TCustomActionMenuBar_Selected_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Selected: TActionClientItem read <gett...

  Result := TActionClientItem_sw.ToVar(TCustomActionMenuBar_sacc(
    TCustomActionMenuBar(AObj)).Selected);
end;

function TCustomActionMenuBar_CloseMenu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CloseMenu;

  TCustomActionMenuBar(AObj).CloseMenu();
end;

function TCustomActionMenuBar_TrackMenu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure TrackMenu;

  TCustomActionMenuBar(AObj).TrackMenu();
end;

function TCustomActionMenuBar_AnimationStyle_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AnimationStyle: TAnimationStyle read <getter> wr...

  if IsGet then
    Result := TAnimationStyle_sw.ToVar(TCustomActionMenuBar(AObj).
      AnimationStyle)
  else
    TCustomActionMenuBar(AObj).AnimationStyle := TAnimationStyle_sw.FromVar(
      AArgs[0]);
end;

function TCustomActionMenuBar_AutoFocus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoFocus: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomActionMenuBar(AObj).AutoFocus
  else
    TCustomActionMenuBar(AObj).AutoFocus := Boolean(AArgs[0]);
end;

function TCustomActionMenuBar_ExpandDelay_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ExpandDelay: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomActionMenuBar(AObj).ExpandDelay
  else
    TCustomActionMenuBar(AObj).ExpandDelay := Integer(AArgs[0]);
end;

function TCustomActionMenuBar_InMenuLoop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property InMenuLoop: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomActionMenuBar(AObj).InMenuLoop
  else
    TCustomActionMenuBar(AObj).InMenuLoop := Boolean(AArgs[0]);
end;

function TCustomActionMenuBar_ParentControl_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParentControl: TCustomActionControl read <getter...

  if IsGet then
    Result := TCustomActionControl_sw.ToVar(TCustomActionMenuBar(AObj).
      ParentControl)
  else
    TCustomActionMenuBar(AObj).ParentControl := TCustomActionControl_sw.FromVar(
      AArgs[0]);
end;

function TCustomActionMenuBar_PopupStack_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PopupStack: TMenuStack read <getter>;

  Result := TMenuStack_sw.ToVar(TCustomActionMenuBar(AObj).PopupStack);
end;

function TCustomActionMenuBar_Resizing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Resizing: Boolean read <getter>;

  Result := TCustomActionMenuBar(AObj).Resizing;
end;

function TCustomActionMenuBar_RootMenu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RootMenu: TCustomActionMenuBar read <getter> wri...

  if IsGet then
    Result := TCustomActionMenuBar_sw.ToVar(TCustomActionMenuBar(AObj).RootMenu)
  else
    TCustomActionMenuBar(AObj).RootMenu := TCustomActionMenuBar_sw.FromVar(
      AArgs[0]);
end;

function TCustomActionMenuBar_UseSystemFont_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property UseSystemFont: Boolean read <getter> write <sett...

  if IsGet then
    Result := TCustomActionMenuBar(AObj).UseSystemFont
  else
    TCustomActionMenuBar(AObj).UseSystemFont := Boolean(AArgs[0]);
end;

function TCustomActionMenuBar_OnEnterMenuLoop_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnEnterMenuLoop: TNotifyEvent read <getter> writ...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomActionMenuBar(AObj).OnEnterMenuLoop)
  else
    TCustomActionMenuBar(AObj).OnEnterMenuLoop := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomActionMenuBar_OnExitMenuLoop_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnExitMenuLoop: TExitMenuEvent read <getter> wri...

  if IsGet then
    Result := TExitMenuEvent_sw.ToVar(TCustomActionMenuBar(AObj).OnExitMenuLoop)
  else
    TCustomActionMenuBar(AObj).OnExitMenuLoop := TExitMenuEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomActionMenuBar_OnGetPopupClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnGetPopupClass: TGetPopupClassEvent read <gette...

  if IsGet then
    Result := TGetPopupClassEvent_sw.ToVar(TCustomActionMenuBar(AObj).
      OnGetPopupClass)
  else
    TCustomActionMenuBar(AObj).OnGetPopupClass := TGetPopupClassEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomActionMenuBar_OnPopup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnPopup: TMenuPopupEvent read <getter> write <se...

  if IsGet then
    Result := TMenuPopupEvent_sw.ToVar(TCustomActionMenuBar(AObj).OnPopup)
  else
    TCustomActionMenuBar(AObj).OnPopup := TMenuPopupEvent_sw.FromVar(AArgs[0]);
end;

class function TCustomActionMenuBar_sw.GetTypeName: WideString;
begin
  Result := 'TCustomActionMenuBar';
end;

class function TCustomActionMenuBar_sw.GetWrappedClass: TClass;
begin
  Result := TCustomActionMenuBar;
end;

class procedure TCustomActionMenuBar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('AnimateDuration', TCustomActionMenuBar_AnimateDuration_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('DelayItem', TCustomActionMenuBar_DelayItem_si, TCustomActionControl_sw, True, True, 0, True, False);
  AData.AddProperty('Expandable', TCustomActionMenuBar_Expandable_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('Expanded', TCustomActionMenuBar_Expanded_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('MouseControl', TCustomActionMenuBar_MouseControl_si, TControl_sw, True, True, 0, True, False);
  AData.AddProperty('ParentMenu', TCustomActionMenuBar_ParentMenu_si, TCustomActionMenuBar_sw, True, True, 0, True, False);
  AData.AddProperty('Selected', TCustomActionMenuBar_Selected_si, TActionClientItem_sw, True, False, 0, True, False);
  AData.AddProcedure('CloseMenu', TCustomActionMenuBar_CloseMenu_si, 0, False);
  AData.AddProcedure('TrackMenu', TCustomActionMenuBar_TrackMenu_si, 0, False);
  AData.AddProperty('AnimationStyle', TCustomActionMenuBar_AnimationStyle_si, TAnimationStyle_sw, True, True, 0, False, False);
  AData.AddProperty('AutoFocus', TCustomActionMenuBar_AutoFocus_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ExpandDelay', TCustomActionMenuBar_ExpandDelay_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('InMenuLoop', TCustomActionMenuBar_InMenuLoop_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ParentControl', TCustomActionMenuBar_ParentControl_si, TCustomActionControl_sw, True, True, 0, False, False);
  AData.AddProperty('PopupStack', TCustomActionMenuBar_PopupStack_si, TMenuStack_sw, True, False, 0, False, False);
  AData.AddProperty('Resizing', TCustomActionMenuBar_Resizing_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('RootMenu', TCustomActionMenuBar_RootMenu_si, TCustomActionMenuBar_sw, True, True, 0, False, False);
  AData.AddProperty('UseSystemFont', TCustomActionMenuBar_UseSystemFont_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('OnEnterMenuLoop', TCustomActionMenuBar_OnEnterMenuLoop_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnExitMenuLoop', TCustomActionMenuBar_OnExitMenuLoop_si, TExitMenuEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnGetPopupClass', TCustomActionMenuBar_OnGetPopupClass_si, TGetPopupClassEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnPopup', TCustomActionMenuBar_OnPopup_si, TMenuPopupEvent_sw, True, True, 0, False, False);
end;

class function TCustomActionMenuBar_sw.ToVar(
  const AValue: TCustomActionMenuBar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomActionMenuBar_sw.FromVar(
  const AValue: OleVariant): TCustomActionMenuBar;
begin
  Result := TCustomActionMenuBar(ConvFromVar(AValue, TCustomActionMenuBar));
end;

class function TCustomActionMenuBar_sw.ClassToVar(
  AClass: TCustomActionMenuBar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomActionMenuBar_sw.ClassFromVar(
  const AClass: OleVariant): TCustomActionMenuBar_sc;
begin
  Result := TCustomActionMenuBar_sc(ConvClsFromVar(AClass, 
    TCustomActionMenuBar));
end;

{ TCustomMenuExpandBtn_sw }

function TCustomMenuExpandBtn_Menu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Menu: TCustomActionMenuBar read <getter>;

  Result := TCustomActionMenuBar_sw.ToVar(TCustomMenuExpandBtn_sacc(
    TCustomMenuExpandBtn(AObj)).Menu);
end;

class function TCustomMenuExpandBtn_sw.GetTypeName: WideString;
begin
  Result := 'TCustomMenuExpandBtn';
end;

class function TCustomMenuExpandBtn_sw.GetWrappedClass: TClass;
begin
  Result := TCustomMenuExpandBtn;
end;

class procedure TCustomMenuExpandBtn_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Menu', TCustomMenuExpandBtn_Menu_si, TCustomActionMenuBar_sw, True, False, 0, True, False);
end;

class function TCustomMenuExpandBtn_sw.ToVar(
  const AValue: TCustomMenuExpandBtn): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomMenuExpandBtn_sw.FromVar(
  const AValue: OleVariant): TCustomMenuExpandBtn;
begin
  Result := TCustomMenuExpandBtn(ConvFromVar(AValue, TCustomMenuExpandBtn));
end;

class function TCustomMenuExpandBtn_sw.ClassToVar(
  AClass: TCustomMenuExpandBtn_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomMenuExpandBtn_sw.ClassFromVar(
  const AClass: OleVariant): TCustomMenuExpandBtn_sc;
begin
  Result := TCustomMenuExpandBtn_sc(ConvClsFromVar(AClass, 
    TCustomMenuExpandBtn));
end;

{ TCustomMenuExpandBtnClass_sw }

class function TCustomMenuExpandBtnClass_sw.GetTypeName: WideString;
begin
  Result := 'TCustomMenuExpandBtnClass';
end;

class function TCustomMenuExpandBtnClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TCustomMenuExpandBtn;
end;

class function TCustomMenuExpandBtnClass_sw.ToVar(
  const AValue: TCustomMenuExpandBtnClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomMenuExpandBtnClass_sw.FromVar(
  const AValue: OleVariant): TCustomMenuExpandBtnClass;
begin
  Result := TCustomMenuExpandBtnClass(ConvFromVar(AValue, 
    TCustomMenuExpandBtn));
end;

{ TCustomActionPopupMenu_sw }

function TCustomActionPopupMenu_Popup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Popup(X: Integer; Y: Integer);

  TCustomActionPopupMenu(AObj).Popup(Integer(AArgs[0]), Integer(AArgs[1]));
end;

function TCustomActionPopupMenu_ExpandBtn_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ExpandBtn: TCustomMenuExpandBtn read <getter> wr...

  if IsGet then
    Result := TCustomMenuExpandBtn_sw.ToVar(TCustomActionPopupMenu(AObj).
      ExpandBtn)
  else
    TCustomActionPopupMenu(AObj).ExpandBtn := TCustomMenuExpandBtn_sw.FromVar(
      AArgs[0]);
end;

function TCustomActionPopupMenu_Shadow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Shadow: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomActionPopupMenu(AObj).Shadow
  else
    TCustomActionPopupMenu(AObj).Shadow := Boolean(AArgs[0]);
end;

class function TCustomActionPopupMenu_sw.GetTypeName: WideString;
begin
  Result := 'TCustomActionPopupMenu';
end;

class function TCustomActionPopupMenu_sw.GetWrappedClass: TClass;
begin
  Result := TCustomActionPopupMenu;
end;

class procedure TCustomActionPopupMenu_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Popup', TCustomActionPopupMenu_Popup_si, 2, False);
  AData.AddProperty('ExpandBtn', TCustomActionPopupMenu_ExpandBtn_si, TCustomMenuExpandBtn_sw, True, True, 0, False, False);
  AData.AddProperty('Shadow', TCustomActionPopupMenu_Shadow_si, Boolean_sw, True, True, 0, False, False);
end;

class function TCustomActionPopupMenu_sw.ToVar(
  const AValue: TCustomActionPopupMenu): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomActionPopupMenu_sw.FromVar(
  const AValue: OleVariant): TCustomActionPopupMenu;
begin
  Result := TCustomActionPopupMenu(ConvFromVar(AValue, TCustomActionPopupMenu));
end;

class function TCustomActionPopupMenu_sw.ClassToVar(
  AClass: TCustomActionPopupMenu_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomActionPopupMenu_sw.ClassFromVar(
  const AClass: OleVariant): TCustomActionPopupMenu_sc;
begin
  Result := TCustomActionPopupMenu_sc(ConvClsFromVar(AClass, 
    TCustomActionPopupMenu));
end;

{ TCustomizeActionToolBarClass_sw }

class function TCustomizeActionToolBarClass_sw.GetTypeName: WideString;
begin
  Result := 'TCustomizeActionToolBarClass';
end;

class function TCustomizeActionToolBarClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TCustomizeActionToolBar;
end;

class function TCustomizeActionToolBarClass_sw.ToVar(
  const AValue: TCustomizeActionToolBarClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomizeActionToolBarClass_sw.FromVar(
  const AValue: OleVariant): TCustomizeActionToolBarClass;
begin
  Result := TCustomizeActionToolBarClass(ConvFromVar(AValue, 
    TCustomizeActionToolBar));
end;

{ TCustomizeActionToolBar_sw }

function TCustomizeActionToolBar_AddlItem_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AddlItem: TActionClientItem read <gett...

  Result := TActionClientItem_sw.ToVar(TCustomizeActionToolBar_sacc(
    TCustomizeActionToolBar(AObj)).AddlItem);
end;

function TCustomizeActionToolBar_AdditionalItem_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AdditionalItem: TActionClientItem read <getter>;

  Result := TActionClientItem_sw.ToVar(TCustomizeActionToolBar(AObj).
    AdditionalItem);
end;

class function TCustomizeActionToolBar_sw.GetTypeName: WideString;
begin
  Result := 'TCustomizeActionToolBar';
end;

class function TCustomizeActionToolBar_sw.GetWrappedClass: TClass;
begin
  Result := TCustomizeActionToolBar;
end;

class procedure TCustomizeActionToolBar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('AddlItem', TCustomizeActionToolBar_AddlItem_si, TActionClientItem_sw, True, False, 0, True, False);
  AData.AddProperty('AdditionalItem', TCustomizeActionToolBar_AdditionalItem_si, TActionClientItem_sw, True, False, 0, False, False);
end;

class function TCustomizeActionToolBar_sw.ToVar(
  const AValue: TCustomizeActionToolBar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomizeActionToolBar_sw.FromVar(
  const AValue: OleVariant): TCustomizeActionToolBar;
begin
  Result := TCustomizeActionToolBar(ConvFromVar(AValue, 
    TCustomizeActionToolBar));
end;

class function TCustomizeActionToolBar_sw.ClassToVar(
  AClass: TCustomizeActionToolBar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomizeActionToolBar_sw.ClassFromVar(
  const AClass: OleVariant): TCustomizeActionToolBar_sc;
begin
  Result := TCustomizeActionToolBar_sc(ConvClsFromVar(AClass, 
    TCustomizeActionToolBar));
end;

{ TCustomizeActionLink_sw }

class function TCustomizeActionLink_sw.GetTypeName: WideString;
begin
  Result := 'TCustomizeActionLink';
end;

class function TCustomizeActionLink_sw.GetWrappedClass: TClass;
begin
  Result := TCustomizeActionLink;
end;

class procedure TCustomizeActionLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TCustomizeActionLink_sw.ToVar(
  const AValue: TCustomizeActionLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomizeActionLink_sw.FromVar(
  const AValue: OleVariant): TCustomizeActionLink;
begin
  Result := TCustomizeActionLink(ConvFromVar(AValue, TCustomizeActionLink));
end;

class function TCustomizeActionLink_sw.ClassToVar(
  AClass: TCustomizeActionLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomizeActionLink_sw.ClassFromVar(
  const AClass: OleVariant): TCustomizeActionLink_sc;
begin
  Result := TCustomizeActionLink_sc(ConvClsFromVar(AClass, 
    TCustomizeActionLink));
end;

{ TCustomizeActionClientItem_sw }

class function TCustomizeActionClientItem_sw.GetTypeName: WideString;
begin
  Result := 'TCustomizeActionClientItem';
end;

class function TCustomizeActionClientItem_sw.GetWrappedClass: TClass;
begin
  Result := TCustomizeActionClientItem;
end;

class procedure TCustomizeActionClientItem_sw.DoInit(
  AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TCustomizeActionClientItem_sw.ToVar(
  const AValue: TCustomizeActionClientItem): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomizeActionClientItem_sw.FromVar(
  const AValue: OleVariant): TCustomizeActionClientItem;
begin
  Result := TCustomizeActionClientItem(ConvFromVar(AValue, 
    TCustomizeActionClientItem));
end;

class function TCustomizeActionClientItem_sw.ClassToVar(
  AClass: TCustomizeActionClientItem_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomizeActionClientItem_sw.ClassFromVar(
  const AClass: OleVariant): TCustomizeActionClientItem_sc;
begin
  Result := TCustomizeActionClientItem_sc(ConvClsFromVar(AClass, 
    TCustomizeActionClientItem));
end;

{ TMDIButtonStyle_sw }

class function TMDIButtonStyle_sw.GetTypeName: WideString;
begin
  Result := 'TMDIButtonStyle';
end;

class procedure TMDIButtonStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'mbMinimize'; Value: Integer({$IFDEF LMDSCT_12}TMDIButtonStyle.{$ENDIF}mbMinimize)),
    (Name: 'mbRestore'; Value: Integer({$IFDEF LMDSCT_12}TMDIButtonStyle.{$ENDIF}mbRestore)),
    (Name: 'mbClose'; Value: Integer({$IFDEF LMDSCT_12}TMDIButtonStyle.{$ENDIF}mbClose))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TMDIButtonStyle_sw.ToVar(
  const AValue: TMDIButtonStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TMDIButtonStyle_sw.FromVar(
  const AValue: OleVariant): TMDIButtonStyle;
begin
  Result := TMDIButtonStyle(Integer(AValue));
end;

{ TCustomMDIMenuButton_sw }

function TCustomMDIMenuButton_ButtonStyle_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ButtonStyle: TMDIButtonStyle read <getter> write...

  if IsGet then
    Result := TMDIButtonStyle_sw.ToVar(TCustomMDIMenuButton(AObj).ButtonStyle)
  else
    TCustomMDIMenuButton(AObj).ButtonStyle := TMDIButtonStyle_sw.FromVar(
      AArgs[0]);
end;

class function TCustomMDIMenuButton_sw.GetTypeName: WideString;
begin
  Result := 'TCustomMDIMenuButton';
end;

class function TCustomMDIMenuButton_sw.GetWrappedClass: TClass;
begin
  Result := TCustomMDIMenuButton;
end;

class procedure TCustomMDIMenuButton_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ButtonStyle', TCustomMDIMenuButton_ButtonStyle_si, TMDIButtonStyle_sw, True, True, 0, False, False);
end;

class function TCustomMDIMenuButton_sw.ToVar(
  const AValue: TCustomMDIMenuButton): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomMDIMenuButton_sw.FromVar(
  const AValue: OleVariant): TCustomMDIMenuButton;
begin
  Result := TCustomMDIMenuButton(ConvFromVar(AValue, TCustomMDIMenuButton));
end;

class function TCustomMDIMenuButton_sw.ClassToVar(
  AClass: TCustomMDIMenuButton_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomMDIMenuButton_sw.ClassFromVar(
  const AClass: OleVariant): TCustomMDIMenuButton_sc;
begin
  Result := TCustomMDIMenuButton_sc(ConvClsFromVar(AClass, 
    TCustomMDIMenuButton));
end;

{ TCustomActionMainMenuBar_sw }

function TCustomActionMainMenuBar_Inactive_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Inactive: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomActionMainMenuBar(AObj).Inactive
  else
    TCustomActionMainMenuBar(AObj).Inactive := Boolean(AArgs[0]);
end;

function TCustomActionMainMenuBar_Shadows_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Shadows: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomActionMainMenuBar(AObj).Shadows
  else
    TCustomActionMainMenuBar(AObj).Shadows := Boolean(AArgs[0]);
end;

function TCustomActionMainMenuBar_WindowMenu_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property WindowMenu: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomActionMainMenuBar(AObj).WindowMenu
  else
    TCustomActionMainMenuBar(AObj).WindowMenu := string(AArgs[0]);
end;

class function TCustomActionMainMenuBar_sw.GetTypeName: WideString;
begin
  Result := 'TCustomActionMainMenuBar';
end;

class function TCustomActionMainMenuBar_sw.GetWrappedClass: TClass;
begin
  Result := TCustomActionMainMenuBar;
end;

class procedure TCustomActionMainMenuBar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Inactive', TCustomActionMainMenuBar_Inactive_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('PersistentHotKeys', False);
  AData.AddProperty('Shadows', TCustomActionMainMenuBar_Shadows_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('WindowMenu', TCustomActionMainMenuBar_WindowMenu_si, string_sw, True, True, 0, False, False);
end;

class function TCustomActionMainMenuBar_sw.ToVar(
  const AValue: TCustomActionMainMenuBar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomActionMainMenuBar_sw.FromVar(
  const AValue: OleVariant): TCustomActionMainMenuBar;
begin
  Result := TCustomActionMainMenuBar(ConvFromVar(AValue, 
    TCustomActionMainMenuBar));
end;

class function TCustomActionMainMenuBar_sw.ClassToVar(
  AClass: TCustomActionMainMenuBar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomActionMainMenuBar_sw.ClassFromVar(
  const AClass: OleVariant): TCustomActionMainMenuBar_sc;
begin
  Result := TCustomActionMainMenuBar_sc(ConvClsFromVar(AClass, 
    TCustomActionMainMenuBar));
end;

{ TActionMainMenuBar_sw }

class function TActionMainMenuBar_sw.GetTypeName: WideString;
begin
  Result := 'TActionMainMenuBar';
end;

class function TActionMainMenuBar_sw.GetWrappedClass: TClass;
begin
  Result := TActionMainMenuBar;
end;

class procedure TActionMainMenuBar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Canvas', False);
  AData.AddPropertyRedecl('UseSystemFont', False);
  AData.AddPropertyRedecl('ActionManager', False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('AllowHiding', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AnimateDuration', False);
  AData.AddPropertyRedecl('AnimationStyle', False);
  AData.AddPropertyRedecl('AutoFocus', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('ColorMap', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('EdgeBorders', False);
  AData.AddPropertyRedecl('EdgeInner', False);
  AData.AddPropertyRedecl('EdgeOuter', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('ExpandDelay', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('HorzMargin', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentBackground', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PersistentHotKeys', False);
  AData.AddPropertyRedecl('Shadows', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('Spacing', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('VertMargin', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('WindowMenu', False);
  AData.AddPropertyRedecl('OnAlignInsertBefore', False);
  AData.AddPropertyRedecl('OnAlignPosition', False);
  AData.AddPropertyRedecl('OnCanResize', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnControlCreated', False);
  AData.AddPropertyRedecl('OnConstrainedResize', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDockDrop', False);
  AData.AddPropertyRedecl('OnDockOver', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnEnterMenuLoop', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnExitMenuLoop', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnGetControlClass', False);
  AData.AddPropertyRedecl('OnGetPopupClass', False);
  AData.AddPropertyRedecl('OnGetSiteInfo', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnPaint', False);
  AData.AddPropertyRedecl('OnPopup', False);
  AData.AddPropertyRedecl('OnResize', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
  AData.AddPropertyRedecl('OnUnDock', False);
end;

class function TActionMainMenuBar_sw.ToVar(
  const AValue: TActionMainMenuBar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionMainMenuBar_sw.FromVar(
  const AValue: OleVariant): TActionMainMenuBar;
begin
  Result := TActionMainMenuBar(ConvFromVar(AValue, TActionMainMenuBar));
end;

class function TActionMainMenuBar_sw.ClassToVar(
  AClass: TActionMainMenuBar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TActionMainMenuBar_sw.ClassFromVar(
  const AClass: OleVariant): TActionMainMenuBar_sc;
begin
  Result := TActionMainMenuBar_sc(ConvClsFromVar(AClass, TActionMainMenuBar));
end;

{ TMenuEdges_sw }

class function TMenuEdges_sw.GetTypeName: WideString;
begin
  Result := 'TMenuEdges';
end;

class function TMenuEdges_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TMenuEdges);
end;

class function TMenuEdges_sw.ToVar(const AValue: TMenuEdges): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TMenuEdges_sw.FromVar(const AValue: OleVariant): TMenuEdges;
begin
  ConvFromVar(AValue, @Result);
end;

{ TCustomMenuItem_sw }

function TCustomMenuItem_Menu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Menu: TCustomActionMenuBar read <getter>;

  Result := TCustomActionMenuBar_sw.ToVar(TCustomMenuItem_sacc(TCustomMenuItem(
    AObj)).Menu);
end;

function TCustomMenuItem_MouseSelected_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MouseSelected: Boolean read <getter>;

  Result := TCustomMenuItem_sacc(TCustomMenuItem(AObj)).MouseSelected;
end;

function TCustomMenuItem_ShortCutBounds_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ShortCutBounds: TRect read <getter> wr...

  if IsGet then
    Result := TRect_sw.ToVar(TCustomMenuItem_sacc(TCustomMenuItem(AObj)).
      ShortCutBounds)
  else
    TCustomMenuItem_sacc(TCustomMenuItem(AObj)).ShortCutBounds := TRect_sw.
      FromVar(AArgs[0]);
end;

function TCustomMenuItem_Edges_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Edges: TMenuEdges read <getter> write <setter>;

  if IsGet then
    Result := TMenuEdges_sw.ToVar(TCustomMenuItem(AObj).Edges)
  else
    TCustomMenuItem(AObj).Edges := TMenuEdges_sw.FromVar(AArgs[0]);
end;

class function TCustomMenuItem_sw.GetTypeName: WideString;
begin
  Result := 'TCustomMenuItem';
end;

class function TCustomMenuItem_sw.GetWrappedClass: TClass;
begin
  Result := TCustomMenuItem;
end;

class procedure TCustomMenuItem_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Menu', TCustomMenuItem_Menu_si, TCustomActionMenuBar_sw, True, False, 0, True, False);
  AData.AddProperty('MouseSelected', TCustomMenuItem_MouseSelected_si, Boolean_sw, True, False, 0, True, False);
  AData.AddProperty('ShortCutBounds', TCustomMenuItem_ShortCutBounds_si, TRect_sw, True, True, 0, True, False);
  AData.AddProperty('Edges', TCustomMenuItem_Edges_si, TMenuEdges_sw, True, True, 0, False, False);
end;

class function TCustomMenuItem_sw.ToVar(
  const AValue: TCustomMenuItem): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomMenuItem_sw.FromVar(
  const AValue: OleVariant): TCustomMenuItem;
begin
  Result := TCustomMenuItem(ConvFromVar(AValue, TCustomMenuItem));
end;

class function TCustomMenuItem_sw.ClassToVar(
  AClass: TCustomMenuItem_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomMenuItem_sw.ClassFromVar(
  const AClass: OleVariant): TCustomMenuItem_sc;
begin
  Result := TCustomMenuItem_sc(ConvClsFromVar(AClass, TCustomMenuItem));
end;

{ TCustomMenuButton_sw }

function TCustomMenuButton_Menu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Menu: TCustomActionMenuBar read <getter>;

  Result := TCustomActionMenuBar_sw.ToVar(TCustomMenuButton_sacc(
    TCustomMenuButton(AObj)).Menu);
end;

class function TCustomMenuButton_sw.GetTypeName: WideString;
begin
  Result := 'TCustomMenuButton';
end;

class function TCustomMenuButton_sw.GetWrappedClass: TClass;
begin
  Result := TCustomMenuButton;
end;

class procedure TCustomMenuButton_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Menu', TCustomMenuButton_Menu_si, TCustomActionMenuBar_sw, True, False, 0, True, False);
end;

class function TCustomMenuButton_sw.ToVar(
  const AValue: TCustomMenuButton): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomMenuButton_sw.FromVar(
  const AValue: OleVariant): TCustomMenuButton;
begin
  Result := TCustomMenuButton(ConvFromVar(AValue, TCustomMenuButton));
end;

class function TCustomMenuButton_sw.ClassToVar(
  AClass: TCustomMenuButton_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomMenuButton_sw.ClassFromVar(
  const AClass: OleVariant): TCustomMenuButton_sc;
begin
  Result := TCustomMenuButton_sc(ConvClsFromVar(AClass, TCustomMenuButton));
end;

{ TCustomAddRemoveItem_sw }

class function TCustomAddRemoveItem_sw.GetTypeName: WideString;
begin
  Result := 'TCustomAddRemoveItem';
end;

class function TCustomAddRemoveItem_sw.GetWrappedClass: TClass;
begin
  Result := TCustomAddRemoveItem;
end;

class procedure TCustomAddRemoveItem_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TCustomAddRemoveItem_sw.ToVar(
  const AValue: TCustomAddRemoveItem): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomAddRemoveItem_sw.FromVar(
  const AValue: OleVariant): TCustomAddRemoveItem;
begin
  Result := TCustomAddRemoveItem(ConvFromVar(AValue, TCustomAddRemoveItem));
end;

class function TCustomAddRemoveItem_sw.ClassToVar(
  AClass: TCustomAddRemoveItem_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomAddRemoveItem_sw.ClassFromVar(
  const AClass: OleVariant): TCustomAddRemoveItem_sc;
begin
  Result := TCustomAddRemoveItem_sc(ConvClsFromVar(AClass, 
    TCustomAddRemoveItem));
end;

{ TMenuItemControlClass_sw }

class function TMenuItemControlClass_sw.GetTypeName: WideString;
begin
  Result := 'TMenuItemControlClass';
end;

class function TMenuItemControlClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TCustomMenuItem;
end;

class function TMenuItemControlClass_sw.ToVar(
  const AValue: TMenuItemControlClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMenuItemControlClass_sw.FromVar(
  const AValue: OleVariant): TMenuItemControlClass;
begin
  Result := TMenuItemControlClass(ConvFromVar(AValue, TCustomMenuItem));
end;

{ TAddRemoveItemClass_sw }

class function TAddRemoveItemClass_sw.GetTypeName: WideString;
begin
  Result := 'TAddRemoveItemClass';
end;

class function TAddRemoveItemClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TCustomAddRemoveItem;
end;

class function TAddRemoveItemClass_sw.ToVar(
  const AValue: TAddRemoveItemClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TAddRemoveItemClass_sw.FromVar(
  const AValue: OleVariant): TAddRemoveItemClass;
begin
  Result := TAddRemoveItemClass(ConvFromVar(AValue, TCustomAddRemoveItem));
end;

{ TMenuButtonControlClass_sw }

class function TMenuButtonControlClass_sw.GetTypeName: WideString;
begin
  Result := 'TMenuButtonControlClass';
end;

class function TMenuButtonControlClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TCustomMenuButton;
end;

class function TMenuButtonControlClass_sw.ToVar(
  const AValue: TMenuButtonControlClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMenuButtonControlClass_sw.FromVar(
  const AValue: OleVariant): TMenuButtonControlClass;
begin
  Result := TMenuButtonControlClass(ConvFromVar(AValue, TCustomMenuButton));
end;

{ ActnMenus_sw }

function ActnMenus_TMenuStack_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMenuStack = class(TStack);

  Result := TLMDUnitWrapper.TypeToVar(TMenuStack_sw);
end;

function ActnMenus_TCustomPopupClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomPopupClass = class of TCustomActionPopupMenu;

  Result := TLMDUnitWrapper.TypeToVar(TCustomPopupClass_sw);
end;

function ActnMenus_TCustomAddRemoveItemClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomAddRemoveItemClass = class of TCustomAddRemov...

  Result := TLMDUnitWrapper.TypeToVar(TCustomAddRemoveItemClass_sw);
end;

function ActnMenus_TActionBarStyleEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionBarStyleEx = class(TActionBarStyle);

  Result := TLMDUnitWrapper.TypeToVar(TActionBarStyleEx_sw);
end;

function ActnMenus_TAnimationStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAnimationStyle = (asNone, asDefault, asUnFold, asSl...

  Result := TLMDUnitWrapper.TypeToVar(TAnimationStyle_sw);
end;

function ActnMenus_TMenuPopupEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMenuPopupEvent = procedure (Sender: TObject; Item: ...

  Result := TLMDUnitWrapper.TypeToVar(TMenuPopupEvent_sw);
end;

function ActnMenus_TGetPopupClassEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetPopupClassEvent = procedure (Sender: TObject; va...

  Result := TLMDUnitWrapper.TypeToVar(TGetPopupClassEvent_sw);
end;

function ActnMenus_TExitMenuEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TExitMenuEvent = procedure (Sender: TCustomActionMen...

  Result := TLMDUnitWrapper.TypeToVar(TExitMenuEvent_sw);
end;

function ActnMenus_TCustomActionMenuBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomActionMenuBar = class(TCustomActionDockBar);

  Result := TLMDUnitWrapper.TypeToVar(TCustomActionMenuBar_sw);
end;

function ActnMenus_TCustomMenuExpandBtn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomMenuExpandBtn = class(TCustomUtilityButton);

  Result := TLMDUnitWrapper.TypeToVar(TCustomMenuExpandBtn_sw);
end;

function ActnMenus_TCustomMenuExpandBtnClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomMenuExpandBtnClass = class of TCustomMenuExpa...

  Result := TLMDUnitWrapper.TypeToVar(TCustomMenuExpandBtnClass_sw);
end;

function ActnMenus_TCustomActionPopupMenu_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomActionPopupMenu = class(TCustomActionMenuBar);

  Result := TLMDUnitWrapper.TypeToVar(TCustomActionPopupMenu_sw);
end;

function ActnMenus_TCustomizeActionToolBarClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomizeActionToolBarClass = class of TCustomizeAc...

  Result := TLMDUnitWrapper.TypeToVar(TCustomizeActionToolBarClass_sw);
end;

function ActnMenus_TCustomizeActionToolBar_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomizeActionToolBar = class(TCustomActionPopupMe...

  Result := TLMDUnitWrapper.TypeToVar(TCustomizeActionToolBar_sw);
end;

function ActnMenus_TCustomizeActionLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomizeActionLink = class(TActionClientLink);

  Result := TLMDUnitWrapper.TypeToVar(TCustomizeActionLink_sw);
end;

function ActnMenus_TCustomizeActionClientItem_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomizeActionClientItem = class(TActionClientItem);

  Result := TLMDUnitWrapper.TypeToVar(TCustomizeActionClientItem_sw);
end;

function ActnMenus_TMDIButtonStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMDIButtonStyle = (mbMinimize, mbRestore, mbClose);

  Result := TLMDUnitWrapper.TypeToVar(TMDIButtonStyle_sw);
end;

function ActnMenus_TCustomMDIMenuButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomMDIMenuButton = class(TSpeedButton);

  Result := TLMDUnitWrapper.TypeToVar(TCustomMDIMenuButton_sw);
end;

function ActnMenus_TCustomActionMainMenuBar_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomActionMainMenuBar = class(TCustomActionMenuBar);

  Result := TLMDUnitWrapper.TypeToVar(TCustomActionMainMenuBar_sw);
end;

function ActnMenus_TActionMainMenuBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionMainMenuBar = class(TCustomActionMainMenuBar);

  Result := TLMDUnitWrapper.TypeToVar(TActionMainMenuBar_sw);
end;

function ActnMenus_TMenuEdges_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMenuEdges = set of TEdgeBorder;

  Result := TLMDUnitWrapper.TypeToVar(TMenuEdges_sw);
end;

function ActnMenus_TCustomMenuItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomMenuItem = class(TCustomActionControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomMenuItem_sw);
end;

function ActnMenus_TCustomMenuButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomMenuButton = class(TCustomButtonControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomMenuButton_sw);
end;

function ActnMenus_TCustomAddRemoveItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomAddRemoveItem = class(TCustomMenuItem);

  Result := TLMDUnitWrapper.TypeToVar(TCustomAddRemoveItem_sw);
end;

function ActnMenus_TMenuItemControlClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMenuItemControlClass = class of TCustomMenuItem;

  Result := TLMDUnitWrapper.TypeToVar(TMenuItemControlClass_sw);
end;

function ActnMenus_TAddRemoveItemClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAddRemoveItemClass = class of TCustomAddRemoveItem;

  Result := TLMDUnitWrapper.TypeToVar(TAddRemoveItemClass_sw);
end;

function ActnMenus_TMenuButtonControlClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMenuButtonControlClass = class of TCustomMenuButton;

  Result := TLMDUnitWrapper.TypeToVar(TMenuButtonControlClass_sw);
end;

function ActnMenus_MenuItemControlClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MenuItemControlClass: TMenuItemControlClass;

  if IsGet then
    Result := TMenuItemControlClass_sw.ToVar(ActnMenus.MenuItemControlClass)
  else
    ActnMenus.MenuItemControlClass := TMenuItemControlClass_sw.FromVar(
      AArgs[0]);
end;

function ActnMenus_MenuAddRemoveItemClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MenuAddRemoveItemClass: TAddRemoveItemClass;

  if IsGet then
    Result := TAddRemoveItemClass_sw.ToVar(ActnMenus.MenuAddRemoveItemClass)
  else
    ActnMenus.MenuAddRemoveItemClass := TAddRemoveItemClass_sw.FromVar(
      AArgs[0]);
end;

function ActnMenus_MenuButtonControlClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MenuButtonControlClass: TMenuButtonControlClass;

  if IsGet then
    Result := TMenuButtonControlClass_sw.ToVar(ActnMenus.MenuButtonControlClass)
  else
    ActnMenus.MenuButtonControlClass := TMenuButtonControlClass_sw.FromVar(
      AArgs[0]);
end;

function ActnMenus_MenuPopupClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MenuPopupClass: TCustomPopupClass;

  if IsGet then
    Result := TCustomPopupClass_sw.ToVar(ActnMenus.MenuPopupClass)
  else
    ActnMenus.MenuPopupClass := TCustomPopupClass_sw.FromVar(AArgs[0]);
end;

function ActnMenus_MenuCustomizePopupClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MenuCustomizePopupClass: TCustomizeActionToolBarClass;

  if IsGet then
    Result := TCustomizeActionToolBarClass_sw.ToVar(ActnMenus.
      MenuCustomizePopupClass)
  else
    ActnMenus.MenuCustomizePopupClass := TCustomizeActionToolBarClass_sw.
      FromVar(AArgs[0]);
end;

function ActnMenus_RegisterActnBarStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RegisterActnBarStyle(AStyle: TActionBarStyleEx);

  ActnMenus.RegisterActnBarStyle(TActionBarStyleEx_sw.FromVar(AArgs[0]));
end;

function ActnMenus_UnRegisterActnBarStyle_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UnRegisterActnBarStyle(AStyle: TActionBarStyleEx);

  ActnMenus.UnRegisterActnBarStyle(TActionBarStyleEx_sw.FromVar(AArgs[0]));
end;

class function ActnMenus_sw.GetUnitName: WideString;
begin
  Result := 'ActnMenus';
end;

class procedure ActnMenus_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TMenuStack_sw, ActnMenus_TMenuStack_si);
  AData.AddType(TCustomPopupClass_sw, ActnMenus_TCustomPopupClass_si);
  AData.AddType(TCustomAddRemoveItemClass_sw, ActnMenus_TCustomAddRemoveItemClass_si);
  AData.AddType(TActionBarStyleEx_sw, ActnMenus_TActionBarStyleEx_si);
  AData.AddType(TAnimationStyle_sw, ActnMenus_TAnimationStyle_si);
  AData.AddType(TMenuPopupEvent_sw, ActnMenus_TMenuPopupEvent_si);
  AData.AddType(TGetPopupClassEvent_sw, ActnMenus_TGetPopupClassEvent_si);
  AData.AddType(TExitMenuEvent_sw, ActnMenus_TExitMenuEvent_si);
  AData.AddType(TCustomActionMenuBar_sw, ActnMenus_TCustomActionMenuBar_si);
  AData.AddType(TCustomMenuExpandBtn_sw, ActnMenus_TCustomMenuExpandBtn_si);
  AData.AddType(TCustomMenuExpandBtnClass_sw, ActnMenus_TCustomMenuExpandBtnClass_si);
  AData.AddType(TCustomActionPopupMenu_sw, ActnMenus_TCustomActionPopupMenu_si);
  AData.AddType(TCustomizeActionToolBarClass_sw, ActnMenus_TCustomizeActionToolBarClass_si);
  AData.AddType(TCustomizeActionToolBar_sw, ActnMenus_TCustomizeActionToolBar_si);
  AData.AddType(TCustomizeActionLink_sw, ActnMenus_TCustomizeActionLink_si);
  AData.AddType(TCustomizeActionClientItem_sw, ActnMenus_TCustomizeActionClientItem_si);
  AData.AddType(TMDIButtonStyle_sw, ActnMenus_TMDIButtonStyle_si);
  AData.AddType(TCustomMDIMenuButton_sw, ActnMenus_TCustomMDIMenuButton_si);
  AData.AddType(TCustomActionMainMenuBar_sw, ActnMenus_TCustomActionMainMenuBar_si);
  AData.AddType(TActionMainMenuBar_sw, ActnMenus_TActionMainMenuBar_si);
  AData.AddType(TMenuEdges_sw, ActnMenus_TMenuEdges_si);
  AData.AddType(TCustomMenuItem_sw, ActnMenus_TCustomMenuItem_si);
  AData.AddType(TCustomMenuButton_sw, ActnMenus_TCustomMenuButton_si);
  AData.AddType(TCustomAddRemoveItem_sw, ActnMenus_TCustomAddRemoveItem_si);
  AData.AddType(TMenuItemControlClass_sw, ActnMenus_TMenuItemControlClass_si);
  AData.AddType(TAddRemoveItemClass_sw, ActnMenus_TAddRemoveItemClass_si);
  AData.AddType(TMenuButtonControlClass_sw, ActnMenus_TMenuButtonControlClass_si);
  AData.AddVariable('MenuItemControlClass', ActnMenus_MenuItemControlClass_si, TMenuItemControlClass_sw);
  AData.AddVariable('MenuAddRemoveItemClass', ActnMenus_MenuAddRemoveItemClass_si, TAddRemoveItemClass_sw);
  AData.AddVariable('MenuButtonControlClass', ActnMenus_MenuButtonControlClass_si, TMenuButtonControlClass_sw);
  AData.AddVariable('MenuPopupClass', ActnMenus_MenuPopupClass_si, TCustomPopupClass_sw);
  AData.AddVariable('MenuCustomizePopupClass', ActnMenus_MenuCustomizePopupClass_si, TCustomizeActionToolBarClass_sw);
  AData.AddProcedure('RegisterActnBarStyle', ActnMenus_RegisterActnBarStyle_si, 1, False);
  AData.AddProcedure('UnRegisterActnBarStyle', ActnMenus_UnRegisterActnBarStyle_si, 1, False);
end;

class function ActnMenus_sw.ToVar(
  AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(ActnMenus_sw);
end;

initialization
  RegisterUnitWrapper(ActnMenus_sw);
  RegisterClassWrapper(TMenuStack_sw);
  RegisterClassWrapper(TActionBarStyleEx_sw);
  RegisterClassWrapper(TCustomActionMenuBar_sw);
  RegisterClassWrapper(TCustomMenuExpandBtn_sw);
  RegisterClassWrapper(TCustomActionPopupMenu_sw);
  RegisterClassWrapper(TCustomizeActionToolBar_sw);
  RegisterClassWrapper(TCustomizeActionLink_sw);
  RegisterClassWrapper(TCustomizeActionClientItem_sw);
  RegisterClassWrapper(TCustomMDIMenuButton_sw);
  RegisterClassWrapper(TCustomActionMainMenuBar_sw);
  RegisterClassWrapper(TActionMainMenuBar_sw);
  RegisterClassWrapper(TCustomMenuItem_sw);
  RegisterClassWrapper(TCustomMenuButton_sw);
  RegisterClassWrapper(TCustomAddRemoveItem_sw);
  RegisterEventWrapper(TypeInfo(TMenuPopupEvent), TMenuPopupEvent_sw);
  RegisterEventWrapper(TypeInfo(TGetPopupClassEvent), TGetPopupClassEvent_sw);
  RegisterEventWrapper(TypeInfo(TExitMenuEvent), TExitMenuEvent_sw);

end.
