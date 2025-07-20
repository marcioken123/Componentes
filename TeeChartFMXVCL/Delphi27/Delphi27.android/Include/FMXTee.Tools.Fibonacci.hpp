// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.Fibonacci.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Tools_FibonacciHPP
#define Fmxtee_Tools_FibonacciHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <System.UIConsts.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Fibonacci
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
	Fmxtee::Canvas::TTeePen* FPen;
	double FValue;
	TFibonacciTool* ITool;
	void __fastcall SetPen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetValue(const double Value);
	
public:
	__fastcall virtual TFibonacciItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TFibonacciItem();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Fmxtee::Canvas::TTeePen* Pen = {read=FPen, write=SetPen};
	__property double Value = {read=FValue, write=SetValue};
};


#pragma pack(push,4)
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

#pragma pack(pop)

class PASCALIMPLEMENTATION TFibonacciTool : public Fmxtee::Engine::TTeeCustomToolSeries
{
	typedef Fmxtee::Engine::TTeeCustomToolSeries inherited;
	
private:
	TFibonacciStyle FDrawStyle;
	double FEndX;
	double FEndY;
	int FLabelsAngle;
	Fmxtee::Canvas::TTeeFont* FLabelFont;
	TFibonacciLevels* FLevels;
	bool FShowLabels;
	double FStartX;
	double FStartY;
	Fmxtee::Canvas::TTeePen* FTrendPen;
	Fmxtee::Canvas::TDoubleArray IDefaultFab;
	System::Types::TPointF ISp;
	void __fastcall ClipDrawingRegion();
	void __fastcall SetDrawStyle(const TFibonacciStyle Value);
	void __fastcall SetEndX(const double Value);
	void __fastcall SetEndY(const double Value);
	void __fastcall SetLabelsAngle(const int Value);
	void __fastcall SetLabelsFont(Fmxtee::Canvas::TTeeFont* const Value);
	void __fastcall SetShowLabels(const bool Value);
	void __fastcall SetStartX(const double Value);
	void __fastcall SetStartY(const double Value);
	void __fastcall SetTrendPen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetLevels(TFibonacciLevels* const Value);
	
protected:
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	void __fastcall DrawLevel(int Index);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TFibonacciTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TFibonacciTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	System::Types::TPointF __fastcall AxisPoint(const double X, const double Y);
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
	__property Fmxtee::Canvas::TTeeFont* LabelsFont = {read=FLabelFont, write=SetLabelsFont};
	__property TFibonacciLevels* Levels = {read=FLevels, write=SetLevels};
	__property Pen;
	__property Series;
	__property bool ShowLabels = {read=FShowLabels, write=SetShowLabels, default=1};
	__property double StartX = {read=FStartX, write=SetStartX};
	__property double StartY = {read=FStartY, write=SetStartY};
	__property Fmxtee::Canvas::TTeePen* TrendPen = {read=FTrendPen, write=SetTrendPen};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Fibonacci */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_FIBONACCI)
using namespace Fmxtee::Tools::Fibonacci;
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
#endif	// Fmxtee_Tools_FibonacciHPP
