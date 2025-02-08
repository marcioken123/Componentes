// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartValues.pas' rev: 31.00 (Windows)

#ifndef LmdchartvaluesHPP
#define LmdchartvaluesHPP

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
#include <LMDChartValuesBase.hpp>
#include <LMDChartPersistent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartvalues
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartValues;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDChartValues : public Lmdchartvaluesbase::TLMDChartValuesBase
{
	typedef Lmdchartvaluesbase::TLMDChartValuesBase inherited;
	
	
private:
	typedef System::DynamicArray<System::Variant> _TLMDChartValues__1;
	
	
private:
	_TLMDChartValues__1 FValues;
	Lmdchartvaluesbase::TLMDChartValueType FValueType;
	void __fastcall LoadValues(System::Classes::TReader* Reader);
	void __fastcall StoreValues(System::Classes::TWriter* Writer);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual Lmdchartvaluesbase::TLMDChartValueType __fastcall GetValueType(void);
	virtual void __fastcall SetValueType(const Lmdchartvaluesbase::TLMDChartValueType Value);
	virtual System::Variant __fastcall GetValues(int Index);
	virtual void __fastcall SetValues(int Index, const System::Variant &Value);
	virtual int __fastcall GetCount(void);
	virtual void __fastcall SetCount(const int Value);
public:
	/* TLMDChartValuesBase.Create */ inline __fastcall virtual TLMDChartValues(System::Classes::TPersistent* Owner) : Lmdchartvaluesbase::TLMDChartValuesBase(Owner) { }
	/* TLMDChartValuesBase.Destroy */ inline __fastcall virtual ~TLMDChartValues(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartvalues */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTVALUES)
using namespace Lmdchartvalues;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartvaluesHPP
