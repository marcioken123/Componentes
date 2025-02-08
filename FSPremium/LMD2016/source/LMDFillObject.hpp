// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFillObject.pas' rev: 31.00 (Windows)

#ifndef LmdfillobjectHPP
#define LmdfillobjectHPP

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
#include <LMDGraph.hpp>
#include <LMDShapeFill.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfillobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFillObject;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDFillOption : unsigned char { foFillInner, foQuickDraw, foGrUseBitmap };

typedef System::Set<TLMDFillOption, TLMDFillOption::foFillInner, TLMDFillOption::foGrUseBitmap> TLMDFillOptions;

class PASCALIMPLEMENTATION TLMDFillObject : public Lmdshapefill::TLMDShapeFill
{
	typedef Lmdshapefill::TLMDShapeFill inherited;
	
private:
	Lmdgraph::TLMDAlignment FAlignment;
	int FOffsetX;
	int FOffsetY;
	Vcl::Graphics::TBrush* FBrush;
	TLMDFillOptions FOptions;
	System::Byte FAlphaLevel;
	void __fastcall SetAlignment(Lmdgraph::TLMDAlignment aValue);
	void __fastcall SetBrush(Vcl::Graphics::TBrush* aValue);
	void __fastcall SetInteger(int Index, int aValue);
	void __fastcall SetOptions(TLMDFillOptions aValue);
	bool __fastcall GetTransparent(void);
	void __fastcall SetAlphaLevel(const System::Byte Value);
	
public:
	__fastcall virtual TLMDFillObject(System::Classes::TPersistent* AOwner);
	__fastcall virtual ~TLMDFillObject(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	bool __fastcall ClipFill(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, System::Uitypes::TColor orgC, int pos);
	bool __fastcall FillCanvas(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, System::Uitypes::TColor orgC);
	__property bool Transparent = {read=GetTransparent, nodefault};
	
__published:
	__property System::Byte AlphaLevel = {read=FAlphaLevel, write=SetAlphaLevel, default=255};
	__property Lmdgraph::TLMDAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Vcl::Graphics::TBrush* Brush = {read=FBrush, write=SetBrush};
	__property int OffsetX = {read=FOffsetX, write=SetInteger, index=0, default=0};
	__property int OffsetY = {read=FOffsetY, write=SetInteger, index=1, default=0};
	__property TLMDFillOptions Options = {read=FOptions, write=SetOptions, default=5};
	__property Style = {default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdfillobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFILLOBJECT)
using namespace Lmdfillobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfillobjectHPP
