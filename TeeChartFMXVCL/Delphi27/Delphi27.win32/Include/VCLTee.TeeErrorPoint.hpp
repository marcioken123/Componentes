// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeErrorPoint.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeerrorpointHPP
#define Vcltee_TeeerrorpointHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeePoin3.hpp>
#include <VCLTee.ErrorBar.hpp>
#include <VCLTee.TeeConst.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeSurfa.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeerrorpoint
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
	Vcltee::Tecanvas::TTeePen* FLeft;
	Vcltee::Tecanvas::TTeePen* FRight;
	Vcltee::Tecanvas::TTeePen* FTop;
	Vcltee::Tecanvas::TTeePen* FBottom;
	void __fastcall SetLeft(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetRight(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetTop(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetBottom(Vcltee::Tecanvas::TTeePen* const Value);
	
public:
	__fastcall TErrorsFormat(Vcltee::Teengine::TChartSeries* AOwner);
	__fastcall virtual ~TErrorsFormat();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcltee::Tecanvas::TTeePen* Left = {read=FLeft, write=SetLeft};
	__property Vcltee::Tecanvas::TTeePen* Right = {read=FRight, write=SetRight};
	__property Vcltee::Tecanvas::TTeePen* Top = {read=FTop, write=SetTop};
	__property Vcltee::Tecanvas::TTeePen* Bottom = {read=FBottom, write=SetBottom};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TErrors3DFormat : public TErrorsFormat
{
	typedef TErrorsFormat inherited;
	
private:
	Vcltee::Tecanvas::TTeePen* FFront;
	Vcltee::Tecanvas::TTeePen* FBack;
	void __fastcall SetFront(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetBack(Vcltee::Tecanvas::TTeePen* const Value);
	
public:
	__fastcall TErrors3DFormat(Vcltee::Teengine::TChartSeries* AOwner);
	__fastcall virtual ~TErrors3DFormat();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcltee::Tecanvas::TTeePen* Front = {read=FFront, write=SetFront};
	__property Vcltee::Tecanvas::TTeePen* Back = {read=FBack, write=SetBack};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TErrorsBase : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Vcltee::Teengine::TChartValueList* FLeft;
	Vcltee::Teengine::TChartValueList* FRight;
	Vcltee::Teengine::TChartValueList* FTop;
	Vcltee::Teengine::TChartValueList* FBottom;
	bool FSeriesColor;
	int FSize;
	Vcltee::Errorbar::TErrorWidthUnits FSizeUnits;
	Vcltee::Teengine::TChartSeries* ISeries;
	void __fastcall PreparePen(int ValueIndex, Vcltee::Tecanvas::TTeePen* const APen);
	void __fastcall SetLeft(Vcltee::Teengine::TChartValueList* const Value);
	void __fastcall SetRight(Vcltee::Teengine::TChartValueList* const Value);
	void __fastcall SetTop(Vcltee::Teengine::TChartValueList* const Value);
	void __fastcall SetBottom(Vcltee::Teengine::TChartValueList* const Value);
	void __fastcall SetSize(int Value);
	void __fastcall SetSizeUnits(const Vcltee::Errorbar::TErrorWidthUnits Value);
	void __fastcall SetSeriesColor(const bool Value);
	
protected:
	void __fastcall AddSample(int Index, const double X, const double Y);
	void __fastcall DrawError(int X, int Y, int ALength, int HalfSize, int AZ, bool IsHoriz);
	void __fastcall CalcMinMaxIndex(/* out */ int &MinIndex, /* out */ int &MaxIndex, bool Horizontal);
	
public:
	__fastcall virtual TErrorsBase(Vcltee::Teengine::TChartSeries* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcltee::Teengine::TChartValueList* Left = {read=FLeft, write=SetLeft};
	__property Vcltee::Teengine::TChartValueList* Right = {read=FRight, write=SetRight};
	__property Vcltee::Teengine::TChartValueList* Top = {read=FTop, write=SetTop};
	__property Vcltee::Teengine::TChartValueList* Bottom = {read=FBottom, write=SetBottom};
	__property bool SeriesColor = {read=FSeriesColor, write=SetSeriesColor, default=0};
	__property int Size = {read=FSize, write=SetSize, default=100};
	__property Vcltee::Errorbar::TErrorWidthUnits SizeUnits = {read=FSizeUnits, write=SetSizeUnits, default=0};
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
	__fastcall virtual TErrors(Vcltee::Teengine::TChartSeries* AOwner);
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
	Vcltee::Teengine::TChartValueList* FFront;
	Vcltee::Teengine::TChartValueList* FBack;
	void __fastcall SetFormat(TErrors3DFormat* const Value);
	void __fastcall SetFront(Vcltee::Teengine::TChartValueList* const Value);
	void __fastcall SetBack(Vcltee::Teengine::TChartValueList* const Value);
	
protected:
	HIDESBASE void __fastcall AddSample(int Index, const double X, const double Y);
	void __fastcall DrawZError(int X, int Y, int Z, int ALength, int HalfSize);
	
public:
	__fastcall virtual TErrors3D(Vcltee::Teengine::TChartSeries* AOwner);
	__fastcall virtual ~TErrors3D();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property TErrors3DFormat* Format = {read=FFormat, write=SetFormat};
	__property Vcltee::Teengine::TChartValueList* Front = {read=FFront, write=SetFront};
	__property Vcltee::Teengine::TChartValueList* Back = {read=FBack, write=SetBack};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TCustomErrorPointSeries : public Vcltee::Series::TPointSeries
{
	typedef Vcltee::Series::TPointSeries inherited;
	
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
	HIDESBASE int __fastcall Add(const double AX, const double AY, const double ALeft, const double ARight, const double ATop, const double ABottom, const System::UnicodeString AXLabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000));
	__property TErrors* Errors = {read=FErrors, write=SetErrors};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
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


class PASCALIMPLEMENTATION TCustomErrorPoint3DSeries : public Vcltee::Teepoin3::TPoint3DSeries
{
	typedef Vcltee::Teepoin3::TPoint3DSeries inherited;
	
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
	HIDESBASE int __fastcall Add(const double AX, const double AY, const double AZ, const double ALeft, const double ARight, const double ATop, const double ABottom, const double AFront, const double ABack, const System::UnicodeString AXLabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000));
	__property TErrors3D* Errors = {read=FErrors, write=SetErrors};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
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
}	/* namespace Teeerrorpoint */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEERRORPOINT)
using namespace Vcltee::Teeerrorpoint;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeerrorpointHPP
