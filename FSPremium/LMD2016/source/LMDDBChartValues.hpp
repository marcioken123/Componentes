// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBChartValues.pas' rev: 31.00 (Windows)

#ifndef LmddbchartvaluesHPP
#define LmddbchartvaluesHPP

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
#include <Data.DB.hpp>
#include <System.Types.hpp>
#include <System.Variants.hpp>
#include <System.Math.hpp>
#include <LMDChartValuesBase.hpp>
#include <LMDChartPersistent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbchartvalues
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBChartValues;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBChartValues : public Lmdchartvaluesbase::TLMDChartValuesBase
{
	typedef Lmdchartvaluesbase::TLMDChartValuesBase inherited;
	
private:
	Data::Db::TDataSet* FDataSet;
	System::UnicodeString FFieldName;
	Lmdchartvaluesbase::TLMDChartValueType FIndicativeValueType;
	void __fastcall SetDataSet(Data::Db::TDataSet* const Value);
	
protected:
	virtual System::Variant __fastcall GetValues(int Index);
	virtual void __fastcall SetValues(int Index, const System::Variant &Value);
	virtual int __fastcall GetCount(void);
	virtual void __fastcall SetCount(const int Value);
	virtual Lmdchartvaluesbase::TLMDChartValueType __fastcall GetValueType(void);
	virtual void __fastcall SetValueType(const Lmdchartvaluesbase::TLMDChartValueType Value);
	
public:
	__fastcall virtual TLMDDBChartValues(System::Classes::TPersistent* AOwner);
	
__published:
	__property Data::Db::TDataSet* DataSet = {read=FDataSet, write=SetDataSet};
	__property System::UnicodeString FieldName = {read=FFieldName, write=FFieldName};
public:
	/* TLMDChartValuesBase.Destroy */ inline __fastcall virtual ~TLMDDBChartValues(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbchartvalues */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBCHARTVALUES)
using namespace Lmddbchartvalues;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbchartvaluesHPP
