unit LMDSysMultimedia;
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

LMDSysMultimedia unit (JH)
--------------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDSysBaseComponent, LMDSysMultimediaObject;

type
  { ************************************************************************** }
  TLMDSysMultimedia = class(TLMDSysBaseComponent)
  private
    function GetObj: TLMDSysMultimediaObject;
    procedure SetObj(aValue: TLMDSysMultimediaObject);
  public
    constructor Create(aOwner: TComponent); override;
  published
    property Multimedia: TLMDSysMultimediaObject read GetObj write SetObj stored false;
    property SysLog;
  end;

implementation

{ **************************** TLMDSysMultimedia ********************************** }
{ ------------------------------- private ------------------------------------ }

function TLMDSysMultimedia.GetObj: TLMDSysMultimediaObject;
begin
  Result:= TLMDSysMultimediaObject(FSysObject);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysMultimedia.SetObj(aValue: TLMDSysMultimediaObject);
begin
end;

{ ------------------------------- public ------------------------------------- }

constructor TLMDSysMultimedia.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FSysObject:= TLMDSysMultimediaObject.Create;
  InitSysObject;
end;

end.
