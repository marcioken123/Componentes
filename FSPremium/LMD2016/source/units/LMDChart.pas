unit LMDChart;
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
LMDChart unit - Core of TLMDChart
-----------------------------------
This unit contain TLMDChart class (main element of LMDChart) and Register
procedure.

Changes
-------
Last (06-June-2006)

--------
Since 18-June-2007 uses new data model: SeriesObjects property is a collection of references
LMDChartSeries components which represent chart data; FSeries field still exists for
backward code compatibility, it's of type TLMDChartData which is now just a wrapper
for TLMDChartSeriesColl (namely for the SeriesObjects property)

###############################################################################}

interface

uses
  Windows, Jpeg,
  SysUtils, Classes, Controls, Graphics, Types, ExtCtrls,
  intfLMDBase, LMDXML, LMDXMLNodeNames, LMDCustomControl, LMDTypes, LMDChartBackground,
  LMDChartUtils, LMDChartPersistent, LMDChartLegend, LMDChartTitleBox, LMDChartLine,
  LMDChartData, LMDChartSeriesCollection, LMDChartArea, LMDChartTypes, LMDChartMarker,
  LMDChartCTColumn, LMDChartCTColumn3D, LMDChartCTBar, LMDChartCTAreaLine, LMDChartCTAreaLine3D,
  LMDChartCTPie2D, LMDChartCTBar3D, LMDChartCTAreaSpline, LMDChartCTDoughnut;

type
  TLMDCustomChart = class(TLMDCustomControl, ILMDComponent)
  public
    function getLMDPackage: TLMDPackageID; override;
  end;

  { ************************* TLMDChart ************************************** }
  /// <summary>
  /// TLMDChart. Represents chart control.
  /// This control are visually appealing and make it easy
  /// for users to see comparisons, patterns, and
  /// trends in data.
  /// </summary>
  TLMDChart = class(TLMDCustomChart)
  private
    FLegend: TLMDChartLegend;
    FBackground: TLMDChartBackground;
    FTitleBox: TLMDChartTitleBox;
    FSeries: TLMDChartData; //ValuesData in UML
    FSeriesColl: TLMDChartSeriesColl;
    FChartArea: TLMDChartArea;

    FIsLoadingData: boolean;

    procedure SetBackground(Value: TLMDChartBackground);
    procedure SetTitleBox(Value: TLMDChartTitleBox);
    procedure SetSeriesColl(Value: TLMDChartSeriesColl);
    procedure SetChartArea(Value: TLMDChartArea);
    procedure SetLegend(Value: TLMDChartLegend);
    function GetChartType: TLMDChartCTAbstract;
    procedure SetChartType(Value: TLMDChartCTAbstract);
    procedure SetIsLoadingData(const Value: boolean);
  protected
    property Series: TLMDChartData read FSeries;

    procedure Paint; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    /// <summary>
    /// Saves inner object state to xml format
    /// </summary>
    procedure SaveStateToXML(FileName, Comment: string);
    /// <summary>
    /// Loads inner object state from xml format
    /// </summary>
    procedure LoadStateFromXML(FileName, Comment: string);
    /// <summary>
    /// Draws object
    /// </summary>
    procedure Draw;
    /// <summary>
    /// Draws object on canvas
    /// </summary>
    procedure DrawTo(ATarget: TCanvas);
    /// <summary>
    /// Saves to bmp file
    /// </summary>
    procedure SaveToBMP(AFileName: string; AImageWidth, AImageHeight: integer);
    /// <summary>
    /// Saves to jpg file
    /// </summary>
    procedure SaveToJPG(AFileName: string; AImageWidth, AImageHeight: integer);
    /// <summary>
    /// Saves to png file
    /// </summary>
    procedure SaveToPNG(AFileName: string; AImageWidth, AImageHeight: integer);
    /// <summary>
    /// Saves chart area to jpg file
    /// </summary>
    procedure SaveChartAreaToJPG(AFileName: string; AImageWidth, AImageHeight: integer);
    /// <summary>
    /// Saves chart area to bmp file
    /// </summary>
    procedure SaveChartAreaToBMP(AFileName: string; AImageWidth, AImageHeight: integer);
    /// <summary>
    /// Saves legend to bmp file
    /// </summary>
    procedure SaveLegendToBMP(AFileName: string);
    /// <summary>
    /// Saves legend to jpg file
    /// </summary>

    procedure SetDataChanged;

    property IsLoadingData: boolean read FIsLoadingData write SetIsLoadingData;
  published
    property About;
    property Legend: TLMDChartLegend read Flegend write SetLegend;
    property Background: TLMDChartBackground read FBackground write SetBackground;
    property TitleBox: TLMDChartTitleBox read FTitleBox write SetTitleBox;
    property SeriesObjects: TLMDChartSeriesColl read FSeriesColl write SetSeriesColl;
    property ChartArea: TLMDChartArea read FChartArea write SetChartArea;
    property ChartType: TLMDChartCTAbstract read GetChartType write SetChartType;

    //property, inherited from TCustomControl
    property Align;
    property ShowHint;
    property PopupMenu;
    //events, inherited from TCustomControl
    property OnClick;
    property OnDblClick;
    property OnMouseMove;
  end;

implementation
{$IFDEF LMD_DEBUGTRACE}
uses
   dialogs;
  {$I C2.INC}
{$ENDIF}

{ ***************************** TLMDCustomChart ****************************** }
{ ---------------------------------- public ---------------------------------- }
function TLMDCustomChart.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_Chart;
end;

{ ***************************** TLMDChart ************************************ }
{ ---------------------------- private --------------------------------------- }
procedure TLMDChart.SetBackground(Value: TLMDChartBackground);
begin
  FBackground.Assign(Value);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChart.SetTitleBox(Value: TLMDChartTitleBox);
begin
  FTitleBox.Assign(Value);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChart.SetChartArea(Value: TLMDChartArea);
begin
  FChartArea.Assign(Value);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChart.SetLegend(Value: TLMDChartLegend);
begin
  FLegend.Assign(Value);
end;

{ ---------------------------- protected ------------------------------------- }

procedure TLMDChart.Paint;
begin
  inherited;
  Draw;
end;

{ ----------------------------- public --------------------------------------- }

procedure TLMDChart.SaveStateToXML(FileName, Comment: string);
var
  LXMLDoc: ILMDXmlDocument;
  LNode: ILMDXmlNode;
begin
  LXMLDoc := LMDCreateXmlDocument(NNChart + Comment, '1.0', '', nil);

  LNode := LXMLDoc.NeedChild(NNChart + Comment);

  FLegend.SaveStateToXML(LNode, '');
  FBackground.SaveStateToXML(LNode, '');
  FTitleBox.SaveStateToXML(LNode, '');
  FSeries.SaveStateToXML(LNode, '');
  FChartArea.SaveStateToXML(LNode, '');

  LXMLDoc.Save(FileName);

end;
{ ---------------------------------------------------------------------------- }

procedure TLMDChart.LoadStateFromXML(FileName, Comment: string);
var
  LXMLDoc: ILMDXmlDocument;
  LNode: ILMDXmlNode;
begin
  LXMLDoc := LMDLoadXmlDocument(FileName);

  LNode := LXMLDoc.NeedChild(NNChart + Comment);

  FLegend.LoadStateFromXML(LNode, '');
  FBackground.LoadStateFromXML(LNode, '');
  FTitleBox.LoadStateFromXML(LNode, '');
  FSeries.LoadStateFromXML(LNode, '');
  FChartArea.LoadStateFromXML(LNode, ''); {!!}
end;
{ ---------------------------------------------------------------------------- }

constructor TLMDChart.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLegend := TLMDChartLegend.Create(self);
  FBackground := TLMDChartBackground.Create(Self);
  FTitleBox := TLMDChartTitleBox.Create(Self);

  FSeriesColl := TLMDChartSeriesColl.Create(Self);
  FSeries := TLMDChartData.Create(self, Self.FSeriesColl);

  FChartArea := TLMDChartArea.Create(self);
  FChartArea.YAxis.SetData(FSeries);
  DoubleBuffered := true;
  //default data state
  {
  FSeries.SetTableSize(3, 3);
  FSeries.SetRowsNames(0, 'Delphi');
  FSeries.SetRowsNames(1, 'C#');
  FSeries.SetRowsNames(2, 'Java');
  FSeries.SetColumnsNames(0, 'DataBase');
  FSeries.SetTableValue(15, 0, 0);
  FSeries.SetTableValue(12, 0, 1);
  FSeries.SetTableValue(-3, 0, 2);
  FSeries.SetColumnsNames(1, 'GameDev');
  FSeries.SetTableValue(10, 1, 0);
  FSeries.SetTableValue(-10, 1, 1);
  FSeries.SetTableValue(10, 1, 2);
  FSeries.SetColumnsNames(2, 'Other');
  FSeries.SetTableValue(5, 2, 0);
  FSeries.SetTableValue(5, 2, 1);
  FSeries.SetTableValue(5, 2, 2);
  FSeries.SetRowsNames(0, 'Delphi');
  FSeries.SetRowsNames(1, 'C#');
  FSeries.SetRowsNames(2, 'Java');
  }
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDChart.Destroy;
begin
  FBackground.Free;
  FTitleBox.Free;
  FSeries.Free;
  FChartArea.Free;
  FSeriesColl.Free;
  FLegend.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChart.Draw;
begin
  DrawTo(Canvas);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChart.DrawTo(ATarget: TCanvas);
var
  LTmpArea, LCurArea: TRect;
  LBackRect: TRect;
  LChanged: boolean;
begin
  Self.Series.Refresh;

  LChanged := false;
  if FTitleBox.IsChanged = true then
    LChanged := true;
  if Legend.IsChanged = true then
    LChanged := true;
  if Background.IsChanged = true then
    LChanged := true;
  if LChanged then
    ChartArea.SetChanged;

  LCurArea := ATarget.ClipRect;
  //ShowMessage(IntToStr(LCurArea.Right - LCurArea.Left) + 'x' + IntToStr(LCurArea.Bottom - LCurArea.Top));  
  //draw main background
  Background.DrawBackground(ATarget, LCurArea);
  //draw title box
  LCurArea := FTitleBox.Draw(ATarget, LCurArea);
  //draw legend
  LTmpArea := Legend.SpaceLeftAfter(LCurArea, Series);
  //if there is at least one chart type and it is set to the property, then draw chart
  if FChartArea.ChartType <> nil then
    ChartArea.DrawChart(ATarget, LTmpArea, Series);
  Legend.Draw(ATarget, LCurArea, Series, LBackRect);

  FTitleBox.NoChanged;
  Legend.NoChanged;
  Background.NoChanged;
  Self.FSeries.NoChanged;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChart.SaveToBMP(AFileName: string; AImageWidth, AImageHeight: integer);
var
  LBuffer: TBitmap;
begin
  LBuffer := TBitmap.Create;
  LBuffer.Height := AImageHeight;
  LBuffer.Width := AImageWidth;
  DrawTo(LBuffer.Canvas);
  LBuffer.SaveToFile(AFileName);
  LBuffer.Free;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChart.SaveToJPG(AFileName: string; AImageWidth, AImageHeight: integer);
var
  LBuffer: TBitmap;

  LJPGBuffer: TJPEGImage;

begin
  LBuffer := TBitmap.Create;

  LJPGBuffer := TJPEGImage.Create;

  try
    LBuffer.Height := AImageHeight;
    LBuffer.Width := AImageWidth;
    DrawTo(LBuffer.Canvas);

    LJPGBuffer.Assign(LBuffer);
    LJPGBuffer.SaveToFile(AFileName);

  finally
    LBuffer.Free;

    LJPGBuffer.Free;

  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChart.SaveToPNG(AFileName: string; AImageWidth, AImageHeight: integer);
var
  LBuffer: TBitmap;

begin
  LBuffer := TBitmap.Create;
  LBuffer.Height := AImageHeight;
  LBuffer.Width := AImageWidth;
  DrawTo(LBuffer.Canvas);

  LBuffer.Free;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChart.SaveChartAreaToJPG(AFileName: string; AImageWidth, AImageHeight: integer);
var
  LBuffer, LBufferCut: TBitmap;

  LJPGBuffer: TJPEGImage;

begin
  LBuffer := TBitmap.Create;
  LBufferCut := TBitmap.Create;

  LJPGBuffer := TJPEGImage.Create;

  try
    LBuffer.Height := AImageHeight;
    LBuffer.Width := AImageWidth;

    ChartArea.DrawChart(LBuffer.Canvas, LBuffer.Canvas.ClipRect, Series);

    LBufferCut.Height := AImageHeight - ChartArea.MarginBottom - ChartArea.MarginTop;
    LBufferCut.Width := AImageWidth - ChartArea.MarginLeft - ChartArea.MarginRight;
    LBufferCut.Canvas.CopyRect(LBufferCut.Canvas.ClipRect, LBuffer.Canvas,
      Rect(
      ChartArea.MarginLeft,
      ChartArea.MarginTop,
      ChartArea.MarginLeft + LBufferCut.Width,
      ChartArea.MarginTop + LBufferCut.Height
      ));

    LJPGBuffer.Assign(LBufferCut);
    LJPGBuffer.SaveToFile(AFileName);

  finally
    LBufferCut.Free;
    LBuffer.Free;

    LJPGBuffer.Free;

  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChart.SaveChartAreaToBMP(AFileName: string; AImageWidth, AImageHeight: integer);
var
  LBuffer, LBufferCut: TBitmap;
begin

  LBuffer := TBitmap.Create;
  LBuffer.Height := AImageHeight;
  LBuffer.Width := AImageWidth;

  ChartArea.DrawChart(LBuffer.Canvas, LBuffer.Canvas.ClipRect, Series);

  LBufferCut := TBitmap.Create;
  LBufferCut.Height := AImageHeight - ChartArea.MarginBottom - ChartArea.MarginTop;
  LBufferCut.Width := AImageWidth - ChartArea.MarginLeft - ChartArea.MarginRight;
  LBufferCut.Canvas.CopyRect(LBufferCut.Canvas.ClipRect, LBuffer.Canvas,
    Rect(
    ChartArea.MarginLeft,
    ChartArea.MarginTop,
    ChartArea.MarginLeft + LBufferCut.Width,
    ChartArea.MarginTop + LBufferCut.Height
    ));

  LBufferCut.SaveToFile(AFileName);
  LBuffer.Free;
  LBufferCut.Free;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChart.SaveLegendToBMP(AFileName: string);
var
  LBuffer, LBufferCut: TBitmap;
  LBackRect: TRect;
begin

  LBuffer := TBitmap.Create;
  LBuffer.Height := 800;
  LBuffer.Width := 600;

  Legend.Draw(LBuffer.Canvas, LBuffer.Canvas.ClipRect, FSeries, LBackRect);

  LBufferCut := TBitmap.Create;
  LBufferCut.Height := LBackRect.Bottom - LBackRect.Top;
  LBufferCut.Width := LBackRect.Right - LBackRect.Left;
  LBufferCut.Canvas.CopyRect(LBufferCut.Canvas.ClipRect, LBuffer.Canvas,
    LBackRect
    );

  LBufferCut.SaveToFile(AFileName);
  LBuffer.Free;
  LBufferCut.Free;
end;

{------------------------------------------------------------------------------}
function TLMDChart.GetChartType: TLMDChartCTAbstract;
begin
  result := FChartArea.ChartType;
end;

{------------------------------------------------------------------------------}
procedure TLMDChart.SetChartType(Value: TLMDChartCTAbstract);
begin
  if Assigned(Self.FChartArea.ChartType) then
    Self.FChartArea.ChartType.RemoveFreeNotification(Self);
  FChartArea.ChartType := Value;
  if Assigned(Self.FChartArea.ChartType) then
    Self.FChartArea.ChartType.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDChart.SetSeriesColl(Value: TLMDChartSeriesColl);
begin
  Self.FSeriesColl.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDChart.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  i: integer;
begin
  inherited;
  if Operation <> opRemove then
    Exit;
  if Assigned(Self.FSeriesColl) then
  begin
    i := 0;
    while i < Self.FSeriesColl.Count do
    begin
      if Self.FSeriesColl.Items[i].Series = AComponent then
      begin
        Self.FSeriesColl.Items[i].Series := nil;
        Self.FSeriesColl.Delete(i);
      end
      else
        Inc(i);
    end;
  end;
  if Self.ChartType = AComponent then
    Self.FChartArea.ChartType := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDChart.SetIsLoadingData(const Value: boolean);
begin
  FIsLoadingData := Value;
  if not FIsLoadingData then
    Self.Refresh;
end;

{------------------------------------------------------------------------------}
procedure TLMDChart.SetDataChanged;
begin
  if Assigned(Self.FSeries) then
    Self.FSeries.SetChanged;
end;

initialization
{$IFDEF LMD_DEBUGTRACE}
  {$I C3.INC}
{$ENDIF}

end.
