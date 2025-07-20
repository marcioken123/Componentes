// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.CustomLegend.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Tools_CustomlegendHPP
#define Fmxtee_Editor_Tools_CustomlegendHPP

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
#include <FMX.Grid.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Memo.hpp>
#include <FMXTee.Tools.CustomLegend.hpp>
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
namespace Customlegend
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomLegendToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCustomLegendToolEditor : public Fmxtee::Editor::Tools::Annotation::TAnnotationToolEdit
{
	typedef Fmxtee::Editor::Tools::Annotation::TAnnotationToolEdit inherited;
	
__published:
	Fmx::Tabcontrol::TTabItem* TabGrid;
	Fmx::Stdctrls::TLabel* Label20;
	Fmx::Spinbox::TSpinBox* UDColCount;
	Fmx::Stdctrls::TLabel* Label18;
	Fmx::Spinbox::TSpinBox* UDRowCount;
	Fmx::Stdctrls::TLabel* Label19;
	Fmx::Spinbox::TSpinBox* UDFixedCols;
	Fmx::Spinbox::TSpinBox* UDFixedRows;
	Fmx::Stdctrls::TLabel* Label21;
	Fmx::Spinbox::TSpinBox* UDGridHeight;
	Fmx::Spinbox::TSpinBox* UDGridWidth;
	Fmx::Stdctrls::TLabel* Label17;
	Fmx::Stdctrls::TLabel* Label22;
	Fmx::Stdctrls::TCheckBox* CBAllowDrag;
	Fmx::Stdctrls::TCheckBox* CBAllowResize;
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall UDColCountChange(System::TObject* Sender);
	void __fastcall UDRowCountChange(System::TObject* Sender);
	void __fastcall UDGridWidthChange(System::TObject* Sender);
	void __fastcall UDGridHeightChange(System::TObject* Sender);
	void __fastcall CBAllowDragChange(System::TObject* Sender);
	void __fastcall CBAllowResizeChange(System::TObject* Sender);
	
private:
	Fmxtee::Tools::Customlegend::TCustomLegendTool* CustomLegend;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TCustomLegendToolEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Annotation::TAnnotationToolEdit(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TCustomLegendToolEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Annotation::TAnnotationToolEdit(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TCustomLegendToolEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Customlegend */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_CUSTOMLEGEND)
using namespace Fmxtee::Editor::Tools::Customlegend;
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
#endif	// Fmxtee_Editor_Tools_CustomlegendHPP
