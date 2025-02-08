// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDVariants.pas' rev: 31.00 (Windows)

#ifndef LmdvariantsHPP
#define LmdvariantsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdvariants
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDVariant;
class DELPHICLASS TLMDVariantList;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDVariant : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Variant FVariant;
	
public:
	__fastcall TLMDVariant(const System::Variant &AVariant);
	__property System::Variant VarData = {read=FVariant, write=FVariant};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDVariant(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVariantList : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TList* FList;
	System::Variant __fastcall GetItem(int Index);
	void __fastcall SetItem(int Index, const System::Variant &AVariant);
	int __fastcall GetCount(void);
	
public:
	__fastcall TLMDVariantList(void);
	__fastcall virtual ~TLMDVariantList(void);
	void __fastcall Add(const System::Variant &AVariant);
	void __fastcall Delete(int Index);
	__property System::Variant Variants[int Index] = {read=GetItem, write=SetItem};
	__property int Count = {read=GetCount, nodefault};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdvariants */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDVARIANTS)
using namespace Lmdvariants;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdvariantsHPP
