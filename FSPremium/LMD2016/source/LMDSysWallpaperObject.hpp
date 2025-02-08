// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysWallpaperObject.pas' rev: 31.00 (Windows)

#ifndef LmdsyswallpaperobjectHPP
#define LmdsyswallpaperobjectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysObject.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsyswallpaperobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysWallpaperObject;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysWallpaperObject : public Lmdsysobject::TLMDSysObject
{
	typedef Lmdsysobject::TLMDSysObject inherited;
	
private:
	System::UnicodeString FPatternMask;
	System::UnicodeString FPattern;
	System::UnicodeString FFilename;
	bool FStretch;
	bool FTile;
	System::Classes::TStrings* FPatternMasks;
	System::Classes::TStrings* FPatterns;
	void __fastcall SetString(int index, System::UnicodeString aValue);
	void __fastcall SetBoolean(int index, bool aValue);
	void __fastcall SetDummyPatterns(System::Classes::TStrings* aValue);
	System::UnicodeString __fastcall GetString(int index);
	bool __fastcall GetBoolean(int index);
	System::Classes::TStrings* __fastcall GetPatterns(void);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	__fastcall virtual TLMDSysWallpaperObject(void);
	__fastcall virtual ~TLMDSysWallpaperObject(void);
	virtual void __fastcall Apply(void);
	virtual void __fastcall Refresh(void);
	void __fastcall GetPatternBitmap(System::UnicodeString aPatName, Vcl::Graphics::TBitmap* aBitmap);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property System::UnicodeString Filename = {read=GetString, write=SetString, stored=false, index=0};
	__property bool Tile = {read=GetBoolean, write=SetBoolean, stored=false, index=0, nodefault};
	__property bool Stretch = {read=GetBoolean, write=SetBoolean, stored=false, index=1, nodefault};
	__property System::Classes::TStrings* Patterns = {read=GetPatterns, write=SetDummyPatterns, stored=false};
	__property System::UnicodeString Pattern = {read=GetString, write=SetString, stored=false, index=1};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsyswallpaperobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSWALLPAPEROBJECT)
using namespace Lmdsyswallpaperobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsyswallpaperobjectHPP
