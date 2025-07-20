// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.Selector.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Editor_Tools_SelectorHPP
#define Fmxtee_Editor_Tools_SelectorHPP

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
#include <FMXTee.Tools.Selector.hpp>
#include <FMX.Edit.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Colors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Selector
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSelectorToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSelectorToolEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Listbox::TComboBox* CBCursor;
	Fmx::Stdctrls::TButton* BHandles;
	Fmx::Stdctrls::TCheckBox* CBAllowDrag;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Spinbox::TSpinBox* UDSize;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Colors::TComboColorBox* CBColor;
	Fmx::Stdctrls::TCheckBox* CBResizeChart;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBCursorChange(System::TObject* Sender);
	void __fastcall CBAllowDragChange(System::TObject* Sender);
	void __fastcall UDSizeChange(System::TObject* Sender);
	void __fastcall BHandlesClick(System::TObject* Sender);
	void __fastcall CBColorChange(System::TObject* Sender);
	void __fastcall CBResizeChartChange(System::TObject* Sender);
	
private:
	Fmxtee::Tools::Selector::TSelectorTool* Selector;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSelectorToolEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSelectorToolEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSelectorToolEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Selector */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_SELECTOR)
using namespace Fmxtee::Editor::Tools::Selector;
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
#endif	// Fmxtee_Editor_Tools_SelectorHPP
