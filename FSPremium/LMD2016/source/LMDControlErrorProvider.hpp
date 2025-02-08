// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDControlErrorProvider.pas' rev: 31.00 (Windows)

#ifndef LmdcontrolerrorproviderHPP
#define LmdcontrolerrorproviderHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDVldBase.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcontrolerrorprovider
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDControlErrorProvider;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDControlErrorProvider : public Lmdvldbase::TLMDCustomErrorProvider
{
	typedef Lmdvldbase::TLMDCustomErrorProvider inherited;
	
protected:
	Lmdvldbase::_di_ILMDValidatingMsgControl FErrMsgControl;
	void __fastcall SetErrMsgControl(const Lmdvldbase::_di_ILMDValidatingMsgControl Value);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall DoDisplayError(Lmdvldbase::_di_ILMDValidatedControl control, System::UnicodeString ErrorMsg, int ErrorLevel);
	
__published:
	__property Lmdvldbase::_di_ILMDValidatingMsgControl ErrMsgControl = {read=FErrMsgControl, write=SetErrMsgControl};
public:
	/* TLMDCustomErrorProvider.Create */ inline __fastcall virtual TLMDControlErrorProvider(System::Classes::TComponent* AOwner) : Lmdvldbase::TLMDCustomErrorProvider(AOwner) { }
	/* TLMDCustomErrorProvider.Destroy */ inline __fastcall virtual ~TLMDControlErrorProvider(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcontrolerrorprovider */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCONTROLERRORPROVIDER)
using namespace Lmdcontrolerrorprovider;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcontrolerrorproviderHPP
