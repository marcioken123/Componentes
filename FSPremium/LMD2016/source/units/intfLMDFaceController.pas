unit intfLMDFaceController;
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

intfLMDFaceController unit (JH)
-------------------------------

Defines several methods which enables a control to read control settings

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Graphics,
  Classes,
  LMDFillObject,
  LMDBevel,
  LMDBitmapEffectObject,
  LMD3DCaption,
  intfLMDBase;

type
  ILMDFaceController = interface(IInterface)
    ['{32BE634B-1A6E-4975-9975-241836293C61}']
    function fcGetFocused: Boolean; 
    function fcGetMouseAbove: Boolean;
    function fcGetTransparent : Boolean;
    function fcGetCtlXP : Boolean;
    function fcGetBorderCtl3D : Boolean;
    function fcGetEnabled     : Boolean;
    function fcGetBackColor   : TColor;

    procedure fcSetFaceController(aComponent:TComponent);
  end;

implementation

end.
