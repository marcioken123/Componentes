// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRegExpValidator.pas' rev: 31.00 (Windows)

#ifndef LmdregexpvalidatorHPP
#define LmdregexpvalidatorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDVldBase.hpp>
#include <LMDRegExpr.hpp>
#include <LMDTypes.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdregexpvalidator
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomRegExpValidator;
class DELPHICLASS TLMDRegExpValidator;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomRegExpValidator : public Lmdvldbase::TLMDCustomValidator
{
	typedef Lmdvldbase::TLMDCustomValidator inherited;
	
private:
	Lmdregexpr::TLMDRegOptions* __fastcall GetOptions(void);
	
protected:
	Lmdregexpr::TLMDRegExpr* FRegEx;
	virtual int __fastcall PerformValidation(System::UnicodeString value);
	Lmdtypes::TLMDRegExString __fastcall GetRegExp(void);
	void __fastcall SetRegExp(const Lmdtypes::TLMDRegExString Value);
	bool __fastcall GetIgnoreCase(void);
	void __fastcall SetIgnoreCase(const bool Value);
	__property Lmdtypes::TLMDRegExString Expression = {read=GetRegExp, write=SetRegExp};
	__property Lmdregexpr::TLMDRegOptions* Options = {read=GetOptions};
	__property bool IgnoreCase = {read=GetIgnoreCase, write=SetIgnoreCase, nodefault};
	
public:
	__fastcall virtual TLMDCustomRegExpValidator(System::Classes::TComponent* AComponent);
	__fastcall virtual ~TLMDCustomRegExpValidator(void);
};


class PASCALIMPLEMENTATION TLMDRegExpValidator : public TLMDCustomRegExpValidator
{
	typedef TLMDCustomRegExpValidator inherited;
	
__published:
	__property Expression = {default=0};
	__property Options;
	__property IgnoreCase;
public:
	/* TLMDCustomRegExpValidator.Create */ inline __fastcall virtual TLMDRegExpValidator(System::Classes::TComponent* AComponent) : TLMDCustomRegExpValidator(AComponent) { }
	/* TLMDCustomRegExpValidator.Destroy */ inline __fastcall virtual ~TLMDRegExpValidator(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdregexpvalidator */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDREGEXPVALIDATOR)
using namespace Lmdregexpvalidator;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdregexpvalidatorHPP
