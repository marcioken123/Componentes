// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTransparent.pas' rev: 31.00 (Windows)

#ifndef LmdtransparentHPP
#define LmdtransparentHPP

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

namespace Lmdtransparent
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTransparent;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTransparent : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	System::Uitypes::TColor FColor;
	Lmdgraph::TLMDTransparentMode FStyle;
	void __fastcall SetColor(System::Uitypes::TColor AValue);
	void __fastcall SetStyle(Lmdgraph::TLMDTransparentMode AValue);
	bool __fastcall GetTransparent(void);
	
public:
	__fastcall virtual TLMDTransparent(System::Classes::TPersistent* Owner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property bool Transparent = {read=GetTransparent, nodefault};
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=-16777201};
	__property Lmdgraph::TLMDTransparentMode Mode = {read=FStyle, write=SetStyle, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDTransparent(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtransparent */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTRANSPARENT)
using namespace Lmdtransparent;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtransparentHPP
