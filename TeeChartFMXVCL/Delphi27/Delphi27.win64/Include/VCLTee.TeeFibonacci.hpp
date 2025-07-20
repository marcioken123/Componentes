// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeFibonacci.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeefibonacciHPP
#define Vcltee_TeefibonacciHPP

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
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teefibonacci
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFibonacciItem;
class DELPHICLASS TFibonacciLevels;
class DELPHICLASS TFibonacciTool;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TFibonacciStyle : unsigned char { fsArc, fsFan, fsRetracement };

class PASCALIMPLEMENTATION TFibonacciItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Vcltee::Tecanvas::TTeePen* FPen;
	double FValue;
	TFibonacciTool* ITool;
	void __fastcall SetPen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetValue(const double Value);
	
public:
	__fastcall virtual TFibonacciItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TFibonacciItem();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcltee::Tecanvas::TTeePen* Pen = {read=FPen, write=SetPen};
	__property double Value = {read=FValue, write=SetValue};
};


class PASCALIMPLEMENTATION TFibonacciLevels : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TFibonacciItem* operator[](int Index) { return this->Level[Index]; }
	
private:
	TFibonacciTool* ITool;
	TFibonacciItem* __fastcall Get(int Index);
	void __fastcall Put(int Index, TFibonacciItem* const Value);
	
public:
	__property TFibonacciItem* Level[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TFibonacciLevels(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TFibonacciLevels() { }
	
};


class PASCALIMPLEMENTATION TFibonacciTool : public Vcltee::Teengine::TTeeCustomToolSeries
{
	typedef Vcltee::Teengine::TTeeCustomToolSeries inherited;
	
private:
	TFibonacciStyle FDrawStyle;
	double FEndX;
	double FEndY;
	int FLabelsAngle;
	Vcltee::Tecanvas::TTeeFont* FLabelFont;
	TFibonacciLevels* FLevels;
	bool FShowLabels;
	double FStartX;
	double FStartY;
	Vcltee::Tecanvas::TTeePen* FTrendPen;
	Vcltee::Tecanvas::TDoubleArray IDefaultFab;
	System::Types::TPoint ISp;
	void __fastcall ClipDrawingRegion();
	void __fastcall SetDrawStyle(const TFibonacciStyle Value);
	void __fastcall SetEndX(const double Value);
	void __fastcall SetEndY(const double Value);
	void __fastcall SetLabelsAngle(const int Value);
	void __fastcall SetLabelsFont(Vcltee::Tecanvas::TTeeFont* const Value);
	void __fastcall SetShowLabels(const bool Value);
	void __fastcall SetStartX(const double Value);
	void __fastcall SetStartY(const double Value);
	void __fastcall SetTrendPen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetLevels(TFibonacciLevels* const Value);
	
protected:
	virtual void __fastcall ChartEvent(Vcltee::Teengine::TChartToolEvent AEvent);
	void __fastcall DrawLevel(int Index);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TFibonacciTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TFibonacciTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	System::Types::TPoint __fastcall AxisPoint(const double X, const double Y);
	void __fastcall CreateDefaultLevels();
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	double __fastcall Radius();
	
__published:
	__property Active = {default=1};
	__property TFibonacciStyle DrawStyle = {read=FDrawStyle, write=SetDrawStyle, default=0};
	__property double EndX = {read=FEndX, write=SetEndX};
	__property double EndY = {read=FEndY, write=SetEndY};
	__property int LabelsAngle = {read=FLabelsAngle, write=SetLabelsAngle, default=90};
	__property Vcltee::Tecanvas::TTeeFont* LabelsFont = {read=FLabelFont, write=SetLabelsFont};
	__property TFibonacciLevels* Levels = {read=FLevels, write=SetLevels};
	__property Pen;
	__property Series;
	__property bool ShowLabels = {read=FShowLabels, write=SetShowLabels, default=1};
	__property double StartX = {read=FStartX, write=SetStartX};
	__property double StartY = {read=FStartY, write=SetStartY};
	__property Vcltee::Tecanvas::TTeePen* TrendPen = {read=FTrendPen, write=SetTrendPen};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teefibonacci */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEFIBONACCI)
using namespace Vcltee::Teefibonacci;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeefibonacciHPP
