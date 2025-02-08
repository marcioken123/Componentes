unit LMDDsgDiagram;
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

LMDDsgDiagram unit (YB)
------------------------
TLMDDiagram unit

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, ExtCtrls, Forms, Windows, Messages, StdCtrls, Graphics, Types,
  SysUtils, Dialogs, LMDUnicode, LMDDsgCst, LMDDsgClass, LMDTypes, intfLMDBase;

type
  ELMDDiagram = class(Exception);
  TLMDCustomDiagram = class;
  TLMDDiagramItem = class;

  TLMDDiagramItemName = type string; // Follow Vcl component naming
  TLMDDiagramItemRef  = type string; // rules. No special Unicode
                                     // support.


  { *************************** TLMDDiagramLink ****************************** }

  TLMDDiagramLink = class(TCollectionItem)
  private
    FDInfIndex    : Integer;
    FEndItemName  : TLMDDiagramItemRef;
    FBeginItemName: TLMDDiagramItemRef;
    FBeginItem    : TLMDDiagramItem;
    FEndItem      : TLMDDiagramItem;
    FColor        : TColor;
    FVisible      : Boolean;
    FData         : TLMDDataTag;

    procedure DoConnectItems;
    procedure SetBeginItemName(const Value: TLMDDiagramItemRef);
    procedure SetEndItemName(const Value: TLMDDiagramItemRef);
    procedure SetColor(const Value: TColor);
    procedure SetVisible(const Value: Boolean);
    function  GetSelected: Boolean;
    procedure SetSelected(const Value: Boolean);
  protected
    function  GetDisplayName: string; override;
    function  CanBeShown: Boolean; virtual;
    procedure DoAssign(ASource: TPersistent); virtual;
    procedure ConnectItems;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    property BeginItem: TLMDDiagramItem read FBeginItem;
    property EndItem: TLMDDiagramItem read FEndItem;
    property Data: TLMDDataTag read FData write FData;
    property Selected: Boolean read GetSelected write SetSelected;
  published
    property BeginItemName: TLMDDiagramItemRef read FBeginItemName write SetBeginItemName;
    property EndItemName: TLMDDiagramItemRef read FEndItemName write SetEndItemName;
    property Color: TColor read FColor write SetColor default clWindowText;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  TLMDDiagramLinkClass = class of TLMDDiagramLink;

  { ************************** TLMDDiagramLinks ****************************** }

  TLMDDiagramLinks = class(TCollection)
  private
    FDiagram: TLMDCustomDiagram;

    function  GetItem(Index: Integer): TLMDDiagramLink;
    procedure SetItem(Index: Integer; const Value: TLMDDiagramLink);
  protected
    function  GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(ADiagram: TLMDCustomDiagram); virtual;
    
    property Diagram: TLMDCustomDiagram read FDiagram;
    property Items[Index: Integer]: TLMDDiagramLink read GetItem write SetItem; default;
  end;

  { ************************ TLMDDiagramItemPanel **************************** }

  TLMDDiagramItemPanel = class(TCustomControl)
  private
    FItem: TLMDDiagramItem;

    function  GetCaption: TLMDString;
    procedure SetCaption(const Value: TLMDString);
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
    procedure WMNCLButtonDown(var Message: TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMSetFocus); message WM_KILLFOCUS;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure CMDrag(var Message: TCMDrag); message CM_DRAG;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DblClick; override;
    procedure Paint; override;
    procedure WndProc(var Message: TMessage); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer;
                      Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
  public
    constructor Create(AOwner: TComponent; AItem: TLMDDiagramItem); reintroduce; virtual;

    property Item: TLMDDiagramItem read FItem;
    property Caption: TLMDString read GetCaption write SetCaption;
    property Canvas;
  end;

  TLMDDiagramItemPanelClass = class of TLMDDiagramItemPanel;

  TLMDDiagramItemState = set of (isBoundsChanged, isCaptionChanged, isColorChanged,
    isVisibleChanged, isChangingBounds, isCreatingPanel);

  { *************************** TLMDDiagramItem ****************************** }

  TLMDDiagramItem = class(TCollectionItem)
  private
    FState  : TLMDDiagramItemState;
    FName   : TLMDDiagramItemName;
    FLeft   : Integer;
    FTop    : Integer;
    FWidth  : Integer;
    FHeight : Integer;
    FCaption: TLMDString;
    FPanel  : TLMDDiagramItemPanel;
    FVisible: Boolean;
    FColor  : TColor;
    FData   : TLMDDataTag;

    procedure CreatePanel;
    procedure FreePanel;
    procedure UpdateBounds;
    procedure UpdateDesigner;
    procedure SetHeight(const Value: Integer);
    procedure SetLeft(const Value: Integer);
    procedure SetTop(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    procedure SetCaption(const Value: TLMDString);
    procedure SetName(const Value: TLMDDiagramItemName);
    procedure SetVisible(const Value: Boolean);
    function  GetSelected: Boolean;
    procedure SetSelected(const Value: Boolean);
    procedure SetColor(const Value: TColor);
  protected
    function  GetDisplayName: string; override;
    function  GetPanelClass: TLMDDiagramItemPanelClass; virtual;
    procedure Update(var ARefreshLinks: Boolean); virtual;
    procedure ForceUpdate; virtual;
    procedure MakeUpdated; virtual;
    procedure DoAssign(ASource: TPersistent); virtual;
    procedure Select(ASelect: Boolean); virtual;
    procedure SetFocus; virtual;
    property  State: TLMDDiagramItemState read FState;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    procedure MakeVisible;
    property  Selected: Boolean read GetSelected write SetSelected;
    property  Data: TLMDDataTag read FData write FData;
    property  Panel: TLMDDiagramItemPanel read FPanel;
  published
    property Left: Integer read FLeft write SetLeft;
    property Top: Integer read FTop write SetTop;
    property Width: Integer read FWidth write SetWidth;
    property Height: Integer read FHeight write SetHeight;
    property Name: TLMDDiagramItemName read FName write SetName;
    property Caption: TLMDString read FCaption write SetCaption;
    property Color: TColor read FColor write SetColor default clBtnFace;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  TLMDDiagramItemClass = class of TLMDDiagramItem;

  { ************************** TLMDDiagramItems ****************************** }

  TLMDDiagramItems = class(TCollection)
  private
    FDiagram: TLMDCustomDiagram;

    function  GetItem(Index: Integer): TLMDDiagramItem;
    procedure SetItem(Index: Integer; const Value: TLMDDiagramItem);
    procedure ReconnectItems;
  protected
    function  GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
    procedure SetItemName(Item: TCollectionItem); override;
  public
    constructor Create(ADiagram: TLMDCustomDiagram); virtual;

    function IndexOf(AItem: TLMDDiagramItem): Integer;
    function Find(const AName: TLMDDiagramItemName): TLMDDiagramItem;
    property Diagram: TLMDCustomDiagram read FDiagram;
    property Items[Index: Integer]: TLMDDiagramItem read GetItem write SetItem; default;
  end;

  { ************************** TLMDLinkDrawInfo ****************************** }

  TLMDLinkDrawInfo = class
  end;

  { ************************ TLMDStdLinkDrawInfo ***************************** }

  TLMDStdLinkDrawInfo = class(TLMDLinkDrawInfo)
  public
    BeginP     : TPoint;
    EndP       : TPoint;
    LineBegin  : TPoint;
    LineEnd    : TPoint;
    LeftToRight: Boolean;
    Color      : TColor;
    Selected   : Boolean;
  end;

  TLMDLinkDrawInfoClass = class of TLMDLinkDrawInfo;

  TLMDLinkDrawInfoRec = record
    Link       : TLMDDiagramLink;
    DrawInfo   : TLMDLinkDrawInfo;
    OldDrawInfo: TLMDLinkDrawInfo;
  end;
  PLMDLinkDrawInfoRec = ^TLMDLinkDrawInfoRec;

  TLMDDiagramItemEvent = procedure(Sender: TObject; AItem: TLMDDiagramItem) of object;
  TLMDDiagramLinkEvent = procedure(Sender: TObject; ALink: TLMDDiagramLink) of object;

  TLMDDiagramState = set of (dsRefreshingLinks, dsChangingSelection,
    dsErasingLinks, dsLinksChanged, dsRepainted);

  { ************************** TLMDCustomDiagram ***************************** }

  TLMDCustomDiagram = class(TCustomPanel, ILMDComponent)
  private
    FAbout            : TLMDAboutVar;
    FState            : TLMDDiagramState;
    FLinkDInfs        : TList;
    FHScrollPos       : Integer;
    FVScrollPos       : Integer;
    FDiagramWidth     : Integer;
    FDiagramHeight    : Integer;
    FReadOnly         : Boolean;
    FLinks            : TLMDDiagramLinks;
    FItems            : TLMDDiagramItems;
    FSelectedItem     : TLMDDiagramItem;
    FSelectedLink     : TLMDDiagramLink;
    FOnChangeSelection: TNotifyEvent;
    FOnChange         : TNotifyEvent;
    FScrollBars       : TScrollStyle;
    FThumbTrack       : Boolean;
    FItemAutoPos      : Boolean;
    FOnInsertItem     : TLMDDiagramItemEvent;
    FOnDeleteItem     : TLMDDiagramItemEvent;
    FOnInsertLink     : TLMDDiagramLinkEvent;
    FOnDeleteLink     : TLMDDiagramLinkEvent;
    
    function CalcItemPos(AWidth, AHeight: Integer): TPoint;
    procedure UpdateScrollBars;
    function IsActiveControl: Boolean;
    procedure FreeLinkDInfs(AInfs: TList);
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure SetDiagramHeight(const Value: Integer);
    procedure SetDiagramWidth(const Value: Integer);
    procedure SetLinks(const Value: TLMDDiagramLinks);
    procedure SetItems(const Value: TLMDDiagramItems);
    procedure SetSelectedItem(const Value: TLMDDiagramItem);
    procedure SetSelectedLink(const Value: TLMDDiagramLink);
    procedure SetHScrollPos(const Value: Integer);
    procedure SetVScrollPos(const Value: Integer);
    procedure SetScrollBars(const Value: TScrollStyle);
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  protected
    procedure EraseLinks;
    procedure Paint; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateHandle; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure WndProc(var Message: TMessage); override;
    procedure Resize; override;
    function GetLinkClass: TLMDDiagramLinkClass; virtual;
    function CreateLinks: TLMDDiagramLinks; virtual;
    function GetItemClass: TLMDDiagramItemClass; virtual;
    function CreateItems: TLMDDiagramItems; virtual;
    function GetLinkDrawInfoClass: TLMDLinkDrawInfoClass; virtual;
    function CreateLinkDrawInfo(ALink: TLMDDiagramLink): TLMDLinkDrawInfo; virtual;
    function IsEqualDrawInfos(ADrawInfo1, ADrawInfo2: TLMDLinkDrawInfo): Boolean; virtual;
    function IsOnLink(ADrawInfo: TLMDLinkDrawInfo; AX, AY: Integer): Boolean; virtual;
    procedure PaintLink(ADrawInfo: TLMDLinkDrawInfo; AClear: Boolean); virtual;
    procedure PaintItem(APanel: TLMDDiagramItemPanel); virtual;
    procedure ChangeSelection; virtual;
    procedure Change; virtual;
    procedure ItemInsert(AItem: TLMDDiagramItem); virtual;
    procedure ItemDelete(AItem: TLMDDiagramItem); virtual;
    procedure LinkInsert(ALink: TLMDDiagramLink); virtual;
    procedure LinkDelete(ALink: TLMDDiagramLink); virtual;

    property State: TLMDDiagramState read FState;
    property ItemAutoPos: Boolean read FItemAutoPos write FItemAutoPos default True;
    property SelectedItem: TLMDDiagramItem read FSelectedItem write SetSelectedItem;
    property SelectedLink: TLMDDiagramLink read FSelectedLink write SetSelectedLink;
    property ScrollBars: TScrollStyle read FScrollBars write SetScrollBars default ssBoth;
    property HScrollPos: Integer read FHScrollPos write SetHScrollPos;
    property VScrollPos: Integer read FVScrollPos write SetVScrollPos;
    property ThumbTrack: Boolean read FThumbTrack write FThumbTrack default False;
    property DiagramWidth: Integer read FDiagramWidth write SetDiagramWidth;
    property DiagramHeight: Integer read FDiagramHeight write SetDiagramHeight;
    property Links: TLMDDiagramLinks read FLinks write SetLinks;
    property Items: TLMDDiagramItems read FItems write SetItems;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChangeSelection: TNotifyEvent read FOnChangeSelection write FOnChangeSelection;
    property OnInsertItem: TLMDDiagramItemEvent read FOnInsertItem write FOnInsertItem;
    property OnDeleteItem: TLMDDiagramItemEvent read FOnDeleteItem write FOnDeleteItem;
    property OnInsertLink: TLMDDiagramLinkEvent read FOnInsertLink write FOnInsertLink;
    property OnDeleteLink: TLMDDiagramLinkEvent read FOnDeleteLink write FOnDeleteLink;
    property BorderStyle default bsSingle;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ScrollBy(ADeltaX, ADeltaY: Integer);
    procedure RefreshLinks;
    function LinkAtPos(AX, AY: Integer): TLMDDiagramLink;
    function ItemRect(AIndex: Integer): TRect;
    function ItemAtPos(AX, AY: Integer): TLMDDiagramItem;

    property DragMode;
    property TabStop default True;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored false;
  end;

type
  TLMDDiagramOnPaintItem = procedure(Sender: TObject; APanel: TLMDDiagramItemPanel) of object;
  TLMDDiagramOnCreateLinkDrawInfo = procedure(Sender: TObject; ALink: TLMDDiagramLink;
    var ADrawInfo: TLMDLinkDrawInfo) of object;
  TLMDDiagramOnIsEqualDrawInfos = procedure (Sender: TObject; ADrawInfo1,
    ADrawInfo2: TLMDLinkDrawInfo; var AIsEqual: Boolean) of object;
  TLMDDiagramOnIsOnLink = procedure(Sender: TObject; ADrawInfo: TLMDLinkDrawInfo;
    AX, AY: Integer; var AIsOnLink: Boolean) of object;
  TLMDDiagramOnPaintLink = procedure(Sender: TObject; ADrawInfo: TLMDLinkDrawInfo;
    AClear: Boolean) of object;

  { ***************************** TLMDDiagram ******************************** }

  TLMDDiagram = class(TLMDCustomDiagram)
  private
    FOnPaintItem         : TLMDDiagramOnPaintItem;
    FCustomDrawItems     : Boolean;
    FCustomDrawLinks     : Boolean;
    FOnCreateLinkDrawInfo: TLMDDiagramOnCreateLinkDrawInfo;
    FOnIsEqualDrawInfos  : TLMDDiagramOnIsEqualDrawInfos;
    FOnIsOnLink          : TLMDDiagramOnIsOnLink;
    FOnPaintLink         : TLMDDiagramOnPaintLink;
    procedure SetCustomDrawItems(const Value: Boolean);
    procedure SetCustomDrawLinks(const Value: Boolean);
  protected
    function CreateLinkDrawInfo(ALink: TLMDDiagramLink): TLMDLinkDrawInfo; override;
    function IsEqualDrawInfos(ADrawInfo1, ADrawInfo2: TLMDLinkDrawInfo): Boolean; override;
    function IsOnLink(ADrawInfo: TLMDLinkDrawInfo; AX, AY: Integer): Boolean; override;
    procedure PaintLink(ADrawInfo: TLMDLinkDrawInfo; AClear: Boolean); override;
    procedure PaintItem(APanel: TLMDDiagramItemPanel); override;
  public
    property Canvas;
    property SelectedItem;
    property SelectedLink;
    property HScrollPos;
    property VScrollPos;
  published
    property CustomDrawItems: Boolean read FCustomDrawItems write SetCustomDrawItems default False;
    property CustomDrawLinks: Boolean read FCustomDrawLinks write SetCustomDrawLinks default False;
    property OnPaintItem: TLMDDiagramOnPaintItem read FOnPaintItem write FOnPaintItem;
    property OnCreateLinkDrawInfo: TLMDDiagramOnCreateLinkDrawInfo read FOnCreateLinkDrawInfo write FOnCreateLinkDrawInfo;
    property OnIsEqualDrawInfos: TLMDDiagramOnIsEqualDrawInfos read FOnIsEqualDrawInfos write FOnIsEqualDrawInfos;
    property OnIsOnLink: TLMDDiagramOnIsOnLink read FOnIsOnLink write FOnIsOnLink;
    property OnPaintLink: TLMDDiagramOnPaintLink read FOnPaintLink write FOnPaintLink;
    property ItemAutoPos;
    property ScrollBars;
    property DiagramWidth;
    property DiagramHeight;
    property Links;
    property Items;
    property ReadOnly;
    property ThumbTrack;
    property OnChange;
    property OnChangeSelection;
    property OnInsertItem;
    property OnDeleteItem;
    property OnInsertLink;
    property OnDeleteLink;
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
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
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses
  LMDUnicodeControl;

{$IFDEF LMD_DEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

const
  LMDRectSize = 14;

{ ************************* class TLMDDiagramLink **************************** }
{ ------------------------------ private ------------------------------------- }
procedure TLMDDiagramLink.DoConnectItems;
begin
  if BeginItemName <> '' then
    FBeginItem := TLMDDiagramLinks(Collection).Diagram.Items.Find(BeginItemName)
  else
    FBeginItem := nil;
  if EndItemName <> '' then
    FEndItem := TLMDDiagramLinks(Collection).Diagram.Items.Find(EndItemName)
  else
    FEndItem := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramLink.SetBeginItemName(const Value: TLMDDiagramItemRef);
begin
  if FBeginItemName <> Value then
    begin
      FBeginItemName := Value;
      DoConnectItems;
      TLMDDiagramLinks(Collection).Diagram.Change;
      Changed(False);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramLink.SetEndItemName(const Value: TLMDDiagramItemRef);
begin
  if FEndItemName <> Value then
    begin
      FEndItemName := Value;
      DoConnectItems;
      TLMDDiagramLinks(Collection).Diagram.Change;
      Changed(False);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramLink.SetColor(const Value: TColor);
begin
  if FColor <> Value then
    begin
      FColor := Value;
      TLMDDiagramLinks(Collection).Diagram.Change;
      Changed(False);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramLink.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
    begin
      FVisible := Value;
      TLMDDiagramLinks(Collection).Diagram.Change;
      Changed(False);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDiagramLink.GetSelected: Boolean;
begin
  Result := (TLMDDiagramLinks(Collection).Diagram.SelectedLink = Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramLink.SetSelected(const Value: Boolean);
begin
  if Value then
    TLMDDiagramLinks(Collection).Diagram.SelectedLink := Self
  else if TLMDDiagramLinks(Collection).Diagram.SelectedLink = Self then
    TLMDDiagramLinks(Collection).Diagram.SelectedLink := nil;
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDDiagramLink.GetDisplayName: string;
begin
  if (FBeginItem <> nil) or (FEndItem <> nil) then
    Result := Format('{%s}-{%s}', [FBeginItemName, FEndItemName])
  else
    Result := inherited GetDisplayName;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDiagramLink.CanBeShown: Boolean;
begin
  Result := (BeginItem <> nil) and (BeginItem.Panel <> nil) and
    (EndItem <> nil) and (EndItem.Panel <> nil) and
    BeginItem.Visible and EndItem.Visible and Visible;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramLink.DoAssign(ASource: TPersistent);
begin
  FEndItemName := TLMDDiagramLink(ASource).FEndItemName;
  FBeginItemName := TLMDDiagramLink(ASource).FBeginItemName;
  DoConnectItems;
  FColor := TLMDDiagramLink(ASource).FColor;
  FVisible := TLMDDiagramLink(ASource).FVisible;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramLink.ConnectItems;
begin
  DoConnectItems;
  Changed(False);
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDDiagramLink.Create(Collection: TCollection);
begin
  inherited;
  FColor := clWindowText;
  FDInfIndex := -1;
  FVisible := True;
  TLMDDiagramLinks(Collection).Diagram.LinkInsert(Self);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDiagramLink.Destroy;
var
  diag: TLMDCustomDiagram;
begin
  diag := TLMDDiagramLinks(Collection).Diagram;

  diag.LinkDelete(Self);
  if diag.SelectedLink = Self then
    diag.SelectedLink := nil;

  if FDInfIndex <> -1 then
  begin
    PLMDLinkDrawInfoRec(diag.FLinkDInfs[FDInfIndex]).Link := nil;
    FDInfIndex := -1;
  end;
  
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramLink.Assign(Source: TPersistent);
begin
  if Source is TLMDDiagramLink then
    begin
      DoAssign(Source);
      TLMDDiagramLinks(Collection).Diagram.Change;
      Changed(False);
    end
  else
    inherited;
end;

{ ************************ class TLMDDiagramLinks **************************** }
{ ------------------------------ private ------------------------------------- }
function TLMDDiagramLinks.GetItem(Index: Integer): TLMDDiagramLink;
begin
  Result := TLMDDiagramLink(inherited Items[Index]);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramLinks.SetItem(Index: Integer; const Value: TLMDDiagramLink);
begin
  inherited Items[Index] := Value;
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDDiagramLinks.GetOwner: TPersistent;
begin
  Result := FDiagram;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramLinks.Update(Item: TCollectionItem);
begin
  Diagram.RefreshLinks;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDDiagramLinks.Create(ADiagram: TLMDCustomDiagram);
begin
  inherited Create(ADiagram.GetLinkClass);
  FDiagram := ADiagram;
end;

{ ********************** class TLMDDiagramItemPanel ************************** }
{ ------------------------------ private ------------------------------------- }
function TLMDDiagramItemPanel.GetCaption: TLMDString;
begin
  Result := LMDGetControlText(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemPanel.SetCaption(const Value: TLMDString);
begin
  LMDSetControlText(Self, Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemPanel.WMNCHitTest(var Message: TWMNCHitTest);
var
  LDiagram: TLMDCustomDiagram;
begin
  DefaultHandler(Message);
  if (Item <> nil) then
  begin
    LDiagram := TLMDDiagramItems(Item.Collection).Diagram;
    if LDiagram.ReadOnly then
      case Message.Result of
        HTBORDER,
        HTBOTTOM,
        HTBOTTOMLEFT,
        HTBOTTOMRIGHT,
        HTCAPTION,
        HTLEFT,
        HTRIGHT,
        HTTOP,
        HTTOPLEFT,
        HTTOPRIGHT:
          Message.Result := HTCLIENT;
      end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemPanel.WMContextMenu(var Message: TWMContextMenu);
var
  LDiagram: TLMDCustomDiagram;
begin
  if Item <> nil then
    begin
      LDiagram := TLMDDiagramItems(Item.Collection).Diagram;
      if LDiagram.HandleAllocated then
        begin
          Message.hWnd := LDiagram.Handle;
          LDiagram.Dispatch(Message);
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemPanel.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  inherited;
  Msg.Result := Msg.Result or DLGC_WANTTAB;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemPanel.WMSize(var Message: TWMSize);
begin
  inherited;
  if Item <> nil then Item.UpdateBounds;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemPanel.WMMove(var Message: TWMMove);
begin
  inherited;
  if Item <> nil then Item.UpdateBounds;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemPanel.WMNCLButtonDown(var Message: TWMNCLButtonDown);
begin
  if Item <> nil then
    begin
      TLMDDiagramItems(Item.Collection).FDiagram.SelectedItem := Item;
      Item.SetFocus;
    end;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemPanel.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  Repaint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemPanel.WMKillFocus(var Message: TWMSetFocus);
begin
  inherited;
  Repaint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemPanel.WMLButtonDown(var Message: TWMLButtonDown);
var
  LShiftState: TShiftState;
begin
  inherited;
  LShiftState := KeysToShiftState(Message.Keys);
  if (TLMDDiagramItems(Item.Collection).Diagram.DragMode = dmAutomatic) and
    not ((ssCtrl in LShiftState) or (ssShift in LShiftState)) then
    TLMDDiagramItems(Item.Collection).Diagram.BeginDrag(False);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemPanel.CMDrag(var Message: TCMDrag);
begin
  if (Message.DragMessage = dmFindTarget) and (Item <> nil) then
    Message.Result := LRESULT(TLMDDiagramItems(Item.Collection).Diagram)
  else
    inherited;
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDDiagramItemPanel.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    begin
      Style := Style or WS_CAPTION or WS_THICKFRAME;
      ExStyle := ExStyle or WS_EX_TOOLWINDOW;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemPanel.CreateWindowHandle(
  const Params: TCreateParams);
begin
  LMDCreateControlHandle(Self, Params, '');
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemPanel.DblClick;
begin
  if Item <> nil then
    TLMDDiagramItems(Item.Collection).Diagram.DblClick;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemPanel.Paint;
begin
  if Item <> nil then
    TLMDDiagramItems(Item.Collection).Diagram.PaintItem(Self)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemPanel.WndProc(var Message: TMessage);
var
  LForm: TCustomForm;
  LDiagram: TLMDCustomDiagram;
  LMouseMsg: TWMMouse;
begin
  if (Message.Msg = WM_SETFOCUS) and (Item <> nil) then
  begin
    LDiagram := TLMDDiagramItems(Item.Collection).Diagram;
    LForm    := GetParentForm(LDiagram);

    if (LForm = nil) or LForm.SetFocusedControl(LDiagram) then
      Dispatch(Message);
  end
  else if not (csDesigning in ComponentState) and
          ((Message.Msg = WM_LBUTTONDOWN) or
           (Message.Msg = WM_LBUTTONDBLCLK)) and
          not TLMDDiagramItems(Item.Collection).Diagram.Dragging and
         (TLMDDiagramItems(Item.Collection).Diagram.DragMode = dmAutomatic) then
  begin
    LMouseMsg := TWMMouse(Message);

    if not IsControlMouseMsg(LMouseMsg) then
    begin
      ControlState := ControlState + [csLButtonDown];
      Dispatch(Message);
    end;
  end
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemPanel.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  p:   TPoint;
  dgm: TLMDCustomDiagram;
begin
  inherited;
  if Item <> nil then
  begin
    p   := Point(X, Y);
    dgm := TLMDDiagramItems(Item.Collection).Diagram;

    MapWindowPoints(Handle, dgm.Handle, p, 1);
    dgm.MouseDown(Button, Shift, p.X, p.Y);

    TLMDDiagramItems(Item.Collection).Diagram.SelectedItem := Item;
    Item.SetFocus;
  end;
end;

procedure TLMDDiagramItemPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  p:   TPoint;
  dgm: TLMDCustomDiagram;
begin
  inherited;
  if Item <> nil then
  begin
    p   := Point(X, Y);
    dgm := TLMDDiagramItems(Item.Collection).Diagram;

    MapWindowPoints(Handle, dgm.Handle, p, 1);
    dgm.MouseMove(Shift, p.X, p.Y);
  end;
end;

procedure TLMDDiagramItemPanel.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  p:   TPoint;
  dgm: TLMDCustomDiagram;
begin
  inherited;
  if Item <> nil then
  begin
    p   := Point(X, Y);
    dgm := TLMDDiagramItems(Item.Collection).Diagram;

    MapWindowPoints(Handle, dgm.Handle, p, 1);
    dgm.MouseDown(Button, Shift, p.X, p.Y);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemPanel.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Item <> nil then
    TLMDDiagramItems(Item.Collection).Diagram.KeyDown(Key, Shift);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemPanel.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if Item <> nil then
    TLMDDiagramItems(Item.Collection).Diagram.KeyUp(Key, Shift);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemPanel.KeyPress(var Key: Char);
begin
  if Item <> nil then
    TLMDDiagramItems(Item.Collection).Diagram.KeyPress(Key);
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDDiagramItemPanel.Create(AOwner: TComponent; AItem: TLMDDiagramItem);
begin
  inherited Create(AOwner);
  FItem := AItem;
  ParentFont := True; // Get Font from diagram.
  ControlStyle := ControlStyle - [csSetCaption, csAcceptsControls];
end;

{ ************************* class TLMDDiagramItem **************************** }
{ ------------------------------ private ------------------------------------- }
procedure TLMDDiagramItem.CreatePanel;
begin
  if FPanel = nil then
    begin
      Include(FState, isCreatingPanel);
      try
        FPanel := GetPanelClass.Create(TLMDDiagramItems(Collection).Diagram, Self);
        FPanel.Parent := TLMDDiagramItems(Collection).Diagram;
        ForceUpdate;
      finally
        Exclude(FState, isCreatingPanel);
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItem.FreePanel;
begin
  if FPanel <> nil then
    begin
      FPanel.Free;
      FPanel := nil;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItem.UpdateBounds;
var
  LNewLeft, LNewTop, LNewWidth, LNewHeight: Integer;
begin
  if not (isChangingBounds in FState) and not (isCreatingPanel in FState) and
    (FPanel <> nil) then
    begin
      LNewLeft := FPanel.Left + TLMDDiagramItems(Collection).FDiagram.FHScrollPos;
      LNewTop := FPanel.Top + TLMDDiagramItems(Collection).FDiagram.FVScrollPos;
      LNewWidth := FPanel.Width;
      LNewHeight := FPanel.Height;
      if (FLeft <> LNewLeft) or (FTop <> LNewTop) or (FWidth <> LNewWidth) or
        (FHeight <> LNewHeight) then
        begin
          FLeft := LNewLeft;
          FTop := LNewTop;
          FWidth := LNewWidth;
          FHeight := LNewHeight;
          Include(FState, isBoundsChanged);

          TLMDDiagramItems(Collection).Diagram.Change;
          Changed(False);

          UpdateDesigner;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItem.UpdateDesigner;
var
  LForm: TCustomForm;
begin
  if csDesigning in TLMDDiagramItems(Collection).Diagram.ComponentState then
    begin
      LForm := GetParentForm(TLMDDiagramItems(Collection).Diagram);
      if (LForm <> nil) and (LForm.Designer <> nil) then
        LForm.Designer.Modified;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItem.SetHeight(const Value: Integer);
begin
  if FHeight <> Value then
    begin
      FHeight := Value;
      Include(FState, isBoundsChanged);
      
      TLMDDiagramItems(Collection).Diagram.Change;
      Changed(False);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItem.SetLeft(const Value: Integer);
begin
  if FLeft <> Value then
    begin
      FLeft := Value;
      Include(FState, isBoundsChanged);

      TLMDDiagramItems(Collection).Diagram.Change;
      Changed(False);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItem.SetTop(const Value: Integer);
begin
  if FTop <> Value then
    begin
      FTop := Value;
      Include(FState, isBoundsChanged);

      TLMDDiagramItems(Collection).Diagram.Change;
      Changed(False);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItem.SetWidth(const Value: Integer);
begin
  if FWidth <> Value then
    begin
      FWidth := Value;
      Include(FState, isBoundsChanged);

      TLMDDiagramItems(Collection).Diagram.Change;
      Changed(False);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItem.SetCaption(const Value: TLMDString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Include(FState, isCaptionChanged);
    
    TLMDDiagramItems(Collection).Diagram.Change;
    Changed(False);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItem.SetName(const Value: TLMDDiagramItemName);
begin
  if Value <> FName then
  begin
    if (Value <> '') and not SameText(Value, FName) then
    begin
      if not IsValidIdent(Value) then
        raise Exception.CreateFmt(SLMDInvalidItemName, [Value]);
      if TLMDDiagramItems(Collection).Find(Value) <> nil then
        raise Exception.CreateFmt(SLMDItemExist, [Value]);
    end;

    if FName = Caption then
      Caption := Value;
    FName := Value;

    TLMDDiagramItems(Collection).ReconnectItems;
    Changed(False);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItem.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
    begin
      if not Value and (TLMDDiagramItems(Collection).Diagram.SelectedItem = Self) then
        TLMDDiagramItems(Collection).Diagram.SelectedItem := nil;
      FVisible := Value;
      Include(FState, isVisibleChanged);

      TLMDDiagramItems(Collection).Diagram.Change;
      Changed(False);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDiagramItem.GetSelected: Boolean;
begin
  Result := TLMDDiagramItems(Collection).Diagram.SelectedItem = Self;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItem.SetSelected(const Value: Boolean);
begin
  if Value then
    TLMDDiagramItems(Collection).Diagram.SelectedItem := Self
  else if TLMDDiagramItems(Collection).Diagram.SelectedItem = Self then
    TLMDDiagramItems(Collection).Diagram.SelectedItem := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItem.SetColor(const Value: TColor);
begin
  if FColor <> Value then
    begin
      FColor := Value;
      Include(FState, isColorChanged);

      TLMDDiagramItems(Collection).Diagram.Change;
      Changed(False);
    end;
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDDiagramItem.GetDisplayName: string;
begin
  if Name <> '' then
    Result := Name
  else
    Result := inherited GetDisplayName;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDiagramItem.GetPanelClass: TLMDDiagramItemPanelClass;
begin
  Result := TLMDDiagramItemPanel;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItem.Update(var ARefreshLinks: Boolean);
begin
  if Visible then
    CreatePanel
  else
    FreePanel;

  if FPanel <> nil then
  begin
    if isBoundsChanged in FState then
    begin
      Include(FState, isChangingBounds);
      try
        FPanel.SetBounds(FLeft - TLMDDiagramItems(Collection).FDiagram.HScrollPos,
                         FTop - TLMDDiagramItems(Collection).FDiagram.VScrollPos,
                         FWidth,
                         FHeight);
      finally
        Exclude(FState, isChangingBounds);
      end;
    end;
    
    if isCaptionChanged in FState then
      FPanel.Caption := FCaption;
    if isColorChanged in FState then
      FPanel.Color := FColor;
  end;
  
  ARefreshLinks := ARefreshLinks or (isBoundsChanged in State) or
                   (isVisibleChanged in State);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItem.ForceUpdate;
begin
  FState := FState + [isBoundsChanged, isCaptionChanged, isColorChanged, isVisibleChanged];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItem.MakeUpdated;
begin
  FState := FState - [isBoundsChanged, isCaptionChanged, isColorChanged, isVisibleChanged];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItem.DoAssign(ASource: TPersistent);
begin
  FLeft := TLMDDiagramItem(ASource).Left;
  FTop := TLMDDiagramItem(ASource).Top;
  FWidth := TLMDDiagramItem(ASource).Width;
  FHeight := TLMDDiagramItem(ASource).Height;
  FCaption := TLMDDiagramItem(ASource).Caption;
  FColor := TLMDDiagramItem(ASource).Color;
  FVisible := TLMDDiagramItem(ASource).Visible;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItem.Select(ASelect: Boolean);
begin
  if ASelect and (Panel <> nil) then
    begin
      Panel.BringToFront;
      Panel.Update;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItem.SetFocus;
begin
  if not (csDesigning in TLMDDiagramItems(Collection).Diagram.ComponentState) and
    (Panel <> nil) and Panel.HandleAllocated and Panel.CanFocus then
    Windows.SetFocus(Panel.Handle);
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDDiagramItem.Create(Collection: TCollection);
var
  LP: TPoint;
begin
  FWidth := 89;
  FHeight := 89;
  FColor := clBtnFace;
  FVisible := True;

  if TLMDDiagramItems(Collection).Diagram.ItemAutoPos then
    begin
      LP := TLMDDiagramItems(Collection).Diagram.CalcItemPos(FWidth, FHeight);
      FLeft := LP.X;
      FTop := LP.Y;
    end;

  inherited;
  TLMDDiagramItems(Collection).Diagram.ItemInsert(Self);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDiagramItem.Destroy;
begin
  TLMDDiagramItems(Collection).Diagram.ItemDelete(Self);
  Name := '';
  if TLMDDiagramItems(Collection).Diagram.SelectedItem = Self then
    TLMDDiagramItems(Collection).Diagram.SelectedItem := nil;
  FreePanel;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItem.Assign(Source: TPersistent);
begin
  if Source is TLMDDiagramItem then
    begin
      DoAssign(Source);
      ForceUpdate;

      TLMDDiagramItems(Collection).Diagram.Change;
      Changed(False);
    end
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItem.MakeVisible;
var
  LDiagram: TLMDCustomDiagram;
  LHScrollPos, LVScrollPos: Integer;
begin
  if not Visible then
    raise ELMDDiagram.Create(SLMDDgrmShowItemError);
  LDiagram := TLMDDiagramItems(Collection).Diagram;
  LHScrollPos := LDiagram.HScrollPos;
  LVScrollPos := LDiagram.VScrollPos;
  if Left + Width > LDiagram.HScrollPos + LDiagram.ClientWidth then
    LHScrollPos := Left + Width - LDiagram.ClientWidth;
  if Top + Height > LDiagram.VScrollPos + LDiagram.ClientHeight then
    LVScrollPos := Top + Height - LDiagram.ClientHeight;
  if Left < LDiagram.HScrollPos then
    LHScrollPos := Left;
  if Top < LDiagram.VScrollPos then
    LVScrollPos := Top;
  LDiagram.ScrollBy(LHScrollPos - LDiagram.HScrollPos,
                    LVScrollPos - LDiagram.VScrollPos);
end;

{ ************************ class TLMDDiagramItems **************************** }
{ ------------------------------ private ------------------------------------- }
function TLMDDiagramItems.GetItem(Index: Integer): TLMDDiagramItem;
begin
  Result := TLMDDiagramItem(inherited Items[Index]);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItems.SetItem(Index: Integer; const Value: TLMDDiagramItem);
begin
  inherited Items[Index] := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItems.ReconnectItems;
var
  LI: Integer;
begin
  FDiagram.Links.BeginUpdate;
  try
    for LI := 0 to FDiagram.Links.Count - 1 do
      FDiagram.Links[LI].ConnectItems;
  finally
    FDiagram.Links.EndUpdate;
  end;
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDDiagramItems.GetOwner: TPersistent;
begin
  Result := FDiagram;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItems.Update(Item: TCollectionItem);
var
  LI: Integer;
  LRefreshLinks, LTmp: Boolean;
begin
  if Item <> nil then
    begin
      LRefreshLinks := False;
      TLMDDiagramItem(Item).Update(LRefreshLinks);
      TLMDDiagramItem(Item).MakeUpdated;
    end
  else
    begin
      LRefreshLinks := False;
      for LI := 0 to Count - 1 do
        begin
          LTmp := False;
          Items[LI].Update(LTmp);
          LRefreshLinks := LRefreshLinks or LTmp;
          Items[LI].MakeUpdated;
        end;
    end;
  if LRefreshLinks then
    FDiagram.RefreshLinks;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItems.SetItemName(Item: TCollectionItem);
var
  LI:   Integer;
  LStr: TLMDString;
begin
  LI := 1;
  LStr := Format('Item%d', [LI]);
  while Find(LStr) <> nil do
    begin
      Inc(LI);
      LStr := Format('Item%d', [LI]);
    end;
  TLMDDiagramItem(Item).Name := LStr;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDDiagramItems.Create(ADiagram: TLMDCustomDiagram);
begin
  inherited Create(ADiagram.GetItemClass);
  FDiagram := ADiagram;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDiagramItems.IndexOf(AItem: TLMDDiagramItem): Integer;
var
  LI: Integer;
begin
  Result := -1;
  for LI := 0 to Count - 1 do
    if AItem = Items[LI] then
      begin
        Result := LI;
        Break;
      end
end;

{ ---------------------------------------------------------------------------- }
function TLMDDiagramItems.Find(
  const AName: TLMDDiagramItemName): TLMDDiagramItem;
var
  LI: Integer;
begin
  Result := nil;
  for LI := 0 to Count - 1 do
    if SameText(AName, Items[LI].Name) then
      begin
        Result := Items[LI];
        Break;
      end;
end;

{ ************************ class TLMDCustomDiagram *************************** }
{ ------------------------------ private ------------------------------------- }
function TLMDCustomDiagram.CalcItemPos(AWidth, AHeight: Integer): TPoint;

  function _CanPasteItem(ALeft, ATop, AWidth, AHeight: Integer): Boolean;

    function __IsRectInts(const AR1, AR2: TRect): Boolean;
    begin
      Result := (AR1.Left <= AR2.Right) and (AR2.Left <= AR1.Right) and
        (AR1.Top <= AR2.Bottom) and (AR2.Top <= AR1.Bottom);
    end;

  var
    LI: Integer;
    LR: TRect;

  begin
    Result := True;
    LR := Rect(ALeft, ATop, ALeft + AWidth, ATop + AHeight);
    for LI := 0 to Items.Count - 1 do
      with Items[LI] do
        if Visible and __IsRectInts(LR, Rect(Left, Top, Left + Width, Top + Height)) then
          begin
            Result := False;
            Break;
          end;
  end;

  function _Scan(LRect: TRect; AWidth, AHeight: Integer; out AP: TPoint): Boolean;

  const
    LStep = 20;

  var
    LX, LY: Integer;

  begin
    Result := False;

    LY := LRect.Top;
    while LY <= LRect.Bottom do
      begin
        LX := LRect.Left;
        while LX <= LRect.Right do
          begin
            if _CanPasteItem(LX, LY, AWidth, AHeight) then
              begin
                Result := True;
                AP := Point(LX, LY);
                Break;
              end;
            Inc(LX, LStep);
          end;
        if Result then Break;
        Inc(LY, LStep);
      end;
  end;

var
  LWidth: Integer;

begin
  LWidth := Width;
  if ScrollBars in [ssHorizontal, ssBoth] then Dec(LWidth, GetSystemMetrics(SM_CYHSCROLL));

  if not _Scan(Rect(HScrollPos, VScrollPos, HScrollPos + LWidth - AWidth,
    DiagramHeight - AHeight), AWidth, AHeight, Result) then
    if not _Scan(Rect(HScrollPos + LWidth - AWidth, VScrollPos, DiagramWidth - AWidth,
      DiagramHeight - AHeight), AWidth, AHeight, Result) then
      if not _Scan(Rect(HScrollPos, 0, DiagramWidth - AWidth,
        VScrollPos - AHeight), AWidth, AHeight, Result) then
        if not _Scan(Rect(0, 0, HScrollPos - AWidth,
          DiagramHeight - AHeight), AWidth, AHeight, Result) then
          Result := Point(HScrollPos, VScrollPos);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.UpdateScrollBars;
var
  LSI: TScrollInfo;
begin
  if HandleAllocated then
    begin
      if ScrollBars in [ssHorizontal, ssBoth] then
        begin
          LSI.cbSize := SizeOf(LSI);
          LSI.fMask := SIF_ALL;
          GetScrollInfo(Self.Handle, SB_HORZ, LSI);
          LSI.nPage := ClientWidth;
          LSI.nMin := 0;
          LSI.nMax := DiagramWidth;
          LSI.nPos := FHScrollPos;
          SetScrollInfo(Self.Handle, SB_HORZ, LSI, True);
        end;
      if ScrollBars in [ssVertical, ssBoth] then
        begin
          LSI.cbSize := SizeOf(LSI);
          LSI.fMask := SIF_ALL;
          GetScrollInfo(Self.Handle, SB_VERT, LSI);
          LSI.nPage := ClientHeight;
          LSI.nMin := 0;
          LSI.nMax := DiagramHeight;
          LSI.nPos := FVScrollPos;
          SetScrollInfo(Self.Handle, SB_VERT, LSI, True);
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDiagram.IsActiveControl: Boolean;
var
  LH: Hwnd;
begin
  Result := False;
  if HandleAllocated then
    begin
      LH := GetFocus;
      while IsWindow(LH) and (Result = False) do
        begin
          if LH = Handle then
            Result := True
          else
            LH := GetParent(LH);
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.FreeLinkDInfs(AInfs: TList);
var
  LI: Integer;
  LDrawInfoRec: PLMDLinkDrawInfoRec;
begin
  if AInfs <> nil then
    begin
      for LI := 0 to AInfs.Count - 1 do
        begin
          LDrawInfoRec := PLMDLinkDrawInfoRec(AInfs[LI]);
          if LDrawInfoRec <> nil then
            begin
              if LDrawInfoRec.DrawInfo <> nil then LDrawInfoRec.DrawInfo.Free;
              Dispose(LDrawInfoRec);
            end;
        end;
      AInfs.Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.WMVScroll(var Message: TWMVScroll);
var
  LSI: TScrollInfo;
  LNewPos: Integer;
begin
  LNewPos := VScrollPos;
  with Message do
    case ScrollCode of
      SB_LINEUP: LNewPos := VScrollPos - 10;
      SB_LINEDOWN: LNewPos := VScrollPos + 10;
      SB_PAGEUP: LNewPos := VScrollPos - ClientHeight;
      SB_PAGEDOWN: LNewPos := VScrollPos + ClientHeight;
      SB_THUMBPOSITION:
        begin
          LSI.cbSize := SizeOf(LSI);
          LSI.fMask := SIF_ALL;
          GetScrollInfo(Self.Handle, SB_VERT, LSI);
          LNewPos := LSI.nTrackPos;
        end;
      SB_THUMBTRACK:
        if ThumbTrack then
          begin
            LSI.cbSize := SizeOf(LSI);
            LSI.fMask := SIF_ALL;
            GetScrollInfo(Self.Handle, SB_VERT, LSI);
            LNewPos := LSI.nTrackPos;
          end;
      SB_BOTTOM: LNewPos := DiagramHeight - ClientHeight;
      SB_TOP: LNewPos := 0;
    end;
  VScrollPos := LNewPos;
  Message.Result := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.WMHScroll(var Message: TWMHScroll);
var
  LSI: TScrollInfo;
  LNewPos: Integer;
begin
  LNewPos := HScrollPos;
  with Message do
    case ScrollCode of
      SB_LINELEFT: LNewPos := HScrollPos - 10;
      SB_LINERIGHT: LNewPos := HScrollPos + 10;
      SB_PAGELEFT: LNewPos := HScrollPos - ClientWidth;
      SB_PAGERIGHT: LNewPos := HScrollPos + ClientWidth;
      SB_THUMBPOSITION:
        begin
          LSI.cbSize := SizeOf(LSI);
          LSI.fMask := SIF_ALL;
          GetScrollInfo(Self.Handle, SB_HORZ, LSI);
          LNewPos := LSI.nTrackPos;
        end;
      SB_THUMBTRACK:
        if ThumbTrack then
          begin
            LSI.cbSize := SizeOf(LSI);
            LSI.fMask := SIF_ALL;
            GetScrollInfo(Self.Handle, SB_HORZ, LSI);
            LNewPos := LSI.nTrackPos;
          end;
      SB_RIGHT: LNewPos := DiagramWidth - ClientWidth;
      SB_LEFT: LNewPos := 0;
    end;
  HScrollPos := LNewPos;
  Message.Result := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.WMSize(var Message: TWMSize);
begin
  inherited;
  UpdateScrollBars;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.WMNCHitTest(var Message: TWMNCHitTest);
begin
  DefaultHandler(Message);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  inherited;
  Msg.Result := Msg.Result or DLGC_WANTTAB;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.WMSetFocus(var Message: TWMSetFocus);
begin
  if SelectedItem <> nil then
    SelectedItem.SetFocus
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.SetDiagramHeight(const Value: Integer);
begin
  if FDiagramHeight <> Value then
    begin
      FDiagramHeight := Value;
      UpdateScrollBars;
      Change;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.SetDiagramWidth(const Value: Integer);
begin
  if FDiagramWidth <> Value then
    begin
      FDiagramWidth := Value;
      UpdateScrollBars;
      Change;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.SetLinks(const Value: TLMDDiagramLinks);
begin
  FLinks.Assign(Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.SetItems(const Value: TLMDDiagramItems);
begin
  FItems.Assign(Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.SetSelectedItem(const Value: TLMDDiagramItem);
var
  LInChanging: Boolean;
begin
  if FSelectedItem <> Value then
    begin
      if (Value <> nil) and not Value.Visible then
        raise ELMDDiagram.Create(SLMDDgrmSelItemError);
      LInChanging := dsChangingSelection in FState;
      if not LInChanging then Include(FState, dsChangingSelection);
      try
        SelectedLink := nil;
      finally
        if not LInChanging then Exclude(FState, dsChangingSelection);
      end;
      if FSelectedItem <> nil then FSelectedItem.Select(False);
      FSelectedItem := Value;
      if FSelectedItem <> nil then
        begin
          FSelectedItem.Select(True);
          if IsActiveControl then FSelectedItem.SetFocus;
        end
      else
        if not (csDesigning in ComponentState) and IsActiveControl
          and HandleAllocated and CanFocus then
          Windows.SetFocus(Handle);
      if not (dsChangingSelection in FState) then ChangeSelection;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.SetSelectedLink(const Value: TLMDDiagramLink);
var
  LInChanging: Boolean;
begin
  if FSelectedLink <> Value then
    begin
      if (Value <> nil) and not Value.Visible then
        raise ELMDDiagram.Create(SLMDDgrmSelLinkError);
      LInChanging := dsChangingSelection in FState;
      if not LInChanging then Include(FState, dsChangingSelection);
      try
        SelectedItem := nil;
      finally
        if not LInChanging then Exclude(FState, dsChangingSelection);
      end;
      FSelectedLink := Value;
      RefreshLinks;
      if not (dsChangingSelection in FState) then ChangeSelection;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.SetHScrollPos(const Value: Integer);
begin
  ScrollBy(Value - FHScrollPos, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.SetVScrollPos(const Value: Integer);
begin
  ScrollBy(0, Value - FVScrollPos);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.SetScrollBars(const Value: TScrollStyle);
begin
  FScrollBars := Value;
  RecreateWnd;
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDCustomDiagram.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_DESIGN;
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDCustomDiagram.EraseLinks;
begin
  Include(FState, dsErasingLinks);
  try
    RefreshLinks;
  finally
    Exclude(FState, dsErasingLinks);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.Paint;
var
  LI: Integer;
  LDrawInfo: TLMDLinkDrawInfo;
  LNewLinkDInfs: TList;
  LClearDInfs: TList;
  LDrawInfoRec: PLMDLinkDrawInfoRec;
begin
  if not (dsRefreshingLinks in State) then
    begin
      inherited;
      if (FLinkDInfs <> nil) and not (dsLinksChanged in State) then
        begin
          for LI := 0 to FLinkDInfs.Count - 1 do
            PaintLink(PLMDLinkDrawInfoRec(FLinkDInfs[LI]).DrawInfo, False);
          Exit;
        end;
    end;

  LNewLinkDInfs := TList.Create;
  try
    { Create new list }
    for LI := 0 to Links.Count - 1 do
      begin
        if not (dsErasingLinks in State) then
          LDrawInfo := CreateLinkDrawInfo(Links[LI])
        else
          LDrawInfo := nil;
        if LDrawInfo <> nil then
          begin
            New(LDrawInfoRec);
            LDrawInfoRec.Link := Links[LI];
            LDrawInfoRec.DrawInfo := LDrawInfo;
            if Links[LI].FDInfIndex <> -1 then
              LDrawInfoRec.OldDrawInfo := PLMDLinkDrawInfoRec(FLinkDInfs[Links[LI].FDInfIndex]).DrawInfo
            else
              LDrawInfoRec.OldDrawInfo := nil;
            Links[LI].FDInfIndex := LNewLinkDInfs.Add(LDrawInfoRec);
          end
        else
          Links[LI].FDInfIndex := -1;
      end;

    LClearDInfs := TList.Create;
    try
      { Create clear list and set to nil PELDiagramLinkDrawInfoRec^.OldDrawInfo field }
      if FLinkDInfs <> nil then
        for LI := 0 to FLinkDInfs.Count - 1 do
          if (PLMDLinkDrawInfoRec(FLinkDInfs[LI]).Link = nil) or
            (PLMDLinkDrawInfoRec(FLinkDInfs[LI]).Link.FDInfIndex = -1) then
            LClearDInfs.Add(PLMDLinkDrawInfoRec(FLinkDInfs[LI]).DrawInfo);
      for LI := 0 to LNewLinkDInfs.Count - 1 do
        with PLMDLinkDrawInfoRec(LNewLinkDInfs[LI])^ do
        begin
          if (OldDrawInfo <> nil) and not IsEqualDrawInfos(DrawInfo, OldDrawInfo) then
            LClearDInfs.Add(OldDrawInfo);
          OldDrawInfo := nil;
        end;

      { Clear Links }
      if dsRefreshingLinks in State then
        for LI := 0 to LClearDInfs.Count - 1 do
          PaintLink(TLMDLinkDrawInfo(LClearDInfs[LI]), True);

      { Paint links }
      for LI := 0 to LNewLinkDInfs.Count - 1 do
        PaintLink(PLMDLinkDrawInfoRec(LNewLinkDInfs[LI]).DrawInfo, False);
    finally
      LClearDInfs.Free;
    end;

    { Free Old list }
    FreeLinkDInfs(FLinkDInfs);
    FLinkDInfs := nil;
  except
    FreeLinkDInfs(LNewLinkDInfs);
    raise;
  end;
  FLinkDInfs := LNewLinkDInfs;
  Exclude(FState, dsLinksChanged);
  Include(FState, dsRepainted);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.CreateParams(var Params: TCreateParams);
const
  LScrollBar: array[TScrollStyle] of DWORD = (0, WS_HSCROLL, WS_VSCROLL,
    WS_HSCROLL or WS_VSCROLL);
begin
  inherited;
  with Params do
    begin
      Style := Style or LScrollBar[ScrollBars] or WS_CLIPCHILDREN;
      WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.CreateHandle;
begin
  inherited;
  UpdateScrollBars;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  SelectedLink := LinkAtPos(X, Y);
  SelectedItem := nil;
  if CanFocus then SetFocus;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.KeyDown(var Key: Word; Shift: TShiftState);
var
  LIndex, LI: Integer;
  LItem: TLMDDiagramItem;
begin
  inherited;
  if Key <> 0 then
    case Key of
      VK_TAB:
        begin
          LItem := nil;
          if SelectedItem <> nil then LIndex := SelectedItem.Index else LIndex := -1;
          if LIndex = -1 then
            begin
              for LI := 0 to Items.Count - 1 do
                if Items[LI].Visible then
                  begin
                    LItem := Items[LI];
                    Break;
                  end;
            end
          else if ssShift in Shift then
            begin
              for LI := LIndex - 1 downto 0 do
                if Items[LI].Visible then
                  begin
                    LItem := Items[LI];
                    Break;
                  end;
              if LItem = nil then
                for LI := Items.Count - 1 downto LIndex do // Include Items[LIndex] item, if no others found
                  if Items[LI].Visible then
                    begin
                      LItem := Items[LI];
                      Break;
                    end;
            end
          else
            begin
              for LI := LIndex + 1 to Items.Count - 1 do
                if Items[LI].Visible then
                  begin
                    LItem := Items[LI];
                    Break;
                  end;
              if LItem = nil then
                for LI := 0 to LIndex do // Include Items[LIndex] item, if no others found
                  if Items[LI].Visible then
                    begin
                      LItem := Items[LI];
                      Break;
                    end;
            end;
          SelectedItem := LItem;
          if LItem <> nil then LItem.MakeVisible;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.WndProc(var Message: TMessage);
var
  LMouseMsg: TWMMouse;
begin
  if not (csDesigning in ComponentState) and ((Message.Msg = WM_LBUTTONDOWN) or
    (Message.Msg = WM_LBUTTONDBLCLK)) and not Dragging and
    (DragMode = dmAutomatic) and (DragKind = dkDrag) then
    begin
      LMouseMsg := TWMMouse(Message);
      if not IsControlMouseMsg(LMouseMsg) then
        begin
          ControlState := ControlState + [csLButtonDown];
          Dispatch(Message);
        end;
    end
  else
    inherited WndProc(Message);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.Resize;
begin
  ScrollBy(0, 0);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDiagram.GetLinkClass: TLMDDiagramLinkClass;
begin
  Result := TLMDDiagramLink;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDiagram.CreateLinks: TLMDDiagramLinks;
begin
  Result := TLMDDiagramLinks.Create(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDiagram.GetItemClass: TLMDDiagramItemClass;
begin
  Result := TLMDDiagramItem;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDiagram.CreateItems: TLMDDiagramItems;
begin
  Result := TLMDDiagramItems.Create(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDiagram.GetLinkDrawInfoClass: TLMDLinkDrawInfoClass;
begin
  Result := TLMDStdLinkDrawInfo;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDiagram.CreateLinkDrawInfo(ALink: TLMDDiagramLink): TLMDLinkDrawInfo;
var
  LdX: Integer;
begin
  if (ALink <> nil) and ALink.CanBeShown then
    begin
      Result := GetLinkDrawInfoClass.Create;
      with Result as TLMDStdLinkDrawInfo do
        begin
          LeftToRight := ((2 * ALink.BeginItem.Left + ALink.BeginItem.Width) div 2) <
            ((2 * ALink.EndItem.Left + ALink.EndItem.Width) div 2);
          BeginP := Point(ALink.BeginItem.Left + ALink.BeginItem.Width * Ord(LeftToRight),
            ALink.BeginItem.Top + GetSystemMetrics(SM_CYBORDER) + GetSystemMetrics(SM_CYSMCAPTION) div 2);
          EndP := Point(ALink.EndItem.Left + ALink.EndItem.Width * Ord(not LeftToRight),
            ALink.EndItem.Top + GetSystemMetrics(SM_CYBORDER) + GetSystemMetrics(SM_CYSMCAPTION) div 2);
          LdX := LMDRectSize * (2 * Ord(LeftToRight) - 1);
          LineBegin := Point(BeginP.X + LdX, BeginP.Y);
          LineEnd := Point(EndP.X - LdX, EndP.Y);
          Color := ALink.Color;
          Selected := (SelectedLink = ALink);
        end;
    end
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDiagram.IsEqualDrawInfos(ADrawInfo1, ADrawInfo2: TLMDLinkDrawInfo): Boolean;
var
  LDI1, LDI2: TLMDStdLinkDrawInfo;
begin
  LDI1 := ADrawInfo1 as TLMDStdLinkDrawInfo;
  LDI2 := ADrawInfo2 as TLMDStdLinkDrawInfo;
  Result := (LDI1.BeginP.X = LDI2.BeginP.X) and
    (LDI1.BeginP.Y = LDI2.BeginP.Y) and
    (LDI1.EndP.X = LDI2.EndP.X) and
    (LDI1.EndP.Y = LDI2.EndP.Y) and
    (LDI1.LeftToRight = LDI2.LeftToRight) and
    (LDI1.Color = LDI2.Color) and
    (LDI1.Selected = LDI2.Selected);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDiagram.IsOnLink(ADrawInfo: TLMDLinkDrawInfo; AX, AY: Integer): Boolean;

const
  LR = 3;

var
  LXMin, LXMax, LYMin, LYMax: Integer;
  LA, LB, LA_2, LB_2, LC_2: Double;
  LP, LP1, LP2: TPoint;
  LDI: TLMDStdLinkDrawInfo;

begin
  LDI := ADrawInfo as TLMDStdLinkDrawInfo;

  LP := Point(AX, AY);
  LP1 := LDI.LineBegin;
  Dec(LP1.X, FHScrollPos);
  Dec(LP1.Y, FVScrollPos);
  LP2 := LDI.LineEnd;
  Dec(LP2.X, FHScrollPos);
  Dec(LP2.Y, FVScrollPos);

  { Calc Min and Max }
  if LP1.X < LP2.X then
    begin
      LXMin := LP1.X;
      LXMax := LP2.X;
    end
  else
    begin
      LXMin := LP2.X;
      LXMax := LP1.X;
    end;
  if LP1.Y < LP2.Y then
    begin
      LYMin := LP1.Y;
      LYMax := LP2.Y;
    end
  else
    begin
      LYMin := LP2.Y;
      LYMax := LP1.Y;
    end;

  { Check }
  Result := (LP.Y - LR <= LYMax) and (LP.Y + LR >= LYMin) and
    (LP.X - LR <= LXMax) and (LP.X + LR >= LXMin);
  if Result and not ((LXMin = LXMax) or (LYMin = LYMax)) then
    begin
      LA := (LP1.Y - LP2.Y) / (LP1.X - LP2.X);
      LB := LP1.Y - LA * LP1.X;

      LA_2 := 1 + LA * LA;
      LB_2 := 2 * LA * LB - 2 * LP.X - 2 * LA * LP.Y;
      LC_2 := LP.X * LP.X + LB * LB - 2 * LB * LP.Y + LP.Y * LP.Y - LR * LR;

      if (LB_2 * LB_2 - 4 * LA_2 * LC_2) < 0 then Result := False;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.PaintLink(ADrawInfo: TLMDLinkDrawInfo; AClear: Boolean);
var
  LXOffset, LYOffset: Integer;
  LDI: TLMDStdLinkDrawInfo;
begin
  LDI := ADrawInfo as TLMDStdLinkDrawInfo;

  if AClear then
    begin
      Canvas.Pen.Color := Color;
      Canvas.Brush.Color := Color;
    end
  else
    begin
      Canvas.Pen.Color := LDI.Color;
      Canvas.Brush.Color := LDI.Color;
    end;

  LXOffset := -HScrollPos;
  LYOffset := -VScrollPos;

  if LDI.Selected then
    Canvas.Pen.Width := 2
  else
    Canvas.Pen.Width := 1;

  Canvas.Polyline([
    Point(
      LDI.LineBegin.X + LXOffset,
      LDI.LineBegin.Y + LYOffset),
    Point(
      LDI.LineEnd.X + LXOffset,
      LDI.LineEnd.Y + LYOffset)
  ]);

  Canvas.Pen.Width := 1;

  Canvas.FillRect(Rect(
    LDI.BeginP.X + LXOffset,
    LDI.BeginP.Y + LYOffset - 1,
    LDI.LineBegin.X + LXOffset,
    LDI.BeginP.Y + LYOffset + 2
    ));

  Canvas.FillRect(Rect(
    LDI.EndP.X + LXOffset,
    LDI.EndP.Y + LYOffset - 1,
    LDI.LineEnd.X + LXOffset,
    LDI.EndP.Y + LYOffset + 2
    ));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.PaintItem(APanel: TLMDDiagramItemPanel);
var
  LRect: TRect;
begin
  APanel.Canvas.Brush.Color := APanel.Item.Color;
  APanel.Canvas.FillRect(ClientRect);
  if APanel.Focused then
    begin
      LRect := APanel.ClientRect;
      InflateRect(LRect, -2, -2);
      APanel.Canvas.DrawFocusRect(LRect);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.ChangeSelection;
begin
  if Assigned(OnChangeSelection) then OnChangeSelection(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.Change;
begin
  if Assigned(OnChange) then OnChange(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.ItemInsert(AItem: TLMDDiagramItem);
begin
  if Assigned(OnInsertItem) then OnInsertItem(Self, AItem);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.ItemDelete(AItem: TLMDDiagramItem);
begin
  if Assigned(OnDeleteItem) then OnDeleteItem(Self, AItem);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.LinkInsert(ALink: TLMDDiagramLink);
begin
  if Assigned(OnInsertLink) then OnInsertLink(Self, ALink);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.LinkDelete(ALink: TLMDDiagramLink);
begin
  if Assigned(OnDeleteLink) then OnDeleteLink(Self, ALink);
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDCustomDiagram.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csSetCaption, csAcceptsControls, csReplicatable];
  Height := 89;
  Width := 185;
  BevelOuter := bvNone;
  BorderStyle := bsSingle;
  TabStop := True;
  FDiagramWidth := 1000;
  FDiagramHeight := 1000;
  FLinks := CreateLinks;
  FItems := CreateItems;
  FScrollBars := ssBoth;
  FItemAutoPos := True;
  UseDockManager := False;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomDiagram.Destroy;
begin
  Items.Clear;
  Links.Clear;

  FItems.Free;
  FItems := nil;
  FLinks.Free;
  FLinks := nil;
  FreeLinkDInfs(FLinkDInfs);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.ScrollBy(ADeltaX, ADeltaY: Integer);
var
  LNewPos, LHDifference, LVDifference: Integer;
begin
  LNewPos := FHScrollPos + ADeltaX;
  if LNewPos < 0 then LNewPos := 0;
  if LNewPos > DiagramWidth - ClientWidth then LNewPos := DiagramWidth - ClientWidth;
  LHDifference := FHScrollPos - LNewPos;

  LNewPos := FVScrollPos + ADeltaY;
  if LNewPos < 0 then LNewPos := 0;
  if LNewPos > DiagramHeight - ClientHeight then LNewPos := DiagramHeight - ClientHeight;
  LVDifference := FVScrollPos - LNewPos;

  if (LHDifference <> 0) or (LVDifference <> 0) then
    begin
      Dec(FHScrollPos, LHDifference);
      Dec(FVScrollPos, LVDifference);
      inherited ScrollBy(LHDifference, LVDifference);
      UpdateScrollBars;
    end;
  Change;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDiagram.RefreshLinks;
begin
  if HandleAllocated then
    begin
      Include(FState, dsRefreshingLinks);
      try
        Exclude(FState, dsRepainted);
        Repaint; // Paint may be not
                 // called if diagram is invisible
        if not (dsRepainted in FState) then
          begin
            Include(FState, dsLinksChanged);
            Exclude(FState, dsRepainted);
          end;
      finally
        Exclude(FState, dsRefreshingLinks);
      end;
    end
  else
    Include(FState, dsLinksChanged);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDiagram.LinkAtPos(AX, AY: Integer): TLMDDiagramLink;
var
  LI: Integer;
begin
  Result := nil;
  for LI := 0 to Links.Count - 1 do
    if (Links[LI].FDInfIndex <> -1) and
      IsOnLink(PLMDLinkDrawInfoRec(FLinkDInfs[Links[LI].FDInfIndex]).DrawInfo, AX, AY) then
      begin
        Result := Links[LI];
        Break;
      end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDiagram.ItemRect(AIndex: Integer): TRect;
var
  LR: TRect;
  LItem: TLMDDiagramItem;
begin
  LItem := Items[AIndex];
  if LItem.Panel <> nil then
    LR := LItem.Panel.BoundsRect
  else
    Result := Rect(0, 0, 0, 0);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDiagram.ItemAtPos(AX, AY: Integer): TLMDDiagramItem;
var
  LI: Integer;
  LP: TPoint;
begin
  Result := nil;
  LP := Point(AX, AY);
  for LI := 0 to Items.Count - 1 do
    if (Items[LI].Panel <> nil) and PtInRect(Items[LI].Panel.BoundsRect, LP) then
      begin
        Result := Items[LI];
        Break;
      end;
end;

{ *************************** class TLMDDiagram ****************************** }
{ ------------------------------ private ------------------------------------- }
procedure TLMDDiagram.SetCustomDrawItems(const Value: Boolean);
var
  LI: Integer;
begin
  if FCustomDrawItems <> Value then
    begin
      FCustomDrawItems := Value;
      for LI := 0 to Items.Count - 1 do
        if Items[LI].Panel <> nil then Items[LI].Panel.Invalidate;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagram.SetCustomDrawLinks(const Value: Boolean);
begin
  if FCustomDrawLinks <> Value then
    begin
      if not (csDesigning in ComponentState) then EraseLinks;
      FCustomDrawLinks := Value;
      if not (csDesigning in ComponentState) then RefreshLinks;
    end;
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDDiagram.CreateLinkDrawInfo(
  ALink: TLMDDiagramLink): TLMDLinkDrawInfo;
begin
  if CustomDrawLinks and not (csDesigning in ComponentState) then
    begin
      Result := nil;
      if Assigned(OnCreateLinkDrawInfo) then OnCreateLinkDrawInfo(Self, ALink, Result);
    end
  else
    Result := inherited CreateLinkDrawInfo(ALink);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDiagram.IsEqualDrawInfos(ADrawInfo1,
  ADrawInfo2: TLMDLinkDrawInfo): Boolean;
begin
  if CustomDrawLinks and not (csDesigning in ComponentState) then
    begin
      Result := False;
      if Assigned(OnIsEqualDrawInfos) then OnIsEqualDrawInfos(Self, ADrawInfo1, ADrawInfo2, Result);
    end
  else
    Result := inherited IsEqualDrawInfos(ADrawInfo1, ADrawInfo2);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDiagram.IsOnLink(ADrawInfo: TLMDLinkDrawInfo; AX,
  AY: Integer): Boolean;
begin
  if CustomDrawLinks and not (csDesigning in ComponentState) then
    begin
      Result := False;
      if Assigned(OnIsOnLink) then OnIsOnLink(Self, ADrawInfo, AX, AY, Result);
    end
  else
    Result := inherited IsOnLink(ADrawInfo, AX, AY);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagram.PaintLink(ADrawInfo: TLMDLinkDrawInfo; AClear: Boolean);
begin
  if CustomDrawLinks and not (csDesigning in ComponentState) then
    begin
      if Assigned(OnPaintLink) then OnPaintLink(Self, ADrawInfo, AClear);
    end
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagram.PaintItem(APanel: TLMDDiagramItemPanel);
begin
  if CustomDrawItems and not (csDesigning in ComponentState) then
    begin
      if Assigned(OnPaintItem) then OnPaintItem(Self, APanel);
    end
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }

initialization
  {$IFDEF LMD_DEBUGTRACE}
    {$I C3.INC}
  {$ENDIF}

end.
