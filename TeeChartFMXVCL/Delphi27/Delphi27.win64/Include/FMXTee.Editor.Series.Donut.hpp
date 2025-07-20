// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Donut.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Editor_Series_DonutHPP
#define Fmxtee_Editor_Series_DonutHPP

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
#include <FMXTee.Chart.ListBox.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMXTee.Procs.hpp>
#include <FMX.TabControl.hpp>
#include <FMXTee.Series.Donut.hpp>
#include <FMX.Edit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Donut
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDonutSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TDonutSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Spinbox::TSpinBox* UDDonut;
	Fmx::Stdctrls::TLabel* Label6;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall UDDonutChange(System::TObject* Sender);
	
private:
	Fmxtee::Series::Donut::TDonutSeries* Donut;
	Fmx::Forms::TCustomForm* FPieForm;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDonutSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDonutSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDonutSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Donut */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_DONUT)
using namespace Fmxtee::Editor::Series::Donut;
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
#endif	// Fmxtee_Editor_Series_DonutHPP
