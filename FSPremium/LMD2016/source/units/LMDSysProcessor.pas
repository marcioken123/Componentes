unit LMDSysProcessor;
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

LMDSysProcessor unit (JH)
-----------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes,
  LMDSysBaseComponent, LMDSysProcessorObject;

type
  { ************************************************************************** }
  TLMDSysProcessor = class(TLMDSysBaseComponent)
  private
    function GetObj: TLMDSysProcessorObject;
    procedure SetObj(aValue: TLMDSysProcessorObject);
  public
    constructor Create(aOwner: TComponent); override;
  published
    property Processor: TLMDSysProcessorObject read GetObj write SetObj;
  end;

implementation

{ **************************** TLMDSysProcessor ********************************** }
{ ------------------------------- private ------------------------------------ }

function TLMDSysProcessor.GetObj: TLMDSysProcessorObject;
begin
  Result:= TLMDSysProcessorObject(FSysObject);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysProcessor.SetObj(aValue: TLMDSysProcessorObject);
begin
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDSysProcessor.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FSysObject:= TLMDSysProcessorObject.Create;
  InitSysObject;
end;

end.
