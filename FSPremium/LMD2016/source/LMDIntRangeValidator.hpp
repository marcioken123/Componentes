// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDIntRangeValidator.pas' rev: 31.00 (Windows)

#ifndef LmdintrangevalidatorHPP
#define LmdintrangevalidatorHPP

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

namespace Lmdintrangevalidator
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDIntRangeValidator;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDIntRangeValidator : public Lmdvldbase::TLMDCustomRangeValidator
{
	typedef Lmdvldbase::TLMDCustomRangeValidator inherited;
	
private:
	int FLowLimit;
	int FHighLimit;
	
protected:
	virtual int __fastcall PerformValidation(System::UnicodeString value);
	void __fastcall HandleConvertError(void);
	
public:
	virtual System::UnicodeString __fastcall GetMessage(Lmdvldbase::_di_ILMDValidatedControl Sender, int errorLevel);
	
__published:
	__property int HighLimit = {read=FHighLimit, write=FHighLimit, nodefault};
	__property int LowLimit = {read=FLowLimit, write=FLowLimit, nodefault};
public:
	/* TLMDCustomValidator.Create */ inline __fastcall virtual TLMDIntRangeValidator(System::Classes::TComponent* AOwner) : Lmdvldbase::TLMDCustomRangeValidator(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDIntRangeValidator(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdintrangevalidator */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDINTRANGEVALIDATOR)
using namespace Lmdintrangevalidator;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdintrangevalidatorHPP
