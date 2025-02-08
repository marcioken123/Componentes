unit Menus_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Menus' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Variants, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, Windows, SysUtils, Classes, Contnrs, Messages, Graphics,
  ImgList, ActnList, Menus, Windows_LMDSW, SysUtils_LMDSW, Classes_LMDSW,
  Contnrs_LMDSW, Messages_LMDSW, Graphics_LMDSW, ImgList_LMDSW, ActnList_LMDSW;


{ Type wrappers }

type
  EMenuError_sw = class;
  TMenuActionLink_sw = class;
  TMenuActionLinkClass_sw = class;
  TMenuItemEnumerator_sw = class;
  TMenuItem_sw = class;
  TMenu_sw = class;
  TMainMenu_sw = class;
  TPopupMenu_sw = class;
  TPopupList_sw = class;
  TMenuItemStack_sw = class;

  EMenuError_sc = class of EMenuError;
  EMenuError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EMenuError): OleVariant;
    class function FromVar(const AValue: OleVariant): EMenuError;
    class function ClassToVar(AClass: EMenuError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EMenuError_sc;
  end;

  TMenuBreak_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TMenuBreak): OleVariant;
    class function FromVar(const AValue: OleVariant): TMenuBreak;
  end;

  TMenuChangeEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Source: TMenuItem; Rebuild: Boolean);
  end;

  TMenuChangeEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TMenuChangeEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TMenuChangeEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TMenuChangeEvent;
  end;

  TMenuDrawItemEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      Selected: Boolean);
  end;

  TMenuDrawItemEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TMenuDrawItemEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TMenuDrawItemEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TMenuDrawItemEvent;
  end;

  TMenuMeasureItemEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; ACanvas: TCanvas; var Width: Integer;
      var Height: Integer);
  end;

  TMenuMeasureItemEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TMenuMeasureItemEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TMenuMeasureItemEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TMenuMeasureItemEvent;
  end;

  TMenuItemAutoFlag_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TMenuItemAutoFlag): OleVariant;
    class function FromVar(const AValue: OleVariant): TMenuItemAutoFlag;
  end;

  TMenuAutoFlag_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TMenuAutoFlag): OleVariant;
    class function FromVar(const AValue: OleVariant): TMenuAutoFlag;
  end;

  TMenuActionLink_sc = class of TMenuActionLink;
  TMenuActionLink_sw = class(TActionLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMenuActionLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TMenuActionLink;
    class function ClassToVar(AClass: TMenuActionLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMenuActionLink_sc;
  end;

  TMenuActionLinkClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TMenuActionLinkClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TMenuActionLinkClass;
  end;

  TMenuItemEnumerator_sc = class of TMenuItemEnumerator;
  TMenuItemEnumerator_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMenuItemEnumerator): OleVariant;
    class function FromVar(const AValue: OleVariant): TMenuItemEnumerator;
    class function ClassToVar(AClass: TMenuItemEnumerator_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMenuItemEnumerator_sc;
  end;

  TMenuItem_sc = class of TMenuItem;
  TMenuItem_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMenuItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TMenuItem;
    class function ClassToVar(AClass: TMenuItem_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMenuItem_sc;
  end;

  TFindItemKind_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFindItemKind): OleVariant;
    class function FromVar(const AValue: OleVariant): TFindItemKind;
  end;

  TMenu_sc = class of TMenu;
  TMenu_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMenu): OleVariant;
    class function FromVar(const AValue: OleVariant): TMenu;
    class function ClassToVar(AClass: TMenu_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMenu_sc;
  end;

  TMainMenu_sc = class of TMainMenu;
  TMainMenu_sw = class(TMenu_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMainMenu): OleVariant;
    class function FromVar(const AValue: OleVariant): TMainMenu;
    class function ClassToVar(AClass: TMainMenu_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMainMenu_sc;
  end;

  TPopupAlignment_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPopupAlignment): OleVariant;
    class function FromVar(const AValue: OleVariant): TPopupAlignment;
  end;

  TTrackButton_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TTrackButton): OleVariant;
    class function FromVar(const AValue: OleVariant): TTrackButton;
  end;

  TMenuAnimations_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TMenuAnimations): OleVariant;
    class function FromVar(const AValue: OleVariant): TMenuAnimations;
  end;

  TMenuAnimation_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TMenuAnimation): OleVariant;
    class function FromVar(const AValue: OleVariant): TMenuAnimation;
  end;

  TPopupMenu_sc = class of TPopupMenu;
  TPopupMenu_sw = class(TMenu_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPopupMenu): OleVariant;
    class function FromVar(const AValue: OleVariant): TPopupMenu;
    class function ClassToVar(AClass: TPopupMenu_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPopupMenu_sc;
  end;

  TPopupList_sc = class of TPopupList;
  TPopupList_sw = class(TList_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPopupList): OleVariant;
    class function FromVar(const AValue: OleVariant): TPopupList;
    class function ClassToVar(AClass: TPopupList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPopupList_sc;
  end;

  TMenuItemStack_sc = class of TMenuItemStack;
  TMenuItemStack_sw = class(TStack_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMenuItemStack): OleVariant;
    class function FromVar(const AValue: OleVariant): TMenuItemStack;
    class function ClassToVar(AClass: TMenuItemStack_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMenuItemStack_sc;
  end;


{ Unit wrapper }

type
  Menus_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TMenuItem_sacc = class(TMenuItem);
  TMenu_sacc = class(TMenu);

{ EMenuError_sw }

class function EMenuError_sw.GetTypeName: WideString;
begin
  Result := 'EMenuError';
end;

class function EMenuError_sw.GetWrappedClass: TClass;
begin
  Result := EMenuError;
end;

class procedure EMenuError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EMenuError_sw.ToVar(const AValue: EMenuError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EMenuError_sw.FromVar(const AValue: OleVariant): EMenuError;
begin
  Result := EMenuError(ConvFromVar(AValue, EMenuError));
end;

class function EMenuError_sw.ClassToVar(AClass: EMenuError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EMenuError_sw.ClassFromVar(
  const AClass: OleVariant): EMenuError_sc;
begin
  Result := EMenuError_sc(ConvClsFromVar(AClass, EMenuError));
end;

{ TMenuBreak_sw }

class function TMenuBreak_sw.GetTypeName: WideString;
begin
  Result := 'TMenuBreak';
end;

class procedure TMenuBreak_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'mbNone'; Value: Integer({$IFDEF LMDSCT_12}TMenuBreak.{$ENDIF}mbNone)),
    (Name: 'mbBreak'; Value: Integer({$IFDEF LMDSCT_12}TMenuBreak.{$ENDIF}mbBreak)),
    (Name: 'mbBarBreak'; Value: Integer({$IFDEF LMDSCT_12}TMenuBreak.{$ENDIF}mbBarBreak))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TMenuBreak_sw.ToVar(const AValue: TMenuBreak): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TMenuBreak_sw.FromVar(const AValue: OleVariant): TMenuBreak;
begin
  Result := TMenuBreak(Integer(AValue));
end;

{ TMenuChangeEvent_sh }

function TMenuChangeEvent_sh.GetHandler: TMethod;
var
  hdr: TMenuChangeEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TMenuChangeEvent_sh.Handler(Sender: TObject; Source: TMenuItem;
  Rebuild: Boolean);
var
  args: array[0..2] of OleVariant;
begin
  // procedure (Sender: TObject; Source: TMenuItem; Rebuild: B...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TMenuItem_sw.ToVar(Source);
  args[2] := Rebuild;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TMenuChangeEvent_sw }

class function TMenuChangeEvent_sw.GetTypeName: WideString;
begin
  Result := 'TMenuChangeEvent';
end;

class function TMenuChangeEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TMenuChangeEvent_sh;
end;

class function TMenuChangeEvent_sw.ToVar(
  const AValue: TMenuChangeEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TMenuChangeEvent_sw.FromVar(
  const AValue: OleVariant): TMenuChangeEvent;
begin
  Result := TMenuChangeEvent(ConvFromVar(AValue));
end;

class function TMenuChangeEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TMenuChangeEvent;
var
  hdlr: TMenuChangeEvent_sh;
begin
  hdlr   := TMenuChangeEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TMenuChangeEvent_sw));
  Result := hdlr.Handler;
end;

{ TMenuDrawItemEvent_sh }

function TMenuDrawItemEvent_sh.GetHandler: TMethod;
var
  hdr: TMenuDrawItemEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TMenuDrawItemEvent_sh.Handler(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
var
  args: array[0..3] of OleVariant;
begin
  // procedure (Sender: TObject; ACanvas: TCanvas; ARect: TRec...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TCanvas_sw.ToVar(ACanvas);
  args[2] := TRect_sw.ToVar(ARect);
  args[3] := Selected;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TMenuDrawItemEvent_sw }

class function TMenuDrawItemEvent_sw.GetTypeName: WideString;
begin
  Result := 'TMenuDrawItemEvent';
end;

class function TMenuDrawItemEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TMenuDrawItemEvent_sh;
end;

class function TMenuDrawItemEvent_sw.ToVar(
  const AValue: TMenuDrawItemEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TMenuDrawItemEvent_sw.FromVar(
  const AValue: OleVariant): TMenuDrawItemEvent;
begin
  Result := TMenuDrawItemEvent(ConvFromVar(AValue));
end;

class function TMenuDrawItemEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TMenuDrawItemEvent;
var
  hdlr: TMenuDrawItemEvent_sh;
begin
  hdlr   := TMenuDrawItemEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TMenuDrawItemEvent_sw));
  Result := hdlr.Handler;
end;

{ TMenuMeasureItemEvent_sh }

function TMenuMeasureItemEvent_sh.GetHandler: TMethod;
var
  hdr: TMenuMeasureItemEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TMenuMeasureItemEvent_sh.Handler(Sender: TObject; ACanvas: TCanvas;
  var Width: Integer; var Height: Integer);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
  v_2: OleVariant;
begin
  // procedure (Sender: TObject; ACanvas: TCanvas; var Width: ...

  v_1 := Width;
  v_2 := Height;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TCanvas_sw.ToVar(ACanvas);
  args[2] := MakeVarRef(v_1);
  args[3] := MakeVarRef(v_2);
  Self.Owner.RunProc(Self.ProcName, args);
  Width := Integer(v_1);
  Height := Integer(v_2);
end;

{ TMenuMeasureItemEvent_sw }

class function TMenuMeasureItemEvent_sw.GetTypeName: WideString;
begin
  Result := 'TMenuMeasureItemEvent';
end;

class function TMenuMeasureItemEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TMenuMeasureItemEvent_sh;
end;

class function TMenuMeasureItemEvent_sw.ToVar(
  const AValue: TMenuMeasureItemEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TMenuMeasureItemEvent_sw.FromVar(
  const AValue: OleVariant): TMenuMeasureItemEvent;
begin
  Result := TMenuMeasureItemEvent(ConvFromVar(AValue));
end;

class function TMenuMeasureItemEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TMenuMeasureItemEvent;
var
  hdlr: TMenuMeasureItemEvent_sh;
begin
  hdlr   := TMenuMeasureItemEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TMenuMeasureItemEvent_sw));
  Result := hdlr.Handler;
end;

{ TMenuItemAutoFlag_sw }

class function TMenuItemAutoFlag_sw.GetTypeName: WideString;
begin
  Result := 'TMenuItemAutoFlag';
end;

class procedure TMenuItemAutoFlag_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'maAutomatic'; Value: Integer({$IFDEF LMDSCT_12}TMenuItemAutoFlag.{$ENDIF}maAutomatic)),
    (Name: 'maManual'; Value: Integer({$IFDEF LMDSCT_12}TMenuItemAutoFlag.{$ENDIF}maManual)),
    (Name: 'maParent'; Value: Integer({$IFDEF LMDSCT_12}TMenuItemAutoFlag.{$ENDIF}maParent))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TMenuItemAutoFlag_sw.ToVar(
  const AValue: TMenuItemAutoFlag): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TMenuItemAutoFlag_sw.FromVar(
  const AValue: OleVariant): TMenuItemAutoFlag;
begin
  Result := TMenuItemAutoFlag(Integer(AValue));
end;

{ TMenuAutoFlag_sw }

class function TMenuAutoFlag_sw.GetTypeName: WideString;
begin
  Result := 'TMenuAutoFlag';
end;

class function TMenuAutoFlag_sw.ToVar(const AValue: TMenuAutoFlag): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TMenuAutoFlag_sw.FromVar(
  const AValue: OleVariant): TMenuAutoFlag;
begin
  Result := TMenuAutoFlag(Integer(AValue));
end;

{ TMenuActionLink_sw }

class function TMenuActionLink_sw.GetTypeName: WideString;
begin
  Result := 'TMenuActionLink';
end;

class function TMenuActionLink_sw.GetWrappedClass: TClass;
begin
  Result := TMenuActionLink;
end;

class procedure TMenuActionLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TMenuActionLink_sw.ToVar(
  const AValue: TMenuActionLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMenuActionLink_sw.FromVar(
  const AValue: OleVariant): TMenuActionLink;
begin
  Result := TMenuActionLink(ConvFromVar(AValue, TMenuActionLink));
end;

class function TMenuActionLink_sw.ClassToVar(
  AClass: TMenuActionLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMenuActionLink_sw.ClassFromVar(
  const AClass: OleVariant): TMenuActionLink_sc;
begin
  Result := TMenuActionLink_sc(ConvClsFromVar(AClass, TMenuActionLink));
end;

{ TMenuActionLinkClass_sw }

class function TMenuActionLinkClass_sw.GetTypeName: WideString;
begin
  Result := 'TMenuActionLinkClass';
end;

class function TMenuActionLinkClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TMenuActionLink;
end;

class function TMenuActionLinkClass_sw.ToVar(
  const AValue: TMenuActionLinkClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMenuActionLinkClass_sw.FromVar(
  const AValue: OleVariant): TMenuActionLinkClass;
begin
  Result := TMenuActionLinkClass(ConvFromVar(AValue, TMenuActionLink));
end;

{ TMenuItemEnumerator_sw }

function TMenuItemEnumerator_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AMenuItem: TMenuItem);

  Result := TMenuItemEnumerator_sw.ToVar(TMenuItemEnumerator_sc(AObj).Create(
    TMenuItem_sw.FromVar(AArgs[0])));
end;

function TMenuItemEnumerator_GetCurrent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetCurrent: TMenuItem;

  Result := TMenuItem_sw.ToVar(TMenuItemEnumerator(AObj).GetCurrent());
end;

function TMenuItemEnumerator_MoveNext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MoveNext: Boolean;

  Result := TMenuItemEnumerator(AObj).MoveNext();
end;

function TMenuItemEnumerator_Current_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Current: TMenuItem read <getter>;

  Result := TMenuItem_sw.ToVar(TMenuItemEnumerator(AObj).Current);
end;

class function TMenuItemEnumerator_sw.GetTypeName: WideString;
begin
  Result := 'TMenuItemEnumerator';
end;

class function TMenuItemEnumerator_sw.GetWrappedClass: TClass;
begin
  Result := TMenuItemEnumerator;
end;

class procedure TMenuItemEnumerator_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('GetCurrent', TMenuItemEnumerator_GetCurrent_si, TMenuItem_sw, 0, False);
  AData.AddFunction('MoveNext', TMenuItemEnumerator_MoveNext_si, Boolean_sw, 0, False);
  AData.AddProperty('Current', TMenuItemEnumerator_Current_si, TMenuItem_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TMenuItemEnumerator_Create_si, 1, False);
end;

class function TMenuItemEnumerator_sw.ToVar(
  const AValue: TMenuItemEnumerator): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMenuItemEnumerator_sw.FromVar(
  const AValue: OleVariant): TMenuItemEnumerator;
begin
  Result := TMenuItemEnumerator(ConvFromVar(AValue, TMenuItemEnumerator));
end;

class function TMenuItemEnumerator_sw.ClassToVar(
  AClass: TMenuItemEnumerator_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMenuItemEnumerator_sw.ClassFromVar(
  const AClass: OleVariant): TMenuItemEnumerator_sc;
begin
  Result := TMenuItemEnumerator_sc(ConvClsFromVar(AClass, TMenuItemEnumerator));
end;

{ TMenuItem_sw }

function TMenuItem_ActionLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ActionLink: TMenuActionLink read <gett...

  if IsGet then
    Result := TMenuActionLink_sw.ToVar(TMenuItem_sacc(TMenuItem(AObj)).
      ActionLink)
  else
    TMenuItem_sacc(TMenuItem(AObj)).ActionLink := TMenuActionLink_sw.FromVar(
      AArgs[0]);
end;

function TMenuItem_InitiateAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure InitiateAction;

  TMenuItem(AObj).InitiateAction();
end;

function TMenuItem_Insert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Insert(Index: Integer; Item: TMenuItem);

  TMenuItem(AObj).Insert(Integer(AArgs[0]), TMenuItem_sw.FromVar(AArgs[1]));
end;

function TMenuItem_Delete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Delete(Index: Integer);

  TMenuItem(AObj).Delete(Integer(AArgs[0]));
end;

function TMenuItem_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TMenuItem(AObj).Clear();
end;

function TMenuItem_Click_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Click;

  TMenuItem(AObj).Click();
end;

function TMenuItem_Find_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Find(ACaption: string): TMenuItem;

  Result := TMenuItem_sw.ToVar(TMenuItem(AObj).Find(string(AArgs[0])));
end;

function TMenuItem_IndexOf_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IndexOf(Item: TMenuItem): Integer;

  Result := TMenuItem(AObj).IndexOf(TMenuItem_sw.FromVar(AArgs[0]));
end;

function TMenuItem_IsLine_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsLine: Boolean;

  Result := TMenuItem(AObj).IsLine();
end;

function TMenuItem_GetEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetEnumerator: TMenuItemEnumerator;

  Result := TMenuItemEnumerator_sw.ToVar(TMenuItem(AObj).GetEnumerator());
end;

function TMenuItem_GetImageList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetImageList: TCustomImageList;

  Result := TCustomImageList_sw.ToVar(TMenuItem(AObj).GetImageList());
end;

function TMenuItem_GetParentMenu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetParentMenu: TMenu;

  Result := TMenu_sw.ToVar(TMenuItem(AObj).GetParentMenu());
end;

function TMenuItem_NewTopLine_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function NewTopLine: Integer;

  Result := TMenuItem(AObj).NewTopLine();
end;

function TMenuItem_NewBottomLine_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function NewBottomLine: Integer;

  Result := TMenuItem(AObj).NewBottomLine();
end;

function TMenuItem_InsertNewLineBefore_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function InsertNewLineBefore(AItem: TMenuItem): Integer;

  Result := TMenuItem(AObj).InsertNewLineBefore(TMenuItem_sw.FromVar(AArgs[0]));
end;

function TMenuItem_InsertNewLineAfter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function InsertNewLineAfter(AItem: TMenuItem): Integer;

  Result := TMenuItem(AObj).InsertNewLineAfter(TMenuItem_sw.FromVar(AArgs[0]));
end;

function TMenuItem_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Add(Item: TMenuItem);

  TMenuItem(AObj).Add(TMenuItem_sw.FromVar(AArgs[0]));
end;

function TMenuItem_Remove_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Remove(Item: TMenuItem);

  TMenuItem(AObj).Remove(TMenuItem_sw.FromVar(AArgs[0]));
end;

function TMenuItem_RethinkHotkeys_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function RethinkHotkeys: Boolean;

  Result := TMenuItem(AObj).RethinkHotkeys();
end;

function TMenuItem_RethinkLines_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function RethinkLines: Boolean;

  Result := TMenuItem(AObj).RethinkLines();
end;

function TMenuItem_Command_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Command: Word read <getter>;

  Result := TMenuItem(AObj).Command;
end;

function TMenuItem_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HMENU read <getter>;

  Result := HMENU_sw.ToVar(TMenuItem(AObj).Handle);
end;

function TMenuItem_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Count: Integer read <getter>;

  Result := TMenuItem(AObj).Count;
end;

function TMenuItem_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TMenuItem read <getter>; ...

  Result := TMenuItem_sw.ToVar(TMenuItem(AObj).Items[Integer(AArgs[0])]);
end;

function TMenuItem_MenuIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MenuIndex: Integer read <getter> write <setter>;

  if IsGet then
    Result := TMenuItem(AObj).MenuIndex
  else
    TMenuItem(AObj).MenuIndex := Integer(AArgs[0]);
end;

function TMenuItem_Parent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Parent: TMenuItem read <getter>;

  Result := TMenuItem_sw.ToVar(TMenuItem(AObj).Parent);
end;

function TMenuItem_Action_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Action: TBasicAction read <getter> write <setter>;

  if IsGet then
    Result := TBasicAction_sw.ToVar(TMenuItem(AObj).Action)
  else
    TMenuItem(AObj).Action := TBasicAction_sw.FromVar(AArgs[0]);
end;

function TMenuItem_AutoCheck_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoCheck: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TMenuItem(AObj).AutoCheck
  else
    TMenuItem(AObj).AutoCheck := Boolean(AArgs[0]);
end;

function TMenuItem_AutoHotkeys_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoHotkeys: TMenuItemAutoFlag read <getter> wri...

  if IsGet then
    Result := TMenuItemAutoFlag_sw.ToVar(TMenuItem(AObj).AutoHotkeys)
  else
    TMenuItem(AObj).AutoHotkeys := TMenuItemAutoFlag_sw.FromVar(AArgs[0]);
end;

function TMenuItem_AutoLineReduction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoLineReduction: TMenuItemAutoFlag read <gette...

  if IsGet then
    Result := TMenuItemAutoFlag_sw.ToVar(TMenuItem(AObj).AutoLineReduction)
  else
    TMenuItem(AObj).AutoLineReduction := TMenuItemAutoFlag_sw.FromVar(AArgs[0]);
end;

function TMenuItem_Bitmap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Bitmap: TBitmap read <getter> write <setter>;

  if IsGet then
    Result := TBitmap_sw.ToVar(TMenuItem(AObj).Bitmap)
  else
    TMenuItem(AObj).Bitmap := TBitmap_sw.FromVar(AArgs[0]);
end;

function TMenuItem_Break_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Break: TMenuBreak read <getter> write <setter>;

  if IsGet then
    Result := TMenuBreak_sw.ToVar(TMenuItem(AObj).Break)
  else
    TMenuItem(AObj).Break := TMenuBreak_sw.FromVar(AArgs[0]);
end;

function TMenuItem_Caption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Caption: string read <getter> write <setter>;

  if IsGet then
    Result := TMenuItem(AObj).Caption
  else
    TMenuItem(AObj).Caption := string(AArgs[0]);
end;

function TMenuItem_Checked_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Checked: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TMenuItem(AObj).Checked
  else
    TMenuItem(AObj).Checked := Boolean(AArgs[0]);
end;

function TMenuItem_SubMenuImages_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SubMenuImages: TCustomImageList read <getter> wr...

  if IsGet then
    Result := TCustomImageList_sw.ToVar(TMenuItem(AObj).SubMenuImages)
  else
    TMenuItem(AObj).SubMenuImages := TCustomImageList_sw.FromVar(AArgs[0]);
end;

function TMenuItem_Default_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Default: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TMenuItem(AObj).Default
  else
    TMenuItem(AObj).Default := Boolean(AArgs[0]);
end;

function TMenuItem_Enabled_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Enabled: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TMenuItem(AObj).Enabled
  else
    TMenuItem(AObj).Enabled := Boolean(AArgs[0]);
end;

function TMenuItem_GroupIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GroupIndex: Byte read <getter> write <setter>;

  if IsGet then
    Result := TMenuItem(AObj).GroupIndex
  else
    TMenuItem(AObj).GroupIndex := Byte(AArgs[0]);
end;

function TMenuItem_HelpContext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HelpContext: THelpContext read <getter> write <s...

  if IsGet then
    Result := THelpContext_sw.ToVar(TMenuItem(AObj).HelpContext)
  else
    TMenuItem(AObj).HelpContext := THelpContext_sw.FromVar(AArgs[0]);
end;

function TMenuItem_Hint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Hint: string read <getter> write <setter>;

  if IsGet then
    Result := TMenuItem(AObj).Hint
  else
    TMenuItem(AObj).Hint := string(AArgs[0]);
end;

function TMenuItem_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImageIndex: TImageIndex read <getter> write <set...

  if IsGet then
    Result := TImageIndex_sw.ToVar(TMenuItem(AObj).ImageIndex)
  else
    TMenuItem(AObj).ImageIndex := TImageIndex_sw.FromVar(AArgs[0]);
end;

function TMenuItem_RadioItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RadioItem: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TMenuItem(AObj).RadioItem
  else
    TMenuItem(AObj).RadioItem := Boolean(AArgs[0]);
end;

function TMenuItem_ShortCut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShortCut: TShortCut read <getter> write <setter>;

  if IsGet then
    Result := TShortCut_sw.ToVar(TMenuItem(AObj).ShortCut)
  else
    TMenuItem(AObj).ShortCut := TShortCut_sw.FromVar(AArgs[0]);
end;

function TMenuItem_Visible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Visible: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TMenuItem(AObj).Visible
  else
    TMenuItem(AObj).Visible := Boolean(AArgs[0]);
end;

function TMenuItem_OnClick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnClick: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TMenuItem(AObj).OnClick)
  else
    TMenuItem(AObj).OnClick := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TMenuItem_OnDrawItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDrawItem: TMenuDrawItemEvent read <getter> wri...

  if IsGet then
    Result := TMenuDrawItemEvent_sw.ToVar(TMenuItem(AObj).OnDrawItem)
  else
    TMenuItem(AObj).OnDrawItem := TMenuDrawItemEvent_sw.FromVar(AArgs[0]);
end;

function TMenuItem_OnMeasureItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnMeasureItem: TMenuMeasureItemEvent read <gette...

  if IsGet then
    Result := TMenuMeasureItemEvent_sw.ToVar(TMenuItem(AObj).OnMeasureItem)
  else
    TMenuItem(AObj).OnMeasureItem := TMenuMeasureItemEvent_sw.FromVar(AArgs[0]);
end;

class function TMenuItem_sw.GetTypeName: WideString;
begin
  Result := 'TMenuItem';
end;

class function TMenuItem_sw.GetWrappedClass: TClass;
begin
  Result := TMenuItem;
end;

class procedure TMenuItem_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ActionLink', TMenuItem_ActionLink_si, TMenuActionLink_sw, True, True, 0, True, False);
  AData.AddProcedure('InitiateAction', TMenuItem_InitiateAction_si, 0, False);
  AData.AddProcedure('Insert', TMenuItem_Insert_si, 2, False);
  AData.AddProcedure('Delete', TMenuItem_Delete_si, 1, False);
  AData.AddProcedure('Clear', TMenuItem_Clear_si, 0, False);
  AData.AddProcedure('Click', TMenuItem_Click_si, 0, False);
  AData.AddFunction('Find', TMenuItem_Find_si, TMenuItem_sw, 1, False);
  AData.AddFunction('IndexOf', TMenuItem_IndexOf_si, Integer_sw, 1, False);
  AData.AddFunction('IsLine', TMenuItem_IsLine_si, Boolean_sw, 0, False);
  AData.AddFunction('GetEnumerator', TMenuItem_GetEnumerator_si, TMenuItemEnumerator_sw, 0, False);
  AData.AddFunction('GetImageList', TMenuItem_GetImageList_si, TCustomImageList_sw, 0, False);
  AData.AddFunction('GetParentMenu', TMenuItem_GetParentMenu_si, TMenu_sw, 0, False);
  AData.AddFunction('NewTopLine', TMenuItem_NewTopLine_si, Integer_sw, 0, False);
  AData.AddFunction('NewBottomLine', TMenuItem_NewBottomLine_si, Integer_sw, 0, False);
  AData.AddFunction('InsertNewLineBefore', TMenuItem_InsertNewLineBefore_si, Integer_sw, 1, False);
  AData.AddFunction('InsertNewLineAfter', TMenuItem_InsertNewLineAfter_si, Integer_sw, 1, False);
  AData.AddProcedure('Add', TMenuItem_Add_si, 1, False);
  AData.AddProcedure('Remove', TMenuItem_Remove_si, 1, False);
  AData.AddFunction('RethinkHotkeys', TMenuItem_RethinkHotkeys_si, Boolean_sw, 0, False);
  AData.AddFunction('RethinkLines', TMenuItem_RethinkLines_si, Boolean_sw, 0, False);
  AData.AddProperty('Command', TMenuItem_Command_si, Word_sw, True, False, 0, False, False);
  AData.AddProperty('Handle', TMenuItem_Handle_si, HMENU_sw, True, False, 0, False, False);
  AData.AddProperty('Count', TMenuItem_Count_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Items', TMenuItem_Items_si, TMenuItem_sw, True, False, 1, False, True);
  AData.AddProperty('MenuIndex', TMenuItem_MenuIndex_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Parent', TMenuItem_Parent_si, TMenuItem_sw, True, False, 0, False, False);
  AData.AddProperty('Action', TMenuItem_Action_si, TBasicAction_sw, True, True, 0, False, False);
  AData.AddProperty('AutoCheck', TMenuItem_AutoCheck_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('AutoHotkeys', TMenuItem_AutoHotkeys_si, TMenuItemAutoFlag_sw, True, True, 0, False, False);
  AData.AddProperty('AutoLineReduction', TMenuItem_AutoLineReduction_si, TMenuItemAutoFlag_sw, True, True, 0, False, False);
  AData.AddProperty('Bitmap', TMenuItem_Bitmap_si, TBitmap_sw, True, True, 0, False, False);
  AData.AddProperty('Break', TMenuItem_Break_si, TMenuBreak_sw, True, True, 0, False, False);
  AData.AddProperty('Caption', TMenuItem_Caption_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Checked', TMenuItem_Checked_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('SubMenuImages', TMenuItem_SubMenuImages_si, TCustomImageList_sw, True, True, 0, False, False);
  AData.AddProperty('Default', TMenuItem_Default_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Enabled', TMenuItem_Enabled_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('GroupIndex', TMenuItem_GroupIndex_si, Byte_sw, True, True, 0, False, False);
  AData.AddProperty('HelpContext', TMenuItem_HelpContext_si, THelpContext_sw, True, True, 0, False, False);
  AData.AddProperty('Hint', TMenuItem_Hint_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('ImageIndex', TMenuItem_ImageIndex_si, TImageIndex_sw, True, True, 0, False, False);
  AData.AddProperty('RadioItem', TMenuItem_RadioItem_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ShortCut', TMenuItem_ShortCut_si, TShortCut_sw, True, True, 0, False, False);
  AData.AddProperty('Visible', TMenuItem_Visible_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('OnClick', TMenuItem_OnClick_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDrawItem', TMenuItem_OnDrawItem_si, TMenuDrawItemEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnMeasureItem', TMenuItem_OnMeasureItem_si, TMenuMeasureItemEvent_sw, True, True, 0, False, False);
end;

class function TMenuItem_sw.ToVar(const AValue: TMenuItem): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMenuItem_sw.FromVar(const AValue: OleVariant): TMenuItem;
begin
  Result := TMenuItem(ConvFromVar(AValue, TMenuItem));
end;

class function TMenuItem_sw.ClassToVar(AClass: TMenuItem_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMenuItem_sw.ClassFromVar(
  const AClass: OleVariant): TMenuItem_sc;
begin
  Result := TMenuItem_sc(ConvClsFromVar(AClass, TMenuItem));
end;

{ TFindItemKind_sw }

class function TFindItemKind_sw.GetTypeName: WideString;
begin
  Result := 'TFindItemKind';
end;

class procedure TFindItemKind_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'fkCommand'; Value: Integer({$IFDEF LMDSCT_12}TFindItemKind.{$ENDIF}fkCommand)),
    (Name: 'fkHandle'; Value: Integer({$IFDEF LMDSCT_12}TFindItemKind.{$ENDIF}fkHandle)),
    (Name: 'fkShortCut'; Value: Integer({$IFDEF LMDSCT_12}TFindItemKind.{$ENDIF}fkShortCut))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TFindItemKind_sw.ToVar(const AValue: TFindItemKind): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFindItemKind_sw.FromVar(
  const AValue: OleVariant): TFindItemKind;
begin
  Result := TFindItemKind(Integer(AValue));
end;

{ TMenu_sw }

function TMenu_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnChange: TMenuChangeEvent read <gette...

  if IsGet then
    Result := TMenuChangeEvent_sw.ToVar(TMenu_sacc(TMenu(AObj)).OnChange)
  else
    TMenu_sacc(TMenu(AObj)).OnChange := TMenuChangeEvent_sw.FromVar(AArgs[0]);
end;

function TMenu_CreateMenuItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CreateMenuItem: TMenuItem;

  Result := TMenuItem_sw.ToVar(TMenu(AObj).CreateMenuItem());
end;

function TMenu_DispatchCommand_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DispatchCommand(ACommand: Word): Boolean;

  Result := TMenu(AObj).DispatchCommand(Word(AArgs[0]));
end;

function TMenu_DispatchPopup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DispatchPopup(AHandle: HMENU): Boolean;

  Result := TMenu(AObj).DispatchPopup(HMENU_sw.FromVar(AArgs[0]));
end;

function TMenu_FindItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindItem(Value: Integer; Kind: TFindItemKind): T...

  Result := TMenuItem_sw.ToVar(TMenu(AObj).FindItem(Integer(AArgs[0]), 
    TFindItemKind_sw.FromVar(AArgs[1])));
end;

function TMenu_GetHelpContext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetHelpContext(Value: Integer; ByCommand: Boolea...

  Result := THelpContext_sw.ToVar(TMenu(AObj).GetHelpContext(Integer(AArgs[0]), 
    Boolean(AArgs[1])));
end;

function TMenu_Images_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Images: TCustomImageList read <getter> write <se...

  if IsGet then
    Result := TCustomImageList_sw.ToVar(TMenu(AObj).Images)
  else
    TMenu(AObj).Images := TCustomImageList_sw.FromVar(AArgs[0]);
end;

function TMenu_IsRightToLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsRightToLeft: Boolean;

  Result := TMenu(AObj).IsRightToLeft();
end;

function TMenu_ParentBiDiModeChanged_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ParentBiDiModeChanged;

  TMenu(AObj).ParentBiDiModeChanged();
end;

function TMenu_AutoHotkeys_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoHotkeys: TMenuAutoFlag read <getter> write <...

  if IsGet then
    Result := TMenuAutoFlag_sw.ToVar(TMenu(AObj).AutoHotkeys)
  else
    TMenu(AObj).AutoHotkeys := TMenuAutoFlag_sw.FromVar(AArgs[0]);
end;

function TMenu_AutoLineReduction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoLineReduction: TMenuAutoFlag read <getter> w...

  if IsGet then
    Result := TMenuAutoFlag_sw.ToVar(TMenu(AObj).AutoLineReduction)
  else
    TMenu(AObj).AutoLineReduction := TMenuAutoFlag_sw.FromVar(AArgs[0]);
end;

function TMenu_BiDiMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BiDiMode: TBiDiMode read <getter> write <setter>;

  if IsGet then
    Result := TBiDiMode_sw.ToVar(TMenu(AObj).BiDiMode)
  else
    TMenu(AObj).BiDiMode := TBiDiMode_sw.FromVar(AArgs[0]);
end;

function TMenu_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HMENU read <getter>;

  Result := HMENU_sw.ToVar(TMenu(AObj).Handle);
end;

function TMenu_OwnerDraw_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OwnerDraw: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TMenu(AObj).OwnerDraw
  else
    TMenu(AObj).OwnerDraw := Boolean(AArgs[0]);
end;

function TMenu_ParentBiDiMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParentBiDiMode: Boolean read <getter> write <set...

  if IsGet then
    Result := TMenu(AObj).ParentBiDiMode
  else
    TMenu(AObj).ParentBiDiMode := Boolean(AArgs[0]);
end;

function TMenu_WindowHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property WindowHandle: HWND read <getter> write <setter>;

  if IsGet then
    Result := HWND_sw.ToVar(TMenu(AObj).WindowHandle)
  else
    TMenu(AObj).WindowHandle := HWND_sw.FromVar(AArgs[0]);
end;

function TMenu_Items_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Items: TMenuItem read <getter>;

  Result := TMenuItem_sw.ToVar(TMenu(AObj).Items);
end;

class function TMenu_sw.GetTypeName: WideString;
begin
  Result := 'TMenu';
end;

class function TMenu_sw.GetWrappedClass: TClass;
begin
  Result := TMenu;
end;

class procedure TMenu_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('OnChange', TMenu_OnChange_si, TMenuChangeEvent_sw, True, True, 0, True, False);
  AData.AddFunction('CreateMenuItem', TMenu_CreateMenuItem_si, TMenuItem_sw, 0, False);
  AData.AddFunction('DispatchCommand', TMenu_DispatchCommand_si, Boolean_sw, 1, False);
  AData.AddFunction('DispatchPopup', TMenu_DispatchPopup_si, Boolean_sw, 1, False);
  AData.AddFunction('FindItem', TMenu_FindItem_si, TMenuItem_sw, 2, False);
  AData.AddFunction('GetHelpContext', TMenu_GetHelpContext_si, THelpContext_sw, 2, False);
  AData.AddProperty('Images', TMenu_Images_si, TCustomImageList_sw, True, True, 0, False, False);
  AData.AddFunction('IsRightToLeft', TMenu_IsRightToLeft_si, Boolean_sw, 0, False);
  AData.AddProcedure('ParentBiDiModeChanged', TMenu_ParentBiDiModeChanged_si, 0, False);
  AData.AddProperty('AutoHotkeys', TMenu_AutoHotkeys_si, TMenuAutoFlag_sw, True, True, 0, False, False);
  AData.AddProperty('AutoLineReduction', TMenu_AutoLineReduction_si, TMenuAutoFlag_sw, True, True, 0, False, False);
  AData.AddProperty('BiDiMode', TMenu_BiDiMode_si, TBiDiMode_sw, True, True, 0, False, False);
  AData.AddProperty('Handle', TMenu_Handle_si, HMENU_sw, True, False, 0, False, False);
  AData.AddProperty('OwnerDraw', TMenu_OwnerDraw_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ParentBiDiMode', TMenu_ParentBiDiMode_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('WindowHandle', TMenu_WindowHandle_si, HWND_sw, True, True, 0, False, False);
  AData.AddProperty('Items', TMenu_Items_si, TMenuItem_sw, True, False, 0, False, False);
end;

class function TMenu_sw.ToVar(const AValue: TMenu): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMenu_sw.FromVar(const AValue: OleVariant): TMenu;
begin
  Result := TMenu(ConvFromVar(AValue, TMenu));
end;

class function TMenu_sw.ClassToVar(AClass: TMenu_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMenu_sw.ClassFromVar(const AClass: OleVariant): TMenu_sc;
begin
  Result := TMenu_sc(ConvClsFromVar(AClass, TMenu));
end;

{ TMainMenu_sw }

function TMainMenu_Merge_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Merge(Menu: TMainMenu);

  TMainMenu(AObj).Merge(TMainMenu_sw.FromVar(AArgs[0]));
end;

function TMainMenu_Unmerge_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Unmerge(Menu: TMainMenu);

  TMainMenu(AObj).Unmerge(TMainMenu_sw.FromVar(AArgs[0]));
end;

function TMainMenu_SetOle2MenuHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetOle2MenuHandle(Handle: HMENU);

  TMainMenu(AObj).SetOle2MenuHandle(HMENU_sw.FromVar(AArgs[0]));
end;

function TMainMenu_AutoMerge_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoMerge: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TMainMenu(AObj).AutoMerge
  else
    TMainMenu(AObj).AutoMerge := Boolean(AArgs[0]);
end;

class function TMainMenu_sw.GetTypeName: WideString;
begin
  Result := 'TMainMenu';
end;

class function TMainMenu_sw.GetWrappedClass: TClass;
begin
  Result := TMainMenu;
end;

class procedure TMainMenu_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Merge', TMainMenu_Merge_si, 1, False);
  AData.AddProcedure('Unmerge', TMainMenu_Unmerge_si, 1, False);
  AData.AddProcedure('SetOle2MenuHandle', TMainMenu_SetOle2MenuHandle_si, 1, False);
  AData.AddPropertyRedecl('AutoHotkeys', False);
  AData.AddPropertyRedecl('AutoLineReduction', False);
  AData.AddProperty('AutoMerge', TMainMenu_AutoMerge_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Images', False);
  AData.AddPropertyRedecl('OwnerDraw', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('OnChange', False);
end;

class function TMainMenu_sw.ToVar(const AValue: TMainMenu): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMainMenu_sw.FromVar(const AValue: OleVariant): TMainMenu;
begin
  Result := TMainMenu(ConvFromVar(AValue, TMainMenu));
end;

class function TMainMenu_sw.ClassToVar(AClass: TMainMenu_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMainMenu_sw.ClassFromVar(
  const AClass: OleVariant): TMainMenu_sc;
begin
  Result := TMainMenu_sc(ConvClsFromVar(AClass, TMainMenu));
end;

{ TPopupAlignment_sw }

class function TPopupAlignment_sw.GetTypeName: WideString;
begin
  Result := 'TPopupAlignment';
end;

class procedure TPopupAlignment_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'paLeft'; Value: Integer({$IFDEF LMDSCT_12}TPopupAlignment.{$ENDIF}paLeft)),
    (Name: 'paRight'; Value: Integer({$IFDEF LMDSCT_12}TPopupAlignment.{$ENDIF}paRight)),
    (Name: 'paCenter'; Value: Integer({$IFDEF LMDSCT_12}TPopupAlignment.{$ENDIF}paCenter))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TPopupAlignment_sw.ToVar(
  const AValue: TPopupAlignment): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPopupAlignment_sw.FromVar(
  const AValue: OleVariant): TPopupAlignment;
begin
  Result := TPopupAlignment(Integer(AValue));
end;

{ TTrackButton_sw }

class function TTrackButton_sw.GetTypeName: WideString;
begin
  Result := 'TTrackButton';
end;

class procedure TTrackButton_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'tbRightButton'; Value: Integer({$IFDEF LMDSCT_12}TTrackButton.{$ENDIF}tbRightButton)),
    (Name: 'tbLeftButton'; Value: Integer({$IFDEF LMDSCT_12}TTrackButton.{$ENDIF}tbLeftButton))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TTrackButton_sw.ToVar(const AValue: TTrackButton): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTrackButton_sw.FromVar(const AValue: OleVariant): TTrackButton;
begin
  Result := TTrackButton(Integer(AValue));
end;

{ TMenuAnimations_sw }

class function TMenuAnimations_sw.GetTypeName: WideString;
begin
  Result := 'TMenuAnimations';
end;

class procedure TMenuAnimations_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'maLeftToRight'; Value: Integer({$IFDEF LMDSCT_12}TMenuAnimations.{$ENDIF}maLeftToRight)),
    (Name: 'maRightToLeft'; Value: Integer({$IFDEF LMDSCT_12}TMenuAnimations.{$ENDIF}maRightToLeft)),
    (Name: 'maTopToBottom'; Value: Integer({$IFDEF LMDSCT_12}TMenuAnimations.{$ENDIF}maTopToBottom)),
    (Name: 'maBottomToTop'; Value: Integer({$IFDEF LMDSCT_12}TMenuAnimations.{$ENDIF}maBottomToTop)),
    (Name: 'maNone'; Value: Integer({$IFDEF LMDSCT_12}TMenuAnimations.{$ENDIF}maNone))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TMenuAnimations_sw.ToVar(
  const AValue: TMenuAnimations): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TMenuAnimations_sw.FromVar(
  const AValue: OleVariant): TMenuAnimations;
begin
  Result := TMenuAnimations(Integer(AValue));
end;

{ TMenuAnimation_sw }

class function TMenuAnimation_sw.GetTypeName: WideString;
begin
  Result := 'TMenuAnimation';
end;

class function TMenuAnimation_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TMenuAnimation);
end;

class function TMenuAnimation_sw.ToVar(
  const AValue: TMenuAnimation): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TMenuAnimation_sw.FromVar(
  const AValue: OleVariant): TMenuAnimation;
begin
  ConvFromVar(AValue, @Result);
end;

{ TPopupMenu_sw }

function TPopupMenu_Popup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Popup(X: Integer; Y: Integer);

  TPopupMenu(AObj).Popup(Integer(AArgs[0]), Integer(AArgs[1]));
end;

function TPopupMenu_PopupComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PopupComponent: TComponent read <getter> write <...

  if IsGet then
    Result := TComponent_sw.ToVar(TPopupMenu(AObj).PopupComponent)
  else
    TPopupMenu(AObj).PopupComponent := TComponent_sw.FromVar(AArgs[0]);
end;

function TPopupMenu_PopupPoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PopupPoint: TPoint read <getter>;

  Result := TPoint_sw.ToVar(TPopupMenu(AObj).PopupPoint);
end;

function TPopupMenu_Alignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Alignment: TPopupAlignment read <getter> write <...

  if IsGet then
    Result := TPopupAlignment_sw.ToVar(TPopupMenu(AObj).Alignment)
  else
    TPopupMenu(AObj).Alignment := TPopupAlignment_sw.FromVar(AArgs[0]);
end;

function TPopupMenu_AutoPopup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoPopup: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TPopupMenu(AObj).AutoPopup
  else
    TPopupMenu(AObj).AutoPopup := Boolean(AArgs[0]);
end;

function TPopupMenu_HelpContext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HelpContext: THelpContext read <getter> write <s...

  if IsGet then
    Result := THelpContext_sw.ToVar(TPopupMenu(AObj).HelpContext)
  else
    TPopupMenu(AObj).HelpContext := THelpContext_sw.FromVar(AArgs[0]);
end;

function TPopupMenu_MenuAnimation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MenuAnimation: TMenuAnimation read <getter> writ...

  if IsGet then
    Result := TMenuAnimation_sw.ToVar(TPopupMenu(AObj).MenuAnimation)
  else
    TPopupMenu(AObj).MenuAnimation := TMenuAnimation_sw.FromVar(AArgs[0]);
end;

function TPopupMenu_TrackButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TrackButton: TTrackButton read <getter> write <s...

  if IsGet then
    Result := TTrackButton_sw.ToVar(TPopupMenu(AObj).TrackButton)
  else
    TPopupMenu(AObj).TrackButton := TTrackButton_sw.FromVar(AArgs[0]);
end;

function TPopupMenu_OnPopup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnPopup: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TPopupMenu(AObj).OnPopup)
  else
    TPopupMenu(AObj).OnPopup := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TPopupMenu_sw.GetTypeName: WideString;
begin
  Result := 'TPopupMenu';
end;

class function TPopupMenu_sw.GetWrappedClass: TClass;
begin
  Result := TPopupMenu;
end;

class procedure TPopupMenu_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Popup', TPopupMenu_Popup_si, 2, False);
  AData.AddProperty('PopupComponent', TPopupMenu_PopupComponent_si, TComponent_sw, True, True, 0, False, False);
  AData.AddProperty('PopupPoint', TPopupMenu_PopupPoint_si, TPoint_sw, True, False, 0, False, False);
  AData.AddProperty('Alignment', TPopupMenu_Alignment_si, TPopupAlignment_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('AutoHotkeys', False);
  AData.AddPropertyRedecl('AutoLineReduction', False);
  AData.AddProperty('AutoPopup', TPopupMenu_AutoPopup_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddProperty('HelpContext', TPopupMenu_HelpContext_si, THelpContext_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Images', False);
  AData.AddProperty('MenuAnimation', TPopupMenu_MenuAnimation_si, TMenuAnimation_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OwnerDraw', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddProperty('TrackButton', TPopupMenu_TrackButton_si, TTrackButton_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnChange', False);
  AData.AddProperty('OnPopup', TPopupMenu_OnPopup_si, TNotifyEvent_sw, True, True, 0, False, False);
end;

class function TPopupMenu_sw.ToVar(const AValue: TPopupMenu): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPopupMenu_sw.FromVar(const AValue: OleVariant): TPopupMenu;
begin
  Result := TPopupMenu(ConvFromVar(AValue, TPopupMenu));
end;

class function TPopupMenu_sw.ClassToVar(AClass: TPopupMenu_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPopupMenu_sw.ClassFromVar(
  const AClass: OleVariant): TPopupMenu_sc;
begin
  Result := TPopupMenu_sc(ConvClsFromVar(AClass, TPopupMenu));
end;

{ TPopupList_sw }

function TPopupList_Window_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Window: HWND read <getter>;

  Result := HWND_sw.ToVar(TPopupList(AObj).Window);
end;

function TPopupList_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Add(Popup: TPopupMenu);

  TPopupList(AObj).Add(TPopupMenu_sw.FromVar(AArgs[0]));
end;

function TPopupList_Remove_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Remove(Popup: TPopupMenu);

  TPopupList(AObj).Remove(TPopupMenu_sw.FromVar(AArgs[0]));
end;

class function TPopupList_sw.GetTypeName: WideString;
begin
  Result := 'TPopupList';
end;

class function TPopupList_sw.GetWrappedClass: TClass;
begin
  Result := TPopupList;
end;

class procedure TPopupList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Window', TPopupList_Window_si, HWND_sw, True, False, 0, False, False);
  AData.AddProcedure('Add', TPopupList_Add_si, 1, False);
  AData.AddProcedure('Remove', TPopupList_Remove_si, 1, False);
end;

class function TPopupList_sw.ToVar(const AValue: TPopupList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPopupList_sw.FromVar(const AValue: OleVariant): TPopupList;
begin
  Result := TPopupList(ConvFromVar(AValue, TPopupList));
end;

class function TPopupList_sw.ClassToVar(AClass: TPopupList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPopupList_sw.ClassFromVar(
  const AClass: OleVariant): TPopupList_sc;
begin
  Result := TPopupList_sc(ConvClsFromVar(AClass, TPopupList));
end;

{ TMenuItemStack_sw }

function TMenuItemStack_ClearItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ClearItem(AItem: TMenuItem);

  TMenuItemStack(AObj).ClearItem(TMenuItem_sw.FromVar(AArgs[0]));
end;

class function TMenuItemStack_sw.GetTypeName: WideString;
begin
  Result := 'TMenuItemStack';
end;

class function TMenuItemStack_sw.GetWrappedClass: TClass;
begin
  Result := TMenuItemStack;
end;

class procedure TMenuItemStack_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('ClearItem', TMenuItemStack_ClearItem_si, 1, False);
end;

class function TMenuItemStack_sw.ToVar(
  const AValue: TMenuItemStack): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMenuItemStack_sw.FromVar(
  const AValue: OleVariant): TMenuItemStack;
begin
  Result := TMenuItemStack(ConvFromVar(AValue, TMenuItemStack));
end;

class function TMenuItemStack_sw.ClassToVar(
  AClass: TMenuItemStack_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMenuItemStack_sw.ClassFromVar(
  const AClass: OleVariant): TMenuItemStack_sc;
begin
  Result := TMenuItemStack_sc(ConvClsFromVar(AClass, TMenuItemStack));
end;

{ Menus_sw }

function Menus_EMenuError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EMenuError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EMenuError_sw);
end;

function Menus_TMenuBreak_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMenuBreak = (mbNone, mbBreak, mbBarBreak);

  Result := TLMDUnitWrapper.TypeToVar(TMenuBreak_sw);
end;

function Menus_TMenuChangeEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMenuChangeEvent = procedure (Sender: TObject; Sourc...

  Result := TLMDUnitWrapper.TypeToVar(TMenuChangeEvent_sw);
end;

function Menus_TMenuDrawItemEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMenuDrawItemEvent = procedure (Sender: TObject; ACa...

  Result := TLMDUnitWrapper.TypeToVar(TMenuDrawItemEvent_sw);
end;

function Menus_TMenuMeasureItemEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMenuMeasureItemEvent = procedure (Sender: TObject; ...

  Result := TLMDUnitWrapper.TypeToVar(TMenuMeasureItemEvent_sw);
end;

function Menus_TMenuItemAutoFlag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMenuItemAutoFlag = (maAutomatic, maManual, maParent);

  Result := TLMDUnitWrapper.TypeToVar(TMenuItemAutoFlag_sw);
end;

function Menus_TMenuAutoFlag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMenuAutoFlag = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TMenuAutoFlag_sw);
end;

function Menus_TMenuActionLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMenuActionLink = class(TActionLink);

  Result := TLMDUnitWrapper.TypeToVar(TMenuActionLink_sw);
end;

function Menus_TMenuActionLinkClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMenuActionLinkClass = class of TMenuActionLink;

  Result := TLMDUnitWrapper.TypeToVar(TMenuActionLinkClass_sw);
end;

function Menus_TMenuItemEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMenuItemEnumerator = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TMenuItemEnumerator_sw);
end;

function Menus_TMenuItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMenuItem = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TMenuItem_sw);
end;

function Menus_TFindItemKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindItemKind = (fkCommand, fkHandle, fkShortCut);

  Result := TLMDUnitWrapper.TypeToVar(TFindItemKind_sw);
end;

function Menus_TMenu_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type TMenu = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TMenu_sw);
end;

function Menus_TMainMenu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMainMenu = class(TMenu);

  Result := TLMDUnitWrapper.TypeToVar(TMainMenu_sw);
end;

function Menus_TPopupAlignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPopupAlignment = (paLeft, paRight, paCenter);

  Result := TLMDUnitWrapper.TypeToVar(TPopupAlignment_sw);
end;

function Menus_TTrackButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTrackButton = (tbRightButton, tbLeftButton);

  Result := TLMDUnitWrapper.TypeToVar(TTrackButton_sw);
end;

function Menus_TMenuAnimations_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMenuAnimations = (maLeftToRight, maRightToLeft, maT...

  Result := TLMDUnitWrapper.TypeToVar(TMenuAnimations_sw);
end;

function Menus_TMenuAnimation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMenuAnimation = set of TMenuAnimations;

  Result := TLMDUnitWrapper.TypeToVar(TMenuAnimation_sw);
end;

function Menus_TPopupMenu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPopupMenu = class(TMenu);

  Result := TLMDUnitWrapper.TypeToVar(TPopupMenu_sw);
end;

function Menus_TPopupList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPopupList = class(TList);

  Result := TLMDUnitWrapper.TypeToVar(TPopupList_sw);
end;

function Menus_TMenuItemStack_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMenuItemStack = class(TStack);

  Result := TLMDUnitWrapper.TypeToVar(TMenuItemStack_sw);
end;

function Menus_PopupList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var PopupList: TPopupList;

  if IsGet then
    Result := TPopupList_sw.ToVar(Menus.PopupList)
  else
    Menus.PopupList := TPopupList_sw.FromVar(AArgs[0]);
end;

function Menus_ShortCutItems_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ShortCutItems: TMenuItemStack;

  if IsGet then
    Result := TMenuItemStack_sw.ToVar(Menus.ShortCutItems)
  else
    Menus.ShortCutItems := TMenuItemStack_sw.FromVar(AArgs[0]);
end;

function Menus_ShortCutToText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ShortCutToText(ShortCut: TShortCut): string;

  Result := Menus.ShortCutToText(TShortCut_sw.FromVar(AArgs[0]));
end;

function Menus_TextToShortCut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TextToShortCut(Text: string): TShortCut;

  Result := TShortCut_sw.ToVar(Menus.TextToShortCut(string(AArgs[0])));
end;

function Menus_NewItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function NewItem(const ACaption: string; AShortCut: TShor...

  Result := TMenuItem_sw.ToVar(Menus.NewItem(string(AArgs[0]), TShortCut_sw.
    FromVar(AArgs[1]), Boolean(AArgs[2]), Boolean(AArgs[3]), TNotifyEvent_sw.
    FromVar(AArgs[4]), THelpContext_sw.FromVar(AArgs[5]), string(AArgs[6])));
end;

function Menus_NewLine_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function NewLine: TMenuItem;

  Result := TMenuItem_sw.ToVar(Menus.NewLine());
end;

function Menus_ValidMenuHotkeys_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ValidMenuHotkeys: string;

  if IsGet then
    Result := Menus.ValidMenuHotkeys
  else
    Menus.ValidMenuHotkeys := string(AArgs[0]);
end;

function Menus_cHotkeyPrefix_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cHotkeyPrefix = <value>;

  Result := cHotkeyPrefix;
end;

function Menus_cLineCaption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cLineCaption = <value>;

  Result := cLineCaption;
end;

function Menus_cDialogSuffix_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cDialogSuffix = <value>;

  Result := cDialogSuffix;
end;

function Menus_StripHotkey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function StripHotkey(const Text: string): string;

  Result := Menus.StripHotkey(string(AArgs[0]));
end;

function Menus_GetHotkey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetHotkey(const Text: string): string;

  Result := Menus.GetHotkey(string(AArgs[0]));
end;

function Menus_AnsiSameCaption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AnsiSameCaption(const Text1: string; const Text2...

  Result := Menus.AnsiSameCaption(string(AArgs[0]), string(AArgs[1]));
end;

function Menus_IsAltGRPressed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsAltGRPressed: boolean;

  Result := Menus.IsAltGRPressed();
end;

class function Menus_sw.GetUnitName: WideString;
begin
  Result := 'Menus';
end;

class procedure Menus_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(EMenuError_sw, Menus_EMenuError_si);
  AData.AddType(TMenuBreak_sw, Menus_TMenuBreak_si);
  AData.AddType(TMenuChangeEvent_sw, Menus_TMenuChangeEvent_si);
  AData.AddType(TMenuDrawItemEvent_sw, Menus_TMenuDrawItemEvent_si);
  AData.AddType(TMenuMeasureItemEvent_sw, Menus_TMenuMeasureItemEvent_si);
  AData.AddType(TMenuItemAutoFlag_sw, Menus_TMenuItemAutoFlag_si);
  AData.AddType(TMenuAutoFlag_sw, Menus_TMenuAutoFlag_si);
  AData.AddType(TMenuActionLink_sw, Menus_TMenuActionLink_si);
  AData.AddType(TMenuActionLinkClass_sw, Menus_TMenuActionLinkClass_si);
  AData.AddType(TMenuItemEnumerator_sw, Menus_TMenuItemEnumerator_si);
  AData.AddType(TMenuItem_sw, Menus_TMenuItem_si);
  AData.AddType(TFindItemKind_sw, Menus_TFindItemKind_si);
  AData.AddType(TMenu_sw, Menus_TMenu_si);
  AData.AddType(TMainMenu_sw, Menus_TMainMenu_si);
  AData.AddType(TPopupAlignment_sw, Menus_TPopupAlignment_si);
  AData.AddType(TTrackButton_sw, Menus_TTrackButton_si);
  AData.AddType(TMenuAnimations_sw, Menus_TMenuAnimations_si);
  AData.AddType(TMenuAnimation_sw, Menus_TMenuAnimation_si);
  AData.AddType(TPopupMenu_sw, Menus_TPopupMenu_si);
  AData.AddType(TPopupList_sw, Menus_TPopupList_si);
  AData.AddType(TMenuItemStack_sw, Menus_TMenuItemStack_si);
  AData.AddVariable('PopupList', Menus_PopupList_si, TPopupList_sw);
  AData.AddVariable('ShortCutItems', Menus_ShortCutItems_si, TMenuItemStack_sw);
  AData.AddFunction('ShortCutToText', Menus_ShortCutToText_si, string_sw, 1, False);
  AData.AddFunction('TextToShortCut', Menus_TextToShortCut_si, TShortCut_sw, 1, False);
  AData.AddFunction('NewItem', Menus_NewItem_si, TMenuItem_sw, 7, False);
  AData.AddFunction('NewLine', Menus_NewLine_si, TMenuItem_sw, 0, False);
  AData.AddVariable('ValidMenuHotkeys', Menus_ValidMenuHotkeys_si, string_sw);
  AData.AddConstant('cHotkeyPrefix', Menus_cHotkeyPrefix_si, nil, VarType(Menus.cHotkeyPrefix));
  AData.AddConstant('cLineCaption', Menus_cLineCaption_si, nil, VarType(Menus.cLineCaption));
  AData.AddConstant('cDialogSuffix', Menus_cDialogSuffix_si, nil, VarType(Menus.cDialogSuffix));
  AData.AddFunction('StripHotkey', Menus_StripHotkey_si, string_sw, 1, False);
  AData.AddFunction('GetHotkey', Menus_GetHotkey_si, string_sw, 1, False);
  AData.AddFunction('AnsiSameCaption', Menus_AnsiSameCaption_si, Boolean_sw, 2, False);
  AData.AddFunction('IsAltGRPressed', Menus_IsAltGRPressed_si, boolean_sw, 0, False);
end;

class function Menus_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Menus_sw);
end;

initialization
  RegisterUnitWrapper(Menus_sw);
  RegisterClassWrapper(EMenuError_sw);
  RegisterClassWrapper(TMenuActionLink_sw);
  RegisterClassWrapper(TMenuItemEnumerator_sw);
  RegisterClassWrapper(TMenuItem_sw);
  RegisterClassWrapper(TMenu_sw);
  RegisterClassWrapper(TMainMenu_sw);
  RegisterClassWrapper(TPopupMenu_sw);
  RegisterClassWrapper(TPopupList_sw);
  RegisterClassWrapper(TMenuItemStack_sw);
  RegisterEventWrapper(TypeInfo(TMenuChangeEvent), TMenuChangeEvent_sw);
  RegisterEventWrapper(TypeInfo(TMenuDrawItemEvent), TMenuDrawItemEvent_sw);
  RegisterEventWrapper(TypeInfo(TMenuMeasureItemEvent), TMenuMeasureItemEvent_sw);

end.
