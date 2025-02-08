// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBookmarkList.pas' rev: 31.00 (Windows)

#ifndef LmdbookmarklistHPP
#define LmdbookmarklistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Data.DB.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbookmarklist
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBookmarkList;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBookmarkList : public System::Classes::TList
{
	typedef System::Classes::TList inherited;
	
public:
	System::DynamicArray<System::Byte> operator[](int Index) { return this->Bookmarks[Index]; }
	
private:
	System::DynamicArray<System::Byte> __fastcall GetBookmark(int Index);
	
public:
	void __fastcall PutBookmark(int Index, System::DynamicArray<System::Byte> aValue);
	void __fastcall AddBookmark(System::DynamicArray<System::Byte> aValue);
	__property System::DynamicArray<System::Byte> Bookmarks[int Index] = {read=GetBookmark, write=PutBookmark/*, default*/};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TLMDBookmarkList(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TLMDBookmarkList(void) : System::Classes::TList() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Word CM_LMDBOOKMARKCHANGED = System::Word(0xb001);
}	/* namespace Lmdbookmarklist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBOOKMARKLIST)
using namespace Lmdbookmarklist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbookmarklistHPP
