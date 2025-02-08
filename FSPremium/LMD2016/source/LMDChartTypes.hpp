// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartTypes.pas' rev: 31.00 (Windows)

#ifndef LmdcharttypesHPP
#define LmdcharttypesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Math.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <LMDCustomComponent.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDXML.hpp>
#include <LMDXMLNodeNames.hpp>
#include <LMDChartData.hpp>
#include <LMDChartPersistent.hpp>
#include <LMDChartSeries.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcharttypes
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartCTAbstract;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDChartCTAbstract : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	Lmdchartseries::TLMDChartSeries* FSeries;
	void __fastcall SetSeries(Lmdchartseries::TLMDChartSeries* const Value);
	
protected:
	bool FChanged;
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	System::Classes::TPersistent* FMainOwner;
	Lmdchartpersistent::TLMDChartPersistent* FChartArea;
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	void __fastcall HighestOwnerRepaint(void);
	virtual void __fastcall ResetMainOwner(System::Classes::TPersistent* AmainOwner);
	virtual bool __fastcall IsChanged(void);
	virtual void __fastcall NoChanged(void);
	__fastcall virtual TLMDChartCTAbstract(System::Classes::TComponent* AOwner);
	virtual void __fastcall Draw(Vcl::Graphics::TBitmap* ABuffer, const System::Types::TRect &AArea, Lmdchartdata::TLMDChartData* AValues, Lmdchartpersistent::TLMDChartPersistent* AChartArea);
	void __fastcall RemoveFromChartArea(void);
	virtual void __fastcall SaveStateToXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	virtual void __fastcall LoadStateFromXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	__fastcall virtual ~TLMDChartCTAbstract(void);
	
__published:
	__property Lmdchartseries::TLMDChartSeries* Series = {read=FSeries, write=SetSeries};
	__property About = {default=0};
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcharttypes */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTTYPES)
using namespace Lmdcharttypes;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcharttypesHPP
