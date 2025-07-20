// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Themes.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_ThemesHPP
#define Fmxtee_Editor_ThemesHPP

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
#include <FMX.TabControl.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Controls3D.hpp>
#include <FMX.Viewport3D.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.Grid.hpp>
#include <FMX.Layouts.hpp>
#include <FMXTee.Chart.Grid.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Chart.hpp>
#include <FMX.Types3D.hpp>
#include <FMXTee.Chart3D.hpp>
#include <FMX.Objects.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Themes
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TChartThemeSelector;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TChartThemeSelector : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TPanel* Panel1;
	Fmx::Stdctrls::TCheckBox* CheckBox1;
	Fmx::Stdctrls::TPanel* PanelButtons;
	Fmx::Stdctrls::TButton* BOk;
	Fmx::Stdctrls::TButton* BCancel;
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabItem1;
	Fmx::Tabcontrol::TTabControl* TabControlPreview;
	Fmx::Stdctrls::TSplitter* Splitter1;
	Fmx::Tabcontrol::TTabItem* TabPreview;
	Fmx::Tabcontrol::TTabItem* TabPalette;
	Fmxtee::Chart::TChart* PreviewChart2D;
	Fmx::Listbox::TListBox* LBThemes;
	Fmx::Viewport3d::TViewport3D* Viewport3D1;
	Fmxtee::Chart::TChart* Chart3DChart1;
	Fmxtee::Chart3d::TChart3D* PreviewChart3D;
	Fmx::Listbox::TListBox* LBPalette;
	Fmxtee::Chart::Grid::TChartGrid* ChartGrid1;
	Fmx::Stdctrls::TSplitter* Splitter2;
	Fmx::Tabcontrol::TTabItem* TabFonts;
	Fmx::Listbox::TListBox* LBFonts;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Stdctrls::TButton* Button1;
	Fmx::Stdctrls::TButton* Button2;
	Fmx::Tabcontrol::TTabItem* TabColors;
	Fmx::Listbox::TListBox* LBColors;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TTrackBar* TBOffset;
	Fmx::Objects::TPaintBox* PaintColors;
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall TabControlPreviewChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall CheckBox1Change(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall BOkClick(System::TObject* Sender);
	void __fastcall LBThemesChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall LBPaletteChange(System::TObject* Sender);
	void __fastcall LBFontsChange(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall LBColorsChange(System::TObject* Sender);
	void __fastcall TBOffsetChange(System::TObject* Sender);
	void __fastcall PaintColorsPaint(System::TObject* Sender, Fmx::Graphics::TCanvas* Canvas);
	
private:
	Fmxtee::Chart::TCustomChart* Chart;
	Fmxtee::Chart::TCustomChart* PreviewChart;
	Fmxtee::Engine::TChartSeries* PaletteSeries;
	Fmxtee::Procs::TColorArray ICurrentColors;
	bool IChangingFonts;
	bool IChangingColors;
	void __fastcall ApplyScheme(const Fmxtee::Procs::TColorArray AColors);
	void __fastcall InitPreviewChart();
	void __fastcall RefreshColorGrid();
	Fmxtee::Chart::TChartThemeClass __fastcall SelectedTheme();
	
public:
	bool AutoApply;
	__classmethod bool __fastcall Choose(System::Classes::TComponent* AOwner, Fmxtee::Chart::TCustomChart* AChart);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TChartThemeSelector(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TChartThemeSelector(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TChartThemeSelector() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Themes */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_THEMES)
using namespace Fmxtee::Editor::Themes;
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
#endif	// Fmxtee_Editor_ThemesHPP
