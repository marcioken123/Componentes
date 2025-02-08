// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCurrencySettings.pas' rev: 31.00 (Windows)

#ifndef LmdcurrencysettingsHPP
#define LmdcurrencysettingsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>
#include <LMDObject.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcurrencysettings
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCurrencySettings;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDCurrencyMode : unsigned char { cmSystem, cmUser };

class PASCALIMPLEMENTATION TLMDCurrencySettings : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	TLMDCurrencyMode FSystem;
	Lmdtypes::TLMDString FPosFormatStr;
	Lmdtypes::TLMDString FNegFormatStr;
	Lmdtypes::TLMDString FSymbol;
	System::Byte FGroup;
	System::Byte FDigits;
	System::WideChar FCurrencyGroup;
	System::WideChar FFractionDelim;
	Lmdtypes::TLMDString FNegFormatSignature;
	bool FNegFormatContainsMinus;
	void __fastcall SetSystemDefaults(TLMDCurrencyMode aValue);
	bool __fastcall IsStored(void);
	void __fastcall SetNegativeFormatStr(const Lmdtypes::TLMDString Value);
	void __fastcall SetPositiveFormatStr(const Lmdtypes::TLMDString Value);
	void __fastcall SetSymbol(const Lmdtypes::TLMDString Value);
	
protected:
	void __fastcall UpdateNegFormatSignature(void);
	
public:
	__fastcall virtual TLMDCurrencySettings(System::Classes::TPersistent* Owner);
	void __fastcall LoadDefaults(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	Lmdtypes::TLMDString __fastcall toStr(System::Currency cur)/* overload */;
	Lmdtypes::TLMDString __fastcall toStr(System::Currency cur, bool minus)/* overload */;
	System::Currency __fastcall toCur(Lmdtypes::TLMDString s);
	bool __fastcall IsNegative(Lmdtypes::TLMDString s);
	int __fastcall firstDigitPos(System::Currency cur);
	__property System::Byte Digits = {read=FDigits, write=FDigits, stored=IsStored, nodefault};
	__property System::WideChar GroupDelim = {read=FCurrencyGroup, write=FCurrencyGroup, stored=IsStored, nodefault};
	__property System::WideChar FractionDelim = {read=FFractionDelim, write=FFractionDelim, stored=IsStored, nodefault};
	
__published:
	__property TLMDCurrencyMode SystemDefaults = {read=FSystem, write=SetSystemDefaults, stored=IsStored, nodefault};
	__property Lmdtypes::TLMDString PositiveFormatStr = {read=FPosFormatStr, write=SetPositiveFormatStr, stored=IsStored};
	__property Lmdtypes::TLMDString NegativeFormatStr = {read=FNegFormatStr, write=SetNegativeFormatStr, stored=IsStored};
	__property Lmdtypes::TLMDString Symbol = {read=FSymbol, write=SetSymbol, stored=IsStored};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDCurrencySettings(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDCurrToStr(System::Currency cur, Lmdtypes::TLMDString CurrencySymbol, Lmdtypes::TLMDString PosFormatStr, Lmdtypes::TLMDString NegFormatStr, System::WideChar CurrencyDelim, System::WideChar GroupDelim, System::Byte Decimals, System::Byte GroupSize)/* overload */;
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDCurrToStr(System::Currency cur, Lmdtypes::TLMDString CurrencySymbol, Lmdtypes::TLMDString PosFormatStr, Lmdtypes::TLMDString NegFormatStr, System::WideChar CurrencyDelim, System::WideChar GroupDelim, System::Byte Decimals, System::Byte GroupSize, bool Minus)/* overload */;
}	/* namespace Lmdcurrencysettings */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCURRENCYSETTINGS)
using namespace Lmdcurrencysettings;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcurrencysettingsHPP
