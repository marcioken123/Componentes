unit LMDThemesWindowsXPTypes;
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

LMDThemesWindowsXPTypes unit (VB)
---------------------------------

ToDo
----

Changes
-------
Release 8.0 (XX 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Graphics, UxTheme,
  LMDThemes, LMDThemesWindowsXPConsts;

type
  TXPBgType = (bgNone, bgBorderFill, bgImageFile);
  TXPBorderType = (btNone, btRect, btRoundRect, btEllipse);
  TXPContentAlignment = (caLeft, caCenter, caRight);
  TXPFillType = (ftNone, ftSolid, ftVertGradient, ftHorzGradient,
    ftRadialGradient, ftTileImage);
  TXPFont = packed record
    Name: string[33];
    Size: integer;
    Style: TFontStyles;
  end;
  TXPGlyphType = (gtNone, gtImageGlyph, gtFontGlyph);
  TXPHAlign = (haLeft, haCenter, haRight);
  TXPIconEffect = (ieNone, ieGlow, ieShadow, iePulse, ieAlpha);
  TXPImageLayout = (ilVertical, ilHorizontal);
  TXPImageSelect = (isNone, isDPI, isSize);
  TXPMargins = TMargins;
  TXPSize = packed record
    cX: integer;
    cY: integer;
  end;
  TXPOffsetType = (otTopLeft, otTopRight, otTopMiddle, otBottomLeft,
    otBottomRight, otBottomMiddle, otMiddleLeft, otMiddleRight, otLeftOfCaption,
    otRightOfCaption, otLeftOfLastButton, otRightOfLastButton,
    otAboveLastButton, otBelowLastButton);
  TXPShadowType = (stNone, stSingle, stContinuous);
  TXPSizingType = (stStretch, stTrueSize, stTile, stTileHorz, stTileVert,
    stTileCenter);
  TXPVAlign = (vaTop, vaCenter, vaBottom);

  TXPRectArray = array of TRect;
  PXPRectArray = ^TXPRectArray;
  implementation

end.
