unit LMDDsgDiagramDB;
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

LMDDsgDiagramDB unit (YB)
------------------------
TLMDDBDiagram unit

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, ExtCtrls, Forms, Windows, Messages, StdCtrls, Graphics,
  SysUtils, Types, LMDUnicode, LMDDsgCst, LMDDsgClass, LMDDsgDiagram, LMDTypes;

type
  TLMDDBDiagram       = class;
  TLMDDBDiagramItem   = class;
  TLMDDBLinkPointType = (lptNone, lptOne, lptInfinity);

  { ************************** TLMDDBDiagramLink ***************************** }

  TLMDDBDiagramLink = class(TLMDDiagramLink)
  private
    FBeginLineIndex: Integer;
    FEndLineIndex  : Integer;
    FBeginPointType: TLMDDBLinkPointType;
    FEndPointType  : TLMDDBLinkPointType;
    
    procedure SetBeginLineIndex(const Value: Integer);
    procedure SetEndLineIndex(const Value: Integer);
    procedure SetBeginPointType(const Value: TLMDDBLinkPointType);
    procedure SetEndPointType(const Value: TLMDDBLinkPointType);
    function  GetBeginItem: TLMDDBDiagramItem;
    function  GetEndItem: TLMDDBDiagramItem;
  protected
    function  CanBeShown: Boolean; override;
    procedure DoAssign(ASource: TPersistent); override;
  public
    constructor Create(Collection: TCollection); override;

    property BeginItem: TLMDDBDiagramItem read GetBeginItem;
    property EndItem: TLMDDBDiagramItem read GetEndItem;
  published
    property BeginLineIndex: Integer read FBeginLineIndex write SetBeginLineIndex default -1;
    property BeginPointType: TLMDDBLinkPointType read FBeginPointType write SetBeginPointType default lptNone;
    property EndLineIndex: Integer read FEndLineIndex write SetEndLineIndex default -1;
    property EndPointType: TLMDDBLinkPointType read FEndPointType write SetEndPointType default lptNone;
  end;

  { ************************** TLMDDBDiagramLinks **************************** }

  TLMDDBDiagramLinks = class(TLMDDiagramLinks)
  private
    function  GetItem(Index: Integer): TLMDDBDiagramLink;
    procedure SetItem(Index: Integer; const Value: TLMDDBDiagramLink);
    function  GetDiagram: TLMDDBDiagram;
  public
    property Diagram: TLMDDBDiagram read GetDiagram;
    property Items[Index: Integer]: TLMDDBDiagramLink read GetItem write SetItem; default;
  end;

  TLMDDBDiagramItemPanel = class;

  { *********************** TLMDDBDiagramItemListBox ************************* }

  TLMDDBDiagramItemListBox = class(TCustomListBox)
  private
    FItems: TLMDStrings;

    function  GetPanel: TLMDDBDiagramItemPanel;
    procedure SetItems(const Value: TLMDStrings);
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure CMDrag(var Message: TCMDrag); message CM_DRAG;
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure CreateHandle; override;
    procedure DblClick; override;
    procedure DestroyWnd; override;
    procedure Click; override;
    procedure WndProc(var Message: TMessage); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    property Panel: TLMDDBDiagramItemPanel read GetPanel;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Items: TLMDStrings read FItems write SetItems;
  end;

  { ************************ TLMDDBDiagramItemPanel ************************** }

  TLMDDBDiagramItemPanel = class(TLMDDiagramItemPanel)
  private
    FListBox: TLMDDBDiagramItemListBox;

    procedure UpdateListBoxStyle;
    function  GetItem: TLMDDBDiagramItem;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    property  ListBox: TLMDDBDiagramItemListBox read FListBox;
  public
    constructor Create(AOwner: TComponent; AItem: TLMDDiagramItem); override;
    destructor Destroy; override;

    property Item: TLMDDBDiagramItem read GetItem;
  end;

  { ************************** TLMDDBDiagramItem ***************************** }

  TLMDDBDiagramItem = class(TLMDDiagramItem)
  private
    FItemsChanged: Boolean;
    FOldItemIndex: Integer;
    FLineIndex   : Integer;
    FLines       : TLMDStrings;

    procedure UpdateListBoxStyle;
    function  ListBoxAvailable: Boolean;
    procedure LinesChange(Sender: TObject);
    procedure SetLines(const Value: TLMDStrings);
    function  GetLineIndex: Integer;
    procedure SetLineIndex(Value: Integer);
    function  GetPanel: TLMDDBDiagramItemPanel;
  protected
    procedure DoAssign(ASource: TPersistent); override;
    procedure Update(var ARefreshLinks: Boolean); override;
    procedure ForceUpdate; override;
    procedure MakeUpdated; override;
    function  GetPanelClass: TLMDDiagramItemPanelClass; override;
    procedure Select(ASelect: Boolean); override;
    procedure SetFocus; override;
    property  Panel: TLMDDBDiagramItemPanel read GetPanel;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    function LineAtPos(APos: TPoint; AExisting: Boolean): Integer;
  published
    property Color default clWindow;
    property Lines: TLMDStrings read FLines write SetLines;
  end;

  { ************************* TLMDDBDiagramItems ***************************** }

  TLMDDBDiagramItems = class(TLMDDiagramItems)
  private
    function  GetItem(Index: Integer): TLMDDBDiagramItem;
    procedure SetItem(Index: Integer; const Value: TLMDDBDiagramItem);
    function  GetDiagram: TLMDDBDiagram;
  public
    function Find(const AName: TLMDString): TLMDDBDiagramItem;
    property Diagram: TLMDDBDiagram read GetDiagram;
    property Items[Index: Integer]: TLMDDBDiagramItem read GetItem write SetItem; default;
  end;

  { ************************* TLMDDBLinkDrawInfo ***************************** }

  TLMDDBLinkDrawInfo = class(TLMDStdLinkDrawInfo)
  public
    BeginType: TLMDDBLinkPointType;
    EndType  : TLMDDBLinkPointType;
  end;

  TLMDDBDiagramMeasureItemLine = procedure(Sender: TObject; AItem: TLMDDBDiagramItem;
                                           ALineIndex: Integer;
                                           var AHeight: Integer) of object;
  TLMDDBDiagramDrawItemLine = procedure(Sender: TObject; AItem: TLMDDBDiagramItem;
                                        ALineIndex: Integer; ACanvas: TCanvas;
                                        ARect: TRect; AState: TOwnerDrawState) of object;
  TLMDDBDiagramItemClick = procedure(Sender: TObject; AItem: TLMDDBDiagramItem) of object;

  { **************************** TLMDDBDiagram ******************************* }

  TLMDDBDiagram = class(TLMDCustomDiagram)
  private
    FOneBitmap        : TBitmap;
    FInfinityBitmap   : TBitmap;
    FItemStyle        : TListBoxStyle;
    FOnDrawItemLine   : TLMDDBDiagramDrawItemLine;
    FOnMeasureItemLine: TLMDDBDiagramMeasureItemLine;
    FOnItemClick      : TLMDDBDiagramItemClick;
    
    function  GetItems: TLMDDBDiagramItems;
    procedure SetItems(const Value: TLMDDBDiagramItems);
    function  GetLinks: TLMDDBDiagramLinks;
    procedure SetLinks(const Value: TLMDDBDiagramLinks);
    procedure SetItemStyle(const Value: TListBoxStyle);
    function  GetSelectedItemLine: Integer;
    procedure SetSelectedItemLine(const Value: Integer);
    function  GetSelectedItem: TLMDDBDiagramItem;
    function  GetSelectedLink: TLMDDBDiagramLink;
    procedure SetSelectedItem(const Value: TLMDDBDiagramItem);
    procedure SetSelectedLink(const Value: TLMDDBDiagramLink);
  protected
    function  GetItemClass: TLMDDiagramItemClass; override;
    function  GetLinkClass: TLMDDiagramLinkClass; override;
    function  CreateLinkDrawInfo(ALink: TLMDDiagramLink): TLMDLinkDrawInfo; override;
    function  IsEqualDrawInfos(ADrawInfo1, ADrawInfo2: TLMDLinkDrawInfo): Boolean; override;
    function  GetLinkDrawInfoClass: TLMDLinkDrawInfoClass; override;
    procedure PaintLink(ADrawInfo: TLMDLinkDrawInfo; AClear: Boolean); override;
    function  CreateItems: TLMDDiagramItems; override;
    function  CreateLinks: TLMDDiagramLinks; override;
    procedure ItemInsert(AItem: TLMDDiagramItem); override;
    procedure DBItemInsert(AItem: TLMDDiagramItem); virtual;
    procedure ItemDelete(AItem: TLMDDiagramItem); override;
    procedure DBItemDelete(AItem: TLMDDiagramItem); virtual;
    function  MeasureItemLine(AItem: TLMDDBDiagramItem; ALineIndex: Integer;
                              var AHeight: Integer): Boolean; virtual;
    function  DrawItemLine(AItem: TLMDDBDiagramItem; ALineIndex: Integer;
                           ACanvas: TCanvas; ARect: TRect;
                           AState: TOwnerDrawState): Boolean; virtual;
    procedure ItemClick(AItem: TLMDDBDiagramItem); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    
    function LinkAtPos(AX, AY: Integer): TLMDDBDiagramLink;
    function ItemAtPos(AX, AY: Integer): TLMDDBDiagramItem;
    property SelectedItemLine: Integer read GetSelectedItemLine write SetSelectedItemLine;
    property SelectedItem: TLMDDBDiagramItem read GetSelectedItem write SetSelectedItem;
    property SelectedLink: TLMDDBDiagramLink read GetSelectedLink write SetSelectedLink;
    property HScrollPos;
    property VScrollPos;
  published
    property ItemAutoPos;
    property ScrollBars;
    property DiagramWidth;
    property DiagramHeight;
    property ReadOnly;
    property Links: TLMDDBDiagramLinks read GetLinks write SetLinks;
    property Items: TLMDDBDiagramItems read GetItems write SetItems;
    property ItemStyle: TListBoxStyle read FItemStyle write SetItemStyle default lbStandard;
    property ThumbTrack;
    property OnMeasureItemLine: TLMDDBDiagramMeasureItemLine read FOnMeasureItemLine write FOnMeasureItemLine;
    property OnDrawItemLine: TLMDDBDiagramDrawItemLine read FOnDrawItemLine write FOnDrawItemLine;
    property OnItemClick: TLMDDBDiagramItemClick read FOnItemClick write FOnItemClick;
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
  Consts, RTLConsts, Variants, LMDUnicodeControl, LMDInsClass;

const
  LMDRectSize = 14;

{ ************************ class TLMDDBDiagramLink *************************** }
{ ------------------------------ private ------------------------------------- }
procedure TLMDDBDiagramLink.SetBeginLineIndex(const Value: Integer);
begin
  if FBeginLineIndex <> Value then
    begin
      FBeginLineIndex := Value;
      TLMDDBDiagramLinks(Collection).Diagram.Change;
      Changed(False);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramLink.SetEndLineIndex(const Value: Integer);
begin
  if FEndLineIndex <> Value then
    begin
      FEndLineIndex := Value;
      TLMDDBDiagramLinks(Collection).Diagram.Change;
      Changed(False);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramLink.SetBeginPointType(
  const Value: TLMDDBLinkPointType);
begin
  if FBeginPointType <> Value then
    begin
      FBeginPointType := Value;
      TLMDDBDiagramLinks(Collection).Diagram.Change;
      Changed(False);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramLink.SetEndPointType(
  const Value: TLMDDBLinkPointType);
begin
  if FEndPointType <> Value then
    begin
      FEndPointType := Value;
      TLMDDBDiagramLinks(Collection).Diagram.Change;
      Changed(False);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagramLink.GetBeginItem: TLMDDBDiagramItem;
begin
  Result := TLMDDBDiagramItem(inherited BeginItem);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagramLink.GetEndItem: TLMDDBDiagramItem;
begin
  Result := TLMDDBDiagramItem(inherited EndItem);
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDDBDiagramLink.CanBeShown: Boolean;
begin
  Result := inherited CanBeShown;
  if Result then
    begin
      Result := (BeginLineIndex >= 0) and
        (BeginLineIndex <= BeginItem.Lines.Count - 1) and
        (EndLineIndex >= 0) and
        (EndLineIndex <= EndItem.Lines.Count - 1);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramLink.DoAssign(ASource: TPersistent);
begin
  inherited;
  FBeginLineIndex := TLMDDBDiagramLink(ASource).FBeginLineIndex;
  FEndLineIndex := TLMDDBDiagramLink(ASource).FEndLineIndex;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDDBDiagramLink.Create(Collection: TCollection);
begin
  FBeginLineIndex := -1;
  FEndLineIndex := -1;
  inherited;
end;

{ ************************ class TLMDDBDiagramLinks ************************** }
{ ------------------------------ private ------------------------------------- }
function TLMDDBDiagramLinks.GetItem(Index: Integer): TLMDDBDiagramLink;
begin
  Result := TLMDDBDiagramLink(inherited Items[Index]);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramLinks.SetItem(Index: Integer;
  const Value: TLMDDBDiagramLink);
begin
  Items[Index] := Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagramLinks.GetDiagram: TLMDDBDiagram;
begin
  Result := TLMDDBDiagram(inherited Diagram);
end;

{ ********************* class TLMDDBDiagramItemListBox *********************** }
{ ------------------------------ private ------------------------------------- }
procedure TLMDDBDiagramItemListBox.WMNCHitTest(var Message: TWMNCHitTest);
begin
  DefaultHandler(Message);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItemListBox.WMContextMenu(var Message: TWMContextMenu);
var
  LDiagram: TLMDCustomDiagram;
begin
  if (Panel <> nil) and (Panel.Item <> nil) then
    begin
      LDiagram := TLMDDBDiagramItems(Panel.Item.Collection).Diagram;
      if LDiagram.HandleAllocated then
        begin
          Message.hWnd := LDiagram.Handle;
          LDiagram.Dispatch(Message);
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItemListBox.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  inherited;
  Msg.Result := Msg.Result or DLGC_WANTTAB;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItemListBox.WMVScroll(var Message: TWMVScroll);
var
  LTopIndex: Integer;
begin
  LTopIndex := TopIndex;
  inherited;
  if (LTopIndex <> TopIndex) and (Panel <> nil) then
    TLMDDBDiagramItems(Panel.Item.Collection).Diagram.RefreshLinks;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItemListBox.WMKeyDown(var Message: TWMKeyDown);
var
  LTopIndex: Integer;
begin
  LTopIndex := TopIndex;
  inherited;
  if (Panel <> nil) and (LTopIndex <> TopIndex) then
    TLMDDBDiagramItems(Panel.Item.Collection).Diagram.RefreshLinks;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItemListBox.WMMouseWheel(var Message: TWMMouseWheel);
var
  LTopIndex: Integer;
begin
  LTopIndex := TopIndex;
  inherited;
  if (LTopIndex <> TopIndex) and (Panel <> nil) then
    TLMDDBDiagramItems(Panel.Item.Collection).Diagram.RefreshLinks;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItemListBox.CNCommand(var Message: TWMCommand);
begin
  if Message.NotifyCode = LBN_DBLCLK then
  begin
    // Do nothing.
  end
  else if Message.NotifyCode = LBN_SELCHANGE then
  begin
    inherited Changed;
    if (Panel <> nil) and (Panel.Item <> nil) then
      TLMDDBDiagramItems(Panel.Item.Collection).Diagram.ItemClick(Panel.Item);
  end
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItemListBox.WMLButtonDown(
  var Message: TWMLButtonDown);
var
  LShiftState: TShiftState;
begin
  inherited;
  if (Panel <> nil) and (Panel.Item <> nil) then
    begin
      LShiftState := KeysToShiftState(Message.Keys);
      if (TLMDDBDiagramItems(Panel.Item.Collection).Diagram.DragMode = dmAutomatic) and
        not ((ssCtrl in LShiftState) or (ssShift in LShiftState)) then
        begin
          TLMDDBDiagramItems(Panel.Item.Collection).Diagram.ItemClick(Panel.Item);
          TLMDDiagramItems(Panel.Item.Collection).Diagram.BeginDrag(False);
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItemListBox.CMDrag(var Message: TCMDrag);
begin
  if (Message.DragMessage = dmFindTarget) and (Panel <> nil) and (Panel.Item <> nil) then
    Message.Result := LRESULT(TLMDDiagramItems(Panel.Item.Collection).Diagram)
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagramItemListBox.GetPanel: TLMDDBDiagramItemPanel;
begin
  Result := TLMDDBDiagramItemPanel(Owner);
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDDBDiagramItemListBox.CreateHandle;
begin
  inherited;
  if (Panel <> nil) and (Panel.Item <> nil) then
  begin
    Items.Assign(Panel.Item.Lines);
    ItemIndex := Panel.Item.FLineIndex;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItemListBox.CreateWindowHandle(
  const Params: TCreateParams);
begin
  LMDCreateControlHandle(Self, Params, 'LISTBOX');
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItemListBox.DblClick;
begin
  if (Panel <> nil) and (Panel.Item <> nil) then
    TLMDDBDiagramItems(Panel.Item.Collection).Diagram.DblClick;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItemListBox.DestroyWnd;
begin
  if (Panel <> nil) and (Panel.Item <> nil) then
    Panel.Item.FLineIndex := ItemIndex;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItemListBox.Click;
begin
  if (Panel <> nil) and (Panel.Item <> nil) then
    TLMDDBDiagramItems(Panel.Item.Collection).Diagram.Click;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItemListBox.WndProc(var Message: TMessage);
var
  LForm: TCustomForm;
  LDiagram: TLMDDBDiagram;
  LMouseMsg: TWMMouse;
begin
  if (Panel <> nil) and (Panel.Item <> nil) then
  begin
    LDiagram := TLMDDBDiagramItems(Panel.Item.Collection).Diagram;
    if Message.Msg = WM_SETFOCUS then
    begin
      LForm := GetParentForm(LDiagram);
      if (LForm = nil) or LForm.SetFocusedControl(LDiagram) then
        Dispatch(Message);
    end
    else if not (csDesigning in ComponentState) and
      ((Message.Msg = WM_LBUTTONDOWN) or (Message.Msg = WM_LBUTTONDBLCLK)) and
      not LDiagram.Dragging and (LDiagram.DragMode = dmAutomatic) then
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
  end
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItemListBox.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (Panel <> nil) and (Panel.Item <> nil) then
  begin
    TLMDDBDiagramItems(Panel.Item.Collection).Diagram.SelectedItem := Panel.Item;
    Panel.Item.SetFocus;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItemListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Panel <> nil) and (Panel.Item <> nil) then
    Panel.KeyDown(Key, Shift);
  if Key <> 0 then inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItemListBox.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if (Panel <> nil) and (Panel.Item <> nil) then
    Panel.KeyUp(Key, Shift);
  if Key <> 0 then inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItemListBox.KeyPress(var Key: Char);
begin
  if (Panel <> nil) and (Panel.Item <> nil) then
    Panel.KeyPress(Key);
  if Key <> #0 then inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItemListBox.MeasureItem(Index: Integer;
  var Height: Integer);
begin
  if (Panel <> nil) and (Panel.Item <> nil) then
  begin
    if not TLMDDBDiagramItems(Panel.Item.Collection).Diagram.MeasureItemLine(Panel.Item,
      Index, Height) then
      inherited;
  end
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItemListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
begin
  if (Panel <> nil) and (Panel.Item <> nil) then
    begin
      if not TLMDDBDiagramItems(Panel.Item.Collection).Diagram.DrawItemLine(Panel.Item,
        Index, Canvas, Rect, State) then
        inherited;
    end
  else
    inherited;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDDBDiagramItemListBox.Create(AOwner: TComponent);
begin
  inherited;

  ParentFont   := True; // Get Font from diagram.
  ControlStyle := ControlStyle + [csClickEvents];

  {$IFDEF _LMD_UNICODEIMPL}
  FItems := TLMDListBoxItems.Create(Self, inherited Items);
  {$ELSE}
  FItems := inherited Items;
  {$ENDIF}
end;

destructor TLMDDBDiagramItemListBox.Destroy;
begin
  inherited;
  {$IFDEF _LMD_UNICODEIMPL}
  FItems.Free;
  {$ENDIF}
end;

{ ********************** class TLMDDBDiagramItemPanel ************************ }
{ ------------------------------ private ------------------------------------- }
procedure TLMDDBDiagramItemPanel.UpdateListBoxStyle;
begin
  FListBox.Style := TLMDDBDiagramItems(Item.Collection).Diagram.ItemStyle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagramItemPanel.GetItem: TLMDDBDiagramItem;
begin
  Result := TLMDDBDiagramItem(inherited Item);
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDDBDiagramItemPanel.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    begin
      Style := Style or WS_CLIPCHILDREN;
      WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
    end;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDDBDiagramItemPanel.Create(AOwner: TComponent;
  AItem: TLMDDiagramItem);
begin
  inherited;
  FListBox := TLMDDBDiagramItemListBox.Create(Self);
  FListBox.Align := alClient;
  UpdateListBoxStyle; // Call before FListBox.Parent assignment
  FListBox.Parent := Self;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDBDiagramItemPanel.Destroy;
begin
  FListBox.Free;
  inherited;
end;

{ ************************ class TLMDDBDiagramItem *************************** }
{ ------------------------------ private ------------------------------------- }
procedure TLMDDBDiagramItem.UpdateListBoxStyle;
begin
  if Panel <> nil then
    Panel.UpdateListBoxStyle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagramItem.ListBoxAvailable: Boolean;
begin
  Result := (Panel <> nil) and (Panel.ListBox <> nil) and
    Panel.ListBox.HandleAllocated;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItem.LinesChange(Sender: TObject);
begin
  FItemsChanged := True;
  TLMDDBDiagramItems(Collection).Diagram.Change;
  Changed(False);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItem.SetLines(const Value: TLMDStrings);
begin
  FLines.Assign(Value);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagramItem.GetLineIndex: Integer;
begin
  if ListBoxAvailable then
    Result := Panel.ListBox.ItemIndex
  else
    Result := FLineIndex;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItem.SetLineIndex(Value: Integer);
begin
  if ListBoxAvailable then
    Panel.ListBox.ItemIndex := Value
  else
    begin
      if (Value >= -1) and (Value <= Lines.Count - 1) then // Works like list box.
        FLineIndex := Value;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagramItem.GetPanel: TLMDDBDiagramItemPanel;
begin
  Result := TLMDDBDiagramItemPanel(inherited Panel);
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDDBDiagramItem.DoAssign(ASource: TPersistent);
var
  LTmp: TNotifyEvent;
begin
  inherited;
  LTmp := TLMDMemoryStrings(FLines).OnChange;
  TLMDMemoryStrings(FLines).OnChange := nil;
  try
    FLines.Assign(TLMDDBDiagramItem(ASource).Lines);
  finally
    TLMDMemoryStrings(FLines).OnChange := LTmp;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItem.Update(var ARefreshLinks: Boolean);
var
  LCount, LLineIndex: Integer;
begin
  inherited;
  if (Panel <> nil) and (Panel.ListBox <> nil) and (isColorChanged in State) then
    Panel.ListBox.Color := Color;

  if FItemsChanged then
    begin
      if (Panel <> nil) and (Panel.ListBox <> nil) and
        Panel.ListBox.HandleAllocated then
        begin
          LCount := Panel.ListBox.Items.Count;
          ARefreshLinks := ARefreshLinks or (LCount <> Lines.Count);
          LLineIndex := Panel.ListBox.ItemIndex;
          if Assigned(Lines) then
            Panel.ListBox.Items.Assign(Lines);
          Panel.ListBox.ItemIndex := LLineIndex;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItem.ForceUpdate;
begin
  inherited;
  FItemsChanged := True;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItem.MakeUpdated;
begin
  inherited;
  FItemsChanged := False;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagramItem.GetPanelClass: TLMDDiagramItemPanelClass;
begin
  Result := TLMDDBDiagramItemPanel;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItem.Select(ASelect: Boolean);
begin
  inherited;
  if ASelect then
    begin
      if GetLineIndex = -1 then
        begin
          if FOldItemIndex < 0 then FOldItemIndex := 0;
          if FOldItemIndex > Lines.Count - 1 then
            FOldItemIndex := Lines.Count - 1;
          if ListBoxAvailable then
            Panel.ListBox.ItemIndex := FOldItemIndex
          else
            FLineIndex := FOldItemIndex;
        end;
    end
    else
      begin
        if ListBoxAvailable then
          begin
            FOldItemIndex := Panel.ListBox.ItemIndex;
            Panel.ListBox.ItemIndex := -1;
          end
        else
          begin
            FOldItemIndex := FLineIndex;
            FLineIndex := -1;
          end;
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItem.SetFocus;
begin
  if not (csDesigning in TLMDDBDiagramItems(Collection).Diagram.ComponentState) and
    (Panel <> nil) and (Panel.ListBox <> nil) and Panel.ListBox.HandleAllocated and
    Panel.ListBox.CanFocus then
    Windows.SetFocus(Panel.ListBox.Handle);
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDDBDiagramItem.Create(Collection: TCollection);
begin
  FLineIndex := -1;
  FLines     := TLMDMemoryStrings.Create;
  TLMDMemoryStrings(FLines).OnChange := LinesChange;

  inherited;

  Color := clWindow;
  TLMDDBDiagramItems(Collection).Diagram.DBItemInsert(Self);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDBDiagramItem.Destroy;
begin
  TLMDDBDiagramItems(Collection).Diagram.DBItemDelete(Self);
  FLines.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagramItem.LineAtPos(APos: TPoint;
  AExisting: Boolean): Integer;
begin
  if ListBoxAvailable then
    begin
      APos := TLMDDBDiagramItems(Collection).Diagram.ClientToScreen(APos);
      APos := Panel.ListBox.ScreenToClient(APos);
      Result := Panel.ListBox.ItemAtPos(APos, AExisting);
    end
  else
    Result := -1;
end;

{ *********************** class TLMDDBDiagramItems *************************** }
{ ------------------------------ private ------------------------------------- }
function TLMDDBDiagramItems.GetItem(Index: Integer): TLMDDBDiagramItem;
begin
  Result := TLMDDBDiagramItem(inherited Items[Index]);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagramItems.SetItem(Index: Integer;
  const Value: TLMDDBDiagramItem);
begin
  inherited Items[Index] := Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagramItems.GetDiagram: TLMDDBDiagram;
begin
  Result := TLMDDBDiagram(inherited Diagram);
end;

{ ------------------------------ public -------------------------------------- }
function TLMDDBDiagramItems.Find(const AName: TLMDString): TLMDDBDiagramItem;
begin
  Result := TLMDDBDiagramItem(inherited Find(AName));
end;

{ ************************** class TLMDDBDiagram ***************************** }
{ ------------------------------ private ------------------------------------- }
function TLMDDBDiagram.GetItems: TLMDDBDiagramItems;
begin
  Result := TLMDDBDiagramItems(inherited Items);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagram.SetItems(const Value: TLMDDBDiagramItems);
begin
  inherited Items := Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagram.GetLinks: TLMDDBDiagramLinks;
begin
  Result := TLMDDBDiagramLinks(inherited Links);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagram.SetLinks(const Value: TLMDDBDiagramLinks);
begin
  inherited Links := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagram.SetItemStyle(const Value: TListBoxStyle);
var
  LI: Integer;
begin
  if FItemStyle <> Value then
    begin
      FItemStyle := Value;
      for LI := 0 to Items.Count - 1 do
        Items[LI].UpdateListBoxStyle;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagram.GetSelectedItemLine: Integer;
begin
  if SelectedItem <> nil then
    Result := SelectedItem.GetLineIndex
  else
    Result := -1;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagram.SetSelectedItemLine(const Value: Integer);
begin
  if SelectedItem <> nil then
    SelectedItem.SetLineIndex(Value);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagram.GetSelectedItem: TLMDDBDiagramItem;
begin
  Result := TLMDDBDiagramItem(inherited SelectedItem);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagram.GetSelectedLink: TLMDDBDiagramLink;
begin
  Result := TLMDDBDiagramLink(inherited SelectedLink);
end;

procedure TLMDDBDiagram.SetSelectedItem(const Value: TLMDDBDiagramItem);
begin
  inherited SelectedItem := Value;
end;

procedure TLMDDBDiagram.SetSelectedLink(const Value: TLMDDBDiagramLink);
begin
  inherited SelectedLink := Value;
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDDBDiagram.GetItemClass: TLMDDiagramItemClass;
begin
  Result := TLMDDBDiagramItem;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagram.GetLinkClass: TLMDDiagramLinkClass;
begin
  Result := TLMDDBDiagramLink;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagram.CreateLinkDrawInfo(
  ALink: TLMDDiagramLink): TLMDLinkDrawInfo;
var
  LRect: TRect;
  LY, LCYSmCaption, LCYBorder: Integer;
  LDI: TLMDDBLinkDrawInfo;
begin
  Result := inherited CreateLinkDrawInfo(ALink);
  LDI := Result as TLMDDBLinkDrawInfo;
  if LDI <> nil then
    begin
      LCYSmCaption := GetSystemMetrics(SM_CYSMCAPTION);
      LCYBorder := GetSystemMetrics(SM_CYBORDER);

      LRect := TLMDDBDiagramItemPanel(ALink.BeginItem.Panel).ListBox.ItemRect(
        TLMDDBDiagramLink(ALink).BeginLineIndex
      );

      LY := (LRect.Top + LRect.Bottom) div 2;
      if LY < 0 then
        LY := - LCYBorder * 2 - LCYSmCaption div 2
      else if LY > TLMDDBDiagramItemPanel(ALink.BeginItem.Panel).ListBox.Height then
        LY := TLMDDBDiagramItemPanel(ALink.BeginItem.Panel).ListBox.Height;

      LDI.BeginP.Y := ALink.BeginItem.Top + LCYBorder * 2 +
        LCYSmCaption + LY + 4 {???};
      LDI.LineBegin.Y := LDI.BeginP.Y;

      LRect := TLMDDBDiagramItemPanel(ALink.EndItem.Panel).ListBox.ItemRect(
        TLMDDBDiagramLink(ALink).EndLineIndex
      );

      LY := (LRect.Top + LRect.Bottom) div 2;
      if LY < 0 then
        LY := - LCYBorder * 2 - LCYSmCaption div 2
      else if LY > TLMDDBDiagramItemPanel(ALink.EndItem.Panel).ListBox.Height then
        LY := TLMDDBDiagramItemPanel(ALink.EndItem.Panel).ListBox.Height;

      LDI.EndP.Y := ALink.EndItem.Top + LCYBorder * 2 +
        LCYSmCaption + LY + 4 {???};
      LDI.LineEnd.Y := LDI.EndP.Y;
      LDI.BeginType := TLMDDBDiagramLink(ALink).BeginPointType;
      LDI.EndType := TLMDDBDiagramLink(ALink).EndPointType;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagram.IsEqualDrawInfos(ADrawInfo1,
  ADrawInfo2: TLMDLinkDrawInfo): Boolean;
var
  LDI1, LDI2: TLMDDBLinkDrawInfo;
begin
  Result := inherited IsEqualDrawInfos(ADrawInfo1, ADrawInfo2);
  if Result then
    begin
      LDI1 := ADrawInfo1 as TLMDDBLinkDrawInfo;
      LDI2 := ADrawInfo2 as TLMDDBLinkDrawInfo;
      Result := (LDI1.BeginType = LDI2.BeginType) and (LDI1.EndType = LDI2.EndType);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagram.GetLinkDrawInfoClass: TLMDLinkDrawInfoClass;
begin
  Result := TLMDDBLinkDrawInfo;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagram.PaintLink(ADrawInfo: TLMDLinkDrawInfo;
  AClear: Boolean);
var
  LBmp: TBitmap;
  LBeginBmpdX, LEndBmpdX: Integer;
  LDI: TLMDDBLinkDrawInfo;
begin
  inherited;

  LDI := ADrawInfo as TLMDDBLinkDrawInfo;

  { Paint bitmaps }

  LBeginBmpdX := - LMDRectSize * Ord(not LDI.LeftToRight);

  case LDI.BeginType of
    lptOne: LBmp := FOneBitmap;
    lptInfinity: LBmp := FInfinityBitmap;
  else
    LBmp := nil;
  end;

  if LBmp <> nil then
    if AClear then
      Canvas.FillRect(Rect(
        LDI.BeginP.X - HScrollPos + LBeginBmpdX,
        LDI.BeginP.Y - VScrollPos - 10,
        LDI.BeginP.X - HScrollPos + LBeginBmpdX + LBmp.Width,
        LDI.BeginP.Y - VScrollPos - 10 + LBmp.Height
      ))
    else
      Canvas.Draw(
        LDI.BeginP.X - HScrollPos + LBeginBmpdX,
        LDI.BeginP.Y - VScrollPos - 10,
        LBmp
      );

  LEndBmpdX := - LMDRectSize * Ord(LDI.LeftToRight);

  case LDI.EndType of
    lptOne: LBmp := FOneBitmap;
    lptInfinity: LBmp := FInfinityBitmap;
  else
    LBmp := nil;
  end;

  if LBmp <> nil then
    if AClear then
      Canvas.FillRect(Rect(
        LDI.EndP.X - HScrollPos + LEndBmpdX,
        LDI.EndP.Y - VScrollPos - 10,
        LDI.EndP.X - HScrollPos + LEndBmpdX + LBmp.Width,
        LDI.EndP.Y - VScrollPos - 10 + LBmp.Height
      ))
    else
      Canvas.Draw(
        LDI.EndP.X - HScrollPos + LEndBmpdX,
        LDI.EndP.Y - VScrollPos - 10,
        LBmp
      );
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagram.CreateItems: TLMDDiagramItems;
begin
  Result := TLMDDBDiagramItems.Create(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagram.CreateLinks: TLMDDiagramLinks;
begin
  Result := TLMDDBDiagramLinks.Create(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagram.ItemInsert(AItem: TLMDDiagramItem);
begin
  // Do nothing (do not call inherited)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagram.DBItemInsert(AItem: TLMDDiagramItem);
begin
  if Assigned(OnInsertItem) then OnInsertItem(Self, AItem);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagram.ItemDelete(AItem: TLMDDiagramItem);
begin
  // Do nothing (do not call inherited)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagram.DBItemDelete(AItem: TLMDDiagramItem);
begin
  if Assigned(OnDeleteItem) then OnDeleteItem(Self, AItem);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagram.MeasureItemLine(AItem: TLMDDBDiagramItem;
  ALineIndex: Integer; var AHeight: Integer): Boolean;
begin
  Result := Assigned(OnMeasureItemLine);
  if Result then
    OnMeasureItemLine(Self, AItem, ALineIndex, AHeight);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagram.DrawItemLine(AItem: TLMDDBDiagramItem; ALineIndex: Integer;
  ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState): Boolean;
begin
  Result := Assigned(OnDrawItemLine);
  if Result then
    OnDrawItemLine(Self, AItem, ALineIndex, ACanvas, ARect, AState);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBDiagram.ItemClick(AItem: TLMDDBDiagramItem);
begin
  if Assigned(OnItemClick) then
    OnItemClick(Self, AItem);
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDDBDiagram.Create(AOwner: TComponent);
begin
  inherited;
  FOneBitmap := TBitmap.Create;
  FOneBitmap.LoadFromResourceName(HInstance, 'ELDGRM_ONE');
  FOneBitmap.Transparent := True;
  FInfinityBitmap := TBitmap.Create;
  FInfinityBitmap.LoadFromResourceName(HInstance, 'ELDGRM_INF');
  FInfinityBitmap.Transparent := True;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDBDiagram.Destroy;
begin
  FOneBitmap.Free;
  FOneBitmap := nil;
  FInfinityBitmap.Free;
  FInfinityBitmap := nil;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagram.LinkAtPos(AX, AY: Integer): TLMDDBDiagramLink;
begin
  Result := TLMDDBDiagramLink(inherited LinkAtPos(AX, AY));
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBDiagram.ItemAtPos(AX, AY: Integer): TLMDDBDiagramItem;
begin
  Result := TLMDDBDiagramItem(inherited ItemAtPos(AX, AY));
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDBDiagramItemListBox.SetItems(const Value: TLMDStrings);
begin
  FItems.Assign(Value);
end;
  
{ ---------------------------------------------------------------------------- }

end.
