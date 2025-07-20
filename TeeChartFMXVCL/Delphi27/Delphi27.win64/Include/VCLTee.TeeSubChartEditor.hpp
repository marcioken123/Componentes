// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeSubChartEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeesubcharteditorHPP
#define Vcltee_TeesubcharteditorHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.TeeSubChart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teesubcharteditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSubChartEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSubChartEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TListBox* LBCharts;
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabPosition;
	Vcl::Comctrls::TTabSheet* TabChart;
	Vcl::Stdctrls::TLabel* LLeft;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* UDLeft;
	Vcl::Stdctrls::TLabel* LTop;
	Vcl::Stdctrls::TEdit* Edit2;
	Vcl::Comctrls::TUpDown* UDTop;
	Vcl::Stdctrls::TLabel* LWidth;
	Vcl::Stdctrls::TEdit* Edit3;
	Vcl::Comctrls::TUpDown* UDWidth;
	Vcl::Stdctrls::TLabel* LHeight;
	Vcl::Stdctrls::TEdit* Edit4;
	Vcl::Comctrls::TUpDown* UDHeight;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Buttons::TSpeedButton* BUp;
	Vcl::Buttons::TSpeedButton* BDown;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Extctrls::TPanel* Panel5;
	Vcl::Stdctrls::TCheckBox* CBTransp;
	Vcl::Stdctrls::TCheckBox* CBAllowDrag;
	Vcl::Stdctrls::TCheckBox* CBAllowResize;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Stdctrls::TCheckBox* CBVisible;
	Vcl::Buttons::TSpeedButton* BAdd;
	Vcl::Buttons::TSpeedButton* BDelete;
	Vcl::Buttons::TSpeedButton* BClone;
	Vcl::Buttons::TSpeedButton* BRename;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall LBChartsClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall BAddClick(System::TObject* Sender);
	void __fastcall BDeleteClick(System::TObject* Sender);
	void __fastcall BUpClick(System::TObject* Sender);
	void __fastcall BDownClick(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall Edit2Change(System::TObject* Sender);
	void __fastcall Edit3Change(System::TObject* Sender);
	void __fastcall Edit4Change(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall BRenameClick(System::TObject* Sender);
	void __fastcall CBTranspClick(System::TObject* Sender);
	void __fastcall CBAllowDragClick(System::TObject* Sender);
	void __fastcall CBAllowResizeClick(System::TObject* Sender);
	void __fastcall CBVisibleClick(System::TObject* Sender);
	void __fastcall BCloneClick(System::TObject* Sender);
	
private:
	Vcltee::Teeedit::TChartEditorPanel* ChartEditor;
	Vcltee::Teesubchart::TSubChart* __fastcall CurrentChart();
	System::UnicodeString __fastcall CurrentChartName();
	void __fastcall EnableButtons();
	void __fastcall SwapChart(int A, int B);
	
protected:
	Vcltee::Teesubchart::TSubChartTool* Tool;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSubChartEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSubChartEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSubChartEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TSubChartEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teesubcharteditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESUBCHARTEDITOR)
using namespace Vcltee::Teesubcharteditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeesubcharteditorHPP
