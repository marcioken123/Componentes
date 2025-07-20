// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.Arrow.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Tools_ArrowHPP
#define Fmxtee_Tools_ArrowHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UIConsts.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Graphics.hpp>
#include <System.Types.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Arrow
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPointXY;
class DELPHICLASS TArrowTool;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TPointXY : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Fmxtee::Engine::TCustomChartElement* IOwner;
	int __fastcall GetX();
	int __fastcall GetY();
	void __fastcall SetX(const int Value);
	void __fastcall SetY(const int Value);
	
public:
	System::Types::TPointF Point;
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property int X = {read=GetX, write=SetX, default=0};
	__property int Y = {read=GetY, write=SetY, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TPointXY() { }
	
public:
	/* TObject.Create */ inline __fastcall TPointXY() : System::Classes::TPersistent() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TArrowTool : public Fmxtee::Engine::TTeeCustomTool
{
	typedef Fmxtee::Engine::TTeeCustomTool inherited;
	
private:
	double FAngle;
	bool FDraw2D;
	bool FFilled;
	TPointXY* FFrom;
	int FHeight;
	double FPercent;
	bool FRotateGradient;
	bool FSelected;
	TPointXY* FTo;
	Fmxtee::Canvas::TTeeTransparency FTransp;
	int FWidth;
	int FZ;
	void __fastcall CalcPoints(/* out */ System::Types::TPointF &AFrom, /* out */ System::Types::TPointF &ATo);
	Fmxtee::Canvas::TTeeGradient* __fastcall GetGradient();
	void __fastcall SetAngle(const double Value);
	void __fastcall SetFilled(const bool Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetZ(const int Value);
	void __fastcall SetPercent(const double Value);
	void __fastcall SetRotateGradient(const bool Value);
	void __fastcall SetGradient(Fmxtee::Canvas::TTeeGradient* const Value);
	void __fastcall SetSelected(const bool Value);
	void __fastcall SetDraw2D(const bool Value);
	void __fastcall SetFrom(TPointXY* const Value);
	void __fastcall SetTo(TPointXY* const Value);
	void __fastcall SetTransp(const Fmxtee::Canvas::TTeeTransparency Value);
	
protected:
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TArrowTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TArrowTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	bool __fastcall Clicked(int X, int Y);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property bool Selected = {read=FSelected, write=SetSelected, nodefault};
	
__published:
	__property Active = {default=1};
	__property double Angle = {read=FAngle, write=SetAngle};
	__property Brush;
	__property bool Draw2D = {read=FDraw2D, write=SetDraw2D, default=0};
	__property bool Filled = {read=FFilled, write=SetFilled, default=1};
	__property TPointXY* FromPoint = {read=FFrom, write=SetFrom};
	__property Fmxtee::Canvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
	__property int Height = {read=FHeight, write=SetHeight, default=20};
	__property ParentChart;
	__property Pen;
	__property double Percent = {read=FPercent, write=SetPercent};
	__property bool RotateGradient = {read=FRotateGradient, write=SetRotateGradient, default=1};
	__property TPointXY* ToPoint = {read=FTo, write=SetTo};
	__property Fmxtee::Canvas::TTeeTransparency Transparency = {read=FTransp, write=SetTransp, default=0};
	__property int Width = {read=FWidth, write=SetWidth, default=20};
	__property int Z = {read=FZ, write=SetZ, default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Arrow */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_ARROW)
using namespace Fmxtee::Tools::Arrow;
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
#endif	// Fmxtee_Tools_ArrowHPP
