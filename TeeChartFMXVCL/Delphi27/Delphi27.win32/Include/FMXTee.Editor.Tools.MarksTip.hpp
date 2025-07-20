// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.MarksTip.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Editor_Tools_MarkstipHPP
#define Fmxtee_Editor_Tools_MarkstipHPP

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
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMXTee.Tools.hpp>
#include <FMXTee.Editor.TextShape.hpp>
#include <FMXTee.Editor.Tools.Series.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Edit.hpp>
#include <FMX.TabControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Markstip
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TMarksTipToolEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TMarksTipToolEdit : public Fmxtee::Editor::Tools::Series::TSeriesToolEditor
{
	typedef Fmxtee::Editor::Tools::Series::TSeriesToolEditor inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabMarksTip;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Tabcontrol::TTabItem* TabFormat;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Listbox::TComboBox* CBStyle;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Listbox::TComboBox* CBMouse;
	Fmx::Spinbox::TSpinBox* SBDelay;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Spinbox::TSpinBox* SBHide;
	Fmx::Listbox::TListBoxItem* LIMouseMove;
	Fmx::Listbox::TListBoxItem* LIMouseClick;
	void __fastcall TabMarksTipChange(System::TObject* Sender);
	void __fastcall SBHideChangeTracking(System::TObject* Sender);
	void __fastcall SBDelayChangeTracking(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBMouseChange(System::TObject* Sender);
	void __fastcall CBStyleChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	
private:
	Fmxtee::Editor::Textshape::TTextShapeEditor* IShapeEditor;
	Fmxtee::Tools::TMarksTipTool* MarksTool;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TMarksTipToolEdit(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TMarksTipToolEdit(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TMarksTipToolEdit() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Markstip */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_MARKSTIP)
using namespace Fmxtee::Editor::Tools::Markstip;
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
#endif	// Fmxtee_Editor_Tools_MarkstipHPP
