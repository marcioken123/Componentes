// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Canvas.PDF.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Canvas_PdfHPP
#define Fmxtee_Canvas_PdfHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.Generics.Collections.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Graphics.hpp>
#include <System.Types.hpp>
#include <System.Math.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Editor.Export.hpp>
#include <System.Generics.Defaults.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Canvas
{
namespace Pdf
{
//-- forward type declarations -----------------------------------------------
struct TFontData;
class DELPHICLASS TPDFEntry;
class DELPHICLASS TPDFImageListEntry;
class DELPHICLASS TPDFImageList;
class DELPHICLASS TPDFFontListEntry;
class DELPHICLASS TPDFFontList;
class DELPHICLASS TPDFPattern;
class DELPHICLASS TPDFPatterns;
class DELPHICLASS TPDFPage;
class DELPHICLASS TPDFDocument;
class DELPHICLASS TPDFCanvas;
class DELPHICLASS TPDFExportFormat;
//-- type declarations -------------------------------------------------------
typedef TFontData *PFontData;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TFontData
{
public:
	System::Types::TRectF FontBBox;
	int FirstChar;
	int LastChar;
	int CapHeight;
	int Ascent;
	int Descent;
	int MaxWidth;
	int AvgWidth;
	float ItalicAngle;
	int DigAspX;
	int DigAspY;
	System::StaticArray<int, 256> CharWidths;
};
#pragma pack(pop)


#pragma pack(push,4)
class PASCALIMPLEMENTATION TPDFEntry : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FObjectNumber;
	void __fastcall SetObjectNumber(const int Value);
	
public:
	__property int ObjectNumber = {read=FObjectNumber, write=SetObjectNumber, nodefault};
public:
	/* TObject.Create */ inline __fastcall TPDFEntry() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TPDFEntry() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TImageType : unsigned char { itJPEG, itBitmap, itUnknown };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TPDFImageListEntry : public TPDFEntry
{
	typedef TPDFEntry inherited;
	
private:
	Fmx::Graphics::TBitmap* FGraphic;
	int FHeight;
	int FWidth;
	void __fastcall DefineImageData();
	int __fastcall GetDataLength();
	TImageType __fastcall GetImageType();
	
public:
	__fastcall TPDFImageListEntry(Fmx::Graphics::TBitmap* const AGraphic);
	__fastcall virtual ~TPDFImageListEntry();
	void __fastcall WriteDataToStream(System::Classes::TStream* const AStream);
	__property int DataLength = {read=GetDataLength, nodefault};
	__property int Height = {read=FHeight, nodefault};
	__property TImageType ImageType = {read=GetImageType, nodefault};
	__property int Width = {read=FWidth, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TPDFImageList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TPDFImageListEntry* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Generics::Collections::TList__1<TPDFImageListEntry*>* IList;
	bool __fastcall EqualImages(Fmx::Graphics::TBitmap* const i1, Fmx::Graphics::TBitmap* const i2);
	int __fastcall GetCount();
	TPDFImageListEntry* __fastcall Get(int Index);
	
public:
	__fastcall TPDFImageList();
	__fastcall virtual ~TPDFImageList();
	__property TPDFImageListEntry* Items[int Index] = {read=Get/*, default*/};
	__property int Count = {read=GetCount, nodefault};
	int __fastcall Select(Fmx::Graphics::TBitmap* const AGraphic);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TPDFFontListEntry : public TPDFEntry
{
	typedef TPDFEntry inherited;
	
private:
	TFontData FFontData;
	System::UnicodeString FPDFName;
	void __fastcall DefineFontData(Fmx::Graphics::TFont* const AFont);
	
public:
	__fastcall TPDFFontListEntry(Fmx::Graphics::TFont* const AFont);
	__property System::UnicodeString PDFName = {read=FPDFName};
	__property TFontData FontData = {read=FFontData};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TPDFFontListEntry() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TPDFFontList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TPDFFontListEntry* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Generics::Collections::TList__1<TPDFFontListEntry*>* IList;
	TPDFFontListEntry* __fastcall Get(int Index);
	int __fastcall GetCount();
	
public:
	__fastcall TPDFFontList();
	__fastcall virtual ~TPDFFontList();
	__property TPDFFontListEntry* Items[int Index] = {read=Get/*, default*/};
	__property int Count = {read=GetCount, nodefault};
	int __fastcall Select(Fmx::Graphics::TFont* const AFont);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TPDFPattern : public TPDFEntry
{
	typedef TPDFEntry inherited;
	
private:
	Fmxtee::Canvas::TTeeGradient* FGradient;
	System::Types::TRectF IRect;
	System::UnicodeString __fastcall PDFRect();
	System::UnicodeString __fastcall RadialCoords();
	
public:
	__fastcall TPDFPattern(Fmxtee::Canvas::TTeeGradient* const AGradient, const System::Types::TRectF &ARect);
	__fastcall virtual ~TPDFPattern();
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TPDFPatterns : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TPDFPattern* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Generics::Collections::TList__1<TPDFPattern*>* IList;
	TPDFPattern* __fastcall Get(int Index);
	int __fastcall GetCount();
	
public:
	__fastcall TPDFPatterns();
	__fastcall virtual ~TPDFPatterns();
	__property TPDFPattern* Items[int Index] = {read=Get/*, default*/};
	__property int Count = {read=GetCount, nodefault};
	int __fastcall Select(Fmxtee::Canvas::TTeeGradient* const AGradient, const System::Types::TRectF &ARect);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TPDFPage : public System::Classes::TMemoryStream
{
	typedef System::Classes::TMemoryStream inherited;
	
public:
	void __fastcall SaveTo(System::Classes::TStream* const AStream);
public:
	/* TMemoryStream.Destroy */ inline __fastcall virtual ~TPDFPage() { }
	
public:
	/* TObject.Create */ inline __fastcall TPDFPage() : System::Classes::TMemoryStream() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TPDFPageSize : unsigned char { psDefault, psA3, psA4, psA5, psLetter, psLegal, psTabloid, psCustom };

enum DECLSPEC_DENUM TPDFPageOrientation : unsigned char { poPortrait, poLandscape };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TPDFDocument : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<TPDFPage*> _TPDFDocument__1;
	
	
public:
	TPDFPage* operator[](int Index) { return this->Items[Index]; }
	
private:
	_TPDFDocument__1 FItems;
	int FHeight;
	int FWidth;
	TPDFPageOrientation FOrientation;
	TPDFPageSize FSize;
	TPDFPatterns* FPatterns;
	TPDFFontList* FFonts;
	TPDFImageList* FImages;
	int IObjCount;
	int CatalogNum;
	int ParentNum;
	int ResourceNum;
	System::Classes::TStringList* OffsetList;
	int XRefPos;
	TPDFPage* __fastcall GetItem(int Index);
	int __fastcall NewObject(System::Classes::TStream* const AStream);
	bool __fastcall SaveFonts();
	void __fastcall SetHeight(const int Value);
	void __fastcall SetOrientation(const TPDFPageOrientation Value);
	void __fastcall SetSize(const TPDFPageSize Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall WriteHeader(System::Classes::TStream* const AStream);
	void __fastcall WriteInfo(System::Classes::TStream* const AStream);
	void __fastcall WritePatterns(System::Classes::TStream* const AStream);
	void __fastcall WriteTTFonts(System::Classes::TStream* const AStream);
	void __fastcall WriteImages(System::Classes::TStream* const AStream);
	void __fastcall WriteResources(System::Classes::TStream* const AStream);
	void __fastcall WritePages(System::Classes::TStream* const AStream);
	void __fastcall WritePage(System::Classes::TStream* const AStream);
	void __fastcall WriteCatalog(System::Classes::TStream* const AStream);
	void __fastcall WriteXRef(System::Classes::TStream* const AStream);
	void __fastcall WriteTrailer(System::Classes::TStream* const AStream);
	
public:
	__fastcall TPDFDocument();
	__fastcall virtual ~TPDFDocument();
	TPDFPage* __fastcall NewPage();
	void __fastcall SaveToStream(System::Classes::TStream* const AStream);
	__property TPDFFontList* Fonts = {read=FFonts};
	__property TPDFImageList* Images = {read=FImages};
	__property TPDFPage* Items[int Index] = {read=GetItem/*, default*/};
	__property TPDFPatterns* Patterns = {read=FPatterns};
	__property TPDFPageOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property int Height = {read=FHeight, write=SetHeight, nodefault};
	__property TPDFPageSize Size = {read=FSize, write=SetSize, default=0};
	__property int Width = {read=FWidth, write=SetWidth, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TPDFCanvas : public Fmxtee::Canvas::TTeeNeutralCanvas
{
	typedef Fmxtee::Canvas::TTeeNeutralCanvas inherited;
	
private:
	double FX;
	double FY;
	bool FEmbeddedFonts;
	System::Classes::TStream* FCStream;
	TPDFDocument* FContents;
	Fmx::Graphics::TBitmap* IControl;
	bool IOwnsReference;
	bool IOwnsDoc;
	int IClipStack;
	System::UnicodeString __fastcall BrushProperties(Fmxtee::Canvas::TTeeBrush* const ABrush, const System::Types::TRectF &R)/* overload */;
	System::UnicodeString __fastcall BrushProperties(const System::Types::TRectF &R)/* overload */;
	void __fastcall CheckReferenceCanvas();
	void __fastcall EndPenBrush();
	System::UnicodeString __fastcall FontProperties(Fmxtee::Canvas::TTeeFont* const Font, /* out */ int &FontIndex);
	System::UnicodeString __fastcall InternalBezCurve(const double ax1, const double ay1, const double ax2, const double ay2, const double ax3, const double ay3);
	void __fastcall InternalDrawArc(int X1, int Y1, int X2, int Y2, int X3, int Y3, int X4, int Y4, bool MoveTo0, bool DrawPie);
	void __fastcall InternalDrawImage(const double sx, const double sy, const double tx, const double ty, int ImageIndex);
	void __fastcall InternalRect(const System::Types::TRectF &Rect, bool UsePen, int RoundX = 0x0, int RoundY = 0x0);
	System::UnicodeString __fastcall PenProperties()/* overload */;
	System::UnicodeString __fastcall PenProperties(Fmxtee::Canvas::TTeePen* const APen)/* overload */;
	System::UnicodeString __fastcall PointToStr(const System::Types::TPointF &P)/* overload */;
	System::UnicodeString __fastcall PointToStr(const double X, const double Y)/* overload */;
	void __fastcall SetEmbeddedFonts(const bool Value);
	System::UnicodeString __fastcall TextToPDFText(const System::UnicodeString AText);
	double __fastcall TranslateVertCoord(const double Y)/* overload */;
	int __fastcall TranslateVertCoord(const int Y)/* overload */;
	
protected:
	virtual bool __fastcall GetIsNoBMPGrid();
	virtual void __fastcall SetPixel(int X, int Y, System::Uitypes::TAlphaColor Value);
	virtual void __fastcall SetPixel3D(int X, int Y, int Z, System::Uitypes::TAlphaColor Value);
	
public:
	__fastcall virtual TPDFCanvas();
	__fastcall TPDFCanvas(TPDFDocument* const ADocument, const int PageIndex);
	__fastcall virtual ~TPDFCanvas();
	virtual System::Types::TRectF __fastcall InitWindow(Fmx::Graphics::TCanvas* const DestCanvas, Fmxtee::Canvas::TView3DOptions* const A3DOptions, System::Uitypes::TAlphaColor ABackColor, bool Is3D, const System::Types::TRectF &UserRect);
	void __fastcall SaveToFile(const System::UnicodeString APath);
	void __fastcall SaveToStream(System::Classes::TStream* const AStream);
	virtual int __fastcall TextWidth(const System::UnicodeString St)/* overload */;
	virtual void __fastcall Arc(const int Left, const int Top, const int Right, const int Bottom, const int StartX, const int StartY, const int EndX, const int EndY)/* overload */;
	virtual void __fastcall Draw(int X, int Y, Fmx::Graphics::TBitmap* const Graphic);
	virtual void __fastcall FillRect(const System::Types::TRectF &Rect);
	virtual void __fastcall Ellipse(const float X1, const float Y1, const float X2, const float Y2)/* overload */;
	virtual void __fastcall LineTo(const float X, const float Y)/* overload */;
	virtual void __fastcall MoveTo(const float X, const float Y)/* overload */;
	virtual void __fastcall Pie(int X1, int Y1, int X2, int Y2, int X3, int Y3, int X4, int Y4)/* overload */;
	virtual void __fastcall Polyline(const System::Types::TPointF *Points, const int Points_High)/* overload */;
	virtual void __fastcall Rectangle(const float X0, const float Y0, const float X1, const float Y1)/* overload */;
	virtual void __fastcall RoundRect(int X1, int Y1, int X2, int Y2, int X3, int Y3)/* overload */;
	virtual void __fastcall StretchDraw(const System::Types::TRectF &Rect, Fmx::Graphics::TBitmap* const Graphic)/* overload */;
	virtual void __fastcall TextOut(const float X, const float Y, const System::UnicodeString Text)/* overload */;
	virtual void __fastcall ClipRectangle(const System::Types::TRectF &Rect)/* overload */;
	virtual void __fastcall ClipRectangle(const System::Types::TRectF &Rect, int RoundX, int RoundY)/* overload */;
	virtual void __fastcall UnClipRectangle();
	virtual void __fastcall GradientFill(const System::Types::TRectF &Rect, System::Uitypes::TAlphaColor StartColor, System::Uitypes::TAlphaColor EndColor, Fmxtee::Canvas::TGradientDirection Direction, int Balance = 0x32, int RadialX = 0x0, int RadialY = 0x0)/* overload */;
	virtual void __fastcall RotateLabel(int x, int y, const System::UnicodeString St, double RotDegree, bool AllowHTML = false);
	virtual void __fastcall RotateLabel3D(int x, int y, int z, const System::UnicodeString St, double RotDegree, bool AllowHTML = false);
	virtual void __fastcall Polygon(const System::Types::TPointF *Points, const int Points_High);
	virtual void __fastcall EllipseWithZ(const float X1, const float Y1, const float X2, const float Y2, const int Z)/* overload */;
	virtual void __fastcall TextOut3D(int X, int Y, int Z, const System::UnicodeString Text, bool AllowHTML = false)/* overload */;
	virtual void __fastcall ShowImage(Fmx::Graphics::TCanvas* const DestCanvas, Fmx::Graphics::TCanvas* const DefaultCanvas, const System::Types::TRectF &UserRect);
	TPDFPage* __fastcall NewPage();
	__property TPDFDocument* Document = {read=FContents};
	__property bool EmbeddedFonts = {read=FEmbeddedFonts, write=SetEmbeddedFonts, default=0};
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  Arc(const int Left, const int Top, const int Right, const int Bottom, const int StartX, const int StartY, const int EndX, const int EndY, const int Z){ Fmxtee::Canvas::TCanvas3D::Arc(Left, Top, Right, Bottom, StartX, StartY, EndX, EndY, Z); }
	inline void __fastcall  Arc(const int Left, const int Top, const int Right, const int Bottom, const float StartAngle, const float EndAngle){ Fmxtee::Canvas::TTeeCanvas::Arc(Left, Top, Right, Bottom, StartAngle, EndAngle); }
	inline void __fastcall  Arc(const System::Types::TRect &R, const float StartAngle, const float EndAngle){ Fmxtee::Canvas::TTeeCanvas::Arc(R, StartAngle, EndAngle); }
	inline void __fastcall  Ellipse(const System::Types::TRectF &R){ Fmxtee::Canvas::TTeeCanvas::Ellipse(R); }
	inline void __fastcall  LineTo(const System::Types::TPointF &P){ Fmxtee::Canvas::TTeeCanvas::LineTo(P); }
	inline void __fastcall  MoveTo(const System::Types::TPointF &P){ Fmxtee::Canvas::TTeeCanvas::MoveTo(P); }
	inline void __fastcall  Pie(const System::Types::TRectF &R, const double StartAngle, const double EndAngle){ Fmxtee::Canvas::TTeeCanvas3D::Pie(R, StartAngle, EndAngle); }
	inline void __fastcall  Polyline(const System::Types::TPointF *Points, const int Points_High, int Z){ Fmxtee::Canvas::TCanvas3D::Polyline(Points, Points_High, Z); }
	inline void __fastcall  Rectangle(const System::Types::TRectF &R, int Z){ Fmxtee::Canvas::TCanvas3D::Rectangle(R, Z); }
	inline void __fastcall  Rectangle(const float X0, const float Y0, const float X1, const float Y1, int Z){ Fmxtee::Canvas::TCanvas3D::Rectangle(X0, Y0, X1, Y1, Z); }
	inline void __fastcall  Rectangle(const System::Types::TRectF &R){ Fmxtee::Canvas::TTeeCanvas::Rectangle(R); }
	inline void __fastcall  RoundRect(const System::Types::TRectF &R, int X, int Y, int Z0, int Z1){ Fmxtee::Canvas::TCanvas3D::RoundRect(R, X, Y, Z0, Z1); }
	inline void __fastcall  RoundRect(const System::Types::TRectF &R, int X, int Y, Fmxtee::Canvas::TTeeCorners* const ACorners = (Fmxtee::Canvas::TTeeCorners*)(0x0)){ Fmxtee::Canvas::TTeeCanvas::RoundRect(R, X, Y, ACorners); }
	inline void __fastcall  StretchDraw(const System::Types::TRectF &Rect, Fmx::Graphics::TBitmap* const Graphic, const double Pos, Fmxtee::Canvas::TCanvas3DPlane Plane = (Fmxtee::Canvas::TCanvas3DPlane)(0x2)){ Fmxtee::Canvas::TCanvas3D::StretchDraw(Rect, Graphic, Pos, Plane); }
	inline void __fastcall  TextOut(const float X, const float Y, const System::UnicodeString Text, bool AllowHtml){ Fmxtee::Canvas::TTeeCanvas::TextOut(X, Y, Text, AllowHtml); }
	inline void __fastcall  GradientFill(Fmxtee::Canvas::TCustomTeeGradient* const Gradient, const System::Types::TRectF &Rect){ Fmxtee::Canvas::TTeeCanvas3D::GradientFill(Gradient, Rect); }
	inline void __fastcall  EllipseWithZ(const System::Types::TRectF &Rect, int Z){ Fmxtee::Canvas::TCanvas3D::EllipseWithZ(Rect, Z); }
	inline void __fastcall  TextOut3D(int x, int y, int z, const System::UnicodeString Text){ Fmxtee::Canvas::TCanvas3D::TextOut3D(x, y, z, Text); }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TPDFPosition : unsigned char { ppCenter, ppStretch, ppFit, ppCustom };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TPDFExportFormat : public Fmxtee::Editor::Export::TTeeExportFormat
{
	typedef Fmxtee::Editor::Export::TTeeExportFormat inherited;
	
private:
	System::Types::TRectF FBounds;
	TPDFPageOrientation FOrientation;
	TPDFPageSize FPageSize;
	TPDFPosition FPosition;
	TPDFDocument* FDocument;
	Fmx::Forms::TForm* FProperties;
	void __fastcall CheckProperties();
	TPDFDocument* __fastcall GetDocument();
	void __fastcall DrawTo(TPDFDocument* const APage, const System::Types::TRectF &ARect, TPDFCanvas* const ACanvas = (TPDFCanvas*)(0x0));
	
protected:
	virtual void __fastcall DoCopyToClipboard();
	
public:
	__fastcall virtual TPDFExportFormat();
	__classmethod System::Types::TRectF __fastcall CalcRectangle(Fmxtee::Procs::TCustomTeePanel* const APanel, TPDFDocument* const ADocument, const TPDFPosition APosition, const System::Types::TRectF &ABounds);
	virtual System::UnicodeString __fastcall Description();
	__classmethod void __fastcall Draw(TPDFCanvas* const ACanvas, Fmxtee::Procs::TCustomTeePanel* const APanel, const System::Types::TRectF &ARect);
	virtual Fmx::Forms::TForm* __fastcall Editor(System::Classes::TComponent* AOwner);
	virtual System::UnicodeString __fastcall FileExtension();
	__classmethod virtual System::UnicodeString __fastcall FileFilter();
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream)/* overload */;
	void __fastcall AddPanel(Fmxtee::Procs::TCustomTeePanel* APanel, int AWidth = 0x0, int AHeight = 0x0);
	__property System::Types::TRectF Bounds = {read=FBounds, write=FBounds};
	__property TPDFPageOrientation Orientation = {read=FOrientation, write=FOrientation, nodefault};
	__property TPDFPageSize PageSize = {read=FPageSize, write=FPageSize, default=7};
	__property TPDFPosition Position = {read=FPosition, write=FPosition, default=0};
	__property TPDFDocument* Document = {read=GetDocument};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TPDFExportFormat() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  SaveToStream(System::Classes::TStream* Stream, Fmx::Forms::TForm* const AOptions){ Fmxtee::Editor::Export::TTeeExportFormat::SaveToStream(Stream, AOptions); }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall WriteStringToStream(System::Classes::TStream* const Stream, const System::UnicodeString S);
extern DELPHI_PACKAGE void __fastcall TeeSaveToPDFFile(Fmxtee::Procs::TCustomTeePanel* const APanel, const System::UnicodeString FileName, int AWidth = 0x0, int AHeight = 0x0);
}	/* namespace Pdf */
}	/* namespace Canvas */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_CANVAS_PDF)
using namespace Fmxtee::Canvas::Pdf;
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
#endif	// Fmxtee_Canvas_PdfHPP
