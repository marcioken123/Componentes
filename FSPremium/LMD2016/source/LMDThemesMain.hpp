// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDThemesMain.pas' rev: 31.00 (Windows)

#ifndef LmdthemesmainHPP
#define LmdthemesmainHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Winapi.UxTheme.hpp>
#include <LMDTypes.hpp>
#include <LMDThemesGeneral.hpp>
#include <LMDThemes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdthemesmain
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
static const System::Int8 CMaxIntListCount = System::Int8(0xa);
static const System::Int8 CThemeSizeMin = System::Int8(0x0);
static const System::Int8 CThemeSizeTrue = System::Int8(0x1);
static const System::Int8 CThemeSizeDraw = System::Int8(0x2);
static const System::Int8 CPropOriginState = System::Int8(0x0);
static const System::Int8 CPropOriginPart = System::Int8(0x1);
static const System::Int8 CPropOriginClass = System::Int8(0x2);
static const System::Int8 CPropOriginGlobal = System::Int8(0x3);
static const System::Int8 CPropOriginNotFound = System::Int8(0x4);
extern DELPHI_PACKAGE Lmdthemesgeneral::TThemeManager* __fastcall GetCurrentThemeManager(void);
extern DELPHI_PACKAGE HRESULT __stdcall CloseThemeData(NativeUInt ATheme);
extern DELPHI_PACKAGE HRESULT __stdcall DrawThemeBackground(NativeUInt Theme, HDC DC, int PartID, int StateID, const System::Types::TRect &Rect, System::Types::PRect ClipRect);
extern DELPHI_PACKAGE HRESULT __stdcall DrawThemeEdge(NativeUInt Theme, HDC DC, int PartID, int StateID, const System::Types::TRect &DestRect, unsigned Edge, unsigned Flags, System::Types::PRect ContentRect);
extern DELPHI_PACKAGE HRESULT __stdcall DrawThemeIcon(NativeUInt Theme, HDC DC, int PartID, int StateID, System::Types::PRect Rect, NativeUInt ImageList, int ImageIndex);
extern DELPHI_PACKAGE HRESULT __stdcall DrawThemeParentBackground(HWND Wnd, HDC DC, const System::Types::PRect ARect);
extern DELPHI_PACKAGE HRESULT __stdcall DrawThemeText(NativeUInt Theme, HDC DC, int PartID, int StateID, System::WideChar * Text, int CharCount, unsigned TextFlags, unsigned TextFlags2, const System::Types::TRect &Rect);
extern DELPHI_PACKAGE HRESULT __stdcall EnableThemeDialogTexture(HWND Wnd, unsigned Flags);
extern DELPHI_PACKAGE HRESULT __stdcall EnableTheming(bool Enable);
extern DELPHI_PACKAGE HRESULT __stdcall GetCurrentThemeName(System::WideChar * ThemeFileName, int MaxNameChars, System::WideChar * ColorName, int MaxColorChars, System::WideChar * SizeName, int MaxSizeChars);
extern DELPHI_PACKAGE unsigned __stdcall GetThemeAppProperties(void);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeBackgroundContentRect(NativeUInt Theme, HDC DC, int PartID, int StateID, const System::Types::TRect &BoundingRect, System::Types::TRect &ContentRect);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeBackgroundExtent(NativeUInt Theme, HDC DC, int PartID, int StateID, const System::Types::TRect &ContentRect, System::Types::TRect &ExtentRect);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeBackgroundRegion(NativeUInt Theme, HDC DC, int PartID, int StateID, System::Types::PRect Rect, HRGN &Region);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeBool(NativeUInt Theme, int PartID, int StateID, int PropID, System::LongBool &Value);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeColor(NativeUInt Theme, int PartID, int StateID, int PropID, unsigned &Color);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeDocumentationProperty(System::WideChar * ThemeName, System::WideChar * PropertyName, System::WideChar * Value, int MaxValueChars);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeEnumValue(NativeUInt Theme, int PartID, int StateID, int PropID, int &Value);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeFilename(NativeUInt Theme, int PartID, int StateID, int PropID, System::WideChar * ThemeFileName, int MaxNameChars);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeFont(NativeUInt Theme, HDC DC, int PartID, int StateID, int PropID, tagLOGFONTW &Font);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeInt(NativeUInt Theme, int PartID, int StateID, int PropID, int &Value);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeIntList(NativeUInt Theme, int PartID, int StateID, int PropID, _INTLIST &List);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeMargins(NativeUInt Theme, HDC DC, int PartID, int StateID, int PropID, _MARGINS &Margins);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeMetric(NativeUInt Theme, HDC DC, int PartID, int StateID, int PropID, int &Value);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemePartSize(NativeUInt Theme, HDC DC, int PartID, int StateID, System::Types::PRect Rect, THEMESIZE SizeType, System::Types::TSize &Size);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemePosition(NativeUInt Theme, int PartID, int StateID, int PropID, System::Types::TPoint &Point);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemePropertyOrigin(NativeUInt Theme, int PartID, int StateID, int PropID, int &Origin);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeRect(NativeUInt Theme, int PartID, int StateID, int PropID, System::Types::TRect &Rect);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeString(NativeUInt Theme, int PartID, int StateID, int PropID, System::WideChar * Buffer, int MaxBufferChars);
extern DELPHI_PACKAGE System::LongBool __stdcall GetThemeSysBool(NativeUInt Theme, int BoolID);
extern DELPHI_PACKAGE unsigned __stdcall GetThemeSysColor(NativeUInt Theme, int ColorID);
extern DELPHI_PACKAGE HBRUSH __stdcall GetThemeSysColorBrush(NativeUInt Theme, int ColorID);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeSysFont(NativeUInt Theme, int FontID, tagLOGFONTW &Font);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeSysInt(NativeUInt Theme, int IntID, int &Value);
extern DELPHI_PACKAGE int __stdcall GetThemeSysSize(NativeUInt Theme, int SizeID);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeSysString(NativeUInt Theme, int StringID, System::WideChar * Value, int MaxStringChars);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeTextExtent(NativeUInt Theme, HDC DC, int PartID, int StateID, System::WideChar * Text, int CharCount, unsigned TextFlags, System::Types::PRect BoundingRect, System::Types::TRect &ExtentRect);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeTextMetrics(NativeUInt Theme, HDC DC, int PartID, int StateID, tagTEXTMETRICW &Metrics);
extern DELPHI_PACKAGE NativeUInt __stdcall GetWindowTheme(HWND Wnd);
extern DELPHI_PACKAGE HRESULT __stdcall HitTestThemeBackground(NativeUInt Theme, HDC DC, int PartID, int StateID, unsigned Options, System::Types::PRect Rect, HRGN Region, const System::Types::TPoint Test, System::Word &HitTestCode);
extern DELPHI_PACKAGE bool __stdcall IsAppThemed(void);
extern DELPHI_PACKAGE bool __stdcall IsThemeActive(void);
extern DELPHI_PACKAGE bool __stdcall IsThemeBackgroundPartiallyTransparent(NativeUInt Theme, int PartID, int StateID);
extern DELPHI_PACKAGE System::LongBool __stdcall IsThemeDialogTextureEnabled(void);
extern DELPHI_PACKAGE bool __stdcall IsThemePartDefined(NativeUInt Theme, int PartID, int StateID);
extern DELPHI_PACKAGE NativeUInt __stdcall OpenThemeData(HWND Wnd, System::WideChar * ClassList);
extern DELPHI_PACKAGE void __stdcall SetThemeAppProperties(unsigned Flags);
extern DELPHI_PACKAGE HRESULT __stdcall SetWindowTheme(HWND Wnd, System::WideChar * SubAppName, System::WideChar * SubIDList);
extern DELPHI_PACKAGE NativeUInt __stdcall LoadTheme(const System::WideString FileName);
extern DELPHI_PACKAGE HRESULT __stdcall ActivateTheme(System::WideString ColorScheme);
extern DELPHI_PACKAGE void __stdcall DeactivateTheme(void);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeDisplayName(NativeUInt ThemeManager, System::WideString &DisplayName);
extern DELPHI_PACKAGE HRESULT __stdcall EnumThemeColorSchemes(NativeUInt ThemeManager, System::Classes::TStringList* &Schemes);
extern DELPHI_PACKAGE HRESULT __stdcall GetThemeColorSchemeDisplayName(System::WideString SchemeName, System::WideString &DisplayName);
extern DELPHI_PACKAGE NativeUInt __stdcall GetCurrentThemeManagerHandle(void);
}	/* namespace Lmdthemesmain */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTHEMESMAIN)
using namespace Lmdthemesmain;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdthemesmainHPP
