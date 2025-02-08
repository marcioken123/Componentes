// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTxtPrinter.pas' rev: 31.00 (Windows)

#ifndef LmdtxtprinterHPP
#define LmdtxtprinterHPP

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
#include <LMDCustomComponent.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtxtprinter
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTxtPrinter;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDGetColorEvent)(System::TObject* Sender, int Row, int PageRow, System::Uitypes::TColor &Color);

typedef void __fastcall (__closure *TLMDGetRectEvent)(System::TObject* Sender, System::Types::TRect &getRect, const System::Types::TRect &printRect);

typedef void __fastcall (__closure *TLMDPrintRectEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* aCanvas, int page, System::Types::TRect &pRect);

typedef void __fastcall (__closure *TLMDPageStringEvent)(System::TObject* Sender, System::UnicodeString &s, int page);

typedef void __fastcall (__closure *TLMDGetIntegerEvent)(System::TObject* Sender, int &aValue);

typedef void __fastcall (__closure *TLMDLineNumStringEvent)(System::TObject* Sender, System::UnicodeString &s, int line);

enum DECLSPEC_DENUM TLMDLineNumbers : unsigned char { lnNone, lnPage, lnGlobal };

enum DECLSPEC_DENUM TLMDPageNumbers : unsigned char { pnNone, pnTopLeft, pnTopCenter, pnTopRight, pnBottomLeft, pnBottomCenter, pnBottomRight };

class PASCALIMPLEMENTATION TLMDTxtPrinter : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	Vcl::Graphics::TFont* FFont;
	bool FBorder;
	bool FWordWrap;
	bool FCountWrappedLines;
	bool FLined;
	Vcl::Graphics::TPen* FLineStyle;
	TLMDLineNumbers FLineNumbers;
	TLMDPageNumbers FPageNumbers;
	System::UnicodeString FPrintTitle;
	int FHeaderHeight;
	int FFooterHeight;
	int FSheetColumns;
	int FSheetRows;
	int FCopies;
	TLMDGetColorEvent FOnGetColor;
	TLMDGetRectEvent FOnGetPrintRect;
	TLMDPrintRectEvent FOnPrintGFooter;
	TLMDPrintRectEvent FOnPrintGHeader;
	TLMDPrintRectEvent FOnPrintFooter;
	TLMDPrintRectEvent FOnPrintHeader;
	TLMDPageStringEvent FOnGetPageString;
	TLMDLineNumStringEvent FOnGetLineNumString;
	TLMDGetIntegerEvent FOnGetLNDigitSpace;
	void __fastcall SetFont(Vcl::Graphics::TFont* aValue);
	void __fastcall SetLineStyle(Vcl::Graphics::TPen* aValue);
	
protected:
	void __fastcall Print(const System::UnicodeString Text, int iStart, int iCount);
	
public:
	__fastcall virtual TLMDTxtPrinter(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDTxtPrinter(void);
	void __fastcall PrintFile(const System::UnicodeString Filename);
	void __fastcall PrintText(const System::UnicodeString txt);
	__property TLMDLineNumStringEvent OnGetLineNumberString = {read=FOnGetLineNumString, write=FOnGetLineNumString};
	
__published:
	__property About = {default=0};
	__property bool Border = {read=FBorder, write=FBorder, default=0};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool WordWrap = {read=FWordWrap, write=FWordWrap, default=1};
	__property bool Lined = {read=FLined, write=FLined, default=0};
	__property TLMDLineNumbers LineNumbers = {read=FLineNumbers, write=FLineNumbers, default=0};
	__property bool CountWrappedLines = {read=FCountWrappedLines, write=FCountWrappedLines, default=0};
	__property TLMDPageNumbers PageNumbers = {read=FPageNumbers, write=FPageNumbers, default=0};
	__property Vcl::Graphics::TPen* LineStyle = {read=FLineStyle, write=SetLineStyle};
	__property System::UnicodeString Title = {read=FPrintTitle, write=FPrintTitle};
	__property int Copies = {read=FCopies, write=FCopies, default=1};
	__property int HeaderHeight = {read=FHeaderHeight, write=FHeaderHeight, default=1};
	__property int FooterHeight = {read=FFooterHeight, write=FFooterHeight, default=1};
	__property int SheetColumns = {read=FSheetColumns, write=FSheetColumns, default=1};
	__property int SheetRows = {read=FSheetRows, write=FSheetRows, default=1};
	__property TLMDGetColorEvent OnGetRowColor = {read=FOnGetColor, write=FOnGetColor};
	__property TLMDGetRectEvent OnGetPrintRect = {read=FOnGetPrintRect, write=FOnGetPrintRect};
	__property TLMDPrintRectEvent OnPrintGlobalFooter = {read=FOnPrintGFooter, write=FOnPrintGFooter};
	__property TLMDPrintRectEvent OnPrintGlobalHeader = {read=FOnPrintGHeader, write=FOnPrintGHeader};
	__property TLMDPrintRectEvent OnPrintFooter = {read=FOnPrintFooter, write=FOnPrintFooter};
	__property TLMDPrintRectEvent OnPrintHeader = {read=FOnPrintHeader, write=FOnPrintHeader};
	__property TLMDPageStringEvent OnGetPageString = {read=FOnGetPageString, write=FOnGetPageString};
	__property TLMDGetIntegerEvent OnGetLineNumberSpace = {read=FOnGetLNDigitSpace, write=FOnGetLNDigitSpace};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtxtprinter */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTXTPRINTER)
using namespace Lmdtxtprinter;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtxtprinterHPP
