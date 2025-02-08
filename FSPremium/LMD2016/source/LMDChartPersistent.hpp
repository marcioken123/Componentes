// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartPersistent.pas' rev: 31.00 (Windows)

#ifndef LmdchartpersistentHPP
#define LmdchartpersistentHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDObject.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartpersistent
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartPersistent;
class DELPHICLASS TLMDChartSeriesCollectionAttribute;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDChartPersistent : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
protected:
	bool FChanged;
	System::Classes::TPersistent* FMainOwner;
	virtual void __fastcall HighestOwnerRepaint(void);
	
public:
	__fastcall virtual TLMDChartPersistent(System::Classes::TPersistent* AMainOwner);
	void __fastcall ResetOwner(System::Classes::TPersistent* AMainOwner);
	virtual bool __fastcall IsChanged(void);
	virtual void __fastcall NoChanged(void);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDChartPersistent(void) { }
	
};


class PASCALIMPLEMENTATION TLMDChartSeriesCollectionAttribute : public TLMDChartPersistent
{
	typedef TLMDChartPersistent inherited;
	
protected:
	virtual void __fastcall HighestOwnerRepaint(void);
public:
	/* TLMDChartPersistent.Create */ inline __fastcall virtual TLMDChartSeriesCollectionAttribute(System::Classes::TPersistent* AMainOwner) : TLMDChartPersistent(AMainOwner) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDChartSeriesCollectionAttribute(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartpersistent */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTPERSISTENT)
using namespace Lmdchartpersistent;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartpersistentHPP
