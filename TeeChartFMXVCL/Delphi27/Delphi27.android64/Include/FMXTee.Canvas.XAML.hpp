// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Canvas.XAML.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Canvas_XamlHPP
#define Fmxtee_Canvas_XamlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Forms.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.Utils.hpp>
#include <System.Types.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Editor.Export.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Canvas
{
namespace Xaml
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TXAMLCanvas;
struct TTextOutItem;
class DELPHICLASS TXAML3DCanvas;
class DELPHICLASS TXAMLExportFormat;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TXAMLCanvas : public Fmxtee::Canvas::TTeeNeutralCanvas
{
	typedef Fmxtee::Canvas::TTeeNeutralCanvas inherited;
	
private:
	float FX;
	float FY;
	System::Classes::TStrings* FStrings;
	int IGraphicCounter;
	Fmxtee::Procs::TCustomTeePanel* IPanel;
	System::WideChar ISeparator;
	void __fastcall Add(const System::UnicodeString S);
	void __fastcall AddGradient(const System::UnicodeString APrefix, System::Uitypes::TAlphaColor StartColor, System::Uitypes::TAlphaColor MidColor, System::Uitypes::TAlphaColor EndColor, Fmxtee::Canvas::TGradientDirection Direction);
	void __fastcall AddGraphic(Fmx::Graphics::TBitmap* const AGraphic);
	void __fastcall AddShape(const System::UnicodeString APrefix, const System::UnicodeString AText, bool UsePen = true, bool UseBrush = true);
	void __fastcall AddStrings(const System::UnicodeString Strings);
	System::UnicodeString __fastcall PointToStr(const float X, const float Y);
	System::UnicodeString __fastcall XAMLColor(System::Uitypes::TAlphaColor AColor);
	
protected:
	virtual System::UnicodeString __fastcall BeginCanvasTag(System::Uitypes::TAlphaColor ABackColor);
	virtual System::UnicodeString __fastcall EndCanvasTag();
	virtual Fmxtee::Canvas::TVisualBlock* __fastcall BeginEntity(const System::UnicodeString Entity, Fmxtee::Canvas::TVisualBlock* const Visual = (Fmxtee::Canvas::TVisualBlock*)(0x0), Fmxtee::Canvas::TTeeTransform* const Transform = (Fmxtee::Canvas::TTeeTransform*)(0x0));
	virtual void __fastcall EndEntity();
	virtual void __fastcall InternalRect(const System::Types::TRectF &Rect, bool UsePen, bool IsRound);
	virtual void __fastcall SetPixel(int X, int Y, System::Uitypes::TAlphaColor Value);
	virtual void __fastcall SetPixel3D(int X, int Y, int Z, System::Uitypes::TAlphaColor Value);
	System::UnicodeString __fastcall XAMLPen();
	
public:
	__fastcall virtual TXAMLCanvas(Fmxtee::Procs::TCustomTeePanel* const Panel, System::Classes::TStrings* const AStrings);
	virtual System::Types::TRectF __fastcall InitWindow(Fmx::Graphics::TCanvas* const DestCanvas, Fmxtee::Canvas::TView3DOptions* const A3DOptions, System::Uitypes::TAlphaColor ABackColor, bool Is3D, const System::Types::TRectF &UserRect);
	virtual void __fastcall Arc(const int Left, const int Top, const int Right, const int Bottom, const int StartX, const int StartY, const int EndX, const int EndY)/* overload */;
	virtual void __fastcall Draw(int X, int Y, Fmx::Graphics::TBitmap* const Graphic);
	virtual void __fastcall FillRect(const System::Types::TRectF &Rect);
	virtual void __fastcall Ellipse(const float X1, const float Y1, const float X2, const float Y2)/* overload */;
	virtual void __fastcall LineTo(const float X, const float Y)/* overload */;
	virtual void __fastcall MoveTo(const float X, const float Y)/* overload */;
	virtual void __fastcall Pie(int X1, int Y1, int X2, int Y2, int X3, int Y3, int X4, int Y4)/* overload */;
	virtual void __fastcall Rectangle(const float X0, const float Y0, const float X1, const float Y1)/* overload */;
	virtual void __fastcall RoundRect(int X1, int Y1, int X2, int Y2, int X3, int Y3)/* overload */;
	virtual void __fastcall StretchDraw(const System::Types::TRectF &Rect, Fmx::Graphics::TBitmap* const Graphic)/* overload */;
	virtual void __fastcall TextOut(const float X, const float Y, const System::UnicodeString Text)/* overload */;
	virtual void __fastcall ClipRectangle(const System::Types::TRectF &Rect)/* overload */;
	virtual void __fastcall UnClipRectangle();
	virtual void __fastcall GradientFill(const System::Types::TRectF &Rect, System::Uitypes::TAlphaColor StartColor, System::Uitypes::TAlphaColor EndColor, Fmxtee::Canvas::TGradientDirection Direction, int Balance = 0x32, int RadialX = 0x0, int RadialY = 0x0)/* overload */;
	virtual void __fastcall RotateLabel(int x, int y, const System::UnicodeString St, double RotDegree, bool AllowHTML = false);
	virtual void __fastcall RotateLabel3D(int x, int y, int z, const System::UnicodeString St, double RotDegree, bool AllowHTML = false);
	virtual void __fastcall Polygon(const System::Types::TPointF *Points, const int Points_High);
	virtual void __fastcall Polyline(const System::Types::TPointF *Points, const int Points_High)/* overload */;
	virtual void __fastcall EllipseWithZ(const float X1, const float Y1, const float X2, const float Y2, const int Z)/* overload */;
	virtual void __fastcall ShowImage(Fmx::Graphics::TCanvas* const DestCanvas, Fmx::Graphics::TCanvas* const DefaultCanvas, const System::Types::TRectF &UserRect);
	virtual void __fastcall TextOut3D(int X, int Y, int Z, const System::UnicodeString Text, bool AllowHTML = false)/* overload */;
public:
	/* TTeeNeutralCanvas.Create */ inline __fastcall virtual TXAMLCanvas() : Fmxtee::Canvas::TTeeNeutralCanvas() { }
	
public:
	/* TTeeCanvas3D.Destroy */ inline __fastcall virtual ~TXAMLCanvas() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  Arc(const int Left, const int Top, const int Right, const int Bottom, const int StartX, const int StartY, const int EndX, const int EndY, const int Z){ Fmxtee::Canvas::TCanvas3D::Arc(Left, Top, Right, Bottom, StartX, StartY, EndX, EndY, Z); }
	inline void __fastcall  Arc(const int Left, const int Top, const int Right, const int Bottom, const float StartAngle, const float EndAngle){ Fmxtee::Canvas::TTeeCanvas::Arc(Left, Top, Right, Bottom, StartAngle, EndAngle); }
	inline void __fastcall  Arc(const System::Types::TRect &R, const float StartAngle, const float EndAngle){ Fmxtee::Canvas::TTeeCanvas::Arc(R, StartAngle, EndAngle); }
	inline void __fastcall  Ellipse(const System::Types::TRectF &R){ Fmxtee::Canvas::TTeeCanvas::Ellipse(R); }
	inline void __fastcall  LineTo(const System::Types::TPointF &P){ Fmxtee::Canvas::TTeeCanvas::LineTo(P); }
	inline void __fastcall  MoveTo(const System::Types::TPointF &P){ Fmxtee::Canvas::TTeeCanvas::MoveTo(P); }
	inline void __fastcall  Pie(const System::Types::TRectF &R, const double StartAngle, const double EndAngle){ Fmxtee::Canvas::TTeeCanvas3D::Pie(R, StartAngle, EndAngle); }
	inline void __fastcall  Rectangle(const System::Types::TRectF &R, int Z){ Fmxtee::Canvas::TCanvas3D::Rectangle(R, Z); }
	inline void __fastcall  Rectangle(const float X0, const float Y0, const float X1, const float Y1, int Z){ Fmxtee::Canvas::TCanvas3D::Rectangle(X0, Y0, X1, Y1, Z); }
	inline void __fastcall  Rectangle(const System::Types::TRectF &R){ Fmxtee::Canvas::TTeeCanvas::Rectangle(R); }
	inline void __fastcall  RoundRect(const System::Types::TRectF &R, int X, int Y, int Z0, int Z1){ Fmxtee::Canvas::TCanvas3D::RoundRect(R, X, Y, Z0, Z1); }
	inline void __fastcall  RoundRect(const System::Types::TRectF &R, int X, int Y, Fmxtee::Canvas::TTeeCorners* const ACorners = (Fmxtee::Canvas::TTeeCorners*)(0x0)){ Fmxtee::Canvas::TTeeCanvas::RoundRect(R, X, Y, ACorners); }
	inline void __fastcall  StretchDraw(const System::Types::TRectF &Rect, Fmx::Graphics::TBitmap* const Graphic, const double Pos, Fmxtee::Canvas::TCanvas3DPlane Plane = (Fmxtee::Canvas::TCanvas3DPlane)(0x2)){ Fmxtee::Canvas::TCanvas3D::StretchDraw(Rect, Graphic, Pos, Plane); }
	inline void __fastcall  TextOut(const float X, const float Y, const System::UnicodeString Text, bool AllowHtml){ Fmxtee::Canvas::TTeeCanvas::TextOut(X, Y, Text, AllowHtml); }
	inline void __fastcall  ClipRectangle(const System::Types::TRectF &Rect, int RoundX, int RoundY){ Fmxtee::Canvas::TTeeCanvas::ClipRectangle(Rect, RoundX, RoundY); }
	inline void __fastcall  GradientFill(Fmxtee::Canvas::TCustomTeeGradient* const Gradient, const System::Types::TRectF &Rect){ Fmxtee::Canvas::TTeeCanvas3D::GradientFill(Gradient, Rect); }
	inline void __fastcall  Polyline(const System::Types::TPointF *Points, const int Points_High, int Z){ Fmxtee::Canvas::TCanvas3D::Polyline(Points, Points_High, Z); }
	inline void __fastcall  EllipseWithZ(const System::Types::TRectF &Rect, int Z){ Fmxtee::Canvas::TCanvas3D::EllipseWithZ(Rect, Z); }
	inline void __fastcall  TextOut3D(int x, int y, int z, const System::UnicodeString Text){ Fmxtee::Canvas::TCanvas3D::TextOut3D(x, y, z, Text); }
	
};


#pragma pack(push,1)
struct DECLSPEC_DRECORD TTextOutItem
{
public:
	int XPos;
	int YPos;
	int ZPos;
	System::UnicodeString FontFamily;
	System::UnicodeString ItemText;
	System::Uitypes::TAlphaColor FontColor;
	System::Uitypes::TAlphaColor ItemBack;
};
#pragma pack(pop)


class PASCALIMPLEMENTATION TXAML3DCanvas : public TXAMLCanvas
{
	typedef TXAMLCanvas inherited;
	
	
private:
	typedef System::DynamicArray<TTextOutItem> _TXAML3DCanvas__1;
	
	
private:
	float FZ;
	System::Classes::TStrings* IItems;
	_TXAML3DCanvas__1 ITexts;
	void __fastcall AddTransform(const float ScaleX, const float ScaleY, const float ScaleZ, const float TranslateX, const float TranslateY, const float TranslateZ, const float RotateAngle);
	System::UnicodeString __fastcall GetOpacity();
	System::UnicodeString __fastcall IDTag(const System::UnicodeString Prefix);
	System::UnicodeString __fastcall TextOutList();
	
protected:
	virtual System::UnicodeString __fastcall BeginCanvasTag(System::Uitypes::TAlphaColor ABackColor);
	virtual Fmxtee::Canvas::TVisualBlock* __fastcall BeginEntity(const System::UnicodeString Entity, Fmxtee::Canvas::TVisualBlock* const Visual = (Fmxtee::Canvas::TVisualBlock*)(0x0), Fmxtee::Canvas::TTeeTransform* const Transform = (Fmxtee::Canvas::TTeeTransform*)(0x0));
	virtual System::UnicodeString __fastcall EndCanvasTag();
	virtual void __fastcall EndEntity();
	virtual bool __fastcall GetSupportsFullRotation();
	virtual void __fastcall InternalRect(const System::Types::TRectF &Rect, bool UsePen, bool IsRound);
	
public:
	bool ScrollBars;
	__fastcall virtual TXAML3DCanvas(Fmxtee::Procs::TCustomTeePanel* const Panel, System::Classes::TStrings* const AStrings);
	__fastcall virtual ~TXAML3DCanvas();
	virtual void __fastcall Cone(bool Vertical, int Left, int Top, int Right, int Bottom, int Z0, int Z1, bool Dark3D, int ConePercent);
	virtual void __fastcall Cube(int Left, int Right, int Top, int Bottom, int Z0, int Z1, bool DarkSides = true, int RoundSize = 0x0)/* overload */;
	virtual void __fastcall EraseBackground(const System::Types::TRectF &Rect);
	virtual void __fastcall LineTo(const float X, const float Y)/* overload */;
	virtual void __fastcall LineTo3D(const float X, const float Y, const float Z)/* overload */;
	virtual void __fastcall MoveTo3D(const float X, const float Y, const float Z)/* overload */;
	virtual void __fastcall Polygon(const System::Types::TPointF *Points, const int Points_High);
	virtual void __fastcall RectangleWithZ(const System::Types::TRectF &Rect, int Z);
	virtual void __fastcall TextOut3D(int X, int Y, int Z, const System::UnicodeString Text, bool AllowHTML = false)/* overload */;
public:
	/* TTeeNeutralCanvas.Create */ inline __fastcall virtual TXAML3DCanvas() : TXAMLCanvas() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  Cube(int Left, int Right, int Top, int Bottom, int Z0, int Z1, int BevelSize, bool DarkSides = true, int RoundSize = 0x0){ Fmxtee::Canvas::TTeeCanvas3D::Cube(Left, Right, Top, Bottom, Z0, Z1, BevelSize, DarkSides, RoundSize); }
	inline void __fastcall  Cube(const System::Types::TRectF &R, int Z0, int Z1, bool DarkSides = true, int RoundSize = 0x0){ Fmxtee::Canvas::TCanvas3D::Cube(R, Z0, Z1, DarkSides, RoundSize); }
	inline void __fastcall  LineTo(const System::Types::TPointF &P){ Fmxtee::Canvas::TTeeCanvas::LineTo(P); }
	inline void __fastcall  LineTo3D(const Fmxtee::Canvas::TPoint3D &P){ Fmxtee::Canvas::TCanvas3D::LineTo3D(P); }
	inline void __fastcall  MoveTo3D(const Fmxtee::Canvas::TPoint3D &P){ Fmxtee::Canvas::TCanvas3D::MoveTo3D(P); }
	inline void __fastcall  TextOut3D(int x, int y, int z, const System::UnicodeString Text){ Fmxtee::Canvas::TCanvas3D::TextOut3D(x, y, z, Text); }
	
};


class PASCALIMPLEMENTATION TXAMLExportFormat : public Fmxtee::Editor::Export::TTeeExportFormat
{
	typedef Fmxtee::Editor::Export::TTeeExportFormat inherited;
	
private:
	Fmx::Forms::TForm* FProperties;
	void __fastcall CheckProperties();
	
protected:
	virtual void __fastcall DoCopyToClipboard();
	
public:
	bool Is3D;
	bool ScrollBars;
	virtual System::UnicodeString __fastcall Description();
	virtual System::UnicodeString __fastcall FileExtension();
	__classmethod virtual System::UnicodeString __fastcall FileFilter();
	System::Classes::TStringList* __fastcall XAML();
	virtual Fmx::Forms::TForm* __fastcall Editor(System::Classes::TComponent* AOwner);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream)/* overload */;
public:
	/* TTeeExportFormat.Create */ inline __fastcall virtual TXAMLExportFormat() : Fmxtee::Editor::Export::TTeeExportFormat() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TXAMLExportFormat() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  SaveToStream(System::Classes::TStream* Stream, Fmx::Forms::TForm* const AOptions){ Fmxtee::Editor::Export::TTeeExportFormat::SaveToStream(Stream, AOptions); }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall TeeSaveToXAMLFile(Fmxtee::Procs::TCustomTeePanel* const APanel, const System::UnicodeString FileName, int AWidth = 0x0, int AHeight = 0x0, bool XAML3D = false);
}	/* namespace Xaml */
}	/* namespace Canvas */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_CANVAS_XAML)
using namespace Fmxtee::Canvas::Xaml;
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
#endif	// Fmxtee_Canvas_XamlHPP
