// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDThemesSGThemeRenderer.pas' rev: 31.00 (Windows)

#ifndef LmdthemessgthemerendererHPP
#define LmdthemessgthemerendererHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>
#include <LMDThemes.hpp>
#include <LMDThemesSGThemeBase.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdthemessgthemerenderer
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSimpleGradientThemeRenderer;
class DELPHICLASS TLMDSimpleGradientThemeController;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSimpleGradientThemeRenderer : public Lmdthemessgthemebase::TLMDBaseSGThemeRenderer
{
	typedef Lmdthemessgthemebase::TLMDBaseSGThemeRenderer inherited;
	
public:
	__classmethod virtual Lmdthemes::TLMDThemesControllerBase* __fastcall Controller();
	__classmethod virtual void __fastcall Init();
	__classmethod virtual Lmdtypes::TLMDString __fastcall GetThemeRendererName();
public:
	/* TLMDBaseSGThemeRenderer.Create */ inline __fastcall virtual TLMDSimpleGradientThemeRenderer(void) : Lmdthemessgthemebase::TLMDBaseSGThemeRenderer() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDSimpleGradientThemeRenderer(void) { }
	
};


class PASCALIMPLEMENTATION TLMDSimpleGradientThemeController : public Lmdthemes::TLMDThemesControllerBase
{
	typedef Lmdthemes::TLMDThemesControllerBase inherited;
	
private:
	Lmdthemes::TLMDThemesOnDrawCheckMarkEvent FOnDrawCheckMark;
	Lmdthemes::TLMDThemesOnDrawCheckMarkEvent FOnDrawRadioBtn;
	Lmdthemes::TLMDThemesOnDrawScrollThumbGripperEvent FOnDrawScrollThumbGripper;
	Lmdthemes::TLMDThemesOnDrawArrowEvent FOnDrawArrow;
	Lmdthemes::TLMDThemesOnDrawGradientArrowEvent FOnDrawGradientArrow;
	Lmdthemes::TLMDThemesOnDrawSimpleSignEvent FOnDrawPlus;
	Lmdthemes::TLMDThemesOnDrawSimpleSignEvent FOnDrawMinus;
	Lmdthemes::TLMDThemesOnDrawSimpleSignEvent FOnDrawCross;
	
protected:
	virtual Lmdthemes::TLMDThemeRenderer* __fastcall GetThemeRenderer(void);
	virtual void __fastcall RegisterController(void);
	virtual void __fastcall UnregisterController(void);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDSimpleGradientThemeController(System::Classes::TComponent* aOwner);
	
__published:
	__property Lmdthemes::TLMDThemesOnDrawCheckMarkEvent OnDrawCheckMark = {read=FOnDrawCheckMark, write=FOnDrawCheckMark};
	__property Lmdthemes::TLMDThemesOnDrawCheckMarkEvent OnDrawRadioBtn = {read=FOnDrawRadioBtn, write=FOnDrawRadioBtn};
	__property Lmdthemes::TLMDThemesOnDrawScrollThumbGripperEvent OnDrawScrollThumbGripper = {read=FOnDrawScrollThumbGripper, write=FOnDrawScrollThumbGripper};
	__property Lmdthemes::TLMDThemesOnDrawArrowEvent OnDrawArrow = {read=FOnDrawArrow, write=FOnDrawArrow};
	__property Lmdthemes::TLMDThemesOnDrawGradientArrowEvent OnDrawGradientArrow = {read=FOnDrawGradientArrow, write=FOnDrawGradientArrow};
	__property Lmdthemes::TLMDThemesOnDrawSimpleSignEvent OnDrawPlus = {read=FOnDrawPlus, write=FOnDrawPlus};
	__property Lmdthemes::TLMDThemesOnDrawSimpleSignEvent OnDrawMinus = {read=FOnDrawMinus, write=FOnDrawMinus};
	__property Lmdthemes::TLMDThemesOnDrawSimpleSignEvent OnDrawCross = {read=FOnDrawCross, write=FOnDrawCross};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDSimpleGradientThemeController(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDSimpleGradientThemeRenderer* LMDSGThemeRenderer;
extern DELPHI_PACKAGE TLMDSimpleGradientThemeController* LMDSGThemeController;
extern DELPHI_PACKAGE void __fastcall RegisterRenderer(void);
}	/* namespace Lmdthemessgthemerenderer */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTHEMESSGTHEMERENDERER)
using namespace Lmdthemessgthemerenderer;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdthemessgthemerendererHPP
