// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.World.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Series_WorldHPP
#define Fmxtee_Series_WorldHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <FMX.Types.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Series.Bubble.hpp>
#include <FMXTee.Series.Map.hpp>
#include <FMXTee.Series.Surface.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace World
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeAfricaGroup;
class DELPHICLASS TTeeUSAGroup;
class DELPHICLASS TTeeNorthAmericaGroup;
class DELPHICLASS TTeeSouthAmericaGroup;
class DELPHICLASS TTeeAmericaGroup;
class DELPHICLASS TTeeAsiaGroup;
class DELPHICLASS TTeeItalyGroup;
class DELPHICLASS TTeeEuropeGroup;
class DELPHICLASS TWorldEntities;
class DELPHICLASS TWorldFlags;
class DELPHICLASS TCitySeries;
class DELPHICLASS TWorldCities;
class DELPHICLASS TWorldLayers;
class DELPHICLASS TWorldSeries;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeeAfricaGroup : public Fmxtee::Series::Map::TTeePolygonGroup
{
	typedef Fmxtee::Series::Map::TTeePolygonGroup inherited;
	
public:
	/* TTeePolygonGroup.Create */ inline __fastcall virtual TTeeAfricaGroup(Fmxtee::Series::Map::TMapSeries* const AMap) : Fmxtee::Series::Map::TTeePolygonGroup(AMap) { }
	/* TTeePolygonGroup.Destroy */ inline __fastcall virtual ~TTeeAfricaGroup() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeeUSAGroup : public Fmxtee::Series::Map::TTeePolygonGroup
{
	typedef Fmxtee::Series::Map::TTeePolygonGroup inherited;
	
private:
	Fmxtee::Series::Map::TTeePolygonGroup* IAlaska;
	Fmxtee::Series::Map::TTeePolygonGroup* IHawaii;
	Fmxtee::Series::Map::TTeePolygonGroup* IPuertoRico;
	
public:
	__fastcall virtual ~TTeeUSAGroup();
	Fmxtee::Series::Map::TTeePolygonGroup* __fastcall Alaska();
	Fmxtee::Series::Map::TTeePolygonGroup* __fastcall Hawaii();
	Fmxtee::Series::Map::TTeePolygonGroup* __fastcall PuertoRico();
public:
	/* TTeePolygonGroup.Create */ inline __fastcall virtual TTeeUSAGroup(Fmxtee::Series::Map::TMapSeries* const AMap) : Fmxtee::Series::Map::TTeePolygonGroup(AMap) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeeNorthAmericaGroup : public Fmxtee::Series::Map::TTeePolygonGroup
{
	typedef Fmxtee::Series::Map::TTeePolygonGroup inherited;
	
private:
	Fmxtee::Series::Map::TTeePolygonGroup* ICanada;
	TTeeUSAGroup* IUSA;
	
public:
	__fastcall virtual ~TTeeNorthAmericaGroup();
	Fmxtee::Series::Map::TTeePolygonGroup* __fastcall Canada();
	TTeeUSAGroup* __fastcall USA();
public:
	/* TTeePolygonGroup.Create */ inline __fastcall virtual TTeeNorthAmericaGroup(Fmxtee::Series::Map::TMapSeries* const AMap) : Fmxtee::Series::Map::TTeePolygonGroup(AMap) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeeSouthAmericaGroup : public Fmxtee::Series::Map::TTeePolygonGroup
{
	typedef Fmxtee::Series::Map::TTeePolygonGroup inherited;
	
public:
	/* TTeePolygonGroup.Create */ inline __fastcall virtual TTeeSouthAmericaGroup(Fmxtee::Series::Map::TMapSeries* const AMap) : Fmxtee::Series::Map::TTeePolygonGroup(AMap) { }
	/* TTeePolygonGroup.Destroy */ inline __fastcall virtual ~TTeeSouthAmericaGroup() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeeAmericaGroup : public Fmxtee::Series::Map::TTeePolygonGroup
{
	typedef Fmxtee::Series::Map::TTeePolygonGroup inherited;
	
private:
	Fmxtee::Series::Map::TTeePolygonGroup* ICentral;
	TTeeNorthAmericaGroup* INorth;
	TTeeSouthAmericaGroup* ISouth;
	
public:
	__fastcall virtual ~TTeeAmericaGroup();
	Fmxtee::Series::Map::TTeePolygonGroup* __fastcall Central();
	TTeeNorthAmericaGroup* __fastcall North();
	TTeeSouthAmericaGroup* __fastcall South();
public:
	/* TTeePolygonGroup.Create */ inline __fastcall virtual TTeeAmericaGroup(Fmxtee::Series::Map::TMapSeries* const AMap) : Fmxtee::Series::Map::TTeePolygonGroup(AMap) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeeAsiaGroup : public Fmxtee::Series::Map::TTeePolygonGroup
{
	typedef Fmxtee::Series::Map::TTeePolygonGroup inherited;
	
private:
	Fmxtee::Series::Map::TTeePolygonGroup* IChina;
	Fmxtee::Series::Map::TTeePolygonGroup* IJapan;
	
public:
	__fastcall virtual ~TTeeAsiaGroup();
	Fmxtee::Series::Map::TTeePolygonGroup* __fastcall China();
	Fmxtee::Series::Map::TTeePolygonGroup* __fastcall Japan();
public:
	/* TTeePolygonGroup.Create */ inline __fastcall virtual TTeeAsiaGroup(Fmxtee::Series::Map::TMapSeries* const AMap) : Fmxtee::Series::Map::TTeePolygonGroup(AMap) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeeItalyGroup : public Fmxtee::Series::Map::TTeePolygonGroup
{
	typedef Fmxtee::Series::Map::TTeePolygonGroup inherited;
	
public:
	/* TTeePolygonGroup.Create */ inline __fastcall virtual TTeeItalyGroup(Fmxtee::Series::Map::TMapSeries* const AMap) : Fmxtee::Series::Map::TTeePolygonGroup(AMap) { }
	/* TTeePolygonGroup.Destroy */ inline __fastcall virtual ~TTeeItalyGroup() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeeEuropeGroup : public Fmxtee::Series::Map::TTeePolygonGroup
{
	typedef Fmxtee::Series::Map::TTeePolygonGroup inherited;
	
private:
	Fmxtee::Series::Map::TTeePolygonGroup* IUK;
	Fmxtee::Series::Map::TTeePolygonGroup* IFrance;
	Fmxtee::Series::Map::TTeePolygonGroup* IGermany;
	Fmxtee::Series::Map::TTeePolygonGroup* IRussia;
	Fmxtee::Series::Map::TTeePolygonGroup* ISpain;
	TTeeItalyGroup* IItaly;
	
public:
	__fastcall virtual ~TTeeEuropeGroup();
	Fmxtee::Series::Map::TTeePolygonGroup* __fastcall France();
	Fmxtee::Series::Map::TTeePolygonGroup* __fastcall Germany();
	TTeeItalyGroup* __fastcall Italy();
	Fmxtee::Series::Map::TTeePolygonGroup* __fastcall Russia();
	Fmxtee::Series::Map::TTeePolygonGroup* __fastcall Spain();
	Fmxtee::Series::Map::TTeePolygonGroup* __fastcall UK();
public:
	/* TTeePolygonGroup.Create */ inline __fastcall virtual TTeeEuropeGroup(Fmxtee::Series::Map::TMapSeries* const AMap) : Fmxtee::Series::Map::TTeePolygonGroup(AMap) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TTeePolygonGroupClass;

enum DECLSPEC_DENUM TWorldMap : unsigned char { wmWorld, wmAfrica, wmAsia, wmAustralia, wmCentralAmerica, wmEurope, wmEurope15, wmEurope27, wmSpain, wmMiddleEast, wmNorthAmerica, wmSouthAmerica, wmUSA, wmUSAHawaiiAlaska, wmEurasia, wmUK, wmGermany, wmUSACounties, wmUSAAlaskaCounties, wmJapan, wmChina, wmFrance, wmChinaProvinces, wmAustraliaCounties, wmAustraliaStates };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TWorldEntities : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TTeeAfricaGroup* IAfrica;
	Fmxtee::Series::Map::TTeePolygonGroup* IAntarctica;
	Fmxtee::Series::Map::TTeePolygonGroup* IAustralia;
	TTeeAmericaGroup* IAmerica;
	TTeeAsiaGroup* IAsia;
	TTeeEuropeGroup* IEurope;
	Fmxtee::Series::Map::TTeePolygonGroup* IMiddleEast;
	Fmxtee::Series::Map::TMapSeries* Map;
	
public:
	__fastcall virtual ~TWorldEntities();
	TTeeAfricaGroup* __fastcall Africa();
	Fmxtee::Series::Map::TTeePolygonGroup* __fastcall Antarctica();
	TTeeAmericaGroup* __fastcall America();
	TTeeAsiaGroup* __fastcall Asia();
	Fmxtee::Series::Map::TTeePolygonGroup* __fastcall Australia();
	TTeeEuropeGroup* __fastcall Europe();
	Fmxtee::Series::Map::TTeePolygonGroup* __fastcall MiddleEast();
public:
	/* TObject.Create */ inline __fastcall TWorldEntities() : System::TObject() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TWorldFlags : public Fmxtee::Series::Map::TMapPersistent
{
	typedef Fmxtee::Series::Map::TMapPersistent inherited;
	
private:
	bool FVisible;
	void __fastcall SetVisible(const bool Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
public:
	/* TMapPersistent.Create */ inline __fastcall virtual TWorldFlags(Fmxtee::Series::Map::TMapSeries* const AMap) : Fmxtee::Series::Map::TMapPersistent(AMap) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TWorldFlags() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TWorldCitiesSize : unsigned char { csPopulation, csValue, csCustom };

class PASCALIMPLEMENTATION TCitySeries : public Fmxtee::Series::Bubble::TCustomBubbleSeries
{
	typedef Fmxtee::Series::Bubble::TCustomBubbleSeries inherited;
	
	
private:
	typedef System::DynamicArray<bool> _TCitySeries__1;
	
	
private:
	TWorldCitiesSize FSize;
	TWorldSeries* IMap;
	System::UnicodeString IMapName;
	_TCitySeries__1 InMap;
	float ISizeFactor;
	bool __fastcall CalcProjection(const int ValueIndex, /* out */ float &X, /* out */ float &Y);
	void __fastcall ReadMap(System::Classes::TReader* Reader);
	bool __fastcall ShouldDrawCity(int ValueIndex);
	void __fastcall WriteMap(System::Classes::TWriter* Writer);
	
protected:
	virtual Fmxtee::Engine::TAxisLabelStyle __fastcall AxisLabelStyle(Fmxtee::Engine::TChartAxis* const AAxis);
	virtual float __fastcall CalcPointerSize(const int ValueIndex);
	virtual bool __fastcall CanDrawMark(int ValueIndex);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Fmxtee::Engine::TSeriesMarkPosition* APosition);
	DYNAMIC void __fastcall DrawPointer(int AX, int AY, System::Uitypes::TAlphaColor AColor, int ValueIndex);
	virtual void __fastcall Loaded();
	
public:
	__fastcall virtual TCitySeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCitySeries();
	virtual bool __fastcall ClickedPointer(int ValueIndex, int tmpX, int tmpY, int x, int y)/* overload */;
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawValue(int ValueIndex);
	/* Hoisted overloads: */
	
protected:
	inline bool __fastcall  ClickedPointer(int ValueIndex, int tmpX, int tmpY, const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::ClickedPointer(ValueIndex, tmpX, tmpY, P); }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TWorldCities : public Fmxtee::Series::Map::TMapPersistent
{
	typedef Fmxtee::Series::Map::TMapPersistent inherited;
	
private:
	TWorldCitiesSize FSize;
	TCitySeries* ICities;
	TCitySeries* __fastcall GetCities();
	bool __fastcall GetVisible();
	void __fastcall SetSize(const TWorldCitiesSize Value);
	void __fastcall SetVisible(const bool Value);
	
public:
	__fastcall virtual ~TWorldCities();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property TCitySeries* Series = {read=GetCities};
	
__published:
	__property TWorldCitiesSize Size = {read=FSize, write=SetSize, default=0};
	__property bool Visible = {read=GetVisible, write=SetVisible, default=0};
public:
	/* TMapPersistent.Create */ inline __fastcall virtual TWorldCities(Fmxtee::Series::Map::TMapSeries* const AMap) : Fmxtee::Series::Map::TMapPersistent(AMap) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TWorldLayers : public Fmxtee::Series::Map::TMapPersistent
{
	typedef Fmxtee::Series::Map::TMapPersistent inherited;
	
private:
	TWorldCities* FCities;
	bool FStates;
	TWorldSeries* IStates;
	void __fastcall ChangedMap();
	void __fastcall Draw();
	TWorldSeries* __fastcall GetStates();
	void __fastcall MoveAlaska();
	void __fastcall SetCities(TWorldCities* const Value);
	void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	void __fastcall SetStates(const bool Value);
	
protected:
	bool __fastcall HasCities();
	
public:
	__fastcall virtual TWorldLayers(Fmxtee::Series::Map::TMapSeries* const AMap);
	__fastcall virtual ~TWorldLayers();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property TWorldSeries* Series = {read=GetStates};
	
__published:
	__property TWorldCities* Cities = {read=FCities, write=SetCities};
	__property bool States = {read=FStates, write=SetStates, default=0};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TWorldSeries : public Fmxtee::Series::Map::TMapSeries
{
	typedef Fmxtee::Series::Map::TMapSeries inherited;
	
private:
	TWorldEntities* FEntities;
	TWorldFlags* FFlags;
	bool FKeepAspect;
	TWorldLayers* FLayers;
	TWorldMap FMap;
	void __fastcall AddToGroup(const System::UnicodeString AFilter, Fmxtee::Series::Map::TTeePolygonGroup* const AGroup);
	void __fastcall DrawFlag(Fmxtee::Series::Map::TTeePolygon* const AShape);
	void __fastcall DrawFlags();
	void __fastcall FilterCities(TCitySeries* const ASeries);
	TWorldEntities* __fastcall GetEntities();
	TWorldFlags* __fastcall GetFlags();
	TWorldLayers* __fastcall GetLayers();
	void __fastcall InternalDrawSeries(Fmxtee::Engine::TChartSeries* const ASeries);
	__classmethod void __fastcall LoadCities();
	void __fastcall LoadMapShapes();
	__classmethod System::Classes::TStringList* __fastcall LoadStrings(const System::UnicodeString AName);
	void __fastcall SetAxesGeo(const bool Value);
	void __fastcall SetFlags(TWorldFlags* const Value);
	void __fastcall SetLayers(TWorldLayers* const Value);
	void __fastcall SetKeepAspect(const bool Value);
	void __fastcall SetMap(const TWorldMap Value);
	void __fastcall TryLoadCachedMap();
	void __fastcall TryLoadWorldMap();
	
protected:
	bool LoadLabels;
	DYNAMIC void __fastcall Added();
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	__classmethod virtual void __fastcall CreateSubGallery(Fmxtee::Engine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DrawAllValues();
	DYNAMIC void __fastcall GalleryChanged3D(bool Is3D);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall Loaded();
	DYNAMIC void __fastcall PrepareForGallery();
	DYNAMIC void __fastcall RecalcAxisMargins(Fmxtee::Engine::TChartAxis* const Axis, System::Types::TRectF &R);
	DYNAMIC void __fastcall Removed();
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	__classmethod virtual void __fastcall SetSubGallery(Fmxtee::Engine::TChartSeries* ASeries, int Index);
	
public:
	__fastcall virtual TWorldSeries(System::Classes::TComponent* AOwner);
	__fastcall TWorldSeries(System::Classes::TComponent* const AOwner, const TWorldMap AMap);
	__fastcall virtual ~TWorldSeries();
	__classmethod void __fastcall AddCities(Fmxtee::Engine::TChartSeries* const DestSeries);
	__classmethod void __fastcall AddPlacemarks(System::Classes::TStringList* const Values, Fmxtee::Engine::TChartSeries* const DestSeries);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC void __fastcall FillSampleValues(int NumValues = 0x0);
	__classmethod bool __fastcall IsWorldMap(const TWorldMap AMap);
	__classmethod void __fastcall LoadMapFromResource(Fmxtee::Series::Map::TMapSeries* const Series, const System::UnicodeString ShpName, const System::UnicodeString ShxName);
	void __fastcall ReloadMap();
	__property TWorldEntities* Entities = {read=GetEntities};
	
__published:
	__property TWorldFlags* Flags = {read=GetFlags, write=SetFlags};
	__property bool KeepAspect = {read=FKeepAspect, write=SetKeepAspect, default=1};
	__property TWorldLayers* Layers = {read=GetLayers, write=SetLayers};
	__property TWorldMap Map = {read=FMap, write=SetMap, default=0};
	__property Shapes = {stored=false};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace World */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_WORLD)
using namespace Fmxtee::Series::World;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES)
using namespace Fmxtee::Series;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Series_WorldHPP
