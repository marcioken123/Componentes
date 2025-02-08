unit LMDDBAliasNamesComboBox;
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

LMDDBAliasNamesComboBox unit (JH)
---------------------------------

ComboBox for selecting a valid bde alias name

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  {$IFNDEF LMDCOMP21}{$IFDEF LMDCOMP16}Bde.DBTables{$ELSE}DBTables{$ENDIF}, {$ENDIF}
  DB, DBCtrls,
  LMDCustomExtCombo, LMDCustomListComboBox;
  type
  TLMDDBAliasNamesComboBox = class (TLMDCustomListComboBox)
  private
  protected
    procedure BeforeDropDown; override;
    procedure UpdateItems;
    procedure Accept; override;
    procedure Loaded; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
  public
    constructor Create (aOwner: TComponent); override;
    destructor Destroy; override;
  published
    property OnSelected;
  end;

implementation

{ ------------------------------------- protected ---------------------------- }
procedure TLMDDBAliasNamesComboBox.BeforeDropDown;
begin
  inherited;
  UpdateItems;  
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBAliasNamesComboBox.UpdateItems;
begin
  Items.Clear;
  {$IFNDEF LMDCOMP21}
  if Assigned (Session) then
    Session.GetAliasNames(Items);
  {$ENDIF}
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBAliasNamesComboBox.Accept;
begin
  inherited;
end;

{ ------------------------------------- public ------------------------------- }
procedure TLMDDBAliasNamesComboBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBAliasNamesComboBox.Loaded;
begin
  inherited;
  Style := csDropDownList;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDDBAliasNamesComboBox.Create (aOwner: TComponent);
begin
  inherited Create (aOwner);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDBAliasNamesComboBox.Destroy;
begin
  inherited Destroy;
end;

end.
