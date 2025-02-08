unit LMD_RegDesign;
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

_LMD_RegDesign unit (YB)
------------------------
Registration unit for LMD DesignPack.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  DesignIntf, Classes, Controls, LMDDsgClass, LMDDsgCst, LMDDsgObjects,
  LMDDsgModule, LMDDsgDesigner, LMDSvcPvdr, LMDDsgPropInsp, LMDDsgComboBox,
  LMDDsgManager, LMDDsgDiagram, LMDDsgDiagramDb, pLMDDsgPE;

procedure Register;

implementation

{ ---------------------------------------------------------------------------- }
procedure Register;
begin
  // Connect components with TWinControl, so that
  // it no longer appears on CLX palette.
  GroupDescendentsWith(TLMDServiceProvider, TWinControl);
  GroupDescendentsWith(TLMDDesignObjects, TWinControl);
  GroupDescendentsWith(TLMDModule, TWinControl);
  GroupDescendentsWith(TLMDCustomDesigner, TWinControl);
  GroupDescendentsWith(TLMDCustomDesignManager, TWinControl);

  LMDSvcPvdr._RegisterOnce;
  RegisterComponents('LMD Design', [TLMDDesignManager,
                                    TLMDDesignObjects,
                                    TLMDDesigner,
                                    TLMDDesignPanel,
                                    TLMDModule,
                                    TLMDPropertyInspector,
                                    TLMDObjectComboBox,
                                    TLMDServiceProvider,
                                    TLMDDiagram,
                                    TLMDDBDiagram]);

  RegisterPropertyEditor(TypeInfo(TLMDDiagramItemRef), TLMDDiagramLink, '',
                         TLMDDiagramItemRefProperty);
end;

{ ---------------------------------------------------------------------------- }

end.


