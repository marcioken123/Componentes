unit LMDSysWindows;
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

LMDSysWindows unit (JH)
----------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDSysBaseComponent, LMDSysWindowsObject;

type
  { ************************************************************************** }
  TLMDSysWindows = class(TLMDSysBaseComponent)
  private
    function GetObj: TLMDSysWindowsObject;
    procedure SetObj(aValue: TLMDSysWindowsObject);
  protected
  public
    constructor Create(aOwner: TComponent); override;
  published
    property Windows: TLMDSysWindowsObject read GetObj write SetObj;
  end;

implementation

{ **************************** TLMDSysWindows ********************************** }
{ ------------------------------- private ------------------------------------ }
function TLMDSysWindows.GetObj: TLMDSysWindowsObject;
begin
  Result:= TLMDSysWindowsObject(FSysObject);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysWindows.SetObj(aValue: TLMDSysWindowsObject);
begin
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDSysWindows.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FSysObject:= TLMDSysWindowsObject.Create;
  InitSysObject;
end;

end.
