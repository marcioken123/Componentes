// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPointList.pas' rev: 31.00 (Windows)

#ifndef LmdpointlistHPP
#define LmdpointlistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdpointlist
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPointList;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDPointList : public System::Classes::TList
{
	typedef System::Classes::TList inherited;
	
private:
	System::Classes::TNotifyEvent FOnChange;
	int FUpdateCount;
	System::Types::TPoint __fastcall GetPoint(int Index);
	
protected:
	void __fastcall GetChange(System::TObject* Sender);
	
public:
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(bool change);
	void __fastcall PutPoint(int Index, const System::Types::TPoint &aValue);
	void __fastcall AddPoint(const System::Types::TPoint &aValue)/* overload */;
	void __fastcall AddPoint(int X, int Y)/* overload */;
	void __fastcall DeletePoint(int Index);
	void __fastcall Clone(TLMDPointList* aValue);
	__property System::Types::TPoint Points[int Index] = {read=GetPoint, write=PutPoint};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TLMDPointList(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TLMDPointList(void) : System::Classes::TList() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdpointlist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPOINTLIST)
using namespace Lmdpointlist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdpointlistHPP
