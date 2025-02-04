
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

{$DEFINE USETCXSCROLLBAR}

unit cxContainer;

{$I cxVer.inc}

interface

uses
  Windows, Messages,
{$IFDEF CLR}
  System.Reflection, System.Runtime.InteropServices,
{$ENDIF}
  dxThemeConsts, dxThemeManager, dxUxTheme,
  Classes, Controls, Forms, Graphics, Menus, StdCtrls, SysUtils, cxClasses,
  cxControls, cxGraphics, cxLookAndFeels, cxScrollBar, cxLookAndFeelPainters;

const
  CM_CLOSEPOPUPWINDOW = WM_APP + 101;
  CM_SHOWPOPUPWINDOW = WM_APP + 102;
  CM_SHORTREFRESHCONTAINER = WM_APP + 103;
  CM_UPDATESCROLLBARS = WM_APP + 104;

  cxDefaultAutoCompleteDelay = 500;

  cxContainerMaxBorderWidth = 2;
  cxContainerShadowWidth = 3;

  cxEmptyBrush: TBrushHandle = 0;

  cxContainerDefaultBorderExtent: TRect = (
    Left: cxContainerMaxBorderWidth;
    Top: cxContainerMaxBorderWidth;
    Right: cxContainerMaxBorderWidth;
    Bottom: cxContainerMaxBorderWidth
  );

type
  TcxContainerBorderStyle = (cbsNone, cbsSingle, cbsThick, cbsFlat, cbs3D,
    cbsUltraFlat, cbsOffice11);
  TcxContainerHotState = (chsNoHotTrack, chsNormal, chsSelected);
  TcxContainerStateItem = (csNormal, csActive, csDisabled, csHotTrack);
  TcxContainerState = set of TcxContainerStateItem;
  TcxMouseButton = (cxmbNone, cxmbLeft, cxmbRight, cxmbMiddle);
  TcxNativeHandle = HWND;

  TcxContainerStyleValue = 0..SizeOf(Integer) * 8 - 1;
  TcxContainerStyleValues = set of TcxContainerStyleValue;

const
  csvBorderColor       = 0;
  csvBorderStyle       = 1;
  csvColor             = 2;
  csvEdges             = 3;
  csvFont              = 4;
  csvHotTrack          = 5;
  csvShadow            = 6;
  csvTextColor         = 7;
  csvTextStyle         = 8;
  csvTransparentBorder = 9;

  cxContainerStyleValueCount = 10;

  cxContainerStyleValueNameA: array[0..cxContainerStyleValueCount - 1] of string = (
    'BorderColor',
    'BorderStyle',
    'Color',
    'Edges',
    'Font',
    'HotTrack',
    'Shadow',
    'TextColor',
    'TextStyle',
    'TransparentBorder'
  );

type
  TcxContainer = class;
  TcxContainerClass = class of TcxContainer;

  { TcxContainerViewInfo }

  TcxContainerViewInfo = class
  private
    FBackgroundColor: TColor;
  protected
    procedure DrawBorder(ACanvas: TcxCanvas; R: TRect); virtual;
    function GetContainerBorderStyle: TcxContainerBorderStyle; virtual;
    procedure InternalPaint(ACanvas: TcxCanvas); virtual;
    procedure SetBackgroundColor(Value: TColor); virtual;
  public
    BorderColor: TColor;
    BorderRect: TRect;
    BorderStyle: TcxContainerBorderStyle;
    BorderWidth: Integer;
    Bounds: TRect;
    ClientRect: TRect;
    ContainerState: TcxContainerState;
    Edges: TcxBorders;
    HotState: TcxContainerHotState;
    NativePart: Integer;
    NativeState: Integer;
    NativeStyle: Boolean;
    Painter: TcxCustomLookAndFeelPainterClass;
    Shadow: Boolean;
    ThemedObjectType: TdxThemedObjectType;
    property BackgroundColor: TColor read FBackgroundColor write SetBackgroundColor;
    constructor Create; virtual;
    procedure Assign(Source: TObject); virtual;
    function GetUpdateRegion(AViewInfo: TcxContainerViewInfo): TcxRegion; virtual;
    procedure Offset(DX, DY: Integer); virtual;
    procedure Paint(ACanvas: TcxCanvas); virtual;
  end;

  TcxContainerViewInfoClass = class of TcxContainerViewInfo;

  { TcxContainerStyle }

  TcxStyleController = class;

  TcxContainerStyleData = record
    Color: TColor;
    Font: TFont;
    FontColor: TColor;
  end;

  TcxContainerStyle = class(TcxInterfacedPersistent, {$IFNDEF CLR}IUnknown, {$ENDIF} IdxSkinSupport)
  private
    FBorderColor: TColor;
    FBorderStyle: TcxContainerBorderStyle;
    FEdges: TcxBorders;
    FHotTrack: Boolean;
    FShadow: Boolean;
    FTransparentBorder: Boolean;

    FDirectAccessMode: Boolean;
    FFontAssignedValueLockCount: Integer;
    FIsDestroying: Boolean;
    FLookAndFeel: TcxLookAndFeel;
    FModified: Boolean;
    FOwner: TPersistent;
    FParentStyle: TcxContainerStyle;
    FState: TcxContainerStateItem;
    FTextStyle: TFontStyles;
    FUpdateCount: Integer;
    FVisibleFont: TFont;
    FOnChanged: TNotifyEvent;

    function GetAssignedValues: TcxContainerStyleValues;
    function GetBorderColor: TColor;
    function GetBorderStyle: TcxContainerBorderStyle;
    function GetEdges: TcxBorders;
    function GetFont: TFont;
    function GetHotTrack: Boolean;
    function GetShadow: Boolean;
    function GetTransparentBorder: Boolean;

    function InternalGetBorderColor(var BorderColor: TColor): Boolean;
    function InternalGetBorderStyle(var BorderStyle: TcxContainerBorderStyle): Boolean;
    function InternalGetEdges(var Edges: TcxBorders): Boolean;
    function InternalGetFont(var Font: TFont): Boolean;
    function InternalGetHotTrack(var HotTrack: Boolean): Boolean;
    function InternalGetShadow(var Shadow: Boolean): Boolean;
    function InternalGetTextColor(var TextColor: TColor): Boolean;
    function InternalGetTextStyle(var TextStyle: TFontStyles): Boolean;
    function InternalGetTransparentBorder(var TransparentBorder: Boolean): Boolean;

    function IsBorderColorStored: Boolean;
    function IsBorderStyleStored: Boolean;
    function IsColorStored: Boolean;
    function IsEdgesStored: Boolean;
    function IsFontStored: Boolean;
    function IsHotTrackStored: Boolean;
  {$IFDEF CLR}
    function IsLookAndFeelStored: Boolean;
  {$ENDIF}
    function IsShadowStored: Boolean;
    function IsStyleControllerStored: Boolean;
    function IsTextColorStored: Boolean;
    function IsTextStyleStored: Boolean;
    function IsTransparentBorderStored: Boolean;

    procedure SetAssignedValues(Value: TcxContainerStyleValues);
    procedure SetBorderColor(Value: TColor);
    procedure SetBorderStyle(Value: TcxContainerBorderStyle);
    procedure SetColor(Value: TColor);
    procedure SetEdges(Value: TcxBorders);
    procedure SetFont(Value: TFont);
    procedure SetHotTrack(Value: Boolean);
    procedure SetShadow(Value: Boolean);
    procedure SetTextColor(Value: TColor);
    procedure SetTextStyle(Value: TFontStyles);
    procedure SetTransparentBorder(Value: Boolean);

    procedure CheckChanges;
    procedure CreateFont;
    function GetActiveStyleController: TcxStyleController;
    function GetBaseStyle: TcxContainerStyle;
    function GetContainer: TcxContainer;
    function GetLookAndFeel: TcxLookAndFeel;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel;
      AChangedValues: TcxLookAndFeelValues);
    procedure ReadIsFontAssigned(Reader: TReader);
    procedure RestoreFont(AFont: TFont);
    procedure SetLookAndFeel(Value: TcxLookAndFeel);
    procedure UpdateVisibleFont;
    procedure WriteIsFontAssigned(Writer: TWriter);
  protected
    FAssignedValues: TcxContainerStyleValues;
    FStyleController: TcxStyleController;
    procedure DefineProperties(Filer: TFiler); override;
    function BaseGetStyleController: TcxStyleController;
    procedure BaseSetStyleController(Value: TcxStyleController);
    procedure Changed; virtual;
    procedure ControllerChangedNotification(AStyleController: TcxStyleController); virtual;
    procedure ControllerFreeNotification(AStyleController: TcxStyleController); virtual;

    function DefaultBorderColor: TColor; virtual;
    function DefaultBorderStyle: TcxContainerBorderStyle; virtual;
    function DefaultColor: TColor; virtual;
    function DefaultEdges: TcxBorders; virtual;
    function DefaultHotTrack: Boolean; virtual;
    function DefaultShadow: Boolean; virtual;
    function DefaultTextColor: TColor; virtual;
    function DefaultTextStyle: TFontStyles; virtual;
    function DefaultTransparentBorder: Boolean; virtual;

    procedure FontChanged(Sender: TObject); virtual;
    function GetColor: TColor; virtual;
    function GetDefaultStyleController: TcxStyleController; virtual;
    function GetStyleColor: TColor; virtual;
    function GetTextColor: TColor; virtual;
    function GetTextStyle: TFontStyles; virtual;
    function InternalGetColor(var Color: TColor): Boolean;
    function InternalGetNotPublishedExtendedStyleValues: TcxContainerStyleValues; virtual;
    function IsBaseStyle: Boolean;
    function IsDestroying: Boolean;
    function IsFontAssignedValueLocked: Boolean;
    procedure LockFontAssignedValue(ALock: Boolean);
    procedure UpdateFont;
    property ParentStyle: TcxContainerStyle read FParentStyle;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
  public
    StyleData: TcxContainerStyleData;
    constructor Create(AOwner: TPersistent; ADirectAccessMode: Boolean;
      AParentStyle: TcxContainerStyle = nil;
      AState: TcxContainerStateItem = csNormal); reintroduce; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate;
    procedure EndUpdate;
    function GetStyleValue(const APropertyName: string;
      out StyleValue: TcxContainerStyleValue): Boolean;
    function GetStyleValueCount: Integer; virtual;
    function GetStyleValueName(AStyleValue: TcxContainerStyleValue;
      out StyleValueName: string): Boolean; virtual;
    function GetVisibleFont: TFont;
    function HasBorder: Boolean; virtual;
    function IsExtendedStylePropertyPublished(
      const APropertyName: string): Boolean;
    function IsValueAssigned(AValue: TcxContainerStyleValue): Boolean; virtual;
    procedure RestoreDefaults; virtual;
    property ActiveStyleController: TcxStyleController read GetActiveStyleController;
    property BaseStyle: TcxContainerStyle read GetBaseStyle;
    property Container: TcxContainer read GetContainer;
    property DirectAccessMode: Boolean read FDirectAccessMode;
    property State: TcxContainerStateItem read FState;
  published
    property AssignedValues: TcxContainerStyleValues read GetAssignedValues
      write SetAssignedValues stored False;
    property BorderColor: TColor read GetBorderColor write SetBorderColor
      stored IsBorderColorStored;
    property BorderStyle: TcxContainerBorderStyle read GetBorderStyle
      write SetBorderStyle stored IsBorderStyleStored;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property Edges: TcxBorders read GetEdges write SetEdges stored IsEdgesStored;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
    property HotTrack: Boolean read GetHotTrack write SetHotTrack stored IsHotTrackStored;
    property LookAndFeel: TcxLookAndFeel read GetLookAndFeel
      write SetLookAndFeel{$IFDEF CLR} stored IsLookAndFeelStored{$ENDIF};
    property Shadow: Boolean read GetShadow write SetShadow stored IsShadowStored;
    property StyleController: TcxStyleController read BaseGetStyleController
      write BaseSetStyleController stored IsStyleControllerStored;
    property TextColor: TColor read GetTextColor write SetTextColor
      stored IsTextColorStored;
    property TextStyle: TFontStyles read GetTextStyle write SetTextStyle
      stored IsTextStyleStored;
    property TransparentBorder: Boolean read GetTransparentBorder
      write SetTransparentBorder stored IsTransparentBorderStored;
  end;

  TcxCustomContainerStyle = TcxContainerStyle; // TODO Remove

  TcxContainerStyleClass = class of TcxContainerStyle;

  { TcxContainerStyles }

  TcxContainerStyles = class
  private
    FStyles: array[TcxContainerStateItem] of TcxContainerStyle;
    function GetStyle(AState: TcxContainerStateItem): TcxContainerStyle;
    function GetStyleDisabled: TcxContainerStyle;
    function GetStyleFocused: TcxContainerStyle;
    function GetStyleHot: TcxContainerStyle;
    function GetStyleNormal: TcxContainerStyle;
    procedure SetOnChanged(Value: TNotifyEvent);
    procedure SetStyle(AState: TcxContainerStateItem; Value: TcxContainerStyle);
    procedure SetStyleDisabled(Value: TcxContainerStyle);
    procedure SetStyleFocused(Value: TcxContainerStyle);
    procedure SetStyleHot(Value: TcxContainerStyle);
    procedure SetStyleNormal(Value: TcxContainerStyle);
  public
    constructor Create(AOwner: TPersistent;
      AStyleClass: TcxContainerStyleClass); virtual;
    destructor Destroy; override;
    procedure RestoreDefaults;
    property Style: TcxContainerStyle read GetStyleNormal write SetStyleNormal;
    property StyleDisabled: TcxContainerStyle read GetStyleDisabled
      write SetStyleDisabled;
    property StyleFocused: TcxContainerStyle read GetStyleFocused
      write SetStyleFocused;
    property StyleHot: TcxContainerStyle read GetStyleHot
      write SetStyleHot;
    property Styles[AState: TcxContainerStateItem]: TcxContainerStyle
      read GetStyle write SetStyle; default;
    property OnChanged: TNotifyEvent write SetOnChanged;
  end;

  TcxContainerStylesClass = class of TcxContainerStyles;

  { TcxStyleController }

  TcxStyleController = class(TComponent)
  private
    FIsDestruction: Boolean;
    FIsFontScaled: Boolean;
    FListeners: TList;
    FOnStyleChanged: TNotifyEvent;
    function GetFakeStyleController: TcxStyleController;
    function GetStyle: TcxContainerStyle;
    function GetInternalStyle(AState: TcxContainerStateItem): TcxContainerStyle;
    procedure SetFakeStyleController(Value: TcxStyleController);
    procedure SetInternalStyle(AState: TcxContainerStateItem; Value: TcxContainerStyle);
    procedure StyleChanged(Sender: TObject);
  protected
    FStyles: TcxContainerStyles;
    procedure Loaded; override;
    procedure AddListener(AListener: TcxContainerStyle); virtual;
    procedure Changed;
    procedure ChangeFontScale(M, D: Integer);
    function GetStyleClass: TcxContainerStyleClass; virtual;
    function GetStylesClass: TcxContainerStylesClass; virtual;
    function IsDestruction: Boolean;
    procedure RemoveListener(AListener: TcxContainerStyle); virtual;
    property Style: TcxContainerStyle read GetStyle;
    property Listeners: TList read FListeners;
    property OnStyleChanged: TNotifyEvent read FOnStyleChanged write FOnStyleChanged;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RestoreStyles;
    property Styles[AState: TcxContainerStateItem]: TcxContainerStyle
      read GetInternalStyle write SetInternalStyle;
  published
    property FakeStyleController: TcxStyleController read GetFakeStyleController
      write SetFakeStyleController stored False;
  end;

  { IcxContainerInnerControl }

  IcxContainerInnerControl = interface
  ['{1B111318-D9C9-4C35-9EFF-5D95793C0106}']
    function GetControl: TWinControl;
    function GetControlContainer: TcxContainer;
    property Control: TWinControl read GetControl;
    property ControlContainer: TcxContainer read GetControlContainer;
  end;

{$IFNDEF CLR}
  TcxScrollBarInfo = TScrollBarInfo;
{$ELSE}
  TcxScrollBarInfo = packed record
    cbSize: DWORD;
    rcScrollBar: TRect;
    dxyLineButton: Integer;
    xyThumbTop: Integer;
    xyThumbBottom: Integer;
    bogus: Integer;
    [MarshalAs(UnmanagedType.ByValArray, SizeConst = CCHILDREN_SCROLLBAR + 1)]
    rgstate: array[0..CCHILDREN_SCROLLBAR] of DWORD;
  end;
{$ENDIF}

  { TcxContainer }

  TcxContainerActiveStyleData = record
    ContainerState: TcxContainerState;
    ActiveStyle: TcxContainerStyle;
  end;

  TcxContainerInnerControlBounds = record
    IsEmpty: Boolean;
    Rect: TRect;
  end;

  TcxContainer = class(TcxControl{$IFNDEF CLR}, IUnknown{$ENDIF},
    IcxCompoundControl, IcxMouseTrackingCaller)
  private
    FActiveStyleData: TcxContainerActiveStyleData;
    FInnerControl: TWinControl;
    FInnerControlBounds: TcxContainerInnerControlBounds;
    FInnerControlMouseDown: Boolean;
    FIsDestroying: Boolean;
    FIsRefreshLocked: Boolean;
    FIsViewInfoCalculated: Boolean;
    FLockAlignControlsCount: Integer;
    FPopupMenuLockCount: Integer;
    FRefreshingContainer: Boolean;
    FScrollBarsCalculating: Boolean;
    function GetActiveControl: TWinControl;
    function GetActiveStyle: TcxContainerStyle;
    function GetFakeStyleController: TcxStyleController;
    function GetInternalStyle(AState: TcxContainerStateItem): TcxContainerStyle;
    function GetIsDestroying: Boolean;
    function GetStyle: TcxContainerStyle;
    function GetStyleDisabled: TcxContainerStyle;
    function GetStyleFocused: TcxContainerStyle;
    function GetStyleHot: TcxContainerStyle;
    procedure SetFakeStyleController(Value: TcxStyleController);
    procedure SetStyle(Value: TcxContainerStyle);
    procedure SetStyleDisabled(Value: TcxContainerStyle);
    procedure SetStyleFocused(Value: TcxContainerStyle);
    procedure SetStyleHot(Value: TcxContainerStyle);
    procedure SetInternalStyle(AState: TcxContainerStateItem;
      Value: TcxContainerStyle);
    function GetDragKind: TDragKind;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged);
      message WM_WINDOWPOSCHANGED;
    procedure WMWindowPosChanging(var Message: TWMWindowPosChanging);
      message WM_WINDOWPOSCHANGING;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMParentColorChanged(var Message: TMessage); message CM_PARENTCOLORCHANGED;
    procedure CMShortRefreshContainer(var Message: TMessage); message CM_SHORTREFRESHCONTAINER;
{$IFNDEF CLR}
    procedure CMParentFontChanged(var Message: TMessage); message CM_PARENTFONTCHANGED;
{$ELSE}
    procedure CMParentFontChanged(var Message: TCMParentFontChanged); message CM_PARENTFONTCHANGED;
{$ENDIF}
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMUpdateScrollBars(var Message: TMessage); message CM_UPDATESCROLLBARS;
  protected
    FInternalSetting: Boolean;
    FIsCreating: Boolean;
    FStyles: TcxContainerStyles;
    FViewInfo: TcxContainerViewInfo;

    // IcxMouseTrackingCaller
    procedure IcxMouseTrackingCaller.MouseLeave = MouseTrackingCallerMouseLeave;
    procedure MouseTrackingCallerMouseLeave;

    // IcxLookAndFeelContainer
    function GetLookAndFeelValue: TcxLookAndFeel; override;

    procedure AdjustClientRect(var Rect: TRect); override;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    function AllowAutoDragAndDropAtDesignTime(X, Y: Integer;
      Shift: TShiftState): Boolean; override;
    function CanFocusOnClick: Boolean; override;
    procedure ChangeScale(M, D: Integer); override;
    procedure ColorChanged; override;
    procedure CursorChanged; override;
    procedure DoContextPopup(MousePos: TPoint;
      var Handled: Boolean); override;
    procedure DragCanceled; override;
    procedure FocusChanged; override;
    function GetClientBounds: TRect; override;
    function IsContainerFocused: Boolean; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    function MayFocus: Boolean; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseEnter(AControl: TControl); override;
    procedure MouseLeave(AControl: TControl); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    function NeedsScrollBars: Boolean; override;
    procedure Paint; override;
    procedure Resize; override;
    procedure SetDragMode(Value: TDragMode); override;
    procedure CreateHandle; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure WndProc(var Message: TMessage); override;
  {$IFDEF CLR}
    procedure BeginAutoDrag; override;
    procedure Click; override;
    procedure DblClick; override;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
      MousePos: TPoint): Boolean; override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
  {$ENDIF}
    procedure AdjustInnerControl; virtual;
    procedure CalculateViewInfo(const P: TPoint; AMouseTracking: Boolean); virtual;
    function CanContainerHandleTabs: Boolean; virtual;
    function CanHaveTransparentBorder: Boolean; virtual;
    function CanShowPopupMenu(const P: TPoint): Boolean; virtual;
    procedure CheckIsViewInfoCalculated;
    procedure ContainerStyleChanged(Sender: TObject); virtual;
    procedure DataChange; virtual;
    procedure DataSetChange; virtual;
    function DefaultParentColor: Boolean; virtual;
    procedure EnabledChanged; dynamic;
    procedure EndMouseTracking; virtual;
    function GetBorderExtent: TRect; virtual;
    function GetInnerControlBounds(const AInnerControlsRegion: TRect;
      AInnerControl: TControl): TcxContainerInnerControlBounds; virtual;
    function GetShadowBounds: TRect; virtual;
    function GetStyleClass: TcxContainerStyleClass; virtual;
    function GetStylesClass: TcxContainerStylesClass; virtual;
    function GetViewInfoClass: TcxContainerViewInfoClass; virtual;
    function HasShadow: Boolean; virtual;
    function InternalGetActiveStyle: TcxContainerStyle; virtual;
    function InternalGetNotPublishedStyleValues: TcxContainerStyleValues; virtual;
    function IsAlignControlsLocked: Boolean;
    function IsInnerControlBoundsChanged(AControl: TWinControl;
      const ABounds: TcxContainerInnerControlBounds): Boolean;
    function IsContainerClass: Boolean; virtual;
    function IsPopupMenuLocked: Boolean;
    function IsTransparentBackground: Boolean; virtual;
    function RefreshContainer(const P: TPoint; Button: TcxMouseButton; Shift: TShiftState;
      AIsMouseEvent: Boolean): Boolean; virtual;
    procedure SaveInnerControlBounds(AControl: TWinControl;
      const ABounds: TcxContainerInnerControlBounds);
    procedure SetShadowRegion; virtual;
    procedure SetSize; virtual;
    procedure SetVisibleBoundsClipRect; virtual;
    procedure UpdateData; virtual;
    procedure AdjustScrollBarPosition(AScrollBar: TcxScrollBar); virtual;
    function GetBackgroundThemedObjectType: TdxThemedObjectType; virtual;
    function GetBackgroundNativePart: Integer; virtual;
    function GetBackgroundNativeState: Integer; virtual;
    function GetScrollBarBounds(const AScrollBarRect: TRect): TRect; virtual;
    function GetScrollBarEnabled(AScrollBar: TcxScrollBar;
      const AScrollBarinfo: TcxScrollBarInfo): Boolean; virtual;
    function GetScrollBarInfo(var AScrollBarInfo: TcxScrollBarInfo;
      const AKind: TScrollBarKind): Boolean; virtual;
    function IsAdjustingScrollBarPositionNeeded(
      const AScrollBarInfo: TcxScrollBarInfo): Boolean; virtual;
    function IsNativeStyle: Boolean; virtual;
    procedure SafeSelectionFocusInnerControl; virtual;
    procedure SetDragKind(Value: TDragKind); virtual;
    procedure SetScrollBarVisible(AScrollBar: TcxScrollBar;
      AVisible: Boolean); virtual;
    property ActiveStyle: TcxContainerStyle read GetActiveStyle;
    property DragKind: TDragKind read GetDragKind write SetDragKind default dkDrag;
    property IsViewInfoCalculated: Boolean read FIsViewInfoCalculated
      write FIsViewInfoCalculated;
    property ScrollBarsCalculating: Boolean read FScrollBarsCalculating;
    property Style: TcxContainerStyle read GetStyle write SetStyle;
    property StyleDisabled: TcxContainerStyle read GetStyleDisabled
      write SetStyleDisabled;
    property StyleFocused: TcxContainerStyle read GetStyleFocused
      write SetStyleFocused;
    property StyleHot: TcxContainerStyle read GetStyleHot write SetStyleHot;
    property ViewInfo: TcxContainerViewInfo read FViewInfo;
  {$IFDEF CLR}
    property DragMode;
  {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Focused: Boolean; override;
    function GetDragImages: TDragImageList; override;
    procedure GetTabOrderList(List: TList); override;
    procedure SetFocus; override;
    procedure ClearSavedChildControlRegions; virtual;
    function GetVisibleBounds: TRect; virtual;
    function HasPopupWindow: Boolean; virtual;
    function InnerControlDefaultHandler(var Message: TMessage): Boolean; virtual;
    function InnerControlMenuHandler(var Message: TMessage): Boolean; virtual;
    procedure Invalidate; override;
    function IsInplace: Boolean; virtual;
    function IsStylePropertyPublished(const APropertyName: string;
      AExtendedStyle: Boolean): Boolean;
    procedure LockAlignControls(ALock: Boolean);
    procedure LockPopupMenu(ALock: Boolean);
    procedure RestoreStyles;
    procedure SetScrollBarsParameters(AIsScrolling: Boolean = False); virtual;
    function ShortRefreshContainer(AIsMouseEvent: Boolean): Boolean;
    procedure Update; override;
    procedure UpdateScrollBarsParameters;
    property InnerControl: TWinControl read FInnerControl write FInnerControl;
    property InnerControlMouseDown: Boolean read FInnerControlMouseDown
      write FInnerControlMouseDown;
    property IsDestroying: Boolean read GetIsDestroying;
    property ParentColor;
    property ParentFont;
    property Styles[AState: TcxContainerStateItem]: TcxContainerStyle
      read GetInternalStyle write SetInternalStyle;
    property VisibleBounds: TRect read GetVisibleBounds;
  published
    property FakeStyleController: TcxStyleController read GetFakeStyleController
      write SetFakeStyleController stored False;
    property TabStop default True;
  end;

  { TcxCustomPopupWindow }

  TcxCustomPopupWindow = class(TcxPopupWindow)
  private
    FCaptureFocus: Boolean;
    FDeactivateLockCount: Integer;
    FDeactivation: Boolean;
    FFocusedControl: TWinControl;
    FIsTopMost: Boolean;
    FJustClosed: Boolean;
    FModalMode: Boolean;
    FTerminateOnDestroy: Boolean;
    FOwnerControl: TWinControl;
    FOnClosed: TNotifyEvent;
    FOnClosing: TNotifyEvent;
    FOnShowed: TNotifyEvent;
    FOnShowing: TNotifyEvent;
    function GetJustClosed: Boolean;
    procedure SetCaptureFocus(Value: Boolean);
    procedure SetIsTopMost(Value: Boolean);
    procedure WMActivateApp(var Message: TWMActivateApp); message WM_ACTIVATEAPP;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure CMClosePopupWindow(var Message: TMessage); message CM_CLOSEPOPUPWINDOW;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMShowPopupWindow(var Message: TMessage); message CM_SHOWPOPUPWINDOW;
  protected
    FStyle: TcxContainerStyle;
    FViewInfo: TcxContainerViewInfo;
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure Deactivate; override;
    function GetOwnerScreenBounds: TRect; override;
    procedure InitPopup; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Paint; override;
    procedure VisibleChanged; override;
    procedure CreateHandle; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    function AcceptsAnySize: Boolean; virtual;
    procedure DoClosed; virtual;
    procedure DoClosing; virtual;
    procedure DoShowed; virtual;
    procedure DoShowing; virtual;
    function GetFirstFocusControl(AControl: TWinControl): TWinControl;
    function HasBackground: Boolean; virtual;
    function IsDeactivateLocked: Boolean;
    function IsOwnerControlVisible: Boolean;
    function IsSysKeyAccepted(Key: Word): Boolean; virtual;
    procedure ModalCloseUp; virtual;
    procedure MouseEnter(AControl: TControl); dynamic;
    procedure MouseLeave(AControl: TControl); dynamic;
    function NeedIgnoreMouseMessageAfterCloseUp(AMsg: Cardinal;
      AShift: TShiftState; X, Y: Integer): Boolean; virtual;
    procedure PopupWindowStyleChanged(Sender: TObject); virtual;
    procedure RecreateWindow;
    property Style: TcxContainerStyle read FStyle;
    property ViewInfo: TcxContainerViewInfo read FViewInfo;
  public
    constructor Create(AOwnerControl: TWinControl); reintroduce; virtual;
    destructor Destroy; override;
    function Focused: Boolean; override;
{$IFDEF DELPHI5}
    function CanFocus: Boolean; override;
{$ENDIF}
    procedure ClosePopup;
    procedure CloseUp; override;
    procedure CorrectBoundsWithDesktopWorkArea(var APosition: TPoint); virtual;
    function GetStyleClass: TcxContainerStyleClass; virtual;
    function GetViewInfoClass: TcxContainerViewInfoClass; virtual;
    function HasCapture: Boolean;
    function IsVisible: Boolean;
    procedure LockDeactivate(ALock: Boolean);
    procedure Popup(AFocusedControl: TWinControl); reintroduce; virtual;
    property CaptureFocus: Boolean read FCaptureFocus write SetCaptureFocus default True;
    property FocusedControl: TWinControl read FFocusedControl write FFocusedControl;
    property IsTopMost: Boolean read FIsTopMost write SetIsTopMost;
    property JustClosed: Boolean read GetJustClosed;
    property ModalMode: Boolean read FModalMode write FModalMode default True;
    property OwnerControl: TWinControl read FOwnerControl;
    property TerminateOnDestroy: Boolean read FTerminateOnDestroy write FTerminateOnDestroy;
    property OnClosed: TNotifyEvent read FOnClosed write FOnClosed;
    property OnClosing: TNotifyEvent read FOnClosing write FOnClosing;
    property OnCloseQuery;
    property OnShowed: TNotifyEvent read FOnShowed write FOnShowed;
    property OnShowing: TNotifyEvent read FOnShowing write FOnShowing;
  end;

  { TcxCustomInnerListBox }

  TcxCustomInnerListBox = class(TListBox{$IFNDEF CLR}, IUnknown{$ENDIF},
    IcxContainerInnerControl)
  private
  {$IFNDEF DELPHI6}
    FAutoComplete: Boolean;
  {$ENDIF}
  {$IFNDEF DELPHI8}
    FAutoCompleteDelay: Cardinal;
  {$ENDIF}
    FAutoCompleteFilter: string;
    FCanvas: TcxCanvas;
    FHScrollBar: TcxScrollBar;
    FIsRedrawLocked: Boolean;
    FLookAndFeel: TcxLookAndFeel;
    FPrevBrushColor: TColor;
    FPrevFontColor: TColor;
    FPrevKeyPressTime: DWORD;
    FScrollBarsCalculating: Boolean;
    FScrollBarsLockCount: Integer;
    FVScrollBar: TcxScrollBar;
    procedure CreateScrollBars;
    function FindAutoCompleteString(const S: string): Integer;
    function GetControlContainer: TcxContainer;
    function GetControl: TWinControl;
    procedure HScrollHandler(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure SetLookAndFeel(Value: TcxLookAndFeel);
    procedure VScrollHandler(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
{$IFNDEF DELPHI6}
    function GetScrollWidth: Integer;
    procedure SetScrollWidth(const Value: Integer);
{$ENDIF}
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMPrint(var Message: TWMPrint); message WM_PRINT;
    procedure WMPrintClient(var Message: TWMPrintClient); message WM_PRINTCLIENT;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMSetRedraw(var Message: TWMSetRedraw); message WM_SETREDRAW;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
  protected
    FContainer: TcxContainer;
    procedure Click; override;
    procedure DblClick; override;
    procedure DestroyWindowHandle; override;
    procedure DoAutoComplete(var Key: Char); virtual;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
      MousePos: TPoint): Boolean; override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    function GetPopupMenu: TPopupMenu; override;
    function GetSizeGripRect: TRect;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel;
      AChangedValues: TcxLookAndFeelValues); virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseEnter(AControl: TControl); dynamic;
    procedure MouseLeave(AControl: TControl); dynamic;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure DrawSizeGrip(ADC: HDC);
    function NeedDrawFocusRect: Boolean; virtual;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure RestoreCanvasParametersForFocusRect;
    procedure SaveCanvasParametersForFocusRect;
    procedure WndProc(var Message: TMessage); override;
    property Container: TcxContainer read FContainer write FContainer;
    property IsRedrawLocked: Boolean read FIsRedrawLocked;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DefaultHandler(var Message); override;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure SetExternalScrollBarsParameters; virtual;
{$IFNDEF DELPHI6}
    procedure AddItem(AItem: string; AObject: TObject);
    procedure ClearSelection;
    procedure DeleteSelected;
    procedure SelectAll;
{$ENDIF}
    function ItemVisible(Index: Integer): Boolean;
    property Canvas: TcxCanvas read FCanvas;
    property HScrollBar: TcxScrollBar read FHScrollBar;
    property LookAndFeel: TcxLookAndFeel read FLookAndFeel write SetLookAndFeel;
    property VScrollBar: TcxScrollBar read FVScrollBar;
{$IFNDEF DELPHI6}
    property ScrollWidth: Integer read GetScrollWidth write SetScrollWidth default 0;
{$ENDIF}
  published
  {$IFNDEF DELPHI6}
    property AutoComplete: Boolean read FAutoComplete write FAutoComplete default True;
  {$ENDIF}
  {$IFNDEF DELPHI8}
    property AutoCompleteDelay: Cardinal read FAutoCompleteDelay
      write FAutoCompleteDelay default cxDefaultAutoCompleteDelay;
  {$ENDIF}
  end;

  TcxCustomListBox = TcxCustomInnerListBox; // TODO Remove

{$IFNDEF CLR}
  TGetScrollBarInfo = function(hwnd: HWND; idObject: Longint;
    var psbi: TScrollBarInfo): BOOL; cdecl stdcall;
{$ENDIF}

{$IFNDEF CLR}
  { _TWinControlAccess }

  _TWinControlAccess = class
  public
    class procedure _RecreateWnd(AInstance: TWinControl);
  end;
{$ELSE}
  { TcxCustomAccess }

  TcxCustomAccess = class
  protected
    class procedure CheckEventInfo(const AName: string;
      var AEventInfo: EventInfo);
    class procedure CheckFieldInfo(const AName: string;
      var AFieldInfo: FieldInfo);
    class procedure CheckMethodInfo(const AName: string;
      var AMethodInfo: MethodInfo);
    class procedure CheckPropertyInfo(const AName: string;
      var APropertyInfo: PropertyInfo);
    class function GetInstanceType: System.Type; virtual;
    class procedure SetEventHandler(AInstance: TObject; AEventInfo: EventInfo;
      ATarget: TObject; const AMethodName: string);
  end;

  { TCanvasAccess }

  TCanvasAccess = class(TcxCustomAccess)
  private
    class var RequiredState_MethodInfo: MethodInfo;
  protected
    class function GetInstanceType: System.Type; override;
  public
    class procedure _RequiredState(AInstance: TCanvas; ReqState: TCanvasState);
  end;

  { TControlAccess }

  TControlAccess = class(TcxCustomAccess)
  private
    class var AdjustSize_MethodInfo: MethodInfo;
    class var DoContextPopup_MethodInfo: MethodInfo;
    class var DoMouseWheel_MethodInfo: MethodInfo;
    class var SendCancelMode_MethodInfo: MethodInfo;
    class var UpdateBoundsRect_MethodInfo: MethodInfo;
    class var DragCursor_PropertyInfo: PropertyInfo;
    class var MouseCapture_PropertyInfo: PropertyInfo;
    class var ParentShowHint_PropertyInfo: PropertyInfo;
    class var OnDragDrop_EventInfo: EventInfo;
    class var OnDragOver_EventInfo: EventInfo;
    class var OnMouseDown_EventInfo: EventInfo;
    class var OnMouseMove_EventInfo: EventInfo;
    class var OnMouseUp_EventInfo: EventInfo;
    class var OnMouseWheel_EventInfo: EventInfo;
  protected
    class function GetInstanceType: System.Type; override;
  public
    class procedure _AdjustSize(AInstance: TControl);
    class procedure _DoContextPopup(AInstance: TControl; MousePos: TPoint;
      var Handled: Boolean);
    class function _DoMouseWheel(AInstance: TControl; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint): Boolean;
    class procedure _SendCancelMode(AInstance: TControl; Sender: TControl);
    class procedure _UpdateBoundsRect(AInstance: TControl; const R: TRect);

    class procedure _SetDragCursor(AInstance: TControl; Value: TCursor);
    class procedure _SetMouseCapture(AInstance: TControl; Value: Boolean);
    class procedure _SetParentShowHint(AInstance: TControl; Value: Boolean);
    class procedure _SetOnDragDrop(AInstance: TControl; ATarget: TObject;
      const AMethodName: string);
    class procedure _SetOnDragOver(AInstance: TControl; ATarget: TObject;
      const AMethodName: string);
    class procedure _SetOnMouseDown(AInstance: TControl; ATarget: TObject;
      const AMethodName: string);
    class procedure _SetOnMouseMove(AInstance: TControl; ATarget: TObject;
      const AMethodName: string);
    class procedure _SetOnMouseUp(AInstance: TControl; ATarget: TObject;
      const AMethodName: string);
    class procedure _SetOnMouseWheel(AInstance: TControl; ATarget: TObject;
      const AMethodName: string);
  end;

  { TCustomFormAccess }

  TCustomFormAccess = class(TcxCustomAccess)
  private
    class var AlphaBlend_PropertyInfo: PropertyInfo;
    class var AlphaBlendValue_PropertyInfo: PropertyInfo;
    class var ClientHandle_PropertyInfo: PropertyInfo;
    class var TransparentColor_PropertyInfo: PropertyInfo;
    class var TransparentColorValue_PropertyInfo: PropertyInfo;
  protected
    class function GetInstanceType: System.Type; override;
  public
    class function _GetAlphaBlend(AInstance: TCustomForm): Boolean;
    class function _GetAlphaBlendValue(AInstance: TCustomForm): Byte;
    class function _GetClientHandle(AInstance: TCustomForm): HWND;
    class function _GetTransparentColor(AInstance: TCustomForm): Boolean;
    class function _GetTransparentColorValue(AInstance: TCustomForm): TColor;
  end;

  { TWinControlAccess }

  TWinControlAccess = class(TcxCustomAccess)
  private
    class var Ctl3D_PropertyInfo: PropertyInfo;
    class var DragKind_PropertyInfo: PropertyInfo;
    class var ParentBackground_PropertyInfo: PropertyInfo;
    class var DragCanceled_MethodInfo: MethodInfo;
    class var PaintControls_MethodInfo: MethodInfo;
    class var PaintWindow_MethodInfo: MethodInfo;
    class var RecreateWnd_MethodInfo: MethodInfo;
    class var SelectNext_MethodInfo: MethodInfo;
    class var OnKeyDown_EventInfo: EventInfo;
    class var OnKeyPress_EventInfo: EventInfo;
    class var OnKeyUp_EventInfo: EventInfo;
  protected
    class function GetInstanceType: System.Type; override;
  public
    class procedure _DragCanceled(AInstance: TWinControl);
    class procedure _PaintControls(AInstance: TWinControl; DC: HDC;
      First: TControl);
    class procedure _PaintWindow(AInstance: TWinControl; DC: HDC);
    class procedure _RecreateWnd(AInstance: TWinControl);
    class procedure _SelectNext(AInstance: TWinControl; CurControl: TWinControl;
      GoForward, CheckTabStop: Boolean);

    class function _GetCtl3D(AInstance: TWinControl): Boolean;
    class procedure _SetDragKind(AInstance: TWinControl; Value: TDragKind);
    class procedure _SetParentBackground(AInstance: TWinControl; Value: Boolean);
    class procedure _SetOnKeyDown(AInstance: TControl; ATarget: TObject;
      const AMethodName: string);
    class procedure _SetOnKeyPress(AInstance: TControl; ATarget: TObject;
      const AMethodName: string);
    class procedure _SetOnKeyUp(AInstance: TControl; ATarget: TObject;
      const AMethodName: string);
  end;

  _TWinControlAccess = TWinControlAccess;
{$ENDIF}

  { _TcxContainerAccess }

  _TcxContainerAccess = class
  public
    class procedure BeginAutoDrag(AInstance: TcxContainer);
    class procedure Click(AInstance: TcxContainer);
    class procedure DblClick(AInstance: TcxContainer);
    class function DoMouseWheel(AInstance: TcxContainer; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint): Boolean;
    class procedure DragOver(AInstance: TcxContainer; Source: TObject;
      X, Y: Integer; State: TDragState; var Accept: Boolean);
    class procedure KeyDown(AInstance: TcxContainer; var Key: Word;
      Shift: TShiftState);
    class procedure KeyPress(AInstance: TcxContainer; var Key: Char);
    class procedure KeyUp(AInstance: TcxContainer; var Key: Word;
      Shift: TShiftState);
    class procedure MouseDown(AInstance: TcxContainer; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    class procedure MouseMove(AInstance: TcxContainer; Shift: TShiftState;
      X, Y: Integer);
    class procedure MouseUp(AInstance: TcxContainer; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  end;

procedure AssignFonts(AFont1, AFont2: TFont);
function ButtonTocxButton(Button: TMouseButton): TcxMouseButton;
function CanShowHint(AControl: TWinControl): Boolean;
function CheckParentsNativeHandle(AControl: TWinControl;
  ANativeHandle: TcxNativeHandle): Boolean;
function cxGetScrollBarInfo(hwnd: HWND; idObject: Longint;
  var psbi: TcxScrollBarInfo): BOOL;
function DefaultContainerStyleController: TcxStyleController;
procedure DrawContainerShadow(ACanvas: TcxCanvas; const ARect: TRect);
procedure ExtendRectByBorders(var R: TRect; ABorderWidth: Integer; AEdges: TcxBorders);
function FindFirstNonChildParentWindow(AWnd: HWND): HWND;
function GetContainerBorderWidth(ABorderStyle: TcxContainerBorderStyle): Integer; overload;
function GetContainerBorderWidth(ALookAndFeelKind: TcxLookAndFeelKind): Integer; overload;
function GetControlRect(AControl: TControl): TRect;
function GetcxContainer(AControl: TWinControl): TcxContainer;
function GetPopupOwnerControl(AWnd: HWND): HWND;
function HasHandle(AControl: TWinControl; AHandle: TcxHandle): Boolean;
function HasNativeHandle(AControl: TWinControl;
  ANativeHandle: TcxNativeHandle; ACheckChildren: Boolean = False): Boolean;
function HasOpenedPopupWindow(AControl: TWinControl): Boolean;
procedure InflateRectByBorders(var R: TRect; ABorderWidth: Integer;
  AEdges: TcxBorders);
function InternalCompareString(const S1, S2: TCaption;
  ACaseSensitive: Boolean): Boolean;
function InternalGetCursorPos: TPoint;
function InternalGetShiftState: TShiftState;
procedure InternalInvalidate(AHandle: TcxHandle; const AOuterRect, AInternalRect: TRect;
  AEraseBackground: Boolean = False);
procedure InternalInvalidateRect(AControl: TWinControl; const R: TRect;
  AEraseBackground: Boolean);
function InternalIsWindowVisible(AControl: TWinControl): Boolean;
function IsChildWindow(AParent: TWinControl; AChildHandle: TcxNativeHandle): Boolean;
function KillMessages(AWnd: HWND; AMsgFilterMin, AMsgFilterMax: UINT;
  AKillAllMessages: Boolean = True): Boolean;
function MouseButtonToShift(Button: TMouseButton): TShiftState;
function NativeHandle(Handle: TcxHandle): TcxNativeHandle;
function ScreenCanvas: TcxScreenCanvas;
procedure SetWindowRegion(AControl: TWinControl;
  const ABounds: TcxContainerInnerControlBounds);
procedure SetWindowShadowRegion(AWindowHandle: TcxHandle; const R: TRect;
  ANativeStyle, AShadow: Boolean; const AExcludeRect: TRect);
function UsecxScrollBars: Boolean;
function AreVisualStylesMustBeUsed(ANativeStyle: Boolean; AThemedObjectType:
  TdxThemedObjectType): Boolean;
function GetSizeGripRect(AControl: IcxContainerInnerControl): TRect;

{$IFNDEF CLR}
procedure DisableWindow(AWindowList: TList; AWnd: HWND);
procedure EnableWindows(AWindowList: TList);

procedure DisableAppWindows(ANeedDisable: Boolean = True);
procedure EnableAppWindows;
function IsInternalWindowsDisabled: Boolean;
function IsInternalWindowsDisabling: Boolean;
{$ENDIF}

var
  cxContainerDefaultStyleController: TcxStyleController;
  cxContainerShadowColor: TColor = clBtnShadow;
  TopMostComboBoxes: Boolean = True;

implementation

uses
{$IFDEF CLR}
  Types, TypInfo,
{$ENDIF}
  dxOffice11;

const
  cxContainerBorderWidthA1: array [TcxContainerBorderStyle] of Integer =
    (0, 1, 2, 2, 2, 1, 1);
  cxContainerBorderWidthA2: array [TcxLookAndFeelKind] of Integer =
    (2, 2, 1, 1);

{$IFNDEF CLR}
type
  TCanvasAccess = class(TCanvas);
{$ENDIF}

{$IFDEF CLR}
[DllImport(user32, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'GetScrollBarInfo')]
function GetScrollBarInfo(hwnd: HWND; idObject: Longint;
  var psbi: TcxScrollBarInfo): BOOL; external;
{$ENDIF}

{$IFNDEF CLR}
type
  TCustomFormAccess = class(TCustomForm);
  TWinControlAccess = class(TWinControl);
{$ENDIF}

var
  FBeingShownPopupWindow: TcxPopupWindow;
  FPopupWindowShowing: Boolean = False;
  FScreenCanvas: TcxScreenCanvas;
  FShiftState: TShiftState;
  FUsecxScrollBars: Boolean;
  FVisiblePopupWindowList: TList;
  FApplicationCallWndProcHook: HHOOK = 0;
  FApplicationGetMessageMsgHook: HHOOK = 0;
  FApplicationMouseMsgHook: HHOOK = 0;
  FCaptionInactivationLocked: Boolean;
  FOldWndProc: {$IFDEF CLR}IntPtr{$ELSE}Pointer{$ENDIF};
{$IFNDEF CLR}
  GetScrollBarInfoProc: TGetScrollBarInfo = nil;
{$ENDIF}

{$IFNDEF CLR}
{ _TWinControlAccess }

class procedure _TWinControlAccess._RecreateWnd(AInstance: TWinControl);
begin
  TWinControlAccess(AInstance).RecreateWnd;
end;
{$ENDIF}

{$IFDEF CLR}
procedure CheckEventInfo(AType: System.Type; const AName: string;
  var AEventInfo: EventInfo);
var
  AFlags: System.Reflection.BindingFlags;
begin
  if AEventInfo = nil then
  begin
    AFlags := System.Reflection.BindingFlags.Instance or
      System.Reflection.BindingFlags.NonPublic;
    AEventInfo := AType.GetEvent(AName, AFlags);
  end;
end;

procedure CheckFieldInfo(AType: System.Type; const AName: string;
  var AFieldInfo: FieldInfo);
var
  AFlags: System.Reflection.BindingFlags;
begin
  if AFieldInfo = nil then
  begin
    AFlags := System.Reflection.BindingFlags.Instance or
      System.Reflection.BindingFlags.NonPublic;
    AFieldInfo := AType.GetField(AName, AFlags);
  end;
end;

procedure CheckMethodInfo(AType: System.Type; const AName: string;
  var AMethodInfo: MethodInfo);
var
  AFlags: System.Reflection.BindingFlags;
begin
  if AMethodInfo = nil then
  begin
    AFlags := System.Reflection.BindingFlags.Instance or
      System.Reflection.BindingFlags.NonPublic;
    AMethodInfo := AType.GetMethod(AName, AFlags);
  end;
end;

procedure CheckPropertyInfo(AType: System.Type; const AName: string;
  var APropertyInfo: PropertyInfo);
var
  AFlags: System.Reflection.BindingFlags;
begin
  if APropertyInfo = nil then
  begin
    AFlags := System.Reflection.BindingFlags.Instance or
      System.Reflection.BindingFlags.NonPublic;
    APropertyInfo := AType.GetProperty(AName, AFlags);
  end;
end;

{ TcxCustomAccess }

class procedure TcxCustomAccess.CheckEventInfo(const AName: string;
  var AEventInfo: EventInfo);
begin
  cxContainer.CheckEventInfo(GetInstanceType, AName, AEventInfo);
end;

class procedure TcxCustomAccess.CheckFieldInfo(const AName: string;
  var AFieldInfo: FieldInfo);
begin
  cxContainer.CheckFieldInfo(GetInstanceType, AName, AFieldInfo);
end;

class procedure TcxCustomAccess.CheckMethodInfo(const AName: string;
  var AMethodInfo: MethodInfo);
begin
  cxContainer.CheckMethodInfo(GetInstanceType, AName, AMethodInfo);
end;

class procedure TcxCustomAccess.CheckPropertyInfo(const AName: string;
  var APropertyInfo: PropertyInfo);
begin
  cxContainer.CheckPropertyInfo(GetInstanceType, AName, APropertyInfo);
end;

class function TcxCustomAccess.GetInstanceType: System.Type;
begin
  Result := nil;
end;

class procedure TcxCustomAccess.SetEventHandler(AInstance: TObject;
  AEventInfo: EventInfo; ATarget: TObject; const AMethodName: string);
var
  ADelegate: Delegate;
  AParams: array of TObject;
begin
  ADelegate := Delegate.CreateDelegate(AEventInfo.EventHandlerType, ATarget,
    AMethodName);
  SetLength(AParams, 1);
  AParams[0] := ADelegate;
  AEventInfo.GetAddMethod(True).Invoke(AInstance, [ADelegate]{AParams});
end;

{ TCanvasAccess }

class procedure TCanvasAccess._RequiredState(AInstance: TCanvas;
  ReqState: TCanvasState);
begin
  CheckMethodInfo('RequiredState', RequiredState_MethodInfo);
  RequiredState_MethodInfo.Invoke(AInstance, [ReqState]);
end;

class function TCanvasAccess.GetInstanceType: System.Type;
begin
  Result := TypeOf(TCanvas);
end;

{ TControlAccess }

class procedure TControlAccess._AdjustSize(AInstance: TControl);
begin
  CheckMethodInfo('AdjustSize', AdjustSize_MethodInfo);
  AdjustSize_MethodInfo.Invoke(AInstance, []);
end;

class procedure TControlAccess._DoContextPopup(AInstance: TControl;
  MousePos: TPoint; var Handled: Boolean);
begin
  CheckMethodInfo('DoContextPopup', DoContextPopup_MethodInfo);
  DoContextPopup_MethodInfo.Invoke(AInstance, [MousePos, Handled]);
end;

class function TControlAccess._DoMouseWheel(AInstance: TControl;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;
begin
  CheckMethodInfo('DoMouseWheel', DoMouseWheel_MethodInfo);
  Result := Boolean(DoMouseWheel_MethodInfo.Invoke(AInstance,
    [Shift, WheelDelta, MousePos]));
end;

class procedure TControlAccess._SendCancelMode(AInstance: TControl;
  Sender: TControl);
begin
  CheckMethodInfo('SendCancelMode', SendCancelMode_MethodInfo);
  SendCancelMode_MethodInfo.Invoke(AInstance, [Sender]);
end;

class procedure TControlAccess._UpdateBoundsRect(AInstance: TControl;
  const R: TRect);
begin
  CheckMethodInfo('UpdateBoundsRect', UpdateBoundsRect_MethodInfo);
  UpdateBoundsRect_MethodInfo.Invoke(AInstance, [R]);
end;

class procedure TControlAccess._SetDragCursor(AInstance: TControl;
  Value: TCursor);
begin
  CheckPropertyInfo('DragCursor', DragCursor_PropertyInfo);
  DragCursor_PropertyInfo.SetValue(AInstance, TObject(Value), []);
end;

class procedure TControlAccess._SetMouseCapture(AInstance: TControl;
  Value: Boolean);
begin
  CheckPropertyInfo('MouseCapture', MouseCapture_PropertyInfo);
  MouseCapture_PropertyInfo.SetValue(AInstance, TObject(Value), []);
end;

class procedure TControlAccess._SetParentShowHint(AInstance: TControl;
  Value: Boolean);
begin
  CheckPropertyInfo('ParentShowHint', ParentShowHint_PropertyInfo);
  ParentShowHint_PropertyInfo.SetValue(AInstance, TObject(Value), []);
end;

class procedure TControlAccess._SetOnDragDrop(AInstance: TControl;
  ATarget: TObject; const AMethodName: string);
begin
  CheckEventInfo('OnDragDrop', OnDragDrop_EventInfo);
  SetEventHandler(AInstance, OnDragDrop_EventInfo, ATarget, AMethodName);
end;

class procedure TControlAccess._SetOnDragOver(AInstance: TControl;
  ATarget: TObject; const AMethodName: string);
begin
  CheckEventInfo('OnDragOver', OnDragOver_EventInfo);
  SetEventHandler(AInstance, OnDragOver_EventInfo, ATarget, AMethodName);
end;

class procedure TControlAccess._SetOnMouseDown(AInstance: TControl;
  ATarget: TObject; const AMethodName: string);
begin
  CheckEventInfo('OnMouseDown', OnMouseDown_EventInfo);
  SetEventHandler(AInstance, OnMouseDown_EventInfo, ATarget, AMethodName);
end;

class procedure TControlAccess._SetOnMouseMove(AInstance: TControl;
  ATarget: TObject; const AMethodName: string);
begin
  CheckEventInfo('OnMouseMove', OnMouseMove_EventInfo);
  SetEventHandler(AInstance, OnMouseMove_EventInfo, ATarget, AMethodName);
end;

class procedure TControlAccess._SetOnMouseUp(AInstance: TControl;
  ATarget: TObject; const AMethodName: string);
begin
  CheckEventInfo('OnMouseUp', OnMouseUp_EventInfo);
  SetEventHandler(AInstance, OnMouseUp_EventInfo, ATarget, AMethodName);
end;

class procedure TControlAccess._SetOnMouseWheel(AInstance: TControl;
  ATarget: TObject; const AMethodName: string);
begin
  CheckEventInfo('OnMouseWheel', OnMouseWheel_EventInfo);
  SetEventHandler(AInstance, OnMouseWheel_EventInfo, ATarget, AMethodName);
end;

class function TControlAccess.GetInstanceType: System.Type;
begin
  Result := TypeOf(TControl);
end;

{ TCustomFormAccess }

class function TCustomFormAccess._GetAlphaBlend(AInstance: TCustomForm): Boolean;
begin
  CheckPropertyInfo('AlphaBlend', AlphaBlend_PropertyInfo);
  Result := Boolean(AlphaBlend_PropertyInfo.GetValue(AInstance, []));
end;

class function TCustomFormAccess._GetAlphaBlendValue(AInstance: TCustomForm): Byte;
begin
  CheckPropertyInfo('AlphaBlendValue', AlphaBlendValue_PropertyInfo);
  Result := Byte(AlphaBlendValue_PropertyInfo.GetValue(AInstance, []));
end;

class function TCustomFormAccess._GetClientHandle(AInstance: TCustomForm): HWND;
begin
  CheckPropertyInfo('ClientHandle', ClientHandle_PropertyInfo);
  Result := HWND(ClientHandle_PropertyInfo.GetValue(AInstance, []));
end;

class function TCustomFormAccess._GetTransparentColor(AInstance: TCustomForm): Boolean;
begin
  CheckPropertyInfo('TransparentColor', TransparentColor_PropertyInfo);
  Result := Boolean(TransparentColor_PropertyInfo.GetValue(AInstance, []));
end;

class function TCustomFormAccess._GetTransparentColorValue(AInstance: TCustomForm): TColor;
begin
  CheckPropertyInfo('TransparentColorValue', TransparentColorValue_PropertyInfo);
  Result := TColor(TransparentColorValue_PropertyInfo.GetValue(AInstance, []));
end;

class function TCustomFormAccess.GetInstanceType: System.Type;
begin
  Result := TypeOf(TCustomForm);
end;

{ TWinControlAccess }

class procedure TWinControlAccess._DragCanceled(AInstance: TWinControl);
begin
  CheckMethodInfo('DragCanceled', DragCanceled_MethodInfo);
  DragCanceled_MethodInfo.Invoke(AInstance, []);
end;

class procedure TWinControlAccess._PaintControls(AInstance: TWinControl;
  DC: HDC; First: TControl);
begin
  CheckMethodInfo('PaintControls', PaintControls_MethodInfo);
  PaintControls_MethodInfo.Invoke(AInstance, [DC, First]);
end;

class procedure TWinControlAccess._PaintWindow(AInstance: TWinControl; DC: HDC);
begin
  CheckMethodInfo('PaintWindow', PaintWindow_MethodInfo);
  PaintWindow_MethodInfo.Invoke(AInstance, [DC]);
end;

class procedure TWinControlAccess._RecreateWnd(AInstance: TWinControl);
begin
  CheckMethodInfo('RecreateWnd', RecreateWnd_MethodInfo);
  RecreateWnd_MethodInfo.Invoke(AInstance, []);
end;

class procedure TWinControlAccess._SelectNext(AInstance: TWinControl;
  CurControl: TWinControl; GoForward, CheckTabStop: Boolean);
begin
  CheckMethodInfo('SelectNext', SelectNext_MethodInfo);
  SelectNext_MethodInfo.Invoke(AInstance, [CurControl, GoForward, CheckTabStop]);
end;

class function TWinControlAccess._GetCtl3D(AInstance: TWinControl): Boolean;
begin
  CheckPropertyInfo('Ctl3D', Ctl3D_PropertyInfo);
  Result := Boolean(Ctl3D_PropertyInfo.GetValue(AInstance, []));
end;

class procedure TWinControlAccess._SetDragKind(AInstance: TWinControl;
  Value: TDragKind);
begin
  CheckPropertyInfo('DragKind', DragKind_PropertyInfo);
  DragKind_PropertyInfo.SetValue(AInstance, Value, []);
end;

class procedure TWinControlAccess._SetParentBackground(AInstance: TWinControl; Value: Boolean);
begin
  CheckPropertyInfo('ParentBackground', ParentBackground_PropertyInfo);
  ParentBackground_PropertyInfo.SetValue(AInstance, TObject(Value), []);
end;

class procedure TWinControlAccess._SetOnKeyDown(AInstance: TControl;
  ATarget: TObject; const AMethodName: string);
begin
  CheckEventInfo('OnKeyDown', OnKeyDown_EventInfo);
  SetEventHandler(AInstance, OnKeyDown_EventInfo, ATarget, AMethodName);
end;

class procedure TWinControlAccess._SetOnKeyPress(AInstance: TControl;
  ATarget: TObject; const AMethodName: string);
begin
  CheckEventInfo('OnKeyPress', OnKeyPress_EventInfo);
  SetEventHandler(AInstance, OnKeyPress_EventInfo, ATarget, AMethodName);
end;

class procedure TWinControlAccess._SetOnKeyUp(AInstance: TControl;
  ATarget: TObject; const AMethodName: string);
begin
  CheckEventInfo('OnKeyUp', OnKeyUp_EventInfo);
  SetEventHandler(AInstance, OnKeyUp_EventInfo, ATarget, AMethodName);
end;

class function TWinControlAccess.GetInstanceType: System.Type;
begin
  Result := TypeOf(TWinControl);
end;
{$ENDIF}

{ _TcxContainerAccess }

class procedure _TcxContainerAccess.BeginAutoDrag(AInstance: TcxContainer);
begin
  AInstance.BeginAutoDrag;
end;

class procedure _TcxContainerAccess.Click(AInstance: TcxContainer);
begin
  AInstance.Click;
end;

class procedure _TcxContainerAccess.DblClick(AInstance: TcxContainer);
begin
  AInstance.DblClick;
end;

class function _TcxContainerAccess.DoMouseWheel(AInstance: TcxContainer;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;
begin
  Result := AInstance.DoMouseWheel(Shift, WheelDelta, MousePos);
end;

class procedure _TcxContainerAccess.DragOver(AInstance: TcxContainer;
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  AInstance.DragOver(Source, X, Y, State, Accept);
end;

class procedure _TcxContainerAccess.KeyDown(AInstance: TcxContainer;
  var Key: Word; Shift: TShiftState);
begin
  AInstance.KeyDown(Key, Shift);
end;

class procedure _TcxContainerAccess.KeyPress(AInstance: TcxContainer;
  var Key: Char);
begin
  AInstance.KeyPress(Key);
end;

class procedure _TcxContainerAccess.KeyUp(AInstance: TcxContainer; var Key: Word;
  Shift: TShiftState);
begin
  AInstance.KeyUp(Key, Shift);
end;

class procedure _TcxContainerAccess.MouseDown(AInstance: TcxContainer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  AInstance.MouseDown(Button, Shift, X, Y);
end;

class procedure _TcxContainerAccess.MouseMove(AInstance: TcxContainer;
  Shift: TShiftState; X, Y: Integer);
begin
  AInstance.MouseMove(Shift, X, Y);
end;

class procedure _TcxContainerAccess.MouseUp(AInstance: TcxContainer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  AInstance.MouseUp(Button, Shift, X, Y);
end;

procedure AssignFonts(AFont1, AFont2: TFont);
begin
{$IFDEF DELPHI9}
  {$IFDEF CLR}
  if (AFont1.Height <> AFont2.Height) or (AFont1.Style <> AFont2.Style) or
    (AFont1.Charset <> AFont2.Charset) or (AFont1.Name <> AFont2.Name) or
    (AFont1.Color <> AFont2.Color) or (AFont1.Size <> AFont2.Size) or
    (AFont1.Orientation <> AFont2.Orientation) then
  {$ENDIF}
{$ENDIF}
      AFont1.Assign(AFont2);
end;

function ButtonTocxButton(Button: TMouseButton): TcxMouseButton;
const
  AButtonMap: array[TMouseButton] of TcxMouseButton = (cxmbLeft, cxmbRight, cxmbMiddle);
begin
  Result := AButtonMap[Button];
end;

function CanShowHint(AControl: TWinControl): Boolean;

  function GetForm(AWnd: HWND; out AForm: TCustomForm;
    out AFormStyle: TFormStyle): Boolean;
  var
    AControl: TWinControl;
  begin
    AControl := FindControl(AWnd);
    Result := AControl is TCustomForm;
    if Result then
    begin
      AForm := TCustomForm(AControl);
    {$IFNDEF CLR}
      AFormStyle := TCustomFormAccess(AForm).FormStyle;
    {$ELSE}
      AFormStyle := (AForm as IMDIForm).GetFormStyle;
    {$ENDIF}
    end;
  end;

  function GetRootParent(AWnd: HWND): HWND;
  var
    AFormStyle: TFormStyle;
    AParentForm: TCustomForm;
  begin
    repeat
      Result := GetParent(AWnd);
      if Result = 0 then
        Break;
      AWnd := Result;
      if GetForm(AWnd, AParentForm, AFormStyle) and
        (AFormStyle = fsMDIChild) then
          Break;
    until False;
    Result := AWnd;
  end;

var
  AForm: TCustomForm;
  AFormStyle: TFormStyle;
  ARootParent: HWND;
begin
  Result := Application.Active and AControl.HandleAllocated and
    IsWindowVisible(AControl.Handle) and
    (FindVCLWindow(GetMouseCursorPos) = AControl);
  if Result then
  begin
    ARootParent := GetRootParent(AControl.Handle);
    Result := not GetForm(ARootParent, AForm, AFormStyle) or
      AForm.Active or (AFormStyle = fsMDIForm) or (FVisiblePopupWindowList.Count > 0) and
      IsChild(ARootParent, TcxCustomPopupWindow(FVisiblePopupWindowList[0]).OwnerControl.Handle);
  end;
end;

function CheckParentsNativeHandle(AControl: TWinControl;
  ANativeHandle: TcxNativeHandle): Boolean;
var
  AParentForm: TCustomForm;
  AParentHandle, AParentHandle1: HWND;
begin
  Result := False;
  if AControl = nil then
    Exit;
  AParentForm := GetParentForm(AControl);
  if AParentForm = nil then
    Exit;
  Result := HasNativeHandle(AParentForm, ANativeHandle, True);
  if not Result and (AParentForm.Parent = nil) then
  begin
    AParentHandle := AParentForm.Handle;
    repeat
      AParentHandle1 := GetParent(AParentHandle);
      if (AParentHandle1 = 0) or not IsChild(AParentHandle1, AParentHandle) then
        Break;
      AParentHandle := AParentHandle1;
    until False;
    if AParentHandle <> AParentForm.Handle then
      Result := (AParentHandle = ANativeHandle) or IsChild(AParentHandle, ANativeHandle);
  end;
end;

function cxGetScrollBarInfo(hwnd: HWND; idObject: Longint;
  var psbi: TcxScrollBarInfo): BOOL;
begin
{$IFNDEF CLR}
  psbi.cbSize := SizeOf(psbi);
{$ELSE}
  psbi.cbSize := Marshal.SizeOf(TypeOf(TcxScrollBarInfo));
{$ENDIF}
  Result := {$IFDEF CLR}GetScrollBarInfo{$ELSE}GetScrollBarInfoProc{$ENDIF}(hwnd, idObject, psbi);
end;

function DefaultContainerStyleController: TcxStyleController;
begin
  Result := cxContainerDefaultStyleController;
end;

procedure DrawContainerShadow(ACanvas: TcxCanvas; const ARect: TRect);
var
  R: TRect;
begin
  with ACanvas do
  begin
    Brush.Color := cxContainerShadowColor;
    with R do
    begin
      Left := ARect.Left + cxContainerShadowWidth;
      Top := ARect.Bottom;
      Right := ARect.Right;
      Bottom := Top + cxContainerShadowWidth;
      FillRect(R);
      ExcludeClipRect(R);

      Left := ARect.Right;
      Top := ARect.Top + cxContainerShadowWidth;
      Right := Left + cxContainerShadowWidth;
      Bottom := ARect.Bottom + cxContainerShadowWidth;
      FillRect(R);
      ExcludeClipRect(R);
    end;
  end;
end;

procedure ExtendRectByBorders(var R: TRect; ABorderWidth: Integer; AEdges: TcxBorders);
begin
  if bLeft in AEdges then
    Dec(R.Left, ABorderWidth);
  if bTop in AEdges then
    Dec(R.Top, ABorderWidth);
  if bRight in AEdges then
    Inc(R.Right, ABorderWidth);
  if bBottom in AEdges then
    Inc(R.Bottom, ABorderWidth);
end;

function FindFirstNonChildParentWindow(AWnd: HWND): HWND;
begin
  Result := 0;
  while (AWnd <> 0) and (Result = 0) do
  begin
    if (GetWindowLong(AWnd, GWL_STYLE) and WS_CHILD) = 0 then
      Result := AWnd;
    AWnd := GetParent(AWnd);
  end;
end;

function GetContainerBorderWidth(ABorderStyle: TcxContainerBorderStyle): Integer;
begin
  Result := cxContainerBorderWidthA1[ABorderStyle];
end;

function GetContainerBorderWidth(ALookAndFeelKind: TcxLookAndFeelKind): Integer;
begin
  Result := cxContainerBorderWidthA2[ALookAndFeelKind];
end;

function GetControlRect(AControl: TControl): TRect;
begin
  Result := Rect(0, 0, AControl.Width, AControl.Height);
end;

function GetcxContainer(AControl: TWinControl): TcxContainer;
var
  AIContainerInnerControl: IcxContainerInnerControl;
begin
  Result := nil;
  if AControl is TcxContainer then
    Result := TcxContainer(AControl)
  else
    if (AControl <> nil) and Supports(AControl, IcxContainerInnerControl, AIContainerInnerControl) then
      Result := AIContainerInnerControl.ControlContainer;
end;

function GetWindowShadowRegion(AWindowHandle: TcxHandle;
  R: TRect; ANativeStyle, AShadow: Boolean;
  const AExcludeRect: TRect): TcxRegionHandle;
var
  ATempRegion: TcxRegionHandle;
begin
  if ANativeStyle then
    Result := 0
  else
  begin
    Result := CreateRectRgnIndirect(R);
    if AShadow then
    begin
      OffsetRect(R, cxContainerShadowWidth, cxContainerShadowWidth);
      ATempRegion := CreateRectRgnIndirect(R);
      CombineRgn(Result, Result, ATempRegion, RGN_OR);
      DeleteObject(ATempRegion);
    end;
    if not IsRectEmpty(AExcludeRect) then
    begin
      ATempRegion := CreateRectRgnIndirect(AExcludeRect);
      CombineRgn(Result, Result, ATempRegion, RGN_DIFF);
      DeleteObject(ATempRegion);
    end;
  end;
end;

function GetPopupOwnerControl(AWnd: HWND): HWND;
begin
  Result := AWnd;
  while (AWnd <> 0) and not (FindControl(AWnd) is TcxCustomPopupWindow) do
    AWnd := GetParent(AWnd);
  if AWnd <> 0 then
    Result := (FindControl(AWnd) as TcxCustomPopupWindow).OwnerControl.Handle;
end;

function HasHandle(AControl: TWinControl; AHandle: TcxHandle): Boolean;
begin
  Result := HasNativeHandle(AControl, NativeHandle(AHandle));
end;

function HasNativeHandle(AControl: TWinControl; ANativeHandle: TcxNativeHandle;
  ACheckChildren: Boolean = False): Boolean;
begin
  Result := (AControl <> nil) and ((AControl.Handle = ANativeHandle) or
    ACheckChildren and IsChildWindow(AControl, ANativeHandle));
end;

function HasOpenedPopupWindow(AControl: TWinControl): Boolean;
var
  AContainer: TcxContainer;
begin
  AContainer := GetcxContainer(AControl);
  Result := (AContainer <> nil) and AContainer.HasPopupWindow;
end;

procedure InflateRectByBorders(var R: TRect; ABorderWidth: Integer;
  AEdges: TcxBorders);
begin
  if not(bLeft in AEdges) then
    Inc(R.Left, ABorderWidth);
  if not(bTop in AEdges) then
    Inc(R.Top, ABorderWidth);
  if not(bRight in AEdges) then
    Dec(R.Right, ABorderWidth);
  if not(bBottom in AEdges) then
    Dec(R.Bottom, ABorderWidth);
end;

function InternalCompareString(const S1, S2: TCaption; ACaseSensitive: Boolean): Boolean;
begin
  if ACaseSensitive then
    Result := AnsiCompareStr(S1, S2) = 0
  else
    Result := AnsiUpperCase(S1) = AnsiUpperCase(S2);
end;

procedure InternalFillRect(ACanvas: TcxCanvas; const AOuterRect, AInternalRect: TRect;
  AColor: TColor);
begin
  if IsRectEmpty(AOuterRect) or EqualRect(AOuterRect, AInternalRect) then
    Exit;
  with ACanvas do
  begin
    Brush.Color := AColor;
    if IsRectEmpty(AInternalRect) then
      FillRect(AOuterRect)
    else
    begin
      FillRect(Rect(AOuterRect.Left, AOuterRect.Top,
        AInternalRect.Left, AOuterRect.Bottom));
      FillRect(Rect(AInternalRect.Left, AOuterRect.Top,
        AInternalRect.Right, AInternalRect.Top));
      FillRect(Rect(AInternalRect.Right, AOuterRect.Top,
        AOuterRect.Right, AOuterRect.Bottom));
      FillRect(Rect(AInternalRect.Left, AInternalRect.Bottom,
        AInternalRect.Right, AOuterRect.Bottom));
    end;
  end;
end;

function InternalGetCursorPos: TPoint;
begin
  GetCursorPos(Result);
end;

function InternalGetShiftState: TShiftState;
var
  AKeyState: TKeyBoardState;
begin
  GetKeyboardState(AKeyState);
  Result := KeyboardStateToShiftState(AKeyState);
end;

procedure InternalInvalidate(AHandle: TcxHandle; const AOuterRect, AInternalRect: TRect;
  AEraseBackground: Boolean = False);

  procedure InternalInvalidateRect(const R: TRect);
  begin
    InvalidateRect(AHandle, {$IFDEF CLR}R{$ELSE}@R{$ENDIF}, AEraseBackground);
  end;

begin
  if IsRectEmpty(AInternalRect) then
    InternalInvalidateRect(AOuterRect)
  else
  begin
    InternalInvalidateRect(Rect(AOuterRect.Left, AOuterRect.Top, AInternalRect.Left,
      AOuterRect.Bottom));
    InternalInvalidateRect(Rect(AInternalRect.Left, AOuterRect.Top, AInternalRect.Right,
      AInternalRect.Top));
    InternalInvalidateRect(Rect(AInternalRect.Right, AOuterRect.Top, AOuterRect.Right,
      AOuterRect.Bottom));
    InternalInvalidateRect(Rect(AInternalRect.Left, AInternalRect.Bottom, AInternalRect.Right,
        AOuterRect.Bottom));
  end;
end;

procedure InternalInvalidateRect(AControl: TWinControl; const R: TRect;
  AEraseBackground: Boolean);
begin
  if AControl.HandleAllocated then
    InvalidateRect(AControl.Handle, {$IFDEF CLR}R{$ELSE}@R{$ENDIF}, AEraseBackground);
end;

function InternalIsWindowVisible(AControl: TWinControl): Boolean;
begin
  with AControl do
  begin
    Result := HandleAllocated;
    Result := Result and IsWindowVisible(Handle);
  end;
end;

function IsChildWindow(AParent: TWinControl; AChildHandle: TcxNativeHandle): Boolean;

  function InternalNativeIsChildWindow(AParent: TWinControl): Boolean;
  begin
    Result := IsChild(NativeHandle(AParent.Handle), AChildHandle);
  end;

  function InternalIsChildWindow(AParent: TWinControl): Boolean;
  var
    I: Integer;
    APopupWindow: TcxCustomPopupWindow;
  begin
    with AParent do
      for I := 0 to ControlCount - 1 do
        if Controls[I] is TWinControl then
        begin
          if HasNativeHandle(TWinControl(Controls[I]), AChildHandle) then
          begin
            Result := True;
            Exit;
          end else
          begin
            Result := InternalIsChildWindow(TWinControl(Controls[I]));
            if Result then
              Exit;
          end;
          Result := InternalNativeIsChildWindow(TWinControl(Controls[I]));
          if Result then
            Exit;
        end;
    if AParent is TcxCustomPopupWindow then
      for I := 0 to FVisiblePopupWindowList.Count - 1 do
      begin
        APopupWindow := TcxCustomPopupWindow(FVisiblePopupWindowList[I]);
        if (APopupWindow = AParent) or (GetParentForm(APopupWindow.OwnerControl) <> AParent) then
          Continue;
        if HasNativeHandle(APopupWindow, AChildHandle) then
        begin
          Result := True;
          Exit;
        end else
        begin
          Result := InternalIsChildWindow(APopupWindow);
          if Result then Exit;
        end;
      end;
    for I := 0 to FVisiblePopupWindowList.Count - 1 do
    begin
      APopupWindow := TcxCustomPopupWindow(FVisiblePopupWindowList[I]);
      if APopupWindow.OwnerControl = AParent then
      begin
        Result := HasNativeHandle(APopupWindow, AChildHandle) or
          InternalIsChildWindow(APopupWindow);
        if Result then Exit;
      end;
    end;
    Result := False;
  end;

begin
  Result := False;
  if (AParent = nil) or (AChildHandle = 0) or HasNativeHandle(AParent, AChildHandle) then
    Exit;
  Result := InternalNativeIsChildWindow(AParent);
  if not Result then
    Result := InternalIsChildWindow(AParent);
end;

function KillMessages(AWnd: HWND; AMsgFilterMin, AMsgFilterMax: UINT;
  AKillAllMessages: Boolean = True): Boolean;
var
  AMsg: TMsg;
begin
  Result := False;
  while PeekMessage(AMsg, AWnd, AMsgFilterMin, AMsgFilterMax, PM_REMOVE) do
    if AMsg.message = WM_QUIT then
    begin
      PostQuitMessage(AMsg.wParam);
      Break;
    end
    else
    begin
      Result := True;
      if not AKillAllMessages then
        Break;
    end;
end;

function MouseButtonToShift(Button: TMouseButton): TShiftState;
begin
  case Button of
    mbLeft:
      Result := [ssLeft];
    mbMiddle:
      Result := [ssMiddle];
    mbRight:
      Result := [ssRight];
  end;
end;

function NativeHandle(Handle: TcxHandle): TcxNativeHandle;
begin
  Result := Handle;
end;

function ScreenCanvas: TcxScreenCanvas;
begin
  Result := FScreenCanvas;
end;

procedure SetUsecxScrollBars;
var
  ALibrary: HMODULE;
begin
{$IFDEF USETCXSCROLLBAR}
  ALibrary := GetModuleHandle('User32');
  if ALibrary <> 0 then
  begin
  {$IFDEF CLR}
    FUsecxScrollBars := GetProcAddress(ALibrary, 'GetScrollBarInfo') <> nil
  {$ELSE}
    @GetScrollBarInfoProc := GetProcAddress(ALibrary, 'GetScrollBarInfo');
    FUsecxScrollBars := Assigned(GetScrollBarInfoProc);
  {$ENDIF}
  end;
{$ELSE}
  FUsecxScrollBars := False;
{$ENDIF}
end;

procedure SetWindowRegion(AControl: TWinControl;
  const ABounds: TcxContainerInnerControlBounds);
begin
  if ABounds.IsEmpty then
    Windows.SetWindowRgn(AControl.Handle, 0, True)
  else
    Windows.SetWindowRgn(AControl.Handle, CreateRectRgnIndirect(ABounds.Rect), True);
end;

procedure SetWindowShadowRegion(AWindowHandle: TcxHandle; const R: TRect;
  ANativeStyle: Boolean; AShadow: Boolean; const AExcludeRect: TRect);
var
  ARgnChanged: Boolean;
  ARgnType: Integer;
  ATempRegion, AWindowRegion: HRGN;
begin
  AWindowRegion := GetWindowShadowRegion(AWindowHandle, R, ANativeStyle,
    AShadow, AExcludeRect);
  ATempRegion := CreateRectRgn(0, 0, 0, 0);
  ARgnType := Integer(GetWindowRgn(AWindowHandle, ATempRegion));
  ARgnChanged := not((AWindowRegion = 0) and ((ARgnType = NULLREGION) or
    (ARgnType = ERROR))) and not EqualRgn(AWindowRegion, ATempRegion);
  DeleteObject(ATempRegion);
  if ARgnChanged then
    SetWindowRgn(AWindowHandle, AWindowRegion, True)
  else
    if AWindowRegion <> 0 then
      DeleteObject(AWindowRegion);
end;

function UsecxScrollBars: Boolean;
begin
  Result := FUsecxScrollBars;
end;

function AreVisualStylesMustBeUsed(ANativeStyle: Boolean;
  AThemedObjectType: TdxThemedObjectType): Boolean;
begin
  Result := ANativeStyle and (OpenTheme(AThemedObjectType) <> 0);
end;

function GetSizeGripRect(AControl: IcxContainerInnerControl): TRect;
var
  R: TRect;
begin
  with AControl.ControlContainer do
    if HScrollBar.Visible and VScrollBar.Visible then
    begin
      Result.TopLeft := ClientToScreen(Point(VScrollBar.Left, HScrollBar.Top));
      GetWindowRect(AControl.Control.Handle, R);
      Dec(Result.Left, R.Left);
      Dec(Result.Top, R.Top);
      Result.Right := Result.Left + VScrollBar.Width;
      Result.Bottom := Result.Top + HScrollBar.Height;
    end
    else
      Result := cxEmptyRect;
end;

{$IFNDEF CLR}
var
  FDisablingWindowsCounter: Integer;
  FTopLevelWindowList: TList;
  FInternalWindowsEnabling: Boolean;

procedure DisableWindow(AWindowList: TList; AWnd: HWND);
begin
  if IsWindowEnabled(AWnd) then
  begin
    AWindowList.Add(Pointer(AWnd));
    EnableWindow(AWnd, False);
  end;
end;

procedure EnableWindows(AWindowList: TList);
var
  I: Integer;
  AWnd: HWND;
begin
  if AWindowList <> nil then
    for I := 0 to AWindowList.Count - 1 do
    begin
      AWnd := HWND(AWindowList[I]);
      if IsWindow(AWnd) then
        EnableWindow(AWnd, True);
    end;
end;

function DisableTopLevelWindow(AWnd: HWND; AInfo: Pointer): BOOL; stdcall;
var
  AProcessId: Cardinal;
begin
  Result := True;
  GetWindowThreadProcessId(AWnd, @AProcessId);
  if (AProcessId = GetCurrentProcessId) then
    DisableWindow(FTopLevelWindowList, AWnd);
end;

procedure DisableAppWindows(ANeedDisable: Boolean = True);
begin
  Inc(FDisablingWindowsCounter);

  if (FDisablingWindowsCounter = 1) and ANeedDisable then
  try
    FInternalWindowsEnabling := True;
    FTopLevelWindowList := TList.Create;
    EnumWindows(@DisableTopLevelWindow, 0);
  finally
    FInternalWindowsEnabling := False;
  end;
end;

procedure EnableAppWindows;
begin
  Dec(FDisablingWindowsCounter);

  if FDisablingWindowsCounter = 0 then
  try
    FInternalWindowsEnabling := True;
    EnableWindows(FTopLevelWindowList);
    FreeAndNil(FTopLevelWindowList);
  finally
    FInternalWindowsEnabling := False;
  end;
end;

function IsInternalWindowsDisabled: Boolean;
begin
  Result := FDisablingWindowsCounter > 0;
end;

function IsInternalWindowsDisabling: Boolean;
begin
  Result := FInternalWindowsEnabling;
end;
{$ENDIF}

{ TcxContainerViewInfo }

constructor TcxContainerViewInfo.Create;
begin
  inherited Create;
  ContainerState := [csNormal];
end;

procedure TcxContainerViewInfo.Assign(Source: TObject);
begin
  if Source is TcxContainerViewInfo then
    with Source as TcxContainerViewInfo do
      Self.ClientRect := ClientRect;
end;

function TcxContainerViewInfo.GetUpdateRegion(AViewInfo: TcxContainerViewInfo): TcxRegion;
begin
  Result := TcxRegion.Create;
end;

procedure TcxContainerViewInfo.Offset(DX, DY: Integer);
begin
  OffsetRect(BorderRect, DX, DY);
  OffsetRect(Bounds, DX, DY);
  OffsetRect(ClientRect, DX, DY);
end;

procedure TcxContainerViewInfo.Paint(ACanvas: TcxCanvas);
begin
  InternalPaint(ACanvas);
end;

procedure TcxContainerViewInfo.DrawBorder(ACanvas: TcxCanvas; R: TRect);
begin
  if Painter <> nil then
    ACanvas.FrameRect(R, BorderColor, BorderWidth)
  else
    begin
      if BorderStyle = cbsNone then
        Exit;
      case BorderStyle of
        cbsSingle, cbsThick:
          ACanvas.FrameRect(R, BorderColor, BorderWidth);
        cbsFlat:
          begin
            ACanvas.DrawEdge(R, True, True, Edges);
            InflateRect(R, -1, -1);
            ACanvas.FrameRect(R, clBtnFace);
          end;
        cbs3D:
          begin
            ACanvas.DrawEdge(R, True, True, Edges);
            InflateRect(R, -1, -1);
            ACanvas.DrawComplexFrame(R, cl3DDkShadow, cl3DLight, Edges);
          end;
      end;
    end;  
end;

function TcxContainerViewInfo.GetContainerBorderStyle: TcxContainerBorderStyle;
begin
  Result := BorderStyle;
end;

procedure TcxContainerViewInfo.InternalPaint(ACanvas: TcxCanvas);

  procedure DrawBackground;
  var
    R: TRect;
  begin
    R := BorderRect;
    Dec(R.Left, BorderWidth);
    Dec(R.Top, BorderWidth);
    if bRight in Edges then Inc(R.Right, BorderWidth);
    if bBottom in Edges then Inc(R.Bottom, BorderWidth);
    if Shadow then
      DrawContainerShadow(ACanvas, R);
    if not(bRight in Edges) then Inc(R.Right, BorderWidth);
    if not(bBottom in Edges) then Inc(R.Bottom, BorderWidth);
    DrawBorder(ACanvas, R);
    with ACanvas do
    begin
      Brush.Color := BackgroundColor;
      FillRect(BorderRect);
    end;
  end;

  procedure DrawNativeStyleBackground;

    function IsBorderNeeded: Boolean;
    begin
      Result := BorderStyle <> cbsNone;
    end;

  var
    ATheme: TTheme;
    R: TRect;
    AColor: COLORREF;
  begin
    if not IsBorderNeeded then
    begin
      ACanvas.Brush.Color := BackgroundColor;
      ACanvas.FillRect(Bounds);
    end
    else
    begin
      ATheme := OpenTheme(ThemedObjectType);
      GetThemeBackgroundContentRect(ATheme, ACanvas.Handle, NativePart,
        NativeState, Bounds, R);
      ACanvas.Brush.Color := BackgroundColor;
      ACanvas.FillRect(R);
      ATheme := OpenTheme(totComboBox);
      GetThemeColor(ATheme, CP_DROPDOWNBUTTON, CBXS_NORMAL, TMT_BORDERCOLOR, AColor);
      InternalFillRect(ACanvas, Bounds, R, AColor);
    end;
  end;

begin
  if NativeStyle then
    DrawNativeStyleBackground
  else
    DrawBackground;
end;

procedure TcxContainerViewInfo.SetBackgroundColor(Value: TColor);
begin
  FBackgroundColor := Value;
end;

{ TcxContainerStyles }

constructor TcxContainerStyles.Create(AOwner: TPersistent;
  AStyleClass: TcxContainerStyleClass);

  function CreateStyle(AState: TcxContainerStateItem): TcxContainerStyle;
  begin
    if AState = csNormal then
      Result := AStyleClass.Create(AOwner, False, nil, AState)
    else
      Result := AStyleClass.Create(AOwner, False, FStyles[csNormal], AState);
  end;

var
  AState: TcxContainerStateItem;
begin
  inherited Create;
  for AState := Low(TcxContainerStateItem) to High(TcxContainerStateItem) do
    FStyles[AState] := CreateStyle(AState);
end;

destructor TcxContainerStyles.Destroy;
var
  AState: TcxContainerStateItem;
begin
  for AState := High(TcxContainerStateItem) downto Low(TcxContainerStateItem) do
    FreeAndNil(FStyles[AState]);
  inherited Destroy;
end;

procedure TcxContainerStyles.RestoreDefaults;
var
  AState: TcxContainerStateItem;
begin
  for AState := Low(TcxContainerStateItem) to High(TcxContainerStateItem) do
    FStyles[AState].RestoreDefaults;
end;

function TcxContainerStyles.GetStyle(AState: TcxContainerStateItem): TcxContainerStyle;
begin
  Result := FStyles[AState];
end;

function TcxContainerStyles.GetStyleDisabled: TcxContainerStyle;
begin
  Result := FStyles[csDisabled];
end;

function TcxContainerStyles.GetStyleFocused: TcxContainerStyle;
begin
  Result := FStyles[csActive];
end;

function TcxContainerStyles.GetStyleHot: TcxContainerStyle;
begin
  Result := FStyles[csHotTrack];
end;

function TcxContainerStyles.GetStyleNormal: TcxContainerStyle;
begin
  Result := FStyles[csNormal];
end;

procedure TcxContainerStyles.SetOnChanged(Value: TNotifyEvent);
var
  AState: TcxContainerStateItem;
begin
  for AState := Low(TcxContainerStateItem) to High(TcxContainerStateItem) do
    FStyles[AState].OnChanged := Value;
end;

procedure TcxContainerStyles.SetStyle(AState: TcxContainerStateItem; Value: TcxContainerStyle);
begin
  FStyles[AState].Assign(Value);
end;

procedure TcxContainerStyles.SetStyleDisabled(Value: TcxContainerStyle);
begin
  FStyles[csDisabled].Assign(Value);
end;

procedure TcxContainerStyles.SetStyleFocused(Value: TcxContainerStyle);
begin
  FStyles[csActive].Assign(Value);
end;

procedure TcxContainerStyles.SetStyleHot(Value: TcxContainerStyle);
begin
  FStyles[csHotTrack].Assign(Value);
end;

procedure TcxContainerStyles.SetStyleNormal(Value: TcxContainerStyle);
begin
  FStyles[csNormal].Assign(Value);
end;

{ TcxStyleController }

constructor TcxStyleController.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FListeners := TList.Create;
  FStyles := TcxContainerStyles.Create(Self, GetStyleClass);
  FStyles.OnChanged := StyleChanged;
end;

destructor TcxStyleController.Destroy;
var
  I: Integer;
begin
  FIsDestruction := True;
  for I := FListeners.Count - 1 downto 0 do
    TcxContainerStyle(FListeners[I]).ControllerFreeNotification(Self);
  FreeAndNil(FStyles);
  FreeAndNil(FListeners);
  inherited Destroy;
end;

procedure TcxStyleController.RestoreStyles;
begin
  FStyles.RestoreDefaults;
end;

procedure TcxStyleController.Loaded;
begin
  inherited Loaded;
  Changed;
end;

procedure TcxStyleController.AddListener(AListener: TcxContainerStyle);
begin
  if (AListener = nil) or (FListeners.IndexOf(AListener) >= 0) then
    Exit;
  FListeners.Add(AListener);
  AListener.LookAndFeel.MasterLookAndFeel := Style.LookAndFeel;
end;

procedure TcxStyleController.Changed;
var
  I: Integer;
begin
  if Assigned(FOnStyleChanged) then
    FOnStyleChanged(Self);
  if not IsDestruction then
    for I := 0 to Listeners.Count - 1 do
      TcxContainerStyle(Listeners[I]).ControllerChangedNotification(Self);
end;

procedure TcxStyleController.ChangeFontScale(M, D: Integer);
begin
  if not (csvFont in Style.AssignedValues) then
    Style.ActiveStyleController.ChangeFontScale(M, D)
  else
    if not FIsFontScaled then
    begin
      FIsFontScaled := True;
      Style.Font.Size := MulDiv(Style.Font.Size, M, D);
    end;
end;

function TcxStyleController.GetStyleClass: TcxContainerStyleClass;
begin
  Result := TcxContainerStyle;
end;

function TcxStyleController.GetStylesClass: TcxContainerStylesClass;
begin
  Result := TcxContainerStyles;
end;

function TcxStyleController.IsDestruction: Boolean;
begin
  Result := FIsDestruction;
end;

procedure TcxStyleController.RemoveListener(AListener: TcxContainerStyle);
begin
  if (AListener = nil) or (FListeners.IndexOf(AListener) < 0) then
    Exit;
  FListeners.Remove(AListener);
  AListener.LookAndFeel.MasterLookAndFeel := nil;
end;

function TcxStyleController.GetFakeStyleController: TcxStyleController;
begin
  Result := Style.StyleController;
end;

function TcxStyleController.GetStyle: TcxContainerStyle;
begin
  Result := FStyles.Style;
end;

function TcxStyleController.GetInternalStyle(AState: TcxContainerStateItem): TcxContainerStyle;
begin
  Result := FStyles[AState];
end;

procedure TcxStyleController.SetFakeStyleController(Value: TcxStyleController);
begin
end;

procedure TcxStyleController.SetInternalStyle(AState: TcxContainerStateItem;
  Value: TcxContainerStyle);
begin
  FStyles[AState].Assign(Value);
end;

procedure TcxStyleController.StyleChanged(Sender: TObject);
begin
  Changed;
end;

{ TcxContainerStyle }

constructor TcxContainerStyle.Create(AOwner: TPersistent;
  ADirectAccessMode: Boolean; AParentStyle: TcxContainerStyle = nil;
  AState: TcxContainerStateItem = csNormal);
begin
  inherited Create(AOwner);
  FDirectAccessMode := ADirectAccessMode;
  FOwner := AOwner;
  if AState <> csNormal then
    FParentStyle := AParentStyle;
  FState := AState;
  if DirectAccessMode then
    FAssignedValues := [csvColor, csvFont, csvTextColor, csvTextStyle]; // TODO ???
  CreateFont;
  FVisibleFont := TFont.Create;
  if IsBaseStyle then
  begin
    FLookAndFeel := TcxLookAndFeel.Create(Self);
    FLookAndFeel.OnChanged := LookAndFeelChanged;
    StyleController := GetDefaultStyleController;
  end;
end;

destructor TcxContainerStyle.Destroy;
begin
  FIsDestroying := True;
  if IsBaseStyle and (ActiveStyleController <> nil) then
    ActiveStyleController.RemoveListener(Self);
  FreeAndNil(FLookAndFeel);
  FreeAndNil(FVisibleFont);
  if not DirectAccessMode and IsBaseStyle then
    FreeAndNil(StyleData.Font);
  inherited Destroy;
end;

procedure TcxContainerStyle.Assign(Source: TPersistent);
begin
  if Source is TcxContainerStyle then
  begin
    BeginUpdate;
    try
      with Source as TcxContainerStyle do
      begin
        if Self.IsBaseStyle then
        begin
          Self.StyleController := StyleController;
          Self.LookAndFeel := LookAndFeel;
        end;

        Self.FBorderColor := FBorderColor;
        Self.FBorderStyle := FBorderStyle;
        Self.FEdges := FEdges;
        Self.FHotTrack := FHotTrack;
        Self.FShadow := FShadow;
        Self.FTransparentBorder := FTransparentBorder;
        Self.StyleData.Color := StyleData.Color;

        if Self.DirectAccessMode then
        begin
          Self.StyleData.Font := Font;
          Self.StyleData.FontColor := TextColor;
        end
        else
        begin
          Self.StyleData.Font.Assign(Font);
          if DirectAccessMode then
            Self.StyleData.Font.Color := TextColor;
          Self.StyleData.FontColor := TextColor;
          Self.FTextStyle := TextStyle;
        end;

        Self.FAssignedValues := FAssignedValues;

        Self.Changed;
      end;
    finally
      EndUpdate;
    end
  end
  else
    inherited Assign(Source);
end;

procedure TcxContainerStyle.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TcxContainerStyle.EndUpdate;
begin
  if FUpdateCount > 0 then
  begin
    Dec(FUpdateCount);
    CheckChanges;
  end;
end;

function TcxContainerStyle.GetStyleValue(const APropertyName: string;
  out StyleValue: TcxContainerStyleValue): Boolean;
var
  I: TcxContainerStyleValue;
  S: string;
begin
  Result := False;
  for I := 0 to GetStyleValueCount - 1 do
  begin
    GetStyleValueName(I, S);
    if InternalCompareString(S, APropertyName, False) then
    begin
      StyleValue := I;
      Result := True;
      Break;
    end;
  end;
end;

function TcxContainerStyle.GetStyleValueCount: Integer;
begin
  Result := cxContainerStyleValueCount;
end;

function TcxContainerStyle.GetStyleValueName(AStyleValue: TcxContainerStyleValue;
  out StyleValueName: string): Boolean;
begin
  Result := AStyleValue < cxContainerStyleValueCount;
  if Result then
    StyleValueName := cxContainerStyleValueNameA[AStyleValue];
end;

function TcxContainerStyle.GetVisibleFont: TFont;
begin
  UpdateVisibleFont;
  Result := FVisibleFont;
end;

function TcxContainerStyle.HasBorder: Boolean;
begin
  if IsBaseStyle then
    Result := True
  else
    Result := ParentStyle.HasBorder;
end;

function TcxContainerStyle.IsExtendedStylePropertyPublished(
  const APropertyName: string): Boolean;
var
  AStyleValue: TcxContainerStyleValue;
begin
  if (APropertyName = 'LookAndFeel') or (APropertyName = 'StyleController') then
  begin
    Result := False;
    Exit;
  end;
  Result := True;
  if GetStyleValue(APropertyName, AStyleValue) then
    Result := not(AStyleValue in InternalGetNotPublishedExtendedStyleValues);
end;

function TcxContainerStyle.IsValueAssigned(AValue: TcxContainerStyleValue): Boolean;
var
  ABorderStyle: TcxContainerBorderStyle;
  AColor: TColor;
  AEdges: TcxBorders;
  AFont: TFont;
  ATempBool: Boolean;
  ATextStyle: TFontStyles;
begin
  Result := False;
  case AValue of
    csvBorderColor:
      Result := InternalGetBorderColor(AColor);
    csvBorderStyle:
      Result := InternalGetBorderStyle(ABorderStyle);
    csvColor:
      Result := InternalGetColor(AColor);
    csvEdges:
      Result := InternalGetEdges(AEdges);
    csvFont:
      Result := InternalGetFont(AFont);
    csvHotTrack:
      Result := InternalGetHotTrack(ATempBool);
    csvShadow:
      Result := InternalGetShadow(ATempBool);
    csvTextColor:
      Result := InternalGetTextColor(AColor);
    csvTextStyle:
      Result := InternalGetTextStyle(ATextStyle);
  end;
end;

procedure TcxContainerStyle.RestoreDefaults;
begin
  BeginUpdate;
  try
    AssignedValues := [];
    if IsBaseStyle then
    begin
      LookAndFeel.Reset;
      if Container <> nil then
      begin
        Container.ParentColor := False;
        Container.ParentFont := True;
      end
      else
        if not DirectAccessMode then
          RestoreFont(StyleData.Font);
      if (Container <> nil) and Container.DefaultParentColor and
        ((ActiveStyleController = nil) or not ActiveStyleController.Style.IsValueAssigned(csvColor)) then
          Container.ParentColor := True;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TcxContainerStyle.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('IsFontAssigned', ReadIsFontAssigned,
    WriteIsFontAssigned, IsFontStored);
end;

function TcxContainerStyle.BaseGetStyleController: TcxStyleController;
begin
  if IsBaseStyle then
    if FStyleController = GetDefaultStyleController then
      Result := nil
    else
      Result := FStyleController
  else
    Result := ParentStyle.StyleController;
end;

procedure TcxContainerStyle.BaseSetStyleController(Value: TcxStyleController);

  function CheckStyleController(AStyleController: TcxStyleController): Boolean;
  begin
    Result := False;
    if AStyleController.Style = Self then
      Exit;
    repeat
      AStyleController := AStyleController.Style.StyleController;
      if AStyleController = nil then
        Break;
      if AStyleController.Style = Self then
        Exit;
    until False;
    Result := True;
  end;

begin
  if not IsBaseStyle then
    ParentStyle.StyleController := Value
  else
  begin
    if FOwner = GetDefaultStyleController then
      Exit;
    if Value = nil then
      Value := GetDefaultStyleController;
    if (Value <> nil) and (not CheckStyleController(Value)) then
      Exit;

    if Value <> FStyleController then
    begin
      if FStyleController <> nil then
        FStyleController.RemoveListener(Self);
      FStyleController := Value;
      if FStyleController <> nil then
        FStyleController.AddListener(Self);
      ControllerChangedNotification(FStyleController);
    end;
  end;
end;

procedure TcxContainerStyle.Changed;
begin
  FModified := True;
  CheckChanges;
end;

procedure TcxContainerStyle.ControllerChangedNotification(AStyleController: TcxStyleController);
begin
  UpdateFont;
  Changed;
end;

procedure TcxContainerStyle.ControllerFreeNotification(AStyleController: TcxStyleController);
begin
  if AStyleController = ActiveStyleController then
    StyleController := nil;
end;

function TcxContainerStyle.DefaultBorderColor: TColor;
begin
  if State = csDisabled then
    Result := clBtnShadow
  else
    if IsBaseStyle then
      Result := clWindowFrame
    else
      Result := ParentStyle.BorderColor;
end;

function TcxContainerStyle.DefaultBorderStyle: TcxContainerBorderStyle;
const
  AStyleBorderStyles: array [TcxLookAndFeelKind] of TcxContainerBorderStyle =
    (cbsFlat, cbs3D, cbsUltraFlat, cbsOffice11);
  ABorderStyles: array [TcxContainerStateItem, TcxContainerBorderStyle] of TcxContainerBorderStyle = (
    (cbsNone, cbsSingle, cbsThick, cbsFlat, cbs3D, cbsUltraFlat, cbsOffice11),
    (cbsFlat, cbsThick, cbsThick, cbs3D, cbs3D, cbsUltraFlat, cbsOffice11),
    (cbsNone, cbsSingle, cbsThick, cbsFlat, cbs3D, cbsUltraFlat, cbsOffice11),
    (cbsFlat, cbsThick, cbsThick, cbs3D, cbs3D, cbsUltraFlat, cbsOffice11)
  );
var
  AState: TcxContainerStateItem;
begin
  if IsBaseStyle then
    Result := AStyleBorderStyles[LookAndFeel.Kind]
  else
  begin
    if HotTrack or (State = csDisabled) then
      AState := State
    else
      AState := csNormal;
    Result := ABorderStyles[AState, ParentStyle.BorderStyle];
  end;
end;

function TcxContainerStyle.DefaultColor: TColor;
var
  AIsDefaultParentColor: Boolean;
begin
  AIsDefaultParentColor := (Container = nil) or Container.DefaultParentColor;
  if IsBaseStyle then
  begin
    if AIsDefaultParentColor then
      Result := clBtnFace
    else
      Result := clWindow;
  end
  else
    if (State = csDisabled) and not AIsDefaultParentColor then
      Result := clBtnFace
    else
      Result := ParentStyle.Color;
end;

function TcxContainerStyle.DefaultEdges: TcxBorders;
begin
  Result := [bLeft, bTop, bRight, bBottom];
end;

function TcxContainerStyle.DefaultHotTrack: Boolean;
begin
  Result := True;
end;

function TcxContainerStyle.DefaultShadow: Boolean;
begin
  Result := False;
end;

function TcxContainerStyle.DefaultTextColor: TColor;
begin
  if State = csDisabled then
    Result := clBtnShadow
  else
    if IsBaseStyle then
      Result := StyleData.Font.Color
    else
      Result := ParentStyle.TextColor;
end;

function TcxContainerStyle.DefaultTextStyle: TFontStyles;
begin
  if IsBaseStyle then
    Result := StyleData.Font.Style
  else
    Result := ParentStyle.TextStyle;
end;

function TcxContainerStyle.DefaultTransparentBorder: Boolean;
begin
  Result := True;
end;

procedure TcxContainerStyle.FontChanged(Sender: TObject);
begin
  if not IsFontAssignedValueLocked then
    Include(FAssignedValues, csvFont);
  Changed;
end;

function TcxContainerStyle.GetColor: TColor;
var
  AContainer: TcxContainer;
begin
  if DirectAccessMode then
    Result := StyleData.Color
  else
  begin
    AContainer := Container;
    if IsBaseStyle and (AContainer <> nil) and
      AContainer.ParentColor and (AContainer.Parent <> nil) then
{$IFNDEF CLR}
        Result := TWinControlAccess(AContainer.Parent).Color
{$ELSE}
        Result := AContainer.Parent.Color
{$ENDIF}
    else
      if not InternalGetColor(Result) then
        Result := DefaultColor;
  end;
end;

function TcxContainerStyle.GetDefaultStyleController: TcxStyleController;
begin
  Result := DefaultContainerStyleController;
end;

function TcxContainerStyle.GetStyleColor: TColor;
var
  AContainer: TcxContainer;
begin
  if FDirectAccessMode then
    Result := StyleData.Color
  else
    if not InternalGetColor(Result) then
      if not IsBaseStyle then
        Result := DefaultColor
      else
      begin
        AContainer := Container;
        if (AContainer <> nil) and not AContainer.IsInplace and
          AContainer.ParentColor and (AContainer.Parent <> nil) then
{$IFNDEF CLR}
            Result := TWinControlAccess(AContainer.Parent).Color
{$ELSE}
            Result := AContainer.Parent.Color
{$ENDIF}
        else
          Result := DefaultColor;
      end;
end;

function TcxContainerStyle.GetTextColor: TColor;
begin
  if DirectAccessMode then
    Result := StyleData.FontColor
  else
    if not InternalGetTextColor(Result) then
      Result := DefaultTextColor;
end;

function TcxContainerStyle.GetTextStyle: TFontStyles;
begin
  if DirectAccessMode then
    Result := StyleData.Font.Style
  else
    if not InternalGetTextStyle(Result) then
      Result := DefaultTextStyle;
end;

function TcxContainerStyle.InternalGetColor(var Color: TColor): Boolean;
begin
  Result := csvColor in FAssignedValues;
  if Result then
    Color := StyleData.Color
  else
    if ActiveStyleController <> nil then
      Result := ActiveStyleController.Styles[State].InternalGetColor(Color);
end;

function TcxContainerStyle.InternalGetNotPublishedExtendedStyleValues: TcxContainerStyleValues;
begin
  Result := [csvEdges, csvFont, csvHotTrack, csvShadow, csvTransparentBorder];
end;

function TcxContainerStyle.IsBaseStyle: Boolean;
begin
  Result := ParentStyle = nil;
end;

function TcxContainerStyle.IsDestroying: Boolean;
begin
  Result := FIsDestroying;
end;

function TcxContainerStyle.IsFontAssignedValueLocked: Boolean;
begin
  Result := FFontAssignedValueLockCount > 0;
end;

procedure TcxContainerStyle.LockFontAssignedValue(ALock: Boolean);
begin
  if ALock then
    Inc(FFontAssignedValueLockCount)
  else
    if FFontAssignedValueLockCount > 0 then
      Dec(FFontAssignedValueLockCount);
end;

procedure TcxContainerStyle.UpdateFont;
var
  AFont: TFont;
begin
  if DirectAccessMode or (csvFont in AssignedValues) then
    Exit;
  LockFontAssignedValue(True);
  try
    if InternalGetFont(AFont) then
      StyleData.Font.Assign(AFont)
    else
      if (Container = nil) or not Container.ParentFont then
        RestoreFont(StyleData.Font);
  finally
    LockFontAssignedValue(False);
  end;
end;

function TcxContainerStyle.GetAssignedValues: TcxContainerStyleValues;
begin
  if DirectAccessMode then
    Result := [0..GetStyleValueCount - 1]
  else
    Result := FAssignedValues;
end;

function TcxContainerStyle.GetBorderColor: TColor;
begin
  if DirectAccessMode then
    Result := clDefault
  else
    if not InternalGetBorderColor(Result) then
      Result := DefaultBorderColor;
end;

function TcxContainerStyle.GetBorderStyle: TcxContainerBorderStyle;
begin
  if DirectAccessMode then
    if csvBorderStyle in FAssignedValues then
      Result := FBorderStyle
    else
      Result := DefaultBorderStyle
  else
    if not InternalGetBorderStyle(Result) then
      Result := DefaultBorderStyle;
end;

function TcxContainerStyle.GetEdges: TcxBorders;
begin
  if DirectAccessMode then
    Result := []
  else
    if not IsBaseStyle then
      Result := ParentStyle.Edges
    else
      if not InternalGetEdges(Result) then
        Result := DefaultEdges;
end;

function TcxContainerStyle.GetFont: TFont;
begin
  if IsBaseStyle then
    Result := StyleData.Font
  else
    Result := ParentStyle.Font;
end;

function TcxContainerStyle.GetHotTrack: Boolean;
begin
  if DirectAccessMode then
  begin
    if csvHotTrack in FAssignedValues then
      Result := FHotTrack
    else
      Result := DefaultHotTrack;
  end
  else
    if not IsBaseStyle then
      Result := ParentStyle.HotTrack
    else
      if not InternalGetHotTrack(Result) then
        Result := DefaultHotTrack;
end;

function TcxContainerStyle.GetShadow: Boolean;
begin
  if DirectAccessMode then
    Result := False
  else
    if not IsBaseStyle then
      Result := ParentStyle.Shadow
    else
      if not InternalGetShadow(Result) then
        Result := DefaultShadow;
end;

function TcxContainerStyle.GetTransparentBorder: Boolean;
begin
  if DirectAccessMode then
    Result := True
  else
    if not IsBaseStyle then
      Result := ParentStyle.TransparentBorder
    else
      if not InternalGetTransparentBorder(Result) then
        Result := DefaultTransparentBorder;
end;

function TcxContainerStyle.InternalGetBorderColor(var BorderColor: TColor): Boolean;
begin
  Result := csvBorderColor in FAssignedValues;
  if Result then
    BorderColor := FBorderColor
  else
    if ActiveStyleController <> nil then
      Result := ActiveStyleController.Styles[State].InternalGetBorderColor(BorderColor);
end;

function TcxContainerStyle.InternalGetBorderStyle(
  var BorderStyle: TcxContainerBorderStyle): Boolean;
begin
  Result := csvBorderStyle in FAssignedValues;
  if Result then
    BorderStyle := FBorderStyle
  else
    if ActiveStyleController <> nil then
      Result := ActiveStyleController.Styles[State].InternalGetBorderStyle(BorderStyle);
end;

function TcxContainerStyle.InternalGetEdges(var Edges: TcxBorders): Boolean;
begin
  Result := csvEdges in FAssignedValues;
  if Result then
    Edges := FEdges
  else
    if ActiveStyleController <> nil then
      Result := ActiveStyleController.Styles[State].InternalGetEdges(Edges);
end;

function TcxContainerStyle.InternalGetFont(var Font: TFont): Boolean;
begin
  Result := csvFont in FAssignedValues;
  if Result then
    Font := StyleData.Font
  else
    if ActiveStyleController <> nil then
      Result := ActiveStyleController.Styles[State].InternalGetFont(Font);
end;

function TcxContainerStyle.InternalGetHotTrack(var HotTrack: Boolean): Boolean;
begin
  Result := csvHotTrack in FAssignedValues;
  if Result then
    HotTrack := FHotTrack
  else
    if ActiveStyleController <> nil then
      Result := ActiveStyleController.Styles[State].InternalGetHotTrack(HotTrack);
end;

function TcxContainerStyle.InternalGetShadow(var Shadow: Boolean): Boolean;
begin
  Result := csvShadow in FAssignedValues;
  if Result then
    Shadow := FShadow
  else
    if ActiveStyleController <> nil then
      Result := ActiveStyleController.Styles[State].InternalGetShadow(Shadow);
end;

function TcxContainerStyle.InternalGetTextColor(var TextColor: TColor): Boolean;
begin
  Result := csvTextColor in FAssignedValues;
  if Result then
    TextColor := StyleData.FontColor
  else
    if ActiveStyleController <> nil then
      Result := ActiveStyleController.Styles[State].InternalGetTextColor(TextColor);
end;

function TcxContainerStyle.InternalGetTextStyle(var TextStyle: TFontStyles): Boolean;
begin
  Result := csvTextStyle in FAssignedValues;
  if Result then
    TextStyle := FTextStyle
  else
    if ActiveStyleController <> nil then
      Result := ActiveStyleController.Styles[State].InternalGetTextStyle(TextStyle);
end;

function TcxContainerStyle.InternalGetTransparentBorder(
  var TransparentBorder: Boolean): Boolean;
begin
  Result := csvTransparentBorder in FAssignedValues;
  if Result then
    TransparentBorder := FTransparentBorder
  else
    if ActiveStyleController <> nil then
      Result := ActiveStyleController.Styles[State].InternalGetTransparentBorder(TransparentBorder);
end;

function TcxContainerStyle.IsBorderColorStored: Boolean;
begin
  Result := (csvBorderColor in FAssignedValues) and ((Container = nil) or
    Container.IsStylePropertyPublished('BorderColor', State <> csNormal));
end;

function TcxContainerStyle.IsBorderStyleStored: Boolean;
begin
  Result := (csvBorderStyle in FAssignedValues) and ((Container = nil) or
    Container.IsStylePropertyPublished('BorderStyle', State <> csNormal)){$IFDEF CLR} and
    IsPropertyUnique(Self, 'BorderStyle'){$ENDIF};
end;

function TcxContainerStyle.IsColorStored: Boolean;
begin
  Result := (csvColor in FAssignedValues) and ((Container = nil) or
    Container.IsStylePropertyPublished('Color', State <> csNormal));
end;

function TcxContainerStyle.IsEdgesStored: Boolean;
begin
  Result := (csvEdges in FAssignedValues) and ((Container = nil) or
    Container.IsStylePropertyPublished('Edges', State <> csNormal));
end;

function TcxContainerStyle.IsFontStored: Boolean;
begin
  Result := (csvFont in FAssignedValues) and ((Container = nil) or
    Container.IsStylePropertyPublished('Font', State <> csNormal));
end;

function TcxContainerStyle.IsHotTrackStored: Boolean;
begin
  Result := (csvHotTrack in FAssignedValues) and ((Container = nil) or
    Container.IsStylePropertyPublished('HotTrack', State <> csNormal));
end;

{$IFDEF CLR}
function TcxContainerStyle.IsLookAndFeelStored: Boolean;
begin
  Result := State = csNormal;
end;
{$ENDIF}

function TcxContainerStyle.IsShadowStored: Boolean;
begin
  Result := (csvShadow in FAssignedValues) and ((Container = nil) or
    Container.IsStylePropertyPublished('Shadow', State <> csNormal));
end;

function TcxContainerStyle.IsStyleControllerStored: Boolean;
begin
  Result := (State = csNormal){$IFDEF CLR} and IsPropertyUnique(Self, 'StyleController'){$ENDIF};
end;

function TcxContainerStyle.IsTextColorStored: Boolean;
begin
  Result := (csvTextColor in FAssignedValues) and ((Container = nil) or
    Container.IsStylePropertyPublished('TextColor', State <> csNormal));
end;

function TcxContainerStyle.IsTextStyleStored: Boolean;
begin
  Result := (csvTextStyle in FAssignedValues) and ((Container = nil) or
    Container.IsStylePropertyPublished('TextStyle', State <> csNormal));
end;

function TcxContainerStyle.IsTransparentBorderStored: Boolean;
begin
  Result := (csvTransparentBorder in FAssignedValues) and ((Container = nil) or
    Container.IsStylePropertyPublished('TransparentBorder', State <> csNormal));
end;

procedure TcxContainerStyle.SetAssignedValues(Value: TcxContainerStyleValues);
begin
  if FAssignedValues <> Value then
  begin
    FAssignedValues := Value;
    if IsBaseStyle then
      UpdateFont;
    Changed;
  end;
end;

procedure TcxContainerStyle.SetBorderColor(Value: TColor);
begin
  if (csvBorderColor in FAssignedValues) and (Value = FBorderColor) then
    Exit;
  FBorderColor := Value;
  Include(FAssignedValues, csvBorderColor);
  Changed;
end;

procedure TcxContainerStyle.SetBorderStyle(Value: TcxContainerBorderStyle);
begin
  if (csvBorderStyle in FAssignedValues) and (Value = FBorderStyle) then
    Exit;
  FBorderStyle := Value;
  Include(FAssignedValues, csvBorderStyle);
  Changed;
end;

procedure TcxContainerStyle.SetColor(Value: TColor);
begin
  if (csvColor in FAssignedValues) and (Value = StyleData.Color) then
    Exit;
  StyleData.Color := Value;
  Include(FAssignedValues, csvColor);
  Changed;
end;

procedure TcxContainerStyle.SetEdges(Value: TcxBorders);
begin
  if not IsBaseStyle then
    ParentStyle.Edges := Value
  else
  begin
    if (csvEdges in FAssignedValues) and (Value = FEdges) then
      Exit;
    FEdges := Value;
    Include(FAssignedValues, csvEdges);
    Changed;
  end;
end;

procedure TcxContainerStyle.SetFont(Value: TFont);
begin
  if DirectAccessMode then
    StyleData.Font := Value
  else
    if not IsBaseStyle then
      ParentStyle.Font := Value
    else
    begin
      StyleData.Font.Assign(Value);
      Include(FAssignedValues, csvFont);
      Changed;
    end;
end;

procedure TcxContainerStyle.SetHotTrack(Value: Boolean);
begin
  if not IsBaseStyle then
    ParentStyle.HotTrack := Value
  else
  begin
    if (csvHotTrack in FAssignedValues) and (Value = FHotTrack) then
      Exit;
    FHotTrack := Value;
    Include(FAssignedValues, csvHotTrack);
    Changed;
  end;
end;

procedure TcxContainerStyle.SetShadow(Value: Boolean);
begin
  if not IsBaseStyle then
    ParentStyle.Shadow := Value
  else
  begin
    if (csvShadow in FAssignedValues) and (Value = FShadow) then
      Exit;
    FShadow := Value;
    Include(FAssignedValues, csvShadow);
    Changed;
  end;
end;

procedure TcxContainerStyle.SetTextColor(Value: TColor);
begin
  if (csvTextColor in FAssignedValues) and (Value = TextColor) then
    Exit;
  StyleData.FontColor := Value;
  Include(FAssignedValues, csvTextColor);
  Changed;
end;

procedure TcxContainerStyle.SetTextStyle(Value: TFontStyles);
begin
  if (csvTextStyle in FAssignedValues) and (Value = TextStyle) then
    Exit;
  FTextStyle := Value;
  Include(FAssignedValues, csvTextStyle);
  Changed;
end;

procedure TcxContainerStyle.SetTransparentBorder(Value: Boolean);
begin
  if not IsBaseStyle then
    ParentStyle.TransparentBorder := Value
  else
  begin
    if (csvTransparentBorder in FAssignedValues) and (Value = FTransparentBorder) then
      Exit;
    FTransparentBorder := Value;
    Include(FAssignedValues, csvTransparentBorder);
    Changed;
  end;
end;

procedure TcxContainerStyle.CheckChanges;
begin
  if FModified and (FUpdateCount = 0) then
  begin
    FModified := False;
    if not IsDestroying and not DirectAccessMode and Assigned(FOnChanged) then
      FOnChanged(Self);
  end;
end;

procedure TcxContainerStyle.CreateFont;
begin
  if not DirectAccessMode and IsBaseStyle then
  begin
    StyleData.Font := TFont.Create;
    StyleData.Font.OnChange := FontChanged;
  end
  else
    StyleData.Font := nil;
end;

function TcxContainerStyle.GetActiveStyleController: TcxStyleController;
begin
  if IsBaseStyle then
    Result := FStyleController
  else
    Result := ParentStyle.FStyleController;
end;

function TcxContainerStyle.GetBaseStyle: TcxContainerStyle;
begin
  if IsBaseStyle then
    Result := Self
  else
    Result := ParentStyle;
end;

function TcxContainerStyle.GetContainer: TcxContainer;
begin
  if FOwner is TcxContainer then
    Result := TcxContainer(FOwner)
  else
    Result := nil;
end;

function TcxContainerStyle.GetLookAndFeel: TcxLookAndFeel;
begin
  if IsBaseStyle then
    Result := FLookAndFeel
  else
    Result := ParentStyle.LookAndFeel;
end;

procedure TcxContainerStyle.LookAndFeelChanged(Sender: TcxLookAndFeel;
  AChangedValues: TcxLookAndFeelValues);
begin
  Changed;
end;

procedure TcxContainerStyle.ReadIsFontAssigned(Reader: TReader);
begin
  Reader.ReadBoolean;
  AssignedValues := AssignedValues + [csvFont];
end;

procedure TcxContainerStyle.RestoreFont(AFont: TFont);
var
  ATempFont: TFont;
begin
  ATempFont := TFont.Create;
  try
    AFont.Assign(ATempFont);
  finally
    ATempFont.Free;
  end;
end;

procedure TcxContainerStyle.SetLookAndFeel(Value: TcxLookAndFeel);
begin
  if IsBaseStyle then
    FLookAndFeel.Assign(Value)
  else
    ParentStyle.LookAndFeel := Value;
end;

procedure TcxContainerStyle.UpdateVisibleFont;
begin
  FVisibleFont.Assign(Font);
  FVisibleFont.Color := TextColor;
  FVisibleFont.Style := TextStyle;
end;

procedure TcxContainerStyle.WriteIsFontAssigned(Writer: TWriter);
begin
  Writer.WriteBoolean(True);
end;

{ TcxContainer }

constructor TcxContainer.Create(AOwner: TComponent);
var
  AColor: TColor;
begin
  inherited Create(AOwner);
  FIsCreating := True;
  FStyles := GetStylesClass.Create(Self, GetStyleClass);
  FStyles.OnChanged := ContainerStyleChanged;

  FActiveStyleData.ContainerState := [csNormal];
  FActiveStyleData.ActiveStyle := FStyles.Style;

  FViewInfo := GetViewInfoClass.Create;
  LookAndFeel.MasterLookAndFeel := FStyles.Style.LookAndFeel;

  ControlStyle := ControlStyle + [csSetCaption, csCaptureMouse];
  TabStop := True;
  ParentColor := DefaultParentColor and not IsInplace and
    not Style.InternalGetColor(AColor);
  if not ParentColor then
    Color := clWindow;
  ClearSavedChildControlRegions;
  
  FIsCreating := False;
end;

destructor TcxContainer.Destroy;
begin
  cxControls.EndMouseTracking(Self);
  FIsDestroying := True;
  FreeAndNil(FViewInfo);
  FStyles.OnChanged := nil;
  FreeAndNil(FStyles);
  inherited Destroy;
end;

function TcxContainer.Focused: Boolean;
begin
  if IsDesigning or (csDestroyingHandle in ControlState) then
    Result := False
  else
  begin
    Result := inherited Focused;
    Result := Result or (InnerControl <> nil) and
      InnerControl.Focused;
  end;
end;

function TcxContainer.GetDragImages: TDragImageList;
begin
  if InnerControl = nil then
    Result := inherited GetDragImages
  else
{$IFNDEF CLR}
    Result := TWinControlAccess(InnerControl).GetDragImages;
{$ELSE}
    Result := InnerControl.GetDragImages;
{$ENDIF}
end;

procedure TcxContainer.GetTabOrderList(List: TList);
var
  AActiveControl: TWinControl;
begin
  if IsContainerClass then
    inherited GetTabOrderList(List)
  else
  begin
    AActiveControl := GetParentForm(Self).ActiveControl;
    if (AActiveControl <> Self) and CanFocus and (InnerControl <> nil) and
      (InnerControl = AActiveControl) then
    begin
      List.Add(InnerControl);
      List.Remove(Self);
    end;
  end;
end;

procedure TcxContainer.SetFocus;
var
  AParentForm: TCustomForm;
begin
  if IsDesigning or IsContainerFocused then
    Exit;
  inherited SetFocus;
  if (InnerControl <> nil) and InnerControl.HandleAllocated and (GetFocus = Handle) then
  begin
    AParentForm := GetParentForm(Self);
    SafeSelectionFocusInnerControl;
    AParentForm.FocusControl(InnerControl);
  end;
end;

procedure TcxContainer.ClearSavedChildControlRegions;
begin
  FInnerControlBounds.IsEmpty := True;
end;

function TcxContainer.GetVisibleBounds: TRect;
var
  ABorderWidth, ABorderMaskedPartWidth: Integer;
begin
  Result := GetControlRect(Self);
  if IsInplace then
    Exit;
  try
    if ViewInfo.Shadow then
    begin
      Dec(Result.Right, cxContainerShadowWidth);
      Dec(Result.Bottom, cxContainerShadowWidth);
    end;

    if not Style.HasBorder then
    begin
      if Style.TransparentBorder then
        InflateRect(Result, -cxContainerMaxBorderWidth, -cxContainerMaxBorderWidth);
      Exit;
    end;
    if ViewInfo.NativeStyle then
    begin
      if Style.TransparentBorder and (Style.BorderStyle = cbsNone) then
        InflateRect(Result, -cxContainerMaxBorderWidth, -cxContainerMaxBorderWidth);
      Exit;
    end;
    if not Style.TransparentBorder then
      Exit;

    ABorderWidth := GetContainerBorderWidth(ViewInfo.BorderStyle);
    ABorderMaskedPartWidth := cxContainerMaxBorderWidth - ABorderWidth;
    InflateRect(Result, -ABorderMaskedPartWidth, -ABorderMaskedPartWidth);
    InflateRectByBorders(Result, ABorderWidth, ViewInfo.Edges);
  finally
    if Result.Top > Result.Bottom then
      Result := Rect(Result.Left, 0, Result.Right, 0);
  end;
end;

function TcxContainer.HasPopupWindow: Boolean;
begin
  Result := False;
end;

function TcxContainer.InnerControlDefaultHandler(var Message: TMessage): Boolean;
begin
  Result := False;
  {$IFNDEF DELPHI5}
  if Message.Msg = WM_CONTEXTMENU then
  begin
    with Message do
      Result := Perform(Msg, WParam, LParam);
    Result := Message.Result <> 0;
  end;
  {$ENDIF}
end;

function TcxContainer.InnerControlMenuHandler(var Message: TMessage): Boolean;
var
  AKeyMessage: TWMKey;
begin
  Result := False;
  if (Message.Msg = CN_KEYDOWN) or (Message.Msg = CN_SYSKEYDOWN) then
  begin
    AKeyMessage := TWMKey{$IFDEF CLR}.Create{$ENDIF}(Message);
    Result := IsMenuKey(AKeyMessage);
    if Result then
      Message.Result := 1;
  end;
end;

procedure TcxContainer.Invalidate;
begin
  inherited Invalidate;
  if InnerControl <> nil then
    InnerControl.Invalidate;
end;

function TcxContainer.IsInplace: Boolean;
begin
  Result := False;
end;

function TcxContainer.IsStylePropertyPublished(const APropertyName: string;
  AExtendedStyle: Boolean): Boolean;
var
  AStyleValue: TcxContainerStyleValue;
begin
  if AExtendedStyle then
    Result := Style.IsExtendedStylePropertyPublished(APropertyName)
  else
    Result := True;
  if Result and Style.GetStyleValue(APropertyName, AStyleValue) then
    Result := not(AStyleValue in InternalGetNotPublishedStyleValues);
end;

procedure TcxContainer.LockAlignControls(ALock: Boolean);
begin
  if ALock then
    Inc(FLockAlignControlsCount)
  else
    if FLockAlignControlsCount > 0 then
      Dec(FLockAlignControlsCount);
end;

procedure TcxContainer.LockPopupMenu(ALock: Boolean);
begin
  if ALock then
    Inc(FPopupMenuLockCount)
  else
    if FPopupMenuLockCount > 0 then
      Dec(FPopupMenuLockCount);
end;

procedure TcxContainer.RestoreStyles;
begin
  FStyles.RestoreDefaults;
end;

procedure TcxContainer.SetScrollBarsParameters(AIsScrolling: Boolean = False);

  procedure SetScrollBarParameters(AScrollBar: TcxScrollBar);
  const
    ABarFlags: array [TScrollBarKind] of Integer = (SB_HORZ, SB_VERT);
  var
    AScrollInfo: TScrollInfo;
  begin
    if not AIsScrolling then
      AdjustScrollBarPosition(AScrollBar);
    if not AScrollBar.Visible then
      Exit;

    AScrollInfo.cbSize := SizeOf(AScrollInfo);
    AScrollInfo.fMask := SIF_ALL;
    GetScrollInfo(FInnerControl.Handle, ABarFlags[AScrollBar.Kind], AScrollInfo);
    with AScrollInfo do
    begin
      if Integer(nPage) > nMax then
        {$IFDEF CLR}nPage{$ELSE}Integer(nPage){$ENDIF} := nMax;
      AScrollBar.SetScrollParams(nMin, nMax, nPos, nPage, True);
    end;
  end;

begin
{$IFDEF USETCXSCROLLBAR}
  if (FInnerControl = nil) or not NeedsScrollBars or IsDestroying or not UsecxScrollBars then
    Exit;
  FScrollBarsCalculating := True;
  try
    SetScrollBarParameters(HScrollBar);
    SetScrollBarParameters(VScrollBar);
  finally
    FScrollBarsCalculating := False;
  end;
{$ENDIF}
end;

function TcxContainer.ShortRefreshContainer(AIsMouseEvent: Boolean): Boolean;
var
  ACursorPos: TPoint;
  AWindowFromPoint: THandle;
begin
  Result := False;
  if not HandleAllocated or IsDestroying or FRefreshingContainer then Exit;
  FRefreshingContainer := True;
  try
    AWindowFromPoint := WindowFromPoint(InternalGetCursorPos);
    if HandleAllocated and IsChildEx(Handle, AWindowFromPoint) then
      ACursorPos := ScreenToClient(InternalGetCursorPos)
    else
      ACursorPos := Point(-1, -1);
    Result := RefreshContainer(ACursorPos, cxmbNone, InternalGetShiftState, AIsMouseEvent);
  finally
    FRefreshingContainer := False;
  end;
end;

procedure TcxContainer.Update;
begin
  inherited Update;
  if InnerControl <> nil then
    InnerControl.Update;
end;

procedure TcxContainer.UpdateScrollBarsParameters;
begin
  if not IsDestroying and HandleAllocated and (InnerControl <> nil) then
    PostMessage(Handle, CM_UPDATESCROLLBARS, 0, 0);
end;

procedure TcxContainer.MouseTrackingCallerMouseLeave;
begin
  EndMouseTracking;
end;

function TcxContainer.GetLookAndFeelValue: TcxLookAndFeel;
begin
  Result := Style.LookAndFeel;
end;

procedure TcxContainer.AdjustClientRect(var Rect: TRect);
begin
  if not IsDestroying then
    Rect := ViewInfo.ClientRect;
end;

procedure TcxContainer.AlignControls(AControl: TControl; var Rect: TRect);
var
  AInnerControlBounds: TcxContainerInnerControlBounds;
begin
  if IsContainerClass then
  begin
    inherited AlignControls(AControl, Rect);
    Exit;
  end;

  if IsAlignControlsLocked or IsInternalControl(AControl) then // ??? !!!
    Exit;
  if AControl = nil then
    inherited AlignControls(AControl, Rect);
  if FIsCreating or (AControl = nil) then
    Exit;
  if (AControl is TWinControl) and TWinControl(AControl).HandleAllocated then
  begin
    AInnerControlBounds := GetInnerControlBounds(Rect, AControl);
    if IsInnerControlBoundsChanged(TWinControl(AControl), AInnerControlBounds) then
    begin
      SetWindowRegion(TWinControl(AControl), AInnerControlBounds);
      SaveInnerControlBounds(TWinControl(AControl), AInnerControlBounds);
    end;
  end;
end;

function TcxContainer.AllowAutoDragAndDropAtDesignTime(X, Y: Integer;
  Shift: TShiftState): Boolean;
begin
  Result := False;
end;

function TcxContainer.CanFocusOnClick: Boolean;
begin
  Result := inherited CanFocusOnClick and not((FInnerControl <> nil) and
    FInnerControl.HandleAllocated and FInnerControl.Focused or
    InnerControlMouseDown);
end;

procedure TcxContainer.ChangeScale(M, D: Integer);

  function NeedFontScaling: Boolean;
  begin
    Result := (M <> D) and Style.IsValueAssigned(csvFont) and
      (not IsLoading or (sfFont in ScalingFlags));
  end;

var
  ANeedFontScaling: Boolean;
begin
  ANeedFontScaling := NeedFontScaling;

  FInternalSetting := not ParentFont;
  try
    inherited ChangeScale(M, D);
  finally
    FInternalSetting := False;
  end;

  if ANeedFontScaling then
    if csvFont in Style.AssignedValues then
      Style.Font.Size := MulDiv(Style.Font.Size, M, D)
    else
      if IsLoading then
        Style.ActiveStyleController.ChangeFontScale(M, D);
end;

procedure TcxContainer.ColorChanged;
begin
  if not FInternalSetting then
    FStyles.Style.Color := Color
  else
  begin
    inherited ColorChanged;
    ShortRefreshContainer(False);
  end;
end;

procedure TcxContainer.CursorChanged;
begin
  inherited CursorChanged;
  if FInnerControl <> nil then
  begin
    FInnerControl.Cursor := Cursor;
  end;
end;

procedure TcxContainer.DoContextPopup(MousePos: TPoint;
  var Handled: Boolean);
begin
  if not IsPopupMenuLocked and ((MousePos.X = -1) and (MousePos.Y = -1) or
    CanShowPopupMenu(MousePos)) then
      inherited DoContextPopup(MousePos, Handled)
  else
    Handled := True;
end;

procedure TcxContainer.DragCanceled;
begin
  inherited DragCanceled;
  if InnerControl <> nil then
{$IFNDEF CLR}
    TWinControlAccess(InnerControl).DragCanceled;
{$ELSE}
    TWinControlAccess._DragCanceled(InnerControl);
{$ENDIF}
end;

procedure TcxContainer.FocusChanged;
begin
  inherited FocusChanged;
  ShortRefreshContainer(False);
end;

function TcxContainer.GetClientBounds: TRect;
begin
  Result := ViewInfo.ClientRect;
end;

function TcxContainer.IsContainerFocused: Boolean;
begin
  Result := Focused;
end;

procedure TcxContainer.KeyDown(var Key: Word; Shift: TShiftState);
var
  AParentForm: TCustomForm;
begin
  inherited KeyDown(Key, Shift);
  case Key of
    VK_TAB:
      if Focused and (Shift * [ssAlt, ssCtrl] = []) and CanContainerHandleTabs then
      begin
        Key := 0;
        AParentForm := GetParentForm(Self);
{$IFNDEF CLR}
        TWinControlAccess(AParentForm).SelectNext(AParentForm.ActiveControl,
          not(ssShift in Shift), True);
{$ELSE}
        TWinControlAccess._SelectNext(AParentForm, AParentForm.ActiveControl,
          not(ssShift in Shift), True);
{$ENDIF}
        if HandleAllocated and (InnerControl <> nil) then
          if GetFocus = Handle then
            InnerControl.SetFocus;
      end;
  end;
end;

procedure TcxContainer.Loaded;
begin
  inherited Loaded;
  ContainerStyleChanged(FStyles.Style);
end;

function TcxContainer.MayFocus: Boolean;
begin
  Result := not((InnerControl <> nil) and InnerControl.Focused);
end;

procedure TcxContainer.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  FShiftState := Shift;
  RefreshContainer(Point(X, Y), ButtonTocxButton(Button), FShiftState, True);
end;

procedure TcxContainer.MouseEnter(AControl: TControl);
begin
  inherited MouseEnter(AControl);
  ShortRefreshContainer(True);
  BeginMouseTracking(Self, VisibleBounds, Self);
end;

procedure TcxContainer.MouseLeave(AControl: TControl);
begin
  inherited MouseLeave(AControl);
  FShiftState := [];
  ShortRefreshContainer(True);
  cxControls.EndMouseTracking(Self);
end;

procedure TcxContainer.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  RefreshContainer(Point(X, Y), cxmbNone, Shift, True);
  BeginMouseTracking(Self, VisibleBounds, Self);
end;

procedure TcxContainer.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  FShiftState := Shift;
  RefreshContainer(Point(X, Y), ButtonTocxButton(Button), FShiftState, True);
end;

function TcxContainer.NeedsScrollBars: Boolean;
begin
  Result := False;
end;

procedure TcxContainer.Paint;
begin
  if RectVisible(Canvas.Handle, ViewInfo.Bounds) then
  begin
    if csPaintCopy in ControlState then
      SetVisibleBoundsClipRect;
    CheckIsViewInfoCalculated;
    ViewInfo.Paint(Canvas);
  end;
end;

procedure TcxContainer.Resize;
begin
  inherited Resize;
  if not FIsCreating then
  begin
    FRefreshingContainer := False;
    ShortRefreshContainer(False);
  end;
end;

procedure TcxContainer.SetDragMode(Value: TDragMode);
begin
  inherited SetDragMode(Value);
  if InnerControl <> nil then
{$IFNDEF CLR}
    TWinControlAccess(InnerControl).DragMode := Value;
{$ELSE}
    (InnerControl as IControl).DragMode := Value;
{$ENDIF}
end;

procedure TcxContainer.CreateHandle;
begin
  inherited CreateHandle;
  PostMessage(Handle, CM_SHORTREFRESHCONTAINER, 0, 0);
end;

procedure TcxContainer.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params.WindowClass do
    style := style and not(CS_HREDRAW or CS_VREDRAW);
end;

procedure TcxContainer.CreateWindowHandle(const Params: TCreateParams);
var
  AParams: TCreateParams;
{$IFDEF CLR}
  AWindowText: IntPtr;
{$ENDIF}
begin
  AParams := Params;
  AParams.Caption := '';
  inherited CreateWindowHandle(AParams);
  if HandleAllocated then
{$IFDEF CLR}
  begin
    AWindowText := Marshal.StringToHGlobalAuto(WindowText);
    try
      CallWindowProc(DefWndProc, Handle, WM_SETTEXT, 0, Integer(AWindowText));
    finally
      Marshal.FreeHGlobal(AWindowText);
    end;
  end;
{$ELSE}
    CallWindowProc(DefWndProc, Handle, WM_SETTEXT, 0, Integer(WindowText));
{$ENDIF}
end;

procedure TcxContainer.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_CHAR, WM_KEYDOWN, WM_KEYUP, CN_CHAR, CN_KEYDOWN, CN_KEYUP:
      if InnerControl <> nil then
      begin
        with TMessage(Message) do
          Result := SendMessage(InnerControl.Handle, Msg, WParam, LParam);
        Exit;
      end;
    WM_SETFOCUS:
      if not Visible then
        Exit;
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
      if (DragMode = dmAutomatic) and not IsDesigning then
      begin
        BeginAutoDrag;
        Exit;
      end;
  end;
  inherited WndProc(Message);
end;

{$IFDEF CLR}
procedure TcxContainer.BeginAutoDrag;
begin
  inherited BeginAutoDrag;
end;

procedure TcxContainer.Click;
begin
  inherited Click;
end;

procedure TcxContainer.DblClick;
begin
  inherited DblClick;
end;

function TcxContainer.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
  MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheel(Shift, WheelDelta, MousePos);
end;

procedure TcxContainer.DragOver(Source: TObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
  inherited DragOver(Source, X, Y, State, Accept);
end;

procedure TcxContainer.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
end;

procedure TcxContainer.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
end;
{$ENDIF}

procedure TcxContainer.AdjustInnerControl;
begin
  if FInnerControl <> nil then
  {$IFNDEF CLR}
    with TWinControlAccess(FInnerControl) do
  {$ELSE}
    with FInnerControl do
  {$ENDIF}
    begin
      Color := ViewInfo.BackgroundColor;
      AssignFonts(Font, ActiveStyle.GetVisibleFont);
    end;
end;

procedure TcxContainer.CalculateViewInfo(const P: TPoint; AMouseTracking: Boolean);

  function GetContainerState: TcxContainerState;
  begin
    if Enabled then
      if IsDesigning then
        Result := [csNormal]
      else
      begin
        if Focused then
          Result := [csActive]
        else
          Result := [csNormal];
        if PtInRect(GetVisibleBounds, P) and AMouseTracking then
          Include(Result, csHotTrack);
      end
    else
      Result := [csDisabled];
  end;

  function GetBorderColor: TColor;
  var
    AIsHighlightBorder: Boolean;
  begin
    if Style.LookAndFeel.SkinPainter <> nil then
    begin
      AIsHighlightBorder := (csActive in ViewInfo.ContainerState) or
        (csHotTrack in ViewInfo.ContainerState) and ActiveStyle.HotTrack or
        IsDesigning and Enabled;
      Result := Style.LookAndFeel.SkinPainter.GetContainerBorderColor(AIsHighlightBorder);  
    end
    else
      if ActiveStyle.BorderStyle in [cbsUltraFlat, cbsOffice11] then
      begin
        AIsHighlightBorder := (csActive in ViewInfo.ContainerState) or
          (csHotTrack in ViewInfo.ContainerState) and ActiveStyle.HotTrack or
          IsDesigning and Enabled;
        if AIsHighlightBorder then
          if ActiveStyle.BorderStyle = cbsOffice11 then
            Result := dxOffice11SelectedBorderColor
          else
            Result := clHighlight
        else
          Result := clBtnShadow;
      end
      else
        Result := ActiveStyle.BorderColor;
  end;

  procedure CalculateColorSettings;
  var
    ATheme: TTheme;
    AColor: COLORREF;
  begin
    ViewInfo.BorderColor := GetBorderColor;
    if ViewInfo.NativeStyle then
    begin
      if Enabled then
        ViewInfo.BackgroundColor := ActiveStyle.Color
      else
      begin
        ATheme := OpenTheme(ViewInfo.ThemedObjectType);
        GetThemeColor(ATheme, ViewInfo.NativePart, ViewInfo.NativePart,
          TMT_FILLCOLOR, AColor);
        ViewInfo.BackgroundColor := AColor;
      end;
    end
    else
      ViewInfo.BackgroundColor := ActiveStyle.Color;
  end;

  procedure CalculateContainerState;
  var
    ASelected: Boolean;
  begin
    ViewInfo.ContainerState := GetContainerState;

    ASelected := ViewInfo.ContainerState * [csActive, csHotTrack] <> [];
    if not ActiveStyle.HotTrack then
      ViewInfo.HotState := chsNoHotTrack
    else
      if ASelected then
        ViewInfo.HotState := chsSelected
      else
        ViewInfo.HotState := chsNormal;

    if ViewInfo.NativeStyle then
      ViewInfo.BorderStyle := Style.BorderStyle
    else
    begin
      ViewInfo.BorderStyle := ActiveStyle.BorderStyle;
      if ViewInfo.BorderStyle in [cbsUltraFlat, cbsOffice11] then
        ViewInfo.BorderStyle := cbsSingle;
    end;
  end;

var
  APrevBorderWidth: Integer;
begin
  ViewInfo.NativeStyle := IsNativeStyle;
  ViewInfo.Painter := Style.LookAndFeel.SkinPainter;

  APrevBorderWidth := GetContainerBorderWidth(ViewInfo.BorderStyle);
  CalculateContainerState;
  if not ViewInfo.NativeStyle and
    (GetContainerBorderWidth(ViewInfo.BorderStyle) < APrevBorderWidth) then
      CalculateContainerState;

  if ViewInfo.NativeStyle then
  begin
    ViewInfo.ThemedObjectType := GetBackgroundThemedObjectType;
    ViewInfo.NativePart := GetBackgroundNativePart;
    ViewInfo.NativeState := GetBackgroundNativeState;
  end;

  ViewInfo.Bounds := GetControlRect(Self);
  ViewInfo.BorderRect := ViewInfo.Bounds;
  with ViewInfo do
    ExtendRect(BorderRect, GetBorderExtent);
  ViewInfo.ClientRect := ViewInfo.BorderRect;
  if ViewInfo.Painter <> nil then
    ViewInfo.BorderWidth := 1
  else
    ViewInfo.BorderWidth := GetContainerBorderWidth(ViewInfo.BorderStyle);
  ViewInfo.Edges := ActiveStyle.Edges;
  ViewInfo.Shadow := HasShadow;
  CalculateColorSettings;
end;

function TcxContainer.CanContainerHandleTabs: Boolean;
begin
  Result := True;
end;

function TcxContainer.CanHaveTransparentBorder: Boolean;
begin
  Result := not (ViewInfo.NativeStyle and (ViewInfo.BorderStyle <> cbsNone));
end;

function TcxContainer.CanShowPopupMenu(const P: TPoint): Boolean;
begin
  Result := True;//PtInRect(ViewInfo.ClientRect, P);
end;

procedure TcxContainer.CheckIsViewInfoCalculated;
begin
  if not IsViewInfoCalculated then
    ShortRefreshContainer(False);
end;

procedure TcxContainer.ContainerStyleChanged(Sender: TObject);
begin
  if FIsCreating or IsLoading then
    Exit;
  ShortRefreshContainer(False);

  if not ParentColor or (csvColor in Style.AssignedValues) then
  begin
    FInternalSetting := True;
    try
      Color := Style.GetStyleColor;
    finally
      FInternalSetting := False;
    end;
  end;

  FInternalSetting := True;
  try
    Font := Style.Font;
  finally
    FInternalSetting := False;
  end;

  if Style.IsValueAssigned(csvFont) then
    ParentFont := False;
end;

procedure TcxContainer.DataChange;
begin
end;

procedure TcxContainer.DataSetChange;
begin
end;

function TcxContainer.DefaultParentColor: Boolean;
begin
  Result := False;
end;

procedure TcxContainer.EnabledChanged;
var
  I: Integer;
begin
  for I := 0 to ControlCount - 1 do
    if Controls[I] is TcxScrollBar then
      TcxScrollBar(Controls[I]).Enabled := Enabled;
  ShortRefreshContainer(False);
end;

procedure TcxContainer.EndMouseTracking;
begin
  MouseLeave(nil);
  cxControls.EndMouseTracking(Self);
end;

function TcxContainer.GetBorderExtent: TRect;
var
  ABorderWidth: Integer;
  ANativeStyle: Boolean;
begin
  ANativeStyle := IsNativeStyle;
  if ActiveStyle.TransparentBorder and (Style.LookAndFeel.SkinPainter = nil) then
    Result := cxContainerDefaultBorderExtent
  else
    if not ActiveStyle.HasBorder or ANativeStyle and (Style.BorderStyle = cbsNone) then
      Result := cxEmptyRect
    else
      if ANativeStyle then
        Result := cxContainerDefaultBorderExtent
      else
      begin
        if Style.LookAndFeel.SkinPainter <> nil then
          ABorderWidth := 1
        else
          ABorderWidth := GetContainerBorderWidth(ViewInfo.BorderStyle);
        Result := cxEmptyRect;
        if bLeft in ActiveStyle.Edges then
          Result.Left := ABorderWidth;
        if bTop in ActiveStyle.Edges then
          Result.Top := ABorderWidth;
        if bRight in ActiveStyle.Edges then
          Result.Right := ABorderWidth;
        if bBottom in ActiveStyle.Edges then
          Result.Bottom := ABorderWidth;
      end;
  if HasShadow then
  begin
    Inc(Result.Right, cxContainerShadowWidth);
    Inc(Result.Bottom, cxContainerShadowWidth);
  end;
end;

function TcxContainer.GetInnerControlBounds(const AInnerControlsRegion: TRect;
  AInnerControl: TControl): TcxContainerInnerControlBounds;
var
  R: TRect;
begin
  if AInnerControl = nil then
  begin
    Result.IsEmpty := True;
    Exit;
  end;

  Result.IsEmpty := False;
  Result.Rect := GetControlRect(AInnerControl);
  R := Result.Rect;
  with AInnerControl.BoundsRect do
  begin
    if Left < AInnerControlsRegion.Left then
      Result.Rect.Left := AInnerControlsRegion.Left - Left;
    if Top < AInnerControlsRegion.Top then
      Result.Rect.Top := AInnerControlsRegion.Top - Top;
    if Right > AInnerControlsRegion.Right then
      Dec(Result.Rect.Right, Right - AInnerControlsRegion.Right);
    if Bottom > AInnerControlsRegion.Bottom then
      Dec(Result.Rect.Bottom, Bottom - AInnerControlsRegion.Bottom);
  end;
  if EqualRect(Result.Rect, R) then
    Result.IsEmpty := True;
end;

function TcxContainer.GetShadowBounds: TRect;
var
  ABorderWidth: Integer;
begin
  Result := ViewInfo.Bounds;
  ExtendRect(Result, GetBorderExtent);
  ABorderWidth := GetContainerBorderWidth(ViewInfo.GetContainerBorderStyle);
  InflateRect(Result, ABorderWidth, ABorderWidth);
  InflateRectByBorders(Result, ABorderWidth, ActiveStyle.Edges);
end;

function TcxContainer.GetStyleClass: TcxContainerStyleClass;
begin
  Result := TcxContainerStyle;
end;

function TcxContainer.GetStylesClass: TcxContainerStylesClass;
begin
  Result := TcxContainerStyles;
end;

function TcxContainer.GetViewInfoClass: TcxContainerViewInfoClass;
begin
  Result := TcxContainerViewInfo;
end;

function TcxContainer.HasShadow: Boolean;
begin
  Result := ActiveStyle.Shadow and not IsNativeStyle;
end;

function TcxContainer.InternalGetActiveStyle: TcxContainerStyle;
begin
  if csDisabled in ViewInfo.ContainerState then
    Result := FStyles.StyleDisabled
  else if csActive in ViewInfo.ContainerState then
    Result := FStyles.StyleFocused
  else if Style.HotTrack and (csHotTrack in ViewInfo.ContainerState) then
    Result := FStyles.StyleHot
  else
    Result := FStyles.Style;
end;

function TcxContainer.InternalGetNotPublishedStyleValues: TcxContainerStyleValues;
begin
  Result := [];
end;

function TcxContainer.IsAlignControlsLocked: Boolean;
begin
  Result := FLockAlignControlsCount > 0;
end;

function TcxContainer.IsInnerControlBoundsChanged(AControl: TWinControl;
  const ABounds: TcxContainerInnerControlBounds): Boolean;
begin
  Result := (AControl = nil) or (AControl <> FInnerControl);
  if not Result and not (FInnerControlBounds.IsEmpty and ABounds.IsEmpty) then
  begin
    Result := FInnerControlBounds.IsEmpty or ABounds.IsEmpty;
    if not Result then
      Result := not EqualRect(FInnerControlBounds.Rect, ABounds.Rect);
  end;
end;

function TcxContainer.IsContainerClass: Boolean;
begin
  Result := False;
end;

function TcxContainer.IsPopupMenuLocked: Boolean;
begin
  Result := FPopupMenuLockCount > 0;
end;

function TcxContainer.IsTransparentBackground: Boolean;
begin
  Result := False;
end;

function TcxContainer.RefreshContainer(const P: TPoint; Button: TcxMouseButton;
  Shift: TShiftState; AIsMouseEvent: Boolean): Boolean;
begin
  Result := True;
  if FIsRefreshLocked or IsDestroying then
    Exit;
  IsViewInfoCalculated := True;
  CalculateViewInfo(P, (Shift = []) and ActiveStyle.HotTrack);
  SetSize;
  AdjustInnerControl;
  SetShadowRegion;
  if FInnerControl = nil then
    InvalidateRect(GetControlRect(Self), False)
  else
    InternalInvalidate(Handle, GetControlRect(Self), ViewInfo.BorderRect, False);

  if csHotTrack in ViewInfo.ContainerState then
    BeginMouseTracking(Self, VisibleBounds, Self);
end;

procedure TcxContainer.SaveInnerControlBounds(AControl: TWinControl;
  const ABounds: TcxContainerInnerControlBounds);
begin
  FInnerControlBounds := ABounds;
end;

procedure TcxContainer.SetShadowRegion;
begin
  if HandleAllocated then
    SetWindowShadowRegion(Handle, GetShadowBounds, not CanHaveTransparentBorder,
      ViewInfo.Shadow, cxEmptyRect);
end;

procedure TcxContainer.SetSize;
begin
  if InnerControl = nil then
    Exit;
  if not EqualRect(InnerControl.BoundsRect, ViewInfo.ClientRect) then
  begin
    FIsRefreshLocked := True;
    try
      with ViewInfo.ClientRect do
        InnerControl.SetBounds(Left, Top, Right - Left, Bottom - Top);
    finally
      FIsRefreshLocked := False;
    end;
  end;
end;

procedure TcxContainer.SetVisibleBoundsClipRect;
var
  AClipRgn: TcxRegionHandle;
begin
  AClipRgn := GetWindowShadowRegion(Handle, GetShadowBounds,
    not CanHaveTransparentBorder, ViewInfo.Shadow, cxEmptyRect);
  if AClipRgn <> 0 then
    Canvas.SetClipRegion(TcxRegion.Create(AClipRgn), roIntersect);
end;

procedure TcxContainer.UpdateData;
begin
end;

procedure TcxContainer.AdjustScrollBarPosition(AScrollBar: TcxScrollBar);
var
  AScrollBarInfo: TcxScrollBarInfo;
  R: TRect;
begin
  if GetScrollBarInfo(AScrollBarInfo, AScrollBar.Kind) and
    IsAdjustingScrollBarPositionNeeded(AScrollBarInfo) then
  begin
    AScrollBar.Enabled := GetScrollBarEnabled(AScrollBar, AScrollBarInfo);
    R := GetScrollBarBounds(AScrollBarInfo.rcScrollBar);
    AScrollBar.SetBounds(R.Left, R.Top, R.Right, R.Bottom);
    SetScrollBarVisible(AScrollBar, (R.Right > 0) and (R.Bottom > 0));
  end
  else
    SetScrollBarVisible(AScrollBar, False);
end;

function TcxContainer.GetBackgroundThemedObjectType: TdxThemedObjectType;
begin
  Result := totEdit;
end;

function TcxContainer.GetBackgroundNativePart: Integer;
begin
  Result := EP_EDITTEXT;
end;

function TcxContainer.GetBackgroundNativeState: Integer;
begin
  with ViewInfo do
  begin
    if not Enabled then
      Result := ETS_DISABLED
    else if Focused then
      Result := ETS_FOCUSED
    else if csHotTrack in ContainerState then
      Result := ETS_HOT
    else
      Result := ETS_NORMAL;
  end;
end;

function TcxContainer.GetScrollBarBounds(const AScrollBarRect: TRect): TRect;
begin
  with AScrollBarRect do
  begin
    Result.TopLeft := ScreenToClient(TopLeft);
    Result.Right := Right - Left;
    Result.Bottom := Bottom - Top;
  end;
  if (Result.Left < 0) or (Result.Right > Width) or
    (Result.Top < 0) or (Result.Bottom > Height) then
      Result := cxEmptyRect;
end;

function TcxContainer.GetScrollBarEnabled(AScrollBar: TcxScrollBar;
  const AScrollBarinfo: TcxScrollBarInfo): Boolean;
begin
  Result := (AScrollBar.Parent <> nil) and
    AScrollBar.Parent.Enabled and
      (AScrollBarInfo.rgstate[0] and STATE_SYSTEM_UNAVAILABLE = 0);
end;

function TcxContainer.GetScrollBarInfo(var AScrollBarInfo: TcxScrollBarInfo;
   const AKind: TScrollBarKind): Boolean;
const
  AScrollBarObjects: array [TScrollBarKind] of Longword = (OBJID_HSCROLL, OBJID_VSCROLL);
begin
  Result := not IsDestroying and (Parent <> nil) and HandleAllocated and
    FInnerControl.HandleAllocated;
  if Result then
  begin
    Result := cxGetScrollBarInfo(FInnerControl.Handle,
      Integer(AScrollBarObjects[AKind]), AScrollBarInfo);
  end;
end;

function TcxContainer.IsAdjustingScrollBarPositionNeeded(
  const AScrollBarInfo: TcxScrollBarInfo): Boolean;
begin
  Result := AScrollBarInfo.rgstate[0] and
    (STATE_SYSTEM_INVISIBLE or STATE_SYSTEM_OFFSCREEN) = 0;
end;

function TcxContainer.IsNativeStyle: Boolean;
begin
  Result := AreVisualStylesMustBeUsed(Style.LookAndFeel.NativeStyle,
    GetBackgroundThemedObjectType);
end;

procedure TcxContainer.SafeSelectionFocusInnerControl;
begin
  InnerControl.SetFocus;
end;

procedure TcxContainer.SetDragKind(Value: TDragKind);
begin
  inherited DragKind := Value;
  if InnerControl <> nil then
{$IFNDEF CLR}
    TWinControlAccess(InnerControl).DragKind := Value;
{$ELSE}
    TWinControlAccess._SetDragKind(InnerControl, Value);
{$ENDIF}
end;

procedure TcxContainer.SetScrollBarVisible(AScrollBar: TcxScrollBar;
  AVisible: Boolean);
begin
  AScrollBar.Visible := AVisible;
  if AVisible then
  begin
    AScrollBar.Ctl3D := False;
    AScrollBar.BringToFront;
  end;
end;

function TcxContainer.GetActiveControl: TWinControl;
begin
  if FInnerControl = nil then
    Result := Self
  else
    Result := FInnerControl;
end;

function TcxContainer.GetActiveStyle: TcxContainerStyle;
begin
  if FActiveStyleData.ContainerState = ViewInfo.ContainerState then
    Result := FActiveStyleData.ActiveStyle
  else
  begin
    FActiveStyleData.ContainerState := ViewInfo.ContainerState;
    FActiveStyleData.ActiveStyle := InternalGetActiveStyle;
    Result := FActiveStyleData.ActiveStyle;
  end;
end;

function TcxContainer.GetFakeStyleController: TcxStyleController;
begin
  Result := Style.StyleController;
end;

function TcxContainer.GetInternalStyle(AState: TcxContainerStateItem): TcxContainerStyle;
begin
  Result := FStyles[AState];
end;

function TcxContainer.GetIsDestroying: Boolean;
begin
  Result := (csDestroying in ComponentState) or FIsDestroying;
end;

function TcxContainer.GetStyle: TcxContainerStyle;
begin
  Result := TcxContainerStyle(FStyles.Style);
end;

function TcxContainer.GetStyleDisabled: TcxContainerStyle;
begin
  Result := TcxContainerStyle(FStyles.StyleDisabled);
end;

function TcxContainer.GetStyleFocused: TcxContainerStyle;
begin
  Result := TcxContainerStyle(FStyles.StyleFocused);
end;

function TcxContainer.GetStyleHot: TcxContainerStyle;
begin
  Result := TcxContainerStyle(FStyles.StyleHot);
end;

procedure TcxContainer.SetFakeStyleController(Value: TcxStyleController);
begin
end;

procedure TcxContainer.SetStyle(Value: TcxContainerStyle);
begin
  FStyles.Style := Value;
end;

procedure TcxContainer.SetStyleDisabled(Value: TcxContainerStyle);
begin
  FStyles.StyleDisabled := Value;
end;

procedure TcxContainer.SetStyleFocused(Value: TcxContainerStyle);
begin
  FStyles.StyleFocused := Value;
end;

procedure TcxContainer.SetStyleHot(Value: TcxContainerStyle);
begin
  FStyles.StyleHot := Value;
end;

procedure TcxContainer.SetInternalStyle(AState: TcxContainerStateItem;
  Value: TcxContainerStyle);
begin
  FStyles[AState] := Value;
end;

function TcxContainer.GetDragKind: TDragKind;
begin
  Result := inherited DragKind;
end;

procedure TcxContainer.WMKillFocus(var Message: TWMKillFocus);
begin
  if InnerControl <> nil then
  begin
    if not InnerControl.HandleAllocated or (Message.FocusedWnd <> InnerControl.Handle) then
    begin
      inherited;
      Exit;
    end;
    Message.Msg := 0;
    Message.Result := 0;
  end
  else
    inherited;
end;

procedure TcxContainer.WMNCPaint(var Message: TWMNCPaint);
begin
  Message.Result := 0;
end;

procedure TcxContainer.WMSetCursor(var Message: TWMSetCursor);
begin
  with Message do
    if (FInnerControl <> nil) and (CursorWnd = Handle) and
      (Smallint(HitTest) = HTCLIENT) and not PtInRect(ViewInfo.ClientRect, ScreenToClient(InternalGetCursorPos)) then
    begin
      Windows.SetCursor(Screen.Cursors[crArrow]);
      Result := 1;
      Exit;
    end;
  inherited;
end;

procedure TcxContainer.WMSetFocus(var Message: TWMSetFocus);
begin
  if not IsDestroying and HandleAllocated and (InnerControl <> nil) and
    InnerControl.HandleAllocated then
  begin
    if Message.FocusedWnd <> InnerControl.Handle then
    begin
      inherited;
      if InnerControl.CanFocus then
        InnerControl.SetFocus;
      Exit;
    end;
    Message.Msg := 0;
    Message.Result := 0;
  end
  else
    inherited;
end;

procedure TcxContainer.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  if not IsDestroying and IsTransparentBackground then
    ShortRefreshContainer(False);
end;

procedure TcxContainer.WMWindowPosChanging(var Message: TWMWindowPosChanging);
var
  AParentForm: TCustomForm;
begin
  if IsDestroying then
  begin
    Message.Result := 0;
    Exit;
  end
  else
    inherited;
  if (GetFocus = Handle) and (InnerControl <> nil) and InnerControl.HandleAllocated and
    InnerControl.CanFocus then
  begin
    AParentForm := GetParentForm(Self);
    AParentForm.FocusControl(InnerControl);
  end;
end;

procedure TcxContainer.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  ShortRefreshContainer(False);
end;

procedure TcxContainer.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  EnabledChanged;
end;

procedure TcxContainer.CMFontChanged(var Message: TMessage);
var
  APrevIsFontAssigned: Boolean;
begin
  if not FInternalSetting then
  begin
    APrevIsFontAssigned := csvFont in Style.FAssignedValues;
    Style.Font := Font;
    if not APrevIsFontAssigned then
      Exclude(Style.FAssignedValues, csvFont);
    inherited;
  end
  else
  begin
    inherited;
    SetSize;
    SetScrollBarsParameters;
    ShortRefreshContainer(False);
  end;
end;

procedure TcxContainer.CMParentColorChanged(var Message: TMessage);
var
  APrevIsStyleColorAssigned: Boolean;
begin
  APrevIsStyleColorAssigned := csvColor in FStyles.Style.FAssignedValues;
  inherited; // TODO CLX ???
  if not APrevIsStyleColorAssigned or ParentColor then
    Exclude(FStyles.Style.FAssignedValues, csvColor);
  if Color <> Style.Color then
    ContainerStyleChanged(Style);

  if IsTransparentBackground and not ParentColor then
    Invalidate;
end;

procedure TcxContainer.CMShortRefreshContainer(var Message: TMessage);
begin
  ShortRefreshContainer(False);
end;

{$IFNDEF CLR}
procedure TcxContainer.CMParentFontChanged(var Message: TMessage);
{$ELSE}
procedure TcxContainer.CMParentFontChanged(var Message: TCMParentFontChanged);
{$ENDIF}
var
  APrevIsStyleFontAssigned: Boolean;
begin
  APrevIsStyleFontAssigned := csvFont in FStyles.Style.FAssignedValues;
  inherited; // TODO CLX ???
  if not ParentFont then
    FStyles.Style.UpdateFont;
  if not APrevIsStyleFontAssigned or ParentFont then
    Exclude(FStyles.Style.FAssignedValues, csvFont);
end;

procedure TcxContainer.CMSysColorChange(var Message: TMessage);
begin
  inherited;
  ShortRefreshContainer(False);
end;

procedure TcxContainer.CMUpdateScrollBars(var Message: TMessage);
begin
  SetScrollBarsParameters;
end;
                                                            
{ TcxCustomPopupWindow }

constructor TcxCustomPopupWindow.Create(AOwnerControl: TWinControl);
begin
  inherited Create;
  FormStyle := fsNormal;
  Visible := False;

  FStyle := GetStyleClass.Create(Self, False);
  FStyle.OnChanged := PopupWindowStyleChanged;
  FViewInfo := GetViewInfoClass.Create;

  FCaptureFocus := True;
  FOwnerControl := AOwnerControl;

  KeyPreview := True;
  FModalMode := True;
end;

destructor TcxCustomPopupWindow.Destroy;
begin
  cxClearObjectLinks(Self);
{$IFDEF DELPHI9}
  PopupMode := pmNone;  // to set FInternalPopupParent to nil
//  PopupParent := nil;
{$ENDIF}
  if IsVisible then
    FVisiblePopupWindowList.Remove(Self);
  FreeAndNil(FViewInfo);
  FStyle.OnChanged := nil;
  FreeAndNil(FStyle);
  inherited Destroy;
end;

function TcxCustomPopupWindow.Focused: Boolean;
var
  AFocusedControl: TcxNativeHandle;
  AIndex: Integer;
begin
  Result := False;
  AIndex := FVisiblePopupWindowList.IndexOf(Self);
  if AIndex = -1 then
    Exit;
  if CaptureFocus then
  begin
    AFocusedControl := GetFocus;
    Result := HasNativeHandle(Self, AFocusedControl, True);
  end;
end;

{$IFDEF DELPHI5}
function TcxCustomPopupWindow.CanFocus: Boolean;
begin
  Result := Visible;
end;
{$ENDIF}

procedure TcxCustomPopupWindow.ClosePopup;
begin
  PostMessage(NativeHandle(Handle), CM_CLOSEPOPUPWINDOW, 0, 0);
end;

procedure TcxCustomPopupWindow.CloseUp;
begin
  if FVisiblePopupWindowList.IndexOf(Self) = -1 then
    Exit;

  FVisiblePopupWindowList.Remove(Self);
  DoClosing;

  FPopupWindowShowing := True;
  FBeingShownPopupWindow := Self;
  try
    ShowWindow(NativeHandle(Handle), SW_HIDE);
    Hide;
    DoClosed;
    if HandleAllocated and HasNativeHandle(Self, GetCapture, True) then
      SetCaptureControl(nil);
  finally
    FPopupWindowShowing := False;
  end;
end;

procedure TcxCustomPopupWindow.CorrectBoundsWithDesktopWorkArea(
  var APosition: TPoint);
var
  ADesktopWorkArea: TRect;
  AWidth, AHeight: Integer;
begin
  if not AcceptsAnySize then
    Exit;

  AWidth := Width;
  AHeight := Height;
  ADesktopWorkArea := GetDesktopWorkArea(APosition);
  with APosition do
  begin
    if X < ADesktopWorkArea.Left then
    begin
      AWidth := AWidth + X - ADesktopWorkArea.Left;
      X := ADesktopWorkArea.Left;
    end;
    if Y < ADesktopWorkArea.Top then
    begin
      AHeight := AHeight + Y - ADesktopWorkArea.Top;
      Y := ADesktopWorkArea.Top;
    end;
    if AWidth > ADesktopWorkArea.Right - X then
      AWidth := ADesktopWorkArea.Right - X;
    if AHeight > ADesktopWorkArea.Bottom - Y then
      AHeight := ADesktopWorkArea.Bottom - Y;
    Width := AWidth;
    Height := AHeight;
    if (Height <> AHeight) and (Y = ADesktopWorkArea.Top) then
      Inc(APosition.Y, AHeight - Height);
  end;
end;

function TcxCustomPopupWindow.GetStyleClass: TcxContainerStyleClass;
begin
  Result := TcxContainerStyle;
end;

function TcxCustomPopupWindow.GetViewInfoClass: TcxContainerViewInfoClass;
begin
  Result := TcxContainerViewInfo;
end;

function TcxCustomPopupWindow.HasCapture: Boolean;
begin
  Result := HasNativeHandle(Self, GetCapture);
end;

function TcxCustomPopupWindow.IsVisible: Boolean;
begin
  Result := (FVisiblePopupWindowList <> nil) and
    (FVisiblePopupWindowList.IndexOf(Self) <> -1);
end;

procedure TcxCustomPopupWindow.LockDeactivate(ALock: Boolean);
begin
  if ALock then
    Inc(FDeactivateLockCount)
  else
    Dec(FDeactivateLockCount);
end;

procedure TcxCustomPopupWindow.AdjustClientRect(var Rect: TRect);
begin
  Rect := ViewInfo.ClientRect;
end;

procedure TcxCustomPopupWindow.Deactivate;
var
  AActiveWnd: TcxHandle;
  APopupWindow: TcxCustomPopupWindow;
  I: Integer;
begin
  FDeactivation := False;
  if IsDeactivateLocked then
    Exit;

  if FVisiblePopupWindowList.Count > 0 then
  begin
    AActiveWnd := GetActiveWindow;
    for I := FVisiblePopupWindowList.Count - 1 downto 0 do
    begin
      APopupWindow := TcxCustomPopupWindow(FVisiblePopupWindowList[I]);
      if HasHandle(APopupWindow, AActiveWnd) then
        Exit;
      if IsWindowEnabled(APopupWindow.Handle) and not APopupWindow.IsDeactivateLocked then
        APopupWindow.CloseUp;
    end;
  end;
  if FVisiblePopupWindowList.Count > 0 then CloseUp;
end;

function TcxCustomPopupWindow.GetOwnerScreenBounds: TRect;
begin
  Result := OwnerBounds;
  if IsChildClassWindow(OwnerControl.Handle) then
    with Result do
    begin
      TopLeft := OwnerParent.ClientToScreen(TopLeft);
      BottomRight := OwnerParent.ClientToScreen(BottomRight);
    end;
end;

procedure TcxCustomPopupWindow.InitPopup;
begin
end;

procedure TcxCustomPopupWindow.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if IsVisible and HasCapture and (Key = VK_ESCAPE) then
  begin
    SetCaptureControl(nil);
    Key := 0;
  end
  else
    inherited KeyDown(Key, Shift);
end;

procedure TcxCustomPopupWindow.Paint;
begin
  ViewInfo.Paint(Canvas);
end;

procedure TcxCustomPopupWindow.VisibleChanged;
var
  AParentForm: TCustomForm;
begin
  inherited VisibleChanged;
  if CaptureFocus and (OwnerControl <> nil) and HandleAllocated and
    not IsWindowVisible(NativeHandle(Handle)) then
  begin
    AParentForm := GetParentForm(FOwnerControl);
    if (AParentForm <> nil) and HasNativeHandle(AParentForm, GetFocus) and
      OwnerControl.CanFocus and not (csDesigning in AParentForm.ComponentState) then
        OwnerControl.SetFocus;
  end;
end;

procedure TcxCustomPopupWindow.CreateHandle;
var
  FIsInVisiblePopupWindowList: Boolean;
begin
  FIsInVisiblePopupWindowList := False;
  if FVisiblePopupWindowList.IndexOf(Self) = -1 then
    FVisiblePopupWindowList.Add(Self)
  else
    FIsInVisiblePopupWindowList := True;
  inherited CreateHandle;
  if not FIsInVisiblePopupWindowList then
    FVisiblePopupWindowList.Remove(Self);
end;

procedure TcxCustomPopupWindow.CreateParams(var Params: TCreateParams);
var
  AParentForm: TCustomForm;
begin
  inherited CreateParams(Params);
  with Params do
  begin
    if CaptureFocus then
    begin
      AParentForm := GetParentForm(OwnerControl);
      if AParentForm <> nil then
        WndParent := AParentForm.Handle;
      Style := Style and not WS_CHILD;
      Style := Style or WS_POPUP;
//      ExStyle := ExStyle or WS_EX_TOOLWINDOW;
      if FIsTopMost and ((AParentForm = nil) or (GetWindowLong(AParentForm.Handle,
          GWL_EXSTYLE) and WS_EX_TOPMOST <> 0)) then
        ExStyle := ExStyle or WS_EX_TOPMOST;
    end else
    begin
      Style := WS_CHILD;
      ExStyle := ExStyle or WS_EX_TOOLWINDOW;
      if Params.WndParent = 0 then
        Params.WndParent := cxMessageWindow.Handle;
    end;
    Style := Style or WS_CLIPCHILDREN;
  end;
end;

procedure TcxCustomPopupWindow.CreateWnd;
begin
{$IFDEF DELPHI9}
  if CaptureFocus then
    PopupParent := GetParentForm(FOwnerControl)
  else
    PopupParent := nil;
{$ENDIF}
  inherited CreateWnd;
  if not CaptureFocus then
    Windows.SetParent(Handle, 0);
end;

procedure TcxCustomPopupWindow.PopupWindowStyleChanged(Sender: TObject);
begin
end;

procedure TcxCustomPopupWindow.RecreateWindow;
begin
  if HandleAllocated then
    RecreateWnd;
end;

procedure TcxCustomPopupWindow.Popup(AFocusedControl: TWinControl);

  function IsTopMostPopupWindow: Boolean;
  var
    I: Integer;
    AParentForm: TCustomForm;
  begin
    AParentForm := GetParentForm(OwnerControl);
    Result := (AParentForm = nil) or
      (GetWindowLong(AParentForm.Handle, GWL_EXSTYLE) and WS_EX_TOPMOST <> 0);
    if not Result and not CaptureFocus then
      for I := 0 to Screen.FormCount - 1 do
        if (Screen.Forms[I].FormStyle = fsStayOnTop) and not Screen.Forms[I].Visible then
        begin
          Result := True;
          Break;
        end;
  end;

  function GetPopupWindowShowingFlags: UINT;
  begin
    if IsTopMostPopupWindow or (not CaptureFocus and TopMostComboBoxes) then
      Result := HWND_TOPMOST
    else
      Result := 0;
  end;

  procedure ShowPopupWindow;
  var
    P: TPoint;
  begin
    InitPopup;
    CalculateSize;
    P := CalculatePosition;
    CorrectBoundsWithDesktopWorkArea(P);
    FPopupWindowShowing := True;
    FBeingShownPopupWindow := Self;
    try
      FVisiblePopupWindowList.Add(Self);
      DoShowing;
      SetBounds(P.X, P.Y, Width, Height);
      Show;
    {$IFDEF DELPHI8}
      SetBounds(P.X, P.Y, Width, Height);
    {$ENDIF}
      if CaptureFocus then
        FFocusedControl := GetFirstFocusControl(AFocusedControl)
      else
        FFocusedControl := AFocusedControl;
      if FFocusedControl = nil then
        SetFocus
      else
        FFocusedControl.SetFocus;
      SetWindowPos(NativeHandle(Handle), GetPopupWindowShowingFlags, 0, 0, 0, 0,
        SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW);
    finally
      FPopupWindowShowing := False;
    end;
  end;

var
  Msg: TMsg;
begin
  if (FVisiblePopupWindowList.IndexOf(Self) <> -1) or not IsOwnerControlVisible then
    Exit;

  ShowPopupWindow;
  ModalResult := mrNone;
  DoShowed;
  if FCaptureFocus and ModalMode then
    while Visible and not Application.Terminated do
    begin
      if PeekMessage(Msg, 0, WM_SYSKEYDOWN, WM_SYSKEYDOWN, PM_NOREMOVE) then
        case Msg.wParam of
          Windows.VK_MENU, Windows.VK_RETURN, Windows.VK_SPACE:
            PeekMessage(Msg, 0, Msg.message, Msg.message, PM_REMOVE);
        end;
      if ModalResult <> mrNone then
        if CloseQuery then
          ModalCloseUp
        else
          ModalResult := mrNone;
      Application.HandleMessage;
    end;
end;

function TcxCustomPopupWindow.AcceptsAnySize: Boolean;
begin
  Result := False;
end;

procedure TcxCustomPopupWindow.DoClosed;
begin
  if Assigned(FOnClosed) then
    FOnClosed(Self);
end;

procedure TcxCustomPopupWindow.DoClosing;
begin
  if Assigned(FOnClosing) then
    FOnClosing(Self);
end;

procedure TcxCustomPopupWindow.DoShowed;
begin
  if Assigned(FOnShowed) then
    FOnShowed(Self);
end;

procedure TcxCustomPopupWindow.DoShowing;
begin
  if Assigned(FOnShowing) then
    FOnShowing(Self);
end;

function TcxCustomPopupWindow.GetFirstFocusControl(AControl: TWinControl): TWinControl;
begin
  if AControl = nil then
    Result := Self
  else
    if AControl.CanFocus and AControl.TabStop then
      Result := AControl
    else
    begin
      Result := FindNextControl(nil, True, True, False);
      if Result = nil then
        Result := Self;
    end;
end;

function TcxCustomPopupWindow.HasBackground;
begin
  Result := False;
end;

function TcxCustomPopupWindow.IsDeactivateLocked: Boolean;
begin
  Result := FDeactivateLockCount <> 0;
end;

function TcxCustomPopupWindow.IsOwnerControlVisible: Boolean;
begin
  Result := OwnerControl.HandleAllocated and IsWindowVisible(OwnerControl.Handle);
end;

function TcxCustomPopupWindow.IsSysKeyAccepted(Key: Word): Boolean;
begin
  case Key of
    Windows.VK_F4, Windows.VK_LEFT, Windows.VK_RIGHT, Windows.VK_UP,
    Windows.VK_DOWN, Windows.VK_PRIOR, Windows.VK_NEXT, Windows.VK_HOME,
    Windows.VK_END:
      Result := True;
    else
      Result := False;
  end;
end;

procedure TcxCustomPopupWindow.ModalCloseUp;
begin
  CloseUp;
end;

procedure TcxCustomPopupWindow.MouseEnter(AControl: TControl);
begin
end;

procedure TcxCustomPopupWindow.MouseLeave(AControl: TControl);
begin
end;

function TcxCustomPopupWindow.NeedIgnoreMouseMessageAfterCloseUp(AMsg: Cardinal;
  AShift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := False;
end;

function TcxCustomPopupWindow.GetJustClosed: Boolean;
begin
  Result := FJustClosed;
  FJustClosed := False;
end;

procedure TcxCustomPopupWindow.SetCaptureFocus(Value: Boolean);
begin
  if Value <> FCaptureFocus then
  begin
    FCaptureFocus := Value;
    RecreateWindow;
    if IsVisible then
    begin
      CloseUp;
      Popup(FocusedControl);
    end;
  end;
end;

procedure TcxCustomPopupWindow.SetIsTopMost(Value: Boolean);
begin
  if Value <> FIsTopMost then
  begin
    FIsTopMost := Value;
    RecreateWindow;
    if IsVisible then
    begin
      CloseUp;
      Popup(FocusedControl);
    end;
  end;
end;

procedure TcxCustomPopupWindow.WMActivateApp(var Message: TWMActivateApp);
begin
end;

procedure TcxCustomPopupWindow.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if HasBackground then
    inherited
  else
    Message.Result := 1;
end;

procedure TcxCustomPopupWindow.CMClosePopupWindow(var Message: TMessage);
begin
  LockDeactivate(True);
  try
    CloseUp;
  finally
    LockDeactivate(False);
  end;
  if OwnerControl.HandleAllocated then
    SendMessage(OwnerControl.Handle, WM_SETFOCUS, 0, 0);
end;

procedure TcxCustomPopupWindow.CMMouseEnter(var Message: TMessage);
begin
  inherited;
{$IFDEF CLR}
  MouseEnter(nil); // TODO
{$ELSE}
  if Message.lParam = 0 then
    MouseEnter(Self)
  else
    MouseEnter(TControl(Message.lParam));
{$ENDIF}
end;

procedure TcxCustomPopupWindow.CMMouseLeave(var Message: TMessage);
begin
  inherited;
{$IFDEF CLR}
  MouseLeave(nil); // TODO
{$ELSE}
  if Message.lParam = 0 then
    MouseLeave(Self)
  else
    MouseLeave(TControl(Message.lParam));
{$ENDIF}
end;

procedure TcxCustomPopupWindow.CMShowPopupWindow(var Message: TMessage);
begin
  Popup(FocusedControl);
end;

{ TcxCustomInnerListBox }

constructor TcxCustomInnerListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFNDEF DELPHI6}
  FAutoComplete := True;
{$ENDIF}
{$IFNDEF DELPHI8}
  FAutoCompleteDelay := cxDefaultAutoCompleteDelay;
{$ENDIF}
  FCanvas := TcxCanvas.Create(inherited Canvas);
  CreateScrollBars;
  FLookAndFeel := TcxLookAndFeel.Create(Self);
  FLookAndFeel.OnChanged := LookAndFeelChanged;
  FHScrollBar.LookAndFeel.MasterLookAndFeel := FLookAndFeel;
  FVScrollBar.LookAndFeel.MasterLookAndFeel := FLookAndFeel;
  BorderStyle := bsNone;
  ControlStyle := ControlStyle + [csDoubleClicks] - [csOpaque];
  ParentColor := False;
  ParentFont := True;
end;

destructor TcxCustomInnerListBox.Destroy;
begin
  if (FHScrollBar <> nil) and (FHScrollBar.Parent = nil) then
    FreeAndNil(FHScrollBar);
  if (FVScrollBar <> nil) and (FVScrollBar.Parent = nil) then
    FreeAndNil(FVScrollBar);
  FreeAndNil(FLookAndFeel);
  FreeAndNil(FCanvas);
  inherited Destroy;
end;

procedure TcxCustomInnerListBox.DefaultHandler(var Message);
{$IFDEF CLR}
var
  AMsg: TMessage;
{$ENDIF}
begin
{$IFDEF CLR}
  AMsg := UnwrapMessage(TObject(Message));
{$ENDIF}
  if (Container = nil) or
    not Container.InnerControlDefaultHandler({$IFDEF CLR}AMsg{$ELSE}TMessage(Message){$ENDIF}) then
      inherited DefaultHandler(Message);
end;

procedure TcxCustomInnerListBox.DragDrop(Source: TObject; X, Y: Integer);
begin
  if Container <> nil then
    Container.DragDrop(Source, Left + X, Top + Y);
end;

procedure TcxCustomInnerListBox.SetExternalScrollBarsParameters;

  procedure AdjustScrollBarPosition(AScrollBar: TcxScrollBar);
  const
    AScrollBarObjects: array [TScrollBarKind] of Longword = (OBJID_HSCROLL, OBJID_VSCROLL);
  var
    AScrollBarInfo: TcxScrollBarInfo;
    AScrollBarState: DWORD;
    AScrollBarVisible: Boolean;
    R: TRect;
  begin
    AScrollBarVisible := False;
    repeat
      if Parent = nil then
        Break;
      if not cxGetScrollBarInfo(Handle, Integer(AScrollBarObjects[AScrollBar.Kind]), AScrollBarInfo) then
        Break;
      AScrollBarState := AScrollBarInfo.rgstate[0];
      if AScrollBarState and (STATE_SYSTEM_INVISIBLE or STATE_SYSTEM_OFFSCREEN) <> 0 then
        Break;
      AScrollBarVisible := True;
      AScrollBar.Enabled := (AScrollBarState and STATE_SYSTEM_UNAVAILABLE = 0) and
        (AScrollBar.Parent <> nil) and AScrollBar.Parent.Enabled;
      with AScrollBarInfo.rcScrollBar do
      begin
        R.TopLeft := Parent.ScreenToClient(TopLeft);
        R.Right := Right - Left;
        R.Bottom := Bottom - Top;
      end;
      with R do
      begin
        if (Left < 0) or (Right > Width) or (Top < 0) or (Bottom > Height) then
          AScrollBarVisible := False
        else
          AScrollBar.SetBounds(Left, Top, Right, Bottom);
      end;
    until True;
    if AScrollBarVisible then
    begin
      Inc(FScrollBarsLockCount);
      try
        AScrollBar.Parent := Parent;
      finally
        Dec(FScrollBarsLockCount);
      end;
      AScrollBar.Ctl3D := False;
      AScrollBar.BringToFront;
    end
    else
      AScrollBar.SetBounds(0, 0, 0, 0);
    AScrollBar.Visible := AScrollBarVisible;
  end;

  procedure SetScrollBarParameters(AScrollBar: TcxScrollBar);
  const
    ABarFlags: array [TScrollBarKind] of Integer = (SB_HORZ, SB_VERT);
  var
    AScrollInfo: TScrollInfo;
  begin
    AdjustScrollBarPosition(AScrollBar);
    if not AScrollBar.Visible then
      Exit;

    AScrollInfo.cbSize := SizeOf(AScrollInfo);
    AScrollInfo.fMask := SIF_ALL;
    GetScrollInfo(Handle, ABarFlags[AScrollBar.Kind], AScrollInfo);
    with AScrollInfo do
    begin
      if Integer(nPage) > nMax then
        {$IFDEF CLR}nPage{$ELSE}Integer(nPage){$ENDIF} := nMax;
      AScrollBar.SetScrollParams(nMin, nMax, nPos, nPage, True);
    end;
  end;

begin
  if (csDestroying in ComponentState) or (FScrollBarsLockCount > 0) or
    not UsecxScrollBars or IsRedrawLocked then
      Exit;
  FScrollBarsCalculating := True;
  try
    SetScrollBarParameters(FHScrollBar);
    SetScrollBarParameters(FVScrollBar);
  finally
    FScrollBarsCalculating := False;
  end;
end;

{$IFNDEF DELPHI6}
procedure TcxCustomInnerListBox.AddItem(AItem: string; AObject: TObject);
var
  S: string;
begin
  SetString(S, PChar(AItem), StrLen(PChar(AItem)));
  Items.AddObject(S, AObject);
end;

procedure TcxCustomInnerListBox.ClearSelection;
var
  I: Integer;
begin
  if MultiSelect then
    for I := 0 to Items.Count - 1 do
      Selected[I] := False
  else
    ItemIndex := -1;
end;

procedure TcxCustomInnerListBox.DeleteSelected;
var
  I: Integer;
begin
  if MultiSelect then
    for I := Items.Count - 1 downto 0 do
    begin
      if Selected[I] then
        Items.Delete(I);
    end
  else
    if ItemIndex <> -1 then
      Items.Delete(ItemIndex);
end;

procedure TcxCustomInnerListBox.SelectAll;
var
  I: Integer;
begin
  if MultiSelect then
    for I := 0 to Items.Count - 1 do
      Selected[I] := True;
end;
{$ENDIF}

function TcxCustomInnerListBox.ItemVisible(Index: Integer): Boolean;
var
  R: TRect;
begin
  R := GetControlRect(Self);
  with ItemRect(Index) do
  begin
    Result := PtInRect(R, TopLeft);
    Result := Result or PtInRect(R, Point(Right - 1, Top));
    Result := Result or PtInRect(R, Point(Left, Bottom - 1));
    Result := Result or PtInRect(R, Point(Right - 1, Bottom - 1));
  end;
end;

procedure TcxCustomInnerListBox.Click;
begin
  inherited Click;
  FVScrollBar.Position := TopIndex;
  if Container <> nil then
    Container.Click;
end;

procedure TcxCustomInnerListBox.DblClick;
begin
  inherited DblClick;
  if Container <> nil then
    Container.DblClick;
end;

procedure TcxCustomInnerListBox.DestroyWindowHandle;
begin
  FIsRedrawLocked := False;
  inherited DestroyWindowHandle;
end;

procedure TcxCustomInnerListBox.DoAutoComplete(var Key: Char);
var
  AIndex: Integer;
{$IFNDEF CLR}
  AMsg: TMsg;
{$ENDIF}
begin
  if not AutoComplete then
    Exit;
  if GetTickCount - FPrevKeyPressTime >= AutoCompleteDelay then
    FAutoCompleteFilter := '';
  FPrevKeyPressTime := GetTickCount;

  if Key = Char(VK_BACK) then
  begin
    AIndex := Length(FAutoCompleteFilter);
  {$IFNDEF CLR}
    while ByteType(FAutoCompleteFilter, AIndex) = mbTrailByte do
      Dec(AIndex);
  {$ENDIF}
    Delete(FAutoCompleteFilter, AIndex, Length(FAutoCompleteFilter) - AIndex + 1);
  end
  else
  {$IFNDEF CLR}
    if Key in LeadBytes then
    begin
      if PeekMessage(AMsg, Handle, WM_CHAR, WM_CHAR, PM_REMOVE) then
      begin
        FAutoCompleteFilter := FAutoCompleteFilter + Key + Chr(AMsg.wParam);
        Key := #0;
      end;
    end
    else
  {$ENDIF}
      FAutoCompleteFilter := FAutoCompleteFilter + Key;

  if Length(FAutoCompleteFilter) > 0 then
  begin
    AIndex := FindAutoCompleteString(FAutoCompleteFilter);
    if AIndex <> -1 then
    begin
      if MultiSelect then
      begin
        ClearSelection;
        SendMessage(Handle, LB_SELITEMRANGE, 1, MakeLParam(AIndex, AIndex));
      end;
      ItemIndex := AIndex;
      Click;
    end;
    if not (Ord(Key) in [VK_RETURN, VK_BACK, VK_ESCAPE]) then
      Key := #0;
  end
  else
  begin
    ItemIndex := 0;
    Click;
  end;
end;

function TcxCustomInnerListBox.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
   MousePos: TPoint): Boolean;
begin
  Result := (Container <> nil) and Container.DoMouseWheel(Shift,
    WheelDelta, MousePos);
  if not Result then
    Result := inherited DoMouseWheel(Shift, WheelDelta, MousePos);
end;

procedure TcxCustomInnerListBox.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if Container <> nil then
    Container.DragOver(Source, Left + X, Top + Y, State, Accept);
end;

function TcxCustomInnerListBox.GetPopupMenu: TPopupMenu;
begin
  if Container = nil then
    Result := inherited GetPopupMenu
  else
    Result := Container.GetPopupMenu;
end;

function TcxCustomInnerListBox.GetSizeGripRect: TRect;
var
  R: TRect;
begin
  if FHScrollBar.Visible and FVScrollBar.Visible then
  begin
    Result.TopLeft := Parent.ClientToScreen(Point(FVScrollBar.Left, FHScrollBar.Top));
    GetWindowRect(Handle, R);
    Dec(Result.Left, R.Left);
    Dec(Result.Top, R.Top);
    Result.Right := Result.Left + FVScrollBar.Width;
    Result.Bottom := Result.Top + FHScrollBar.Height;
  end
  else
    Result := cxEmptyRect;
end;

procedure TcxCustomInnerListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Container <> nil then
    Container.KeyDown(Key, Shift);
  if Key <> 0 then
    inherited KeyDown(Key, Shift);
end;

procedure TcxCustomInnerListBox.KeyPress(var Key: Char);
begin
  if Key = Char(VK_TAB) then
    Key := #0;
  if (Key <> #0) and (Container <> nil) then
    Container.KeyPress(Key);
  if Key = Char(VK_RETURN) then
    Key := #0;
  if Key <> #0 then
  begin
    if Assigned(OnKeyPress) then
      OnKeyPress(Self, Key);
    if Key <> #0 then
      DoAutoComplete(Key);
  end;
end;

procedure TcxCustomInnerListBox.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_TAB) then
    Key := 0;
  if Container <> nil then
    Container.KeyUp(Key, Shift);
  if Key <> 0 then
    inherited KeyUp(Key, Shift);
end;

procedure TcxCustomInnerListBox.LookAndFeelChanged(Sender: TcxLookAndFeel;
  AChangedValues: TcxLookAndFeelValues);
begin
  if HandleAllocated then
    Invalidate;
end;

procedure TcxCustomInnerListBox.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if Container <> nil then
    with Container do
    begin
      InnerControlMouseDown := True;
      try
        MouseDown(Button, Shift, X + Self.Left, Y + Self.Top);
      finally
        InnerControlMouseDown := False;
      end;
    end;
end;

procedure TcxCustomInnerListBox.MouseEnter(AControl: TControl);
begin
end;

procedure TcxCustomInnerListBox.MouseLeave(AControl: TControl);
begin
  if Container <> nil then
    Container.ShortRefreshContainer(True);
end;

procedure TcxCustomInnerListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  if Container <> nil then
    Container.MouseMove(Shift, X + Left, Y + Top);
end;

procedure TcxCustomInnerListBox.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if Container <> nil then
    Container.MouseUp(Button, Shift, X + Left, Y + Top);
end;

procedure TcxCustomInnerListBox.DrawSizeGrip(ADC: HDC);
var
  ABrush: HBRUSH;
begin
  if UsecxScrollBars and HScrollBar.Visible and VScrollBar.Visible then
  begin
    ABrush := CreateSolidBrush(ColorToRGB(clBtnFace));
    try
      FillRect(ADC, GetSizeGripRect, ABrush);
    finally
      DeleteObject(ABrush);
    end;
  end;
end;

function TcxCustomInnerListBox.NeedDrawFocusRect: Boolean;
begin
  Result := not Assigned(OnDrawItem);
end;

procedure TcxCustomInnerListBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = FHScrollBar then
      FHScrollBar := nil
    else if AComponent = FVScrollBar then
      FVScrollBar := nil;
end;

procedure TcxCustomInnerListBox.RestoreCanvasParametersForFocusRect;
begin
  Canvas.Brush.Color := FPrevBrushColor;
  Canvas.Font.Color := FPrevFontColor;
{$IFNDEF CLR}
  TCanvasAccess(Canvas.Canvas).RequiredState([csHandleValid, csBrushValid]);
{$ELSE}
  TCanvasAccess._RequiredState(Canvas.Canvas, [csHandleValid, csBrushValid]);
{$ENDIF}
end;

procedure TcxCustomInnerListBox.SaveCanvasParametersForFocusRect;
begin
  FPrevBrushColor := Canvas.Brush.Color;
  FPrevFontColor := Canvas.Font.Color;
end;

procedure TcxCustomInnerListBox.WndProc(var Message: TMessage);
begin
  if (Container <> nil) and Container.InnerControlMenuHandler(Message) then
    Exit;
  inherited WndProc(Message);
  case Message.Msg of
    CM_WININICHANGE,
    LB_ADDSTRING,
    LB_DELETESTRING,
    LB_INSERTSTRING,
    LB_RESETCONTENT,
    LB_SETCARETINDEX,
    LB_SETCURSEL,
    LB_SETHORIZONTALEXTENT,
    LB_SETTOPINDEX,
    WM_HSCROLL,
    WM_MOUSEWHEEL,
    WM_VSCROLL,
    WM_WINDOWPOSCHANGED:
      SetExternalScrollBarsParameters;
    WM_SETREDRAW:
      if Message.WParam <> 0 then
        SetExternalScrollBarsParameters;
  end;
end;

procedure TcxCustomInnerListBox.CreateScrollBars;

  procedure InitializeScrollBar(AScrollBar: TcxScrollBar);
  begin
    AScrollBar.SmallChange := 1;
    AScrollBar.Visible := False;
  end;

begin
  FHScrollBar := TcxScrollBar.Create(Self);
  FHScrollBar.FreeNotification(Self);
  FHScrollBar.Kind := sbHorizontal;
  FHScrollBar.OnScroll := HScrollHandler;
  InitializeScrollBar(FHScrollBar);

  FVScrollBar := TcxScrollBar.Create(Self);
  FVScrollBar.FreeNotification(Self);
  FVScrollBar.Kind := sbVertical;
  FVScrollBar.OnScroll := VScrollHandler;
  InitializeScrollBar(FVScrollBar);
end;

function TcxCustomInnerListBox.FindAutoCompleteString(const S: string): Integer;
begin
{$IFDEF DELPHI6}
  if Style in [lbVirtual, lbVirtualOwnerDraw] then
    Result := DoFindData(S)
  else
{$ENDIF}
  {$IFNDEF CLR}
    Result := SendMessage(Handle, LB_FINDSTRING, -1, LPARAM(PChar(S)));
  {$ELSE}
    Result := SendTextMessage(Handle, LB_FINDSTRING, -1, S);
  {$ENDIF}
end;

function TcxCustomInnerListBox.GetControlContainer: TcxContainer;
begin
  Result := FContainer;
end;

function TcxCustomInnerListBox.GetControl: TWinControl;
begin
  Result := Self;
end;

procedure TcxCustomInnerListBox.HScrollHandler(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
  if FHScrollBar.HandleAllocated then
  begin
    CallWindowProc(DefWndProc, Handle, WM_HSCROLL, Word(ScrollCode) +
      Word(ScrollPos) shl 16, FHScrollBar.Handle);
    ScrollPos := GetScrollPos(Handle, SB_HORZ);
  end;
end;

procedure TcxCustomInnerListBox.SetLookAndFeel(Value: TcxLookAndFeel);
begin
  FLookAndFeel.Assign(Value);
end;

procedure TcxCustomInnerListBox.VScrollHandler(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
  if FVScrollBar.HandleAllocated then
    if ScrollCode in [scLineUp, scLineDown] then
      TopIndex := ScrollPos
    else
    begin
      CallWindowProc(DefWndProc, Handle, WM_VSCROLL, Word(ScrollCode) +
        Word(ScrollPos) shl 16, FVScrollBar.Handle);
      ScrollPos := GetScrollPos(Handle, SB_VERT);
    end;
end;

{$IFNDEF DELPHI6}
function TcxCustomInnerListBox.GetScrollWidth: Integer;
begin
  Result := SendMessage(Handle, LB_GETHORIZONTALEXTENT, 0, 0);
end;

procedure TcxCustomInnerListBox.SetScrollWidth(const Value: Integer);
begin
  if Value <> ScrollWidth then
    SendMessage(Handle, LB_SETHORIZONTALEXTENT, Value, 0);
end;
{$ENDIF}

procedure TcxCustomInnerListBox.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if Container <> nil then
    with Message do
    begin
      Result := Result or DLGC_WANTCHARS;
      if GetKeyState(VK_CONTROL) >= 0 then
        Result := Result or DLGC_WANTTAB;
    end;
end;

procedure TcxCustomInnerListBox.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if (Container <> nil) and not Container.IsDestroying then
    Container.FocusChanged;
end;

procedure TcxCustomInnerListBox.WMLButtonDown(var Message: TWMLButtonDown);

  function NeedImmediateBeginDrag: Boolean;
  var
    AItemIndex : Integer;
    AShiftState: TShiftState;
  begin
    Result := False;
    AShiftState := KeysToShiftState(Message.Keys);
    if MultiSelect then
      if not(ssShift in AShiftState) or (ssCtrl in AShiftState) then
      begin
        AItemIndex := ItemAtPos(SmallPointToPoint(Message.Pos), True);
        Result := (AItemIndex >= 0) and Selected[AItemIndex];
      end;
  end;

  function NeedBeginDrag: Boolean;
  var
    AShiftState: TShiftState;
  begin
    AShiftState := KeysToShiftState(Message.Keys);
    Result := not(MultiSelect and ((ssCtrl in AShiftState) or
      (ssShift in AShiftState)));
  end;

var
  APrevDragMode: TDragMode;
begin
  if not((Container <> nil) and (DragMode = dmAutomatic) and
    not Container.IsDesigning) then
  begin
    inherited;
    Exit;
  end;

  APrevDragMode := DragMode;
  try
    DragMode := dmManual;
    if NeedImmediateBeginDrag then
    begin
      Container.BeginDrag(False);
      Exit;
    end;
    inherited;
    if NeedBeginDrag then
      Container.BeginDrag(False);
  finally
    DragMode := APrevDragMode;
  end;
end;

procedure TcxCustomInnerListBox.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  if not FScrollBarsCalculating then
    SetExternalScrollBarsParameters;
end;

procedure TcxCustomInnerListBox.WMNCPaint(var Message: TWMNCPaint);
var
  ADC: HDC;
begin
  inherited;
  if UsecxScrollBars and HScrollBar.Visible and VScrollBar.Visible then
  begin
    ADC := GetWindowDC(Handle);
    try
      DrawSizeGrip(ADC);
    finally
      ReleaseDC(Handle, ADC);
    end;
  end;
end;

procedure TcxCustomInnerListBox.WMPrint(var Message: TWMPrint);
begin
  if UsecxScrollBars and (Message.Flags and PRF_NONCLIENT <> 0) then
  begin
    Message.Flags := Message.Flags and not PRF_NONCLIENT;
    DrawSizeGrip(Message.DC);
  end;
  inherited;
end;

procedure TcxCustomInnerListBox.WMPrintClient(var Message: TWMPrintClient);
begin
  DefaultHandler(Message);
end;

procedure TcxCustomInnerListBox.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if (Container <> nil) and not Container.IsDestroying and not(csDestroying in ComponentState)
      and (Message.FocusedWnd <> Container.Handle) then
    Container.FocusChanged;
end;

procedure TcxCustomInnerListBox.WMSetRedraw(var Message: TWMSetRedraw);
begin
  inherited;
  FIsRedrawLocked := Message.Redraw = 0;
  if not (csDestroying in ComponentState) and not FIsRedrawLocked then
    SetExternalScrollBarsParameters;
end;

procedure TcxCustomInnerListBox.WMWindowPosChanged(var Message: TWMWindowPosChanged);
var
  ARgn: HRGN;
begin
  inherited;
  if csDestroying in ComponentState then
    Exit;
  if FHScrollBar.Visible and FVScrollBar.Visible then
  begin
    ARgn := CreateRectRgnIndirect(GetSizeGripRect);
    SendMessage(Handle, WM_NCPAINT, ARgn, 0);
    DeleteObject(ARgn);
  end;
end;

procedure TcxCustomInnerListBox.CMMouseEnter(var Message: TMessage);
begin
  inherited;
{$IFDEF CLR}
  MouseEnter(nil); // TODO
{$ELSE}
  if Message.lParam = 0 then
    MouseEnter(Self)
  else
    MouseEnter(TControl(Message.lParam));
{$ENDIF}
end;

procedure TcxCustomInnerListBox.CMMouseLeave(var Message: TMessage);
begin
  inherited;
{$IFDEF CLR}
  MouseLeave(nil); // TODO
{$ELSE}
  if Message.lParam = 0 then
    MouseLeave(Self)
  else
    MouseLeave(TControl(Message.lParam));
{$ENDIF}
end;

procedure TcxCustomInnerListBox.CNDrawItem(var Message: TWMDrawItem);
var
  ACanvas: TCanvas;
  AItemState: TOwnerDrawState;
begin
  with {$IFDEF CLR}Message.DrawItemStruct{$ELSE}Message.DrawItemStruct^{$ENDIF} do
  begin
{$IFDEF CLR}
    AItemState := TOwnerDrawState(itemState and $FFFF);
{$ELSE}
    AItemState := TOwnerDrawState(LongRec(itemState).Lo);
{$ENDIF}
    ACanvas := inherited Canvas;
    ACanvas.Handle := hDC;
    ACanvas.Font := Font;
    ACanvas.Brush := Brush;
    if (Integer(itemID) >= 0) and (odSelected in AItemState) then
    begin
      ACanvas.Brush.Color := clHighlight;
      ACanvas.Font.Color := clHighlightText
    end;
    if Integer(itemID) >= 0 then
      DrawItem(itemID, rcItem, AItemState)
    else
      ACanvas.FillRect(rcItem);
    if (odFocused in AItemState) and NeedDrawFocusRect then
      DrawFocusRect(hDC, rcItem);
    ACanvas.Handle := 0;
  end;
end;


function WndProc(hWnd: HWND; Msg: Windows.UINT; WParam: WPARAM; LParam: LPARAM): LRESULT{$IFNDEF CLR} stdcall{$ENDIF};
begin
  SetWindowLong(hwnd, GWL_WNDPROC, Longint(FOldWndProc));
  Result := 1;
end;

function ApplicationCallWndProcHookProc(Code: Integer;
  WParam, LParam: Longint): Longint{$IFNDEF CLR} stdcall{$ENDIF};

  procedure LockMessage(AWnd: HWND);
  begin
    FOldWndProc := {$IFDEF CLR}IntPtr{$ELSE}Pointer{$ENDIF}(GetWindowLong(AWnd, GWL_WNDPROC));
    SetWindowLong(AWnd, GWL_WNDPROC, {$IFDEF CLR}WndProc{$ELSE}Longint(@WndProc){$ENDIF});
  end;

var
  AParentForm: TCustomForm;
  AParentWindow: HWND;
  APopupWindow: TcxCustomPopupWindow;
  I, J: Integer;
{$IFDEF CLR}
  ACWPStruct: TCWPStruct;
{$ENDIF}
begin
  if (FVisiblePopupWindowList.Count = 0) or (Code <> HC_ACTION) then
  begin
    Result := CallNextHookEx(FApplicationCallWndProcHook, Code, WParam, LParam);
    Exit;
  end;

  {$IFDEF CLR}
  ACWPStruct := TCWPStruct(Marshal.PtrToStructure(IntPtr(LParam), TypeOf(TCWPStruct)));
  with ACWPStruct do
  {$ELSE}
  with Windows.PCWPStruct(LParam)^ do
  {$ENDIF}
    case message of
      WM_NCACTIVATE:
        if wParam = 0 then
          if FCaptionInactivationLocked then
            LockMessage(hwnd)
          else
            for I := 0 to FVisiblePopupWindowList.Count - 1 do
            begin
              APopupWindow := TcxCustomPopupWindow(FVisiblePopupWindowList[I]);
              if csDestroying in APopupWindow.ComponentState then
                Continue;
              AParentForm := GetParentForm(APopupWindow.OwnerControl);
              if (AParentForm <> nil) and (NativeHandle(AParentForm.Handle) = hwnd) then
                LockMessage(hwnd);
            end;

      WM_ACTIVATEAPP:
          if wParam = 0 then
          begin
            I := 0;
            while I < FVisiblePopupWindowList.Count do
            begin
              APopupWindow := TcxCustomPopupWindow(FVisiblePopupWindowList[I]);
              AParentForm := GetParentForm(APopupWindow.OwnerControl);
              if AParentForm <> nil then
                PostMessage(NativeHandle(AParentForm.Handle), WM_NCACTIVATE, 0, 0);
              if APopupWindow.CaptureFocus and APopupWindow.Active or not IsWindowEnabled(APopupWindow.Handle) then
              begin
                Inc(I);
                Continue;
              end;
              APopupWindow.CloseUp;
              if APopupWindow.OwnerControl is TcxContainer then
                TcxContainer(APopupWindow.OwnerControl).FocusChanged;
              I := 0;
            end;
          end;

      WM_DESTROY:
        for I := 0 to FVisiblePopupWindowList.Count - 1 do
        begin
          APopupWindow := TcxCustomPopupWindow(FVisiblePopupWindowList[I]);
          if csDestroying in APopupWindow.ComponentState then
            Continue;
          if HasNativeHandle(APopupWindow, hwnd) then
          begin
            APopupWindow.Close;
            if FVisiblePopupWindowList.IndexOf(APopupWindow) = -1 then
              with APopupWindow do
                if not (csDestroying in ComponentState) and FTerminateOnDestroy then
                  Application.Terminate;
            Break;
          end;
        end;

      WM_CLOSE:
        for I := 0 to FVisiblePopupWindowList.Count - 1 do
        begin
          APopupWindow := TcxCustomPopupWindow(FVisiblePopupWindowList[I]);
          if csDestroying in APopupWindow.ComponentState then
            Continue;
          if HasNativeHandle(APopupWindow, hwnd) then
          begin
            if APopupWindow.CloseQuery then
              APopupWindow.CloseUp;
            if (FVisiblePopupWindowList.IndexOf(APopupWindow) = -1) and
              APopupWindow.CaptureFocus and not(csDestroying in APopupWindow.OwnerControl.ComponentState) then
            begin
              AParentWindow := FindFirstNonChildParentWindow(APopupWindow.OwnerControl.Handle);
              SendMessage(AParentWindow, WM_CLOSE, 0, 0);
            end;
            Break;
          end;
          if not APopupWindow.CaptureFocus and not(csDestroying in APopupWindow.OwnerControl.ComponentState) then
          begin
            AParentForm := GetParentForm(APopupWindow.OwnerControl);
            if not AParentForm.HandleAllocated or HasNativeHandle(AParentForm, hwnd) then
              APopupWindow.CloseUp;
            Break;
          end;
        end;

      WM_SHOWWINDOW:
        if wParam = 0 then
          for I := FVisiblePopupWindowList.Count - 1 downto 0 do
          begin
            APopupWindow := TcxCustomPopupWindow(FVisiblePopupWindowList[I]);
            if csDestroying in APopupWindow.ComponentState then
              Continue;
            with APopupWindow.OwnerControl do
              if (csDestroying in ComponentState) or not HandleAllocated then
                Continue;
            if HasNativeHandle(APopupWindow.OwnerControl, hwnd) then
            begin
              for J := FVisiblePopupWindowList.Count - 1 downto I do
                TcxCustomPopupWindow(FVisiblePopupWindowList[J]).CloseUp;
              Break;
            end;
          end;

      WM_WINDOWPOSCHANGED:
        begin
          I := 0;
          while I < FVisiblePopupWindowList.Count do
          begin
            APopupWindow := TcxCustomPopupWindow(FVisiblePopupWindowList[I]);
            if (csDestroying in APopupWindow.ComponentState) or not APopupWindow.HandleAllocated then
            begin
              Inc(I);
              Continue;
            end;
            with APopupWindow.OwnerControl do
              if (csDestroying in ComponentState) or not HandleAllocated then
              begin
                Inc(I);
                Continue;
              end;
            if not HasNativeHandle(APopupWindow.OwnerControl, hwnd) then
            begin
              Inc(I);
              Continue;
            end;
            if InternalIsWindowVisible(APopupWindow.OwnerControl) then
              Inc(I)
            else
            begin
              APopupWindow.CloseUp;
              I := 0;
              Continue;
            end;
          end;
        end;
    end;
  Result := CallNextHookEx(FApplicationCallWndProcHook, Code, WParam, LParam);
end;

  {$IFNDEF CLR}
function ApplicationGetMessageMsgHookProc(Code: Integer;
  WParam, LParam: Longint):Longint stdcall;
var
  APMsg: Windows.PMSG;
  APopupWindow: TcxCustomPopupWindow;
begin
  if (FVisiblePopupWindowList.Count > 0) and (Code = HC_ACTION) and (WParam = PM_REMOVE) then
  begin
    APMsg := Windows.PMSG(LParam);
    if (APMsg^.message = WM_SYSKEYDOWN) and (FVisiblePopupWindowList.Count > 0) then
      with FVisiblePopupWindowList do
      begin
        APopupWindow := TcxCustomPopupWindow(Items[Count - 1]);
        if (not APopupWindow.CaptureFocus or not APopupWindow.ModalMode) and
            not APopupWindow.IsSysKeyAccepted(APMsg^.wParam) then
          APMsg^.message := 0;
      end;
  end;
  Result := CallNextHookEx(FApplicationGetMessageMsgHook, Code, WParam, LParam);
end;
  {$ELSE}
function ApplicationGetMessageMsgHookProc(Code: Integer;
  WParam, LParam: Longint):Longint;
var
  AMsg: Windows.TMsg;
  APopupWindow: TcxCustomPopupWindow;
begin
  if (FVisiblePopupWindowList.Count > 0) and (Code = HC_ACTION) and (WParam = PM_REMOVE) then
  begin
    AMsg := Windows.TMsg(Marshal.PtrToStructure(IntPtr(LParam), TypeOf(AMsg)));
    if (AMsg.message = WM_SYSKEYDOWN) and (FVisiblePopupWindowList.Count > 0) then
      with FVisiblePopupWindowList do
      begin
        APopupWindow := TcxCustomPopupWindow(Items[Count - 1]);
        if (not APopupWindow.CaptureFocus or not APopupWindow.ModalMode) and
            not APopupWindow.IsSysKeyAccepted(AMsg.wParam) then
          AMsg.message := 0;
      end;
    Marshal.StructureToPtr(AMsg, IntPtr(LParam), False);
  end;
  Result := CallNextHookEx(FApplicationGetMessageMsgHook, Code, WParam, LParam);
end;
  {$ENDIF}

function ApplicationMouseMsgHookProc(Code: Integer;
  WParam, LParam: Longint): Longint{$IFNDEF CLR} stdcall{$ENDIF};

  function MDIParentOrAnotherMDIChild(APopupWindow: TcxCustomPopupWindow; AWnd: HWND): Boolean;
  var
    AMDIChildForm, AMDIParentForm: TCustomForm;
    AMDIClientNativeHandle, AParentNativeHandle: HWND;
    AParentForm: TCustomForm;
    I, J: Integer;
  begin
    AParentForm := GetParentForm(APopupWindow.OwnerControl);
    AParentNativeHandle := GetParent(NativeHandle(AParentForm.Handle));
    Result := AParentNativeHandle = AWnd;
    if Result then
      Exit;
    for I := 0 to Screen.FormCount - 1 do
    begin
      AMDIParentForm := Screen.Forms[I];
  {$IFNDEF CLR}
      if (TCustomFormAccess(AMDIParentForm).FormStyle = fsMDIForm) and (TCustomFormAccess(AMDIParentForm).ClientHandle <> 0) then
  {$ELSE}
      if ((AMDIParentForm as IMDIForm).GetFormStyle = fsMDIForm) and (TCustomFormAccess._GetClientHandle(AMDIParentForm) <> 0) then
  {$ENDIF}
      begin
  {$IFNDEF CLR}
        AMDIClientNativeHandle := NativeHandle(TCustomFormAccess(AMDIParentForm).ClientHandle);
  {$ELSE}
        AMDIClientNativeHandle := NativeHandle(TCustomFormAccess._GetClientHandle(AMDIParentForm));
  {$ENDIF}
        if AParentNativeHandle = AMDIClientNativeHandle then // TODO Check CLX
        begin
          Result := HasNativeHandle(AMDIParentForm, AWnd, True);
          if Result then
            Break;

  {$IFNDEF CLR}
          for J := 0 to TCustomFormAccess(AMDIParentForm).MDIChildCount - 1 do
  {$ELSE}
          for J := 0 to (AMDIParentForm as IMDIForm).MDIChildCount - 1 do
  {$ENDIF}
          begin
  {$IFNDEF CLR}
            AMDIChildForm := TCustomFormAccess(AMDIParentForm).MDIChildren[J];
  {$ELSE}
            AMDIChildForm := (AMDIParentForm as IMDIForm).MDIChildren[J];
  {$ENDIF}
            if AMDIChildForm = AParentForm then
              Continue;
            Result := HasNativeHandle(AMDIChildForm, AWnd, True);
            if Result then
              Break;
          end;

          Break;
        end;
      end;
    end;
  end;

  function InternalNeedIgnoreMouseMessageAfterCloseUp(
    APopupWindow: TcxCustomPopupWindow): Boolean;
  var
    P: TPoint;
  begin
  {$IFNDEF CLR}
    P := PMouseHookStruct(LParam)^.pt;
  {$ELSE}
    P := TMouseHookStruct(Marshal.PtrToStructure(IntPtr(LParam), TypeOf(TMouseHookStruct))).pt;
   {$ENDIF}
    Result := APopupWindow.NeedIgnoreMouseMessageAfterCloseUp(WParam, InternalGetShiftState, P.X, P.Y);
  end;

  function CheckWindow(AWnd: HWND): Boolean;
  var
    I: Integer;
    ACallNextHook: Boolean;
    APopupWindow: TcxCustomPopupWindow;
    AParentForm: TCustomForm;
  begin
    Result := True;
    ACallNextHook := True;
    I := 0;
    while I < FVisiblePopupWindowList.Count do
    begin
      APopupWindow := TcxCustomPopupWindow(FVisiblePopupWindowList[I]);
      if APopupWindow.CaptureFocus and not APopupWindow.Active then
      begin
        Inc(I);
        Continue;
      end;
      with APopupWindow do
      begin
        if HasNativeHandle(APopupWindow, AWnd, True) then
        begin
          Inc(I);
          Continue;
        end;
        AParentForm := GetParentForm(OwnerControl);
//        if HasNativeHandle(AParentForm, AWnd, True) then
        if CheckParentsNativeHandle(OwnerControl, AWnd) or ((AParentForm is TcxCustomPopupWindow) and not TcxCustomPopupWindow(AParentForm).IsVisible) then
        begin
          if HasNativeHandle(OwnerControl, AWnd, True) then
            if (WParam = WM_LBUTTONDOWN) or (WParam = WM_LBUTTONDBLCLK) then
            begin
  {$IFNDEF CLR}
              if PtInRect(OwnerScreenBounds, PMouseHookStruct(LParam)^.pt) then
  {$ELSE}
              if PtInRect(OwnerScreenBounds, TMouseHookStruct(Marshal.PtrToStructure(IntPtr(LParam),
                TypeOf(TMouseHookStruct))).pt) then
  {$ENDIF}
              begin
                ACallNextHook := False;
                if InternalNeedIgnoreMouseMessageAfterCloseUp(APopupWindow) then
                  FJustClosed := True;
              end;
            end;

          FCaptionInactivationLocked := True;
          LockDeactivate(True);
          try
            APopupWindow.CloseUp;
            if not ACallNextHook and ((csDestroying in OwnerControl.ComponentState)
                or not OwnerControl.Visible) then
              Result := False;
          finally
            LockDeactivate(False);
            FCaptionInactivationLocked := False;
          end;
          I := 0;
        end
        else
        begin
          AParentForm := GetParentForm(OwnerControl);
  {$IFNDEF CLR}
          if (TCustomFormAccess(AParentForm).FormStyle = fsMDIChild) and MDIParentOrAnotherMDIChild(APopupWindow, AWnd) then
  {$ELSE}
          if ((AParentForm as IMDIForm).GetFormStyle = fsMDIChild) and MDIParentOrAnotherMDIChild(APopupWindow, AWnd) then
  {$ENDIF}
          begin
            APopupWindow.CloseUp;
            I := 0;
          end
          else
          begin
            Inc(I);
            Continue;
          end;
        end;
      end;
    end;
  end;

begin
  if (FVisiblePopupWindowList.Count > 0) and (Code = HC_ACTION) then
    case WParam of
      WM_NCLBUTTONDOWN, WM_NCLBUTTONDBLCLK, WM_LBUTTONDOWN, WM_LBUTTONDBLCLK,
      WM_NCRBUTTONDOWN, WM_NCRBUTTONDBLCLK, WM_RBUTTONDOWN, WM_RBUTTONDBLCLK,
      WM_NCMBUTTONDOWN, WM_NCMBUTTONDBLCLK, WM_MBUTTONDOWN, WM_MBUTTONDBLCLK:
  {$IFNDEF CLR}
        if not CheckWindow(PMouseHookStruct(LParam)^.hwnd) then
  {$ELSE}
        if not CheckWindow(TMouseHookStruct(Marshal.PtrToStructure(IntPtr(LParam), TypeOf(TMouseHookStruct))).hwnd) then
  {$ENDIF}
        begin
          Result := 1;
          Exit;
        end;
    end;
  Result := CallNextHookEx(FApplicationMouseMsgHook, Code, WParam, LParam);
end;

{$IFDEF CLR}
const
  ApplicationCallWndProcHookDelegate: TFNHookProc = @ApplicationCallWndProcHookProc;
  ApplicationGetMessageMsgHookDelegate: TFNHookProc = @ApplicationGetMessageMsgHookProc;
  ApplicationMouseMsgHookDelegate: TFNHookProc = @ApplicationMouseMsgHookProc;
{$ENDIF}

initialization
  SetUsecxScrollBars;
{$IFDEF DELPHI6}
  StartClassGroup(TControl);
  GroupDescendentsWith(TcxStyleController, TControl);
{$ENDIF}
  FVisiblePopupWindowList := TList.Create;
{$IFNDEF CLR}
  FApplicationCallWndProcHook := SetWindowsHookEx(WH_CALLWNDPROC,
    @ApplicationCallWndProcHookProc, 0, GetCurrentThreadID);
  FApplicationGetMessageMsgHook := SetWindowsHookEx(WH_GETMESSAGE,
    @ApplicationGetMessageMsgHookProc, 0, GetCurrentThreadID);
  FApplicationMouseMsgHook := SetWindowsHookEx(WH_MOUSE,
    @ApplicationMouseMsgHookProc, 0, GetCurrentThreadID);
{$ELSE}
  FApplicationCallWndProcHook := SetWindowsHookEx(WH_CALLWNDPROC,
    ApplicationCallWndProcHookDelegate, 0, GetCurrentThreadID);
  FApplicationGetMessageMsgHook := SetWindowsHookEx(WH_GETMESSAGE,
    ApplicationGetMessageMsgHookDelegate, 0, GetCurrentThreadID);
  FApplicationMouseMsgHook := SetWindowsHookEx(WH_MOUSE,
    ApplicationMouseMsgHookDelegate, 0, GetCurrentThreadID);
{$ENDIF}
  FScreenCanvas := TcxScreenCanvas.Create;
  cxControls.cxGetParentWndForDocking := GetPopupOwnerControl;

finalization
  cxControls.cxGetParentWndForDocking := nil;
  FreeAndNil(FScreenCanvas);
  if FApplicationMouseMsgHook <> 0 then
    UnhookWindowsHookEx(FApplicationMouseMsgHook);
  FApplicationMouseMsgHook := 0;
  if FApplicationGetMessageMsgHook <> 0 then
    UnhookWindowsHookEx(FApplicationGetMessageMsgHook);
  FApplicationGetMessageMsgHook := 0;
  if FApplicationCallWndProcHook <> 0 then
    UnhookWindowsHookEx(FApplicationCallWndProcHook);
  FApplicationCallWndProcHook := 0;
  FreeAndNil(FVisiblePopupWindowList);

end.


