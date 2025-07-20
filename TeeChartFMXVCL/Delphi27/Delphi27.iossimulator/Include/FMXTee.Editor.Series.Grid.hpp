// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Grid.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Editor_Series_GridHPP
#define Fmxtee_Editor_Series_GridHPP

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
#include <FMXTee.RadioGroup.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMX.TabControl.hpp>
#include <FMXTee.Series.Surface.hpp>
#include <FMX.Edit.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Colors.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Procs.hpp>
#include <FMX.Grid.hpp>
#include <FMX.Layouts.hpp>
#include <FMXTee.Chart.Grid.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Grid
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGrid3DSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TGrid3DSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabSingle;
	Fmx::Tabcontrol::TTabItem* TabRange;
	Fmx::Tabcontrol::TTabItem* TabPalette;
	Fmx::Stdctrls::TPanel* Panel1;
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Spinbox::TSpinBox* UDXGrid;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Spinbox::TSpinBox* UDZGrid;
	Fmx::Stdctrls::TLabel* Label7;
	Fmx::Spinbox::TSpinBox* UDDepth;
	Fmx::Stdctrls::TLabel* Label8;
	Fmx::Stdctrls::TCheckBox* CBIrreg;
	Fmx::Colors::TComboColorBox* BColor;
	Fmx::Stdctrls::TButton* BRemove;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Colors::TComboColorBox* BFromColor;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Colors::TComboColorBox* BMidColor;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Colors::TComboColorBox* BToColor;
	Fmx::Stdctrls::TLabel* Label9;
	Fmx::Stdctrls::TCheckBox* CBNoMiddle;
	Fmx::Stdctrls::TButton* BSwap;
	Fmx::Stdctrls::TButton* BGallery;
	Fmx::Tabcontrol::TTabControl* TabControl2;
	Fmx::Tabcontrol::TTabItem* TabSteps;
	Fmx::Tabcontrol::TTabItem* TabColors;
	Fmx::Spinbox::TSpinBox* UDPalette;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TCheckBox* CBUseMin;
	Fmx::Stdctrls::TLabel* Label10;
	Fmx::Edit::TEdit* EPaletteMin;
	Fmx::Edit::TEdit* EPaletteStep;
	Fmx::Stdctrls::TLabel* Label11;
	Fmx::Spinbox::TSpinBox* UDLegendEvery;
	Fmx::Stdctrls::TLabel* Label12;
	Fmx::Stdctrls::TPanel* Panel2;
	Fmx::Listbox::TComboBox* CBPalStyle;
	Fmx::Listbox::TListBoxItem* ListBoxItem1;
	Fmx::Listbox::TListBoxItem* ListBoxItem2;
	Fmx::Listbox::TListBoxItem* ListBoxItem3;
	Fmx::Listbox::TListBoxItem* ListBoxItem4;
	Fmx::Listbox::TListBoxItem* ListBoxItem5;
	Fmx::Listbox::TListBoxItem* ListBoxItem6;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Stdctrls::TLabel* Label13;
	Fmx::Listbox::TComboBox* CBPalettes;
	Fmx::Stdctrls::TButton* BInvert;
	Fmx::Stdctrls::TCheckBox* CBColorEach;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBPalStyleChange(System::TObject* Sender);
	void __fastcall BInvertClick(System::TObject* Sender);
	void __fastcall BColorChange(System::TObject* Sender);
	void __fastcall BFromColorChange(System::TObject* Sender);
	void __fastcall BMidColorChange(System::TObject* Sender);
	void __fastcall BToColorChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall UDZGridChange(System::TObject* Sender);
	void __fastcall UDDepthChange(System::TObject* Sender);
	void __fastcall UDPaletteChange(System::TObject* Sender);
	void __fastcall CBIrregChange(System::TObject* Sender);
	void __fastcall CBPalettesChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	void __fastcall CBUseMinChange(System::TObject* Sender);
	void __fastcall EPaletteMinChange(System::TObject* Sender);
	void __fastcall EPaletteStepChange(System::TObject* Sender);
	void __fastcall BSwapClick(System::TObject* Sender);
	void __fastcall CBNoMiddleChange(System::TObject* Sender);
	void __fastcall UDLegendEveryChange(System::TObject* Sender);
	void __fastcall BRemoveClick(System::TObject* Sender);
	void __fastcall BGalleryClick(System::TObject* Sender);
	void __fastcall CBColorEachChange(System::TObject* Sender);
	
private:
	Fmxtee::Chart::Grid::TChartGrid* FChartGrid;
	Fmxtee::Engine::TChartSeries* PaletteSeries;
	Fmxtee::Series::Surface::TCustom3DPaletteSeries* Grid3D;
	bool IChangingColor;
	void __fastcall CheckMidColor();
	void __fastcall SetCustomPalette();
	void __fastcall UpdatePalette();
	bool __fastcall EditGradientColors(System::Uitypes::TAlphaColor &AStart, System::Uitypes::TAlphaColor &AMid, System::Uitypes::TAlphaColor &AEnd, bool HideTabColors);
	void __fastcall ChartGridEditingCell(Fmxtee::Chart::Grid::TCustomChartGrid* Sender, int ACol, int ARow, bool &Allow);
	void __fastcall ChartGridChangeColor(System::TObject* Sender);
	
protected:
	bool Creating;
	void __fastcall TeeEvent(Fmxtee::Procs::TTeeEvent* Event);
	
public:
	__classmethod void __fastcall ApplyPalette(Fmxtee::Series::Surface::TCustom3DPaletteSeries* const Series, int Index);
	__classmethod Fmx::Forms::TForm* __fastcall CreateEmbedd(System::Classes::TComponent* const AOwner, Fmxtee::Series::Surface::TCustom3DPaletteSeries* const AGrid3D, Fmx::Types::TFmxObject* const AParent);
	void __fastcall RefreshControls(Fmxtee::Series::Surface::TCustom3DPaletteSeries* const AGrid);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TGrid3DSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TGrid3DSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TGrid3DSeriesEditor() { }
	
private:
	void *__ITeeEventListener;	// Fmxtee::Procs::ITeeEventListener 
	
public:
	operator Fmxtee::Procs::ITeeEventListener*(void) { return (Fmxtee::Procs::ITeeEventListener*)&__ITeeEventListener; }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Grid */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_GRID)
using namespace Fmxtee::Editor::Series::Grid;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES)
using namespace Fmxtee::Editor::Series;
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
#endif	// Fmxtee_Editor_Series_GridHPP
