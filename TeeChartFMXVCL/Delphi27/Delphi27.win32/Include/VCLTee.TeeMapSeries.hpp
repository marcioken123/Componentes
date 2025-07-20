// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeMapSeries.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeemapseriesHPP
#define Vcltee_TeemapseriesHPP

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
#include <System.Generics.Collections.hpp>
#include <System.Math.Vectors.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeSurfa.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teemapseries
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPolygonSeries;
class DELPHICLASS TTeePolygon;
class DELPHICLASS TTeePolygonGroup;
class DELPHICLASS TTeePolygonGroups;
class DELPHICLASS TTeePolygonList;
class DELPHICLASS TMapPersistent;
class DELPHICLASS TMapMarks;
class DELPHICLASS TMapLegendSort;
class DELPHICLASS TMapLegend;
class DELPHICLASS TMapRenderOptions;
class DELPHICLASS TMapSeries;
class DELPHICLASS TTeeKMLSource;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPolygonSeries : public Vcltee::Teengine::TChartSeries
{
	typedef Vcltee::Teengine::TChartSeries inherited;
	
protected:
	virtual void __fastcall CanvasChanged(System::TObject* Sender);
	virtual void __fastcall DrawLegendShape(int ValueIndex, const System::Types::TRect &Rect);
	virtual void __fastcall NotifyValue(Vcltee::Teengine::TValueEvent ValueEvent, int ValueIndex);
	virtual void __fastcall PrepareLegendCanvas(int ValueIndex, System::Uitypes::TColor &BackColor, Vcl::Graphics::TBrushStyle &BrushStyle);
	virtual void __fastcall SetActive(bool Value);
	virtual void __fastcall SetSeriesColor(System::Uitypes::TColor AColor);
	
public:
	DYNAMIC void __fastcall FillSampleValues(int NumValues);
	TTeePolygon* __fastcall Polygon();
public:
	/* TChartSeries.Create */ inline __fastcall virtual TPolygonSeries(System::Classes::TComponent* AOwner) : Vcltee::Teengine::TChartSeries(AOwner) { }
	/* TChartSeries.Destroy */ inline __fastcall virtual ~TPolygonSeries() { }
	
};


enum DECLSPEC_DENUM TPolygonConcave : unsigned char { pcUnknown, pcYes, pcNo };

typedef System::DynamicArray<TTeePolygon*> TTeePolygons;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeePolygon : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
	
private:
	typedef System::DynamicArray<Vcltee::Tecanvas::TPoint3D> _TTeePolygon__1;
	
	
private:
	bool FClosed;
	System::UnicodeString FCode;
	Vcltee::Tecanvas::TTeeGradient* FGradient;
	Vcltee::Tecanvas::TFloatXY* FOffset;
	bool FParentBrush;
	bool FParentPen;
	TPolygonSeries* FPoints;
	float FSize;
	Vcltee::Tecanvas::TTeeTransparency FTransparency;
	System::Types::TRect IBounds;
	bool IBoundsDone;
	bool ICentroidDone;
	_POINTFLOAT ICentroid;
	bool IVisibleDone;
	bool IVisible;
	TPolygonConcave IConcave;
	Vcltee::Tecanvas::TPointFloatArray ITriangles;
	Vcltee::Tecanvas::TTeeCachedObject* ITriangleCached;
	bool IPointsDone;
	void __fastcall CalcOffset(float &X, float &Y);
	void __fastcall ClearCachedPoints();
	void __fastcall DataChanged();
	void __fastcall DoResize(const _POINTFLOAT &ACenter, const float X, const float Y);
	void __fastcall FreeCached();
	Vcltee::Tecanvas::TTeeBrush* __fastcall GetBrush();
	System::Uitypes::TColor __fastcall GetColor();
	Vcltee::Tecanvas::TTeeGradient* __fastcall GetGradient();
	Vcltee::Tecanvas::TTeePen* __fastcall GetPen();
	Vcltee::Teeprocs::TBackImage* __fastcall GetPicture();
	System::UnicodeString __fastcall GetText();
	bool __fastcall GetTransparent();
	double __fastcall GetZ();
	bool __fastcall IsConcave();
	void __fastcall OffsetChanged(System::TObject* Source);
	System::Types::TRect __fastcall PointRect();
	Vcltee::Tecanvas::TPointFloatArray __fastcall PointValues();
	void __fastcall SetBrush(Vcltee::Tecanvas::TTeeBrush* const Value);
	void __fastcall SetClosed(const bool Value);
	void __fastcall SetCode(const System::UnicodeString Value);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	void __fastcall SetGradient(Vcltee::Tecanvas::TTeeGradient* const Value);
	void __fastcall SetOffset(Vcltee::Tecanvas::TFloatXY* const Value);
	void __fastcall SetParentBrush(const bool Value);
	void __fastcall SetParentPen(const bool Value);
	void __fastcall SetPen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetPicture(Vcltee::Teeprocs::TBackImage* const Value);
	void __fastcall SetSize(const float Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetTransparency(const Vcltee::Tecanvas::TTeeTransparency Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetZ(const double Value);
	System::Types::TRectF __fastcall ValueBounds();
	
protected:
	Vcltee::Tecanvas::TPointArray IPoints;
	_TTeePolygon__1 ITrianglePoints3D;
	_TTeePolygon__1 IPoints3D;
	Vcltee::Tecanvas::TTeeTransform* Transform;
	int ZNear;
	int ZFar;
	bool __fastcall Clicked(const int AIndex, const int X, const int Y);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall DoDraw(Vcltee::Tecanvas::TCanvas3D* const ACanvas, int Index, System::Uitypes::TColor AColor, Vcltee::Tecanvas::TTeeTransparency ATransp);
	void __fastcall DoOffset(const float X, const float Y);
	virtual System::UnicodeString __fastcall GetDisplayName();
	
public:
	TMapSeries* ParentSeries;
	TTeePolygon* ParentShape;
	__fastcall virtual TTeePolygon(System::Classes::TCollection* Collection);
	__fastcall virtual ~TTeePolygon();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	int __fastcall AddXY(const Vcltee::Tecanvas::TFloatPoint &Point)/* overload */;
	int __fastcall AddXY(const double X, const double Y)/* overload */;
	void __fastcall Draw(Vcltee::Tecanvas::TCanvas3D* const ACanvas, int ValueIndex, const bool CheckHover = false);
	Vcltee::Tecanvas::TPointArray __fastcall GetPoints();
	void __fastcall OffsetValues(const float X, const float Y);
	void __fastcall Resize(const float X, const float Y);
	TTeePolygons __fastcall Siblings();
	bool __fastcall Visible();
	System::Types::TRect __fastcall Bounds();
	_POINTFLOAT __fastcall Centroid();
	__property TPolygonSeries* Points = {read=FPoints};
	
__published:
	__property Vcltee::Tecanvas::TTeeBrush* Brush = {read=GetBrush, write=SetBrush};
	__property bool Closed = {read=FClosed, write=SetClosed, default=1};
	__property System::UnicodeString Code = {read=FCode, write=SetCode};
	__property System::Uitypes::TColor Color = {read=GetColor, write=SetColor, default=16777215};
	__property Vcltee::Tecanvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
	__property Vcltee::Tecanvas::TFloatXY* Offset = {read=FOffset, write=SetOffset};
	__property bool ParentBrush = {read=FParentBrush, write=SetParentBrush, default=1};
	__property bool ParentPen = {read=FParentPen, write=SetParentPen, default=1};
	__property Vcltee::Tecanvas::TTeePen* Pen = {read=GetPen, write=SetPen};
	__property Vcltee::Teeprocs::TBackImage* Picture = {read=GetPicture, write=SetPicture};
	__property float Size = {read=FSize, write=SetSize};
	__property System::UnicodeString Text = {read=GetText, write=SetText};
	__property Vcltee::Tecanvas::TTeeTransparency Transparency = {read=FTransparency, write=SetTransparency, default=0};
	__property bool Transparent = {read=GetTransparent, write=SetTransparent, default=0};
	__property double Z = {read=GetZ, write=SetZ};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeePolygonGroup : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::UnicodeString FCode;
	System::UnicodeString FText;
	System::Uitypes::TColor __fastcall GetColor();
	bool __fastcall GetVisible();
	bool __fastcall HasShape(TTeePolygon* const AShape);
	void __fastcall SetCode(const System::UnicodeString Value);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetVisible(const bool Value);
	
protected:
	TMapSeries* Map;
	
public:
	TTeePolygons Shapes;
	__fastcall virtual TTeePolygonGroup(TMapSeries* const AMap);
	__fastcall virtual ~TTeePolygonGroup();
	void __fastcall Add(TMapSeries* const AMap)/* overload */;
	void __fastcall Add(TTeePolygon* const AShape)/* overload */;
	void __fastcall Add(const int *AShapes, const int AShapes_High)/* overload */;
	void __fastcall Add(int AFrom, int ATo)/* overload */;
	void __fastcall Add(TTeePolygonList* const AShapes, int AFrom, int ATo)/* overload */;
	int __fastcall Count();
	void __fastcall Hide();
	void __fastcall Offset(const float X, const float Y);
	void __fastcall Resize(const float X, const float Y);
	void __fastcall Show();
	__property System::UnicodeString Code = {read=FCode, write=SetCode};
	__property System::Uitypes::TColor Color = {read=GetColor, write=SetColor, nodefault};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property bool Visible = {read=GetVisible, write=SetVisible, nodefault};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TTeePolygonGroups : public System::Generics::Collections::TObjectList__1<TTeePolygonGroup*>
{
	typedef System::Generics::Collections::TObjectList__1<TTeePolygonGroup*> inherited;
	
public:
	TTeePolygonGroup* operator[](int Index) { return this->Group[Index]; }
	
private:
	TMapSeries* IMap;
	TTeePolygonGroup* __fastcall Get(int Index);
	TTeePolygonGroup* __fastcall GetByCode(const System::UnicodeString ACode);
	TTeePolygonGroup* __fastcall GetByName(const System::UnicodeString AName);
	int __fastcall IndexWithShape(TTeePolygon* const AShape);
	void __fastcall Put(int Index, TTeePolygonGroup* const Value);
	
protected:
	int __fastcall IndexOfCode(const System::UnicodeString ACode);
	
public:
	HIDESBASE TTeePolygonGroup* __fastcall Add(const System::UnicodeString AName)/* overload */;
	HIDESBASE TTeePolygonGroup* __fastcall Add(const System::UnicodeString AName, const System::UnicodeString ACode, const TTeePolygons AShapes)/* overload */;
	__property TTeePolygonGroup* ByCode[const System::UnicodeString ACode] = {read=GetByCode};
	__property TTeePolygonGroup* ByName[const System::UnicodeString AName] = {read=GetByName};
	__property TTeePolygonGroup* Group[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* {System_Generics_Collections}TObjectList<VCLTee_TeeMapSeries_TTeePolygonGroup>.Create */ inline __fastcall TTeePolygonGroups()/* overload */ : System::Generics::Collections::TObjectList__1<TTeePolygonGroup*>() { }
	/* {System_Generics_Collections}TObjectList<VCLTee_TeeMapSeries_TTeePolygonGroup>.Create */ inline __fastcall TTeePolygonGroups(bool AOwnsObjects)/* overload */ : System::Generics::Collections::TObjectList__1<TTeePolygonGroup*>(AOwnsObjects) { }
	/* {System_Generics_Collections}TObjectList<VCLTee_TeeMapSeries_TTeePolygonGroup>.Create */ inline __fastcall TTeePolygonGroups(const System::DelphiInterface<System::Generics::Defaults::IComparer__1<TTeePolygonGroup*> > AComparer, bool AOwnsObjects)/* overload */ : System::Generics::Collections::TObjectList__1<TTeePolygonGroup*>(AComparer, AOwnsObjects) { }
	/* {System_Generics_Collections}TObjectList<VCLTee_TeeMapSeries_TTeePolygonGroup>.Create */ inline __fastcall TTeePolygonGroups(System::Generics::Collections::TEnumerable__1<TTeePolygonGroup*>* const Collection, bool AOwnsObjects)/* overload */ : System::Generics::Collections::TObjectList__1<TTeePolygonGroup*>(Collection, AOwnsObjects) { }
	/* {System_Generics_Collections}TObjectList<VCLTee_TeeMapSeries_TTeePolygonGroup>.Destroy */ inline __fastcall virtual ~TTeePolygonGroups() { }
	
public:
	/* {System_Generics_Collections}TList<VCLTee_TeeMapSeries_TTeePolygonGroup>.Create */ inline __fastcall TTeePolygonGroups(const System::DelphiInterface<System::Generics::Defaults::IComparer__1<TTeePolygonGroup*> > AComparer)/* overload */ : System::Generics::Collections::TObjectList__1<TTeePolygonGroup*>(AComparer) { }
	/* {System_Generics_Collections}TList<VCLTee_TeeMapSeries_TTeePolygonGroup>.Create */ inline __fastcall TTeePolygonGroups(System::Generics::Collections::TEnumerable__1<TTeePolygonGroup*>* const Collection)/* overload */ : System::Generics::Collections::TObjectList__1<TTeePolygonGroup*>(Collection) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeePolygonList : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TTeePolygon* operator[](int Index) { return this->Polygon[Index]; }
	
private:
	HIDESBASE void __fastcall Delete(int Start, int Quantity)/* overload */;
	TTeePolygon* __fastcall Get(int Index);
	TTeePolygon* __fastcall GetByCode(const System::UnicodeString ACode);
	TTeePolygon* __fastcall GetByName(const System::UnicodeString AName);
	void __fastcall Put(int Index, TTeePolygon* const Value);
	
protected:
	int __fastcall IndexOfCode(const System::UnicodeString ACode);
	
public:
	HIDESBASE TTeePolygon* __fastcall Add();
	__property TTeePolygon* ByCode[const System::UnicodeString ACode] = {read=GetByCode};
	__property TTeePolygon* ByName[const System::UnicodeString AName] = {read=GetByName};
	void __fastcall Exchange(int A, int B);
	HIDESBASE TMapSeries* __fastcall Owner();
	__property TTeePolygon* Polygon[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TTeePolygonList(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TTeePolygonList() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TMapPersistent : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
protected:
	TMapSeries* IMap;
	
public:
	__fastcall virtual TMapPersistent(TMapSeries* const AMap);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TMapPersistent() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TMapMarksText : unsigned char { mtLabel, mtCode, mtBoth };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TMapMarks : public TMapPersistent
{
	typedef TMapPersistent inherited;
	
private:
	bool FAutoSize;
	bool FAutoTextColor;
	bool FCentroid;
	TMapMarksText FStyle;
	bool FUpperCase;
	void __fastcall SetAutoSize(const bool Value);
	void __fastcall SetAutoTextColor(const bool Value);
	void __fastcall SetCentroid(const bool Value);
	void __fastcall SetStyle(const TMapMarksText Value);
	void __fastcall SetUppercase(const bool Value);
	
public:
	__fastcall virtual TMapMarks(TMapSeries* const AMap);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=1};
	__property bool AutoTextColor = {read=FAutoTextColor, write=SetAutoTextColor, default=1};
	__property bool Centroid = {read=FCentroid, write=SetCentroid, default=1};
	__property TMapMarksText TextStyle = {read=FStyle, write=SetStyle, default=0};
	__property bool Uppercase = {read=FUpperCase, write=SetUppercase, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TMapMarks() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TMapLegendSortBy : unsigned char { mlsText, mlsValue, mlsNone };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TMapLegendSort : public TMapPersistent
{
	typedef TMapPersistent inherited;
	
private:
	TMapLegendSortBy FBy;
	bool FInverted;
	void __fastcall SetBy(const TMapLegendSortBy Value);
	void __fastcall SetInverted(const bool Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property TMapLegendSortBy By = {read=FBy, write=SetBy, default=0};
	__property bool Inverted = {read=FInverted, write=SetInverted, default=0};
public:
	/* TMapPersistent.Create */ inline __fastcall virtual TMapLegendSort(TMapSeries* const AMap) : TMapPersistent(AMap) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TMapLegendSort() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TMapLegendStyle : unsigned char { lsPalette, lsTexts, lsGroups };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TMapLegend : public TMapPersistent
{
	typedef TMapPersistent inherited;
	
private:
	bool FIncludeUnNamed;
	bool FIncludeZero;
	TMapLegendSort* FSort;
	TMapLegendStyle FStyle;
	void __fastcall SetIncludeUnNamed(const bool Value);
	void __fastcall SetIncludeZero(const bool Value);
	void __fastcall SetStyle(const TMapLegendStyle Value);
	void __fastcall SetSort(TMapLegendSort* const Value);
	
public:
	bool VisibleOnly;
	__fastcall virtual TMapLegend(TMapSeries* const AMap);
	__fastcall virtual ~TMapLegend();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool IncludeUnNamed = {read=FIncludeUnNamed, write=SetIncludeUnNamed, default=0};
	__property bool IncludeZero = {read=FIncludeZero, write=SetIncludeZero, default=0};
	__property TMapLegendSort* Sort = {read=FSort, write=SetSort};
	__property TMapLegendStyle Style = {read=FStyle, write=SetStyle, default=0};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TMapRenderOptions : public TMapPersistent
{
	typedef TMapPersistent inherited;
	
private:
	Vcltee::Tecanvas::TTeeBrush* FBrush;
	Vcltee::Tecanvas::TTeePen* FMeridians;
	Vcltee::Tecanvas::TTeePen* FParallels;
	Vcltee::Tecanvas::TPointXYFloat* FRotation;
	int XCenterDeg;
	float YCenterRad;
	float CosYCenter;
	float SinYCenter;
	Vcltee::Teengine::TAxisCalcPos IHorizCalc;
	Vcltee::Teengine::TAxisCalcPos IVertCalc;
	float IOffsetX;
	float IOffsetY;
	_POINTFLOAT __fastcall CalcPoint(const float X, const float Y)/* overload */;
	System::Types::TPoint __fastcall CalcPoint(const double X, const double Y, /* out */ float &Z)/* overload */;
	Vcltee::Tecanvas::TPoint3D __fastcall CalcPoint2D(const _POINTFLOAT &P)/* overload */;
	System::Types::TPoint __fastcall CalcPoint2D(const double X, const double Y)/* overload */;
	void __fastcall DrawSphere(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
	void __fastcall Prepare();
	void __fastcall SetBrush(Vcltee::Tecanvas::TTeeBrush* const Value);
	void __fastcall SetMeridians(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetParallels(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetRotation(Vcltee::Tecanvas::TPointXYFloat* const Value);
	
protected:
	void __fastcall CalcSpherical(float &X, float &Y)/* overload */;
	void __fastcall CalcSpherical(float &X, float &Y, /* out */ float &Z)/* overload */;
	
public:
	__fastcall virtual TMapRenderOptions(TMapSeries* const AMap);
	__fastcall virtual ~TMapRenderOptions();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcltee::Tecanvas::TTeeBrush* Brush = {read=FBrush, write=SetBrush};
	__property Vcltee::Tecanvas::TTeePen* Meridians = {read=FMeridians, write=SetMeridians};
	__property Vcltee::Tecanvas::TTeePen* Parallels = {read=FParallels, write=SetParallels};
	__property Vcltee::Tecanvas::TPointXYFloat* Rotation = {read=FRotation, write=SetRotation};
};


enum DECLSPEC_DENUM TMapRenderMode : unsigned char { rmDefault, rm2D, rm3D };

class PASCALIMPLEMENTATION TMapSeries : public Vcltee::Teesurfa::TCustom3DPaletteSeries
{
	typedef Vcltee::Teesurfa::TCustom3DPaletteSeries inherited;
	
	
private:
	typedef System::DynamicArray<int> _TMapSeries__1;
	
	typedef System::DynamicArray<int> _TMapSeries__2;
	
	
public:
	TTeePolygon* operator[](int Index) { return this->Polygon[Index]; }
	
private:
	Vcltee::Tecanvas::TTeeEmboss* FEmboss;
	TTeePolygonGroups* FGroups;
	TMapLegend* FMapLegend;
	TMapMarks* FMapMarks;
	Vcltee::Tecanvas::TFloatXY* FOffset;
	Vcltee::Teengine::TSeriesPointer* FPointer;
	TMapRenderMode FRender;
	TMapRenderOptions* FRenderOptions;
	Vcltee::Tecanvas::TTeeShadow* FShadow;
	TTeePolygonList* FShapes;
	bool FTransparent;
	_TMapSeries__1 I3DList;
	_TMapSeries__2 ILegendItems;
	bool IValueBoundsDone;
	System::Types::TRectF IValueBounds;
	System::Uitypes::TColor __fastcall AutoColor(const System::Uitypes::TColor AColor);
	float __fastcall CalcPointSize();
	void __fastcall CalcValueBounds();
	int __fastcall CalcVisibleLegendItems();
	void __fastcall ClearCachedPoints();
	int __fastcall CompareLegendItem(int a, int b);
	int __fastcall CompareOrder(int a, int b);
	int __fastcall CompareOrderRender(int a, int b);
	bool __fastcall DisplayAtLegend(TTeePolygon* const AShape);
	void __fastcall DoDelete(int ValueIndex);
	void __fastcall EnsureShapeCount();
	void __fastcall FreeCached();
	Vcltee::Teengine::TSeriesPointer* __fastcall GetPointer();
	float __fastcall GetPointSize();
	TTeePolygon* __fastcall GetPolygon(int Index);
	void __fastcall InvalidateLegend();
	void __fastcall OffsetChanged(System::TObject* Sender);
	void __fastcall SetEmboss(Vcltee::Tecanvas::TTeeEmboss* const Value);
	void __fastcall SetMapLegend(TMapLegend* const Value);
	void __fastcall SetMapMarks(TMapMarks* const Value);
	void __fastcall SetOffset(Vcltee::Tecanvas::TFloatXY* const Value);
	void __fastcall SetPointer(Vcltee::Teengine::TSeriesPointer* const Value);
	void __fastcall SetPointSize(const float Value);
	void __fastcall SetRender(const TMapRenderMode Value);
	void __fastcall SetRenderOptions(TMapRenderOptions* const Value);
	void __fastcall SetShadow(Vcltee::Tecanvas::TTeeShadow* const Value);
	void __fastcall SetShapes(TTeePolygonList* const Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SortLegendItems();
	void __fastcall SwapLegendItem(int a, int b);
	void __fastcall SwapPolygon(int a, int b);
	
protected:
	bool IAdding;
	bool ILoading;
	bool Reuse3D;
	bool CanSaveData;
	int MinSize;
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual void __fastcall CalcHorizMargins(int &LeftMargin, int &RightMargin);
	virtual int __fastcall CalcLegendIndex(int LegendIndex);
	virtual void __fastcall CalcSelectionPos(int ValueIndex, /* out */ int &X, /* out */ int &Y);
	virtual void __fastcall CalcVerticalMargins(int &TopMargin, int &BottomMargin);
	virtual bool __fastcall CanDrawMark(int ValueIndex);
	virtual void __fastcall ChangedAxisScale(Vcltee::Teengine::TChartAxis* const Axis);
	__classmethod virtual void __fastcall CreateSubGallery(Vcltee::Teengine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DoBeforeDrawChart();
	virtual void __fastcall DoBeforeDrawValues();
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Vcltee::Teengine::TSeriesMarkPosition* APosition);
	virtual void __fastcall DrawValue(int ValueIndex);
	DYNAMIC void __fastcall GalleryChanged3D(bool Is3D);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual System::UnicodeString __fastcall GetMarkLabel(int ValueIndex);
	virtual void __fastcall GetPaletteBounds(/* out */ double &AMin, /* out */ double &ARange);
	bool __fastcall IsVisible();
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	__classmethod virtual void __fastcall SetSubGallery(Vcltee::Teengine::TChartSeries* ASeries, int Index);
	virtual int __fastcall ValueIndexToLegend(int ValueIndex);
	
public:
	__fastcall virtual TMapSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TMapSeries();
	virtual int __fastcall AddXY(const double AXValue, const double AYValue, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000));
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Clear();
	void __fastcall ClearLegend();
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	virtual int __fastcall CountLegendItems();
	virtual void __fastcall Delete(int ValueIndex)/* overload */;
	virtual void __fastcall Delete(int Start, int Quantity, bool RemoveGap = false)/* overload */;
	Vcltee::Teengine::TChartAxis* __fastcall GetZAxis();
	virtual System::Uitypes::TColor __fastcall LegendItemColor(int LegendIndex);
	virtual System::UnicodeString __fastcall LegendString(int LegendIndex, Vcltee::Teengine::TLegendTextStyle LegendTextStyle);
	virtual int __fastcall LegendToValueIndex(int LegendIndex);
	virtual double __fastcall MaxXValue();
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinXValue();
	virtual double __fastcall MinYValue();
	DYNAMIC int __fastcall NumSampleValues();
	DYNAMIC void __fastcall SwapValueIndex(int A, int B);
	__property TTeePolygonGroups* Groups = {read=FGroups};
	__property TTeePolygon* Polygon[int Index] = {read=GetPolygon/*, default*/};
	
__published:
	__property Active = {default=1};
	__property ColorSource = {default=0};
	__property Cursor = {default=0};
	__property HorizAxis = {default=1};
	__property Marks;
	__property ParentChart;
	__property DataSource;
	__property PercentFormat = {default=0};
	__property SeriesColor;
	__property ShowInLegend = {default=1};
	__property Title = {default=0};
	__property ValueFormat = {default=0};
	__property VertAxis = {default=0};
	__property XLabelsSource = {default=0};
	__property Brush;
	__property Vcltee::Tecanvas::TTeeEmboss* Emboss = {read=FEmboss, write=SetEmboss};
	__property EndColor = {default=16777215};
	__property TMapLegend* MapLegend = {read=FMapLegend, write=SetMapLegend};
	__property TMapMarks* MapMarks = {read=FMapMarks, write=SetMapMarks};
	__property MidColor = {default=536870911};
	__property LegendEvery = {default=1};
	__property Vcltee::Tecanvas::TFloatXY* Offset = {read=FOffset, write=SetOffset};
	__property Pen;
	__property PaletteMin = {default=0};
	__property PaletteStep = {default=0};
	__property PaletteSteps = {default=32};
	__property PaletteStyle = {default=0};
	__property Vcltee::Teengine::TSeriesPointer* Pointer = {read=GetPointer, write=SetPointer};
	__property float PointSize = {read=GetPointSize, write=SetPointSize};
	__property TMapRenderMode RenderMode = {read=FRender, write=SetRender, default=0};
	__property TMapRenderOptions* RenderOptions = {read=FRenderOptions, write=SetRenderOptions};
	__property Vcltee::Tecanvas::TTeeShadow* Shadow = {read=FShadow, write=SetShadow};
	__property TTeePolygonList* Shapes = {read=FShapes, write=SetShapes};
	__property StartColor = {default=8388608};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property Transparency = {default=0};
	__property UseColorRange = {default=1};
	__property UsePalette = {default=0};
	__property UsePaletteMin = {default=0};
	__property TimesZOrder = {default=3};
	__property XValues;
	__property YValues;
	__property ZValues;
	__property AfterDrawValues;
	__property BeforeDrawValues;
	__property OnAfterAdd;
	__property OnBeforeAdd;
	__property OnClearValues;
	__property OnClick;
	__property OnDblClick;
	__property OnGetColor;
	__property OnGetMarkText;
	__property OnMouseEnter;
	__property OnMouseLeave;
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeeKMLSource : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__classmethod void __fastcall Load(Vcltee::Teengine::TChartSeries* const ASeries, const System::UnicodeString FileName);
public:
	/* TObject.Create */ inline __fastcall TTeeKMLSource() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TTeeKMLSource() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teemapseries */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEMAPSERIES)
using namespace Vcltee::Teemapseries;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeemapseriesHPP
