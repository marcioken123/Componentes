// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Tower.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Editor_Series_TowerHPP
#define Fmxtee_Editor_Series_TowerHPP

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
#include <FMXTee.Chart.ListBox.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMX.TabControl.hpp>
#include <FMXTee.Series.Surface.hpp>
#include <FMX.Edit.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Colors.hpp>
#include <FMXTee.Procs.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Grid.hpp>
#include <FMXTee.Chart.Grid.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Tower
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTowerSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTowerSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabGlobal;
	Fmx::Stdctrls::TButton* BPen;
	Fmx::Stdctrls::TButton* BBrush;
	Fmx::Spinbox::TSpinBox* UDTowerTransp;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Tabcontrol::TTabItem* TabGrid3D;
	Fmx::Stdctrls::TCheckBox* CBDark3D;
	Fmx::Listbox::TComboBox* CBStyle;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Listbox::TListBoxItem* ListBoxItem1;
	Fmx::Listbox::TListBoxItem* ListBoxItem2;
	Fmx::Listbox::TListBoxItem* ListBoxItem3;
	Fmx::Listbox::TListBoxItem* ListBoxItem4;
	Fmx::Listbox::TListBoxItem* ListBoxItem5;
	Fmx::Listbox::TListBoxItem* ListBoxItem6;
	Fmx::Listbox::TListBoxItem* ListBoxItem7;
	Fmx::Listbox::TListBoxItem* ListBoxItem8;
	Fmx::Listbox::TListBoxItem* ListBoxItem9;
	Fmx::Stdctrls::TCheckBox* CBOrigin;
	Fmx::Edit::TEdit* EOrigin;
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Spinbox::TSpinBox* UDDepth;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Spinbox::TSpinBox* UDWidth;
	Fmx::Stdctrls::TLabel* Label3;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall BPenClick(System::TObject* Sender);
	void __fastcall BBrushClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall CBDark3DChange(System::TObject* Sender);
	void __fastcall UDTowerTranspChange(System::TObject* Sender);
	void __fastcall CBOriginChange(System::TObject* Sender);
	void __fastcall EOriginChange(System::TObject* Sender);
	void __fastcall CBStyleChange(System::TObject* Sender);
	void __fastcall UDDepthChange(System::TObject* Sender);
	void __fastcall UDWidthChange(System::TObject* Sender);
	
protected:
	Fmx::Forms::TCustomForm* Grid3DForm;
	Fmxtee::Series::Surface::TTowerSeries* Tower;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTowerSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTowerSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTowerSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Tower */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_TOWER)
using namespace Fmxtee::Editor::Series::Tower;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES)
using namespace Fmxtee::Editor::Series;
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
#endif	// Fmxtee_Editor_Series_TowerHPP
