// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeClusteringTool.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeclusteringtoolHPP
#define Vcltee_TeeclusteringtoolHPP

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
#include <System.UIConsts.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeClustering.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeclusteringtool
{
//-- forward type declarations -----------------------------------------------
struct TXYZData;
struct TClusterStats;
class DELPHICLASS TClusteringTool;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TXYZData
{
public:
	double X;
	double Y;
	double Z;
	int Index;
};


struct DECLSPEC_DRECORD TClusterStats
{
public:
	double CoVariance;
	double Correlation;
	double SumOfSquares;
};


enum DECLSPEC_DENUM TDistanceMethod : unsigned char { dmEuclidean, dmSquaredEuclidean, dmManhattan, dmMinkowski, dmSorensen, dmChebyshev };

enum DECLSPEC_DENUM TClusteringMethod : unsigned char { cmKMeans, cmHierarchical, cmQT };

class PASCALIMPLEMENTATION TClusteringTool : public Vcltee::Teengine::TTeeCustomToolSeries
{
	typedef Vcltee::Teengine::TTeeCustomToolSeries inherited;
	
private:
	bool FBoundings;
	Vcltee::Teengine::TSeriesPointer* FCenters;
	Vcltee::Teengine::TSeriesPointer* FCentroids;
	bool FColorEach;
	TClusteringMethod FMethod;
	Vcltee::Teeclustering::TClusterProvider* Provider;
	Vcltee::Tecanvas::TTeeTransparency FTransp;
	Vcltee::Teeclustering::THierarchicalClustering* FHierarchical;
	Vcltee::Teeclustering::TKMeansClustering* FKMeans;
	Vcltee::Teeclustering::TQTClustering* FQTClustering;
	void __fastcall Colorize(Vcltee::Teeclustering::TCluster* const ACluster);
	TDistanceMethod __fastcall GetDistance();
	float __fastcall GetLambda();
	Vcltee::Teeclustering::TLinkageMethod __fastcall GetLinkage();
	void __fastcall ResetColors();
	void __fastcall SetBoundings(const bool Value);
	void __fastcall SetCenters(Vcltee::Teengine::TSeriesPointer* const Value);
	void __fastcall SetCentroids(Vcltee::Teengine::TSeriesPointer* const Value);
	void __fastcall SetColorEach(const bool Value);
	void __fastcall SetDistance(const TDistanceMethod Value);
	void __fastcall SetLambda(const float Value);
	void __fastcall SetLinkage(const Vcltee::Teeclustering::TLinkageMethod Value);
	void __fastcall SetMethod(const TClusteringMethod Value);
	void __fastcall SetTransp(const Vcltee::Tecanvas::TTeeTransparency Value);
	
protected:
	virtual void __fastcall ChartEvent(Vcltee::Teengine::TChartToolEvent AEvent);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetSeries(Vcltee::Teengine::TChartSeries* const Value);
	
public:
	__fastcall virtual TClusteringTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TClusteringTool();
	void __fastcall Clear();
	Vcltee::Teeclustering::TCluster* __fastcall Clusters();
	TXYZData __fastcall Data(Vcltee::Teeclustering::TCluster* const ACluster);
	__classmethod virtual System::UnicodeString __fastcall Description();
	Vcltee::Teeclustering::TCluster* __fastcall Execute();
	_POINTFLOAT __fastcall GetClusterCenter(Vcltee::Teeclustering::TCluster* const ACluster);
	_POINTFLOAT __fastcall GetHullCentroid(Vcltee::Teeclustering::TCluster* const ACluster);
	void __fastcall GetClusterPoints(Vcltee::Teeclustering::TCluster* const ACluster, /* out */ Vcltee::Tecanvas::TPointArray &Points);
	TClusterStats __fastcall GetStats(Vcltee::Teeclustering::TCluster* const ACluster);
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property bool ColorEach = {read=FColorEach, write=SetColorEach, default=1};
	__property TDistanceMethod Distance = {read=GetDistance, write=SetDistance, default=0};
	__property Vcltee::Teeclustering::TLinkageMethod Linkage = {read=GetLinkage, write=SetLinkage, default=0};
	__property TClusteringMethod Method = {read=FMethod, write=SetMethod, default=0};
	__property float MinkowskiLambda = {read=GetLambda, write=SetLambda};
	__property Vcltee::Teeclustering::THierarchicalClustering* Hierarchical = {read=FHierarchical};
	__property Vcltee::Teeclustering::TKMeansClustering* KMeans = {read=FKMeans};
	__property Vcltee::Teeclustering::TQTClustering* QTClustering = {read=FQTClustering};
	__property Vcltee::Teengine::TSeriesPointer* Centers = {read=FCenters, write=SetCenters};
	__property Vcltee::Teengine::TSeriesPointer* Centroids = {read=FCentroids, write=SetCentroids};
	__property bool ShowBounds = {read=FBoundings, write=SetBoundings, default=1};
	__property Vcltee::Tecanvas::TTeeTransparency Transparency = {read=FTransp, write=SetTransp, default=75};
};


typedef System::DynamicArray<Vcltee::Tecanvas::TFloatPoint> TFloatPointArray;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall BoundingEllipse(const Vcltee::Tecanvas::TPointArray P, _POINTFLOAT &Center, _POINTFLOAT &Radius, double &RotationAngle);
}	/* namespace Teeclusteringtool */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECLUSTERINGTOOL)
using namespace Vcltee::Teeclusteringtool;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeclusteringtoolHPP
