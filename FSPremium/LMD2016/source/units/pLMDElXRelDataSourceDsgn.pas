unit pLMDElXRelDataSourceDsgn;
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
  Windows, Messages, SysUtils,  Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ElPgCtl, ElXPThemedControl, StdCtrls, ElCLabel,
  ElLabel, ElEdits, ElBtnEdit, ElCombos, ElBtnCtl, ElCheckCtl, ElPanel,
  ElGroupBox, ElCheckItemGrp, ElListBox, ElSpin, ElPopBtn, ElDBTree,
  ImgList, ElImgLst, pLMDElXRelationsDsgn,
  DesignEditors, DesignWindows, DsnConst, DesignIntf,
  ElDBXTree,
  LMDUtils,
  DB,
  LMDElDBConst,
  TypInfo{$IFNDEF LMDCOMP9},JPEG{$ENDIF};

type

  TELRelDataSourceEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index : Integer); override;
    function GetVerb(Index : Integer) : string; override;
    function GetVerbCount : Integer; override;
  end;

  TElRelDataSourceDsgn = class(TForm)
    Bevel1: TBevel;
    Panel1: TPanel;
    Panel2: TPanel;
    ElPageControl1: TElPageControl;
    ElTabSheet1: TElTabSheet;
    ElTabSheet2: TElTabSheet;
    Bevel2: TBevel;
    Button1: TElPopupButton;
    Button2: TElPopupButton;
    Button3: TElPopupButton;
    Image1: TImage;
    ElTabSheet3: TElTabSheet;
    Image2: TImage;
    SimpleRootCB: TElComboBox;
    SimpleRootFieldCB: TElComboBox;
    SimpleDetailDataSetCB: TElComboBox;
    SimpleDetailDisplayCB: TElComboBox;
    SimpleMasterFieldCB: TElComboBox;
    SimpleDetailFieldCB: TElComboBox;
    ElCheckBox1: TElCheckBox;
    ElEdit1: TElEdit;
    ElCheckBox2: TElCheckBox;
    ElEdit2: TElEdit;
    ElCheckBox3: TElCheckBox;
    SimpleDetailRelDisplayCB: TElComboBox;
    SimpleDetailRelFieldCB: TElComboBox;
    SimpleDetailRelCB: TElComboBox;
    ElEdit3: TElEdit;
    SimpleMasterRelFieldCB: TElComboBox;
    SimpleMasterRelCB: TElComboBox;
    SimpleMasterDataSetCB: TElComboBox;
    ElTabSheet4: TElTabSheet;
    ElTabSheet5: TElTabSheet;
    ElTabSheet6: TElTabSheet;
    ElLabel16: TElLabel;
    ElLabel17: TElLabel;
    ElRadioGroup1: TElRadioGroup;
    ElRadioGroup2: TElRadioGroup;
    ElCheckBox4: TElCheckBox;
    ElLabel18: TElLabel;
    ElEdit4: TElEdit;
    ElLabel19: TElLabel;
    RootCB: TElComboBox;
    RootFieldCB: TElComboBox;
    ElCheckBox5: TElCheckBox;
    ElEdit5: TElEdit;
    ElLabel22: TElLabel;
    ElCheckBox6: TElCheckBox;
    ElLabel23: TElLabel;
    ElEdit6: TElEdit;
    ElCheckBox9: TElCheckBox;
    ElTabSheet7: TElTabSheet;
    ElPopupButton1: TElPopupButton;
    ElPopupButton2: TElPopupButton;
    ElPopupButton3: TElPopupButton;
    ElPopupButton4: TElPopupButton;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    ElLabel7: TElLabel;
    ElLabel30: TElLabel;
    ElLabel3: TElLabel;
    ElLabel21: TElLabel;
    ElLabel2: TElLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    ElLabel8: TElLabel;
    ElLabel6: TElLabel;
    ElLabel5: TElLabel;
    ElLabel4: TElLabel;
    ElLabel15: TElLabel;
    ElLabel1: TElLabel;
    ElLabel31: TElLabel;
    Image4: TImage;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    ElLabel32: TElLabel;
    Image5: TImage;
    ElLabel14: TElLabel;
    ElLabel13: TElLabel;
    ElLabel12: TElLabel;
    ElLabel11: TElLabel;
    ElLabel10: TElLabel;
    ElLabel9: TElLabel;
    Image3: TImage;
    Image6: TImage;
    ElImageList1: TElImageList;
    ActiveCB: TElCheckBox;
    ElLabel25: TElLabel;
    CaptionEdit: TElEdit;
    ShowcaptionCB: TElCheckBox;
    MasterDataSetCB: TElComboBox;
    ElLabel20: TElLabel;
    ElLabel24: TElLabel;
    MasterFieldCB: TElComboBox;
    DetailDataSetCB: TElComboBox;
    ElLabel26: TElLabel;
    ElLabel27: TElLabel;
    ElLabel28: TElLabel;
    DetailFieldCB: TElComboBox;
    DetailDisplayCB: TElComboBox;
    DenyDisplCB: TElCheckBox;
    ElLabel29: TElLabel;
    ActiveLevelEdit: TElSpinEdit;
    ElListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ElRadioGroup1Click(Sender: TObject);
    procedure ElCheckBox5Click(Sender: TObject);
    procedure ElCheckBox6Click(Sender: TObject);
    procedure ElPopupButton2Click(Sender: TObject);
    procedure ElPopupButton1Click(Sender: TObject);
    procedure ElPageControl1Change(Sender: TObject);
    procedure ElPopupButton3Click(Sender: TObject);
    procedure ElPopupButton4Click(Sender: TObject);
    procedure ActiveCBClick(Sender: TObject);
    procedure CaptionEditChange(Sender: TObject);
    procedure ShowcaptionCBClick(Sender: TObject);
    procedure MasterDataSetCBChange(Sender: TObject);
    procedure MasterFieldCBChange(Sender: TObject);
    procedure DetailDataSetCBChange(Sender: TObject);
    procedure DetailFieldCBChange(Sender: TObject);
    procedure DetailDisplayCBChange(Sender: TObject);
    procedure DenyDisplCBClick(Sender: TObject);
    procedure ActiveLevelEditChange(Sender: TObject);
    procedure ElListBox1Click(Sender: TObject);
    procedure ElRadioGroup2Click(Sender: TObject);
    procedure ElEdit4Change(Sender: TObject);
    procedure ElCheckBox4Click(Sender: TObject);
    procedure RootCBChange(Sender: TObject);
    procedure RootFieldCBChange(Sender: TObject);
    procedure ElEdit6Change(Sender: TObject);
    procedure ElCheckBox9Click(Sender: TObject);
    procedure ElCheckBox1Click(Sender: TObject);
    procedure ElEdit1Change(Sender: TObject);
    procedure SimpleRootCBChange(Sender: TObject);
    procedure SimpleRootFieldCBChange(Sender: TObject);
    procedure ElEdit5Change(Sender: TObject);
    procedure SimpleMasterDataSetCBChange(Sender: TObject);
    procedure SimpleDetailDataSetCBChange(Sender: TObject);
    procedure SimpleMasterFieldCBChange(Sender: TObject);
    procedure SimpleDetailFieldCBChange(Sender: TObject);
    procedure SimpleDetailDisplayCBChange(Sender: TObject);
    procedure ElEdit2Change(Sender: TObject);
    procedure ElCheckBox2Click(Sender: TObject);
    procedure SimpleMasterRelCBChange(Sender: TObject);
    procedure SimpleDetailRelCBChange(Sender: TObject);
    procedure SimpleMasterRelFieldCBChange(Sender: TObject);
    procedure SimpleDetailRelFieldCBChange(Sender: TObject);
    procedure SimpleDetailRelDisplayCBChange(Sender: TObject);
    procedure ElEdit3Change(Sender: TObject);
    procedure ElCheckBox3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    AComp : TComponent;
    DElRelDataSource : TELXRelDataSource;
    DRelationsItem : TELXRelationsItem;
   FDesigner : IDesigner;
   procedure ColorTabs;
    procedure GetData;
    procedure SetEnabledForControl(val: Boolean);
    procedure Initialize;
    procedure InitializeStep;
    procedure SetDBStr(const S: string);
    procedure CheckFieldType;
    procedure FinalizeStep;
  end;

var
  ElRelDataSourceDsgn: TElRelDataSourceDsgn;
  Step, StepCount, SelfRef : Integer;
  Descr : array [1..7] of {$ifdef lmdcomp12}string{$else}shortstring{$endif} = (
          'Set property for root level',
          'Set property for first level',
          'Set property for it level. If you wont add next level - press "Next" button, if your tree is completed - press "Close" button.',
          'Select mode for design. In expert mode you can set all property on one list, in simple mode you can set property step-by-step.',
          'Select tree type.',
          'Set property for root level.',
          'Set property for relations.');
  Color1: array [0..3] of TColor = (TColor($00ccd7c4), TColor($00bdcaca), TColor($00bcb1c7), TColor($00d0bab7));
  Color2: array [0..3] of TColor = (TColor($00cdd5ca), TColor($00cbd7d8), TColor($00c9c5cb), TColor($00cbc1bc));

const
  SNoSelfRefrence = 'Change to master\detail tree type because different sets are used.';

implementation

{$R *.dfm}
{ TELRelDataSourceEditor }

procedure TELRelDataSourceEditor.ExecuteVerb(Index: Integer);
var Form : TCustomForm;
begin
  if Index = 1 then
    with TRelationsEditor.Create(Application) do
    begin
      try
        AComp := Component;
        FDesigner := Self.Designer;
        DRelations := TElXRelDataSource(AComp).Relations;
        Initialize;
        ShowModal;
        Form := LMDGetOwnerForm(Component);
        if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
      finally
        Free;
      end;
    end;
  if Index = 0 then
    with TElRelDataSourceDsgn.Create(Application) do
    begin
      try
        AComp := Component;
        FDesigner := Self.Designer;
        DElRelDataSource := TElXRelDataSource(AComp);
        Initialize;
        ShowModal;
        Form := LMDGetOwnerForm(Component);
        if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
      finally
        Free;
      end;
    end;
end;

function TELRelDataSourceEditor.GetVerb(Index: Integer): string;
begin
  if Index = 1 then
    Result := 'Relations';
  if Index = 0 then
    Result := 'NewElRelDataSource';
end;

function TELRelDataSourceEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

procedure TElRelDataSourceDsgn.Button1Click(Sender: TObject);
begin
  Step := Step - 1;
  ElLabel16.Caption := 'Step '+IntToStr(Step);
  Button2.Enabled := true;
  if Step < StepCount then
    ElPageControl1.TabIndex := ElPageControl1.TabIndex - 1
  else
    ColorTabs;
  if ElPageControl1.TabIndex = 0 then
    Button1.Enabled := False
  else
    Button1.Enabled := True;
  if (ElPageControl1.TabIndex < StepCount - 1) or (StepCount = 5) then
    Button2.Caption := 'Next >';
  if (ElPageControl1.TabIndex = StepCount - 1) and (StepCount = 4) then
    Button2.Enabled := false;
  InitializeStep;
end;

procedure TElRelDataSourceDsgn.Button2Click(Sender: TObject);
begin
  Step := Step + 1;
  ElLabel16.Caption := 'Step '+IntToStr(Step);
  Button2.Enabled := true;
  if Step >= StepCount then
    ColorTabs;
  if (ElPageControl1.TabIndex < StepCount - 1) then
  begin
    ElPageControl1.TabIndex := ElPageControl1.TabIndex + 1;
    if ElPageControl1.TabIndex = 0 then
      Button1.Enabled := False
    else
      Button1.Enabled := True;
    if (ElPageControl1.TabIndex < StepCount - 1) or (StepCount = 5) then
      Button2.Caption := 'Next >';
    if (ElPageControl1.TabIndex = StepCount - 1) and (StepCount = 4) then
      Button2.Enabled := false;
  end
  else
  begin
    if (StepCount = 4) then
      ModalResult := mrOk;
  end;
  InitializeStep;
end;

procedure TElRelDataSourceDsgn.Button3Click(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
  begin
    if (StepCount = 5) and ((not Assigned(DRelationsItem.MasterDataSet)) or (not Assigned(DRelationsItem.DetailDataSet))
      or (DRelationsItem.MasterField = '') or (DRelationsItem.DetailField = '') or (DRelationsItem.DetailDisplayField = '')) then
      DElRelDataSource.Relations.DeleteItem(DRelationsItem.Index);
  end;
  Close;
end;

procedure TElRelDataSourceDsgn.FormCreate(Sender: TObject);
begin
  Step := 1;
  ElLabel17.Caption := Descr[Step];
  ElLabel16.Caption := 'Step '+IntToStr(Step);
  ElPageControl1.ActivePageIndex := 0;
  ElTabSheet6.PageIndex := 2;
  ElTabSheet7.PageIndex := 3;
  StepCount := 4;
  SelfRef := 0;
end;

procedure TElRelDataSourceDsgn.ElRadioGroup1Click(Sender: TObject);
begin
  case ElRadioGroup1.ItemIndex of
    0: begin
         ElTabSheet6.PageIndex := 2;
         ElTabSheet7.PageIndex := 3;
         StepCount := 4;
       end;
    1: begin
         ElTabSheet1.PageIndex := 2;
         ElTabSheet2.PageIndex := 3;
         ElTabSheet3.PageIndex := 4;
         StepCount := 5
       end;
  end;
end;

procedure TElRelDataSourceDsgn.ElCheckBox5Click(Sender: TObject);
begin
  ElEdit5.Enabled := ElCheckBox5.Checked;
  ElLabel21.Enabled := ElCheckBox6.Checked;
  if not ElCheckBox5.Checked then
    ElEdit5.Text := '(none)'
  else
    ElEdit5.Text := '';
  try
    DElRelDataSource.Filtered := ElCheckBox5.Checked;
  except
    raise;
    DElRelDataSource.Filter := '';
    ElEdit5.Text := '(none}';
  end;
end;

procedure TElRelDataSourceDsgn.ElCheckBox6Click(Sender: TObject);
begin
  ElEdit6.Enabled := ElCheckBox6.Checked;
  ElLabel23.Enabled := ElCheckBox6.Checked;
  if not ElCheckBox6.Checked then
    ElEdit6.Text := '(none)'
  else
    ElEdit6.Text := '';
  try
    DElRelDataSource.Filtered := ElCheckBox6.Checked;
  except
    raise;
    DElRelDataSource.Filter := '';
    ElEdit6.Text := '(none}';
  end;
end;

procedure TElRelDataSourceDsgn.ElPopupButton2Click(Sender: TObject);
begin
  if ElListBox1.ItemIndex > -1 then
  begin
    DElRelDataSource.Relations.DeleteItem(ElListBox1.ItemIndex);
    ElListBox1.Items.Delete(ElListBox1.ItemIndex);
  end;
  GetData;
end;

procedure TElRelDataSourceDsgn.ElPopupButton1Click(Sender: TObject);
var
  s : integer;
begin
  if ElListBox1.Items.Count > 0 then
    s := StrToInt(copy(ElListBox1.Items.Strings[ElListBox1.Items.Count - 1],10,length(ElListBox1.Items.Strings[ElListBox1.Items.Count - 1])-9))
  else
    s := -1;
  s:= s+1;
  ElListBox1.Items.Add('Relation ' + IntToStr(s));
  DElRelDataSource.Relations.AddItem(s);
  ElListBox1.ItemIndex := s;
  GetData;
  if (SelfRef = 1) and Assigned(DRelationsItem) then
  begin
    DRelationsItem.MasterDataSet:=DElRelDataSource.DataSet;
    DRelationsItem.DetailDataSet:=DElRelDataSource.DataSet;
    if Assigned(DElRelDataSource.DataSet) then
    begin
      if (DElRelDataSource.DataSet.Owner <> DElRelDataSource.Owner) then
      begin
        MasterDataSetCB.Text := DElRelDataSource.DataSet.Owner.Name + '.' + DElRelDataSource.DataSet.Name;
        DetailDataSetCB.Text := DElRelDataSource.DataSet.Owner.Name + '.' + DElRelDataSource.DataSet.Name;
      end
      else
      begin
        MasterDataSetCB.Text := DElRelDataSource.DataSet.Name;
        DetailDataSetCB.Text := DElRelDataSource.DataSet.Name;
      end;
    end
    else
    begin
      MasterDataSetCB.ItemIndex := -1;
      DetailDataSetCB.ItemIndex := -1;
      MasterFieldCB.ItemIndex := -1;
      DetailFieldCB.ItemIndex := -1;
    end;
    MasterDataSetCBChange(Self);
    DetailDataSetCBChange(self);
  end;
end;

procedure TElRelDataSourceDsgn.ElPageControl1Change(Sender: TObject);
begin
//  ElLabel16.Caption := 'Step '+IntToStr(Step);
  if (Step < StepCount) then
    ElLabel17.Caption := Descr[ElPageControl1.ActivePage.Tag]
  else
  begin
    ElLabel17.Caption := Descr[3]
  end;
end;

procedure TElRelDataSourceDsgn.ElPopupButton3Click(Sender: TObject);
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

procedure TElRelDataSourceDsgn.ElPopupButton4Click(Sender: TObject);
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

procedure TElRelDataSourceDsgn.ColorTabs;
var
  bmp : TBitmap;
  i : integer;
begin
  i := (Step - 5) mod 4;
  bmp := TBitmap.Create;
  ElImageList1.GetBitmap(i, Bmp);
  Image6.Picture.Assign(Bmp);
  Shape7.Brush.Color := Color1[i];
  Shape8.Brush.Color := Color2[i];
  Bmp.Free;
  ElLabel32.Caption := 'Level '+IntToStr(Step-StepCount+2);
  Button2.Caption := 'Add relation';
end;

procedure TElRelDataSourceDsgn.CheckFieldType;
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

procedure TElRelDataSourceDsgn.GetData;
begin
  if ElListBox1.ItemIndex > -1 then
    DRelationsItem := DElRelDataSource.Relations.Items[ElListBox1.ItemIndex]
  else
    DRelationsItem := nil;
  if Assigned(DRelationsItem) then
    with DRelationsItem do
    begin
      SetEnabledForControl(true);
      MasterDataSetCB.Enabled := (SelfRef = 0);
      DetailDataSetCB.Enabled := (SelfRef = 0);
      ActiveCB.Checked := Active;
      ActiveLevelEdit.Value := ActiveOnLevel;
      CaptionEdit.Text := Caption;
      DenyDisplCB.Checked := DenyLookSetPosition;
      ShowcaptionCB.Checked := ShowCaption;
      if Assigned(MasterDataSet) then
      begin
        if (MasterDataSet.Owner <> DElRelDataSource.Owner) then
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
        if (DetailDataSet.Owner <> DElRelDataSource.Owner) then
          DetailDataSetCB.Text := DetailDataSet.Owner.Name + '.' + DetailDataSet.Name
        else
          DetailDataSetCB.Text := DetailDataSet.Name;
        DetailDataSetCBChange(self);  
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

procedure TElRelDataSourceDsgn.InitializeStep;
var
  p: boolean;
  i: integer;
begin
  if (Step = 2) then
  begin
    ElRadioGroup2.Enabled := true;
    if (DElRelDataSource.Relations.Count > 0) then
    begin
      p := false;
      if Assigned(DElRelDataSource.DataSet) then
        p := true;
      for i := 0 to DElRelDataSource.Relations.Count - 1 do
      begin
        if p then
        begin
          if Assigned(DElRelDataSource.Relations.Items[i].MasterDataSet) and (DElRelDataSource.DataSet <> DElRelDataSource.Relations.Items[i].MasterDataSet) then
            p := false;
          if Assigned(DElRelDataSource.Relations.Items[i].DetailDataSet) and (DElRelDataSource.DataSet <> DElRelDataSource.Relations.Items[i].DetailDataSet) then
            p := false;
        end;
      end;
      if not p then
      begin
        ElRadioGroup2.Enabled := false;
      end;
    end;
  end
  else
  begin
    if StepCount = 5 then //simple mode
    begin
      case Step of
        3 :    //root
          begin
            Button2.Enabled := false;
            ElEdit1.Text := DElRelDataSource.Caption;
            ElCheckBox1.Checked := DElRelDataSource.ShowCaption;
            ElEdit5.Text := DElRelDataSource.Filter;
            ElCheckBox5.Checked := DElRelDataSource.Filtered;
            if Assigned(DElRelDataSource.DataSet) then
            begin
              if (DElRelDataSource.DataSet.Owner <> DElRelDataSource.Owner) then
                SimpleRootCB.Text := DElRelDataSource.DataSet.Owner.Name + '.' + DElRelDataSource.DataSet.Name
              else
                SimpleRootCB.Text := DElRelDataSource.DataSet.Name;
              SimpleRootCBChange(self);
              if DElRelDataSource.RootDataField <> '' then
                SimpleRootFieldCB.Text := DElRelDataSource.RootDataField
              else
                SimpleRootFieldCB.ItemIndex := -1;
            end
            else
            begin
              SimpleRootCB.ItemIndex := -1;
              SimpleRootFieldCB.ItemIndex := -1;
            end;
          end;
        4 :    //level 1
          begin
            Button2.Enabled := false;
            if DElRelDataSource.Relations.Count = 0 then
            begin
              DElRelDataSource.Relations.AddItem(0);
              DElRelDataSource.Relations.Items[0].ActiveOnLevel := 1;
            end;
            DRelationsItem := DElRelDataSource.Relations.Items[0];
            DRelationsItem.MasterDataSet:=DElRelDataSource.DataSet;
            SimpleMasterDataSetCB.Enabled := false;
            if (SelfRef = 1) then
            begin
              DRelationsItem.DetailDataSet:=DElRelDataSource.DataSet;
              SimpleDetailDataSetCB.Enabled := false;
            end
            else
              SimpleDetailDataSetCB.Enabled := true;
            if (DElRelDataSource.DataSet.Owner <> DElRelDataSource.Owner) then
            begin
              SimpleMasterDataSetCB.Text := DElRelDataSource.DataSet.Owner.Name + '.' + DElRelDataSource.DataSet.Name;
              if (SelfRef = 1) then
                SimpleDetailDataSetCB.Text := DElRelDataSource.DataSet.Owner.Name + '.' + DElRelDataSource.DataSet.Name;
            end
            else
            begin
              SimpleMasterDataSetCB.Text := DElRelDataSource.DataSet.Name;
              if (SelfRef = 1) then
                SimpleDetailDataSetCB.Text := DElRelDataSource.DataSet.Name;
            end;
            if (DRelationsItem.MasterField <> '') then
              SimpleMasterFieldCB.Text := DRelationsItem.MasterField
            else
              SimpleMasterFieldCB.ItemIndex := -1;
            SimpleMasterDataSetCBChange(Self);
            if Assigned(DRelationsItem.DetailDataSet) then
            begin
              if (DRelationsItem.DetailDataSet.Owner <> DElRelDataSource.Owner) then
                SimpleDetailDataSetCB.Text := DRelationsItem.DetailDataSet.Owner.Name + '.' + DRelationsItem.DetailDataSet.Name
              else
                SimpleDetailDataSetCB.Text := DRelationsItem.DetailDataSet.Name;
              if DRelationsItem.DetailField <> '' then
                SimpleDetailFieldCB.Text := DRelationsItem.DetailField;
              if DRelationsItem.DetailDisplayField <> '' then
                SimpleDetailDisplayCB.Text := DRelationsItem.DetailDisplayField;
            end
            else
            begin
              SimpleDetailDataSetCB.ItemIndex := -1;
              SimpleDetailDisplayCB.ItemIndex := -1;
              SimpleDetailFieldCB.ItemIndex := -1;
            end;
            SimpleDetailDataSetCBChange(self);
            ElEdit2.Text := DRelationsItem.Caption;
            ElCheckBox2.Checked := DRelationsItem.ShowCaption;
          end;
        else if (Step > 4) then   //level next
          begin
            Button2.Enabled := false;
            if (DElRelDataSource.Relations.Count <= Step - 4) then
            begin
              DElRelDataSource.Relations.AddItem(Step - 4);
              DElRelDataSource.Relations.Items[Step - 4].ActiveOnLevel := Step - 3;
            end;
            DRelationsItem := DElRelDataSource.Relations.Items[Step - 4];
            DRelationsItem.MasterDataSet:=DElRelDataSource.Relations.Items[Step - 5].DetailDataSet;
            SimpleMasterRelCB.Enabled := false;
            SimpleDetailRelCB.ItemIndex := -1;
            if (SelfRef = 1) then
            begin
              DRelationsItem.DetailDataSet:=DElRelDataSource.DataSet;
              SimpleDetailRelCB.Enabled := false;
            end
            else
              SimpleDetailRelCB.Enabled := true;
            if (DRelationsItem.MasterDataSet.Owner <> DElRelDataSource.Owner) then
            begin
              SimpleMasterRelCB.Text := DRelationsItem.MasterDataSet.Owner.Name + '.' + DRelationsItem.MasterDataSet.Name;
              if (SelfRef = 1) then
                SimpleDetailRelCB.Text := DElRelDataSource.DataSet.Owner.Name + '.' + DElRelDataSource.DataSet.Name;
            end
            else
            begin
              SimpleMasterRelCB.Text := DRelationsItem.MasterDataSet.Name;
              if (SelfRef = 1) then
                SimpleDetailRelCB.Text := DElRelDataSource.DataSet.Name;
            end;
            if (DRelationsItem.MasterField <> '') then
              SimpleMasterRelFieldCB.Text := DRelationsItem.MasterField
            else
              SimpleMasterRelFieldCB.ItemIndex := -1;
            SimpleMasterRelCBChange(Self);
            if Assigned(DRelationsItem.DetailDataSet) then
            begin
              if (DRelationsItem.DetailDataSet.Owner <> DElRelDataSource.Owner) then
                SimpleDetailRelCB.Text := DRelationsItem.DetailDataSet.Owner.Name + '.' + DRelationsItem.DetailDataSet.Name
              else
                SimpleDetailRelCB.Text := DRelationsItem.DetailDataSet.Name;
              if DRelationsItem.DetailField <> '' then
                SimpleDetailRelFieldCB.Text := DRelationsItem.DetailField;
              if DRelationsItem.DetailDisplayField <> '' then
                SimpleDetailRelDisplayCB.Text := DRelationsItem.DetailDisplayField;
            end
            else
            begin
              SimpleDetailRelCB.ItemIndex := -1;
              SimpleDetailRelDisplayCB.ItemIndex := -1;
              SimpleDetailRelFieldCB.ItemIndex := -1;
            end;
            SimpleDetailRelCBChange(self);
            ElEdit3.Text := DRelationsItem.Caption;
            ElCheckBox3.Checked := DRelationsItem.ShowCaption;
          end;
      end;
    end
    else //expert mode
    begin
      case Step of
        3 :
          begin
            ElEdit4.Text := DElRelDataSource.Caption;
            ElCheckBox4.Checked := DElRelDataSource.ShowCaption;
            ElEdit6.Text := DElRelDataSource.Filter;
            ElCheckBox6.Checked := DElRelDataSource.Filtered;
            ElCheckBox9.Checked := DElRelDataSource.DenyLookSetPosition;
            if Assigned(DElRelDataSource.DataSet) then
            begin
              if (DElRelDataSource.DataSet.Owner <> DElRelDataSource.Owner) then
                RootCB.Text := DElRelDataSource.DataSet.Owner.Name + '.' + DElRelDataSource.DataSet.Name
              else
                RootCB.Text := DElRelDataSource.DataSet.Name;
              RootCBChange(self);
              if DElRelDataSource.RootDataField <> '' then
                RootFieldCB.Text := DElRelDataSource.RootDataField
              else
                RootFieldCB.ItemIndex := -1;
            end
            else
            begin
              RootCB.ItemIndex := -1;
              RootFieldCB.ItemIndex := -1;
            end;
          end;
        4 :
          begin
            ElListBox1.ItemIndex := 0;
            GetData;
            MasterDataSetCBChange(self);
            DetailDataSetCBChange(self);
          end;
      end;
    end;
  end;
end;

procedure TElRelDataSourceDsgn.Initialize;
var
  i : integer;
  p : boolean;
begin
  FDesigner.GetComponentNames(GetTypeData(TDataSet.ClassInfo), SetDBStr);
  if DElRelDataSource.Relations.Count > 0 then
  begin
    p := false;
    if Assigned(DElRelDataSource.DataSet) then
      p := true;
    for i := 0 to DElRelDataSource.Relations.Count - 1 do
    begin
      ElListBox1.Items.Add(DElRelDataSource.Relations.Items[i].Name) ;
      if p then
      begin
        if Assigned(DElRelDataSource.Relations.Items[i].MasterDataSet) and (DElRelDataSource.DataSet <> DElRelDataSource.Relations.Items[i].MasterDataSet) then
          p := false;
        if Assigned(DElRelDataSource.Relations.Items[i].DetailDataSet) and (DElRelDataSource.DataSet <> DElRelDataSource.Relations.Items[i].DetailDataSet) then
          p := false;
      end;
    end;
    ElListBox1.ItemIndex := 0;
    if p then
    begin
      ElRadioGroup2.ItemIndex := 1;
      SelfRef := 1;
    end;
  end;
end;

procedure TElRelDataSourceDsgn.SetDBStr(const S: string);
begin
  RootCB.Items.Add(S);
  MasterDataSetCB.Items.Add(S);
  DetailDataSetCB.Items.Add(S);
  SimpleRootCB.Items.Add(S);
  SimpleMasterDataSetCB.Items.Add(S);
  SimpleDetailDataSetCB.Items.Add(S);
  SimpleMasterRelCB.Items.Add(S);
  SimpleDetailRelCB.Items.Add(S);
end;

procedure TElRelDataSourceDsgn.SetEnabledForControl(val: Boolean);
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

procedure TElRelDataSourceDsgn.ActiveCBClick(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.Active := ActiveCB.Checked;
end;

procedure TElRelDataSourceDsgn.CaptionEditChange(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.Caption:=CaptionEdit.Text;
end;

procedure TElRelDataSourceDsgn.ShowcaptionCBClick(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.ShowCaption:=ShowcaptionCB.Checked;
end;

procedure TElRelDataSourceDsgn.MasterDataSetCBChange(Sender: TObject);
var
  i: integer;
  s: string;
  LActive, LOpened: boolean;
begin
  LOpened := False;
  s := MasterFieldCB.Text;
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

procedure TElRelDataSourceDsgn.MasterFieldCBChange(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.MasterField:=MasterFieldCB.Text;
  CheckFieldType;
end;

procedure TElRelDataSourceDsgn.DetailDataSetCBChange(Sender: TObject);
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

procedure TElRelDataSourceDsgn.DetailFieldCBChange(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.DetailField:=DetailFieldCB.Text;
  CheckFieldType;
end;

procedure TElRelDataSourceDsgn.DetailDisplayCBChange(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.DetailDisplayField:=DetailDisplayCB.Text;
end;

procedure TElRelDataSourceDsgn.DenyDisplCBClick(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.DenyLookSetPosition:=DenyDisplCB.Checked;
end;

procedure TElRelDataSourceDsgn.ActiveLevelEditChange(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.ActiveOnLevel := ActiveLevelEdit.Value;
end;

procedure TElRelDataSourceDsgn.ElListBox1Click(Sender: TObject);
begin
  GetData;
end;

procedure TElRelDataSourceDsgn.ElRadioGroup2Click(Sender: TObject);
begin
  SelfRef := ElRadioGroup2.ItemIndex;
end;

procedure TElRelDataSourceDsgn.ElEdit4Change(Sender: TObject);
begin
  if Assigned(DElRelDataSource) then
    DElRelDataSource.Caption := ElEdit4.Text;
end;

procedure TElRelDataSourceDsgn.ElCheckBox4Click(Sender: TObject);
begin
  if Assigned(DElRelDataSource) then
    DElRelDataSource.ShowCaption := ElCheckBox4.Checked;
end;

procedure TElRelDataSourceDsgn.RootCBChange(Sender: TObject);
var
  i: integer;
  s: string;
  p: boolean;
  LActive, LOpened: boolean;
begin
  LOpened := False;
  s := RootFieldCB.Text;
  RootFieldCB.Items.Clear;
  if RootCB.Text <> '' then
  begin
    DElRelDataSource.RootDataSet := TDataSet(FDesigner.GetComponent(RootCB.Text));
    LActive := DElRelDataSource.RootDataSet.Active;
    try
      if (DElRelDataSource.RootDataSet.FieldCount = 0) then
      begin
        DElRelDataSource.RootDataSet.DisableControls;
        if not DElRelDataSource.RootDataSet.Active then
         DElRelDataSource.RootDataSet.Open;
        LOpened := True;
      end;
      for i := 0 to DElRelDataSource.RootDataSet.FieldCount - 1 do
      begin
        RootFieldCB.Items.Add(DElRelDataSource.RootDataSet.Fields[i].FieldName);
      end;
      if RootFieldCB.Items.IndexOf(s) > -1 then
        RootFieldCB.Text := s
      else
        RootFieldCB.ItemIndex := -1;
      finally
        if LOpened then
        begin
          DElRelDataSource.RootDataSet.Active := LActive;
          DElRelDataSource.RootDataSet.EnableControls;
        end;
      end;
  end
  else
    DElRelDataSource.RootDataSet:=nil;
  if (SelfRef = 1) and (DElRelDataSource.Relations.Count > 0) then
  begin
    p := false;
    if Assigned(DElRelDataSource.DataSet) then
      p := true;
    for i := 0 to DElRelDataSource.Relations.Count - 1 do
    begin
      if p then
      begin
        if Assigned(DElRelDataSource.Relations.Items[i].MasterDataSet) and (DElRelDataSource.DataSet <> DElRelDataSource.Relations.Items[i].MasterDataSet) then
          p := false;
        if Assigned(DElRelDataSource.Relations.Items[i].DetailDataSet) and (DElRelDataSource.DataSet <> DElRelDataSource.Relations.Items[i].DetailDataSet) then
          p := false;
      end;
    end;
    if not p then
    begin
      ShowMessage(SNoSelfRefrence);
      ElRadioGroup2.ItemIndex := 0;
      SelfRef := 0;
    end;
  end;
end;

procedure TElRelDataSourceDsgn.RootFieldCBChange(Sender: TObject);
begin
  if Assigned(DElRelDataSource) then
    DElRelDataSource.DataField:=RootFieldCB.Text;
end;

procedure TElRelDataSourceDsgn.ElEdit6Change(Sender: TObject);
begin
  if (ElEdit6.Text <> '(none)') and (ElEdit6.Text <> '') then
  begin
    try
      DElRelDataSource.Filter := ElEdit6.Text;
    except
      raise;
      DElRelDataSource.Filter := '';
      ElEdit6.Text := '(none}';
    end;
  end
  else
    DElRelDataSource.Filter := '';
end;

procedure TElRelDataSourceDsgn.ElCheckBox9Click(Sender: TObject);
begin
  if Assigned(DElRelDataSource) then
    DElRelDataSource.DenyLookSetPosition:=ElCheckBox9.Checked;
end;

procedure TElRelDataSourceDsgn.ElCheckBox1Click(Sender: TObject);
begin
  if Assigned(DElRelDataSource) then
    DElRelDataSource.ShowCaption := ElCheckBox1.Checked;
end;

procedure TElRelDataSourceDsgn.ElEdit1Change(Sender: TObject);
begin
  if Assigned(DElRelDataSource) then
    DElRelDataSource.Caption := ElEdit1.Text;
end;

procedure TElRelDataSourceDsgn.SimpleRootCBChange(Sender: TObject);
var
  i: integer;
  s: string;
  p: boolean;
begin
  s := SimpleRootFieldCB.Text;
  SimpleRootFieldCB.Items.Clear;
  if SimpleRootCB.Text <> '' then
  begin
    DElRelDataSource.RootDataSet:=TDataSet(FDesigner.GetComponent(SimpleRootCB.Text));
    for i := 0 to DElRelDataSource.DataSet.FieldCount - 1 do
    begin
      SimpleRootFieldCB.Items.Add(DElRelDataSource.DataSet.Fields[i].FieldName);
    end;
    if SimpleRootFieldCB.Items.IndexOf(s) > -1 then
      SimpleRootFieldCB.Text := s
    else
      SimpleRootFieldCB.ItemIndex := -1;
  end
  else
    DElRelDataSource.RootDataSet:=nil;
  if (SelfRef = 1) and (DElRelDataSource.Relations.Count > 0) then
  begin
    p := false;
    if Assigned(DElRelDataSource.DataSet) then
      p := true;
    for i := 0 to DElRelDataSource.Relations.Count - 1 do
    begin
      if p then
      begin
        if Assigned(DElRelDataSource.Relations.Items[i].MasterDataSet) and (DElRelDataSource.DataSet <> DElRelDataSource.Relations.Items[i].MasterDataSet) then
          p := false;
        if Assigned(DElRelDataSource.Relations.Items[i].DetailDataSet) and (DElRelDataSource.DataSet <> DElRelDataSource.Relations.Items[i].DetailDataSet) then
          p := false;
      end;
    end;
    if not p then
    begin
      ShowMessage(SNoSelfRefrence);
      ElRadioGroup2.ItemIndex := 0;
      SelfRef := 0;
    end;
  end;
  FinalizeStep;
end;

procedure TElRelDataSourceDsgn.SimpleRootFieldCBChange(Sender: TObject);
begin
  if Assigned(DElRelDataSource) then
    DElRelDataSource.DataField:=SimpleRootFieldCB.Text;
  FinalizeStep;
end;

procedure TElRelDataSourceDsgn.ElEdit5Change(Sender: TObject);
begin
  if (ElEdit5.Text <> '(none)') and (ElEdit5.Text <> '') then
  begin
    try
      DElRelDataSource.Filter := ElEdit5.Text;
    except
      raise;
      DElRelDataSource.Filter := '';
      ElEdit5.Text := '(none}';
    end;
  end
  else
    DElRelDataSource.Filter := '';
end;

procedure TElRelDataSourceDsgn.FinalizeStep;
begin
  case Step of
    3:  if Assigned(DElRelDataSource.DataSet) and (DElRelDataSource.RootDataField <> '') then
          Button2.Enabled := true
        else
          Button2.Enabled := false;
    4:  if Assigned(DElRelDataSource.relations.items[0].MasterDataSet) and (DElRelDataSource.relations.items[0].MasterField <> '')
          and Assigned(DElRelDataSource.relations.items[0].DetailDataSet) and (DElRelDataSource.relations.items[0].DetailField <> '') and (DElRelDataSource.relations.items[0].DetailDisplayField <> '') then
          Button2.Enabled := true
        else
          Button2.Enabled := false;
    else  if Assigned(DElRelDataSource.relations.items[Step - 4].MasterDataSet) and (DElRelDataSource.relations.items[Step - 4].MasterField <> '')
            and Assigned(DElRelDataSource.relations.items[Step - 4].DetailDataSet) and (DElRelDataSource.relations.items[Step - 4].DetailField <> '') and (DElRelDataSource.relations.items[Step - 4].DetailDisplayField <> '') then
            Button2.Enabled := true
          else
            Button2.Enabled := false;
  end;
end;

procedure TElRelDataSourceDsgn.SimpleMasterDataSetCBChange(Sender: TObject);
var
  i: integer;
  s: string;
begin
  s := SimpleMasterFieldCB.Text;
  SimpleMasterFieldCB.Items.Clear;
  if Assigned(DRelationsItem) then
  begin
    if SimpleMasterDataSetCB.Text <> '' then
    begin
      DRelationsItem.MasterDataSet:=TDataSet(FDesigner.GetComponent(SimpleMasterDataSetCB.Text));
      for i := 0 to DRelationsItem.MasterDataSet.FieldCount - 1 do
      begin
        SimpleMasterFieldCB.Items.Add(DRelationsItem.MasterDataSet.Fields[i].FieldName);
      end;
      if SimpleMasterFieldCB.Items.IndexOf(s) > -1 then
        SimpleMasterFieldCB.Text := s
      else
        SimpleMasterFieldCB.ItemIndex := -1;
    end
    else
      DRelationsItem.MasterDataSet:=nil;
  end;
  FinalizeStep;
end;

procedure TElRelDataSourceDsgn.SimpleDetailDataSetCBChange(
  Sender: TObject);
var
  i: integer;
  s1, s2: string;
begin
  s1 := SimpleDetailFieldCB.Text;
  s2 := SimpleDetailDisplayCB.Text;
  SimpleDetailFieldCB.Items.Clear;
  SimpleDetailDisplayCB.Items.Clear;
  if Assigned(DRelationsItem) then
  begin
      if SimpleDetailDataSetCB.Text <> '' then
    begin
      DRelationsItem.DetailDataSet:=TDataSet(FDesigner.GetComponent(SimpleDetailDataSetCB.Text));
      for i := 0 to DRelationsItem.DetailDataSet.FieldCount - 1 do
      begin
        SimpleDetailFieldCB.Items.Add(DRelationsItem.DetailDataSet.Fields[i].FieldName);
        SimpleDetailDisplayCB.Items.Add(DRelationsItem.DetailDataSet.Fields[i].FieldName);
      end;
      if SimpleDetailFieldCB.Items.IndexOf(s1) > -1 then
        SimpleDetailFieldCB.Text := s1
      else
        SimpleDetailFieldCB.ItemIndex := -1;
      if SimpleDetailDisplayCB.Items.IndexOf(s2) > -1 then
        SimpleDetailDisplayCB.Text := s2
      else
        SimpleDetailDisplayCB.ItemIndex := -1;
    end
    else
      DRelationsItem.DetailDataSet:=nil;
  end;
  FinalizeStep;
end;

procedure TElRelDataSourceDsgn.SimpleMasterFieldCBChange(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.MasterField:=SimpleMasterFieldCB.Text;
  CheckFieldType;
  FinalizeStep;
end;

procedure TElRelDataSourceDsgn.SimpleDetailFieldCBChange(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.DetailField:=SimpleDetailFieldCB.Text;
  CheckFieldType;
  FinalizeStep;
end;

procedure TElRelDataSourceDsgn.SimpleDetailDisplayCBChange(
  Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.DetailDisplayField:=SimpleDetailDisplayCB.Text;
  FinalizeStep;
end;

procedure TElRelDataSourceDsgn.ElEdit2Change(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.Caption:=ElEdit2.Text;
end;

procedure TElRelDataSourceDsgn.ElCheckBox2Click(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.ShowCaption:=ElCheckBox2.Checked;
end;

procedure TElRelDataSourceDsgn.SimpleMasterRelCBChange(Sender: TObject);
var
  i: integer;
  s: string;
begin
  s := SimpleMasterRelFieldCB.Text;
  SimpleMasterRelFieldCB.Items.Clear;
  if Assigned(DRelationsItem) then
  begin
    if SimpleMasterRelCB.Text <> '' then
    begin
      DRelationsItem.MasterDataSet:=TDataSet(FDesigner.GetComponent(SimpleMasterRelCB.Text));
      for i := 0 to DRelationsItem.MasterDataSet.FieldCount - 1 do
      begin
        SimpleMasterRelFieldCB.Items.Add(DRelationsItem.MasterDataSet.Fields[i].FieldName);
      end;
      if SimpleMasterRelFieldCB.Items.IndexOf(s) > -1 then
        SimpleMasterRelFieldCB.Text := s
      else
        SimpleMasterRelFieldCB.ItemIndex := -1;
    end
    else
      DRelationsItem.MasterDataSet:=nil;
  end;
  FinalizeStep;
end;

procedure TElRelDataSourceDsgn.SimpleDetailRelCBChange(Sender: TObject);
var
  i: integer;
  s1, s2: string;
begin
  s1 := SimpleDetailRelFieldCB.Text;
  s2 := SimpleDetailRelDisplayCB.Text;
  SimpleDetailRelFieldCB.Items.Clear;
  SimpleDetailRelDisplayCB.Items.Clear;
  if Assigned(DRelationsItem) then
  begin
      if SimpleDetailRelCB.Text <> '' then
    begin
      DRelationsItem.DetailDataSet:=TDataSet(FDesigner.GetComponent(SimpleDetailRelCB.Text));
      for i := 0 to DRelationsItem.DetailDataSet.FieldCount - 1 do
      begin
        SimpleDetailRelFieldCB.Items.Add(DRelationsItem.DetailDataSet.Fields[i].FieldName);
        SimpleDetailRelDisplayCB.Items.Add(DRelationsItem.DetailDataSet.Fields[i].FieldName);
      end;
      if SimpleDetailRelFieldCB.Items.IndexOf(s1) > -1 then
        SimpleDetailRelFieldCB.Text := s1
      else
        SimpleDetailRelFieldCB.ItemIndex := -1;
      if SimpleDetailRelDisplayCB.Items.IndexOf(s2) > -1 then
        SimpleDetailRelDisplayCB.Text := s2
      else
        SimpleDetailRelDisplayCB.ItemIndex := -1;
    end
    else
      DRelationsItem.DetailDataSet:=nil;
  end;
  FinalizeStep;
end;

procedure TElRelDataSourceDsgn.SimpleMasterRelFieldCBChange(
  Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.MasterField:=SimpleMasterRelFieldCB.Text;
  CheckFieldType;
  FinalizeStep;
end;

procedure TElRelDataSourceDsgn.SimpleDetailRelFieldCBChange(
  Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.DetailField:=SimpleDetailRelFieldCB.Text;
  CheckFieldType;
  FinalizeStep;
end;

procedure TElRelDataSourceDsgn.SimpleDetailRelDisplayCBChange(
  Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.DetailDisplayField:=SimpleDetailRelDisplayCB.Text;
  FinalizeStep;
end;

procedure TElRelDataSourceDsgn.ElEdit3Change(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.Caption:=ElEdit3.Text;
end;

procedure TElRelDataSourceDsgn.ElCheckBox3Click(Sender: TObject);
begin
  if Assigned(DRelationsItem) then
    DRelationsItem.ShowCaption:=ElCheckBox3.Checked;
end;

end.
