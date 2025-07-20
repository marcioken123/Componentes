// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Surface.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Editor_Series_SurfaceHPP
#define Fmxtee_Editor_Series_SurfaceHPP

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
#include <FMX.TabControl.hpp>
#include <FMXTee.Series.Surface.hpp>
#include <FMX.Edit.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Colors.hpp>
#include <FMXTee.Procs.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Grid.hpp>
#include <FMXTee.Chart.Grid.hpp>
#include <FMXTee.Editor.Stroke.hpp>
#include <FMXTee.Editor.Brush.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Surface
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSurfaceSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSurfaceSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabGlobal;
	Fmx::Tabcontrol::TTabItem* TabGrid3D;
	Fmx::Tabcontrol::TTabControl* TabControl2;
	Fmx::Tabcontrol::TTabItem* TabItem1;
	Fmx::Tabcontrol::TTabItem* TabBorder;
	Fmx::Tabcontrol::TTabItem* TabPattern;
	Fmx::Tabcontrol::TTabItem* TabSides;
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Stdctrls::TRadioButton* rbWireFrame;
	Fmx::Stdctrls::TRadioButton* rbDotFrame;
	Fmx::Stdctrls::TRadioButton* rbSolid;
	Fmx::Stdctrls::TCheckBox* CBSmoothPalette;
	Fmx::Stdctrls::TCheckBox* CBHideCells;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Stdctrls::TCheckBox* CBFastBrush;
	Fmx::Tabcontrol::TTabControl* TabControl3;
	Fmx::Tabcontrol::TTabItem* TabSidesPen;
	Fmx::Tabcontrol::TTabItem* TabSidesBrush;
	Fmx::Stdctrls::TTrackBar* TBTransp;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBSmoothPaletteChange(System::TObject* Sender);
	void __fastcall rbSolidChange(System::TObject* Sender);
	void __fastcall rbWireFrameChange(System::TObject* Sender);
	void __fastcall rbDotFrameChange(System::TObject* Sender);
	void __fastcall CBHideCellsChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall CBFastBrushChange(System::TObject* Sender);
	void __fastcall TabControl2Change(System::TObject* Sender);
	void __fastcall TabControl3Change(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	void __fastcall TBTranspTracking(System::TObject* Sender);
	
private:
	Fmxtee::Editor::Stroke::TStrokeEditor* ISideBorder;
	Fmxtee::Editor::Stroke::TStrokeEditor* IBorder;
	Fmxtee::Editor::Brush::TBrushEditor* ISidePattern;
	Fmxtee::Editor::Brush::TBrushEditor* IPattern;
	
protected:
	Fmx::Forms::TCustomForm* Grid3DForm;
	Fmxtee::Series::Surface::TSurfaceSeries* Surface;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSurfaceSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSurfaceSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSurfaceSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Surface */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_SURFACE)
using namespace Fmxtee::Editor::Series::Surface;
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
#endif	// Fmxtee_Editor_Series_SurfaceHPP
