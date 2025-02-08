// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomPrintTask.pas' rev: 31.00 (Windows)

#ifndef LmdcustomprinttaskHPP
#define LmdcustomprinttaskHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Math.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Printers.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDPrinter.hpp>
#include <LMDDocModel.hpp>
#include <LMDDocElementRenderer.hpp>
#include <LMDPrintConst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomprinttask
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomPrintTask;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomPrintTask : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	bool FPagesPrepared;
	Lmdprinter::TLMDPrinter* FPrinter;
	Lmdprinter::TLMDPrintRendererBase* FRendererProxy;
	void __fastcall SetPrinter(Lmdprinter::TLMDPrinter* const Value);
	Lmdtypes::TLMDMeasureUnits __fastcall GetUnits(void);
	void __fastcall SetUnits(const Lmdtypes::TLMDMeasureUnits Value);
	Lmdtypes::TLMDMeasureUnits __fastcall GetRealUnits(void);
	
protected:
	Lmdprinter::TLMDPrinter* FUtilPrinter;
	void __fastcall CheckPrinterAssigned(void);
	void __fastcall CheckPagesPrepared(void);
	void __fastcall CheckPagesNotPrepared(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall PreparePagesInternal(int APageWidth, int APageHeight, Vcl::Graphics::TCanvas* ACanvas) = 0 ;
	virtual int __fastcall GetPagesCountInternal(Lmdprinter::TLMDPrintOperationRange ARange) = 0 ;
	virtual void __fastcall DrawPageInternal(Lmdprinter::TLMDPrintOperationRange ARange, int ANum, const System::Types::TPoint &APoint, Vcl::Graphics::TCanvas* ACanvas) = 0 ;
	virtual void __fastcall FinalizePagesInternal(void) = 0 ;
	virtual void __fastcall OnUnitsChanged(Lmdtypes::TLMDMeasureUnits AOldUnits, Lmdtypes::TLMDMeasureUnits ANewUnits);
	__property Lmdtypes::TLMDMeasureUnits Units = {read=GetUnits, write=SetUnits, default=2};
	__property Lmdtypes::TLMDMeasureUnits RealUnits = {read=GetRealUnits, nodefault};
	
public:
	__fastcall virtual TLMDCustomPrintTask(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomPrintTask(void);
	virtual void __fastcall PreparePages(void);
	virtual int __fastcall GetPagesCount(void);
	virtual void __fastcall FinalizePages(void);
	void __fastcall Print(void)/* overload */;
	void __fastcall Print(int AStart, int ACount)/* overload */;
	void __fastcall ExecPrintPreviewDlg(void);
	void __fastcall ExecPrintDlg(void);
	void __fastcall ExecPrintSetupDlg(void);
	void __fastcall ExecPageSetupDlg(void);
	
__published:
	__property Lmdprinter::TLMDPrinter* Printer = {read=FPrinter, write=SetPrinter};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomprinttask */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMPRINTTASK)
using namespace Lmdcustomprinttask;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomprinttaskHPP
