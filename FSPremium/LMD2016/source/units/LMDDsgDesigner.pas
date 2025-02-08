unit LMDDsgDesigner;
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

LMDDsgDesigner unit (YB)
------------------------
TLMDDesigner and TLMDDesignPanel unit

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, Messages, SysUtils, Consts, Forms, Windows, Graphics,
  ExtCtrls, StdCtrls, Menus, Clipbrd, ImgList, Dialogs, RTLConsts, Themes,
  intfLMDBase, LMDUnicode, LMDTypes, LMDXML, LMDSvcPvdr, LMDUnicodeControl,
  LMDInsEditorWnds, LMDInsEditorUtils, LMDDsgClass, LMDDsgCst, LMDDsgObjects,
  LMDDsgModule;

type
  { ************************ TLMDCustomDesignPanel *************************** }

  TLMDCustomDesignPanel = class(TWinControl, ILMDComponent)
  private
    FAbout:       TLMDAboutVar;
    FEng:         TObject;
    FBorderStyle: TBorderStyle;
    FForm:        TCustomForm;
    FScrollCtrl:  TControl;

    procedure SetEng(AEng: TObject);
    procedure SetBorderStyle(const Value: TBorderStyle);
    function  GetIsUsed: Boolean;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMRButtonDown(var Message: TWMLButtonDown); message WM_RBUTTONDOWN;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMCursorChanged(var Message: TMessage); message CM_CURSORCHANGED;
    procedure CMBiDiModeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMParentBiDiModeChanged(var Message: TMessage); message CM_PARENTBIDIMODECHANGED;
    procedure CMParentColorChanged(var Message: TMessage); message CM_PARENTCOLORCHANGED;
    procedure CMParentFontChanged(var Message: TMessage); message CM_PARENTFONTCHANGED;
    procedure CMParentShowHintChanged(var Message: TMessage); message CM_PARENTSHOWHINTCHANGED;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    function  GetAutoScroll: Boolean;
    procedure SetAutoScroll(const Value: Boolean);
    function  GetHorzScrollBar: TControlScrollBar;
    procedure SetHorzScrollBar(const Value: TControlScrollBar);
    function  GetVertScrollBar: TControlScrollBar;
    procedure SetVertScrollBar(const Value: TControlScrollBar);
    procedure UpdateFormParentWindow;
    procedure UpdateFormBounds;
    procedure UpdateEngFocus;
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DestroyWnd; override;
    procedure CreateHandle; override;
    function  GetPopupMenu: TPopupMenu; override;
    procedure RootBoundsChanged;
    property  IsUsed: Boolean read GetIsUsed;
    property  Form: TCustomForm read FForm;
    property  BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property  AutoScroll: Boolean read GetAutoScroll write SetAutoScroll;
    property  HorzScrollBar: TControlScrollBar read GetHorzScrollBar write SetHorzScrollBar;
    property  VertScrollBar: TControlScrollBar read GetVertScrollBar write SetVertScrollBar;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property  TabStop default True;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
  end;

  { *************************** TLMDDesignPanel ****************************** }

  TLMDDesignPanel = class(TLMDCustomDesignPanel)
  public
    property IsUsed;
    property Form;
  published
    property BorderStyle;
    property AutoScroll;
    property HorzScrollBar;
    property VertScrollBar;
    property BiDiMode;
    property Align;
    property Anchors;
    property Color;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
  end;

  { ************************* TLMDCustomDesigner ***************************** }

  TLMDCustomDesigner = class;
  ELMDDesigner       = class(Exception);

  TLMDDesignerLockModeItem = (lmNoMove, lmNoResize, lmNoDelete,
                              lmNoInsertIn, lmNoCopy, lmCustom1, lmCustom2,
                              lmCustom3, lmCustom4, lmCustom5, lmCustom6,
                              lmCustom7, lmCustom8);
  TLMDDesignerLockMode = set of TLMDDesignerLockModeItem;
  TLMDDesignerAlignType = (atNoChanges, atLeftTop, atRightBottom,
                           atSpaceEqually, atCenter, atCenterInWindow);

  TLMDDesignerGridSize = 2..32;

  { ************************** TLMDDesignerGrid ****************************** }

  TLMDDesignerGrid = class(TPersistent)
  private
    FDesigner: TLMDCustomDesigner;
    FVisible : Boolean;
    FYStep   : TLMDDesignerGridSize;
    FXStep   : TLMDDesignerGridSize;
    FColor   : TColor;
    procedure SetVisible(const Value: Boolean);
    procedure SetXStep(const Value: TLMDDesignerGridSize);
    procedure SetYStep(const Value: TLMDDesignerGridSize);
    procedure SetColor(const Value: TColor);
  public
    constructor Create(AOwnerDesigner: TLMDCustomDesigner);
    procedure   Assign(Source: TPersistent); override;
  published
    property XStep: TLMDDesignerGridSize read FXStep write SetXStep default 8;
    property YStep: TLMDDesignerGridSize read FYStep write SetYStep default 8;
    property Visible: Boolean read FVisible write SetVisible default True;
    property Color: TColor read FColor write SetColor default clBlack;
  end;

  { ********************* TLMDDesignerHiddenClasses ************************** }

  TLMDDesignerHiddenClasses = class
  private
    FDesigner      : TLMDCustomDesigner;
    FItems         : TList;
    FUpdateCount   : Integer;
    FChanged       : Boolean;

    function  GetCount: Integer;
    function  GetItems(I: Integer): TComponentClass;
    procedure Changed;
  protected
    procedure DoChange; virtual;
  public
    constructor Create(AOwnerDesigner: TLMDCustomDesigner);
    destructor Destroy; override;

    function  Add(AClass: TComponentClass): Integer;
    function  IndexOf(AClass: TComponentClass): Integer;
    procedure Delete(AI: Integer);
    procedure Remove(AClass: TComponentClass);
    procedure GetClasses(AResult: TList); 
    procedure SetClasses(AClasses: TList);
    procedure Clear;
    procedure BeginUpdate;
    procedure EndUpdate;
    property  Items[I: Integer]: TComponentClass read GetItems; default;
    property  Count: Integer read GetCount;
  end;

  TLMDDesignerHint           = (dhComponent, dhSize, dhMove, dhInsert);
  TLMDDesignerHints          = set of TLMDDesignerHint;
  TLMDDesignerMenuOptions    = set of (dmoAddDefaultItems, dmoAddCompEditorItems);
  TLMDDesignerServiceOptions = set of (dsoUseCompInsertionService,
                                       dsoUseCompImageService,
                                       dsoUseObjEditService);
  
  TLMDDesignerOnComponentInsertingEvent = procedure(Sender: TObject;
    var AComponentClass: TComponentClass) of object;

  TLMDDesignerOnComponentHintEvent = procedure(Sender: TObject;
    AComponent: TComponent; var AHint: TLMDString) of object;

  TLMDDesignerOnNotificationEvent = procedure(Sender: TObject;
    AnObject: TPersistent; Operation: TOperation) of object;

  TLMDDesignerOnGetImageIndex = procedure(Sender: TObject;
    AComponentClass: TComponentClass; var AImageIndex: Integer) of object;

  TLMDDesignerOnGetTransparence = procedure(Sender: TObject;
    AControl: TControl; var ATransparent: Boolean) of object;

  TLMDDesignerOnShowNonvisualComponent = procedure(Sender: TObject;
    AComponent: TComponent; var AShowComponent: Boolean) of object;

  { ************************* TLMDCustomDesigner ***************************** }

  TLMDCustomDesigner = class(TComponent, ILMDComponent)
  private
    FAbout                     : TLMDAboutVar;
    FEng                       : TObject;
    FServiceProvider           : TLMDServiceProvider;
    FServiceOptions            : TLMDDesignerServiceOptions;
    FModule                    : TLMDModule;
    FModuleNotifier            : ILMDModuleNotifier;
    FSnapToGrid                : Boolean;
    FShowAlignLines            : Boolean;
    FActive                    : Boolean;
    FOnComponentInserted       : TNotifyEvent;
    FOnComponentInserting      : TLMDDesignerOnComponentInsertingEvent;
    FGrid                      : TLMDDesignerGrid;
    FSelection                 : TLMDDesignObjects;
    FSelnNotifier              : TObject;
    FAllComponents             : TLMDDesignObjects;
    FDesignPanel               : TLMDCustomDesignPanel;
    FOnChange                  : TNotifyEvent;
    FOnComponentHint           : TLMDDesignerOnComponentHintEvent;
    FHints                     : TLMDDesignerHints;
    FTempMenu                  : TPopupMenu;
    FOnDesignFormClose         : TCloseEvent;
    FPopupMenu                 : TPopupMenu;
    FOnContextPopup            : TContextPopupEvent;
    FHandleClr                 : TColor;
    FMultySelectHandleClr      : TColor;
    FHandleBorderClr           : TColor;
    FInactiveHandleClr         : TColor;
    FInactiveHandleBorderClr   : TColor;
    FLockedHandleClr           : TColor;
    FMultySelectHandleBorderClr: TColor;
    FClipboardFormat           : TLMDString;
    FClipbrdFormatRegistered   : Boolean;
    FClipboardFormatWord       : Word;
    FOnKeyUp                   : TKeyEvent;
    FOnKeyDown                 : TKeyEvent;
    FOnKeyPress                : TKeyPressEvent;
    FOnNotification            : TLMDDesignerOnNotificationEvent;
    FOnDblClick                : TNotifyEvent;
    FOnDragDrop                : TDragDropEvent;
    FOnDragOver                : TDragOverEvent;
    FComponentContextPopup     : Boolean;
    FOnMouseUp                 : TMouseEvent;
    FOnMouseDown               : TMouseEvent;
    FOnMouseMove               : TMouseMoveEvent;
    FOnMouseWheel              : TMouseWheelEvent;
    FOnMouseWheelUp            : TMouseWheelUpDownEvent;
    FOnMouseWheelDown          : TMouseWheelUpDownEvent;
    FWheelAccumulator          : Integer;
    FOnClick                   : TNotifyEvent;
    FShowNonvisualComponents   : Boolean;
    FShowComponentCaptions     : Boolean;
    FComponentCaptionsFont     : TFont;
    FOnGetTransparence         : TLMDDesignerOnGetTransparence;
    FOnGetImageIndex           : TLMDDesignerOnGetImageIndex;
    FNonvisualComponentImages  : TImageList;
    FNonvisualCompImagesChangeLink : TChangeLink;
    FHiddenClasses             : TLMDDesignerHiddenClasses;
    FOnShowNonvisualComponent  : TLMDDesignerOnShowNonvisualComponent;
    FNonvisualComponentWidth   : Integer;
    FNonvisualComponentHeight  : Integer;
    FExcludeRoot               : Boolean;
    FMenuOptions               : TLMDDesignerMenuOptions;
    FEditorWindows             : TLMDEditorWindowManager;
    FEditorUtils               : TLMDEditorUtils;
    FShowRootResizers          : Boolean;

    procedure GridParamsChanged;
    procedure RegisterClipboardFormat;
    procedure ContextPopup(AMousePos: TPoint);
    procedure ClearTempMenuItems(AMenu: TPopupMenu);
    procedure AddDefaultMenuItems(AMenu: TPopupMenu);
    function  DoKeyDown(var AMessage: TWMKey): Boolean;
    function  DoKeyPress(var AMessage: TWMKey): Boolean;
    function  DoKeyUp(var AMessage: TWMKey): Boolean;
    procedure CompsChangeNotification(Sender: TObject; AChangedComps: TList);
    procedure SetActive(const Value: Boolean);
    procedure SetSelection(const Value: TLMDDesignObjects);
    procedure SetAllComponents(const Value: TLMDDesignObjects);
    procedure SetExcludeRoot(const Value: Boolean);
    procedure SetModule(const Value: TLMDModule);
    procedure SetDesignPanel(const Value: TLMDCustomDesignPanel);
    function  GetRootVisible: Boolean;
    procedure SetRootVisible(const Value: Boolean);
    procedure SetPopupMenu(const Value: TPopupMenu);
    procedure SetHandleBorderClr(const Value: TColor);
    procedure SetHandleClr(const Value: TColor);
    procedure SetInactiveHandleBorderClr(const Value: TColor);
    procedure SetInactiveHandleClr(const Value: TColor);
    procedure SetLockedHandleClr(const Value: TColor);
    procedure SetMultySelectHandleBorderClr(const Value: TColor);
    procedure SetMultySelectHandleClr(const Value: TColor);
    procedure SetClipboardFormat(const Value: TLMDString);
    procedure SetGrid(const Value: TLMDDesignerGrid);
    function  GetFocused: Boolean;
    function  IsDefaultFormat:Boolean;
    procedure SetShowNonvisualComponents(const Value: Boolean);
    procedure SetShowComponentCaptions(const Value: Boolean);
    procedure SetComponentCaptionsFont(const Value: TFont);
    procedure SetNonvisualComponentImages(const Value: TImageList);
    procedure SetNonvisualComponentWidth(const Value: Integer);
    procedure SetNonvisualComponentHeight(const Value: Integer);
    procedure HiddenClassesChanged;
    function  IsComponentHidden(AComponent: TComponent): Boolean;
    procedure NonvisualCompImagesChange(Sender: TObject);
    procedure DoSaveLocks(AParent: ILMDXmlElement; AOwner: TComponent);
    procedure DoLoadLocks(AParent: ILMDXmlElement; AOwner: TComponent);
    function  HasLockedChildren(AOwner: TComponent): Boolean;
    procedure SetServiceProvider(const Value: TLMDServiceProvider);
    procedure SetShowRootResizers(const Value: Boolean);
    procedure SetServiceOptions(const Value: TLMDDesignerServiceOptions);
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    procedure CheckActive(AIsActiveNeeded: Boolean);
    function  GetPopupMenu: TPopupMenu; dynamic;
    procedure DoChange; virtual;
    procedure ComponentInserting(var AComponentClass: TComponentClass); virtual;
    procedure ComponentInserted; virtual;
    procedure DoNotification(AnObject: TPersistent; Operation: TOperation); virtual;
    procedure DoFocus; virtual;
    procedure DoComponentHint(AComponent: TComponent; var AHint: TLMDString); virtual;
    procedure DoContextPopup(AMousePos: TPoint; var AHandled: Boolean); dynamic;
    procedure DesignFormClose(var Action: TCloseAction); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); virtual;
    procedure KeyPress(var Key: Char); virtual;
    procedure KeyUp(var Key: Word; Shift: TShiftState); virtual;
    procedure MouseDown(AButton: TMouseButton; AShift: TShiftState; AX, AY: Integer); dynamic;
    procedure MouseMove(AShift: TShiftState; AX, AY: Integer); dynamic;
    procedure MouseUp(AButton: TMouseButton; AShift: TShiftState; AX, AY: Integer); dynamic;
    function  DoMouseWheel(AShift: TShiftState; AWheelDelta: Integer; AMousePos: TPoint): Boolean; dynamic;
    function  DoMouseWheelDown(AShift: TShiftState; AMousePos: TPoint): Boolean; dynamic;
    function  DoMouseWheelUp(AShift: TShiftState; AMousePos: TPoint): Boolean; dynamic;
    procedure DblClick; virtual;
    procedure Click; virtual;
    procedure DragOver(ASource: TObject; AX, AY: Integer; AState: TDragState; var AAccept: Boolean); dynamic;
    function  DoGetTransparence(AControl: TControl): Boolean; virtual;
    procedure DoGetImageParams(AComponentClass: TComponentClass;
                               var AImageList: TImageList;
                               var AImageIndex: Integer); virtual;
    procedure DoShowNonvisualComponent(AComponent: TComponent;
                                       var AShowComponent: Boolean); virtual;
    property  ServiceProvider: TLMDServiceProvider read FServiceProvider write SetServiceProvider;
    property  ServiceOptions: TLMDDesignerServiceOptions read FServiceOptions write SetServiceOptions
                  default [dsoUseCompInsertionService, dsoUseCompImageService, dsoUseObjEditService];
    property  WheelAccumulator: Integer read FWheelAccumulator write FWheelAccumulator;
    property  Active: Boolean read FActive write SetActive;
    property  Focused: Boolean read GetFocused;
    property  Module: TLMDModule read FModule write SetModule;
    property  Selection: TLMDDesignObjects read FSelection write SetSelection;
    property  AllComponents: TLMDDesignObjects read FAllComponents write SetAllComponents;
    property  EditorWindows: TLMDEditorWindowManager read FEditorWindows;
    property  ExcludeRoot: Boolean read FExcludeRoot write SetExcludeRoot default False;
    property  RootVisible: Boolean read GetRootVisible write SetRootVisible;
    property  DesignPanel: TLMDCustomDesignPanel read FDesignPanel write SetDesignPanel;
    property  Grid: TLMDDesignerGrid read FGrid write SetGrid;
    property  SnapToGrid: Boolean read FSnapToGrid write FSnapToGrid default True;
    property  ShowAlignLines: Boolean read FShowAlignLines write FShowAlignLines default True;
    property  Hints: TLMDDesignerHints read FHints write FHints default [dhComponent, dhSize, dhMove, dhInsert];
    property  PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
    property  HandleColor: TColor read FHandleClr write SetHandleClr default clBlack;
    property  HandleBorderColor: TColor read FHandleBorderClr write SetHandleBorderClr default clBlack;
    property  MultiSelectHandleColor: TColor read FMultySelectHandleClr write SetMultySelectHandleClr default clGray;
    property  MultiSelectHandleBorderColor: TColor read FMultySelectHandleBorderClr write SetMultySelectHandleBorderClr default clGray;
    property  InactiveHandleColor: TColor read FInactiveHandleClr write SetInactiveHandleClr default clGray;
    property  InactiveHandleBorderColor: TColor read FInactiveHandleBorderClr write SetInactiveHandleBorderClr default clBlack;
    property  LockedHandleColor: TColor read FLockedHandleClr write SetLockedHandleClr default clRed;
    property  ClipboardFormat: TLMDString read FClipboardFormat write SetClipboardFormat stored IsDefaultFormat;
    property  ComponentContextPopup: Boolean read FComponentContextPopup write FComponentContextPopup default True;
    property  ShowNonvisualComponents: Boolean read FShowNonvisualComponents write SetShowNonvisualComponents default False;
    property  ShowComponentCaptions: Boolean read FShowComponentCaptions write SetShowComponentCaptions default False;
    property  ComponentCaptionsFont: TFont read FComponentCaptionsFont write SetComponentCaptionsFont; 
    property  NonvisualComponentImages: TImageList read FNonvisualComponentImages write SetNonvisualComponentImages;
    property  NonvisualComponentWidth: Integer read FNonvisualComponentWidth write SetNonvisualComponentWidth default 28;
    property  NonvisualComponentHeight: Integer read FNonvisualComponentHeight write SetNonvisualComponentHeight default 28;
    property  HiddenClasses: TLMDDesignerHiddenClasses read FHiddenClasses;
    property  MenuOptions: TLMDDesignerMenuOptions read FMenuOptions write FMenuOptions default [dmoAddCompEditorItems];
    property  ShowRootResizers: Boolean read FShowRootResizers write SetShowRootResizers default False;
    property  OnChange: TNotifyEvent read FOnChange write FOnChange;
    property  OnComponentInserting: TLMDDesignerOnComponentInsertingEvent read FOnComponentInserting write FOnComponentInserting;
    property  OnComponentInserted: TNotifyEvent read FOnComponentInserted write FOnComponentInserted;
    property  OnNotification: TLMDDesignerOnNotificationEvent read FOnNotification write FOnNotification;
    property  OnComponentHint: TLMDDesignerOnComponentHintEvent read FOnComponentHint write FOnComponentHint;
    property  OnDesignFormClose: TCloseEvent read FOnDesignFormClose write FOnDesignFormClose;
    property  OnGetTransparence: TLMDDesignerOnGetTransparence read FOnGetTransparence write FOnGetTransparence;
    property  OnGetImageIndex: TLMDDesignerOnGetImageIndex read FOnGetImageIndex write FOnGetImageIndex;
    property  OnShowNonvisualComponent: TLMDDesignerOnShowNonvisualComponent read FOnShowNonvisualComponent write FOnShowNonvisualComponent;
    property  OnContextPopup: TContextPopupEvent read FOnContextPopup write FOnContextPopup;
    property  OnKeyDown: TKeyEvent read FOnKeyDown write FOnKeyDown;
    property  OnKeyPress: TKeyPressEvent read FOnKeyPress write FOnKeyPress;
    property  OnKeyUp: TKeyEvent read FOnKeyUp write FOnKeyUp;
    property  OnMouseDown: TMouseEvent read FOnMouseDown write FOnMouseDown;
    property  OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property  OnMouseUp: TMouseEvent read FOnMouseUp write FOnMouseUp;
    property  OnMouseWheel: TMouseWheelEvent read FOnMouseWheel write FOnMouseWheel;
    property  OnMouseWheelDown: TMouseWheelUpDownEvent read FOnMouseWheelDown write FOnMouseWheelDown;
    property  OnMouseWheelUp: TMouseWheelUpDownEvent read FOnMouseWheelUp write FOnMouseWheelUp;
    property  OnClick: TNotifyEvent read FOnClick write FOnClick;
    property  OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property  OnDragDrop: TDragDropEvent read FOnDragDrop write FOnDragDrop;
    property  OnDragOver: TDragOverEvent read FOnDragOver write FOnDragOver;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure DragDrop(ASource: TObject; AX, AY: Integer); dynamic;
    function  ComponentAtPos(const APos: TPoint): TComponent;
    function  CanFocus: Boolean;
    procedure SetFocus;

    function  IsDesignComponent(AComponent: TComponent): Boolean;
    procedure GetComponentPosition(AComponent: TComponent; var ALeft, ATop: Integer);
    procedure SetComponentPosition(AComponent: TComponent; ALeft, ATop: Integer);
    procedure CancelMode;
    procedure UpdateComponent(AIndex: Integer);
    procedure SelectAll;
    procedure DeleteSelectedComponents;

    procedure LockComponent(AComponent: TComponent; ALockMode: TLMDDesignerLockMode);
    procedure LockAll(ALockMode: TLMDDesignerLockMode);
    function  GetLockMode(AComponent: TComponent): TLMDDesignerLockMode;
    function  TryGetLockMode(AComponent: TComponent;
                             out ALockMode: TLMDDesignerLockMode): Boolean;
    procedure ClearAllLocks;

    procedure SaveLockState(AStream: TStream); overload;
    procedure SaveLockState(const AFileName: TLMDString); overload;
    procedure LoadLockState(AStream: TStream); overload;
    procedure LoadLockState(const AFileName: TLMDString); overload;

    procedure UpdateSelected;
    procedure LockSelected(ALockMode: TLMDDesignerLockMode);
    procedure AlignSelectedToGrid;
    procedure AlignSelected(AHorzAlign, AVertAlign: TLMDDesignerAlignType);
    procedure BringSelectedToFront;
    procedure SendSelectedToBack;

    function  CanCopyToClipboard: Boolean;
    function  CanCutToClipboard: Boolean;
    function  CanPasteFromClipboard: Boolean;
    procedure CutToClipboard;
    procedure CopyToClipboard;
    procedure PasteFromClipboard;

    procedure UpdateNonvisualComponents;     // For manually added frame
                                             // children, because frames
                                             // didn't report any notifications.

    procedure UpdateAllComponentsCollection; // For manually added root
                                             // children.
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
  end;

  { ******************************* TLMDDesigner ***************************** }

  TLMDDesigner = class(TLMDCustomDesigner)
  private
    procedure ReadDeprecatedEventProp(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    property Active;
    property Focused;
    property RootVisible;
    property HiddenClasses;
    property EditorWindows;
  published
    property ServiceProvider;
    property ServiceOptions;
    property Selection;
    property AllComponents;
    property ExcludeRoot;
    property ShowRootResizers;
    property Module;
    property DesignPanel;
    property Grid;
    property SnapToGrid;
    property ShowAlignLines;
    property Hints;
    property PopupMenu;
    property MenuOptions;
    property HandleColor;
    property HandleBorderColor;
    property MultiSelectHandleColor;
    property MultiSelectHandleBorderColor;
    property InactiveHandleColor;
    property InactiveHandleBorderColor;
    property LockedHandleColor;
    property ClipboardFormat;
    property ComponentContextPopup;
    property ShowNonvisualComponents;
    property ShowComponentCaptions;
    property ComponentCaptionsFont;
    property NonvisualComponentImages;
    property NonvisualComponentWidth;
    property NonvisualComponentHeight;
    property OnChange;
    property OnComponentInserting;
    property OnComponentInserted;
    property OnNotification;
    property OnComponentHint;
    property OnDesignFormClose;
    property OnGetTransparence;
    property OnGetImageIndex;
    property OnShowNonvisualComponent;
    property OnContextPopup;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
  end;

  { **************************** Designer services *************************** }

  ILMDDesignerNotifier = class
  public
    procedure Focus(ASender: TLMDCustomDesigner); virtual; abstract;
    procedure ActiveChanged(ASender: TLMDCustomDesigner); virtual; abstract;
  end;

  ILMDCompInsService = class
  public
    procedure Inserting(ASender: TObject;
                        var AComponentClass: TComponentClass); virtual; abstract;
    procedure Inserted(ADesigner: TLMDCustomDesigner); virtual; abstract;
  end;

  ILMDCompImageService = class
  public
    procedure GetCompImageParams(ASender: TObject;
                                 AComponentClass: TComponentClass;
                                 var AImageList: TImageList;
                                 var AImageIndex: Integer); virtual; abstract;
  end;

  ILMDObjEditService = class
  public
    procedure DblClicked(ASender: TObject;
                         AInstance: TPersistent); virtual; abstract;
    procedure AdjustMenu(ASender: TObject;
                         AInstance: TPersistent;
                         AMenu: TPopupMenu); virtual; abstract;
  end;

function LMDIsPlacedOnDesignPanel(AControl: TWinControl): Boolean;
function LMDGetDesignerList: TList;
function LMDFindDesigner(ARoot: TWinControl): TLMDCustomDesigner;
function LMDFindDesignerEditorWindows(ARoot: TWinControl): TLMDEditorWindowManager;

implementation

uses
  Math, LMDProcs, LMDInsClass;

{$IFDEF LMD_DEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

const
  HandleSize = 5;

  LockModeNames: array[TLMDDesignerLockModeItem] of TLMDString = (
    'nomove', 'noresize', 'nodelete', 'noinsertin', 'nocopy', 'custom1',
    'custom2', 'custom3', 'custom4', 'custom5', 'custom6', 'custom7',
    'custom8');

var
  RMDsgnrSizing: DWORD;
  RMDsgnrCancel: DWORD;
  RMDsgnrSCUpd:  DWORD;

  DesignerList: TList;

type
  TEngine = class;

  TComponentAccess  = class(TComponent);
  TControlAccess    = class(TControl);
  TWinControlAccess = class(TWinControl);

  PWMMouse  = ^TWMMouse;
  TDMSizing = record
    Msg:          Cardinal;
    Unused:       WPARAM;
    MouseMessage: PWMMouse;
    Result:       LRESULT;
  end;

  {******************************* TEditorUtils *******************************}

  TEditorUtils = class(TLMDEditorUtils)
  private
    FDesigner: TLMDCustomDesigner;
  public
    constructor Create(ADesigner: TLMDCustomDesigner);
    procedure   GetObjects(AResult: TList); override;
    procedure   SetObjects(AObjects: TList); override;
    function    GetUniqueCompName(AComp: TComponent): TLMDString; override;
    procedure   MarkModified; override;
  end;

  { *************************** TDesignerMenuItem **************************** }

  TDesignerMenuItemAction = (miaNone, miaCut, miaCopy, miaPaste, miaSelectAll);

  TDesignerMenuItem = class(TMenuItem)
  protected
    procedure UpdateState;
  public
    Designer: TLMDCustomDesigner;
    Action:   TDesignerMenuItemAction;

    procedure Click; override;
  end;

  { **************************** TDesignPanelForm **************************** }

  TDesignPanelForm = class(TCustomForm)
  private
    FDesignPanel: TLMDCustomDesignPanel;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateHandle; override;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor CreateForm(ADesignPanel: TLMDCustomDesignPanel); reintroduce;

    function SetFocusedControl(Control: TWinControl): Boolean; override;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property AutoScroll;
  end;

  { ****************************** TSelnNotifier ***************************** }

  TSelnNotifier = class(ILMDDsgObjsNotifier)
  private
    FDesigner: TLMDCustomDesigner;
  public
    constructor Create(ADesigner: TLMDCustomDesigner);
    procedure   Changed(ASender: TLMDDesignObjects); override;
  end;

  { ***************************** TModuleNotifier **************************** }

  TModuleNotifier = class(ILMDModuleNotifier)
  private
    FDesigner: TLMDCustomDesigner;
  public
    constructor Create(ADesigner: TLMDCustomDesigner);
    procedure   RootChange(AModule: TLMDModule); override;
    procedure   RootReloaded(AModule: TLMDModule); override;
  end;

  TCompCaptionsFont = class(TFont)
  private
    FDesigner: TLMDCustomDesigner;
  protected
    procedure Changed; override;
  public
    constructor Create(ADesigner: TLMDCustomDesigner);
  end;

  { ******************************* TEngCanvas ******************************* }

  TEngCanvas = class(TCanvas)
  private
    FWinControl   : TWinControl;
    FHiddenControl: TWinControl;
    FEng          : TEngine;

    procedure SetWinControl(const Value: TWinControl);
  protected
    procedure CreateHandle; override;
  public
    constructor Create(AEng: TEngine);
    destructor Destroy; override;

    function ScreenToClient(const AP: TPoint): TPoint;
    property WinControl: TWinControl read FWinControl write SetWinControl;
  end;

  { ********************************* TEngHint ******************************* }

  TEngHintTimerMode = (tmShow, tmHide);

  TEngHint = class
  private
    FTimer             : TTimer;
    FTimerMode         : TEngHintTimerMode;
    FNeedStartHideTimer: Boolean;
    FStr               : TLMDString;
    FActive            : Boolean;
    FCheckControl      : TControl;
    FUseHooks          : Boolean;
    FEng               : TEngine;
    FHintWindow        : TLMDHintWindow;
    
    procedure TimerOnTimer(Sender: TObject);
    procedure ActivateNoPause;
  public
    constructor Create(AEng: TEngine);
    destructor Destroy; override;

    procedure ActivateHint(APauseBeforeShow, AHideAfterPause, AUseHooks: Boolean;
                           ACheckControl: TControl; const AStr: TLMDString);
    procedure CancelHint;
    procedure IsHintMsg(var AMsg: TMsg);
    property  Active: Boolean read FActive;
  end;

  { **************************** TNonvisualControl *************************** }

  TNonvisualControl = class;

  TNonvisualControlLabel = class(TCustomControl)
  private
    FControl: TNonvisualControl;
  protected
    procedure WndProc(var Message: TMessage); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent;
                       AControl: TNonvisualControl); reintroduce;
    procedure Update(const AText: TLMDString); reintroduce;
  end;

  TNonvisualControl = class(TCustomControl)
  private
    FDEng:      TEngine;
    FComponent: TComponent;
    FLabel:     TNonvisualControlLabel;

    procedure UpdateLabelWindow;
  protected
    procedure WndProc(var Message: TMessage); override;
    procedure Paint; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(ADEng: TEngine; AComponent: TComponent); reintroduce;
    destructor Destroy; override;

    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer;
                        AHeight: Integer); override;
    procedure SetParentHandle(AHandle: THandle);
    procedure Update; reintroduce;
    procedure Renaming(const ANewName: TLMDString);
    property  Component: TComponent read FComponent;
  end;

  { ***************************** TMouseHandleBase *************************** }

  TMouseHandlesMode = (imNone, imSizeable, imMultiSelect);
  TMouseHandlePos   = (ppTopLeft, ppTop, ppTopRight, ppRight, ppBottomRight,
                       ppBottom, ppBottomLeft, ppLeft);

  TMouseHandleParams = record
    Control: TControl;
    Mode:    TMouseHandlesMode;
    Active:  Boolean;
  end;

  TMouseHandleState = (mhcActive, mhcInactive, mhcMulti, mhcLocked);

  TSelCtrlItem     = class;
  TMouseHandleBase = class(TCustomControl)
  private
    FSelCtrl    : TSelCtrlItem;
    FDEng       : TEngine;
    FPos        : TMouseHandlePos;
    FState      : TMouseHandleState;
    FBorderColor: TColor;
    FColor      : TColor;

    procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBKGND;
    function  GetControl: TControl;
    function  GetThemedBackColor: TColor;
    function  GetThemedBorderColor: TColor;
  protected
    procedure Paint; override;
    procedure WndProc(var Message: TMessage); override;
    procedure GetHandleParams(var AParams: TMouseHandleParams); virtual; abstract;
    procedure MouseAction(var Message: TMessage); virtual; abstract;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(ASelCtrl: TSelCtrlItem; ADEng: TEngine;
                       APos: TMouseHandlePos); reintroduce;
    destructor  Destroy; override;

    procedure Update; reintroduce;
    property  Pos: TMouseHandlePos read FPos;
    property  Control: TControl read GetControl;
  end;

  { ******************************* TSelCtrlItem ***************************** }

  TSelCtrls    = class;

  TRootMouseHandle = class(TMouseHandleBase)
  private
    FInitPos:        TPoint;
    FInitRootWidth:  Integer;
    FInitRootHeight: Integer;
    FMouseDown:      Boolean;

    procedure ResizeRoot;
  protected
    procedure GetHandleParams(var AParams: TMouseHandleParams); override;
    procedure MouseAction(var Message: TMessage); override;
  public
    constructor Create(ADEng: TEngine; APos: TMouseHandlePos;
                       ASelCtrl: TSelCtrlItem);
  end;

  TSelCtrlMouseHandle = class(TMouseHandleBase)
  protected
    procedure GetHandleParams(var AParams: TMouseHandleParams); override;
    procedure MouseAction(var Message: TMessage); override;
  public
    constructor Create(ADEng: TEngine; APos: TMouseHandlePos;
                       ASelCtrl: TSelCtrlItem);
  end;

  TSelCtrlItem = class
  private
    FSelCtrls : TSelCtrls;
    FPoints   : array[TMouseHandlePos] of TMouseHandleBase;
    FControl  : TControl;
    FMode     : TMouseHandlesMode;
    FActivePos: TMouseHandlePos;

    procedure SetMode(const Value: TMouseHandlesMode;
                      AUpdateMouseHandles: Boolean);
  public
    constructor Create(AOwnerSelCtrls: TSelCtrls; AControl: TControl);
    destructor Destroy; override;

    property  Mode: TMouseHandlesMode read FMode;
    property  Control: TControl read FControl;
  end;

  { ********************************* TSelCtrls ****************************** }

  TDeferItem = class
  public
    Parent: HWND;
    DWP:    HDWP;
  end;

  TSelCtrls = class
  private
    FDEng          : TEngine;
    FItems         : TList;
    FVisible       : Boolean;
    FActive        : Boolean;
    FRootWinControl: TWinControl;
    FDefers        : TList; // DeferWindowPos works only inside single
                            // parent window, so we have to perform a
                            // distinct defer operation for each parent.
    FUpdateCount   : Integer;
    FChanged       : Boolean;
    FDestroying    : Boolean;

    function  GetCount: Integer;
    procedure SetVisible(const Value: Boolean);
    procedure SetActive(const Value: Boolean);
    procedure SetRootWinControl(const Value: TWinControl);
    function  GetItems(I: Integer): TControl;
    function  GetComp(I: Integer): TComponent;
    function  GetDefControl: TControl;
    function  GetDefComp: TComponent;
    procedure Change;
    procedure UpdateMode(AUpdatePoints: Boolean);
    procedure InsertItem(AItem: TSelCtrlItem);
    procedure RemoveItem(AItem: TSelCtrlItem);
    procedure CheckDesignControl(AControl: TControl);
    procedure ClearDeferItems;
  protected
    procedure BeginDefer;
    procedure DeferPos(hWnd, hPnt: HWND; hWndInsertAfter: HWND; x, y, cx,
                       cy: Integer; uFlags: UINT);
    procedure EndDefer;
  public
    constructor Create(ADEng: TEngine); reintroduce;
    destructor Destroy; override;

    function  Add(AControl: TControl): Integer;
    function  IndexOf(AControl: TControl): Integer;
    procedure Delete(AI: Integer);
    procedure Remove(AControl: TControl);
    procedure GetControls(AResult: TList);
    procedure GetComps(AResult: TList);
    procedure ClearExcept(AControl: TControl);
    procedure ClearNotChildrensOf(AParent: TWinControl);
    procedure Clear;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Lock(ALockMode: TLMDDesignerLockMode);
    procedure AlignToGrid;
    procedure Align(AHorzAlign, AVertAlign: TLMDDesignerAlignType);
    procedure BringToFront;
    procedure SendToBack;
    property  Items[I: Integer]: TControl
            read GetItems; default; // Represents visual controls and
                                    // control stubs for non-visual components,
                                    // not non-visual components itself.
    property  Comp[I: Integer]: TComponent read GetComp;
    property  Count: Integer read GetCount;
    property  DefControl: TControl read GetDefControl;
    property  DefComp: TComponent read GetDefComp;
  end;

  { *************************** TEngine draw handlers ************************ }

  TEngDrawHandler      = class;
  TEngDrawHandlerClass = class of TEngDrawHandler;

  TEngAlignLine = record
    IsVertical: Boolean;
    Origin:     Integer;
    Min:        Integer;
    Max:        Integer;
  end;

  TEngDrawHandler = class
  private
    FDEng:                TEngine;
    FCanvas:              TEngCanvas;
    FAlignToList:         TList; // Controls for aligning to.
    FAlignLines:          array of TEngAlignLine;
    FSnapToGrid:          Boolean;
    FSkipXCursorMoving:   Boolean;
    FSkipYCursorMoving:   Boolean;
    FInitCursorPos:       TPoint;
    FVirtCursor:          TPoint;
    FLastVirtCursorPos:   TPoint;
    FDrawInited:          Boolean;
    FInitRectForAlign:    TRect;
    FHasInitRectForAlign: Boolean;
    FAlignEnabled:        Boolean;

    function  VirtualizeCursor: TPoint;
    procedure GetAlignedCursor(const ACtrlRect: TRect;
                               var ACursPos: TPoint;
                               out AAlignedX, AAlignedY: Boolean);
    function  IsRectForAlignChanged(const LR: TRect): Boolean;
    procedure FillAlignToList(AParent: TWinControl);
    function  FindVisibleScreenRect(AClient: TWinControl;
                                    out ARect: TRect): Boolean;
  protected
    procedure UpdateAlignLines;
    procedure XORDrawAlignLines;
    property  VirtCursor: TPoint read FVirtCursor;
    property  Canvas: TEngCanvas read FCanvas;
  protected
    procedure GetParams(out AEnableSnapToGrid: Boolean;
                        out ASnapToGridFirstCursorPos: Boolean); virtual;
    function  GetRectForAlign(out ARect: TRect; const AVirtCurs: TPoint): Boolean; virtual;
    procedure GetAlignParams(out ALeft, ATop, ARight, ABottom: Boolean); virtual;
    procedure DoInitDraw; virtual; abstract;
    procedure DoMoveDraw; virtual; abstract;
    procedure DoClearDraw; virtual; abstract;
    procedure DoApply; virtual; abstract;
  public
    constructor Create(ADEng: TEngine; AControlToDrawOn: TWinControl;
                       ASkipXCursorMoving, ASkipYCursorMoving: Boolean); virtual;
    destructor Destroy; override;

    procedure InitDraw;
    procedure MoveDraw;
    procedure FinDraw(AApply: Boolean);
  end;

  TEngSelectHandler = class(TEngDrawHandler)
  private
    FPointA: TPoint;
    FPointB: TPoint;

    procedure XORDraw;
  protected
    procedure DoInitDraw; override;
    procedure DoMoveDraw; override;
    procedure DoClearDraw; override;
    procedure DoApply; override;
  end;

  TEngMoveHandler = class(TEngDrawHandler)
  private
    FControlList:          TList;
    FStartClientCursorPos: TPoint;
    FOffset:               TPoint;
    FMinLeftTop:           TPoint;

    function  AdjustOffset(const AVirtCursorPos: TPoint): TPoint;
    procedure XORDraw;
    procedure ShowHint(P: TPoint);
  protected
    procedure GetParams(out AEnableSnapToGrid: Boolean;
                        out ASnapToGridFirstCursorPos: Boolean); override;
    function  GetRectForAlign(out ARect: TRect; const AVirtCurs: TPoint): Boolean; override;
    procedure DoInitDraw; override;
    procedure DoMoveDraw; override;
    procedure DoClearDraw; override;
    procedure DoApply; override;
  public
    constructor Create(ADEng: TEngine; AControlToDrawOn: TWinControl;
                       ASkipXCursorMoving, ASkipYCursorMoving: Boolean); override;
    destructor Destroy; override;
  end;

  TEngResizeHandler = class(TEngDrawHandler)
  private
    FControl:              TControl;
    FPointPosition:        TMouseHandlePos;
    FStartClientCursorPos: TPoint;
    FOffset:               TPoint;

    function  GetDrawRect(const AOffset: TPoint): TRect;
    function  AdjustOffset(const AVirtCursorPos: TPoint): TPoint;
    procedure XORDraw(R: TRect);
    procedure ShowHint(R: TRect);
  protected
    procedure GetParams(out AEnableSnapToGrid: Boolean;
                        out ASnapToGridFirstCursorPos: Boolean); override;
    function  GetRectForAlign(out ARect: TRect; const AVirtCurs: TPoint): Boolean; override;
    procedure GetAlignParams(out ALeft, ATop, ARight, ABottom: Boolean); override;
    procedure DoInitDraw; override;
    procedure DoMoveDraw; override;
    procedure DoClearDraw; override;
    procedure DoApply; override;
  public
    constructor Create(ADEng: TEngine; AControlToDrawOn: TWinControl;
                       ASkipXCursorMoving, ASkipYCursorMoving: Boolean); override;
  end;

  TEngInsertHandler = class(TEngDrawHandler)
  private
    FStartClientCursorPos: TPoint;
    FOffset:               TPoint;
    FDrawn:                Boolean;

    function  GetDrawRect(const AOffset: TPoint): TRect;
    function  AdjustOffset(const AVirtCursorPos: TPoint): TPoint;
    procedure XORDraw(R: TRect);
    procedure ShowHint(R: TRect);
  protected
    procedure GetParams(out AEnableSnapToGrid: Boolean;
                        out ASnapToGridFirstCursorPos: Boolean); override;
    function  GetRectForAlign(out ARect: TRect; const AVirtCurs: TPoint): Boolean; override;
    procedure DoInitDraw; override;
    procedure DoMoveDraw; override;
    procedure DoClearDraw; override;
    procedure DoApply; override;
  end;

  { ***************************** TEngCompNotifier *************************** }

  TEngCompNotifier = class(TComponent)
  private
    FDEng:  TEngine;
    FComps: TList;
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
  public
    constructor Create(ADEng: TEngine); reintroduce;
    destructor  Destroy; override;

    procedure AddComp(AComp: TComponent);
    procedure RemoveComp(AComp: TComponent);
    procedure Clear;
  end;

  { ********************************* TEngine ******************************** }

  IEngDesigner = IDesignerHook;
  TEngState    = set of (desDestroying, desDrawMode, desClicked,
                         desUpdatingDesSeln, desUpdatingEngSeln);

  TEngine = class(TInterfacedObject, IEngDesigner)
  private
    FDesigner                             : TLMDCustomDesigner;
    FMouseHandles                         : TList;
    FGrid                                 : TLMDDesignerGrid;
    FState                                : TEngState;
    FSelCtrls                             : TSelCtrls;
    FCompNotifier                         : TEngCompNotifier;
    FHint                                 : TEngHint;
    FHintControl                          : TControl;
    FRoot                                 : TWinControl;
    FForm                                 : TCustomForm;
    FDesignPanel                          : TLMDCustomDesignPanel;
    FDrawHandler                          : TEngDrawHandler;
    FInsertingComponentClass              : TComponentClass;
    FGridBitmap                           : Graphics.TBitmap;
    FGridBrush                            : HBRUSH;
    FGridBkColor                          : TColor;
    FGridFgColor                          : TColor;
    FGridHScrollPos                       : Integer;
    FGridVScrollPos                       : Integer;
    FOldRootLeft                          : Integer;
    FOldRootTop                           : Integer;
    FNonvisualControls                    : TList;
    FDefNonVisibleBitmap                  : Graphics.TBitmap;

    function  GetRootVisible: Boolean;
    procedure SetRootVisible(const Value: Boolean);
    procedure GridParamsChanged;
    function  GetThemedFormColor: TColor;
    function  GetThemedGridColor: TColor;
    procedure UpdateGridPattern;
    procedure ReaderReadComponent(Component: TComponent);
    function  GetFocused: Boolean;
    procedure AddNonvisualControlItem(AControl: TNonvisualControl);
    procedure RemoveNonvisualControlItem(AControl: TNonvisualControl);
    function  GetDefNonVisibleBitmap: Graphics.TBitmap;
  protected
    { IUnknown }

    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    { IDesignerNotify }

    procedure Modified;
    procedure Notification(AnObject: TPersistent; Operation: TOperation);
    {$IFDEF LMDCOMP21}
    procedure CanInsertComponent(AComponent: TComponent);
    {$ENDIF}

    { ILMDEngDesigner }

    function  GetCustomForm: TCustomForm;
    procedure SetCustomForm(Value: TCustomForm);
    function  GetIsControl: Boolean;
    procedure SetIsControl(Value: Boolean);
    function  IsDesignMsg(Sender: TControl; var Message: TMessage): Boolean;
    procedure PaintGrid;
    {$IFDEF LMDCOMP9}
    procedure PaintMenu;
    {$ENDIF}
    {$IFDEF LMDCOMP17}
    procedure DrawSelectionMarks(AControl: TControl);
    function IsSelected(AControl: TControl): Boolean;
    {$ENDIF}
    procedure ValidateRename(AComponent: TComponent; const CurName,
                             NewName: string);
    function  UniqueName(const BaseName: string): string;
    function  GetRoot: TComponent;
  protected
    { Controls handling, including non-visual component stub controls, }
    { not non-visual components itself                                 }

    function  IsDesignControl(AControl: TControl;
                              ARejectTransparent: Boolean = True): Boolean;
    function  GetDesignControl(AControl: TControl): TControl;
    function  GetContainer(AControl: TControl; AIsForInserting: Boolean): TWinControl;
    function  GetControlParent(AControl: TControl): TWinControl;
    function  MouseMessage(ASender: TControl; const AMessage: TMessage): Boolean;
    function  KeyMessage(const AMessage: TMessage): Boolean;
    procedure LockControl(AControl: TControl; ALockMode: TLMDDesignerLockMode);
    procedure ClearLocks;
    class function GetLockMode(AControl: TControl): TLMDDesignerLockMode;
    class function GetFullLockMode(AControl: TControl): TLMDDesignerLockMode;
    procedure AlignToGrid(AControl: TControl);
    procedure SetPosition(AControl: TControl; ALeft, ATop: Integer);
    function  ControlAtPos(const APos: TPoint): TControl;
    procedure SelectControls(AControls: TList);
    procedure DesignPanelHandleChanging(ANewHandle: Integer);
    procedure UpdateMouseHandles;
    procedure UpdateControlMouseHandles(AControl: TControl); overload;

    { Non-visual components stub controls handling }

    procedure ClearNonvisualControls;
    procedure AddNonvisualControl(AComp: TComponent);
    procedure RemoveNonvisualControl(AComp: TComponent);
    function  FindNonvisualControl(AComp: TComponent): TNonvisualControl;
    function  NonvisualControlByComp(AComp: TComponent): TNonvisualControl;
    procedure RecreateNonvisualControls;
    procedure UpdateNonvisualControls;
    procedure RepaintNonvisualControls;
    function  CompByControl(AControl: TControl): TComponent;
    function  ControlByComp(AComp: TComponent): TControl;
    function  FindControl(AComp: TComponent): TControl;

    { All components handling, including visual controls and }
    { non-visual components, not stubs                       }

    function  GetCompParent(AComp: TComponent): TWinControl;
    procedure ClipbrdSave(AStream: TStream; AComponents: TList);
    procedure ClipbrdLoad(AStream: TStream; AParent: TWinControl);
    procedure SelectAll;
    procedure SelectComps(AComps: TList);
    function  IndexOfSelectedComp(AComp: TComponent): Integer;
    function  IsCompHidden(AComp: TComponent): Boolean;
    procedure DeleteSelectedComps;

    { Two-ways selection synchronization }

    procedure UpdateDesignerSelection;
    procedure UpdateEngineSelection;

    { All-components collection synchronization }

    procedure DoAddChildrenToAllComps(AOwner: TComponent; AResult: TList);
    procedure GetAllComponents(AExcludeRoot: Boolean; AResult: TList);
    procedure UpdateDesignerAllComponents;

    { Other methods }

    procedure CancelMode;
    function  CanFocus: Boolean;
    procedure SetFocus;
    property  Focused: Boolean read GetFocused;
    property  RootVisible: Boolean read GetRootVisible write SetRootVisible;
  public
    constructor Create(ADesigner: TLMDCustomDesigner; ARoot: TWinControl;
                       ADesignPanel: TLMDCustomDesignPanel);
    destructor Destroy; override;
  end;

{ **************************** Global procedures ***************************** }
{ ---------------------------------------------------------------------------- }

function LMDBlend(ABase, C: TColor; Alpha: Integer): TColor;
var
  bq, cq: TRGBQuad;
  rq:     TRGBQuad;
  alp:    Double;
begin
  bq  := TRGBQuad(ColorToRGB(ABase));
  cq  := TRGBQuad(ColorToRGB(C));
  alp := Alpha / 100;

  if alp > 1 then
    alp := 1
  else if alp < 0 then
    alp := 0;

  rq.rgbBlue     := Round(bq.rgbBlue * (1 - alp) + cq.rgbBlue * alp);
  rq.rgbGreen    := Round(bq.rgbGreen * (1 - alp) + cq.rgbGreen * alp);
  rq.rgbRed      := Round(bq.rgbRed * (1 - alp) + cq.rgbRed * alp);
  rq.rgbReserved := Round(bq.rgbReserved * (1 - alp) + cq.rgbReserved * alp);

  Result := TColor(rq);
end;

function LMDIsPlacedOnDesignPanel(AControl: TWinControl): Boolean;
begin
  Result := (AControl.Parent is TDesignPanelForm);
end;

{ ---------------------------------------------------------------------------- }
function LMDGetDesignerList: TList;
begin
  Result := DesignerList;
end;

{ ---------------------------------------------------------------------------- }
function LMDFindDesigner(ARoot: TWinControl): TLMDCustomDesigner;
var
  i:   Integer;
  mdl: TLMDModule;
begin
  for i := 0 to DesignerList.Count - 1 do
  begin
    mdl := TLMDCustomDesigner(DesignerList[i]).FModule;
    
    if (mdl <> nil) and (mdl.Root = ARoot) and
       TLMDCustomDesigner(DesignerList[i]).Active then
    begin
      Result := TLMDCustomDesigner(DesignerList[i]);
      Exit;
    end;
  end;

  Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function LMDFindDesignerEditorWindows(ARoot: TWinControl): TLMDEditorWindowManager;
var
  dsnr: TLMDCustomDesigner;
begin
  dsnr := LMDFindDesigner(ARoot);
  if dsnr <> nil then
    Result := dsnr.EditorWindows
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function Max(const A, B: Integer): Integer;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

{ ---------------------------------------------------------------------------- }
function Min(const A, B: Integer): Integer;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;

{ ---------------------------------------------------------------------------- }
procedure RegisterDesignerMessages;
begin
  RMDsgnrSizing := RegisterWindowMessage(PChar(
    Format('LMD_RM_DsgnrSizing%.8X%.8X', [HInstance, GetCurrentThreadID])));
  RMDsgnrCancel := RegisterWindowMessage(PChar(
    Format('LMD_RM_DsgnrCancel%.8X%.8X', [HInstance, GetCurrentThreadID])));
  RMDsgnrSCUpd := RegisterWindowMessage(PChar(
    Format('LMD_RM_DsgnrSCUpd%.8X%.8X', [HInstance, GetCurrentThreadID])));
end;

{ ---------------------------------------------------------------------------- }
function RectFromPoints(AP1, AP2: TPoint): TRect;
begin
  if AP1.x < AP2.x then
    begin
      Result.Left := AP1.x;
      Result.Right := AP2.x;
    end
  else
    begin
      Result.Left := AP2.x;
      Result.Right := AP1.x;
    end;
  if AP1.y < AP2.y then
    begin
      Result.Top := AP1.y;
      Result.Bottom := AP2.y;
    end
  else
    begin
      Result.Top := AP2.y;
      Result.Bottom := AP1.y;
    end;
end;

{ ---------------------------------------------------------------------------- }
function IsRectCrossed(AR1, AR2: TRect): Boolean;
begin
  Result := (AR1.Left <= AR2.Right) and (AR2.Left <= AR1.Right) and
    (AR1.Top <= AR2.Bottom) and (AR2.Top <= AR1.Bottom);
end;

{ ---------------------------------------------------------------------------- }
procedure DrawSelectRect(ARect: TRect; ACanvas: TCanvas);
begin
  ACanvas.Pen.Color   := clGray;
  ACanvas.Pen.Mode    := pmXor;
  ACanvas.Pen.Width   := 1;
  ACanvas.Pen.Style   := psDot;
  ACanvas.Brush.Style := bsClear;

  ACanvas.Rectangle(ARect);
end;

{ ---------------------------------------------------------------------------- }
procedure DrawControlRect(ARect: TRect; ACanvas: TCanvas);
begin
  ACanvas.Pen.Color   := clGray;
  ACanvas.Pen.Mode    := pmXor;
  ACanvas.Pen.Width   := 2;
  ACanvas.Pen.Style   := psSolid;
  ACanvas.Brush.Style := bsClear;

  Inc(ARect.Left);
  Inc(ARect.Top);
  ACanvas.Rectangle(ARect);
end;

{ ---------------------------------------------------------------------------- }
procedure DrawAlignLine(const AFrom, ATo: TPoint; ACanvas: TCanvas);
begin
  ACanvas.Pen.Color   := clGray;
  ACanvas.Pen.Mode    := pmXor;
  ACanvas.Pen.Width   := 1;
  ACanvas.Pen.Style   := psSolid;
  ACanvas.Brush.Style := bsClear;

  ACanvas.MoveTo(AFrom.X, AFrom.Y);
  ACanvas.LineTo(ATo.X, ATo.Y);
end;

{ ---------------------------------------------------------------------------- }
function AlignHorzSortProc(Item1, Item2: TLMDDataTag): Integer;
begin
  if TControl(Item1).Left < TControl(Item2).Left then
    Result := 1
  else if TControl(Item1).Left > TControl(Item2).Left then
    Result := -1
  else
    Result := 0;
end;

{ ---------------------------------------------------------------------------- }
function AlignVertSortProc(Item1, Item2: TLMDDataTag): Integer;
begin
  if TControl(Item1).Top < TControl(Item2).Top then
    Result := 1
  else if TControl(Item1).Top > TControl(Item2).Top then
    Result := -1
  else
    Result := 0;
end;

{ ********************** class TLMDCustomDesignPanel ************************* }
{ -------------------------------- private ----------------------------------- }
procedure TLMDCustomDesignPanel.SetEng(AEng: TObject);
begin
  FEng := AEng;
  UpdateFormParentWindow;
  UpdateEngFocus;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignPanel.SetBorderStyle(const Value: TBorderStyle);
begin
  if (Value <> FBorderStyle) and (Value in [bsSingle, bsNone]) then
    begin
      FBorderStyle := Value;
      RecreateWnd;
      UpdateFormBounds;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesignPanel.GetIsUsed: Boolean;
begin
  Result := FEng <> nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignPanel.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if TabStop and CanFocus then
    SetFocus;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignPanel.WMRButtonDown(var Message: TWMLButtonDown);
begin
  if CanFocus then
    SetFocus;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignPanel.CMColorChanged(var Message: TMessage);
begin
  FForm.Color := Color;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignPanel.CMCursorChanged(var Message: TMessage);
begin
  FForm.Cursor := Cursor;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignPanel.CMBiDiModeChanged(var Message: TMessage);
begin
  FForm.BiDiMode := BiDiMode;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignPanel.CMFontChanged(var Message: TMessage);
begin
  FForm.Font := Font;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignPanel.CMParentBiDiModeChanged(var Message: TMessage);
begin
  TDesignPanelForm(FForm).ParentBiDiMode := ParentBiDiMode;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignPanel.CMParentColorChanged(var Message: TMessage);
begin
  TDesignPanelForm(FForm).ParentColor := ParentColor;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignPanel.CMParentFontChanged(var Message: TMessage);
begin
  TDesignPanelForm(FForm).ParentFont := ParentFont;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignPanel.CMParentShowHintChanged(var Message: TMessage);
begin
  TDesignPanelForm(FForm).ParentShowHint := ParentShowHint;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignPanel.WMSetFocus(var Msg: TWMSetFocus);
begin
  UpdateEngFocus;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesignPanel.GetAutoScroll: Boolean;
begin
  Result := TDesignPanelForm(FForm).AutoScroll;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignPanel.SetAutoScroll(const Value: Boolean);
begin
  TDesignPanelForm(FForm).AutoScroll := Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesignPanel.GetHorzScrollBar: TControlScrollBar;
begin
  Result := FForm.HorzScrollBar;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignPanel.SetHorzScrollBar(const Value: TControlScrollBar);
begin
  FForm.HorzScrollBar := Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesignPanel.GetVertScrollBar: TControlScrollBar;
begin
  Result := FForm.VertScrollBar;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignPanel.SetVertScrollBar(const Value: TControlScrollBar);
begin
  FForm.VertScrollBar := value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignPanel.UpdateFormParentWindow;
begin
  if IsUsed and HandleAllocated then
    FForm.ParentWindow := Handle
  else
    FForm.ParentWindow := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignPanel.UpdateEngFocus;
begin
  if IsUsed and Focused then
    TEngine(FEng).SetFocus;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignPanel.UpdateFormBounds;
var
  LR: TRect;
begin
  if HandleAllocated then
  begin
    LR := ClientRect;
    with LR do
      FForm.SetBounds(Left, Top, Right - Left, Bottom - Top);
  end;
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDCustomDesignPanel.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_DESIGN;
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDCustomDesignPanel.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited;
  with Params do
  begin
    Style   := Style or WS_CLIPCHILDREN or BorderStyles[FBorderStyle];
    ExStyle := ExStyle or WS_EX_CONTROLPARENT;

    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style   := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;

    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignPanel.CreateHandle;
begin
  inherited;
  UpdateFormBounds;
  UpdateFormParentWindow;
  if FForm.ParentWindow <> 0 then
    ShowWindow(FForm.Handle, SW_SHOW);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesignPanel.GetPopupMenu: TPopupMenu;
begin
  Result := inherited GetPopupMenu;
  if IsUsed then Result := nil;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDCustomDesignPanel.Create(AOwner: TComponent);
begin
  inherited;
  TabStop      := True;
  Width        := 185;
  Height       := 41;
  FBorderStyle := bsSingle;

  FForm              := TDesignPanelForm.CreateForm(Self);
  FForm.Visible      := True;
  FScrollCtrl        := TControl.Create(FForm);
  FScrollCtrl.Width  := 0;
  FScrollCtrl.Height := 0;
  FScrollCtrl.Parent := FForm;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomDesignPanel.Destroy;
begin
  FForm.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignPanel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  UpdateFormBounds;
end;

{ ************************* class TLMDDesignerGrid *************************** }
{ ------------------------------ private ------------------------------------- }
procedure TLMDDesignerGrid.SetVisible(const Value: Boolean);
begin
  if Value = FVisible then Exit;
  FVisible := Value;
  FDesigner.GridParamsChanged;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDesignerGrid.SetXStep(const Value: TLMDDesignerGridSize);
begin
  if Value = FXStep then Exit;
  if Value < 2 then
    FXStep := 2
  else if Value > 32 then
    FXStep := 32
  else
    FXStep := Value;
  FDesigner.GridParamsChanged;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDesignerGrid.SetYStep(const Value: TLMDDesignerGridSize);
begin
  if Value = FYStep then Exit;
  if Value < 2 then
    FYStep := 2
  else if Value > 32 then
    FYStep := 32
  else
    FYStep := Value;
  FDesigner.GridParamsChanged;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDesignerGrid.SetColor(const Value: TColor);
begin
  if FColor = Value then Exit;
  FColor := Value;
  FDesigner.GridParamsChanged;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDDesignerGrid.Create(AOwnerDesigner: TLMDCustomDesigner);
begin
  inherited Create;
  FDesigner := AOwnerDesigner;
  FXStep := 8;
  FYStep := 8;
  FVisible := True;
  FColor := clBlack;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDesignerGrid.Assign(Source: TPersistent);
begin
  FVisible := TLMDDesignerGrid(Source).FVisible;
  FYStep := TLMDDesignerGrid(Source).FYStep;
  FXStep := TLMDDesignerGrid(Source).FXStep;
  FColor := TLMDDesignerGrid(Source).FColor;
end;

{ ********************************* class TSelCtrls ************************** }
{ ------------------------------ private ------------------------------------- }

function TLMDDesignerHiddenClasses.GetCount: Integer;
begin
  Result := FItems.Count;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDesignerHiddenClasses.GetItems(I: Integer): TComponentClass;
begin
  Result := TComponentClass(FItems[I]);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDesignerHiddenClasses.Changed;
begin
  if FUpdateCount <= 0 then
    DoChange
  else
    FChanged := True;
end;

{ ----------------------------- protected ------------------------------------ }
procedure TLMDDesignerHiddenClasses.DoChange;
begin
  FDesigner.HiddenClassesChanged;
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDDesignerHiddenClasses.Create(
  AOwnerDesigner: TLMDCustomDesigner);
begin
  inherited Create;
  FDesigner := AOwnerDesigner;
  FItems := TList.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDesignerHiddenClasses.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDesignerHiddenClasses.Add(AClass: TComponentClass): Integer;
begin
  Result := FItems.IndexOf(TObject(AClass));
  if Result = -1 then
  begin
    Result := FItems.Add(TObject(AClass));
    Changed;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDesignerHiddenClasses.IndexOf(
  AClass: TComponentClass): Integer;
begin
  Result := FItems.IndexOf(TObject(AClass));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDesignerHiddenClasses.Delete(AI: Integer);
begin
  FItems.Delete(AI);
  Changed;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDesignerHiddenClasses.Remove(AClass: TComponentClass);
var
  LI: Integer;
begin
  LI := IndexOf(AClass);
  if LI <> -1 then
  begin
    Delete(LI);
    Changed;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDesignerHiddenClasses.GetClasses(AResult: TList);
var
  LI: Integer;
begin
  AResult.Clear;
  for LI := 0 to Count - 1 do
    AResult.Add(TObject(Items[LI]));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDesignerHiddenClasses.SetClasses(AClasses: TList);
var
  LI: Integer;
begin
  BeginUpdate;
  try
    Clear;
    for LI := 0 to AClasses.Count - 1 do
      Add(TComponentClass(AClasses[LI])); // May raise exception
  finally
    EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDesignerHiddenClasses.Clear;
begin
  FItems.Clear;
  Changed;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDesignerHiddenClasses.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDesignerHiddenClasses.EndUpdate;
begin
  if FUpdateCount > 0 then
    Dec(FUpdateCount);

  if (FUpdateCount = 0) and FChanged then
  begin
    FChanged := False;
    DoChange;
  end;
end;

{ ********************************* class TSelCtrls ************************** }
{ ------------------------------ private ------------------------------------- }
function TSelCtrls.GetCount: Integer;
begin
  Result := FItems.Count;
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.SetVisible(const Value: Boolean);
begin
  if FVisible = Value then
    Exit;
  FVisible := Value;
  UpdateMode(True);
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.SetActive(const Value: Boolean);
begin
  if FActive = Value then Exit;
  FActive := Value;
  FDEng.UpdateMouseHandles;
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.SetRootWinControl(const Value: TWinControl);
begin
  if FRootWinControl = Value then
    Exit;

  FRootWinControl := Value;
  UpdateMode(True);
end;

{ ---------------------------------------------------------------------------- }
function TSelCtrls.GetItems(I: Integer): TControl;
begin
  Result := TSelCtrlItem(FItems[I]).Control;
end;

{ ---------------------------------------------------------------------------- }
function TSelCtrls.GetComp(I: Integer): TComponent;
begin
  Result := FDEng.CompByControl(Items[I]);
end;

{ ---------------------------------------------------------------------------- }
function TSelCtrls.GetDefControl: TControl;
begin
  if Count > 0 then
    Result := Items[Count - 1]
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TSelCtrls.GetDefComp: TComponent;
begin
  Result := FDEng.CompByControl(DefControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.Change;
begin
  if FUpdateCount <= 0 then
  begin
    FChanged := False;

    if not FDestroying then
    begin
      UpdateMode(False);
      FDEng.UpdateMouseHandles;

      if not (desDestroying in FDEng.FState) then
        FDEng.UpdateDesignerSelection;
    end;

    FDEng.FRoot.Invalidate;
  end
  else
    FChanged := True;
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.UpdateMode(AUpdatePoints: Boolean);

  procedure _SetHandlesMode(Value: TMouseHandlesMode);
  var
    i: Integer;
  begin
    BeginDefer;
    for i := 0 to Count - 1 do
      TSelCtrlItem(FItems[i]).SetMode(Value, AUpdatePoints);
    EndDefer;
  end;

begin
  if FVisible then
  begin
    if Count = 1 then
      _SetHandlesMode(imSizeable)
    else
      _SetHandlesMode(imMultiSelect);
  end
  else
    _SetHandlesMode(imNone);
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.InsertItem(AItem: TSelCtrlItem);
begin
  FItems.Add(AItem);
  if FVisible and (AItem.Control.Parent <> nil)
  then
    AItem.Control.Show;
  Change;
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.RemoveItem(AItem: TSelCtrlItem);
begin
  FItems.Remove(AItem);
  Change;
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.CheckDesignControl(
  AControl: TControl);
begin
  if not FDEng.IsDesignControl(AControl) then
    raise ELMDDesigner.CreateFmt(SLMDDsgnrCanNotSelectComp, [AControl.Name]);
end;

{ ------------------------------ public -------------------------------------- }
constructor TSelCtrls.Create(ADEng: TEngine);
begin
  inherited Create;
  
  FDEng   := ADEng;
  FItems  := TList.Create;
  FDefers := TList.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TSelCtrls.Destroy;
begin
  FDestroying := True;
  Clear;
  ClearDeferItems;
  FItems.Free;
  FDefers.Free;

  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TSelCtrls.Add(AControl: TControl): Integer;
var
  idx: Integer;
begin
  idx := IndexOf(AControl);
  if idx = -1 then
  begin
    CheckDesignControl(AControl);
    TSelCtrlItem.Create(Self, AControl);
    Result := Count - 1;
  end
  else
    Result := idx;
end;

{ ---------------------------------------------------------------------------- }
function TSelCtrls.IndexOf(AControl: TControl): Integer;
var
  LI: Integer;
begin
  Result := -1;
  for LI := 0 to Count - 1 do
    if TSelCtrlItem(FItems[LI]).Control = AControl then
    begin
      Result := LI;
      Break;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.DeferPos(hWnd, hPnt, hWndInsertAfter: HWND; x, y, cx,
  cy: Integer; uFlags: UINT);
var
  i:   Integer;
  itm: TDeferItem;
begin
  itm := nil;

  for i := 0 to FDefers.Count - 1 do
    if (TDeferItem(FDefers[i]).Parent = hPnt) then
    begin
      itm := TDeferItem(FDefers[i]);
      Break; // for
    end;

  if itm = nil then
  begin
    itm        := TDeferItem.Create;
    itm.Parent := hPnt;
    itm.DWP    := BeginDeferWindowPos(0);
    FDefers.Add(itm);
  end;

  itm.DWP := DeferWindowPos(itm.DWP, hWnd, hWndInsertAfter, x, y,
                            cx, cy, uFlags);
  if itm.DWP = 0 then
    RaiseLastOSError;
end;

procedure TSelCtrls.Delete(AI: Integer);
begin
  TObject(FItems[AI]).Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.Remove(AControl: TControl);
var
  LI: Integer;
begin
  LI := IndexOf(AControl);
  if LI <> -1 then
    Delete(LI);
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.GetControls(AResult: TList);
var
  LI: Integer;
begin
  for LI := 0 to Count - 1 do
    AResult.Add(Items[LI]);
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.GetComps(AResult: TList);
var
  LI: Integer;
begin
  for LI := 0 to Count - 1 do
    AResult.Add(Comp[LI]);
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.ClearExcept(AControl: TControl);
var
  i:   Integer;
  lst: TList;
begin
  BeginUpdate;
  try
    lst := TList.Create;
    try
      for i := 0 to Count - 1 do
      begin
        if TSelCtrlItem(FItems[i]).Control <> AControl then
          lst.Add(FItems[i]);
      end;

      if lst.Count > 0 then
      begin
        BeginDefer;
        for i := 0 to lst.Count - 1 do                // Hide mouse handles
          TSelCtrlItem(lst[i]).SetMode(imNone, True); // to speedup their
                                                      // destruction.
        EndDefer;

        for i := 0 to lst.Count - 1 do
          TSelCtrlItem(lst[i]).Free;
      end;
    finally
      lst.Free;
    end;

    if Count = 0 then
    begin
      if AControl <> nil then
        Add(AControl);
    end
    else
    begin
      if FVisible and not (AControl is TNonvisualControl) and
         (AControl.Parent <> nil) then
        AControl.Show;
    end;
  finally
    EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.ClearNotChildrensOf(AParent: TWinControl);
var
  LI: Integer;
begin
  BeginUpdate;
  try
    for LI := Count - 1 downto 0 do
      if FDEng.GetControlParent(Items[LI]) <> AParent then
        Delete(LI);
  finally
    EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.Clear;
begin
  ClearExcept(nil);
end;

procedure TSelCtrls.ClearDeferItems;
var
  i: Integer;
begin
  for i := 0 to FDefers.Count - 1 do
    TObject(FDefers[i]).Free;
  FDefers.Clear;
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.BeginDefer;
begin
  ClearDeferItems;
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.EndDefer;
var
  i:   Integer;
  itm: TDeferItem;
begin
  try
    for i := 0 to FDefers.Count - 1 do
    begin
      itm := TDeferItem(FDefers[i]);
      if (itm.DWP <> 0) and not EndDeferWindowPos(itm.DWP) then
        RaiseLastOSError;
    end;
  finally
    ClearDeferItems;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.EndUpdate;
begin
  Dec(FUpdateCount);
  if (FUpdateCount = 0) and FChanged then
    Change;
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.Lock(ALockMode: TLMDDesignerLockMode);
var
  LI: Integer;
begin
  for LI := 0 to Count - 1 do
    FDEng.LockControl(Items[LI], ALockMode);
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.AlignToGrid;
var
  LI: Integer;
begin
  for LI := 0 to Count - 1 do
    FDEng.AlignToGrid(Items[LI]);
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.Align(AHorzAlign, AVertAlign: TLMDDesignerAlignType);

type
  _TEdges = (etLeft, etTop, etRight, etBottom);
  _TDirection = (dtHorz, dtVert);

  procedure _AlignAdges(AEdges: _TEdges);
  var
    LBase, LCur, LI: Integer;
  begin
    if Count < 2 then Exit;
    LBase := 0 + MaxInt * Ord(AEdges in [etLeft, etTop]);
    for LI := 0 to Count - 1 do
      begin
        LCur := 0; // Initialize
        case AEdges of
          etLeft:    LCur := Items[LI].Left;
          etTop:     LCur := Items[LI].Top;
          etRight:   LCur := Items[LI].Left + Items[LI].Width;
          etBottom:  LCur := Items[LI].Top + Items[LI].Height;
        end;
        if AEdges in [etLeft, etTop] then
          begin
            if LCur < LBase then LBase := LCur;
          end
        else
          if LCur > LBase then LBase := LCur;
      end;
    for LI := 0 to Count - 1 do
      begin
        case AEdges of
          etLeft:    Items[LI].Left := LBase;
          etTop:     Items[LI].Top := LBase;
          etRight:   Items[LI].Left := LBase - Items[LI].Width;
          etBottom:  Items[LI].Top := LBase - Items[LI].Height;
        end;
      end;
    FDEng.Modified;
  end;

  procedure _SpaceEqually(ADir: _TDirection);
  var
    LI: Integer;
    LMin, LMax, LCur: Integer;
    LControls: TList;
  begin
    if Count <= 2 then Exit;
    LControls := TList.Create;
    GetControls(LControls);
    try
      if ADir = dtHorz then
        begin
          LControls.Sort(AlignHorzSortProc);
          LMin := TControl(LControls[0]).Left;
          LMax := TControl(LControls[LControls.Count - 1]).Left;
        end
      else
        begin
          LControls.Sort(AlignVertSortProc);
          LMin := TControl(LControls[0]).Top;
          LMax := TControl(LControls[LControls.Count - 1]).Top;
        end;
      for LI := 1 to LControls.Count - 2 do
        begin
          LCur := LMin + Round(LI * (LMax - LMin) / (LControls.Count - 1));
          if ADir = dtHorz then
            TControl(LControls[LI]).Left := LCur
          else
            TControl(LControls[LI]).Top := LCur;
        end;
    finally
      LControls.Free;
    end;
    FDEng.Modified;
  end;

  procedure _SetCenters(ADir: _TDirection; AValue: Integer);
  var
    LI: Integer;
  begin
    for LI := 0 to Count - 1 do
      begin
        if ADir = dtHorz then
          Items[LI].Left := AValue - Items[LI].Width div 2
        else
          Items[LI].Top := AValue - Items[LI].Height div 2;
      end;
  end;

  procedure _Center(ADir: _TDirection);
  begin
    if Count < 2 then Exit;
    if ADir = dtHorz then
      _SetCenters(ADir, Items[0].Left + Items[0].Width div 2)
    else
      _SetCenters(ADir, Items[0].Top + Items[0].Height div 2);
    FDEng.Modified;
  end;

  procedure _CenterInWindow(ADir: _TDirection);
  begin
    if Count < 1 then Exit;
    if ADir = dtHorz then
      _SetCenters(ADir, Items[0].Parent.Width div 2)
    else
      _SetCenters(ADir, Items[0].Parent.Height div 2);
    FDEng.Modified;
  end;

begin
  if (DefControl <> nil) and
    (DefControl <> FDEng.FRoot) then
    begin
      ClearNotChildrensOf(FDEng.GetControlParent(DefControl));
      BeginUpdate;
      try
        case AHorzAlign of
          atLeftTop:         _AlignAdges(etLeft);
          atRightBottom:     _AlignAdges(etRight);
          atSpaceEqually:    _SpaceEqually(dtHorz);
          atCenter:          _Center(dtHorz);
          atCenterInWindow:  _CenterInWindow(dtHorz);
        end;
        case AVertAlign of
          atLeftTop:         _AlignAdges(etTop);
          atRightBottom:     _AlignAdges(etBottom);
          atSpaceEqually:    _SpaceEqually(dtVert);
          atCenter:          _Center(dtVert);
          atCenterInWindow:  _CenterInWindow(dtVert);
        end;
      finally
        FDEng.UpdateMouseHandles;
        EndUpdate;
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.BringToFront;
var
  LI: Integer;
begin
  for LI := 0 to Count - 1 do
    if Items[LI] <> FDEng.FRoot then
      Items[LI].BringToFront;
  FDEng.UpdateNonvisualControls;
  FDEng.Modified;
end;

{ ---------------------------------------------------------------------------- }
procedure TSelCtrls.SendToBack;
var
  LI: Integer;
begin
  for LI := 0 to Count - 1 do
    if (Items[LI] <> FDEng.FRoot) and
      not (Items[LI] is  TNonvisualControl) then
      Items[LI].SendToBack;
  FDEng.UpdateNonvisualControls;
  FDEng.Modified;
end;

{******************************** TEngDrawHandler *****************************}
{ ---------------------------------------------------------------------------- }
function TEngDrawHandler.VirtualizeCursor: TPoint;
var
  LR:        TRect;
  LAlignedX,
  LAlignedY: Boolean;
begin
  GetCursorPos(Result);

  LAlignedX := False;
  LAlignedY := False;
  if FDrawInited and FDEng.FDesigner.FShowAlignLines and
     GetRectForAlign(LR, Result) then // Provide non-aligned cursor here.
  begin
    if not FHasInitRectForAlign then
    begin
      FInitRectForAlign    := LR;
      FHasInitRectForAlign := True;
    end;

    if FHasInitRectForAlign and IsRectForAlignChanged(LR) then
      FAlignEnabled := True;

    if FAlignEnabled then
      GetAlignedCursor(LR, Result, LAlignedX, LAlignedY);
  end;

  if FSkipXCursorMoving then
    Result.X := FInitCursorPos.Y
  else if not LAlignedX and FSnapToGrid then
    Result.X := Round((Result.X - FInitCursorPos.X) / FDEng.FGrid.FXStep) *
                                          FDEng.FGrid.FXStep + FInitCursorPos.X;
  if FSkipYCursorMoving then
    Result.Y := FInitCursorPos.Y
  else if not LAlignedY and FSnapToGrid then
    Result.Y := Round((Result.Y - FInitCursorPos.Y) / FDEng.FGrid.FYStep) *
                                          FDEng.FGrid.FYStep + FInitCursorPos.Y;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngDrawHandler.GetAlignedCursor(const ACtrlRect: TRect;
  var ACursPos: TPoint; out AAlignedX, AAlignedY: Boolean);
const
  TRESHOLD = 5;
var
  LI:           Integer;
  LDX, LDY:     Integer;
  LR:           TRect;
  LAlignLeft,
  LAlignTop,
  LAlignRight,
  LAlignBottom: Boolean;
begin
  GetAlignParams(LAlignLeft, LAlignTop, LAlignRight, LAlignBottom);

  LDX := MaxInt;
  LDY := MaxInt;

  for LI := 0 to FAlignToList.Count - 1 do
  begin
    LR := TControl(FAlignToList[LI]).BoundsRect;

    if LAlignLeft and (Abs(LR.Left - ACtrlRect.Left) < Abs(LDX)) then
      LDX := LR.Left - ACtrlRect.Left;
    if LAlignRight and (Abs(LR.Right - ACtrlRect.Right) < Abs(LDX)) then
      LDX := LR.Right - ACtrlRect.Right;

    if LAlignTop and (Abs(LR.Top - ACtrlRect.Top) < Abs(LDY)) then
      LDY := LR.Top - ACtrlRect.Top;
    if LAlignBottom and (Abs(LR.Bottom - ACtrlRect.Bottom) < Abs(LDY)) then
      LDY := LR.Bottom - ACtrlRect.Bottom;
  end;

  AAlignedX := Abs(LDX) <= TRESHOLD;
  if AAlignedX then
    Inc(ACursPos.X, LDX);

  AAlignedY := Abs(LDY) <= TRESHOLD;
  if AAlignedY then
    Inc(ACursPos.Y, LDY);
end;

{ ---------------------------------------------------------------------------- }
function TEngDrawHandler.IsRectForAlignChanged(const LR: TRect): Boolean;
const
  TRESHOLD = 3;
begin
  Result := (Abs(FInitRectForAlign.Left - LR.Left) >= TRESHOLD) or
            (Abs(FInitRectForAlign.Top - LR.Top) >= TRESHOLD) or
            (Abs(FInitRectForAlign.Right - LR.Right) >= TRESHOLD) or
            (Abs(FInitRectForAlign.Bottom - LR.Bottom) >= TRESHOLD);
end;

{ ---------------------------------------------------------------------------- }
procedure TEngDrawHandler.FillAlignToList(AParent: TWinControl);
var
  LI:       Integer;
  LControl: TControl;
begin
  for LI := 0 to AParent.ControlCount - 1 do
  begin
    LControl := AParent.Controls[LI];

    if FDEng.IsDesignControl(LControl, False) and
       not (LControl is TNonvisualControl) and
       (FDEng.FSelCtrls.IndexOf(LControl) = -1) then
      FAlignToList.Add(LControl);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TEngDrawHandler.FindVisibleScreenRect(AClient: TWinControl;
  out ARect: TRect): Boolean;
var
  LR1, LR2: TRect;
begin
  LR1             := AClient.ClientRect;
  LR1.TopLeft     := AClient.ClientToScreen(LR1.TopLeft);
  LR1.BottomRight := AClient.ClientToScreen(LR1.BottomRight);

  LR2             := FDEng.FForm.ClientRect;
  LR2.TopLeft     := FDEng.FForm.ClientToScreen(LR2.TopLeft);
  LR2.BottomRight := FDEng.FForm.ClientToScreen(LR2.BottomRight);

  ARect.Left   := Max(LR1.Left, LR2.Left);
  ARect.Top    := Max(LR1.Top, LR2.Top);
  ARect.Right  := Min(LR1.Right, LR2.Right);
  ARect.Bottom := Min(LR1.Bottom, LR2.Bottom);

  Result := (ARect.Left <= ARect.Right) and (ARect.Top <= ARect.Bottom);
  if not Result then
    ARect := Rect(0, 0, 0, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TEngDrawHandler.UpdateAlignLines;

  procedure _MakeLine(AIsVertical: Boolean; AOrigin,
                      AC1, AC2, AC3, AC4: Integer);
  var
    LIdx:       Integer;
    LI:         Integer;
    LMin, LMax: Integer;
  begin
    { Find or create align line item }

    LIdx := -1;
    for LI := 0 to High(FAlignLines) do
      if (FAlignLines[LI].IsVertical = AIsVertical) and
         (FAlignLines[LI].Origin = AOrigin) then
      begin
        LIdx := LI;
        Break; // for
      end;

    if LIdx = -1 then
    begin
      SetLength(FAlignLines, Length(FAlignLines) + 1);
      LIdx := High(FAlignLines);

      FAlignLines[LIdx].IsVertical := AIsVertical;
      FAlignLines[LIdx].Origin     := AOrigin;
      FAlignLines[LIdx].Min        := MaxInt;
      FAlignLines[LIdx].Max        := -MaxInt;
    end;

    { Update min and max }

    LMin := Min(Min(Min(Min(FAlignLines[LIdx].Min, AC1), AC2), AC3), AC4);
    LMax := Max(Max(Max(Max(FAlignLines[LIdx].Max, AC1), AC2), AC3), AC4);

    FAlignLines[LIdx].Min := LMin;
    FAlignLines[LIdx].Max := LMax;
  end;

var
  LI:           Integer;
  LCtrlRect:    TRect;
  LR:           TRect;
  LAlignLeft,
  LAlignTop,
  LAlignRight,
  LAlignBottom: Boolean;
begin
  GetAlignParams(LAlignLeft, LAlignTop, LAlignRight, LAlignBottom);
  SetLength(FAlignLines, 0);

  if FDEng.FDesigner.FShowAlignLines and
     GetRectForAlign(LCtrlRect, FVirtCursor) then
    for LI := 0 to FAlignToList.Count - 1 do
    begin
      LR := TControl(FAlignToList[LI]).BoundsRect;

      if LAlignLeft and (LR.Left = LCtrlRect.Left) then
        _MakeLine(True, LR.Left - 1, LR.Top, LR.Bottom, LCtrlRect.Top,
                  LCtrlRect.Bottom);

      if LAlignTop and (LR.Top = LCtrlRect.Top) then
        _MakeLine(False, LR.Top - 1, LR.Left, LR.Right, LCtrlRect.Left,
                  LCtrlRect.Right);

      if LAlignRight and (LR.Right = LCtrlRect.Right) then
        _MakeLine(True, LR.Right, LR.Top, LR.Bottom, LCtrlRect.Top,
                  LCtrlRect.Bottom);

      if LAlignBottom and (LR.Bottom = LCtrlRect.Bottom) then
        _MakeLine(False, LR.Bottom, LR.Left, LR.Right, LCtrlRect.Left,
                  LCtrlRect.Right);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngDrawHandler.XORDrawAlignLines;
var
  LI:         Integer;
  LFrom, LTo: TPoint;
begin
  for LI := 0 to High(FAlignLines) do
  begin
    if FAlignLines[LI].IsVertical then
    begin
      LFrom := Point(FAlignLines[LI].Origin, FAlignLines[LI].Min);
      LTo   := Point(FAlignLines[LI].Origin, FAlignLines[LI].Max);
    end
    else
    begin
      LFrom := Point(FAlignLines[LI].Min, FAlignLines[LI].Origin);
      LTo   := Point(FAlignLines[LI].Max, FAlignLines[LI].Origin);
    end;

    DrawAlignLine(LFrom, LTo, FCanvas);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngDrawHandler.GetParams(out AEnableSnapToGrid,
  ASnapToGridFirstCursorPos: Boolean);
begin
  AEnableSnapToGrid         := False;
  ASnapToGridFirstCursorPos := False;
end;

{ ---------------------------------------------------------------------------- }
function TEngDrawHandler.GetRectForAlign(out ARect: TRect;
  const AVirtCurs: TPoint): Boolean;
begin
  Result := False;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngDrawHandler.GetAlignParams(out ALeft, ATop, ARight,
  ABottom: Boolean);
begin
  ALeft   := True;
  ATop    := True;
  ARight  := True;
  ABottom := True;
end;

{ ---------------------------------------------------------------------------- }
constructor TEngDrawHandler.Create(ADEng: TEngine;
  AControlToDrawOn: TWinControl; ASkipXCursorMoving,
  ASkipYCursorMoving: Boolean);
var
  LEnableSnap,
  LSnapFirstCurs: Boolean;
begin
  inherited Create;
  FDEng        := ADEng;
  FCanvas      := TEngCanvas.Create(ADEng);
  FAlignToList := TList.Create;

  FDEng.FHint.CancelHint;
  FDEng.FForm.Update;

  GetParams(LEnableSnap, LSnapFirstCurs);

  FCanvas.WinControl   := AControlToDrawOn;
  FSnapToGrid          := LEnableSnap and FDEng.FDesigner.FSnapToGrid;
  FSkipXCursorMoving   := ASkipXCursorMoving;
  FSkipYCursorMoving   := ASkipYCursorMoving;
  FHasInitRectForAlign := False;

  FillAlignToList(AControlToDrawOn);

  GetCursorPos(FInitCursorPos);
  if FSnapToGrid and LSnapFirstCurs then
  begin
    FInitCursorPos := FDEng.FForm.ScreenToClient(FInitCursorPos);

    FInitCursorPos.x := ((FInitCursorPos.x +
      FDEng.FForm.HorzScrollBar.ScrollPos) div
      FDEng.FGrid.FXStep) * FDEng.FGrid.FXStep -
      FDEng.FForm.HorzScrollBar.ScrollPos;
    FInitCursorPos.y := ((FInitCursorPos.y +
      FDEng.FForm.VertScrollBar.ScrollPos) div
      FDEng.FGrid.FYStep) * FDEng.FGrid.FYStep -
      FDEng.FForm.VertScrollBar.ScrollPos;

    FInitCursorPos := FDEng.FForm.ClientToScreen(FInitCursorPos);
  end;
end;

{ ---------------------------------------------------------------------------- }
destructor TEngDrawHandler.Destroy;
begin
  FCanvas.Free;
  FAlignToList.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngDrawHandler.InitDraw;
var
  LR: TRect;
begin
  FInitCursorPos := VirtualizeCursor;

  SetCaptureControl(FDEng.FRoot);
  if FindVisibleScreenRect(FCanvas.WinControl, LR) then
    ClipCursor(@LR);

  FVirtCursor        := FInitCursorPos;
  FLastVirtCursorPos := FInitCursorPos;
  
  DoInitDraw;
  FDrawInited := True;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngDrawHandler.MoveDraw;
begin
  FVirtCursor := VirtualizeCursor;

  if (FLastVirtCursorPos.X <> FVirtCursor.X) or
     (FLastVirtCursorPos.Y <> FVirtCursor.Y) then
    DoMoveDraw;

  FLastVirtCursorPos := FVirtCursor;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngDrawHandler.FinDraw(AApply: Boolean);
begin
  if GetCaptureControl = FDEng.FRoot then
    SetCaptureControl(nil);
  ClipCursor(nil);

  DoClearDraw;
  if AApply then
    DoApply;
end;

{******************************* TEngSelectHandler ****************************}
{ ---------------------------------------------------------------------------- }
procedure TEngSelectHandler.XORDraw;
var
  LR: TRect;
begin
  LR := RectFromPoints(FPointA, FPointB);
  Inc(LR.Right);
  Inc(LR.Bottom);

  DrawSelectRect(LR, Canvas);
end;

{ ---------------------------------------------------------------------------- }
procedure TEngSelectHandler.DoInitDraw;
begin
  FPointA := FCanvas.ScreenToClient(VirtCursor);
  FPointB := FPointA;

  XORDraw;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngSelectHandler.DoMoveDraw;
begin
  XORDraw;
  FPointA := FCanvas.ScreenToClient(VirtCursor);
  XORDraw;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngSelectHandler.DoClearDraw;
begin
  XORDraw;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngSelectHandler.DoApply;
var
  LI:          Integer;
  LSelectRect: TRect;
  LControl:    TControl;
begin
  LSelectRect := RectFromPoints(FPointA, FPointB);

  FDEng.FSelCtrls.BeginUpdate;
  try
    for LI := 0 to FCanvas.WinControl.ControlCount - 1 do
    begin
      LControl := FCanvas.WinControl.Controls[LI];

      if IsRectCrossed(LControl.BoundsRect, LSelectRect) and
         FDEng.IsDesignControl(LControl) then
        FDEng.FSelCtrls.Add(LControl);
    end;

    for LI := 0 to FDEng.FNonvisualControls.Count - 1 do
      if TNonvisualControl(FDEng.FNonvisualControls[LI]).Component.Owner =
                                                        FCanvas.WinControl then
      begin
        LControl := TControl(FDEng.FNonvisualControls[LI]);
        if IsRectCrossed(LControl.BoundsRect, LSelectRect) and
           FDEng.IsDesignControl(LControl) then
          FDEng.FSelCtrls.Add(LControl);
      end;

    if FDEng.FSelCtrls.Count > 1 then
      FDEng.FSelCtrls.Remove(FDEng.FRoot);
  finally
    FDEng.FSelCtrls.EndUpdate;
  end;
end;

{******************************* TEngMoveHandler ******************************}
{ ---------------------------------------------------------------------------- }
function TEngMoveHandler.AdjustOffset(const AVirtCursorPos: TPoint): TPoint;
begin
  Result := FCanvas.ScreenToClient(AVirtCursorPos);
  Dec(Result.X, FStartClientCursorPos.X);
  Dec(Result.Y, FStartClientCursorPos.Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TEngMoveHandler.XORDraw;
var
  LI: Integer;
  LR: TRect;
begin
  for LI := 0 to FControlList.Count - 1 do
  begin
    LR := TControl(FControlList[LI]).BoundsRect;
    OffsetRect(LR, FOffset.x, FOffset.y);

    DrawControlRect(LR, Canvas);
  end;

  XORDrawAlignLines;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngMoveHandler.ShowHint(P: TPoint);
begin
  if dhMove in FDEng.FDesigner.Hints then
  begin
    FDEng.FHint.ActivateHint(False, False, False, nil,
                             Format('%d, %d', [P.X, P.Y]));
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngMoveHandler.GetParams(out AEnableSnapToGrid,
  ASnapToGridFirstCursorPos: Boolean);
begin
  AEnableSnapToGrid         := True;
  ASnapToGridFirstCursorPos := False;
end;

{ ---------------------------------------------------------------------------- }
function TEngMoveHandler.GetRectForAlign(out ARect: TRect;
  const AVirtCurs: TPoint): Boolean;
var
  LOffset: TPoint;
begin
  LOffset := AdjustOffset(AVirtCurs);
  Result  := (FControlList.Count > 0);

  if Result then
  begin
    ARect := TControl(FControlList[0]).BoundsRect;
    OffsetRect(ARect, LOffset.X, LOffset.Y);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngMoveHandler.DoInitDraw;
begin
  FOffset               := Point(0, 0);
  FStartClientCursorPos := FCanvas.ScreenToClient(VirtCursor);
  UpdateAlignLines;

  XORDraw;
  ShowHint(Point(FMinLeftTop.X + FOffset.X,
                 FMinLeftTop.Y + FOffset.Y));
end;

{ ---------------------------------------------------------------------------- }
procedure TEngMoveHandler.DoMoveDraw;
begin
  FDEng.FHint.CancelHint;
  XORDraw;

  FOffset := AdjustOffset(VirtCursor);
  UpdateAlignLines;

  XORDraw;
  ShowHint(Point(FMinLeftTop.X + FOffset.X,
                 FMinLeftTop.Y + FOffset.Y));
end;

{ ---------------------------------------------------------------------------- }
procedure TEngMoveHandler.DoClearDraw;
begin
  FDEng.FHint.CancelHint;
  XORDraw;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngMoveHandler.DoApply;
var
  LI:         Integer;
  LControl:   TControl;
  LNewBounds: TRect;
begin
  if (FOffset.X = 0) and (FOffset.Y = 0) then
    Exit;

  for LI := 0 to FControlList.Count - 1 do
  begin
    LControl := TControl(FControlList[LI]);

    LNewBounds := LControl.BoundsRect;
    OffsetRect(LNewBounds, FOffset.X, FOffset.Y);

    with LNewBounds do
      LControl.SetBounds(Left, Top, Right - Left, Bottom - Top);
  end;

  FDEng.Modified;
end;

{ ---------------------------------------------------------------------------- }
constructor TEngMoveHandler.Create(ADEng: TEngine;
  AControlToDrawOn: TWinControl; ASkipXCursorMoving,
  ASkipYCursorMoving: Boolean);
var
  LI:       Integer;
  LControl: TControl;
  LR:       TRect;
begin
  inherited;
  FControlList := TList.Create;
  FMinLeftTop  := Point(MaxInt, MaxInt);

  for LI := 0 to FDEng.FSelCtrls.Count - 1 do
  begin
    LControl := FDEng.FSelCtrls[LI];

    if not (lmNoMove in FDEng.GetLockMode(LControl)) then
    begin
      FControlList.Add(LControl);

      LR := LControl.BoundsRect;
      if FMinLeftTop.X > LR.Left then FMinLeftTop.X := LR.Left;
      if FMinLeftTop.Y > LR.Top then  FMinLeftTop.Y := LR.Top;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
destructor TEngMoveHandler.Destroy;
begin
  FControlList.Free;
  inherited;
end;

{****************************** TEngResizeHandler *****************************}
{ ---------------------------------------------------------------------------- }
function TEngResizeHandler.GetDrawRect(const AOffset: TPoint): TRect;
begin
  Result := FControl.BoundsRect;

  Result.Left   := Result.Left + AOffset.X *
                   Ord(FPointPosition in [ppTopLeft, ppBottomLeft, ppLeft]);
  Result.Top    := Result.Top + AOffset.Y *
                   Ord(FPointPosition in [ppTopLeft, ppTop, ppTopRight]);
  Result.Right  := Result.Right + AOffset.X *
                   Ord(FPointPosition in [ppTopRight, ppRight, ppBottomRight]);
  Result.Bottom := Result.Bottom + AOffset.Y *
                   Ord(FPointPosition in [ppBottomRight, ppBottom, ppBottomLeft]);

  Result := RectFromPoints(Result.TopLeft, Result.BottomRight);
end;

{ ---------------------------------------------------------------------------- }
function TEngResizeHandler.AdjustOffset(const AVirtCursorPos: TPoint): TPoint;
begin
  Result := FCanvas.ScreenToClient(AVirtCursorPos);
  Dec(Result.X, FStartClientCursorPos.X);
  Dec(Result.Y, FStartClientCursorPos.Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TEngResizeHandler.XORDraw(R: TRect);
begin
  DrawControlRect(R, Canvas);
  XORDrawAlignLines;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngResizeHandler.ShowHint(R: TRect);
begin
  if dhSize in FDEng.FDesigner.Hints then
  begin
    FDEng.FHint.ActivateHint(False, False, False, nil,
                             Format('%d x %d', [R.Right - R.Left,
                                                R.Bottom - R.Top]));
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngResizeHandler.GetParams(out AEnableSnapToGrid,
  ASnapToGridFirstCursorPos: Boolean);
begin
  AEnableSnapToGrid         := True;
  ASnapToGridFirstCursorPos := False;
end;

{ ---------------------------------------------------------------------------- }
function TEngResizeHandler.GetRectForAlign(out ARect: TRect;
  const AVirtCurs: TPoint): Boolean;
var
  LOffset: TPoint;
begin
  LOffset := AdjustOffset(AVirtCurs);
  ARect   := GetDrawRect(LOffset);
  Result  := True;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngResizeHandler.GetAlignParams(out ALeft, ATop, ARight,
  ABottom: Boolean);
begin
  ALeft    := FPointPosition in [ppTopLeft, ppLeft, ppBottomLeft];
  ATop     := FPointPosition in [ppTopLeft, ppTop, ppTopRight];
  ARight   := FPointPosition in [ppTopRight, ppRight, ppBottomRight];
  ABottom  := FPointPosition in [ppBottomRight, ppBottom, ppBottomLeft];
end;

{ ---------------------------------------------------------------------------- }
procedure TEngResizeHandler.DoInitDraw;
var
  LR: TRect;
begin
  FStartClientCursorPos := FCanvas.ScreenToClient(VirtCursor);
  FOffset               := AdjustOffset(VirtCursor);
  UpdateAlignLines;

  LR := GetDrawRect(FOffset);
  XORDraw(LR);
  ShowHint(LR);
end;

{ ---------------------------------------------------------------------------- }
procedure TEngResizeHandler.DoMoveDraw;
var
  LR: TRect;
begin
  FDEng.FHint.CancelHint;
  XORDraw(GetDrawRect(FOffset));

  FOffset := AdjustOffset(VirtCursor);
  UpdateAlignLines;

  LR := GetDrawRect(FOffset);
  XORDraw(LR);
  ShowHint(LR);
end;

{ ---------------------------------------------------------------------------- }
procedure TEngResizeHandler.DoClearDraw;
begin
  FDEng.FHint.CancelHint;
  XORDraw(GetDrawRect(FOffset));
end;

{ ---------------------------------------------------------------------------- }
procedure TEngResizeHandler.DoApply;
var
  LR, LOld: TRect;
begin
  LR   := GetDrawRect(FOffset);
  LOld := FControl.BoundsRect;

  if (LR.Left <> LOld.Left) or (LR.Top <> LOld.Top) or
     (LR.Right <> LOld.Right) or (LR.Bottom <> LOld.Bottom) then
    begin
      with LR do
        FControl.SetBounds(Left, Top, Right - Left, Bottom - Top);

      FControl.Update;
      FDEng.Modified;
    end;
end;

{ ---------------------------------------------------------------------------- }
constructor TEngResizeHandler.Create(ADEng: TEngine;
  AControlToDrawOn: TWinControl; ASkipXCursorMoving,
  ASkipYCursorMoving: Boolean);
begin
  inherited;

  FControl       := FDEng.FSelCtrls[0];
  FPointPosition := TSelCtrlItem(FDEng.FSelCtrls.FItems[0]).FActivePos;
end;

{******************************* TEngInsertHandler ****************************}
{ ---------------------------------------------------------------------------- }
function TEngInsertHandler.GetDrawRect(const AOffset: TPoint): TRect;
begin
  Result := RectFromPoints(FStartClientCursorPos,
                           Point(FStartClientCursorPos.X + AOffset.X,
                                 FStartClientCursorPos.Y + AOffset.Y));
  Inc(Result.Right);
  Inc(Result.Bottom);
end;

{ ---------------------------------------------------------------------------- }
function TEngInsertHandler.AdjustOffset(const AVirtCursorPos: TPoint): TPoint;
begin
  Result := FCanvas.ScreenToClient(AVirtCursorPos);
  Dec(Result.X, FStartClientCursorPos.X);
  Dec(Result.Y, FStartClientCursorPos.Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TEngInsertHandler.XORDraw(R: TRect);
begin
  DrawControlRect(R, Canvas);
  XORDrawAlignLines;
  FDrawn := True;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngInsertHandler.ShowHint(R: TRect);
begin
  if dhInsert in FDEng.FDesigner.Hints then
  begin
      FDEng.FHint.ActivateHint(False, False, False, nil,
                               Format('%d x %d', [R.Right - R.Left,
                                                  R.Bottom - R.Top]));
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngInsertHandler.GetParams(out AEnableSnapToGrid,
  ASnapToGridFirstCursorPos: Boolean);
begin
  AEnableSnapToGrid         := True;
  ASnapToGridFirstCursorPos := True;
end;

{ ---------------------------------------------------------------------------- }
function TEngInsertHandler.GetRectForAlign(out ARect: TRect;
  const AVirtCurs: TPoint): Boolean;
{var
  LOffset: TPoint;}
begin
  // No align on insertion. Otherwise it is too common to
  // insert a control with very small dimentions, because of
  // aligning.

 {LOffset := AdjustOffset(AVirtCurs);
  ARect   := GetDrawRect(LOffset);
  Result  := True;}

  Result := False;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngInsertHandler.DoInitDraw;
begin
  FStartClientCursorPos := FCanvas.ScreenToClient(VirtCursor);
  FOffset               := AdjustOffset(VirtCursor);
  FDrawn                := False;

  // No drawing here.
end;

{ ---------------------------------------------------------------------------- }
procedure TEngInsertHandler.DoMoveDraw;
var
  LR: TRect;
begin
  FDEng.FHint.CancelHint;

  if FDrawn then
    XORDraw(GetDrawRect(FOffset));

  FOffset := AdjustOffset(VirtCursor);
  UpdateAlignLines;

  LR := GetDrawRect(FOffset);
  XORDraw(LR);
  ShowHint(LR);
end;

{ ---------------------------------------------------------------------------- }
procedure TEngInsertHandler.DoClearDraw;
begin
  FDEng.FHint.CancelHint;
  if FDrawn then
    XORDraw(GetDrawRect(FOffset));
end;

{ ---------------------------------------------------------------------------- }
procedure TEngInsertHandler.DoApply;
var
  LR:       TRect;
  LInsComp: TComponent;
  LName:    TLMDString;
  LControl: TControl;
begin
  LR       := GetDrawRect(FOffset);
  LInsComp := FDEng.FInsertingComponentClass.Create(FDEng.FRoot);

  try
    with LInsComp do
    begin
      LName := FDEng.UniqueName(FDEng.FInsertingComponentClass.ClassName);
      Name  := LName; // Here may be exception.

      LControl := FDEng.FindControl(LInsComp);

      if LControl <> nil then
      begin
        with LR do
          if (Right - Left > 1) or (Bottom - Top > 1) then
            LControl.SetBounds(Left, Top, Right - Left, Bottom - Top)
          else
            LControl.SetBounds(Left, Top, LControl.Width, LControl.Height);
      end;

      if LInsComp is TControl then
        TControl(LInsComp).Parent := FCanvas.WinControl; // Here may be exception.

      if LControl <> nil then
        FDEng.FSelCtrls.ClearExcept(LControl);
    end;
  except
    LInsComp.Free;
    raise;
  end;

  FDEng.FDesigner.ComponentInserted;
  FDEng.UpdateDesignerAllComponents;
  FDEng.Modified;
end;

{ ****************************** TEngCompNotifier **************************** }
{ ------------------------------ protected ----------------------------------- }
procedure TEngCompNotifier.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  FDEng.Notification(AComponent, Operation);

  if Operation = opRemove then
    RemoveComp(AComponent);
end;

{ ---------------------------------------------------------------------------- }
constructor TEngCompNotifier.Create(ADEng: TEngine);
begin
  inherited Create(nil);
  FDEng  := ADEng;
  FComps := TList.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TEngCompNotifier.Destroy;
begin
  Clear;
  FComps.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngCompNotifier.AddComp(AComp: TComponent);
begin
  if FComps.IndexOf(AComp) = -1 then
  begin
    AComp.FreeNotification(Self);
    FComps.Add(AComp);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngCompNotifier.RemoveComp(AComp: TComponent);
begin
  AComp.RemoveFreeNotification(Self);
  FComps.Remove(AComp);
end;

{ ---------------------------------------------------------------------------- }
procedure TEngCompNotifier.Clear;
var
  LComp: TComponent;
begin
  while FComps.Count > 0 do
  begin
    LComp := TComponent(FComps[0]);

    if LComp <> nil then
      RemoveComp(LComp);
  end;
end;

{ *********************** class TLMDCustomDesigner *************************** }
{ ------------------------------ private ------------------------------------- }
procedure TLMDCustomDesigner.GridParamsChanged;
begin
  if Active then TEngine(FEng).GridParamsChanged;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.RegisterClipboardFormat;
begin
  if not FClipbrdFormatRegistered then
  begin
    FClipboardFormatWord := Windows.{$IFDEF LMD_UNICODE}RegisterClipboardFormatW
                                    {$ELSE}RegisterClipboardFormat{$ENDIF}(
      PLMDChar(FClipboardFormat));

    FClipbrdFormatRegistered := True;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.ContextPopup(AMousePos: TPoint);
var
  LHandled:       Boolean;
  LPopupMenu:     TPopupMenu;
  LIsDefaultMenu: Boolean;
  LControl:       TControl;
  LSelCtrls:      TSelCtrls;
  LSvc:           ILMDObjEditService;
  LComp:          TComponent;
begin
  FTempMenu.Free;   // Destroy previous implicit menu.
  FTempMenu := nil; //

  LHandled := False;
  DoContextPopup(AMousePos, LHandled);
  if LHandled then
    Exit;

  LPopupMenu     := GetPopupMenu;
  LIsDefaultMenu := (LPopupMenu = nil);
  if LIsDefaultMenu then
  begin
    FTempMenu  := TPopupMenu.Create(nil);
    LPopupMenu := FTempMenu;
  end;
    
  if LPopupMenu.AutoPopup then
  begin
    LSelCtrls := TEngine(FEng).FSelCtrls;

    { Calc popup point }

    if (AMousePos.X = -1) and (AMousePos.Y = -1) then
    begin
      if ComponentContextPopup and (LSelCtrls.Count = 1) and
         (LSelCtrls.DefComp <> TEngine(FEng).FRoot) then
      begin
        LControl  := LSelCtrls.DefControl;
        AMousePos := LControl.ClientToScreen(Point(LControl.Width, 0));
      end
      else
        AMousePos := TEngine(FEng).FForm.ClientToScreen(Point(0, 0));
    end;

    { Adjust menu }

    if LIsDefaultMenu or (dmoAddDefaultItems in FMenuOptions) then
      AddDefaultMenuItems(LPopupMenu)
    else
      ClearTempMenuItems(LPopupMenu);

    if (dmoAddCompEditorItems in FMenuOptions) and
       (dsoUseObjEditService in FServiceOptions) and
       LMDTryGetService(FServiceProvider, ILMDObjEditService, LSvc) then
    begin
      LComp := LSelCtrls.DefComp;
      LSvc.AdjustMenu(Self, LComp, LPopupMenu);
    end;

    { Do popup }

    LPopupMenu.PopupComponent := Self;
    LPopupMenu.Popup(AMousePos.X, AMousePos.Y);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.AddDefaultMenuItems(AMenu: TPopupMenu);

  function _CreateItem(const S: TLMDString;
                       AAction: TDesignerMenuItemAction): TDesignerMenuItem;
  begin
    Result := TDesignerMenuItem.Create(Self);
    try
      Result.Designer  := Self;
      Result.Caption   := S;
      Result.Action    := AAction;

      Result.UpdateState;
    except
      Result.Free;
      raise;
    end;
  end;

var
  needsep: Boolean;
begin
  ClearTempMenuItems(AMenu);

  needsep := (AMenu.Items.Count > 0);

  AMenu.Items.Add(_CreateItem('Cut', miaCut));
  AMenu.Items.Add(_CreateItem('Copy', miaCopy));
  AMenu.Items.Add(_CreateItem('Paste', miaPaste));
  AMenu.Items.Add(_CreateItem('-', miaNone));
  AMenu.Items.Add(_CreateItem('Select all', miaSelectAll));

  if needsep then
    AMenu.Items.Add(_CreateItem('-', miaNone));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.ClearTempMenuItems(AMenu: TPopupMenu);

  procedure _Iterate(AParent: TMenuItem);
  var
    i:    Integer;
    item: TMenuItem;
  begin
    for i := AParent.Count - 1 downto 0 do
    begin
      item := AParent[i];

      if item is TDesignerMenuItem then
        item.Free
      else
        _Iterate(item);
    end;
  end;

begin
  _Iterate(AMenu.Items);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesigner.DoKeyDown(var AMessage: TWMKey): Boolean;
var
  LShiftState: TShiftState;
  LChar: Word;
begin
  Result := True;

  with AMessage do
    begin
      LShiftState := KeyDataToShiftState(KeyData);
      LChar := CharCode;
      KeyDown(LChar, LShiftState);
      CharCode := LChar;

      if CharCode = 0 then
        Exit;
    end;

  Result := False;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesigner.DoKeyPress(var AMessage: TWMKey): Boolean;
var
  LChar: Char;
begin
  Result := True;

  with AMessage do
    begin
      LChar := Char(CharCode);
      KeyPress(LChar);
      CharCode := Ord(LChar);

      if LChar = #0 then
        Exit;
    end;

  Result := False;  
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesigner.DoKeyUp(var AMessage: TWMKey): Boolean;
var
  LShiftState: TShiftState;
  LChar: Word;
begin
  Result := True;

  with AMessage do
    begin
      LShiftState := KeyDataToShiftState(KeyData);
      LChar := CharCode;
      KeyUp(LChar, LShiftState);
      CharCode := LChar;

      if CharCode = 0 then
        Exit;
    end;

  Result := False;  
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetActive(const Value: Boolean);
var
  LI:    Integer;
  LList: TList;
begin
  if FActive = Value then
    Exit;

  if Value then
  begin
    if (FModule = nil) or (FModule.Root = nil) then
      raise ELMDDesigner.Create(SLMDDsgnrMisingDesignCtrl);

    if (FSelection = nil) then
      raise ELMDDesigner.Create(SLMDDsgnrMisingSelection);

    if not (FModule.Root is TCustomForm) then
    begin
      if FModule.Root.Parent <> nil then
         raise ELMDDesigner.Create(SLMDDsgnrRootHaveParent);
      if FDesignPanel = nil then
        raise ELMDDesigner.Create(SLMDDsgnrMisingDesignPanel);
    end;

    if (FDesignPanel <> nil) and FDesignPanel.IsUsed then
      raise ELMDDesigner.CreateFmt(SLMDDsgnrDesignPanelIsUsed,
                                   [FDesignPanel.Name]);

    FEng := TEngine.Create(Self, FModule.Root, FDesignPanel);
  end
  else
  begin
    FEng.Free;
    FEng := nil;
  end;

  FActive := Value;

  if FActive then
  begin
    TEngine(FEng).ClearLocks;
    TEngine(FEng).UpdateEngineSelection;
    TEngine(FEng).UpdateDesignerAllComponents;
  end;

  { Send services notifications }

  if FServiceProvider <> nil then
  begin
    LList := FServiceProvider.Notifiers.GetList(ILMDDesignerNotifier);
    try
      for LI := 0 to LList.Count - 1 do
        ILMDDesignerNotifier(LList[LI]).ActiveChanged(Self);
      for LI := 0 to LList.Count - 1 do
        if FActive and TEngine(FEng).Focused then
          ILMDDesignerNotifier(LList[LI]).Focus(Self);
    finally
      LList.Free;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetSelection(const Value: TLMDDesignObjects);
begin
  CheckActive(False);
  if FSelection = Value then
    Exit;

  if (Value <> nil) and (Value = FAllComponents) then
    raise ELMDDesigner.Create(SLMDDsgnrSameCollections);

  if FSelection <> nil then
  begin
    FSelection.RemoveFreeNotification(Self);
    FSelection.RemoveNotifier(TSelnNotifier(FSelnNotifier));
  end;
  FSelection := Value;
  if FSelection <> nil then
  begin
    FSelection.FreeNotification(Self);
    FSelection.AddNotifier(TSelnNotifier(FSelnNotifier));
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetAllComponents(
  const Value: TLMDDesignObjects);
begin
  CheckActive(False);
  if FAllComponents = Value then
    Exit;

  if (Value <> nil) and (Value = FSelection) then
    raise ELMDDesigner.Create(SLMDDsgnrSameCollections);

  if FAllComponents <> nil then
    FAllComponents.RemoveFreeNotification(Self);
  FAllComponents := Value;
  if FAllComponents <> nil then
    FAllComponents.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetExcludeRoot(const Value: Boolean);
begin
  if FExcludeRoot <> Value then
  begin
    FExcludeRoot := Value;
    if FActive then
      TEngine(FEng).UpdateDesignerAllComponents;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetModule(const Value: TLMDModule);
begin
  CheckActive(False);
  if FModule = Value then
    Exit;

  if FModule <> nil then
  begin
    FModule.RemoveFreeNotification(Self);
    FModule.RemoveNotifier(FModuleNotifier);
  end;
  FModule := Value;
  if FModule <> nil then
  begin
    FModule.FreeNotification(Self);
    FModule.AddNotifier(FModuleNotifier);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetDesignPanel(const Value: TLMDCustomDesignPanel);
begin
  CheckActive(False);

  if FDesignPanel <> Value then
  begin
    if FDesignPanel <> nil then
      FDesignPanel.RemoveFreeNotification(Self);
    FDesignPanel := Value;
    if FDesignPanel <> nil then
      FDesignPanel.FreeNotification(Self);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesigner.GetRootVisible: Boolean;
begin
  CheckActive(True);
  Result := TEngine(FEng).RootVisible;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetRootVisible(const Value: Boolean);
begin
  CheckActive(True);
  TEngine(FEng).RootVisible := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetPopupMenu(const Value: TPopupMenu);
begin
  FPopupMenu := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetHandleBorderClr(const Value: TColor);
begin
  FHandleBorderClr := Value;
  if Active then
    TEngine(FEng).UpdateMouseHandles;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetHandleClr(const Value: TColor);
begin
  FHandleClr := Value;
  if Active then
    TEngine(FEng).UpdateMouseHandles;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetInactiveHandleBorderClr(const Value: TColor);
begin
  FInactiveHandleBorderClr := Value;
  if Active then
    TEngine(FEng).UpdateMouseHandles;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetInactiveHandleClr(const Value: TColor);
begin
  FInactiveHandleClr := Value;
  if Active then
    TEngine(FEng).UpdateMouseHandles;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetLockedHandleClr(const Value: TColor);
begin
  FLockedHandleClr := Value;
  if Active then
    TEngine(FEng).UpdateMouseHandles;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetMultySelectHandleBorderClr(const Value: TColor);
begin
  FMultySelectHandleBorderClr := Value;
  if Active then
    TEngine(FEng).UpdateMouseHandles;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetMultySelectHandleClr(const Value: TColor);
begin
  FMultySelectHandleClr := Value;
  if Active then
    TEngine(FEng).UpdateMouseHandles;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetClipboardFormat(const Value: TLMDString);
begin
  if FClipboardFormat = Value then
    Exit;
  FClipboardFormat         := Value;
  FClipbrdFormatRegistered := False;
  RegisterClipboardFormat;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetGrid(const Value: TLMDDesignerGrid);
begin
  FGrid.Assign(Value);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesigner.GetFocused: Boolean;
begin
  Result := Active and TEngine(FEng).Focused;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesigner.IsDefaultFormat: Boolean;
begin
  Result := FClipboardFormat <> LMDDefaultDsgnrClipboardFmt;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetShowNonvisualComponents(
  const Value: Boolean);
begin
  if FShowNonvisualComponents <> Value then
  begin
    FShowNonvisualComponents := Value;

    if Active then
    begin
      if Value then
        TEngine(FEng).RecreateNonvisualControls
      else
        TEngine(FEng).ClearNonvisualControls;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetShowComponentCaptions(
  const Value: Boolean);
begin
  if FShowComponentCaptions <> Value then
  begin
    FShowComponentCaptions := Value;
    if Active then
      TEngine(FEng).UpdateNonvisualControls;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetComponentCaptionsFont(const Value: TFont);
begin
  FComponentCaptionsFont.Assign(Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetNonvisualComponentImages(
  const Value: TImageList);
begin
  if FNonvisualComponentImages <> Value then
  begin
    if FNonvisualComponentImages <> nil then
    begin
      FNonvisualComponentImages.RemoveFreeNotification(Self);
      FNonvisualComponentImages.UnRegisterChanges(FNonvisualCompImagesChangeLink);
    end;

    FNonvisualComponentImages := Value;

    if FNonvisualComponentImages <> nil then
    begin
      FNonvisualComponentImages.FreeNotification(Self);
      FNonvisualComponentImages.RegisterChanges(FNonvisualCompImagesChangeLink);
    end;

    if Active then
      TEngine(FEng).RepaintNonvisualControls;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetNonvisualComponentWidth(const Value: Integer);
begin
  if FNonvisualComponentWidth <> Value then
  begin
    FNonvisualComponentWidth := Value;
    if Active then
      TEngine(FEng).UpdateNonvisualControls;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetNonvisualComponentHeight(const Value: Integer);
begin
  if FNonvisualComponentHeight <> Value then
  begin
    FNonvisualComponentHeight := Value;
    if Active then
      TEngine(FEng).UpdateNonvisualControls;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.HiddenClassesChanged;
begin
  if (FEng <> nil) and FShowNonvisualComponents then
    TEngine(FEng).RecreateNonvisualControls;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesigner.IsComponentHidden(AComponent: TComponent): Boolean;
var
  LCls:  TComponentClass;
  LShow: Boolean;
begin
  LCls  := TComponentClass(AComponent.ClassType);
  LShow := (FHiddenClasses.IndexOf(LCls) = -1);

  DoShowNonvisualComponent(AComponent, LShow);
  Result := not LShow;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.NonvisualCompImagesChange(Sender: TObject);
begin
  if Active then
    TEngine(FEng).RepaintNonvisualControls;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.DoSaveLocks(AParent: ILMDXmlElement;
  AOwner: TComponent);
var
  i:       Integer;
  j:       TLMDDesignerLockModeItem;
  elem:    ILMDXmlElement;
  comp:    TComponent;
  locks:   TLMDDesignerLockMode;
  chlocks: Boolean;
begin
  for i := 0 to AOwner.ComponentCount - 1 do
  begin
    comp    := AOwner.Components[i];
    chlocks := LMDIsFrameCopy(comp) and HasLockedChildren(comp);

    if (TryGetLockMode(comp, locks) and (locks <> [])) or chlocks then
    begin
      elem := AParent.AppendElement('component');
      elem.SetAttr('name', comp.Name);

      for j := Low(TLMDDesignerLockModeItem) to
               High(TLMDDesignerLockModeItem) do
      begin
        if j in locks then
          elem.SetBoolAttr(LockModeNames[j], True);
      end;

      if chlocks then
        DoSaveLocks(elem, comp);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.DoLoadLocks(AParent: ILMDXmlElement;
  AOwner: TComponent);
var
  i:     Integer;
  j:     TLMDDesignerLockModeItem;
  nd:    ILMDXmlNode;
  elem:  ILMDXmlElement;
  comp:  TComponent;
  lmode: TLMDDesignerLockMode;
begin
  for i := 0 to AParent.ChildNodes.Count - 1 do
  begin
    nd := AParent.ChildNodes[i];

    if nd.NodeType = LMD_NODE_ELEMENT then
    begin
      elem := nd.AsElement;

      if (elem.NodeName = 'component') and elem.AttrExists('name') then
      begin
        comp  := AOwner.FindComponent(elem.GetAttr('name'));
        lmode := [];

        if comp <> nil then
        begin
          for j := Low(TLMDDesignerLockModeItem) to
                   High(TLMDDesignerLockModeItem) do
            if elem.AttrExists(LockModeNames[j]) and
               elem.GetBoolAttr(LockModeNames[j]) then
              Include(lmode, j);

          LockComponent(comp, lmode);
          if LMDIsFrameCopy(comp) then
            DoLoadLocks(elem, comp);
        end;
      end;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesigner.HasLockedChildren(AOwner: TComponent): Boolean;
var
  i:    Integer;
  comp: TComponent;
begin
  for i := 0 to AOwner.ComponentCount - 1 do
  begin
    comp := AOwner.Components[i];

    if (GetLockMode(comp) <> []) or
       (LMDIsFrameCopy(comp) and HasLockedChildren(comp)) then
    begin
      Result := True;
      Exit;
    end;
  end;

  Result := False;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetServiceProvider(
  const Value: TLMDServiceProvider);
begin
  if FServiceProvider <> Value then
  begin
    if FServiceProvider <> nil then
    begin
      FServiceProvider.RemoveFreeNotification(Self);
      FServiceProvider.Members.UnregisterMember(Self);
    end;

    FServiceProvider := Value;

    if FServiceProvider <> nil then
    begin
      FServiceProvider.FreeNotification(Self);
      FServiceProvider.Members.RegisterMember(Self);
    end;
  end;
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDCustomDesigner.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_DESIGN;
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDCustomDesigner.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  
  if Operation = opRemove then
  begin
    if AComponent = FDesignPanel then
    begin
      Active      := False;
      DesignPanel := nil;
    end;

    if AComponent = FSelection then
    begin
      Active    := False;
      Selection := nil;
    end;

    if AComponent = FAllComponents then
    begin
      Active        := False;
      AllComponents := nil;
    end;

    if AComponent = FModule then
    begin
      Active := False;
      Module := nil;
    end;

    if AComponent = FServiceProvider then
      ServiceProvider := nil;

    if AComponent = PopupMenu then
      PopupMenu := nil;
        
    if AComponent = NonvisualComponentImages then
      NonvisualComponentImages := nil;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.CheckActive(AIsActiveNeeded: Boolean);
begin
  if AIsActiveNeeded <> Active then
    if AIsActiveNeeded then
      raise ELMDDesigner.Create(SLMDDsgnrMastBeActive)
    else
      raise ELMDDesigner.Create(SLMDDsgnrMastBeInactive);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesigner.GetPopupMenu: TPopupMenu;
begin
  Result := FPopupMenu;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.DoChange;
var
  comps: TList;
begin
  if FActive then
  begin
    comps := TList.Create;
    try
      TEngine(FEng).GetAllComponents(False, comps);
      LMDComponentsChanged(Self, comps);
    finally
      comps.Free;
    end;
  end;

  if Assigned(OnChange) then
    OnChange(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.ComponentInserting(
  var AComponentClass: TComponentClass);
var
  svc: ILMDCompInsService;
begin
  { Try to utilize service }

  if (dsoUseCompInsertionService in FServiceOptions) and
     LMDTryGetService(FServiceProvider, ILMDCompInsService, svc) then
  begin
    svc.Inserting(Self, AComponentClass);
  end;

  { Fire event }

  if Assigned(OnComponentInserting) then
    OnComponentInserting(Self, AComponentClass);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.ComponentInserted;
var
  svc: ILMDCompInsService;
begin
  { Try to utilize service }

  if (dsoUseCompInsertionService in FServiceOptions) and
     LMDTryGetService(FServiceProvider, ILMDCompInsService, svc) then
  begin
    svc.Inserted(Self);
  end;

  { Fire event }

  if Assigned(OnComponentInserted) then
    OnComponentInserted(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.DoNotification(AnObject: TPersistent;
  Operation: TOperation);
begin
  if Assigned(FOnNotification) then
    FOnNotification(Self, AnObject, Operation);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.DoFocus;
var
  LI:    Integer;
  LList: TList;
begin
  { Send services notification }

  if FServiceProvider <> nil then
  begin
    LList := FServiceProvider.Notifiers.GetList(ILMDDesignerNotifier);
    try
      for LI := 0 to LList.Count - 1 do
        ILMDDesignerNotifier(LList[LI]).Focus(Self);
    finally
      LList.Free;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.DoComponentHint(AComponent: TComponent;
  var AHint: TLMDString);
begin
  if Assigned(OnComponentHint) then
    OnComponentHint(Self, AComponent, AHint);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.DoContextPopup(AMousePos: TPoint;
  var AHandled: Boolean);
begin
  if Assigned(OnContextPopup) then OnContextPopup(Self, AMousePos, AHandled);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.DesignFormClose(var Action: TCloseAction);
begin
  if Assigned(OnDesignFormClose) then OnDesignFormClose(Self, Action);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Assigned(OnKeyDown) then OnKeyDown(Self, Key, Shift);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.KeyPress(var Key: Char);
begin
  if Assigned(OnKeyPress) then OnKeyPress(Self, Key);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if Assigned(OnKeyUp) then OnKeyUp(Self, Key, Shift);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.MouseDown(AButton: TMouseButton; AShift: TShiftState; AX, AY: Integer);
begin
  if Assigned(OnMouseDown) then
    OnMouseDown(Self, AButton, AShift, AX, AY);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.MouseMove(AShift: TShiftState; AX, AY: Integer);
begin
  if Assigned(OnMouseMove) then OnMouseMove(Self, AShift, AX, AY);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.MouseUp(AButton: TMouseButton; AShift: TShiftState; AX, AY: Integer);
begin
  if Assigned(OnMouseUp) then OnMouseUp(Self, AButton, AShift, AX, AY);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesigner.DoMouseWheel(AShift: TShiftState;
  AWheelDelta: Integer; AMousePos: TPoint): Boolean;
var
  IsNeg: Boolean;
begin
  Result := False;
  if Assigned(FOnMouseWheel) then
    FOnMouseWheel(Self, AShift, AWheelDelta, AMousePos, Result);
  if not Result then
    begin
      Inc(FWheelAccumulator, AWheelDelta);
      while Abs(FWheelAccumulator) >= WHEEL_DELTA do
        begin
          IsNeg := FWheelAccumulator < 0;
          FWheelAccumulator := Abs(FWheelAccumulator) - WHEEL_DELTA;
          if IsNeg then
            begin
              if FWheelAccumulator <> 0 then FWheelAccumulator := -FWheelAccumulator;
              Result := DoMouseWheelDown(AShift, AMousePos);
            end
          else
            Result := DoMouseWheelUp(AShift, AMousePos);
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesigner.DoMouseWheelDown(AShift: TShiftState;
  AMousePos: TPoint): Boolean;
begin
  Result := False;
  if Assigned(FOnMouseWheelDown) then
    FOnMouseWheelDown(Self, AShift, AMousePos, Result);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesigner.DoMouseWheelUp(AShift: TShiftState;
  AMousePos: TPoint): Boolean;
begin
  Result := False;
  if Assigned(FOnMouseWheelUp) then
    FOnMouseWheelUp(Self, AShift, AMousePos, Result);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.DblClick;
var
  svc:  ILMDObjEditService;
  comp: TComponent;
begin
  { Send command to component-editors service }

  if (dsoUseObjEditService in FServiceOptions) and
     LMDTryGetService(FServiceProvider, ILMDObjEditService, svc) then
  begin
    comp := TEngine(FEng).FSelCtrls.DefComp;
    if comp <> nil then
      svc.DblClicked(Self, comp);
  end;

  { Fire event }

  if Assigned(OnDblClick) then
    OnDblClick(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.Click;
begin
  if Assigned(OnClick) then OnClick(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.DragOver(ASource: TObject;
  AX, AY: Integer; AState: TDragState; var AAccept: Boolean);
begin
  AAccept := False;
  if Assigned(FOnDragOver) then
    begin
      AAccept := True;
      FOnDragOver(Self, ASource, AX, AY, AState, AAccept);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesigner.DoGetTransparence(AControl: TControl): Boolean;
begin
  Result := False;
  if Assigned(FOnGetTransparence) then
    FOnGetTransparence(Self, AControl, Result);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.DoGetImageParams(
  AComponentClass: TComponentClass; var AImageList: TImageList;
  var AImageIndex: Integer);
var
  svc: ILMDCompImageService;
begin
  AImageList  := FNonvisualComponentImages;
  AImageIndex := -1;

  { Try to utilize service }

  if (dsoUseCompImageService in FServiceOptions) and
     LMDTryGetService(FServiceProvider, ILMDCompImageService, svc) then
  begin
    svc.GetCompImageParams(Self, AComponentClass, AImageList, AImageIndex);
  end;

  { Fire event }

  if (AImageList = FNonvisualComponentImages) and
     Assigned(OnGetImageIndex) then
    OnGetImageIndex(Self, AComponentClass, AImageIndex);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.DoShowNonvisualComponent(
  AComponent: TComponent; var AShowComponent: Boolean);
begin
  if Assigned(OnShowNonvisualComponent) then
    OnShowNonvisualComponent(Self, AComponent, AShowComponent);
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDCustomDesigner.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FGrid                          := TLMDDesignerGrid.Create(Self);
  FHiddenClasses                 := TLMDDesignerHiddenClasses.Create(Self);
  FModuleNotifier                := TModuleNotifier.Create(Self);
  FSelnNotifier                  := TSelnNotifier.Create(Self);
  FEditorUtils                   := TEditorUtils.Create(Self).AddRef;
  FEditorWindows                 := TLMDEditorWindowManager.Create(Self, FEditorUtils);
  FSnapToGrid                    := True;
  FShowAlignLines                := True;
  FHints                         := [dhComponent, dhSize, dhMove, dhInsert];
  FHandleClr                     := clBlack;
  FHandleBorderClr               := clBlack;
  FMultySelectHandleClr          := clGray;
  FMultySelectHandleBorderClr    := clGray;
  FInactiveHandleClr             := clGray;
  FInactiveHandleBorderClr       := clBlack;
  FLockedHandleClr               := clRed;
  FClipboardFormat               := LMDDefaultDsgnrClipboardFmt;
  FComponentContextPopup         := True;
  FNonvisualComponentWidth       := 28;
  FNonvisualComponentHeight      := 28;
  FComponentCaptionsFont         := TCompCaptionsFont.Create(Self);
  FMenuOptions                   := [dmoAddCompEditorItems];
  FServiceOptions                := [dsoUseCompInsertionService, dsoUseCompImageService,
                                     dsoUseObjEditService];

  FNonvisualCompImagesChangeLink          := TChangeLink.Create;
  FNonvisualCompImagesChangeLink.OnChange := NonvisualCompImagesChange;

  LMDRegisterComponentChangeNotification(Self, CompsChangeNotification);
  DesignerList.Add(Self);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomDesigner.Destroy;
begin
  FEditorWindows.DestroyAll;

  Active                   := False;
  ServiceProvider          := nil;
  Module                   := nil;
  Selection                := nil;
  AllComponents            := nil;
  NonvisualComponentImages := nil;

  LMDUnregisterComponentChangeNotification(Self);
  DesignerList.Remove(Self);

  FGrid.Free;
  FModuleNotifier.Free;
  FSelnNotifier.Free;
  FHiddenClasses.Free;
  FNonvisualCompImagesChangeLink.Free;
  FComponentCaptionsFont.Free;
  FTempMenu.Free;
  FEditorWindows.Free;
  FEditorUtils.Release(True);
  
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.DragDrop(ASource: TObject; AX, AY: Integer);
begin
  if Assigned(FOnDragDrop) then
    FOnDragDrop(Self, ASource, AX, AY);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesigner.ComponentAtPos(const APos: TPoint): TComponent;
begin
  CheckActive(True);
  Result := TEngine(FEng).CompByControl(
    TEngine(FEng).ControlAtPos(APos));
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesigner.CanFocus: Boolean;
begin
  Result := Active and TEngine(FEng).CanFocus;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetFocus;
begin
  CheckActive(True);
  TEngine(FEng).SetFocus;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesigner.IsDesignComponent(AComponent: TComponent): Boolean;
var
  LControl: TControl;
begin
  CheckActive(True);
  LControl := TEngine(FEng).FindControl(AComponent);
  if LControl <> nil then
    Result := TEngine(FEng).IsDesignControl(LControl)
  else
    Result := False;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.GetComponentPosition(AComponent: TComponent;
  var ALeft, ATop: Integer);
var
  LControl: TControl;
begin
  CheckActive(True);
  LControl := TEngine(FEng).FindControl(AComponent);
  if LControl <> nil then
  begin
    ALeft := LControl.Left;
    ATop := LControl.Top;
  end
  else
  begin
    ALeft := 0;
    ATop  := 0;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SetComponentPosition(AComponent: TComponent;
  ALeft, ATop: Integer);
var
  LControl: TControl;
begin
  CheckActive(True);
  LControl := TEngine(FEng).FindControl(AComponent);
  if LControl <> nil then
    TEngine(FEng).SetPosition(LControl, ALeft, ATop);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.CancelMode;
begin
  CheckActive(True);
  TEngine(FEng).CancelMode;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.UpdateComponent(AIndex: Integer);
var
  LEng: TEngine;
begin
  CheckActive(True);

  LEng := TEngine(FEng);
  LEng.UpdateControlMouseHandles(LEng.FSelCtrls[AIndex]);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SelectAll;
begin
  CheckActive(True);
  TEngine(FEng).SelectAll;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.DeleteSelectedComponents;
begin
  CheckActive(True);
  TEngine(FEng).DeleteSelectedComps;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.LockComponent(AComponent: TComponent;
  ALockMode: TLMDDesignerLockMode);
begin
  CheckActive(True);
  TEngine(FEng).LockControl(TEngine(FEng).ControlByComp(AComponent),
                            ALockMode);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.LockAll(ALockMode: TLMDDesignerLockMode);
var
  LI:    Integer;
  LRoot: TWinControl;
begin
  CheckActive(True);
  LRoot := TEngine(FEng).FRoot;

  for LI := 0 to LRoot.ComponentCount - 1 do
    if TEngine(FEng).FindControl(LRoot.Components[LI]) <> nil then
      LockComponent(LRoot.Components[LI], ALockMode);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesigner.GetLockMode(
  AComponent: TComponent): TLMDDesignerLockMode;
begin
  if Active then
    Result := TEngine.GetLockMode(
      TEngine(FEng).ControlByComp(AComponent))
  else
    Result := [];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.ClearAllLocks;
begin
  CheckActive(True);
  TEngine(FEng).ClearLocks;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SaveLockState(AStream: TStream);
var
  xml: ILMDXmlDocument;
begin
  CheckActive(True);

  xml := LMDCreateXmlDocument('locklist', '1.0', 'utf-8');
  DoSaveLocks(xml.DocumentElement, FModule.Root);
  xml.Save(AStream);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SaveLockState(const AFileName: TLMDString);
var
  stream: TStream;
begin
  stream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveLockState(stream);
  finally
    stream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.LoadLockState(AStream: TStream);
var
  xml: ILMDXmlDocument;
begin
  CheckActive(True);

  xml := LMDLoadXmlDocument(AStream);
  DoLoadLocks(xml.DocumentElement, FModule.Root);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.LoadLockState(const AFileName: TLMDString);
var
  stream: TStream;
begin
  stream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadLockState(stream);
  finally
    stream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.UpdateSelected;
begin
  CheckActive(True);
  TEngine(FEng).UpdateMouseHandles;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.LockSelected(ALockMode: TLMDDesignerLockMode);
var
  LI: Integer;
begin
  CheckActive(True);

  for LI := 0 to FSelection.Count - 1 do
    if FSelection[0] is TComponent then
      LockComponent(TComponent(FSelection[LI]), ALockMode);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.AlignSelectedToGrid;
begin
  CheckActive(True);
  TEngine(FEng).FSelCtrls.AlignToGrid;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.AlignSelected(AHorzAlign,
  AVertAlign: TLMDDesignerAlignType);
begin
  CheckActive(True);
  TEngine(FEng).FSelCtrls.Align(AHorzAlign, AVertAlign);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.BringSelectedToFront;
begin
  CheckActive(True);
  TEngine(FEng).FSelCtrls.BringToFront;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.SendSelectedToBack;
begin
  CheckActive(True);
  TEngine(FEng).FSelCtrls.SendToBack;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesigner.CanCopyToClipboard: Boolean;
var
  LI:        Integer;
  LSelCtrls: TSelCtrls;
  LDefPnt:   TWinControl;
begin
  if not Active then
  begin
    Result := False;
    Exit;
  end;

  LSelCtrls := TEngine(FEng).FSelCtrls;

  if ((LSelCtrls.Count = 1) and (LSelCtrls[0] <> TEngine(FEng).FRoot)) or
     (LSelCtrls.Count > 1) then
  begin
    Result  := True;
    LDefPnt := TEngine(FEng).GetControlParent(LSelCtrls.DefControl);

    for LI := 0 to LSelCtrls.Count - 1 do
      if (TEngine(FEng).GetControlParent(LSelCtrls[LI]) = LDefPnt) and
         (LSelCtrls[LI] <> TEngine(FEng).FRoot) and
         (lmNoCopy in TEngine(FEng).GetFullLockMode(LSelCtrls[LI])) then
      begin
        Result := False;
        Break; // for
      end;
  end
  else
    Result := False;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesigner.CanCutToClipboard: Boolean;
var
  LI:        Integer;
  LSelCtrls: TSelCtrls;
  LDefPnt:   TWinControl;
begin
  if not Active then
  begin
    Result := False;
    Exit;
  end;

  LSelCtrls := TEngine(FEng).FSelCtrls;

  if ((LSelCtrls.Count = 1) and (LSelCtrls[0] <> TEngine(FEng).FRoot)) or
     (LSelCtrls.Count > 1) then
  begin
    Result  := True;
    LDefPnt := TEngine(FEng).GetControlParent(LSelCtrls.DefControl);
    
    for LI := 0 to LSelCtrls.Count - 1 do
      if (TEngine(FEng).GetControlParent(LSelCtrls[LI]) = LDefPnt) and
         (LSelCtrls[LI] <> TEngine(FEng).FRoot) and
         ((lmNoCopy in TEngine(FEng).GetFullLockMode(LSelCtrls[LI])) or
          (lmNoDelete in TEngine(FEng).GetFullLockMode(LSelCtrls[LI]))) then
      begin
        Result := False;
        Break;
      end;
  end
  else
    Result := False;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDesigner.CanPasteFromClipboard: Boolean;
var
  LC:        TComponent;
  LParent:   TWinControl;
  LSelCtrls: TSelCtrls;
begin
  if not Active then
  begin
    Result := False;
    Exit;
  end;

  Result    := True;
  LSelCtrls := TEngine(FEng).FSelCtrls;

  if LSelCtrls.DefComp <> nil then
  begin
    LC := nil;
    if LSelCtrls.DefComp is TControl then
      LC := TComponentAccess(LSelCtrls.DefComp).GetChildParent;

    if (LC <> nil) and (LC is TWinControl) and
       (csAcceptsControls in TWinControl(LC).ControlStyle) then
      LParent := TWinControl(LC)
    else
      LParent := TEngine(FEng).GetContainer(TEngine(FEng).ControlByComp(
        LSelCtrls.DefComp), True);

    if (LParent = nil) or
       (lmNoInsertin in TEngine(FEng).GetLockMode(LParent))
    then
      Result := False;
  end;
  
  if Result then
  begin
    RegisterClipboardFormat;
    Result := Clipboard.HasFormat(FClipboardFormatWord);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.CutToClipboard;
begin
  CheckActive(True);
  if CanCutToClipboard then
  begin
    CopyToClipboard;
    DeleteSelectedComponents;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.CopyToClipboard;
var
  LMemHandle:     THandle;
  LGlobalDataPtr: Pointer;
  LStream:        TMemoryStream;
  LComponents:    TList;
  LSelCtrls:      TSelCtrls;
begin
  CheckActive(True);
  if not CanCopyToClipboard then
    Exit;

  LSelCtrls := TEngine(FEng).FSelCtrls;

  RegisterClipboardFormat;
  LSelCtrls.ClearNotChildrensOf(TEngine(FEng).GetCompParent(LSelCtrls.DefComp));

  if LSelCtrls.Count > 0 then
  begin
    LStream := TMemoryStream.Create;
    try
      LComponents := TList.Create;
      try
        LSelCtrls.GetComps(LComponents);
        TEngine(FEng).ClipbrdSave(LStream, LComponents);
      finally
        LComponents.Free;
      end;

      LMemHandle := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, LStream.Size);
      try
        LGlobalDataPtr := GlobalLock(LMemHandle);
        try
          Move(LStream.Memory^, LGlobalDataPtr^, LStream.Size);
        finally
          GlobalUnlock(LMemHandle);
        end;
      except
        GlobalFree(LMemHandle);
        raise;
      end;
    finally
      LStream.Free;
    end;
    Clipboard.SetAsHandle(FClipboardFormatWord, LMemHandle);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.PasteFromClipboard;
var
  LMemHandle:     THandle;
  LGlobalDataPtr: Pointer;
  LStream:        TMemoryStream;
  LLocalDataPtr:  Pointer;
  LLocalDataSize: Integer;
  LC:             TComponent;
  LParent:        TWinControl;
  LSelCtrls:      TSelCtrls;
begin
  CheckActive(True);
  if not CanPasteFromClipboard then
    Exit;

  LSelCtrls      := TEngine(FEng).FSelCtrls;
  LMemHandle     := Clipboard.GetAsHandle(FClipboardFormatWord);
  LGlobalDataPtr := GlobalLock(LMemHandle);
  try
    LLocalDataPtr := nil;
    LLocalDataSize := GlobalSize(LMemHandle);
    ReallocMem(LLocalDataPtr, LLocalDataSize);
    try
      Move(LGlobalDataPtr^, LLocalDataPtr^, LLocalDataSize);

      LStream := TMemoryStream.Create;
      try
        LStream.Size := LLocalDataSize;
        Move(LLocalDataPtr^, LStream.Memory^, LLocalDataSize);

        if LSelCtrls.DefComp <> nil then
        begin
          LC := nil;
          if LSelCtrls.DefComp is TControl then
            LC := TComponentAccess(LSelCtrls.DefComp).GetChildParent;

          if (LC <> nil) and (LC is TWinControl) and
             (csAcceptsControls in TWinControl(LC).ControlStyle) then
            LParent := TWinControl(LC)
          else
            LParent := TEngine(FEng).GetContainer(
              TEngine(FEng).ControlByComp(LSelCtrls.DefComp), True);
        end
        else
          LParent := nil;

        if LParent = nil then
          LParent := TEngine(FEng).FRoot;

        TEngine(FEng).ClipbrdLoad(LStream, LParent);
      finally
        LStream.Free;
      end;
    finally
      FreeMem(LLocalDataPtr);
    end;
  finally
    GlobalUnlock(LMemHandle);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.UpdateNonvisualComponents;
begin
  if FActive and FShowNonvisualComponents then
    TEngine(FEng).RecreateNonvisualControls;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesigner.UpdateAllComponentsCollection;
begin
  if FActive then
    TEngine(FEng).UpdateDesignerAllComponents;
end;

{ ******************************** TLMDDesigner ****************************** }
{ ---------------------------------------------------------------------------- }
procedure TLMDDesigner.ReadDeprecatedEventProp(Reader: TReader);
begin
  if Reader.NextValue = vaNil then
    Reader.ReadValue
  else
    Reader.ReadIdent;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDesigner.DefineProperties(Filer: TFiler);
begin
  inherited;

  { Deprecated properties }

  Filer.DefineProperty('OnChangeSelection', ReadDeprecatedEventProp, nil, False);
  Filer.DefineProperty('OnValidateName', ReadDeprecatedEventProp, nil, False);
  Filer.DefineProperty('OnGetUniqueName', ReadDeprecatedEventProp, nil, False);
  Filer.DefineProperty('OnReadError', ReadDeprecatedEventProp, nil, False);
  Filer.DefineProperty('OnReadFindMethod', ReadDeprecatedEventProp, nil, False);
  Filer.DefineProperty('OnReadSetName', ReadDeprecatedEventProp, nil, False);
  Filer.DefineProperty('OnReadReferenceName', ReadDeprecatedEventProp, nil, False);
  Filer.DefineProperty('OnReadCreateComponent', ReadDeprecatedEventProp, nil, False);
  Filer.DefineProperty('OnReadFindComponentClass', ReadDeprecatedEventProp, nil, False);
  Filer.DefineProperty('OnClipboardFindComponentClass', ReadDeprecatedEventProp, nil, False);
end;

{ ************************** class TDesignPanelForm ************************** }
{ ------------------------------ protected ----------------------------------- }
procedure TDesignPanelForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style   := Style and not (WS_POPUP or WS_CAPTION or WS_THICKFRAME or
                              WS_MINIMIZEBOX or WS_MAXIMIZEBOX or
                              WS_SYSMENU) or
                             (WS_CHILD or WS_GROUP or WS_TABSTOP);
    ExStyle := ExStyle and not (WS_EX_DLGMODALFRAME or WS_EX_WINDOWEDGE or
                                WS_EX_TOOLWINDOW);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TDesignPanelForm.CreateHandle;
begin
  inherited;
  if (FDesignPanel <> nil) and FDesignPanel.IsUsed then
    TEngine(FDesignPanel.FEng).DesignPanelHandleChanging(Handle);
end;

{ ---------------------------------------------------------------------------- }
procedure TDesignPanelForm.WndProc(var Message: TMessage);
begin
  if FDesignPanel <> nil then
  begin
    case Message.Msg of
      WM_DESTROY:
      begin
        if FDesignPanel.IsUsed then
          TEngine(FDesignPanel.FEng).DesignPanelHandleChanging(0);
      end;
      WM_LBUTTONDOWN,
      WM_MBUTTONDOWN,
      WM_RBUTTONDOWN:
      begin
        if FDesignPanel.IsUsed then
          TEngine(FDesignPanel.FEng).SetFocus;
      end;
    end;
  end;

  inherited WndProc(Message);
end;

{ ------------------------------ public -------------------------------------- }
constructor TDesignPanelForm.CreateForm(ADesignPanel: TLMDCustomDesignPanel);
begin
  FDesignPanel := ADesignPanel;
  inherited CreateNew(nil);

  BorderStyle  := bsNone;          // Required for VCL Styles support,
  VertScrollBar.Visible := False;  // otherwise style handler will draw
  HorzScrollBar.Visible := False;  // caption, border and scrollbars.
end;

{ ---------------------------------------------------------------------------- }
function TDesignPanelForm.SetFocusedControl(Control: TWinControl): Boolean;
begin
  // Do not call inherited, becouse TDesignPanelForm must never become
  // Screen.ActiveForm or Screen.ActiveCustomForm.

  Result := True;
end;

{ ******************************* TSelnNotifier ****************************** }
{ -------------------------------- public ------------------------------------ }
constructor TSelnNotifier.Create(ADesigner: TLMDCustomDesigner);
begin
  inherited Create;
  FDesigner := ADesigner;
end;

{ ---------------------------------------------------------------------------- }
procedure TSelnNotifier.Changed(ASender: TLMDDesignObjects);
begin
  if FDesigner.FActive then
    TEngine(FDesigner.FEng).UpdateEngineSelection;
end;

{ ****************************** TModuleNotifier ***************************** }
{ -------------------------------- public ------------------------------------ }
constructor TModuleNotifier.Create(ADesigner: TLMDCustomDesigner);
begin
  inherited Create;
  FDesigner := ADesigner;
end;

{ ---------------------------------------------------------------------------- }
procedure TModuleNotifier.RootChange(AModule: TLMDModule);
begin
  FDesigner.Active := False;
end;

{ ---------------------------------------------------------------------------- }
procedure TModuleNotifier.RootReloaded(AModule: TLMDModule);
begin
  if FDesigner.FActive then
    TEngine(FDesigner.FEng).UpdateDesignerAllComponents;
end;

{****************************** TCompCaptionsFont *****************************}
{ ---------------------------------------------------------------------------- }
procedure TCompCaptionsFont.Changed;
begin
  if (FDesigner <> nil) and (FDesigner.Active) then
    TEngine(FDesigner.FEng).UpdateNonvisualControls;
end;

{ ---------------------------------------------------------------------------- }
constructor TCompCaptionsFont.Create(ADesigner: TLMDCustomDesigner);
begin
  inherited Create;
  FDesigner := ADesigner;
end;

{ ***************************** class TEngCanvas ***************************** }
{ ------------------------------ private ------------------------------------- }
procedure TEngCanvas.SetWinControl(const Value: TWinControl);
begin
  FWinControl := Value;

  if Value <> nil then
    FHiddenControl.ParentWindow := Value.Handle
  else
    FHiddenControl.ParentWindow := 0;

  Handle := 0;
end;

{ ------------------------------ protected ----------------------------------- }
procedure TEngCanvas.CreateHandle;
begin
  inherited;
  Handle := GetDCEx(FHiddenControl.Handle, 0, DCX_PARENTCLIP);
end;

{ ------------------------------ public -------------------------------------- }
constructor TEngCanvas.Create(AEng: TEngine);
begin
  inherited Create;
  FEng           := AEng;
  FHiddenControl := TWinControl.Create(nil);
end;

{ ---------------------------------------------------------------------------- }
destructor TEngCanvas.Destroy;
begin
  FHiddenControl.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TEngCanvas.ScreenToClient(const AP: TPoint): TPoint;
begin
  Result := FHiddenControl.ScreenToClient(AP);
end;

{ ******************************* class TEngHint ***************************** }
{ ------------------------------ private ------------------------------------- }
procedure TEngHint.TimerOnTimer(Sender: TObject);
begin
  case FTimerMode of
    tmShow: ActivateNoPause;
    tmHide: CancelHint;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngHint.ActivateNoPause;

  function _GetCursorHeightMargin: Integer;
  var
    IconInfo:                                  TIconInfo;
    BitmapInfoSize, BitmapBitsSize, ImageSize: DWORD;
    Bitmap:                                    PBitmapInfoHeader;
    Bits:                                      Pointer;
    BytesPerScanline:                          Integer;

      function FindScanline(Source: Pointer; MaxLen: Cardinal;
                            Value: Cardinal): Cardinal;
      var
        p: PByte;
      begin
        p := Source;
        Result := MaxLen;
        while (Result > 0) and (p^ = Value) do
        begin
          Inc(p);
          Dec(Result);
        end;
      end;

  begin
    Result := GetSystemMetrics(SM_CYCURSOR);

    if GetIconInfo(GetCursor, IconInfo) then
    try
      GetDIBSizes(IconInfo.hbmMask, BitmapInfoSize, BitmapBitsSize);
      Bitmap := AllocMem(DWORD(BitmapInfoSize) + BitmapBitsSize);
      try
      Bits := Pointer(TLMDPtrUInt(Bitmap) + BitmapInfoSize);
      if GetDIB(IconInfo.hbmMask, 0, Bitmap^, Bits^) and
        (Bitmap^.biBitCount = 1) then
        begin
          { Point Bits to the end of this bottom-up bitmap }
          with Bitmap^ do
            begin
              BytesPerScanline := ((biWidth * biBitCount + 31) and not 31) div 8;
              ImageSize := biWidth * BytesPerScanline;
              Bits := Pointer(TLMDPtrUInt(Bits) + BitmapBitsSize - ImageSize);
              { Use the width to determine the height since another mask bitmap
                may immediately follow }
              Result := FindScanline(Bits, ImageSize, $FF);
              { In case the and mask is blank, look for an empty scanline in the
                xor mask. }
              if (Result = 0) and (biHeight >= 2 * biWidth) then
                Result := FindScanline(Pointer(TLMDPtrUInt(Bits) - ImageSize),
                                       ImageSize, $00);
              Result := Result div BytesPerScanline;
            end;
          Dec(Result, IconInfo.yHotSpot);
        end;
      finally
        FreeMem(Bitmap, BitmapInfoSize + BitmapBitsSize);
      end;
    finally
      if IconInfo.hbmColor <> 0 then DeleteObject(IconInfo.hbmColor);
      if IconInfo.hbmMask <> 0 then DeleteObject(IconInfo.hbmMask);
    end;
  end;

var
  LP: TPoint;
  LR: TRect;

begin
  GetCursorPos(LP);

  if (FCheckControl <> nil) and
     (FEng.GetDesignControl(FindDragTarget(LP, True)) <> FCheckControl) then
    CancelHint
  else
  begin
    FTimer.Enabled := False;
    LMDHookHint(IsHintMsg);
    FHintWindow.Color       := Application.HintColor;
    FHintWindow.Canvas.Font := Screen.HintFont;
    LR := FHintWindow.CalcHintRect(Screen.Width, FStr, nil);
    OffsetRect(LR, LP.X, LP.Y + _GetCursorHeightMargin);
    FHintWindow.ActivateHint(LR, FStr);
    FHintWindow.Update;
    if FNeedStartHideTimer then
    begin
      FTimer.Interval := Application.HintHidePause;
      FTimerMode      := tmHide;
      FTimer.Enabled  := True;
    end;
    FActive := True;
  end;
end;

{ ------------------------------ public -------------------------------------- }
constructor TEngHint.Create(AEng: TEngine);
begin
  inherited Create;
  FEng := AEng;
  FTimer := TTimer.Create(nil);
  FTimer.Enabled := False;
  FTimer.OnTimer := TimerOnTimer;
  FHintWindow := TLMDHintWindow.Create(nil);
end;

{ ---------------------------------------------------------------------------- }
destructor TEngHint.Destroy;
begin
  CancelHint;
  FTimer.Free;
  FHintWindow.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngHint.ActivateHint(APauseBeforeShow, AHideAfterPause,
  AUseHooks: Boolean; ACheckControl: TControl; const AStr: TLMDString);
begin
  FNeedStartHideTimer := AHideAfterPause;
  FCheckControl := ACheckControl;
  FUseHooks := AUseHooks;
  FStr := AStr;
  if APauseBeforeShow then
    begin
      FTimer.Interval := Application.HintPause;
      FTimerMode := tmShow;
      FTimer.Enabled := True;
    end
  else
    ActivateNoPause;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngHint.CancelHint;
begin
  FTimer.Enabled := False;
  ShowWindow(FHintWindow.Handle, SW_HIDE);
  LMDUnhookHint(IsHintMsg);
  FActive := False;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngHint.IsHintMsg(var AMsg: TMsg);
begin
  if FUseHooks and (FHintWindow <> nil) then
    if FHintWindow.IsHintMsg(AMsg) then
      CancelHint;
end;

{************************** TNonvisualControlLabel ****************************}
{ ---------------------------------------------------------------------------- }
procedure TNonvisualControlLabel.WndProc(var Message: TMessage);
begin
  if (FControl.FDEng = nil) or
     not FControl.FDEng.IsDesignMsg(Self, Message) then
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TNonvisualControlLabel.Paint;
begin
  Canvas.Brush.Color := clBtnFace;
  Canvas.TextRect(ClientRect, 0, 0, FControl.FComponent.Name);
end;

{ ---------------------------------------------------------------------------- }
constructor TNonvisualControlLabel.Create(AOwner: TComponent;
  AControl: TNonvisualControl);
begin
  inherited Create(AOwner);
  FControl := AControl;

  Width  := 30;
  Height := 12;
end;

{ ---------------------------------------------------------------------------- }
procedure TNonvisualControlLabel.Update(const AText: TLMDString);
var
  LDc:     HDC;
  OldFont: HGDIOBJ;
  LRect:   TRect;
begin
  { Update font }

  Canvas.Font := FControl.FDEng.FDesigner.FComponentCaptionsFont;

  { Update bounds }

  LRect   := Rect(0, 0, 0, 0);
  LDc     := GetDC(0);
  OldFont := SelectObject(LDc, Canvas.Font.Handle);
  try
    Windows.{$IFDEF LMD_UNICODE}DrawTextW{$ELSE}DrawText{$ENDIF}(
      LDc, PLMDChar(AText), Length(AText), LRect,
      DT_EXPANDTABS or DT_CALCRECT);
  finally
    SelectObject(LDc, OldFont);
    ReleaseDC(0, LDc);
  end;

  SetBounds(FControl.Left - ((LRect.Right - FControl.Width) div 2),
            FControl.Top + FControl.FDEng.FDesigner.FNonvisualComponentHeight,
            LRect.Right, LRect.Bottom);
end;

{ ************************* class TNonvisualControl ************************** }
{ ----------------------------- protected ------------------------------------ }
procedure TNonvisualControl.WndProc(var Message: TMessage);
begin
  if (FDEng = nil) or not FDEng.IsDesignMsg(Self, Message) then
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TNonvisualControl.UpdateLabelWindow;
begin
  if FDEng.FDesigner.FShowComponentCaptions then
  begin
    FLabel.ParentWindow := ParentWindow;
    FLabel.BringToFront;
  end
  else
    FLabel.ParentWindow := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TNonvisualControl.Paint;
var
  LImageList:  TImageList;
  LImageIndex: Integer;
  LLeft, LTop: Integer;
begin
  inherited;

  LImageList  := nil;
  LImageIndex := -1;

  if FDEng <> nil then
    FDEng.FDesigner.DoGetImageParams(TComponentClass(Component.ClassType),
                                     LImageList, LImageIndex);

  if (LImageList <> nil) and (LImageIndex >= 0) and
     (LImageIndex <= LImageList.Count - 1) then
    begin
      LLeft := (Width - LImageList.Width) div 2;
      LTop := (Height - LImageList.Height) div 2;
      LImageList.Draw(Canvas, LLeft, LTop, LImageIndex, dsTransparent, itImage)
    end
  else
    begin
      LLeft := (Width - FDEng.GetDefNonVisibleBitmap.Width) div 2;
      LTop := (Height - FDEng.GetDefNonVisibleBitmap.Height) div 2;
      Canvas.Draw(LLeft, LTop, FDEng.GetDefNonVisibleBitmap);
    end;

  Canvas.Pen.Color := clBtnHighlight;
  Canvas.MoveTo(0, Height);
  Canvas.LineTo(0, 0);
  Canvas.LineTo(Width, 0);
  Canvas.Pen.Color := clBtnShadow;
  Canvas.MoveTo(0, Height - 1);
  Canvas.LineTo(Width - 1, Height - 1);
  Canvas.LineTo(Width - 1, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TNonvisualControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (AComponent = FComponent) and (Operation = opRemove) then
    Free;
end;

{ ------------------------------- public ------------------------------------- }
constructor TNonvisualControl.Create(ADEng: TEngine; AComponent: TComponent);
begin
  inherited Create(nil);
  Color        := clBtnFace;
  ControlStyle := ControlStyle - [csAcceptsControls];
  FComponent   := AComponent;
  FLabel       := TNonvisualControlLabel.Create(nil, Self);

  AComponent.FreeNotification(Self);
  ADEng.AddNonvisualControlItem(Self);

  Update;
end;

{ ---------------------------------------------------------------------------- }
destructor TNonvisualControl.Destroy;
begin
  FComponent.RemoveFreeNotification(Self);
  FDEng.RemoveNonvisualControlItem(Self);

  FLabel.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TNonvisualControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  LDesiInfo:  Longint;
  tmpL, tmpT: Word;
begin
  { Fix coordinates }

  tmpL := Word(aLeft);
  tmpT := Word(aTop);
  if aLeft < 0 then tmpL := 0;
  if aTop < 0 then  tmpT := 0;

  { Set bounds }

  inherited SetBounds(tmpL, tmpT, FDEng.FDesigner.FNonvisualComponentWidth,
                      FDEng.FDesigner.FNonvisualComponentHeight);

  { Update label }

  FLabel.Update(FComponent.Name);

  { Update component design info }

  if FComponent <> nil then
  begin
    LDesiInfo := FComponent.DesignInfo;
    LDesiInfo := (LDesiInfo and $FFFF) or (tmpT shl 16);
    LDesiInfo := (LDesiInfo and Integer($FFFF0000)) or
                 (tmpL and $FFFF);
    FComponent.DesignInfo := LDesiInfo;
  end;

  { Update root }

  if FDEng <> nil then
    FDEng.FRoot.Update;
end;

{ ---------------------------------------------------------------------------- }
procedure TNonvisualControl.SetParentHandle(AHandle: THandle);
begin
  ParentWindow := AHandle;
  BringToFront;

  UpdateLabelWindow;
end;

{ ---------------------------------------------------------------------------- }
procedure TNonvisualControl.Update;
var
  LLeft, LTop: Integer;
begin
  if ParentWindow <> 0 then
    BringToFront;
  UpdateLabelWindow;

  if FComponent <> nil then
    begin
      LLeft := FComponent.DesignInfo and $FFFF;
      LTop :=  FComponent.DesignInfo shr 16;
      if LLeft < 0 then LLeft := 0;
      if LTop < 0 then  LTop := 0;

      SetBounds(LLeft, LTop, Width, Height);
    end;
  inherited Update;
end;

{ ---------------------------------------------------------------------------- }
procedure TNonvisualControl.Renaming(const ANewName: TLMDString);
begin
  FLabel.Update(ANewName);
end;

{ **************************** class TEngine ****************************** }
{ ------------------------------ private ------------------------------------- }
function TEngine.GetRootVisible: Boolean;
begin
  Result := IsWindowVisible(FRoot.Handle);
end;

function TEngine.GetThemedFormColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleColor(scWindow)
  else
  {$ENDIF}
    Result := FForm.Color;
end;

function TEngine.GetThemedGridColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := LMDBlend(StyleServices.GetStyleFontColor(sfWindowTextNormal),
                       GetThemedFormColor, 70)
  else
  {$ENDIF}
    Result := FForm.Color;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.SetRootVisible(const Value: Boolean);
begin
  if Value then
    ShowWindow(FRoot.Handle, SW_SHOW)
  else
    ShowWindow(FRoot.Handle, SW_HIDE);
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.GridParamsChanged;
begin
  UpdateGridPattern;
  FForm.Refresh;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.UpdateGridPattern;
var
  LI, LJ, LXOff, LYOff: Integer;
begin
  FGridBkColor    := GetThemedFormColor;
  FGridFgColor    := GetThemedGridColor;
  FGridHScrollPos := FForm.HorzScrollBar.ScrollPos;
  FGridVScrollPos := FForm.VertScrollBar.ScrollPos;
  LXOff           := FGridHScrollPos mod FGrid.XStep;
  LYOff           := FGridVScrollPos mod FGrid.YStep;

  with FGridBitmap do
  begin
    Width              := (8 div FGrid.XStep + 1) * FGrid.XStep;
    Height             := (8 div FGrid.YStep + 1) * FGrid.YStep;
    Canvas.Brush.Color := FGridBkColor;
    Canvas.Brush.Style := bsSolid;
    Canvas.FillRect(Rect(0, 0, FGridBitmap.Width, FGridBitmap.Height));

    LI := -LXOff;
    while LI < FGridBitmap.Width do
      begin
        LJ := -LYOff;
        while LJ < FGridBitmap.Height do
          begin
            if (LI >= 0) and (LJ >= 0) then
              Canvas.Pixels[LI, LJ] := FGridFgColor;
            Inc(LJ, FGrid.YStep);
          end;
        Inc(LI, FGrid.XStep);
      end;
  end;

  if FGridBrush <> 0 then
    DeleteObject(FGridBrush);
  FGridBrush := CreatePatternBrush(FGridBitmap.Handle);
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.ReaderReadComponent(Component: TComponent);

  function _ControlExist(AControl: TControl; AParent: TWinControl;
    ALeft, ATop: Integer): Boolean;
  var
    LI: Integer;
  begin
    Result := False;
    for LI := 0 to AParent.ControlCount - 1 do
      if AParent.Controls[LI] <> AControl then
        with AParent.Controls[LI] do
          if (Left = ALeft) and (Top = ATop) then
            begin
              Result := True;
              Break;
            end;
    if AParent = FRoot then
      for LI := 0 to FNonvisualControls.Count - 1 do
        if FNonvisualControls[LI] <> AControl then
          with TNonvisualControl(FNonvisualControls[LI]) do
            if (Left = ALeft) and (Top = ATop) then
            begin
              Result := True;
              Break;
            end;
  end;

  function _GetNewTopLeft(AControl: TControl; AParent: TWinControl; ALeft, ATop,
    AWidth, AHeight: Integer): TPoint;
  var
    LNewLeft, LNewTop, LOldLeft, LOldTop: Integer;
  begin
    Result := Point(ALeft, ATop);

    if AParent <> nil then
      begin
        if ALeft > AParent.Width - AWidth then
          LNewLeft := AParent.Width - AWidth
        else
          LNewLeft := ALeft;
        if ATop > AParent.Height - AHeight then
            LNewTop := AParent.Height - AHeight
        else
          LNewTop := ATop;

        LOldLeft := ALeft;
        LOldTop := ATop;
        while _ControlExist(AControl, AParent, LNewLeft, LNewTop) do
          begin
            Inc(LNewLeft, FGrid.XStep);
            Inc(LNewTop, FGrid.YStep);
            if LNewLeft > AParent.Width - AWidth then
              LNewLeft := AParent.Width - AWidth;
            if LNewTop > AParent.Height - AHeight then
              LNewTop := AParent.Height - AHeight;
            if (LOldLeft = LNewLeft) and (LOldTop = LNewTop) then
              Break;
            LOldLeft := LNewLeft;
            LOldTop := LNewTop;
          end;

        Result := Point(LNewLeft, LNewTop);
      end;
  end;

var
  LControl: TControl;
  LNewLeftTop: TPoint;

begin
  LControl := FindControl(Component);
  if (LControl <> nil) and IsDesignControl(LControl) then
  begin
    if LControl is TNonvisualControl then
      (LControl as TNonvisualControl).Update;

    LNewLeftTop := _GetNewTopLeft(
      LControl,
      GetControlParent(LControl),
      LControl.Left,
      LControl.Top,
      LControl.Width,
      LControl.Height
    );

    LControl.SetBounds(LNewLeftTop.X, LNewLeftTop.Y,
      LControl.Width, LControl.Height);

    if LControl is TNonvisualControl then
      (LControl as TNonvisualControl).Update;

    FSelCtrls.Add(LControl);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TEngine.GetFocused: Boolean;
begin
  Result := FForm.Focused;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.AddNonvisualControlItem(AControl: TNonvisualControl);
begin
  AControl.FDEng := Self;
  FNonvisualControls.Add(AControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.RemoveNonvisualControlItem(
  AControl: TNonvisualControl);
begin
  FNonvisualControls.Remove(AControl);
  AControl.FDEng := nil;
end;

{ ---------------------------------------------------------------------------- }
function TEngine.GetDefNonVisibleBitmap: Graphics.TBitmap;
begin
  if FDefNonVisibleBitmap = nil then
    begin
      FDefNonVisibleBitmap        := Graphics.TBitmap.Create;
      FDefNonVisibleBitmap.Width  := 24;
      FDefNonVisibleBitmap.Height := 24;
      FDefNonVisibleBitmap.Transparent := True;
      FDefNonVisibleBitmap.LoadFromResourceName(HInstance, 'LMDDSGNONVISIBLE');
    end;
  Result := FDefNonVisibleBitmap;
end;

{ ------------------------------ protected ----------------------------------- }
function TEngine._AddRef: Integer;
begin
  Result := -1;
end;

{ ---------------------------------------------------------------------------- }
function TEngine._Release: Integer;
begin
  Result := -1;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.Modified;
begin
  UpdateMouseHandles;
  UpdateNonvisualControls;
  FDesigner.EditorWindows.UpdateAll;
  FDesigner.DoChange;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.Notification(AnObject: TPersistent;
  Operation: TOperation);
var
  LComp: TComponent;
begin
  if AnObject is TComponent then
  begin
    LComp := TComponent(AnObject);

    if LComp is TControl then
    begin
      if Operation = opRemove then
        FSelCtrls.Remove(TControl(LComp));
    end
    else
    begin
      if (Operation = opInsert) and FDesigner.FShowNonvisualComponents and
         (FindNonvisualControl(LComp) = nil) and not IsCompHidden(LComp) then
        AddNonvisualControl(LComp)
      else if Operation = opRemove then
        RemoveNonvisualControl(LComp);
    end;

    if Operation = opRemove then
      UpdateDesignerAllComponents;
  end;

  FDesigner.DoNotification(AnObject, Operation);
end;

{ ---------------------------------------------------------------------------- }
function TEngine.GetCustomForm: TCustomForm;
begin
  if FRoot is TCustomForm then
    Result := TCustomForm(FRoot)
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.SetCustomForm(Value: TCustomForm);
begin
  raise ELMDDesigner.Create(SLMDNotImplemented);
end;

{ ---------------------------------------------------------------------------- }
function TEngine.GetIsControl: Boolean;
begin
  Result := TControlAccess(FRoot).IsControl;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.SetIsControl(Value: Boolean);
begin
  TControlAccess(FRoot).IsControl := Value;
end;

{ ---------------------------------------------------------------------------- }
function TEngine.IsDesignMsg(Sender: TControl; var Message: TMessage): Boolean;

  procedure _FormClose;
  var
    LCloseAction: TCloseAction;
    LForm:        TForm;
  begin
    LForm := TForm(FRoot);
    if LForm.FormStyle = fsMDIChild then
    begin
      if biMinimize in LForm.BorderIcons then
        LCloseAction := caMinimize
      else
        LCloseAction := caNone;
    end
    else
      LCloseAction := caHide;
    FDesigner.DesignFormClose(LCloseAction);
    if LCloseAction <> caNone then
      begin
        if Application.MainForm = TCustomForm(LForm) then
          Application.Terminate
        else
        case LCloseAction of
          caHide:
            RootVisible := False;
          caMinimize:
            if RootVisible then
              ShowWindow(LForm.Handle, SW_SHOWMINIMIZED);
        else
          LForm.Release;
        end;
      end;
  end;

  procedure _ContextPopup(AMousePos: TPoint);
  begin
    CancelMode;
    FDesigner.ContextPopup(AMousePos);
  end;

  procedure _GetRootHitTest(var AMessage: TWMNCHitTest);
  var
    p: TPoint;
  begin
    p := SmallPointToPoint(AMessage.Pos);
    MapWindowPoints(0, FRoot.Handle, p, 1);

    if PtInRect(FRoot.ClientRect, p) then
      AMessage.Result := HTCLIENT
    else
      AMessage.Result := HTTRANSPARENT;
  end;

var
  LI:            Integer;
  LSource:       TObject;
  LAccepts:      Boolean;
  LIsDockOp:     Boolean;
  LP:            TPoint;
  LButton:       TMouseButton;
  LShift:        TShiftState;
  LHintMsg:      TMsg;
  LWMMouse:      TWMMouse;
  LWMMouseWheel: TWMMouseWheel;
  LWMNCHitTest:  TWMNCHitMessage;
  LWMKey:        TWMKey;
begin
  Result := False;
  if Sender = nil then
    Exit;

  if not (desDrawMode in FState) then
  begin
    LHintMsg.message := Message.Msg;
    LHintMsg.wParam  := Message.WParam;
    LHintMsg.lParam  := Message.LParam;
    LHintMsg.hwnd    := 0;
    FHint.IsHintMsg(LHintMsg);
  end;

  if Message.Msg = RMDsgnrSCUpd then
  begin
    LI := FSelCtrls.IndexOf(TControl(Message.WParam));
    if LI <> -1 then
      UpdateControlMouseHandles(FSelCtrls[LI]);
  end
  else if Message.Msg = RMDsgnrSizing then
  begin
    Windows.SetFocus(FForm.Handle);
    Result := MouseMessage(Sender, Message);
  end
  else
    case Message.Msg of
      CM_DRAG:
      begin
        with TCMDrag(Message) do
        begin
          Result := 0;
          case DragMessage of
            dmDragEnter, dmDragLeave, dmDragMove, dmDragDrop:
            begin
              if DragRec.Target <> nil then
              begin
                LSource := DragRec.Source;
                LIsDockOp := LSource is TDragDockObject;
                if not LIsDockOp then
                  with FDesigner.Module.ScreenToClient(DragRec.Pos) do
                    case DragMessage of
                      dmDragEnter, dmDragLeave, dmDragMove:
                      begin
                        LAccepts := True;
                        FDesigner.DragOver(LSource, X, Y,
                          TDragState(DragMessage), LAccepts);
                        Result := Ord(LAccepts);
                      end;
                      dmDragDrop:
                        FDesigner.DragDrop(LSource, X, Y);
                    end;
              end;
            end;
            dmFindTarget:
              Result := LRESULT(FRoot);
          end;
        end;
        Result := True;
      end;
      WM_WINDOWPOSCHANGED:
        PostMessage(FForm.Handle, RMDsgnrSCUpd, WPARAM(Sender), 0); // PostMessage is
                                                                    // improves control
                                                                    // repaint speed
                                                                    // becouse SelCtrls
                                                                    // will be updated after
                                                                    // control painting.
      WM_NCHITTEST:
      begin
        if (Sender = FRoot) and (FRoot is TCustomForm) and
           (FDesignPanel <> nil) then
        begin
          _GetRootHitTest(TWMNCHitTest(Message));
          Result := True;
        end;
      end;
      WM_SETFOCUS:
      begin
        if (FDesignPanel <> nil) and (GetParentForm(FDesignPanel) <> nil) then
          GetParentForm(FDesignPanel).SetFocusedControl(FDesignPanel);
        FSelCtrls.SetActive(Focused);
        if Focused then
          FDesigner.DoFocus;
        Result := True;
      end;
      WM_KILLFOCUS:
      begin
        FSelCtrls.SetActive(Focused);
        if Focused then
          FDesigner.DoFocus;
        Result := True;
      end;
      WM_CANCELMODE:
        CancelMode;
      WM_CLOSE:
      begin
        if (Sender = FRoot) and (FRoot is TCustomForm) then
          _FormClose;
        Result := True;
      end;
      WM_CONTEXTMENU:
      begin
        with TWMContextMenu(Message) do
          _ContextPopup(Point(XPos, YPos));
        Message.Result := 1;
        Result := True;
      end;
      WM_SETCURSOR:
      begin
        Windows.SetCursor(Screen.Cursors[crArrow]);
        Result := True;
      end;
      WM_SIZE:
      begin
        if (Sender = FRoot) and (FDesignPanel <> nil) then
          FDesignPanel.RootBoundsChanged;
      end;
      WM_NCLBUTTONDOWN, WM_NCLBUTTONUP, WM_NCLBUTTONDBLCLK,
      WM_NCRBUTTONDOWN, WM_NCRBUTTONUP, WM_NCRBUTTONDBLCLK,
      WM_NCMBUTTONDOWN, WM_NCMBUTTONUP, WM_NCMBUTTONDBLCLK:
      begin
        if (Sender = FRoot) and (FRoot is TCustomForm) and
           (FDesignPanel <> nil) then
        begin
          LWMNCHitTest := TWMNCHitMessage(Message);
          Result       := (LWMNCHitTest.HitTest = HTCAPTION) or
                          (LWMNCHitTest.HitTest = HTMENU) or
                          (LWMNCHitTest.HitTest = HTREDUCE) or
                          (LWMNCHitTest.HitTest = HTSYSMENU) or
                          (LWMNCHitTest.HitTest = HTZOOM) or
                          (LWMNCHitTest.HitTest = HTCLOSE) or
                          (LWMNCHitTest.HitTest = HTHELP);
        end;
      end;
      WM_MOUSEFIRST..WM_MOUSELAST:
      begin
        case Message.Msg of
          WM_LBUTTONDOWN, WM_LBUTTONDBLCLK, WM_MBUTTONDOWN, WM_MBUTTONDBLCLK,
          WM_RBUTTONDOWN, WM_RBUTTONDBLCLK:
          begin
            Windows.SetFocus(FForm.Handle);
            if Message.Msg = WM_LBUTTONDOWN then
              Include(FState, desClicked);
            if (Message.Msg = WM_LBUTTONDBLCLK) and
               not (desDrawMode in FState) then
            begin
              CancelMode;
              FDesigner.DblClick;
            end;
            LButton := mbLeft; // Initialize
            LShift := [];      // Initialize
            case Message.Msg of
              WM_LBUTTONDOWN:    begin LButton := mbLeft; LShift := [] end;
              WM_LBUTTONDBLCLK:  begin LButton := mbLeft; LShift := [ssDouble] end;
              WM_MBUTTONDOWN:    begin LButton := mbMiddle; LShift := [] end;
              WM_MBUTTONDBLCLK:  begin LButton := mbMiddle; LShift := [ssDouble] end;
              WM_RBUTTONDOWN:    begin LButton := mbRight; LShift := [] end;
              WM_RBUTTONDBLCLK:  begin LButton := mbRight; LShift := [ssDouble] end;
            end;
            LWMMouse := TWMMouse(Message);
            LShift := KeysToShiftState(LWMMouse.Keys) + LShift;
            LP := Sender.ClientToScreen(SmallPointToPoint(LWMMouse.Pos));

            with FDesigner.Module.ScreenToClient(LP) do
              FDesigner.MouseDown(LButton, LShift, X, Y);
          end;
          WM_LBUTTONUP, WM_MBUTTONUP, WM_RBUTTONUP:
          begin
            if (Message.Msg = WM_LBUTTONUP) and (desClicked in FState) then
            begin
              Exclude(FState, desClicked);
              FDesigner.Click;
            end;
            LButton := mbLeft; // Initialize
            case Message.Msg of
              WM_LBUTTONUP: LButton := mbLeft;
              WM_MBUTTONUP: LButton := mbMiddle;
              WM_RBUTTONUP: LButton := mbRight;
            end;

            LWMMouse := TWMMouse(Message);
            LShift := KeysToShiftState(LWMMouse.Keys);
            LP := Sender.ClientToScreen(SmallPointToPoint(LWMMouse.Pos));
            with FDesigner.Module.ScreenToClient(LP) do
              FDesigner.MouseUp(LButton, LShift, X, Y);
            if Message.Msg = WM_RBUTTONUP then
            begin
              GetCursorPos(LP);
              _ContextPopup(LP);
              Message.Result := 1;
            end;
          end;
          WM_MOUSEMOVE:
          begin
            LWMMouse := TWMMouse(Message);
            LShift := KeysToShiftState(LWMMouse.Keys);
            LP := Sender.ClientToScreen(SmallPointToPoint(LWMMouse.Pos));
            with FDesigner.Module.ScreenToClient(LP) do
              FDesigner.MouseMove(LShift, X, Y);
          end;
          WM_MOUSEWHEEL:
          begin
            LWMMouse := TWMMouse(Message);
            LWMMouseWheel := TWMMouseWheel(Message);
            LShift := KeysToShiftState(LWMMouse.Keys);
            FDesigner.DoMouseWheel(LShift, LWMMouseWheel.WheelDelta,
              SmallPointToPoint(LWMMouse.Pos));
          end;
        end;
        Result := MouseMessage(Sender, Message);
      end;
      WM_KEYFIRST..WM_KEYLAST:
      begin
        if (Message.Msg = WM_SYSCHAR) then
          Result := False
        else
        begin
          LWMKey := TWMKey(Message);
          case Message.Msg of
            WM_KEYDOWN, WM_SYSKEYDOWN:  Result := FDesigner.DoKeyDown(LWMKey);
            WM_KEYUP, WM_SYSKEYUP:      Result := FDesigner.DoKeyUp(LWMKey);
            WM_CHAR:                    Result := FDesigner.DoKeyPress(LWMKey);
          end;
          if not Result then
            Result := KeyMessage(Message);
        end;
      end;
      CN_CHAR,
      CN_SYSCHAR,
      CN_KEYDOWN,
      CN_SYSKEYDOWN:
      begin
        LWMKey := TWMKey(Message);
        case LWMKey.CharCode of
          VK_TAB, VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN:
            ; // Do nothing.
        else
          if FDesigner.FDesignPanel <> nil then
          begin
            GetParentForm(FDesigner.FDesignPanel).Dispatch(Message);
            Result := (Message.Result <> 0);
          end;
        end;
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.PaintGrid;
begin
  if FGrid.Visible then
  begin
    if (FGridBrush = 0) or (FGridBkColor <> GetThemedFormColor) or
       (FGridFgColor <> GetThemedGridColor) or
       (FForm.HorzScrollBar.ScrollPos <> FGridHScrollPos) or
       (FForm.VertScrollBar.ScrollPos <> FGridVScrollPos) then
      UpdateGridPattern;

    // Condition below is required. It prevents grid drawing on a child canvas
    // during DrawParentBackground operation. This behavior is equal to Delphi
    // behavior itself; otherwise the grid, painted on a child canvas, will be
    // potentially misalinged with form grid. This is clearly visible with XP
    // themes turned on on TButton/TCheckBox controls.

    if WindowFromDC(FForm.Canvas.Handle) = FForm.Handle then
      FillRect(FForm.Canvas.Handle, FForm.ClientRect, FGridBrush);
  end;
end;

{$IFDEF LMDCOMP9}
{ ---------------------------------------------------------------------------- }
procedure TEngine.PaintMenu;
begin
  // Do nothing.
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }
procedure TEngine.ValidateRename(AComponent: TComponent;
  const CurName, NewName: string);
var
  LNonvisCont: TNonvisualControl;
  errmsg:      TLMDString;
begin
  if AComponent = nil then // Look in TComponent.SetName
    AComponent := FRoot;   //

  if (AComponent is TControl {!!!!!}) and IsDesignControl(TControl(AComponent)) and
     (NewName <> '') then
  begin
    errmsg := '';
    if not FDesigner.FModule.IsValidCompName(AComponent, NewName, errmsg) then
    begin
      if errmsg = '' then
        errmsg := format(SInvalidName, [NewName]);
      raise ELMDDesigner.Create(errmsg);
    end;

    if not FDesigner.FModule.IsUniqueCompName(NewName) then
      raise ELMDDesigner.CreateFmt(SDuplicateName, [NewName]);
  end;

  if not (AComponent is TControl) then
  begin
    LNonvisCont := FindNonvisualControl(AComponent);
    if LNonvisCont <> nil then
      LNonvisCont.Renaming(NewName);
  end;
end;

{ ---------------------------------------------------------------------------- }
{$IFDEF LMDCOMP17}
procedure TEngine.DrawSelectionMarks(AControl: TControl);
begin
  // Do nothing.
end;

function TEngine.IsSelected(AControl: TControl): Boolean;
begin
  result := false;
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }
function TEngine.UniqueName(const BaseName: string): string;
begin
  Result := FDesigner.FModule.GetUniqueCompName(BaseName);
end;

{ ---------------------------------------------------------------------------- }
function TEngine.GetRoot: TComponent;
begin
  Result := FRoot;
end;

{ ---------------------------------------------------------------------------- }
function TEngine.IsDesignControl(AControl: TControl;
  ARejectTransparent: Boolean): Boolean;
begin
  Result := (AControl = FRoot) or
            ((csDesigning in AControl.ComponentState) and
             LMDIsOwnerValid(FRoot, AControl.Owner)) or
            (AControl is TNonvisualControl);

  if ARejectTransparent and Result and (AControl <> FRoot) then
    Result := not FDesigner.DoGetTransparence(AControl);
end;

{ ---------------------------------------------------------------------------- }
function TEngine.GetDesignControl(AControl: TControl): TControl;
begin
  Result := nil;
  while AControl <> nil do
  begin
    if IsDesignControl(AControl) then
    begin
      Result := AControl;
      Break;
    end;
    AControl := GetControlParent(AControl);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TEngine.GetContainer(AControl: TControl;
  AIsForInserting: Boolean): TWinControl;
var
  LCanBeACont: Boolean;
begin
  Result := nil;
  while AControl <> nil do
  begin
    LCanBeACont := (AControl is TWinControl) and
                   not (AControl is TNonvisualControl) and
                   not (AControl is TNonvisualControlLabel) and
                  (csAcceptsControls in TWinControl(AControl).ControlStyle);

    if AIsForInserting then
      LCanBeACont := LCanBeACont and not LMDIsFrameCopy(AControl) and
                     not LMDIsOwnedByFrameCopy(AControl);

    if LCanBeACont then
    begin
      Result := TWinControl(AControl);
      Break;
    end;
    
    AControl := GetControlParent(AControl);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TEngine.GetControlParent(AControl: TControl): TWinControl;
var
  LNonvisComp: TComponent;
begin
  if AControl is TNonvisualControl then
    LNonvisComp := TNonvisualControl(AControl).Component
  else if AControl is TNonvisualControlLabel then
    LNonvisComp := TNonvisualControlLabel(AControl).FControl.Component
  else
    LNonvisComp := nil;

  if LNonvisComp <> nil then
  begin
    if (LNonvisComp.Owner <> nil) and (LNonvisComp.Owner is TWinControl) then
      Result := TWinControl(LNonvisComp.Owner)
    else
      Result := FRoot;
  end
  else
    Result := AControl.Parent;
end;

{ ---------------------------------------------------------------------------- }
function TEngine.MouseMessage(ASender: TControl;
  const  AMessage: TMessage): Boolean;

  function _DispatchDesignHitTest(ASender: TControl;
                                  ALMessage: TMessage): Boolean;
  begin
    ALMessage.Msg    := CM_DESIGNHITTEST;
    ALMessage.Result := 0;
    
    ASender.Dispatch(ALMessage);
    Result := (ALMessage.Result <> 0);
  end;

  procedure _InitDrawMode(AControlToDrawOn: TWinControl;
                          ADrawHandlerClass: TEngDrawHandlerClass;
                          ASkipXCursorMoving, ASkipYCursorMoving: Boolean);
  begin
    FDrawHandler := ADrawHandlerClass.Create(Self, AControlToDrawOn,
                                             ASkipXCursorMoving,
                                             ASkipYCursorMoving);
    FDrawHandler.InitDraw;

    Include(FState, desDrawMode);
  end;

  procedure _FinDrawMode(AApply: Boolean);
  begin
    try
      FDrawHandler.FinDraw(AApply);
    finally
      FDrawHandler.Free;
      FDrawHandler := nil;

      Exclude(FState, desDrawMode); 
    end;
  end;

  function _ControlFromChildParent(AChildParent: TWinControl): TControl;
  var
    LI: Integer;
  begin
    Result := nil;
    if TComponentAccess(FRoot).GetChildParent = AChildParent then
      Result := FRoot
    else
    begin
      for LI := 0 to FRoot.ComponentCount - 1 do
        if (FRoot.Components[LI] is TControl) and
           (TComponentAccess(FRoot.Components[LI]).GetChildParent = AChildParent) then
        begin
          Result := FRoot.Components[LI] as TControl;
          Break;
        end;
    end;
  end;

var
  LI:                  Integer;
  LDesignMessage:      Boolean;
  LControl:            TControl;
  LContainer:          TWinControl;
  LS:                  TLMDString;
  LInsertingComponent: Boolean;
  LNeedMove:           Boolean;
  LControls:           TList;
  LShiftState:         TShiftState;
  LWMMouse:            TWMMouse;
  LMessage:            TMessage;
begin
  LWMMouse := TWMMouse(AMessage);
  LMessage := TMessage(AMessage);
  
  Result := (desDrawMode in FState) or (AMessage.Msg = RMDsgnrSizing);
  if not Result then
  begin
    LDesignMessage := _DispatchDesignHitTest(ASender, LMessage);
    Result         := Result or not LDesignMessage;
  end;

  if AMessage.Msg = RMDsgnrSizing then
  begin
    if not (lmNoResize in GetLockMode(ASender)) then
    begin
      FSelCtrls.SetVisible(False);
      FSelCtrls.ClearExcept(ASender);

      _InitDrawMode(GetControlParent(ASender), TEngResizeHandler,
            TSelCtrlItem(FSelCtrls.FItems[0]).FActivePos in [ppTop, ppBottom],
            TSelCtrlItem(FSelCtrls.FItems[0]).FActivePos in [ppLeft, ppRight]);
    end;
  end
  else if AMessage.Msg = RMDsgnrCancel then
  begin
    if desDrawMode in FState then
    begin
      _FinDrawMode(False);
      FSelCtrls.SetVisible(True);
    end;
  end
  else
    case AMessage.Msg of
      WM_LBUTTONDOWN, WM_RBUTTONDOWN:
      begin
        LShiftState := KeysToShiftState(LWMMouse.Keys);

        if not ((ASender = FForm) and (FRoot <> FForm)) then // If not non-root
                                                             // underlying form.
        begin
          { Try init insert mode }

          LInsertingComponent := False;

          if AMessage.Msg = WM_LBUTTONDOWN then
          begin
            LContainer := GetContainer(ASender, True);

            if LContainer <> nil then
            begin
              LControl := _ControlFromChildParent(LContainer);

              if (LControl <> nil) and not (lmNoInsertIn in GetLockMode(LControl)) then
              begin
                FInsertingComponentClass := nil;
                FDesigner.ComponentInserting(FInsertingComponentClass);
                
                if FInsertingComponentClass <> nil then
                begin
                  LInsertingComponent := True;
                  _InitDrawMode(LContainer, TEngInsertHandler, False, False);
                end;
              end;
            end;
          end;

          { If no insertion }

          if not LInsertingComponent then
          begin
            if ssShift in LShiftState then
            begin
              { Selection addition with shift key }

              ASender := GetDesignControl(ASender);
              FSelCtrls.BeginUpdate;
              try
                if FSelCtrls.IndexOf(ASender) = -1 then
                begin
                  if not ((ASender = FRoot) and (FSelCtrls.Count <> 0)) then
                    FSelCtrls.Add(ASender);
                end
                else
                  FSelCtrls.Remove(ASender);

                if FSelCtrls.Count = 0 then
                  FSelCtrls.Add(FRoot);
              finally
                FSelCtrls.EndUpdate;
              end;
            end
            else if (GetDesignControl(ASender) = FRoot) or
                    (ssCtrl in LShiftState) then
            begin
              { Init selection mode }

              FSelCtrls.ClearExcept(FRoot);
              if Result and (AMessage.Msg = WM_LBUTTONDOWN) then
              begin
                LContainer := GetContainer(ASender, False);
                if LContainer <> nil then
                  _InitDrawMode(LContainer, TEngSelectHandler, False, False);
              end;
            end
            else
            begin
              { Init moving mode }

              LControls := TList.Create;
              try
                ASender := GetDesignControl(ASender);
                if FSelCtrls.IndexOf(ASender) = -1 then
                  LControls.Add(ASender)
                else
                begin
                  FSelCtrls.ClearNotChildrensOf(
                    GetControlParent(ASender));
                  FSelCtrls.GetControls(LControls);
                end;
                if Result and (AMessage.Msg = WM_LBUTTONDOWN) then
                begin
                  LNeedMove := False;
                  for LI := 0 to LControls.Count - 1 do
                    if not (lmNoMove in GetLockMode(TControl(LControls[LI]))) then
                    begin
                      LNeedMove := True;
                      Break;
                    end;
                    
                  if not (lmNoMove in GetLockMode(ASender)) and LNeedMove then
                  begin
                    for LI := LControls.Count - 1 downto 0 do
                      if lmNoMove in GetLockMode(TControl(LControls[LI])) then
                        LControls.Delete(LI);
                        
                    FSelCtrls.SetVisible(False);
                    SelectControls(LControls);
                    
                    _InitDrawMode(GetControlParent(ASender), TEngMoveHandler,
                                  False, False);
                  end
                  else
                    SelectControls(LControls);
                end
                else
                  SelectControls(LControls);
              finally
                LControls.Free;
              end;
            end;
          end;
        end;
      end;
      WM_MOUSEMOVE:
      begin
        if desDrawMode in FState then
          FDrawHandler.MoveDraw
        else
        begin
          ASender := GetDesignControl(ASender);
          if ASender <> nil then
          begin
            if (ASender = FRoot) or (ASender = FForm) or not Result then
              FHint.CancelHint
            else
              if FHintControl <> ASender then
              begin
                if dhComponent in FDesigner.Hints then
                begin
                  LS := Format('%s: %s', [CompByControl(ASender).Name,
                               CompByControl(ASender).ClassName]);

                  FDesigner.DoComponentHint(CompByControl(ASender), LS);
                  if LS <> '' then
                    FHint.ActivateHint(not FHint.Active, True, True,
                                       ASender, LS)
                  else
                    FHint.CancelHint;
                end
                else
                  FHint.CancelHint;
              end;
            if Result then
              FHintControl := ASender
            else
              FHintControl := nil;
          end;
        end;
      end;
      WM_LBUTTONUP:
      begin
        if desDrawMode in FState then
        begin
          _FinDrawMode(True);
          FSelCtrls.SetVisible(True);
        end;
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TEngine.KeyMessage(const AMessage: TMessage): Boolean;

type
  TDirection = (dNone, dLeft, dUp, dRight, dDown);

  function _CalcDistance(AFromRect, AToRect: TRect;
    ADirection: TDirection): Real;
  const
    LRotateCount: array[TDirection] of Integer = (-1, 4, 3, 2, 1);
  var
    LI: Integer;
    LBufRect: TRect;
    LFromP, LToP: TPoint;
  begin
    Result := -1;
    if LRotateCount[ADirection] = -1 then Exit;
    for LI := 1 to LRotateCount[ADirection] do
      begin
        LBufRect := AFromRect;
        AFromRect.TopLeft := Point(-LBufRect.Bottom, LBufRect.Left);
        AFromRect.BottomRight := Point(-LBufRect.Top, LBufRect.Right);
        LBufRect := AToRect;
        AToRect.TopLeft := Point(-LBufRect.Bottom, LBufRect.Left);
        AToRect.BottomRight := Point(-LBufRect.Top, LBufRect.Right);
      end;
    if AToRect.Right < AFromRect.Left then
      begin
        if (AToRect.Bottom < AFromRect.Top) and
          (AFromRect.Top - AToRect.Bottom > AFromRect.Left - AToRect.Right) then
          Exit;
        if (AToRect.Top > AFromRect.Bottom) and
          (AToRect.Top - AFromRect.Bottom > AFromRect.Left - AToRect.Right) then
          Exit;
      end
    else
      if (AToRect.Left <= AFromRect.Right) and
        (AToRect.Right >= AFromrect.Left) then
        begin
          if AToRect.Bottom < AFromRect.Top then Exit;
          if AToRect.Top > AFromRect.Bottom then Exit;
          if (AToRect.Left + AToRect.Right) div 2 >=
            (AFromRect.Left + AFromRect.Right) div 2 then Exit;
        end
      else
        Exit;
    LFromP := Point(AFromRect.Left, (AFromRect.Top + AFromRect.Bottom) div 2);
    if AToRect.Right < AFromRect.Left then
      begin
        if AToRect.Bottom < LFromP.y then LToP := AToRect.BottomRight
          else
            if AToRect.Bottom > LFromP.y then
              LToP := Point(AToRect.Right, AToRect.Top)
            else
              LToP := Point(AToRect.Right, LFromP.y);
      end
    else
      if AToRect.Top > LFromP.y then LToP := Point(AToRect.Top, LFromP.y)
        else
          if AToRect.Bottom < LFromP.y then
            LToP := Point(AToRect.Bottom, LFromP.y)
          else
            LToP := LFromP;
    Result := Sqrt((LFromP.x - LToP.x) * (LFromP.x - LToP.x) +
      (LFromP.y - LToP.y) * (LFromP.y - LToP.y));
  end;

  function _FindNearControl(AForward: Boolean): TControl;

    function __DoFind(AFromIndex, AToIndex: Integer;
      AForward: Boolean): TControl;
    var
      LControl: TControl;
    begin
      Result := nil;
      while AFromIndex * (-1 + 2 * Ord(AForward)) <=
        AToIndex * (-1 + 2 * Ord(AForward)) do
        begin
          LControl := FindControl(FRoot.Components[AFromIndex]);
          if (LControl <> nil) and IsDesignControl(LControl) and
            (GetControlParent(LControl) <> nil) then
            begin
              Result := LControl;
              Break;
            end;
          Inc(AFromIndex, -1 + 2 * Ord(AForward));
        end;
    end;

  var
    LMainComponent: TComponent;

  begin
    Result := nil;
    if FSelCtrls.Count > 0 then
      begin
        LMainComponent := CompByControl(FSelCtrls.DefControl);
        if LMainComponent <> FRoot then
          begin
            Result := __DoFind(LMainComponent.ComponentIndex +
              (-1 + 2 * Ord(AForward)), (FRoot.ComponentCount - 1) *
              Ord(AForward), AForward);
            if Result = nil then
              Result := __DoFind((FRoot.ComponentCount - 1) * Ord(not AForward),
                LMainComponent.ComponentIndex + (1 - 2 * Ord(AForward)), AForward);
          end;
      end;
  end;

var
  LShiftState: TShiftState;
  LControl, LChousedControl: TControl;
  LI, LdX, LdY: Integer;
  LControlOffset, LChousedControlOffset: Real;
  LDirection: TDirection;
  LWMKeyDown: TWMKeyDown;
begin
  Result := True;
  LWMKeyDown := TWMKeyDown(AMessage);
  case AMessage.Msg of
    WM_KEYDOWN, WM_SYSKEYDOWN:
      begin
        LShiftState := KeyDataToShiftState(LWMKeyDown.KeyData);
        case LWMKeyDown.CharCode of
          VK_ESCAPE:
            if desDrawMode in FState then
              CancelMode
            else
              begin
                LControl := nil;
                if (FSelCtrls.DefControl <> nil) and
                  (GetControlParent(FSelCtrls.DefControl) <> nil)
                then
                  LControl := GetDesignControl(GetControlParent(
                    FSelCtrls.DefControl));
                if LControl = nil then
                  LControl := FRoot;
                FSelCtrls.ClearExcept(LControl);
              end;
          VK_LEFT, VK_UP, VK_RIGHT, VK_DOWN:
            if (FSelCtrls.Count > 0) then
              begin
                CancelMode;
                if ((ssShift in LShiftState) or (ssCtrl in LShiftState)) then
                  begin
                    if FSelCtrls.DefControl <> FRoot then
                      begin
                        FSelCtrls.BeginUpdate;
                        try
                          FSelCtrls.ClearNotChildrensOf(
                            GetControlParent(FSelCtrls.DefControl));
                          if ssShift in LShiftState then
                            begin
                              for LI := FSelCtrls.Count - 1 downto 0 do
                                if lmNoResize in GetLockMode(FSelCtrls[LI]) then
                                  FSelCtrls.Delete(LI);
                            end
                          else
                            for LI := FSelCtrls.Count - 1 downto 0 do
                              if lmNoMove in GetLockMode(FSelCtrls[LI]) then
                                FSelCtrls.Delete(LI);
                        finally
                          FSelCtrls.EndUpdate;
                        end;
                        if FSelCtrls.Count > 0 then
                          begin
                            LdX := 0;
                            LdY := 0;
                            case LWMKeyDown.CharCode of
                              VK_LEFT: LdX := -1;
                              VK_UP: LdY := - 1;
                              VK_RIGHT: LdX := 1;
                              VK_DOWN: LdY := 1;
                            end;
                            if (LdX <> 0) or (LdY <> 0) then
                              begin
                                if ssShift in LShiftState then
                                  begin
                                    for LI := 0 to FSelCtrls.Count - 1 do
                                      with FSelCtrls[LI] do
                                        SetBounds(Left, Top, Max(Width + LdX, 0),
                                        Max(Height + LdY, 0));
                                  end
                                else
                                  for LI := 0 to FSelCtrls.Count - 1 do
                                    with FSelCtrls[LI] do
                                      SetBounds(Left + LdX, Top + LdY, Width, Height);
                                Modified;
                              end;
                          end;
                      end;
                  end
                else
                  if (LShiftState = []) then
                    begin
                      if FSelCtrls.DefControl <> FRoot then
                        begin
                          case LWMKeyDown.CharCode of
                            VK_LEFT: LDirection := dLeft;
                            VK_UP: LDirection := dUp;
                            VK_RIGHT: LDirection := dRight;
                            VK_DOWN: LDirection := dDown;
                          else
                            LDirection := dNone;
                          end;
                          LChousedControl := nil;
                          LChousedControlOffset := 1.7E+308; // MaxReal
                          for LI := 0 to
                            GetControlParent(FSelCtrls.DefControl).ControlCount - 1 do
                            begin
                              LControl := GetControlParent(
                                FSelCtrls.DefControl).Controls[LI];
                              if (LControl <> FSelCtrls.DefControl) and
                                IsDesignControl(LControl) then
                                begin
                                  LControlOffset := _CalcDistance(
                                    FSelCtrls.DefControl.BoundsRect,
                                    LControl.BoundsRect, LDirection);
                                  if (LControlOffset >= 0) and
                                    (LChousedControlOffset > LControlOffset) then
                                    begin
                                      LChousedControl := LControl;
                                      LChousedControlOffset := LControlOffset;
                                    end;
                                end;
                            end;
                          if GetControlParent(FSelCtrls.DefControl) = FRoot then
                            for LI := 0 to FNonvisualControls.Count - 1 do
                              begin
                                LControl := TControl(FNonvisualControls[LI]);
                                if (LControl <> FSelCtrls.DefControl) and
                                  IsDesignControl(LControl) then
                                  begin
                                    LControlOffset := _CalcDistance(
                                      FSelCtrls.DefControl.BoundsRect,
                                      LControl.BoundsRect, LDirection);
                                    if (LControlOffset >= 0) and
                                      (LChousedControlOffset > LControlOffset) then
                                      begin
                                        LChousedControl := LControl;
                                        LChousedControlOffset := LControlOffset;
                                      end;
                                  end;
                              end;
                          if LChousedControl <> nil then
                            FSelCtrls.ClearExcept(LChousedControl);
                        end;
                    end;
              end;
          VK_TAB:
            begin
              CancelMode;
              LChousedControl := _FindNearControl(not (ssShift in LShiftState));
              if LChousedControl <> nil then
                FSelCtrls.ClearExcept(LChousedControl);
            end;
          VK_DELETE:
            DeleteSelectedComps;
          Ord('A'):
            if (ssCtrl in LShiftState) and not (ssShift in LShiftState) then
              SelectAll;
          Ord('X'):
            if (ssCtrl in LShiftState) and not (ssShift in LShiftState) then
              FDesigner.CutToClipboard;
          Ord('C'):
            if (ssCtrl in LShiftState) and not (ssShift in LShiftState) then
              FDesigner.CopyToClipboard;
          Ord('V'):
            if (ssCtrl in LShiftState) and not (ssShift in LShiftState) then
              FDesigner.PasteFromClipboard;
        end;
      end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.LockControl(AControl: TControl;
  ALockMode: TLMDDesignerLockMode);
var
  LIntLockMode: Integer;
begin
  if IsDesignControl(AControl) and (AControl <> FRoot) then
  begin
    LIntLockMode        := PInteger(@ALockMode)^;
    AControl.DesignInfo := LIntLockMode;
    UpdateControlMouseHandles(AControl);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.ClearLocks;

  procedure _DoClearLocks(AOwner: TComponent);
  var
    i:    Integer;
    comp: TComponent;
    ctrl: TControl;
  begin
    for i := 0 to AOwner.ComponentCount - 1 do
    begin
      comp := AOwner.Components[i];
      ctrl := FindControl(comp); // Can be nil, if no visual
                                 // representation is exist.

      if ctrl <> nil then
        LockControl(ctrl, []);

      if LMDIsFrameCopy(comp) then
        _DoClearLocks(comp);
    end;
  end;

begin
  _DoClearLocks(FRoot);
end;

{ ---------------------------------------------------------------------------- }
class function TEngine.GetLockMode(AControl: TControl): TLMDDesignerLockMode;
var
  LIntLockMode: Integer;
begin
  LIntLockMode := AControl.DesignInfo;
  Result       := TLMDDesignerLockMode((@LIntLockMode)^);
end;

{ ---------------------------------------------------------------------------- }
class function TEngine.GetFullLockMode(
  AControl: TControl): TLMDDesignerLockMode;
var
  LI: Integer;
begin
  Result := GetLockMode(AControl);
  if AControl is TWinControl then
    for LI := 0 to TWinControl(AControl).ControlCount - 1 do
      Result := Result + GetLockMode(TWinControl(AControl).Controls[LI]);
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.AlignToGrid(AControl: TControl);
var
  LNewLeft, LNewTop: Integer;
begin
  if (AControl <> FRoot) and IsDesignControl(AControl) then
    begin
      LNewLeft := Round(AControl.Left / FGrid.XStep) * FGrid.XStep;
      LNewTop := Round(AControl.Top / FGrid.YStep) * FGrid.YStep;
      SetPosition(AControl, LNewLeft, LNewTop);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.SetPosition(AControl: TControl; ALeft, ATop: Integer);
begin
  if (AControl <> FRoot) and IsDesignControl(AControl) then
    begin
      AControl.SetBounds(ALeft, ATop, AControl.Width, AControl.Height);
      Modified;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TEngine.ControlAtPos(const APos: TPoint): TControl;
begin
  Result := FindDragTarget(FRoot.ClientToScreen(APos), True);
  if Result <> nil then
    Result := GetDesignControl(Result);
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.SelectControls(AControls: TList);
var
  LI: Integer;
begin
  FSelCtrls.BeginUpdate;
  try
    for LI := FSelCtrls.Count - 1 downto 0 do
      if AControls.IndexOf(FSelCtrls[LI]) = -1 then
        FSelCtrls.Delete(LI);

    for LI := 0 to AControls.Count - 1 do
      if FSelCtrls.IndexOf(TControl(AControls[LI])) = -1 then
        FSelCtrls.Add(TControl(AControls[LI]));
  finally
    FSelCtrls.EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.ClearNonvisualControls;
begin
  while FNonvisualControls.Count <> 0 do
    TNonvisualControl(FNonvisualControls[0]).Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.AddNonvisualControl(AComp: TComponent);
var
  h: THandle;
begin
  if FindNonvisualControl(AComp) = nil then
  begin
    if (AComp.Owner <> nil) and (AComp.Owner is TWinControl) then
      h := TWinControl(AComp.Owner).Handle
    else
      h := FRoot.Handle;

    with TNonvisualControl.Create(Self, AComp) do
      SetParentHandle(h);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.RemoveNonvisualControl(AComp: TComponent);
var
  LControl: TNonvisualControl;
begin
  LControl := FindNonvisualControl(AComp);
  if LControl <> nil then
    LControl.Free;
end;

{ ---------------------------------------------------------------------------- }
function TEngine.FindNonvisualControl(AComp: TComponent): TNonvisualControl;
var
  LI: Integer;
begin
  Result := nil;
  for LI := 0 to FNonvisualControls.Count - 1 do
    if TNonvisualControl(FNonvisualControls[LI]).Component = AComp then
    begin
      Result := TNonvisualControl(FNonvisualControls[LI]);
      Break;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TEngine.NonvisualControlByComp(
  AComp: TComponent): TNonvisualControl;
begin
  Result := FindNonvisualControl(AComp);
  if Result = nil then
    raise ELMDDesigner.CreateFmt(SLMDDsgnrCompHaveNoVisualRepr,
                                 [AComp.Name]);
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.RecreateNonvisualControls;

  procedure _Iterate(AOwner: TComponent);
  var
    LI: Integer;
  begin
    for LI := 0 to AOwner.ComponentCount - 1 do
    begin
      if not (AOwner.Components[LI] is TControl) and
         not IsCompHidden(AOwner.Components[LI]) then
        AddNonvisualControl(AOwner.Components[LI]);

      if LMDIsFrameCopy(AOwner.Components[LI]) then
        _Iterate(AOwner.Components[LI]);
    end;
  end;

begin
  ClearNonvisualControls;
  _Iterate(FRoot);
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.UpdateNonvisualControls;
var
  LI: Integer;
begin
  for LI := 0 to FNonvisualControls.Count - 1 do
    TNonvisualControl(FNonvisualControls[LI]).Update;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.RepaintNonvisualControls;
var
  LI: Integer;
begin
  for LI := 0 to FNonvisualControls.Count - 1 do
    TNonvisualControl(FNonvisualControls[LI]).Invalidate;
end;

{ ---------------------------------------------------------------------------- }
function TEngine.CompByControl(AControl: TControl): TComponent;
begin
  if AControl is TNonvisualControl then
    Result := TNonvisualControl(AControl).Component
  else
    Result := AControl;
end;

{ ---------------------------------------------------------------------------- }
function TEngine.FindControl(AComp: TComponent): TControl;
begin
  if AComp is TControl then
    Result := TControl(AComp)
  else
    Result := FindNonvisualControl(AComp);
end;

{ ---------------------------------------------------------------------------- }
function TEngine.ControlByComp(AComp: TComponent): TControl;
begin
  if AComp is TControl then
    Result := TControl(AComp)
  else
    Result := NonvisualControlByComp(AComp);
end;

{ ---------------------------------------------------------------------------- }
function TEngine.GetCompParent(AComp: TComponent): TWinControl;
var
  LControl: TControl;
begin
  LControl := FindControl(AComp);
  if LControl <> nil then
    Result := GetControlParent(LControl)
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.ClipbrdSave(AStream: TStream;
  AComponents: TList);
begin
  FDesigner.FModule.ClipboardSave(AStream, AComponents);
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.ClipbrdLoad(AStream: TStream; AParent: TWinControl);
begin
  FSelCtrls.BeginUpdate;
  try
    FSelCtrls.Clear;
    FDesigner.FModule.ClipboardLoad(AStream, AParent, ReaderReadComponent);
  finally
    FSelCtrls.EndUpdate;
  end;
  UpdateDesignerAllComponents;
  Modified;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.SelectAll;
var
  LI: Integer;
  LControl: TControl;
begin
  FSelCtrls.BeginUpdate;
  try
    for LI := 0 to FRoot.ComponentCount - 1 do
    begin
      LControl := FindControl(FRoot.Components[LI]);
      if (LControl <> nil) and IsDesignControl(LControl) then
        FSelCtrls.Add(LControl);
    end;
  finally
    FSelCtrls.EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.SelectComps(AComps: TList);
var
  LI:        Integer;
  LControls: TList;
begin
  LControls := TList.Create;
  try
    for LI := 0 to AComps.Count - 1 do
      LControls.Add(ControlByComp(TComponent(AComps[LI])));
    SelectControls(LControls);
  finally
    LControls.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TEngine.IndexOfSelectedComp(
  AComp: TComponent): Integer;
var
  LControl: TControl;
begin
  Result := -1;

  if AComp is TControl then
    LControl := AComp as TControl
  else
    LControl := FindNonvisualControl(AComp);

  if LControl <> nil then
    Result := FSelCtrls.IndexOf(LControl)
end;

{ ---------------------------------------------------------------------------- }
function TEngine.IsCompHidden(AComp: TComponent): Boolean;
begin
  Result := FDesigner.IsComponentHidden(AComp);
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.DeleteSelectedComps;
var
  LI: Integer;
  LLockedIndex: Integer;
begin
  CancelMode;
  if ((FSelCtrls.Count = 1) and (FSelCtrls[0] <> FRoot)) or
    (FSelCtrls.Count > 1) then
    begin
      FSelCtrls.BeginUpdate;
      try
        LLockedIndex := -1;
        for LI := 0 to FSelCtrls.Count - 1 do
          if (FSelCtrls[LI] <> FRoot) and
            (lmNoDelete in GetFullLockMode(FSelCtrls[LI])) then
              if LLockedIndex = -1 then
                LLockedIndex := LI
              else
                LLockedIndex := -2;
        if LLockedIndex = -1 then
          begin
            LI := FSelCtrls.Count - 1;
            while True do
              begin
                if LI > FSelCtrls.Count - 1 then
                  LI := FSelCtrls.Count - 1;
                if LI < 0 then
                  Break;
                if FSelCtrls[LI] <> FRoot then
                  CompByControl(FSelCtrls[LI]).Free;
                Dec(LI);
              end;
          end
        else if LLockedIndex = -2 then
          raise ELMDDesigner.Create(SLMDDsgnrCompsLockedDel)
        else
          raise ELMDDesigner.CreateFmt(SLMDDsgnrCompLockedDel,
            [FSelCtrls[LLockedIndex].Name]);
      finally
        FSelCtrls.EndUpdate;
      end;
      Modified;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.UpdateDesignerSelection;
var
  LList: TList;
begin
  if desUpdatingEngSeln in FState then
    Exit;

  LList := TList.Create;
  Include(FState, desUpdatingDesSeln);
  try
    FSelCtrls.GetComps(LList);
    if FDesigner.FExcludeRoot then
      LList.Remove(FRoot);
      
    FDesigner.FSelection.SetItems(LList);
  finally
    Exclude(FState, desUpdatingDesSeln);
    LList.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.UpdateEngineSelection;
var
  LI:      Integer;
  LList:   TList;
  LComp:   TComponent;
  LIsCtrl: Boolean;
begin
  if desUpdatingDesSeln in FState then
    Exit;

  LList := TList.Create;
  Include(FState, desUpdatingEngSeln);
  try
    FDesigner.FSelection.GetComps(LList);
    for LI := LList.Count - 1 downto 0 do
    begin
      LComp   := TComponent(LList[LI]);
      LIsCtrl := (LComp is TControl);
      if (LIsCtrl and not IsDesignControl(TControl(LComp))) or
         (not LIsCtrl and (FindNonvisualControl(LComp) = nil)) then
        LList.Delete(LI);
    end;

    SelectComps(LList);
  finally
    Exclude(FState, desUpdatingEngSeln);
    LList.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.DoAddChildrenToAllComps(AOwner: TComponent;
  AResult: TList);
var
  LI:      Integer;
  LComp:   TComponent;
  LTransp: Boolean;
begin
  for LI := 0 to AOwner.ComponentCount - 1 do
  begin
    LComp   := AOwner.Components[LI];
    LTransp := (LComp is TControl) and FDesigner.DoGetTransparence(
                                                            TControl(LComp));

    if not (csDestroying in LComp.ComponentState) and
       not LTransp then
    begin
      FCompNotifier.AddComp(LComp);
      AResult.Add(LComp);

      if LMDIsFrameCopy(LComp) then
        DoAddChildrenToAllComps(LComp, AResult);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.GetAllComponents(AExcludeRoot: Boolean; AResult: TList);
begin
  if not AExcludeRoot then
    AResult.Add(FRoot);
  DoAddChildrenToAllComps(FRoot, AResult);
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.UpdateDesignerAllComponents;
var
  comps: TList;
begin
  if FDesigner.FAllComponents = nil then
    Exit;

  comps := TList.Create;
  try
    GetAllComponents(FDesigner.FExcludeRoot, comps);
    FDesigner.FAllComponents.SetItems(comps);
  finally
    comps.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TEngine.CancelMode;
var
  LCancelMessage: TMessage;
begin
  if desDrawMode in FState then
  begin
    LCancelMessage.Msg := RMDsgnrCancel;
    MouseMessage(FForm, LCancelMessage);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TEngine.CanFocus: Boolean;
begin
  Result := FForm.CanFocus;
end;

{$IFDEF LMDCOMP21}
{ ---------------------------------------------------------------------------- }
procedure TEngine.CanInsertComponent(AComponent: TComponent);
begin
  // Do nothing.
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }
procedure TEngine.SetFocus;
begin
  Windows.SetFocus(FForm.Handle);
end;

{ ------------------------------ public -------------------------------------- }
constructor TEngine.Create(ADesigner: TLMDCustomDesigner; ARoot: TWinControl;
  ADesignPanel: TLMDCustomDesignPanel);
begin
  inherited Create;

  FDesigner                := ADesigner;
  FSelCtrls                := TSelCtrls.Create(Self);
  FNonvisualControls       := TList.Create;
  FCompNotifier            := TEngCompNotifier.Create(Self);
  FMouseHandles            := TList.Create;
  FGrid                    := ADesigner.Grid;
  FHint                    := TEngHint.Create(Self);
  FGridBitmap              := Graphics.TBitmap.Create;
  
  if (ARoot is TCustomForm) and (ADesignPanel = nil) then
  begin
    FRoot        := ARoot;
    FForm        := TCustomForm(ARoot);
    FDesignPanel := nil;
  end
  else if (ARoot is TCustomForm) and (ADesignPanel <> nil) then
  begin
    FRoot        := ARoot;
    FForm        := TCustomForm(ARoot);
    FDesignPanel := ADesignPanel;
    FOldRootLeft := FRoot.Left;
    FOldRootTop  := FRoot.Top;

    FDesignPanel.SetEng(Self);
    FRoot.ParentWindow := FDesignPanel.Form.Handle;
    FRoot.SetBounds(0, 0, FRoot.Width, FRoot.Height);
    FDesignPanel.RootBoundsChanged;
  end
  else
  begin
    FRoot        := ARoot;
    FForm        := ADesignPanel.Form;
    FDesignPanel := ADesignPanel;
    FOldRootLeft := FRoot.Left;
    FOldRootTop  := FRoot.Top;

    FDesignPanel.SetEng(Self);
    FRoot.Parent := FDesignPanel.Form;
    FRoot.SetBounds(0, 0, FRoot.Width, FRoot.Height);
    FDesignPanel.RootBoundsChanged;
  end;

  FForm.Designer := Self;
  TComponentAccess(FForm).SetDesigning(True, False);
  TComponentAccess(FRoot).SetDesigning(True, True);

  FForm.UpdateControlState;
  if FForm.HandleAllocated then
    RedrawWindow(FForm.Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or
      RDW_UPDATENOW or RDW_ALLCHILDREN);

  FSelCtrls.SetRootWinControl(FRoot);
  FSelCtrls.SetActive(Focused);
  FSelCtrls.SetVisible(True);

  if FDesigner.FShowNonvisualComponents then
    RecreateNonvisualControls;
  UpdateMouseHandles;
end;

{ ---------------------------------------------------------------------------- }
destructor TEngine.Destroy;
begin
  Include(FState, desDestroying);

  CancelMode;

  FSelCtrls.SetVisible(False);
  FSelCtrls.Clear;
  FSelCtrls.SetRootWinControl(nil);
  ClearNonvisualControls;

  if not (csDestroying in FForm.ComponentState) then
    TComponentAccess(FForm).SetDesigning(False, False);
  if not (csDestroying in FRoot.ComponentState) then
    TComponentAccess(FRoot).SetDesigning(False, True);

  FForm.Designer := nil;

  if not (csDestroying in FRoot.ComponentState) then
  begin
    if (FRoot is TCustomForm) and (FDesignPanel <> nil) then
      FRoot.ParentWindow := 0
    else
      FRoot.Parent := nil;
    
    if FDesignPanel <> nil then
      FRoot.SetBounds(FOldRootLeft, FOldRootTop,
                      FRoot.Width, FRoot.Height);
  end;

  if FDesignPanel <> nil then
    FDesignPanel.SetEng(nil);

  if not (csDestroying in FForm.ComponentState) then
  begin
    FForm.UpdateControlState;
    
    if FForm.HandleAllocated then
      RedrawWindow(FForm.Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or
                   RDW_UPDATENOW or RDW_ALLCHILDREN);
  end;

  FHint.Free;
  FGridBitmap.Free;
  FNonvisualControls.Free;
  FSelCtrls.Free;
  FCompNotifier.Free;
  FMouseHandles.Free;
  FDefNonVisibleBitmap.Free;
  if FGridBrush <> 0 then
    DeleteObject(FGridBrush);

  inherited;
end;

{ ***************************** class TSelCtrlItem *************************** }
{ ------------------------------ private ------------------------------------- }
procedure TSelCtrlItem.SetMode(const Value: TMouseHandlesMode;
  AUpdateMouseHandles: Boolean);
var
  i: TMouseHandlePos;
begin
  if FMode <> Value then
  begin
    FMode := Value;

    if AUpdateMouseHandles then
    begin
      for i := Low(TMouseHandlePos) to High(TMouseHandlePos) do
        if FPoints[i] <> nil then
          FPoints[i].Update;
    end;
  end;
end;

{ ------------------------------ public -------------------------------------- }
constructor TSelCtrlItem.Create(AOwnerSelCtrls: TSelCtrls;
  AControl: TControl);
var
  LI: TMouseHandlePos;
begin
  inherited Create;

  FSelCtrls := AOwnerSelCtrls;
  FControl  := AControl;

  for LI := ppTopLeft to ppLeft do
  begin
    if AControl = FSelCtrls.FDEng.FRoot then
      FPoints[LI] := TRootMouseHandle.Create(FSelCtrls.FDEng, LI, Self)
    else
      FPoints[LI] := TSelCtrlMouseHandle.Create(FSelCtrls.FDEng, LI, Self);
  end;

  FSelCtrls.FDEng.FCompNotifier.AddComp(FControl);
  FSelCtrls.InsertItem(Self);
end;

{ ---------------------------------------------------------------------------- }
destructor TSelCtrlItem.Destroy;
var
  LI: TMouseHandlePos;
begin
  FSelCtrls.FDEng.FCompNotifier.RemoveComp(FControl);
  FSelCtrls.RemoveItem(Self);

  for LI := ppTopLeft to ppLeft do
    FPoints[LI].Free;
  inherited;
end;

{******************************* TDesignerMenuItem ****************************}
{ ---------------------------------------------------------------------------- }
procedure TDesignerMenuItem.Click;
begin
  case Action of
    miaNone:        ; // Do nothing.
    miaCut:         Designer.CutToClipboard;
    miaCopy:        Designer.CopyToClipboard;
    miaPaste:       Designer.PasteFromClipboard;
    miaSelectAll:   Designer.SelectAll;
  else
    Assert(False);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TDesignerMenuItem.UpdateState;
begin
  case Action of
    miaNone:        ; // Do nothing.
    miaCut:         Enabled := Designer.CanCutToClipboard;
    miaCopy:        Enabled := Designer.CanCopyToClipboard;
    miaPaste:       Enabled := Designer.CanPasteFromClipboard;
    miaSelectAll:   Enabled := True;
  else
    Assert(False);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TEngine.DesignPanelHandleChanging(ANewHandle: Integer);
begin
  if FRoot = nil then
    Exit;
  if ANewHandle <> 0 then
    UpdateMouseHandles;

//  if FRoot is TCustomForm then
//  begin
    if ANewHandle <> 0 then
    begin
      FRoot.ParentWindow := ANewHandle;
      ShowWindow(FRoot.Handle, SW_SHOW);
    end
    else
      FRoot.ParentWindow := 0; // Must be done, otherwise all component
                               // captions (window texts) will be lost.
//  end;

  if FDesigner.FShowNonvisualComponents and (ANewHandle <> 0) then
  begin
    Assert(FRoot.HandleAllocated);
    RecreateNonvisualControls;
  end;
end;
        
{ ---------------------------------------------------------------------------- }

procedure TEngine.UpdateControlMouseHandles(AControl: TControl);
var
  i: Integer;
begin
  FSelCtrls.BeginDefer;
  for i := 0 to FMouseHandles.Count - 1 do
  begin
    if TMouseHandleBase(FMouseHandles[i]).Control = AControl then
      TMouseHandleBase(FMouseHandles[i]).Update;
  end;
  FSelCtrls.EndDefer;
end;

{ ---------------------------------------------------------------------------- }

procedure TEngine.UpdateMouseHandles;
var
  i: Integer;
begin
  FSelCtrls.BeginDefer;
  for i := 0 to FMouseHandles.Count - 1 do
    TMouseHandleBase(FMouseHandles[i]).Update;
  FSelCtrls.EndDefer;
end;

{ ---------------------------------------------------------------------------- }

constructor TMouseHandleBase.Create(ASelCtrl: TSelCtrlItem;
  ADEng: TEngine; APos: TMouseHandlePos);
begin
  inherited Create(nil);
  FSelCtrl     := ASelCtrl;
  FDEng        := ADEng;
  ControlStyle := ControlStyle + [csOpaque];
  Visible      := False;
  FPos         := APos;
  Width        := HandleSize;
  Height       := HandleSize;

  FDEng.FMouseHandles.Add(Self);
end;

procedure TMouseHandleBase.CreateParams(var Params: TCreateParams);
begin
  inherited;
//  Params.ExStyle := Params.ExStyle or WS_EX_TOPMOST;
end;

destructor TMouseHandleBase.Destroy;
begin
  FDEng.FMouseHandles.Remove(Self);
  if HandleAllocated then
    ShowWindow(WindowHandle, SW_HIDE);
  inherited;
end;

function TMouseHandleBase.GetControl: TControl;
var
  LParams: TMouseHandleParams;
begin
  GetHandleParams(LParams);
  Result := LParams.Control;
end;

function TMouseHandleBase.GetThemedBackColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
  begin
    case FState of
      mhcActive:
        Result := LMDBlend(StyleServices.GetStyleFontColor(sfWindowTextNormal),
                           StyleServices.GetStyleColor(scWindow), 30);
      mhcInactive:
        Result := LMDBlend(StyleServices.GetStyleFontColor(sfWindowTextNormal),
                           StyleServices.GetStyleColor(scWindow), 70);
      mhcMulti:
        Result := LMDBlend(StyleServices.GetStyleFontColor(sfWindowTextNormal),
                           StyleServices.GetStyleColor(scWindow), 50);
      mhcLocked:
        Result := StyleServices.GetStyleFontColor(sfWindowTextNormal);
    else
      Assert(False);
      Result := 0; // Initialize.
    end;
  end
  else
  {$ENDIF}
    Result := FColor;
end;

function TMouseHandleBase.GetThemedBorderColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := GetThemedBackColor
  else
  {$ENDIF}
    Result := FBorderColor;
end;

procedure TMouseHandleBase.Paint;
begin
  Canvas.Pen.Color   := GetThemedBorderColor;
  Canvas.Brush.Color := GetThemedBackColor;
  Canvas.Rectangle(0, 0, Width, Height);
end;

procedure TMouseHandleBase.Update;
const
  CURSORS: array[TMouseHandlePos] of TCursor = (
    crSizeNWSE, crSizeNS, crSizeNESW, crSizeWE,
    crSizeNWSE, crSizeNS, crSizeNESW, crSizeWE
  );
  SHOW_FLAGS: array[Boolean] of Integer = (
    SWP_HIDEWINDOW,
    SWP_SHOWWINDOW or SWP_NOACTIVATE
  );
var
  LParams:       TMouseHandleParams;
  LLockMode:     TLMDDesignerLockMode;
  LDesigner:     TLMDCustomDesigner;
  LParent:       TWinControl;
  LParentHandle: Integer;
  LLeft, LTop:   Integer;
  LVisible:      Boolean;
  LShowing:      Boolean;
  flags:         Integer;
  wnd:           HWND;
begin
  GetHandleParams(LParams);

  LParent := FDEng.GetControlParent(LParams.Control);
  if (LParent = nil) and (LParams.Control = FDEng.FRoot) and
     (FDEng.FDesignPanel <> nil) then
    LParent := FDEng.FDesignPanel.Form;

  if (LParent <> nil) and (LParent.HandleAllocated) then
    LParentHandle := LParent.Handle
  else
    LParentHandle := 0;
  if LParentHandle = 0 then
    Exit;

  case FPos of
    ppTopLeft, ppTop, ppTopRight:
      LTop := LParams.Control.Top -
        (HandleSize div 2) * Ord(LParams.Mode = imSizeable);
    ppRight, ppLeft:
      LTop := LParams.Control.Top +
        LParams.Control.Height div 2 - (HandleSize div 2);
    ppBottomRight, ppBottom, ppBottomLeft:
      LTop := LParams.Control.Top + LParams.Control.Height - HandleSize +
        (HandleSize div 2) * Ord(LParams.Mode = imSizeable);
    else
      LTop := 0;
  end;
  case FPos of
    ppTopLeft, ppLeft, ppBottomLeft:
      LLeft := LParams.Control.Left -
        (HandleSize div 2) * Ord(LParams.Mode = imSizeable);
    ppTop, ppBottom:
      LLeft := LParams.Control.Left +
        LParams.Control.Width div 2 - (HandleSize div 2);
    ppTopRight, ppRight, ppBottomRight:
      LLeft := LParams.Control.Left + LParams.Control.Width - HandleSize +
        (HandleSize div 2) * Ord(LParams.Mode = imSizeable);
    else
      LLeft := 0;
  end;

  LDesigner := FDEng.FDesigner;
  LLockMode := TEngine.GetLockMode(LParams.Control);

  if LParams.Active then
  begin
    if LParams.Mode = imSizeable then
    begin
      FState       := mhcActive;
      FBorderColor := LDesigner.HandleBorderColor;
      FColor       := LDesigner.HandleColor;
    end
    else
    begin
      FState       := mhcMulti;
      FBorderColor := LDesigner.MultiSelectHandleBorderColor;
      FColor       := LDesigner.MultiSelectHandleColor;
    end;

    if lmNoMove in LLockMode then
    begin
      FState := mhcLocked;
      FColor := LDesigner.LockedHandleColor;
    end;
    if lmNoResize in LLockMode then
    begin
      FState       := mhcLocked;
      FBorderColor := LDesigner.LockedHandleColor;
    end;
  end
  else
  begin
    if LParams.Mode = imSizeable then
    begin
      FState       := mhcInactive;
      FBorderColor := LDesigner.InactiveHandleBorderColor;
      FColor       := LDesigner.InactiveHandleColor;
    end
    else
    begin
      FState       := mhcMulti;
      FBorderColor := LDesigner.MultiSelectHandleBorderColor;
      FColor       := LDesigner.MultiSelectHandleColor;
    end;
  end;

  ParentWindow := LParentHandle;

  LShowing := False;
  LVisible := (LParams.Mode = imSizeable) or
              ((FPos in [ppTopLeft, ppTopRight, ppBottomRight, ppBottomLeft]) and
               (LParams.Mode = imMultiSelect));
  flags    := 0;
  wnd      := Handle;

  if IsWindowVisible(wnd) <> LVisible then
  begin
    flags    := flags or SWP_NOSIZE {or SWP_NOMOVE} or SHOW_FLAGS[LVisible];
    LShowing := LVisible;
  end;
  if LVisible and ((LLeft <> Left) or (LTop <> Top)) then
    flags := flags or SWP_NOSIZE and not SWP_NOMOVE;

  if flags <> 0 then
  begin
    FSelCtrl.FSelCtrls.DeferPos(wnd, ParentWindow, HWND_TOP, LLeft,
                                LTop, 0, 0, flags);
//  SetWindowPos({ADwp, }wnd, HWND_TOP, LLeft, LTop, 0, 0, flags);
  end;

  if (LParams.Mode = imSizeable) and not (lmNoResize in LLockMode)
    then Cursor := CURSORS[FPos]
    else Cursor := crDefault;

  if not LShowing then
    Invalidate;
end;

procedure TMouseHandleBase.WMEraseBkgnd(var Message: TMessage);
begin
  Message.Result := 1;
end;

procedure TMouseHandleBase.WndProc(var Message: TMessage);
begin
  inherited;
  if (Message.Msg = WM_LBUTTONDOWN) or (Message.Msg = WM_LBUTTONUP) or
     (Message.Msg = WM_MOUSEMOVE) or (Message.Msg = WM_CANCELMODE) then
    MouseAction(Message);
end;

constructor TSelCtrlMouseHandle.Create(ADEng: TEngine;
  APos: TMouseHandlePos; ASelCtrl: TSelCtrlItem);
begin
  FSelCtrl := ASelCtrl;
  inherited Create(ASelCtrl, ADEng, APos);
end;

procedure TSelCtrlMouseHandle.GetHandleParams(
  var AParams: TMouseHandleParams);
begin
  AParams.Control := FSelCtrl.Control;
  AParams.Mode    := FSelCtrl.Mode;
  AParams.Active  := FSelCtrl.FSelCtrls.FActive;
end;

{ TRootMouseHandle }

constructor TRootMouseHandle.Create(ADEng: TEngine; APos: TMouseHandlePos;
  ASelCtrl: TSelCtrlItem);
begin
  FSelCtrl := ASelCtrl;
  inherited Create(ASelCtrl, ADEng, APos);
end;

procedure TRootMouseHandle.GetHandleParams(
  var AParams: TMouseHandleParams);
begin
  AParams.Control := FSelCtrl.Control;

  if (FDEng.FDesignPanel = nil) or not FDEng.FDesigner.FShowRootResizers then
  begin
    AParams.Active := False;
    AParams.Mode   := imNone;
  end
  else if Pos in [ppRight, ppBottomRight, ppBottom] then
  begin
    AParams.Active := FSelCtrl.FSelCtrls.FActive;
    AParams.Mode   := FSelCtrl.Mode;
  end
  else
  begin
    AParams.Active := False;
    AParams.Mode   := imMultiSelect;
  end;
end;

procedure TSelCtrlMouseHandle.MouseAction(var Message: TMessage);
var
  LParams:  TMouseHandleParams;
  LDMSng:   TDMSizing;
begin
  GetHandleParams(LParams);

  if (Message.Msg = WM_LBUTTONDOWN) and (LParams.Mode = imSizeable) then
  begin
    LDMSng.Msg          := RMDsgnrSizing;
    LDMSng.MouseMessage := @(Message);

    FSelCtrl.FActivePos := Pos;
    FDEng.IsDesignMsg(LParams.Control, TMessage(LDMSng));
  end;
end;

procedure TRootMouseHandle.MouseAction(var Message: TMessage);
var
  LParams: TMouseHandleParams;
begin
  GetHandleParams(LParams);

  case Message.Msg of
    WM_LBUTTONDOWN:
    begin
      if LParams.Mode = imSizeable then
      begin
        MouseCapture := True;
        FMouseDown   := True;
        GetCursorPos(FInitPos);
        FInitRootWidth  := FDEng.FRoot.Width;
        FInitRootHeight := FDEng.FRoot.Height;
      end;
    end;
    WM_LBUTTONUP,
    WM_CANCELMODE:
    begin
      MouseCapture := False;
      FMouseDown   := False;
    end;
    WM_MOUSEMOVE:
    begin
      if (LParams.Mode = imSizeable) and FMouseDown then
        ResizeRoot;
    end;
  end;
end;

procedure TRootMouseHandle.ResizeRoot;
var
  LCurs:      TPoint;
  LNewWidth:  Integer;
  LNewHeight: Integer;
begin
  GetCursorPos(LCurs);
  
  LNewWidth  := FInitRootWidth;
  LNewHeight := FInitRootHeight;

  if Pos in [ppRight, ppBottomRight] then
    Inc(LNewWidth, (LCurs.X - FInitPos.X));
  if Pos in [ppBottomRight, ppBottom] then
    Inc(LNewHeight, (LCurs.Y - FInitPos.Y));

  if LNewWidth < 0 then
    LNewWidth := 0;
  if LNewHeight < 0 then
    LNewHeight := 0;

  if (FDEng.FRoot.Width <> LNewWidth) or (FDEng.FRoot.Height <> LNewHeight) then
  begin
    FDEng.FRoot.SetBounds(FDEng.FRoot.Left, FDEng.FRoot.Top,
                          LNewWidth, LNewHeight);
    FDEng.Modified;
  end;
end;

procedure TLMDCustomDesignPanel.RootBoundsChanged;
var
  LRoot: TWinControl;
begin
  if IsUsed then
  begin
    LRoot := TEngine(FEng).FRoot;
    FScrollCtrl.SetBounds(LRoot.Left, LRoot.Top, LRoot.Width,
                          LRoot.Height);
  end
  else
    FScrollCtrl.SetBounds(0, 0, 0, 0);
end;

{ TEditorUtils }

constructor TEditorUtils.Create(ADesigner: TLMDCustomDesigner);
begin
  inherited Create;
  FDesigner := ADesigner;
end;

procedure TEditorUtils.GetObjects(AResult: TList);
begin
  if not IsReset and FDesigner.Active then
    FDesigner.FSelection.GetItems(AResult);
end;

function TEditorUtils.GetUniqueCompName(AComp: TComponent): TLMDString;
begin
  if not IsReset and FDesigner.Active then
    Result := FDesigner.FModule.GetUniqueCompName(AComp.ClassName);
  if Result = '' then
    Result := inherited GetUniqueCompName(AComp);
end;

procedure TEditorUtils.MarkModified;
begin
  if not IsReset and FDesigner.Active then
    TEngine(FDesigner.FEng).Modified;
end;

procedure TEditorUtils.SetObjects(AObjects: TList);
begin
  if not IsReset and FDesigner.Active then
    FDesigner.FSelection.SetItems(AObjects);
end;

procedure TLMDCustomDesigner.SetShowRootResizers(const Value: Boolean);
begin
  FShowRootResizers := Value;
end;

procedure TLMDCustomDesigner.SetServiceOptions(
  const Value: TLMDDesignerServiceOptions);
begin
  if FServiceOptions <> Value then
  begin
    FServiceOptions := Value;
    if Active then
      TEngine(FEng).RepaintNonvisualControls;
  end;
end;

procedure TLMDCustomDesigner.CompsChangeNotification(Sender: TObject;
  AChangedComps: TList);
var
  i:      Integer;
  update: Boolean;
begin
  if (Sender = Self) or not FActive then
    Exit;

  update := False;
  for i := 0 to AChangedComps.Count - 1 do
    if LMDIsObjectOwnedBy(TComponent(AChangedComps[i]), FModule.Root) then
    begin
      update := True;
      Break; // for
    end;

  if update then
  begin
    TEngine(FEng).UpdateMouseHandles;
    TEngine(FEng).UpdateNonvisualControls;
    FEditorWindows.UpdateAll;
  end;
end;

procedure TLMDCustomDesignPanel.DestroyWnd;
begin
  TWinControlAccess(FForm).DestroyHandle;
  inherited;
end;

function TLMDCustomDesigner.TryGetLockMode(AComponent: TComponent;
  out ALockMode: TLMDDesignerLockMode): Boolean;
var
  ctrl: TControl;
begin
  ctrl := nil;
  if Active then
    ctrl := TEngine(FEng).FindControl(AComponent);

  if ctrl <> nil then
  begin
    ALockMode := TEngine.GetLockMode(ctrl);
    Result    := True;
  end
  else
  begin
    ALockMode := [];
    Result    := False;
  end;
end;

initialization
  RegisterDesignerMessages;
  DesignerList := TList.Create;

  {$IFDEF LMD_DEBUGTRACE}
    {$I C1.INC}
  {$ENDIF}

{ ---------------------------------------------------------------------------- }
finalization
  DesignerList.Free;

{ ---------------------------------------------------------------------------- }
end.

