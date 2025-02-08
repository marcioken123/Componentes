unit pLMDElXGridColProp;
{$I lmdcmps.inc}
{$J+}

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

pLMDElXGridColProp unit
-----------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Buttons, 
  ElSpin,
  Forms,
  Dialogs,
  ComCtrls,
  StdCtrls,
  ExtCtrls,
  Math,
  DB,
  ElDBXTree,
  ElDBXTreeGrids,
  LMDElDBConst,
  ElTree,
  ElHeader,
  ElVCLUtils,
  LMDGraphUtils,
  ElTreeComboBox,
  ElXPThemedControl,
//  UxTheme,
  DesignEditors, DesignWindows, DsnConst, DesignIntf,
  ElTreeGrids,
  ElACtrls,
  ElEdits,
  ElBtnCtl,
  ElPopBtn,
  ElCLabel,
  ElLabel,
  ElPanel,
  HTMLLbx,
  ElComponent,
  ElTreeInplaceEditors
  ;

type

  TElXColumnsDefsProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes : TPropertyAttributes; override;
  end;

  TXColumnDefs = class(TForm)
    Panel1: TElPanel;
    Panel2: TElPanel;
    NLabel1: TElLabel;
    NLabel2: TElLabel;
    Edit1: TElSpinEdit;
    Panel4: TElPanel;
    Button1: TElPopupButton;
    Button2: TElPopupButton;
    Button3: TElPopupButton;
    Button4: TElPopupButton;
    Tree: TElTreeStringGrid;
    InplaceCombo: TElTreeInplaceComboBox;
    DataSetCB: TElAdvancedComboBox;
    procedure FormShow(Sender: TObject);
    procedure DataSetCBChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure TreeItemDeletion(Sender: TObject;
      Item: TElTreeItem);
    procedure TreeItemDraw(Sender: TObject; Item: TElTreeItem;
      Surface: TCanvas; R: TRect; SectionIndex: Integer);
    procedure TreeClick(Sender: TObject);
    procedure InplaceComboBeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure InplaceComboAfterOperation(Sender: TObject; var Accepted,
      DefaultConversion: Boolean);
  private
    oldvalue : integer;
  public
    AComp : TComponent;
    DStylesDefs : TElXStylesDefs;
    DStylesDefsItem : TElXStylesDefsItem;
    procedure SetValue;
    procedure GetValue;
  end;

var

  ColumnDefs: TXColumnDefs = nil;

implementation

{$R *.DFM}
type
  PXDataRec = ^TXDataRec;
  TXDataRec = record
    ComboIdx : integer;
    DataField : string;
  end;

procedure TElXColumnsDefsProperty.Edit;
var
  Form : TCustomForm;
begin
  if ColumnDefs = nil then
    ColumnDefs := TXColumnDefs.Create(Application);
  with ColumnDefs do
  begin
    AComp := TComponent(GetComponent(0));
    DStylesDefs := TCustomElDBXTree(GetComponent(0)).StylesDefs;
    if DStylesDefs.Count > 0 then
      begin
        ShowModal;
        Form := GetParentForm(AComp as TControl);
        if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
      end
    else ShowMessage (SNoSetInstall);
  end;
end;

function TElXColumnsDefsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

procedure TXColumnDefs.FormShow(Sender: TObject);
var i : integer;
begin
  DataSetCB.Clear;
  for i:=0 to DStylesDefs.Count-1 do
      if not DStylesDefs[i].InDesign then
        if DataSetCB.Items.IndexOf(DStylesDefs[i].DataSetName) = -1 then
          DataSetCB.Items.Add(DStylesDefs[i].DataSetName);
  i := (DStylesDefs.Tree as TElDBXTreeStringGrid).ColCount;
  oldvalue := 1;
  Edit1.Value := i;
  Edit1Change(self);
  GetValue;
end;

procedure TXColumnDefs.DataSetCBChange(Sender: TObject);
var
  i  : integer;
  s: string;
begin
  DStylesDefsItem := nil;
  s := DataSetCB.Text;
  for i := 0 to DStylesDefs.Count-1 do
    if Assigned(DStylesDefs[i].DataLink.DataSet) and (CompareStr(s, DStylesDefs[i].DataSetName) = 0) then
    begin
      DStylesDefsItem := DStylesDefs[i];
      Break;
    end;
  for i := 1 to Tree.Items.Count-1 do
    begin
      Tree.Items[i].ColumnText.Clear;
      PXDataRec(Tree.Items[i].Data).ComboIdx :=0;
      PXDataRec(Tree.Items[i].Data).DataField := 'empty column or defined by user';
    end;
end;

procedure TXColumnDefs.Edit1Change(Sender: TObject);

var i : integer;
    TI : TElTreeItem;
    CS : TElCellStyle;
    PData : PXDataRec;

begin
  if Edit1.Value < 1 then Edit1.Value := 1;
  if oldvalue < Edit1.Value then
    begin
      for i := oldvalue to Edit1.Value - 1 do
        begin
          New(PData);
          PData^.ComboIdx := 0;
          PData^.DataField := 'empty column or defined by user';
          TI := Tree.Items.AddLastItem(nil);
          TI.Data := PData;
          TI.Text := 'Column'+IntToStr(TI.Index+1);
          TI.UseStyles := true;
          CS := TI.AddStyle;
          CS.OwnerProps := true;
          CS.Style := elhsOwnerDraw;
          CS.CellType := sftEnum;
          CS := TI.AddStyle;
          CS.OwnerProps := true;
          CS.Style := elhsOwnerDraw;
        end;
    end
  else
    begin
      if Tree.IsEditing then Tree.EndEdit(true);
      for i := oldvalue downto Edit1.Value do
        begin
          Tree.Items.Delete(Tree.Items[i]);
        end;
    end;
  oldvalue := Edit1.value;
end;

procedure TXColumnDefs.Button1Click(Sender: TObject);
begin
  if (AComp is TElDBXTreeStringGrid) then
    if Assigned((AComp as TElDBXTreeStringGrid).DataSource.DataSet) then
    begin
      (AComp as TElDBXTreeStringGrid).ColCount := Edit1.Value;
      SetValue;
      (AComp as TElDBXTreeStringGrid).RebuildTree(true);
    end
    else
      ShowMessage(SNoDSetInstall);
  Close;
end;

procedure TXColumnDefs.SetValue;
var
  i,j : integer;
  s, s1 : string;
begin
  s1 := DataSetCB.Text;
  for j := 0 to DStylesDefs.Count - 1 do
  begin
    DStylesDefs[j].DataFields.Clear;
    DStylesDefs[j].HasColumn := False;
    if Assigned(DStylesDefs[j].DataLink.DataSet) and (SameText(s1, DStylesDefs[j].DataSetName)) then
    begin
      DStylesDefs[j].HasColumn := True;
      for i := 1 to Edit1.Value - 1 do
      begin
        s := PXDataRec(Tree.Items[i].Data).DataField;
        DStylesDefs[j].DataFields.Add(s);
        if s <> 'empty column or defined by user' then
          begin
          if DStylesDefs[j].DataLink.DataSet.DefaultFields then
            begin
              (DStylesDefs.Tree as TElDBXTreeStringGrid).HeaderSections[i].Text := DStylesDefs[j].DataLink.DataSet.FieldDefList.Find(s).DisplayName;
            end
            else
            begin
              (DStylesDefs.Tree as TElDBXTreeStringGrid).HeaderSections[i].Text := DStylesDefs[j].DataLink.DataSet.FindField(s).DisplayLabel;
            end;
          //            (DStylesDefs.Tree as TElDBXTreeStringGrid).HeaderSections[i].Text := s;
            (DStylesDefs.Tree as TElDBXTreeStringGrid).HeaderSections[i].AutoSize := (DStylesDefs.Tree as TElDBXTreeStringGrid).AutoResizeColumns;
          end
        else
          (DStylesDefs.Tree as TElDBXTreeStringGrid).HeaderSections[i].Text := '';
      end;
    end;
  end;
  if (DStylesDefs.Tree as TElDBXTreeStringGrid).AutoResizeColumns then
    if Assigned((DStylesDefs.Tree as TElDBXTreeStringGrid).Items.RootItem[0]) then
      (DStylesDefs.Tree as TElDBXTreeStringGrid).Items.RootItem[0].TreeView.AutoSizeAllColumns;
end;

procedure TXColumnDefs.Button2Click(Sender: TObject);
begin
  if (AComp is TElDBXTreeStringGrid) then
    begin
      (AComp as TElDBXTreeStringGrid).ColCount := Edit1.Value;
      SetValue;
      (AComp as TElDBXTreeStringGrid).RebuildTree(true);
    end;
end;

procedure TXColumnDefs.GetValue;
var i,j : integer;
begin
  for j := 0 to DStylesDefs.Count-1 do
  begin
    if (DStylesDefs[j].DataFields.Count > 0) or (DStylesDefs[j].HasColumn) then
    begin
      DStylesDefsItem := DStylesDefs[j];
      DataSetCB.Text := DStylesDefsItem.DataSetName;
      DataSetCBChange(self);
      Edit1.Value := DStylesDefs[j].DataFields.Count + 1;
      for i := 1 to Edit1.Value - 1 do
      begin
        PXDataRec(Tree.Items[i].Data).DataField := DStylesDefsItem.DataFields.Strings[i-1];
        if DStylesDefsItem.DataFields.Strings[i-1] <> 'empty column or defined by user' then
        begin
          if Assigned(DStylesDefsItem.DataLink.DataSet.FindField(DStylesDefsItem.DataFields.Strings[i-1])) then
            PXDataRec(Tree.Items[i].Data).ComboIdx := DStylesDefsItem.DataLink.DataSet.FindField(DStylesDefsItem.DataFields.Strings[i-1]).FieldNo
          else
          begin
            PXDataRec(Tree.Items[i].Data).ComboIdx := 0;
            DStylesDefsItem.DataFields.Strings[i-1] := 'empty column or defined by user';
            PXDataRec(Tree.Items[i].Data).DataField := DStylesDefsItem.DataFields.Strings[i-1];
          end;
        end
        else PXDataRec(Tree.Items[i].Data).ComboIdx := 0;
      end;
      Tree.Refresh;
      break;
    end;
  end;
end;

procedure TXColumnDefs.Button3Click(Sender: TObject);
var i : integer;
begin
  DataSetCB.Clear;
      for i:=0 to DStylesDefs.Count-1 do
          if not DStylesDefs[i].InDesign then DataSetCB.Items.Add(DStylesDefs[i].DataSetName);
  i := (DStylesDefs.Tree as TElDBXTreeStringGrid).ColCount;
  Edit1.Value := i;
  Edit1Change(Self);
  GetValue;
end;

procedure TXColumnDefs.Button4Click(Sender: TObject);
begin
  Close;
end;

procedure TXColumnDefs.TreeItemDeletion(Sender: TObject; Item: TElTreeItem);

begin
  if Assigned(Item.Data) then
    Dispose(PXDataRec(Item.Data));
end;

procedure TXColumnDefs.TreeItemDraw(Sender: TObject; Item: TElTreeItem;
  Surface: TCanvas; R: TRect; SectionIndex: Integer);
var
  ArrowColor: TColor;
begin
  Surface.Brush.Style := bsClear;
  if SectionIndex = 1 then
  begin
    Dec(R.Right, 20);

    DrawText(Surface.Handle, Pchar(PXDataRec(Item.Data).DataField), -1, R, DT_LEFT or DT_SINGLELINE or DT_VCENTER);

    R.Left := R.Right;
    R.Right := R.Right + 20;
    if Item.Selected then
      ArrowColor := clHighlightText
    else
      ArrowColor := clWindowText;
    LMDDrawArrow(Surface, eadDown, R, ArrowColor, true);
  end;
end;

procedure TXColumnDefs.TreeClick(Sender: TObject);
var HS : integer;
    Item : TElTreeItem;
    ItemPart: TSTItemPart;
    P       : TPoint;
begin
  GetCursorPos(P);
  P := Tree.ScreenToClient(P);
  Item := Tree.GetItemAt(P.x, P.Y, ItemPart, HS);
  if HS = 1 then
    if P.X > Tree.HeaderSections[HS].Right -10 then
      Tree.EditItem(Item, HS);
end;

procedure TXColumnDefs.InplaceComboBeforeOperation(Sender: TObject;
  var DefaultConversion: Boolean);
var
  comboBox : TElHTMLComboBox;
    i : integer;
begin
  ComboBox := InplaceCombo.Editor;
  Combobox.Items.Clear;
  Combobox.Items.Add('empty column or defined by user');
  if (DStylesDefsItem <> nil) and (DStylesDefsItem.DataLink.DataSet <> nil) then
    for i := 0 to DStylesDefsItem.DataLink.DataSet.FieldCount-1 do
      Combobox.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName);
  ComboBox.Text := PXDataRec((InplaceCombo.Item as TElTreeItem).Data).DataField;
  ComboBox.ItemIndex := PXDataRec((InplaceCombo.Item as TElTreeItem).Data).ComboIdx;
  Combobox.Style := csDropDownList;
  InplaceCombo.ValueAsText := PXDataRec((InplaceCombo.Item as TElTreeItem).Data).DataField;
end;

procedure TXColumnDefs.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if Tree.IsEditing then Tree.EndEdit(true);
end;

procedure TXColumnDefs.InplaceComboAfterOperation(Sender: TObject;
  var Accepted, DefaultConversion: Boolean);
var comboBox : TElHTMLComboBox;//TElAdvancedCombobox;
begin
  ComboBox := InplaceCombo.Editor;
  if ComboBox.ItemIndex >= 0 then
    begin
      PXDataRec((InplaceCombo.Item as TElTreeItem).Data).ComboIdx := ComboBox.ItemIndex;
      PXDataRec((InplaceCombo.Item as TElTreeItem).Data).DataField := ComboBox.Items[ComboBox.ItemIndex];
      Accepted := true;
    end
  else
    Accepted := false;
end;

end.
