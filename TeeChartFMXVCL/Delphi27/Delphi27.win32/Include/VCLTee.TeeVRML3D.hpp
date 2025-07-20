// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeVRML3D.pas' rev: 34.00 (Windows)

#ifndef Vcltee_Teevrml3dHPP
#define Vcltee_Teevrml3dHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeExport.hpp>
#include <System.Math.Vectors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teevrml3d
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TVRMLOptions;
class DELPHICLASS TVRML3DCanvas;
class DELPHICLASS TVRMLExportFormat;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TVRMLOptions : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* LabelWWW;
	Vcl::Stdctrls::TButton* BRun;
	void __fastcall LabelWWWClick(System::TObject* Sender);
	void __fastcall BRunClick(System::TObject* Sender);
	
private:
	Vcltee::Teeprocs::TCustomTeePanel* Panel;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TVRMLOptions(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TVRMLOptions(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TVRMLOptions() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TVRMLOptions(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TVRML3DCanvas : public Vcltee::Tecanvas::TTeeNeutralCanvas
{
	typedef Vcltee::Tecanvas::TTeeNeutralCanvas inherited;
	
private:
	int FX;
	int FY;
	int FZ;
	bool IClosedLine;
	System::Classes::TStrings* IStrings;
	System::UnicodeString __fastcall ABCToString(const double A, const double B, const double C);
	void __fastcall AddAppearance()/* overload */;
	void __fastcall AddAppearance(System::Uitypes::TColor AColor)/* overload */;
	void __fastcall AddTransform(int X, int Y, int Z);
	System::UnicodeString __fastcall AllPoints(const System::Types::TPoint *Points, const int Points_High, int Z)/* overload */;
	System::UnicodeString __fastcall AllPoints(const Vcltee::Tecanvas::TPoint3D *Points, const int Points_High)/* overload */;
	System::UnicodeString __fastcall AllPoints(const System::Types::TRect &Rect, int Z)/* overload */;
	System::UnicodeString __fastcall AllPoints(const System::Math::Vectors::TPoint3D *Points, const int Points_High)/* overload */;
	void __fastcall EndTransform();
	System::UnicodeString __fastcall Indexes(int Max);
	void __fastcall InternalPolygon3D(const System::UnicodeString Points, int ALength);
	void __fastcall Polygon3DFloat(const System::Math::Vectors::TPoint3D *Points, const int Points_High);
	System::UnicodeString __fastcall VRMLColor(System::Uitypes::TColor AColor);
	System::UnicodeString __fastcall XYZ(const double X, const double Y, const double Z);
	
protected:
	virtual Vcltee::Tecanvas::TVisualBlock* __fastcall BeginEntity(const System::UnicodeString Entity, Vcltee::Tecanvas::TVisualBlock* const Visual = (Vcltee::Tecanvas::TVisualBlock*)(0x0), Vcltee::Tecanvas::TTeeTransform* const Transform = (Vcltee::Tecanvas::TTeeTransform*)(0x0));
	virtual void __fastcall EndEntity();
	virtual HDC __fastcall GetHandle();
	virtual bool __fastcall GetIsNoBMPGrid();
	virtual System::Uitypes::TColor __fastcall GetPixel(int x, int y);
	virtual System::Uitypes::TColor __fastcall GetPixel3D(int X, int Y, int Z);
	virtual bool __fastcall GetSupports3DText();
	virtual bool __fastcall GetSupportsFullRotation();
	virtual bool __fastcall GetSupportsXORMode();
	virtual bool __fastcall GetUseBuffer();
	virtual void __fastcall SetPixel(int X, int Y, System::Uitypes::TColor Value);
	virtual void __fastcall SetPixel3D(int X, int Y, int Z, System::Uitypes::TColor Value);
	virtual void __fastcall SetUseBuffer(bool Value);
	
public:
	__fastcall TVRML3DCanvas(Vcltee::Teeprocs::TCustomTeePanel* Panel, System::Classes::TStrings* AStrings);
	__fastcall virtual ~TVRML3DCanvas();
	__classmethod virtual System::UnicodeString __fastcall Description();
	virtual System::Types::TRect __fastcall InitWindow(Vcl::Graphics::TCanvas* const DestCanvas, Vcltee::Tecanvas::TView3DOptions* const A3DOptions, System::Uitypes::TColor ABackColor, bool Is3D, const System::Types::TRect &UserRect);
	virtual void __fastcall Projection(int MaxDepth, const System::Types::TRect &ABounds, const System::Types::TRect &Rect);
	virtual bool __fastcall ReDrawBitmap();
	virtual void __fastcall ShowImage(Vcl::Graphics::TCanvas* const DestCanvas, Vcl::Graphics::TCanvas* const DefaultCanvas, const System::Types::TRect &UserRect);
	virtual void __fastcall Calculate2DPosition(int &x, int &y, int z)/* overload */;
	virtual System::Types::TPoint __fastcall Calculate3DPosition(int x, int y, int z)/* overload */;
	virtual void __fastcall ClipRectangle(const System::Types::TRect &Rect)/* overload */;
	virtual void __fastcall UnClipRectangle();
	virtual void __fastcall Arc(const int Left, const int Top, const int Right, const int Bottom, const int StartX, const int StartY, const int EndX, const int EndY)/* overload */;
	virtual void __fastcall Arrow(bool Filled, const System::Types::TPoint &FromPoint, const System::Types::TPoint &ToPoint, int ArrowWidth, int ArrowHeight, int Z0, int Z1, const double ArrowPercent)/* overload */;
	virtual void __fastcall Cone(bool Vertical, int Left, int Top, int Right, int Bottom, int Z0, int Z1, bool Dark3D, int ConePercent);
	virtual void __fastcall Cylinder(bool Vertical, int Left, int Top, int Right, int Bottom, int Z0, int Z1, bool Dark3D = true);
	virtual void __fastcall Cube(int Left, int Right, int Top, int Bottom, int Z0, int Z1, bool DarkSides = true, int RoundSize = 0x0)/* overload */;
	virtual void __fastcall Cube(int Left, int Right, int Top, int Bottom, int Z0, int Z1, int BevelSize, bool DarkSides = true, int RoundSize = 0x0)/* overload */;
	virtual void __fastcall Donut(int XCenter, int YCenter, int XRadius, int YRadius, const double StartAngle, const double EndAngle, const double HolePercent)/* overload */;
	virtual void __fastcall Draw(int X, int Y, Vcl::Graphics::TGraphic* const Graphic);
	virtual void __fastcall Ellipse(const int X1, const int Y1, const int X2, const int Y2)/* overload */;
	virtual void __fastcall EllipseWithZ(const int X1, const int Y1, const int X2, const int Y2, const int Z)/* overload */;
	virtual void __fastcall EraseBackground(const System::Types::TRect &Rect);
	virtual void __fastcall FillRect(const System::Types::TRect &Rect);
	virtual void __fastcall GradientFill(const System::Types::TRect &Rect, System::Uitypes::TColor StartColor, System::Uitypes::TColor EndColor, Vcltee::Tecanvas::TGradientDirection Direction, int Balance = 0x32, int RadialX = 0x0, int RadialY = 0x0)/* overload */;
	virtual void __fastcall Invalidate();
	virtual void __fastcall LineTo(const int X, const int Y)/* overload */;
	virtual void __fastcall LineTo3D(const int X, const int Y, const int Z)/* overload */;
	virtual void __fastcall MoveTo(const int X, const int Y)/* overload */;
	virtual void __fastcall MoveTo3D(const int X, const int Y, const int Z)/* overload */;
	virtual void __fastcall Pie(int X1, int Y1, int X2, int Y2, int X3, int Y3, int X4, int Y4)/* overload */;
	virtual void __fastcall Pie(const System::Types::TRect &R, const double StartAngle, const double EndAngle)/* overload */;
	virtual void __fastcall Pie3D(int XCenter, int YCenter, int XRadius, int YRadius, int Z0, int Z1, const double StartAngle, const double EndAngle, bool DarkSides, bool DrawSides, int DonutPercent = 0x0, Vcltee::Tecanvas::TCustomTeeGradient* Gradient = (Vcltee::Tecanvas::TCustomTeeGradient*)(0x0), int BevelPercent = 0x0, Vcltee::Tecanvas::TEdgeStyle EdgeStyle = (Vcltee::Tecanvas::TEdgeStyle)(0x2), Vcltee::Tecanvas::TTeeTransparency Transparency = (Vcltee::Tecanvas::TTeeTransparency)(0x0), int BevelBright = 0x0, bool BevelBorder = true, bool HideSides = false);
	virtual void __fastcall Plane3D(const System::Types::TPoint &A, const System::Types::TPoint &B, int Z0, int Z1);
	virtual void __fastcall PlaneFour3D(Vcltee::Tecanvas::TFourPoints &Points, int Z0, int Z1);
	virtual void __fastcall PlaneWithZ(const System::Types::TPoint &P1, const System::Types::TPoint &P2, const System::Types::TPoint &P3, const System::Types::TPoint &P4, int Z)/* overload */;
	virtual void __fastcall Polygon(const System::Types::TPoint *Points, const int Points_High);
	virtual void __fastcall Polygon3D(const Vcltee::Tecanvas::TPoint3D *Points, const int Points_High)/* overload */;
	virtual void __fastcall PolygonWithZ(const System::Types::TPoint *Points, const int Points_High, int Z);
	virtual void __fastcall Polyline(const System::Types::TPoint *Points, const int Points_High)/* overload */;
	virtual void __fastcall Polyline(const System::Types::TPoint *Points, const int Points_High, int Z)/* overload */;
	HIDESBASE void __fastcall Polyline(const Vcltee::Tecanvas::TPoint3D *Points, const int Points_High)/* overload */;
	HIDESBASE void __fastcall Polyline(const System::Math::Vectors::TPoint3D *Points, const int Points_High)/* overload */;
	virtual void __fastcall Pyramid(bool Vertical, int Left, int Top, int Right, int Bottom, int z0, int z1, bool DarkSides = true);
	virtual void __fastcall Rectangle(const int X0, const int Y0, const int X1, const int Y1)/* overload */;
	virtual void __fastcall RectangleWithZ(const System::Types::TRect &Rect, int Z);
	virtual void __fastcall RectangleY(const int Left, const int Top, const int Right, const int Z0, const int Z1);
	virtual void __fastcall RectangleZ(const int Left, const int Top, const int Bottom, const int Z0, const int Z1);
	virtual void __fastcall RotateLabel(int x, int y, const System::UnicodeString St, double RotDegree, bool AllowHTML = false);
	virtual void __fastcall RotateLabel3D(int x, int y, int z, const System::UnicodeString St, double RotDegree, bool AllowHTML = false);
	virtual void __fastcall RoundRect(int X1, int Y1, int X2, int Y2, int X3, int Y3)/* overload */;
	virtual void __fastcall Sphere(int x, int y, int z, const double Radius)/* overload */;
	virtual void __fastcall Surface3D(Vcltee::Tecanvas::TTeeCanvasSurfaceStyle Style, bool SameBrush, bool CreateCached, bool AddNormals, int NumXValues, int NumZValues, const Vcltee::Tecanvas::TTeeCanvasCalcPoints CalcPoints, Vcltee::Tecanvas::TTeeCachedObject* &Cached);
	virtual void __fastcall StretchDraw(const System::Types::TRect &Rect, Vcl::Graphics::TGraphic* const Graphic)/* overload */;
	virtual void __fastcall TextOut(int X, int Y, const System::UnicodeString Text)/* overload */;
	virtual void __fastcall TextOut3D(int X, int Y, int Z, const System::UnicodeString Text, bool AllowHTML = false)/* overload */;
	virtual void __fastcall Triangle3D(const Vcltee::Tecanvas::TTrianglePoints3D &Points, const Vcltee::Tecanvas::TTriangleColors3D &Colors);
	virtual void __fastcall TriangleWithZ(const System::Types::TPoint &P1, const System::Types::TPoint &P2, const System::Types::TPoint &P3, int Z);
public:
	/* TTeeNeutralCanvas.Create */ inline __fastcall virtual TVRML3DCanvas() : Vcltee::Tecanvas::TTeeNeutralCanvas() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  Calculate3DPosition(_POINTFLOAT &P, const float zPos){ Vcltee::Tecanvas::TTeeCanvas3D::Calculate3DPosition(P, zPos); }
	inline System::Types::TPoint __fastcall  Calculate3DPosition(const Vcltee::Tecanvas::TPoint3D &P){ return Vcltee::Tecanvas::TCanvas3D::Calculate3DPosition(P); }
	inline System::Types::TPoint __fastcall  Calculate3DPosition(const System::Types::TPoint &P, int z){ return Vcltee::Tecanvas::TCanvas3D::Calculate3DPosition(P, z); }
	inline void __fastcall  ClipRectangle(const System::Types::TRect &Rect, int RoundX, int RoundY){ Vcltee::Tecanvas::TTeeCanvas::ClipRectangle(Rect, RoundX, RoundY); }
	inline void __fastcall  Arc(const int Left, const int Top, const int Right, const int Bottom, const int StartX, const int StartY, const int EndX, const int EndY, const int Z){ Vcltee::Tecanvas::TCanvas3D::Arc(Left, Top, Right, Bottom, StartX, StartY, EndX, EndY, Z); }
	inline void __fastcall  Arc(const int Left, const int Top, const int Right, const int Bottom, const float StartAngle, const float EndAngle){ Vcltee::Tecanvas::TTeeCanvas::Arc(Left, Top, Right, Bottom, StartAngle, EndAngle); }
	inline void __fastcall  Arc(const System::Types::TRect &R, const float StartAngle, const float EndAngle){ Vcltee::Tecanvas::TTeeCanvas::Arc(R, StartAngle, EndAngle); }
	inline void __fastcall  Arrow(bool Filled, const System::Types::TPoint &FromPoint, const System::Types::TPoint &ToPoint, int ArrowWidth, int ArrowHeight, int Z){ Vcltee::Tecanvas::TCanvas3D::Arrow(Filled, FromPoint, ToPoint, ArrowWidth, ArrowHeight, Z); }
	inline void __fastcall  Arrow(bool Filled, const double ArrowPercent, const System::Types::TPoint &FromPoint, const System::Types::TPoint &ToPoint, int ArrowWidth, int ArrowHeight){ Vcltee::Tecanvas::TTeeCanvas::Arrow(Filled, ArrowPercent, FromPoint, ToPoint, ArrowWidth, ArrowHeight); }
	inline void __fastcall  Cube(const System::Types::TRect &R, int Z0, int Z1, bool DarkSides = true, int RoundSize = 0x0){ Vcltee::Tecanvas::TCanvas3D::Cube(R, Z0, Z1, DarkSides, RoundSize); }
	inline void __fastcall  Ellipse(const System::Types::TRect &R){ Vcltee::Tecanvas::TTeeCanvas::Ellipse(R); }
	inline void __fastcall  EllipseWithZ(const System::Types::TRect &Rect, int Z){ Vcltee::Tecanvas::TCanvas3D::EllipseWithZ(Rect, Z); }
	inline void __fastcall  GradientFill(Vcltee::Tecanvas::TCustomTeeGradient* const Gradient, const System::Types::TRect &Rect){ Vcltee::Tecanvas::TTeeCanvas3D::GradientFill(Gradient, Rect); }
	inline void __fastcall  LineTo(const System::Types::TPoint &P){ Vcltee::Tecanvas::TTeeCanvas::LineTo(P); }
	inline void __fastcall  LineTo(const _POINTFLOAT &P){ Vcltee::Tecanvas::TTeeCanvas::LineTo(P); }
	inline void __fastcall  LineTo3D(const Vcltee::Tecanvas::TPoint3D &P){ Vcltee::Tecanvas::TCanvas3D::LineTo3D(P); }
	inline void __fastcall  LineTo3D(const float X, const float Y, const float Z){ Vcltee::Tecanvas::TCanvas3D::LineTo3D(X, Y, Z); }
	inline void __fastcall  MoveTo(const System::Types::TPoint &P){ Vcltee::Tecanvas::TTeeCanvas::MoveTo(P); }
	inline void __fastcall  MoveTo(const _POINTFLOAT &P){ Vcltee::Tecanvas::TTeeCanvas::MoveTo(P); }
	inline void __fastcall  MoveTo3D(const Vcltee::Tecanvas::TPoint3D &P){ Vcltee::Tecanvas::TCanvas3D::MoveTo3D(P); }
	inline void __fastcall  MoveTo3D(const float X, const float Y, const float Z){ Vcltee::Tecanvas::TCanvas3D::MoveTo3D(X, Y, Z); }
	inline void __fastcall  PlaneWithZ(const Vcltee::Tecanvas::TFourPoints &P, int Z){ Vcltee::Tecanvas::TCanvas3D::PlaneWithZ(P, Z); }
	inline void __fastcall  Rectangle(const System::Types::TRect &R, int Z){ Vcltee::Tecanvas::TCanvas3D::Rectangle(R, Z); }
	inline void __fastcall  Rectangle(const int X0, const int Y0, const int X1, const int Y1, int Z){ Vcltee::Tecanvas::TCanvas3D::Rectangle(X0, Y0, X1, Y1, Z); }
	inline void __fastcall  Rectangle(const System::Types::TRect &R){ Vcltee::Tecanvas::TTeeCanvas::Rectangle(R); }
	inline void __fastcall  RoundRect(const System::Types::TRect &R, int X, int Y, int Z0, int Z1){ Vcltee::Tecanvas::TCanvas3D::RoundRect(R, X, Y, Z0, Z1); }
	inline void __fastcall  RoundRect(const System::Types::TRect &R, int X, int Y, Vcltee::Tecanvas::TTeeCorners* const ACorners = (Vcltee::Tecanvas::TTeeCorners*)(0x0)){ Vcltee::Tecanvas::TTeeCanvas::RoundRect(R, X, Y, ACorners); }
	inline void __fastcall  StretchDraw(const System::Types::TRect &Rect, Vcl::Graphics::TGraphic* const Graphic, const double Pos, Vcltee::Tecanvas::TCanvas3DPlane Plane = (Vcltee::Tecanvas::TCanvas3DPlane)(0x2)){ Vcltee::Tecanvas::TCanvas3D::StretchDraw(Rect, Graphic, Pos, Plane); }
	inline void __fastcall  TextOut(const int X, const int Y, const System::UnicodeString Text, bool AllowHtml){ Vcltee::Tecanvas::TTeeCanvas::TextOut(X, Y, Text, AllowHtml); }
	inline void __fastcall  TextOut3D(int x, int y, int z, const System::UnicodeString Text){ Vcltee::Tecanvas::TCanvas3D::TextOut3D(x, y, z, Text); }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TVRMLExportFormat : public Vcltee::Teeexport::TTeeExportFormat
{
	typedef Vcltee::Teeexport::TTeeExportFormat inherited;
	
private:
	void __fastcall CheckProperties();
	
protected:
	TVRMLOptions* FProperties;
	virtual void __fastcall DoCopyToClipboard();
	
public:
	__fastcall virtual ~TVRMLExportFormat();
	virtual System::UnicodeString __fastcall Description();
	virtual System::UnicodeString __fastcall FileExtension();
	__classmethod virtual System::UnicodeString __fastcall FileFilter();
	System::Classes::TStringList* __fastcall VRML();
	virtual Vcl::Forms::TForm* __fastcall Options(bool Check = true);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream)/* overload */;
public:
	/* TTeeExportFormat.Create */ inline __fastcall virtual TVRMLExportFormat() : Vcltee::Teeexport::TTeeExportFormat() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  SaveToStream(System::Classes::TStream* Stream, Vcl::Forms::TForm* const AOptions){ Vcltee::Teeexport::TTeeExportFormat::SaveToStream(Stream, AOptions); }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall TeeSaveToVRML(Vcltee::Teeprocs::TCustomTeePanel* APanel, const System::WideString FileName);
}	/* namespace Teevrml3d */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEVRML3D)
using namespace Vcltee::Teevrml3d;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_Teevrml3dHPP
