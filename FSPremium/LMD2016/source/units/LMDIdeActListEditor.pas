unit LMDIdeActListEditor;
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

LMDIdeActListEditor unit (YB)
-----------------------------
Action list component editors unit.

Changes
-------

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActnList, ImgList, ComCtrls, ToolWin, StdCtrls, ExtCtrls, LMDUnicode,
  LMDDsgClass, LMDDsgObjects, LMDDsgPropInsp, LMDTypes, LMDInsEditorWnds,
  LMDInsEditorUtils;

type
  {************************ TLMDActionListEditorDialog ************************}

  TLMDActionListEditorDialog = class(TForm)
    UIActions: TActionList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    Images: TImageList;
    LeftPanel: TPanel;
    Splitter1: TSplitter;
    CenterPanel: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    CatsView: TListView;
    ActsView: TListView;
    actNew: TAction;
    actDelete: TAction;
    actUp: TAction;
    actDown: TAction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure CatsViewClick(Sender: TObject);
    procedure actDeleteUpdate(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure ActsViewClick(Sender: TObject);
    procedure actUpUpdate(Sender: TObject);
    procedure actDownUpdate(Sender: TObject);
    procedure actUpExecute(Sender: TObject);
    procedure actDownExecute(Sender: TObject);
  private
    FCallbacks:  TLMDEditorWindowCallbacks;
    FActionList: TActionList;

    procedure SetFreeNotification;
    procedure CallbacksCommand(Sender: TObject;
                               ACommand: TLMDEditorWndCommand);

    function  GetCurrentCategory: string;

    procedure UpdateView;
    procedure UpdateCatsView;
    procedure UpdateActsView;

    procedure UpdateDesignerSelection;
    procedure UpdateStayOnTop;
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
  public
    class procedure OpenEditor(ACallbacks: TLMDEditorWindowCallbacks;
                               AValue: TActionList);
  end;

resourcestring
  SLMDActDlgNoCategory = '(No Category)';

implementation

{$R *.dfm}
    
{------------------------------------------------------------------------------}

var
  EditorList: TList;

{************************* TLMDActionListEditorDialog *************************}
{------------------------------------------------------------------------------}

class procedure TLMDActionListEditorDialog.OpenEditor(
  ACallbacks: TLMDEditorWindowCallbacks; AValue: TActionList);
var
  i:      Integer;
  editor: TLMDActionListEditorDialog;
begin
  for i := 0 to EditorList.Count -1 do
    if TLMDActionListEditorDialog(EditorList[i]).FActionList = AValue then
    begin
      ACallbacks.Free;

      TLMDActionListEditorDialog(EditorList[i]).Show;
      TLMDActionListEditorDialog(EditorList[i]).BringToFront;
      Exit;
    end;

  editor               := TLMDActionListEditorDialog.Create(Application);
  editor.FCallbacks    := ACallbacks;
  ACallbacks.OnCommand := editor.CallbacksCommand;
  editor.FActionList   := AValue;
  editor.Caption       := 'Editing ' + AValue.GetNamePath;

  editor.SetFreeNotification;
  editor.UpdateView;

  EditorList.Add(editor);
  editor.Show;
  editor.BringToFront;
  editor.UpdateDesignerSelection;
  editor.UpdateStayOnTop;
end;
           
{------------------------------------------------------------------------------}

procedure TLMDActionListEditorDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;
          
{------------------------------------------------------------------------------}

procedure TLMDActionListEditorDialog.FormDestroy(Sender: TObject);
begin
  EditorList.Remove(Self);
  FCallbacks.Free;
end;
        
{------------------------------------------------------------------------------}

procedure TLMDActionListEditorDialog.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  
  if Operation = opRemove then
  begin
    if AComponent = FActionList then
    begin
      FActionList := nil;
      Close;
    end;

    if (AComponent is TAction) and (ActsView <> nil) and 
       (ActsView.FindData(0, AComponent, True, False) <> nil) then
      UpdateActsView;
  end;
end;
     
{------------------------------------------------------------------------------}

procedure TLMDActionListEditorDialog.CallbacksCommand(Sender: TObject;
  ACommand: TLMDEditorWndCommand);
begin
  case ACommand of
    ewcUpdateView:      UpdateView;
    ewcHideWindow:      Hide;
    ewcShowWindow:      Show;
    ewcDestroyWindow:   Release;
    ewcUpdateStayOnTop: UpdateStayOnTop;
  end;
end;
     
{------------------------------------------------------------------------------}

procedure TLMDActionListEditorDialog.SetFreeNotification;
begin
  FActionList.FreeNotification(Self);
end;
    
{------------------------------------------------------------------------------}

procedure TLMDActionListEditorDialog.UpdateView;
begin
  if FActionList <> nil then
    Caption := 'Editing ' + FActionList.GetNamePath;

  UpdateCatsView;
  UpdateActsView;
end;
    
{------------------------------------------------------------------------------}

procedure TLMDActionListEditorDialog.UpdateDesignerSelection;
var
  i:    Integer;
  seln: TList;
begin
  if FActionList = nil then
    Exit;

  seln := TList.Create;
  try
    for i := 0 to ActsView.Items.Count - 1 do
      if ActsView.Items[i].Selected then
        seln.Add(TAction(ActsView.Items[i].Data));

    if seln.Count = 0 then
      seln.Add(FActionList);

    FCallbacks.EditorUtils.SetObjects(seln);
  finally
    seln.Free;
  end;
end;
    
{------------------------------------------------------------------------------}

procedure TLMDActionListEditorDialog.UpdateCatsView;
var
  i:      Integer;
  cats:   TStringList;
  selctd: string;
  cat:    string;
begin
  if FActionList = nil then
  begin
    CatsView.Items.Clear;
    Exit;
  end;

  cats := TStringList.Create;
  try
    { Build list of categories }

    for i := 0 to FActionList.ActionCount - 1 do
    begin
      cat := FActionList.Actions[i].Category;
      if (cat <> '') and (cats.IndexOf(cat) = -1) then
         cats.Add(FActionList.Actions[i].Category);
    end;

    { Update category list-view }

    CatsView.Items.BeginUpdate;
    try
      selctd := '';                                // Remember selected
      if CatsView.Selected <> nil then             // category.
        selctd := CatsView.Selected.Caption;       //

      CatsView.Items.Clear;

      CatsView.Items.Add.Caption := SLMDActDlgNoCategory;
      for i := 0 to cats.Count - 1 do
        CatsView.Items.Add.Caption := cats[i];

      if selctd <> '' then
        CatsView.Selected := CatsView.FindCaption( // Restore selected category.
          0, selctd, False, True, False)           //
      else
        CatsView.Selected := CatsView.Items[0];
    finally
      CatsView.Items.EndUpdate;
    end;
  finally
    cats.Free;
  end;
end;
        
{------------------------------------------------------------------------------}

procedure TLMDActionListEditorDialog.actNewExecute(Sender: TObject);
var
  act:  TAction;
  item: TListItem;
begin
  act            := TAction.Create(FActionList.Owner);
  act.Name       := FCallbacks.EditorUtils.GetUniqueCompName(act);
  act.Category   := GetCurrentCategory;
  act.ActionList := FActionList;

  UpdateView;
  item := ActsView.FindData(0, act, True, False);
  if item <> nil then
  begin
    ActsView.Selected := nil; // The way to deselect all items.
    item.Selected     := True;
  end;
  UpdateDesignerSelection;
  FCallbacks.EditorUtils.MarkModified;
end;
     
{------------------------------------------------------------------------------}

procedure TLMDActionListEditorDialog.UpdateActsView;
var
  cat:       string;
  i:         Integer;
  old, item: TListItem;
  wassel:    Boolean;
begin
  if FActionList = nil then
  begin
    ActsView.Items.Clear;
    Exit;
  end;

  cat := GetCurrentCategory;

  ActsView.Items.BeginUpdate;
  try
    for i := 0 to ActsView.Items.Count - 1 do
      ActsView.Items[i].Data := nil;

    for i := 0 to FActionList.ActionCount - 1 do
      if  FActionList.Actions[i].Category = cat then
      begin
        old := ActsView.FindCaption(0, FActionList.Actions[i].Name,
                                    False, True, False);
        wassel := (old <> nil) and old.Selected;

        item          := ActsView.Items.Insert(i);
        item.Caption  := FActionList.Actions[i].Name;
        item.Data     := FActionList.Actions[i];
        item.Selected := wassel;

        FActionList.Actions[i].FreeNotification(Self);
      end;

    for i := ActsView.Items.Count - 1 downto 0 do
      if ActsView.Items[i].Data = nil then
        ActsView.Items[i].Free;
  finally
    ActsView.Items.EndUpdate;
  end;
end;
     
{------------------------------------------------------------------------------}

procedure TLMDActionListEditorDialog.CatsViewClick(Sender: TObject);
begin
  UpdateActsView;
  UpdateDesignerSelection;
end;
      
{------------------------------------------------------------------------------}

function TLMDActionListEditorDialog.GetCurrentCategory: string;
begin
  Result := '';
  if (CatsView.Selected <> nil) and (CatsView.Selected.Index <> 0) then
    Result := CatsView.Selected.Caption;
end;
     
{------------------------------------------------------------------------------}

procedure TLMDActionListEditorDialog.actDeleteUpdate(Sender: TObject);
begin
  actDelete.Enabled := (ActsView.SelCount > 0);
end;
    
{------------------------------------------------------------------------------}

procedure TLMDActionListEditorDialog.actDeleteExecute(Sender: TObject);
var
  i: Integer;
begin
  for i := ActsView.Items.Count - 1 downto 0 do
    if ActsView.Items[i].Selected then
      TAction(ActsView.Items[i].Data).Free;

  UpdateView;
  UpdateDesignerSelection;
  FCallbacks.EditorUtils.MarkModified;
end;
     
{------------------------------------------------------------------------------}

procedure TLMDActionListEditorDialog.ActsViewClick(Sender: TObject);
begin
  UpdateDesignerSelection;
end;
    
{------------------------------------------------------------------------------}

procedure TLMDActionListEditorDialog.actUpUpdate(Sender: TObject);
begin
  actUp.Enabled := (ActsView.SelCount > 0);
end;

procedure TLMDActionListEditorDialog.actDownUpdate(Sender: TObject);
begin
  actDown.Enabled := (ActsView.SelCount > 0);
end;

procedure TLMDActionListEditorDialog.actUpExecute(Sender: TObject);
var
  i:    Integer;
  sel:  TList;
  prev: TAction;
begin
  sel  := TList.Create;
  prev := nil;
  try
    for i := ActsView.Items.Count - 1 downto 0 do
      if ActsView.Items[i].Selected then
      begin
        sel.Add(ActsView.Items[i].Data);
        prev := nil;
      end
      else if (prev = nil) and (sel.Count <> 0) then
        prev := TAction(ActsView.Items[i].Data);

      if prev <> nil then
      begin
        for i := sel.Count - 1 downto 0 do
          TAction(sel[i]).Index := prev.Index;
      end;
  finally
    sel.Free;
  end;

  UpdateView;
  UpdateDesignerSelection;
  FCallbacks.EditorUtils.MarkModified;
end;

procedure TLMDActionListEditorDialog.actDownExecute(Sender: TObject);
var
  i:    Integer;
  sel:  TList;
  next: TAction;
begin
  sel  := TList.Create;
  next := nil;
  try
    for i := 0 to ActsView.Items.Count - 1 do
      if ActsView.Items[i].Selected then
      begin
        sel.Add(ActsView.Items[i].Data);
        next := nil;
      end
      else if (next = nil) and (sel.Count <> 0) then
        next := TAction(ActsView.Items[i].Data);

      if next <> nil then
      begin
        for i := sel.Count - 1 downto 0 do
          TAction(sel[i]).Index := next.Index;
      end;
  finally
    sel.Free;
  end;

  UpdateView;
  UpdateDesignerSelection;
  FCallbacks.EditorUtils.MarkModified;
end;

procedure TLMDActionListEditorDialog.UpdateStayOnTop;
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
   
{------------------------------------------------------------------------------}

end.

