// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Import.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_ImportHPP
#define Fmxtee_Editor_ImportHPP

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
#include <FMX.ComboEdit.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.TreeView.hpp>
#include <FMX.ListBox.hpp>
#include <FMXTee.Chart.hpp>
#include <FMX.Edit.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Procs.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Import
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TImportEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TImportEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Layouts::TLayout* PanelButtons;
	Fmx::Tabcontrol::TTabItem* TabOrigin;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Tabcontrol::TTabItem* TabPreview;
	Fmx::Layouts::TLayout* Layout1;
	Fmx::Stdctrls::TButton* BImport;
	Fmx::Stdctrls::TSpeedButton* BPrevious;
	Fmx::Stdctrls::TSpeedButton* BNext;
	Fmx::Stdctrls::TRadioButton* RGFile;
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Stdctrls::TRadioButton* RGWeb;
	Fmx::Stdctrls::TRadioButton* RGComponent;
	Fmx::Stdctrls::TLabel* LFile;
	Fmx::Comboedit::TComboEdit* CBFile;
	Fmx::Stdctrls::TLabel* LURL;
	Fmx::Comboedit::TComboEdit* CBURL;
	Fmx::Stdctrls::TLabel* LComponent;
	Fmx::Treeview::TTreeView* Tree;
	Fmx::Stdctrls::TSpeedButton* ChooseFile;
	Fmx::Dialogs::TOpenDialog* OpenDialog1;
	Fmxtee::Chart::TChart* PreviewChart;
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall BNextClick(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	void __fastcall BPreviousClick(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall BImportClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBFileChange(System::TObject* Sender);
	void __fastcall CBURLChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ChooseFileClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall RGFileChange(System::TObject* Sender);
	void __fastcall TreeChange(System::TObject* Sender);
	void __fastcall CBFileChangeTracking(System::TObject* Sender);
	void __fastcall CBFileTyping(System::TObject* Sender);
	void __fastcall CBURLChangeTracking(System::TObject* Sender);
	void __fastcall CBURLTyping(System::TObject* Sender);
	
private:
	bool ShouldSaveHistory;
	bool LoadedHistory;
	Fmx::Forms::TCommonCustomForm* ChartEditor;
	void __fastcall ImportTo(Fmxtee::Chart::TCustomChart* const AChart);
	void __fastcall LoadComponents();
	void __fastcall LoadHistory();
	void __fastcall SaveHistory();
	System::Classes::TComponent* __fastcall SelectedComponent();
	void __fastcall ShowHideTabs();
	void __fastcall TryAddHistory(Fmx::Comboedit::TComboEdit* const ACombo);
	
public:
	bool ComponentRuntime;
	Fmxtee::Chart::TCustomChart* Chart;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TImportEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TImportEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TImportEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Import */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_IMPORT)
using namespace Fmxtee::Editor::Import;
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
#endif	// Fmxtee_Editor_ImportHPP
