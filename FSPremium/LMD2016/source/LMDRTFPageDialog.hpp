// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFPageDialog.pas' rev: 31.00 (Windows)

#ifndef LmdrtfpagedialogHPP
#define LmdrtfpagedialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Winapi.CommDlg.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Printers.hpp>
#include <LMDRTFBase.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfpagedialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRichPageSetupDialog;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDRichPageType : unsigned char { ptEnvelope, ptPaper };

enum DECLSPEC_DENUM TLMDRichPageSetupDialogOption : unsigned char { psoDefaultMinMargins, psoIgnoreMinMargins, psoDisableMargins, psoDisableOrientation, psoDisablePagePainting, psoDisablePaper, psoDisablePrinter, psoShowHelp, psoNoWarning, psoNoNetworkButton };

typedef System::Set<TLMDRichPageSetupDialogOption, TLMDRichPageSetupDialogOption::psoDefaultMinMargins, TLMDRichPageSetupDialogOption::psoNoNetworkButton> TLMDRichPageSetupDialogOptions;

typedef void __fastcall (__closure *TLMDRichPageSetupBeforePaintEvent)(System::TObject* Sender, short PaperSize, System::Uitypes::TPrinterOrientation Orientation, TLMDRichPageType PageType, bool &DoneDrawing);

typedef void __fastcall (__closure *TLMDRichPaintPageEvent)(System::TObject* Sender, NativeUInt Handle, const System::Types::TRect &PageRect, bool &DoneDrawing);

class PASCALIMPLEMENTATION TLMDRichPageSetupDialog : public Vcl::Dialogs::TCommonDialog
{
	typedef Vcl::Dialogs::TCommonDialog inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	Lmdrtfbase::TLMDRichPageMargins* FMargin;
	Lmdrtfbase::TLMDRichPageMargins* FMinMargin;
	double FPageWidth;
	double FPageHeight;
	Lmdrtfbase::TLMDRichDialogPosition FDlgPosition;
	TLMDRichPageSetupDialogOptions FOptions;
	Lmdtypes::TLMDUnits FUnits;
	TLMDRichPageSetupBeforePaintEvent FBeforePaint;
	TLMDRichPaintPageEvent FOnDrawRetAddress;
	TLMDRichPaintPageEvent FOnDrawMinMargin;
	TLMDRichPaintPageEvent FOnDrawEnvStamp;
	TLMDRichPaintPageEvent FOnDrawFullPage;
	TLMDRichPaintPageEvent FOnDrawGreekText;
	TLMDRichPaintPageEvent FOnDrawMargin;
	void __fastcall SetUnits(Lmdtypes::TLMDUnits aValue);
	void __fastcall SetMargin(int index, Lmdrtfbase::TLMDRichPageMargins* aValue);
	
protected:
	HWND __fastcall GetDlgParentHandle(void);
	
public:
	__fastcall virtual TLMDRichPageSetupDialog(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDRichPageSetupDialog(void);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	bool __fastcall GetDefaults(void);
	bool __fastcall GetMinMarginDefaults(void);
	virtual bool __fastcall Execute(void)/* overload */;
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Lmdrtfbase::TLMDRichDialogPosition DlgPosition = {read=FDlgPosition, write=FDlgPosition, default=0};
	__property Lmdrtfbase::TLMDRichPageMargins* Margin = {read=FMargin, write=SetMargin, index=0};
	__property Lmdrtfbase::TLMDRichPageMargins* MinMargin = {read=FMinMargin, write=SetMargin, index=1};
	__property TLMDRichPageSetupDialogOptions Options = {read=FOptions, write=FOptions, default=1};
	__property double PageWidth = {read=FPageWidth, write=FPageWidth};
	__property double PageHeight = {read=FPageHeight, write=FPageHeight};
	__property Lmdtypes::TLMDUnits Units = {read=FUnits, write=SetUnits, default=2};
	__property TLMDRichPageSetupBeforePaintEvent OnBeforePaint = {read=FBeforePaint, write=FBeforePaint};
	__property TLMDRichPaintPageEvent OnDrawFullPage = {read=FOnDrawFullPage, write=FOnDrawFullPage};
	__property TLMDRichPaintPageEvent OnDrawMinMargin = {read=FOnDrawMinMargin, write=FOnDrawMinMargin};
	__property TLMDRichPaintPageEvent OnDrawMargin = {read=FOnDrawMargin, write=FOnDrawMargin};
	__property TLMDRichPaintPageEvent OnDrawGreekText = {read=FOnDrawGreekText, write=FOnDrawGreekText};
	__property TLMDRichPaintPageEvent OnDrawEnvStamp = {read=FOnDrawEnvStamp, write=FOnDrawEnvStamp};
	__property TLMDRichPaintPageEvent OnDrawRetAddress = {read=FOnDrawRetAddress, write=FOnDrawRetAddress};
	/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(HWND ParentWnd){ return Vcl::Dialogs::TCommonDialog::Execute(ParentWnd); }
	
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


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtfpagedialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFPAGEDIALOG)
using namespace Lmdrtfpagedialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfpagedialogHPP
