unit intfLMDBase;
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

intfLMDBase unit (RM)
---------------------
Introduces the ILMDComponent interface which should be implemented by all
LMD controls to provide designtime features (about dialog) and access to
version numbers of a particular package.

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}
interface
uses
  SysUtils, LMDTypes;

type
  ILMDComponent = interface(IInterface)
    ['{42DEE038-9F98-4CA3-9734-F770483E97FF}']
    function getLMDPackage:TLMDPackageID;  // specification in LMDTypes
  end;

  function LMDSupports(const Instance: TObject; const IID: TGUID; out Intf): Boolean;

implementation

// same as implementation in Delphi 6up, but required for Delphi 5 compatibility

function LMDSupports(const Instance: TObject; const IID: TGUID; out Intf): Boolean;

var
  LUnknown: IUnknown;

begin
  Result := (Instance <> nil) and
            ((Instance.GetInterface(IUnknown, LUnknown) and Supports(LUnknown, IID, Intf)) or
             Instance.GetInterface(IID, Intf));
  end;

end.
