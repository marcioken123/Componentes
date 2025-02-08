unit pLMDHideNonVC;
{$I lmdcmps.inc}

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls, Forms, Variants,
  DesignIntf,DesignWindows,DesignEditors,
  Menus, StdCtrls, ExtCtrls, Dialogs,
  LMDClass, LMDFormA, LMDStrings, LMDHideNonVC, LMDThemes,
  LMDCustomPanel, LMDCustomBevelPanel, LMDWndProcComponent, LMDSimplePanel,
  LMDCustomComponent, LMDCustomControl, LMDButton, LMDCustomButton, LMDControl;

type

  TLMDHideNonVCfrm = class(TDesignWindow)
    cbList: TListBox;
    popMenu: TPopupMenu;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDSimplePanel2: TLMDSimplePanel;
    lbl: TLabel;
    d: TLabel;
    CloseButton: TLMDButton;
    btHide: TLMDButton;
    btShow: TLMDButton;
    btshowall: TLMDButton;
    btHideAll: TLMDButton;
    btDelete: TLMDButton;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure btHideClick(Sender: TObject);
    procedure btshowClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure HandleClick(Sender: TObject);
    procedure popMenuPopup(Sender: TObject);
    procedure cbListMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cbListKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FComponent: TLMDHideNonVC;
    FDummy:Boolean;
    FSelectList: IDesignerSelections;
    fOwnSelection: Boolean;
    FName:String;
    procedure SetComponent(aValue: TLMDHideNonVC);
    procedure HandleNewComponent(Sender:TObject; aComponent:TComponent);
    function GetSelected:TPersistent;
    function  BuildAddString(aValue:TComponent):String;
    function  GetAddStringName(const aValue:String):String;
    procedure CheckButtonStates;
    procedure CheckInfo;
  protected
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure HideSelection;
    procedure ShowSelection;
    procedure DeleteSelection;
    property SelectList: IDesignerSelections read FSelectList;
    procedure SelectAdd(Comp: TComponent);
    procedure SelectAll;
    procedure SelectNone;
    procedure SelectOne(Comp: TComponent);
    procedure DoSelectAll;
    function UniqueName(Component: TComponent): string; override;
    public
    destructor Destroy; override;
    procedure Activated; override;
    function EditAction(Action: TEditAction): Boolean; override;
    procedure ItemInserted(const ADesigner: IDesigner; Item: TPersistent); override;
    // Replaces ComponentDeleted procedure
    procedure ItemDeleted(const ADesigner: IDesigner; Item: TPersistent); override;
    // Replaces FormModified procedure
    procedure ItemsModified(const Designer: IDesigner);override;
    procedure DesignerOpened(const Designer: IDesigner;AResurrecting: Boolean); override;
    // Replaces FormClosed procedure
    procedure DesignerClosed(const Designer: IDesigner; AGoingDormant: Boolean); override;
    procedure SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections); override;
    procedure Initialize;
    function GetEditState: TEditState; override;
    procedure UpdateSelection;
    {properties}
    property DComponent:TLMDHideNonVC read FComponent write SetComponent;
    property OwnSelection: Boolean read fOwnSelection write fOwnSelection;
  end;

var
  LMDHideNonVCfrm: TLMDHideNonVCfrm;

implementation
uses
  LMDProcs;

{$R *.DFM}
{************************* TLMDHideNonVCForm **********************************}
{-------------------------- private -------------------------------------------}
procedure TLMDHideNonVCfrm.btHideClick(Sender: TObject);
begin
  if Sender=btHideAll then DoSelectAll;
  HideSelection;
  CheckInfo;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.btshowClick(Sender: TObject);
begin
  if Sender=btShowAll then DoSelectAll;
  ShowSelection;
  CheckInfo;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.btDeleteClick(Sender: TObject);
begin
  DeleteSelection;
  UpdateSelection;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.HandleClick(Sender: TObject);
begin
  GetComponentEditor(TComponent(cbList.Items.Objects[cbList.ItemIndex]),
                     IDesigner(Designer)).
                     ExecuteVerb(Integer(TMenuItem(Sender).Tag));
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.popMenuPopup(Sender: TObject);
var
  i,vc:Integer;
  it:TMenuItem;
  c:TComponent;
  cp:IComponentEditor;

begin

  {delete old list of items}
  with popMenu do
    while Items.Count>0 do
      begin
        it:=Items[Pred(Items.Count)];
        Items.Delete(Pred(Items.Count));
        it.Free;
      end;

  if (cbList.Items.Count>0) and (cbList.ItemIndex<>-1) then
    begin
      c:=TComponent(cbList.Items.Objects[cbList.ItemIndex]);
      cp:=GetComponentEditor(c, IDesigner(Designer));
      vc:=cp.GetVerbCount;
      for i:=0 to Pred(vc) do
        begin
          it:=TMenuItem.Create(popMenu);
          it.Tag:=i;
          it.Caption:=cp.GetVerb(i);
          it.OnClick:=HandleClick;
          popMenu.Items.Add(it);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.cbListMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbRight then exit;
  UpdateSelection;
  CheckInfo;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.FormCreate(Sender: TObject);
begin
  Initialize;
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatForm);{$ENDIF}
end;

{------------------------------------------------------------------------------}
function TLMDHideNonVCfrm.BuildAddString(aValue:TComponent):String;
begin
  result:=aValue.Name + ' ['+aValue.ClassName+']'
end;

{------------------------------------------------------------------------------}
function TLMDHideNonVCfrm.GetAddStringName(const aValue:String):String;
begin
  result:=LMDAnsiTrim(copy(aValue, 1, pos('[', aValue)-1));
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.CheckInfo;
var
  tmp:LongInt;
begin
  if FComponent=nil then exit;
  with cbList do
    if (ItemIndex<>-1) and (items.Count>0) then
      begin
        tmp:=TComponent(Items.Objects[ItemIndex]).DesignInfo;
        if (tmp=defHideX)  then
          begin
            d.Font.Color:=clMaroon;
            d.Caption:='[Hidden]'
          end
        else
          begin
            d.Font.Color:=clNavy;
            d.Caption:='[Visible]';
          end
      end
    else
      begin
        d.Font.Color:=clBlack;
        d.Caption:='---';
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.CheckButtonStates;
begin
  btHide.Enabled:=cbList.SelCount>0;
  btShow.Enabled:=btHide.Enabled;
  btDelete.Enabled:=btHide.Enabled;
  btHideAll.Enabled:=cbList.Items.Count>0;
  btShowAll.Enabled:=btHideAll.Enabled;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.HandleNewComponent(Sender:TObject; aComponent:TComponent);
begin
  FDummy:=True;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.SetComponent(aValue:TLMDHideNonVC);
begin
  if FComponent<>aValue then
    begin
      If FComponent<>nil then FComponent.OnNewComponent:=nil;
      FComponent:=aValue;
      If FComponent<>nil then
        begin
          FComponent.OnNewComponent:=HandleNewComponent;
          with FComponent.Owner as TCustomForm do
            begin
              FName:=Name+'.'+DComponent.Name;
              Self.Caption:=FName;
              if Designer<>nil then Self.Designer := Designer as IDesigner;
            end;
        end;
      Initialize;
    end
end;

{------------------------------------------------------------------------------}
function TLMDHideNonVCfrm.GetSelected:TPersistent;
var
  i:Integer;
begin
  result:=nil;
  with cbList do
    for i:=0 to Pred(Items.Count) do
      if Selected[I] then
        begin
          Result:=TPersistent(Items.Objects[I]);
          exit;
        end;
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDHideNonVCfrm.BeginUpdate;
begin
  FSelectList:=CreateSelectionList;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.EndUpdate;
begin
  if  Assigned(FSelectList) then
    if FSelectList.Count>1 then
      Designer.SetSelections(FSelectList)
    else
      if FSelectList.Count=1 then
        Designer.SelectComponent(TComponent(FSelectList.Items[0]));//DComponent);
  OwnSelection:=True;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.SelectAll;
begin
  SendMessage(cblist.Handle, LB_SETSEL, 1, -1);
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.SelectNone;
begin
  SendMessage(cblist.Handle, LB_SETSEL, 0, -1);
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.SelectAdd(Comp: TComponent);
begin
  SelectList.Add(Comp);
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.SelectOne(Comp: TComponent);
begin
  BeginUpdate;
  SelectAdd(Comp);
  EndUpdate;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.ShowSelection;
var
  i:Integer;
  t:TComponent;
begin
  for i:=0 to Pred(cbList.Items.Count) do
    if cbList.Selected[i] then
      begin
        t:=TComponent(cbList.Items.Objects[i]){SelectList[i]};
        if (t.DesignInfo=defHideX)  then
          begin
            if (FComponent.UseTagInfo) and (LongInt(t.Tag)<>0) then
              begin
                t.DesignInfo:=LongInt(t.Tag);
                t.Tag:=0;
              end
            else
              t.DesignInfo:=0;
            LMDShowContainer(TCustomForm(Designer.Root), t);
          end;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.HideSelection;
var
  i:Integer;
  t:TComponent;
begin
  for i:=0 to Pred(cbList.Items.Count) do
    if cbList.Selected[i] then
      begin
        t:=TComponent(cbList.Items.Objects[i]){SelectList[i]};
        if (t.DesignInfo<>defHideX)  then
          begin
            if FComponent.UseTagInfo then t.Tag:=t.DesignInfo;
            t.DesignInfo:=LongInt(defHideX);
            LMDRemoveContainer(TCustomForm(Designer.Root), t);
          end;
     end;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.cbListKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  UpdateSelection;
  CheckInfo;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.DeleteSelection;
var
  i:Integer;
  t:TComponent;
begin
  for i:=Pred(cbList.Items.Count) downto 0 do
    begin
    if cbList.Selected[i] then
      begin
        t:=TComponent(cbList.Items.Objects[i]);
        TCustomForm(FComponent.Owner).RemoveComponent(t);
        Designer.Modified;
        t.Free;
      end;
    end
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.UpdateSelection;
var
  i:Integer;
begin
  with cbList do
    case selcount of
      //0:SelectOne(DComponent);
      1:SelectOne(TComponent(GetSelected));
    else
      begin
        BeginUpdate;
        For i:=0 to Pred(Items.Count) do
          if Selected[i] then SelectAdd(TComponent(Items.Objects[i]));
        EndUpdate;
      end;
  end;
  CheckButtonStates;
  CheckInfo;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.DoSelectAll;
begin
  SelectAll;
  UpdateSelection;
end;

{------------------------------------------------------------------------------}
function TLMDHideNonVCfrm.UniqueName(Component: TComponent): string;
begin

end;

{------------------------- Public ---------------------------------------------}
procedure TLMDHideNonVCfrm.Activated;
begin
  if not OwnSelection then UpdateSelection;
  inherited Activated;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.Initialize;
var
  i:Integer;
begin
  cbList.Clear;
  if FComponent=nil then exit;
  BeginUpdate;
  with TCustomForm(FComponent.Owner) do
    for i:=0 to Pred(ComponentCount) do
      if LMDCheckValidComponent(Components[i], FComponent) then
        cbList.Items.AddObject(BuildAddString(Components[i]), Components[i]);
end;

{------------------------------------------------------------------------------}
function TLMDHideNonVCfrm.GetEditState: TEditState;
begin
  Result := [];
  if cbList.SelCount>0 then Include(result, esCanDelete);
end;

{------------------------------------------------------------------------------}
function TLMDHideNonVCfrm.EditAction(Action: TEditAction):Boolean;
begin
  result:=true;
  case Action of
    eaSelectAll: DoSelectAll;
    eaDelete:    DeleteSelection;
  else
    result:=false;
  end;
end;

{------------------------------------------------------------------------------}
procedure  TLMDHideNonVCfrm.ItemInserted(const ADesigner: IDesigner; Item: TPersistent);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.ItemDeleted(const ADesigner: IDesigner; Item: TPersistent);
var
  i:Integer;
begin
  if FDummy or (FComponent=nil) then exit;
  if Item is TLMDHideNonVC then
    begin
      FComponent:=nil;
      Release;
    end
  else
    with cbList do
      begin
        i:=Items.IndexOfObject(Item);
        if i<>-1 then Items.Delete(i);
        UpdateSelection;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.ItemsModified(const Designer: IDesigner);
var
  i:Integer;
  t:TComponent;
begin
  if Designer.Root<>FComponent.Owner then exit;

  with FComponent.Owner as TCustomForm do
    if FName<>Name+'.'+FComponent.Name then
      begin
        FName:=Name+'.'+FComponent.Name;
        Self.Caption:=FName;
        exit;
      end;

  with cbList do
    begin
      if FDummy then
        begin
          if FComponent<>nil then
            with FComponent.Owner as TCustomForm do
              begin
                t:=Components[Pred(ComponentCount)];
                if LMDCheckValidComponent(t, FComponent) and (Items.IndexOfObject(t)=-1) then
                  Items.AddObject(BuildAddString(t), t);
                CheckInfo;
              end;
        end
      else
        begin
          For i:=0 to Pred(Items.Count) do
            if TComponent(Items.Objects[i]).Name<>GetAddStringName(Items[i]) then
              begin
                t:=TComponent(Items.Objects[i]);
                Items.Delete(i);
                Items.AddObject(BuildAddString(t), t);
              end;
        end;
    end;
  FDummy:=False;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.DesignerOpened(const Designer: IDesigner;AResurrecting: Boolean);
begin

end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.DesignerClosed(const Designer: IDesigner;AGoingDormant: Boolean);
begin
  if (FComponent<>nil) and (Designer.Root=FComponent.Owner) then Free;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVCfrm.SelectionChanged(const ADesigner: IDesigner;
                                            const ASelection: IDesignerSelections);
var
  i,j:Integer;
begin
  if FSelectList<>ASelection then OwnSelection:=False;
  if not OwnSelection then FSelectList:=nil;
  if not OwnSelection and (ASelection<>nil) then
    begin
      SelectNone;
      for i:=0 to Pred(ASelection.Count) do
        if LMDCheckValidComponent(TComponent(ASelection[i]), FComponent) then
          begin
            j:=cbList.Items.IndexofObject(ASelection[i]);
            if j<>-1 then cbList.Selected[j]:=True;
          end;
    end;
  CheckButtonStates;
end;

{------------------------------- public ---------------------------------------}
destructor TLMDHideNonVCfrm.Destroy;
begin
  if Self=LMDHideNonVCfrm then LMDHideNonVCfrm:=nil;
  inherited Destroy;
end;

end.
