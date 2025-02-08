// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTeeth.pas' rev: 31.00 (Windows)

#ifndef LmdteethHPP
#define LmdteethHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDGraph.hpp>
#include <LMDObject.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdteeth
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTeeth;
//-- type declarations -------------------------------------------------------
typedef System::Int8 TLMDTeethCount;

class PASCALIMPLEMENTATION TLMDTeeth : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	TLMDTeethCount FCount;
	Lmdgraph::TLMDDirection FDirection;
	bool FOffset;
	bool FSetPerCount;
	int FWidth;
	int FHeight;
	void __fastcall SetBoolean(int Index, bool aValue);
	void __fastcall SetCount(TLMDTeethCount aValue);
	void __fastcall SetDirection(Lmdgraph::TLMDDirection aValue);
	void __fastcall SetInteger(int Index, int aValue);
	
public:
	__fastcall virtual TLMDTeeth(System::Classes::TPersistent* Owner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property TLMDTeethCount Count = {read=FCount, write=SetCount, default=10};
	__property Lmdgraph::TLMDDirection Direction = {read=FDirection, write=SetDirection, default=0};
	__property int Height = {read=FHeight, write=SetInteger, index=1, default=0};
	__property bool Offset = {read=FOffset, write=SetBoolean, index=0, default=1};
	__property bool SetPerCount = {read=FSetPerCount, write=SetBoolean, index=1, default=1};
	__property int Width = {read=FWidth, write=SetInteger, index=0, default=10};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDTeeth(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdteeth */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEETH)
using namespace Lmdteeth;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdteethHPP
