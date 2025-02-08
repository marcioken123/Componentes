// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwframe.pas' rev: 6.00

#ifndef wwframeHPP
#define wwframeHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <TypInfo.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwframe
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TwwComboButtonStyle { cbsEllipsis, cbsDownArrow, cbsCustom };
#pragma option pop

class DELPHICLASS TwwButtonEffects;
class PASCALIMPLEMENTATION TwwButtonEffects : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FTransparent;
	bool FFlat;
	void __fastcall SetTransparent(bool val);
	void __fastcall SetFlat(bool val);
	
protected:
	virtual void __fastcall Refresh(void);
	
public:
	Controls::TControl* Control;
	Controls::TControl* Button;
	__fastcall TwwButtonEffects(Classes::TComponent* Owner, Controls::TControl* AButton);
	/*         class method */ static TwwButtonEffects* __fastcall Get(TMetaClass* vmt, Controls::TControl* Control);
	
__published:
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwButtonEffects(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TwwEditFocusStyle { efsFrameBox, efsFrameSunken, efsFrameRaised, efsFrameEtched, efsFrameBump, efsFrameSingle };
#pragma option pop

#pragma option push -b-
enum TwwEditFrameEnabledType { efLeftBorder, efTopBorder, efRightBorder, efBottomBorder };
#pragma option pop

typedef Set<TwwEditFrameEnabledType, efLeftBorder, efBottomBorder>  TwwEditFrameEnabledSet;

class DELPHICLASS TwwEditFrame;
class PASCALIMPLEMENTATION TwwEditFrame : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Controls::TWinControl* Control;
	bool FEnabled;
	TwwEditFrameEnabledSet FNonFocusBorders;
	TwwEditFrameEnabledSet FFocusBorders;
	TwwEditFocusStyle FFocusStyle;
	TwwEditFocusStyle FNonFocusStyle;
	int FNonFocusTextOffsetX;
	int FNonFocusTextOffsetY;
	bool FTransparent;
	bool FTransparentClearsBackground;
	bool FMouseEnterSameAsFocus;
	int FAutoSizeHeightAdjust;
	Graphics::TColor FNonFocusTransparentFontColor;
	Graphics::TColor FNonFocusColor;
	Graphics::TColor FNonFocusFontColor;
	void __fastcall SetFocusBorders(TwwEditFrameEnabledSet val);
	void __fastcall SetNonFocusBorders(TwwEditFrameEnabledSet val);
	void __fastcall SetNonFocusStyle(TwwEditFocusStyle val);
	void __fastcall SetEnabled(bool val);
	void __fastcall SetTransparent(bool val);
	void __fastcall CheckParentClipping(void);
	
public:
	bool CreateTransparent;
	int __fastcall NCPaint(bool FFocused, bool AlwaysTransparent = false, HDC adc = (HDC)(0x0));
	bool __fastcall IsSingleBorderStyle(TwwEditFocusStyle Style);
	__fastcall TwwEditFrame(Classes::TComponent* Owner);
	void __fastcall GetEditRectForFrame(Types::TRect &Loc);
	void __fastcall RefreshTransparentText(bool InvalidateBorders = false, bool UseEditRect = true, bool Exiting = false);
	void __fastcall RefreshControl(void);
	void __fastcall AdjustHeight(void);
	bool __fastcall IsFrameEffective(void);
	virtual void __fastcall GetFrameTextPosition(int &Left, int &Indent, bool Focused = false);
	/*         class method */ static TwwEditFrame* __fastcall Get(TMetaClass* vmt, Controls::TControl* Control);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall AssignAll(Classes::TPersistent* Source, bool SkipOptimize = true);
	__property bool TransparentClearsBackground = {read=FTransparentClearsBackground, write=FTransparentClearsBackground, default=0};
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property int AutoSizeHeightAdjust = {read=FAutoSizeHeightAdjust, write=FAutoSizeHeightAdjust, default=0};
	__property TwwEditFrameEnabledSet FocusBorders = {read=FFocusBorders, write=SetFocusBorders, default=15};
	__property TwwEditFrameEnabledSet NonFocusBorders = {read=FNonFocusBorders, write=SetNonFocusBorders, default=8};
	__property TwwEditFocusStyle FocusStyle = {read=FFocusStyle, write=FFocusStyle, default=0};
	__property TwwEditFocusStyle NonFocusStyle = {read=FNonFocusStyle, write=SetNonFocusStyle, default=0};
	__property int NonFocusTextOffsetX = {read=FNonFocusTextOffsetX, write=FNonFocusTextOffsetX, default=0};
	__property int NonFocusTextOffsetY = {read=FNonFocusTextOffsetY, write=FNonFocusTextOffsetY, default=0};
	__property Graphics::TColor NonFocusTransparentFontColor = {read=FNonFocusTransparentFontColor, write=FNonFocusTransparentFontColor, default=536870911};
	__property Graphics::TColor NonFocusColor = {read=FNonFocusColor, write=FNonFocusColor, default=536870911};
	__property Graphics::TColor NonFocusFontColor = {read=FNonFocusFontColor, write=FNonFocusFontColor, default=536870911};
	__property bool MouseEnterSameAsFocus = {read=FMouseEnterSameAsFocus, write=FMouseEnterSameAsFocus, default=0};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwEditFrame(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwframe)
extern PACKAGE bool __fastcall wwIsTransparentParent(Controls::TControl* control);
extern PACKAGE void __fastcall wwDrawEdge(Controls::TWinControl* Control, TwwEditFrame* Frame, Graphics::TCanvas* Canvas, bool Focused)/* overload */;
extern PACKAGE void __fastcall wwDrawEdge(Controls::TWinControl* Control, TwwEditFrame* Frame, HDC DC, bool Focused)/* overload */;
extern PACKAGE void __fastcall wwInvalidateTransparentArea2(Controls::TControl* control, bool Exiting, bool TransparentClearsBackground);
extern PACKAGE void __fastcall wwInvalidateTransparentArea(Controls::TControl* control, bool Exiting);

}	/* namespace Wwframe */
using namespace Wwframe;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwframe
