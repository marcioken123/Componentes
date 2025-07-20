// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Histogram.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Editor_Series_HistogramHPP
#define Fmxtee_Editor_Series_HistogramHPP

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
#include <FMX.Edit.hpp>
#include <FMX.Colors.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMX.TabControl.hpp>
#include <FMXTee.Functions.Stats.hpp>
#include <FMXTee.Editor.Stroke.hpp>
#include <FMXTee.Editor.Brush.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Histogram
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THistogramSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION THistogramSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Stdctrls::TCheckBox* CBColorEach;
	Fmx::Tabcontrol::TTabItem* TabBorder;
	Fmx::Tabcontrol::TTabItem* TabLines;
	Fmx::Tabcontrol::TTabItem* TabPattern;
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Colors::TColorButton* BAreaColor;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Spinbox::TSpinBox* UDTransp;
	Fmx::Stdctrls::TLabel* Label7;
	Fmx::Stdctrls::TGroupBox* GroupBox2;
	Fmx::Stdctrls::TCheckBox* CBUseOrigin;
	Fmx::Spinbox::TSpinBox* UDOrigin;
	Fmx::Stdctrls::TLabel* Label8;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBColorEachChange(System::TObject* Sender);
	void __fastcall UDTranspChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBUseOriginChange(System::TObject* Sender);
	void __fastcall UDOriginChange(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	
private:
	bool CreatingForm;
	Fmxtee::Editor::Stroke::TStrokeEditor* FBorder;
	Fmxtee::Editor::Stroke::TStrokeEditor* FLines;
	Fmxtee::Editor::Brush::TBrushEditor* FPattern;
	Fmxtee::Functions::Stats::THistogramSeries* TheSeries;
	void __fastcall EnableOrigin();
public:
	/* TCustomForm.Create */ inline __fastcall virtual THistogramSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual THistogramSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~THistogramSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Histogram */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_HISTOGRAM)
using namespace Fmxtee::Editor::Series::Histogram;
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
#endif	// Fmxtee_Editor_Series_HistogramHPP
