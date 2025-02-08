// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VclTracer.pas' rev: 6.00

#ifndef VclTracerHPP
#define VclTracerHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Forms.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <CoolCtrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcltracer
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TMessageTracer;
class PASCALIMPLEMENTATION TMessageTracer : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Controls::TWinControl* FControl;
	bool FAlwaysOnTop;
	bool FAutoLoad;
	Coolctrls::TCCAboutBox* FAboutBox;
	void __fastcall SetControl(Controls::TWinControl* Value);
	void __fastcall SetAlwaysOnTop(bool Value);
	bool __fastcall GetAlwaysOnTop(void);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TMessageTracer(Classes::TComponent* AOwner);
	__fastcall virtual ~TMessageTracer(void);
	virtual void __fastcall Execute(void);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property bool AlwaysOnTop = {read=GetAlwaysOnTop, write=SetAlwaysOnTop, default=0};
	__property bool AutoLoad = {read=FAutoLoad, write=FAutoLoad, default=0};
	__property Controls::TWinControl* Control = {read=FControl, write=SetControl};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Vcltracer */
using namespace Vcltracer;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// VclTracer
