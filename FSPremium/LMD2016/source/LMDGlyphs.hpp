// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDGlyphs.pas' rev: 31.00 (Windows)

#ifndef LmdglyphsHPP
#define LmdglyphsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Math.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Buttons.hpp>
#include <Winapi.CommCtrl.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.Themes.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDUnicode.hpp>
#include <LMDPNGImage.hpp>
#include <LMDGraph.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDObjectList.hpp>
#include <LMDTypes.hpp>
#include <LMDProcs.hpp>
#include <LMDPNGImageList.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDPNGImageFilters.hpp>
#include <System.ImageList.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdglyphs
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDGlyphList;
class DELPHICLASS TLMDGlyphCache;
class DELPHICLASS TLMDButtonGlyph;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDGlyphListMaskUsage : unsigned char { muUnmasked, muMasked, muGlyphList };

class PASCALIMPLEMENTATION TLMDGlyphList : public Vcl::Controls::TImageList
{
	typedef Vcl::Controls::TImageList inherited;
	
private:
	System::Classes::TBits* Used;
	int FCount;
	int __fastcall AllocateIndex(void);
	
public:
	__fastcall TLMDGlyphList(int AWidth, int AHeight);
	__fastcall virtual ~TLMDGlyphList(void);
	HIDESBASE int __fastcall AddMasked(Vcl::Graphics::TBitmap* Image, System::Uitypes::TColor MaskColor, TLMDGlyphListMaskUsage aMaskUsage = (TLMDGlyphListMaskUsage)(0x2));
	HIDESBASE void __fastcall Delete(int Index);
	__property int Count = {read=FCount, nodefault};
public:
	/* TCustomImageList.Create */ inline __fastcall virtual TLMDGlyphList(System::Classes::TComponent* AOwner) : Vcl::Controls::TImageList(AOwner) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGlyphCache : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Lmdobjectlist::TLMDObjectList* GlyphLists;
	
public:
	__fastcall TLMDGlyphCache(void);
	__fastcall virtual ~TLMDGlyphCache(void);
	TLMDGlyphList* __fastcall GetList(int AWidth, int AHeight);
	void __fastcall ReturnList(TLMDGlyphList* List);
	bool __fastcall Empty(void);
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDButtonGlyph : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	bool FResizable;
	Vcl::Imglist::TCustomImageList* FImageList;
	Vcl::Imglist::TCustomImageList* FAlphaImageList;
	int FImageIndex;
	bool FUseImageList;
	Vcl::Graphics::TIcon* FIcon;
	bool FUseIcon;
	Vcl::Graphics::TBitmap* FOriginal;
	TLMDGlyphList* FGlyphList;
	System::StaticArray<int, 5> FIndexs;
	System::Uitypes::TColor FTransparentColor;
	Vcl::Buttons::TNumGlyphs FNumGlyphs;
	System::Classes::TNotifyEvent FOnChange;
	bool FStretched;
	int FStrW;
	int FStrH;
	Lmdpngimage::TLMDPNGObject* FPngGlyph;
	bool FUsePng;
	void __fastcall SetUsePng(const bool Value);
	void __fastcall SetPngGlyph(Lmdpngimage::TLMDPNGObject* const Value);
	virtual void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* NewValue);
	virtual void __fastcall SetAlphaImageList(Vcl::Imglist::TCustomImageList* NewValue);
	void __fastcall SetImageIndex(int NewValue);
	void __fastcall GlyphChanged(System::TObject* Sender);
	void __fastcall PngChanged(System::TObject* Sender);
	void __fastcall IconChanged(System::TObject* Sender);
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* Value);
	void __fastcall SetNumGlyphs(Vcl::Buttons::TNumGlyphs Value);
	void __fastcall Repaint(void);
	virtual int __fastcall CreateButtonGlyph(Lmdgraph::TLMDExButtonState State, TLMDGlyphListMaskUsage aMaskUsage = (TLMDGlyphListMaskUsage)(0x2));
	void __fastcall DrawButtonGlyph(Vcl::Graphics::TCanvas* Canvas, const System::Types::TPoint &GlyphPos, Lmdgraph::TLMDExButtonState State, bool Transparent, System::Uitypes::TColor Color, bool AlphaBlended, TLMDGlyphListMaskUsage MaskUsage = (TLMDGlyphListMaskUsage)(0x2));
	void __fastcall DrawButtonText(Vcl::Graphics::TCanvas* Canvas, const Lmdtypes::TLMDString Caption, const System::Types::TRect &TextBounds, Lmdgraph::TLMDExButtonState State, bool Multiline, System::Classes::TAlignment Alignment, bool Active, bool Transparent, Lmdgraph::TLMDTextDrawType TextDrawType, Lmdclass::TLMDThemeMode ThemeMode, const Vcl::Themes::TThemedElementDetails &Details, bool ShowAccelChar, bool IsHTML, Lmdhtmlunit::TLMDHTMLRender* HTMLRender, bool ChangeDisabledText);
	void __fastcall CalcButtonLayout(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Client, const System::Types::TPoint &OffsetSize, const Lmdtypes::TLMDString Caption, Vcl::Buttons::TButtonLayout Layout, int Margin, int Spacing, System::Types::TPoint &GlyphPos, System::Types::TRect &TextBounds, bool ShowGlyph, bool ShowText, bool MultiLine, int ArrowWidth, Lmdclass::TLMDThemeMode ThemeMode, const Vcl::Themes::TThemedElementDetails &Details, bool ShowAccelChar, bool IsHTML, Lmdhtmlunit::TLMDHTMLRender* HTMLRender, System::Classes::TAlignment Alignments);
	System::Types::TRect __fastcall GetGlyphSize(void);
	void __fastcall SetUseIcon(bool NewValue);
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList};
	__property Vcl::Imglist::TCustomImageList* AlphaImageList = {read=FAlphaImageList, write=SetAlphaImageList};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property bool UseImageList = {read=FUseImageList, write=FUseImageList, nodefault};
	
public:
	__fastcall TLMDButtonGlyph(void);
	__fastcall virtual ~TLMDButtonGlyph(void);
	void __fastcall ResetNumGlyphs(void);
	System::Types::TRect __fastcall Draw(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Client, const System::Types::TPoint &Offset, const Lmdtypes::TLMDString Caption, Vcl::Buttons::TButtonLayout Layout, int Margin, int Spacing, Lmdgraph::TLMDExButtonState State, Lmdgraph::TLMDExButtonState GlyphState, System::Classes::TAlignment Alignment, bool Transparent, bool Multiline, bool Active, bool ShowGlyph, bool ShowText, int ArrowWidth, Lmdgraph::TLMDTextDrawType TextDrawType, System::Uitypes::TColor Color, Lmdclass::TLMDThemeMode ThemeMode, const Vcl::Themes::TThemedElementDetails &Details, bool ShowAccelChar, bool ImageIsAlphaBlended, bool IsHTML, Lmdhtmlunit::TLMDHTMLRender* HTMLRender, bool ChangeDisabledText, TLMDGlyphListMaskUsage MaskUsage = (TLMDGlyphListMaskUsage)(0x2));
	void __fastcall GetPaintGlyphSize(const System::Types::TRect &R, System::Types::TPoint &Size);
	int __fastcall CalcButtonWidth(Vcl::Graphics::TCanvas* Canvas, int &MaxHeight, const System::Types::TPoint &Offset, const Lmdtypes::TLMDString Caption, Vcl::Buttons::TButtonLayout Layout, int Margin, int Spacing, bool ShowGlyph, bool ShowText, bool MultiLine, int ArrowWidth, Lmdclass::TLMDThemeMode ThemeMode, const Vcl::Themes::TThemedElementDetails &Details, bool ShowAccelChar, bool IsHTML, Lmdhtmlunit::TLMDHTMLRender* HTMLRender);
	__property bool UseIcon = {read=FUseIcon, write=SetUseIcon, nodefault};
	__property Vcl::Graphics::TIcon* Icon = {read=FIcon};
	__property bool UsePng = {read=FUsePng, write=SetUsePng, nodefault};
	__property Lmdpngimage::TLMDPNGObject* PngGlyph = {read=FPngGlyph, write=SetPngGlyph};
	__property Vcl::Graphics::TBitmap* Glyph = {read=FOriginal, write=SetGlyph};
	__property Vcl::Buttons::TNumGlyphs NumGlyphs = {read=FNumGlyphs, write=SetNumGlyphs, default=1};
	__property System::Types::TRect GlyphSize = {read=GetGlyphSize};
	__property bool Resizable = {read=FResizable, write=FResizable, nodefault};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDGlyphCache* GlyphCache;
extern DELPHI_PACKAGE Vcl::Graphics::TBitmap* Pattern;
extern DELPHI_PACKAGE int ButtonCount;
}	/* namespace Lmdglyphs */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDGLYPHS)
using namespace Lmdglyphs;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdglyphsHPP
