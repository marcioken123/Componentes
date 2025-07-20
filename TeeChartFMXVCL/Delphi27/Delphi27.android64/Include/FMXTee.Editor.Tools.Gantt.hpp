// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.Gantt.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Tools_GanttHPP
#define Fmxtee_Editor_Tools_GanttHPP

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
#include <FMXTee.Tools.Gantt.hpp>
#include <FMX.Edit.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Gantt
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGanttToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TGanttToolEditor : public Fmxtee::Editor::Tools::Series::TSeriesToolEditor
{
	typedef Fmxtee::Editor::Tools::Series::TSeriesToolEditor inherited;
	
__published:
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Spinbox::TSpinBox* UDTolerance;
	Fmx::Stdctrls::TCheckBox* CBAllowDrag;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Listbox::TComboBox* CBCursorDrag;
	Fmx::Stdctrls::TCheckBox* CBAllowResize;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Listbox::TComboBox* CBCursorResize;
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall UDToleranceChange(System::TObject* Sender);
	void __fastcall CBAllowDragChange(System::TObject* Sender);
	void __fastcall CBCursorDragChange(System::TObject* Sender);
	void __fastcall CBCursorResizeChange(System::TObject* Sender);
	void __fastcall CBAllowResizeChange(System::TObject* Sender);
	
private:
	Fmxtee::Tools::Gantt::TGanttTool* Gantt;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TGanttToolEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TGanttToolEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TGanttToolEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Gantt */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_GANTT)
using namespace Fmxtee::Editor::Tools::Gantt;
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
#endif	// Fmxtee_Editor_Tools_GanttHPP
