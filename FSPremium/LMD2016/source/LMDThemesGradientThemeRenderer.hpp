// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDThemesGradientThemeRenderer.pas' rev: 31.00 (Windows)

#ifndef LmdthemesgradientthemerendererHPP
#define LmdthemesgradientthemerendererHPP

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
#include <LMDThemesGradientThemeBase.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdthemesgradientthemerenderer
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDGradientThemeRenderer;
class DELPHICLASS TLMDThemesGradientThemeController;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDGradientThemeRenderer : public Lmdthemesgradientthemebase::TLMDBaseGradientThemeRenderer
{
	typedef Lmdthemesgradientthemebase::TLMDBaseGradientThemeRenderer inherited;
	
public:
	__classmethod virtual Lmdthemes::TLMDThemesControllerBase* __fastcall Controller();
	__classmethod virtual void __fastcall Init();
	__classmethod virtual Lmdtypes::TLMDString __fastcall GetThemeRendererName();
public:
	/* TLMDBaseGradientThemeRenderer.Create */ inline __fastcall virtual TLMDGradientThemeRenderer(void) : Lmdthemesgradientthemebase::TLMDBaseGradientThemeRenderer() { }
	/* TLMDBaseGradientThemeRenderer.Destroy */ inline __fastcall virtual ~TLMDGradientThemeRenderer(void) { }
	
};


class PASCALIMPLEMENTATION TLMDThemesGradientThemeController : public Lmdthemes::TLMDThemesControllerBase
{
	typedef Lmdthemes::TLMDThemesControllerBase inherited;
	
private:
	Lmdthemes::TLMDThemesOnDrawElement FOnDrawElement;
	Lmdthemes::TLMDThemesOnDrawCheckMarkEvent FOnDrawCheckMark;
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
	__fastcall virtual TLMDThemesGradientThemeController(System::Classes::TComponent* aOwner);
	
__published:
	__property Lmdthemes::TLMDThemesOnDrawElement OnDrawElement = {read=FOnDrawElement, write=FOnDrawElement};
	__property Lmdthemes::TLMDThemesOnDrawCheckMarkEvent OnDrawCheckMark = {read=FOnDrawCheckMark, write=FOnDrawCheckMark};
	__property Lmdthemes::TLMDThemesOnDrawScrollThumbGripperEvent OnDrawScrollThumbGripper = {read=FOnDrawScrollThumbGripper, write=FOnDrawScrollThumbGripper};
	__property Lmdthemes::TLMDThemesOnDrawArrowEvent OnDrawArrow = {read=FOnDrawArrow, write=FOnDrawArrow};
	__property Lmdthemes::TLMDThemesOnDrawGradientArrowEvent OnDrawGradientArrow = {read=FOnDrawGradientArrow, write=FOnDrawGradientArrow};
	__property Lmdthemes::TLMDThemesOnDrawSimpleSignEvent OnDrawPlus = {read=FOnDrawPlus, write=FOnDrawPlus};
	__property Lmdthemes::TLMDThemesOnDrawSimpleSignEvent OnDrawMinus = {read=FOnDrawMinus, write=FOnDrawMinus};
	__property Lmdthemes::TLMDThemesOnDrawSimpleSignEvent OnDrawCross = {read=FOnDrawCross, write=FOnDrawCross};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDThemesGradientThemeController(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDGradientThemeRenderer* LMDGradientThemeRenderer;
extern DELPHI_PACKAGE TLMDThemesGradientThemeController* LMDGradientThemeController;
extern DELPHI_PACKAGE void __fastcall RegisterRenderer(void);
}	/* namespace Lmdthemesgradientthemerenderer */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTHEMESGRADIENTTHEMERENDERER)
using namespace Lmdthemesgradientthemerenderer;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdthemesgradientthemerendererHPP
