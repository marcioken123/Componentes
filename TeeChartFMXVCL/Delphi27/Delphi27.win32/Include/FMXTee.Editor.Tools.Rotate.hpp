// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.Rotate.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Editor_Tools_RotateHPP
#define Fmxtee_Editor_Tools_RotateHPP

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
#include <FMXTee.Tools.hpp>
#include <FMX.Edit.hpp>
#include <FMX.TabControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Rotate
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TRotateToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TRotateToolEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Tabcontrol::TTabItem* TabFormat;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Listbox::TComboBox* CBCursor;
	Fmx::Stdctrls::TCheckBox* CBInverted;
	Fmx::Listbox::TComboBox* CBStyle;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Listbox::TComboBox* CBButton;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Stdctrls::TTrackBar* SBInertia;
	Fmx::Stdctrls::TLabel* LabelInertia;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Spinbox::TSpinBox* UDSpeed;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Listbox::TListBoxItem* ListBoxItem1;
	Fmx::Listbox::TListBoxItem* ListBoxItem2;
	Fmx::Listbox::TListBoxItem* ListBoxItem3;
	Fmx::Listbox::TListBoxItem* ListBoxItem4;
	Fmx::Listbox::TListBoxItem* ListBoxItem5;
	Fmx::Listbox::TListBoxItem* ListBoxItem6;
	Fmx::Stdctrls::TButton* BOutline;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBCursorChange(System::TObject* Sender);
	void __fastcall CBInvertedChange(System::TObject* Sender);
	void __fastcall CBStyleChange(System::TObject* Sender);
	void __fastcall CBButtonChange(System::TObject* Sender);
	void __fastcall UDSpeedChange(System::TObject* Sender);
	void __fastcall SBInertiaChange(System::TObject* Sender);
	void __fastcall BOutlineClick(System::TObject* Sender);
	
private:
	Fmxtee::Tools::TRotateTool* Rotate;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TRotateToolEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRotateToolEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRotateToolEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Rotate */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_ROTATE)
using namespace Fmxtee::Editor::Tools::Rotate;
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
#endif	// Fmxtee_Editor_Tools_RotateHPP
