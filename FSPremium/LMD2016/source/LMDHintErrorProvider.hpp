// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHintErrorProvider.pas' rev: 31.00 (Windows)

#ifndef LmdhinterrorproviderHPP
#define LmdhinterrorproviderHPP

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
#include <LMDMessageHint.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdhinterrorprovider
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHintErrorProvider;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDHintErrorProvider : public Lmdvldbase::TLMDCustomErrorProvider
{
	typedef Lmdvldbase::TLMDCustomErrorProvider inherited;
	
protected:
	Lmdmessagehint::TLMDMessageHint* FMessageHint;
	virtual void __fastcall DoDisplayError(Lmdvldbase::_di_ILMDValidatedControl control, System::UnicodeString ErrorMsg, int ErrorLevel);
	void __fastcall SetMessageHint(Lmdmessagehint::TLMDMessageHint* aValue);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall virtual TLMDHintErrorProvider(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDHintErrorProvider(void);
	
__published:
	__property Lmdmessagehint::TLMDMessageHint* MessageHint = {read=FMessageHint, write=SetMessageHint};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdhinterrorprovider */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHINTERRORPROVIDER)
using namespace Lmdhinterrorprovider;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdhinterrorproviderHPP
