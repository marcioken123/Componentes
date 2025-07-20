// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.ActivityGauge.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Editor_Series_ActivitygaugeHPP
#define Fmxtee_Editor_Series_ActivitygaugeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMXTee.Procs.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Controls.Presentation.hpp>
#include <FMX.Graphics.hpp>
#include <FMXTee.Series.ActivityGauge.hpp>
#include <FMX.Colors.hpp>
#include <FMX.TabControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Activitygauge
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TActivityGaugeSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TActivityGaugeSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Colors::TComboColorBox* BBackColor;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	void __fastcall BBackColorChange(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	
private:
	Fmxtee::Series::Activitygauge::TActivityGauge* ActivityGauge;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TActivityGaugeSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TActivityGaugeSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TActivityGaugeSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TActivityGaugeSeriesEditor* ActivityGaugeSeriesEditor;
}	/* namespace Activitygauge */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_ACTIVITYGAUGE)
using namespace Fmxtee::Editor::Series::Activitygauge;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES)
using namespace Fmxtee::Editor::Series;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR)
using namespace Fmxtee::Editor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Editor_Series_ActivitygaugeHPP
