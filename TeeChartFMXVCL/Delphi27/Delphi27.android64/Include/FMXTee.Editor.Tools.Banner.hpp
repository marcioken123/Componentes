// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.Banner.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Tools_BannerHPP
#define Fmxtee_Editor_Tools_BannerHPP

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
#include <FMX.ListBox.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Memo.hpp>
#include <FMXTee.Tools.Banner.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Editor.Tools.Annotation.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Banner
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBannerEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TBannerEditor : public Fmxtee::Editor::Tools::Annotation::TAnnotationToolEdit
{
	typedef Fmxtee::Editor::Tools::Annotation::TAnnotationToolEdit inherited;
	
__published:
	Fmx::Tabcontrol::TTabItem* TabBanner;
	Fmx::Stdctrls::TCheckBox* CBScroll;
	Fmx::Stdctrls::TLabel* Label20;
	Fmx::Spinbox::TSpinBox* UDDelay;
	Fmx::Listbox::TComboBox* CBDirection;
	Fmx::Listbox::TListBoxItem* ListBoxItem17;
	Fmx::Listbox::TListBoxItem* ListBoxItem18;
	Fmx::Stdctrls::TLabel* Label17;
	Fmx::Stdctrls::TLabel* Label18;
	Fmx::Spinbox::TSpinBox* UDStep;
	Fmx::Stdctrls::TCheckBox* CBBlink;
	Fmx::Stdctrls::TLabel* Label19;
	Fmx::Spinbox::TSpinBox* UDBlinkOn;
	Fmx::Spinbox::TSpinBox* UDBlinkOff;
	Fmx::Stdctrls::TLabel* Label21;
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBScrollChange(System::TObject* Sender);
	void __fastcall UDDelayChange(System::TObject* Sender);
	void __fastcall UDStepChange(System::TObject* Sender);
	void __fastcall CBBlinkChange(System::TObject* Sender);
	void __fastcall UDBlinkOnChange(System::TObject* Sender);
	void __fastcall UDBlinkOffChange(System::TObject* Sender);
	void __fastcall CBDirectionChange(System::TObject* Sender);
	
private:
	Fmxtee::Tools::Banner::TBannerTool* Banner;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TBannerEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Annotation::TAnnotationToolEdit(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TBannerEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Annotation::TAnnotationToolEdit(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TBannerEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Banner */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_BANNER)
using namespace Fmxtee::Editor::Tools::Banner;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS)
using namespace Fmxtee::Editor::Tools;
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
#endif	// Fmxtee_Editor_Tools_BannerHPP
