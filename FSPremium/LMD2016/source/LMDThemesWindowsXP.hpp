// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDThemesWindowsXP.pas' rev: 31.00 (Windows)

#ifndef LmdthemeswindowsxpHPP
#define LmdthemeswindowsxpHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.CommCtrl.hpp>
#include <System.Types.hpp>
#include <Winapi.UxTheme.hpp>
#include <LMDTypes.hpp>
#include <LMDRTLXConst.hpp>
#include <LMDIniCtrl.hpp>
#include <LMDDebugUnit.hpp>
#include <LMDThemesEngine.hpp>
#include <LMDThemesMain.hpp>
#include <LMDThemesGeneral.hpp>
#include <LMDThemesWindowsXPConsts.hpp>
#include <LMDThemesWindowsXPTypes.hpp>
#include <LMDThemesWindowsXPUtils.hpp>
#include <LMDThemes.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdthemeswindowsxp
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TWindowsXPThemePart;
class DELPHICLASS TWindowsXPTheme;
class DELPHICLASS TWindowsXPThemeMetrics;
class DELPHICLASS TWindowsXPThemeGlobalsPart;
class DELPHICLASS TWindowsXPThemeGlobals;
class DELPHICLASS TWindowsXPThemeManager;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemePart : public Lmdthemesgeneral::TThemePart
{
	typedef Lmdthemesgeneral::TThemePart inherited;
	
	
private:
	typedef System::StaticArray<System::UnicodeString, 8> _TWindowsXPThemePart__1;
	
	
private:
	System::StaticArray<bool, 13> FBoolProps;
	System::StaticArray<System::Uitypes::TColor, 23> FColorProps;
	System::StaticArray<int, 25> FIntProps;
	System::StaticArray<_MARGINS, 3> FMarginsProps;
	System::StaticArray<System::Types::TPoint, 2> FPointProps;
	System::StaticArray<Lmdthemeswindowsxptypes::TXPSize, 7> FSizeProps;
	_TWindowsXPThemePart__1 FStrProps;
	System::UnicodeString FSection;
	Lmdthemeswindowsxptypes::TXPBgType FBgType;
	Lmdthemeswindowsxptypes::TXPBorderType FBorderType;
	Lmdthemeswindowsxptypes::TXPContentAlignment FContentAlignment;
	Lmdthemeswindowsxptypes::TXPFillType FFillType;
	Lmdthemeswindowsxptypes::TXPGlyphType FGlyphType;
	Lmdthemeswindowsxptypes::TXPHAlign FHAlign;
	Lmdthemeswindowsxptypes::TXPIconEffect FIconEffect;
	Lmdthemeswindowsxptypes::TXPImageLayout FImageLayout;
	Lmdthemeswindowsxptypes::TXPImageSelect FImageSelect;
	Lmdthemeswindowsxptypes::TXPOffsetType FOffsetType;
	Lmdthemeswindowsxptypes::TXPSizingType FSizingType;
	Lmdthemeswindowsxptypes::TXPShadowType FTextShadowType;
	Lmdthemeswindowsxptypes::TXPImageSelect FTrueSizeScalingType;
	Lmdthemeswindowsxptypes::TXPVAlign FVAlign;
	System::Classes::TBits* FProps;
	bool __fastcall GetAvailable(int Index);
	Lmdthemeswindowsxptypes::TXPBgType __fastcall GetBgType(void);
	bool __fastcall GetBoolProp(int Tag);
	Lmdthemeswindowsxptypes::TXPBorderType __fastcall GetBorderType(void);
	System::Uitypes::TColor __fastcall GetColorProp(int Tag);
	Lmdthemeswindowsxptypes::TXPContentAlignment __fastcall GetContentAligment(void);
	bool __fastcall GetDefined(int Index);
	Lmdthemeswindowsxptypes::TXPFillType __fastcall GetFillType(void);
	Lmdthemeswindowsxptypes::TXPGlyphType __fastcall GetGlyphType(void);
	Lmdthemeswindowsxptypes::TXPHAlign __fastcall GetHAlign(void);
	Lmdthemeswindowsxptypes::TXPIconEffect __fastcall GetIconEffect(void);
	Lmdthemeswindowsxptypes::TXPImageLayout __fastcall GetImageLayout(void);
	Lmdthemeswindowsxptypes::TXPImageSelect __fastcall GetImageSelect(void);
	int __fastcall GetIntProp(int Tag);
	_MARGINS __fastcall GetMarginsProp(int Tag);
	Lmdthemeswindowsxptypes::TXPOffsetType __fastcall GetOffsetType(void);
	System::Types::TPoint __fastcall GetPointProp(int Tag);
	Lmdthemeswindowsxptypes::TXPSize __fastcall GetSizeProp(int Tag);
	Lmdthemeswindowsxptypes::TXPSizingType __fastcall GetSizingType(void);
	System::UnicodeString __fastcall GetStrProp(int Tag);
	Lmdthemeswindowsxptypes::TXPShadowType __fastcall GetTextShadowType(void);
	Lmdthemeswindowsxptypes::TXPImageSelect __fastcall GetTrueSizeScalingType(void);
	Lmdthemeswindowsxptypes::TXPVAlign __fastcall GetVAlign(void);
	void __fastcall SetDefined(int Index, const bool Value);
	
protected:
	Vcl::Graphics::TBitmap* FGlyphImage;
	Vcl::Graphics::TBitmap* FImage;
	Vcl::Graphics::TBitmap* FImage1;
	Vcl::Graphics::TBitmap* FImage2;
	Vcl::Graphics::TBitmap* FImage3;
	Vcl::Graphics::TBitmap* FImage4;
	Vcl::Graphics::TBitmap* FImage5;
	Lmdthemeswindowsxptypes::TXPRectArray FGlyphRects;
	Lmdthemeswindowsxptypes::TXPRectArray FImageRects;
	Lmdthemeswindowsxptypes::TXPRectArray FImage1Rects;
	Lmdthemeswindowsxptypes::TXPRectArray FImage2Rects;
	Lmdthemeswindowsxptypes::TXPRectArray FImage3Rects;
	Lmdthemeswindowsxptypes::TXPRectArray FImage4Rects;
	Lmdthemeswindowsxptypes::TXPRectArray FImage5Rects;
	virtual void __fastcall DivideImage(Vcl::Graphics::TBitmap* Image, int Count, Lmdthemeswindowsxptypes::TXPRectArray &Rects);
	virtual void __fastcall DivideImages(void);
	virtual void __fastcall DrawBorderFillBackground(HDC DC, int StateID, const System::Types::TRect &R, System::Types::PRect ClipRect);
	virtual void __fastcall DrawGradientBackground(HDC DC, int StateID, const System::Types::TRect &R, System::Types::PRect ClipRect, bool Vertical);
	virtual void __fastcall DrawImageFileBackground(HDC DC, int StateID, const System::Types::TRect &R, System::Types::PRect ClipRect);
	virtual void __fastcall DrawImageGlyph(HDC DC, int StateID, const System::Types::TRect &R, System::Types::PRect ClipRect);
	virtual void __fastcall DrawSolidBackground(HDC DC, int StateID, const System::Types::TRect &R, System::Types::PRect ClipRect);
	void __fastcall DrawStretchedImage(HDC DC, const System::Types::TRect &DstRect, System::Types::PRect ClipRect, Vcl::Graphics::TBitmap* Image, const System::Types::TRect &SrcRect, System::Uitypes::TColor TransparentColor);
	void __fastcall DrawTiledImage(HDC DC, const System::Types::TRect &DstRect, System::Types::PRect ClipRect, Vcl::Graphics::TBitmap* Image, const System::Types::TRect &SrcRect, System::Uitypes::TColor TransparentColor);
	void __fastcall DrawTrueSizedImage(HDC DC, const System::Types::TRect &DstRect, System::Types::PRect ClipRect, Vcl::Graphics::TBitmap* Image, const System::Types::TRect &SrcRect, System::Uitypes::TColor TransparentColor);
	virtual int __fastcall GetStateRectIndex(int StateID);
	virtual void __fastcall ParseScheme(Lmdinictrl::TLMDIniCtrl* const Scheme, System::UnicodeString Section);
	virtual void __fastcall SelectImage(HDC DC, const System::Types::TRect &R, Lmdthemeswindowsxptypes::TXPImageSelect SelectType, Vcl::Graphics::TBitmap* &Image, Lmdthemeswindowsxptypes::PXPRectArray &Rects);
	virtual void __fastcall SetupInternals(void);
	Vcl::Graphics::TBitmap* __fastcall ImageByIndex(int index);
	Lmdthemeswindowsxptypes::PXPRectArray __fastcall RectsArrayByIndex(int index);
	
public:
	__fastcall virtual TWindowsXPThemePart(TWindowsXPTheme* Theme, TWindowsXPThemePart* Parent, System::UnicodeString ASection);
	__fastcall virtual ~TWindowsXPThemePart(void);
	virtual void __fastcall DrawThemeBackground(HDC DC, int StateID, const System::Types::TRect &Rect, System::Types::PRect ClipRect);
	virtual void __fastcall DrawThemeEdge(HDC DC, int StateID, const System::Types::TRect &DestRect, unsigned Edge, unsigned Flags, System::Types::PRect ContentRect);
	virtual void __fastcall DrawThemeIcon(HDC DC, int StateID, const System::Types::TRect &Rect, NativeUInt ImageList, int ImageIndex);
	virtual void __fastcall DrawThemeText(HDC DC, int StateID, System::WideChar * Text, int CharCount, unsigned TextFlags, unsigned TextFlags2, const System::Types::TRect &ARect);
	virtual void __fastcall GetThemeBackgroundContentRect(HDC DC, int StateID, const System::Types::TRect &BoundingRect, /* out */ System::Types::TRect &ContentRect);
	virtual void __fastcall GetThemeBackgroundExtent(HDC DC, int StateID, const System::Types::TRect &ContentRect, /* out */ System::Types::TRect &ExtentRect);
	virtual void __fastcall GetThemeBackgroundRegion(HDC DC, int StateID, const System::Types::TRect &Rect, /* out */ HRGN &Region);
	virtual void __fastcall GetThemeBool(int StateID, int PropID, /* out */ bool &Value);
	virtual void __fastcall GetThemeColor(int StateID, int PropID, /* out */ unsigned &Color);
	virtual void __fastcall GetThemeEnumValue(int StateID, int PropID, /* out */ int &Value);
	virtual void __fastcall GetThemeFilename(int StateID, int PropID, System::WideChar * ThemeFileName, int MaxNameChars);
	virtual void __fastcall GetThemeFont(HDC DC, int StateID, int PropID, tagLOGFONTW &Font);
	virtual void __fastcall GetThemeInt(int StateID, int PropID, /* out */ int &Value);
	virtual void __fastcall GetThemeIntList(int StateID, int PropID, /* out */ _INTLIST &List);
	virtual void __fastcall GetThemeMargins(HDC DC, int StateID, int PropID, _MARGINS &Margins);
	virtual void __fastcall GetThemeMetric(HDC DC, int StateID, int PropID, /* out */ int &Value);
	virtual void __fastcall GetThemePartSize(HDC DC, int StateID, System::Types::PRect Rect, unsigned SizeType, /* out */ System::Types::TSize &Size);
	virtual void __fastcall GetThemePosition(int StateID, int PropID, /* out */ System::Types::TPoint &Point);
	virtual void __fastcall GetThemePropertyOrigin(int StateID, int PropID, int &Origin);
	virtual void __fastcall GetThemeRect(int StateID, int PropID, /* out */ System::Types::TRect &Rect);
	virtual void __fastcall GetThemeString(int StateID, int PropID, System::WideChar * Buffer, int MaxBufferChars);
	virtual void __fastcall GetThemeTextExtent(HDC DC, int StateID, System::WideChar * Text, int CharCount, unsigned TextFlags, System::Types::PRect BoundingRect, /* out */ System::Types::TRect &ExtentRect);
	virtual void __fastcall GetThemeTextMetrics(HDC DC, int StateID, /* out */ tagTEXTMETRICW &Metrics);
	virtual void __fastcall HitTestThemeBackground(HDC DC, int StateID, unsigned Options, const System::Types::TRect &Rect, HRGN Region, const System::Types::TPoint &Test, /* out */ System::Word &HitTestCode);
	virtual bool __fastcall IsThemeBackgroundPartiallyTransparent(int StateID);
	virtual bool __fastcall IsThemePartStateDefined(int StateID);
	virtual System::UnicodeString __fastcall GetSection(void);
	__property bool Available[int Index] = {read=GetAvailable};
	__property bool Defined[int Index] = {read=GetDefined, write=SetDefined};
	__property Lmdthemeswindowsxptypes::TXPBgType BgType = {read=GetBgType, nodefault};
	__property bool BoolProp[int Tag] = {read=GetBoolProp};
	__property Lmdthemeswindowsxptypes::TXPBorderType BorderType = {read=GetBorderType, nodefault};
	__property System::Uitypes::TColor ColorProp[int Tag] = {read=GetColorProp};
	__property Lmdthemeswindowsxptypes::TXPContentAlignment ContentAlignment = {read=GetContentAligment, nodefault};
	__property Lmdthemeswindowsxptypes::TXPFillType FillType = {read=GetFillType, nodefault};
	__property Lmdthemeswindowsxptypes::TXPGlyphType GlyphType = {read=GetGlyphType, nodefault};
	__property Lmdthemeswindowsxptypes::TXPHAlign HAlign = {read=GetHAlign, nodefault};
	__property Lmdthemeswindowsxptypes::TXPIconEffect IconEffect = {read=GetIconEffect, nodefault};
	__property Lmdthemeswindowsxptypes::TXPImageLayout ImageLayout = {read=GetImageLayout, nodefault};
	__property Lmdthemeswindowsxptypes::TXPImageSelect ImageSelect = {read=GetImageSelect, nodefault};
	__property int IntProp[int Tag] = {read=GetIntProp};
	__property _MARGINS MarginsProp[int Tag] = {read=GetMarginsProp};
	__property Lmdthemeswindowsxptypes::TXPOffsetType OffsetType = {read=GetOffsetType, nodefault};
	__property System::Types::TPoint PointProp[int Tag] = {read=GetPointProp};
	__property Lmdthemeswindowsxptypes::TXPSize SizeProp[int Tag] = {read=GetSizeProp};
	__property Lmdthemeswindowsxptypes::TXPSizingType SizingType = {read=GetSizingType, nodefault};
	__property System::UnicodeString StrProp[int Tag] = {read=GetStrProp};
	__property Lmdthemeswindowsxptypes::TXPShadowType TextShadowType = {read=GetTextShadowType, nodefault};
	__property Lmdthemeswindowsxptypes::TXPImageSelect TrueSizeScalingType = {read=GetTrueSizeScalingType, nodefault};
	__property Lmdthemeswindowsxptypes::TXPVAlign VAlign = {read=GetVAlign, nodefault};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TWindowsXPTheme : public Lmdthemesgeneral::TTheme
{
	typedef Lmdthemesgeneral::TTheme inherited;
	
public:
	virtual bool __fastcall GetThemeSysBool(int BoolID);
	virtual unsigned __fastcall GetThemeSysColor(int ColorID);
	virtual HBRUSH __fastcall GetThemeSysColorBrush(int ColorID);
	virtual HRESULT __fastcall GetThemeSysFont(int FontID, /* out */ tagLOGFONTW &Font);
	virtual HRESULT __fastcall GetThemeSysInt(int IntID, /* out */ int &Value);
	virtual int __fastcall GetThemeSysSize(int SizeID);
	virtual void __fastcall GetThemeSysString(int StringID, System::WideChar * Value, int MaxStringChars);
public:
	/* TTheme.Create */ inline __fastcall virtual TWindowsXPTheme(Lmdthemesgeneral::TThemeManager* Manager) : Lmdthemesgeneral::TTheme(Manager) { }
	/* TTheme.Destroy */ inline __fastcall virtual ~TWindowsXPTheme(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeMetrics : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::StaticArray<System::UnicodeString, 4> _TWindowsXPThemeMetrics__1;
	
	
private:
	System::StaticArray<bool, 1> FBools;
	System::StaticArray<bool, 1> FBoolsDefined;
	System::StaticArray<HBRUSH, 31> FBrushes;
	System::StaticArray<bool, 31> FBrushesDefined;
	System::StaticArray<unsigned, 31> FColors;
	System::StaticArray<bool, 31> FColorsDefined;
	System::StaticArray<tagLOGFONTW, 9> FFonts;
	System::StaticArray<bool, 9> FFontsDefined;
	System::StaticArray<int, 3> FInts;
	System::StaticArray<bool, 3> FIntsDefined;
	System::StaticArray<int, 10> FSizes;
	System::StaticArray<bool, 10> FSizesDefined;
	_TWindowsXPThemeMetrics__1 FStrings;
	System::StaticArray<bool, 4> FStringsDefined;
	
public:
	__fastcall TWindowsXPThemeMetrics(void);
	__fastcall virtual ~TWindowsXPThemeMetrics(void);
	void __fastcall ClearMetrics(void);
	void __fastcall ParseMetrics(Lmdinictrl::TLMDIniCtrl* const Scheme);
	bool __fastcall GetBool(int BoolID);
	unsigned __fastcall GetColor(int ColorID);
	HBRUSH __fastcall GetColorBrush(int ColorID);
	tagLOGFONTW __fastcall GetFont(int FontID);
	int __fastcall GetInt(int IntID);
	int __fastcall GetSize(int SizeID);
	System::UnicodeString __fastcall GetString(int StringID);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeGlobalsPart : public TWindowsXPThemePart
{
	typedef TWindowsXPThemePart inherited;
	
public:
	virtual void __fastcall DrawThemeBackground(HDC DC, int StateID, const System::Types::TRect &Rect, System::Types::PRect ClipRect);
	virtual void __fastcall GetThemeBackgroundContentRect(HDC DC, int StateID, const System::Types::TRect &BoundingRect, /* out */ System::Types::TRect &ContentRect);
	virtual void __fastcall GetThemeBackgroundExtent(HDC DC, int StateID, const System::Types::TRect &ContentRect, /* out */ System::Types::TRect &ExtentRect);
	virtual void __fastcall HitTestThemeBackground(HDC DC, int StateID, unsigned Options, const System::Types::TRect &Rect, HRGN Region, const System::Types::TPoint &Test, /* out */ System::Word &HitTestCode);
	virtual bool __fastcall IsThemeBackgroundPartiallyTransparent(int StateID);
	virtual bool __fastcall IsThemePartStateDefined(int StateID);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemeGlobalsPart(TWindowsXPTheme* Theme, TWindowsXPThemePart* Parent, System::UnicodeString ASection) : TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeGlobalsPart(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TWindowsXPThemeGlobals : public TWindowsXPTheme
{
	typedef TWindowsXPTheme inherited;
	
private:
	int FPartID;
	
protected:
	virtual Lmdthemesgeneral::TThemePart* __fastcall FindPart(int PartID);
	
public:
	__fastcall virtual TWindowsXPThemeGlobals(Lmdthemesgeneral::TThemeManager* Manager);
	__property int PartID = {read=FPartID, nodefault};
public:
	/* TTheme.Destroy */ inline __fastcall virtual ~TWindowsXPThemeGlobals(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeManager : public Lmdthemesgeneral::TThemeManager
{
	typedef Lmdthemesgeneral::TThemeManager inherited;
	
private:
	NativeUInt FFileHandle;
	System::UnicodeString FDelFileName;
	TWindowsXPThemeMetrics* FMetrics;
	Lmdinictrl::TLMDIniCtrl* FSchemeIni;
	Lmdinictrl::TLMDIniCtrl* FThemesIni;
	
protected:
	virtual Lmdthemesgeneral::TTheme* __fastcall CreateTheme(System::WideString ThemeName);
	virtual System::WideString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TWindowsXPThemeManager(void);
	__fastcall virtual ~TWindowsXPThemeManager(void);
	virtual void __fastcall Open(System::WideString FileName);
	virtual void __fastcall Close(void);
	virtual void __fastcall Activate(System::WideString ColorScheme);
	virtual void __fastcall ChangeColorScheme(System::WideString ColorScheme);
	virtual void __fastcall Deactivate(void);
	virtual System::WideString __fastcall GetColorSchemeDisplayName(System::WideString SchemeName);
	virtual void __fastcall GetThemeDocumentationProperty(System::WideChar * ThemeName, System::WideChar * PropertyName, System::WideChar * Value, int MaxValueChars);
	virtual unsigned __fastcall GetThemeSysColor(NativeUInt Theme, int ColorID);
	virtual HBRUSH __fastcall GetThemeSysColorBrush(NativeUInt Theme, int ColorID);
	virtual NativeUInt __fastcall ThemeManagerHandle(void);
	__property NativeUInt FileHandle = {read=FFileHandle, nodefault};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdthemeswindowsxp */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTHEMESWINDOWSXP)
using namespace Lmdthemeswindowsxp;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdthemeswindowsxpHPP
