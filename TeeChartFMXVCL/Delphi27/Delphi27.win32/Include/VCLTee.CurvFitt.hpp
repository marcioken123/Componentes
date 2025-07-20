// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.CurvFitt.pas' rev: 34.00 (Windows)

#ifndef Vcltee_CurvfittHPP
#define Vcltee_CurvfittHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <VCLTee.TeePoly.hpp>
#include <VCLTee.TeEngine.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Curvfitt
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomFittingFunction;
class DELPHICLASS TCurveFittingFunction;
class DELPHICLASS TCustomTrendFunction;
class DELPHICLASS TTrendFunction;
class DELPHICLASS TExpTrendFunction;
class DELPHICLASS TCorrelationFunction;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TTypeFitting : unsigned char { cfPolynomial };

class PASCALIMPLEMENTATION TCustomFittingFunction : public Vcltee::Teengine::TTeeFunction
{
	typedef Vcltee::Teengine::TTeeFunction inherited;
	
private:
	int FFactor;
	int FFirstPoint;
	int FFirstCalcPoint;
	int FLastPoint;
	int FLastCalcPoint;
	int FPolyDegree;
	TTypeFitting FTypeFitting;
	Vcltee::Teepoly::TDegreeVector IAnswerVector;
	double IMinYValue;
	void __fastcall SetFactor(const int Value);
	void __fastcall SetFirstCalcPoint(int Value);
	void __fastcall SetFirstPoint(int Value);
	void __fastcall SetIntegerProperty(int &Variable, int Value);
	void __fastcall SetLastCalcPoint(int Value);
	void __fastcall SetLastPoint(int Value);
	void __fastcall SetPolyDegree(int Value);
	void __fastcall SetTypeFitting(TTypeFitting Value);
	
protected:
	double __fastcall GetAnswerVector(int Index);
	virtual void __fastcall AddFittedPoints(Vcltee::Teengine::TChartSeries* Source);
	__property int Factor = {read=FFactor, write=SetFactor, nodefault};
	
public:
	__fastcall virtual TCustomFittingFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
	double __fastcall GetCurveYValue(Vcltee::Teengine::TChartSeries* Source, const double X);
	__property double AnswerVector[int Index] = {read=GetAnswerVector};
	__property int FirstCalcPoint = {read=FFirstCalcPoint, write=SetFirstCalcPoint, default=-1};
	__property int FirstPoint = {read=FFirstPoint, write=SetFirstPoint, default=-1};
	__property int LastCalcPoint = {read=FLastCalcPoint, write=SetLastCalcPoint, default=-1};
	__property int LastPoint = {read=FLastPoint, write=SetLastPoint, default=-1};
	__property int PolyDegree = {read=FPolyDegree, write=SetPolyDegree, default=5};
	__property TTypeFitting TypeFitting = {read=FTypeFitting, write=SetTypeFitting, default=0};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TCustomFittingFunction() { }
	
};


class PASCALIMPLEMENTATION TCurveFittingFunction : public TCustomFittingFunction
{
	typedef TCustomFittingFunction inherited;
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
__published:
	__property Factor = {default=1};
	__property FirstCalcPoint = {default=-1};
	__property FirstPoint = {default=-1};
	__property LastCalcPoint = {default=-1};
	__property LastPoint = {default=-1};
	__property PolyDegree = {default=5};
	__property TypeFitting = {default=0};
public:
	/* TCustomFittingFunction.Create */ inline __fastcall virtual TCurveFittingFunction(System::Classes::TComponent* AOwner) : TCustomFittingFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TCurveFittingFunction() { }
	
};


enum DECLSPEC_DENUM TTrendStyle : unsigned char { tsNormal, tsLogarithmic, tsExponential };

class PASCALIMPLEMENTATION TCustomTrendFunction : public Vcltee::Teengine::TTeeFunction
{
	typedef Vcltee::Teengine::TTeeFunction inherited;
	
private:
	TTrendStyle IStyle;
	int ICount;
	double SumX;
	double SumXY;
	double SumY;
	double SumX2;
	double SumY2;
	bool __fastcall CalculateValues(Vcltee::Teengine::TChartSeries* Source, int FirstIndex, int LastIndex);
	
protected:
	virtual void __fastcall CalculatePeriod(Vcltee::Teengine::TChartSeries* Source, const double tmpX, int FirstIndex, int LastIndex);
	virtual void __fastcall CalculateAllPoints(Vcltee::Teengine::TChartSeries* Source, Vcltee::Teengine::TChartValueList* NotMandatorySource);
	
public:
	__fastcall virtual TCustomTrendFunction(System::Classes::TComponent* AOwner);
	virtual double __fastcall Calculate(Vcltee::Teengine::TChartSeries* const SourceSeries, int First, int Last);
	virtual double __fastcall CalculateMany(Vcltee::Teengine::TDataSourcesList* const SourceSeriesList, int ValueIndex);
	bool __fastcall CalculateTrend(double &m, double &b, Vcltee::Teengine::TChartSeries* Source, int FirstIndex, int LastIndex);
	double __fastcall Coefficient(Vcltee::Teengine::TChartSeries* Source, int FirstIndex, int LastIndex);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TCustomTrendFunction() { }
	
};


class PASCALIMPLEMENTATION TTrendFunction : public TCustomTrendFunction
{
	typedef TCustomTrendFunction inherited;
	
public:
	/* TCustomTrendFunction.Create */ inline __fastcall virtual TTrendFunction(System::Classes::TComponent* AOwner) : TCustomTrendFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TTrendFunction() { }
	
};


class PASCALIMPLEMENTATION TExpTrendFunction : public TCustomTrendFunction
{
	typedef TCustomTrendFunction inherited;
	
public:
	__fastcall virtual TExpTrendFunction(System::Classes::TComponent* AOwner);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TExpTrendFunction() { }
	
};


class PASCALIMPLEMENTATION TCorrelationFunction : public TCustomTrendFunction
{
	typedef TCustomTrendFunction inherited;
	
protected:
	virtual void __fastcall CalculatePeriod(Vcltee::Teengine::TChartSeries* Source, const double tmpX, int FirstIndex, int LastIndex);
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	virtual double __fastcall Calculate(Vcltee::Teengine::TChartSeries* const SourceSeries, int First, int Last);
	virtual double __fastcall CalculateMany(Vcltee::Teengine::TDataSourcesList* const SourceSeriesList, int ValueIndex);
public:
	/* TCustomTrendFunction.Create */ inline __fastcall virtual TCorrelationFunction(System::Classes::TComponent* AOwner) : TCustomTrendFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TCorrelationFunction() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Curvfitt */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_CURVFITT)
using namespace Vcltee::Curvfitt;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_CurvfittHPP
