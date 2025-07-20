// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeThemeEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeethemeeditorHPP
#define Vcltee_TeethemeeditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.Menus.hpp>
#include <VCLTee.TeeGDIPlus.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeThemes.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeDraw3D.hpp>
#include <VCLTee.TeeChartGrid.hpp>
#include <VCLTee.TeeGalleryPanel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teethemeeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TChartThemeSelector;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TChartThemeSelector : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabPreview;
	Vcltee::Chart::TChart* PreviewChart;
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Extctrls::TPanel* PanelBottom;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TButton* BOK;
	Vcl::Stdctrls::TButton* Button2;
	Vcltee::Teetools::TRotateTool* ChartTool1;
	Vcltee::Teedraw3d::TDraw3D* ScaledChart;
	Vcl::Comctrls::TTabSheet* TabPalette;
	Vcltee::Teechartgrid::TChartGrid* ChartGrid1;
	Vcl::Stdctrls::TButton* BSaveAs;
	Vcl::Buttons::TSpeedButton* SpeedView;
	Vcl::Menus::TPopupMenu* PopupView;
	Vcl::Menus::TMenuItem* CBView3D;
	Vcl::Menus::TMenuItem* CBScale;
	Vcl::Extctrls::TPanel* Panel5;
	Vcl::Comctrls::TTabSheet* TabGallery;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcltee::Teegallerypanel::TChartGalleryPanel* ChartGalleryPanel1;
	Vcl::Comctrls::TTreeView* LBThemes;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TListBox* LBPalette;
	Vcl::Extctrls::TSplitter* Splitter2;
	Vcl::Comctrls::TTabSheet* TabFonts;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TListBox* LBFonts;
	Vcl::Extctrls::TPanel* Panel6;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Comctrls::TTabSheet* TabColors;
	Vcl::Extctrls::TPanel* Panel7;
	Vcl::Extctrls::TPanel* Panel8;
	Vcl::Stdctrls::TListBox* LBColors;
	Vcl::Buttons::TSpeedButton* SBFontUp;
	Vcl::Buttons::TSpeedButton* SBFontDown;
	Vcl::Extctrls::TPanel* Panel9;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Extctrls::TPanel* Panel10;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Comctrls::TTrackBar* TBOffset;
	Vcl::Extctrls::TPanel* Panel11;
	void __fastcall LBThemesClick(System::TObject* Sender);
	void __fastcall BOKClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ScaledChartAfterDraw(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall ChartGrid1ChangeColor(System::TObject* Sender);
	void __fastcall BSaveAsClick(System::TObject* Sender);
	void __fastcall SpeedViewMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall CBScaleClick(System::TObject* Sender);
	void __fastcall CBView3DClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ChartGalleryPanel1ChangeChart(System::TObject* Sender);
	void __fastcall ChartGalleryPanel1SelectedChart(System::TObject* Sender);
	void __fastcall LBPaletteClick(System::TObject* Sender);
	void __fastcall LBFontsClick(System::TObject* Sender);
	void __fastcall LBColorsClick(System::TObject* Sender);
	void __fastcall LBColorsDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall LBFontsDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall LBFontsMeasureItem(Vcl::Controls::TWinControl* Control, int Index, int &Height);
	void __fastcall SBFontUpClick(System::TObject* Sender);
	void __fastcall SBFontDownClick(System::TObject* Sender);
	void __fastcall LBColorsDblClick(System::TObject* Sender);
	void __fastcall TBOffsetChange(System::TObject* Sender);
	
private:
	Vcl::Comctrls::TTreeNode* IBasic;
	Vcl::Comctrls::TTreeNode* ICustom;
	Vcltee::Teengine::TChartSeries* PaletteSeries;
	Vcltee::Teeprocs::TColorArray ICurrentColors;
	bool IChangingColors;
	bool IChangingFonts;
	bool ISelecting;
	void __fastcall AddToGallery(Vcl::Comctrls::TTreeNode* const AItem);
	void __fastcall ApplyScheme(const Vcltee::Teeprocs::TColorArray AColors);
	void __fastcall ApplyThemeTo(Vcl::Comctrls::TTreeNode* const AItem, Vcltee::Chart::TCustomChart* const AChart);
	void __fastcall CheckScale();
	void __fastcall CreatePreview(Vcltee::Chart::TCustomChart* const AChart, Vcl::Comctrls::TTreeNode* const AItem = (Vcl::Comctrls::TTreeNode*)(0x0));
	void __fastcall InitPreviewChart();
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Winapi::Messages::TMessage &Message);
	void __fastcall RecreateGallery();
	void __fastcall RefreshColorGrid();
	void __fastcall SelectAtGallery();
	
public:
	Vcltee::Chart::TCustomChart* Chart;
	bool AutoApply;
	__classmethod TChartThemeSelector* __fastcall CreateEditor(System::Classes::TComponent* const AOwner, Vcltee::Teeprocs::TCustomTeePanel* const APanel);
	Vcltee::Chart::TChartThemeClass __fastcall SelectedTheme();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TChartThemeSelector(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TChartThemeSelector(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TChartThemeSelector() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TChartThemeSelector(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall AddChartThemes(System::Classes::TStrings* const Items);
extern DELPHI_PACKAGE Vcltee::Chart::TChartThemeClass __fastcall ChartThemeSelector(Vcltee::Chart::TCustomChart* const AChart);
extern DELPHI_PACKAGE void __fastcall ShowThemesEditor(bool Value);
}	/* namespace Teethemeeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEETHEMEEDITOR)
using namespace Vcltee::Teethemeeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeethemeeditorHPP
