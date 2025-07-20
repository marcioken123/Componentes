// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Equalizer.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Series_EqualizerHPP
#define Fmxtee_Editor_Series_EqualizerHPP

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
#include <FMX.SpinBox.hpp>
#include <FMX.Controls.Presentation.hpp>
#include <FMX.EditBox.hpp>
#include <FMX.Graphics.hpp>
#include <FMXTee.Series.Equalizer.hpp>
#include <FMXTee.Editor.Series.CustomBar.hpp>
#include <FMX.Colors.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Edit.hpp>
#include <FMXTee.Editor.Stroke.hpp>
#include <FMXTee.Editor.Series.Pointer.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Equalizer
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TEqualizerSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TEqualizerSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Spinbox::TSpinBox* UDDInterval;
	Fmx::Stdctrls::TCheckBox* CBDHigh;
	Fmx::Controls::TStyleBook* StyleBook1;
	Fmx::Edit::TEdit* EDDownStep;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall AddEditors();
	void __fastcall UDDIntervalChange(System::TObject* Sender);
	void __fastcall CBDHighChange(System::TObject* Sender);
	void __fastcall EDDownStepChange(System::TObject* Sender);
	
private:
	Fmxtee::Series::Equalizer::TEqualizerSeries* EqualizerSeries;
	Fmx::Forms::TForm* FBarEditor;
	Fmx::Forms::TForm* FPointEditor;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TEqualizerSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TEqualizerSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TEqualizerSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TEqualizerSeriesEditor* EqualizerSeriesSeriesEditor;
}	/* namespace Equalizer */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_EQUALIZER)
using namespace Fmxtee::Editor::Series::Equalizer;
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
#endif	// Fmxtee_Editor_Series_EqualizerHPP
