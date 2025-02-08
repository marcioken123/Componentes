// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFigures.pas' rev: 31.00 (Windows)

#ifndef LmdfiguresHPP
#define LmdfiguresHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDGraph.hpp>
#include <LMDFillers.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfigures
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFigure;
class DELPHICLASS TLMDRectangle;
class DELPHICLASS TLMDCutBaseRectangle;
class DELPHICLASS TLMDCustomCutRectangle;
class DELPHICLASS TLMDCutRectangle;
class DELPHICLASS TLMDCutXYRectangle;
class DELPHICLASS TLMDRoundRectangle;
class DELPHICLASS TLMDLine;
class DELPHICLASS TLMDCircle;
class DELPHICLASS TLMDEllipse;
class DELPHICLASS TLMDContainerFigure;
class DELPHICLASS TLMDUnionFigure;
class DELPHICLASS TLMDIntersectFigure;
class DELPHICLASS TLMDSubtractionFigure;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFigure : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FAntiAliasing;
	bool FAutoBoundFill;
	System::Types::TPoint FBasePoint;
	System::Uitypes::TColor FBorderColor;
	Lmdgraph::TLMDBorderSides FBorderSides;
	int FBorderWidth;
	Lmdfillers::TLMDFiller* FFiller;
	int FLengthN;
	int FLengthN2;
	int FLengthT;
	int FLengthT2;
	bool FMoveFillerWithFigure;
	bool FSoftBorder;
	bool FTransparent;
	System::Types::TPoint FVectorN;
	System::Types::TPoint FVectorT;
	virtual System::Types::TPoint __fastcall GetBasePoint(void);
	virtual System::Uitypes::TColor __fastcall GetBorderColor(void);
	virtual int __fastcall GetBorderWidth(void);
	virtual System::Types::TPoint __fastcall GetVectorN(void);
	virtual System::Types::TPoint __fastcall GetVectorT(void);
	virtual double __fastcall IsInside(const System::Types::TPoint &APoint, int &ABorderWidth);
	virtual void __fastcall PreCalc(void);
	virtual void __fastcall SetBasePoint(const System::Types::TPoint &Value);
	virtual void __fastcall SetBorderColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetBorderWidth(int Value);
	void __fastcall SetFiller(Lmdfillers::TLMDFiller* Value);
	virtual void __fastcall SetVectorN(const System::Types::TPoint &Value);
	virtual void __fastcall SetVectorT(const System::Types::TPoint &Value);
	
public:
	__fastcall TLMDFigure(Lmdfillers::TLMDFiller* AFiller)/* overload */;
	virtual void __fastcall Draw24(Vcl::Graphics::TBitmap* ABitMap);
	virtual void __fastcall Draw32(Vcl::Graphics::TBitmap* ABitMap, bool aPremult);
	virtual void __fastcall Draw(Vcl::Graphics::TBitmap* ABitMap, Vcl::Graphics::TPixelFormat aPixelFormat, bool aUsePremult = true)/* overload */;
	virtual void __fastcall Draw(HDC aTargetDC, Vcl::Graphics::TPixelFormat aPixelFormat, bool aUsePremult = true, bool aCopyBkgnd = true)/* overload */;
	virtual System::Types::TRect __fastcall IncludeRect(void);
	__property bool AntiAliasing = {read=FAntiAliasing, write=FAntiAliasing, nodefault};
	__property bool AutoBoundFill = {read=FAutoBoundFill, write=FAutoBoundFill, default=1};
	__property System::Types::TPoint BasePoint = {read=GetBasePoint, write=SetBasePoint};
	__property System::Uitypes::TColor BorderColor = {read=GetBorderColor, write=SetBorderColor, nodefault};
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, write=FBorderSides, nodefault};
	__property int BorderWidth = {read=GetBorderWidth, write=SetBorderWidth, nodefault};
	__property Lmdfillers::TLMDFiller* Filler = {read=FFiller, write=SetFiller};
	__property bool MoveFillerWithFigure = {read=FMoveFillerWithFigure, write=FMoveFillerWithFigure, default=0};
	__property bool SoftBorder = {read=FSoftBorder, write=FSoftBorder, nodefault};
	__property bool Transparent = {read=FTransparent, write=FTransparent, nodefault};
	__property System::Types::TPoint VectorN = {read=GetVectorN, write=SetVectorN};
	__property System::Types::TPoint VectorT = {read=GetVectorT, write=SetVectorT};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDFigure(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRectangle : public TLMDFigure
{
	typedef TLMDFigure inherited;
	
private:
	virtual double __fastcall IsInside(const System::Types::TPoint &APoint, int &ABorderWidth);
	
public:
	__fastcall TLMDRectangle(int x1, int y1, int x2, int y2, Lmdfillers::TLMDFiller* AFiller)/* overload */;
	__fastcall TLMDRectangle(const System::Types::TPoint &ATopLeft, const System::Types::TPoint &ABottomRight, Lmdfillers::TLMDFiller* AFiller)/* overload */;
	__fastcall TLMDRectangle(const System::Types::TRect &ARect, Lmdfillers::TLMDFiller* AFiller)/* overload */;
	virtual System::Types::TRect __fastcall IncludeRect(void);
	void __fastcall Rectangle(int x1, int y1, int x2, int y2)/* overload */;
	void __fastcall Rectangle(const System::Types::TPoint &ATopLeft, const System::Types::TPoint &ABottomRight)/* overload */;
	void __fastcall Rectangle(const System::Types::TRect &ARect)/* overload */;
public:
	/* TLMDFigure.Create */ inline __fastcall TLMDRectangle(Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDFigure(AFiller) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRectangle(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCutBaseRectangle : public TLMDRectangle
{
	typedef TLMDRectangle inherited;
	
private:
	Lmdgraph::TLMDCornerCut FCornerCut;
	int FXCut;
	int FYCut;
	virtual double __fastcall IsInside(const System::Types::TPoint &APoint, int &ABorderWidth);
	
public:
	double __fastcall CornerInclude(int AX, int AY, Lmdgraph::TLMDCutType ACutType = (Lmdgraph::TLMDCutType)(0x0));
public:
	/* TLMDRectangle.Create */ inline __fastcall TLMDCutBaseRectangle(int x1, int y1, int x2, int y2, Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDRectangle(x1, y1, x2, y2, AFiller) { }
	/* TLMDRectangle.Create */ inline __fastcall TLMDCutBaseRectangle(const System::Types::TPoint &ATopLeft, const System::Types::TPoint &ABottomRight, Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDRectangle(ATopLeft, ABottomRight, AFiller) { }
	/* TLMDRectangle.Create */ inline __fastcall TLMDCutBaseRectangle(const System::Types::TRect &ARect, Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDRectangle(ARect, AFiller) { }
	
public:
	/* TLMDFigure.Create */ inline __fastcall TLMDCutBaseRectangle(Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDRectangle(AFiller) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDCutBaseRectangle(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCustomCutRectangle : public TLMDCutBaseRectangle
{
	typedef TLMDCutBaseRectangle inherited;
	
private:
	Lmdgraph::TLMDCutType __fastcall GetCornerCut(Lmdgraph::TLMDRectangleCorner Index);
	int __fastcall GetCutX(void);
	int __fastcall GetCutY(void);
	void __fastcall SetCornerCut(Lmdgraph::TLMDRectangleCorner Index, Lmdgraph::TLMDCutType Value);
	void __fastcall SetCutX(int Value);
	void __fastcall SetCutY(int Value);
	
public:
	__property Lmdgraph::TLMDCutType CornerCut[Lmdgraph::TLMDRectangleCorner Index] = {read=GetCornerCut, write=SetCornerCut};
	__property int CutX = {read=GetCutX, write=SetCutX, nodefault};
	__property int CutY = {read=GetCutY, write=SetCutY, nodefault};
public:
	/* TLMDRectangle.Create */ inline __fastcall TLMDCustomCutRectangle(int x1, int y1, int x2, int y2, Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDCutBaseRectangle(x1, y1, x2, y2, AFiller) { }
	/* TLMDRectangle.Create */ inline __fastcall TLMDCustomCutRectangle(const System::Types::TPoint &ATopLeft, const System::Types::TPoint &ABottomRight, Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDCutBaseRectangle(ATopLeft, ABottomRight, AFiller) { }
	/* TLMDRectangle.Create */ inline __fastcall TLMDCustomCutRectangle(const System::Types::TRect &ARect, Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDCutBaseRectangle(ARect, AFiller) { }
	
public:
	/* TLMDFigure.Create */ inline __fastcall TLMDCustomCutRectangle(Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDCutBaseRectangle(AFiller) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDCustomCutRectangle(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCutRectangle : public TLMDCutBaseRectangle
{
	typedef TLMDCutBaseRectangle inherited;
	
private:
	int __fastcall GetCut(void);
	void __fastcall SetCut(int Value);
	
public:
	__property int Cut = {read=GetCut, write=SetCut, nodefault};
public:
	/* TLMDRectangle.Create */ inline __fastcall TLMDCutRectangle(int x1, int y1, int x2, int y2, Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDCutBaseRectangle(x1, y1, x2, y2, AFiller) { }
	/* TLMDRectangle.Create */ inline __fastcall TLMDCutRectangle(const System::Types::TPoint &ATopLeft, const System::Types::TPoint &ABottomRight, Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDCutBaseRectangle(ATopLeft, ABottomRight, AFiller) { }
	/* TLMDRectangle.Create */ inline __fastcall TLMDCutRectangle(const System::Types::TRect &ARect, Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDCutBaseRectangle(ARect, AFiller) { }
	
public:
	/* TLMDFigure.Create */ inline __fastcall TLMDCutRectangle(Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDCutBaseRectangle(AFiller) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDCutRectangle(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCutXYRectangle : public TLMDCutBaseRectangle
{
	typedef TLMDCutBaseRectangle inherited;
	
private:
	int __fastcall GetCutX(void);
	int __fastcall GetCutY(void);
	void __fastcall SetCutX(int Value);
	void __fastcall SetCutY(int Value);
	
public:
	__property int CutX = {read=GetCutX, write=SetCutX, nodefault};
	__property int CutY = {read=GetCutY, write=SetCutY, nodefault};
public:
	/* TLMDRectangle.Create */ inline __fastcall TLMDCutXYRectangle(int x1, int y1, int x2, int y2, Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDCutBaseRectangle(x1, y1, x2, y2, AFiller) { }
	/* TLMDRectangle.Create */ inline __fastcall TLMDCutXYRectangle(const System::Types::TPoint &ATopLeft, const System::Types::TPoint &ABottomRight, Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDCutBaseRectangle(ATopLeft, ABottomRight, AFiller) { }
	/* TLMDRectangle.Create */ inline __fastcall TLMDCutXYRectangle(const System::Types::TRect &ARect, Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDCutBaseRectangle(ARect, AFiller) { }
	
public:
	/* TLMDFigure.Create */ inline __fastcall TLMDCutXYRectangle(Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDCutBaseRectangle(AFiller) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDCutXYRectangle(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRoundRectangle : public TLMDCutBaseRectangle
{
	typedef TLMDCutBaseRectangle inherited;
	
private:
	int __fastcall GetRadius(void);
	void __fastcall SetRadius(int Value);
	
public:
	__property int Radius = {read=GetRadius, write=SetRadius, nodefault};
public:
	/* TLMDRectangle.Create */ inline __fastcall TLMDRoundRectangle(int x1, int y1, int x2, int y2, Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDCutBaseRectangle(x1, y1, x2, y2, AFiller) { }
	/* TLMDRectangle.Create */ inline __fastcall TLMDRoundRectangle(const System::Types::TPoint &ATopLeft, const System::Types::TPoint &ABottomRight, Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDCutBaseRectangle(ATopLeft, ABottomRight, AFiller) { }
	/* TLMDRectangle.Create */ inline __fastcall TLMDRoundRectangle(const System::Types::TRect &ARect, Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDCutBaseRectangle(ARect, AFiller) { }
	
public:
	/* TLMDFigure.Create */ inline __fastcall TLMDRoundRectangle(Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDCutBaseRectangle(AFiller) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRoundRectangle(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLine : public TLMDFigure
{
	typedef TLMDFigure inherited;
	
private:
	System::Types::TPoint FPointFrom;
	System::Types::TPoint FPointTo;
	int FWidth;
	int FWidthLeft;
	int FWidthLeftN;
	int FWidthRight;
	int FWidthRightN;
	virtual double __fastcall IsInside(const System::Types::TPoint &APoint, int &ABorderWidth);
	virtual void __fastcall PreCalc(void);
	void __fastcall SetPointFrom(const System::Types::TPoint &Value);
	void __fastcall SetPointTo(const System::Types::TPoint &Value);
	void __fastcall SetWidth(int Value);
	
public:
	__fastcall TLMDLine(int x1, int y1, int x2, int y2, int AWidth, Lmdfillers::TLMDFiller* AFiller)/* overload */;
	__fastcall TLMDLine(const System::Types::TPoint &APointFrom, const System::Types::TPoint &APointTo, int AWidth, Lmdfillers::TLMDFiller* AFiller)/* overload */;
	virtual System::Types::TRect __fastcall IncludeRect(void);
	void __fastcall Line(int x1, int y1, int x2, int y2, int AWidth)/* overload */;
	void __fastcall Line(const System::Types::TPoint &APointFrom, const System::Types::TPoint &APointTo, int AWidth)/* overload */;
	__property System::Types::TPoint PointFrom = {read=FPointFrom, write=SetPointFrom};
	__property System::Types::TPoint PointTo = {read=FPointTo, write=SetPointTo};
	__property int Width = {read=FWidth, write=SetWidth, nodefault};
public:
	/* TLMDFigure.Create */ inline __fastcall TLMDLine(Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDFigure(AFiller) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDLine(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCircle : public TLMDFigure
{
	typedef TLMDFigure inherited;
	
private:
	int FRadius;
	void __fastcall SetRadius(int Value);
	virtual double __fastcall IsInside(const System::Types::TPoint &APoint, int &ABorderWidth);
	System::Types::TPoint __fastcall GetCenter(void);
	void __fastcall SetCenter(const System::Types::TPoint &Value);
	
public:
	__fastcall TLMDCircle(int x, int y, int ARadius, Lmdfillers::TLMDFiller* AFiller)/* overload */;
	__fastcall TLMDCircle(const System::Types::TPoint &ACenterPoint, int ARadius, Lmdfillers::TLMDFiller* AFiller)/* overload */;
	void __fastcall Circle(int x, int y, int ARadius)/* overload */;
	void __fastcall Circle(const System::Types::TPoint &ACenterPoint, int ARadius)/* overload */;
	virtual System::Types::TRect __fastcall IncludeRect(void);
	__property int Radius = {read=FRadius, write=SetRadius, nodefault};
	__property System::Types::TPoint Center = {read=GetCenter, write=SetCenter};
public:
	/* TLMDFigure.Create */ inline __fastcall TLMDCircle(Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDFigure(AFiller) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDCircle(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEllipse : public TLMDFigure
{
	typedef TLMDFigure inherited;
	
private:
	int FDistance;
	System::Types::TPoint FFocus1;
	System::Types::TPoint FFocus2;
	virtual void __fastcall PreCalc(void);
	virtual double __fastcall IsInside(const System::Types::TPoint &APoint, int &ABorderWidth);
	
public:
	__fastcall TLMDEllipse(int x1, int y1, int x2, int y2, Lmdfillers::TLMDFiller* AFiller)/* overload */;
	__fastcall TLMDEllipse(const System::Types::TRect &ARect, Lmdfillers::TLMDFiller* AFiller)/* overload */;
	void __fastcall Ellipse(int x1, int y1, int x2, int y2)/* overload */;
	void __fastcall Ellipse(const System::Types::TRect &ARect)/* overload */;
	virtual System::Types::TRect __fastcall IncludeRect(void);
public:
	/* TLMDFigure.Create */ inline __fastcall TLMDEllipse(Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDFigure(AFiller) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDEllipse(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDContainerFigure : public TLMDFigure
{
	typedef TLMDFigure inherited;
	
private:
	System::Classes::TList* FFigureList;
	TLMDFigure* __fastcall GetItem(int Index);
	virtual double __fastcall IsInside(const System::Types::TPoint &APoint, int &ABorderWidth);
	virtual void __fastcall SetBorderColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetBorderWidth(int Value);
	void __fastcall SetItem(int Index, TLMDFigure* Value);
	
public:
	__fastcall TLMDContainerFigure(void)/* overload */;
	__fastcall virtual ~TLMDContainerFigure(void);
	int __fastcall Add(TLMDFigure* AFigure);
	int __fastcall Count(void);
	void __fastcall Clear(bool aFreeItems = false);
	void __fastcall Delete(TLMDFigure* AFigure);
	virtual System::Types::TRect __fastcall IncludeRect(void);
	virtual void __fastcall PreCalc(void);
	__property TLMDFigure* Item[int Index] = {read=GetItem, write=SetItem};
public:
	/* TLMDFigure.Create */ inline __fastcall TLMDContainerFigure(Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDFigure(AFiller) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDUnionFigure : public TLMDContainerFigure
{
	typedef TLMDContainerFigure inherited;
	
private:
	virtual double __fastcall IsInside(const System::Types::TPoint &APoint, int &ABorderWidth);
	
public:
	virtual System::Types::TRect __fastcall IncludeRect(void);
public:
	/* TLMDContainerFigure.Create */ inline __fastcall TLMDUnionFigure(void)/* overload */ : TLMDContainerFigure() { }
	/* TLMDContainerFigure.Destroy */ inline __fastcall virtual ~TLMDUnionFigure(void) { }
	
public:
	/* TLMDFigure.Create */ inline __fastcall TLMDUnionFigure(Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDContainerFigure(AFiller) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIntersectFigure : public TLMDContainerFigure
{
	typedef TLMDContainerFigure inherited;
	
private:
	virtual double __fastcall IsInside(const System::Types::TPoint &APoint, int &ABorderWidth);
	
public:
	virtual System::Types::TRect __fastcall IncludeRect(void);
public:
	/* TLMDContainerFigure.Create */ inline __fastcall TLMDIntersectFigure(void)/* overload */ : TLMDContainerFigure() { }
	/* TLMDContainerFigure.Destroy */ inline __fastcall virtual ~TLMDIntersectFigure(void) { }
	
public:
	/* TLMDFigure.Create */ inline __fastcall TLMDIntersectFigure(Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDContainerFigure(AFiller) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSubtractionFigure : public TLMDContainerFigure
{
	typedef TLMDContainerFigure inherited;
	
private:
	virtual double __fastcall IsInside(const System::Types::TPoint &APoint, int &ABorderWidth);
	
public:
	virtual System::Types::TRect __fastcall IncludeRect(void);
public:
	/* TLMDContainerFigure.Create */ inline __fastcall TLMDSubtractionFigure(void)/* overload */ : TLMDContainerFigure() { }
	/* TLMDContainerFigure.Destroy */ inline __fastcall virtual ~TLMDSubtractionFigure(void) { }
	
public:
	/* TLMDFigure.Create */ inline __fastcall TLMDSubtractionFigure(Lmdfillers::TLMDFiller* AFiller)/* overload */ : TLMDContainerFigure(AFiller) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdfigures */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFIGURES)
using namespace Lmdfigures;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfiguresHPP
