unit pLMDElXRelationsDsgn;
{$I lmdcmps.inc}
{
  ##############################################################################
  # Author:             LMD Innovative (EK, AH)
  # Created:            05/05/2005
  # Description:
  # State:              release
  # Comments:
  #---------------------------------- CHANGES ----------------------------------
  # Author:
  # Date:
  # Description:
  # %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  # Author:
  # Date:
  # Description:
  ##############################################################################
}

interface

uses
  DesignEditors, DesignWindows, DsnConst, DesignIntf,
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  DB,
  Dialogs,
  ExtCtrls,
  ElPanel,
  LMDElDBConst,
  LMDUtils,
  TypInfo,
  StdCtrls, ElBtnEdit, ElCombos, ElEdits, ElListBox,
  ElPopBtn, ElSpin, ElXPThemedControl, ElBtnCtl, ElCheckCtl, ElCLabel,
  ElLabel, ElPgCtl, ElDBXTree;

type
  TRelationsEditor = class(TForm)
    ElLabel29: TElLabel;
    ElLabel28: TElLabel;
    ElLabel27: TElLabel;
    ElLabel26: TElLabel;
    ElLabel25: TElLabel;
    ElLabel24: TElLabel;
    ElLabel20: TElLabel;
    ActiveCB: TElCheckBox;
    ActiveLevelEdit: TElSpinEdit;
    ElPopupButton2: TElPopupButton;
    ElPopupButton1: TElPopupButton;
    CaptionEdit: TElEdit;
    DetailDisplayCB: TElComboBox;
    DetailFieldCB: TElComboBox;
    DetailDataSetCB: TElComboBox;
    MasterFieldCB: TElComboBox;
    MasterDataSetCB: TElComboBox;
    ShowcaptionCB: TElCheckBox;
    DenyDisplCB: TElCheckBox;
    ElPopupButton3: TElPopupButton;
    ElPopupButton4: TElPopupButton;
    panel1: TPanel;
    Bevel2: TBevel;
    Button2: TButton;
    ElPanel1: TElPanel;
    ElListBox1: TListBox;
    procedure Button3Click(Sender: TObject);
    procedure ElPopupButton1Click(Sender: TObject);
    procedure ElPopupButton2Click(Sender: TObject);
    procedure ElPopupButton3Click(Sender: TObject);
    procedure ElPopupButton4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ElListBox1Click(Sender: TObject);
    procedure MasterDataSetCBChange(Sender: TObject);
    procedure DetailDataSetCBChange(Sender: TObject);
    procedure MasterFieldCBChange(Sender: TObject);
    procedure DetailFieldCBChange(Sender: TObject);
    procedure DetailDisplayCBChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CaptionEditChange(Sender: TObject);
    procedure ShowcaptionCBClick(Sender: TObject);
    procedure ActiveCBClick(Sender: TObject);
    procedure DenyDisplCBClick(Sender: TObject);
    procedure ActiveLevelEditChange(Sender: TObject);
  private
    { Private declarations }
  public
    AComp : TComponent;
    DRelations : TELXRelations;
    DRelationsItem : TELXRelationsItem;
   FDesigner : IDesigner;
   procedure GetData;
    procedure SetEnabledForControl(val: Boolean);
    procedure Initialize;
    procedure SetDBStr(const S: string);
    procedure CheckFieldType;
  end;

  TElRelationsProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes : TPropertyAttributes; override;
    function GetValue : string; override;
  end;

var

  RelationsEditor: TRelationsEditor = nil;

implementation
{$R *.dfm}

{ TElRelationsProperty }

procedure TElRelationsProperty.Edit;
var
  Editor : TRelationsEditor;
  Form : TCustomForm;
begin
  Editor := TRelationsEditor.Create(Application);
  with Editor do
  begin
    try
      AComp := TComponent(GetComponent(0));
      FDesigner := Self.Designer;
      DRelations := TElXRelDataSource(AComp).Relations;
      Initialize;
      ShowModal;
      Form := LMDGetOwnerForm(TComponent(GetComponent(0)));
      if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
    finally
      Free;
    end;
  end;
end;

function TElRelationsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

function TElRelationsProperty.GetValue: string;
begin
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
end;

{ TRelationsEditor }

procedure TRelationsEditor.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TRelationsEditor.ElPopupButton1Click(Sender: TObject);
var
  s : integer;
begin
  if ElListBox1.Items.Count > 0 then
    s := StrToInt(copy(ElListBox1.Items.Strings[ElListBox1.Items.Count - 1],10,length(ElListBox1.Items.Strings[ElListBox1.Items.Count - 1])-9))
  else
    s := -1;
  s:= s+1;
  ElListBox1.Items.Add('Relation ' + IntToStr(s));
  DRelations.AddItem(s);
  ElListBox1.ItemIndex := s;
  GetData;
end;

procedure TRelationsEditor.ElPopupButton2Click(Sender: TObject);
begin
  if ElListBox1.ItemIndex > -1 then
  begin
    DRelations.DeleteItem(ElListBox1.ItemIndex);
    ElListBox1.Items.Delete(ElListBox1.ItemIndex);
  end;
  GetData;
end;

procedure TRelationsEditor.ElPopupButton3Click(Sender: TObject);
var
  i : integer;
begin
// up
  i := ElListBox1.ItemIndex;
  if  i > 0 then
  begin
    ElListBox1.items.Move(i, i - 1);
    ElListBox1.ItemIndex := i - 1;
  end;
end;

procedure TRelationsEditor.ElPopupButton4Click(Sender: TObject);
var
  i : integer;
begin
// down
  i := ElListBox1.ItemIndex;
  if  i < (ElListBox1.Items.Count - 1) then
  begin
    ElListBox1.items.Move(i, i + 1);
    ElListBox1.ItemIndex := i + 1;
  end;
end;

procedure TRelationsEditor.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TRelationsEditor.Initialize;
var
  i : integer;
begin
  FDesigner.GetComponentNames(GetTypeData(TDataSet.ClassInfo), SetDBStr);
  if DRelations.Count > 0 then
  begin
    for i := 0 to DRelations.Count - 1 do
      ElListBox1.Items.Add((DRelations).Items[i].Name) ;
    ElListBox1.ItemIndex := 0;
    GetData;
    MasterDataSetCBChange(self);
    DetailDataSetCBChange(self);
  end;
end;

procedure TRelationsEditor.GetData;
begin
  if ElListBox1.ItemIndex > -1 then
    DRelationsItem := (DRelations).Items[ElListBox1.ItemIndex]
  else
    DRelationsItem := nil;
  if Assigned(DRelationsItem) then
    with DRelationsItem do
    begin
      SetEnabledForControl(true);
      ActiveCB.Checked := Active;
      ActiveLevelEdit.Value := ActiveOnLevel;
      CaptionEdit.Text := Caption;
      DenyDisplCB.Checked := DenyLookSetPosition;
      ShowcaptionCB.Checked := ShowCaption;
      if Assigned(MasterDataSet) then
      begin
        if (MasterDataSet.Owner <> DRelations.DataSource.Owner) then
          MasterDataSetCB.Text := MasterDataSet.Owner.Name + '.' + MasterDataSet.Name
        else
          MasterDataSetCB.Text := MasterDataSet.Name;
        MasterDataSetCBChange(Self);
        if MasterField <> '' then
          MasterFieldCB.Text := MasterField
        else
          MasterFieldCB.ItemIndex := -1;
      end
      else
      begin
        MasterFieldCB.ItemIndex := -1;
        MasterDataSetCB.ItemIndex := -1;
      end;
      if Assigned(DetailDataSet) then
      begin
        if (DetailDataSet.Owner <> DRelations.DataSource.Owner) then
          DetailDataSetCB.Text := DetailDataSet.Owner.Name + '.' + DetailDataSet.Name
        else
          DetailDataSetCB.Text := DetailDataSet.Name;
        DetailDataSetCBChange(Self);  
        if DetailField <> '' then
          DetailFieldCB.Text := DetailField
        else
          DetailFieldCB.ItemIndex := -1;
        if DetailDisplayField <> '' then
          DetailDisplayCB.Text := DetailDisplayField
        else
          DetailDisplayCB.ItemIndex := -1;
      end
      else
      begin
        DetailDataSetCB.ItemIndex := -1;
        DetailFieldCB.ItemIndex := -1;
        DetailDisplayCB.ItemIndex := -1;
      end;
    end
  else
  begin
    SetEnabledForControl(false);
    ActiveCB.Checked := false;
    ActiveLevelEdit.Value := -1;
    CaptionEdit.Text := '';
    DenyDisplCB.Checked := false;
    ShowcaptionCB.Checked := false;
    DetailFieldCB.ItemIndex := -1;
    DetailDisplayCB.ItemIndex := -1;
    MasterFieldCB.ItemIndex := -1;
    MasterDataSetCB.ItemIndex := -1;
//    MasterDataSetCB.Text := '';
    DetailDataSetCB.ItemIndex := -1;
//    DetailDataSetCB.Text := '';
  end;
end;

procedure TRelationsEditor.SetEnabledForControl(val: Boolean);
begin
  ActiveCB.Enabled := val;
  ActiveLevelEdit.Enabled := val;
  CaptionEdit.Enabled := val;
  DenyDisplCB.Enabled := val;
  DetailDataSetCB.Enabled := val;
  DetailFieldCB.Enabled := val;
  DetailDisplayCB.Enabled := val;
  MasterFieldCB.Enabled := val;
  MasterDataSetCB.Enabled := val;
  ShowcaptionCB.Enabled := val;
  ElLabel20.Enabled := val;
  ElLabel24.Enabled := val;
  ElLabel25.Enabled := val;
  ElLabel26.Enabled := val;
  ElLabel27.Enabled := val;
  ElLabel28.Enabled := val;
  ElLabel29.Enabled := val;
end;

procedure TRelationsEditor.ElListBox1Click(Sender: TObject);
begin
  GetData;
end;

procedure TRelationsEditor.MasterDataSetCBChange(Sender: TObject);
var
  i: integer;
  s: string;
  LActive, LOpened: boolean;
begin
  s := MasterFieldCB.Text;
  LOpened := False;
  MasterFieldCB.Items.Clear;
  if Assigned(DRelationsItem) then
  begin
    if MasterDataSetCB.Text <> '' then
    begin
      DRelationsItem.MasterDataSet:=TDataSet(FDesigner.GetComponent(MasterDataSetCB.Text));
      LActive := DRelationsItem.MasterDataSet.Active;
      try
        if (DRelationsItem.MasterDataSet.FieldCount = 0) then
        begin
          DRelationsItem.MasterDataSet.DisableControls;
          if not DRelationsItem.MasterDataSet.Active then
            DRelationsItem.MasterDataSet.Open;
          LOpened := True;
        end;
        for i := 0 to DRelationsItem.MasterDataSet.FieldCount - 1 do
        begin
          MasterFieldCB.Items.Add(DRelationsItem.MasterDataSet.Fields[i].FieldName);
        end;
        if MasterFieldCB.Items.IndexOf(s) > -1 then
          MasterFieldCB.Text := s
        else
          MasterFieldCB.ItemIndex := -1;
      finally
        if LOpened then
        begin
          DRelationsItem.MasterDataSet.Active := LActive;
          DRelationsItem.MasterDataSet.EnableControls;
        end;
      end;
    end
    else
      DRelationsItem.MasterDataSet:=nil;
  end;
end;

procedure TRelationsEditor.DetailDataSetCBChange(Sender: TObject);
var
  i: integer;
  s1, s2: string;
  LActive, LOpened: boolean;
begin
  LOpened := False;
  s1 := DetailFieldCB.Text;
  s2 := DetailDisplayCB.Text;
  DetailFieldCB.Items.Clear;
  DetailDisplayCB.Items.Clear;
  if Assigned(DRelationsItem) then
  begin
    if DetailDataSetCB.Text <> '' then
    begin
      DRelationsItem.DetailDataSet:=TDataSet(FDesigner.GetComponent(DetailDataSetCB.Text));
      LActive := DRelationsItem.DetailDataSet.Active;
      try
        if (DRelationsItem.DetailDataSet.FieldCount = 0) then
        begin
          DRelationsItem.DetailDataSet.DisableControls;
          if not DRelationsItem.DetailDataSet.Active then
            DRelationsItem.DetailDataSet.Open;
          LOpened := True;
        end;
        for i := 0 to DRelationsItem.DetailDataSet.FieldCount - 1 do
        begin
          DetailFieldCB.Items.Add(DRelationsItem.DetailDataSet.Fields[i].FieldName);
          DetailDisplayCB.Items.Add(DRelationsItem.DetailDataSet.Fields[i].FieldName);
        end;
        if DetailFieldCB.Items.IndexOf(s1) > -1 then
          DetailFieldCB.Text := s1
        else
          DetailFieldCB.ItemIndex := -1;
        if DetailDisplayCB.Items.IndexOf(s2) > -1 then
          DetailDisplayCB.Text := s2
        else
          DetailDisplayCB.ItemIndex := -1;
      finally
        if LOpened then
        begin
          DRelationsItem.DetailDataSet.Active := LActive;
          DRelationsItem.DetailDataSet.EnableControls;
        end;
      end;
    end
    else
      DRelationsItem.DetailDataSet:=nil;
  end;
end;

procedure TRelationsEditor.MasterFieldCBChange(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.MasterField:=MasterFieldCB.Text;
  CheckFieldType;
end;

procedure TRelationsEditor.DetailFieldCBChange(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.DetailField:=DetailFieldCB.Text;
  CheckFieldType;
end;

procedure TRelationsEditor.DetailDisplayCBChange(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.DetailDisplayField:=DetailDisplayCB.Text;
end;

procedure TRelationsEditor.SetDBStr(const S: string);
begin
  MasterDataSetCB.Items.Add(S);
  DetailDataSetCB.Items.Add(S);
end;

procedure TRelationsEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ElListBox1.Items.Clear;
  MasterDataSetCB.Items.Clear;
  DetailDataSetCB.Items.Clear;
  MasterFieldCB.Items.Clear;
  DetailDisplayCB.Items.Clear;
  DetailFieldCB.Items.Clear;
end;

procedure TRelationsEditor.CheckFieldType;
var m,d : TFieldType;
begin
  if Assigned(DRelationsItem) and Assigned(DRelationsItem.MasterDataSet) and Assigned(DRelationsItem.DetailDataSet) then
    if (DRelationsItem.DetailField <> '') and (DRelationsItem.MasterField <> '') then
      begin
        m := DRelationsItem.MasterDataSet.FieldByName(DRelationsItem.MasterField).DataType;
        d := DRelationsItem.DetailDataSet.FieldByName(DRelationsItem.DetailField).DataType;
        if m <> d then ShowMessage(SMasterDetailIncompatible);
      end;
end;

procedure TRelationsEditor.CaptionEditChange(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.Caption:=CaptionEdit.Text;
end;

procedure TRelationsEditor.ShowcaptionCBClick(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.ShowCaption:=ShowcaptionCB.Checked;
end;

procedure TRelationsEditor.ActiveCBClick(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.Active := ActiveCB.Checked;
end;

procedure TRelationsEditor.DenyDisplCBClick(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.DenyLookSetPosition:=DenyDisplCB.Checked;
end;

procedure TRelationsEditor.ActiveLevelEditChange(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.ActiveOnLevel := ActiveLevelEdit.Value;
end;

end.
