// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeMapSeriesEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeemapserieseditHPP
#define Vcltee_TeemapserieseditHPP

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
#include <Vcl.Grids.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeMapSeries.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeChartGrid.hpp>
#include <VCLTee.TeeLisB.hpp>
#include <VCLTee.TeeNavigator.hpp>
#include <VCLTee.TeeBrushDlg.hpp>
#include <VCLTee.TeeEdiGrad.hpp>
#include <VCLTee.TeeGDIPlus.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeeDragPoint.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teemapseriesedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TMapSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TMapSeriesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Comctrls::TTabSheet* TabGlobal;
	Vcl::Comctrls::TTabSheet* TabShapes;
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabFormat;
	Vcl::Stdctrls::TCheckBox* CBGlobalPen;
	Vcl::Stdctrls::TCheckBox* CBGlobalBrush;
	Vcl::Comctrls::TTabSheet* TabData;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Extctrls::TPanel* Panel1;
	Vcltee::Tecanvas::TButtonColor* ButtonColor1;
	Vcltee::Teelisb::TChartListBox* ChartListBox1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Buttons::TSpeedButton* SBDelete;
	Vcl::Buttons::TSpeedButton* SBAdd;
	Vcl::Stdctrls::TCheckBox* CBDefaultColor;
	Vcl::Stdctrls::TCheckBox* CBClosed;
	Vcl::Comctrls::TTabSheet* TabValues;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* EText;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* EditZ;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* ShapeIndex;
	Vcl::Stdctrls::TCheckBox* CBVisible;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Comctrls::TTabSheet* TabShadow;
	Vcl::Comctrls::TTabSheet* TabEmboss;
	Vcl::Comctrls::TPageControl* PageOptions;
	Vcl::Comctrls::TTabSheet* TabOptions;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabPattern;
	Vcl::Comctrls::TTrackBar* TBShapeTransp;
	Vcl::Comctrls::TTabSheet* TabShapeBorder;
	Vcl::Comctrls::TTabSheet* TabShapePattern;
	Vcl::Comctrls::TPageControl* PageControl4;
	Vcl::Comctrls::TTabSheet* TabChartPoints;
	Vcl::Comctrls::TTabSheet* TabPoints;
	Vcltee::Teechartgrid::TChartGrid* ChartGrid1;
	Vcltee::Teechartgrid::TChartGridNavigator* ChartGridNavigator1;
	Vcltee::Chart::TChart* Chart1;
	Vcltee::Series::TLineSeries* Series1;
	Vcltee::Teetools::TMarksTipTool* ChartTool1;
	Vcltee::Teedragpoint::TDragPointTool* ChartTool2;
	Vcl::Stdctrls::TCheckBox* CBSort;
	Vcl::Stdctrls::TLabel* LCode;
	Vcl::Stdctrls::TEdit* ECode;
	Vcl::Comctrls::TTabSheet* TabPointer;
	Vcl::Comctrls::TTabSheet* TabMapMarks;
	Vcltee::Tecanvas::TComboFlat* CBMarksStyle;
	Vcl::Stdctrls::TCheckBox* CBMarksAutoSize;
	Vcl::Stdctrls::TCheckBox* CBMarksUpper;
	Vcl::Stdctrls::TCheckBox* CBMarksCentroid;
	Vcl::Comctrls::TTabSheet* TabLegend;
	Vcl::Stdctrls::TCheckBox* CBIncludeZero;
	Vcl::Stdctrls::TCheckBox* CBAutoTextColor;
	Vcl::Stdctrls::TGroupBox* GBLegendSort;
	Vcl::Extctrls::TRadioGroup* RGLegendSort;
	Vcl::Stdctrls::TCheckBox* CBLegendSort;
	Vcl::Stdctrls::TCheckBox* CBIncludeUnnamed;
	Vcl::Stdctrls::TCheckBox* CBMarksVisible;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TLabel* LParentShape;
	Vcl::Extctrls::TPanel* PanelShapesTop;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TLabel* LShapeCount;
	Vcl::Extctrls::TPanel* PanelLeft;
	Vcl::Extctrls::TPanel* PanelOptions;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TCheckBox* CBTransp;
	Vcl::Stdctrls::TEdit* EPointSize;
	Vcl::Comctrls::TTrackBar* TBTransp;
	Vcltee::Tecanvas::TComboFlat* CBRenderMode;
	Vcltee::Tecanvas::TComboFlat* CBPointUnits;
	Vcltee::Tecanvas::TComboFlat* CBLegendStyle;
	Vcl::Stdctrls::TLabel* LLegendStyle;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Stdctrls::TGroupBox* GBOffset;
	Vcl::Stdctrls::TLabel* LHorizOffset;
	Vcl::Comctrls::TTrackBar* TBHorizOffset;
	Vcl::Stdctrls::TLabel* LVertOffset;
	Vcl::Comctrls::TTrackBar* TBVertOffset;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ETextChange(System::TObject* Sender);
	void __fastcall ChartListBox1Click(System::TObject* Sender);
	void __fastcall CBGlobalPenClick(System::TObject* Sender);
	void __fastcall CBGlobalBrushClick(System::TObject* Sender);
	void __fastcall EditZChange(System::TObject* Sender);
	void __fastcall ButtonColor1Click(System::TObject* Sender);
	void __fastcall PageControl2Change(System::TObject* Sender);
	void __fastcall SBDeleteClick(System::TObject* Sender);
	void __fastcall SBAddClick(System::TObject* Sender);
	void __fastcall ChartGrid1SetEditText(System::TObject* Sender, int ACol, int ARow, const System::UnicodeString Value);
	void __fastcall ChartListBox1ChangeColor(Vcltee::Teelisb::TChartListBox* Sender, Vcltee::Teengine::TCustomChartSeries* Series);
	void __fastcall CBDefaultColorClick(System::TObject* Sender);
	void __fastcall CBClosedClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBVisibleClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall ChartListBox1ChangeActive(Vcltee::Teelisb::TChartListBox* Sender, Vcltee::Teengine::TCustomChartSeries* Series);
	void __fastcall CBTranspClick(System::TObject* Sender);
	void __fastcall EPointSizeChange(System::TObject* Sender);
	void __fastcall PageOptionsChange(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	void __fastcall TBShapeTranspChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall CBRenderModeChange(System::TObject* Sender);
	void __fastcall ChartTool2DragPoint(Vcltee::Teedragpoint::TDragPointTool* Sender, int Index);
	void __fastcall CBSortClick(System::TObject* Sender);
	void __fastcall ECodeChange(System::TObject* Sender);
	void __fastcall CBMarksStyleChange(System::TObject* Sender);
	void __fastcall CBMarksAutoSizeClick(System::TObject* Sender);
	void __fastcall CBMarksUpperClick(System::TObject* Sender);
	void __fastcall CBMarksCentroidClick(System::TObject* Sender);
	void __fastcall CBPointUnitsChange(System::TObject* Sender);
	void __fastcall CBIncludeZeroClick(System::TObject* Sender);
	void __fastcall CBAutoTextColorClick(System::TObject* Sender);
	void __fastcall CBLegendSortClick(System::TObject* Sender);
	void __fastcall RGLegendSortClick(System::TObject* Sender);
	void __fastcall CBIncludeUnnamedClick(System::TObject* Sender);
	void __fastcall CBMarksVisibleClick(System::TObject* Sender);
	void __fastcall LParentShapeClick(System::TObject* Sender);
	void __fastcall CBLegendStyleChange(System::TObject* Sender);
	void __fastcall TBHorizOffsetChange(System::TObject* Sender);
	void __fastcall TBVertOffsetChange(System::TObject* Sender);
	
private:
	bool ChangingColor;
	bool ChangingText;
	Vcl::Forms::TCustomForm* Grid3DForm;
	Vcltee::Teependlg::TPenDialog* IShapeBorder;
	Vcltee::Teebrushdlg::TBrushDialog* IShapePattern;
	void __fastcall CheckDefaultColor();
	void __fastcall ClearButtonColorLink();
	void __fastcall EnableTabs();
	void __fastcall FillShapes();
	void __fastcall InitializeShapesListBox();
	Vcltee::Teemapseries::TTeePolygon* __fastcall SelectedShape();
	
protected:
	Vcltee::Teemapseries::TMapSeries* Map;
	bool DirtyList;
	
public:
	System::TObject* InitialShape;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TMapSeriesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TMapSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TMapSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TMapSeriesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teemapseriesedit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEMAPSERIESEDIT)
using namespace Vcltee::Teemapseriesedit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeemapserieseditHPP
