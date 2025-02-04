unit GeoControlProp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DesignIntf, DesignEditors, StdCtrls, ExtCtrls, GeoControl;

type
  TfmGXOutlookEditor = class(TForm)
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    btnSectionAdd: TButton;
    btnSectionDelete: TButton;
    btnItemAdd: TButton;
    btnDeleteAdd: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    edSection: TEdit;
    Label2: TLabel;
    edCaption: TEdit;
    btnMoveUp: TButton;
    btnMoveDown: TButton;
    cbEnabled: TCheckBox;
    edImageIndex: TEdit;
    Label3: TLabel;
    cbVisible: TCheckBox;
    Label4: TLabel;
    cmbAction: TComboBox;
    procedure edSectionChange(Sender: TObject);
    procedure edCaptionChange(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSectionAddClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnSectionDeleteClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure OutlookChange(Sender: TObject);
    procedure UpdateActionCombo;
    procedure btnMoveUpClick(Sender: TObject);
    procedure btnMoveDownClick(Sender: TObject);
    procedure btnDisabledClick(Sender: TObject);
    procedure btnSelectedClick(Sender: TObject);
    procedure cbEnabledClick(Sender: TObject);
    procedure edImageIndexChange(Sender: TObject);
    procedure edImageIndexKeyPress(Sender: TObject; var Key: Char);
    procedure cbVisibleClick(Sender: TObject);
    procedure cmbActionChange(Sender: TObject);
    procedure cmbActionKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    Outlook: TGeoCustomControl;
    FUpdateFlag: Boolean;
  public
    { Public declarations }
    CompOutLook: TGeoCustomControl;
    Modified: Boolean;
  end;

  type TGeoControlEditor = class(TComponentEditor)
  public
   function GetVerb(Index: Integer): string; override;
   function GetVerbCount: Integer; override;
   procedure ExecuteVerb(Index: Integer); override;
  end;

var
  fmGXOutlookEditor: TfmGXOutlookEditor;

procedure CopyOutlook(Source,Dest: TGeoCustomControl);

implementation

{$R *.DFM}

type
  TFEGXOutlookHack = class(TGeoCustomControl);

procedure CopyOutlook(Source,Dest: TGeoCustomControl);
var
  Button: TGXOutlookItems;
  i: Integer;
Begin
  Dest.Clear;
  for i := 0 to Source.Count - 1 do
  begin
    Button:=Dest.Add;
    Button.Assign(Source.Items[i]);
  end;
  with TFEGXOutlookHack(Dest) do
  begin
    Font.Assign(TFEGXOutlookHack(Source).Font);
    SelectedFont.Assign(TFEGXOutlookHack(Source).SelectedFont);
    ButtonFont.Assign(TFEGXOutlookHack(Source).ButtonFont);
    Background.Assign(TFEGXOutlookHack(Source).Background);
    Images := TFEGXOutlookHack(Source).Images;
    Spacing := TFEGXOutlookHack(Source).Spacing;
    TopSpacing := TFEGXOutlookHack(Source).TopSpacing;
    FrameStyle := TFEGXOutlookHack(Source).FrameStyle;
    ButtonColor := TFEGXOutlookHack(Source).ButtonColor;
  end;
End;

function TGeoControlEditor.GetVerb(Index: Integer): string;
Begin
  Result := '&Edit Items...';
End;

function TGeoControlEditor.GetVerbCount: Integer;
Begin
  Result := 1;
End;

procedure TGeoControlEditor.ExecuteVerb(Index: Integer);
var
  Dlg: TfmGXOutLookEditor;
Begin
  Dlg:=TfmGXOutlookeditor.Create(Application);
  Try
    Dlg.CompOutlook := TGeoCustomControl(Component);
    CopyOutlook(TGeoCustomControl(Component),Dlg.Outlook);
    Dlg.UpdateActionCombo;
    Dlg.OutlookChange(Dlg.Outlook);
    Dlg.ShowModal;
    if Dlg.ModalResult = mrOK then
    begin
      if Dlg.Modified then
      begin
        CopyOutlook(Dlg.Outlook, TGeoCustomControl(Component));
        Designer.Modified;
      end;
    end;
  finally
    Dlg.Free;
  End;
End;

procedure TfmGXOutlookEditor.FormCreate(Sender: TObject);
begin
  Modified := False;
  FUpdateFlag := false;
  Outlook := TGeoCustomControl.Create(self);
  Outlook.Parent := GroupBox1;
  Outlook.SetBounds(8, 16, 120, GroupBox1.ClientHeight - 24);
  TFEGXOutlookHack(Outlook).Design:=True;
  TFEGXOutlookHack(Outlook).OnChange := OutlookChange;
end;

procedure TfmGXOutlookEditor.edSectionChange(Sender: TObject);
begin
  if TFEGXOutlookHack(Outlook).SelectedButton >= 0 then
  begin
    Outlook.Items[TFEGXOutlookHack(Outlook).SelectedButton].Caption := edSection.Text;
    Modified := true;
  end;
end;

procedure TfmGXOutlookEditor.edCaptionChange(Sender: TObject);
begin
  if FUpdateFlag then EXIT;
  if (TFEGXOutlookHack(Outlook).SelectedButton >= 0) and
     (TFEGXOutlookHack(Outlook).SelectedItem >= 0) then
  begin
    Outlook.Items[TFEGXOutlookHack(Outlook).SelectedButton].Items[TFEGXOutlookHack(Outlook).SelectedItem].Caption := edCaption.Text;
    Modified:=True;
  end;
end;

procedure TfmGXOutlookEditor.btnLoadClick(Sender: TObject);
begin
  {if (TFEGXOutlookHack(Outlook).SelectedButton >= 0) and (TFEGXOutlookHack(Outlook).SelectedItem >= 0) then
    if OpenDialog1.Execute then
    begin
      TFEGXOutlookHack(Outlook).Items[TFEGXOutlookHack(Outlook).SelectedButton].Items[TFEGXOutlookHack(Outlook).SelectedItem].Icon.LoadFromFile(OpenDialog1.FileName);
      imNormal.Picture.LoadFromFile(OpenDialog1.FileName);
      Modified:=True;
    end;}
end;

procedure TfmGXOutlookEditor.btnSectionAddClick(Sender: TObject);
begin
  TFEGXOutlookHack(Outlook).SmoothScrolling := False;
  Try
//    TFEGXOutlookHack(Outlook).Add;

    with TFEGXOutlookHack(Outlook).Add do
      Caption := 'New';
    TFEGXOutlookHack(Outlook).SelectedButton := TFEGXOutlookHack(Outlook).Count - 1;
    OutlookChange(Outlook);
  finally
    TFEGXOutlookHack(Outlook).SmoothScrolling := True;
  end;
end;

procedure TfmGXOutlookEditor.btnAddClick(Sender: TObject);
begin
  if TFEGXOutlookHack(Outlook).SelectedButton < 0 then exit;
  with TFEGXOutlookHack(Outlook).Items[TFEGXOutlookHack(Outlook).SelectedButton].Add do
    Caption:='New';
  TFEGXOutlookHack(Outlook).SelectedItem := TFEGXOutlookHack(Outlook).Items[TFEGXOutlookHack(Outlook).SelectedButton].Count-1;
  OutlookChange(Outlook);
end;

procedure TfmGXOutlookEditor.btnSectionDeleteClick(Sender: TObject);
begin
  if TFEGXOutlookHack(Outlook).SelectedButton >= 0 then
    TFEGXOutlookHack(Outlook).Delete(TFEGXOutlookHack(Outlook).SelectedButton);
  OutlookChange(Outlook);
end;

procedure TfmGXOutlookEditor.btnDeleteClick(Sender: TObject);
var
  i: Integer;
begin
  if (TFEGXOutlookHack(Outlook).SelectedButton >= 0) and (TFEGXOutlookHack(Outlook).SelectedItem >= 0) then
  begin
    i := TFEGXOutlookHack(Outlook).SelectedItem;
    TFEGXOutlookHack(Outlook).Items[TFEGXOutlookHack(Outlook).SelectedButton].Delete(TFEGXOutlookHack(Outlook).SelectedItem);
    if i > TFEGXOutlookHack(Outlook).Items[TFEGXOutlookHack(Outlook).SelectedButton].Count - 1 then
      i := TFEGXOutlookHack(Outlook).Items[TFEGXOutlookHack(Outlook).SelectedButton].Count - 1;
    TFEGXOutlookHack(Outlook).SelectedItem := i;
  end;
  OutlookChange(Outlook);
end;

procedure TfmGXOutlookEditor.OutlookChange(Sender: TObject);
begin
  FUpdateFlag := True;
  TRY
    if TFEGXOutlookHack(Outlook).SelectedButton < 0 then
    begin
      edSection.Text := '';
      edCaption.Text := '';
      edImageIndex.Text := '';
      edSection.ReadOnly:=True;
      edSection.Color:=clBtnFace;
      edCaption.ReadOnly:=True;
      edImageIndex.ReadOnly:=True;
      edCaption.Color:=clBtnFace;
      edImageIndex.Color:=clBtnFace;
      cbEnabled.Enabled:=False;
      cbVisible.Enabled:=False;
      cmbAction.ItemIndex := -1;
      cmbAction.Color:=clBtnFace;
      cmbAction.Enabled:=False;
      Exit;
    end;
    edSection.Text:=Outlook.Items[TFEGXOutlookHack(Outlook).SelectedButton].Caption;
    edSection.ReadOnly:=False;
    edSection.Color:=clWindow;
    if TFEGXOutlookHack(Outlook).SelectedItem < 0 then
    begin
      edCaption.Text:='';
      edImageIndex.Text := '';
      edCaption.ReadOnly:=True;
      edImageIndex.ReadOnly:=True;
      edCaption.Color:=clBtnFace;
      edImageIndex.Color:=clBtnFace;
      cbEnabled.Enabled:=False;
      cbVisible.Enabled:=False;
      cmbAction.ItemIndex := -1;
      cmbAction.Color:=clBtnFace;
      cmbAction.Enabled:=False;
      Exit;
    end;
    edCaption.ReadOnly:=False;
    edImageIndex.ReadOnly:=False;
    edCaption.Color:=clWindow;
    edImageIndex.Color:=clWindow;
    cmbAction.Color:=clWindow;
    cbEnabled.Enabled:=True;
    cbVisible.Enabled:=True;
    cmbAction.Enabled:=True;
    with TFEGXOutlookHack(Outlook) do
    begin
      edImageIndex.Text := IntToStr(Items[SelectedButton].Items[SelectedItem].ImageIndex);
      edCaption.Text := Items[SelectedButton].Items[SelectedItem].Caption;
      cbEnabled.Checked := Items[SelectedButton].Items[SelectedItem].Enabled;
      cbVisible.Checked := Items[SelectedButton].Items[SelectedItem].Visible;

      if Assigned(Items[SelectedButton].Items[SelectedItem].Action) then
        cmbAction.ItemIndex  := cmbAction.Items.IndexOfObject(Items[SelectedButton].Items[SelectedItem].Action)
      else
        cmbAction.ItemIndex := -1;
    end;
  FINALLY
    FUpdateFlag := false;
  END;
end;

procedure TfmGXOutlookEditor.UpdateActionCombo;
var
  i: Integer;
  Owner: TComponent;
begin
  Owner := CompOutlook.Owner;
  for i := 0 to Owner.ComponentCount - 1 do
    if Owner.Components[i] is TBasicAction then
      cmbAction.Items.AddObject(Owner.Components[i].Name, Owner.Components[i]);
end;

procedure TfmGXOutlookEditor.btnMoveUpClick(Sender: TObject);
begin
  with TFEGXOutlookHack(Outlook) do
    if (SelectedButton >= 0) then
      if (SelectedItem > 0) then
      begin
        Items[SelectedButton].Swap(SelectedItem,SelectedItem - 1);
        SelectedItem := SelectedItem - 1;
      end;
end;

procedure TfmGXOutlookEditor.btnMoveDownClick(Sender: TObject);
begin
  with TFEGXOutlookHack(Outlook) do
    if (SelectedButton >= 0) then
      if (SelectedItem < Items[SelectedButton].Count - 1) then
      begin
        Items[SelectedButton].Swap(SelectedItem,SelectedItem + 1);
        SelectedItem := SelectedItem + 1;
      end;
end;

procedure TfmGXOutlookEditor.btnDisabledClick(Sender: TObject);
begin{
  with TFEGXOutlookHack(Outlook) do
    if (SelectedButton >= 0) and (SelectedItem >= 0) then
      if OpenDialog1.Execute then
      begin
        Items[SelectedButton].Items[SelectedItem].DisabledIcon.LoadFromFile(OpenDialog1.FileName);
        imDisabled.Picture.LoadFromFile(OpenDialog1.FileName);
        Modified:=True;
      end;}
end;

procedure TfmGXOutlookEditor.btnSelectedClick(Sender: TObject);
begin{
  with TFEGXOutlookHack(Outlook) do
    if (SelectedButton >= 0) and (SelectedItem >= 0) then
      if OpenDialog1.Execute then
      begin
        Items[SelectedButton].Items[SelectedItem].SelectedIcon.LoadFromFile(OpenDialog1.FileName);
        imSelected.Picture.LoadFromFile(OpenDialog1.FileName);
        Modified := True;
      end;}
end;

procedure TfmGXOutlookEditor.cbEnabledClick(Sender: TObject);
begin
  if FUpdateFlag then EXIT;
  with TFEGXOutlookHack(Outlook) do
    if (SelectedButton >= 0) and (SelectedItem >= 0) then
    begin
      Items[SelectedButton].Items[SelectedItem].Enabled := cbEnabled.Checked;
      Modified := True;
    end;
end;

procedure TfmGXOutlookEditor.edImageIndexChange(Sender: TObject);
begin
  if FUpdateFlag then EXIT;
  if (TFEGXOutlookHack(Outlook).SelectedButton >= 0) and
     (TFEGXOutlookHack(Outlook).SelectedItem >= 0) then
  begin
    if edImageIndex.Text <> '-' then
    begin
      if edImageIndex.Text = '' then
        Outlook.Items[TFEGXOutlookHack(Outlook).SelectedButton].Items[TFEGXOutlookHack(Outlook).SelectedItem].ImageIndex := -1
      else
        TRY
          Outlook.Items[TFEGXOutlookHack(Outlook).SelectedButton].Items[TFEGXOutlookHack(Outlook).SelectedItem].ImageIndex := StrToInt(edImageIndex.Text);
        EXCEPT
          Outlook.Items[TFEGXOutlookHack(Outlook).SelectedButton].Items[TFEGXOutlookHack(Outlook).SelectedItem].ImageIndex := -1;
        END;  
    end;  
    Modified:=True;
  end;
end;

procedure TfmGXOutlookEditor.edImageIndexKeyPress(Sender: TObject;
  var Key: Char);
begin
  if NOT (Key in ['0','1','2','3','4','5','6','7','8','9','-', #8]) then
    Key := #0;
end;

procedure TfmGXOutlookEditor.cbVisibleClick(Sender: TObject);
begin
  if FUpdateFlag then EXIT;
  with TFEGXOutlookHack(Outlook) do
    if (SelectedButton >= 0) and (SelectedItem >= 0) then
    begin
      Items[SelectedButton].Items[SelectedItem].Visible := cbVisible.Checked;
      Modified := True;
    end;
end;

procedure TfmGXOutlookEditor.cmbActionChange(Sender: TObject);
begin
  if FUpdateFlag then EXIT;
  if (TFEGXOutlookHack(Outlook).SelectedButton >= 0) and
     (TFEGXOutlookHack(Outlook).SelectedItem >= 0) then
  begin
    if cmbAction.ItemIndex > -1 then
      Outlook.Items[TFEGXOutlookHack(Outlook).SelectedButton].Items[TFEGXOutlookHack(Outlook).SelectedItem].Action := TBasicAction(cmbAction.Items.Objects[cmbAction.ItemIndex])
    else
      Outlook.Items[TFEGXOutlookHack(Outlook).SelectedButton].Items[TFEGXOutlookHack(Outlook).SelectedItem].Action := nil;
    Modified:=True;
  end;
end;

procedure TfmGXOutlookEditor.cmbActionKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
    cmbAction.ItemIndex := -1;
end;

end.
