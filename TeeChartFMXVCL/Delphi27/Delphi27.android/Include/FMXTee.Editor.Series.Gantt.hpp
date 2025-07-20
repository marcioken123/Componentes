// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Gantt.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Series_GanttHPP
#define Fmxtee_Editor_Series_GanttHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Dialogs.hpp>
#include <FMXTee.Series.Gantt.hpp>
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
namespace Gantt
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGanttSeriesEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TGanttSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabGanttOptions;
	Fmx::Tabcontrol::TTabItem* TabCallout;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Stdctrls::TButton* BConnLines;
	Fmx::Spinbox::TSpinBox* UDPointVertSize;
	Fmx::Stdctrls::TGroupBox* GPLine;
	Fmx::Stdctrls::TButton* BColor;
	Fmx::Stdctrls::TCheckBox* CBColorEach;
	Fmx::Spinbox::TSpinBox* UDTransp;
	void __fastcall BColorClick(System::TObject* Sender);
	void __fastcall CBColorEachChange(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall BConnLinesClick(System::TObject* Sender);
	void __fastcall UDTranspChange(System::TObject* Sender);
	void __fastcall UDPointVertSizeChange(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	
private:
	Fmxtee::Editor::Series::Pointer::TSeriesPointerEditor* ICallout;
	Fmxtee::Series::Gantt::TGanttSeries* FGantt;
	Fmxtee::Editor::Series::Pointer::TSeriesPointerEditor* FPointerEditor;
	void __fastcall RefreshGantt(Fmxtee::Series::Gantt::TGanttSeries* const AGantt);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TGanttSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TGanttSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TGanttSeriesEditor() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Gantt */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_GANTT)
using namespace Fmxtee::Editor::Series::Gantt;
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
#endif	// Fmxtee_Editor_Series_GanttHPP
