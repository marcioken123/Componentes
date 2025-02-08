// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysDisplayObject.pas' rev: 31.00 (Windows)

#ifndef LmdsysdisplayobjectHPP
#define LmdsysdisplayobjectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <LMDSysObject.hpp>
#include <LMDSysPlusObject.hpp>
#include <LMDSysWallpaperObject.hpp>
#include <LMDSysScreenSaverObject.hpp>
#include <LMDSysPropertyDesc.hpp>
#include <LMDSysBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysdisplayobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysDisplayMode;
class DELPHICLASS TLMDSysDisplayModes;
class DELPHICLASS TLMDSysDisplayObject;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSysDisplayMode : public Lmdsysobject::TLMDSysBaseCollectionItem
{
	typedef Lmdsysobject::TLMDSysBaseCollectionItem inherited;
	
private:
	unsigned FWidth;
	unsigned FColors;
	unsigned FHeight;
	unsigned FBitsPerPixel;
	unsigned FFrequency;
	bool FMonochrome;
	bool FInterlaced;
	void __fastcall SetDummyCardinal(unsigned aValue);
	void __fastcall SetDummyBool(bool aValue);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	int __fastcall Activate(void);
	int __fastcall Test(void);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property unsigned Width = {read=FWidth, write=SetDummyCardinal, stored=false, nodefault};
	__property unsigned Height = {read=FHeight, write=SetDummyCardinal, stored=false, nodefault};
	__property unsigned Frequency = {read=FFrequency, write=SetDummyCardinal, stored=false, nodefault};
	__property unsigned BitsPerPixel = {read=FBitsPerPixel, write=SetDummyCardinal, stored=false, nodefault};
	__property bool Monochrome = {read=FMonochrome, write=SetDummyBool, stored=false, nodefault};
	__property bool Interlaced = {read=FInterlaced, write=SetDummyBool, stored=false, nodefault};
	__property unsigned Colors = {read=FColors, write=SetDummyCardinal, stored=false, nodefault};
public:
	/* TLMDSysBaseCollectionItem.Create */ inline __fastcall virtual TLMDSysDisplayMode(System::Classes::TCollection* Collection) : Lmdsysobject::TLMDSysBaseCollectionItem(Collection) { }
	/* TLMDSysBaseCollectionItem.Destroy */ inline __fastcall virtual ~TLMDSysDisplayMode(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSysDisplayModes : public Lmdsysobject::TLMDSysBaseCollection
{
	typedef Lmdsysobject::TLMDSysBaseCollection inherited;
	
public:
	TLMDSysDisplayMode* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TComponent* FOwner;
	HIDESBASE TLMDSysDisplayMode* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDSysDisplayMode* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	HIDESBASE TLMDSysDisplayMode* __fastcall Add(void);
	__fastcall TLMDSysDisplayModes(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDSysDisplayModes(void);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	__property TLMDSysDisplayMode* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDSysDisplayDisplayInfo : unsigned char { ddiPlus, ddiScreenSaver, ddiWallPaper, ddiDisplayModes };

typedef System::Set<TLMDSysDisplayDisplayInfo, TLMDSysDisplayDisplayInfo::ddiPlus, TLMDSysDisplayDisplayInfo::ddiDisplayModes> TLMDSysDisplayDisplayInfos;

class PASCALIMPLEMENTATION TLMDSysDisplayObject : public Lmdsysobject::TLMDSysObject
{
	typedef Lmdsysobject::TLMDSysObject inherited;
	
private:
	unsigned FWidth;
	unsigned FHeight;
	unsigned FColors;
	unsigned FBitsPerPixel;
	unsigned FFrequency;
	bool FMonochrome;
	bool FInterlaced;
	Lmdsysplusobject::TLMDSysPlusObject* FPlus;
	Lmdsysscreensaverobject::TLMDSysScreenSaverObject* FScreenSaver;
	TLMDSysDisplayModes* FDisplayModes;
	Lmdsyswallpaperobject::TLMDSysWallpaperObject* FWallpaper;
	TLMDSysDisplayDisplayInfos FDisplayInfo;
	void __fastcall SetDummyPlusInfo(Lmdsysplusobject::TLMDSysPlusObject* aValue);
	void __fastcall SetDummyScreenSaverInfo(Lmdsysscreensaverobject::TLMDSysScreenSaverObject* aValue);
	void __fastcall SetDummyDisplayModes(TLMDSysDisplayModes* aValue);
	void __fastcall SetDummyWallpaperObject(Lmdsyswallpaperobject::TLMDSysWallpaperObject* aValue);
	void __fastcall SetDummyCardinal(unsigned aValue);
	void __fastcall SetDummyBool(bool aValue);
	void __fastcall SetDisplayInfo(const TLMDSysDisplayDisplayInfos Value);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	virtual void __fastcall InitObject(System::Classes::TComponent* aOwner);
	
public:
	__fastcall virtual TLMDSysDisplayObject(void)/* overload */;
	__fastcall TLMDSysDisplayObject(System::Classes::TComponent* aOwner)/* overload */;
	__fastcall virtual ~TLMDSysDisplayObject(void);
	virtual void __fastcall Refresh(void);
	virtual void __fastcall Apply(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	int __fastcall GetElementCount(void);
	System::TObject* __fastcall GetElement(int index);
	
__published:
	__property unsigned Width = {read=FWidth, write=SetDummyCardinal, stored=false, nodefault};
	__property unsigned Height = {read=FHeight, write=SetDummyCardinal, stored=false, nodefault};
	__property unsigned Frequency = {read=FFrequency, write=SetDummyCardinal, stored=false, nodefault};
	__property unsigned BitsPerPixel = {read=FBitsPerPixel, write=SetDummyCardinal, stored=false, nodefault};
	__property bool Monochrome = {read=FMonochrome, write=SetDummyBool, stored=false, nodefault};
	__property bool Interlaced = {read=FInterlaced, write=SetDummyBool, stored=false, nodefault};
	__property unsigned Colors = {read=FColors, write=SetDummyCardinal, stored=false, nodefault};
	__property Lmdsysplusobject::TLMDSysPlusObject* Plus = {read=FPlus, write=SetDummyPlusInfo, stored=false};
	__property Lmdsysscreensaverobject::TLMDSysScreenSaverObject* ScreenSaver = {read=FScreenSaver, write=SetDummyScreenSaverInfo, stored=false};
	__property TLMDSysDisplayModes* DisplayModes = {read=FDisplayModes, write=SetDummyDisplayModes, stored=false};
	__property Lmdsyswallpaperobject::TLMDSysWallpaperObject* Wallpaper = {read=FWallpaper, write=SetDummyWallpaperObject, stored=false};
	__property TLMDSysDisplayDisplayInfos DisplayInfo = {read=FDisplayInfo, write=SetDisplayInfo, default=7};
private:
	void *__ILMDSysContainer;	// Lmdsysbase::ILMDSysContainer 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {D8DECF0C-3DE0-4E44-AD38-F022380E2970}
	operator Lmdsysbase::_di_ILMDSysContainer()
	{
		Lmdsysbase::_di_ILMDSysContainer intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdsysbase::ILMDSysContainer*(void) { return (Lmdsysbase::ILMDSysContainer*)&__ILMDSysContainer; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
#define def_TLMDSysDisplayDisplayInfos (System::Set<TLMDSysDisplayDisplayInfo, TLMDSysDisplayDisplayInfo::ddiPlus, TLMDSysDisplayDisplayInfo::ddiDisplayModes>() << TLMDSysDisplayDisplayInfo::ddiPlus << TLMDSysDisplayDisplayInfo::ddiScreenSaver << TLMDSysDisplayDisplayInfo::ddiWallPaper )
}	/* namespace Lmdsysdisplayobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSDISPLAYOBJECT)
using namespace Lmdsysdisplayobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysdisplayobjectHPP
