// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShadow.pas' rev: 31.00 (Windows)

#ifndef LmdshadowHPP
#define LmdshadowHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDGraph.hpp>
#include <LMDObject.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshadow
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShadow;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDShadow : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	System::Uitypes::TColor FColor;
	Lmdgraph::TLMDShadowDepth FDepth;
	void __fastcall SetColor(System::Uitypes::TColor AValue);
	void __fastcall SetDepth(Lmdgraph::TLMDShadowDepth AValue);
	void __fastcall SetStyle(Lmdgraph::TLMDShadowStyle AValue);
	
protected:
	Lmdgraph::TLMDShadowStyle FStyle;
	
public:
	__fastcall virtual TLMDShadow(System::Classes::TPersistent* Owner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC System::UnicodeString __fastcall GetSetStr(void);
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=-16777200};
	__property Lmdgraph::TLMDShadowDepth Depth = {read=FDepth, write=SetDepth, default=6};
	__property Lmdgraph::TLMDShadowStyle Style = {read=FStyle, write=SetStyle, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDShadow(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshadow */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHADOW)
using namespace Lmdshadow;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshadowHPP
