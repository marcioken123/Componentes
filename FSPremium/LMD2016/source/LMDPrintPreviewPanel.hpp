// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPrintPreviewPanel.pas' rev: 31.00 (Windows)

#ifndef LmdprintpreviewpanelHPP
#define LmdprintpreviewpanelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Math.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Printers.hpp>
#include <Vcl.ToolWin.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Buttons.hpp>
#include <LMDPrinter.hpp>
#include <LMDShSpinEdit.hpp>
#include <LMDTypes.hpp>
#include <LMDCustomControl.hpp>
#include <intfLMDBase.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdprintpreviewpanel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPrintChangeLink;
class DELPHICLASS TLMDPrintPreviewPanel;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDPrintPreviewMode : unsigned char { pmExactScale, pmWholePage, pmTextWidth, pmTwoPages, pmExactMultiPages };

class PASCALIMPLEMENTATION TLMDPrintChangeLink : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDPrintPreviewPanel* FSender;
	System::Classes::TNotifyEvent FOnChange;
	
public:
	__fastcall virtual ~TLMDPrintChangeLink(void);
	DYNAMIC void __fastcall Change(void);
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TLMDPrintPreviewPanel* Sender = {read=FSender, write=FSender};
public:
	/* TObject.Create */ inline __fastcall TLMDPrintChangeLink(void) : System::TObject() { }
	
};


enum DECLSPEC_DENUM TLMDPrintPreviewChange : unsigned char { pcMode, pcScale, pcCurrentPage, pcScroll, pcResize };

class PASCALIMPLEMENTATION TLMDPrintPreviewPanel : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
	
private:
	typedef System::DynamicArray<System::Types::TRect> _TLMDPrintPreviewPanel__1;
	
	typedef System::DynamicArray<int> _TLMDPrintPreviewPanel__2;
	
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	System::Classes::TList* FClients;
	System::Classes::TNotifyEvent FOnChange;
	Vcl::Stdctrls::TScrollBar* FHScroll;
	Vcl::Stdctrls::TScrollBar* FVScroll;
	Vcl::Controls::TCustomControl* FPaintPanel;
	int FScale;
	int FRealScale;
	int FCurrentPage;
	int FTotalPages;
	int FHorzPages;
	int FVertPages;
	int FPagePanels;
	_TLMDPrintPreviewPanel__1 FPageRects;
	_TLMDPrintPreviewPanel__2 FPageRectsNumbers;
	double FPrinterFullWidthMM;
	double FPrinterFullHeightMM;
	Lmdprinter::TLMDPrinterHelper* FPrinterHlp;
	Lmdprinter::TLMDPrinterBase* FPrinter;
	int FMargin;
	Lmdprinter::TLMDPrinterListener* FLst;
	TLMDPrintPreviewMode FMode;
	Vcl::Graphics::TBitmap* FBmp;
	bool FHandleCreated;
	bool FDestroing;
	int FMouseWheelAcc;
	void __fastcall SetPagesNum(int ANum);
	void __fastcall ClearPageRects(void);
	void __fastcall CheckPrinterAssigned(void);
	void __fastcall SetPrinterHelper(Lmdprinter::TLMDPrinterHelper* AValue);
	void __fastcall SetCurrentPage(int AValue);
	void __fastcall SetMargin(int AValue);
	void __fastcall SetScale(int AValue);
	void __fastcall SetMode(TLMDPrintPreviewMode AValue);
	void __fastcall ScrollChange(System::TObject* ASender);
	void __fastcall PaintContent(void);
	
protected:
	void __fastcall UpdateScaleMode(TLMDPrintPreviewChange AChange);
	void __fastcall DoPanelKeyDown(System::Word Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWindowHandle(const Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall DestroyWindowHandle(void);
	DYNAMIC bool __fastcall DoMouseWheel(System::Classes::TShiftState Shift, int WheelDelta, const System::Types::TPoint &MousePos);
	
public:
	__fastcall virtual TLMDPrintPreviewPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDPrintPreviewPanel(void);
	void __fastcall ResetVars(void);
	void __fastcall Change(void);
	void __fastcall RegisterChanges(TLMDPrintChangeLink* AValue);
	void __fastcall UnRegisterChanges(TLMDPrintChangeLink* AValue);
	void __fastcall SetMultiPages(int AHorzPages, int AVertPages, bool ADoChangeMode);
	void __fastcall Zoom(bool AZoomIn);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	__property Lmdprinter::TLMDPrinterHelper* PrinterHelper = {read=FPrinterHlp, write=SetPrinterHelper};
	__property int TotalPages = {read=FTotalPages, nodefault};
	__property int CurrentPage = {read=FCurrentPage, write=SetCurrentPage, nodefault};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property int Scale = {read=FScale, write=SetScale, nodefault};
	__property int RealScale = {read=FRealScale, nodefault};
	__property TLMDPrintPreviewMode Mode = {read=FMode, write=SetMode, nodefault};
	__property int Margin = {read=FMargin, write=SetMargin, default=20};
	__property Align = {default=0};
	__property Color = {default=-16777200};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property OnResize;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDPrintPreviewPanel(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
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
extern DELPHI_PACKAGE System::StaticArray<int, 8> LMDPrintZoomValues;
static const System::Int8 LMDPrintPreviewDefaultMargin = System::Int8(0x14);
}	/* namespace Lmdprintpreviewpanel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPRINTPREVIEWPANEL)
using namespace Lmdprintpreviewpanel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdprintpreviewpanelHPP
