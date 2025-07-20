// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Point3D.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Editor_Series_Point3dHPP
#define Fmxtee_Editor_Series_Point3dHPP

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
#include <FMX.TabControl.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Series.Point3D.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Editor.Stroke.hpp>
#include <FMXTee.Procs.hpp>
#include <FMX.Colors.hpp>
#include <FMX.Edit.hpp>
#include <FMXTee.Editor.Series.Pointer.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Point3d
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPoint3DSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPoint3DSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Tabcontrol::TTabItem* TabLine;
	Fmx::Tabcontrol::TTabItem* TabBaseLine;
	Fmx::Spinbox::TSpinBox* UDTransp;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Colors::TComboColorBox* BColor;
	Fmx::Stdctrls::TCheckBox* CBColorEach;
	Fmx::Spinbox::TSpinBox* UDPointDepth;
	Fmx::Stdctrls::TLabel* Label2;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBColorEachChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall UDTranspChange(System::TObject* Sender);
	void __fastcall UDPointDepthChange(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	
private:
	Fmxtee::Editor::Series::Pointer::TSeriesPointerEditor* PointerForm;
	Fmxtee::Series::Point3d::TPoint3DSeries* TheSeries;
	Fmxtee::Editor::Stroke::TStrokeEditor* FLinePen;
	Fmxtee::Editor::Stroke::TStrokeEditor* FBasePen;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPoint3DSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPoint3DSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPoint3DSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Point3d */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_POINT3D)
using namespace Fmxtee::Editor::Series::Point3d;
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
#endif	// Fmxtee_Editor_Series_Point3dHPP
