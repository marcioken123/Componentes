// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeToolsGalleryDemos.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeetoolsgallerydemosHPP
#define Vcltee_TeetoolsgallerydemosHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Grids.hpp>
#include <System.UITypes.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeToolsGallery.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teetoolsgallerydemos
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TToolDemosBase;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TToolDemosBase : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	void __fastcall ChartDblClick(System::TObject* Sender);
	
protected:
	Vcltee::Teetoolsgallery::TTeeToolsGallery* Gallery;
	Vcl::Buttons::TBitBtn* __fastcall AddBitButton(Vcltee::Chart::TCustomChart* const Chart, Vcltee::Teengine::TCustomChartElement* const Element, const System::UnicodeString AText, System::Classes::TNotifyEvent AEvent, System::TObject* const AObject);
	Vcl::Stdctrls::TButton* __fastcall AddButton(Vcltee::Chart::TCustomChart* const Chart, const System::UnicodeString AText, System::Classes::TNotifyEvent AEvent, System::TObject* const AObject);
	Vcl::Stdctrls::TCheckBox* __fastcall AddCheck(Vcltee::Chart::TCustomChart* const Chart, const System::UnicodeString AText, System::Classes::TNotifyEvent AEvent, System::TObject* const AObject);
	Vcl::Controls::TControl* __fastcall AddControl(const Vcl::Controls::TControlClass AClass, Vcltee::Chart::TCustomChart* const Chart, const System::UnicodeString AText, System::TObject* const AObject);
	Vcltee::Chart::TChart* __fastcall CreateChart(const Vcltee::Teengine::TTeeCustomToolClass ATool, const System::UnicodeString ATitle = System::UnicodeString(), const Vcltee::Teengine::TChartSeriesClass ASeries = 0x0);
	virtual void __fastcall CreateGallery() = 0 ;
	Vcltee::Chart::TChart* __fastcall NewChart(const System::UnicodeString ATitle = System::UnicodeString(), const Vcltee::Teengine::TChartSeriesClass ASeries = 0x0);
	virtual Vcltee::Chart::TCustomChart* __fastcall Prepare(System::TClass AClass);
	
public:
	__fastcall TToolDemosBase(Vcltee::Teetoolsgallery::TTeeToolsGallery* const AGallery);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TToolDemosBase() { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define TeeMsg_Animate L"&Animate !"
#define TeeMsg_Stop L"&Stop"
}	/* namespace Teetoolsgallerydemos */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEETOOLSGALLERYDEMOS)
using namespace Vcltee::Teetoolsgallerydemos;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeetoolsgallerydemosHPP
