unit pLMDOSPropForm;
{$I lmdcmps.inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, LMDObjectStorage, StdCtrls, TypInfo, Buttons;

type
  TLMDOSPropForm = class(TForm)
    Panel1: TPanel;
    OkBtn: TButton;
    CancelBtn: TButton;
    ComponentsTree: TTreeView;
    Panel2: TPanel;
    ToBtn: TSpeedButton;
    FromBtn: TSpeedButton;
    Panel3: TPanel;
    PropListView: TListView;
    ExcludedPropertiesList: TListView;
    Label1: TLabel;
    ExclAdd: TSpeedButton;
    ExclDel: TSpeedButton;
    AllDelBtn: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure ToBtnClick(Sender: TObject);
    procedure FromBtnClick(Sender: TObject);
    procedure ComponentsTreeChange(Sender: TObject; Node: TTreeNode);
    procedure PropListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ExclAddClick(Sender: TObject);
    procedure ExclDelClick(Sender: TObject);
    procedure AllDelBtnClick(Sender: TObject);
    procedure ComponentsTreeDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    OS : TLMDObjectStorage;
    procedure UpdatePropertiesTree;
    function  IsPropertyExist(szComp,szProp:String):Boolean;
    procedure Apply;
    procedure UpdateBtn;
  end;

var
  LMDOSPropForm: TLMDOSPropForm;

implementation
uses
  pLMDRegOS;

{$R *.DFM}
{ ---------------------------------------------------------------------------- }
procedure TLMDOSPropForm.Apply;
var
  i : Integer;
begin
  OS.Properties.Clear;
  for i:=0 to PropListView.Items.Count-1 do
    with OS.Properties.Add do
    begin
      ComponentName := PropListView.Items[i].Caption;
      Name := PropListView.Items[i].SubItems[0];
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDOSPropForm.FormShow(Sender: TObject);
var
  i : Integer;
begin

  PropListView.Items.BeginUpdate;
  PropListView.Items.Clear;
  try
    for i:=0 to OS.Properties.Count-1 do
    begin
      with PropListView.Items.Add do
      begin
        Caption := OS.Properties[i].ComponentName;
        SubItems.Add(OS.Properties[i].Name);
      end;
    end;
  except
  end;
  PropListView.Items.EndUpdate;

  ExcludedPropertiesList.Items.BeginUpdate;
  ExcludedPropertiesList.Items.Clear;
  try
    for i:=0 to ExcludedProperties.Count-1 do
    begin
      with ExcludedPropertiesList.Items.Add do
      begin
        Caption := ExcludedProperties[i];
      end;
    end;
  except
  end;
  ExcludedPropertiesList.Items.EndUpdate;
  UpdatePropertiesTree;
  UpdateBtn;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDOSPropForm.OkBtnClick(Sender: TObject);
begin
  Apply;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDOSPropForm.UpdateBtn;
begin
  ToBtn.Enabled := (ComponentsTree.Selected<>nil) and (ComponentsTree.Selected.Level=1);
  FromBtn.Enabled := PropListView.Selected<>nil;
  AllDelBtn.Enabled := PropListView.Items.Count>0;
  ExclAdd.Enabled := ToBtn.Enabled;
  ExclDel.Enabled := ExcludedPropertiesList.Selected<>nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDOSPropForm.ToBtnClick(Sender: TObject);
begin
  if (ComponentsTree.Selected<>nil) and (ComponentsTree.Selected.Level=1) then
  begin
    with PropListView.Items.Add do
    begin
      Caption := ComponentsTree.Selected.Parent.Text;
      SubItems.Add(ComponentsTree.Selected.Text);
    end;
    ComponentsTree.Selected.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDOSPropForm.FromBtnClick(Sender: TObject);
var
  i : Integer;
  //PN: TTreeNode;
begin
  if PropListView.Selected<>nil then
  begin
    for i:=0 to ComponentsTree.Items.Count-1 do
      if (ComponentsTree.Items[i].Level=0) and (ComponentsTree.Items[i].Text=PropListView.Selected.Caption) then
      begin
        {PN := }ComponentsTree.Items.AddChild(ComponentsTree.Items[i],PropListView.Selected.SubItems[0]);
        break;
      end;
    PropListView.Selected.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDOSPropForm.ComponentsTreeChange(Sender: TObject;
  Node: TTreeNode);
begin
  UpdateBtn;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDOSPropForm.PropListViewSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  UpdateBtn;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDOSPropForm.UpdatePropertiesTree;
var
  i : Integer;
  szComp,szProp:String;

  procedure AddProperties(aObject:TComponent);
  var
    CN: TTreeNode;
    PN: TTreeNode;
    I, Count: Integer;
    PropInfo: PPropInfo;
    PropList: PPropList;
    begin
    CN := ComponentsTree.Items.Add(nil,aObject.Name);
    Count := GetTypeData(aObject.ClassInfo)^.PropCount;
    if Count > 0 then
    begin
      GetMem(PropList, Count * SizeOf(Pointer));
      try
        GetPropInfos(aObject.ClassInfo,PropList);
        for I := 0 to Count - 1 do
        begin
          PropInfo := PropList[I];
          if PropInfo = nil then break;
          if {IsStoredProp(aObject,PropInfo) and }
            (PropInfo.PropType^.Kind <> tkMethod)
            and (not IsPropertyExist(aObject.Name, {$IFDEF LMDCOMP12}String{$ENDIF}(PropInfo.Name))){ and (OS.Properties.FindItem(aObject.Name,PropInfo.Name)=nil)} and
                (ExcludedProperties.IndexOf({$IFDEF LMDCOMP12}String{$ENDIF}(PropInfo.Name))=-1) then
          begin
            PN := ComponentsTree.Items.AddChild(CN, {$IFDEF LMDCOMP12}String{$ENDIF}(PropInfo.Name));
            if (aObject.Name=szComp) and ({$IFDEF LMDCOMP12}String{$ENDIF}(PropInfo.Name)=szProp) then
            begin
              PN.Selected := True;
              PN.Focused  := True;
            end;
          end;
        end;
      finally
        FreeMem(PropList, Count * SizeOf(Pointer));
        end;
    end;

  end;

begin
  szComp := '';
  szProp := '';
  if (ComponentsTree.Selected<>nil) and (ComponentsTree.Selected.Level=1) then
  begin
    szProp := ComponentsTree.Selected.Text;
    szComp := ComponentsTree.Selected.Parent.Text;
  end;
  ComponentsTree.Items.BeginUpdate;
  ComponentsTree.Items.Clear;
  try
    AddProperties(OS.Owner);
    for i:=0 to OS.Owner.ComponentCount-1 do
    begin
      if (OS.Owner.Components[i]<>OS) and (OS.Owner.Components[i].Name<>'') then
        AddProperties(OS.Owner.Components[i]);
    end;
  except
  end;
  ComponentsTree.Items.EndUpdate;
  if (ComponentsTree.Selected<>nil) then
    ComponentsTree.Selected.MakeVisible;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDOSPropForm.ExclAddClick(Sender: TObject);
begin
  if (ComponentsTree.Selected<>nil) and (ComponentsTree.Selected.Level=1) then
  begin
    with ExcludedPropertiesList.Items.Add do
    begin
      Caption := ComponentsTree.Selected.Text;
      ExcludedProperties.Add(Caption);
      if ComponentsTree.Items.Count>(ComponentsTree.Selected.AbsoluteIndex+1) then
        ComponentsTree.Selected := ComponentsTree.Items[ComponentsTree.Selected.AbsoluteIndex+1];
    end;
    UpdatePropertiesTree;
    SaveExcludedProperties;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDOSPropForm.ExclDelClick(Sender: TObject);
var
  i : Integer;
begin
  if ExcludedPropertiesList.Selected<>nil then
  begin
    i := ExcludedProperties.IndexOf(ExcludedPropertiesList.Selected.Caption);
    if i>=0 then
      ExcludedProperties.Delete(i);
    ExcludedPropertiesList.Selected.Free;
    UpdatePropertiesTree;
    SaveExcludedProperties;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDOSPropForm.AllDelBtnClick(Sender: TObject);
begin
  PropListView.Items.Clear;
  UpdatePropertiesTree;
  UpdateBtn;
end;

{ ---------------------------------------------------------------------------- }
function TLMDOSPropForm.IsPropertyExist(szComp, szProp: String): Boolean;
var
  i : Integer;
begin
  Result := False;
  for i:=0 to PropListView.Items.Count-1 do
    if (PropListView.Items[i].Caption=szComp) and (PropListView.Items[i].SubItems[0]=szProp) then
    begin
      Result := True;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDOSPropForm.ComponentsTreeDblClick(Sender: TObject);
begin
  ToBtnClick(Sender);
end;

end.
