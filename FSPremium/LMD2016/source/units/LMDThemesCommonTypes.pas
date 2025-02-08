unit LMDThemesCommonTypes;
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

LMDThemesCommonTypes unit (VB)
------------------------------

Contains common types and constants for gradient theme renderers

Changes
-------
Release 10.0 (January 2010)
- Initial Release

###############################################################################}

interface

uses
  Graphics, TypInfo, Themes;

type
  TLMDColorIndex = (ciStart, ciEnd);
  TLMDDetailPropKind = (dpkFill, dpkFrame, dpkEnabledText, dpkDisabledText);
  TLMDDetailPropKindSet = set of TLMDDetailPropKind;
  TLMDColorIndexSet = set of TLMDColorIndex;
  TThemedElementSet = set of TThemedElement;
  TLMDGradientColorCountType = (gccCalculated, gccFixed);

  TLMDThemeDetailMetaData = record
    DetailTypeInfo: PTypeInfo;
    FillData: Pointer;
    FrameData: Pointer;
    TextData: Pointer;
    AuxData: Pointer;
  end;

  TLMDThemeElementMetaData = record
    ElementTypeInfo: PTypeInfo;
    DetailData: array of TLMDThemeDetailMetaData;
  end;

  PLMDThemeElementMetaData = ^TLMDThemeElementMetaData;

  TLMDGradientColorsData = array[0..255] of array[TLMDColorIndex] of TColor;
  PLMDGradientColorsData = ^TLMDGradientColorsData;
  TLMDColorsData = array[0..255] of TColor;
  PLMDColorsData = ^TLMDColorsData;

const
  CAllDetailPropKinds = [dpkFill, dpkFrame, dpkDisabledText, dpkEnabledText];

implementation

end.
