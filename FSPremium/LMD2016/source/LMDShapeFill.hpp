// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShapeFill.pas' rev: 31.00 (Windows)

#ifndef LmdshapefillHPP
#define LmdshapefillHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <LMDGradient.hpp>
#include <LMDGraph.hpp>
#include <LMDObject.hpp>
#include <LMDPNGImage.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshapefill
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShapeFill;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDShapeFill : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	Vcl::Graphics::TBitmap* FBitmap;
	Lmdpngimage::TLMDPNGObject* FPng;
	Lmdgradient::TLMDGradient* FGradient;
	Lmdgraph::TLMDFillStyle FFillStyle;
	Lmdgraph::TLMDTileMode FTileMode;
	void __fastcall SetBitmap(Vcl::Graphics::TBitmap* aValue);
	void __fastcall SetListBitmap(Vcl::Graphics::TBitmap* aValue);
	void __fastcall SetGradient(Lmdgradient::TLMDGradient* aValue);
	void __fastcall SetFillStyle(Lmdgraph::TLMDFillStyle aValue);
	void __fastcall SetTileMode(Lmdgraph::TLMDTileMode aValue);
	Vcl::Graphics::TBitmap* __fastcall GetBitmap(void);
	bool __fastcall GetEmpty(void);
	bool __fastcall GetMustRedraw(void);
	HPALETTE __fastcall GetPalette(void);
	void __fastcall SetPng(Lmdpngimage::TLMDPNGObject* const Value);
	
protected:
	Vcl::Graphics::TBitmap* FListBitmap;
	
public:
	__fastcall virtual TLMDShapeFill(System::Classes::TPersistent* Owner);
	__fastcall virtual ~TLMDShapeFill(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC System::UnicodeString __fastcall GetSetStr(void);
	__property bool Empty = {read=GetEmpty, nodefault};
	__property HPALETTE Palette = {read=GetPalette, nodefault};
	__property bool SizeDependent = {read=GetMustRedraw, nodefault};
	__property Vcl::Graphics::TBitmap* ListBitmap = {read=FListBitmap, write=SetListBitmap};
	__property Vcl::Graphics::TBitmap* CurrentBitmap = {read=GetBitmap};
	
__published:
	__property Vcl::Graphics::TBitmap* Bitmap = {read=FBitmap, write=SetBitmap};
	__property Lmdpngimage::TLMDPNGObject* Png = {read=FPng, write=SetPng};
	__property Lmdgraph::TLMDFillStyle Style = {read=FFillStyle, write=SetFillStyle, default=2};
	__property Lmdgradient::TLMDGradient* Gradient = {read=FGradient, write=SetGradient};
	__property Lmdgraph::TLMDTileMode TileMode = {read=FTileMode, write=SetTileMode, default=3};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshapefill */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHAPEFILL)
using namespace Lmdshapefill;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshapefillHPP
