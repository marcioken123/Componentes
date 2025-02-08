// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysPropertyDesc.pas' rev: 31.00 (Windows)

#ifndef LmdsyspropertydescHPP
#define LmdsyspropertydescHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsyspropertydesc
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysPropertyDesc;
class DELPHICLASS TLMDSysPropertiesDesc;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSysPropertyDesc : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	int FPropertyId;
	System::UnicodeString FTitle;
	System::UnicodeString FDescription;
	bool FAvailable;
	System::UnicodeString FText;
	void __fastcall SetText(System::UnicodeString value);
	
public:
	__fastcall virtual TLMDSysPropertyDesc(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDSysPropertyDesc(void);
	__property int PropertyID = {read=FPropertyId, write=FPropertyId, nodefault};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property System::UnicodeString Description = {read=FDescription, write=FDescription};
	__property bool Available = {read=FAvailable, write=FAvailable, nodefault};
	__property System::UnicodeString Text = {read=FText, write=SetText};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSysPropertiesDesc : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDSysPropertyDesc* operator[](int index) { return this->Items[index]; }
	
private:
	HIDESBASE TLMDSysPropertyDesc* __fastcall GetItem(int index);
	
public:
	__fastcall TLMDSysPropertiesDesc(void);
	__fastcall virtual ~TLMDSysPropertiesDesc(void);
	HIDESBASE TLMDSysPropertyDesc* __fastcall Add(int aPropertyID, System::UnicodeString aTitle, System::UnicodeString aDescription);
	TLMDSysPropertyDesc* __fastcall PropertyByID(int aID);
	void __fastcall InvalidateProperties(void);
	__property TLMDSysPropertyDesc* Items[int index] = {read=GetItem/*, default*/};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsyspropertydesc */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSPROPERTYDESC)
using namespace Lmdsyspropertydesc;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsyspropertydescHPP
