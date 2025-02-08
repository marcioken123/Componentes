// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFloatRangeValidator.pas' rev: 31.00 (Windows)

#ifndef LmdfloatrangevalidatorHPP
#define LmdfloatrangevalidatorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDVldBase.hpp>
#include <LMDCustomComponent.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfloatrangevalidator
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFloatRangeValidator;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFloatRangeValidator : public Lmdvldbase::TLMDCustomRangeValidator
{
	typedef Lmdvldbase::TLMDCustomRangeValidator inherited;
	
private:
	double FLowLimit;
	double FHighLimit;
	
protected:
	virtual int __fastcall PerformValidation(System::UnicodeString value);
	void __fastcall HandleConvertError(void);
	
public:
	virtual System::UnicodeString __fastcall GetMessage(Lmdvldbase::_di_ILMDValidatedControl Sender, int errorLevel);
	
__published:
	__property double HighLimit = {read=FHighLimit, write=FHighLimit};
	__property double LowLimit = {read=FLowLimit, write=FLowLimit};
public:
	/* TLMDCustomValidator.Create */ inline __fastcall virtual TLMDFloatRangeValidator(System::Classes::TComponent* AOwner) : Lmdvldbase::TLMDCustomRangeValidator(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDFloatRangeValidator(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdfloatrangevalidator */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFLOATRANGEVALIDATOR)
using namespace Lmdfloatrangevalidator;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfloatrangevalidatorHPP
