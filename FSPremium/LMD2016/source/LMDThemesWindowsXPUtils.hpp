// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDThemesWindowsXPUtils.pas' rev: 31.00 (Windows)

#ifndef LmdthemeswindowsxputilsHPP
#define LmdthemeswindowsxputilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDThemesWindowsXPTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdthemeswindowsxputils
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Lmdthemeswindowsxptypes::TXPBgType __fastcall StrToBgType(System::UnicodeString S, Lmdthemeswindowsxptypes::TXPBgType Default);
extern DELPHI_PACKAGE bool __fastcall StrToBoolean(System::UnicodeString S, bool Default);
extern DELPHI_PACKAGE Lmdthemeswindowsxptypes::TXPBorderType __fastcall StrToBorderType(System::UnicodeString S, Lmdthemeswindowsxptypes::TXPBorderType Default);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall StrToColor(System::UnicodeString S, System::Uitypes::TColor Default);
extern DELPHI_PACKAGE Lmdthemeswindowsxptypes::TXPContentAlignment __fastcall StrToContentAlignment(System::UnicodeString S, Lmdthemeswindowsxptypes::TXPContentAlignment Default);
extern DELPHI_PACKAGE Lmdthemeswindowsxptypes::TXPFillType __fastcall StrToFillType(System::UnicodeString S, Lmdthemeswindowsxptypes::TXPFillType Default);
extern DELPHI_PACKAGE bool __fastcall StrToFont(System::UnicodeString S, Lmdthemeswindowsxptypes::TXPFont &Font);
extern DELPHI_PACKAGE Lmdthemeswindowsxptypes::TXPGlyphType __fastcall StrToGlyphType(System::UnicodeString S, Lmdthemeswindowsxptypes::TXPGlyphType Default);
extern DELPHI_PACKAGE Lmdthemeswindowsxptypes::TXPHAlign __fastcall StrToHAlign(System::UnicodeString S, Lmdthemeswindowsxptypes::TXPHAlign Default);
extern DELPHI_PACKAGE Lmdthemeswindowsxptypes::TXPIconEffect __fastcall StrToIconEffect(System::UnicodeString S, Lmdthemeswindowsxptypes::TXPIconEffect Default);
extern DELPHI_PACKAGE Lmdthemeswindowsxptypes::TXPImageLayout __fastcall StrToImageLayout(System::UnicodeString S, Lmdthemeswindowsxptypes::TXPImageLayout Default);
extern DELPHI_PACKAGE Lmdthemeswindowsxptypes::TXPImageSelect __fastcall StrToImageSelect(System::UnicodeString S, Lmdthemeswindowsxptypes::TXPImageSelect Default);
extern DELPHI_PACKAGE _MARGINS __fastcall StrToMargins(System::UnicodeString S, const _MARGINS &Default);
extern DELPHI_PACKAGE Lmdthemeswindowsxptypes::TXPOffsetType __fastcall StrToOffsetType(System::UnicodeString S, Lmdthemeswindowsxptypes::TXPOffsetType Default);
extern DELPHI_PACKAGE System::Types::TPoint __fastcall StrToPoint(System::UnicodeString S, const System::Types::TPoint &Default);
extern DELPHI_PACKAGE System::Types::TRect __fastcall StrToRect(System::UnicodeString S, const System::Types::TRect &Default);
extern DELPHI_PACKAGE Lmdthemeswindowsxptypes::TXPShadowType __fastcall StrToShadowType(System::UnicodeString S, Lmdthemeswindowsxptypes::TXPShadowType Default);
extern DELPHI_PACKAGE Lmdthemeswindowsxptypes::TXPSize __fastcall StrToSize(System::UnicodeString S, const Lmdthemeswindowsxptypes::TXPSize &Default);
extern DELPHI_PACKAGE Lmdthemeswindowsxptypes::TXPSizingType __fastcall StrToSizingType(System::UnicodeString S, Lmdthemeswindowsxptypes::TXPSizingType Default);
extern DELPHI_PACKAGE Lmdthemeswindowsxptypes::TXPVAlign __fastcall StrToVAlign(System::UnicodeString S, Lmdthemeswindowsxptypes::TXPVAlign Default);
extern DELPHI_PACKAGE _MARGINS __fastcall XPMargins(int Left, int Right, int Top, int Bottom);
extern DELPHI_PACKAGE Lmdthemeswindowsxptypes::TXPSize __fastcall XPSize(int Width, int Height);
extern DELPHI_PACKAGE System::UnicodeString __fastcall NormalizeFileName(const System::UnicodeString FileName);
}	/* namespace Lmdthemeswindowsxputils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTHEMESWINDOWSXPUTILS)
using namespace Lmdthemeswindowsxputils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdthemeswindowsxputilsHPP
