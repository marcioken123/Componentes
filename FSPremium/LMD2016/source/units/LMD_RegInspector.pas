unit LMD_RegInspector;
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

_LMD_RegInspector unit (YB)
------------------------
Registration unit for LMD InspectorPack.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  DesignIntf, Classes, Controls, LMDInsPropPage, LMDInsPropInsp;

procedure Register;

implementation

{ ---------------------------------------------------------------------------- }
procedure Register;
begin
  // Connect components with TWinControl, so that
  // it no longer appears on CLX palette.
  GroupDescendentsWith(TLMDCustomPropertyInspector, TWinControl);
  GroupDescendentsWith(TLMDCustomPropsPage, TWinControl);

  RegisterComponents('LMD Inspector', [TLMDSimplePropInspector]);
end;

{ ---------------------------------------------------------------------------- }

end.

