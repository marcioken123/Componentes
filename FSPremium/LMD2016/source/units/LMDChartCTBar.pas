unit LMDChartCTBar;
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
LMDChartCTBar unit
-----------------------

Changes
-------
Last (09-June-2006)

###############################################################################}

interface

uses
  Windows, Variants, SysUtils, Types, Math, Graphics, Classes,
  LMDXML, LMDXMLNodeNames, LMDChartData, LMDChartTypes, LMDChartPersistent,
  LMDChartUtils, LMDChartAxis, LMDChartMarker, LMDChartLabel, LMDChartLine,
  LMDChartScaleBreak;

type
  { ************************ TLMDChartCTBar ********************************** }
  /// <summary>
  /// A bar chart displays series as sets of horizontal bars that are grouped
  /// by category. Values are represented by the length of the bars as measured
  /// by the x-axis. Category labels are displayed on the y-axis. Bar charts
  /// are typically used to compare values between categories.
  /// </summary>
  TLMDChartCTBar = class(TLMDChartCTAbstract)
  private
    FColumnAutoSize: boolean;
    FColumnAutoSizeValue: integer;
    FColumnCustomSize: integer;
    FColumnsTransparency: byte;
    FColumnsLabels: TLMDChartLabel;
    FShowColumnsLabels: boolean;
    FLabelsYDeviation: integer;
    FLabelsXDeviation: integer;
    FLabelsMargin: integer;
    FBarsStacked: boolean;
    FFullStacked: boolean;
    FXLine: TLMDChartLine;
    FYLine: TLMDChartLine;
    procedure SetColumnAutoSize(Value: boolean);
    procedure SetColumnAutoSizeValue(Value: integer);
    procedure SetColumnCustomSize(Value: integer);
    procedure SetColumnsLabels(Value: TLMDChartLabel);
    procedure SetColumnsTransparency(Value: byte);
    procedure SetLabelsMargin(Value: integer);
    procedure SetLabelsXDeviation(Value: integer);
    procedure SetLabelsYDeviation(Value: integer);
    procedure SetBarsStacked(Value: boolean);
    procedure SetShowColumnsLabels(Value: boolean);
    procedure SetFullStacked(Value: boolean);
    procedure SetXLine(Value: TLMDChartLine);
    procedure SetYLine(Value: TLMDChartLine);
  protected
    procedure DrawBars(ATarget: TCanvas; AValues: TLMDChartData;
      AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis;
      AShowMarkers: boolean);
    procedure DrawBarsStacked(ATarget: TCanvas; AValues: TLMDChartData;
      AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis;
      AShowMarkers: boolean);
  public
    procedure Assign(ASource: TPersistent); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    /// <summary>
    /// Draws object on canvas
    /// </summary>
    procedure Draw(ABuffer: TBitmap; AArea: TRect; AValues: TLMDChartData;
      AChartArea: TLMDChartPersistent); override;
    /// <summary>
    /// Saves inner object state to xml format
    /// </summary>
    procedure SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string); override;
    /// <summary>
    /// Loads inner object state from xml format
    /// </summary>
    procedure LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string); override;
    function IsChanged: boolean; override;
    procedure NoChanged; override;
    procedure ResetMainOwner(AmainOwner: TPersistent); override;
  published
    property YLine: TLMDChartLine read FYLine write SetYLine;
    property XLine: TLMDChartLine read FXLine write SetXLine;
    property LabelsXDeviation: integer read FLabelsXDeviation write SetLabelsXDeviation default 0;
    property LabelsYDeviation: integer read FLabelsYDeviation write SetLabelsYDeviation default 0;
    property LabelsMargin: integer read FLabelsMargin write SetLabelsMargin default 4;
    property ColumnsLabels: TLMDChartLabel read FColumnsLabels write SetColumnsLabels;
    property ColumnsTransparency: byte read FColumnsTransparency write SetColumnsTransparency default 150;
    property ColumnAutoSize: boolean read FColumnAutoSize write SetColumnAutoSize default true;
    property ColumnAutoSizeValue: integer read FColumnAutoSizeValue write SetColumnAutoSizeValue default 10;
    property ColumnCustomSize: integer read FColumnCustomSize write SetColumnCustomSize default 20;
    property BarsStacked: boolean read FBarsStacked write SetBarsStacked default false;
    property FullStacked: boolean read FFullStacked write SetFullStacked default false;
    property ShowColumnsLabels: boolean read FShowColumnsLabels write SetShowColumnsLabels default true;
  end;

implementation

uses
  LMDChartArea;

{ ************************ TLMDChartCTBar ************************************ }
{ ------------------------ private ------------------------------------------- }

procedure TLMDChartCTBar.SetYLine(Value: TLMDChartLine);
begin
  if Value <> FYLine then
  begin
    FYLine.Assign(Value);
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar.SetXLine(Value: TLMDChartLine);
begin
  if Value <> FXLine then
  begin
    FXLine.Assign(Value);
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar.SetColumnAutoSize(Value: boolean);
begin
  FColumnAutoSize := value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar.SetColumnAutoSizeValue(Value: integer);
begin
  FColumnAutoSizeValue := value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar.SetColumnCustomSize(Value: integer);
begin
  FColumnCustomSize := value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar.SetColumnsLabels(Value: TLMDChartLabel);
begin
  FColumnsLabels.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar.SetColumnsTransparency(Value: byte);
begin
  FColumnsTransparency := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar.SetLabelsMargin(Value: integer);
begin
  FLabelsMargin := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar.SetLabelsXDeviation(Value: integer);
begin
  FLabelsXDeviation := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar.SetLabelsYDeviation(Value: integer);
begin
  FLabelsYDeviation := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar.SetBarsStacked(Value: boolean);
begin
  FBarsStacked := Value;
  if Value = false then
    FFullStacked := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar.SetShowColumnsLabels(Value: boolean);
begin
  FShowColumnsLabels := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;
{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar.SetFullStacked(Value: boolean);
begin
  FFullStacked := Value;
  if Value = true then
    FBarsStacked := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ------------------------ public -------------------------------------------- }

function TLMDChartCTBar.IsChanged: boolean;
begin
  if FColumnsLabels.IsChanged then
    FChanged := true;
  if FYLine.IsChanged then
    FChanged := true;
  if FXLine.IsChanged then
    FChanged := true;
  IsChanged := FChanged;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTBar.NoChanged;
begin
  FChanged := false;
  FColumnsLabels.NoChanged;
  FYLine.NoChanged;
  FXLine.NoChanged;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar.ResetMainOwner(AmainOwner: TPersistent);
begin
  FMainOwner := AMainOwner;
  FColumnsLabels.ResetOwner(FMainOwner);
  FYLine.ResetOwner(FMainOwner);
  FXLine.ResetOwner(FMainOwner);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar.LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin

  WorkNode := BaseNode.NeedChild(NNCTBar + NNSpace + Comment);

  FColumnsLabels.LoadStateFromXML(WorkNode, '');

  IterNode := WorkNode.NeedChild('ColumnsTransparency');
  FColumnsTransparency := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('ShowColumnsLabels');
  FShowColumnsLabels := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('LabelsYDeviation');
  FLabelsYDeviation := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('LabelsXDeviation');
  FLabelsXDeviation := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('LabelsMargin');
  FLabelsMargin := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('BarsStacked');
  FBarsStacked := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('FullStacked');
  FFullStacked := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('ColumnAutoSize');
  FColumnAutoSize := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('ColumnAutoSizeValue');
  FColumnAutoSizeValue := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('ColumnCustomSize');
  FColumnCustomSize := IterNode.GetVarAttr('value', 0);
end;
{ -----------------------------------------------------------------------------}

procedure TLMDChartCTBar.SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  IterNode := BaseNode.AppendElement('ChartType');
  IterNode.SetVarAttr('value', Variant(ChartBarID));

  WorkNode := BaseNode.EnsureChild(NNCTBar + NNSpace + Comment);

  FColumnsLabels.SaveStateToXML(WorkNode, '');

  IterNode := WorkNode.AppendElement('ColumnsTransparency');
  IterNode.SetVarAttr('value', FColumnsTransparency);

  IterNode := WorkNode.AppendElement('ShowColumnsLabels');
  IterNode.SetBoolAttr('value', FShowColumnsLabels);

  IterNode := WorkNode.AppendElement('LabelsYDeviation');
  IterNode.SetVarAttr('value', FLabelsYDeviation);

  IterNode := WorkNode.AppendElement('LabelsXDeviation');
  IterNode.SetVarAttr('value', FLabelsXDeviation);

  IterNode := WorkNode.AppendElement('LabelsMargin');
  IterNode.SetVarAttr('value', FLabelsMargin);

  IterNode := WorkNode.AppendElement('BarsStacked');
  IterNode.SetBoolAttr('value', FBarsStacked);

  IterNode := WorkNode.AppendElement('FullStacked');
  IterNode.SetBoolAttr('value', FFullStacked);

  IterNode := WorkNode.AppendElement('ColumnAutoSize');
  IterNode.SetBoolAttr('value', FColumnAutoSize);

  IterNode := WorkNode.AppendElement('ColumnAutoSizeValue');
  IterNode.SetVarAttr('value', FColumnAutoSizeValue);

  IterNode := WorkNode.AppendElement('ColumnCustomSize');
  IterNode.SetVarAttr('value', FColumnCustomSize);
end;
{ -----------------------------------------------------------------------------}

procedure TLMDChartCTBar.Assign(ASource: TPersistent);
begin
  if ASource is TLMDChartCTBar then
  begin
    try
      FColumnsLabels.Assign(TLMDChartCTBar(ASource).FColumnsLabels);
      FShowColumnsLabels := TLMDChartCTBar(ASource).FShowColumnsLabels;
      ColumnsTransparency := TLMDChartCTBar(ASource).FColumnsTransparency;
      FColumnAutoSize := TLMDChartCTBar(ASource).FColumnAutoSize;
      FColumnAutoSizeValue := TLMDChartCTBar(ASource).ColumnAutoSizeValue;
      FColumnCustomSize := TLMDChartCTBar(ASource).ColumnCustomSize;
      FLabelsYDeviation := TLMDChartCTBar(ASource).FLabelsYDeviation;
      FLabelsXDeviation := TLMDChartCTBar(ASource).FLabelsXDeviation;
      FLabelsMargin := TLMDChartCTBar(ASource).FLabelsMargin;
      FBarsStacked := TLMDChartCTBar(ASource).FBarsStacked;
      FYLine := TLMDChartCTBar(ASource).FYLine;
      FXLine := TLMDChartCTBar(ASource).FXLine;
    finally
    end;
  end;
  inherited Assign(ASource);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDChartCTBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FColumnsLabels := TLMDChartLabel.Create(AOwner);
  FYLine := TLMDChartLine.Create(AOwner);
  FXLine := TLMDChartLine.Create(AOwner);
  //default
  FShowColumnsLabels := true;
  FColumnAutoSize := true;
  FColumnAutoSizeValue := 10;
  FColumnCustomSize := 30;
  FColumnsTransparency := 150;
  FBarsStacked := false;
  FFullStacked := false;
  FLabelsMargin := 4;
  FLabelsYDeviation := 0;
  FLabelsXDeviation := 0;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDChartCTBar.Destroy;
begin
  FColumnsLabels.Free;
  FYLine.Free;
  FXLine.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar.Draw(ABuffer: TBitmap; AArea: TRect;
  AValues: TLMDChartData; AChartArea: TLMDChartPersistent);
var
  LLeftFld, LTopFld, LRightFld, LBottomFld: integer;
  i, j, LTempVar, LPositionOnAxis, LErrorBack, LYLabels, LXLabels: integer;
  LXAxisStart, LXAxisEnd: TPoint;
  LYAxisStart, LYAxisEnd: TPoint;
  LCalcZ, LCalcX: real;
  LTickSz: integer;
  LChartArea: TLMDChartArea;
  LBlackBuf, LWhiteBuf: TBitmap;
  LXLabelsWidth, LYLabelsHeight: integer;
  labeldata: variant;
begin
  inherited;
  LChartArea := TLMDChartArea(AChartArea);
  if BarsStacked then
    AValues.HighestForStacked := true
  else
    AValues.HighestForStacked := false;
  LChartArea.YAxis.AutoScale := LChartArea.YAxis.AutoScale;

  LBlackBuf := TBitmap.Create;
  LBlackBuf.Height := AArea.Bottom - AArea.Top - LChartArea.MarginTop - LChartArea.MarginBottom;
  LBlackBuf.Width := AArea.Right - AArea.Left - LChartArea.MarginLeft - LChartArea.MarginRight;
  LWhiteBuf := TBitmap.Create;
  LWhiteBuf.Height := AArea.Bottom - AArea.Top - LChartArea.MarginTop - LChartArea.MarginBottom;
  LWhiteBuf.Width := AArea.Right - AArea.Left - LChartArea.MarginLeft - LChartArea.MarginRight;
  //in this type of chart X axis - vertical (!)
  LTopFld := LChartArea.InnerIndentTop + LChartArea.Edge.Width;
  LLeftFld := LChartArea.InnerIndentLeft + LChartArea.Edge.Width;
  LRightFld := LChartArea.InnerIndentRight + LChartArea.Edge.Width;
  LBottomFld := LChartArea.InnerIndentBottom + LChartArea.Edge.Width;
  //without autoscale
  LCalcZ := LChartArea.YAxis.MaxValue - LChartArea.YAxis.MinValue;
  LCalcX := LCalcZ / LChartArea.YAxis.MajorStep; // step count
  with ABuffer.Canvas do
  begin
    //calculate max width of XAxis labels
    Font.Assign(LChartArea.XAxis.Font);
    LXLabelsWidth := 0;
    if AValues.ColCount > 0 then
      for i := 0 to AValues.ColCount - 1 do
        LXLabelsWidth := max(LXLabelsWidth, TextWidth(AValues.GetColumnsNames(i)));
    LXLabels := LLeftFld + 1;

    //XAxis ticks size
    LTickSz := 0;
    if (LChartArea.XAxis.MajorTick = ttOutside) or (LChartArea.XAxis.MajorTick = ttCross) then
      LTickSz := LChartArea.XAxis.MajorTickSize + 4;
    if (LChartArea.XAxis.MinorTick = ttOutside) or (LChartArea.XAxis.MinorTick = ttCross) then
      if LChartArea.XAxis.MinorTickSize > LTickSz then
        LTickSz := LChartArea.XAxis.MinorTickSize + 4;
    LLeftFld := LLeftFld + LTickSz;

    //calculate position of YAxis (in this type of chart - horizontal) (!)
    Font.Assign(LChartArea.XAxis.Font);
    LYLabelsHeight := TextHeight('0,0');
    LTickSz := 0;
    LYLabels := ABuffer.Height - LBottomFld - LYLabelsHeight;
    if (LChartArea.YAxis.MajorTick = ttOutside) or (LChartArea.YAxis.MajorTick = ttCross) then
      LTickSz := LChartArea.YAxis.MajorTickSize + 4;
    if (LChartArea.YAxis.MinorTick = ttOutside) or (LChartArea.YAxis.MinorTick = ttCross) then
      if LChartArea.YAxis.MinorTickSize > LTickSz then
        LTickSz := LChartArea.YAxis.MinorTickSize + 4;
    LBottomFld := LBottomFld + LTickSz;
    LYAxisStart.Y := ABuffer.Height - LBottomFld - LYLabelsHeight;
    LYAxisStart.X := LXLabelsWidth + LLeftFld + 1;
    LYAxisEnd.Y := ABuffer.Height - LBottomFld - LYLabelsHeight;
    LYAxisEnd.X := ABuffer.Width - 1 - LRightFld;

    //calc position of XAxis
    LXAxisStart.X := LYAxisStart.X + LChartArea.YAxis.CalcPosFromBottom(LYAxisEnd.X - LYAxisStart.X, 0, LErrorBack);
    LXAxisStart.Y := LTopFld + 1;
    LXAxisEnd.X := LYAxisStart.X + LChartArea.YAxis.CalcPosFromBottom(LYAxisEnd.X - LYAxisStart.X, 0, LErrorBack);
    LXAxisEnd.Y := LYAxisStart.Y;

    //draw X major grid
    LChartArea.MajorGridLineHorizontal.SetupCanvasPen(Pen);
    if LChartArea.MajorGridHorizontal then
    begin
      LTempVar := LXAxisEnd.Y - LXAxisStart.Y;
      if AValues.ColCount > 1 then
      begin
        for i := 0 to AValues.ColCount do
        begin
          LPositionOnAxis := Trunc(LTempVar * ((1 / AValues.ColCount) * i));
          DrawLine(LYAxisStart.X, LXAxisEnd.Y - LPositionOnAxis, LYAxisEnd.X, LXAxisEnd.Y - LPositionOnAxis, ABuffer.Canvas);
        end;
      end;
    end;

    //draw YAxis  major labels and ticks
    Brush.Style := bsClear;
    Font.Assign(LChartArea.YAxis.Font);
    if LCalcX > 0 then
      for i := 0 to Trunc(StrToFloat(FloatToStr(LCalcX))) do
      begin
        LPositionOnAxis := LChartArea.YAxis.CalcPosFromBottom(LYAxisEnd.X - LYAxisStart.X, LChartArea.YAxis.MinValue + LChartArea.YAxis.MajorStep * i, LErrorBack);
        DrawXTick(ABuffer.Canvas,
          LYAxisStart.X + LPositionOnAxis,
          LYAxisEnd.Y,
          LChartArea.YAxis.MajorTickSize,
          LChartArea.YAxis.MajorTick,
          FYLine);
        labeldata := LChartArea.YAxis.MinValue + LChartArea.YAxis.MajorStep * i;
        if not BarsStacked then
        begin
          if (LChartArea.YAxis.ScaleBreak.Enabled) and (labeldata > LChartArea.YAxis.ScaleBreak.PositiveLowLimit) and
            ((LChartArea.YAxis.ScaleBreak.Appearance = sbaPositive) or (LChartArea.YAxis.ScaleBreak.Appearance = sbaBoth)) then
            labeldata := labeldata + LChartArea.YAxis.ScaleBreak.PositiveHighLimit - LChartArea.YAxis.ScaleBreak.PositiveLowLimit;
          if (LChartArea.YAxis.ScaleBreak.Enabled) and (labeldata < LChartArea.YAxis.ScaleBreak.NegativeLowLimit) and
            ((LChartArea.YAxis.ScaleBreak.Appearance = sbaNegative) or (LChartArea.YAxis.ScaleBreak.Appearance = sbaBoth)) then
            labeldata := labeldata + LChartArea.YAxis.ScaleBreak.NegativeHighLimit - LChartArea.YAxis.ScaleBreak.NegativeLowLimit;
        end;
        labeldata := Round(labeldata);
        TextOut((LYAxisStart.X + LPositionOnAxis) - TextWidth(floattostr(labeldata)) div 2,
          LYLabels,
          floattostr(labeldata) + AValues.ValIndicator);
      end;
    FYLine.SetupCanvasPen(Pen);
    DrawLine(LYAxisStart.X, LYAxisStart.Y, LYAxisEnd.X, LYAxisEnd.Y, ABuffer.Canvas);

    //draw Y major grid
    LChartArea.MajorGridLineVertical.SetupCanvasPen(Pen);
    if LChartArea.MajorGridVertical then
    begin
      if LCalcX > 0 then
        for i := 0 to Trunc(StrToFloat(FloatToStr(LCalcX))) do
        begin
          LPositionOnAxis := LChartArea.YAxis.CalcPosFromBottom(LYAxisEnd.X - LYAxisStart.X, LChartArea.YAxis.MinValue + LChartArea.YAxis.MajorStep * i, LErrorBack);
          DrawLine(LYAxisStart.X + LPositionOnAxis, LYAxisEnd.Y, LYAxisStart.X + LPositionOnAxis, LXAxisStart.Y, ABuffer.Canvas);
        end;
    end;
  end;

  //draw bars
  LWhiteBuf.Canvas.Brush.Color := clWhite;
  LWhiteBuf.Canvas.Pen.Style := psClear;
  LWhiteBuf.Canvas.FillRect(LWhiteBuf.Canvas.ClipRect);
  LBlackBuf.Canvas.Brush.Color := clBlack;
  LBlackBuf.Canvas.Pen.Style := psClear;
  LBlackBuf.Canvas.FillRect(LBlackBuf.Canvas.ClipRect);

  if not FBarsStacked then
  begin
    DrawBars(LWhiteBuf.Canvas, AValues, LXAxisStart.Y, LXAxisEnd.Y, LYAxisStart.X, LYAxisEnd.X, LChartArea.YAxis, LChartArea.ShowMarkers);
    DrawBars(LBlackBuf.Canvas, AValues, LXAxisStart.Y, LXAxisEnd.Y, LYAxisStart.X, LYAxisEnd.X, LChartArea.YAxis, LChartArea.ShowMarkers);
    DrawTransparency(ABuffer, LWhiteBuf, LBlackBuf, LChartArea.Shadow, LChartArea.ShadowColor, LChartArea.ShadowDepth, LChartArea.ShadowTransparency, FColumnsTransparency);
  end
  else
  begin
    DrawBarsStacked(LWhiteBuf.Canvas, AValues, LXAxisStart.Y, LXAxisEnd.Y, LYAxisStart.X, LYAxisEnd.X, LChartArea.YAxis, LChartArea.ShowMarkers);
    DrawBarsStacked(LBlackBuf.Canvas, AValues, LXAxisStart.Y, LXAxisEnd.Y, LYAxisStart.X, LYAxisEnd.X, LChartArea.YAxis, LChartArea.ShowMarkers);
    DrawTransparency(ABuffer, LWhiteBuf, LBlackBuf, LChartArea.Shadow, LChartArea.ShadowColor, LChartArea.ShadowDepth, LChartArea.ShadowTransparency, FColumnsTransparency);
  end;

  //draw XAxis--------------
  with ABuffer.Canvas do
  begin

    Font.Assign(LChartArea.XAxis.Font);
    FXLine.SetupCanvasPen(Pen);
    DrawLine(LXAxisStart.X, LXAxisStart.Y, LXAxisEnd.X, LXAxisEnd.Y, ABuffer.Canvas);

    // length of X axis
    LTempVar := LXAxisEnd.Y - LXAxisStart.Y;
    //draw all ticks and labels
    brush.Style := bsClear;
    if AValues.ColCount > 1 then
    begin
      //major ticks
      for i := 0 to AValues.ColCount do
      begin
        LPositionOnAxis := Trunc(LTempVar * ((1 / AValues.ColCount) * i));
        DrawYTick(ABuffer.Canvas, LXAxisStart.X, LXAxisEnd.Y - LPositionOnAxis, LChartArea.XAxis.MajorTickSize, LChartArea.XAxis.MajorTick, FXLine);
      end;

      //minor ticks
      for i := 1 to AValues.ColCount * 2 do
      begin
        if not odd(i) then
          Continue;
        LPositionOnAxis := Trunc(LTempVar * ((1 / (AValues.ColCount * 2)) * i));
        DrawYTick(ABuffer.Canvas, LXAxisStart.X, LXAxisEnd.Y - LPositionOnAxis, LChartArea.XAxis.MinorTickSize, LChartArea.XAxis.MinorTick, FXLine);
      end;
      //labels
      j := 1;
      for i := 1 to AValues.ColCount * 2 do
      begin
        if not odd(i) then
          Continue;
        LPositionOnAxis := Trunc(LTempVar * ((1 / (AValues.ColCount * 2)) * i));
        if AValues.GetColumnsNames(j - 1) = '' then
          TextOut(LXLabels, LXAxisEnd.Y - LPositionOnAxis - TextHeight(IntToStr(j)) div 2, IntToStr(j))
        else
          TextOut(LXLabels, LXAxisEnd.Y - LPositionOnAxis - TextHeight(AValues.GetColumnsNames(j - 1)) div 2, AValues.GetColumnsNames(j - 1));
        j := j + 1;
      end;
    end;
  end;
  LWhiteBuf.Free;
  LBlackBuf.Free;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar.DrawBars(ATarget: TCanvas; AValues: TLMDChartData;
  AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
var
  LDelta, i, j, LPositionOnAxis, LBarWidth, LErrorBack, LPosY: integer;
  labelstr: string;
  loaddata, labeldata: variant;
  OffSetNeg, OffSetPos: variant;
  fp, lp: TPoint;
begin
  OffSetPos := 0;
  OffSetNeg := 0;
  if AYAxis.ScaleBreak.Enabled then
  begin
    OffSetPos := AYAxis.ScaleBreak.PositiveLowLimit - AYAxis.ScaleBreak.PositiveHighLimit;
    OffSetNeg := AYAxis.ScaleBreak.NegativeLowLimit - AYAxis.ScaleBreak.NegativeHighLimit;
  end;
  LDelta := AEndX - AStartX;
  if (AValues.ColCount > 0) and (AValues.RowCount > 0) then
  begin
    for i := 0 to (AValues.ColCount * 2) - 1 do
    begin
      if not odd(i) then
        Continue;
      LPositionOnAxis := Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * i));
      //check column width
      if not FColumnAutoSize then
        LBarWidth := FColumnCustomSize
      else
        LBarWidth := (Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * (i + 1))) - Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * (i - 1))) - FColumnAutoSizeValue * 2) div AValues.RowCount;
      //draw column
      LPosY := (AEndX - LPositionOnAxis) + (AValues.RowCount * LBarWidth div 2);
      for j := 0 to AValues.RowCount - 1 do
      begin
        if AValues.GetTableValue(i div 2, j) = EmptyID then
          loaddata := 0
        else
          loaddata := AValues.GetTableValue(i div 2, j);
        labeldata := loaddata;
        if (loaddata > AYAxis.ScaleBreak.PositiveHighLimit) and
          ((AYAxis.ScaleBreak.Appearance = sbaPositive) or (AYAxis.ScaleBreak.Appearance = sbaBoth)) then
          loaddata := loaddata + OffSetPos;
        if (loaddata < AYAxis.ScaleBreak.NegativeHighLimit) and
          ((AYAxis.ScaleBreak.Appearance = sbaNegative) or (AYAxis.ScaleBreak.Appearance = sbaBoth)) then
          loaddata := loaddata + OffSetNeg;
        AValues.GetRowsLines(j).SetupCanvasPen(ATarget.Pen);
        if loaddata < 0 then //if values is negative
        begin
          AValues.GetRowsLines(j).SetupCanvasPen(ATarget.Pen);
          AValues.GetRowFill(j).DrawRectangle(ATarget, AValues.GetRowsLines(j), AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack), LPosY + 1, AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, LErrorBack) + 1, LPosY - LBarWidth);
          if AShowMarkers then
            AValues.GetRowMarker(j).Draw(ATarget, AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack), trunc(LPosY - LBarWidth / 2));
          if FShowColumnsLabels then
            ColumnsLabels.Draw(ATarget, floattostr(labeldata), AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack) - FLabelsMargin - FLabelsXDeviation, trunc(LPosY - LBarWidth / 2) + FLabelsYDeviation, claRightTop, clcVertical);
        end
        else
          if loaddata > 0 then
          begin
            AValues.GetRowsLines(j).SetupCanvasPen(ATarget.Pen);
            AValues.GetRowFill(j).DrawRectangle(ATarget, AValues.GetRowsLines(j), AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack) + 1, LPosY + 1, AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, LErrorBack), LPosY - LBarWidth);
            if AShowMarkers then
              AValues.GetRowMarker(j).Draw(ATarget, AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack), trunc(LPosY - LBarWidth / 2));
            if FShowColumnsLabels then
            begin
              if AValues.GetTableValue(i div 2, j) = EmptyID then
                labelstr := 'none'
              else
                labelstr := floattostr(loaddata);
              ColumnsLabels.Draw(ATarget, floattostr(labeldata), AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack) + FLabelsMargin + FLabelsXDeviation, trunc(LPosY - LBarWidth / 2) + FLabelsYDeviation, claLeftTop, clcVertical);
            end;
          end;
        LPosY := LPosY - LBarWidth;
      end;
    end;
  end;
  if AYAxis.ScaleBreak.Enabled then
  begin
    if (AYAxis.ScaleBreak.Appearance = sbaPositive) or (AYAxis.ScaleBreak.Appearance = sbaBoth) then
    begin
      fp.Y := AStartX;
      lp.Y := AEndX;
      fp.X := AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, AYAxis.ScaleBreak.PositiveLowLimit, LErrorBack);
      lp.X := fp.X;
      AYAxis.ScaleBreak.RenderBreak(ATarget, fp, lp, true, true);
    end;
    if (AYAxis.ScaleBreak.Appearance = sbaNegative) or (AYAxis.ScaleBreak.Appearance = sbaBoth) then
    begin
      fp.Y := AStartX;
      lp.Y := AEndX;
      fp.X := AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, AYAxis.ScaleBreak.NegativeLowLimit, LErrorBack);
      lp.X := fp.X;
      AYAxis.ScaleBreak.RenderBreak(ATarget, fp, lp, true, true);
    end;
  end;
end;

procedure TLMDChartCTBar.DrawBarsStacked(ATarget: TCanvas;
  AValues: TLMDChartData; AStartX, AEndX, AStartY, AEndY: integer;
  AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
var
  i, j: integer;
  LColumnPosition, LColumnWidth, LErrorBack, LDelta, LPosY: integer;
  LAccomulation, SumVal: real;
  Factors: array of real;
  loaddata: variant;
begin
  LDelta := AEndX - AStartX;
  if (AValues.ColCount > 0) and (AValues.RowCount > 0) then
  begin
    SetLength(factors, AValues.ColCount);
    if (FFullStacked) then
    begin
      for i := 0 to AValues.ColCount - 1 do
      begin
        SumVal := 0;
        for j := 0 to AValues.RowCount - 1 do
        begin
          if AValues.GetTableValue(i, j) = EmptyID then
            loaddata := 0
          else
            loaddata := AValues.GetTableValue(i, j);
          SumVal := SumVal + abs(loaddata);
        end;
        Factors[i] := SumVal;
      end;
      for i := 0 to AValues.ColCount - 1 do
        Factors[i] := AYAxis.MaxValue / Factors[i];
    end
    else
      for i := 0 to AValues.ColCount - 1 do
        Factors[i] := 1;

    for i := 0 to (AValues.ColCount * 2) - 1 do
    begin

      if not odd(i) then
        Continue;
      LColumnPosition := Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * i));
      //check column width
      if not FColumnAutoSize then
        LColumnWidth := FColumnCustomSize
      else
        LColumnWidth := (Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * (i + 1))) -
          Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * (i - 1))) - FColumnAutoSizeValue * 2);
      //draw column
      LPosY := (AEndX - LColumnPosition) + LColumnWidth div 2;
      //negative
      LAccomulation := 0;
      for j := 0 to AValues.RowCount - 1 do
      begin
        if AValues.GetTableValue(i div 2, j) = EmptyID then
          loaddata := 0
        else
          loaddata := AValues.GetTableValue(i div 2, j);
        if loaddata < 0 then
        begin
          AValues.GetRowFill(j).DrawRectangle(ATarget,
            AValues.GetRowsLines(j),
            AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation, LErrorBack) + 1,
            LPosY - LColumnWidth,
            AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata * Factors[i div 2], LErrorBack)
            , LPosY
            );
          if FShowColumnsLabels then
            ColumnsLabels.Draw(ATarget, floattostr(AValues.GetTableValue(i div 2, j)), AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata / 2, LErrorBack) + FLabelsMargin + FLabelsXDeviation,
              LPosY - LColumnWidth div 2 + FLabelsYDeviation, claLeftTop, clcHorzVert);
          LAccomulation := LAccomulation + loaddata * Factors[i div 2];
        end;
      end;
      //positive
      LAccomulation := 0;
      for j := 0 to AValues.RowCount - 1 do
      begin
        if AValues.GetTableValue(i div 2, j) = EmptyID then
          loaddata := 0
        else
          loaddata := AValues.GetTableValue(i div 2, j);
        if loaddata > 0 then
        begin
          AValues.GetRowFill(j).DrawRectangle(ATarget,
            AValues.GetRowsLines(j),
            AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation, LErrorBack),
            LPosY - LColumnWidth,
            AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata * Factors[i div 2], LErrorBack) + 1
            , LPosY
            );
          if FShowColumnsLabels then
            ColumnsLabels.Draw(ATarget, floattostr(AValues.GetTableValue(i div 2, j)), AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata / 2, LErrorBack) + FLabelsMargin + FLabelsXDeviation,
              LPosY - LColumnWidth div 2 + FLabelsYDeviation, claLeftTop, clcHorzVert);
          LAccomulation := LAccomulation + loaddata * Factors[i div 2];
        end;
      end;

    end;

  end;

end;

end.
