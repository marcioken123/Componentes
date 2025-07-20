// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.SubChart.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Tools_SubchartHPP
#define Fmxtee_Editor_Tools_SubchartHPP

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
#include <FMX.ListBox.hpp>
#include <System.UIConsts.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMXTee.Tools.SubChart.hpp>
#include <FMX.Edit.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Layouts.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Subchart
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSubChartEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TSubChartEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabPosition;
	Fmx::Tabcontrol::TTabItem* TabChart;
	Fmx::Stdctrls::TCheckBox* CBTransp;
	Fmx::Spinbox::TSpinBox* UDLeft;
	Fmx::Spinbox::TSpinBox* UDTop;
	Fmx::Stdctrls::TLabel* LTop;
	Fmx::Stdctrls::TLabel* LLeft;
	Fmx::Stdctrls::TLabel* LWidth;
	Fmx::Spinbox::TSpinBox* UDWidth;
	Fmx::Stdctrls::TLabel* LHeight;
	Fmx::Spinbox::TSpinBox* UDHeight;
	Fmx::Stdctrls::TCheckBox* CBAllowDrag;
	Fmx::Stdctrls::TCheckBox* CBAllowResize;
	Fmx::Stdctrls::TPanel* Panel1;
	Fmx::Stdctrls::TPanel* Panel2;
	Fmx::Stdctrls::TButton* BAdd;
	Fmx::Stdctrls::TButton* BDelete;
	Fmx::Stdctrls::TButton* BRename;
	Fmx::Stdctrls::TPanel* Panel3;
	Fmx::Stdctrls::TPanel* Panel4;
	Fmx::Stdctrls::TPanel* Panel5;
	Fmx::Listbox::TListBox* LBCharts;
	Fmx::Stdctrls::TButton* BUp;
	Fmx::Stdctrls::TButton* BDown;
	Fmx::Stdctrls::TCheckBox* CBVisible;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall UDLeftChange(System::TObject* Sender);
	void __fastcall UDTopChange(System::TObject* Sender);
	void __fastcall UDWidthChange(System::TObject* Sender);
	void __fastcall UDHeightChange(System::TObject* Sender);
	void __fastcall CBTranspChange(System::TObject* Sender);
	void __fastcall BAddClick(System::TObject* Sender);
	void __fastcall BDeleteClick(System::TObject* Sender);
	void __fastcall BUpClick(System::TObject* Sender);
	void __fastcall BDownClick(System::TObject* Sender);
	void __fastcall BRenameClick(System::TObject* Sender);
	void __fastcall CBAllowDragChange(System::TObject* Sender);
	void __fastcall CBAllowResizeChange(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	void __fastcall LBChartsChange(System::TObject* Sender);
	void __fastcall CBVisibleChange(System::TObject* Sender);
	
private:
	Fmxtee::Tools::Subchart::TSubChartTool* SubChart;
	Fmx::Forms::TForm* IChartPanel;
	Fmxtee::Tools::Subchart::TSubChart* __fastcall CurrentChart();
	System::UnicodeString __fastcall CurrentChartName();
	void __fastcall SwapChart(int A, int B);
	void __fastcall EnableButtons();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSubChartEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSubChartEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSubChartEditor() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Subchart */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_SUBCHART)
using namespace Fmxtee::Editor::Tools::Subchart;
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
#endif	// Fmxtee_Editor_Tools_SubchartHPP
