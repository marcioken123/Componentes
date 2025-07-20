// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeePSCanvas.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeepscanvasHPP
#define Vcltee_TeepscanvasHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeExport.hpp>
#include <System.Math.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teepscanvas
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TEPSCanvas;
class DELPHICLASS TEPSExportFormat;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TEPSCanvas : public Vcltee::Tecanvas::TTeeNeutralCanvas
{
	typedef Vcltee::Tecanvas::TTeeNeutralCanvas inherited;
	
private:
	System::Classes::TStrings* FStrings;
	int FX;
	int FY;
	void __fastcall Add(const System::UnicodeString S);
	System::UnicodeString __fastcall BrushProperties(Vcl::Graphics::TBrush* const Brush);
	void __fastcall InternalRect(const System::Types::TRect &Rect, bool UsePen, bool IsRound);
	void __fastcall InternalArc(int X1, int Y1, int X2, int Y2, int X3, int Y3, int X4, int Y4, bool Pie);
	System::UnicodeString __fastcall PenProperties(Vcltee::Tecanvas::TTeePen* const Pen);
	System::UnicodeString __fastcall PointToStr(int X, int Y);
	System::UnicodeString __fastcall SetPenStyle(Vcl::Graphics::TPenStyle PenStyle);
	System::UnicodeString __fastcall TextToPSText(System::UnicodeString AText);
	void __fastcall TranslateVertCoord(int &Y);
	
protected:
	virtual void __fastcall SetPixel(int X, int Y, System::Uitypes::TColor Value);
	virtual void __fastcall SetPixel3D(int X, int Y, int Z, System::Uitypes::TColor Value);
	
public:
	__fastcall TEPSCanvas(System::Classes::TStrings* const AStrings);
	virtual System::Types::TRect __fastcall InitWindow(Vcl::Graphics::TCanvas* const DestCanvas, Vcltee::Tecanvas::TView3DOptions* const A3DOptions, System::Uitypes::TColor ABackColor, bool Is3D, const System::Types::TRect &UserRect);
	virtual void __fastcall Arc(const int Left, const int Top, const int Right, const int Bottom, const int StartX, const int StartY, const int EndX, const int EndY)/* overload */;
	virtual void __fastcall Draw(int X, int Y, Vcl::Graphics::TGraphic* const Graphic);
	virtual void __fastcall FillRect(const System::Types::TRect &Rect);
	virtual void __fastcall Ellipse(const int X1, const int Y1, const int X2, const int Y2)/* overload */;
	virtual void __fastcall LineTo(const int X, const int Y)/* overload */;
	virtual void __fastcall MoveTo(const int X, const int Y)/* overload */;
	virtual void __fastcall Pie(int X1, int Y1, int X2, int Y2, int X3, int Y3, int X4, int Y4)/* overload */;
	virtual void __fastcall Rectangle(const int X0, const int Y0, const int X1, const int Y1)/* overload */;
	virtual void __fastcall RoundRect(int X1, int Y1, int X2, int Y2, int X3, int Y3)/* overload */;
	virtual void __fastcall StretchDraw(const System::Types::TRect &Rect, Vcl::Graphics::TGraphic* const Graphic)/* overload */;
	virtual void __fastcall TextOut(int X, int Y, const System::UnicodeString Text)/* overload */;
	virtual void __fastcall ClipRectangle(const System::Types::TRect &Rect)/* overload */;
	virtual void __fastcall UnClipRectangle();
	virtual void __fastcall GradientFill(const System::Types::TRect &Rect, System::Uitypes::TColor StartColor, System::Uitypes::TColor EndColor, Vcltee::Tecanvas::TGradientDirection Direction, int Balance = 0x32, int RadialX = 0x0, int RadialY = 0x0)/* overload */;
	virtual void __fastcall RotateLabel(int x, int y, const System::UnicodeString St, double RotDegree, bool AllowHTML = false);
	virtual void __fastcall RotateLabel3D(int x, int y, int z, const System::UnicodeString St, double RotDegree, bool AllowHTML = false);
	virtual void __fastcall Polygon(const System::Types::TPoint *Points, const int Points_High);
	virtual void __fastcall ShowImage(Vcl::Graphics::TCanvas* const DestCanvas, Vcl::Graphics::TCanvas* const DefaultCanvas, const System::Types::TRect &UserRect);
	virtual void __fastcall EllipseWithZ(const int X1, const int Y1, const int X2, const int Y2, const int Z)/* overload */;
	virtual void __fastcall TextOut3D(int X, int Y, int Z, const System::UnicodeString Text, bool AllowHTML = false)/* overload */;
public:
	/* TTeeNeutralCanvas.Create */ inline __fastcall virtual TEPSCanvas() : Vcltee::Tecanvas::TTeeNeutralCanvas() { }
	
public:
	/* TTeeCanvas3D.Destroy */ inline __fastcall virtual ~TEPSCanvas() { }
	
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
	inline void __fastcall  ClipRectangle(const System::Types::TRect &Rect, int RoundX, int RoundY){ Vcltee::Tecanvas::TTeeCanvas::ClipRectangle(Rect, RoundX, RoundY); }
	inline void __fastcall  GradientFill(Vcltee::Tecanvas::TCustomTeeGradient* const Gradient, const System::Types::TRect &Rect){ Vcltee::Tecanvas::TTeeCanvas3D::GradientFill(Gradient, Rect); }
	inline void __fastcall  EllipseWithZ(const System::Types::TRect &Rect, int Z){ Vcltee::Tecanvas::TCanvas3D::EllipseWithZ(Rect, Z); }
	inline void __fastcall  TextOut3D(int x, int y, int z, const System::UnicodeString Text){ Vcltee::Tecanvas::TCanvas3D::TextOut3D(x, y, z, Text); }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TEPSExportFormat : public Vcltee::Teeexport::TTeeExportFormat
{
	typedef Vcltee::Teeexport::TTeeExportFormat inherited;
	
protected:
	virtual void __fastcall DoCopyToClipboard();
	
public:
	virtual System::UnicodeString __fastcall Description();
	virtual System::UnicodeString __fastcall FileExtension();
	__classmethod virtual System::UnicodeString __fastcall FileFilter();
	System::Classes::TStringList* __fastcall EPSList();
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream)/* overload */;
public:
	/* TTeeExportFormat.Create */ inline __fastcall virtual TEPSExportFormat() : Vcltee::Teeexport::TTeeExportFormat() { }
	/* TTeeExportFormat.Destroy */ inline __fastcall virtual ~TEPSExportFormat() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  SaveToStream(System::Classes::TStream* Stream, Vcl::Forms::TForm* const AOptions){ Vcltee::Teeexport::TTeeExportFormat::SaveToStream(Stream, AOptions); }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall TeeSaveToPSFile(Vcltee::Teeprocs::TCustomTeePanel* const APanel, const System::UnicodeString FileName, int AWidth = 0x0, int AHeight = 0x0);
}	/* namespace Teepscanvas */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEPSCANVAS)
using namespace Vcltee::Teepscanvas;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeepscanvasHPP
