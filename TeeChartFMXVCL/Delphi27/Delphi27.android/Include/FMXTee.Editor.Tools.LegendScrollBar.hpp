// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.LegendScrollBar.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Tools_LegendscrollbarHPP
#define Fmxtee_Editor_Tools_LegendscrollbarHPP

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
#include <FMX.ListBox.hpp>
#include <FMXTee.Tools.hpp>
#include <FMX.Edit.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Memo.hpp>
#include <FMXTee.Tools.LegendScrollBar.hpp>
#include <FMX.Colors.hpp>
#include <FMXTee.Editor.Stroke.hpp>
#include <FMXTee.Editor.Brush.hpp>
#include <FMXTee.Editor.Gradient.hpp>
#include <FMXTee.Editor.Picture.hpp>
#include <FMXTee.Procs.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Legendscrollbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TScrollbarEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TScrollbarEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Tabcontrol::TTabItem* TabFormat;
	Fmx::Tabcontrol::TTabItem* TabThumb;
	Fmx::Stdctrls::TCheckBox* CBAuto;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Spinbox::TSpinBox* UDSize;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Spinbox::TSpinBox* UDDelay;
	Fmx::Stdctrls::TCheckBox* CBArrows;
	Fmx::Layouts::TLayout* Layout1;
	Fmx::Colors::TComboColorBox* CBColor;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Tabcontrol::TTabControl* TabControl2;
	Fmx::Tabcontrol::TTabItem* TabBorder;
	Fmx::Tabcontrol::TTabItem* TabBack;
	Fmx::Tabcontrol::TTabItem* TabArrows;
	Fmx::Tabcontrol::TTabItem* TabDisabled;
	Fmx::Tabcontrol::TTabControl* TabControl3;
	Fmx::Tabcontrol::TTabItem* TabThumbOptions;
	Fmx::Tabcontrol::TTabItem* TabThumbBorder;
	Fmx::Tabcontrol::TTabItem* TabThumbBrush;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Listbox::TComboBox* CBBevel;
	Fmx::Listbox::TListBoxItem* ListBoxItem6;
	Fmx::Listbox::TListBoxItem* ListBoxItem7;
	Fmx::Listbox::TListBoxItem* ListBoxItem8;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Spinbox::TSpinBox* UDThumbSize;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Spinbox::TSpinBox* UDRoundSize;
	Fmx::Listbox::TComboBox* CBStyle;
	Fmx::Listbox::TListBoxItem* ListBoxItem1;
	Fmx::Listbox::TListBoxItem* ListBoxItem2;
	Fmx::Listbox::TListBoxItem* ListBoxItem3;
	Fmx::Listbox::TListBoxItem* ListBoxItem4;
	Fmx::Listbox::TListBoxItem* ListBoxItem5;
	Fmx::Stdctrls::TLabel* Label7;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall UDSizeChange(System::TObject* Sender);
	void __fastcall CBAutoChange(System::TObject* Sender);
	void __fastcall UDDelayChange(System::TObject* Sender);
	void __fastcall CBColorChange(System::TObject* Sender);
	void __fastcall CBStyleChange(System::TObject* Sender);
	void __fastcall UDThumbSizeChange(System::TObject* Sender);
	void __fastcall CBBevelChange(System::TObject* Sender);
	void __fastcall CBArrowsChange(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	void __fastcall TabControl2Change(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall TabControl3Change(System::TObject* Sender);
	void __fastcall UDRoundSizeChangeTracking(System::TObject* Sender);
	
private:
	Fmxtee::Tools::TTeeScrollBar* Scrollbar;
	Fmxtee::Editor::Brush::TBrushEditor* IArrow;
	Fmxtee::Editor::Stroke::TStrokeEditor* IBorder;
	Fmxtee::Editor::Brush::TBrushEditor* IBack;
	Fmxtee::Editor::Brush::TBrushEditor* IDisabled;
	Fmxtee::Editor::Stroke::TStrokeEditor* IThumbBorder;
	Fmxtee::Editor::Brush::TBrushEditor* IThumbBrush;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TScrollbarEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TScrollbarEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TScrollbarEditor() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Legendscrollbar */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_LEGENDSCROLLBAR)
using namespace Fmxtee::Editor::Tools::Legendscrollbar;
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
#endif	// Fmxtee_Editor_Tools_LegendscrollbarHPP
