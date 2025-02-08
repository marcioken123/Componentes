unit LMDDBTablesComboBox;
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

LMDDBTablesComboBox unit (JH)
-----------------------------

ComboBox for selecting a table from a database

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  {$IFNDEF LMDCOMP21}{$IFNDEF LMDX64} {$IFDEF LMDCOMP16}Bde.DBTables{$ELSE}DBTables{$ENDIF}, {$ENDIF}{$ENDIF}
  DB, DBCtrls, LMDCustomExtCombo, LMDCustomListComboBox;

type
  TLMDDBTablesComboBox = class (TLMDCustomListComboBox)
  private
    FDatabaseName: String;
    procedure SetDatabaseName (aValue: String);
  protected
    procedure BeforeDropDown; override;
    procedure UpdateItems;
    procedure Accept; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
    procedure Loaded; override;
  public
    constructor Create (aOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DatabaseName: String read FDatabaseName write SetDatabaseName;
    property OnSelected;
  end;

implementation

{ ------------------------------------- private ------------------------------ }
procedure TLMDDBTablesComboBox.SetDatabaseName (aValue: String);
begin
  FDatabaseName := aValue;
  Text := '';
end;

{ ------------------------------------- protected ---------------------------- }
procedure TLMDDBTablesComboBox.BeforeDropDown;
begin
  inherited;
  UpdateItems;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBTablesComboBox.UpdateItems;
{$IFNDEF LMDCOMP21}
var
  FExtensions,
  FSystem     : Boolean;
{$ENDIF}
begin
  Items.Clear;
  {$IFNDEF LMDCOMP21}
  FExtensions := true;
  FSystem     := true;
  if Assigned (Session) then
    Session.GetTableNames(FDataBaseName, '', FExtensions, FSystem, Items);
  {$ENDIF}
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBTablesComboBox.Accept;
begin
  inherited;
end;

{ ------------------------------------- public ------------------------------- }
procedure TLMDDBTablesComboBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBTablesComboBox.Loaded;
begin
  inherited;
  Style := csDropDownList;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDDBTablesComboBox.Create (aOwner: TComponent);
begin
  inherited Create (aOwner);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDBTablesComboBox.Destroy;
begin
  inherited Destroy;
end;

end.
