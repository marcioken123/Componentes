unit LMD_RegFx;
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

_LMD_RegFx unit (RM, AH)
-----------------------

Note
----
LMD FxPack is based on code licensed from Eugene Kryukov

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  DesignIntf, DesignEditors, VCLEditors,
  Classes, Controls, SysUtils;

procedure Register;

implementation

uses
  pLMDCommon, pLMDFxAniListDesigner, pLMDFxAniDesigner, pLMDCst,
  LMDFxBase, LMDFxEffect, LMDFxAnimation, LMDFxImage, LMDFxForm, LMDFxImageList;

procedure Register; {==========================================================}
begin
  GroupDescendentsWith(TLMDFxComponent, TWinControl);

  RegisterComponents('LMD Fx', [TLMDFxAnimationList,
                                TLMDFxAnimationForm,
                                TLMDFxImageList,
                                TLMDFxImage
                               ]);

  RegisterNoIcon([TLMDFxAnimation]);

  RegisterComponentEditor(TLMDFxAnimationList, TLMDFxAnimationListEditor);

  RegisterPropertyEditor(TypeInfo(TLMDFxEffectKind), TLMDFxAnimation, 'Effect', TLMDFxAnimationPropertyEditor);

end;

end.
