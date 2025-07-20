// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.DBSummary.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Editor_DbsummaryHPP
#define Fmxtee_Editor_DbsummaryHPP

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
#include <FMXTee.Editor.DB.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.ComboEdit.hpp>
#include <FMX.Edit.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Dbsummary
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDBSummaryEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TDBSummaryEditor : public Fmxtee::Editor::Db::TDBSourceEditor
{
	typedef Fmxtee::Editor::Db::TDBSourceEditor inherited;
	
__published:
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Listbox::TComboBox* CBAgg;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Comboedit::TComboEdit* CBValue;
	Fmx::Listbox::TComboBox* CBTimeStep;
	Fmx::Listbox::TComboBox* CBSort;
	Fmx::Comboedit::TComboEdit* CBGroup;
	Fmx::Listbox::TComboBox* CBSortType;
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
	Fmx::Listbox::TListBoxItem* ListBoxItem14;
	Fmx::Listbox::TListBoxItem* ListBoxItem15;
	Fmx::Listbox::TListBoxItem* ListBoxItem16;
	Fmx::Listbox::TListBoxItem* ListBoxItem17;
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBSortTypeChange(System::TObject* Sender);
	void __fastcall CBSortChange(System::TObject* Sender);
	HIDESBASE void __fastcall CBSourcesChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall BApplyClick(System::TObject* Sender);
	void __fastcall CBGroupChange(System::TObject* Sender);
	void __fastcall CBAggChange(System::TObject* Sender);
	
private:
	void __fastcall CheckCount();
	void __fastcall EnableCombos();
	void __fastcall EnableTimeStep();
	void __fastcall RefreshSummary();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDBSummaryEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Db::TDBSourceEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDBSummaryEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Db::TDBSourceEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDBSummaryEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Dbsummary */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_DBSUMMARY)
using namespace Fmxtee::Editor::Dbsummary;
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
#endif	// Fmxtee_Editor_DbsummaryHPP
