// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDGlyph.pas' rev: 31.00 (Windows)

#ifndef LmdglyphHPP
#define LmdglyphHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <LMDGraph.hpp>
#include <LMDButtonBase.hpp>
#include <LMD3DCaption.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <LMDImageList.hpp>
#include <LMDCustomComponent.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdglyph
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDXGlyphList;
class DELPHICLASS TLMDXGlyphCache;
class DELPHICLASS TLMDGlyph;
//-- type declarations -------------------------------------------------------
typedef System::Int8 TLMDNumGlyphs;

class PASCALIMPLEMENTATION TLMDXGlyphList : public Lmdimagelist::TLMDImageListItem
{
	typedef Lmdimagelist::TLMDImageListItem inherited;
	
private:
	int FCount;
	System::Classes::TBits* FUsedBA;
	int __fastcall AllocateIndex(void);
	
public:
	__fastcall TLMDXGlyphList(int aWidth, int aHeight);
	__fastcall virtual ~TLMDXGlyphList(void);
	HIDESBASE int __fastcall Add(Vcl::Graphics::TBitmap* Image, Vcl::Graphics::TBitmap* Mask);
	HIDESBASE int __fastcall AddMasked(Vcl::Graphics::TBitmap* Image, System::Uitypes::TColor MaskColor);
	HIDESBASE void __fastcall Delete(int Index);
	__property int Count = {read=FCount, nodefault};
public:
	/* TLMDImageListItem.Create */ inline __fastcall virtual TLMDXGlyphList(System::Classes::TComponent* aOwner) : Lmdimagelist::TLMDImageListItem(aOwner) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDXGlyphCache : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TList* FList;
	
public:
	__fastcall TLMDXGlyphCache(void);
	__fastcall virtual ~TLMDXGlyphCache(void);
	TLMDXGlyphList* __fastcall GetList(int aWidth, int aHeight);
	void __fastcall FreeList(TLMDXGlyphList* aList);
	bool __fastcall Empty(void);
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDGlyphStyle : unsigned char { gsStandard, gsExplorer };

class PASCALIMPLEMENTATION TLMDGlyph : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Vcl::Graphics::TBitmap* FBitmap;
	System::StaticArray<int, 9> FIndexs;
	TLMDXGlyphList* FGlyphList;
	TLMDNumGlyphs FNumGlyphs;
	System::Classes::TNotifyEvent FOnChange;
	TLMDGlyphStyle FStyle;
	System::Types::TRect FDrawnRect;
	System::Types::TRect FGlyphRect;
	System::Types::TRect FTextRect;
	System::Uitypes::TColor FTransparentColor;
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* aValue);
	void __fastcall SetNumGlyphs(TLMDNumGlyphs aValue);
	void __fastcall SetStyle(TLMDGlyphStyle aValue);
	void __fastcall GetGlyphChange(System::TObject* Sender);
	void __fastcall Init(void);
	
public:
	__fastcall TLMDGlyph(void);
	__fastcall virtual ~TLMDGlyph(void);
	void __fastcall DrawButtonGlyphAndText(Vcl::Graphics::TCanvas* aCanvas, const System::UnicodeString aString, Lmd3dcaption::TLMD3DCaption* Effects, const System::Types::TRect &aDest, Lmdbuttonbase::TLMDButtonState State, Lmdglyphtextlayout::TLMDGlyphTextLayout* aLayout, Lmdgraph::TLMDDrawTextStyles ExtFlags, bool MultiLine, int flags);
	int __fastcall GetButtonGlyph(Lmdbuttonbase::TLMDButtonState State);
	void __fastcall GetStateBitmap(Lmdbuttonbase::TLMDButtonState State, Vcl::Graphics::TBitmap* bmp);
	__property Vcl::Graphics::TBitmap* Glyph = {read=FBitmap, write=SetGlyph};
	__property TLMDNumGlyphs NumGlyphs = {read=FNumGlyphs, write=SetNumGlyphs, nodefault};
	__property TLMDGlyphStyle Style = {read=FStyle, write=SetStyle, nodefault};
	__property System::Types::TRect DrawnRect = {read=FDrawnRect};
	__property System::Types::TRect GlyphRect = {read=FGlyphRect};
	__property System::Types::TRect TextRect = {read=FTextRect};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDXGlyphCache* LMDGlyphCache;
}	/* namespace Lmdglyph */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDGLYPH)
using namespace Lmdglyph;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdglyphHPP
