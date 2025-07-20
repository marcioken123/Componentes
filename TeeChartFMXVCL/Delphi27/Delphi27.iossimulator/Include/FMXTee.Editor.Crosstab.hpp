// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.CrossTab.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Editor_CrosstabHPP
#define Fmxtee_Editor_CrosstabHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.ComboEdit.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Dialogs.hpp>
#include <FMXTee.Editor.Source.hpp>
#include <FMXTee.Chart.Crosstab.hpp>
#include <FMXTee.Editor.DB.hpp>
#include <FMX.Edit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Crosstab
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDBChartCrossTabEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TDBChartCrossTabEditor : public Fmxtee::Editor::Db::TDBSourceEditor
{
	typedef Fmxtee::Editor::Db::TDBSourceEditor inherited;
	
__published:
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Listbox::TComboBox* CBAgg;
	Fmx::Comboedit::TComboEdit* CBValue;
	Fmx::Comboedit::TComboEdit* CBGroup;
	Fmx::Comboedit::TComboEdit* CBLabels;
	Fmx::Stdctrls::TCheckBox* CBActive;
	Fmx::Stdctrls::TCheckBox* CBCase;
	Fmx::Stdctrls::TCheckBox* CBHide;
	Fmx::Stdctrls::TPanel* PanelButtons;
	Fmx::Stdctrls::TPanel* Panel2;
	Fmx::Stdctrls::TButton* BOK;
	void __fastcall BApplyClick(System::TObject* Sender);
	void __fastcall CBAggChange(System::TObject* Sender);
	void __fastcall CBHideChange(System::TObject* Sender);
	void __fastcall CBCaseChange(System::TObject* Sender);
	void __fastcall CBActiveChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	HIDESBASE void __fastcall CBSourcesChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	
private:
	Fmxtee::Chart::Crosstab::TDBCrossTabSource* DataSource;
	void __fastcall EnableCombos();
	void __fastcall RefreshSource();
	
public:
	__classmethod void __fastcall Edit(System::Classes::TComponent* const AOwner, Fmxtee::Chart::Crosstab::TDBCrossTabSource* const ACrossTab);
	DYNAMIC void __fastcall Translate();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDBChartCrossTabEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Db::TDBSourceEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDBChartCrossTabEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Db::TDBSourceEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDBChartCrossTabEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Crosstab */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_CROSSTAB)
using namespace Fmxtee::Editor::Crosstab;
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
#endif	// Fmxtee_Editor_CrosstabHPP
