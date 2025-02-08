// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCompareValidator.pas' rev: 31.00 (Windows)

#ifndef LmdcomparevalidatorHPP
#define LmdcomparevalidatorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <LMDVldBase.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcomparevalidator
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCompareValidator;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCompareValidator : public Lmdvldbase::TLMDCustomValidator
{
	typedef Lmdvldbase::TLMDCustomValidator inherited;
	
protected:
	Lmdvldbase::_di_ILMDValidatedControl FRefControl;
	Lmdvldbase::TLMDRefSign FRefSign;
	Lmdvldbase::TLMDValueType FValueType;
	bool FLoopFlag;
	bool FValidateRefControl;
	void __fastcall SetRefControl(const Lmdvldbase::_di_ILMDValidatedControl Value);
	bool __fastcall CompliesWithConstraint(System::UnicodeString val, System::UnicodeString refVal, Lmdvldbase::TLMDRefSign sign);
	virtual int __fastcall PerformValidation(System::UnicodeString value);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
__published:
	__property Lmdvldbase::TLMDRefSign RefSign = {read=FRefSign, write=FRefSign, nodefault};
	__property Lmdvldbase::TLMDValueType ValueType = {read=FValueType, write=FValueType, nodefault};
	__property Lmdvldbase::_di_ILMDValidatedControl RefControl = {read=FRefControl, write=SetRefControl};
	__property bool ValidateRefControl = {read=FValidateRefControl, write=FValidateRefControl, default=0};
public:
	/* TLMDCustomValidator.Create */ inline __fastcall virtual TLMDCompareValidator(System::Classes::TComponent* AOwner) : Lmdvldbase::TLMDCustomValidator(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDCompareValidator(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcomparevalidator */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCOMPAREVALIDATOR)
using namespace Lmdcomparevalidator;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcomparevalidatorHPP
