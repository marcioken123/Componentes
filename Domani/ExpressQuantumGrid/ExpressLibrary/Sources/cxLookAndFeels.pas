
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressCommonLibrary                                         }
{                                                                    }
{       Copyright (c) 1998-2007 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSCOMMONLIBRARY AND ALL          }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxLookAndFeels;

{$I cxVer.inc}

interface

uses
{$IFDEF VCL}
  dxThemeConsts, dxThemeManager, Messages,
  dxOffice11,
  {$IFDEF CLR}
  WinUtils,
  {$ENDIF}
{$ENDIF}
  SysUtils, Classes, Controls, Forms, cxClasses, cxLookAndFeelPainters;

type
  { TcxLookAndFeel }

  TcxLookAndFeelKind = (lfFlat, lfStandard, lfUltraFlat, lfOffice11);
  TcxLookAndFeelValue = (lfvKind, lfvNativeStyle, lfvSkinName);
  TcxLookAndFeelValues = set of TcxLookAndFeelValue;

const
  cxDefaultLookAndFeelKind = lfUltraFlat;
  cxDefaultLookAndFeelNativeStyle = False;
  cxDefaultLookAndFeelSkinName = '';


type
  TcxLookAndFeel = class;
  TcxSystemPaletteChangedNotifier = class;

  IcxLookAndFeelNotificationListener = interface
  ['{205538BF-F19E-4285-B11F-B182D9635881}']
    function GetObject: TObject;
    procedure MasterLookAndFeelChanged(Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues);
    procedure MasterLookAndFeelDestroying(Sender: TcxLookAndFeel);
  end;

  IdxSkinSupport = interface
  ['{EF3FF483-9B69-46DF-95A4-D3A3810F63A5}']
  end;
  
  { IcxLookAndFeelContainer }

  IcxLookAndFeelContainer = interface
    ['{6065B58B-C557-4464-A67D-64183FD13F25}']
    function GetLookAndFeel: TcxLookAndFeel;
  end;

  { TcxLookAndFeel }

  TcxLookAndFeelChangedEvent = procedure(Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues) of object;

  TcxLookAndFeelData = record
    Kind: TcxLookAndFeelKind;
    NativeStyle: Boolean;
    SkinName: string;
    Painter: TcxCustomLookAndFeelPainterClass;
  end;

  TcxLookAndFeel = class(TcxInterfacedPersistent, IcxLookAndFeelNotificationListener)
  private
    FAssignedValues: TcxLookAndFeelValues;
    FChangeListenerList: TList;
    FCurrentState: TcxLookAndFeelData;
    FData: TcxLookAndFeelData;
    FIsDestruction: Boolean;
    FIsRootLookAndFeel: Boolean;
    FMasterLookAndFeel: TcxLookAndFeel;
    FPainter: TcxCustomLookAndFeelPainterClass;
    FSkinPainter: TcxCustomLookAndFeelPainterClass;
    FPrevState: TcxLookAndFeelData;
    FSystemPaletteChangedNotifier: TcxSystemPaletteChangedNotifier;
    FOnChanged: TcxLookAndFeelChangedEvent;
    function GetActiveStyle: TcxLookAndFeelStyle;
    function GetKind: TcxLookAndFeelKind;
    function GetMasterLookAndFeel: TcxLookAndFeel;
    function GetNativeStyle: Boolean;
    function GetPainter: TcxCustomLookAndFeelPainterClass;
    function GetSkinName: string;
    procedure SetAssignedValues(Value: TcxLookAndFeelValues);
    procedure SetKind(Value: TcxLookAndFeelKind);
    procedure SetMasterLookAndFeel(Value: TcxLookAndFeel);
    procedure SetNativeStyle(Value: Boolean);
    procedure SetPainter(Value: TcxCustomLookAndFeelPainterClass);
    procedure SetSkinName(const Value: string);

    procedure CheckStateChanges;
    function GetDefaultKind: TcxLookAndFeelKind;
    function GetDefaultNativeStyle: Boolean;
    function GetDefaultSkinName: string;
    function GetDefaultSkinPainter: TcxCustomLookAndFeelPainterClass;
    function IsKindStored: Boolean;
    function IsNativeStyleStored: Boolean;
    function IsSkinNameStored: Boolean;
    procedure SaveState;

    { IcxLookAndFeelNotificationListener }
    function GetObject: TObject;
    procedure MasterLookAndFeelDestroying(Sender: TcxLookAndFeel);
  protected
    procedure Changed(AChangedValues: TcxLookAndFeelValues);
    function InternalGetKind: TcxLookAndFeelKind; virtual;
    function InternalGetNativeStyle: Boolean; virtual;
    function InternalGetSkinName: string; virtual;
    function InternalGetSkinPainter: TcxCustomLookAndFeelPainterClass; virtual;
    function IsVisualSkinAvailable(const ASkinName: string;
      out Painter: TcxCustomLookAndFeelPainterClass): Boolean; virtual;
    procedure MasterLookAndFeelChanged(Sender: TcxLookAndFeel;
      AChangedValues: TcxLookAndFeelValues);
    procedure SystemPaletteChanged; virtual;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AddChangeListener(AListener: IcxLookAndFeelNotificationListener);
    function GetAvailablePainter(ANeededThemedObjectType:
      TdxThemedObjectType): TcxCustomLookAndFeelPainterClass; overload;
    function GetAvailablePainter(ANeededThemedObjectTypes:
      TdxThemedObjectTypes = []): TcxCustomLookAndFeelPainterClass; overload;
    procedure RemoveChangeListener(AListener: IcxLookAndFeelNotificationListener);
    procedure Reset;
    procedure SetStyle(Value: TcxLookAndFeelStyle);
    property ActiveStyle: TcxLookAndFeelStyle read GetActiveStyle;
    property MasterLookAndFeel: TcxLookAndFeel read GetMasterLookAndFeel write SetMasterLookAndFeel;
    property Painter: TcxCustomLookAndFeelPainterClass read GetPainter write SetPainter;
    property SkinPainter: TcxCustomLookAndFeelPainterClass read FSkinPainter write FSkinPainter; 
    property OnChanged: TcxLookAndFeelChangedEvent read FOnChanged write FOnChanged;
  published
    property AssignedValues: TcxLookAndFeelValues read FAssignedValues write SetAssignedValues stored False;
    property Kind: TcxLookAndFeelKind read GetKind write SetKind stored IsKindStored;
    property NativeStyle: Boolean read GetNativeStyle write SetNativeStyle stored IsNativeStyleStored;
    property SkinName: string read GetSkinName write SetSkinName stored IsSkinNameStored;
  end;

  { TcxLookAndFeelController }

  TcxLookAndFeelController = class(TComponent, IcxLookAndFeelNotificationListener)
  private
    function GetKind: TcxLookAndFeelKind;
    function GetNativeStyle: Boolean;
    function GetSkinName: string;
    function IsSkinNameStored: Boolean;
    procedure SetKind(Value: TcxLookAndFeelKind);
    procedure SetNativeStyle(Value: Boolean);
    procedure SetSkinName(const Value: string);
    procedure Modified;
    { IcxLookAndFeelNotificationListener }
    function GetObject: TObject;
    procedure MasterLookAndFeelChanged(Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues);
    procedure MasterLookAndFeelDestroying(Sender: TcxLookAndFeel);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Kind: TcxLookAndFeelKind read GetKind write SetKind default cxDefaultLookAndFeelKind;
    property NativeStyle: Boolean read GetNativeStyle write SetNativeStyle default cxDefaultLookAndFeelNativeStyle;
    property SkinName: string read GetSkinName write SetSkinName stored IsSkinNameStored;
  end;

  { TcxSystemPaletteChangedNotifier }

  TcxSystemPaletteChangedEvent = procedure of object;

  TcxSystemPaletteChangedNotifier = class
  private
    FIsPrimary: Boolean;
    FOnSystemPaletteChanged: TcxSystemPaletteChangedEvent;
  protected
    procedure DoChanged; virtual;
  public
    constructor Create(AIsPrimary: Boolean = False); virtual;
    destructor Destroy; override;
    property OnSystemPaletteChanged: TcxSystemPaletteChangedEvent
      read FOnSystemPaletteChanged write FOnSystemPaletteChanged;
  end;

  TdxClassSupportsSkinProc = function(AClass: TPersistent): Boolean;

function RootLookAndFeel: TcxLookAndFeel;
procedure SetControlLookAndFeel(AControl: TWinControl; AMasterLookAndFeel: TcxLookAndFeel); overload;
procedure SetControlLookAndFeel(AControl: TWinControl; AKind: TcxLookAndFeelKind;
  ANativeStyle: Boolean); overload;

var
  ClassSupportsSkinProc: TdxClassSupportsSkinProc; 

implementation

uses
{$IFDEF WIN32}
  Windows,
{$ENDIF}
  cxControls;

const
  LookAndFeelValueAll = [lfvKind, lfvNativeStyle, lfvSkinName];
  LookAndFeelPainterMap: array[TcxLookAndFeelKind] of TcxCustomLookAndFeelPainterClass = (
    TcxFlatLookAndFeelPainter,
    TcxStandardLookAndFeelPainter,
    TcxUltraFlatLookAndFeelPainter,
    TcxOffice11LookAndFeelPainter
  );
  LookAndFeelStyleMap: array[TcxLookAndFeelKind] of TcxLookAndFeelStyle =
    (lfsFlat, lfsStandard, lfsUltraFlat, lfsOffice11);
  LookAndFeelKindMap: array[TcxLookAndFeelStyle] of TcxLookAndFeelKind =
    (lfFlat, lfStandard, lfUltraFlat, lfStandard, lfOffice11);

type
  { TcxSystemPaletteChangedListener }

  TcxSystemPaletteChangedListener = class
  private
    FNotifierList: TList;
    FPrimaryNotifierList: TList;
    FWindowHandle: TcxHandle;
{$IFDEF LINUX}
    FWidgetHook: QWidget_hookH;
{$ENDIF}
    procedure DoChange;
{$IFDEF VCL}
    procedure WndProc(var Msg: TMessage);
{$ELSE}
  {$IFDEF LINUX}
    function WidgetEventFilter(Sender: QObjectH; Event: QEventH): Boolean; cdecl;
  {$ENDIF}
{$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddNotifier(ANotifier: TcxSystemPaletteChangedNotifier;
      AIsPrimary: Boolean);
    procedure RemoveNotifier(ANotifier: TcxSystemPaletteChangedNotifier;
      AIsPrimary: Boolean);
  end;

var
  FLookAndFeelControllerCount: Integer;
  FRootLookAndFeel: TcxLookAndFeel;
  FSystemPaletteChangedListener: TcxSystemPaletteChangedListener;
  FSystemPaletteChangedListenerRefCount: Integer;

procedure SetControlLookAndFeel(AControl: TWinControl; AMasterLookAndFeel: TcxLookAndFeel);
var
  AIntf: IcxLookAndFeelContainer;
  I: Integer;
begin
  if Supports(AControl, IcxLookAndFeelContainer, AIntf) then
    AIntf.GetLookAndFeel.MasterLookAndFeel := AMasterLookAndFeel;
  for I := 0 to AControl.ControlCount - 1 do
    if AControl.Controls[I] is TWinControl then
      SetControlLookAndFeel(TWinControl(AControl.Controls[I]), AMasterLookAndFeel);
end;

procedure SetControlLookAndFeel(AControl: TWinControl; AKind: TcxLookAndFeelKind;
  ANativeStyle: Boolean);
var
  AIntf: IcxLookAndFeelContainer;
  I: Integer;
begin
  if Supports(AControl, IcxLookAndFeelContainer, AIntf) then
    with AIntf.GetLookAndFeel do
    begin
      Kind := AKind;
      NativeStyle := ANativeStyle;
    end;
  for I := 0 to AControl.ControlCount - 1 do
    if AControl.Controls[I] is TWinControl then
      SetControlLookAndFeel(TWinControl(AControl.Controls[I]), AKind, ANativeStyle);
end;  

procedure AddRefSystemPaletteChangedListener;
begin
  if FSystemPaletteChangedListenerRefCount = 0 then
    FSystemPaletteChangedListener := TcxSystemPaletteChangedListener.Create;
  Inc(FSystemPaletteChangedListenerRefCount);
end;

procedure ReleaseRefSystemPaletteChangedListener;
begin
  Dec(FSystemPaletteChangedListenerRefCount);
  if FSystemPaletteChangedListenerRefCount = 0 then
    FreeAndNil(FSystemPaletteChangedListener);
end;

function RootLookAndFeel: TcxLookAndFeel;
begin
  Result := FRootLookAndFeel;
end;

{$IFNDEF VCL}
  {$IFDEF WIN32}
var
  FApplicationCallWndProcHook: HHOOK = 0;
  {$ENDIF}
{$ENDIF}

{ TcxSystemPaletteChangedListener }

{$IFNDEF VCL}
  {$IFDEF WIN32}
function ApplicationCallWndProcHookProc(Code: Integer; WParam,
  LParam: Longint): Longint stdcall;
begin
  try
    with PCWPStruct(LParam)^ do
      if (message = WM_SYSCOLORCHANGE) and (hwnd = QWidget_winId(FSystemPaletteChangedListener.FWindowHandle)) then
        FSystemPaletteChangedListener.DoChange;
  finally
    Result := CallNextHookEx(FApplicationCallWndProcHook, Code, WParam, LParam);
  end;
end;
  {$ENDIF}
{$ENDIF}

{$IFDEF VCL}
constructor TcxSystemPaletteChangedListener.Create;
begin
  inherited Create;
  CreateOffice11Colors;
  {$IFDEF DELPHI6}
    {$IFNDEF CLR}
    FWindowHandle := Classes.AllocateHWnd(WndProc);
    {$ELSE}
    FWindowHandle := WinUtils.AllocateHWnd(WndProc);
    {$ENDIF}
  {$ELSE}
  FWindowHandle := Forms.AllocateHWnd(WndProc);
  {$ENDIF}
  FNotifierList := TList.Create;
  FPrimaryNotifierList := TList.Create;
end;
{$ELSE}
  {$IFDEF WIN32}
constructor TcxSystemPaletteChangedListener.Create;
begin
  inherited Create;
  FWindowHandle := QWidget_create(nil, '', 0);
  FApplicationCallWndProcHook := SetWindowsHookEx(WH_CALLWNDPROC,
    @ApplicationCallWndProcHookProc, 0, GetCurrentThreadID);
  FNotifierList := TList.Create;
  FPrimaryNotifierList := TList.Create;
end;
  {$ENDIF}
  {$IFDEF LINUX}
constructor TcxSystemPaletteChangedListener.Create;
var
  AMethod: TMethod;
begin
  inherited Create;
  FWindowHandle := QWidget_create(nil, '', 0);
  FWidgetHook := QWidget_hook_create(FWindowHandle);
  TEventFilterMethod(AMethod) := WidgetEventFilter;
  Qt_hook_hook_events(FWidgetHook, AMethod);
  FNotifierList := TList.Create;
  FPrimaryNotifierList := TList.Create;
end;
  {$ENDIF}
{$ENDIF}

destructor TcxSystemPaletteChangedListener.Destroy;
begin
  FreeAndNil(FPrimaryNotifierList);
  FreeAndNil(FNotifierList);
{$IFDEF VCL}
  {$IFDEF DELPHI6}
    {$IFNDEF CLR}
    Classes.DeallocateHWnd(FWindowHandle);
    {$ELSE}
    WinUtils.DeallocateHWnd(FWindowHandle);
    {$ENDIF}
  {$ELSE}
  Forms.DeallocateHWnd(FWindowHandle);
  {$ENDIF}
  ReleaseOffice11Colors;
{$ELSE}
  {$IFDEF WIN32}
  if FApplicationCallWndProcHook <> 0 then
    UnhookWindowsHookEx(FApplicationCallWndProcHook);
  FApplicationCallWndProcHook := 0;
  QWidget_destroy(FWindowHandle);
  {$ENDIF}
  {$IFDEF LINUX}
  QWidget_hook_destroy(FWidgetHook);
  QWidget_destroy(FWindowHandle);
  {$ENDIF}
{$ENDIF}
  inherited Destroy;
end;
                                                        
procedure TcxSystemPaletteChangedListener.AddNotifier(
  ANotifier: TcxSystemPaletteChangedNotifier; AIsPrimary: Boolean);
begin
  if AIsPrimary then
  begin
    if FPrimaryNotifierList <> nil then
      FPrimaryNotifierList.Add(ANotifier);
  end
  else
    if FNotifierList <> nil then
      FNotifierList.Add(ANotifier);
end;

procedure TcxSystemPaletteChangedListener.RemoveNotifier(
  ANotifier: TcxSystemPaletteChangedNotifier; AIsPrimary: Boolean);
begin
  if AIsPrimary then
  begin
    if FPrimaryNotifierList <> nil then
      FPrimaryNotifierList.Remove(ANotifier);
  end
  else
    if FNotifierList <> nil then
      FNotifierList.Remove(ANotifier);
end;

procedure TcxSystemPaletteChangedListener.DoChange;
var
  I: Integer;
begin
  RefreshOffice11Colors;
  for I := FPrimaryNotifierList.Count - 1 downto 0 do
  //for I := 0 to FPrimaryNotifierList.Count - 1 do
    TcxSystemPaletteChangedNotifier(FPrimaryNotifierList[I]).DoChanged;
  for I := FNotifierList.Count - 1 downto 0 do
  //for I := 0 to FNotifierList.Count - 1 do
    TcxSystemPaletteChangedNotifier(FNotifierList[I]).DoChanged;
end;

{$IFDEF VCL}
procedure TcxSystemPaletteChangedListener.WndProc(var Msg: TMessage);
begin
  with Msg do
    try
      if Msg = WM_SYSCOLORCHANGE then
        DoChange;
    finally
    {$IFNDEF CLR}
      Result := DefWindowProc(FWindowHandle, Msg, wParam, lParam);
    {$ELSE}
      Result := WindowProcDelegate(FWindowHandle, Msg, wParam, lParam);
    {$ENDIF}
    end;
end;
{$ELSE}
  {$IFDEF LINUX}
function TcxSystemPaletteChangedListener.WidgetEventFilter(Sender: QObjectH;
  Event: QEventH): Boolean; cdecl;
begin
  Result := False;
  if QEvent_type(Event) = QEventType_ApplicationPaletteChange then
    DoChange;
end;
  {$ENDIF}
{$ENDIF}

{ TcxLookAndFeel }

constructor TcxLookAndFeel.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FChangeListenerList := TList.Create;
  FData.Kind := cxDefaultLookAndFeelKind;
  FData.NativeStyle := cxDefaultLookAndFeelNativeStyle;
  FCurrentState := FData;
  FSystemPaletteChangedNotifier := TcxSystemPaletteChangedNotifier.Create;
  FSystemPaletteChangedNotifier.OnSystemPaletteChanged := SystemPaletteChanged;
  if FRootLookAndFeel <> nil then
  begin
    FRootLookAndFeel.AddChangeListener(Self);
    FCurrentState.Kind := InternalGetKind;
    FCurrentState.NativeStyle := InternalGetNativeStyle;
    FCurrentState.SkinName := InternalGetSkinName;
    FSkinPainter := nil;
    if not FCurrentState.NativeStyle then
      FSkinPainter := InternalGetSkinPainter;
  end;
  FCurrentState.Painter := GetAvailablePainter();
end;

destructor TcxLookAndFeel.Destroy;
var
  I: Integer;
{$IFDEF CLR}
  ANotificationListener: IcxLookAndFeelNotificationListener;
{$ENDIF}
begin
  FreeAndNil(FSystemPaletteChangedNotifier);
  FIsDestruction := True;
  for I := 0 to FChangeListenerList.Count - 1 do
  begin
  {$IFNDEF CLR}
    IcxLookAndFeelNotificationListener(FChangeListenerList.Items[I]).MasterLookAndFeelDestroying(Self);
  {$ELSE}
  if Supports(FChangeListenerList.Items[I], IcxLookAndFeelNotificationListener, ANotificationListener) then
    ANotificationListener.MasterLookAndFeelDestroying(Self);
  {$ENDIF}
  end;
  FIsDestruction := False;
  FreeAndNil(FChangeListenerList);

  if MasterLookAndFeel <> nil then
    MasterLookAndFeel.RemoveChangeListener(Self);

  if FIsRootLookAndFeel then
  begin
    FRootLookAndFeel := nil;
    FIsRootLookAndFeel := False;
  end;
  inherited Destroy;
end;

procedure TcxLookAndFeel.AddChangeListener(AListener: IcxLookAndFeelNotificationListener);
var
  AIsLookAndFeelController: Boolean;
begin
  if AListener = nil then
    Exit;
  AIsLookAndFeelController := AListener.GetObject is TcxLookAndFeelController;
  if not FIsRootLookAndFeel and AIsLookAndFeelController then
    Exit;
  if FChangeListenerList.IndexOf({$IFNDEF CLR}Pointer{$ENDIF}(AListener)) >= 0 then
    Exit;

  if FIsRootLookAndFeel and AIsLookAndFeelController then
    Inc(FLookAndFeelControllerCount);
  FChangeListenerList.Add({$IFNDEF CLR}Pointer{$ENDIF}(AListener));
end;

function TcxLookAndFeel.GetAvailablePainter(ANeededThemedObjectType:
  TdxThemedObjectType): TcxCustomLookAndFeelPainterClass;
begin
  if NativeStyle and AreVisualStylesAvailable(ANeededThemedObjectType) then
    Result := TcxWinXPLookAndFeelPainter
  else
    if FSkinPainter <> nil then
      Result := FSkinPainter
    else
      Result := LookAndFeelPainterMap[Kind];
end;

function TcxLookAndFeel.GetAvailablePainter(ANeededThemedObjectTypes:
  TdxThemedObjectTypes = []): TcxCustomLookAndFeelPainterClass;
begin
  if NativeStyle and AreVisualStylesAvailable(ANeededThemedObjectTypes) then
    Result := TcxWinXPLookAndFeelPainter
  else
    if FSkinPainter <> nil then
      Result := FSkinPainter
    else
      Result := LookAndFeelPainterMap[Kind];
end;

procedure TcxLookAndFeel.Assign(Source: TPersistent);
begin
  if Source is TcxLookAndFeel then
    with Source as TcxLookAndFeel do
    begin
      Self.SaveState;
      Self.FData := FData;
      Self.FAssignedValues := FAssignedValues;
      Self.MasterLookAndFeel := MasterLookAndFeel;
      Self.CheckStateChanges;
    end
  else
    inherited Assign(Source);
end;

procedure TcxLookAndFeel.RemoveChangeListener(AListener: IcxLookAndFeelNotificationListener);
var
  AIsLookAndFeelController: Boolean;
begin
  if AListener = nil then
    Exit;
  AIsLookAndFeelController := AListener.GetObject is TcxLookAndFeelController;
  if FChangeListenerList.IndexOf({$IFNDEF CLR}Pointer{$ENDIF}(AListener)) < 0 then
    Exit;

  if not FIsDestruction then
    FChangeListenerList.Remove({$IFNDEF CLR}Pointer{$ENDIF}(AListener));

  if FIsRootLookAndFeel and AIsLookAndFeelController then
  begin
    Dec(FLookAndFeelControllerCount);
    if FLookAndFeelControllerCount = 0 then
      Reset;
  end;
end;

procedure TcxLookAndFeel.Reset;
begin
  AssignedValues := [];
end;

procedure TcxLookAndFeel.SetStyle(Value: TcxLookAndFeelStyle);
begin
  NativeStyle := Value = lfsNative;
  if not NativeStyle then
    Kind := LookAndFeelKindMap[Value];
end;

procedure TcxLookAndFeel.Changed(AChangedValues: TcxLookAndFeelValues);
var
  I, APrevCount: Integer;
{$IFDEF CLR}
  ANotificationListener: IcxLookAndFeelNotificationListener;
{$ENDIF}
begin
  if (AChangedValues = []) or FIsDestruction then Exit;
  FCurrentState.Kind := InternalGetKind;
  FCurrentState.NativeStyle := InternalGetNativeStyle;
  FCurrentState.SkinName := InternalGetSkinName;
  FSkinPainter := nil;
  if not FCurrentState.NativeStyle then
    FSkinPainter := InternalGetSkinPainter;
  FCurrentState.Painter := GetAvailablePainter;

  I := 0;
  while I < FChangeListenerList.Count do
  begin
    APrevCount := FChangeListenerList.Count;
    {$IFNDEF CLR}
    IcxLookAndFeelNotificationListener(FChangeListenerList.Items[I]).MasterLookAndFeelChanged(Self, AChangedValues);
    {$ELSE}
    if Supports(FChangeListenerList.Items[I], IcxLookAndFeelNotificationListener, ANotificationListener) then
      ANotificationListener.MasterLookAndFeelChanged(Self, AChangedValues);
    {$ENDIF}
    if APrevCount = FChangeListenerList.Count then
      Inc(I);
  end;

  if Assigned(FOnChanged) then
    FOnChanged(Self, AChangedValues);
end;

function TcxLookAndFeel.InternalGetKind: TcxLookAndFeelKind;
begin
  if lfvKind in FAssignedValues then
    Result := FData.Kind
  else
    Result := GetDefaultKind;
end;

function TcxLookAndFeel.InternalGetNativeStyle: Boolean;
begin
  if lfvNativeStyle in FAssignedValues then
    Result := FData.NativeStyle
  else
    Result := GetDefaultNativeStyle;
end;

function TcxLookAndFeel.InternalGetSkinName: string;
begin
  if lfvSkinName in FAssignedValues then
    Result := FData.SkinName
  else
    Result := GetDefaultSkinName;
end;

function TcxLookAndFeel.InternalGetSkinPainter: TcxCustomLookAndFeelPainterClass;
begin
  if lfvSkinName in FAssignedValues then
    IsVisualSkinAvailable(FData.SkinName, Result)
  else
    Result := GetDefaultSkinPainter;
end;

function TcxLookAndFeel.IsVisualSkinAvailable(const ASkinName: string;
  out Painter: TcxCustomLookAndFeelPainterClass): Boolean;
begin
  Result := (ASkinName <> '') and
    GetExtendedStylePainters.GetPainterByName(ASkinName, Painter);
  if not Result then
    Painter := nil;
end;

procedure TcxLookAndFeel.MasterLookAndFeelChanged(Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues);
var
  AOwnChangedValues: TcxLookAndFeelValues;
begin
  AOwnChangedValues := (LookAndFeelValueAll - FAssignedValues) * AChangedValues;
  Changed(AOwnChangedValues);
end;                  

procedure TcxLookAndFeel.SystemPaletteChanged;
begin
  Changed([lfvNativeStyle]);
end;

function TcxLookAndFeel.GetActiveStyle: TcxLookAndFeelStyle;
begin
  if NativeStyle and AreVisualStylesAvailable then
    Result := lfsNative
  else
    Result := LookAndFeelStyleMap[Kind];
end;

function TcxLookAndFeel.GetKind: TcxLookAndFeelKind;
begin
  Result := FCurrentState.Kind;
end;

function TcxLookAndFeel.GetMasterLookAndFeel: TcxLookAndFeel;
begin
  if FIsRootLookAndFeel then
    Result := nil
  else
    if FMasterLookAndFeel = nil then
      Result := FRootLookAndFeel
    else
      Result := FMasterLookAndFeel;
end;

function TcxLookAndFeel.GetNativeStyle: Boolean;
begin
  Result := FCurrentState.NativeStyle;
end;

function TcxLookAndFeel.GetPainter: TcxCustomLookAndFeelPainterClass;
begin
  if FPainter = nil then
    Result := FCurrentState.Painter
  else
    Result := FPainter;
end;

function TcxLookAndFeel.GetSkinName: string;
begin
  Result := FCurrentState.SkinName;
end;

procedure TcxLookAndFeel.SetAssignedValues(Value: TcxLookAndFeelValues);
begin
  if Value <> FAssignedValues then
  begin
    SaveState;
    FAssignedValues := Value;
    CheckStateChanges;
  end;
end;

procedure TcxLookAndFeel.SetKind(Value: TcxLookAndFeelKind);
var
  AOldKind: TcxLookAndFeelKind;
begin
  AOldKind := Kind;
  Include(FAssignedValues, lfvKind);
  FData.Kind := Value;
  if AOldKind <> InternalGetKind then
    Changed([lfvKind]);
end;

procedure TcxLookAndFeel.SetMasterLookAndFeel(Value: TcxLookAndFeel);
begin
  if FIsRootLookAndFeel or (Value = Self) then Exit;
  if Value <> MasterLookAndFeel then
  begin
    SaveState;
    if MasterLookAndFeel <> nil then
      MasterLookAndFeel.RemoveChangeListener(Self);
    FMasterLookAndFeel := Value;
    if MasterLookAndFeel <> nil then
      MasterLookAndFeel.AddChangeListener(Self);
    CheckStateChanges;
  end;
end;

procedure TcxLookAndFeel.SetNativeStyle(Value: Boolean);
var
  AOldNativeStyle: Boolean;
begin
  AOldNativeStyle := NativeStyle;
  Include(FAssignedValues, lfvNativeStyle);
  FData.NativeStyle := Value;
  if AOldNativeStyle <> InternalGetNativeStyle then
    Changed([lfvNativeStyle]);
end;

procedure TcxLookAndFeel.SetPainter(Value: TcxCustomLookAndFeelPainterClass);
begin
  if Painter <> Value then
  begin
    FPainter := Value;
    Changed([lfvKind, lfvNativeStyle]);
  end;
end;

procedure TcxLookAndFeel.SetSkinName(const Value: string);
var
  AOldSkinName: string;
begin
  AOldSkinName := SkinName;
  Include(FAssignedValues, lfvSkinName);
  FData.SkinName := Value;
  if AOldSkinName <> InternalGetSkinName then
    Changed([lfvSkinName]);
end;

procedure TcxLookAndFeel.CheckStateChanges;
var
  AChangedValues: TcxLookAndFeelValues;
begin
  AChangedValues := [];
  if FPrevState.Kind <> InternalGetKind then
    Include(AChangedValues, lfvKind);
  if FPrevState.NativeStyle <> InternalGetNativeStyle then
    Include(AChangedValues, lfvNativeStyle);
  if FPrevState.SkinName <> InternalGetSkinName then 
    Include(AChangedValues, lfvSkinName);
  Changed(AChangedValues);
end;

function TcxLookAndFeel.GetDefaultKind: TcxLookAndFeelKind;
begin
  if FIsRootLookAndFeel then
    Result := cxDefaultLookAndFeelKind
  else
    if FMasterLookAndFeel = nil then
      if FRootLookAndFeel = nil then
        Result := cxDefaultLookAndFeelKind
      else
        Result := FRootLookAndFeel.Kind
    else
      Result := FMasterLookAndFeel.Kind;
end;

function TcxLookAndFeel.GetDefaultNativeStyle: Boolean;
begin
  if FIsRootLookAndFeel then
    Result := cxDefaultLookAndFeelNativeStyle
  else
    if FMasterLookAndFeel = nil then
      if FRootLookAndFeel = nil then
        Result := cxDefaultLookAndFeelNativeStyle
      else
        Result := FRootLookAndFeel.NativeStyle
    else
      Result := FMasterLookAndFeel.NativeStyle;
end;

function TcxLookAndFeel.GetDefaultSkinName: string;
begin
  if FIsRootLookAndFeel then
    Result := cxDefaultLookAndFeelSkinName
  else
    if FMasterLookAndFeel = nil then
      if FRootLookAndFeel = nil then
        Result := cxDefaultLookAndFeelSkinName
      else
        Result := FRootLookAndFeel.SkinName
    else
      Result := FMasterLookAndFeel.SkinName;
end;

function TcxLookAndFeel.GetDefaultSkinPainter: TcxCustomLookAndFeelPainterClass;
begin
  if FIsRootLookAndFeel then
    Result := nil
  else
    if FMasterLookAndFeel = nil then
      if FRootLookAndFeel = nil then
        Result := nil
      else
        Result := FRootLookAndFeel.SkinPainter
    else
      Result := FMasterLookAndFeel.SkinPainter;
end;

function TcxLookAndFeel.IsKindStored: Boolean;
begin
  Result := lfvKind in FAssignedValues;
end;

function TcxLookAndFeel.IsNativeStyleStored: Boolean;
begin
  Result := lfvNativeStyle in FAssignedValues;
end;

function TcxLookAndFeel.IsSkinNameStored: Boolean;
begin
  Result := lfvSkinName in FAssignedValues;
end;

procedure TcxLookAndFeel.SaveState;
begin
  FPrevState.Kind := Kind;
  FPrevState.NativeStyle := NativeStyle;
  FPrevState.SkinName := SkinName;
end;

function TcxLookAndFeel.GetObject: TObject;
begin
  Result := Self;
end;

procedure TcxLookAndFeel.MasterLookAndFeelDestroying(Sender: TcxLookAndFeel);
begin
  MasterLookAndFeel := nil;
end;

{ TcxLookAndFeelController }

constructor TcxLookAndFeelController.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if RootLookAndFeel <> nil then
    RootLookAndFeel.AddChangeListener(Self);
end;

destructor TcxLookAndFeelController.Destroy;
begin
  if RootLookAndFeel <> nil then
    RootLookAndFeel.RemoveChangeListener(Self);
  inherited Destroy;
end;

function TcxLookAndFeelController.GetKind: TcxLookAndFeelKind;
begin
  if RootLookAndFeel = nil then
    Result := cxDefaultLookAndFeelKind
  else
    Result := RootLookAndFeel.Kind;
end;

function TcxLookAndFeelController.GetNativeStyle: Boolean;
begin
  if RootLookAndFeel = nil then
    Result := cxDefaultLookAndFeelNativeStyle
  else
    Result := RootLookAndFeel.NativeStyle;
end;

function TcxLookAndFeelController.GetSkinName: string;
begin
  if RootLookAndFeel = nil then
    Result := cxDefaultLookAndFeelSkinName
  else
    Result := RootLookAndFeel.SkinName;
end;

function TcxLookAndFeelController.IsSkinNameStored: Boolean;
begin
  Result := SkinName <> '';
end;

procedure TcxLookAndFeelController.SetKind(Value: TcxLookAndFeelKind);
begin
  if RootLookAndFeel <> nil then
    RootLookAndFeel.Kind := Value;
end;

procedure TcxLookAndFeelController.SetNativeStyle(Value: Boolean);
begin
  if RootLookAndFeel <> nil then
    RootLookAndFeel.NativeStyle := Value;
end;

procedure TcxLookAndFeelController.SetSkinName(const Value: string);
begin
  if RootLookAndFeel <> nil then
    RootLookAndFeel.SkinName := Value;
end;

procedure TcxLookAndFeelController.Modified;
begin
end;

function TcxLookAndFeelController.GetObject: TObject;
begin
  Result := Self;
end;

procedure TcxLookAndFeelController.MasterLookAndFeelChanged(Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues);
begin
  if csDesigning in ComponentState then
    Modified;
end;

procedure TcxLookAndFeelController.MasterLookAndFeelDestroying(Sender: TcxLookAndFeel);
var
  AOwnerForm: TCustomForm;
begin
  AOwnerForm := nil;
{$IFDEF DELPHI6}
  if (Owner is TFrame) and (TFrame(Owner).Owner is TForm) then
    AOwnerForm := TForm(TFrame(Owner).Owner)
  else
{$ENDIF}
    if Owner is TForm then
      AOwnerForm := TForm(Owner);
  if AOwnerForm = nil then
    Exit;
{$IFDEF VCL}
  if AOwnerForm.Designer <> nil then
    AOwnerForm.Designer.Modified;
{$ELSE}
  if AOwnerForm.DesignerHook <> nil then
    AOwnerForm.DesignerHook.Modified;
{$ENDIF}
end;

{ TcxSystemPaletteChangedNotifier }

constructor TcxSystemPaletteChangedNotifier.Create(AIsPrimary: Boolean = False);
begin
  inherited Create;
  FIsPrimary := AIsPrimary;
  AddRefSystemPaletteChangedListener;
  FSystemPaletteChangedListener.AddNotifier(Self, AIsPrimary);
end;

destructor TcxSystemPaletteChangedNotifier.Destroy;
begin
  FSystemPaletteChangedListener.RemoveNotifier(Self, FIsPrimary);
  ReleaseRefSystemPaletteChangedListener;
end;

procedure TcxSystemPaletteChangedNotifier.DoChanged;
begin
  if Assigned(FOnSystemPaletteChanged) then
    FOnSystemPaletteChanged;
end;

function ClassSupportsSkinHandler(AClass: TPersistent): Boolean;
begin
  Result := Supports(AClass, IdxSkinSupport);
end;

initialization
{$IFDEF DELPHI6}
  GroupDescendentsWith(TcxLookAndFeelController, TForm);
{$ENDIF}
  FRootLookAndFeel := TcxLookAndFeel.Create(nil);
  FRootLookAndFeel.FIsRootLookAndFeel := True;
  ClassSupportsSkinProc := ClassSupportsSkinHandler;

finalization
  FreeAndNil(FRootLookAndFeel);

end.
