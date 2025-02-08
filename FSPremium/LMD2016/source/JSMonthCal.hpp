// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSMonthCal.pas' rev: 31.00 (Windows)

#ifndef JsmonthcalHPP
#define JsmonthcalHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jsmonthcal
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TJSMonthCalendar;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TJSMonthCalendar : public Vcl::Comctrls::TMonthCalendar
{
	typedef Vcl::Comctrls::TMonthCalendar inherited;
	
protected:
	DYNAMIC void __fastcall DblClick(void);
public:
	/* TMonthCalendar.Create */ inline __fastcall virtual TJSMonthCalendar(System::Classes::TComponent* AOwner) : Vcl::Comctrls::TMonthCalendar(AOwner) { }
	
public:
	/* TCommonCalendar.Destroy */ inline __fastcall virtual ~TJSMonthCalendar(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TJSMonthCalendar(HWND ParentWindow) : Vcl::Comctrls::TMonthCalendar(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Jsmonthcal */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSMONTHCAL)
using namespace Jsmonthcal;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JsmonthcalHPP
