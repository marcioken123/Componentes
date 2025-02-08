unit ElDBXTreeGrids;
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

ElDBXTreeGrids unit
-------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils,
  Windows,
  Forms,
  Messages,
  Controls,
  StdCtrls,
  ElDBTreeEditors,

  Types,

  LMDTypes,
  ElVCLUtils,
  ElStrArray,
  ELXTree,
  ElDBXTree,
  LMDElDBConst,
  ElHeader,
  LMDUnicodeStrings,
  ElTreeInplaceEditors,
  Classes;

type

  TCustomElDBXTreeGrid = class;

  THackElXStylesDefsItem = class(TElXStylesDefsItem);

  TElDBXTreeGridColumns = class(TPersistent)
  private
    Tree : TCustomElDBXTreeGrid;
  protected
    procedure SetDataSetName(DatasetName : string);
    function GetDataSetName : string;
  public
    property DataSetName: string read GetDataSetName Write SetDataSetName;
    procedure Add(FieldName: string; HeaderTitle: TLMDString);
    procedure Insert(FieldName: string; HeaderTitle: TLMDString; ColumnIndex: Integer = 0);
    procedure Delete(ColumnIndex: Integer = 0);
    function  GetFieldNameByIndex(ColumnIndex: Integer): String;
    procedure  SetFieldNameByIndex(ColumnIndex: Integer; FieldName: string);
    procedure  AddAllFields;
  published
  end;

  TCustomElDBXTreeGrid = class(TCustomElDBXTree)
  private
    FgoAlwaysShowEditor: Boolean;
    FgoRowSelect: Boolean;
    FgoColMoving: Boolean;
    FgoTabs: Boolean;
    FColumns : TElDBXTreeGridColumns;

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
    function GetTopRow: Integer;
    procedure SetTopRow(Value: Integer);
    function GetgoEditing: Boolean;
    procedure SetgoEditing(Value: Boolean);
  protected
    FgoTabSkipNonEditable: Boolean;
    FgoDeletion: Boolean;

    procedure KeyDownTransfer(Sender: TObject; var Key: Word; Shift: TShiftState);override;
    function CreateView: TElXTreeView; override;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    function GetNextTabSection(SectionIndex : integer; var ToNextItem : boolean):
        TElHeaderSection;
    function GetPrevTabSection(SectionIndex : integer; var ToNextItem : boolean):
        TElHeaderSection;

    property goRowSelect: Boolean read FgoRowSelect write SetgoRowSelect;
    property goColMoving: Boolean read FgoColMoving write SetgoColMoving default true;
    property goTabs: Boolean read FgoTabs write FgoTabs;
    property ColCount: Integer read GetColCount write SetColCount default 5;
    property DefaultColWidth: Integer read GetDefaultColWidth write
      SetDefaultColWidth default 64;
    property DefaultRowHeight: Integer read GetDefaultRowHeight write
      SetDefaultRowHeight default 24;
    property EditorMode: Boolean read GetEditorMode write SetEditorMode;
    property RowCount: Integer read GetRowCount;
    property goEditing: Boolean read GetgoEditing write SetgoEditing default true;
    property goTabSkipNonEditable: Boolean read FgoTabSkipNonEditable write
      FgoTabSkipNonEditable;
    property goDeletion: Boolean read FgoDeletion write FgoDeletion default false;
  public
    procedure RebuildTree(KeepCurrentID: Boolean);override;
//    function CellRect(ACol, ARow: Longint): TRect;
//    procedure MouseToCell(X, Y: Integer; var ACol, ARow: Longint);
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    function GetNextEditableSection(Section: TElHeaderSection; GoForward:
      boolean): TElHeaderSection;
    property Col: Integer read GetCol write SetCol;
    property Header;
    property ColWidths[Index: Integer]: Integer read GetColWidths write
      SetColWidths;
    property LeftCol: Integer read GetLeftCol write SetLeftCol;
    property Row: Integer read GetRow write SetRow;
    property TopRow: Integer read GetTopRow write SetTopRow;
  published
    property Columns : TElDBXTreeGridColumns  read FColumns;
    property VerticalLines default true;
    property HorizontalLines default true;
  end;

  {$IFNDEF LMD_UNICODE}
  TElDBXTreeWideStringEdit = TElDBTreeEdit;
  {$else}
  TElDBXTreeWideStringEdit = TElDBTreeWideStringEdit;
  {$ENDIF}

  TElDBXTreeTrickyInplaceEdit = class(TElDBXTreeWideStringEdit)
  private
    FDummyStr: string;
  published
    property Name: string read FDummyStr;
    property Tree: string read FDummyStr;
  end;

  TElDBXTreeStringGrid = class(TCustomElDBXTreeGrid)
  private
    FCols: TLMDStringArray;
    FRows: TLMDStringArray;
    FEditor: TElDBXTreeWideStringEdit;
    FSavedEditWndProc: TWndMethod;
    function GetCols(Index: Integer): TLMDStrings;
//    procedure SetCols(Index: Integer; Value: TLMDStrings);
    function GetRows(Index: Integer): TLMDStrings;
    function GetCells(ACol, ARow: Integer): TLMDString;
    procedure SetCells(ACol, ARow: Integer; Value: TLMDString);
    function GetObjects(ACol, ARow: Integer): TObject;
    procedure SetObjects(ACol, ARow: Integer; Value: TObject);
    procedure SetEditor(Value: TElDBXTreeWideStringEdit);
    protected
    FUseDefaultEditor: Boolean;
    procedure TriggerInplaceEditorNeeded(Item: TElXTreeItem; SectionIndex: Integer;
      SupposedFieldType: TElFieldType; var Editor: TElTreeInplaceEditor); override;
    procedure OnFontChange(Sender: TObject); override;

    procedure KeyDownTransfer(Sender: TObject; var Key: Word; Shift:
      TShiftState); override;
    procedure EditorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditWndProc(var Message: TMessage);
    public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    property Cols[Index: Integer]: TLMDStrings read GetCols;
    property Rows[Index: Integer]: TLMDStrings read GetRows;
    property Cells[ACol, ARow: Integer]: TLMDString read GetCells write SetCells;
    default;
    property Objects[ACol, ARow: Integer]: TObject read GetObjects write SetObjects;

    property Editor: TElDBXTreeWideStringEdit read FEditor write SetEditor;
  published
//    property NoRebuildOnDataChange;
    property UseThemeForSelection;
    property FixedTopRowNum;
    property FixedBottomRowNum;
    property FixedColNum;
    property GutterWidth;
    property DataSource;
    property UseDefaultEditor: Boolean read FUseDefaultEditor write
      FUseDefaultEditor default false;

    property IncrementalSearchTimeout;
    property IncrementalSearch;
    property MultiSelect default False;
    property ColCount default 5;
    property RowCount;
    property goRowSelect default false;
    property goColMoving default true;
    property goDeletion default false;
    property goEditing default true;
    property goTabs default false;
    property goTabSkipNonEditable default false;
    property DefaultColWidth default 64;
    property DefaultRowHeight default 24;

    property ActiveBorderType;
    property Align;
    property AutoLookup;
    property AutoResizeColumns;

    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property BevelKind;
    property DragKind;
    property DoubleBuffered;

    property AdjustMultilineHeight;
    property Background;
    property BackgroundType;
    property LineHeight;
    property BorderStyle;
    property Ctl3D;
    property DragCursor;
    property ChangeDelay;
    property ChangeStateImage;
    property CheckBoxFlat;
    property CheckBoxGlyph;
    property CheckBoxSize;
    property Color;
    property Cursor;
    property CustomCheckboxes;
    property CustomPlusMinus;
    property VertDivLinesColor;
    property HorzDivLinesColor;
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
    property HeaderRowCount;
    property HeaderHotTrack;
    property HeaderInvertSortArrows;
    property HeaderUseTreeFont;
    property HeaderSections;
    property HeaderFilterColor;
    property HeaderFlat;
    property HeaderFont;
    property HeaderImages;
    property AlphaForHeaderImages;

    property HeaderWrapCaptions;
    property BackGroundColor;

    property HideFocusRect;
    property HideHintOnTimer;
    property HideHintOnMove;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;
    property HideSelection;
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

    property OnHTMLImageNeeded;
    property OnLinkClick;
    property LinkCursor;
    property LinkColor;  { Published }
    property LinkStyle;  { Published }

    property LineBorderActiveColor;
    property LineBorderInactiveColor;
    property LinesColor;
    property LinesStyle;
    property LineHintColor;
    property LineHintMode default shmLong;
    property LineHintTimeout;
    property LockHeaderHeight default true;
    property MainTreeColumn;
    property MinusPicture;
    property MoveFocusOnCollapse;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PlusMinusTransparent;
    property PlusPicture;
    property PopupMenu;
    property QuickEditMode;
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
    property StripedEvenColor;
    property StripedItems;
    property StripedOddColor;

    property Storage;
    property StoragePath;

    property StickyHeaderSections;
    property TabOrder;
    property TabStop;
    property UseCustomScrollBars;

    property VerticalLines default true;
    property VerticalLinesLong default false;
    property VertScrollBarStyles;
    property Visible;
    property UseSystemHintColors;
    property TextColor;
//    property BkColor;

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

    property SelectColumn;

    property OnAfterSelectionChange;
    property OnChanging;
    property OnDragTargetChange;
    property OnItemChange;
    property OnItemChanged;
    property OnCellChange;
    property OnItemPreDraw;
    property OnItemDraw;
    property OnResize;

    property OnInplaceEditorNeeded;

    property OnItemChecked;
    property OnItemExpand;
//    property OnItemCreated;
    property OnItemCollapse;
    property OnItemExpanding;
    property OnItemCollapsing;
    property OnItemDeletion;
    property OnItemCreated;
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
    property OnCellDeletion;
    property OnVertScrollDrawPart;
    property OnVertScrollHintNeeded;
    property OnHeaderMouseDown;
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

  TElDBXTreeGridView = class(TElDBXTreeView)
  protected
////    function IntLButtonDown(X, Y : integer; Shift : TShiftState) : boolean;
//
////    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  end;

  EElXDBTreeGridError = class(EElTreeError);

implementation

{$hints off}

procedure TCustomElDBXTreeGrid.KeyDownTransfer(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var i, j: integer;
  Item: TElXTreeItem;
  b: boolean;
  Section: TElHeaderSection;

  procedure ToNextSection;
    begin
      if FGoAlwaysShowEditor and (not fGoRowSelect) and IsEditing then
      begin
        Key := 0;
        EndEdit(not ExplorerEditMode);
      end;

      b := false;
      Section := GetNextTabSection(SelectColumn, b);

//       move focus to next item
      if b = true then
      begin
        i := ItemFocused.AbsoluteIndex;

        if i = Integer(Items.Count) - 1 then
          i := -1;
        ItemFocused := Items[i + 1];
        EnsureVisibleBottom(ItemFocused);
      end;

//       Select new section
      SelectColumn := Section.Index;
//      EnsureColumnVisible(SelectColumn);

      DoItemFocused;
      DoAfterSelectionChange;

      if FGoAlwaysShowEditor and (not fGoRowSelect) and HeaderSections[SelectColumn].Editable then
         EditItem(ItemFocused, SelectColumn);
    end;

    procedure ToPrevSection;
    begin
      if FGoAlwaysShowEditor and (not fGoRowSelect) and IsEditing then
        EndEdit(not ExplorerEditMode);

      b := false;
      Section := GetPrevTabSection(SelectColumn, b);

//       move focus to next item
      if b = true then
      begin
        i := ItemFocused.AbsoluteIndex;

        if i = 0 then
          i := Integer(Items.Count);
        ItemFocused := Items[i - 1];
        EnsureVisible(ItemFocused);
      end;

//       Select new section
      SelectColumn := Section.Index;
//      EnsureColumnVisible(SelectColumn);

      DoItemFocused;
      DoAfterSelectionChange;

      if FGoAlwaysShowEditor and (not fGoRowSelect) and HeaderSections[SelectColumn].Editable then
        EditItem(ItemFocused, SelectColumn);
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
 { if (Shift = []) then
  begin
    if (ItemFocused <> nil) then
    begin
      if (Key = VK_PRIOR) or (Key = VK_NEXT) or
        (Key = VK_HOME) or (Key = VK_END) or
        (Key = VK_UP) or (Key = VK_DOWN) then
      begin
        Item := TElDBXTreeGridView(FView).FindNewFocused(Key, j, b);
        Item := TElDBXTreeGridView(FView).FindNewFocused(Key, @j, b);
        if Item <> nil then
        begin
          ItemFocused := (Item as TElDBXTreeItem);
          if (Key = VK_NEXT) or (Key = VK_END) or (Key = VK_DOWN) then
            EnsureVisibleBottom(ItemFocused)
          else
            EnsureVisible(ItemFocused);
        end;
        DoAfterSelectionChange;

        if FGoAlwaysShowEditor and (not fGoRowSelect) and HeaderSections[SelectColumn].Editable then
          EditItem(ItemFocused, SelectColumn);
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
        if ItemFocused = nil then
        begin
          ItemFocused := (Item as TElDBXTreeItem);
          DoAfterSelectionChange;

          if FGoAlwaysShowEditor and (not fGoRowSelect) and HeaderSections[SelectColumn].Editable then
            EditItem(Item, SelectColumn);
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
  end;}
end;
{$hints on}

procedure TCustomElDBXTreeGrid.WMChar(var Message: TWMChar);
begin
  if (not FGoAlwaysShowEditor) and (not fGoRowSelect) then
  begin
    if (QuickEditMode) and (ItemFocused <> nil) and HeaderSections[SelectColumn].Editable then
      EditItem(ItemFocused, SelectColumn);
  end;
  inherited;
end;

procedure TCustomElDBXTreeGrid.SetgoRowSelect(Value: Boolean);
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

procedure TCustomElDBXTreeGrid.SetgoColMoving(Value: Boolean);
begin
  if FgoColMoving <> Value then
  begin
    FgoColMoving := Value;
    DraggableSections := Value;
  end;
end;

function TCustomElDBXTreeGrid.CreateView: TElXTreeView;
begin
  result := TElDBXTreeGridView.Create(Self);
end; { CreateView }

//function TCustomElDBXTreeGrid.CellRect(ACol, ARow: Longint): TRect;
//var Item: TElXTreeItem;
//begin
//  Item := GetAsCell(ACol, ARow);
//  if Item <> nil then
//  begin
//    Result := GetItemRect(ARow);
//    Result.Left := FHeader.Sections[ACol].Left;
//    Result.Right := Result.Left + FHeader.Sections[ACol].Width;
//    OffsetRect(Result, -FHeader.Left, 0);
//  end
//  else
//  begin
//    SetRectEmpty(Result);
//  end;
//end;

//function TCustomElDBXTreeGrid.GetAsCell(ACol, ARow: Integer): TElXTreeItem;
//begin
//  if (Integer(Items.Count) > ARow) and (FHeader.Sections.Count > ACol) then
//    Result := Items[ARow]
//  else
//    Result := nil;
//end;

//procedure TCustomElDBXTreeGrid.MouseToCell(X, Y: Integer; var ACol, ARow: Longint);
//var Item: TElDBXTreeItem;
//  hc: integer;
//  ip: TSTXItemPart;
//begin
//  Item := GetItemAt(X, Y, ip, hc);
//  if ip = ipOutside then
//  begin
//    ACol := -1;
//    ARow := -1;
//  end
//  else
//  begin
//    ARow := Item.AbsoluteIndex;
//    ACol := hc;
//  end;
//end;

function TCustomElDBXTreeGrid.GetCol: Integer;
begin
  result := SelectColumn;
end;

procedure TCustomElDBXTreeGrid.SetCol(Value: Integer);
begin
  if (Value <> -1) or (not FgoRowSelect) then
    SelectColumn := Value
  else
    SelectColumn := -1;
end;

function TCustomElDBXTreeGrid.GetRow: Integer;
begin
  if ItemFocused <> nil then
    Result := ItemFocused.AbsoluteIndex
  else
    Result := -1;
end;

procedure TCustomElDBXTreeGrid.SetRow(Value: Integer);
begin
  if (Value >= 0) and (Value < Integer(Items.Count)) then
    ItemFocused := Items[Value]
  else
    raise EElXDBTreeGridError.Create('Row index out of bounds');
end;

function TCustomElDBXTreeGrid.GetLeftCol: Integer;
var HS: TElHeaderSection;
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

procedure TCustomElDBXTreeGrid.SetLeftCol(Value: Integer);
begin
  if Value < FHeader.Sections.Count then
    Left := FHeader.Sections[Value].Left;
end;

function TCustomElDBXTreeGrid.GetColCount: Integer;
begin
  Result := FHeader.Sections.Count;
end;

procedure TCustomElDBXTreeGrid.SetColCount(Value: Integer);
var
  i : Integer;
  b : Boolean;
begin
  if Value < 1 then exit;
  IsUpdating := true;
  if Value <> FHeader.Sections.Count then
    b := True
  else
    b := False;
  try
    if Value  < FHeader.Sections.Count then
      with FHeader.Sections do
        while Count > Value do
        begin
          DeleteSection(Item[Count-1]);
          if (not (csLoading in Self.ComponentState)) and (not (csDesigning in Self.ComponentState)) then
            for i := 0 to StylesDefs.Count-1 do
            begin
              if StylesDefs[i].DataFields.Count > Value - 1 then
                StylesDefs[i].DataFields.Delete(StylesDefs[i].DataFields.Count-1);
            end;
        end;
    if Value > FHeader.Sections.Count then
    begin
      with FHeader.Sections do
        while Count < Value do
        begin
          AddSection.Editable := goEditing;
          if (not (csLoading in Self.ComponentState)) and (not (csDesigning in Self.ComponentState)) then
            for i := 0 to StylesDefs.Count-1 do
            begin
              if (StylesDefs[i].DataFields.Count > 0) or StylesDefs[i].HasColumn then
              begin
                StylesDefs[i].DataFields.Add('empty column or defined by user');
              end;
            end;
        end;
    end;
  finally
    IsUpdating := false;
    if b {and (not Self.NoRebuildOnDataChange)} and (not (csLoading in Self.ComponentState)) and (not (csDesigning in Self.ComponentState)) then
      Self.RebuildTree(true);
  end;
end;

function TCustomElDBXTreeGrid.GetColWidths(Index: Integer): Integer;
begin
  if Index >= FHeader.Sections.Count then
    raise EElXDBTreeGridError.Create('Column index out of bounds');
  Result := FHeader.Sections[Index].Width;
end;

procedure TCustomElDBXTreeGrid.SetColWidths(Index: Integer; Value: Integer);
begin
  if Index >= FHeader.Sections.Count then
    raise EElXDBTreeGridError.Create('Column index out of bounds');
  FHeader.Sections[Index].Width := Value;
end;

function TCustomElDBXTreeGrid.GetDefaultColWidth: Integer;
begin
  Result := FHeader.DefaultWidth;
end;

procedure TCustomElDBXTreeGrid.SetDefaultColWidth(Value: Integer);
begin
  FHeader.DefaultWidth := Value;
end;

function TCustomElDBXTreeGrid.GetDefaultRowHeight: Integer;
begin
  if AutoLineHeight then
    Result := -1
  else
    Result := LineHeight;
end;

procedure TCustomElDBXTreeGrid.SetDefaultRowHeight(Value: Integer);
begin
  if Value = -1 then
    AutoLineHeight := true
  else
  begin
    AutoLineHeight := false;
    LineHeight := Value;
  end;
end;

function TCustomElDBXTreeGrid.GetEditorMode: Boolean;
begin
  Result := IsEditing;
end;

procedure TCustomElDBXTreeGrid.SetEditorMode(Value: Boolean);
begin
  if Value <> EditorMode then
  begin
    if Value then
    begin
      if (QuickEditMode) and (ItemFocused <> nil) {and (not goRowSelect) } and HeaderSections[SelectColumn].Editable then
        EditItem(ItemFocused, SelectColumn);
    end
    else
      EndEdit(true);
  end;
end;

function TCustomElDBXTreeGrid.GetRowCount: Integer;
begin
  Result := Items.Count;
end;

function TCustomElDBXTreeGrid.GetTopRow: Integer;
begin
  Result := TopIndex;
end;

procedure TCustomElDBXTreeGrid.SetTopRow(Value: Integer);
begin
  TopIndex := Value;
end;

constructor TCustomElDBXTreeGrid.Create(Owner: TComponent);
begin
  inherited;
  DefaultColWidth := 64;
  DefaultRowHeight := 24;
  ColCount := 5;
  ShowColumns := true;
  LockHeaderHeight := true;
  HeaderHeight := 0;
  MultiSelect := false;
  RowSelect := false;
  SelectColumn := 0;
//  Tracking := false;
  ShowRoot := false;
//  ShowButtons := false;
  ShowLines := false;
  ShowImages := false;
  goEditing := true;
  goColMoving := true;
  FgoAlwaysShowEditor := false;
  VerticalLines := true;
  HorizontalLines := true;
//  AlwaysKeepSelection := true;
//  AlwaysKeepFocus := true;
  VerticalLinesLong := false;
  FColumns := TElDBXTreeGridColumns.Create;
  FColumns.Tree := Self;
end;

destructor TCustomElDBXTreeGrid.Destroy;
begin
  FColumns.Free;
  inherited;
end;

function TCustomElDBXTreeGrid.GetgoEditing: Boolean;
begin
  Result := DoInplaceEdit;
end;

procedure TCustomElDBXTreeGrid.SetgoEditing(Value: Boolean);
var i: integer;
begin
  DoInplaceEdit := Value;
  for i := 0 to FHeader.Sections.Count - 1 do
    FHeader.Sections[i].Editable := Value;
end;

procedure TCustomElDBXTreeGrid.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTCHARS;
  if goTabs then
    Message.Result := Message.Result or DLGC_WANTTAB;
end;

//procedure TCustomElDBXTreeGrid.MouseDownTransfer(Sender: TObject; Button:
//  TMouseButton; Shift: TShiftState; X: Integer; Y: Integer);
//var ARow,
//    ACol : integer;
//    HCol : integer;
//    IP   : TSTItemPart;
//begin
//  Y := Y;
//  X := X + FView.Left;
//  MouseToCell(X + FView.Left, Y + FView.Top, ACol, ARow);
//  if (ARow <> -1) and (ACol <> -1) and (Button = mbLeft) then
//  begin
//    if FGoAlwaysShowEditor {and (not fGoRowSelect)} and IsEditing then
//      EndEdit(not ExplorerEditMode);
//    if (ARow = Row) and (ACol = Col) and
//      (not FGoAlwaysShowEditor) {and (not fGoRowSelect) } then
//      Self.EditorMode := true
//    else
//    begin
//      GetItemAt(X, Y, IP, HCol);
//      if ip <> ipButton then
//      begin
//        Row := ARow;
//        Col := ACol;
//        DoAfterSelectionChange;
//        if FGoAlwaysShowEditor and {(not fGoRowSelect) and}  HeaderSections[SelectColumn].Editable then
//          EditItem(ItemFocused, SelectColumn);
//      end;
//    end;
//  end;
//  inherited;
//end; { MouseDownTransfer }

//procedure TCustomElDBXTreeGrid.EnsureColumnVisible(SectionNumber: integer);
//var Section: TElHeaderSection;
//begin
//  if (SectionNumber >= 0) and (SectionNumber < FHeader.Sections.Count) then
//  begin
//    Section := FHeader.Sections[SectionNumber];
//    if LeftPosition + FView.Width < Section.Right then
//    begin
//      LeftPosition := Section.Right - FView.Width;
//    end
//    else
//      if LeftPosition > Section.Left then
//      begin
//        LeftPosition := Section.Left;
//      end;
//  end;
//end;

function TCustomElDBXTreeGrid.GetNextEditableSection(Section: TElHeaderSection;
  GoForward: boolean): TElHeaderSection;
var i: integer;
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

//function TElDBXTreeGridView.IntLButtonDown(X, Y : integer; Shift : TShiftState) : boolean;
//var
//  ItemPart: TSTItemPart;
//  HCol    : Integer;
//  Item    : TElXTreeItem;
//begin
//  result := false;
//  DoHideLineHint;
//  FIgnoreClick2 := false;
//  if (not (csDesigning in ComponentState)) and (not Focused) and CanFocus then
//    SetFocus;
//  FPressCoord := Point(X, Y);
//  FPressed := true;
//  Item := GetItemAt(X, Y, ItemPart, HCol);
//  if ItemPart <> ipOutside then
//  begin
//    if (ItemPart in [ipButton, ipPicture, ipPicture2]) or ((ItemPart = ipColumn) and IsControlCell(Item, HCol)) then
//      result := true
//    else
//    begin
//      TCustomElDBXTreeGrid(FOwner).MouseDownTransfer(Self, mbLeft, [], X, Y);
//    end;
//  end;
//end;

//procedure TElDBXTreeGridView.WMLButtonDown(var Message: TWMLButtonDown);
//begin
//  if IntLButtonDown(Message.XPos, Message.YPos, KeyDataToShiftState(Message.Keys)) then inherited;
//end;
//
procedure TElDBXTreeGridView.KeyDown(var Key: Word; Shift: TShiftState);
begin
 { if (Owner as TCustomElDBXTreeGrid).goTabs and (Key = VK_TAB) then
//     (not goRowSelect) and (ItemFocused <> nil) then
  begin
    if Shift = [] then
    begin
      Key := VK_RIGHT
    end
    else
      if Shift = [ssShift] then
        Key := VK_LEFT;
  end; }
  inherited;
end;

procedure TElDBXTreeGridView.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTCHARS;
  if (Owner as TCustomElDBXTreeGrid).goTabs then
    Message.Result := Message.Result or DLGC_WANTTAB;
end;

function TElDBXTreeStringGrid.GetCols(Index: Integer): TLMDStrings;
var i: integer;
  Item: TElXTreeItem;
  hs: integer;
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
      if Item.Cells.count <= hs then
        FCols.AddObject('', nil)
      else
        FCols.AddObject(Item.Cells[hs].Text, Item.Cells[hs].CellObject);
    end;
  end;
end;

//procedure TElDBXTreeStringGrid.SetCols(Index: Integer; Value: TLMDStrings);
//var i: integer;
//begin
//  IsUpdating := true;
//  try
//    while Index >= FHeader.Sections.Count do
//      FHeader.Sections.AddSection.Editable := goEditing;
//
//    Items.AllocateStorage(Value.Count);
//    while Value.Count > Integer(Items.Count) do
//      Items.AddLastItem(nil);
//    for i := 0 to Value.Count - 1 do
//    begin
//      Cells[Index, i] := Value[i];
//      Objects[Index, i] := Value.Objects[i];
//    end;
//  finally
//    IsUpdating := false;
//  end;
//end;

function TElDBXTreeStringGrid.GetRows(Index: Integer): TLMDStrings;
var i: integer;
  Item: TElXTreeItem;
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
      if Item.Cells.count <= i then
        FRows.AddObject('', nil)
      else
        FRows.AddObject(Item.Cells[i].Text, Item.Cells[i].CellObject);
    end
    else
      if i = MainTreeColumn then
        FRows.AddObject(Item.Text, Item.AnObject)
      else
      begin
        if Item.Cells.count <= i - 1 then
          FRows.AddObject('', nil)
        else
          FRows.AddObject(Item.Cells[i - 1].Text, Item.Cells[i - 1].CellObject);
      end;
  end;
end;

//procedure TElDBXTreeStringGrid.SetRows(Index: Integer; Value: TLMDStrings);
//var i: integer;
//begin
//  IsUpdating := true;
//  try
//    Items.AllocateStorage(Index + 1);
//    while Index >= Integer(Items.Count) do
//      Items.AddLastItem(nil);
//    while Value.Count >= FHeader.Sections.Count do
//      FHeader.Sections.AddSection;
//    for i := 0 to Value.Count - 1 do
//    begin
//      Cells[i, Index] := Value[i];
//      Objects[i, Index] := Value.Objects[i];
//    end;
//  finally
//    IsUpdating := false;
//  end;
//end;

constructor TElDBXTreeStringGrid.Create(Owner: TComponent);
begin
  inherited;
  FEditor := TElDBXTreeTrickyInplaceEdit.Create(Self);
  FEditor.Editor.OnKeyDown := EditorKeyDown;
  FSavedEditWndProc := FEditor.Editor.WindowProc;
  FEditor.Editor.WindowProc := EditWndProc;
end;

destructor TElDBXTreeStringGrid.Destroy;
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

procedure TElDBXTreeStringGrid.TriggerInplaceEditorNeeded(Item: TElXTreeItem;
  SectionIndex: Integer; SupposedFieldType: TElFieldType;
  var Editor: TElTreeInplaceEditor);
begin
  inherited;
  if UseDefaultEditor {or (Editor = nil) } then
    Editor := FEditor;
end;

procedure TElDBXTreeStringGrid.SetEditor(Value: TElDBXTreeWideStringEdit);
begin
  FEditor.Assign(Value);
end;

function TElDBXTreeStringGrid.GetCells(ACol, ARow: Integer): TLMDString;
begin
  if (ARow >= Integer(Items.Count)) or
    (Items[ARow].Cells.Count + 1 <= ACol) then
    Result := ''
  else
  begin
    if ACol = MainTreeColumn then
      Result := Items[ARow].Text
    else
      if ACol < MainTreeColumn then
        Result := Items[ARow].Cells[ACol].Text
      else
        Result := Items[ARow].Cells[ACol - 1].Text;
  end;
end;

procedure TElDBXTreeStringGrid.SetCells(ACol, ARow: Integer; Value: TLMDString);
var Item: TElXTreeItem;
  hs: integer;
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
      while Item.Cells.Count <= hs do
        Item.Cells.Add;
      Item.Cells[hs].Text := Value;
    end;
  finally
    IsUpdating := false;
  end;
end;

function TElDBXTreeStringGrid.GetObjects(ACol, ARow: Integer): TObject;
begin
  if (ARow >= Integer(Items.Count)) or
    (Items[ARow].Cells.Count + 1 <= ACol) then
    Result := nil
  else
  begin
    if ACol = MainTreeColumn then
      Result := Items[ARow].AnObject
    else
      if ACol < MainTreeColumn then
        Result := Items[ARow].Cells[ACol].CellObject
      else
        Result := Items[ARow].Cells[ACol - 1].CellObject;
  end;
end;

procedure TElDBXTreeStringGrid.SetObjects(ACol, ARow: Integer; Value: TObject);
var Item: TElXTreeItem;
  hs: integer;
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
      while Item.Cells.Count <= hs do
        Item.Cells.Add;
      Item.Cells[hs].CellObject := Value;
    end;
  finally
    IsUpdating := false;
  end;
end;

procedure TElDBXTreeStringGrid.KeyDownTransfer(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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

procedure TElDBXTreeStringGrid.OnFontChange(Sender: TObject);
begin
  inherited;
  Editor.Editor.Font.Assign(Font);
  end;

procedure TElDBXTreeStringGrid.EditorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = []) then
  begin
    case Key of
      VK_DOWN, VK_UP:
        begin
          Key := 0;
          EndEdit(not ExplorerEditMode);
          KeyDownTransfer(Self, Key, Shift);
        end;
      VK_RETURN:
        if not FgoAlwaysShowEditor then
        begin
          Key := 0;
          EndEdit(false);
        end;
      VK_RIGHT:
        if FEditor.Editor.SelStart >= Length(FEditor.Editor.Text) then
        begin
          Key := 0;
          EndEdit(not ExplorerEditMode);
          if (Col + 1) < ColCount then
            Col := Col + 1
          else
            if (Row + 1) < RowCount then
            begin
              Col := 0;
              Row := Row + 1;
            end;
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
        end;
      VK_TAB:
        begin
          Key := 0;
          EndEdit(not ExplorerEditMode);
          if (Col + 1) < ColCount then
            Col := Col + 1
          else
            if (Row + 1) < RowCount then
            begin
              Col := 0;
              Row := Row + 1;
            end;
        end;
    end;
  end;
  inherited;
end;

procedure TElDBXTreeStringGrid.EditWndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_GETDLGCODE: Message.Result := DLGC_WANTCHARS or DLGC_WANTTAB or DLGC_WANTARROWS or DLGC_WANTALLKEYS;
  end;
  if Message.Msg <> WM_GETDLGCODE then
    FSavedEditWndProc(Message)
end;

//procedure TCustomElDBXTreeGrid.SetSource(Source: TElXRelDataSource);
//begin
//  inherited;
//end;

function TCustomElDBXTreeGrid.GetNextTabSection(SectionIndex : integer; var
    ToNextItem : boolean): TElHeaderSection;
var CurIndex : integer;
    Section  : TElHeaderSection;
begin
  result := nil;
  ToNextItem := false;
  Section := FHeader.Sections[SectionIndex];
  CurIndex := Section.Position + 1;
  while CurIndex <> SectionIndex do
  begin
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
    end
    else
      ToNextItem := false;
    inc(CurIndex);
  end;
end;

function TCustomElDBXTreeGrid.GetPrevTabSection(SectionIndex : integer; var
    ToNextItem : boolean): TElHeaderSection;
var CurIndex : integer;
    Section  : TElHeaderSection;
begin
  result := nil;
  ToNextItem := false;
  Section := FHeader.Sections[SectionIndex];
  CurIndex := Section.Position - 1;
  while CurIndex <> SectionIndex do
  begin
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
    dec(CurIndex);
  end;
end;

procedure TCustomElDBXTreeGrid.RebuildTree(KeepCurrentID: Boolean);
var
  i : Integer;
begin
  for i := 0 to StylesDefs.Count-1 do
  begin
    while StylesDefs[i].DataFields.Count > (ColCount - 1) do
    begin
      StylesDefs[i].DataFields.Delete(StylesDefs[i].DataFields.Count-1);
    end;
    if (StylesDefs[i].DataFields.Count > 0) then
    begin
      while StylesDefs[i].DataFields.Count < ColCount - 1 do
      begin
        StylesDefs[i].DataFields.Add('empty column or defined by user');
      end;
    end;
  end;
  inherited;
end;

//procedure TNewCustomElDBTreeGrid.SetColCount(Value: Integer);
//var
//  i : Integer;
//  b : Boolean;
//begin
//  if Value < 1 then exit;
//  IsUpdating := true;
//  if Value <> FHeader.Sections.Count then
//    b := True
//  else
//    b := False;
//  try
//    if Value < FHeader.Sections.Count then
//      with FHeader.Sections do
//        while Count > Value do
//        begin
//          DeleteSection(Item[Count - 1]);
//          if (not (csLoading in Self.ComponentState)) and (not (csDesigning in Self.ComponentState)) then
//            for i := 0 to StylesDefs.Count-1 do
//            begin
//              if StylesDefs[i].DataFields.Count > Value - 1 then
//                StylesDefs[i].DataFields.Delete(StylesDefs[i].DataFields.Count-1);
//            end;
//        end;
//    if Value > FHeader.Sections.Count then
//    begin
//      with FHeader.Sections do
//        while Count < Value do
//        begin
//          AddSection.Editable := goEditing;
//          if (not (csLoading in Self.ComponentState)) and (not (csDesigning in Self.ComponentState)) then
//            for i := 0 to StylesDefs.Count-1 do
//            begin
//              if (StylesDefs[i].DataFields.Count > 0) then
//              begin
//                StylesDefs[i].DataFields.Add('empty column or defined by user');
////                StylesDefs[i].DataFields[StylesDefs[i].DataFields.Count-2] := 'empty column or defined by user';
//              end;
//            end;
//        end;
//    end;
//  finally
//    IsUpdating := false;
//    if b and (not (csLoading in Self.ComponentState)) and (not (csDesigning in Self.ComponentState)) then
//      Self.RebuildTree(true);
//  end;
//end;

{ TElDBXTreeGridColumns }

{ TElDBXTreeGridColumns }

function TElDBXTreeGridColumns.GetDataSetName: string;
var j : Integer;
begin
  Result := '';
  for j := 0 to Tree.StylesDefs.Count - 1 do
  begin
    if THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields.Count > 0 then
    begin
      Result := THackElXStylesDefsItem(Tree.StylesDefs[j]).DataSetName;
      break;
    end;
  end;
  if Result = '' then
    raise EOnUndefinedGridColumnsDataSet.Create(SNoColumnSetAssigned);
end;

procedure TElDBXTreeGridColumns.SetDataSetName(DatasetName: string);
var
  j, i : Integer;
  Pri : Boolean;
begin
  pri := False;
  for j := 0 to Tree.StylesDefs.Count - 1 do
  begin
    if THackElXStylesDefsItem(Tree.StylesDefs[j]).DataSetName = DatasetName then
      pri := True;
  end;
  if not pri then
  begin
    raise ENoValidDataSetName.CreateFmt(SNoValidDataSetName, [Datasetname]);
    // Abort;
  end;
  for j := 0 to Tree.StylesDefs.Count - 1 do
  begin
    if THackElXStylesDefsItem(Tree.StylesDefs[j]).DataSetName = DatasetName then
      begin
        Tree.StylesDefs[j].HasColumn := True;
        if THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields.Count > 0 then
        begin
          for i := 0 to THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields.Count - 1 do
          begin
            if THackElXStylesDefsItem(Tree.StylesDefs[j]).FDataLink.DataSet.DefaultFields then
              begin
                if not Assigned(THackElXStylesDefsItem(Tree.StylesDefs[j]).FDataLink.DataSet.FieldDefList.Find(THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields[i])) then
                  THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields[i] := 'empty column or defined by user';
              end
              else
              begin
                if not Assigned(THackElXStylesDefsItem(Tree.StylesDefs[j]).FDataLink.DataSet.FindField(THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields[i])) then
                  THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields[i] := 'empty column or defined by user';
              end;
            end;
        end;
        for i := THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields.Count to Tree.ColCount - 1 do
        begin
          THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields.Add('empty column or defined by user');
        end;
      end
    else
      begin
        Tree.StylesDefs[j].HasColumn := False;
        THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields.Clear;
      end;
  end;
  if {(not self.Tree.NoRebuildOnDataChange) and} (not (csLoading in Tree.ComponentState)) and (not (csDesigning in Tree.ComponentState)) then
    Tree.RebuildTree(true);
end;

function TElDBXTreeGridColumns.GetFieldNameByIndex(ColumnIndex: Integer): String;
var
  j : Integer;
begin
  Result := '';
  if ColumnIndex < 0 then
  begin
    raise EIncorrectColumnIndex.Create(SIncorrectColumnIndex);
    // Abort;
  end;
  for j := 0 to Tree.StylesDefs.Count - 1 do
  begin
    if (Tree.StylesDefs[j].HasColumn) or (THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields.Count > 0) then
      if THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields.Count > ColumnIndex then
      begin
        Result := THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields[ColumnIndex];
        break;
      end
      else
      begin
        raise EIncorrectColumnIndex.Create(SIncorrectColumnIndex);
        // Abort;
      end;
  end;
end;

procedure TElDBXTreeGridColumns.Insert(FieldName: string;HeaderTitle: TLMDString;
  ColumnIndex: Integer);
var
  s, s1, h, h1: string;
  j, i : Integer;
  pri : Boolean;
begin
  if ColumnIndex < 0 then
  begin
    raise EIncorrectColumnIndex.Create(SIncorrectColumnIndex);
    // Abort;
  end;
  pri := False;
  for j := 0 to Tree.StylesDefs.Count - 1 do
  begin
    if (Tree.StylesDefs[j].HasColumn) or (THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields.Count > 0) then
    begin
    if THackElXStylesDefsItem(Tree.StylesDefs[j]).FDataLink.DataSet.DefaultFields then
      begin
        if Assigned(THackElXStylesDefsItem(Tree.StylesDefs[j]).FDataLink.DataSet.FieldDefList.Find(FieldName)) then
          pri := True;
      end
      else
      begin
        if Assigned(THackElXStylesDefsItem(Tree.StylesDefs[j]).FDataLink.DataSet.FindField(FieldName)) then
          pri := True;
      end;
    if THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields.Count < ColumnIndex then
      begin
        raise EIncorrectColumnIndex.Create(SIncorrectColumnIndex);
        // Abort;
      end;
      break;
    end;
  end;
  if FieldName = 'empty column or defined by user' then
    pri := True;
  if not pri then
  begin
    raise EIncorrectFieldName.CreateFmt(SIncorrectFieldName, [FieldName]);
    // Abort;
  end;
  Tree.IsUpdating := True;
  Tree.ColCount := Tree.ColCount + 1;
  Tree.IsUpdating := False;
  for j := 0 to Tree.StylesDefs.Count - 1 do
  begin
    if (Tree.StylesDefs[j].HasColumn) or (THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields.Count > 0) then
      if THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields.Count > ColumnIndex then
      begin
        s1 := FieldName;
        for i := ColumnIndex to THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields.Count - 1 do
        begin
          s := THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields[i];
          THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields[i] := s1;
          s1 := s;
        end;
      end
      else
      begin
        raise EIncorrectColumnIndex.Create(SIncorrectColumnIndex);
        // Abort;
      end;
  end;
  h1 := HeaderTitle;
  for i := ColumnIndex to tree.HeaderSections.Count - 1 do
  begin
    h := Tree.Header.Sections[i].Cell[0].Text;
    Tree.Header.Sections[i].Cell[0].Text := h1;
    h1 := h;
  end;
  if {(not Tree.NoRebuildOnDataChange) and} (not (csLoading in Tree.ComponentState)) and (not (csDesigning in Tree.ComponentState)) then
    Tree.RebuildTree(true);
end;

procedure TElDBXTreeGridColumns.SetFieldNameByIndex(
  ColumnIndex: Integer; FieldName: string);
var
  j : Integer;
  pri : Boolean;
  h1 : string;
begin
  if ColumnIndex < 0 then
  begin
    raise EIncorrectColumnIndex.Create(SIncorrectColumnIndex);
    // Abort;
  end;
  pri := False;
  h1 := '';
  for j := 0 to Tree.StylesDefs.Count - 1 do
  begin
    if (Tree.StylesDefs[j].HasColumn) or (THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields.Count > 0) then
    begin
    if THackElXStylesDefsItem(Tree.StylesDefs[j]).FDataLink.DataSet.DefaultFields then
      begin
        if Assigned(THackElXStylesDefsItem(Tree.StylesDefs[j]).FDataLink.DataSet.FieldDefList.Find(FieldName)) then
        begin
          pri := True;
          h1 := THackElXStylesDefsItem(Tree.StylesDefs[j]).FDataLink.DataSet.FieldDefList.Find(FieldName).DisplayName;
        end;
      end
      else
      begin
        if Assigned(THackElXStylesDefsItem(Tree.StylesDefs[j]).FDataLink.DataSet.FindField(FieldName)) then
        begin
          pri := True;
          h1 := THackElXStylesDefsItem(Tree.StylesDefs[j]).FDataLink.DataSet.FindField(FieldName).DisplayLabel;
        end;
      end;
    break;
    end;
  end;
  if FieldName = 'empty column or defined by user' then
    pri := True;
  if not pri then
  begin
    raise EIncorrectFieldName.CreateFmt(SIncorrectFieldName, [FieldName]);
    // Abort;
  end;
  for j := 0 to Tree.StylesDefs.Count - 1 do
  begin
    if (Tree.StylesDefs[j].HasColumn) or (THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields.Count > 0) then
      if THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields.Count > ColumnIndex then
      begin
        THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields[ColumnIndex] := FieldName;
      end
      else
      begin
        EIncorrectColumnIndex.Create(SIncorrectColumnIndex);
        // Abort;
      end;
  end;
  Tree.Header.Sections[ColumnIndex+1].Cell[0].Text := h1;
  if {(not Tree.NoRebuildOnDataChange) and} (not (csLoading in Tree.ComponentState)) and (not (csDesigning in Tree.ComponentState)) then
    Tree.RebuildTree(true);
end;

procedure TElDBXTreeGridColumns.Add(FieldName: string; HeaderTitle: TLMDString);
begin
  Insert(FieldName,HeaderTitle,Tree.ColCount - 1);
end;

procedure TElDBXTreeGridColumns.Delete(ColumnIndex: Integer);
var
  j, i : Integer;
begin
  if ColumnIndex < 0 then
  begin
    raise EIncorrectColumnIndex.Create(SIncorrectColumnIndex);
    // Abort;
  end;
  for j := 0 to Tree.StylesDefs.Count - 1 do
  begin
    if (Tree.StylesDefs[j].HasColumn) or (THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields.Count > 0) then
      if THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields.Count - 1 < ColumnIndex then
      begin
        raise EIncorrectColumnIndex.Create(SIncorrectColumnIndex);
        // Abort;
      end
      else
      begin
        for i := ColumnIndex to THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields.Count - 2 do
        begin
          THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields[i] := THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields[i + 1];
        end;
      end;
  end;
  Tree.ColCount := Tree.ColCount - 1;
end;

procedure TElDBXTreeGridColumns.AddAllFields;
var
  j, i : Integer;
//  pri : Boolean;
begin
  // pri := False;
  for j := 0 to Tree.StylesDefs.Count - 1 do
  begin
    if (Tree.StylesDefs[j].HasColumn) or (THackElXStylesDefsItem(Tree.StylesDefs[j]).DataFields.Count > 0) then
    begin
      if (THackElXStylesDefsItem(Tree.StylesDefs[j]).FDataLink.DataSet <> nil) then
      begin
        for i := 0 to THackElXStylesDefsItem(Tree.StylesDefs[j]).FDataLink.DataSet.FieldCount-1 do
          Add(THackElXStylesDefsItem(Tree.StylesDefs[j]).FDataLink.DataSet.Fields[i].FieldName,THackElXStylesDefsItem(Tree.StylesDefs[j]).FDataLink.DataSet.Fields[i].DisplayLabel);
        //pri := True;
        break;
      end;
    end;
  end;
end;

end.
