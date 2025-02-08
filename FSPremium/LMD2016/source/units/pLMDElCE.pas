unit pLMDElCE;
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

LMD ElPack specific component editors (Core)
--------------------------------------------

ToDo
----
* Make HotkeyEditor work for TElHotkeyEdit as well

Changes
-------
Release 6.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, TypInfo, Dialogs,
  DesignEditors, DesignWindows, DesignMenus, DsnConst, DesignIntf, RTLConsts,
  LMDUtils,
  LMDElConst,
  ElPgCtl;

type

  {*********************** TElDlgEditor ***************************************}
  TElDlgEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {*********************** TElExplorerBarEditor *******************************}
  TElExplorerBarEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index : Integer); override;
    function GetVerb(Index : Integer) : string; override;
    function GetVerbCount : Integer; override;
  end;

  {*********************** TFormCtlProperty ***********************************}
  TFormCtlProperty = class(TComponentProperty)
  public
    procedure GetValues(Proc : TGetStrProc); override;
    procedure SetValue(const Value : string); override;
  end;

  {----------------------  Class TElHotKeyEditor ------------------------------}
  TElHotKeyEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------  Class TElHTMLContainerEditor -----------------------}
  TElHTMLContainerEditor = class(TDefaultEditor)
  protected
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;
    public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;
  {*********************** TElHeaderEditor ************************************}
  TElHeaderEditor = class(TDefaultEditor)
  public
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;
    procedure ExecuteVerb(Index: integer); override;
    function GetVerb(Index: integer): string; override;
    function GetVerbCount: integer; override;
  end;

  {*********************** TElMRUCollectionEditor *****************************}
  TElMRUCollectionEditor = class(TDefaultEditor)
  public
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;
    procedure ExecuteVerb(Index: integer); override;
    function GetVerb(Index: integer): string; override;
    function GetVerbCount: integer; override;
  end;

  {*********************** TElPageControlEditor *******************************}
  TElPageControlEditor = class(TComponentEditor)
  private
    function GetPageControl : TElPageControl;
  public
    procedure ExecuteVerb(Index : Integer); override;
    function GetVerb(Index : Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
  end;

  {*********************** TElSideBarEditor ***********************************}
  TElSideBarEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: integer); override;
    function GetVerb(Index: integer): string; override;
    function GetVerbCount: integer; override;
  end;

  {*********************** TElStatusBarEditor *********************************}
  TElStatusBarEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: integer); override;
    function GetVerb(Index: integer): string; override;
    function GetVerbCount: integer; override;
  end;

  {*********************** TStrPoolItemsEditor ********************************}
  TStrPoolItemsEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index : Integer); override;
    function GetVerb(Index : Integer) : string; override;
    function GetVerbCount : Integer; override;
  end;

  {*********************** TElTimerPoolEditor *********************************}
  TElTimerPoolEditor = class(TDefaultEditor)
  public
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;
    procedure ExecuteVerb(Index: integer); override;
    function GetVerb(Index: integer): string; override;
    function GetVerbCount: integer; override;
  end;

  {*********************** TElToolBarEditor ***********************************}
  TElToolBarEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index : Integer); override;
    function GetVerb(Index : Integer) : string; override;
    function GetVerbCount : Integer; override;
  end;

  {*********************** TElTreeEditor **************************************}
  TElTreeEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index : Integer); override;
    function GetVerb(Index : Integer) : string; override;
    function GetVerbCount : Integer; override;
  end;

  {*********************** TElXTreeEditor **************************************}
  TElXTreeEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index : Integer); override;
    function GetVerb(Index : Integer) : string; override;
    function GetVerbCount : Integer; override;
  end;

implementation
uses
  Forms, ColnEdit,
  Consts, LMDUnicodeStrings, pLMDCPGetBase,
  ElToolBar, ElHeader, ElTree, ElSideBar, ElStatBar, ElExpBar, ElStrPool, ElVCLUtils,
  ElComponent, ElSysHotKey,
  pLMDElHTMLEditorDlg, pLMDElSectProp, pLMDElStrPoolEdit,
  pLMDElXSectProp, ElXHeader, ElXTree, pLMDElXItemsProp, pLMDElItemsProp;

type
  THackDlg=class(TCommonDialog);

{********************* Class TElDlgEditor *************************************}
{------------------------------------------------------------------------------}
procedure TElDlgEditor.ExecuteVerb(Index: Integer);
begin
  case index of
    0 : if Component is TElBaseDlgComponent then
          TElBaseDlgComponent(Component).Execute
          else
          if Component is TCommonDialog then
            THackDlg(Component).Execute;
            end;
end;

{------------------------------------------------------------------------------}
function TElDlgEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: Result:='Test Dialog...';
  end;
end;

{------------------------------------------------------------------------------}
function TElDlgEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ ******************** class TElExplorerBarEditor **************************** }
procedure TElExplorerBarEditor.ExecuteVerb(Index : Integer);
var
  Bar : TElExplorerBar;
begin
  if Index = 0 then
  begin
    Bar := TElExplorerBar(Component);
    TElExplorerBarGroup(Designer.CreateComponent(TElExplorerBarGroup, Bar, 0, 10000, Bar.Width, 100)).Parent := Bar;
  end;
end;

{ -----------------------------------------------------------------------------}
function TElExplorerBarEditor.GetVerb(Index : Integer): string;
begin
  if Index = 0 then
    Result := 'Add group';
end;

{ -----------------------------------------------------------------------------}
function TElExplorerBarEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ ******************** class TFormCtlProperty ********************************* }
procedure TFormCtlProperty.GetValues(Proc : TGetStrProc);
begin
  inherited;
  if (TCustomForm(Designer.Root) is GetTypeData(GetPropType)^.ClassType) and
    (TCustomForm(Designer.Root).Name <> '') then
      Proc(TCustomForm(Designer.Root).Name);
end;

{ -----------------------------------------------------------------------------}
procedure TFormCtlProperty.SetValue(const Value : string);
var
  Comp : TComponent;
begin
  Comp := Designer.GetComponent(Value);
  if ((Comp = nil) or not (Comp is GetTypeData(GetPropType)^.ClassType))
    and (CompareText(TCustomForm(Designer.Root).Name, Value) = 0) then
    begin
    if not (TCustomForm(Designer.Root) is GetTypeData(GetPropType)^.ClassType) then
    begin
      MessageDlg(Format('Invalid property value: %s expected, %s found',
                        [TCustomForm(Designer.Root).ClassName, GetTypeData(GetPropType)^.ClassType.ClassName]),
                 mtError, [mbOk], 0);
      raise
        EPropertyError.Create(SInvalidPropertyValue);
    end;
    SetOrdValue(Longint(Designer.Root));
    end
  else
    inherited;
end;

{------------------------------------------------------------------------------}
procedure TElHotKeyEditor.ExecuteVerb(Index: Integer);
var
  tmp: TShortCut;
begin
  case Index of
    0: begin
         tmp := (Component as TElSysHotKey).Shortcut;
         if LMDCPGetShortCut(tmp) then
           begin
            (Component as TElSysHotKey).Shortcut := tmp;
            Designer.Modified;
           end;
       end;
  end;
end;

{------------------------------------------------------------------------------}
function TElHotKeyEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'HotKey Editor';
  end;
end;

{------------------------------------------------------------------------------}
function TElHotKeyEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ ******************** class TElHeaderEditor ********************************* }

procedure TElHeaderEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);

var
  PropName : string;
begin

  PropName := Prop.GetName;

  if (CompareText(PropName, 'SECTIONS') = 0) then
  begin

    Prop.Edit;

    Continue := False;
  end;
end;

{ -----------------------------------------------------------------------------}
procedure TElHeaderEditor.ExecuteVerb(Index: integer);
begin
  Edit;
end;

{ -----------------------------------------------------------------------------}
function TElHeaderEditor.GetVerb(Index: integer): string;
begin
  Result := 'Se&ctions Editor...';
end;

{ -----------------------------------------------------------------------------}
function TElHeaderEditor.GetVerbCount: integer;
begin
  Result := 1;
end;

{ TLMDRTFStorageEditor }
{------------------------------------------------------------------------------}

procedure TElHTMLContainerEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);

var
  PropName: string;
begin
  PropName:= Prop.GetName;
  if CompareText(PropName, 'Items') = 0 then
    begin
      Prop.Edit;
      Continue:= False;
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TElHTMLContainerEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: Edit;
  end;
end;

{------------------------------------------------------------------------------}
function TElHTMLContainerEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result:= 'HTML Snippet Editor...';
  else
    Result:= '';
  end;
end;

{------------------------------------------------------------------------------}
function TElHTMLContainerEditor.GetVerbCount: Integer;
begin
  Result:= 1
end;

{ ******************** class TElMRUCollectionEditor ************************** }

procedure TElMRUCollectionEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);

var
  PropName : string;
begin

  PropName := Prop.GetName;
  if (CompareText(PropName, 'SECTIONS') = 0) then
  begin
    Prop.Edit;
    Continue := False;
  end;

end;

{ -----------------------------------------------------------------------------}
procedure TElMRUCollectionEditor.ExecuteVerb(Index: integer);
begin
  Edit;
end;

{ -----------------------------------------------------------------------------}
function TElMRUCollectionEditor.GetVerb(Index: integer): string;
begin
  Result := 'Se&ctions...';
end;

{ -----------------------------------------------------------------------------}
function TElMRUCollectionEditor.GetVerbCount: integer;
begin
  Result := 1;
end;

{ ******************** class TElPageControlEditor **************************** }
procedure TElPageControlEditor.ExecuteVerb(Index : Integer);
var
  PageControl : TElPageControl;

    procedure AddPage;
    var Page : TElTabSheet;
    begin
      Page := TElTabSheet.Create(Designer.GetRoot);
      try
        Page.Name := Designer.UniqueName(TElTabSheet.ClassName);
        Page.Caption := Page.Name;
        Page.PageControl := PageControl;
      except
        Page.Free;
        raise;
      end;
      PageControl.ActivePage := Page;
      Designer.SelectComponent(Page);
      Designer.Modified;
    end;

    procedure GoToPage(Next : boolean);
    var ASheet : TElTabSheet;
    begin
      ASheet := PageControl.FindNextPage(PageControl.ActivePage, Next, false, false);
      if (ASheet <> nil) and (ASheet <> PageControl.ActivePage) then
      begin
        PageControl.ActivePage := ASheet;
        if Component is TElTabSheet then
          Designer.SelectComponent(ASheet);
        Designer.Modified;
      end;
    end;

begin
  PageControl := GetPageControl;
  case Index of
    0: AddPage;
    1: GoToPage(true);
    2: GoToPage(false);
    3: if PageControl.ActivePage <> nil then
         PageControl.ActivePage.Free;
    else
      inherited;
  end;
end;

{ -----------------------------------------------------------------------------}
function TElPageControlEditor.GetVerb(Index : Integer): string;
begin
  case Index of
    0: result := 'New Page';
    1: result := 'Next Page';
    2: result := 'Previous Page';
    3: result := 'Delete Page';
    else result := '';
  end;
end;

{ -----------------------------------------------------------------------------}
function TElPageControlEditor.GetVerbCount: Integer;
begin
  Result := 4;
end;

{ -----------------------------------------------------------------------------}
function TElPageControlEditor.GetPageControl : TElPageControl;
begin
  if (Component is TElPageControl) then
    result := TElPageControl(Component)
  else
  if (Component is TElTabSheet) then
    result := TElTabSheet(Component).PageControl
  else
    raise Exception.Create('ElPageControl property editor used for unknown component');
end;

{ -----------------------------------------------------------------------------}
procedure TElPageControlEditor.PrepareItem(Index: Integer; const AItem: IMenuItem);
var
  pg: TElPageControl;
begin
  if (Index = 3) and Assigned(aItem) then
  begin
    pg := GetPageControl;
    AItem.Enabled := Assigned(pg) and (pg.ActivePage <> nil);
  end
  else
    inherited;
end;

{ ******************** class TElSideBarEditor ******************************** }
procedure TElSideBarEditor.ExecuteVerb(Index: integer);
begin
  if Index = 0 then
  begin
    ShowCollectionEditor(Self.Designer, Component, (Component as TElSideBar).Sections, 'Sections');
  end;
end;

{ -----------------------------------------------------------------------------}
function TElSideBarEditor.GetVerb(Index: integer): string;
begin
  if Index = 0 then
     result := 'Sidebar Sections ...'
end;

{ -----------------------------------------------------------------------------}
function TElSideBarEditor.GetVerbCount: integer;
begin
  result := 1;
end;

{ ******************** class TElStatusBarEditor ****************************** }
procedure TElStatusBarEditor.ExecuteVerb(Index: integer);
begin
  if Index = 0 then
    begin
      ShowCollectionEditor(Self.Designer, Component, (Component as TElStatusBar).Panels, 'Panels');
    end;
end;

{ -----------------------------------------------------------------------------}
function TElStatusBarEditor.GetVerb(Index: integer): string;
begin
  if Index = 0 then result := 'Status Panels ...';
end;

{ -----------------------------------------------------------------------------}
function TElStatusBarEditor.GetVerbCount: integer;
begin
  result := 1;
end;

{ ******************** class TStrPoolItemsEditor ***************************** }
procedure TStrPoolItemsEditor.ExecuteVerb(Index : Integer);
begin
  if Index = 0 then
  begin
    with TStrPoolEditForm.Create(Application) do
    begin
      try
        { Set dialog's caption. }
        if Component is TElStringPool then
          SetData(TElStringPool(Component).Items);
        if (ShowModal = mrOk) then
        begin
          GetData((Component as TElStringPool).Items);
          if Assigned(self.Designer) then Self.Designer.Modified;
        end;
      finally
        Free;  { Free dialog. }
      end;  { try/finally }
    end;  { with }
  end;
end;

{ -----------------------------------------------------------------------------}
function TStrPoolItemsEditor.GetVerb(Index : Integer) : string;
begin
  if Index = 0 then Result := 'Items Editor';
end;

{ -----------------------------------------------------------------------------}
function TStrPoolItemsEditor.GetVerbCount : Integer;
begin
  Result := 1;
end;

{ ******************** class TElTimerPoolEditor ****************************** }

procedure TElTimerPoolEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);

var
  PropName : string;
begin

  PropName := Prop.GetName;
  if (CompareText(PropName, 'ITEMS') = 0) then
  begin
    Prop.Edit;
    Continue := False;
  end;

end;

{ -----------------------------------------------------------------------------}
procedure TElTimerPoolEditor.ExecuteVerb(Index: integer);
begin
  Edit;
end;

{ -----------------------------------------------------------------------------}
function TElTimerPoolEditor.GetVerb(Index: integer): string;
begin
  Result := 'Ti&mers...';
end;

{ -----------------------------------------------------------------------------}
function TElTimerPoolEditor.GetVerbCount: integer;
begin
  Result := 1;
end;

{ ******************** class TElToolBarEditor ******************************** }
procedure TElToolBarEditor.ExecuteVerb(Index : Integer);
var
  TBar : TElToolBar;
  TButton : TElToolButton;
begin
  case Index of
    0, 1 :
      begin
        TBar := TElToolBar(Component);
        TButton := TElToolButton(Designer.CreateComponent(TElToolButton, TBar, 10000, 10000, TBar.BtnWidth, TBar.BtnHeight));
        if Assigned(TButton) then
        begin
          if Index = 0 then
            TButton.ButtonType := ebtButton
          else
            TButton.ButtonType := ebtSeparator;
        end;
      end;
  end;
end;

{ -----------------------------------------------------------------------------}
function TElToolBarEditor.GetVerb(Index : Integer) : string;
begin
  case Index of
    0 : Result := 'New B&utton';
    1 : Result := 'New Se&parator';
  end;
end;

{ -----------------------------------------------------------------------------}
function TElToolBarEditor.GetVerbCount : Integer;
begin
  Result := 2;
end;

{ ******************** class TElTreeEditor *********************************** }
procedure TElTreeEditor.ExecuteVerb(Index : Integer);
begin
  if Index = 0 then
  begin
    with TItemsPropDlg.Create(Application) do
    begin
      try
        { Set dialog's caption. }
        Caption := Component.Owner.Name + '.' + Component.Name + ' - ' + Caption;
        AComp := Component;
        DTreeItems := TCustomElTree(AComp).Items;
        Tree.Items := DTreeItems;
        Tree.Font.Assign(TElTree(AComp).Font);
        if (ShowModal = mrOk) then
          if Assigned(self.Designer) then Self.Designer.Modified;
      finally
        Free;  { Free dialog. }
      end;  { try/finally }
    end;  { with }
  end else
  if Index = 1 then
  begin
    with TElSectionsPropDlg.Create(Application) do
    begin
      ASect := TElTree(Component).HeaderSections;
      SetData;
      Caption := Format('Editing %s.Sections', [Component.Name]);
      if ShowModal = mrOk then
        begin
          GetData;
          if Assigned(self.Designer) then Self.Designer.Modified;
        end;
    end;
  end;
end;

{ -----------------------------------------------------------------------------}
function TElTreeEditor.GetVerb(Index : Integer) : string;
begin
  if Index = 0 then
    Result := 'Items ...'
  else
    if Index = 1 then
      Result := 'Header Sections ...';
end;

{ -----------------------------------------------------------------------------}
function TElTreeEditor.GetVerbCount : Integer;
begin
  Result := 2;
end;

{ ******************** class TElXTreeEditor *********************************** }
procedure TElXTreeEditor.ExecuteVerb(Index : Integer);
begin
  if Index = 0 then
  begin
    with TXItemsPropDlg.Create(Application) do
    begin
      try
        { Set dialog's caption. }
        Caption := Component.Owner.Name + '.' + Component.Name + ' - ' + Caption;
        AComp := Component;
        XTree.HeaderSections.Assign(TCustomElXTree(AComp).HeaderSections);
        DXTreeItems := TCustomElXTree(AComp).Items;
        XTree.Font.Assign(TElXTree(AComp).Font);
        XTree.Items := DXTreeItems;
        if (ShowModal = mrOk) then
          if Assigned(self.Designer) then Self.Designer.Modified;
      finally
        Free;  { Free dialog. }
      end;  { try/finally }
    end;  { with }
  end else
  if Index = 1 then
  begin
    with TElXSectionsPropDlg.Create(Application) do
    begin
      ASect := TElXTree(Component).HeaderSections;
      SetData;
      Caption := Format('Editing %s.Sections', [Component.Name]);
      if ShowModal = mrOk then
        begin
          GetData;
          if Assigned(self.Designer) then Self.Designer.Modified;
        end;
    end;
  end;
end;

{ -----------------------------------------------------------------------------}
function TElXTreeEditor.GetVerb(Index : Integer) : string;
begin
  if Index = 0 then
    Result := 'Items ...'
  else
    if Index = 1 then
      Result := 'Header Sections ...';
end;

{ -----------------------------------------------------------------------------}
function TElXTreeEditor.GetVerbCount : Integer;
begin
  Result := 2;
end;

end.
