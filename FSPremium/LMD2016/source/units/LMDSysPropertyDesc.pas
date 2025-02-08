unit LMDSysPropertyDesc;
{$I LMDCmps.inc}

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

LMDSysPropertyDesc unit (JH)
---------------------------

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Classes;

type
  { ************************************************************************** }
  TLMDSysPropertyDesc = class (TCollectionItem)
  private
    FPropertyId         : integer;
    FTitle              : string;
    FDescription        : string;
    FAvailable          : boolean;
    FText               : string;
    procedure SetText(value : string);
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property PropertyID : integer read FPropertyID write FPropertyID;
    property Title : string read FTitle write FTitle;
    property Description : string read FDescription write FDescription;
    property Available : boolean read FAvailable write FAvailable;
    property Text : string read FText write SetText;
  end;

  { ************************************************************************** }
  TLMDSysPropertiesDesc = class (TCollection)
  private
    function GetItem(index : integer) : TLMDSysPropertyDesc;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(aPropertyID : integer; aTitle, aDescription : string) : TLMDSysPropertyDesc;
    function PropertyByID(aID : integer) : TLMDSysPropertyDesc;
    procedure InvalidateProperties;
    property Items[index : integer] : TLMDSysPropertyDesc read GetItem; default;
  end;

implementation
uses
  Sysutils;

{ **************************** TLMDSysPropertyDesc *************************** }
{ ------------------------------- private ------------------------------------ }
procedure TLMDSysPropertyDesc.SetText(value : string);
begin
  FAvailable := True;
  FText := value;
end;

{ ------------------------------- protected ---------------------------------- }
{ ------------------------------- public ------------------------------------- }
constructor TLMDSysPropertyDesc.Create(Collection: TCollection);
begin
  inherited;
  FPropertyID := -1;
  FTitle := '';
  FDescription := '';
  FAvailable := False;
  FText := '';
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysPropertyDesc.Destroy;
begin
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }

{ **************************** TLMDSysPropertiesDesc ************************* }
{ ------------------------------- private ------------------------------------ }
function TLMDSysPropertiesDesc.GetItem(index : integer) : TLMDSysPropertyDesc;
begin
  result := TLMDSysPropertyDesc(inherited GetItem(index));
end;

{ ------------------------------- protected ---------------------------------- }
{ ------------------------------- public ------------------------------------- }
constructor TLMDSysPropertiesDesc.Create;
begin
  inherited Create(TLMDSysPropertyDesc);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysPropertiesDesc.Destroy;
begin
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysPropertiesDesc.Add(aPropertyID : integer; aTitle, aDescription : string) : TLMDSysPropertyDesc;
begin
  result := TLMDSysPropertyDesc(inherited Add);
  result.PropertyID := aPropertyID;
  result.Title := aTitle;
  result.Description := aDescription;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysPropertiesDesc.PropertyByID(aID : integer) : TLMDSysPropertyDesc;
var
  i : integer;
begin
  result := nil;
  for i := 0 to count-1 do
    if GetItem(i).PropertyID = aID then
      begin
        result := GetItem(i);
        break;
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysPropertiesDesc.InvalidateProperties;
var
  i : integer;
begin
  for i := 0 to count-1 do
    GetItem(i).Available := False;
end;

{ ---------------------------------------------------------------------------- }
end.
