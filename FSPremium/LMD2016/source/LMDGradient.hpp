// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDGradient.pas' rev: 31.00 (Windows)

#ifndef LmdgradientHPP
#define LmdgradientHPP

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
#include <LMDObject.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdgradient
{
//-- forward type declarations -----------------------------------------------
struct TLMDGradientColorEntry;
class DELPHICLASS TLMDGradient;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TLMDGradientColorEntry
{
public:
	System::Uitypes::TColor Color;
	int ColorCount;
	void *Further;
};


enum DECLSPEC_DENUM TLMDGradientMode : unsigned char { gmTwoColors, gmColorArray };

class PASCALIMPLEMENTATION TLMDGradient : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	Lmdgraph::TLMDColorCount FColorCount;
	System::Uitypes::TColor FColor;
	System::Classes::TList* FColorList;
	System::Uitypes::TColor FEndColor;
	bool FPaletteRealize;
	HPALETTE FPalette;
	Lmdgraph::TLMDGradientStyle FStyle;
	System::Classes::TList* FColors;
	bool FTwoColors;
	void __fastcall SetColor(System::Uitypes::TColor aValue);
	void __fastcall SetStyle(Lmdgraph::TLMDGradientStyle aValue);
	void __fastcall SetEndColor(System::Uitypes::TColor aValue);
	void __fastcall SetColorCount(Lmdgraph::TLMDColorCount aValue);
	void __fastcall SetPaletteRealize(bool aValue);
	void __fastcall SetTwoColors(bool aValue);
	void __fastcall SetColors(System::Classes::TList* aValue);
	void __fastcall DestroyPalette(void);
	void __fastcall WriteColorArray(System::Classes::TWriter* Writer);
	void __fastcall ReadColorArray(System::Classes::TReader* Reader);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	HPALETTE __fastcall GetPalette(void);
	DYNAMIC void __fastcall Change(void);
	
public:
	__fastcall virtual TLMDGradient(System::Classes::TPersistent* Owner);
	__fastcall virtual ~TLMDGradient(void);
	void __fastcall InitPalette(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC System::UnicodeString __fastcall GetSetStr(void);
	void __fastcall PaintGradient(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect);
	void __fastcall SetRealPalette(Vcl::Graphics::TCanvas* aCanvas);
	__property HPALETTE Palette = {read=GetPalette, nodefault};
	__property System::Classes::TList* ColorList = {read=FColorList};
	__property System::Classes::TList* Colors = {read=FColors, write=SetColors};
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=16711680};
	__property Lmdgraph::TLMDColorCount ColorCount = {read=FColorCount, write=SetColorCount, default=16};
	__property Lmdgraph::TLMDGradientStyle Style = {read=FStyle, write=SetStyle, default=1};
	__property System::Uitypes::TColor EndColor = {read=FEndColor, write=SetEndColor, default=0};
	__property bool PaletteRealize = {read=FPaletteRealize, write=SetPaletteRealize, default=0};
	__property bool TwoColors = {read=FTwoColors, write=SetTwoColors, default=1};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdgradient */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDGRADIENT)
using namespace Lmdgradient;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdgradientHPP
