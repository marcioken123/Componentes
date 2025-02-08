unit ElTreeGrids;
{$I lmdcmps.inc}

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

ElTreeGrids unit
----------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Messages,
  Controls,
  Forms,
  SysUtils,
  StdCtrls,

  Classes,

  Types,

  LMDTypes,
  ElStrArray,
  ElTree,
  ElHeader,
  ElVCLUtils,
  LMDUnicodeStrings,
  ElTreeInplaceEditors,
  ElTreeBtnEdit;

type
     TCustomElTreeGrid = class(TCustomElTree)
     private
       //FRow,
       //FCol : integer;
       FgoAlwaysShowEditor: Boolean;
       FgoRowSelect: Boolean;
       FgoColMoving: Boolean;
       FgoTabs: Boolean;
       procedure EditFocusedItem(ForcedEdit: boolean);
       procedure SetgoRowSelect(Value: Boolean);
       procedure SetgoColMoving(Value: Boolean);
       function GetCol: Integer;
       procedure SetCol(Value: Integer);
       function GetRow: Integer;
       procedure SetRow(Value: Integer);
       function GetLeftCol: Integer;
       procedure SetLeftCol(Value: Integer);
       function GetColCount: Integer;
       procedure SetColCount(Value: Integer);
       function GetColWidths(Index: Integer): Integer;
       procedure SetColWidths(Index: Integer; Value: Integer);
       function GetDefaultColWidth: Integer;
       procedure SetDefaultColWidth(Value: Integer);
       function GetDefaultRowHeight: Integer;
       procedure SetDefaultRowHeight(Value: Integer);
       function GetEditorMode: Boolean;
       procedure SetEditorMode(Value: Boolean);
       function GetRowCount: Integer;
       procedure SetRowCount(Value: Integer);
       function GetTopRow: Integer;
       procedure SetTopRow(Value: Integer);
       function GetgoEditing: Boolean;
       procedure SetgoEditing(Value: Boolean);
     protected
       FgoTabSkipNonEditable: Boolean;
       FgoDeletion: Boolean;
       FOnRowAdded: TNotifyEvent;
       procedure OnHeaderSectionDelete(Header: TCustomElHeader; Section: TElHeaderSection);override;
       procedure KeyDownTransfer(Sender : TObject; var Key : Word; Shift :
           TShiftState); override;
       procedure WMChar(var Message: TWMChar); message WM_CHAR;
       procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
       function CreateView: TElTreeView; override;
       function GetAsCell(ACol, ARow : Integer): TElTreeItem;
       procedure ChangeScale(M, D: Integer); override;

       procedure MouseDownTransfer(Sender : TObject; Button : TMouseButton; Shift :
           TShiftState; X : Integer; Y : Integer); override;
       procedure EnsureColumnVisible(SectionNumber : integer);
       function GetNextTabSection(SectionIndex : integer; var ToNextItem : boolean):
           TElHeaderSection;
       function GetPrevTabSection(SectionIndex : integer; var ToNextItem : boolean):
           TElHeaderSection;
       procedure TriggerRowAddedEvent; virtual;
       property goAlwaysShowEditor: Boolean read FgoAlwaysShowEditor write
           FgoAlwaysShowEditor;
       property goRowSelect: Boolean read FgoRowSelect write SetgoRowSelect;
       property goColMoving: Boolean read FgoColMoving write SetgoColMoving default true;
       property goTabs: Boolean read FgoTabs write FgoTabs;
       property goDeletion: Boolean read FgoDeletion write FgoDeletion default false;
       property goEditing: Boolean read GetgoEditing write SetgoEditing default true;
       property goTabSkipNonEditable: Boolean read FgoTabSkipNonEditable write FgoTabSkipNonEditable;

       property ColCount: Integer read GetColCount write SetColCount default 5;
       property DefaultColWidth: Integer read GetDefaultColWidth write
           SetDefaultColWidth default 64;
       property DefaultRowHeight: Integer read GetDefaultRowHeight write
           SetDefaultRowHeight default 24;
       property EditorMode: Boolean read GetEditorMode write SetEditorMode;
       property RowCount: Integer read GetRowCount write SetRowCount default 5;
       property OnRowAdded: TNotifyEvent read FOnRowAdded write FOnRowAdded;
     public
       function CellRect(ACol, ARow: Longint): TRect;
       procedure MouseToCell(X, Y: Integer; var ACol, ARow: Longint);
       constructor Create(Owner : TComponent); override;
       function GetNextEditableSection(Section : TElHeaderSection; GoForward :
           boolean): TElHeaderSection;
       property Col: Integer read GetCol write SetCol;
       property ColWidths[Index: Integer]: Integer read GetColWidths write
           SetColWidths;
       property LeftCol: Integer read GetLeftCol write SetLeftCol;
       property Row: Integer read GetRow write SetRow;
       property TopRow: Integer read GetTopRow write SetTopRow;
     published
       property VerticalLines default true;
       property HorizontalLines default true;
     end;

     TElTreeTrickyInplaceEdit = class(TElTreeInplaceButtonEdit)
     private
       FDummyStr : string;
     published
       property Name : string read FDummyStr;
       property Tree : string read FDummyStr;
     end;

     TElTreeStringGrid = class(TCustomElTreeGrid)
     private
       FCols : TLMDStringArray;
       FRows: TLMDStringArray;
       FSavedEditWndProc: TWndMethod;
       function GetCols(Index: Integer): TLMDStrings;
       procedure SetCols(Index: Integer; Value: TLMDStrings);
       function GetRows(Index: Integer): TLMDStrings;
       procedure SetRows(Index: Integer; Value: TLMDStrings);
       function GetCells(ACol, ARow: Integer): TLMDString;
       procedure SetCells(ACol, ARow: Integer; Value: TLMDString);
       function GetObjects(ACol, ARow: Integer): TObject;
       procedure SetObjects(ACol, ARow: Integer; Value: TObject);
       procedure SetEditor(Value : TElTreeInplaceButtonEdit);
     protected
       FEditor : TElTreeInplaceButtonEdit;
       FUseDefaultEditor: Boolean;
       procedure TriggerInplaceEditorNeeded(Item : TElTreeItem; SectionIndex : Integer;
        SupposedFieldType : TElFieldType; var Editor: TElTreeInplaceEditor); override;
       procedure OnFontChange(Sender: TObject); override;

       procedure KeyDownTransfer(Sender : TObject; var Key : Word; Shift :
           TShiftState); override;
       procedure EditorKeyDown(Sender  : TObject; var Key : Word; Shift : TShiftState);
       procedure EditWndProc(var Message: TMessage);
       function GetIncSearchColumnText(Item : TElTreeItem): TLMDString; override;
     public
       constructor Create(Owner : TComponent); override;
       destructor Destroy; override;
       property Cols[Index: Integer]: TLMDStrings read GetCols write SetCols;
       property Rows[Index: Integer]: TLMDStrings read GetRows write SetRows;
       property Cells[ACol, ARow: Integer]: TLMDString read GetCells write SetCells;
           default;
       property Objects[ACol, ARow: Integer]: TObject read GetObjects write SetObjects;

       property Editor : TElTreeInplaceButtonEdit read FEditor
                                                  write SetEditor;
     published
       property UseDefaultEditor: Boolean read FUseDefaultEditor write
           FUseDefaultEditor default false;

       property ColCount default 5;
       property RowCount default 5;
       property goAlwaysShowEditor  default false;
       property goRowSelect default false;
       property goColMoving default true;
       property goDeletion default false;
       property goEditing default true;
       property goTabs default false;
       property goTabSkipNonEditable default false;
       property DefaultColWidth default 64;
       property DefaultRowHeight default 24;

       property AlwaysKeepFocus default True;
       property AlwaysKeepSelection;
       property AutoCollapse;
       property AutoExpand;
       property AutoLineHeight default False;

       property DefaultSectionWidth default 64;

       property BarStyle;
       property BarStyleVerticalLines;

       property UseThemeForSelection;
       property CheckBoxFlat;
       property CheckBoxGlyph;
       property CheckBoxSize;

       property IgnoreEnabled;
       property IncrementalSearch;
       property IncrementalSearchScope;
       property IncrementalSearchTimeout;
       property KeepSelectionWithinLevel;
       property MainTextType;
       property MouseFrameSelect;
       property PathSeparator;
       property QuickEditMode;
       property RowHotTrack;

       property SortUseCase;
       property StripedOddColor;
       property StripedEvenColor;
       property StripedItems;

       property ActiveBorderType;
       property Align;
       property AutoLookup;
       property AutoResizeColumns;
       property Anchors;
       property Constraints;
       property DockOrientation default doNoOrient;
       property Floating;
       property BevelKind;
       property DragKind;
       property DoubleBuffered;
       property AdjustMultilineHeight;
       property Background;
       property BackgroundType;
       property BorderStyle;
       property ChangeDelay;
       property ChangeStateImage;
       property Ctl3D;
       property ParentCtl3D;
       property Color;
       property Cursor;
       property CustomCheckboxes;
       property CustomPlusMinus;
       property VertDivLinesColor;
       property HorzDivLinesColor;
       property DragCursor;
       property DragAllowed;
       property DragTrgDrawMode;
       property DragType;
       property DragExpandDelay;
       property DragImageMode;
       property DrawFocusRect;
       property DragRectAcceptColor;
       property DragRectDenyColor;

       property Enabled;
       property ExpandOnDragOver;
       property ExplorerEditMode;
       property FilteredVisibility;
       property Flat;
       property FlatFocusedScrollbars;
       property FocusedSelectColor;
       property FocusedSelectTextColor;
       property ForcedScrollBars;
       property Font stored true;
       property GradientStartColor;
       property GradientEndColor;
       property GradientSteps;
       property HeaderActiveFilterColor;
       property HeaderColor;
       property HeaderHeight default 0;
       property HeaderHotTrack;
       property HeaderInvertSortArrows;
       property HeaderSections;
       property HeaderFilterColor;
       property HeaderFlat;
       property HeaderImages;
       property HeaderFont;
       property HeaderUseTreeFont;
       property HorzArrowsScroll;
       property AlphaForHeaderImages;
       property HeaderWrapCaptions;
       property HideFocusRect;
       property HideHintOnTimer;
       property HideHintOnMove;
       property HideSelectColor;
       property HideSelectTextColor;
       property HideSelection;
       property HighlightAlphaLevel;
       property HorizontalLines default true;
       property HideHorzScrollBar;
       property HideVertScrollBar;
       property Hint;
       property HorzScrollBarStyles;
       property HeaderImageForm;
       property ImageForm;
       property Images;
       property Images2;
       property AlphaForImages;
       property AlphaForImages2;
       property InactiveBorderType;
       property InplaceEditorDelay;
       property ItemIndent;
       property Items;
       property LineBorderActiveColor;
       property LineBorderInactiveColor;
       property LinesColor;
       property LinesStyle;
       property LineHintColor;
       property LineHintMode default shmLong;
       property LineHintTimeout;
       property LineHintType;
       property LockHeaderHeight default true;
       property MainTreeColumn;
       property MinusPicture;
       property MoveFocusOnCollapse;

       property ParentFont;
       property ParentShowHint;
       property PlusMinusTransparent;
       property PlusPicture;
       property PopupMenu;
       property RadioButtonGlyph;
       property RightAlignedText;
       property RightAlignedView;
       property RightClickSelect;
       property ScrollbarOpposite;
       property HorzScrollTracking;
       property VertScrollTracking;
       property ShowButtons default false;
       property ShowCheckBoxes;
       property ShowEmptyImages;
       property ShowEmptyImages2;
       property ShowHint;
       property ShowImages default false;
       property ShowLines default false;
       property ShowRoot default false;
       property ShowRootButtons;
       property SortDir;
       property SortMode;
       property SortSection;
       property SortType;
       property Storage;
       property StoragePath;
       property StickyHeaderSections;
       property TabOrder;
       property TabStop default True;
       property ParentThemeMode default true;
       property ThemeMode;
       property ThemeGlobalMode;
       property UseCustomScrollBars;

       property VerticalLines default true;
       property VerticalLinesLong default false;
       property VertScrollBarStyles;
       property VirtualityLevel;
       property Visible;
       property UseSystemHintColors;
       property TextColor;
       property BkColor;

       property OnRowAdded;
       property OnScroll;
       property OnHeaderColumnClick;
       property OnHeaderColumnDraw;
       property OnHeaderColumnResize;
       property OnHeaderColumnMove;
       property OnHeaderLookup;
       property OnHeaderLookupDone;
       property OnHeaderResize;
       property OnHeaderSectionExpand;
       property OnHeaderSectionCollapse;
       property OnHeaderSectionFilterCall;
       property OnHeaderSectionAutoSize;
       property OnHeaderSectionMeasure;
       property OnHorzScrollDrawPart;
       property OnHorzScrollHintNeeded;

       property OnAfterSelectionChange;
       property OnChanging;
       property OnDragTargetChange;
       property OnItemChange;
       property OnItemPreDraw;
       property OnItemDraw;
       property OnResize;

       property OnInplaceEditorNeeded;
       property OnTryEdit;

       property OnItemChecked;
       property OnItemExpand;
       property OnItemCollapse;
       property OnItemExpanding;
       property OnItemCollapsing;
       property OnItemDeletion;
       property OnItemFocused;
       property OnShowLineHint;
       property OnCompareItems;
       property OnItemPicDraw;
       property OnItemPicDraw2;
       property OnItemPostDraw;
       property OnHotTrack;
       property OnSortBegin;
       property OnSortEnd;
       property OnItemSave;
       property OnItemLoad;
       property OnItemSelectedChange;
       property OnCellStyleSave;
       property OnCellStyleLoad;
       property OnVertScrollDrawPart;
       property OnVertScrollHintNeeded;
       property OnHTMLImageNeeded;
       property OnHTMLImageNeededEx;
       property OnLinkClick;
       property OnLinkOver;
       property LinkCursor;
       property LinkColor;
       property LinkStyle;
       property OnHeaderMouseDown;
       property OnVirtualTextNeeded;
       property OnVirtualHintNeeded;
       property OnVirtualValueNeeded;
       property OnVirtualStyleNeeded;

       property OnClick;
       property OnEnter;
       property OnExit;
       property OnDragDrop;
       property OnDragOver;
       property OnStartDrag;
       property OnEndDrag;
       property OnMouseDown;
       property OnMouseMove;
       property OnMouseUp;
       property OnDblClick;
       property OnKeyDown;
       property OnKeyPress;
       property OnKeyUp;
       property OnStartDock;
       property OnEndDock;
       property OnContextPopup;
       property OnOleTargetDrag;
       property OnOleTargetDrop;
       property OnOleDragStart;
       property OnOleDragFinish;
   end;

     TElTreeGridView = class(TElTreeView)
     protected
       function IntLButtonDown(X, Y : integer; Shift : TShiftState) : boolean;
       function NeedToFoxusItemInMouseDown: Boolean; override;
       procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
       procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
     end;

     EElTreeGridError = class(EElTreeError);

implementation

procedure TCustomElTreeGrid.KeyDownTransfer(Sender : TObject; var Key : Word; Shift : TShiftState);
var {i,} j : integer;
    Item : TElTreeItem;
    b    : boolean;
    Section : TElHeaderSection;

    procedure ToNextSection;
    begin
      if FGoAlwaysShowEditor and (not fGoRowSelect) and IsEditing then
      begin
        Key := 0;
        EndEdit(not ExplorerEditMode);
      end;

      b := false;
      Section := GetNextTabSection(SelectColumn, b);

      // move focus to next item
      if b = true then
      begin
        Key := VK_DOWN;
        Item := TElTreeGridView(FView).FindNewFocused(Key, @j, b);
        if (Item = nil) or (Item = ItemFocused) then
        begin
          Key := VK_HOME;
          Item := TElTreeGridView(FView).FindNewFocused(Key, @j, b);
        end;

        if Item <> nil then
        begin
          ItemFocused := Item;
          if Key = VK_DOWN then
            EnsureVisibleBottomEx(ItemFocused, False)
          else
            EnsureVisibleEx(ItemFocused, False);
        end;
      end;

      // Select new section
      SelectColumn := Section.Index;
      EnsureColumnVisible(SelectColumn);

      DoItemFocused;
      DoAfterSelectionChange;

      EditFocusedItem(false);
    end;

    procedure ToPrevSection;
    var Key : Word;
    begin
      if FGoAlwaysShowEditor and (not fGoRowSelect) and IsEditing then
        EndEdit(not ExplorerEditMode);

      b := false;
      Section := GetPrevTabSection(SelectColumn, b);

      // move focus to next item
      if b = true then
      begin
        Key := VK_UP;
        Item := TElTreeGridView(FView).FindNewFocused(Key, @j, b);
        if (Item = nil) or (Item = ItemFocused) then
        begin
          Key := VK_END;
          Item := TElTreeGridView(FView).FindNewFocused(Key, @j, b);
        end;

        if Item <> nil then
        begin
          ItemFocused := Item;
          if Key = VK_END then
            EnsureVisibleBottomEx(ItemFocused, False)
          else
            EnsureVisibleEx(ItemFocused, False);
        end;
      end;

      // Select new section
      SelectColumn := Section.Index;
      EnsureColumnVisible(SelectColumn);

      DoItemFocused;
      DoAfterSelectionChange;

      EditFocusedItem(false);
    end;

begin
  inherited;
  if goTabs and (Key = VK_TAB) and
     (not goRowSelect) and (ItemFocused <> nil) then
  begin
    if Shift = [] then
    begin
      ToNextSection;

      Key := 0;
    end
    else
    if Shift = [ssShift] then
    begin
      ToPrevSection;

      Key := 0;
    end;
  end;
  if (Shift = []) then
  begin
    if (ItemFocused <> nil) then
    begin
      if (Key = VK_PRIOR) or (Key = VK_NEXT) or
         (Key = VK_HOME) or (Key = VK_END) or
         (Key = VK_UP) or (Key = VK_DOWN) then
      begin
        if FGoAlwaysShowEditor and (not fGoRowSelect) and IsEditing then
           EndEdit(not ExplorerEditMode);
        Item := TElTreeGridView(FView).FindNewFocused(Key, @j, b);
        if Item <> nil then
        begin
          ItemFocused := Item;
          if (Key = VK_NEXT) or (Key = VK_END) or (Key = VK_DOWN) then
            EnsureVisibleBottomEx(ItemFocused, False)
          else
            EnsureVisibleEx(ItemFocused, False);
        end;
        DoAfterSelectionChange;

        EditFocusedItem(false);
        Key := 0;
      end
      else
      if Key = VK_LEFT then
      begin
        ToPrevSection;
        Key := 0;
      end
      else
      if Key = VK_RIGHT then
      begin
        ToNextSection;
        Key := 0;
      end
    end;
    if Key = VK_INSERT then
    begin
      if goEditing then
      begin
        Item := Items.AddItem(nil);
        EnsureVisibleBottom(Item);
        TriggerRowAddedEvent;
        if ItemFocused = nil then
        begin
          ItemFocused := Item;
          DoAfterSelectionChange;
          EditFocusedItem(false);
        end;
      end;
      Key := 0;
    end
  end
  else
  if Shift = [ssCtrl] then
  begin
    if Key = VK_DELETE then
    begin
      if goDeletion then
        Items.DeleteItem(ItemFocused);
      DoAfterSelectionChange;
      Key := 0;
    end;
  end;
end;

procedure TCustomElTreeGrid.WMChar(var Message: TWMChar);
begin
  if (not FGoAlwaysShowEditor) and (not fGoRowSelect) then
    EditFocusedItem(true);
  inherited;
end;

procedure TCustomElTreeGrid.SetgoRowSelect(Value: Boolean);
begin
  if FgoRowSelect <> Value then
  begin
    FgoRowSelect := Value;
    RowSelect := Value;
    if Value then
      SelectColumn := -1
    else
      SelectColumn := 0;
  end;
end;

procedure TCustomElTreeGrid.SetgoColMoving(Value: Boolean);
begin
  if FgoColMoving <> Value then
  begin
    FgoColMoving := Value;
    DraggableSections := Value;
  end;
end;

function TCustomElTreeGrid.CreateView: TElTreeView;
begin
  result := TElTreeGridView.Create(Self);
end;  { CreateView }

function TCustomElTreeGrid.CellRect(ACol, ARow: Longint): TRect;
var Item : TElTreeItem;
begin
  Item := GetAsCell(ACol, ARow);
  if Item <> nil then
  begin
    Result := GetItemRect(ARow);
    Result.Left := FHeader.Sections[ACol].Left;
    Result.Right := Result.Left + FHeader.Sections[ACol].Width;
    OffsetRect(Result, -FHeader.Left, 0);
  end
  else
  begin
    SetRectEmpty(Result);
  end;
end;

procedure TCustomElTreeGrid.ChangeScale(M, D: Integer);
var
  i: Integer;
begin
  inherited;

  if M <> D then
  begin
    if DefaultRowHeight > 0 then
      DefaultRowHeight := MulDiv(DefaultRowHeight, M, D);

    HeaderHeight := MulDiv(HeaderHeight, M, D);
    DefaultColWidth := MulDiv(DefaultColWidth, M, D);
    DefaultSectionWidth := MulDiv(DefaultSectionWidth, M, D);

    for i := 0 to HeaderSections.Count - 1 do
      HeaderSections[i].Width := MulDiv(HeaderSections[i].Width, M, D);
  end;
end;

function TCustomElTreeGrid.GetAsCell(ACol, ARow : Integer): TElTreeItem;
begin
  if (Integer(Items.Count) > ARow) and (FHeader.Sections.Count > ACol) then
    Result := Items[ARow]
  else
    Result := nil;
end;

procedure TCustomElTreeGrid.MouseToCell(X, Y: Integer; var ACol, ARow: Longint);
var Item : TElTreeItem;
    hc   : integer;
    ip   : TSTItemPart;
begin
  Item := GetItemAt(X, Y, ip, hc);
  if ip = ipOutside then
  begin
    ACol := -1;
    ARow := -1;
  end
  else
  begin
    ARow := Item.AbsoluteIndex;
    ACol := hc;
  end;
end;

function TCustomElTreeGrid.GetCol: Integer;
begin
  result := SelectColumn;
end;

procedure TCustomElTreeGrid.SetCol(Value: Integer);
begin
  if (Value <> -1) or (not FgoRowSelect) then
    SelectColumn := Value
  else
    SelectColumn := -1;
end;

function TCustomElTreeGrid.GetRow: Integer;
begin
  if ItemFocused <> nil then
    Result := ItemFocused.AbsoluteIndex
  else
    Result := -1;
end;

procedure TCustomElTreeGrid.SetRow(Value: Integer);
begin
  if (Value >= 0) and (Value < Integer(Items.Count)) then
    ItemFocused := Items[Value]
  else
    raise EElTreeGridError.Create('Row index out of bounds');
end;

function TCustomElTreeGrid.GetLeftCol: Integer;
var HS : TElHeaderSection;
begin
  if Left = 0 then
    Result := 0
  else
  begin
    HS := FHeader.GetSectionAt(Left, 0);
    if HS <> nil then
      result := HS.Index
    else
      result := -1;
  end;
end;

procedure TCustomElTreeGrid.SetLeftCol(Value: Integer);
begin
  if Value < FHeader.Sections.Count then
    Left := FHeader.Sections[Value].Left;
end;

function TCustomElTreeGrid.GetColCount: Integer;
begin
  Result := FHeader.Sections.Count;
end;

procedure TCustomElTreeGrid.SetColCount(Value: Integer);
begin
  if Value < 1 then exit;
  IsUpdating := true;
  try
    if Value < FHeader.Sections.Count then
      with FHeader.Sections do
        while Count > Value do
          DeleteSection(Item[Count - 1]);
    if Value > FHeader.Sections.Count then
    begin
      with FHeader.Sections do
        while Count < Value do
          AddSection.Editable := goEditing;
    end;
  finally
    IsUpdating := false;
  end;
end;

function TCustomElTreeGrid.GetColWidths(Index: Integer): Integer;
begin
  if Index >= FHeader.Sections.Count then
    raise EElTreeGridError.Create('Column index out of bounds');
  Result := FHeader.Sections[Index].Width;
end;

procedure TCustomElTreeGrid.SetColWidths(Index: Integer; Value: Integer);
begin
  if Index >= FHeader.Sections.Count then
    raise EElTreeGridError.Create('Column index out of bounds');
  FHeader.Sections[Index].Width := Value;
end;

function TCustomElTreeGrid.GetDefaultColWidth: Integer;
begin
  Result := FHeader.DefaultWidth;
end;

procedure TCustomElTreeGrid.SetDefaultColWidth(Value: Integer);
begin
  FHeader.DefaultWidth := Value;
end;

function TCustomElTreeGrid.GetDefaultRowHeight: Integer;
begin
  if AutoLineHeight then
    Result := -1
  else
    Result := LineHeight;
end;

procedure TCustomElTreeGrid.SetDefaultRowHeight(Value: Integer);
begin
  if Value = -1 then
    AutoLineHeight := true
  else
  begin
    AutoLineHeight := false;
    LineHeight := Value;
  end;
end;

function TCustomElTreeGrid.GetEditorMode: Boolean;
begin
  Result := IsEditing;
end;

procedure TCustomElTreeGrid.SetEditorMode(Value: Boolean);
begin
  if Value <> EditorMode then
  begin
    if Value then
      EditFocusedItem(true)
    else
      EndEdit(true);
  end;
end;

function TCustomElTreeGrid.GetRowCount: Integer;
begin
  Result := Items.Count;
end;

procedure TCustomElTreeGrid.SetRowCount(Value: Integer);
begin
  if Value < 0 then exit;
  IsUpdating := true;
  try
  while Value < Integer(Items.Count) do
    with Items do
      DeleteItem(TElTreeItem(FAllList.Last));

  if Value > Integer(Items.Count) then
  begin
    Items.AllocateStorage(Value);
    while Value > Integer(Items.Count) do
      Items.AddLastItem(nil);
  end;
  finally
    IsUpdating := false;
  end;
end;

function TCustomElTreeGrid.GetTopRow: Integer;
begin
  Result := TopIndex;
end;

procedure TCustomElTreeGrid.SetTopRow(Value: Integer);
begin
  TopIndex := Value;
end;

constructor TCustomElTreeGrid.Create(Owner : TComponent);
begin
  inherited;
  DefaultColWidth := 64;
  DefaultRowHeight := 24;
  ColCount := 5;
  RowCount := 5;
  ShowColumns := true;
  LockHeaderHeight := true;
  HeaderHeight := 0;
  MultiSelect := false;
  RowSelect := false;
  SelectColumn := 0;
  HotTrack := false;
  ShowRoot := false;
  ShowButtons := false;
  ShowLines := false;
  ShowImages := false;
  goEditing := true;
  goColMoving := true;
  VerticalLines := true;
  HorizontalLines := true;
  AlwaysKeepSelection := true;
  AlwaysKeepFocus := true;
  VerticalLinesLong := false;
end;

function TCustomElTreeGrid.GetgoEditing: Boolean;
begin
  Result := DoInplaceEdit;
end;

procedure TCustomElTreeGrid.SetgoEditing(Value: Boolean);
var i : integer;
begin
  DoInplaceEdit := Value;
  for i := 0 to FHeader.Sections.Count - 1 do
    FHeader.Sections[i].Editable := Value;
end;

procedure TCustomElTreeGrid.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTCHARS;
  if goTabs then
    Message.Result := Message.Result or DLGC_WANTTAB;
end;

procedure TCustomElTreeGrid.MouseDownTransfer(Sender : TObject; Button :
    TMouseButton; Shift : TShiftState; X : Integer; Y : Integer);
var ARow,
    ACol : integer;
    HCol : integer;
    IP   : TSTItemPart;
    it: TElTreeItem;
begin
//  if ssDouble in Shift then exit;
  Y := Y ;
  X := X + FView.Left;
  MouseToCell(X + FView.Left, Y + FView.Top, ACol, ARow);
  if (ARow <> -1) and (ACol <> -1) and (Button = mbLeft) then
  begin
    if FGoAlwaysShowEditor {and (not fGoRowSelect)} and IsEditing then
      EndEdit(not ExplorerEditMode);
    if (ARow = Row) and (ACol = Col) and
       (not FGoAlwaysShowEditor) {and (not fGoRowSelect) } then
      Self.EditorMode := true
    else
    begin
      it := GetItemAt(X, Y + FView.Top, IP, HCol);
      if ip <> ipButton then
      begin
        Row := ARow;
        if it = ItemFocused then
        begin
          Col := ACol;
          DoAfterSelectionChange;
        end;
        if FgoAlwaysShowEditor then
          EditFocusedItem(true);
      end;
    end;
//  FRow := ARow;
//  FCol := ACol;
  end;
  inherited;
end;  { MouseDownTransfer }

procedure TCustomElTreeGrid.EnsureColumnVisible(SectionNumber : integer);
var Section : TElHeaderSection;
begin
  if (SectionNumber >= 0) and (SectionNumber < FHeader.Sections.Count) then
  begin
    Section := FHeader.Sections[SectionNumber];
    if LeftPosition + FView.Width < Section.Right then
    begin
      LeftPosition := Section.Right - FView.Width;
    end
    else
    if LeftPosition > Section.Left then
    begin
      LeftPosition := Section.Left;
    end;
  end;
end;

function TCustomElTreeGrid.GetNextEditableSection(Section : TElHeaderSection;
    GoForward : boolean): TElHeaderSection;
var i : integer;
begin
  result := Section;
  if not Result.Editable then
    repeat
      if GoForward then
      begin
        i := Section.Position + 1;
        if i >= HeaderSections.Count then
          i := 0;
      end
      else
      begin
        i := Section.Position - 1;
        if i = -1 then
          i := HeaderSections.Count - 1;
      end;
      result := FHeader.Sections.ItemByPos[i];
    until (result = Section) or (result.Editable);
end;

function TCustomElTreeGrid.GetNextTabSection(SectionIndex : integer; var
    ToNextItem : boolean): TElHeaderSection;
var
  CurIndex: integer;
  Section: TElHeaderSection;
begin
  ToNextItem := false;
  Section := FHeader.Sections[SectionIndex];
  CurIndex := Section.Position;
  repeat
    inc(CurIndex);
    if CurIndex >= FHeader.Sections.Count then
    begin
      ToNextItem := true;
      CurIndex := 0;
    end;
    Section := FHeader.Sections.ItemByPos[CurIndex];
    if Section.Visible then
    begin
      if (not goEditing) or (not goTabSkipNonEditable) or Section.Editable then
      begin
        result := Section;
        exit;
      end;
    end;
  until not Assigned(FHeader.Sections.ItemByPos[CurIndex]);
  result := FHeader.Sections[SectionIndex];
end;

function TCustomElTreeGrid.GetPrevTabSection(SectionIndex : integer; var
    ToNextItem : boolean): TElHeaderSection;
var
  CurIndex  : integer;
  Section: TElHeaderSection;
begin
  ToNextItem := false;
  Section := FHeader.Sections[SectionIndex];
  CurIndex := Section.Position;
  repeat
    dec(CurIndex);
    if CurIndex < 0 then
    begin
      ToNextItem := true;
      CurIndex := FHeader.Sections.Count - 1;
    end;
    Section := FHeader.Sections.ItemByPos[CurIndex];
    if Section.Visible then
    begin
      if (not goEditing) or (not goTabSkipNonEditable) or Section.Editable then
      begin
        result := Section;
        exit;
      end;
    end;
  until not Assigned(FHeader.Sections.ItemByPos[CurIndex]);
  result := FHeader.Sections[SectionIndex];
end;

procedure TCustomElTreeGrid.TriggerRowAddedEvent;
begin
  if assigned(FOnRowAdded) then FOnRowAdded(Self);
end;

function TElTreeGridView.IntLButtonDown(X, Y : integer; Shift : TShiftState) : boolean;
{var
  ItemPart: TSTItemPart;
  HCol    : Integer;
  Item    : TElTreeItem;}
begin
  result := false;
  DoHideLineHint;
  FIgnoreClick2 := false;
  {  if (not (csDesigning in ComponentState)) and (not Focused) and CanFocus then
    SetFocus;
  FPressCoord := Point(X, Y);
  FPressed := true;
  Item := GetItemAt(X, Y, ItemPart, HCol);
  if ItemPart <> ipOutside then
  begin
    if (ItemPart in [ipButton, ipPicture, ipPicture2, ipCheckBox]) or ((ItemPart = ipColumn) and IsControlCell(Item, HCol)) then
      result := true
    else
    begin
      TCustomElTreeGrid(FOwner).MouseDownTransfer(Self, mbLeft, [], X, Y);
    end;
  end;}
end;

procedure TElTreeGridView.WMLButtonDown(var Message: TWMLButtonDown);
begin
//  if IntLButtonDown(Message.XPos, Message.YPos, KeyDataToShiftState(Message.Keys)) then
  IntLButtonDown(Message.XPos, Message.YPos, KeyDataToShiftState(Message.Keys));
    inherited;
end;

function TElTreeGridView.NeedToFoxusItemInMouseDown: Boolean;
begin
  Result := false;
end;

procedure TElTreeGridView.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTCHARS;
  if (Owner as TCustomElTreeGrid).goTabs then
    Message.Result := Message.Result or DLGC_WANTTAB;
end;

function TElTreeStringGrid.GetCols(Index: Integer): TLMDStrings;
var i    : integer;
    Item : TElTreeItem;
    hs   : integer;
begin
  if FCols = nil then
    FCols := TLMDStringArray.Create;
  Result := FCols;
  // filling the cols
  FCols.Clear;
  hs := Index;
  if Index > MainTreeColumn then
    dec(hs);
  for i := 0 to Items.Count - 1 do
  begin
    Item := Items[i];
    if hs = MainTreeColumn then
      FCols.AddObject(Item.Text, Item.AnObject)
    else
    begin
      if Item.ColumnText.count <= hs then
        FCols.AddObject('', nil)
      else
        FCols.AddObject(Item.ColumnText[hs], Item.ColumnText.Objects[hs]);
    end;
  end;
end;

procedure TElTreeStringGrid.SetCols(Index: Integer; Value: TLMDStrings);
var i : integer;
begin
  IsUpdating := true;
  try
    while Index >= FHeader.Sections.Count do
      FHeader.Sections.AddSection.Editable := goEditing;

    Items.AllocateStorage(Value.Count);
    while Value.Count > Integer(Items.Count) do
      Items.AddLastItem(nil);
    for i := 0 to Value.Count - 1 do
    begin
      Cells[Index, i] := Value[i];
      Objects[Index, i] := Value.Objects[i];
    end;
  finally
    IsUpdating := false;
  end;
end;

function TElTreeStringGrid.GetRows(Index: Integer): TLMDStrings;
var i    : integer;
    Item : TElTreeItem;
begin
  if FRows = nil then
    FRows := TLMDStringArray.Create;
  Result := FRows;
  // filling the rows
  FRows.Clear;
  if Index > Integer(Items.Count) - 1 then
    exit;
  Item := Items[Index];

  for i := 0 to FHeader.Sections.Count - 1 do
  begin
    if i < MainTreeColumn then
    begin
      if Item.ColumnText.count <= i then
        FRows.AddObject('', nil)
      else
        FRows.AddObject(Item.ColumnText[i], Item.ColumnText.Objects[i]);
    end
    else
    if i = MainTreeColumn then
      FRows.AddObject(Item.Text, Item.AnObject)
    else
    begin
      if Item.ColumnText.count <= i - 1 then
        FRows.AddObject('', nil)
      else
        FRows.AddObject(Item.ColumnText[i - 1], Item.ColumnText.Objects[i - 1]);
    end;
  end;
end;

procedure TElTreeStringGrid.SetRows(Index: Integer; Value: TLMDStrings);
var i : integer;
begin
  IsUpdating := true;
  try
    Items.AllocateStorage(Index + 1);
    while Index >= Integer(Items.Count) do
      Items.AddLastItem(nil);
    while Value.Count > FHeader.Sections.Count do
      FHeader.Sections.AddSection;
    for i := 0 to Value.Count - 1 do
    begin
      Cells[i, Index] := Value[i];
      Objects[i, Index] := Value.Objects[i];
    end;
  finally
    IsUpdating := false;
  end;
end;

constructor TElTreeStringGrid.Create(Owner : TComponent);
begin
  inherited;
  FEditor := TElTreeTrickyInplaceEdit.Create(Self);
  FEditor.Editor.ButtonVisible := false;
  FEditor.Editor.AltButtonVisible := false;
  FEditor.Editor.OnKeyDown := EditorKeyDown;
  // FEditor.Tree := Self;
  FSavedEditWndProc := FEditor.Editor.WindowProc;
  FEditor.Editor.WindowProc := EditWndProc;
//  FCol := -1;
//  FRow := -1;
end;

destructor TElTreeStringGrid.Destroy;
begin
  if FRows <> nil then
    FRows.Free;
  if FCols <> nil then
    FCols.Free;
  FCols := nil;
  FRows := nil;
  FEditor.Free;
  inherited;
end;

procedure TElTreeStringGrid.TriggerInplaceEditorNeeded(Item : TElTreeItem;
          SectionIndex : Integer; SupposedFieldType : TElFieldType;
          var Editor : TElTreeInplaceEditor);
begin
  inherited;
  if UseDefaultEditor {or (Editor = nil) }then
    Editor := FEditor
  else
    if Editor = FEditor then
      Editor := nil;
end;

procedure TElTreeStringGrid.SetEditor(Value : TElTreeInplaceButtonEdit);

begin
  FEditor.Assign(Value);
end;

function TElTreeStringGrid.GetCells(ACol, ARow: Integer): TLMDString;
begin
  if (ARow >= Integer(Items.Count)) or
    (Items[ARow].ColumnText.Count + 1 <= ACol) then
    Result := ''
  else
  begin
    if ACol = MainTreeColumn then
      Result := Items[ARow].Text
    else
    if ACol < MainTreeColumn then
      Result := Items[ARow].ColumnText[ACol]
    else
      Result := Items[ARow].ColumnText[ACol - 1];
  end;
end;

procedure TElTreeStringGrid.SetCells(ACol, ARow: Integer; Value: TLMDString);
var Item : TElTreeItem;
    hs : integer;
begin
  IsUpdating := true;
  try
    Items.AllocateStorage(ARow + 1);
    while ARow >= Integer(Items.Count) do
      Items.AddItem(nil);
    while ACol >= FHeader.Sections.Count do
      FHeader.Sections.AddSection;
    Item := Items[ARow];
    hs := ACol;
    if ACol > MainTreeColumn then
      dec(hs);
    if ACol = MainTreeColumn then
      Item.Text := Value
    else
    begin
      while Item.ColumnText.Count <= hs do
        Item.ColumnText.Add('');
      Item.ColumnText[hs] := Value;
    end;
  finally
    IsUpdating := false;
  end;
end;

function TElTreeStringGrid.GetObjects(ACol, ARow: Integer): TObject;
begin
  if (ARow >= Integer(Items.Count)) or
    (Items[ARow].ColumnText.Count + 1 <= ACol) then
    Result := nil
  else
  begin
    if ACol = MainTreeColumn then
      Result := Items[ARow].AnObject
    else
    if ACol < MainTreeColumn then
      Result := Items[ARow].ColumnText.Objects[ACol]
    else
      Result := Items[ARow].ColumnText.Objects[ACol - 1];
  end;
end;

procedure TElTreeStringGrid.SetObjects(ACol, ARow: Integer; Value: TObject);
var Item : TElTreeItem;
    hs : integer;
begin
  IsUpdating := true;
  try
    Items.AllocateStorage(ARow + 1);
    while ARow >= Integer(Items.Count) do
      Items.AddItem(nil);
    while ACol >= FHeader.Sections.Count do
      FHeader.Sections.AddSection;
    Item := Items[ARow];
    hs := ACol;
    if ACol > MainTreeColumn then
      dec(hs);
    if ACol = MainTreeColumn then
      Item.AnObject := Value
    else
    begin
      while Item.ColumnText.Count <= hs do
        Item.ColumnText.Add('');
      Item.ColumnText.Objects[hs] := Value;
    end;
  finally
    IsUpdating := false;
  end;
end;

procedure TElTreeStringGrid.KeyDownTransfer(Sender : TObject; var Key : Word;
    Shift : TShiftState);
begin
  if (Key = VK_F2) and (Shift = []) and (not IsEditing) then
  begin
    EditorMode := true;
  end;
  if (Key = VK_RETURN) and (Shift = []) and (not fgoRowSelect) then
  begin
    if (not IsEditing) then
      EditorMode := true;
  end;
  inherited;
end;

procedure TElTreeStringGrid.OnFontChange(Sender: TObject);
begin
  inherited;
  // todo:
  //Editor.Editor.Font.Assign(Font);
end;

procedure TElTreeStringGrid.EditorKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
  if (Shift = []) then
  begin
    case Key of
      VK_DOWN, VK_UP:
        begin
          EndEdit(not ExplorerEditMode);
          if Key = VK_UP then
          begin
            if Row > 0 then
              Row := Row - 1;
          end
          else
          begin
            if Row < RowCount - 1 then
              Row := Row + 1;
          end;
          Key := 0;
          if FgoAlwaysShowEditor then
            EditFocusedItem(true);
          //KeyDownTransfer( Self, Key, Shift );
        end;
      VK_RETURN:
        if not goAlwaysShowEditor then
        begin
          Key := 0;
          EndEdit(false);
        end;
      VK_RIGHT:
        if FEditor.Editor.SelStart >= Length(FEditor.Editor.Text) then
        begin
          Key := 0;
          EndEdit(not ExplorerEditMode);
          if (Col+1) < ColCount then
            Col := Col + 1
          else
            if (Row+1) < RowCount then
            begin
              Col := 0;
              Row := Row + 1;
            end;
          if FgoAlwaysShowEditor then
            EditFocusedItem(true);
        end;
      VK_LEFT:
        if FEditor.Editor.SelStart <= 0 then
        begin
          Key := 0;
          EndEdit(not ExplorerEditMode);
          if Col > 0 then
            Col := Col - 1
          else
            if Row > 0 then
            begin
              Col := ColCount - 1;
              Row := Row - 1;
            end;
          if FgoAlwaysShowEditor then
            EditFocusedItem(true);
        end;
      VK_TAB:
        begin
          EndEdit(not ExplorerEditMode);
          KeyDownTransfer(Self, Key, Shift);
          Key := 0;

          (*
          if (Col+1) < ColCount then
            Col := Col + 1
          else
            if (Row+1) < RowCount then
            begin
              Col := 0;
              Row := Row + 1;
            end;
          *)
        end;
    end;

//    if Key in [VK_TAB, VK_RIGHT] then
//      if FEditor.Editor.SelStart > Length(FEditor.Editor.Text)

    (*
    if (Key = VK_RETURN) and (not goAlwaysShowEditor) then
      EndEdit(false)
    else
    if Key = VK_LEFT then
    begin
      if FEditor.Editor.SelStart = 0 then
      begin
        EndEdit(False);
      end;
    end
    else
    if Key = VK_RIGHT then
    begin
      if FEditor.Editor.SelStart = Length(FEditor.Editor.Text) then
      begin
        EndEdit(False);
      end;
    end;
    *)
  end;
  inherited;
end;

procedure TElTreeStringGrid.EditWndProc(var Message: TMessage);
begin
  case Message.Msg of
    // WM_KILLFOCUS: if FEditor.Editor.Visible then EndEdit( false );
    WM_GETDLGCODE: Message.Result := DLGC_WANTCHARS or DLGC_WANTTAB or DLGC_WANTARROWS or DLGC_WANTALLKEYS;
  end;
  if Message.Msg <> WM_GETDLGCODE then
    FSavedEditWndProc( Message )
end;

function TElTreeStringGrid.GetIncSearchColumnText(Item : TElTreeItem):
    TLMDString;
var i : integer;
begin
  if goRowSelect or (SelectColumn = -1) or (SelectColumn = MainTreeColumn) then
    Result := inherited GetIncSearchColumnText(Item)
  else
  begin
    i := SelectColumn;
    if i > MainTreeColumn then
      dec(i);
    if (Item.ColumnText = nil) or (Item.ColumnText.Count >= i) then
      result := ''
    else
      result := Item.ColumnText[i];
  end;
end;

procedure TCustomElTreeGrid.OnHeaderSectionDelete(Header: TCustomElHeader; Section: TElHeaderSection);
begin
  if Col >= FHeader.Sections.Count then
    Col := Col - 1;
  inherited;
end;

procedure TCustomElTreeGrid.EditFocusedItem(ForcedEdit: boolean);
var
  LDoEdit: Boolean;
begin
  if Assigned(ItemFocused) then
  begin
    LDoEdit := ForcedEdit or (FGoAlwaysShowEditor and (not fGoRowSelect));
    if LDoEdit then
    begin
      if SelectColumn = -1 then
      begin
        if HeaderSections[MainTreeColumn].Editable then
          EditItem(ItemFocused, SelectColumn);
      end
      else
        if HeaderSections[SelectColumn].Editable then
          EditItem(ItemFocused, SelectColumn);
    end;
  end;
end;

end.
