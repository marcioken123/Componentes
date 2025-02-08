unit LMDRVEFormUnit;
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

LMDRVEFormUnit unit (DD)
-----------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, Menus, ImgList, LMDYParser, LMDBaseRefine,
  LMDREFINELEX, LMDREFINEPARSER, Buttons, LMDSearchConsts
  ;

const
  T_OR   = 0;
  T_AND  = 1;
  T_NEAR = 2;

type
  TOnLMDRVEChange = procedure(Sender: TObject; szText: String) of object;

  TLMDRVEForm = class(TForm)
    PageControl: TPageControl;
    VESheet: TTabSheet;
    OptionsPage: TTabSheet;
    Panel: TPanel;
    VETree: TTreeView;
    TreeImageList: TImageList;
    OperatorMenu: TPopupMenu;
    AND1: TMenuItem;
    OR1: TMenuItem;
    NEAR1: TMenuItem;
    UpdateTimer: TTimer;
    BottomPanel: TPanel;
    Pages: TNotebook;
    Label1: TLabel;
    WordEdit: TEdit;
    AddButton: TSpeedButton;
    NOTCheckBox: TCheckBox;
    ANDRadio: TRadioButton;
    ORRadio: TRadioButton;
    NEARRadio: TRadioButton;
    AddOperatorBtn: TSpeedButton;
    DelBtn: TSpeedButton;
    GroupBtn: TSpeedButton;
    UngroupBtn: TSpeedButton;
    SearchMemo: TMemo;
    OpenBBtn: TBitBtn;
    CloseBBtn: TBitBtn;
    AsteriskButton: TBitBtn;
    QuestButton: TBitBtn;
    NearBtn: TBitBtn;
    NotBtn: TBitBtn;
    OrBtn: TBitBtn;
    AndBtn: TBitBtn;
    EvaluateButton: TBitBtn;
    CancelButton: TBitBtn;
    OKButton: TBitBtn;
    MCCheck: TCheckBox;
    WWCheck: TCheckBox;
    HelpButton: TBitBtn;
    procedure FormDeactivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NEARRadio1Click(Sender: TObject);
    procedure AddOperatorBtn1Click(Sender: TObject);
    procedure VETreeChange(Sender: TObject; Node: TTreeNode);
    procedure VETreeEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure VETreeEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure AND1Click(Sender: TObject);
    procedure VETreeGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure VETreeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UpdateTimerTimer(Sender: TObject);
    procedure SearchMemo1Change(Sender: TObject);
    procedure WordEditChange(Sender: TObject);
    procedure WordEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AddButtonClick(Sender: TObject);
    procedure NEARRadioClick(Sender: TObject);
    procedure AddOperatorBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure GroupBtnClick(Sender: TObject);
    procedure UngroupBtnClick(Sender: TObject);
    procedure SearchMemoChange(Sender: TObject);
    procedure OpenBBtnClick(Sender: TObject);
    procedure CloseBBtnClick(Sender: TObject);
    procedure AsteriskButtonClick(Sender: TObject);
    procedure QuestButtonClick(Sender: TObject);
    procedure AndBtnClick(Sender: TObject);
    procedure OrBtnClick(Sender: TObject);
    procedure NotBtnClick(Sender: TObject);
    procedure NearBtnClick(Sender: TObject);
    procedure EvaluateButtonClick(Sender: TObject);
  private
    FSimpleInterface: Boolean;
    FOnChangeSearchString: TOnLMDRVEChange;
    function  CheckSelected: Boolean;
    function  AddNewNode(Node: TTreeNode): TTreeNode;
    procedure SetOnChangeSearchString(const Value: TOnLMDRVEChange);
    procedure ChangedSS;
    procedure SetSimpleInterface(const Value: Boolean);
    protected
    procedure BuildTree(Code: TSegment);
    function  CheckForNearParam(Node: TTreeNode): Boolean;
    function  GetNOT(Node: TTreeNode): Boolean;
    function  GetTag(Node: TTreeNode): Integer;
    procedure SetTag(Node: TTreeNode; iTag: Integer);
    procedure SetNOT(Node: TTreeNode; b: Boolean);
    function  GetUITag: Integer;
    procedure AddSearchString(szAdd: String);
    public
    AnySingleCharacter, AnySequenceCharacter: Char;
    procedure UpdateBuilder;
    procedure UpdateOnShow;
    procedure UpdateBtn;
    function  BuildSearchString(Node: TTreeNode = nil; szOperator: String = 'AND'): String;
    function  BuildVE(szString: String): Boolean;
    procedure SetSearchString(szString: String);
    published
    property  SimpleInterface: Boolean read FSimpleInterface write SetSimpleInterface;
    property  OnChangeSearchString: TOnLMDRVEChange read FOnChangeSearchString write SetOnChangeSearchString;
  end;

implementation

{$R *.DFM}

uses
  LMDRefineUnit;

procedure TLMDRVEForm.FormDeactivate(Sender: TObject);
begin
//  Close;
end;

function TLMDRVEForm.CheckSelected: Boolean;
var
  i: Integer;
begin
  Result := VETree.SelectionCount >= 2;
  for i := 1 to VETree.SelectionCount - 1 do
    begin
      if (VETree.Selections[0].Parent <> VETree.Selections[i].Parent) then
        begin
          Result := False;
          break;
        end;
    end;
end;

function TLMDRVEForm.AddNewNode;
begin
  if Node<>nil then
  begin
    if Node.Parent<>nil then
      Result := VETree.Items.AddChild(Node.Parent,'')
    else
      Result := VETree.Items.Add(nil,'');
  end
  else
    Result := VETree.Items.Add(nil,'');
end;

procedure TLMDRVEForm.SetOnChangeSearchString(const Value: TOnLMDRVEChange);
begin
  FOnChangeSearchString := Value;
end;

procedure TLMDRVEForm.ChangedSS;
begin
  if Assigned(FOnChangeSearchString) then
    FOnChangeSearchString(Self, BuildSearchString);
end;

procedure TLMDRVEForm.SetSimpleInterface(const Value: Boolean);
begin
  FSimpleInterface := Value;
end;

procedure TLMDRVEForm.BuildTree(Code: TSegment);
var
  i,j : Integer;
  Stack : TSegment;
  szTmp : String;
  Node, Node1, Node2  : TTreeNode;
begin
  VETree.Items.Clear;
  Stack := TSegment.Create;
//  VETree.Items.BeginUpdate;
  try
    i := 0;
    while i<Code.Count do
    begin
      case Code.Codes[i] of
        C_CONST:
          begin
            Inc(i);
            szTmp := Code.Codes[i];
            Node  := VETree.Items.Add(nil,szTmp);
            Node.ImageIndex := 1;
            Node.SelectedIndex := 1;
            Node.StateIndex := Node.ImageIndex;
            Stack.AddCode(Integer(Pointer(Node)));
            end;
        C_OR,C_AND,C_NEAR:
          begin
            Node1 := TTreeNode(Pointer(Integer(Stack.Pop)));
            Node2 := TTreeNode(Pointer(Integer(Stack.Pop)));
            if (Node1<>nil) and (Node2<>nil) then
            begin
              Node  := VETree.Items.Add(nil,'');
              Node.ImageIndex := 2;
              Node.SelectedIndex := 2;
              Node.StateIndex := Node.ImageIndex;
              szTmp := '';
              j := 1;
              case Code.Codes[i] of
                C_OR : begin szTmp:='OR';j:=0; end;
                C_AND :szTmp:='AND';
                C_NEAR :begin szTmp:='NEAR';j:=2; end;
              end;
              Node.Data := Pointer(j);
              Node.Text := LMDSP_OPERATOR_S+' '+szTmp;
              if (Node2.ImageIndex in [2,4]) and (szTmp=Node2.Text) then
              begin
                while Node2.Count>0 do
                  Node2.Item[0].MoveTo(Node,naAddChild);
                  Node2.Free;
              end
              else
                Node2.MoveTo(Node,naAddChild);
                if (Node1.ImageIndex  in [2,4]) and (szTmp=Node1.Text) then
              begin
                while Node1.Count>0 do
                  Node1.Item[0].MoveTo(Node,naAddChild);
                  Node1.Free;
              end
              else
                Node1.MoveTo(Node,naAddChild);
                Stack.AddCode(Integer(Pointer(Node)));
              end;
          end;
        C_NOT:
          begin
            Node := TTreeNode(Pointer(Integer(Stack.Pop)));
            if (Node<>nil) then
            begin
              try
                SetNOT(Node,not GetNOT(Node));
              except
              end;
            end;
            Stack.AddCode(Integer(Pointer(Node)));
            end;
      end;
      inc(i);
    end;
  finally
//    VETree.Items.EndUpdate;
    Stack.Free;
  end;
end;

function TLMDRVEForm.CheckForNearParam(Node: TTreeNode): Boolean;
begin
  Result := Node.Parent <> nil;
  if Result then
  begin
    Result := (Node.Parent.ImageIndex in [2,4]) and
     (GetTag(Node.Parent) = T_NEAR);
  end;
end;

function TLMDRVEForm.GetNOT(Node: TTreeNode): Boolean;
begin
  Result := (Integer(Node.Data) and $8000)<>0;
  end;

function TLMDRVEForm.GetTag(Node: TTreeNode): Integer;
begin
  Result := Integer(Node.Data) and (not $8000);
  end;

procedure TLMDRVEForm.SetTag(Node: TTreeNode; iTag: Integer);
begin
  Node.Data := Pointer(iTag or (Integer(Node.Data) and $8000));
  end;

procedure TLMDRVEForm.SetNOT(Node: TTreeNode; b: Boolean);
begin
  if b then
  begin
    Node.Data := Pointer(Integer(Node.Data) or $8000);
  end
  else
  begin
    Node.Data := Pointer(Integer(Node.Data) and (not $8000));
  end;
  end;

function TLMDRVEForm.GetUITag: Integer;
begin
  if ANDRadio.Checked then
    Result := T_AND
  else
  if ORRadio.Checked then
    Result := T_OR
  else
    Result := T_NEAR;
end;

procedure TLMDRVEForm.UpdateBuilder;
begin
  ChangedSS;
  UpdateTimer.Enabled := false;
  UpdateTimer.Enabled := True;
  // RM
  if EvaluateButton.Visible then
    EvaluateButton.Enabled:=SearchMemo.Text<>'';
end;

procedure TLMDRVEForm.AddSearchString(szAdd: String);

begin
  SearchMemo.Text := SearchMemo.Text + szAdd;
  SearchMemo.SetFocus;
  SendMessage(SearchMemo.Handle, EM_SETSEL, Length(SearchMemo.Text), Length(SearchMemo.Text));
  UpdateBuilder;
end;

procedure TLMDRVEForm.UpdateOnShow;
begin
  if FSimpleInterface then
    Pages.ActivePage := 'SimplePage'
  else
    Pages.ActivePage := 'ExtPage';
  WordEdit.Text := '';
  SearchMemo.Text := '';
  VETree.Items.Clear;
  UpdateBtn;
end;

procedure TLMDRVEForm.UpdateBtn;
begin
  AddButton.Enabled := (WordEdit.Text<>'');
  DelBtn.Enabled := VETree.Selected<>nil;
  GroupBtn.Enabled := CheckSelected;
  AddOperatorBtn.Enabled := GroupBtn.Enabled;
  ANDRadio.Enabled := AddOperatorBtn.Enabled;
  ORRadio.Enabled := AddOperatorBtn.Enabled;
  NEARRadio.Enabled := AddOperatorBtn.Enabled;
  NOTCheckBox.Enabled := AddButton.Enabled;
  UngroupBtn.Enabled := (VETree.Selected<>nil) and ((VETree.Selected.ImageIndex=0) or ((VETree.Selected.Parent<>nil) and (VETree.Selected.Parent.ImageIndex=0)));
end;

function TLMDRVEForm.BuildSearchString;
var
  i : Integer;
  szTmp : String;
begin
  Result := '';
  if FSimpleInterface then
  begin
    Result := SearchMemo.Text;
    exit;
  end;

  if Node=nil then
  begin
    for i:=0 to VETree.Items.Count-1 do
    begin
      if VETree.Items[i].Parent<>nil then
        continue;
      szTmp := BuildSearchString(VETree.Items[i],szOperator);
      if szTmp='' then
        continue;
      if Result<>'' then
        Result := Result+' '+szOperator+' ';
      Result := Result+szTmp;
    end;
    if Length(Result)>0 then
    begin
      if (Result[1]='(') and (Result[Length(Result)]=')') then
        Result := Copy(Result,2,Length(Result)-2);
    end;
  end
  else
  begin
    case Node.ImageIndex of
      1,3:
        begin
          Result := Node.Text;
          if GetNOT(Node) and (Result<>'') then
            Result := 'NOT '+Result;
        end;
      0:
        begin
          for i:=0 to Node.Count-1 do
          begin
            szTmp := BuildSearchString(Node.Item[i],szOperator);
            if szTmp='' then
              continue;
            if Result<>'' then
              Result := Result+' '+szOperator+' ';
            Result := Result+szTmp;
          end;
          Result := '('+Result+')';
          if GetNOT(Node) then
            Result := 'NOT '+Result;
        end;
      2,4:
        begin
          szOperator := 'AND';
          case GetTag(Node) of
            T_OR : szOperator := 'OR';
            T_NEAR : szOperator := 'NEAR';
          end;
          if szOperator<>'NEAR' then
          begin
            for i:=0 to Node.Count-1 do
            begin
              szTmp := BuildSearchString(Node.Item[i],szOperator);
              if szTmp='' then
                continue;
              if Result<>'' then
                Result := Result+' '+szOperator+' ';
              Result := Result+szTmp;
            end;
          end
          else
            if Node.Count>=2 then
            begin
              Result := Node.Item[0].Text+' NEAR '+Node.Item[1].Text;
            end;
          if Result<>'' then
            Result := '('+Result+')';
          if GetNOT(Node) then
            Result := 'NOT '+Result;
        end;
    end;
  end;
end;

function TLMDRVEForm.BuildVE(szString: String): Boolean;

var
  FStream : TYVCLStream;
  RL : TLMDREFINELEXLex;
  RF : TLMDREFINEParser;
  c  : Char;
  i  : Integer;
begin
  FStream := TYVCLStream.Create;
  RL := TLMDREFINELEXLex.Create(FStream);
  RF := TLMDREFINEParser.Create(RL);
  try
    with FStream.aInStream do
    begin
      Clear;
      Seek(0, soFromBeginning);
      Write(szString[1], Length(szString) * SizeOf(Char));
      c := nl;
      Write(c, sizeof(Char));
      c := #0;
      Write(c, sizeof(Char));
      Write(c, sizeof(Char));
      Seek(0, soFromBeginning);
      end;
    i := RF.yyparse;
    Result := i=0;

    BuildTree(RF.Code);

  finally
    RF.Free;
    RL.Free;
    FStream.Free;
  end;

  UpdateBtn;
end;

procedure TLMDRVEForm.SetSearchString;
begin
  SearchMemo.Text := szString;
  BuildVE(szString);
end;

procedure TLMDRVEForm.FormCreate(Sender: TObject);
begin
  inherited;
  FSimpleInterface := True;
  Caption := LMDSP_RVEFormCaption;
  VESheet.Caption := LMDSP_RVEFormVESheetCaption;
  OptionsPage.Caption := LMDSP_RVEFormOptionsPageCaption;
  EvaluateButton.Caption := LMDSP_RVEFormEvaluateButtonCaption;
  CancelButton.Caption := LMDSP_RVEFormCancelButtonCaption;
  OKButton.Caption := LMDSP_RVEFormOKButtonCaption;
  HelpButton.Caption:=LMDSP_RVEFormHELPButtonCaption;
  MCCheck.Caption:=LMDSP_MatchCaseCheckBoxCaption;
  WWCheck.Caption:=LMDSP_MathWholeCheckBoxCaption;
  AnySingleCharacter := '?';
  AnySequenceCharacter := '*';
end;

procedure TLMDRVEForm.NEARRadio1Click(Sender: TObject);
begin
  UpdateBtn;
end;

procedure TLMDRVEForm.AddOperatorBtn1Click(Sender: TObject);
var
  Node : TTreeNode;
  szTmp : String;
  i     : Integer;
  List : TList;
  SN: TTreeNode;
begin
  if ANDRadio.Checked then
    szTmp := 'AND'
  else
  if ORRadio.Checked then
    szTmp := 'OR'
  else
    szTmp := 'NEAR';
  List := TList.Create;
  SN := nil;
  try
    for i:=0 to VETree.SelectionCount-1 do
      begin
        List.Add(VETree.Selections[i]);
      end;

    Node := AddNewNode(SN.Parent);
    Node.MoveTo(SN,naInsert);

//    Node := AddNewNode(VETree.Selected);
    Node.Text := LMDSP_OPERATOR_S+' '+szTmp;
    Node.ImageIndex := 2;
    Node.SelectedIndex := 2;
    Node.StateIndex := Node.ImageIndex;
    Node.Data := Pointer(GetUITag);
    for i:=0 to List.Count-1 do
    begin
      TTreeNode(List[i]).MoveTo(Node,naAddChild);
      end;
  finally
    List.Free;
  end;
  Node.Expand(True);
  UpdateBtn;
  ChangedSS;
end;

procedure TLMDRVEForm.VETreeChange(Sender: TObject; Node: TTreeNode);
begin
  UpdateBtn;
end;

procedure TLMDRVEForm.VETreeEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
var
  i, iTag : Integer;
begin
  AllowEdit := Node.ImageIndex in [1,3];
  if Node.ImageIndex in [2,4] then
    begin
      iTag := GetTag(Node);
      for i:=0 to OperatorMenu.Items.Count-1 do
        OperatorMenu.Items[i].Checked := OperatorMenu.Items[i].Tag =iTag;
      OperatorMenu.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
    end;
end;

procedure TLMDRVEForm.VETreeEdited(Sender: TObject; Node: TTreeNode; var S: String);
begin
  Node.Text := S;
  ChangedSS;
  VETree.Invalidate;
end;

procedure TLMDRVEForm.AND1Click(Sender: TObject);
var
  szOperator : String;
  begin
  if VETree.Selected<>nil then
  begin
    SetTag(VETree.Selected,TMenuItem(Sender).Tag);
    szOperator := 'AND';
    case Integer(TMenuItem(Sender).Tag) of
      T_OR : szOperator := 'OR';
      T_NEAR : szOperator := 'NEAR';
    end;
    VETree.Selected.Text := LMDSP_OPERATOR_S+' '+szOperator;
    ChangedSS;
  end;
end;

procedure TLMDRVEForm.VETreeGetImageIndex(Sender: TObject;
  Node: TTreeNode);
begin
  if GetNOT(Node) then
    Node.ImageIndex := Node.StateIndex+2
  else
    Node.ImageIndex := Node.StateIndex;
  Node.SelectedIndex := Node.ImageIndex;
end;

procedure TLMDRVEForm.VETreeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Node : TTreeNode;
begin
  if FSimpleInterface then exit;
  Node := VETree.GetNodeAt(X,Y);
  if (Node<>nil) and (Node.ImageIndex<>0) then
  begin
    if htOnIcon in VETree.GetHitTestInfoAt(X,Y) then
    begin
      SetNOT(node,not GetNot(Node));
//      VETreeGetImageIndex(VETree,Node);
//      VETree.Invalidate;
      ChangedSS;
    end;
  end;
end;

procedure TLMDRVEForm.UpdateTimerTimer(Sender: TObject);
begin
  UpdateTimer.Enabled := false;
  BuildVE(SearchMemo.Text);
end;

procedure TLMDRVEForm.SearchMemo1Change(Sender: TObject);
begin
  UpdateBuilder;
end;

procedure TLMDRVEForm.WordEditChange(Sender: TObject);
begin
  UpdateBtn;
end;

procedure TLMDRVEForm.WordEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=13 then
    AddButtonClick(Self);
end;

procedure TLMDRVEForm.AddButtonClick(Sender: TObject);
var
  Node : TTreeNode;
begin
  if VETree.Selected<>nil then
  begin
    if VETree.Selected.ImageIndex in [2,4] then
      Node := VETree.Items.AddChild(VETree.Selected,WordEdit.Text)
    else
    if (VETree.Selected.Parent<>nil) and (VETree.Selected.Parent.ImageIndex  in [2,4]) then
      Node := VETree.Items.AddChild(VETree.Selected.Parent,WordEdit.Text)
    else
      Node := AddNewNode(VETree.Selected);
  end
  else
    Node := VETree.Items.Add(nil,WordEdit.Text);
  Node.ImageIndex := 1;
  Node.SelectedIndex := 1;
  Node.StateIndex := Node.ImageIndex;
  Node.Text := WordEdit.Text;
  SetNOT(Node,NOTCheckBox.Checked);
  UpdateBtn;
  VETree.Invalidate;
  ChangedSS;
end;

procedure TLMDRVEForm.NEARRadioClick(Sender: TObject);
begin
  UpdateBtn;
end;

procedure TLMDRVEForm.AddOperatorBtnClick(Sender: TObject);
var
  Node : TTreeNode;
  szTmp : String;
  i     : Integer;
  List : TList;
  SN: TTreeNode;
begin
  if ANDRadio.Checked then
    szTmp := 'AND'
  else
  if ORRadio.Checked then
    szTmp := 'OR'
  else
    szTmp := 'NEAR';
  List := TList.Create;
  SN := nil;
  try
    for i:=0 to VETree.SelectionCount-1 do
      begin
        List.Add(VETree.Selections[i]);
      end;

    Node := AddNewNode(SN.Parent);
    Node.MoveTo(SN,naInsert);

//    Node := AddNewNode(VETree.Selected);
    Node.Text := LMDSP_OPERATOR_S+' '+szTmp;
    Node.ImageIndex := 2;
    Node.SelectedIndex := 2;
    Node.StateIndex := Node.ImageIndex;
    Node.Data := Pointer(GetUITag);
    for i:=0 to List.Count-1 do
    begin
      TTreeNode(List[i]).MoveTo(Node,naAddChild);
      end;
  finally
    List.Free;
  end;
  Node.Expand(True);
  UpdateBtn;
  ChangedSS;
end;

procedure TLMDRVEForm.DelBtnClick(Sender: TObject);
var
  Node : TTreeNode;
begin
  if VETree.Selected<>nil then
  begin
    Node := VETree.Selected;
    if Node.GetNextSibling<>nil then
      Node.GetNextSibling.Focused := True
    else
      if Node.GetPrev<>nil then
        Node.GetPrev.Focused := True;
    VETree.Selected.Selected := True;
    Node.Free;
  end;
  UpdateBtn;
  VETree.Invalidate;
  ChangedSS;
end;

procedure TLMDRVEForm.GroupBtnClick(Sender: TObject);
var
  i : Integer;
  Node : TTreeNode;
  List : TList;
  SN: TTreeNode;
begin
  if VETree.SelectionCount=0 then exit;
  List := TList.Create;
  try
    SN := nil;
    for i:=0 to VETree.SelectionCount-1 do
      begin
        List.Add(VETree.Selections[i]);
      end;
    Node := AddNewNode(SN.Parent);
    Node.MoveTo(SN,naInsert);
    Node.Text := LMDSP_GROUP_S;
    Node.ImageIndex := 0;
    Node.SelectedIndex := 0;
    Node.StateIndex := Node.ImageIndex;
    for i:=0 to List.Count-1 do
      begin
        TTreeNode(List[i]).MoveTo(Node,naAddChild);
        end;
  finally
    List.Free;
  end;
  ChangedSS;
end;

procedure TLMDRVEForm.UngroupBtnClick(Sender: TObject);
var
  Node : TTreeNode;
begin
  if VETree.Selected<>nil then
  begin
    Node := VETree.Selected;
    if Node.ImageIndex=0 then
    begin
      while Node.Count>0 do
        Node.Item[0].MoveTo(Node,naInsert);
      Node.Free;
    end
    else
      if Node.Parent<>nil then
        Node.MoveTo(Node.Parent,naInsert);
    UpdateBtn;
  end;
  ChangedSS;
end;

procedure TLMDRVEForm.SearchMemoChange(Sender: TObject);
begin
  UpdateBuilder;
end;

procedure TLMDRVEForm.OpenBBtnClick(Sender: TObject);
begin
  AddSearchString('(');
end;

procedure TLMDRVEForm.CloseBBtnClick(Sender: TObject);
begin
  AddSearchString(')');
end;

procedure TLMDRVEForm.AsteriskButtonClick(Sender: TObject);
begin
  AddSearchString(AnySequenceCharacter);
end;

procedure TLMDRVEForm.QuestButtonClick(Sender: TObject);
begin
  AddSearchString(AnySingleCharacter);
end;

procedure TLMDRVEForm.AndBtnClick(Sender: TObject);
begin
  AddSearchString(' AND ');
end;

procedure TLMDRVEForm.OrBtnClick(Sender: TObject);
begin
  AddSearchString(' OR ');
end;

procedure TLMDRVEForm.NotBtnClick(Sender: TObject);
begin
  AddSearchString(' NOT ');
end;

procedure TLMDRVEForm.NearBtnClick(Sender: TObject);
begin
  AddSearchString(' NEAR ');
end;

procedure TLMDRVEForm.EvaluateButtonClick(Sender: TObject);
var
  TLR: TLMDRefine;
begin
  TLR := TLMDRefine.Create(nil);
  try
    if TLR.ParseTemplate(SearchMemo.Text) then
      Windows.MessageBox(Handle,PChar(LMDSP_CorrectTemplate), '' ,MB_OK+MB_ICONINFORMATION)
    else
      Windows.MessageBox(Handle, PChar(LMDSP_InCorrectTemplate), '' ,MB_OK+MB_ICONERROR)
  finally
    FreeAndNil(TLR);
  end;
end;

end.
