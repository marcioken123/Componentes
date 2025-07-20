// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeXAMLCanvas.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeexamlcanvasHPP
#define Vcltee_TeexamlcanvasHPP

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
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeExport.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teexamlcanvas
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TXAMLCanvas;
struct TTextOutItem;
class DELPHICLASS TXAML3DCanvas;
class DELPHICLASS TXAMLExportFormat;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TXAMLCanvas : public Vcltee::Tecanvas::TTeeNeutralCanvas
{
	typedef Vcltee::Tecanvas::TTeeNeutralCanvas inherited;
	
private:
	int FX;
	int FY;
	System::Classes::TStrings* FStrings;
	int IGraphicCounter;
	Vcltee::Teeprocs::TCustomTeePanel* IPanel;
	System::WideChar ISeparator;
	void __fastcall Add(const System::UnicodeString S);
	void __fastcall AddGradient(const System::UnicodeString APrefix, System::Uitypes::TColor StartColor, System::Uitypes::TColor MidColor, System::Uitypes::TColor EndColor, Vcltee::Tecanvas::TGradientDirection Direction);
	void __fastcall AddGraphic(Vcl::Graphics::TGraphic* const AGraphic);
	void __fastcall AddShape(const System::UnicodeString APrefix, const System::UnicodeString AText, bool UsePen = true, bool UseBrush = true);
	void __fastcall AddStrings(const System::UnicodeString Strings);
	System::UnicodeString __fastcall PointToStr(const int X, const int Y);
	System::UnicodeString __fastcall XAMLColor(System::Uitypes::TColor AColor);
	
protected:
	virtual System::UnicodeString __fastcall BeginCanvasTag(System::Uitypes::TColor ABackColor);
	virtual System::UnicodeString __fastcall EndCanvasTag();
	virtual Vcltee::Tecanvas::TVisualBlock* __fastcall BeginEntity(const System::UnicodeString Entity, Vcltee::Tecanvas::TVisualBlock* const Visual = (Vcltee::Tecanvas::TVisualBlock*)(0x0), Vcltee::Tecanvas::TTeeTransform* const Transform = (Vcltee::Tecanvas::TTeeTransform*)(0x0));
	virtual void __fastcall EndEntity();
	virtual void __fastcall InternalRect(const System::Types::TRect &Rect, bool UsePen, bool IsRound);
	virtual void __fastcall SetPixel(int X, int Y, System::Uitypes::TColor Value);
	virtual void __fastcall SetPixel3D(int X, int Y, int Z, System::Uitypes::TColor Value);
	System::UnicodeString __fastcall XAMLPen();
	
public:
	__fastcall virtual TXAMLCanvas(Vcltee::Teeprocs::TCustomTeePanel* const Panel, System::Classes::TStrings* const AStrings);
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
	virtual void __fastcall Polyline(const System::Types::TPoint *Points, const int Points_High)/* overload */;
	virtual void __fastcall EllipseWithZ(const int X1, const int Y1, const int X2, const int Y2, const int Z)/* overload */;
	virtual void __fastcall ShowImage(Vcl::Graphics::TCanvas* const DestCanvas, Vcl::Graphics::TCanvas* const DefaultCanvas, const System::Types::TRect &UserRect);
	virtual void __fastcall TextOut3D(int X, int Y, int Z, const System::UnicodeString Text, bool AllowHTML = false)/* overload */;
public:
	/* TTeeNeutralCanvas.Create */ inline __fastcall virtual TXAMLCanvas() : Vcltee::Tecanvas::TTeeNeutralCanvas() { }
	
public:
	/* TTeeCanvas3D.Destroy */ inline __fastcall virtual ~TXAMLCanvas() { }
	
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
	inline void __fastcall  Polyline(const System::Types::TPoint *Points, const int Points_High, int Z){ Vcltee::Tecanvas::TCanvas3D::Polyline(Points, Points_High, Z); }
	inline void __fastcall  EllipseWithZ(const System::Types::TRect &Rect, int Z){ Vcltee::Tecanvas::TCanvas3D::EllipseWithZ(Rect, Z); }
	inline void __fastcall  TextOut3D(int x, int y, int z, const System::UnicodeString Text){ Vcltee::Tecanvas::TCanvas3D::TextOut3D(x, y, z, Text); }
	
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
	System::Uitypes::TColor FontColor;
	System::Uitypes::TColor ItemBack;
};
#pragma pack(pop)


class PASCALIMPLEMENTATION TXAML3DCanvas : public TXAMLCanvas
{
	typedef TXAMLCanvas inherited;
	
	
private:
	typedef System::DynamicArray<TTextOutItem> _TXAML3DCanvas__1;
	
	
private:
	int FZ;
	System::Classes::TStrings* IItems;
	_TXAML3DCanvas__1 ITexts;
	void __fastcall AddTransform(const float ScaleX, const float ScaleY, const float ScaleZ, const float TranslateX, const float TranslateY, const float TranslateZ, const float RotateAngle);
	System::UnicodeString __fastcall GetOpacity();
	System::UnicodeString __fastcall IDTag(const System::UnicodeString Prefix);
	System::UnicodeString __fastcall TextOutList();
	
protected:
	virtual System::UnicodeString __fastcall BeginCanvasTag(System::Uitypes::TColor ABackColor);
	virtual Vcltee::Tecanvas::TVisualBlock* __fastcall BeginEntity(const System::UnicodeString Entity, Vcltee::Tecanvas::TVisualBlock* const Visual = (Vcltee::Tecanvas::TVisualBlock*)(0x0), Vcltee::Tecanvas::TTeeTransform* const Transform = (Vcltee::Tecanvas::TTeeTransform*)(0x0));
	virtual System::UnicodeString __fastcall EndCanvasTag();
	virtual void __fastcall EndEntity();
	virtual bool __fastcall GetSupportsFullRotation();
	virtual void __fastcall InternalRect(const System::Types::TRect &Rect, bool UsePen, bool IsRound);
	
public:
	bool ScrollBars;
	__fastcall virtual TXAML3DCanvas(Vcltee::Teeprocs::TCustomTeePanel* const Panel, System::Classes::TStrings* const AStrings);
	__fastcall virtual ~TXAML3DCanvas();
	virtual void __fastcall Cone(bool Vertical, int Left, int Top, int Right, int Bottom, int Z0, int Z1, bool Dark3D, int ConePercent);
	virtual void __fastcall Cube(int Left, int Right, int Top, int Bottom, int Z0, int Z1, bool DarkSides = true, int RoundSize = 0x0)/* overload */;
	virtual void __fastcall EraseBackground(const System::Types::TRect &Rect);
	virtual void __fastcall LineTo(const int X, const int Y)/* overload */;
	virtual void __fastcall LineTo3D(const int X, const int Y, const int Z)/* overload */;
	virtual void __fastcall MoveTo3D(const int X, const int Y, const int Z)/* overload */;
	virtual void __fastcall Polygon(const System::Types::TPoint *Points, const int Points_High);
	virtual void __fastcall RectangleWithZ(const System::Types::TRect &Rect, int Z);
	virtual void __fastcall TextOut3D(int X, int Y, int Z, const System::UnicodeString Text, bool AllowHTML = false)/* overload */;
public:
	/* TTeeNeutralCanvas.Create */ inline __fastcall virtual TXAML3DCanvas() : TXAMLCanvas() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  Cube(int Left, int Right, int Top, int Bottom, int Z0, int Z1, int BevelSize, bool DarkSides = true, int RoundSize = 0x0){ Vcltee::Tecanvas::TTeeCanvas3D::Cube(Left, Right, Top, Bottom, Z0, Z1, BevelSize, DarkSides, RoundSize); }
	inline void __fastcall  Cube(const System::Types::TRect &R, int Z0, int Z1, bool DarkSides = true, int RoundSize = 0x0){ Vcltee::Tecanvas::TCanvas3D::Cube(R, Z0, Z1, DarkSides, RoundSize); }
	inline void __fastcall  LineTo(const System::Types::TPoint &P){ Vcltee::Tecanvas::TTeeCanvas::LineTo(P); }
	inline void __fastcall  LineTo(const _POINTFLOAT &P){ Vcltee::Tecanvas::TTeeCanvas::LineTo(P); }
	inline void __fastcall  LineTo3D(const Vcltee::Tecanvas::TPoint3D &P){ Vcltee::Tecanvas::TCanvas3D::LineTo3D(P); }
	inline void __fastcall  LineTo3D(const float X, const float Y, const float Z){ Vcltee::Tecanvas::TCanvas3D::LineTo3D(X, Y, Z); }
	inline void __fastcall  MoveTo3D(const Vcltee::Tecanvas::TPoint3D &P){ Vcltee::Tecanvas::TCanvas3D::MoveTo3D(P); }
	inline void __fastcall  MoveTo3D(const float X, const float Y, const float Z){ Vcltee::Tecanvas::TCanvas3D::MoveTo3D(X, Y, Z); }
	inline void __fastcall  TextOut3D(int x, int y, int z, const System::UnicodeString Text){ Vcltee::Tecanvas::TCanvas3D::TextOut3D(x, y, z, Text); }
	
};


class PASCALIMPLEMENTATION TXAMLExportFormat : public Vcltee::Teeexport::TTeeExportFormat
{
	typedef Vcltee::Teeexport::TTeeExportFormat inherited;
	
private:
	Vcl::Forms::TForm* FProperties;
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
	virtual Vcl::Forms::TForm* __fastcall Options(bool Check = true);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream)/* overload */;
public:
	/* TTeeExportFormat.Create */ inline __fastcall virtual TXAMLExportFormat() : Vcltee::Teeexport::TTeeExportFormat() { }
	/* TTeeExportFormat.Destroy */ inline __fastcall virtual ~TXAMLExportFormat() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  SaveToStream(System::Classes::TStream* Stream, Vcl::Forms::TForm* const AOptions){ Vcltee::Teeexport::TTeeExportFormat::SaveToStream(Stream, AOptions); }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall TeeSaveToXAMLFile(Vcltee::Teeprocs::TCustomTeePanel* const APanel, const System::UnicodeString FileName, int AWidth = 0x0, int AHeight = 0x0, bool XAML3D = false);
}	/* namespace Teexamlcanvas */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEXAMLCANVAS)
using namespace Vcltee::Teexamlcanvas;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeexamlcanvasHPP
