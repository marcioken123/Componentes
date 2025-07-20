// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.Cursor.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Tools_CursorHPP
#define Fmxtee_Editor_Tools_CursorHPP

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
#include <FMX.SpinBox.hpp>
#include <FMXTee.Procs.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.ListBox.hpp>
#include <FMXTee.Tools.hpp>
#include <FMX.Edit.hpp>
#include <FMXTee.Editor.Stroke.hpp>
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
namespace Cursor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCursorToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCursorToolEditor : public Fmxtee::Editor::Tools::Series::TSeriesToolEditor
{
	typedef Fmxtee::Editor::Tools::Series::TSeriesToolEditor inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabItem1;
	Fmx::Tabcontrol::TTabItem* TabItem2;
	Fmx::Tabcontrol::TTabItem* TabItem3;
	Fmx::Listbox::TComboBox* CBStyle;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TCheckBox* CBSnap;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Listbox::TComboBox* CBSnapStyle;
	Fmx::Stdctrls::TCheckBox* CBZ;
	Fmx::Stdctrls::TCheckBox* CBFollow;
	Fmx::Combotrackbar::TComboTrackBar* UDClick;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Spinbox::TSpinBox* UDHorizSize;
	Fmx::Stdctrls::TLabel* LabelHorizSize;
	Fmx::Spinbox::TSpinBox* UDVertSize;
	Fmx::Stdctrls::TLabel* LabelVertSize;
	Fmx::Spinbox::TSpinBox* UDScope;
	Fmx::Stdctrls::TLabel* LabelScope;
	Fmx::Listbox::TComboBox* CBScopeStyle;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Listbox::TListBoxItem* ListBoxItem1;
	Fmx::Listbox::TListBoxItem* ListBoxItem2;
	Fmx::Listbox::TListBoxItem* ListBoxItem3;
	Fmx::Listbox::TListBoxItem* ListBoxItem4;
	Fmx::Listbox::TListBoxItem* ListBoxItem5;
	Fmx::Listbox::TListBoxItem* ListBoxItem6;
	Fmx::Listbox::TListBoxItem* ListBoxItem7;
	Fmx::Listbox::TListBoxItem* ListBoxItem8;
	Fmx::Listbox::TListBoxItem* ListBoxItem9;
	Fmx::Listbox::TListBoxItem* ListBoxItem10;
	Fmx::Listbox::TListBoxItem* ListBoxItem11;
	Fmx::Listbox::TListBoxItem* ListBoxItem12;
	Fmx::Listbox::TListBoxItem* ListBoxItem13;
	Fmx::Tabcontrol::TTabItem* TabBorder;
	Fmx::Tabcontrol::TTabItem* TabAnnotation;
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBFollowChange(System::TObject* Sender);
	void __fastcall CBZChange(System::TObject* Sender);
	void __fastcall UDClickTyping(System::TObject* Sender);
	void __fastcall UDClickChangeTracking(System::TObject* Sender);
	void __fastcall CBSnapStyleChange(System::TObject* Sender);
	void __fastcall UDHorizSizeChangeTracking(System::TObject* Sender);
	void __fastcall UDVertSizeChangeTracking(System::TObject* Sender);
	void __fastcall UDScopeChangeTracking(System::TObject* Sender);
	void __fastcall CBScopeStyleChange(System::TObject* Sender);
	void __fastcall CBStyleChange(System::TObject* Sender);
	HIDESBASE void __fastcall CBSeriesChange(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	
private:
	Fmxtee::Tools::TCursorTool* CursorTool;
	Fmxtee::Editor::Tools::Annotation::TAnnotationToolEdit* IAnnEditor;
	Fmxtee::Editor::Stroke::TStrokeEditor* IBorderEditor;
	void __fastcall EnableSnap();
	void __fastcall EnableScope();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TCursorToolEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TCursorToolEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TCursorToolEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Cursor */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_CURSOR)
using namespace Fmxtee::Editor::Tools::Cursor;
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
#endif	// Fmxtee_Editor_Tools_CursorHPP
