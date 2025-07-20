// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.Nearest.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Tools_NearestHPP
#define Fmxtee_Editor_Tools_NearestHPP

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
#include <FMX.ComboTrackBar.hpp>
#include <FMXTee.Procs.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Edit.hpp>
#include <FMXTee.Tools.hpp>
#include <FMX.TabControl.hpp>
#include <FMXTee.Editor.Stroke.hpp>
#include <FMXTee.Editor.Brush.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Nearest
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TNearestToolEdit;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TNearestToolEdit : public Fmxtee::Editor::Tools::Series::TSeriesToolEditor
{
	typedef Fmxtee::Editor::Tools::Series::TSeriesToolEditor inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Tabcontrol::TTabItem* TabPen;
	Fmx::Tabcontrol::TTabItem* TabBrush;
	Fmx::Tabcontrol::TTabItem* TabLine;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Combotrackbar::TComboTrackBar* UDSize;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Listbox::TComboBox* CBStyle;
	Fmx::Listbox::TListBoxItem* ListBoxItem1;
	Fmx::Listbox::TListBoxItem* ListBoxItem2;
	Fmx::Listbox::TListBoxItem* ListBoxItem3;
	Fmx::Listbox::TListBoxItem* ListBoxItem4;
	Fmx::Listbox::TListBoxItem* ListBoxItem5;
	Fmx::Stdctrls::TCheckBox* CBFull;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Combotrackbar::TComboTrackBar* UDDistance;
	Fmx::Stdctrls::TCheckBox* CBShowHint;
	Fmx::Listbox::TComboBox* CBHintStyle;
	void __fastcall CBFullChange(System::TObject* Sender);
	void __fastcall UDSizeChangeTracking(System::TObject* Sender);
	void __fastcall CBStyleChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	void __fastcall UDDistanceChangeTracking(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBShowHintChange(System::TObject* Sender);
	void __fastcall CBHintStyleChange(System::TObject* Sender);
	
private:
	Fmxtee::Tools::TNearestTool* Nearest;
	Fmxtee::Editor::Stroke::TStrokeEditor* IPen;
	Fmxtee::Editor::Stroke::TStrokeEditor* ILine;
	Fmxtee::Editor::Brush::TBrushEditor* IBrush;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TNearestToolEdit(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TNearestToolEdit(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TNearestToolEdit() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Nearest */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_NEAREST)
using namespace Fmxtee::Editor::Tools::Nearest;
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
#endif	// Fmxtee_Editor_Tools_NearestHPP
