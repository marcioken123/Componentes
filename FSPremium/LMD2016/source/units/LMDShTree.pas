unit LMDShTree;
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

LMDShTree unit (DS)
-------------------
Contains shell Tree View


Changes
-------
Release 8.0 (September 2006)
 - Initial Release

###############################################################################}

interface
uses
  Windows, Classes, Dialogs, ComCtrls, Graphics, Controls, ExtCtrls, CommCtrl,
  Messages, ShlObj, ActiveX, ShellAPI,
  LMDShBase, LMDShView, LMDShFolder, LMDShMisc, LMDShItem, LMDControl, LMDTypes;

type
  {****************************************************************************}
  TLMDShellTreeOption = (toShowHidden, toShowFolders, toShowNonFolders,
    toAllowRename, toAllowDrag, toAllowDrop, toColorCompressed, toExpandTopNode,
    toExtendedMenu, toShellMenu);

  TLMDShellTreeOptions = set of TLMDShellTreeOption;

  {****************************************************************************}
  TLMDShellTreeNode = class(TTreeNode)
  private
    FShellItem: TLMDCustomShellItem;
    procedure SetShellItem(const aValue : TLMDCustomShellItem);
  protected
    procedure SetHasChildren;
  public
    { constructor / destructor }
    constructor Create(AOwner: TTreeNodes); {$ifdef LMD_NATIVEUNICODE}override;{$endif}
    destructor Destroy; override;

    { properties }
    property ShellItem: TLMDCustomShellItem read FShellItem write SetShellItem;
  end;

  {****************************************************************************}
  TLMDShellTree = class(TLMDBaseTreeView, IUnknown,
                        ILMDShellView, ILMDShellEdit, IDropTarget)
  private
    { property variables }
    FShellFolder        : TLMDShellFolder;
    FCompressedColor    : TColor;
    FFileFilter         : TStringList;
    FFiltered           : boolean;
    FOptions            : TLMDShellTreeOptions;
    FShowCheckBoxes     : boolean;

    { internal variables }
    FStateImages        : TImageList;
    FItemsCache         : TLMDShellItemsList;
    FCheckedItems       : TLMDShellItemsList;
    FEnumOptions        : TLMDShellEnumOptions;
    FClickPoint         : TPoint;
    FChangeLocked       : boolean;
    FActiveChangeLocked : boolean;
    FDataObject         : IDataObject;
    FDragScroll         : boolean;
    FDoingDragDrop      : boolean;
    FDropTargetNode     : TTreeNode;
    FDragNode           : TTreeNode;

    { V2.0 }
    FAutoContext        : boolean;
    FAutoSortSupport    : boolean;
    FSelectionInfoEvent : TLMDShellInfoEvent;

    FRefreshTimer       : TTimer;
    FRefreshList        : TList;

    { events }
    FOnFilterItem       : TLMDShellItemFilter;
    FOnItemSelected     : TLMDShellItemEvent;

    { property methods }
    procedure SetShellFolder(const aValue : TLMDShellFolder);
    procedure SetCompressedColor(const aValue : TColor);
    function GetFileFilter : string;
    procedure SetFileFilter(const aValue : string);
    procedure SetFiltered(const aValue : boolean);
    procedure SetOptions(const aValue : TLMDShellTreeOptions);
    procedure SetShowCheckBoxes(const aValue : boolean);
    function GetSelectedItem : TLMDCustomShellItem;

    { V2.0 }
    function GetShowNonFolder : boolean;
    procedure SetShowNonFolder(const value : boolean);

    { internal methods }
    procedure RepaintEx;
    procedure ReloadTree;
    procedure EnumItems(aPIDL : PItemIDList; var aItems : TLMDShellItemsList);
    procedure DoAdvancedCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
        State: TCustomDrawState; Stage: TCustomDrawStage;
        var PaintImages, DefaultDraw: Boolean);
//    function GetNodeFromItem(const Item: TTVItem): TTreeNode;
    procedure AddToRefreshList(Node: TTreeNode);
    procedure RefreshTimerFire(Sender: TObject);
    function  GetReadOnly: Boolean;
    procedure SetReadOnly(Value: Boolean);
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure FakeReadMethod(Reader: TReader);
    function  ChangeTimerNode: TTreeNode;
    function  GetChangeDelay: integer;
    procedure SetChangeDelay(V: integer);
    function GetCheckedCount: Integer;
    function GetCheckedItem(const Index: Integer): TLMDCustomShellItem;
    procedure HandlerCheckItem(Sender: TObject; Checked: Boolean);
  protected
    procedure DoFilterItem(const aItem : TLMDCustomShellItem; var aAccept : Boolean); virtual;

    { base class methods }
    procedure DefineProperties(Filer: TFiler); override;
    procedure Change(Node : TTreeNode); override;
    function  CanExpand(Node : TTreeNode) : Boolean; override;
    procedure Collapse(Node: TTreeNode); override;
    procedure Edit(const Item : TTVItem); override;
    function  CanEdit(Node : TTreeNode): Boolean; override;
    procedure Click; override;
    function CreateNode : TTreeNode; override;

    procedure Loaded; override;
    procedure CreateWnd; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DestroyWnd; override;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;

    procedure WndProc(var Message : TMessage); override;

    procedure CNNotify(var Message : TWMNotify); message CN_Notify;

    procedure DoCustomDrawItem(Sender : TCustomTreeView; Node : TTreeNode;
              State : TCustomDrawState; var DefaultDraw : Boolean); virtual;

    procedure ToggleItemCheckbox(Node: TTreeNode; AChecked: Boolean);
    { IDropTarget }
    function IDropTarget.DragEnter = ShellTreeDragEnter;
    function IDropTarget.DragOver = ShellTreeDragOver;
    function IDropTarget.DragLeave = ShellTreeDragLeave;
    function IDropTarget.Drop = ShellTreeDrop;

    function ShellTreeDragEnter(const dataObj : IDataObject; grfKeyState : Longint;
      pt : TPoint; var dwEffect : Longint): HResult; stdcall;
    function ShellTreeDragOver(grfKeyState : Longint; pt : TPoint;
      var dwEffect : Longint): HResult;  stdcall;
    function ShellTreeDragLeave : HResult;  stdcall;
    function ShellTreeDrop(const dataObj : IDataObject; grfKeyState : Longint;
      pt : TPoint; var dwEffect : Longint): HResult;  stdcall;
    function  FindNodeByShellItem(AItem: TLMDShellItem): TLMDShellTreeNode;
  public
    { constructor / destructor }
    constructor Create(aOwner : TComponent); override;
    destructor Destroy; override;

    { ILMDView methods }
    // ----------------------
    procedure BeginUpdate;
    procedure EndUpdate;

    procedure BeginEnumeration;
    procedure EndEnumeration;
    function TerminateEnumeration : boolean;
    procedure AddItem(aItem : TLMDCustomShellItem);
    procedure ActiveFolderChanged;
    function  Controller:TLMDCustomShellController;
    function  FindNode(PIDL : PItemIDList; CanExpand: Boolean): TLMDShellTreeNode;

    procedure DoFileChange(aPIDL : PItemIDList);
    procedure DoFileCreate(aPIDL : PItemIDList);
    procedure DoFileDelete(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
    procedure DoFileRename(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
    procedure DoFolderChange(aPIDL : PItemIDList);
    procedure DoFolderCreate(aPIDL : PItemIDList);
    procedure DoFolderDelete(aPIDL : PItemIDList);
    procedure DoFolderRename(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
    // ----------------------

    // RM 30-July-2003 - ILMDShellEdit
    // ----------------
    function Editable:Boolean;
    function CanCut:Boolean;
    function CanCopy:Boolean;
    function CanDelete:Boolean;
    function CanPaste:Boolean;
    function CanRename:Boolean;
    function CanAccessItem:Boolean;

    procedure ExecuteCommand(const Verb: String; var Handled: Boolean);

    procedure CopyToClipboard;
    procedure CutToClipboard;
    procedure PasteFromClipboard;

    procedure CopyItems(const Target:String);
    procedure MoveItems(const Target:String);

    procedure DeleteItems;
    function  Rename: Boolean;
    procedure ShowProperties;

    procedure CopyFileNameAsText;
    procedure CopyPathAsText;
    procedure Open;
    procedure OpenWith;
    // ----------------

    procedure MailTo;
    function  NewFolder: Boolean;

    procedure RefreshBranches(const aNodes: array of TTreeNode);
    procedure RefreshBranch(Node: TTreeNode);

    procedure ClearCheckboxes();
    function getLMDPackage:TLMDPackageID;override;

    { properties }
    property SelectedItem : TLMDCustomShellItem read GetSelectedItem;
    property CheckedCount: Integer read GetCheckedCount;
    property CheckedItems[const Index: Integer]: TLMDCustomShellItem read GetCheckedItem;
  published
    { properties }
    property About;
    property Align;
    property Anchors;
    property AutoExpand;
    property BiDiMode;
    property BorderWidth;
    property ChangeDelay read GetChangeDelay write SetChangeDelay default 500;
    property Constraints;
    property HotTrack;
    property ParentBiDiMode;
    property ToolTips;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property Enabled;
    property Font;
    property HideSelection;
    property Indent;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowButtons;
    property ShowHint;
    property ShowLines;
    property ShowRoot;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnCollapsed;
    property OnCollapsing;
//    property OnCompare;
    property OnDblClick;
    property OnDeletion;
//    property OnDragDrop;
//    property OnDragOver;
    property OnEdited;
    property OnEditing;
//    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnExpanding;
    property OnExpanded;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
//    property OnStartDrag;
    property OnEndDock;
    property OnStartDock;
    property OnContextPopup;

    property Folder : TLMDShellFolder read FShellFolder write SetShellFolder;

    property CompressedColor : TColor read FCompressedColor write SetCompressedColor;

    property FileFilter : string read GetFileFilter write SetFileFilter;

    property Filtered : boolean read FFiltered write SetFiltered;

    property Options : TLMDShellTreeOptions read FOptions write SetOptions;
    property ShowCheckBoxes : boolean read FShowCheckBoxes write SetShowCheckBoxes;

    { events }
    property OnFilterItem : TLMDShellItemFilter read FOnFilterItem write FOnFilterItem;

    property OnItemSelected : TLMDShellItemEvent read FOnItemSelected write FOnItemSelected;

    { for v2.0 }
    property ShowNonFolders : boolean read GetShowNonFolder write SetShowNonFolder;

    property AutoContextMenus : boolean read FAutoContext write FAutoContext;

    property AutoSortSupport : boolean read FAutoSortSupport write FAutoSortSupport;

    property OnSelectionInfo : TLMDShellInfoEvent read FSelectionInfoEvent write FSelectionInfoEvent;
  end;

implementation

uses
  Imglist, Forms, SysUtils, Masks, ClipBrd, 
  LMDShDragDrop, LMDShPIDL, LMDShController, LMDUtils, LMDProcs, LMDSysIn, LMDStrings;

{** TLMDShellTreeNode *********************************************************}
{-- private  ------------------------------------------------------------------}
procedure TLMDShellTreeNode.SetShellItem(const aValue : TLMDCustomShellItem);
begin
  if FShellItem = aValue then Exit;
  FShellItem.Free;
  FShellItem := aValue;

  if TLMDShellTree(TreeView).ShowCheckBoxes then
    begin
      if FShellItem.Checked then StateIndex := 2
      else StateIndex := 1;
    end
  else
    StateIndex := -1;

  Text:= FShellItem.DisplayName;
  ImageIndex := FShellItem.IconIndex;
  SelectedIndex := FShellItem.OpenIconIndex;//ImageIndex;

  Cut := FShellItem.IsGhosted;
  OverlayIndex := FShellItem.OverlayIconIndex;
//  OverlayIndex := FShellItem.OpenIconIndex;

  HasChildren := FShellItem.HasRemovableMedia
    or not FShellItem.IsFileSystem
    or (LMDSIWindowsNT and not FShellItem.IsFileSystemAncestor)
    or TLMDShellTree(TreeView).FShellFolder.ID_HasChildren(FShellItem.AbsoluteID,
        TLMDShellTree(TreeView).FEnumOptions);
end;

{-- protected -----------------------------------------------------------------}
procedure TLMDShellTreeNode.SetHasChildren;
begin
  HasChildren := TLMDShellTree(TreeView).FShellFolder.ID_HasChildren(FShellItem.AbsoluteID,
    TLMDShellTree(TreeView).FEnumOptions);
end;

{ --------------------------------- public  ---------------------------------- }
constructor TLMDShellTreeNode.Create(AOwner: TTreeNodes);
begin
  inherited;
  FShellItem := nil;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDShellTreeNode.Destroy;
begin
  if FShellItem <> nil then FShellItem.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellTree.FakeReadMethod(Reader: TReader);
begin
  Reader.ReadIdent;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellTree.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('OnDragDrop', FakeReadMethod, nil, false);
  Filer.DefineProperty('OnDragOver', FakeReadMethod, nil, false);
  Filer.DefineProperty('OnEndDrag', FakeReadMethod, nil, false);
  Filer.DefineProperty('OnCompare', FakeReadMethod, nil, false);
  Filer.DefineProperty('OnStartDrag', FakeReadMethod, nil, false);
end;

{** TLMDShellTree *************************************************************}
{-- private -------------------------------------------------------------------}
procedure TLMDShellTree.SetShellFolder(const aValue : TLMDShellFolder);
begin
  if FShellFolder = aValue then Exit;

  if FShellFolder <> nil then FShellFolder.UnRegisterView(Self);
  Items.Clear;
  FShellFolder := aValue;
  if FShellFolder <> nil then
    begin
      FShellFolder.RegisterView(Self);
      Images := FShellFolder.SmallFolderImages;

      if  HandleAllocated then
        begin
          ReloadTree;
          ActiveFolderChanged;
        end;
      Exit;
    end;
  RepaintEx;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.SetCompressedColor(const aValue : TColor);
begin
  if FCompressedColor = aValue then Exit;
  FCompressedColor := aValue;
  if (toColorCompressed in FOptions) then RepaintEx;
end;

{------------------------------------------------------------------------------}
function TLMDShellTree.GetFileFilter : string;
begin
  result := FFileFilter.DelimitedText;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.SetFileFilter(const aValue : string);
begin
  if FileFilter = aValue then Exit;
  FFileFilter.DelimitedText := aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.SetFiltered(const aValue : boolean);
begin
  if FFiltered = aValue then Exit;
  FFiltered := aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.SetOptions(const aValue : TLMDShellTreeOptions);
var
  NeedRepaint : boolean;
begin
  if FOptions = aValue then Exit;
  NeedRepaint := (not (toColorCompressed in FOptions) and (toColorCompressed in aValue)) or
     ((toColorCompressed in FOptions) and not (toColorCompressed in aValue));
  FOptions := aValue;

  FEnumOptions := [];
  if toShowHidden in FOptions then Include(FEnumOptions, eoIncludeHidden);
  if toShowFolders in FOptions then Include(FEnumOptions, eoFolders);
  if toShowNonFolders in FOptions then Include(FEnumOptions, eoNonFolders);

  if NeedRepaint then RepaintEx;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.SetShowCheckBoxes(const aValue : boolean);
var
  i : integer;
begin
  if FShowCheckBoxes = aValue then Exit;
  FShowCheckBoxes := aValue;

  Items.BeginUpdate;
  for i := 0 to Items.count-1 do
    if not FShowCheckBoxes then Items[i].StateIndex := -1
    else
//      with TLMDShellTreeNode(Items[i]).ShellItem do
      with TLMDShellTreeNode(Items[i]) do
      begin
//        if ShellItem.Checked then TLMDShellTreeNode(Items[i]).StateIndex := 2
//        else TLMDShellTreeNode(Items[i]).StateIndex := 1;
        if ShellItem.Checked then
          StateIndex := 2
        else
          StateIndex := 1;
      end;
  Items.EndUpdate;

  RepaintEx;
end;

{------------------------------------------------------------------------------}
function TLMDShellTree.GetSelectedItem : TLMDCustomShellItem;
begin
  result := nil;
  if Selected = nil then Exit;
  result := TLMDShellTreeNode(Selected).ShellItem;
end;

{------------------------------------------------------------------------------}
function TLMDShellTree.GetShowNonFolder : boolean;
begin
  result := toShowNonFolders in FOptions;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.HandlerCheckItem(Sender: TObject; Checked: Boolean);
begin
  ToggleItemCheckbox(FindNodeByShellItem(TLMDShellItem(Sender)), Checked);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.SetShowNonFolder(const value : boolean);
begin
  if value then Options := Options + [toShowNonFolders]
  else Options := Options - [toShowNonFolders];
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.RepaintEx;
var
  R : TRect;
begin
  if  not HandleAllocated then
    exit;

  R := ClientRect;
  LMDInvalidateRect(Handle, R, False);
  Update;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.CMShowingChanged(var Message: TMessage);
begin
  inherited ;

  if  Items.Count = 0 then
    ReloadTree;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.ReloadTree;
begin
  Items.BeginUpdate;
  Items.Clear;
  if FShellFolder <> nil then
    with TLMDShellTreeNode(Items.AddChild(nil, '')) do
      ShellItem := FShellFolder.CreateShellItem(FShellFolder.NamespaceRootID);
  Items.EndUpdate;

  if  Assigned(TopItem) then
    TopItem.Expand(False);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.EnumItems(aPIDL : PItemIDList; var aItems : TLMDShellItemsList);
begin
  FItemsCache := aItems;
  Screen.Cursor := crHourGlass;
  try
    FShellFolder.Enumerate(aPIDL, Self, FEnumOptions);
  finally
    Screen.Cursor := crDefault;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDShellTree.ShellTreeDragEnter(const dataObj : IDataObject;
    grfKeyState : Longint; pt : TPoint; var dwEffect : Longint): HResult;
var
  FE       : TFormatEtc;
  ClientPt : TPoint;
begin
  FDataObject := nil;

  FE.cfFormat := CF_HDROP;
  FE.dwAspect := DVASPECT_CONTENT;
  FE.ptd := nil;
  FE.tymed := TYMED_HGLOBAL;
  FE.lindex := -1;

  if (dataObj.QueryGetData(FE) <> NOERROR) then
  begin
    dwEffect := DROPEFFECT_NONE;
    result := NOERROR;
  end
  else
  begin
    FDataObject := dataObj;
    Result := NOERROR;
  end;
  ImageList_GetDragImage(nil, nil);
  ClientPt := ScreenToClient(pt);
  ImageList_DragEnter(Handle, ClientPt.x, ClientPt.y);
  FDragScroll := False;
end;

{------------------------------------------------------------------------------}
function TLMDShellTree.ShellTreeDragOver(grfKeyState : Longint; pt : TPoint; var dwEffect : Longint): HResult;
var
  ClientPt      : TPoint;
  Node          : TTreeNode;
  ScrollPos     : Integer;
  ShellItem     : TLMDCustomShellItem;
  DropTargetIntf    : IDropTarget;
  OldRect       : TRect;
  NewRect       : TRect;
begin
  result := S_OK;
  if FDataObject = nil then
    begin
      dwEffect := DROPEFFECT_NONE;
    end
  else
    begin
      OldRect := Rect(0, 0, 0, 0);
      FDoingDragDrop := True;
      ClientPt := ScreenToClient(pt);
      Node := GetNodeAt(ClientPt.X, ClientPt.Y);
      if Node <> nil then
        begin
          ClientPt := ScreenToClient(pt);
          ScrollPos := GetScrollPos(Handle, SB_HORZ);
          if (ClientPt.Y < 10) and (Node <> Items[0]) then
            begin
              Sleep(30);
              ImageList_DragShowNoLock(False);
              if ScrollPos <> 1 then SendMessage(Handle, WM_SETREDRAW, 0, 0);
              TopItem := Node.GetPrevVisible;
              if ScrollPos <> 1 then
                begin
                  SendMessage(Handle, WM_HSCROLL, SB_LEFT, 0);
                  SendMessage(Handle, WM_SETREDRAW, 1, 0);
                end;
              ImageList_DragShowNoLock(True);
              FDragScroll := True;
            end;

          if (ClientPt.Y > Height - 30) and (Node.GetNext <> nil) then
            begin
              Sleep(30);
              ImageList_DragShowNoLock(False);
              if ScrollPos <> 1 then SendMessage(Handle, WM_SETREDRAW, 0, 0);
              SendMessage(Handle, WM_SETREDRAW, 0, 0);
              TopItem := TopItem.GetNextVisible;
              if ScrollPos <> 1 then
                begin
                  SendMessage(Handle, WM_HSCROLL, SB_LEFT, 0);
                  SendMessage(Handle, WM_SETREDRAW, 1, 0);
                end;
              ImageList_DragShowNoLock(True);
              FDragScroll := True;
            end;
          ShellItem := TLMDShellTreeNode(Node).ShellItem;
          DropTargetIntf := ShellItem.DropTargetIntf;
          if DropTargetIntf <> nil then
            begin
              DropTargetIntf.DragEnter(FDataObject, grfKeyState, pt, dwEffect);
              result := DropTargetIntf.DragOver(grfKeyState, pt, dwEffect);
              DropTargetIntf.DragLeave;
              DropTargetIntf := nil;
            end;

          if FDropTargetNode <> Node then
            begin
              if FDropTargetNode <> nil then
                begin
                  FDropTargetNode.DropTarget := False;
                  OldRect := FDropTargetNode.DisplayRect(True);
                end;

              Node.DropTarget := True;
              FDropTargetNode := Node;
              ImageList_DragMove(ClientPt.x, ClientPt.y);
              ImageList_DragShowNoLock(False);

              if FDragScroll then
                begin
                  NewRect := ClientRect;
                  FDragScroll := False;
                end
              else
                begin
                  NewRect := Node.DisplayRect(True);
                  LMDInvalidateRect(Handle, OldRect, False);
                end;

              LMDInvalidateRect(Handle, NewRect, False);
              UpdateWindow(Handle);
              ImageList_DragShowNoLock(True);
              Exit;
            end;
        end
      else dwEffect := DROPEFFECT_NONE;
    end;
  ImageList_DragMove(ClientPt.x, ClientPt.y);
end;

{------------------------------------------------------------------------------}
function TLMDShellTree.ShellTreeDragLeave : HResult;
begin
  FDataObject := nil;
  result := NOERROR;
  FDoingDragDrop := False;
  ImageList_DragLeave(Handle);
  if FDropTargetNode <> nil then
    begin
      FDropTargetNode.DropTarget := False;
      FDropTargetNode := nil;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDShellTree.ShellTreeDrop(const dataObj : IDataObject; grfKeyState : Longint; pt : TPoint; var dwEffect : Longint): HResult;
var
  Node       : TTreeNode;
  ClientPt   : TPoint;
  DropTargetIntf : IDropTarget;
  ShellItem  : TLMDCustomShellItem;
begin
  result := S_OK;
  if FDataObject = nil then
    begin
      result := E_FAIL;
      Exit;
    end;
  ShellTreeDragLeave;
  ClientPt := ScreenToClient(pt);
  Node := GetNodeAt(ClientPt.X, ClientPt.Y);
  if Assigned(Node) then
    begin
      ShellItem := TLMDShellTreeNode(Node).ShellItem;
      grfKeyState := grfKeyState or MK_LBUTTON;
      DropTargetIntf := ShellItem.DropTargetIntf;
      if Assigned(DropTargetIntf) then
        begin
          DropTargetIntf.DragEnter(dataObj, grfKeyState, pt, dwEffect);
          result := DropTargetIntf.Drop(dataObj, grfKeyState, pt, dwEffect);
          DropTargetIntf.DragLeave;
          DropTargetIntf := nil;
        end;

      if FDropTargetNode <> nil then
        begin
          FDropTargetNode.DropTarget := False;
          FDropTargetNode := nil;
        end;

      if  Assigned(FDragNode) then
        RefreshBranches([FDragNode.Parent, Node.Parent])
      else
        RefreshBranch(Node.Parent);

      FDragNode := nil;
    end;
  FDoingDragDrop := False;
end;

{-- protected -----------------------------------------------------------------}
procedure TLMDShellTree.DoFilterItem(const aItem : TLMDCustomShellItem; var aAccept : Boolean);

  function FilterItem : boolean;
  var
    i : LongInt;
  begin
    result := False;
    for I:= 0 to FFileFilter.count - 1 do
      if MatchesMask(aItem.DisplayName, FFileFilter[i]) then
        begin
          result := True;
          Break;
        end;
  end;

begin
  if (csDesigning in ComponentState) then Exit;
  if FFiltered then
    if FileFilter <> '' then aAccept := FilterItem
    else
      if assigned(FOnFilterItem) then
        FOnFilterItem(Self, aItem, aAccept);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.Change(Node : TTreeNode);
var
  N: TLMDShellTreeNode;
begin
  inherited;

  if  not Assigned(Node)  then
    exit;

  N := TLMDShellTreeNode(Node);

  if Assigned(FOnItemSelected) then
    FOnItemSelected(Self, N.ShellItem);

  if FChangeLocked or not Assigned(N.ShellItem) then
    Exit;

  FActiveChangeLocked := True;
  try
    //VB Jan 2007: Check added to fix double firing of OnChange event
    //(rep by Ron in lmdpacks newsgroup 19 Dec 2006)
    with FShellFolder do
      if not ID_Equal(ActiveFolder.AbsoluteID, N.ShellItem.AbsoluteID) then
        FShellFolder.ChDir(N.ShellItem.AbsoluteID);
  finally
    FActiveChangeLocked := False;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDShellTree.AddToRefreshList(Node: TTreeNode);
begin
//  if  Assigned(Node)  then
    begin
      if  not Assigned(FRefreshList)  then
        FRefreshList := TList.Create;

      if  not Assigned(FRefreshTimer) then
        begin
          FRefreshTimer := TTimer.Create(self);
          FRefreshTimer.Enabled := False;
          FRefreshTimer.Interval := 1000;
          FRefreshTimer.OnTimer := RefreshTimerFire;
        end;

      if  FRefreshList.IndexOf(Node) < 0  then
        begin
          FRefreshTimer.Enabled := False;
          FRefreshList.Add(Node);
          FRefreshTimer.Enabled := True;
        end;
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDShellTree.RefreshTimerFire(Sender: TObject);
var
  aNodes: array of TTreeNode;
  i: integer;
begin
  FRefreshTimer.Enabled := False;

  if  Assigned(FRefreshList) and (FRefreshList.Count > 0) then
    begin
      if  IsEditing then
        begin
          FRefreshTimer.Enabled := True;
          exit;
        end;

      SetLength(aNodes, FRefreshList.Count);

      for i := 0 to FRefreshList.Count - 1 do
        aNodes[i] := TTreeNode(FRefreshList[i]);

      FRefreshList.Clear;
      RefreshBranches(aNodes);
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDShellTree.RefreshBranches(const aNodes: array of TTreeNode);
  procedure CollectOpenNodes(Node: TTreeNode; Lst: TList);
  begin
    if  not Assigned(Node) and (Items.Count > 0) then
      Node := Items.GetFirstNode;

    if  Assigned(Node)  then
      begin
        if  Lst.IndexOf(Node) < 0 then
           Lst.Add(Node);

        Node := Node.getFirstChild;

        while Assigned(Node) do
          begin

            if  Node.Expanded then
              CollectOpenNodes(Node, Lst);

            Node := Node.getNextSibling;
          end;
      end;
  end;

  function  RemoveNodeMark(Node: TTreeNode; PIDLs: TList): Boolean;
  var
    i: integer;
    P: PItemIDList;
  begin
    Result := False;
    P := TLMDShellTreeNode(Node).ShellItem.AbsoluteID;

    for i := 0 to PIDLs.Count - 1 do
      if  FShellFolder.ID_Equal(P, PItemIDList(PIDLs[i]))  then
        begin
          FShellFolder.ID_Free(PItemIDList(PIDLs[i]));
          PIDLs.Delete(i);
          Result := True;
          break;
        end;
  end;

  procedure ExpandItems(Node: TTreeNode; PIDLs: TList);
  var
    N: TTreeNode;
  begin
    Node.Expand(False);
    N := Node;
    Node := Node.getFirstChild;

    if  Assigned(Node)  then
      while Assigned(Node) do
        begin
          if  RemoveNodeMark(Node, PIDLs)  then
            ExpandItems(Node, PIDLs);

          if  PIDLs.Count = 0 then
            break;

          Node := Node.getNextSibling;
        end
    else
      N.HasChildren := False;
  end;

var
  Lst, PIDLs: TList;
  i: integer;
  Node, SelNode, TopNode: TTreeNode;
  N: TLMDShellTreeNode;
  aItemId: array of HTreeItem;
  iSel, iTop: PItemIDList;
//  HTreeItem;
begin
  if FShellFolder = nil then Exit;

  if  Items.Count = 0 then
    ReloadTree;

  PIDLs := nil;
  SelNode := nil;
  TopNode := nil;
  iTop := nil;
  iSel := nil;
  Items.BeginUpdate;
  Lst := TList.Create;

  try
    if  Assigned(TopItem) then
      iTop := FShellFolder.ID_Clone(TLMDShellTreeNode(TopItem).ShellItem.AbsoluteID);

    if  Assigned(Selected)  then
      iSel := FShellFolder.ID_Clone(TLMDShellTreeNode(Selected).ShellItem.AbsoluteID);

    SetLength(aItemId, Length(aNodes));

    for i := Low(aNodes) to High(aNodes) do
      begin
        Node := aNodes[i];
        if  Assigned(Node)  then
          aItemId[i] := Node.ItemId
        else
          aItemId[i] := nil;

        if  Node.Expanded then
          CollectOpenNodes(Node, Lst);
      end;

    if  Lst.Count > 0 then
      begin
        PIDLs := TList.Create;
        PIDLs.Count := Lst.Count;

        for i := 0 to Lst.Count - 1 do
          begin
            N := TLMDShellTreeNode(Lst[i]);
            PIDLs[i] := FShellFolder.ID_Clone(N.ShellItem.AbsoluteID);
            Lst[i] := N.ItemId;
          end;

        for i := Lst.Count - 1 downto 0 do
          begin
            Node := Items.GetNode(HTREEITEM(Lst[i]));

            if  Assigned(Node)  then
              Node.Collapse(True);
          end;

        FreeAndNil(Lst);

        for i := Low(aItemId) to High(aItemId) do
          begin
            if  Assigned(aItemId[i])  then
              Node := Items.GetNode(aItemId[i])
            else
              Node := nil;

              if  Assigned(Node)  then
                begin
                  RemoveNodeMark(Node, PIDLs);
                  ExpandItems(Node, PIDLs);
                end;
          end;
      end;

    if  Assigned(iTop)  then
      TopNode := FindNode(iTop, True);

    if  Assigned(iSel)  then
      SelNode := FindNode(iSel, True);
  finally
    if  Assigned(iSel)  then
      FShellFolder.ID_Free(iSel);

    if  Assigned(iTop)  then
      FShellFolder.ID_Free(iTop);

    if  Assigned(PIDLs) then
      for i := 0 to PIDLs.Count - 1 do
        FShellFolder.ID_Free(PItemIDList(PIDLs[i]));

    PIDLs.Free;
    Lst.Free;
    Items.EndUpdate;
  end;

  if  Assigned(SelNode) then
    Selected := SelNode;

  if  Assigned(TopNode) then
    TopItem := TopNode;
end;

{------------------------------------------------------------------------------}
function TLMDShellTree.getLMDPackage:TLMDPackageID;
begin
  result:=pi_LMD_SHELL;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.ToggleItemCheckbox(Node: TTreeNode; AChecked: Boolean);
var
  LShellItem: TLMDCustomShellItem;
begin
  LShellItem := TLMDShellTreeNode(Node).ShellItem;
  if AChecked then
    FCheckedItems.Add(LShellItem)
  else
    FCheckedItems.Delete(LShellItem);
  LShellItem.Checked := AChecked;
  Items.BeginUpdate;
  if LShellItem.Checked then
    Node.StateIndex := 2
  else
    Node.StateIndex := 1;
  Items.EndUpdate;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.RefreshBranch(Node: TTreeNode);
begin
  RefreshBranches([Node]);
end;

{------------------------------------------------------------------------------}

function  TLMDShellTree.ChangeTimerNode: TTreeNode;
begin
  Result := TTreeNode(FChangeTimer.Tag);
end;

{------------------------------------------------------------------------------}

function  TLMDShellTree.CanExpand(Node : TTreeNode) : Boolean;
var
  i: integer;
  ShellItems: TLMDShellItemsList;
  Sel: TTreeNode;
begin
  Result := inherited CanExpand(Node);
  if (csDestroying in ComponentState) or (csDesigning in ComponentState) then Exit;
  if Node.HasChildren and (Node.Count = 0) then
    begin
      Sel := Selected;

      if  not (Assigned(Sel) and (ChangeDelay > 0) and FChangeTimer.Enabled
          and (ChangeTimerNode = Sel)) then
        Sel := nil;

      ShellItems := TLMDShellItemsList.Create;
      Items.BeginUpdate;
      try
        EnumItems(TLMDShellTreeNode(Node).ShellItem.AbsoluteID, ShellItems);
        for i := 0 to ShellItems.count-1 do
          with TLMDShellTreeNode(Items.AddChild(Node, '')) do
            ShellItem := ShellItems[i];
      finally
        Items.EndUpdate;
        ShellItems.Free;
      end;

      if  Assigned(Sel) then
        FChangeTimer.Enabled := True;
    end;

  if  Node.Count = 0  then
    Node.HasChildren := False;
end;

{------------------------------------------------------------------------------}

procedure TLMDShellTree.Collapse(Node: TTreeNode);
var
  i : integer;
  Sel: TTreeNode;
begin
  inherited;

  if Node.Count = 0 then Exit;

  Items.BeginUpdate;
  for i := Node.count-1 downto 0 do
    Node.Item[i].Free;//Delete;
  Node.HasChildren := True;
  Items.EndUpdate;

  Sel := Selected;
  if  Assigned(Sel) and (ChangeDelay > 0) and not FChangeTimer.Enabled
      and (ChangeTimerNode = Sel) and Assigned(FShellFolder)
      and not FShellFolder.ID_Equal(FShellFolder.ActiveFolder.AbsoluteID,
          TLMDShellTreeNode(Sel).ShellItem.AbsoluteID)   then
    FChangeTimer.Enabled := True;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.Edit(const Item : TTVItem);
var
  ShellItem     : TLMDCustomShellItem;
  S: string;
begin
  S := LMDPtrToText(Item.pszText);
  ShellItem := TLMDShellTreeNode(Selected).ShellItem;
  if (S = ShellItem.DisplayName) or (S = '') then
    Exit;

  inherited;

  if  not FShellFolder.RenameItem(ShellItem, S) then
    Selected.Text := ShellItem.DisplayName;
end;

{------------------------------------------------------------------------------}
function  TLMDShellTree.CanEdit(Node : TTreeNode): Boolean;
begin
  result := inherited CanEdit(Node);
  if result then
    result := TLMDShellTreeNode(Node).ShellItem.CanRename and (toAllowRename in FOptions);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.ClearCheckboxes;
begin
  Items.BeginUpdate;
  try
    while FCheckedItems.Count > 0 do
      FCheckedItems.Item[0].Checked := false;
  finally
    Items.EndUpdate;
  end;
end;

procedure TLMDShellTree.Click;
var
  Node  : TTreeNode;
  R     : TRect;
  LShellItem: TLMDCustomShellItem;
begin
  inherited;
  if not FShowCheckBoxes then Exit;
  Node := GetNodeAt(FClickPoint.x, FClickPoint.y);
  if Node = nil then Exit;
  R := Node.DisplayRect(True);
  if (FClickPoint.x < R.Left) and ((FClickPoint.x > (R.Left-32))) then
  begin
    LShellItem := TLMDShellTreeNode(Node).ShellItem;
    LShellItem.OnCheckItem := HandlerCheckItem;
    LShellItem.Checked := not LShellItem.Checked;
  end;
    //ToggleItemCheckbox(Node, not TLMDShellTreeNode(Node).ShellItem.Checked);
end;

{------------------------------------------------------------------------------}
function TLMDShellTree.CreateNode: TTreeNode;
begin
  Result:= TLMDShellTreeNode.Create(Items);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.Loaded;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.CreateWnd;
begin
  inherited;
  if not (csDesigning in ComponentState) then
    if (toAllowDrop in FOptions) then
    begin
      {$IFDEF LMDCOMP9}
      {$IFDEF LMDCOMP11}
      RegisterDragDrop(Handle, Self);
      {$ELSE}
      if Assigned(Parent) and Parent.HandleAllocated then
        RegisterDragDrop(Parent.Handle, Self);
      {$ENDIF}
      {$ELSE}
      RegisterDragDrop(Handle, Self);
      {$ENDIF}
    end;

  if FShellFolder <> nil then
    begin
      Images := FShellFolder.SmallFolderImages;
      ReloadTree;
      ActiveFolderChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.DestroyWnd;
begin
//  if  not (csDestroying in ComponentState)  then
//    AddToRefreshList(nil);

  inherited;
  if not (csDesigning in ComponentState) then
    if (toAllowDrop in FOptions) then
      {$IFDEF LMDCOMP9}
      {$IFDEF LMDCOMP11}
      RevokeDragDrop(Handle);
      {$ELSE}
      if Assigned(Parent) and Parent.HandleAllocated then
        RevokeDragDrop(Parent.Handle);
      {$ENDIF}
      {$ELSE}
      RevokeDragDrop(Handle);
      {$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.CreateParams(var Params: TCreateParams);
begin
  inherited;
//  Params.Style := Params.Style and not TVS_DISABLEDRAGDROP;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited;
  if aComponent = FShellFolder then
    if Operation = opRemove then
      Folder := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.WndProc(var Message : TMessage);
var
  ShellItem     : TLMDCustomShellItem;
  Flags         : DWORD;
  Res           : Integer;
  tmpPIDL       : PItemIDList;
begin

  case Message.Msg of
    WM_INITMENUPOPUP,
    WM_DRAWITEM,
    WM_MENUCHAR,
    WM_MEASUREITEM:
      if Assigned(ContextMenu2) then
      begin
        ContextMenu2.HandleMenuMsg(Message.Msg, Message.wParam, Message.lParam);
        Message.Result := 0;
      end;
    WM_CONTEXTMENU :
      if  (PopupMenu = nil) and (toShellMenu in FOptions) then
        begin
          Flags := CMF_EXPLORE;
          if (toAllowRename in FOptions) then Flags := Flags or CMF_CANRENAME;
          if (toExtendedMenu in Options) and (GetKeyState(VK_SHIFT) < 0) then Flags := Flags or $00000080;

          if Selected <> nil then
            begin
              ShellItem := TLMDShellTreeNode(Selected).ShellItem;
              tmpPIDL := ShellItem.RelativeID;
              Res := LMDShellInvokeContextMenu(Self, ShellItem.ParentShellFolderIntf, tmpPIDL, LoWord(Message.lParam), HiWord(Message.lParam), Handle, Flags);
//              Res := LMDShellInvokeContextMenu(Self, ShellItem.ParentShellFolderIntf, tmpPIDL, 1, LoWord(Message.lParam), HiWord(Message.lParam), Handle, Flags);
              if Res = 19 then Selected.EditText;
              Exit;
            end;
        end;

    WM_LBUTTONUP, WM_RBUTTONUP : FClickPoint := Point(Message.LParamLo, Message.LParamHi);

    WM_ERASEBKGND :
      if FDragScroll then
        begin
          Message.result := 0;
          Exit;
        end;
  end;
  inherited;
end;

{------------------------------------------------------------------------------}
{
function TLMDShellTree.GetNodeFromItem(const Item: TTVItem): TTreeNode;
begin
  Result := nil;
  if Items <> nil then
    with Item do
      if (state and TVIF_PARAM) <> 0 then Result := Pointer(lParam)
      else Result := Items.GetNode(hItem);
end;
}
{------------------------------------------------------------------------------}

procedure TLMDShellTree.CNNotify(var Message : TWMNotify);

var
  NMHdr         : TNMHdr;
  NMTree        : TNMTreeView;
//  Node          : TTreeNode;
  ShellItem     : TLMDCustomShellItem;
  DropEffect    : Integer;
  tmpPIDL       : PItemIDList;
  DropSource    : IDropSource;
  HDragImgList  : HIMAGELIST;
  PIDLS         : TLMDShellPIDLS;
begin

  NMHdr := Message.NMHdr^;

  case NMHdr.code of
    TVN_BEGINDRAG:
      if (toAllowDrag in FOptions) then
        begin

          NMTree := PNMTreeView(Pointer(Message.NMHdr))^;

          FDragNode := GetNodeAt(NMTree.ptDrag.X, NMTree.ptDrag.Y);

          if  not Assigned(FDragNode) then
            exit;

          FShellFolder.DragSource := Self;
          ShellItem := TLMDShellTreeNode(FDragNode).ShellItem;
          DropEffect := ShellItem.DWFileAttributes;
          PIDLS := TLMDShellPIDLS.Create;
          tmpPIDL := FShellFolder.ID_Clone(ShellItem.AbsoluteID);
          FShellFolder.ID_RemoveLastID(tmpPIDL);
          PIDLS.Add(tmpPIDL);
          FShellFolder.ID_Free(tmpPIDL);
          PIDLS.Add(ShellItem.RelativeID);
          FDataObject := TLMDShellDataObject.Create(PIDLS);
          DropSource := TLMDShellDropSource.Create;
          HDragImgList := TreeView_CreateDragImage(Handle, NMTree.itemNew.hItem);
          ImageList_BeginDrag(HDragImgList, 0, 0, 0);
          DoDragDrop(FDataObject, DropSource, DropEffect, DropEffect);

          FShellFolder.DragSource := nil;
          ImageList_EndDrag();
          ImageList_Destroy(HDragImgList);
          PIDLS.Free;
          DropSource := nil;
          FDataObject := nil;

          if  Assigned(FDragNode) then
            RefreshBranch(FDragNode.Parent);

          FDragNode := nil;
          exit;
      end;
  end;
  if (csDesigning in ComponentState) and (NMHdr.code = NM_CUSTOMDRAW) then
    Exit
  else
    inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.DoCustomDrawItem(Sender : TCustomTreeView; Node : TTreeNode;
      State : TCustomDrawState; var DefaultDraw : Boolean);
var
  ShellItem : TLMDCustomShellItem;
begin
  if not (csDesigning in ComponentState) then
  begin
    if (toColorCompressed in FOptions) then
    begin
      if not (cdsSelected in State) then
      begin
        ShellItem := TLMDShellTreeNode(Node).ShellItem;
        if ShellItem <> nil then
        begin
          if ShellItem.DriveType = DRIVE_REMOVABLE then Exit;
          if ShellItem.IsCompressed then
            Canvas.Font.Color := FCompressedColor
        end;
      end;
    end;
  end;
end;

procedure TLMDShellTree.DoAdvancedCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
        State: TCustomDrawState; Stage: TCustomDrawStage;
        var PaintImages, DefaultDraw: Boolean);
begin
  if  (Stage = cdPrePaint) AND (State = [])   then
    DoCustomDrawItem(self, Node, State, DefaultDraw);
end;

{-- public --------------------------------------------------------------------}
constructor TLMDShellTree.Create(aOwner : TComponent);
begin
  inherited;
  FShellFolder := nil;
  FItemsCache := nil;
  FCheckedItems := TLMDShellItemsList.Create;
  FCheckedItems.OnCheckItem := HandlerCheckItem;
  FOptions := [toShowFolders, toExpandTopNode, toAllowRename, toAllowDrag, toAllowDrop, toShellMenu];
  FEnumOptions := [eoFolders];
  FCompressedColor := clBlue;
  FFiltered := False;
  FFileFilter := TStringList.Create;
  FShowCheckBoxes := False;
  FStateImages := TImageList.Create(nil);
  FStateImages.ResourceLoad(rtBitmap, 'LMDSHELLCHECKBOX', clFuchsia);
  StateImages := FStateImages;
  FOnFilterItem := nil;
  FOnItemSelected := nil;
  HideSelection := False;
  FChangeLocked := False;
  FActiveChangeLocked := False;
  SortType := comctrls.stNone;
  FDataObject := nil;
  FDragScroll := False;
  FDoingDragDrop := False;
  FDropTargetNode := nil;

  { v2.0 }
  FAutoContext := False;
  FAutoSortSupport := False;
  FSelectionInfoEvent := nil;
  ChangeDelay := 500;
  OnAdvancedCustomDrawItem := DoAdvancedCustomDrawItem;
  DragMode := dmAutomatic;
  FRefreshList := nil;
  FRefreshTimer := nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellTree.Destroy;
begin
  if FShellFolder <> nil then FShellFolder.UnRegisterView(Self);
  FStateImages.Free;
  FFileFilter.Free;
  FDataObject := nil;
  FreeAndNil(FCheckedItems);
  FRefreshList.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.ExecuteCommand(const Verb: String; var Handled: Boolean);
var
  ShellItem     : TLMDCustomShellItem;
  tmpPIDL       : PItemIDList;
begin
  if Selected <> nil then
    begin
      ShellItem := TLMDShellTreeNode(Selected).ShellItem;
      tmpPIDL := ShellItem.RelativeID;
      LMDShellDoContextMenuVerb(nil, ShellItem.ParentShellFolderIntf, tmpPIDL, Handle, Verb);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.BeginEnumeration;
begin
  FItemsCache.Clear;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.EndEnumeration;
begin
  FItemsCache.SortByRelativeID;
  FItemsCache := nil;
end;

procedure TLMDShellTree.BeginUpdate;
Begin
  if  not FActiveChangeLocked then
    Items.BeginUpdate;
End;

procedure TLMDShellTree.EndUpdate;
Begin
  if  not FActiveChangeLocked then
    Items.EndUpdate;
End;

{------------------------------------------------------------------------------}
function TLMDShellTree.TerminateEnumeration : boolean;
begin
  result := False;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.AddItem(aItem : TLMDCustomShellItem);
var
  bAccept : boolean;
begin
  bAccept := True;
  DoFilterItem(aItem, bAccept);
  if bAccept then FItemsCache.Add(aItem)
  else aItem.Free;
end;

{------------------------------------------------------------------------------}
function  TLMDShellTree.FindNode(PIDL : PItemIDList; CanExpand: Boolean): TLMDShellTreeNode;
var
  i, j    : integer;
  PIDLS   : TList;
  tmpPIDL : PItemIDList;
//  aPIDL   : PItemIDList;
  Node    : TTreeNode;
  Flag    : boolean;
  FullPath: string;
begin
  Result := nil;

  if (FShellFolder = nil) or (PIDL = nil)  then Exit;

  PIDLS := TList.Create;
  try
    PIDLS.Add(FShellFolder.ID_Clone(PIDL));

    while True do
      begin
        tmpPIDL := FShellFolder.ID_Clone(PItemIDList(PIDLS[0]));
        if FShellFolder.ID_RemoveLastID(tmpPIDL) then
          PIDLS.Insert(0, tmpPIDL)
        else
          begin
            FShellFolder.ID_Free(tmpPIDL);
            Break;
          end;
      end;

    FullPath := LMDPIDLToPath(PIDL);
    Node := Items.GetFirstNode;
    Flag := True;
    i := PIDLS.Count;
    tmpPIDL := (Node as TLMDShellTreeNode).ShellItem.AbsoluteID;

    for j := 0 to PIDLS.Count - 1 do
      if  FShellFolder.ID_Equal(PItemIDList(PIDLS[j]), tmpPIDL) then
        begin
          i := j + 1;
          break;
        end;

    while Assigned(Node) and (i < PIDLS.count) and Flag do
      begin
        if  CanExpand then
          Node.Expand(False);

        Flag := False;

        for j := 0 to Node.Count - 1 do
          if  LMDPIDLToPath(TLMDShellTreeNode(Node[j]).ShellItem.AbsoluteID) = FullPath then
            begin
              Node := Node.Item[j];
              Flag := True;
              Break;
            end;

        if  Flag  then
          break;

        tmpPIDL := PItemIDList(PIDLS[i]);

        for j := 0 to Node.Count - 1 do
          if FShellFolder.ID_Equal(tmpPIDL, TLMDShellTreeNode(Node[j]).ShellItem.AbsoluteID) then
            begin
              Node := Node.Item[j];
              Inc(i);
              Flag := True;
              Break;
            end;
      end;

    Result := Node as TLMDShellTreeNode;
  finally
    for i := 0 to PIDLS.count-1 do
      FShellFolder.ID_Free(PItemIDList(PIDLS[i]));
    PIDLS.Free;
  end;
end;

function TLMDShellTree.FindNodeByShellItem(AItem: TLMDShellItem): TLMDShellTreeNode;
var
  i: Integer;
  LItem: TLMDShellTreeNode;
begin
  Result := nil;
  for i := 0 to Items.Count - 1 do
  begin
    LItem := TLMDShellTreeNode(Items[i]);
    if (LItem.ShellItem = AItem) then
    begin
      Result := LItem;
      exit;
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.ActiveFolderChanged;
var
  Node    : TTreeNode;
  Ch      : boolean;
begin
  if FShellFolder = nil then Exit;
  if FShellFolder.ActiveFolder = nil then Exit;
  if FActiveChangeLocked then Exit;
  if IsEditing then
    Selected.EndEdit(True);

  Ch := not Assigned(Selected) or
          not FShellFolder.ID_Equal(TLMDShellTreeNode(Selected).ShellItem.AbsoluteID,
                       FShellFolder.ActiveFolder.AbsoluteID);

  FChangeLocked := True;

  try
    Node := FindNode(FShellFolder.ActiveFolder.AbsoluteID, True);

    if  Assigned(Node)  then
      begin
        Selected := Node;
        Node.MakeVisible;
        RefreshBranch(Node);
      end;
  finally
    FChangeLocked := False;
  end;

  if  Ch and Assigned(Node) then
  begin
    FChangeLocked := True;
    try
      Change(Node);
    finally
      FChangeLocked := False;
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.DoFileChange(aPIDL : PItemIDList);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.DoFileCreate(aPIDL : PItemIDList);
var
  tmpPIDL : PItemIDList;
begin
  tmpPIDL := FShellFolder.ID_Clone(aPIDL);
  FShellFolder.ID_RemoveLastID(tmpPIDL);
  DoFolderChange(tmpPIDL);
  FShellFolder.ID_Free(tmpPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.DoFileDelete(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
var
  tmpPIDL : PItemIDList;
begin
  tmpPIDL := FShellFolder.ID_Clone(aPIDL1);
  FShellFolder.ID_RemoveLastID(tmpPIDL);
  DoFolderChange(tmpPIDL);
  FShellFolder.ID_Free(tmpPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.DoFileRename(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
begin
  DoFolderRename(aPIDL1, aPIDL2);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.DoFolderChange(aPIDL : PItemIDList);
var
  i             : integer;
  Node          : TLMDShellTreeNode;
{
  i, j          : integer;
  Node          : TLMDShellTreeNode;
  ShellItems    : TLMDShellItemsList;
  Flag          : boolean;
}
begin
  Node := nil;
  for i := 0 to Items.count-1 do
    if FShellFolder.ID_Equal(aPIDL, TLMDShellTreeNode(Items[i]).ShellItem.AbsoluteID) then
      begin
        Node := TLMDShellTreeNode(Items[i]);
        Break;
      end;
  if Node = nil then Exit;

  AddToRefreshList(Node);
//  RefreshBranch(Node);
{
  ShellItems := TLMDShellItemsList.Create;
  try
    EnumItems(aPIDL, ShellItems);

    Items.BeginUpdate;
    for i := Node.count-1 downto 0 do
      begin
        Flag := False;
        for j := 0 to ShellItems.count-1 do
          if LMDSameText(Node.Item[i].Text, ShellItems[j].DisplayName) then
            begin
              Flag := True;
              Break;
            end;
        if not Flag then
          Node.Item[i].Delete;
      end;

    for i := ShellItems.count-1 downto 0 do
      begin
        Flag := False;
        for j := 0 to Node.count-1 do
          if LMDSameText(Node.Item[j].Text, ShellItems[i].DisplayName) then
            begin
              Flag := True;
              Break;
            end;
        if not Flag then
          begin
            with TLMDShellTreeNode(Items.AddChild(Node, '')) do
              ShellItem := ShellItems[i];
            ShellItems.Delete(i);
          end;
      end;
    Node.SetHasChildren;
    Items.EndUpdate;
  finally
    for i := 0 to ShellItems.count-1 do
      ShellItems[i].Free;
    ShellItems.Free;
  end;
}
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.DoFolderCreate(aPIDL : PItemIDList);
var
  tmpPIDL : PItemIDList;
begin
  tmpPIDL := FShellFolder.ID_Clone(aPIDL);
  FShellFolder.ID_RemoveLastID(tmpPIDL);
  DoFolderChange(tmpPIDL);
  FShellFolder.ID_Free(tmpPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.DoFolderDelete(aPIDL : PItemIDList);
var
  tmpPIDL : PItemIDList;
begin
  tmpPIDL := FShellFolder.ID_Clone(aPIDL);
  FShellFolder.ID_RemoveLastID(tmpPIDL);
  DoFolderChange(tmpPIDL);
  FShellFolder.ID_Free(tmpPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.DoFolderRename(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
var
  i             : integer;
  Node          : TLMDShellTreeNode;
  tmpParent1    : PItemIDList;
  tmpParent2    : PItemIDList;
begin
  tmpParent1 := FShellFolder.ID_Clone(aPIDL1);
  tmpParent2 := FShellFolder.ID_Clone(aPIDL2);
  FShellFolder.ID_RemoveLastID(tmpParent1);
  FShellFolder.ID_RemoveLastID(tmpParent2);

  if not FShellFolder.ID_Equal(tmpParent1, tmpParent2) then
    begin
      DoFolderChange(tmpParent1);
      DoFolderChange(tmpParent2);
      FShellFolder.ID_Free(tmpParent1);
      FShellFolder.ID_Free(tmpParent2);
      Exit;
    end;

  FShellFolder.ID_Free(tmpParent1);
  FShellFolder.ID_Free(tmpParent2);

  Node := nil;
  for i := 0 to Items.count-1 do
    if FShellFolder.ID_Equal(aPIDL1, TLMDShellTreeNode(Items[i]).ShellItem.AbsoluteID) then
      begin
        Node := TLMDShellTreeNode(Items[i]);
        Break;
      end;

  if Node = nil then Exit;

  Items.BeginUpdate;
  Node.Collapse(False);
  Node.ShellItem := FShellFolder.CreateShellItem(aPIDL2);
  Node.SetHasChildren;
  if Node.Expanded then Node.Expand(False);
  Items.EndUpdate;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.CopyToClipboard;
var
  ShellItem     : TLMDCustomShellItem;
  tmpPIDL       : PItemIDList;
begin
//  exit;
  if Selected <> nil then
    begin
      ShellItem := TLMDShellTreeNode(Selected).ShellItem;
      if ShellItem.CanCopy then
        begin
          tmpPIDL := ShellItem.RelativeID;
          LMDShellDoContextMenuVerb(nil, ShellItem.ParentShellFolderIntf, tmpPIDL, Handle, 'copy');
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.CutToClipboard;
var
  ShellItem     : TLMDCustomShellItem;
  tmpPIDL       : PItemIDList;
begin
//  exit;
  if Selected <> nil then
    begin
      ShellItem := TLMDShellTreeNode(Selected).ShellItem;
      if ShellItem.CanCopy then
        begin
          tmpPIDL := ShellItem.RelativeID;
          LMDShellDoContextMenuVerb(nil, ShellItem.ParentShellFolderIntf, tmpPIDL, Handle, 'cut');
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.PasteFromClipboard;
var
  tmpPIDL       : PItemIDList;
  ShellItem     : TLMDCustomShellItem;
begin
  if FShellFolder = nil then Exit;
  if FShellFolder.ActiveFolder = nil then Exit;
  if Selected = nil then exit;

  ShellItem := TLMDShellTreeNode(Selected).ShellItem;
  if ShellItem <> nil then
    begin
      tmpPIDL := ShellItem.RelativeID;
      if ShellItem.CanPaste then
        LMDShellDoContextMenuVerb(nil, ShellItem.ParentShellFolderIntf, tmpPIDL, Handle, 'paste');
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.DeleteItems;
var
  ShellItem     : TLMDCustomShellItem;
  tmpPIDL       : PItemIDList;
begin
  if Selected <> nil then
    begin
      ShellItem := TLMDShellTreeNode(Selected).ShellItem;
      tmpPIDL := ShellItem.RelativeID;
      LMDShellDoContextMenuVerb(nil, ShellItem.ParentShellFolderIntf, tmpPIDL,
              Handle, 'delete');
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.ShowProperties;
begin
  if FShellFolder = nil then Exit;
  if Selected = nil then Exit;
  FShellFolder.ShowPropertySheet(TLMDShellTreeNode(Selected).ShellItem);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.OpenWith;
begin
  Open;
  {if Selected = nil then Exit;
  cmd := 'rundll32.exe shell32.dll,OpenAs_RunDLL '+TLMDShellTreeNode(Selected).ShellItem.Path;
  WinExec(PChar(cmd),0);}
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.MailTo;
begin
  if Selected = nil then Exit;
  //cmd := 'rundll32.exe mailnews.dll,Mail_RunDLL MailTo:';
  //WinExec(PAnsiChar(Int_Ref(cmd)),0);
  ShellExecute(0, 'open', 'rundll32.exe', int_Ref('mailnews.dll,Mail_RunDLL MailTo:'), int_Ref(''), 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.CopyFileNameAsText;
var
  Buf   : string;
begin
  if Selected = nil then Exit;
  Buf := ExtractFileName(TLMDShellTreeNode(Selected).ShellItem.Path);
  LMDSetClipboardText(Buf);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.CopyPathAsText;
var
  Buf   : string;
begin
  if Selected = nil then Exit;
  Buf := TLMDShellTreeNode(Selected).ShellItem.Path;
  LMDSetClipboardText(Buf);
end;

{------------------------------------------------------------------------------}
function  TLMDShellTree.NewFolder: Boolean;
var
  i     : integer;
  Path  : string;
  Itm   : TTreeNode;
begin
  Result := False;
  if FShellFolder = nil then Exit;
  if  Selected = nil  then  Exit;
  if  IsEditing then Exit;

  Itm := nil;
  Path := FShellFolder.NewFolder;

  if  Path <> ''  then
    begin
      Selected.HasChildren := True;
      Selected.Expand(False);
      RefreshBranch(Selected);

      for i := 0 to Items.count-1 do
        if LMDAnsiSameText(Path, TLMDShellTreeNode(Items[i]).ShellItem.Path) then
          begin
            Itm := Items[i];
            Break;
          end;

      if  Assigned(Itm) then
        begin
          Itm.MakeVisible;
          Itm.Selected := True;
          Itm.EditText;
        end;

      Result := True;
    end;
end;

// NEW
// -------

function TLMDShellTree.Editable: Boolean;
begin
  result:=Enabled and Focused and Assigned(FShellFolder);
end;

{------------------------------------------------------------------------------}
function TLMDShellTree.CanCopy: Boolean;
begin
  result:=Editable and Assigned(Selected) and SelectedItem.CanCopy;
end;

{------------------------------------------------------------------------------}
function TLMDShellTree.CanCut: Boolean;
begin
  result:=Editable and Assigned(Selected) and (fcCanMove in SelectedItem.Capabilities);
end;

{------------------------------------------------------------------------------}
function TLMDShellTree.CanDelete: Boolean;
begin
  result:=Editable and Assigned(Selected) and (fcCanDelete in SelectedItem.Capabilities);
end;

{------------------------------------------------------------------------------}
function TLMDShellTree.CanPaste: Boolean;
begin
  result:=Editable and (Clipboard.HasFormat(LMDShPIDLCFormat));
end;

{------------------------------------------------------------------------------}
function TLMDShellTree.Controller: TLMDCustomShellController;
begin
  result:=FShellFolder;
end;

{------------------------------------------------------------------------------}
function TLMDShellTree.CanAccessItem: Boolean;
begin
  result:=Editable and Assigned(Selected);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.Open;
begin
  if Selected=nil then exit;
  if TLMDShellTreeNode(Selected).ShellItem.IsFolder then
    FShellFolder.ChDir(TLMDShellTreeNode(Selected).ShellItem.AbsoluteID)
  else
    FShellFolder.ExecuteDefault(TLMDShellTreeNode(Selected).ShellItem);
end;

{------------------------------------------------------------------------------}
function TLMDShellTree.CanRename: Boolean;
var
  S: TTreeNode;
begin
  S := Selected;
  Result := Assigned(S) and not IsEditing and Editable and CanEdit(S);
end;

{------------------------------------------------------------------------------}
function  TLMDShellTree.Rename: Boolean;
begin
  Result := CanRename;

  if  Result  then
    Selected.EditText;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.CopyItems(const Target: String);
begin
  if Selected=nil then exit;
  FShellFolder.CopyFiles(TLMDShellTreeNode(Selected).ShellItem.PathName, Target+#0);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.MoveItems(const Target: String);
begin
  if Selected=nil then exit;
  FShellFolder.MoveFiles(TLMDShellTreeNode(Selected).ShellItem.PathName, Target+#0);
end;

{------------------------------------------------------------------------------}
function  TLMDShellTree.GetReadOnly: Boolean;
begin
  Result := inherited ReadOnly;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellTree.SetReadOnly(Value: Boolean);
begin
  if  ReadOnly <> Value then
  begin
    inherited ReadOnly := Value;
    if  ReadOnly  then
      Options := Options - [toAllowRename, toAllowDrop];
  end;
end;

function  TLMDShellTree.GetChangeDelay: integer;
begin
  Result := inherited ChangeDelay;
end;

function TLMDShellTree.GetCheckedCount: Integer;
begin
  Result := FCheckedItems.Count;
end;

function TLMDShellTree.GetCheckedItem(const Index: Integer): TLMDCustomShellItem;
begin
  Result := FCheckedItems.Item[Index];
end;

procedure TLMDShellTree.SetChangeDelay(V: integer);
begin
  inherited ChangeDelay := V;
end;

initialization
  if not LMDDisableOleinit then
    OleInitialize(nil);

finalization
  if not LMDDisableOleinit then
    OleUninitialize;

end.
