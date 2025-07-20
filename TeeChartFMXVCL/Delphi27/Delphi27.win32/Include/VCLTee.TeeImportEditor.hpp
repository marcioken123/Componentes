// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeImportEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeimporteditorHPP
#define Vcltee_TeeimporteditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeeImport.hpp>
#include <VCLTee.Chart.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeeGDIPlus.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <Vcl.CheckLst.hpp>
#include <VCLTee.TeeLisB.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeimporteditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TImportEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TImportEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabOrigin;
	Vcl::Extctrls::TPanel* PanelButtons;
	Vcl::Extctrls::TRadioGroup* RGOrigin;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TButton* BImport;
	Vcl::Buttons::TSpeedButton* BPrevious;
	Vcl::Buttons::TSpeedButton* BNext;
	Vcl::Comctrls::TTabSheet* TabOptions;
	Vcl::Comctrls::TTabSheet* TabPreview;
	Vcltee::Chart::TChart* PreviewChart;
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Vcl::Extctrls::TPanel* PanelFile;
	Vcl::Stdctrls::TLabel* LFile;
	Vcl::Stdctrls::TComboBox* CBFile;
	Vcl::Buttons::TSpeedButton* ChooseFile;
	Vcl::Extctrls::TPanel* PanelWeb;
	Vcl::Stdctrls::TLabel* LURL;
	Vcl::Stdctrls::TComboBox* CBURL;
	Vcl::Extctrls::TPanel* PanelComponent;
	Vcl::Stdctrls::TLabel* LComponent;
	Vcl::Comctrls::TTreeView* Tree;
	Vcl::Extctrls::TPanel* PanelOptions;
	Vcl::Stdctrls::TButton* BAnalyze;
	Vcl::Extctrls::TPanel* PanelSelected;
	Vcltee::Teelisb::TChartListBox* CBSeries;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Extctrls::TPanel* FormatOptions;
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall BNextClick(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall BPreviousClick(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall BImportClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBFileChange(System::TObject* Sender);
	void __fastcall CBURLChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ChooseFileClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall RGOriginClick(System::TObject* Sender);
	void __fastcall TreeChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall BAnalyzeClick(System::TObject* Sender);
	void __fastcall CBSeriesChangeActive(Vcltee::Teelisb::TChartListBox* Sender, Vcltee::Teengine::TCustomChartSeries* Series);
	
private:
	bool ShouldSaveHistory;
	bool LoadedHistory;
	Vcl::Forms::TCustomForm* ChartEditor;
	Vcltee::Teeimport::TDataImport* FImport;
	int Origin_Component;
	void __fastcall FillOptions();
	void __fastcall LoadComponents();
	void __fastcall LoadHistory();
	void __fastcall SaveHistory();
	int __fastcall Origin_Clipboard();
	System::Classes::TComponent* __fastcall SelectedComponent();
	void __fastcall ShowHideTabs();
	void __fastcall TryAddHistory(Vcl::Stdctrls::TComboBox* const ACombo);
	
public:
	bool ComponentRuntime;
	Vcltee::Chart::TCustomChart* Chart;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TImportEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TImportEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TImportEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TImportEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeimporteditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEIMPORTEDITOR)
using namespace Vcltee::Teeimporteditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeimporteditorHPP
