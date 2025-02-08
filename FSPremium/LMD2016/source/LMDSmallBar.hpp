// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSmallBar.pas' rev: 31.00 (Windows)

#ifndef LmdsmallbarHPP
#define LmdsmallbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <LMDGraph.hpp>
#include <LMDObject.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsmallbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSmallBar;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSmallBar : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	bool FAutosize;
	System::Byte FBarCount;
	System::Uitypes::TColor FColor;
	System::Byte FHSpace;
	System::Byte FVSpace;
	void __fastcall SetAutosize(bool aValue);
	void __fastcall SetByte(int Index, System::Byte aValue);
	void __fastcall SetColor(System::Uitypes::TColor aValue);
	
public:
	__fastcall virtual TLMDSmallBar(System::Classes::TPersistent* Owner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	int __fastcall GetBarExtend(Lmdgraph::TLMDMeterDirection Direction, int w, int h);
	
__published:
	__property bool AutoSize = {read=FAutosize, write=SetAutosize, default=1};
	__property System::Uitypes::TColor BarColor = {read=FColor, write=SetColor, default=8388608};
	__property System::Byte BarCount = {read=FBarCount, write=SetByte, index=0, default=10};
	__property System::Byte HSpace = {read=FHSpace, write=SetByte, index=1, default=3};
	__property System::Byte VSpace = {read=FVSpace, write=SetByte, index=2, default=3};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDSmallBar(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsmallbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSMALLBAR)
using namespace Lmdsmallbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsmallbarHPP
