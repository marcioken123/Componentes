// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.PageNumber.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Tools_PagenumberHPP
#define Fmxtee_Tools_PagenumberHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Graphics.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Tools.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Pagenumber
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPageNumTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPageNumTool : public Fmxtee::Tools::TAnnotationTool
{
	typedef Fmxtee::Tools::TAnnotationTool inherited;
	
private:
	Fmxtee::Canvas::TTeePen* FButtonPen;
	bool FButtons;
	int FButtonWidth;
	Fmxtee::Canvas::TTeeBrush* FDisabledBrush;
	Fmxtee::Canvas::TTeeBrush* FEnabledBrush;
	System::UnicodeString FFormat;
	bool __fastcall IsFormatStored();
	void __fastcall LeftTriangle(/* out */ Fmxtee::Canvas::TTrianglePoints &ATriangle);
	void __fastcall RightTriangle(/* out */ Fmxtee::Canvas::TTrianglePoints &ATriangle);
	void __fastcall SetButtons(bool Value);
	void __fastcall SetButtonWidth(int Value);
	void __fastcall SetDisabledButton(Fmxtee::Canvas::TTeeGradient* const Value);
	void __fastcall SetEnabledButton(Fmxtee::Canvas::TTeeGradient* const Value);
	void __fastcall SetFormat(const System::UnicodeString Value);
	void __fastcall SetButtonPen(Fmxtee::Canvas::TTeePen* const Value);
	Fmxtee::Canvas::TTeeGradient* __fastcall GetDisabledButton();
	Fmxtee::Canvas::TTeeGradient* __fastcall GetEnabledButton();
	void __fastcall SetDisabledBrush(Fmxtee::Canvas::TTeeBrush* const Value);
	void __fastcall SetEnabledBrush(Fmxtee::Canvas::TTeeBrush* const Value);
	
protected:
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DoDrawText(Fmxtee::Engine::TCustomAxisPanel* const AParent)/* overload */;
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual System::UnicodeString __fastcall GetText();
	virtual System::Types::TRectF __fastcall GetTextBounds(Fmxtee::Engine::TCustomAxisPanel* const Panel, const System::Types::TRectF &ABounds, /* out */ int &x, /* out */ int &y)/* overload */;
	virtual int __fastcall GetXOffset();
	
public:
	__fastcall virtual TPageNumTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TPageNumTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property Fmxtee::Canvas::TTeePen* ButtonPen = {read=FButtonPen, write=SetButtonPen};
	__property int ButtonWidth = {read=FButtonWidth, write=SetButtonWidth, default=12};
	__property Fmxtee::Canvas::TTeeBrush* DisabledBrush = {read=FDisabledBrush, write=SetDisabledBrush};
	__property Fmxtee::Canvas::TTeeGradient* DisabledButton = {read=GetDisabledButton, write=SetDisabledButton};
	__property Fmxtee::Canvas::TTeeBrush* EnabledBrush = {read=FEnabledBrush, write=SetEnabledBrush};
	__property Fmxtee::Canvas::TTeeGradient* EnabledButton = {read=GetEnabledButton, write=SetEnabledButton};
	__property System::UnicodeString Format = {read=FFormat, write=SetFormat, stored=IsFormatStored};
	__property bool ShowButtons = {read=FButtons, write=SetButtons, default=1};
	__property TextAlignment = {default=2};
	/* Hoisted overloads: */
	
protected:
	inline void __fastcall  DoDrawText(){ Fmxtee::Tools::TAnnotationTool::DoDrawText(); }
	inline System::Types::TRectF __fastcall  GetTextBounds(/* out */ int &x, /* out */ int &y){ return Fmxtee::Tools::TAnnotationTool::GetTextBounds(x, y); }
	inline System::Types::TRectF __fastcall  GetTextBounds(Fmxtee::Engine::TCustomAxisPanel* Panel, /* out */ int &x, /* out */ int &y){ return Fmxtee::Tools::TAnnotationTool::GetTextBounds(Panel, x, y); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Pagenumber */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_PAGENUMBER)
using namespace Fmxtee::Tools::Pagenumber;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS)
using namespace Fmxtee::Tools;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Tools_PagenumberHPP
