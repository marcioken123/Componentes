unit LMDShapeHint;
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

LMDShapeHint unit (RM)
---------------------

ToDo
----
* Animation

Changes
-------
Release 8.07 (March 2008)
* UseSystemShadow support
* Changed To Region-drawing

Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Controls, Messages, Graphics, LMDTypes,
  LMDPNGImage, LMDButtonBase, LMD3DCaption, LMDCustomHint, LMDCustomShapeHint;

type
  {-------------------- class TLMDShapeHint -----------------------------------}

  TLMDShapeHint = class(TLMDCustomShapeHint)
  published
    property CloseBtnType;
    property CloseBtnStyle;
    property DefaultTitle;
    property DefaultIcon;
    property Enabled;
    property Font3D;
    property Gradient;
    property HideAccelChar;
    property Distance;
    property NoseLength;
    property NoseWidth;
    property NoseAngleWidth;
    property Options;
    property Position;
    property RoundRectWidth;
    property Shadow;
    property Style;
    property ThemeMode;
    property ThemeGlobalMode;
    property TitleFont;
    property TitleFont3D;
    property UseGradient;
    property UseSystemShadow;
  end;

implementation

end.
