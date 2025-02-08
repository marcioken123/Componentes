// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDObject.pas' rev: 34.00 (Windows)

#ifndef LmdobjectHPP
#define LmdobjectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDObject;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDObject : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::Classes::TPersistent* FOwner;
	System::Classes::TNotifyEvent FOnChange;
	System::Byte FUpdate;
	
protected:
	DYNAMIC void __fastcall GetChange(System::TObject* Sender);
	DYNAMIC void __fastcall Change();
	__fastcall virtual TLMDObject(System::Classes::TPersistent* Owner);
	
public:
	DYNAMIC System::UnicodeString __fastcall GetSetStr();
	void __fastcall BeginUpdate();
	void __fastcall EndUpdate(bool aValue = false);
	bool __fastcall IsUpdating();
	__property System::Classes::TPersistent* Owner = {read=FOwner};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDObject() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDOBJECT)
using namespace Lmdobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdobjectHPP
