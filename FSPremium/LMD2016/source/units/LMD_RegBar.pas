unit LMD_RegBar;
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

_LMD_RegBar unit (DD, RM, AH)
-----------------------------
Registration unit for LMD BarPack.

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Classes, SysUtils, Controls;

procedure Register;

implementation
uses
  DesignIntf, DesignEditors, VCLEditors,
  pLMDBarCE, pLMDBarPE, pLMDOIEnh, pLMDCommon, pLMDGlobalEditors,
  LMDBarBase, LMDBarHTMLLabel, LMDExplorerBar, LMDSectionBar, LMDSectionBarPopupMenu;

{------------------------------------------------------------------------------}
procedure Register;
begin

  // components
  RegisterComponents('LMD Bar',  [TLMDExplorerBarStorage,
                                  TLMDExplorerBar,
                                  TLMDExplorerBarController,
                                  TLMDSectionBar,
                                  TLMDSectionBarStorage,
                                  TLMDSectionBarController,
                                  TLMDSectionBarPopupMenu,
                                  TLMDBarHTMLLabel
                                  ]);

  // Component Editors
  RegisterComponentEditor(TLMDSectionBar, TLMDBarSectionBarEditor);
  RegisterComponentEditor(TLMDSectionBarStorage, TLMDBarSectionBarEditor);
  RegisterComponentEditor(TLMDSectionBarController, TLMDBarSectionBarControllerEditor);
  RegisterPropertyEditor(TypeInfo(TCollection), TLMDSectionBar, 'Sections', TLMDBarSectionBarCollectionProperty);
  RegisterPropertyEditor(TypeInfo(TCollection), TLMDSectionBarStorage, 'Sections', TLMDBarSectionBarCollectionProperty);

  RegisterComponentEditor(TLMDExplorerBar, TLMDBarExplorerBarEditor);
  RegisterComponentEditor(TLMDExplorerBarStorage, TLMDBarExplorerBarEditor);
  RegisterPropertyEditor(TypeInfo(TCollection), TLMDExplorerBar, 'Sections', TLMDBarExplorerBarCollectionProperty);
  RegisterPropertyEditor(TypeInfo(TCollection), TLMDExplorerBarStorage, 'Sections', TLMDBarExplorerBarCollectionProperty);

  RegisterComponentEditor(TLMDBarHTMLLabel, TLMDBarHTMLLabelComponentEditor);
  RegisterPropertyEditor(TypeInfo(TLMDBarHTMLString), TLMDBarHTMLLabel, 'Caption', TLMDBarCaptionProperty);

  // get current global settings, entry for adding custom set editors
  // ToDo
  if geoSetOI in LMDGLOBALEDITOROPTIONS then
    begin
      RegisterPropertyEditor(TypeInfo(TLMDSectionBarPopupMenuItems), nil, '', TLMDSetProperty);
    end;
end;

end.

