// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwchangelink.pas' rev: 6.00

#ifndef wwchangelinkHPP
#define wwchangelinkHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwchangelink
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwChangeLink;
class PASCALIMPLEMENTATION TwwChangeLink : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	Classes::TNotifyEvent FOnChanging;
	Classes::TNotifyEvent FOnLoaded;
	System::TObject* FSender;
	
public:
	virtual void __fastcall Change(void);
	virtual void __fastcall Changing(void);
	virtual void __fastcall Loaded(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Classes::TNotifyEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property Classes::TNotifyEvent OnLoaded = {read=FOnLoaded, write=FOnLoaded};
	__property System::TObject* Sender = {read=FSender, write=FSender};
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TwwChangeLink(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TwwChangeLink(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwchangelink)

}	/* namespace Wwchangelink */
using namespace Wwchangelink;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwchangelink
