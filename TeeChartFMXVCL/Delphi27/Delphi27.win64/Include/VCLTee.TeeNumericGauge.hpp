// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeNumericGauge.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeenumericgaugeHPP
#define Vcltee_TeenumericgaugeHPP

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
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <System.StrUtils.hpp>
#include <System.UIConsts.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeAnimate.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teenumericgauge
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TNumericShape;
class DELPHICLASS TNumericMarker;
class DELPHICLASS TNumericMarkers;
class DELPHICLASS TCustomGauge;
class DELPHICLASS TNumericGauge;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TNumericShape : public Vcltee::Chart::TTextShape
{
	typedef Vcltee::Chart::TTextShape inherited;
	
private:
	int __fastcall CalcWidth(Vcltee::Teeprocs::TCustomTeePanel* const Panel, const System::UnicodeString AText);
	bool __fastcall IsElektra();
	bool __fastcall IsDigital();
	void __fastcall CalcVariables(Vcltee::Tecanvas::TTeeCanvas* const ACanvas, /* out */ int &AWidth, /* out */ int &AHeight, /* out */ int &AComma, /* out */ int &AQuote);
	
protected:
	virtual void __fastcall CalcTextAlign(Vcltee::Teeprocs::TCustomTeePanel* const Panel, /* out */ int &X, const System::Types::TRect &R, System::UnicodeString AText);
	virtual System::Types::TPoint __fastcall CalcTextSize(Vcltee::Teeprocs::TCustomTeePanel* const Panel, System::UnicodeString S, const Vcltee::Teeprocs::TTextFormat TextFormat, /* out */ int &NumLines);
	virtual void __fastcall DrawString(Vcltee::Teeprocs::TCustomTeePanel* const Panel, const int X, const int Y, const int Z, const System::UnicodeString Text, bool AllowHTML, int AAngle, const System::Types::TPoint &RotationCenter);
public:
	/* TCustomTextShape.Create */ inline __fastcall virtual TNumericShape(Vcltee::Teeprocs::TCustomTeePanel* const AOwner)/* overload */ : Vcltee::Chart::TTextShape(AOwner) { }
	/* TCustomTextShape.Destroy */ inline __fastcall virtual ~TNumericShape() { }
	
};


class PASCALIMPLEMENTATION TNumericMarker : public Vcltee::Teetools::TAnnotationTool
{
	typedef Vcltee::Teetools::TAnnotationTool inherited;
	
protected:
	TNumericGauge* FGauge;
	virtual Vcltee::Chart::TTextShape* __fastcall CreateShape();
	virtual void __fastcall SetActive(bool Value);
	
public:
	__fastcall virtual ~TNumericMarker();
	__property TNumericGauge* Gauge = {read=FGauge};
public:
	/* TAnnotationTool.Create */ inline __fastcall virtual TNumericMarker(System::Classes::TComponent* AOwner) : Vcltee::Teetools::TAnnotationTool(AOwner) { }
	
};


class PASCALIMPLEMENTATION TNumericMarkers : public Vcltee::Teengine::TChartTools
{
	typedef Vcltee::Teengine::TChartTools inherited;
	
public:
	TNumericMarker* operator[](int Index) { return this->Items[Index]; }
	
private:
	TNumericGauge* FGauge;
	TNumericMarker* __fastcall Get(int Index);
	void __fastcall Put(int Index, TNumericMarker* const Value);
	void __fastcall SetParentChart(Vcltee::Teeprocs::TCustomTeePanel* const Value);
	
public:
	HIDESBASE TNumericMarker* __fastcall Add(const System::UnicodeString AText)/* overload */;
	HIDESBASE TNumericMarker* __fastcall Add(const System::UnicodeString AText, int FontSize, Vcltee::Teetools::TAnnotationPosition APosition, System::Classes::TAlignment AAlignment, int FontColor, int ShapeColor)/* overload */;
	void __fastcall Assign(TNumericMarkers* Source)/* overload */;
	__property TNumericGauge* Gauge = {read=FGauge};
	__property TNumericMarker* Items[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* {System_Generics_Collections}TList<VCLTee_TeEngine_TTeeCustomTool>.Create */ inline __fastcall TNumericMarkers()/* overload */ : Vcltee::Teengine::TChartTools() { }
	/* {System_Generics_Collections}TList<VCLTee_TeEngine_TTeeCustomTool>.Create */ inline __fastcall TNumericMarkers(const System::DelphiInterface<System::Generics::Defaults::IComparer__1<Vcltee::Teengine::TTeeCustomTool*> > AComparer)/* overload */ : Vcltee::Teengine::TChartTools(AComparer) { }
	/* {System_Generics_Collections}TList<VCLTee_TeEngine_TTeeCustomTool>.Create */ inline __fastcall TNumericMarkers(System::Generics::Collections::TEnumerable__1<Vcltee::Teengine::TTeeCustomTool*>* const Collection)/* overload */ : Vcltee::Teengine::TChartTools(Collection) { }
	/* {System_Generics_Collections}TList<VCLTee_TeEngine_TTeeCustomTool>.Destroy */ inline __fastcall virtual ~TNumericMarkers() { }
	
	/* Hoisted overloads: */
	
public:
	inline Vcltee::Teengine::TTeeCustomTool* __fastcall  Add(Vcltee::Teengine::TTeeCustomTool* const Tool){ return Vcltee::Teengine::TChartTools::Add(Tool); }
	inline Vcltee::Teengine::TTeeCustomTool* __fastcall  Add(Vcltee::Teengine::TTeeCustomToolClass Tool){ return Vcltee::Teengine::TChartTools::Add(Tool); }
	
};


class PASCALIMPLEMENTATION TCustomGauge : public Vcltee::Teengine::TChartSeries
{
	typedef Vcltee::Teengine::TChartSeries inherited;
	
private:
	Vcltee::Teeprocs::TTeeShape* FFace;
	Vcltee::Series::TFramedBorder* FFrame;
	System::Classes::TNotifyEvent FOnChange;
	System::Types::TRect FCustomBounds;
	Vcltee::Series::TFramedBorder* __fastcall GetFrame();
	double __fastcall GetValue();
	void __fastcall SetFace(Vcltee::Teeprocs::TTeeShape* const Value);
	void __fastcall SetFrame(Vcltee::Series::TFramedBorder* const Value);
	
protected:
	Vcltee::Teeanimate::TNumberAnimation* IAnimation;
	bool ICircled;
	System::Types::TRect INewRect;
	System::Types::TRect IOrigRect;
	bool IGalleryStatic;
	virtual void __fastcall CalcOrigRect();
	virtual Vcltee::Series::TFramedBorder* __fastcall CreateFrame();
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawFace();
	DYNAMIC void __fastcall GalleryChanged3D(bool Is3D);
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall SetGaugePalette(const System::Uitypes::TColor *Palette, const int Palette_High);
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetValue(const double AValue);
	virtual void __fastcall SetValues();
	
public:
	Vcltee::Teeprocs::TColorArray GaugeColorPalette;
	__fastcall virtual TCustomGauge(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomGauge();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod Vcltee::Teeanimate::TNumberAnimation* __fastcall CreateAnimation(System::Classes::TComponent* const AOwner, const double StartValue, const double EndValue, int Duration);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	System::Uitypes::TColor __fastcall GetPaletteColor(int Index);
	__property System::Types::TRect CustomBounds = {read=FCustomBounds, write=FCustomBounds};
	__property Vcltee::Teeprocs::TTeeShape* Face = {read=FFace, write=SetFace};
	__property Vcltee::Series::TFramedBorder* Frame = {read=GetFrame, write=SetFrame};
	__property double Value = {read=GetValue, write=SetValue};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
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
	__classmethod virtual void __fastcall CreateSubGallery(Vcltee::Teengine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DrawAllValues();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall PrepareForGallery();
	void __fastcall ReadMarkers(System::Classes::TStream* Stream);
	virtual void __fastcall SetGaugePalette(const System::Uitypes::TColor *Palette, const int Palette_High);
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	__classmethod virtual void __fastcall SetSubGallery(Vcltee::Teengine::TChartSeries* ASeries, int Index);
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
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
#define TeeGauge_DefaultValueFormat L"#,##0.00#"
extern DELPHI_PACKAGE System::StaticArray<System::Uitypes::TColor, 24> LCDPalette;
extern DELPHI_PACKAGE System::StaticArray<System::Uitypes::TColor, 24> LEDPalette;
}	/* namespace Teenumericgauge */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEENUMERICGAUGE)
using namespace Vcltee::Teenumericgauge;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeenumericgaugeHPP
