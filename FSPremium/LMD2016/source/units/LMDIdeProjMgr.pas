unit LMDIdeProjMgr;
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

LMDIdeProjMgr unit (YB)
-----------------------
TLMDProjectManager unit.

Changes
-------

###############################################################################}

interface

uses
  Windows, Messages, Types, Classes, Controls, SysUtils, Forms, Graphics,
  ComCtrls, ExtCtrls, Menus, intfLMDBase, LMDTypes, LMDStrings, LMDSvcPvdr,
  LMDXML, LMDIdeCst;

type
  TLMDProjectManager      = class;
  TLMDOpenedDocument      = class;
  TLMDDocEditorsView      = class;
  ELMDProjectManager      = class(Exception);

  TLMDProjNode            = class;
  TLMDProjDocument        = class;
  TLMDProjNodeClass       = class of TLMDProjNode;

  {******************************* TLMDProjNode *******************************}

  TLMDProjNode = class(TObject)
  private
    FProjMgr:          TLMDProjectManager;
    FParent:           TLMDProjNode;
    FNodes:            TList;
    FDocuments:        TList;
    FModified:         Boolean;
    FChildModifyCount: Integer;
    FData:             TLMDDataTag;
    FTreeNodes:        TList;
    FDestroying:       Boolean;

    procedure InsertNode(ANode: TLMDProjNode);
    procedure RemoveNode(ANode: TLMDProjNode);
    procedure SetTreeNode(ATreeView: TCustomTreeView; ANode: TTreeNode);
    function  GetTreeNode(ATreeView: TCustomTreeView): TTreeNode;
    procedure ClearTreeNodes;
    procedure ClearNodes;
    procedure SetModified(AValue: Boolean);
    function  GetNodeCount: Integer;
    function  GetNodes(AIndex: Integer): TLMDProjNode;
    function  GetDocumentCount: Integer;
    function  GetDocuments(AIndex: Integer): TLMDProjDocument;
    function  GetIdent: TLMDString;
    procedure SetParent(const Value: TLMDProjNode);
  protected
    procedure ReadChildren(AParent: ILMDXmlElement);
    procedure WriteChildren(AParent: ILMDXmlElement);
  protected
    procedure DoRead(AElem: ILMDXmlElement; AIsParentXml: Boolean); virtual;
    procedure DoWrite(AElem: ILMDXmlElement; AIsParentXml: Boolean); virtual;
    function  DoGetDisplayName: TLMDString; virtual;
    procedure DrawImage(ACanvas: TCanvas; const ARect: TRect); virtual;
  public
    constructor Create(AProjMgr: TLMDProjectManager;
                       AParent: TLMDProjNode); virtual;
    destructor Destroy; override;
    procedure  AfterConstruction; override;

    class function  GetNodeClassIdent: TLMDString;
    class procedure SetNodeClassIdent(const AValue: TLMDString);

    procedure UpdateViews;
    procedure MarkModified;
    procedure ResetModified;
    function  IsModified(AWithChildren: Boolean = True): Boolean;
    function  FindParentDocument: TLMDProjDocument;

    procedure Delete;

    property ProjMgr: TLMDProjectManager read FProjMgr;
    property Parent: TLMDProjNode read FParent write SetParent;
    property Ident: TLMDString read GetIdent;
    property DisplayName: TLMDString read DoGetDisplayName;
    property NodeCount: Integer read GetNodeCount;                 // All nodes.
    property Nodes[AIndex: Integer]: TLMDProjNode read GetNodes;   // including docs.
    property DocumentCount: Integer read GetDocumentCount;
    property Documents[AIndex: Integer]: TLMDProjDocument read GetDocuments;
    property Data: TLMDDataTag read FData write FData;
  end;

  {***************************** TLMDProjDocument *****************************}

  TLMDProjDocumentState        = set of (dsLoading, dsSaving, dsChangeName,
                                         dsOpening);
  TLMDProjDocumentSaveQueryRes = (sqrYes, sqrNo, sqrCancel);

  TLMDProjDocument = class(TLMDProjNode)
  private
    FDocumentState:  TLMDProjDocumentState;
    FFilePath:       TLMDString; // Lazy inited. Use FilePath
                                 // property instead.
    FNewFilePath:    TLMDString;
    FIsNew:          Boolean;
    FOpenedDocument: TLMDOpenedDocument;

    function  SaveOpenedFile(const AFileIdent: TLMDString;
                             const AFilePath: TLMDString): Boolean;
    function  MakeUniqueFileName(const ABaseName: TLMDString): TLMDString;
    function  GetDiscardable: Boolean;
    function  GetNeedSave: Boolean;
    function  GetOpened: Boolean;
    function  GetFilePath: TLMDString;
    procedure InternalSetFilePath(const AValue: TLMDString);
  protected
    { Load and Save functions should be called from DoRead/DoWrite in the case
      we reading/writing from parent XML. That is DoRead should first
      read stored in the parent XML content, and perform node loading based
      on this content. Do write should also call Save function before, to save
      the node, because the node filepath could change during saving. Then
      DoWrite should write the node into the parent XML. }

    procedure Load(const AFilePath: TLMDString);
    procedure Save(AChangeName: Boolean = False);

    procedure SaveAssociatedFile(const AFileIdent: TLMDString;
                                 const AFilePath: TLMDString;
                                 const AOldFilePath: TLMDString);

    function  GetRelativeFilePath: TLMDString;        // Used to read/write
    function  MakeFullFilePath(                       // reference to itself
      const ARelFilePath: TLMDString): TLMDString;    // in parent's XML.

    { LoadFromXml and SaveToXml utility functions can be used in DoLoad/DoSave
      to load/save the document in XML format. In this case DoRead/DoWrite
      functions will be used to populate XML. Do not forget to call
      ReadChildren/WriteChildren from DoRead/DoWrite if required. }

    procedure LoadFromXml(const AFilePath: TLMDString);
    procedure SaveToXml(const AFilePath: TLMDString);
  protected
    function  DoGetDisplayName: TLMDString; override;
    procedure DoLoad(const AFilePath: TLMDString); virtual; abstract;
    procedure DoSave(const AFilePath: TLMDString); virtual; abstract;
    function  DoOpenFileStream(const AFileIdent: TLMDString): TStream; virtual;
    function  DoGetDefaultBaseName: TLMDString; virtual; abstract;
    function  DoGetFileExt: TLMDString; virtual; abstract;
  public
    constructor Create(AProjMgr: TLMDProjectManager;
                       AParent: TLMDProjNode); override;
    destructor Destroy; override;

    function  Open(AShowEditor: Boolean): Boolean;
    function  OpenFileStream(const AFileIdent: TLMDString): TStream;
    procedure Close;

    property DocumentState: TLMDProjDocumentState read FDocumentState;
    property FileExt: TLMDString read DoGetFileExt;
    property FilePath: TLMDString read GetFilePath;
    property NewFilePath: TLMDString read FNewFilePath; // Only while saving or
                                                        // loading.
    property IsNew: Boolean read FIsNew;
    property NeedSave: Boolean read GetNeedSave;        // New or modified.
    property Discardable: Boolean read GetDiscardable;  // New and not modified.
    property Opened: Boolean read GetOpened;
    property OpenedDocument: TLMDOpenedDocument read FOpenedDocument;
  end;

  {****************************** TLMDProjectManager **************************}

  TLMDProjDocOpenContext = class
  private
    FDocument: TLMDProjDocument;
  public
    constructor Create(ADocument: TLMDProjDocument);

    procedure Open(AOpenedDocument: TLMDOpenedDocument);
    property  Document: TLMDProjDocument read FDocument;
  end;

  TLMDProjMgrStreamKind     = (skRead, skWrite);
  TLMDProjMgrOnCreateStream = procedure(Sender: TObject;
                                        const AFilePath: TLMDString;
                                        AStreamKind: TLMDProjMgrStreamKind;
                                        var AStream: TStream) of object;
  TLMDProjMgrOnSaveQuery = procedure(Sender: TObject;
                                     ADocument: TLMDProjDocument;
                                     var ASave: TLMDProjDocumentSaveQueryRes) of object;
  TLMDProjMgrOnSaveAs = procedure(Sender: TObject;
                                  ADocument: TLMDProjDocument;
                                  var AFilePath: TLMDString;
                                  var ASave: Boolean) of object;
  TLMDProjMgrOnOpen = procedure(Sender: TObject; AShowEditor: Boolean;
                                AContext: TLMDProjDocOpenContext) of object;
  TLMDProjMgrOnAddition = procedure(Sender: TObject; ANode: TLMDProjNode) of object;
  TLMDProjMgrOnDeletion = procedure(Sender: TObject; ANode: TLMDProjNode) of object;
  TLMDProjMgrOnFilePathChanged = procedure(Sender: TObject;
                                           ADocument: TLMDProjDocument) of object;

  TLMDProjectManager = class(TComponent, ILMDComponent)
  private
    FAbout:             TLMDAboutVar;
    FRoot:              TLMDProjDocument;
    FViews:             TList;
    FNodeClasses:       TList;
    FOnCreateStream:    TLMDProjMgrOnCreateStream;
    FOnSaveQuery:       TLMDProjMgrOnSaveQuery;
    FOnSaveAs:          TLMDProjMgrOnSaveAs;
    FOnOpen:            TLMDProjMgrOnOpen;
    FEditorsView:       TLMDDocEditorsView;
    FOnAddition:        TLMDProjMgrOnAddition;
    FOnDeletion:        TLMDProjMgrOnDeletion;
    FOnFilePathChanged: TLMDProjMgrOnFilePathChanged;

    function  FindNodeClass(const AIdent: TLMDString): TLMDProjNodeClass;
    procedure DissociateViews;
    procedure UpdateViews;
    procedure SetEditorsView(const Value: TLMDDocEditorsView);
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    function  GetNodeClass(const AIdent: TLMDString): TLMDProjNodeClass; virtual;
    function  DoCreateStream(const AFilePath: TLMDString;
                             AStreamKind: TLMDProjMgrStreamKind): TStream; virtual;
    function  DoSaveQuery(ADocument: TLMDProjDocument): TLMDProjDocumentSaveQueryRes; virtual;
    function  DoSaveAs(ADocument: TLMDProjDocument;
                       var AFilePath: TLMDString): Boolean; virtual;
    procedure DoOpen(AShowEditor: Boolean;
                     AContext: TLMDProjDocOpenContext); virtual;
    procedure DoAddition(ANode: TLMDProjNode); virtual;
    procedure DoDeletion(ANode: TLMDProjNode); virtual;
    procedure DoFilePathChanged(ADocument: TLMDProjDocument); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Clear;
    procedure Load(const AFilePath: TLMDString; ARootClass: TLMDProjNodeClass);
    function  Save(AChangeName: Boolean): Boolean; overload;
    function  Save(ADocument: TLMDProjDocument; AChangeName: Boolean): Boolean; overload;
    function  SaveQuery: TLMDProjDocumentSaveQueryRes; overload;
    function  SaveQuery(ADocument: TLMDProjDocument): TLMDProjDocumentSaveQueryRes; overload;
    function  New(AParent: TLMDProjNode; ANodeClass: TLMDProjNodeClass): TLMDProjNode;
    function  AddExisting(const AFilePath: TLMDString; AParent: TLMDProjNode;
                          ANodeClass: TLMDProjNodeClass): TLMDProjNode;

    function  CreateStream(const AFilePath: TLMDString;
                           AStreamKind: TLMDProjMgrStreamKind): TStream;

    procedure RegisterNodeClass(AClass: TLMDProjNodeClass);
    procedure UnregisterNodeClass(AClass: TLMDProjNodeClass);

    property Root: TLMDProjDocument read FRoot;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property EditorsView: TLMDDocEditorsView read FEditorsView write SetEditorsView;
    property OnCreateStream: TLMDProjMgrOnCreateStream read FOnCreateStream write FOnCreateStream;
    property OnSaveQuery: TLMDProjMgrOnSaveQuery read FOnSaveQuery write FOnSaveQuery;
    property OnSaveAs: TLMDProjMgrOnSaveAs read FOnSaveAs write FOnSaveAs;
    property OnOpen: TLMDProjMgrOnOpen read FOnOpen write FOnOpen;
    property OnAddition: TLMDProjMgrOnAddition read FOnAddition write FOnAddition;
    property OnDeletion: TLMDProjMgrOnDeletion read FOnDeletion write FOnDeletion;
    property OnFilePathChanged: TLMDProjMgrOnFilePathChanged read FOnFilePathChanged write FOnFilePathChanged;
  end;

  {***************************** TLMDOpenedDocument ***************************}

  TLMDOpenedDocumentBeforeSave = procedure(Sender: TObject;
                                           const AFilePath: TLMDString;
                                           var ACancel: Boolean) of object;
  TLMDOpenedDocumentOnSave = procedure(Sender: TObject;
                                       const AFilePath: TLMDString) of object;
  TLMDOpenedDocumentOnSaveFile = procedure(Sender: TObject;
                                           const AFileIdent: TLMDString;
                                           AFileStream: TStream;
                                           var AHandled: Boolean) of object;
  TLMDOpenedDocumentOnOpening = procedure(Sender: TObject;
                                          ADocument: TLMDProjDocument) of object;

  TLMDOpenedDocument = class(TComponent, ILMDComponent)
  private
    FAbout:         TLMDAboutVar;
    FNode:          TLMDProjDocument;
    FEditorVisible: Boolean;
    FOnBeforeSave:  TLMDOpenedDocumentBeforeSave;
    FOnAfterSave:   TLMDOpenedDocumentOnSave;
    FOnSaveFile:    TLMDOpenedDocumentOnSaveFile;
    FOnClose:       TNotifyEvent;
    FOnShow:        TNotifyEvent;
    FOnHide:        TNotifyEvent;
    FOnOpening:     TLMDOpenedDocumentOnOpening;

    procedure AssociateNode(AValue: TLMDProjDocument);
    function  GetOpened: Boolean;
    procedure SetEditorVisible(const Value: Boolean);
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  protected
    function  DoBeforeSave(const AFilePath: TLMDString): Boolean; virtual;
    procedure DoAfterSave(const AFilePath: TLMDString); virtual;
    function  DoSaveFile(const AFileIdent: TLMDString;
                         AFileStream: TStream): Boolean; virtual;
    procedure DoClose; virtual;
    procedure DoShow; virtual;
    procedure DoHide; virtual;
    procedure DoOpening(ADocument: TLMDProjDocument); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure MarkClosed;
    property  Node: TLMDProjDocument read FNode;
    property  Opened: Boolean read GetOpened;
    property  EditorVisible: Boolean read FEditorVisible write SetEditorVisible;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property OnBeforeSave: TLMDOpenedDocumentBeforeSave read FOnBeforeSave write FOnBeforeSave;
    property OnAfterSave: TLMDOpenedDocumentOnSave read FOnAfterSave write FOnAfterSave;
    property OnSaveFile: TLMDOpenedDocumentOnSaveFile read FOnSaveFile write FOnSaveFile;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;
    property OnOpening: TLMDOpenedDocumentOnOpening read FOnOpening write FOnOpening;
  end;

  {************************** TLMDProjectManagerView **************************}

  TLMDProjectManagerView = class(TCustomTreeView, ILMDComponent)
  private
    FAbout:          TLMDAboutVar;
    FProjectManager: TLMDProjectManager;
    FUpdateCount:    Integer;
    FDblClicking:    Boolean;

    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure SetProjectManager(const Value: TLMDProjectManager);
    procedure UpdateView;
    function  GetSelectedDoc: TLMDProjDocument;
    function  GetSelected: TLMDProjNode;
    procedure DummyDrawHandler(Sender: TCustomTreeView; Node: TTreeNode;
                               State: TCustomDrawState; Stage: TCustomDrawStage;
                               var PaintImages, DefaultDraw: Boolean);
  protected
    { ILMDComponent }
    
    function getLMDPackage: TLMDPackageID;
  protected
    procedure CreateHandle; override;
    function  CreateNode: TTreeNode; override;
    procedure DblClick; override;
    function  CanCollapse(Node: TTreeNode): Boolean; override;
    function  CanExpand(Node: TTreeNode): Boolean; override;
    function  CustomDrawItem(Node: TTreeNode; State: TCustomDrawState;
                             Stage: TCustomDrawStage;
                             var PaintImages: Boolean): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure BeginUpdate;
    procedure EndUpdate;
    function  ConvertTreeNode(ATreeNode: TTreeNode): TLMDProjNode;
    property  Selected: TLMDProjNode read GetSelected;
    property  SelectedDoc: TLMDProjDocument read GetSelectedDoc;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property ProjectManager: TLMDProjectManager read FProjectManager write SetProjectManager;
    property Align;
    property Anchors;
    property AutoExpand;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind default bkNone;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property ChangeDelay;
    property Color;
    property Ctl3D;
    property Constraints;
    property DragKind;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection default False;
    property HotTrack;
    property Indent;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property RightClickSelect;
    property RowSelect;
    property ShowHint;
    property ShowLines;
    property ShowRoot;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnAddition;
    property OnClick;
    property OnCollapsed;
    property OnCollapsing;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    {$IFDEF LMDCOMP14}
    property OnHint;
    {$ENDIF}
    property OnExpanding;
    property OnExpanded;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  {*************************** TLMDDocEditorsView *****************************}

  TLMDDocEditorsViewEditors = class;
  TLMDDocEditorsViewItem    = class
  private
    FEditors:         TLMDDocEditorsViewEditors;
    FProjManager:     TLMDProjectManager;
    FOpenedDocument:  TLMDOpenedDocument;
    FFrame:           TCustomFrame;
    function GetNode: TLMDProjDocument;
  public
    constructor Create(AEditors: TLMDDocEditorsViewEditors;
                       AProjManager: TLMDProjectManager;
                       AOpenedDocument: TLMDOpenedDocument;
                       AFrame: TCustomFrame);
    destructor Destroy; override;

    procedure Delete;
    procedure Close;

    property ProjManager: TLMDProjectManager read FProjManager;
    property OpenedDocument: TLMDOpenedDocument read FOpenedDocument;
    property Node: TLMDProjDocument read GetNode;
    property Frame: TCustomFrame read FFrame;
  end;

  TLMDDocEditorsViewEditors = class
  private
    FView:  TLMDDocEditorsView;
    FItems: TList;

    function GetCount: Integer;
    function GetItems(AIndex: Integer): TLMDDocEditorsViewItem;
  public
    constructor Create(AView: TLMDDocEditorsView);
    destructor Destroy; override;

    procedure DeleteAll;
    function  IndexOf(AItem: TLMDDocEditorsViewItem): Integer;
    function  Find(ADocument: TLMDOpenedDocument): TLMDDocEditorsViewItem; overload;
    function  Find(ANode: TLMDProjNode): TLMDDocEditorsViewItem; overload;

    property Count: Integer read GetCount;
    property Items[AIndex: Integer]: TLMDDocEditorsViewItem read GetItems; default;
  end;

  TLMDDocEditorsViewOnCreateEditor = procedure(Sender: TObject;
                                               ADocument: TLMDProjDocument;
                                               var AEditor: TCustomFrame) of object;
  TLMDDocEditorsViewOnGetTabName = procedure(Sender: TObject;
                                             AEditor: TLMDDocEditorsViewItem;
                                             var AName: TLMDString) of object;

  TLMDDocEditorsView = class(TCustomPanel)
  private
    FTabs:           TTabControl;
    FClientPanel:    TPanel;
    FTabHeight:      Integer;
    FEditors:        TLMDDocEditorsViewEditors;
    FActiveEditor:   TLMDDocEditorsViewItem;
    FNeedUpdate:     Boolean;
    FUpdateCount:    Integer;
    FOnCreateEditor: TLMDDocEditorsViewOnCreateEditor;
    FOnGetTabName:   TLMDDocEditorsViewOnGetTabName;
    FOnChange:       TNotifyEvent;

    function  ContainsFocus: Boolean;
    procedure SetTabHeight(const Value: Integer);
    procedure ItemDestroying(AItem: TLMDDocEditorsViewItem);
    procedure CreateEditor(AShowEditor: Boolean;
                           AContext: TLMDProjDocOpenContext);
    procedure ShowEditor(ADocument: TLMDOpenedDocument);
    procedure HideEditor(ADocument: TLMDOpenedDocument);
    procedure FreeEditor(ADocument: TLMDOpenedDocument);
    procedure FreeMgrEditors(AProjMgr: TLMDProjectManager);
    function  FindNearVisibleEditor(AItem: TLMDDocEditorsViewItem): TLMDDocEditorsViewItem;
    procedure TabChanged;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateHandle; override;
    procedure Resize; override;
    function  DoCreateEditor(ADocument: TLMDProjDocument): TCustomFrame; virtual;
    function  DoGetTaName(AEditor: TLMDDocEditorsViewItem): TLMDString; virtual;
    procedure DoChange; virtual;

    procedure UpdateView;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure BeginUpdate;
    procedure EndUpdate;
    property  Editors: TLMDDocEditorsViewEditors read FEditors;
    property  ActiveEditor: TLMDDocEditorsViewItem read FActiveEditor;
  published
    property TabHeight: Integer read FTabHeight write SetTabHeight default 18;
    property OnCreateEditor: TLMDDocEditorsViewOnCreateEditor read FOnCreateEditor write FOnCreateEditor;
    property OnGetTabName: TLMDDocEditorsViewOnGetTabName read FOnGetTabName write FOnGetTabName;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BevelInner;
    property BevelOuter default bvNone;
    property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property BorderStyle default bsSingle;
    property Caption;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentFont;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnCanResize;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
  end;

implementation

uses
  Dialogs, Math;

{$IFDEF LMD_DEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

{------------------------------------------------------------------------------}

type
  ESaveCancel    = class(Exception);
  TNodeClassItem = class
  public
    Ident:     TLMDString;
    NodeClass: TLMDProjNodeClass;
  end;

  TProjViewNode = class(TTreeNode)
  private
    FProjNode: TLMDProjNode;
  public
    destructor Destroy; override;
  end;

  TEditorTabControl = class(TTabControl)
  private
    FView: TLMDDocEditorsView;
  protected
    procedure Change; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TEditorClientPanel = class(TPanel)
  public
    constructor Create(AOwner: TComponent); override;
  end;
       
{------------------------------------------------------------------------------}

var
  IdentByClassList: TList;      // Lazy created list of TNodeClassItem.
  DummyImageList:   TImageList; // Dummy image list to tell tree-view to add
                                // screen space for images.
      
{------------------------------------------------------------------------------}

procedure FreeIdentByClassList;
var
  i: Integer;
begin
  if IdentByClassList <> nil then
  begin
    for i := 0 to IdentByClassList.Count - 1 do
      TObject(IdentByClassList[i]).Free;

    IdentByClassList.Free;
    IdentByClassList := nil;
  end;
end;

{******************************** TLMDProjNode ********************************}
{------------------------------------------------------------------------------}

procedure TLMDProjNode.InsertNode(ANode: TLMDProjNode);
begin
  ANode.FParent := Self;
  if ANode.FModified then
    Inc(FChildModifyCount);

  FNodes.Add(ANode);
  if ANode is TLMDProjDocument then
    FDocuments.Add(ANode);
end;
               
{------------------------------------------------------------------------------}

procedure TLMDProjNode.RemoveNode(ANode: TLMDProjNode);
begin
  ANode.FParent := nil;
  if ANode.FModified then
    Dec(FChildModifyCount);

  FNodes.Remove(ANode);
  if ANode is TLMDProjDocument then
    FDocuments.Remove(ANode);
end;
         
procedure TLMDProjNode.ResetModified;
begin
  if (Self is TLMDProjDocument) and
     not (dsOpening in TLMDProjDocument(Self).DocumentState) then
  begin
    SetModified(False);

    FProjMgr.UpdateViews;
    if FProjMgr.FEditorsView <> nil then
      FProjMgr.FEditorsView.UpdateView;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDProjNode.AfterConstruction;
begin
  inherited;
  FProjMgr.DoAddition(Self);
  FProjMgr.UpdateViews;
end;

procedure TLMDProjNode.ClearNodes;
begin
  while FNodes.Count > 0 do
    TObject(FNodes[0]).Free;
end;
       
{------------------------------------------------------------------------------}

procedure TLMDProjNode.SetModified(AValue: Boolean);
begin
  if AValue <> FModified then
  begin
    FModified := AValue;

    if FParent <> nil then
    begin
      if AValue then
        Inc(FParent.FChildModifyCount)
      else
        Dec(FParent.FChildModifyCount);
    end;
  end;
end;
     
{------------------------------------------------------------------------------}

function TLMDProjNode.GetNodeCount: Integer;
begin
  Result := FNodes.Count;
end;
     
{------------------------------------------------------------------------------}

function TLMDProjNode.GetNodes(AIndex: Integer): TLMDProjNode;
begin
  Result := TLMDProjNode(FNodes[AIndex]);
end;
     
{------------------------------------------------------------------------------}

function TLMDProjNode.GetDocumentCount: Integer;
begin
  Result := FDocuments.Count;
end;
      
{------------------------------------------------------------------------------}

function TLMDProjNode.GetDocuments(AIndex: Integer): TLMDProjDocument;
begin
  Result := TLMDProjDocument(FDocuments[AIndex]);
end;
       
{------------------------------------------------------------------------------}

function TLMDProjNode.GetIdent: TLMDString;
begin
  Result := GetNodeClassIdent;
end;
     
{------------------------------------------------------------------------------}

procedure TLMDProjNode.ReadChildren(AParent: ILMDXmlElement);
var
  i:    Integer;
  elem: ILMDXmlElement;
  cls:  TLMDProjNodeClass;
  nd:   TLMDProjNode;
begin
  for i := 0 to AParent.ChildNodes.Count - 1 do
    if AParent.ChildNodes[i].NodeType = LMD_NODE_ELEMENT then
    begin
      elem := AParent.ChildNodes[i].AsElement;
      cls  := FProjMgr.GetNodeClass(elem.NodeName);
      nd   := cls.Create(FProjMgr, Self);

      nd.DoRead(elem, True);
    end;
end;
       
{------------------------------------------------------------------------------}

procedure TLMDProjNode.WriteChildren(AParent: ILMDXmlElement);
var
  i:    Integer;
  elem: ILMDXmlElement;
begin
  for i := 0 to NodeCount - 1 do
  begin
    elem := AParent.AppendElement(Nodes[i].Ident);
    Nodes[i].DoWrite(elem, True);
  end;
end;
   
{------------------------------------------------------------------------------}

function TLMDProjNode.DoGetDisplayName: TLMDString;
begin
  Result := SLMDProjNodeDefaultDisplayName;
end;
   
{------------------------------------------------------------------------------}

constructor TLMDProjNode.Create(AProjMgr: TLMDProjectManager;
  AParent: TLMDProjNode);
begin
  inherited Create;

  FNodes     := TList.Create;
  FDocuments := TList.Create;
  FTreeNodes := TList.Create;
  FProjMgr   := AProjMgr;

  if AParent <> nil then
    AParent.InsertNode(Self)
  else
  begin
    Assert(Self is TLMDProjDocument, 'Root project node should be a document.');
    AProjMgr.FRoot := TLMDProjDocument(Self);
  end;
end;
       
{------------------------------------------------------------------------------}

destructor TLMDProjNode.Destroy;
begin
  FDestroying := True;
  ClearTreeNodes;
  ClearNodes;
  if FParent <> nil then
    FParent.RemoveNode(Self)
  else
    FProjMgr.FRoot := nil;

  FNodes.Free;
  FDocuments.Free;
  FTreeNodes.Free;

  FProjMgr.DoDeletion(Self);
  FProjMgr.UpdateViews;
  inherited;
end;
     
{------------------------------------------------------------------------------}

class function TLMDProjNode.GetNodeClassIdent: TLMDString;
var
  i: Integer;
begin
  if IdentByClassList <> nil then
    for i := 0 to IdentByClassList.Count - 1 do
      if TNodeClassItem(IdentByClassList[i]).NodeClass = Self then
      begin
        Result := TNodeClassItem(IdentByClassList[i]).Ident;
        Exit;
      end;

  raise ELMDProjectManager.CreateFmt(SLMDProjNodeClassHasNoIdent,
                                     [ClassName]);
end;
       
{------------------------------------------------------------------------------}

class procedure TLMDProjNode.SetNodeClassIdent(const AValue: TLMDString);
var
  item: TNodeClassItem;
begin
  if IdentByClassList = nil then
    IdentByClassList := TList.Create;

  item := TNodeClassItem.Create;
  try
    item.Ident     := AValue;
    item.NodeClass := Self;
    IdentByClassList.Add(item);
  except
    item.Free;
    raise;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDProjNode.SetParent(const Value: TLMDProjNode);
begin
  if FParent <> Value then
  begin
    Assert(FProjMgr.FRoot <> Self, 'Cannot move root project manager node.');
    Assert(Value <> nil, 'Cannot replace root project manager node.');

    FParent.RemoveNode(Self);
    Value.InsertNode(Self);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDProjNode.MarkModified;
begin
  if (Self is TLMDProjDocument) and
     not (dsOpening in TLMDProjDocument(Self).DocumentState) then
  begin
    SetModified(True);

    FProjMgr.UpdateViews;
    if FProjMgr.FEditorsView <> nil then
      FProjMgr.FEditorsView.UpdateView;
  end;
end;
      
{------------------------------------------------------------------------------}

function TLMDProjNode.IsModified(AWithChildren: Boolean): Boolean;
begin
  Result := FModified;
  if AWithChildren then
    Result := Result or (FChildModifyCount > 0);
end;
         
{------------------------------------------------------------------------------}

function TLMDProjNode.FindParentDocument: TLMDProjDocument;
var
  cur: TLMDProjNode;
begin
  cur := FParent;
  while (cur <> nil) and not (cur is TLMDProjDocument) do
    cur := cur.FParent;

  Result := TLMDProjDocument(cur);
end;
      
{------------------------------------------------------------------------------}

procedure TLMDProjNode.Delete;
begin
  Free;
end;

{******************************* TLMDProjDocument *****************************}
{------------------------------------------------------------------------------}

function TLMDProjDocument.SaveOpenedFile(const AFileIdent,
  AFilePath: TLMDString): Boolean;
var
  mstr: TMemoryStream;
  rstr: TStream;
begin
  Assert(dsSaving in FDocumentState,
         'Saving associated files is only allowed hile saving document.');
  Result := False;

  if Opened then
  begin
    mstr := TMemoryStream.Create; // Use in-memory stream to prevent
                                  // existing file damage in error case.
    try
      Result := FOpenedDocument.DoSaveFile(AFileIdent, mstr);
      if Result then
      begin
        rstr := FProjMgr.CreateStream(AFilePath, skWrite);
        try
          mstr.SaveToStream(rstr);
        finally
          rstr.Free;
        end;
      end;
    finally
      mstr.Free;
    end;
  end;
end;
          
{------------------------------------------------------------------------------}

function TLMDProjDocument.MakeUniqueFileName(
  const ABaseName: TLMDString): TLMDString;
var
  pntdoc: TLMDProjDocument;
  i:      Integer;

  function _HasParentChildDoc(const AFileName: TLMDString): Boolean;
  var
    i: Integer;
  begin
    if pntdoc <> nil then
      for i := 0 to pntdoc.DocumentCount - 1 do
        if (pntdoc.Documents[i] <> Self) and
           LMDSameText(ExtractFileName(pntdoc.Documents[i].FFilePath),
                       AFileName) then
        begin
          Result := True;
          Exit;
        end;
    Result := False;
  end;

begin
  pntdoc := FindParentDocument;

  i := 1;
  while True do
  begin
    Result := ABaseName + IntToStr(i) + DoGetFileExt;
    if not _HasParentChildDoc(Result) then
      Exit;
    Inc(i);
  end;
end;
      
{------------------------------------------------------------------------------}

function TLMDProjDocument.GetDiscardable: Boolean;
begin
  Result := FIsNew and not IsModified(True);
end;
     
{------------------------------------------------------------------------------}

function TLMDProjDocument.GetNeedSave: Boolean;
begin
  Result := FIsNew or IsModified(True);
end;
        
{------------------------------------------------------------------------------}

function TLMDProjDocument.GetOpened: Boolean;
begin
  Result := (FOpenedDocument <> nil);
end;
     
{------------------------------------------------------------------------------}

function TLMDProjDocument.GetFilePath: TLMDString;
begin
  if FFilePath = '' then
    FFilePath := MakeUniqueFileName(DoGetDefaultBaseName);
  Result := FFilePath;
end;
        
{------------------------------------------------------------------------------}

procedure TLMDProjDocument.Load(const AFilePath: TLMDString);
begin
  Assert(not FModified and not Opened);

  Include(FDocumentState, dsLoading);
  FNewFilePath := AFilePath;
  try
    DoLoad(AFilePath);

    SetModified(False);
    FIsNew     := False;
    InternalSetFilePath(AFilePath);
  finally
    FNewFilePath := '';
    Exclude(FDocumentState, dsLoading);
  end;
end;
     
{------------------------------------------------------------------------------}

procedure TLMDProjDocument.Save(AChangeName: Boolean);
var
  flname: TLMDString;
begin
  if not NeedSave and not AChangeName then
    Exit;

  flname := FilePath;
  if (FisNew or AChangeName) and not FProjMgr.DoSaveAs(Self, flname) then
    raise ESaveCancel.Create(''); // Not for users.
  flname := ChangeFileExt(flname, DoGetFileExt);

  Include(FDocumentState, dsSaving);
  if AChangeName then
    Include(FDocumentState, dsChangeName);
  FNewFilePath := flname;
  try
    Open(False);      // For smart editors that will assist saving.

    if Opened and not FOpenedDocument.DoBeforeSave(flname) then
      raise ESaveCancel.Create(''); // Not for users.

    DoSave(flname);

    SetModified(False);
    FIsNew     := False;
    InternalSetFilePath(flname);

    if Opened then
      FOpenedDocument.DoAfterSave(flname);
  finally
    FNewFilePath := '';
    Exclude(FDocumentState, dsSaving);
    Exclude(FDocumentState, dsChangeName);
  end;

  FProjMgr.UpdateViews;
  if FProjMgr.FEditorsView <> nil then
    FProjMgr.FEditorsView.UpdateView;
end;
        
{------------------------------------------------------------------------------}

procedure TLMDProjDocument.SaveAssociatedFile(const AFileIdent, AFilePath,
  AOldFilePath: TLMDString);
var
  cpyres: Boolean;
begin
  Assert(dsSaving in FDocumentState,
         'Saving associated files is only allowed hile saving document.');

  if not SaveOpenedFile(AFileIdent, AFilePath) then
  begin
    if IsNew then
    begin
      TFileStream.Create(AFilePath, fmCreate).Free;
    end
    else if (dsChangeName in FDocumentState) and
            not LMDSameText(AFilePath, AOldFilePath) then
    begin
      cpyres := {$IFDEF _LMD_UNICODEIMPL}CopyFileW({$ELSE}CopyFile({$ENDIF}
        PLMDChar(AOldFilePath), PLMDChar(AFilePath), False);
      if not cpyres then
        RaiseLastOSError;
    end
    else
      Assert(AFilePath = AOldFilePath);
  end;
end;
        
{------------------------------------------------------------------------------}

function TLMDProjDocument.GetRelativeFilePath: TLMDString;
var
  pntflnm: TLMDString;
  pntdoc:  TLMDProjDocument;
begin
  pntdoc := FindParentDocument;

  if pntdoc = nil then
    Result := FilePath
  else
  begin
    if (dsSaving in pntdoc.FDocumentState) or
       (dsLoading in pntdoc.FDocumentState) then
      pntflnm := pntdoc.FNewFilePath
    else
      pntflnm := pntdoc.FilePath;

    Result  := ExtractRelativePath(pntflnm, FilePath);
  end;
end;
         
{------------------------------------------------------------------------------}

function TLMDProjDocument.MakeFullFilePath(
  const ARelFilePath: TLMDString): TLMDString;
var
  pntflnm: TLMDString;
  pntdoc:  TLMDProjDocument;
  pntdir:  TLMDString;
begin
  pntdoc := FindParentDocument;

  if (pntdoc = nil) or (ExtractFileDrive(ARelFilePath) <> '') then
    Result := ARelFilePath
  else
  begin
    if (dsSaving in pntdoc.FDocumentState) or
       (dsLoading in pntdoc.FDocumentState) then
      pntflnm := pntdoc.FNewFilePath
    else
      pntflnm := pntdoc.FilePath;

    pntdir := ExtractFileDir(pntflnm);
    Result := LMDSlashAdd(pntdir) + ARelFilePath;
  end;
end;
           
{------------------------------------------------------------------------------}

function TLMDProjDocument.DoGetDisplayName: TLMDString;
begin
  Result := ExtractFileName(FilePath);
end;
          
{------------------------------------------------------------------------------}

function TLMDProjDocument.DoOpenFileStream(
  const AFileIdent: TLMDString): TStream;
begin
  Result := nil; // Override me.
end;
        
{------------------------------------------------------------------------------}

constructor TLMDProjDocument.Create(AProjMgr: TLMDProjectManager;
  AParent: TLMDProjNode);
begin
  inherited;
  FIsNew := True;
end;
      
{------------------------------------------------------------------------------}

destructor TLMDProjDocument.Destroy;
begin
  if FOpenedDocument <> nil then
    FOpenedDocument.AssociateNode(nil);
  inherited;
end;
        
{------------------------------------------------------------------------------}

function TLMDProjDocument.Open(AShowEditor: Boolean): Boolean;
var
  ctx: TLMDProjDocOpenContext;
begin
  Assert(not (dsOpening in FDocumentState),
         'Document opening is already in progress.');

  ctx := TLMDProjDocOpenContext.Create(Self);
  Include(FDocumentState, dsOpening);
  try
    if not Opened then
      FProjMgr.DoOpen(AShowEditor, ctx);
    Result := Opened;
  finally
    Exclude(FDocumentState, dsOpening);
    ctx.Free;
  end;

  if Opened and AShowEditor then
    FOpenedDocument.DoShow;
end;
     
{------------------------------------------------------------------------------}

function TLMDProjDocument.OpenFileStream(
  const AFileIdent: TLMDString): TStream;
begin
  Assert(not IsNew, 'Can''t open file stream for not yet saved document.');

  Result := DoOpenFileStream(AFileIdent);
  Assert(Result <> nil, 'Document has no specified file.');
end;
         
{------------------------------------------------------------------------------}

procedure TLMDProjDocument.Close;
begin
  if Opened then
    FOpenedDocument.DoClose;
end;

{***************************** TLMDProjDocOpenContext *************************}
{------------------------------------------------------------------------------}

constructor TLMDProjDocOpenContext.Create(ADocument: TLMDProjDocument);
begin
  inherited Create;
  FDocument := ADocument;
end;
          
{------------------------------------------------------------------------------}

procedure TLMDProjDocOpenContext.Open(
  AOpenedDocument: TLMDOpenedDocument);
begin
  Assert(AOpenedDocument.Node = nil,
         'Opened document object already bound to another project document.');
  AOpenedDocument.DoOpening(FDocument);
  AOpenedDocument.AssociateNode(FDocument);
end;

{******************************* TLMDProjectManager ***************************}
{------------------------------------------------------------------------------}

function TLMDProjectManager.FindNodeClass(
  const AIdent: TLMDString): TLMDProjNodeClass;
var
  i: Integer;
begin
  for i := 0 to FNodeClasses.Count - 1 do
    if LMDSameText(TLMDProjNodeClass(FNodeClasses[i]).GetNodeClassIdent,
                   AIdent) then
  begin
    Result := TLMDProjNodeClass(FNodeClasses[i]);
    Exit;
  end;

  Result := nil;
end;
         
{------------------------------------------------------------------------------}

function TLMDProjectManager.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_IDE;
end;
         
{------------------------------------------------------------------------------}

function TLMDProjectManager.GetNodeClass(
  const AIdent: TLMDString): TLMDProjNodeClass;
begin
  Result := FindNodeClass(AIdent);
  if Result = nil then
    raise ELMDProjectManager.CreateFmt(SLMDProjNodeClassNotRegistered,
                                       [AIdent]);
end;
       
{------------------------------------------------------------------------------}

procedure TLMDProjectManager.DoAddition(ANode: TLMDProjNode);
begin
  if Assigned(FOnAddition) then
    FOnAddition(Self, ANode);
end;

function TLMDProjectManager.DoCreateStream(const AFilePath: TLMDString;
  AStreamKind: TLMDProjMgrStreamKind): TStream;
begin
  Result := nil;
  if Assigned(FOnCreateStream) then
    FOnCreateStream(Self, AFilePath, AStreamKind, Result);
end;
         
procedure TLMDProjectManager.DoDeletion(ANode: TLMDProjNode);
begin
  if Assigned(FOnDeletion) then
    FOnDeletion(Self, ANode);
end;

{------------------------------------------------------------------------------}

function TLMDProjectManager.DoSaveQuery(
  ADocument: TLMDProjDocument): TLMDProjDocumentSaveQueryRes;
begin
  Result := sqrYes;
  if Assigned(FOnSaveQuery) then
    FOnSaveQuery(Self, ADocument, Result);
end;
         
{------------------------------------------------------------------------------}

function TLMDProjectManager.DoSaveAs(ADocument: TLMDProjDocument;
  var AFilePath: TLMDString): Boolean;
begin
  Result := False;
  if Assigned(FOnSaveAs) then
    FOnSaveAs(Self, ADocument, AFilePath, Result);
end;
         
{------------------------------------------------------------------------------}

procedure TLMDProjectManager.DoOpen(AShowEditor: Boolean;
  AContext: TLMDProjDocOpenContext);
begin
  if Assigned(FOnOpen) then
    FOnOpen(Self, AShowEditor, AContext);
  if not AContext.Document.Opened and (FEditorsView <> nil) then
    FEditorsView.CreateEditor(AShowEditor, AContext);
end;
       
{------------------------------------------------------------------------------}

constructor TLMDProjectManager.Create(AOwner: TComponent);
begin
  inherited;
  FNodeClasses := TList.Create;
  FViews       := TList.Create;
end;
        
{------------------------------------------------------------------------------}

destructor TLMDProjectManager.Destroy;
begin
  EditorsView := nil;
  DissociateViews;
  Clear;
  FNodeClasses.Free;
  FViews.Free;
  inherited;
end;
     
{------------------------------------------------------------------------------}

function TLMDProjectManager.AddExisting(const AFilePath: TLMDString;
  AParent: TLMDProjNode; ANodeClass: TLMDProjNodeClass): TLMDProjNode;
begin
  Result := ANodeClass.Create(Self, AParent);
  try
    if Result is TLMDProjDocument then
      TLMDProjDocument(Result).Load(AFilePath);
  except
    Result.Free;
    raise;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDProjectManager.Clear;
begin
  FRoot.Free;
  FRoot := nil;
end;

{------------------------------------------------------------------------------}

procedure TLMDProjectManager.Load(const AFilePath: TLMDString;
  ARootClass: TLMDProjNodeClass);
begin
  Clear;

  ARootClass.Create(Self, nil);
  FRoot.Load(AFilePath);
end;
      
{------------------------------------------------------------------------------}

function TLMDProjectManager.Save(AChangeName: Boolean): Boolean;
begin
  Assert(FRoot <> nil, 'Has no project.');
  Result := Save(FRoot, AChangeName);
end;
      
{------------------------------------------------------------------------------}

function TLMDProjectManager.Save(ADocument: TLMDProjDocument;
  AChangeName: Boolean): Boolean;
begin
  try
    Result := True;
    ADocument.Save(AChangeName);
  except
    on e: ESaveCancel do
      Result := False
    else
      raise;
  end;
end;
     
{------------------------------------------------------------------------------}

function TLMDProjectManager.SaveQuery: TLMDProjDocumentSaveQueryRes;
begin
  Assert(FRoot <> nil, 'Has no project.');
  Result := SaveQuery(FRoot);
end;
          
{------------------------------------------------------------------------------}

function TLMDProjectManager.SaveQuery(
  ADocument: TLMDProjDocument): TLMDProjDocumentSaveQueryRes;
begin
  Result := DoSaveQuery(ADocument);
end;
           
{------------------------------------------------------------------------------}

function TLMDProjectManager.New(AParent: TLMDProjNode;
  ANodeClass: TLMDProjNodeClass): TLMDProjNode;
begin
  Result := ANodeClass.Create(Self, AParent);
end;
                     
{------------------------------------------------------------------------------}

function TLMDProjectManager.CreateStream(const AFilePath: TLMDString;
  AStreamKind: TLMDProjMgrStreamKind): TStream;
begin
  Result := DoCreateStream(AFilePath, AStreamKind);

  if Result = nil then
    case AStreamKind of
      skRead:   Result := TFileStream.Create(AFilePath, fmOpenRead or
                                                        fmShareDenyWrite);
      skWrite:  Result := TFileStream.Create(AFilePath, fmCreate);
    else
      Assert(False);
    end;
end;
            
{------------------------------------------------------------------------------}

procedure TLMDProjectManager.RegisterNodeClass(AClass: TLMDProjNodeClass);
begin
  if FNodeClasses.IndexOf(TObject(AClass)) = -1 then
    FNodeClasses.Add(TObject(AClass));
end;
           
{------------------------------------------------------------------------------}

procedure TLMDProjectManager.UnregisterNodeClass(
  AClass: TLMDProjNodeClass);
begin
  FNodeClasses.Remove(TObject(AClass));
end;

{****************************** TLMDOpenedDocument ****************************}
{------------------------------------------------------------------------------}

procedure TLMDOpenedDocument.AssociateNode(AValue: TLMDProjDocument);
var
  edview: TLMDDocEditorsView;
begin
  if AValue <> FNode then
  begin
    edview := nil;
    if FNode <> nil then
    begin
      FNode.FOpenedDocument := nil;
      edview := FNode.FProjMgr.FEditorsView;
    end;
    FNode := AValue;
    if FNode <> nil then
      FNode.FOpenedDocument := Self;

    if (FNode = nil) and (edview <> nil) then
      edview.FreeEditor(Self);
  end;
end;
             
{------------------------------------------------------------------------------}

function TLMDOpenedDocument.GetOpened: Boolean;
begin
  Result := (FNode <> nil);
end;
             
{------------------------------------------------------------------------------}

function TLMDOpenedDocument.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_IDE;
end;
               
{------------------------------------------------------------------------------}

function TLMDOpenedDocument.DoBeforeSave(const AFilePath: TLMDString): Boolean;
var
  cancel: Boolean;
begin
  Result := True;

  if Assigned(FOnBeforeSave) then
  begin
    cancel := False;
    FOnBeforeSave(Self, AFilePath, cancel);

    Result := not cancel;
  end;
end;
                 
{------------------------------------------------------------------------------}

procedure TLMDOpenedDocument.DoAfterSave(const AFilePath: TLMDString);
begin
  if Assigned(FOnAfterSave) then
    FOnAfterSave(Self, AFilePath);
end;
               
{------------------------------------------------------------------------------}

function TLMDOpenedDocument.DoSaveFile(const AFileIdent: TLMDString;
  AFileStream: TStream): Boolean;
var
  s: TLMDString;
begin
  Result := False;
  if Assigned(FOnSaveFile) then
  begin
    s := AFileIdent;         // C++ bug workaround. UnicodeString::UnicodeString
    SetLength(s, Length(s)); // constructor in dstring.cpp does not check for
                             // RefCount == -1 condition. QC buf: #111495.

    FOnSaveFile(Self, s, AFileStream, Result);
  end;
end;
                
{------------------------------------------------------------------------------}

procedure TLMDOpenedDocument.DoClose;
begin
  if Assigned(FOnClose) then
    FOnClose(Self)
  else
    MarkClosed;
end;
                  
{------------------------------------------------------------------------------}

procedure TLMDOpenedDocument.DoShow;
begin
  FEditorVisible := True;
  if Opened and (FNode.FProjMgr.FEditorsView <> nil) then
    FNode.FProjMgr.FEditorsView.ShowEditor(Self);

  if Assigned(FOnShow) then
    FOnShow(Self);
end;
                     
{------------------------------------------------------------------------------}

constructor TLMDOpenedDocument.Create(AOwner: TComponent);
begin
  inherited;
end;
                      
{------------------------------------------------------------------------------}

destructor TLMDOpenedDocument.Destroy;
begin
  AssociateNode(nil);
  inherited;
end;
               
{------------------------------------------------------------------------------}

procedure TLMDOpenedDocument.MarkClosed;
begin
  AssociateNode(nil);
end;
              
{------------------------------------------------------------------------------}

procedure TLMDProjDocument.LoadFromXml(const AFilePath: TLMDString);
var
  stream: TStream;
  xml:    ILMDXmlDocument;
begin
  stream := FProjMgr.CreateStream(AFilePath, skRead);
  try
    xml := LMDLoadXmlDocument(stream);

    Assert(LMDSameText(xml.DocumentElement.NodeName, Ident),
           'Wrong main XML document node name.');
    DoRead(xml.DocumentElement, False);
  finally
    stream.Free;
  end;
end;

procedure TLMDProjDocument.SaveToXml(const AFilePath: TLMDString);
var
  mstr: TMemoryStream;
  rstr: TStream;
  xml:  ILMDXmlDocument;
begin
  mstr := TMemoryStream.Create; // Use in-memory stream to prevent
                                // existing file damage in error case.
  try
    xml := LMDCreateXmlDocument(Ident, '1.0', 'utf-8');
    DoWrite(xml.DocumentElement, False);
    xml.Save(mstr);

    rstr := FProjMgr.CreateStream(AFilePath, skWrite);
    try
      mstr.SaveToStream(rstr);
    finally
      rstr.Free;
    end;
  finally
    mstr.Free;
  end;
end;

{ TLMDProjectManagerView }

procedure TLMDProjectManagerView.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

constructor TLMDProjectManagerView.Create(AOwner: TComponent);
begin
  inherited;
  ReadOnly := True;
  Images   := DummyImageList;

  OnAdvancedCustomDrawItem := DummyDrawHandler; // The way to tell tree view
                                                // that it is custom-drawn.
                                                // Compatible with Delphi5.
end;

procedure TLMDProjectManagerView.CreateHandle;
begin
  inherited;
  UpdateView;
end;

function TLMDProjectManagerView.CreateNode: TTreeNode;
begin
  Result := TProjViewNode.Create(Items);
  Result.ImageIndex    := -1;
  Result.SelectedIndex := -1;
end;

destructor TLMDProjectManagerView.Destroy;
begin
  ProjectManager := nil;
  inherited;
end;

procedure TLMDProjectManagerView.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then
    UpdateView;
end;

function TLMDProjectManagerView.GetSelectedDoc: TLMDProjDocument;
var
  nd: TLMDProjNode;
begin
  nd := GetSelected;
  if nd is TLMDProjDocument then
    Result := TLMDProjDocument(nd)
  else
    Result := nil;
end;

function TLMDProjectManagerView.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_IDE;
end;

function TLMDProjectManagerView.GetSelected: TLMDProjNode;
var
  treend: TTreeNode;
begin
  treend := inherited Selected;
  if treend <> nil then
    Result := TProjViewNode(treend).FProjNode
  else
    Result := nil;
end;

procedure TLMDProjectManagerView.SetProjectManager(
  const Value: TLMDProjectManager);
begin
  if FProjectManager <> Value then
  begin
    if FProjectManager <> nil then
      FProjectManager.FViews.Remove(Self);
    FProjectManager := Value;
    if FProjectManager <> nil then
      FProjectManager.FViews.Add(Self);
    UpdateView;
  end;
end;

procedure TLMDProjectManagerView.UpdateView;

  procedure _UpdateOrDelNode(ANode: TTreeNode);
  var
    projnd:  TLMDProjNode;
  begin
    projnd := TProjViewNode(ANode).FProjNode;
    if projnd = nil then
      ANode.Delete
    else
      ANode.Text := projnd.DisplayName;
  end;

  procedure _EnsureNode(ANode: TLMDProjNode; AParent: TTreeNode);
  var
    treend: TTreeNode;
    i:      Integer;
  begin
    if not ANode.FDestroying then
    begin
      treend := ANode.GetTreeNode(Self);
      if treend = nil then
      begin
        treend := Items.AddChild(AParent, ANode.DisplayName);
        ANode.SetTreeNode(Self, treend);
      end;

      for i := 0 to ANode.NodeCount - 1 do
        _EnsureNode(ANode.Nodes[i], treend);
    end;
  end;

var
  i: Integer;
begin
  if not HandleAllocated then
    Exit;

  Items.BeginUpdate;
  try
    if (FProjectManager = nil) or (FProjectManager.Root = nil) then
      Items.Clear
    else
    begin
      for i := Items.Count - 1 downto 0 do
        _UpdateOrDelNode(Items[i]);

      _EnsureNode(FProjectManager.Root, nil);
    end;

    if Items.GetFirstNode <> nil then
      Items.GetFirstNode.Expand(False);
  finally
    Items.EndUpdate;
  end;
end;

function TLMDProjectManagerView.ConvertTreeNode(
  ATreeNode: TTreeNode): TLMDProjNode;
begin
  if ATreeNode is TProjViewNode then
    Result := TProjViewNode(ATreeNode).FProjNode
  else
    Result := nil;
end;

procedure TLMDProjectManagerView.DblClick;
var
  p:    TPoint;
  //svc:  ILMDObjEditService;
begin
  { Send command to component-editors service }

  GetCursorPos(p);
  p := ScreenToClient(p);

  if htOnItem in GetHitTestInfoAt(p.X, p.Y) then
  begin
    //svc := nil;
    //if (FServiceProvider <> nil) and
    //   (ctsoUseObjEditService in FServiceOptions) then
    //  svc := ILMDObjEditService(FServiceProvider.Services.Find(
    //                            LMDObjEditService_ID));

    //if (svc <> nil) and (Selection.Count = 1) then
    //  svc.DblClicked(Self, Selection[0]);
  end;

  { Fire event }

  inherited;
end;

procedure TLMDProjectManagerView.WMLButtonDblClk(
  var Message: TWMLButtonDblClk);
begin
  FDblClicking := (htOnItem in GetHitTestInfoAt(Message.XPos, Message.YPos));
  try
    inherited;
  finally
    FDblClicking := False;
  end;
end;

function TLMDProjectManagerView.CanCollapse(Node: TTreeNode): Boolean;
begin
  Result := not FDblClicking;
  if Result then
    Result := inherited CanCollapse(Node);
end;

function TLMDProjectManagerView.CanExpand(Node: TTreeNode): Boolean;
begin
  Result := not FDblClicking;
  if Result then
    Result := inherited CanExpand(Node);
end;

procedure TLMDProjectManagerView.DummyDrawHandler(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
  var PaintImages, DefaultDraw: Boolean);
begin
  // Do nothing.
end;

function TLMDProjectManagerView.CustomDrawItem(Node: TTreeNode;
  State: TCustomDrawState; Stage: TCustomDrawStage;
  var PaintImages: Boolean): Boolean;
var
  r:    TRect;
  prnd: TLMDProjNode;
begin
  if Stage = cdPostPaint then
  begin
    Result      := False;
    PaintImages := False;

    prnd := TProjViewNode(Node).FProjNode;
    r    := Node.DisplayRect(True);
    r    := Rect(r.Left - 16, r.Top, r.Left + 1, r.Bottom);

    if prnd <> nil then
      prnd.DrawImage(Canvas, r);
  end
  else
    Result := True;
end;

{ TProjViewNode }

destructor TProjViewNode.Destroy;
begin
  if FProjNode <> nil then
    FProjNode.SetTreeNode(TreeView, nil);
  inherited;
end;

procedure TLMDProjNode.SetTreeNode(ATreeView: TCustomTreeView;
  ANode: TTreeNode);
var
  i, idx: Integer;
begin
  idx := -1;
  for i := 0 to FTreeNodes.Count - 1 do
    if TProjViewNode(FTreeNodes[i]).TreeView = ATreeView then
    begin
      idx := i;
      Break; // for
    end;

  if ANode = nil then // Delete
  begin
    if idx <> -1 then
    begin
      TProjViewNode(FTreeNodes[idx]).FProjNode := nil;
      FTreeNodes.Delete(idx);
    end;
  end
  else if idx = -1 then // Add
  begin
    FTreeNodes.Add(ANode);
    TProjViewNode(ANode).FProjNode := Self;
  end
  else if FTreeNodes[idx] <> ANode then // Replace
  begin
    TProjViewNode(FTreeNodes[idx]).FProjNode := nil;
    TProjViewNode(ANode).FProjNode           := Self;
    FTreeNodes[idx]                          := ANode;
  end;
end;

procedure TLMDProjNode.ClearTreeNodes;
var
  i: Integer;
begin
  for i := 0 to FTreeNodes.Count - 1 do
    TProjViewNode(FTreeNodes[i]).FProjNode := nil;
  FTreeNodes.Clear;
end;

function TLMDProjNode.GetTreeNode(ATreeView: TCustomTreeView): TTreeNode;
var
  i: Integer;
begin
  for i := 0 to FTreeNodes.Count - 1 do
    if TTreeNode(FTreeNodes[i]).TreeView = ATreeView then
    begin
      Result := TTreeNode(FTreeNodes[i]);
      Exit;
    end;

  Result := nil;
end;

procedure TLMDProjectManager.DissociateViews;
begin
  while FViews.Count > 0 do
    TLMDProjectManagerView(FViews[0]).ProjectManager := nil;
end;

procedure TLMDProjectManager.UpdateViews;
var
  i: Integer;
begin
  for i := 0 to FViews.Count - 1 do
    TLMDProjectManagerView(FViews[i]).UpdateView;
end;

procedure TLMDProjNode.DoRead(AElem: ILMDXmlElement;
  AIsParentXml: Boolean);
begin
  // Do nothing.
end;

procedure TLMDProjNode.DoWrite(AElem: ILMDXmlElement;
  AIsParentXml: Boolean);
begin
  // Do nothing.
end;

procedure TLMDProjNode.UpdateViews;
begin
  FProjMgr.UpdateViews;
  if FProjMgr.FEditorsView <> nil then
    FProjMgr.FEditorsView.UpdateView;
end;

procedure TLMDProjNode.DrawImage(ACanvas: TCanvas; const ARect: TRect);
begin
  // Do nothing.
end;

{ TLMDDocEditorsView }

procedure TLMDDocEditorsView.FreeEditor(ADocument: TLMDOpenedDocument);
var
  item: TLMDDocEditorsViewItem;
begin
  item := FEditors.Find(ADocument);
  if item <> nil then
    item.Delete;
end;

function TLMDDocEditorsView.ContainsFocus: Boolean;
var
  wnd: HWND;
begin
  if HandleAllocated then
  begin
    wnd := GetFocus;
    while wnd <> 0 do
    begin
      if wnd = WindowHandle then
      begin
        Result := True;
        Exit;
      end;
      wnd := GetParent(wnd);
    end;
  end;
  Result := False;
end;

constructor TLMDDocEditorsView.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle            := ControlStyle - [csAcceptsControls, csSetCaption];
  {$IFDEF LMDCOMP7}
  ParentBackground        := False;
  {$ENDIF}
  Width                   := 100;
  Height                  := 100;
  BevelOuter              := bvNone;
  BorderStyle             := bsSingle;
  FTabHeight              := 18;
  FTabs                   := TEditorTabControl.Create(Self);
  FTabs.Parent            := Self;
  FClientPanel            := TEditorClientPanel.Create(Self);
  FClientPanel.Parent     := Self;
  FClientPanel.BevelOuter := bvNone;
  FEditors                := TLMDDocEditorsViewEditors.Create(Self);
end;

procedure TLMDDocEditorsView.CreateHandle;
begin
  inherited;
  UpdateView;
end;

destructor TLMDDocEditorsView.Destroy;
begin
  Destroying;
  FEditors.DeleteAll;
  
  FTabs.Free;
  FClientPanel.Free;
  FEditors.Free;
  inherited;
end;

function TLMDDocEditorsView.DoCreateEditor(
  ADocument: TLMDProjDocument): TCustomFrame;
begin
  Result := nil;
  if Assigned(FOnCreateEditor) then
    FOnCreateEditor(Self, ADocument, Result);
end;

procedure TLMDDocEditorsView.CreateEditor(AShowEditor: Boolean;
  AContext: TLMDProjDocOpenContext);
var
  i:      Integer;
  frame:  TCustomFrame;
  opedtr: TLMDOpenedDocument;
begin
  frame := DoCreateEditor(AContext.Document);
  try
    if frame <> nil then
    begin
      opedtr := nil;
      for i := 0 to frame.ComponentCount - 1 do
        if frame.Components[i] is TLMDOpenedDocument then
        begin
          opedtr := TLMDOpenedDocument(frame.Components[i]);
          Break; // for
        end;

      if opedtr = nil then
        raise ELMDProjectManager.Create(SLMDNoOpenedDocFound);

      frame.Visible := False;
      frame.Align   := alClient;
      frame.Parent  := FClientPanel;
      
      TLMDDocEditorsViewItem.Create(FEditors, AContext.Document.ProjMgr,
                                    opedtr, frame);
      AContext.Open(opedtr);
    end;
  except
    frame.Free;
    raise;
  end;

  UpdateView;
end;

procedure TLMDDocEditorsView.Resize;
begin
  UpdateView;
end;

procedure TLMDDocEditorsView.SetTabHeight(const Value: Integer);
begin
  FTabHeight := Value;
  UpdateView;
end;

procedure TLMDDocEditorsView.UpdateView;
var
  cr:         TRect;
  i:          Integer;
  visedtrs:   TList;
  item:       TLMDDocEditorsViewItem;
  tabidx:     Integer;
  acttab:     Integer;
  caption:    TLMDString;
  frame:      TCustomFrame;
begin
  if FUpdateCount > 0 then
  begin
    FNeedUpdate := True;
    Exit;
  end
  else
    FNeedUpdate := False;
    
  if not HandleAllocated then
    Exit;

  visedtrs := TList.Create;
  try
    { Create list of visible editors }

    for i := 0 to FEditors.Count - 1 do
    begin
      if FEditors[i].OpenedDocument.EditorVisible then
        visedtrs.Add(FEditors[i]);
    end;

    { Update layout }

    cr := ClientRect;

    if visedtrs.Count > 0 then
    begin
      FTabs.Visible   := True;
      FTabs.TabHeight := FTabHeight;
      FTabs.SetBounds(cr.Left, cr.Top, cr.Right - cr.Left + 2,
                      FTabHeight + 8);
      FClientPanel.SetBounds(cr.Left, cr.Top + FTabs.Height - 2,
                             cr.Right - cr.Left,
                             cr.Bottom - (cr.Top + FTabs.Height - 2));
    end
    else
    begin
      FTabs.Visible := False;
      FClientPanel.SetBounds(cr.Left, cr.Top, cr.Right - cr.Left,
                             cr.Bottom - cr.Top);
    end;

    { Update tabs }

    FTabs.Tabs.BeginUpdate;
    try
      for i := FTabs.Tabs.Count - 1 downto 0 do
      begin
        if visedtrs.IndexOf(FTabs.Tabs.Objects[i]) = -1 then
          FTabs.Tabs.Delete(i);
      end;

      acttab := -1;
      for i := 0 to visedtrs.Count - 1 do
      begin
        item    := TLMDDocEditorsViewItem(visedtrs[i]);
        tabidx  := FTabs.Tabs.IndexOfObject(visedtrs[i]);
        caption := DoGetTaName(item);

        if tabidx = -1 then
          FTabs.Tabs.AddObject(caption, item)
        else
          FTabs.Tabs[tabidx] := caption;

        if item = FActiveEditor then
          acttab := i;
      end;

      FTabs.TabIndex := acttab;
    finally
      FTabs.Tabs.EndUpdate;
    end;

    { Show active editor }

    frame := nil;
    if FActiveEditor <> nil then
      frame := FActiveEditor.Frame;

    if frame <> nil then
    begin
      frame.Align   := alClient;
      frame.Parent  := FClientPanel;
      frame.Visible := True;
    end;

    for i := 0 to FClientPanel.ControlCount - 1 do
    begin
      if (FClientPanel.Controls[i] <> frame) and
         (FClientPanel.Controls[i] is TCustomFrame) then
        FClientPanel.Controls[i].Visible := False;
    end;
  finally
    visedtrs.Free;
  end;
end;

procedure TLMDDocEditorsView.FreeMgrEditors(AProjMgr: TLMDProjectManager);
var
  i: Integer;
begin
  if not (csDestroying in ComponentState) then
  begin
    BeginUpdate;
    try
      for i := FEditors.Count - 1 downto 0 do
      begin
        if FEditors[i].ProjManager = AProjMgr then
          FreeEditor(FEditors[i].OpenedDocument);
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TLMDDocEditorsView.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TLMDDocEditorsView.EndUpdate;
begin
  Dec(FUpdateCount);
  if (FUpdateCount <= 0) and FNeedUpdate then
    UpdateView;
end;

procedure TLMDDocEditorsView.HideEditor(ADocument: TLMDOpenedDocument);
var
  item: TLMDDocEditorsViewItem;
begin
  item := FEditors.Find(ADocument);
  if item <> nil then
  begin
    if FActiveEditor = item then
      FActiveEditor := FindNearVisibleEditor(item);
    UpdateView;
  end;
end;

procedure TLMDDocEditorsView.ItemDestroying(AItem: TLMDDocEditorsViewItem);
var
  next: TLMDDocEditorsViewItem;
  frm:  TCustomForm;
begin
  if FEditors.FView.FActiveEditor = AItem then
  begin
    if ContainsFocus then
    begin
      frm := GetParentForm(Self);
      if frm <> nil then
        frm.ActiveControl := Self;
    end;
    next := FEditors.FView.FindNearVisibleEditor(AItem);
    FEditors.FView.FActiveEditor := next;
  end;
end;

procedure TLMDDocEditorsView.ShowEditor(ADocument: TLMDOpenedDocument);
var
  item: TLMDDocEditorsViewItem;
begin
  item := FEditors.Find(ADocument);
  if item <> nil then
    FActiveEditor := item;
  UpdateView;
end;

function TLMDDocEditorsView.DoGetTaName(
  AEditor: TLMDDocEditorsViewItem): TLMDString;
begin
  Result := AEditor.Node.DisplayName;
  if Assigned(FOnGetTabName) then
    FOnGetTabName(Self, AEditor, Result);
end;

function TLMDDocEditorsView.FindNearVisibleEditor(
  AItem: TLMDDocEditorsViewItem): TLMDDocEditorsViewItem;
var
  i:   Integer;
  idx: Integer;
begin
  idx := FEditors.IndexOf(AItem);
  for i := idx - 1 downto 0 do
    if FEditors[i].OpenedDocument.EditorVisible then
    begin
      Result := FEditors[i];
      Exit;
    end;

  for i := idx + 1 to FEditors.Count - 1 do
    if FEditors[i].OpenedDocument.EditorVisible then
    begin
      Result := FEditors[i];
      Exit;
    end;

  Result := nil;
end;

procedure TLMDDocEditorsView.TabChanged;
var
  tbidx: Integer;
  item:  TLMDDocEditorsViewItem;
begin
  tbidx := FTabs.TabIndex;
  if tbidx < 0 then
    FActiveEditor := nil
  else
  begin
    item := TLMDDocEditorsViewItem(FTabs.Tabs.Objects[tbidx]);
    if FEditors.IndexOf(item) = -1 then // Stale item doe to
                                        // BeginUpdate/EndUpdate.
      item := nil;
    FActiveEditor := item;
  end;

  UpdateView;
  DoChange;
end;

procedure TLMDDocEditorsView.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TLMDDocEditorsView.CreateParams(var Params: TCreateParams);
begin
  inherited;
  
  with Params do // As for csAcceptsControls.
  begin
    Style   := Style or WS_CLIPCHILDREN;
    ExStyle := ExStyle or WS_EX_CONTROLPARENT;
  end;
end;

{ TEditorTabControl }

procedure TEditorTabControl.Change;
begin
  if FView <> nil then
    FView.TabChanged;
end;

constructor TEditorTabControl.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csAcceptsControls];
  FView        := TLMDDocEditorsView(AOwner);
end;

{ TEditorClientPanel }

constructor TEditorClientPanel.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption];
end;

procedure TLMDOpenedDocument.SetEditorVisible(const Value: Boolean);
begin
  if FEditorVisible <> Value then
  begin
    if Value then
      DoShow
    else
      DoHide;
  end;
end;

procedure TLMDOpenedDocument.DoHide;
begin
  FEditorVisible := False;
  if Opened and (FNode.FProjMgr.FEditorsView <> nil) then
    FNode.FProjMgr.FEditorsView.HideEditor(Self);

  if Assigned(FOnHide) then
    FOnHide(Self);
end;

procedure TLMDProjectManager.SetEditorsView(
  const Value: TLMDDocEditorsView);
begin
  if FEditorsView <> Value then
  begin
    if FEditorsView <> nil then
    begin
      FEditorsView.FreeMgrEditors(Self);
      FEditorsView.RemoveFreeNotification(Self);
    end;
    FEditorsView := Value;
    if FEditorsView <> nil then
      FEditorsView.FreeNotification(Self);
  end;
end;

procedure TLMDProjectManager.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FEditorsView) then
    EditorsView := nil;
end;

procedure TLMDOpenedDocument.DoOpening(ADocument: TLMDProjDocument);
begin
  if Assigned(FOnOpening) then
    FOnOpening(Self, ADocument);
end;

{ TLMDDocEditorsViewItem }

procedure TLMDDocEditorsViewItem.Close;
begin
  FOpenedDocument.Node.Close;
end;

constructor TLMDDocEditorsViewItem.Create(
  AEditors: TLMDDocEditorsViewEditors; AProjManager: TLMDProjectManager;
  AOpenedDocument: TLMDOpenedDocument; AFrame: TCustomFrame);
begin
  inherited Create;

  FProjManager    := AProjManager;
  FOpenedDocument := AOpenedDocument;
  FFrame          := AFrame;
  
  FEditors        := AEditors;
  FEditors.FItems.Add(Self);
end;

procedure TLMDDocEditorsViewItem.Delete;
begin
  Destroy;
end;

destructor TLMDDocEditorsViewItem.Destroy;
begin
  FEditors.FView.ItemDestroying(Self);
  FEditors.FItems.Remove(Self);

  FFrame.Free;
  FEditors.FView.UpdateView;
  inherited;
end;

function TLMDDocEditorsViewItem.GetNode: TLMDProjDocument;
begin
  Result := FOpenedDocument.Node;
end;

{ TLMDDocEditorsViewEditors }

constructor TLMDDocEditorsViewEditors.Create(AView: TLMDDocEditorsView);
begin
  inherited Create;
  FView := AView;
  FItems := TList.Create;
end;

procedure TLMDDocEditorsViewEditors.DeleteAll;
begin
  FView.BeginUpdate;
  try
    while FItems.Count > 0 do
      TLMDDocEditorsViewItem(FItems[0]).Delete;
  finally
    FView.EndUpdate;
  end;
end;

destructor TLMDDocEditorsViewEditors.Destroy;
begin
  DeleteAll;
  FItems.Free;
  inherited;
end;

function TLMDDocEditorsViewEditors.Find(
  ADocument: TLMDOpenedDocument): TLMDDocEditorsViewItem;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    if TLMDDocEditorsViewItem(FItems[i]).FOpenedDocument = ADocument then
    begin
      Result := TLMDDocEditorsViewItem(FItems[i]);
      Exit;
    end;

  Result := nil;
end;

function TLMDDocEditorsViewEditors.Find(
  ANode: TLMDProjNode): TLMDDocEditorsViewItem;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    if TLMDDocEditorsViewItem(FItems[i]).OpenedDocument.Node = ANode then
    begin
      Result := TLMDDocEditorsViewItem(FItems[i]);
      Exit;
    end;
  Result := nil;
end;

function TLMDDocEditorsViewEditors.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TLMDDocEditorsViewEditors.GetItems(
  AIndex: Integer): TLMDDocEditorsViewItem;
begin
  Result := TLMDDocEditorsViewItem(FItems[AIndex]);
end;

function TLMDDocEditorsViewEditors.IndexOf(
  AItem: TLMDDocEditorsViewItem): Integer;
begin
  Result := FItems.IndexOf(AItem);
end;

procedure TLMDProjDocument.InternalSetFilePath(const AValue: TLMDString);
begin
  if FFilePath <> AValue then
  begin
    FFilePath := AValue;
    FProjMgr.DoFilePathChanged(Self);
  end;
end;

procedure TLMDProjectManager.DoFilePathChanged(
  ADocument: TLMDProjDocument);
begin
  if Assigned(FOnFilePathChanged) then
    FOnFilePathChanged(Self, ADocument);
end;

initialization
  DummyImageList := TImageList.Create(nil);
  {$IFDEF LMD_DEBUGTRACE}
    {$I C3.INC}
  {$ENDIF}

{------------------------------------------------------------------------------}

finalization
  FreeIdentByClassList;
  DummyImageList.Free;

{------------------------------------------------------------------------------}

end.
