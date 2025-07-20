// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.AxisArrow.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Tools_AxisarrowHPP
#define Fmxtee_Editor_Tools_AxisarrowHPP

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
#include <FMXTee.Editor.Tools.Axis.hpp>
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
namespace Axisarrow
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAxisArrowToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TAxisArrowToolEditor : public Fmxtee::Editor::Tools::Axis::TAxisToolEditor
{
	typedef Fmxtee::Editor::Tools::Axis::TAxisToolEditor inherited;
	
__published:
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Listbox::TComboBox* CBPos;
	Fmx::Listbox::TListBoxItem* ListBoxItem1;
	Fmx::Listbox::TListBoxItem* ListBoxItem2;
	Fmx::Listbox::TListBoxItem* ListBoxItem3;
	Fmx::Stdctrls::TCheckBox* CBInv;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Spinbox::TSpinBox* UDLength;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Spinbox::TSpinBox* UDWidth;
	Fmx::Stdctrls::TButton* BBrush;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Spinbox::TSpinBox* UDSize;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Stdctrls::TLabel* Label7;
	Fmx::Spinbox::TSpinBox* UDScroll;
	Fmx::Stdctrls::TLabel* Label8;
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBPosChange(System::TObject* Sender);
	void __fastcall CBInvChange(System::TObject* Sender);
	void __fastcall UDLengthChange(System::TObject* Sender);
	void __fastcall UDWidthChange(System::TObject* Sender);
	void __fastcall UDSizeChange(System::TObject* Sender);
	void __fastcall UDScrollChange(System::TObject* Sender);
	void __fastcall BBrushClick(System::TObject* Sender);
	
private:
	Fmxtee::Tools::TAxisArrowTool* AxisArrow;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAxisArrowToolEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Axis::TAxisToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAxisArrowToolEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Axis::TAxisToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAxisArrowToolEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Axisarrow */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_AXISARROW)
using namespace Fmxtee::Editor::Tools::Axisarrow;
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
#endif	// Fmxtee_Editor_Tools_AxisarrowHPP
