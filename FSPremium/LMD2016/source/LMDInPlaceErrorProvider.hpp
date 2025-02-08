// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDInPlaceErrorProvider.pas' rev: 31.00 (Windows)

#ifndef LmdinplaceerrorproviderHPP
#define LmdinplaceerrorproviderHPP

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
#include <System.UITypes.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdinplaceerrorprovider
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDControlColors;
class DELPHICLASS TLMDInPlaceErrorProvider;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDControlColors : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::Uitypes::TColor FontColor;
	System::Uitypes::TColor BackColor;
	Vcl::Controls::TControl* Control;
	bool ColorsModified;
public:
	/* TObject.Create */ inline __fastcall TLMDControlColors(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDControlColors(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDInPlaceErrorProvider : public Lmdvldbase::TLMDCustomErrorProvider
{
	typedef Lmdvldbase::TLMDCustomErrorProvider inherited;
	
protected:
	System::Uitypes::TColor FControlFontColor;
	System::Uitypes::TColor FControlBackColor;
	System::Classes::TList* FControlColorList;
	System::Uitypes::TColor FIndicationFontColor;
	System::Uitypes::TColor FIndicationBackColor;
	virtual void __fastcall DoDisplayError(Lmdvldbase::_di_ILMDValidatedControl AControl, System::UnicodeString ErrorMsg, int ErrorLevel);
	
public:
	__fastcall virtual ~TLMDInPlaceErrorProvider(void);
	__fastcall virtual TLMDInPlaceErrorProvider(System::Classes::TComponent* AOwner);
	
__published:
	__property System::Uitypes::TColor IndicationFontColor = {read=FIndicationFontColor, write=FIndicationFontColor, default=255};
	__property System::Uitypes::TColor IndicationBackColor = {read=FIndicationBackColor, write=FIndicationBackColor, default=65535};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdinplaceerrorprovider */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDINPLACEERRORPROVIDER)
using namespace Lmdinplaceerrorprovider;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdinplaceerrorproviderHPP
