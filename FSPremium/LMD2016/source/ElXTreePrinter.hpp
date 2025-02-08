// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElXTreePrinter.pas' rev: 31.00 (Windows)

#ifndef ElxtreeprinterHPP
#define ElxtreeprinterHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.ImgList.hpp>
#include <System.Math.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <System.Types.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <ElXTree.hpp>
#include <ElXTreeCell.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <ElPrinter.hpp>
#include <Vcl.Forms.hpp>
#include <ElHeader.hpp>
#include <ElXHeader.hpp>
#include <ElStack.hpp>
#include <ElVCLUtils.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elxtreeprinter
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS EElXTreePrinterError;
class DELPHICLASS TElXTreePrinter;
class DELPHICLASS TElXTreePrintSettings;
class DELPHICLASS TElXHeaderPrintSettings;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TElXPrintTreeItemEvent)(System::TObject* Sender, Elxtree::TElXTreeItem* Item, bool &Print);

typedef void __fastcall (__closure *TElXPrintHeaderSectionEvent)(System::TObject* Sender, Elxheader::TElXHeaderSection* Section, bool &Print);

#pragma pack(push,4)
class PASCALIMPLEMENTATION EElXTreePrinterError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EElXTreePrinterError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EElXTreePrinterError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EElXTreePrinterError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EElXTreePrinterError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EElXTreePrinterError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EElXTreePrinterError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EElXTreePrinterError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EElXTreePrinterError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EElXTreePrinterError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EElXTreePrinterError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EElXTreePrinterError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EElXTreePrinterError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EElXTreePrinterError(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TElXHeaderPrintOption : unsigned char { hpoPrintOnEveryPage, hpoShowSortMarks, hpoShowImages, hpoWrapCaptions, hpoFlat };

typedef System::Set<TElXHeaderPrintOption, TElXHeaderPrintOption::hpoPrintOnEveryPage, TElXHeaderPrintOption::hpoFlat> TElXHeaderPrintOptions;

enum DECLSPEC_DENUM TElXTreePrintOption : unsigned char { tpoShowButtons, tpoShowEmptyImages, tpoShowEmptyImages2, tpoShowCheckboxes, tpoShowColumns, tpoShowHeader, tpoShowHiddenItems, tpoShowHiddenSections, tpoShowImages, tpoShowInvisibleItems, tpoShowInvisibleSections, tpoShowLines, tpoShowRoot, tpoShowRootButtons, tpoShowLeafButton, tpoShowVerticalLines, tpoShowHorizontalLines, tpoUseItemStyles, tpoUseCellStyles };

typedef System::Set<TElXTreePrintOption, TElXTreePrintOption::tpoShowButtons, TElXTreePrintOption::tpoUseCellStyles> TElXTreePrintOptions;

class PASCALIMPLEMENTATION TElXTreePrinter : public Elprinter::TElControlPrinter
{
	typedef Elprinter::TElControlPrinter inherited;
	
private:
	Elprinter::TPageEvent FOnAfterPage;
	Elprinter::TPageEvent FOnBeforePage;
	void __fastcall SetTree(Elxtree::TCustomElXTree* Value);
	void __fastcall SetTreeProps(Elxtree::TCustomElXTree* ATree);
	void __fastcall SetHeaderPS(TElXHeaderPrintSettings* const Value);
	void __fastcall SetTreePS(TElXTreePrintSettings* const Value);
	void __fastcall SetPrintAsIs(const bool Value);
	
protected:
	bool FShowPageNumbers;
	Elprinter::TPNLayout FPageNumbersLayout;
	Lmdtypes::TLMDString FPageNumbersText;
	System::Classes::TAlignment FPageNumbersAlignment;
	Lmdtypes::TLMDString FCaption;
	Elprinter::TDrawPageNumberEvent FOnDrawPageNumber;
	Elprinter::TDrawPageCaptionEvent FOnDrawCaption;
	bool FPrinting;
	bool FPrintAsIs;
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	TElXPrintTreeItemEvent FOnItemPrinting;
	TElXPrintHeaderSectionEvent FOnSectionPrinting;
	Elxtree::TCustomElXTree* FTree;
	TElXHeaderPrintSettings* FHeaderPS;
	TElXTreePrintSettings* FTreePS;
	void __fastcall DoDrawHeader(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &ARect, Elxtree::TCustomElXTree* ATree);
	virtual void __fastcall TriggerItemPrintingEvent(Elxtree::TElXTreeItem* Item, bool &Print);
	virtual void __fastcall TriggerSectionPrintingEvent(Elxheader::TElXHeaderSection* Section, bool &Print);
	virtual void __fastcall TriggerAfterPage(int PageNumber);
	virtual void __fastcall TriggerBeforePage(int PageNumber);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadPageNumbersLayout(System::Classes::TReader* Reader);
	virtual void __fastcall DoDrawPageNumber(int PageNumber);
	virtual void __fastcall DoDrawCaption(int PageNumber, System::Types::TRect &Rec);
	
public:
	__fastcall virtual TElXTreePrinter(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElXTreePrinter(void);
	void __fastcall Print(void);
	
__published:
	__property bool PrintAsIs = {read=FPrintAsIs, write=SetPrintAsIs, nodefault};
	__property TElXHeaderPrintSettings* HeaderPrintSettings = {read=FHeaderPS, write=SetHeaderPS};
	__property TElXTreePrintSettings* TreePrintSettings = {read=FTreePS, write=SetTreePS};
	__property Elxtree::TCustomElXTree* Tree = {read=FTree, write=SetTree};
	__property bool ShowPageNumbers = {read=FShowPageNumbers, write=FShowPageNumbers, default=1};
	__property Elprinter::TPNLayout PageNumbersLayout = {read=FPageNumbersLayout, write=FPageNumbersLayout, default=0};
	__property Lmdtypes::TLMDString PageNumbersText = {read=FPageNumbersText, write=FPageNumbersText};
	__property System::Classes::TAlignment PageNumbersAlignment = {read=FPageNumbersAlignment, write=FPageNumbersAlignment, default=2};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=FCaption};
	__property Elprinter::TPageEvent OnAfterPage = {read=FOnAfterPage, write=FOnAfterPage};
	__property Elprinter::TPageEvent OnBeforePage = {read=FOnBeforePage, write=FOnBeforePage};
	__property TElXPrintTreeItemEvent OnItemPrinting = {read=FOnItemPrinting, write=FOnItemPrinting};
	__property TElXPrintHeaderSectionEvent OnSectionPrinting = {read=FOnSectionPrinting, write=FOnSectionPrinting};
	__property Elprinter::TDrawPageNumberEvent OnDrawPageNumber = {read=FOnDrawPageNumber, write=FOnDrawPageNumber};
	__property Elprinter::TDrawPageCaptionEvent OnDrawCaption = {read=FOnDrawCaption, write=FOnDrawCaption};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElXTreePrintSettings : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TElXTreePrinter* FPrinter;
	Vcl::Graphics::TFont* FFont;
	int FScale;
	System::Uitypes::TColor FStripedEvenColor;
	bool FStripedItems;
	System::Uitypes::TColor FStripedOddColor;
	System::Uitypes::TColor FHorzDivLinesColor;
	System::Uitypes::TColor FVertDivLinesColor;
	Elxtreecell::TElXCellStyle* FStyle;
	TElXTreePrintOptions FPrintOptions;
	void __fastcall Init(TElXTreePrinter* APrinter);
	void __fastcall SetPrintOptions(const TElXTreePrintOptions Value);
	void __fastcall SetScale(int Value);
	void __fastcall SetStyle(Elxtreecell::TElXCellStyle* const Value);
	void __fastcall SetVertDivLinesColor(const System::Uitypes::TColor Value);
	void __fastcall SetHorzDivLinesColor(const System::Uitypes::TColor Value);
	void __fastcall SetTextColor(const System::Uitypes::TColor Value);
	void __fastcall SetStripedEvenColor(const System::Uitypes::TColor Value);
	void __fastcall SetStripedItems(const bool Value);
	void __fastcall SetStripedOddColor(const System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetTextColor(void);
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	
public:
	__fastcall TElXTreePrintSettings(void);
	__fastcall virtual ~TElXTreePrintSettings(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property Elxtreecell::TElXCellStyle* Style = {read=FStyle, write=SetStyle};
	
__published:
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property int Scale = {read=FScale, write=SetScale, default=100};
	__property System::Uitypes::TColor StripedEvenColor = {read=FStripedEvenColor, write=SetStripedEvenColor, nodefault};
	__property bool StripedItems = {read=FStripedItems, write=SetStripedItems, default=0};
	__property System::Uitypes::TColor StripedOddColor = {read=FStripedOddColor, write=SetStripedOddColor, nodefault};
	__property System::Uitypes::TColor TextColor = {read=GetTextColor, write=SetTextColor, nodefault};
	__property System::Uitypes::TColor HorzDivLinesColor = {read=FHorzDivLinesColor, write=SetHorzDivLinesColor, nodefault};
	__property System::Uitypes::TColor VertDivLinesColor = {read=FVertDivLinesColor, write=SetVertDivLinesColor, nodefault};
	__property TElXTreePrintOptions TreePrintOptions = {read=FPrintOptions, write=SetPrintOptions, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElXHeaderPrintSettings : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TElXTreePrinter* FPrinter;
	System::Uitypes::TColor FColor;
	Vcl::Graphics::TFont* FFont;
	int FHeight;
	TElXHeaderPrintOptions FPrintOptions;
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetPrintOptions(const TElXHeaderPrintOptions Value);
	void __fastcall Init(TElXTreePrinter* APrinter);
	
public:
	__fastcall TElXHeaderPrintSettings(void);
	__fastcall virtual ~TElXHeaderPrintSettings(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=16777215};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property int Height = {read=FHeight, write=SetHeight, nodefault};
	__property TElXHeaderPrintOptions HeaderPrintOptions = {read=FPrintOptions, write=SetPrintOptions, nodefault};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elxtreeprinter */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELXTREEPRINTER)
using namespace Elxtreeprinter;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElxtreeprinterHPP
