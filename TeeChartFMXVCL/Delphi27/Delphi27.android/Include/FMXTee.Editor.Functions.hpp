// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Functions.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_FunctionsHPP
#define Fmxtee_Editor_FunctionsHPP

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
#include <FMX.Controls.Presentation.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.TabControl.hpp>
#include <FMXTee.Editor.Source.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Editor.SelectList.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Functions
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFunctionEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TFunctionEditor : public Fmxtee::Editor::Source::TBaseSourceEditor
{
	typedef Fmxtee::Editor::Source::TBaseSourceEditor inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* PageControl1;
	Fmx::Tabcontrol::TTabItem* TabSource;
	Fmx::Stdctrls::TPanel* PanSingle;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Stdctrls::TLabel* LValues;
	Fmx::Listbox::TComboBox* CBSingle;
	Fmx::Listbox::TComboBox* CBValues;
	Fmx::Stdctrls::TButton* BNone;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Stdctrls::TButton* SpeedButton1;
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall BApplyClick(System::TObject* Sender);
	void __fastcall CBSingleChange(System::TObject* Sender);
	void __fastcall CBValuesChange(System::TObject* Sender);
	void __fastcall BNoneClick(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	HIDESBASE void __fastcall CBSourcesChange(System::TObject* Sender);
	
private:
	bool Filling;
	Fmx::Forms::TForm* IOptions;
	Fmxtee::Editor::Selectlist::TSelectListForm* ISources;
	void __fastcall FillSeries();
	__classmethod void __fastcall SetValueListCombo(Fmxtee::Engine::TChartSeries* const Series, Fmx::Listbox::TComboBox* const Combo);
	void __fastcall TryCreateNewFunction();
	
public:
	Fmxtee::Engine::TChartSeries* Series;
	__classmethod void __fastcall FillSeriesSources(Fmx::Listbox::TCustomListBox* const AItems, Fmx::Listbox::TComboBox* const AItems2, Fmxtee::Engine::TChartSeries* const TheSeries, bool AddCurrent);
	Fmxtee::Engine::TTeeFunctionClass __fastcall FunctionClass();
	DYNAMIC void __fastcall Translate();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TFunctionEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Source::TBaseSourceEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFunctionEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Source::TBaseSourceEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFunctionEditor() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Functions */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_FUNCTIONS)
using namespace Fmxtee::Editor::Functions;
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
#endif	// Fmxtee_Editor_FunctionsHPP
