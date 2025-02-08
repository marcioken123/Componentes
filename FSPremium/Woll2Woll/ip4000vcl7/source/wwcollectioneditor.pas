unit wwCollectionEditor;
{
//
// Components : TwwCollectionEditorForm
//
// Copyright (c) 1998 by Woll2Woll Software
//
}

// 9/22/98 - Added code to Collection Editor's destructor
//           and to the ItemsList OnChange event. 
//
// 10/1/98 - Added notification method to fix an access
//           violation that was occuring when a form was
//           being closed.
//
// 11/16/98 - Added code to fix the 10/1/98 change which
//           was getting called to often.  This change
//           checks to make sure that AComponent is a
//           TCustomForm.

{ This collection editor may only support the navigator currently due to
  only having one global collection editor }

interface

{$i wwIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
       {$ifdef wwdelphi6up}
       designintf, designeditors,
       {$else}
       dsgnintf,
       {$endif}
//  dsgnintf,
  wwCommon, wwCollection, ComCtrls, Buttons,
  {$ifdef wwDelphi4Up}ImgList,{$endif} ToolWin;

const
  swwInvalidParameter = 'Parameter %s of %s cannot be %s';

type
  TwwCollectionEditorForm = class(TForm)
    ItemsList: TListView;
    ToolBar1: TToolBar;
    AddButton: TToolButton;
    DeleteButton: TToolButton;
    MoveUpButton: TToolButton;
    MoveDownButton: TToolButton;
    EnabledImageList: TImageList;
    DisabledImageList: TImageList;
    ToolButton1: TToolButton;
    UserButtonDivider: TToolButton;
    UserButton1: TToolButton;
    UserButton2: TToolButton;
    procedure MoveButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure ItemsListBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure ItemsListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ItemsListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ItemsListChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
  protected
    IgnoreChange: Boolean;
    function GetSelectedComponent(Index: Integer): IwwCollectionItem;
    function GetItemText(Item: IwwCollectionItem): string;
    procedure ItemUpdateName(Item: IwwCollectionItem);
    procedure ItemUpdateSelection(Item: IwwCollectionItem);
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
  public
    Collection: IwwCollection;
    FDesigner:
        {$ifdef wwDelphi6Up} IDesigner;
        {$else} {$ifdef wwDelphi4Up} IFormDesigner; {$else} TFormDesigner; {$endif}
        {$endif}
//     {$ifdef wwDelphi4Up}IFormDesigner{$else}TFormDesigner{$endif};
    procedure Reload;
    procedure SetSelection(Instance: TPersistent; Selected: Boolean); virtual;
    procedure Update; override;
    destructor Destroy; override;
  end;

  TwwCollectionCustomizeEvent = procedure(EditorForm: TwwCollectionEditorForm) of object;

  procedure wwExecuteCollectionEditor(ACaption: string;
    ADesigner:
        {$ifdef wwDelphi6Up} IDesigner;
        {$else} {$ifdef wwDelphi4Up} IFormDesigner; {$else} TFormDesigner; {$endif}
        {$endif}
//    {$ifdef wwDelphi4Up}IFormDesigner{$else}TFormDesigner{$endif};
    ACollection: IwwCollection; CustomizeEvent: TwwCollectionCustomizeEvent);

var
  wwCollectionEditorForm: TwwCollectionEditorForm = nil;

implementation

{$R *.DFM}

// This function executes our Collection Editor.  The
// meaning of the parameters are as follows:
//
// ACaption -    The Caption of the Collection Editor form.
//               i.e. 'wwDBNavigator1.Buttons'
// ADesigner -   The Designer property of TComponentEditor,
//               TPropertyEditor, etc.
// AComponent -  The actual component getting edited.
//               i.e. In the context of TComponentEditor,
//               just pass the Component property.
// ACollection - The property that implements ICollection.
//               i.e. wwDBNavigator1.Buttons as IwwCollection
// -ksw (7/3/98)

procedure wwExecuteCollectionEditor(ACaption: string;
 ADesigner:
        {$ifdef wwDelphi6Up} IDesigner;
        {$else} {$ifdef wwDelphi4Up} IFormDesigner; {$else} TFormDesigner; {$endif}
        {$endif}
//  {$ifdef wwDelphi4Up}IFormDesigner{$else}TFormDesigner{$endif};
  ACollection: IwwCollection; CustomizeEvent: TwwCollectionCustomizeEvent);
begin
  ADesigner.Modified;

  // ACollection and AComponent cannot be nil.
  if ACollection = nil then raise EInvalidOperation.Create(Format(swwInvalidParameter, ['ACollection', 'wwExecuteCollectionEditor', 'nil']));

  if wwCollectionEditorForm = nil then
    wwCollectionEditorForm := TwwCollectionEditorForm.Create(Application);

  with wwCollectionEditorForm do
  begin
    ACollection.Designer := wwCollectionEditorForm;

    FDesigner := ADesigner;
    if (ACollection<>Collection) and (Collection<>nil) then
       Collection.Designer:= nil; // Detach previous collection

    Collection := ACollection;
    Reload;
    Caption := ACaption;
    if Assigned(CustomizeEvent) then CustomizeEvent(wwCollectionEditorForm);
    Show;
  end
end;

procedure TwwCollectionEditorForm.Update;
begin
  inherited Update;
  Reload;
end;

procedure TwwCollectionEditorForm.Reload;
var i: integer;
begin
  ItemsList.Items.BeginUpdate;
  ItemsList.Items.Clear;
  for i:= 0 to Collection.Count - 1 do
  begin
    ItemsList.Items.Add.Caption := GetItemText(Collection.Items[i]);
    Collection.Items[i].SetOnUpdateName(ItemUpdateName);
    Collection.Items[i].SetSelectionMethod(ItemUpdateSelection);
  end;
  ItemsList.Items.EndUpdate;
end;

destructor TwwCollectionEditorForm.Destroy;
begin
  Collection.Designer := nil;
  wwCollectionEditorForm := nil;
//  Designer.SelectComponent(nil);  // 9/22/98
  inherited;
end;

function TwwCollectionEditorForm.GetSelectedComponent(Index: Integer): IwwCollectionItem;
begin
  result := Collection.Items[Index];
  if result = nil then raise EInvalidOperation.Create('GetSelectedComponent is returning nil');
end;

procedure TwwCollectionEditorForm.MoveButtonClick(Sender: TObject);
var Item: IwwCollectionItem;
    Button: TComponent;
begin
  if ItemsList.Selected = nil then Exit;
  Item := GetSelectedComponent(ItemsList.Selected.Index);
  Button := Sender as TComponent;
  if (Item <> nil) and
     (((Button.Tag = -1) and (Item.Index > 0)) or
      ((Button.Tag = 1) and (Item.Index < Collection.Count))) then
  begin
    Item.Index := Item.Index + Button.Tag;
    Reload;
    ItemsList.Items[Item.Index].Selected := True;
    if FDesigner <> nil then FDesigner.Modified;
  end
end;

{$ifndef wwDelphi5}
function ExtractPersistent(Component: TPersistent): TPersistent;
begin
   result:= Component as TPersistent;
end;
{$endif}

procedure TwwCollectionEditorForm.DeleteButtonClick(Sender: TObject);
var i, OldItemIndex: integer;
    {$ifdef wwDelphi5Up}
    Selections: IDesignerSelections;
    {$else}
    Selections: TComponentList;
    {$endif}
    OldSel: TListItem;
    p: TPersistent;
begin
  // Prevent OnChange event from firing.
  IgnoreChange := True;

  if ItemsList.Selected = nil then Exit;
  OldItemIndex := ItemsList.Selected.Index;

  // Select Navigator
  {$ifndef wwDelphi5Up}
  Selections := TComponentList.Create;
  {$else}
  Selections := CreateSelectionList;
  {$endif}
  if FDesigner<>Nil then
  begin
    FDesigner.GetSelections(Selections);
//    Designer.SelectComponent(nil);
  end;
  for i := 0 to Selections.Count - 1 do begin
     { 1/21/2000 - Don't allow deleting ancerstor component }
     p:= ExtractPersistent(Selections[i]);
     if (p is TComponent) and
        (csAncestor in TComponent(p).ComponentState) then
     begin
        continue;
     end;
     p.Free;
  end;
  {$ifndef wwDelphi5Up}
  Selections.Free;
  {$endif}

  Reload;

  OldSel := ItemsList.Items[wwMin(OldItemIndex, ItemsList.Items.Count - 1)];
  if OldSel <> nil then OldSel.Selected := True;

  // Allow OnChange event to fire.
  IgnoreChange := False;

  // Set the currently selected ListView item to be selected
  ItemsListChange(ItemsList, ItemsList.Selected, ctState);

  if FDesigner <> nil then FDesigner.Modified;
end;

procedure TwwCollectionEditorForm.AddButtonClick(Sender: TObject);
begin
  Collection.Add;
  Reload;
  if FDesigner <> nil then FDesigner.Modified;
end;

function TwwCollectionEditorForm.GetItemText(Item: IwwCollectionItem): string;
begin
  result := InttoStr(Item.Index) + ' - ' + Item.GetDisplayName;
end;

procedure TwwCollectionEditorForm.ItemUpdateName(Item: IwwCollectionItem);
begin
  Reload;
  ItemsList.Items[Item.Index].Caption := GetItemText(Item);
end;

procedure TwwCollectionEditorForm.ItemUpdateSelection(Item: IwwCollectionItem);
begin
  ItemsList.Selected := ItemsList.Items[Item.Index];
end;

procedure TwwCollectionEditorForm.ItemsListBoxKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  // F11 is the default character keystroke to bring up the
  // object inspector.  If that keystroke is overridable,
  // then this code becomes unpredictable.  -!- Need to look
  // into that.  -ksw (7/3/98)
  case Key of
    VK_INSERT: AddButtonClick(AddButton);
    VK_DELETE: DeleteButtonClick(DeleteButton);
    VK_UP, VK_DOWN: if ssCtrl in Shift then
    begin
      if Key = VK_UP then
        MoveButtonClick(MoveUpButton)
      else MoveButtonClick(MoveDownButton);
      Key := 0;
    end;
    VK_RETURN: wwPlayKeystroke(Handle, VK_F11, 0);
  end;
end;

procedure TwwCollectionEditorForm.FormResize(Sender: TObject);
begin
  // The Items list is a TListView.  It is in the Report viewstyle
  // and has one column.  This "aligns" that column to the client
  // width of the list view.
  with ItemsList.ClientRect do
    ItemsList.Columns[0].Width := Right - Left;
end;

procedure TwwCollectionEditorForm.ItemsListDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source <> nil) and (Source is TListView) and (Source = Sender) and ((Sender as TListView).GetItemAt(X,Y) <> (Sender as TListView).Selected);
end;

procedure TwwCollectionEditorForm.ItemsListDragDrop(Sender,
  Source: TObject; X, Y: Integer);
var Item: TListItem;
    Index: Integer;
    SelItem: IwwCollectionItem;
begin
  Item := (Sender as TListView).GetItemAt(X,Y);
  if Item = nil then Index := (Sender as TListView).Items.Count
  else Index := Item.Index;

  SelItem := GetSelectedComponent(ItemsList.Selected.Index);
  SelItem.Index := Index;
  Reload;
  ItemsList.Items[SelItem.Index].Selected := True;
  if FDesigner <> nil then FDesigner.Modified;
end;

procedure TwwCollectionEditorForm.SetSelection(Instance: TPersistent; Selected: Boolean);
var i: Integer;
begin
  IgnoreChange := True;
  for i := 0 to ItemsList.Items.Count - 1 do
    if Collection.Items[i].GetInstance = Instance then
    begin
      ItemsList.Items[i].Selected := Selected;
      Break;
    end;
  IgnoreChange := False;
end;

procedure TwwCollectionEditorForm.Notification(AComponent: TComponent; AOperation: TOperation);
var
    {$ifdef wwDelphi5Up}
    Selections: IDesignerSelections;
    {$else}
    Selections: TComponentList;
    {$endif}
begin
  if (AOperation = opRemove) and (AComponent is TCustomForm) then
  begin
     if (FDesigner <> nil) and
        {$ifdef wwDelphi6Up}
       (FDesigner.Root = AComponent) then
       {$else}
       (FDesigner.Form = AComponent) then
       {$endif}
       { 11/20/98 - Only clear selections if its form containing component }
     begin
        {$ifndef wwDelphi5Up}
        Selections := TComponentList.Create;
        FDesigner.SetSelections(selections);
        Selections.Free;
        {$else}
        Selections := CreateSelectionList;
        FDesigner.SetSelections(selections);
        {$endif}
     end
  end;
  inherited;
end;

procedure TwwCollectionEditorForm.ItemsListChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
var
    {$ifdef wwDelphi5Up}
    Selections: IDesignerSelections;
    {$else}
    Selections: TComponentList;
    {$endif}
    i: Integer;
begin
  if (csDestroying in ComponentState) or (Change <> ctState) then Exit;  // 9/22/98

  DeleteButton.Enabled := ItemsList.Selected <> nil;
  MoveUpButton.Enabled := ItemsList.Selected <> nil;
  MoveDownButton.Enabled := ItemsList.Selected <> nil;

  if (FDesigner = nil) or IgnoreChange then Exit;

  {$ifndef wwDelphi5Up}
  Selections := TComponentList.Create;
  {$else}
  Selections := CreateSelectionList;
  {$endif}
  for i:= 0 to ItemsList.Items.Count - 1 do
    if ItemsList.Items[i].Selected then
      {$ifdef wwDelphi5}
      Selections.Add(MakeIPersistent(GetSelectedComponent(i).GetInstance));
      {$else}
      Selections.Add(GetSelectedComponent(i).GetInstance);
      {$endif}
  if Selections.Count > 0 then
    FDesigner.SetSelections(Selections);
  {$ifndef wwDelphi5Up}
  Selections.Free;
  {$endif}
end;

initialization
finalization
  wwCollectionEditorForm.Free;
end.
