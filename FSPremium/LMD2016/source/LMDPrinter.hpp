// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPrinter.pas' rev: 31.00 (Windows)

#ifndef LmdprinterHPP
#define LmdprinterHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Printers.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Math.hpp>
#include <Winapi.WinSpool.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.Types.hpp>
#include <System.Contnrs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <LMDObject.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdprinter
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDPrintPackError;
struct TLMDDoubleRect;
class DELPHICLASS TLMDPageMargins;
class DELPHICLASS TLMDPageTemplateBlock;
class DELPHICLASS TLMDPrintRendererBase;
struct TLMDPrinterInfo;
class DELPHICLASS TLMDPrinterListener;
class DELPHICLASS TLMDPrinterHelper;
class DELPHICLASS TLMDPrinterBase;
class DELPHICLASS TLMDPrinter;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPrintPackError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPrintPackError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPrintPackError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPrintPackError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPrintPackError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPrintPackError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPrintPackError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPrintPackError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPrintPackError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPrintPackError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPrintPackError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPrintPackError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPrintPackError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPrintPackError(void) { }
	
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TLMDDoubleRect
{
public:
	double Left;
	double Top;
	double Right;
	double Bottom;
};


class PASCALIMPLEMENTATION TLMDPageMargins : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	double FLeft;
	double FTop;
	double FBottom;
	double FRight;
	TLMDPrinterBase* FPrinter;
	TLMDDoubleRect __fastcall GetAsRect(void);
	void __fastcall SetAsRect(const TLMDDoubleRect &AValue);
	void __fastcall CheckMarginsRect(const TLMDDoubleRect &AValue);
	void __fastcall Reset(void);
	bool __fastcall IsMarginBottomStored(void);
	bool __fastcall IsMarginLeftStored(void);
	bool __fastcall IsMarginRightStored(void);
	bool __fastcall IsMarginTopStored(void);
	void __fastcall SetBottom(const double Value);
	void __fastcall SetLeft(const double Value);
	void __fastcall SetRight(const double Value);
	void __fastcall SetTop(const double Value);
	void __fastcall ReadMarginsZero(System::Classes::TReader* Reader);
	void __fastcall WriteMarginsZero(System::Classes::TWriter* Writer);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall TLMDPageMargins(TLMDPrinterBase* APrinter);
	virtual void __fastcall Assign(System::Classes::TPersistent* AValue);
	__property TLMDDoubleRect MarginRect = {read=GetAsRect, write=SetAsRect};
	
__published:
	__property double Left = {read=FLeft, write=SetLeft, stored=IsMarginLeftStored};
	__property double Right = {read=FRight, write=SetRight, stored=IsMarginRightStored};
	__property double Top = {read=FTop, write=SetTop, stored=IsMarginTopStored};
	__property double Bottom = {read=FBottom, write=SetBottom, stored=IsMarginBottomStored};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDPageMargins(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPageTemplateBlock : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TLMDPrinterBase* FPrinter;
	System::Classes::TStrings* FVars;
	Vcl::Forms::TForm* FFakeForm;
	Vcl::Comctrls::TRichEdit* FSaveRichEdit;
	Vcl::Comctrls::TRichEdit* FRichEdit;
	bool FVisible;
	System::Classes::TStrings* FTemplProxy;
	void __fastcall Reset(void);
	void __fastcall SetTemplate(System::Classes::TStrings* const ATemplate);
	System::Classes::TStrings* __fastcall GetTemplate(void);
	int __fastcall PixToTwips(int APix, bool AHoriz);
	void __fastcall ExpandTemplates(void);
	int __fastcall CalkHeight(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &AMaxRect);
	void __fastcall DrawTo(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetVars(System::Classes::TStrings* const Value);
	__property System::Classes::TStrings* Variables = {read=FVars, write=SetVars};
	
public:
	__fastcall TLMDPageTemplateBlock(TLMDPrinterBase* APrinter);
	__fastcall virtual ~TLMDPageTemplateBlock(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* AValue);
	void __fastcall AssignLines(System::Classes::TStrings* AValue);
	void __fastcall AssignLinesTo(System::Classes::TStrings* AValue);
	__property TLMDPrinterBase* Printer = {read=FPrinter};
	
__published:
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property System::Classes::TStrings* Template = {read=GetTemplate, write=SetTemplate};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDPrintOperationRange : unsigned char { orSelection, orAll };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPrintRendererBase : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall PreparePages(int APageWidth, int APageHeight, Vcl::Graphics::TCanvas* ACanvas) = 0 ;
	virtual void __fastcall FinalizePages(void) = 0 ;
	virtual int __fastcall GetPagesCount(TLMDPrintOperationRange ARange) = 0 ;
	virtual void __fastcall DrawPage(TLMDPrintOperationRange ARange, int ANum, const System::Types::TPoint &APoint, Vcl::Graphics::TCanvas* ACanvas) = 0 ;
public:
	/* TObject.Create */ inline __fastcall TLMDPrintRendererBase(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDPrintRendererBase(void) { }
	
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TLMDPrinterInfo
{
public:
	System::Uitypes::TPrinterOrientation Orientation;
	double PageWidthFullUnits;
	double PageHeightFullUnits;
	TLMDDoubleRect MinMarginsUnits;
	int PageWidthFullPixels;
	int PageHeightFullPixels;
	System::Types::TRect MinMarginsPixels;
	double PixPerUnitX;
	double PixPerUnitY;
	Lmdtypes::TLMDUnits SystemUnits;
};


enum DECLSPEC_DENUM TLMDPrinterChangeKind : unsigned char { pcUnits, pcPrintableArea, pcPrinterSettings };

typedef System::Set<TLMDPrinterChangeKind, TLMDPrinterChangeKind::pcUnits, TLMDPrinterChangeKind::pcPrinterSettings> TLMDPrinterChangeKinds;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPrinterListener : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall Refresh(TLMDPrinterChangeKinds AChanges) = 0 ;
public:
	/* TObject.Create */ inline __fastcall TLMDPrinterListener(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDPrinterListener(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPrinterHelper : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	virtual void __fastcall SetPageMargins(const TLMDDoubleRect &AValue) = 0 ;
	virtual TLMDDoubleRect __fastcall GetPageMargins(void) = 0 ;
	
public:
	virtual void __fastcall AddListener(TLMDPrinterListener* ALst) = 0 ;
	virtual void __fastcall RemoveListener(TLMDPrinterListener* ALst) = 0 ;
	virtual void __fastcall ExecPrintSetupDlg(void) = 0 ;
	virtual void __fastcall ExecPageSetupDlg(void) = 0 ;
	virtual void __fastcall ExecPrintDlg(void) = 0 ;
	virtual TLMDPrinterBase* __fastcall GetPrinter(void) = 0 ;
	__property TLMDDoubleRect Margins = {read=GetPageMargins, write=SetPageMargins};
	virtual void __fastcall PrintPages(TLMDPrintOperationRange ARange, int AStart, int ACount) = 0 ;
	virtual int __fastcall GetPagesCount(TLMDPrintOperationRange ARange) = 0 ;
	virtual void __fastcall DrawPage(TLMDPrintOperationRange ARange, int APage, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect) = 0 ;
	virtual void __fastcall SavePage(TLMDPrintOperationRange ARange, int APage, Lmdtypes::TLMDString AFileName) = 0 ;
public:
	/* TObject.Create */ inline __fastcall TLMDPrinterHelper(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDPrinterHelper(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDPrinterBase : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
protected:
	Vcl::Printers::TPrinter* FSysPrinter;
	TLMDPrinterInfo FPrinterInfo;
	Lmdtypes::TLMDUnits FRealUnits;
	Lmdtypes::TLMDUnits FUnits;
	Lmdtypes::TLMDString FTitle;
	double FPrintableWidthUnits;
	double FPrintableHeightUnits;
	int FPrintableWidthPixels;
	int FPrintableHeightPixels;
	System::Contnrs::TObjectList* FListeners;
	TLMDPrinterChangeKinds FChanges;
	bool __fastcall IsPrinterValid(void);
	void __fastcall CheckPrinterValid(void);
	void __fastcall CheckActive(void);
	void __fastcall CheckNotActive(void);
	void __fastcall CheckUnits(Lmdtypes::TLMDMeasureUnits AUnits);
	void __fastcall CheckUpdating(void);
	void __fastcall CheckNotUpdating(void);
	void __fastcall RaiseNotImplemented(void);
	Lmdtypes::TLMDMeasureUnits __fastcall CalkRealUnits(Lmdtypes::TLMDMeasureUnits AUnits, Lmdtypes::TLMDMeasureUnits ASystemUnits);
	void __fastcall SetUnits(const Lmdtypes::TLMDMeasureUnits AValue);
	void __fastcall SetTitle(const Lmdtypes::TLMDString ATitle);
	System::Types::TRect __fastcall GetMinMarginsPixels(void);
	TLMDDoubleRect __fastcall GetMinMarginsUnits(void);
	System::Uitypes::TPrinterOrientation __fastcall GetOrientation(void);
	double __fastcall GetPixPerUnitX(void);
	double __fastcall GetPixPerUnitY(void);
	int __fastcall GetPrintInfoPixels(const int AIndex);
	double __fastcall GetPrintInfoUnits(const int AIndex);
	TLMDDoubleRect __fastcall GetDefaultMarginRect(void);
	void __fastcall AddSettingsChanges(TLMDPrinterChangeKinds AChanges);
	void __fastcall FireSettingsChanged(void);
	void __fastcall FireBeforePage(void);
	void __fastcall FireAfterPage(void);
	void __fastcall UpdatePrinterInfo(void);
	void __fastcall PrinterSettingsChanged(TLMDPrinterChangeKinds AChanges);
	void __fastcall RecalkPrintable(void);
	virtual void __fastcall ResetOnPrinterChanges(TLMDPrinterChangeKinds AChanges);
	virtual void __fastcall PrintableSettingsChanged(void);
	virtual TLMDDoubleRect __fastcall GetPageMargins(void);
	DYNAMIC void __fastcall Change(void);
	
public:
	__fastcall virtual TLMDPrinterBase(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDPrinterBase(void);
	TLMDPrinterInfo __fastcall GetDefaultPrinterInfo(Lmdtypes::TLMDMeasureUnits AUnits);
	TLMDPrinterInfo __fastcall GetPrinterInfo(Lmdtypes::TLMDMeasureUnits AUnits);
	Vcl::Printers::TPrinter* __fastcall GetSysPrinter(void);
	__property Lmdtypes::TLMDMeasureUnits RealUnits = {read=FRealUnits, nodefault};
	__property double PageWidthFullUnits = {read=GetPrintInfoUnits, index=0};
	__property double PageHeightFullUnits = {read=GetPrintInfoUnits, index=1};
	__property double PageWidthPrintableUnits = {read=GetPrintInfoUnits, index=2};
	__property double PageHeightPrintableUnits = {read=GetPrintInfoUnits, index=3};
	__property TLMDDoubleRect MinMarginsUnits = {read=GetMinMarginsUnits};
	__property int PageWidthFullPixels = {read=GetPrintInfoPixels, index=0, nodefault};
	__property int PageHeightFullPixels = {read=GetPrintInfoPixels, index=1, nodefault};
	__property int PageWidthPrintablePixels = {read=GetPrintInfoPixels, index=2, nodefault};
	__property int PageHeightPrintablePixels = {read=GetPrintInfoPixels, index=3, nodefault};
	__property System::Types::TRect MinMarginsPixels = {read=GetMinMarginsPixels};
	__property double PixPerUnitX = {read=GetPixPerUnitX};
	__property double PixPerUnitY = {read=GetPixPerUnitY};
	__property System::Uitypes::TPrinterOrientation Orientation = {read=GetOrientation, nodefault};
	System::Types::TRect __fastcall UnitsToPixelsRect(const TLMDDoubleRect &ARect);
	TLMDDoubleRect __fastcall PixelsToUnitsRect(const System::Types::TRect &ARect);
	int __fastcall UnitsToPixelsX(double AUnits);
	double __fastcall PixelsToUnitsX(int APixels);
	int __fastcall UnitsToPixelsY(double AUnits);
	double __fastcall PixelsToUnitsY(int APixels);
	double __fastcall UnitsToUnits(Lmdtypes::TLMDMeasureUnits AWhatUnitsFrom, Lmdtypes::TLMDMeasureUnits AWhatUnitsTo, double AUnits);
	TLMDDoubleRect __fastcall UnitsToUnitsRect(Lmdtypes::TLMDMeasureUnits AWhatUnitsFrom, Lmdtypes::TLMDMeasureUnits AWhatUnitsTo, const TLMDDoubleRect &AUnits);
	void __fastcall AddListener(TLMDPrinterListener* ALst);
	void __fastcall RemoveListener(TLMDPrinterListener* ALst);
	void __fastcall SetPrinter(NativeUInt hDevMode, NativeUInt hDevNames);
	void __fastcall GetPrinter(NativeUInt &hDevMode, NativeUInt &hDevNames);
	
__published:
	__property About = {default=0};
	__property Lmdtypes::TLMDMeasureUnits Units = {read=FUnits, write=SetUnits, default=2};
	__property Lmdtypes::TLMDString Title = {read=FTitle, write=SetTitle};
	__property OnChange;
};


class PASCALIMPLEMENTATION TLMDPrinter : public TLMDPrinterBase
{
	typedef TLMDPrinterBase inherited;
	
private:
	TLMDPageMargins* FPageMargins;
	TLMDPageTemplateBlock* FHeader;
	TLMDPageTemplateBlock* FFooter;
	TLMDPrinterHelper* FHelper;
	bool FPagesPrepared;
	bool FDocStarted;
	int FPagesCount;
	int FSelectedPagesCount;
	System::Types::TRect FContentRect;
	TLMDPrintRendererBase* FRenderer;
	Vcl::Graphics::TMetafile* FMetafile;
	int FCurrentPage;
	int FHeadH;
	int FFootH;
	System::Types::TRect FFrameRect;
	Lmdtypes::TLMDUnits FOldUnits;
	Vcl::Printers::TPrinter* FOldSysPrinter;
	void __fastcall CheckPagesPrepared(void);
	void __fastcall CheckPagesNotPrepared(void);
	void __fastcall CheckDocStarted(void);
	void __fastcall CheckDocFinished(void);
	void __fastcall CheckPagesRange(TLMDPrintOperationRange AOpRange, int AStart, int ACount);
	void __fastcall SetPageMargins(TLMDPageMargins* const AValue);
	void __fastcall SetFooter(TLMDPageTemplateBlock* const AValue);
	void __fastcall SetHeader(TLMDPageTemplateBlock* const AValue);
	void __fastcall FillVars(TLMDPageTemplateBlock* ATemplate);
	void __fastcall PreparePrintVars(void);
	void __fastcall FreePrintVars(void);
	
protected:
	virtual void __fastcall ResetOnPrinterChanges(TLMDPrinterChangeKinds AChanges);
	virtual void __fastcall PrintableSettingsChanged(void);
	virtual TLMDDoubleRect __fastcall GetPageMargins(void);
	
public:
	__fastcall virtual TLMDPrinter(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDPrinter(void);
	void __fastcall PreparePages(TLMDPrintRendererBase* ARenderer);
	void __fastcall FinalizePages(void);
	void __fastcall BeginDoc(void);
	void __fastcall EndDoc(void);
	void __fastcall PrintPages(TLMDPrintOperationRange ARange, int AStart, int ACount);
	int __fastcall GetPagesCount(TLMDPrintOperationRange ARange);
	void __fastcall DrawPage(TLMDPrintOperationRange ARange, int APage, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	void __fastcall SavePage(TLMDPrintOperationRange ARange, int APage, Lmdtypes::TLMDString AFileName);
	void __fastcall ExecPreviewDlg(void);
	bool __fastcall ExecPrintSetupDlg(void);
	bool __fastcall ExecPageSetupDlg(void);
	bool __fastcall ExecPrintDlg(void);
	__property TLMDPrinterHelper* PrinterHelper = {read=FHelper};
	
__published:
	__property TLMDPageMargins* Margins = {read=FPageMargins, write=SetPageMargins};
	__property TLMDPageTemplateBlock* Header = {read=FHeader, write=SetHeader};
	__property TLMDPageTemplateBlock* Footer = {read=FFooter, write=SetFooter};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall LMDPrintIsMetricLocale(void);
extern DELPHI_PACKAGE void __fastcall LMDPrintCheckMarginsRect(const TLMDDoubleRect &AMargins, TLMDPrinterBase* APrinter);
extern DELPHI_PACKAGE TLMDDoubleRect __fastcall LMDDoubleRect(double ALeft, double ARight, double ATop, double ABottom);
}	/* namespace Lmdprinter */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPRINTER)
using namespace Lmdprinter;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdprinterHPP
