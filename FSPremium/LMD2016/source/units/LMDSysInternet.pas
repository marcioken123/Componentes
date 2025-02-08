unit LMDSysInternet;
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

LMDSysInternet unit (JH)
-----------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDSysBaseComponent,
  LMDSysInternetObject;

type
  { ************************************************************************** }
  TLMDSysInternet = class(TLMDSysBaseComponent)
  private
    function GetObj: TLMDSysInternetObject;
    procedure SetObj(aValue: TLMDSysInternetObject);
  public
    constructor Create(aOwner: TComponent); override;
  published
    property Internet: TLMDSysInternetObject read GetObj write SetObj;
    //property SysLog;
  end;

implementation

{ **************************** TLMDSysInternet ********************************** }
{ ------------------------------- private ------------------------------------ }

function TLMDSysInternet.GetObj: TLMDSysInternetObject;
begin
  Result:= TLMDSysInternetObject(FSysObject);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysInternet.SetObj(aValue: TLMDSysInternetObject);
begin
end;

{ ------------------------------- public ------------------------------------- }

constructor TLMDSysInternet.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FSysObject:= TLMDSysInternetObject.Create;
  InitSysObject;
end;

end.
