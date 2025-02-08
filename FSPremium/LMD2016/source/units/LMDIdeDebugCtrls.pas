unit LMDIdeDebugCtrls;
{$I LMDCmps.inc}

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

LMDIdeDebugCtrls unit (YB)
--------------------------
Debugging related controls unit.

Changes
-------

###############################################################################}

interface

uses
  Classes, Controls, Windows, Messages, SysUtils, Graphics, Forms, StdCtrls,
  ComCtrls, ImgList, Grids, intfLMDBase, LMDTypes, LMDHashTable,
  LMDUnicodeControl, LMDSvcPvdr, LMDSctScripter, LMDIdeCst, LMDIdeClass;

const
  DM_ASYNCUPDATE = WM_USER + 1;

type
  {**************************** TLMDDebuggerSource ****************************}

  TLMDDbgSourceChange   = set of (scFrameIndex, scDebuggerState,
                                  scDebugNameChanged);
  ILMDDbgSourceNotifier = class
  public
    procedure StateChanged(AChange: TLMDDbgSourceChange); virtual; abstract;
    procedure LogMessage(const AMsg: TLMDString;
                         AKind: TLMDDebugMsgKind); virtual; abstract;
    procedure BreakpointsChanged; virtual; abstract;
  end;

  TLMDDebuggerSourceOnLogMessage = procedure(Sender: TObject;
                                             const AMsg: TLMDString;
                                             AKind: TLMDDebugMsgKind) of object;

  TLMDDebuggerSource = class(TComponent, ILMDComponent)
  private
    FAbout:                TLMDAboutVar;
    FServiceProvider:      TLMDServiceProvider;
    FDebugger:             TLMDScriptDebugger;
    FStackFrameIndex:      Integer;
    FDbgNotifier:          ILMDScriptDebuggerNotifier;
    FNotifiers:            TList;
    FOnStateChanged:       TNotifyEvent;
    FOnLogMessage:         TLMDDebuggerSourceOnLogMessage;
    FOnBreakpointsChanged: TNotifyEvent;

    procedure AdjustFrameIndex;
    procedure DebuggerBreaked(ADebugger: TLMDScriptDebugger);
    procedure DebuggerResumed(ADebugger: TLMDScriptDebugger);
    procedure DebugNameChanged(ADebugger: TLMDScriptDebugger;
                               AScript: TLMDScriptControl);
    procedure DebugLogMessage(ADebugger: TLMDScriptDebugger;
                              const AMsg: TLMDString; AKind: TLMDDebugMsgKind);
    procedure BreakpointsChanged(ADebugger: TLMDScriptDebugger);
    procedure SetDebugger(const Value: TLMDScriptDebugger);
    procedure SetStackFrameIndex(const Value: Integer);
    function  GetStackFrame: TLMDStackFrame;
    procedure SetServiceProvider(const Value: TLMDServiceProvider);
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    procedure DoStateChanged(AChange: TLMDDbgSourceChange); virtual;
    procedure DoLogMessage(const AMsg: TLMDString; AKind: TLMDDebugMsgKind); virtual;
    procedure DoBreakpointsChanged; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure AddNotifier(ANotifier: ILMDDbgSourceNotifier);
    procedure RemoveNotifier(ANotifier: ILMDDbgSourceNotifier);
    property  StackFrameIndex: Integer read FStackFrameIndex write SetStackFrameIndex;
    property  StackFrame: TLMDStackFrame read GetStackFrame;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property ServiceProvider: TLMDServiceProvider read FServiceProvider write SetServiceProvider;
    property Debugger: TLMDScriptDebugger read FDebugger write SetDebugger;
    property OnStateChanged: TNotifyEvent read FOnStateChanged write FOnStateChanged;
    property OnLogMessage: TLMDDebuggerSourceOnLogMessage read FOnLogMessage write FOnLogMessage;
    property OnBreakpointsChanged: TNotifyEvent read FOnBreakpointsChanged write FOnBreakpointsChanged;
  end;

  {***************************** TLMDCallStackView ****************************}

  TLMDCallStackViewOnGetCaption    = procedure(Sender: TObject; AFrame: TLMDStackFrame;
                                               var S: TLMDString) of object;
  TLMDCallStackViewOnGetImageIndex = procedure(Sender: TObject; AFrame: TLMDStackFrame;
                                               var AImageIndex: TImageIndex) of object;

  TLMDCallStackFrameIndexUpdate = (iuOnClick, iuOnDblClick);

  TLMDCallStackView = class(TCustomListView, ILMDComponent)
  private
    FAbout:             TLMDAboutVar;
    FAdjusting:         Boolean;
    FItemBuffer:        TBitmap;
    FSourceNotifier:    ILMDDbgSourceNotifier;
    FSource:            TLMDDebuggerSource;
    FSourceIndexUpdate: TLMDCallStackFrameIndexUpdate;
    FPrevSelected:      Integer;
    FItemImageIndex:    TImageIndex;
    FTopImageIndex:     TImageIndex;
    FOnGetCaption:      TLMDCallStackViewOnGetCaption;
    FOnGetImageIndex:   TLMDCallStackViewOnGetImageIndex;

    procedure SourceStateChanged;
    procedure AdjustColumns(AWholeWidth: Integer);
    function  GetBufferBitmap(AWidth, AHeight: Integer): TBitmap;
    procedure DoDrawItem(AIndex: Integer; State: TCustomDrawState;
                         ACanvas: TCanvas; const ARect: TRect);
    procedure SetSource(const Value: TLMDDebuggerSource);
    function  GetImages: TCustomImageList;
    procedure SetImages(const Value: TCustomImageList);
    procedure SetItemImageIndex(const Value: TImageIndex);
    procedure SetTopImageIndex(const Value: TImageIndex);
    function  GetSelected: TLMDStackFrame;
    procedure SetSelected(const Value: TLMDStackFrame);
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  protected
    procedure CreateHandle; override;
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    procedure DblClick; override;
    procedure Change(Item: TListItem; Change: Integer); override;
    procedure Delete(Item: TListItem); override;
    function  IsCustomDrawn(Target: TCustomDrawTarget;
                            Stage: TCustomDrawStage): Boolean; override;
    function  CustomDraw(const ARect: TRect;
                         Stage: TCustomDrawStage): Boolean; override;
    function  CustomDrawItem(Item: TListItem; State: TCustomDrawState;
                             Stage: TCustomDrawStage): Boolean; override;
    function  DoGetCaption(AFrame: TLMDStackFrame): TLMDString; virtual;
    function  DoGetImageIndex(AFrame: TLMDStackFrame): TImageIndex; virtual;
    function  GetThemedBackColor: TColor;
    function  GetThemedTextColor(AEnabled: Boolean): TColor;
    procedure UpdateView;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property  ItemIndex;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property Source: TLMDDebuggerSource read FSource write SetSource;
    property SourceIndexUpdate: TLMDCallStackFrameIndexUpdate read FSourceIndexUpdate write FSourceIndexUpdate default iuOnDblClick;
    property Selected: TLMDStackFrame read GetSelected write SetSelected;
    property Images: TCustomImageList read GetImages write SetImages;
    property ItemImageIndex: TImageIndex read FItemImageIndex write SetItemImageIndex default -1;
    property TopImageIndex: TImageIndex read FTopImageIndex write SetTopImageIndex default -1;
    property OnGetCaption: TLMDCallStackViewOnGetCaption read FOnGetCaption write FOnGetCaption;
    property OnGetImageIndex: TLMDCallStackViewOnGetImageIndex read FOnGetImageIndex write FOnGetImageIndex;
    property Align;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF LMDCOMP10}
    property OnMouseActivate;
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
  end;

  {************************** TLMDCallStackComboBox ***************************}

  TLMDCallStackComboOnGetCaption = procedure(Sender: TObject;
                                             AFrame: TLMDStackFrame;
                                             var S: TLMDString) of object;

  TLMDCallStackComboBox = class(TCustomComboBox, ILMDComponent)
  private
    FAbout:          TLMDAboutVar;
    FSource:         TLMDDebuggerSource;
    FSourceNotifier: ILMDDbgSourceNotifier;
    FIsEmpty:        Boolean;
    FOnGetCaption:   TLMDCallStackComboOnGetCaption;

    procedure SourceStateChanged;
    procedure SetSource(const Value: TLMDDebuggerSource);
    function  GetItemIndex: Integer; reintroduce;
    procedure SetItemIndex(const Value: Integer); reintroduce;
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  protected
    procedure CreateHandle; override;
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    procedure CloseUp; override;
    function  DoGetCaption(AFrame: TLMDStackFrame): TLMDString; virtual;
    procedure UpdateView;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property Source: TLMDDebuggerSource read FSource write SetSource;
    property OnGetCaption: TLMDCallStackComboOnGetCaption read FOnGetCaption write FOnGetCaption;
    property Align;
    property AutoDropDown default False;
    {$IFDEF LMDCOMP7}
    property AutoCloseUp default False;
    {$ENDIF}
    property BevelEdges;
    property BevelInner;
    property BevelKind default Controls.bkNone;
    property BevelOuter;
    property Anchors;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    {$IFDEF LMDCOMP12}
    property ParentDoubleBuffered;
    {$ENDIF}
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnCloseUp;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    {$IFDEF LMDCOMP10}
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
    property OnSelect;
    property OnStartDock;
    property OnStartDrag;
  end;

  {***************************** TLMDVarsTreeBase *****************************}

  TLMDVarsTreeBase     = class;
  TLMDExpandedNode     = class;
  TLMDRootExpandedNode = class;

  TLMDNodePath = array[0..1024] of Integer;
  PLMDNodePath = ^TLMDNodePath;

  TLMDNodeDescr = record
    Parent: TLMDExpandedNode;
    Index:  Integer;
  end;

  TLMDNodeData = record
    Name:         TLMDString;
    Value:        TLMDString;
    Key:          Pointer; // Optional.
    ShowCheckbox: Boolean;
    Checked:      Boolean;
    Enabled:      Boolean; // Gray text, if False.
  end;

  TLMDExpNodeProcRes = (enrProcessChildren, cnrDeleteItem);
  TLMDExpNodeProc    = function(AItem: TLMDExpandedNode;
                                AUserData: Pointer): TLMDExpNodeProcRes of object;
  TLMDExpandedNode = class
  private
    FParent: TLMDExpandedNode;
    FKey:    Pointer;
    FIndex:  Integer;
    FItems:  TList; // Lazy inited.

    function  GetTree: TLMDVarsTreeBase;
    function  GetRoot: TLMDRootExpandedNode;
    function  GetLevel: Integer;
    procedure InsertItem(AItem: TLMDExpandedNode);
    procedure RemoveItem(AItem: TLMDExpandedNode);
  public
    constructor Create(AParent: TLMDExpandedNode; AKey: Pointer;
                       AIndex: Integer);
    destructor Destroy; override;

    procedure Clear;
    procedure Delete;
    function  Add(AKey: Pointer; AIndex: Integer): TLMDExpandedNode;
    procedure ForAllItems(AProc: TLMDExpNodeProc;
                          AUserData: Pointer);

    property Tree: TLMDVarsTreeBase read GetTree;
    property Root: TLMDRootExpandedNode read GetRoot;
    property Parent: TLMDExpandedNode read FParent;
    property Key: Pointer read FKey;
    property Index: Integer read FIndex; // In Parent's childrens.
    property Level: Integer read GetLevel;
  end;

  TLMDRootExpandedNode = class(TLMDExpandedNode)
  private
    FTree:  TLMDVarsTreeBase;
    FIndex: TLMDHashTable;

    procedure InsertInIndex(AItem: TLMDExpandedNode);
    procedure RemoveFromIndex(AItem: TLMDExpandedNode);
  public
    constructor Create(ATree: TLMDVarsTreeBase);
    destructor Destroy; override;

    function  FindItem(const ANode: TLMDNodeDescr): TLMDExpandedNode;
    procedure UpdateHashIndex;
  end;

  TLMDVarsTreeBase = class(TCustomListView, ILMDComponent)
  private
    FAbout:         TLMDAboutVar;
    FRoot:          TLMDRootExpandedNode;
    FListSize:      Integer;
    FCachedNode:    TLMDNodeDescr;  // ListIdx to Node cache.
    FCachedListIdx: Integer;        //
    FItemBuffer:    TBitmap;
    FExpBtns:       array of TRect;
    FCheckBtns:     array of TRect;
    FAdjusting:     Boolean;
    FImageLst:      TImageList;

    procedure WMEraseBkGnd(var Message: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMNotify(var Message: TWMNotify); message WM_NOTIFY;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure NotifyDesigner;
    function  CountVisibleChildrenProc(AItem: TLMDExpandedNode;
                                       AUserData: Pointer): TLMDExpNodeProcRes;
    function  ValidateExpNodeProc(AItem: TLMDExpandedNode;
                                  AUserData: Pointer): TLMDExpNodeProcRes;
    function  NodeByListIdx(AListIdx: Integer): TLMDNodeDescr;
    function  GetLevel(const ANode: TLMDNodeDescr): Integer;
    function  GetChildCount(const ANode: TLMDNodeDescr): Integer; overload;
    function  GetChildCount(const ANode: TLMDExpandedNode): Integer; overload;
    procedure GetData(const ANode: TLMDNodeDescr; out AData: TLMDNodeData);
    procedure CheckboxClicked(const ANode: TLMDNodeDescr);
    function  GetExpanded(const ANode: TLMDNodeDescr): Boolean;
    procedure SetExpanded(AListIdx: Integer; AValue: Boolean;
                          AInvalidate: Boolean = True);
    procedure InitColumns;
    procedure AdjustColumns(ANameWidth, AWholeWidth: Integer);
    function  GetBufferBitmap(AWidth, AHeight: Integer): TBitmap;
    function  IsOnExpBtn(const P: TPoint): Boolean;
    procedure SetExpBtn(AListIdx: Integer; const ABounds: TRect);
    function  IsOnCheckBtn(const P: TPoint): Boolean;
    procedure SetCheckBtn(AListIdx: Integer; const ABounds: TRect);
    procedure DoDrawItem(const ANode: TLMDNodeDescr; AListIdx: Integer;
                         State: TCustomDrawState; ACanvas: TCanvas;
                         const ARect: TRect; AValClnOffset: Integer;
                         out AExpBtn, ACheckBtn: TRect);
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  protected
    procedure CreateWnd; override;  // Look at stupid TCustomListBox
                                    // implementation.
    procedure CreateHandle; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure DblClick; override;
    function  OwnerDataFetch(Item: TListItem;
                             Request: TItemRequest): Boolean; override;
    function  IsCustomDrawn(Target: TCustomDrawTarget;
                            Stage: TCustomDrawStage): Boolean; override;
    function  CustomDraw(const ARect: TRect;
                         Stage: TCustomDrawStage): Boolean; override;
    function  CustomDrawItem(Item: TListItem; State: TCustomDrawState;
                             Stage: TCustomDrawStage): Boolean; override;
    function  DoGetChildCount(APath: PLMDNodePath;
                              APathSize: Integer): Integer; virtual; abstract;
    procedure DoGetNodeData(APath: PLMDNodePath; APathSize: Integer;
                            var AData: TLMDNodeData); virtual; abstract;
    function  DoKeyIndexOf(AParentPath: PLMDNodePath; AParentPathSize: Integer;
                           AKey: Pointer): Integer; virtual;
    procedure DoCheckboxClicked(APath: PLMDNodePath;
                                APathSize: Integer); virtual;
    procedure DoGetColumnNames(var ANameCln, AValueCln: TLMDString); virtual;

    function  GetThemedBackColor: TColor;
    function  GetThemedTextColor(AEnabled: Boolean): TColor;
    procedure UpdateView(AInvalidate: Boolean = True);
    function  GetSelectedPath(APathBuf: PLMDNodePath; ABufSize: Integer): Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
  end;

  {**************************** TLMDVariablesView *****************************}

  TLMDVarsViewDataKind = (dkLocalVars, dkExpression);

  TLMDVariablesView = class(TLMDVarsTreeBase)
  private
    FVars:          TLMDVariables;
    FShowRoot:       Boolean;
    FSourceNotifier: ILMDDbgSourceNotifier;
    FSource:         TLMDDebuggerSource;
    FKind: TLMDVarsViewDataKind;
    FExpression: TLMDString;
    FAutoShowRoot: Boolean;

    procedure VarsChanged;
    function  TryVarByPath(APath: PLMDNodePath; APathSize: Integer;
                           out AVar: TLMDVariable): Boolean;
    procedure SourceStateChanged;
    function  GetRoot: TLMDVariable;
    procedure SetShowRoot(const Value: Boolean);
    procedure SetSource(const Value: TLMDDebuggerSource);
    function  IsShowRootStored: Boolean;
    procedure SetAutoShowRoot(const Value: Boolean);
    procedure SetExpression(const Value: TLMDString);
    procedure SetKind(const Value: TLMDVarsViewDataKind);
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    function  DoGetChildCount(APath: PLMDNodePath;
                              APathSize: Integer): Integer; override;
    procedure DoGetNodeData(APath: PLMDNodePath; APathSize: Integer;
                            var AData: TLMDNodeData); override;
    procedure UpdateView;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Vars: TLMDVariables read FVars;
    property Root: TLMDVariable read GetRoot;
  published
    property ShowRoot: Boolean read FShowRoot write SetShowRoot stored IsShowRootStored;
    property Source: TLMDDebuggerSource read FSource write SetSource;
    property Kind: TLMDVarsViewDataKind read FKind write SetKind default dkLocalVars;
    property Expression: TLMDString read FExpression write SetExpression;
    property AutoShowRoot: Boolean read FAutoShowRoot write SetAutoShowRoot default True;
    property Align;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowColumnHeaders;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF LMDCOMP10}
    property OnMouseActivate;
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
  end;

  {****************************** TLMDWatchView *******************************}

  TLMDWatchItem = class(TCollectionItem)
  private
    FExpression: TLMDString;
    FEnabled:    Boolean;
    FNeedUpdate: Boolean;
    FVars:       TLMDVariables;

    procedure VarsChanged;
    procedure InternalInvalidate;
    procedure SetEnabled(const Value: Boolean);
    procedure SetExpression(const Value: TLMDString);
    function  GetRoot: TLMDVariable;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    procedure Delete;
    property  Vars: TLMDVariables read FVars;
    property  Root: TLMDVariable read GetRoot;
  published
    property Expression: TLMDString read FExpression write SetExpression;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
  end;

  TLMDWatchItems = class(TOwnedCollection)
  private
    function  GetItem(Index: Integer): TLMDWatchItem;
    procedure SetItem(Index: Integer; const Value: TLMDWatchItem);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    function Add(const AExpression: TLMDString): TLMDWatchItem; overload;
    function Add: TLMDWatchItem; overload;
    function FindItemID(ID: Integer): TLMDWatchItem;
    function Insert(Index: Integer): TLMDWatchItem;
    property Items[Index: Integer]: TLMDWatchItem read GetItem write SetItem; default;
  end;

  TLMDWatchView = class(TLMDVarsTreeBase)
  private
    FItems:          TLMDWatchItems;
    FSourceNotifier: ILMDDbgSourceNotifier;
    FSource:         TLMDDebuggerSource;

    procedure SourceStateChanged;
    procedure ItemsChanged;
    function  TryVarByPath(APath: PLMDNodePath; APathSize: Integer;
                           out AVar: TLMDVariable): Boolean;
    procedure SetSource(const Value: TLMDDebuggerSource);
    procedure SetItems(const Value: TLMDWatchItems);
    function  GetSelected: TLMDWatchItem;
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    function  DoGetChildCount(APath: PLMDNodePath;
                              APathSize: Integer): Integer; override;
    procedure DoGetNodeData(APath: PLMDNodePath; APathSize: Integer;
                            var AData: TLMDNodeData); override;
    function  DoKeyIndexOf(AParentPath: PLMDNodePath; AParentPathSize: Integer;
                           AKey: Pointer): Integer; override;
    procedure DoCheckboxClicked(APath: PLMDNodePath;
                                APathSize: Integer); override;
    procedure DoGetColumnNames(var ANameCln, AValueCln: TLMDString); override;
    procedure UpdateView;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Items: TLMDWatchItems read FItems write SetItems;
    property Source: TLMDDebuggerSource read FSource write SetSource;
    property Selected: TLMDWatchItem read GetSelected;
    property Align;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowColumnHeaders;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF LMDCOMP10}
    property OnMouseActivate;
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
  end;

  {***************************** TLMDEventLogView *****************************}

  TLMDEventLogViewState = set of (lvsAsyncUpdateSent);

  TLMDEventLogView = class(TCustomGrid, ILMDComponent)
  private
    FAbout:               TLMDAboutVar;
    FState:               TLMDEventLogViewState;
    FSourceNotifier:      ILMDDbgSourceNotifier;
    FSource:              TLMDDebuggerSource;
    FSourceMessageKinds:  TLMDDebugMsgKinds;
    FAsyncUpdate:         Boolean;
    FMaxMessageCount:     Integer;
    FShowNewMessage:      Boolean;
    FMessages:            TStringList; // Circular queue.
    FMsgStart:            Integer;     //
    FMsgMaxWidth:         Integer;
    FMsgMaxWidthIndex:    Integer;     // The index of last processed
                                       // message. The FMsgMaxWidth should be
                                       // updated if this index does not point
                                       // to the last message.
    FMsgColors:           array[TLMDDebugMsgKind] of TColor;
    FMsgBkColors:         array[TLMDDebugMsgKind] of TColor;
    FUseMsgColors:        Boolean;

    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure DMAsyncUpdate(var Message: TMessage); message DM_ASYNCUPDATE;
    procedure AdjustColWidth;
    procedure AdjustRowHeight;
    procedure NormalizeMessages;
    procedure GetMsg(AIndex: Integer; out AMsg: TLMDString;
                     out AKind: TLMDDebugMsgKind);
    procedure InitColors;
    procedure SourceLogMsg(const AMsg: TLMDString; AKind: TLMDDebugMsgKind);
    procedure SetMaxMessageCount(const Value: Integer);
    function  GetMsgColor(const Index: Integer): TColor;
    procedure SetMsgColor(const Index: Integer; const Value: TColor);
    function  IsMsgColorStred(const Index: Integer): Boolean;
    function  GetMsgBkColor(const Index: Integer): TColor;
    procedure SetMsgBkColor(const Index: Integer; const Value: TColor);
    function  IsMsgBkColorStred(const Index: Integer): Boolean;
    procedure SetSource(const Value: TLMDDebuggerSource);
    procedure SetUseMsgColors(const Value: Boolean);
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    procedure CreateHandle; override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
                       AState: TGridDrawState); override;
    procedure UpdateView(AForceSync: Boolean = False;
                         ASelectLastMsg: Boolean = False);
    function  GetThemedBackColor: TColor;
    function  GetThemedTextColor: TColor;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Clear;
    procedure LogMessage(const AMsg: TLMDString); overload;
    procedure LogMessage(const AMsg: TLMDString; AKind: TLMDDebugMsgKind); overload;
    property  Col;
    property  ColWidths;
    property  GridHeight;
    property  GridWidth;
    property  LeftCol;
    property  Selection;
    property  Row;
    property  RowHeights;
    property  TabStops;
    property  TopRow;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property AsyncUpdate: Boolean read FAsyncUpdate write FAsyncUpdate default True;
    property ShowNewMessage: Boolean read FShowNewMessage write FShowNewMessage default True;
    property MaxMessageCount: Integer read FMaxMessageCount write SetMaxMessageCount default -1;
    property Source: TLMDDebuggerSource read FSource write SetSource;
    property SourceMessageKinds: TLMDDebugMsgKinds read FSourceMessageKinds write FSourceMessageKinds default LMDAllMsgKinds;
    property UseMsgColors: Boolean read FUseMsgColors write SetUseMsgColors default True;
    property DebuggerOutputColor: TColor index dmDebuggerOutput read GetMsgColor write SetMsgColor stored IsMsgColorStred;
    property DebuggerOutputBkColor: TColor index dmDebuggerOutput read GetMsgBkColor write SetMsgBkColor stored IsMsgBkColorStred;
    property BreakpointReachedColor: TColor index dmBreakpointReached read GetMsgColor write SetMsgColor stored IsMsgColorStred;
    property BreakpointReachedBkColor: TColor index dmBreakpointReached read GetMsgBkColor write SetMsgBkColor stored IsMsgBkColorStred;
    property LogMessageColor: TColor index dmLogMessage read GetMsgColor write SetMsgColor stored IsMsgColorStred;
    property LogMessageBkColor: TColor index dmLogMessage read GetMsgBkColor write SetMsgBkColor stored IsMsgBkColorStred;
    property EvalExprColor: TColor index dmEvalExpr read GetMsgColor write SetMsgColor stored IsMsgColorStred;
    property EvalExprBkColor: TColor index dmEvalExpr read GetMsgBkColor write SetMsgBkColor stored IsMsgBkColorStred;
    property LogStackHeaderColor: TColor index dmLogStackHeader read GetMsgColor write SetMsgColor stored IsMsgColorStred;
    property LogStackHeaderBkColor: TColor index dmLogStackHeader read GetMsgBkColor write SetMsgBkColor stored IsMsgBkColorStred;
    property LogStackFrameColor: TColor index dmLogStackFrame read GetMsgColor write SetMsgColor stored IsMsgColorStred;
    property LogStackFrameBkColor: TColor index dmLogStackFrame read GetMsgBkColor write SetMsgBkColor stored IsMsgBkColorStred;
    property Align;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property ColCount;
    property Constraints;
    property Ctl3D;
    property DefaultRowHeight;
    property DefaultDrawing;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property GridLineWidth;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    {$IFDEF LMDCOMP12}
    property ParentDoubleBuffered;
    {$ENDIF}
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property Visible;
    property VisibleColCount;
    property VisibleRowCount;
    property OnClick;
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
    {$IFDEF LMDCOMP10}
    property OnMouseActivate;
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  {*************************** TLMDBreakpointsView ****************************}

  TLMDBPViewOnGetImageIndex = procedure(Sender: TObject; BP: TLMDBreakpoint;
                                        var AIndex: TImageIndex) of object;

  TLMDBreakpointsView = class(TCustomListView, ILMDComponent)
  private
    FAbout:              TLMDAboutVar;
    FCheckBtns:          array of TRect;
    FSourceNotifier:     ILMDDbgSourceNotifier;
    FSource:             TLMDDebuggerSource;
    FNormalImageIndex:   TImageIndex;
    FDisabledImageIndex: TImageIndex;
    FInvalidImageIndex:  TImageIndex;
    FOnGetImageIndex:    TLMDBPViewOnGetImageIndex;

    procedure WMEraseBkGnd(var Message: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure InitColumns;
    procedure SourceStateChanged;
    function  IsOnCheckBtn(const P: TPoint): Boolean;
    procedure SetCheckBtn(AListIdx: Integer; const ABounds: TRect);
    function  BpByItem(AItem: TListItem): TLMDBreakpoint;
    procedure SetSource(const Value: TLMDDebuggerSource);
    function  GetImages: TCustomImageList;
    procedure SetImages(const Value: TCustomImageList);
    procedure SetDisabledImageIndex(const Value: TImageIndex);
    procedure SetInvalidImageIndex(const Value: TImageIndex);
    procedure SetNormalImageIndex(const Value: TImageIndex);
    function  GetSelected: TLMDBreakpoint;
    procedure SetSelected(const Value: TLMDBreakpoint);
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    procedure CreateWnd; override;
    procedure CreateHandle; override;
    function  IsCustomDrawn(Target: TCustomDrawTarget;
                            Stage: TCustomDrawStage): Boolean; override;
    function  CustomDraw(const ARect: TRect;
                         Stage: TCustomDrawStage): Boolean; override;
    function  CustomDrawItem(Item: TListItem; State: TCustomDrawState;
                             Stage: TCustomDrawStage): Boolean; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure DoGetBreakpointParams(BP: TLMDBreakpoint; out ASource,
                                    ALine, ACondition, AAction,
                                    APassCount, AGroup: TLMDString); virtual;
    function  DoGetImageIndex(BP: TLMDBreakpoint): TImageIndex; virtual;
    procedure UpdateView;
    function  GetThemedBackColor: TColor;
    function  GetThemedTextColor(ABreakpointEnabled: Boolean): TColor;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property Source: TLMDDebuggerSource read FSource write SetSource;
    property Images: TCustomImageList read GetImages write SetImages;
    property Selected: TLMDBreakpoint read GetSelected write SetSelected;
    property NormalImageIndex: TImageIndex read FNormalImageIndex write SetNormalImageIndex default -1;
    property DisabledImageIndex: TImageIndex read FDisabledImageIndex write SetDisabledImageIndex default -1;
    property InvalidImageIndex: TImageIndex read FInvalidImageIndex write SetInvalidImageIndex default -1;
    property OnGetImageIndex: TLMDBPViewOnGetImageIndex read FOnGetImageIndex write FOnGetImageIndex;
    property Align;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowColumnHeaders;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF LMDCOMP10}
    property OnMouseActivate;
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses
  RTLConsts, Themes, CommCtrl, Math;

type
  TDebuggerNotifier = class(ILMDScriptDebuggerNotifier)
  private
    FSource: TLMDDebuggerSource;
  public
    constructor Create(ASource: TLMDDebuggerSource);

    procedure Breaked(ADebugger: TLMDScriptDebugger); override;
    procedure Resumed(ADebugger: TLMDScriptDebugger); override;
    procedure DebugNameChanged(ADebugger: TLMDScriptDebugger;
                               AScript: TLMDScriptControl); override;
    procedure LogMessage(ADebugger: TLMDScriptDebugger; const AMsg: TLMDString;
                         AKind: TLMDDebugMsgKind); override;
    procedure BreakpointsChanged(ADebugger: TLMDScriptDebugger); override;
  end;

  TCallStackViewSourceNotifier = class(ILMDDbgSourceNotifier)
  private
    FView: TLMDCallStackView;
  public
    constructor Create(AView: TLMDCallStackView);

    procedure StateChanged(AChange: TLMDDbgSourceChange); override;
    procedure LogMessage(const AMsg: TLMDString; AKind: TLMDDebugMsgKind); override;
    procedure BreakpointsChanged; override;
  end;

  TCallStackComboSourceNotifier = class(ILMDDbgSourceNotifier)
  private
    FComboBox: TLMDCallStackComboBox;
  public
    constructor Create(AComboBox: TLMDCallStackComboBox);

    procedure StateChanged(AChange: TLMDDbgSourceChange); override;
    procedure LogMessage(const AMsg: TLMDString; AKind: TLMDDebugMsgKind); override;
    procedure BreakpointsChanged; override;
  end;

  TNodeIndexTraits = class(TLMDHashTableTraits)
  public
    class function MakeHashI(AItem: TObject): Integer; override;
    class function MakeHashK(const AKey): Integer; override;
    class function Compare(const AKey; AItem: TObject): Boolean; override;
  end;

  TVarsViewItems = class(TLMDVariables)
  private
    FView: TLMDVariablesView;
  protected
    procedure DoChange; override;
  public
    constructor Create(AView: TLMDVariablesView);
  end;

  TWatchItemItems = class(TLMDVariables)
  private
    FOwner: TLMDWatchItem;
  protected
    procedure DoChange; override;
  public
    constructor Create(AOwner: TLMDWatchItem);
  end;

  TVarsViewSourceNotifier = class(ILMDDbgSourceNotifier)
  private
    FView: TLMDVariablesView;
  public
    constructor Create(AView: TLMDVariablesView);

    procedure StateChanged(AChange: TLMDDbgSourceChange); override;
    procedure LogMessage(const AMsg: TLMDString; AKind: TLMDDebugMsgKind); override;
    procedure BreakpointsChanged; override;
  end;

  TWatchViewSourceNotifier = class(ILMDDbgSourceNotifier)
  private
    FView: TLMDWatchView;
  public
    constructor Create(AView: TLMDWatchView);

    procedure StateChanged(AChange: TLMDDbgSourceChange); override;
    procedure LogMessage(const AMsg: TLMDString; AKind: TLMDDebugMsgKind); override;
    procedure BreakpointsChanged; override;
  end;

  TEventLogSourceNotifier = class(ILMDDbgSourceNotifier)
  private
    FView: TLMDEventLogView;
  public
    constructor Create(AView: TLMDEventLogView);

    procedure StateChanged(AChange: TLMDDbgSourceChange); override;
    procedure LogMessage(const AMsg: TLMDString; AKind: TLMDDebugMsgKind); override;
    procedure BreakpointsChanged; override;
  end;

  TBreakpointsSourceNotifier = class(ILMDDbgSourceNotifier)
  private
    FView: TLMDBreakpointsView;
  public
    constructor Create(AView: TLMDBreakpointsView);

    procedure StateChanged(AChange: TLMDDbgSourceChange); override;
    procedure LogMessage(const AMsg: TLMDString; AKind: TLMDDebugMsgKind); override;
    procedure BreakpointsChanged; override;
  end;

  PIterateNodesPath = ^TIterateNodesPath;
  TIterateNodesPath = array of Integer;

  PCountVisibleChildrenData = ^TCountVisibleChildrenData;
  TCountVisibleChildrenData = record
    Path:  TIterateNodesPath;
    Count: Integer;
  end;


const
  CheckBoxSize  = 13;
  ExpandBtnSize = 9;

  DefaultMsgColors: array[TLMDDebugMsgKind] of TColor = (
    clNavy,         // dmDebuggerOutput
    clRed,          // dmBreakpointReached
    $000000D9,      // dmLogMessage
    $008080FF,      // dmEvalExpr
    $000000D9,      // dmLogStackHeader
    $002080FF       // dmLogStackFrame
  );
  DefaultMsgBkColors: array[TLMDDebugMsgKind] of TColor = (
    clWindow,       // dmDebuggerOutput
    clWindow,       // dmBreakpointReached
    clWindow,       // dmLogMessage
    clWindow,       // dmEvalExpr
    clWindow,       // dmLogStackHeader
    clWindow        // dmLogStackFrame
  );

var
  CachedBrushBitmap:  TBitmap; // Lazy inited, use GetBrushBitmap.
  DefDebugImages:     TImageList;

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

procedure InitImages;

  procedure _AddBitmap(const AResName: string);
  var
    bmp:  TBitmap;
    mask: TBitmap;
  begin
    bmp  := TBitmap.Create;
    mask := TBitmap.Create;
    try
      bmp.Transparent := True;
      bmp.LoadFromResourceName(HInstance, AResName);

      mask.Assign(bmp);
      mask.Mask(mask.Canvas.Pixels[0, 0]);

      DefDebugImages.Add(bmp, mask);
    finally
      bmp.Free;
      mask.Free;
    end;
  end;

begin
  DefDebugImages := TImageList.Create(nil);
  try
    _AddBitmap('LMD_CALLSTACKTOP');      // 0
    _AddBitmap('LMD_CALLSTACKNORMAL');   // 1
    _AddBitmap('LMD_BPNORMAL');          // 2
    _AddBitmap('LMD_BPDISABLED');        // 3
  except
    DefDebugImages.Free;
    DefDebugImages := nil;
    raise;
  end;
end;

function GetBrushBitmap(AColor, ABkColor: TColor): TBitmap;
var
  i, j: Integer;
begin
  if CachedBrushBitmap = nil then
  begin
    CachedBrushBitmap        := TBitmap.Create;
    CachedBrushBitmap.Width  := 8;
    CachedBrushBitmap.Height := 8;
  end;

  with CachedBrushBitmap do
  begin
    if (Canvas.Pixels[0, 0] <> AColor) or
       (Canvas.Pixels[1, 0] <> ABkColor) then
    begin
      Canvas.Brush.Color := ABkColor;
      Canvas.FillRect(Rect(0, 0, 8, 8));

      for i := 0 to 7 do
      begin
        j := 0;
        if i mod 2 <> 0 then
          Inc(j);

        while j <= 7 do
        begin
          Canvas.Pixels[j, i] := AColor;
          Inc(j, 2);
        end;
      end;
    end;
  end;

  Result := CachedBrushBitmap;
end;

procedure DrawHorzBrushLine(ACanvas: TCanvas; X1, X2, Y: Integer);
begin
  ACanvas.FillRect(Rect(X1, Y, X2, Y + 1));
end;

procedure DrawVertBrushLine(ACanvas: TCanvas; X, Y1, Y2: Integer);
begin
  ACanvas.FillRect(Rect(X, Y1, X + 1, Y2));
end;

procedure DrawTextWithElipsis(ACanvas: TCanvas; const S: TLMDString;
  const R: TRect);
var
  flags: Cardinal;
  tr:    TRect;
begin
  flags := DT_SINGLELINE or DT_LEFT or DT_VCENTER or DT_END_ELLIPSIS;
  tr    := R;

  {$IFNDEF CLR}
  {$IFDEF _LMD_UNICODEIMPL}
  DrawTextW(ACanvas.Handle, PWideChar(S), Length(S), tr, flags);
  {$ELSE}
  DrawText(ACanvas.Handle, PChar(S), Length(S), tr, flags);
  {$ENDIF}
  {$ELSE}
  DrawText(ACanvas.Handle, S, Length(S), tr, flags);
  {$ENDIF}
end;

procedure DrawCheckbox(ACanvas: TCanvas; AChecked: Boolean;
  const R: TRect; ABtn: PRect = nil);
const
  BTN_STYLE: array[Boolean] of TThemedButton = (tbCheckBoxUncheckedNormal,
                                                tbCheckBoxCheckedNormal);
  CHECK_MARK: array[0..6] of Integer = (0, 1, 2, 1, 0, -1, -2);
var
  LDetails: TThemedElementDetails;
  i:        Integer;
  btn: TRect;
begin
  with ACanvas do
  begin
    btn := Rect(R.Left, R.Top, R.Left + CheckBoxSize, R.Top + CheckBoxSize);
    OffsetRect(btn, 0, ((R.Bottom - R.Top) - CheckBoxSize) div 2);

    if ThemeServices.ThemesEnabled then
    begin
      LDetails := ThemeServices.GetElementDetails(BTN_STYLE[AChecked]);
      ThemeServices.DrawElement(Handle, LDetails, btn);
    end
    else
    begin
      Pen.Color := clBlack;
      Rectangle(btn);

      if AChecked then
      begin
        for i := 0 to 6 do
        begin
          MoveTo(btn.Left + i + 3, btn.Top + CHECK_MARK[i] + 5);
          LineTo(btn.Left + i + 3, btn.Top + CHECK_MARK[i] + 5 + 3);
        end;
      end;
    end;

    if ABtn <> nil then
      ABtn^ := btn;
  end;
end;

procedure DrawExpandButton(ACanvas: TCanvas; AX, AY: Integer;
  AExpanded: Boolean; ABtn: PRect = nil);
const
  BTN_STYLE: array[Boolean] of TThemedTreeview = (ttGlyphClosed,
                                                  ttGlyphOpened);
var
  LDetails: TThemedElementDetails;
  btn:      TRect;
begin
  with ACanvas do
  begin
    btn := Rect(AX, AY, AX + ExpandBtnSize, AY + ExpandBtnSize);

    if ThemeServices.ThemesEnabled then
    begin
      LDetails := ThemeServices.GetElementDetails(BTN_STYLE[AExpanded]);
      ThemeServices.DrawElement(Handle, LDetails, btn);
    end
    else
    begin
      Pen.Color := clBtnShadow;
      Rectangle(btn);

      Pen.Color := clBlack;
      Polyline([Point(btn.Left + 2, btn.Top + 4),
                Point(btn.Left + 7, btn.Top + 4)]);
      if not AExpanded then
        Polyline([Point(btn.Left + 4, btn.Top + 2),
                  Point(btn.Left + 4, btn.Top + 7)]);
    end;

    if ABtn <> nil then
      ABtn^ := btn;
  end;
end;

constructor TLMDVarsTreeBase.Create(AOwner: TComponent);
begin
  inherited;
  ViewStyle         := vsReport;
  RowSelect         := True;
  ReadOnly          := True;
  OwnerDraw         := True;
  OwnerData         := True;
  ColumnClick       := False;
  FRoot             := TLMDRootExpandedNode.Create(Self);
  FImageLst         := TImageList.Create(nil);
  FImageLst.Width   := GetSystemMetrics(SM_CXSMICON) + 1; // This is the way
  FImageLst.Height  := GetSystemMetrics(SM_CYSMICON) + 1; // to control item's
  SmallImages       := FImageLst;                         // height.
  InitColumns;
end;

destructor TLMDVarsTreeBase.Destroy;
begin
  FRoot.Free;
  FItemBuffer.Free;
  FImageLst.Free;
  inherited;
end;

{ TLMDExpandedNode }

function TLMDExpandedNode.Add(AKey: Pointer;
  AIndex: Integer): TLMDExpandedNode;
begin
  Result := TLMDExpandedNode.Create(Self, AKey, AIndex);
end;

procedure TLMDExpandedNode.Clear;
begin
  while FItems <> nil do
    TLMDExpandedNode(FItems[0]).Delete;
end;

constructor TLMDExpandedNode.Create(AParent: TLMDExpandedNode;
  AKey: Pointer; AIndex: Integer);
begin
  inherited Create;

  FParent := AParent;
  FKey    := AKey;
  FIndex  := AIndex;

  if FParent <> nil then
  begin
    FParent.InsertItem(Self);
    GetRoot.InsertInIndex(Self);
  end;
end;

procedure TLMDExpandedNode.Delete;
begin
  Free;
end;

destructor TLMDExpandedNode.Destroy;
begin
  Clear;

  if FParent <> nil then
  begin
    GetRoot.RemoveFromIndex(Self);
    FParent.RemoveItem(Self);
  end;

  FItems.Free;
  inherited;
end;

procedure TLMDVarsTreeBase.GetData(const ANode: TLMDNodeDescr;
  out AData: TLMDNodeData);
var
  pthA:       array[0..15] of Integer;
  pthB:       array of Integer;
  ppth:       PLMDNodePath;
  pthsz, idx: Integer;
  expnd:      TLMDExpandedNode;
begin
  pthsz := GetLevel(ANode);

  if pthsz <= 16 then
    ppth := @pthA[0]
  else
  begin
    SetLength(pthB, pthsz);
    ppth := @pthB[0];
  end;

  expnd := ANode.Parent;
  idx   := pthsz - 1;

  ppth[idx] := ANode.Index;
  Dec(idx);

  while expnd <> FRoot do
  begin
    ppth[idx] := expnd.Index;
    expnd     := expnd.Parent;
    Dec(idx);
  end;

  DoGetNodeData(ppth, pthsz, AData);
end;

function TLMDVarsTreeBase.GetLevel(const ANode: TLMDNodeDescr): Integer;
begin
  Result := ANode.Parent.Level + 1;
end;

function TLMDVarsTreeBase.GetSelectedPath(APathBuf: PLMDNodePath;
  ABufSize: Integer): Integer;
var
  item:  TListItem;
  ndd:   TLMDNodeDescr;
  expnd: TLMDExpandedNode;
  idx:   Integer;
begin
  // Returns -1 if no node selected. Otherwise returns path size.
  // If the buffer is too small for the path it will not be filled.

  Result := -1;
  item   := Selected;
  if item = nil then
    Exit;

  ndd    := NodeByListIdx(item.Index);
  Result := GetLevel(ndd);

  if Result > ABufSize then
    Exit;

  expnd := ndd.Parent;
  idx   := Result - 1;

  APathBuf[idx] := ndd.Index;
  Dec(idx);

  while expnd <> FRoot do
  begin
    APathBuf[idx] := expnd.Index;
    expnd         := expnd.Parent;
    Dec(idx);
  end;
end;

function TLMDVarsTreeBase.GetThemedBackColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleColor(scTreeView)
  else
  {$ENDIF}
    Result := Color;
end;

function TLMDVarsTreeBase.GetThemedTextColor(AEnabled: Boolean): TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
  begin
    if AEnabled then
      Result := StyleServices.GetStyleFontColor(sfTreeItemTextNormal)
    else
      Result := StyleServices.GetStyleFontColor(sfTreeItemTextDisabled)
  end
  else
  {$ENDIF}
  begin
    if AEnabled then
      Result := Font.Color
    else
      Result := clBtnShadow;
  end;
end;

function TLMDVarsTreeBase.NodeByListIdx(AListIdx: Integer): TLMDNodeDescr;
var
  expnd:  TLMDExpandedNode;
  cshnd:  TLMDExpandedNode;
  cshcnt: Integer;
begin
  if FCachedNode.Parent = nil then
  begin
    FCachedNode.Parent := FRoot;
    FCachedNode.Index  := 0;
    FCachedListIdx     := 0;
  end;

  cshnd  := nil;
  cshcnt := 0;

  while FCachedListIdx <> AListIdx do
  begin
    Assert(FCachedNode.Parent <> nil);

    if FCachedListIdx < AListIdx then
    begin
      { Step forward }

      expnd := FRoot.FindItem(FCachedNode);

      if expnd <> nil then
      begin
        FCachedNode.Parent := expnd;
        FCachedNode.Index  := 0;
      end
      else
      begin
        if cshnd <> FCachedNode.Parent then
        begin
          cshcnt := GetChildCount(FCachedNode.Parent);
          cshnd  := FCachedNode.Parent;
        end;

        while FCachedNode.Index = cshcnt - 1 do
        begin
          if FCachedNode.Parent.Parent = nil then
            Assert(FCachedNode.Parent.Parent <> nil);

          expnd              := FCachedNode.Parent;
          FCachedNode.Parent := expnd.Parent;
          FCachedNode.Index  := expnd.Index;

          if cshnd <> FCachedNode.Parent then
          begin
            cshcnt := GetChildCount(FCachedNode.Parent);
            cshnd  := FCachedNode.Parent;
          end;
        end;

        Inc(FCachedNode.Index);
      end;

      Inc(FCachedListIdx);
    end
    else
    begin
      { Step backward }

      if FCachedNode.Index = 0 then
      begin
        Assert(FCachedNode.Parent.Parent <> nil);

        expnd              := FCachedNode.Parent;
        FCachedNode.Parent := expnd.Parent;
        FCachedNode.Index  := expnd.Index;
      end
      else
      begin
        Dec(FCachedNode.Index);

        expnd := FRoot.FindItem(FCachedNode);

        while expnd <> nil do
        begin
          if cshnd <> expnd then
          begin
            cshcnt := GetChildCount(expnd);
            cshnd  := expnd;
          end;

          FCachedNode.Parent := expnd;
          FCachedNode.Index  := GetChildCount(expnd) - 1;

          expnd := FRoot.FindItem(FCachedNode);
        end;
      end;

      Dec(FCachedListIdx);
    end;
  end;

  Result := FCachedNode;
end;

procedure TLMDVarsTreeBase.NotifyDesigner;
var
  frm: TCustomForm;
begin
  if csDesigning in ComponentState then
  begin
    frm := GetParentForm(Self);
    if (frm <> nil) and (frm.Designer <> nil) then
      frm.Designer.Modified;
  end;
end;

function TLMDVarsTreeBase.OwnerDataFetch(Item: TListItem;
  Request: TItemRequest): Boolean;
var
  dt: TLMDNodeData;
begin
  Result := True;
  GetData(NodeByListIdx(Item.Index), dt);

  Item.Caption := dt.Name;
  Item.SubItems.Add(dt.Value);
end;

procedure TLMDVarsTreeBase.UpdateView(AInvalidate: Boolean);
var
  vlddt: TIterateNodesPath;
  cvcdt: TCountVisibleChildrenData;
begin
  FCachedNode.Parent := nil;
  FCachedNode.Index  := -1;
  FRoot.ForAllItems(ValidateExpNodeProc, @vlddt);
  FRoot.UpdateHashIndex;

  cvcdt.Count := DoGetChildCount(nil, 0);
  FRoot.ForAllItems(CountVisibleChildrenProc, @cvcdt);
  FListSize   := cvcdt.Count;

  if HandleAllocated then
  begin
    Items.Count := FListSize;
    if Columns.Count > 0 then
      AdjustColumns(Columns[0].Width, Width);

    if AInvalidate then
      Invalidate;
  end;
end;

function TLMDVarsTreeBase.ValidateExpNodeProc(AItem: TLMDExpandedNode;
  AUserData: Pointer): TLMDExpNodeProcRes;
var
  idx: Integer;
  pth: PIterateNodesPath;
  lvl: Integer;
begin
  pth := PIterateNodesPath(AUserData);
  lvl := AItem.Level;
  idx := DoKeyIndexOf(@pth^[0], lvl - 1, AItem.Key);

  if idx <> -1 then
  begin
    if Length(pth^) < lvl then // Update path.
      SetLength(pth^, lvl);    //
    pth^[lvl - 1] := idx;      //

    if DoGetChildCount(@pth^[0], lvl) > 0 then
    begin
      AItem.FIndex := idx;
      Result       := enrProcessChildren;
    end
    else
      Result := cnrDeleteItem;
  end
  else
    Result := cnrDeleteItem;
end;

procedure TLMDExpandedNode.ForAllItems(AProc: TLMDExpNodeProc;
  AUserData: Pointer);
var
  i: Integer;
begin
  i := 0;
  while (FItems <> nil) and (i < FItems.Count) do
  begin
    case AProc(TLMDExpandedNode(FItems[i]), AUserData) of
      enrProcessChildren:
      begin
        TLMDExpandedNode(FItems[i]).ForAllItems(AProc, AUserData);
        Inc(i);
      end;
      cnrDeleteItem:
        TLMDExpandedNode(FItems[i]).Delete;
    end;
  end;
end;

function TLMDVarsTreeBase.GetChildCount(
  const ANode: TLMDNodeDescr): Integer;

  function _DynArrayVersion: Integer;
  var
    pth:        array of Integer;
    pthsz, idx: Integer;
    expnd:      TLMDExpandedNode;
  begin
    pthsz := GetLevel(ANode);

    SetLength(pth, pthsz);

    expnd := ANode.Parent;
    idx   := pthsz - 1;

    pth[idx] := ANode.Index;
    Dec(idx);

    while expnd <> FRoot do
    begin
      pth[idx]  := expnd.Index;
      expnd     := expnd.Parent;
      Dec(idx);
    end;

    Result := DoGetChildCount(@pth[0], pthsz);
  end;

var
  pth:        array[0..15] of Integer;
  pthsz, idx: Integer;
  expnd:      TLMDExpandedNode;
begin
  pthsz := GetLevel(ANode);

  if pthsz > 16 then
  begin
    Result := _DynArrayVersion;
    Exit;
  end;

  expnd := ANode.Parent;
  idx   := pthsz - 1;

  pth[idx] := ANode.Index;
  Dec(idx);

  while expnd <> FRoot do
  begin
    pth[idx]  := expnd.Index;
    expnd     := expnd.Parent;
    Dec(idx);
  end;

  Result := DoGetChildCount(@pth[0], pthsz);
end;

function TLMDVarsTreeBase.GetChildCount(
  const ANode: TLMDExpandedNode): Integer;
var
  ndd: TLMDNodeDescr;
begin
  if ANode = FRoot then
    Result := DoGetChildCount(nil, 0)
  else
  begin
    ndd.Parent := ANode.Parent;
    ndd.Index  := ANode.Index;
    Result     := GetChildCount(ndd);
  end;
end;

function TLMDExpandedNode.GetLevel: Integer;
var
  cur: TLMDExpandedNode;
begin
  Result := 0;
  cur    := Self;

  while cur.FParent <> nil do
  begin
    cur := cur.FParent;
    Inc(Result);
  end;
end;

function TLMDExpandedNode.GetRoot: TLMDRootExpandedNode;
var
  cur: TLMDExpandedNode;
begin
  cur := Self;
  while cur.FParent <> nil do
    cur := cur.FParent;

  Result := TLMDRootExpandedNode(cur);
end;

function TLMDExpandedNode.GetTree: TLMDVarsTreeBase;
begin
  Result := TLMDRootExpandedNode(GetRoot).FTree;
end;

procedure TLMDExpandedNode.InsertItem(AItem: TLMDExpandedNode);
begin
  if FItems = nil then
    FItems := TList.Create;
  FItems.Add(AItem);
end;

procedure TLMDExpandedNode.RemoveItem(AItem: TLMDExpandedNode);
begin
  if FItems <> nil then
  begin
    FItems.Remove(AItem);
    if FItems.Count = 0 then
      FreeAndNil(FItems);
  end;
end;

procedure TLMDVarsTreeBase.CheckboxClicked(const ANode: TLMDNodeDescr);
var
  pthA:       array[0..15] of Integer;
  pthB:       array of Integer;
  ppth:       PLMDNodePath;
  pthsz, idx: Integer;
  expnd:      TLMDExpandedNode;
begin
  pthsz := GetLevel(ANode);

  if pthsz <= 16 then
    ppth := @pthA[0]
  else
  begin
    SetLength(pthB, pthsz);
    ppth := @pthB[0];
  end;

  expnd := ANode.Parent;
  idx   := pthsz - 1;

  ppth[idx] := ANode.Index;
  Dec(idx);

  while expnd <> FRoot do
  begin
    ppth[idx] := expnd.Index;
    expnd     := expnd.Parent;
    Dec(idx);
  end;

  DoCheckboxClicked(ppth, pthsz);
end;

procedure TLMDVarsTreeBase.CMDesignHitTest(var Message: TCMDesignHitTest);
var
  p:   TPoint;
  itm: TListItem;
begin
  inherited;

  p   := SmallPointToPoint(Message.Pos);
  itm := GetItemAt(p.X, p.Y);

  if (itm <> nil) and IsOnCheckBtn(p) then
    Message.Result := 1;
end;

function TLMDVarsTreeBase.CountVisibleChildrenProc(
  AItem: TLMDExpandedNode; AUserData: Pointer): TLMDExpNodeProcRes;
var
  dt:  PCountVisibleChildrenData;
  lvl: Integer;
begin
  dt  := PCountVisibleChildrenData(AUserData);
  lvl := AItem.Level;

  if Length(dt.Path) < lvl then
    SetLength(dt.Path, lvl);
  dt.Path[lvl - 1] := AItem.Index;

  Inc(dt.Count, DoGetChildCount(@dt.Path[0], lvl));
  Result := enrProcessChildren;
end;

{ TLMDVariablesTree }

constructor TLMDVariablesView.Create(AOwner: TComponent);
begin
  inherited;
  FVars           := TVarsViewItems.Create(Self);
  FSourceNotifier := TVarsViewSourceNotifier.Create(Self);
  FAutoShowRoot   := True;
end;

destructor TLMDVariablesView.Destroy;
begin
  Destroying;

  Source := nil;
  FSourceNotifier.Free;
  FVars.Free;
  FVars := nil;
  inherited;
end;

function TLMDVariablesView.DoGetChildCount(APath: PLMDNodePath;
  APathSize: Integer): Integer;
var
  v: TLMDVariable;
begin
  if FShowRoot and (APathSize = 0) and (FVars.Root <> nil) then
    Result := 1 // root
  else if TryVarByPath(APath, APathSize, v) then
    Result := v.Count
  else
    Result := 0;
end;

procedure TLMDVariablesView.DoGetNodeData(APath: PLMDNodePath;
  APathSize: Integer; var AData: TLMDNodeData);
var
  v: TLMDVariable;
begin
  if TryVarByPath(APath, APathSize, v) then
  begin
    AData.Name         := v.Name;
    AData.Value        := v.Value;
    AData.ShowCheckbox := False;
    AData.Enabled      := True;
  end;
end;

procedure TLMDVarsTreeBase.CreateHandle;
begin
  inherited;
  AdjustColumns(Columns[0].Width, Width);
  UpdateView;
end;

procedure TLMDVarsTreeBase.CreateWnd;
begin
  inherited;
  if Columns.Count = 0 then
    InitColumns;
end;

procedure TLMDVarsTreeBase.DblClick;
var
  p:    TPoint;
  item: TListItem;
  ndd:  TLMDNodeDescr;
begin
  GetCursorPos(p);
  MapWindowPoints(0, Handle, p, 1);

  item := GetItemAt(p.X, p.Y);

  if (item <> nil) and not IsOnExpBtn(p) and
     not IsOnCheckBtn(p) then
  begin
    ndd := NodeByListIdx(item.Index);
    SetExpanded(item.Index, not GetExpanded(ndd));
  end;

  inherited;
end;

function TLMDVariablesView.GetRoot: TLMDVariable;
begin
  Result := FVars.Root;
end;

function TLMDVariablesView.IsShowRootStored: Boolean;
begin
  Result := (FSource = nil) or not FAutoShowRoot;
end;

procedure TLMDVariablesView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FSource) then
    Source := nil;
end;

procedure TLMDVariablesView.SetAutoShowRoot(const Value: Boolean);
begin
  if FAutoShowRoot <> Value then
  begin
    FAutoShowRoot := Value;
    if FAutoShowRoot and (FShowRoot <> (FKind = dkExpression)) then
      SourceStateChanged;
  end;
end;

procedure TLMDVariablesView.SetExpression(const Value: TLMDString);
begin
  if FExpression <> Value then
  begin
    FExpression := Value;
    FKind       := dkExpression;

    SourceStateChanged;
  end;
end;

procedure TLMDVariablesView.SetKind(const Value: TLMDVarsViewDataKind);
begin
  if FKind <> Value then
  begin
    FKind := Value;
    if FKind = dkLocalVars then
      FExpression := '';

    SourceStateChanged;
  end;
end;

procedure TLMDVariablesView.SetShowRoot(const Value: Boolean);
begin
  if FShowRoot <> Value then
  begin
    FShowRoot := Value;
    FVars.Changed; // To be consistent with
                   // Items.BeginUpdate/Items.EndUpdate.
  end;
end;

procedure TLMDVariablesView.SetSource(const Value: TLMDDebuggerSource);
begin
  if FSource <> Value then
  begin
    if FSource <> nil then
    begin
      FSource.RemoveNotifier(FSourceNotifier);
      FSource.RemoveFreeNotification(Self);
    end;

    FSource := Value;

    if FSource <> nil then
    begin
      FSource.AddNotifier(FSourceNotifier);
      FSource.FreeNotification(Self);
    end;

    SourceStateChanged;
  end;
end;

procedure TLMDVariablesView.SourceStateChanged;
begin
  if not (csDesigning in ComponentState) then
    UpdateView;
end;

procedure TLMDVariablesView.UpdateView;
begin
  FVars.BeginUpdate;
  try
    if (FSource <> nil) and (FSource.Debugger <> nil) and
       (FSource.Debugger.BreakKind <> bkNone) then
    begin
      case FKind of
        dkLocalVars:  FSource.StackFrame.GetVariables(FVars);
        dkExpression: begin
                        if FExpression <> '' then
                          FSource.StackFrame.Eval(FExpression, FVars)
                        else
                          FVars.Clear;
                      end;
      end;

      if FAutoShowRoot then
        ShowRoot := (FKind = dkExpression);
    end
    else
      FVars.Clear;
  finally
    FVars.EndUpdate;
  end;
end;

function TLMDVarsTreeBase.GetExpanded(const ANode: TLMDNodeDescr): Boolean;
begin
  Result := (FRoot.FindItem(ANode) <> nil);
end;

procedure TLMDVarsTreeBase.SetExpanded(AListIdx: Integer;
  AValue, AInvalidate: Boolean);
var
  expnd: TLMDExpandedNode;
  cnt:   Integer;
  last:  Integer;
  ndd:   TLMDNodeDescr;
  nddt:  TLMDNodeData;
begin
  ndd   := NodeByListIdx(AListIdx);
  expnd := FRoot.FindItem(ndd);

  if AValue then
  begin
    cnt := GetChildCount(ndd);
    if (expnd <> nil) or (cnt = 0) then
      Exit;

    GetData(ndd, nddt);
    ndd.Parent.Add(nddt.Key, ndd.Index);
    Inc(FListSize, cnt);
  end
  else
  begin
    if expnd = nil then
      Exit;

    cnt := GetChildCount(expnd);
    expnd.ForAllItems(CountVisibleChildrenProc, @cnt);

    expnd.Delete;
    Dec(FListSize, cnt);
  end;

  FCachedNode    := ndd;
  FCachedListIdx := AListIdx;
  Items.Count    := FListSize;
  if HandleAllocated and (Columns.Count > 0) then
    AdjustColumns(Columns[0].Width, Width);

  if AInvalidate then
  begin
    last := TopItem.Index + VisibleRowCount;
    if last > FListSize - 1 then
      last := FListSize - 1;

    UpdateItems(TopItem.Index, last);
  end;
end;

function TLMDVarsTreeBase.CustomDrawItem(Item: TListItem;
  State: TCustomDrawState; Stage: TCustomDrawStage): Boolean;
var
  r, bufr, valr: TRect;
  ebtn, chbtn:   TRect;
  ndd:           TLMDNodeDescr;
  valoff:        Integer;
  b:             TBitmap;
  itmidx: Integer;
begin
  if Stage = cdPrePaint then
  begin
    if Item.Selected then          // TListView bug.
      Include(State, cdsSelected); //

    itmidx := Item.Index; // We need to fetch item index here, because
                          // indirect call to TopItem will re-populate
                          // this *temporary* virtual-listview item.

    r := Item.DisplayRect(drBounds);
    ListView_GetSubItemRect(Handle, itmidx, 1, LVIR_BOUNDS, @valr);

    valoff := valr.Left - r.Left;
    ndd    := NodeByListIdx(itmidx);

    { Get buffer bitmap }

    b      := GetBufferBitmap(r.Right - r.Left, r.Bottom - r.Top + 1);
    bufr   := r;
    OffsetRect(bufr, -r.Left, -r.Top);

    if r.Top mod 2 <> 0 then  // Required for continious brushed tree
      OffsetRect(bufr, 0, 1); // lines. So, the bufr.Top CAN be non-zero.

    DoDrawItem(ndd, itmidx, State, b.Canvas, bufr, valoff, ebtn, chbtn);
    Canvas.CopyRect(r, b.Canvas, bufr);

    OffsetRect(ebtn, r.Left, r.Top);
    SetExpBtn(itmidx, ebtn);

    OffsetRect(chbtn, r.Left, r.Top);
    SetCheckBtn(itmidx, chbtn);
  end;

  Result := False;
end;

function TLMDVarsTreeBase.IsCustomDrawn(Target: TCustomDrawTarget;
  Stage: TCustomDrawStage): Boolean;
begin
  Result := (Target in [dtControl, dtItem, dtSubItem]);
end;

procedure TLMDVarsTreeBase.WMNotify(var Message: TWMNotify);
var
  setres: Boolean;
begin
  setres := False;

  case Message.NMHdr.code of
    HDN_BEGINTRACKA,
    HDN_BEGINTRACKW:
      with PHDNotify(Pointer(Message.NMHdr))^ do
      begin
        if Item = 1 then  // Prevent dragging autosized
          setres := True; // Value's column splitter.
      end;
    HDN_ITEMCHANGEDA,
    HDN_ITEMCHANGEDW:
      with PHDNotify(Pointer(Message.NMHdr))^ do
      begin
        if Item = 0 then
          AdjustColumns(PItem.cxy, Width);
      end;
  end;

  inherited;

  if setres then
    Message.Result := 1;
end;

procedure TLMDVarsTreeBase.InitColumns;
var
  cln:    TListColumn;
  nmcln:  TLMDString;
  valcln: TLMDString;
begin
  DoGetColumnNames(nmcln, valcln);

  cln          := Columns.Add;
  cln.Caption  := nmcln;
  cln.Width    := 100;
  cln          := Columns.Add;
  cln.Caption  := valcln;
end;

procedure TLMDVarsTreeBase.AdjustColumns(ANameWidth, AWholeWidth: Integer);
var
  w:     Integer;
  r:     TRect;
  delta: Integer;
begin
  if HandleAllocated and not FAdjusting and (Columns.Count > 1) then
  begin
    FAdjusting := True;

    r := ClientRect;
    AdjustClientRect(r);

    delta := Width - (r.Right - r.Left);
    w     := (AWholeWidth - delta) - ANameWidth;
    if w < 32 then
      w := 32;

    Columns[1].Width := w;
    FAdjusting       := False;
  end;
end;

procedure TLMDVarsTreeBase.WMEraseBkGnd(var Message: TWMEraseBkGnd);
begin
  Message.Result := 1;
end;

function TLMDVarsTreeBase.GetBufferBitmap(AWidth,
  AHeight: Integer): TBitmap;
begin
  if FItemBuffer = nil then
  begin
    FItemBuffer        := TBitmap.Create;
    FItemBuffer.Handle := CreateCompatibleBitmap(Canvas.Handle, AWidth,
                                                 AHeight);
  end
  else
  begin
    FItemBuffer.Width  := AWidth;
    FItemBuffer.Height := AHeight;
  end;
  
  FItemBuffer.Canvas.Font := Font;
  Result                  := FItemBuffer;
end;

function TLMDVarsTreeBase.CustomDraw(const ARect: TRect;
  Stage: TCustomDrawStage): Boolean;
var
  lastitm: Integer;
  r:       TRect;
  i:       Integer;
  dcidx:   Integer;
begin
  Result := True;

  if Stage = cdPrePaint then
  begin
    dcidx := SaveDC(Canvas.Handle);
    try
      if Items.Count > 0 then
      begin
        lastitm := TopItem.Index + VisibleRowCount;
        if lastitm > Items.Count - 1 then
          lastitm := Items.Count - 1;

        for i := TopItem.Index to lastitm do
        begin
          r := Items[i].DisplayRect(drBounds);
          ExcludeClipRect(Canvas.Handle, r.Left, r.Top, r.Right, r.Bottom);
        end;
      end;

      Canvas.Brush.Color := GetThemedBackColor;
      Canvas.FillRect(Rect(0, 0, Width, Height)); // ClientRect not always
                                                  // crrect here.
    finally
      RestoreDC(Canvas.Handle, dcidx);
    end;
  end;
end;

function TLMDVariablesView.TryVarByPath(APath: PLMDNodePath;
  APathSize: Integer; out AVar: TLMDVariable): Boolean;
var
  i:   Integer;
  cur: TLMDVariable;
begin
  cur := nil;

  if FVars <> nil then
  begin
    cur := FVars.Root;
    for i := Ord(FShowRoot) to APathSize - 1 do
      cur := cur[APath[i]];
  end;

  AVar   := cur;
  Result := (cur <> nil);
end;

procedure TLMDVariablesView.VarsChanged;
begin
  inherited UpdateView;
end;

{ TLMDRootExpandedNode }

constructor TLMDRootExpandedNode.Create(ATree: TLMDVarsTreeBase);
begin
  inherited Create(nil, nil, 0);

  FTree := ATree;
  FIndex := TLMDHashTable.Create(TNodeIndexTraits);
end;

destructor TLMDRootExpandedNode.Destroy;
begin
  FIndex.Free;
  inherited;
end;

function TLMDRootExpandedNode.FindItem(
  const ANode: TLMDNodeDescr): TLMDExpandedNode;
begin
  Result := TLMDExpandedNode(FIndex.Find(ANode));
end;

procedure TLMDRootExpandedNode.InsertInIndex(AItem: TLMDExpandedNode);
begin
  FIndex.Add(AItem);
end;

procedure TLMDRootExpandedNode.RemoveFromIndex(AItem: TLMDExpandedNode);
var
  ndd: TLMDNodeDescr;
begin
  ndd.Parent := AItem.FParent;
  ndd.Index  := AItem.FIndex;
  FIndex.Remove(ndd);
end;

procedure TLMDRootExpandedNode.UpdateHashIndex;
begin
  FIndex.Update;
end;

{ TNodeIndexTraits }

class function TNodeIndexTraits.Compare(const AKey;
  AItem: TObject): Boolean;
begin
  Result := (TLMDExpandedNode(AItem).FParent = TLMDNodeDescr(AKey).Parent) and
            (TLMDExpandedNode(AItem).FIndex = TLMDNodeDescr(AKey).Index);
end;

class function TNodeIndexTraits.MakeHashI(AItem: TObject): Integer;
var
  ndd: TLMDNodeDescr;
begin
  ndd.Parent := TLMDExpandedNode(AItem).FParent;
  ndd.Index  := TLMDExpandedNode(AItem).FIndex;
  Result     := MakeHashK(ndd);
end;

class function TNodeIndexTraits.MakeHashK(const AKey): Integer;
begin
  with TLMDNodeDescr(AKey) do
    Result := TLMDHashTable.IntHash(Integer(Parent) xor Index);
end;

function TLMDVarsTreeBase.IsOnCheckBtn(const P: TPoint): Boolean;
var
  i: Integer;
begin
  for i := 0 to High(FCheckBtns) do
    if PtInRect(FCheckBtns[i], P) then
    begin
      Result := True;
      Exit;
    end;

  Result := False;
end;

function TLMDVarsTreeBase.IsOnExpBtn(const P: TPoint): Boolean;
var
  i: Integer;
begin
  for i := 0 to High(FExpBtns) do
    if PtInRect(FExpBtns[i], P) then
    begin
      Result := True;
      Exit;
    end;

  Result := False;
end;

procedure TLMDVarsTreeBase.SetExpBtn(AListIdx: Integer;
  const ABounds: TRect);
var
  idx: Integer;
begin
  idx := AListIdx - TopItem.Index;
  if idx < 0 then // For sure
    Exit;         //

  if idx > High(FExpBtns) then
    SetLength(FExpBtns, idx + 1);

  FExpBtns[idx] := ABounds;
end;

procedure TLMDVarsTreeBase.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  item: TListItem;
  ndd:  TLMDNodeDescr;
  p:    TPoint;
begin
  item := GetItemAt(X, Y);
  p    := Point(X, Y);

  if item <> nil then
  begin
    if IsOnExpBtn(p) then
    begin
      ndd := NodeByListIdx(item.Index);
      SetExpanded(item.Index, not GetExpanded(ndd));
    end
    else if IsOnCheckBtn(p) then
    begin
      ndd := NodeByListIdx(item.Index);
      CheckboxClicked(ndd);
      NotifyDesigner;
    end;
  end;

  inherited;
end;

procedure TLMDVarsTreeBase.SetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
begin
  if HandleAllocated and (Columns.Count > 0) and (AWidth < Width) then
    AdjustColumns(Columns[0].Width, AWidth);
  inherited;
  if HandleAllocated and (Columns.Count > 0) and (AWidth >= Width) then
    AdjustColumns(Columns[0].Width, AWidth);
end;

procedure TLMDVarsTreeBase.SetCheckBtn(AListIdx: Integer; const ABounds: TRect);
var
  idx: Integer;
begin
  idx := AListIdx - TopItem.Index;
  if idx < 0 then // For sure
    Exit;         //

  if idx > High(FCheckBtns) then
    SetLength(FCheckBtns, idx + 1);

  FCheckBtns[idx] := ABounds;
end;

procedure TLMDVarsTreeBase.DoCheckboxClicked(APath: PLMDNodePath;
  APathSize: Integer);
begin
  // Do nothing.
end;

procedure TLMDVarsTreeBase.DoDrawItem(const ANode: TLMDNodeDescr;
  AListIdx: Integer; State: TCustomDrawState; ACanvas: TCanvas;
  const ARect: TRect; AValClnOffset: Integer; out AExpBtn,
  ACheckBtn: TRect);
var
  r:        TRect;
  cur:      TLMDExpandedNode;
  dt:       TLMDNodeData;
  lnA, lnB: TPoint;
  bkclr:    TColor;
  fntclr:   TColor;
  dcidx:    Integer;
begin
  AExpBtn   := Rect(0, 0, 0, 0);
  ACheckBtn := Rect(0, 0, 0, 0);
  r         := ARect;
  GetData(ANode, dt);

  { Fill background }

  if cdsSelected in State then
  begin
    if cdsFocused in State then
    begin
      bkclr  := clHighlight;
      fntclr := clHighlightText;
    end
    else
    begin
      bkclr  := LMDBlend(GetThemedBackColor,
                         GetThemedTextColor(True), 10);
      fntclr := GetThemedTextColor(dt.Enabled);
    end;
  end
  else
  begin
    bkclr  := GetThemedBackColor;
    fntclr := GetThemedTextColor(dt.Enabled);
  end;

  ACanvas.Font.Color  := fntclr;
  ACanvas.Brush.Color := bkclr;
  ACanvas.FillRect(r);

  { Draw first column in clipped rect }

  dcidx := SaveDC(ACanvas.Handle);
  try
    IntersectClipRect(ACanvas.Handle, r.Left, r.Top, AValClnOffset,
                      r.Bottom);

    { Draw tree lines }

    ACanvas.Brush.Bitmap := GetBrushBitmap(GetThemedTextColor(True),
                                           GetThemedBackColor);
    cur                  := ANode.Parent;

    while cur <> FRoot do
    begin
      if cur.Index < GetChildCount(cur.Parent) - 1 then
        DrawVertBrushLine(ACanvas, r.Left + 6 + 18 * (cur.Level - 1),
                          r.Top, r.Bottom);
      cur := cur.Parent;
    end;

    Inc(r.Left, 18 * (GetLevel(ANode) - 1));

    lnA := Point(r.Left + 6, r.Top);
    lnB := Point(lnA.X, r.Bottom);
    if (ANode.Index = 0) and (ANode.Parent = FRoot) then
      lnA.Y := r.Top + 8;
    if ANode.Index = GetChildCount(ANode.Parent) - 1 then
      lnB.Y := r.Top + 8;
    DrawVertBrushLine(ACanvas, lnA.X, lnA.Y, lnB.Y);
    DrawHorzBrushLine(ACanvas, r.Left + 6, r.Left + 16,
                      r.Top + 8);

    ACanvas.Brush.Bitmap := nil;
    ACanvas.Brush.Color  := bkclr;

    { Draw expand/collapse button }

    if GetChildCount(ANode) > 0 then
      DrawExpandButton(ACanvas, r.Left + 2, r.Top + 4,
                       GetExpanded(ANode), @AExpBtn);
    Inc(r.Left, 16);

    { Draw checkbox }

    if dt.ShowCheckbox then
    begin
      Inc(r.Left, 2);
      DrawCheckbox(ACanvas, dt.Checked, r, @ACheckBtn);
      Inc(r.Left, CheckBoxSize + 2);
    end;

    { Draw Name }

    ACanvas.Refresh;
    DrawTextWithElipsis(ACanvas, dt.Name, Rect(r.Left + 4, r.Top, AValClnOffset,
                                               r.Bottom));
  finally
    RestoreDC(ACanvas.Handle, dcidx);
  end;

  { Draw second column }

  ACanvas.Refresh;
  DrawTextWithElipsis(ACanvas, dt.Value, Rect(AValClnOffset + 4, r.Top, r.Right,
                                              r.Bottom));

  { Draw focus rect }

  if (cdsSelected in State) and (cdsFocused in State) then
    DrawFocusRect(ACanvas.Handle, ARect);
end;

procedure TLMDVarsTreeBase.DoGetColumnNames(var ANameCln,
  AValueCln: TLMDString);
begin
  ANameCln  := 'Name';
  AValueCln := 'Value';
end;

function TLMDVarsTreeBase.DoKeyIndexOf(AParentPath: PLMDNodePath;
  AParentPathSize: Integer; AKey: Pointer): Integer;
begin
  Result := -1; // Key not found.
end;

{ TVarsTreeItems }

constructor TVarsViewItems.Create(AView: TLMDVariablesView);
begin
  inherited Create;
  FView := AView;
end;

procedure TVarsViewItems.DoChange;
begin
  FView.VarsChanged;
  inherited;
end;

{ TLMDDebuggerSource }

procedure TLMDDebuggerSource.AddNotifier(ANotifier: ILMDDbgSourceNotifier);
begin
  if FNotifiers.IndexOf(ANotifier) = -1 then
    FNotifiers.Add(ANotifier);
end;

procedure TLMDDebuggerSource.AdjustFrameIndex;
begin
  if FDebugger <> nil then
  begin
    if FStackFrameIndex < 0 then
      FStackFrameIndex := 0;
    if FStackFrameIndex > FDebugger.StackFrameCount - 1 then
      FStackFrameIndex := FDebugger.StackFrameCount - 1;
  end
  else
    FStackFrameIndex := -1;
end;

procedure TLMDDebuggerSource.BreakpointsChanged(ADebugger: TLMDScriptDebugger);
begin
  DoBreakpointsChanged;
end;

constructor TLMDDebuggerSource.Create(AOwner: TComponent);
begin
  inherited;
  FDbgNotifier := TDebuggerNotifier.Create(Self);
  FNotifiers   := TList.Create;
end;

procedure TLMDDebuggerSource.DebuggerBreaked(ADebugger: TLMDScriptDebugger);
begin
  FStackFrameIndex := 0;
  AdjustFrameIndex;
  DoStateChanged([scFrameIndex, scDebuggerState]);
end;

procedure TLMDDebuggerSource.DebuggerResumed(ADebugger: TLMDScriptDebugger);
begin
  FStackFrameIndex := 0;
  AdjustFrameIndex;
  DoStateChanged([scFrameIndex, scDebuggerState]);
end;

procedure TLMDDebuggerSource.DebugLogMessage(ADebugger: TLMDScriptDebugger;
  const AMsg: TLMDString; AKind: TLMDDebugMsgKind);
begin
  DoLogMessage(AMsg, AKind);
end;

procedure TLMDDebuggerSource.DebugNameChanged(ADebugger: TLMDScriptDebugger;
  AScript: TLMDScriptControl);
begin
  DoStateChanged([scDebugNameChanged]);
end;

destructor TLMDDebuggerSource.Destroy;
begin
  Destroying;
  ServiceProvider := nil;
  Debugger := nil;
  FDbgNotifier.Free;
  FNotifiers.Free;
  FNotifiers := nil;
  inherited;
end;

procedure TLMDDebuggerSource.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FDebugger then
      Debugger := nil;
    if AComponent = FServiceProvider then
      ServiceProvider := nil;
  end;
end;

procedure TLMDDebuggerSource.DoBreakpointsChanged;
var
  i: Integer;
begin
  if not (csDestroying in ComponentState) then
  begin
    for i := 0 to FNotifiers.Count - 1 do
      ILMDDbgSourceNotifier(FNotifiers[i]).BreakpointsChanged;

    if Assigned(FOnBreakpointsChanged) then
      FOnBreakpointsChanged(Self);
  end;
end;

procedure TLMDDebuggerSource.DoLogMessage(const AMsg: TLMDString;
  AKind: TLMDDebugMsgKind);
var
  i: Integer;
begin
  if not (csDestroying in ComponentState) then
  begin
    for i := 0 to FNotifiers.Count - 1 do
      ILMDDbgSourceNotifier(FNotifiers[i]).LogMessage(AMsg, AKind);

    if Assigned(FOnLogMessage) then
      FOnLogMessage(Self, AMsg, AKind);
  end;
end;

procedure TLMDDebuggerSource.DoStateChanged(
  AChange: TLMDDbgSourceChange);
var
  i: Integer;
begin
  if not (csDestroying in ComponentState) then
  begin
    for i := 0 to FNotifiers.Count - 1 do
      ILMDDbgSourceNotifier(FNotifiers[i]).StateChanged(AChange);

    if Assigned(FOnStateChanged) then
      FOnStateChanged(Self);
  end;
end;

function TLMDDebuggerSource.GetStackFrame: TLMDStackFrame;
begin
  Result := nil;
  if (FDebugger <> nil) and (FStackFrameIndex >= 0) and
     (FStackFrameIndex < FDebugger.StackFrameCount) then
    Result := FDebugger.StackFrames[FStackFrameIndex];

end;

procedure TLMDDebuggerSource.RemoveNotifier(
  ANotifier: ILMDDbgSourceNotifier);
begin
  if FNotifiers <> nil then
    FNotifiers.Remove(ANotifier);
end;

procedure TLMDDebuggerSource.SetDebugger(const Value: TLMDScriptDebugger);
begin
  if FDebugger <> Value then
  begin
    if FDebugger <> nil then
    begin
      FDebugger.RemoveNotifier(FDbgNotifier);
      FDebugger.RemoveFreeNotification(Self);
    end;

    FDebugger := Value;

    if FDebugger <> nil then
    begin
      FDebugger.FreeNotification(Self);
      FDebugger.AddNotifier(FDbgNotifier);
    end;

    FStackFrameIndex := 0;
    AdjustFrameIndex;
    DoStateChanged([scFrameIndex, scDebuggerState]);
  end;
end;

procedure TLMDDebuggerSource.SetServiceProvider(
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

procedure TLMDDebuggerSource.SetStackFrameIndex(const Value: Integer);
begin
  if FStackFrameIndex <> Value then
  begin
    FStackFrameIndex := Value;
    AdjustFrameIndex;
    DoStateChanged([scFrameIndex]);
  end;
end;

function TLMDDebuggerSource.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_IDE;
end;

{ TDebuggerNotifier }

procedure TDebuggerNotifier.Breaked(ADebugger: TLMDScriptDebugger);
begin
  FSource.DebuggerBreaked(ADebugger);
end;

procedure TDebuggerNotifier.BreakpointsChanged(ADebugger: TLMDScriptDebugger);
begin
  FSource.BreakpointsChanged(ADebugger);
end;

constructor TDebuggerNotifier.Create(ASource: TLMDDebuggerSource);
begin
  inherited Create;
  FSource := ASource;
end;

procedure TDebuggerNotifier.DebugNameChanged(ADebugger: TLMDScriptDebugger;
  AScript: TLMDScriptControl);
begin
  FSource.DebugNameChanged(ADebugger, AScript);
end;

procedure TDebuggerNotifier.LogMessage(ADebugger: TLMDScriptDebugger;
  const AMsg: TLMDString; AKind: TLMDDebugMsgKind);
begin
  FSource.DebugLogMessage(ADebugger, AMsg, AKind);
end;

procedure TDebuggerNotifier.Resumed(ADebugger: TLMDScriptDebugger);
begin
  FSource.DebuggerResumed(ADebugger);
end;

{ TVarsTreeSourceNotifier }

procedure TVarsViewSourceNotifier.BreakpointsChanged;
begin
  // Do nothing.
end;

constructor TVarsViewSourceNotifier.Create(AView: TLMDVariablesView);
begin
  inherited Create;
  FView := AView;
end;

procedure TVarsViewSourceNotifier.LogMessage(const AMsg: TLMDString;
  AKind: TLMDDebugMsgKind);
begin
  // Do nothing.
end;

procedure TVarsViewSourceNotifier.StateChanged(
  AChange: TLMDDbgSourceChange);
begin
  FView.SourceStateChanged;
end;

{ TLMDCallStackView }

procedure TLMDCallStackView.AdjustColumns;
var
  w:     Integer;
  delta: Integer;
  r:     TRect;
begin
  if HandleAllocated and not FAdjusting and (Columns.Count > 0) then
  begin
    FAdjusting := True;

    r := ClientRect;
    AdjustClientRect(r);

    delta := Width - (r.Right - r.Left);
    w     := AWholeWidth - delta;
    if w < 32 then
      w := 32;

    Columns[0].Width := w;
    FAdjusting       := False;
  end;
end;

constructor TLMDCallStackView.Create(AOwner: TComponent);
begin
  inherited;
  FSourceNotifier    := TCallStackViewSourceNotifier.Create(Self);
  FSourceIndexUpdate := iuOnDblClick;
  FItemImageIndex    := -1;
  FTopImageIndex     := -1;
  FPrevSelected      := -1;
  ViewStyle          := vsReport;
  OwnerDraw          := True;
  OwnerData          := True;
  ShowColumnHeaders  := False;
  RowSelect          := True;
  ReadOnly           := True;
  SmallImages        := DefDebugImages;
  Columns.Add;
end;

procedure TLMDCallStackView.CreateHandle;
begin
  inherited;
  AdjustColumns(Width);
  FPrevSelected := -1;
end;

function TLMDCallStackView.CustomDraw(const ARect: TRect;
  Stage: TCustomDrawStage): Boolean;
var
  lastitm: Integer;
  r:       TRect;
  i:       Integer;
  dcidx:   Integer;
begin
  Result := True;

  if Stage = cdPrePaint then
  begin
    dcidx := SaveDC(Canvas.Handle);
    try
      if Items.Count > 0 then
      begin
        lastitm := TopItem.Index + VisibleRowCount;
        if lastitm > Items.Count - 1 then
          lastitm := Items.Count - 1;

        for i := TopItem.Index to lastitm do
        begin
          r := Items[i].DisplayRect(drBounds);
          ExcludeClipRect(Canvas.Handle, r.Left, r.Top, r.Right, r.Bottom);
        end;
      end;

      Canvas.Brush.Color := GetThemedBackColor;
      Canvas.FillRect(Rect(0, 0, Width, Height)); // ClientRect not always
                                                  // correct here.

      if Items.Count = 0 then
      begin
        Canvas.Refresh;
        SetTextColor(Canvas.Handle, ColorToRGB(GetThemedTextColor(False)));
        Canvas.TextOut(ClientRect.Left + 8, ClientRect.Top + 1,
                       SLMDProcessNotAccessible);
      end;

    finally
      RestoreDC(Canvas.Handle, dcidx);
    end;
  end;
end;

function TLMDCallStackView.CustomDrawItem(Item: TListItem;
  State: TCustomDrawState; Stage: TCustomDrawStage): Boolean;
var
  r:    TRect;
  b:    TBitmap;
  bufr: TRect;
begin
  if Stage = cdPrePaint then
  begin
    if Item.Selected then          // TListView bug.
      Include(State, cdsSelected); //

    r := Item.DisplayRect(drBounds);

    { Get buffer bitmap }

    b      := GetBufferBitmap(r.Right - r.Left, r.Bottom - r.Top + 1);
    bufr   := r;
    OffsetRect(bufr, -r.Left, -r.Top);

    DoDrawItem(Item.Index, State, b.Canvas, bufr);
    Canvas.CopyRect(r, b.Canvas, bufr);
  end;

  Result := False;
end;

procedure TLMDCallStackView.DblClick;
var
  p:    TPoint;
  item: TListItem;
begin
  if FSourceIndexUpdate = iuOnDblClick then
  begin
    GetCursorPos(p);
    MapWindowPoints(0, Handle, p, 1);

    item := GetItemAt(p.X, p.Y);
    if (item <> nil) and (FSource <> nil) then
      FSource.StackFrameIndex := item.Index;
  end;

  inherited;
end;

procedure TLMDCallStackView.Delete(Item: TListItem);
begin
  if (Item <> nil) and (FPrevSelected = Item.Index) then
    FPrevSelected := -1;
  inherited;
end;

destructor TLMDCallStackView.Destroy;
begin
  Destroying;
  Source := nil;
  SmallImages := nil;
  FSourceNotifier.Free;
  FItemBuffer.Free;
  inherited;
end;

procedure TLMDCallStackView.DoDrawItem(AIndex: Integer;
  State: TCustomDrawState; ACanvas: TCanvas; const ARect: TRect);
var
  r:      TRect;
  bkclr:  TColor;
  img:    Integer;
  imgs:   TCustomImageList;
  frm:    TLMDStackFrame;
  fntclr: TColor;
begin
  r   := ARect;
  frm := FSource.FDebugger.StackFrames[AIndex];

  { Fill background }

  if cdsSelected in State then
  begin
    if cdsFocused in State then
    begin
      bkclr  := clHighlight;
      fntclr := clHighlightText;
    end
    else
    begin
      bkclr  := LMDBlend(GetThemedBackColor, GetThemedTextColor(True), 10);
      fntclr := GetThemedTextColor(True);
    end;
  end
  else
  begin
    bkclr  := GetThemedBackColor;
    fntclr := GetThemedTextColor(True);
  end;

  ACanvas.Font.Color  := fntclr;
  ACanvas.Brush.Color := bkclr;
  ACanvas.FillRect(r);

  { Draw image }

  img  := DoGetImageIndex(frm);
  imgs := inherited SmallImages;

  if (imgs <> nil) and (img >= 0) and (img < imgs.Count) then
    imgs.Draw(ACanvas, r.Left + 2, (r.Top + r.Bottom - imgs.Height) div 2,
              img);

  if imgs <> nil then
    Inc(r.Left, imgs.Width + 4);

  { Draw caption }

  ACanvas.Refresh;
  DrawTextWithElipsis(ACanvas, DoGetCaption(frm), r);

  { Draw focus rect }

  if (cdsSelected in State) and (cdsFocused in State) then
    DrawFocusRect(ACanvas.Handle, ARect);
end;

function TLMDCallStackView.DoGetCaption(
  AFrame: TLMDStackFrame): TLMDString;
begin
  Result := AFrame.ScriptControl.DebugName;
  if Result <> '' then
    Result := Result + ': ';
  Result := Result + AFrame.LongDescription;

  if Assigned(FOnGetCaption) then
    FOnGetCaption(Self, AFrame, Result);
end;

function TLMDCallStackView.DoGetImageIndex(
  AFrame: TLMDStackFrame): TImageIndex;
var
  imgs:   TCustomImageList;
  frmidx: Integer;
begin
  frmidx := AFrame.Index;
  Result := Ord(frmidx > 0); // LMD_CALLSTACKTOP or LMD_CALLSTACKNORMAL.

  imgs := GetImages;         // Will be nil, if default
                             // images are used.
  if imgs <> nil then
  begin
    Result := ItemImageIndex;
    if (frmidx = 0) and (TopImageIndex <> -1) then
      Result := TopImageIndex;

    if Assigned(FOnGetImageIndex) then
      FOnGetImageIndex(Self, AFrame, Result);
  end;
end;

function TLMDCallStackView.GetBufferBitmap(AWidth,
  AHeight: Integer): TBitmap;
begin
  if FItemBuffer = nil then
  begin
    FItemBuffer        := TBitmap.Create;
    FItemBuffer.Handle := CreateCompatibleBitmap(Canvas.Handle, AWidth,
                                                 AHeight);
  end
  else
  begin
    FItemBuffer.Width  := AWidth;
    FItemBuffer.Height := AHeight;
  end;

  FItemBuffer.Canvas.Font := Font;
  Result                  := FItemBuffer;
end;

function TLMDCallStackView.GetImages: TCustomImageList;
begin
  if SmallImages = DefDebugImages then
    Result := nil
  else
    Result := SmallImages;
end;

function TLMDCallStackView.IsCustomDrawn(Target: TCustomDrawTarget;
  Stage: TCustomDrawStage): Boolean;
begin
  Result := (Target in [dtControl, dtItem, dtSubItem]);
end;

procedure TLMDCallStackView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FSource) then
    Source := nil;
end;

procedure TLMDCallStackView.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if HandleAllocated and (Columns.Count > 0) and (AWidth < Width) then
    AdjustColumns(AWidth);
  inherited;
  if HandleAllocated and (Columns.Count > 0) and (AWidth >= Width) then
    AdjustColumns(AWidth);
end;

procedure TLMDCallStackView.SetImages(const Value: TCustomImageList);
begin
  if GetImages <> Value then
  begin
    Items.BeginUpdate;
    try
      if Value = nil then
        SmallImages := DefDebugImages
      else
        SmallImages := Value;

      Invalidate;
    finally
      Items.EndUpdate;
    end;
  end;
end;

procedure TLMDCallStackView.SetItemImageIndex(const Value: TImageIndex);
begin
  if FItemImageIndex <> Value then
  begin
    FItemImageIndex := Value;
    Invalidate;
  end;
end;

procedure TLMDCallStackView.Change(Item: TListItem; Change: Integer);
begin
  if (FSourceIndexUpdate = iuOnClick) and (Item <> nil) and
     (FPrevSelected <> Item.Index) and Item.Selected and
     (FSource <> nil) then
  begin
    FPrevSelected           := Item.Index;
    FSource.StackFrameIndex := Item.Index;
  end;

  inherited;
end;

procedure TLMDCallStackView.SetSource(const Value: TLMDDebuggerSource);
begin
  if FSource <> Value then
  begin
    if FSource <> nil then
    begin
      FSource.RemoveNotifier(FSourceNotifier);
      FSource.RemoveFreeNotification(Self);
    end;

    FSource := Value;

    if FSource <> nil then
    begin
      FSource.AddNotifier(FSourceNotifier);
      FSource.FreeNotification(Self);
    end;

    SourceStateChanged;
  end;
end;

procedure TLMDCallStackView.SetTopImageIndex(const Value: TImageIndex);
begin
  if FTopImageIndex <> Value then
  begin
    FTopImageIndex := Value;
    Invalidate;
  end;
end;

procedure TLMDCallStackView.SourceStateChanged;
begin
  if not (csDesigning in ComponentState) then
    UpdateView;
end;

procedure TLMDCallStackView.UpdateView;
var
  dbgr: TLMDScriptDebugger;
  fidx: Integer;
begin
  if HandleAllocated then
  begin
    Items.BeginUpdate;
    try
      if (FSource <> nil) and (FSource.FDebugger <> nil) and
         (FSource.FDebugger.BreakKind <> bkNone) then
      begin
        dbgr        := FSource.FDebugger;
        Items.Count := dbgr.StackFrameCount;

        fidx          := FSource.StackFrameIndex;
        FPrevSelected := fidx;
        if (fidx >= 0) and (fidx < Items.Count) then
          ItemIndex := fidx;

        Invalidate;
      end
      else
        Items.Clear;
    finally
      Items.EndUpdate;
    end;
  end;
end;

function TLMDCallStackView.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_IDE;
end;

function TLMDCallStackView.GetSelected: TLMDStackFrame;
var
  item: TListItem;
begin
  Result := nil;
  item   := inherited Selected;
  
  if (item <> nil) and (FSource <> nil) and (FSource.FDebugger <> nil) and
     (item.Index < FSource.FDebugger.StackFrameCount) then
    Result := FSource.FDebugger.StackFrames[item.Index];
end;

function TLMDCallStackView.GetThemedBackColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleColor(scListView)
  else
  {$ENDIF}
    Result := Color;
end;

function TLMDCallStackView.GetThemedTextColor(AEnabled: Boolean): TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
  begin
    if AEnabled then
      Result := StyleServices.GetStyleFontColor(sfListItemTextNormal)
    else
      Result := LMDBlend(StyleServices.GetStyleFontColor(sfListItemTextNormal),
                         StyleServices.GetStyleColor(scListView), 50);
  end
  else
  {$ENDIF}
  begin
    if AEnabled then
      Result := Font.Color
    else
      Result := clBtnFace;
  end;
end;

procedure TLMDCallStackView.SetSelected(const Value: TLMDStackFrame);
begin
  inherited Selected := Items[Value.Index];
end;

{ TCallStackViewSourceNotifier }

procedure TCallStackViewSourceNotifier.BreakpointsChanged;
begin
  // Do nothing.
end;

constructor TCallStackViewSourceNotifier.Create(AView: TLMDCallStackView);
begin
  inherited Create;
  FView := AView;
end;

procedure TCallStackViewSourceNotifier.LogMessage(const AMsg: TLMDString;
  AKind: TLMDDebugMsgKind);
begin
  // Do nothing.
end;

procedure TCallStackViewSourceNotifier.StateChanged(
  AChange: TLMDDbgSourceChange);
begin
  FView.SourceStateChanged;
end;

{ TLMDCallStackComboBox }

procedure TLMDCallStackComboBox.CloseUp;
begin
  if not FIsEmpty and (FSource <> nil) then
    FSource.StackFrameIndex := inherited ItemIndex;
  inherited;
end;

constructor TLMDCallStackComboBox.Create(AOwner: TComponent);
begin
  inherited;
  FSourceNotifier := TCallStackComboSourceNotifier.Create(Self);
  FIsEmpty        := True;
  Style           := csDropDownList;
end;

procedure TLMDCallStackComboBox.CreateHandle;
begin
  inherited;
  UpdateView;
end;

destructor TLMDCallStackComboBox.Destroy;
begin
  Destroying;
  Source := nil;
  FSourceNotifier.Free;
  inherited;
end;

function TLMDCallStackComboBox.DoGetCaption(
  AFrame: TLMDStackFrame): TLMDString;
begin
  Result := AFrame.ScriptControl.DebugName;
  if Result <> '' then
    Result := Result + ': ';
  Result := Result + AFrame.LongDescription;

  if Assigned(FOnGetCaption) then
    FOnGetCaption(Self, AFrame, Result);
end;

function TLMDCallStackComboBox.GetItemIndex: Integer;
begin
  if FIsEmpty then
    Result := -1
  else
    Result := inherited ItemIndex;
end;

function TLMDCallStackComboBox.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_IDE;
end;

procedure TLMDCallStackComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FSource) then
    Source := nil;
end;

procedure TLMDCallStackComboBox.SetItemIndex(const Value: Integer);
begin
  if not FIsEmpty then
    inherited ItemIndex := Value;
end;

procedure TLMDCallStackComboBox.SetSource(const Value: TLMDDebuggerSource);
begin
  if FSource <> Value then
  begin
    if FSource <> nil then
    begin
      FSource.RemoveNotifier(FSourceNotifier);
      FSource.RemoveFreeNotification(Self);
    end;

    FSource := Value;

    if FSource <> nil then
    begin
      FSource.AddNotifier(FSourceNotifier);
      FSource.FreeNotification(Self);
    end;

    SourceStateChanged;
  end;
end;

procedure TLMDCallStackComboBox.SourceStateChanged;
begin
  if not (csDesigning in ComponentState) then
    UpdateView;
end;

procedure TLMDCallStackComboBox.UpdateView;
var
  i:    Integer;
  frm:  TLMDStackFrame;
  dbgr: TLMDScriptDebugger;
begin
  if HandleAllocated then
  begin
    Items.BeginUpdate;
    try
      Items.Clear;

      if (FSource <> nil) and (FSource.FDebugger <> nil) and
         (FSource.FDebugger.BreakKind <> bkNone) then
      begin
        FIsEmpty := False;
        dbgr     := FSource.FDebugger;

        for i := 0 to dbgr.StackFrameCount - 1 do
        begin
          frm := dbgr.StackFrames[i];

          Items.Add(DoGetCaption(frm));
          inherited ItemIndex := FSource.StackFrameIndex;
        end;
      end
      else
      begin
        FIsEmpty := True;

        Items.Add(SLMDProcessNotAccessible);
        inherited ItemIndex := 0;
      end;
    finally
      Items.EndUpdate;
    end;
  end;
end;

{ TCallStackComboSourceNotifier }

procedure TCallStackComboSourceNotifier.BreakpointsChanged;
begin
  // Do nothing.
end;

constructor TCallStackComboSourceNotifier.Create(
  AComboBox: TLMDCallStackComboBox);
begin
  inherited Create;
  FComboBox := AComboBox;
end;

procedure TCallStackComboSourceNotifier.LogMessage(const AMsg: TLMDString;
  AKind: TLMDDebugMsgKind);
begin
  // Do nothing.
end;

procedure TCallStackComboSourceNotifier.StateChanged(
  AChange: TLMDDbgSourceChange);
begin
  FComboBox.SourceStateChanged;
end;

{ TLMDEventLogView }

procedure TLMDEventLogView.AdjustColWidth;
var
  clnw, tw, i: Integer;
begin
  if HandleAllocated then
  begin
    { Update max message width }

    for i := FMsgMaxWidthIndex + 1 to FMessages.Count - 1 do
    begin
      tw := Canvas.TextWidth(FMessages[i]);
      if tw > FMsgMaxWidth then
        FMsgMaxWidth := tw;
    end;
    FMsgMaxWidthIndex := FMessages.Count - 1;

    { Calc column width }

    clnw := ClientWidth;

    if clnw < 32 then
      clnw := 32;
    if clnw < FMsgMaxWidth + 8 then
      clnw := FMsgMaxWidth + 8;

    if DefaultColWidth <> clnw then // For sure.
      DefaultColWidth := clnw;
  end;
end;

procedure TLMDEventLogView.AdjustRowHeight;
var
  h: Integer;
begin
  if HandleAllocated then
  begin
    Canvas.Font := Font;
    h           := Canvas.TextHeight('Wg') + 2;

    if DefaultRowHeight <> h then // For sure
      DefaultRowHeight := h;
  end;
end;

procedure TLMDEventLogView.Clear;
begin
  FMessages.Clear;

  FMsgMaxWidth      := 0;
  FMsgMaxWidthIndex := -1;
  UpdateView(True);
end;

procedure TLMDEventLogView.CMFontChanged(var Message: TMessage);
begin
  inherited;

  FMsgMaxWidth      := 0;
  FMsgMaxWidthIndex := -1;
  UpdateView(True);
end;

constructor TLMDEventLogView.Create(AOwner: TComponent);
begin
  inherited;
  FShowNewMessage     := True;
  FAsyncUpdate        := True;
  FMaxMessageCount    := -1;
  FMessages           := TStringList.Create;
  FMsgMaxWidthIndex   := -1;
  FSourceNotifier     := TEventLogSourceNotifier.Create(Self);
  FSourceMessageKinds := LMDAllMsgKinds;
  FUseMsgColors       := True;
  DefaultDrawing      := False;
  GridLineWidth       := 0;
  FixedCols           := 0;
  FixedRows           := 0;
  ColCount            := 1;
  RowCount            := 0;
  InitColors;
end;

procedure TLMDEventLogView.CreateHandle;
begin
  inherited;
  UpdateView(True, FShowNewMessage);
end;

destructor TLMDEventLogView.Destroy;
begin
  Destroying;
  Source := nil;
  FMessages.Free;
  FSourceNotifier.Free;

  inherited;
end;

procedure TLMDEventLogView.DMAsyncUpdate(var Message: TMessage);
begin
  if lvsAsyncUpdateSent in FState then
  begin
    Exclude(FState, lvsAsyncUpdateSent);
    UpdateView(True, FShowNewMessage);
  end;
end;

procedure TLMDEventLogView.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
var
  clr, bk, tmp: TColor;
  s:            TLMDString;
  knd:          TLMDDebugMsgKind;
begin
  clr := FMsgColors[dmDebuggerOutput];
  bk  := FMsgBkColors[dmDebuggerOutput];
  s   := '';

  if ARow < FMessages.Count then
  begin
    GetMsg(ARow, s, knd);
    clr := FMsgColors[knd];
    bk  := FMsgBkColors[knd];
  end;

  if gdSelected in AState then
  begin
    tmp := clr;
    clr := bk;
    bk  := tmp;
  end;

  if not FUseMsgColors then
  begin
    if gdSelected in AState then
    begin
      clr := clHighlightText;
      bk  := clHighlight;
    end
    else
    begin
      clr := GetThemedTextColor;
      bk  := GetThemedBackColor;
    end;
  end;

  Canvas.Font.Color  := clr;
  Canvas.Brush.Color := bk;

  LMDTextRect(Canvas, ARect, ARect.Left + 3, ARect.Top + 1, s);

  if gdFocused in AState then
    DrawFocusRect(Canvas.Handle, ARect);
end;

procedure TLMDEventLogView.GetMsg(AIndex: Integer; out AMsg: TLMDString;
  out AKind: TLMDDebugMsgKind);
begin
  Inc(AIndex, FMsgStart);
  if AIndex >= FMessages.Count then
    Dec(AIndex, FMessages.Count);

  AMsg  := FMessages[AIndex];
  AKind := TLMDDebugMsgKind(FMessages.Objects[AIndex]);
end;

function TLMDEventLogView.GetMsgBkColor(const Index: Integer): TColor;
begin
  Result := FMsgBkColors[TLMDDebugMsgKind(Index)];
end;

function TLMDEventLogView.GetMsgColor(const Index: Integer): TColor;
begin
  Result := FMsgColors[TLMDDebugMsgKind(Index)];
end;

function TLMDEventLogView.GetThemedBackColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleColor(scGrid)
  else
  {$ENDIF}
    Result := clWindow;
end;

function TLMDEventLogView.GetThemedTextColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleFontColor(sfGridItemNormal)
  else
  {$ENDIF}
    Result := clWindowText;
end;

procedure TLMDEventLogView.InitColors;
var
  i: TLMDDebugMsgKind;
begin
  for i := Low(TLMDDebugMsgKind) to High(TLMDDebugMsgKind) do
  begin
    FMsgColors[i]   := DefaultMsgColors[i];
    FMsgBkColors[i] := DefaultMsgBkColors[i];
  end;
end;

function TLMDEventLogView.IsMsgBkColorStred(
  const Index: Integer): Boolean;
begin
  Result := (FMsgBkColors[TLMDDebugMsgKind(Index)] <>
             DefaultMsgBkColors[TLMDDebugMsgKind(Index)]);
end;

function TLMDEventLogView.IsMsgColorStred(
  const Index: Integer): Boolean;
begin
  Result := (FMsgColors[TLMDDebugMsgKind(Index)] <>
             DefaultMsgColors[TLMDDebugMsgKind(Index)]);
end;

procedure TLMDEventLogView.LogMessage(const AMsg: TLMDString);
begin
  LogMessage(AMsg, dmDebuggerOutput);
end;

procedure TLMDEventLogView.SourceLogMsg(const AMsg: TLMDString;
  AKind: TLMDDebugMsgKind);
begin
  if AKind in FSourceMessageKinds then
    LogMessage(AMsg, AKind);
end;

procedure TLMDEventLogView.LogMessage(const AMsg: TLMDString;
  AKind: TLMDDebugMsgKind);
begin
  if (FMaxMessageCount < 0) or // -1
     (FMessages.Count < FMaxMessageCount) then
  begin
    FMsgStart := 0;
    FMessages.AddObject(AMsg, TObject(AKind));
  end
  else if FMaxMessageCount > 0 then
  begin
    FMessages[FMsgStart]         := AMsg;
    FMessages.Objects[FMsgStart] := TObject(AKind);

    Inc(FMsgStart);
    if FMsgStart >= FMessages.Count then
      FMsgStart := 0;
  end;

  FMsgMaxWidth      := 0;
  FMsgMaxWidthIndex := -1;
  UpdateView(False, FShowNewMessage);
end;

procedure TLMDEventLogView.NormalizeMessages;
var
  msgs: TStringList;
  i:    Integer;
begin
  if FMsgStart > 0 then
  begin
    msgs := TStringList.Create;
    try
      for i := FMsgStart to FMessages.Count - 1 do
        msgs.Add(FMessages[i]);
      for i := 0 to FMsgStart - 1 do
        msgs.Add(FMessages[i]);

      FMessages.Free;
      FMessages := msgs;
      FMsgStart := 0;
    except
      msgs.Free;
      raise;
    end;
  end;
end;

procedure TLMDEventLogView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FSource) then
    Source := nil;
end;

procedure TLMDEventLogView.SetMaxMessageCount(const Value: Integer);
begin
  if FMaxMessageCount <> Value then
  begin
    FMaxMessageCount := Value;

    if (FMaxMessageCount >= 0) and (FMessages.Count > FMaxMessageCount) then
    begin
      NormalizeMessages;

      while FMessages.Count > FMaxMessageCount do
        FMessages.Delete(FMessages.Count - 1);
    end;
  end;
end;

procedure TLMDEventLogView.SetMsgBkColor(const Index: Integer;
  const Value: TColor);
begin
  if FMsgBkColors[TLMDDebugMsgKind(Index)] <> Value then
  begin
    FMsgBkColors[TLMDDebugMsgKind(Index)] := Value;
    UpdateView(True);
  end;
end;

procedure TLMDEventLogView.SetMsgColor(const Index: Integer;
  const Value: TColor);
begin
  if FMsgColors[TLMDDebugMsgKind(Index)] <> Value then
  begin
    FMsgColors[TLMDDebugMsgKind(Index)] := Value;
    UpdateView(True);
  end;
end;

procedure TLMDEventLogView.SetSource(const Value: TLMDDebuggerSource);
begin
  if FSource <> Value then
  begin
    if FSource <> nil then
    begin
      FSource.RemoveNotifier(FSourceNotifier);
      FSource.RemoveFreeNotification(Self);
    end;

    FSource := Value;

    if FSource <> nil then
    begin
      FSource.AddNotifier(FSourceNotifier);
      FSource.FreeNotification(Self);
    end;
  end;
end;

procedure TLMDEventLogView.SetUseMsgColors(const Value: Boolean);
begin
  if FUseMsgColors <> Value then
  begin
    FUseMsgColors := Value;
    UpdateView(True);
  end;
end;

procedure TLMDEventLogView.UpdateView(AForceSync, ASelectLastMsg: Boolean);
begin
  if HandleAllocated then
  begin
    { Handle async update mode }

    if not AForceSync and FAsyncUpdate then
    begin
      if not (lvsAsyncUpdateSent in FState) then
      begin
        PostMessage(Handle, DM_ASYNCUPDATE, 0, 0);
        Include(FState, lvsAsyncUpdateSent);
      end;
      Exit;
    end;

    { Do update }

    AdjustRowHeight;
    AdjustColWidth;

    RowCount := FMessages.Count;

    if ASelectLastMsg and (FMessages.Count > 0) then
      Row := FMessages.Count - 1;
    Invalidate;
  end;
end;

procedure TLMDEventLogView.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  {$IFDEF LMDCOMP7}
  if csParentBackground in ControlStyle then // Remove some flickers.
    inherited;
  {$ENDIF}
end;

procedure TLMDEventLogView.WMSize(var Message: TWMSize);
begin
  AdjustColWidth;
  inherited;
end;

function TLMDEventLogView.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_IDE;
end;

{ TEventLogSourceNotifier }

procedure TEventLogSourceNotifier.BreakpointsChanged;
begin
  // Do nothing.
end;

constructor TEventLogSourceNotifier.Create(AView: TLMDEventLogView);
begin
  inherited Create;
  FView := AView;
end;

procedure TEventLogSourceNotifier.LogMessage(const AMsg: TLMDString;
  AKind: TLMDDebugMsgKind);
begin
  FView.SourceLogMsg(AMsg, AKind);
end;

procedure TEventLogSourceNotifier.StateChanged(AChange: TLMDDbgSourceChange);
begin
  // Do nothing.
end;

{ TLMDBreakpointsView }

function TLMDBreakpointsView.BpByItem(AItem: TListItem): TLMDBreakpoint;
begin
  Result := nil;

  if (AItem <> nil) and (FSource <> nil) and (FSource.FDebugger <> nil) and
     (AItem.Index >= 0) and (AItem.Index < FSource.FDebugger.BreakpointCount) then
    Result := FSource.FDebugger.Breakpoints[AItem.Index];
end;

constructor TLMDBreakpointsView.Create(AOwner: TComponent);
begin
  inherited;

  FSourceNotifier     := TBreakpointsSourceNotifier.Create(Self);
  FNormalImageIndex   := -1;
  FDisabledImageIndex := -1;
  FInvalidImageIndex  := -1;
  ViewStyle           := vsReport;
  OwnerDraw           := True;
  OwnerData           := True;
  ColumnClick         := False;
  RowSelect           := True;
  ReadOnly            := True;
  SmallImages         := DefDebugImages;
  InitColumns;
end;

procedure TLMDBreakpointsView.CreateHandle;
begin
  inherited;
  UpdateView;
end;

procedure TLMDBreakpointsView.CreateWnd;
begin
  inherited;
  if Columns.Count = 0 then
    InitColumns;
end;

function TLMDBreakpointsView.CustomDraw(const ARect: TRect;
  Stage: TCustomDrawStage): Boolean;
var
  lastitm: Integer;
  r:       TRect;
  i:       Integer;
  dcidx:   Integer;
begin
  Result := True;

  if Stage = cdPrePaint then
  begin
    dcidx := SaveDC(Canvas.Handle);
    try
      if Items.Count > 0 then
      begin
        lastitm := TopItem.Index + VisibleRowCount;
        if lastitm > Items.Count - 1 then
          lastitm := Items.Count - 1;

        for i := TopItem.Index to lastitm do
        begin
          r := Items[i].DisplayRect(drBounds);
          ExcludeClipRect(Canvas.Handle, r.Left, r.Top, r.Right, r.Bottom);
        end;
      end;

      Canvas.Brush.Color := GetThemedBackColor;
      Canvas.FillRect(Rect(0, 0, Width, Height)); // ClientRect not always
                                                  // correct here.
      if Items.Count = 0 then
      begin
        SetTextColor(Canvas.Handle, ColorToRGB(GetThemedTextColor(False)));
        Canvas.TextOut(ClientRect.Left + 8, ClientRect.Top + 1,
                       SLMDProcessNotAccessible);
      end;
    finally
      RestoreDC(Canvas.Handle, dcidx);
    end;
  end;
end;

function TLMDBreakpointsView.CustomDrawItem(Item: TListItem;
  State: TCustomDrawState; Stage: TCustomDrawStage): Boolean;
var
  bp:   TLMDBreakpoint;
  r:    array[0..5] of TRect;
  s:    array[0..5] of TLMDString;
  i:    Integer;
  img:  TImageIndex;
  imgs: TCustomImageList;
  btn: TRect;
begin
  if Stage = cdPrePaint then
  begin
    if Item.Selected then          // TListView bug.
      Include(State, cdsSelected); //

    bp := FSource.FDebugger.Breakpoints[Item.Index];
    DoGetBreakpointParams(bp, s[0], s[1], s[2], s[3], s[4], s[5]);

    for i := 0 to 5 do
      ListView_GetSubItemRect(Handle, Item.Index, i, LVIR_BOUNDS, @r[i]);
    r[0].Right := r[1].Left;

    if cdsSelected in State then
    begin
      if cdsFocused in State then
      begin
        Canvas.Brush.Color := clHighlight;
        Canvas.Font.Color  := clHighlightText;
      end
      else
      begin
        Canvas.Brush.Color := LMDBlend(GetThemedBackColor,
                                       GetThemedTextColor(True), 10);
        Canvas.Font.Color  := GetThemedTextColor(bp.Enabled);
      end;
    end
    else
    begin
      Canvas.Brush.Color := GetThemedBackColor;
      Canvas.Font.Color  := GetThemedTextColor(bp.Enabled);
    end;

    { Draw first column }

    // Checkbox

    Canvas.FillRect(Rect(r[0].Left, r[0].Top, r[0].Left +
                    CheckBoxSize + 4, r[0].Bottom));

    Inc(r[0].Left, 2);
    DrawCheckbox(Canvas, bp.Enabled, r[0], @btn);
    SetCheckBtn(Item.Index, btn);
    Inc(r[0].Left, CheckBoxSize + 2);

    // Image

    img  := DoGetImageIndex(bp);
    imgs := inherited SmallImages;

    if (imgs <> nil) and (img >= 0) and (img < imgs.Count) then
    begin
      Canvas.FillRect(Rect(r[0].Left, r[0].Top, r[0].Left +
                      imgs.Width + 4, r[0].Bottom));
      imgs.Draw(Canvas, r[0].Left + 2, (r[0].Top +
                r[0].Bottom - imgs.Height) div 2, img);
      Inc(r[0].Left, imgs.Width + 4);
    end;

    // Text

    Canvas.Refresh;
    LMDTextRect(Canvas, r[0], r[0].Left + 2, r[0].Top + 1, s[0]);

    { Draw subitems }

    Canvas.Refresh;
    for i := 1 to 5 do
      LMDTextRect(Canvas, r[i], r[i].Left + 8, r[i].Top + 1, s[i]);
  end;

  Result := False;
end;

destructor TLMDBreakpointsView.Destroy;
begin
  Destroying;
  Source      := nil;
  SmallImages := nil;

  inherited;
end;

procedure TLMDBreakpointsView.DoGetBreakpointParams(BP: TLMDBreakpoint;
  out ASource, ALine, ACondition, AAction, APassCount, AGroup: TLMDString);

  function _AddComma(const S: TLMDString): TLMDString;
  begin
    Result := S;
    if Result <> '' then
      Result := Result + ', ';
  end;

begin
  ASource    := BP.Module.Name;
  ALine      := IntToStr(BP.Line);
  ACondition := BP.Condition;
  AGroup     := BP.Group;
  APassCount := IntToStr(BP.PassCount);
  AAction    := '';

  if BP.PassCount > 0 then
    APassCount := Format('%d of %d', [BP.CurrentPassCount, BP.PassCount]);

  if BP.Action.Break then
    AAction := _AddComma(AAction) + 'Break';
  if BP.Action.LogMessage <> '' then
    AAction := _AddComma(AAction) + Format('Log message ''%s''',
                                           [BP.Action.LogMessage]);
  if BP.Action.EvalExpression <> '' then
    AAction := _AddComma(AAction) + Format('Eval expression ''%s''',
                                           [BP.Action.EvalExpression]);
  if BP.Action.EnableGroup <> '' then
    AAction := _AddComma(AAction) + Format('Enable group ''%s''',
                                           [BP.Action.EnableGroup]);
  if BP.Action.DisableGroup <> '' then
    AAction := _AddComma(AAction) + Format('Disable group ''%s''',
                                           [BP.Action.DisableGroup]);
  if BP.Action.LogStackFrames > 0 then
  begin
    if BP.Action.LogStackFrames = LMDAllStackFrames then
      AAction := _AddComma(AAction) + 'Log all stack frames'
    else
      AAction := _AddComma(AAction) + Format('Log %d stack frame(s)',
                                             [BP.Action.LogStackFrames]);
  end;
end;

function TLMDBreakpointsView.DoGetImageIndex(BP: TLMDBreakpoint): TImageIndex;
var
  imgs: TCustomImageList;
begin
  Result := 2 + Ord(bp.State = bsInvalid); // LMD_BPNORMAL or LMD_BPDISABLED.

  imgs := GetImages;  // Will be nil, if default
                      // images are used.
  if imgs <> nil then
  begin
    Result := FNormalImageIndex;
    if not BP.Enabled and (FDisabledImageIndex <> -1) then
      Result := FDisabledImageIndex;
    if (bp.State = bsInvalid) and (FInvalidImageIndex <> -1) then
      Result := FInvalidImageIndex;

    if Assigned(FOnGetImageIndex) then
      FOnGetImageIndex(Self, BP, Result);
  end;
end;

function TLMDBreakpointsView.GetImages: TCustomImageList;
begin
  if SmallImages = DefDebugImages then
    Result := nil
  else
    Result := SmallImages;
end;

function TLMDBreakpointsView.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_IDE;
end;

function TLMDBreakpointsView.GetSelected: TLMDBreakpoint;
var
  item: TListItem;
begin
  Result := nil;
  item   := inherited Selected;

  if item <> nil then
    Result := BpByItem(item);
end;

function TLMDBreakpointsView.GetThemedBackColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleColor(scListView)
  else
  {$ENDIF}
    Result := Color;
end;

function TLMDBreakpointsView.GetThemedTextColor(
  ABreakpointEnabled: Boolean): TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
  begin
    if ABreakpointEnabled then
      Result := StyleServices.GetStyleFontColor(sfListItemTextNormal)
    else
      Result := LMDBlend(StyleServices.GetStyleFontColor(sfListItemTextNormal),
                         StyleServices.GetStyleColor(scListView), 50);
  end
  else
  {$ENDIF}
  begin
    if ABreakpointEnabled then
      Result := Font.Color
    else
      Result := clBtnShadow;
  end;
end;

procedure TLMDBreakpointsView.InitColumns;
begin
  with Columns.Add do
  begin
    Caption := 'Source';
    Width   := 200;
  end;
  with Columns.Add do
  begin
    Caption := 'Line';
    Width   := 75;
  end;
  with Columns.Add do
  begin
    Caption := 'Condition';
    Width   := 200;
  end;
  with Columns.Add do
  begin
    Caption := 'Action';
    Width   := 200;
  end;
  with Columns.Add do
  begin
    Caption := 'Pass Count';
    Width   := 75;
  end;
  with Columns.Add do
  begin
    Caption := 'Group';
    Width   := 75;
  end;
end;

function TLMDBreakpointsView.IsCustomDrawn(Target: TCustomDrawTarget;
  Stage: TCustomDrawStage): Boolean;
begin
  Result := (Target in [dtControl, dtItem, dtSubItem]);
end;

function TLMDBreakpointsView.IsOnCheckBtn(const P: TPoint): Boolean;
var
  i: Integer;
begin
  for i := 0 to High(FCheckBtns) do
    if PtInRect(FCheckBtns[i], P) then
    begin
      Result := True;
      Exit;
    end;

  Result := False;
end;

procedure TLMDBreakpointsView.KeyDown(var Key: Word; Shift: TShiftState);
var
  bp: TLMDBreakpoint;
begin
  inherited;      // Call inherited first to allow the user to process key
                  // differently or suppress standard action.
  case Key of
    VK_SPACE:
    begin
      bp := Selected;
      if bp <> nil then
      begin
        bp.Enabled := not bp.Enabled;
        Key        := 0;
      end;
    end;
    VK_DELETE:
    begin
      bp := Selected;
      if bp <> nil then
      begin
        bp.Delete;
        Key := 0;
      end;
    end;
  end;
end;

procedure TLMDBreakpointsView.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  item: TListItem;
  bp:   TLMDBreakpoint;
begin
  item := GetItemAt(X, Y);
  if (item <> nil) and IsOnCheckBtn(Point(X, Y)) then
  begin
    bp := BpByItem(item);
    if bp <> nil then
      bp.Enabled := not bp.Enabled;
  end;

  inherited;
end;

procedure TLMDBreakpointsView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FSource) then
    Source := nil;
end;

procedure TLMDBreakpointsView.SetCheckBtn(AListIdx: Integer; const ABounds: TRect);
var
  idx: Integer;
begin
  idx := AListIdx - TopItem.Index;
  if idx < 0 then // For sure
    Exit;         //

  if idx > High(FCheckBtns) then
    SetLength(FCheckBtns, idx + 1);

  FCheckBtns[idx] := ABounds;
end;

procedure TLMDBreakpointsView.SetDisabledImageIndex(const Value: TImageIndex);
begin
  if FDisabledImageIndex <> Value then
  begin
    FDisabledImageIndex := Value;
    Invalidate;
  end;
end;

procedure TLMDBreakpointsView.SetImages(const Value: TCustomImageList);
begin
  if GetImages <> Value then
  begin
    Items.BeginUpdate;
    try
      if Value = nil then
        SmallImages := DefDebugImages
      else
        SmallImages := Value;

      Invalidate;
    finally
      Items.EndUpdate;
    end;
  end;
end;

procedure TLMDBreakpointsView.SetInvalidImageIndex(const Value: TImageIndex);
begin
  if FInvalidImageIndex <> Value then
  begin
    FInvalidImageIndex := Value;
    Invalidate;
  end;
end;

procedure TLMDBreakpointsView.SetNormalImageIndex(const Value: TImageIndex);
begin
  if FNormalImageIndex <> Value then
  begin
    FNormalImageIndex := Value;
    Invalidate;
  end;
end;

procedure TLMDBreakpointsView.SetSelected(const Value: TLMDBreakpoint);
var
  item: TListItem;
begin
  item := nil;
  if (Value <> nil) and (FSource <> nil) and (FSource.Debugger <> nil) and
     (Value.Debugger = FSource.Debugger) then
    item := Items[Value.Index];

  inherited Selected := item;
end;

procedure TLMDBreakpointsView.SetSource(const Value: TLMDDebuggerSource);
begin
  if FSource <> Value then
  begin
    if FSource <> nil then
    begin
      FSource.RemoveNotifier(FSourceNotifier);
      FSource.RemoveFreeNotification(Self);
    end;

    FSource := Value;

    if FSource <> nil then
    begin
      FSource.AddNotifier(FSourceNotifier);
      FSource.FreeNotification(Self);
    end;
  end;
end;

procedure TLMDBreakpointsView.SourceStateChanged;
begin
  if not (csDesigning in ComponentState) then
    UpdateView;
end;

procedure TLMDBreakpointsView.UpdateView;
var
  dbgr: TLMDScriptDebugger;
begin
  if HandleAllocated then
  begin
    Items.BeginUpdate;
    try
      if (FSource <> nil) and (FSource.FDebugger <> nil) then
      begin
        dbgr        := FSource.FDebugger;
        Items.Count := dbgr.BreakpointCount;
        Invalidate;
      end
      else
        Items.Clear;
    finally
      Items.EndUpdate;
    end;
  end;
end;

procedure TLMDBreakpointsView.WMEraseBkGnd(var Message: TWMEraseBkGnd);
begin
  Message.Result := 1;
end;

{ TBreakpointsSourceNotifier }

procedure TBreakpointsSourceNotifier.BreakpointsChanged;
begin
  FView.SourceStateChanged;
end;

constructor TBreakpointsSourceNotifier.Create(AView: TLMDBreakpointsView);
begin
  inherited Create;
  FView := AView;
end;

procedure TBreakpointsSourceNotifier.LogMessage(const AMsg: TLMDString;
  AKind: TLMDDebugMsgKind);
begin
  // Do nothing.
end;

procedure TBreakpointsSourceNotifier.StateChanged(
  AChange: TLMDDbgSourceChange);
begin
  FView.SourceStateChanged;
end;

{ TLMDWatchView }

constructor TLMDWatchView.Create(AOwner: TComponent);
begin
  inherited;
  FItems          := TLMDWatchItems.Create(Self, TLMDWatchItem);
  FSourceNotifier := TWatchViewSourceNotifier.Create(Self);
end;

destructor TLMDWatchView.Destroy;
begin
  Destroying;

  Source := nil;
  FSourceNotifier.Free;
  FItems.Free;
  inherited;
end;

procedure TLMDWatchView.DoCheckboxClicked(APath: PLMDNodePath;
  APathSize: Integer);
var
  item: TLMDWatchItem;
begin
  if APathSize = 1 then
  begin
    item         := FItems[APath[0]];
    item.Enabled := not item.Enabled;
  end;
end;

function TLMDWatchView.DoGetChildCount(APath: PLMDNodePath;
  APathSize: Integer): Integer;
var
  v: TLMDVariable;
begin
  if APathSize = 0 then
    Result := FItems.Count
  else if TryVarByPath(APath, APathSize, v) then
    Result := v.Count
  else
    Result := 0;
end;

procedure TLMDWatchView.DoGetColumnNames(var ANameCln,
  AValueCln: TLMDString);
begin
  inherited;
  ANameCln := 'Watch Name';
end;

procedure TLMDWatchView.DoGetNodeData(APath: PLMDNodePath;
  APathSize: Integer; var AData: TLMDNodeData);
var
  v:    TLMDVariable;
  item: TLMDWatchItem;
begin
  item := FItems[APath[0]];

  if APathSize = 1 then
  begin
    AData.Name         := item.FExpression;
    AData.Key          := Pointer(item.ID);
    AData.ShowCheckbox := True;
    AData.Checked      := item.FEnabled;
    AData.Enabled      := item.FEnabled;

    if not item.FEnabled then
      AData.Value := '[disabled]'
    else if item.FVars.Root <> nil then
      AData.Value := item.FVars.Root.Value
    else
      AData.Value := '[process not accessible]';
  end
  else if TryVarByPath(APath, APathSize, v) then
  begin
    AData.Name         := v.Name;
    AData.Value        := v.Value;
    AData.Key          := Pointer(v.Id);
    AData.ShowCheckbox := False;
    AData.Enabled      := True;
  end;
end;

function TLMDWatchView.DoKeyIndexOf(AParentPath: PLMDNodePath;
  AParentPathSize: Integer; AKey: Pointer): Integer;
var
  item: TLMDWatchItem;
  pntv: TLMDVariable;
begin
  if AParentPathSize = 0 then
  begin
    item := FItems.FindItemID(Integer(AKey));

    if item <> nil then
      Result := item.Index
    else
      Result := -1;
  end
  else if TryVarByPath(AParentPath, AParentPathSize, pntv) then
    Result := pntv.IndexOfId(Integer(AKey))
  else
    Result := -1;
end;

function TLMDWatchView.GetSelected: TLMDWatchItem;
var
  pth: array[0..15] of Integer;
begin
  if GetSelectedPath(@pth, 16) = 1 then
    Result := TLMDWatchItem(FItems[pth[0]])
  else
    Result := nil;
end;

procedure TLMDWatchView.ItemsChanged;
var
  i:    Integer;
  item: TLMDWatchItem;
  frm: TLMDStackFrame;
begin
  { Re-evaluate invalidated items }

  frm := nil;
  if (FSource <> nil) and (FSource.FDebugger <> nil) and
     (FSource.FDebugger.BreakKind <> bkNone) then
    frm := FSource.StackFrame;

  for i := 0 to FItems.Count - 1 do
  begin
    item := FItems[i];

    if item.FNeedUpdate then
    begin
      if (frm <> nil) and item.FEnabled then
        frm.Eval(item.FExpression, item.FVars);
      item.FNeedUpdate := False;
    end;
  end;

  { Update view }

  inherited UpdateView;
end;

procedure TLMDWatchView.KeyDown(var Key: Word; Shift: TShiftState);
var
  itm: TLMDWatchItem;
begin
  inherited;      // Call inherited first to allow the user to process key
                  // differently or suppress standard action.
  case Key of
    VK_SPACE:
    begin
      itm := Selected;
      if itm <> nil then
      begin
        itm.Enabled := not itm.Enabled;
        Key         := 0;
      end;
    end;
    VK_DELETE:
    begin
      itm := Selected;
      if itm <> nil then
      begin
        itm.Delete;
        Key := 0;
      end;
    end;
  end;
end;

procedure TLMDWatchView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FSource) then
    Source := nil;
end;

procedure TLMDWatchView.SetItems(const Value: TLMDWatchItems);
begin
  FItems.Assign(Value);
end;

procedure TLMDWatchView.SetSource(const Value: TLMDDebuggerSource);
begin
  if FSource <> Value then
  begin
    if FSource <> nil then
    begin
      FSource.RemoveNotifier(FSourceNotifier);
      FSource.RemoveFreeNotification(Self);
    end;

    FSource := Value;

    if FSource <> nil then
    begin
      FSource.AddNotifier(FSourceNotifier);
      FSource.FreeNotification(Self);
    end;

    SourceStateChanged;
  end;
end;

procedure TLMDWatchView.SourceStateChanged;
begin
  if not (csDesigning in ComponentState) then
    UpdateView;
end;

function TLMDWatchView.TryVarByPath(APath: PLMDNodePath;
  APathSize: Integer; out AVar: TLMDVariable): Boolean;
var
  i:    Integer;
  cur:  TLMDVariable;
  item: TLMDWatchItem;
begin
  cur := nil;

  if FItems <> nil then
  begin
    item := FItems[APath[0]];
    cur  := item.FVars.Root;

    for i := 1 to APathSize - 1 do
      cur := cur[APath[i]];
  end;

  AVar   := cur;
  Result := (cur <> nil);
end;

procedure TLMDWatchView.UpdateView;
var
  i: Integer;
begin
  FItems.BeginUpdate;
  try
    for i := 0 to FItems.Count - 1 do
      FItems[i].InternalInvalidate;
  finally
    FItems.EndUpdate;
  end;
end;

{ TWatchViewSourceNotifier }

procedure TWatchViewSourceNotifier.BreakpointsChanged;
begin
  // Do nothing.
end;

constructor TWatchViewSourceNotifier.Create(AView: TLMDWatchView);
begin
  inherited Create;
  FView := AView;
end;

procedure TWatchViewSourceNotifier.LogMessage(const AMsg: TLMDString;
  AKind: TLMDDebugMsgKind);
begin
  // Do nothing.
end;

procedure TWatchViewSourceNotifier.StateChanged(AChange: TLMDDbgSourceChange);
begin
  FView.SourceStateChanged;
end;

{ TLMDWatchItem }

procedure TLMDWatchItem.Assign(Source: TPersistent);
begin
  if Source is TLMDWatchItem then
  begin
    FExpression := TLMDWatchItem(Source).Expression;
    FEnabled    := TLMDWatchItem(Source).Enabled;
    Changed(False);
  end
  else
    inherited; // Assign error.
end;

constructor TLMDWatchItem.Create(Collection: TCollection);
begin
  inherited;
  FEnabled := True;
  FVars    := TWatchItemItems.Create(Self);
end;

procedure TLMDWatchItem.Delete;
begin
  Free;
end;

destructor TLMDWatchItem.Destroy;
begin
  FVars.Free;
  inherited;
end;

function TLMDWatchItem.GetRoot: TLMDVariable;
begin
  Result := FVars.Root;
end;

procedure TLMDWatchItem.InternalInvalidate;
begin
  FNeedUpdate := True;
  FVars.Clear;
  Changed(False);
end;

procedure TLMDWatchItem.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    InternalInvalidate;
  end;
end;

procedure TLMDWatchItem.SetExpression(const Value: TLMDString);
begin
  if FExpression <> Value then
  begin
    FExpression := Value;
    InternalInvalidate;
  end;
end;

procedure TLMDWatchItem.VarsChanged;
begin
  if not FNeedUpdate then
    Changed(False);
end;

{ TLMDWatchItems }

function TLMDWatchItems.Add: TLMDWatchItem;
begin
  Result := TLMDWatchItem(inherited Add);
end;

function TLMDWatchItems.Add(const AExpression: TLMDString): TLMDWatchItem;
begin
  BeginUpdate;
  try
    Result := TLMDWatchItem(inherited Add);
    Result.Expression := AExpression;
  finally
    EndUpdate;
  end;
end;

function TLMDWatchItems.FindItemID(ID: Integer): TLMDWatchItem;
begin
  Result := TLMDWatchItem(inherited FindItemId(ID));
end;

function TLMDWatchItems.GetItem(Index: Integer): TLMDWatchItem;
begin
  Result := TLMDWatchItem(inherited Items[Index]);
end;

function TLMDWatchItems.Insert(Index: Integer): TLMDWatchItem;
begin
  Result := TLMDWatchItem(inherited Insert(Index));
end;

procedure TLMDWatchItems.SetItem(Index: Integer; const Value: TLMDWatchItem);
begin
  inherited Items[Index] := Value;
end;

procedure TLMDWatchItems.Update(Item: TCollectionItem);
begin
  if Owner is TLMDWatchView then
    TLMDWatchView(Owner).ItemsChanged;
end;

{ TWatchItemItems }

constructor TWatchItemItems.Create(AOwner: TLMDWatchItem);
begin
  inherited Create;
  FOwner := AOwner;
end;

procedure TWatchItemItems.DoChange;
begin
  FOwner.VarsChanged;
end;

function TLMDVarsTreeBase.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_IDE;
end;

initialization
  InitImages;

finalization
  DefDebugImages.Free;

end.
