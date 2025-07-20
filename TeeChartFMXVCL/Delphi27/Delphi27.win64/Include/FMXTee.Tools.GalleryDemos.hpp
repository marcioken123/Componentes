// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.GalleryDemos.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Tools_GallerydemosHPP
#define Fmxtee_Tools_GallerydemosHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <FMX.Types.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Graphics.hpp>
#include <System.UITypes.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Tools.Gallery.hpp>
#include <FMXTee.Animations.Tools.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Gallerydemos
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TToolDemosBase;
//-- type declarations -------------------------------------------------------
typedef Fmx::Stdctrls::TButton TBitBtn;

_DECLARE_METACLASS(System::TMetaClass, TControlClass);

class PASCALIMPLEMENTATION TToolDemosBase : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	void __fastcall ChartDblClick(System::TObject* Sender);
	
protected:
	Fmxtee::Tools::Gallery::TToolsGallery* Gallery;
	Fmx::Stdctrls::TButton* __fastcall AddBitButton(Fmxtee::Chart::TCustomChart* const Chart, Fmxtee::Engine::TCustomChartElement* const Element, const System::UnicodeString AText, System::Classes::TNotifyEvent AEvent, System::TObject* const AObject);
	Fmx::Stdctrls::TButton* __fastcall AddButton(Fmxtee::Chart::TCustomChart* const Chart, const System::UnicodeString AText, System::Classes::TNotifyEvent AEvent, System::TObject* const AObject);
	Fmx::Stdctrls::TCheckBox* __fastcall AddCheck(Fmxtee::Chart::TCustomChart* const Chart, const System::UnicodeString AText, System::Classes::TNotifyEvent AEvent, System::TObject* const AObject);
	Fmx::Controls::TControl* __fastcall AddControl(const TControlClass AClass, Fmxtee::Chart::TCustomChart* const Chart, const System::UnicodeString AText, System::TObject* const AObject);
	Fmxtee::Chart::TChart* __fastcall CreateChart(const Fmxtee::Engine::TTeeCustomToolClass ATool, const System::UnicodeString ATitle = System::UnicodeString(), const Fmxtee::Engine::TChartSeriesClass ASeries = 0x0);
	virtual void __fastcall CreateGallery() = 0 ;
	Fmxtee::Chart::TChart* __fastcall NewChart(const System::UnicodeString ATitle = System::UnicodeString(), const Fmxtee::Engine::TChartSeriesClass ASeries = 0x0);
	virtual Fmxtee::Chart::TCustomChart* __fastcall Prepare(System::TClass AClass);
	
public:
	__fastcall TToolDemosBase(Fmxtee::Tools::Gallery::TToolsGallery* const AGallery);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TToolDemosBase() { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define TeeMsg_Animate L"&Animate !"
#define TeeMsg_Stop L"&Stop"
}	/* namespace Gallerydemos */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_GALLERYDEMOS)
using namespace Fmxtee::Tools::Gallerydemos;
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
#endif	// Fmxtee_Tools_GallerydemosHPP
