// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Canvas.HTML5.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Canvas_Html5HPP
#define Fmxtee_Canvas_Html5HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Platform.hpp>
#include <FMX.Graphics.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Editor.Export.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Canvas
{
namespace Html5
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THTML5Canvas;
class DELPHICLASS THTML5ExportFormat;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION THTML5Canvas : public Fmxtee::Canvas::TTeeNeutralCanvas
{
	typedef Fmxtee::Canvas::TTeeNeutralCanvas inherited;
	
private:
	float FX;
	float FY;
	System::Classes::TStrings* FStrings;
	int IGradientCount;
	bool IOwnsStrings;
	System::WideChar OldDecimal;
	void __fastcall Add(const System::UnicodeString S);
	void __fastcall AddBrush();
	void __fastcall AddDashedLine();
	void __fastcall AddGradient(Fmxtee::Canvas::TTeeGradient* const AGradient, const System::Types::TRectF &Rect);
	void __fastcall AddPen();
	System::Classes::TStrings* __fastcall GetStrings();
	System::UnicodeString __fastcall HTML5Color(const System::Uitypes::TAlphaColor AColor)/* overload */;
	System::UnicodeString __fastcall HTML5Color(const System::Uitypes::TAlphaColor AColor, const float ATransp)/* overload */;
	void __fastcall InitStrings();
	
protected:
	virtual void __fastcall SmoothShadow(Fmxtee::Canvas::TTeeShadow* const Shadow, const System::Types::TRectF &Rect, bool Ellipse, int RoundSize, const System::Types::TPointF *P, const int P_High, int DonutPercent = 0x0, const double StartAngle = 0.000000E+00, const double EndAngle = 3.600000E+02);
	
public:
	__fastcall THTML5Canvas(System::Classes::TStrings* const AStrings);
	__fastcall virtual ~THTML5Canvas();
	virtual System::Types::TRectF __fastcall InitWindow(Fmx::Graphics::TCanvas* const DestCanvas, Fmxtee::Canvas::TView3DOptions* const A3DOptions, System::Uitypes::TAlphaColor ABackColor, bool Is3D, const System::Types::TRectF &UserRect);
	virtual void __fastcall AssignVisiblePenColor(Fmxtee::Canvas::TTeePen* const APen, System::Uitypes::TAlphaColor AColor);
	virtual void __fastcall Arc(const int Left, const int Top, const int Right, const int Bottom, const int StartX, const int StartY, const int EndX, const int EndY)/* overload */;
	virtual void __fastcall Draw(int X, int Y, Fmx::Graphics::TBitmap* const Graphic);
	virtual void __fastcall FillRect(const System::Types::TRectF &Rect);
	virtual void __fastcall Ellipse(const float X1, const float Y1, const float X2, const float Y2)/* overload */;
	virtual void __fastcall LineTo(const float X, const float Y)/* overload */;
	virtual void __fastcall MoveTo(const float X, const float Y)/* overload */;
	virtual void __fastcall Pie(const System::Types::TRectF &R, const double StartAngle, const double EndAngle)/* overload */;
	virtual void __fastcall Pie(int X1, int Y1, int X2, int Y2, int X3, int Y3, int X4, int Y4)/* overload */;
	virtual void __fastcall Rectangle(const float X0, const float Y0, const float X1, const float Y1)/* overload */;
	virtual void __fastcall RoundRect(int X1, int Y1, int X2, int Y2, int X3, int Y3)/* overload */;
	virtual void __fastcall StretchDraw(const System::Types::TRectF &Rect, Fmx::Graphics::TBitmap* const Graphic)/* overload */;
	virtual void __fastcall TextOut(const float X, const float Y, const System::UnicodeString Text)/* overload */;
	virtual void __fastcall ClipEllipse(const System::Types::TRectF &Rect, bool Inverted = false);
	virtual void __fastcall ClipRectangle(const System::Types::TRectF &Rect)/* overload */;
	virtual void __fastcall ClipRectangle(const System::Types::TRectF &Rect, int RoundX, int RoundY)/* overload */;
	virtual void __fastcall ClipPolygon(const System::Types::TPointF *Points, const int Points_High, int NumPoints, bool DiffRegion = false);
	virtual void __fastcall UnClipRectangle();
	virtual void __fastcall GradientFill(const System::Types::TRectF &Rect, System::Uitypes::TAlphaColor StartColor, System::Uitypes::TAlphaColor EndColor, Fmxtee::Canvas::TGradientDirection Direction, int Balance = 0x32, int RadialX = 0x0, int RadialY = 0x0)/* overload */;
	virtual void __fastcall RotateLabel(int x, int y, const System::UnicodeString St, double RotDegree, bool AllowHTML = false);
	virtual void __fastcall RotateLabel3D(int x, int y, int z, const System::UnicodeString St, double RotDegree, bool AllowHTML = false);
	virtual void __fastcall Polygon(const System::Types::TPointF *Points, const int Points_High);
	virtual void __fastcall Polyline(const System::Types::TPointF *Points, const int Points_High)/* overload */;
	virtual void __fastcall ShowImage(Fmx::Graphics::TCanvas* const DestCanvas, Fmx::Graphics::TCanvas* const DefaultCanvas, const System::Types::TRectF &UserRect);
	virtual void __fastcall TextOut3D(int X, int Y, int Z, const System::UnicodeString Text, bool AllowHTML = false)/* overload */;
	__property System::Classes::TStrings* Strings = {read=GetStrings};
public:
	/* TTeeNeutralCanvas.Create */ inline __fastcall virtual THTML5Canvas() : Fmxtee::Canvas::TTeeNeutralCanvas() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  Arc(const int Left, const int Top, const int Right, const int Bottom, const int StartX, const int StartY, const int EndX, const int EndY, const int Z){ Fmxtee::Canvas::TCanvas3D::Arc(Left, Top, Right, Bottom, StartX, StartY, EndX, EndY, Z); }
	inline void __fastcall  Arc(const int Left, const int Top, const int Right, const int Bottom, const float StartAngle, const float EndAngle){ Fmxtee::Canvas::TTeeCanvas::Arc(Left, Top, Right, Bottom, StartAngle, EndAngle); }
	inline void __fastcall  Arc(const System::Types::TRect &R, const float StartAngle, const float EndAngle){ Fmxtee::Canvas::TTeeCanvas::Arc(R, StartAngle, EndAngle); }
	inline void __fastcall  Ellipse(const System::Types::TRectF &R){ Fmxtee::Canvas::TTeeCanvas::Ellipse(R); }
	inline void __fastcall  LineTo(const System::Types::TPointF &P){ Fmxtee::Canvas::TTeeCanvas::LineTo(P); }
	inline void __fastcall  MoveTo(const System::Types::TPointF &P){ Fmxtee::Canvas::TTeeCanvas::MoveTo(P); }
	inline void __fastcall  Rectangle(const System::Types::TRectF &R, int Z){ Fmxtee::Canvas::TCanvas3D::Rectangle(R, Z); }
	inline void __fastcall  Rectangle(const float X0, const float Y0, const float X1, const float Y1, int Z){ Fmxtee::Canvas::TCanvas3D::Rectangle(X0, Y0, X1, Y1, Z); }
	inline void __fastcall  Rectangle(const System::Types::TRectF &R){ Fmxtee::Canvas::TTeeCanvas::Rectangle(R); }
	inline void __fastcall  RoundRect(const System::Types::TRectF &R, int X, int Y, int Z0, int Z1){ Fmxtee::Canvas::TCanvas3D::RoundRect(R, X, Y, Z0, Z1); }
	inline void __fastcall  RoundRect(const System::Types::TRectF &R, int X, int Y, Fmxtee::Canvas::TTeeCorners* const ACorners = (Fmxtee::Canvas::TTeeCorners*)(0x0)){ Fmxtee::Canvas::TTeeCanvas::RoundRect(R, X, Y, ACorners); }
	inline void __fastcall  StretchDraw(const System::Types::TRectF &Rect, Fmx::Graphics::TBitmap* const Graphic, const double Pos, Fmxtee::Canvas::TCanvas3DPlane Plane = (Fmxtee::Canvas::TCanvas3DPlane)(0x2)){ Fmxtee::Canvas::TCanvas3D::StretchDraw(Rect, Graphic, Pos, Plane); }
	inline void __fastcall  TextOut(const float X, const float Y, const System::UnicodeString Text, bool AllowHtml){ Fmxtee::Canvas::TTeeCanvas::TextOut(X, Y, Text, AllowHtml); }
	inline void __fastcall  GradientFill(Fmxtee::Canvas::TCustomTeeGradient* const Gradient, const System::Types::TRectF &Rect){ Fmxtee::Canvas::TTeeCanvas3D::GradientFill(Gradient, Rect); }
	inline void __fastcall  Polyline(const System::Types::TPointF *Points, const int Points_High, int Z){ Fmxtee::Canvas::TCanvas3D::Polyline(Points, Points_High, Z); }
	inline void __fastcall  TextOut3D(int x, int y, int z, const System::UnicodeString Text){ Fmxtee::Canvas::TCanvas3D::TextOut3D(x, y, z, Text); }
	
};


class PASCALIMPLEMENTATION THTML5ExportFormat : public Fmxtee::Editor::Export::TTeeExportFormat
{
	typedef Fmxtee::Editor::Export::TTeeExportFormat inherited;
	
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
	/* TTeeExportFormat.Create */ inline __fastcall virtual THTML5ExportFormat() : Fmxtee::Editor::Export::TTeeExportFormat() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  SaveToStream(System::Classes::TStream* Stream, Fmx::Forms::TForm* const AOptions){ Fmxtee::Editor::Export::TTeeExportFormat::SaveToStream(Stream, AOptions); }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall TeeSaveToHTML5File(Fmxtee::Procs::TCustomTeePanel* const APanel, System::UnicodeString FileName, int AWidth = 0x0, int AHeight = 0x0);
}	/* namespace Html5 */
}	/* namespace Canvas */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_CANVAS_HTML5)
using namespace Fmxtee::Canvas::Html5;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_CANVAS)
using namespace Fmxtee::Canvas;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Canvas_Html5HPP
