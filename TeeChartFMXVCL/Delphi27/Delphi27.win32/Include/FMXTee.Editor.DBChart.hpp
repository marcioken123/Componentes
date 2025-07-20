// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.DBChart.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Editor_DbchartHPP
#define Fmxtee_Editor_DbchartHPP

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
#include <FMX.Edit.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.ComboEdit.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.ListBox.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Dbchart
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDBChartEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TDBChartEditor : public Fmxtee::Editor::Db::TDBSourceEditor
{
	typedef Fmxtee::Editor::Db::TDBSourceEditor inherited;
	
__published:
	Fmx::Layouts::TLayout* GroupFields;
	Fmx::Stdctrls::TLabel* LLabels;
	Fmx::Comboedit::TComboEdit* CBLabelsField;
	void __fastcall CBLabelsFieldChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall BApplyClick(System::TObject* Sender);
	HIDESBASE void __fastcall CBSourcesChange(System::TObject* Sender);
	
private:
	static const System::Int8 MaxValueSources = System::Int8(0x10);
	
	System::StaticArray<Fmx::Stdctrls::TLabel*, 16> LabelValues;
	System::StaticArray<Fmx::Stdctrls::TCheckBox*, 16> CBDateTime;
	void __fastcall CBValuesChange(System::TObject* Sender);
	void __fastcall RefreshFields();
	void __fastcall SetFields();
	void __fastcall SetTextItemIndex(Fmx::Comboedit::TComboEdit* const Combo);
	
protected:
	virtual bool __fastcall IsValid(System::Classes::TComponent* AComponent);
	
public:
	System::StaticArray<Fmx::Comboedit::TComboEdit*, 16> CBValues;
	DYNAMIC void __fastcall Translate();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDBChartEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Db::TDBSourceEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDBChartEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Db::TDBSourceEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDBChartEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Dbchart */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_DBCHART)
using namespace Fmxtee::Editor::Dbchart;
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
#endif	// Fmxtee_Editor_DbchartHPP
