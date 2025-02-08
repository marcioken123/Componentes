unit LMDInsCollectionEditor;
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

LMDInsCollectionEditor unit (RS)
--------------------------------
Collection Editor Dialog

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, ExtCtrls, Classes, ActnList, Menus, ImgList,
  Controls, StdCtrls, ComCtrls, ToolWin, Variants, Graphics, Forms, Dialogs,
  LMDUnicode, LMDTypes, LMDInsClass, LMDInsPropInsp, LMDInsEditorWnds;

type
  {************************ TLMDCollectionEditorDialog ************************}

  // We use this to refer to an item because we have no way
  // of being notified of item's desctruction.

  TLMDItemReference = class
  public
    Id: Integer; // The unique ID of a collection item.
  end;

  TLMDCollectionEditorDialog = class(TForm)
    ToolBar1: TToolBar;
    tbAdd: TToolButton;
    tbDelete: TToolButton;
    ToolButton4: TToolButton;
    tbMoveUp: TToolButton;
    tbMoveDown: TToolButton;
    lbItems: TListBox;
    PopupMenu1: TPopupMenu;
    A1: TMenuItem;
    Delete1: TMenuItem;
    N1: TMenuItem;
    Moveup1: TMenuItem;
    Movedown1: TMenuItem;
    N2: TMenuItem;
    miToolbar: TMenuItem;
    ActionList1: TActionList;
    acAdd: TAction;
    acDelete: TAction;
    acMoveUp: TAction;
    acMoveDown: TAction;
    Timer1: TTimer;
    Images: TImageList;
    procedure acAddExecute(Sender: TObject);
    procedure acDeleteExecute(Sender: TObject);
    procedure acMoveUpExecute(Sender: TObject);
    procedure miToolbarClick(Sender: TObject);
    procedure lbItemsClick(Sender: TObject);
    procedure acMoveDownExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acDeleteUpdate(Sender: TObject);
    procedure acMoveUpUpdate(Sender: TObject);
    procedure acMoveDownUpdate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    FCallbacks: TLMDEditorWindowCallbacks;
    FColl:      TCollection;
    FColOwner:  TComponent;

    procedure CallbacksCommand(Sender: TObject;
                               ACommand: TLMDEditorWndCommand);

    function  GetColItem(AIndex: Integer): TCollectionItem;
    function  InfoById(Id: Integer): TLMDItemReference;
    function  GetItemName(ItemIndex: Integer): TLMDString;
    procedure SelectItemById(Id: Integer);
    procedure SetFreeNotification;

    procedure DeleteSelected;

    procedure UpdateListBox;
    procedure UpdateDesignerSelection;
    procedure UpdateStayOnTop;
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
  public
    class procedure OpenEditor(ACallbacks: TLMDEditorWindowCallbacks;
                               AValue: TCollection);
  end;

var
  EditorList: TList;

implementation

{$R *.dfm}

type
  TPersistentAccess = class(TPersistent);

{************************* TLMDCollectionEditorDialog *************************}
{ ------------------------------- published ---------------------------------- }
procedure TLMDCollectionEditorDialog.acAddExecute(Sender: TObject);
var
  item: TCollectionItem;
begin
  item := FColl.Add;
  UpdateListBox;
  SelectItemById(item.Id); // Focus the added item.
  UpdateDesignerSelection;
  FCallbacks.EditorUtils.MarkModified;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCollectionEditorDialog.acDeleteExecute(Sender: TObject);
begin
  DeleteSelected;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCollectionEditorDialog.acMoveUpExecute(Sender: TObject);
var
  item: TCollectionItem;
begin
  item := GetColItem(lbItems.ItemIndex);

  if (item <> nil) then
  begin
    item.Index := item.Index - 1;
    UpdateListBox;
    SelectItemById(item.Id);

    UpdateDesignerSelection;
    FCallbacks.EditorUtils.MarkModified;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCollectionEditorDialog.miToolbarClick(Sender: TObject);
begin
  miToolbar.Checked := not miToolbar.Checked;
  ToolBar1.Visible  := miToolbar.Checked;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCollectionEditorDialog.lbItemsClick(Sender: TObject);
begin
  UpdateDesignerSelection;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCollectionEditorDialog.acMoveDownExecute(Sender: TObject);
var
  item: TCollectionItem;
begin
  item := GetColItem(lbItems.ItemIndex);
  if (item <> nil) then
  begin
    item.Index := item.Index + 1;
    UpdateListBox;
    SelectItemById(item.Id);

    UpdateDesignerSelection;
    FCallbacks.EditorUtils.MarkModified;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCollectionEditorDialog.Timer1Timer(Sender: TObject);
begin
  // This is needed to achieve 'approximately' valid item list,
  // because we have no way of being notified of items' changes.

  UpdateListBox;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCollectionEditorDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCollectionEditorDialog.acDeleteUpdate(Sender: TObject);
begin
  acDelete.Enabled := (lbItems.SelCount > 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCollectionEditorDialog.acMoveUpUpdate(Sender: TObject);
begin
  acMoveUp.Enabled := (lbItems.ItemIndex > 0) and
                      (lbItems.SelCount = 1);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCollectionEditorDialog.acMoveDownUpdate(Sender: TObject);
begin
  acMoveDown.Enabled := (lbItems.ItemIndex < lbItems.Items.Count - 1) and
                        (lbItems.SelCount = 1);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCollectionEditorDialog.FormDestroy(Sender: TObject);
begin
  EditorList.Remove(Self);
  FCallbacks.Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCollectionEditorDialog.FormActivate(Sender: TObject);
begin
  UpdateDesignerSelection;
end;

{ ------------------------------ private ------------------------------------- }
function TLMDCollectionEditorDialog.GetColItem(AIndex: Integer): TCollectionItem;
var
  itemRef: TLMDItemReference;
begin
  // This function ensures existence of the requested item.
  // It must be checked as we have no way of being notified of item's
  // destrcution. So, we **must** call this function to access an item.

  itemRef := TLMDItemReference(lbItems.Items.Objects[AIndex]);
  Result  := FColl.FindItemID(ItemRef.Id);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCollectionEditorDialog.InfoById(
  Id: Integer): TLMDItemReference;
var
  i: Integer;
begin
  for i := 0 to lbItems.Items.Count - 1 do
  begin
    Result := TLMDItemReference(lbItems.Items.Objects[i]);
    if Result.Id = Id then
      Exit;
  end;
  Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCollectionEditorDialog.GetItemName(ItemIndex: Integer): TLMDString;
begin
  Result := Format('%d - %s', [ItemIndex, FColl.Items[ItemIndex].DisplayName])
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCollectionEditorDialog.SelectItemById(Id: Integer);
var
  i: Integer;
begin
  for i := 0 to lbItems.Items.Count - 1 do
    if TLMDItemReference(lbItems.Items.Objects[i]).Id = Id then
    begin
      lbItems.ItemIndex := i;
      lbItems.Selected[i] := True;
      Break; // for
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCollectionEditorDialog.SetFreeNotification;

  function _GetPersistentComponent(AObj: TPersistent): TComponent;
  begin
    while AObj <> nil do
    begin
      if AObj is TComponent then
      begin
        Result := TComponent(AObj);
        Exit;
      end;

      AObj := TPersistentAccess(AObj).GetOwner;
    end;

    Result := nil;
  end;

var
  owner: TComponent;
begin
  // In VCL there are no collection that has no owner, or that has
  // non-component owner. Moreover, Delphi 2005 .Net VCL library function
  // Classes.TPersistent.GetRootDesigner
  // tells us, that such collections can't exists.
  //
  // So, our collection free-notification mechanism will be based on then
  // standard TComponent free-notification.
  //
  // Note: this is only free-notification of the collection itself, not
  // its items.

  owner := _GetPersistentComponent(FColl);
  if owner = nil then
  begin
    raise Exception.Create('Cannot edit the collection as it ' +
                           'has no valid owner.');
  end;

  FColOwner := owner;
  FColOwner.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCollectionEditorDialog.DeleteSelected;
var
  i: Integer;
begin
  for i := lbItems.Items.Count - 1 downto 0 do
    if lbItems.Selected[i] and (GetColItem(i) <> nil) then
      FColl.Delete(i);

  UpdateListBox;
  UpdateDesignerSelection;
  FCallbacks.EditorUtils.MarkModified;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCollectionEditorDialog.UpdateListBox;

  procedure FetchItems(List: TStrings);
  var
    i:       Integer;
    itemRef: TLMDItemReference;
  begin
    if FColl <> nil then
      for i := 0 to FColl.Count - 1 do
      begin
        itemRef    := TLMDItemReference.Create;
        itemRef.Id := FColl.Items[i].ID;
        List.AddObject(GetItemName(i), itemRef);
      end;
  end;

  function ItemsEqual(items1, items2: TStrings): boolean;
  var
    i: integer;
  begin
    i      := 0;
    Result := (items1.Count = items2.Count);

    while Result and (i < items1.Count) do
    begin
      Result := (TLMDItemReference(items1.Objects[i]).Id =
                 TLMDItemReference(items2.Objects[i]).Id) and
                (items1[i] = items2[i]);
      if Result then
        Inc(i);
    end;
  end;

var
  i:        Integer;
  tmpItems: TStringList;
  itemRef:  TLMDItemReference;
  item:     TCollectionItem;
begin
  if FColl = nil then Exit;

  tmpItems := TStringList.Create;
  FetchItems(tmpItems);
  try
    if (tmpItems.Count = 0) or not ItemsEqual(lbItems.Items, tmpItems) then
    begin
      lbItems.Items.BeginUpdate;
      try
        { Delete non-existent items }

        for i := lbItems.Items.Count - 1 downto 0 do
        begin
          itemRef := TLMDItemReference(lbItems.Items.Objects[i]);
          item    := FColl.FindItemID(itemRef.Id);

          if (item = nil) or (item.Index <> i) then
          begin
            lbItems.Items.Delete(i);
            itemRef.Free;
          end
          else
            lbItems.Items[i] := GetItemName(i); // Update name.
        end;

        { Add new items }

        for i := 0 to FColl.Count - 1 do
        begin
          item := FColl.Items[i];
          if InfoById(item.ID) = nil then
          begin
            itemRef    := TLMDItemReference.Create;
            itemRef.Id := item.ID;
            lbItems.Items.InsertObject(i, GetItemName(i), itemRef);
          end;
        end;
      finally
        lbItems.Items.EndUpdate;
      end;
    end;
  finally
    for I := 0 to tmpItems.Count - 1 do
      TLMDItemReference(tmpItems.Objects[I]).Free;
    tmpItems.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCollectionEditorDialog.UpdateDesignerSelection;
var
  i:    Integer;
  item: TCollectionItem;
  seln: TList;
begin
  seln := TList.Create;
  try
    for i := 0 to lbItems.Items.Count - 1 do
      if lbItems.Selected[i] then
      begin
        item := GetColItem(i);
        if item <> nil then
          seln.Add(item);
      end;

    FCallbacks.EditorUtils.SetObjects(seln);
  finally
    seln.Free;
  end;
end;

{ ------------------------------ protected ----------------------------------- }

procedure TLMDCollectionEditorDialog.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FColOwner) then
    Close;
end;

{ --------------------------------- public ----------------------------------- }

class procedure TLMDCollectionEditorDialog.OpenEditor(
  ACallbacks: TLMDEditorWindowCallbacks; AValue: TCollection);
var
  i:      Integer;
  editor: TLMDCollectionEditorDialog;
begin
  for i := 0 to EditorList.Count -1 do
    if TLMDCollectionEditorDialog(EditorList[i]).FColl = AValue then
    begin
      ACallbacks.Free;

      TLMDCollectionEditorDialog(EditorList[i]).Show;
      TLMDCollectionEditorDialog(EditorList[i]).BringToFront;
      Exit;
    end;

  editor               := TLMDCollectionEditorDialog.Create(Application);
  editor.FCallbacks    := ACallbacks;
  ACallbacks.OnCommand := editor.CallbacksCommand;
  editor.FColl         := AValue;
  editor.Caption       := 'Editing ' + AValue.GetNamePath;

  editor.SetFreeNotification;
  editor.UpdateListBox;

  EditorList.Add(editor);
  editor.Show;
  editor.BringToFront;
  editor.UpdateStayOnTop;

  if editor.lbItems.Items.Count > 0 then
  begin
    editor.lbItems.Selected[0] := True;
    editor.UpdateDesignerSelection;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDCollectionEditorDialog.CallbacksCommand(Sender: TObject;
  ACommand: TLMDEditorWndCommand);
begin
  case ACommand of
    ewcUpdateView:      UpdateListBox;
    ewcHideWindow:      Hide;
    ewcShowWindow:      Show;
    ewcDestroyWindow:   Release;
    ewcUpdateStayOnTop: UpdateStayOnTop;
  end;
end;
       { ---------------------------------------------------------------------------- }

procedure TLMDCollectionEditorDialog.UpdateStayOnTop;
begin
  if FCallbacks.StayOnTop then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;
end;

initialization
  EditorList := TList.Create;

finalization
  EditorList.Free;
           { ---------------------------------------------------------------------------- }

end.
