// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeePageNumTool.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeepagenumtoolHPP
#define Vcltee_TeepagenumtoolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <System.UIConsts.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeTools.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teepagenumtool
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPageNumTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPageNumTool : public Vcltee::Teetools::TAnnotationTool
{
	typedef Vcltee::Teetools::TAnnotationTool inherited;
	
private:
	Vcltee::Tecanvas::TTeePen* FButtonPen;
	bool FButtons;
	int FButtonWidth;
	Vcltee::Tecanvas::TTeeBrush* FDisabledBrush;
	Vcltee::Tecanvas::TTeeBrush* FEnabledBrush;
	System::UnicodeString FFormat;
	bool __fastcall IsFormatStored();
	void __fastcall LeftTriangle(/* out */ Vcltee::Tecanvas::TTrianglePoints &ATriangle);
	void __fastcall RightTriangle(/* out */ Vcltee::Tecanvas::TTrianglePoints &ATriangle);
	void __fastcall SetButtons(bool Value);
	void __fastcall SetButtonWidth(int Value);
	void __fastcall SetDisabledButton(Vcltee::Tecanvas::TTeeGradient* const Value);
	void __fastcall SetEnabledButton(Vcltee::Tecanvas::TTeeGradient* const Value);
	void __fastcall SetFormat(const System::UnicodeString Value);
	void __fastcall SetButtonPen(Vcltee::Tecanvas::TTeePen* const Value);
	Vcltee::Tecanvas::TTeeGradient* __fastcall GetDisabledButton();
	Vcltee::Tecanvas::TTeeGradient* __fastcall GetEnabledButton();
	void __fastcall SetDisabledBrush(Vcltee::Tecanvas::TTeeBrush* const Value);
	void __fastcall SetEnabledBrush(Vcltee::Tecanvas::TTeeBrush* const Value);
	
protected:
	virtual void __fastcall ChartMouseEvent(Vcltee::Teengine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DoDrawText(Vcltee::Teengine::TCustomAxisPanel* const AParent)/* overload */;
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual System::UnicodeString __fastcall GetText();
	virtual System::Types::TRect __fastcall GetTextBounds(Vcltee::Teengine::TCustomAxisPanel* const Panel, const System::Types::TRect &ABounds, /* out */ int &x, /* out */ int &y)/* overload */;
	virtual int __fastcall GetXOffset();
	
public:
	__fastcall virtual TPageNumTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TPageNumTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property Vcltee::Tecanvas::TTeePen* ButtonPen = {read=FButtonPen, write=SetButtonPen};
	__property int ButtonWidth = {read=FButtonWidth, write=SetButtonWidth, default=12};
	__property Vcltee::Tecanvas::TTeeBrush* DisabledBrush = {read=FDisabledBrush, write=SetDisabledBrush};
	__property Vcltee::Tecanvas::TTeeGradient* DisabledButton = {read=GetDisabledButton, write=SetDisabledButton};
	__property Vcltee::Tecanvas::TTeeBrush* EnabledBrush = {read=FEnabledBrush, write=SetEnabledBrush};
	__property Vcltee::Tecanvas::TTeeGradient* EnabledButton = {read=GetEnabledButton, write=SetEnabledButton};
	__property System::UnicodeString Format = {read=FFormat, write=SetFormat, stored=IsFormatStored};
	__property bool ShowButtons = {read=FButtons, write=SetButtons, default=1};
	__property TextAlignment = {default=2};
	/* Hoisted overloads: */
	
protected:
	inline void __fastcall  DoDrawText(){ Vcltee::Teetools::TAnnotationTool::DoDrawText(); }
	inline System::Types::TRect __fastcall  GetTextBounds(/* out */ int &x, /* out */ int &y){ return Vcltee::Teetools::TAnnotationTool::GetTextBounds(x, y); }
	inline System::Types::TRect __fastcall  GetTextBounds(Vcltee::Teengine::TCustomAxisPanel* Panel, /* out */ int &x, /* out */ int &y){ return Vcltee::Teetools::TAnnotationTool::GetTextBounds(Panel, x, y); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teepagenumtool */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEPAGENUMTOOL)
using namespace Vcltee::Teepagenumtool;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeepagenumtoolHPP
