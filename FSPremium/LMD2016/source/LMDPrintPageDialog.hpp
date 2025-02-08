// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPrintPageDialog.pas' rev: 31.00 (Windows)

#ifndef LmdprintpagedialogHPP
#define LmdprintpagedialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.CommDlg.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Printers.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDPrinter.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdprintpagedialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPrintBaseDialog;
class DELPHICLASS TLMDPrintPageSetupDialog;
class DELPHICLASS TLMDPrintDialog;
class DELPHICLASS TLMDPrinterSetupDialog;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDPageSetupDialogPosition : unsigned char { rdpOwner, rdpMainForm, rdpScreen };

enum DECLSPEC_DENUM TLMDPageSetupDialogOption : unsigned char { psoDisableMargins, psoDisableOrientation, psoDisablePagePainting, psoDisablePaper, psoDisablePrinter, psoDisableHeaderFooter, psoShowHelp, psoWarning, psoNoNetworkButton };

typedef System::Set<TLMDPageSetupDialogOption, TLMDPageSetupDialogOption::psoDisableMargins, TLMDPageSetupDialogOption::psoNoNetworkButton> TLMDPageSetupDialogOptions;

typedef void __fastcall (__closure *TLMDPaintPageEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &PageRect, bool &DoneDrawing);

enum DECLSPEC_DENUM TLMDPageType : unsigned char { ptEnvelope, ptPaper };

typedef void __fastcall (__closure *TLMDPageSetupBeforePaintEvent)(System::TObject* Sender, const short PaperSize, const System::Uitypes::TPrinterOrientation Orientation, const TLMDPageType PageType, bool &DoneDrawing);

class PASCALIMPLEMENTATION TLMDPrintBaseDialog : public Vcl::Dialogs::TCommonDialog
{
	typedef Vcl::Dialogs::TCommonDialog inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	
protected:
	Lmdprinter::TLMDPrinterBase* FPrinter;
	virtual void __fastcall SetPrinter(Lmdprinter::TLMDPrinterBase* const Value);
	virtual bool __fastcall DoExecute(HWND ParentWnd) = 0 ;
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall CheckPrinterSet(void);
	__property Lmdprinter::TLMDPrinterBase* Printer = {read=FPrinter, write=SetPrinter};
	
public:
	__fastcall virtual TLMDPrintBaseDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDPrintBaseDialog(void);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual bool __fastcall Execute(HWND ParentWnd)/* overload */;
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(void){ return Vcl::Dialogs::TCommonDialog::Execute(); }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


class PASCALIMPLEMENTATION TLMDPrintPageSetupDialog : public TLMDPrintBaseDialog
{
	typedef TLMDPrintBaseDialog inherited;
	
private:
	Lmdprinter::TLMDDoubleRect FMargin;
	TLMDPageSetupDialogOptions FOptions;
	TLMDPageSetupBeforePaintEvent FBeforePaint;
	TLMDPaintPageEvent FOnDrawRetAddress;
	TLMDPaintPageEvent FOnDrawMinMargin;
	TLMDPaintPageEvent FOnDrawEnvStamp;
	TLMDPaintPageEvent FOnDrawFullPage;
	TLMDPaintPageEvent FOnDrawGreekText;
	TLMDPaintPageEvent FOnDrawMargin;
	Lmdprinter::TLMDPrinter* FTmpPrinter;
	TLMDPageSetupDialogPosition FDlgPosition;
	void __fastcall SetMargin(const Lmdprinter::TLMDDoubleRect &AValue);
	Lmdprinter::TLMDDoubleRect __fastcall IntToUnitsRect(const System::Types::TRect &ARect);
	System::Types::TRect __fastcall UnitsToIntRect(const Lmdprinter::TLMDDoubleRect &ARect);
	double __fastcall IntToUnits(int AInt);
	int __fastcall UnitsToInt(double AUnits);
	HWND __fastcall GetDlgParentHandle(void);
	void __fastcall SetHeader(System::Classes::TStrings* const Value);
	System::Classes::TStrings* __fastcall GetHeader(void);
	System::Classes::TStrings* __fastcall GetFooter(void);
	void __fastcall SetFooter(System::Classes::TStrings* const Value);
	
protected:
	virtual bool __fastcall DoExecute(HWND ParentWnd);
	virtual void __fastcall SetPrinter(Lmdprinter::TLMDPrinterBase* const Value);
	
public:
	__fastcall virtual TLMDPrintPageSetupDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDPrintPageSetupDialog(void);
	__property Lmdprinter::TLMDDoubleRect Margins = {read=FMargin, write=SetMargin};
	
__published:
	__property Printer;
	__property System::Classes::TStrings* HeaderTemplate = {read=GetHeader, write=SetHeader};
	__property System::Classes::TStrings* FooterTemplate = {read=GetFooter, write=SetFooter};
	__property TLMDPageSetupDialogOptions Options = {read=FOptions, write=FOptions, default=0};
	__property TLMDPageSetupDialogPosition DlgPosition = {read=FDlgPosition, write=FDlgPosition, default=0};
	__property TLMDPageSetupBeforePaintEvent OnBeforePaint = {read=FBeforePaint, write=FBeforePaint};
	__property TLMDPaintPageEvent OnDrawFullPage = {read=FOnDrawFullPage, write=FOnDrawFullPage};
	__property TLMDPaintPageEvent OnDrawMinMargin = {read=FOnDrawMinMargin, write=FOnDrawMinMargin};
	__property TLMDPaintPageEvent OnDrawMargin = {read=FOnDrawMargin, write=FOnDrawMargin};
	__property TLMDPaintPageEvent OnDrawGreekText = {read=FOnDrawGreekText, write=FOnDrawGreekText};
	__property TLMDPaintPageEvent OnDrawEnvStamp = {read=FOnDrawEnvStamp, write=FOnDrawEnvStamp};
	__property TLMDPaintPageEvent OnDrawRetAddress = {read=FOnDrawRetAddress, write=FOnDrawRetAddress};
};


class PASCALIMPLEMENTATION TLMDPrintDialog : public TLMDPrintBaseDialog
{
	typedef TLMDPrintBaseDialog inherited;
	
private:
	int FFromPage;
	int FToPage;
	bool FCollate;
	System::Uitypes::TPrintDialogOptions FOptions;
	bool FPrintToFile;
	System::Uitypes::TPrintRange FPrintRange;
	int FMinPage;
	int FMaxPage;
	int FCopies;
	void __fastcall SetNumCopies(int Value);
	
protected:
	virtual bool __fastcall DoExecute(HWND ParentWnd);
	
__published:
	__property Printer;
	__property bool Collate = {read=FCollate, write=FCollate, default=0};
	__property int Copies = {read=FCopies, write=SetNumCopies, default=0};
	__property int FromPage = {read=FFromPage, write=FFromPage, default=0};
	__property int MinPage = {read=FMinPage, write=FMinPage, default=0};
	__property int MaxPage = {read=FMaxPage, write=FMaxPage, default=0};
	__property System::Uitypes::TPrintDialogOptions Options = {read=FOptions, write=FOptions, default=0};
	__property bool PrintToFile = {read=FPrintToFile, write=FPrintToFile, default=0};
	__property System::Uitypes::TPrintRange PrintRange = {read=FPrintRange, write=FPrintRange, default=0};
	__property int ToPage = {read=FToPage, write=FToPage, default=0};
public:
	/* TLMDPrintBaseDialog.Create */ inline __fastcall virtual TLMDPrintDialog(System::Classes::TComponent* AOwner) : TLMDPrintBaseDialog(AOwner) { }
	/* TLMDPrintBaseDialog.Destroy */ inline __fastcall virtual ~TLMDPrintDialog(void) { }
	
};


class PASCALIMPLEMENTATION TLMDPrinterSetupDialog : public TLMDPrintBaseDialog
{
	typedef TLMDPrintBaseDialog inherited;
	
protected:
	virtual bool __fastcall DoExecute(HWND ParentWnd);
	
__published:
	__property Printer;
public:
	/* TLMDPrintBaseDialog.Create */ inline __fastcall virtual TLMDPrinterSetupDialog(System::Classes::TComponent* AOwner) : TLMDPrintBaseDialog(AOwner) { }
	/* TLMDPrintBaseDialog.Destroy */ inline __fastcall virtual ~TLMDPrinterSetupDialog(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define LMDPageSetupDefaultOptions System::Set<System::Byte>()
}	/* namespace Lmdprintpagedialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPRINTPAGEDIALOG)
using namespace Lmdprintpagedialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdprintpagedialogHPP
