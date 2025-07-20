// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeGriEd.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeegriedHPP
#define Vcltee_TeegriedHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ExtDlgs.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeSurfa.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeChartGrid.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teegried
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGrid3DSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TGrid3DSeriesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TTimer* Timer1;
	Vcl::Menus::TPopupMenu* PopupMenu1;
	Vcl::Menus::TMenuItem* Invert1;
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Vcl::Dialogs::TSaveDialog* SaveDialog1;
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabGrid;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* LDepth;
	Vcl::Stdctrls::TEdit* SEXGrid;
	Vcl::Comctrls::TUpDown* UDXGrid;
	Vcl::Stdctrls::TEdit* SEZGrid;
	Vcl::Comctrls::TUpDown* UDZGrid;
	Vcl::Stdctrls::TEdit* EDepth;
	Vcl::Comctrls::TUpDown* UDDepth;
	Vcl::Stdctrls::TCheckBox* CBIrreg;
	Vcl::Stdctrls::TButton* BLoad;
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSingle;
	Vcltee::Tecanvas::TButtonColor* BColor;
	Vcl::Stdctrls::TCheckBox* CBColorEach;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TButton* BRemove;
	Vcl::Comctrls::TTabSheet* TabRange;
	Vcltee::Tecanvas::TButtonColor* BFromColor;
	Vcltee::Tecanvas::TButtonColor* BMidColor;
	Vcltee::Tecanvas::TButtonColor* BToColor;
	Vcl::Stdctrls::TCheckBox* CheckBox1;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Comctrls::TTrackBar* TBStart;
	Vcl::Comctrls::TTrackBar* TBMid;
	Vcl::Comctrls::TTrackBar* TBEnd;
	Vcl::Comctrls::TTabSheet* TabPalette;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Buttons::TSpeedButton* SBLoad;
	Vcl::Buttons::TSpeedButton* SBSave;
	Vcl::Buttons::TSpeedButton* SBNew;
	Vcltee::Tecanvas::TComboFlat* CBPalStyle;
	Vcltee::Tecanvas::TComboFlat* CBPalettes;
	Vcl::Stdctrls::TButton* Button4;
	Vcltee::Teechartgrid::TChartGrid* ChartGrid1;
	Vcl::Extctrls::TPanel* PanelSteps;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TEdit* SEPalette;
	Vcl::Comctrls::TUpDown* UDPalette;
	Vcl::Stdctrls::TCheckBox* CBUseMin;
	Vcl::Stdctrls::TEdit* EPaletteMin;
	Vcl::Stdctrls::TEdit* EPaletteStep;
	Vcl::Stdctrls::TEdit* ELegendEvery;
	Vcl::Comctrls::TUpDown* UDLegendEvery;
	Vcl::Stdctrls::TCheckBox* CBAutoStep;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall SEZGridChange(System::TObject* Sender);
	void __fastcall SEPaletteChange(System::TObject* Sender);
	void __fastcall EDepthChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBIrregClick(System::TObject* Sender);
	void __fastcall CBPalStyleChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall CBUseMinClick(System::TObject* Sender);
	void __fastcall EPaletteMinChange(System::TObject* Sender);
	void __fastcall EPaletteStepChange(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall CheckBox1Click(System::TObject* Sender);
	void __fastcall BMidColorClick(System::TObject* Sender);
	void __fastcall ELegendEveryChange(System::TObject* Sender);
	void __fastcall BRemoveClick(System::TObject* Sender);
	void __fastcall Timer1Timer(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall CBPalettesChange(System::TObject* Sender);
	void __fastcall ChartGrid1ChangeColor(System::TObject* Sender);
	void __fastcall ChartGrid1EditingCell(Vcltee::Teechartgrid::TCustomChartGrid* Sender, int ACol, int ARow, bool &Allow);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall Invert1Click(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall SBSaveClick(System::TObject* Sender);
	void __fastcall SBLoadClick(System::TObject* Sender);
	void __fastcall TBStartChange(System::TObject* Sender);
	void __fastcall TBMidChange(System::TObject* Sender);
	void __fastcall TBEndChange(System::TObject* Sender);
	void __fastcall BLoadClick(System::TObject* Sender);
	void __fastcall CBAutoStepClick(System::TObject* Sender);
	void __fastcall CBColorEachClick(System::TObject* Sender);
	
private:
	Vcltee::Teengine::TChartSeries* PaletteSeries;
	Vcltee::Teesurfa::TCustom3DPaletteSeries* Grid3D;
	void __fastcall CheckAutoStep();
	void __fastcall CheckMidColor();
	bool __fastcall EditGradientColors(System::Uitypes::TColor &AStart, System::Uitypes::TColor &AMid, System::Uitypes::TColor &AEnd, bool HideTabColors);
	void __fastcall RefreshGridSize();
	void __fastcall SetAlphaTrackBars();
	void __fastcall SetCustomPalette();
	void __fastcall UpdatePalette();
	void __fastcall TeeEvent(Vcltee::Teeprocs::TTeeEvent* Event);
	
protected:
	bool Creating;
	
public:
	__classmethod void __fastcall ApplyPalette(Vcltee::Teesurfa::TCustom3DPaletteSeries* const Series, int Index);
	void __fastcall RefreshControls(Vcltee::Teesurfa::TCustom3DPaletteSeries* const AGrid);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TGrid3DSeriesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TGrid3DSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TGrid3DSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGrid3DSeriesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
private:
	void *__ITeeEventListener;	// Vcltee::Teeprocs::ITeeEventListener 
	
public:
	operator Vcltee::Teeprocs::ITeeEventListener*(void) { return (Vcltee::Teeprocs::ITeeEventListener*)&__ITeeEventListener; }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Vcl::Forms::TCustomForm* __fastcall TeeInsertGrid3DForm(Vcl::Controls::TControl* const AParent, Vcltee::Teesurfa::TCustom3DPaletteSeries* const AGrid3D);
}	/* namespace Teegried */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEGRIED)
using namespace Vcltee::Teegried;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeegriedHPP
