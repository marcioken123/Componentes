// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Animations.Series.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Animations_SeriesHPP
#define Fmxtee_Editor_Animations_SeriesHPP

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
#include <FMX.Graphics.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.Layouts.hpp>
#include <FMXTee.Chart.GalleryPanel.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.SpinBox.hpp>
#include <FMX.ListBox.hpp>
#include <FMXTee.Animate.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMXTee.Animations.Tools.hpp>
#include <FMX.Edit.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Animations
{
namespace Series
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSeriesAnimationEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSeriesAnimationEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Stdctrls::TCheckBox* CBStartMin;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Listbox::TComboBox* CBSeries;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Edit::TEdit* EStart;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Spinbox::TSpinBox* EDrawEvery;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Listbox::TComboBox* CBLoop;
	void __fastcall CBStartMinChange(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBSeriesChange(System::TObject* Sender);
	void __fastcall CBLoopChange(System::TObject* Sender);
	void __fastcall EDrawEveryChangeTracking(System::TObject* Sender);
	void __fastcall EStartChange(System::TObject* Sender);
	
private:
	void __fastcall PrepareControls();
	
protected:
	Fmxtee::Animations::Tools::TSeriesAnimation* Animation;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSeriesAnimationEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSeriesAnimationEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSeriesAnimationEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Series */
}	/* namespace Animations */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_ANIMATIONS_SERIES)
using namespace Fmxtee::Editor::Animations::Series;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_ANIMATIONS)
using namespace Fmxtee::Editor::Animations;
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
#endif	// Fmxtee_Editor_Animations_SeriesHPP
