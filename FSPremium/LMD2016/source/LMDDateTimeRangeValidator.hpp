// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDateTimeRangeValidator.pas' rev: 31.00 (Windows)

#ifndef LmddatetimerangevalidatorHPP
#define LmddatetimerangevalidatorHPP

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

namespace Lmddatetimerangevalidator
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDateTimeRangeValidator;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDateTimeRangeValidator : public Lmdvldbase::TLMDCustomRangeValidator
{
	typedef Lmdvldbase::TLMDCustomRangeValidator inherited;
	
private:
	System::TDateTime FLowLimit;
	System::TDateTime FHighLimit;
	
protected:
	virtual int __fastcall PerformValidation(System::UnicodeString value);
	void __fastcall HandleConvertError(void);
	
public:
	virtual System::UnicodeString __fastcall GetMessage(Lmdvldbase::_di_ILMDValidatedControl Sender, int errorLevel);
	
__published:
	__property System::TDateTime HighLimit = {read=FHighLimit, write=FHighLimit};
	__property System::TDateTime LowLimit = {read=FLowLimit, write=FLowLimit};
public:
	/* TLMDCustomValidator.Create */ inline __fastcall virtual TLMDDateTimeRangeValidator(System::Classes::TComponent* AOwner) : Lmdvldbase::TLMDCustomRangeValidator(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDDateTimeRangeValidator(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddatetimerangevalidator */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDATETIMERANGEVALIDATOR)
using namespace Lmddatetimerangevalidator;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddatetimerangevalidatorHPP
