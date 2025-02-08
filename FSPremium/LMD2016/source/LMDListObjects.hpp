// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDListObjects.pas' rev: 31.00 (Windows)

#ifndef LmdlistobjectsHPP
#define LmdlistobjectsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdlistobjects
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDListObjects;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDListObjects : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::TObject* operator[](int Ind) { return this->Items[Ind]; }
	
protected:
	System::Classes::TList* FItems;
	virtual void __fastcall SetItems(int Ind, System::TObject* Value);
	virtual System::TObject* __fastcall GetItems(int Ind);
	virtual void __fastcall Utilize(System::TObject* Obj);
	
public:
	__fastcall TLMDListObjects(void);
	__fastcall virtual ~TLMDListObjects(void);
	void __fastcall Clear(void);
	void __fastcall Remove(System::TObject* Obj);
	int __fastcall Count(void);
	int __fastcall Add(System::TObject* Obj);
	System::TObject* __fastcall RemoveLast(void);
	__property System::TObject* Items[int Ind] = {read=GetItems, write=SetItems/*, default*/};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdlistobjects */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLISTOBJECTS)
using namespace Lmdlistobjects;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlistobjectsHPP
