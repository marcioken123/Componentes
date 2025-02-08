// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPrintToolBar.pas' rev: 31.00 (Windows)

#ifndef LmdprinttoolbarHPP
#define LmdprinttoolbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Forms.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDPrintPreviewPanel.hpp>
#include <LMDShSpinEdit.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdprinttoolbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPrintToolBar;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDPrintToolBarItem : unsigned char { tbPrint, tbPrintSetup, tbPageSettings, tbSave, tbZoom100, tbZoomTextWidth, tbWholePage, tbTwoPages, tbMultiPages, tbZoomOut, tbZoomIn, tbPageFirst, tbPagePrev, tbPageNext, tbPageLast, tbPageSpin, tbScaleCombo, tbClose };

typedef System::Set<TLMDPrintToolBarItem, TLMDPrintToolBarItem::tbPrint, TLMDPrintToolBarItem::tbClose> TLMDPrintToolBarItems;

class PASCALIMPLEMENTATION TLMDPrintToolBar : public Vcl::Extctrls::TPanel
{
	typedef Vcl::Extctrls::TPanel inherited;
	
	
private:
	typedef System::DynamicArray<TLMDPrintToolBarItem> _TLMDPrintToolBar__1;
	
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDPrintToolBarItems FItems;
	Lmdprintpreviewpanel::TLMDPrintChangeLink* FChangeLink;
	Lmdprintpreviewpanel::TLMDPrintPreviewPanel* FPreviewPanel;
	bool FFlat;
	System::Classes::TList* FBtnList;
	Lmdshspinedit::TLMDShSpinEdit* FPageSpin;
	Vcl::Stdctrls::TComboBox* FScaleCombo;
	int FComboCmdStart;
	int FComboCmdEnd;
	_TLMDPrintToolBar__1 FComboCmd;
	Vcl::Dialogs::TSaveDialog* FSaveDlg;
	Vcl::Controls::TImageList* FImgList;
	Vcl::Comctrls::TToolBar* FToolBar;
	void __fastcall SetPreviewPanel(Lmdprintpreviewpanel::TLMDPrintPreviewPanel* AValue);
	void __fastcall SetItems(TLMDPrintToolBarItems AValue);
	void __fastcall SetFlat(bool AValue);
	void __fastcall GetUpdateBar(System::TObject* Sender);
	Vcl::Comctrls::TToolButton* __fastcall GetButton(TLMDPrintToolBarItem AIndex);
	void __fastcall BuildScaleComboStrings(void);
	void __fastcall DoClick(System::TObject* Sender);
	void __fastcall DoScaleComboExit(System::TObject* Sender);
	void __fastcall DoScaleComboKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	int __fastcall ModeToComboIdx(Lmdprintpreviewpanel::TLMDPrintPreviewMode AMode);
	
protected:
	virtual void __fastcall CreateHandle(void);
	void __fastcall GetChange(System::TObject* Sender);
	void __fastcall InitToolBar(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	__property System::Classes::TList* Buttons = {read=FBtnList};
	
public:
	__fastcall virtual TLMDPrintToolBar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDPrintToolBar(void);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	void __fastcall UpdateBar(void);
	__property Vcl::Comctrls::TToolButton* ButtonKind[TLMDPrintToolBarItem AIndex] = {read=GetButton};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property TLMDPrintToolBarItems DisplayItems = {read=FItems, write=SetItems, default=262111};
	__property bool Flat = {read=FFlat, write=SetFlat, default=1};
	__property Lmdprintpreviewpanel::TLMDPrintPreviewPanel* PreviewPanel = {read=FPreviewPanel, write=SetPreviewPanel};
	__property Align = {default=0};
	__property BorderWidth = {default=0};
	__property Color = {default=-16777201};
	__property ParentColor = {default=0};
	__property ShowHint;
	__property ParentShowHint = {default=1};
	__property Visible = {default=1};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDPrintToolBar(HWND ParentWindow) : Vcl::Extctrls::TPanel(ParentWindow) { }
	
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
#define def_LMDPrintToolBarItems (System::Set<TLMDPrintToolBarItem, TLMDPrintToolBarItem::tbPrint, TLMDPrintToolBarItem::tbClose>() << TLMDPrintToolBarItem::tbPrint << TLMDPrintToolBarItem::tbPrintSetup << TLMDPrintToolBarItem::tbPageSettings << TLMDPrintToolBarItem::tbSave << TLMDPrintToolBarItem::tbZoom100 << TLMDPrintToolBarItem::tbWholePage << TLMDPrintToolBarItem::tbTwoPages << TLMDPrintToolBarItem::tbMultiPages << TLMDPrintToolBarItem::tbZoomOut << TLMDPrintToolBarItem::tbZoomIn << TLMDPrintToolBarItem::tbPageFirst << TLMDPrintToolBarItem::tbPagePrev << TLMDPrintToolBarItem::tbPageNext << TLMDPrintToolBarItem::tbPageLast << TLMDPrintToolBarItem::tbPageSpin << TLMDPrintToolBarItem::tbScaleCombo << TLMDPrintToolBarItem::tbClose )
}	/* namespace Lmdprinttoolbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPRINTTOOLBAR)
using namespace Lmdprinttoolbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdprinttoolbarHPP
