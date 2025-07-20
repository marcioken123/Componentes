// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeGLCanvas.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeglcanvasHPP
#define Vcltee_TeeglcanvasHPP

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
#include <System.UITypes.hpp>
#include <System.Math.Vectors.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <System.Types.hpp>
#include <VCLTee.OpenGL2.hpp>
#include <VCLTee.TeeConst.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeglcanvas
{
//-- forward type declarations -----------------------------------------------
struct TGLFontCache;
struct TTeeTexture;
struct TGLColorCache;
class DELPHICLASS TGLCachedObject;
class DELPHICLASS TGLCanvas;
class DELPHICLASS TAlphaBitmap;
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<float, 4> GLMat;

struct DECLSPEC_DRECORD TGLFontCache
{
public:
	int Offset;
	System::UnicodeString Name;
	int Weight;
	System::Uitypes::TFontStyles Style;
	float Extrusion;
	Vcltee::Tecanvas::TTeeFontStyle GLStyle;
	int Size;
};


struct DECLSPEC_DRECORD TTeeTexture
{
public:
	Vcl::Graphics::TGraphic* Graphic;
	unsigned GLTexture;
};


enum DECLSPEC_DENUM TGLScreenSync : unsigned char { ssSystem, ssYes, ssNo };

enum DECLSPEC_DENUM TGLColorDepth : unsigned char { cd24Bit, cd32Bit };

struct DECLSPEC_DRECORD TGLColorCache
{
public:
	System::Uitypes::TColor Color;
	float Transp;
};


typedef bool __fastcall (__closure *TGLGetPicBits)(Vcl::Graphics::TGraphic* AGraphic, System::Sysutils::PByteArray &Bits);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TGLCachedObject : public Vcltee::Tecanvas::TTeeCachedObject
{
	typedef Vcltee::Tecanvas::TTeeCachedObject inherited;
	
	
private:
	typedef System::DynamicArray<int> _TGLCachedObject__1;
	
	
private:
	_TGLCachedObject__1 Lists;
	void __fastcall AddList();
	
public:
	__fastcall virtual ~TGLCachedObject();
public:
	/* TObject.Create */ inline __fastcall TGLCachedObject() : Vcltee::Tecanvas::TTeeCachedObject() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TGLCanvas : public Vcltee::Tecanvas::TTeeNeutralCanvas
{
	typedef Vcltee::Tecanvas::TTeeNeutralCanvas inherited;
	
	
private:
	typedef System::DynamicArray<TTeeTexture> _TGLCanvas__1;
	
	typedef System::StaticArray<TGLFontCache, 101> _TGLCanvas__2;
	
	
private:
	int FAntialiasLevel;
	TGLColorDepth FColorDepth;
	int FDepth;
	Vcltee::Tecanvas::TTeeCanvasSurfaceStyle FDrawStyle;
	float FFontExtrusion;
	float FShininess;
	int FTextureQuality;
	int FWidth;
	int FHeight;
	System::Classes::TNotifyEvent FOnFinish;
	System::Classes::TNotifyEvent FOnInit;
	HDC FDC;
	HGLRC HRC;
	float FX;
	float FY;
	float FZ;
	bool FIs3D;
	int INumFonts;
	bool FUseBuffer;
	bool IDrawToBitmap;
	Vcl::Graphics::TCanvas* IDestCanvas;
	Vcltee::Opengl2::TGLUQuadric *FQuadric;
	bool IQuadricTexture;
	int IMaxTexSize;
	TGLColorCache IOldColor;
	float IOldPenWidth;
	Vcl::Graphics::TPenStyle IOldPenStyle;
	bool IPenAlpha;
	_TGLCanvas__1 ITextures;
	int IOldDepth;
	Vcltee::Opengl2::TGLUTesselator *ITess;
	Vcltee::Opengl2::TGLUTesselator *ITess2D;
	System::Byte IWasDepthTest;
	System::Byte IWasLighting;
	float __fastcall CalcZoom();
	void __fastcall DeleteTexture(int Index);
	void __fastcall DeleteTextures();
	void __fastcall DestroyGLContext();
	int __fastcall FontWeight();
	HDC __fastcall GetDCHandle();
	void __fastcall InitMatrix();
	void __fastcall InternalGradient(const Vcltee::Tecanvas::TFourPoints &P, Vcltee::Tecanvas::TTeeGradientColors* const Colors, Vcltee::Tecanvas::TGradientDirection Direction, int Balance = 0x32, int RadialX = 0x0, int RadialY = 0x0, const float Z = 0.000000E+00f)/* overload */;
	void __fastcall InternalGradient(const System::Types::TRect &R, const float Z)/* overload */;
	void __fastcall InternalRectangle(const System::Types::TRect &Rect)/* overload */;
	void __fastcall InternalRectangle(const System::Types::TRect &Rect, const float Z)/* overload */;
	bool __fastcall InternalUseBuffer();
	void __fastcall PrepareTess();
	void __fastcall PrepareTessDirect();
	Vcltee::Opengl2::PGLUQuadric __fastcall Quadric();
	void __fastcall SetAntialiasLevel(const int Value);
	void __fastcall SetColorDepth(const TGLColorDepth Value);
	void __fastcall SetFontExtrusion(const float Value);
	void __fastcall SetPolygonMode();
	void __fastcall SetShininess(const float Value);
	
protected:
	float ITextureRepeatX;
	float ITextureRepeatY;
	bool IAntiAlias;
	bool IActiveBlend;
	bool ITransp3D;
	bool IZeroAtCenter;
	bool ICanNPOTS;
	bool IRelaxedNPOTS;
	TGLGetPicBits FOnGetPicBits;
	void __fastcall ApplyPolygonOffset(bool Enable);
	void __fastcall CreateFontOutlines(int Index);
	void __fastcall DoConcave(const Vcltee::Opengl2::TAffineDblVector *Points, const int Points_High, const bool Invert = false);
	bool __fastcall GetPixelAttribute(int Attribute, int APixelFormat, int &Value);
	TGLScreenSync __fastcall GetSync();
	bool __fastcall GetTexQuality();
	unsigned __fastcall GLTextureStyle();
	void __fastcall InitOpenGLFont();
	void __fastcall InitAmbientLight(int AmbientLight);
	HIDESBASE void __fastcall InternalCylinder(bool Vertical, int Left, int Top, int Right, int Bottom, int Z0, int Z1, bool Dark3D, int ConePercent, Vcltee::Tecanvas::TTeeBrush* const Side1 = (Vcltee::Tecanvas::TTeeBrush*)(0x0), Vcltee::Tecanvas::TTeeBrush* const Side2 = (Vcltee::Tecanvas::TTeeBrush*)(0x0));
	void __fastcall InternalEllipse(const System::Types::TRect &R, const float Z);
	void __fastcall EndBrushBitmap()/* overload */;
	void __fastcall EndBrushBitmap(Vcl::Graphics::TGraphic* const Graphic)/* overload */;
	int __fastcall QuadricDrawStyle();
	virtual void __fastcall SetAntiAlias(const bool Value);
	bool __fastcall SetBrushBitmap()/* overload */;
	bool __fastcall SetBrushBitmap(Vcl::Graphics::TGraphic* const Graphic)/* overload */;
	void __fastcall SetBrushBitmap(Vcl::Graphics::TGraphic* const Graphic, unsigned AGLTexture)/* overload */;
	void __fastcall SetDrawStyle(Vcltee::Tecanvas::TTeeCanvasSurfaceStyle Value);
	void __fastcall SetSync(const TGLScreenSync Value);
	void __fastcall SetTexQuality(bool Value);
	virtual Vcltee::Tecanvas::TVisualBlock* __fastcall BeginEntity(const System::UnicodeString Entity, Vcltee::Tecanvas::TVisualBlock* const Visual = (Vcltee::Tecanvas::TVisualBlock*)(0x0), Vcltee::Tecanvas::TTeeTransform* const Transform = (Vcltee::Tecanvas::TTeeTransform*)(0x0));
	virtual void __fastcall EndEntity();
	void __fastcall BeginBrush(const unsigned Mode);
	void __fastcall BeginPen()/* overload */;
	void __fastcall BeginPen(const unsigned Mode)/* overload */;
	void __fastcall BeginPen(const unsigned Mode, Vcltee::Tecanvas::TTeePen* const APen)/* overload */;
	virtual void __fastcall DoChangedBrush(Vcltee::Tecanvas::TTeeBrush* const ABrush);
	virtual void __fastcall DoChangedPen();
	void __fastcall EndPen();
	virtual Vcltee::Tecanvas::TCanvasStyle __fastcall CanvasStyle();
	virtual HDC __fastcall GetHandle();
	virtual System::Uitypes::TColor __fastcall GetPixel(int x, int y);
	virtual System::Uitypes::TColor __fastcall GetPixel3D(int X, int Y, int Z);
	virtual bool __fastcall GetSupports3DText();
	virtual bool __fastcall GetSupportsFullRotation();
	virtual bool __fastcall GetSupportsXORMode();
	virtual bool __fastcall GetUseBuffer();
	bool __fastcall IsPenVisible();
	void __fastcall SetPen(Vcltee::Tecanvas::TTeePen* const APen);
	virtual void __fastcall SetPixel(int X, int Y, System::Uitypes::TColor Value);
	virtual void __fastcall SetPixel3D(int X, int Y, int Z, System::Uitypes::TColor Value);
	virtual void __fastcall SetUseBuffer(bool Value);
	virtual void __fastcall SmoothShadow(Vcltee::Tecanvas::TTeeShadow* const Shadow, const System::Types::TRect &Rect, bool Ellipse, int RoundSize, const System::Types::TPoint *P, const int P_High, int DonutPercent = 0x0, const double StartAngle = 0.000000E+00, const double EndAngle = 3.600000E+02);
	void __fastcall TeeNormal(const int x, const int y, const int z)/* overload */;
	void __fastcall TeeNormal(const float x, const float y, const float z)/* overload */;
	void __fastcall TeeVertex2D(const int x, const int y);
	void __fastcall TeeVertex3D(const System::Types::TPoint &P, const float z)/* overload */;
	void __fastcall TeeVertex3D(const System::Types::TPoint &P, int z)/* overload */;
	void __fastcall TeeVertex3D(const int x, const int y, const int z)/* overload */;
	void __fastcall TeeVertex3D(const float x, const float y, const float z)/* overload */;
	void __fastcall TeeVertex3D(const Vcltee::Tecanvas::TPoint3D &P)/* overload */;
	virtual void __fastcall FastLineTo(const int X, const int Y);
	virtual void __fastcall SetFastLine(const bool Active);
	virtual Vcltee::Tecanvas::TPointFloatArray __fastcall Tessellate(const double *X, const int X_High, const double *Y, const int Y_High);
	System::Classes::TNotifyEvent FOnProjection;
	_TGLCanvas__2 FontCache;
	unsigned ISavedError;
	bool UsesStencil;
	void __fastcall ActivateBlend(const bool Value);
	Vcl::Graphics::TGraphic* __fastcall AddNewTexture(Vcl::Graphics::TGraphic* AGraphic, unsigned AGLTexture);
	void __fastcall CalcMinMax(const System::Math::Vectors::TPoint3D *Points, const int Points_High, System::Math::Vectors::TPoint3D &AMin, System::Math::Vectors::TPoint3D &AMax);
	void __fastcall CheckContext();
	void __fastcall DoProjection(bool DoPick = false, int x = 0x0, int y = 0x0);
	int __fastcall FindFont();
	bool __fastcall FindTexture(Vcl::Graphics::TGraphic* const AGraphic, /* out */ unsigned &AGLTexture);
	void __fastcall InitLight(int Num, const GLMat &AAmbient, const GLMat &ADiffuse, const GLMat &ASpecular, const System::Math::Vectors::TPoint3D &Position, const System::Math::Vectors::TPoint3D &Direction, bool UseDirection, const float SpotDegrees, int SpotExponent);
	void __fastcall RemoveTexture(Vcl::Graphics::TGraphic* const AGraphic);
	void __fastcall SetModelView();
	void __fastcall SetTextureParams();
	__property int CachedFonts = {read=INumFonts, nodefault};
	
public:
	int AmbientLight;
	Vcltee::Tecanvas::TTeeFontStyle FontStyle;
	bool ShadeQuality;
	float ZoomCorrection;
	__fastcall virtual TGLCanvas();
	__fastcall virtual ~TGLCanvas();
	void __fastcall BufferToBitmap(Vcl::Graphics::TBitmap* const ABitmap, const System::Types::TRect &R);
	bool __fastcall CheckGLError();
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall EditorClass();
	void __fastcall DeleteFont(int Index)/* overload */;
	void __fastcall DeleteFont()/* overload */;
	void __fastcall Repaint();
	virtual void __fastcall DisableRotation();
	virtual void __fastcall EnableRotation();
	void __fastcall SetMaterialColor();
	virtual Vcltee::Tecanvas::TTeeBlend* __fastcall BeginBlending(const System::Types::TRect &R, Vcltee::Tecanvas::TTeeTransparency Transparency);
	virtual void __fastcall EndBlending(Vcltee::Tecanvas::TTeeBlend* const Blend);
	virtual void __fastcall Arc(const int Left, const int Top, const int Right, const int Bottom, const int StartX, const int StartY, const int EndX, const int EndY)/* overload */;
	virtual void __fastcall Donut(int XCenter, int YCenter, int XRadius, int YRadius, const double StartAngle, const double EndAngle, const double HolePercent)/* overload */;
	virtual void __fastcall Draw(int X, int Y, Vcl::Graphics::TGraphic* const Graphic);
	virtual void __fastcall EraseBackground(const System::Types::TRect &Rect);
	virtual void __fastcall Ellipse(const int X1, const int Y1, const int X2, const int Y2)/* overload */;
	virtual void __fastcall FillRect(const System::Types::TRect &Rect);
	virtual void __fastcall LineTo(const int X, const int Y)/* overload */;
	virtual void __fastcall MoveTo(const int X, const int Y)/* overload */;
	virtual void __fastcall MoveTo(const _POINTFLOAT &P)/* overload */;
	virtual void __fastcall Pie(const System::Types::TRect &R, const double StartAngle, const double EndAngle)/* overload */;
	virtual void __fastcall Pie(int X1, int Y1, int X2, int Y2, int X3, int Y3, int X4, int Y4)/* overload */;
	virtual void __fastcall Rectangle(const int X0, const int Y0, const int X1, const int Y1)/* overload */;
	virtual void __fastcall RoundRect(int X1, int Y1, int X2, int Y2, int X3, int Y3)/* overload */;
	void __fastcall SetColor(const System::Uitypes::TColor AColor);
	virtual void __fastcall StretchDraw(const System::Types::TRect &Rect, Vcl::Graphics::TGraphic* const Graphic)/* overload */;
	virtual void __fastcall TextOut(int X, int Y, const System::UnicodeString Text)/* overload */;
	virtual void __fastcall ClipRectangle(const System::Types::TRect &Rect)/* overload */;
	virtual void __fastcall GradientFill(const System::Types::TRect &Rect, System::Uitypes::TColor StartColor, System::Uitypes::TColor EndColor, Vcltee::Tecanvas::TGradientDirection Direction, int Balance = 0x32, int RadialX = 0x0, int RadialY = 0x0)/* overload */;
	virtual void __fastcall Polyline(const System::Types::TPoint *Points, const int Points_High, int Z)/* overload */;
	virtual void __fastcall Polyline(const System::Types::TPoint *Points, const int Points_High)/* overload */;
	HIDESBASE void __fastcall Polyline(const Vcltee::Tecanvas::TPoint3D *Points, const int Points_High)/* overload */;
	virtual void __fastcall PolylineFloat(const _POINTFLOAT *Points, const int Points_High)/* overload */;
	virtual void __fastcall PolylineFloat(const System::Math::Vectors::TPoint3D *Points, const int Points_High)/* overload */;
	virtual void __fastcall Polygon(const System::Types::TPoint *Points, const int Points_High);
	virtual void __fastcall PolygonConcave(const System::Types::TPoint *Points, const int Points_High)/* overload */;
	virtual void __fastcall PolygonConcave(const System::Types::TPoint *Points, const int Points_High, int Z)/* overload */;
	virtual void __fastcall RotateLabel(int x, int y, const System::UnicodeString St, double RotDegree, bool AllowHTML = false);
	virtual void __fastcall UnClipRectangle();
	HIDESBASE _POINTFLOAT __fastcall Calculate2DPosition(const float x, const float y, const float z)/* overload */;
	virtual void __fastcall Calculate2DPosition(int &x, int &y, int z)/* overload */;
	virtual System::Types::TPoint __fastcall Calculate3DPosition(int x, int y, int z)/* overload */;
	virtual System::Types::TRect __fastcall InitWindow(Vcl::Graphics::TCanvas* const DestCanvas, Vcltee::Tecanvas::TView3DOptions* const A3DOptions, System::Uitypes::TColor ABackColor, bool Is3D, const System::Types::TRect &UserRect);
	virtual void __fastcall Projection(int MaxDepth, const System::Types::TRect &Bounds, const System::Types::TRect &Rect);
	virtual void __fastcall ShowImage(Vcl::Graphics::TCanvas* const DestCanvas, Vcl::Graphics::TCanvas* const DefaultCanvas, const System::Types::TRect &UserRect);
	virtual bool __fastcall ReDrawBitmap();
	virtual bool __fastcall RenderToBitmap(Vcl::Graphics::TBitmap* &ABitmap, const System::Types::TRect &R);
	virtual void __fastcall Arrow(bool Filled, const System::Types::TPoint &FromPoint, const System::Types::TPoint &ToPoint, int ArrowWidth, int ArrowHeight, int Z0, int Z1, const double ArrowPercent)/* overload */;
	virtual void __fastcall Cone(bool Vertical, int Left, int Top, int Right, int Bottom, int Z0, int Z1, bool Dark3D, int ConePercent);
	virtual void __fastcall Cube(int Left, int Right, int Top, int Bottom, int Z0, int Z1, bool DarkSides, int RoundSize = 0x0)/* overload */;
	HIDESBASE void __fastcall Cube(float Left, float Right, float Top, float Bottom, float Z0, float Z1, bool DarkSides, int RoundSize = 0x0)/* overload */;
	HIDESBASE void __fastcall Cube(const System::Math::Vectors::TPoint3D &MinBounds, const System::Math::Vectors::TPoint3D &MaxBounds)/* overload */;
	virtual void __fastcall Cylinder(bool Vertical, int Left, int Top, int Right, int Bottom, int Z0, int Z1, bool DarkCover);
	virtual void __fastcall DrawCheckBox(int x, int y, bool Checked, const System::Uitypes::TColor ABackColor, bool CheckBox = true);
	virtual void __fastcall EllipseWithZ(const int X1, const int Y1, const int X2, const int Y2, const int Z)/* overload */;
	HIDESBASE void __fastcall Line(const System::Math::Vectors::TPoint3D &A, const System::Math::Vectors::TPoint3D &B);
	HIDESBASE void __fastcall LineTo(const float X, const float Y)/* overload */;
	virtual void __fastcall LineTo3D(const int X, const int Y, const int Z)/* overload */;
	virtual void __fastcall LineTo3D(const float X, const float Y, const float Z)/* overload */;
	virtual void __fastcall LineWithZ(int X0, int Y0, int X1, int Y1, int Z)/* overload */;
	virtual void __fastcall MoveTo3D(const int X, const int Y, const int Z)/* overload */;
	virtual void __fastcall MoveTo3D(const float X, const float Y, const float Z)/* overload */;
	virtual void __fastcall Pie3D(int XCenter, int YCenter, int XRadius, int YRadius, int Z0, int Z1, const double StartAngle, const double EndAngle, bool DarkSides, bool DrawSides, int DonutPercent = 0x0, Vcltee::Tecanvas::TCustomTeeGradient* Gradient = (Vcltee::Tecanvas::TCustomTeeGradient*)(0x0), int BevelPercent = 0x0, Vcltee::Tecanvas::TEdgeStyle EdgeStyle = (Vcltee::Tecanvas::TEdgeStyle)(0x2), Vcltee::Tecanvas::TTeeTransparency Transparency = (Vcltee::Tecanvas::TTeeTransparency)(0x0), int BevelBright = 0x0, bool BevelBorder = true, bool HideSides = false)/* overload */;
	virtual void __fastcall Plane3D(const System::Types::TPoint &A, const System::Types::TPoint &B, int Z0, int Z1);
	void __fastcall Plane3DFloat(const _POINTFLOAT &A, const _POINTFLOAT &B, const float Z0, const float Z1);
	virtual void __fastcall PlaneWithZ(const System::Types::TPoint &P1, const System::Types::TPoint &P2, const System::Types::TPoint &P3, const System::Types::TPoint &P4, int Z)/* overload */;
	virtual void __fastcall PlaneFour3D(Vcltee::Tecanvas::TFourPoints &Points, int Z0, int Z1);
	virtual void __fastcall Polygon3D(const Vcltee::Tecanvas::TPoint3D *Points, const int Points_High)/* overload */;
	void __fastcall Polygon3DFloat(const System::Math::Vectors::TPoint3D *Points, const int Points_High)/* overload */;
	virtual void __fastcall Polygon3DConcave(const System::Math::Vectors::TPoint3D *Points, const int Points_High, const bool Invert = false)/* overload */;
	virtual void __fastcall Polygon3DConcave(const Vcltee::Tecanvas::TPoint3D *Points, const int Points_High, const bool Invert = false)/* overload */;
	virtual void __fastcall PolygonWithZ(const System::Types::TPoint *Points, const int Points_High, int Z);
	virtual void __fastcall Pyramid(bool Vertical, int Left, int Top, int Right, int Bottom, int z0, int z1, bool DarkSides);
	virtual void __fastcall PyramidTrunc(const System::Types::TRectF &R, const double StartZ, const double EndZ, const double TruncX, const double TruncZ, bool TopCover = true, bool BottomCover = true);
	virtual void __fastcall RectangleWithZ(const System::Types::TRect &Rect, int Z);
	virtual void __fastcall RectangleY(const int Left, const int Top, const int Right, const int Z0, const int Z1);
	virtual void __fastcall RectangleZ(const int Left, const int Top, const int Bottom, const int Z0, const int Z1);
	virtual void __fastcall RotateLabel3D(int x, int y, int z, const System::UnicodeString St, double RotDegree, bool AllowHTML = false);
	virtual void __fastcall Sphere(int x, int y, int z, const double Radius)/* overload */;
	HIDESBASE void __fastcall Sphere(const float x, const float y, const float z, const float Radius)/* overload */;
	HIDESBASE void __fastcall Sphere(const System::Math::Vectors::TPoint3D &Center, const System::Math::Vectors::TPoint3D &Radius)/* overload */;
	virtual void __fastcall StretchDraw(const System::Types::TRect &Rect, Vcl::Graphics::TGraphic* const Graphic, const double Pos, Vcltee::Tecanvas::TCanvas3DPlane Plane = (Vcltee::Tecanvas::TCanvas3DPlane)(0x2))/* overload */;
	virtual void __fastcall Surface3D(Vcltee::Tecanvas::TTeeCanvasSurfaceStyle Style, bool SameBrush, bool CreateCached, bool AddNormals, int NumXValues, int NumZValues, const Vcltee::Tecanvas::TTeeCanvasCalcPoints CalcPoints, Vcltee::Tecanvas::TTeeCachedObject* &Cached);
	void __fastcall Tetrahedron(float Left, float Top, float Right, float Bottom, float z0, float z1);
	void __fastcall TextOut3DFloat(float X, float Y, float Z, const System::UnicodeString Text);
	virtual void __fastcall TextOut3D(int x, int y, int z, const System::UnicodeString Text, bool AllowHTML)/* overload */;
	virtual void __fastcall Triangle3D(const Vcltee::Tecanvas::TTrianglePoints3D &Points, const Vcltee::Tecanvas::TTriangleColors3D &Colors);
	virtual void __fastcall Triangles(const Vcltee::Tecanvas::TPoint3D *P, const int P_High, bool CreateCached, Vcltee::Tecanvas::TTeeCachedObject* &Cached);
	virtual void __fastcall TriangleWithZ(const System::Types::TPoint &P1, const System::Types::TPoint &P2, const System::Types::TPoint &P3, int Z);
	virtual void __fastcall TriSurface(int NumTriangles, bool CreateCached, bool AddNormals, Vcltee::Tecanvas::TTeeBlend* const Blend, Vcltee::Tecanvas::TTeeTransparency Transparency, const Vcltee::Tecanvas::TTeeCanvasTriPoints CalcPoints, Vcltee::Tecanvas::TTeeCachedObject* &Cached);
	__property int AntialiasLevel = {read=FAntialiasLevel, write=SetAntialiasLevel, default=4};
	__property TGLColorDepth ColorDepth = {read=FColorDepth, write=SetColorDepth, default=0};
	__property Vcltee::Tecanvas::TTeeCanvasSurfaceStyle DrawStyle = {read=FDrawStyle, write=SetDrawStyle, default=0};
	__property float FontExtrusion = {read=FFontExtrusion, write=SetFontExtrusion};
	__property float Shininess = {read=FShininess, write=FShininess};
	__property bool TextureQuality = {read=GetTexQuality, write=SetTexQuality, default=1};
	__property TGLScreenSync ScreenSync = {read=GetSync, write=SetSync, default=0};
	__property System::Classes::TNotifyEvent OnInit = {read=FOnInit, write=FOnInit};
	__property System::Classes::TNotifyEvent OnFinish = {read=FOnFinish, write=FOnFinish};
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  Arc(const int Left, const int Top, const int Right, const int Bottom, const int StartX, const int StartY, const int EndX, const int EndY, const int Z){ Vcltee::Tecanvas::TCanvas3D::Arc(Left, Top, Right, Bottom, StartX, StartY, EndX, EndY, Z); }
	inline void __fastcall  Arc(const int Left, const int Top, const int Right, const int Bottom, const float StartAngle, const float EndAngle){ Vcltee::Tecanvas::TTeeCanvas::Arc(Left, Top, Right, Bottom, StartAngle, EndAngle); }
	inline void __fastcall  Arc(const System::Types::TRect &R, const float StartAngle, const float EndAngle){ Vcltee::Tecanvas::TTeeCanvas::Arc(R, StartAngle, EndAngle); }
	inline void __fastcall  Ellipse(const System::Types::TRect &R){ Vcltee::Tecanvas::TTeeCanvas::Ellipse(R); }
	inline void __fastcall  LineTo(const System::Types::TPoint &P){ Vcltee::Tecanvas::TTeeCanvas::LineTo(P); }
	inline void __fastcall  LineTo(const _POINTFLOAT &P){ Vcltee::Tecanvas::TTeeCanvas::LineTo(P); }
	inline void __fastcall  MoveTo(const System::Types::TPoint &P){ Vcltee::Tecanvas::TTeeCanvas::MoveTo(P); }
	inline void __fastcall  Rectangle(const System::Types::TRect &R, int Z){ Vcltee::Tecanvas::TCanvas3D::Rectangle(R, Z); }
	inline void __fastcall  Rectangle(const int X0, const int Y0, const int X1, const int Y1, int Z){ Vcltee::Tecanvas::TCanvas3D::Rectangle(X0, Y0, X1, Y1, Z); }
	inline void __fastcall  Rectangle(const System::Types::TRect &R){ Vcltee::Tecanvas::TTeeCanvas::Rectangle(R); }
	inline void __fastcall  RoundRect(const System::Types::TRect &R, int X, int Y, int Z0, int Z1){ Vcltee::Tecanvas::TCanvas3D::RoundRect(R, X, Y, Z0, Z1); }
	inline void __fastcall  RoundRect(const System::Types::TRect &R, int X, int Y, Vcltee::Tecanvas::TTeeCorners* const ACorners = (Vcltee::Tecanvas::TTeeCorners*)(0x0)){ Vcltee::Tecanvas::TTeeCanvas::RoundRect(R, X, Y, ACorners); }
	inline void __fastcall  TextOut(const int X, const int Y, const System::UnicodeString Text, bool AllowHtml){ Vcltee::Tecanvas::TTeeCanvas::TextOut(X, Y, Text, AllowHtml); }
	inline void __fastcall  ClipRectangle(const System::Types::TRect &Rect, int RoundX, int RoundY){ Vcltee::Tecanvas::TTeeCanvas::ClipRectangle(Rect, RoundX, RoundY); }
	inline void __fastcall  GradientFill(Vcltee::Tecanvas::TCustomTeeGradient* const Gradient, const System::Types::TRect &Rect){ Vcltee::Tecanvas::TTeeCanvas3D::GradientFill(Gradient, Rect); }
	inline void __fastcall  Calculate3DPosition(_POINTFLOAT &P, const float zPos){ Vcltee::Tecanvas::TTeeCanvas3D::Calculate3DPosition(P, zPos); }
	inline System::Types::TPoint __fastcall  Calculate3DPosition(const Vcltee::Tecanvas::TPoint3D &P){ return Vcltee::Tecanvas::TCanvas3D::Calculate3DPosition(P); }
	inline System::Types::TPoint __fastcall  Calculate3DPosition(const System::Types::TPoint &P, int z){ return Vcltee::Tecanvas::TCanvas3D::Calculate3DPosition(P, z); }
	inline void __fastcall  Arrow(bool Filled, const System::Types::TPoint &FromPoint, const System::Types::TPoint &ToPoint, int ArrowWidth, int ArrowHeight, int Z){ Vcltee::Tecanvas::TCanvas3D::Arrow(Filled, FromPoint, ToPoint, ArrowWidth, ArrowHeight, Z); }
	inline void __fastcall  Arrow(bool Filled, const double ArrowPercent, const System::Types::TPoint &FromPoint, const System::Types::TPoint &ToPoint, int ArrowWidth, int ArrowHeight){ Vcltee::Tecanvas::TTeeCanvas::Arrow(Filled, ArrowPercent, FromPoint, ToPoint, ArrowWidth, ArrowHeight); }
	inline void __fastcall  Cube(int Left, int Right, int Top, int Bottom, int Z0, int Z1, int BevelSize, bool DarkSides = true, int RoundSize = 0x0){ Vcltee::Tecanvas::TTeeCanvas3D::Cube(Left, Right, Top, Bottom, Z0, Z1, BevelSize, DarkSides, RoundSize); }
	inline void __fastcall  Cube(const System::Types::TRect &R, int Z0, int Z1, bool DarkSides = true, int RoundSize = 0x0){ Vcltee::Tecanvas::TCanvas3D::Cube(R, Z0, Z1, DarkSides, RoundSize); }
	inline void __fastcall  EllipseWithZ(const System::Types::TRect &Rect, int Z){ Vcltee::Tecanvas::TCanvas3D::EllipseWithZ(Rect, Z); }
	inline void __fastcall  LineTo3D(const Vcltee::Tecanvas::TPoint3D &P){ Vcltee::Tecanvas::TCanvas3D::LineTo3D(P); }
	inline void __fastcall  LineWithZ(const System::Types::TPoint &FromPoint, const System::Types::TPoint &ToPoint, int Z){ Vcltee::Tecanvas::TCanvas3D::LineWithZ(FromPoint, ToPoint, Z); }
	inline void __fastcall  MoveTo3D(const Vcltee::Tecanvas::TPoint3D &P){ Vcltee::Tecanvas::TCanvas3D::MoveTo3D(P); }
	inline void __fastcall  PlaneWithZ(const Vcltee::Tecanvas::TFourPoints &P, int Z){ Vcltee::Tecanvas::TCanvas3D::PlaneWithZ(P, Z); }
	inline void __fastcall  TextOut3D(int x, int y, int z, const System::UnicodeString Text){ Vcltee::Tecanvas::TCanvas3D::TextOut3D(x, y, z, Text); }
	
};


class PASCALIMPLEMENTATION TAlphaBitmap : public Vcl::Graphics::TBitmap
{
	typedef Vcl::Graphics::TBitmap inherited;
	
public:
	/* TBitmap.Create */ inline __fastcall virtual TAlphaBitmap()/* overload */ : Vcl::Graphics::TBitmap() { }
	/* TBitmap.Create */ inline __fastcall TAlphaBitmap(int AWidth, int AHeight)/* overload */ : Vcl::Graphics::TBitmap(AWidth, AHeight) { }
	/* TBitmap.Destroy */ inline __fastcall virtual ~TAlphaBitmap() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::WideChar *TeeOpenGLFontName;
extern DELPHI_PACKAGE float TeeMaterialAmbient;
extern DELPHI_PACKAGE float TeeMaterialDiffuse;
extern DELPHI_PACKAGE float TeeMaterialSpecular;
extern DELPHI_PACKAGE float TeeMaterialEmission;
extern DELPHI_PACKAGE unsigned TeeFullLightModel;
extern DELPHI_PACKAGE unsigned TeeLightLocal;
extern DELPHI_PACKAGE unsigned TeeColorPlanes;
extern DELPHI_PACKAGE int TeeTextAngleY;
extern DELPHI_PACKAGE int TeeTextAngleZ;
extern DELPHI_PACKAGE float TeeTextWidthFactor;
extern DELPHI_PACKAGE float TeeTextHeightFactor;
extern DELPHI_PACKAGE int TeeDefaultLightSpot;
extern DELPHI_PACKAGE int TeeSphereSlices;
extern DELPHI_PACKAGE int TeeSphereStacks;
extern DELPHI_PACKAGE int TeeCylinderStacks;
extern DELPHI_PACKAGE unsigned TeeSmoothQuality;
extern DELPHI_PACKAGE unsigned TeePerspectiveQuality;
extern DELPHI_PACKAGE int TeeTextureEnvMode;
extern DELPHI_PACKAGE bool TeePolygonOffset;
extern DELPHI_PACKAGE bool TeeWrapTextures;
static const System::Byte TeeFontListRange = System::Byte(0xe1);
static const System::Int8 TeeMaxFonts = System::Int8(0x64);
extern DELPHI_PACKAGE int TeeSpotExponent;
}	/* namespace Teeglcanvas */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEGLCANVAS)
using namespace Vcltee::Teeglcanvas;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeglcanvasHPP
