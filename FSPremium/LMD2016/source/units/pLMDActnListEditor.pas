unit pLMDActnListEditor;
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

pLMDActnListEditor(AH)
------------------------------

Changes
-------
Release 9.0 (September 2008)
 - Initial Release

###############################################################################}
interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ActnList, Menus, ComCtrls, ToolWin, LMDActnList,
  LMDUtils, LMDStdActns, LMDTypes, ImgList, StdActns, 
  DesignEditors, DesignWindows, DsnConst, DesignIntf{$IFDEF LMDCOMP17},System.Actions{$ENDIF};
  type
  TfrmActionListEditor = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ActionList1: TActionList;
    mnuStd: TPopupMenu;
    actNewAction: TAction;
    actNewStandardAction: TAction;
    NewAction1: TMenuItem;
    Newstandardaction1: TMenuItem;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    lstCategory: TListBox;
    Splitter1: TSplitter;
    lstAction: TListBox;
    ImageList1: TImageList;
    mnuActions: TPopupMenu;
    actMoveUp: TAction;
    actMoveDown: TAction;
    actDelete: TAction;
    mnuToolbar: TPopupMenu;
    actTextLabel: TAction;
    extLabels1: TMenuItem;
    tmrUpdate: TTimer;
    NewAction2: TMenuItem;
    Newstandardaction2: TMenuItem;
    N1: TMenuItem;
    MoveUp1: TMenuItem;
    MoveDown1: TMenuItem;
    N2: TMenuItem;
    actSwitchToolbar: TAction;
    N3: TMenuItem;
    actSwitchToolbar1: TMenuItem;
    actEditCut: TEditCut;
    actEditCopy: TEditCopy;
    actEditPaste: TEditPaste;
    Copy1: TMenuItem;
    Cut1: TMenuItem;
    Paste1: TMenuItem;
    Delete1: TMenuItem;
    procedure actNewStandardActionExecute(Sender: TObject);
    procedure actNewActionExecute(Sender: TObject);
    procedure lstCategoryMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lstCategoryKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lstActionMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lstActionKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actTextLabelExecute(Sender: TObject);
    procedure actMoveUpExecute(Sender: TObject);
    procedure actMoveDownExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lstCategoryClick(Sender: TObject);
    procedure lstActionClick(Sender: TObject);
    procedure tmrUpdateTimer(Sender: TObject);
    procedure actSwitchToolbarExecute(Sender: TObject);
    procedure actEditCutExecute(Sender: TObject);
    procedure actEditCopyExecute(Sender: TObject);
    procedure actEditPasteExecute(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  private
    procedure ActionEnumarator(const Category: string; ActionClass: TBasicActionClass; Info: TLMDDataTag);
    procedure NotifyCategoryChange;
    procedure SelectAction;
    procedure AddNewAction(AClass: TBasicActionClass; const ACategory: String);
    function UniqueActionName(LName: string): string;
    procedure UpdateActionsState;
  public
    { Public declarations }
    FActionList: TLMDActionList;
    FDesigner: IDesigner;
    procedure UpdateList;
  end;

var
  frmActionListEditor: TfrmActionListEditor;

implementation

uses
  pLMDStdActnList, LMDProcs;

type
  THackLMDActionList = class(TLMDActionList);

{$R *.dfm}

procedure TfrmActionListEditor.actDeleteExecute(Sender: TObject);
var
  i: Integer;
  LItemSave: Integer;
  LAction: TContainedAction;
begin
  LItemSave := -1;
  if lstAction.SelCount > 0 then
  begin
    for i := 0 to lstAction.Count - 1 do
    begin
      if lstAction.Selected[i] then
      begin
        LAction := TContainedAction(TStringList(lstCategory.Items.Objects[lstCategory.ItemIndex]).Objects[i]);
        LAction.RemoveFreeNotification(Self);
        TStringList(lstCategory.Items.Objects[lstCategory.ItemIndex]).Delete(i);
        THackLMDActionList(FActionList).RemoveAction(LAction);
        LAction.Free;
        if TStringList(lstCategory.Items.Objects[lstCategory.ItemIndex]).Count = 0 then
          if lstCategory.ItemIndex <> 0 then
          begin
            lstCategory.Items.Delete(lstCategory.ItemIndex);
            lstCategory.ItemIndex := 0;
          end;
      end
      else
        if LItemSave = -1 then
          LItemSave := i;
    end;
    UpdateList;
    UpdateActionsState;
    lstAction.Selected[LItemSave] := True;
  end;
end;

procedure TfrmActionListEditor.actEditCopyExecute(Sender: TObject);
begin
  FDesigner.CopySelection;
end;

procedure TfrmActionListEditor.actEditCutExecute(Sender: TObject);
begin
  FDesigner.CutSelection;
end;

procedure TfrmActionListEditor.actEditPasteExecute(Sender: TObject);
begin
  if FDesigner.CanPaste then
    FDesigner.PasteSelection;
end;

procedure TfrmActionListEditor.ActionEnumarator(const Category: string;
  ActionClass: TBasicActionClass; Info: TLMDDataTag);
begin
  with (TObject(Info) as TfrmStdActionList) do
    AddStdAction(Category, FActionList.GetReplacedActionClass(ActionClass).ClassName, ActionClass);
end;

procedure TfrmActionListEditor.actMoveDownExecute(Sender: TObject);
var
  i: Integer;
  LItemSave: array of Boolean;
begin
  SetLength(LItemSave, lstAction.Count);
  if lstAction.SelCount > 0 then
  begin
    for i := 0 to lstAction.Count - 1 do
    begin
      if not LItemSave[i] then
        LItemSave[i] := False;
      if lstAction.Selected[i] then
      begin
        if i < lstAction.Count - 1 then
        begin
          TStringList(lstCategory.Items.Objects[lstCategory.ItemIndex]).Exchange(i, i + 1);
          LItemSave[i] := False;
          LItemSave[i + 1] := True;
        end
        else
          LItemSave[i] := True;
      end
    end;
    UpdateList;
    for i := 0 to Length(LItemSave) - 1 do
      lstAction.Selected[i] := LItemSave[i];
  end;
end;

procedure TfrmActionListEditor.actMoveUpExecute(Sender: TObject);
var
  i: Integer;
  LItemSave: array of Boolean;
begin
  SetLength(LItemSave, lstAction.Count);
  if lstAction.SelCount > 0 then
  begin
    for i := 0 to lstAction.Count - 1 do
    begin
      if lstAction.Selected[i] then
      begin
        if i >= 1 then
        begin
          TStringList(lstCategory.Items.Objects[lstCategory.ItemIndex]).Exchange(i, i - 1);
          LItemSave[i] := False;
          LItemSave[i - 1] := True;
        end
        else
          LItemSave[i] := True;
      end
      else
        LItemSave[i] := False;
    end;
    UpdateList;
    for i := 0 to Length(LItemSave) - 1 do
      lstAction.Selected[i] := LItemSave[i];
  end;
end;

procedure TfrmActionListEditor.actNewActionExecute(Sender: TObject);
begin
  AddNewAction(TAction, '');
end;

procedure TfrmActionListEditor.actNewStandardActionExecute(Sender: TObject);
begin
  frmStdActionList := TfrmStdActionList.Create(nil);
  try
    EnumRegisteredActions(ActionEnumarator, frmStdActionList);
    frmStdActionList.TreeView1.Selected := frmStdActionList.TreeView1.Items.GetFirstNode;
    if frmStdActionList.ShowModal = mrOk then
      if Assigned(frmStdActionList.TreeView1.Selected.Data) then
        AddNewAction(TBasicActionClass(frmStdActionList.TreeView1.Selected.Data), frmStdActionList.TreeView1.Selected.Parent.Text);
  finally
    frmStdActionList.Free;
  end;
end;

procedure TfrmActionListEditor.actSwitchToolbarExecute(Sender: TObject);
begin
  ToolBar1.Visible := not ToolBar1.Visible;
  actSwitchToolbar.Checked := ToolBar1.Visible;
end;

procedure TfrmActionListEditor.actTextLabelExecute(Sender: TObject);
begin
  ToolBar1.ShowCaptions := not ToolBar1.ShowCaptions;
  actTextLabel.Checked := ToolBar1.ShowCaptions;
end;

procedure TfrmActionListEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  i: Integer;
  LTemp: TObject;
begin
  for i := 0 to lstCategory.Items.Count - 1 do
  begin
    LTemp := lstCategory.Items.Objects[i];
    lstCategory.Items.Objects[i] := nil;
    LTemp.Free;
  end;
  lstCategory.Items.Clear;
  FActionList := nil;
  tmrUpdate.Enabled := False;
end;

procedure TfrmActionListEditor.FormShow(Sender: TObject);
begin
  lstCategory.Selected[0] := True;
  tmrUpdate.Enabled := True;
  UpdateList;
  UpdateActionsState;
end;

procedure TfrmActionListEditor.lstActionClick(Sender: TObject);
begin
  UpdateActionsState;
end;

procedure TfrmActionListEditor.lstActionKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  SelectAction;
end;

procedure TfrmActionListEditor.lstActionMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SelectAction;
end;

procedure TfrmActionListEditor.lstCategoryClick(Sender: TObject);
begin
  UpdateActionsState;
end;

procedure TfrmActionListEditor.lstCategoryKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  NotifyCategoryChange;
  UpdateActionsState;
end;

procedure TfrmActionListEditor.lstCategoryMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  NotifyCategoryChange;
  UpdateActionsState;
end;

procedure TfrmActionListEditor.UpdateList;
var
  i: Integer;
  LCategoryIdx: Integer;
  LCategory: string;
  LActionIdx: Integer;
begin
  if Assigned(FActionList) then
  begin
    for i := 0 to FActionList.ActionCount - 1 do
    begin
      LCategory := FActionList.Actions[i].Category;
      if LCategory = '' then
        LCategory := '(No Category)';
      LCategoryIdx := lstCategory.Items.IndexOf(LCategory);
      if LCategoryIdx < 0 then
      begin
        LCategoryIdx := lstCategory.Items.AddObject(LCategory, TStringList.Create);
      end;
      if not Assigned(lstCategory.Items.Objects[LCategoryIdx]) then
        lstCategory.Items.Objects[LCategoryIdx] := TStringList.Create;

      LActionIdx := TStringList(lstCategory.Items.Objects[LCategoryIdx]).IndexOfObject(FActionList.Actions[i]);
      if LActionIdx < 0 then
        TStringList(lstCategory.Items.Objects[LCategoryIdx]).AddObject(FActionList.Actions[i].Name, FActionList.Actions[i]);
      NotifyCategoryChange;
    end;
    if FActionList.ActionCount = 0 then
      NotifyCategoryChange;
  end;
end;

procedure TfrmActionListEditor.UpdateActionsState;
begin
  actMoveUp.Enabled := lstAction.SelCount > 0;
  actMoveDown.Enabled := lstAction.SelCount > 0;
  actDelete.Enabled := lstAction.SelCount > 0;
end;

function TfrmActionListEditor.UniqueActionName(LName: string): String;
var
  j: Integer;
  i: Integer;
begin
  Delete(LName, 1, 1);
  j := 1;
  i := 0;
  Result := LName + IntToStr(j);
  while i < FActionList.ActionCount do
  begin
    if FActionList.Actions[i].Name = Result then
    begin
      inc(j);
      Result := LName + IntToStr(j);
      i := 0;
    end
    else
      inc(i);
  end;
end;

procedure TfrmActionListEditor.AddNewAction(AClass: TBasicActionClass; const ACategory: String);
var
  LAction: TCustomAction;
  LTemp: TBasicAction;
begin
  LTemp := TCustomAction(CreateAction(FActionList, AClass));
  try
    LAction := TCustomAction(FDesigner.CreateComponent(FActionList.GetReplacedActionClass(AClass), FActionList, 0, 0, 0, 0));
    LAction.Assign(LTemp);
  finally
    LTemp.Free;
  end;
  LAction.Category := ACategory;
  LAction.Name := UniqueActionName(LAction.ClassName);
  LAction.FreeNotification(Self);
  FDesigner.Modified;

  with FindRootDesigner(FActionList) do
  Notification(LAction, opInsert);
  THackLMDActionList(FActionList).AddAction(LAction);
  UpdateList;
end;

procedure TfrmActionListEditor.SelectAction;
begin
  if lstAction.ItemIndex >= 0 then
    if Assigned(lstAction.Items.Objects[lstAction.ItemIndex]) then
      FDesigner.SelectComponent(TComponent(lstAction.Items.Objects[lstAction.ItemIndex]));
end;

procedure TfrmActionListEditor.tmrUpdateTimer(Sender: TObject);
var
  i: Integer;
  LIndex: Integer;
begin
  if Assigned(FActionList) then
  begin
    for i := 0 to FActionList.ActionCount - 1 do
    begin
      LIndex := lstAction.Items.IndexOfObject(FActionList.Actions[i]);
      if LIndex >= 0 then
      begin
        if FActionList.Actions[i].Name <> lstAction.Items[LIndex] then
        begin
          lstAction.Items.Strings[LIndex] := FActionList.Actions[i].Name;
          if lstCategory.ItemIndex >= 0 then
            TStringList(lstCategory.Items.Objects[lstCategory.ItemIndex]).Strings[LIndex];
        end;
      end;
    end;
  end;
end;

procedure TfrmActionListEditor.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  i: Integer;
  LIndex: Integer;
begin
  inherited;
  if (AComponent is TCustomAction) and (Operation = opRemove) then
  begin
    for i := 0 to lstCategory.Items.Count - 1 do
    begin
      LIndex := TStringList(lstCategory.Items.Objects[i]).IndexOfObject(AComponent);
      if LIndex >= 0 then
        TStringList(lstCategory.Items.Objects[i]).Delete(LIndex);
    end;
    UpdateList;
  end;
end;

procedure TfrmActionListEditor.NotifyCategoryChange;
begin
  if lstCategory.ItemIndex >= 0 then
    if Assigned(lstCategory.Items.Objects[lstCategory.ItemIndex]) then
    begin
      lstAction.Items.Clear;
      lstAction.Items.Assign(TStrings(lstCategory.Items.Objects[lstCategory.ItemIndex]));
    end
    else
      lstAction.Items.Clear;
end;

end.
