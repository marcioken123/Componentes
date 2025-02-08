unit LMDSectionBarPopupMenu;
{$I lmdcmps.INC}

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

LMDSectionBarPopupMenu unit (RM)
--------------------------------
Special popup menu component designed to work with an instance of TLMDSectionBar.

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Menus, Classes,
  LMDBarBase, LMDControl, LMDTypes;

type
  TLMDSectionBarPopupMenuItems = set of (sbmAddSection, sbmDelSection, sbmRenSection,
                                         sbmMoveSection, sbmAddItem, sbmDelItem, sbmRenItem,
                                         sbmIconSize);

  {---------------------TLMDSectionBarPopupMenu---------------------------------}
  TLMDSectionBarPopupMenu = class (TLMDBasePopupMenu)
  private
    FCaptionEdit:Boolean;
    FVisibleItems : TLMDSectionBarPopupMenuItems;
    FDisableEffect:Boolean;
    FCurrentItem: TObject;
    procedure SetSmallIconSize (Sender : TObject);
    procedure SetLargeIconSize (Sender : TObject);
    procedure AddSection (Sender : TObject);
    procedure DelSection (Sender : TObject);
    procedure RenSection (Sender : TObject);
    procedure MoveSectionUp(Sender : TObject);
    procedure MoveSectionDown(Sender : TObject);
    procedure AddItem (Sender : TObject);
    procedure DelItem (Sender : TObject);
    procedure RenItem (Sender : TObject);
  protected
    procedure Loaded; override;
  public
//    constructor Create(AOwner: TComponent); override;
    procedure Popup(X, Y: Integer); override;
    constructor Create (aOwner : TComponent); override;
    function getLMDPackage:TLMDPackageID;override;
  published
    property About;
    property VisibleItems:TLMDSectionBarPopupMenuItems read FVisibleItems write FVisibleItems default [sbmAddSection, sbmDelSection, sbmRenSection, sbmMoveSection, sbmAddItem, sbmDelItem, sbmRenItem, sbmIconSize];
    property DisableEffect:Boolean read FDisableEffect write FDisableEffect default false;
    property CaptionEditor:Boolean read FCaptionEdit write FCaptionEdit default false;
  end;

implementation
uses
  LMDBarConsts, LMDSectionBar;

type
  TCrackItem=class(TMenuItem);  // to identify our own menus

{ *************** TLMDSectionBarPopupMenu ************************************* }
{ ------------------ private ------------------------------------------------- }
procedure TLMDSectionBarPopupMenu.SetSmallIconSize (Sender : TObject);
begin
  TLMDSectionBar(PopupComponent).ActiveSection.ViewStyle:=lvsSmallImages;
  TMenuItem(Sender).Checked := true;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSectionBarPopupMenu.SetLargeIconSize (Sender : TObject);
begin
  TLMDSectionBar(PopupComponent).ActiveSection.ViewStyle:=lvsLargeImages;
  TMenuItem(Sender).Checked := true;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSectionBarPopupMenu.AddSection (Sender : TObject);
begin
  TLMDSectionBar(PopupComponent).SectionAdd(true, FCaptionEdit, not FDisableEffect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSectionBarPopupMenu.DelSection (Sender : TObject);
begin
  TLMDSectionBar(PopupComponent).SectionDelete;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSectionBarPopupMenu.RenSection (Sender : TObject);
begin
  TLMDSectionBar(PopupComponent).SectionEdit;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSectionBarPopupMenu.MoveSectionUp(Sender : TObject);
begin
  with TLMDSectionBar(PopupComponent) do
    SectionMove(ActiveSectionIndex-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSectionBarPopupMenu.MoveSectionDown(Sender : TObject);
begin
  with TLMDSectionBar(PopupComponent) do
    SectionMove(ActiveSectionIndex+1);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSectionBarPopupMenu.AddItem (Sender : TObject);
begin
  with TLMDSectionBar(PopupComponent) do
     ItemAdd(true, FCaptionEdit);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSectionBarPopupMenu.DelItem (Sender : TObject);
begin
  if Assigned(FCurrentItem) then
    with TLMDSectionBar(PopupComponent) do
      ItemDelete(TLMDSectionBarItem(FCurrentItem).Index);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSectionBarPopupMenu.RenItem (Sender : TObject);
begin
  if Assigned(FCurrentItem) then
    with TLMDSectionBar(PopupComponent) do
      ItemEdit(TLMDSectionBarItem(FCurrentItem).Index);
end;

{ -------------------------- public ------------------------------------------ }
procedure TLMDSectionBarPopupMenu.Popup(X, Y: Integer);
var
  i, scount:Integer;
  isActiveSection:Boolean;

const
   iconGroupIndex = 3;

  function Add (capt : String) : TMenuItem;
  var
    mi : TCrackItem;
  begin
    mi := TCrackItem.Create (self);
    mi.Caption := capt;
    Items.Add (mi);
    //return a pointer to the created item (for setting properties)
    result := mi;
  end;

begin
  //delete all items added automatically
  for i:=Items.Count-1 downto 0 do
    if Items[i] is TCrackItem then
      Items.Delete(i);

  //seperate user items from the ones added automatically
  if (Items.Count> 0) and (FVisibleItems <> []) then
    Add ('-');

  scount:=0;

  IsActiveSection:=TLMDSectionBar(PopupComponent).ActiveSectionIndex<>-1;

  //add items
  if sbmIconSize in FVisibleItems then
    begin
      with Add (IDS_BAR_SMALLICONS) do
        begin
          GroupIndex := iconGroupIndex;
          RadioItem := true;
          Enabled := IsActiveSection and (TLMDSectionBar(PopupComponent).ActiveSection.SmallImages<>nil);
          if Enabled then
            with TLMDSectionBar(PopupComponent).ActiveSection do
             Checked:=(ViewStyle=lvsSmallImages);
          OnClick := SetSmallIconSize;
          Inc(scount);
        end;
      with Add (IDS_BAR_LARGEICONS) do
        begin
          GroupIndex := iconGroupIndex;
          RadioItem := true;
          Enabled := IsActiveSection  and (TLMDSectionBar(PopupComponent).ActiveSection.LargeImages<>nil);
          if Enabled then
            with TLMDSectionBar(PopupComponent).ActiveSection do
             Checked:=(ViewStyle=lvsLargeImages);
          OnClick := SetLargeIconSize;
          Inc(scount);
        end;
      if FVisibleItems - [sbmIconSize] <> [] then
        Add ('-');
    end;

  if sbmAddSection in FVisibleItems then
    begin
      with Add (IDS_BAR_ADDSECTION) do
        begin
          OnClick := AddSection;
          Inc(scount);
        end;
    end;

  if sbmDelSection in FVisibleItems then
    begin
      with Add (IDS_BAR_DELSECTION) do
        begin
          Enabled := TLMDSectionBar(PopupComponent).ActiveSections.Count>=1;
          OnClick:=DelSection;
          Inc(scount);
        end;
    end;
  if sbmRenSection in FVisibleItems then
    begin
      with Add (IDS_BAR_RENSECTION) do
        begin
          Enabled := TLMDSectionBar (PopupComponent).ActiveSections.Count >= 1;
          OnClick := RenSection;
           Inc(scount);
       end;
    end;

  //
  if (sbmMoveSection in FVisibleItems) then
    begin
      if sCount>0 then Add ('-');

      with Add (IDS_BAR_MOVESECTIONUP) do
        begin
          Enabled := TLMDSectionBar(PopupComponent).ActiveSectionIndex>0;
          OnClick := MoveSectionUp;
        end;

      with Add (IDS_BAR_MOVESECTIONDOWN) do
        begin
          Enabled := TLMDSectionBar(PopupComponent).ActiveSectionIndex<TLMDSectionBar(PopupComponent).ActiveSections.Count-1;
          OnClick := MoveSectionDown;
        end;

    end;

  if (FVisibleItems - [sbmAddSection, sbmDelSection, sbmRenSection, sbmIconSize] <> []) and //if there are item concerning menu items
     (FVisibleItems - [sbmAddItem, sbmDelItem, sbmRenItem, sbmIconSize] <> []) then //if there are items concerning sections we add a section - item separator line
    Add ('-');

  IsActiveSection:=IsActiveSection and not TLMDSectionBar(PopupComponent).ActiveSection.ReadOnly;

  if sbmAddItem in FVisibleItems then
    with Add (IDS_BAR_ADDITEM) do
      begin
        Enabled :=IsActiveSection;
        OnClick := AddItem;
      end;

  FCurrentItem:=nil;
  if IsActiveSection then
    begin
      IsActiveSection:=IsActiveSection and (TLMDSectionBar(PopupComponent).ActiveSection.SelectedItem<>nil);
      If IsActiveSection then FCurrentItem:=TLMDSectionBar(PopupComponent).ActiveSection.SelectedItem;
    end;

  if sbmDelItem in FVisibleItems then
    with Add (IDS_BAR_DELITEM) do
      begin
        Enabled :=  IsActiveSection;
        OnClick := DelItem;
      end;

  if sbmRenItem in FVisibleItems then
     with Add (IDS_BAR_RENITEM) do
        begin
          Enabled := IsActiveSection;
          OnClick := RenItem;
        end;

  inherited Popup (X,Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSectionBarPopupMenu.Loaded;
begin
  inherited Loaded;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDSectionBarPopupMenu.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FVisibleItems := [sbmAddSection, sbmDelSection, sbmRenSection, sbmMoveSection, sbmAddItem, sbmDelItem, sbmRenItem, sbmIconSize];
end;

{ ---------------------------------------------------------------------------- }
function TLMDSectionBarPopupMenu.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_BAR;
end;

end.
