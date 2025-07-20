// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeWorldSeries.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeworldseriesHPP
#define Vcltee_TeeworldseriesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.BubbleCh.hpp>
#include <VCLTee.TeeMapSeries.hpp>
#include <VCLTee.TeeSurfa.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeworldseries
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
class PASCALIMPLEMENTATION TTeeAfricaGroup : public Vcltee::Teemapseries::TTeePolygonGroup
{
	typedef Vcltee::Teemapseries::TTeePolygonGroup inherited;
	
public:
	/* TTeePolygonGroup.Create */ inline __fastcall virtual TTeeAfricaGroup(Vcltee::Teemapseries::TMapSeries* const AMap) : Vcltee::Teemapseries::TTeePolygonGroup(AMap) { }
	/* TTeePolygonGroup.Destroy */ inline __fastcall virtual ~TTeeAfricaGroup() { }
	
};


class PASCALIMPLEMENTATION TTeeUSAGroup : public Vcltee::Teemapseries::TTeePolygonGroup
{
	typedef Vcltee::Teemapseries::TTeePolygonGroup inherited;
	
private:
	Vcltee::Teemapseries::TTeePolygonGroup* IAlaska;
	Vcltee::Teemapseries::TTeePolygonGroup* IHawaii;
	Vcltee::Teemapseries::TTeePolygonGroup* IPuertoRico;
	
public:
	__fastcall virtual ~TTeeUSAGroup();
	Vcltee::Teemapseries::TTeePolygonGroup* __fastcall Alaska();
	Vcltee::Teemapseries::TTeePolygonGroup* __fastcall Hawaii();
	Vcltee::Teemapseries::TTeePolygonGroup* __fastcall PuertoRico();
public:
	/* TTeePolygonGroup.Create */ inline __fastcall virtual TTeeUSAGroup(Vcltee::Teemapseries::TMapSeries* const AMap) : Vcltee::Teemapseries::TTeePolygonGroup(AMap) { }
	
};


class PASCALIMPLEMENTATION TTeeNorthAmericaGroup : public Vcltee::Teemapseries::TTeePolygonGroup
{
	typedef Vcltee::Teemapseries::TTeePolygonGroup inherited;
	
private:
	Vcltee::Teemapseries::TTeePolygonGroup* ICanada;
	TTeeUSAGroup* IUSA;
	
public:
	__fastcall virtual ~TTeeNorthAmericaGroup();
	Vcltee::Teemapseries::TTeePolygonGroup* __fastcall Canada();
	TTeeUSAGroup* __fastcall USA();
public:
	/* TTeePolygonGroup.Create */ inline __fastcall virtual TTeeNorthAmericaGroup(Vcltee::Teemapseries::TMapSeries* const AMap) : Vcltee::Teemapseries::TTeePolygonGroup(AMap) { }
	
};


class PASCALIMPLEMENTATION TTeeSouthAmericaGroup : public Vcltee::Teemapseries::TTeePolygonGroup
{
	typedef Vcltee::Teemapseries::TTeePolygonGroup inherited;
	
public:
	/* TTeePolygonGroup.Create */ inline __fastcall virtual TTeeSouthAmericaGroup(Vcltee::Teemapseries::TMapSeries* const AMap) : Vcltee::Teemapseries::TTeePolygonGroup(AMap) { }
	/* TTeePolygonGroup.Destroy */ inline __fastcall virtual ~TTeeSouthAmericaGroup() { }
	
};


class PASCALIMPLEMENTATION TTeeAmericaGroup : public Vcltee::Teemapseries::TTeePolygonGroup
{
	typedef Vcltee::Teemapseries::TTeePolygonGroup inherited;
	
private:
	Vcltee::Teemapseries::TTeePolygonGroup* ICentral;
	TTeeNorthAmericaGroup* INorth;
	TTeeSouthAmericaGroup* ISouth;
	
public:
	__fastcall virtual ~TTeeAmericaGroup();
	Vcltee::Teemapseries::TTeePolygonGroup* __fastcall Central();
	TTeeNorthAmericaGroup* __fastcall North();
	TTeeSouthAmericaGroup* __fastcall South();
public:
	/* TTeePolygonGroup.Create */ inline __fastcall virtual TTeeAmericaGroup(Vcltee::Teemapseries::TMapSeries* const AMap) : Vcltee::Teemapseries::TTeePolygonGroup(AMap) { }
	
};


class PASCALIMPLEMENTATION TTeeAsiaGroup : public Vcltee::Teemapseries::TTeePolygonGroup
{
	typedef Vcltee::Teemapseries::TTeePolygonGroup inherited;
	
private:
	Vcltee::Teemapseries::TTeePolygonGroup* IChina;
	Vcltee::Teemapseries::TTeePolygonGroup* IJapan;
	
public:
	__fastcall virtual ~TTeeAsiaGroup();
	Vcltee::Teemapseries::TTeePolygonGroup* __fastcall China();
	Vcltee::Teemapseries::TTeePolygonGroup* __fastcall Japan();
public:
	/* TTeePolygonGroup.Create */ inline __fastcall virtual TTeeAsiaGroup(Vcltee::Teemapseries::TMapSeries* const AMap) : Vcltee::Teemapseries::TTeePolygonGroup(AMap) { }
	
};


class PASCALIMPLEMENTATION TTeeItalyGroup : public Vcltee::Teemapseries::TTeePolygonGroup
{
	typedef Vcltee::Teemapseries::TTeePolygonGroup inherited;
	
public:
	/* TTeePolygonGroup.Create */ inline __fastcall virtual TTeeItalyGroup(Vcltee::Teemapseries::TMapSeries* const AMap) : Vcltee::Teemapseries::TTeePolygonGroup(AMap) { }
	/* TTeePolygonGroup.Destroy */ inline __fastcall virtual ~TTeeItalyGroup() { }
	
};


class PASCALIMPLEMENTATION TTeeEuropeGroup : public Vcltee::Teemapseries::TTeePolygonGroup
{
	typedef Vcltee::Teemapseries::TTeePolygonGroup inherited;
	
private:
	Vcltee::Teemapseries::TTeePolygonGroup* IUK;
	Vcltee::Teemapseries::TTeePolygonGroup* IFrance;
	Vcltee::Teemapseries::TTeePolygonGroup* IGermany;
	Vcltee::Teemapseries::TTeePolygonGroup* IRussia;
	Vcltee::Teemapseries::TTeePolygonGroup* ISpain;
	TTeeItalyGroup* IItaly;
	
public:
	__fastcall virtual ~TTeeEuropeGroup();
	Vcltee::Teemapseries::TTeePolygonGroup* __fastcall France();
	Vcltee::Teemapseries::TTeePolygonGroup* __fastcall Germany();
	TTeeItalyGroup* __fastcall Italy();
	Vcltee::Teemapseries::TTeePolygonGroup* __fastcall Russia();
	Vcltee::Teemapseries::TTeePolygonGroup* __fastcall Spain();
	Vcltee::Teemapseries::TTeePolygonGroup* __fastcall UK();
public:
	/* TTeePolygonGroup.Create */ inline __fastcall virtual TTeeEuropeGroup(Vcltee::Teemapseries::TMapSeries* const AMap) : Vcltee::Teemapseries::TTeePolygonGroup(AMap) { }
	
};


_DECLARE_METACLASS(System::TMetaClass, TTeePolygonGroupClass);

enum DECLSPEC_DENUM TWorldMap : unsigned char { wmWorld, wmAfrica, wmAsia, wmAustralia, wmCentralAmerica, wmEurope, wmEurope15, wmEurope27, wmSpain, wmMiddleEast, wmNorthAmerica, wmSouthAmerica, wmUSA, wmUSAHawaiiAlaska, wmEurasia, wmUK, wmGermany, wmUSACounties, wmUSAAlaskaCounties, wmJapan, wmChina, wmFrance, wmChinaProvinces, wmAustraliaCounties, wmAustraliaStates };

class PASCALIMPLEMENTATION TWorldEntities : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TTeeAfricaGroup* IAfrica;
	Vcltee::Teemapseries::TTeePolygonGroup* IAntarctica;
	Vcltee::Teemapseries::TTeePolygonGroup* IAustralia;
	TTeeAmericaGroup* IAmerica;
	TTeeAsiaGroup* IAsia;
	TTeeEuropeGroup* IEurope;
	Vcltee::Teemapseries::TTeePolygonGroup* IMiddleEast;
	Vcltee::Teemapseries::TMapSeries* Map;
	
public:
	__fastcall virtual ~TWorldEntities();
	TTeeAfricaGroup* __fastcall Africa();
	Vcltee::Teemapseries::TTeePolygonGroup* __fastcall Antarctica();
	TTeeAmericaGroup* __fastcall America();
	TTeeAsiaGroup* __fastcall Asia();
	Vcltee::Teemapseries::TTeePolygonGroup* __fastcall Australia();
	TTeeEuropeGroup* __fastcall Europe();
	Vcltee::Teemapseries::TTeePolygonGroup* __fastcall MiddleEast();
public:
	/* TObject.Create */ inline __fastcall TWorldEntities() : System::TObject() { }
	
};


class PASCALIMPLEMENTATION TWorldFlags : public Vcltee::Teemapseries::TMapPersistent
{
	typedef Vcltee::Teemapseries::TMapPersistent inherited;
	
private:
	bool FVisible;
	void __fastcall SetVisible(const bool Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
public:
	/* TMapPersistent.Create */ inline __fastcall virtual TWorldFlags(Vcltee::Teemapseries::TMapSeries* const AMap) : Vcltee::Teemapseries::TMapPersistent(AMap) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TWorldFlags() { }
	
};


enum DECLSPEC_DENUM TWorldCitiesSize : unsigned char { csPopulation, csValue, csCustom };

class PASCALIMPLEMENTATION TCitySeries : public Vcltee::Bubblech::TCustomBubbleSeries
{
	typedef Vcltee::Bubblech::TCustomBubbleSeries inherited;
	
	
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
	virtual Vcltee::Teengine::TAxisLabelStyle __fastcall AxisLabelStyle(Vcltee::Teengine::TChartAxis* const AAxis);
	virtual float __fastcall CalcPointerSize(const int ValueIndex);
	virtual bool __fastcall CanDrawMark(int ValueIndex);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Vcltee::Teengine::TSeriesMarkPosition* APosition);
	DYNAMIC void __fastcall DrawPointer(int AX, int AY, System::Uitypes::TColor AColor, int ValueIndex);
	virtual void __fastcall Loaded();
	
public:
	__fastcall virtual TCitySeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCitySeries();
	virtual bool __fastcall ClickedPointer(int ValueIndex, int tmpX, int tmpY, int x, int y)/* overload */;
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawValue(int ValueIndex);
	/* Hoisted overloads: */
	
protected:
	inline bool __fastcall  ClickedPointer(int ValueIndex, int tmpX, int tmpY, const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::ClickedPointer(ValueIndex, tmpX, tmpY, P); }
	
};


class PASCALIMPLEMENTATION TWorldCities : public Vcltee::Teemapseries::TMapPersistent
{
	typedef Vcltee::Teemapseries::TMapPersistent inherited;
	
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
	/* TMapPersistent.Create */ inline __fastcall virtual TWorldCities(Vcltee::Teemapseries::TMapSeries* const AMap) : Vcltee::Teemapseries::TMapPersistent(AMap) { }
	
};


class PASCALIMPLEMENTATION TWorldLayers : public Vcltee::Teemapseries::TMapPersistent
{
	typedef Vcltee::Teemapseries::TMapPersistent inherited;
	
private:
	TWorldCities* FCities;
	bool FStates;
	TWorldSeries* IStates;
	void __fastcall ChangedMap();
	void __fastcall Draw();
	TWorldSeries* __fastcall GetStates();
	void __fastcall MoveAlaska();
	void __fastcall SetCities(TWorldCities* const Value);
	void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	void __fastcall SetStates(const bool Value);
	
protected:
	bool __fastcall HasCities();
	
public:
	__fastcall virtual TWorldLayers(Vcltee::Teemapseries::TMapSeries* const AMap);
	__fastcall virtual ~TWorldLayers();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property TWorldSeries* Series = {read=GetStates};
	
__published:
	__property TWorldCities* Cities = {read=FCities, write=SetCities};
	__property bool States = {read=FStates, write=SetStates, default=0};
};


class PASCALIMPLEMENTATION TWorldSeries : public Vcltee::Teemapseries::TMapSeries
{
	typedef Vcltee::Teemapseries::TMapSeries inherited;
	
private:
	TWorldEntities* FEntities;
	TWorldFlags* FFlags;
	bool FKeepAspect;
	TWorldLayers* FLayers;
	TWorldMap FMap;
	void __fastcall AddToGroup(const System::UnicodeString AFilter, Vcltee::Teemapseries::TTeePolygonGroup* const AGroup);
	void __fastcall DrawFlag(Vcltee::Teemapseries::TTeePolygon* const AShape);
	void __fastcall DrawFlags();
	void __fastcall FilterCities(TCitySeries* const ASeries);
	TWorldEntities* __fastcall GetEntities();
	TWorldFlags* __fastcall GetFlags();
	TWorldLayers* __fastcall GetLayers();
	void __fastcall InternalDrawSeries(Vcltee::Teengine::TChartSeries* const ASeries);
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
	__classmethod virtual void __fastcall CreateSubGallery(Vcltee::Teengine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DrawAllValues();
	DYNAMIC void __fastcall GalleryChanged3D(bool Is3D);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall Loaded();
	DYNAMIC void __fastcall PrepareForGallery();
	DYNAMIC void __fastcall RecalcAxisMargins(Vcltee::Teengine::TChartAxis* const Axis, System::Types::TRect &R);
	DYNAMIC void __fastcall Removed();
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	__classmethod virtual void __fastcall SetSubGallery(Vcltee::Teengine::TChartSeries* ASeries, int Index);
	
public:
	__fastcall virtual TWorldSeries(System::Classes::TComponent* AOwner);
	__fastcall TWorldSeries(System::Classes::TComponent* const AOwner, const TWorldMap AMap);
	__fastcall virtual ~TWorldSeries();
	__classmethod void __fastcall AddCities(Vcltee::Teengine::TChartSeries* const DestSeries);
	__classmethod void __fastcall AddPlacemarks(System::Classes::TStringList* const Values, Vcltee::Teengine::TChartSeries* const DestSeries);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC void __fastcall FillSampleValues(int NumValues = 0x0);
	__classmethod bool __fastcall IsWorldMap(const TWorldMap AMap);
	__classmethod void __fastcall LoadMapFromResource(Vcltee::Teemapseries::TMapSeries* const Series, const System::UnicodeString ShpName, const System::UnicodeString ShxName);
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
}	/* namespace Teeworldseries */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEWORLDSERIES)
using namespace Vcltee::Teeworldseries;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeworldseriesHPP
