unit LMDSedKeyBindingsDialog;
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

LMDSedKeyBindingsDialog unit (VT)
---------------------
This unit contains the editor view related classes for LMD-Tools Syntax Edit
packages.

Changes
-------
Release 8.0 (August 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, LMDTypes, LMDSedUtils, LMDSedView,
  LMDArrayUtils;

type

  {********************************* TLMDSedKeyBindingsDlg ********************}

  TLMDSedKeyBindingsDlg = class(TForm)
    trCommands: TTreeView;
    Splitter1: TSplitter;
    Panel1: TPanel;
    lbCurrentBinding: TLabel;
    lbNewBinding: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    lsBindings: TListBox;
    btnDeleteBinding: TButton;
    btnAddBinding: TButton;
    edCurrentBinding: TEdit;
    btnClearBinding: TButton;
    btnResetDefault: TButton;
    btnResetAll: TButton;
    procedure FormCreate(Sender: TObject);
    procedure trCommandsChange(Sender: TObject; Node: TTreeNode);
    procedure edCurrentBindingKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCurrentBindingKeyPress(Sender: TObject; var Key: Char);
    procedure btnClearBindingClick(Sender: TObject);
    procedure lsBindingsClick(Sender: TObject);
    procedure btnAddBindingClick(Sender: TObject);
    procedure btnDeleteBindingClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnResetDefaultClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lsBindingsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnResetAllClick(Sender: TObject);
  private
    FCurrentSc: TShortCut;
    FCurrentSc2: TShortCut;

    FSrt: array of TLMDEditCommandItem;
    FCurrentSortData: TObject;
    FView: TLMDCustomEditView;

    function CommandSortOps(AIdx1, AIdx2: Integer; AOp: TLMDArrayOperation): Integer;
    function BindingsSortOps(AIdx1, AIdx2: Integer; AOp: TLMDArrayOperation): Integer;

    procedure EnableButtons;
    procedure StrToShortcuts(const AStr: TLMDString;
                             out ASc, ASc2: TShortCut);
    function  ShortcutsToStr(ASc, ASc2: TShortCut): TLMDString;
    procedure DeleteCurrentBinding;
    procedure ClearCurrentBinding;
    procedure UpdateNodeStatus;
    procedure FillTree;
    procedure SaveKeyBindings;
    function ShowView(AView: TLMDCustomEditView): TModalResult;

    
    procedure CMDialogKey(var Msg: TWMKey); message CM_DIALOGKEY;

  public
    { Public declarations }
  end;

var
  LMDSedMappingsDlg: TLMDSedKeyBindingsDlg;

function LMDEditExecKeyBindingsDialog(AView: TLMDCustomEditView): Boolean;

implementation

uses LMDSedConst, LMDStrings, Menus, Math;

{$R *.dfm}

type

{******************************* TNodeBinding *********************************}

TNodeBinding = class
public
  Shortcut: TShortCut;
  Shortcut2: TShortCut;

  constructor Create(ASc, ASc2: TShortCut);
  function    Equals(AOther: TNodeBinding): Boolean; {$IFDEF LMDCOMP12}reintroduce; {$ENDIF}
end;

TNodeBindingArray = array of TNodeBinding;

{******************************* TNodeData ************************************}

TNodeData = class
public
  Bindings: TNodeBindingArray;
  Command:  TLMDEditCommand;
  Descr:    TLMDString;
  Modes:    TLMDEditCommandModes;

  procedure AddBinding(ABinding: TNodeBinding);
  procedure RemoveBinding(ABinding: TNodeBinding); overload;
  procedure RemoveBinding(ASc, ASc2: TShortCut); overload;
  procedure RemoveOvrBindings(ASc, ASc2: TShortCut);
  function  FindBinding(ASc, ASc2: TShortCut): TNodeBinding;
  function  HasBinding(ASc, ASc2: TShortCut): Boolean; overload;
  function  HasBinding(ASc: TShortCut): Boolean; overload;
  procedure ClearBindings;

  destructor Destroy; override;

end;

TNodeDataArray = array of TNodeData;

{------------------------------------------------------------------------------}

procedure SortBindings(ADlg: TLMDSedKeyBindingsDlg;
                       AData: TNodeData);
begin
  ADlg.FCurrentSortData := AData;
  if Length(AData.Bindings)<>0 then
    LMDArrayShortSort(0, Length(AData.Bindings)-1, ADlg.BindingsSortOps);
end;

{------------------------------------------------------------------------------}

procedure GetDefaultBindings(ADlg: TLMDSedKeyBindingsDlg;
                             AData: TNodeData);
var
    Def: TLMDEditCommandItem;
    B: TLMDEditCommandBinding;
    i: Integer;
begin
  Assert(AData<>nil);

  AData.ClearBindings;

  Def := ADlg.FView.GetDefaultKeyBindings.FindCommand(AData.Command);

  for i := 0 to Def.Bindings.Count - 1 do
  begin
    B := Def.Bindings[i];
    AData.AddBinding(TNodeBinding.Create(B.Shortcut, B.Shortcut2));
  end;

  SortBindings(ADlg, AData);
end;

{------------------------------------------------------------------------------}

function  IsBindingOverriden(ABind: TNodeBinding;
                             ASc, ASc2: TShortCut): Boolean;
begin
  Result := ((ABind.Shortcut=ASc) and (ABind.Shortcut2=ASc2)) or
            ((ABind.Shortcut=ASc) and (ABind.Shortcut2=0)) or
            ((ABind.Shortcut=ASc) and (ASc2=0));
end;

{------------------------------------------------------------------------------}

function  FindOverrideNodes(ADlg: TLMDSedKeyBindingsDlg;
                            AModes: TLMDEditCommandModes;
                            ASc, ASc2: TShortCut): TNodeDataArray;
var
    i, j, l: Integer;
    Data: TNodeData;
begin
  Setlength(Result, 0);

  for i := 0 to ADlg.trCommands.Items.Count - 1 do
    for j := 0 to ADlg.trCommands.Items[i].Count - 1 do
    begin
      Data := TNodeData(ADlg.trCommands.Items[i][j].Data);

      if (Data.HasBinding(ASc, ASc2) or
          ((ASc2=0) and Data.HasBinding(ASc)) or
          Data.HasBinding(ASc, 0)) and
         ((Data.Modes * AModes) <> [])
      then
      begin
        l := Length(Result);
        SetLength(Result, l+1);
        Result[l] := Data;
      end;
    end;
end;

{------------------------------------------------------------------------------}

procedure NodesDataToStrings(const ANodes: TNodeDataArray;
                             AStrs: TLMDMemoryStrings;
                             ADoClear: Boolean);
var
    i: Integer;
begin
  if ADoClear then
    AStrs.Clear;

  for i := 0 to Length(ANodes) - 1 do
    AStrs.Add(ANodes[i].Descr);
end;

{------------------------------------------------------------------------------}

procedure UniqueStrings(AStrs: TLMDMemoryStrings);
var
    i: Integer;
begin
  AStrs.Sort;

  i := 0;
  while i<AStrs.Count-1 do
  begin
    if AStrs[i+1]=AStrs[i] then
      AStrs.Delete(i+1)
    else
      Inc(i);
  end;
end;

{------------------------------------------------------------------------------}

function LMDEditExecKeyBindingsDialog(AView: TLMDCustomEditView): Boolean;
var
    Dlg: TLMDSedKeyBindingsDlg;
begin
  Dlg := TLMDSedKeyBindingsDlg.Create(nil);
  try
    Result := Dlg.ShowView(AView)=mrOk;
  finally
    Dlg.Free;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDSedKeyBindingsDlg.ShortcutsToStr(ASc,
                                                ASc2: TShortCut): TLMDString;
begin
  if ASc2=0 then
    Result := ShortcutToText(ASc)
  else
    Result := ShortcutToText(ASc)+', '+ShortcutToText(ASc2);
end;

{------------------------------------------------------------------------------}

function TLMDSedKeyBindingsDlg.BindingsSortOps(AIdx1, AIdx2: Integer;
  AOp: TLMDArrayOperation): Integer;
var
    Data: TNodeData;
    tmp: TNodeBinding;
    S1, S2: TLMDString;
begin
  Data := TNodeData(FCurrentSortData);

  Result := -1;

  case AOp of
    aoCompare:
    begin
      S1 := ShortcutsToStr(Data.Bindings[AIdx1].Shortcut,
                           Data.Bindings[AIdx1].Shortcut2);

      S2 := ShortcutsToStr(Data.Bindings[AIdx2].Shortcut,
                           Data.Bindings[AIdx2].Shortcut2);

      Result := LMDCompareStr(S1, S2);
    end;

    aoSwap:
    begin
      tmp := Data.Bindings[AIdx1];
      Data.Bindings[AIdx1] := Data.Bindings[AIdx2];
      Data.Bindings[AIdx2] := tmp;
    end;

    aoGetSize: Result := Length(Data.Bindings);

    aoAssign,
    aoSetSize: Assert(false);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedKeyBindingsDlg.btnAddBindingClick(Sender: TObject);
var
    Sc, Sc2: TShortCut;
    DataOvr: TNodeDataArray;
    Data: TNodeData;
    Mr: TModalResult;
    i: Integer;
    Descrs: TLMDMemoryStrings;
begin
  SetLength(DataOvr, 0);
  Descrs := TLMDMemoryStrings.Create;

  try
    if LMDTrim(edCurrentBinding.Text)<>'' then
    begin
      Assert(trCommands.Selected<>nil);
      Assert(trCommands.Selected.Data<>nil);

      Data := TNodeData( trCommands.Selected.Data );

      StrToShortcuts(edCurrentBinding.Text, Sc, Sc2);

      DataOvr := FindOverrideNodes(self, Data.Modes, Sc, Sc2);

      if Length(DataOvr)<>0 then
      begin
        NodesDataToStrings(DataOvr, Descrs, true);

        Mr := MessageDlg(Format(SLMDSedKeyDlgReplaceBinding,
                         [edCurrentBinding.Text, Descrs.Text]),
                         mtConfirmation, [mbYes, mbNo], -1);

        if Mr=mrNo then
          Exit
        else
        begin
          for i := 0 to Length(DataOvr) - 1 do
            DataOvr[i].RemoveOvrBindings(Sc, Sc2);
        end;
      end;

      Data.AddBinding(TNodeBinding.Create(Sc, Sc2));
      UpdateNodeStatus;
    end;

    EnableButtons;

  finally
    Descrs.Free;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedKeyBindingsDlg.btnClearBindingClick(Sender: TObject);
begin
  ClearCurrentBinding;
  EnableButtons;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedKeyBindingsDlg.btnDeleteBindingClick(Sender: TObject);
begin
  DeleteCurrentBinding;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedKeyBindingsDlg.btnOkClick(Sender: TObject);
begin
  SaveKeyBindings;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedKeyBindingsDlg.btnResetAllClick(Sender: TObject);
var
    i, j: Integer;
    Data: TNodeData;
begin
  for i := 0 to trCommands.Items.Count - 1 do
    for j := 0 to trCommands.Items[i].Count - 1 do
    begin
      Data := TNodeData(trCommands.Items[i][j].Data);
      GetDefaultBindings(self, Data);
    end;

  UpdateNodeStatus;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedKeyBindingsDlg.btnResetDefaultClick(Sender: TObject);
var
    Data: TNodeData;
    DataOvr: TNodeDataArray;
    Descrs: TLMDMemoryStrings;
    i, j: Integer;
    Def: TLMDEditCommandItem;
    Mr: TModalResult;
begin
  SetLength(DataOvr, 0);
  Descrs := TLMDMemoryStrings.Create;
  try
    Data := TNodeData(trCommands.Selected.Data);
    Def := FView.GetDefaultKeyBindings.FindCommand(Data.Command);

    for i := 0 to Def.Bindings.Count - 1 do
    begin
      with Def.Bindings[i] do
        DataOvr := FindOverrideNodes(self, Data.Modes, Shortcut, Shortcut2);

      NodesDataToStrings(DataOvr, Descrs, false);
    end;

    UniqueStrings(Descrs);
    Assert(Descrs.Count>0);

    if (Descrs.Count>1) or
       ((Descrs.Count=1) and (Descrs[0]<>Data.Descr))
    then
    begin
      Mr := MessageDlg(Format(SLMDSedKeyDlgResetAlert, [Descrs.Text]),
                       mtConfirmation, [mbYes, mbNo], -1);

      if Mr=mrNo then
        Exit
      else
      begin
        for i := 0 to Def.Bindings.Count - 1 do
        begin
          with Def.Bindings[i] do
          begin
            DataOvr := FindOverrideNodes(self, Def.Modes, Shortcut, Shortcut2);

            for j := 0 to Length(DataOvr) - 1 do
              DataOvr[j].RemoveOvrBindings(Shortcut, Shortcut2);
          end;
        end;
      end;
    end;

    Data.ClearBindings;
    GetDefaultBindings(self, Data);
  finally
    Descrs.Free;
  end;

  UpdateNodeStatus;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedKeyBindingsDlg.ClearCurrentBinding;
begin
  FCurrentSc := 0;
  FCurrentSc2 := 0;
  edCurrentBinding.Text := '';
end;

procedure TLMDSedKeyBindingsDlg.CMDialogKey(var Msg: TWMKey);
begin
  if (ActiveControl = edCurrentBinding) and (Msg.Charcode = VK_TAB)
  then
    edCurrentBinding.Text := LMDTab
  else
    inherited;
end;

{------------------------------------------------------------------------------}

function TLMDSedKeyBindingsDlg.CommandSortOps(AIdx1, AIdx2: Integer;
  AOp: TLMDArrayOperation): Integer;
var
  tmp: TLMDEditCommandItem;
begin
  Result := -1;

  case AOp of
    aoCompare:
    begin
      Result := LMDCompareStr(FSrt[AIdx1].Category, FSrt[AIdx2].Category);
      if Result=0 then
        Result := LMDCompareStr(FSrt[AIdx1].Description, FSrt[AIdx2].Description);
    end;

    aoSwap:
    begin
      tmp := FSrt[AIdx1];
      FSrt[AIdx1] := FSrt[AIdx2];
      FSrt[AIdx2] := tmp;
    end;

    aoGetSize: Result := Length(FSrt);

    aoAssign,
    aoSetSize: Assert(false);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedKeyBindingsDlg.DeleteCurrentBinding;
var
    Data: TNodeData;
    Sc, Sc2: TShortCut;
    Idx: Integer;
    B: TNodeBinding;
begin
  if lsBindings.ItemIndex=-1 then
    Exit;

  Assert(trCommands.Selected<>nil);
  Assert(trCommands.Selected.Data<>nil);

  Data := TNodeData( trCommands.Selected.Data );

  Idx := lsBindings.ItemIndex;

  StrToShortcuts(lsBindings.Items[Idx], Sc, Sc2);

  B := Data.FindBinding(Sc, Sc2);
  Assert(B<>nil);

  Data.RemoveBinding(B);
  UpdateNodeStatus;

  if lsBindings.Items.Count<>0 then
    lsBindings.ItemIndex := Min(lsBindings.Items.Count-1, Idx);

  EnableButtons;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedKeyBindingsDlg.edCurrentBindingKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
    S: TLMDString;
    Sc: TShortCut;
begin
  Sc := ShortCut(Key, Shift);

  if (Key<>VK_LSHIFT) and (Key<>VK_RSHIFT) and
     (Key<>VK_LCONTROL) and (Key<>VK_RCONTROL) and
     (Key<>VK_SHIFT) and (Key<>VK_CONTROL) and
     (Key<>VK_MENU)
  then
  begin
    S := ShortCutToText(Sc);

    if FCurrentSc=0 then
    begin
      edCurrentBinding.Text := S;
      FCurrentSc := Sc;
    end
    else if FCurrentSc2=0 then
    begin
      edCurrentBinding.Text := ShortCutToText(FCurrentSc) + ', ' + S;
      FCurrentSc2 := Sc;
    end
    else
    begin
      edCurrentBinding.Text := S;
      FCurrentSc2 := 0;
      FCurrentSc := Sc;
    end;
  end;

  edCurrentBinding.SelStart := Length(edCurrentBinding.Text);
  edCurrentBinding.SelLength := 0;

  Key := 0;

  EnableButtons;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedKeyBindingsDlg.edCurrentBindingKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := #0;
  EnableButtons;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedKeyBindingsDlg.EnableButtons;
var
    Node: TTreeNode;
begin
  Node := trCommands.Selected;
  if (Node<>nil) and (Node.Parent<>nil) then
  begin
    lsBindings.Enabled := true;

    btnAddBinding.Enabled := Length(LMDTrim(edCurrentBinding.Text))<>0;
    btnClearBinding.Enabled := btnAddBinding.Enabled;

    btnDeleteBinding.Enabled := lsBindings.ItemIndex<>-1;

    edCurrentBinding.Enabled := true;
    btnResetDefault.Enabled := true;
  end
  else
  begin
    lsBindings.Enabled := false;

    btnDeleteBinding.Enabled := false;
    btnAddBinding.Enabled := false;
    btnClearBinding.Enabled := false;
    btnResetDefault.Enabled := false;
    edCurrentBinding.Enabled := false;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedKeyBindingsDlg.FillTree;

const EditModes = [cmForView, cmForIncSearch];

var
    Cmds: TLMDEditCommandList;
    i, j, Cnt: Integer;
    CatNode: TTreeNode;
    Node: TTreeNode;
    Cat: TLMDString;
    Data: TNodeData;
    Bind: TNodeBinding;
    Item: TLMDEditCommandItem;
    IsCust, AddIt: Boolean;
    B: TLMDEditCommandBinding;
begin
  Cmds := FView.GetDefaultKeyBindings;

  Cnt := 0;
  for i := 0 to Cmds.Count - 1 do
  begin
    if Cmds[i].Editable and ((Cmds[i].Modes * EditModes) <> []) then
      Inc(Cnt);
  end;

  SetLength(FSrt, Cnt);

  j := 0;
  for i := 0 to Cmds.Count - 1 do
  begin
    if Cmds[i].Editable and ((Cmds[i].Modes * EditModes) <> [])  then
    begin
      Item := FView.CustomKeyBindings.FindCommand(Cmds[i].Command);

      if Item = nil then
        FSrt[j] := Cmds[i]
      else
        FSrt[j] := Item;

      Inc(j);
    end;
  end;

  LMDArrayShortSort(0, Length(FSrt)-1, CommandSortOps);

  trCommands.Items.Clear;

  Cat := '';
  CatNode := nil;

  for i := 0 to Length(FSrt) - 1 do
  begin
    if FSrt[i].Category <> Cat then
    begin
      Cat := FSrt[i].Category;
      CatNode := trCommands.Items.AddChild(nil, Cat);
      CatNode.Data := nil;
    end;

    trCommands.Items.AddChild(CatNode, FSrt[i].Description);

    Node := CatNode.GetLastChild;
    Data := TNodeData(Node.Data);
    if Data = nil then
    begin
      Data := TNodeData.Create;
      Data.ClearBindings;
      Data.Command := FSrt[i].Command;
      Data.Descr := FSrt[i].Description;
      Data.Modes := FSrt[i].Modes;

      Node.Data := Data;
    end;

    for j := 0 to FSrt[i].Bindings.Count - 1 do
    begin
      B := FSrt[i].Bindings[j];

      IsCust := FSrt[i].Collection = FView.CustomKeyBindings;

      if not IsCust then
      begin
        AddIt := FView.CustomKeyBindings.FindBinding(B.Shortcut, 0, EditModes) = nil;
        if AddIt then
          AddIt := FView.CustomKeyBindings.FindBinding(B.Shortcut, B.Shortcut2, EditModes) = nil;

        if AddIt then
        begin
          if B.Shortcut2=0 then
            AddIt := FView.CustomKeyBindings.FindBinding(B.Shortcut, EditModes) = nil;
        end;
      end
      else
        AddIt := true;

      if AddIt then
      begin
        Bind := TNodeBinding.Create(B.Shortcut, B.Shortcut2);

        Data.AddBinding(Bind);
        Data.Modes := Data.Modes + FSrt[i].Modes;
      end;
    end;

    SortBindings(self, Data);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedKeyBindingsDlg.FormCreate(Sender: TObject);
begin
  LMDGetDialogFont(Font);

  Caption := SLMDSedKeyDlgCaption;

  btnCancel.Caption := SLMDSedKeyDlgCancel;
  btnOk.Caption := SLMDSedKeyDlgOk;
  btnDeleteBinding.Caption := SLMDSedKeyDlgDeleteBinding;
  btnResetDefault.Caption := SLMDSedKeyDlgResetBinding;
  btnAddBinding.Caption := SLMDSedKeyDlgAddBinding;
  btnClearBinding.Caption := SLMDSedKeyDlgClearBinding;
  btnResetAll.Caption := SLMDSedKeyDlgResetAllBinding;

  FCurrentSc := 0;
  FCurrentSc2 := 0;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedKeyBindingsDlg.FormDestroy(Sender: TObject);
var
    i, j: Integer;
    Data: TNodeData;
begin
  for i := 0 to trCommands.Items.Count - 1 do
    for j := 0 to trCommands.Items[i].Count - 1 do
    begin
      Data := TNodeData(trCommands.Items[i][j].Data);
      Data.Free;
      trCommands.Items[i][j].Data := nil;
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedKeyBindingsDlg.lsBindingsClick(Sender: TObject);
begin
  EnableButtons;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedKeyBindingsDlg.lsBindingsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (lsBindings.ItemIndex<>-1) and
     ( (Key=VK_DELETE) or (Key=VK_BACK) )
  then
    DeleteCurrentBinding;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedKeyBindingsDlg.SaveKeyBindings;
var
    i, j, k: Integer;
    Data: TNodeData;
    Item: TLMDEditCommandItem;
    Bind: TLMDEditCommandBinding;
    B: TNodeBinding;
    DefData: TNodeData;
    BindEquals: Boolean;
begin
  DefData := TNodeData.Create;
  FView.CustomKeyBindings.BeginUpdate;

  FView.CustomKeyBindings.Clear;
  try
    for i := 0 to trCommands.Items.Count - 1 do
      for j := 0 to trCommands.Items[i].Count - 1 do
      begin
        Data := TNodeData(trCommands.Items[i][j].Data);
        SortBindings(self, Data);

        DefData.Command := Data.Command;
        DefData.ClearBindings;
        GetDefaultBindings(self, DefData);

        BindEquals := Length(Data.Bindings)=Length(DefData.Bindings);

        if BindEquals then
          for k := 0 to Length(Data.Bindings) - 1 do
            if not DefData.Bindings[k].Equals(Data.Bindings[k]) then
            begin
              BindEquals := false;
              Break;
            end;

        if not BindEquals then
        begin
          Item := FView.CustomKeyBindings.Add;
          Item.Command := Data.Command;
          Item.Modes := Data.Modes;

          for k := 0 to Length(Data.Bindings) - 1 do
          begin
            B := Data.Bindings[k];

            Bind := Item.Bindings.Add;
            Bind.Shortcut := B.Shortcut;
            Bind.Shortcut2 := B.Shortcut2;
          end;
        end;
      end;
  finally
    FView.CustomKeyBindings.EndUpdate;
    DefData.Free;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDSedKeyBindingsDlg.ShowView(AView: TLMDCustomEditView): TModalResult;
begin
  Assert(AView<>nil);

  FView := AView;

  FillTree;

  ShowModal;

  if ModalResult=mrOk then
    SaveKeyBindings;

  Result := ModalResult;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedKeyBindingsDlg.StrToShortcuts(const AStr: TLMDString;
                                               out ASc, ASc2: TShortCut);
var
    Cln: Integer;
begin
  Cln := LMDPosEx(',', AStr, 1);

  ASc2 := 0;
  if Cln<>0 then
  begin
    ASc := TextToShortCut( LMDTrim(Copy(AStr, 1, Cln-1)) );
    ASc2 := TextToShortCut( LMDTrim(Copy(AStr, Cln+1, Length(AStr)-Cln)) );
  end
  else
    ASc := TextToShortCut( LMDTrim(Copy(AStr, 0, Length(AStr))) );
end;

{------------------------------------------------------------------------------}

procedure TLMDSedKeyBindingsDlg.trCommandsChange(Sender: TObject;
  Node: TTreeNode);
begin
  UpdateNodeStatus;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedKeyBindingsDlg.UpdateNodeStatus;
var
    Node: TTreeNode;
    Data: TNodeData;
    i: Integer;
begin
  Node := trCommands.Selected;
  if (Node<>nil) and (Node.Parent<>nil) then
  begin
    Data := TNodeData(Node.Data);

    lsBindings.Items.Clear;

    for i := 0 to Length(Data.Bindings) - 1 do
    begin
      lsBindings.Items.Add(ShortcutsToStr(
                           Data.Bindings[i].Shortcut,
                           Data.Bindings[i].Shortcut2));
    end;
  end
  else
    lsBindings.Items.Clear;

  edCurrentBinding.Text := '';
  FCurrentSc := 0;
  FCurrentSc2 := 0;

  EnableButtons;
end;

{------------------------------------------------------------------------------}

procedure TNodeData.AddBinding(ABinding: TNodeBinding);
begin
  SetLength(Bindings, Length(Bindings)+1);
  Bindings[Length(Bindings)-1] := ABinding;
end;

{------------------------------------------------------------------------------}

procedure TNodeData.ClearBindings;
var
    i: Integer;
begin
  for i := 0 to Length(Bindings) - 1 do
    Bindings[i].Free;

  SetLength(Bindings, 0);
end;

{------------------------------------------------------------------------------}

destructor TNodeData.Destroy;
begin
  ClearBindings;
end;

{------------------------------------------------------------------------------}

function TNodeData.FindBinding(ASc, ASc2: TShortCut): TNodeBinding;
var
    i: Integer;
begin
  Result := nil;

  for i := 0 to Length(Bindings) - 1 do
    if (ASc=Bindings[i].Shortcut) and (ASc2=Bindings[i].Shortcut2) then
    begin
      Result := Bindings[i];
      Break;
    end;
end;

{------------------------------------------------------------------------------}

function TNodeData.HasBinding(ASc, ASc2: TShortCut): Boolean;
begin
  Result := FindBinding(ASc, ASc2)<>nil;
end;

{------------------------------------------------------------------------------}

function  TNodeData.HasBinding(ASc: TShortCut): Boolean;
var
    i: Integer;
begin
  Result := false;

  for i := 0 to Length(Bindings) - 1 do
    if ASc=Bindings[i].Shortcut then
    begin
      Result := true;
      Break;
    end;
end;

{------------------------------------------------------------------------------}

procedure TNodeData.RemoveBinding(ASc, ASc2: TShortCut);
var
    B: TNodeBinding;
begin
  B := FindBinding(ASc, ASc2);
  Assert(B<>nil);

  RemoveBinding(B);
end;

{------------------------------------------------------------------------------}

procedure TNodeData.RemoveOvrBindings(ASc, ASc2: TShortCut);
var
    i, j: Integer;
    NewBinds: TNodeBindingArray;
begin
  j := 0;
  SetLength(NewBinds, Length(Bindings));

  for i := 0 to Length(Bindings) - 1 do
  begin
    if not IsBindingOverriden(Bindings[i], ASc, ASc2) then
    begin
      NewBinds[j] := Bindings[i];
      Inc(j);
    end
    else
      Bindings[i].Free;
  end;

  Bindings := Copy(NewBinds, 0, j);
end;

{------------------------------------------------------------------------------}

procedure TNodeData.RemoveBinding(ABinding: TNodeBinding);
var
    i: Integer;
begin
  i := 0;
  while i<Length(Bindings) do
  begin
    if Bindings[i]=ABinding then
      Break;

    Inc(i);
  end;

  Assert(i<Length(Bindings));

  Bindings[i].Free;

  while i<Length(Bindings)-1 do
  begin
    Bindings[i] := Bindings[i+1];

    Inc(i);
  end;

  SetLength(Bindings, i);
end;

{------------------------------------------------------------------------------}

constructor TNodeBinding.Create(ASc, ASc2: TShortCut);
begin
  inherited Create;
  
  Shortcut := ASc;
  Shortcut2 := ASc2;
end;

{------------------------------------------------------------------------------}

function TNodeBinding.Equals(AOther: TNodeBinding): Boolean;
begin
  Result := (Shortcut=AOther.Shortcut) and (Shortcut2=AOther.Shortcut2);
end;

end.
