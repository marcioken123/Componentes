// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.HighLow.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Editor_Series_HighlowHPP
#define Fmxtee_Editor_Series_HighlowHPP

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
#include <FMXTee.Series.Error.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Editor.Stroke.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Editor.Brush.hpp>
#include <FMX.SpinBox.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Colors.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Highlow
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THighLowSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION THighLowSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Tabcontrol::TTabItem* TabHigh;
	Fmx::Tabcontrol::TTabItem* TabLow;
	Fmx::Tabcontrol::TTabItem* TabLines;
	Fmx::Colors::TComboColorBox* BColor;
	Fmx::Stdctrls::TCheckBox* CBColorEach;
	Fmx::Spinbox::TSpinBox* UDTransp;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Tabcontrol::TTabControl* PageHigh;
	Fmx::Tabcontrol::TTabItem* TabHighBorder;
	Fmx::Tabcontrol::TTabItem* TabHighPattern;
	Fmx::Tabcontrol::TTabControl* PageLow;
	Fmx::Tabcontrol::TTabItem* TabLowBorder;
	Fmx::Tabcontrol::TTabItem* TabLowPattern;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBColorEachChange(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	void __fastcall UDTranspChange(System::TObject* Sender);
	void __fastcall PageLowChange(System::TObject* Sender);
	void __fastcall PageHighChange(System::TObject* Sender);
	
private:
	Fmxtee::Series::Error::THighLowSeries* HighLow;
	Fmxtee::Editor::Stroke::TStrokeEditor* FHighPen;
	Fmxtee::Editor::Brush::TBrushEditor* FHighBrush;
	Fmxtee::Editor::Stroke::TStrokeEditor* FLowPen;
	Fmxtee::Editor::Brush::TBrushEditor* FLowBrush;
	Fmxtee::Editor::Stroke::TStrokeEditor* FPen;
public:
	/* TCustomForm.Create */ inline __fastcall virtual THighLowSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual THighLowSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~THighLowSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE THighLowSeriesEditor* HighLowSeriesEditor;
}	/* namespace Highlow */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_HIGHLOW)
using namespace Fmxtee::Editor::Series::Highlow;
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
#endif	// Fmxtee_Editor_Series_HighlowHPP
