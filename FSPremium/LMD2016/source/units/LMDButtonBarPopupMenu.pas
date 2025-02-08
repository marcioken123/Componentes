unit LMDButtonBarPopupMenu;
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

LMDButtonBarPopupMenu unit (JH)
-------------------------------

Special popup menu component designed to work with an instance of a 
TLMDButtonBar class.

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Menus, Classes,
  LMDBase, LMDTypes;

type
  TLMDButtonBarPopupMenuItem = (bmAddSection, bmDelSection, bmRenSection,
                                bmAddItem, bmDelItem, bmRenItem,
                                bmIconSize);
  TLMDButtonBarPopupMenuItems = set of TLMDButtonBarPopupMenuItem;

  {---------------------TLMDButtonBarPopupMenu---------------------------------}
  TLMDButtonBarPopupMenu = class (TPopupMenu)
  private
    FAbout        : TLMDAboutVar;
    FVisibleItems : TLMDButtonBarPopupMenuItems;
    //FUserItems    : Integer;

    procedure SetSmallIconSize (Sender : TObject);
    procedure SetLargeIconSize (Sender : TObject);
    procedure AddSection (Sender : TObject);
    procedure DelSection (Sender : TObject);
    procedure RenSection (Sender : TObject);
    procedure AddItem (Sender : TObject);
    procedure DelItem (Sender : TObject);
    procedure RenItem (Sender : TObject);
  public
//    constructor Create(AOwner: TComponent); override;
    procedure Popup(X, Y: Integer); override;
    procedure Loaded; override;
    constructor Create (aOwner : TComponent); override;
  published
    property About:TLMDAboutVar read FAbout write FAbout;
    property VisibleItems : TLMDButtonBarPopupMenuItems read FVisibleItems write FVisibleItems default [bmAddSection, bmDelSection, bmRenSection, bmAddItem, bmDelItem, bmRenItem, bmIconSize];
  end;

implementation
uses
  lmdconst,
  LMDButtonBar;

type
  TCrackItem=class(TMenuItem);  // to identify our own menus

{ *************** TLMDButtonBarPopupMenu ************************************* }
{ ------------------ private ------------------------------------------------- }
procedure TLMDButtonBarPopupMenu.SetSmallIconSize (Sender : TObject);
begin
  TLMDButtonBar (PopupComponent).Sections[TLMDButtonBar (PopupComponent).Open].UseSmallImages := true;
  TMenuItem(Sender).Checked := true;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarPopupMenu.SetLargeIconSize (Sender : TObject);
begin
  TLMDButtonBar (PopupComponent).Sections[TLMDButtonBar (PopupComponent).Open].UseSmallImages := false;
  TMenuItem(Sender).Checked := true;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarPopupMenu.AddSection (Sender : TObject);
begin
  TLMDButtonBar (PopupComponent).AddSection;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarPopupMenu.DelSection (Sender : TObject);
begin
  TLMDButtonBar (PopupComponent).DelSection;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarPopupMenu.RenSection (Sender : TObject);
begin
  TLMDButtonBar (PopupComponent).RenSection;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarPopupMenu.AddItem (Sender : TObject);
begin
  TLMDButtonBar (PopupComponent).AddItem;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarPopupMenu.DelItem (Sender : TObject);
begin
  TLMDButtonBar (PopupComponent).DelItem;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarPopupMenu.RenItem (Sender : TObject);
begin
  TLMDButtonBar (PopupComponent).RenItem;
end;

{ -------------------------- public ------------------------------------------ }
procedure TLMDButtonBarPopupMenu.Popup(X, Y: Integer);
var
  i:Integer;
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
  {while FUserItems < Items.Count do
    Items.Delete(Items.Count-1);}

  //seperate user items from the ones added automatically
  if (Items.Count> 0) and (FVisibleItems <> []) then
    Add ('-');

  //add items
  if bmIconSize in FVisibleItems then
    begin
      with Add (IDS_SMALLICONS) do
        begin
          GroupIndex := iconGroupIndex;
          RadioItem := true;
          Enabled := (TLMDButtonBar (PopupComponent).Sections.Count > 0);
          Checked := (TLMDButtonBar (PopupComponent).Sections.Count > 0) and
                     TLMDButtonBar (PopupComponent).Sections[TLMDButtonBar (PopupComponent).Open].UseSmallImages;
          OnClick := SetSmallIconSize;
        end;
      with Add (IDS_LARGEICONS) do
        begin
          GroupIndex := iconGroupIndex;
          RadioItem := true;
          Enabled := (TLMDButtonBar (PopupComponent).Sections.Count > 0);
          Checked := (TLMDButtonBar (PopupComponent).Sections.Count > 0) and
                     not TLMDButtonBar (PopupComponent).Sections[TLMDButtonBar (PopupComponent).Open].UseSmallImages;
          OnClick := SetLargeIconSize;
        end;
      if FVisibleItems - [bmIconSize] <> [] then
        Add ('-');
    end;
  if bmAddSection in FVisibleItems then
    begin
      with Add (IDS_ADDSECTION) do
        begin
          OnClick := AddSection;
        end;
    end;
  if bmDelSection in FVisibleItems then
    begin
      with Add (IDS_DELSECTION) do
        begin
          Enabled := TLMDButtonBar (PopupComponent).Sections.Count >= 1;
          OnClick := DelSection;
          //TLMDButtonBar (PopupComponent).FSections[TLMDButtonBar (PopupComponent).Open].Free;
        end;
    end;
  if bmRenSection in FVisibleItems then
    begin
      with Add (IDS_RENSECTION) do
        begin
          Enabled := TLMDButtonBar (PopupComponent).Sections.Count >= 1;
          OnClick := RenSection;
        end;
    end;
  if (FVisibleItems - [bmAddSection, bmDelSection, bmRenSection, bmIconSize] <> []) and //if there are item concerning menu items
     (FVisibleItems - [bmAddItem, bmDelItem, bmRenItem, bmIconSize] <> []) then //if there are items concerning sections we add a section - item separator line
    Add ('-');
  if bmAddItem in FVisibleItems then
    begin
      with Add (IDS_ADDITEM) do
        begin
          Enabled :=  (TLMDButtonBar (PopupComponent).Sections.Count > 0) and
                      (not TLMDButtonBar (PopupComponent).Sections[TLMDButtonBar (PopupComponent).Open].ReadOnly);
          OnClick := AddItem;
        end;
    end;
  if bmDelItem in FVisibleItems then
    begin
      with Add (IDS_DELITEM) do
        begin
          Enabled := (TLMDButtonBar (PopupComponent).Sections.Count > 0) and
                     (TLMDButtonBar (PopupComponent).Sections[TLMDButtonBar (PopupComponent).Open].Items.Count > 0) and
                     (not TLMDButtonBar (PopupComponent).Sections[TLMDButtonBar (PopupComponent).Open].ReadOnly) and
                     (TLMDButtonBar (PopupComponent).HighlightedItem <> -1);
          OnClick := DelItem;
        end;
    end;
  if bmRenItem in FVisibleItems then
    begin
      with Add (IDS_RENITEM) do
        begin
          Enabled := (TLMDButtonBar (PopupComponent).Sections.Count > 0) and
                     (TLMDButtonBar (PopupComponent).Sections[TLMDButtonBar (PopupComponent).Open].Items.Count > 0) and
                     (not TLMDButtonBar (PopupComponent).Sections[TLMDButtonBar (PopupComponent).Open].ReadOnly) and
                     (TLMDButtonBar (PopupComponent).HighlightedItem <> -1);
          OnClick := RenItem;
        end;
    end;
  inherited Popup (X,Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarPopupMenu.Loaded;
begin
  inherited Loaded;
  //backup the number of user defined menu entries (only relevant for runtime)
  //FUserItems := Items.Count;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDButtonBarPopupMenu.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FVisibleItems := [bmAddSection, bmDelSection, bmRenSection, bmAddItem, bmDelItem, bmRenItem, bmIconSize];
end;

end.
