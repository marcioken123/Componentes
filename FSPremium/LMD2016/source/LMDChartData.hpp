// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartData.pas' rev: 31.00 (Windows)

#ifndef LmdchartdataHPP
#define LmdchartdataHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.Types.hpp>
#include <System.Variants.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Math.hpp>
#include <LMDXML.hpp>
#include <LMDXMLNodeNames.hpp>
#include <LMDChartPersistent.hpp>
#include <LMDChartUtils.hpp>
#include <LMDChartLine.hpp>
#include <LMDChartBackground.hpp>
#include <LMDChartMarker.hpp>
#include <LMDChartSeries.hpp>
#include <LMDChartSeriesCollection.hpp>
#include <LMDChartSource.hpp>
#include <LMDChartValuesBase.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartdata
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartData;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TDataType : unsigned char { dtMoney, dtNumber };

enum DECLSPEC_DENUM TLMDSeriesOrientType : unsigned char { sotRow, sotCol };

typedef System::DynamicArray<System::Variant> Lmdchartdata__1;

typedef System::DynamicArray<System::DynamicArray<System::Variant> > TDynamicArray;

class PASCALIMPLEMENTATION TLMDChartData : public Lmdchartpersistent::TLMDChartPersistent
{
	typedef Lmdchartpersistent::TLMDChartPersistent inherited;
	
	
private:
	typedef System::DynamicArray<System::UnicodeString> _TLMDChartData__1;
	
	typedef System::DynamicArray<int> _TLMDChartData__2;
	
	typedef System::DynamicArray<Lmdchartline::TLMDChartLine*> _TLMDChartData__3;
	
	typedef System::DynamicArray<System::UnicodeString> _TLMDChartData__4;
	
	typedef System::DynamicArray<Lmdchartbackground::TLMDChartBackground*> _TLMDChartData__5;
	
	typedef System::DynamicArray<Lmdchartmarker::TLMDChartMarker*> _TLMDChartData__6;
	
	typedef System::DynamicArray<System::Uitypes::TColor> _TLMDChartData__7;
	
	
private:
	int __fastcall GetColCount(void);
	int __fastcall GetRowCount(void);
	void __fastcall ResizeInternalArrays(void);
	
protected:
	bool FChanged;
	System::TObject* AOwnerMy;
	_TLMDChartData__1 FColumnsNames;
	_TLMDChartData__2 FRowsWidth;
	_TLMDChartData__3 FRowsLines;
	_TLMDChartData__4 FRowsNames;
	_TLMDChartData__5 FRowsFill;
	_TLMDChartData__6 FRowsMarkers;
	_TLMDChartData__7 FColorScheme;
	System::Variant FHighestValue;
	System::Variant FLowestValue;
	TDataType FValuesType;
	System::UnicodeString FValTypeIndicator;
	bool FHighestForStacked;
	Lmdchartseriescollection::TLMDChartSeriesColl* FChartSeriesColl;
	void __fastcall SetValuesType(TDataType NewType);
	void __fastcall SetHighestForStacked(bool NewType);
	System::Variant __fastcall GetHighestValue(void);
	System::Variant __fastcall GetLowestValue(void);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* ASource);
	__fastcall TLMDChartData(System::Classes::TPersistent* AOwner, Lmdchartseriescollection::TLMDChartSeriesColl* ASeriesColl);
	__fastcall virtual ~TLMDChartData(void);
	void __fastcall SetSeriesColl(Lmdchartseriescollection::TLMDChartSeriesColl* ASeriesColl);
	virtual bool __fastcall IsChanged(void);
	virtual void __fastcall NoChanged(void);
	void __fastcall SetChanged(void);
	System::UnicodeString __fastcall GetColumnsNames(int AColumn);
	Lmdchartbackground::TLMDChartBackground* __fastcall GetRowFill(int ARow);
	Lmdchartmarker::TLMDChartMarker* __fastcall GetRowMarker(int ARow);
	Lmdchartline::TLMDChartLine* __fastcall GetRowsLines(int APosition);
	System::UnicodeString __fastcall GetRowsNames(int ARow);
	double __fastcall GetTableValue(int AColumn, int ARow);
	void __fastcall SetColumnsNames(int AColumn, System::UnicodeString AValue)/* overload */;
	void __fastcall SetColumnsNames(int AColumn, System::TDateTime AValue, const System::Sysutils::TFormatSettings &FSet)/* overload */;
	void __fastcall SetColumnsNames(int AColumn, System::TDateTime AValue)/* overload */;
	void __fastcall SetColumnsNames(int AColumn, System::Currency AValue, const System::Sysutils::TFormatSettings &FSet)/* overload */;
	void __fastcall SetColumnsNames(int AColumn, System::Currency AValue)/* overload */;
	void __fastcall SetColumnsNames(int AColumn, double AValue)/* overload */;
	void __fastcall SetRowsLines(int APosition, Lmdchartline::TLMDChartLine* Value);
	void __fastcall SetRowsNames(int ARow, System::UnicodeString AValue)/* overload */;
	void __fastcall SetRowsNames(int ARow, System::TDateTime AValue, const System::Sysutils::TFormatSettings &FSet)/* overload */;
	void __fastcall SetRowsNames(int ARow, System::TDateTime AValue)/* overload */;
	void __fastcall SetRowsNames(int ARow, System::Currency AValue, const System::Sysutils::TFormatSettings &FSet)/* overload */;
	void __fastcall SetRowsNames(int ARow, System::Currency AValue)/* overload */;
	void __fastcall SetRowsNames(int ARow, double AValue)/* overload */;
	void __fastcall SetRowWidth(int ARow, int ASize);
	void __fastcall SetTableSize(int AColumn, int ARow);
	void __fastcall SetTableValue(double AValue, int AColumn, int ARow);
	void __fastcall SetColorScheme(const System::Uitypes::TColor *AColors, const int AColors_High);
	void __fastcall SaveStateToXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	void __fastcall LoadStateFromXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	void __fastcall InvertedRecalculate(void);
	void __fastcall Get3ParametersPointArr(TLMDSeriesOrientType AOrient, TDynamicArray &Arr);
	void __fastcall SetEmptyValue(int ACol, int ARow);
	void __fastcall Refresh(void);
	
__published:
	__property System::Variant HighestValue = {read=GetHighestValue};
	__property System::Variant LowestValue = {read=GetLowestValue};
	__property TDataType ValuesType = {read=FValuesType, write=SetValuesType, nodefault};
	__property int RowCount = {read=GetRowCount, default=3};
	__property int ColCount = {read=GetColCount, default=3};
	__property System::UnicodeString ValIndicator = {read=FValTypeIndicator};
	__property bool HighestForStacked = {read=FHighestForStacked, write=SetHighestForStacked, default=0};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE int EmptyID;
extern DELPHI_PACKAGE System::StaticArray<System::Uitypes::TColor, 18> LMDDefaultColorTemplate;
}	/* namespace Lmdchartdata */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTDATA)
using namespace Lmdchartdata;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartdataHPP
