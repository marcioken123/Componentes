unit LMD_RegSearch;
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

_LMD_RegSearch unit (DD)
------------------------
Registers components and editors for LMD SearchPack.

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Classes, Controls, SysUtils,
  DesignIntf, DesignEditors, VCLEditors,
  pLMDCommon, LMDRefineUnit, LMDSearchBase, LMDSearchFileGrep, LMDDBRefine;

procedure Register;

implementation

uses
  pLMDCst, pLMDSearchPE, pLMDOIEnh;

procedure Register;
begin
  RegisterComponents('LMD Search', [TLMDRefine, TLMDSearchFileGrep, TLMDDBRefine]);

  // Component Editor
  RegisterComponentEditor(TLMDSearchBaseDlgComponent, TLMDSearchComponentEditor);

  // Property Editors
  RegisterPropertyEditor(TypeInfo(TLMDSearchTemplate), nil, '', TLMDSearchTemplatePropertyEditor);
  //RegisterPropertyEditor(TypeInfo(String), TLMDSearchFileGrep, 'Content', TLMDSearchFileGrepContentPropertyEditor);

  // get current global settings, entry for adding custom set editors
  if geoSetOI in LMDGLOBALEDITOROPTIONS then
    begin
    end;
end;

end.
