// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDIdeAlignPltte.pas' rev: 31.00 (Windows)

#ifndef LmdidealignpltteHPP
#define LmdidealignpltteHPP

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
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Buttons.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDSvcPvdr.hpp>
#include <LMDDsgDesigner.hpp>
#include <LMDIdeCst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdidealignpltte
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDAlignPaletteForm;
class DELPHICLASS TLMDAlignPalette;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDAlignPaletteForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Buttons::TSpeedButton* btnHorzCenter;
	Vcl::Buttons::TSpeedButton* btnLeft;
	Vcl::Buttons::TSpeedButton* btnHorzCenterInWindow;
	Vcl::Buttons::TSpeedButton* btnHorzSpaceEqually;
	Vcl::Buttons::TSpeedButton* btnRight;
	Vcl::Buttons::TSpeedButton* btnVertCenter;
	Vcl::Buttons::TSpeedButton* btnTop;
	Vcl::Buttons::TSpeedButton* btnVertCenterInWindow;
	Vcl::Buttons::TSpeedButton* btnVertSpaceEqually;
	Vcl::Buttons::TSpeedButton* btnBottom;
	void __fastcall btnsClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	TLMDAlignPalette* FPalette;
	void __fastcall DoAlign(Lmddsgdesigner::TLMDDesignerAlignType AHorzAlign, Lmddsgdesigner::TLMDDesignerAlignType AVertAlign);
	Lmdtypes::TLMDString __fastcall GetButtonHint(int ATag);
	
public:
	__fastcall TLMDAlignPaletteForm(TLMDAlignPalette* APalette);
	__fastcall virtual ~TLMDAlignPaletteForm(void);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDAlignPaletteForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDAlignPaletteForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDAlignPalette : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDAlignPaletteForm* FForm;
	int FFormTop;
	int FFormLeft;
	bool FVisible;
	Lmddsgdesigner::TLMDDesigner* FDesigner;
	Lmdsvcpvdr::TLMDServiceProvider* FServiceProvider;
	bool FAlwaysOnTop;
	void __fastcall SetDesigner(Lmddsgdesigner::TLMDDesigner* const Value);
	void __fastcall SetFormLeft(const int Value);
	void __fastcall SetServiceProvider(Lmdsvcpvdr::TLMDServiceProvider* const Value);
	void __fastcall SetFormTop(const int Value);
	void __fastcall SetVisible(const bool Value);
	bool __fastcall GetVisible(void);
	int __fastcall GetFormLeft(void);
	int __fastcall GetFormTop(void);
	void __fastcall SetAlwaysOnTop(const bool Value);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDAlignPalette(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDAlignPalette(void);
	void __fastcall Show(void);
	void __fastcall Hide(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Lmddsgdesigner::TLMDDesigner* Designer = {read=FDesigner, write=SetDesigner};
	__property Lmdsvcpvdr::TLMDServiceProvider* ServiceProvider = {read=FServiceProvider, write=SetServiceProvider};
	__property int FormLeft = {read=GetFormLeft, write=SetFormLeft, default=0};
	__property int FormTop = {read=GetFormTop, write=SetFormTop, default=0};
	__property bool Visible = {read=GetVisible, write=SetVisible, default=0};
	__property bool AlwaysOnTop = {read=FAlwaysOnTop, write=SetAlwaysOnTop, default=0};
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
}	/* namespace Lmdidealignpltte */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIDEALIGNPLTTE)
using namespace Lmdidealignpltte;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdidealignpltteHPP
