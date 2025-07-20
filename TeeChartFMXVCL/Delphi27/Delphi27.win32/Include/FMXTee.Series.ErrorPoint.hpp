// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.ErrorPoint.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Series_ErrorpointHPP
#define Fmxtee_Series_ErrorpointHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <FMX.Types.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Series.Point3D.hpp>
#include <FMXTee.Series.Error.hpp>
#include <FMXTee.Constants.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Series.Surface.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Errorpoint
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TErrorsFormat;
class DELPHICLASS TErrors3DFormat;
class DELPHICLASS TErrorsBase;
class DELPHICLASS TErrors;
class DELPHICLASS TErrors3D;
class DELPHICLASS TCustomErrorPointSeries;
class DELPHICLASS TErrorPointSeries;
class DELPHICLASS TCustomErrorPoint3DSeries;
class DELPHICLASS TErrorPoint3DSeries;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TErrorsFormat : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Fmxtee::Canvas::TTeePen* FLeft;
	Fmxtee::Canvas::TTeePen* FRight;
	Fmxtee::Canvas::TTeePen* FTop;
	Fmxtee::Canvas::TTeePen* FBottom;
	void __fastcall SetLeft(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetRight(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetTop(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetBottom(Fmxtee::Canvas::TTeePen* const Value);
	
public:
	__fastcall TErrorsFormat(Fmxtee::Engine::TChartSeries* AOwner);
	__fastcall virtual ~TErrorsFormat();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Fmxtee::Canvas::TTeePen* Left = {read=FLeft, write=SetLeft};
	__property Fmxtee::Canvas::TTeePen* Right = {read=FRight, write=SetRight};
	__property Fmxtee::Canvas::TTeePen* Top = {read=FTop, write=SetTop};
	__property Fmxtee::Canvas::TTeePen* Bottom = {read=FBottom, write=SetBottom};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TErrors3DFormat : public TErrorsFormat
{
	typedef TErrorsFormat inherited;
	
private:
	Fmxtee::Canvas::TTeePen* FFront;
	Fmxtee::Canvas::TTeePen* FBack;
	void __fastcall SetFront(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetBack(Fmxtee::Canvas::TTeePen* const Value);
	
public:
	__fastcall TErrors3DFormat(Fmxtee::Engine::TChartSeries* AOwner);
	__fastcall virtual ~TErrors3DFormat();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Fmxtee::Canvas::TTeePen* Front = {read=FFront, write=SetFront};
	__property Fmxtee::Canvas::TTeePen* Back = {read=FBack, write=SetBack};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TErrorsBase : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Fmxtee::Engine::TChartValueList* FLeft;
	Fmxtee::Engine::TChartValueList* FRight;
	Fmxtee::Engine::TChartValueList* FTop;
	Fmxtee::Engine::TChartValueList* FBottom;
	bool FSeriesColor;
	int FSize;
	Fmxtee::Series::Error::TErrorWidthUnits FSizeUnits;
	Fmxtee::Engine::TChartSeries* ISeries;
	void __fastcall PreparePen(int ValueIndex, Fmxtee::Canvas::TTeePen* const APen);
	void __fastcall SetLeft(Fmxtee::Engine::TChartValueList* const Value);
	void __fastcall SetRight(Fmxtee::Engine::TChartValueList* const Value);
	void __fastcall SetTop(Fmxtee::Engine::TChartValueList* const Value);
	void __fastcall SetBottom(Fmxtee::Engine::TChartValueList* const Value);
	void __fastcall SetSize(int Value);
	void __fastcall SetSizeUnits(const Fmxtee::Series::Error::TErrorWidthUnits Value);
	void __fastcall SetSeriesColor(const bool Value);
	
protected:
	void __fastcall AddSample(int Index, const double X, const double Y);
	void __fastcall DrawError(int X, int Y, int ALength, int HalfSize, int AZ, bool IsHoriz);
	void __fastcall CalcMinMaxIndex(/* out */ int &MinIndex, /* out */ int &MaxIndex, bool Horizontal);
	
public:
	__fastcall virtual TErrorsBase(Fmxtee::Engine::TChartSeries* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Fmxtee::Engine::TChartValueList* Left = {read=FLeft, write=SetLeft};
	__property Fmxtee::Engine::TChartValueList* Right = {read=FRight, write=SetRight};
	__property Fmxtee::Engine::TChartValueList* Top = {read=FTop, write=SetTop};
	__property Fmxtee::Engine::TChartValueList* Bottom = {read=FBottom, write=SetBottom};
	__property bool SeriesColor = {read=FSeriesColor, write=SetSeriesColor, default=0};
	__property int Size = {read=FSize, write=SetSize, default=100};
	__property Fmxtee::Series::Error::TErrorWidthUnits SizeUnits = {read=FSizeUnits, write=SetSizeUnits, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TErrorsBase() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TErrors : public TErrorsBase
{
	typedef TErrorsBase inherited;
	
private:
	TErrorsFormat* FFormat;
	void __fastcall SetFormat(TErrorsFormat* const Value);
	
public:
	__fastcall virtual TErrors(Fmxtee::Engine::TChartSeries* AOwner);
	__fastcall virtual ~TErrors();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property TErrorsFormat* Format = {read=FFormat, write=SetFormat};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TErrors3D : public TErrorsBase
{
	typedef TErrorsBase inherited;
	
private:
	TErrors3DFormat* FFormat;
	Fmxtee::Engine::TChartValueList* FFront;
	Fmxtee::Engine::TChartValueList* FBack;
	void __fastcall SetFormat(TErrors3DFormat* const Value);
	void __fastcall SetFront(Fmxtee::Engine::TChartValueList* const Value);
	void __fastcall SetBack(Fmxtee::Engine::TChartValueList* const Value);
	
protected:
	HIDESBASE void __fastcall AddSample(int Index, const double X, const double Y);
	void __fastcall DrawZError(int X, int Y, int Z, int ALength, int HalfSize);
	
public:
	__fastcall virtual TErrors3D(Fmxtee::Engine::TChartSeries* AOwner);
	__fastcall virtual ~TErrors3D();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property TErrors3DFormat* Format = {read=FFormat, write=SetFormat};
	__property Fmxtee::Engine::TChartValueList* Front = {read=FFront, write=SetFront};
	__property Fmxtee::Engine::TChartValueList* Back = {read=FBack, write=SetBack};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TCustomErrorPointSeries : public Fmxtee::Series::TPointSeries
{
	typedef Fmxtee::Series::TPointSeries inherited;
	
private:
	TErrors* FErrors;
	void __fastcall SetErrors(TErrors* const Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall CalcHorizMargins(int &LeftMargin, int &RightMargin);
	virtual void __fastcall CalcVerticalMargins(int &TopMargin, int &BottomMargin);
	void __fastcall CalcErrorSize(/* out */ int &Horiz, /* out */ int &Vert);
	virtual void __fastcall DrawValue(int ValueIndex);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TCustomErrorPointSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomErrorPointSeries();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	HIDESBASE int __fastcall Add(const double AX, const double AY, const double ALeft, const double ARight, const double ATop, const double ABottom, const System::UnicodeString AXLabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff));
	__property TErrors* Errors = {read=FErrors, write=SetErrors};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


class PASCALIMPLEMENTATION TErrorPointSeries : public TCustomErrorPointSeries
{
	typedef TCustomErrorPointSeries inherited;
	
__published:
	__property Errors;
public:
	/* TCustomErrorPointSeries.Create */ inline __fastcall virtual TErrorPointSeries(System::Classes::TComponent* AOwner) : TCustomErrorPointSeries(AOwner) { }
	/* TCustomErrorPointSeries.Destroy */ inline __fastcall virtual ~TErrorPointSeries() { }
	
};


class PASCALIMPLEMENTATION TCustomErrorPoint3DSeries : public Fmxtee::Series::Point3d::TPoint3DSeries
{
	typedef Fmxtee::Series::Point3d::TPoint3DSeries inherited;
	
private:
	TErrors3D* FErrors;
	void __fastcall SetErrors(TErrors3D* const Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory);
	virtual void __fastcall CalcHorizMargins(int &LeftMargin, int &RightMargin);
	virtual void __fastcall CalcVerticalMargins(int &TopMargin, int &BottomMargin);
	void __fastcall CalcErrorSize(/* out */ int &Horiz, /* out */ int &Vert);
	virtual void __fastcall DrawValue(int ValueIndex);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TCustomErrorPoint3DSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomErrorPoint3DSeries();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	HIDESBASE int __fastcall Add(const double AX, const double AY, const double AZ, const double ALeft, const double ARight, const double ATop, const double ABottom, const double AFront, const double ABack, const System::UnicodeString AXLabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff));
	__property TErrors3D* Errors = {read=FErrors, write=SetErrors};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


class PASCALIMPLEMENTATION TErrorPoint3DSeries : public TCustomErrorPoint3DSeries
{
	typedef TCustomErrorPoint3DSeries inherited;
	
__published:
	__property Errors;
public:
	/* TCustomErrorPoint3DSeries.Create */ inline __fastcall virtual TErrorPoint3DSeries(System::Classes::TComponent* AOwner) : TCustomErrorPoint3DSeries(AOwner) { }
	/* TCustomErrorPoint3DSeries.Destroy */ inline __fastcall virtual ~TErrorPoint3DSeries() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Errorpoint */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_ERRORPOINT)
using namespace Fmxtee::Series::Errorpoint;
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
#endif	// Fmxtee_Series_ErrorpointHPP
