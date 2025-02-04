
{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           Express Cross Platform Library controls                  }
{                                                                    }
{           Copyright (c) 2000-2007 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSCROSSPLATFORMLIBRARY AND ALL   }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
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

unit cxControls;

{$I cxVer.inc}

interface

uses
{$IFDEF VCL}
  Windows, Messages,
{$ELSE}
  Qt,
{$ENDIF}
{$IFDEF DELPHI6}
  Types,
{$ENDIF}
  Controls, Graphics, Forms, Classes, StdCtrls, Menus, cxGraphics,
{$IFDEF USETCXSCROLLBAR}
  cxScrollBar,
{$ENDIF}
 {$IFDEF CLR}
 WinUtils,
 {$ENDIF}
  cxClasses,
  cxLookAndFeels,
  cxLookAndFeelPainters;

const
{$IFNDEF VCL}
  VK_ESCAPE = Key_Escape;
  VK_RETURN = Key_Return;
  VK_INSERT = Key_Insert;
  VK_BACK = Key_Backspace;
  VK_DELETE = Key_Delete;
  VK_TAB = Key_Tab;
  VK_LEFT = Key_Left;
  VK_RIGHT = Key_Right;
  VK_UP = Key_Up;
  VK_DOWN = Key_Down;
  VK_HOME = Key_Home;
  VK_END = Key_End;
  VK_PRIOR = Key_Prior;
  VK_NEXT = Key_Next;
  VK_ADD = Key_Plus;
  VK_SUBTRACT = Key_Minus;
  VK_MULTIPLY = Key_Asterisk;
  VK_SPACE = Key_Space;
  VK_F2 = Key_F2;
  VK_F4 = Key_F4;
{$ELSE}
  CM_NCSIZECHANGED = WM_APP + 305;
{$ENDIF}

{$IFDEF VCL}
 {$IFNDEF DELPHI7}
   WM_APPCOMMAND = $0319;
  {$EXTERNALSYM WM_APPCOMMAND}
 {$ENDIF} 
 
  FAPPCOMMAND_MASK = $0000F000;
 {$EXTERNALSYM FAPPCOMMAND_MASK}
  APPCOMMAND_BROWSER_BACKWARD = 1;
 {$EXTERNALSYM APPCOMMAND_BROWSER_BACKWARD}
  APPCOMMAND_BROWSER_FORWARD  = 2;
 {$EXTERNALSYM APPCOMMAND_BROWSER_FORWARD}
{$ENDIF}

type
  TcxHandle = {$IFDEF VCL}HWND{$ELSE}QWidgetH{$ENDIF};

{$IFDEF VCL}
  TcxDragDetect = (ddNone, ddDrag, ddCancel);
{$ELSE}
  TWinControlClass = class of TWinControl;
{$ENDIF}

  TcxNumberType = (ntInteger, ntFloat, ntExponent);

{$IFNDEF DELPHI7}
  TWMPrint = packed record
    Msg: Cardinal;
    DC: HDC;
    Flags: Cardinal;
    Result: Integer;
  end;

  TWMPrintClient = TWMPrint;
{$ENDIF}

{$IFNDEF CLR}
  TLBGetItemRect = packed record
    Msg: Cardinal;
    ItemIndex: Integer;
    Rect: PRect;
    Result: Longint;
  end;
{$ELSE}
  TLBGetItemRect = class(TWMNoParams)
  private
    function GetItemIndex: Integer;
    function GetRect: TRect;
    procedure SetItemIndex(Value: Integer);
    procedure SetRect(const Value: TRect);
  public
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property Rect: TRect read GetRect write SetRect;
  end;
{$ENDIF}

  TcxControl = class;

  TDragControlObjectClass = class of TDragControlObject;

  IcxMouseCaptureObject = interface
    ['{ACB73657-6066-4564-9A3D-D4D0273AA82F}']
    procedure DoCancelMode;
  end;

  IcxMouseTrackingCaller = interface
    ['{84A4BCBE-E001-4D60-B7A6-75E2B0DCD3E9}']
    procedure MouseLeave;
  end;

  IcxMouseTrackingCaller2 = interface(IcxMouseTrackingCaller)
    ['{3A5D973B-F016-4F22-80B6-1D35668D7743}']
    function PtInCaller(const P: TPoint): Boolean;
  end;

  { IcxCompoundControl }

  IcxCompoundControl = interface
  ['{A4A77F28-1D03-425B-9A83-0B853B5D8DEF}']
    function GetActiveControl: TWinControl;
    property ActiveControl: TWinControl read GetActiveControl;
  end;

  { IcxPopupMenu }

  IcxPopupMenu = interface
    ['{61EEDA7D-88CC-45BF-8A00-5C25174D6501}']
    function IsShortCutKey(var Message: TWMKey): Boolean;
    procedure Popup(X, Y: Integer);
  end;

  { control child component }

  TcxControlChildComponent = class(TcxComponent)
  private
    FControl: TcxControl;
    function GetIsLoading: Boolean;
  protected
    function GetIsDestroying: Boolean; virtual;
    procedure Initialize; virtual;
    procedure SetControl(Value: TcxControl); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateEx(AControl: TcxControl;
      AAssignOwner: Boolean = True); virtual;
    destructor Destroy; override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    procedure SetParentComponent(Value: TComponent); override;
    property Control: TcxControl read FControl write SetControl;
    property IsDestroying: Boolean read GetIsDestroying;
    property IsLoading: Boolean read GetIsLoading;
  end;

  { scrollbar and size grip }

  TcxScrollBarData = record
    Min: Integer;
    Max: Integer;
    Position: Integer;
    PageSize: Integer;
    SmallChange: TScrollBarInc;
    LargeChange: TScrollBarInc;
    Enabled: Boolean;
    Visible: Boolean;
    AllowShow: Boolean;
    AllowHide: Boolean;
  end;

  TcxControlScrollBar = class({$IFDEF USETCXSCROLLBAR}TcxScrollBar{$ELSE}TScrollBar{$ENDIF})
  private
    function GetVisible: Boolean;
    procedure SetVisible(Value: Boolean);
  {$IFDEF VCL}
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
  {$ENDIF}
  protected
  {$IFDEF VCL}
    procedure WndProc(var Message: TMessage); override;
  {$ELSE}
    function DesignEventQuery(Sender: QObjectH; Event: QEventH): Boolean; override;
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;
  {$IFNDEF USETCXSCROLLBAR}
    procedure InitWidget; override;
  {$ENDIF}
    procedure WidgetDestroyed; override;
  {$ENDIF}
    procedure FocusParent; virtual;
  public
    Data: TcxScrollBarData;
    constructor Create(AOwner: TComponent); override;
    procedure ApplyData;
  {$IFNDEF VCL}
    function CanFocus: Boolean; override;
  {$ENDIF}
    property Visible: Boolean read GetVisible write SetVisible;
  end;

  TcxSizeGrip = class(TCustomControl)
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { drag & drop objects }

  TcxDragAndDropObjectClass = class of TcxDragAndDropObject;

  TcxDragAndDropObject = class
  private
    FCanvas: TcxCanvas;
    FControl: TcxControl;
    FDirty: Boolean;
    procedure SetDirty(Value: Boolean);
  protected
    procedure ChangeMousePos(const P: TPoint);
    procedure DirtyChanged; virtual;
    function GetDragAndDropCursor(Accepted: Boolean): TCursor; virtual;
    function GetImmediateStart: Boolean; virtual;

    procedure AfterDragAndDrop(Accepted: Boolean); virtual;
    procedure BeginDragAndDrop; virtual;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); virtual;
    procedure EndDragAndDrop(Accepted: Boolean); virtual;

    property Canvas: TcxCanvas read FCanvas write FCanvas;
    property Control: TcxControl read FControl;
    property Dirty: Boolean read FDirty write SetDirty;
  public
    CurMousePos: TPoint;
    PrevMousePos: TPoint;
    constructor Create(AControl: TcxControl); virtual;

    procedure DoBeginDragAndDrop;
    procedure DoDragAndDrop(const P: TPoint; var Accepted: Boolean);
    procedure DoEndDragAndDrop(Accepted: Boolean);

    property ImmediateStart: Boolean read GetImmediateStart;
  end;

  TcxDragControlObject = class(TDragControlObject)
  protected
    procedure Finished(Target: TObject; X, Y: Integer; Accepted: Boolean); override;
  {$IFDEF VCL}
    function GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor; override;
  {$ENDIF}
  end;

  TcxDragImageListClass = class of TcxDragImageList;

  TcxDragImageList = class(TDragImageList);

  { control }

  TcxControlBorderStyle = (cxcbsNone, cxcbsDefault);
  TcxDragAndDropState = (ddsNone, ddsStarting, ddsInProcess);

  TcxKey = (kAll, kArrows, kChars, kTab);
  TcxKeys = set of TcxKey;

  TcxMouseWheelScrollingKind = (mwskNone, mwskHorizontal, mwskVertical);

  TcxControlListernerLink = class
    Ref: TcxControl;
  end;

  TcxControl = class(TCustomControl{$IFNDEF DELPHI6}, IUnknown{$ENDIF},
    IcxLookAndFeelContainer)
  private
    FActiveCanvas: TcxCanvas;
    FBorderStyle: TcxControlBorderStyle;
    FCalculatingScrollBarsParams: Boolean;
    FCanvas: TcxCanvas;
    FCreatingWindow: Boolean;
    FDefaultCursor: TCursor;
    FDragAndDropObject: TcxDragAndDropObject;
    FDragAndDropObjectClass: TcxDragAndDropObjectClass;
    FDragAndDropPrevCursor: TCursor;
    FDragAndDropState: TcxDragAndDropState;
    FDragImages: TcxDragImageList;
    FFinishingDragAndDrop: Boolean;
    FFocusOnClick: Boolean;
    FFontListenerList: IInterfaceList;
    FHScrollBar: TcxControlScrollBar;
    FInitialHScrollBarVisible: Boolean;
    FInitialVScrollBarVisible: Boolean;
    FIsInitialScrollBarsParams: Boolean;
    FKeys: TcxKeys;
    FLookAndFeel: TcxLookAndFeel;
    FMouseButtonPressed: Boolean;
    FMouseCaptureObject: TObject;
    FMouseDownPos: TPoint;
    FMouseRightButtonReleased: Boolean;
    FPopupMenu: TComponent;
    FScrollBars: TScrollStyle;
    FScrollBarsLockCount: Integer;
    FScrollBarsUpdateNeeded: Boolean;
    FSizeGrip: TcxSizeGrip;
    FUpdatingScrollBars: Boolean;
    FVScrollBar: TcxControlScrollBar;
  {$IFDEF VCL}
    FIsScrollingContent: Boolean;
    FLastParentBackground: Boolean;
    {$IFNDEF DELPHI7}
    FParentBackground: Boolean;
    {$ENDIF}
  {$ENDIF}
    FOnFocusChanged: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;

    function GetActiveCanvas: TcxCanvas;
    function GetDragAndDropObject: TcxDragAndDropObject;
    function GetHScrollBarVisible: Boolean;
    function GetIsDestroying: Boolean;
    function GetIsLoading: Boolean;
    function GetVScrollBarVisible: Boolean;
    procedure SetBorderStyle(Value: TcxControlBorderStyle);
    procedure SetDragAndDropState(Value: TcxDragAndDropState);
    procedure SetLookAndFeel(Value: TcxLookAndFeel);
    procedure SetKeys(Value: TcxKeys);
    procedure SetMouseCaptureObject(Value: TObject);
    procedure SetPopupMenu(Value: TComponent);
    procedure SetScrollBars(Value: TScrollStyle);
  {$IFDEF VCL}
    {$IFNDEF DELPHI7}
    procedure SetParentBackground(Value: Boolean);
    {$ENDIF}
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMCursorChanged(var Message: TMessage); message CM_CURSORCHANGED;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMNCSizeChanged(var Message: TMessage); message CM_NCSIZECHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure CNSysKeyDown(var Message: TWMKeyDown); message CN_SYSKEYDOWN;
  {$ENDIF}
    procedure CreateScrollBars;
    procedure DestroyScrollBars;
    procedure ScrollEvent(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
  protected
    FBounds: TRect;
  {$IFDEF VCL}
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure Resize; override;
    procedure WndProc(var Message: TMessage); override;
  {$ELSE}
    function DesignEventQuery(Sender: QObjectH; Event: QEventH): Boolean; override;
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;
    procedure InitWidget; override;
    procedure SetParent(const AParent: TWidgetControl); override;
  {$ENDIF}
    procedure DestroyWindowHandle; override;
    procedure DoContextPopup({$IFNDEF VCL}const {$ENDIF}MousePos: TPoint;
      var Handled: Boolean); override;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
      {$IFNDEF VCL}const{$ENDIF} MousePos: TPoint): Boolean; override;
    function DoShowPopupMenu(AMenu: TComponent; X, Y: Integer): Boolean; virtual;
    function GetPopupMenu: TPopupMenu; override;
    function IsMenuKey(var Message: TWMKey): Boolean;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Modified;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;

  {$IFDEF VCL}
    procedure ColorChanged; dynamic;
    procedure DoScrolling;
    procedure ParentBackgroundChanged; virtual;
    procedure VisibleChanged; dynamic;
  {$ENDIF}
    procedure AddChildComponent(AComponent: TcxControlChildComponent); dynamic;
    procedure RemoveChildComponent(AComponent: TcxControlChildComponent); dynamic;

    property FontListenerList: IInterfaceList read FFontListenerList;

    procedure AfterMouseDown(AButton: TMouseButton; X, Y: Integer); virtual;
    function AllowAutoDragAndDropAtDesignTime(X, Y: Integer;
      Shift: TShiftState): Boolean; virtual;
    function AllowDragAndDropWithoutFocus: Boolean; dynamic;
    procedure BeforeMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure BoundsChanged; {$IFDEF VCL}dynamic{$ELSE}override{$ENDIF};
    procedure BringInternalControlsToFront; virtual;
    procedure CancelMouseOperations; virtual;
    function CanDrag(X, Y: Integer): Boolean; dynamic;
    function CanFocusOnClick: Boolean; overload; virtual;
    function CanFocusOnClick(X, Y: Integer): Boolean; overload; virtual; 
    procedure CursorChanged; {$IFDEF VCL}dynamic{$ELSE}override{$ENDIF};
    procedure DoCancelMode; dynamic;
    procedure FocusChanged; dynamic;
    function FocusWhenChildIsClicked(AChild: TControl): Boolean; virtual;
    procedure FontChanged; {$IFDEF VCL}dynamic;{$ELSE}override;{$ENDIF}
    function GetBorderSize: Integer; virtual;
    function GetBounds: TRect; virtual;
    function GetClientBounds: TRect; virtual;
    function GetCursor(X, Y: Integer): TCursor; virtual;
    function GetDesignHitTest(X, Y: Integer; Shift: TShiftState): Boolean; dynamic;
    function GetDragObjectClass: TDragControlObjectClass; dynamic;
    function GetIsDesigning: Boolean; virtual;
    function GetIsFocused: Boolean; virtual;
    function GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind; virtual;
    function HasBackground: Boolean; virtual;
    procedure InitControl; virtual;
    function IsInternalControl(AControl: TControl): Boolean; virtual;
    function MayFocus: Boolean; dynamic;
    procedure MouseEnter(AControl: TControl); {$IFDEF VCL}dynamic{$ELSE}override{$ENDIF};
    procedure MouseLeave(AControl: TControl); {$IFDEF VCL}dynamic{$ELSE}override{$ENDIF};
    procedure TextChanged; {$IFDEF VCL}dynamic{$ELSE}override{$ENDIF};

    // IcxLookAndFeelContainer
    function IcxLookAndFeelContainer.GetLookAndFeel = GetLookAndFeelValue;
    function GetLookAndFeelValue: TcxLookAndFeel; virtual;

    // look&feel
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass; virtual;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel;
      AChangedValues: TcxLookAndFeelValues); virtual;
    property LookAndFeel: TcxLookAndFeel read FLookAndFeel write SetLookAndFeel;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;

    // scrollbars
    procedure CheckNeedsScrollBars;
    function GetHScrollBarBounds: TRect; virtual;
    function GetSizeGripBounds: TRect; virtual;
    function GetVScrollBarBounds: TRect; virtual;
    procedure InitScrollBars;
    procedure InitScrollBarsParameters; virtual;
    function IsPixelScrollBar(AKind: TScrollBarKind): Boolean; virtual;
    function NeedsScrollBars: Boolean; virtual;
    function NeedsToBringInternalControlsToFront: Boolean; virtual;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
      var AScrollPos: Integer); virtual;
    procedure SetInternalControlsBounds; virtual;
    procedure UpdateInternalControlsState; virtual;
    procedure UpdateScrollBars; virtual;

    property CalculatingScrollBarsParams: Boolean read FCalculatingScrollBarsParams;
    property HScrollBar: TcxControlScrollBar read FHScrollBar;
    property HScrollBarVisible: Boolean read GetHScrollBarVisible;
    property ScrollBars: TScrollStyle read FScrollBars write SetScrollBars default ssBoth;
    property SizeGrip: TcxSizeGrip read FSizeGrip;
    property UpdatingScrollBars: Boolean read FUpdatingScrollBars;
    property VScrollBar: TcxControlScrollBar read FVScrollBar;
    property VScrollBarVisible: Boolean read GetVScrollBarVisible;

    // internal drag and drop (columns moving, ...)
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); dynamic;
    procedure EndDragAndDrop(Accepted: Boolean); dynamic;
    function GetDragAndDropObjectClass: TcxDragAndDropObjectClass; virtual;
    function StartDragAndDrop(const P: TPoint): Boolean; dynamic;

    // delphi drag and drop
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    procedure DrawDragImage(ACanvas: TcxCanvas; const R: TRect); virtual;
    function GetDragImagesClass: TcxDragImageListClass; virtual;
    function GetDragImagesSize: TPoint; virtual;
    function GetIsCopyDragDrop: Boolean; virtual;
    function HasDragImages: Boolean; virtual;
    procedure HideDragImage;
    procedure InitDragImages(ADragImages: TcxDragImageList); virtual;
    procedure ShowDragImage;
    property DragImages: TcxDragImageList read FDragImages;
    property IsCopyDragDrop: Boolean read GetIsCopyDragDrop;

    property BorderSize: Integer read GetBorderSize;
    property BorderStyle: TcxControlBorderStyle read FBorderStyle write SetBorderStyle;
    property CreatingWindow: Boolean read FCreatingWindow;
    property FocusOnClick: Boolean read FFocusOnClick write FFocusOnClick default True;
    property Keys: TcxKeys read FKeys write SetKeys;
    property MouseRightButtonReleased: Boolean read FMouseRightButtonReleased;
    property MouseWheelScrollingKind: TcxMouseWheelScrollingKind read GetMouseWheelScrollingKind;
    property PopupMenu: TComponent read FPopupMenu write SetPopupMenu;
  {$IFDEF VCL}
    property IsScrollingContent: Boolean read FIsScrollingContent;
    property ParentBackground{$IFNDEF DELPHI7}: Boolean read FParentBackground
      write SetParentBackground{$ENDIF} default True;
  {$ENDIF}

    property OnFocusChanged: TNotifyEvent read FOnFocusChanged write FOnFocusChanged;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetDragImages: TDragImageList; override;
  {$IFDEF DELPHI4}
    {$IFNDEF CLR}
    procedure BeforeDestruction; override;
    {$ENDIF}
  {$ENDIF}
    function CanFocusEx: Boolean; virtual;
    function AcceptMousePosForClick(X, Y: Integer): Boolean; virtual;
  {$IFDEF VCL}
    procedure InvalidateRect(const R: TRect; EraseBackground: Boolean);
    procedure InvalidateRgn(ARegion: TcxRegion; EraseBackground: Boolean);
    procedure InvalidateWithChildren;
  {$ENDIF}
    function IsMouseInPressedArea(X, Y: Integer): Boolean;
    procedure PostMouseMove(AMousePos: TPoint); overload;
    procedure PostMouseMove; overload;
    procedure ScrollContent(ADirection: TcxDirection);
    procedure ScrollWindow(DX, DY: Integer; const AScrollRect: TRect);
    procedure SetScrollBarInfo(AScrollBarKind: TScrollBarKind;
      AMin, AMax, AStep, APage, APos: Integer; AAllowShow, AAllowHide: Boolean);
    function StartDrag(DragObject: TDragObject): Boolean; dynamic;
    procedure UpdateWithChildren;

    // internal drag and drop (columns moving, ...)
    procedure BeginDragAndDrop; dynamic;
    procedure FinishDragAndDrop(Accepted: Boolean);
    property DragAndDropObject: TcxDragAndDropObject read GetDragAndDropObject;
    property DragAndDropObjectClass: TcxDragAndDropObjectClass read GetDragAndDropObjectClass
      write FDragAndDropObjectClass;
    property DragAndDropState: TcxDragAndDropState read FDragAndDropState
      write SetDragAndDropState;

    procedure AddFontListener(AListener: IcxFontListener);
    procedure RemoveFontListener(AListener: IcxFontListener);

    procedure LockScrollBars;
    procedure UnlockScrollBars;

    property ActiveCanvas: TcxCanvas read GetActiveCanvas;
    property Bounds: TRect read GetBounds;
    property Canvas: TcxCanvas read FCanvas;
    property ClientBounds: TRect read GetClientBounds;
    property IsDesigning: Boolean read GetIsDesigning;
    property IsDestroying: Boolean read GetIsDestroying;
    property IsLoading: Boolean read GetIsLoading;
    property IsFocused: Boolean read GetIsFocused;
    property MouseCaptureObject: TObject read FMouseCaptureObject write SetMouseCaptureObject;
    property MouseDownPos: TPoint read FMouseDownPos write FMouseDownPos;
  end;

  { customize listbox }

  TcxCustomizeListBox = class(TListBox)
  private
    FDragAndDropItemIndex: Integer;
    FMouseDownPos: TPoint;
    function GetDragAndDropItemObject: TObject;
    function GetItemObject: TObject;
    procedure SetItemObject(Value: TObject);
  {$IFDEF VCL}
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
  {$ENDIF}
  protected
  {$IFDEF VCL}
    procedure CreateParams(var Params: TCreateParams); override;
  {$ENDIF}
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  {$IFNDEF VCL}
    procedure Resize; override;
  {$ENDIF}

    procedure BeginDragAndDrop; dynamic;

    property DragAndDropItemIndex: Integer read FDragAndDropItemIndex;
    property DragAndDropItemObject: TObject read GetDragAndDropItemObject;
  public
    constructor Create(AOwner: TComponent); override;
    property ItemObject: TObject read GetItemObject write SetItemObject;
  end;

  { messagewindow }

  TcxMessageWindow = class
  private
    FHandle: HWND;
  protected
    procedure WndProc(var Message: TMessage); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    property Handle: HWND read FHandle;
  end;

  { popup }

  TcxPopupAlignHorz = (pahLeft, pahCenter, pahRight);
  TcxPopupAlignVert = (pavTop, pavCenter, pavBottom);
  TcxPopupDirection = (pdHorizontal, pdVertical);

  TcxPopupWindow = class(TForm)
  private
    FAdjustable: Boolean;
    FAlignHorz: TcxPopupAlignHorz;
    FAlignVert: TcxPopupAlignVert;
    FBorderSpace: Integer;
    FBorderStyle: TcxPopupBorderStyle;
    FCanvas: TcxCanvas;
    FDirection: TcxPopupDirection;
    FFrameColor: TColor;
    FOwnerBounds: TRect;
    FOwnerParent: TControl;
  {$IFDEF VCL}
    FPrevActiveWindow: HWND;
  {$ELSE}
    FAppDeactivationTimer: TTimer;
  {$ENDIF}
    function GetNCHeight: Integer;
    function GetNCWidth: Integer;
    procedure SetBorderSpace(Value: Integer);
    procedure SetBorderStyle(Value: TcxPopupBorderStyle);
  {$IFDEF VCL}
    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure WMActivateApp(var Message: TWMActivateApp); message WM_ACTIVATEAPP;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
  {$ELSE}
    procedure AppDeactivationTimerHandler(Sender: TObject);
  {$ENDIF}
  protected
    procedure Deactivate; override;
    procedure Paint; override;
  {$IFDEF VCL}
    procedure VisibleChanged; dynamic;
  {$ELSE}
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;
  {$ENDIF}

    function CalculatePosition: TPoint; virtual;
    procedure CalculateSize; virtual;
    function GetBorderWidth(ABorder: TcxBorder): Integer; virtual;
    function GetClientBounds: TRect; virtual;
    function GetFrameWidth(ABorder: TcxBorder): Integer; virtual;
    function GetOwnerScreenBounds: TRect; virtual;
    procedure InitPopup; virtual;
    procedure RestoreControlsBounds;

    procedure DrawFrame; virtual;

    property BorderWidths[ABorder: TcxBorder]: Integer read GetBorderWidth;
    property Canvas: TcxCanvas read FCanvas;
    property FrameWidths[ABorder: TcxBorder]: Integer read GetFrameWidth;
    property NCHeight: Integer read GetNCHeight;
    property NCWidth: Integer read GetNCWidth;
  public
    constructor Create; reintroduce; virtual;
    destructor Destroy; override;
    procedure CloseUp; virtual;
    procedure Popup; virtual;

    property Adjustable: Boolean read FAdjustable write FAdjustable;
    property AlignHorz: TcxPopupAlignHorz read FAlignHorz write FAlignHorz;
    property AlignVert: TcxPopupAlignVert read FAlignVert write FAlignVert;
    property BorderSpace: Integer read FBorderSpace write SetBorderSpace;
    property BorderStyle: TcxPopupBorderStyle read FBorderStyle write SetBorderStyle;
    property ClientBounds: TRect read GetClientBounds;
    property Direction: TcxPopupDirection read FDirection write FDirection;
    property FrameColor: TColor read FFrameColor write FFrameColor;
    property OwnerBounds: TRect read FOwnerBounds write FOwnerBounds;
    property OwnerParent: TControl read FOwnerParent write FOwnerParent;
    property OwnerScreenBounds: TRect read GetOwnerScreenBounds;
  end;

  { drag image }

  TcxDragImageClass = class of TcxDragImage;

  TcxDragImage = class(TcxPopupWindow)
  private
    FImage: TBitmap;
    FImageCanvas: TcxCanvas;
    FPositionOffset: TPoint;
    function GetAlphaBlended: Boolean;
    function GetVisible: Boolean;
    function GetWindowCanvas: TcxCanvas;
    procedure SetVisible(Value: Boolean);
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
    property Image: TBitmap read FImage;
    property WindowCanvas: TcxCanvas read GetWindowCanvas;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Init(const ASourceBounds: TRect; const ASourcePoint: TPoint);
    procedure MoveTo(const APosition: TPoint);
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure Show;
    procedure Hide;

    property AlphaBlended: Boolean read GetAlphaBlended;
    property Canvas: TcxCanvas read FImageCanvas;
    property PositionOffset: TPoint read FPositionOffset write FPositionOffset;
    property Visible: Boolean read GetVisible write SetVisible;
  end;

  { TcxDragAndDropArrow }

  TcxArrowPlace = (apLeft, apTop, apRight, apBottom);

  TcxDragAndDropArrowClass = class of TcxDragAndDropArrow;

  TcxDragAndDropArrow = class(TcxDragImage)
  private
    FTransparent: Boolean;
    function GetTransparent: Boolean;
  protected
    function GetImageBackColor: TColor; virtual;
    property ImageBackColor: TColor read GetImageBackColor;
  public
    constructor Create(ATransparent: Boolean); reintroduce; virtual;
    procedure Init(AOwner: TControl; const AAreaBounds, AClientRect: TRect;
      APlace: TcxArrowPlace);
    property Transparent: Boolean read GetTransparent;
  end;

  { TcxTimer }

  TcxTimer = class (TComponent)
  private
    FEnabled: Boolean;
    FEventID: Cardinal;
    FInterval: Cardinal;
    FTimerOn: Boolean;
    FOnTimer: TNotifyEvent;
    function CanSetTimer: Boolean;
    procedure KillTimer;
    procedure SetEnabled(Value: Boolean);
    procedure SetInterval(Value: Cardinal);
    procedure SetOnTimer(Value: TNotifyEvent);
    procedure SetTimer;
    procedure SetTimerOn(Value: Boolean);
    procedure UpdateTimer;
    property TimerOn: Boolean read FTimerOn write SetTimerOn;
  protected
    procedure TimeOut; dynamic;
{$IFDEF CLR}
  strict protected
    procedure Finalize; override;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Interval: Cardinal read FInterval write SetInterval default 1000;
    property OnTimer: TNotifyEvent read FOnTimer write SetOnTimer;
  end;

{$IFDEF CLR}
  { TcxControlAccess }

  TcxControlAccess = class
    class procedure _DragAndDrop(AInstance: TcxControl; const P: TPoint;
      var Accepted: Boolean);
    class procedure _FocusChanged(AInstance: TcxControl);
    class function _GetHScrollBarBounds(AInstance: TcxControl): TRect;
    class procedure _Modified(AInstance: TcxControl);
  end;
{$ENDIF}

function CanAllocateHandle(AControl: TWinControl): Boolean;
function cxMessageWindow: TcxMessageWindow;
function DragDetect(Wnd: HWND): TcxDragDetect;
function GetMouseKeys: WPARAM;
function GetDblClickInterval: Integer;
function GetDesktopWorkArea(const P: TPoint): TRect;
function GetMouseCursorPos: TPoint;
function GetPointPosition(const ARect: TRect; const P: TPoint;
  AHorzSeparation, AVertSeparation: Boolean): TcxPosition;
function IsChildClassWindow(AWnd: HWND): Boolean;
function IsChildEx(AParentWnd, AWnd: HWND): Boolean;
function IsCtrlPressed: Boolean;
function IsPointInDragDetectArea(const AMouseDownPos: TPoint; X, Y: Integer): Boolean;
function IsNumericChar(C: Char; AType: TcxNumberType): Boolean;
function IsTextChar(C: Char): Boolean;
procedure MakeVisibleOnDesktop(var ABounds: TRect; const ADesktopPoint: TPoint); overload;
procedure MakeVisibleOnDesktop(AControl: TControl); overload;
procedure MapWindowPoint(AHandleFrom, AHandleTo: TcxHandle; var P: TPoint);
procedure MapWindowRect(AHandleFrom, AHandleTo: TcxHandle; var R: TRect);
function RemoveAccelChars(const S: string): string;
procedure SetDesignerModified(AComponent: TComponent);
function ShiftStateToKeys(AShift: TShiftState): WORD;
function TranslateKey(Key: Word): Word;

// mouse tracking
procedure BeginMouseTracking(AControl: TWinControl; const ABounds: TRect;
  ACaller: IcxMouseTrackingCaller);
procedure EndMouseTracking(ACaller: IcxMouseTrackingCaller);
function IsMouseTracking(ACaller: IcxMouseTrackingCaller): Boolean;

// hourglass cursor showing
procedure HideHourglassCursor;
procedure ShowHourglassCursor;

// popup menu routines
function GetPopupMenuHeight(APopupMenu: TPopupMenu): Integer;
function IsPopupMenuShortCut(APopupMenu: TComponent;
  var Message: TWMKey): Boolean;
function ShowPopupMenu(ACaller, AComponent: TComponent; X, Y: Integer): Boolean;
function ShowPopupMenuFromCursorPos(ACaller, AComponent: TComponent): Boolean;

// delphi drag and drop
function GetDragObject: TDragObject;

// drag and drop arrow
function GetDragAndDropArrowBounds(const AAreaBounds, AClientRect: TRect; APlace: TcxArrowPlace): TRect;
procedure GetDragAndDropArrowPoints(const ABounds: TRect; APlace: TcxArrowPlace;
  out P: TPointArray; AForRegion: Boolean);
procedure DrawDragAndDropArrow(ACanvas: TcxCanvas; const ABounds: TRect; APlace: TcxArrowPlace);

procedure DialogApplyFont(ADialog: TCustomForm; AFont: TFont);

function GET_APPCOMMAND_LPARAM(lParam: LPARAM): Integer;
{$EXTERNALSYM GET_APPCOMMAND_LPARAM}

procedure RecreateControlWnd(AControl: TWinControl);

{$IFNDEF DELPHI6}
function CheckWin32Version(AMajor: Integer; AMinor: Integer = 0): Boolean;
{$ENDIF}

{$IFDEF CLR}
{$IFNDEF DELPHI10}
function MapWindowPoints(hWndFrom, hWndTo: HWND; var lpPoint: TPoint;
  cPoints: UINT): Integer; overload;
{$ENDIF}
{$ENDIF}

{$IFDEF VCL}
const
  crBase = 2100;
  crDragCopy = crBase;
  crcxRemove = crBase + 8;
  crcxVertSize = crBase + 9;
  crcxHorzSize = crBase + 10;
  crcxDragMulti = crBase + 11;
  crcxNoDrop = crBase + 12;
  crcxDrag = crBase + 13;
  crcxColorPicker = crBase + 14;
  crcxHandPoint = -crBase + 1;
{$ENDIF}

type
  TcxGetParentFormForDockingFunc = function (AControl: TControl): TCustomForm;
  TcxGetParentWndForDockingFunc = function (AWnd: HWND): HWND;

var
  cxDragAndDropWindowTransparency: Byte = 180;
  cxGetParentFormForDocking: TcxGetParentFormForDockingFunc = nil;
  cxGetParentWndForDocking: TcxGetParentWndForDockingFunc = nil;
  // platform info
  IsWin95X: Boolean = False;
  IsWin2KOrXP: Boolean = False;
  IsWinXP: Boolean = False;
  IsWinNT: Boolean = False;

implementation

{$IFDEF VCL}
{$R cxControls.res}
{$ENDIF}

uses
{$IFDEF VCL}
  dxUxTheme,
  dxThemeConsts,
{$ENDIF}
{$IFDEF CLR}
  System.Runtime.InteropServices,
{$ENDIF}
  SysUtils, Math, cxGeometry;

const
{$IFDEF VCL}
  crFullScroll = crBase + 1;
  crHorScroll = crBase + 2;
  crVerScroll = crBase + 3;
  crUpScroll = crBase + 4;
  crRightScroll = crBase + 5;
  crDownScroll = crBase + 6;
  crLeftScroll = crBase + 7;
{$ELSE}
  CYHSCROLL = 16;
  CXVSCROLL = 16;
{$ENDIF}

  ScreenHandle = {$IFDEF VCL}0{$ELSE}nil{$ENDIF};

type
{$IFNDEF CLR}
  TControlAccess = class(TControl);
  TCustomFormAccess = class(TCustomForm);
  TMenuItemAccess = class(TMenuItem);
{$ENDIF}

  TcxTimerWindow = class(TcxMessageWindow)
  protected
    procedure WndProc(var Message: TMessage); override;
  end;

var
  FDragObject: TDragObject;
  FUser32DLL: HMODULE;
  FcxMessageWindow: TcxMessageWindow;
  FcxTimerWindow: TcxTimerWindow;
  FActiveTimerList: TList;

{$IFNDEF DELPHI7}

type
  TSetLayeredWindowAttributes = function(Hwnd: THandle; crKey: COLORREF; bAlpha: Byte; dwFlags: DWORD): Boolean; stdcall;

var
  SetLayeredWindowAttributes: TSetLayeredWindowAttributes = nil;

procedure InitSetLayeredWindowAttributes;
var
  AModule: HMODULE;
begin
  AModule := GetModuleHandle('User32.dll');
  if AModule <> 0 then
    @SetLayeredWindowAttributes := GetProcAddress(AModule, 'SetLayeredWindowAttributes');
end;

{$ENDIF}

{$IFDEF CLR}
{$IFNDEF DELPHI10}
[DllImport(user32, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'MapWindowPoints')]
function MapWindowPoints(hWndFrom, hWndTo: HWND; var lpPoint: TPoint;
  cPoints: UINT): Integer; external;
{$ENDIF}  
[DllImport(user32, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ScrollWindowEx')]
function ScrollWindowEx(hWnd: HWND; dx, dy: Integer; const prcScroll: TRect;
  prcClip: IntPtr; hrgnUpdate: HRGN; prcUpdate: IntPtr; flags: UINT): BOOL; external;
{$ENDIF}

function CanAllocateHandle(AControl: TWinControl): Boolean;
begin
  Result := AControl.HandleAllocated or (AControl.ParentWindow <> 0) or
    (AControl.Parent <> nil) and CanAllocateHandle(AControl.Parent);
end;

function cxMessageWindow: TcxMessageWindow;
begin
  if FcxMessageWindow = nil then
    FcxMessageWindow := TcxMessageWindow.Create;
  Result := FcxMessageWindow;
end;

function DragDetect(Wnd: HWND): TcxDragDetect;
var
  NoDragZone: TRect;
  P: TPoint;
  Msg: TMsg;
begin
  Result := ddCancel;

  P := GetMouseCursorPos;
  NoDragZone.Right := 2 * Mouse.DragThreshold;//GetSystemMetrics(SM_CXDRAG);
  NoDragZone.Bottom := 2 * Mouse.DragThreshold;//GetSystemMetrics(SM_CYDRAG);
  NoDragZone.Left := P.X - NoDragZone.Right div 2;
  NoDragZone.Top := P.Y - NoDragZone.Bottom div 2;
  Inc(NoDragZone.Right, NoDragZone.Left);
  Inc(NoDragZone.Bottom, NoDragZone.Top);

  SetCapture(Wnd);
  try
    while GetCapture = Wnd do
    begin
      case Integer(GetMessage(Msg, 0, 0, 0)) of
        -1: Break;
        0: begin
            PostQuitMessage(Msg.wParam);
            Break;
          end;
      end;
      try
        case Msg.message of
          WM_KEYDOWN, WM_KEYUP:
            if Msg.wParam = VK_ESCAPE then Break;
          WM_MOUSEMOVE:
            if Msg.hwnd = Wnd then
            begin
              P := Point(LoWord(Msg.lParam), HiWord(Msg.lParam));
              ClientToScreen(Msg.hwnd, P);
              if not PtInRect(NoDragZone, P) then
              begin
                Result := ddDrag;
                Break;
              end;
            end;
          WM_LBUTTONUP, WM_RBUTTONUP, WM_MBUTTONUP:
            begin
              Result := ddNone;
              Break;
            end;
        end;
      finally
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
    end;
  finally
    if GetCapture = Wnd then ReleaseCapture;
  end;
end;

function GetMouseKeys: WPARAM;
begin
  Result := 0;
  if GetAsyncKeyState(VK_LBUTTON) < 0 then Inc(Result, MK_LBUTTON);
  if GetAsyncKeyState(VK_MBUTTON) < 0 then Inc(Result, MK_MBUTTON);
  if GetAsyncKeyState(VK_RBUTTON) < 0 then Inc(Result, MK_RBUTTON);
  if GetAsyncKeyState(VK_CONTROL) < 0 then Inc(Result, MK_CONTROL);
  if GetAsyncKeyState(VK_SHIFT) < 0 then Inc(Result, MK_SHIFT);
end;

function GetDblClickInterval: Integer;
begin
{$IFDEF VCL}
  Result := GetDoubleClickTime;
{$ELSE}
  Result := QApplication_doubleClickInterval;
{$ENDIF}
end;

type
  HMONITOR = type Integer;
  PMonitorInfo = ^TMonitorInfo;
  TMonitorInfo = packed record
    cbSize: DWORD;
    rcMonitor: TRect;
    rcWork: TRect;
    dwFalgs: DWORD;
  end;

{$IFDEF CLR}
[DllImport(User32, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetMonitorInfo')]
function _GetMonitorInfo(hMonitor: HMONITOR; var MonitorInfo: TMonitorInfo): Boolean; external;
[DllImport(User32, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'MonitorFromPoint')]
function _MonitorFromPoint(ptScreenCoords: TPoint; dwFlags: DWORD): HMONITOR; external;
{$ENDIF}

function GetDesktopWorkArea(const P: TPoint): TRect;
{$IFDEF VCL}
const
  MONITOR_DEFAULTTONEAREST = $2;
var
  Info: TMonitorInfo;
  GetMonitorInfo: {$IFNDEF CLR}function(hMonitor: HMONITOR; lpMonitorInfo: PMonitorInfo): Boolean; stdcall{$ELSE}FARPROC{$ENDIF};
  MonitorFromPoint: {$IFNDEF CLR}function(ptScreenCoords: TPoint; dwFlags: DWORD): HMONITOR; stdcall{$ELSE}FARPROC{$ENDIF};
begin
  if FUser32DLL > 32 then
  begin
    GetMonitorInfo := GetProcAddress(FUser32DLL, 'GetMonitorInfoA');
    MonitorFromPoint := GetProcAddress(FUser32DLL, 'MonitorFromPoint');
  end
  else
  begin
    GetMonitorInfo := nil;
    MonitorFromPoint := nil;
  end;

  if not Assigned(GetMonitorInfo) then
    SystemParametersInfo(SPI_GETWORKAREA, 0, {$IFNDEF CLR}@{$ENDIF}Result, 0)
  else
  begin
    Info.cbSize := SizeOf(Info);
  {$IFNDEF CLR}
    GetMonitorInfo(MonitorFromPoint(P, MONITOR_DEFAULTTONEAREST), @Info);
  {$ELSE}
    _GetMonitorInfo(_MonitorFromPoint(P, MONITOR_DEFAULTTONEAREST), Info);
  {$ENDIF}
    Result := Info.rcWork;
  end;
end;
{$ELSE}
begin
  QWidget_rect(QApplication_desktop, @Result);
end;
{$ENDIF}

function GetMouseCursorPos: TPoint;
begin
{$IFDEF VCL}
  if not Windows.GetCursorPos(Result) then
    Result := cxInvalidPoint;
{$ELSE}
  QCursor_pos(@Result);
{$ENDIF}
end;

function GetPointPosition(const ARect: TRect; const P: TPoint;
  AHorzSeparation, AVertSeparation: Boolean): TcxPosition;
const
  Positions: array[Boolean, Boolean] of TcxPosition =
    ((posBottom, posRight), (posLeft, posTop));
type
  TCorner = (BottomLeft, TopLeft, TopRight, BottomRight);

  function GetCornerCoords(ACorner: TCorner): TPoint;
  begin
    case ACorner of
      BottomLeft:
        Result := Point(ARect.Left, ARect.Bottom);
      TopLeft:
        Result := ARect.TopLeft;
      TopRight:
        Result := Point(ARect.Right, ARect.Top);
      BottomRight:
        Result := ARect.BottomRight;
    end;
  end;

  function GetSign(const P1, P2, P: TPoint): Integer;
  begin
    Result := (P.X - P1.X) * (P2.Y - P1.Y) - (P.Y - P1.Y) * (P2.X - P1.X);
  end;

var
  ASign1, ASign2: Integer;
begin
  if AHorzSeparation and AVertSeparation then
  begin
    ASign1 := GetSign(GetCornerCoords(BottomLeft), GetCornerCoords(TopRight), P);
    ASign2 := GetSign(GetCornerCoords(TopLeft), GetCornerCoords(BottomRight), P);
    Result := Positions[ASign1 >= 0, ASign2 >= 0];
  end
  else
    if AHorzSeparation then
      if P.X < GetRangeCenter(ARect.Left, ARect.Right) then
        Result := posLeft
      else
        Result := posRight
    else
      if AVertSeparation then
        if P.Y < GetRangeCenter(ARect.Top, ARect.Bottom) then
          Result := posTop
        else
          Result := posBottom
      else
        Result := posNone;
end;

function IsChildClassWindow(AWnd: HWND): Boolean;
begin
  Result := GetWindowLong(AWnd, GWL_STYLE) and WS_CHILD = WS_CHILD;
end;

function IsChildEx(AParentWnd, AWnd: HWND): Boolean;
begin
  Result := (AParentWnd = AWnd) or IsChild(AParentWnd, AWnd);
end;

function IsCtrlPressed: Boolean;
begin
{$IFDEF VCL}
  Result := GetAsyncKeyState(VK_CONTROL) < 0;
{$ELSE}
  Result := False;
{$ENDIF}
end;

function IsPointInDragDetectArea(const AMouseDownPos: TPoint; X, Y: Integer): Boolean;
begin
  Result :=
    (Abs(X - AMouseDownPos.X) < Mouse.DragThreshold) and
    (Abs(Y - AMouseDownPos.Y) < Mouse.DragThreshold);
end;

function IsNumericChar(C: Char; AType: TcxNumberType): Boolean;
begin
{$IFNDEF CLR}
  Result := C in ['-', '+', '0'..'9'];
{$ELSE}
  Result := (C = '-') or (C = '+') or System.Char.IsDigit(C);
{$ENDIF}
  if AType in [ntFloat, ntExponent] then
  begin
    Result := Result or (C = DecimalSeparator{$IFDEF CLR}[1]{$ENDIF});
    if AType = ntExponent then
      Result := Result or (C = 'e') or (C = 'E');
  end;
end;

function IsTextChar(C: Char): Boolean;
begin
{$IFNDEF CLR}
  Result := C in [#32..#255];
{$ELSE}
  Result := (Word(C) >= 32) and (Word(C) <= 255) or System.Char.IsLetterOrDigit(C);
{$ENDIF}
end;

procedure MakeVisibleOnDesktop(var ABounds: TRect; const ADesktopPoint: TPoint);
var
  ADesktopBounds: TRect;
begin
  ADesktopBounds := GetDesktopWorkArea(ADesktopPoint);
  if ABounds.Right > ADesktopBounds.Right then
    Offsetrect(ABounds, ADesktopBounds.Right - ABounds.Right, 0);
  if ABounds.Bottom > ADesktopBounds.Bottom then
    OffsetRect(ABounds, 0, ADesktopBounds.Bottom - ABounds.Bottom);
  if ABounds.Left < ADesktopBounds.Left then
    OffsetRect(ABounds, ADesktopBounds.Left - ABounds.Left, 0);
  if ABounds.Top < ADesktopBounds.Top then
    OffsetRect(ABounds, 0, ADesktopBounds.Top - ABounds.Top);
end;

procedure MakeVisibleOnDesktop(AControl: TControl);
var
  ABounds: TRect;
begin
  ABounds := AControl.BoundsRect;
  MakeVisibleOnDesktop(ABounds, ABounds.TopLeft);
  AControl.BoundsRect := ABounds;
end;

procedure MapWindowPoint(AHandleFrom, AHandleTo: TcxHandle; var P: TPoint);
begin            {10}
{$IFDEF VCL}
  MapWindowPoints(AHandleFrom, AHandleTo, P, 1);
{$ELSE}
  if AHandleFrom = ScreenHandle then
    QWidget_mapFromGlobal(AHandleTo, @P, @P)
  else
    if AHandleTo = ScreenHandle then
      QWidget_mapToGlobal(AHandleFrom, @P, @P)
    else
    begin
      QWidget_mapToGlobal(AHandleFrom, @P, @P);
      QWidget_mapFromGlobal(AHandleTo, @P, @P);
    end;
      //QWidget_mapFrom(AHandleFrom, @P, AHandleTo, @P);
{$ENDIF}
end;

procedure MapWindowRect(AHandleFrom, AHandleTo: TcxHandle; var R: TRect);
var
  p: TPoint;
begin
  p := R.TopLeft;
  MapWindowPoint(AHandleFrom, AHandleTo, p);
  R.TopLeft := p;
  p := R.BottomRight;
  MapWindowPoint(AHandleFrom, AHandleTo, p);
  R.BottomRight := p;
end;

function RemoveAccelChars(const S: string): string;
const
  AAccelChar: Char = '&';
var
  ALastIndex, I: Integer;
begin
  Result := '';
  I := 1;
  ALastIndex := Length(S);
  while I <= ALastIndex do
  begin
    if S[I] = AAccelChar then
      if I < ALastIndex then
        Inc(I)
      else
      begin
        Result := Result + '_';
        Break;
      end;
    Result := Result + S[I];
    Inc(I);
  end;
end;

procedure SetDesignerModified(AComponent: TComponent);
var
  ADesigner: IDesignerNotify;
  //AParentForm: TCustomForm;
begin
  if (AComponent is TcxControl) and not TcxControl(AComponent).IsDesigning or
    not (AComponent is TcxControl) and not (csDesigning in AComponent.ComponentState) then
    Exit;
  ADesigner := nil;
{$IFNDEF CLR}
  {if AComponent is TControl then
  begin
    AParentForm := GetParentForm(TControl(AComponent));
    if AParentForm <> nil then
      ADesigner := AParentForm.Designer;
  end
  else}
    ADesigner := FindRootDesigner(AComponent);
{$ELSE}
  ADesigner := AComponent.GetRootDesigner;
{$ENDIF}
  if ADesigner <> nil then
    ADesigner.Modified;
end;

function ShiftStateToKeys(AShift: TShiftState): WORD;
begin
  Result := 0;
  if ssShift in AShift then Inc(Result, MK_SHIFT);
  if ssCtrl in AShift then Inc(Result, MK_CONTROL);
  if ssLeft in AShift then Inc(Result, MK_LBUTTON);
  if ssRight in AShift then Inc(Result, MK_RBUTTON);
  if ssMiddle in AShift then Inc(Result, MK_MBUTTON);
end;

function TranslateKey(Key: Word): Word;
begin
{$IFDEF VCL}
  Result := Key;
{$ELSE}
  if (Key = Key_Return) or (Key = Key_Enter) then
    Result := VK_RETURN
  else
    Result := Key;
{$ENDIF}
end;

{$IFDEF VCL}
  {$IFDEF USETCXSCROLLBAR}

{ TcxSettingsController }

type
  TcxSettingsController = class
  private
    FList: TList;
  protected
    FWindow: HWND;
    procedure MainWndProc(var Message: TMessage);
    procedure WndProc(var Message: TMessage); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddListener(AListener: TcxControl);
    procedure NotifyListeners;
    procedure RemoveListener(AListener: TcxControl);
  end;

constructor TcxSettingsController.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TcxSettingsController.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

procedure TcxSettingsController.AddListener(AListener: TcxControl);
begin
  with FList do
    if IndexOf({$IFNDEF CLR}Pointer{$ENDIF}(AListener)) = -1 then
    begin                                 
    {$IFDEF VCL}
      if Count = 0 then
      {$IFDEF DELPHI6}
        {$IFNDEF CLR}
        FWindow := Classes.AllocateHWnd(MainWndProc);
        {$ELSE}
        FWindow := WinUtils.AllocateHWnd(MainWndProc);
        {$ENDIF}
      {$ELSE}
        FWindow := Forms.AllocateHWnd(MainWndProc);
      {$ENDIF}
    {$ENDIF}
      Add({$IFNDEF CLR}Pointer{$ENDIF}(AListener));
    end;
end;

procedure TcxSettingsController.RemoveListener(AListener: TcxControl);
begin
  FList.Remove({$IFNDEF CLR}Pointer{$ENDIF}(AListener));
{$IFDEF VCL}
  if FList.Count = 0 then
  {$IFDEF DELPHI6}
    {$IFNDEF CLR}
    Classes.DeallocateHWnd(FWindow);
    {$ELSE}
    WinUtils.DeallocateHWnd(FWindow);
    {$ENDIF}
  {$ELSE}
    Forms.DeallocateHWnd(FWindow);
  {$ENDIF}
{$ENDIF}
end;

procedure TcxSettingsController.NotifyListeners;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do
    if TCustomControl(FList[I]).HandleAllocated then
      SendNotifyMessage(TCustomControl(FList[I]).Handle, CM_NCSIZECHANGED, 0, 0);
end;

procedure TcxSettingsController.MainWndProc(var Message: TMessage);
begin
  try
    WndProc(Message);
  except
    Application.HandleException(Self);
  end;
end;

procedure TcxSettingsController.WndProc(var Message: TMessage);
begin
  if (Message.Msg = WM_SETTINGCHANGE) and (Message.WParam = SPI_SETNONCLIENTMETRICS) then
  begin
    NotifyListeners;
    Message.Result := 0;
    Exit;
  end;
  with Message do Result := DefWindowProc(FWindow, Msg, wParam, lParam);
end;

var
  FSettingsController: TcxSettingsController;

function cxSettingsController: TcxSettingsController;
begin
  if FSettingsController = nil then
    FSettingsController := TcxSettingsController.Create;
  Result := FSettingsController;
end;

  {$ENDIF}
{$ENDIF}


{ mouse tracking }

var
  FMouseTrackingTimerList: TList;
  FMouseTrackingTimerListIsFinalized: Boolean;

function MouseTrackingTimerList: TList;
begin
  if not FMouseTrackingTimerListIsFinalized and (FMouseTrackingTimerList = nil) then
    FMouseTrackingTimerList := TList.Create;
  Result := FMouseTrackingTimerList;
end;

type
  TMouseTrackingTimer = class(TcxTimer)
  protected
    procedure TimerHandler(Sender: TObject);
  public
    Caller: IcxMouseTrackingCaller;
    Control: TWinControl;
    Bounds: TRect;
    constructor Create(AOwner: TComponent); override;
  end;

constructor TMouseTrackingTimer.Create(AOwner: TComponent);
begin
  inherited;
  Interval := 10;
  OnTimer := TimerHandler;
end;

procedure TMouseTrackingTimer.TimerHandler(Sender: TObject);
var
  ACaller: IcxMouseTrackingCaller;

  function PtInCaller: Boolean;
  var
    ACaller2: IcxMouseTrackingCaller2;
  begin
    if Supports(Caller, IcxMouseTrackingCaller2, ACaller2) then
      Result := Control.HandleAllocated and
        (Caller as IcxMouseTrackingCaller2).PtInCaller(Control.ScreenToClient(GetMouseCursorPos))
    else
      Result := PtInRect(Bounds, GetMouseCursorPos);
  end;

begin
  if not PtInCaller then
  begin
    ACaller := Caller;
    if (Control <> nil) and{$IFDEF VCL} Control.HandleAllocated and{$ENDIF}
      not PtInRect(Control.ClientRect, Control.ScreenToClient(GetMouseCursorPos)) then
      {$IFNDEF CLR}
        SendMessage(Control.Handle, CM_MOUSELEAVE, 0, LPARAM(Control));
      {$ELSE}
        //TODO check it out for CLR
        SendMessage(Control.Handle, CM_MOUSELEAVE, 0, 0);
      {$ENDIF}
    if ACaller <> nil then ACaller.MouseLeave;
    EndMouseTracking(ACaller);
  end;
end;

procedure BeginMouseTracking(AControl: TWinControl; const ABounds: TRect;
  ACaller: IcxMouseTrackingCaller);
var
  ATimer: TMouseTrackingTimer;
begin
  if FMouseTrackingTimerListIsFinalized or IsMouseTracking(ACaller) then Exit;
  ATimer := TMouseTrackingTimer.Create(nil);
  with ATimer do
  begin
    Control := AControl;
    Bounds := ABounds;
    if Control <> nil then
      MapWindowRect(Control.Handle, ScreenHandle, Bounds);
    Caller := ACaller;
  end;
  MouseTrackingTimerList.Add(ATimer);
end;

function GetMouseTrackingTimer(ACaller: IcxMouseTrackingCaller): TMouseTrackingTimer;
var
  I: Integer;
begin
  if not FMouseTrackingTimerListIsFinalized then
  begin
    for I := 0 to MouseTrackingTimerList.Count - 1 do
    begin
      Result := TMouseTrackingTimer(MouseTrackingTimerList[I]);
      if Result.Caller = ACaller then Exit;
    end;
  end;
  Result := nil;
end;

procedure EndMouseTracking(ACaller: IcxMouseTrackingCaller);
var
  ATimer: TMouseTrackingTimer;
begin
  ATimer := GetMouseTrackingTimer(ACaller);
  if ATimer <> nil then
  begin
    MouseTrackingTimerList.Remove(ATimer);
    ATimer.Free;
  end;
end;

{ hourglass cursor showing }

var
  FPrevScreenCursor: TCursor;
  FHourglassCursorUseCount: Integer;

function IsMouseTracking(ACaller: IcxMouseTrackingCaller): Boolean;
begin
  Result := not FMouseTrackingTimerListIsFinalized and (GetMouseTrackingTimer(ACaller) <> nil);
end;

procedure HideHourglassCursor;
begin
  if FHourglassCursorUseCount <> 0 then
  begin
    Dec(FHourglassCursorUseCount);
    if FHourglassCursorUseCount = 0 then
      Screen.Cursor := FPrevScreenCursor;
  end;
end;

procedure ShowHourglassCursor;
begin
  if FHourglassCursorUseCount = 0 then
  begin
    FPrevScreenCursor := Screen.Cursor;
    Screen.Cursor := crHourglass;
  end;
  Inc(FHourglassCursorUseCount);
end;

{ popup menu routines }

function GetPopupMenuHeight(APopupMenu: TPopupMenu): Integer;

  function IsOwnerDrawItem(AMenuItem: TMenuItem): Boolean;
  begin
    Result := APopupMenu.OwnerDraw or (AMenuItem.GetImageList <> nil) or
      not AMenuItem.Bitmap.Empty;
  end;

const
  AMenuItemHeightCorrection = 4;
  APopupMenuHeightCorrection = 4;
var
  ACanvas: TcxScreenCanvas;
  AMenuItemDefaultHeight, AMenuItemHeight, AMenuItemWidth, I: Integer;
begin
  ACanvas := TcxScreenCanvas.Create;
  try
    ACanvas.Font.Assign(Screen.MenuFont);
    AMenuItemDefaultHeight := ACanvas.TextHeight('Qg') + AMenuItemHeightCorrection;

    Result := 0;
    for I := 0 to APopupMenu.Items.Count - 1 do
      if APopupMenu.Items[I].Visible then
      begin
        AMenuItemHeight := AMenuItemDefaultHeight;
        if IsOwnerDrawItem(APopupMenu.Items[I]) then
        {$IFNDEF CLR}
          TMenuItemAccess(APopupMenu.Items[I]).MeasureItem(ACanvas.Canvas,
            AMenuItemWidth, AMenuItemHeight);
        {$ELSE}
          IMenuItem(APopupMenu.Items[I]).MeasureItem(ACanvas.Canvas, AMenuItemWidth, AMenuItemHeight);
        {$ENDIF}
        Inc(Result, AMenuItemHeight);
      end;
    Inc(Result, APopupMenuHeightCorrection);
  finally
    ACanvas.Free;
  end;
end;

function IsPopupMenuShortCut(APopupMenu: TComponent;
  var Message: TWMKey): Boolean;
var
  AIcxPopupMenu: IcxPopupMenu;
begin
  Result := False;
  if APopupMenu = nil then
    Exit;

  if Supports(APopupMenu, IcxPopupMenu, AIcxPopupMenu) then
    Result := AIcxPopupMenu.IsShortCutKey(Message)
  else
    Result := (APopupMenu is TPopupMenu) and (TPopupMenu(APopupMenu).WindowHandle <> 0) and
      TPopupMenu(APopupMenu).IsShortCut(Message);
end;

function ShowPopupMenu(ACaller, AComponent: TComponent; X, Y: Integer): Boolean;
var
  AIcxPopupMenu: IcxPopupMenu;
begin
  Result := False;
  if AComponent <> nil then
  begin
    Result := True;
    if Supports(AComponent, IcxPopupMenu, AIcxPopupMenu) then
      AIcxPopupMenu.Popup(X, Y)
    else
      if (AComponent is TPopupMenu) and TPopupMenu(AComponent).AutoPopup then
        with TPopupMenu(AComponent) do
        begin
          PopupComponent := ACaller;
          Popup(X, Y);
        end
      else
        Result := False;
  end;
end;

function ShowPopupMenuFromCursorPos(ACaller, AComponent: TComponent): Boolean;
var
  P: TPoint;
begin
  GetCursorPos(P);
  Result := ShowPopupMenu(ACaller, AComponent, P.X, P.Y);
end;

function GetDragObject: TDragObject;
begin
  Result := FDragObject;
end;

{ drag and drop arrow }

const
  DragAndDropArrowWidth = 11;
  DragAndDropArrowHeight = 9;
  DragAndDropArrowBorderColor = clBlack;
  DragAndDropArrowColor = clLime;

function GetDragAndDropArrowBounds(const AAreaBounds, AClientRect: TRect;
  APlace: TcxArrowPlace): TRect;

  procedure CheckResult;
  begin
    if IsRectEmpty(AClientRect) then Exit;
    with AClientRect do
    begin
      Result.Left := Max(Result.Left, Left);
      Result.Right := Max(Result.Right, Left);
      Result.Left := Min(Result.Left, Right - 1);
      Result.Right := Min(Result.Right, Right - 1);

      Result.Top := Max(Result.Top, Top);
      Result.Bottom := Max(Result.Bottom, Top);
      Result.Top := Min(Result.Top, Bottom - 1);
      Result.Bottom := Min(Result.Bottom, Bottom - 1);
    end;
  end;

  procedure CalculateHorizontalArrowBounds;
  begin
    Result.Bottom := Result.Top + 1;
    InflateRect(Result, 0, DragAndDropArrowWidth div 2);
    if APlace = apLeft then
    begin
      Result.Right := Result.Left;
      Dec(Result.Left, DragAndDropArrowHeight);
    end
    else
    begin
      Result.Left := Result.Right;
      Inc(Result.Right, DragAndDropArrowHeight);
    end;
  end;

  procedure CalculateVerticalArrowBounds;
  begin
    Result.Right := Result.Left + 1;
    InflateRect(Result, DragAndDropArrowWidth div 2, 0);
    if APlace = apTop then
    begin
      Result.Bottom := Result.Top;
      Dec(Result.Top, DragAndDropArrowHeight);
    end
    else
    begin
      Result.Top := Result.Bottom;
      Inc(Result.Bottom, DragAndDropArrowHeight);
    end;
  end;

begin
  Result := AAreaBounds;
  CheckResult;
  if APlace in [apLeft, apRight] then
    CalculateHorizontalArrowBounds
  else
    CalculateVerticalArrowBounds;
end;

procedure GetDragAndDropArrowPoints(const ABounds: TRect; APlace: TcxArrowPlace;
  out P: TPointArray; AForRegion: Boolean);

  procedure CalculatePointsForLeftArrow;
  begin
    with ABounds do
    begin
      P[0] := Point(Left + 3, Top - Ord(AForRegion));
      P[1] := Point(Left + 3, Top + 3);
      P[2] := Point(Left, Top + 3);
      P[3] := Point(Left, Bottom - 4 + Ord(AForRegion));
      P[4] := Point(Left + 3, Bottom - 4 + Ord(AForRegion));
      P[5] := Point(Left + 3, Bottom - 1 + Ord(AForRegion));
      P[6] := Point(Right - 1 + Ord(AForRegion), Top + 5);
    end;
  end;

  procedure CalculatePointsForTopArrow;
  begin
    with ABounds do
    begin
      P[0] := Point(Left + 3, Top);
      P[1] := Point(Right - 4 + Ord(AForRegion), Top);
      P[2] := Point(Right - 4 + Ord(AForRegion), Top + 3);
      P[3] := Point(Right - 1 + Ord(AForRegion), Top + 3);
      P[4] := Point(Left + 5, Bottom - 1 + Ord(AForRegion));
      P[5] := Point(Left, Top + 3);
      P[6] := Point(Left + 3, Top + 3);
    end;
  end;

  procedure CalculatePointsForRightArrow;
  begin
    with ABounds do
    begin
      P[0] := Point(Right - 4 + Ord(AForRegion), Top - Ord(AForRegion));
      P[1] := Point(Right - 4 + Ord(AForRegion), Top + 3);
      P[2] := Point(Right - 1 + Ord(AForRegion), Top + 3);
      P[3] := Point(Right - 1 + Ord(AForRegion), Bottom - 4 + Ord(AForRegion));
      P[4] := Point(Right - 4 + Ord(AForRegion), Bottom - 4 + Ord(AForRegion));
      P[5] := Point(Right - 4 + Ord(AForRegion), Bottom - 1 + Ord(AForRegion));
      P[6] := Point(Left, Top + 5);
    end;
  end;

  procedure CalculatePointsForBottomArrow;
  begin
    with ABounds do
    begin
      P[0] := Point(Left + 3, Bottom - 1 + Ord(AForRegion));
      P[1] := Point(Right - 4 + Ord(AForRegion), Bottom - 1 + Ord(AForRegion));
      P[2] := Point(Right - 4 + Ord(AForRegion), Bottom - 4 + Ord(AForRegion));
      P[3] := Point(Right - 1 + Ord(AForRegion), Bottom - 4 + Ord(AForRegion));
      P[4] := Point(Left + 5, Top - Ord(AForRegion));
      P[5] := Point(Left - Ord(AForRegion), Bottom - 4 + Ord(AForRegion));
      P[6] := Point(Left + 3, Bottom - 4);
    end;
  end;

begin
  SetLength(P, 7);
  case APlace of
    apLeft:
      CalculatePointsForLeftArrow;
    apTop:
      CalculatePointsForTopArrow;
    apRight:
      CalculatePointsForRightArrow;
    apBottom:
      CalculatePointsForBottomArrow;
  end;
end;

procedure DrawDragAndDropArrow(ACanvas: TcxCanvas; const ABounds: TRect;
  APlace: TcxArrowPlace);
var
  P: TPointArray;
begin
  GetDragAndDropArrowPoints(ABounds, APlace, P, False);
  ACanvas.Brush.Color := DragAndDropArrowColor;
  ACanvas.Pen.Color := DragAndDropArrowBorderColor;
  ACanvas.Polygon(P);
end;

{ other }

procedure DialogApplyFont(ADialog: TCustomForm; AFont: TFont);
{$IFNDEF CLR}

  function GetTextHeight: Integer;
  begin
    Result := ADialog.Canvas.TextHeight('Qq');
  end;

var
  AOldTextHeight, ANewTextHeight: Integer;
{$ENDIF}
begin
  with ADialog do
  begin
  {$IFNDEF CLR}
    AOldTextHeight := GetTextHeight;
  {$ENDIF}
    Font := AFont;
  {$IFNDEF CLR}
    ANewTextHeight := GetTextHeight;
    TCustomFormAccess(ADialog).ScaleControls(ANewTextHeight, AOldTextHeight);
    ClientWidth := MulDiv(ClientWidth, ANewTextHeight, AOldTextHeight);
    ClientHeight := MulDiv(ClientHeight, ANewTextHeight, AOldTextHeight);
  {$ENDIF}
  end;
end;

function GET_APPCOMMAND_LPARAM(lParam: LPARAM): Integer;
begin
  Result := Short(HiWord(lParam) and not FAPPCOMMAND_MASK);
end;

procedure RecreateControlWnd(AControl: TWinControl);
begin
  if AControl.HandleAllocated then
    AControl.Perform(CM_RECREATEWND, 0, 0);
end;

{$IFNDEF DELPHI6}
function CheckWin32Version(AMajor: Integer; AMinor: Integer = 0): Boolean;
begin
  Result := (Win32MajorVersion > AMajor) or
    ((Win32MajorVersion = AMajor) and (Win32MinorVersion >= AMinor));
end;
{$ENDIF}

{$IFDEF CLR}

{ TLBGetItemRect }

function TLBGetItemRect.GetItemIndex: Integer;
begin
  Result := WParam;
end;

function TLBGetItemRect.GetRect: TRect;
begin
  Result := TRect(Marshal.PtrToStructure(IntPtr(LParam), TypeOf(TRect)));
end;

procedure TLBGetItemRect.SetItemIndex(Value: Integer);
begin
  WParam := Value;
end;

procedure TLBGetItemRect.SetRect(const Value: TRect);
begin
  Marshal.StructureToPtr(TObject(Value), IntPtr(OriginalMessage.LParam), False);
end;

{$ENDIF}

{ TcxControlChildComponent }

constructor TcxControlChildComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Initialize;
end;

constructor TcxControlChildComponent.CreateEx(AControl: TcxControl; AAssignOwner: Boolean = True);
begin
  //FControl := AControl;
  if AAssignOwner then
    Create(AControl.Owner)
  else
    Create(nil);
  Control := AControl;
end;

destructor TcxControlChildComponent.Destroy;
begin
  if FControl <> nil then
    FControl.RemoveChildComponent(Self);
  inherited;
end;

function TcxControlChildComponent.GetIsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

function TcxControlChildComponent.GetIsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

procedure TcxControlChildComponent.Initialize;
begin
end;

procedure TcxControlChildComponent.SetControl(Value: TcxControl);
begin
  FControl := Value;
end;

procedure TcxControlChildComponent.SetParentComponent(Value: TComponent);
begin
  inherited;
  if Value is TcxControl then
    TcxControl(Value).AddChildComponent(Self);
end;

function TcxControlChildComponent.GetParentComponent: TComponent;
begin
  Result := FControl;
end;

function TcxControlChildComponent.HasParent: Boolean;
begin
  Result := FControl <> nil;
end;

{ TcxControlScrollBar }

constructor TcxControlScrollBar.Create(AOwner: TComponent);
begin
  inherited;
  Color := clBtnFace;
  ControlStyle := ControlStyle - [csFramed] + [csNoDesignVisible];
  TabStop := False;
  Visible := False;
{$IFNDEF VCL}  //!!!
  Height := CYHSCROLL;
  Width := CXVSCROLL;
{$ENDIF}
{$IFDEF USETCXSCROLLBAR}
  LookAndFeel.MasterLookAndFeel := TcxControl(AOwner).LookAndFeel;
{$ENDIF}
end;

function TcxControlScrollBar.GetVisible: boolean;
begin
  Result := inherited Visible;
end;

procedure TcxControlScrollBar.SetVisible(Value: boolean);
begin
  inherited Visible := Value;
{$IFNDEF VCL}
  if csDesigning in ComponentState then
    if Value then
      QWidget_show(Handle)
    else
      QWidget_hide(Handle);
{$ENDIF}
end;

{$IFDEF VCL}

procedure TcxControlScrollBar.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
  Message.Result := 1;
end;

{$ENDIF}

{$IFDEF VCL}

procedure TcxControlScrollBar.WndProc(var Message: TMessage);
begin
  if Message.Msg = WM_LBUTTONDOWN then FocusParent;
  inherited;
end;

{$ELSE}

function TcxControlScrollBar.DesignEventQuery(Sender: QObjectH; Event: QEventH): Boolean;
begin
  Result := True;
end;

function TcxControlScrollBar.EventFilter(Sender: QObjectH; Event: QEventH): Boolean;
begin
  if (QEvent_type(Event) = QEventType_MouseButtonPress) and
    (QMouseEvent_button(QMouseEventH(Event)) = ButtonState_LeftButton) then
    FocusParent;
  Result := inherited EventFilter(Sender, Event);
end;

{$IFNDEF USETCXSCROLLBAR}

procedure TcxControlScrollBar.InitWidget;
begin
  inherited InitWidget;
  QWidget_setFocusPolicy(Handle, QWidgetFocusPolicy_NoFocus);
  //QClxObjectMap_add(FHandle, Integer(FControl));
end;

{$ENDIF}

procedure TcxControlScrollBar.WidgetDestroyed;
begin
  //QClxObjectMap_remove(FHandle);
  inherited WidgetDestroyed;
end;

function TcxControlScrollBar.CanFocus: Boolean;
begin
  Result := False;
end;

{$ENDIF}

procedure TcxControlScrollBar.FocusParent;
begin
  if Parent = nil then Exit;
  if (Parent is TcxControl) and TcxControl(Parent).FocusWhenChildIsClicked(Self) or
    not (Parent is TcxControl) and Parent.CanFocus then
    Parent.SetFocus;
end;

procedure TcxControlScrollBar.ApplyData;
begin
  if Data.Visible then
  begin
{$IFNDEF USETCXSCROLLBAR}
  {$IFDEF VCL}
    PageSize := Data.PageSize;
  {$ENDIF}
    SetParams(Data.Position, Data.Min, Data.Max);
  {$IFDEF VCL}
    PageSize := Data.PageSize;  // to resetup
  {$ENDIF}
{$ELSE}
    SetScrollParams(Data.Min, Data.Max, Data.Position, Data.PageSize, True);
{$ENDIF}
    SmallChange := Data.SmallChange;
    LargeChange := Data.LargeChange;
  end;
  Enabled := Data.Enabled;
  Visible := Data.Visible;
end;

{ TcxSizeGrip }

constructor TcxSizeGrip.Create(AOwner: TComponent);
begin
  inherited;
  Color := {$IFDEF VCL}clBtnFace{$ELSE}clButton{$ENDIF};
  ControlStyle := ControlStyle + [csNoDesignVisible];
end;

procedure TcxSizeGrip.Paint;
begin
  Canvas.Brush.Color := Color;
  Canvas.FillRect(ClientRect);
end;

{ TcxDragAndDropObject }

constructor TcxDragAndDropObject.Create(AControl: TcxControl);
begin
  inherited Create;
  FControl := AControl;
  FCanvas := Control.Canvas;
  CurMousePos := Point(-1, -1);
  PrevMousePos := Point(-1, -1);
end;

procedure TcxDragAndDropObject.SetDirty(Value: Boolean);
begin
  if FDirty <> Value then
  begin
    FDirty := Value;
    DirtyChanged;
  end;
end;

procedure TcxDragAndDropObject.ChangeMousePos(const P: TPoint);
begin
  PrevMousePos := CurMousePos;
  CurMousePos := P;
end;

procedure TcxDragAndDropObject.DirtyChanged;
begin
end;

function TcxDragAndDropObject.GetDragAndDropCursor(Accepted: Boolean): TCursor;
const
  Cursors: array[Boolean] of TCursor = (crNoDrop, crDrag);
begin
  Result := Cursors[Accepted];
end;

function TcxDragAndDropObject.GetImmediateStart: Boolean;
begin
  Result := False;
end;

procedure TcxDragAndDropObject.AfterDragAndDrop(Accepted: Boolean);
begin
end;

procedure TcxDragAndDropObject.BeginDragAndDrop;
begin
  DirtyChanged;
end;

procedure TcxDragAndDropObject.DragAndDrop(const P: TPoint; var Accepted: Boolean);
begin
  Dirty := False;
  Screen.Cursor := GetDragAndDropCursor(Accepted);
end;

procedure TcxDragAndDropObject.EndDragAndDrop(Accepted: Boolean);
begin
  Dirty := True;
end;

procedure TcxDragAndDropObject.DoBeginDragAndDrop;
begin
  CurMousePos := Control.ScreenToClient(GetMouseCursorPos);
  PrevMousePos := CurMousePos;
  BeginDragAndDrop;
end;

procedure TcxDragAndDropObject.DoDragAndDrop(const P: TPoint; var Accepted: Boolean);
begin
  ChangeMousePos(P);
  DragAndDrop(P, Accepted);
end;

procedure TcxDragAndDropObject.DoEndDragAndDrop(Accepted: Boolean);
begin
  EndDragAndDrop(Accepted);
  AfterDragAndDrop(Accepted);
end;

{ TcxDragControlObject }

procedure TcxDragControlObject.Finished(Target: TObject; X, Y: Integer; Accepted: Boolean);
begin
  inherited;
  Free;
end;

{$IFDEF VCL}

function TcxDragControlObject.GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor;
begin
  if Accepted and (Control as TcxControl).IsCopyDragDrop then
    Result := crDragCopy
  else
    Result := inherited GetDragCursor(Accepted, X, Y);
end;

{$ENDIF}

{ TcxControl }

constructor TcxControl.Create(AOwner: TComponent);
begin
  inherited;
  if HasDragImages then
    ControlStyle := ControlStyle + [csDisplayDragImage];
  FCanvas := TcxCanvas.Create(inherited Canvas);
  FDefaultCursor := Cursor;
  FFocusOnClick := True;
  FFontListenerList := TInterfaceList.Create;
  FLookAndFeel := TcxLookAndFeel.Create(Self);
  FLookAndFeel.OnChanged := LookAndFeelChanged;
  FScrollBars := ssBoth;
  CreateScrollBars;
  TabStop := MayFocus;
{$IFDEF VCL}
  FLastParentBackground := True;
  ParentBackground := True;
{$ENDIF}
end;

destructor TcxControl.Destroy;
begin
  EndDrag(False);
  DestroyScrollBars;
  FFontListenerList := nil;
  FreeAndNil(FActiveCanvas);
  FCanvas.Free;
  FreeAndNil(FLookAndFeel);
  cxClearObjectLinks(Self);
  inherited;
end;

{$IFDEF DELPHI4}
{$IFNDEF CLR}
procedure TcxControl.BeforeDestruction;
begin
  if not (csDestroying in ComponentState) then
    Destroying;
end;
{$ENDIF}
{$ENDIF}

function TcxControl.GetActiveCanvas: TcxCanvas;
begin
{$IFDEF VCL}
  if HandleAllocated then
  begin
    if FActiveCanvas <> nil then FreeAndNil(FActiveCanvas);
    Result := Canvas;
  end
  else
  begin
    if FActiveCanvas = nil then
      FActiveCanvas := TcxScreenCanvas.Create;
    Result := FActiveCanvas;
  end;
{$ELSE}
  Result := Canvas;
{$ENDIF}
end;

function TcxControl.GetDragAndDropObject: TcxDragAndDropObject;
begin
  if FDragAndDropObject = nil then
    FDragAndDropObject := GetDragAndDropObjectClass.Create(Self);
  Result := FDragAndDropObject;
end;

function TcxControl.GetHScrollBarVisible: Boolean;
begin
  if NeedsScrollBars then
    if FCalculatingScrollBarsParams then
      Result := FHScrollBar.Data.Visible
    else
      Result := FHScrollBar.Visible
  else
    Result := False;  
end;

function TcxControl.GetIsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

function TcxControl.GetIsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

function TcxControl.GetVScrollBarVisible: Boolean;
begin
  if NeedsScrollBars then
    if FCalculatingScrollBarsParams then
      Result := FVScrollBar.Data.Visible
    else
      Result := FVScrollBar.Visible
  else
    Result := False;  
end;

procedure TcxControl.SetBorderStyle(Value: TcxControlBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    BoundsChanged;
  end;
end;

procedure TcxControl.SetDragAndDropState(Value: TcxDragAndDropState);
begin
  if FDragAndDropState <> Value then
  begin
    FDragAndDropState := Value;
    if (Value = ddsNone) and not FFinishingDragAndDrop then DoCancelMode;
  end;
end;

procedure TcxControl.SetLookAndFeel(Value: TcxLookAndFeel);
begin
  LookAndFeel.Assign(Value);
end;

procedure TcxControl.SetKeys(Value: TcxKeys);
{$IFNDEF VCL}
const
  InputKey: array[TcxKey] of TInputKey = (ikAll, ikArrows, ikChars, ikTabs);
var
  I: TcxKey;
{$ENDIF}
begin
  if FKeys <> Value then
  begin
    FKeys := Value;
  {$IFNDEF VCL}
    InputKeys := [];
    for I := Low(TcxKey) to High(TcxKey) do
      if I in FKeys then
        InputKeys := InputKeys + [InputKey[I]];
  {$ENDIF}
  end;
end;

procedure TcxControl.SetMouseCaptureObject(Value: TObject);
var
  AIMouseCaptureObject: IcxMouseCaptureObject;
  AMouseWasCaught: Boolean;
begin
  if FMouseCaptureObject <> Value then
  begin
    if (FMouseCaptureObject <> nil) and
      Supports(FMouseCaptureObject, IcxMouseCaptureObject, AIMouseCaptureObject) then
      AIMouseCaptureObject.DoCancelMode;
    FMouseCaptureObject := Value;
    AMouseWasCaught := MouseCapture;
    MouseCapture := FMouseCaptureObject <> nil;
    if AMouseWasCaught and not MouseCapture and (DragAndDropState = ddsStarting) then
      Perform(WM_CANCELMODE, 0, 0);
  end;
end;

procedure TcxControl.SetPopupMenu(Value: TComponent);
var
  AIcxPopupMenu: IcxPopupMenu;
begin
  // check Value
  if (Value <> nil) and not ((Value is TPopupMenu) or
    Supports(Value, IcxPopupMenu, AIcxPopupMenu)) then
    Value := nil;
  if FPopupMenu <> Value then
  begin
    if FPopupMenu <> nil then
      FPopupMenu.RemoveFreeNotification(Self);
    FPopupMenu := Value;
    if FPopupMenu <> nil then
      FPopupMenu.FreeNotification(Self);
  end;
end;

procedure TcxControl.SetScrollBars(Value: TScrollStyle);
begin
  if FScrollBars <> Value then
  begin
    FScrollBars := Value;
    BoundsChanged;
  end;
end;

{$IFDEF VCL}

  {$IFNDEF DELPHI7}
procedure TcxControl.SetParentBackground(Value: Boolean);
begin
  if FParentBackground <> Value then
  begin
    FParentBackground := Value;
    Invalidate;
  end;
end;
  {$ENDIF}

procedure TcxControl.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
  FinishDragAndDrop(False);
  DoCancelMode;
end;

procedure TcxControl.WMContextMenu(var Message: TWMContextMenu);
var
  Pt, Temp: TPoint;
  Handled: Boolean;
begin
  if Message.Result <> 0 then Exit;
  if csDesigning in ComponentState then
  begin
    inherited;
    Exit;
  end;

  Pt := SmallPointToPoint(Message.Pos);
  if (Pt.x = -1) and (Pt.y = -1) then
    Temp := Pt
  else
  begin
    Temp := ScreenToClient(Pt);
    if not PtInRect(ClientRect, Temp) then
    begin
      inherited;
      Exit;
    end;
  end;

  Handled := False;
  DoContextPopup(Temp, Handled);
  Message.Result := Ord(Handled);
  if Handled then Exit;

  inherited;
end;

procedure TcxControl.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if HasBackground then
    inherited
  else
    Message.Result := 1;
end;

procedure TcxControl.WMGetDlgCode(var Message: TWMGetDlgCode);
const
  DlgCodes: array[TcxKey] of Integer =
    (DLGC_WANTALLKEYS, DLGC_WANTARROWS, DLGC_WANTCHARS, DLGC_WANTTAB);
var
  I: TcxKey;
  Res: Integer;
begin
  Res := 0;
  for I := Low(TcxKey) to High(TcxKey) do
    if (I in FKeys) and ((I <> kTab) or (GetAsyncKeyState(VK_CONTROL) >= 0)) then
      Inc(Res, DlgCodes[I]);
  Message.Result := Res;
end;

procedure TcxControl.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  PostMessage(Handle, CM_NCSIZECHANGED, 0, 0);
end;

procedure TcxControl.WMPaint(var Message: TWMPaint);
begin
  HideDragImage;
  inherited;
  ShowDragImage;
end;

procedure TcxControl.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
begin
  P := ScreenToClient(GetMouseCursorPos);
  with P do
    if IsDesigning and (DragAndDropState = ddsNone) and GetDesignHitTest(X, Y, [ssLeft]) then
      SetCursor(Screen.Cursors[GetCursor(X, Y)])
    else
      inherited;
end;

procedure TcxControl.CMColorChanged(var Message: TMessage);
begin
  ColorChanged;
  inherited;
end;

procedure TcxControl.CMCursorChanged(var Message: TMessage);
begin
  CursorChanged;
  inherited;
end;

procedure TcxControl.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
  inherited;
  with Message do
    if Result = 0 then
      Result := Integer(GetDesignHitTest(XPos, YPos, KeysToShiftState(Keys)));
end;

procedure TcxControl.CMFontChanged(var Message: TMessage);
begin
  inherited;
  FontChanged;
end;

procedure TcxControl.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if Message.lParam = 0 then
    MouseEnter(Self)
  else
  {$IFNDEF CLR}
    MouseEnter(TControl(Message.lParam));
  {$ELSE}
    //TODO CLR check it out
    if (Parent <> nil) and (Message.lParam < Parent.ControlCount)
      and (Message.lParam >= 0) then
      MouseEnter(Parent.Controls[Message.lParam]);
  {$ENDIF}
end;

procedure TcxControl.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if Message.lParam = 0 then
    MouseLeave(Self)
  else
  {$IFNDEF CLR}
    MouseLeave(TControl(Message.lParam));
  {$ELSE}
    //TODO CLR check it out
    if (Parent <> nil) and (Message.lParam < Parent.ControlCount)
      and (Message.lParam >= 0) then
      MouseLeave(Parent.Controls[Message.lParam]);
  {$ENDIF}
end;

procedure TcxControl.CMNCSizeChanged(var Message: TMessage);
var
  ANewHeight, ANewWidth: Integer;
begin
  if not NeedsScrollBars then Exit;
  ANewHeight := GetSystemMetrics(SM_CYHSCROLL);
  ANewWidth  := GetSystemMetrics(SM_CXVSCROLL);
  if (FHScrollBar.Height <> ANewHeight) or (FVScrollBar.Width <> ANewWidth) then
  begin
    FHScrollBar.Height := ANewHeight;
    FVScrollBar.Width := ANewWidth;
    BoundsChanged;
  end;
end;

procedure TcxControl.CMTextChanged(var Message: TMessage);
begin
  inherited;
  TextChanged;
end;

procedure TcxControl.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
  VisibleChanged;
end;

procedure TcxControl.CNKeyDown(var Message: TWMKeyDown);
begin
  // TODO: for D7 UpdateUIState(Message.CharCode);?
  if IsMenuKey(Message) then
  begin
    Message.Result := 1;
    Exit;
  end;
  if DragAndDropState <> ddsNone then
  begin
    if Message.CharCode = VK_ESCAPE  then
      SendMessage(Handle, WM_KEYDOWN, Message.CharCode, Message.KeyData);
    Message.Result := 1;
    Exit;
  end;
  inherited;
end;

procedure TcxControl.CNSysKeyDown(var Message: TWMKeyDown);
begin
  if IsMenuKey(Message) then
  begin
    Message.Result := 1;
    Exit;
  end;
  inherited;
end;

{$ENDIF}

procedure TcxControl.CreateScrollBars;
begin
  if not NeedsScrollBars or (FSizeGrip <> nil) then Exit;
  FHScrollBar := TcxControlScrollBar.Create(Self);
  FHScrollBar.Kind := sbHorizontal;
  FHScrollBar.OnScroll := ScrollEvent;
  FVScrollBar := TcxControlScrollBar.Create(Self);
  FVScrollBar.Kind := sbVertical;
  FVScrollBar.OnScroll := ScrollEvent;
  FSizeGrip := TcxSizeGrip.Create(Self);
{$IFNDEF VCL}
  FHScrollBar.Height := CYHSCROLL;
  FVScrollBar.Width := CXVSCROLL;
{$ENDIF}
{$IFDEF VCL}
  {$IFDEF USETCXSCROLLBAR}
    cxSettingsController.AddListener(Self);
  {$ENDIF}
{$ENDIF}
end;

procedure TcxControl.DestroyScrollBars;
begin
  if FSizeGrip = nil then Exit;
{$IFDEF VCL}
  {$IFDEF USETCXSCROLLBAR}
    cxSettingsController.RemoveListener(Self);
  {$ENDIF}
{$ENDIF}
  FreeAndNil(FSizeGrip);
  FreeAndNil(FVScrollBar);
  FreeAndNil(FHScrollBar);
end;

procedure TcxControl.ScrollEvent(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
  Scroll(TcxControlScrollBar(Sender).Kind, ScrollCode, ScrollPos);
end;

{$IFDEF VCL}

procedure TcxControl.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    Style := Style or WS_CLIPCHILDREN;
end;

procedure TcxControl.CreateWnd;
begin
  FCreatingWindow := True;
  try
    inherited;
    CheckNeedsScrollBars;
    InitControl;
  finally
    FCreatingWindow := False;
  end;
end;

procedure TcxControl.Resize;
begin
  inherited;
  BoundsChanged;
end;

procedure TcxControl.WndProc(var Message: TMessage);
var
  ALink: TcxObjectLink;
{$IFDEF CLR}
  AMouseMessage: TWMMouse;
{$ENDIF}

  function GetMousePos: TPoint;
  begin
    if HandleAllocated and ((Width > 32768) or (Height > 32768)) then
      Result := ScreenToClient(GetMouseCursorPos)
    else
      Result := SmallPointToPoint(TWMMouse{$IFDEF CLR}.Create{$ENDIF}(Message).Pos);
  end;

  function GetMouseButton: TMouseButton;
  begin
    case Message.Msg of
      WM_LBUTTONDOWN:
        Result := mbLeft;
      WM_RBUTTONDOWN:
        Result := mbRight;
    else
      Result := mbMiddle;
    end;
  end;

  procedure DoAfterMouseDown;
  begin
    case Message.Msg of
      WM_LBUTTONDOWN, WM_RBUTTONDOWN, WM_MBUTTONDOWN:
        with GetMousePos do
          AfterMouseDown(GetMouseButton, X, Y);
    end;
  end;

begin
  ALink := cxAddObjectLink(Self);
  try
    if ((Message.Msg = WM_LBUTTONDOWN) or (Message.Msg = WM_LBUTTONDBLCLK)) and not Dragging and
      (IsDesigning and GetDesignHitTest(GetMousePos.X, GetMousePos.Y, [ssLeft]) or
       not IsDesigning and (DragMode = dmAutomatic)) then
    begin
    {$IFNDEF CLR}
      if not IsControlMouseMsg(TWMMouse(Message)) then
    {$ELSE}
      AMouseMessage := TWMMouse.Create(Message);
      if not IsControlMouseMsg(AMouseMessage) then
    {$ENDIF}
      begin
        ControlState := ControlState + [csLButtonDown];
        Dispatch(Message);
        ControlState := ControlState - [csLButtonDown];
      end;
      Exit;
    end;
    if Message.Msg = WM_RBUTTONUP then
      FMouseRightButtonReleased := True;
    inherited;
  finally
    if ALink.Ref <> nil then
    begin
      case Message.Msg of
    {    WM_KEYDOWN:
          if Message.wParam = VK_ESCAPE then FinishDragAndDrop(False);//!!!}
        WM_RBUTTONUP:
          FMouseRightButtonReleased := False;
        WM_SETFOCUS, WM_KILLFOCUS:
          FocusChanged;
        WM_PAINT:
          if ParentBackground <> FLastParentBackground then
          begin
            FLastParentBackground := ParentBackground;
            ParentBackgroundChanged;
          end;
      end;
      DoAfterMouseDown;
    end;
    cxRemoveObjectLink(ALink);
  end;
end;

{$ELSE}

function TcxControl.DesignEventQuery(Sender: QObjectH; Event: QEventH): Boolean;
var
  P: TPoint;
  AShiftState: TShiftState;

  function GetShiftState: TShiftState;
  begin
    Result := ButtonStateToShiftState(QMouseEvent_state(QMouseEventH(Event)));
    case GetMouseEventButton(Event) of
      mbLeft:
        Include(Result, ssLeft);
      mbRight:
        Include(Result, ssRight);
      mbMiddle:
        Include(Result, ssMiddle);
    end;
  end;

  function GetCurrentCursor: TCursor;
  begin
    if GetDesignHitTest(P.X, P.Y, AShiftState + [ssLeft]) then
      Result := GetCursor(P.X, P.Y)
    else
      Result := FDefaultCursor;
  end;

begin
  Result := inherited DesignEventQuery(Sender, Event);
  if not Result and (Sender = Handle) and
    (QEvent_type(Event) in [QEventType_MouseButtonPress, QEventType_MouseButtonRelease,
      QEventType_MouseButtonDblClick, QEventType_MouseMove]) then
  begin
    P := GetMouseEventPos(Event);
    AShiftState := GetShiftState;
    Result := GetDesignHitTest(P.X, P.Y, AShiftState);
    if DragAndDropState = ddsNone then
      QWidget_setCursor(Handle, Screen.Cursors[GetCurrentCursor]);
  end;
end;

function TcxControl.EventFilter(Sender: QObjectH; Event: QEventH): Boolean;
var
  ALink: TcxControlListenerLink;

  procedure DoAfterMouseDown;
  begin
    if QEvent_type(Event) in [QEventType_MouseButtonPress, QEventType_MouseButtonDblClick] then
      with FMouseDownPos do
        AfterMouseDown(GetMouseEventButton(Event), X, Y);
  end;

begin
  ALink := AddListenerLink(self);
  try
    case QEvent_type(Event) of
      QEventType_MouseButtonPress, QEventType_MouseButtonDblClick:
        if Sender = Handle then
        begin
          FMouseDownPos := GetMouseEventPos(Event);
          with FMouseDownPos do
            if (GetMouseEventButton(Event) = mbLeft) and
              (DragMode = dmAutomatic) and not Dragging and
              (not IsDesigning or GetDesignHitTest(X, Y, [ssLeft])) then
            begin
              ControlState := ControlState +
                [{$IFDEF DELPHI7}csDragAllow, {$ENDIF}{$IFDEF KYLIX3}csDragAllow, {$ENDIF}csLButtonDown];
              Application.CancelHint;
              if csCaptureMouse in ControlStyle then
                SetMouseGrabControl(Self)
              else
                if GetMouseGrabControl = nil then
                  SetMouseGrabControl(nil);
              if csClickEvents in ControlStyle then
                ControlState := ControlState + [csClicked];
              MouseDown(mbLeft, ButtonStateToShiftState(QMouseEvent_state(QMouseEventH(Event))), X, Y);
              Result := False;
              Exit;
            end;
        end;
    end;
    Result := inherited EventFilter(Sender, Event);
    case QEvent_type(Event) of
      QEventType_FocusIn, QEventType_FocusOut:
        FocusChanged;
      QEventType_MouseButtonRelease:
        CancelMouseOperations;
    end;
  finally
    if ALink.Ref <> nil then
      DoAfterMouseDown;
   RemoveListenerLink(ALink);
  end;
end;

procedure TcxControl.InitWidget;
begin
  inherited;
  if not MayFocus then
    QWidget_setFocusPolicy(Handle, QWidgetFocusPolicy_NoFocus);
  if not HasBackground then
    QWidget_setBackgroundMode(Handle, QWidgetBackgroundMode_NoBackground);
  InitControl;
end;

procedure TcxControl.SetParent(const AParent: TWidgetControl);
begin                             {4}
  // no check for <> in inherited method - to avoid bugs from ReSubmitFlags
  if (csLoading in ComponentState) or (Parent <> AParent) then
    inherited;
end;

{$ENDIF}

procedure TcxControl.DestroyWindowHandle;
begin
  inherited DestroyWindowHandle;
  ControlState := ControlState - [csClicked];
end;

procedure TcxControl.DoContextPopup({$IFNDEF VCL}const {$ENDIF}MousePos: TPoint;
  var Handled: Boolean);
var
  P: TPoint;
begin
  inherited;
  if not Handled then
  begin
    if (MousePos.X = -1) and (MousePos.Y = -1) then
      P := ClientToScreen(Point(0, 0)) // TODO: GetOffsetPos method
    else
      P := ClientToScreen(MousePos);
    Handled := DoShowPopupMenu(PopupMenu, P.X, P.Y);
  end;
end;

function TcxControl.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
  {$IFNDEF VCL}const{$ENDIF} MousePos: TPoint): Boolean;
const
  ADirections: array[Boolean, Boolean] of TcxDirection = ((dirLeft, dirRight), (dirUp, dirDown));
var
  I: Integer;
begin
  Result := inherited DoMouseWheel(Shift, WheelDelta, MousePos);
  if not Result and (MouseWheelScrollingKind <> mwskNone) then
  begin
    for I := 0 to {$IFDEF VCL}Mouse.WheelScrollLines{$ELSE}QApplication_wheelScrollLines{$ENDIF} - 1 do
      ScrollContent(ADirections[MouseWheelScrollingKind = mwskVertical, WheelDelta < 0]);
    Result := True;
  end;
end;

function TcxControl.DoShowPopupMenu(AMenu: TComponent; X, Y: Integer): Boolean;
begin
  Result := ShowPopupMenu(Self, AMenu, X, Y);
end;

function TcxControl.GetPopupMenu: TPopupMenu;
begin
  if FPopupMenu is TPopupMenu then
    Result := TPopupMenu(FPopupMenu)
  else
    Result := nil;
end;

function TcxControl.IsMenuKey(var Message: TWMKey): Boolean;
var
  AControl: TWinControl;
begin
  Result := False;
  if not IsDesigning then
  begin
    AControl := Self;
    repeat
      if (AControl is TcxControl) and
        IsPopupMenuShortCut(TcxControl(AControl).PopupMenu, Message) then
      begin
        Result := True;
        Break;
      end;
      AControl := AControl.Parent;
    until AControl = nil;
  end;
end;

procedure TcxControl.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then FinishDragAndDrop(False);
  inherited;
end;

procedure TcxControl.Modified;

  function IsValidComponentState(AComponent: TComponent): Boolean;
  begin
    Result := AComponent.ComponentState * [csLoading, csWriting, csDestroying] = [];
  end;

var
  AControl: TWinControl;
  ACanSetModified: Boolean;
begin
  if not IsDesigning then Exit;
  ACanSetModified := False;
  AControl := Self;
  while AControl is TWinControl do
  begin
    ACanSetModified := IsValidComponentState(AControl);
    if not ACanSetModified then Break;
    AControl := AControl.Parent;
  end;
  if ACanSetModified then
    SetDesignerModified(Self);
end;

procedure TcxControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  procedure ProcessDragAndDrop;
  begin
    if (Button = mbLeft) and not (ssDouble in Shift) and StartDragAndDrop(Point(X, Y)) then
      if DragAndDropObject.ImmediateStart then
        BeginDragAndDrop
      else
        DragAndDropState := ddsStarting
    else
      FinishDragAndDrop(False);
  end;

var
  ALink: TcxObjectLink;
  AOriginalBounds: TRect;
begin
  FMouseDownPos := Point(X, Y);
  ALink := cxAddObjectLink(Self);
  try
    if CanFocusOnClick(X, Y) and not (ssDouble in Shift) then  // to allow form showing on dbl click
    begin
      AOriginalBounds := BoundsRect;
      SetFocus;
      if ALink.Ref = nil then Exit;
      // to workaround the bug in VCL with parented forms
      if (GetParentForm(Self) <> nil) and (GetParentForm(Self).ActiveControl = Self) and
        not IsFocused then
        Windows.SetFocus(Handle);
      if not IsFocused and not AllowDragAndDropWithoutFocus then
      begin
        MouseCapture := False;
        Exit;
      end;
      Inc(X, AOriginalBounds.Left - Left);
      Inc(Y, AOriginalBounds.Top - Top);
    end;
    ProcessDragAndDrop;
    if ALink.Ref = nil then Exit;
    BeforeMouseDown(Button, Shift, X, Y);
    if ALink.Ref = nil then Exit;
    inherited;
  finally
    if ALink.Ref <> nil then
      if MouseCapture then FMouseButtonPressed := True;
    cxRemoveObjectLink(ALink);
  end;
end;

procedure TcxControl.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  AAccepted: Boolean;

  procedure SetCursor;
  var
    ACursor: TCursor;
  begin
    ACursor := FDefaultCursor;
    Cursor := GetCursor(X, Y);
    FDefaultCursor := ACursor;
  end;

begin
  SetCursor;
  inherited;
  if (DragAndDropState = ddsStarting) and not IsMouseInPressedArea(X, Y) then
    BeginDragAndDrop;
  if DragAndDropState = ddsInProcess then
  begin
    AAccepted := False;
    DragAndDrop(Point(X, Y), AAccepted);
  end;
end;

procedure TcxControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FMouseButtonPressed := False;
  CancelMouseOperations;
  inherited;
end;

procedure TcxControl.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = PopupMenu) then
    PopupMenu := nil; 
end;

procedure TcxControl.Paint;
begin
  if FBorderStyle = cxcbsDefault then
  begin
    LookAndFeelPainter.DrawBorder(Canvas, Bounds);
    Canvas.IntersectClipRect(ClientBounds);
  end;
  inherited;
  // CB9021 - bug in VCL: to actually show internal controls
  // if they were made visible when one of the parent's Showing was False
  UpdateInternalControlsState;
end;

{$IFDEF VCL}

procedure TcxControl.ColorChanged;
begin
end;

procedure TcxControl.DoScrolling;
const
  ScrollTimeStep = 20;
  ScrollValueStep = 5;
  MaxSpeed = 12;
var
  BreakOnMouseUp: Boolean;
  AllowHorScrolling, AllowVerScrolling: Boolean;
  P, PrevP, AnchorPos: TPoint;
  AnchorSize, Speed, TimerHits: Integer;
  AnchorWnd, CaptureWnd: HWND;
  Direction: TcxDirection;
  Timer: UINT;
  Msg: TMsg;

  function CreateScrollingAnchorWnd: HWND;
  var
    B: TBitmap;
    W, H: Integer;
    Rgn: HRGN;
    DC: HDC;

    function GetResourceBitmapName: string;
    begin
      if AllowHorScrolling and AllowVerScrolling then
        Result := 'CX_FULLSCROLLBITMAP'
      else
        if AllowHorScrolling then
          Result := 'CX_HORSCROLLBITMAP'
        else
          Result := 'CX_VERSCROLLBITMAP';
    end;

  begin
    B := TBitmap.Create;
    B.LoadFromResourceName(HInstance, GetResourceBitmapName);

    W := B.Width;
    H := B.Height;
    AnchorSize := W;
    with AnchorPos do
      Result := CreateWindowEx(WS_EX_TOPMOST, 'STATIC', nil, WS_POPUP,
        X - W div 2, Y - H div 2, W, H, Handle, 0, HInstance, nil);
    Rgn := CreateEllipticRgn(0, 0, W + 1, H + 1);
    SetWindowRgn(Result, Rgn, True);
    SetWindowPos(Result, 0, 0, 0, 0, 0,
      SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW or SWP_NOACTIVATE);

    DC := GetWindowDC(Result);
    BitBlt(DC, 0, 0, W, H, B.Canvas.Handle, 0, 0, SRCCOPY);
    Rgn := CreateEllipticRgn(0, 0, W + 1, H + 1);
    FrameRgn(DC, Rgn, GetSysColorBrush(COLOR_WINDOWTEXT), 1, 1);
    DeleteObject(Rgn);
    ReleaseDC(Result, DC);

    B.Free;
  end;

  procedure CalcDirectionAndSpeed(const P: TPoint);
  var
    DeltaX, DeltaY, SpeedValue: Integer;

    function GetNeutralZone: TRect;
    begin
      {$IFNDEF CLR}
      Result := Classes.Bounds(AnchorPos.X - AnchorSize div 2, AnchorPos.Y - AnchorSize div 2, AnchorSize, AnchorSize);
      {$ELSE}
      Result := Types.Bounds(AnchorPos.X - AnchorSize div 2, AnchorPos.Y - AnchorSize div 2, AnchorSize, AnchorSize);
      {$ENDIF}
      if not AllowHorScrolling then
      begin
        Result.Left := 0;
        Result.Right := Screen.Width;
      end;
      if not AllowVerScrolling then
      begin
        Result.Top := 0;
        Result.Bottom := Screen.Height;
      end;
    end;

  begin
    if PtInRect(GetNeutralZone, P) then
    begin
      Direction := dirNone;
      Speed := 0;
      Exit;
    end
    else
    begin
      BreakOnMouseUp := True;
      DeltaX := P.X - AnchorPos.X;
      DeltaY := P.Y - AnchorPos.Y;
      if AllowHorScrolling and (not AllowVerScrolling or (Abs(DeltaX) > Abs(DeltaY))) then
      begin
        if DeltaX < 0 then
          Direction := dirLeft
        else
          Direction := dirRight;
        SpeedValue := Abs(DeltaX);
      end
      else
      begin
        if DeltaY < 0 then
          Direction := dirUp
        else
          Direction := dirDown;
        SpeedValue := Abs(DeltaY);
      end;
    end;
    Dec(SpeedValue, AnchorSize div 2);
    Speed := 1 + SpeedValue div ScrollValueStep;
    if Speed > MaxSpeed then Speed := MaxSpeed;
  end;

  procedure SetMouseCursor;
  var
    Cursor: TCursor;
  begin
    case Direction of
      dirLeft:
        Cursor := crLeftScroll;
      dirUp:
        Cursor := crUpScroll;
      dirRight:
        Cursor := crRightScroll;
      dirDown:
        Cursor := crDownScroll;
    else
      if AllowHorScrolling and AllowVerScrolling then
        Cursor := crFullScroll
      else
        if AllowHorScrolling then
          Cursor := crHorScroll
        else
          Cursor := crVerScroll;
    end;
    SetCursor(Screen.Cursors[Cursor]);
  end;

begin
  AllowHorScrolling := HScrollBarVisible;
  AllowVerScrolling := VScrollBarVisible;
  if not (AllowHorScrolling or AllowVerScrolling) then Exit;
  FIsScrollingContent := True;
  BreakOnMouseUp := False;
  PrevP := GetMouseCursorPos;
  AnchorPos := PrevP;
  AnchorWnd := CreateScrollingAnchorWnd;
  Direction := dirNone;
  SetMouseCursor;
  Speed := 1;
  TimerHits := 0;
  Timer := SetTimer(0, 0, ScrollTimeStep, nil);

  CaptureWnd := Handle;
  SetCapture(CaptureWnd);
  try
    while GetCapture = CaptureWnd do
    begin
      case Integer(GetMessage(Msg, 0, 0, 0)) of
        -1: Break;
        0: begin
            PostQuitMessage(Msg.wParam);
            Break;
          end;
      end;
      if (Msg.message = WM_PAINT) and (Msg.hwnd = AnchorWnd) then
      begin
        ValidateRect(AnchorWnd, nil);
        Continue;
      end;
      if (Msg.message >= WM_MOUSEFIRST) and (Msg.message <= WM_MOUSELAST) and
        (Msg.message <> WM_MOUSEMOVE) and (Msg.message <> WM_MBUTTONUP) then
        Break;
      try
        case Msg.message of
          WM_KEYDOWN, WM_KEYUP:
            if Msg.wParam = VK_ESCAPE then Break;
          WM_MOUSEMOVE:
            begin
            {$IFNDEF CLR}
              P := SmallPointToPoint(TSmallPoint(Msg.lParam));
              Windows.ClientToScreen(Msg.hwnd, P);
            {$ELSE}
              P := Msg.pt;
            {$ENDIF}
              if (P.X <> PrevP.X) or (P.Y <> PrevP.Y) then
              begin
                CalcDirectionAndSpeed(P);
                SetMouseCursor;
                PrevP := P;
              end;
            end;
          WM_LBUTTONDOWN, WM_RBUTTONDOWN:
            Break;
          WM_MBUTTONUP:
            if BreakOnMouseUp then Break;
          WM_TIMER:
            if UINT(Msg.wParam) = Timer then
            begin
              Inc(TimerHits);
              if TimerHits mod (MaxSpeed - Speed + 1) = 0 then
                ScrollContent(Direction);
            end;
        end;
      finally
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
    end;
  finally
    if GetCapture = CaptureWnd then ReleaseCapture;

    KillTimer(0, Timer);
    DestroyWindow(AnchorWnd);
    FIsScrollingContent := False;
  end;
end;

procedure TcxControl.ParentBackgroundChanged;
begin
end;

procedure TcxControl.VisibleChanged;
begin
end;

{$ENDIF}

procedure TcxControl.AddChildComponent(AComponent: TcxControlChildComponent);
begin
  AComponent.Control := Self;
end;

procedure TcxControl.RemoveChildComponent(AComponent: TcxControlChildComponent);
begin
  AComponent.Control := nil;
end;

procedure TcxControl.AfterMouseDown(AButton: TMouseButton; X, Y: Integer);
begin
  if (DragMode = dmAutomatic) and (AButton = mbLeft) and
    MouseCapture and { to prevent drag and drop when mouse button is released already }
    (not IsDesigning or AllowAutoDragAndDropAtDesignTime(X, Y, [])) and
    CanDrag(X, Y) and (DragDetect(Handle) = ddDrag) then
    BeginDrag(True{False});
  if AButton = mbMiddle then DoScrolling;
end;

function TcxControl.AllowAutoDragAndDropAtDesignTime(X, Y: Integer;
  Shift: TShiftState): Boolean;
begin
  Result := True;
end;

function TcxControl.AllowDragAndDropWithoutFocus: Boolean;
begin
  Result := False;
end;

procedure TcxControl.BeforeMouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
end;

procedure TcxControl.BoundsChanged;
begin
  {$IFNDEF VCL}inherited;{$ENDIF}
  UpdateScrollBars;
end;

procedure TcxControl.BringInternalControlsToFront;
begin
  FHScrollBar.BringToFront;
  FVScrollBar.BringToFront;
  FSizeGrip.BringToFront;
end;

procedure TcxControl.CancelMouseOperations;
begin
  FinishDragAndDrop(True);
  MouseCaptureObject := nil;
end;

function TcxControl.CanDrag(X, Y: Integer): Boolean;
begin
  Result := DragAndDropState = ddsNone;
end;

function TcxControl.CanFocusOnClick: Boolean;
begin
  Result := not IsDesigning and FFocusOnClick and MayFocus and CanFocus;
end;

function TcxControl.CanFocusOnClick(X, Y: Integer): Boolean;
begin
  Result := CanFocusOnClick;
end;

procedure TcxControl.CursorChanged;
begin
  FDefaultCursor := Cursor;
{$IFNDEF VCL}
  inherited;
  if HandleAllocated and IsDesigning then
    QWidget_setCursor(Handle, Screen.Cursors[Cursor]);
{$ENDIF}
end;

procedure TcxControl.DoCancelMode;
begin
  FMouseButtonPressed := False;
  MouseCaptureObject := nil;
end;

procedure TcxControl.FocusChanged;
begin
  if Assigned(FOnFocusChanged) then FOnFocusChanged(Self);
end;

function TcxControl.FocusWhenChildIsClicked(AChild: TControl): Boolean;
begin
  Result := CanFocusOnClick;
end;

procedure TcxControl.FontChanged;
var
  I: Integer;
begin
  for I := 0 to FFontListenerList.Count - 1 do
    IcxFontListener(FFontListenerList[I]).Changed(Self, Font);
{$IFDEF VCL}
  Invalidate;
{$ELSE}
  inherited;
{$ENDIF}
end;

function TcxControl.GetBorderSize: Integer;
begin
  if FBorderStyle = cxcbsNone then
    Result := 0
  else
    Result := LookAndFeelPainter.BorderSize;
end;

function TcxControl.GetBounds: TRect;
begin
  if IsRectEmpty(FBounds) then
    if HandleAllocated then
      Result := ClientRect
    else
      Result := Rect(0, 0, Width, Height)
  else
    Result := FBounds;
end;

function TcxControl.GetClientBounds: TRect;
begin
  Result := Bounds;
  InflateRect(Result, -BorderSize, -BorderSize);
  if HScrollBarVisible then
    Dec(Result.Bottom, FHScrollBar.Height);
  if VScrollBarVisible then
    Dec(Result.Right, FVScrollBar.Width);
end;

function TcxControl.GetCursor(X, Y: Integer): TCursor;
begin
  Result := FDefaultCursor;
end;

function TcxControl.GetDesignHitTest(X, Y: Integer; Shift: TShiftState): Boolean;
begin
  Result := (DragAndDropState <> ddsNone) or FMouseButtonPressed;
end;

function TcxControl.GetDragObjectClass: TDragControlObjectClass;
begin
  Result := TcxDragControlObject;
end;

function TcxControl.GetIsDesigning: Boolean;
begin
  Result := csDesigning in ComponentState;
end;

function TcxControl.GetIsFocused: Boolean;
begin                                {7}
{$IFDEF VCL}
  Result := Focused;
{$ELSE}
  // Focused is wrong when form/app is inactive
  Result := HandleAllocated and QWidget_hasFocus(Handle);
{$ENDIF}
end;

function TcxControl.GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind;
begin
  if VScrollBarVisible then
    Result := mwskVertical
  else
    Result := mwskNone;
end;

function TcxControl.HasBackground: Boolean;
begin
  Result := False;
end;

procedure TcxControl.InitControl;
begin
  InitScrollBars;
end;

function TcxControl.IsInternalControl(AControl: TControl): Boolean;
begin
  Result := (AControl = FHScrollBar) or (AControl = FVScrollBar) or
    (AControl = FSizeGrip);
end;

function TcxControl.MayFocus: Boolean;
begin
  Result := True;
end;

procedure TcxControl.MouseEnter(AControl: TControl);
begin
  {$IFNDEF VCL}inherited;{$ENDIF}
  if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
end;

procedure TcxControl.MouseLeave(AControl: TControl);
begin
  {$IFNDEF VCL}inherited;{$ENDIF}
  if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
end;

procedure TcxControl.TextChanged;
begin
{$IFNDEF VCL}
  inherited TextChanged;
{$ENDIF}
end;

function TcxControl.GetLookAndFeelValue: TcxLookAndFeel;
begin
  Result := LookAndFeel;
end;

function TcxControl.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := LookAndFeel.Painter;
end;

procedure TcxControl.LookAndFeelChanged(Sender: TcxLookAndFeel;
  AChangedValues: TcxLookAndFeelValues);
begin
end;

procedure TcxControl.InitScrollBarsParameters;
begin
end;

function TcxControl.IsPixelScrollBar(AKind: TScrollBarKind): Boolean;
begin
  Result := False;
end;

function TcxControl.NeedsScrollBars: Boolean;
begin
  Result := True;
end;

function TcxControl.NeedsToBringInternalControlsToFront: Boolean;
begin
{$IFDEF DELPHI9}
  Result := not IsDesigning;
{$ELSE}
  Result := True;
{$ENDIF}
end;

procedure TcxControl.Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
  var AScrollPos: Integer);
begin
end;

procedure TcxControl.CheckNeedsScrollBars;
begin
  if NeedsScrollBars then
  begin
    CreateScrollBars;
    if HandleAllocated then
      InitScrollBars;
  end
  else
    DestroyScrollBars;
end;

function TcxControl.GetHScrollBarBounds: TRect;
begin
  Result := ClientBounds;
  Result.Top := Result.Bottom;
  Result.Bottom := Result.Top + FHScrollBar.Height;
end;

function TcxControl.GetSizeGripBounds: TRect;
begin
  with Result do
  begin
    Left := FVScrollBar.Left;
    Right := Left + FVScrollBar.Width;
    Top := FHScrollBar.Top;
    Bottom := Top + FHScrollBar.Height;
  end;
end;

function TcxControl.GetVScrollBarBounds: TRect;
begin
  Result := ClientBounds;
  Result.Left := Result.Right;
  Result.Right := Result.Left + FVScrollBar.Width;
end;

procedure TcxControl.InitScrollBars;
begin
  if NeedsScrollBars then
  begin
    FHScrollBar.Parent := Self;
    FVScrollBar.Parent := Self;
    FSizeGrip.Parent := Self;
  end;
end;

procedure TcxControl.SetInternalControlsBounds;
begin
  if FHScrollBar.Visible then
    FHScrollBar.BoundsRect := GetHScrollBarBounds;
  if FVScrollBar.Visible then
    FVScrollBar.BoundsRect := GetVScrollBarBounds;
  if FSizeGrip.Visible then
    FSizeGrip.BoundsRect := GetSizeGripBounds;
end;

procedure TcxControl.UpdateInternalControlsState;
begin
  if not NeedsScrollBars then Exit;
  if FHScrollBar.Visible then
    FHScrollBar.UpdateControlState;
  if FVScrollBar.Visible then
    FVScrollBar.UpdateControlState;
  if FSizeGrip.Visible then
    FSizeGrip.UpdateControlState;
end;

procedure TcxControl.UpdateScrollBars;
var
  APrevUpdatingScrollBars, APrevHScrollBarVisible, APrevVScrollBarVisible: Boolean;

  procedure CalculateScrollBarsParams;
  var
    APrevHScrollBarVisible, APrevVScrollBarVisible: Boolean;

    procedure CheckPixelScrollBars;
    var
      AHideScrollBar: array[TScrollBarKind] of Boolean;
      I: TScrollBarKind;

      function GetScrollBar(AScrollBarKind: TScrollBarKind): TcxControlScrollBar;
      begin
        if AScrollBarKind = sbHorizontal then
          Result := FHScrollBar
        else
          Result := FVScrollBar;
      end;

      function CanHide(AScrollBarKind: TScrollBarKind): Boolean;
      begin
        with GetScrollBar(AScrollBarKind).Data do
          Result := Visible and Enabled and AllowHide;
      end;

      function GetOppositeScrollBarSize(AScrollBarKind: TScrollBarKind): Integer;
      begin
        if AScrollBarKind = sbHorizontal then
          Result := FVScrollBar.Width
        else
          Result := FHScrollBar.Height;
      end;

      procedure CheckPixelScrollBar(AScrollBarKind: TScrollBarKind);
      begin
        if IsPixelScrollBar(AScrollBarKind) then
          with GetScrollBar(AScrollBarKind).Data do
            if PageSize + GetOppositeScrollBarSize(AScrollBarKind) >= Max - Min + 1 then
              AHideScrollBar[AScrollBarKind] := True;
      end;

    begin
      if not CanHide(sbHorizontal) or not CanHide(sbVertical) then Exit;
      AHideScrollBar[sbHorizontal] := False;
      AHideScrollBar[sbVertical] := False;
      CheckPixelScrollBar(sbHorizontal);
      CheckPixelScrollBar(sbVertical);
      if AHideScrollBar[sbHorizontal] and AHideScrollBar[sbVertical] then
        for I := Low(TScrollBarKind) to High(TScrollBarKind) do
          with GetScrollBar(I).Data do
            SetScrollBarInfo(I, Min, Max, SmallChange, PageSize + GetOppositeScrollBarSize(I),
              Position, AllowShow, AllowHide);
    end;

  begin
    if FCalculatingScrollBarsParams then Exit;
    FCalculatingScrollBarsParams := True;
    try
      FHScrollBar.Data.Visible := False;
      FVScrollBar.Data.Visible := False;
      repeat
        APrevHScrollBarVisible := HScrollBarVisible;
        APrevVScrollBarVisible := VScrollBarVisible;
        //BoundsChanged; - causes things like Left/TopPos to be recalculated during scrolling
        InitScrollBarsParameters;
      until (HScrollBarVisible = APrevHScrollBarVisible) and
        (VScrollBarVisible = APrevVScrollBarVisible);
      CheckPixelScrollBars;
    finally
      FCalculatingScrollBarsParams := False;
    end;
  end;

  function GetIsInitialScrollBarsParams: Boolean;
  begin
    Result := APrevUpdatingScrollBars and
      (FHScrollBar.Data.Visible = FInitialHScrollBarVisible) and
      (FVScrollBar.Data.Visible = FInitialVScrollBarVisible);
  end;

  procedure CheckScrollBarParams(AScrollBar: TcxControlScrollBar; AInitialVisible: Boolean);
  begin
    with AScrollBar do
      if Visible <> AInitialVisible then
      begin
        Enabled := False;
        Visible := True;
      end;
  end;

  function IsBoundsChangeNeeded: Boolean;
  begin
    Result :=
      (FHScrollBar.Visible <> APrevHScrollBarVisible) or
      (FVScrollBar.Visible <> APrevVScrollBarVisible);
  end;

begin
  if not NeedsScrollBars then Exit;
  if FScrollBarsLockCount > 0 then
  begin
    FScrollBarsUpdateNeeded := True;
    Exit;
  end;
  if not FUpdatingScrollBars then
  begin
    FInitialHScrollBarVisible := FHScrollBar.Visible;
    FInitialVScrollBarVisible := FVScrollBar.Visible;
  end;
  APrevUpdatingScrollBars := FUpdatingScrollBars;
  FUpdatingScrollBars := True;
  try
    APrevHScrollBarVisible := FHScrollBar.Visible;
    APrevVScrollBarVisible := FVScrollBar.Visible;
    if not FIsInitialScrollBarsParams then
    begin
      CalculateScrollBarsParams;
      FIsInitialScrollBarsParams := GetIsInitialScrollBarsParams;
      if FIsInitialScrollBarsParams then
      begin
        CheckScrollBarParams(FHScrollBar, FInitialHScrollBarVisible);
        CheckScrollBarParams(FVScrollBar, FInitialVScrollBarVisible);
      end
      else
      begin
        FHScrollBar.ApplyData;
        FVScrollBar.ApplyData;
      end;
    end;
    if IsBoundsChangeNeeded then
      BoundsChanged
    else
    begin
      FSizeGrip.Visible := FHScrollBar.Visible and FVScrollBar.Visible;
      SetInternalControlsBounds;
      if NeedsToBringInternalControlsToFront then
        BringInternalControlsToFront;
    end;
  finally
    if not APrevUpdatingScrollBars then
      FIsInitialScrollBarsParams := False;
    FUpdatingScrollBars := APrevUpdatingScrollBars;
  end;
end;

procedure TcxControl.DragAndDrop(const P: TPoint; var Accepted: Boolean);
begin
  DragAndDropObject.DoDragAndDrop(P, Accepted);
end;

procedure TcxControl.EndDragAndDrop(Accepted: Boolean);
begin
  DragAndDropState := ddsNone;
  Screen.Cursor := FDragAndDropPrevCursor;
  MouseCapture := False;
  MouseCaptureObject := nil;
  DragAndDropObject.DoEndDragAndDrop(Accepted);
  {DragAndDropObject.DoEndDragAndDrop(Accepted);
  SetCaptureControl(nil);
  DragAndDropState := ddsNone;
  Screen.Cursor := FDragAndDropPrevCursor;}
end;

function TcxControl.GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
begin
  Result := FDragAndDropObjectClass;
  if Result = nil then
    Result := TcxDragAndDropObject;
end;

function TcxControl.StartDragAndDrop(const P: TPoint): Boolean;
begin
  Result := False;
end;

procedure TcxControl.DoStartDrag(var DragObject: TDragObject);
begin
  Update;
  inherited;
  if (DragObject = nil) and (GetDragObjectClass <> nil) then
    DragObject := GetDragObjectClass.Create(Self);
  if not StartDrag(DragObject) then
  begin
    DragObject.Free;
    DragObject := nil;
    CancelDrag;
  end;
end;

procedure TcxControl.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  inherited;
  FreeAndNil(FDragImages);
end;

procedure TcxControl.DragOver(Source: TObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
  if Source is TDragObject then
    if State = dsDragLeave then
      FDragObject := nil
    else
      FDragObject := TDragObject(Source);
  inherited;
end;

procedure TcxControl.DrawDragImage(ACanvas: TcxCanvas; const R: TRect);
begin
end;

function TcxControl.GetDragImages: TDragImageList;
begin
  if HasDragImages then
  begin
    if FDragImages = nil then
    begin
      FDragImages := GetDragImagesClass.Create(nil);
      InitDragImages(FDragImages);
    end;
    if FDragImages.Count = 0 then
      Result := nil
    else
      Result := FDragImages;
  end
  else
    Result := nil;
end;

function TcxControl.GetDragImagesClass: TcxDragImageListClass;
begin
  Result := TcxDragImageList;
end;

function TcxControl.GetDragImagesSize: TPoint;
begin
  Result := Point(0, 0);
end;

function TcxControl.GetIsCopyDragDrop: Boolean;
begin
  Result := IsCtrlPressed;
end;

function TcxControl.HasDragImages: Boolean;
begin
  Result := False;
end;

procedure TcxControl.HideDragImage;
begin
  if GetDragObject <> nil then
    GetDragObject.HideDragImage;
end;

procedure TcxControl.InitDragImages(ADragImages: TcxDragImageList);
var
  B: TBitmap;
  ACanvas: TcxCanvas;
begin
  with ADragImages, GetDragImagesSize do
  begin
    Width := X;
    Height := Y;
    if (X = 0) or (Y = 0) then Exit;
  end;

  B := TBitmap.Create;
  try
    with B do
    begin
      Width := ADragImages.Width;
      Height := ADragImages.Height;
      ACanvas := TcxCanvas.Create(Canvas);
      try
        DrawDragImage(ACanvas, Rect(0, 0, Width, Height));
      finally
        ACanvas.Free;
      end;
    end;
    ADragImages.AddMasked(B, B.TransparentColor);
  finally
    B.Free;
  end;
end;

procedure TcxControl.ShowDragImage;
begin
  if GetDragObject <> nil then
    GetDragObject.ShowDragImage;
end;

function TcxControl.CanFocusEx: Boolean;
var
  AParentForm: TCustomForm;
begin
  AParentForm := GetParentForm(Self);
  Result := CanFocus and ((AParentForm = nil) or
    AParentForm.CanFocus and AParentForm.Enabled and AParentForm.Visible);
end;

function TcxControl.AcceptMousePosForClick(X, Y: Integer): Boolean;
begin
  Result := (DragMode = dmManual) or IsMouseInPressedArea(X, Y);
end;

{$IFDEF VCL}

procedure TcxControl.InvalidateRect(const R: TRect; EraseBackground: Boolean);
begin
  if HandleAllocated then
    Windows.InvalidateRect(Handle, {$IFNDEF CLR}@{$ENDIF}R, EraseBackground)
end;

procedure TcxControl.InvalidateRgn(ARegion: TcxRegion; EraseBackground: Boolean);
begin
  if HandleAllocated and (ARegion <> nil) and not ARegion.IsEmpty then
    Windows.InvalidateRgn(Handle, ARegion.Handle, EraseBackground);
end;

procedure TcxControl.InvalidateWithChildren;
begin
  if HandleAllocated then
    RedrawWindow(Handle, nil, 0, RDW_ALLCHILDREN or RDW_INVALIDATE or RDW_NOERASE);
end;

{$ENDIF}

function TcxControl.IsMouseInPressedArea(X, Y: Integer): Boolean;
begin
  Result := IsPointInDragDetectArea(MouseDownPos, X, Y);
end;

procedure TcxControl.PostMouseMove;
begin
  if HandleAllocated then
    PostMouseMove(ScreenToClient(GetMouseCursorPos));
end;

procedure TcxControl.PostMouseMove(AMousePos: TPoint);
begin
  if not HandleAllocated then Exit;
{$IFDEF VCL}
  with AMousePos do
    PostMessage(Handle, WM_MOUSEMOVE, 0, MakeLParam(X, Y));
{$ELSE}
  QApplication_postEvent(Handle, QMouseEvent_create(QEventType_MouseMove, @AMousePos,
    Integer(ButtonState_NoButton), Integer(ButtonState_NoButton)));
{$ENDIF}
end;

procedure TcxControl.ScrollContent(ADirection: TcxDirection);
var
  AScrollPos: Integer;

  function GetScrollBarKind: TScrollBarKind;
  begin
    if ADirection in [dirLeft, dirRight] then
      Result := sbHorizontal
    else
      Result := sbVertical;
  end;

  function GetScrollCode: TScrollCode;
  begin
    if ADirection in [dirLeft, dirUp] then
      Result := scLineUp
    else
      Result := scLineDown;
  end;

  function GetScrollPos: Integer;
  begin
    if GetScrollBarKind = sbHorizontal then
      Result := FHScrollBar.Position
    else
      Result := FVScrollBar.Position;
  end;

begin
  if (ADirection = dirNone) or not NeedsScrollBars then Exit;
  AScrollPos := GetScrollPos;
  Scroll(GetScrollBarKind, GetScrollCode, AScrollPos);
  Update;
end;

procedure TcxControl.ScrollWindow(DX, DY: Integer; const AScrollRect: TRect);
begin
  HideDragImage;
  try
  {$IFDEF CLR}
    ScrollWindowEx(Handle, DX, DY, AScrollRect, nil, 0, nil, SW_ERASE or SW_INVALIDATE);
  {$ELSE}
    ScrollWindowEx(Handle, DX, DY, @AScrollRect, nil, 0, nil, SW_ERASE or SW_INVALIDATE);
  {$ENDIF}
  finally
    ShowDragImage;
  end;
end;

procedure TcxControl.SetScrollBarInfo(AScrollBarKind: TScrollBarKind;
  AMin, AMax, AStep, APage, APos: Integer; AAllowShow, AAllowHide: Boolean);

  function GetScrollBar: TcxControlScrollBar;
  begin
    if AScrollBarKind = sbHorizontal then
      Result := FHScrollBar
    else
      Result := FVScrollBar;
  end;

var
  AScrollBarData: TcxScrollBarData;
begin
  AScrollBarData := GetScrollBar.Data;
  if AScrollBarKind = sbHorizontal then
    AScrollBarData.AllowShow := AAllowShow and (FScrollBars in [ssHorizontal, ssBoth])
  else
    AScrollBarData.AllowShow := AAllowShow and (FScrollBars in [ssVertical, ssBoth]);
  AScrollBarData.AllowHide := AAllowHide;
  if AScrollBarData.AllowShow then
    if (AMax < AMin) or (AMax - AMin + 1 <= APage) or (APos < AMin) then
      if AScrollBarData.AllowHide then
        AScrollBarData.Visible := False
      else
      begin
        AScrollBarData.Enabled := False;
        AScrollBarData.Visible := True;
      end
    else
    begin
    {$IFNDEF VCL}
      if LookAndFeel.NativeStyle then
      begin
        Dec(AMax, APage - 1);
        PageSize := 0;
      end
      else
        PageSize := APage;
    {$ELSE}
      AScrollBarData.PageSize := APage;
    {$ENDIF}
      AScrollBarData.Min := AMin;
      AScrollBarData.Max := AMax;
      AScrollBarData.SmallChange := AStep;
      AScrollBarData.LargeChange := APage;
      AScrollBarData.Position := APos;
      AScrollBarData.Enabled := True;
      AScrollBarData.Visible := True;
    end
  else
    AScrollBarData.Visible := False;
  GetScrollBar.Data := AScrollBarData;
end;

function TcxControl.StartDrag(DragObject: TDragObject): Boolean;
begin
  Result := True;
end;

procedure TcxControl.UpdateWithChildren;
begin
  if HandleAllocated then
    RedrawWindow(Handle, nil, 0, RDW_UPDATENOW or RDW_ALLCHILDREN);
end;

procedure TcxControl.BeginDragAndDrop;
begin
  DragAndDropObject.DoBeginDragAndDrop;
  MouseCapture := True;
  FDragAndDropPrevCursor := Screen.Cursor;
  DragAndDropState := ddsInProcess;
end;

procedure TcxControl.FinishDragAndDrop(Accepted: Boolean);
begin
  if FFinishingDragAndDrop then Exit;
  FFinishingDragAndDrop := True;
  try
    if DragAndDropState = ddsInProcess then
      EndDragAndDrop(Accepted)
    else
      DragAndDropState := ddsNone;
    FreeAndNil(FDragAndDropObject);
  finally
    FFinishingDragAndDrop := False;
  end;
end;

procedure TcxControl.AddFontListener(AListener: IcxFontListener);
begin
  FFontListenerList.Add(AListener);
end;

procedure TcxControl.RemoveFontListener(AListener: IcxFontListener);
begin
  FFontListenerList.Remove(AListener);
end;

procedure TcxControl.LockScrollBars;
begin
  if FScrollBarsLockCount = 0 then
    FScrollBarsUpdateNeeded := False;
  Inc(FScrollBarsLockCount);
end;

procedure TcxControl.UnlockScrollBars;
begin
  if FScrollBarsLockCount > 0 then
  begin
    Dec(FScrollBarsLockCount);
    if (FScrollBarsLockCount = 0) and FScrollBarsUpdateNeeded then
      UpdateScrollBars;
  end;
end;

{ TcxCustomizeListBox }

constructor TcxCustomizeListBox.Create(AOwner: TComponent);
begin
  inherited;
  FDragAndDropItemIndex := -1;
end;

function TcxCustomizeListBox.GetDragAndDropItemObject: TObject;
begin
  Result := Items.Objects[FDragAndDropItemIndex];
end;

function TcxCustomizeListBox.GetItemObject: TObject;
begin
  if ItemIndex = -1 then
    Result := nil
  else
    Result := Items.Objects[ItemIndex];
end;

procedure TcxCustomizeListBox.SetItemObject(Value: TObject);
begin
  if ItemObject <> Value then
  begin
    ItemIndex := Items.IndexOfObject(Value);
    Click;
  end;
end;

{$IFDEF VCL}

procedure TcxCustomizeListBox.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
  FDragAndDropItemIndex := -1;
end;

procedure TcxCustomizeListBox.WMMouseMove(var Message: TWMMouseMove);
begin
  if FDragAndDropItemIndex = -1 then
    inherited
  else
    with Message do
      MouseMove(KeysToShiftState(Keys), XPos, YPos);
end;

procedure TcxCustomizeListBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params.WindowClass do
    style := style or CS_HREDRAW;
end;

{$ENDIF}

procedure TcxCustomizeListBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if (Button = mbLeft) and (ItemAtPos(Point(X, Y), True) <> -1) and
    (ItemObject <> nil) then
  begin
    FDragAndDropItemIndex := ItemIndex;
    FMouseDownPos := Point(X, Y);
  end;
end;

procedure TcxCustomizeListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (FDragAndDropItemIndex <> -1) and
    (not IsPointInDragDetectArea(FMouseDownPos, X, Y) or
     (ItemAtPos(Point(X, Y), True) <> FDragAndDropItemIndex)) then
  begin
    ItemIndex := FDragAndDropItemIndex;
    BeginDragAndDrop;
    FDragAndDropItemIndex := -1;
  end;
end;

procedure TcxCustomizeListBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  FDragAndDropItemIndex := -1;
end;

{$IFNDEF VCL}

procedure TcxCustomizeListBox.Resize;
begin
  inherited;
  Invalidate;
end;

{$ENDIF}

procedure TcxCustomizeListBox.BeginDragAndDrop;
var
  I: Integer;
begin
  if MultiSelect then
    with Items do
    begin
      BeginUpdate;
      try
        for I := 0 to Count - 1 do
          Selected[I] := I = ItemIndex;
      finally
        EndUpdate;
      end;
    end;
end;

{ TcxMessageWindow }

constructor TcxMessageWindow.Create;
begin
  inherited Create;
  FHandle := AllocateHWnd(WndProc);
end;

destructor TcxMessageWindow.Destroy;
begin
  DeallocateHWnd(FHandle);
  inherited Destroy;
end;

procedure TcxMessageWindow.WndProc(var Message: TMessage);
begin
  Message.Result := DefWindowProc(Handle, Message.Msg, Message.wParam, Message.lParam);
end;

{ TcxPopupWindow }

constructor TcxPopupWindow.Create;
begin
  CreateNew(nil);
  inherited BorderStyle := {$IFDEF VCL}bsNone{$ELSE}fbsNone{$ENDIF};
{$IFDEF VCL}
  DefaultMonitor := dmDesktop;
{$ENDIF}
  FormStyle := fsStayOnTop;
  FAdjustable := True;
  FAlignVert := pavBottom;
  FCanvas := TcxCanvas.Create(inherited Canvas);
  FDirection := pdVertical;
  FFrameColor := clWindowText;
end;

destructor TcxPopupWindow.Destroy;
begin
  FCanvas.Free;
  inherited;
end;

function TcxPopupWindow.GetNCHeight: Integer;
begin
  Result := BorderWidths[bTop] + BorderWidths[bBottom];
end;

function TcxPopupWindow.GetNCWidth: Integer;
begin
  Result := BorderWidths[bLeft] + BorderWidths[bRight];
end;

procedure TcxPopupWindow.SetBorderSpace(Value: Integer);
begin
  RestoreControlsBounds;
  FBorderSpace := Value;
end;

procedure TcxPopupWindow.SetBorderStyle(Value: TcxPopupBorderStyle);
begin
  RestoreControlsBounds;
  FBorderStyle := Value;
end;

{$IFDEF VCL}

procedure TcxPopupWindow.WMActivate(var Message: TWMActivate);
begin
  inherited;
  if Message.Active <> WA_INACTIVE then
  begin
    FPrevActiveWindow := Message.ActiveWindow;
    SendMessage(FPrevActiveWindow, WM_NCACTIVATE, WPARAM(True), 0);
  end;
end;

procedure TcxPopupWindow.WMActivateApp(var Message: TWMActivateApp);
begin
  inherited;
  if not Message.Active then
  begin
    SendMessage(FPrevActiveWindow, WM_NCACTIVATE, WPARAM(False), 0);
    CloseUp;
  end;
end;

procedure TcxPopupWindow.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
  VisibleChanged;
end;

{$ELSE}

procedure TcxPopupWindow.AppDeactivationTimerHandler(Sender: TObject);
begin
  if FindControl(QApplication_focusWidget(Application.Handle)) = nil then
    CloseUp;
end;

{$ENDIF}

procedure TcxPopupWindow.Deactivate;
begin
  inherited;
  CloseUp;
end;

procedure TcxPopupWindow.Paint;
begin
  inherited;
  DrawFrame;
end;

{$IFDEF VCL}

procedure TcxPopupWindow.VisibleChanged;
begin
end;

{$ELSE}

function TcxPopupWindow.EventFilter(Sender: QObjectH; Event: QEventH): Boolean;
begin
  Result := inherited EventFilter(Sender, Event);
  {case QEvent_type(Event) of
    QEventType_WindowDeactivate:
      begin
        CloseUp;
      end;
  end;}
end;

{$ENDIF}

function TcxPopupWindow.CalculatePosition: TPoint;
var
  AAlignHorz: TcxPopupAlignHorz;
  AAlignVert: TcxPopupAlignVert;
  AOwnerScreenBounds: TRect;
  AOrigin: TPoint;

  procedure CalculateCommonPosition;
  begin
    with AOwnerScreenBounds do
    begin
      if AAlignHorz = pahCenter then
      begin
        Result.X := (Left + Right - Width) div 2;
        AOrigin.X := Result.X;
      end;
      if AAlignVert = pavCenter then
      begin
        Result.Y := (Top + Bottom - Height) div 2;
        AOrigin.Y := Result.Y;
      end;
    end;
  end;

  procedure CalculateHorizontalPosition;
  begin
    with AOwnerScreenBounds do
    begin
      case AAlignHorz of
        pahLeft:
          begin
            Result.X := Left - Width;
            AOrigin.X := Left;
          end;
        pahRight:
          begin
            Result.X := Right;
            AOrigin.X := Right;
          end;
      end;
      case AAlignVert of
        pavTop:
          begin
            Result.Y := Top;
            AOrigin.Y := Top;
          end;
        pavBottom:
          begin
            Result.Y := Bottom - Height;
            AOrigin.Y := Bottom;
          end;
      end;
    end;
  end;

  procedure CalculateVerticalPosition;
  begin
    with Result, AOwnerScreenBounds do
    begin
      case AAlignHorz of
        pahLeft:
          begin
            X := Left;
            AOrigin.X := Left;
          end;
        pahRight:
          begin
            X := Right - Width;
            AOrigin.X := Right;
          end;
      end;
      case AAlignVert of
        pavTop:
          begin
            Y := Top - Height;
            AOrigin.Y := Top;
          end;
        pavBottom:
          begin
            Y := Bottom;
            AOrigin.Y := Bottom;
          end;
      end;
    end;
  end;

  procedure CheckPosition;
  var
    ADesktopWorkArea: TRect;

    procedure CheckCommonPosition;
    begin
      with Result, ADesktopWorkArea do
      begin
        if (FDirection = pdVertical) or (AAlignHorz = pahCenter) then
        begin
          if X + Width > Right then X := Right - Width;
          if X < Left then X := Left;
        end;
        if (FDirection = pdHorizontal) or (AAlignVert = pavCenter) then
        begin
          if Y + Height > Bottom then Y := Bottom - Height;
          if Y < Top then Y := Top;
        end;
      end;
    end;

    procedure CheckHorizontalPosition;

      function MoreSpaceOnLeft: Boolean;
      begin
        with ADesktopWorkArea do
          Result := AOwnerScreenBounds.Left - Left > Right - AOwnerScreenBounds.Right;
      end;

    begin
      with Result, ADesktopWorkArea do
        case AAlignHorz of
          pahLeft:
            if (X < Left) and not MoreSpaceOnLeft then
              AAlignHorz := pahRight;
          pahRight:
            if (X + Width > Right) and MoreSpaceOnLeft then
              AAlignHorz := pahLeft;
        end;
      CalculateHorizontalPosition;
    end;

    procedure CheckVerticalPosition;

      function MoreSpaceOnTop: Boolean;
      begin
        with ADesktopWorkArea do
          Result := AOwnerScreenBounds.Top - Top > Bottom - AOwnerScreenBounds.Bottom;
      end;

    begin
      with Result, ADesktopWorkArea do
        case AAlignVert of
          pavTop:
            if (Y < Top) and not MoreSpaceOnTop then
              AAlignVert := pavBottom;
          pavBottom:
            if (Y + Height > Bottom) and MoreSpaceOnTop then
              AAlignVert := pavTop;
        end;
      CalculateVerticalPosition;
    end;

  begin
    ADesktopWorkArea := GetDesktopWorkArea(AOrigin);
    if FDirection = pdHorizontal then
      CheckHorizontalPosition
    else
      CheckVerticalPosition;
    CheckCommonPosition;
  end;

begin
  AAlignHorz := FAlignHorz;
  AAlignVert := FAlignVert;
  AOwnerScreenBounds := OwnerScreenBounds;
  CalculateCommonPosition;
  if FDirection = pdHorizontal then
    CalculateHorizontalPosition
  else
    CalculateVerticalPosition;
  CheckPosition;
end;

procedure TcxPopupWindow.CalculateSize;
var
  AClientWidth, AClientHeight, I: Integer;
  ABounds: TRect;

  procedure CheckClientSize;
  begin
    with ABounds do
    begin
      if Right > AClientWidth then AClientWidth := Right;
      if Bottom > AClientHeight then AClientHeight := Bottom;
    end;
  end;

begin
  if not FAdjustable then Exit;

  AClientWidth := 0;
  AClientHeight := 0;
  for I := 0 to ControlCount - 1 do
  begin
    ABounds := Controls[I].BoundsRect;
    CheckClientSize;
    OffsetRect(ABounds, BorderWidths[bLeft], BorderWidths[bTop]);
    Controls[I].BoundsRect := ABounds;
  end;

  if (AClientWidth <> 0) or (ControlCount <> 0) then
    Width := BorderWidths[bLeft] + AClientWidth + BorderWidths[bRight];
  if (AClientHeight <> 0) or (ControlCount <> 0) then
    Height := BorderWidths[bTop] + AClientHeight + BorderWidths[bBottom];
end;

function TcxPopupWindow.GetBorderWidth(ABorder: TcxBorder): Integer;
begin
  Result := FBorderSpace + FrameWidths[ABorder];
end;

function TcxPopupWindow.GetClientBounds: TRect;
var
  ABorder: TcxBorder;
begin
  Result := ClientRect;
  for ABorder := Low(ABorder) to High(ABorder) do
    case ABorder of
      bLeft:
        Inc(Result.Left, BorderWidths[ABorder]);
      bTop:
        Inc(Result.Top, BorderWidths[ABorder]);
      bRight:
        Dec(Result.Right, BorderWidths[ABorder]);
      bBottom:
        Dec(Result.Bottom, BorderWidths[ABorder]);
    end;
end;

function TcxPopupWindow.GetFrameWidth(ABorder: TcxBorder): Integer;
begin
  case FBorderStyle of
    pbsUltraFlat:
      Result := 1;
    pbsFlat:
      Result := 1;
    pbs3D:
      Result := 2;
  else
    Result := 0;
  end;
end;

function TcxPopupWindow.GetOwnerScreenBounds: TRect;
begin
  Result := OwnerBounds;
  with Result do
  begin
    TopLeft := OwnerParent.ClientToScreen(TopLeft);
    BottomRight := OwnerParent.ClientToScreen(BottomRight);
  end;
end;

procedure TcxPopupWindow.InitPopup;
begin
  if FOwnerParent <> nil then
  {$IFNDEF CLR}
    Font := TControlAccess(FOwnerParent).Font;
  {$ELSE}
    Font := FOwnerParent.Font;
  {$ENDIF}
end;

procedure TcxPopupWindow.RestoreControlsBounds;
var
  I: Integer;
  ABounds: TRect;
begin
  for I := 0 to ControlCount - 1 do
  begin
    ABounds := Controls[I].BoundsRect;
    OffsetRect(ABounds, -BorderWidths[bLeft], -BorderWidths[bTop]);
    Controls[I].BoundsRect := ABounds;
  end;
end;

procedure TcxPopupWindow.DrawFrame;
var
  R: TRect;

  procedure DrawUltraFlatBorder;
  begin
    Canvas.FrameRect(R, FrameColor);
  end;

  procedure DrawFlatBorder;
  begin
    Canvas.DrawEdge(R, False, False);
  end;

  procedure Draw3DBorder;
  begin
    Canvas.DrawEdge(R, False, True);
    InflateRect(R, -1, -1);
    Canvas.DrawEdge(R, False, False);
  end;

begin
  R := Bounds(0, 0, Width, Height);
  case FBorderStyle of
    pbsUltraFlat:
      DrawUltraFlatBorder;
    pbsFlat:
      DrawFlatBorder;
    pbs3D:
      Draw3DBorder;
  end;
end;

procedure TcxPopupWindow.CloseUp;
begin
{$IFNDEF VCL}
  FreeAndNil(FAppDeactivationTimer);
{$ENDIF}
  Hide;
end;

procedure TcxPopupWindow.Popup;

{$IFNDEF VCL}

  procedure StartAppDeactivationTimer;
  begin
    FAppDeactivationTimer := TTimer.Create(nil);
    with FAppDeactivationTimer do
    begin
      Interval := 50;
      OnTimer := AppDeactivationTimerHandler;
    end;
  end;

  procedure FocusFirstControl;
  var
    AControl: TWinControl;
  begin
    AControl := FindNextControl(nil, True, True, True);
    if AControl <> nil then AControl.SetFocus;
  end;

{$ENDIF}
begin
  InitPopup;
  CalculateSize;
  Left := CalculatePosition.X;
  Top := CalculatePosition.Y;
{$IFNDEF VCL}
  StartAppDeactivationTimer;
{$ENDIF}
  Show;
{$IFNDEF VCL}
  FocusFirstControl;
{$ENDIF}
end;

{ TcxDragImage }

constructor TcxDragImage.Create;
begin
  inherited;
  SetBounds(0, 0, 0, 0);
  FImage := TBitmap.Create;
  FImageCanvas := TcxCanvas.Create(Image.Canvas);
{$IFDEF DELPHI6}
  AlphaBlend := True;
  AlphaBlendValue := cxDragAndDropWindowTransparency;
{$ENDIF}
end;

destructor TcxDragImage.Destroy;
begin
  FImageCanvas.Free;
  FImage.Free;
  inherited;
end;

function TcxDragImage.GetAlphaBlended: Boolean;
begin
{$IFDEF DELPHI6}
  Result := AlphaBlend and
  {$IFNDEF CLR}
    Assigned(SetLayeredWindowAttributes);
  {$ELSE}
    SupportsLayeredWindowAttributes;
  {$ENDIF}
{$ELSE}
  Result := False;
{$ENDIF}
end;

function TcxDragImage.GetVisible: Boolean;
begin
  Result := HandleAllocated and IsWindowVisible(Handle);
end;

function TcxDragImage.GetWindowCanvas: TcxCanvas;
begin
  Result := inherited Canvas;
end;

procedure TcxDragImage.SetVisible(Value: Boolean);
begin
  if Visible <> Value then
    if Value then
      Show
    else
      Hide;
end;

procedure TcxDragImage.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TcxDragImage.WMNCHitTest(var Message: TWMNCHitTest);
begin
  Message.Result := HTTRANSPARENT;
end;

procedure TcxDragImage.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params.WindowClass do
    Style := Style or CS_SAVEBITS;
end;

procedure TcxDragImage.Paint;
begin
  inherited;
  WindowCanvas.Draw(0, 0, Image);
end;

procedure TcxDragImage.Init(const ASourceBounds: TRect; const ASourcePoint: TPoint);

  function CalculatePositionOffset: TPoint;
  begin
    Result.X := ASourcePoint.X - ASourceBounds.Left;
    Result.Y := ASourcePoint.Y - ASourceBounds.Top;
  end;

begin
  Width := ASourceBounds.Right - ASourceBounds.Left;
  Height := ASourceBounds.Bottom - ASourceBounds.Top;
  PositionOffset := CalculatePositionOffset;
end;

procedure TcxDragImage.MoveTo(const APosition: TPoint);
begin
  HandleNeeded;  // so that later CreateHandle won't reset Left and Top
  SetBounds(APosition.X - PositionOffset.X, APosition.Y - PositionOffset.Y, Width, Height);
end;

procedure TcxDragImage.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  if Image <> nil then
  begin
    Image.Width := Width;
    Image.Height := Height;
  end;
end;

procedure TcxDragImage.Show;
begin
  ShowWindow(Handle, SW_SHOWNA);
  Update;
end;

procedure TcxDragImage.Hide;
begin
  if HandleAllocated then
    ShowWindow(Handle, SW_HIDE);
end;

{ TcxDragDropArrow }

constructor TcxDragAndDropArrow.Create(ATransparent: Boolean);
begin
  inherited Create;
  FTransparent := ATransparent;
{$IFDEF DELPHI6}
  AlphaBlend := False;
  if Transparent then
  begin
    TransparentColorValue := ImageBackColor;
    TransparentColor := True;
  end;
{$ENDIF}
end;

function TcxDragAndDropArrow.GetTransparent: Boolean;
begin
{$IFDEF DELPHI6}
  Result := FTransparent and
  {$IFNDEF CLR}
    Assigned(SetLayeredWindowAttributes);
  {$ELSE}
    SupportsLayeredWindowAttributes;
  {$ENDIF}  
{$ELSE}
  Result := False;
{$ENDIF}
end;

function TcxDragAndDropArrow.GetImageBackColor: TColor;
begin
  Result := clFuchsia;
end;

procedure TcxDragAndDropArrow.Init(AOwner: TControl; const AAreaBounds, AClientRect: TRect;
  APlace: TcxArrowPlace);

  procedure DrawArrow;
  begin
    Canvas.Brush.Color := ImageBackColor;
    Canvas.FillRect(ClientRect);
    DrawDragAndDropArrow(Canvas, ClientRect, APlace);
  end;

  procedure SetArrowRegion;
  var
    APoints: TPointArray;
    ARegion: HRGN;
  begin
    GetDragAndDropArrowPoints(ClientRect, APlace, APoints, True);
    ARegion := CreatePolygonRgn(APoints[0], Length(APoints), WINDING);
    SetWindowRgn(Handle, ARegion, True);
  end;

var
  R: TRect;
begin
  R := GetDragAndDropArrowBounds(AAreaBounds, AClientRect, APlace);
  if AOwner <> nil then
  begin
    R.TopLeft := AOwner.ClientToScreen(R.TopLeft);
    R.BottomRight := AOwner.ClientToScreen(R.BottomRight);
  end;
  HandleNeeded;  // so that later CreateHandle won't reset Left and Top
  BoundsRect := R;
  DrawArrow;
  if not Transparent then
    SetArrowRegion;
end;

{ TcxTimer }

function ActiveTimerList: TList;
begin
  if FActiveTimerList = nil then
    FActiveTimerList := TList.Create;
  Result := FActiveTimerList;
end;

function cxTimerWindow: TcxTimerWindow;
begin
  if FcxTimerWindow = nil then
    FcxTimerWindow := TcxTimerWindow.Create;
  Result := FcxTimerWindow;
end;

procedure TcxTimerWindow.WndProc(var Message: TMessage);

  function cxTimer(APointer: Integer): TcxTimer;
  begin
  {$IFNDEF CLR}
    Result := TcxTimer(APointer);
  {$ELSE}
    Result := TcxTimer(GCHandle(IntPtr(APointer)).Target);
  {$ENDIF}
  end;

begin
  if Message.Msg = WM_TIMER then
  begin
    if ActiveTimerList.IndexOf(Pointer(Message.WParam)) <> -1 then
      cxTimer(Message.WParam).TimeOut;
  end
  else
    inherited WndProc(Message);
end;

constructor TcxTimer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEnabled := True;
  FInterval := 1000;
{$IFNDEF CLR}
  FEventID := Cardinal(Self);
{$ELSE}
  FEventID := Cardinal(IntPtr(GCHandle.Alloc(Self)));
{$ENDIF}
end;

destructor TcxTimer.Destroy;
begin
  KillTimer;
{$IFDEF CLR}
  GCHandle(IntPtr(FEventID)).Free;
  System.GC.SuppressFinalize(Self);
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF CLR}
procedure TcxTimer.Finalize;
begin
  KillTimer;
  inherited;
end;
{$ENDIF}

procedure TcxTimer.TimeOut;
begin
  if Assigned(FOnTimer) then
    FOnTimer(Self);
end;

function TcxTimer.CanSetTimer: Boolean;
begin
  Result := FEnabled and not TimerOn and Assigned(FOnTimer);
end;

procedure TcxTimer.KillTimer;
begin
  if TimerOn then
  begin
    Windows.KillTimer(cxTimerWindow.FHandle, FEventID);
    TimerOn := False;
  end;
end;

procedure TcxTimer.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    UpdateTimer;
  end;
end;

procedure TcxTimer.SetInterval(Value: Cardinal);
begin
  if (FInterval <> Value) and (Value > 0) then
  begin
    FInterval := Value;
    UpdateTimer;
  end;
end;

procedure TcxTimer.SetOnTimer(Value: TNotifyEvent);
begin
  FOnTimer := Value;
  UpdateTimer;
end;

procedure TcxTimer.SetTimer;
begin
  if CanSetTimer then
    TimerOn := Windows.SetTimer(cxTimerWindow.FHandle, FEventID, FInterval, nil) <> 0;
end;

procedure TcxTimer.SetTimerOn(Value: Boolean);
begin
  if FTimerOn <> Value then
  begin
    if Value then
      ActiveTimerList.Add(Pointer(FEventID))
    else
      ActiveTimerList.Remove(Pointer(FEventID));
    FTimerOn := Value;
  end;
end;

procedure TcxTimer.UpdateTimer;
begin
  KillTimer;
  SetTimer;
end;

{$IFDEF CLR}
{ TcxControlAccess }

class procedure TcxControlAccess._DragAndDrop(AInstance: TcxControl;
  const P: TPoint; var Accepted: Boolean);
begin
  AInstance.DragAndDrop(P, Accepted);
end;

class procedure TcxControlAccess._FocusChanged(AInstance: TcxControl);
begin
  AInstance.FocusChanged;
end;

class function TcxControlAccess._GetHScrollBarBounds(
  AInstance: TcxControl): TRect;
begin
  Result := AInstance.GetHScrollBarBounds;
end;

class procedure TcxControlAccess._Modified(AInstance: TcxControl);
begin
  AInstance.Modified;
end;
{$ENDIF}

procedure InitPlatformInfo;
begin
  IsWin95X := (Win32Platform = VER_PLATFORM_WIN32_WINDOWS) or
    (Win32Platform = VER_PLATFORM_WIN32s);
  IsWin2KOrXP := (Win32Platform = VER_PLATFORM_WIN32_NT) and
    (Win32MajorVersion >= 5);
  IsWinXP := (Win32Platform = VER_PLATFORM_WIN32_NT) and
    (Win32MajorVersion >= 5) and (Win32MinorVersion > 0);
  IsWinNT := (Win32Platform = VER_PLATFORM_WIN32_NT) and
    (Win32MajorVersion >= 4);
end;

initialization
{$IFDEF VCL}
  InitPlatformInfo;
  Screen.Cursors[crDragCopy] := LoadCursor(HInstance, 'CX_DRAGCOPYCURSOR');
  Screen.Cursors[crFullScroll] := LoadCursor(HInstance, 'CX_FULLSCROLLCURSOR');
  Screen.Cursors[crHorScroll] := LoadCursor(HInstance, 'CX_HORSCROLLCURSOR');
  Screen.Cursors[crVerScroll] := LoadCursor(HInstance, 'CX_VERSCROLLCURSOR');
  Screen.Cursors[crUpScroll] := LoadCursor(HInstance, 'CX_UPSCROLLCURSOR');
  Screen.Cursors[crRightScroll] := LoadCursor(HInstance, 'CX_RIGHTSCROLLCURSOR');
  Screen.Cursors[crDownScroll] := LoadCursor(HInstance, 'CX_DOWNSCROLLCURSOR');
  Screen.Cursors[crLeftScroll] := LoadCursor(HInstance, 'CX_LEFTSCROLLCURSOR');
  Screen.Cursors[crcxRemove] := LoadCursor(HInstance, 'CX_REMOVECURSOR');
  Screen.Cursors[crcxVertSize] := LoadCursor(HInstance, 'CX_VERTSIZECURSOR');
  Screen.Cursors[crcxHorzSize] := LoadCursor(HInstance, 'CX_HORZSIZECURSOR');
  Screen.Cursors[crcxDragMulti] := LoadCursor(HInstance, 'CX_MULTIDRAGCURSOR');
  Screen.Cursors[crcxNoDrop] := LoadCursor(HInstance, 'CX_NODROPCURSOR');
  Screen.Cursors[crcxDrag] := LoadCursor(HInstance, 'CX_DRAGCURSOR');
  Screen.Cursors[crcxHandPoint] := LoadCursor(0{HInstance}, IDC_HAND{'CX_HANDPOINTCURSOR'});
  Screen.Cursors[crcxColorPicker] := LoadCursor(HInstance, 'CX_COLORPICKERCURSOR');
  FUser32DLL := LoadLibrary('USER32');
{$ENDIF}
{$IFDEF DELPHI6}
  //StartClassGroup(TControl);
  GroupDescendentsWith(TcxControlChildComponent, TControl);
{$ENDIF}
{$IFNDEF DELPHI7}
  InitSetLayeredWindowAttributes;
{$ENDIF}

finalization
  if FMouseTrackingTimerList <> nil then
  begin
    if FMouseTrackingTimerList.Count <> 0 then
      raise Exception.Create('MouseTrackingTimerList.Count <> 0');
    FreeAndNil(FMouseTrackingTimerList);
    FMouseTrackingTimerListIsFinalized := True;
  end;
{$IFDEF VCL}
  if FUser32DLL > 32 then FreeLibrary(FUser32DLL);
{$ENDIF}

{$IFDEF VCL}
  {$IFDEF USETCXSCROLLBAR}
    FreeAndNil(FSettingsController);
  {$ENDIF}
{$ENDIF}
  FreeAndNil(FcxTimerWindow);
  FreeAndNil(FActiveTimerList);
  FreeAndNil(FcxMessageWindow);

end.
