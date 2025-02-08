unit LMDDBGrid;
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

LMDDBGrid unit (VT)
-------------------
Unit contains main code of LMD DB Grid.

Changes
-------
Release 1.0 (July 2009)
 - Initial Release
 - Code formatting (YB, FEB 2011)

###############################################################################}

interface

uses
  Windows, Controls, ExtCtrls, Grids, LMDTypes, Contnrs, Forms, Messages,
  Classes, Graphics, StdCtrls, SysUtils, ComCtrls, DB, Menus, LMDStrings,
  intfLMDBase, LMDThemes, LMDClass, LMDGrid;

type
  TLMDCustomDBGrid = class;

  //== TGridDataLink ===========================================================

  TGridDataLink = class(TDataLink)
  private
    FGrid:        TLMDCustomDBGrid;
    FOldFieldCnt: Integer;

    procedure ResetOldFieldCnt;
    function  FieldCnt: Integer;
  protected
    procedure DataEvent(Event: TDataEvent; Info: {$ifdef LMDCOMP16}NativeInt{$else}Longint{$endif}); override;
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
    procedure FocusControl(Field: TFieldRef); override;
    procedure EditingChanged; override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
    procedure UpdateData; override;
    procedure CheckBrowseMode; override;
  public
    constructor Create(AGrid: TLMDCustomDBGrid);
  end;

  //== TLMDGridLookupChooser ===================================================

  TLMDGridLookupChooser = class(TLMDGridColumnChooser)
  private
    FDBGrid:        TLMDCustomDBGrid;
    FDefWidth:      Integer;
    FItemHeight:    Integer;
    FDropDownCount: Integer;
    FLookupSource:  TDataSource;
    FKey, FValue:   Variant;

    function  CreateDBGrid(AParent: TWinControl): TLMDCustomDBGrid;
    procedure SetItemHeight(const Value: Integer);
    procedure PaintFormattedCellData(ACanvas: TCanvas; ARect: TRect;
                                     const AData: Variant; AAlignment: TAlignment;
                                     ACellState: TLMDGridCellStates);
    procedure SetDropDownCount(const Value: Integer);
    function  CalkHeight: Integer;
  protected
    function  GetData(var AKey: Variant; var AValue: Variant): Boolean; override;
    procedure SetData(const AKey: Variant; const AValue: Variant); override;
    procedure SetFocus; override;
    function  GetLayout: TLMDGridChooserLayout; override;
    function  GetChooserKind: TLMDGridChooserKind; override;
    procedure SetBounds(ARect: TRect); override;
    function  GetControlSize: TSize; override;
    procedure SetControlParent(AParent: TWinControl); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ItemHeight: Integer read FItemHeight write SetItemHeight default 18;
    property DropDownCount: Integer read FDropDownCount write SetDropDownCount default 7;
  end;

  //== TLMDCustomDBGrid ========================================================

  TLMDDataSetSortEvent = procedure(Sender: TObject; AColumn: TLMDGridColumn;
                                   ASortKind: TLMDGridSortKind;
                                   ADataSet: TDataSet) of object;

  TLMDCustomDBGrid = class(TLMDCustomGrid)
  private
    FLink:                  TGridDataLink;
    FAutoColumnsMode:       Boolean;
    FDoRemoveDefPropsMode:  Boolean;
    FColFields:             array of TField;
    FColFieldsKey:          array of TField;
    FColFieldsCompat:       array of Boolean;
    FSelAncBmk:             TBookmark;
    FSelAnc:                TPoint;
    FGridSortEvent:         TLMDDataSetSortEvent;

    procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
    function  GetDataSource: TDataSource;
    procedure SetDataSource(const Value: TDataSource);
    function  GetFields(ActiveDSOnly: Boolean = True): TFields;
    function  ColByField(AField: string): TLMDGridColumn; overload;
    function  ColByField(AField: TField): TLMDGridColumn; overload;
    function  FieldByCol(AColumn: TLMDGridColumn): TField;
    procedure MoveColField(AFrom, ATo: Integer);
    function  GetAveTextWidth(const AText: TLMDString; AMaxTextLn: Integer;
                              AFont: TFont): Integer;
    function  GetTextLnByWidth(AWidth: Integer; AFont: TFont): Integer;
    procedure ReadAutoColumns(Reader: TReader);
    procedure WriteAutoColumns(Writer: TWriter);
    function  IsColumnFieldCompatible(ACol: TLMDGridColumn; ABySettings: Boolean;
                                      AField: TField; AErrMessage: PLMDString): Boolean;
    procedure DataSetChanged;
    procedure CheckBrowseMode;
    procedure UpdateScrollBar;
    procedure UpdateLinkConfig;
    function  IsSequenced: Boolean;
    procedure UpdateData;
    procedure RecordChanged(Field: TField);
    procedure FocusControl(Field: TFieldRef);
  protected
    // TCustomGrid hacks

    procedure TopLeftChanged; override;

    // Utilites

    function FieldWidthToColWidth(AColumn: TLMDGridColumn; AWidth: Integer): Integer;
    function ColWidthToFieldWidth(AColumn: TLMDGridColumn; AWidth: Integer): Integer;

    // DB-related

    procedure ActiveChanged;
    procedure CheckUnidirectional(ADataSource: TDataSource);
    procedure RefreshColumns; overload;
    procedure RefreshColumns(AutoCreateComponents: Boolean;
                             ANameSetProc: TLMDGridColumnNameSetCallback); overload;

    // VCL parent overrides

    procedure DefineProperties(Filer: TFiler); override;
    procedure GetAvailableColumnFieldNames(ACol: TLMDGridColumn;
                                           AList: TStrings); override;
    function  IsEOF: Boolean; override;
    procedure MoveDataRow(AFrom, ATo: Integer); override;
    procedure ColumnAdding(AColumn: TLMDGridColumn); override;
    procedure ColumnAdded(AColumn: TLMDGridColumn); override;
    procedure ColumnDeleting(AColumn: TLMDGridColumn); override;
    procedure ColumnMoving(AFrom, ATo: Integer); override;
    procedure InternalColumnDataTypeChanged(ACol: TLMDGridColumn); override;
    procedure InternalDataLayoutChange; override;
    procedure InternalDataSourceSort(AColumn: TLMDGridColumn;
                                     Value: TLMDGridSortKind;
                                     var ACorrectIdx: Integer); override;
    procedure InternalDeleteDataRow(ARow: Integer; var CorrIndex: Integer); override;
    procedure InternalSetColumnFieldName(AColumn: TLMDGridColumn;
                                         const AValue: string;
                                         ABefore: Boolean); override;
    procedure InternalSetColumnGrid(AColumn: TLMDGridColumn); override;
    function  InternalIsColumnDataBound(ACol: Integer): Boolean; override;
    procedure InternalSetDefaultColWidth(AColumn: TLMDGridColumn); override;
    procedure InternalSetDefaultColPos(AColumn: TLMDGridColumn); override;
    procedure InternalSetupScrollBarsStyle; override;
    function  CanStoreMoveRow: Boolean; override;
    function  CanStoreMoveCol: Boolean; override;
    function  CanStoreEdit: Boolean; override;
    function  CanStoreInsert: Boolean; override;
    function  CanStoreRemove: Boolean; override;
    function  CanStoreRowEdit: Boolean; override;
    function  GetDataRowCount: Integer; override;
    procedure SetDataRowCount(const Value: Integer); override;
    procedure InternalGetDataCell(ACol, ARow: Integer; Key, Value: PVariant); override;
    procedure InternalSetDataCell(ACol, ARow: Integer; Key, Value: PVariant;
                                  ABlockSort: Boolean; out NewRow: Integer); override;
    procedure InternalEnterNewRecMode(ADestIndex: Integer); override;
    procedure InternalExitNewRecMode(ACommit: Boolean; out ACurrentIndex: Integer); override;
    procedure InternalEnterRowEditMode; override;
    procedure InternalExitRowEditMode(ACommit: Boolean; out ACurrentIndex: Integer); override;
    procedure InternalAfterSyncGridStore; override;
    procedure InternalUpdateStore; override;
    function  InternalDataSourceCanSort: Boolean; override;
    procedure InternalRestrictDataPoint(var ACol: Integer; var ARow: Integer); override;
    function  InternalMoveVert(ANewCurrent, ANewTop: Integer): Boolean; override;
    procedure InternalEndUpdateLow; override;

    // Auto columns mode

    function  GetAutoColumnsMode: Boolean; override;
    procedure SetAutoColumnsMode(AMode: Boolean); override;
    function  CanFillColumnsFromStore: Boolean; override;
    procedure FillColumnsFromStore(ANameSetProc: TLMDGridColumnNameSetCallback); override;

    // Selection related

    function  GetSelRect: TRect; override;
    function  IsSelectionValid: Boolean; override;
    procedure CancelSelectionLow; override;
    procedure CancelSelAncLow;

    //Default values

    function  GetColumnField(AColumn: TLMDGridColumn): TField; override;
    function  GetColumnFieldKey(AColumn: TLMDGridColumn): TField; override;
    function  GetDefaultColumnCaption(AColumn: TLMDGridColumn): TLMDString; override;
    function  GetDefaultColumnAlignment(AColumn: TLMDGridColumn): TAlignment; override;
    function  GetDefaultColumnVisible(AColumn: TLMDGridColumn): Boolean; override;
    function  GetDefaultColumnReadOnly(AColumn: TLMDGridColumn): Boolean; override;
    function  GetDefaultColumnWidth(AColumn: TLMDGridColumn): Integer; override;
    procedure PageSizeChanged; override;

    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property OnDataSetSort: TLMDDataSetSortEvent read FGridSortEvent write FGridSortEvent;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function UpdateAction(Action: TBasicAction): Boolean; override;
  end;

  //== TLMDDBGrid ==============================================================

  TLMDDBGrid = class(TLMDCustomDBGrid)
  published
    property DataSource;
    property Columns;
    property Style;
    property DefaultColWidth;
    property DefaultRowHeight;
    property ScrollBarsStyle;
    property ThemeMode;
    property ThemeGlobalMode;
    property Options;
    property OnBeforeRowDelete;
    property OnPaintEmptyBanner;
    property OnGetCellColor;
    property OnDrawDataCell;
    property OnDrawHeaderCell;
    property OnDrawIndicator;
    property OnDataSetSort;
    property Align;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
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
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
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
    {$IFDEF LMDCOMP10}
    property OnMouseEnter;
    property OnMouseLeave;
	{$ENDIF}
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    {$IFDEF LMDCOMP14}
    property OnGesture;
    property Touch;
    {$ENDIF}	
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}   	
  end;

implementation

uses
  Math, Variants, LMDGridConst, LMDProcs;

type
  TColumnAccess = class(TLMDGridColumn);
  TGridAccess   = class(TLMDCustomGrid);

  TProxyColumn = class(TLMDGridColumn)
  protected
    function  GetEmbeddedEditor: ILMDGridEmbeddedEdit; override;
    procedure ResetEmbeddedEditor; override;
    procedure PaintFormattedCellData(ACanvas: TCanvas; ARect: TRect;
                                     const AData: Variant; AAlignment: TAlignment;
                                     ACellState: TLMDGridCellStates); override;
    function  CompareColValues(Val1: PVariant; Val2: PVariant): Integer; override;
    function  IsSortingAllowed: Boolean; override;
    function  GetColumnCompatDataTypes: TLMDGridFieldTypes; override;
  end;

  TPopupDBGrid = class(TLMDDBGrid)
  private
    FGrid:    TLMDGridEditParentHelper;
    FChooser: TLMDGridLookupChooser;

    procedure WMActivate(var Message: TWMActivate); message WM_Activate;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
  protected
    constructor Create(AOwner: TComponent; AGrid: TLMDGridEditParentHelper;
                       AChooser: TLMDGridLookupChooser); reintroduce;

    function  UseAlternate: Boolean; override;
    function  GetStyle: TLMDGridStyle; override;
    procedure Beep; override;
    procedure Resize; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  end;

//== TGridDataLink =============================================================

procedure TGridDataLink.ActiveChanged;
begin
  ResetOldFieldCnt;
  FGrid.ActiveChanged;
end;

procedure TGridDataLink.CheckBrowseMode;
begin
  FGrid.CheckBrowseMode;
end;

constructor TGridDataLink.Create(AGrid: TLMDCustomDBGrid);
begin
  Assert(AGrid <> nil);

  FOldFieldCnt := 0;
  FGrid := AGrid;
  VisualControl := True;
end;

procedure TGridDataLink.DataEvent(Event: TDataEvent; Info: {$ifdef LMDCOMP16}NativeInt{$else}Longint{$endif});
begin
  inherited;

  if Event = deFieldListChange then
    LayoutChanged;
end;

procedure TGridDataLink.DataSetChanged;
begin
  if FieldCnt = FOldFieldCnt then
    FGrid.DataSetChanged
  else
    LayoutChanged;
end;

procedure TGridDataLink.DataSetScrolled(Distance: Integer);
begin
  DataSetChanged;

  if Distance <> 0 then
    FGrid.IncludeChange(cfCurrent);
end;

procedure TGridDataLink.EditingChanged;
begin
  DataSetChanged;
end;

function TGridDataLink.FieldCnt: Integer;
begin
  if (DataSet = nil) or (DataSet.Fields = nil) then
    Result := 0
  else
    Result := DataSet.Fields.Count;
end;

procedure TGridDataLink.FocusControl(Field: TFieldRef);
begin
  FGrid.FocusControl(Field);
end;

procedure TGridDataLink.LayoutChanged;
begin
  ResetOldFieldCnt;
  FGrid.InternalDataLayoutChange;
end;

procedure TGridDataLink.RecordChanged(Field: TField);
begin
  FGrid.RecordChanged(Field);
end;

procedure TGridDataLink.ResetOldFieldCnt;
begin
  FOldFieldCnt := FieldCnt;
end;

procedure TGridDataLink.UpdateData;
begin
  FGrid.UpdateData;
end;

//== TLMDCustomDBGrid ==========================================================

function TLMDCustomDBGrid.CanFillColumnsFromStore: Boolean;
begin
  Result := True;
end;

function TLMDCustomDBGrid.CanStoreMoveCol: Boolean;
begin
  Result := True;
end;

function TLMDCustomDBGrid.CanStoreMoveRow: Boolean;
begin
  Result := False;
end;

procedure TLMDCustomDBGrid.CheckUnidirectional(ADataSource: TDataSource);
begin
  if Assigned(ADataSource) and
     Assigned(ADataSource.DataSet) and
     ADataSource.DataSet.IsUnidirectional
  then
    raise ELMDGridError.Create(SLMDGridDataSetUnidirectional);
end;

function TLMDCustomDBGrid.ColByField(AField: string): TLMDGridColumn;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Columns.Count - 1 do
    if Columns[i].FieldName = AField then
    begin
      Result := Columns[i];
      Exit;
    end;
end;

procedure TLMDCustomDBGrid.ColumnAdded(AColumn: TLMDGridColumn);
begin
  inherited;

  if AColumn.Visible and (AColumn.Position <= FSelAnc.X) then
    Inc(FSelAnc.X);
end;

procedure TLMDCustomDBGrid.ColumnAdding(AColumn: TLMDGridColumn);
var
  l: Integer;
begin
  l := Length(FColFields);
  SetLength(FColFields, l + 1);
  SetLength(FColFieldsKey, l + 1);

  FColFields[l] := nil;
  FColFieldsKey[l] := nil;

  if not InInitMode then
    FAutoColumnsMode := False;

  inherited;
end;

procedure TLMDCustomDBGrid.ColumnDeleting(AColumn: TLMDGridColumn);
var
  l:    Integer;
  colI: Integer;
begin
  l := Length(FColFields);
  MoveColField(AColumn.Position, l - 1);
  SetLength(FColFields, l - 1);
  SetLength(FColFieldsKey, l - 1);

  if not InInitMode then
    FAutoColumnsMode := False;

  if AColumn.Visible then
  begin
    colI := AColumn.Position;
    if colI = FSelAnc.X then
    begin
      if colI = Columns.Count - 1 then
        Dec(FSelAnc.X);
    end
    else if colI < FSelAnc.X then
      Dec(FSelAnc.X);
  end;
end;

procedure TLMDCustomDBGrid.ColumnMoving(AFrom, ATo: Integer);
var
  col: TLMDGridColumn;
begin
  MoveColField(AFrom, ATo);

  col := Columns[AFrom];
  if col.Visible then
  begin
    if AFrom = FSelAnc.X then
      FSelAnc.X := ATo
    else if (AFrom > FSelAnc.X) and (ATo <= FSelAnc.X) then
      Inc(FSelAnc.X)
    else if (AFrom < FSelAnc.X) and (ATo > FSelAnc.X) then
      Dec(FSelAnc.X);
  end;
end;

function TLMDCustomDBGrid.ColWidthToFieldWidth(AColumn: TLMDGridColumn;
  AWidth: Integer): Integer;
begin
  Result := GetTextLnByWidth(AWidth, AColumn.Font);
end;

constructor TLMDCustomDBGrid.Create(AOwner: TComponent);
begin
  FDoRemoveDefPropsMode := False;
  FAutoColumnsMode := True;

  FLink := TGridDataLink.Create(self);

  inherited;

  CancelSelectionLow;
  ScrollBars := ssHorizontal;
end;

procedure TLMDCustomDBGrid.InternalDataLayoutChange;
begin
  BeginUpdateLow(False, True);
  try
    RefreshColumns;
  finally
    EndUpdateLow;
  end;
end;

procedure TLMDCustomDBGrid.MoveColField(AFrom, ATo: Integer);
var
  i: Integer;
  x: TField;
begin
  x := FColFields[AFrom];

  if AFrom < ATo then
    for i := AFrom to ATo - 1 do
      FColFields[i] := FColFields[i + 1]
  else
    for i := AFrom downto ATo + 1 do
      FColFields[i] := FColFields[i - 1];

  FColFields[ATo] := x;

  ///
  x := FColFieldsKey[AFrom];

  if AFrom < ATo then
    for i := AFrom to ATo - 1 do
      FColFieldsKey[i] := FColFieldsKey[i + 1]
  else
    for i := AFrom downto ATo + 1 do
      FColFieldsKey[i] := FColFieldsKey[i - 1];

  FColFieldsKey[ATo] := x;
end;

procedure TLMDCustomDBGrid.DataSetChanged;
var
  oldRowCount:         Integer;
  state:               TDataSetState;
  oldRec:              Integer;
  cmp, dir, r, rs, re: Integer;
  bmk:                 TBookmark;
begin
  ////Update row count
  oldRowCount := inherited RowCount;

  if FLink.Active then
  begin
    inherited RowCount := 1000;
    FLink.BufferCount := PageHeight;
  end;

  SyncGridStore;

  if oldRowCount <> inherited RowCount then
    IncludeState(isNeedFullRepaint);

  ///Update active record and selection
  if (DataRowCount > 0) and HaveVisibleData then
    inherited Row := DataRowToGridRow(FLink.ActiveRecord);

  if not InInternal then
  begin
    CancelSelection;
    InvalidateSelRect;
  end;

  ///Update state
  state := dsInactive;

  if FLink.Active then
    state := FLink.DataSet.state;

  if not InInternal then
  begin
    BeginInternal;
    try
      if (state <> dsInsert) and IsNewRecMode then
        ExitNewRecMode(False)
      else if (state = dsInsert) and (not IsNewRecMode) then
        InitNewRecMode(False);

      if (state <> dsEdit) and IsRowEditMode then
        ExitRowEditMode(False)
      else if (state = dsEdit) and (not IsRowEditMode) then
        InitRowEditMode;
    finally
      EndInternal;
    end;
  end;

  UpdateScrollBar;

  if IsSelectionValid then
  begin
    oldRec := FLink.ActiveRecord;
    bmk := FLink.DataSet.GetBookmark;
    try
      cmp := FLink.DataSet.CompareBookmarks(FSelAncBmk, bmk);
      FLink.DataSet.FreeBookmark(bmk);

      if cmp <> 0 then
      begin
        dir := cmp div Abs(cmp);

        r := CurrentRow;
        rs := TopDataRow;
        re := rs + PageHeight - 1;
        while ((r + dir) >= rs) and ((r + dir) <= re) do
        begin
          Inc(r, dir);

          FLink.ActiveRecord := r;
          bmk := FLink.DataSet.GetBookmark;
          cmp := FLink.DataSet.CompareBookmarks(FSelAncBmk, bmk);
          FLink.DataSet.FreeBookmark(bmk);

          if (cmp = 0) then
            Break
          else if Sign(cmp) <> Sign(dir) then
          begin
            Dec(r, dir);
            Break;
          end;
        end;
        FSelAnc.Y := r;
      end
      else
        CancelSelAncLow;
    finally
      FLink.ActiveRecord := oldRec;
    end;
  end
  else
    CancelSelAncLow;
end;

procedure TLMDCustomDBGrid.DefineProperties(Filer: TFiler);
var
  grid:   TLMDCustomDBGrid;
  doSave: Boolean;
begin
  inherited;

  if Filer.Ancestor <> nil then
  begin
    grid := Filer.Ancestor as TLMDCustomDBGrid;

    doSave := FAutoColumnsMode <> grid.FAutoColumnsMode;
  end
  else
    doSave := not FAutoColumnsMode;

  Filer.DefineProperty('AutoColumnsMode', ReadAutoColumns,
                       WriteAutoColumns,
                       doSave);
end;

destructor TLMDCustomDBGrid.Destroy;
begin
  IncludeState(isDestroing);
  inherited;
  FreeAndNil(FLink);
end;

function TLMDCustomDBGrid.FieldByCol(AColumn: TLMDGridColumn): TField;
begin
  Assert(AColumn <> nil);
  if (AColumn.FieldName <> '') and (GetFields <> nil) then
    Result := GetFields.FindField(AColumn.FieldName)
  else
    Result := nil;
end;

function TLMDCustomDBGrid.FieldWidthToColWidth(AColumn: TLMDGridColumn;
  AWidth: Integer): Integer;
var
  font: TFont;
  text: TLMDString;
begin
  if opShowHeader in Options then
  begin
    text := AColumn.Title.Caption;
    font := AColumn.Title.font;
  end
  else
  begin
    text := '';
    font := AColumn.font;
  end;

  Result := GetAveTextWidth(text, AWidth, font);
end;

procedure TLMDCustomDBGrid.FillColumnsFromStore(
  ANameSetProc: TLMDGridColumnNameSetCallback);
begin
  BeginUpdateLow(False, True);
  try
    FAutoColumnsMode := False;
    RefreshColumns(True, ANameSetProc);
  finally
    EndUpdateLow;
  end;
end;

function TLMDCustomDBGrid.GetFields(ActiveDSOnly: Boolean): TFields;
begin
  if (FLink.DataSet <> nil) and (FLink.DataSet.Active or
                                 not ActiveDSOnly) then
    Result := FLink.DataSet.Fields
  else
    Result := nil;
end;

function TLMDCustomDBGrid.GetTextLnByWidth(AWidth: Integer;
  AFont: TFont): Integer;
var
  restoreCanvas: Boolean;
  tempDc:        HDC;
  tm:            TTextMetric;
  w:             Integer;
begin
  restoreCanvas := not HandleAllocated;
  if restoreCanvas then
    Canvas.Handle := GetDC(0);

  try
    Canvas.Font := AFont;
    GetTextMetrics(Canvas.Handle, tm);

    w := Canvas.TextWidth('0');
    Result := (AWidth - tm.tmOverhang) div (w - tm.tmOverhang);
  finally
    if restoreCanvas then
    begin
      tempDc := Canvas.Handle;
      Canvas.Handle := 0;
      ReleaseDC(0, tempDc);
    end;
  end;
end;

procedure TLMDCustomDBGrid.InternalAfterSyncGridStore;
var
  i: Integer;
begin
  UpdateLinkConfig;

  for i := 0 to Columns.Count - 1 do
    TColumnAccess(Columns[i]).CheckInitPropsForField;

  UpdateScrollBar;
end;

procedure TLMDCustomDBGrid.InternalColumnDataTypeChanged(ACol: TLMDGridColumn);
begin
  InternalDataLayoutChange;
end;

function TLMDCustomDBGrid.InternalDataSourceCanSort: Boolean;
begin
  Result := True;
end;

procedure TLMDCustomDBGrid.InternalDataSourceSort(AColumn: TLMDGridColumn;
  Value: TLMDGridSortKind; var ACorrectIdx: Integer);
const
  Types = [ftString, ftSmallint, ftInteger, ftWord, ftBoolean, ftFloat,
           ftCurrency, ftBCD, ftDate, ftTime, ftDateTime, ftAutoInc,
           ftFixedChar, ftWideString, ftLargeint, ftVariant, ftGuid,
           ftTimeStamp, ftFMTBcd];
var
  keys:      string;
  keyValues: array of Variant;
  fields:    TFields;
  f:         TField;
  l, i:      Integer;
begin
  Assert(ACOlumn <> nil);
  keys := '';

  if not IsSortingAllowed(AColumn) then
    Exit;

  if (FLink.DataSet <> nil) and Assigned(FGridSortEvent) then
  begin
    fields := GetFields;
    for i := 0 to fields.Count - 1 do
    begin
      f := fields[i];
      if (f.FieldKind = fkData) and (f.DataType in Types) then
      begin
        if keys <> '' then
          keys := keys + ';';

        keys := keys + f.FieldName;
        l := Length(keyValues);
        SetLength(keyValues, l + 1);
        keyValues[l] := f.Value;
      end;
    end;

    FGridSortEvent(self, AColumn, Value, FLink.DataSet);
    FLink.DataSet.Locate(keys, keyValues, [loCaseInsensitive, loPartialKey]);

    ACorrectIdx := CurrentRow;
  end;
end;

procedure TLMDCustomDBGrid.InternalDeleteDataRow(ARow: Integer;
  var CorrIndex: Integer);
begin
  Assert(ARow = CurrentRow);
  try
    Assert(FLink.DataSet.State = dsBrowse);
    FLink.DataSet.Delete;
  finally
    CorrIndex := CurrentRow;
  end;
end;

function TLMDCustomDBGrid.InternalIsColumnDataBound(ACol: Integer): Boolean;
begin
  CheckColumnIdx(ACol);
  Result := (FColFields[ACol] <> nil) and
            FColFieldsCompat[ACol];
end;

procedure TLMDCustomDBGrid.InternalSetColumnFieldName(AColumn: TLMDGridColumn;
  const AValue: string; ABefore: Boolean);
var
  fields: TFields;
  field:  TField;
  msg:    TLMDString;
begin
  if ABefore then
  begin
    if not ((csReading in ComponentState) or InInitMode) then
    begin
      fields := GetFields;
      if (AColumn.Grid = self) and (fields <> nil) and
         (fields.Count > 0)    and (AValue <> '')
      then
      begin
        field := fields.FindField(AValue);
        if field = nil then
          raise ELMDGridError.CreateFmt(SLMDGridBadFieldName, [AValue]);

        if not IsColumnFieldCompatible(AColumn, True, field, @msg) then
          raise ELMDGridError.Create(msg);
      end;
    end;
  end
  else if not InInitMode then
    RefreshColumns;
end;

procedure TLMDCustomDBGrid.InternalSetColumnGrid(AColumn: TLMDGridColumn);
begin
  if not InInitMode then
    RefreshColumns;
end;

procedure TLMDCustomDBGrid.InternalSetDataCell(ACol, ARow: Integer;
  Key, Value: PVariant; ABlockSort: Boolean; out NewRow: Integer);
var
  f, fl: TField;
begin
  Assert(FLink.Active);
  Assert(ARow = CurrentRow);

  NewRow := CurrentRow;
  f := FColFields[ACol];
  fl := FColFieldsKey[ACol];
  if f <> nil then
  begin
    if f.FieldKind = fkLookup then
    begin
      if fl <> nil then
        fl.Value := Key^;
    end
    else
      FColFields[ACol].Value := Value^;
  end;
end;

procedure TLMDCustomDBGrid.InternalSetDefaultColPos(AColumn: TLMDGridColumn);
var
  field:  TField;
  fields: TFields;
begin
  if FAutoColumnsMode then
  begin
    field := FieldByCol(AColumn);
    fields := GetFields;
    if fields <> nil then
    begin
      BeginInternal;
      try
        field.Index := AColumn.Position;
      finally
        EndInternal;
      end;
    end;
  end;
end;

procedure TLMDCustomDBGrid.InternalSetDefaultColWidth(AColumn: TLMDGridColumn);
var
  field: TField;
begin
  if FAutoColumnsMode then
  begin
    field := FieldByCol(AColumn);

    BeginInternal;
    try
      field.DisplayWidth := ColWidthToFieldWidth(AColumn, AColumn.Width);
      TColumnAccess(AColumn).RemoveSetting(csWidth);
    finally
      EndInternal;
    end;
  end;
end;

procedure TLMDCustomDBGrid.InternalSetupScrollBarsStyle;
var
  sb: TScrollStyle;
begin
  sb := ScrollBarsStyle;
  case sb of
    ssVertical: sb := ssNone;
    ssBoth: sb := ssBoth;
  end;

  inherited ScrollBars := sb;
end;

procedure TLMDCustomDBGrid.InternalUpdateStore;
begin
  DataSetChanged;
end;

function TLMDCustomDBGrid.IsColumnFieldCompatible(ACol: TLMDGridColumn;
  ABySettings: Boolean; AField: TField; AErrMessage: PLMDString): Boolean;
begin
  if ABySettings then
    Result := TColumnAccess(ACol).IsFieldTypeCompatibleWithColSettings(AField,
                                                                       AErrMessage)
  else
    Result := AField.DataType in TColumnAccess(ACol).GetColumnCompatDataTypes;
end;

function TLMDCustomDBGrid.GetAutoColumnsMode: Boolean;
begin
  Result := FAutoColumnsMode;
end;

procedure TLMDCustomDBGrid.GetAvailableColumnFieldNames(ACol: TLMDGridColumn;
  AList: TStrings);
var
  fields: TFields;
  i:      Integer;
begin
  fields := GetFields;
  if fields <> nil then
    for i := 0 to fields.Count - 1 do
      if IsColumnFieldCompatible(ACol, False, fields[i], nil) then
        AList.Add(fields[i].FieldName);
end;

function TLMDCustomDBGrid.GetAveTextWidth(const AText: TLMDString;
  AMaxTextLn: Integer; AFont: TFont): Integer;
var
  restoreCanvas: Boolean;
  tempDc:        HDC;
  tm:            TTextMetric;
  w:             Integer;
begin
  restoreCanvas := not HandleAllocated;
  if restoreCanvas then
    Canvas.Handle := GetDC(0);

  try
    Canvas.Font := AFont;
    GetTextMetrics(Canvas.Handle, tm);
    Result := AMaxTextLn * (Canvas.TextWidth('0') - tm.tmOverhang) +
              tm.tmOverhang + 4;

    Canvas.Font := AFont;
    w := Canvas.TextWidth(AText) + 4;
    if Result < w then
      Result := w;
  finally
    if restoreCanvas then
    begin
      tempDc := Canvas.Handle;
      Canvas.Handle := 0;
      ReleaseDC(0, tempDc);
    end;
  end;
end;

function TLMDCustomDBGrid.GetColumnField(AColumn: TLMDGridColumn): TField;
begin
  Result := FColFields[AColumn.Position];
end;

function TLMDCustomDBGrid.GetColumnFieldKey(AColumn: TLMDGridColumn): TField;
begin
  Result := FColFieldsKey[AColumn.Position];
end;

function TLMDCustomDBGrid.GetDataRowCount: Integer;
begin
  if FLink.Active then
    Result := FLink.RecordCount
  else
    Result := 0;
end;

function TLMDCustomDBGrid.GetDataSource: TDataSource;
begin
  Result := FLink.DataSource;
end;

function TLMDCustomDBGrid.GetDefaultColumnAlignment(
  AColumn: TLMDGridColumn): TAlignment;
var
  f: TField;
begin
  f := FieldByCol(AColumn);
  if f <> nil then
    Result := f.Alignment
  else
    Result := inherited GetDefaultColumnAlignment(AColumn);
end;

function TLMDCustomDBGrid.GetDefaultColumnCaption(
  AColumn: TLMDGridColumn): TLMDString;
var
  f: TField;
begin
  f := FieldByCol(AColumn);
  if f <> nil then
  begin
    if f.DisplayLabel <> '' then
      Result := f.DisplayLabel
    else
      Result := f.FieldName
  end
  else
    Result := inherited GetDefaultColumnCaption(AColumn);
end;

function TLMDCustomDBGrid.GetDefaultColumnReadOnly(
  AColumn: TLMDGridColumn): Boolean;
var
  f: TField;
begin
  f := FieldByCol(AColumn);
  if f <> nil then
    Result := f.ReadOnly
  else
    Result := inherited GetDefaultColumnReadOnly(AColumn);
end;

function TLMDCustomDBGrid.GetDefaultColumnVisible(
  AColumn: TLMDGridColumn): Boolean;
var
  f: TField;
begin
  f := FieldByCol(AColumn);
  if f <> nil then
    Result := f.Visible
  else
    Result := inherited GetDefaultColumnVisible(AColumn);
end;

function TLMDCustomDBGrid.GetDefaultColumnWidth(
  AColumn: TLMDGridColumn): Integer;
var
  f: TField;
begin
  f := FieldByCol(AColumn);
  if f <> nil then
    Result := FieldWidthToColWidth(AColumn, f.DisplayWidth)
  else
    Result := inherited GetDefaultColumnWidth(AColumn);
end;

procedure TLMDCustomDBGrid.RefreshColumns;
var
  cb: TLMDGridColumnNameSetCallback;
begin
  cb := nil;
  RefreshColumns(False, cb);
end;

procedure TLMDCustomDBGrid.ReadAutoColumns(Reader: TReader);
begin
  FAutoColumnsMode := Reader.ReadBoolean;
  RefreshColumns;
end;

procedure TLMDCustomDBGrid.RefreshColumns(AutoCreateComponents: Boolean;
  ANameSetProc: TLMDGridColumnNameSetCallback);
var
  fields:   TFields;
  i:        Integer;
  descr:    TLMDGridColumnDescr;
  col:      TLMDGridColumn;
  field:    TField;
  recreate: Boolean;

  procedure ResetCol(ACol: TLMDGridColumn; ADoInit: Boolean);
  var
    f: TField;
  begin
    f := FieldByCol(ACol);

    FColFields[ACol.Position] := f;

    if (f <> nil) and (fields <> nil) and (f.FieldKind = fkLookup) then
      FColFieldsKey[ACol.Position] := fields.FindField(f.KeyFields)
    else
      FColFieldsKey[ACol.Position] := nil;

    if f <> nil then
      FColFieldsCompat[ACol.Position] := IsColumnFieldCompatible(ACol, True, f, nil)
    else
      FColFieldsCompat[ACol.Position] := False;

    if ADoInit then
      TColumnAccess(ACol).CheckInitPropsForField;
  end;

  procedure SyncColumns;
  var
    i: Integer;
  begin
    SetLength(FColFields, Columns.Count);
    SetLength(FColFieldsKey, Columns.Count);
    SetLength(FColFieldsCompat, Columns.Count);

    for i := 0 to Columns.Count - 1 do
      ResetCol(Columns[i], False);
  end;

begin
  if InInternal then
    Exit;

  BeginUpdateLow(False, True);
  try
    ExitNewRecMode(False);
    ExitRowEditMode(False);

    recreate := FAutoColumnsMode or AutoCreateComponents;
    if recreate then
      EnterInitMode;

    try
      if FAutoColumnsMode then
      begin
        Columns.Clear;

        SetLength(FColFields, 0);
        SetLength(FColFieldsKey, 0);
        SetLength(FColFieldsCompat, 0);
      end;

      fields := GetFields(False);
      SyncColumns;

      if fields <> nil then
      begin
        for i := 0 to fields.Count - 1 do
        begin
          field := fields[i];
          col := ColByField(field.FieldName);

          if (col = nil) and recreate then
          begin
            descr := TLMDGridColumn.GetRegisteredColumnClass(field.DataType);
            if descr <> nil then
            begin
              if AutoCreateComponents then
                col := descr.ColClass.Create(self.Owner)
              else
                col := descr.ColClass.Create(nil);

              if Assigned(ANameSetProc) then
                ANameSetProc(col);

              col.FieldName := fields[i].FieldName;
              col.Grid := self;

              SetLength(FColFields, Columns.Count);
              SetLength(FColFieldsKey, Columns.Count);
              SetLength(FColFieldsCompat, Columns.Count);

              ResetCol(col, True);
            end;
          end;
        end;
      end;

      if recreate then
        RebuildColsSaved
      else
        CheckDataLayoutChange;
    finally
      if recreate then
        ExitInitMode;
    end;
  finally
    EndUpdateLow;
  end;
end;

procedure TLMDCustomDBGrid.SetAutoColumnsMode(AMode: Boolean);
begin
  if AMode <> FAutoColumnsMode then
  begin
    BeginUpdateLow(False, True);
    try
      FAutoColumnsMode := AMode;
      if AMode then
        RefreshColumns
      else
        ClearColumns;
    finally
      EndUpdateLow;
    end;
  end;
end;

procedure TLMDCustomDBGrid.SetDataSource(const Value: TDataSource);
begin
  if Value = FLink.Datasource then
    Exit;

  CheckUnidirectional(Value);
  BeginUpdateLow(False, True);
  try
    FLink.DataSource := Value;
    if Value <> nil then
      Value.FreeNotification(Self);
  finally
    EndUpdateLow;
  end;
end;

procedure TLMDCustomDBGrid.TopLeftChanged;
begin
  if InInternal then
    Exit;
  inherited;
end;

function TLMDCustomDBGrid.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := (FLink <> nil) and FLink.UpdateAction(Action);
end;

procedure TLMDCustomDBGrid.UpdateLinkConfig;
begin
  FLink.BufferCount := PageHeight;
end;

procedure TLMDCustomDBGrid.UpdateScrollBar;
var
  siold, sinew: TScrollInfo;
begin
  if HandleAllocated and Showing and
     (ScrollBarsStyle in [ssBoth, ssVertical]) and
     (not IsUpdating)
  then
  begin
    if FLink.Active and HaveVisibleData then
    begin
      siold.cbSize := sizeof(siold);
      siold.fMask := SIF_ALL;
      GetScrollInfo(Self.Handle, SB_VERT, siold);
      sinew := siold;

      if IsSequenced then
      begin
        sinew.nMin := 1;
        sinew.nPage := PageHeight;
        sinew.nMax := Integer(DWORD(FLink.DataSet.RecordCount) + sinew.nPage - 1);
        if FLink.DataSet.State in [dsInactive, dsBrowse, dsEdit] then
          sinew.nPos := FLink.DataSet.RecNo;  // else keep old pos
      end
      else
      begin
        sinew.nMin := 0;
        sinew.nPage := 0;
        sinew.nMax := 4;

        if FLink.DataSet.Bof then
          sinew.nPos := 0
        else if FLink.DataSet.Eof then
          sinew.nPos := 4
        else
          sinew.nPos := 2;
      end;

      if (sinew.nMin <> siold.nMin)   or (sinew.nMax <> siold.nMax) or
         (sinew.nPage <> siold.nPage) or (sinew.nPos <> siold.nPos)
      then
        SetScrollInfo(Self.Handle, SB_VERT, sinew, True);
    end
    else
      ShowScrollBar(Handle, SB_VERT, False);
  end;
end;

procedure TLMDCustomDBGrid.WriteAutoColumns(Writer: TWriter);
begin
  Writer.WriteBoolean(FAutoColumnsMode);
end;

procedure TLMDCustomDBGrid.PageSizeChanged;
begin
  if not (csDestroying in ComponentState) then
    DataSetChanged;
end;

procedure TLMDCustomDBGrid.WMVScroll(var Msg: TWMVScroll);
var
  si:         TScrollInfo;
  curC, curR: Integer;
  sel:        Boolean;
  shift:      TShiftState;
begin
  if not FLink.Active then
    Exit;

  shift := GetShiftState;
  sel := ssShift in shift;

  curC := CurrentColumn;
  curR := CurrentRow;

  case Msg.ScrollCode of
    SB_LINEUP:   SetCurrent(curC, curR - 1, sel);
    SB_LINEDOWN: SetCurrent(curC, curR + 1, sel);

    SB_PAGEUP:   SetCurrent(curC, curR - PageHeight, sel);
    SB_PAGEDOWN: SetCurrent(curC, curR + PageHeight, sel);

    SB_THUMBPOSITION:
      begin
        if IsSequenced then
        begin
          si.cbSize := sizeof(si);
          si.fMask := SIF_ALL;
          GetScrollInfo(Self.Handle, SB_VERT, si);

          if si.nTrackPos <= 1 then
            SetCurrent(curC, -(MaxInt div 2), sel)
          else if si.nTrackPos >= FLink.DataSet.RecordCount then
            SetCurrent(curC, MaxInt div 2, sel)
          else
            SetCurrent(curC, si.nTrackPos - curR, sel);
        end
        else
        begin
          BeginInternal;
          try
            case Msg.Pos of
              0: SetCurrent(curC, -(MaxInt div 2), sel);

              1: SetCurrent(curC, curR - PageHeight, sel);

              2: Exit;

              3: SetCurrent(curC, curR + PageHeight, sel);

              4: SetCurrent(curC, MaxInt div 2, sel);
            end;
          finally
            EndInternal;
          end;
        end;
      end;

    SB_BOTTOM: SetCurrent(curC, MaxInt div 2, sel);

    SB_TOP:    SetCurrent(curC, -(MaxInt div 2), sel);
  end;

  UpdateScrollBar;
end;

function TLMDCustomDBGrid.IsSequenced: Boolean;
begin
  Result := FLink.Active and FLink.DataSet.IsSequenced;
end;

function TLMDCustomDBGrid.CanStoreEdit: Boolean;
begin
  Result := FLink.Active and (not FLink.ReadOnly) and
            FLink.DataSet.CanModify and (not FLink.DataSet.IsEmpty);
end;

function TLMDCustomDBGrid.CanStoreInsert: Boolean;
begin
  Result := FLink.Active and (not FLink.ReadOnly) and FLink.DataSet.CanModify;
end;

function TLMDCustomDBGrid.CanStoreRemove: Boolean;
begin
  Result := FLink.Active and (not FLink.ReadOnly) and
            FLink.DataSet.CanModify and (not FLink.DataSet.IsEmpty);
end;

procedure TLMDCustomDBGrid.InternalEndUpdateLow;
begin
  UpdateScrollBar;
end;

procedure TLMDCustomDBGrid.InternalEnterNewRecMode(ADestIndex: Integer);
begin
  try
    if ADestIndex = DataRowCount then
      FLink.DataSet.Append
    else
      FLink.DataSet.Insert;
  finally
    SyncGridStore;
  end;
end;

procedure TLMDCustomDBGrid.InternalExitNewRecMode(ACommit: Boolean;
  out ACurrentIndex: Integer);
begin
  if ACommit then
    FLink.DataSet.Post
  else
    FLink.DataSet.Cancel;

  ACurrentIndex := CurrentRow;
end;

function TLMDCustomDBGrid.CanStoreRowEdit: Boolean;
begin
  Result := FLink.Active and FLink.DataSet.CanModify and (not (FLink.ReadOnly));
end;

procedure TLMDCustomDBGrid.InternalEnterRowEditMode;
begin
  FLink.DataSet.Edit;
end;

procedure TLMDCustomDBGrid.InternalExitRowEditMode(ACommit: Boolean;
  out ACurrentIndex: Integer);
begin
  ACurrentIndex := CurrentRow;
  if not FLink.Active then
    Exit;

  if ACommit then
    FLink.DataSet.Post
  else
    FLink.DataSet.Cancel;
end;

procedure TLMDCustomDBGrid.InternalGetDataCell(ACol, ARow: Integer;
  Key, Value: PVariant);
var
  oldRec: Integer;
  top:    Integer;
  f, fl:  TField;
begin
  Assert(FLink.Active);

  oldRec := FLink.ActiveRecord;
  try
    top := TopDataRow;

    FLink.ActiveRecord := ARow - top;
    f := FColFields[ACol];
    fl := FColFieldsKey[ACol];

    if f = nil then
    begin
      Key^   := Null;
      Value^ := Null;
    end
    else if f.FieldKind = fkLookup then
    begin
      if fl <> nil then
      begin
        Key^ := fl.Value;
        Value^ := f.Value;
      end
      else
      begin
        Key^ := Null;
        Value^ := Null;
      end;
    end
    else if f <> nil then
    begin
      Key^ := Null;
      Value^ := f.Value;
    end
  finally
    FLink.ActiveRecord := oldRec;
  end;
end;

procedure TLMDCustomDBGrid.MoveDataRow(AFrom, ATo: Integer);
begin
  Assert(False);
end;

procedure TLMDCustomDBGrid.SetDataRowCount(const Value: Integer);
begin
  Assert(False);
end;

procedure TLMDCustomDBGrid.InternalRestrictDataPoint(var ACol: Integer;
  var ARow: Integer);
begin
  RestrictDataPoint(ACol, ARow, False);
end;

function TLMDCustomDBGrid.InternalMoveVert(ANewCurrent,
  ANewTop: Integer): Boolean;
var
  dy: Integer;
begin
  BeginInternal;
  try
    dy := ANewCurrent - CurrentRow;
    if dy <> 0 then
    begin
      dy := FLink.MoveBy(dy);
      Result := dy <> 0;
    end
    else
      Result := True;
  finally
    EndInternal;
  end;
end;

procedure TLMDCustomDBGrid.CancelSelectionLow;
begin
  if FLink.Active then
    FLink.DataSet.FreeBookmark(FSelAncBmk);

  CancelSelAncLow;

  if FLink.Active and (FSelAnc.X >= 0) and (FSelAnc.Y >= 0) then
    FSelAncBmk := FLink.DataSet.GetBookmark
  else
    FSelAncBmk := nil;
end;

function TLMDCustomDBGrid.GetSelRect: TRect;
var
  x0, x1, y0, y1: Integer;
  col, row:       Integer;
begin
  col := CurrentColumn;
  row := CurrentRow;

  x0 := Min(FSelAnc.X, col);
  x1 := Max(FSelAnc.X, col);

  y0 := Min(FSelAnc.Y, row);
  y1 := Max(FSelAnc.Y, row);

  Result := Rect(x0, y0, x1, y1);
  if opRowSelect in Options then
  begin
    Result.Left := 0;
    Result.Right := Columns.Count - 1;
  end;
end;

function TLMDCustomDBGrid.IsSelectionValid: Boolean;
begin
  Result := (FSelAncBmk <> nil) and FLink.Active;
end;

procedure TLMDCustomDBGrid.CheckBrowseMode;
begin
  if not InInternal then
    InvalidateSelRect;
end;

procedure TLMDCustomDBGrid.UpdateData;
begin
  BeginInternal;
  try
    if IsNewRecMode then
      ExitNewRecMode(True)
    else if IsRowEditMode then
      ExitRowEditMode(True);
  finally
    EndInternal;
  end;
end;

procedure TLMDCustomDBGrid.RecordChanged(Field: TField);
var
  col: TLMDGridColumn;
begin
  if not HandleAllocated then
    Exit;

  col := nil;
  if Field <> nil then
    col := ColByField(Field);

  if col = nil then
    InvalidateRow(inherited Row)
  else
    InvalidateCell(DataColToGridCol(col.Position), inherited Row);
end;

function TLMDCustomDBGrid.ColByField(AField: TField): TLMDGridColumn;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Length(FColFields) - 1 do
    if FColFields[i] = AField then
    begin
      Result := Columns[i];
      Exit;
    end;
end;

procedure TLMDCustomDBGrid.FocusControl(Field: TFieldRef);
begin
  { TODO : Show editor?... }
end;

procedure TLMDCustomDBGrid.ActiveChanged;
begin
  if FLink.Active and Assigned(FLink.DataSource) then
    CheckUnidirectional(DataSource);

  BeginUpdateLow(False, True);
  try
    InternalDataLayoutChange;
    DataSetChanged;
  finally
    EndUpdateLow;
  end;
end;

function TLMDCustomDBGrid.IsEOF: Boolean;
begin
  Result := FLink.Active and FLink.Eof;
end;

procedure TLMDCustomDBGrid.CancelSelAncLow;
begin
  FSelAnc := Point(CurrentColumn, CurrentRow);
end;

//== TLMDGridLookupChooser =====================================================

constructor TLMDGridLookupChooser.Create(AOwner: TComponent);
begin
  inherited;

  FDefWidth := 0;

  FDropDownCount := 7;
  FItemHeight := 18;

  FDBGrid := nil;

  FLookupSource := TDataSource.Create(nil);
end;

function TLMDGridLookupChooser.CreateDBGrid(
  AParent: TWinControl): TLMDCustomDBGrid;
var
  field, resField: TField;
  col:             TLMDGridColumn;
begin
  CheckCol;

  Result := TPopupDBGrid.Create(AParent.Owner, GetEditHelper, self);

  field := GetColumnField;
  FLookupSource.DataSet := field.LookupDataSet;
  Result.DataSource := FLookupSource;

  if (FLookupSource.DataSet <> nil) and FLookupSource.DataSet.Active then
  begin
    resField := FLookupSource.DataSet.Fields.FindField(field.LookupResultField);

    Result.ClearColumns;
    Result.SetAutoColumnsMode(False);
    col := TProxyColumn.Create(nil);
    col.FieldName := resField.FieldName;
    col.ReadOnly := True;
    Result.Columns.Add(col);
  end;

  Result.DefaultRowHeight := FItemHeight;
  Result.ThemeMode :=  TGridAccess(FColumn.Grid).ThemeMode;
  Result.ThemeGlobalMode := TGridAccess(FColumn.Grid).ThemeGlobalMode;
  Result.BorderStyle := bsNone;
  Result.Align := alClient;

  Result.Parent := AParent;
  Result.Options := [opDrawFocusSelected, opThumbTracking];
  Result.Visible := True;

  FDefWidth := Result.Width;
end;

destructor TLMDGridLookupChooser.Destroy;
begin
  FreeAndNil(FDBGrid);

  FLookupSource.DataSet := nil;
  FreeAndNil(FLookupSource);

  inherited;
end;

function TLMDGridLookupChooser.GetChooserKind: TLMDGridChooserKind;
begin
  Result := ckControl;
end;

function TLMDGridLookupChooser.GetControlSize: TSize;
begin
  Assert(FDBGrid <> nil);

  Result.cy := CalkHeight;
  Result.cx := FDefWidth;
end;

procedure TLMDGridLookupChooser.SetItemHeight(const Value: Integer);
begin
  if Value = FItemHeight then
    Exit;

  FItemHeight := Value;
  ColumnNotifyPropChanged;
end;

procedure TLMDGridLookupChooser.PaintFormattedCellData(ACanvas: TCanvas;
  ARect: TRect; const AData: Variant; AAlignment: TAlignment;
  ACellState: TLMDGridCellStates);
var
  v:   Variant;
  col: TColumnAccess;
begin
  col := TColumnAccess(FColumn);
  v   := col.FormatPaintData(AData);
  col.PaintFormattedCellData(ACanvas, ARect, v, AAlignment, ACellState);
end;

procedure TLMDGridLookupChooser.SetDropDownCount(const Value: Integer);
begin
  if Value = FDropDownCount then
    Exit;

  FDropDownCount := Value;
  ColumnNotifyPropChanged;
end;

function  TLMDGridLookupChooser.CalkHeight: Integer;
var
  cnt:     Integer;
  borderH: Integer;
begin
  borderH := FDBGrid.Height - FDBGrid.ClientHeight;

  if FDBGrid.RowCount <= 1 then
    cnt := FDropDownCount
  else
    cnt := Min(FDBGrid.RowCount + 1, FDropDownCount);

  Result := FItemHeight * cnt + borderH;
end;

function TLMDGridLookupChooser.GetData(var AKey, AValue: Variant): Boolean;
var
  ds:           TDataSet;
  field, f, rf: TField;
  ok:           Boolean;
begin
  CheckCol;

  ds := FDBGrid.DataSource.DataSet;
  Assert(ds <> nil);

  ok := False;
  if ds.Active then
  begin
    field := GetColumnField;

    f := ds.Fields.FindField(field.LookupKeyFields);
    rf := ds.Fields.FindField(field.LookupResultField);

    ok := (f <> nil) and (rf <> nil);
    if ok then
    begin
      AKey := f.Value;
      AValue := rf.Value;
    end;
  end;

  if not ok then
  begin
    AKey := FKey;
    AValue := FValue;
  end;

  Result := ok;
end;

function TLMDGridLookupChooser.GetLayout: TLMDGridChooserLayout;
begin
  Result := clUnderEdit;
end;

procedure TLMDGridLookupChooser.SetBounds(ARect: TRect);
begin
  FDBGrid.BoundsRect := ARect;
end;

procedure TLMDGridLookupChooser.SetControlParent(AParent: TWinControl);
begin
  CheckCol;

  if AParent <> nil then
    FDBGrid := CreateDBGrid(AParent)
  else
  begin
    FDBGrid.Parent := nil;
    FDBGrid.DataSource := nil;

    FLookupSource.DataSet := nil;

    FreeAndNil(FDBGrid);
  end;
end;

procedure TLMDGridLookupChooser.SetData(const AKey, AValue: Variant);
var
  ds:                 TDataSet;
  field, lookupField: TField;
begin
  CheckCol;

  FKey   := AKey;
  FValue := AValue;

  ds := FDBGrid.DataSource.DataSet;
  Assert(ds <> nil);

  if ds.Active then
  begin
    field := GetColumnField;
    lookupField := GetColumnFieldKey;

    ds.Locate(field.LookupKeyFields, lookupField.Value, []);
  end;
end;

procedure TLMDGridLookupChooser.SetFocus;
begin
  Assert(FDBGrid.HandleAllocated);
  Windows.SetFocus(FDBGrid.Handle);
end;

//== TPopupDBGrid ==============================================================

procedure TPopupDBGrid.WMActivate(var Message: TWMActivate);
begin
  inherited;

  if Message.Active <> WA_INACTIVE then
    SendMessage(Message.ActiveWindow, WM_NCACTIVATE, WPARAM(True), 0);
end;

procedure TPopupDBGrid.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  GetParentForm(self).SetFocusedControl(FGrid.AsControl);
end;

procedure TPopupDBGrid.Beep;
begin
  // Do nothing.
end;

constructor TPopupDBGrid.Create(AOwner: TComponent;
  AGrid: TLMDGridEditParentHelper; AChooser: TLMDGridLookupChooser);
begin
  inherited Create(AOwner);
  FGrid    := AGrid;
  FChooser := AChooser; // Set chooser before inherited.
end;

function TPopupDBGrid.GetStyle: TLMDGridStyle;
begin
  Result := TGridAccess(FChooser.FColumn.Grid).Style;
end;

procedure TPopupDBGrid.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then // Report change before hiding.
    FGrid.EditorChanged;  //

  FGrid.KeyDownPreprocess(Key, Shift, psChooser);
  if Key <> 0 then
    inherited KeyDown(Key, Shift);
end;

procedure TPopupDBGrid.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  k: Word;
begin
  inherited;

  if ssDouble in Shift then
  begin
    k := VK_RETURN;
    KeyDown(k, []);
  end;
end;

procedure TPopupDBGrid.Resize;
begin
  inherited;
  Columns[0].Width := ClientWidth;
end;

function TPopupDBGrid.UseAlternate: Boolean;
begin
  Result := False;
end;

//== TProxyColumn ==============================================================

function TProxyColumn.CompareColValues(Val1, Val2: PVariant): Integer;
begin
  Result := 0;
end;

function TProxyColumn.GetColumnCompatDataTypes: TLMDGridFieldTypes;
begin
  Result := [Low(TFieldType)..High(TFieldType)];
end;

function TProxyColumn.GetEmbeddedEditor: ILMDGridEmbeddedEdit;
begin
  Assert(False);
  Result := nil;
end;

function TProxyColumn.IsSortingAllowed: Boolean;
begin
  Result := False;
end;

procedure TProxyColumn.PaintFormattedCellData(ACanvas: TCanvas;
  ARect: TRect; const AData: Variant; AAlignment: TAlignment;
  ACellState: TLMDGridCellStates);
var
  grd: TPopupDBGrid;
begin
  grd := Grid as TPopupDBGrid;
  grd.FChooser.PaintFormattedCellData(ACanvas, ARect, AData,
                                      AAlignment, ACellState);
end;

procedure TProxyColumn.ResetEmbeddedEditor;
begin
  Assert(False);
end;

initialization
  TLMDGridColumnChooser.RegisterChooserClass(TLMDGridLookupChooser,
                                             'LookupChooser',
                                             SLMDGridLookupChooserDescr,
                                             nil, [], 0,
                                             [Low(TFieldType)..High(TFieldType)],
                                             3, [fkLookup], bsPickList);

end.
