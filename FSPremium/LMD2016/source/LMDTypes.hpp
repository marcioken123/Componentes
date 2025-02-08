// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTypes.pas' rev: 34.00 (Windows)

#ifndef LmdtypesHPP
#define LmdtypesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <System.TypInfo.hpp>
#include <LMDUnicode.hpp>
#include <LMDUnicodeStrings.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtypes
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDMargins;
//-- type declarations -------------------------------------------------------
typedef unsigned TLMDPtrUInt;

typedef int TLMDPtrInt;

typedef System::Sysutils::LongRec TLMDIntRec;

typedef NativeUInt TLMDSize_t;

typedef System::WideChar * PLMDChar;

typedef System::WideChar TLMDChar;

typedef System::UnicodeString TLMDBaseString;

typedef System::Classes::TStrings TLMDStrings;

typedef System::Classes::TStringList TLMDMemoryStrings;

typedef System::UnicodeString TLMDString;

typedef TLMDString TElFString;

typedef void * TLMDDataTag;

typedef System::Typinfo::PPropInfo TLMDPropInfo;

typedef System::Typinfo::PTypeInfo TLMDTypeInfo;

typedef System::Typinfo::PTypeData TLMDTypeData;

typedef System::Typinfo::PPropList TLMDPropList;

enum DECLSPEC_DENUM TLMDBOM : unsigned char { bomNone, bomUTF32BE, bomUTF32LE, bomUTF16BE, bomUTF16LE, bomUTF8, bomUTF7 };

typedef System::DynamicArray<System::WideChar> TLMDCharArray;

typedef System::DynamicArray<System::WideChar> TLMDWideCharArray;

typedef System::DynamicArray<char> TLMDAnsiCharArray;

typedef System::DynamicArray<int> TLMDIntArray;

typedef System::DynamicArray<System::Byte> TLMDByteArray;

typedef System::UnicodeString TLMDRegExString;

enum DECLSPEC_DENUM TLMDUnits : unsigned char { unPoints, unInches, unMillimeters, unAuto };

typedef TLMDUnits TLMDMeasureUnits;

typedef System::Int8 TLMDPercent;

typedef System::StaticArray<void *, 134217727> TPointerList;

typedef TPointerList *PPointerList;

typedef void * TxListItem;

typedef System::StaticArray<System::Byte, 2147483647> TByteArr;

typedef TByteArr *PByteArr;

typedef void * PtrToPixel;

typedef void * UniPtr;

enum DECLSPEC_DENUM TLMDWaitStatus : unsigned char { wsAbandoned, wsSignaled, wsTimeout, wsFailed };

typedef void __fastcall (__closure *TLMDWndMethod)(Winapi::Messages::TMessage &Message);

typedef void __fastcall (__closure *TLMDIndexEvent)(System::TObject* Sender, int Index);

typedef System::UnicodeString TLMDAboutVar;

class PASCALIMPLEMENTATION TLMDMargins : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FTop;
	int FLeft;
	int FRight;
	int FBottom;
	System::Classes::TNotifyEvent FOnChange;
	void __fastcall SetMargins(const int Index, const int Value);
	
protected:
	virtual void __fastcall Change();
	
public:
	__fastcall TLMDMargins()/* overload */;
	__fastcall TLMDMargins(const int ALeft, const int ATop, const int ARight, const int ABottom)/* overload */;
	__fastcall TLMDMargins(const System::Types::TRect &ARect)/* overload */;
	virtual void __fastcall Assign(System::Classes::TPersistent* ASource);
	System::Types::TRect __fastcall AsRect();
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property int Left = {read=FLeft, write=SetMargins, index=0, default=0};
	__property int Top = {read=FTop, write=SetMargins, index=1, default=0};
	__property int Right = {read=FRight, write=SetMargins, index=2, default=0};
	__property int Bottom = {read=FBottom, write=SetMargins, index=3, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDMargins() { }
	
};


enum DECLSPEC_DENUM TLMDPackageID : unsigned char { pi_LMD_BAR, pi_LMD_CHART, pi_LMD_CORE, pi_LMD_DESIGN, pi_LMD_DIALOG, pi_LMD_DOCKING, pi_LMD_ELCORE, pi_LMD_ELPRO, pi_LMD_FX, pi_LMD_GRID, pi_LMD_IDE, pi_LMD_INSPECTOR, pi_LMD_LEGACY, pi_LMD_LOG, pi_LMD_PLUGIN, pi_LMD_PRINT, pi_LMD_RTF, pi_LMD_RTL, pi_LMD_RTLX, pi_LMD_SCRIPT, pi_LMD_SEARCH, pi_LMD_SHELL, pi_LMD_STORAGE, pi_LMD_SYNTAX, pi_LMD_SYS, pi_LMD_THEMES, pi_LMD_TOOLS, pi_LMD_TXT, pi_LMD_WEB };

struct DECLSPEC_DRECORD Lmdtypes__2
{
public:
	System::UnicodeString Name;
	System::UnicodeString Version;
	System::UnicodeString ReleaseDate;
};


typedef System::StaticArray<Lmdtypes__2, 29> Lmdtypes__3;

//-- var, const, procedure ---------------------------------------------------
#define LMDVCL_PRODUCTNAME L"LMD-Tools 2016"
#define LMDTOOLS_REGISTRYPATH L"SOFTWARE\\LMD Innovative\\LMD-Tools 2016"
static const int MaxListSize = int(0x7ffffff);
extern DELPHI_PACKAGE bool LMDDisableOleinit;
extern DELPHI_PACKAGE Lmdtypes__3 LMDPackageInfo;
}	/* namespace Lmdtypes */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTYPES)
using namespace Lmdtypes;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtypesHPP
