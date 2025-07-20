// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Pyramid.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Editor_Series_PyramidHPP
#define Fmxtee_Editor_Series_PyramidHPP

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
#include <System.Rtti.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Colors.hpp>
#include <FMX.TabControl.hpp>
#include <FMXTee.Editor.Stroke.hpp>
#include <FMXTee.Editor.Brush.hpp>
#include <FMXTee.Series.Pyramid.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Pyramid
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPyramidSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPyramidSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Tabcontrol::TTabItem* TabBorder;
	Fmx::Tabcontrol::TTabItem* TabPattern;
	Fmx::Colors::TComboColorBox* CBColor;
	Fmx::Stdctrls::TCheckBox* CBDefColor;
	Fmx::Stdctrls::TCheckBox* CBColorEach;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Stdctrls::TTrackBar* TBSize;
	Fmx::Stdctrls::TLabel* LSize;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TTrackBar* TBTransp;
	Fmx::Stdctrls::TLabel* LTransp;
	void __fastcall TabControl1Change(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	void __fastcall TBSizeChange(System::TObject* Sender);
	void __fastcall CBColorEachChange(System::TObject* Sender);
	void __fastcall CBDefColorChange(System::TObject* Sender);
	void __fastcall CBColorChange(System::TObject* Sender);
	
private:
	Fmxtee::Editor::Stroke::TStrokeEditor* FBorder;
	Fmxtee::Editor::Brush::TBrushEditor* FBrush;
	Fmxtee::Series::Pyramid::TPyramidSeries* Pyramid;
	void __fastcall CheckDefColor();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPyramidSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPyramidSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPyramidSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Pyramid */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_PYRAMID)
using namespace Fmxtee::Editor::Series::Pyramid;
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
#endif	// Fmxtee_Editor_Series_PyramidHPP
