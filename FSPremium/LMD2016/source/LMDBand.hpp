// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBand.pas' rev: 31.00 (Windows)

#ifndef LmdbandHPP
#define LmdbandHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDLex.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdband
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTokenBand;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTokenBand : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	Lmdlex::TLMDToken* operator[](int Index) { return this->Item[Index]; }
	
private:
	System::Classes::TList* FList;
	int FCursor;
	Lmdlex::TLMDToken* __fastcall GetCurrent(void);
	Lmdlex::TLMDToken* __fastcall GetItem(int Index);
	
public:
	__fastcall TLMDTokenBand(void);
	__fastcall virtual ~TLMDTokenBand(void);
	bool __fastcall Eof(void);
	bool __fastcall Bof(void);
	void __fastcall Clear(void);
	void __fastcall Add(Lmdlex::TLMDToken* aToken);
	void __fastcall Insert(Lmdlex::TLMDToken* aToken);
	void __fastcall Remove(void);
	void __fastcall Next(void);
	void __fastcall Prev(void);
	void __fastcall First(void);
	void __fastcall Last(void);
	__property Lmdlex::TLMDToken* Current = {read=GetCurrent};
	__property int Pos = {read=FCursor, write=FCursor, nodefault};
	__property Lmdlex::TLMDToken* Item[int Index] = {read=GetItem/*, default*/};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdband */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBAND)
using namespace Lmdband;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbandHPP
