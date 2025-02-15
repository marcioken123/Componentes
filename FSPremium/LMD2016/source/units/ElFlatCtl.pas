unit ElFlatCtl;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
� by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

ElFlatCtl unit
--------------

ToDo
----
CM_CONTROLLISTCHANGE isn't exists in VCL.NET - we need to find way to
workaround it

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls, Forms, Types,
  StdCtrls, TypInfo,
  ElVCLUtils, ElStyleMan, ElComponent,   ElHook,
  LMDGraph, LMDSysIn, Themes, LMDThemes,LMDClass;

type

  TElFlatController = class(TElComponent)
  private
    FActiveBorderType : TElFlatBorderType;
    FInactiveBorderType : TElFlatBorderType;
    FHook : TElHook;
    FMouseOver : boolean;
    FFlatFocusedScrollbars : Boolean;
    FBorderSides: TLMDBorderSides;

    FStyleMgrLink : TElStyleMgrChangeLink;
    FStyleManager: TElStyleManager;
    FStyleName: string;

    FThemeGlobalMode: Boolean;

    procedure SetFlatFocusedScrollbars(newValue : Boolean);
    procedure HookAfterProcessHandler(Sender : TObject; var Msg : TMessage; var Handled : Boolean); { TElHookEvent }
    procedure SetActive(newValue : Boolean);
    function GetActive : Boolean;
    procedure SetControl(newValue : TWinControl);
    function GetControl : TWinControl;
    procedure SetDesignActive(newValue : Boolean);
    function GetDesignActive : Boolean;
    procedure SetActiveBorderType(newValue : TElFlatBorderType);
    procedure SetInactiveBorderType(newValue : TElFlatBorderType);
    procedure SetBorderSides(Value: TLMDBorderSides);
    procedure HookBeforeProcessHandler(Sender : TObject; var Msg : TMessage; var
        Handled : Boolean);

    function GetUseXPThemes: Boolean;
    procedure ReadUseXPThemes(Reader: TReader);

  protected
    FLineBorderActiveColor: TColor;
    FLineBorderInactiveColor: TColor;

    FBorderColorDkShadow: TColor;
    FBorderColorFace: TColor;
    FBorderColorHighlight: TColor;
    FBorderColorShadow: TColor;
    FBorderColorWindow: TColor;

    FThemeMode : TLMDThemeMode;
    FPreventStyleChange :Boolean;

    procedure DefineProperties(Filer:TFiler);override;
    procedure SetThemeGlobalMode(const Value: Boolean);virtual;
    procedure SetThemeMode(const Value: TLMDThemeMode);virtual;
    procedure SetUseXPThemes(const Value: Boolean);virtual;

    procedure DoThemeChanged; virtual;
    function UseThemeMode: TLMDThemeMode;
    procedure UpdateStyle;
    //new V9
    procedure SetStyleManager(Value: TElStyleManager); virtual;
    procedure SetStyleName(const Value: string); virtual;
    procedure StyleMgrChange(Sender : TObject);

    procedure SetLineBorderActiveColor(Value: TColor);
    procedure SetLineBorderInactiveColor(Value: TColor);
    function IsControlThemed(Control : TControl): Boolean;

    procedure Loaded; override;
    procedure DoNCPaint;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetBorderColorDkShadow(Value: TColor);
    procedure SetBorderColorFace(Value: TColor);
    procedure SetBorderColorHighlight(Value: TColor);
    procedure SetBorderColorShadow(Value: TColor);
    procedure SetBorderColorWindow(Value: TColor);
    { Protected declarations }
  public
    { Public declarations }
    procedure DrawFlatBorder;
    procedure UpdateFrame;
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function IsThemed: Boolean; // any other than ttmNone  -> Use LMDThemeServices
    property UseXPThemes: Boolean read GetUseXPThemes write SetUseXPThemes;
  published
    { Published properties and events }
    property FlatFocusedScrollbars : Boolean read FFlatFocusedScrollbars write SetFlatFocusedScrollbars; { Published }
    property Active : Boolean read GetActive write SetActive;
    property Control : TWinControl read GetControl write SetControl;
    property DesignActive : Boolean read GetDesignActive write SetDesignActive default true;
    property ActiveBorderType : TElFlatBorderType read FActiveBorderType write SetActiveBorderType default fbtSunken;  { Published }
    property InactiveBorderType : TElFlatBorderType read FInactiveBorderType write SetInactiveBorderType default fbtSunkenOuter;  { Published }
    property BorderSides: TLMDBorderSides read FBorderSides write SetBorderSides;
    property BorderColorDkShadow: TColor read FBorderColorDkShadow write
        SetBorderColorDkShadow default cl3DDkShadow;
    property BorderColorFace: TColor read FBorderColorFace write SetBorderColorFace
        default clBtnFace;
    property BorderColorHighlight: TColor read FBorderColorHighlight write
        SetBorderColorHighlight default clBtnHighlight;
    property BorderColorShadow: TColor read FBorderColorShadow write
        SetBorderColorShadow default clBtnShadow;
    property LineBorderActiveColor: TColor read FLineBorderActiveColor write
        SetLineBorderActiveColor;
    property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
        SetLineBorderInactiveColor;

    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
    property BorderColorWindow: TColor read FBorderColorWindow write
        SetBorderColorWindow default clWindow;

    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;

  end; { TElFlatController }

  TElFlatEntry = class(TCollectionItem)
  private
    FController : TElFlatController;
    FDesignActive : Boolean;
    FControl : TWinControl;
    FActive : Boolean;
    FFlatFocusedScrollbars : Boolean;
    function GetActive : Boolean;
    procedure SetActive(newValue : Boolean);
    function GetFlatFocusedScrollbars : Boolean;
    procedure SetFlatFocusedScrollbars(newValue : Boolean);
    function GetDesignActive : Boolean;
    procedure SetDesignActive(newValue : Boolean);
    procedure SetControl(newValue : TWinControl);
    function GetActiveBorderType : TElFlatBorderType;
    procedure SetActiveBorderType(newValue : TElFlatBorderType);
    function GetInactiveBorderType : TElFlatBorderType;
    procedure SetInactiveBorderType(newValue : TElFlatBorderType);
  protected
    FLineBorderActiveColor: TColor;
    FLineBorderInactiveColor: TColor;
    FBorderSides: TLMDBorderSides;
    procedure SetLineBorderActiveColor(Value: TColor);
    procedure SetLineBorderInactiveColor(Value: TColor);
    procedure SetBorderSides(Value: TLMDBorderSides);
    function GetUseXPThemes: Boolean;
    procedure SetUseXPThemes(Value: Boolean);
  public
    procedure Assign(Source : TPersistent); override;

    constructor Create(Collection : TCollection); override;
    destructor Destroy; override;
  published
    property Active : Boolean read GetActive write SetActive; { Published }
    property BorderSides: TLMDBorderSides read FBorderSides write SetBorderSides;
    property FlatFocusedScrollbars : Boolean read GetFlatFocusedScrollbars write SetFlatFocusedScrollbars; { Published }
    property DesignActive : Boolean read GetDesignActive write SetDesignActive; { Published }
    property Control: TWinControl read FControl write SetControl; { Published }
    property ActiveBorderType : TElFlatBorderType read GetActiveBorderType write SetActiveBorderType;  { Published }
    property InactiveBorderType : TElFlatBorderType read GetInactiveBorderType write SetInactiveBorderType;  { Published }
    property LineBorderActiveColor: TColor read FLineBorderActiveColor write
        SetLineBorderActiveColor;
    property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
        SetLineBorderInactiveColor;
    property UseXPThemes: Boolean read GetUseXPThemes write SetUseXPThemes;
  end;

  TElFlatMultiController = class;

  TElFlatEntries = class(TCollection)
  private
    FController : TElFlatMultiController;
    function GetEntries(index : integer) : TElFlatEntry;
    procedure SetEntries(index : integer; newValue : TElFlatEntry);
    public
    function GetOwner : TPersistent; override;
    function Add : TElFlatEntry;
    property Entries[index : integer] : TElFlatEntry read GetEntries write SetEntries; default;
  end;

  TElFlatMultiController = class(TElComponent)
  private
    FActiveBorderType : TElFlatBorderType;
    FInactiveBorderType : TElFlatBorderType;
    FFlatFocusedScrollbars : Boolean;
    FAutoAddControls : Boolean;
    FHook : TElHook;
    FEntries : TElFlatEntries;
    FBorderSides: TLMDBorderSides;
    FStyleManager: TElStyleManager;
    FStyleName: string;

    procedure CMControlListChange(var Msg : TMessage); message CM_CONTROLLISTCHANGE;

    procedure SetEntries(newValue : TElFlatEntries);
    procedure SetActive(newValue : Boolean);
    function GetActive : Boolean;
    procedure SetDesignActive(newValue : Boolean);
    function GetDesignActive : Boolean;
    procedure AfterProcessHandler(Sender : TObject; var Msg : TMessage; var Handled : Boolean); { TElHookEvent }
    procedure SetAutoAddControls(newValue : Boolean);
    procedure ScanForm;
    procedure SetFlatFocusedScrollbars(newValue : Boolean);
    procedure SetActiveBorderType(newValue : TElFlatBorderType);
    procedure SetInactiveBorderType(newValue : TElFlatBorderType);
    procedure SetBorderSides(Value: TLMDBorderSides);
  protected
    FLineBorderActiveColor: TColor;
    FLineBorderInactiveColor: TColor;
    FUseXPThemes: Boolean;
    procedure SetStyleManager(Value: TElStyleManager); virtual;
    procedure SetStyleName(const Value: string); virtual;
    procedure SetLineBorderActiveColor(Value: TColor);
    procedure SetLineBorderInactiveColor(Value: TColor);
    procedure Loaded; override;
    procedure SetUseXPThemes(Value: Boolean);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property Entries : TElFlatEntries read FEntries write SetEntries; { Published }
    property Active : Boolean read GetActive write SetActive default true;
    property DesignActive : Boolean read GetDesignActive write SetDesignActive default true;
    property AutoAddControls : Boolean read FAutoAddControls write SetAutoAddControls default true; { Published }
    property FlatFocusedScrollbars : Boolean read FFlatFocusedScrollbars write SetFlatFocusedScrollbars; { Published }
    property ActiveBorderType : TElFlatBorderType read FActiveBorderType write SetActiveBorderType default fbtSunken;  { Published }
    property InactiveBorderType : TElFlatBorderType read FInactiveBorderType write SetInactiveBorderType default fbtSunkenOuter;  { Published }
    property LineBorderActiveColor: TColor read FLineBorderActiveColor write
        SetLineBorderActiveColor;
    property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
        SetLineBorderInactiveColor;
    property BorderSides: TLMDBorderSides read FBorderSides write SetBorderSides;
    property UseXPThemes: Boolean read FUseXPThemes write SetUseXPThemes default
        true;
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
  end;

implementation

uses Grids;

destructor TElFlatMultiController.Destroy;
begin
  StyleManager := nil;
  FreeAndNil(FHook);
  FreeAndNil(FEntries);
  inherited;
end;

constructor TElFlatMultiController.Create(AOwner : TComponent);
begin
  inherited;
  FHook := TElHook.Create(Self);
  FHook.OnAfterProcess := AfterProcessHandler;
  FHook.Control := GetTopOwnerControl(Self);
  FEntries := TElFlatEntries.Create(TElFlatEntry);
  FEntries.FController := Self;
  FAutoAddControls := true;
  FActiveBorderType := fbtSunken;
  FInactiveBorderType := fbtSunkenOuter;
  FUseXPThemes := true;
  DesignActive := true;
  Active := true;
  ScanForm;
end; { Create }

function TElFlatEntries.GetEntries;
{ Returns the value of data member FEntries. }
begin
  result := TElFlatEntry(GetItem(index));
end; { GetEntries }

procedure TElFlatEntries.SetEntries;
{ Sets data member FEntries to newValue. }
begin
  inherited SetItem(Index, newValue);
end; { SetEntries }

function TElFlatEntries.GetOwner : TPersistent; { public }
begin
  result := FController;
end; { GetOwner }

function TElFlatEntries.Add : TElFlatEntry; { public }
begin
  result := TElFlatEntry(inherited Add);
end; { Add }

procedure TElFlatMultiController.SetEntries(newValue : TElFlatEntries);
begin
  if newValue <> FEntries then FEntries.Assign(newValue);
end;

procedure TElFlatMultiController.ScanForm;

  procedure IntScanControl(AControl : TWinControl; Entries : TElFlatEntries);
  var
    i, j : integer;
    C : TWinControl;
    X : TElFlatEntry;
    b : boolean;
  begin
    for i := 0 to AControl.ControlCount - 1 do // Iterate
    begin
      if AControl.Controls[i] is TWinControl then
      begin
        C := TWinControl(AControl.Controls[i]);
        b := false;
        for j := 0 to Entries.Count - 1 do // Iterate
        begin
          if Entries.Entries[j].Control = AControl.Controls[i] then
          begin
            b := true;
            break;
          end;
        end; // for
        if not b then
        begin
          X := Entries.Add;
          X.SetControl(C);
          X.Active := true;
          X.DesignActive := true;
          X.FFlatFocusedScrollbars := Self.FFlatFocusedScrollbars;
          X.ActiveBorderType := FActiveBorderType;
          X.InactiveBorderType := FInactiveBorderType;
          X.LineBorderActiveColor := FLineBorderActiveColor;
          X.LineBorderInactiveColor := FLineBorderInactiveColor;
        end;
        if C.ControlCount > 0 then IntScanControl(C, Entries);
      end;
    end; // for
  end;

begin
  IntScanControl(TWinControl(FHook.Control), Entries);
end;

procedure TElFlatMultiController.CMControlListChange(var Msg : TMessage); { private }

var
  i : integer;
  C : TWinControl;
  X : TElFlatEntry;
begin
  if (csDesigning in ComponentState) and (ComponentState * [csLoading, csReading, csDestroying] = []) then
  begin
    if (boolean(Msg.lParam) = true) and (TControl(Msg.wParam) is TWinControl) and (FAutoAddControls) then // add a control
    begin
      for i := 0 to Entries.Count - 1 do // Iterate
      begin
        if Entries.Entries[i].Control = TWinControl(Msg.wParam) then exit;
        end; // for
      X := Entries.Add;
      X.SetControl(TWinControl(Msg.wParam));
      X.Active := Active;
      X.DesignActive := DesignActive;
      X.FFlatFocusedScrollbars := Self.FFlatFocusedScrollbars;
      X.ActiveBorderType := FActiveBorderType;
      X.InactiveBorderType := FInactiveBorderType;
      X.FLineBorderActiveColor := FLineBorderActiveColor;
      X.FLineBorderInactiveColor := FLineBorderInactiveColor;
    end
    else
    if (boolean(Msg.lParam) = false) and (TControl(Msg.wParam) is TWinControl) then
    begin
      C := TWinControl(Msg.wParam);
      i := 0;
      while i < Entries.Count do
      begin
        if Entries[i].Control = C then
        begin
          Entries[i].Active := false;
          Entries[i].Free;
        end
        else
        inc(i);
      end; // for
    end;
  end;
end; { CMControlListChange }

{ Exposed properties' Read/Write methods: }

procedure TElFlatMultiController.SetActive(newValue : Boolean);
{ Sets the FHook subcomponent's Active property to newValue. }
begin
  FHook.Active := newValue;
end; { SetActive }

function TElFlatMultiController.GetActive : Boolean;
{ Returns the Active property from the FHook subcomponent. }
begin
  GetActive := FHook.Active;
end; { GetActive }

procedure TElFlatMultiController.SetDesignActive(newValue : Boolean);
{ Sets the FHook subcomponent's DesignActive property to newValue. }
begin
  FHook.DesignActive := newValue;
end; { SetDesignActive }

function TElFlatMultiController.GetDesignActive : Boolean;
{ Returns the DesignActive property from the FHook subcomponent. }
begin
  GetDesignActive := FHook.DesignActive;
end; { GetDesignActive }

procedure TElFlatMultiController.AfterProcessHandler(Sender : TObject; var Msg : TMessage; var Handled : Boolean);
{ Handles the FHook OnAfterProcess event. }
begin

  if Msg.Msg = CM_CONTROLLISTCHANGE then
    CMControlListChange(Msg);

end; { AfterProcessHandler }

procedure TElFlatMultiController.SetAutoAddControls(newValue : Boolean);
{ Sets data member FAutoAddControls to newValue. }
begin
  if (FAutoAddControls <> newValue) then
  begin
    FAutoAddControls := newValue;
  end; { if }
end; { SetAutoAddControls }

procedure TElFlatMultiController.SetFlatFocusedScrollbars(newValue : Boolean);
var i : integer;
begin
  if (FFlatFocusedScrollbars <> newValue) then
  begin
    FFlatFocusedScrollbars := newValue;
    if ComponentState * [csLoading, csReading, csDestroying] = [] then
      for i := 0 to Self.FEntries.Count - 1 do    { Iterate }
        FEntries[i].FlatFocusedScrollbars := newValue;
  end; { if }
end; { SetFlatFocusedScrollbars }

procedure TElFlatMultiController.SetActiveBorderType(newValue : TElFlatBorderType);
var i : integer;
begin
  if (FActiveBorderType <> newValue) then
  begin
    FActiveBorderType := newValue;
    if ComponentState * [csLoading, csReading, csDestroying] = [] then
      for i := 0 to Self.FEntries.Count - 1 do    { Iterate }
        FEntries[i].ActiveBorderType := newValue;
  end;  { if }
end;  { SetActiveBorderType }

procedure TElFlatMultiController.SetInactiveBorderType(newValue : TElFlatBorderType);
var i : integer;
begin
  if (FInactiveBorderType <> newValue) then
  begin
    FInactiveBorderType := newValue;
    if ComponentState * [csLoading, csReading, csDestroying] = [] then
      for i := 0 to Self.FEntries.Count - 1 do    { Iterate }
        FEntries[i].InactiveBorderType := newValue;
  end;  { if }
end;  { SetInactiveBorderType }

procedure TElFlatMultiController.SetLineBorderActiveColor(Value: TColor);
var i : integer;
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;
    if ComponentState * [csLoading, csReading, csDestroying] = [] then
      for i := 0 to Self.FEntries.Count - 1 do    { Iterate }
        FEntries[i].LineBorderActiveColor := Value;
  end;
end;

procedure TElFlatMultiController.SetLineBorderInactiveColor(Value: TColor);
var i : integer;
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;
    if ComponentState * [csLoading, csReading, csDestroying] = [] then
      for i := 0 to Self.FEntries.Count - 1 do    { Iterate }
        FEntries[i].LineBorderInactiveColor := Value;
  end;
end;

procedure TElFlatMultiController.SetBorderSides(Value: TLMDBorderSides);
var i : integer;
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if ComponentState * [csLoading, csReading, csDestroying] = [] then
      for i := 0 to Self.FEntries.Count - 1 do    { Iterate }
        FEntries[i].BorderSides := Value;
  end;
end;

procedure TElFlatMultiController.Loaded;
var i : integer;
begin
  inherited;
  for i := 0 to Entries.Count -1 do
  begin
    FEntries[i].BorderSides := BorderSides;
    FEntries[i].LineBorderInactiveColor := LineBorderInactiveColor;
    FEntries[i].LineBorderActiveColor := LineBorderActiveColor;
    FEntries[i].InactiveBorderType := InactiveBorderType;
    FEntries[i].ActiveBorderType := ActiveBorderType;
    FEntries[i].FlatFocusedScrollBars := FlatFocusedScrollBars;
    FEntries[i].UseXPThemes := UseXPThemes;
  end;
end;

procedure TElFlatMultiController.SetUseXPThemes(Value: Boolean);
var i : integer;
begin
  if FUseXPThemes <> Value then
  begin
    FUseXPThemes := Value;
    if ComponentState * [csLoading, csReading, csDestroying] = [] then
      for i := 0 to Self.FEntries.Count - 1 do    { Iterate }
        FEntries[i].UseXPThemes := Value;
  end;
end;

procedure TElFlatMultiController.Notification(AComponent: TComponent;
    Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FStyleManager) then
     StyleManager := nil;
end; { Notification }

procedure TElFlatMultiController.SetStyleManager(Value: TElStyleManager);
var i : integer;
begin
  if FStyleManager <> Value then
  begin
    if (FStyleManager <> nil) and (not (csDestroying in FStyleManager.ComponentState)) then
      FStyleManager.RemoveFreeNotification(Self);
    FStyleManager := Value;
    if FStyleManager <> nil then
      FStyleManager.FreeNotification(Self);

    for i := 0 to Entries.Count - 1 do
      Entries[i].FController.StyleManager := Value;
  end;
end;

procedure TElFlatMultiController.SetStyleName(const Value: string);
var i : integer;
begin
  if FStyleName <> Value then
  begin
    for i := 0 to Entries.Count - 1 do
      Entries[i].FController.StyleName := Value;
  end;
end;

function TElFlatEntry.GetActive : Boolean;
{ Returns the value of data member FActive. }
begin
  result := FActive;
end; { GetActive }

procedure TElFlatEntry.SetActive(newValue : Boolean);
{ Sets data member FActive to newValue. }
begin
  if (FActive <> newValue) then
  begin
    FActive := newValue;
    FController.Active := newValue;
  end; { if }
end; { SetActive }

function TElFlatEntry.GetFlatFocusedScrollbars : Boolean;
{ Returns the value of data member FFlatFocusedScrollbars. }
begin
  result := FFlatFocusedScrollbars;
end; { GetFlatFocusedScrollbars }

procedure TElFlatEntry.SetFlatFocusedScrollbars(newValue : Boolean);
{ Sets data member FFlatFocusedScrollbars to newValue. }
begin
  if (FFlatFocusedScrollbars <> newValue) then
  begin
    FFlatFocusedScrollbars := newValue;
    FController.SetFlatFocusedScrollbars(newValue);
    FFlatFocusedScrollbars := FController.FlatFocusedScrollbars;
  end; { if }
end; { SetFlatFocusedScrollbars }

function TElFlatEntry.GetDesignActive : Boolean;
{ Returns the value of data member FDesignActive. }
begin
  result := FDesignActive;
end; { GetDesignActive }

procedure TElFlatEntry.SetDesignActive(newValue : Boolean);
{ Sets data member FDesignActive to newValue. }
begin
  if (FDesignActive <> newValue) then
  begin
    FDesignActive := newValue;
    FController.DesignActive := newValue;
  end; { if }
end; { SetDesignActive }

procedure TElFlatEntry.SetControl;
begin
  if FControl <> newValue then
  begin
    FController.Control := newValue;
    FControl := newValue;
  end;
end;

constructor TElFlatEntry.Create(Collection : TCollection); { public }
begin
  inherited;
  FController := TElFlatController.Create(nil);
end; { Create }

destructor TElFlatEntry.Destroy; { public }
begin
  FController.Free;
  inherited;
end; { Destroy }

procedure TElFlatEntry.Assign(Source : TPersistent); { protected }
begin
  if Source is TElFlatEntry then
  begin
    FController.Assign(TElFlatEntry(Source).FController);
    FFlatFocusedScrollbars := TElFlatEntry(Source).FlatFocusedScrollbars;
    FDesignActive := TElFlatEntry(Source).DesignActive;
    FActive := TElFlatEntry(Source).Active;
  end
  else
    inherited;
end; { Assign }

function TElFlatEntry.GetActiveBorderType : TElFlatBorderType;
{ Returns the value of data member FActiveBorderType. }
begin
  result := FController.ActiveBorderType;
end;  { GetActiveBorderType }

procedure TElFlatEntry.SetActiveBorderType(newValue : TElFlatBorderType);
{ Sets data member FActiveBorderType to newValue. }
begin
  FController.ActiveBorderType := newValue;
end;  { SetActiveBorderType }

function TElFlatEntry.GetInactiveBorderType : TElFlatBorderType;
{ Returns the value of data member FInactiveBorderType. }
begin
  result := FController.FInactiveBorderType;
end;  { GetInactiveBorderType }

procedure TElFlatEntry.SetInactiveBorderType(newValue : TElFlatBorderType);
{ Sets data member FInactiveBorderType to newValue. }
begin
  FController.InactiveBorderType := newValue;
end;  { SetInactiveBorderType }

procedure TElFlatEntry.SetLineBorderActiveColor(Value: TColor);
begin
  FLineBorderActiveColor := Value;
  FController.FLineBorderActiveColor := Value;
end;

procedure TElFlatEntry.SetLineBorderInactiveColor(Value: TColor);
begin
  FLineBorderInactiveColor := Value;
  FController.FLineBorderInactiveColor := Value;
end;

procedure TElFlatEntry.SetBorderSides(Value: TLMDBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
  end;
end;

function TElFlatEntry.GetUseXPThemes: Boolean;
begin
  Result := FController.UseXPThemes;
end;

procedure TElFlatEntry.SetUseXPThemes(Value: Boolean);
begin
  FController.UseXPThemes := Value;
end;

procedure TElFlatController.SetFlatFocusedScrollbars(newValue : Boolean);
{ Sets data member FFlatFocusedScrollbars to newValue. }
begin
  if (FFlatFocusedScrollbars <> newValue) then
  begin
    if newValue then
    begin
      if (Control <> nil) and (Control is TCustomGrid) then exit;
    end;
    FFlatFocusedScrollbars := newValue;
    if Active then UpdateFrame;
  end; { if }
end; { SetFlatFocusedScrollbars }

procedure TElFlatController.UpdateFrame; { protected }
var
  R   : TRect;
  WF  : DWORD;
  WFE : DWORD;
begin
  if Control = nil then exit;
  if Control.HandleAllocated then
  begin
    WF := GetWindowLong(Control.Handle, GWL_STYLE);
    WFE := GetWindowLong(Control.Handle, GWL_EXSTYLE);
    if (Control is TCustomComboBox) or
       (WF and (WS_BORDER or WS_THICKFRAME) > 0) or ((WFE and WS_EX_CLIENTEDGE) > 0) then
    begin
      R := Rect(0, 0, Control.Width, Control.Height);
      RedrawWindow(TWinControl(Control).Handle, @R, 0, rdw_Invalidate or rdw_UpdateNow or rdw_Frame);
    end;
  end;
end; { UpdateFrame }

type
  TElHackControl = class(TWinControl)
    property Color;
    end;

procedure TElFlatController.DrawFlatBorder;
var
  DC : HDC;
  R  : TRect;
  WF : DWORD;
  WFE : DWORD;
  BS  : TElFlatBorderType;
  b : boolean;
  AColor : TColor;
  ARgn,
  CRgn   : HRGN;

begin
  if IsThemed and
     ((GetWindowLong(TWinControl(Control).Handle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE) = WS_EX_CLIENTEDGE) then
  begin
    ARgn := CreateRectRgnIndirect(R);
    R := TWinControl(Control).ClientRect;
    CRgn := CreateRectRgnIndirect(R);
    CombineRgn(ARgn, ARgn, CRgn, RGN_DIFF);
    RedrawWindow(TWinControl(Control).Handle, nil, ARgn, RDW_INVALIDATE or RDW_FRAME {or RDW_UPDATENOW or RDW_NOERASE});
    DeleteObject(ARgn);
    DeleteObject(CRgn);
    exit;
  end;

  GetWindowRect(Control.Handle, R);  //get the TRect of the control
  OffsetRect(R, -R.Left, -R.Top);  //offset the control as needed

  DC := GetWindowDC(Control.Handle);
  try
    WF := GetWindowLong(Control.Handle, GWL_STYLE);
    WFE := GetWindowLong(Control.Handle, GWL_EXSTYLE);
    if (Control is TCustomComboBox) or
       (WF and (WS_BORDER or WS_THICKFRAME) > 0) or ((WFE and WS_EX_CLIENTEDGE) > 0) then
    begin
      b := Control.Focused or FMouseOver;
      if b then
        BS := FActiveBorderType
      else
        BS := FInactiveBorderType;
      if b then
        AColor := LineBorderActiveColor
      else
        AColor := LineBorderInactiveColor;

      DrawFlatFrameEx2(DC, R, AColor, TElHackControl(Control).Color, b, Control.Enabled, FBorderSides, BS, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
    end;
    DrawFlatScrollbars(Control.Handle, DC, R,
        {Control.Brush.Color,} (Control.Focused or FMouseOver) and (not FlatFocusedScrollBars),
        ssBoth, false, false, false, GetWindowLong(Control.Handle, GWL_STYLE), GetWindowLong(Control.Handle, GWL_EXSTYLE));
  finally
    ReleaseDC(Control.Handle, DC);
  end;
end;

procedure TElFlatController.HookAfterProcessHandler(Sender : TObject; var Msg : TMessage; var Handled : Boolean);

begin
  case Msg.Msg of
    //WM_CREATE:
    //  if (Control<>nil) and (Control is TWinControl) and UseXPThemes and XPThemesAvailable then
    //    C.reateThemeHandle;
    WM_NCCALCSIZE:
      begin
        if not (ebsLeft in BorderSides) then
          dec(TWMNCCalcSize(Msg).CalcSize_Params.rgrc[0].Left, GetSystemMetrics(SM_CYEDGE));
        if not (ebsTop in BorderSides) then
          dec(TWMNCCalcSize(Msg).CalcSize_Params.rgrc[0].Top, GetSystemMetrics(SM_CXEDGE));
        if not (ebsRight in BorderSides) then
          Inc(TWMNCCalcSize(Msg).CalcSize_Params.rgrc[0].Right, GetSystemMetrics(SM_CYEDGE));
        if not (ebsBottom in BorderSides) then
          Inc(TWMNCCalcSize(Msg).CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(SM_CXEDGE));
        end;
    WM_NCHITTEST,
    CM_MOUSEENTER :
      begin
        FMouseOver := true;
        if Active and ((FInactiveBorderType <> FActiveBorderType) and
           (not control.Focused) or LMDThemeServices.ThemesEnabled) then
          DrawFlatBorder;
      end;
    WM_MOUSELEAVE :
      begin
        FMouseOver := false;
        if Active and ((FInactiveBorderType <> FActiveBorderType) and
           (not control.Focused) or LMDThemeServices.ThemesEnabled) then
             DrawFlatBorder;
      end;
    WM_SIZE,
    WM_SETFOCUS,
      WM_KILLFOCUS :
      if (Active and (FInactiveBorderType <> FActiveBorderType)) then
        UpdateFrame;
    CM_EXIT:
      if (Control is TCustomComboBox) then
        UpdateFrame;
    WM_NCPAINT:
      DoNCPaint;
    WM_PAINT,
    WM_VSCROLL,
    WM_HSCROLL :
      DrawFlatBorder;
  end;
end; { HookAfterProcessHandler }

{ Exposed properties' Read/Write methods: }

procedure TElFlatController.SetActive(newValue : Boolean);
begin
  FHook.Active := newValue;
  if newValue then
    UpdateFrame
  else
  if (Control <> nil) and Control.HandleAllocated then
  begin
    SetWindowPos(Control.Handle, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER or SWP_DRAWFRAME);
    Control.Invalidate;
  end;
end; { SetActive }

function TElFlatController.GetActive : Boolean;
{ Returns the Active property from the FHook subcomponent. }
begin
  GetActive := FHook.Active;
end; { GetActive }

procedure TElFlatController.SetControl(newValue: TWinControl);
var
  b: boolean;
  ASides: TLMDBorderSides;
begin
  if newValue = nil then
  begin
    if FHook.Control <> nil then Active := false;
  end;
  b := Active;
  Active := false;
  UpdateFrame;
  FHook.Control := newValue;
  if IsControlThemed(newValue) then exit;
  Active := b;
  if UseXPThemes then exit;
  if (newValue <> nil) and Active then
  begin
    ASides := FBorderSides;
    if ASides <> [] then
      FBorderSides := []
    else
      FBorderSides := AllBorderSides;
    SetBorderSides(ASides);
  end;
end; { SetControl }

function TElFlatController.GetControl : TWinControl;
{ Returns the Control property from the FHook subcomponent. }
begin
  GetControl := FHook.Control as TWinControl;
end; { GetControl }

procedure TElFlatController.SetDesignActive(newValue : Boolean);
begin
  FHook.DesignActive := newValue;
  if (Control <> nil) and (csDesigning in ComponentState) then
  begin
    SetWindowPos(Control.Handle, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER or SWP_DRAWFRAME);
    Control.Invalidate;
  end;
end; { SetDesignActive }

function TElFlatController.GetDesignActive : Boolean;
{ Returns the DesignActive property from the FHook subcomponent. }
begin
  GetDesignActive := FHook.DesignActive;
end; { GetDesignActive }

procedure TElFlatController.SetActiveBorderType(newValue : TElFlatBorderType);
{ Sets data member FActiveBorderType to newValue. }
begin
  if (FActiveBorderType <> newValue) then
  begin
    FActiveBorderType := newValue;
    if Active and (Control <> nil) and (Control.Focused or FMouseOver) then UpdateFrame;
  end;  { if }
end;  { SetActiveBorderType }

procedure TElFlatController.SetInactiveBorderType(newValue : TElFlatBorderType);
{ Sets data member FInactiveBorderType to newValue. }
begin
  if (FInactiveBorderType <> newValue) then
  begin
    FInactiveBorderType := newValue;
    if Active and (Control <> nil) and (not (Control.Focused or FMouseOver)) then UpdateFrame;
  end;  { if }
end;  { SetInactiveBorderType }

destructor TElFlatController.Destroy;
begin
  Destroying;
  SetActive(False);
  Control := nil;
  // MessageBox(0, '1', nil, 0);
  StyleManager := nil;
  // MessageBox(0, '2', nil, 0);
  FreeAndNil(FStyleMgrLink);
  // MessageBox(0, '3', nil, 0);
  inherited Destroy;
  // MessageBox(0, '4', nil, 0);
  if FHook <> nil then
    FreeAndNil(FHook);
  // MessageBox(0, '5', nil, 0);
end; { Destroy }

constructor TElFlatController.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FBorderSides := [ebsLeft, ebsTop, ebsRight, ebsBottom];
  FBorderColorFace := clBtnFace;
  FBorderColorShadow := clBtnShadow;
  FBorderColorDkShadow := cl3DDkShadow;
  FBorderColorHighlight := clBtnHighlight;
  FBorderColorWindow := clWindow;
  FThemeMode := ttmPlatform;
  FActiveBorderType := fbtSunken;
  FInactiveBorderType := fbtSunkenOuter;
  FHook := TElHook.Create(nil);
  DesignActive := true;
  FHook.OnAfterProcess := HookAfterProcessHandler;
  FHook.OnBeforeProcess := HookBeforeProcessHandler;
  FStyleMgrLink := TElStyleMgrChangeLink.Create;
  FStyleMgrLink.OnChange := StyleMgrChange;
  if not (csDesigning in ComponentState) then
    StyleManager := DefaultStyleManager;
end; { Create }

procedure TElFlatController.SetBorderSides(Value: TLMDBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if Active and (FHook.Control <> nil) and (FHook.Control is TWinControl) and
       TWinControl(FHook.Control).HandleAllocated then
      TWinControl(FHook.Control).Perform(CM_RECREATEWND, 0, 0);
  end;
end;

procedure TElFlatController.SetLineBorderActiveColor(Value: TColor);
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;
    if Active and (Control <> nil) and (not (Control.Focused or FMouseOver)) then UpdateFrame;
  end;
end;

procedure TElFlatController.SetLineBorderInactiveColor(Value: TColor);
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;
    if Active and (Control <> nil) and (not (Control.Focused or FMouseOver)) then UpdateFrame;
  end;
end;

function TElFlatController.IsControlThemed(Control : TControl): Boolean;
var PI : PPropInfo;
begin
  result := false;
  if LMDSIWindowsXPUp and (Control <> nil) then
  begin
    PI := GetPropInfo(Control.ClassInfo, 'UseXPThemes', [tkEnumeration]);
    if PI <> nil then
    begin
      result := GetOrdProp(Control, PI) <> 0;
    end;
  end;
end;

procedure TElFlatController.SetUseXPThemes(const Value: Boolean);
begin
  if UseXPThemes <> Value then
  begin
    ThemeMode := LMDCtlXP[Value];
    DoThemeChanged;
  end;
end;

procedure TElFlatController.HookBeforeProcessHandler(Sender : TObject; var Msg
    : TMessage; var Handled : Boolean);
{ Handles the FHook OnAfterProcess event. }
begin
  case Msg.Msg of
    WM_DESTROY: ;
      //if (Control<>nil) and (Control is TWinControl) and UseXPThemes and XPThemesAvailable then
      //  F.reeThemeHandle;
    WM_THEMECHANGED:  //EL_ThemeChanged
      begin
        if IsThemed and (Control<>nil) and (Control is TWinControl) then
        begin
          SetWindowPos(
            TWinControl(Control).Handle,
            0,
            0, 0, 0, 0,
            SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER
            );
          RedrawWindow(TWinControl(Control).Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE{ or RDW_ERASE});
        end;
        Msg.Result := 1;
        Handled := true;
      end;
  end;
end; { HookAfterProcessHandler }

procedure TElFlatController.Loaded;
begin
  inherited;
  if Active and UseXPThemes and (Control <> nil) and (Control<>nil) and (Control is TWinControl) then
    TElHackControl(Control).RecreateWnd;
  UpdateStyle;
end;

procedure TElFlatController.DoNCPaint;
var DC : HDC;
    RW,
    RC : TRect;
    Handle : THandle;

const BordersFlat : array[boolean] of Integer = (0, WS_BORDER);
      Borders3D : array[boolean] of Integer = (0, WS_EX_CLIENTEDGE);
      ScrollBars : array[boolean, boolean] of Integer = ((0, WS_VSCROLL), (WS_HSCROLL, WS_HSCROLL or WS_VSCROLL));

begin
  Handle := TWinControl(Control).Handle;
  if IsThemed then
  begin
    DC := GetWindowDC(Handle);

    if ((GetWindowLong(TWinControl(Control).Handle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE) = WS_EX_CLIENTEDGE) then
    begin
      Windows.GetClientRect(Handle, RC);
      if GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0 then
        inc(RC.Right, GetSystemMetrics(SM_CXVSCROLL));
      if GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0 then
        inc(RC.Bottom, GetSystemMetrics(SM_CYHSCROLL));
      GetWindowRect(Handle, RW);
      MapWindowPoints(0, Handle, RW, 2);
      OffsetRect(RC, -RW.Left, -RW.Top);
      ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
      OffsetRect(RW, -RW.Left, -RW.Top);

      LMDThemeServices.DrawElement(UseThemeMode,DC, teEditDontCare, RW, nil);

    end;

    ReleaseDC(Handle, DC);
  end
end;

procedure TElFlatController.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Control) then
    Control := nil;
  if (Operation = opRemove) and (AComponent = FStyleManager) then
     StyleManager := nil;
end; { Notification }

procedure TElFlatController.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
  begin
    if (FStyleManager <> nil) and (not (csDestroying in FStyleManager.ComponentState)) then
      FStyleManager.RemoveFreeNotification(Self);
    if FStyleManager <> nil then
       FStyleManager.UnregisterChanges(FStyleMgrLink);
    FStyleManager := Value;
    if FStyleManager <> nil then
    begin
      FStyleManager.FreeNotification(Self);
      FStyleManager.RegisterChanges(FStyleMgrLink);
      UpdateStyle;
    end;
  end;
end;

procedure TElFlatController.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
  begin
    FStyleName := Value;
    UpdateStyle;
  end;
end;

procedure TElFlatController.StyleMgrChange(Sender : TObject);
begin
  UpdateStyle;
end;

procedure TElFlatController.UpdateStyle;
begin
  if (Control = nil) or (Control.ComponentState * [csLoading, csReading] <> []) then
    exit;
  if FStyleManager <> nil then
  begin
    if (Control <> nil) and Control.HandleAllocated and Control.Visible then
      SendMessage(Control.Handle, WM_SETREDRAW, 0, 0);
    FStyleManager.ApplyStyle(Self, StyleName);
    if (Control <> nil) and Control.HandleAllocated and Control.Visible then
    begin
      SendMessage(Control.Handle, WM_SETREDRAW, 1, 0);
      Control.Invalidate;
    end;
  end;
end;

procedure TElFlatController.SetBorderColorDkShadow(Value: TColor);
begin
  if FBorderColorDkShadow <> Value then
  begin
    FBorderColorDkShadow := Value;
    if Active and (Control <> nil) then UpdateFrame;
  end;
end;

procedure TElFlatController.SetBorderColorFace(Value: TColor);
begin
  if FBorderColorFace <> Value then
  begin
    FBorderColorFace := Value;
    if Active and (Control <> nil) then UpdateFrame;
  end;
end;

procedure TElFlatController.SetBorderColorHighlight(Value: TColor);
begin
  if FBorderColorHighlight <> Value then
  begin
    FBorderColorHighlight := Value;
    if Active and (Control <> nil) then UpdateFrame;
  end;
end;

procedure TElFlatController.SetBorderColorShadow(Value: TColor);
begin
  if FBorderColorShadow <> Value then
  begin
    FBorderColorShadow := Value;
    if Active and (Control <> nil) then UpdateFrame;
  end;
end;

procedure TElFlatController.SetBorderColorWindow(Value: TColor);
begin
  if FBorderColorWindow <> Value then
  begin
    FBorderColorWindow := Value;
    if Active and (Control <> nil) then UpdateFrame;
  end;
end;

{------------------------------------------------------------------------------}
function TElFlatController.GetUseXPThemes: Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

{------------------------------------------------------------------------------}
procedure TElFlatController.ReadUseXPThemes(Reader: TReader);
begin
  SetUseXPThemes(Reader.ReadBoolean);
end;

{------------------------------------------------------------------------------}
procedure TElFlatController.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('UseXPThemes', ReadUseXPThemes, nil, false);
end;

{------------------------------------------------------------------------------}
procedure TElFlatController.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
  begin
    FThemeGlobalMode := Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
procedure TElFlatController.SetThemeMode(const Value: TLMDThemeMode);
begin
  if Value <> FThemeMode then
  begin
    FThemeMode:= Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
procedure TElFlatController.DoThemeChanged;
begin
  if Active and (Control<>nil) and (Control is TWinControl) then
  with TElHackControl(Control) do
  begin
    if HandleAllocated then
	  RecreateWnd;
  end;
end;

{------------------------------------------------------------------------------}
function TElFlatController.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

{------------------------------------------------------------------------------}
function TElFlatController.UseThemeMode: TLMDThemeMode;
begin
  if FThemeGlobalMode then
    result := LMDApplication.ThemeGlobalMode
  else
    result := FThemeMode;
  result := LMDThemeServices.UseTheme(result);
end;

end.
