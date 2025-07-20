// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.Clustering.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Tools_ClusteringHPP
#define Fmxtee_Tools_ClusteringHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UIConsts.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Graphics.hpp>
#include <System.Types.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Functions.Clustering.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Clustering
{
//-- forward type declarations -----------------------------------------------
struct TXYZData;
struct TClusterStats;
class DELPHICLASS TClusteringTool;
//-- type declarations -------------------------------------------------------
typedef System::Types::TPointF TPointFloat;

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

class PASCALIMPLEMENTATION TClusteringTool : public Fmxtee::Engine::TTeeCustomToolSeries
{
	typedef Fmxtee::Engine::TTeeCustomToolSeries inherited;
	
private:
	bool FBoundings;
	Fmxtee::Engine::TSeriesPointer* FCenters;
	Fmxtee::Engine::TSeriesPointer* FCentroids;
	bool FColorEach;
	TClusteringMethod FMethod;
	Fmxtee::Functions::Clustering::TClusterProvider* Provider;
	Fmxtee::Canvas::TTeeTransparency FTransp;
	Fmxtee::Functions::Clustering::THierarchicalClustering* FHierarchical;
	Fmxtee::Functions::Clustering::TKMeansClustering* FKMeans;
	Fmxtee::Functions::Clustering::TQTClustering* FQTClustering;
	void __fastcall Colorize(Fmxtee::Functions::Clustering::TCluster* const ACluster);
	TDistanceMethod __fastcall GetDistance();
	float __fastcall GetLambda();
	Fmxtee::Functions::Clustering::TLinkageMethod __fastcall GetLinkage();
	void __fastcall ResetColors();
	void __fastcall SetBoundings(const bool Value);
	void __fastcall SetCenters(Fmxtee::Engine::TSeriesPointer* const Value);
	void __fastcall SetCentroids(Fmxtee::Engine::TSeriesPointer* const Value);
	void __fastcall SetColorEach(const bool Value);
	void __fastcall SetDistance(const TDistanceMethod Value);
	void __fastcall SetLambda(const float Value);
	void __fastcall SetLinkage(const Fmxtee::Functions::Clustering::TLinkageMethod Value);
	void __fastcall SetMethod(const TClusteringMethod Value);
	void __fastcall SetTransp(const Fmxtee::Canvas::TTeeTransparency Value);
	
protected:
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetSeries(Fmxtee::Engine::TChartSeries* const Value);
	
public:
	__fastcall virtual TClusteringTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TClusteringTool();
	void __fastcall Clear();
	Fmxtee::Functions::Clustering::TCluster* __fastcall Clusters();
	TXYZData __fastcall Data(Fmxtee::Functions::Clustering::TCluster* const ACluster);
	__classmethod virtual System::UnicodeString __fastcall Description();
	Fmxtee::Functions::Clustering::TCluster* __fastcall Execute();
	System::Types::TPointF __fastcall GetClusterCenter(Fmxtee::Functions::Clustering::TCluster* const ACluster);
	System::Types::TPointF __fastcall GetHullCentroid(Fmxtee::Functions::Clustering::TCluster* const ACluster);
	void __fastcall GetClusterPoints(Fmxtee::Functions::Clustering::TCluster* const ACluster, /* out */ Fmxtee::Canvas::TPointArray &Points);
	TClusterStats __fastcall GetStats(Fmxtee::Functions::Clustering::TCluster* const ACluster);
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property bool ColorEach = {read=FColorEach, write=SetColorEach, default=1};
	__property TDistanceMethod Distance = {read=GetDistance, write=SetDistance, default=0};
	__property Fmxtee::Functions::Clustering::TLinkageMethod Linkage = {read=GetLinkage, write=SetLinkage, default=0};
	__property TClusteringMethod Method = {read=FMethod, write=SetMethod, default=0};
	__property float MinkowskiLambda = {read=GetLambda, write=SetLambda};
	__property Fmxtee::Functions::Clustering::THierarchicalClustering* Hierarchical = {read=FHierarchical};
	__property Fmxtee::Functions::Clustering::TKMeansClustering* KMeans = {read=FKMeans};
	__property Fmxtee::Functions::Clustering::TQTClustering* QTClustering = {read=FQTClustering};
	__property Fmxtee::Engine::TSeriesPointer* Centers = {read=FCenters, write=SetCenters};
	__property Fmxtee::Engine::TSeriesPointer* Centroids = {read=FCentroids, write=SetCentroids};
	__property bool ShowBounds = {read=FBoundings, write=SetBoundings, default=1};
	__property Fmxtee::Canvas::TTeeTransparency Transparency = {read=FTransp, write=SetTransp, default=75};
};


typedef System::DynamicArray<Fmxtee::Canvas::TFloatPoint> TFloatPointArray;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall BoundingEllipse(const Fmxtee::Canvas::TPointArray P, System::Types::TPointF &Center, System::Types::TPointF &Radius, double &RotationAngle);
}	/* namespace Clustering */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_CLUSTERING)
using namespace Fmxtee::Tools::Clustering;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS)
using namespace Fmxtee::Tools;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Tools_ClusteringHPP
