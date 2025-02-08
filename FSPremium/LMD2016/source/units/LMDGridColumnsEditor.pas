unit LMDGridColumnsEditor;
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

LMDGridColumnsEditor unit (VT)
-------------------
Unit contains columns editor for LMD Grid.

Changes
-------
Release 1.0 (July 2009)
 - Initial Release
 - Code formatting (YB, FEB 2011)

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, ImgList, ToolWin, Contnrs, DesignWindows,
  DesignIntf, LMDGrid;

type
  //== TLMDGridColumnEditForm ==================================================

  TLMDGridColumnEditForm = class(TDesignWindow)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    ColumnList: TListView;
    ToolBar: TToolBar;
    DefImages: TImageList;
    ToolsImages: TImageList;
    ToolBar1: TToolBar;
    btnDel: TToolButton;
    btnClear: TToolButton;
    ToolButton3: TToolButton;
    btnUp: TToolButton;
    btnDown: TToolButton;
    ToolButton1: TToolButton;
    btnTop: TToolButton;
    ToolButton2: TToolButton;
    btnAddAll: TToolButton;
    Images: TImageList;
    procedure btnDelClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure ColumnListKeyDown(Sender: TObject; var Key: Word;
                                Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnTopClick(Sender: TObject);
    procedure ColumnListSelectItem( Sender: TObject;
                                    Item: TListItem;
                                    Selected: Boolean);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnAddAllClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    FDesigner:  IDesigner;
    FClosing:   Boolean;
    FUpdateCnt: Integer;
    FGrid:      TLMDCustomGrid;

    procedure CheckColDelete(ACheckAll: Boolean);
    procedure CheckColAdd;

    procedure NameSetProc(ACol: TLMDGridColumn);
    procedure CloseEditor;
    procedure OnAddColClick(ASender: TObject);
    function  GetColClassIdx(AColClass: TClass): Integer;
    procedure RemoveCurrentCol;
    procedure ReloadAll(ASelToDesigner: Boolean);
    procedure MoveCurrentUpDown(AUp: Boolean);
    procedure UpdateStatus;
  protected
    procedure Activated; override;
  public
    constructor Create(AGrid: TLMDCustomGrid;
                       const ADesigner: IDesigner); reintroduce;

    procedure DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean); override;
    procedure ItemDeleted(const ADesigner: IDesigner; AItem: TPersistent); override;
    procedure ItemsModified(const ADesigner: IDesigner); override;
    procedure SelectionChanged(const ADesigner: IDesigner;
                               const ASelection: IDesignerSelections); override;
    property  Grid: TLMDCustomGrid read FGrid;
  end;

procedure LMDGridShowColumnsDialog(AGrid: TLMDCustomGrid;
                                   const ADesigner: IDesigner);

implementation

uses
  LMDTypes, LMDGridConst, Math;

{$R *.dfm}

type
  TGridAccess = class(TLMDCustomGrid);

//== Globals ===================================================================

procedure LMDGridShowColumnsDialog(AGrid: TLMDCustomGrid;
  const ADesigner: IDesigner);
var
  dlg: TLMDGridColumnEditForm;
begin
  dlg := TLMDGridColumnEditForm.Create(AGrid, ADesigner);
  dlg.Caption := SLMDGridColumnsEditorCaption + ': ' + AGrid.Name;
  dlg.Show;
end;

//== TLMDGridColumnEditForm ====================================================

procedure TLMDGridColumnEditForm.Activated;
begin
  FDesigner.Activate;
  ReloadAll(false);
end;

procedure TLMDGridColumnEditForm.btnAddAllClick(Sender: TObject);
var
  res: Integer;
  hg:  TGridAccess;
begin
  CheckColAdd;
  hg := TGridAccess(Grid);

  if (not hg.GetAutoColumnsMode) and (hg.Columns.Count > 0) then
  begin
    res := MessageDlg(SLMDGridDsgBtnAddAllColumnsAsk, mtConfirmation,
                      [mbYes, mbNo], -1);
    if res <> mrYes then
      Exit;
  end;

  hg.BeginUpdateLow(false, true);
  try
    hg.SetAutoColumnsMode(false);
    hg.Columns.Clear;
    hg.FillColumnsFromStore(NameSetProc);

    if hg.Columns.Count = 0 then
      hg.SetAutoColumnsMode(true);
  finally
    TGridAccess(Grid).EndUpdateLow;
  end;
  ReloadAll(false);
  FDesigner.Modified;

  UpdateStatus;
end;

procedure TLMDGridColumnEditForm.btnClearClick(Sender: TObject);
begin
  CheckColDelete(true);

  TGridAccess(Grid).Columns.Clear;
  TGridAccess(Grid).SetAutoColumnsMode(true);

  ReloadAll(true);
  FDesigner.Modified;
end;

procedure TLMDGridColumnEditForm.btnDelClick(Sender: TObject);
begin
  RemoveCurrentCol;
end;

procedure TLMDGridColumnEditForm.btnDownClick(Sender: TObject);
begin
  MoveCurrentUpDown(false);
end;

procedure TLMDGridColumnEditForm.btnTopClick(Sender: TObject);
begin
  if (Sender as TToolButton).Down then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;
end;

procedure TLMDGridColumnEditForm.btnUpClick(Sender: TObject);
begin
  MoveCurrentUpDown(true);
end;

procedure TLMDGridColumnEditForm.CheckColAdd;
begin
  if (Grid = nil) or (Grid.Owner = nil) then
    Exit;

  if csInline in Grid.Owner.ComponentState then
    raise ELMDGridError.Create(SLMDGridDesignerCantAddToFrame);
end;

procedure TLMDGridColumnEditForm.CheckColDelete(ACheckAll: Boolean);
var
  i:   Integer;
  col: TLMDGridColumn;
begin
  if Grid = nil then
    Exit;

  for i := 0 to ColumnList.Items.Count - 1 do
  begin
    if ACheckAll or ColumnList.Items[i].Selected then
    begin
      col := TLMDGridColumn( ColumnList.Items[i].Data );
      if csAncestor in col.ComponentState then
        raise ELMDGridError.Create(SLMDGridDesignerCantDeleteAncestor);
    end;
  end;
end;

procedure TLMDGridColumnEditForm.CloseEditor;
begin
  FClosing := True;
  FGrid    := nil;
  Close;
end;

procedure TLMDGridColumnEditForm.ColumnListKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
    RemoveCurrentCol
  else if (Key = VK_UP) and (Shift = [ssCtrl]) then
  begin
    Key := 0;
    MoveCurrentUpDown(true);
  end
  else if (Key = VK_DOWN) and (Shift = [ssCtrl]) then
  begin
    Key := 0;
    MoveCurrentUpDown(false);
  end;
end;

procedure TLMDGridColumnEditForm.ColumnListSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if not (csDestroying in ComponentState) then
    ReloadAll(true);
end;

constructor TLMDGridColumnEditForm.Create(AGrid: TLMDCustomGrid;
  const ADesigner: IDesigner);
begin
  inherited Create(nil);

  if AGrid = nil then
    raise ELMDGridError.Create(SLMDGridGridArgIsNil);
  if ADesigner = nil then
    raise ELMDGridError.Create(SLMDGridDesignerArgIsNil);

  FGrid      := AGrid;
  FDesigner  := ADesigner;
  FClosing   := false;
  FUpdateCnt := 0;

  btnDel.Hint    := SLMDGridDsgBtnDelete;
  btnClear.Hint  := SLMDGridDsgBtnClear;
  btnUp.Hint     := SLMDGridDsgBtnUp;
  btnDown.Hint   := SLMDGridDsgBtnDown;
  btnTop.Hint    := SLMDGridDsgBtnTop;
  btnAddAll.Hint := SLMDGridDsgBtnAddAllColumns;

  ReloadAll(false);
  UpdateStatus;
end;

procedure TLMDGridColumnEditForm.DesignerClosed(
  const ADesigner: IDesigner; AGoingDormant: Boolean);
begin
  if FDesigner = ADesigner then
    CloseEditor;
end;

procedure TLMDGridColumnEditForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (Grid <> nil) and (FDesigner <> nil) then
    FDesigner.SelectComponent(Grid);
  Action := caFree;
end;

procedure TLMDGridColumnEditForm.FormCreate(Sender: TObject);
begin
  ColumnList.DoubleBuffered := True;
end;

procedure TLMDGridColumnEditForm.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    CloseEditor;
end;

function TLMDGridColumnEditForm.GetColClassIdx(
  AColClass: TClass): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to TLMDGridColumn.RegisteredColumnClassesCount - 1 do
    if TLMDGridColumn.GetRegisteredColumnClass(i).ColClass = AColClass then
    begin
      Result := i;
      Exit;
    end;
end;

procedure TLMDGridColumnEditForm.ItemDeleted(const ADesigner: IDesigner;
  AItem: TPersistent);
begin
  if (AItem = nil) or FClosing then
    Exit;

  if (Grid = nil) or (csDestroying in Grid.ComponentState) or
     (AItem = Grid) then
    CloseEditor
  else
    ReloadAll(false);
end;

procedure TLMDGridColumnEditForm.ItemsModified(const ADesigner: IDesigner);
begin
  if FClosing or (ADesigner <> FDesigner) or (Grid = nil) then
    Exit;
  ReloadAll(false);
end;

procedure TLMDGridColumnEditForm.MoveCurrentUpDown(AUp: Boolean);
var
  col: TLMDGridColumn;
  i:   Integer;
begin
  if FClosing or (Grid = nil) or (ColumnList.ItemFocused = nil) then
    Exit;

  col := TLMDGridColumn(ColumnList.ItemFocused.Data);
  if TGridAccess(Grid).Columns.HaveCol(col) then
  begin
    if AUp then
      col.Position := Max(0, col.Position - 1)
    else
      col.Position := Min(TGridAccess(Grid).Columns.Count - 1, col.Position + 1);

    ReloadAll(false);

    for i := 0 to ColumnList.Items.Count - 1 do
      if ColumnList.Items[i].Data = col then
      begin
        ColumnList.ItemFocused := ColumnList.Items[i];
        ColumnList.Selected := ColumnList.Items[i];
      end
      else
        ColumnList.Items[i].Selected := false;

    ReloadAll(true);
  end;

  UpdateStatus;
  FDesigner.Modified;
end;

procedure TLMDGridColumnEditForm.NameSetProc(ACol: TLMDGridColumn);
begin
  ACol.Name := FDesigner.UniqueName(ACol.ClassName);
  FDesigner.Modified;
end;

procedure TLMDGridColumnEditForm.OnAddColClick(ASender: TObject);
var
  descr: TLMDGridColumnDescr;
  btn:   TToolButton;
  col:   TLMDGridColumn;
  i, id: Integer;
begin
  if (Grid = nil) or FClosing then
    Exit;

  CheckColAdd;
  TGridAccess(Grid).SetAutoColumnsMode(false);

  btn   := ASender as TToolButton;
  id    := Min(btn.Tag, TLMDGridColumn.RegisteredColumnClassesCount - 1);
  descr := TLMDGridColumn.GetRegisteredColumnClass(id);
  col   := descr.ColClass.Create(Grid.Owner);

  col.Name := FDesigner.UniqueName(col.ClassName);
  col.Grid := Grid;

  ReloadAll(false);

  for i := 0 to ColumnList.Items.Count - 2 do
    ColumnList.Items[i].Selected := false;

  ColumnList.Selected := ColumnList.Items[ColumnList.Items.Count - 1];
  ColumnList.ItemFocused := ColumnList.Selected;

  ReloadAll(true);
  FDesigner.Modified;
end;


procedure TLMDGridColumnEditForm.ReloadAll(ASelToDesigner: Boolean);
var
  i, cnt:      Integer;
  descr:       TLMDGridColumnDescr;
  btn:         TToolButton;
  col:         TLMDGridColumn;
  itm:         TListItem;
  newitm:      Boolean;
  sels:        IDesignerSelections;
  current:     TLMDGridColumn;
  curidx, Idx: Integer;
  bmp:         TBitmap;
  captn:       TLMDString;
  transclr:    TColor;
begin
  if FUpdateCnt > 0 then
    Exit;

  Inc(FUpdateCnt);
  try
    curidx := ColumnList.ItemIndex;

    if curidx <> -1 then
      current := TLMDGridColumn(ColumnList.Items[ColumnList.ItemIndex].Data)
    else
      current := nil;


    { Available column types. Synchronize with buttons }

    cnt := TLMDGridColumn.RegisteredColumnClassesCount;

    for i := 0 to cnt - 1 do
    begin
      descr  := TLMDGridColumn.GetRegisteredColumnClass(i);
      newitm := (i >= ToolBar.ButtonCount);

      if newitm then
      begin
        btn        := TToolButton.Create(self);
        btn.Parent := ToolBar;

        if descr.Image <> nil then
        begin
          transclr       := descr.Image.Canvas.Pixels[0, 0];
          btn.ImageIndex := Images.AddMasked(descr.Image, transclr);
        end
        else
        begin
          bmp := TBitmap.Create;
          try
            DefImages.GetBitmap(0, bmp);
            transclr       := bmp.Canvas.Pixels[0, 0];
            btn.ImageIndex := Images.AddMasked(bmp, transclr);
          finally
            bmp.Free;
          end;
        end;
      end
      else
        btn := ToolBar.Buttons[i];

      btn.Caption := descr.Description;
      btn.Hint    := descr.Description;
      btn.Tag     := i;
      if newitm then
        btn.Left := 500;
      btn.OnClick := OnAddColClick;
    end;

    while ToolBar.ButtonCount > cnt do
    begin
      Assert(cnt > 0);
      btn := ToolBar.Buttons[ ToolBar.ButtonCount - 1];

      btn.Parent := nil;
      btn.Free;
    end;

    { Column list synchronization }

    cnt := TGridAccess(Grid).Columns.Count;
    if TGridAccess(Grid).GetAutoColumnsMode then
      cnt := 0;

    for i := 0 to cnt - 1 do
    begin
      col := TGridAccess(Grid).Columns[i];

      newitm := ColumnList.Items.Count <= i;
      if newitm then
        itm := ColumnList.Items.Add
      else
        itm := ColumnList.Items[i];

      itm.Data := TGridAccess(Grid).Columns[i];

      Idx := GetColClassIdx(col.ClassType);
      if itm.ImageIndex <> Idx then
      begin
        if Idx = -1 then
          itm.ImageIndex := 0
        else
          itm.ImageIndex := Idx;
      end;

      captn := col.Title.Caption;
      if captn = '' then
        captn := '<Untittled>';

      if newitm then
      begin
        itm.SubItems.Append(captn);
        itm.SubItems.Append(col.Name);
        itm.SubItems.Append(col.ClassName);
      end
      else
      begin
        if itm.SubItems[0] <> captn then
          itm.SubItems[0] := captn;

        if itm.SubItems[1] <> col.Title.Caption then
          itm.SubItems[1] := col.Name;

        if itm.SubItems[2] <> col.Title.Caption then
          itm.SubItems[2] := col.ClassName;
      end;
    end;

    Idx := cnt;
    cnt := ColumnList.Items.Count - cnt;
    while cnt > 0 do
    begin
      ColumnList.Items[Idx].Delete;
      Dec(cnt);
    end;

    Idx := -1;
    for i := 0 to ColumnList.Items.Count - 1 do
      if ColumnList.Items[i].Data = current then
      begin
        Idx := i;
        Break;
      end;

    if Idx <> -1 then
    begin
      if ColumnList.ItemIndex <> Idx then
        ColumnList.ItemIndex := Idx
    end
    else if curidx <> -1 then
    begin
      if curidx < ColumnList.Items.Count then
        ColumnList.ItemIndex := curidx
      else
        ColumnList.ItemIndex := ColumnList.Items.Count - 1;
    end;

    if ASelToDesigner then
    begin
      sels := CreateSelectionList;

      for i := 0 to ColumnList.Items.Count - 1 do
      begin
        if ColumnList.Items[i].Selected then
        begin
          col := TLMDGridColumn( ColumnList.Items[i].Data );
          Assert(col <> nil);

          sels.Add(col);
        end;
      end;

      if sels.Count <> 0 then
        FDesigner.SetSelections(sels);
    end;
  finally
    Dec(FUpdateCnt);
  end;

  UpdateStatus;
end;

procedure TLMDGridColumnEditForm.RemoveCurrentCol;
var
  i, first: Integer;
  col:      TLMDGridColumn;
begin
  if (Grid = nil) or FClosing or (ColumnList.Selected = nil) then
    Exit;

  CheckColDelete(false);

  Inc(FUpdateCnt);
  try
    first := -1;
    for i := 0 to ColumnList.Items.Count - 1 do
    begin
      if ColumnList.Items[i].Selected then
      begin
        col := TLMDGridColumn( ColumnList.Items[i].Data );
        col.Free;

        ColumnList.Items[i].Data := nil;

        if first = -1 then
          first := i;
        ColumnList.Items[i].Selected := false;
      end;
    end;

    ColumnList.ItemIndex := Min(first, ColumnList.Items.Count - 1);
    if ColumnList.ItemIndex <> -1 then
    begin
      ColumnList.Selected    := ColumnList.Items[ColumnList.ItemIndex];
      ColumnList.ItemFocused := ColumnList.Selected;
    end;
  finally
    Dec(FUpdateCnt);
  end;

  if TGridAccess(Grid).Columns.Count = 0 then
    TGridAccess(Grid).SetAutoColumnsMode(true);

  ReloadAll(true);
  FDesigner.Modified;
end;

procedure TLMDGridColumnEditForm.SelectionChanged(
  const ADesigner: IDesigner; const ASelection: IDesignerSelections);
begin
  if FClosing or (ADesigner <> FDesigner) or (Grid = nil) then
    Exit;
  ReloadAll(false);
end;

procedure TLMDGridColumnEditForm.UpdateStatus;
begin
  btnAddAll.Visible := TGridAccess(Grid).CanFillColumnsFromStore;
  btnDel.Enabled    := ColumnList.Items.Count > 0;
  btnClear.Enabled  := btnDel.Enabled;
  btnUp.Enabled     := ColumnList.ItemIndex > 0;
  btnDown.Enabled   := ColumnList.ItemIndex < ColumnList.Items.Count - 1;
end;

end.
