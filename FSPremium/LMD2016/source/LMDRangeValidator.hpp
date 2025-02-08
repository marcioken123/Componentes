// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRangeValidator.pas' rev: 31.00 (Windows)

#ifndef LmdrangevalidatorHPP
#define LmdrangevalidatorHPP

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

namespace Lmdrangevalidator
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRangeValidator;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRangeValidator : public Lmdvldbase::TLMDCustomValidator
{
	typedef Lmdvldbase::TLMDCustomValidator inherited;
	
private:
	Lmdvldbase::TLMDValueType FValueType;
	System::UnicodeString FLowLimit;
	System::UnicodeString FHighLimit;
	
protected:
	virtual int __fastcall PerformValidation(System::UnicodeString value);
	void __fastcall HandleConvertError(void);
	
public:
	virtual System::UnicodeString __fastcall GetMessage(Lmdvldbase::_di_ILMDValidatedControl Sender, int errorLevel);
	
__published:
	__property Lmdvldbase::TLMDValueType ValueType = {read=FValueType, write=FValueType, nodefault};
	__property System::UnicodeString HighLimit = {read=FHighLimit, write=FHighLimit};
	__property System::UnicodeString LowLimit = {read=FLowLimit, write=FLowLimit};
public:
	/* TLMDCustomValidator.Create */ inline __fastcall virtual TLMDRangeValidator(System::Classes::TComponent* AOwner) : Lmdvldbase::TLMDCustomValidator(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDRangeValidator(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrangevalidator */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRANGEVALIDATOR)
using namespace Lmdrangevalidator;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrangevalidatorHPP
