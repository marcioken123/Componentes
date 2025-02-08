// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDocElementRenderer.pas' rev: 31.00 (Windows)

#ifndef LmddocelementrendererHPP
#define LmddocelementrendererHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Contnrs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDTypes.hpp>
#include <LMDStrings.hpp>
#include <LMDPrinter.hpp>
#include <LMDDocModel.hpp>
#include <LMDPrintablePage.hpp>
#include <LMDPrintConst.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddocelementrenderer
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomDocElementRenderer;
struct TLMDRtfChunk;
class DELPHICLASS TLMDCharTraits;
class DELPHICLASS TLMDCharWidthHash;
class DELPHICLASS TLMDBaseTextRenderer;
class DELPHICLASS TLMDTextBlockRenderer;
class DELPHICLASS TLMDTableRenderer;
class DELPHICLASS TLMDDocImageRenderer;
//-- type declarations -------------------------------------------------------
typedef System::DynamicArray<Lmdprintablepage::TLMDPageArea*> Lmddocelementrenderer__1;

typedef System::DynamicArray<System::DynamicArray<Lmdprintablepage::TLMDPageArea*> > TLMDPageAreasMatrix;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCustomDocElementRenderer : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TLMDPageAreasMatrix FPageAreas;
	Vcl::Graphics::TCanvas* FPageCanvas;
	int FStartPageIndex;
	int FPageWidth;
	int FPageHeight;
	Lmdtypes::TLMDMargins* FMargins;
	void __fastcall SetMargins(Lmdtypes::TLMDMargins* const Value);
	
protected:
	Lmddocmodel::TLMDDocElement* FDocElement;
	void __fastcall AssignFontToPrinterFont(Vcl::Graphics::TFont* ASourceFont, Vcl::Graphics::TFont* ATargetFont);
	
public:
	virtual void __fastcall FreePageAreas(void);
	__fastcall TLMDCustomDocElementRenderer(void);
	__fastcall virtual ~TLMDCustomDocElementRenderer(void);
	virtual void __fastcall LayOut(void) = 0 ;
	virtual void __fastcall DrawArea(const System::Types::TPoint &APoint, int AVertIndex, int AHorizIndex) = 0 ;
	__property TLMDPageAreasMatrix PageAreas = {read=FPageAreas};
	
__published:
	__property int StartPageIndex = {read=FStartPageIndex, write=FStartPageIndex, nodefault};
	__property int PageWidth = {read=FPageWidth, write=FPageWidth, nodefault};
	__property int PageHeight = {read=FPageHeight, write=FPageHeight, nodefault};
	__property Vcl::Graphics::TCanvas* PageCanvas = {read=FPageCanvas, write=FPageCanvas};
	__property Lmddocmodel::TLMDDocElement* DocElement = {read=FDocElement, write=FDocElement};
	__property Lmdtypes::TLMDMargins* ContentMargins = {read=FMargins, write=SetMargins};
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TLMDRtfChunk
{
public:
	int Start;
	int Count;
	int Height;
};


typedef System::DynamicArray<TLMDRtfChunk> TLMDRtfChunksArray;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCharTraits : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::WideChar Ch;
	int PixelWidth;
	TLMDCharTraits* Next;
public:
	/* TObject.Create */ inline __fastcall TLMDCharTraits(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDCharTraits(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCharWidthHash : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::StaticArray<TLMDCharTraits*, 128> FTraits;
	int __fastcall GetCharWidth(System::WideChar AChar);
	void __fastcall SetCharWidth(System::WideChar AChar, const int Value);
	
public:
	__property int CharWidth[System::WideChar AChar] = {read=GetCharWidth, write=SetCharWidth};
	__fastcall TLMDCharWidthHash(void);
	__fastcall virtual ~TLMDCharWidthHash(void);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBaseTextRenderer : public TLMDCustomDocElementRenderer
{
	typedef TLMDCustomDocElementRenderer inherited;
	
private:
	int FTabSize;
	
protected:
	Lmddocmodel::TLMDTextBlock* __fastcall GetBlock(void);
	Lmddocmodel::TLMDTextAlignment __fastcall GetAlign(void);
	int __fastcall PixelsToTwipsX(int APixels);
	int __fastcall PixelsToTwipsY(int APixels);
	int __fastcall TwipsToPixelsX(int ATwips);
	int __fastcall TwipsToPixelsY(int ATwips);
	System::Classes::TStrings* __fastcall FormatStringsToArea(const Lmdtypes::TLMDString AStr, Vcl::Graphics::TCanvas* ACanvas, int AWidth, int AHeight, double ASpacing, bool AEnforceExistingLineBreaks, bool ABreakAtAnyChar, /* out */ int &ALastPos);
	System::Contnrs::TObjectList* __fastcall GetListOfFormattedStringBlocks(Vcl::Graphics::TCanvas* ACanvas, int AWidth, int AHeight, int AFirstHeight, double ASpacing, bool AEnforceExistingLineBreaks, bool ABreakAtAnyChar);
	void __fastcall DrawFormattedStrings(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	TLMDRtfChunksArray __fastcall GetListOfFormattedRTFChunksPositions(Vcl::Graphics::TCanvas* ACanvas, int AWidth, int AHeight, int AFirstHeight);
	void __fastcall DrawRTF(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	
public:
	__fastcall TLMDBaseTextRenderer(void);
	void __fastcall DrawTextBlock(const System::Types::TPoint &APoint, Vcl::Graphics::TCanvas* ACanvas);
	int __fastcall GetTextBlockHeight(Vcl::Graphics::TCanvas* ACanvas, Lmddocmodel::TLMDTextBlock* ATextBlock);
	__property int TabSize = {read=FTabSize, write=FTabSize, nodefault};
public:
	/* TLMDCustomDocElementRenderer.Destroy */ inline __fastcall virtual ~TLMDBaseTextRenderer(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTextBlockRenderer : public TLMDBaseTextRenderer
{
	typedef TLMDBaseTextRenderer inherited;
	
public:
	virtual void __fastcall LayOut(void);
	virtual void __fastcall DrawArea(const System::Types::TPoint &APoint, int AVertIndex, int AHorizIndex);
public:
	/* TLMDBaseTextRenderer.Create */ inline __fastcall TLMDTextBlockRenderer(void) : TLMDBaseTextRenderer() { }
	
public:
	/* TLMDCustomDocElementRenderer.Destroy */ inline __fastcall virtual ~TLMDTextBlockRenderer(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTableRenderer : public TLMDBaseTextRenderer
{
	typedef TLMDBaseTextRenderer inherited;
	
	
private:
	typedef System::DynamicArray<Lmddocmodel::TLMDTextBlock*> _TLMDTableRenderer__1;
	
	typedef System::DynamicArray<System::DynamicArray<Lmddocmodel::TLMDTextBlock*> > _TLMDTableRenderer__2;
	
	typedef System::DynamicArray<System::DynamicArray<System::DynamicArray<Lmddocmodel::TLMDTextBlock*> > > _TLMDTableRenderer__3;
	
	
protected:
	_TLMDTableRenderer__3 FTextBlocks;
	TLMDTextBlockRenderer* FTextRenderer;
	int FCurRow;
	int FCurSubRow;
	void __fastcall DrawTableCell(const System::Types::TPoint &AZeroPoint, Vcl::Graphics::TCanvas* ACanvas, Lmddocmodel::TLMDTableCell* ACell, Lmddocmodel::TLMDTextBlock* ATextBlock);
	
public:
	__fastcall TLMDTableRenderer(void);
	__fastcall virtual ~TLMDTableRenderer(void);
	virtual void __fastcall LayOut(void);
	virtual void __fastcall DrawArea(const System::Types::TPoint &APoint, int AVertIndex, int AHorizIndex);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDocImageRenderer : public TLMDCustomDocElementRenderer
{
	typedef TLMDCustomDocElementRenderer inherited;
	
protected:
	Vcl::Graphics::TBitmap* FBitmap;
	bool FBitmapCopied;
	
public:
	virtual void __fastcall FreePageAreas(void);
	virtual void __fastcall LayOut(void);
	virtual void __fastcall DrawArea(const System::Types::TPoint &APoint, int AVertIndex, int AHorizIndex);
public:
	/* TLMDCustomDocElementRenderer.Create */ inline __fastcall TLMDDocImageRenderer(void) : TLMDCustomDocElementRenderer() { }
	/* TLMDCustomDocElementRenderer.Destroy */ inline __fastcall virtual ~TLMDDocImageRenderer(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LoadRTFLines(Vcl::Comctrls::TRichEdit* ADest, System::Classes::TStrings* ASrc);
extern DELPHI_PACKAGE void __fastcall SaveRTFLines(System::Classes::TStrings* ADest, Vcl::Comctrls::TRichEdit* ASrc);
}	/* namespace Lmddocelementrenderer */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDOCELEMENTRENDERER)
using namespace Lmddocelementrenderer;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddocelementrendererHPP
