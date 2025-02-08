unit pLMDChartEditorDlg;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################
pLMDChartEditorDlg unit - Chart component editor
-----------------------------------
Description

ToDo
----
*

Changes
-------

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ExtDlgs,
  ExtCtrls, LMDChart, StdCtrls, ComCtrls, ImgList, Grids, Buttons, Variants,
  {$ifdef LMD_UNICODE} LMDUnicodeStrings, {$endif}
  pLMDMarginsEditor, LMDShSpinEdit, pLMDAlignmentEditor,
  LMDChartCTAreaSpline3D, LMDChartCTAreaSpline, LMDChartCTAreaLine3D, LMDChartCTAreaLine,
  LMDChartCTDoughnut, LMDChartCTPie2D, LMDChartCTBar3D, LMDChartCTBar,
  LMDChartCTColumn3D, LMDChartTypes, LMDChartCTColumn,
  LMDCustomComponent, pLMDDistanceAndPositionDlg, pLMDLineEditorDlg, pLMDAreaFillEditor,
  LMDChartLegend, LMDChartBackground, LMDChartLine,
  LMDChartAxis, LMDChartTitleBox, LMDChartUtils, LMDChartSeries, LMDChartSeriesCollection,
  LMDChartValuesBase, pLMDAddSeriesDlg, pLMDChartValuesOptionsSelDlg,
  LMDControl, LMDCustomControl, LMDTypes, LMDUtils;

type
  TLMDChartEditor = class(TForm)
    plChartPreview: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    btOK: TButton;
    PageControl1: TPageControl;
    tsChartType: TTabSheet;
    tsChartData: TTabSheet;
    tsOptions: TTabSheet;
    PageControl2: TPageControl;
    isGeneral: TTabSheet;
    tsAxis: TTabSheet;
    tsLegend: TTabSheet;
    tsTitleBox: TTabSheet;
    chbShowLegend: TCheckBox;
    Label6: TLabel;
    btLegendEdge: TButton;
    btLegendIndentsDefine: TButton;
    btLegendBackground: TButton;
    btChartBackground: TButton;
    aeLegendAlignment: TLMDAlignmentEditor;
    GroupBox1: TGroupBox;
    btChartAreaBackground: TButton;
    btEdge: TButton;
    GroupBox2: TGroupBox;
    meChartAreaInnerIndents: TLMDMarginsEditor;
    GroupBox3: TGroupBox;
    meChartAreaMargins: TLMDMarginsEditor;
    GroupBox4: TGroupBox;
    chbVerticalGridLines: TCheckBox;
    btMajorVerticalGridLine: TButton;
    GroupBox5: TGroupBox;
    chbHorizontalGridLines: TCheckBox;
    btMajorHorizontalGridLine: TButton;
    chbChartAreaMarkers: TCheckBox;
    GroupBox6: TGroupBox;
    chbChartAreaShadow: TCheckBox;
    btChartAreaShadowColor: TButton;
    tbChartAreaShadowTransparency: TTrackBar;
    tbChartAreaShadowDepth: TTrackBar;
    Label7: TLabel;
    Label8: TLabel;
    btLegendFont: TButton;
    chbLegendMayOverlap: TCheckBox;
    tbLegendIconSize: TTrackBar;
    Label9: TLabel;
    Label10: TLabel;
    tbLegendSpaceAfterIcon: TTrackBar;
    Label11: TLabel;
    tbLegendIntervalBetweenLines: TTrackBar;
    rgLegendLayout: TRadioGroup;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    aeTitleBoxAlignment: TLMDAlignmentEditor;
    aeHeaderIconAlignment: TLMDAlignmentEditor;
    Label12: TLabel;
    edHeaderText: TEdit;
    GroupBox7: TGroupBox;
    meTitleBoxMargins: TLMDMarginsEditor;
    Label13: TLabel;
    tbTitleBoxChartMargin: TTrackBar;
    Label14: TLabel;
    tbTitleBoxEdgeMargin: TTrackBar;
    btHeaderIcon: TButton;
    FontDialog1: TFontDialog;
    OpenPictureDialog1: TOpenPictureDialog;
    GroupBox8: TGroupBox;
    btXAxisLine: TButton;
    btXAxisFont: TButton;
    rgXAxisMajorTicks: TRadioGroup;
    rgXAxisMinorTicks: TRadioGroup;
    Label15: TLabel;
    edXAxisMajorTickSize: TEdit;
    Label16: TLabel;
    edXAxisMinorTickSize: TEdit;
    Label17: TLabel;
    cbXAxisValueType: TComboBox;
    GroupBox9: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    btYAxisLine: TButton;
    btYAxisFont: TButton;
    rgYAxisMajorTicks: TRadioGroup;
    rgYAxisMinorTicks: TRadioGroup;
    edYAxisMajorTickSize: TEdit;
    edYAxisMinorTickSize: TEdit;
    cbYAxisValueType: TComboBox;
    edYAxisMajorStep: TEdit;
    edYAxisMinorStep: TEdit;
    Label21: TLabel;
    Label22: TLabel;
    PageControl4: TPageControl;
    tsChartTypeOptions: TTabSheet;
    GroupBox10: TGroupBox;
    ColorDialog1: TColorDialog;
    tbCTLabelsXDeviation: TTrackBar;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    tbCTLabelsYDeviation: TTrackBar;
    tbCTLabelsMargin: TTrackBar;
    chbCTShowLabels: TCheckBox;
    Label26: TLabel;
    tbCTTransparency: TTrackBar;
    btCTLabelsBackground: TButton;
    btCTLabelEdges: TButton;
    btCTLabelFont: TButton;
    chbCTShowLabelsBackground: TCheckBox;
    Label27: TLabel;
    tbCTLabelsIndent: TTrackBar;
    pcSpecificCTOptions: TPageControl;
    tsCT3DOptions: TTabSheet;
    tsCTSpecifcOptions: TTabSheet;
    chbCTStacked: TCheckBox;
    chbCTFullStacked: TCheckBox;
    chbCTAutoSize: TCheckBox;
    lbCTAutoSizeValue: TLabel;
    tbCTAutoSizeValue: TTrackBar;
    lbCTCustomSize: TLabel;
    tbCTCustomSize: TTrackBar;
    gbCTLeftPlane: TGroupBox;
    btCTLeftPlaneFill: TButton;
    btCTLeftPlaneLine: TButton;
    gbCTBackPlane: TGroupBox;
    btCTBackPlaneFill: TButton;
    btCTBackPlaneLine: TButton;
    Label28: TLabel;
    tbChartDepth: TTrackBar;
    chbCTNoEdge: TCheckBox;
    chbCTShaded: TCheckBox;
    gbCTBottomPlane: TGroupBox;
    btCTBottomPlaneFill: TButton;
    btCTBottomPlaneLine: TButton;
    btCTLeftZGrid: TButton;
    btCTBottomZMajorGrid: TButton;
    btCTBottomZMinorGrid: TButton;
    chbCTMultiRow: TCheckBox;
    lbCTIndent3D: TLabel;
    tbCTIndent3D: TTrackBar;
    chbCTExplodeAutoScale: TCheckBox;
    chbCTProportional: TCheckBox;
    chbYAxisAutoScale: TCheckBox;
    chbYAxisStacked: TCheckBox;
    chbYAxisInverted: TCheckBox;
    edYMinValue: TEdit;
    edYMaxValue: TEdit;
    Label2: TLabel;
    Label4: TLabel;
    Panel4: TPanel;
    btAddSeries: TButton;
    btRemoveSeries: TButton;
    pcChartSeriesValues: TTabControl;
    bColOptions: TButton;
    sgData: TStringGrid;
    Label3: TLabel;
    seRowCount: TLMDShSpinEdit;

    function GetLMDChartAlignmentByXY(Ax, Ay: integer): TLMDChartAlignment;
    procedure SetXYByLMDChartAlignment(AAlign: TLMDChartAlignment; AEditor: TLMDAlignmentEditor);

    procedure FormCreate(Sender: TObject);
    procedure btLegendIndentsDefineClick(Sender: TObject);
    procedure btLegendEdgeClick(Sender: TObject);
    procedure btLegendBackgroundClick(Sender: TObject);
    procedure btChartBackgroundClick(Sender: TObject);
    procedure btChartAreaBackgroundClick(Sender: TObject);
    procedure btEdgeClick(Sender: TObject);
    procedure chbVerticalGridLinesClick(Sender: TObject);
    procedure chbHorizontalGridLinesClick(Sender: TObject);
    procedure btMajorVerticalGridLineClick(Sender: TObject);
    procedure btMajorHorizontalGridLineClick(Sender: TObject);
    procedure chbChartAreaMarkersClick(Sender: TObject);
    procedure meChartAreaInnerIndentsBottomMarginChange(Sender: TObject);
    procedure meChartAreaInnerIndentsLeftMarginChange(Sender: TObject);
    procedure meChartAreaInnerIndentsRightMarginChange(Sender: TObject);
    procedure meChartAreaInnerIndentsTopMarginChange(Sender: TObject);
    procedure meChartAreaMarginsBottomMarginChange(Sender: TObject);
    procedure meChartAreaMarginsLeftMarginChange(Sender: TObject);
    procedure meChartAreaMarginsRightMarginChange(Sender: TObject);
    procedure meChartAreaMarginsTopMarginChange(Sender: TObject);
    procedure chbChartAreaShadowClick(Sender: TObject);
    procedure btChartAreaShadowColorClick(Sender: TObject);
    procedure tbChartAreaShadowTransparencyChange(Sender: TObject);
    procedure tbChartAreaShadowDepthChange(Sender: TObject);
    procedure chbShowLegendClick(Sender: TObject);
    procedure chbLegendMayOverlapClick(Sender: TObject);
    procedure btLegendFontClick(Sender: TObject);
    procedure tbLegendIconSizeChange(Sender: TObject);
    procedure tbLegendSpaceAfterIconChange(Sender: TObject);
    procedure tbLegendIntervalBetweenLinesChange(Sender: TObject);
    procedure rgLegendLayoutClick(Sender: TObject);
    procedure aeLegendAlignmentChange(Sender: TObject);
    procedure btXAxisFontClick(Sender: TObject);
    procedure btYAxisFontClick(Sender: TObject);
    procedure btXAxisLineClick(Sender: TObject);
    procedure btYAxisLineClick(Sender: TObject);
    procedure rgXAxisMajorTicksClick(Sender: TObject);
    procedure rgXAxisMinorTicksClick(Sender: TObject);
    procedure rgYAxisMajorTicksClick(Sender: TObject);
    procedure rgYAxisMinorTicksClick(Sender: TObject);
    procedure chbYAxisAutoScaleClick(Sender: TObject);
    procedure chbYAxisStackedClick(Sender: TObject);
    procedure chbYAxisInvertedClick(Sender: TObject);
    procedure cbXAxisValueTypeChange(Sender: TObject);
    procedure cbYAxisValueTypeChange(Sender: TObject);
    procedure edXAxisMajorTickSizeChange(Sender: TObject);
    procedure edXAxisMinorTickSizeChange(Sender: TObject);
    procedure edYAxisMajorTickSizeChange(Sender: TObject);
    procedure edYAxisMinorTickSizeChange(Sender: TObject);
    procedure edYAxisMajorStepChange(Sender: TObject);
    procedure edYAxisMinorStepChange(Sender: TObject);
    procedure edHeaderTextChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure meTitleBoxMarginsBottomMarginChange(Sender: TObject);
    procedure meTitleBoxMarginsLeftMarginChange(Sender: TObject);
    procedure meTitleBoxMarginsRightMarginChange(Sender: TObject);
    procedure meTitleBoxMarginsTopMarginChange(Sender: TObject);
    procedure tbTitleBoxChartMarginChange(Sender: TObject);
    procedure tbTitleBoxEdgeMarginChange(Sender: TObject);
    procedure aeTitleBoxAlignmentChange(Sender: TObject);
    procedure aeHeaderIconAlignmentChange(Sender: TObject);
    procedure btHeaderIconClick(Sender: TObject);
    procedure chbCTShowLabelsClick(Sender: TObject);
    procedure btCTLabelsBackgroundClick(Sender: TObject);
    procedure btCTLabelEdgesClick(Sender: TObject);
    procedure btCTLabelFontClick(Sender: TObject);
    procedure chbCTShowLabelsBackgroundClick(Sender: TObject);
    procedure tbCTLabelsXDeviationChange(Sender: TObject);
    procedure tbCTLabelsYDeviationChange(Sender: TObject);
    procedure tbCTLabelsMarginChange(Sender: TObject);
    procedure tbCTLabelsIndentChange(Sender: TObject);
    procedure tbCTTransparencyChange(Sender: TObject);
    procedure chbCTShadedClick(Sender: TObject);
    procedure chbCTNoEdgeClick(Sender: TObject);
    procedure tbChartDepthChange(Sender: TObject);
    procedure chbCTAutoSizeClick(Sender: TObject);
    procedure chbCTStackedClick(Sender: TObject);
    procedure chbCTFullStackedClick(Sender: TObject);
    procedure chbCTMultiRowClick(Sender: TObject);
    procedure chbCTExplodeAutoScaleClick(Sender: TObject);
    procedure chbCTProportionalClick(Sender: TObject);
    procedure tbCTAutoSizeValueChange(Sender: TObject);
    procedure tbCTCustomSizeChange(Sender: TObject);
    procedure tbCTIndent3DChange(Sender: TObject);
    procedure btCTLeftPlaneFillClick(Sender: TObject);
    procedure btCTBackPlaneFillClick(Sender: TObject);
    procedure btCTBottomPlaneFillClick(Sender: TObject);
    procedure btCTLeftPlaneLineClick(Sender: TObject);
    procedure btCTBackPlaneLineClick(Sender: TObject);
    procedure btCTBottomPlaneLineClick(Sender: TObject);
    procedure btCTLeftZGridClick(Sender: TObject);
    procedure btCTBottomZMajorGridClick(Sender: TObject);
    procedure btCTBottomZMinorGridClick(Sender: TObject);
    procedure edYMinValueChange(Sender: TObject);
    procedure edYMaxValueChange(Sender: TObject);
    procedure btAddSeriesClick(Sender: TObject);
    procedure btRemoveSeriesClick(Sender: TObject);
    function IsCurrSeriesAssigned: Boolean;
    function CurrentSeries: TLMDChartSeriesCollectionItem;
    procedure seRowCountChange(Sender: TObject);
    procedure sgDataSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure bColOptionsClick(Sender: TObject);
    procedure pcChartSeriesValuesChange(Sender: TObject);
  private
    { Private declarations }
    FChart: TLMDChart;
    FForm: TForm;
    FChartPreview: TLMDChart;
    FDistPosEditor: TLMDDistanceAndSizeEditor;
    FLineEditor: TLMDLineEditor;
    FFillEditor: TLMDAreaFillEditor;
    FCurChartType: TLMDChartCTAbstract;

    FProgrammaticUpdate: boolean;

    //procedure CopyChartSettings(AFromChart, AToChart: TLMDChart);
    //procedure CopyChartTypeSettings(AFromChartType, AToChartType: TLMDChartCTAbstract);
    //procedure CopyChartBackgroundSettings(AFromBackground, AToBackground: TLMDChartBackground);
    //procedure CopyChartLineSettings(AFromLine, AToLine: TLMDChartLine);

    procedure DisplayChartData;
    procedure DisplayChartValues(ASeries: TLMDCustomChartSeries);
    procedure AdjustChartDataTabControl;

    function IsChart3D: boolean;

    procedure SetUpChartTypeEditors;
    procedure DisplayChartTypeSettings;
    procedure ApplyChartTypeSettings;
  protected
    property ChartPreview: TLMDChart read FChartPreview;  
  public
    { Public declarations }
    procedure Edit(AChart: TLMDChart);
  end;

  TLMDChartTypeClass = class of TLMDChartCTAbstract;

var
  LMDChartEditor: TLMDChartEditor;

implementation
{$R *.DFM}
uses
  DesignEditors, DesignWindows, DsnConst, DesignIntf;
  { TLMDChartEditor }

{
procedure TLMDChartEditor.CopyChartSettings(AFromChart,
  AToChart: TLMDChart);
var
  LParentForm: TForm;
  LParent: TWinControl;
  found: boolean;
  i: integer;
  LChartType: TLMDChartCTAbstract;
  LChartTypeClass: TLMDChartTypeClass;
begin

  //setting up (locating or creating in the parent form of the target chart)
  //chart type object and its options
  if AFromChart.ChartType = nil then
    AToChart.ChartType := nil
  else if (AToChart.ChartType = nil)
    or (AFromChart.ChartType.ClassType <> AToChart.ChartType.ClassType) then
  begin
    LParent := AToChart.Parent;
    while((not (LParent = nil)) and (not (LParent is TForm))) do
      LParent := LParent.Parent;
    if LParent is TForm then
    begin
      LParentForm := LParent as TForm;
      found := false;
      i := 0;
      while ((not found) and (i < LParentForm.ComponentCount)) do
      begin
        found := LParentForm.Components[i].ClassType = AFromChart.ChartType.ClassType;
        if not found then
          Inc(i);
      end;
      if found then
        LChartType := LParentForm.Components[i] as TLMDChartCTAbstract
      else
      begin
        LChartTypeClass := TLMDChartTypeClass(AFromChart.ChartType.ClassType);
        LChartType := LChartTypeClass.Create(LParentForm);
      end;
      CopyChartTypeSettings(AFromChart.ChartType, LChartType);
      AToChart.ChartType := LChartType;
    end;
  end;

  {
  //copying chart data
  ...

  //copying chart options
  CopyChartBackgroundSettings(AFromChart.Background, AToChart.Background);

  //chart area options
  CopyChartBackgroundSettings(AFromChart.ChartArea.Background, AToChart.ChartArea.Background);
  CopyChartLineSettings(AFromChart.ChartArea.Edge, AToChart.ChartArea.Edge);

  AToChart.ChartArea.InnerIndentLeft := AFromChart.ChartArea.InnerIndentLeft;
  AToChart.ChartArea.InnerIndentBottom := AFromChart.ChartArea.InnerIndentBottom;
  AToChart.ChartArea.InnerIndentRight := AFromChart.ChartArea.InnerIndentRight;
  AToChart.ChartArea.InnerIndentTop := AFromChart.ChartArea.InnerIndentTop;

  AToChart.ChartArea.MajorGridHorizontal := AFromChart.ChartArea.MajorGridHorizontal;
  AToChart.ChartArea.MajorGridVertical := AFromChart.ChartArea.MajorGridVertical;
  CopyChartLineSettings(AFromChart.ChartArea.MajorGridLineHorizontal, AToChart.ChartArea.MajorGridLineHorizontal);
  CopyChartLineSettings(AFromChart.ChartArea.MajorGridLineVertical, AToChart.ChartArea.MajorGridLineVertical);

  AToChart.ChartArea.MarginLeft := AFromChart.ChartArea.MarginLeft;
  AToChart.ChartArea.MarginBottom := AFromChart.ChartArea.MarginBottom;
  AToChart.ChartArea.MarginRight := AFromChart.ChartArea.MarginRight;
  AToChart.ChartArea.MarginTop := AFromChart.ChartArea.MarginTop;

  AToChart.ChartArea.Shadow := AFromChart.ChartArea.Shadow;
  AToChart.ChartArea.ShadowColor := AFromChart.ChartArea.ShadowColor;
  AToChart.ChartArea.ShadowDepth := AFromChart.ChartArea.ShadowDepth;
  AToChart.ChartArea.ShadowTransparency := AFromChart.ChartArea.ShadowTransparency;

  AToChart.ChartArea.ShowMarkers := AFromChart.ChartArea.ShowMarkers;

  //X axis options
  //CopyChartLineSettings(AFromChart.ChartArea.XAxis.Line, AToChart.ChartArea.XAxis.Line);
  AToChart.ChartArea.XAxis.Font.Assign(AFromChart.ChartArea.XAxis.Font);
  AToChart.ChartArea.XAxis.MinorTick := AFromChart.ChartArea.XAxis.MinorTick;
  AToChart.ChartArea.XAxis.MinorTickSize := AFromChart.ChartArea.XAxis.MinorTickSize;
  AToChart.ChartArea.XAxis.MajorTick := AFromChart.ChartArea.XAxis.MajorTick;
  AToChart.ChartArea.XAxis.MajorTickSize := AFromChart.ChartArea.XAxis.MajorTickSize;
  AToChart.ChartArea.XAxis.ValuesType := AFromChart.ChartArea.XAxis.ValuesType;

  //Y axis options
  //CopyChartLineSettings(AFromChart.ChartArea.YAxis.Line, AToChart.ChartArea.YAxis.Line);
  AToChart.ChartArea.YAxis.Font.Assign(AFromChart.ChartArea.YAxis.Font);
  AToChart.ChartArea.YAxis.MinorTick := AFromChart.ChartArea.YAxis.MinorTick;
  AToChart.ChartArea.YAxis.MinorTickSize := AFromChart.ChartArea.YAxis.MinorTickSize;
  AToChart.ChartArea.YAxis.MajorTick := AFromChart.ChartArea.YAxis.MajorTick;
  AToChart.ChartArea.YAxis.MajorTickSize := AFromChart.ChartArea.YAxis.MajorTickSize;
  AToChart.ChartArea.YAxis.ValuesType := AFromChart.ChartArea.YAxis.ValuesType;
  AToChart.ChartArea.YAxis.Inverted := AFromChart.ChartArea.YAxis.Inverted;
  AToChart.ChartArea.YAxis.AutoScale := AFromChart.ChartArea.YAxis.AutoScale;
  AToChart.ChartArea.YAxis.ChartStacked := AFromChart.ChartArea.YAxis.ChartStacked;
  AToChart.ChartArea.YAxis.MinorStep := AFromChart.ChartArea.YAxis.MinorStep;
  AToChart.ChartArea.YAxis.MajorStep := AFromChart.ChartArea.YAxis.MajorStep;
  AToChart.ChartArea.YAxis.MinValue := AFromChart.ChartArea.YAxis.MinValue;
  AToChart.ChartArea.YAxis.MaxValue := AFromChart.ChartArea.YAxis.MaxValue;

  //legend options
  AToChart.Legend.AbsoluteX := AFromChart.Legend.AbsoluteX;
  AToChart.Legend.AbsoluteY := AFromChart.Legend.AbsoluteY;
  AToChart.Legend.Alignment := AFromChart.Legend.Alignment;
  CopyChartBackgroundSettings(AFromChart.Legend.Background, AToChart.Legend.Background);
  CopyChartLineSettings(AFromChart.Legend.Edge, AToChart.Legend.Edge);
  AToChart.Legend.Font.Assign(AFromChart.Legend.Font);
  AToChart.Legend.HorizontalListing := AFromChart.Legend.HorizontalListing;
  AToChart.Legend.IconSize := AFromChart.Legend.IconSize;

  AToChart.Legend.InnerIndentLeft := AFromChart.Legend.InnerIndentLeft;
  AToChart.Legend.InnerIndentBottom := AFromChart.Legend.InnerIndentBottom;
  AToChart.Legend.InnerIndentRight := AFromChart.Legend.InnerIndentRight;
  AToChart.Legend.InnerIndentTop := AFromChart.Legend.InnerIndentTop;
  AToChart.Legend.MarginEdge := AFromChart.Legend.MarginEdge;
  AToChart.Legend.MarginChart := AFromChart.Legend.MarginChart;
  AToChart.Legend.Overlap := AFromChart.Legend.Overlap;
  AToChart.Legend.Show := AFromChart.Legend.Show;
  AToChart.Legend.SpaceBtwLines := AFromChart.Legend.SpaceBtwLines;
  AToChart.Legend.SpaceAfterIcon := AFromChart.Legend.SpaceAfterIcon;

  //title box options
  AToChart.TitleBox.Alignment := AFromChart.TitleBox.Alignment;
  CopyChartBackgroundSettings(AFromChart.TitleBox.Background, AToChart.TitleBox.Background);
  CopyChartLineSettings(AFromChart.TitleBox.Edge, AToChart.TitleBox.Edge);
  AToChart.TitleBox.Font.Assign(AFromChart.TitleBox.Font);
  AToChart.TitleBox.Icon.Assign(AFromChart.TitleBox.Icon);
  AToChart.TitleBox.IconAlignment := AFromChart.TitleBox.IconAlignment;
  AToChart.TitleBox.IconMargin := AFromChart.TitleBox.IconMargin;
  AToChart.TitleBox.InnerIndentLeft := AFromChart.TitleBox.InnerIndentLeft;
  AToChart.TitleBox.InnerIndentBottom := AFromChart.TitleBox.InnerIndentBottom;
  AToChart.TitleBox.InnerIndentRight := AFromChart.TitleBox.InnerIndentRight;
  AToChart.TitleBox.InnerIndentTop := AFromChart.TitleBox.InnerIndentTop;
  AToChart.TitleBox.MarginEdge := AFromChart.TitleBox.MarginEdge;
  AToChart.TitleBox.MarginChart := AFromChart.TitleBox.MarginChart;
  AToChart.TitleBox.Text := AFromChart.TitleBox.Text;
  
end;
}

{
procedure TLMDChartEditor.CopyChartTypeSettings(AFromChartType,
  AToChartType: TLMDChartCTAbstract);
var
  LChartCTAreaSpline3DSrc, LChartCTAreaSpline3DDest: TLMDChartCTAreaSpline3D;
  LChartCTAreaSplineSrc, LChartCTAreaSplineDest: TLMDChartCTAreaSpline;
  LChartCTAreaLine3DSrc, LChartCTAreaLine3DDest: TLMDChartCTAreaLine3D;
  LChartCTAreaLineSrc, LChartCTAreaLineDest: TLMDChartCTAreaLine;
  LChartCTDoughnutSrc, LChartCTDoughnutDest: TLMDChartCTDoughnut;
  LChartCTPie2DSrc, LChartCTPie2DDest: TLMDChartCTPie2D;
  LChartCTBar3DSrc, LChartCTBar3DDest: TLMDChartCTBar3D;
  LChartCTBarSrc, LChartCTBarDest: TLMDChartCTBar;
  LChartCTColumn3DSrc, LChartCTColumn3DDest: TLMDChartCTColumn3D;
  LChartCTColumnSrc, LChartCTColumnDest: TLMDChartCTColumn;
begin
  if AFromChartType.ClassType <> AToChartType.ClassType then
    Exit;
  if AFromChartType is TLMDChartCTColumn then
  begin
    LChartCTColumnSrc := AFromChartType as TLMDChartCTColumn;
    LChartCTColumnDest := AToChartType as TLMDChartCTColumn;

    LChartCTColumnDest.ShowColumnsLabels := LChartCTColumnSrc.ShowColumnsLabels;
    LChartCTColumnDest.ColumnsLabels.ShowBackground := LChartCTColumnSrc.ColumnsLabels.ShowBackground;
    LChartCTColumnDest.LabelsXDeviation := LChartCTColumnSrc.LabelsXDeviation;
    LChartCTColumnDest.LabelsYDeviation := LChartCTColumnSrc.LabelsYDeviation;
    LChartCTColumnDest.LabelsMargin := LChartCTColumnSrc.LabelsMargin;
    LChartCTColumnDest.ColumnsLabels.Indent := LChartCTColumnSrc.ColumnsLabels.Indent;
    LChartCTColumnDest.ColumnsTransparency := LChartCTColumnSrc.ColumnsTransparency;

    LChartCTColumnDest.ColumnAutoSize := LChartCTColumnSrc.ColumnAutoSize;
    LChartCTColumnDest.ColumnsStacked := LChartCTColumnSrc.ColumnsStacked;
    LChartCTColumnDest.FullStacked := LChartCTColumnSrc.FullStacked;
    LChartCTColumnDest.ColumnAutoSizeValue := LChartCTColumnSrc.ColumnAutoSizeValue;
    LChartCTColumnDest.ColumnCustomSize := LChartCTColumnSrc.ColumnCustomSize;
  end
  else if AFromChartType is TLMDChartCTBar then
  begin
    LChartCTBarSrc := AFromChartType as TLMDChartCTBar;
    LChartCTBarDest := AToChartType as TLMDChartCTBar;

    LChartCTBarDest.ShowColumnsLabels := LChartCTBarSrc.ShowColumnsLabels;
    LChartCTBarDest.ColumnsLabels.ShowBackground := LChartCTBarSrc.ColumnsLabels.ShowBackground;
    LChartCTBarDest.LabelsXDeviation := LChartCTBarSrc.LabelsXDeviation;
    LChartCTBarDest.LabelsYDeviation := LChartCTBarSrc.LabelsYDeviation;
    LChartCTBarDest.LabelsMargin := LChartCTBarSrc.LabelsMargin;
    LChartCTBarDest.ColumnsLabels.Indent := LChartCTBarSrc.ColumnsLabels.Indent;
    LChartCTBarDest.ColumnsTransparency := LChartCTBarSrc.ColumnsTransparency;

    LChartCTBarDest.ColumnAutoSize := LChartCTBarSrc.ColumnAutoSize;
    LChartCTBarDest.BarsStacked := LChartCTBarSrc.BarsStacked;
    LChartCTBarDest.FullStacked := LChartCTBarSrc.FullStacked;
    LChartCTBarDest.ColumnAutoSizeValue := LChartCTBarSrc.ColumnAutoSizeValue;
    LChartCTBarDest.ColumnCustomSize := LChartCTBarSrc.ColumnCustomSize;
  end
  else if AFromChartType is TLMDChartCTPie2D then
  begin
    LChartCTPie2DSrc := AFromChartType as TLMDChartCTPie2D;
    LChartCTPie2DDest := AToChartType as TLMDChartCTPie2D;

    LChartCTPie2DDest.ShowPercent := LChartCTPie2DSrc.ShowPercent;
    LChartCTPie2DDest.PiesLabels.ShowBackground := LChartCTPie2DSrc.PiesLabels.ShowBackground;
    LChartCTPie2DDest.LabelsXDeviation := LChartCTPie2DSrc.LabelsXDeviation;
    LChartCTPie2DDest.LabelsYDeviation := LChartCTPie2DSrc.LabelsYDeviation;
    LChartCTPie2DDest.LabelsMargin := LChartCTPie2DSrc.LabelsMargin;
    LChartCTPie2DDest.PiesLabels.Indent := LChartCTPie2DSrc.PiesLabels.Indent;
    LChartCTPie2DDest.PieTransparency := LChartCTPie2DSrc.PieTransparency;

    LChartCTPie2DDest.ExplodeAutoScale := LChartCTPie2DSrc.ExplodeAutoScale;
    LChartCTPie2DDest.Proportional := LChartCTPie2DSrc.Proportional;
  end
  else if AFromChartType is TLMDChartCTDoughnut then
  begin
    LChartCTDoughnutSrc := AFromChartType as TLMDChartCTDoughnut;
    LChartCTDoughnutDest := AToChartType as TLMDChartCTDoughnut;

    LChartCTDoughnutDest.ShowPercent := LChartCTDoughnutSrc.ShowPercent;
    LChartCTDoughnutDest.PiesLabels.ShowBackground := LChartCTDoughnutSrc.PiesLabels.ShowBackground;
    LChartCTDoughnutDest.LabelsXDeviation := LChartCTDoughnutSrc.LabelsXDeviation;
    LChartCTDoughnutDest.LabelsYDeviation := LChartCTDoughnutSrc.LabelsYDeviation;
    LChartCTDoughnutDest.LabelsMargin := LChartCTDoughnutSrc.LabelsMargin;
    LChartCTDoughnutDest.PiesLabels.Indent := LChartCTDoughnutSrc.PiesLabels.Indent;
    LChartCTDoughnutDest.PieTransparency := LChartCTDoughnutSrc.PieTransparency;
  end
  else if AFromChartType is TLMDChartCTAreaLine then
  begin
    LChartCTAreaLineSrc := AFromChartType as TLMDChartCTAreaLine;
    LChartCTAreaLineDest := AToChartType as TLMDChartCTAreaLine;

    LChartCTAreaLineDest.ShowAreaLabels := LChartCTAreaLineSrc.ShowAreaLabels;
    LChartCTAreaLineDest.AreaLabels.ShowBackground := LChartCTAreaLineSrc.AreaLabels.ShowBackground;
    LChartCTAreaLineDest.LabelsXDeviation := LChartCTAreaLineSrc.LabelsXDeviation;
    LChartCTAreaLineDest.LabelsYDeviation := LChartCTAreaLineSrc.LabelsYDeviation;
    LChartCTAreaLineDest.LabelsMargin := LChartCTAreaLineSrc.LabelsMargin;
    LChartCTAreaLineDest.AreaLabels.Indent := LChartCTAreaLineSrc.AreaLabels.Indent;
    LChartCTAreaLineDest.AreaTransparency := LChartCTAreaLineSrc.AreaTransparency;

    LChartCTAreaLineDest.AreaStacked := LChartCTAreaLineSrc.AreaStacked;
  end
  else if AFromChartType is TLMDChartCTAreaSpline then
  begin
    LChartCTAreaSplineSrc := AFromChartType as TLMDChartCTAreaSpline;
    LChartCTAreaSplineDest := AToChartType as TLMDChartCTAreaSpline;

    LChartCTAreaSplineDest.ShowAreaLabels := LChartCTAreaSplineSrc.ShowAreaLabels;
    LChartCTAreaSplineDest.AreaLabels.ShowBackground := LChartCTAreaSplineSrc.AreaLabels.ShowBackground;
    LChartCTAreaSplineDest.LabelsXDeviation := LChartCTAreaSplineSrc.LabelsXDeviation;
    LChartCTAreaSplineDest.LabelsYDeviation := LChartCTAreaSplineSrc.LabelsYDeviation;
    LChartCTAreaSplineDest.LabelsMargin := LChartCTAreaSplineSrc.LabelsMargin;
    LChartCTAreaSplineDest.AreaLabels.Indent := LChartCTAreaSplineSrc.AreaLabels.Indent;
    LChartCTAreaSplineDest.AreaTransparency := LChartCTAreaSplineSrc.AreaTransparency;

    LChartCTAreaSplineDest.AreaStacked := LChartCTAreaSplineSrc.AreaStacked;
  end
  else if AFromChartType is TLMDChartCTAreaLine3D then
  begin
    LChartCTAreaLine3DSrc := AFromChartType as TLMDChartCTAreaLine3D;
    LChartCTAreaLine3DDest := AToChartType as TLMDChartCTAreaLine3D;

    LChartCTAreaLine3DDest.ShowAreaLabels := LChartCTAreaLine3DSrc.ShowAreaLabels;
    LChartCTAreaLine3DDest.AreaLabels.ShowBackground := LChartCTAreaLine3DSrc.AreaLabels.ShowBackground;
    LChartCTAreaLine3DDest.LabelsXDeviation := LChartCTAreaLine3DSrc.LabelsXDeviation;
    LChartCTAreaLine3DDest.LabelsYDeviation := LChartCTAreaLine3DSrc.LabelsYDeviation;
    LChartCTAreaLine3DDest.LabelsMargin := LChartCTAreaLine3DSrc.LabelsMargin;
    LChartCTAreaLine3DDest.AreaLabels.Indent := LChartCTAreaLine3DSrc.AreaLabels.Indent;
    LChartCTAreaLine3DDest.AreaTransparency := LChartCTAreaLine3DSrc.AreaTransparency;

    LChartCTAreaLine3DDest.Shaded := LChartCTAreaLine3DDest.Shaded;
    LChartCTAreaLine3DDest.NoEdge := LChartCTAreaLine3DDest.NoEdge;
    LChartCTAreaLine3DDest.ChartDepth := LChartCTAreaLine3DDest.ChartDepth;
    LChartCTAreaLine3DDest.Indent3D := LChartCTAreaLine3DDest.Indent3D;
  end
  else if AFromChartType is TLMDChartCTAreaSpline3D then
  begin
    LChartCTAreaSpline3DSrc := AFromChartType as TLMDChartCTAreaSpline3D;
    LChartCTAreaSpline3DDest := AFromChartType as TLMDChartCTAreaSpline3D;

    LChartCTAreaSpline3DDest.ShowAreaLabels := LChartCTAreaSpline3DSrc.ShowAreaLabels;
    LChartCTAreaSpline3DDest.AreaLabels.ShowBackground := LChartCTAreaSpline3DSrc.AreaLabels.ShowBackground;
    LChartCTAreaSpline3DDest.LabelsXDeviation := LChartCTAreaSpline3DSrc.LabelsXDeviation;
    LChartCTAreaSpline3DDest.LabelsYDeviation := LChartCTAreaSpline3DSrc.LabelsYDeviation;
    LChartCTAreaSpline3DDest.LabelsMargin := LChartCTAreaSpline3DSrc.LabelsMargin;
    LChartCTAreaSpline3DDest.AreaLabels.Indent := LChartCTAreaSpline3DSrc.AreaLabels.Indent;
    LChartCTAreaSpline3DDest.AreaTransparency := LChartCTAreaSpline3DSrc.AreaTransparency;

    LChartCTAreaSpline3DDest.Shaded := LChartCTAreaSpline3DSrc.Shaded;
    LChartCTAreaSpline3DDest.NoEdge := LChartCTAreaSpline3DSrc.NoEdge;
    LChartCTAreaSpline3DDest.ChartDepth := LChartCTAreaSpline3DSrc.ChartDepth;
    LChartCTAreaSpline3DDest.Indent3D := LChartCTAreaSpline3DSrc.Indent3D;
  end
  else if AFromChartType is TLMDChartCTColumn3D then
  begin
    LChartCTColumn3DSrc := AFromChartType as TLMDChartCTColumn3D;
    LChartCTColumn3DDest := AToChartType as TLMDChartCTColumn3D;

    LChartCTColumn3DDest.ShowColumnsLabels := LChartCTColumn3DSrc.ShowColumnsLabels;
    LChartCTColumn3DDest.ColumnsLabels.ShowBackground := LChartCTColumn3DSrc.ColumnsLabels.ShowBackground;
    LChartCTColumn3DDest.LabelsXDeviation := LChartCTColumn3DSrc.LabelsXDeviation;
    LChartCTColumn3DDest.LabelsYDeviation := LChartCTColumn3DSrc.LabelsYDeviation;
    LChartCTColumn3DDest.LabelsMargin := LChartCTColumn3DSrc.LabelsMargin;
    LChartCTColumn3DDest.ColumnsLabels.Indent := LChartCTColumn3DSrc.ColumnsLabels.Indent;
    LChartCTColumn3DDest.ColumnsTransparency := LChartCTColumn3DSrc.ColumnsTransparency;

    LChartCTColumn3DDest.ColumnAutoSize := LChartCTColumn3DSrc.ColumnAutoSize;
    LChartCTColumn3DDest.Stacked := LChartCTColumn3DSrc.Stacked;
    LChartCTColumn3DDest.FullStacked := LChartCTColumn3DSrc.FullStacked;
    LChartCTColumn3DDest.ColumnAutoSizeValue := LChartCTColumn3DSrc.ColumnAutoSizeValue;
    LChartCTColumn3DDest.ColumnCustomSize := LChartCTColumn3DSrc.ColumnCustomSize;

    LChartCTColumn3DDest.ShadedBoxes := LChartCTColumn3DSrc.ShadedBoxes;
    LChartCTColumn3DDest.NoEdge := LChartCTColumn3DSrc.NoEdge;
    LChartCTColumn3DDest.ChartDepth := LChartCTColumn3DSrc.ChartDepth;
    LChartCTColumn3DDest.MultiRow := LChartCTColumn3DSrc.MultiRow;
    LChartCTColumn3DDest.MultiRowIndent := LChartCTColumn3DSrc.MultiRowIndent;
  end
  else if AFromChartType is TLMDChartCTBar then
  begin
    LChartCTBar3DSrc := AFromChartType as TLMDChartCTBar3D;
    LChartCTBar3DDest := AToChartType as TLMDChartCTBar3D;

    LChartCTBar3DDest.ShowColumnsLabels := LChartCTBar3DSrc.ShowColumnsLabels;
    LChartCTBar3DDest.ColumnsLabels.ShowBackground := LChartCTBar3DSrc.ColumnsLabels.ShowBackground;
    LChartCTBar3DDest.LabelsXDeviation := LChartCTBar3DSrc.LabelsXDeviation;
    LChartCTBar3DDest.LabelsYDeviation := LChartCTBar3DSrc.LabelsYDeviation;
    LChartCTBar3DDest.LabelsMargin := LChartCTBar3DSrc.LabelsMargin;
    LChartCTBar3DDest.ColumnsLabels.Indent := LChartCTBar3DSrc.ColumnsLabels.Indent;
    LChartCTBar3DDest.ColumnsTransparency := LChartCTBar3DSrc.ColumnsTransparency;

    LChartCTBar3DDest.ColumnAutoSize := LChartCTBar3DSrc.ColumnAutoSize;
    LChartCTBar3DDest.Stacked := LChartCTBar3DSrc.Stacked;
    LChartCTBar3DDest.FullStacked := LChartCTBar3DSrc.FullStacked;
    LChartCTBar3DDest.ColumnAutoSizeValue := LChartCTBar3DSrc.ColumnAutoSizeValue;
    LChartCTBar3DDest.ColumnCustomSize := LChartCTBar3DSrc.ColumnCustomSize;

    LChartCTBar3DDest.ShadedBoxes := LChartCTBar3DSrc.ShadedBoxes;
    LChartCTBar3DDest.NoEdge := LChartCTBar3DSrc.NoEdge;
    LChartCTBar3DDest.ChartDepth := LChartCTBar3DSrc.ChartDepth;
    LChartCTBar3DDest.MultiRow := LChartCTBar3DSrc.MultiRow;
    LChartCTBar3DDest.MultiRowIndent := LChartCTBar3DSrc.MultiRowIndent;
  end
end;
}

procedure TLMDChartEditor.Edit(AChart: TLMDChart);
var
  Lx, Ly: integer;
begin
  FChart := AChart;
  FForm := LMDGetOwnerForm(AChart);

  //after the chart model update the editor works with the chart component on the user's form directly,
  //not with its editor copy (cancel-ability is sacrificed to simplicity)
  FChartPreview := AChart;
  //CopyChartSettings(FChart, ChartPreview);

  if Assigned(ChartPreview) then
    FCurChartType := ChartPreview.ChartType
  else
    FCurChartType := nil;

  Self.FProgrammaticUpdate := true;

  DisplayChartData;
  SetUpChartTypeEditors;
  DisplayChartTypeSettings;

  //displaying various options:

  //general options
  chbVerticalGridLines.Checked := ChartPreview.ChartArea.MajorGridVertical;
  chbHorizontalGridLines.Checked := ChartPreview.ChartArea.MajorGridHorizontal;
  chbChartAreaMarkers.Checked := ChartPreview.ChartArea.ShowMarkers;
  chbChartAreaShadow.Checked := ChartPreview.ChartArea.Shadow;
  tbChartAreaShadowTransparency.Position := ChartPreview.ChartArea.ShadowTransparency;
  tbChartAreaShadowDepth.Position := ChartPreview.ChartArea.ShadowDepth;

  meChartAreaInnerIndents.SETopMargin.Value := ChartPreview.ChartArea.InnerIndentTop;
  meChartAreaInnerIndents.SELeftMargin.Value := ChartPreview.ChartArea.InnerIndentLeft;
  meChartAreaInnerIndents.SEBottomMargin.Value := ChartPreview.ChartArea.InnerIndentBottom;
  meChartAreaInnerIndents.SERightMargin.Value := ChartPreview.ChartArea.InnerIndentRight;

  meChartAreaMargins.SETopMargin.Value := ChartPreview.ChartArea.MarginTop;
  meChartAreaMargins.SELeftMargin.Value := ChartPreview.ChartArea.MarginLeft;
  meChartAreaMargins.SEBottomMargin.Value := ChartPreview.ChartArea.MarginBottom;
  meChartAreaMargins.SERightMargin.Value := ChartPreview.ChartArea.MarginRight;

  //legend options
  chbShowLegend.Checked := ChartPreview.Legend.Show;
  chbLegendMayOverlap.Checked := ChartPreview.Legend.Overlap;
  tbLegendIconSize.Position := ChartPreview.Legend.IconSize;
  tbLegendSpaceAfterIcon.Position := ChartPreview.Legend.SpaceAfterIcon;
  tbLegendIntervalBetweenLines.Position := ChartPreview.Legend.SpaceBtwLines;
  if ChartPreview.Legend.HorizontalListing then
    rgLegendLayout.ItemIndex := 1
  else
    rgLegendLayout.ItemIndex := 0;

  Lx := 0; Ly := 0;
  case ChartPreview.Legend.Alignment of
  laTopLeft:      begin Lx := 0; Ly := 0; end;
  laLeft:         begin Lx := 0; Ly := 1; end;
  laBottomLeft:   begin Lx := 0; Ly := 2; end;
  laTop:          begin Lx := 1; Ly := 0; end;
  laAbsolute:     begin Lx := 1; Ly := 1; end;
  laBottom:       begin Lx := 1; Ly := 2; end;
  laTopRight:     begin Lx := 2; Ly := 0; end;
  laRight:        begin Lx := 2; Ly := 1; end;
  laBottomRight:  begin Lx := 2; Ly := 2; end;
  end;
  aeLegendAlignment.SelX := Lx;
  aeLegendAlignment.SelY := Ly;

  //axis options
  cbXAxisValueType.ItemIndex := Integer(ChartPreview.ChartArea.XAxis.ValuesType);
  cbYAxisValueType.ItemIndex := Integer(ChartPreview.ChartArea.YAxis.ValuesType);
  rgXAxisMajorTicks.ItemIndex := Integer(ChartPreview.ChartArea.XAxis.MajorTick);
  rgXAxisMinorTicks.ItemIndex := Integer(ChartPreview.ChartArea.XAxis.MinorTick);
  rgYAxisMajorTicks.ItemIndex := Integer(ChartPreview.ChartArea.YAxis.MajorTick);
  rgYAxisMinorTicks.ItemIndex := Integer(ChartPreview.ChartArea.YAxis.MinorTick);
  edXAxisMajorTickSize.Text := IntToStr(ChartPreview.ChartArea.XAxis.MajorTickSize);
  edXAxisMinorTickSize.Text := IntToStr(ChartPreview.ChartArea.XAxis.MinorTickSize);
  edYAxisMajorTickSize.Text := IntToStr(ChartPreview.ChartArea.YAxis.MajorTickSize);
  edYAxisMinorTickSize.Text := IntToStr(ChartPreview.ChartArea.YAxis.MinorTickSize);
  edYMinValue.Text := IntToStr(ChartPreview.ChartArea.YAxis.MinValue);
  edYMaxValue.Text := IntToStr(ChartPreview.ChartArea.YAxis.MaxValue);
  edYAxisMajorStep.Text := VarToStr(ChartPreview.ChartArea.YAxis.MajorStep);
  edYAxisMinorStep.Text := VarToStr(ChartPreview.ChartArea.YAxis.MinorStep);

  chbYAxisAutoScale.Checked := ChartPreview.ChartArea.YAxis.AutoScale;
  //chbYAxisInverted.Checked := ChartPreview.ChartArea.YAxis.Inverted;
  chbYAxisStacked.Checked := ChartPreview.ChartArea.YAxis.ChartStacked;

  //title box options
  SetXYByLMDChartAlignment(ChartPreview.TitleBox.Alignment, aeTitleBoxAlignment);
  SetXYByLMDChartAlignment(ChartPreview.TitleBox.IconAlignment, aeHeaderIconAlignment);

  meTitleBoxMargins.SETopMargin.Value := ChartPreview.TitleBox.InnerIndentTop;
  meTitleBoxMargins.SELeftMargin.Value := ChartPreview.TitleBox.InnerIndentLeft;
  meTitleBoxMargins.SEBottomMargin.Value := ChartPreview.TitleBox.InnerIndentBottom;
  meTitleBoxMargins.SERightMargin.Value := ChartPreview.TitleBox.InnerIndentRight;

  tbTitleBoxChartMargin.Position := ChartPreview.TitleBox.MarginChart;
  tbTitleBoxEdgeMargin.Position := ChartPreview.TitleBox.MarginEdge;

  edHeaderText.Text := ChartPreview.TitleBox.Text;

  Self.FProgrammaticUpdate := false;

  ShowModal;
  {
  if ShowModal = mrOK then
  begin
    CopyChartSettings(ChartPreview, FChart);
  end;
  }
end;

procedure TLMDChartEditor.DisplayChartData;
var
  i: integer;
begin
  Self.pcChartSeriesValues.Tabs.Clear;
  for i := 0 to ChartPreview.SeriesObjects.Count - 1 do
  begin
    if Assigned(ChartPreview.SeriesObjects.Items[i].Series) then
      pcChartSeriesValues.Tabs.AddObject(ChartPreview.SeriesObjects.Items[i].Series.SeriesName, ChartPreview.SeriesObjects.Items[i])
    else
      pcChartSeriesValues.Tabs.AddObject('Unassigned', nil);
  end;
  Self.AdjustChartDataTabControl;
end;

procedure TLMDChartEditor.DisplayChartValues(ASeries: TLMDCustomChartSeries);
var
  i, j: integer;
begin
  if not Assigned(ASeries) then
        Exit;

  seRowCount.Value := ASeries.ChartValuesCollection.NumberOfValues;
  sgData.RowCount := seRowCount.Value + sgData.FixedRows;
  sgData.ColCount := ASeries.ChartValuesCollection.Count;

  for i := 0 to ASeries.ChartValuesCollection.Count - 1 do
  begin
    if Assigned(ASeries.ChartValuesCollection.Items[i].ChartValues) then
    begin
      sgData.Cells[i, 0] := ASeries.ChartValuesCollection.Items[i].ChartValues.Name;
      sgData.Cells[i, 1] := ASeries.ChartValuesCollection.Items[i].ChartValues.Caption;
      sgData.Cells[i, 2] := ChartValueTypeToStr(ASeries.ChartValuesCollection.Items[i].ChartValues.ValueType);
      for j := 0 to ASeries.ChartValuesCollection.Items[i].ChartValues.Count - 1 do
        sgData.Cells[i, j + sgData.FixedRows] := VarToStr(ASeries.ChartValuesCollection.Items[i].ChartValues.Values[j]);
    end;
  end;
end;

procedure TLMDChartEditor.FormCreate(Sender: TObject);
begin
  FDistPosEditor := TLMDDistanceAndSizeEditor.Create(Self);
  FLineEditor := TLMDLineEditor.Create(Self);
  FFillEditor := TLMDAreaFillEditor.Create(Self);
end;

procedure TLMDChartEditor.btLegendIndentsDefineClick(Sender: TObject);
begin
  if FDistPosEditor.Edit then
  begin
    ChartPreview.Legend.InnerIndentLeft := FDistPosEditor.LeftMargin;
    ChartPreview.Legend.InnerIndentBottom := FDistPosEditor.BottomMargin;
    ChartPreview.Legend.InnerIndentRight := FDistPosEditor.RightMargin;
    ChartPreview.Legend.InnerIndentTop := FDistPosEditor.TopMargin;
  end;
end;

procedure TLMDChartEditor.btLegendEdgeClick(Sender: TObject);
begin
  FLineEditor.Edit(ChartPreview.Legend.Edge);
end;

procedure TLMDChartEditor.btLegendBackgroundClick(Sender: TObject);
begin
  FFillEditor.Edit(ChartPreview.Legend.Background);
end;

procedure TLMDChartEditor.btChartBackgroundClick(Sender: TObject);
begin
  FFillEditor.Edit(ChartPreview.Background);
end;

procedure TLMDChartEditor.btChartAreaBackgroundClick(Sender: TObject);
begin
  FFillEditor.Edit(ChartPreview.ChartArea.Background);
end;

procedure TLMDChartEditor.btEdgeClick(Sender: TObject);
begin
  FLineEditor.Edit(ChartPreview.ChartArea.Edge);
end;

procedure TLMDChartEditor.chbVerticalGridLinesClick(Sender: TObject);
begin
  ChartPreview.ChartArea.MajorGridVertical := chbVerticalGridLines.Checked;
end;

procedure TLMDChartEditor.chbHorizontalGridLinesClick(Sender: TObject);
begin
  ChartPreview.ChartArea.MajorGridHorizontal := chbHorizontalGridLines.Checked;
end;

procedure TLMDChartEditor.btMajorVerticalGridLineClick(Sender: TObject);
begin
  FLineEditor.Edit(ChartPreview.ChartArea.MajorGridLineVertical);
end;

procedure TLMDChartEditor.btMajorHorizontalGridLineClick(Sender: TObject);
begin
  FLineEditor.Edit(ChartPreview.ChartArea.MajorGridLineHorizontal);
end;

procedure TLMDChartEditor.chbChartAreaMarkersClick(Sender: TObject);
begin
  ChartPreview.ChartArea.ShowMarkers := chbChartAreaMarkers.Checked;
end;

procedure TLMDChartEditor.meChartAreaInnerIndentsBottomMarginChange(
  Sender: TObject);
begin
  ChartPreview.ChartArea.InnerIndentBottom := meChartAreaInnerIndents.SEBottomMargin.Value;
end;

procedure TLMDChartEditor.meChartAreaInnerIndentsLeftMarginChange(
  Sender: TObject);
begin
  ChartPreview.ChartArea.InnerIndentLeft := meChartAreaInnerIndents.SELeftMargin.Value;
end;

procedure TLMDChartEditor.meChartAreaInnerIndentsRightMarginChange(
  Sender: TObject);
begin
  ChartPreview.ChartArea.InnerIndentRight := meChartAreaInnerIndents.SERightMargin.Value;
end;

procedure TLMDChartEditor.meChartAreaInnerIndentsTopMarginChange(
  Sender: TObject);
begin
  ChartPreview.ChartArea.InnerIndentTop := meChartAreaInnerIndents.SETopMargin.Value;
end;

procedure TLMDChartEditor.meChartAreaMarginsBottomMarginChange(
  Sender: TObject);
begin
  ChartPreview.ChartArea.MarginBottom := meChartAreaMargins.SEBottomMargin.Value;
end;

procedure TLMDChartEditor.meChartAreaMarginsLeftMarginChange(
  Sender: TObject);
begin
  ChartPreview.ChartArea.MarginLeft := meChartAreaMargins.SELeftMargin.Value;
end;

procedure TLMDChartEditor.meChartAreaMarginsRightMarginChange(
  Sender: TObject);
begin
  ChartPreview.ChartArea.MarginRight := meChartAreaMargins.SERightMargin.Value;
end;

procedure TLMDChartEditor.meChartAreaMarginsTopMarginChange(
  Sender: TObject);
begin
  ChartPreview.ChartArea.MarginTop := meChartAreaMargins.SETopMargin.Value;
end;

procedure TLMDChartEditor.chbChartAreaShadowClick(Sender: TObject);
begin
  ChartPreview.ChartArea.Shadow := chbChartAreaShadow.Checked;
end;

procedure TLMDChartEditor.btChartAreaShadowColorClick(Sender: TObject);
begin
  if ColorDialog1.Execute then
    ChartPreview.ChartArea.ShadowColor := ColorDialog1.Color;
end;

procedure TLMDChartEditor.tbChartAreaShadowTransparencyChange(
  Sender: TObject);
begin
  ChartPreview.ChartArea.ShadowTransparency := tbChartAreaShadowTransparency.Position;
end;

procedure TLMDChartEditor.tbChartAreaShadowDepthChange(Sender: TObject);
begin
  ChartPreview.ChartArea.ShadowDepth := tbChartAreaShadowDepth.Position;
end;

procedure TLMDChartEditor.chbShowLegendClick(Sender: TObject);
begin
  ChartPreview.Legend.Show := chbShowLegend.Checked;
end;

procedure TLMDChartEditor.chbLegendMayOverlapClick(Sender: TObject);
begin
  ChartPreview.Legend.Overlap := chbLegendMayOverlap.Checked;
end;

procedure TLMDChartEditor.btLegendFontClick(Sender: TObject);
begin
  FontDialog1.Font.Assign(ChartPreview.Legend.Font);
  if FontDialog1.Execute then
    ChartPreview.Legend.Font.Assign(FontDialog1.Font);
end;

procedure TLMDChartEditor.tbLegendIconSizeChange(Sender: TObject);
begin
  ChartPreview.Legend.IconSize := tbLegendIconSize.Position;
end;

procedure TLMDChartEditor.tbLegendSpaceAfterIconChange(Sender: TObject);
begin
  ChartPreview.Legend.SpaceAfterIcon := tbLegendSpaceAfterIcon.Position;
end;

procedure TLMDChartEditor.tbLegendIntervalBetweenLinesChange(
  Sender: TObject);
begin
  ChartPreview.Legend.SpaceBtwLines := tbLegendIntervalBetweenLines.Position;
end;

procedure TLMDChartEditor.rgLegendLayoutClick(Sender: TObject);
begin
  ChartPreview.Legend.HorizontalListing := rgLegendLayout.ItemIndex = 1;
end;

procedure TLMDChartEditor.aeLegendAlignmentChange(Sender: TObject);
var
  Lbx, Lby: integer;
  LAlign: TLMDLegendAlignment;
begin
  Lbx := aeLegendAlignment.SelX;
  Lby := aeLegendAlignment.SelY;
  LAlign := laTopLeft;
  if (Lbx = 0) and (Lby = 0) then
    LAlign := laTopLeft
  else if (Lbx = 0) and (Lby = 1) then
    LAlign := laLeft
  else if (Lbx = 0) and (Lby = 2) then
    LAlign := laBottomLeft
  else if (Lbx = 1) and (Lby = 0) then
    LAlign := laTop
  else if (Lbx = 1) and (Lby = 1) then
    LAlign := laAbsolute
  else if (Lbx = 1) and (Lby = 2) then
    LAlign := laBottom
  else if (Lbx = 2) and (Lby = 0) then
    LAlign := laTopRight
  else if (Lbx = 2) and (Lby = 1) then
    LAlign := laRight
  else if (Lbx = 2) and (Lby = 2) then
    LAlign := laBottomRight;
  ChartPreview.Legend.Alignment := LAlign;
end;

procedure TLMDChartEditor.btXAxisFontClick(Sender: TObject);
begin
  FontDialog1.Font.Assign(ChartPreview.ChartArea.XAxis.Font);
  if FontDialog1.Execute then
    ChartPreview.ChartArea.XAxis.Font.Assign(FontDialog1.Font);
end;

procedure TLMDChartEditor.btYAxisFontClick(Sender: TObject);
begin
FontDialog1.Font.Assign(ChartPreview.ChartArea.YAxis.Font);
  if FontDialog1.Execute then
    ChartPreview.ChartArea.YAxis.Font.Assign(FontDialog1.Font);
end;

procedure TLMDChartEditor.btXAxisLineClick(Sender: TObject);
begin
  //FLineEditor.Edit(ChartPreview.ChartArea.XAxis.Line);
end;

procedure TLMDChartEditor.btYAxisLineClick(Sender: TObject);
begin
  //FLineEditor.Edit(ChartPreview.ChartArea.YAxis.Line);
end;

procedure TLMDChartEditor.rgXAxisMajorTicksClick(Sender: TObject);
begin
  ChartPreview.ChartArea.XAxis.MajorTick := TLMDChartTickTypes(rgXAxisMajorTicks.ItemIndex);
end;

procedure TLMDChartEditor.rgXAxisMinorTicksClick(Sender: TObject);
begin
  ChartPreview.ChartArea.XAxis.MinorTick := TLMDChartTickTypes(rgXAxisMinorTicks.ItemIndex);
end;

procedure TLMDChartEditor.rgYAxisMajorTicksClick(Sender: TObject);
begin
  ChartPreview.ChartArea.YAxis.MajorTick := TLMDChartTickTypes(rgYAxisMajorTicks.ItemIndex);
end;

procedure TLMDChartEditor.rgYAxisMinorTicksClick(Sender: TObject);
begin
  ChartPreview.ChartArea.YAxis.MinorTick := TLMDChartTickTypes(rgYAxisMinorTicks.ItemIndex);
end;

procedure TLMDChartEditor.chbYAxisAutoScaleClick(Sender: TObject);
begin
  ChartPreview.ChartArea.YAxis.AutoScale := chbYAxisAutoScale.Checked;
end;

procedure TLMDChartEditor.chbYAxisStackedClick(Sender: TObject);
begin
  ChartPreview.ChartArea.YAxis.ChartStacked := chbYAxisStacked.Checked;
end;

procedure TLMDChartEditor.chbYAxisInvertedClick(Sender: TObject);
begin
  //ChartPreview.ChartArea.YAxis.Inverted := chbYAxisInverted.Checked;
end;

procedure TLMDChartEditor.cbXAxisValueTypeChange(Sender: TObject);
begin
  ChartPreview.ChartArea.XAxis.ValuesType :=
    TLMDChartAxisValuesTypes(cbXAxisValueType.ItemIndex);
end;

procedure TLMDChartEditor.cbYAxisValueTypeChange(Sender: TObject);
begin
  ChartPreview.ChartArea.YAxis.ValuesType :=
    TLMDChartAxisValuesTypes(cbYAxisValueType.ItemIndex);
end;

procedure TLMDChartEditor.edXAxisMajorTickSizeChange(Sender: TObject);
begin
  try
    ChartPreview.ChartArea.XAxis.MajorTickSize := StrToInt(edXAxisMajorTickSize.Text);
  except
    on E: Exception do;
  end;
end;

procedure TLMDChartEditor.edXAxisMinorTickSizeChange(Sender: TObject);
begin
  try
    ChartPreview.ChartArea.XAxis.MinorTickSize := StrToInt(edXAxisMinorTickSize.Text);
  except
    on E: Exception do;
  end;
end;

procedure TLMDChartEditor.edYAxisMajorTickSizeChange(Sender: TObject);
begin
  try
    ChartPreview.ChartArea.YAxis.MajorTickSize := StrToInt(edYAxisMajorTickSize.Text);
  except
    on E: Exception do;
  end;
end;

procedure TLMDChartEditor.edYAxisMinorTickSizeChange(Sender: TObject);
begin
  try
    ChartPreview.ChartArea.YAxis.MinorTickSize := StrToInt(edYAxisMinorTickSize.Text);
  except
    on E: Exception do;
  end;
end;

procedure TLMDChartEditor.edYAxisMajorStepChange(Sender: TObject);
begin
  try
    ChartPreview.ChartArea.YAxis.MajorStep := StrToFloat(edYAxisMajorStep.Text);
  except
    on E: Exception do;
  end;
end;

procedure TLMDChartEditor.edYAxisMinorStepChange(Sender: TObject);
begin
  try
    ChartPreview.ChartArea.YAxis.MinorStep := StrToFloat(edYAxisMinorStep.Text);
  except
    on E: Exception do;
  end;
end;

procedure TLMDChartEditor.edHeaderTextChange(Sender: TObject);
begin
  ChartPreview.TitleBox.Text := edHeaderText.Text;
end;

procedure TLMDChartEditor.Button2Click(Sender: TObject);
begin
  FLineEditor.Edit(ChartPreview.TitleBox.Edge);
end;

procedure TLMDChartEditor.Button1Click(Sender: TObject);
begin
  FFillEditor.Edit(ChartPreview.TitleBox.Background);
end;

procedure TLMDChartEditor.Button3Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(ChartPreview.TitleBox.Font);
  if FontDialog1.Execute then
    ChartPreview.TitleBox.Font.Assign(FontDialog1.Font);
end;

procedure TLMDChartEditor.meTitleBoxMarginsBottomMarginChange(
  Sender: TObject);
begin
  ChartPreview.TitleBox.InnerIndentBottom := meTitleBoxMargins.SEBottomMargin.Value;
end;

procedure TLMDChartEditor.meTitleBoxMarginsLeftMarginChange(
  Sender: TObject);
begin
  ChartPreview.TitleBox.InnerIndentLeft := meTitleBoxMargins.SELeftMargin.Value;
end;

procedure TLMDChartEditor.meTitleBoxMarginsRightMarginChange(
  Sender: TObject);
begin
  ChartPreview.TitleBox.InnerIndentRight := meTitleBoxMargins.SERightMargin.Value;
end;

procedure TLMDChartEditor.meTitleBoxMarginsTopMarginChange(
  Sender: TObject);
begin
  ChartPreview.TitleBox.InnerIndentTop := meTitleBoxMargins.SETopMargin.Value;
end;

procedure TLMDChartEditor.tbTitleBoxChartMarginChange(Sender: TObject);
begin
  ChartPreview.TitleBox.MarginChart := tbTitleBoxChartMargin.Position;
end;

procedure TLMDChartEditor.tbTitleBoxEdgeMarginChange(Sender: TObject);
begin
  ChartPreview.TitleBox.MarginEdge := tbTitleBoxEdgeMargin.Position;
end;

procedure TLMDChartEditor.aeTitleBoxAlignmentChange(Sender: TObject);
begin
  ChartPreview.TitleBox.Alignment :=
    GetLMDChartAlignmentByXY(aeTitleBoxAlignment.SelX, aeTitleBoxAlignment.SelY);
end;

function TLMDChartEditor.GetLMDChartAlignmentByXY(Ax,
  Ay: integer): TLMDChartAlignment;
begin
  Result := caTop;
  if (Ax = 0) and (Ay = 1) then
    Result := caLeft
  else if (Ax = 1) and (Ay = 2) then
    Result := caBottom
  else if (Ax = 2) and (Ay = 1) then
    Result := caRigth;
end;

procedure TLMDChartEditor.aeHeaderIconAlignmentChange(Sender: TObject);
begin
  ChartPreview.TitleBox.IconAlignment :=
    GetLMDChartAlignmentByXY(aeHeaderIconAlignment.SelX, aeHeaderIconAlignment.SelY);
end;

procedure TLMDChartEditor.btHeaderIconClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
    ChartPreview.TitleBox.Icon.LoadFromFile(OpenPictureDialog1.FileName);
end;

procedure TLMDChartEditor.SetXYByLMDChartAlignment(
  AAlign: TLMDChartAlignment; AEditor: TLMDAlignmentEditor);
var
  Lx, Ly: integer;
begin
  Lx := 0; Ly := 0;
  case AAlign of
  caTop:    begin Lx := 1; Ly := 0; end;
  caLeft:   begin Lx := 0; Ly := 1; end;
  caBottom: begin Lx := 1; Ly := 2; end;
  caRigth:  begin Lx := 2; Ly := 1; end;
  end;
  AEditor.SelX := Lx;
  AEditor.SelY := Ly;
end;

procedure TLMDChartEditor.SetUpChartTypeEditors;
begin
  if FCurChartType = nil then
  begin
    pcSpecificCTOptions.Visible := false;
    Exit;
  end;

  pcSpecificCTOptions.Visible := true;
  tsCT3DOptions.TabVisible := IsChart3D;

  chbCTAutoSize.Visible := (FCurChartType is TLMDChartCTColumn)
                                  or (FCurChartType is TLMDChartCTBar)
                                  or (FCurChartType is TLMDChartCTColumn3D)
                                  or (FCurChartType is TLMDChartCTBar3D);
  lbCTAutoSizeValue.Visible := chbCTAutoSize.Visible;
  tbCTAutoSizeValue.Visible := chbCTAutoSize.Visible;
  lbCTCustomSize.Visible := chbCTAutoSize.Visible;
  tbCTCustomSize.Visible := chbCTAutoSize.Visible;
  chbCTAutoSizeClick(nil);

  chbCTStacked.Visible := not ((FCurChartType is TLMDChartCTPie2D)
                                  or (FCurChartType is TLMDChartCTDoughnut)
                                    );
  chbCTFullStacked.Visible := (FCurChartType is TLMDChartCTColumn)
                                  or (FCurChartType is TLMDChartCTBar)
                                  or (FCurChartType is TLMDChartCTColumn3D)
                                  or (FCurChartType is TLMDChartCTBar3D);

  chbCTMultiRow.Visible := (FCurChartType is TLMDChartCTColumn3D)
                                  or (FCurChartType is TLMDChartCTBar3D);
  tbCTIndent3D.Visible := ((FCurChartType is TLMDChartCTColumn3D) and (FCurChartType as TLMDChartCTColumn3D).MultiRow)
                                  or ((FCurChartType is TLMDChartCTBar3D) and (FCurChartType as TLMDChartCTBar3D).MultiRow)
                                  or (FCurChartType is TLMDChartCTAreaLine3D)
                                  or (FCurChartType is TLMDChartCTAreaSpline3D);
  lbCTIndent3D.Visible := tbCTIndent3D.Visible;

  chbCTExplodeAutoScale.Visible := (FCurChartType is TLMDChartCTPie2D)
                                  or (FCurChartType is TLMDChartCTDoughnut);
  chbCTProportional.Visible := FCurChartType is TLMDChartCTPie2D;

  btCTLeftZGrid.Visible := (FCurChartType is TLMDChartCTColumn3D)
                                  or (FCurChartType is TLMDChartCTAreaLine3D)
                                  or (FCurChartType is TLMDChartCTAreaSpline3D);
  btCTBottomZMajorGrid.Visible := FCurChartType is TLMDChartCTColumn3D;
  btCTBottomZMinorGrid.Visible := btCTBottomZMajorGrid.Visible;
end;

procedure TLMDChartEditor.chbCTShowLabelsClick(Sender: TObject);
begin
  ApplyChartTypeSettings;
end;

procedure TLMDChartEditor.ApplyChartTypeSettings;
var
  LChartCTAreaSpline3D: TLMDChartCTAreaSpline3D;
  LChartCTAreaSpline: TLMDChartCTAreaSpline;
  LChartCTAreaLine3D: TLMDChartCTAreaLine3D;
  LChartCTAreaLine: TLMDChartCTAreaLine;
  LChartCTDoughnut: TLMDChartCTDoughnut;
  LChartCTPie2D: TLMDChartCTPie2D;
  LChartCTBar3D: TLMDChartCTBar3D;
  LChartCTBar: TLMDChartCTBar;
  LChartCTColumn3D: TLMDChartCTColumn3D;
  LChartCTColumn: TLMDChartCTColumn;
begin
  if Self.FProgrammaticUpdate then
    Exit;
  if FCurChartType is TLMDChartCTColumn then
  begin
    LChartCTColumn := FCurChartType as TLMDChartCTColumn;

    LChartCTColumn.ShowColumnsLabels := chbCTShowLabels.Checked;
    LChartCTColumn.ColumnsLabels.ShowBackground := chbCTShowLabelsBackground.Checked;
    LChartCTColumn.LabelsXDeviation := tbCTLabelsXDeviation.Position;
    LChartCTColumn.LabelsYDeviation := tbCTLabelsYDeviation.Position;
    LChartCTColumn.LabelsMargin := tbCTLabelsMargin.Position;
    LChartCTColumn.ColumnsLabels.Indent := tbCTLabelsIndent.Position;
    LChartCTColumn.ColumnsTransparency := tbCTTransparency.Position;

    LChartCTColumn.ColumnAutoSize := chbCTAutoSize.Checked;
    LChartCTColumn.ColumnsStacked := chbCTStacked.Checked;
    LChartCTColumn.FullStacked := chbCTFullStacked.Checked;
    LChartCTColumn.ColumnAutoSizeValue := tbCTAutoSizeValue.Position;
    LChartCTColumn.ColumnCustomSize := tbCTCustomSize.Position;
  end
  else if FCurChartType is TLMDChartCTBar then
  begin
    LChartCTBar := FCurChartType as TLMDChartCTBar;

    LChartCTBar.ShowColumnsLabels := chbCTShowLabels.Checked;
    LChartCTBar.ColumnsLabels.ShowBackground := chbCTShowLabelsBackground.Checked;
    LChartCTBar.LabelsXDeviation := tbCTLabelsXDeviation.Position;
    LChartCTBar.LabelsYDeviation := tbCTLabelsYDeviation.Position;
    LChartCTBar.LabelsMargin := tbCTLabelsMargin.Position;
    LChartCTBar.ColumnsLabels.Indent := tbCTLabelsIndent.Position;
    LChartCTBar.ColumnsTransparency := tbCTTransparency.Position;

    LChartCTBar.ColumnAutoSize := chbCTAutoSize.Checked;
    LChartCTBar.BarsStacked := chbCTStacked.Checked;
    LChartCTBar.FullStacked := chbCTFullStacked.Checked;
    LChartCTBar.ColumnAutoSizeValue := tbCTAutoSizeValue.Position;
    LChartCTBar.ColumnCustomSize := tbCTCustomSize.Position;
  end
  else if FCurChartType is TLMDChartCTPie2D then
  begin
    LChartCTPie2D := FCurChartType as TLMDChartCTPie2D;

    LChartCTPie2D.ShowPercent := chbCTShowLabels.Checked;
    LChartCTPie2D.PiesLabels.ShowBackground := chbCTShowLabelsBackground.Checked;
    LChartCTPie2D.LabelsXDeviation := tbCTLabelsXDeviation.Position;
    LChartCTPie2D.LabelsYDeviation := tbCTLabelsYDeviation.Position;
    LChartCTPie2D.LabelsMargin := tbCTLabelsMargin.Position;
    LChartCTPie2D.PiesLabels.Indent := tbCTLabelsIndent.Position;
    LChartCTPie2D.PieTransparency := tbCTTransparency.Position;

    LChartCTPie2D.ExplodeAutoScale := chbCTExplodeAutoScale.Checked;
    LChartCTPie2D.Proportional := chbCTProportional.Checked;
  end
  else if FCurChartType is TLMDChartCTDoughnut then
  begin
    LChartCTDoughnut := FCurChartType as TLMDChartCTDoughnut;

    LChartCTDoughnut.ShowPercent := chbCTShowLabels.Checked;
    LChartCTDoughnut.PiesLabels.ShowBackground := chbCTShowLabelsBackground.Checked;
    LChartCTDoughnut.LabelsXDeviation := tbCTLabelsXDeviation.Position;
    LChartCTDoughnut.LabelsYDeviation := tbCTLabelsYDeviation.Position;
    LChartCTDoughnut.LabelsMargin := tbCTLabelsMargin.Position;
    LChartCTDoughnut.PiesLabels.Indent := tbCTLabelsIndent.Position;
    LChartCTDoughnut.PieTransparency := tbCTTransparency.Position;
  end
  else if FCurChartType is TLMDChartCTAreaLine then
  begin
    LChartCTAreaLine := FCurChartType as TLMDChartCTAreaLine;

    LChartCTAreaLine.ShowAreaLabels := chbCTShowLabels.Checked;
    LChartCTAreaLine.AreaLabels.ShowBackground := chbCTShowLabelsBackground.Checked;
    LChartCTAreaLine.LabelsXDeviation := tbCTLabelsXDeviation.Position;
    LChartCTAreaLine.LabelsYDeviation := tbCTLabelsYDeviation.Position;
    LChartCTAreaLine.LabelsMargin := tbCTLabelsMargin.Position;
    LChartCTAreaLine.AreaLabels.Indent := tbCTLabelsIndent.Position;
    LChartCTAreaLine.AreaTransparency := tbCTTransparency.Position;

    LChartCTAreaLine.AreaStacked := chbCTStacked.Checked;
  end
  else if FCurChartType is TLMDChartCTAreaSpline then
  begin
    LChartCTAreaSpline := FCurChartType as TLMDChartCTAreaSpline;

    LChartCTAreaSpline.ShowAreaLabels := chbCTShowLabels.Checked;
    LChartCTAreaSpline.AreaLabels.ShowBackground := chbCTShowLabelsBackground.Checked;
    LChartCTAreaSpline.LabelsXDeviation := tbCTLabelsXDeviation.Position;
    LChartCTAreaSpline.LabelsYDeviation := tbCTLabelsYDeviation.Position;
    LChartCTAreaSpline.LabelsMargin := tbCTLabelsMargin.Position;
    LChartCTAreaSpline.AreaLabels.Indent := tbCTLabelsIndent.Position;
    LChartCTAreaSpline.AreaTransparency := tbCTTransparency.Position;

    LChartCTAreaSpline.AreaStacked := chbCTStacked.Checked;
  end
  else if FCurChartType is TLMDChartCTAreaLine3D then
  begin
    LChartCTAreaLine3D := FCurChartType as TLMDChartCTAreaLine3D;

    LChartCTAreaLine3D.ShowAreaLabels := chbCTShowLabels.Checked;
    LChartCTAreaLine3D.AreaLabels.ShowBackground := chbCTShowLabelsBackground.Checked;
    LChartCTAreaLine3D.LabelsXDeviation := tbCTLabelsXDeviation.Position;
    LChartCTAreaLine3D.LabelsYDeviation := tbCTLabelsYDeviation.Position;
    LChartCTAreaLine3D.LabelsMargin := tbCTLabelsMargin.Position;
    LChartCTAreaLine3D.AreaLabels.Indent := tbCTLabelsIndent.Position;
    LChartCTAreaLine3D.AreaTransparency := tbCTTransparency.Position;

    LChartCTAreaLine3D.Shaded := chbCTShaded.Checked;
    LChartCTAreaLine3D.NoEdge := chbCTNoEdge.Checked;
    LChartCTAreaLine3D.ChartDepth := tbChartDepth.Position;
    LChartCTAreaLine3D.Indent3D := tbCTIndent3D.Position;
  end
  else if FCurChartType is TLMDChartCTAreaSpline3D then
  begin
    LChartCTAreaSpline3D := FCurChartType as TLMDChartCTAreaSpline3D;

    LChartCTAreaSpline3D.ShowAreaLabels := chbCTShowLabels.Checked;
    LChartCTAreaSpline3D.AreaLabels.ShowBackground := chbCTShowLabelsBackground.Checked;
    LChartCTAreaSpline3D.LabelsXDeviation := tbCTLabelsXDeviation.Position;
    LChartCTAreaSpline3D.LabelsYDeviation := tbCTLabelsYDeviation.Position;
    LChartCTAreaSpline3D.LabelsMargin := tbCTLabelsMargin.Position;
    LChartCTAreaSpline3D.AreaLabels.Indent := tbCTLabelsIndent.Position;
    LChartCTAreaSpline3D.AreaTransparency := tbCTTransparency.Position;

    LChartCTAreaSpline3D.Shaded := chbCTShaded.Checked;
    LChartCTAreaSpline3D.NoEdge := chbCTNoEdge.Checked;
    LChartCTAreaSpline3D.ChartDepth := tbChartDepth.Position;
    LChartCTAreaSpline3D.Indent3D := tbCTIndent3D.Position;
  end
  else if FCurChartType is TLMDChartCTColumn3D then
  begin
    LChartCTColumn3D := FCurChartType as TLMDChartCTColumn3D;

    LChartCTColumn3D.ShowColumnsLabels := chbCTShowLabels.Checked;
    LChartCTColumn3D.ColumnsLabels.ShowBackground := chbCTShowLabelsBackground.Checked;
    LChartCTColumn3D.LabelsXDeviation := tbCTLabelsXDeviation.Position;
    LChartCTColumn3D.LabelsYDeviation := tbCTLabelsYDeviation.Position;
    LChartCTColumn3D.LabelsMargin := tbCTLabelsMargin.Position;
    LChartCTColumn3D.ColumnsLabels.Indent := tbCTLabelsIndent.Position;
    LChartCTColumn3D.ColumnsTransparency := tbCTTransparency.Position;

    LChartCTColumn3D.ColumnAutoSize := chbCTAutoSize.Checked;
    LChartCTColumn3D.Stacked := chbCTStacked.Checked;
    LChartCTColumn3D.FullStacked := chbCTFullStacked.Checked;
    LChartCTColumn3D.ColumnAutoSizeValue := tbCTAutoSizeValue.Position;
    LChartCTColumn3D.ColumnCustomSize := tbCTCustomSize.Position;

    LChartCTColumn3D.ShadedBoxes := chbCTShaded.Checked;
    LChartCTColumn3D.NoEdge := chbCTNoEdge.Checked;
    LChartCTColumn3D.ChartDepth := tbChartDepth.Position;
    LChartCTColumn3D.MultiRow := chbCTMultiRow.Checked;
    LChartCTColumn3D.MultiRowIndent := tbCTIndent3D.Position;
  end
  else if FCurChartType is TLMDChartCTBar then
  begin
    LChartCTBar3D := FCurChartType as TLMDChartCTBar3D;

    LChartCTBar3D.ShowColumnsLabels := chbCTShowLabels.Checked;
    LChartCTBar3D.ColumnsLabels.ShowBackground := chbCTShowLabelsBackground.Checked;
    LChartCTBar3D.LabelsXDeviation := tbCTLabelsXDeviation.Position;
    LChartCTBar3D.LabelsYDeviation := tbCTLabelsYDeviation.Position;
    LChartCTBar3D.LabelsMargin := tbCTLabelsMargin.Position;
    LChartCTBar3D.ColumnsLabels.Indent := tbCTLabelsIndent.Position;
    LChartCTBar3D.ColumnsTransparency := tbCTTransparency.Position;

    LChartCTBar3D.ColumnAutoSize := chbCTAutoSize.Checked;
    LChartCTBar3D.Stacked := chbCTStacked.Checked;
    LChartCTBar3D.FullStacked := chbCTFullStacked.Checked;
    LChartCTBar3D.ColumnAutoSizeValue := tbCTAutoSizeValue.Position;
    LChartCTBar3D.ColumnCustomSize := tbCTCustomSize.Position;

    LChartCTBar3D.ShadedBoxes := chbCTShaded.Checked;
    LChartCTBar3D.NoEdge := chbCTNoEdge.Checked;
    LChartCTBar3D.ChartDepth := tbChartDepth.Position;
    LChartCTBar3D.MultiRow := chbCTMultiRow.Checked;
    LChartCTBar3D.MultiRowIndent := tbCTIndent3D.Position;
  end
end;

procedure TLMDChartEditor.DisplayChartTypeSettings;
var
  LChartCTAreaSpline3D: TLMDChartCTAreaSpline3D;
  LChartCTAreaSpline: TLMDChartCTAreaSpline;
  LChartCTAreaLine3D: TLMDChartCTAreaLine3D;
  LChartCTAreaLine: TLMDChartCTAreaLine;
  LChartCTDoughnut: TLMDChartCTDoughnut;
  LChartCTPie2D: TLMDChartCTPie2D;
  LChartCTBar3D: TLMDChartCTBar3D;
  LChartCTBar: TLMDChartCTBar;
  LChartCTColumn3D: TLMDChartCTColumn3D;
  LChartCTColumn: TLMDChartCTColumn;
begin
  if FCurChartType is TLMDChartCTColumn then
  begin
    LChartCTColumn := FCurChartType as TLMDChartCTColumn;

    chbCTShowLabels.Checked := LChartCTColumn.ShowColumnsLabels;
    chbCTShowLabelsBackground.Checked := LChartCTColumn.ColumnsLabels.ShowBackground;
    tbCTLabelsXDeviation.Position := LChartCTColumn.LabelsXDeviation;
    tbCTLabelsYDeviation.Position := LChartCTColumn.LabelsYDeviation;
    tbCTLabelsMargin.Position := LChartCTColumn.LabelsMargin;
    tbCTLabelsIndent.Position := LChartCTColumn.ColumnsLabels.Indent;
    tbCTTransparency.Position := LChartCTColumn.ColumnsTransparency;

    chbCTAutoSize.Checked := LChartCTColumn.ColumnAutoSize;
    chbCTStacked.Checked := LChartCTColumn.ColumnsStacked;
    chbCTFullStacked.Checked := LChartCTColumn.FullStacked;
    tbCTAutoSizeValue.Position := LChartCTColumn.ColumnAutoSizeValue;
    tbCTCustomSize.Position := LChartCTColumn.ColumnCustomSize;
  end
  else if FCurChartType is TLMDChartCTBar then
  begin
    LChartCTBar := FCurChartType as TLMDChartCTBar;

    chbCTShowLabels.Checked := LChartCTBar.ShowColumnsLabels;
    chbCTShowLabelsBackground.Checked := LChartCTBar.ColumnsLabels.ShowBackground;
    tbCTLabelsXDeviation.Position := LChartCTBar.LabelsXDeviation;
    tbCTLabelsYDeviation.Position := LChartCTBar.LabelsYDeviation;
    tbCTLabelsMargin.Position := LChartCTBar.LabelsMargin;
    tbCTLabelsIndent.Position := LChartCTBar.ColumnsLabels.Indent;
    tbCTTransparency.Position := LChartCTBar.ColumnsTransparency;

    chbCTAutoSize.Checked := LChartCTBar.ColumnAutoSize;
    chbCTStacked.Checked := LChartCTBar.BarsStacked;
    chbCTFullStacked.Checked := LChartCTBar.FullStacked;
    tbCTAutoSizeValue.Position := LChartCTBar.ColumnAutoSizeValue;
    tbCTCustomSize.Position := LChartCTBar.ColumnCustomSize;
  end
  else if FCurChartType is TLMDChartCTPie2D then
  begin
    LChartCTPie2D := FCurChartType as TLMDChartCTPie2D;

    chbCTShowLabels.Checked := LChartCTPie2D.ShowPercent;
    chbCTShowLabelsBackground.Checked := LChartCTPie2D.PiesLabels.ShowBackground;
    tbCTLabelsXDeviation.Position := LChartCTPie2D.LabelsXDeviation;
    tbCTLabelsYDeviation.Position := LChartCTPie2D.LabelsYDeviation;
    tbCTLabelsMargin.Position := LChartCTPie2D.LabelsMargin;
    tbCTLabelsIndent.Position := LChartCTPie2D.PiesLabels.Indent;
    tbCTTransparency.Position := LChartCTPie2D.PieTransparency;

    chbCTExplodeAutoScale.Checked := LChartCTPie2D.ExplodeAutoScale;
    chbCTProportional.Checked := LChartCTPie2D.Proportional;
  end
  else if FCurChartType is TLMDChartCTDoughnut then
  begin
    LChartCTDoughnut := FCurChartType as TLMDChartCTDoughnut;

    chbCTShowLabels.Checked := LChartCTDoughnut.ShowPercent;
    chbCTShowLabelsBackground.Checked := LChartCTDoughnut.PiesLabels.ShowBackground;
    tbCTLabelsXDeviation.Position := LChartCTDoughnut.LabelsXDeviation;
    tbCTLabelsYDeviation.Position := LChartCTDoughnut.LabelsYDeviation;
    tbCTLabelsMargin.Position := LChartCTDoughnut.LabelsMargin;
    tbCTLabelsIndent.Position := LChartCTDoughnut.PiesLabels.Indent;
    tbCTTransparency.Position := LChartCTDoughnut.PieTransparency;
  end
  else if FCurChartType is TLMDChartCTAreaLine then
  begin
    LChartCTAreaLine := FCurChartType as TLMDChartCTAreaLine;

    chbCTShowLabels.Checked := LChartCTAreaLine.ShowAreaLabels;
    chbCTShowLabelsBackground.Checked := LChartCTAreaLine.AreaLabels.ShowBackground;
    tbCTLabelsXDeviation.Position := LChartCTAreaLine.LabelsXDeviation;
    tbCTLabelsYDeviation.Position := LChartCTAreaLine.LabelsYDeviation;
    tbCTLabelsMargin.Position := LChartCTAreaLine.LabelsMargin;
    tbCTLabelsIndent.Position := LChartCTAreaLine.AreaLabels.Indent;
    tbCTTransparency.Position := LChartCTAreaLine.AreaTransparency;

    chbCTStacked.Checked := LChartCTAreaLine.AreaStacked;
  end
  else if FCurChartType is TLMDChartCTAreaSpline then
  begin
    LChartCTAreaSpline := FCurChartType as TLMDChartCTAreaSpline;

    chbCTShowLabels.Checked := LChartCTAreaSpline.ShowAreaLabels;
    chbCTShowLabelsBackground.Checked := LChartCTAreaSpline.AreaLabels.ShowBackground;
    tbCTLabelsXDeviation.Position := LChartCTAreaSpline.LabelsXDeviation;
    tbCTLabelsYDeviation.Position := LChartCTAreaSpline.LabelsYDeviation;
    tbCTLabelsMargin.Position := LChartCTAreaSpline.LabelsMargin;
    tbCTLabelsIndent.Position := LChartCTAreaSpline.AreaLabels.Indent;
    tbCTTransparency.Position := LChartCTAreaSpline.AreaTransparency;

    chbCTStacked.Checked := LChartCTAreaSpline.AreaStacked;
  end
  else if FCurChartType is TLMDChartCTAreaLine3D then
  begin
    LChartCTAreaLine3D := FCurChartType as TLMDChartCTAreaLine3D;

    chbCTShowLabels.Checked := LChartCTAreaLine3D.ShowAreaLabels;
    chbCTShowLabelsBackground.Checked := LChartCTAreaLine3D.AreaLabels.ShowBackground;
    tbCTLabelsXDeviation.Position := LChartCTAreaLine3D.LabelsXDeviation;
    tbCTLabelsYDeviation.Position := LChartCTAreaLine3D.LabelsYDeviation;
    tbCTLabelsMargin.Position := LChartCTAreaLine3D.LabelsMargin;
    tbCTLabelsIndent.Position := LChartCTAreaLine3D.AreaLabels.Indent;
    tbCTTransparency.Position := LChartCTAreaLine3D.AreaTransparency;

    chbCTShaded.Checked := LChartCTAreaLine3D.Shaded;
    chbCTNoEdge.Checked := LChartCTAreaLine3D.NoEdge;
    tbChartDepth.Position := LChartCTAreaLine3D.ChartDepth;
    tbCTIndent3D.Position := LChartCTAreaLine3D.Indent3D;
  end
  else if FCurChartType is TLMDChartCTAreaSpline3D then
  begin
    LChartCTAreaSpline3D := FCurChartType as TLMDChartCTAreaSpline3D;

    chbCTShowLabels.Checked := LChartCTAreaSpline3D.ShowAreaLabels;
    chbCTShowLabelsBackground.Checked := LChartCTAreaSpline3D.AreaLabels.ShowBackground;
    tbCTLabelsXDeviation.Position := LChartCTAreaSpline3D.LabelsXDeviation;
    tbCTLabelsYDeviation.Position := LChartCTAreaSpline3D.LabelsYDeviation;
    tbCTLabelsMargin.Position := LChartCTAreaSpline3D.LabelsMargin;
    tbCTLabelsIndent.Position := LChartCTAreaSpline3D.AreaLabels.Indent;
    tbCTTransparency.Position := LChartCTAreaSpline3D.AreaTransparency;

    chbCTShaded.Checked := LChartCTAreaSpline3D.Shaded;
    chbCTNoEdge.Checked := LChartCTAreaSpline3D.NoEdge;
    tbChartDepth.Position := LChartCTAreaSpline3D.ChartDepth;
    tbCTIndent3D.Position := LChartCTAreaSpline3D.Indent3D;
  end
  else if FCurChartType is TLMDChartCTColumn3D then
  begin
    LChartCTColumn3D := FCurChartType as TLMDChartCTColumn3D;

    chbCTShowLabels.Checked := LChartCTColumn3D.ShowColumnsLabels;
    chbCTShowLabelsBackground.Checked := LChartCTColumn3D.ColumnsLabels.ShowBackground;
    tbCTLabelsXDeviation.Position := LChartCTColumn3D.LabelsXDeviation;
    tbCTLabelsYDeviation.Position := LChartCTColumn3D.LabelsYDeviation;
    tbCTLabelsMargin.Position := LChartCTColumn3D.LabelsMargin;
    tbCTLabelsIndent.Position := LChartCTColumn3D.ColumnsLabels.Indent;
    tbCTTransparency.Position := LChartCTColumn3D.ColumnsTransparency;

    chbCTAutoSize.Checked := LChartCTColumn3D.ColumnAutoSize;
    chbCTStacked.Checked := LChartCTColumn3D.Stacked;
    chbCTFullStacked.Checked := LChartCTColumn3D.FullStacked;
    tbCTAutoSizeValue.Position := LChartCTColumn3D.ColumnAutoSizeValue;
    tbCTCustomSize.Position := LChartCTColumn3D.ColumnCustomSize;

    chbCTShaded.Checked := LChartCTColumn3D.ShadedBoxes;
    chbCTNoEdge.Checked := LChartCTColumn3D.NoEdge;
    tbChartDepth.Position := LChartCTColumn3D.ChartDepth;
    chbCTMultiRow.Checked := LChartCTColumn3D.MultiRow;
    tbCTIndent3D.Position := LChartCTColumn3D.MultiRowIndent;
  end
  else if FCurChartType is TLMDChartCTBar then
  begin
    LChartCTBar3D := FCurChartType as TLMDChartCTBar3D;

    chbCTShowLabels.Checked := LChartCTBar3D.ShowColumnsLabels;
    chbCTShowLabelsBackground.Checked := LChartCTBar3D.ColumnsLabels.ShowBackground;
    tbCTLabelsXDeviation.Position := LChartCTBar3D.LabelsXDeviation;
    tbCTLabelsYDeviation.Position := LChartCTBar3D.LabelsYDeviation;
    tbCTLabelsMargin.Position := LChartCTBar3D.LabelsMargin;
    tbCTLabelsIndent.Position := LChartCTBar3D.ColumnsLabels.Indent;
    tbCTTransparency.Position := LChartCTBar3D.ColumnsTransparency;

    chbCTAutoSize.Checked := LChartCTBar3D.ColumnAutoSize;
    chbCTStacked.Checked := LChartCTBar3D.Stacked;
    chbCTFullStacked.Checked := LChartCTBar3D.FullStacked;
    tbCTAutoSizeValue.Position := LChartCTBar3D.ColumnAutoSizeValue;
    tbCTCustomSize.Position := LChartCTBar3D.ColumnCustomSize;

    chbCTShaded.Checked := LChartCTBar3D.ShadedBoxes;
    chbCTNoEdge.Checked := LChartCTBar3D.NoEdge;
    tbChartDepth.Position := LChartCTBar3D.ChartDepth;
    chbCTMultiRow.Checked := LChartCTBar3D.MultiRow;
    tbCTIndent3D.Position := LChartCTBar3D.MultiRowIndent;
  end
end;

procedure TLMDChartEditor.btCTLabelsBackgroundClick(Sender: TObject);
begin
  if FCurChartType is TLMDChartCTColumn then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTColumn).ColumnsLabels.Background);
  end
  else if FCurChartType is TLMDChartCTBar then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTBar).ColumnsLabels.Background);
  end
  else if FCurChartType is TLMDChartCTPie2D then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTPie2D).PiesLabels.Background);
  end
  else if FCurChartType is TLMDChartCTDoughnut then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTDoughnut).PiesLabels.Background);
  end
  else if FCurChartType is TLMDChartCTAreaLine then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTAreaLine).AreaLabels.Background);
  end
  else if FCurChartType is TLMDChartCTAreaSpline then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTAreaSpline).AreaLabels.Background);
  end
  else if FCurChartType is TLMDChartCTAreaLine3D then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTAreaLine3D).AreaLabels.Background);
  end
  else if FCurChartType is TLMDChartCTAreaSpline3D then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTAreaSpline3D).AreaLabels.Background);
  end
  else if FCurChartType is TLMDChartCTColumn3D then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTColumn3D).ColumnsLabels.Background);
  end
  else if FCurChartType is TLMDChartCTBar3D then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTBar3D).ColumnsLabels.Background);
  end
end;

procedure TLMDChartEditor.btCTLabelEdgesClick(Sender: TObject);
begin
  if FCurChartType is TLMDChartCTColumn then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTColumn).ColumnsLabels.Edge);
  end
  else if FCurChartType is TLMDChartCTBar then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTBar).ColumnsLabels.Edge);
  end
  else if FCurChartType is TLMDChartCTPie2D then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTPie2D).PiesLabels.Edge);
  end
  else if FCurChartType is TLMDChartCTDoughnut then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTDoughnut).PiesLabels.Edge);
  end
  else if FCurChartType is TLMDChartCTAreaLine then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTAreaLine).AreaLabels.Edge);
  end
  else if FCurChartType is TLMDChartCTAreaSpline then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTAreaSpline).AreaLabels.Edge);
  end
  else if FCurChartType is TLMDChartCTAreaLine3D then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTAreaLine3D).AreaLabels.Edge);
  end
  else if FCurChartType is TLMDChartCTAreaSpline3D then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTAreaSpline3D).AreaLabels.Edge);
  end
  else if FCurChartType is TLMDChartCTColumn3D then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTColumn3D).ColumnsLabels.Edge);
  end
  else if FCurChartType is TLMDChartCTBar3D then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTBar3D).ColumnsLabels.Edge);
  end
end;

procedure TLMDChartEditor.btCTLabelFontClick(Sender: TObject);
begin
  if FCurChartType is TLMDChartCTColumn then
  begin
    FontDialog1.Font.Assign((FCurChartType as TLMDChartCTColumn).ColumnsLabels.Font);
    if FontDialog1.Execute then
      (FCurChartType as TLMDChartCTColumn).ColumnsLabels.Font.Assign(FontDialog1.Font);
  end
  else if FCurChartType is TLMDChartCTBar then
  begin
    FontDialog1.Font.Assign((FCurChartType as TLMDChartCTBar).ColumnsLabels.Font);
    if FontDialog1.Execute then
      (FCurChartType as TLMDChartCTBar).ColumnsLabels.Font.Assign(FontDialog1.Font);
  end
  else if FCurChartType is TLMDChartCTPie2D then
  begin
    FontDialog1.Font.Assign((FCurChartType as TLMDChartCTPie2D).PiesLabels.Font);
    if FontDialog1.Execute then
      (FCurChartType as TLMDChartCTPie2D).PiesLabels.Font.Assign(FontDialog1.Font);
  end
  else if FCurChartType is TLMDChartCTDoughnut then
  begin
    FontDialog1.Font.Assign((FCurChartType as TLMDChartCTDoughnut).PiesLabels.Font);
    if FontDialog1.Execute then
      (FCurChartType as TLMDChartCTDoughnut).PiesLabels.Font.Assign(FontDialog1.Font);
  end
  else if FCurChartType is TLMDChartCTAreaLine then
  begin
    FontDialog1.Font.Assign((FCurChartType as TLMDChartCTAreaLine).AreaLabels.Font);
    if FontDialog1.Execute then
      (FCurChartType as TLMDChartCTAreaLine).AreaLabels.Font.Assign(FontDialog1.Font);
  end
  else if FCurChartType is TLMDChartCTAreaSpline then
  begin
    FontDialog1.Font.Assign((FCurChartType as TLMDChartCTAreaSpline).AreaLabels.Font);
    if FontDialog1.Execute then
      (FCurChartType as TLMDChartCTAreaSpline).AreaLabels.Font.Assign(FontDialog1.Font);
  end
  else if FCurChartType is TLMDChartCTAreaLine3D then
  begin
    FontDialog1.Font.Assign((FCurChartType as TLMDChartCTAreaLine3D).AreaLabels.Font);
    if FontDialog1.Execute then
      (FCurChartType as TLMDChartCTAreaLine3D).AreaLabels.Font.Assign(FontDialog1.Font);
  end
  else if FCurChartType is TLMDChartCTAreaSpline3D then
  begin
    FontDialog1.Font.Assign((FCurChartType as TLMDChartCTAreaSpline3D).AreaLabels.Font);
    if FontDialog1.Execute then
      (FCurChartType as TLMDChartCTAreaSpline3D).AreaLabels.Font.Assign(FontDialog1.Font);
  end
  else if FCurChartType is TLMDChartCTColumn3D then
  begin
    FontDialog1.Font.Assign((FCurChartType as TLMDChartCTColumn3D).ColumnsLabels.Font);
    if FontDialog1.Execute then
      (FCurChartType as TLMDChartCTColumn3D).ColumnsLabels.Font.Assign(FontDialog1.Font);
  end
  else if FCurChartType is TLMDChartCTBar3D then
  begin
    FontDialog1.Font.Assign((FCurChartType as TLMDChartCTBar3D).ColumnsLabels.Font);
    if FontDialog1.Execute then
      (FCurChartType as TLMDChartCTBar3D).ColumnsLabels.Font.Assign(FontDialog1.Font);
  end
end;

procedure TLMDChartEditor.chbCTShowLabelsBackgroundClick(Sender: TObject);
begin
  ApplyChartTypeSettings;
end;

procedure TLMDChartEditor.tbCTLabelsXDeviationChange(Sender: TObject);
begin
  ApplyChartTypeSettings;
end;

procedure TLMDChartEditor.tbCTLabelsYDeviationChange(Sender: TObject);
begin
  ApplyChartTypeSettings;
end;

procedure TLMDChartEditor.tbCTLabelsMarginChange(Sender: TObject);
begin
  ApplyChartTypeSettings;
end;

procedure TLMDChartEditor.tbCTLabelsIndentChange(Sender: TObject);
begin
  ApplyChartTypeSettings;
end;

procedure TLMDChartEditor.tbCTTransparencyChange(Sender: TObject);
begin
  ApplyChartTypeSettings;
end;

procedure TLMDChartEditor.chbCTShadedClick(Sender: TObject);
begin
  ApplyChartTypeSettings;
end;

procedure TLMDChartEditor.chbCTNoEdgeClick(Sender: TObject);
begin
  ApplyChartTypeSettings;
end;

procedure TLMDChartEditor.tbChartDepthChange(Sender: TObject);
begin
  ApplyChartTypeSettings;
end;

procedure TLMDChartEditor.chbCTAutoSizeClick(Sender: TObject);
begin
  if Assigned(Sender) then
    ApplyChartTypeSettings;
  lbCTAutoSizeValue.Visible := chbCTAutoSize.Checked;
  tbCTAutoSizeValue.Visible := chbCTAutoSize.Checked;
  lbCTCustomSize.Visible := not chbCTAutoSize.Checked;
  tbCTCustomSize.Visible := not chbCTAutoSize.Checked;
end;

procedure TLMDChartEditor.chbCTStackedClick(Sender: TObject);
begin
  ApplyChartTypeSettings;
  if not chbCTStacked.Checked then
    chbCTFullStacked.Checked := false;
end;

procedure TLMDChartEditor.chbCTFullStackedClick(Sender: TObject);
begin
  ApplyChartTypeSettings;
  if chbCTFullStacked.Checked then
    chbCTStacked.Checked := true;
end;

procedure TLMDChartEditor.chbCTMultiRowClick(Sender: TObject);
begin
  ApplyChartTypeSettings;
  lbCTIndent3D.Visible := chbCTMultiRow.Checked;
  tbCTIndent3D.Visible := chbCTMultiRow.Checked;
end;

procedure TLMDChartEditor.chbCTExplodeAutoScaleClick(Sender: TObject);
begin
  ApplyChartTypeSettings;
end;

procedure TLMDChartEditor.chbCTProportionalClick(Sender: TObject);
begin
  ApplyChartTypeSettings;
end;

procedure TLMDChartEditor.tbCTAutoSizeValueChange(Sender: TObject);
begin
  ApplyChartTypeSettings;
end;

procedure TLMDChartEditor.tbCTCustomSizeChange(Sender: TObject);
begin
  ApplyChartTypeSettings;
end;

procedure TLMDChartEditor.tbCTIndent3DChange(Sender: TObject);
begin
  ApplyChartTypeSettings;
end;

procedure TLMDChartEditor.btCTLeftPlaneFillClick(Sender: TObject);
begin
  if not IsChart3D then
    Exit;
  if FCurChartType is TLMDChartCTAreaLine3D then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTAreaLine3D).LeftPlaneFill);
  end
  else if FCurChartType is TLMDChartCTAreaSpline3D then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTAreaSpline3D).LeftPlaneFill);
  end
  else if FCurChartType is TLMDChartCTColumn3D then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTColumn3D).LeftPlaneFill);
  end
  else if FCurChartType is TLMDChartCTBar3D then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTBar3D).LeftPlaneFill);
  end;
end;

function TLMDChartEditor.IsChart3D: boolean;
begin
  Result := (FCurChartType is TLMDChartCTColumn3D)
                                    or (FCurChartType is TLMDChartCTBar3D)
                                    or (FCurChartType is TLMDChartCTAreaLine3D)
                                    or (FCurChartType is TLMDChartCTAreaSpline3D);
end;

procedure TLMDChartEditor.btCTBackPlaneFillClick(Sender: TObject);
begin
  if not IsChart3D then
    Exit;
  if FCurChartType is TLMDChartCTAreaLine3D then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTAreaLine3D).BackPlaneFill);
  end
  else if FCurChartType is TLMDChartCTAreaSpline3D then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTAreaSpline3D).BackPlaneFill);
  end
  else if FCurChartType is TLMDChartCTColumn3D then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTColumn3D).BackPlaneFill);
  end
  else if FCurChartType is TLMDChartCTBar3D then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTBar3D).BackPlaneFill);
  end;
end;

procedure TLMDChartEditor.btCTBottomPlaneFillClick(Sender: TObject);
begin
  if not IsChart3D then
    Exit;
  if FCurChartType is TLMDChartCTAreaLine3D then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTAreaLine3D).BottomPlaneFill);
  end
  else if FCurChartType is TLMDChartCTAreaSpline3D then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTAreaSpline3D).BottomPlaneFill);
  end
  else if FCurChartType is TLMDChartCTColumn3D then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTColumn3D).BottomPlaneFill);
  end
  else if FCurChartType is TLMDChartCTBar3D then
  begin
    FFillEditor.Edit((FCurChartType as TLMDChartCTBar3D).BottomPlaneFill);
  end;
end;

procedure TLMDChartEditor.btCTLeftPlaneLineClick(Sender: TObject);
begin
  if not IsChart3D then
    Exit;
  if FCurChartType is TLMDChartCTAreaLine3D then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTAreaLine3D).LeftPlaneLine);
  end
  else if FCurChartType is TLMDChartCTAreaSpline3D then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTAreaSpline3D).LeftPlaneLine);
  end
  else if FCurChartType is TLMDChartCTColumn3D then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTColumn3D).LeftPlaneLine);
  end
  else if FCurChartType is TLMDChartCTBar3D then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTBar3D).LeftPlaneLine);
  end;
end;

procedure TLMDChartEditor.btCTBackPlaneLineClick(Sender: TObject);
begin
  if not IsChart3D then
    Exit;
  if FCurChartType is TLMDChartCTAreaLine3D then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTAreaLine3D).BackPlaneLine);
  end
  else if FCurChartType is TLMDChartCTAreaSpline3D then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTAreaSpline3D).BackPlaneLine);
  end
  else if FCurChartType is TLMDChartCTColumn3D then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTColumn3D).BackPlaneLine);
  end
  else if FCurChartType is TLMDChartCTBar3D then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTBar3D).BackPlaneLine);
  end;
end;

procedure TLMDChartEditor.btCTBottomPlaneLineClick(Sender: TObject);
begin
  if not IsChart3D then
    Exit;
  if FCurChartType is TLMDChartCTAreaLine3D then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTAreaLine3D).BottomPlaneLine);
  end
  else if FCurChartType is TLMDChartCTAreaSpline3D then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTAreaSpline3D).BottomPlaneLine);
  end
  else if FCurChartType is TLMDChartCTColumn3D then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTColumn3D).BottomPlaneLine);
  end
  else if FCurChartType is TLMDChartCTBar3D then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTBar3D).BottomPlaneLine);
  end;
end;

procedure TLMDChartEditor.btCTLeftZGridClick(Sender: TObject);
begin
  if (FCurChartType is TLMDChartCTColumn3D) then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTColumn3D).LeftZGrid);
  end
  else if (FCurChartType is TLMDChartCTAreaLine3D) then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTAreaLine3D).LeftZGrid);
  end
  else if (FCurChartType is TLMDChartCTAreaSpline3D) then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTAreaSpline3D).LeftZGrid);
  end;
end;

procedure TLMDChartEditor.btCTBottomZMajorGridClick(Sender: TObject);
begin
  if (FCurChartType is TLMDChartCTColumn3D) then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTColumn3D).BottomZMajorGrid);
  end;
end;

procedure TLMDChartEditor.btCTBottomZMinorGridClick(Sender: TObject);
begin
  if (FCurChartType is TLMDChartCTColumn3D) then
  begin
    FLineEditor.Edit((FCurChartType as TLMDChartCTColumn3D).BottomZMinorGrid);
  end;
end;

{
procedure TLMDChartEditor.CopyChartBackgroundSettings(AFromBackground,
  AToBackground: TLMDChartBackground);
begin
  AToBackground.Style := AFromBackground.Style;
  AToBackground.Image.Assign(AFromBackground.Image);
  AToBackground.SolidColor := AFromBackground.SolidColor;
  AToBackground.GradientColorBegin := AFromBackground.GradientColorBegin;
  AToBackground.GradientColorEnd := AFromBackground.GradientColorEnd;
  AToBackground.GradientAngle := AFromBackground.GradientAngle;
  AToBackground.GradientMaxLOD := AFromBackground.GradientMaxLOD;

end;
}

{
procedure TLMDChartEditor.CopyChartLineSettings(AFromLine,
  AToLine: TLMDChartLine);
begin
  AToLine.Width := AFromLine.Width;
  AToLine.Color := AFromLine.Color;
  AToLine.Style := AFromLine.Style;
end;
}

procedure TLMDChartEditor.edYMinValueChange(Sender: TObject);
begin
  try
    ChartPreview.ChartArea.YAxis.MinValue := StrToInt(edYMinValue.Text);
  except
    on E: Exception do ;
  end;
end;

procedure TLMDChartEditor.edYMaxValueChange(Sender: TObject);
begin
  try
    ChartPreview.ChartArea.YAxis.MaxValue := StrToInt(edYMaxValue.Text);
  except
    on E: Exception do ;
  end;
end;

procedure TLMDChartEditor.btAddSeriesClick(Sender: TObject);
var
  LDlg: TLMDAddSeriesDlg;
begin
  LDlg := TLMDAddSeriesDlg.Create(nil);
  if LDlg.AddSeries(ChartPreview) then
  begin
    DisplayChartData;
    if Assigned(FForm) then
        FForm.Designer.Modified;
  end;
  LDlg.Free;
end;

procedure TLMDChartEditor.btRemoveSeriesClick(Sender: TObject);
var
  i: integer;
  LFound: boolean;
begin
  if pcChartSeriesValues.Tabs.Count > 0 then
  begin
    i := 0;
    LFound := false;
    while (not LFound) and (i < ChartPreview.SeriesObjects.Count) do
    begin
     LFound := ChartPreview.SeriesObjects.Items[i] = pcChartSeriesValues.Tabs.Objects[pcChartSeriesValues.TabIndex];
     if not LFound then
       Inc(i);
    end;
    if LFound then
    begin
      pcChartSeriesValues.Tabs.Delete(pcChartSeriesValues.Tabs.IndexOfObject(ChartPreview.SeriesObjects.Items[i]));
      ChartPreview.SeriesObjects.Delete(i);
      Self.AdjustChartDataTabControl;
      if Assigned(FForm) then
        FForm.Designer.Modified;
    end;
  end;
end;

function TLMDChartEditor.IsCurrSeriesAssigned: Boolean;
begin
  Result := (pcChartSeriesValues.Tabs.Count > 0) and (pcChartSeriesValues.TabIndex >= 0) and
    (Assigned(pcChartSeriesValues.Tabs.Objects[pcChartSeriesValues.TabIndex]));
end;

function TLMDChartEditor.CurrentSeries: TLMDChartSeriesCollectionItem;
begin
  Result := TLMDChartSeriesCollectionItem(pcChartSeriesValues.Tabs.Objects[pcChartSeriesValues.TabIndex]);
end;

procedure TLMDChartEditor.seRowCountChange(Sender: TObject);
var
  LSeriesItem: TLMDChartSeriesCollectionItem;
  i, j, oldCount: integer;
begin
  if IsCurrSeriesAssigned then
  begin
    LSeriesItem := CurrentSeries;
    if Assigned(LSeriesItem.Series) then
    begin
      LSeriesItem.Series.ChartValuesCollection.NumberOfValues := seRowCount.Value;
      oldCount := sgData.RowCount;
      sgData.RowCount := seRowCount.Value + 3;
      for j := oldCount to sgData.RowCount - 1 do
        for i := 0 to sgData.ColCount - 1 do
          sgData.Cells[i, j] := VarToStr(LSeriesItem.Series.ChartValuesCollection.Items[i].ChartValues.Values[j]);
      if Assigned(FForm) and (not Self.FProgrammaticUpdate) then
        FForm.Designer.Modified;
    end;
  end;  
end;

procedure TLMDChartEditor.sgDataSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
var
  LSeriesItem: TLMDChartSeriesCollectionItem;
begin
  if IsCurrSeriesAssigned then
  begin
    LSeriesItem := CurrentSeries;
    if Assigned(LSeriesItem.Series) and Assigned(LSeriesItem.Series.ChartValuesCollection) and
      (ACol < LSeriesItem.Series.ChartValuesCollection.Count)
      and (ARow  - sgData.FixedRows < LSeriesItem.Series.ChartValuesCollection.Items[ACol].ChartValues.Count) then
    begin
      LSeriesItem.Series.ChartValuesCollection.Items[ACol].ChartValues.Values[ARow - sgData.FixedRows]
        := sgData.Cells[ACol, ARow];
      if Assigned(FForm) and (not Self.FProgrammaticUpdate) then
        FForm.Designer.Modified;
    end;
  end;
end;

procedure TLMDChartEditor.bColOptionsClick(Sender: TObject);
var
  LSeriesItem: TLMDChartSeriesCollectionItem;
  LChartValues: TLMDChartValuesBase;
  LColOptionsDlg: TLMDChartValuesOptionsSelector;
  ACol: integer;
begin
  if IsCurrSeriesAssigned then
  begin
    ACol := sgData.Col;
    LSeriesItem := CurrentSeries;
    if Assigned(LSeriesItem.Series) and Assigned(LSeriesItem.Series.ChartValuesCollection)
     and (ACol < LSeriesItem.Series.ChartValuesCollection.Count) then
    begin
      LChartValues := LSeriesItem.Series.ChartValuesCollection[ACol].ChartValues;
      if Assigned(LChartValues) then
      begin
        LColOptionsDlg := TLMDChartValuesOptionsSelector.Create(nil);
        if LColOptionsDlg.Edit(LChartValues) then
        begin
          sgData.Cells[ACol, 0] := LChartValues.Name;
          sgData.Cells[ACol, 1] := LChartValues.Caption;
          sgData.Cells[ACol, 2] := ChartValueTypeToStr(LChartValues.ValueType);
          if Assigned(FForm) then
            FForm.Designer.Modified;
        end;
        LColOptionsDlg.Free;
      end;
    end;
  end;
end;

procedure TLMDChartEditor.pcChartSeriesValuesChange(Sender: TObject);
begin
  Self.DisplayChartValues(Self.ChartPreview.SeriesObjects[Self.pcChartSeriesValues.TabIndex].Series);
end;

procedure TLMDChartEditor.AdjustChartDataTabControl;
begin
  if Assigned(ChartPreview) and Assigned(ChartPreview.SeriesObjects)
        and (ChartPreview.SeriesObjects.Count > 0) then
  begin
    pcChartSeriesValues.Visible := true;
    Self.pcChartSeriesValues.TabIndex := 0;
    Self.DisplayChartValues(ChartPreview.SeriesObjects.Items[0].Series);
  end
  else
    pcChartSeriesValues.Visible := false;
end;

end.
