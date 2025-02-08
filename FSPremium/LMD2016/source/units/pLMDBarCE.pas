unit pLMDBarCE;
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

pLMDBarCE unit (DD, RM, AH)
---------------------------
Implements component editors for BarPack controls.


Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  DesignIntf, DesignEditors, VCLEditors, ColnEdit,
  Classes, SysUtils, Dialogs, Controls, Comctrls, Menus,
  LMDBarBase, LMDExplorerBar, LMDSectionBar, LMDSectionBarPopupMenu, pLMDCommon,
  pLMDGlobalEditors;

type

  {----------------------------------------------------------------------------}
  TLMDBarHTMLLabelComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer);override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  // ExplorerBar editors
  {------------------------------------------------------------------------------}
  TLMDBarExplorerBarCollectionEditor = class(TLMDCollectionItemsEditor)
  protected
    function GetWorkCollection(index:Integer):TCollection;override;
  end;

  {----------------------------------------------------------------------------}
  TLMDBarExplorerBarCollectionProperty = class(TCollectionProperty)
  public
    function GetEditorClass:TCollectionEditorClass; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDBarExplorerBarEditor = class(TDefaultEditor)
  protected // 6.0
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;
  public
    procedure ExecuteVerb(Index: Integer);  override;
    function GetVerb(Index: Integer): String;  override;
    function GetVerbCount: Integer;  override;
  end;

  {----------------------------------------------------------------------------}
  TLMDBarSectionBarControllerEditor = class(TDefaultEditor)
  protected // 6.0
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;
  public
    procedure ExecuteVerb(Index: Integer);  override;
    function GetVerb(Index: Integer): String;  override;
    function GetVerbCount: Integer;  override;
  end;

  // Bar control
  {----------------------------------------------------------------------------}
  TLMDBarSectionBarCollectionProperty = class(TCollectionProperty)
  public
    function GetEditorClass:TCollectionEditorClass; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDBarSectionBarCollectionEditor = class(TLMDCollectionItemsEditor)
  protected
    function GetWorkCollection(index:Integer):TCollection;override;
  end;

  {----------------------------------------------------------------------------}
  TLMDBarSectionBarEditor = class(TDefaultEditor)
  protected // 6.0
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;
  public
    procedure ExecuteVerb(Index: Integer);  override;
    function GetVerb(Index: Integer): String;  override;
    function GetVerbCount: Integer;  override;
  end;

implementation
uses
  Graphics, 
  pLMDCst, LMDBarHTMLLabel, pLMDSectionBarEditorDlg, pLMDHTMLEditDlg;

{------------------------------------------------------------------------------}
procedure LMDAssignXPValues(it:TLMDSectionBarTheme);
begin
  with it do
    begin
      ButtonBackground:=LSB_BUTTON_BACK;
      ButtonHighLightTextColor:=$00C65252;
      ButtonTextColor:=clBlack;
      ButtonSpaceColor:=clSilver;
      DisableTextColor:=LSB_DISABLETEXT;
      HighlightTextColor:=LSB_HIGHLIGHTEXT;
      ItemBorderBlack:=$00C66931;
      ItemBorderLight:=$00C66931;
      ItemDownBackground:=$00F7DFD6;
      ItemDragBackGround:=$00FEAEAC;
      ItemDragBorder:=$00C66931;
      ItemSelectedBackground:=$00EFD3C6;
      ViewBackground:=LSB_LISTVIEW_BACK;
      TextColor:=LSB_TEXTCOLOR;
      CustomScrollBmp:=nil;
      CaptionSpace:=defLMD_CAPTIONGAP;
      DragSpace:=defLMD_DRAGSPACE;
      ImageSpace:=defLMD_IMAGEGAP;
      ItemsSpace:=defLMD_ITEMSGAP;
      ScrollStep:=defLMD_SCROLLSIZE;
      ButtonSpace:=1;
      ButtonMinHeight:=0;
      SelectionStyle:=lssFull;
    end;
end;

{********************* Class TLMDBarHTMLLabelComponentEditor ******************}
{------------------------------------------------------------------------------}
procedure TLMDBarHTMLLabelComponentEditor.ExecuteVerb(Index: Integer);
begin
  case index of
    0: with TfrmLMDMiniHTMLEditor.Create(nil) do
         try
           SetViewControlClass(TLMDBarHTMLLabel);
           HTMLEdit.Text:=TLMDBarHTMLLabel(Component).Caption;
           if ShowModal=mrok then
             TLMDBarHTMLLabel(Component).Caption:=HTMLEdit.Text;
         finally
           free;
         end;
   end;

end;

{------------------------------------------------------------------------------}
function TLMDBarHTMLLabelComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:result:='Caption-Editor';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDBarHTMLLabelComponentEditor.GetVerbCount: Integer;
begin
  Result:=1;
end;

{***************** Class TLMDBarExplorerBarCollectionEditor *******************}
{------------------------------------------------------------------------------}
function TLMDBarExplorerBarCollectionEditor.GetWorkCollection(Index:Integer):TCollection;
begin
  result:=TLMDExplorerBarSection(Collection.Items[ListView1.Selected.Index]).Items;
end;

{***************** Class TLMDBarExplorerBarCollectionProperty *****************}
{------------------------------------------------------------------------------}
function TLMDBarExplorerBarCollectionProperty.GetEditorClass: TCollectionEditorClass;
begin
  result:=TLMDBarExplorerBarCollectionEditor;
end;

{ ******************* Class TLMDBarExplorerBarEditor ************************* }
{------------------------------------------------------------------------------}
procedure TLMDBarExplorerBarEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);
var
  tmp:string;
begin
  tmp:=Prop.GetName;
  if (CompareText(tmp,'Sections')=0) then
  begin
    Prop.Edit;
    Continue := False;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBarExplorerBarEditor.ExecuteVerb(Index: Integer);
begin
  case index of
    0:Edit;
    2:TLMDExplorerBar(Component).ExpandAll;
    3:TLMDExplorerBar(Component).CollapseAll;
  end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDBarExplorerBarEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: result:='Section Editor';
    1: result:='-';
    2: result:='Expand All';
    3: result:='Collapse All';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDBarExplorerBarEditor.GetVerbCount: Integer;
begin
 if Component is TLMDExplorerBarStorage then
   Result:=1
 else
   Result:=4;
end;

{ ******************* Class TLMDBarSectionBarControllerEditor***************** }
{------------------------------------------------------------------------------}
procedure TLMDBarSectionBarControllerEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);
var
  tmp:string;
begin
  tmp:=Prop.GetName;
  if (CompareText(tmp,'Themes')=0) then
    begin
      Prop.Edit;
      Continue := False;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBarSectionBarControllerEditor.ExecuteVerb(Index: Integer);
begin
  case index of
    0:Edit;
    1:begin
        with TLMDSectionBarController(Component) do
         LMDAssignXPValues(Themes.Add.Theme);
        Edit;
      end;
    end;
    Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDBarSectionBarControllerEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: result:='Section Editor';
    1: result:='Add XP Theme item';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDBarSectionBarControllerEditor.GetVerbCount: Integer;
begin
   Result:=2
end;

{***************** Class TLMDBarSectionBarCollectionEditor ********************}
{------------------------------------------------------------------------------}
function TLMDBarSectionBarCollectionEditor.GetWorkCollection(index:Integer):TCollection;
begin
  result:=TLMDSectionBarSection(Collection.Items[Index]).Items;
end;

{***************** Class TLMDSectionBarCollectionProperty *********************}
{------------------------------------------------------------------------------}
function TLMDBarSectionBarCollectionProperty.GetEditorClass: TCollectionEditorClass;
begin
  result:=TLMDBarSectionBarCollectionEditor;
end;

{ ******************* Class TLMDBarSectionBarEditor ************************** }
{------------------------------------------------------------------------------}
procedure TLMDBarSectionBarEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);
var
  tmp:string;
begin
  tmp:=Prop.GetName;
  if (CompareText(tmp,'Sections')=0) then
  begin
    Prop.Edit;
    Continue := False;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBarSectionBarEditor.ExecuteVerb(Index: Integer);
begin
  if (Component is TLMDCustomSectionBar) and TLMDSectionBar(Component).SingleSection
     and (Index=2) then Index:=7;

  case index of
    0: with TLMDfrmSectionBarEditorDlg.Create(nil) do
        try
          FDesigner:=self.Designer;
          if Component is TLMDSectionBar then
            bbar.Sections:=TLMDSectionBar(Component).Sections
          else
            bbar.Sections:=TLMDSectionBarStorage(Component).Sections;
          if showmodal=mrOK then
            begin
              if Component is TLMDSectionBar then
                TLMDSectionBar(Component).Sections:=bbar.Sections
              else
                TLMDSectionBarStorage(Component).Sections:=bbar.Sections
            end
          else
            exit;
        finally
          free;
        end;
     2:Edit;
     3: with TLMDSectionBar(Component).Sections.Add do
         Caption:='Section '+IntToStr (Sections.Count);
     4: TLMDSectionBar(Component).SectionNext;
     5: TLMDSectionBar(Component).SectionPrev;
     7: if Assigned(TLMDSectionBar(Component).ActiveSection) then
          with TLMDSectionBar(Component).ActiveSection.Items.Add do
            Caption:='Item '+IntToStr (TLMDSectionBar(Component).ActiveSection.Items.Count);
     9: with TLMDSectionBar(Component) do
         LMDAssignXPValues(Theme);
  end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDBarSectionBarEditor.GetVerb(Index: Integer): string;
begin
    case index of
      0: result:='Component-Editor';
      2: if (Component is TLMDCustomSectionBar) and (TLMDSectionBar(Component).SingleSection) then
          result:='Add item'
         else
          result:='Section Editor';
      3: result := 'Add Section';
      4: result := 'Next section';
      5: result := 'Prev section';
      1,6,8: result := '-';
      7: result := 'Add item';
      9: result := 'XP Style Theme';
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBarSectionBarEditor.GetVerbCount: Integer;
begin
  Result:=3;
  if Component is TLMDCustomSectionBar then
    if not TLMDSectionBar(Component).SingleSection then
      result:=10;
end;

end.

