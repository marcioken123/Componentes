unit pLMDStorPropForm;
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

pLMDStorPropForm unit (VO)
--------------------------
LMDStoragePack: Stored Properties Form

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, LMDStorPropertiesStorage, StdCtrls, TypInfo, Buttons,
  ImgList
  ;

type
  {-------------------  Class TLMDPropForm ------------------------------------}
  TLMDPropForm = class(TForm)
    BottomPanel: TPanel;
    OkBtn: TButton;
    CancelBtn: TButton;
    ComponentsTree: TTreeView;
    MiddlePanel: TPanel;
    ToBtn: TSpeedButton;
    FromBtn: TSpeedButton;
    RightPanel: TPanel;
    PropListView: TListView;
    ExcludedPropertiesList: TListView;
    ExcludePropertiesLabel: TLabel;
    ExclAdd: TSpeedButton;
    ExclDel: TSpeedButton;
    AllDelBtn: TSpeedButton;
    ImageList1: TImageList;
    procedure FormShow(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure ToBtnClick(Sender: TObject);
    procedure FromBtnClick(Sender: TObject);
    procedure ComponentsTreeChange(Sender: TObject; Node: TTreeNode);
    procedure ExclAddClick(Sender: TObject);
    procedure ExclDelClick(Sender: TObject);
    procedure AllDelBtnClick(Sender: TObject);
    procedure ComponentsTreeDblClick(Sender: TObject);
    procedure PropListViewChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure ExcludedPropertiesListChange(Sender: TObject;
      Item: TListItem; Change: TItemChange);
  private
    { Private declarations }
  public
    { Public declarations }
    OS: TLMDStorPropertiesStorage;
    procedure UpdatePropertiesTree(SelectedItem: String = '');
    function IsPropertyExist(szComp, szProp: string): Boolean;
    procedure Apply;
    procedure UpdateBtn;
  end;

var
  LMDPropForm: TLMDPropForm;

const
  MaxLevel = 40;

implementation
(*
uses pLMDStorPE
//, System.ComponentModel
;
*)

{$R *.DFM}

{------------------------------------------------------------------------------}
function CheckItem(S: String): String;
var
  p: integer;
begin
  Result := S;
  p := Pos(' ', S);
  if p > 0 then Result := 'Item(' + copy(S, 1, p - 1) + ')';
end;

{------------------------------------------------------------------------------}
procedure TLMDPropForm.FormShow(Sender: TObject);
var
  i: Integer;
begin
  PropListView.Items.BeginUpdate;
  PropListView.Items.Clear;
  try
    for i := 0 to OS.Properties.Count - 1 do
      begin
        with PropListView.Items.Add do
          begin
            Caption := OS.Properties[i].ComponentName;
            SubItems.Add(OS.Properties[i].PropertyName);
          end;
      end;
  except
  end;
  PropListView.Items.EndUpdate;

  ExcludedPropertiesList.Items.BeginUpdate;
  ExcludedPropertiesList.Items.Clear;
  try
{
    for i := 0 to ExcludedProperties.Count - 1 do
      begin
        with ExcludedPropertiesList.Items.Add do
          begin
            Caption := ExcludedProperties[i];
          end;
      end;
}
  except
  end;
  ExcludedPropertiesList.Items.EndUpdate;
  UpdatePropertiesTree;
  UpdateBtn;
end;

{------------------------------------------------------------------------------}
procedure TLMDPropForm.OkBtnClick(Sender: TObject);
begin
  Apply;
end;

{------------------------------------------------------------------------------}
procedure TLMDPropForm.ToBtnClick(Sender: TObject);
var
  Node: TTreeNode;
  S: String;
begin
  if (ComponentsTree.Selected <> nil) and
   (ComponentsTree.Selected.Level >= 1) then
    begin
      with PropListView.Items.Add do
        begin
          Caption := ComponentsTree.Selected.Parent.Text;
          if ComponentsTree.Selected.Level = 1 then
           SubItems.Add(ComponentsTree.Selected.Text) else
          begin
            Node := ComponentsTree.Selected;
            s := Node.Text;
            while Node.Parent <> nil do
            begin
              Node := Node.Parent;
              if Node.Parent <> nil then s := CheckItem(Node.Text) + OS.ComplexPropDelimiter + s;
            end;
            Caption := Node.Text;
            SubItems.Add(s);            
          end;
        end;
      ComponentsTree.Selected.Free;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPropForm.FromBtnClick(Sender: TObject);
var
  i: Integer;
//  done: boolean;
  SelectedItem: String;
begin
//  done := false;
  if PropListView.Selected <> nil then
    begin
      for i := 0 to ComponentsTree.Items.Count - 1 do
        if (ComponentsTree.Items[i].Level = 0) and
         (ComponentsTree.Items[i].Text = PropListView.Selected.Caption) and
          (pos(OS.ComplexPropDelimiter, PropListView.Selected.SubItems[0]) = 0) then
          begin
            ComponentsTree.Items.AddChild(ComponentsTree.Items[i],
              PropListView.Selected.SubItems[0]);
//            Done := True;
            break;
          end;
      SelectedItem := PropListView.Selected.Caption;
      PropListView.Selected.Free;      
      {if not Done then} UpdatePropertiesTree(SelectedItem);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPropForm.ComponentsTreeChange(Sender: TObject; Node: TTreeNode);
begin
  UpdateBtn;
end;

{------------------------------------------------------------------------------}
procedure TLMDPropForm.ExclAddClick(Sender: TObject);
begin
  if (ComponentsTree.Selected <> nil) and (ComponentsTree.Selected.Level = 1)
    then
    begin
      with ExcludedPropertiesList.Items.Add do
        begin
          Caption := ComponentsTree.Selected.Text;
//          ExcludedProperties.Add(Caption);
          if ComponentsTree.Items.Count >
           (ComponentsTree.Selected.AbsoluteIndex + 1) then
            ComponentsTree.Selected :=
              ComponentsTree.Items[ComponentsTree.Selected.AbsoluteIndex + 1];
        end;
      UpdatePropertiesTree;
//      SaveExcludedProperties;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPropForm.ExclDelClick(Sender: TObject);
var
  i: Integer;
begin
  if ExcludedPropertiesList.Selected <> nil then
    begin
      i := ExcludedPropertiesList.Items.IndexOf(ExcludedPropertiesList.Selected);
      if i >= 0 then
        ExcludedPropertiesList.Items.Delete(i);
      ExcludedPropertiesList.Selected.Free;
      UpdatePropertiesTree;
      //SaveExcludedProperties;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPropForm.AllDelBtnClick(Sender: TObject);
begin
  PropListView.Items.Clear;
  UpdatePropertiesTree;
  UpdateBtn;
end;

{------------------------------------------------------------------------------}
procedure TLMDPropForm.ComponentsTreeDblClick(Sender: TObject);
begin
  ToBtnClick(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDPropForm.PropListViewChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  UpdateBtn;
end;

{------------------------------------------------------------------------------}
procedure TLMDPropForm.ExcludedPropertiesListChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  UpdateBtn;
end;

{------------------------- Public----------------------------------------------}
procedure TLMDPropForm.UpdatePropertiesTree(SelectedItem: String = '');
var
  i: Integer;
  szComp, szProp: string;
  CN: TTreeNode;
  ML: Integer;
  ObjStack:TList;

  procedure AddIcon(aObject: TObject; Node: TTreeNode);
  begin
    if Node = nil then exit;
    Node.ImageIndex := 0;
    if aObject <> nil then
    begin
      if aObject is TForm then Node.ImageIndex := 1 else
      if aObject is TGraphicControl then Node.ImageIndex := 3 else
      if aObject is TPanel then Node.ImageIndex := 5 else
      if aObject is TWinControl then Node.ImageIndex := 4 else
      if aObject is TCollection then Node.ImageIndex := 7;
    end;
    Node.StateIndex := Node.ImageIndex;
    Node.SelectedIndex := Node.ImageIndex;
    if (Node.Parent <> nil) and (Node.Parent.ImageIndex = 0) then
    begin
      if Node.Parent.Level = 0 then
      begin
        Node.Parent.ImageIndex := 2;
        Node.Parent.SelectedIndex := 2;
        Node.Parent.StateIndex := 2;
      end else
      begin
        Node.Parent.ImageIndex := 6;
        Node.Parent.SelectedIndex := 6;
        Node.Parent.StateIndex := 6;
      end;
    end;
  end;

  procedure AddPropertiesObj(const aObject: TObject; Node: TTreeNode; PropName: String);
  var
    PN, VN: TTreeNode;
    I, k, Count: Integer;
  PropInfo: PPropInfo;
    PropList: PPropList;
  TObj: TObject;
    TS, TT: String;
  begin
    if not Assigned(aObject) then exit;
    if ML > MaxLevel then exit;
    if ObjStack.IndexOf(aObject)>-1 then exit;
    if aObject.ClassInfo=nil then exit;
    ObjStack.Add(aObject);
    Inc(ML);
    Count := GetTypeData(aObject.ClassInfo).PropCount;
    if Count > 0 then
      begin
        GetMem(PropList, Count * SizeOf(Pointer));
        try
          GetPropInfos(aObject.ClassInfo,PropList);
          for I := 0 to Count - 1 do
            begin
              PropInfo := PropList[I];
              if PropInfo = nil then break;
              TS := CheckItem(Node.Text) + OS.ComplexPropDelimiter + {$IFDEF LMDCOMP12}String{$ENDIF}(PropInfo.Name);
              PN := Node;
              while PN.Parent <> nil do
              begin
                PN := PN.Parent;
                if PN.Level > 0 then TS := CheckItem(PN.Text) + OS.ComplexPropDelimiter + TS;
                if PN.Level = 0 then TT := PN.Text;
              end;
              if not IsPropertyExist(TT, TS) and
//               (ExcludedProperties.IndexOf(PropInfo.Name) = -1) and
            (PropInfo.PropType^.Kind <> tkMethod)
            then
              begin
                case PropInfo.PropType^.Kind of
                  tkClass:
                    begin
                      TObj := GetObjectProp(aObject, {$IFDEF LMDCOMP12}String{$ENDIF}(PropInfo.Name));
                      PN := ComponentsTree.Items.AddChild(Node, {$IFDEF LMDCOMP12}String{$ENDIF}(PropInfo.Name));
                      AddIcon(TObj, PN);
                      if TObj is TCollection then
                      begin
                        for k := 0 to (TObj as TCollection).Count - 1 do
                        begin
                          VN := ComponentsTree.Items.AddChild(PN, IntToStr(k) +
                           ' - ' + TCollection(TObj).Items[k].ClassName);
                          AddIcon(nil, VN);
                          AddPropertiesObj(TCollection(TObj).Items[k], VN, {$IFDEF LMDCOMP12}String{$ENDIF}(PropInfo.Name));
                        end;
                      end else AddPropertiesObj(TObj, PN, {$IFDEF LMDCOMP12}String{$ENDIF}(PropInfo.Name));
                    end
                  else
                    begin
                      PN := ComponentsTree.Items.AddChild(Node, {$IFDEF LMDCOMP12}String{$ENDIF}(PropInfo.Name));
                      AddIcon(nil, PN);
                    end;
                end;
              end;
            end;
        finally
        FreeMem(PropList, Count * SizeOf(Pointer));
        end;
      end;
      Dec(ML);
      ObjStack.Remove(aObject);
  end;

  procedure AddProperties(const aObject: TComponent; Node: TTreeNode);
  var
    PN, VN: TTreeNode;
    I, k, Count: Integer;
  PropInfo: PPropInfo;
    PropList: PPropList;
  TObj: TObject;
  begin
    if not Assigned(aObject) then exit;
    if ML > MaxLevel then exit;
    if ObjStack.IndexOf(aObject)>-1 then exit;
    ObjStack.Add(aObject);
    Inc(ML);
    Count := GetTypeData(aObject.ClassInfo).PropCount;
    if Count > 0 then
      begin
        GetMem(PropList, Count * SizeOf(Pointer));
        try
          GetPropInfos(aObject.ClassInfo,PropList);
          for I := 0 to Count - 1 do
            begin
              PropInfo := PropList[I];
              if PropInfo = nil then break;
              if not IsPropertyExist(aObject.Name, {$IFDEF LMDCOMP12}String{$ENDIF}(PropInfo.Name))
//              and (ExcludedProperties.IndexOf(PropInfo.Name) = -1)
              then
              begin
                case PropInfo.PropType^.Kind of
                  tkClass:
                    begin
                      TObj := GetObjectProp(aObject, {$IFDEF LMDCOMP12}String{$ENDIF}(PropInfo.Name));
                      PN := ComponentsTree.Items.AddChild(Node, {$IFDEF LMDCOMP12}String{$ENDIF}(PropInfo.Name));
                      AddIcon(TObj, PN);
                      if TObj is TComponent then
                      AddProperties(TObj as TComponent, PN) else
                      if TObj is TCollection then
                      begin
                        for k := 0 to (TObj as TCollection).Count - 1 do
                        begin
                          VN := ComponentsTree.Items.AddChild(PN, IntToStr(k)
                           + ' - ' + TCollection(TObj).Items[k].ClassName);
                          AddIcon(nil, VN);
                          AddPropertiesObj(TCollection(TObj).Items[k], VN, {$IFDEF LMDCOMP12}String{$ENDIF}(PropInfo.Name));
                        end;
                      end else AddPropertiesObj(TObj, PN, {$IFDEF LMDCOMP12}String{$ENDIF}(PropInfo.Name));
                    end;
                  tkMethod:
                  else
                    begin
                      PN := ComponentsTree.Items.AddChild(Node, {$IFDEF LMDCOMP12}String{$ENDIF}(PropInfo.Name));
                      AddIcon(nil, PN);
                      if (aObject.Name = szComp) and ({$IFDEF LMDCOMP12}String{$ENDIF}(PropInfo.Name) = szProp) then
                        begin
                          PN.Selected := True;
                          PN.Focused := True;
                        end;
                    end;
                end;
              end;
            end;
        finally
        FreeMem(PropList, Count * SizeOf(Pointer));
        end;
      end;
      Dec(ML);
      ObjStack.Remove(aObject);
  end;

begin
  ObjStack:=TList.Create;
  szComp := '';
  szProp := '';
  ML := 0;
  if (ComponentsTree.Selected <> nil) and (ComponentsTree.Selected.Level = 1)
    then
    begin
      szProp := ComponentsTree.Selected.Text;
      szComp := ComponentsTree.Selected.Parent.Text;
    end;
  ComponentsTree.Items.BeginUpdate;
  ComponentsTree.Items.Clear;
  try
    CN := ComponentsTree.Items.Add(nil, OS.Owner.Name);
    AddIcon(OS.Owner, CN);
    AddProperties(OS.Owner, CN);
    CN.AlphaSort(True);

    if OS.Owner.Name = SelectedItem then
    begin
      CN.Selected := True;
      CN.Focused := True;
      CN.Expand(False);
    end;

    for i := 0 to OS.Owner.ComponentCount - 1 do
      begin
        if (OS.Owner.Components[i] <> OS) and
         (OS.Owner.Components[i].Name <> '') then
        begin
          CN := ComponentsTree.Items.Add(nil, OS.Owner.Components[i].Name);
          AddIcon(OS.Owner.Components[i], CN);
          AddProperties(OS.Owner.Components[i], CN);

          CN.AlphaSort(True);

          if OS.Owner.Components[i].Name = SelectedItem then
          begin
            CN.Selected := True;
            CN.Focused := True;
            CN.Expand(False);
          end;

        end;
      end;
  except
  end;
  ObjStack.Free;
  ComponentsTree.Items.EndUpdate;
  if (ComponentsTree.Selected <> nil) then
    ComponentsTree.Selected.MakeVisible;
end;

{------------------------------------------------------------------------------}
function TLMDPropForm.IsPropertyExist(szComp, szProp: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to PropListView.Items.Count - 1 do
    if (PropListView.Items[i].Caption = szComp) and
      (PropListView.Items[i].SubItems[0] = szProp) then
      begin
        Result := True;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPropForm.Apply;
var
  i: Integer;
begin
  OS.Properties.Clear;
  for i := 0 to PropListView.Items.Count - 1 do
    with OS.Properties.Add do
      begin
        ComponentName := PropListView.Items[i].Caption;
        PropertyName := PropListView.Items[i].SubItems[0];
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPropForm.UpdateBtn;
begin
  ToBtn.Enabled := (ComponentsTree.Selected <> nil) and
    (ComponentsTree.Selected.Level >= 1);
  FromBtn.Enabled := PropListView.Selected <> nil;
  AllDelBtn.Enabled := PropListView.Items.Count > 0;
  ExclAdd.Enabled := (ComponentsTree.Selected <> nil) and
    (ComponentsTree.Selected.Level = 1);
  ExclDel.Enabled := ExcludedPropertiesList.Selected <> nil;
end;

end.

