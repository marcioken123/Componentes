// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDThemesWindowsXPTypes.pas' rev: 31.00 (Windows)

#ifndef LmdthemeswindowsxptypesHPP
#define LmdthemeswindowsxptypesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.UxTheme.hpp>
#include <LMDThemes.hpp>
#include <LMDThemesWindowsXPConsts.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdthemeswindowsxptypes
{
//-- forward type declarations -----------------------------------------------
struct TXPFont;
struct TXPSize;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TXPBgType : unsigned char { bgNone, bgBorderFill, bgImageFile };

enum DECLSPEC_DENUM TXPBorderType : unsigned char { btNone, btRect, btRoundRect, btEllipse };

enum DECLSPEC_DENUM TXPContentAlignment : unsigned char { caLeft, caCenter, caRight };

enum DECLSPEC_DENUM TXPFillType : unsigned char { ftNone, ftSolid, ftVertGradient, ftHorzGradient, ftRadialGradient, ftTileImage };

#pragma pack(push,1)
struct DECLSPEC_DRECORD TXPFont
{
public:
	System::SmallString<33> Name;
	int Size;
	System::Uitypes::TFontStyles Style;
};
#pragma pack(pop)


enum DECLSPEC_DENUM TXPGlyphType : unsigned char { gtNone, gtImageGlyph, gtFontGlyph };

enum DECLSPEC_DENUM TXPHAlign : unsigned char { haLeft, haCenter, haRight };

enum DECLSPEC_DENUM TXPIconEffect : unsigned char { ieNone, ieGlow, ieShadow, iePulse, ieAlpha };

enum DECLSPEC_DENUM TXPImageLayout : unsigned char { ilVertical, ilHorizontal };

enum DECLSPEC_DENUM TXPImageSelect : unsigned char { isNone, isDPI, isSize };

typedef _MARGINS TXPMargins;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TXPSize
{
public:
	int cX;
	int cY;
};
#pragma pack(pop)


enum DECLSPEC_DENUM TXPOffsetType : unsigned char { otTopLeft, otTopRight, otTopMiddle, otBottomLeft, otBottomRight, otBottomMiddle, otMiddleLeft, otMiddleRight, otLeftOfCaption, otRightOfCaption, otLeftOfLastButton, otRightOfLastButton, otAboveLastButton, otBelowLastButton };

enum DECLSPEC_DENUM TXPShadowType : unsigned char { stNone, stSingle, stContinuous };

enum DECLSPEC_DENUM TXPSizingType : unsigned char { stStretch, stTrueSize, stTile, stTileHorz, stTileVert, stTileCenter };

enum DECLSPEC_DENUM TXPVAlign : unsigned char { vaTop, vaCenter, vaBottom };

typedef System::DynamicArray<System::Types::TRect> TXPRectArray;

typedef TXPRectArray *PXPRectArray;

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdthemeswindowsxptypes */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTHEMESWINDOWSXPTYPES)
using namespace Lmdthemeswindowsxptypes;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdthemeswindowsxptypesHPP
