// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDThemesGeneral.pas' rev: 31.00 (Windows)

#ifndef LmdthemesgeneralHPP
#define LmdthemesgeneralHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.UxTheme.hpp>
#include <LMDThemesWindowsXPConsts.hpp>
#include <LMDRTLXConst.hpp>
#include <LMDDebugUnit.hpp>
#include <LMDUnicode.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdthemesgeneral
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TThemePart;
class DELPHICLASS TTheme;
class DELPHICLASS TThemeManager;
//-- type declarations -------------------------------------------------------
typedef NativeUInt TThemeHandle;

typedef NativeUInt TThemeManagerHandle;

typedef _INTLIST TThemeIntList;

typedef _INTLIST *PThemeIntList;

typedef unsigned TThemeSize;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TThemePart : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TThemePart* FParent;
	TTheme* FTheme;
	
public:
	__fastcall virtual TThemePart(TTheme* Theme, TThemePart* Parent);
	__fastcall virtual ~TThemePart(void);
	virtual void __fastcall DrawThemeBackground(HDC DC, int StateID, const System::Types::TRect &Rect, System::Types::PRect ClipRect) = 0 ;
	virtual void __fastcall DrawThemeEdge(HDC DC, int StateID, const System::Types::TRect &DestRect, unsigned Edge, unsigned Flags, System::Types::PRect ContentRect) = 0 ;
	virtual void __fastcall DrawThemeIcon(HDC DC, int StateID, const System::Types::TRect &Rect, NativeUInt ImageList, int ImageIndex) = 0 ;
	virtual void __fastcall DrawThemeText(HDC DC, int StateID, System::WideChar * Text, int CharCount, unsigned TextFlags, unsigned TextFlags2, const System::Types::TRect &Rect) = 0 ;
	virtual void __fastcall GetThemeBackgroundContentRect(HDC DC, int StateID, const System::Types::TRect &BoundingRect, /* out */ System::Types::TRect &ContentRect) = 0 ;
	virtual void __fastcall GetThemeBackgroundExtent(HDC DC, int StateID, const System::Types::TRect &ContentRect, /* out */ System::Types::TRect &ExtentRect) = 0 ;
	virtual void __fastcall GetThemeBackgroundRegion(HDC DC, int StateID, const System::Types::TRect &Rect, /* out */ HRGN &Region) = 0 ;
	virtual void __fastcall GetThemeBool(int StateID, int PropID, /* out */ bool &Value) = 0 ;
	virtual void __fastcall GetThemeColor(int StateID, int PropID, /* out */ unsigned &Color) = 0 ;
	virtual void __fastcall GetThemeEnumValue(int StateID, int PropID, /* out */ int &Value) = 0 ;
	virtual void __fastcall GetThemeFilename(int StateID, int PropID, System::WideChar * ThemeFileName, int MaxNameChars) = 0 ;
	virtual void __fastcall GetThemeFont(HDC DC, int StateID, int PropID, tagLOGFONTW &Font) = 0 ;
	virtual void __fastcall GetThemeInt(int StateID, int PropID, /* out */ int &Value) = 0 ;
	virtual void __fastcall GetThemeIntList(int StateID, int PropID, /* out */ _INTLIST &List) = 0 ;
	virtual void __fastcall GetThemeMargins(HDC DC, int StateID, int PropID, _MARGINS &Margins) = 0 ;
	virtual void __fastcall GetThemeMetric(HDC DC, int StateID, int PropID, /* out */ int &Value) = 0 ;
	virtual void __fastcall GetThemePartSize(HDC DC, int StateID, System::Types::PRect Rect, unsigned SizeType, /* out */ System::Types::TSize &Size) = 0 ;
	virtual void __fastcall GetThemePosition(int StateID, int PropID, /* out */ System::Types::TPoint &Point) = 0 ;
	virtual void __fastcall GetThemePropertyOrigin(int StateID, int PropID, int &Origin) = 0 ;
	virtual void __fastcall GetThemeRect(int StateID, int PropID, /* out */ System::Types::TRect &Rect) = 0 ;
	virtual void __fastcall GetThemeString(int StateID, int PropID, System::WideChar * Buffer, int MaxBufferChars) = 0 ;
	virtual void __fastcall GetThemeTextExtent(HDC DC, int StateID, System::WideChar * Text, int CharCount, unsigned TextFlags, System::Types::PRect BoundingRect, /* out */ System::Types::TRect &ExtentRect) = 0 ;
	virtual void __fastcall GetThemeTextMetrics(HDC DC, int StateID, /* out */ tagTEXTMETRICW &Metrics) = 0 ;
	virtual void __fastcall HitTestThemeBackground(HDC DC, int StateID, unsigned Options, const System::Types::TRect &Rect, HRGN Region, const System::Types::TPoint &Test, /* out */ System::Word &HitTestCode) = 0 ;
	virtual bool __fastcall IsThemeBackgroundPartiallyTransparent(int StateID) = 0 ;
	virtual bool __fastcall IsThemePartStateDefined(int StateID) = 0 ;
	virtual System::UnicodeString __fastcall GetSection(void) = 0 ;
	__property TThemePart* Parent = {read=FParent};
	__property TTheme* Theme = {read=FTheme};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TTheme : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<int> _TTheme__1;
	
	
private:
	int FIndex;
	TThemeManager* FManager;
	_TTheme__1 FPartIndex;
	System::Classes::TList* FParts;
	System::Classes::TNotifyEvent FOnDestroy;
	
protected:
	virtual void __fastcall AddPart(int PartID, TThemePart* ThemePart);
	virtual void __fastcall ClearParts(void);
	virtual TThemePart* __fastcall FindPart(int PartID);
	DYNAMIC void __fastcall DoDestroy(void);
	__property System::Classes::TList* Parts = {read=FParts};
	
public:
	__fastcall virtual TTheme(TThemeManager* Manager);
	__fastcall virtual ~TTheme(void);
	virtual HRESULT __fastcall DrawThemeBackground(HDC DC, int PartID, int StateID, const System::Types::TRect &Rect, System::Types::PRect ClipRect);
	virtual HRESULT __fastcall DrawThemeEdge(HDC DC, int PartID, int StateID, const System::Types::TRect &DestRect, unsigned Edge, unsigned Flags, System::Types::PRect ContentRect);
	virtual void __fastcall DrawThemeIcon(HDC DC, int PartID, int StateID, const System::Types::TRect &Rect, NativeUInt ImageList, int ImageIndex);
	virtual void __fastcall DrawThemeText(HDC DC, int PartID, int StateID, System::WideChar * Text, int CharCount, unsigned TextFlags, unsigned TextFlags2, const System::Types::TRect &Rect);
	virtual void __fastcall GetThemeBackgroundContentRect(HDC DC, int PartID, int StateID, const System::Types::TRect &BoundingRect, /* out */ System::Types::TRect &ContentRect);
	virtual void __fastcall GetThemeBackgroundExtent(HDC DC, int PartID, int StateID, const System::Types::TRect &ContentRect, /* out */ System::Types::TRect &ExtentRect);
	virtual void __fastcall GetThemeBackgroundRegion(HDC DC, int PartID, int StateID, const System::Types::TRect &Rect, /* out */ HRGN &Region);
	virtual void __fastcall GetThemeBool(int PartID, int StateID, int PropID, /* out */ bool &Value);
	virtual HRESULT __fastcall GetThemeColor(int PartID, int StateID, int PropID, /* out */ unsigned &Color);
	virtual void __fastcall GetThemeEnumValue(int PartID, int StateID, int PropID, /* out */ int &Value);
	virtual void __fastcall GetThemeFilename(int PartID, int StateID, int PropID, System::WideChar * ThemeFileName, int MaxNameChars);
	virtual HRESULT __fastcall GetThemeFont(HDC DC, int PartID, int StateID, int PropID, tagLOGFONTW &Font);
	virtual void __fastcall GetThemeInt(int PartID, int StateID, int PropID, /* out */ int &Value);
	virtual void __fastcall GetThemeIntList(int PartID, int StateID, int PropID, /* out */ _INTLIST &List);
	virtual void __fastcall GetThemeMargins(HDC DC, int PartID, int StateID, int PropID, _MARGINS &Margins);
	virtual void __fastcall GetThemeMetric(HDC DC, int PartID, int StateID, int PropID, /* out */ int &Value);
	virtual void __fastcall GetThemePartSize(HDC DC, int PartID, int StateID, System::Types::PRect Rect, unsigned SizeType, /* out */ System::Types::TSize &Size);
	virtual void __fastcall GetThemePosition(int PartID, int StateID, int PropID, /* out */ System::Types::TPoint &Point);
	virtual void __fastcall GetThemePropertyOrigin(int PartID, int StateID, int PropID, /* out */ int &Origin);
	virtual void __fastcall GetThemeRect(int PartID, int StateID, int PropID, /* out */ System::Types::TRect &Rect);
	virtual void __fastcall GetThemeString(int PartID, int StateID, int PropID, System::WideChar * Buffer, int MaxBufferChars);
	virtual bool __fastcall GetThemeSysBool(int BoolID);
	virtual unsigned __fastcall GetThemeSysColor(int ColorID);
	virtual HBRUSH __fastcall GetThemeSysColorBrush(int ColorID);
	virtual HRESULT __fastcall GetThemeSysFont(int FontID, /* out */ tagLOGFONTW &Font);
	virtual HRESULT __fastcall GetThemeSysInt(int IntID, /* out */ int &Value);
	virtual int __fastcall GetThemeSysSize(int SizeID);
	virtual void __fastcall GetThemeSysString(int StringID, System::WideChar * Value, int MaxStringChars);
	virtual void __fastcall GetThemeTextExtent(HDC DC, int PartID, int StateID, System::WideChar * Text, int CharCount, unsigned TextFlags, System::Types::PRect BoundingRect, /* out */ System::Types::TRect &ExtentRect);
	virtual void __fastcall GetThemeTextMetrics(HDC DC, int PartID, int StateID, /* out */ tagTEXTMETRICW &Metrics);
	virtual void __fastcall HitTestThemeBackground(HDC DC, int PartID, int StateID, unsigned Options, const System::Types::TRect &Rect, HRGN Region, const System::Types::TPoint &Test, /* out */ System::Word &HitTestCode);
	virtual bool __fastcall IsThemeBackgroundPartiallyTransparent(int PartID, int StateID);
	virtual bool __fastcall IsThemePartDefined(int PartID, int StateID);
	__property TThemeManager* Manager = {read=FManager};
	__property System::Classes::TNotifyEvent OnDestroy = {read=FOnDestroy, write=FOnDestroy};
	__property int ThemeIndex = {read=FIndex, nodefault};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TThemeManager : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TStringList* FThemes;
	void __fastcall DeleteTempFile(void);
	void __fastcall ThemeDestroyed(System::TObject* Sender);
	
protected:
	System::WideString FColorScheme;
	System::Classes::TStringList* FColorSchemes;
	System::WideString FFileName;
	bool FIsCabFile;
	System::WideString FUnpackedFileName;
	virtual System::WideString __fastcall GetColorScheme(int Index);
	virtual int __fastcall GetColorSchemeCount(void);
	virtual System::WideString __fastcall GetDisplayName(void) = 0 ;
	virtual void __fastcall AddTheme(System::WideString ThemeName, TTheme* Theme);
	virtual void __fastcall ClearThemes(void);
	virtual TTheme* __fastcall CreateTheme(System::WideString ThemeName) = 0 ;
	virtual TTheme* __fastcall FindTheme(System::WideString ThemeName);
	virtual int __fastcall IndexOfTheme(TTheme* Theme);
	
public:
	__fastcall virtual TThemeManager(void);
	__fastcall virtual ~TThemeManager(void);
	virtual void __fastcall CloseThemeData(NativeUInt ThemeHandle);
	virtual HRESULT __fastcall DrawThemeBackground(NativeUInt ThemeHandle, HDC DC, int PartID, int StateID, const System::Types::TRect &Rect, System::Types::PRect ClipRect);
	virtual HRESULT __fastcall DrawThemeEdge(NativeUInt ThemeHandle, HDC DC, int PartID, int StateID, const System::Types::TRect &DestRect, unsigned Edge, unsigned Flags, System::Types::PRect ContentRect);
	virtual void __fastcall DrawThemeIcon(NativeUInt ThemeHandle, HDC DC, int PartID, int StateID, const System::Types::TRect &Rect, NativeUInt ImageList, int ImageIndex);
	virtual void __fastcall DrawThemeParentBackground(HWND Wnd, HDC DC, System::Types::PRect ARect);
	virtual void __fastcall DrawThemeText(NativeUInt ThemeHandle, HDC DC, int PartID, int StateID, System::WideChar * Text, int CharCount, unsigned TextFlags, unsigned TextFlags2, const System::Types::TRect &Rect);
	virtual void __fastcall EnableThemeDialogTexture(HWND Wnd, unsigned Flags);
	virtual void __fastcall EnableTheming(bool Enable);
	virtual void __fastcall GetCurrentThemeName(System::WideChar * ThemeFileName, int MaxNameChars, System::WideChar * ColorName, int MaxColorChars, System::WideChar * FontSize, int MaxSizeChars);
	virtual unsigned __fastcall GetThemeAppProperties(void);
	virtual void __fastcall GetThemeBackgroundContentRect(NativeUInt ThemeHandle, HDC DC, int PartID, int StateID, const System::Types::TRect &BoundingRect, /* out */ System::Types::TRect &ContentRect);
	virtual void __fastcall GetThemeBackgroundExtent(NativeUInt ThemeHandle, HDC DC, int PartID, int StateID, const System::Types::TRect &ContentRect, /* out */ System::Types::TRect &ExtentRect);
	virtual void __fastcall GetThemeBackgroundRegion(NativeUInt ThemeHandle, HDC DC, int PartID, int StateID, const System::Types::TRect &Rect, /* out */ HRGN &Region);
	virtual void __fastcall GetThemeBool(NativeUInt ThemeHandle, int PartID, int StateID, int PropID, /* out */ bool &Value);
	virtual HRESULT __fastcall GetThemeColor(NativeUInt ThemeHandle, int PartID, int StateID, int PropID, /* out */ unsigned &Color);
	virtual void __fastcall GetThemeDocumentationProperty(System::WideChar * ThemeName, System::WideChar * PropertyName, System::WideChar * Value, int MaxValueChars);
	virtual void __fastcall GetThemeEnumValue(NativeUInt ThemeHandle, int PartID, int StateID, int PropID, /* out */ int &Value);
	virtual void __fastcall GetThemeFilename(NativeUInt ThemeHandle, int PartID, int StateID, int PropID, System::WideChar * ThemeFileName, int MaxNameChars);
	virtual HRESULT __fastcall GetThemeFont(NativeUInt ThemeHandle, HDC DC, int PartID, int StateID, int PropID, tagLOGFONTW &Font);
	virtual void __fastcall GetThemeInt(NativeUInt ThemeHandle, int PartID, int StateID, int PropID, /* out */ int &Value);
	virtual void __fastcall GetThemeIntList(NativeUInt ThemeHandle, int PartID, int StateID, int PropID, /* out */ _INTLIST &List);
	virtual void __fastcall GetThemeMargins(NativeUInt ThemeHandle, HDC DC, int PartID, int StateID, int PropID, _MARGINS &Margins);
	virtual void __fastcall GetThemeMetric(NativeUInt ThemeHandle, HDC DC, int PartID, int StateID, int PropID, /* out */ int &Value);
	virtual void __fastcall GetThemePartSize(NativeUInt ThemeHandle, HDC DC, int PartID, int StateID, System::Types::PRect Rect, unsigned SizeType, /* out */ System::Types::TSize &Size);
	virtual void __fastcall GetThemePosition(NativeUInt ThemeHandle, int PartID, int StateID, int PropID, /* out */ System::Types::TPoint &Point);
	virtual void __fastcall GetThemePropertyOrigin(NativeUInt ThemeHandle, int PartID, int StateID, int PropID, /* out */ int &Origin);
	virtual void __fastcall GetThemeRect(NativeUInt ThemeHandle, int PartID, int StateID, int PropID, /* out */ System::Types::TRect &Rect);
	virtual void __fastcall GetThemeString(NativeUInt ThemeHandle, int PartID, int StateID, int PropID, System::WideChar * Buffer, int MaxBufferChars);
	virtual bool __fastcall GetThemeSysBool(NativeUInt ThemeHandle, int BoolID);
	virtual unsigned __fastcall GetThemeSysColor(NativeUInt ThemeHandle, int ColorID);
	virtual HBRUSH __fastcall GetThemeSysColorBrush(NativeUInt ThemeHandle, int ColorID);
	virtual HRESULT __fastcall GetThemeSysFont(NativeUInt ThemeHandle, int FontID, /* out */ tagLOGFONTW &Font);
	virtual HRESULT __fastcall GetThemeSysInt(NativeUInt ThemeHandle, int IntID, /* out */ int &Value);
	virtual int __fastcall GetThemeSysSize(NativeUInt ThemeHandle, int SizeID);
	virtual void __fastcall GetThemeSysString(NativeUInt ThemeHandle, int StringID, System::WideChar * Value, int MaxStringChars);
	virtual void __fastcall GetThemeTextExtent(NativeUInt ThemeHandle, HDC DC, int PartID, int StateID, System::WideChar * Text, int CharCount, unsigned TextFlags, System::Types::PRect BoundingRect, /* out */ System::Types::TRect &ExtentRect);
	virtual void __fastcall GetThemeTextMetrics(NativeUInt ThemeHandle, HDC DC, int PartID, int StateID, /* out */ tagTEXTMETRICW &Metrics);
	virtual NativeUInt __fastcall GetWindowTheme(HWND Wnd);
	virtual void __fastcall HitTestThemeBackground(NativeUInt ThemeHandle, HDC DC, int PartID, int StateID, unsigned Options, const System::Types::TRect &Rect, HRGN Region, const System::Types::TPoint &Test, /* out */ System::Word &HitTestCode);
	virtual bool __fastcall IsThemeBackgroundPartiallyTransparent(NativeUInt ThemeHandle, int PartID, int StateID);
	virtual bool __fastcall IsThemeDialogTextureEnabled(void);
	virtual bool __fastcall IsThemePartDefined(NativeUInt ThemeHandle, int PartID, int StateID);
	virtual NativeUInt __fastcall OpenThemeData(HWND Wnd, const System::WideChar * ClassList);
	virtual void __fastcall SetThemeAppProperties(unsigned Flags);
	virtual void __fastcall SetWindowTheme(HWND Wnd, System::WideChar * SubAppName, System::WideChar * SubIDList);
	virtual void __fastcall Open(System::WideString FileName);
	virtual void __fastcall Close(void);
	virtual void __fastcall Activate(System::WideString ColorScheme);
	virtual void __fastcall ChangeColorScheme(System::WideString ColorScheme);
	virtual void __fastcall Deactivate(void);
	virtual System::WideString __fastcall GetColorSchemeDisplayName(System::WideString SchemeName) = 0 ;
	virtual NativeUInt __fastcall ThemeManagerHandle(void) = 0 ;
	__property System::WideString DisplayName = {read=GetDisplayName};
	__property int ColorSchemeCount = {read=GetColorSchemeCount, nodefault};
	__property System::WideString ColorSchemes[int Index] = {read=GetColorScheme};
	__property System::WideString FileName = {read=FFileName};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall IsValidTheme(NativeUInt ThemeHandle, TTheme* &Theme);
}	/* namespace Lmdthemesgeneral */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTHEMESGENERAL)
using namespace Lmdthemesgeneral;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdthemesgeneralHPP
