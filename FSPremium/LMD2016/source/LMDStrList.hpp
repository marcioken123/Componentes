// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStrList.pas' rev: 31.00 (Windows)

#ifndef LmdstrlistHPP
#define LmdstrlistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstrlist
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStrList;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDStrList : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	System::Classes::TStringList* FStrList;
	System::Types::TDuplicates __fastcall GetDuplicates(void);
	System::Classes::TStrings* __fastcall GetList(void);
	bool __fastcall GetSorted(void);
	System::Classes::TNotifyEvent __fastcall GetOnChange(void);
	System::Classes::TNotifyEvent __fastcall GetOnChanging(void);
	void __fastcall SetList(System::Classes::TStrings* aValue);
	void __fastcall SetSorted(bool aValue);
	void __fastcall SetDuplicates(System::Types::TDuplicates aValue);
	void __fastcall SetOnChange(System::Classes::TNotifyEvent aValue);
	void __fastcall SetOnChanging(System::Classes::TNotifyEvent aValue);
	
public:
	__fastcall virtual TLMDStrList(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDStrList(void);
	
__published:
	__property About = {default=0};
	__property System::Classes::TStrings* Items = {read=GetList, write=SetList};
	__property bool Sorted = {read=GetSorted, write=SetSorted, nodefault};
	__property System::Types::TDuplicates Duplicates = {read=GetDuplicates, write=SetDuplicates, nodefault};
	__property System::Classes::TNotifyEvent OnChange = {read=GetOnChange, write=SetOnChange};
	__property System::Classes::TNotifyEvent OnChanging = {read=GetOnChanging, write=SetOnChanging};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdstrlist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTRLIST)
using namespace Lmdstrlist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstrlistHPP
