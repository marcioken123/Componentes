// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Gauges.Numeric.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Gauges_NumericHPP
#define Fmxtee_Gauges_NumericHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <System.StrUtils.hpp>
#include <System.UIConsts.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Tools.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Animate.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Gauges
{
namespace Numeric
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TNumericShape;
class DELPHICLASS TNumericMarker;
class DELPHICLASS TNumericMarkers;
class DELPHICLASS TCustomGauge;
class DELPHICLASS TNumericGauge;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TNumericShape : public Fmxtee::Chart::TTextShape
{
	typedef Fmxtee::Chart::TTextShape inherited;
	
private:
	int __fastcall CalcWidth(Fmxtee::Procs::TCustomTeePanel* const Panel, const System::UnicodeString AText);
	bool __fastcall IsElektra();
	bool __fastcall IsDigital();
	void __fastcall CalcVariables(Fmxtee::Canvas::TTeeCanvas* const ACanvas, /* out */ int &AWidth, /* out */ int &AHeight, /* out */ int &AComma, /* out */ int &AQuote);
	
protected:
	virtual void __fastcall CalcTextAlign(Fmxtee::Procs::TCustomTeePanel* const Panel, /* out */ float &X, const System::Types::TRectF &R, System::UnicodeString AText);
	virtual System::Types::TPointF __fastcall CalcTextSize(Fmxtee::Procs::TCustomTeePanel* const Panel, System::UnicodeString S, const Fmxtee::Procs::TTextFormat TextFormat, /* out */ int &NumLines);
	virtual void __fastcall DrawString(Fmxtee::Procs::TCustomTeePanel* const Panel, const float X, const int Y, const int Z, const System::UnicodeString Text, bool AllowHTML, int AAngle, const System::Types::TPointF &RotationCenter);
public:
	/* TCustomTextShape.Create */ inline __fastcall virtual TNumericShape(Fmxtee::Procs::TCustomTeePanel* const AOwner)/* overload */ : Fmxtee::Chart::TTextShape(AOwner) { }
	/* TCustomTextShape.Destroy */ inline __fastcall virtual ~TNumericShape() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TNumericMarker : public Fmxtee::Tools::TAnnotationTool
{
	typedef Fmxtee::Tools::TAnnotationTool inherited;
	
protected:
	TNumericGauge* FGauge;
	virtual Fmxtee::Chart::TTextShape* __fastcall CreateShape();
	virtual void __fastcall SetActive(bool Value);
	
public:
	__fastcall virtual ~TNumericMarker();
	__property TNumericGauge* Gauge = {read=FGauge};
public:
	/* TAnnotationTool.Create */ inline __fastcall virtual TNumericMarker(System::Classes::TComponent* AOwner) : Fmxtee::Tools::TAnnotationTool(AOwner) { }
	
};


class PASCALIMPLEMENTATION TNumericMarkers : public Fmxtee::Engine::TChartTools
{
	typedef Fmxtee::Engine::TChartTools inherited;
	
public:
	TNumericMarker* operator[](int Index) { return this->Items[Index]; }
	
private:
	TNumericGauge* FGauge;
	TNumericMarker* __fastcall Get(int Index);
	void __fastcall Put(int Index, TNumericMarker* const Value);
	void __fastcall SetParentChart(Fmxtee::Procs::TCustomTeePanel* const Value);
	
public:
	HIDESBASE TNumericMarker* __fastcall Add(const System::UnicodeString AText)/* overload */;
	HIDESBASE TNumericMarker* __fastcall Add(const System::UnicodeString AText, int FontSize, Fmxtee::Tools::TAnnotationPosition APosition, System::Classes::TAlignment AAlignment, int FontColor, int ShapeColor)/* overload */;
	void __fastcall Assign(TNumericMarkers* Source)/* overload */;
	__property TNumericGauge* Gauge = {read=FGauge};
	__property TNumericMarker* Items[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* {System_Generics_Collections}TList<FMXTee_Engine_TTeeCustomTool>.Create */ inline __fastcall TNumericMarkers()/* overload */ : Fmxtee::Engine::TChartTools() { }
	/* {System_Generics_Collections}TList<FMXTee_Engine_TTeeCustomTool>.Create */ inline __fastcall TNumericMarkers(const System::DelphiInterface<System::Generics::Defaults::IComparer__1<Fmxtee::Engine::TTeeCustomTool*> > AComparer)/* overload */ : Fmxtee::Engine::TChartTools(AComparer) { }
	/* {System_Generics_Collections}TList<FMXTee_Engine_TTeeCustomTool>.Create */ inline __fastcall TNumericMarkers(System::Generics::Collections::TEnumerable__1<Fmxtee::Engine::TTeeCustomTool*>* const Collection)/* overload */ : Fmxtee::Engine::TChartTools(Collection) { }
	/* {System_Generics_Collections}TList<FMXTee_Engine_TTeeCustomTool>.Destroy */ inline __fastcall virtual ~TNumericMarkers() { }
	
	/* Hoisted overloads: */
	
public:
	inline Fmxtee::Engine::TTeeCustomTool* __fastcall  Add(Fmxtee::Engine::TTeeCustomTool* const Tool){ return Fmxtee::Engine::TChartTools::Add(Tool); }
	inline Fmxtee::Engine::TTeeCustomTool* __fastcall  Add(Fmxtee::Engine::TTeeCustomToolClass Tool){ return Fmxtee::Engine::TChartTools::Add(Tool); }
	
};


class PASCALIMPLEMENTATION TCustomGauge : public Fmxtee::Engine::TChartSeries
{
	typedef Fmxtee::Engine::TChartSeries inherited;
	
private:
	Fmxtee::Procs::TTeeShape* FFace;
	Fmxtee::Series::TFramedBorder* FFrame;
	System::Classes::TNotifyEvent FOnChange;
	System::Types::TRectF FCustomBounds;
	Fmxtee::Series::TFramedBorder* __fastcall GetFrame();
	double __fastcall GetValue();
	void __fastcall SetFace(Fmxtee::Procs::TTeeShape* const Value);
	void __fastcall SetFrame(Fmxtee::Series::TFramedBorder* const Value);
	
protected:
	Fmxtee::Animate::TNumberAnimation* IAnimation;
	bool ICircled;
	System::Types::TRectF INewRect;
	System::Types::TRectF IOrigRect;
	bool IGalleryStatic;
	virtual void __fastcall CalcOrigRect();
	virtual Fmxtee::Series::TFramedBorder* __fastcall CreateFrame();
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawFace();
	DYNAMIC void __fastcall GalleryChanged3D(bool Is3D);
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall SetGaugePalette(const System::Uitypes::TAlphaColor *Palette, const int Palette_High);
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetValue(const double AValue);
	virtual void __fastcall SetValues();
	
public:
	Fmxtee::Procs::TColorArray GaugeColorPalette;
	__fastcall virtual TCustomGauge(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomGauge();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod Fmxtee::Animate::TNumberAnimation* __fastcall CreateAnimation(System::Classes::TComponent* const AOwner, const double StartValue, const double EndValue, int Duration);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	System::Uitypes::TAlphaColor __fastcall GetPaletteColor(int Index);
	__property System::Types::TRectF CustomBounds = {read=FCustomBounds, write=FCustomBounds};
	__property Fmxtee::Procs::TTeeShape* Face = {read=FFace, write=SetFace};
	__property Fmxtee::Series::TFramedBorder* Frame = {read=GetFrame, write=SetFrame};
	__property double Value = {read=GetValue, write=SetValue};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


enum DECLSPEC_DENUM TDigitalFont : unsigned char { dfBar, dfDot, dfCustom };

class PASCALIMPLEMENTATION TNumericGauge : public TCustomGauge
{
	typedef TCustomGauge inherited;
	
private:
	TDigitalFont FFont;
	TNumericMarkers* FMarkers;
	void __fastcall ChangeValueMarker();
	TNumericMarker* __fastcall GetTextMarker();
	TNumericMarker* __fastcall GetUnitsMarker();
	TNumericMarker* __fastcall GetValueMarker();
	HIDESBASE bool __fastcall IsValueFormatStored();
	void __fastcall SetFont(const TDigitalFont Value);
	void __fastcall SetMarkers(TNumericMarkers* const Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool Sequential = false);
	__classmethod virtual void __fastcall CreateSubGallery(Fmxtee::Engine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DrawAllValues();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall PrepareForGallery();
	void __fastcall ReadMarkers(System::Classes::TStream* Stream);
	virtual void __fastcall SetGaugePalette(const System::Uitypes::TAlphaColor *Palette, const int Palette_High);
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	__classmethod virtual void __fastcall SetSubGallery(Fmxtee::Engine::TChartSeries* ASeries, int Index);
	virtual void __fastcall SetValue(const double Value);
	virtual void __fastcall SetValueFormat(const System::UnicodeString Value);
	void __fastcall WriteMarkers(System::Classes::TStream* Stream);
	
public:
	__fastcall virtual TNumericGauge(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TNumericGauge();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	DYNAMIC int __fastcall NumSampleValues();
	virtual bool __fastcall UseAxis();
	__property bool Embedded = {read=IInternalUse, write=IInternalUse, nodefault};
	__property TNumericMarkers* Markers = {read=FMarkers, write=SetMarkers};
	__property TNumericMarker* TextMarker = {read=GetTextMarker};
	__property TNumericMarker* UnitsMarker = {read=GetUnitsMarker};
	__property TNumericMarker* ValueMarker = {read=GetValueMarker};
	
__published:
	__property Active = {default=1};
	__property Cursor = {default=0};
	__property ParentChart;
	__property DataSource;
	__property PercentFormat = {default=0};
	__property ShowInLegend = {default=1};
	__property Title = {default=0};
	__property ValueFormat = {stored=IsValueFormatStored, default=0};
	__property AfterDrawValues;
	__property BeforeDrawValues;
	__property OnAfterAdd;
	__property OnBeforeAdd;
	__property OnChange;
	__property OnClearValues;
	__property OnClick;
	__property OnDblClick;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property XLabelsSource = {default=0};
	__property XValues;
	__property YValues;
	__property TDigitalFont DigitalFont = {read=FFont, write=SetFont, default=0};
	__property Face;
	__property Frame;
	__property Value = {default=0};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
#define TeeGauge_DefaultValueFormat u"#,##0.00#"
extern DELPHI_PACKAGE System::StaticArray<System::Uitypes::TAlphaColor, 24> LCDPalette;
extern DELPHI_PACKAGE System::StaticArray<System::Uitypes::TAlphaColor, 24> LEDPalette;
}	/* namespace Numeric */
}	/* namespace Gauges */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_GAUGES_NUMERIC)
using namespace Fmxtee::Gauges::Numeric;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_GAUGES)
using namespace Fmxtee::Gauges;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Gauges_NumericHPP
