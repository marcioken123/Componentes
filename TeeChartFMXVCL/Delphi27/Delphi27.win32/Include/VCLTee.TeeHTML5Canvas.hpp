// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeHTML5Canvas.pas' rev: 34.00 (Windows)

#ifndef Vcltee_Teehtml5canvasHPP
#define Vcltee_Teehtml5canvasHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Clipbrd.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeExport.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teehtml5canvas
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THTML5Canvas;
class DELPHICLASS THTML5ExportFormat;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION THTML5Canvas : public Vcltee::Tecanvas::TTeeNeutralCanvas
{
	typedef Vcltee::Tecanvas::TTeeNeutralCanvas inherited;
	
private:
	int FX;
	int FY;
	System::Classes::TStrings* FStrings;
	int IGradientCount;
	bool IOwnsStrings;
	System::WideChar OldDecimal;
	void __fastcall Add(const System::UnicodeString S);
	void __fastcall AddBrush();
	void __fastcall AddDashedLine();
	void __fastcall AddGradient(Vcltee::Tecanvas::TTeeGradient* const AGradient, const System::Types::TRect &Rect);
	void __fastcall AddPen();
	System::Classes::TStrings* __fastcall GetStrings();
	System::UnicodeString __fastcall HTML5Color(const System::Uitypes::TColor AColor)/* overload */;
	System::UnicodeString __fastcall HTML5Color(const System::Uitypes::TColor AColor, const float ATransp)/* overload */;
	void __fastcall InitStrings();
	
protected:
	virtual void __fastcall SmoothShadow(Vcltee::Tecanvas::TTeeShadow* const Shadow, const System::Types::TRect &Rect, bool Ellipse, int RoundSize, const System::Types::TPoint *P, const int P_High, int DonutPercent = 0x0, const double StartAngle = 0.000000E+00, const double EndAngle = 3.600000E+02);
	virtual Vcltee::Tecanvas::TCanvasStyle __fastcall CanvasStyle();
	
public:
	__fastcall THTML5Canvas(System::Classes::TStrings* const AStrings);
	__fastcall virtual ~THTML5Canvas();
	virtual System::Types::TRect __fastcall InitWindow(Vcl::Graphics::TCanvas* const DestCanvas, Vcltee::Tecanvas::TView3DOptions* const A3DOptions, System::Uitypes::TColor ABackColor, bool Is3D, const System::Types::TRect &UserRect);
	virtual void __fastcall AssignVisiblePenColor(Vcltee::Tecanvas::TTeePen* const APen, System::Uitypes::TColor AColor);
	virtual void __fastcall Arc(const int Left, const int Top, const int Right, const int Bottom, const int StartX, const int StartY, const int EndX, const int EndY)/* overload */;
	virtual void __fastcall Draw(int X, int Y, Vcl::Graphics::TGraphic* const Graphic);
	virtual void __fastcall FillRect(const System::Types::TRect &Rect);
	virtual void __fastcall Ellipse(const int X1, const int Y1, const int X2, const int Y2)/* overload */;
	virtual void __fastcall LineTo(const int X, const int Y)/* overload */;
	virtual void __fastcall MoveTo(const int X, const int Y)/* overload */;
	virtual void __fastcall Pie(const System::Types::TRect &R, const double StartAngle, const double EndAngle)/* overload */;
	virtual void __fastcall Pie(int X1, int Y1, int X2, int Y2, int X3, int Y3, int X4, int Y4)/* overload */;
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
	__property System::Classes::TStrings* Strings = {read=GetStrings};
public:
	/* TTeeNeutralCanvas.Create */ inline __fastcall virtual THTML5Canvas() : Vcltee::Tecanvas::TTeeNeutralCanvas() { }
	
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
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION THTML5ExportFormat : public Vcltee::Teeexport::TTeeExportFormat
{
	typedef Vcltee::Teeexport::TTeeExportFormat inherited;
	
protected:
	virtual void __fastcall DoCopyToClipboard();
	
public:
	__fastcall virtual ~THTML5ExportFormat();
	virtual System::UnicodeString __fastcall Description();
	virtual System::UnicodeString __fastcall FileExtension();
	__classmethod virtual System::UnicodeString __fastcall FileFilter();
	System::Classes::TStringList* __fastcall HTML5();
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream)/* overload */;
public:
	/* TTeeExportFormat.Create */ inline __fastcall virtual THTML5ExportFormat() : Vcltee::Teeexport::TTeeExportFormat() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  SaveToStream(System::Classes::TStream* Stream, Vcl::Forms::TForm* const AOptions){ Vcltee::Teeexport::TTeeExportFormat::SaveToStream(Stream, AOptions); }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall TeeSaveToHTML5File(Vcltee::Teeprocs::TCustomTeePanel* const APanel, System::UnicodeString FileName, int AWidth = 0x0, int AHeight = 0x0);
}	/* namespace Teehtml5canvas */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEHTML5CANVAS)
using namespace Vcltee::Teehtml5canvas;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_Teehtml5canvasHPP
