// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.DrawLine.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Editor_Tools_DrawlineHPP
#define Fmxtee_Editor_Tools_DrawlineHPP

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
#include <FMXTee.Editor.Tools.Series.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMXTee.Procs.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Edit.hpp>
#include <FMXTee.Tools.hpp>
#include <FMX.TabControl.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Drawline
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDrawLineEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TDrawLineEdit : public Fmxtee::Editor::Tools::Series::TSeriesToolEditor
{
	typedef Fmxtee::Editor::Tools::Series::TSeriesToolEditor inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Tabcontrol::TTabItem* TabFormat;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Listbox::TComboBox* CBButton;
	Fmx::Listbox::TListBoxItem* ListBoxItem1;
	Fmx::Listbox::TListBoxItem* ListBoxItem2;
	Fmx::Listbox::TListBoxItem* ListBoxItem3;
	Fmx::Stdctrls::TCheckBox* CBEnable;
	Fmx::Stdctrls::TCheckBox* CBSelect;
	Fmx::Stdctrls::TCheckBox* CBSelectNew;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Spinbox::TSpinBox* UDClick;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Stdctrls::TButton* BPen;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Listbox::TComboBox* CBStyle;
	Fmx::Listbox::TListBoxItem* ListBoxItem4;
	Fmx::Listbox::TListBoxItem* ListBoxItem5;
	Fmx::Listbox::TListBoxItem* ListBoxItem6;
	Fmx::Listbox::TListBoxItem* ListBoxItem7;
	Fmx::Listbox::TListBoxItem* ListBoxItem8;
	void __fastcall CBStyleChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBButtonChange(System::TObject* Sender);
	void __fastcall CBEnableChange(System::TObject* Sender);
	void __fastcall CBSelectChange(System::TObject* Sender);
	void __fastcall CBSelectNewChange(System::TObject* Sender);
	void __fastcall BPenClick(System::TObject* Sender);
	void __fastcall UDClickChange(System::TObject* Sender);
	
private:
	Fmxtee::Tools::TDrawLineTool* DrawLine;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDrawLineEdit(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDrawLineEdit(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDrawLineEdit() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Drawline */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_DRAWLINE)
using namespace Fmxtee::Editor::Tools::Drawline;
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
#endif	// Fmxtee_Editor_Tools_DrawlineHPP
