unit LMDDckSite;
{$I LmdCmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
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

LMDDckSite unit (YB)
--------------------
TLMDDockSite and TLMDDockManager components unit.

Changes
-------
Release 4.0 (January 2009)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Variants, Windows, Graphics, Messages, Controls, SysUtils, Consts,
  Forms, Menus, RTLConsts, ExtCtrls, StdCtrls, ImgList, GraphUtil, Themes,
  {$IFDEF LMDCOMP16}Styles,{$ENDIF} intfLMDBase, LMDUnicode, LMDTypes, LMDXML,
  LMDDckClass, LMDDckCst, LMDDckStyles, LMDDckStyleElems;

{$DEFINE LMD_DCK_UPDATE} // For debug purposes. Before use, check
                         // that all Update calls are inside these 
                         // IFDEFs.
const
  alDocTop    = TAlign(Ord(alCustom) + 1);
  alDocBottom = TAlign(Ord(alCustom) + 2);
  alDocLeft   = TAlign(Ord(alCustom) + 3);
  alDocRight  = TAlign(Ord(alCustom) + 4);

type
  TAlignEx          = alNone..alDocRight;
  TLMDDockZone      = class;
  TLMDDockZoneTree  = class;
  TLMDDockSite      = class;
  TLMDDockPanel     = class;
  TLMDDockManager   = class;
  ELMDDockManager   = class(Exception);

  {$HPPEMIT 'struct TLMDDockPanelBtn;'}
  {$HPPEMIT 'struct TAutoHideTab;'}

  { ***************************** TLMDDragObject ***************************** }

  TLMDFloatingForm = class;

  TLMDDragObject = class(TDragDockObjectEx)
  private
    FDockingRect: TWinControl;
    FAccepted:    Boolean;
    FAcceptedExt: Boolean;
    FInited:      Boolean;
    FXOffset:     Integer;
    FYOffset:     Integer;
    FRWidth:      Integer;
    FRHeight:     Integer;
    FTabInRect:   Boolean;
    FDragForm:    TLMDFloatingForm;
    FDragContent: Boolean;
    FAnimateRect: Boolean;
    FBorderColor: TColor;
    FBackColor:   TColor;

    procedure Init;
    procedure UpdateDragFormPos(const P: TPoint);
    function  ControlSite: TLMDDockSite;
  protected
    procedure WndProc(var Msg: TMessage); override;
    function  GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor; override;
    procedure AdjustDockRect(ARect: TRect); override;
    procedure DrawDragDockImage; override;
    procedure EraseDragDockImage; override;
    procedure EndDrag(Target: TObject; X, Y: Integer); override;
  public
    constructor Create(AControl: TControl); override;
    destructor Destroy; override;

    property TabInRect: Boolean read FTabInRect write FTabInRect;
    property DragContent: Boolean read FDragContent write FDragContent;
    property AnimateRect: Boolean read FAnimateRect write FAnimateRect;
    property BackColor: TColor read FBackColor write FBackColor;
    property BorderColor: TColor read FBorderColor write FBorderColor;
  end;

  { ***************************** TLMDFloatingForm *************************** }

  TLMDFloatingForm = class(TCustomForm)
  private
    {$IFDEF LMDCOMP16}
    type
      TFormStyleHack = class(TMouseTrackControlStyleHook) // VCL bug: QC-105372!
      protected
        FCaptionRect:      TRect;
        FChangeSizeCalled: Boolean;
      end;

      TStyleHook = class(TFormStyleHook)
      private
        procedure WMNCHitTest(var Message: TWMNCHitTest);
                              message WM_NCHITTEST;
        procedure WMWindowPosChanging(var Message: TWMWindowPosChanging);
                                      message WM_WINDOWPOSCHANGING;
      end;

    var
    {$ENDIF}
      FState:       set of (ffsDragging, ffsAccepted, ffsPopupPending,
                            ffsActivatePending, ffsUpdatingBorder);
      FSite:        TLMDDockSite;
      FKind:        TLMDFloatFormKind;
      FSinglePanel: TLMDDockPanel;
      FHeader:      TRect;
      FButtons:     TLMDPanelBtnKinds; // Valid for any header kind.
      FButtonsData: TLMDButtonsData;
      FGlows:       array[TAlign] of TObject; // of TGlow.
      FContent:     TRect;
      FRgnSet:      Boolean;
      FDragStart:   TPoint;

    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCLButtonDown(var Message: TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
    procedure WMNCRButtonDown(var Message: TWMNCRButtonDown); message WM_NCRBUTTONDOWN;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMNCLButtonDblClk(var Message: TWMNCLButtonDblClk); message WM_NCLBUTTONDBLCLK;
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMNCMouseMove(var Message: TWMNCMouseMove); message WM_NCMOUSEMOVE;
    procedure WMTimer(var Message: TMessage); message WM_TIMER;
    function  GetIsEmpty: Boolean;
    function  GetIsDragging: Boolean;
    function  GetIsAccepted: Boolean;
    function  GetIsTopmost: Boolean;
    procedure SiteNotification;
    function  HasVisiblePanels: Boolean;
    function  FindButtonAtPoint(const P: TPoint): TLMDPanelBtnKind;
    function  SysHitTest(const P: TPoint): LRESULT;
    function  ChooseManager: TLMDDockManager;
    function  StyleElems: TLMDDockElems;
    procedure InitGlows;
    procedure FreeGlows;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure DoAddDockClient(Client: TControl; const ARect: TRect); override;
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure DoClose(var Action: TCloseAction); override;
    procedure DoShow; override;
    procedure UpdateBorder;
    procedure UpdateTracking(AMouseDown, AMouseUp: Boolean);
    procedure CancelTracking;
    procedure AdjustWindowRgn;
    procedure UpdateGlows(AForceRedraw: Boolean = False);
    procedure VisibleChanging; override;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateEx(AOwner: TComponent; AManager: TLMDDockManager);
    destructor  Destroy; override;

    function  CloseQuery: Boolean; override;
    procedure ActivateOnNextShow;
    procedure SetDraggingMode(const ADragging, AAccepted: Boolean);
    property  Site: TLMDDockSite read FSite;
    property  IsEmpty: Boolean read GetIsEmpty;
    property  IsDragging: Boolean read GetIsDragging;
    property  IsAccepted: Boolean read GetIsAccepted; // Only while dragging.
    property  IsTopmost: Boolean read GetIsTopmost;
  end;

  { ****************************** TLMDDockPanel ***************************** }

  TLMDDockPanelHdrImage   = (hiDefault, hiShow, hiHide);
  TLMDDockClientKind      = (dkTool, dkDocument);
  TLMDDockPanelState      = set of (psDesignDragPending, psDesignDrag,
                                    psBeginAutoDragCalled, psUpdatingColors,
                                    psUpdatingParentFont);
  TLMDockPanelCloseAction = caNone..caFree;
  TLMDockPanelCloseQuery  = procedure(Sender: TObject;
                                      var CanClose: Boolean) of object;
  TLMDockPanelClose       = procedure(Sender: Tobject; var CloseAction:
                                      TLMDockPanelCloseAction) of object;

  TLMDDockPanelClick      = procedure(Sender: TObject; var AHandled: Boolean)
                            of object;

  TLMDDockPanel = class(TCustomControl, ILMDComponent)
  private
    FAbout:            TLMDAboutVar;
    FState:            TLMDDockPanelState;
    FLoadingSite:      TLMDDockSite;
    FSite:             TLMDDockSite;
    FZone:             TLMDDockZone;
    FClientControl:    TControl;
    FLastCheckActive:  Boolean;
    FDsgDragStart:     TPoint;
    FDsgDragRect:      TWinControl;
    FOnSiteShowing:    Boolean;
    FSpltrSide:        TAlign;
    FSpltrArea:        TRect;
    FHaveHeader:       Boolean;
    FHeaderArea:       TRect;
    FButtonsData:      TLMDButtonsData;
    FContent:          TRect;
    FImages:           TCustomImageList;
    FImageChangeLink:  TChangeLink;
    FImageIndex:       TImageIndex;
    FShowHeader:       Boolean;
    FBorderStyle:      TBorderStyle;
    FButtons:          TLMDPanelBtnKinds;
    FShowHeaderImage:  TLMDDockPanelHdrImage;
    FHeaderMenu:       TPopupMenu;
    FOnHeaderPopup:    TContextPopupEvent;
    FPanelVisible:     Boolean;
    FOnShow:           TNotifyEvent;
    FOnHide:           TNotifyEvent;
    FDefaultColor:     Boolean;
    FDefaultFontColor: Boolean;
    FClientKind:       TLMDDockClientKind;
    FOnClose:          TLMDockPanelClose;
    FOnCloseQuery:     TLMDockPanelCloseQuery;
    FOnHeaderDblClick: TLMDDockPanelClick;

    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure WMTimer(var Message: TMessage); message WM_TIMER;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMFloat(var Message: TCMFloat); message CM_FLOAT;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMParentColorChanged(var Message: TMessage); message CM_PARENTCOLORCHANGED;
    procedure CMParentFontChanged(var Message: TMessage); message CM_PARENTFONTCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMRelease(var Message: TMessage); message CM_RELEASE;
    procedure InternalSetLoadingSite(const Value: TLMDDockSite);
    procedure InternalSetToSite(const Value: TLMDDockSite; ADockTask: TObject);
    procedure InternalResetSite;
    function  GetDockClient: TControl;
    procedure SetOnSiteShowing(const Value: Boolean);
    procedure UpdateVisible;
    function  FindButtonAtPoint(const P: TPoint): TLMDPanelBtnKind;
    procedure UpdateTracking(AMouseDown, AMouseUp: Boolean);
    procedure CancelTracking;
    procedure ImagesChange(Sender: TObject);
    function  GetActive: Boolean;
    procedure SetImages(const Value: TCustomImageList);
    procedure SetImageIndex(const Value: TImageIndex);
    procedure SetPanelVisible(const Value: Boolean);
    procedure SetShowHeader(const Value: Boolean);
    procedure SetBorderStyle(const Value: TBorderStyle);
    procedure SetButtons(const Value: TLMDPanelBtnKinds);
    procedure SetShowHeaderImage(const Value: TLMDDockPanelHdrImage);
    procedure SetHeaderMenu(const Value: TPopupMenu);
    procedure SetClientKind(const Value: TLMDDockClientKind);
    function  IsColorStored: Boolean;
    procedure SetDefaultColor(const Value: Boolean);
    procedure SetDefaultFontColor(const Value: Boolean);
    procedure UpdateColors;
    function  GetDefFontColor: TColor;
    function  GetVisible: Boolean;
    procedure UpdateMouseCapture;
    procedure AdjustDockSizes;
    function  CanHeaderPopup: Boolean;
    procedure HeaderPopup(const AMousePos: TPoint);
    procedure ActiveChanged;
    procedure InvalidateBorder(FOldContent: TRect);
    procedure UpdateHook(AHook: BOolean);
    function  StyleElems: TLMDDockElems;
    procedure InternalClose;
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  protected
    procedure ReadState(Reader: TReader); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateHandle; override;
    function  DesignWndProc(var Message: TMessage): Boolean; override;
    procedure SetParent(AParent: TWinControl); override;
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure AlignControls(AControl: TControl; var ARect: TRect); override;
    procedure AdjustSize; override;
    procedure Resize; override;
    procedure Paint; override;
    procedure WndProc(var Message: TMessage); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
                      X, Y: Integer); override;
    procedure Click; override;
    procedure DblClick; override;
    procedure BeginAutoDrag; override;
    function  GetFloating: Boolean; override;
    procedure DoStartDock(var DragObject: TDragObject); override;
    procedure ShowControl(AControl: TControl); override;
    procedure ConstrainedResize(var MinWidth, MinHeight, MaxWidth,
                                MaxHeight: Integer); override;
    function  DoHeaderPopup(const AMousePos: TPoint): Boolean; virtual;
    function  DoHeaderDblClick: Boolean; virtual;
    procedure DoActiveChanged; virtual;
    function  DoClose: TLMDockPanelCloseAction; virtual;
    property  OnSiteShowing: Boolean read FOnSiteShowing write SetOnSiteShowing;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Release;
    procedure UpdateDesignDrag(ASite: TLMDDockSite; AMouseDown, AMouseUp,
                               AImmediate, AUseCapture, AUseCursor: Boolean;
                               const P: TPoint);
    procedure CancelDesignDrag(ASite: TLMDDockSite);
    {$IFDEF LMDCOMP11}
    procedure SetDesignVisible(Value: Boolean); override;
    {$ENDIF}
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure Dock(NewDockSite: TWinControl; ARect: TRect); override;
    procedure UpdateLayout;
    procedure Activate(AShowParentForm: Boolean = True);
    procedure Deactivate;
    function  CloseQuery: Boolean; virtual;
    procedure Close;
    property  Active: Boolean read GetActive;
    property  Site: TLMDDockSite read FSite;
    property  Zone: TLMDDockZone read FZone;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property Images: TCustomImageList read FImages write SetImages;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex default -1;
    property ClientKind: TLMDDockClientKind read FClientKind write SetClientKind default dkTool;
    property PanelVisible: Boolean read FPanelVisible write SetPanelVisible default True;
    property ShowHeader: Boolean read FShowHeader write SetShowHeader default True;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property Buttons: TLMDPanelBtnKinds read FButtons write SetButtons default [pbMenu, pbPin, pbMaximize, pbClose];
    property ShowHeaderImage: TLMDDockPanelHdrImage read FShowHeaderImage write SetShowHeaderImage default hiDefault;
    property HeaderMenu: TPopupMenu read FHeaderMenu write SetHeaderMenu;
    property OnHeaderPopup: TContextPopupEvent read FOnHeaderPopup write FOnHeaderPopup;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;
    property Color stored IsColorStored;
    property ParentColor default False;
    property DefaultColor: Boolean read FDefaultColor write SetDefaultColor default True;
    property DefaultFontColor: Boolean read FDefaultFontColor write SetDefaultFontColor default True;
    property BiDiMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    {$IFDEF LMDCOMP7}
    property ParentBackground;
    {$ENDIF}
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Left;
    property Top;
    property Width;
    property Height;
    property DragMode default dmAutomatic;
    property Caption;
    property Visible: Boolean read GetVisible stored False;
    property PopupMenu;
    property OnCloseQuery: TLMDockPanelCloseQuery read FOnCloseQuery write FOnCloseQuery;
    property OnClose: TLMDockPanelClose read FOnClose write FOnClose;
//    property OnHeaderClick; No way to implement, because the mouse is
//                            captured by VCL drag process at mouse-down
//                            event, and there no mouse-up received by the
//                            panel.
    property OnHeaderDblClick: TLMDDockPanelClick read FOnHeaderDblClick write FOnHeaderDblClick;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnEndDock;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    {$IFDEF LMDCOMP9}
    property OnAlignInsertBefore;
    property OnAlignPosition;
    {$ENDIF}
  end;

  { ****************************** TLMDDockZone ****************************** }

  TLMDZoneKind       = (zkPanel, zkHorz, zkVert, zkTabs);
  TLMDZoneKinds      = set of TLMDZoneKind;
  TLMDZoneResizeKind = (zrkProportional, zrkFixed, zrkSpace);

  TLMDZoneSplitterInfo = record
    Bounds: TRect;
    ZoneA:  TLMDDockZone; // Zone at the left (top) of splitter.
    ZoneB:  TLMDDockZone; // Zone at the right (bottom) of splitter.
  end;

  TLMDZoneTabInfo = record
    Bounds:   TRect;
    CloseBtn: TRect;
    Spacer:   TRect;
    Zone:     TLMDDockZone; // Nil for drag-track tab.
  end;

  TLMDTabbedDocsInfo = record
    MainZone:  TLMDDockZone; // Most parent zone related to tabbed documents
                             // area. Usually, this will be tabs or horz/vert
                             // zone. In current implementation this zone will
                             // always be equal to space zone.
    AreasMask: TLMDActiveAreas;
  end;

  TLMDDockSiteHitKind     = (hkNone, hkZone, hkSplitter);
  TLMDDockSiteHitZoneArea = (hzaClient, hzaTabs);
  TLMDDockSiteHitTest = record
    Kind:     TLMDDockSiteHitKind;
    Zone:     TLMDDockZone;   // Zone or splitter parent zone.
    ZoneArea: TLMDDockSiteHitZoneArea;
    Index:    Integer;        // Splitter or tab index in Zone.
    TabBtn:   TLMDTabBtnKind;
  end;
  
  TLMDDockZone = class
  private
    FTree:         TLMDDockZoneTree;
    FParent:       TLMDDockZone;
    FKind:         TLMDZoneKind;
    FZones:        TList; // Lazy inited.
    FPanel:        TLMDDockPanel;
    FDSize:        Double;
    FHeight:       Integer;
    FLeft:         Integer;
    FWidth:        Integer;
    FTop:          Integer;
    FSelectedPage: TLMDDockZone;
    FScrollToTab:  TLMDDockZone; // Reset to nil after layout update.
    FAutoHide:     Boolean;
    FInserting:    Boolean;
    FShowing:      Boolean;
    FSplitters:    array of TLMDZoneSplitterInfo;
    FFirstTab:     Integer;
    FTabs:         array of TLMDZoneTabInfo;
    FTabArea:      TRect;
    FTabsClip:     TRect;
    FTabAreaBtns:  TLMDTabBtnAreas;
    FSeqWasHidden: Boolean;
    FAutoHideSide: TAlign;
    FFixed:        Boolean; // Storing TLMDZoneResizeKind exactly, specifically
                            // zrkSpace, leads to too many errors.

    procedure InsertZone(AZone: TLMDDockZone; AIndex: Integer);
    procedure RemoveZone(AZone: TLMDDockZone);
    function  GetResizeKind: TLMDZoneResizeKind;
    function  GetZoneCount: Integer;
    function  GetZones(AIndex: Integer): TLMDDockZone;
    function  GetSplitterCount: Integer;
    function  GetSplitters(AIndex: Integer): TLMDZoneSplitterInfo;
    function  GetTabCount: Integer;
    function  GetTabs(AIndex: Integer): TLMDZoneTabInfo;
    function  GetTabState(AIndex: Integer): TLMDZoneTabState;
    function  GetHotTabBtn(AIndex: Integer; out ADown: Boolean): TLMDTabBtnKind;
    procedure RemoveTab(ATab: TLMDDockZone);
    function  GetBounds: TRect;
    function  GetIndex: Integer;
    procedure SetIndex(const Value: Integer);
    procedure SetResizeKind(const Value: TLMDZoneResizeKind);
    procedure SetAutoHide(const Value: Boolean);
    procedure SetSelectedPage(const Value: TLMDDockZone);
    procedure SetFirstTab(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    procedure SetHeight(const Value: Integer);
    procedure InternalSetPanel(const Value: TLMDDockPanel);
    procedure InternalSetBounds(const Value: TRect);
    procedure InternalSetInserting(AWidth, AHeight: Integer);
    function  FindMainDocsZone: TLMDDockZone;
    procedure PanelUIStateChanged(APanel: TLMDDockPanel);
  protected
    procedure CopyFrom(ASource: TLMDDockZone);
    procedure UpdatePanelZn;
    procedure UpdateSeqZn(ASeqHandler: TObject);
    procedure UpdateTabsZn;
    function  UpdateTabArea: TLMDDockZone;
    procedure UpdateAutoHide;
    procedure UpdateLayout;
    procedure UpdateDockTracking;
    procedure Paint(ACanvas: TCanvas);
  public
    constructor Create(ATree: TLMDDockZoneTree); overload;
    constructor Create(ATree: TLMDDockZoneTree; APanel: TLMDDockPanel); overload;
    destructor Destroy; override;

    function  IsEmpty: Boolean;
    function  IsEmptySpace: Boolean;
    function  IsAutoHidden: Boolean;
    procedure AutoHideClose;
    function  ContainSpace: Boolean;
    function  TabbedDocsHost: Boolean;
    function  TabbedDocsInfo(out AInfo: TLMDTabbedDocsInfo): Boolean;
    function  ContainsVisibleContent: Boolean;
    function  ContainsPanel(APanel: TLMDDockPanel): Boolean;
    function  Caption: TLMDString;
    function  GetImageParams(out AImages: TCustomImageList;
                             out AImageIndex: Integer): Boolean;
    function  GetTabImageParams(AChild: TLMDDockZone;
                                out AImages: TCustomImageList;
                                out AImageIndex: Integer): Boolean;
    function  GetTabPanel(AChild: TLMDDockZone;
                          out APanel: TLMDDockPanel): Boolean;
    function  GetTabCaption(AChild: TLMDDockZone): TLMDString;
    function  GetBaseTabWidth(AChild: TLMDDockZone): Integer;
    function  GetTabButtons(AChild: TLMDDockZone): TLMDTabBtnKinds;
    function  GetInsertingTabIndex(const P: TPoint;
                                   AClient: TControl): Integer;
    function  IsTabInView(AChild: TLMDDockZone): Boolean;
    procedure ScrollToTab(AChild: TLMDDockZone);
    procedure ClearZones;
    function  AddZone(AZone: TLMDDockZone): Integer; overload;
    procedure AddZone(AZone: TLMDDockZone; AIndex: Integer); overload;
    function  HasPanelZones(AVisibleOnly: Boolean): Boolean;
    procedure GetPanelZones(AVisibleOnly: Boolean; AResult: TList);
    procedure SetChildrenSizes(const ASizes: array of Integer);

    property Parent: TLMDDockZone read FParent;
    property Index: Integer read GetIndex write SetIndex;
    property Kind: TLMDZoneKind read FKind;
    property ZoneCount: Integer read GetZoneCount;
    property Zones[AIndex: Integer]: TLMDDockZone read GetZones; default;
    property Panel: TLMDDockPanel read FPanel;
    property SplitterCount: Integer read GetSplitterCount;
    property Splitters[AIndex: Integer]: TLMDZoneSplitterInfo read GetSplitters;
    property TabCount: Integer read GetTabCount;
    property Tabs[AIndex: Integer]: TLMDZoneTabInfo read GetTabs;
    property SelectedPage: TLMDDockZone read FSelectedPage write SetSelectedPage;
    property FirstTab: Integer read FFirstTab write SetFirstTab;
    property DSize: Double read FDSize;
    property Inserting: Boolean read FInserting;
    property Left: Integer read FLeft;
    property Top: Integer read FTop;
    property Width: Integer read FWidth write SetWidth;
    property Height: Integer read FHeight write SetHeight;
    property Bounds: TRect read GetBounds;
    property Showing: Boolean read FShowing;
    property AutoHideSide: TAlign read FAutoHideSide;
    property AutoHide: Boolean read FAutoHide write SetAutoHide;
    property ResizeKind: TLMDZoneResizeKind read GetResizeKind write SetResizeKind;
  end;

  { **************************** TLMDDockZoneTree **************************** }

  TLMDDragTabInfo = record
    ZoneIndex: Integer;
    Client:    TControl;
  end;

  TLMDDockZoneTree = class
  private
    FSite:          TLMDDockSite;
    FRoot:          TLMDDockZone;
    FSpaceZone:     TLMDDockZone;
    FBorderBounds:  TRect;
    FAutoHideZones: array[TAlign] of TList;
    FDragTabZone:   TLMDDockZone;    // Drag-track tab is a tab that temporary
    FDragTabInfo:   TLMDDragTabInfo; // inserted into existing tab area while
                                     // dragging to indicate a drop position.
    FHotTabZone:    TLMDDockZone;
    FHotTabIndex:   Integer;
    FHotTabBtn:     TLMDTabBtnKind;
    FHotTabBtnDown: Boolean;
    FHorzHandler:   TObject;
    FVertHandler:   TObject;
    FDeferHandle:   HDWP;
    FActivatePanel: TLMDDockPanel;

    procedure ZoneDestroying(AZone: TLMDDockZone);
    procedure DoNormalizeZone(AZone: TLMDdockZone);
    procedure RemoveFromAutoHideZones(AZone: TLMDDockZone);
    procedure ClearAutoHideZones;
    procedure CorrectDocZones;
  public
    constructor Create(ASite: TLMDDockSite); virtual;
    destructor Destroy; override;

    procedure Clear;
    function  FindZoneByClient(AClient: TControl): TLMDDockZone;
    function  GetInsertingRect(AZone: TLMDDockZone; ADropAlign: TAlign;
                               AClient: TControl): TRect;
    procedure Paint(ACanvas: TCanvas);
    procedure InsertPanel(APanel: TLMDDockPanel; ADockTask: TObject);
    procedure RemovePanel(APanel: TLMDDockPanel);
    procedure NormalizeZones;
    procedure UpdateLayout(AActivate: TLMDDockPanel = nil);
    procedure SetDragTab(ATabZone: TLMDDockZone; ATabInfo: TLMDDragTabInfo;
                         AInvalidate: Boolean = True);
    procedure ResetDragTab(AInvalidate: Boolean = True);
    procedure SetHotTab(ATabZone: TLMDDockZone; ATabIndex: Integer;
                        AInvalidate: Boolean = True);
    procedure ResetHotTab(AInvalidate: Boolean = True);
    procedure SetHotBtn(AHotBtn: TLMDTabBtnKind; AHotDown: Boolean;
                        AInvalidate: Boolean = True);
    procedure ResetTabBtn(AInvalidate: Boolean = True);
    procedure GetUnpinnedPanelZones(ASide: TAlign; AVisibleOnly: Boolean;
                                    AResult: TList);

    property Root: TLMDDockZone read FRoot;
    property Space: TLMDDockZone read FSpaceZone;
    property DragTabZone: TLMDDockZone read FDragTabZone;
    property DragTabInfo: TLMDDragTabInfo read FDragTabInfo;
  end;

  { ****************************** TLMDDockSite ****************************** }

  TLMDDockSiteLockMode    = set of (dlmDockIn, dlmUndockFrom,
                                    dlmSplitterResize, dlmPanelAutoHide,
                                    dlmPanelClose);
  TLMDDragInfo = record
    Zone:      TLMDDockZone; // Nil - means no info.
    Align:     TAlign;
    Index:     Integer;
    Rect:      TRect;
    TabInRect: Boolean;      // Hint to paint drag window with tab,
                             // not just rect.
  end;

  TLMDHotSpotArea   = TLMDActiveArea {$IFDEF LMDCOMP9}deprecated{$ENDIF};
  TLMDHotSpotAreas  = TLMDActiveAreas {$IFDEF LMDCOMP9}deprecated{$ENDIF};

  TAutoHideTab = record
    PanelZone: TLMDDockZone;
    Bounds:    TRect;
    Spacer:    TRect;
  end;
  TAutoHideTabs = array of TAutoHideTab;

  TLMDAutoHideState = (ahsOpened, ahsClosed);

  TLMDDockSiteOnCustomInsertQuery = procedure(Sender: TObject; AClient: TControl;
                                              AZone: TLMDDockZone; AAlign: TAlign;
                                              var AIsCustomInsert: Boolean) of object;
  TLMDDockSiteOnCustomInsert = procedure(Sender: TObject; AClient: TControl;
                                         AZone: TLMDDockZone; AAlign: TAlign) of object;
  TLMDDockSiteOnDockOver = procedure(Sender: TObject; Source: TDragDockObject;
                                     AZone: TLMDDockZone; AAlign: TAlign;
                                     var Accept: Boolean) of object;
  TLMDDockSiteOnDockDrop = procedure(Sender: TObject; Source: TDragDockObject;
                                     AZone: TLMDDockZone; AAlign: TAlign) of object;
  TLMDDockSiteOnUpdateHotSpots = procedure(Sender: TObject; AZone: TLMDDockZone;
                                           var EnabledAreas: TLMDHotSpotAreas) of object;
  TLMDDockSiteOnAutoHide = procedure(Sender: TObject; AClient: TControl;
                                     AState: TLMDAutoHideState) of object;

  TLMDDockSiteState = set of (dssUpdatingPanels, dssRemovingUndocked,
                              dssSplitSizing, dssTabBtnDown, dssLoadingLayout,
                              dssCustomInsert, dssNoAlignControls);

  TLMDDockSite = class(TCustomControl, ILMDComponent)
  private
    FAbout:               TLMDAboutVar;
    FNext:                TLMDDockSite; // Next in global SiteList.
    FState:               TLMDDockSiteState;
    FLockMode:            TLMDDockSiteLockMode;
    FManager:             TLMDDockManager;
    FFixupReader:         TReader;
    FLoadingPanels:       TList;
    FReadedLayout:        ILMDXmlDocument;
    FPanels:              TList;
    FInDragMsg:           Boolean;
    FDockTask:            TObject;
    FUndockPanel:         TLMDDockPanel;
    FHotspots:            array[TLMDHotSpotKind] of TObject;
    FSplitterAreas:       Boolean; // Active areas, additional
    FZoneTabAreas:        Boolean; // to hotspots.
    FAutoHideSides:       array[TAlign] of TControl;
    FZoneTree:            TLMDDockZoneTree;
    FSplitSizer:          TObject;
    FShifter:             TObject;
    FShiftingPanel:       TLMDDockPanel;
    FShiftingSide:        TAlign;
    FShiftingEvent:       TLMDAutoHideState; // Can be -1.
    FLoadDesignLayout:    Boolean;
    FUseSpace:            Boolean;
    FTabsMenu:            TPopupMenu;
    FOnCustomInsertQuery: TLMDDockSiteOnCustomInsertQuery;
    FOnCustomInsert:      TLMDDockSiteOnCustomInsert;
    FOnDockOver:          TLMDDockSiteOnDockOver;
    FOnDockDrop:          TLMDDockSiteOnDockDrop;
    FOnChange:            TNotifyEvent;
    FOnUpdateHotSpots:    TLMDDockSiteOnUpdateHotSpots;
    FOnAutoHide:          TLMDDockSiteOnAutoHide;

    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMDrag(var Message: TCMDrag); message CM_DRAG;
    procedure CMDockNotification(var Message: TCMDockNotification); message CM_DOCKNOTIFICATION;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    {$IFDEF LMDCOMP16}
    procedure CMStyleChanged(var Message: TMessage); message CM_STYLECHANGED;
    {$ENDIF}
    procedure ZoneDestroying(AZone: TLMDDockZone);
    procedure ClearLoadingPanels;
    procedure InsertOrUpdatePanel(APanel: TLMDDockPanel; ADockTask: TObject);
    procedure RemovePanel(APanel: TLMDDockPanel);
    procedure PanelUIStateChanged(APanel: TLMDDockPanel);
    procedure DestroyPanels;
    procedure InternalDockControl(AControl: TControl; ADropOnZone: TLMDDockZone;
                                  AAlign: TAlign; AIndex: Integer; ASelectPage:
                                  Boolean; AExactSet: Boolean = False);
    function  FindHotspot(const P: TPoint): TObject;
    function  GetDragInfo(const P: TPoint; AClient: TControl;
                          ASource: TDragDockObject = nil): TLMDDragInfo;
    function  GetPanelCount: Integer;
    function  GetPanels(AIndex: Integer): TLMDDockPanel;
    function  GetRootZone: TLMDDockZone;
    function  GetSpaceZone: TLMDDockZone;
    function  DockTaskFromDropInfo(AClient: TControl; AWidth, AHeight: Integer;
                                   const ADropInfo: TLMDDragInfo;
                                   AManualDockSrc: TDragDockObject = nil): TObject;
    function  UpdateDockTracking(const P: TPoint; AClient: TControl;
                                 ASource: TDragDockObject = nil): TLMDDragInfo;
    procedure EndDockTracking(AInvalidate: Boolean = True);
    procedure UpdateTracking;
    procedure CancelTracking;
    procedure DesignDrag(APanel: TLMDDockPanel; ADragMsg: TDragMessage;
                         const P: TPoint; var R: TRect; var AShowRect: Boolean;
                         var ATabInRect: Boolean);
    procedure ZoneSizingFinishProc(AAccept: Boolean; AData: TObject;
                                   AData2: Integer; const ASpltBounds: TRect);
    procedure PanelSizingFinishProc(AAccept: Boolean; AData: TObject;
                                   AData2: Integer; const ASpltBounds: TRect);
    procedure BeginSplitterSizing(AZone: TLMDdockZone; ASplIndex: Integer;
                                  const P: TPoint); overload;
    procedure BeginSplitterSizing(APanel: TLMDDockPanel; const P: TPoint); overload;
    procedure UpdateSplitterSizing(const P: TPoint);
    procedure EndSplitterSizing(AAccept: Boolean);
    procedure SetShifingPanel(APanel: TLMDDockPanel; ASide: TAlign;
                              AOpen, AActivate: Boolean;
                              AImmediateInvert: Boolean = True);
    procedure RaiseShiftingEvent(APanel: TLMDDockPanel;
                                 AState: TLMDAutoHideState);
    procedure BeginLoading;
    procedure EndLoading;
    procedure IdToCompProc(const AId: TLMDString; out AComp: TComponent);
    procedure CompToIdProc(AComp: TComponent; out AId: TLMDString);
    procedure ReferenceIdProc(var AId: TLMDString);
    procedure ReadLayout(Stream: TStream);
    procedure WriteLayout(Stream: TStream);
    procedure FixupReadedIds(AReader: TReader);
    procedure FreeReadedLayout(ADockLoadingPanels: Boolean);
    procedure ApplyReadedLayout;
    function  TryCustomInsert(AClient: TControl; AZone: TLMDDockZone;
                              AAlign: TAlign): Boolean;
    procedure SetUseSpace(const Value: Boolean);
    procedure UpdateUndockSizes;
    function  DeactivateActiveChild(const ACheckOnly, AExclude:
                                    array of TLMDDockPanel): Boolean;
    procedure ManagerChanged;
    function  GetClientKind(AClient: TControl): TLMDDockClientKind;
    procedure SetLockMode(const Value: TLMDDockSiteLockMode);
    procedure SetManager(const Value: TLMDDockManager);
    function  StyleElems: TLMDDockElems;
  protected
    { ILMDComponent }
    function  getLMDPackage: TLMDPackageID;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadState(Reader: TReader); override;
    procedure Loaded; override;
    procedure Updated; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateHandle; override;
    function  DesignWndProc(var Message: TMessage): Boolean; override;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
                      X, Y: Integer); override;
    procedure AlignControls(AControl: TControl; var ARect: TRect); override;
    {$IFNDEF LMDCOMP12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    {$ENDIF}
    {$IFDEF LMDCOMP9}
    function  IsQualifyingSite(const Client: TControl): Boolean; override;
    {$ENDIF}
    procedure GetSiteInfo(Client: TControl; var InfluenceRect: TRect;
                          MousePos: TPoint; var CanDock: Boolean); override;
    procedure DoAddDockClient(Client: TControl; const ARect: TRect); override;
    procedure DockOver(Source: TDragDockObject; X, Y: Integer;
                       State: TDragState; var Accept: Boolean); override;
    function  DoUnDock(NewTarget: TWinControl;
                       Client: TControl): Boolean; override;
    procedure DoRemoveDockClient(Client: TControl); override;
    procedure ShowControl(AControl: TControl); override;
    procedure GetClientImageParams(AClient: TControl;
                                   out AImages: TCustomImageList;
                                   out AImageIndex: Integer); virtual;
    procedure DoChange; virtual;
    function  DoDockOver(Source: TDragDockObject; AZone: TLMDDockZone;
                         AAlign: TAlign): Boolean; reintroduce; virtual;
    procedure DoDockDrop(Source: TDragDockObject; AZone: TLMDDockZone;
                         AAlign: TAlign); virtual;
    function  DoCustomInsertQuery(AClient: TControl; AZone: TLMDDockZone;
                                  AAlign: TAlign): Boolean; virtual;
    procedure DoCustomInsert(AClient: TControl; AZone: TLMDDockZone;
                             AAlign: TAlign); virtual;
    procedure DoUpdateHotSpots(AClient: TControl; AZone: TLMDDockZone;
                               var EnabledAreas: TLMDActiveAreas); virtual;
    procedure DoAutoHide(AClient: TControl; AState: TLMDAutoHideState); virtual;
    function  GetIsFloatingSite: Boolean; virtual;
    function  GetIsFloatingDoc: Boolean; virtual;
    function  GetFloatingForm: TLMDFloatingForm; virtual;
    procedure NotifyFloatForm; virtual;
    function  WantsTransparency(const P: TPoint): Boolean; virtual;
    function  ShowPanelHeader(APanel: TLMDDockPanel): Boolean; virtual;
    function  GetPanelButtons(APanel: TLMDDockPanel): TLMDPanelBtnKinds; virtual;
    procedure PanelButtonClick(APanel: TLMDDockPanel; B: TLMDPanelBtnKind); virtual;
    procedure PopupTabsMenu(AZone: TLMDDockZone);
    procedure DoDockTask;
    procedure ResetUndockedClientPnls;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    {$IFDEF LMDCOMP12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    {$ENDIF}
    procedure DockDrop(Source: TDragDockObject; X, Y: Integer); override;
    procedure DockControl(AControl: TControl; ADropOnZone: TLMDDockZone = nil;
                          AZoneSide: TAlign = alClient; ATabIndex: Integer = -1;
                          ASelectPage: Boolean = True);
    procedure UpdateLayout(AFireChangeEvent: Boolean = False; AActivate: TLMDDockPanel = nil);
    function  FindPanelByClient(AClient: TControl): TLMDDockPanel;
    function  FindZoneByClient(AClient: TControl): TLMDDockZone;
    function  GetHitTest(const P: TPoint): TLMDDockSiteHitTest;

    property IsFloatingSite: Boolean read GetIsFloatingSite;
    property IsFloatingDoc: Boolean read GetIsFloatingDoc;
    property FloatingForm: TLMDFloatingForm read GetFloatingForm;
    property PanelCount: Integer read GetPanelCount;
    property Panels[AIndex: Integer]: TLMDDockPanel read GetPanels;
    property RootZone: TLMDDockZone read GetRootZone;
    property SpaceZone: TLMDDockZone read GetSpaceZone;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property Manager: TLMDDockManager read FManager write SetManager;
    property LockMode: TLMDDockSiteLockMode read FLockMode write SetLockMode default [];
    property LoadDesignLayout: Boolean read FLoadDesignLayout write FLoadDesignLayout default True;
    property UseSpace: Boolean read FUseSpace write SetUseSpace default True;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnDockOver: TLMDDockSiteOnDockOver read FOnDockOver write FOnDockOver;
    property OnDockDrop: TLMDDockSiteOnDockDrop read FOnDockDrop write FOnDockDrop;
    property OnCustomInsertQuery: TLMDDockSiteOnCustomInsertQuery read FOnCustomInsertQuery write FOnCustomInsertQuery;
    property OnCustomInsert: TLMDDockSiteOnCustomInsert read FOnCustomInsert write FOnCustomInsert;
    property OnUpdateHotSpots: TLMDDockSiteOnUpdateHotSpots read FOnUpdateHotSpots write FOnUpdateHotSpots;
    property OnAutoHide: TLMDDockSiteOnAutoHide read FOnAutoHide write FOnAutoHide;
    property Align;
    property Anchors;
    property Font;
    property ParentFont;
    property OnGetSiteInfo;
    property BiDiMode;
    property Constraints;
    property Enabled;
    property ParentBiDiMode;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnUnDock;
  end;

  { ***************************** TLMDDockManager **************************** }

  TLMDDockGetCompId     = procedure(Sender: TObject; AComponent: TComponent;
                                    var AId: TLMDString) of object;
  TLMDDockGetComp       = procedure(Sender: TObject; const AId: TLMDString;
                                    var AComponent: TComponent) of object;
  TLMDDockSaveSite      = procedure(Sender: TObject; ASite: TLMDDockSite;
                                    AFloat: Boolean; var ASave: Boolean) of object;
  TLMDDockStreamAppInfo = procedure(Sender: TObject;
                                    const Xml: ILMDXmlDocument) of object;
  TLMDDockSiteEvent     = procedure(Sender: TObject; ASite: TLMDDockSite) of object;
  TLMDDockAttachSite    = procedure(Sender: TObject; ASite: TLMDDockSite;
                                    var Attach: Boolean) of object;
  TLMDDockGetClientKind = procedure(Sender: TObject; AClient: TControl;
                                    var AKind: TLMDDockClientKind) of object;

  TLMDDockManager = class(TComponent, ILMDComponent)
  private
    FNext:                  TLMDDockManager; // Next in global manager list.
    FStyle:                 TLMDDockStyle;
    FDockElems:             TLMDDockElems;
    FPersistFloatSize:      Boolean;
    FStayFloatFormsOnTop:   Boolean;
    FFloatFormButtons:      TLMDPanelBtnKinds;
    FUseTabbedDocs:         Boolean;
    FOnLayoutChange:        TNotifyEvent;
    FOnGetComp:             TLMDDockGetComp;
    FOnGetCompId:           TLMDDockGetCompId;
    FOnSaveSite:            TLMDDockSaveSite;
    FOnWriteAppInfo:        TLMDDockStreamAppInfo;
    FOnReadAppInfo:         TLMDDockStreamAppInfo;
    FBeforeRead:            TLMDDockStreamAppInfo;
    FBeforeWrite:           TLMDDockStreamAppInfo;
    FOnAttachFloatingSite:  TLMDDockAttachSite;
    FOnDestroyFloatingSite: TLMDDockSiteEvent;
    FOnCreateFloatingSite:  TLMDDockSiteEvent;
    FOnGetClientKind:       TLMDDockGetClientKind;
    FScrollDocTabs:         Boolean;

    function  FindSite(AFloating: Boolean; const AId: TLMDString): TLMDDockSite;
    procedure IdToCompProc(const AId: TLMDString; out AComp: TComponent);
    procedure CompToIdProc(AComp: TComponent; out AId: TLMDString);
    procedure UpdateSites;
    procedure SetStayFloatFormsOnTop(const Value: Boolean);
    procedure SetFloatFormButtons(const Value: TLMDPanelBtnKinds);
    procedure SetUseTabbedDocs(const Value: Boolean);
    function  GetSiteCount: Integer;
    function  GetSites(AIndex: Integer): TLMDDockSite;
    procedure SetStyle(const Value: TLMDDockStyle);
    function  GetStyleName: TLMDStyleName;
    procedure SetStyleName(const Value: TLMDStyleName);
    procedure SetScrollDocTabs(const Value: Boolean);
  protected
    { ILMDComponent }
    function  getLMDPackage: TLMDPackageID;
  protected
    procedure Loaded; override;
    procedure DoLayoutChange; virtual;
    function  AttachFloatingSite(ASite: TLMDDockSite): Boolean; virtual;
    procedure FloatingSiteCreated(ASite: TLMDDockSite); virtual;
    procedure FloatingSiteDestroying(ASite: TLMDDockSite); virtual;
    function  DoGetCompId(AComp: TComponent): TLMDString; virtual;
    function  DoGetComp(const AId: TLMDString): TComponent; virtual;
    function  DoSaveSite(ASite: TLMDDockSite): Boolean; virtual;
    procedure DoBeforeWrite(const Xml: ILMDXmlDocument); virtual;
    procedure DoBeforeRead(const Xml: ILMDXmlDocument); virtual;
    procedure DoWriteAppInfo(const Xml: ILMDXmlDocument); virtual;
    procedure DoReadAppInfo(const Xml: ILMDXmlDocument); virtual;
    function  DoGetClientKind(AClient: TControl): TLMDDockClientKind; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SaveToStream(AStream: TStream);
    procedure SaveToFile(const AFileName: TLMDString);
    procedure LoadFromStream(AStream: TStream);
    procedure LoadFromFile(const AFileName: TLMDString);
    procedure ApplyDesignLayout;

    property Style: TLMDDockStyle read FStyle write SetStyle;
    property DockElems: TLMDDockElems read FDockElems;

    property SiteCount: Integer read GetSiteCount;
    property Sites[AIndex: Integer]: TLMDDockSite read GetSites;
  published
    property StyleName: TLMDStyleName read GetStyleName write SetStyleName;
    property PersistFloatSize: Boolean read FPersistFloatSize write FPersistFloatSize default False;
    property FloatFormButtons: TLMDPanelBtnKinds read FFloatFormButtons write SetFloatFormButtons default [pbMaximize, pbClose];
    property ScrollDocTabs: Boolean read FScrollDocTabs write SetScrollDocTabs default True;
    property UseTabbedDocs: Boolean read FUseTabbedDocs write SetUseTabbedDocs default True;
    property StayFloatFormsOnTop: Boolean read FStayFloatFormsOnTop write SetStayFloatFormsOnTop default True;
    property OnLayoutChange: TNotifyEvent read FOnLayoutChange write FOnLayoutChange;
    property OnAttachFloatingSite: TLMDDockAttachSite read FOnAttachFloatingSite write FOnAttachFloatingSite;
    property OnCreateFloatingSite: TLMDDockSiteEvent read FOnCreateFloatingSite write FOnCreateFloatingSite;
    property OnDestroyFloatingSite: TLMDDockSiteEvent read FOnDestroyFloatingSite write FOnDestroyFloatingSite;
    property OnGetCompId: TLMDDockGetCompId read FOnGetCompId write FOnGetCompId;
    property OnGetComp: TLMDDockGetComp read FOnGetComp write FOnGetComp;
    property OnSaveSite: TLMDDockSaveSite read FOnSaveSite write FOnSaveSite;
    property BeforeWrite: TLMDDockStreamAppInfo read FBeforeWrite write FBeforeWrite;
    property BeforeRead: TLMDDockStreamAppInfo read FBeforeRead write FBeforeRead;
    property OnWriteAppInfo: TLMDDockStreamAppInfo read FOnWriteAppInfo write FOnWriteAppInfo;
    property OnReadAppInfo: TLMDDockStreamAppInfo read FOnReadAppInfo write FOnReadAppInfo;
    property OnGetClientKind: TLMDDockGetClientKind read FOnGetClientKind write FOnGetClientKind;
  end;

function LMDGetClientCaption(AClient: TControl): TLMDString;

{ **************************** Design-time support *************************** }

type
  TLMDGetDesignerSelection = procedure(AComponent: TComponent;
                                       ASelection: TList);
  TLMDSetDesignedSelection = procedure(AComponent: TComponent);
  TLMDDesignerAction       = (paUnknown, paMove, paSelectChildren, paInsert);
  TLMDGetDesignerAction    = function(AComponent: TComponent): TLMDDesignerAction;

var
  LMDGetDesignerSelectionProc: TLMDGetDesignerSelection;
  LMDSetDesignedSelectionProc: TLMDSetDesignedSelection;
  LMDGetDesignerActionProc:    TLMDGetDesignerAction;

implementation

uses
  Types, Math {$IFDEF LMD_DEBUGTRACE}, Dialogs; {$I C2.INC}{$ELSE};{$ENDIF}

type
  TControlAccess    = class(TControl);
  TReaderAccess     = class(TReader);
  TDockStylesAccess = class(TLMDDockStyles);

  { ******************************* TDockTask ******************************** }

  TDockTask = class
  public
    Client:     TControl;
    Zone:       TLMDDockZone;
    ExactSet:   Boolean;
    Align:      TAlign;   // If not ExactSet.
    Index:      Integer;  //
    SelectPage: Boolean;  //
    Width:      Integer;  //
    Height:     Integer;  //
  end;

  { ****************************** TSeqHandlers ****************************** }

  TSeqItemKind = (sikProportional, sikPreserveSize, sikSpace);
  TSeqItem     = record
    Data:  TObject;
    Kind:  TSeqItemKind;
    Size:  Integer;
    DSize: Double;
  end;
  TSeqItems = array of TSeqItem;

  TSeqHandler = class
  public
    class procedure CalcLayout(var AItems: TSeqItems; AZoneSize: Integer;
                               ASplitterSize: Integer);
    function  GetControlXSize(AControl: TControl): Integer; virtual; abstract;
    function  GetZoneXMin(AZone: TLMDDockZone; M: TLMDMargins = nil): Integer; virtual; abstract;
    function  GetZoneYMin(AZone: TLMDDockZone; M: TLMDMargins = nil): Integer; virtual; abstract;
    function  GetZoneXSize(AZone: TLMDDockZone; M: TLMDMargins = nil): Integer; virtual; abstract;
    function  GetZoneYSize(AZone: TLMDDockZone; M: TLMDMargins = nil): Integer; virtual; abstract;
    function  GetRealRect(AXMin, AYMin, AXSize, AYSize: Integer): TRect; virtual; abstract;
    procedure OffsetRealRect(var ARect: TRect; AXOffset, AYOffset: Integer); virtual; abstract;
    function  GetHideSide(AAfterSpace: Boolean): TAlign; virtual; abstract;
  end;

  THorzSeqHandler = class(TSeqHandler)
  public
    function  GetControlXSize(AControl: TControl): Integer; override;
    function  GetZoneXMin(AZone: TLMDDockZone; M: TLMDMargins = nil): Integer; override;
    function  GetZoneYMin(AZone: TLMDDockZone; M: TLMDMargins = nil): Integer; override;
    function  GetZoneXSize(AZone: TLMDDockZone; M: TLMDMargins = nil): Integer; override;
    function  GetZoneYSize(AZone: TLMDDockZone; M: TLMDMargins = nil): Integer; override;
    function  GetRealRect(AXMin, AYMin, AXSize, AYSize: Integer): TRect; override;
    procedure OffsetRealRect(var ARect: TRect; AXOffset, AYOffset: Integer); override;
    function  GetHideSide(AAfterSpace: Boolean): TAlign; override;
  end;

  TVertSeqHandler = class(TSeqHandler)
  public
    function  GetControlXSize(AControl: TControl): Integer; override;
    function  GetZoneXMin(AZone: TLMDDockZone; M: TLMDMargins = nil): Integer; override;
    function  GetZoneYMin(AZone: TLMDDockZone; M: TLMDMargins = nil): Integer; override;
    function  GetZoneXSize(AZone: TLMDDockZone; M: TLMDMargins = nil): Integer; override;
    function  GetZoneYSize(AZone: TLMDDockZone; M: TLMDMargins = nil): Integer; override;
    function  GetRealRect(AXMin, AYMin, AXSize, AYSize: Integer): TRect; override;
    procedure OffsetRealRect(var ARect: TRect; AXOffset, AYOffset: Integer); override;
    function  GetHideSide(AAfterSpace: Boolean): TAlign; override;
  end;

  { ****************************** TTabsHandlers ***************************** }

  TTabItem = record
    Zone:     TLMDDockZone;
    BaseSize: Integer;
    Size:     Integer;
  end;
  TTabItems = array of TTabItem;

  TCutMode = (cmNone, cmLast, cmAll);

  TTabsHandler = class
  public
    class function  CreateHandler(ASide: TAlign): TTabsHandler;
    class procedure CalcLayout(ACanvas: TCanvas; ATabArea, ASpacer: Integer;
                               ACutMode: TCutMode; var AItems: TTabItems);
    function  GetXMin(const ARect: TRect): Integer; virtual; abstract;
    function  GetYMin(const ARect: TRect): Integer; virtual; abstract;
    function  GetXSize(const ARect: TRect): Integer; virtual; abstract;
    function  GetYSize(const ARect: TRect): Integer; virtual; abstract;
    function  GetRealRect(AXMin, AYMin, AXSize, AYSize: Integer): TRect; virtual; abstract;
    procedure OffsetRealRect(var ARect: TRect; AXOffset, AYOffset: Integer); virtual; abstract;
  end;

  TLRTabsHandler = class(TTabsHandler)
  public
    function  GetXMin(const ARect: TRect): Integer; override;
    function  GetYMin(const ARect: TRect): Integer; override;
    function  GetXSize(const ARect: TRect): Integer; override;
    function  GetYSize(const ARect: TRect): Integer; override;
    function  GetRealRect(AXMin, AYMin, AXSize, AYSize: Integer): TRect; override;
    procedure OffsetRealRect(var ARect: TRect; AXOffset, AYOffset: Integer); override;
  end;

  TTBTabsHandler = class(TTabsHandler)
  public
    function  GetXMin(const ARect: TRect): Integer; override;
    function  GetYMin(const ARect: TRect): Integer; override;
    function  GetXSize(const ARect: TRect): Integer; override;
    function  GetYSize(const ARect: TRect): Integer; override;
    function  GetRealRect(AXMin, AYMin, AXSize, AYSize: Integer): TRect; override;
    procedure OffsetRealRect(var ARect: TRect; AXOffset, AYOffset: Integer); override;
  end;

  { ***************************** TSplitterSizer ***************************** }

  TSplitterFinishProc = procedure(AAccept: Boolean; AData: TObject;
                                  AData2: Integer;
                                  const ASpltBounds: TRect) of object;
  TSplitterSizer = class
  private
    FSite:           TLMDDockSite;
    FIsVert:         Boolean;
    FArea:           TRect;
    FSplitterBounds: TRect;
    FSpltrSize:      Integer;
    FData:           TObject;
    FData2:          Integer;
    FFinishProc:     TSplitterFinishProc;
    FBrush:          TBrush;
    FInited:         Boolean;
    FXOffset:        Integer;
    FYOffset:        Integer;
    FDrawRect:       TRect;

    procedure Draw;
    function  CalcSplitterSize: Integer;
  public
    constructor Create(ASite: TLMDDockSite; AIsVert: Boolean; const AArea,
                       ASplitterBounds: TRect; AData: TObject; AData2: Integer;
                       AFinishProc: TSplitterFinishProc);
    destructor Destroy; override;

    procedure Update(const AMousePos: TPoint);
    procedure Finish(AAccept: Boolean);
  end;

  { ****************************** TPanelShifter ***************************** }

  TPanelShifterState = (pssClosed, pssOpened, pssOpening, pssClosing);
  TPanelShifter = class
  private
    FSite:        TLMDDockSite;
    FState:       TPanelShifterState;
    FInactiveCnt: Integer;
    FOffset:      Double;  // 0 - fully closed, 1 - fully opened.
    FActivate:    Boolean;
    FUpdating:    Boolean;
    FTimerHWnd:   THandle;

    function  CheckPanel: Boolean;
    function  IsPnlActive: Boolean;
    function  IsPnlSelectedByDesigner: Boolean;
    function  IsCursorOnPanel: Boolean;
    function  DeactivatePanel: Boolean;
    function  CalcPanelBounds: TRect;
    procedure TimerWndProc(var Msg: TMessage);
  public
    constructor Create(ASite: TLMDDockSite);
    destructor Destroy; override;

    procedure SetState(AOpen, AAnimate, AActivate: Boolean);
    procedure Update;
  end;

  { ******************************* TZOrderer ******************************** }

  TZOrderer = class
  private
    FWindows: TList;
  public
    constructor Create;
    destructor Destroy; override;

    procedure UpdateZOrder;
    procedure AddWindow(AWindow: TWinControl);
    procedure RemoveWindow(AWindow: TWinControl);
  end;

  { ******************************* TAnimator ******************************** }

  TAnimationProc = procedure(AId: Integer) of object;

  PAnimatorItem = ^TAnimatorItem;
  TAnimatorItem = record
    Id:       Integer;
    Proc:     TAnimationProc;
    Duration: Integer;
    Elapsed:  Integer;
  end;

  TAnimationKind = (akLinear, akSqrt, akSquare, akCubic);

  TAnimator = class
  private
    FItems:  array of TAnimatorItem;
    FCount:  Integer;
    FNextId: Integer;
    FHWnd:   HWND;

    function  GetIsExists(AId: Integer): Boolean;
    function  GetValue(AId: Integer): Double;
    function  Find(AId: Integer): PAnimatorItem;
    procedure Remove(AId: Integer);
    procedure UpdateTimer;
    procedure WndProc(var Message: TMessage);
    procedure Step(AItem: PAnimatorItem);
    function  AdjustValue(V: Double; AKind: TAnimationKind): Double;
  public
    constructor Create;
    destructor Destroy; override;

    procedure ReStart(ADuration: Integer; AProc: TAnimationProc;
                      var AId: Integer);
    procedure Cancel(AId: Integer);
    function  RangedVal(AId: Integer; AFrom, ATo: Integer;
                        AKind: TAnimationKind = akLinear): Integer; overload;
    function  RangedVal(AId: Integer; AFrom, ATo: Double;
                        AKind: TAnimationKind = akLinear): Double; overload;
    function  RangedVal(AId: Integer; AFrom, ATo: TPoint;
                        AKind: TAnimationKind = akLinear): TPoint; overload;
    function  RangedVal(AId: Integer; AFrom, ATo: TRect;
                        AKind: TAnimationKind = akLinear): TRect; overload;
    property  IsExists[AId: Integer]: Boolean read GetIsExists;
    property  Value[AId: Integer]: Double read GetValue;
  end;

  { ******************************** THotSpot ******************************** }

  THotSpotState = record
    Alpha:  Integer;
    Bounds: TRect;
  end;

  THotSpot = class(TCustomControl)
  private
    FSite:         TLMDDockSite; // Valid only while visible.
    FKind:         TLMDHotSpotKind;
    FZone:         TLMDDockZone;
    FEnabledAreas: TLMDActiveAreas;
    FUsedAreas:    TLMDActiveAreas;
    FLayout:       TLMDHotSpotLayout;
    FBitmap:       TBitmap;
    FAnimationId:  Integer;
    FState:        THotSpotState;
    FPrevState:    THotSpotState;

    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure AnimateTo(ASite: TLMDDockSite; AShowing: Boolean;
                        const ABounds: TRect);
    procedure AnimationStep(AId: Integer);
    procedure PrepareBitmap(C: TCanvas; HS: TLMDHotspotBase);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ZoneDestroying(AZone: TLMDDockZone);
    procedure Show(AKind: TLMDHotSpotKind; ASite: TLMDDockSite;
                   ACenterZone: TLMDDockZone;
                   AEnabledAreas: TLMDActiveAreas;
                   const ASiteRect, AZoneRect: TRect);
    procedure Hide;
    function  GetHotSpotInfo(P: TPoint; out AZone: TLMDDockZone;
                             out ADropAlign: TAlign): Boolean;
  end;

  { ***************************** TAutoHideSide ****************************** }

  TAutoHideSide = class(TCustomControl)
  private
    FSite:        TLMDDockSite;
    FSide:        TAlign;
    FHandler:     TTabsHandler;
    FTabs:        TAutoHideTabs;
    FHotTab:      Integer;
    FTimerActive: Boolean;

    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMTimer(var Message: TWMTimer); message WM_TIMER;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    function  FindTabAtPoint(const P: TPoint): Integer;
    procedure UpdateTracking(AImmediate, AActivate: Boolean);
    procedure CancelTracking;
    procedure UpdateShiftTimer(ATimerActive: Boolean);
    procedure UpdateTrackTimer;
    procedure SetShiftingPanel(APanel: TLMDDockPanel; AActivate: Boolean);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(ASite: TLMDDockSite; ASide: TAlign); reintroduce;
    destructor Destroy; override;

    procedure ZoneDestroying(AZone: TLMDDockZone);
    procedure UpdateLayout(const R: TRect);
    function  FindPanelAtPoint(const P: TPoint): TLMDDockPanel;
  end;

  { ***************************** TDockingRect ******************************* }

  TDockingRectState = record
    Accepted: Boolean;
    Alpha:    Integer;
    Bounds:   TRect;
  end;

  TDockingRect = class(TCustomControl)
  private
    FTabInRect:   Boolean;
    FBkColor:     TColor;
    FBrdColor:    TColor;
    FAnimate:     Boolean;
    FAnimationId: Integer;
    FState:       TDockingRectState;
    FPrevState:   TDockingRectState;

    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure AnimateTo(AShowing, AAccepted: Boolean; AShowingFrom: PRect;
                        const ABounds: TRect);
    procedure AnimationStep(AId: Integer);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Show(AShowingFrom: PRect; const ABounds: TRect;
                   ATabInRect: Boolean; ABkColor, ABrdColor: TColor;
                   AAccepted, AAnimate: Boolean);
    procedure Hide;
    property  Accepted: Boolean read FState.Accepted;
  end;

  { ***************************** TFloatingSite ****************************** }

  TFloatingSite = class(TLMDDockSite)
  private
    FForm: TLMDFloatingForm;
  protected
    function  GetIsFloatingSite: Boolean; override;
    function  GetIsFloatingDoc: Boolean; override;
    function  GetFloatingForm: TLMDFloatingForm; override;
    procedure NotifyFloatForm; override;
    function  WantsTransparency(const P: TPoint): Boolean; override;
    function  ShowPanelHeader(APanel: TLMDDockPanel): Boolean; override;
    function  GetPanelButtons(APanel: TLMDDockPanel): TLMDPanelBtnKinds; override;
    procedure PanelButtonClick(APanel: TLMDDockPanel; B: TLMDPanelBtnKind); override;
  public
    function  GetFormKind(out ASingle: TLMDDockPanel): TLMDFloatFormKind;
    function  AllowClose: Boolean;
    function  AllowMaximize: Boolean;
    procedure GetHeaderBtns(var AButtons: TLMDPanelBtnKinds);
    function  HeaderBtnClick(B: TLMDPanelBtnKind): Boolean;
    function  FormHeaderDrag(out APanel: TLMDDockPanel): Boolean;
  end;

  { ***************************** TSiteStreamer ****************************** }

  TSiteStreamerIdToComp    = procedure(const AId: TLMDString;
                                       out AComponent: TComponent) of object;
  TSiteStreamerCompToId    = procedure(AComponent: TComponent;
                                       out AId: TLMDString) of object;
  TSiteStreamerReferenceId = procedure(var AId: TLMDString) of object;

  TSiteStreamer = class
  private
    FSite:             TLMDDockSite;
    FIdToComp:         TSiteStreamerIdToComp;
    FCompToId:         TSiteStreamerCompToId;
    FRefIdProc:        TSiteStreamerReferenceId;
    FPersistFloatSize: Boolean;

    procedure AdjustBounds(var ABounds: TRect);
    function  ZoneKindToStr(AKind: TLMDZoneKind): TLMDString;
    function  StrToZoneKind(const AKind: TLMDString): TLMDZoneKind;
    function  GetSeqZoneSize(AZone: TLMDDockZone): Integer;
    procedure SetSeqZoneSize(AZone: TLMDDockZone; AValue: Integer);
    function  FindFirstZoneElem(AParent: ILMDXmlElement): ILMDXmlElement;
    procedure DoSave(AParent: ILMDXmlElement);
    procedure DoSaveZone(AZone: TLMDDockZone; AParent: ILMDXmlElement);
    procedure DoLoad(AElem: ILMDXmlElement);
    procedure DoLoadZone(AZone: TLMDDockZone; AElem: ILMDXmlElement);
    procedure DoFixupIds(AElem: ILMDXmlElement);
    procedure DoFixupZoneId(AElem: ILMDXmlElement);
  public
    class procedure Save(ASite: TLMDDockSite; AParent: ILMDXmlElement;
                         ACompToId: TSiteStreamerCompToId;
                         ASaveFloatSize: Boolean);
    class function  GetParams(AElem: ILMDXmlElement; out AFloating: Boolean;
                              out AId: TLMDString): Boolean;
    class procedure Load(ASite: TLMDDockSite; AElem: ILMDXmlElement;
                         AIdToComp: TSiteStreamerIdToComp;
                         ALoadFloatSize: Boolean);
    class procedure FixupIds(ASite: TLMDDockSite; AElem: ILMDXmlElement;
                             ARefIdProc: TSiteStreamerReferenceId);
  end;

  { ***************************** TManagerElems ****************************** }

  TManagerElems = class(TLMDDockElems)
  private
    FManager: TLMDDockManager;
  protected
    procedure Changed(AChanges: TLMDElemSetChanges); override;
  public
    constructor Create(AManager: TLMDDockManager);
  end;

  TTabMenuItem = class(TMenuItem)
  private
    FTabZone: TLMDDockZone;
    FIndex:   Integer;
  public
    constructor Create(AOwner: TComponent; ATabZone: TLMDDockZone;
                       AIndex: Integer); reintroduce;
    procedure   Click; override;
  end;

  { ********************************* TGlow ********************************** }

  TResizeKind = (rkLeft, rkTopLeft, rkTop, rkTopRight,
                 rkRight, rkBottomLeft, rkBottom, rkBottomRight);

  TResizer = class
  private
    FForm:        TLMDFloatingForm;
    FKind:        TResizeKind;
    FWnd:         HWND;
    FStartDrag:   TPoint;
    FStartBounds: TRect;
    FFinished:    Boolean;

    procedure Init;
    procedure WndProc(var M: TMessage);
    procedure DoResize;
  public
    constructor Create(AForm: TLMDFloatingForm; AKind: TResizeKind);
    destructor Destroy; override;

    property Finished: Boolean read FFinished;
  end;

  TGlow = class(TCustomControl)
  private
    FForm:       TLMDFloatingForm;
    FSide:       TAlign;
    FBitmap:     TBitmap;
    FBitmapActv: Boolean;
    FBounds:     TRect;
    FResizer:    TResizer;

    procedure WMEraseBkgnd(var M: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSetCursor(var M: TWMSetCursor); message WM_SETCURSOR;
    procedure WMMouseActivate(var M: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure UpdateBitmap;
    function  GetResizeKind(const P: TPoint): TResizeKind;
    function  GetBounds: TRect;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer;
                        Y: Integer); override;
  public
    constructor Create(AForm: TLMDFloatingForm; ASide: TAlign); reintroduce;
    destructor Destroy; override;

    procedure Update(AForceRedraw: Boolean); reintroduce;
  end;

{ ********************************** Globals ********************************* }
{ ---------------------------------------------------------------------------- }
const
  STD_INDENT        = 4;
  ANIMATOR_INTERVAL = 10;
  MIN_ZONESIZE      = 32;

  REQUIRED_ZONE_KIND: array[TAlignEx] of TLMDZoneKind = (
    zkTabs, zkVert, zkVert, zkHorz, zkHorz, zkTabs, zkTabs,
    zkVert, zkVert, zkHorz, zkHorz
  );

  PLACE_AFTER_ZONE: array[TAlignEx] of Boolean = (
    True, False, True, False, True, True, True,
    False, True, False, True
  );

  ZONEKIND_STRS: array[TLMDZoneKind] of TLMDString = ('PANEL', 'HORZ',
                                                      'VERT', 'TABS');

  HOTSPOT_AREAS: array[TLMDHotSpotKind] of TLMDActiveAreas = (
    [hsaSiteLeft],   // hsLeft
    [hsaSiteTop],    // hsTop
    [hsaSiteRight],  // hsRight
    [hsaSiteBottom], // hsBottom
    [hsaZoneLeft, hsaZoneTop, hsaZoneRight, hsaZoneBottom,
     hsaDocsLeft, hsaDocsTop, hsaDocsRight, hsaDocsBottom,
     hsaTabs]        // hsCenter
  );

  CUT_MODES: array[Boolean, Boolean] of TCutMode = (
    (cmAll, cmLast),
    (cmAll, cmNone)
  );

{ ---------------------------------------------------------------------------- }
var
  SiteList:             TLMDDockSite;    // Linked lists.
  MgrList:              TLMDDockManager; //
  DefDockElems:         TLMDDockElems;
  ZOrderer:             TZOrderer;
  Animator:             TAnimator;
  PanelsHook:           HHOOK;
  PanelsHookRefCount:   Integer;

{ ---------------------------------------------------------------------------- }
function GetDefDockElems(AManager: TLMDDockManager): TLMDDockElems;
var
  de: TLMDDockElems;
begin
  if AManager <> nil then
    Result := AManager.DockElems
  else
  begin
    if DefDockElems = nil then
    begin
      de := TLMDDockElems.Create;
      try
        de.Style     := DockStyles.DefaultStyle;
        DefDockElems := de;
      except
        de.Free;
        raise;
      end;
    end;
    Result := DefDockElems;
  end;
end;

{ ---------------------------------------------------------------------------- }
function LMDGetClientCaption(AClient: TControl): TLMDString;
var
  i: Integer;
  s: string;
begin
  if AClient = nil then
    Result := ''
  else if AClient is TLMDDockPanel then
    Result := TLMDDockPanel(AClient).Caption
  else if AClient is TCustomForm then
    Result := TCustomForm(AClient).Caption
  else
  begin
    SetString(s, nil, AClient.GetTextLen + 1);
    AClient.GetTextBuf(PChar(s), Length(s));

    for i := 1 to Length(s) do // Search for first CR/LF.
      if Byte(s[i]) in [13, 10] then
      begin
        SetLength(s, i - 1);
        Break;
      end;

    Result := s;
  end;
end;

{ ---------------------------------------------------------------------------- }
function PanelsHookProc(Code: Integer; wparam: WPARAM;
  Msg: PCWPRetStruct): Longint; stdcall;
var
  i:    Integer;
  site: TLMDDockSite;
  pnl:  TLMDDockPanel;
  {$IFNDEF LMDCOMP11}
  mfrm: TForm;
  {$ENDIF}
begin
  if Code = HC_ACTION then
  begin
    case Msg.Message of
      WM_ACTIVATE,
      CM_ACTIVATE,
      CM_DEACTIVATE:  begin
                        site := SiteList;
                        while site <> nil do
                        begin
                          for i := 0 to site.PanelCount - 1 do
                          begin
                            pnl := site.Panels[i];
                            if pnl.FLastCheckActive <> pnl.Active then
                              pnl.ActiveChanged;
                          end;
                          site := site.FNext;
                        end;
                      end;
      {$IFNDEF LMDCOMP11}
      WM_SHOWWINDOW:  begin
                        // For old Delphi versions this code helps to
                        // hide floating forms (with their glows) on
                        // application minimization.

                        mfrm := Application.MainForm;
                        if (mfrm <> nil) and mfrm.HandleAllocated and
                           (Msg.hwnd = mfrm.Handle) then
                        begin
                          case Msg.lParam of
                            SW_PARENTCLOSING:
                              ShowOwnedPopups(mfrm.Handle, False);
                            SW_PARENTOPENING:
                              ShowOwnedPopups(mfrm.Handle, True);
                          end;
                        end;
                      end;
      {$ENDIF}
    end;
  end;

  Result := CallNextHookEx(PanelsHook, Code, WParam, LPARAM(Msg));
end;

{ ---------------------------------------------------------------------------- }
procedure NotifyDesigner(AControl: TControl);
var
  frm: TcustomForm;
begin
  if (csDesigning in AControl.ComponentState) and
     not (csLoading in AControl.ComponentState) and
     not (csUpdating in AControl.ComponentState) then
  begin
    frm := GetParentForm(AControl);
    if (frm <> nil) and (frm.Designer <> nil) then
      frm.Designer.Modified;
  end;
end;

{ ---------------------------------------------------------------------------- }
function IsSinglePanelFloatingSite(ASite: TWinControl;
  out APanel: TLMDDockPanel): Boolean;
var
  site: TLMDDockSite;
  pnl:  TLMDDockPanel;
  i:    Integer;
begin
  if (ASite is TLMDDockSite) and TLMDDockSite(ASite).IsFloatingSite then
  begin
    site := TLMDDockSite(ASite);
    pnl  := nil;

    for i := 0 to site.PanelCount - 1 do
      if site.Panels[i].PanelVisible then
      begin
        if pnl <> nil then
        begin
          Result := False;
          Exit;
        end;
        pnl := site.Panels[i];
      end;

    APanel := pnl;
    Result := (APanel <> nil);
  end
  else
    Result := False;
end;

{ ---------------------------------------------------------------------------- }
procedure DesignAutoConnect(ACreating: TComponent);
var
  ownr:  TComponent;
  i:     Integer;
  c:     TComponent;
  mgr:   TLMDDockManager;
  sites: TList;
  site:  TLMDDockSite;
begin
  ownr := ACreating.Owner;
  if ownr = nil then
    Exit;

  mgr   := nil;
  sites := TList.Create;
  try
    for i := 0 to ownr.ComponentCount - 1 do
    begin
      c := ownr.Components[i];

      if not (csLoading in c.ComponentState) then
      begin
        if c is TLMDDockSite then
        begin
          site := TLMDDockSite(c);
          if site.Manager = nil then
            sites.Add(site);
        end
        else if c is TLMDDockManager then
        begin
          if mgr = nil then
            mgr := TLMDDockManager(c)
          else
            mgr := TLMDDockManager(1); // More that one manager.
        end;
      end;
    end;

    if (mgr = nil) or (mgr = TLMDDockManager(1)) then
      Exit;

    for i := 0 to sites.Count - 1 do
    begin
      site := TLMDDockSite(sites[i]);
      if (ACreating = site) or (ACreating = mgr) then
        site.Manager := mgr;
    end;
  finally
    sites.Free;
  end;
end;

{ ****************************** TLMDDragObject ****************************** }
{ ---------------------------------------------------------------------------- }
procedure TLMDDragObject.AdjustDockRect(ARect: TRect);
begin
  Init;
  DockRect := Rect(DragPos.X - FXOffset, DragPos.Y - FYOffset,
                   DragPos.X - FXOffset + FRWidth,
                   DragPos.Y - FYOffset + FRHeight);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDragObject.DrawDragDockImage;
var
  accpt:   Boolean;
  swnfrom: TRect;
begin
  if FInited then
  begin
    accpt := FAccepted and FAcceptedExt;

    if not FDragContent or accpt then
    begin
      if FDockingRect = nil then
        FDockingRect := TDockingRect.Create(nil);

      if FDragForm <> nil then
      begin
        swnfrom        := FDragForm.BoundsRect;
        swnfrom.Bottom := swnfrom.Top + GetSystemMetrics(SM_CYSMCAPTION);
      end
      else
        swnfrom := TDockingRect(FDockingRect).BoundsRect;

      TDockingRect(FDockingRect).Show(@swnfrom, DockRect, FTabInRect,
                                      FBackColor, FBorderColor, accpt,
                                      FAnimateRect);
    end
    else if FDragContent and (FDockingRect <> nil) then
      TDockingRect(FDockingRect).Hide;

    if FDragForm <> nil then
      FDragForm.SetDraggingMode(True, accpt);

    UpdateDragFormPos(DragPos); // For sure.
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDragObject.EraseDragDockImage;
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }
function TLMDDragObject.GetDragCursor(Accepted: Boolean; X,
  Y: Integer): TCursor;
begin
  FAccepted := Accepted;
  Result    := inherited GetDragCursor(Accepted, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDragObject.Init;
var
  site:  TLMDDockSite;
  fscls: TWinControlClass;
  frm:   TLMDFloatingForm;
  pnl:   TLMDDockPanel;
begin
  if not FInited then
  begin
    FInited := True;
    site    := ControlSite;
    fscls   := Control.FloatingDockSiteClass;

    if IsSinglePanelFloatingSite(site, pnl) then
    begin
      frm      := TLMDFloatingForm(site.Parent);
      FXOffset := frm.FDragStart.X {DragPos.X} - frm.Left;
      FYOffset := frm.FDragStart.Y {DragPos.Y} - frm.Top;
      FRWidth  := frm.Width;
      FRHeight := frm.Height;

      if FDragContent then
      begin
        FDragForm := frm;
        FDragForm.SetDraggingMode(True, False);
      end;
    end
    else
    begin
      if FDragContent and (fscls <> nil) and
         fscls.InheritsFrom(TLMDFloatingForm) then
      begin
        FDragForm            := TLMDFloatingForm(fscls.Create(Application));
        FDragForm.BoundsRect := DockRect;

        FDragForm.ActivateOnNextShow; // Before DockControl.
        FDragForm.Site.DockControl(Control);
        FDragForm.SetDraggingMode(True, False);

        pnl := FDragForm.Site.FindPanelByClient(Control);
        if pnl <> nil then
          pnl.Activate(True);
      end;

      FXOffset := DragPos.X - DockRect.Left;
      FYOffset := DragPos.Y - DockRect.Top;
      FRWidth  := DockRect.Right - DockRect.Left;
      FRHeight := DockRect.Bottom - DockRect.Top;
    end;

    // Ensure that the drag-point is inside the form's caption. Otherwise,
    // dragging process will not find dock sites, because the form's child
    // controls are not transparent (HTTRANSPARENT).
    // Drag-point can be originally outside of the form's caption because of
    // fast mouse moving or because of undocking by site's tabs dragging.

    if FXOffset < 2 then
      FXOffset := 2
    else if FXOffset > FRWidth then
      FXOffset := FRWidth - 2;

    if FYOffset < 0 then
      FYOffset := 2
    else if FYOffset > GetSystemMetrics(SM_CYSMCAPTION) then
      FYOffset := GetSystemMetrics(SM_CYSMCAPTION) - 2;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDragObject.UpdateDragFormPos(const P: TPoint);
begin
  if FDragForm <> nil then
  begin
    FDragForm.BoundsRect := Rect(P.X - FXOffset, P.Y - FYOffset,
                                 P.X - FXOffset + FRWidth,
                                 P.Y - FYOffset + FRHeight);
    ZOrderer.UpdateZOrder;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDragObject.WndProc(var Msg: TMessage);
begin
  // We have to update FDragForm position BEFORE any other docking actions.
  // Otherwise, it will be possible for the cursor to be over the dragging
  // form *content*. We can mark the form itself transparent (HTTRANSPARENT),
  // but, because of the child controls, it will NOT be fully transparent for
  // the dragging operation anyway.

  if Msg.Msg = WM_MOUSEMOVE then
    UpdateDragFormPos(Mouse.CursorPos);
  FAcceptedExt := True;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDragObject.EndDrag(Target: TObject; X, Y: Integer);
begin
  if FDockingRect <> nil then
    TDockingRect(FDockingRect).Hide;

  inherited;

  if (FDragForm <> nil) and not FDragForm.IsEmpty then
    FDragForm.SetDraggingMode(False, False);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDragObject.ControlSite: TLMDDockSite;
begin
  if Control.HostDockSite is TLMDDockSite then
    Result := TLMDDockSite(Control.HostDockSite)
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDDragObject.Create(AControl: TControl);
begin
  inherited;
  FDragContent := True;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDragObject.Destroy;
begin
  FDockingRect.Free;
  inherited;
end;

{ ****************************** TLMDFloatingForm **************************** }
{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
  MouseCapture := False;
  FState       := FState - [ffsPopupPending];
  CancelTracking;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := -1;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
begin
  with Message.MinMaxInfo^.ptMinTrackSize do
  begin
    X := 128;  // We set here more adequate min size, like in MS VS. However,
    Y := 40;   // this code is REQUIRED, because in case of custom border
               // DefWinProc sets min size to (0, 0) by default (in inherited).
  end;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.WMLButtonDown(var Message: TWMLButtonDown);
begin
  UpdateTracking(True, False);
  inherited;
end;

procedure TLMDFloatingForm.WMLButtonUp(var Message: TWMLButtonUp);
begin
  UpdateTracking(False, True);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.WMMouseMove(var Message: TWMMouseMove);
begin
  inherited;
  UpdateTracking(False, False);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.WMMove(var Message: TWMMove);
begin
  inherited;
  if FSite.FManager <> nil then
    FSite.FManager.DoLayoutChange;
  UpdateGlows;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.WMActivate(var Message: TWMActivate);
begin
  inherited;
  UpdateGlows(True);
  Invalidate;
  {$IFDEF LMD_DCK_UPDATE}Update;{$ENDIF}
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.WMNCHitTest(var Message: TWMNCHitTest);
const
  BRD_SIZES: array[0..2, 0..3] of Integer = (
    (HTTOPLEFT,   HTLEFT,     HTLEFT,     HTBOTTOMLEFT),
    (HTTOP,       HTCAPTION,  HTCLIENT,   HTBOTTOM),
    (HTTOPRIGHT,  HTRIGHT,    HTRIGHT,    HTBOTTOMRIGHT)
  );
var
  xidx, yidx: Integer;
  p:          TPoint;
  br:         TRect;
  hdr:        TRect;
begin
  with Message do
  begin
    if ffsDragging in FState then
      Result := HTTRANSPARENT
    else if BorderStyle = bsNone then
    begin
      p := ScreenToClient(Point(XPos, YPos));

      if FindButtonAtPoint(p) <> pbNone then
        Result := HTCLIENT // Don't know what to use.
      else
      begin
        if (FKind = ffPanel) and (FSinglePanel <> nil) then
        begin
          hdr := FSinglePanel.FHeaderArea;
          MapWindowPoints(FSinglePanel.Handle, Handle, hdr, 2);
        end
        else
          hdr := FHeader;

        br     := FContent;
        br.Top := Max(hdr.Top, Min(4, hdr.Bottom));
        xidx   := 1 - Ord(p.X < br.Left) + Ord(p.X >= br.Right);
        yidx   := 2 - Ord(p.Y < br.Top) - Ord(p.Y < hdr.Bottom) +
                  Ord(p.Y >= br.Bottom);
        Result := BRD_SIZES[xidx, yidx];
      end;
    end
    else
      inherited;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.WMNCLButtonDown(var Message: TWMNCLButtonDown);
var
  pnl: TLMDDockPanel;
begin
  if (WindowState = wsNormal) and (Message.HitTest = HTCAPTION) and
     TFloatingSite(FSite).FormHeaderDrag(pnl) then
  begin
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
                 SWP_NOMOVE or SWP_NOSIZE); // Activate.
    if Active then
    begin
      FDragStart := Mouse.CursorPos; // This fixes the bug with shifting cursor
                                     // point relative to the real starting drag
                                     // point, which happens in cases of very
                                     // fast mouse movements due to BeginDrag
                                     // mouse threshold.
      pnl.GetDockClient.BeginDrag(False);
      pnl.AdjustDockSizes; // Adjust dock sizes,
                           // after BeginDrag.
    end;
  end
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.WMNCMouseMove(var Message: TWMNCMouseMove);
begin
  inherited;
  UpdateTracking(False, False);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.WMNCRButtonDown(var Message: TWMNCRButtonDown);
begin
  if (Message.HitTest = HTCAPTION) and not MouseCapture and
     (FSinglePanel <> nil) and FSinglePanel.CanHeaderPopup then
  begin
    MouseCapture := True;
    Include(FState, ffsPopupPending);
  end
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.WMRButtonUp(var Message: TWMRButtonUp);
var
  p: TPoint;
begin
  if ffsPopupPending in FState then
  begin
    p            := ClientToScreen(Point(Message.XPos, Message.YPos));
    MouseCapture := False;
    Exclude(FState, ffsPopupPending);

    if SysHitTest(p) = HTCAPTION then
      FSite.Panels[0].HeaderPopup(p);
    UpdateTracking(False, False);
  end
  else
    inherited;
end;

procedure TLMDFloatingForm.WMSize(var Message: TWMSize);
begin
  inherited;
  UpdateGlows;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.WMTimer(var Message: TMessage);
begin
  UpdateTracking(False, False);
end;

procedure TLMDFloatingForm.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  //  UpdateGlows - Call from here will introduce bugs in
  //  forms activating/z-order.
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.WMNCLButtonDblClk(
  var Message: TWMNCLButtonDblClk);
var
  p:   TPoint;
  pnl: TLMDDockPanel;
begin
  p := Point(Message.XCursor, Message.YCursor);

  if (BorderStyle = bsNone) and (SysHitTest(p) = HTCAPTION) then
  begin
    if (not IsSinglePanelFloatingSite(FSite, pnl) or
        not pnl.DoHeaderDblClick) and
       (pbMaximize in FButtons) then
      TFloatingSite(FSite).HeaderBtnClick(pbMaximize);
  end
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.SetDraggingMode(const ADragging,
  AAccepted: Boolean);
begin
  if (IsDragging <> ADragging) or (IsAccepted <> AAccepted) then
  begin
    FSite.DockSite := not ADragging;
    FState         := FState - [ffsDragging, ffsAccepted];

    if ADragging then
      Include(FState, ffsDragging);
    if AAccepted then
      Include(FState, ffsAccepted);

    ZOrderer.UpdateZOrder;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.SiteNotification;
begin
  if not IsEmpty then
  begin
    Visible := HasVisiblePanels;
    UpdateBorder;
    UpdateGlows(True);
  end
  else
    Release;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFloatingForm.StyleElems: TLMDDockElems;
begin
  Result := GetDefDockElems(FSite.Manager);
end;

{ ---------------------------------------------------------------------------- }
function TLMDFloatingForm.SysHitTest(const P: TPoint): LRESULT;
var
  prm: LPARAM;
begin
  prm := 0;
  PSmallPoint(@prm)^ := PointToSmallPoint(p);
  Result             := SendMessage(WindowHandle, WM_NCHITTEST, 0, prm);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.UpdateBorder;
const
  SYS_BORDER: array[TLMDFloatBorderKind] of TFormBorderStyle = (
    bsSizeable,
    bsSizeToolWin,
    bsNone
  );
  SYS_ICONS: array[TLMDPanelBtnKind] of TBorderIcons = (
    [],             // pbMenu
    [],             // pbPin
    [biMaximize],   // pbMaximize
    [biSystemMenu]  // pbClose
  );
var
  ff:    TLMDFloatFrameBase;
  fb:    TLMDFrameBtnBase;
  b:     TLMDPanelBtnKind;
  bicns: TBorderIcons;
begin
  if ffsUpdatingBorder in FState then // Needed for Delphi 6.
    Exit;                             //

  Include(FState, ffsUpdatingBorder);
  try
    FKind := TFloatingSite(FSite).GetFormKind(FSinglePanel);

    if FSinglePanel <> nil then
      Caption := FSinglePanel.Caption
    else
      Caption := '';

    ff       := StyleElems.GetForm(FKind);
    FButtons := [];

    TFloatingSite(FSite).GetHeaderBtns(FButtons);
    BorderStyle := SYS_BORDER[ff.BorderKind];

    if ff.BorderKind = fbCustom then
    begin
      ff.GetAreas(ClientRect, Font, FHeader, FContent);
      if ff.HasCaption then
      begin
        fb := StyleElems.GetFormButton(FKind);
        fb.GetAreas(FHeader, FButtons, FButtonsData);
      end
      else
        FButtonsData.Kinds := [];
    end
    else
    begin
      FHeader  := Rect(0, 0, 0, 0);
      FContent := ClientRect;
      bicns    := [];

      for b := Low(TLMDPanelBtnKind) to High(TLMDPanelBtnKind) do
      begin
        if b in FButtons then
          bicns := bicns + SYS_ICONS[b];
      end;
      BorderIcons := bicns;
    end;

    AdjustWindowRgn;
    Realign;
    Invalidate;
  finally
    Exclude(FState, ffsUpdatingBorder);
  end;
end;

procedure TLMDFloatingForm.UpdateGlows(AForceRedraw: Boolean);
var
  a: TAlign;
begin
  for a := Low(TAlign) to High(TAlign) do
  begin
    if FGlows[a] <> nil then
      TGlow(FGlows[a]).Update(AForceRedraw);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.UpdateTracking(AMouseDown,
  AMouseUp: Boolean);
var
  p:        TPoint;
  btn, old: TLMDPanelBtnKind;
  olddown:  Boolean;
begin
  if BorderStyle <> bsNone then
    Exit;

  with FButtonsData do
  begin
    p       := ScreenToClient(Mouse.CursorPos);
    btn     := FindButtonAtPoint(p);
    old     := Hot;
    olddown := HotDown;

    if AMouseDown then
    begin
      Hot     := btn;
      HotDown := (Hot <> pbNone);
    end
    else if AMouseUp then
    begin
      if (btn <> pbNone) and (Hot = btn) and HotDown then
        TFloatingSite(FSite).HeaderBtnClick(btn);

      Hot     := pbNone;
      HotDown := False;
    end
    else if not HotDown then
      Hot := btn;

    if Hot <> pbNone then
      SetTimer(Handle, 1, 50, nil)
    else
      KillTimer(Handle, 1);

    if HandleAllocated and (old <> Hot) or (olddown <> HotDown) then
    begin
      if (old <> pbNone) then
        InvalidateRect(Handle, @Buttons[old], True);
      if (Hot <> pbNone) then
        InvalidateRect(Handle, @Buttons[FButtonsData.Hot], True);
    end;
  end;
end;

procedure TLMDFloatingForm.VisibleChanging;
begin
  inherited;
  UpdateGlows;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.DoAddDockClient(Client: TControl;
  const ARect: TRect);
begin
  FSite.DockControl(Client); // This code is required for
                             // ManualFloat support.
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.DoClose(var Action: TCloseAction);
var
  i:   Integer;
  pnl: TLMDDockPanel;
begin
  for i := 0 to FSite.PanelCount - 1 do
  begin
    pnl := FSite.Panels[i];
    if pnl.PanelVisible then
      pnl.InternalClose; // CloseQuery is already called for all
                         // panels, so do not call it second time.
  end;
  Action := caNone;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.DoShow;
begin
  if not (ffsActivatePending in FState) then
  begin
    // This code called from TCustomForm.CMShowingChanged. It allows to
    // prevent form activation while showing. Docking form should not be
    // activated, for example, on layout loading or ManualFloat.

    ShowWindow(Handle, SW_SHOWNOACTIVATE);
    UpdateGlows;
    Exclude(FState, ffsActivatePending);
  end;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFloatingForm.FindButtonAtPoint(
  const P: TPoint): TLMDPanelBtnKind;
var
  i: TLMDPanelBtnKind;
begin
  with FButtonsData do
  begin
    Result := pbNone;
    if BorderStyle <> bsNone then
      Exit;

    for i := Low(TLMDPanelBtnKind) to High(TLMDPanelBtnKind) do
      if (i in Kinds) and PtInRect(Buttons[i], P) then
      begin
        Result := i;
        Exit;
      end;
  end;
end;

procedure TLMDFloatingForm.FreeGlows;
begin
  FreeAndNil(FGlows[alLeft]);
  FreeAndNil(FGlows[alTop]);
  FreeAndNil(FGlows[alRight]);
  FreeAndNil(FGlows[alBottom]);
end;

{ ---------------------------------------------------------------------------- }
function TLMDFloatingForm.HasVisiblePanels: Boolean;
var
  i: Integer;
begin
  for i := 0 to FSite.PanelCount - 1 do
    if FSite.Panels[i].PanelVisible then
    begin
      Result := True;
      Exit;
    end;
  Result := False;
end;

procedure TLMDFloatingForm.InitGlows;
begin
  if FGlows[alLeft] = nil then // Not inited.
  begin
    FGlows[alLeft]   := TGlow.Create(Self, alLeft);
    FGlows[alTop]    := TGlow.Create(Self, alTop);
    FGlows[alRight]  := TGlow.Create(Self, alRight);
    FGlows[alBottom] := TGlow.Create(Self, alBottom);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFloatingForm.GetIsAccepted: Boolean;
begin
  Result := (ffsAccepted in FState);
end;

{ ---------------------------------------------------------------------------- }
function TLMDFloatingForm.GetIsDragging: Boolean;
begin
  Result := (ffsDragging in FState);
end;

{ ---------------------------------------------------------------------------- }
function TLMDFloatingForm.GetIsEmpty: Boolean;
begin
  Result := (FSite.PanelCount = 0);
end;

{ ---------------------------------------------------------------------------- }
function TLMDFloatingForm.GetIsTopmost: Boolean;
begin
  Result := HandleAllocated and (GetWindowLong(Handle, GWL_EXSTYLE) and
                                 WS_EX_TOPMOST <> 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.Paint;
const
  STATES: array[Boolean, Boolean] of TLMDFrameBtnState = (
    ([],          [fbsMaximized]),
    ([fbsActive], [fbsActive, fbsMaximized])
  );
var
  ff:   TLMDFloatFrameBase;
  fc:   TLMDCaptionFrameBase;
  fb:   TLMDFrameBtnBase;
  actv: Boolean;
  cr:   TRect;
  s:    TLMDString;
  imgs: TCustomImageList;
  idx:  Integer;

  function ShowImage(out AImages: TCustomImageList;
                     out AIndex: Integer): Boolean;
  var
    sp: TLMDDockPanel;
    pe: TLMDPanelElem;
  begin
    sp := FSinglePanel;

    if sp <> nil then
    begin
      pe     := sp.StyleElems.Panel;
      Result := (((sp.FShowHeaderImage = hiDefault) and pe.ShowHeaderImage) or
                 (sp.FShowHeaderImage = hiShow)) and
                (sp.FImages <> nil) and (sp.FImageIndex >= 0) and
                (sp.FImageIndex < sp.FImages.Count);
      if Result then
      begin
        AImages := sp.FImages;
        AIndex  := sp.FImageIndex;
      end;
    end
    else
      Result := False;
  end;

begin
  if BorderStyle = bsNone then
  begin
    actv := inherited Active;
    ff   := StyleElems.GetForm(FKind);

    ff.GetFrame(actv).Draw(Canvas, ClientRect);

    if ff.HasCaption then
    begin
      fc := TLMDCaptionFrameBase(ff);
      cr := fc.CaptionContent.AdjustRect(FHeader);

      fc.GetCaption(actv).Draw(Canvas, FHeader);

      fb := StyleElems.GetFormButton(FKind);
      fb.Draw(Canvas, FButtonsData, STATES[actv, WindowState = wsMaximized]);
      cr.Right := Min(cr.Right, FButtonsData.Group.Left);

      if ShowImage(imgs, idx) and (cr.Right - cr.Left >= imgs.Width) then
      begin
        imgs.Draw(Canvas, cr.Left, (cr.Top + cr.Bottom -
                  imgs.Height) div 2, idx);
        Inc(cr.Left, imgs.Width + STD_INDENT);
      end;

      if cr.Right - cr.Left > 0 then
      begin
        s                 := Caption;
        Canvas.Font.Color := fc.GetTextColor(actv);

        SetBkMode(Canvas.Handle, TRANSPARENT);
        LMDDrawTextWithElipsis(Canvas, s, cr);
        Inc(cr.Left, Canvas.TextWidth(s));
      end;

      cr := fc.FillerMargins.AdjustRect(cr);
      if cr.Right - cr.Left > 0 then
        fc.GetFiller(actv).Draw(Canvas, cr);
    end;
  end
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.Resize;
begin
  UpdateBorder;
  if FSite.FManager <> nil then
    FSite.FManager.DoLayoutChange;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.ActivateOnNextShow;
begin
  Include(FState, ffsActivatePending);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.AdjustClientRect(var Rect: TRect);
begin
  inherited;
  Rect := FContent;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.AdjustWindowRgn;
var
  ff:  TLMDFloatFrameBase;
  rgn: HRGN;
begin
  if HandleAllocated then
  begin
    if BorderStyle = bsNone then
    begin
      ff  := StyleElems.GetForm(FKind);
      rgn := ff.WindowRegion.MakeRegion(Bounds(0, 0, Width, Height));
    end
    else
      rgn := 0;

    if (rgn <> 0) or FRgnSet then
    begin
      SetWindowRgn(WindowHandle, rgn, True);
      DeleteObject(rgn);
      FRgnSet := (rgn <> 0);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.CancelTracking;
var
  old: TLMDPanelBtnKind;
begin
  if BorderStyle <> bsNone then
    Exit;
  with FButtonsData do
  begin
    old     := Hot;
    Hot     := pbNone;
    HotDown := False;

    if HandleAllocated and (old <> pbNone) then
      InvalidateRect(Handle, @Buttons[old], True);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFloatingForm.ChooseManager: TLMDDockManager;
var
  mgr: TLMDDockManager;
begin
  mgr := MgrList;
  while mgr <> nil do
  begin
    if mgr.AttachFloatingSite(FSite) then
    begin
      Result := mgr;
      Exit;
    end;
    mgr := mgr.FNext;
  end;
  Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFloatingForm.CloseQuery: Boolean;
var
  i:   Integer;
  pnl: TLMDDockPanel;
begin
  for i := 0 to FSite.PanelCount - 1 do
  begin
    pnl := FSite.Panels[i];
    if not pnl.CloseQuery then
    begin
      Result := False;
      Exit;
    end;
  end;
  Result := True;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDFloatingForm.Create(AOwner: TComponent);
begin
  CreateEx(AOwner, ChooseManager);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDFloatingForm.CreateEx(AOwner: TComponent;
  AManager: TLMDDockManager);
begin
  CreateNew(AOwner);

  AutoScroll           := False;
  Position             := poDesigned;
  DefaultMonitor       := dmDesktop;
  FSite                := TFloatingSite.Create(nil);
  FSite.UseSpace       := False;
  FSite.Align          := alClient;
  FSite.Parent         := Self;
  FSite.Manager        := AManager;
  FButtonsData.Hot     := pbNone;
  FButtonsData.HotDown := False;

  TFloatingSite(FSite).FForm := Self;
  ZOrderer.AddWindow(Self);
  UpdateBorder;

  if FSite.FManager <> nil then
  begin
    FSite.FManager.FloatingSiteCreated(FSite);
    FSite.FManager.DoLayoutChange;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  {$IFNDEF LMDCOMP11}
  if (Params.WndParent = Application.Handle) and
     (Application.MainForm <> nil) then
    Params.WndParent := Application.MainForm.Handle;
  {$ENDIF}
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatingForm.CreateWnd;
begin
  inherited;
  AdjustWindowRgn;
  ZOrderer.UpdateZOrder;
  InitGlows;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDFloatingForm.Destroy;
begin
  if FSite.FManager <> nil then
  begin
    FSite.FManager.FloatingSiteDestroying(FSite);
    FSite.FManager.DoLayoutChange;
  end;

  FreeGlows;
  FSite.Free; // Free before inherited.
  ZOrderer.RemoveWindow(Self);
  inherited;
end;

procedure TLMDFloatingForm.DestroyWnd;
begin
  inherited;
  FreeGlows;
end;

{ ******************************* TLMDDockPanel ****************************** }
{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.WMPaint(var Message: TWMPaint);
begin
  {$IFDEF LMDCOMP11}
  if (csDesigning in ComponentState) and not Showing and
     HandleAllocated and IsWindowVisible(Handle) then
    Perform(CM_SHOWINGCHANGED, 0, 0);
  {$ENDIF}
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := -1;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.WMNCHitTest(var Message: TWMNCHitTest);
var
  p: TPoint;
begin
  if FSite <> nil then
  begin
    p := SmallPointToPoint(Message.Pos);
    MapWindowPoints(0, FSite.Handle, p, 1);

    if FSite.WantsTransparency(p) then
      Message.Result := HTTRANSPARENT
    else
      inherited;
  end
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.WMSetCursor(var Message: TWMSetCursor);
const
  SPLTR_CURSORS: array[Boolean] of TCursor = (crHSplit, crVSplit);
var
  ms: TPoint;
begin
  GetCursorPos(ms);
  ms := ScreenToClient(ms);

  if psDesignDrag in FState then
  begin
    Windows.SetCursor(Screen.Cursors[crDrag]);
  end
  else if PtInRect(FSpltrArea, ms) and
          ((FSite = nil) or not (dlmSplitterResize in FSite.FLockMode)) then
  begin
    Windows.SetCursor(Screen.Cursors[
      SPLTR_CURSORS[FSpltrSide in [alTop, alBottom]]]);
  end
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.WMTimer(var Message: TMessage);
begin
  UpdateTracking(False, False);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
  CancelTracking;
  CancelDesignDrag(FSite);
end;

procedure TLMDDockPanel.WMWindowPosChanged(
  var Message: TWMWindowPosChanged);
begin
  inherited;
  AdjustDockSizes; // Adjust dock sizes, after inherited.
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.WMContextMenu(var Message: TWMContextMenu);
var
  p: TPoint;
begin
  p := SmallPointToPoint(Message.Pos);
  if PtInRect(FHeaderArea, ScreenToClient(p)) then
    HeaderPopup(p)
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.CMEnter(var Message: TCMEnter);
begin
  inherited;
  ActiveChanged;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.CMExit(var Message: TCMExit);
begin
  inherited;
  ActiveChanged;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.CMFloat(var Message: TCMFloat);
var
  fscls: TWinControlClass;
  form:  TLMDFloatingForm;
  pnl:   TLMDDockPanel;
begin
  if IsSinglePanelFloatingSite(FSite, pnl) then
  begin
    form            := TLMDFloatingForm(FSite.Parent);
    form.BoundsRect := Message.DockSource.DockRect;
  end
  else
  begin
    fscls := TLMDFloatingForm;
    if FloatingDockSiteClass.InheritsFrom(TLMDFloatingForm) then
      fscls := FloatingDockSiteClass;

    form            := TLMDFloatingForm(fscls.Create(Application));
    form.BoundsRect := Message.DockSource.DockRect;
    form.FSite.DockControl(Self);
  end;

  Activate(True);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.CMFontChanged(var Message: TMessage);
begin
  inherited;
  if FDefaultFontColor and (Font.Color <> GetDefFontColor) and
     not (psUpdatingColors in FState) and
     not (psUpdatingParentFont in FState) then
    FDefaultFontColor := False;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.CMTextChanged(var Message: TMessage);
begin
  inherited;
  if FSite <> nil then
  begin
    FSite.UpdateLayout;
    FSite.PanelUIStateChanged(Self);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.InternalSetLoadingSite(const Value: TLMDDockSite);
begin
  if Value <> FLoadingSite then
  begin
    if FLoadingSite <> nil then
      FLoadingSite.FLoadingPanels.Remove(Self);
    FLoadingSite := Value;
    if FLoadingSite <> nil then
      FLoadingSite.FLoadingPanels.Add(Self);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.InternalSetToSite(const Value: TLMDDockSite;
  ADockTask: TObject);
var
  old: TLMDDockSite;
begin
  old := FSite;
  if (FSite <> nil) and (FSite <> Value) then
    FSite.RemovePanel(Self);
  if Value <> nil then
    Value.InsertOrUpdatePanel(Self, ADockTask);

  if FSite <> old then
  begin
    UpdateVisible;
    Realign;
  end;
end;

procedure TLMDDockPanel.InvalidateBorder(FOldContent: TRect);
type
  TRegionData = record
    Header: RGNDATAHEADER;
    Rects:  array[0..3] of TRect;
  end;
var
  cr:  TRect;
  dt:  TRegionData;
  rgn: HRGN;
  cnt: TRect;
begin
  if HandleAllocated then
  begin
    cr  := ClientRect;
    cnt := FContent;

    if cnt.Left < FOldContent.Left then
      cnt.Left := FOldContent.Left;
    if cnt.Top < FOldContent.Top then
      cnt.Top := FOldContent.Top;
    if cnt.Right > FOldContent.Right then
      cnt.Right := FOldContent.Right;
    if cnt.Bottom > FOldContent.Bottom then
      cnt.Bottom := FOldContent.Bottom;

    dt.Header.dwSize   := SizeOf(RGNDATAHEADER);
    dt.Header.iType    := RDH_RECTANGLES;
    dt.Header.nCount   := 4;
    dt.Header.nRgnSize := 0;
    dt.Header.rcBound  := cr;

    dt.Rects[0] := Rect(cr.Left, cr.Top, cr.Right, cnt.Top);
    dt.Rects[1] := Rect(cr.Left, cnt.Top, cnt.Left, cnt.Bottom);
    dt.Rects[2] := Rect(cnt.Right, cnt.Top, cr.Right, cnt.Bottom);
    dt.Rects[3] := Rect(cr.Left, cnt.Bottom, cr.Right, cr.Bottom);

    rgn := ExtCreateRegion(nil, SizeOf(TRegionData), PRGNDATA(@dt)^);
    InvalidateRgn(Handle, rgn, False);
    DeleteObject(rgn);
  end;
end;

procedure TLMDDockPanel.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  p: TPoint;
begin
  p := Point(X, Y);

  if (Button = mbLeft) and (FSite <> nil) and PtInRect(FSpltrArea, p) and
     ((FSite = nil) or not (dlmSplitterResize in FSite.FLockMode)) then
  begin
    MapWindowPoints(Handle, FSite.Handle, p, 1);
    FSite.BeginSplitterSizing(Self, p);
  end
  else if (FSite = nil) or FSite.DeactivateActiveChild([], [Self]) then
  begin
    if CanFocus then
      Activate(False);
    UpdateTracking((Button = mbLeft), False);

    if not (ssDouble in Shift) and (Button = mbLeft) and
       PtInRect(FHeaderArea, p) and (FindButtonAtPoint(p) = pbNone) and
       not FButtonsData.HotDown then
    begin
      if csDesigning in ComponentState then
        UpdateDesignDrag(FSite, True, False, False, True, True,
                         ClientToScreen(p))
      else if (TControlAccess(GetDockClient).DragMode = dmAutomatic) and
              Application.AutoDragDocking and
              ((FSite = nil) or not (dlmUndockFrom in FSite.FLockMode)) then
      begin
        GetDockClient.BeginDrag(False);
        Exit; // No inherited.
      end;
    end;
  end;

  inherited;
end;

procedure TLMDDockPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  p: TPoint;
begin
  p := Point(X, Y);
  UpdateTracking(False, False);

  MapWindowPoints(Handle, 0, p, 1);
  UpdateDesignDrag(FSite, False, False, False, True, True, p);

  inherited;
end;

procedure TLMDDockPanel.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  p: TPoint;
begin
  p := Point(X, Y);
  UpdateTracking(False, True);

  MapWindowPoints(Handle, 0, p, 1);
  UpdateDesignDrag(FSite, False, True, False, True, True, p);

  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.InternalClose;
begin
  case DoClose of
    caNone: ; // Do nothing.
    caHide: PanelVisible := False;
    caFree: Release;
  end;
  NotifyDesigner(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.InternalResetSite;
begin
  if FSite <> nil then
  begin
    FSite.RemovePanel(Self);
    UpdateVisible;
    Realign;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockPanel.GetActive: Boolean;
begin
  // Here we should use global Screen.ActiveControl, instead of parent
  // form's ActiveControl, which means the active control of currently
  // active form.

  Result := not (csDesigning in ComponentState) and
            ContainsControl(Screen.ActiveControl);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockPanel.GetDefFontColor: TColor;
var
  site: TLMDDockSite;
  pe: TLMDPanelElem;
begin
  site := FSite;
  if site = nil then
    site := FLoadingSite;

  if site <> nil then
  begin
    pe     := site.StyleElems.Panel;
    Result := pe.DefaultFontColor;
  end
  else
    Result := clWindowText;
end;

function TLMDDockPanel.GetDockClient: TControl;
begin
  if FClientControl <> nil then
    Result := FClientControl
  else
    Result := Self;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.SetOnSiteShowing(const Value: Boolean);
begin
  if FOnSiteShowing <> Value then
  begin
    FOnSiteShowing := Value;
    UpdateVisible;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.UpdateVisible;
var
  vis: Boolean;
begin
  vis := ((FSite <> nil) and FOnSiteShowing) or
         ((FSite = nil) and PanelVisible);
  {$IFDEF LMDCOMP11}
  if vis and (csDesignerHide in ControlState) then
    vis := False;
  {$ENDIF}

  inherited Visible := vis;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockPanel.FindButtonAtPoint(const P: TPoint): TLMDPanelBtnKind;
var
  i: TLMDPanelBtnKind;
begin
  with FButtonsData do
  begin
    for i := Low(TLMDPanelBtnKind) to High(TLMDPanelBtnKind) do
      if (i in Kinds) and PtInRect(Buttons[i], P) then
      begin
        Result := i;
        Exit;
      end;
    Result := pbNone;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.UpdateTracking(AMouseDown, AMouseUp: Boolean);
var
  p:        TPoint;
  btn, old: TLMDPanelBtnKind;
  olddown:  Boolean;
begin
  with FButtonsData do
  begin
    p       := ScreenToClient(Mouse.CursorPos);
    btn     := FindButtonAtPoint(p);
    old     := Hot;
    olddown := HotDown;

    if not PanelVisible or (psDesignDrag in FState) or
       (psDesignDragPending in FState) then
    begin
      Hot     := pbNone;
      HotDown := False;
    end
    else if AMouseDown then
    begin
      Hot     := btn;
      HotDown := (Hot <> pbNone);
    end
    else if AMouseUp then
    begin
      if (FSite <> nil) and (btn <> pbNone) and
         (Hot = btn) and HotDown then
        FSite.PanelButtonClick(Self, btn);

      Hot     := pbNone;
      HotDown := False;
    end
    else if not HotDown then
      Hot := btn;

    if Hot <> pbNone then
      SetTimer(Handle, 1, 50, nil)
    else
      KillTimer(Handle, 1);

    UpdateMouseCapture;

    if HandleAllocated and (old <> Hot) or (olddown <> HotDown) then
    begin
      if (old <> pbNone) then
        InvalidateRect(Handle, @Buttons[old], True);
      if (Hot <> pbNone) then
        InvalidateRect(Handle, @Buttons[FButtonsData.Hot], True);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.CancelTracking;
var
  old: TLMDPanelBtnKind;
begin
  with FButtonsData do
  begin
    old     := Hot;
    Hot     := pbNone;
    HotDown := False;

    if HandleAllocated and (old <> pbNone) then
      InvalidateRect(Handle, @Buttons[old], True);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockPanel.CanHeaderPopup: Boolean;
begin
  Result := (FHeaderMenu <> nil) and FHeaderMenu.AutoPopup;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.Click;
var
  p: TPoint;
begin
  p := ScreenToClient(Mouse.CursorPos);
  if not PtInRect(FHeaderArea, p) then
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.Close;
begin
  if CloseQuery then
    InternalClose;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockPanel.CloseQuery: Boolean;
begin
  Result := (FSite = nil) or not
            (dlmPanelClose in FSite.FLockMode);
  if Assigned(FOnCloseQuery) then
    FOnCloseQuery(Self, Result);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.UpdateDesignDrag(ASite: TLMDDockSite; AMouseDown,
  AMouseUp, AImmediate, AUseCapture, AUseCursor: Boolean; const P: TPoint);
var
  imgbnds: TRect;
  showimg: Boolean;
  tbinrct: Boolean;
begin
  imgbnds := Rect(0, 0, 0, 0);
  showimg := False;
  tbinrct := False;

  if AMouseDown and not (psDesignDrag in FState) then
  begin
    if AImmediate then
      Include(FState, psDesignDrag)
    else
    begin
      Include(FState, psDesignDragPending);
      FDsgDragStart := P;
    end;
  end
  else if AMouseUp and ((psDesignDrag in FState) or
                        (psDesignDragPending in FState)) then
  begin
    if psDesignDrag in FState then
      ASite.DesignDrag(Self, dmDragDrop, P, imgbnds, showimg, tbinrct);
    FState := FState - [psDesignDrag, psDesignDragPending];
  end
  else if (psDesignDragPending in FState) and
          ((Abs(P.X - FDsgDragStart.X) > Mouse.DragThreshold) or
           (Abs(P.Y - FDsgDragStart.Y) > Mouse.DragThreshold)) then
  begin
    Exclude(FState, psDesignDragPending);
    Include(FState, psDesignDrag);
  end;

  if psDesignDrag in FState then
  begin
    if AUseCursor then
      Windows.SetCursor(Screen.Cursors[crDrag]);
    ASite.DesignDrag(Self, dmDragMove, P, imgbnds, showimg, tbinrct);
  end;

  if showimg then
  begin
    if FDsgDragRect = nil then
      FDsgDragRect := TDockingRect.Create(nil);
    TDockingRect(FDsgDragRect).Show(nil, imgbnds, tbinrct, $00DF9D84, clWhite,
                                    True, False);
  end
  else if FDsgDragRect <> nil then
    TDockingRect(FDsgDragRect).Hide;

  if AUseCapture then
    UpdateMouseCapture;
end;

procedure TLMDDockPanel.UpdateHook(AHook: BOolean);
begin
  if AHook then
  begin
    if PanelsHookRefCount = 0 then
      PanelsHook := SetWindowsHookEx(WH_CALLWNDPROCRET, @PanelsHookProc, 0,
                                     GetCurrentThreadID);
    Inc(PanelsHookRefCount);
  end
  else
  begin
    Dec(PanelsHookRefCount);
    if PanelsHookRefCount = 0 then
      UnhookWindowsHookEx(PanelsHook);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.CancelDesignDrag(ASite: TLMDDockSite);
var
  imgbnds: TRect;
  showimg: Boolean;
  tbinrct: Boolean;
begin
  if psDesignDrag in FState then
    ASite.DesignDrag(Self, dmDragCancel, Point(0, 0), imgbnds, showimg,
                     tbinrct);

  FState := FState - [psDesignDrag, psDesignDragPending];

  if FDsgDragRect <> nil then
    FreeAndNil(FDsgDragRect);
  UpdateMouseCapture;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.ImagesChange(Sender: TObject);
begin
  if HandleAllocated and FHaveHeader then
    InvalidateRect(Handle, @FHeaderArea, True);
  if FSite <> nil then
    FSite.UpdateLayout;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.SetImages(const Value: TCustomImageList);
begin
  if Value <> FImages then
  begin
    if FImages <> nil then
    begin
      FImages.UnRegisterChanges(FImageChangeLink);
      FImages.RemoveFreeNotification(Self);
    end;
    FImages := Value;
    if FImages <> nil then
    begin
      FImages.RegisterChanges(FImageChangeLink);
      FImages.FreeNotification(Self);
    end;

    ImagesChange(FImages);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.SetImageIndex(const Value: TImageIndex);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    if FImages <> nil then
      ImagesChange(FImages);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.SetClientKind(const Value: TLMDDockClientKind);
begin
  FClientKind := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.SetPanelVisible(const Value: Boolean);
begin
  if FPanelVisible <> Value then
  begin
    CancelTracking;
    FPanelVisible := Value;

    if FSite <> nil then
    begin
      if FSite.FloatingForm <> nil then
        FSite.FloatingForm.UpdateBorder;
      FSite.UpdateLayout(True);
      FSite.PanelUIStateChanged(Self);
    end;
    UpdateVisible;

    if FPanelVisible then
    begin
      if Assigned(FOnShow) then
        FOnShow(Self);
    end
    else
    begin
      if Assigned(FOnHide) then
        FOnHide(Self);
    end
  end;
end;

procedure TLMDDockPanel.SetParent(AParent: TWinControl);
var
  recrt: Boolean;
begin
  recrt := HandleAllocated;

  {$IFDEF LMDCOMP10}
  if recrt then
    UpdateRecreatingFlag(True);
  {$ENDIF}
  try
    if (Parent = nil) and recrt then
      DestroyHandle;
    inherited;
  finally
    {$IFDEF LMDCOMP10}
    if recrt then
      UpdateRecreatingFlag(False);
    {$ENDIF}
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.SetShowHeader(const Value: Boolean);
begin
  if FShowHeader <> Value then
  begin
    FShowHeader := Value;
    UpdateLayout;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.SetBorderStyle(const Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    UpdateLayout;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.SetButtons(const Value: TLMDPanelBtnKinds);
begin
  if FButtons <> Value then
  begin
    FButtons := Value;
    UpdateLayout;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.SetShowHeaderImage(
  const Value: TLMDDockPanelHdrImage);
begin
  if FShowHeaderImage <> Value then
  begin
    FShowHeaderImage := Value;
    UpdateLayout;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.SetHeaderMenu(const Value: TPopupMenu);
begin
  if FHeaderMenu <> Value then
  begin
    if FHeaderMenu <> nil then
      FHeaderMenu.RemoveFreeNotification(Self);
    FHeaderMenu := Value;
    if FHeaderMenu <> nil then
      FHeaderMenu.FreeNotification(Self);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockPanel.GetVisible: Boolean;
begin
  Result := inherited Visible;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.UpdateMouseCapture;
begin
  MouseCapture := FButtonsData.HotDown or (psDesignDrag in FState) or
                  (psDesignDragPending in FState);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.AdjustDockSizes;
var
  form: TLMDFloatingForm;
begin
  if Floating and (FSite <> nil) then
  begin
    form         := TFloatingSite(FSite).FForm;
    UndockHeight := form.Height;
    UndockWidth  := form.Width;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.HeaderPopup(const AMousePos: TPoint);
begin
  if not (csDesigning in ComponentState) then
  begin
    if DoHeaderPopup(AMousePos) then
      Exit;

    if CanHeaderPopup then
    begin
      FHeaderMenu.PopupComponent := Self;
      FHeaderMenu.Popup(AMousePos.X, AMousePos.Y);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockPanel.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_DOCKING;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FImages then
      Images := nil;
    if AComponent = FHeaderMenu then
      HeaderMenu := nil;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.ReadState(Reader: TReader);
begin
  if Reader.Parent is TLMDDockSite then
    InternalSetLoadingSite(TLMDDockSite(Reader.Parent));
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.Release;
begin
  PanelVisible := False;
  PostMessage(Handle, CM_RELEASE, 0, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.ActiveChanged;
begin
  if FSite <> nil then
    FSite.PanelUIStateChanged(Self);
  UpdateLayout;
  {$IFDEF LMD_DCK_UPDATE}Update;{$ENDIF}
  FLastCheckActive := Active;
  DoActiveChanged;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.AdjustClientRect(var Rect: TRect);
begin
  Rect := FContent;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.AlignControls(AControl: TControl;
  var ARect: TRect);
begin
  if FClientControl <> nil then
    FClientControl.BoundsRect := FContent
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.Resize;
begin
  inherited;
  UpdateLayout;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.Paint;
const
  STATES: array[Boolean, Boolean] of TLMDFrameBtnState = (
    ([],          [fbsPinned]),
    ([fbsActive], [fbsActive, fbsPinned])
  );
var
  pe:     TLMDPanelElem;
  pp:     TLMDPinPanelBase;
  pb:     TLMDPanelButtonElem;
  cr, sr: TRect;
  actv:   Boolean;
  s:      TLMDString;

  function ShowImage: Boolean;
  begin
    Result := (((FShowHeaderImage = hiDefault) and pe.ShowHeaderImage) or
               (FShowHeaderImage = hiShow)) and
              (FImages <> nil) and (FImageIndex >= 0) and
              (FImageIndex < FImages.Count);
  end;

begin
  if FZone = nil then // Very rare case; as described by the user:
    Exit;             //   Crash on undock of auto-hidden panel
                      //   with a frame with a win-control inside...

  pe   := StyleElems.Panel;
  cr   := ClientRect;
  actv := GetActive;

  if (FSpltrSide <> alNone) and Assigned(FZone) then // 27.Jun.2013 WP/AIDA:
                                                     // check if FZone is
                                                     // assigned.
  begin
    pp := StyleElems.GetPinPanel(FZone.AutoHideSide);
    pp.Background.Draw(Canvas, cr);
    pp.Splitter.Draw(Canvas, FSpltrArea);
    pp.GetAreas(cr, sr, cr);
  end;

  if Color <> clNone then
  begin
    Canvas.Brush.Color := Color;
    Canvas.Brush.Style := bsSolid;
    Canvas.FillRect(FContent);
  end;

  if FHaveHeader then
  begin
    pe.GetCaption(actv).Draw(Canvas, FHeaderArea);
    cr := pe.CaptionContent.AdjustRect(FHeaderArea);

    pb := StyleElems.PanelButton;
    pb.Draw(Canvas, FButtonsData, STATES[actv, FSpltrSide = alNone]);
    cr.Right := Min(cr.Right, FButtonsData.Group.Left);

    if ShowImage and (cr.Right - cr.Left >= FImages.Width) then
    begin
      FImages.Draw(Canvas, cr.Left, (cr.Top + cr.Bottom -
                   FImages.Height) div 2, FImageIndex);
      Inc(cr.Left, FImages.Width + STD_INDENT);
    end;

    if cr.Right - cr.Left > 0 then
    begin
      s                 := Caption;
      Canvas.Font       := Font;
      Canvas.Font.Color := pe.GetTextColor(actv);

      SetBkMode(Canvas.Handle, TRANSPARENT);
      LMDDrawTextWithElipsis(Canvas, s, cr);
      Inc(cr.Left, Canvas.TextWidth(s));
    end;

    cr := pe.FillerMargins.AdjustRect(cr);
    if cr.Right - cr.Left > 0 then
      pe.GetFiller(actv).Draw(Canvas, cr);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.WndProc(var Message: TMessage);
begin
  inherited;                                  // Eventually calls BeginAutoDrag.

  if psBeginAutoDragCalled in FState then     // Dispatch disabled by Vcl code
  begin                                       // mouse messages to support Vcl's
    Exclude(Fstate, psBeginAutoDragCalled);   // default mouse calls chain, e.g.
    Dispatch(Message);                        // MouseDown virtual procedure.
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.BeginAutoDrag;
begin
  Include(FState, psBeginAutoDragCalled);
  // Do not call inherited.
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockPanel.GetFloating: Boolean;
begin
  Result := (HostDockSite is TFloatingSite);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.DoStartDock(var DragObject: TDragObject);

  function _DragContent: Boolean;
  var
    sb: TLMDSiteBackElem;
  begin
    if FSite <> nil then
    begin
      sb     := Site.StyleElems.SiteBack;
      Result := sb.DragContent;
    end
    else
      Result := False;
  end;

  function _AnimateRect: Boolean;
  var
    sb: TLMDSiteBackElem;
  begin
    if FSite <> nil then
    begin
      sb     := Site.StyleElems.SiteBack;
      Result := sb.AnimateDragRect;
    end
    else
      Result := False;
  end;

  function _BackColor: TColor;
  var
    sb: TLMDSiteBackElem;
  begin
    if FSite <> nil then
    begin
      sb     := Site.StyleElems.SiteBack;
      Result := sb.DragRectBack;
    end
    else
      Result := $00DF9D84;
  end;

  function _BorderColor: TColor;
  var
    sb: TLMDSiteBackElem;
  begin
    if FSite <> nil then
    begin
      sb     := Site.StyleElems.SiteBack;
      Result := sb.DragRectBorder;
    end
    else
      Result := clWhite;
  end;

var
  dobj: TLMDDragObject;
begin
  inherited;

  if DragObject = nil then
  begin
    dobj             := TLMDDragObject.Create(Self);
    dobj.DragContent := _DragContent;
    dobj.AnimateRect := _AnimateRect;
    dobj.BackColor   := _BackColor;
    dobj.BorderColor := _BorderColor;
    DragObject       := dobj;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.ShowControl(AControl: TControl);
begin
  if FSite <> nil then
    FSite.ShowControl(Self) // Call site, not parent.
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockPanel.StyleElems: TLMDDockElems;
var
  mgr: TLMDDockManager;
begin
  if FSite <> nil then
    mgr := FSite.Manager
  else
    mgr := nil;
  Result := GetDefDockElems(mgr);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.ConstrainedResize(var MinWidth, MinHeight,
  MaxWidth, MaxHeight: Integer);
begin
  // Do not call inherited. The panel shuld be
  // always able ro resize.
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockPanel.DoHeaderDblClick: Boolean;
begin
  Result := False;
  if Assigned(FOnHeaderDblClick) then
    FOnHeaderDblClick(Self, Result);
end;

function TLMDDockPanel.DoHeaderPopup(const AMousePos: TPoint): Boolean;
begin
  Result := False;
  if Assigned(FOnHeaderPopup) then
    FOnHeaderPopup(Self, AMousePos, Result);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDDockPanel.Create(AOwner: TComponent);
begin
  inherited;

  ControlStyle              := ControlStyle + [csClickEvents, csAcceptsControls,
                                               csNoDesignVisible,
                                               csOpaque, csSetCaption];
  Color                     := clBtnFace;
  ParentColor               := False;
  FDefaultColor             := True;
  FDefaultFontColor         := True;
  FloatingDockSiteClass     := TLMDFloatingForm;
  DragKind                  := dkDock;
  DragMode                  := dmAutomatic;
  FButtonsData.Hot          := pbNone;
  FButtonsData.HotDown      := False;
  FImageChangeLink          := TChangeLink.Create;
  FImageChangeLink.OnChange := ImagesChange;
  FImageIndex               := -1;
  FPanelVisible             := True;
  FShowHeader               := True;
  FBorderStyle              := bsSingle;
  FButtons                  := [pbMenu, pbPin, pbMaximize, pbClose];
  FShowHeaderImage          := hiDefault;

  UpdateHook(True);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockPanel.DesignWndProc(var Message: TMessage): Boolean;
var
  p: TPoint;
begin
  case Message.Msg of
    WM_LBUTTONDOWN:
    begin
      p      := SmallPointToPoint(TWMMouse(Message).Pos);
      Result := PtInRect(FHeaderArea, p) or PtInRect(FSpltrArea, p) or
                (Assigned(LMDGetDesignerActionProc) and
                 (LMDGetDesignerActionProc(Self) = paMove));

      if Result and Assigned(LMDSetDesignedSelectionProc) then
        LMDSetDesignedSelectionProc(Self);
    end;
    WM_MOUSEMOVE, WM_LBUTTONUP:
    begin
      p      := SmallPointToPoint(TWMMouse(Message).Pos);
      Result := PtInRect(FHeaderArea, p) or FButtonsData.HotDown or
                (psDesignDrag in FState) or (psDesignDragPending in FState);
    end
  else
    Result := inherited DesignWndProc(Message);
  end;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDockPanel.Destroy;
begin
  InternalSetLoadingSite(nil);
  InternalResetSite;
  UpdateHook(False);

  Images := nil;
  HeaderMenu := nil;
  FImageChangeLink.Free;
  FDsgDragRect.Free;

  inherited;
end;

{ ---------------------------------------------------------------------------- }
{$IFDEF LMDCOMP11}
procedure TLMDDockPanel.SetDesignVisible(Value: Boolean);
begin
  inherited;
  UpdateVisible;
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.DoActiveChanged;
begin
  // Do nothing. Edwin Yip - LMD customer asked for this method.
end;

procedure TLMDDockPanel.Dock(NewDockSite: TWinControl; ARect: TRect);
begin
  inherited;
  if HostDockSite <> FSite then
    InternalResetSite;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockPanel.DoClose: TLMDockPanelCloseAction;
begin
  Result := caHide;
  if Assigned(FOnClose) then
    FOnClose(Self, Result);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.UpdateLayout;
var
  pe:     TLMDPanelElem;
  pp:     TLMDPinPanelBase;
  site:   TLMDDockSite;
  btns:   TLMDPanelBtnKinds;
  oldcnt: TRect;
begin
  pe       := StyleElems.Panel;
  oldcnt   := FContent;
  FContent := ClientRect;

  { Auto hidden frame }

  site := FSite;
  if site = nil then
    site := FLoadingSite;

  if (FZone <> nil) and FZone.IsAutoHidden then
  begin
    FSpltrSide := LMDOppsiteSide[FZone.AutoHideSide];
    pp         := StyleElems.GetPinPanel(FZone.AutoHideSide);
    pp.GetAreas(FContent, FSpltrArea, FContent);
  end
  else
  begin
    FSpltrSide := alNone;
    FSpltrArea := Rect(0, 0, 0, 0);
  end;

  { Frame }

  FHaveHeader := (site <> nil) and site.ShowPanelHeader(Self);
  pe.GetAreas(FContent, FHaveHeader, Font, FHeaderArea, FContent);

  if FHaveHeader then
  begin
    btns := site.GetPanelButtons(Self);
    StyleElems.PanelButton.GetAreas(FHeaderArea, btns, FButtonsData);
  end
  else
    FButtonsData.Kinds := [];

  UpdateColors;
  Realign;
  InvalidateBorder(oldcnt);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.Activate(AShowParentForm: Boolean);
var
  frm: TCustomForm;
  ac: TWinControl;
begin
  if not (csDesigning in ComponentState) and CanFocus and
     not Active then
  begin
    frm := GetParentForm(Self);

    if frm <> nil then
    begin
      ac := frm.ActiveControl;
      if not ContainsControl(ac) then
      begin
        frm.ActiveControl := Self; // OnEnter event is raised here; the user
                                   // can change active control inside it.
        ac := frm.ActiveControl;
        if (ac = Self) or not ContainsControl(ac) then
          SelectFirst;
      end;
      if AShowParentForm then
        frm.Show; // Activate.
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.DblClick;
var
  p: TPoint;
begin
  p := ScreenToClient(Mouse.CursorPos);
  if PtInRect(FHeaderArea, p) then
    DoHeaderDblClick
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.Deactivate;
var
  frm: TCustomForm;
begin
  if Active and not (csDesigning in ComponentState) then
  begin
    frm := GetParentForm(Self);
    if frm <> nil then
    begin
      if FSite <> nil then
        frm.ActiveControl := FSite
      else
        frm.ActiveControl := nil;
    end;
  end;
end;

{ ******************************* TLMDDockZone ******************************* }
{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.InsertZone(AZone: TLMDDockZone; AIndex: Integer);
begin
  if FZones = nil then
    FZones := TList.Create;

  FZones.Insert(AIndex, AZone);
  AZone.FParent := Self;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.RemoveZone(AZone: TLMDDockZone);
begin
  FZones.Remove(AZone);
  AZone.FParent := nil;

  RemoveTab(AZone);
  if FSelectedPage = AZone then
    FSelectedPage := nil;
  if FScrollToTab = AZone then
    FScrollToTab := nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.GetZoneCount: Integer;
begin
  if FZones = nil then
    Result := 0
  else
    Result := FZones.Count;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.GetZones(AIndex: Integer): TLMDDockZone;
begin
  if FZones = nil then
    TList.Error(@SListIndexError, AIndex);
  Result := TLMDDockZone(FZones[AIndex]);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.GetSplitterCount: Integer;
begin
  Result := Length(FSplitters);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.GetSplitters(AIndex: Integer): TLMDZoneSplitterInfo;
begin
  Result := FSplitters[AIndex];
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.GetTabButtons(AChild: TLMDDockZone): TLMDTabBtnKinds;
var
  pnl: TLMDdockPanel;
  tab: TLMDTabedAreaBtnBase;
begin
  if GetTabPanel(AChild, pnl) then
  begin
    Result := [];
    tab    := FTree.FSite.StyleElems.GetTabedAreaButton(TabbedDocsHost);

    // Actually, only Close button is supported whithin a tab.

    if (tbClose in tab.ShowButtons) and (pbClose in FTree.FSite.
                                         GetPanelButtons(pnl)) then
      Include(Result, tbClose);
  end
  else
    Result := [];
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.GetTabCaption(AChild: TLMDDockZone): TLMDString;
begin
  if AChild <> nil then
    Result := AChild.Caption
  else if FTree.DragTabZone = Self then
    Result := LMDGetClientCaption(FTree.DragTabInfo.Client)
  else
    Result := '';
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.GetTabCount: Integer;
begin
  Result := Length(FTabs);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.GetTabImageParams(AChild: TLMDDockZone;
  out AImages: TCustomImageList; out AImageIndex: Integer): Boolean;
begin
  if AChild <> nil then
    AChild.GetImageParams(AImages, AImageIndex)
  else if FTree.DragTabZone = Self then
    FTree.FSite.GetClientImageParams(FTree.DragTabInfo.Client,
                                     AImages, AImageIndex)
  else
  begin
    AImages     := nil;
    AImageIndex := -1;
  end;

  Result := (AImages <> nil) and (AImageIndex >= 0) and
            (AImageIndex < AImages.Count);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.GetTabPanel(AChild: TLMDDockZone;
  out APanel: TLMDDockPanel): Boolean;
begin
  if AChild <> nil then
    APanel := AChild.FPanel
  else if FTree.DragTabZone = Self then
    APanel := FTree.FSite.FindPanelByClient(FTree.DragTabInfo.Client)
  else
    APanel := nil;
  Result := (APanel <> nil);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.GetTabs(AIndex: Integer): TLMDZoneTabInfo;
begin
  Result := FTabs[AIndex];
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.GetTabState(AIndex: Integer): TLMDZoneTabState;
var
  tab: ^TLMDZoneTabInfo;
begin
  Result := ztsNormal;
  tab    := @FTabs[AIndex];

  if (tab.Zone = nil) or ((FTree.FDragTabZone <> Self) and
                          (tab.Zone = FSelectedPage)) then
    Result := ztsSelected
  else if (FTree.FHotTabZone = Self) and
          (FTree.FHotTabIndex = AIndex) then
    Result := ztsHot;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.RemoveTab(ATab: TLMDDockZone);
var
  i, idx: Integer;
begin
  idx := -1;
  for i := 0 to High(FTabs) do
    if FTabs[i].Zone = ATab then
    begin
      idx := i;
      Break; // for
    end;

  if idx <> -1 then
  begin
    for i := idx to High(FTabs) - 1 do
      FTabs[i] := FTabs[i + 1];
    SetLength(FTabs, Length(FTabs) - 1);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.GetBaseTabWidth(AChild: TLMDDockZone): Integer;
var
  site: TLMDDockSite;
  tba:  TLMDTabedAreaBase;
  lst:  TCustomImageList;
  idx:  Integer;
  btw:  Integer;
  btna: Integer;

  function GetCloseWidth: Integer;
  const
    PNT_SZ = 1000;
  var
    pnt, br: TRect;
    tab:     TLMDTabedAreaBtnBase;
  begin
    tab := site.StyleElems.GetTabedAreaButton(TabbedDocsHost);
    pnt := Rect(0, 0, PNT_SZ, PNT_SZ);

    tab.GetCloseArea(pnt, br);
    Result := PNT_SZ - br.Left + STD_INDENT;
  end;

begin
  site             := FTree.FSite;
  tba              := site.StyleElems.GetTabedArea(TabbedDocsHost);
  site.Canvas.Font := site.Font;
  btw              := 0;

  { Content }

  if tba.ShowTabImage and GetTabImageParams(AChild, lst, idx) then
    Inc(btw, lst.Width + STD_INDENT);
  Inc(btw, site.Canvas.TextWidth(GetTabCaption(AChild)));

  { Buttons }
  
  if tbClose in GetTabButtons(AChild) then // Only close button is
    btna := GetCloseWidth                  // currently supported.
  else
    btna := 0;
  
  Result := tba.TabContent.Left + btw + Max(tba.TabContent.Right, btna);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.GetBounds: TRect;
begin
  Result.Left   := FLeft;
  Result.Top    := FTop;
  Result.Right  := FLeft + FWidth;
  Result.Bottom := FTop + FHeight;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.GetHotTabBtn(AIndex: Integer;
  out ADown: Boolean): TLMDTabBtnKind;
begin
  Result := tbNone;
  ADown  := False;

  if (FTree.FHotTabZone = Self) and
     (FTree.FHotTabIndex = AIndex) then
  begin
    Result := FTree.FHotTabBtn;
    ADown  := FTree.FHotTabBtnDown;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.GetIndex: Integer;
begin
  if FParent <> nil then
    Result := FParent.FZones.IndexOf(Self)
  else
    Result := -1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.GetInsertingTabIndex(const P: TPoint;
  AClient: TControl): Integer;
var
  tba:       TLMDTabedAreaBase;
  tac:       TRect;
  i, x:      Integer;
  excludezn: TLMDDockZone;
  items:     TTabItems;
  itmcnt:    Integer;
  mgr:       TLMDDockManager;
begin
  mgr := FTree.FSite.FManager;
  tba := FTree.FSite.StyleElems.GetTabedArea(TabbedDocsHost);
  tac := tba.TabAreaContent.AdjustRect(FTabArea);
  SetLength(items, Length(FTabs) + 1);

  items[0].Zone     := nil;
  items[0].BaseSize := GetBaseTabWidth(nil);
  itmcnt            := 1;
  excludezn         := FTree.FindZoneByClient(AClient);

  for i := 0 to High(FTabs) do
    if (FTabs[i].Zone <> nil) and (FTabs[i].Zone <> excludezn) then
    begin
      items[itmcnt].Zone     := FTabs[i].Zone;
      items[itmcnt].BaseSize := GetBaseTabWidth(FTabs[i].Zone);
      Inc(itmcnt);
    end;

  SetLength(items, itmcnt); // Set real length.
  TTabsHandler.CalcLayout(FTree.FSite.Canvas, tac.Right - tac.Left,
                          tba.SpacerWidth, CUT_MODES[(mgr = nil) or
                          mgr.ScrollDocTabs, TabbedDocsHost], items);

  Result := -1;
  x      := tac.Left;

  for i := 1 to FFirstTab do // Start from index 1 to
                             // skip inserting item.
    Dec(x, items[i].Size + tba.SpacerWidth);

  if PtInRect(tac, P) then
  begin
    if (P.X >= x) and (P.X < x + items[0].Size) then
      Result := 0;

    for i := 1 to High(items) do
    begin
      Inc(x, items[i].Size + tba.SpacerWidth);
      if P.X >= x then
        Result := items[i].Zone.Index + 1
      else
        Break; // for
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.SetIndex(const Value: Integer);
var
  idx: Integer;
begin
  if FParent <> nil then
  begin
    idx := FParent.FZones.IndexOf(Self);
    if idx <> Value then
    begin
      FParent.FZones.Move(idx, Value);
      FTree.FSite.UpdateLayout(True);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.SetResizeKind(const Value: TLMDZoneResizeKind);
begin
  if ResizeKind <> Value then
  begin
    case Value of
      zrkProportional,
      zrkFixed:         begin
                          FFixed := (Value = zrkFixed);
                          if FTree.FSpaceZone = Self then
                            FTree.FSpaceZone := nil;
                        end;
      zrkSpace:         begin
                          FFixed           := False;
                          FTree.FSpaceZone := Self;

                          if not FTree.FSite.FUseSpace then
                            FTree.FSite.UseSpace := True;
                        end;
    else
      Assert(False);
    end;

    FTree.FSite.UpdateLayout(True);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.SetWidth(const Value: Integer);
begin
  if FWidth <> Value then
  begin
    FWidth     := Value;
    FDSize     := 0;
    FInserting := True;

    FTree.FSite.UpdateLayout(True);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.TabbedDocsHost: Boolean;
begin
  Result := (FindMainDocsZone <> nil);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.TabbedDocsInfo(out AInfo: TLMDTabbedDocsInfo): Boolean;

  function ComposeByIndex(AMain: TLMDDockZone; AIfNotFirst,
                          AIfNotLast: TLMDActiveAreas): TLMDActiveAreas;
  var
    zn:  TLMDDockZone;
    idx: Integer;
  begin
    Result := [];
    zn     := Self;

    while zn.Parent <> nil do
    begin
      if zn.Parent = AMain then
      begin
        idx := AMain.FZones.IndexOf(zn);
        if idx > 0 then
          Result := Result + AIfNotFirst;
        if idx < (AMain.FZones.Count - 1) then
          Result := Result + AIfNotLast;
        Break; // while
      end;
      zn := zn.Parent;
    end;
  end;

var
  zn:    TLMDDockZone;
  areas: TLMDActiveAreas;
begin
  zn := FindMainDocsZone;

  if zn <> nil then
  begin
    areas := [Low(TLMDActiveArea)..High(TLMDActiveArea)];

    case zn.Kind of
      zkPanel:  begin
                  if zn.IsEmpty then
                    areas := areas - [hsaDocsTop, hsaDocsBottom,
                                      hsaDocsLeft, hsaDocsRight];
                end;
      zkTabs:   ; // Do nothing. No additional
                  // restrictions to areas.
      zkHorz:   areas := areas - [hsaDocsTop, hsaDocsBottom] -
                         ComposeByIndex(zn, [hsaZoneLeft], [hsaZoneRight]);
      zkVert:   areas := areas - [hsaDocsLeft, hsaDocsRight] -
                         ComposeByIndex(zn, [hsaZoneTop], [hsaZoneBottom]);
    else
      Assert(False);
    end;

    AInfo.MainZone  := zn;
    AInfo.AreasMask := areas;
    Result          := True;
  end
  else
    Result := False;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.ScrollToTab(AChild: TLMDDockZone);
begin
  if not IsTabInView(AChild) then
  begin
    FScrollToTab := AChild;
    FTree.FSite.UpdateLayout(True);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.SetAutoHide(const Value: Boolean);
begin
  if FAutoHide <> Value then
  begin
    FAutoHide := Value;
    FTree.FSite.UpdateLayout(True);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.SetChildrenSizes(const ASizes: array of Integer);
var
  cnt:  Integer;
  i:    Integer;
  zone: TLMDDockZone;
begin
  if FKind in [zkHorz, zkVert] then
  begin
    cnt := Length(ASizes);
    if cnt > FZones.Count then
      cnt := FZones.Count;

    for i := 0 to cnt - 1 do
      if ASizes[i] > 0 then
      begin
        zone            := TLMDDockZone(FZones[i]);
        zone.FDSize     := 0;
        zone.FInserting := True;

        if FKind = zkHorz then
          zone.FWidth := ASizes[i]
        else
          zone.FHeight := ASizes[i];
      end;

    FTree.FSite.UpdateLayout(True);
  end;
end;

procedure TLMDDockZone.SetFirstTab(const Value: Integer);
begin
  if FFirstTab <> Value then
  begin
    FFirstTab := Value;
    FTree.FSite.UpdateLayout(True); // Possible values range
                                    // is ensured here.
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.SetHeight(const Value: Integer);
begin
  if FHeight <> Value then
  begin
    FHeight    := Value;
    FDSize     := 0;
    FInserting := True;

    FTree.FSite.UpdateLayout(True);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.SetSelectedPage(const Value: TLMDDockZone);
begin
  if ((FSelectedPage <> Value) or not IsTabInView(Value)) and
     ((Value = nil) or (Value.FParent = Self)) then
  begin
    FSelectedPage := Value;
    FScrollToTab  := Value;
    FTree.FSite.UpdateLayout(True);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.InternalSetPanel(const Value: TLMDDockPanel);
begin
  if FPanel <> Value then
  begin
    if (Value <> nil)and (Value.FZone <> nil) then
      Value.FZone.InternalSetPanel(nil);
    if FPanel <> nil then
      FPanel.FZone := nil;
    FPanel := Value;
    if FPanel <> nil then
      FPanel.FZone := Self;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.InternalSetBounds(const Value: TRect);
begin
  FLeft   := Value.Left;
  FTop    := Value.Top;
  FWidth  := Value.Right - Value.Left;
  FHeight := Value.Bottom - Value.Top;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.InternalSetInserting(AWidth, AHeight: Integer);
begin
  FLeft      := 0;
  FTop       := 0;
  FWidth     := AWidth;
  FHeight    := AHeight;
  FDSize     := 0;
  FInserting := True;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.CopyFrom(ASource: TLMDDockZone);
var
  oldzns: Integer;
  acttab: TLMDDockZone;
begin
  oldzns := ZoneCount;
  acttab := ASource.FSelectedPage;

  if ASource.Panel <> nil then
    InternalSetPanel(ASource.Panel)
  else
  begin
    oldzns := ZoneCount;
    while ASource.ZoneCount > 0 do
      AddZone(ASource.Zones[0]);
  end;
  FKind         := ASource.Kind;
  FFixed        := ASource.FFixed;
  FAutoHide     := ASource.AutoHide;
  FSelectedPage := acttab;
  if FTree.FSpaceZone = ASource then
    FTree.FSpaceZone := Self;

  while oldzns > 0 do
  begin
    Zones[0].Free;
    Dec(oldzns);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.UpdatePanelZn;
var
  pze: TLMDPanelZoneElem;
  cr:  TRect;
begin
  if Panel <> nil then
  begin
    pze := FTree.FSite.StyleElems.PanelZone;
    cr  := pze.Content.AdjustRect(Bounds);

    Panel.Parent := FTree.FSite;
    Panel.UpdateLayout;

    if Showing and Panel.PanelVisible then
    begin
      Panel.SetBounds(cr.Left, cr.Top,
                      cr.Right - cr.Left,
                      cr.Bottom - cr.Top);
      Panel.OnSiteShowing := True;
      if Panel = FTree.FActivatePanel then
      begin
        Panel.BringToFront;
        Panel.Activate(False);
      end;
    end
    else if Panel <> FTree.FSite.FShiftingPanel then
    begin
      Panel.OnSiteShowing := False;
      if not IsAutoHidden then
        Panel.SetBounds(cr.Left, cr.Top,
                        cr.Right - cr.Left,
                        cr.Bottom - cr.Top);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.UpdateSeqZn(ASeqHandler: TObject);
var
  sze:       TLMDSeqZoneBase;
  hdr:       TSeqHandler;
  curzn:     TLMDdockZone;
  i, itmlnt: Integer;
  hidden:    Boolean;
  sitems:    TSeqItems;
  x, y, ysz: Integer;
  splsz:     Integer;
begin
  hdr   := TSeqHandler(ASeqHandler);
  sze   := FTree.FSite.StyleElems.GetSeqZone(FKind = zkVert);
  splsz := sze.GetSplitterSize;

  itmlnt := 0;
  SetLength(sitems, ZoneCount);

  for i := 0 to ZoneCount - 1 do
  begin
    curzn  := Zones[i];
    hidden := not curzn.ContainsVisibleContent;

    if not hidden then
    begin
      sitems[itmlnt].Data  := curzn;
      sitems[itmlnt].Kind  := sikProportional;
      sitems[itmlnt].Size  := hdr.GetZoneXSize(curzn);
      sitems[itmlnt].DSize := curzn.DSize;

      if Zones[i].Inserting or (Zones[i].ResizeKind = zrkFixed) or
         curzn.FSeqWasHidden then
        sitems[itmlnt].Kind := sikPreserveSize
      else if curzn.ContainSpace then
        sitems[itmlnt].Kind := sikSpace;

      Inc(itmlnt);
    end
    else
      Zones[i].FShowing := False;

    curzn.FSeqWasHidden := hidden;
  end;
  SetLength(sitems, itmlnt); // Set real length.

  TSeqHandler.CalcLayout(sitems, hdr.GetZoneXSize(Self,
                         sze.Content), splsz);

  if Length(sitems) > 1 then
    SetLength(FSplitters, Length(sitems) - 1);

  x   := hdr.GetZoneXMin(Self, sze.Content);
  y   := hdr.GetZoneYMin(Self, sze.Content);
  ysz := hdr.GetZoneYSize(Self, sze.Content);

  for i := 0 to High(sitems) do
  begin
    curzn := TLMDDockZone(sitems[i].Data);
    curzn.InternalSetBounds(hdr.GetRealRect(x, y, sitems[i].Size, ysz));
    curzn.FDSize   := sitems[i].DSize;
    curzn.FShowing := FShowing;
    Inc(x, sitems[i].Size);

    if i <= High(FSplitters) then
    begin
      FSplitters[i].Bounds := hdr.GetRealRect(x, y, splsz, ysz);
      FSplitters[i].ZoneA := curzn;
      FSplitters[i].ZoneB := TLMDDockZone(sitems[i + 1].Data);
      Inc(x, splsz);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.UpdateTabsZn;
var
  tba: TLMDTabedAreaBase;
  cr:  TRect;
  i:   Integer;
begin
  tba := FTree.FSite.StyleElems.GetTabedArea(TabbedDocsHost);
  tba.GetAreas(Bounds, FTree.FSite.Font, cr, FTabArea);

  FillChar(FTabAreaBtns, SizeOf(FTabAreaBtns), 0);
  FSelectedPage := UpdateTabArea;

  if Length(FTabs) = 0 then
  begin
    FTabArea  := Rect(0, 0, 0, 0);
    FTabsClip := Rect(0, 0, 0, 0);
    cr        := Bounds;
  end;

  for i := 0 to ZoneCount - 1 do
  begin
    Zones[i].InternalSetBounds(cr);
    Zones[i].FShowing := FShowing and (Zones[i] = FSelectedPage);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.UpdateTabArea: TLMDDockZone;
const
  SCROLL_BTNS: array[Boolean] of TLMDTabBtnKinds = ([], [tbLeft, tbRight]);
var
  mgr:       TLMDDockManager;
  tba:       TLMDTabedAreaBase;
  tab:       TLMDTabedAreaBtnBase;
  tac, cr:   TRect;
  i, dragtb: Integer;
  excludezn: TLMDDockZone;
  apgfnd:    Boolean;
  items:     TTabItems;
  itmcnt:    Integer;
  x, y, ysz: Integer;
  lspc:      PRect;
  bgrp:      TRect;

  function CorrectFirstTab: Integer;
  var
    lefts:     array of Integer;
    i, sidx:   Integer;
    asz, tsz:  Integer;
    max:       Integer;
    lft, rght: Integer;
  begin
    SetLength(lefts, Length(items));
    asz  := tac.Right - tac.Left;
    tsz  := 0;
    sidx := -1;

    for i := 0 to High(items) do
    begin
      if items[i].Zone = FScrollToTab then
        sidx := i;
      lefts[i] := tsz;
      tsz      := tsz + items[i].Size + tba.SpacerWidth;
    end;
    Dec(tsz, tba.SpacerWidth);

    max := 0;
    for i := High(items) downto 0 do
      if tsz - lefts[i] > asz then
      begin
        max := i + 1;
        if max > High(items) then
          max := High(items);
        Break; // for
      end;

    if FFirstTab < 0 then
      FFirstTab := 0
    else if FFirstTab > max then
      FFirstTab := max;

    if (FScrollToTab <> nil) and (sidx <> -1) then
    begin
      lft  := lefts[sidx];
      rght := lefts[sidx] + items[sidx].Size;

      while (FFirstTab > 0) and (lft < lefts[FFirstTab]) do
        Dec(FFirstTab);
      while (FFirstTab < max) and (rght > lefts[FFirstTab] + asz) do
        Inc(FFirstTab);
    end;

    Result := lefts[FFirstTab];
  end;

begin
  mgr    := FTree.FSite.FManager;
  tba    := FTree.FSite.StyleElems.GetTabedArea(TabbedDocsHost);
  tab    := FTree.FSite.StyleElems.GetTabedAreaButton(TabbedDocsHost);
  tac    := tba.TabAreaContent.AdjustRect(FTabArea);
  Result := FSelectedPage;

  { Calc tab items }

  excludezn := FTree.FindZoneByClient(FTree.FDragTabInfo.Client);
  itmcnt    := 0;
  dragtb    := -1;
  SetLength(items, ZoneCount + 1);

  for i := 0 to ZoneCount - 1 do
    if Zones[i].ContainsVisibleContent and (Zones[i] <> excludezn) then
    begin
      if (dragtb = -1) and (i >= FTree.FDragTabInfo.ZoneIndex) then
        dragtb := itmcnt;

      items[itmcnt].Zone     := Zones[i];
      items[itmcnt].BaseSize := GetBaseTabWidth(Zones[i]);
      Inc(itmcnt);
    end;

  if FTree.FDragTabZone = Self then
  begin
    if (dragtb < 0) or (dragtb > itmcnt) then
      dragtb := itmcnt;
    for i := itmcnt downto dragtb + 1 do
      items[i] := items[i - 1];

    items[dragtb].Zone     := nil;
    items[dragtb].BaseSize := GetBaseTabWidth(nil);
    Inc(itmcnt);
  end;

  { Correct active page }

  apgfnd := False;

  if Result <> nil then
  begin
    for i := 0 to itmcnt - 1 do
      if items[i].Zone = Result then
      begin
        apgfnd := True;
        Break; // for
      end;
  end;

  if not apgfnd then
  begin
    Result := nil;
    for i := 0 to itmcnt - 1 do
      if items[i].Zone <> nil then
      begin
        Result := items[i].Zone;
        Break; // for
      end;
  end;

  { Suppress single tab }

  if (itmcnt = 1) and not TabbedDocsHost then
    itmcnt := 0;

  { Calc layout }

  if itmcnt > 0 then
  begin
    tab.GetGroupAreas(FTabArea, tab.ShowButtons - [tbClose] -
                      SCROLL_BTNS[(mgr <> nil) and not mgr.
                      ScrollDocTabs], FTabAreaBtns, bgrp);
    if not IsRectEmpty(bgrp) then
      tac.Right := Min(tac.Right, bgrp.Left);

    SetLength(items, itmcnt); // Set real length.
    TTabsHandler.CalcLayout(FTree.FSite.Canvas, tac.Right - tac.Left,
                            tba.SpacerWidth, CUT_MODES[(mgr = nil) or
                            mgr.ScrollDocTabs, TabbedDocsHost], items);
    SetLength(FTabs, Length(items));

    x    := tac.Left - CorrectFirstTab;
    y    := tac.Top;
    ysz  := tac.Bottom - tac.Top;
    lspc := nil;

    for i := 0 to High(FTabs) do
    begin
      FTabs[i].Bounds   := Classes.Bounds(x, y, items[i].Size, ysz);
      FTabs[i].Spacer   := Classes.Bounds(x + items[i].Size, y,
                                          Max(0, tba.SpacerWidth), ysz);
      FTabs[i].Zone     := items[i].Zone;
      FTabs[i].CloseBtn := Rect(0, 0, 0, 0);

      if tbClose in GetTabButtons(items[i].Zone) then
      begin
        cr := tba.TabContent.AdjustRect(FTabs[i].Bounds);
        tab.GetCloseArea(FTabs[i].Bounds, FTabs[i].CloseBtn);

        if FTabs[i].CloseBtn.Left < cr.Left then
          FTabs[i].CloseBtn := Rect(0, 0, 0, 0);
      end;

      Inc(x, items[i].Size + tba.SpacerWidth);
      lspc := @FTabs[i].Spacer;
    end;

    if lspc <> nil then
      lspc^ := Rect(0, 0, 0, 0);

    FTabsClip := tba.ContentClip.AdjustRect(tac);
  end
  else
  begin
    SetLength(FTabs, 0);
    FFirstTab := 0;
  end;

  FScrollToTab := nil; // Task done.
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.UpdateAutoHide;
var
  i:        Integer;
  hdr:      TSeqHandler;
  afterspc: Boolean;
begin
  case Kind of
    zkPanel:  begin
                if (FPanel = FTree.FSite.FShiftingPanel) and
                   not IsAutoHidden then
                  FTree.FSite.FShiftingPanel := nil;
              end;
    zkHorz,
    zkVert:   begin
                if Kind = zkHorz then
                  hdr := TSeqHandler(FTree.FHorzHandler)
                else
                  hdr := TSeqHandler(FTree.FVertHandler);

                if ResizeKind = zrkSpace then
                begin
                  for i := 0 to ZoneCount - 1 do
                    Zones[i].FAutoHideSide := alNone;
                end
                else if ContainSpace then
                begin
                  afterspc := False;
                  for i := 0 to ZoneCount - 1 do
                  begin
                    if Zones[i].ContainSpace then
                    begin
                      Zones[i].FAutoHideSide := alNone;
                      afterspc               := True;
                    end
                    else
                      Zones[i].FAutoHideSide := hdr.GetHideSide(afterspc);
                  end;
                end
                else
                begin
                  for i := 0 to ZoneCount - 1 do
                    Zones[i].FAutoHideSide := AutoHideSide;
                end;
              end;
    zkTabs:   begin
                for i := 0 to ZoneCount - 1 do
                  Zones[i].FAutoHideSide := AutoHideSide;
              end;
  end;

  if ((FParent = nil) or not FParent.IsAutoHidden) and
     (FAutoHideSide <> alNone) and FAutoHide then
    FTree.FAutoHideZones[FAutoHideSide].Add(Self);

  for i := 0 to ZoneCount - 1 do
    Zones[i].UpdateAutoHide;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.UpdateLayout;
var
  i: Integer;

  procedure UpdateChild(AZone: TLMDDockZone);
  begin
    AZone.FInserting := False;
    AZone.UpdateLayout;
  end;

begin
  SetLength(FSplitters, 0);
  SetLength(FTabs, 0);

  case Kind of
    zkPanel:  UpdatePanelZn;
    zkHorz:   UpdateSeqZn(FTree.FHorzHandler);
    zkVert:   UpdateSeqZn(FTree.FVertHandler);
    zkTabs:   UpdateTabsZn;
  end;

  if FSelectedPage <> nil then
    UpdateChild(FSelectedPage);
  for i := 0 to ZoneCount - 1 do
    if Zones[i] <> FSelectedPage then
      UpdateChild(Zones[i]);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.UpdateDockTracking;
begin
  if FKind = zkTabs then
  begin
    SetLength(FTabs, 0);
    UpdateTabArea;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.Paint(ACanvas: TCanvas);
var
  i:      Integer;
  se:     TLMDDockElems;
  sze:    TLMDSeqZoneBase;
  empty:  Boolean;
  tba:    TLMDTabedAreaBase;
  tab:    TLMDTabedAreaBtnBase;
  actv:   Boolean;
  down:   Boolean;

  function HasShowingZones: Boolean;
  var
    i: Integer;
  begin
    if FZones <> nil then
      for i := 0 to FZones.Count - 1 do
        if TLMDDockZone(FZones[i]).Showing then
        begin
          Result := True;
          Exit;
        end;
    Result := False;
  end;

  procedure DrawTab(AIndex: Integer);
  var
    tb:     ^TLMDZoneTabInfo;
    state:   TLMDZoneTabState;
    cr, tr:  TRect;
    s:       TLMDString;
    lst:     TCustomImageList;
    idx:     Integer;
    bs:      TLMDTabedAreaBtnState;
  begin
    tb    := @FTabs[AIndex];
    state := GetTabState(AIndex);

    if state = ztsSelected then
      tr := tba.SelectedMargins.AdjustRect(tb.Bounds)
    else
      tr := tb.Bounds;

    tba.GetTab(actv, state).Draw(ACanvas, tr);
    cr := tba.TabContent.AdjustRect(tb.Bounds);

    if tba.ShowTabImage and GetTabImageParams(tb.Zone, lst, idx) and
       (cr.Right - cr.Left >= lst.Width) then
    begin
      lst.Draw(ACanvas, cr.Left, ((cr.Top + cr.Bottom) -
               lst.Height) div 2, idx);
      Inc(cr.Left, lst.Width + STD_INDENT);
    end;

    if not IsRectEmpty(tb.CloseBtn) then
    begin
      bs := [];
      if actv then
        Include(bs, tbsAreaActive);
      if state = ztsSelected then
        Include(bs, tbsTabSelected);
      if state = ztsHot then
        Include(bs, tbsTabHot);

      if GetHotTabBtn(AIndex, down) = tbClose then
      begin
        Include(bs, tbsHot);
        if down then
          Include(bs, tbsHotDown);
      end;

      tab.GetStates(tbClose, bs).Draw(ACanvas, tb.CloseBtn);
      cr.Right := Min(cr.Right, tb.CloseBtn.Left - STD_INDENT);
    end;

    if cr.Right - cr.Left > 0 then
    begin
      s                  := GetTabCaption(tb.Zone);
      ACanvas.Font.Color := tba.GetTextColor(actv, state);
      SetBkMode(ACanvas.Handle, TRANSPARENT);
      LMDDrawTextWithElipsis(ACanvas, s, cr);
    end;
  end;

  procedure DrawTabs;
  var
    i, sel: Integer;
    dc:     HDC;
    save:   Integer;
  begin
    dc   := ACanvas.Handle;
    save := SaveDC(dc);
    sel  := -1;

    IntersectClipRect(dc, FTabsClip.Left, FTabsClip.Top,
                      FTabsClip.Right, FTabsClip.Bottom);

    for i := High(FTabs) downto 0 do
    begin
      if GetTabState(i) = ztsSelected then
        sel := i
      else
        DrawTab(i);
      tba.GetSpacer(actv).Draw(ACanvas, FTabs[i].Spacer);
    end;

    if sel <> -1 then
      DrawTab(sel);

    RestoreDC(dc, save);
    ACanvas.Refresh; // Sync Delphi canvas state.
  end;

  procedure DrawAreaButtons;
  var
    b:  TLMDTabBtnKind;
    bs: TLMDTabedAreaBtnState;
  begin
    for b := Low(TLMDTabBtnKind) to High(TLMDTabBtnKind) do
      if not IsRectEmpty(FTabAreaBtns[b]) then
      begin
        bs := [];
        if actv then
          Include(bs, tbsAreaActive);

        if GetHotTabBtn(-1, down) = b then
        begin
          Include(bs, tbsHot);
          if down then
            Include(bs, tbsHotDown);
        end;

        tab.GetStates(b, bs).Draw(ACanvas, FTabAreaBtns[b]);
      end;
  end;

begin
  if Showing then
  begin
    se    := FTree.FSite.StyleElems;
    empty := False;

    case FKind of
      zkPanel:  begin
                  if (FPanel <> nil) and FPanel.PanelVisible and
                     {$IFDEF LMDCOMP11} not (csDesignerHide in
                                             FPanel.ControlState)
                     {$ELSE} True {$ENDIF} then
                    se.PanelZone.Background.Draw(ACanvas, Bounds)
                  else
                    empty := True;
                end;
      zkHorz,
      zkVert:   begin
                  if HasShowingZones then
                  begin
                    sze := se.GetSeqZone(FKind = zkVert);
                    sze.Background.Draw(ACanvas, Bounds);
                    for i := 0 to High(FSplitters) do
                      sze.Splitter.Draw(ACanvas, FSplitters[i].Bounds);
                  end
                  else
                    empty := True;
                end;
      zkTabs:   begin
                  if HasShowingZones and not IsRectEmpty(FTabArea) then
                  begin
                    tba  := se.GetTabedArea(TabbedDocsHost);
                    tab  := se.GetTabedAreaButton(TabbedDocsHost);
                    actv := (FSelectedPage <> nil) and
                            (FSelectedPage.FKind = zkPanel) and
                            (FSelectedPage.FPanel <> nil) and
                            (FSelectedPage.FPanel.Active);

                    tba.GetBack(actv).Draw(ACanvas, Bounds);
                    tba.GetTabArea(actv).Draw(ACanvas, FTabArea);

                    DrawTabs;
                    DrawAreaButtons;
                  end
                  else
                    empty := True;
                end;
    end;

    if empty then
      se.EmptyZone.Background.Draw(ACanvas, Bounds)
    else
    begin
      for i := 0 to ZoneCount - 1 do
        Zones[i].Paint(ACanvas);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.PanelUIStateChanged(APanel: TLMDDockPanel);
var
  bnds: TRect;
begin
  if APanel.OnSiteShowing then
  begin
    if (FKind = zkTabs) and TabbedDocsHost and
       (SelectedPage <> nil) and SelectedPage.ContainsPanel(APanel) then
    begin
      bnds := Bounds;
      InvalidateRect(FTree.FSite.Handle, @bnds, True);
    end
    else if FParent <> nil then
      FParent.PanelUIStateChanged(APanel);
  end;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDDockZone.Create(ATree: TLMDDockZoneTree);
begin
  inherited Create;
  FTree      := ATree;
  FKind      := zkPanel;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDDockZone.Create(ATree: TLMDDockZoneTree;
  APanel: TLMDDockPanel);
begin
  inherited Create;
  FTree := ATree;
  FKind := zkPanel;
  InternalSetPanel(APanel);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDockZone.Destroy;
begin
  FTree.ZoneDestroying(Self);

  if FParent <> nil then
    FParent.RemoveZone(Self);
  ClearZones;
  InternalSetPanel(nil);
  FZones.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.FindMainDocsZone: TLMDDockZone;
var
  mgr:   TLMDDockManager;
  spcr:  TLMDDockZone;
  pknds: TLMDZoneKinds;
begin
  mgr   := FTree.FSite.FManager;
  spcr  := nil;
  pknds := [];

  if (mgr = nil) or mgr.UseTabbedDocs then
  begin
    case FKind of
      zkPanel:  begin
                  if IsEmpty then
                    spcr := Self;
                  pknds := [zkTabs];
                end;
      zkTabs:   begin
                  spcr  := Self;
                  pknds := [zkHorz, zkVert];
                end;
      zkHorz,
      zkVert:   begin
                  spcr  := Self;
                  pknds := [];
                end;
    else
      Assert(False);
    end;
  end;

  if FTree.FSpaceZone = Self then
    Result := spcr
  else if (FParent <> nil) and (FParent.FKind in pknds) then
    Result := FParent.FindMainDocsZone
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.AutoHideClose;
begin
  if (FPanel <> nil) and (FTree.FSite.FShiftingPanel = FPanel) then
    TPanelShifter(FTree.FSite.FShifter).SetState(False, True, False);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.IsEmpty: Boolean;
begin
  Result := (FPanel = nil) and (ZoneCount = 0);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.IsEmptySpace: Boolean;
begin
  Result := IsEmpty and (ResizeKind = zrkSpace);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.IsTabInView(AChild: TLMDDockZone): Boolean;
var
  tba: TLMDTabedAreaBase;
  tac: TRect;
  i:   Integer;
begin
  tba := FTree.FSite.StyleElems.GetTabedArea(TabbedDocsHost);
  tac := tba.TabAreaContent.AdjustRect(FTabArea);

  for i := 0 to High(FTabs) do
    if FTabs[i].Zone = AChild then
    begin
      Result := (tac.Left <= FTabs[i].Bounds.Left) and
                (tac.Right >= FTabs[i].Bounds.Right);
      Exit;
    end;

  Result := False;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.IsAutoHidden: Boolean;
begin
  Result := (FAutoHideSide <> alNone) and FAutoHide;
  if not Result and (FParent <> nil) then
    Result := FParent.IsAutoHidden;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.ContainsPanel(APanel: TLMDDockPanel): Boolean;
var
  i: Integer;
begin
  if FPanel = APanel then
    Result := True
  else
  begin
    for i := 0 to ZoneCount - 1 do
      if Zones[i].ContainsPanel(APanel) then
      begin
        Result := True;
        Exit;
      end;
    Result := False;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.ContainSpace: Boolean;
var
  cur: TLMDDockZone;
begin
  cur := FTree.FSpaceZone;

  while cur <> nil do
  begin
    if cur = Self then
    begin
      Result := True;
      Exit;
    end;
    cur := cur.FParent;
  end;

  Result := False;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.ContainsVisibleContent: Boolean;
var
  i: Integer;
begin
  if FAutoHide and (FAutoHideSide <> alNone) then
    Result := False
  else
  begin
    Result := (ResizeKind = zrkSpace) or ((FPanel <> nil) and
                                          FPanel.PanelVisible);
    if not Result then
    begin
      for i := 0 to ZoneCount - 1 do
        if Zones[i].ContainsVisibleContent then
        begin
          Result := True;
          Break; // for
        end;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.Caption: TLMDString;
begin
  Result := '';
  if FPanel <> nil then
    Result := FPanel.Caption
  else if ZoneCount = 1 then
    Result := Zones[0].Caption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.GetImageParams(out AImages: TCustomImageList;
  out AImageIndex: Integer): Boolean;
begin
  AImages     := nil;
  AImageIndex := -1;
  if FPanel <> nil then
  begin
    AImages     := FPanel.Images;
    AImageIndex := FPanel.ImageIndex;
  end;

  Result := (AImages <> nil) and (AImageIndex >= 0) and
            (AImageIndex < AImages.Count);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.ClearZones;
begin
  while ZoneCount > 0 do
    Zones[0].Free;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.AddZone(AZone: TLMDDockZone): Integer;
begin
  Result := ZoneCount;
  if AZone.FParent <> nil then
    AZone.FParent.RemoveZone(AZone);
  InsertZone(AZone, Result);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.AddZone(AZone: TLMDDockZone; AIndex: Integer);
begin
  if AZone.FParent <> nil then
    AZone.FParent.RemoveZone(AZone);

  if AIndex < 0 then
    AIndex := 0
  else if AIndex > ZoneCount then
    AIndex := ZoneCount;
  InsertZone(AZone, AIndex);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.HasPanelZones(AVisibleOnly: Boolean): Boolean;
var
  i: Integer;
begin
  if (FPanel <> nil) and (not AVisibleOnly or FPanel.PanelVisible) then
  begin
    Result := True;
    Exit;
  end;

  for i := 0 to ZoneCount - 1 do
    if Zones[i].HasPanelZones(AVisibleOnly) then
    begin
      Result := True;
      Exit;
    end;

  Result := False;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZone.GetPanelZones(AVisibleOnly: Boolean;
  AResult: TList);
var
  i: Integer;
begin
  if (FPanel <> nil) and (not AVisibleOnly or FPanel.PanelVisible) then
    AResult.Add(Self);
  for i := 0 to ZoneCount - 1 do
    Zones[i].GetPanelZones(AVisibleOnly, AResult);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZone.GetResizeKind: TLMDZoneResizeKind;
begin
  if FTree.FSpaceZone = Self then
    Result := zrkSpace
  else if FFixed then
    Result := zrkFixed
  else
    Result := zrkProportional;
end;

{ ***************************** TLMDDockZoneTree ***************************** }
{ ---------------------------------------------------------------------------- }
procedure TLMDDockZoneTree.ZoneDestroying(AZone: TLMDDockZone);
begin
  RemoveFromAutoHideZones(AZone);
  if FDragTabZone = AZone then
    FDragTabZone := nil;
  if FHotTabZone = AZone then
    FHotTabZone := nil;
  if FSpaceZone = AZone then
    FSpaceZone := nil;
  FSite.ZoneDestroying(AZone);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZoneTree.DoNormalizeZone(AZone: TLMDdockZone);
var
  i:  Integer;
  ch: TLMDDockZone;
begin
  for i := 0 to AZone.ZoneCount - 1 do
    DoNormalizeZone(AZone.Zones[i]);

  for i := AZone.ZoneCount - 1 downto 0 do
  begin
    ch := AZone.Zones[i];

    if (ch = FSpaceZone) and (AZone.FKind = zkTabs) then
      FSpaceZone := AZone;
    if ch.IsEmpty and (ch <> FSpaceZone) then
      ch.Free;
  end;

  if (AZone.ZoneCount = 1) and ((AZone.FKind <> zkTabs) or
                                not AZone.TabbedDocsHost) then
    AZone.CopyFrom(AZone.Zones[0]); // Of course, this will free
                                    // the child itself.

  if AZone.IsEmpty then
    AZone.FKind := zkPanel; // For sure.
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZoneTree.RemoveFromAutoHideZones(AZone: TLMDDockZone);
var
  i:   TAlign;
  idx: Integer;
begin
  for i := Low(TAlign) to High(TAlign) do
  begin
    idx := -1;
    if FAutoHideZones[i] <> nil then
      idx := FAutoHideZones[i].IndexOf(AZone);

    if idx <> -1 then
    begin
      FAutoHideZones[i].Delete(idx);
      Break; // for
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZoneTree.ClearAutoHideZones;
var
  i: TAlign;
begin
  for i := Low(TAlign) to High(TAlign) do
  begin
    if FAutoHideZones[i] <> nil then
      FAutoHideZones[i].Clear;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZoneTree.CorrectDocZones;
var
  i:   Integer;
  mgr: TLMDDockManager;
  zn:  TLMDDockZone;

  procedure EnsureDocTabs(AZone: TLMDDockZone);
  var
    idx, i:  Integer;
    pzns:    TList;
    ch, pzn: TLMDDockZone;
    svspc:   TLMDDockZone;
  begin
    if AZone.FKind <> zkTabs then
    begin
      ch        := TLMDDockZone.Create(Self);
      ch.FDSize := 1;
      ch.InternalSetBounds(Rect(0, 0, AZone.Width, AZone.Height));

      svspc := FSpaceZone;
      ch.CopyFrom(AZone);

      AZone.AddZone(ch);
      AZone.FKind := zkTabs;
      FSpaceZone  := svspc;
    end;

    idx  := 0;
    pzns := TList.Create;
    try
      while idx < AZone.ZoneCount do
      begin
        if AZone[idx].FKind <> zkPanel then
        begin
          ch := AZone[idx];

          pzns.Clear;
          ch.GetPanelZones(False, pzns);

          for i := 0 to pzns.Count - 1 do
          begin
            pzn        := TLMDDockZone(pzns[i]);
            pzn.FDSize := 1;
            pzn.InternalSetBounds(Rect(0, 0, AZone.Width, AZone.Height));

            AZone.AddZone(pzn, idx + i);
          end;

          ch.Free;
          Inc(idx, pzns.Count);
        end;
        Inc(idx);
      end;
    finally
      pzns.Free;
    end;
  end;

begin
  mgr := FSite.FManager;
  zn  := FSpaceZone;

  if ((mgr = nil) or mgr.UseTabbedDocs) and
     (zn <> nil) and not zn.IsEmpty then
  begin
    if zn.FKind in [zkHorz, zkVert] then
    begin
      for i := 0 to zn.ZoneCount - 1 do
        EnsureDocTabs(zn.Zones[i]);
    end
    else
      EnsureDocTabs(zn);
  end;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDDockZoneTree.Create(ASite: TLMDDockSite);
begin
  inherited Create;
  FSite                    := ASite;
  FRoot                    := TLMDDockZone.Create(Self);
  FSpaceZone               := FRoot;
  FHorzHandler             := THorzSeqHandler.Create;
  FVertHandler             := TVertSeqHandler.Create;
  FAutoHideZones[alLeft]   := TList.Create;
  FAutoHideZones[alTop]    := TList.Create;
  FAutoHideZones[alRight]  := TList.Create;
  FAutoHideZones[alBottom] := TList.Create;
  FHotTabBtn               := tbNone;
  FHotTabBtnDown           := False;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDockZoneTree.Destroy;
begin
  FRoot.Free;
  FHorzHandler.Free;
  FVertHandler.Free;
  FAutoHideZones[alLeft].Free;
  FAutoHideZones[alTop].Free;
  FAutoHideZones[alRight].Free;
  FAutoHideZones[alBottom].Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZoneTree.Clear;
begin
  FRoot.ClearZones;
  FRoot.InternalSetPanel(nil);
  ResetDragTab(False);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZoneTree.FindZoneByClient(
  AClient: TControl): TLMDDockZone;
var
  pnl: TLMDDockPanel;
begin
  Result := nil;
  pnl    := FSite.FindPanelByClient(AClient);
  if pnl <> nil then
    Result := pnl.FZone;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZoneTree.GetUnpinnedPanelZones(ASide: TAlign;
  AVisibleOnly: Boolean; AResult: TList);
var
  i: Integer;
  zn: TLMDDockZone;
begin
  for i := 0 to FAutoHideZones[ASide].Count - 1 do
    begin
      zn := TLMDDockZone(FAutoHideZones[ASide][i]);
      zn.GetPanelZones(AVisibleOnly, AResult);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockZoneTree.GetInsertingRect(AZone: TLMDDockZone;
  ADropAlign: TAlign; AClient: TControl): TRect;
var
  pntzn:      TLMDDockZone;
  hdr:        TSeqHandler;
  curzn:      TLMDDockZone;
  xsize:      Integer;
  i, itmlnt:  Integer;
  idx:        Integer;
  shift:      Integer;
  sitems:     TSeqItems;
  spltrw:     Integer;
  sz:         TLMDSeqZoneBase;
begin
  //!!! Wrong impl. Impl does not account
  //    zones content padding.

  pntzn := AZone.Parent;

  if (pntzn <> nil) and (pntzn.Kind = REQUIRED_ZONE_KIND[ADropAlign]) then
  begin
    if pntzn.Kind in [zkHorz, zkVert] then
    begin
      if pntzn.Kind = zkHorz then
      begin
        hdr := TSeqHandler(FHorzHandler);
        sz  := FSite.StyleElems.HorzZone;
      end
      else
      begin
        hdr := TSeqHandler(FVertHandler);
        sz  := FSite.StyleElems.VertZone;
      end;

      xsize := hdr.GetControlXSize(AClient);
      if xsize > (hdr.GetZoneXSize(pntzn) div 2) then
        xsize := (hdr.GetZoneXSize(pntzn) div 2);

      itmlnt := 0;
      idx    := -1;
      SetLength(sitems, pntzn.ZoneCount + 1);
      for i := 0 to pntzn.ZoneCount - 1 do
      begin
        curzn := pntzn.Zones[i];
        if curzn.ContainsVisibleContent then
        begin
          sitems[itmlnt].Kind  := sikProportional;
          sitems[itmlnt].Size  := hdr.GetZoneXSize(curzn);
          sitems[itmlnt].DSize := curzn.DSize;

          if curzn.ContainSpace then
            sitems[itmlnt].Kind := sikSpace;
          if curzn = AZone then
            idx := itmlnt + Ord(PLACE_AFTER_ZONE[ADropAlign]);

          Inc(itmlnt);
        end;
      end;
      SetLength(sitems, itmlnt + 1); // Set real length.

      for i := High(sitems) downto idx + 1 do
        sitems[i] := sitems[i - 1];
      sitems[idx].Kind  := sikPreserveSize;
      sitems[idx].Size  := xsize;
      sitems[idx].DSize := 0;

      spltrw := sz.GetSplitterSize;
      TSeqHandler.CalcLayout(sitems, hdr.GetZoneXSize(pntzn), spltrw);

      shift := 0;
      for i := 0 to idx - 1 do
        Inc(shift, sitems[i].Size + spltrw);

      Result := hdr.GetRealRect(hdr.GetZoneXMin(pntzn) + shift,
                                hdr.GetZoneYMin(pntzn),
                                sitems[idx].Size,
                                hdr.GetZoneYSize(pntzn));
    end
    else
      Result := pntzn.Bounds;
  end
  else if AZone.IsEmpty and (ADropAlign = alClient) then
  begin
    Result := AZone.Bounds;
  end
  else
  begin
    if REQUIRED_ZONE_KIND[ADropAlign] in [zkHorz, zkVert] then
    begin
      if REQUIRED_ZONE_KIND[ADropAlign] = zkHorz then
        hdr := TSeqHandler(FHorzHandler)
      else
        hdr := TSeqHandler(FVertHandler);

      xsize := hdr.GetControlXSize(AClient);
      if xsize > (hdr.GetZoneXSize(AZone) div 2) then
        xsize := (hdr.GetZoneXSize(AZone) div 2);

      Result := hdr.GetRealRect(hdr.GetZoneXMin(AZone), hdr.GetZoneYMin(AZone),
                                xsize, hdr.GetZoneYSize(AZone));
      if PLACE_AFTER_ZONE[ADropAlign] then
        hdr.OffsetRealRect(Result, hdr.GetZoneXSize(AZone) - xsize, 0);
    end
    else
      Result := AZone.Bounds;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZoneTree.Paint(ACanvas: TCanvas);
var
  sbe: TLMDSiteBackElem;
  bk:  TLMDElemState;
begin
  TLMDBuffer.BeginDraw(ACanvas, FSite.ClientRect);
  try
    sbe := FSite.StyleElems.SiteBack;
    bk  := sbe.GetBack(FSite.IsFloatingSite, FSite.IsFloatingDoc);

    bk.Draw(ACanvas, FSite.ClientRect);
    FRoot.Paint(ACanvas);
  finally
    TLMDBuffer.EndDraw;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZoneTree.InsertPanel(APanel: TLMDDockPanel;
  ADockTask: TObject);
type
  TExpandSpace = (esYes, esNo, esUnknown);
var
  dtsk:  TDockTask;
  zone,
  pnt,
  doctb,
  ch:    TLMDDockZone;
  idx:   Integer;
  expsp: TExpandSpace;
begin
  dtsk := TDockTask(ADockTask);
  zone := dtsk.Zone;
  pnt  := zone.Parent;

  if dtsk.ExactSet then
  begin
    zone.InternalSetPanel(APanel); // Special mode for streaming.
    Exit;
  end;

  if FSpaceZone = zone then
  begin
    if dtsk.Align in [TAlignEx(alDocTop), alDocBottom,
                      alDocLeft, alDocRight] then
      expsp := esYes
    else
      expsp := esNo;
  end
  else
    expsp := esUnknown;

  if (pnt = nil) or (pnt.Kind <> REQUIRED_ZONE_KIND[dtsk.Align]) or
     (expsp = esYes) then
  begin
    pnt := zone;

    if (pnt.Kind <> REQUIRED_ZONE_KIND[dtsk.Align]) then
    begin
      zone := TLMDDockZone.Create(Self);
      zone.CopyFrom(pnt);
      zone.FDSize := 1;
      zone.InternalSetBounds(Rect(0, 0, pnt.Width, pnt.Height));

      pnt.AddZone(zone);
      pnt.FKind := REQUIRED_ZONE_KIND[dtsk.Align];

      if expsp = esYes then
        FSpaceZone := pnt
      else if (pnt = FRoot) and FSite.UseSpace and
              (FSpaceZone = nil) then
        FSpaceZone := zone;
    end
    else
    begin
      if PLACE_AFTER_ZONE[dtsk.Align] then
        zone := pnt.Zones[pnt.ZoneCount - 1]
      else
        zone := pnt.Zones[0];
    end;
  end;

  ch := TLMDDockZone.Create(Self, APanel);
  ch.InternalSetInserting(dtsk.Width, dtsk.Height);

  if pnt.TabbedDocsHost and (pnt.FKind <> zkTabs) then
  begin
    doctb        := TLMDDockZone.Create(Self);
    doctb.FKind  := zkTabs;
    doctb.InternalSetInserting(dtsk.Width, dtsk.Height);

    doctb.AddZone(ch);
    ch := doctb;
  end;

  if dtsk.Index <> -1 then
    idx := dtsk.Index
  else
  begin
    if dtsk.Align = alClient then
      idx := 0
    else
      idx := zone.Index + Ord(PLACE_AFTER_ZONE[dtsk.Align]);
  end;

  pnt.AddZone(ch, idx);
  if (pnt.Kind = zkTabs) and dtsk.SelectPage then
    pnt.FSelectedPage := ch;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZoneTree.RemovePanel(APanel: TLMDDockPanel);
begin
  if (APanel.FZone <> nil) and (APanel.FZone.FTree = Self) then
    APanel.FZone.InternalSetPanel(nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZoneTree.NormalizeZones;
begin
  DoNormalizeZone(FRoot);
  CorrectDocZones;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZoneTree.UpdateLayout(AActivate: TLMDDockPanel);
var
  se:     TLMDDockElems;
  r:      TRect;
  cr, sr: TRect;

  function GetSideSize(ASide: TAlign): Integer;
  var
    i:  Integer;
    zn: TLMDDockZone;
  begin
    for i := 0 to FAutoHideZones[ASide].Count - 1 do
    begin
      zn := TLMDDockZone(FAutoHideZones[ASide][i]);
      if zn.HasPanelZones(True) then
      begin
        Result := se.GetPinArea(alLeft).GetSize(FSite.Font);
        Exit;
      end;
    end;
    Result := 0;
  end;

begin
  ClearAutoHideZones;
  NormalizeZones;

  se                  := FSite.StyleElems;
  r                   := FSite.ClientRect;
  FRoot.FAutoHide     := False; // For sure.
  FRoot.FAutoHideSide := alNone;
  FRoot.FShowing      := True;

  FRoot.UpdateAutoHide;

  FBorderBounds := Rect(r.Left + GetSideSize(alLeft),
                        r.Top + GetSideSize(alTop),
                        r.Right - GetSideSize(alRight),
                        r.Bottom - GetSideSize(alBottom));
  se.SiteBack.GetAreas(FBorderBounds, FSite.IsFloatingSite,
                       FSite.IsFloatingDoc, cr);

  sr := Rect(r.Left, cr.Top, FBorderBounds.Left, cr.Bottom);
  TAutoHideSide(FSite.FAutoHideSides[alLeft]).UpdateLayout(sr);

  sr := Rect(cr.Left, r.Top, cr.Right, FBorderBounds.Top);
  TAutoHideSide(FSite.FAutoHideSides[alTop]).UpdateLayout(sr);

  sr := Rect(FBorderBounds.Right, cr.Top, r.Right, cr.Bottom);
  TAutoHideSide(FSite.FAutoHideSides[alRight]).UpdateLayout(sr);

  sr := Rect(cr.Left, FBorderBounds.Bottom, cr.Right, r.Bottom);
  TAutoHideSide(FSite.FAutoHideSides[alBottom]).UpdateLayout(sr);

  FActivatePanel := AActivate;
  FDeferHandle   := BeginDeferWindowPos(16);
  try
    FRoot.InternalSetBounds(cr);
    FRoot.UpdateLayout;
  finally
    EndDeferWindowPos(FDeferHandle);
    FDeferHandle   := 0;
    FActivatePanel := nil;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZoneTree.SetDragTab(ATabZone: TLMDDockZone;
  ATabInfo: TLMDDragTabInfo; AInvalidate: Boolean);
var
  oldzn:  TLMDDockZone;
  oldnfo: TLMDDragTabInfo;
begin
  oldzn        := FDragTabZone;
  oldnfo       := FDragTabInfo;
  FDragTabZone := ATabZone;
  FDragTabInfo := ATabInfo;

  if oldzn <> nil then
    oldzn.UpdateDockTracking;
  if FDragTabZone <> nil then
    FDragTabZone.UpdateDockTracking;

  if AInvalidate and FSite.HandleAllocated and (oldzn <> FDragTabZone) or
     (oldnfo.ZoneIndex <> FDragTabInfo.ZoneIndex) then
  begin
    if oldzn <> nil then
      InvalidateRect(FSite.Handle, @oldzn.FTabArea, True);
    if FDragTabZone <> nil then
      InvalidateRect(FSite.Handle, @FDragTabZone.FTabArea, True);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZoneTree.SetHotBtn(AHotBtn: TLMDTabBtnKind;
  AHotDown: Boolean; AInvalidate: Boolean);
var
  obtn:  TLMDTabBtnKind;
  odown: Boolean;
begin
  obtn           := FHotTabBtn;
  odown          := FHotTabBtnDown;
  FHotTabBtn     := AHotBtn;
  FHotTabBtnDown := AHotDown;

  if AInvalidate and FSite.HandleAllocated and ((obtn <> FHotTabBtn) or
                                                (odown <> FHotTabBtnDown)) then
  begin
    if FHotTabZone <> nil then
      InvalidateRect(FSite.Handle, @FHotTabZone.FTabArea, True);
  end;
end;

procedure TLMDDockZoneTree.SetHotTab(ATabZone: TLMDDockZone;
  ATabIndex: Integer; AInvalidate: Boolean);
var
  ozn:  TLMDDockZone;
  oidx: Integer;
begin
  ozn          := FHotTabZone;
  oidx         := FHotTabIndex;
  FHotTabZone  := ATabZone;
  FHotTabIndex := ATabIndex;

  if AInvalidate and FSite.HandleAllocated and ((ozn <> FHotTabZone) or
                                                (oidx <> FHotTabIndex)) then
  begin
    if ozn <> nil then
      InvalidateRect(FSite.Handle, @ozn.FTabArea, True);
    if FHotTabZone <> nil then
      InvalidateRect(FSite.Handle, @FHotTabZone.FTabArea, True);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZoneTree.ResetDragTab(AInvalidate: Boolean);
var
  old: TLMDDockZone;
begin
  old                    := FDragTabZone;
  FDragTabZone           := nil;
  FDragTabInfo.ZoneIndex := -1;
  FDragTabInfo.Client    := nil;

  if old <> nil then
    old.UpdateDockTracking;

  if AInvalidate and FSite.HandleAllocated and (old <> nil) then
    InvalidateRect(FSite.Handle, @old.FTabArea, True);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZoneTree.ResetHotTab(AInvalidate: Boolean);
var
  old: TLMDDockZone;
begin
  old          := FHotTabZone;
  FHotTabZone  := nil;
  FHotTabIndex := -1;

  if AInvalidate and FSite.HandleAllocated and (old <> nil) then
    InvalidateRect(FSite.Handle, @old.FTabArea, True);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockZoneTree.ResetTabBtn(AInvalidate: Boolean);
var
  obtn:  TLMDTabBtnKind;
  odown: Boolean;
begin
  obtn           := FHotTabBtn;
  odown          := FHotTabBtnDown;
  FHotTabBtn     := tbNone;
  FHotTabBtnDown := False;

  if AInvalidate and FSite.HandleAllocated and ((obtn <> FHotTabBtn) or
                                                (odown <> FHotTabBtnDown)) then
  begin
    if FHotTabZone <> nil then
      InvalidateRect(FSite.Handle, @FHotTabZone.FTabArea, True);
  end;
end;

{ ******************************* TLMDDockSite ******************************* }
{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := -1;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.WMNCHitTest(var Message: TWMNCHitTest);
var
  p: TPoint;
begin
  p := SmallPointToPoint(Message.Pos);
  MapWindowPoints(0, Handle, p, 1);

  if WantsTransparency(p) then
    Message.Result := HTTRANSPARENT
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.WMSetCursor(var Message: TWMSetCursor);
const
  SPLTR_CURSORS: array[Boolean] of TCursor = (crHSplit, crVSplit);
var
  ms:   TPoint;
  htst: TLMDDockSiteHitTest;
begin
  GetCursorPos(ms);
  htst := GetHitTest(ScreenToClient(ms));

  if (htst.Kind = hkSplitter) and not (dlmSplitterResize in FLockMode) then
    Windows.SetCursor(Screen.Cursors[SPLTR_CURSORS[htst.Zone.Kind = zkVert]])
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.WMContextMenu(var Message: TWMContextMenu);
var
  P:    TPoint;
  chzn: TLMDDockZone;
  htst: TLMDDockSiteHitTest;
begin
  p    := SmallPointToPoint(Message.Pos);
  htst := GetHitTest(ScreenToClient(p));

  if (htst.Kind = hkZone) and (htst.ZoneArea = hzaTabs) and
     (htst.Index <> -1) then
  begin
    chzn := htst.Zone.Tabs[htst.Index].Zone;
    if (chzn <> nil) and (chzn.Panel <> nil) then
      chzn.Panel.HeaderPopup(p);
  end
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
  EndSplitterSizing(False);
  CancelTracking;
  Exclude(FState, dssTabBtnDown);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.CMDrag(var Message: TCMDrag);
var
  cp:   TPoint;
  src:  TDragDockObject;
begin
  FInDragMsg := True;
  try
    if Message.DragRec.Docking then
    begin
      cp  := ScreenToClient(Message.DragRec^.Pos);
      src := TDragDockObject(Message.DragRec.Source);

      case Message.DragMessage of
        dmDragLeave:    if not src.Dropped then
                          EndDockTracking;
        dmDragCancel:   EndDockTracking;
      else
        UpdateDockTracking(cp, src.Control, src);
      end;
    end;

    inherited;

    if Message.DragRec.Docking and (Message.DragMessage = dmDragDrop) then
      EndDockTracking(False); // No invalidate.
  finally
    FInDragMsg := False;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.CMDockNotification(
  var Message: TCMDockNotification);
var
  pnl: TLMDDockPanel;
begin
  inherited;
  case Message.NotifyRec^.ClientMsg of
    CM_VISIBLECHANGED:
    begin
      pnl := FindPanelByClient(Message.Client);
      if (pnl <> nil) and (pnl.FClientControl <> nil) then
        pnl.PanelVisible := pnl.FClientControl.Visible;
    end;
    WM_SETTEXT:
    begin
      pnl := FindPanelByClient(Message.Client);
      if (pnl <> nil) and (pnl.FClientControl <> nil) then
        pnl.Caption := LMDGetClientCaption(Message.Client);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.CMFontChanged(var Message: TMessage);
begin
  inherited;
  UpdateLayout;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  CancelTracking;
end;

{$IFDEF LMDCOMP16}
procedure TLMDDockSite.CMStyleChanged(var Message: TMessage);
begin
  TDockStylesAccess(DockStyles).VCLStyleChanged;
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.CNKeyDown(var Message: TWMKeyDown);
begin
  inherited;
  EndSplitterSizing(False);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.ZoneDestroying(AZone: TLMDDockZone);
var
  i: TLMDHotSpotKind;
  j: TAlign;
begin
  for i := Low(TLMDHotSpotKind) to High(TLMDHotSpotKind) do
  begin
    if FHotspots[i] <> nil then
      THotSpot(FHotspots[i]).ZoneDestroying(AZone);
  end;

  for j := Low(TAlign) to High(TAlign) do
  begin
    if FAutoHideSides[j] <> nil then
      TAutoHideSide(FAutoHideSides[j]).ZoneDestroying(AZone);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.CancelTracking;
begin
  FZoneTree.ResetHotTab;
  FZoneTree.ResetTabBtn;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.ClearLoadingPanels;
begin
  while FLoadingPanels.Count > 0 do
    TLMDDockPanel(FLoadingPanels[0]).InternalSetLoadingSite(nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.InsertOrUpdatePanel(APanel: TLMDDockPanel;
  ADockTask: TObject);
begin
  if APanel.FSite <> Self then
  begin
    if (APanel.HostDockSite <> nil) and (APanel.HostDockSite <> Self) and
       not (csDestroying in APanel.HostDockSite.ComponentState) then
    begin
      APanel.HostDockSite.Perform(CM_UNDOCKCLIENT, 0, LPARAM(APanel));
      APanel.Dock(NullDockSite, APanel.BoundsRect);
    end;

    APanel.FSite  := Self;
    APanel.Parent := Self; // Required! See the comment below.
    FPanels.Add(APanel);
  end;

  FZoneTree.InsertPanel(APanel, ADockTask);

  UpdateLayout(True); // Generally UpdateLayout will set the Parent of the
                      // panel. But! The layout updating is skipped, if the
                      // site's handle is not allocated. This can lead to
                      // situation, when the panel's Parent is updated too late.
                      // For example, if the panel was a hidden floating panel
                      // it will be destroyed during old floating site
                      // destruction.
  NotifyFloatForm;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.RemovePanel(APanel: TLMDDockPanel);
begin
  if APanel.FSite = Self then
  begin
    FZoneTree.RemovePanel(APanel);

    FPanels.Remove(APanel);
    if FShiftingPanel = APanel then
      FShiftingPanel := nil;
    APanel.FSite := nil;

    if APanel.FZone <> nil then
      APanel.FZone.InternalSetPanel(nil);
    APanel.FClientControl := nil;

    if not (csDestroying in APanel.ComponentState) and
       (APanel.HostDockSite = nil) or (APanel.HostDockSite = Self) then
      APanel.Parent := nil;

    UpdateLayout(True);
    NotifyFloatForm;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.PanelUIStateChanged(APanel: TLMDDockPanel);
begin
  if APanel = FShiftingPanel then
  begin
    if not APanel.PanelVisible then
      SetShifingPanel(nil, alNone, True, False);
  end;
  if APanel.FZone <> nil then
    APanel.FZone.PanelUIStateChanged(APanel);

  NotifyFloatForm;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.PopupTabsMenu(AZone: TLMDDockZone);
var
  p:   TPoint;
  itm: TMenuItem;
  i:   Integer;
begin
  if FTabsMenu <> nil then
    FTabsMenu.Free;
  FTabsMenu := TPopupMenu.Create(nil);

  p := ClientToScreen(Point(AZone.FTabAreaBtns[tbMenu].Left,
                            AZone.FTabAreaBtns[tbMenu].Bottom));

  for i := 0 to AZone.TabCount - 1 do
  begin
    itm := TTabMenuItem.Create(FTabsMenu, AZone, i);
    FTabsMenu.Items.Add(itm);
  end;

  FTabsMenu.Popup(p.X, p.Y); // We can't free menu right after popup,
                             // because in this case no menu item click
                             // will occures.
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.DestroyPanels;
begin
  while FPanels.Count > 0 do
    TObject(FPanels[0]).Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.InternalDockControl(AControl: TControl;
  ADropOnZone: TLMDDockZone; AAlign: TAlign; AIndex: Integer;
  ASelectPage: Boolean; AExactSet: Boolean);
var
  dtsk: TDockTask;
begin
  dtsk := TDockTask.Create;
  try
    if ADropOnZone = nil then
      ADropOnZone := FZoneTree.Root;
    if AAlign = alNone then
      AAlign := alClient;

    dtsk.Client     := AControl;
    dtsk.Zone       := ADropOnZone;
    dtsk.ExactSet   := AExactSet;
    dtsk.Align      := AAlign;
    dtsk.Index      := AIndex;
    dtsk.SelectPage := ASelectPage;
    dtsk.Width      := AControl.Width;
    dtsk.Height     := AControl.Height;

    FDockTask := dtsk;

    if AControl.HostDockSite <> nil then
      AControl.HostDockSite.Perform(CM_UNDOCKCLIENT, 0, LPARAM(AControl));
    AControl.Dock(Self, AControl.BoundsRect);

    DoDockTask;
  finally
    dtsk.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSite.GetClientKind(AClient: TControl): TLMDDockClientKind;
begin
  if (FManager = nil) or FManager.FUseTabbedDocs then
  begin
    if FManager <> nil then
      Result := FManager.DoGetClientKind(AClient)
    else if AClient is TLMDDockPanel then
      Result := TLMDDockPanel(AClient).FClientKind
    else
      Result := dkTool;
  end
  else
    Result := dkTool;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSite.FindHotspot(const P: TPoint): TObject;
var
  i:    TLMDHotSpotKind;
  gp:   TPoint;
  zone: TLMDDockZone;
  algn: TAlign;
begin
  gp := ClientToScreen(P);
  for i := Low(TLMDHotSpotKind) to High(TLMDHotSpotKind) do
    if (FHotspots[i] <> nil) and
       THotSpot(FHotspots[i]).GetHotSpotInfo(gp, zone, algn) then
    begin
      Result := THotSpot(FHotspots[i]);
      Exit;
    end;

  Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSite.GetDragInfo(const P: TPoint;
  AClient: TControl; ASource: TDragDockObject): TLMDDragInfo;
const
  SPL_ALIGNS: array[Boolean] of TAlign = (alRight, alBottom);
var
  hspt: THotSpot;
  zone: TLMDDockZone;
  algn: TAlign;
  htst: TLMDDockSiteHitTest;
begin
  Result.Zone      := nil;
  Result.Align     := alNone;
  Result.Index     := -1;
  Result.Rect      := Rect(0, 0, 0, 0);
  Result.TabInRect := False;

  hspt := THotSpot(FindHotspot(P));

  if (hspt <> nil) and hspt.GetHotSpotInfo(ClientToScreen(P),
                                           zone, algn) then
  begin
    Result.Zone  := zone;
    Result.Align := algn;
  end
  else
  begin
    htst := GetHitTest(P);

    if FSplitterAreas and (htst.Kind = hkSplitter) then
    begin
      Result.Zone  := htst.Zone.Splitters[htst.Index].ZoneA;
      Result.Align := SPL_ALIGNS[htst.Zone.Kind <> zkHorz];
    end
    else if FZoneTabAreas and (htst.Kind = hkZone) and
            (htst.ZoneArea = hzaTabs) then
    begin
      Result.Zone  := htst.Zone;
      Result.Align := alClient;
      Result.Index := htst.Zone.GetInsertingTabIndex(P, AClient);
    end;
  end;

  if Result.Zone <> nil then
  begin
    Result.Rect := FZoneTree.GetInsertingRect(Result.Zone, Result.Align,
                                              AClient);

    if (Result.Align = alClient) and (Result.Zone.TabCount > 0) then
    begin
      if Result.Zone.TabbedDocsHost then
        Inc(Result.Rect.Top, Result.Zone.FTabArea.Bottom -
            Result.Zone.FTabArea.Top)
      else
        Dec(Result.Rect.Bottom, Result.Zone.FTabArea.Bottom -
            Result.Zone.FTabArea.Top);
    end;

    if (Result.Align = alClient) and
       (((Result.Zone.Kind = zkPanel) and (Result.Zone.Panel <> nil) and
         Result.Zone.Panel.PanelVisible) or
        ((Result.Zone.Kind = zkTabs) and (Result.Zone.TabCount = 0) and
         (Result.Zone.FSelectedPage <> nil))) then
      Result.TabInRect := True;
  end;

  if (Result.Zone <> nil) and (ASource <> nil) and
     not DoDockOver(ASource, Result.Zone, Result.Align) then
    Result.Zone := nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSite.GetFloatingForm: TLMDFloatingForm;
begin
  Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSite.GetPanelButtons(
  APanel: TLMDDockPanel): TLMDPanelBtnKinds;
var
  b:   TLMDPanelBtnKind;
  zn:  TLMDDockZone;
  add: Boolean;
begin
  Result := [];
  zn     := APanel.FZone;

  for b := Low(TLMDPanelBtnKind) to High(TLMDPanelBtnKind) do
  begin
    case B of
      pbMenu:     add := True;
      pbPin:      add := (zn <> nil) and (zn.AutoHideSide <> alNone) and
                         not (dlmPanelAutoHide in FLockMode);
      pbClose:    add := not (dlmPanelClose in FLockMode);
    else
      add := False;
    end;

    if add and (b in APanel.FButtons) then
      Include(Result, b);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSite.GetPanelCount: Integer;
begin
  Result := FPanels.Count;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSite.GetPanels(AIndex: Integer): TLMDDockPanel;
begin
  Result := TLMDDockPanel(FPanels[AIndex]);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSite.GetRootZone: TLMDDockZone;
begin
  Result := FZoneTree.Root;
end;

procedure TLMDDockSite.GetSiteInfo(Client: TControl; var InfluenceRect: TRect;
  MousePos: TPoint; var CanDock: Boolean);
var
  c: TWinControl;
begin
  CanDock := CanDock and not (dlmDockIn in FLockMode);

  if CanDock then
  begin
    // Here is a workaround of the following issue:
    //
    // If two dock-sites exist in the project on different forms, and one
    // floating panel is placed above second dock-site, then another one
    // panel will not be able to dock into first floating panel, because
    // no hot-spot will be shown.
    // This happens due to wrong selection of the target site in VCL's
    // QualifyingSites.GetTopSite method.

    c := FindVCLWindow(MousePos);
    while (c <> nil) and (c <> Self) do
    begin
      if c is TFloatingSite then
      begin
        CanDock := False;
        Break; // while
      end;
      c := c.Parent;
    end;
  end;

  inherited;
end;

function TLMDDockSite.GetSpaceZone: TLMDDockZone;
begin
  Result := FZoneTree.Space;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSite.DockTaskFromDropInfo(AClient: TControl;
  AWidth, AHeight: Integer; const ADropInfo: TLMDDragInfo;
  AManualDockSrc: TDragDockObject): TObject;
var
  dtsk: TDockTask;
begin
  dtsk := TDockTask.Create;
  try
    dtsk.Client     := AClient;
    dtsk.Zone       := ADropInfo.Zone;
    dtsk.ExactSet   := False;
    dtsk.Align      := ADropInfo.Align;
    dtsk.Index      := ADropInfo.Index;
    dtsk.SelectPage := True;
    dtsk.Width      := AWidth;
    dtsk.Height     := AHeight;

    if (dtsk.Zone = nil) and (AManualDockSrc <> nil) then // Manual docking.
    begin
      dtsk.Zone  := FZoneTree.FindZoneByClient(AManualDockSrc.DropOnControl);
      dtsk.Align := AManualDockSrc.DropAlign;
    end;
    if dtsk.Zone = nil then // Still nil, set default.
    begin
      dtsk.Zone  := FZoneTree.Root;
      dtsk.Align := alClient;
    end;
  except
    dtsk.Free;
    raise;
  end;

  Result := dtsk;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSite.UpdateDockTracking(const P: TPoint;
  AClient: TControl; ASource: TDragDockObject): TLMDDragInfo;

  procedure BuiltinTabbedDocAdjust(const AHitTest: TLMDDockSiteHitTest;
                                   var EnabledAreas: TLMDActiveAreas);
  const
    DOCSHOST_AREAS: array[Boolean] of TLMDActiveAreas = (
      [hsaSplitters, hsaTabAreas, hsaTabs],
      []
    );
  begin
    if Self.IsFloatingDoc then
      EnabledAreas := []
    else if GetClientKind(AClient) = dkDocument then
      EnabledAreas := EnabledAreas - [hsaSiteLeft, hsaSiteTop,
                                      hsaSiteRight, hsaSiteBottom,
                                      hsaZoneLeft, hsaZoneTop,
                                      hsaZoneRight, hsaZoneBottom] -
                      DOCSHOST_AREAS[(AHitTest.Zone <> nil) and
                                      AHitTest.Zone.TabbedDocsHost];
  end;

var
  i:       TLMDHotSpotKind;
  htst:    TLMDDockSiteHitTest;
  srec,
  zrec:    TRect;
  dtnfo:   TLMDDragTabInfo;
  amask:   TLMDActiveAreas;
  areas:   TLMDActiveAreas;
  areaszn: TLMDDockZone;
  tdnfo:   TLMDTabbedDocsInfo;
begin
  htst := GetHitTest(P);

  { Detect visible hotspots and enabled areas }

  GetWindowRect(Handle, srec);
  if htst.Kind = hkZone then
  begin
    zrec := htst.Zone.Bounds;
    MapWindowPoints(Handle, 0, zrec, 2);
  end
  else
    zrec := srec;

  areaszn := nil;
  amask   := [hsaSiteLeft, hsaSiteTop, hsaSiteRight, hsaSiteBottom,
              hsaSplitters, hsaTabAreas];

  case htst.Kind of
    hkZone:       begin
                    areaszn := htst.Zone;
                    amask   := amask + [hsaZoneLeft, hsaZoneTop,
                                        hsaZoneRight, hsaZoneBottom,
                                        hsaTabs];

                    if htst.Zone.TabbedDocsInfo(tdnfo) then
                      amask  := (amask + [hsaDocsLeft, hsaDocsTop,
                                          hsaDocsRight, hsaDocsBottom]) *
                                tdnfo.AreasMask;
                  end;
    hkSplitter:   begin
                    if htst.Zone.TabbedDocsInfo(tdnfo) then
                      amask  := amask * tdnfo.AreasMask;
                  end;
  end;

  areas := amask;
  if not UseSpace then
    areas := areas - [hsaSiteLeft, hsaSiteTop, hsaSiteRight, hsaSiteBottom];
  BuiltinTabbedDocAdjust(htst, areas);

  DoUpdateHotSpots(AClient, areaszn, areas);
  areas := areas * amask; // Masked areas ensure integrity of the
                          // tabbed document zones and cannot be
                          // overridden.

  { Update hotspots visible }

  for i := Low(TLMDHotSpotKind) to High(TLMDHotSpotKind) do
  begin
    if HOTSPOT_AREAS[i] * areas <> [] then
    begin
      if FHotspots[i] = nil then
        FHotspots[i] := THotSpot.Create(Self);
      THotSpot(FHotspots[i]).Show(i, Self, htst.Zone, areas,
                                  srec, zrec);
    end
    else if FHotspots[i] <> nil then
      THotSpot(FHotspots[i]).Hide;
  end;

  FSplitterAreas := (hsaSplitters in areas);
  FZoneTabAreas  := (hsaTabAreas in areas);

  { Update tabs tracking }

  Result := GetDragInfo(P, AClient, ASource);

  if (Result.Zone <> nil) and (Result.Zone.Kind = zkTabs) and
     (Result.Align = alClient) and (Length(Result.Zone.FTabs) > 0) then
  begin
    dtnfo.ZoneIndex := Result.Index;
    dtnfo.Client    := AClient;
    FZoneTree.SetDragTab(Result.Zone, dtnfo);
  end
  else
    FZoneTree.ResetDragTab;

  UpdateTracking; // For sure.
  {$IFDEF LMD_DCK_UPDATE}Update;{$ENDIF}
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSite.StyleElems: TLMDDockElems;
begin
  Result := GetDefDockElems(FManager);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.EndDockTracking(AInvalidate: Boolean);
var
  i: TLMDHotSpotKind;
begin
  for i := Low(TLMDHotSpotKind) to High(TLMDHotSpotKind) do
    if FHotspots[i] <> nil then
      THotSpot(FHotspots[i]).Hide;
  FZoneTree.ResetDragTab(AInvalidate);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.DesignDrag(APanel: TLMDDockPanel;
  ADragMsg: TDragMessage; const P: TPoint; var R: TRect;
  var AShowRect: Boolean; var ATabInRect: Boolean);
var
  cp:   TPoint;
  dnfo: TLMDDragInfo;
  dtsk: TDockTask;
begin
  R          := Rect(0, 0, 0, 0);
  cp         := ScreenToClient(P);
  dnfo       := UpdateDockTracking(cp, APanel);
  AShowRect  := False;
  ATabInRect := dnfo.TabInRect;

  case ADragMsg of
    dmDragMove:
      if dnfo.Zone <> nil then
      begin
        R := dnfo.Rect;
        MapWindowPoints(Handle, 0, R, 2);
        AShowRect := True;
      end;
    dmDragCancel:
      EndDockTracking;
    dmDragDrop:
    begin
      EndDockTracking(False);

      if dnfo.Zone <> nil then
      begin
        dtsk := TDockTask(DockTaskFromDropInfo(APanel, dnfo.Rect.Right -
                                               dnfo.Rect.Left, dnfo.Rect.
                                               Bottom - dnfo.Rect.Top, dnfo));
        try
          FDockTask := dtsk;
          DoDockTask;
        finally
          dtsk.Free;
        end;

        NotifyDesigner(Self);
      end;
    end;
  end;
end;

function TLMDDockSite.DesignWndProc(var Message: TMessage): Boolean;
var
  htst: TLMDDockSiteHitTest;
begin
  if (Message.Msg >= WM_MOUSEFIRST) and (Message.Msg <= WM_MOUSELAST) then
  begin
    htst   := GetHitTest(SmallPointToPoint(TWMMouse(Message).Pos));
    Result := (dssSplitSizing in FState) or (htst.Kind = hkSplitter) or
              ((htst.Kind = hkZone) and (htst.ZoneArea = hzaTabs) and
               (htst.Index <> -1));
  end
  else
    Result := inherited DesignWndProc(Message);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.ZoneSizingFinishProc(AAccept: Boolean;
  AData: TObject; AData2: Integer; const ASpltBounds: TRect);
var
  zone:    TLMDDockZone;
  spltr:   TLMDZoneSplitterInfo;
  oldbnds: TRect;
  offset, w1, h1, w2, h2: Integer;
begin
  zone    := TLMDDockZone(AData);
  spltr   := zone.Splitters[AData2];
  oldbnds := spltr.Bounds;

  if AAccept then
  begin
    if zone.Kind = zkHorz then
    begin
      offset := ASpltBounds.Left - oldbnds.Left;
      w1     := spltr.ZoneA.Width + offset;
      h1     := spltr.ZoneA.Height;
      w2     := spltr.ZoneB.Width - offset;
      h2     := spltr.ZoneB.Height;
    end
    else
    begin
      offset := ASpltBounds.Top - oldbnds.Top;
      w1     := spltr.ZoneA.Width;
      h1     := spltr.ZoneA.Height + offset;
      w2     := spltr.ZoneB.Width;
      h2     := spltr.ZoneB.Height - offset;
    end;

    if offset <> 0 then
    begin
      spltr.ZoneA.InternalSetInserting(w1, h1);
      spltr.ZoneB.InternalSetInserting(w2, h2);
      UpdateLayout(True);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.PanelButtonClick(APanel: TLMDDockPanel;
  B: TLMDPanelBtnKind);
var
  zn:  TLMDDockZone;
  p:   TPoint;
  bd: ^TLMDButtonsData;
begin
  zn := APanel.FZone;
  bd := @APanel.FButtonsData;

  case B of
    pbMenu:   if (APanel.FHeaderMenu <> nil) and
                 not (csDesigning in ComponentState) then
              begin
                p := Point(bd.Buttons[B].Left, bd.Buttons[B].Bottom + 1);
                APanel.HeaderPopup(APanel.ClientToScreen(p));
              end;
    pbPin:    if (zn <> nil) and (zn.AutoHideSide <> alNone) then
              begin
                if zn.IsAutoHidden then
                begin
                 while zn <> nil do
                 begin
                   zn.FAutoHide := False;
                   if (zn.Parent <> nil) and (zn.Parent.Kind = zkTabs) and
                      (zn.Parent.FSelectedPage <> zn) then
                     zn.Parent.FSelectedPage := zn;
                   zn := zn.Parent;
                 end;
                 UpdateLayout(True);
                end
                else
                begin
                  if (zn.Parent <> nil) and (zn.Parent.Kind = zkTabs) then
                    zn := zn.Parent;
                  zn.FAutoHide := True;

                  APanel.Deactivate;
                  UpdateLayout(True);
                  SetShifingPanel(APanel, APanel.FZone.AutoHideSide,
                                  False, False);
                end;
                NotifyDesigner(Self);
              end;
    pbClose:  APanel.Close;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.PanelSizingFinishProc(AAccept: Boolean;
  AData: TObject; AData2: Integer; const ASpltBounds: TRect);
var
  pnl:  TLMDDockPanel;
  bnds: TRect;
begin
  if AAccept then
  begin
    pnl  := TLMDDockPanel(AData);
    bnds := pnl.BoundsRect;

    LMDSetRectSide(bnds, pnl.FSpltrSide, LMDGetRectSide(ASpltBounds,
                   pnl.FSpltrSide));
    pnl.BoundsRect := bnds;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.BeginSplitterSizing(AZone: TLMDdockZone;
  ASplIndex: Integer; const P: TPoint);
var
  area:  TRect;
  spltr: TLMDZoneSplitterInfo;
begin
  EndSplitterSizing(False);
  Include(FState, dssSplitSizing);

  spltr       := AZone.Splitters[ASplIndex];
  area        := Rect(spltr.ZoneA.Left, spltr.ZoneA.Top,
                      spltr.ZoneB.Bounds.Right, spltr.ZoneB.Bounds.Bottom);
  FSplitSizer := TSplitterSizer.Create(Self, (AZone.Kind <> zkHorz), area,
                                       spltr.Bounds, AZone, ASplIndex,
                                       ZoneSizingFinishProc);
  TSplitterSizer(FSplitSizer).Update(P);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.BeginSplitterSizing(APanel: TLMDDockPanel;
  const P: TPoint);
var
  splbnds: TRect;
begin
  EndSplitterSizing(False);
  Include(FState, dssSplitSizing);

  splbnds := APanel.FSpltrArea;
  MapWindowPoints(APanel.Handle, Handle, splbnds, 2);

  FSplitSizer := TSplitterSizer.Create(Self,
                                       APanel.FSpltrSide in [alTop, alBottom],
                                       FZoneTree.Root.Bounds,
                                       splbnds, APanel, 0,
                                       PanelSizingFinishProc);
  TSplitterSizer(FSplitSizer).Update(P);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.UpdateSplitterSizing(const P: TPoint);
begin
  if dssSplitSizing in FState then
    TSplitterSizer(FSplitSizer).Update(P);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.UpdateTracking;
var
  p:    TPoint;
  htst: TLMDDockSiteHitTest;
begin
  p    := ScreenToClient(Mouse.CursorPos);
  htst := GetHitTest(p);
     
  if dssSplitSizing in FState then
    CancelTracking
  else if dssTabBtnDown in FState then
    // Do nothing
  else if (GetCapture = 0) and (htst.Kind = hkZone) and 
          (htst.Zone <> nil) and (htst.ZoneArea = hzaTabs) then
  begin
    FZoneTree.SetHotTab(htst.Zone, htst.Index);
    FZoneTree.SetHotBtn(htst.TabBtn, False);
  end
  else
    CancelTracking;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.EndSplitterSizing(AAccept: Boolean);
begin
  if dssSplitSizing in FState then
  begin
    TSplitterSizer(FSplitSizer).Finish(AAccept);

    FSplitSizer.Free;
    FSplitSizer := nil;
    Exclude(Fstate, dssSplitSizing);

    if AAccept then
      NotifyDesigner(Self);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.SetLockMode(const Value: TLMDDockSiteLockMode);
begin
  if FLockMode <> Value then
  begin
    FLockMode := Value;
    UpdateLayout(True);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.SetManager(const Value: TLMDDockManager);
begin
  if FManager <> Value then
  begin
    if FManager <> nil then
      FManager.RemoveFreeNotification(Self);
    FManager := Value;
    if FManager <> nil then
      FManager.FreeNotification(Self);
    ManagerChanged;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.SetShifingPanel(APanel: TLMDDockPanel;
  ASide: TAlign; AOpen, AActivate: Boolean; AImmediateInvert: Boolean);
const
  STATES: array[Boolean] of TLMDAutoHideState = (ahsOpened, ahsClosed);
var
  old:   TLMDDockPanel;
  rbnds: TRect;
begin
  if (FShiftingPanel <> APanel) or (FShiftingSide <> ASide) then
  begin
    old            := FShiftingPanel;
    FShiftingPanel := APanel;
    FShiftingSide  := ASide;

    if old <> nil then
    begin
      old.OnSiteShowing := False;
      old.Deactivate;
      RaiseShiftingEvent(old, ahsClosed);
    end;

    FShiftingEvent := STATES[AOpen];

    if FShiftingPanel <> nil then
    begin
      rbnds := FZoneTree.Root.Bounds;
      if FShiftingPanel.Width = 0 then
        FShiftingPanel.Width := MIN_ZONESIZE;
      if FShiftingPanel.Height = 0 then
        FShiftingPanel.Height := MIN_ZONESIZE;
      if FShiftingPanel.Width > (rbnds.Right - rbnds.Left) then
        FShiftingPanel.Width := (rbnds.Right - rbnds.Left);
      if FShiftingPanel.Height > (rbnds.Bottom - rbnds.Top) then
        FShiftingPanel.Height := (rbnds.Bottom - rbnds.Top);
    end;

    if AImmediateInvert then
      TPanelShifter(FShifter).SetState(not AOpen, False, False);
  end;

  TPanelShifter(FShifter).SetState(AOpen, True, AActivate);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.BeginLoading;
begin
  Include(FState, dssLoadingLayout);
  FZoneTree.Clear;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.EndLoading;
var
  i:   Integer;
  pnl: TLMDDockPanel;
begin
  for i := FPanels.Count - 1 downto 0 do
  begin
    pnl := TLMDDockPanel(FPanels[i]);
    if (pnl.FZone = nil) or (pnl.FZone.FTree.FSite <> Self) then
      RemovePanel(pnl);
  end;

  Exclude(FState, dssLoadingLayout);

  FreeReadedLayout(True);
  UpdateLayout;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.IdToCompProc(const AId: TLMDString;
  out AComp: TComponent);
var
  i: Integer;
begin
  AComp := nil;

  if AId = 'SELF_SITE' then
    AComp := Self
  else if AId <> '' then
  begin
    for i := 0 to FLoadingPanels.Count - 1 do
      if TComponent(FLoadingPanels[i]).Name = AId then
      begin
        AComp := TComponent(FLoadingPanels[i]);
        Break; // for
      end;

    if AComp = nil then
      for i := 0 to FPanels.Count - 1 do
        if TComponent(FPanels[i]).Name = AId then
        begin
          AComp := TComponent(FPanels[i]);
          Break; // for
        end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.CompToIdProc(AComp: TComponent;
  out AId: TLMDString);
begin
  AId := '';

  if AComp = Self then
    AId := 'SELF_SITE'
  else if FPanels.IndexOf(AComp) <> -1 then
    AId := AComp.Name;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.RaiseShiftingEvent(APanel: TLMDDockPanel;
  AState: TLMDAutoHideState);
begin
  if (FShiftingEvent <> AState) and (APanel <> nil) then
  begin
    DoAutoHide(APanel.GetDockClient, AState);
    FShiftingEvent := AState;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.ReadLayout(Stream: TStream);
begin
  FReadedLayout := LMDLoadXmlDocument(Stream);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.WriteLayout(Stream: TStream);
var
  xml: ILMDXmlDocument;
begin
  if FReadedLayout <> nil then
    xml := FReadedLayout  // Required to be consistent with frames
                          // synchronization. The rule is simple: if the data
                          // has been readed (via ReadLayout), it should be
                          // provided back (when required) consistently via
                          // WriteLayout, INDEPENDENTLY of whether the Loaded
                          // method has been already called or not yet.
  else
  begin
    xml := LMDCreateXmlDocument('sitelist', '1.0', 'utf-8');
    TSiteStreamer.Save(Self, xml.DocumentElement, CompToIdProc, False);
  end;

  xml.Save(Stream);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.FixupReadedIds(AReader: TReader);
var
  elem: ILMDXmlElement;
begin
  if (csLoading in ComponentState) and (FReadedLayout <> nil) then
  begin
    FFixupReader := AReader;
    try
      elem := FReadedLayout.DocumentElement.ChildNodes[0].AsElement;
      TSiteStreamer.FixupIds(Self, elem, ReferenceIdProc);
    finally
      FFixupReader := nil;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSite.WantsTransparency(const P: TPoint): Boolean;
begin
  Result := False;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.FreeReadedLayout(ADockLoadingPanels: Boolean);
var
  i:   Integer;
  pnl: TLMDDockPanel;
begin
  FReadedLayout := nil;

  if ADockLoadingPanels then
    for i := FLoadingPanels.Count - 1 downto 0 do
    begin
      pnl := TLMDDockPanel(FLoadingPanels[i]);
      if {FPanels.IndexOf(pnl) = -1} pnl.FSite = nil then
      begin
        pnl.PanelVisible := False;
        DockControl(pnl, FZoneTree.Root, alRight);
      end;
    end;

  ClearLoadingPanels;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.ApplyReadedLayout;
var
  elem: ILMDXmlElement;
begin
  if FReadedLayout <> nil then
  begin
    elem := FReadedLayout.DocumentElement.ChildNodes[0].AsElement;
    TSiteStreamer.Load(Self, elem, IdToCompProc, False);
  end;
  UpdateUndockSizes;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.SetUseSpace(const Value: Boolean);
begin
  if FUseSpace <> Value then
  begin
    FUseSpace := Value;
    if not FUseSpace then
      FZoneTree.FSpaceZone := nil;
    UpdateLayout(True);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSite.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_DOCKING;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSite.DeactivateActiveChild(const ACheckOnly,
  AExclude: array of TLMDDockPanel): Boolean;

  function _IsInArray(const AArray: array of TLMDDockPanel;
                      AValue: TLMDDockPanel): Boolean;
  var
    i: Integer;
  begin
    for i := 0 to High(AArray) do
      if AArray[i] = AValue then
      begin
        Result := True;
        Exit;
      end;
    Result := False;
  end;

var
  frm: TCustomForm;
  i:   Integer;
begin
  Result := True;
  frm    := GetParentForm(Self);

  if (frm <> nil) and (frm.ActiveControl <> nil) then
  begin
    for i := 0 to PanelCount - 1 do
      if Panels[i].ContainsControl(frm.ActiveControl) and
         ((Length(ACheckOnly) = 0) or _IsInArray(ACheckOnly, Panels[i])) and
         not _IsInArray(AExclude, Panels[i]) then
      begin
        frm.ActiveControl := Panels[i];
        Result            := (frm.ActiveControl = Panels[i]);
        Break; // for
      end;
  end;
end;

procedure TLMDDockSite.DefineProperties(Filer: TFiler);

  function _DoWrite: Boolean;
  var
    s1, s2: TMemoryStream;
  begin
    Result := True;

    if Filer.Ancestor is TLMDDockSite then
    begin
      s1 := TMemoryStream.Create;
      s2 := TMemoryStream.Create;
      try
        WriteLayout(s1);
        TLMDDockSite(Filer.Ancestor).WriteLayout(s2);

        Result := (s1.Size <> s2.Size) or
                  not CompareMem(s1.Memory, s2.Memory, s1.Size);
      finally
        s1.Free;
        s2.Free;
      end;
    end;
  end;

begin
  inherited;
  Filer.DefineBinaryProperty('Layout', ReadLayout, WriteLayout, _DoWrite);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.Loaded;
begin
  inherited;
  if FLoadDesignLayout or (csDesigning in ComponentState) then
    ApplyReadedLayout;
  UpdateLayout;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style   := Params.Style or WS_CLIPCHILDREN;
  Params.ExStyle := Params.ExStyle or WS_EX_CONTROLPARENT;
  with Params.WindowClass do
    style := style and not (CS_VREDRAW or CS_HREDRAW);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.CreateHandle;
begin
  inherited;
  UpdateLayout;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.Paint;
begin
  Canvas.Font := Font;
  FZoneTree.Paint(Canvas);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.ManagerChanged;
begin
  UpdateLayout(True);
  NotifyFloatForm;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  p:    TPoint;
  htst: TLMDDockSiteHitTest;
  pnl:  TLMDDockPanel;
  tz:   TLMDDockZone;
begin
  inherited;

  p    := Point(X, Y);
  htst := GetHitTest(p);

  if (htst.Kind = hkSplitter) and (Button = mbLeft) and
     not (dlmSplitterResize in FLockMode) then
  begin
    BeginSplitterSizing(htst.Zone, htst.Index, Point(X, Y));
  end
  else if (htst.Kind = hkZone) and (htst.ZoneArea = hzaTabs) and
          (Button in [mbLeft, mbMiddle]) then
  begin
    if htst.TabBtn <> tbNone then // htst.Index can be -1 here
                                  // in case of tbMenu button.
    begin
      FZoneTree.SetHotTab(htst.Zone, htst.Index);
      FZoneTree.SetHotBtn(htst.TabBtn, True);
      Include(FState, dssTabBtnDown);
    end
    else if htst.Index <> -1 then
    begin
      pnl := htst.Zone.Tabs[htst.Index].Zone.Panel;

      if (pnl <> nil) and DeactivateActiveChild([], [pnl]) then
      begin
        tz := htst.Zone;

        if tz.FSelectedPage <> tz.Tabs[htst.Index].Zone then
        begin
          tz.FSelectedPage := tz.Tabs[htst.Index].Zone;
          UpdateLayout(True, pnl);
          NotifyDesigner(Self);
        end
        else
          pnl.Activate(False);

        if Button = mbMiddle then
        begin
          if (pbClose in pnl.FButtons) and not
             (dlmPanelClose in FLockMode) then
            pnl.Close;
        end
        else
        begin
          if csDesigning in ComponentState then
            pnl.UpdateDesignDrag(Self, True, False, False, True,
                                 True, ClientToScreen(Point(X, Y)))
          else if (TControlAccess(pnl.GetDockClient).DragMode =
                   dmAutomatic) and Application.AutoDragDocking and
                   not (dlmUndockFrom in FLockMode) then
            pnl.GetDockClient.BeginDrag(False);
        end;
      end;
    end;
  end;

  UpdateTracking;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  p: TPoint;
begin
  inherited;
  p := Point(X, Y);
  UpdateSplitterSizing(p);
  UpdateTracking;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.MouseUp(Button: TMouseButton; 
  Shift: TShiftState; X, Y: Integer);
var
  p:    TPoint;
  htst: TLMDDockSiteHitTest;
  pnl:  TLMDDockPanel;
  tzn:  TLMDDockZone;
begin
  inherited;
  p    := Point(X, Y);
  htst := GetHitTest(p);

  if dssTabBtnDown in FState then
  begin
    Exclude(FState, dssTabBtnDown);

    if (htst.Zone   = FZoneTree.FHotTabZone) and
       (htst.Index  = FZoneTree.FHotTabIndex) and
       (htst.TabBtn = FZoneTree.FHotTabBtn) then
    begin
      tzn := htst.Zone;

      case FZoneTree.FHotTabBtn of
        tbMenu:   PopupTabsMenu(tzn);
        tbClose:  if tzn.GetTabPanel(tzn.FTabs[htst.Index].Zone, pnl) then
                    PanelButtonClick(pnl, pbClose);
        tbLeft:   tzn.FirstTab := tzn.FirstTab - 1;
        tbRight:  tzn.FirstTab := tzn.FirstTab + 1;
      else
        Assert(False);
      end;
    end;
  end
  else if dssSplitSizing in FState then
    EndSplitterSizing(True);

  UpdateTracking;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.AlignControls(AControl: TControl; var ARect: TRect);
var
  frm: TCustomForm;
begin
  frm := GetParentForm(Self);
  if (frm = nil) or (frm.WindowState <> wsMinimized) then
  begin
    if not (dssNoAlignControls in FState) then
      UpdateLayout;
  end;
end;

{ ---------------------------------------------------------------------------- }
function _ChildrenCompare(Item1, Item2: Pointer): Integer;
begin
  Result := CompareText(TComponent(Item1).Name, TComponent(Item2).Name);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  i:   Integer;
  lst: TList;
begin
  lst := TList.Create;
  try
    for i := 0 to FPanels.Count - 1 do
      if lst.IndexOf(FPanels[i]) = -1 then
        lst.Add(FPanels[i]);
    for i := 0 to FLoadingPanels.Count - 1 do
      if lst.IndexOf(FLoadingPanels[i]) = -1 then
        lst.Add(FLoadingPanels[i]);

    lst.Sort(_ChildrenCompare); // Sort the list with some stable predicate to
                                // prevent children reordering to be stored in
                                // DFM when the site is inherited from the frame.
    for i := 0 to lst.Count - 1 do
      Proc(TComponent(lst[i]));
  finally
    lst.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.DoAddDockClient(Client: TControl;
  const ARect: TRect);
begin
  DoDockTask;
end;

procedure TLMDDockSite.DoAutoHide(AClient: TControl;
  AState: TLMDAutoHideState);
begin
  if Assigned(FOnAutoHide) then
    FOnAutoHide(Self, AClient, AState);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.DockOver(Source: TDragDockObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  dnfo: TLMDDragInfo;
  r:    TRect;
begin
  dnfo   := GetDragInfo(Point(X, Y), Source.Control, Source);
  Accept := True; // We have to set Accept to True always; even if the drag
                  // point is not over the hot-spot. Otherwise, the site will
                  // not receive end-drag notification. Moreover, dropping a
                  // client over the site, but not on the hot-spot, will work
                  // incorrectly.

  if dnfo.Zone <> nil then
  begin
    r := dnfo.Rect;
    MapWindowPoints(Handle, 0, r, 2);

    Source.DockRect := r;
  end
  else
    PositionDockRect(Source);

  if Source is TLMDDragObject then
  begin
    TLMDDragObject(Source).FAcceptedExt := (dnfo.Zone <> nil);
    TLMDDragObject(Source).TabInRect    := (dnfo.Zone <> nil) and
                                           dnfo.TabInRect;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.DoRemoveDockClient(Client: TControl);
var
  pnl: TLMDDockPanel;
begin
  if Client is TLMDDockPanel then
  begin
    pnl := TLMDDockPanel(Client);
    if pnl.FSite = Self then
      pnl.InternalResetSite;
  end
  else
  begin
    pnl := FindPanelByClient(Client);
    if pnl <> nil then
    begin
      if dssCustomInsert in FState then
      begin
        FUndockPanel       := pnl; // Deffer panel destruction.
        pnl.FClientControl := nil;
      end
      else
        pnl.Free;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.ShowControl(AControl: TControl);
var
  pnl:     TLMDDockPanel;
  zn, pnt: TLMDDockZone;
  changed: Boolean;
  oldvis:  Boolean;
begin
  pnl := nil;
  if AControl is TLMDDockPanel then
    pnl := TLMDDockPanel(AControl);

  if (pnl <> nil) and (pnl.FZone <> nil) and
     DeactivateActiveChild([], [pnl]) then
  begin
    zn     := pnl.FZone;
    oldvis := pnl.PanelVisible;

    pnl.PanelVisible := True;

    if zn.IsAutoHidden then
      SetShifingPanel(pnl, zn.AutoHideSide, True, True)
    else
    begin
      changed := False;

      while zn <> nil do
      begin
        pnt := zn.Parent;

        if (pnt <> nil) and (pnt.Kind = zkTabs) and
           ((pnt.FSelectedPage <> zn) or not pnt.IsTabInView(zn)) then
        begin
          pnt.FSelectedPage := zn;
          pnt.FScrollToTab  := zn;
          changed           := True;
        end;

        zn := pnt;
      end;

      if changed then
        UpdateLayout(True);
      pnl.Activate(True);
    end;

    if FShiftingPanel <> pnl then
    begin
      if FShiftingPanel <> nil then
        FShiftingPanel.Deactivate;
      SetShifingPanel(FShiftingPanel, FShiftingSide, False, False, False);
    end;

    if oldvis <> pnl.PanelVisible then
      NotifyDesigner(pnl);
  end;

  inherited;
end;

function TLMDDockSite.ShowPanelHeader(APanel: TLMDDockPanel): Boolean;
var
  pzn: TLMDDockZone;
begin
  pzn    := APanel.FZone;
  Result := APanel.FShowHeader and ((pzn = nil) or not pzn.TabbedDocsHost);
end;

function TLMDDockSite.TryCustomInsert(AClient: TControl; AZone: TLMDDockZone;
  AAlign: TAlign): Boolean;
begin
  Result := DoCustomInsertQuery(AClient, AZone, AAlign);

  if Result then
  begin
    Include(FState, dssCustomInsert);
    try
      {
        Several things should be noted here:
         - First, we dock into the NullDockSite, so performing only undocking. No
           Parent changes occures here.
         - Second, if the client has been docked into this site, then the
           container panel will be destroyed. Since client Parent is still equal
           to the container panel the client will be destroyed as well. To prevent
           such behavior we include dssCustomInsert flag. In this state the site
           deffer panel destruction saving the reference to the panel in the
           FUndockPanel field.
         - Only after Parent changes as a result of firing custom docking
           events, we can safelly destroy the panel.
      }

      if (AClient.HostDockSite <> nil) and
         not (csDestroying in AClient.HostDockSite.ComponentState) then
      begin
        AClient.HostDockSite.Perform(CM_UNDOCKCLIENT, 0, LPARAM(AClient));
        AClient.Dock(NullDockSite, AClient.BoundsRect);
      end;

      DoCustomInsert(AClient, AZone, AAlign);
    finally
      Exclude(FState, dssCustomInsert);
      FreeAndNil(FUndockPanel);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.GetClientImageParams(AClient: TControl;
  out AImages: TCustomImageList; out AImageIndex: Integer);
begin
  if AClient is TLMDDockPanel then
  begin
    AImages     := TLMDDockPanel(AClient).Images;
    AImageIndex := TLMDDockPanel(AClient).ImageIndex;
  end
  else
  begin
    AImages     := nil;
    AImageIndex := -1;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
  if FManager <> nil then
    FManager.DoLayoutChange;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSite.DoDockOver(Source: TDragDockObject;
  AZone: TLMDDockZone; AAlign: TAlign): Boolean;
begin
  Result := True;
  if Assigned(FOnDockOver) then
    FOnDockOver(Self, Source, AZone, AAlign, Result);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.DoDockDrop(Source: TDragDockObject;
  AZone: TLMDDockZone; AAlign: TAlign);
begin
  if Assigned(FOnDockDrop) then
    FOnDockDrop(Self, Source, AZone, AAlign);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSite.DoCustomInsertQuery(AClient: TControl;
  AZone: TLMDDockZone; AAlign: TAlign): Boolean;
begin
  Result := False;
  if Assigned(FOnCustomInsertQuery) then
    FOnCustomInsertQuery(Self, AClient, AZone, AAlign, Result);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.DoCustomInsert(AClient: TControl; AZone: TLMDDockZone;
  AAlign: TAlign);
begin
  if Assigned(FOnCustomInsert) then
    FOnCustomInsert(Self, AClient, AZone, AAlign);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FManager) then
    Manager := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.NotifyFloatForm;
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.DoDockTask;
var
  dtsk:   TDockTask;
  pnl:    TLMDDockPanel;
  imglst: TCustomImageList;
  imgidx: Integer;
begin
  dtsk      := TDockTask(FDockTask);
  FDockTask := nil;

  if dtsk = nil then
    Exit;

  EndDockTracking(False); // We should exec FTree.ResetHotTab before inserting
                          // to prevent updating algorithm to think that new
                          // panel zone is 'old' hot-tab-zone.

  if dtsk.Client is TLMDDockPanel then
    pnl := TLMDDockPanel(dtsk.Client)
  else
    pnl := FindPanelByClient(dtsk.Client);

  if pnl <> nil then
    pnl.InternalSetToSite(Self, dtsk)
  else
  begin
    pnl := TLMDDockPanel.Create(Self);
    try
      GetClientImageParams(dtsk.Client, imglst, imgidx);

      pnl.FClientControl := dtsk.Client;
      pnl.PanelVisible   := dtsk.Client.Visible;
      pnl.Images         := imglst;
      pnl.ImageIndex     := imgidx;

      pnl.InternalSetToSite(Self, dtsk);
      dtsk.Client.Parent := pnl;
    except
      pnl.Free;
      raise;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.ResetUndockedClientPnls;
var
  i:   Integer;
  cln: TControl;
begin
  Include(Fstate, dssRemovingUndocked);
  try
    for i := FPanels.Count - 1 downto 0 do
    begin
      cln := TLMDDockPanel(FPanels[i]).GetDockClient;
      if (cln.HostDockSite <> nil) and (cln.HostDockSite <> Self) then
        TLMDDockPanel(FPanels[i]).InternalResetSite;
    end;
  finally
    Exclude(Fstate, dssRemovingUndocked);
  end;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDDockSite.Create(AOwner: TComponent);
begin
  inherited;

  ControlStyle             := [csDoubleClicks, csOpaque, csCaptureMouse];
  DockSite                 := True;
  FLockMode                := [];
  FLoadingPanels           := TList.Create;
  FLoadDesignLayout        := True;
  FUseSpace                := True;
  FPanels                  := TList.Create;
  FZoneTree                := TLMDDockZoneTree.Create(Self);
  FShifter                 := TPanelShifter.Create(Self);
  FAutoHideSides[alLeft]   := TAutoHideSide.Create(Self, alLeft);
  FAutoHideSides[alTop]    := TAutoHideSide.Create(Self, alTop);
  FAutoHideSides[alRight]  := TAutoHideSide.Create(Self, alRight);
  FAutoHideSides[alBottom] := TAutoHideSide.Create(Self, alBottom);

  FNext    := SiteList;
  SiteList := Self;

  if csDesigning in ComponentState then
    DesignAutoConnect(Self);

  {$IFDEF LMDCOMP16}
  if FNext = nil then                              // VCL Style may be
    TDockStylesAccess(DockStyles).VCLStyleChanged; // potentially changed
  {$ENDIF}                                         // while there were no
                                                   // existing sites.
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDockSite.Destroy;
var
  i:    TAlign;
  j:    TLMDHotSpotKind;
  site: ^TLMDDockSite;
begin
  Destroying;
  Manager := nil;

  site := @SiteList;
  while site^ <> Self do
    site := @site.FNext;
  site^ := FNext;

  ClearLoadingPanels;
  DestroyPanels;
  FLoadingPanels.Free;
  FPanels.Free;
  FZoneTree.Free;
  FSplitSizer.Free;
  FShifter.Free;
  for i := Low(TAlign) to High(TAlign) do
    FAutoHideSides[i].Free;
  for j := Low(TLMDHotSpotKind) to High(TLMDHotSpotKind) do
    FHotspots[j].Free;
  FTabsMenu.Free;

  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.DockDrop(Source: TDragDockObject; X, Y: Integer);

  procedure _AcceptAsFloating;
  var
    drect: TDragRec;
  begin
    Source.DragTarget := nil;
    Source.Control.Perform(CM_FLOAT, 0, LPARAM(Source));

    if Source.DragTarget <> nil then
    begin
      drect.Pos     := Source.DragPos;
      drect.Target  := Source.DragTarget;
      drect.Source  := Source;
      drect.Docking := True;
      SendMessage(Source.DragHandle, CM_DRAG, WPARAM(dmDragDrop),
                  LPARAM(@drect));
    end;
  end;

var
  dnfo: TLMDDragInfo;
  dtsk: TDockTask;
  frm:  TCustomForm;
  pnl:  TLMDDockPanel;
begin
  // Note: We do not call CM_DOCKCLIENT from this method,
  // instead all reaquired things are done directly here.
  // So, CM_DOCKCLIENT is never used/called in TLMDDockSite.

  dnfo := GetDragInfo(Point(X, Y), Source.Control, Source);

  if FInDragMsg and (dnfo.Zone = nil) then // Not for ManualDock case.
  begin
    _AcceptAsFloating;
    Exit;
  end;

  dtsk := TDockTask(DockTaskFromDropInfo(Source.Control,
                                         Source.DockRect.Right -
                                         Source.DockRect.Left,
                                         Source.DockRect.Bottom -
                                         Source.DockRect.Top,
                                         dnfo, Source));
  try
    // Here dock-task params can be not equal to drag-info params,
    // because DockTaskFromDropInfo fills dock-task using Source
    // drag-object in ManualDock case.

    if TryCustomInsert(Source.Control, dtsk.Zone, dtsk.Align) then
      Exit;

    FDockTask := dtsk;
    DisableAlign;
    try
      Source.Control.Dock(Self, Source.DockRect);
      DoDockTask;
    finally
      EnableAlign;
    end;

    frm := GetParentForm(Self);
    if frm <> nil then
      frm.BringToFront;
    pnl := FindPanelByClient(Source.Control);
    if pnl <> nil then
      pnl.Activate(True);

    DoDockDrop(Source, dtsk.Zone, dtsk.Align);
  finally
    dtsk.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.DockControl(AControl: TControl;
  ADropOnZone: TLMDDockZone; AZoneSide: TAlign; ATabIndex: Integer;
  ASelectPage: Boolean);
begin
  if ADropOnZone = nil then
    ADropOnZone := FZoneTree.Root;
  if AZoneSide = alNone then
    AZoneSide := alClient;

  if not TryCustomInsert(AControl, ADropOnZone, AZoneSide) then
    InternalDockControl(AControl, ADropOnZone, AZoneSide,
                        ATabIndex, ASelectPage);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.UpdateLayout(AFireChangeEvent: Boolean;
  AActivate: TLMDDockPanel);
begin
  if not HandleAllocated or (csDestroying in ComponentState) or
     (dssUpdatingPanels in FState) or (dssRemovingUndocked in FState) or
     (dssLoadingLayout in FState) then
    Exit;

  Include(FState, dssUpdatingPanels);
  try
    ResetUndockedClientPnls; // We should first reset all panels that
                             // are been undocked.
                             // Note that UpdatePanels can be called just
                             // from AlignControl, when new panel dock
                             // site changes panel's Parent. At this time
                             // DoRemoveDockClient is not called yet.

    FZoneTree.UpdateLayout(AActivate);
    TPanelShifter(FShifter).Update;
    Invalidate;
  finally
    Exclude(FState, dssUpdatingPanels);
  end;

  if not (csDestroying in ComponentState) and AFireChangeEvent then
    DoChange;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSite.FindPanelByClient(AClient: TControl): TLMDDockPanel;
var
  i: Integer;
begin
  Result := nil;

  if (AClient is TLMDDockPanel) and (TLMDDockPanel(AClient).FSite = Self) then
  begin
    Result := TLMDDockPanel(AClient);
  end
  else if AClient <> nil then
  begin
    for i := 0 to FPanels.Count - 1 do
      if TLMDDockPanel(FPanels[i]).FClientControl = AClient then
      begin
        Result := TLMDDockPanel(FPanels[i]);
        Break; // for
      end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSite.FindZoneByClient(AClient: TControl): TLMDDockZone;
var
  pnl: TLMDDockPanel;
begin
  Result := nil;
  pnl    := FindPanelByClient(AClient);
  if pnl <> nil then
    Result := pnl.FZone;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSite.GetHitTest(const P: TPoint): TLMDDockSiteHitTest;

  function ZoneAtPoint(AZone: TLMDDockZone): TLMDDockZone;
  var
    i: Integer;
  begin
    if AZone.Showing and PtInRect(AZone.Bounds, P) then
    begin
      if AZone.Kind = zkTabs then
      begin
        Result := AZone;
        Exit;
      end;

      for i := AZone.ZoneCount - 1 downto 0 do
      begin
        Result := ZoneAtPoint(AZone.Zones[i]);
        if Result <> nil then
          Exit;
      end;

      if AZone.ZoneCount = 0 then
        Result := AZone
      else
        Result := nil;
    end
    else
      Result := nil;
  end;

  function FindTabIndex(AZone: TLMDDockZone; out AIndex: Integer;
                        out B: TLMDTabBtnKind): Boolean;
  var
    i: Integer;
  begin
    for i := 0 to AZone.TabCount - 1 do
      if PtInRect(AZone.Tabs[i].Bounds, P) then
      begin
        if PtInRect(AZone.Tabs[i].CloseBtn, P) then
          B := tbClose;

        AIndex := i;
        Result := True;
        Exit;
      end;

    Result := False;
  end;

  function FindSplitterIndex(AZone: TLMDDockZone;
    out ASplitZone: TLMDDockZone; out AIndex: Integer): Boolean;
  var
    i: Integer;
  begin
    if AZone.Showing and PtInRect(AZone.Bounds, P) then
    begin
      for i := 0 to AZone.SplitterCount - 1 do
        if PtInRect(AZone.Splitters[i].Bounds, P) then
        begin
          ASplitZone := AZone;
          AIndex     := i;
          Result     := True;
          Exit;
        end;

      for i := 0 to AZone.ZoneCount - 1 do
        if FindSplitterIndex(AZone.Zones[i], ASplitZone, AIndex) then
        begin
          Result := True;
          Exit;
        end;
    end;

    Result := False;
  end;

var
  b: TLMDTabBtnKind;
begin
  Result.Kind     := hkNone;
  Result.Zone     := nil;
  Result.ZoneArea := hzaClient;
  Result.Index    := -1;
  Result.TabBtn   := tbNone;

  Result.Zone := ZoneAtPoint(FZoneTree.Root);
  if Result.Zone <> nil then
  begin
    Result.Kind := hkZone;

    if PtInRect(Result.Zone.FTabArea, P) then
    begin
      Result.ZoneArea := hzaTabs;

      if PtInRect(Result.Zone.FTabsClip, P) then
        FindTabIndex(Result.Zone, Result.Index, Result.TabBtn)
      else
      begin
        for b := Low(TLMDTabBtnKind) to High(TLMDTabBtnKind) do
          if PtInRect(Result.Zone.FTabAreaBtns[b], P) then
          begin
            Result.TabBtn := b;
            Break; // for
          end;
      end;
    end;
  end
  else if FindSplitterIndex(FZoneTree.Root, Result.Zone,
                            Result.Index) then
    Result.Kind := hkSplitter;
end;

function TLMDDockSite.GetIsFloatingDoc: Boolean;
begin
  Result := False;
end;

function TLMDDockSite.GetIsFloatingSite: Boolean;
begin
  Result := False;
end;

{ ****************************** TLMDDockManager ***************************** }
{ ---------------------------------------------------------------------------- }
function TLMDDockManager.FindSite(AFloating: Boolean;
  const AId: TLMDString): TLMDDockSite;
var
  form: TLMDFloatingForm;
  comp: TComponent;
begin
  Result := nil;

  if AFloating then
  begin
    form   := TLMDFloatingForm.CreateEx(Application, Self);
    Result := form.FSite;
  end
  else
  begin
    IdToCompProc(AId, comp);
    if (comp <> nil) and (comp is TLMDDockSite) then
      Result := TLMDDockSite(comp);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockManager.FloatingSiteCreated(ASite: TLMDDockSite);
begin
  if Assigned(FOnCreateFloatingSite) then
    FOnCreateFloatingSite(Self, ASite);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockManager.FloatingSiteDestroying(ASite: TLMDDockSite);
begin
  if Assigned(FOnDestroyFloatingSite) then
    FOnDestroyFloatingSite(Self, ASite);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockManager.IdToCompProc(const AId: TLMDString;
  out AComp: TComponent);
var
  i:          Integer;
  curnm:      TLMDString;
  len, start: Integer;
begin
  AComp := DoGetComp(AId);
  if (AComp <> nil) or (AId = '') then
    Exit;

  len   := Length(AId);
  AComp := nil;
  start := 1;
  i     := 1;

  while i <= len do
  begin
    if (AId[i] = '.') or (i = len) then
    begin
      if i = len then
        Inc(i);

      curnm := Copy(AId, start, (i - start));
      start := i + 1;

      if AComp = nil then
        AComp := FindGlobalComponent(curnm)
      else
        AComp := AComp.FindComponent(curnm);

      if AComp = nil then
        Break; // while
    end;

    Inc(i);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockManager.CompToIdProc(AComp: TComponent;
  out AId: TLMDString);

  function _IsGlobal(AComp: TComponent): Boolean;
  begin
    Result := (FindGlobalComponent(AComp.Name) = AComp);
  end;

begin
  AId := DoGetCompId(AComp);
  if AId <> '' then
    Exit;

  while AComp <> nil do
  begin
    if AComp.Name = '' then
    begin
      AId := '';
      Exit;
    end;

    if AId <> '' then
      AId := '.' + AId;
    AId := AComp.Name + AId;

    if _IsGlobal(AComp) then
      Break; // while
    AComp := AComp.Owner;
  end;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDDockManager.Create(AOwner: TComponent);
begin
  inherited;
  FDockElems           := TManagerElems.Create(Self);
  FStayFloatFormsOnTop := True;
  FFloatFormButtons    := [pbMaximize, pbClose];
  FScrollDocTabs       := True;
  FUseTabbedDocs       := True;
  FNext                := MgrList;
  MgrList              := Self;

  if csDesigning in ComponentState then
    DesignAutoConnect(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockManager.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_DOCKING;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockManager.GetSiteCount: Integer;
var
  site: TLMDDockSite;
begin
  Result := 0;
  site   := SiteList;

  while site <> nil do
  begin
    if site.FManager = Self then
      Inc(Result);
    site := site.FNext;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockManager.GetSites(AIndex: Integer): TLMDDockSite;
var
  idx:  Integer;
  site: TLMDDockSite;
begin
  idx  := AIndex;
  site := SiteList;

  while site <> nil do
  begin
    if site.FManager = Self then
    begin
      if idx = 0 then
      begin
        Result := site;
        Exit;
      end;
      Dec(idx);
    end;
    site := site.FNext;
  end;

  raise EListError.CreateFmt(SListIndexError, [AIndex]);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockManager.GetStyleName: TLMDStyleName;
begin
  if FStyle <> nil then
    Result := FStyle.Name
  else
    Result := '';
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockManager.DoGetCompId(AComp: TComponent): TLMDString;
begin
  Result := '';
  if Assigned(FOnGetCompId) then
    FOnGetCompId(Self, AComp, Result);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockManager.DoLayoutChange;
begin
  if Assigned(FOnLayoutChange) then
    FOnLayoutChange(Self);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDockManager.Destroy;
var
  mgr: ^TLMDDockManager;
begin
  mgr := @MgrList;
  while (mgr^ <> nil) and (mgr^ <> Self) do
    mgr := @mgr.FNext;
  mgr^ := FNext;
  FDockElems.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockManager.AttachFloatingSite(ASite: TLMDDockSite): Boolean;
begin
  // Attach floating sites automatically only if the application
  // has a single manager. Otherwise, the user has to write an event
  // handler to attach floating sites.

  Result := (MgrList = Self) and (MgrList.FNext = nil);
  if Assigned(FOnAttachFloatingSite) then
    FOnAttachFloatingSite(Self, ASite, Result);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockManager.DoBeforeRead(const Xml: ILMDXmlDocument);
begin
  if Assigned(FBeforeRead) then
    FBeforeRead(Self, Xml);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockManager.DoBeforeWrite(const Xml: ILMDXmlDocument);
begin
  if Assigned(FBeforeWrite) then
    FBeforeWrite(Self, Xml);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockManager.DoGetClientKind(
  AClient: TControl): TLMDDockClientKind;
begin
  if AClient is TLMDDockPanel then
    Result := TLMDDockPanel(AClient).FClientKind
  else
    Result := dkTool;
  if Assigned(FOnGetClientKind) then
    FOnGetClientKind(Self, AClient, Result);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockManager.DoGetComp(const AId: TLMDString): TComponent;
begin
  Result := nil;
  if Assigned(FOnGetComp) then
    FOnGetComp(Self, AId, Result);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockManager.DoSaveSite(ASite: TLMDDockSite): Boolean;
begin
  Result := True;
  if Assigned(FOnSaveSite) then
    FOnSaveSite(Self, ASite, ASite.IsFloatingSite, Result);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockManager.DoWriteAppInfo(const Xml: ILMDXmlDocument);
begin
  if Assigned(FOnWriteAppInfo) then
    FOnWriteAppInfo(Self, Xml);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockManager.DoReadAppInfo(const Xml: ILMDXmlDocument);
begin
  if Assigned(FOnReadAppInfo) then
    FOnReadAppInfo(Self, Xml);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockManager.SaveToStream(AStream: TStream);
var
  xml:  ILMDXmlDocument;
  site: TLMDDockSite;
  id:   TLMDString;
begin
  xml := LMDCreateXmlDocument('sitelist', '1.0', 'utf-8');
  DoBeforeWrite(xml);

  site := SiteList;
  while site <> nil do
  begin
    if (site.Manager = Self) and DoSaveSite(site) then
    begin
      CompToIdProc(site, id);

      if (id <> '') or (site.IsFloatingSite and (site.PanelCount > 0)) then
        TSiteStreamer.Save(site, xml.DocumentElement, CompToIdProc,
                           FPersistFloatSize);
    end;
    site := site.FNext;
  end;

  DoWriteAppInfo(xml);
  xml.Save(AStream);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockManager.UpdateSites;
var
  site: TLMDDockSite;
begin
  site := SiteList;
  while site <> nil do
  begin
    if site.FManager = Self then
      site.ManagerChanged;
    site := site.FNext;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockManager.SaveToFile(const AFileName: TLMDString);
var
  stream: TStream;
begin
  stream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(stream);
  finally
    stream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockManager.LoadFromStream(AStream: TStream);
var
  i:     Integer;
  xml:   ILMDXmlDocument;
  nd:    ILMDXmlNode;
  elem:  ILMDXmlElement;
  fltng: Boolean;
  id:    TLMDString;
  site:  TLMDDockSite;
begin
  xml := LMDLoadXmlDocument(AStream);
  if xml.DocumentElement = nil then
    raise ELMDDockManager.Create('Invalid layout XML');

  DoBeforeRead(xml);

  for i := 0 to xml.DocumentElement.ChildNodes.Count - 1 do
  begin
    nd := xml.DocumentElement.ChildNodes[i];

    if nd.NodeType = LMD_NODE_ELEMENT then
    begin
      elem := nd.AsElement;

      if TSiteStreamer.GetParams(elem, fltng, id) then
      begin
        site := FindSite(fltng, id);
        if site <> nil then
          TSiteStreamer.Load(site, elem, IdToCompProc, FPersistFloatSize);
      end;
    end;
  end;

  DoReadAppInfo(xml);
  DoLayoutChange;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockManager.Loaded;
begin
  inherited;
  UpdateSites;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockManager.LoadFromFile(const AFileName: TLMDString);
var
  stream: TStream;
begin
  stream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(stream);
  finally
    stream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockManager.ApplyDesignLayout;
var
  site: TLMDDockSite;
begin
  site := SiteList;
  while site <> nil do
  begin
    if site.FManager = Self then
      site.ApplyReadedLayout;
    site := site.FNext;
  end;
  DoLayoutChange;
end;

{ ******************************* TSeqHandler ******************************** }
{ ---------------------------------------------------------------------------- }
class procedure TSeqHandler.CalcLayout(var AItems: TSeqItems;
  AZoneSize: Integer; ASplitterSize: Integer);

  function _CorrectProportionalDSizes: Double;
  var
    i, pCnt:     Integer;
    pSum, npSum: Double;
  begin
    Result := 0;
    pCnt   := 0; // Proportional.
    pSum   := 0; //
    npSum  := 0; // Other - non proportional.

    for i := 0 to High(AItems) do
    begin
      if AItems[i].Kind = sikProportional then
      begin
        pSum  := pSum + AItems[i].DSize;
        Inc(pCnt);
      end
      else
        npSum := npSum + AItems[i].DSize;
    end;

    for i := 0 to High(AItems) do
      if AItems[i].Kind = sikProportional then
      begin
        if pSum > 0 then
          AItems[i].DSize := AItems[i].DSize * ((1 - npSum) / pSum)
        else
          AItems[i].DSize := (1 - npSum) / pCnt;
        Result := Result + AItems[i].DSize;
      end;
  end;

var
  i, propcnt, spcidx:    Integer;
  cur, sum:              Double;
  filled:                Integer;
  propsz, spcsz, pvszsz: Integer;
  maxisz, oldsz:         Integer;
  done:                  Boolean;
  fixed:                 array of Boolean;
begin
  if Length(AItems) = 0 then
    Exit;

  if Length(AItems) > 1 then
    Dec(AZoneSize, (Length(AItems) - 1) * ASplitterSize);
  if AZoneSize < 0 then
    AZoneSize := 0;

  if MIN_ZONESIZE * Length(AItems) >= AZoneSize then
  begin
    { Set equal size to each item }

    cur    := 0;
    filled := 0;

    for i := 0 to High(AItems) do
    begin
      cur            := cur + AZoneSize / Length(AItems);
      AItems[i].Size := Round(cur) - filled;
      Inc(filled, AItems[i].Size);

      if AItems[i].Kind in [sikSpace, sikPreserveSize] then
        AItems[i].DSize := 1 / Length(AItems);
    end;

    _CorrectProportionalDSizes;
  end
  else
  begin
    { Get items metrics }

    propsz  := 0;
    spcsz   := 0;
    pvszsz  := 0;
    propcnt := 0;
    spcidx  := -1;

    for i := 0 to High(AItems) do
    begin
      if AItems[i].Size < MIN_ZONESIZE then
        AItems[i].Size := MIN_ZONESIZE;
      case AItems[i].Kind of
        sikProportional:  begin
                            Inc(propsz, AItems[i].Size);
                            Inc(propcnt);
                          end;
        sikPreserveSize:  Inc(pvszsz, AItems[i].Size);
        sikSpace:         begin
                            Inc(spcsz, AItems[i].Size);
                            spcidx := i;
                          end;
      end;
    end;

    { Correct space size }

    if spcidx <> -1 then // Has space
    begin
      spcsz := AZoneSize - (pvszsz + propsz);
      if spcsz < MIN_ZONESIZE then
        spcsz := MIN_ZONESIZE;

      AItems[spcidx].Size  := spcsz;
      AItems[spcidx].DSize := spcsz / AZoneSize;
    end;

    { Correct preserve-size items size }

    maxisz := AZoneSize - (spcsz + propcnt * MIN_ZONESIZE); // Max allowed.
    if pvszsz > maxisz then
    begin
      for i := 0 to High(AItems) do
        if (AItems[i].Kind = sikPreserveSize) and
           (AItems[i].Size > MIN_ZONESIZE) then
        begin
          oldsz := AItems[i].Size;

          Dec(AItems[i].Size, pvszsz - maxisz);
          if AItems[i].Size < MIN_ZONESIZE then
            AItems[i].Size := MIN_ZONESIZE;

          Dec(pvszsz, oldsz - AItems[i].Size);
          if pvszsz <= maxisz then
            Break; // for
        end;
    end
    else if (propcnt = 0) and (spcidx = -1) and (AZoneSize > pvszsz) then
    begin
      // If no other items exists, the only way is to
      // expand preserve-size items to whole zone.

      for i := 0 to High(AItems) do
        if AItems[i].Kind = sikPreserveSize then
        begin
          Inc(AItems[i].Size, AZoneSize - pvszsz);
          pvszsz := AZoneSize;
          Break; // for
        end;
    end;

    for i := 0 to High(AItems) do
    begin
      if AItems[i].Kind = sikPreserveSize then
        AItems[i].DSize := AItems[i].Size / AZoneSize;
    end;

    { Correct proportional items size }

    sum := _CorrectProportionalDSizes;

    if (propcnt > 0) and (propsz <> AZoneSize - (spcsz + pvszsz)) then
    begin
      Assert(sum > 0);
      propsz := AZoneSize - (spcsz + pvszsz);

      SetLength(fixed, Length(AItems));
      for i := 0 to High(fixed) do
        fixed[i] := False;

      repeat
        cur    := 0;
        filled := 0;
        done   := True;

        for i := 0 to High(AItems) do
          if (AItems[i].Kind = sikProportional) and not fixed[i] then
          begin
            cur            := cur + propsz * (AItems[i].DSize / sum);
            AItems[i].Size := Round(cur) - filled;
            Inc(filled, AItems[i].Size);
          end;

        for i := 0 to High(AItems) do
          if (AItems[i].Kind = sikProportional) and
             (AItems[i].Size < MIN_ZONESIZE) then
          begin
            AItems[i].Size := MIN_ZONESIZE;
            propsz         := propsz - AItems[i].Size;
            sum            := sum - AItems[i].DSize;
            done           := False;
            fixed[i]       := True;
          end;
      until done;
    end;
  end;
end;

{ ***************************** THorzSeqHandler ****************************** }
{ ---------------------------------------------------------------------------- }
function THorzSeqHandler.GetControlXSize(AControl: TControl): Integer;
begin
  Result := AControl.Width;
end;

{ ---------------------------------------------------------------------------- }
function THorzSeqHandler.GetZoneXMin(AZone: TLMDDockZone;
  M: TLMDMargins): Integer;
begin
  Result := AZone.Left;
  if M <> nil then
    Inc(Result, M.Left);
end;

{ ---------------------------------------------------------------------------- }
function THorzSeqHandler.GetZoneYMin(AZone: TLMDDockZone;
  M: TLMDMargins): Integer;
begin
  Result := AZone.Top;
  if M <> nil then
    Inc(Result, M.Top);
end;

{ ---------------------------------------------------------------------------- }
function THorzSeqHandler.GetZoneXSize(AZone: TLMDDockZone;
  M: TLMDMargins): Integer;
begin
  Result := AZone.Width;
  if M <> nil then
    Dec(Result, M.Left + M.Right);
end;

{ ---------------------------------------------------------------------------- }
function THorzSeqHandler.GetZoneYSize(AZone: TLMDDockZone;
  M: TLMDMargins): Integer;
begin
  Result := AZone.Height;
  if M <> nil then
    Dec(Result, M.Top + M.Bottom);
end;

{ ---------------------------------------------------------------------------- }
function THorzSeqHandler.GetRealRect(AXMin, AYMin, AXSize,
  AYSize: Integer): TRect;
begin
  Result := Rect(AXMin, AYMin, AXMin + AXSize, AYMin + AYSize);
end;

{ ---------------------------------------------------------------------------- }
procedure THorzSeqHandler.OffsetRealRect(var ARect: TRect; AXOffset,
  AYOffset: Integer);
begin
  OffsetRect(ARect, AXOffset, AYOffset);
end;

{ ---------------------------------------------------------------------------- }
function THorzSeqHandler.GetHideSide(AAfterSpace: Boolean): TAlign;
begin
  if AAfterSpace then
    Result := alRight
  else
    Result := alLeft;
end;

{ ***************************** TVertSeqHandler ****************************** }
{ ---------------------------------------------------------------------------- }
function TVertSeqHandler.GetControlXSize(AControl: TControl): Integer;
begin
  Result := AControl.Height;
end;

{ ---------------------------------------------------------------------------- }
function TVertSeqHandler.GetZoneXMin(AZone: TLMDDockZone;
  M: TLMDMargins): Integer;
begin
  Result := AZone.Top;
  if M <> nil then
    Inc(Result, M.Top);
end;

{ ---------------------------------------------------------------------------- }
function TVertSeqHandler.GetZoneYMin(AZone: TLMDDockZone;
  M: TLMDMargins): Integer;
begin
  Result := AZone.Left;
  if M <> nil then
    Inc(Result, M.Left);
end;

{ ---------------------------------------------------------------------------- }
function TVertSeqHandler.GetZoneXSize(AZone: TLMDDockZone;
  M: TLMDMargins): Integer;
begin
  Result := AZone.Height;
  if M <> nil then
    Dec(Result, M.Top + M.Bottom);
end;

{ ---------------------------------------------------------------------------- }
function TVertSeqHandler.GetZoneYSize(AZone: TLMDDockZone;
  M: TLMDMargins): Integer;
begin
  Result := AZone.Width;
  if M <> nil then
    Dec(Result, M.Left + M.Right);
end;

{ ---------------------------------------------------------------------------- }
function TVertSeqHandler.GetRealRect(AXMin, AYMin, AXSize,
  AYSize: Integer): TRect;
begin
  Result := Rect(AYMin, AXMin, AYMin + AYSize, AXMin + AXSize);
end;

{ ---------------------------------------------------------------------------- }
procedure TVertSeqHandler.OffsetRealRect(var ARect: TRect; AXOffset,
  AYOffset: Integer);
begin
  OffsetRect(ARect, AYOffset, AXOffset);
end;

{ ---------------------------------------------------------------------------- }
function TVertSeqHandler.GetHideSide(AAfterSpace: Boolean): TAlign;
begin
  if AAfterSpace then
    Result := alBottom
  else
    Result := alTop;
end;

{ ******************************* TTabsHandler ******************************* }
{ ---------------------------------------------------------------------------- }
class function TTabsHandler.CreateHandler(ASide: TAlign): TTabsHandler;
begin
  if ASide in [alLeft, alRight] then
    Result := TLRTabsHandler.Create
  else
    Result := TTBTabsHandler.Create;
end;

{ ---------------------------------------------------------------------------- }
class procedure TTabsHandler.CalcLayout(ACanvas: TCanvas; ATabArea,
  ASpacer: Integer; ACutMode: TCutMode; var AItems: TTabItems);
var
  i:         Integer;
  sum:       Integer;
  nospcrs:   Integer;
  fixed:     array of Boolean;
  unfixcnt:  Integer;
  dsz, cur:  Double;
  sz:        Integer;
  done:      Boolean;
  cut:       Boolean;
begin
  nospcrs := ATabArea - ASpacer * Max(Length(AItems) - 1, 0);
  sum     := 0;

  for i := 0 to High(AItems) do
  begin
    AItems[i].Size := AItems[i].BaseSize;
    Inc(sum, AItems[i].Size);
  end;

  case ACutMode of
    cmNone: ; // Do nothing.
    cmLast: if sum > nospcrs then
            begin
              sz  := ATabArea;
              cut := False;

              for i := 0 to High(AItems) do
              begin
                if not cut then
                begin
                  if AItems[i].Size > sz then
                  begin
                    AItems[i].Size := Max(sz, 0);//0
                    cut            := True;
                  end;
                  Dec(sz, AItems[i].Size + ASpacer);
                end
                else
                  AItems[i].Size := 0;
              end;
            end;
    cmAll:  if sum > nospcrs then
            begin
              SetLength(fixed, Length(AItems));
              for i := 0 to High(fixed) do
                fixed[i] := False;
              unfixcnt := Length(AItems);
              done     := False;

              while (unfixcnt > 0) and not done do
              begin
                done := True;
                dsz  := nospcrs / unfixcnt;
                cur  := 0;
                sz   := 0;

                for i := 0 to High(AItems) do
                  if not fixed[i] then
                  begin
                    cur            := cur + dsz;
                    AItems[i].Size := Max(Round(cur) - sz, 0);

                    if AItems[i].Size > AItems[i].BaseSize then
                    begin
                      AItems[i].Size := AItems[i].BaseSize;
                      fixed[i]       := True;
                      done           := False;
                      Dec(unfixcnt);
                      Dec(nospcrs, AItems[i].Size);
                    end;

                    Inc(sz, AItems[i].Size);
                  end;
              end;
            end;
  else
    Assert(False);
  end;
end;

{ ****************************** TLRTabsHandler ****************************** }
{ ---------------------------------------------------------------------------- }
function TLRTabsHandler.GetXMin(const ARect: TRect): Integer;
begin
  Result := ARect.Left;
end;

{ ---------------------------------------------------------------------------- }
function TLRTabsHandler.GetYMin(const ARect: TRect): Integer;
begin
  Result := ARect.Top;
end;

{ ---------------------------------------------------------------------------- }
function TLRTabsHandler.GetXSize(const ARect: TRect): Integer;
begin
  Result := ARect.Right - ARect.Left;
end;

{ ---------------------------------------------------------------------------- }
function TLRTabsHandler.GetYSize(const ARect: TRect): Integer;
begin
  Result := ARect.Bottom - ARect.Top;
end;

{ ---------------------------------------------------------------------------- }
function TLRTabsHandler.GetRealRect(AXMin, AYMin, AXSize,
  AYSize: Integer): TRect;
begin
  Result := Rect(AXMin, AYMin, AXMin + AXSize, AYMin + AYSize);
end;

{ ---------------------------------------------------------------------------- }
procedure TLRTabsHandler.OffsetRealRect(var ARect: TRect; AXOffset,
  AYOffset: Integer);
begin
  OffsetRect(ARect, AXOffset, AYOffset);
end;

{ ***************************** TTBTabsHandler ******************************* }
{ ---------------------------------------------------------------------------- }
function TTBTabsHandler.GetXMin(const ARect: TRect): Integer;
begin
  Result := ARect.Top;
end;

{ ---------------------------------------------------------------------------- }
function TTBTabsHandler.GetYMin(const ARect: TRect): Integer;
begin
  Result := ARect.Left;
end;

{ ---------------------------------------------------------------------------- }
function TTBTabsHandler.GetXSize(const ARect: TRect): Integer;
begin
  Result := ARect.Bottom - ARect.Top;
end;

{ ---------------------------------------------------------------------------- }
function TTBTabsHandler.GetYSize(const ARect: TRect): Integer;
begin
  Result := ARect.Right - ARect.Left;
end;

{ ---------------------------------------------------------------------------- }
function TTBTabsHandler.GetRealRect(AXMin, AYMin, AXSize,
  AYSize: Integer): TRect;
begin
  Result := Rect(AYMin, AXMin, AYMin + AYSize, AXMin + AXSize);
end;

{ ---------------------------------------------------------------------------- }
procedure TTBTabsHandler.OffsetRealRect(var ARect: TRect; AXOffset,
  AYOffset: Integer);
begin
  OffsetRect(ARect, AYOffset, AXOffset);
end;

{ ****************************** TSplitterSizer ****************************** }
{ ---------------------------------------------------------------------------- }
procedure TSplitterSizer.Draw;
var
  dc:    HDC;
  oldbr: HBRUSH;
begin
  dc    := GetDCEx(FSite.Handle, 0, DCX_CACHE or DCX_CLIPSIBLINGS or
                   DCX_LOCKWINDOWUPDATE);
  oldbr := SelectObject(dc, FBrush.Handle);
  try
    PatBlt(dc, FDrawRect.Left, FDrawRect.Top,
           FDrawRect.Right - FDrawRect.Left,
           FDrawRect.Bottom - FDrawRect.Top,
           PATINVERT);
  finally
    if oldbr <> 0 then
      SelectObject(dc, oldbr);
    ReleaseDC(FSite.Handle, dc);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TSplitterSizer.CalcSplitterSize: Integer;
begin
  if not FIsVert then
    Result := FSplitterBounds.Right - FSplitterBounds.Left
  else
    Result := FSplitterBounds.Bottom - FSplitterBounds.Top;
end;

{ ---------------------------------------------------------------------------- }
constructor TSplitterSizer.Create(ASite: TLMDDockSite; AIsVert: Boolean;
  const AArea, ASplitterBounds: TRect; AData: TObject; AData2: Integer;
  AFinishProc: TSplitterFinishProc);
begin
  inherited Create;

  Application.CancelHint;
  {$IFDEF LMD_DCK_UPDATE}ASite.Update;{$ENDIF}

  FSite           := ASite;
  FIsVert         := AIsVert;
  FArea           := AArea;
  FSplitterBounds := ASplitterBounds;
  FSpltrSize      := CalcSplitterSize;
  FData           := AData;
  FData2          := AData2;
  FFinishProc     := AFinishProc;
  FBrush          := TBrush.Create;
  FBrush.Bitmap   := AllocPatternBitmap(clBlack, clWhite);
end;

{ ---------------------------------------------------------------------------- }
destructor TSplitterSizer.Destroy;
begin
  FBrush.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TSplitterSizer.Update(const AMousePos: TPoint);

  function _CalcCoord(AMin, AMax, AInitial,
                      AMouse, AOffset: Integer): Integer;
  begin
    if (AMax - AMin) <= (MIN_ZONESIZE * 2) then
      Result := AInitial
    else
    begin
      Result := AMouse - AOffset;
      if Result < AMin + MIN_ZONESIZE then
        Result := AMin + MIN_ZONESIZE;
      if Result > AMax - FSpltrSize - MIN_ZONESIZE then
        Result := AMax - FSpltrSize - MIN_ZONESIZE;
    end;
  end;

var
  crd: Integer;

begin
  SetCapture(FSite.Handle);
  FSite.MouseCapture := True;

  if not FInited then
  begin
    FXOffset := AMousePos.X - FSplitterBounds.Left;
    FYOffset := AMousePos.Y - FSplitterBounds.Top;
  end
  else
    Draw; // Erase

  if not FIsVert then
  begin
    crd       := _CalcCoord(FArea.Left, FArea.Right, FSplitterBounds.Left,
                            AMousePos.X, FXOffset);
    FDrawRect := Rect(crd, FArea.Top, crd + FSpltrSize,
                      FArea.Bottom);
  end
  else
  begin
    crd       := _CalcCoord(FArea.Top, FArea.Bottom, FSplitterBounds.Top,
                            AMousePos.Y, FYOffset);
    FDrawRect := Rect(FArea.Left, crd, FArea.Right,
                      crd + FSpltrSize);
  end;

  Draw;
  FInited := True;
end;

{ ---------------------------------------------------------------------------- }
procedure TSplitterSizer.Finish(AAccept: Boolean);
begin
  if FInited then
    Draw;
  FSite.MouseCapture := False;
  FFinishProc(AAccept, FData, FData2, FDrawRect);
end;

{ ******************************* TPanelShifter ****************************** }
{ ---------------------------------------------------------------------------- }
function TPanelShifter.CheckPanel: Boolean;
begin
  Result := (FSite.FShiftingPanel <> nil);

  if not Result then
  begin
    FOffset      := 0;
    FInactiveCnt := 0;
    FState       := pssClosed;
    KillTimer(FTimerHWnd, 1);
  end
end;

{ ---------------------------------------------------------------------------- }
function TPanelShifter.IsPnlActive: Boolean;
begin
  Result := (FSite.FShiftingPanel <> nil) and FSite.FShiftingPanel.Active;
end;

{ ---------------------------------------------------------------------------- }
function TPanelShifter.IsPnlSelectedByDesigner: Boolean;
var
  i:    Integer;
  seln: TList;
begin
  Result := False;

  if (FSite.FShiftingPanel <> nil) and
     (csDesigning in FSite.ComponentState) and
     Assigned(LMDGetDesignerSelectionProc) then
  begin
    seln := TList.Create;
    try
      LMDGetDesignerSelectionProc(FSite, seln);

      for i := 0 to seln.Count - 1 do
        if (TObject(seln[i]) is TControl) and
           FSite.FShiftingPanel.ContainsControl(TControl(seln[i])) then
        begin
          Result := True;
          Break; // for
        end;
    finally
      seln.Free;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TPanelShifter.IsCursorOnPanel: Boolean;
var
  p:    TPoint;
  side: TAutoHideSide;
begin
  Result := False;

  if FSite.FShiftingPanel <> nil then
  begin
    GetCursorPos(p);
    Result := PtInRect(FSite.FShiftingPanel.BoundsRect,
                       FSite.ScreenToClient(p));
    if not Result then
    begin
      side   := TAutoHideSide(FSite.FAutoHideSides[FSite.FShiftingSide]);
      Result := (side.FindPanelAtPoint(p) = FSite.FShiftingPanel);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TPanelShifter.CalcPanelBounds: TRect;
var
  pnl:        TLMDDockPanel;
  hdr:        TTabsHandler;
  isafter:    Boolean;
  cr:         TRect;
  xmin, xoff: Integer;
begin
  pnl := FSite.FShiftingPanel;
  hdr := TTabsHandler.CreateHandler(FSite.FShiftingSide);
  try
    isafter := FSite.FShiftingSide in [alRight, alBottom];
    cr      := FSite.RootZone.Bounds;

    xmin := hdr.GetXMin(cr);
    if isafter then
      Inc(xmin, hdr.GetXSize(cr) - hdr.GetXSize(pnl.BoundsRect));

    xoff := -Round(hdr.GetXSize(pnl.BoundsRect) * (1 - FOffset));
    if isafter then
      xoff := -xoff;
    Inc(xmin, xoff);

    Result := hdr.GetRealRect(xmin, hdr.GetYMin(cr),
                              hdr.GetXSize(pnl.BoundsRect),
                              hdr.GetYSize(cr));
  finally
    hdr.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TPanelShifter.TimerWndProc(var Msg: TMessage);
begin
  try
    if Msg.Msg = WM_TIMER then
    begin
      case FState of
        pssOpened:          begin
                              if IsPnlActive or IsCursorOnPanel or
                                 (dssSplitSizing in FSite.FState) or
                                 IsPnlSelectedByDesigner then
                                FInactiveCnt := 0
                              else
                                Inc(FInactiveCnt);

                              if FInactiveCnt >= 5 then
                              begin
                                if DeactivatePanel then
                                  SetState(False, True, False)
                                else
                                  KillTimer(FTimerHWnd, 1);
                              end;
                            end;
        pssOpening:         begin
                              FOffset := FOffset + 0.1; // 10 steps.
                              if FOffset >= 1 then
                                SetState(True, False, FActivate);
                              Update;
                            end;
        pssClosing:         begin
                              FOffset := FOffset - 0.1; // 10 steps.
                              if FOffset <= 0 then
                                SetState(False, False, False);
                              Update;
                            end;
      else
        KillTimer(FTimerHWnd, 1);
      end;

      Msg.Result := 0;
    end
    else
      Msg.Result := DefWindowProc(FTimerHWnd, Msg.Msg, Msg.WParam, Msg.LParam);
  except
    Application.HandleException(Self);
  end;
end;

{ ---------------------------------------------------------------------------- }
constructor TPanelShifter.Create(ASite: TLMDDockSite);
begin
  inherited Create;
  FSite      := ASite;
  FTimerHWnd := Classes.AllocateHWnd(TimerWndProc);
end;

{ ---------------------------------------------------------------------------- }
function TPanelShifter.DeactivatePanel: Boolean;
begin
  Result := (FSite.FShiftingPanel = nil) or
            FSite.DeactivateActiveChild([FSite.FShiftingPanel], []);
end;

destructor TPanelShifter.Destroy;
begin
  Classes.DeallocateHWnd(FTimerHWnd);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TPanelShifter.SetState(AOpen, AAnimate, AActivate: Boolean);
begin
  if CheckPanel then
  begin
    if not AAnimate then
    begin
      if AOpen then
      begin
        FOffset      := 1;
        FActivate    := AActivate;
        FState       := pssOpened;
        FInactiveCnt := 0;
        SetTimer(FTimerHWnd, 1, 200, nil);
      end
      else
      begin
        FOffset   := 0;
        FActivate := False;
        FState    := pssClosed;
        KillTimer(FTimerHWnd, 1);
      end;
    end
    else
    begin
      if AOpen then
      begin
        if not (FState in [pssOpened, pssOpening]) then
        begin
          FState    := pssOpening;
          FActivate := AActivate;
          SetTimer(FTimerHWnd, 1, 10, nil);
        end
        else if AActivate then
          FActivate := True;
      end
      else
      begin
        FState    := pssClosing;
        FActivate := False;
        SetTimer(FTimerHWnd, 1, 10, nil);
      end;
    end;
  end;

  Update;

  case FState of
    pssOpened: FSite.RaiseShiftingEvent(FSite.FShiftingPanel, ahsOpened);
    pssClosed: FSite.RaiseShiftingEvent(FSite.FShiftingPanel, ahsClosed);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TPanelShifter.Update;
var
  pnl:  TLMDdockPanel;
  side: TAutoHideSide;
begin
  if CheckPanel and not FUpdating then
  begin
    FUpdating := True;
    pnl       := FSite.FShiftingPanel;

    if FState = pssClosed then
      pnl.OnSiteShowing := False
    else
    begin
      Include(FSite.FState, dssNoAlignControls);
      try
        side := TAutoHideSide(FSite.FAutoHideSides[FSite.FShiftingSide]);

        if not pnl.OnSiteShowing or (FState = pssOpened) then
        begin
          pnl.BringToFront;
          side.BringToFront;
        end;
        pnl.BoundsRect    := CalcPanelBounds;
        pnl.OnSiteShowing := True;

        if FActivate then
        begin
          if pnl.CanFocus then
            pnl.Activate(True);
          FActivate := False;
        end;
      finally
        Exclude(FSite.FState, dssNoAlignControls);
      end;
    end;

    FUpdating := False;
  end;
end;

{ ********************************* THotSpot ********************************* }
{ ---------------------------------------------------------------------------- }
procedure THotSpot.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.Result := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure THotSpot.WMNCHitTest(var Message: TWMNCHitTest);
begin
  Message.Result := HTTRANSPARENT;
end;

{ ---------------------------------------------------------------------------- }
procedure THotSpot.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style   := WS_POPUP;
    ExStyle := WS_EX_LAYERED;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure THotSpot.Paint;
begin
  // Do nothing. Look at UpdateLayeredWindow docs.
end;

{ ---------------------------------------------------------------------------- }
procedure THotSpot.PrepareBitmap(C: TCanvas; HS: TLMDHotspotBase);
var
  cr: TRect;
  a:  TLMDActiveArea;
  st: TLMDElemState;
begin
  cr := Bounds(0, 0, hs.Width, hs.Height);

  C.Brush.Color := clBlack; // Make fully
  C.FillRect(cr);           // transparent.

  HS.Background.Draw(C, cr);

  for a := Low(TLMDActiveArea) to High(TLMDActiveArea) do
    if a in FUsedAreas then
    begin
      if HS.GetActiveArea(a in FEnabledAreas, a, st) then
        st.Draw(c, FLayout[a]);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure THotSpot.AnimateTo(ASite: TLMDDockSite; AShowing: Boolean;
  const ABounds: TRect);
const
  ANIM_ALPHA: array[Boolean] of Integer = (0, 255);
var
  durtn: Integer;
  prev:  TRect;
  neww:  Integer;
  newh:  Integer;
begin
  if (FState.Alpha <> ANIM_ALPHA[AShowing]) or
     not EqualRect(FState.Bounds, ABounds) then
  begin
    if not HandleAllocated or not IsWindowVisible(WindowHandle) then
      prev := ABounds
    else
    begin
      neww        := ABounds.Right - ABounds.Left;
      newh        := ABounds.Bottom - ABounds.Top;
      prev.Left   := Left + (Width - neww) div 2;
      prev.Top    := Top + (Height - newh) div 2;
      prev.Right  := prev.Left + neww;
      prev.Bottom := prev.Top + newh;
    end;

    FPrevState.Alpha  := Animator.RangedVal(FAnimationId, FPrevState.Alpha,
                                            FState.Alpha);
    FPrevState.Bounds := prev;
    FState.Alpha      := ANIM_ALPHA[AShowing];
    FState.Bounds     := ABounds;

    durtn := 100 * Ord((FSite <> nil) and FSite.StyleElems.SiteBack.
                       AnimateHotSpots);
    Animator.ReStart(durtn, AnimationStep, FAnimationId);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure THotSpot.AnimationStep(AId: Integer);
var
  alpha:          Integer;
  spos, dpos, sz: TPoint;
  bf:             BLENDFUNCTION;
  bnds:           TRect;
begin
  alpha := Animator.RangedVal(FAnimationId, FPrevState.Alpha,
                              FState.Alpha);
  bnds  := Animator.RangedVal(FAnimationId, FPrevState.Bounds,
                              FState.Bounds, akCubic);

  if alpha = 0 then
  begin
    ShowWindow(Handle, SW_HIDE);
    BoundsRect := bnds;
  end
  else
  begin
    ShowWindow(Handle, SW_SHOWNOACTIVATE);

    bf.BlendOp             := AC_SRC_OVER;
    bf.BlendFlags          := 0;
    bf.SourceConstantAlpha := alpha;
    bf.AlphaFormat         := AC_SRC_ALPHA;
    spos                   := Point(0, 0);

    dpos := bnds.TopLeft;
    sz   := Point(bnds.Right - bnds.Left, bnds.Bottom - bnds.Top);

    if not UpdateLayeredWindow(Handle, 0, @dpos, @sz,
                               FBitmap.Canvas.Handle,
                               @spos, 0, @bf, ULW_ALPHA) then
      RaiseLastOSError;

    {$IFDEF LMDCOMP12}
    UpdateBounds;
    {$ELSE}
    Perform(WM_MOVE, 0, 0); // Calls private UpdateBounds.
    {$ENDIF}
  end;
end;

{ ---------------------------------------------------------------------------- }
constructor THotSpot.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csOpaque];
  Visible      := False;
  FBitmap      := TBitmap.Create;

  ZOrderer.AddWindow(Self);
end;

{ ---------------------------------------------------------------------------- }
destructor THotSpot.Destroy;
begin
  ZOrderer.RemoveWindow(Self);
  Animator.Cancel(FAnimationId);
  FBitmap.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure THotSpot.ZoneDestroying(AZone: TLMDDockZone);
begin
  if AZone = FZone then
    FZone := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure THotSpot.Show(AKind: TLMDHotSpotKind; ASite: TLMDDockSite;
  ACenterZone: TLMDDockZone; AEnabledAreas: TLMDActiveAreas;
  const ASiteRect, AZoneRect: TRect);
const
  IDENT   = 20;
  SIDES_A = [hsaZoneLeft, hsaZoneTop, hsaZoneRight, hsaZoneBottom];
  SIDES_B = [hsaDocsLeft, hsaDocsTop, hsaDocsRight, hsaDocsBottom];
var
  hs:       TLMDHotspotBase;
  lft, top: Integer;
  oldareas: TLMDActiveAreas;
  bigcrss:  Boolean;
begin
  oldareas      := FEnabledAreas;
  FSite         := ASite;
  FKind         := AKind;
  FEnabledAreas := AEnabledAreas;
  FUsedAreas    := HOTSPOT_AREAS[AKind];
  bigcrss       := True;

  if SIDES_A * FEnabledAreas = [] then
  begin
    FUsedAreas := FUsedAreas - SIDES_A;
    bigcrss    := False;
  end;
  if SIDES_B * FEnabledAreas = [] then
  begin
    FUsedAreas := FUsedAreas - SIDES_B;
    bigcrss    := False;
  end;

  hs := FSite.StyleElems.GetHotSpot(AKind, bigcrss);
  hs.GetAreas(FLayout);

  lft := 0; // Initialize
  top := 0; //

  case AKind of
    hsLeft:       begin
                    lft   := ASiteRect.Left + IDENT;
                    top   := (ASiteRect.Top + ASiteRect.Bottom -
                              hs.Height) div 2;
                    FZone := ASite.FZoneTree.Root;
                  end;
    hsTop:        begin
                    lft   := (ASiteRect.Left + ASiteRect.Right -
                              hs.Width) div 2;
                    top   := ASiteRect.Top + IDENT;
                    FZone := ASite.FZoneTree.Root;
                  end;
    hsRight:      begin
                    lft   := ASiteRect.Right - IDENT - hs.Width;
                    top   := (ASiteRect.Top + ASiteRect.Bottom -
                              hs.Height) div 2;
                    FZone := ASite.FZoneTree.Root;
                  end;
    hsBottom:     begin
                    lft   := (ASiteRect.Left + ASiteRect.Right -
                              hs.Width) div 2;
                    top   := ASiteRect.Bottom - IDENT - hs.Height;
                    FZone := ASite.FZoneTree.Root;
                  end;
    hsCenter:     begin
                    lft   := (AZoneRect.Left + AZoneRect.Right -
                              hs.Width) div 2;
                    top   := (AZoneRect.Top + AZoneRect.Bottom -
                              hs.Height) div 2;
                    FZone := ACenterZone;
                  end;
  else
    Assert(False);
  end;

  FBitmap.Width       := hs.Width;
  FBitmap.Height      := hs.Height;
  FBitmap.PixelFormat := pf32bit;

  PrepareBitmap(FBitmap.Canvas, hs);
  ParentWindow := Application.Handle;

  AnimateTo(FSite, True, Rect(lft, top, lft + hs.Width,
                              top + hs.Height));
end;

{ ---------------------------------------------------------------------------- }
procedure THotSpot.Hide;
begin
  if HandleAllocated then
    AnimateTo(FSite, False, FState.Bounds);
  FSite := nil;
end;

{ ---------------------------------------------------------------------------- }
function THotSpot.GetHotSpotInfo(P: TPoint; out AZone: TLMDDockZone;
  out ADropAlign: TAlign): Boolean;
const
  DROP_ALIGNS: array[TLMDActiveArea] of TAlign = (
    alLeft,      // hsaSiteLeft
    alTop,       // hsaSiteTop
    alRight,     // hsaSiteRight
    alBottom,    // hsaSiteBottom
    alLeft,      // hsaZoneLeft
    alTop,       // hsaZoneTop
    alRight,     // hsaZoneRight
    alBottom,    // hsaZoneBottom
    alDocLeft,   // hsaDocsLeft
    alDocTop,    // hsaDocsTop
    alDocRight,  // hsaDocsRight
    alDocBottom, // hsaDocsBottom
    alClient,    // hsaTabs
    alNone,      // hsaSplitter
    alNone       // hsaZoneTabs
  );
  DOC_SIDES = [hsaZoneLeft, hsaZoneTop, hsaZoneRight, hsaZoneBottom];
var
  zn:   TLMDDockZone;
  dnfo: TLMDTabbedDocsInfo;
  i, a: TLMDActiveArea;
begin
  Result     := False;
  AZone      := nil;
  ADropAlign := alNone;

  if (FZone <> nil) and (FState.Alpha <> 0) and // Not shifting or hiding.
     EqualRect(FState.Bounds, BoundsRect) then  //
  begin
    P := ScreenToClient(P);
    a := hsaNone;

    for i := Low(FLayout) to High(FLayout) do
      if (i in FUsedAreas * FEnabledAreas) and PtInRect(FLayout[i], P) then
      begin
        a := i;
        Break; // for
      end;

    if a <> hsaNone then
    begin
      if (a in DOC_SIDES) and FZone.TabbedDocsInfo(dnfo) then
        zn := dnfo.MainZone
      else
        zn := FZone;

      AZone      := zn;
      ADropAlign := DROP_ALIGNS[a];
      Result     := True;
    end;
  end;
end;

{ ****************************** TAutoHideSide ******************************* }
{ ---------------------------------------------------------------------------- }
procedure TAutoHideSide.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := -1;
end;

{ ---------------------------------------------------------------------------- }
procedure TAutoHideSide.WMTimer(var Message: TWMTimer);
var
  p: TPoint;
begin
  case Message.TimerID of
    1:  if Application.Active then
        begin
          GetCursorPos(p);
          UpdateTracking(True, False);
        end;
    2:  UpdateTracking(False, False);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TAutoHideSide.CMDesignHitTest(var Msg: TCMDesignHitTest);
begin
  Msg.Result := 1;
end;

{ ---------------------------------------------------------------------------- }
function TAutoHideSide.FindTabAtPoint(const P: TPoint): Integer;
var
  i: Integer;
begin
  for i := 0 to High(FTabs) do
    if PtInRect(FTabs[i].Bounds, P) then
    begin
      Result := i;
      Exit;
    end;

  Result := -1;
end;

{ ---------------------------------------------------------------------------- }
procedure TAutoHideSide.UpdateTracking(AImmediate, AActivate: Boolean);
var
  p:   TPoint;
  old: Integer;
  pnl: TLMDDockPanel;
begin
  p       := ScreenToClient(Mouse.CursorPos);
  old     := FHotTab;
  FHotTab := FindTabAtPoint(p);
  if (FHotTab <> -1) and ((FTabs[FHotTab].PanelZone = nil) or
                          (FTabs[FHotTab].PanelZone.Panel = nil)) then
    FHotTab := -1;

  if FHotTab <> -1 then
    pnl := FTabs[FHotTab].PanelZone.Panel
  else
    pnl := nil;

  if pnl <> nil then
  begin
    if AImmediate or ((FHotTab = old) and not FTimerActive) then
    begin
      UpdateShiftTimer(False);

      if (AActivate and FSite.DeactivateActiveChild([], [pnl])) or
         (not AActivate and FSite.DeactivateActiveChild([FSite.FShiftingPanel],
                                                        [pnl])) then
        SetShiftingPanel(pnl, AActivate);
    end
    else
      UpdateShiftTimer(True);
    UpdateTrackTimer;
  end
  else
    CancelTracking;

  if old <> FHotTab then
    Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TAutoHideSide.UpdateTrackTimer;
begin
  if FHotTab <> -1 then
    SetTimer(Handle, 2, 50, nil)
  else
    KillTimer(Handle, 2);
end;

{ ---------------------------------------------------------------------------- }
procedure TAutoHideSide.CancelTracking;
var
  old: Integer;
begin
  old     := FHotTab;
  FHotTab := -1;
  UpdateShiftTimer(False);
  UpdateTrackTimer;

  if old <> FHotTab then
    Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TAutoHideSide.UpdateShiftTimer(ATimerActive: Boolean);
begin
  if FTimerActive <> ATimerActive then
  begin
    if ATimerActive then
      SetTimer(Handle, 1, 500, nil)
    else if HandleAllocated then
      KillTimer(Handle, 1);
    FTimerActive := ATimerActive;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TAutoHideSide.SetShiftingPanel(APanel: TLMDDockPanel;
  AActivate: Boolean);
begin
  FSite.SetShifingPanel(APanel, FSide, True, AActivate);
end;

{ ---------------------------------------------------------------------------- }
procedure TAutoHideSide.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle or WS_EX_TOPMOST;
end;

{ ---------------------------------------------------------------------------- }
procedure TAutoHideSide.Paint;
var
  se:   TLMDDockElems;
  pa:   TLMDPinAreaBase;
  i:    Integer;
  lfnt: TLogFont;
  org:  TPoint;

  procedure DrawTab(AIndex: Integer);
  var
    tab: ^TAutoHideTab;
    cr:   TRect;
    lst:  TCustomImageList;
    idx:  Integer;
    x, y: Integer;
    s:    TLMDString;
  begin
    tab := @FTabs[AIndex];
    tab.PanelZone.GetImageParams(lst, idx);

    pa.GetTab(AIndex = FHotTab).Draw(Canvas, tab.Bounds);
    cr := pa.TabContent.AdjustRect(tab.Bounds);

    { Image }

    if pa.ShowTabImage and (lst <> nil) and (idx >= 0) and
                           (idx < lst.Count) then
    begin
      if FSide in [alLeft, alRight] then
      begin
        x := ((cr.Left + cr.Right) - lst.Width) div 2;
        y := cr.Top;
        Inc(cr.Top, lst.Height + STD_INDENT);
      end
      else
      begin
        x := cr.Left;
        y := ((cr.Top + cr.Bottom) - lst.Height) div 2;
        Inc(cr.Left, lst.Width + STD_INDENT);
      end;
      lst.Draw(Canvas, x, y, idx);
    end;

    { Caption }

    if FSide in [alLeft, alRight] then
    begin
      x := ((cr.Left + cr.Right) + Canvas.TextHeight('Wg')) div 2;
      y := cr.Top;
    end
    else
    begin
      x := cr.Left;
      y := ((cr.Top + cr.Bottom) - Canvas.TextHeight('Wg')) div 2;
    end;

    s                 := tab.PanelZone.Panel.Caption;
    Canvas.Font.Color := pa.GetTextColor(AIndex = FHotTab);
    SetBkMode(Canvas.Handle, TRANSPARENT);
    LMDDrawOrientedText(Canvas, s, x, y, tab.Bounds);
  end;

  procedure DrawSiteBack;
  var
    sb: TLMDElemState;
  begin
    sb := se.SiteBack.GetBack(FSite.IsFloatingSite,
                              FSite.IsFloatingDoc);

    OffsetViewportOrgEx(Canvas.Handle, -Left, -Top, @org);
    sb.Draw(Canvas, BoundsRect);
    SetViewportOrgEx(Canvas.Handle, org.X, org.Y, nil);
  end;

begin
  TLMDBuffer.BeginDraw(Canvas, ClientRect);
  try
    if (FSite <> nil) and (FSide in [alLeft, alRight]) then // Create vertical font.
    begin
      GetObject(FSite.Font.Handle, SizeOf(lfnt), @lfnt);
      lfnt.lfEscapement   := 270 * 10;
      lfnt.lfOrientation  := 270 * 10;
      lfnt.lfOutPrecision := OUT_TT_ONLY_PRECIS;
      Canvas.Font.Handle  := CreateFontIndirect(lfnt);
    end
    else
      Canvas.Font := Font;

    se := FSite.StyleElems;
    pa := se.GetPinArea(FSide);

    DrawSiteBack;
    pa.Background.Draw(Canvas, ClientRect);

    for i := 0 to High(FTabs) do
    begin
      DrawTab(i);
      pa.Spacer.Draw(Canvas, FTabs[i].Spacer);
    end;
  finally
    TLMDBuffer.EndDraw;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TAutoHideSide.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if Button = mbLeft then
    UpdateTracking(True, True);
end;

{ ---------------------------------------------------------------------------- }
procedure TAutoHideSide.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  UpdateTracking(False, False);
end;

{ ---------------------------------------------------------------------------- }
constructor TAutoHideSide.Create(ASite: TLMDDockSite;
  ASide: TAlign);
begin
  inherited Create(ASite);
  FSite        := ASite;
  FSide        := ASide;
  FHandler     := TTabsHandler.CreateHandler(ASide);
  FHotTab      := -1;
  ControlStyle := [csOpaque, csNoDesignVisible];
  Visible      := False;
  Parent       := ASite;
end;

{ ---------------------------------------------------------------------------- }
destructor TAutoHideSide.Destroy;
begin
  FHandler.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TAutoHideSide.ZoneDestroying(AZone: TLMDDockZone);
var
  i: Integer;
begin
  for i := 0 to High(FTabs) do
    if FTabs[i].PanelZone = AZone then
    begin
      FTabs[i].PanelZone := nil;
      Break; // for
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TAutoHideSide.UpdateLayout(const R: TRect);
var
  i:      Integer;
  pa:     TLMDPinAreaBase;
  cr:     TRect;
  items:  TTabItems;
  x, y:   Integer;
  xsz:    Integer;
  pzns:   TList;
  lspc:   PRect;

  function GetBaseTabSize(APnlZone: TLMDDockZone): Integer;
  var
    lst: TCustomImageList;
    idx: Integer;
    bts: Integer;
    sz:  TSize;
  begin
    Canvas.Font := Font;
    bts         := 0;

    if pa.ShowTabImage and APnlZone.GetImageParams(lst, idx) then
    begin
      if FSide in [alLeft, alRight] then
        Inc(bts, lst.Height + STD_INDENT)
      else
        Inc(bts, lst.Width + STD_INDENT);
    end;

    Inc(bts, Canvas.TextWidth(APnlZone.Caption));
    if FSide in [alLeft, alRight] then // Strange vertical
      Inc(bts, 4);                     // font behavior.

    sz     := pa.TabContent.UnadjustSize(bts, bts);
    Result := FHandler.GetYSize(Rect(0, 0, sz.cx, sz.cy));
  end;

begin
  if IsRectEmpty(R) then
  begin
    Visible := False;
    Exit;
  end;

  pa   := FSite.StyleElems.GetPinArea(FSide);
  cr   := pa.Content.AdjustRect(Rect(0, 0, R.Right - R.Left, R.Bottom - R.Top));
  pzns := TList.Create;
  try
    FSite.FZoneTree.GetUnpinnedPanelZones(FSide, True, pzns);

    SetLength(items, pzns.Count);
    for i := 0 to High(items) do
    begin
      items[i].Zone     := TLMDDockZone(pzns[i]);
      items[i].BaseSize := GetBaseTabSize(pzns[i]);
    end;

    TTabsHandler.CalcLayout(FSite.Canvas, FHandler.GetYSize(R),
                            pa.GetSpacerSize, cmNone, items);
    SetLength(FTabs, Length(items));

    lspc := nil;
    x    := FHandler.GetXMin(cr);
    y    := FHandler.GetYMin(cr);
    xsz  := FHandler.GetXSize(cr);

    for i := 0 to High(items) do
    begin
      FTabs[i].PanelZone := items[i].Zone;
      FTabs[i].Bounds    := FHandler.GetRealRect(x, y, xsz, items[i].Size);
      FTabs[i].Spacer    := FHandler.GetRealRect(x, y + items[i].Size, xsz,
                                                 Max(0, pa.GetSpacerSize));
      Inc(y, items[i].Size + pa.GetSpacerSize);
      lspc := @FTabs[i].Spacer;
    end;

    if lspc <> nil then
      lspc^ := Rect(0, 0, 0, 0);

    BoundsRect := R;
    Visible    := True;
    Invalidate;
  finally
    pzns.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TAutoHideSide.FindPanelAtPoint(const P: TPoint): TLMDDockPanel;
var
  idx: Integer;
begin
  idx := FindTabAtPoint(ScreenToClient(P));

  if (idx <> -1) and (FTabs[idx].PanelZone <> nil) then
    Result := FTabs[idx].PanelZone.Panel
  else
    Result := nil;
end;

{ ******************************* TDockingRect ******************************* }
{ ---------------------------------------------------------------------------- }
procedure TDockingRect.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.Result := 0;
end;

procedure TDockingRect.WMNCHitTest(var Message: TWMNCHitTest);
begin
  Message.Result := HTTRANSPARENT;
end;

{ ---------------------------------------------------------------------------- }
procedure TDockingRect.AnimateTo(AShowing, AAccepted: Boolean;
  AShowingFrom: PRect; const ABounds: TRect);
const
  ANIM_ALPHA: array[Boolean] of Integer = (0, 80);
begin
  if (FState.Alpha <> ANIM_ALPHA[AShowing]) or
     not EqualRect(FState.Bounds, ABounds) then
  begin
    if AShowing and (AShowingFrom <> nil) and AAccepted and
       not FState.Accepted then
    begin
      FPrevState.Accepted := False;
      FPrevState.Alpha    := 0;
      FPrevState.Bounds   := AShowingFrom^;
    end
    else
    begin
      FPrevState.Accepted := FState.Accepted;
      FPrevState.Alpha    := Animator.RangedVal(FAnimationId, FPrevState.Alpha,
                                                FState.Alpha, akSqrt);
      if AShowing then
        FPrevState.Bounds := ABounds
      else
        FPrevState.Bounds := BoundsRect;
    end;

    FState.Accepted := AAccepted;
    FState.Alpha    := ANIM_ALPHA[AShowing];
    FState.Bounds   := ABounds;

    Animator.ReStart(50 * Ord(FAnimate), AnimationStep, FAnimationId);
  end;
end;

procedure TDockingRect.AnimationStep(AId: Integer);
var
  alpha: Integer;
  bnds:  TRect;
begin
  alpha := Animator.RangedVal(FAnimationId, FPrevState.Alpha,
                              FState.Alpha, akSqrt);
  bnds  := Animator.RangedVal(FAnimationId, FPrevState.Bounds,
                              FState.Bounds, akSqrt);

  if alpha = 0 then
  begin
    ShowWindow(Handle, SW_HIDE);
    BoundsRect := bnds; //!!!Rect(0, 0, 0, 0);
  end
  else
  begin
    SetLayeredWindowAttributes(Handle, clFuchsia, alpha,
                               LWA_ALPHA or LWA_COLORKEY);
    SetWindowPos(Handle, 0, bnds.Left, bnds.Top, bnds.Right - bnds.Left,
                 bnds.Bottom - bnds.Top, SWP_SHOWWINDOW or SWP_NOZORDER or
                 SWP_NOACTIVATE or SWP_NOCOPYBITS);
    ZOrderer.UpdateZOrder;

    Invalidate;
    {$IFDEF LMD_DCK_UPDATE}Update;{$ENDIF}
  end;
end;

constructor TDockingRect.Create(AOwner: TComponent);
begin
  inherited;
  Visible := False;
  ZOrderer.AddWindow(Self);
end;

procedure TDockingRect.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style   := WS_POPUP;
    ExStyle := WS_EX_LAYERED;
  end;
end;

destructor TDockingRect.Destroy;
begin
  Animator.Cancel(FAnimationId);
  ZOrderer.RemoveWindow(Self);
  inherited;
end;

procedure TDockingRect.Hide;
begin
  AnimateTo(False, False, nil, FState.Bounds);
end;

{ ---------------------------------------------------------------------------- }
procedure TDockingRect.Paint;
const
  TAB_HEIGHT = 24;
  TAB_WIDTH  = 50;
  TAB_IDENT  = 8;
var
  r:     TRect;
  drwtb: Boolean;
begin
  Canvas.Pen.Color   := FBrdColor;
  Canvas.Brush.Color := FBkColor;
  r                  := ClientRect;

  drwtb := FTabInRect and (ClientHeight > TAB_HEIGHT + 4) and
           (ClientWidth > (TAB_IDENT * 2 + 4));

  if drwtb then
    Dec(r.Bottom, TAB_HEIGHT);

  Canvas.Rectangle(r);
  InflateRect(r, -1, -1);
  Canvas.Rectangle(r);
  InflateRect(r, 1, 1);

  if drwtb then
  begin
    Canvas.Brush.Color := clFuchsia; // Transparent area.
    Canvas.FillRect(Rect(r.Left, r.Bottom, ClientRect.Right,
                         ClientRect.Bottom));

    r := Rect(r.Left + TAB_IDENT, r.Bottom - 2,
              r.Left + TAB_IDENT + TAB_WIDTH, ClientRect.Bottom - 2);
    if r.Right > ClientRect.Right - TAB_IDENT then
      r.Right := ClientRect.Right - TAB_IDENT;

    Canvas.Pen.Color   := FBrdColor;
    Canvas.Brush.Color := FBkColor;

    Canvas.Rectangle(r);
    InflateRect(r, -1, -1);
    Canvas.Rectangle(r);
    InflateRect(r, 1, 1);

    Canvas.FillRect(Rect(r.Left + 2, r.Top,        // Remove tab upper border.
                         r.Right - 2, r.Top + 2)); //

    Canvas.Pixels[r.Left, r.Bottom - 1]      := clFuchsia;
    Canvas.Pixels[r.Left + 2, r.Bottom - 3]  := FBrdColor;
    Canvas.Pixels[r.Right - 1, r.Bottom - 1] := clFuchsia;
    Canvas.Pixels[r.Right - 3, r.Bottom - 3] := FBrdColor;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TDockingRect.Show(AShowingFrom: PRect; const ABounds: TRect;
  ATabInRect: Boolean; ABkColor, ABrdColor: TColor; AAccepted,
  AAnimate: Boolean);
begin
  FTabInRect   := ATabInRect;
  FAnimate     := AAnimate;
  FBkColor     := ABkColor;
  FBrdColor    := ABrdColor;
  ParentWindow := Application.Handle;
  AnimateTo(True, AAccepted, AShowingFrom, ABounds);
end;

{ ****************************** TFloatingSite ******************************* }
{ ---------------------------------------------------------------------------- }
function TFloatingSite.AllowClose: Boolean;
var
  i:   Integer;
  pnl: TLMDDockPanel;
begin
  for i := 0 to PanelCount - 1 do
  begin
    pnl := Panels[i];
    if pnl.PanelVisible and not (pbClose in pnl.Buttons) then
    begin
      Result := False;
      Exit;
    end;
  end;
  Result := not (dlmPanelClose in FLockMode);
end;

{ ---------------------------------------------------------------------------- }
function TFloatingSite.AllowMaximize: Boolean;
var
  i:   Integer;
  pnl: TLMDDockPanel;
begin
  for i := 0 to PanelCount - 1 do
  begin
    pnl := Panels[i];
    if pnl.PanelVisible and not (pbMaximize in pnl.Buttons) then
    begin
      Result := False;
      Exit;
    end;
  end;
  Result := True;
end;

{ ---------------------------------------------------------------------------- }
function TFloatingSite.WantsTransparency(const P: TPoint): Boolean;
var
  sgl: TLMDDockPanel;
  cp:  TPoint;
begin
  if (FForm <> nil) and FForm.IsDragging then
    Result := True
  else if GetFormKind(sgl) = ffPanel then
  begin
    cp := p;
    MapWindowPoints(Handle, sgl.Handle, cp, 1);

    Result := (GetFormKind(sgl) = ffPanel) and
              PtInRect(sgl.FHeaderArea, cp) and
              (sgl.FindButtonAtPoint(cp) = pbNone);
  end
  else
    Result := False;
end;

{ ---------------------------------------------------------------------------- }
function TFloatingSite.FormHeaderDrag(out APanel: TLMDDockPanel): Boolean;
begin
  Result := IsSinglePanelFloatingSite(Self, APanel);
end;

{ ---------------------------------------------------------------------------- }
function TFloatingSite.GetFloatingForm: TLMDFloatingForm;
begin
  Result := FForm;
end;

{ ---------------------------------------------------------------------------- }
function TFloatingSite.GetFormKind(
  out ASingle: TLMDDockPanel): TLMDFloatFormKind;

  function IsSingleTabZone(out ASingle: TLMDDockPanel): Boolean;
  var
    tbzn: TLMDDockZone;
    pzn:  TLMDDockZone;
    i:    Integer;
  begin
    tbzn := nil;

    for i := 0 to PanelCount - 1 do
      if Panels[i].PanelVisible then
      begin
        pzn := Panels[i].FZone.FParent;

        if (pzn = nil) or (pzn.FKind <> zkTabs) or
           ((tbzn <> nil) and (pzn <> tbzn)) then
        begin
          Result := False;
          Exit;
        end;

        tbzn := pzn;
      end;

    if (tbzn <> nil) and (tbzn.SelectedPage <> nil) then
    begin
      ASingle := tbzn.SelectedPage.FPanel;
      Result := (ASingle <> nil);
    end
    else
      Result := False;
  end;

  function UsePanelStyle(out ASingle: TLMDDockPanel): Boolean;
  begin
    Result := IsSinglePanelFloatingSite(Self, ASingle) or
              IsSingleTabZone(ASingle);
  end;

begin
  if UsePanelStyle(ASingle) then
  begin
    if IsFloatingDoc then
      Result := ffDoc
    else
      Result := ffPanel;
  end
  else
  begin
    Result := ffGroup;
    ASingle := nil;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFloatingSite.GetHeaderBtns(var AButtons: TLMDPanelBtnKinds);
var
  mgr: TLMDDockManager;
  b:   TLMDPanelBtnKind;
  add: Boolean;
  rem: Boolean;

  function AllowButton(B: TLMDPanelBtnKind): Boolean;
  var
    i: Integer;
    p: TLMDDockPanel;
  begin
    for i := 0 to PanelCount - 1 do
    begin
      p := Panels[i];
      if p.PanelVisible and not (B in p.Buttons) then
      begin
        Result := False;
        Exit;
      end;
    end;
    Result := True;
  end;

begin
  mgr := FManager;

  for b := Low(TLMDPanelBtnKind) to High(TLMDPanelBtnKind) do
  begin
    case B of
      pbMaximize: begin
                    add := AllowButton(pbMaximize);
                    rem := True;
                  end;
      pbClose:    begin
                    add := not (dlmPanelClose in FLockMode) and
                           AllowButton(pbClose);
                    rem := True;
                  end;
    else
      add := False;
      rem := False;
    end;

    if add and ((mgr = nil) or (b in mgr.FloatFormButtons)) then
      Include(AButtons, b)
    else if rem then
      Exclude(AButtons, b);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TFloatingSite.GetIsFloatingDoc: Boolean;
begin
  Result := (PanelCount = 1) and (GetClientKind(Panels[0].
                                  GetDockClient) = dkDocument);
end;

{ ---------------------------------------------------------------------------- }
function TFloatingSite.GetIsFloatingSite: Boolean;
begin
  Result := True;
end;

{ ---------------------------------------------------------------------------- }
function TFloatingSite.GetPanelButtons(
  APanel: TLMDDockPanel): TLMDPanelBtnKinds;
var
  sgl: TLMDDockPanel;
begin
  Result := inherited GetPanelButtons(APanel);
  if (GetFormKind(sgl) = ffPanel) and (APanel = sgl) then
    GetHeaderBtns(Result);
end;

{ ---------------------------------------------------------------------------- }
function TFloatingSite.HeaderBtnClick(B: TLMDPanelBtnKind): Boolean;
begin
  case B of
    pbMaximize: begin
                  if FForm.WindowState = wsNormal then
                    FForm.WindowState := wsMaximized
                  else
                    FForm.WindowState := wsNormal;
                  Result := True;
                end;
    pbClose:    begin
                  FForm.Close;
                  Result := True;
                end;
  else
    Result := False;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFloatingSite.NotifyFloatForm;
begin
  if FForm <> nil then
    FForm.SiteNotification;
end;

{ ---------------------------------------------------------------------------- }
procedure TFloatingSite.PanelButtonClick(APanel: TLMDDockPanel;
  B: TLMDPanelBtnKind);
var
  sgl: TLMDDockPanel;
begin
  if (GetFormKind(sgl) = ffPanel) and (APanel = sgl) then
  begin
    if not HeaderBtnClick(B) then
      inherited;
  end
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
function TFloatingSite.ShowPanelHeader(APanel: TLMDDockPanel): Boolean;
var
  sgl: TLMDDockPanel;
  ff:  TLMDFloatFrameBase;
begin
  Result := inherited ShowPanelHeader(APanel);

  case GetFormKind(sgl) of
    ffPanel:  begin
                ff     := StyleElems.GetForm(ffPanel);
                Result := Result and ((ff.BorderKind = fbCustom) or
                                      (APanel <> sgl));
              end;
    ffGroup:  ; // Do no change result.
    ffDoc:    Result := False;
  else
    Assert(False);
  end;
end;

{ ****************************** TSiteStreamer ******************************* }
{ ---------------------------------------------------------------------------- }
function TSiteStreamer.ZoneKindToStr(AKind: TLMDZoneKind): TLMDString;
begin
  Result := ZONEKIND_STRS[AKind];
end;

{ ---------------------------------------------------------------------------- }
function TSiteStreamer.StrToZoneKind(
  const AKind: TLMDString): TLMDZoneKind;
var
  i: TLMDZoneKind;
begin
  for i := Low(TLMDZoneKind) to High(TLMDZoneKind) do
    if SameText(ZONEKIND_STRS[i], AKind) then
    begin
      Result := i;
      Exit;
    end;
  raise ELMDDockManager.CreateFmt(SLMDDckInvalidZoneKind, [AKind]);
end;

{ ---------------------------------------------------------------------------- }
function TSiteStreamer.GetSeqZoneSize(AZone: TLMDDockZone): Integer;
begin
  case AZone.Parent.Kind of
    zkHorz: Result := AZone.Width;
    zkVert: Result := AZone.Height;
  else
    Result := 0;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TSiteStreamer.SetSeqZoneSize(AZone: TLMDDockZone;
  AValue: Integer);
begin
  case AZone.Parent.Kind of
    zkHorz: AZone.FWidth  := AValue;
    zkVert: AZone.FHeight := AValue;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TSiteStreamer.FindFirstZoneElem(
  AParent: ILMDXmlElement): ILMDXmlElement;
var
  i:  Integer;
  nd: ILMDXmlNode;
begin
  for i := 0 to AParent.ChildNodes.Count - 1 do
  begin
    nd := AParent.ChildNodes[i];
    if (nd.NodeType = LMD_NODE_ELEMENT) and
       (nd.NodeName = 'zone') then
    begin
      Result := nd.AsElement;
      Exit;
    end;
  end;

  Result := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TSiteStreamer.DoSave(AParent: ILMDXmlElement);
var
  elem: ILMDXmlElement;
  id:   TLMDString;
begin
  elem := AParent.AppendElement('site');

  if FSite is TFloatingSite then
  begin
    elem.SetBoolAttr('floating', True);
    elem.SetIntAttr ('left',     TFloatingSite(FSite).FForm.Left);
    elem.SetIntAttr ('top',      TFloatingSite(FSite).FForm.Top);
    elem.SetIntAttr ('width',    TFloatingSite(FSite).FForm.Width);
    elem.SetIntAttr ('height',   TFloatingSite(FSite).FForm.Height);
  end
  else
  begin
    FCompToId(FSite, id);
    if id <> '' then
      elem.SetAttr('id', id);
  end;

  DoSaveZone(FSite.RootZone, elem);
end;

{ ---------------------------------------------------------------------------- }
procedure TSiteStreamer.DoSaveZone(AZone: TLMDDockZone;
  AParent: ILMDXmlElement);
var
  i:    Integer;
  elem: ILMDXmlElement;
  id:   TLMDString;
  pnl:  TLMDDockPanel;
begin
  { Save zone }

  elem := AParent.AppendElement('zone');
  elem.SetAttr('kind', ZoneKindToStr(AZone.Kind));
  if AZone.AutoHide then
    elem.SetBoolAttr('autohide', True);

  case AZone.Kind of
    zkPanel:
      if AZone.Panel <> nil then
      begin
        pnl := AZone.Panel;
        FCompToId(pnl.GetDockClient, id);

        if id <> '' then
        begin
          elem.SetAttr    ('id',      id);
          elem.SetBoolAttr('visible', pnl.PanelVisible);

          if AZone.IsAutoHidden then
          begin
            elem.SetIntAttr('hiddenwidth',  pnl.Width);
            elem.SetIntAttr('hiddenheight', pnl.Height);
          end;

          if FPersistFloatSize then
          begin
            elem.SetIntAttr('floatwidth',  pnl.UndockWidth);
            elem.SetIntAttr('floatheight',  pnl.UndockHeight);
          end;
        end;
      end;
    zkTabs:
      if AZone.FSelectedPage <> nil then
        elem.SetIntAttr('activetab', AZone.FSelectedPage.Index);
  end;

  if (AZone.Parent <> nil) and (AZone.Parent.Kind in [zkHorz, zkVert]) then
  begin
    elem.SetIntAttr('size', GetSeqZoneSize(AZone));
    if not AZone.AutoHide then
      elem.SetFloatAttr('dsize', AZone.DSize);
  end;

  if AZone.ResizeKind = zrkSpace then
    elem.SetBoolAttr('isspace', True);

  { Save children }

  for i := 0 to AZone.ZoneCount - 1 do
    DoSaveZone(AZone.Zones[i], elem);
end;

{ ---------------------------------------------------------------------------- }
procedure TSiteStreamer.DoLoad(AElem: ILMDXmlElement);
var
  bnds:   TRect;
  rootzn: ILMDXmlElement;
begin
  FSite.BeginLoading;
  try
    if FSite is TFloatingSite then
    begin
      bnds.Left   := AElem.GetIntAttr('left');
      bnds.Top    := AElem.GetIntAttr('top');
      bnds.Right  := bnds.Left + AElem.GetIntAttr('width');
      bnds.Bottom := bnds.Top + AElem.GetIntAttr('height');

      AdjustBounds(bnds);
      TFloatingSite(FSite).FForm.BoundsRect := bnds;
    end;

    rootzn := FindFirstZoneElem(AElem);
    if rootzn <> nil then
      DoLoadZone(FSite.RootZone, rootzn);
  finally
    FSite.EndLoading;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TSiteStreamer.DoLoadZone(AZone: TLMDDockZone;
  AElem: ILMDXmlElement);
var
  acttb:      Integer;
  i:          Integer;
  nd:         ILMDXmlNode;
  chznelm:    ILMDXmlElement;
  chzn:       TLMDDockZone;
  comp:       TComponent;
  pnl:        TLMDDockPanel;
  wdth, hght: Integer;
begin
  { Load zone }

  acttb           := -1; // Initialize.
  AZone.FKind     := StrToZoneKind(AElem.GetAttr('kind'));
  AZone.FAutoHide := AElem.GetBoolAttr('autohide');

  case AZone.Kind of
    zkPanel:
    begin
      FIdToComp(AElem.GetAttr('id'), comp);

      if (comp <> nil) and (comp is TControl) then
      begin
        FSite.InternalDockControl(TControl(comp), AZone, alClient,
                                  -1, True, True);
        pnl := FSite.FindPanelByClient(TControl(comp));

        pnl.PanelVisible := AElem.GetBoolAttr('visible');
        wdth             := AElem.GetIntAttr('hiddenwidth', pnl.Width);
        hght             := AElem.GetIntAttr('hiddenheight', pnl.Height);

        if FPersistFloatSize then
        begin
          pnl.UndockWidth  := AElem.GetIntAttr('floatwidth');
          pnl.UndockHeight := AElem.GetIntAttr('floatheight');
        end;

        pnl.SetBounds(pnl.Left, pnl.Top, wdth, hght); // Required to do in
                                                      // single step.

        if comp <> pnl then
        begin
          pnl.Caption            := LMDGetClientCaption(TControl(comp));
          TControl(comp).Visible := pnl.PanelVisible;
        end;
      end;
    end;
    zkTabs:
    begin
      acttb := AElem.GetIntAttr('activetab', -1);
    end;
  end;

  if (AZone.Parent <> nil) and (AZone.Parent.Kind in [zkHorz, zkVert]) then
  begin
    SetSeqZoneSize(AZone, AElem.GetIntAttr('size'));
    if not AZone.AutoHide then
      AZone.FDSize := AElem.GetFloatAttr('dsize');
  end;

  if AElem.GetBoolAttr('isspace') then
    FSite.FZoneTree.FSpaceZone := AZone;

  { Load children }

  for i := 0 to AElem.ChildNodes.Count - 1 do
  begin
    nd := AElem.ChildNodes[i];
    if (nd.NodeType = LMD_NODE_ELEMENT) and
       (nd.NodeName = 'zone') then
    begin
      chznelm := nd.AsElement;
      chzn    := TLMDDockZone.Create(FSite.FZoneTree);

      AZone.AddZone(chzn); // Set proper parent first.
      DoLoadZone(chzn, chznelm);
    end;
  end;

  { Set active tab }

  if (AZone.Kind = zkTabs) and (acttb >= 0) and
     (acttb < AZone.ZoneCount) then
    AZone.FSelectedPage := AZone.Zones[acttb]
  else
    AZone.FSelectedPage := nil;
end;

{ ---------------------------------------------------------------------------- }
class procedure TSiteStreamer.Save(ASite: TLMDDockSite;
  AParent: ILMDXmlElement; ACompToId: TSiteStreamerCompToId;
  ASaveFloatSize: Boolean);
var
  stmr: TSiteStreamer;
begin
  stmr := TSiteStreamer.Create;
  try
    stmr.FSite             := ASite;
    stmr.FCompToId         := ACompToId;
    stmr.FPersistFloatSize := ASaveFloatSize;
    stmr.DoSave(AParent);
  finally
    stmr.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
class function TSiteStreamer.GetParams(AElem: ILMDXmlElement;
  out AFloating: Boolean; out AId: TLMDString): Boolean;
begin
  AFloating := False;
  AId       := '';
  Result    := (AElem.NodeName = 'site');

  if Result then
  begin
    AFloating := AElem.GetBoolAttr('floating');
    if not AFloating then
      AId := AElem.GetAttr('id');
  end;
end;

{ ---------------------------------------------------------------------------- }
class procedure TSiteStreamer.Load(ASite: TLMDDockSite;
  AElem: ILMDXmlElement; AIdToComp: TSiteStreamerIdToComp;
  ALoadFloatSize: Boolean);
var
  stmr: TSiteStreamer;
begin
  stmr := TSiteStreamer.Create;
  try
    stmr.FSite             := ASite;
    stmr.FIdToComp         := AIdToComp;
    stmr.FPersistFloatSize := ALoadFloatSize;
    stmr.DoLoad(AElem);
  finally
    stmr.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSite.DoUnDock(NewTarget: TWinControl;
  Client: TControl): Boolean;
var
  dnfo: TLMDDragInfo;
begin
  Result := True;

  if NewTarget = Self then
  begin
    dnfo := GetDragInfo(ScreenToClient(Mouse.CursorPos), Client);
    if dnfo.Zone = nil then
      NewTarget := nil; // Actually, client will be floating.
  end;

  if Assigned(OnUnDock) then                                         // As in
    OnUnDock(Self, Client, NewTarget, Result);                       // VCL.
  Result := Result and (Perform(CM_UNDOCKCLIENT, WPARAM(NewTarget),  //
            LPARAM(Client)) = 0);                                    //
end;

procedure TLMDDockSite.DoUpdateHotSpots(AClient: TControl;
  AZone: TLMDDockZone; var EnabledAreas: TLMDActiveAreas);
begin
  if Assigned(FOnUpdateHotSpots) then
    FOnUpdateHotSpots(Self, AZone, EnabledAreas);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSite.UpdateUndockSizes;
var
  i:   Integer;
  pnl: TLMDDockPanel;
begin
  for i := 0 to FPanels.Count -1 do
  begin
    pnl := TLMDDockPanel(FPanels[i]);

    pnl.UndockWidth  := pnl.UndockWidth;  // Explicitly set, to prevent
    pnl.UndockHeight := pnl.UndockHeight; // dependency from Width/Height.
  end;
end;

{ ---------------------------------------------------------------------------- }
{$IFDEF LMDCOMP9}
function TLMDDockSite.IsQualifyingSite(const Client: TControl): Boolean;
begin
  Result := True;
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }
procedure TLMDDockPanel.CreateHandle;
begin
  inherited;
  UpdateLayout;
end;

{ ---------------------------------------------------------------------------- }
class procedure TSiteStreamer.FixupIds(ASite: TLMDDockSite;
  AElem: ILMDXmlElement; ARefIdProc: TSiteStreamerReferenceId);
var
  stmr: TSiteStreamer;
begin
  stmr := TSiteStreamer.Create;
  try
    stmr.FSite      := ASite;
    stmr.FRefIdProc := ARefIdProc;
    stmr.DoFixupIds(AElem);
  finally
    stmr.Free;
  end;
end;

procedure TSiteStreamer.AdjustBounds(var ABounds: TRect);
var
  mon:  TMonitor;
  wr:   TRect;
  xoff: Integer;
  yoff: Integer;
begin
  mon := Screen.MonitorFromRect(ABounds);
  wr  := Mon.WorkareaRect;

  if ABounds.Right < wr.Left + 8 then
    xoff := wr.Left + 8 - ABounds.Right
  else if ABounds.Left >= wr.Right - 8 then
    xoff := wr.Right - 8 - ABounds.Left
  else
    xoff := 0;

  if ABounds.Top >= wr.Bottom - 8 then
    yoff := wr.Bottom - 8 - ABounds.Top
  else if ABounds.Top < wr.Top - 8 then
    yoff := wr.Top - 8 - ABounds.Top
  else
    yoff := 0;

  OffsetRect(ABounds, xoff, yoff);
end;

procedure TSiteStreamer.DoFixupIds(AElem: ILMDXmlElement);
var
  rootzn: ILMDXmlElement;
begin
  rootzn := FindFirstZoneElem(AElem);
  if rootzn <> nil then
    DoFixupZoneId(rootzn);
end;

procedure TSiteStreamer.DoFixupZoneId(AElem: ILMDXmlElement);
var
  i:       Integer;
  id:      TLMDString;
  znknd:   TLMDZoneKind;
  nd:      ILMDXmlNode;
  chznelm: ILMDXmlElement;
begin
  znknd := StrToZoneKind(AElem.GetAttr('kind'));
  if znknd = zkPanel then
  begin
    id := AElem.GetAttr('id');
    FRefIdProc(id);
    AElem.SetAttr('id', id);
  end;

  { Fixup children }

  for i := 0 to AElem.ChildNodes.Count - 1 do
  begin
    nd := AElem.ChildNodes[i];
    if (nd.NodeType = LMD_NODE_ELEMENT) and
       (nd.NodeName = 'zone') then
    begin
      chznelm := nd.AsElement;
      DoFixupZoneId(chznelm);
    end;
  end;
end;

procedure TLMDDockSite.ReferenceIdProc(var AId: TLMDString);
var
  old, s: string;
begin
  if FFixupReader <> nil then
  begin
    old := AId;
    s   := AId;
    TReaderAccess(FFixupReader).ReferenceName(s);
    AId := s;
  end;
end;

procedure TLMDDockSite.ReadState(Reader: TReader);
begin
  inherited;
  FixupReadedIds(Reader);
end;

procedure TLMDDockSite.Updated;
begin
  inherited;
  if csDesigning in ComponentState then
    ApplyReadedLayout;
end;

procedure TLMDDockPanel.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params.WindowClass do
  begin
    style := style and not (CS_VREDRAW or CS_HREDRAW);
    if Parent = nil then
      Params.WndParent := Application.Handle;
  end;
end;

procedure TLMDDockPanel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  dwp: HDWP;
begin
  if HandleAllocated and (FZone <> nil) and (FZone.FTree.
     FDeferHandle <> 0) and ((ALeft <> Left) or (ATop <> 
     Top) or (AWidth <> Width) or (AHeight <> Height)) then
  begin
    dwp := DeferWindowPos(FZone.FTree.FDeferHandle, Handle,
                          0, ALeft, ATop, AWidth, AHeight,
                          SWP_NOZORDER + SWP_NOACTIVATE);
    FZone.FTree.FDeferHandle := dwp;
  end
  else
    inherited;
end;

procedure TLMDDockPanel.AdjustSize;
begin
  if not (csLoading in ComponentState) and HandleAllocated then
    RequestAlign;
end;

{ TZOrderer }

procedure TZOrderer.AddWindow(AWindow: TWinControl);
begin
  FWindows.Add(AWindow);
end;

constructor TZOrderer.Create;
begin
  inherited Create;
  FWindows := TList.Create;
end;

destructor TZOrderer.Destroy;
begin
  FWindows.Free;
  inherited;
end;

procedure TZOrderer.RemoveWindow(AWindow: TWinControl);
begin
  FWindows.Remove(AWindow);
end;

procedure TZOrderer.UpdateZOrder;

  procedure _DoPosition(AControl: TWinControl; var H: HWND);
  begin
    if AControl.HandleAllocated then
    begin
      SetWindowPos(AControl.Handle, H, 0, 0, 0, 0, SWP_NOMOVE or
                   SWP_NOSIZE or SWP_NOACTIVATE or SWP_NOOWNERZORDER);
      H := AControl.Handle;
    end;
  end;

var
  i:     Integer;
  h:     HWND;
//  frm:   TLMDFloatingForm;
  hspt:  THotSpot;
  drct:  TDockingRect;
//  ontop: Boolean;
begin
  h := HWND_TOPMOST;

  for i := 0 to FWindows.Count - 1 do
    if TWinControl(FWindows[i]) is THotSpot then
    begin
      hspt := THotSpot(FWindows[i]);
      _DoPosition(hspt, h);
    end;

  for i := 0 to FWindows.Count - 1 do
    if TWinControl(FWindows[i]) is TDockingRect then
    begin
      drct := TDockingRect(FWindows[i]);
      if drct.Accepted then
        _DoPosition(drct, h);
    end;

//  for i := 0 to FWindows.Count - 1 do
//    if TWinControl(FWindows[i]) is TLMDFloatingForm then
//    begin
//      frm := TLMDFloatingForm(FWindows[i]);
//      if frm.IsDragging then
//        _DoPosition(frm, h);
//    end;

  for i := 0 to FWindows.Count - 1 do
    if TWinControl(FWindows[i]) is TDockingRect then
    begin
      drct := TDockingRect(FWindows[i]);
      if not drct.Accepted then
        _DoPosition(drct, h);
    end;

  // For remaining (not dragging) floating forms we need adjust its
  // topmost state, ONLY if its currently invalid. Otherwise, we should
  // not change Z-order to prevent floating forms reordering relative
  // to each other as well as relative to other forms in application
  // (possible with topmost state as well).

//  for i := 0 to FWindows.Count - 1 do
//    if TWinControl(FWindows[i]) is TLMDFloatingForm then
//    begin
//      frm   := TLMDFloatingForm(FWindows[i]);
//      ontop := (frm.Site.Manager = nil) or frm.Site.Manager.StayFloatFormsOnTop;
//
//      if not frm.IsDragging and (frm.IsTopmost <> ontop) then
//      begin
//        if not ontop then
//          h := HWND_NOTOPMOST;
//        _DoPosition(frm, h);
//      end;
//    end;
end;

{ TAnimator }

function TAnimator.AdjustValue(V: Double; AKind: TAnimationKind): Double;
begin
  case AKind of
    akSqrt:   Result := Sqrt(V);
    akSquare: Result := V * V;
    akCubic:  Result := V * V * V;
  else
    Result := V;
  end;
end;

procedure TAnimator.Cancel(AId: Integer);
begin
  Remove(AId);
end;

constructor TAnimator.Create;
begin
  inherited Create;
  FNextId := 1; // No zero id.
end;

destructor TAnimator.Destroy;
begin
  FCount := 0;
  UpdateTimer; // Release FHWnd.
  inherited;
end;

function TAnimator.GetIsExists(AId: Integer): Boolean;
begin
  Result := (Find(AId) <> nil);
end;

function TAnimator.GetValue(AId: Integer): Double;
var
  itm: PAnimatorItem;
begin
  itm := Find(AId);

  if (itm <> nil) and (itm.Elapsed < itm.Duration) and
     (itm.Duration > 0) then
    Result := itm.Elapsed / itm.Duration
  else
    Result := 1; // If not exists, consider as finished too.
end;

function TAnimator.Find(AId: Integer): PAnimatorItem;
var
  i: Integer;
begin
  if AId <> -1 then
  begin
    for i := 0 to High(FItems) do
      if FItems[i].Id = AId then
      begin
        Result := @FItems[i];
        Exit;
      end;
  end;

  Result := nil;
end;

function TAnimator.RangedVal(AId, AFrom, ATo: Integer;
  AKind: TAnimationKind): Integer;
var
  val: Double;
begin
  val    := AdjustValue(Value[AId], AKind);
  Result := Round(ATo * val + AFrom * (1 - val));
end;

function TAnimator.RangedVal(AId: Integer; AFrom, ATo: Double;
  AKind: TAnimationKind): Double;
var
  val: Double;
begin
  val    := AdjustValue(Value[AId], AKind);
  Result := ATo * val + AFrom * (1 - val);
end;

function TAnimator.RangedVal(AId: Integer; AFrom, ATo: TRect;
  AKind: TAnimationKind): TRect;
var
  val: Double;
begin
  val           := AdjustValue(Value[AId], AKind);
  Result.Left   := Round(ATo.Left * val + AFrom.Left * (1 - val));
  Result.Top    := Round(ATo.Top * val + AFrom.Top * (1 - val));
  Result.Right  := Round(ATo.Right * val + AFrom.Right * (1 - val));
  Result.Bottom := Round(ATo.Bottom * val + AFrom.Bottom * (1 - val));
end;

function TAnimator.RangedVal(AId: Integer; AFrom, ATo: TPoint;
  AKind: TAnimationKind): TPoint;
var
  val: Double;
begin
  val      := AdjustValue(Value[AId], AKind);
  Result.X := Round(ATo.X * val + AFrom.X * (1 - val));
  Result.Y := Round(ATo.Y * val + AFrom.Y * (1 - val));
end;

procedure TAnimator.Remove(AId: Integer);
var
  itm: PAnimatorItem;
begin
  itm := Find(AId);

  if itm <> nil then
  begin
    itm.Id   := -1;
    itm.Proc := nil;

    Dec(FCount);
    UPdateTimer;
  end;
end;

procedure TAnimator.ReStart(ADuration: Integer;
  AProc: TAnimationProc; var AId: Integer);
var
  i:   Integer;
  itm: PAnimatorItem;
begin
  Remove(AId);
  itm := nil;

  for i := 0 to High(FItems) do
    if FItems[i].Id = -1 then
    begin
      itm := @FItems[i];
      Break;
    end;

  if itm = nil then
  begin
    SetLength(FItems, Length(FItems) + 1);
    itm := @FItems[High(FItems)];
  end;

  AId := FNextId;
  Inc(FNextId);

  itm.Id       := AId;
  itm.Proc     := AProc;
  itm.Duration := ADuration;
  itm.Elapsed  := 0;
  Inc(FCount);

  Step(itm);
  UpdateTimer;
end;

procedure TAnimator.Step(AItem: PAnimatorItem);
begin
  AItem.Proc(AItem.Id);
  if AItem.Elapsed >= AItem.Duration then
    Remove(AItem.Id);
end;

procedure TAnimator.UpdateTimer;
begin
  if FCount > 0 then
  begin
    if FHWnd = 0 then
    begin
      FHWnd := AllocateHWnd(WndProc);
      if SetTimer(FHWnd, 1, ANIMATOR_INTERVAL, nil) = 0 then
        raise EOutOfResources.Create(SNoTimers);
    end;
  end
  else if FHWnd <> 0 then
  begin
    DeallocateHWnd(FHWnd);
    FHWnd := 0;
  end;
end;

procedure TAnimator.WndProc(var Message: TMessage);
var
  i:   Integer;
  itm: PAnimatorItem;
begin
  if Message.Msg <> WM_TIMER then
  begin
    Message.Result := DefWindowProc(FHWnd, Message.Msg, Message.wParam,
                                    Message.lParam);
    Exit;
  end;

  try
    for i := 0 to High(FItems) do
    begin
      itm := @FItems[i];

      if (itm.Id <> -1) and Assigned(itm.Proc) then
      begin
        Inc(itm.Elapsed, ANIMATOR_INTERVAL);
        Step(itm);
      end;
    end;

    UpdateTimer;
  except
    Application.HandleException(Self);
  end;
end;

procedure TLMDDockPanel.SetDefaultColor(const Value: Boolean);
begin
  if FDefaultColor <> Value then
  begin
    if Value then
      ParentColor := False;
    FDefaultColor := Value;
    UpdateColors;
  end;
end;

procedure TLMDDockPanel.SetDefaultFontColor(const Value: Boolean);
begin
  if FDefaultFontColor <> Value then
  begin
    FDefaultFontColor := Value;
    UpdateColors;
  end;
end;

function TLMDDockPanel.IsColorStored: Boolean;
begin
  Result := not ParentColor and not DefaultColor;
end;

procedure TLMDDockPanel.CMParentColorChanged(var Message: TMessage);
begin
  if ParentColor then
    FDefaultColor := False;
  inherited;
end;

procedure TLMDDockPanel.CMParentFontChanged(var Message: TMessage);
var
  old: TMessage;
begin
  if ParentFont and FDefaultFontColor then
  begin
    Include(FState, psUpdatingParentFont);
    old            := Message;
    Message.LParam := LPARAM(TFont.Create);
    Message.WParam := 1;
    try
      if old.WParam <> 0 then
        TFont(Message.LParam).Assign(TFont(old.LParam))
      else
        TFont(Message.LParam).Assign(TControlAccess(Parent).Font);
      TFont(Message.LParam).Color := GetDefFontColor;

      inherited;
    finally
      TFont(Message.LParam).Free;
      Message := old;
      Exclude(FState, psUpdatingParentFont);
    end;
  end
  else
    inherited;
end;

procedure TLMDDockPanel.CMRelease(var Message: TMessage);
begin
  Free;
end;

procedure TLMDDockPanel.UpdateColors;
var
  site: TLMDDockSite;
  pe:   TLMDPanelElem;
begin
  Include(FState, psUpdatingColors);
  try
    site := FSite;
    if site = nil then
      site := FLoadingSite;

    if FDefaultColor then
    begin
      if site <> nil then
      begin
        pe    := site.StyleElems.Panel;
        Color := pe.DefaultColor;
      end
      else
        Color := clBtnFace;
    end;

    if ParentFont then
    begin
      if Parent <> nil then
        Perform(CM_PARENTFONTCHANGED, 0, 0); // Font color cannot be set
                                             // directly, because this will
                                             // reset ParentFont property.
    end
    else if FDefaultFontColor then
    begin
      if site <> nil then
        Font.Color := GetDefFontColor
      else
        Font.Color := clWindowText;
    end;
  finally
    Exclude(FState, psUpdatingColors);
  end;
end;

procedure TLMDDockPanel.Loaded;
begin
  inherited;
  UpdateColors;
end;

procedure TLMDDockPanel.CMColorChanged(var Message: TMessage);
begin
  if not (psUpdatingColors in FState) then
    FDefaultColor := False;
  inherited;
end;

procedure TLMDDockManager.SetScrollDocTabs(const Value: Boolean);
begin
  if FScrollDocTabs <> Value then
  begin
    FScrollDocTabs := Value;
    UpdateSites;
  end;
end;

procedure TLMDDockManager.SetFloatFormButtons(const Value: TLMDPanelBtnKinds);
begin
  if FFloatFormButtons <> Value then
  begin
    FFloatFormButtons := Value;
    UpdateSites;
  end;
end;

procedure TLMDDockManager.SetStayFloatFormsOnTop(const Value: Boolean);
begin
  if FStayFloatFormsOnTop <> Value then
  begin
    FStayFloatFormsOnTop := Value;
    ZOrderer.UpdateZOrder;
  end;
end;

procedure TLMDDockManager.SetStyle(const Value: TLMDDockStyle);
begin
  if FStyle <> Value then
  begin
    FStyle           := Value;
    FDockElems.Style := Value;
  end;
end;

procedure TLMDDockManager.SetStyleName(const Value: TLMDStyleName);
var
  st: TLMDDockStyle;
begin
  if Value <> '' then
    st := DockStyles.GetByName(Value)
  else
    st := nil;
  SetStyle(st);
end;

procedure TLMDDockManager.SetUseTabbedDocs(const Value: Boolean);
begin
  if FUseTabbedDocs <> Value then
  begin
    FUseTabbedDocs := Value;
    UpdateSites;
  end;
end;

{ TLMDFloatingForm.TStyleHook }

{$IFDEF LMDCOMP16}
procedure TLMDFloatingForm.TStyleHook.WMNCHitTest(var Message: TWMNCHitTest);
begin
  if Form.BorderStyle = bsNone then
    Handled := False
  else
    inherited;
end;
{$ENDIF}

{$IFDEF LMDCOMP16}
procedure TLMDFloatingForm.TStyleHook.WMWindowPosChanging(
  var Message: TWMWindowPosChanging);
begin
  inherited;
  TFormStyleHack(Self).FChangeSizeCalled := False;
end;
{$ENDIF}

{ TManagerElems }

procedure TManagerElems.Changed(AChanges: TLMDElemSetChanges);
begin
  if FManager <> nil then
    FManager.UpdateSites;
end;

constructor TManagerElems.Create(AManager: TLMDDockManager);
begin
  inherited Create;
  FManager := AManager;
end;

{ TTabMenuItem }

procedure TTabMenuItem.Click;
var
  tb: ^TLMDZoneTabInfo;
  zn:  TLMDDockZone;
begin
  tb := @FTabZone.FTabs[FIndex];
  zn := tb.Zone;

  if zn <> nil then
  begin
    if IsRectEmpty(tb.Bounds) then
      zn.Index := 0;
    if zn.Panel <> nil then
      zn.Panel.Show
    else
      FTabZone.SelectedPage := zn; // For sure.
  end;
end;

constructor TTabMenuItem.Create(AOwner: TComponent; ATabZone: TLMDDockZone;
  AIndex: Integer);
begin
  inherited Create(AOwner);
  FTabZone := ATabZone;
  FIndex   := AIndex;
  Caption  := FTabZone.GetTabCaption(FTabZone.Tabs[FIndex].Zone);
  Checked  := (FTabZone.FSelectedPage = FTabZone.Tabs[FIndex].Zone);
end;

{ TGlow }

procedure TGlow.WMMouseActivate(var M: TWMMouseActivate);
begin
  inherited;
  M.Result := MA_NOACTIVATE;
end;

constructor TGlow.Create(AForm: TLMDFloatingForm; ASide: TAlign);
begin
  inherited Create(AForm);

  FForm        := AForm;
  FSide        := ASide;
  FBitmap      := TBitmap.Create;
  ControlStyle := ControlStyle + [csOpaque];
  Visible      := False;

  Update(False);
end;

procedure TGlow.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style   := WS_POPUP;
  Params.ExStyle := WS_EX_LAYERED;
end;

destructor TGlow.Destroy;
begin
  FBitmap.Free;
  FResizer.Free;
  inherited;
end;

function TGlow.GetBounds: TRect;
var
  r:  TRect;
  mr: TLMDMargins;
begin
  mr := FForm.StyleElems.GetForm(FForm.FKind).GlowContent;
  r  := FForm.BoundsRect;

  case FSide of
    alTop:    begin
                r.Bottom := r.Top;
                r.Top    := r.Bottom - mr.Top;
                r.Left   := r.Left - mr.Left;
                r.Right  := r.Right + mr.Right;
              end;
    alBottom: begin
                r.Top    := r.Bottom;
                r.Bottom := r.Top + mr.Bottom;
                r.Left   := r.Left - mr.Left;
                r.Right  := r.Right + mr.Right;
              end;
    alLeft:   begin
                r.Right  := r.Left;
                r.Left   := r.Right - mr.Left;
              end;
    alRight:  begin
                r.Left   := r.Right;
                r.Right  := r.Left + mr.Right;
              end;
  else
    Assert(False);
  end;

  Result := r;
end;

function TGlow.GetResizeKind(const P: TPoint): TResizeKind;
type
  THorzSize = (hsLeft, hsCenter, hsRight);
const
  rkNone = TResizeKind(-1);

  RES_KINDS: array[TAlign, THorzSize] of TResizeKind = (
    (rkNone, rkNone, rkNone),                 // alNone
    (rkTopLeft, rkTop, rkTopRight),           // alTop
    (rkBottomLeft, rkBottom, rkBottomRight),  // alBottom
    (rkLeft, rkLeft, rkLeft),                 // alLeft
    (rkRight, rkRight, rkRight),              // alRight
    (rkNone, rkNone, rkNone),                 // alClient
    (rkNone, rkNone, rkNone)                  // alCustom
  );
var
  hs:    THorzSize;
  bwdth: Integer;
begin
  bwdth := FBounds.Right - FBounds.Left;
  if (P.X < 16) and (bwdth > 32) then
    hs := hsLeft
  else if (P.X > bwdth - 16) and
          (bwdth > 32) then
    hs := hsRight
  else
    hs := hsCenter;

  Result := RES_KINDS[FSide, hs];
  Assert(Result <> rkNone);
end;

procedure TGlow.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if FResizer <> nil then
    FResizer.Free;
  FResizer := TResizer.Create(FForm, GetResizeKind(Point(X, Y)));
end;

procedure TGlow.Paint;
begin
  // Do nothing.
end;

procedure TGlow.Update(AForceRedraw: Boolean);
const
  SWP_FLAGS: array[Boolean] of Integer = (
    SWP_HIDEWINDOW,
    SWP_SHOWWINDOW or SWP_NOACTIVATE or
    SWP_NOSIZE or SWP_NOMOVE or
    SWP_NOZORDER or SWP_NOOWNERZORDER
  );
var
  show: Boolean;
  bf:   BLENDFUNCTION;
  spos: TPoint;
  dpos: TPoint;
  sz:   TPoint;
  ff:   TLMDFloatFrameBase;
  bwd:  Integer;
  bhg:  Integer;
begin
  FBounds := GetBounds; // UpdateLayeredWindow does not updates Delphi
                        // TControl.BoundsRect, so, Width/Height/ect will
                        // be zero.

  ff   := FForm.StyleElems.GetForm(FForm.FKind);
  bwd  := FBounds.Right - FBounds.Left;
  bhg  := FBounds.Bottom - FBounds.Top;
  show := FForm.Visible and FForm.HandleAllocated and
          (FForm.WindowState <> wsMinimized) and
          (ff.BorderKind = fbCustom) and (bwd > 0) and (bhg > 0);

  if (FBitmap.Width <> bwd) or (FBitmap.Height <> bhg) or
     AForceRedraw then
  begin
    FBitmapActv         := FForm.Active;
    FBitmap.Width       := bwd;
    FBitmap.Height      := bhg;
    FBitmap.PixelFormat := pf32bit;

    UpdateBitmap;
  end;

  ParentWindow := FForm.Handle;
  SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_FLAGS[show]);

  if show then
  begin
    bf.BlendOp             := AC_SRC_OVER;
    bf.BlendFlags          := 0;
    bf.SourceConstantAlpha := 255;
    bf.AlphaFormat         := AC_SRC_ALPHA;
    spos                   := Point(0, 0);

    dpos := FBounds.TopLeft;
    sz   := Point(bwd, bhg);

    if not UpdateLayeredWindow(Handle, 0, @dpos, @sz,
                               FBitmap.Canvas.Handle,
                               @spos, 0, @bf, ULW_ALPHA) then
      RaiseLastOSError;
  end;
end;

procedure TGlow.UpdateBitmap;
var
  ff:         TLMDFloatFrameBase;
  actv:       Boolean;
  cr, r:      TRect;
  c:          TCanvas;
  xoff, yoff: Integer;
begin
  c  := FBitmap.Canvas;
  cr := Rect(0, 0, FBitmap.Width, FBitmap.Height);

  c.Brush.Color := clBlack; // Make fully
  c.FillRect(cr);           // transparent.

  actv := FForm.Active;
  ff   := FForm.StyleElems.GetForm(FForm.FKind);
  r    := ff.GlowContent.UnadjustRect(FForm.BoundsRect);

  case FSide of
    alTop:    begin
                xoff := r.Left;
                yoff := r.Top;
              end;
    alBottom: begin
                xoff := r.Left;
                yoff := r.Bottom - cr.Bottom;
              end;
    alLeft:   begin
                xoff := r.Left;
                yoff := r.Top + ff.GlowContent.Top;
              end;
    alRight:  begin
                xoff := r.Right - cr.Right;
                yoff := r.Top + ff.GlowContent.Top;
              end;
  else
    Assert(False);
    xoff := 0; // Initialize.
    yoff := 0; //
  end;

  OffsetRect(r, -xoff, -yoff);
  ff.GetGlow(actv).Draw(c, r);
end;

procedure TGlow.WMEraseBkgnd(var M: TWmEraseBkgnd);
begin
  M.Result := 0;
end;

procedure TGlow.WMSetCursor(var M: TWMSetCursor);
const
  CURSORS: array[TResizeKind] of TCursor = (
    crSizeWE,   // rkLeft
    crSizeNWSE, // rkTopLeft
    crSizeNS,   // rkTop
    crSizeNESW, // rkTopRight
    crSizeWE,   // rkRight
    crSizeNESW, // rkBottomLeft
    crSizeNS,   // rkBottom
    crSizeNWSE  // rkBottomRight
  );
var
  p: TPoint;
  hc: HCURSOR;
begin
  p  := ScreenToClient(Mouse.CursorPos);
  hc := Screen.Cursors[CURSORS[GetResizeKind(p)]];
  SetCursor(hc);
end;

{ TResizer }

constructor TResizer.Create(AForm: TLMDFloatingForm; AKind: TResizeKind);
begin
  inherited Create;
  FForm := AForm;
  FKind := AKind;
  FWnd  := AllocateHWnd(WndProc);
  Init;
end;

destructor TResizer.Destroy;
begin
  DeallocateHWnd(FWnd);
  inherited;
end;

procedure TResizer.DoResize;
var
  bnds:     TRect;
  off:      TPoint;
  mmnfo:    MINMAXINFO;
  bwd, bhg: Integer;
begin
  bnds := FStartBounds;
  off  := Point(Mouse.CursorPos.X - FStartDrag.X,
                Mouse.CursorPos.Y - FStartDrag.Y);

  case FKind of
    rkLeft:         Inc(bnds.Left, off.X);
    rkTopLeft:      begin
                      Inc(bnds.Left, off.X);
                      Inc(bnds.Top, off.Y);
                    end;
    rkTop:          Inc(bnds.Top, off.Y);
    rkTopRight:     begin
                      Inc(bnds.Right, off.X);
                      Inc(bnds.Top, off.Y);
                    end;
    rkRight:        Inc(bnds.Right, off.X);
    rkBottomLeft:   begin
                      Inc(bnds.Left, off.X);
                      Inc(bnds.Bottom, off.Y);
                    end;
    rkBottom:       Inc(bnds.Bottom, off.Y);
    rkBottomRight:  begin
                      Inc(bnds.Right, off.X);
                      Inc(bnds.Bottom, off.Y);
                    end;
  end;

  FillChar(mmnfo, SizeOf(mmnfo), 0);
  SendMessage(FForm.Handle, WM_GETMINMAXINFO, 0, LPARAM(@mmnfo));

  bwd := bnds.Right - bnds.Left;
  bhg := bnds.Bottom - bnds.Top;

  if bwd < mmnfo.ptMinTrackSize.X then
  begin
    case FKind of
      rkTopLeft, rkLeft,
      rkBottomLeft:
        Dec(bnds.Left, mmnfo.ptMinTrackSize.X - bwd);
      rkTopRight, rkRight,
      rkBottomRight:
        Inc(bnds.Right, mmnfo.ptMinTrackSize.X - bwd);
    end;
  end;

  if bhg < mmnfo.ptMinTrackSize.Y then
  begin
    case FKind of
      rkTopLeft, rkTop,
      rkTopRight:
        Dec(bnds.Top, mmnfo.ptMinTrackSize.Y - bhg);
      rkBottomLeft, rkBottom,
      rkBottomRight:
        Inc(bnds.Bottom, mmnfo.ptMinTrackSize.Y - bhg);
    end;
  end;

  SetWindowPos(FForm.Handle, 0, bnds.Left, bnds.Top,
               bnds.Right - bnds.Left, bnds.Bottom - bnds.Top,
               SWP_NOACTIVATE or SWP_NOZORDER);
  UpdateWindow(FForm.Handle);
end;

procedure TResizer.Init;
begin
  FStartDrag   := Mouse.CursorPos;
  FStartBounds := FForm.BoundsRect;
  SetCapture(FWnd);
end;

procedure TResizer.WndProc(var M: TMessage);
begin
  try
    case M.Msg of
      WM_MOUSEMOVE:   begin
                        if not FFinished then
                          DoResize;
                      end;
      WM_CANCELMODE,
      WM_LBUTTONUP,
      WM_RBUTTONUP:   begin
                        if GetCapture = FWnd then
                          ReleaseCapture;
                        FFinished := True;
                      end;
    end;

    M.Result := DefWindowProc(FWnd, M.Msg, M.WParam, M.LParam);
  except
    Application.HandleException(Self);
  end;
end;

initialization
  ZOrderer := TZOrderer.Create;
  Animator := TAnimator.Create;

  {$IFDEF LMDCOMP16}
  TStyleManager.Engine.RegisterStyleHook(TLMDFloatingForm, TLMDFloatingForm.
                                         TStyleHook);
  {$ENDIF}

  {$IFDEF LMD_DEBUGTRACE}
    {$I C1.INC}
  {$ENDIF}

finalization
  {$IFDEF LMDCOMP16}
  TStyleManager.Engine.UnRegisterStyleHook(TLMDFloatingForm, TLMDFloatingForm.
                                           TStyleHook);
  {$ENDIF}

  ZOrderer.Free;
  Animator.Free;
  DefDockElems.Free;

end.

