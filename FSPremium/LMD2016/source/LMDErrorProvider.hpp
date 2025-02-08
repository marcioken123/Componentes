// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDErrorProvider.pas' rev: 31.00 (Windows)

#ifndef LmderrorproviderHPP
#define LmderrorproviderHPP

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
#include <LMDInPlaceErrorProvider.hpp>
#include <LMDIconErrorProvider.hpp>
#include <LMDMessageBoxErrorProvider.hpp>
#include <LMDControlErrorProvider.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmderrorprovider
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDErrorProvider;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDErrorProvider : public Lmdvldbase::TLMDCustomErrorProvider
{
	typedef Lmdvldbase::TLMDCustomErrorProvider inherited;
	
protected:
	Lmdinplaceerrorprovider::TLMDInPlaceErrorProvider* FLMDInPlaceErrorProvider;
	Lmdiconerrorprovider::TLMDIconErrorProvider* FLMDIconErrorProvider;
	Lmdmessageboxerrorprovider::TLMDMessageBoxErrorProvider* FLMDMessageBoxErrorProvider;
	Lmdcontrolerrorprovider::TLMDControlErrorProvider* FLMDControlErrorProvider;
	bool FUseMessageBox;
	bool FUseInPlaceIndication;
	bool FUseIcon;
	bool FUseErrMsgControl;
	virtual void __fastcall DoDisplayError(Lmdvldbase::_di_ILMDValidatedControl control, System::UnicodeString ErrorMsg, int ErrorLevel);
	
public:
	__fastcall virtual TLMDErrorProvider(System::Classes::TComponent* AOwner);
	
__published:
	__property Lmdinplaceerrorprovider::TLMDInPlaceErrorProvider* InPlaceErrorProvider = {read=FLMDInPlaceErrorProvider};
	__property Lmdiconerrorprovider::TLMDIconErrorProvider* IconErrorProvider = {read=FLMDIconErrorProvider};
	__property Lmdmessageboxerrorprovider::TLMDMessageBoxErrorProvider* MessageBoxErrorProvider = {read=FLMDMessageBoxErrorProvider};
	__property Lmdcontrolerrorprovider::TLMDControlErrorProvider* ControlErrorProvider = {read=FLMDControlErrorProvider};
	__property bool UseMessageBox = {read=FUseMessageBox, write=FUseMessageBox, nodefault};
	__property bool UseErrMsgControl = {read=FUseErrMsgControl, write=FUseErrMsgControl, nodefault};
	__property bool UseIcon = {read=FUseIcon, write=FUseIcon, nodefault};
	__property bool UseInPlaceIndication = {read=FUseInPlaceIndication, write=FUseInPlaceIndication, nodefault};
public:
	/* TLMDCustomErrorProvider.Destroy */ inline __fastcall virtual ~TLMDErrorProvider(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmderrorprovider */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDERRORPROVIDER)
using namespace Lmderrorprovider;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmderrorproviderHPP
