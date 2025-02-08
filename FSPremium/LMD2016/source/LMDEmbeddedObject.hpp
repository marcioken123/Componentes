// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDEmbeddedObject.pas' rev: 31.00 (Windows)

#ifndef LmdembeddedobjectHPP
#define LmdembeddedobjectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <LMDObject.hpp>
#include <LMDBevel.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdembeddedobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDEmbeddedObject;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDEmbeddedObject : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	Lmdbevel::TLMDBevel* FBevel;
	System::Uitypes::TColor FColor;
	bool FTransparent;
	Vcl::Graphics::TFont* FFont;
	void __fastcall SetBevel(Lmdbevel::TLMDBevel* aValue);
	void __fastcall SetColor(System::Uitypes::TColor aValue);
	void __fastcall SetBoolean(bool aValue);
	void __fastcall SetFont(Vcl::Graphics::TFont* aValue);
	
public:
	__fastcall virtual TLMDEmbeddedObject(System::Classes::TPersistent* Owner);
	__fastcall virtual ~TLMDEmbeddedObject(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Lmdbevel::TLMDBevel* Bevel = {read=FBevel, write=SetBevel};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property bool Transparent = {read=FTransparent, write=SetBoolean, nodefault};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdembeddedobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDEMBEDDEDOBJECT)
using namespace Lmdembeddedobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdembeddedobjectHPP
