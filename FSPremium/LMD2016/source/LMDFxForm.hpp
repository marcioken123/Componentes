// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFxForm.pas' rev: 31.00 (Windows)

#ifndef LmdfxformHPP
#define LmdfxformHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <LMDFxBitmap.hpp>
#include <LMDFxEffect.hpp>
#include <LMDFxAnimation.hpp>
#include <LMDFxUtils.hpp>
#include <LMDFxImageList.hpp>
#include <LMDFxBase.hpp>
#include <LMDCustomComponent.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfxform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFxAnimationForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFxAnimationForm : public Lmdfxbase::TLMDFxComponent
{
	typedef Lmdfxbase::TLMDFxComponent inherited;
	
private:
	Vcl::Graphics::TPicture* FMask;
	System::Uitypes::TColor FMaskColor;
	Lmdfxutils::TLMDFxMaskMode FMaskMode;
	Lmdfxanimation::TLMDFxAnimation* FShowAnimation;
	bool FShowAnimationComplete;
	Lmdfxbitmap::TLMDFxBitmap* FDesktopImage;
	HRGN FRegion;
	HRGN FCopyRegion;
	System::Classes::TWndMethod FPrevWndProc;
	void __fastcall FormWndProc(Winapi::Messages::TMessage &Msg);
	void __fastcall SetMask(Vcl::Graphics::TPicture* const Value);
	void __fastcall SetShowAnimation(Lmdfxanimation::TLMDFxAnimation* const Value);
	
protected:
	void __fastcall AdjustSizeByMask(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall PrepareShowAnimation(void);
	void __fastcall FinishShowAnimation(void);
	
public:
	__fastcall virtual TLMDFxAnimationForm(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFxAnimationForm(void);
	__property HRGN Region = {read=FCopyRegion, nodefault};
	
__published:
	__property Vcl::Graphics::TPicture* Mask = {read=FMask, write=SetMask};
	__property System::Uitypes::TColor MaskColor = {read=FMaskColor, write=FMaskColor, nodefault};
	__property Lmdfxutils::TLMDFxMaskMode MaskMode = {read=FMaskMode, write=FMaskMode, nodefault};
	__property Lmdfxanimation::TLMDFxAnimation* ShowAnimation = {read=FShowAnimation, write=SetShowAnimation};
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word CM_FINISHANIMATION = System::Word(0xb1b0);
extern DELPHI_PACKAGE TLMDFxAnimationForm* __fastcall FindAnimationForm(Vcl::Forms::TCustomForm* AForm);
}	/* namespace Lmdfxform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFXFORM)
using namespace Lmdfxform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfxformHPP
