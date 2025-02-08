// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartValuesBase.pas' rev: 31.00 (Windows)

#ifndef LmdchartvaluesbaseHPP
#define LmdchartvaluesbaseHPP

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
#include <System.Types.hpp>
#include <System.Variants.hpp>
#include <System.Math.hpp>
#include <LMDChartPersistent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartvaluesbase
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartValuesBase;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDChartValueType : unsigned char { cvtNumber, cvtMoney, cvtDate, cvtLabel, cvtUnknown };

class PASCALIMPLEMENTATION TLMDChartValuesBase : public Lmdchartpersistent::TLMDChartPersistent
{
	typedef Lmdchartpersistent::TLMDChartPersistent inherited;
	
private:
	System::UnicodeString FName;
	System::Variant FLowestValue;
	System::Variant FHighestValue;
	System::UnicodeString FCaption;
	System::Classes::TList* FParentCharts;
	void __fastcall SetName(System::UnicodeString val);
	System::UnicodeString __fastcall GetName(void);
	
protected:
	virtual System::Variant __fastcall GetValues(int Index);
	virtual void __fastcall SetValues(int Index, const System::Variant &Value);
	virtual int __fastcall GetCount(void) = 0 ;
	virtual void __fastcall SetCount(const int Value);
	virtual TLMDChartValueType __fastcall GetValueType(void) = 0 ;
	virtual void __fastcall SetValueType(const TLMDChartValueType Value);
	__property System::Variant LowestValue = {read=FLowestValue};
	__property System::Variant HighestValue = {read=FHighestValue};
	void __fastcall RefreshParentCharts(void);
	
public:
	__fastcall virtual TLMDChartValuesBase(System::Classes::TPersistent* Owner);
	__fastcall virtual ~TLMDChartValuesBase(void);
	__property System::Variant Values[int Index] = {read=GetValues, write=SetValues};
	void __fastcall AddParentChart(Vcl::Controls::TControl* AChart);
	void __fastcall RemoveParentChart(Vcl::Controls::TControl* AChart);
	
__published:
	__property System::UnicodeString Name = {read=GetName, write=SetName};
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property int Count = {read=GetCount, write=SetCount, nodefault};
	__property TLMDChartValueType ValueType = {read=GetValueType, write=SetValueType, nodefault};
};


typedef System::TMetaClass* TLMDChartValuesClass;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString __fastcall ChartValueTypeToStr(TLMDChartValueType AValType);
extern DELPHI_PACKAGE TLMDChartValueType __fastcall StrToChartValueType(System::UnicodeString AValType);
extern DELPHI_PACKAGE int __fastcall CompareTypedChartValues(const System::Variant &val1, const System::Variant &val2, TLMDChartValueType valType);
}	/* namespace Lmdchartvaluesbase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTVALUESBASE)
using namespace Lmdchartvaluesbase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartvaluesbaseHPP
