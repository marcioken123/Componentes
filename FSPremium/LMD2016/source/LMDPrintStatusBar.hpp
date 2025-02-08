// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPrintStatusBar.pas' rev: 31.00 (Windows)

#ifndef LmdprintstatusbarHPP
#define LmdprintstatusbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCustomStatusBar.hpp>
#include <LMDPrintPreviewPanel.hpp>
#include <LMDTypes.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDControl.hpp>
#include <LMDGraph.hpp>
#include <LMD3DCaption.hpp>
#include <LMDBevel.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdprintstatusbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPrintStatusBar;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDPrintStatusPanel : unsigned char { pspPage, pspScale, pspPageSize, pspOrientation };

typedef System::Set<TLMDPrintStatusPanel, TLMDPrintStatusPanel::pspPage, TLMDPrintStatusPanel::pspOrientation> TLMDPrintStatusPanels;

class PASCALIMPLEMENTATION TLMDPrintStatusBar : public Lmdcustomstatusbar::TLMDCustomStatusBar
{
	typedef Lmdcustomstatusbar::TLMDCustomStatusBar inherited;
	
private:
	Lmdprintpreviewpanel::TLMDPrintPreviewPanel* FPreviewPanel;
	Lmdprintpreviewpanel::TLMDPrintChangeLink* FChangeLink;
	TLMDPrintStatusPanels FPanels;
	void __fastcall SetPreviewPanel(Lmdprintpreviewpanel::TLMDPrintPreviewPanel* AValue);
	HIDESBASE void __fastcall SetPanels(TLMDPrintStatusPanels AValue);
	void __fastcall GetUpdateBar(System::TObject* Sender);
	Lmdcustomstatusbar::TLMDStatusPanel* __fastcall GetPanel(TLMDPrintStatusPanel AIndex);
	
protected:
	void __fastcall InitStatusBar(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDPrintStatusBar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDPrintStatusBar(void);
	void __fastcall UpdateBar(void);
	__property CtlXP = {default=1};
	__property Lmdcustomstatusbar::TLMDStatusPanel* InfoPanel[TLMDPrintStatusPanel Index] = {read=GetPanel};
	
__published:
	__property Lmdprintpreviewpanel::TLMDPrintPreviewPanel* PreviewPanel = {read=FPreviewPanel, write=SetPreviewPanel};
	__property Alignment = {default=0};
	__property Font3D;
	__property SizeGrip = {default=1};
	__property ControlGap = {default=0};
	__property Bevel;
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property TLMDPrintStatusPanels InfoPanels = {read=FPanels, write=SetPanels, default=15};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDPrintStatusBar(HWND ParentWindow) : Lmdcustomstatusbar::TLMDCustomStatusBar(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define def_PrintStatusPanels (System::Set<TLMDPrintStatusPanel, TLMDPrintStatusPanel::pspPage, TLMDPrintStatusPanel::pspOrientation>() << TLMDPrintStatusPanel::pspPage << TLMDPrintStatusPanel::pspScale << TLMDPrintStatusPanel::pspPageSize << TLMDPrintStatusPanel::pspOrientation )
}	/* namespace Lmdprintstatusbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPRINTSTATUSBAR)
using namespace Lmdprintstatusbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdprintstatusbarHPP
