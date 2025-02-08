// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSimpleBevel.pas' rev: 31.00 (Windows)

#ifndef LmdsimplebevelHPP
#define LmdsimplebevelHPP

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

namespace Lmdsimplebevel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSimpleBevel;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSimpleBevelStyle : unsigned char { sbNormal, sbInset, sbOffset };

class PASCALIMPLEMENTATION TLMDSimpleBevel : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	Lmdgraph::TLMDBevelWidth FWidth;
	TLMDSimpleBevelStyle FStyle;
	System::Uitypes::TColor FColor;
	System::Uitypes::TColor FLightColor;
	System::Uitypes::TColor FShadowColor;
	void __fastcall SetWidth(Lmdgraph::TLMDBevelWidth aValue);
	void __fastcall SetStyle(TLMDSimpleBevelStyle aValue);
	void __fastcall SetColor(int Index, System::Uitypes::TColor aValue);
	
public:
	__fastcall virtual TLMDSimpleBevel(System::Classes::TPersistent* Owner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC System::UnicodeString __fastcall GetSetStr(void);
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, index=2, default=0};
	__property Lmdgraph::TLMDBevelWidth Width = {read=FWidth, write=SetWidth, default=2};
	__property TLMDSimpleBevelStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property System::Uitypes::TColor LightColor = {read=FLightColor, write=SetColor, index=0, default=-16777196};
	__property System::Uitypes::TColor ShadowColor = {read=FShadowColor, write=SetColor, index=1, default=-16777200};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDSimpleBevel(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsimplebevel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSIMPLEBEVEL)
using namespace Lmdsimplebevel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsimplebevelHPP
