// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeSVGCanvas.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeesvgcanvasHPP
#define Vcltee_TeesvgcanvasHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeExport.hpp>
#include <System.Math.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teesvgcanvas
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSVGCanvas;
class DELPHICLASS TSVGExportFormat;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSVGCanvas : public Vcltee::Tecanvas::TTeeNeutralCanvas
{
	typedef Vcltee::Tecanvas::TTeeNeutralCanvas inherited;
	
private:
	int FX;
	int FY;
	System::Classes::TStrings* FStrings;
	int IClipCount;
	int IClipStack;
	int IGradientCount;
	void __fastcall Add(const System::UnicodeString S);
	void __fastcall AddEnd(const System::UnicodeString s);
	void __fastcall InternalRect(const System::Types::TRect &Rect, bool UsePen, int RoundX = 0x0, int RoundY = 0x0);
	System::UnicodeString __fastcall PointToStr(const int X, const int Y);
	void __fastcall PrepareShape();
	System::UnicodeString __fastcall SVGBrushPen(bool UsePen = true);
	void __fastcall SVGClip();
	System::UnicodeString __fastcall SVGColor(System::Uitypes::TColor AColor);
	System::UnicodeString __fastcall SVGEllipse(const int X1, const int Y1, const int X2, const int Y2);
	void __fastcall SVGEndClip();
	System::UnicodeString __fastcall SVGOpacity(bool IsPen, const System::Uitypes::TColor AColor);
	System::UnicodeString __fastcall SVGPen();
	System::UnicodeString __fastcall SVGPoints(const System::Types::TPoint *Points, const int Points_High);
	System::UnicodeString __fastcall SVGRect(const System::Types::TRect &Rect);
	System::UnicodeString __fastcall TotalBounds();
	void __fastcall TextOutWithRotate(int X, int Y, const System::UnicodeString Text, const double RotDegree);
	
protected:
	virtual Vcltee::Tecanvas::TVisualBlock* __fastcall BeginEntity(const System::UnicodeString Entity, Vcltee::Tecanvas::TVisualBlock* const Visual = (Vcltee::Tecanvas::TVisualBlock*)(0x0), Vcltee::Tecanvas::TTeeTransform* const Transform = (Vcltee::Tecanvas::TTeeTransform*)(0x0));
	virtual void __fastcall EndEntity();
	void __fastcall AddLink(int x, int y, const System::UnicodeString Text, const System::UnicodeString URL, const System::UnicodeString Hint);
	void __fastcall AddToolTip(const System::UnicodeString Entity, const System::UnicodeString ToolTip);
	virtual void __fastcall SetPixel(int X, int Y, System::Uitypes::TColor Value);
	virtual void __fastcall SetPixel3D(int X, int Y, int Z, System::Uitypes::TColor Value);
	virtual System::UnicodeString __fastcall HeaderContents();
	
public:
	bool Antialias;
	System::UnicodeString DocType;
	bool Groups;
	System::UnicodeString SVGDescription;
	__fastcall TSVGCanvas(System::Classes::TStrings* const AStrings);
	virtual System::Types::TRect __fastcall InitWindow(Vcl::Graphics::TCanvas* const DestCanvas, Vcltee::Tecanvas::TView3DOptions* const A3DOptions, System::Uitypes::TColor ABackColor, bool Is3D, const System::Types::TRect &UserRect);
	__classmethod virtual System::UnicodeString __fastcall Description();
	virtual void __fastcall Arc(const int Left, const int Top, const int Right, const int Bottom, const int StartX, const int StartY, const int EndX, const int EndY)/* overload */;
	virtual void __fastcall Draw(int X, int Y, Vcl::Graphics::TGraphic* const Graphic);
	virtual void __fastcall FillRect(const System::Types::TRect &Rect);
	virtual void __fastcall Ellipse(const int X1, const int Y1, const int X2, const int Y2)/* overload */;
	virtual void __fastcall LineTo(const int X, const int Y)/* overload */;
	virtual void __fastcall MoveTo(const int X, const int Y)/* overload */;
	virtual void __fastcall Pie(int X1, int Y1, int X2, int Y2, int X3, int Y3, int X4, int Y4)/* overload */;
	HIDESBASE void __fastcall Pie(int X1, int Y1, int X2, int Y2, int X3, int Y3, int X4, int Y4, double HolePercent)/* overload */;
	virtual void __fastcall Donut(int XCenter, int YCenter, int XRadius, int YRadius, const double StartAngle, const double EndAngle, const double HolePercent)/* overload */;
	virtual void __fastcall Rectangle(const int X0, const int Y0, const int X1, const int Y1)/* overload */;
	virtual void __fastcall RoundRect(int X1, int Y1, int X2, int Y2, int X3, int Y3)/* overload */;
	virtual void __fastcall StretchDraw(const System::Types::TRect &Rect, Vcl::Graphics::TGraphic* const Graphic)/* overload */;
	virtual void __fastcall TextOut(int X, int Y, const System::UnicodeString Text)/* overload */;
	virtual void __fastcall ClipEllipse(const System::Types::TRect &Rect, bool Inverted = false);
	virtual void __fastcall ClipRectangle(const System::Types::TRect &Rect)/* overload */;
	virtual void __fastcall ClipRectangle(const System::Types::TRect &Rect, int RoundX, int RoundY)/* overload */;
	virtual void __fastcall ClipPolygon(const System::Types::TPoint *Points, const int Points_High, int NumPoints, bool DiffRegion = false);
	virtual void __fastcall UnClipRectangle();
	virtual void __fastcall GradientFill(const System::Types::TRect &Rect, System::Uitypes::TColor StartColor, System::Uitypes::TColor EndColor, Vcltee::Tecanvas::TGradientDirection Direction, int Balance = 0x32, int RadialX = 0x0, int RadialY = 0x0)/* overload */;
	virtual void __fastcall RotateLabel(int x, int y, const System::UnicodeString St, double RotDegree, bool AllowHTML = false);
	virtual void __fastcall RotateLabel3D(int x, int y, int z, const System::UnicodeString St, double RotDegree, bool AllowHTML = false);
	virtual void __fastcall Polygon(const System::Types::TPoint *Points, const int Points_High);
	virtual void __fastcall Polyline(const System::Types::TPoint *Points, const int Points_High)/* overload */;
	virtual void __fastcall ShowImage(Vcl::Graphics::TCanvas* const DestCanvas, Vcl::Graphics::TCanvas* const DefaultCanvas, const System::Types::TRect &UserRect);
	virtual void __fastcall TextOut3D(int X, int Y, int Z, const System::UnicodeString Text, bool AllowHTML = false)/* overload */;
public:
	/* TTeeNeutralCanvas.Create */ inline __fastcall virtual TSVGCanvas() : Vcltee::Tecanvas::TTeeNeutralCanvas() { }
	
public:
	/* TTeeCanvas3D.Destroy */ inline __fastcall virtual ~TSVGCanvas() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  Arc(const int Left, const int Top, const int Right, const int Bottom, const int StartX, const int StartY, const int EndX, const int EndY, const int Z){ Vcltee::Tecanvas::TCanvas3D::Arc(Left, Top, Right, Bottom, StartX, StartY, EndX, EndY, Z); }
	inline void __fastcall  Arc(const int Left, const int Top, const int Right, const int Bottom, const float StartAngle, const float EndAngle){ Vcltee::Tecanvas::TTeeCanvas::Arc(Left, Top, Right, Bottom, StartAngle, EndAngle); }
	inline void __fastcall  Arc(const System::Types::TRect &R, const float StartAngle, const float EndAngle){ Vcltee::Tecanvas::TTeeCanvas::Arc(R, StartAngle, EndAngle); }
	inline void __fastcall  Ellipse(const System::Types::TRect &R){ Vcltee::Tecanvas::TTeeCanvas::Ellipse(R); }
	inline void __fastcall  LineTo(const System::Types::TPoint &P){ Vcltee::Tecanvas::TTeeCanvas::LineTo(P); }
	inline void __fastcall  LineTo(const _POINTFLOAT &P){ Vcltee::Tecanvas::TTeeCanvas::LineTo(P); }
	inline void __fastcall  MoveTo(const System::Types::TPoint &P){ Vcltee::Tecanvas::TTeeCanvas::MoveTo(P); }
	inline void __fastcall  MoveTo(const _POINTFLOAT &P){ Vcltee::Tecanvas::TTeeCanvas::MoveTo(P); }
	inline void __fastcall  Pie(const System::Types::TRect &R, const double StartAngle, const double EndAngle){ Vcltee::Tecanvas::TTeeCanvas3D::Pie(R, StartAngle, EndAngle); }
	inline void __fastcall  Rectangle(const System::Types::TRect &R, int Z){ Vcltee::Tecanvas::TCanvas3D::Rectangle(R, Z); }
	inline void __fastcall  Rectangle(const int X0, const int Y0, const int X1, const int Y1, int Z){ Vcltee::Tecanvas::TCanvas3D::Rectangle(X0, Y0, X1, Y1, Z); }
	inline void __fastcall  Rectangle(const System::Types::TRect &R){ Vcltee::Tecanvas::TTeeCanvas::Rectangle(R); }
	inline void __fastcall  RoundRect(const System::Types::TRect &R, int X, int Y, int Z0, int Z1){ Vcltee::Tecanvas::TCanvas3D::RoundRect(R, X, Y, Z0, Z1); }
	inline void __fastcall  RoundRect(const System::Types::TRect &R, int X, int Y, Vcltee::Tecanvas::TTeeCorners* const ACorners = (Vcltee::Tecanvas::TTeeCorners*)(0x0)){ Vcltee::Tecanvas::TTeeCanvas::RoundRect(R, X, Y, ACorners); }
	inline void __fastcall  StretchDraw(const System::Types::TRect &Rect, Vcl::Graphics::TGraphic* const Graphic, const double Pos, Vcltee::Tecanvas::TCanvas3DPlane Plane = (Vcltee::Tecanvas::TCanvas3DPlane)(0x2)){ Vcltee::Tecanvas::TCanvas3D::StretchDraw(Rect, Graphic, Pos, Plane); }
	inline void __fastcall  TextOut(const int X, const int Y, const System::UnicodeString Text, bool AllowHtml){ Vcltee::Tecanvas::TTeeCanvas::TextOut(X, Y, Text, AllowHtml); }
	inline void __fastcall  GradientFill(Vcltee::Tecanvas::TCustomTeeGradient* const Gradient, const System::Types::TRect &Rect){ Vcltee::Tecanvas::TTeeCanvas3D::GradientFill(Gradient, Rect); }
	inline void __fastcall  Polyline(const System::Types::TPoint *Points, const int Points_High, int Z){ Vcltee::Tecanvas::TCanvas3D::Polyline(Points, Points_High, Z); }
	inline void __fastcall  TextOut3D(int x, int y, int z, const System::UnicodeString Text){ Vcltee::Tecanvas::TCanvas3D::TextOut3D(x, y, z, Text); }
	
private:
	void *__ICanvasToolTips;	// Vcltee::Tecanvas::ICanvasToolTips 
	void *__ICanvasHyperlinks;	// Vcltee::Tecanvas::ICanvasHyperlinks 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {03EBCB55-D01F-4CA8-8A2F-48EB3BEBC5E3}
	operator Vcltee::Tecanvas::_di_ICanvasToolTips()
	{
		Vcltee::Tecanvas::_di_ICanvasToolTips intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Vcltee::Tecanvas::ICanvasToolTips*(void) { return (Vcltee::Tecanvas::ICanvasToolTips*)&__ICanvasToolTips; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {84DBB276-CBD2-4BBB-AC31-AACBF8B6F34C}
	operator Vcltee::Tecanvas::_di_ICanvasHyperlinks()
	{
		Vcltee::Tecanvas::_di_ICanvasHyperlinks intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Vcltee::Tecanvas::ICanvasHyperlinks*(void) { return (Vcltee::Tecanvas::ICanvasHyperlinks*)&__ICanvasHyperlinks; }
	#endif
	
};


class PASCALIMPLEMENTATION TSVGExportFormat : public Vcltee::Teeexport::TTeeExportFormat
{
	typedef Vcltee::Teeexport::TTeeExportFormat inherited;
	
private:
	bool FAntiAlias;
	System::UnicodeString FDesc;
	bool FGroups;
	void __fastcall CheckProperties();
	
protected:
	Vcl::Forms::TForm* FProperties;
	virtual void __fastcall DoCopyToClipboard();
	
public:
	__fastcall virtual ~TSVGExportFormat();
	virtual System::UnicodeString __fastcall Description();
	virtual System::UnicodeString __fastcall FileExtension();
	__classmethod virtual System::UnicodeString __fastcall FileFilter();
	System::Classes::TStringList* __fastcall SVG();
	virtual Vcl::Forms::TForm* __fastcall Options(bool Check = true);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream)/* overload */;
	__property bool AntiAlias = {read=FAntiAlias, write=FAntiAlias, nodefault};
	__property bool Groups = {read=FGroups, write=FGroups, nodefault};
	__property System::UnicodeString SVGDescription = {read=FDesc, write=FDesc};
public:
	/* TTeeExportFormat.Create */ inline __fastcall virtual TSVGExportFormat() : Vcltee::Teeexport::TTeeExportFormat() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  SaveToStream(System::Classes::TStream* Stream, Vcl::Forms::TForm* const AOptions){ Vcltee::Teeexport::TTeeExportFormat::SaveToStream(Stream, AOptions); }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall TeeSaveToSVGFile(Vcltee::Teeprocs::TCustomTeePanel* const APanel, System::UnicodeString FileName, int AWidth = 0x0, int AHeight = 0x0);
}	/* namespace Teesvgcanvas */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESVGCANVAS)
using namespace Vcltee::Teesvgcanvas;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeesvgcanvasHPP
