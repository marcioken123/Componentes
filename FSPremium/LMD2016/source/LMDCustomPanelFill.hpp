// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomPanelFill.pas' rev: 31.00 (Windows)

#ifndef LmdcustompanelfillHPP
#define LmdcustompanelfillHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <LMDGraph.hpp>
#include <LMDFillObject.hpp>
#include <LMD3DCaption.hpp>
#include <LMDFXCaption.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustompanelfill
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomPanelFill;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomPanelFill : public Lmdcustomparentpanel::TLMDCustomParentPanel
{
	typedef Lmdcustomparentpanel::TLMDCustomParentPanel inherited;
	
private:
	Lmdgraph::TLMDAlignment FAlignment;
	Lmdfxcaption::TLMDFxCaption* FFontFx;
	Lmdfillobject::TLMDFillObject* FFillObject;
	bool FTransparentBorder;
	void __fastcall SetAlignment(Lmdgraph::TLMDAlignment aValue);
	void __fastcall SetCaptionFx(Lmdfxcaption::TLMDFxCaption* aValue);
	void __fastcall SetFillObject(Lmdfillobject::TLMDFillObject* aValue);
	void __fastcall SetTransparentBorder(bool aValue);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall AdjustClientRect(System::Types::TRect &Rect);
	virtual void __fastcall CreateBack(bool aValue);
	HIDESBASE void __fastcall DrawBack(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &aRect);
	virtual void __fastcall DrawCaption(const System::Types::TRect &aRect, Lmdgraph::TLMDAlignment aAlignment);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	virtual bool __fastcall GetEmpty(void);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall MouseEnter(void);
	virtual void __fastcall MouseExit(void);
	virtual Lmdfillobject::TLMDFillObject* __fastcall GetFillObject(void);
	virtual Lmd3dcaption::TLMD3DCaption* __fastcall GetFont3D(void);
	__property Lmdgraph::TLMDAlignment Alignment = {read=FAlignment, write=SetAlignment, default=4};
	__property Lmdfxcaption::TLMDFxCaption* FontFX = {read=FFontFx, write=SetCaptionFx};
	
public:
	__fastcall virtual TLMDCustomPanelFill(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomPanelFill(void);
	__property Lmdfillobject::TLMDFillObject* FillObject = {read=FFillObject, write=SetFillObject};
	__property bool TransparentBorder = {read=FTransparentBorder, write=SetTransparentBorder, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomPanelFill(HWND ParentWindow) : Lmdcustomparentpanel::TLMDCustomParentPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustompanelfill */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMPANELFILL)
using namespace Lmdcustompanelfill;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustompanelfillHPP
