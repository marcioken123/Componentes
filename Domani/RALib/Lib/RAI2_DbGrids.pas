{***********************************************************
                R&A Library
                   RAI2
       Copyright (C) 1998-99 R&A

       description : adapter unit - converts RAI2 calls to delphi calls

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib
************************************************************}
{$INCLUDE RA.INC}

unit RAI2_DbGrids;

interface

uses RAI2;

  procedure RegisterRAI2Adapter(RAI2Adapter: TRAI2Adapter);

implementation

uses Classes, Graphics, Menus, Grids, Db, DbGrids, RAI2_Windows;


  { TColumnTitle }

{ constructor Create(Column: TColumn) }
procedure TColumnTitle_Create(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TColumnTitle.Create(V2O(Args.Values[0]) as TColumn));
end;

{  procedure Assign(Source: TPersistent); }
procedure TColumnTitle_Assign(var Value: Variant; Args: TArgs);
begin
  TColumnTitle(Args.Obj).Assign(V2O(Args.Values[0]) as TPersistent);
end;

{  function DefaultAlignment: TAlignment; }
procedure TColumnTitle_DefaultAlignment(var Value: Variant; Args: TArgs);
begin
  Value := TColumnTitle(Args.Obj).DefaultAlignment;
end;

{  function DefaultColor: TColor; }
procedure TColumnTitle_DefaultColor(var Value: Variant; Args: TArgs);
begin
  Value := TColumnTitle(Args.Obj).DefaultColor;
end;

{  function DefaultFont: TFont; }
procedure TColumnTitle_DefaultFont(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TColumnTitle(Args.Obj).DefaultFont);
end;

{  function DefaultCaption: string; }
procedure TColumnTitle_DefaultCaption(var Value: Variant; Args: TArgs);
begin
  Value := TColumnTitle(Args.Obj).DefaultCaption;
end;

{  procedure RestoreDefaults; }
procedure TColumnTitle_RestoreDefaults(var Value: Variant; Args: TArgs);
begin
  TColumnTitle(Args.Obj).RestoreDefaults;
end;

{ property Read Alignment: TAlignment }
procedure TColumnTitle_Read_Alignment(var Value: Variant; Args: TArgs);
begin
  Value := TColumnTitle(Args.Obj).Alignment;
end;

{ property Write Alignment(Value: TAlignment) }
procedure TColumnTitle_Write_Alignment(const Value: Variant; Args: TArgs);
begin
  TColumnTitle(Args.Obj).Alignment := Value;
end;

{ property Read Caption: string }
procedure TColumnTitle_Read_Caption(var Value: Variant; Args: TArgs);
begin
  Value := TColumnTitle(Args.Obj).Caption;
end;

{ property Write Caption(Value: string) }
procedure TColumnTitle_Write_Caption(const Value: Variant; Args: TArgs);
begin
  TColumnTitle(Args.Obj).Caption := Value;
end;

{ property Read Color: TColor }
procedure TColumnTitle_Read_Color(var Value: Variant; Args: TArgs);
begin
  Value := TColumnTitle(Args.Obj).Color;
end;

{ property Write Color(Value: TColor) }
procedure TColumnTitle_Write_Color(const Value: Variant; Args: TArgs);
begin
  TColumnTitle(Args.Obj).Color := Value;
end;

{ property Read Font: TFont }
procedure TColumnTitle_Read_Font(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TColumnTitle(Args.Obj).Font);
end;

{ property Write Font(Value: TFont) }
procedure TColumnTitle_Write_Font(const Value: Variant; Args: TArgs);
begin
  TColumnTitle(Args.Obj).Font := V2O(Value) as TFont;
end;

  { TColumn }

{ constructor Create(Collection: TCollection) }
procedure TColumn_Create(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TColumn.Create(V2O(Args.Values[0]) as TCollection));
end;

{  procedure Assign(Source: TPersistent); }
procedure TColumn_Assign(var Value: Variant; Args: TArgs);
begin
  TColumn(Args.Obj).Assign(V2O(Args.Values[0]) as TPersistent);
end;

{  function DefaultAlignment: TAlignment; }
procedure TColumn_DefaultAlignment(var Value: Variant; Args: TArgs);
begin
  Value := TColumn(Args.Obj).DefaultAlignment;
end;

{  function DefaultColor: TColor; }
procedure TColumn_DefaultColor(var Value: Variant; Args: TArgs);
begin
  Value := TColumn(Args.Obj).DefaultColor;
end;

{  function DefaultFont: TFont; }
procedure TColumn_DefaultFont(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TColumn(Args.Obj).DefaultFont);
end;

{$IFDEF RA_D3H}
{  function DefaultImeMode: TImeMode; }
procedure TColumn_DefaultImeMode(var Value: Variant; Args: TArgs);
begin
  Value := TColumn(Args.Obj).DefaultImeMode;
end;

{  function DefaultImeName: TImeName; }
procedure TColumn_DefaultImeName(var Value: Variant; Args: TArgs);
begin
  Value := TColumn(Args.Obj).DefaultImeName;
end;
{$ENDIF RA_D3H}

{  function DefaultReadOnly: Boolean; }
procedure TColumn_DefaultReadOnly(var Value: Variant; Args: TArgs);
begin
  Value := TColumn(Args.Obj).DefaultReadOnly;
end;

{  function DefaultWidth: Integer; }
procedure TColumn_DefaultWidth(var Value: Variant; Args: TArgs);
begin
  Value := TColumn(Args.Obj).DefaultWidth;
end;

{  procedure RestoreDefaults; }
procedure TColumn_RestoreDefaults(var Value: Variant; Args: TArgs);
begin
  TColumn(Args.Obj).RestoreDefaults;
end;

{$IFDEF RA_D3H}
{ property Read Grid: TCustomDBGrid }
procedure TColumn_Read_Grid(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TColumn(Args.Obj).Grid);
end;
{$ENDIF RA_D3H}

{ property Read AssignedValues: TColumnValues }
procedure TColumn_Read_AssignedValues(var Value: Variant; Args: TArgs);
begin
  Value := S2V(Word(TColumn(Args.Obj).AssignedValues));
end;

{ property Read Field: TField }
procedure TColumn_Read_Field(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TColumn(Args.Obj).Field);
end;

{ property Write Field(Value: TField) }
procedure TColumn_Write_Field(const Value: Variant; Args: TArgs);
begin
  TColumn(Args.Obj).Field := V2O(Value) as TField;
end;

{ property Read Alignment: TAlignment }
procedure TColumn_Read_Alignment(var Value: Variant; Args: TArgs);
begin
  Value := TColumn(Args.Obj).Alignment;
end;

{ property Write Alignment(Value: TAlignment) }
procedure TColumn_Write_Alignment(const Value: Variant; Args: TArgs);
begin
  TColumn(Args.Obj).Alignment := Value;
end;

{ property Read ButtonStyle: TColumnButtonStyle }
procedure TColumn_Read_ButtonStyle(var Value: Variant; Args: TArgs);
begin
  Value := TColumn(Args.Obj).ButtonStyle;
end;

{ property Write ButtonStyle(Value: TColumnButtonStyle) }
procedure TColumn_Write_ButtonStyle(const Value: Variant; Args: TArgs);
begin
  TColumn(Args.Obj).ButtonStyle := Value;
end;

{ property Read Color: TColor }
procedure TColumn_Read_Color(var Value: Variant; Args: TArgs);
begin
  Value := TColumn(Args.Obj).Color;
end;

{ property Write Color(Value: TColor) }
procedure TColumn_Write_Color(const Value: Variant; Args: TArgs);
begin
  TColumn(Args.Obj).Color := Value;
end;

{ property Read DropDownRows: Cardinal }
procedure TColumn_Read_DropDownRows(var Value: Variant; Args: TArgs);
begin
  Value := Integer(TColumn(Args.Obj).DropDownRows);
end;

{ property Write DropDownRows(Value: Cardinal) }
procedure TColumn_Write_DropDownRows(const Value: Variant; Args: TArgs);
begin
  TColumn(Args.Obj).DropDownRows := Value;
end;

{ property Read FieldName: String }
procedure TColumn_Read_FieldName(var Value: Variant; Args: TArgs);
begin
  Value := TColumn(Args.Obj).FieldName;
end;

{ property Write FieldName(Value: String) }
procedure TColumn_Write_FieldName(const Value: Variant; Args: TArgs);
begin
  TColumn(Args.Obj).FieldName := Value;
end;

{ property Read Font: TFont }
procedure TColumn_Read_Font(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TColumn(Args.Obj).Font);
end;

{ property Write Font(Value: TFont) }
procedure TColumn_Write_Font(const Value: Variant; Args: TArgs);
begin
  TColumn(Args.Obj).Font := V2O(Value) as TFont;
end;

{$IFDEF RA_D3H}
{ property Read ImeMode: TImeMode }
procedure TColumn_Read_ImeMode(var Value: Variant; Args: TArgs);
begin
  Value := TColumn(Args.Obj).ImeMode;
end;

{ property Write ImeMode(Value: TImeMode) }
procedure TColumn_Write_ImeMode(const Value: Variant; Args: TArgs);
begin
  TColumn(Args.Obj).ImeMode := Value;
end;

{ property Read ImeName: TImeName }
procedure TColumn_Read_ImeName(var Value: Variant; Args: TArgs);
begin
  Value := TColumn(Args.Obj).ImeName;
end;

{ property Write ImeName(Value: TImeName) }
procedure TColumn_Write_ImeName(const Value: Variant; Args: TArgs);
begin
  TColumn(Args.Obj).ImeName := Value;
end;
{$ENDIF RA_D3H}

{ property Read PickList: TStrings }
procedure TColumn_Read_PickList(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TColumn(Args.Obj).PickList);
end;

{ property Write PickList(Value: TStrings) }
procedure TColumn_Write_PickList(const Value: Variant; Args: TArgs);
begin
  TColumn(Args.Obj).PickList := V2O(Value) as TStrings;
end;

{$IFDEF RA_D3H}
{ property Read PopupMenu: TPopupMenu }
procedure TColumn_Read_PopupMenu(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TColumn(Args.Obj).PopupMenu);
end;

{ property Write PopupMenu(Value: TPopupMenu) }
procedure TColumn_Write_PopupMenu(const Value: Variant; Args: TArgs);
begin
  TColumn(Args.Obj).PopupMenu := V2O(Value) as TPopupMenu;
end;
{$ENDIF RA_D3H}

{ property Read ReadOnly: Boolean }
procedure TColumn_Read_ReadOnly(var Value: Variant; Args: TArgs);
begin
  Value := TColumn(Args.Obj).ReadOnly;
end;

{ property Write ReadOnly(Value: Boolean) }
procedure TColumn_Write_ReadOnly(const Value: Variant; Args: TArgs);
begin
  TColumn(Args.Obj).ReadOnly := Value;
end;

{ property Read Title: TColumnTitle }
procedure TColumn_Read_Title(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TColumn(Args.Obj).Title);
end;

{ property Write Title(Value: TColumnTitle) }
procedure TColumn_Write_Title(const Value: Variant; Args: TArgs);
begin
  TColumn(Args.Obj).Title := V2O(Value) as TColumnTitle;
end;

{ property Read Width: Integer }
procedure TColumn_Read_Width(var Value: Variant; Args: TArgs);
begin
  Value := TColumn(Args.Obj).Width;
end;

{ property Write Width(Value: Integer) }
procedure TColumn_Write_Width(const Value: Variant; Args: TArgs);
begin
  TColumn(Args.Obj).Width := Value;
end;

  { TDBGridColumns }

{ constructor Create(Grid: TCustomDBGrid; ColumnClass: TColumnClass) }
procedure TDBGridColumns_Create(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TDBGridColumns.Create(V2O(Args.Values[0]) as TCustomDBGrid, TColumnClass(V2O(Args.Values[1]))));
end;

{  function Add: TColumn; }
procedure TDBGridColumns_Add(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TDBGridColumns(Args.Obj).Add);
end;

{$IFDEF RA_D3H}
{  procedure LoadFromFile(const Filename: string); }
procedure TDBGridColumns_LoadFromFile(var Value: Variant; Args: TArgs);
begin
  TDBGridColumns(Args.Obj).LoadFromFile(Args.Values[0]);
end;

{  procedure LoadFromStream(S: TStream); }
procedure TDBGridColumns_LoadFromStream(var Value: Variant; Args: TArgs);
begin
  TDBGridColumns(Args.Obj).LoadFromStream(V2O(Args.Values[0]) as TStream);
end;
{$ENDIF RA_D3H}

{  procedure RestoreDefaults; }
procedure TDBGridColumns_RestoreDefaults(var Value: Variant; Args: TArgs);
begin
  TDBGridColumns(Args.Obj).RestoreDefaults;
end;

{  procedure RebuildColumns; }
procedure TDBGridColumns_RebuildColumns(var Value: Variant; Args: TArgs);
begin
  TDBGridColumns(Args.Obj).RebuildColumns;
end;

{$IFDEF RA_D3H}
{  procedure SaveToFile(const Filename: string); }
procedure TDBGridColumns_SaveToFile(var Value: Variant; Args: TArgs);
begin
  TDBGridColumns(Args.Obj).SaveToFile(Args.Values[0]);
end;

{  procedure SaveToStream(S: TStream); }
procedure TDBGridColumns_SaveToStream(var Value: Variant; Args: TArgs);
begin
  TDBGridColumns(Args.Obj).SaveToStream(V2O(Args.Values[0]) as TStream);
end;
{$ENDIF RA_D3H}

{ property Read State: TDBGridColumnsState }
procedure TDBGridColumns_Read_State(var Value: Variant; Args: TArgs);
begin
  Value := TDBGridColumns(Args.Obj).State;
end;

{ property Write State(Value: TDBGridColumnsState) }
procedure TDBGridColumns_Write_State(const Value: Variant; Args: TArgs);
begin
  TDBGridColumns(Args.Obj).State := Value;
end;

{ property Read Grid: TCustomDBGrid }
procedure TDBGridColumns_Read_Grid(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TDBGridColumns(Args.Obj).Grid);
end;

{ property Read Items[Integer]: TColumn }
procedure TDBGridColumns_Read_Items(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TDBGridColumns(Args.Obj).Items[Args.Values[0]]);
end;

{ property Write Items[Integer]: TColumn }
procedure TDBGridColumns_Write_Items(const Value: Variant; Args: TArgs);
begin
  TDBGridColumns(Args.Obj).Items[Args.Values[0]] := V2O(Value) as TColumn;
end;

  { TBookmarkList }

{ constructor Create(AGrid: TCustomDBGrid) }
procedure TBookmarkList_Create(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TBookmarkList.Create(V2O(Args.Values[0]) as TCustomDBGrid));
end;

{  procedure Clear; }
procedure TBookmarkList_Clear(var Value: Variant; Args: TArgs);
begin
  TBookmarkList(Args.Obj).Clear;
end;

{  procedure Delete; }
procedure TBookmarkList_Delete(var Value: Variant; Args: TArgs);
begin
  TBookmarkList(Args.Obj).Delete;
end;

{  function Find(const Item: TBookmarkStr; var Index: Integer): Boolean; }
procedure TBookmarkList_Find(var Value: Variant; Args: TArgs);
begin
  Value := TBookmarkList(Args.Obj).Find(Args.Values[0], TVarData(Args.Values[1]).vInteger);
end;

{  function IndexOf(const Item: TBookmarkStr): Integer; }
procedure TBookmarkList_IndexOf(var Value: Variant; Args: TArgs);
begin
  Value := TBookmarkList(Args.Obj).IndexOf(Args.Values[0]);
end;

{  function Refresh: Boolean; }
procedure TBookmarkList_Refresh(var Value: Variant; Args: TArgs);
begin
  Value := TBookmarkList(Args.Obj).Refresh;
end;

{ property Read Count: Integer }
procedure TBookmarkList_Read_Count(var Value: Variant; Args: TArgs);
begin
  Value := TBookmarkList(Args.Obj).Count;
end;

{ property Read CurrentRowSelected: Boolean }
procedure TBookmarkList_Read_CurrentRowSelected(var Value: Variant; Args: TArgs);
begin
  Value := TBookmarkList(Args.Obj).CurrentRowSelected;
end;

{ property Write CurrentRowSelected(Value: Boolean) }
procedure TBookmarkList_Write_CurrentRowSelected(const Value: Variant; Args: TArgs);
begin
  TBookmarkList(Args.Obj).CurrentRowSelected := Value;
end;

{ property Read Items[Integer]: TBookmarkStr }
procedure TBookmarkList_Read_Items(var Value: Variant; Args: TArgs);
begin
  Value := TBookmarkList(Args.Obj).Items[Args.Values[0]];
end;

  { TCustomDBGrid }

{  procedure DefaultDrawDataCell(const Rect: TRect; Field: TField; State: TGridDrawState); }
procedure TCustomDBGrid_DefaultDrawDataCell(var Value: Variant; Args: TArgs);
begin
  TCustomDBGrid(Args.Obj).DefaultDrawDataCell(Var2Rect(Args.Values[0]), V2O(Args.Values[1]) as TField, TGridDrawState(Byte(V2S(Args.Values[2]))));
end;

{  procedure DefaultDrawColumnCell(const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState); }
procedure TCustomDBGrid_DefaultDrawColumnCell(var Value: Variant; Args: TArgs);
begin
  TCustomDBGrid(Args.Obj).DefaultDrawColumnCell(Var2Rect(Args.Values[0]), Args.Values[1], V2O(Args.Values[2]) as TColumn, TGridDrawState(Byte(V2S(Args.Values[3]))));
end;

{  function ValidFieldIndex(FieldIndex: Integer): Boolean; }
procedure TCustomDBGrid_ValidFieldIndex(var Value: Variant; Args: TArgs);
begin
  Value := TCustomDBGrid(Args.Obj).ValidFieldIndex(Args.Values[0]);
end;

{ property Read FieldCount: Integer }
procedure TCustomDBGrid_Read_FieldCount(var Value: Variant; Args: TArgs);
begin
  Value := TCustomDBGrid(Args.Obj).FieldCount;
end;

{ property Read Fields[Integer]: TField }
procedure TCustomDBGrid_Read_Fields(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TCustomDBGrid(Args.Obj).Fields[Args.Values[0]]);
end;

{ property Read SelectedField: TField }
procedure TCustomDBGrid_Read_SelectedField(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TCustomDBGrid(Args.Obj).SelectedField);
end;

{ property Write SelectedField(Value: TField) }
procedure TCustomDBGrid_Write_SelectedField(const Value: Variant; Args: TArgs);
begin
  TCustomDBGrid(Args.Obj).SelectedField := V2O(Value) as TField;
end;

{ property Read SelectedIndex: Integer }
procedure TCustomDBGrid_Read_SelectedIndex(var Value: Variant; Args: TArgs);
begin
  Value := TCustomDBGrid(Args.Obj).SelectedIndex;
end;

{ property Write SelectedIndex(Value: Integer) }
procedure TCustomDBGrid_Write_SelectedIndex(const Value: Variant; Args: TArgs);
begin
  TCustomDBGrid(Args.Obj).SelectedIndex := Value;
end;

  { TDBGrid }

{ constructor Create(AOwner: TComponent) }
procedure TDBGrid_Create(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TDBGrid.Create(V2O(Args.Values[0]) as TComponent));
end;


procedure RegisterRAI2Adapter(RAI2Adapter: TRAI2Adapter);
begin
  with RAI2Adapter do
  begin
   { TColumnValue }
    AddConst('DbGrids', 'cvColor', cvColor);
    AddConst('DbGrids', 'cvWidth', cvWidth);
    AddConst('DbGrids', 'cvFont', cvFont);
    AddConst('DbGrids', 'cvAlignment', cvAlignment);
    AddConst('DbGrids', 'cvReadOnly', cvReadOnly);
    AddConst('DbGrids', 'cvTitleColor', cvTitleColor);
    AddConst('DbGrids', 'cvTitleCaption', cvTitleCaption);
    AddConst('DbGrids', 'cvTitleAlignment', cvTitleAlignment);
    AddConst('DbGrids', 'cvTitleFont', cvTitleFont);
   {$IFDEF RA_D3H}
    AddConst('DbGrids', 'cvImeMode', cvImeMode);
    AddConst('DbGrids', 'cvImeName', cvImeName);
   {$ENDIF RA_D3H}
   { TColumnTitle }
    AddClass('DbGrids', TColumnTitle, 'TColumnTitle');
    AddGet(TColumnTitle, 'Create', TColumnTitle_Create, 1, [varEmpty]);
    AddGet(TColumnTitle, 'Assign', TColumnTitle_Assign, 1, [varEmpty]);
    AddGet(TColumnTitle, 'DefaultAlignment', TColumnTitle_DefaultAlignment, 0, [0]);
    AddGet(TColumnTitle, 'DefaultColor', TColumnTitle_DefaultColor, 0, [0]);
    AddGet(TColumnTitle, 'DefaultFont', TColumnTitle_DefaultFont, 0, [0]);
    AddGet(TColumnTitle, 'DefaultCaption', TColumnTitle_DefaultCaption, 0, [0]);
    AddGet(TColumnTitle, 'RestoreDefaults', TColumnTitle_RestoreDefaults, 0, [0]);
    AddGet(TColumnTitle, 'Alignment', TColumnTitle_Read_Alignment, 0, [0]);
    AddSet(TColumnTitle, 'Alignment', TColumnTitle_Write_Alignment, 0, [0]);
    AddGet(TColumnTitle, 'Caption', TColumnTitle_Read_Caption, 0, [0]);
    AddSet(TColumnTitle, 'Caption', TColumnTitle_Write_Caption, 0, [0]);
    AddGet(TColumnTitle, 'Color', TColumnTitle_Read_Color, 0, [0]);
    AddSet(TColumnTitle, 'Color', TColumnTitle_Write_Color, 0, [0]);
    AddGet(TColumnTitle, 'Font', TColumnTitle_Read_Font, 0, [0]);
    AddSet(TColumnTitle, 'Font', TColumnTitle_Write_Font, 0, [0]);
   { TColumnButtonStyle }
    AddConst('DbGrids', 'cbsAuto', cbsAuto);
    AddConst('DbGrids', 'cbsEllipsis', cbsEllipsis);
    AddConst('DbGrids', 'cbsNone', cbsNone);
   { TColumn }
    AddClass('DbGrids', TColumn, 'TColumn');
    AddGet(TColumn, 'Create', TColumn_Create, 1, [varEmpty]);
    AddGet(TColumn, 'Assign', TColumn_Assign, 1, [varEmpty]);
    AddGet(TColumn, 'DefaultAlignment', TColumn_DefaultAlignment, 0, [0]);
    AddGet(TColumn, 'DefaultColor', TColumn_DefaultColor, 0, [0]);
    AddGet(TColumn, 'DefaultFont', TColumn_DefaultFont, 0, [0]);
   {$IFDEF RA_D3H}
    AddGet(TColumn, 'DefaultImeMode', TColumn_DefaultImeMode, 0, [0]);
    AddGet(TColumn, 'DefaultImeName', TColumn_DefaultImeName, 0, [0]);
   {$ENDIF RA_D3H}
    AddGet(TColumn, 'DefaultReadOnly', TColumn_DefaultReadOnly, 0, [0]);
    AddGet(TColumn, 'DefaultWidth', TColumn_DefaultWidth, 0, [0]);
    AddGet(TColumn, 'RestoreDefaults', TColumn_RestoreDefaults, 0, [0]);
   {$IFDEF RA_D3H}
    AddGet(TColumn, 'Grid', TColumn_Read_Grid, 0, [0]);
   {$ENDIF RA_D3H}
    AddGet(TColumn, 'AssignedValues', TColumn_Read_AssignedValues, 0, [0]);
    AddGet(TColumn, 'Field', TColumn_Read_Field, 0, [0]);
    AddSet(TColumn, 'Field', TColumn_Write_Field, 0, [0]);
    AddGet(TColumn, 'Alignment', TColumn_Read_Alignment, 0, [0]);
    AddSet(TColumn, 'Alignment', TColumn_Write_Alignment, 0, [0]);
    AddGet(TColumn, 'ButtonStyle', TColumn_Read_ButtonStyle, 0, [0]);
    AddSet(TColumn, 'ButtonStyle', TColumn_Write_ButtonStyle, 0, [0]);
    AddGet(TColumn, 'Color', TColumn_Read_Color, 0, [0]);
    AddSet(TColumn, 'Color', TColumn_Write_Color, 0, [0]);
    AddGet(TColumn, 'DropDownRows', TColumn_Read_DropDownRows, 0, [0]);
    AddSet(TColumn, 'DropDownRows', TColumn_Write_DropDownRows, 0, [0]);
    AddGet(TColumn, 'FieldName', TColumn_Read_FieldName, 0, [0]);
    AddSet(TColumn, 'FieldName', TColumn_Write_FieldName, 0, [0]);
    AddGet(TColumn, 'Font', TColumn_Read_Font, 0, [0]);
    AddSet(TColumn, 'Font', TColumn_Write_Font, 0, [0]);
   {$IFDEF RA_D3H}
    AddGet(TColumn, 'ImeMode', TColumn_Read_ImeMode, 0, [0]);
    AddSet(TColumn, 'ImeMode', TColumn_Write_ImeMode, 0, [0]);
    AddGet(TColumn, 'ImeName', TColumn_Read_ImeName, 0, [0]);
    AddSet(TColumn, 'ImeName', TColumn_Write_ImeName, 0, [0]);
   {$ENDIF RA_D3H}
    AddGet(TColumn, 'PickList', TColumn_Read_PickList, 0, [0]);
    AddSet(TColumn, 'PickList', TColumn_Write_PickList, 0, [0]);
   {$IFDEF RA_D3H}
    AddGet(TColumn, 'PopupMenu', TColumn_Read_PopupMenu, 0, [0]);
    AddSet(TColumn, 'PopupMenu', TColumn_Write_PopupMenu, 0, [0]);
   {$ENDIF RA_D3H}
    AddGet(TColumn, 'ReadOnly', TColumn_Read_ReadOnly, 0, [0]);
    AddSet(TColumn, 'ReadOnly', TColumn_Write_ReadOnly, 0, [0]);
    AddGet(TColumn, 'Title', TColumn_Read_Title, 0, [0]);
    AddSet(TColumn, 'Title', TColumn_Write_Title, 0, [0]);
    AddGet(TColumn, 'Width', TColumn_Read_Width, 0, [0]);
    AddSet(TColumn, 'Width', TColumn_Write_Width, 0, [0]);
   { TDBGridColumnsState }
    AddConst('DbGrids', 'csDefault', csDefault);
    AddConst('DbGrids', 'csCustomized', csCustomized);
   { TDBGridColumns }
    AddClass('DbGrids', TDBGridColumns, 'TDBGridColumns');
    AddGet(TDBGridColumns, 'Create', TDBGridColumns_Create, 2, [varEmpty, varEmpty]);
    AddGet(TDBGridColumns, 'Add', TDBGridColumns_Add, 0, [0]);
   {$IFDEF RA_D3H}
    AddGet(TDBGridColumns, 'LoadFromFile', TDBGridColumns_LoadFromFile, 1, [varEmpty]);
    AddGet(TDBGridColumns, 'LoadFromStream', TDBGridColumns_LoadFromStream, 1, [varEmpty]);
   {$ENDIF RA_D3H}
    AddGet(TDBGridColumns, 'RestoreDefaults', TDBGridColumns_RestoreDefaults, 0, [0]);
    AddGet(TDBGridColumns, 'RebuildColumns', TDBGridColumns_RebuildColumns, 0, [0]);
   {$IFDEF RA_D3H}
    AddGet(TDBGridColumns, 'SaveToFile', TDBGridColumns_SaveToFile, 1, [varEmpty]);
    AddGet(TDBGridColumns, 'SaveToStream', TDBGridColumns_SaveToStream, 1, [varEmpty]);
   {$ENDIF RA_D3H}
    AddGet(TDBGridColumns, 'State', TDBGridColumns_Read_State, 0, [0]);
    AddSet(TDBGridColumns, 'State', TDBGridColumns_Write_State, 0, [0]);
    AddGet(TDBGridColumns, 'Grid', TDBGridColumns_Read_Grid, 0, [0]);
    AddGet(TDBGridColumns, 'Items', TDBGridColumns_Read_Items, 1, [0]);
    AddSet(TDBGridColumns, 'Items', TDBGridColumns_Write_Items, 1, [1]);
   { TBookmarkList }
    AddClass('DbGrids', TBookmarkList, 'TBookmarkList');
    AddGet(TBookmarkList, 'Create', TBookmarkList_Create, 1, [varEmpty]);
    AddGet(TBookmarkList, 'Clear', TBookmarkList_Clear, 0, [0]);
    AddGet(TBookmarkList, 'Delete', TBookmarkList_Delete, 0, [0]);
    AddGet(TBookmarkList, 'Find', TBookmarkList_Find, 2, [varEmpty, varByRef]);
    AddGet(TBookmarkList, 'IndexOf', TBookmarkList_IndexOf, 1, [varEmpty]);
    AddGet(TBookmarkList, 'Refresh', TBookmarkList_Refresh, 0, [0]);
    AddGet(TBookmarkList, 'Count', TBookmarkList_Read_Count, 0, [0]);
    AddGet(TBookmarkList, 'CurrentRowSelected', TBookmarkList_Read_CurrentRowSelected, 0, [0]);
    AddSet(TBookmarkList, 'CurrentRowSelected', TBookmarkList_Write_CurrentRowSelected, 0, [0]);
    AddGet(TBookmarkList, 'Items', TBookmarkList_Read_Items, 1, [0]);
   { TDBGridOption }
    AddConst('DbGrids', 'dgEditing', dgEditing);
    AddConst('DbGrids', 'dgAlwaysShowEditor', dgAlwaysShowEditor);
    AddConst('DbGrids', 'dgTitles', dgTitles);
    AddConst('DbGrids', 'dgIndicator', dgIndicator);
    AddConst('DbGrids', 'dgColumnResize', dgColumnResize);
    AddConst('DbGrids', 'dgColLines', dgColLines);
    AddConst('DbGrids', 'dgRowLines', dgRowLines);
    AddConst('DbGrids', 'dgTabs', dgTabs);
    AddConst('DbGrids', 'dgRowSelect', dgRowSelect);
    AddConst('DbGrids', 'dgAlwaysShowSelection', dgAlwaysShowSelection);
    AddConst('DbGrids', 'dgConfirmDelete', dgConfirmDelete);
    AddConst('DbGrids', 'dgCancelOnExit', dgCancelOnExit);
    AddConst('DbGrids', 'dgMultiSelect', dgMultiSelect);
   { TCustomDBGrid }
    AddClass('DbGrids', TCustomDBGrid, 'TCustomDBGrid');
    AddGet(TCustomDBGrid, 'DefaultDrawDataCell', TCustomDBGrid_DefaultDrawDataCell, 3, [varEmpty, varEmpty, varEmpty]);
    AddGet(TCustomDBGrid, 'DefaultDrawColumnCell', TCustomDBGrid_DefaultDrawColumnCell, 4, [varEmpty, varEmpty, varEmpty, varEmpty]);
    AddGet(TCustomDBGrid, 'ValidFieldIndex', TCustomDBGrid_ValidFieldIndex, 1, [varEmpty]);
    AddGet(TCustomDBGrid, 'FieldCount', TCustomDBGrid_Read_FieldCount, 0, [0]);
    AddGet(TCustomDBGrid, 'Fields', TCustomDBGrid_Read_Fields, 1, [0]);
    AddGet(TCustomDBGrid, 'SelectedField', TCustomDBGrid_Read_SelectedField, 0, [0]);
    AddSet(TCustomDBGrid, 'SelectedField', TCustomDBGrid_Write_SelectedField, 0, [0]);
    AddGet(TCustomDBGrid, 'SelectedIndex', TCustomDBGrid_Read_SelectedIndex, 0, [0]);
    AddSet(TCustomDBGrid, 'SelectedIndex', TCustomDBGrid_Write_SelectedIndex, 0, [0]);
   { TDBGrid }
    AddClass('DbGrids', TDBGrid, 'TDBGrid');
    AddGet(TDBGrid, 'Create', TDBGrid_Create, 1, [varEmpty]);
  end;    { with }
  RegisterClasses([TDBGrid]);
end;    { RegisterRAI2Adapter }

end.
