// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDChartEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdcharteditordlgHPP
#define PlmdcharteditordlgHPP

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
#include <Vcl.ExtDlgs.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDChart.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.Buttons.hpp>
#include <System.Variants.hpp>
#include <LMDUnicodeStrings.hpp>
#include <pLMDMarginsEditor.hpp>
#include <LMDShSpinEdit.hpp>
#include <pLMDAlignmentEditor.hpp>
#include <LMDChartCTAreaSpline3D.hpp>
#include <LMDChartCTAreaSpline.hpp>
#include <LMDChartCTAreaLine3D.hpp>
#include <LMDChartCTAreaLine.hpp>
#include <LMDChartCTDoughnut.hpp>
#include <LMDChartCTPie2D.hpp>
#include <LMDChartCTBar3D.hpp>
#include <LMDChartCTBar.hpp>
#include <LMDChartCTColumn3D.hpp>
#include <LMDChartTypes.hpp>
#include <LMDChartCTColumn.hpp>
#include <LMDCustomComponent.hpp>
#include <pLMDDistanceAndPositionDlg.hpp>
#include <pLMDLineEditorDlg.hpp>
#include <pLMDAreaFillEditor.hpp>
#include <LMDChartLegend.hpp>
#include <LMDChartBackground.hpp>
#include <LMDChartLine.hpp>
#include <LMDChartAxis.hpp>
#include <LMDChartTitleBox.hpp>
#include <LMDChartUtils.hpp>
#include <LMDChartSeries.hpp>
#include <LMDChartSeriesCollection.hpp>
#include <LMDChartValuesBase.hpp>
#include <pLMDAddSeriesDlg.hpp>
#include <pLMDChartValuesOptionsSelDlg.hpp>
#include <LMDControl.hpp>
#include <LMDCustomControl.hpp>
#include <LMDTypes.hpp>
#include <LMDUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdcharteditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDChartEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* plChartPreview;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TButton* btOK;
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* tsChartType;
	Vcl::Comctrls::TTabSheet* tsChartData;
	Vcl::Comctrls::TTabSheet* tsOptions;
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Comctrls::TTabSheet* isGeneral;
	Vcl::Comctrls::TTabSheet* tsAxis;
	Vcl::Comctrls::TTabSheet* tsLegend;
	Vcl::Comctrls::TTabSheet* tsTitleBox;
	Vcl::Stdctrls::TCheckBox* chbShowLegend;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TButton* btLegendEdge;
	Vcl::Stdctrls::TButton* btLegendIndentsDefine;
	Vcl::Stdctrls::TButton* btLegendBackground;
	Vcl::Stdctrls::TButton* btChartBackground;
	Plmdalignmenteditor::TLMDAlignmentEditor* aeLegendAlignment;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TButton* btChartAreaBackground;
	Vcl::Stdctrls::TButton* btEdge;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Plmdmarginseditor::TLMDMarginsEditor* meChartAreaInnerIndents;
	Vcl::Stdctrls::TGroupBox* GroupBox3;
	Plmdmarginseditor::TLMDMarginsEditor* meChartAreaMargins;
	Vcl::Stdctrls::TGroupBox* GroupBox4;
	Vcl::Stdctrls::TCheckBox* chbVerticalGridLines;
	Vcl::Stdctrls::TButton* btMajorVerticalGridLine;
	Vcl::Stdctrls::TGroupBox* GroupBox5;
	Vcl::Stdctrls::TCheckBox* chbHorizontalGridLines;
	Vcl::Stdctrls::TButton* btMajorHorizontalGridLine;
	Vcl::Stdctrls::TCheckBox* chbChartAreaMarkers;
	Vcl::Stdctrls::TGroupBox* GroupBox6;
	Vcl::Stdctrls::TCheckBox* chbChartAreaShadow;
	Vcl::Stdctrls::TButton* btChartAreaShadowColor;
	Vcl::Comctrls::TTrackBar* tbChartAreaShadowTransparency;
	Vcl::Comctrls::TTrackBar* tbChartAreaShadowDepth;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TButton* btLegendFont;
	Vcl::Stdctrls::TCheckBox* chbLegendMayOverlap;
	Vcl::Comctrls::TTrackBar* tbLegendIconSize;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Comctrls::TTrackBar* tbLegendSpaceAfterIcon;
	Vcl::Stdctrls::TLabel* Label11;
	Vcl::Comctrls::TTrackBar* tbLegendIntervalBetweenLines;
	Vcl::Extctrls::TRadioGroup* rgLegendLayout;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TButton* Button3;
	Plmdalignmenteditor::TLMDAlignmentEditor* aeTitleBoxAlignment;
	Plmdalignmenteditor::TLMDAlignmentEditor* aeHeaderIconAlignment;
	Vcl::Stdctrls::TLabel* Label12;
	Vcl::Stdctrls::TEdit* edHeaderText;
	Vcl::Stdctrls::TGroupBox* GroupBox7;
	Plmdmarginseditor::TLMDMarginsEditor* meTitleBoxMargins;
	Vcl::Stdctrls::TLabel* Label13;
	Vcl::Comctrls::TTrackBar* tbTitleBoxChartMargin;
	Vcl::Stdctrls::TLabel* Label14;
	Vcl::Comctrls::TTrackBar* tbTitleBoxEdgeMargin;
	Vcl::Stdctrls::TButton* btHeaderIcon;
	Vcl::Dialogs::TFontDialog* FontDialog1;
	Vcl::Extdlgs::TOpenPictureDialog* OpenPictureDialog1;
	Vcl::Stdctrls::TGroupBox* GroupBox8;
	Vcl::Stdctrls::TButton* btXAxisLine;
	Vcl::Stdctrls::TButton* btXAxisFont;
	Vcl::Extctrls::TRadioGroup* rgXAxisMajorTicks;
	Vcl::Extctrls::TRadioGroup* rgXAxisMinorTicks;
	Vcl::Stdctrls::TLabel* Label15;
	Vcl::Stdctrls::TEdit* edXAxisMajorTickSize;
	Vcl::Stdctrls::TLabel* Label16;
	Vcl::Stdctrls::TEdit* edXAxisMinorTickSize;
	Vcl::Stdctrls::TLabel* Label17;
	Vcl::Stdctrls::TComboBox* cbXAxisValueType;
	Vcl::Stdctrls::TGroupBox* GroupBox9;
	Vcl::Stdctrls::TLabel* Label18;
	Vcl::Stdctrls::TLabel* Label19;
	Vcl::Stdctrls::TLabel* Label20;
	Vcl::Stdctrls::TButton* btYAxisLine;
	Vcl::Stdctrls::TButton* btYAxisFont;
	Vcl::Extctrls::TRadioGroup* rgYAxisMajorTicks;
	Vcl::Extctrls::TRadioGroup* rgYAxisMinorTicks;
	Vcl::Stdctrls::TEdit* edYAxisMajorTickSize;
	Vcl::Stdctrls::TEdit* edYAxisMinorTickSize;
	Vcl::Stdctrls::TComboBox* cbYAxisValueType;
	Vcl::Stdctrls::TEdit* edYAxisMajorStep;
	Vcl::Stdctrls::TEdit* edYAxisMinorStep;
	Vcl::Stdctrls::TLabel* Label21;
	Vcl::Stdctrls::TLabel* Label22;
	Vcl::Comctrls::TPageControl* PageControl4;
	Vcl::Comctrls::TTabSheet* tsChartTypeOptions;
	Vcl::Stdctrls::TGroupBox* GroupBox10;
	Vcl::Dialogs::TColorDialog* ColorDialog1;
	Vcl::Comctrls::TTrackBar* tbCTLabelsXDeviation;
	Vcl::Stdctrls::TLabel* Label23;
	Vcl::Stdctrls::TLabel* Label24;
	Vcl::Stdctrls::TLabel* Label25;
	Vcl::Comctrls::TTrackBar* tbCTLabelsYDeviation;
	Vcl::Comctrls::TTrackBar* tbCTLabelsMargin;
	Vcl::Stdctrls::TCheckBox* chbCTShowLabels;
	Vcl::Stdctrls::TLabel* Label26;
	Vcl::Comctrls::TTrackBar* tbCTTransparency;
	Vcl::Stdctrls::TButton* btCTLabelsBackground;
	Vcl::Stdctrls::TButton* btCTLabelEdges;
	Vcl::Stdctrls::TButton* btCTLabelFont;
	Vcl::Stdctrls::TCheckBox* chbCTShowLabelsBackground;
	Vcl::Stdctrls::TLabel* Label27;
	Vcl::Comctrls::TTrackBar* tbCTLabelsIndent;
	Vcl::Comctrls::TPageControl* pcSpecificCTOptions;
	Vcl::Comctrls::TTabSheet* tsCT3DOptions;
	Vcl::Comctrls::TTabSheet* tsCTSpecifcOptions;
	Vcl::Stdctrls::TCheckBox* chbCTStacked;
	Vcl::Stdctrls::TCheckBox* chbCTFullStacked;
	Vcl::Stdctrls::TCheckBox* chbCTAutoSize;
	Vcl::Stdctrls::TLabel* lbCTAutoSizeValue;
	Vcl::Comctrls::TTrackBar* tbCTAutoSizeValue;
	Vcl::Stdctrls::TLabel* lbCTCustomSize;
	Vcl::Comctrls::TTrackBar* tbCTCustomSize;
	Vcl::Stdctrls::TGroupBox* gbCTLeftPlane;
	Vcl::Stdctrls::TButton* btCTLeftPlaneFill;
	Vcl::Stdctrls::TButton* btCTLeftPlaneLine;
	Vcl::Stdctrls::TGroupBox* gbCTBackPlane;
	Vcl::Stdctrls::TButton* btCTBackPlaneFill;
	Vcl::Stdctrls::TButton* btCTBackPlaneLine;
	Vcl::Stdctrls::TLabel* Label28;
	Vcl::Comctrls::TTrackBar* tbChartDepth;
	Vcl::Stdctrls::TCheckBox* chbCTNoEdge;
	Vcl::Stdctrls::TCheckBox* chbCTShaded;
	Vcl::Stdctrls::TGroupBox* gbCTBottomPlane;
	Vcl::Stdctrls::TButton* btCTBottomPlaneFill;
	Vcl::Stdctrls::TButton* btCTBottomPlaneLine;
	Vcl::Stdctrls::TButton* btCTLeftZGrid;
	Vcl::Stdctrls::TButton* btCTBottomZMajorGrid;
	Vcl::Stdctrls::TButton* btCTBottomZMinorGrid;
	Vcl::Stdctrls::TCheckBox* chbCTMultiRow;
	Vcl::Stdctrls::TLabel* lbCTIndent3D;
	Vcl::Comctrls::TTrackBar* tbCTIndent3D;
	Vcl::Stdctrls::TCheckBox* chbCTExplodeAutoScale;
	Vcl::Stdctrls::TCheckBox* chbCTProportional;
	Vcl::Stdctrls::TCheckBox* chbYAxisAutoScale;
	Vcl::Stdctrls::TCheckBox* chbYAxisStacked;
	Vcl::Stdctrls::TCheckBox* chbYAxisInverted;
	Vcl::Stdctrls::TEdit* edYMinValue;
	Vcl::Stdctrls::TEdit* edYMaxValue;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Stdctrls::TButton* btAddSeries;
	Vcl::Stdctrls::TButton* btRemoveSeries;
	Vcl::Comctrls::TTabControl* pcChartSeriesValues;
	Vcl::Stdctrls::TButton* bColOptions;
	Vcl::Grids::TStringGrid* sgData;
	Vcl::Stdctrls::TLabel* Label3;
	Lmdshspinedit::TLMDShSpinEdit* seRowCount;
	Lmdcharttitlebox::TLMDChartAlignment __fastcall GetLMDChartAlignmentByXY(int Ax, int Ay);
	void __fastcall SetXYByLMDChartAlignment(Lmdcharttitlebox::TLMDChartAlignment AAlign, Plmdalignmenteditor::TLMDAlignmentEditor* AEditor);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall btLegendIndentsDefineClick(System::TObject* Sender);
	void __fastcall btLegendEdgeClick(System::TObject* Sender);
	void __fastcall btLegendBackgroundClick(System::TObject* Sender);
	void __fastcall btChartBackgroundClick(System::TObject* Sender);
	void __fastcall btChartAreaBackgroundClick(System::TObject* Sender);
	void __fastcall btEdgeClick(System::TObject* Sender);
	void __fastcall chbVerticalGridLinesClick(System::TObject* Sender);
	void __fastcall chbHorizontalGridLinesClick(System::TObject* Sender);
	void __fastcall btMajorVerticalGridLineClick(System::TObject* Sender);
	void __fastcall btMajorHorizontalGridLineClick(System::TObject* Sender);
	void __fastcall chbChartAreaMarkersClick(System::TObject* Sender);
	void __fastcall meChartAreaInnerIndentsBottomMarginChange(System::TObject* Sender);
	void __fastcall meChartAreaInnerIndentsLeftMarginChange(System::TObject* Sender);
	void __fastcall meChartAreaInnerIndentsRightMarginChange(System::TObject* Sender);
	void __fastcall meChartAreaInnerIndentsTopMarginChange(System::TObject* Sender);
	void __fastcall meChartAreaMarginsBottomMarginChange(System::TObject* Sender);
	void __fastcall meChartAreaMarginsLeftMarginChange(System::TObject* Sender);
	void __fastcall meChartAreaMarginsRightMarginChange(System::TObject* Sender);
	void __fastcall meChartAreaMarginsTopMarginChange(System::TObject* Sender);
	void __fastcall chbChartAreaShadowClick(System::TObject* Sender);
	void __fastcall btChartAreaShadowColorClick(System::TObject* Sender);
	void __fastcall tbChartAreaShadowTransparencyChange(System::TObject* Sender);
	void __fastcall tbChartAreaShadowDepthChange(System::TObject* Sender);
	void __fastcall chbShowLegendClick(System::TObject* Sender);
	void __fastcall chbLegendMayOverlapClick(System::TObject* Sender);
	void __fastcall btLegendFontClick(System::TObject* Sender);
	void __fastcall tbLegendIconSizeChange(System::TObject* Sender);
	void __fastcall tbLegendSpaceAfterIconChange(System::TObject* Sender);
	void __fastcall tbLegendIntervalBetweenLinesChange(System::TObject* Sender);
	void __fastcall rgLegendLayoutClick(System::TObject* Sender);
	void __fastcall aeLegendAlignmentChange(System::TObject* Sender);
	void __fastcall btXAxisFontClick(System::TObject* Sender);
	void __fastcall btYAxisFontClick(System::TObject* Sender);
	void __fastcall btXAxisLineClick(System::TObject* Sender);
	void __fastcall btYAxisLineClick(System::TObject* Sender);
	void __fastcall rgXAxisMajorTicksClick(System::TObject* Sender);
	void __fastcall rgXAxisMinorTicksClick(System::TObject* Sender);
	void __fastcall rgYAxisMajorTicksClick(System::TObject* Sender);
	void __fastcall rgYAxisMinorTicksClick(System::TObject* Sender);
	void __fastcall chbYAxisAutoScaleClick(System::TObject* Sender);
	void __fastcall chbYAxisStackedClick(System::TObject* Sender);
	void __fastcall chbYAxisInvertedClick(System::TObject* Sender);
	void __fastcall cbXAxisValueTypeChange(System::TObject* Sender);
	void __fastcall cbYAxisValueTypeChange(System::TObject* Sender);
	void __fastcall edXAxisMajorTickSizeChange(System::TObject* Sender);
	void __fastcall edXAxisMinorTickSizeChange(System::TObject* Sender);
	void __fastcall edYAxisMajorTickSizeChange(System::TObject* Sender);
	void __fastcall edYAxisMinorTickSizeChange(System::TObject* Sender);
	void __fastcall edYAxisMajorStepChange(System::TObject* Sender);
	void __fastcall edYAxisMinorStepChange(System::TObject* Sender);
	void __fastcall edHeaderTextChange(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall meTitleBoxMarginsBottomMarginChange(System::TObject* Sender);
	void __fastcall meTitleBoxMarginsLeftMarginChange(System::TObject* Sender);
	void __fastcall meTitleBoxMarginsRightMarginChange(System::TObject* Sender);
	void __fastcall meTitleBoxMarginsTopMarginChange(System::TObject* Sender);
	void __fastcall tbTitleBoxChartMarginChange(System::TObject* Sender);
	void __fastcall tbTitleBoxEdgeMarginChange(System::TObject* Sender);
	void __fastcall aeTitleBoxAlignmentChange(System::TObject* Sender);
	void __fastcall aeHeaderIconAlignmentChange(System::TObject* Sender);
	void __fastcall btHeaderIconClick(System::TObject* Sender);
	void __fastcall chbCTShowLabelsClick(System::TObject* Sender);
	void __fastcall btCTLabelsBackgroundClick(System::TObject* Sender);
	void __fastcall btCTLabelEdgesClick(System::TObject* Sender);
	void __fastcall btCTLabelFontClick(System::TObject* Sender);
	void __fastcall chbCTShowLabelsBackgroundClick(System::TObject* Sender);
	void __fastcall tbCTLabelsXDeviationChange(System::TObject* Sender);
	void __fastcall tbCTLabelsYDeviationChange(System::TObject* Sender);
	void __fastcall tbCTLabelsMarginChange(System::TObject* Sender);
	void __fastcall tbCTLabelsIndentChange(System::TObject* Sender);
	void __fastcall tbCTTransparencyChange(System::TObject* Sender);
	void __fastcall chbCTShadedClick(System::TObject* Sender);
	void __fastcall chbCTNoEdgeClick(System::TObject* Sender);
	void __fastcall tbChartDepthChange(System::TObject* Sender);
	void __fastcall chbCTAutoSizeClick(System::TObject* Sender);
	void __fastcall chbCTStackedClick(System::TObject* Sender);
	void __fastcall chbCTFullStackedClick(System::TObject* Sender);
	void __fastcall chbCTMultiRowClick(System::TObject* Sender);
	void __fastcall chbCTExplodeAutoScaleClick(System::TObject* Sender);
	void __fastcall chbCTProportionalClick(System::TObject* Sender);
	void __fastcall tbCTAutoSizeValueChange(System::TObject* Sender);
	void __fastcall tbCTCustomSizeChange(System::TObject* Sender);
	void __fastcall tbCTIndent3DChange(System::TObject* Sender);
	void __fastcall btCTLeftPlaneFillClick(System::TObject* Sender);
	void __fastcall btCTBackPlaneFillClick(System::TObject* Sender);
	void __fastcall btCTBottomPlaneFillClick(System::TObject* Sender);
	void __fastcall btCTLeftPlaneLineClick(System::TObject* Sender);
	void __fastcall btCTBackPlaneLineClick(System::TObject* Sender);
	void __fastcall btCTBottomPlaneLineClick(System::TObject* Sender);
	void __fastcall btCTLeftZGridClick(System::TObject* Sender);
	void __fastcall btCTBottomZMajorGridClick(System::TObject* Sender);
	void __fastcall btCTBottomZMinorGridClick(System::TObject* Sender);
	void __fastcall edYMinValueChange(System::TObject* Sender);
	void __fastcall edYMaxValueChange(System::TObject* Sender);
	void __fastcall btAddSeriesClick(System::TObject* Sender);
	void __fastcall btRemoveSeriesClick(System::TObject* Sender);
	bool __fastcall IsCurrSeriesAssigned(void);
	Lmdchartseriescollection::TLMDChartSeriesCollectionItem* __fastcall CurrentSeries(void);
	void __fastcall seRowCountChange(System::TObject* Sender);
	void __fastcall sgDataSetEditText(System::TObject* Sender, int ACol, int ARow, const System::UnicodeString Value);
	void __fastcall bColOptionsClick(System::TObject* Sender);
	void __fastcall pcChartSeriesValuesChange(System::TObject* Sender);
	
private:
	Lmdchart::TLMDChart* FChart;
	Vcl::Forms::TForm* FForm;
	Lmdchart::TLMDChart* FChartPreview;
	Plmddistanceandpositiondlg::TLMDDistanceAndSizeEditor* FDistPosEditor;
	Plmdlineeditordlg::TLMDLineEditor* FLineEditor;
	Plmdareafilleditor::TLMDAreaFillEditor* FFillEditor;
	Lmdcharttypes::TLMDChartCTAbstract* FCurChartType;
	bool FProgrammaticUpdate;
	void __fastcall DisplayChartData(void);
	void __fastcall DisplayChartValues(Lmdchartseries::TLMDCustomChartSeries* ASeries);
	void __fastcall AdjustChartDataTabControl(void);
	bool __fastcall IsChart3D(void);
	void __fastcall SetUpChartTypeEditors(void);
	void __fastcall DisplayChartTypeSettings(void);
	void __fastcall ApplyChartTypeSettings(void);
	
protected:
	__property Lmdchart::TLMDChart* ChartPreview = {read=FChartPreview};
	
public:
	void __fastcall Edit(Lmdchart::TLMDChart* AChart);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDChartEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDChartEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDChartEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDChartEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


typedef System::TMetaClass* TLMDChartTypeClass;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDChartEditor* LMDChartEditor;
}	/* namespace Plmdcharteditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDCHARTEDITORDLG)
using namespace Plmdcharteditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdcharteditordlgHPP
