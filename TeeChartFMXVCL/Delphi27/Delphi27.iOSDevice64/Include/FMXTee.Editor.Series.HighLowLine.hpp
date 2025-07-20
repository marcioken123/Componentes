// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.HighLowLine.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Editor_Series_HighlowlineHPP
#define Fmxtee_Editor_Series_HighlowlineHPP

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
#include <FMX.Colors.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Series.Error.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Editor.Stroke.hpp>
#include <FMXTee.Series.HighLowLine.hpp>
#include <FMXTee.Editor.Series.Pointer.hpp>
#include <FMX.TabControl.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Highlowline
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THighLowLineSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION THighLowLineSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* BBorder;
	Fmx::Colors::TComboColorBox* BColor;
	Fmx::Stdctrls::TCheckBox* CBColorEach;
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Tabcontrol::TTabItem* TabHigh;
	Fmx::Tabcontrol::TTabItem* TabLow;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBColorEachChange(System::TObject* Sender);
	void __fastcall BColorChange(System::TObject* Sender);
	void __fastcall BBorderClick(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	
private:
	Fmxtee::Series::Highlowline::THighLowLineSeries* HighLow;
	Fmxtee::Editor::Series::Pointer::TSeriesPointerEditor* FHighPointer;
	Fmxtee::Editor::Series::Pointer::TSeriesPointerEditor* FLowPointer;
public:
	/* TCustomForm.Create */ inline __fastcall virtual THighLowLineSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual THighLowLineSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~THighLowLineSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE THighLowLineSeriesEditor* HighLowLineSeriesEditor;
}	/* namespace Highlowline */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_HIGHLOWLINE)
using namespace Fmxtee::Editor::Series::Highlowline;
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
#endif	// Fmxtee_Editor_Series_HighlowlineHPP
