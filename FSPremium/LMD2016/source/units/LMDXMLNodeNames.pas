unit LMDXMLNodeNames;

interface

type
  TChartTypeID = (ChartAreaLineID, ChartAreaLine3DID, ChartAreaSplineID,
    ChartAreaSpline3DID, ChartBarID, ChartBar3DID, ChartColumnID,
    ChartColumn3DID, ChartPieID, ChartDoughnutID);

const
  NNSpace = '';

  NNChart = 'Chart' + NNSpace;
  NNChartLegend = 'ChartLegend' + NNSpace;
  NNChartLine = 'ChartLine' + NNSpace;
  NNChartBackground = 'ChartBackground' + NNSpace;
  NNChartFont = 'ChartFont' + NNSpace;
  NNChartTitleBox = 'ChartTitleBox' + NNSpace;
  NNChartMarker = 'ChartMarker' + NNSpace;
  NNChartData = 'ChartData' + NNSpace;
  NNChartArea = 'ChartArea' + NNSpace;
  NNChartAxis = 'ChartAxis' + NNSpace;
  NNChartYAxis = 'ChartYAxis' + NNSpace;
  NNChartLabel = 'ChartLabel' + NNSpace;

  NNCTAreaLine = 'AreaLine';
  NNCTAreaLine3D = 'AreaLine3D';
  NNCTAreaSpline = 'AreaSpline';
  NNCTAreaSpline3D = 'AreaSpline3D';
  NNCTBar = 'Bar';
  NNCTBar3D = 'Bar3D';
  NNCTColumn = 'Column';
  NNCTColumn3D = 'Column3D';
  NNCTPie = 'Pie';
  NNCTDoughnut = 'Doughnut';

implementation
end.
