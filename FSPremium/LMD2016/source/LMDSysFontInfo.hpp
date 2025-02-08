// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysFontInfo.pas' rev: 31.00 (Windows)

#ifndef LmdsysfontinfoHPP
#define LmdsysfontinfoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDTypes.hpp>
#include <LMDSysObject.hpp>
#include <LMDSysBase.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysfontinfo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFontItem;
class DELPHICLASS TLMDFontsInfo;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TFontType : unsigned char { ftDEVICE, ftRASTER, ftTRUETYPE };

typedef System::Set<TFontType, TFontType::ftDEVICE, TFontType::ftTRUETYPE> TFontTypes;

enum DECLSPEC_DENUM TtmFlag : unsigned char { TM_ITALIC, TM_BOLD, TM_REGULAR, TM_NONNEGATIVE_AC, TM_PS_OPENTYPE, TM_TT_OPENTYPE, TM_MULTIPLEMASTER, TM_TYPE1, TM_DSIG };

typedef System::Set<TtmFlag, TtmFlag::TM_ITALIC, TtmFlag::TM_DSIG> TtmFlags;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFontItem : public Lmdsysobject::TLMDSysCollectionItem
{
	typedef Lmdsysobject::TLMDSysCollectionItem inherited;
	
private:
	bool FLogItalic;
	bool FLogStikeOut;
	bool FLogUnderline;
	System::Byte FLogFamily;
	System::Byte FLogClipPrecision;
	System::Byte FLogQuality;
	System::Byte FLogOutPrecision;
	int FLogHeight;
	int FLogOrientation;
	int FLogEscapement;
	int FLogWidth;
	int FLogWeight;
	System::UnicodeString FStyle;
	System::UnicodeString FFullName;
	System::UnicodeString FLogFaceName;
	System::UnicodeString FScript;
	System::Uitypes::TFontCharset FLogCharSet;
	System::Uitypes::TFontPitch FLogPitch;
	TFontTypes FFontType;
	bool FtmItalic;
	bool FtmUnderline;
	bool FtmStikeOut;
	System::Byte FtmFamily;
	int FtmSizeEM;
	int FtmExternalLeading;
	int FtmMaxCharWidth;
	int FtmCellHeight;
	int FtmHeight;
	int FtmAscent;
	int FtmInternalLeading;
	int FtmWeight;
	int FtmDigitizedAspectY;
	int FtmDigitizedAspectX;
	int FtmDescent;
	int FtmAveCharWidth;
	System::UnicodeString FtmFirstChar;
	System::Uitypes::TFontCharset FtmCharSet;
	System::Uitypes::TFontPitch FtmPitch;
	TtmFlags FtmFlags;
	System::UnicodeString FtmDefaultChar;
	System::UnicodeString FtmLastChar;
	System::UnicodeString FtmBreakChar;
	int FtmOverhang;
	int FtmAvgWidth;
	void __fastcall SetDummyString(System::UnicodeString aValue);
	void __fastcall SetDummyBool(const bool Value);
	void __fastcall SetDummyByte(const System::Byte Value);
	void __fastcall SetDummyCharset(const System::Uitypes::TFontCharset Value);
	void __fastcall SetDummyFontType(const TFontTypes Value);
	void __fastcall SetDummyLong(const int Value);
	void __fastcall SetDummyPitch(const System::Uitypes::TFontPitch Value);
	void __fastcall SetDummyFlags(const TtmFlags Value);
	System::UnicodeString __fastcall FontTypeToStr(TFontTypes aFontType);
	System::UnicodeString __fastcall FontCharsetToStr(System::Uitypes::TFontCharset aCharSet);
	System::UnicodeString __fastcall FontPitchToStr(System::Uitypes::TFontPitch aPitch);
	System::UnicodeString __fastcall tmFlagsToStr(TtmFlags atmFlags);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property TFontTypes FontType = {read=FFontType, write=SetDummyFontType, nodefault};
	__property System::UnicodeString FullName = {read=FFullName, write=SetDummyString};
	__property System::UnicodeString Style = {read=FStyle, write=SetDummyString};
	__property System::UnicodeString Script = {read=FScript, write=SetDummyString};
	__property int LogHeight = {read=FLogHeight, write=SetDummyLong, nodefault};
	__property int LogWidth = {read=FLogWidth, write=SetDummyLong, nodefault};
	__property int LogEscapement = {read=FLogEscapement, write=SetDummyLong, nodefault};
	__property int LogOrientation = {read=FLogOrientation, write=SetDummyLong, nodefault};
	__property int LogWeight = {read=FLogWeight, write=SetDummyLong, nodefault};
	__property bool LogItalic = {read=FLogItalic, write=SetDummyBool, nodefault};
	__property bool LogUnderline = {read=FLogUnderline, write=SetDummyBool, nodefault};
	__property bool LogStikeOut = {read=FLogStikeOut, write=SetDummyBool, nodefault};
	__property System::Uitypes::TFontCharset LogCharSet = {read=FLogCharSet, write=SetDummyCharset, nodefault};
	__property System::Byte LogOutPrecision = {read=FLogOutPrecision, write=SetDummyByte, nodefault};
	__property System::Byte LogClipPrecision = {read=FLogClipPrecision, write=SetDummyByte, nodefault};
	__property System::Byte LogQuality = {read=FLogQuality, write=SetDummyByte, nodefault};
	__property System::Uitypes::TFontPitch LogPitch = {read=FLogPitch, write=SetDummyPitch, nodefault};
	__property System::Byte LogFamily = {read=FLogFamily, write=SetDummyByte, nodefault};
	__property System::UnicodeString LogFaceName = {read=FLogFaceName, write=SetDummyString};
	__property int tmHeight = {read=FtmHeight, write=SetDummyLong, nodefault};
	__property int tmAscent = {read=FtmAscent, write=SetDummyLong, nodefault};
	__property int tmDescent = {read=FtmDescent, write=SetDummyLong, nodefault};
	__property int tmInternalLeading = {read=FtmInternalLeading, write=SetDummyLong, nodefault};
	__property int tmExternalLeading = {read=FtmExternalLeading, write=SetDummyLong, nodefault};
	__property int tmAveCharWidth = {read=FtmAveCharWidth, write=SetDummyLong, nodefault};
	__property int tmMaxCharWidth = {read=FtmMaxCharWidth, write=SetDummyLong, nodefault};
	__property int tmWeight = {read=FtmWeight, write=SetDummyLong, nodefault};
	__property int tmOverhang = {read=FtmOverhang, write=SetDummyLong, nodefault};
	__property int tmDigitizedAspectX = {read=FtmDigitizedAspectX, write=SetDummyLong, nodefault};
	__property int tmDigitizedAspectY = {read=FtmDigitizedAspectY, write=SetDummyLong, nodefault};
	__property System::UnicodeString tmFirstChar = {read=FtmFirstChar, write=SetDummyString};
	__property System::UnicodeString tmLastChar = {read=FtmLastChar, write=SetDummyString};
	__property System::UnicodeString tmDefaultChar = {read=FtmDefaultChar, write=SetDummyString};
	__property System::UnicodeString tmBreakChar = {read=FtmBreakChar, write=SetDummyString};
	__property bool tmItalic = {read=FtmItalic, write=SetDummyBool, nodefault};
	__property bool tmUnderline = {read=FtmUnderline, write=SetDummyBool, nodefault};
	__property bool tmStikeOut = {read=FtmStikeOut, write=SetDummyBool, nodefault};
	__property System::Uitypes::TFontPitch tmPitch = {read=FtmPitch, write=SetDummyPitch, nodefault};
	__property System::Byte tmFamily = {read=FtmFamily, write=SetDummyByte, nodefault};
	__property System::Uitypes::TFontCharset tmCharSet = {read=FtmCharSet, write=SetDummyCharset, nodefault};
	__property TtmFlags tmFlags = {read=FtmFlags, write=SetDummyFlags, nodefault};
	__property int tmSizeEM = {read=FtmSizeEM, write=SetDummyLong, nodefault};
	__property int tmCellHeight = {read=FtmCellHeight, write=SetDummyLong, nodefault};
	__property int tmAvgWidth = {read=FtmAvgWidth, write=SetDummyLong, nodefault};
public:
	/* TLMDSysBaseCollectionItem.Create */ inline __fastcall virtual TLMDFontItem(System::Classes::TCollection* Collection) : Lmdsysobject::TLMDSysCollectionItem(Collection) { }
	/* TLMDSysBaseCollectionItem.Destroy */ inline __fastcall virtual ~TLMDFontItem(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDFontsInfo : public Lmdsysobject::TLMDSysCollection
{
	typedef Lmdsysobject::TLMDSysCollection inherited;
	
public:
	TLMDFontItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TComponent* FOwner;
	HIDESBASE TLMDFontItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDFontItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	HIDESBASE TLMDFontItem* __fastcall Add(void);
	__fastcall TLMDFontsInfo(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDFontsInfo(void);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	__property TLMDFontItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 NTMNONNEGATIVEAC = System::Int8(0x10);
static const System::Int8 NTMPSOPENTYPE = System::Int8(0x11);
static const System::Int8 NTMTTOPENTYPE = System::Int8(0x12);
static const System::Int8 NTMMULTIPLEMASTER = System::Int8(0x13);
static const System::Int8 NTMTYPE1 = System::Int8(0x14);
static const System::Int8 NTMDSIG = System::Int8(0x15);
}	/* namespace Lmdsysfontinfo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSFONTINFO)
using namespace Lmdsysfontinfo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysfontinfoHPP
