// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDUsp10.pas' rev: 31.00 (Windows)

#ifndef Lmdusp10HPP
#define Lmdusp10HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdusp10
{
//-- forward type declarations -----------------------------------------------
struct SCRIPT_CONTROL;
struct SCRIPT_ANALYSIS;
struct SCRIPT_ITEM;
struct SCRIPT_VISATTR;
struct GOFFSET;
struct SCRIPT_PROPERTIES;
struct SCRIPT_FONTPROPERTIES;
struct SCRIPT_TABDEF;
struct SCRIPT_DIGITSUBSTITUTE;
//-- type declarations -------------------------------------------------------
typedef void * PSCRIPT_CACHE;

typedef void * TScriptCache;

typedef void * *PScriptCache;

typedef SCRIPT_CONTROL *PSCRIPT_CONTROL;

struct DECLSPEC_DRECORD SCRIPT_CONTROL
{
public:
	System::Word uDefaultLanguage;
	System::Byte fFlags;
	System::Byte fReserved;
};


typedef SCRIPT_CONTROL tag_SCRIPT_CONTROL;

typedef SCRIPT_CONTROL TScriptControl;

typedef SCRIPT_CONTROL *PScriptControl;

typedef System::Word SCRIPT_STATE;

typedef SCRIPT_STATE *PSCRIPT_STATE;

typedef SCRIPT_STATE tag_SCRIPT_STATE;

typedef SCRIPT_STATE TScriptState;

typedef SCRIPT_STATE *PScriptState;

struct DECLSPEC_DRECORD SCRIPT_ANALYSIS
{
public:
	System::Word Flags;
	SCRIPT_STATE S;
};


typedef SCRIPT_ANALYSIS *PSCRIPT_ANALYSIS;

typedef SCRIPT_ANALYSIS tag_SCRIPT_ANALYSIS;

typedef SCRIPT_ANALYSIS TScriptAnalysis;

typedef SCRIPT_ANALYSIS *PScriptAnalysis;

typedef SCRIPT_ITEM *PSCRIPT_ITEM;

struct DECLSPEC_DRECORD SCRIPT_ITEM
{
public:
	int iCharPos;
	SCRIPT_ANALYSIS a;
};


typedef SCRIPT_ITEM tag_SCRIPT_ITEM;

typedef SCRIPT_ITEM TScriptItem;

typedef SCRIPT_ITEM *PScriptItem;

enum DECLSPEC_DENUM SCRIPT_JUSTIFY : unsigned char { SCRIPT_JUSTIFY_NONE, SCRIPT_JUSTIFY_ARABIC_BLANK, SCRIPT_JUSTIFY_CHARACTER, SCRIPT_JUSTIFY_RESERVED1, SCRIPT_JUSTIFY_BLANK, SCRIPT_JUSTIFY_RESERVED2, SCRIPT_JUSTIFY_RESERVED3, SCRIPT_JUSTIFY_ARABIC_NORMAL, SCRIPT_JUSTIFY_ARABIC_KASHIDA, SCRIPT_JUSTIFY_ARABIC_ALEF, SCRIPT_JUSTIFY_ARABIC_HA, SCRIPT_JUSTIFY_ARABIC_RA, SCRIPT_JUSTIFY_ARABIC_BA, SCRIPT_JUSTIFY_ARABIC_BARA, SCRIPT_JUSTIFY_ARABIC_SEEN, SCRIPT_JUSTIFY_RESERVED4 };

typedef SCRIPT_JUSTIFY tag_SCRIPT_JUSTIFY;

typedef SCRIPT_VISATTR *PSCRIPT_VISATTR;

struct DECLSPEC_DRECORD SCRIPT_VISATTR
{
public:
	System::Byte fFlags;
	System::Byte fShapeReserved;
};


typedef SCRIPT_VISATTR tag_SCRIPT_VISATTR;

typedef SCRIPT_VISATTR TScriptVisattr;

typedef SCRIPT_VISATTR *PScriptVisattr;

typedef GOFFSET *PGOFFSET;

struct DECLSPEC_DRECORD GOFFSET
{
public:
	int du;
	int dv;
};


typedef GOFFSET TGOffset;

enum DECLSPEC_DENUM TScriptLogAttrs : unsigned char { fSoftBreak, fWhiteSpace, fCharStop, fWordStop, fInvalid, fRes1, fRes2, fRes3 };

typedef System::Set<TScriptLogAttrs, TScriptLogAttrs::fSoftBreak, TScriptLogAttrs::fRes3> SCRIPT_LOGATTR;

typedef SCRIPT_LOGATTR *PSCRIPT_LOGATTR;

typedef SCRIPT_LOGATTR tag_SCRIPT_LOGATTR;

typedef SCRIPT_LOGATTR TScriptLogAttr;

typedef SCRIPT_LOGATTR *PScriptLogAttr;

typedef SCRIPT_PROPERTIES *PSCRIPT_PROPERTIES;

typedef PSCRIPT_PROPERTIES *PPSCRIPT_PROPERTIES;

struct DECLSPEC_DRECORD SCRIPT_PROPERTIES
{
public:
	System::Word LangId;
	System::Word flag1;
	System::Word flag2;
};


typedef SCRIPT_FONTPROPERTIES *PSCRIPT_FONTPROPERTIES;

struct DECLSPEC_DRECORD SCRIPT_FONTPROPERTIES
{
public:
	int cBytes;
	System::Word wgBlank;
	System::Word wgDefault;
	System::Word wgInvalid;
	System::Word wgKashida;
	int iKashidaWidth;
};


typedef SCRIPT_FONTPROPERTIES TScriptFontproperties;

typedef SCRIPT_FONTPROPERTIES *PScriptFontproperties;

typedef SCRIPT_TABDEF *PSCRIPT_TABDEF;

struct DECLSPEC_DRECORD SCRIPT_TABDEF
{
public:
	int cTabStops;
	int iScale;
	int *pTabStops;
	int iTabOrigin;
};


typedef SCRIPT_TABDEF tag_SCRIPT_TABDEF;

typedef SCRIPT_TABDEF TScriptTabDef;

typedef SCRIPT_TABDEF *PScriptTabDef;

typedef void * SCRIPT_STRING_ANALYSIS;

typedef void * TScriptStringAnalysis;

typedef void * *PScriptStringAnalysis;

typedef SCRIPT_DIGITSUBSTITUTE *PSCRIPT_DIGITSUBSTITUTE;

struct DECLSPEC_DRECORD SCRIPT_DIGITSUBSTITUTE
{
public:
	int flag0;
	System::Word flag1;
	unsigned dwReserved;
};


typedef SCRIPT_DIGITSUBSTITUTE tag_SCRIPT_DIGITSUBSTITUTE;

//-- var, const, procedure ---------------------------------------------------
#define usp10 L"usp10.dll"
static const System::Word USPBUILD = System::Word(0x190);
static const System::Int8 SCRIPT_UNDEFINED = System::Int8(0x0);
static const HRESULT USP_E_SCRIPT_NOT_IN_FONT = HRESULT(-2147220992);
extern "C" HRESULT __fastcall ScriptFreeCache(PScriptCache psc);
static const int scContextDigits = int(0x10000);
static const int scInvertPreBoundDir = int(0x20000);
static const int scInvertPostBoundDir = int(0x40000);
static const int scLinkStringBefore = int(0x80000);
static const int scLinkStringAfter = int(0x100000);
static const int scNeutralOverride = int(0x200000);
static const int scNumericOverride = int(0x400000);
static const int scLegacyBidiClass = int(0x800000);
static const System::Int8 ssBidiLevel = System::Int8(0x1f);
static const System::Int8 ssOverrideDirection = System::Int8(0x20);
static const System::Int8 ssInhibitSymSwap = System::Int8(0x40);
static const System::Byte ssCharShape = System::Byte(0x80);
static const System::Word ssDigitSubstitute = System::Word(0x100);
static const System::Word ssInhibitLigate = System::Word(0x200);
static const System::Word ssDisplayZWG = System::Word(0x400);
static const System::Word ssArabicNumContext = System::Word(0x800);
static const System::Word ssGcpClusters = System::Word(0x1000);
static const System::Word ssReserved = System::Word(0x2000);
static const System::Word ssEngineReserved = System::Word(0xc000);
static const System::Word saScript = System::Word(0x3ff);
static const System::Word saRTL = System::Word(0x400);
static const System::Word saLayoutRTL = System::Word(0x800);
static const System::Word saLinkBefore = System::Word(0x1000);
static const System::Word saLinkAfter = System::Word(0x2000);
static const System::Word saLogicalOrder = System::Word(0x4000);
static const System::Word saNoGlyphIndex = System::Word(0x8000);
extern "C" HRESULT __stdcall ScriptItemize(const System::WideChar * pwcInChars, int cInChars, int cMaxItems, const PSCRIPT_CONTROL psControl, const PSCRIPT_STATE psState, PScriptItem pItems, System::PInteger pcItems);
extern "C" HRESULT __stdcall ScriptLayout(int cRuns, const System::PByte pbLevel, System::PInteger piVisualToLogical, System::PInteger piLogicalToVisual);
static const System::Int8 svJustification = System::Int8(0xf);
static const System::Int8 svClusterStart = System::Int8(0x10);
static const System::Int8 svDiacritic = System::Int8(0x20);
static const System::Int8 svZeroWidth = System::Int8(0x40);
static const System::Byte svReserved = System::Byte(0x80);
extern "C" HRESULT __stdcall ScriptShape(HDC hdc, PScriptCache psc, const System::WideChar * pwcChars, int cChars, int cMaxGlyphs, PSCRIPT_ANALYSIS psa, PWORD pwOutGlyphs, PWORD pwLogClust, PScriptVisattr psva, System::PInteger pcGlyphs);
extern "C" HRESULT __stdcall ScriptPlace(HDC hdc, PScriptCache psc, const PWORD pwGlyphs, int cGlyphs, const PScriptVisattr psva, PSCRIPT_ANALYSIS psa, System::PInteger piAdvance, PGOFFSET pGoffset, PABC pABC);
extern "C" HRESULT __stdcall ScriptTextOut(const HDC hdc, PScriptCache psc, int x, int y, unsigned fuOptions, const System::Types::PRect lprc, const PSCRIPT_ANALYSIS psa, const System::WideChar * pwcReserved, int iReserved, const PWORD pwGlyphs, int cGlyphs, const System::PInteger piAdvance, const System::PInteger piJustify, const PGOFFSET pGoffset);
extern "C" HRESULT __stdcall ScriptJustify(const PSCRIPT_VISATTR psva, const System::PInteger piAdvance, int cGlyphs, int iDx, int iMinKashida, System::PInteger piJustify);
extern "C" HRESULT __stdcall ScriptBreak(const System::WideChar * pwcChars, int cChars, const PSCRIPT_ANALYSIS psa, PScriptLogAttr psla);
extern "C" HRESULT __stdcall ScriptCPtoX(int iCP, System::LongBool fTrailing, int cChars, int cGlyphs, PWORD pwLogClust, PSCRIPT_VISATTR psva, System::PInteger piAdvance, PSCRIPT_ANALYSIS psa, System::PInteger piX);
extern "C" HRESULT __stdcall ScriptXtoCP(int iX, int cChars, int cGlyphs, PWORD pwLogClust, PSCRIPT_VISATTR psva, System::PInteger piAdvance, PSCRIPT_ANALYSIS psa, System::PInteger piCP, System::PInteger piTrailing);
extern "C" HRESULT __stdcall ScriptGetLogicalWidths(PSCRIPT_ANALYSIS psa, int cChars, int cGlyphs, System::PInteger piGlyphWidth, PWORD pwLogClust, PScriptVisattr psva, System::PInteger piDx);
extern "C" HRESULT __stdcall ScriptApplyLogicalWidth(System::PInteger piDx, int cChars, int cGlyphs, PWORD pwLogClust, PSCRIPT_VISATTR psva, System::PInteger piAdvance, PSCRIPT_ANALYSIS psa, PABC pABC, System::PInteger piJustify);
static const System::Int8 SGCM_RTL = System::Int8(0x1);
extern "C" HRESULT __stdcall ScriptGetCMap(HDC hdc, PScriptCache psc, System::WideChar * pwcInChars, int cChars, unsigned dwFlags, PWORD pwOutGlyphs);
extern "C" HRESULT __stdcall ScriptGetGlyphABCWidth(HDC hdc, PScriptCache psc, System::Word wGlyph, PABC pABC);
static const int sp1Numeric = int(0x10000);
static const int sp1Complex = int(0x20000);
static const int sp1NeedsWordBreaking = int(0x40000);
static const int sp1NeedsCaretInfo = int(0x80000);
static const int sp1CharSet = int(0xff00000);
static const int sp1Control = int(0x10000000);
static const int sp1PrivateUseArea = int(0x20000000);
static const int sp1NeedsCharacterJustify = int(0x40000000);
static const unsigned sp1InvalidGlyph = unsigned(0x80000000);
static const System::Int8 sp2InvalidLogAttr = System::Int8(0x1);
static const System::Int8 sp2CDM = System::Int8(0x2);
static const System::Int8 sp2AmbiguousCharSet = System::Int8(0x4);
static const System::Int8 sp2ClusterSizeVaries = System::Int8(0x8);
static const System::Int8 sp2RejectInvalid = System::Int8(0x10);
extern "C" HRESULT __stdcall ScriptGetProperties(PPSCRIPT_PROPERTIES &ppSp, System::PInteger piNumScripts);
extern "C" HRESULT __stdcall ScriptGetFontProperties(HDC hdc, PScriptCache psc, PScriptFontproperties sfp);
extern "C" HRESULT __stdcall ScriptCacheGetHeight(HDC hdc, PScriptCache psc, System::PInteger tmHeight);
static const System::Int8 SSA_PASSWORD = System::Int8(0x1);
static const System::Int8 SSA_TAB = System::Int8(0x2);
static const System::Int8 SSA_CLIP = System::Int8(0x4);
static const System::Int8 SSA_FIT = System::Int8(0x8);
static const System::Int8 SSA_DZWG = System::Int8(0x10);
static const System::Int8 SSA_FALLBACK = System::Int8(0x20);
static const System::Int8 SSA_BREAK = System::Int8(0x40);
static const System::Byte SSA_GLYPHS = System::Byte(0x80);
static const System::Word SSA_RTL = System::Word(0x100);
static const System::Word SSA_GCP = System::Word(0x200);
static const System::Word SSA_HOTKEY = System::Word(0x400);
static const System::Word SSA_METAFILE = System::Word(0x800);
static const System::Word SSA_LINK = System::Word(0x1000);
static const System::Word SSA_HIDEHOTKEY = System::Word(0x2000);
static const System::Word SSA_HOTKEYONLY = System::Word(0x2400);
static const int SSA_FULLMEASURE = int(0x4000000);
static const int SSA_LPKANSIFALLBACK = int(0x8000000);
static const int SSA_PIDX = int(0x10000000);
static const int SSA_LAYOUTRTL = int(0x20000000);
static const int SSA_DONTGLYPH = int(0x40000000);
static const unsigned SSA_NOKASHIDA = unsigned(0x80000000);
extern "C" HRESULT __stdcall ScriptStringAnalyse(HDC hdc, const System::WideChar * pString, int cString, int cGlyphs, int iCharset, unsigned dwFlags, int iReqWidth, PScriptControl psControl, PScriptState psState, const System::PInteger piDx, PScriptTabDef pTabdef, const System::PByte pbInClass, PScriptStringAnalysis pssa);
extern "C" HRESULT __stdcall ScriptStringFree(void * pssa);
extern "C" System::Types::PSize __stdcall ScriptString_pSize(void * ssa);
extern "C" System::PInteger __stdcall ScriptString_pcOutChars(void * ssa);
extern "C" PSCRIPT_LOGATTR __stdcall ScriptString_pLogAttr(void * ssa);
extern "C" HRESULT __stdcall ScriptStringGetOrder(void * ssa, PUINT puOrder);
extern "C" HRESULT __stdcall ScriptStringCPtoX(void * ssa, int icp, System::LongBool fTrailing, System::PInteger pX);
extern "C" HRESULT __stdcall ScriptStringXtoCP(void * ssa, int iX, System::PInteger piCh, System::PInteger piTrailing);
extern "C" HRESULT __stdcall ScriptStringGetLogicalWidths(void * ssa, System::PInteger piDx);
extern "C" HRESULT __stdcall ScriptStringValidate(void * ssa);
extern "C" HRESULT __stdcall ScriptStringOut(void * ssa, int iX, int iY, unsigned uOptions, const System::Types::PRect prc, int iMinSel, int iMaxSel, System::LongBool fDisabled);
static const System::Int8 SIC_COMPLEX = System::Int8(0x1);
static const System::Int8 SIC_ASCIIDIGIT = System::Int8(0x2);
static const System::Int8 SIC_NEUTRAL = System::Int8(0x4);
extern "C" HRESULT __stdcall ScriptIsComplex(System::WideChar * pwcInChars, int cInChars, unsigned dwFlags);
static const System::Word sdNationalDigitLanguage = System::Word(0xffff);
static const unsigned sdTraditionalDigitLanguage = unsigned(0xffff0000);
static const System::Byte sdDigitSubstitute = System::Byte(0xff);
extern "C" HRESULT __stdcall ScriptRecordDigitSubstitution(unsigned Locale, PSCRIPT_DIGITSUBSTITUTE psds);
static const System::Int8 SCRIPT_DIGITSUBSTITUTE_CONTEXT = System::Int8(0x0);
static const System::Int8 SCRIPT_DIGITSUBSTITUTE_NONE = System::Int8(0x1);
static const System::Int8 SCRIPT_DIGITSUBSTITUTE_NATIONAL = System::Int8(0x2);
static const System::Int8 SCRIPT_DIGITSUBSTITUTE_TRADITIONAL = System::Int8(0x3);
extern "C" HRESULT __stdcall ScriptApplyDigitSubstitution(PSCRIPT_DIGITSUBSTITUTE psds, PSCRIPT_CONTROL psc, PSCRIPT_STATE pss);
}	/* namespace Lmdusp10 */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDUSP10)
using namespace Lmdusp10;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Lmdusp10HPP
