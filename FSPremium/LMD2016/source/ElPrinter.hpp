// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElPrinter.pas' rev: 31.00 (Windows)

#ifndef ElprinterHPP
#define ElprinterHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Math.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Printers.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <LMDProcs.hpp>
#include <ElComponent.hpp>
#include <LMDObjectList.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elprinter
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS EPrinterError;
class DELPHICLASS TElPrinter;
class DELPHICLASS TElControlPrinter;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION EPrinterError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EPrinterError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EPrinterError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EPrinterError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EPrinterError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EPrinterError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EPrinterError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EPrinterError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EPrinterError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EPrinterError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EPrinterError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EPrinterError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EPrinterError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EPrinterError(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TPNLayout : unsigned char { plTop, plBottom };

typedef void __fastcall (__closure *TDrawPageNumberEvent)(System::TObject* Sender, Lmdtypes::TLMDString &Text, int PageNumber);

typedef void __fastcall (__closure *TDrawPageCaptionEvent)(System::TObject* Sender, Lmdtypes::TLMDString &Text, int PageNumber, System::Types::TRect &Rec);

typedef void __fastcall (__closure *TPageEvent)(System::TObject* Sender, int PageNumber);

class PASCALIMPLEMENTATION TElPrinter : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	bool FActive;
	Lmdobjectlist::TLMDObjectList* FCanvas;
	HDC FDC;
	TPageEvent FOnAfterPage;
	TPageEvent FOnBeforePage;
	int FPageIndex;
	Lmdobjectlist::TLMDObjectList* FPages;
	int FPageWidth;
	int FPageHeight;
	int FPrintOffsetX;
	int FPrintOffsetY;
	int FRightMargin;
	int FBottomMargin;
	int FLeftMargin;
	int FTopMargin;
	System::UnicodeString FTitle;
	Vcl::Graphics::TCanvas* __fastcall GetCanvas(int Index);
	Vcl::Graphics::TMetafile* __fastcall GetPage(int Index);
	int __fastcall GetPageCount(void);
	int __fastcall GetPageHeight(void);
	int __fastcall GetPageWidth(void);
	int __fastcall GetPrintOffsetX(void);
	int __fastcall GetPrintOffsetY(void);
	void __fastcall SetBottomMargin(int Value);
	void __fastcall SetCanvas(int Index, Vcl::Graphics::TCanvas* Value);
	void __fastcall SetLeftMargin(int Value);
	void __fastcall SetPage(int Index, Vcl::Graphics::TMetafile* Value);
	void __fastcall SetPageIndex(int Value);
	void __fastcall SetRightMargin(int Value);
	void __fastcall SetTopMargin(int Value);
	
protected:
	virtual void __fastcall TriggerAfterPage(int PageNumber);
	virtual void __fastcall TriggerBeforePage(int PageNumber);
	
public:
	__fastcall virtual TElPrinter(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElPrinter(void);
	void __fastcall Abort(void);
	int __fastcall AddPage(void);
	void __fastcall BeginDoc(void);
	void __fastcall Clear(void);
	void __fastcall DeletePage(int Index);
	void __fastcall EndDoc(void);
	void __fastcall InsertPage(int Index);
	virtual void __fastcall Loaded(void);
	void __fastcall NewPage(void);
	int __fastcall Preview(void);
	void __fastcall PrintPages(int StartIndex, int EndIndex);
	void __fastcall SavePage(System::UnicodeString FileName, int Index);
	int __fastcall HorzMMToPixel(int MM100s);
	int __fastcall VertMMToPixel(int MM100s);
	__property bool Active = {read=FActive, nodefault};
	__property Vcl::Graphics::TCanvas* Canvas[int Index] = {read=GetCanvas, write=SetCanvas};
	__property Vcl::Graphics::TMetafile* Page[int Index] = {read=GetPage, write=SetPage};
	__property int PageCount = {read=GetPageCount, nodefault};
	__property int PageHeight = {read=FPageHeight, nodefault};
	__property int PageIndex = {read=FPageIndex, write=SetPageIndex, default=-1};
	__property int PageWidth = {read=FPageWidth, nodefault};
	__property int PrintOffsetX = {read=FPrintOffsetX, nodefault};
	__property int PrintOffsetY = {read=FPrintOffsetY, nodefault};
	__property HDC PrinterDC = {read=FDC, nodefault};
	
__published:
	__property int BottomMargin = {read=FBottomMargin, write=SetBottomMargin, default=2000};
	__property int LeftMargin = {read=FLeftMargin, write=SetLeftMargin, default=2000};
	__property int RightMargin = {read=FRightMargin, write=SetRightMargin, default=2000};
	__property int TopMargin = {read=FTopMargin, write=SetTopMargin, default=2000};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property TPageEvent OnAfterPage = {read=FOnAfterPage, write=FOnAfterPage};
	__property TPageEvent OnBeforePage = {read=FOnBeforePage, write=FOnBeforePage};
};


class PASCALIMPLEMENTATION TElControlPrinter : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	TElPrinter* FPrinter;
	void __fastcall SetElPrinter(TElPrinter* Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
__published:
	__property TElPrinter* Printer = {read=FPrinter, write=SetElPrinter};
public:
	/* TComponent.Create */ inline __fastcall virtual TElControlPrinter(System::Classes::TComponent* AOwner) : Elcomponent::TElComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TElControlPrinter(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elprinter */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELPRINTER)
using namespace Elprinter;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElprinterHPP
