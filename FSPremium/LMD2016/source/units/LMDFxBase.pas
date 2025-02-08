unit LMDFxBase;
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

LMDFxBase unit (RM, AH)
------------------------

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
  Windows, Classes, Controls, Messages, Graphics, LMDCustomComponent, LMDTypes,
  LMDBaseControl;

const
 { Paint to bitmap message - paint form content to specified DC
  wParam - Point
  lParam - DC }
  CM_PAINTTOBITMAP      = CM_BASE + 456;

type

  { ************************** TLMDFxComponent ****************************** }
  TLMDFxComponent = class(TLMDCustomComponent)
  public
    function getLMDPackage:TLMDPackageID;override;
  published
    property About;
  end;

  { ************************ TLMDFxGraphicControl *************************** }
  TLMDFxGraphicControl = class(TLMDBaseControl)
  public
    function getLMDPackage:TLMDPackageID;override;
  published
    property About;
  end;

implementation
{$IFDEF LMD_DEBUGTRACE}
uses
   dialogs;
  {$I C2.INC}
{$ENDIF}

{ ************************ TLMDFxGraphicControl ****************************** }
{----------------------------- public -----------------------------------------}
function TLMDFxComponent.getLMDPackage:TLMDPackageID;
begin
  result:=pi_LMD_Fx;
end;

{ ************************ TLMDFxGraphicControl ****************************** }
{----------------------------- public -----------------------------------------}
function TLMDFxGraphicControl.getLMDPackage:TLMDPackageID;
begin
  result:=pi_LMD_Fx;
end;

initialization
{$IFDEF LMD_DEBUGTRACE}
  {$I C3.INC}
{$ENDIF}

end.
