unit LMDSysFileAssoc;
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

LMDSysFileAssoc unit (JH)
------------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDSysBaseComponent,
  LMDSysFileAssocInfo;

type
  { ************************************************************************** }
  TLMDSysFileAssoc = class(TLMDSysBaseComponent)
  private
    FFileAssoc: TLMDFileAssocsInfo;
    procedure SetFileAssoc(const Value: TLMDFileAssocsInfo);
  protected
    procedure RefreshIt; override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    function GetElement(index : integer) : TObject;  override;
  published
    property FileAssoc: TLMDFileAssocsInfo read FFileAssoc write SetFileAssoc stored false;
    property SysLog;
  end;

implementation

{ **************************** TLMDSysFileAssoc ********************************** }
{ ------------------------------- private ------------------------------------ }
 procedure TLMDSysFileAssoc.SetFileAssoc(const Value: TLMDFileAssocsInfo);
begin
  FFileAssoc.Assign(Value);
end;

{ -------------------------------- protected --------------------------------- }
procedure TLMDSysFileAssoc.RefreshIt;
begin
  FFileAssoc.Refresh;
end;

 { ------------------------------- public ------------------------------------- }
 constructor TLMDSysFileAssoc.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FFileAssoc:= TLMDFileAssocsInfo.Create(Self);

end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysFileAssoc.Destroy;
begin
  FFileAssoc.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysFileAssoc.GetElement(index: integer): TObject;
begin
  result:=FFileAssoc;
end;

end.
