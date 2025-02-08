// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDThemesSGExtThemeRenderer.pas' rev: 31.00 (Windows)

#ifndef LmdthemessgextthemerendererHPP
#define LmdthemessgextthemerendererHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.UxTheme.hpp>
#include <Vcl.Themes.hpp>
#include <Vcl.Graphics.hpp>
#include <System.TypInfo.hpp>
#include <LMDTypes.hpp>
#include <LMDClass.hpp>
#include <LMDThemes.hpp>
#include <LMDGraph.hpp>
#include <LMDGradient.hpp>
#include <LMDThemesCommonTypes.hpp>
#include <LMDThemesSGThemeBase.hpp>
#include <LMDThemesSGThemeRenderer.hpp>
#include <System.Types.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdthemessgextthemerenderer
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSimpleGradientExtThemeRenderer;
class DELPHICLASS TLMDSimpleGradientExtThemeController;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSimpleGradientExtThemeRenderer : public Lmdthemessgthemebase::TLMDBaseSGThemeRenderer
{
	typedef Lmdthemessgthemebase::TLMDBaseSGThemeRenderer inherited;
	
private:
	int FColorBrightnessPercent;
	void __fastcall SetColorBrightnessPercent(const int Value);
	
protected:
	void __fastcall DrawFrame(HDC aDC, const System::Types::TRect &R, System::Uitypes::TColor aColor, Lmdgraph::TLMDFrameSides aFrame);
	virtual void __fastcall DrawGradientFramedRect(HDC DC, const System::Types::TRect &R, System::Types::PRect ClipRect, System::Uitypes::TColor AStartFillColor, System::Uitypes::TColor AEndFillColor, System::Uitypes::TColor AFrameColor, Lmdgraph::TLMDGradientStyle AGradientStyle, System::Word AFlags, Lmdgraph::TLMDFrameSides AFrame = (Lmdgraph::TLMDFrameSides() << Lmdgraph::TLMDFrameSide::fsBottom << Lmdgraph::TLMDFrameSide::fsLeft << Lmdgraph::TLMDFrameSide::fsRight << Lmdgraph::TLMDFrameSide::fsTop ));
	
public:
	__classmethod virtual Lmdthemes::TLMDThemesControllerBase* __fastcall Controller();
	__classmethod virtual void __fastcall Init();
	__classmethod virtual Lmdtypes::TLMDString __fastcall GetThemeRendererName();
	__fastcall virtual TLMDSimpleGradientExtThemeRenderer(void);
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedTab Detail, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedTab Detail, const System::Types::TRect &R, System::Types::PRect ClipRect)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedScrollBar Detail, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedScrollBar Detail, const System::Types::TRect &R, System::Types::PRect ClipRect)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedTrackBar Detail, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedTrackBar Detail, const System::Types::TRect &R, System::Types::PRect ClipRect)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedToolBar Detail, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedToolBar Detail, const System::Types::TRect &R, System::Types::PRect ClipRect)/* overload */;
	__property int ColorBrightnessPercent = {read=FColorBrightnessPercent, write=SetColorBrightnessPercent, default=20};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDSimpleGradientExtThemeRenderer(void) { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedButton Detail, const System::Types::TRect &R){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedButton Detail, const System::Types::TRect &R, System::Types::PRect ClipRect){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R, ClipRect); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedComboBox Detail, const System::Types::TRect &R){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedComboBox Detail, const System::Types::TRect &R, System::Types::PRect ClipRect){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R, ClipRect); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedEdit Detail, const System::Types::TRect &R){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedEdit Detail, const System::Types::TRect &R, System::Types::PRect ClipRect){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R, ClipRect); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedExplorerBar Detail, const System::Types::TRect &R){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedExplorerBar Detail, const System::Types::TRect &R, System::Types::PRect ClipRect){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R, ClipRect); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedProgress Detail, const System::Types::TRect &R){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedProgress Detail, const System::Types::TRect &R, System::Types::PRect ClipRect){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R, ClipRect); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedSpin Detail, const System::Types::TRect &R){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedSpin Detail, const System::Types::TRect &R, System::Types::PRect ClipRect){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R, ClipRect); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedStatus Detail, const System::Types::TRect &R){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedStatus Detail, const System::Types::TRect &R, System::Types::PRect ClipRect){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R, ClipRect); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedToolTip Detail, const System::Types::TRect &R){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedToolTip Detail, const System::Types::TRect &R, System::Types::PRect ClipRect){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R, ClipRect); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedWindow Detail, const System::Types::TRect &R){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedWindow Detail, const System::Types::TRect &R, System::Types::PRect ClipRect){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R, ClipRect); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedListview Detail, const System::Types::TRect &R){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedListview Detail, const System::Types::TRect &R, System::Types::PRect ClipRect){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R, ClipRect); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedHeader Detail, const System::Types::TRect &R){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedHeader Detail, const System::Types::TRect &R, System::Types::PRect ClipRect){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R, ClipRect); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedTreeview Detail, const System::Types::TRect &R){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R); }
	inline void __fastcall  DrawElement(HDC DC, Vcl::Themes::TThemedTreeview Detail, const System::Types::TRect &R, System::Types::PRect ClipRect){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Detail, R, ClipRect); }
	inline void __fastcall  DrawElement(HDC DC, const Vcl::Themes::TThemedElementDetails &Details, const System::Types::TRect &R, System::Types::PRect ClipRect = (System::Types::PRect)(0x0)){ Lmdthemessgthemebase::TLMDBaseSGThemeRenderer::DrawElement(DC, Details, R, ClipRect); }
	
};


class PASCALIMPLEMENTATION TLMDSimpleGradientExtThemeController : public Lmdthemes::TLMDThemesControllerBase
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
	int FColorBrightnessPercent;
	int __fastcall GetColorBrightnessPercent(void);
	void __fastcall SetColorBrightnessPercent(const int Value);
	
protected:
	virtual Lmdthemes::TLMDThemeRenderer* __fastcall GetThemeRenderer(void);
	virtual void __fastcall RegisterController(void);
	virtual void __fastcall UnregisterController(void);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDSimpleGradientExtThemeController(System::Classes::TComponent* aOwner);
	
__published:
	__property Lmdthemes::TLMDThemesOnDrawCheckMarkEvent OnDrawCheckMark = {read=FOnDrawCheckMark, write=FOnDrawCheckMark};
	__property Lmdthemes::TLMDThemesOnDrawScrollThumbGripperEvent OnDrawScrollThumbGripper = {read=FOnDrawScrollThumbGripper, write=FOnDrawScrollThumbGripper};
	__property Lmdthemes::TLMDThemesOnDrawArrowEvent OnDrawArrow = {read=FOnDrawArrow, write=FOnDrawArrow};
	__property Lmdthemes::TLMDThemesOnDrawGradientArrowEvent OnDrawGradientArrow = {read=FOnDrawGradientArrow, write=FOnDrawGradientArrow};
	__property Lmdthemes::TLMDThemesOnDrawSimpleSignEvent OnDrawPlus = {read=FOnDrawPlus, write=FOnDrawPlus};
	__property Lmdthemes::TLMDThemesOnDrawSimpleSignEvent OnDrawMinus = {read=FOnDrawMinus, write=FOnDrawMinus};
	__property Lmdthemes::TLMDThemesOnDrawSimpleSignEvent OnDrawCross = {read=FOnDrawCross, write=FOnDrawCross};
	__property int ColorBrightnessPercent = {read=GetColorBrightnessPercent, write=SetColorBrightnessPercent, default=20};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDSimpleGradientExtThemeController(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 ColorBrightnessPercent = System::Int8(0x14);
extern DELPHI_PACKAGE TLMDSimpleGradientExtThemeRenderer* LMDSGExtThemeRenderer;
extern DELPHI_PACKAGE TLMDSimpleGradientExtThemeController* LMDSGExtThemeController;
extern DELPHI_PACKAGE void __fastcall RegisterRenderer(void);
}	/* namespace Lmdthemessgextthemerenderer */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTHEMESSGEXTTHEMERENDERER)
using namespace Lmdthemessgextthemerenderer;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdthemessgextthemerendererHPP
