unit LMDChartLegend;
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
LMDChartLegend
-----------------------------------

Changes
-------
Last (08-June-2006)

###############################################################################}

interface

uses
  Windows, Graphics, Classes, Variants, Types, Math,
  LMDXML, LMDXMLNodeNames, LMDChartBackground, LMDChartPersistent, LMDChartLine,
  LMDChartData, LMDChartFont;

type
  TLMDLegendAlignment = (laTop, laTopRight, laTopLeft, laBottom, laBottomLeft,
    laBottomRight, laLeft, laRight, laAbsolute);

  { ************************ TLMDChartLegend ********************************* }
  /// <summary>
  /// TLMDChartLegend. Adds a legend to your chart control, where
  /// the legend displays the label for each data series
  /// in the chart and a key showing the chart element
  /// for the series.
  /// </summary>
  TLMDChartLegend = class(TLMDChartPersistent)
  private
    FShow: boolean;
    FAbsoluteX: integer;
    FAbsoluteY: integer;
    FOverlap: boolean;
    FAlignment: TLMDLegendAlignment;
    FEdge: TLMDChartLine;
    FFont: TLMDChartFont;
    FBackground: TLMDChartBackground;
    FMarginEdge: integer;
    FMarginChart: integer;
    FHorizontalListing: boolean;
    FSpaceBtwLines: integer;
    FIconSize: integer;
    FSpaceAfterIcon: integer;
    //inners indets
    FInnerIndentLeft: integer;
    FInnerIndentRight: integer;
    FInnerIndentTop: integer;
    FInnerIndentBottom: integer;
    procedure SetAlignment(Value: TLMDLegendAlignment);
    procedure SetEdge(Value: TLMDChartLine);
    procedure SetFont(Value: TLMDChartFont);
    procedure SetMarginEdge(Value: integer);
    procedure SetMarginChart(Value: integer);
    procedure SetHorizontalListing(Value: boolean);
    procedure SetIconSize(Value: integer);
    procedure SetInnerIndentBottom(Value: integer);
    procedure SetInnerIndentLeft(Value: integer);
    procedure SetInnerIndentRight(Value: integer);
    procedure SetInnerIndentTop(Value: integer);
    procedure SetSpaceBtwLines(Value: integer);
    procedure SetBackground(Value: TLMDChartBackground);
    procedure SetSpaceAfterIcon(Value: integer);
    procedure SetOverlap(Value: boolean);
    procedure SetAbsoluteX(Value: integer);
    procedure SetAbsoluteY(Value: integer);
    procedure SetShow(Value: boolean);
  protected
  public
    constructor Create(AMainOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
    /// <summary>
    /// Draws object on canvas
    /// </summary>
    function Draw(ATarget: TCanvas; AArea: TRect; AVal: TLMDChartData; var ABorders: TRect): TRect;
    function SpaceLeftAfter(AArea: TRect; AVal: TLMDChartData): TRect;
    /// <summary>
    /// Saves inner object state to xml format
    /// </summary>
    procedure SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
    /// <summary>
    /// Loads inner object state from xml format
    /// </summary>
    procedure LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
  published
    property Show: boolean read FShow write SetShow default true;
    property AbsoluteX: integer read FAbsoluteX write SetAbsoluteX default 0;
    property AbsoluteY: integer read FAbsoluteY write SetAbsoluteY default 0;
    property Overlap: boolean read FOverlap write SetOverlap default false;
    property Background: TLMDChartBackground read FBackground write SetBackground;
    property Edge: TLMDChartLine read FEdge write SetEdge;
    property Font: TLMDChartFont read FFont write SetFont;
    property MarginEdge: integer read FMarginEdge write SetMarginEdge default 5;
    property MarginChart: integer read FMarginChart write SetMarginChart default 5;
    property HorizontalListing: boolean read FHorizontalListing write SetHorizontalListing default true;
    property SpaceBtwLines: integer read FSpaceBtwLines write SetSpaceBtwLines default 5;
    property IconSize: integer read FIconSize write SetIconSize default 6;
    property InnerIndentLeft: integer read FInnerIndentLeft write SetInnerIndentLeft default 4;
    property InnerIndentRight: integer read FInnerIndentRight write SetInnerIndentRight default 4;
    property InnerIndentTop: integer read FInnerIndentTop write SetInnerIndentTop default 4;
    property InnerIndentBottom: integer read FInnerIndentBottom write SetInnerIndentBottom default 4;
    property SpaceAfterIcon: integer read FSpaceAfterIcon write SetSpaceAfterIcon default 2;
    property Alignment: TLMDLegendAlignment read FAlignment write SetAlignment default laTop;
  end;

implementation

{ ************************** TLMDChartLegend ********************************* }
{ -------------------------- private ------------------------------------------}

procedure TLMDChartLegend.SetAlignment(Value: TLMDLegendAlignment);
begin
  FAlignment := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartLegend.SetBackground(Value: TLMDChartBackground);
begin
  FBackground.Assign(Value);
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartLegend.SetEdge(Value: TLMDChartLine);
begin
  FEdge.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartLegend.SetFont(Value: TLMDChartFont);
begin
  FFont.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartLegend.SetHorizontalListing(Value: boolean);
begin
  FHorizontalListing := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartLegend.SetIconSize(Value: integer);
begin
  FIconSize := Value;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartLegend.SetInnerIndentBottom(Value: integer);
begin
  FInnerIndentBottom := Value;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartLegend.SetInnerIndentLeft(Value: integer);
begin
  FInnerIndentLeft := Value;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartLegend.SetInnerIndentRight(Value: integer);
begin
  FInnerIndentRight := Value;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartLegend.SetInnerIndentTop(Value: integer);
begin
  FInnerIndentTop := Value;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartLegend.SetMarginChart(Value: integer);
begin
  FMarginChart := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartLegend.SetMarginEdge(Value: integer);
begin
  FMarginEdge := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartLegend.SetOverlap(Value: boolean);
begin
  FOverlap := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartLegend.SetSpaceAfterIcon(Value: integer);
begin
  FSpaceAfterIcon := Value;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartLegend.SetSpaceBtwLines(Value: integer);
begin
  FSpaceBtwLines := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartLegend.SetAbsoluteX(Value: integer);
begin
  FAbsoluteX := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartLegend.SetAbsoluteY(Value: integer);
begin
  FAbsoluteY := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartLegend.SetShow(Value: boolean);
begin
  FShow := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -------------------------- public -------------------------------------------}

procedure TLMDChartLegend.SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  WorkNode := BaseNode.EnsureChild(NNChartLegend + Comment);
  FEdge.SaveStateToXML(WorkNode, '');
  FBackground.SaveStateToXML(WorkNode, '');
  FFont.SaveStateToXML(WorkNode, '');
  IterNode := WorkNode.AppendElement('Show');
  IterNode.SetBoolAttr('value', FShow);
  IterNode := WorkNode.AppendElement('AbsoluteX');
  IterNode.SetVarAttr('value', FAbsoluteX);
  IterNode := WorkNode.AppendElement('AbsoluteY');
  IterNode.SetVarAttr('value', FAbsoluteY);
  IterNode := WorkNode.AppendElement('Overlap');
  IterNode.SetBoolAttr('value', FOverlap);
  IterNode := WorkNode.AppendElement('Alignment');
  IterNode.SetVarAttr('value', Variant(FAlignment));
  IterNode := WorkNode.AppendElement('MarginEdge');
  IterNode.SetVarAttr('value', FMarginEdge);
  IterNode := WorkNode.AppendElement('MarginChart');
  IterNode.SetVarAttr('value', FMarginChart);
  IterNode := WorkNode.AppendElement('HorizontalListing');
  IterNode.SetBoolAttr('value', FHorizontalListing);
  IterNode := WorkNode.AppendElement('SpaceBtwLines');
  IterNode.SetVarAttr('value', FSpaceBtwLines);
  IterNode := WorkNode.AppendElement('IconSize');
  IterNode.SetVarAttr('value', FIconSize);
  IterNode := WorkNode.AppendElement('SpaceAfterIcon');
  IterNode.SetVarAttr('value', FSpaceAfterIcon);
  IterNode := WorkNode.AppendElement('InnerIndentLeft');
  IterNode.SetVarAttr('value', FInnerIndentLeft);
  IterNode := WorkNode.AppendElement('InnerIndentRight');
  IterNode.SetVarAttr('value', FInnerIndentRight);
  IterNode := WorkNode.AppendElement('InnerIndentTop');
  IterNode.SetVarAttr('value', FInnerIndentTop);
  IterNode := WorkNode.AppendElement('InnerIndentBottom');
  IterNode.SetVarAttr('value', FInnerIndentBottom);
end;
{ -----------------------------------------------------------------------------}

procedure TLMDChartLegend.LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  WorkNode := BaseNode.NeedChild(NNChartLegend + Comment);
  FEdge.LoadStateFromXML(WorkNode, '');
  FFont.LoadStateFromXML(WorkNode, '');
  FBackground.LoadStateFromXML(WorkNode, '');

  IterNode := WorkNode.NeedChild('Show');
  FShow := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('AbsoluteX');
  FAbsoluteX := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('AbsoluteY');
  FAbsoluteY := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('Overlap');
  FOverlap := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('Alignment');
  FAlignment := TLMDLegendAlignment(IterNode.GetVarAttr('value', 0));

  IterNode := WorkNode.NeedChild('MarginEdge');
  FMarginEdge := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('MarginChart');
  FMarginChart := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('HorizontalListing');
  FHorizontalListing := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('SpaceBtwLines');
  FSpaceBtwLines := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('IconSize');
  FIconSize := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('SpaceAfterIcon');
  FSpaceAfterIcon := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('InnerIndentLeft');
  FInnerIndentLeft := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('InnerIndentRight');
  FInnerIndentRight := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('InnerIndentTop');
  FInnerIndentTop := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('InnerIndentBottom');
  FInnerIndentBottom := IterNode.GetVarAttr('value', 0);
end;
{ -----------------------------------------------------------------------------}

procedure TLMDChartLegend.Assign(ASource: TPersistent);
begin
  if ASource is TLMDChartLegend then
  begin
    try
    finally
      FShow := TLMDChartLegend(ASource).FShow;
      FAbsoluteX := TLMDChartLegend(ASource).FAbsoluteX;
      FAbsoluteY := TLMDChartLegend(ASource).FAbsoluteY;
      FOverlap := TLMDChartLegend(ASource).FOverlap;
      FAlignment := TLMDChartLegend(ASource).FAlignment;
      FSpaceAfterIcon := TLMDChartLegend(ASource).FSpaceAfterIcon;
      FEdge.Assign(TLMDChartLegend(ASource).FEdge);
      FFont.Assign(TLMDChartLegend(ASource).FFont);
      FBackground.Assign(TLMDChartLegend(ASource).FBackground);
      FMarginEdge := TLMDChartLegend(ASource).FMarginEdge;
      FMarginChart := TLMDChartLegend(ASource).FMarginChart;
      FHorizontalListing := TLMDChartLegend(ASource).FHorizontalListing;
      FSpaceBtwLines := TLMDChartLegend(ASource).FSpaceBtwLines;
      FIconSize := TLMDChartLegend(ASource).FIconSize;
      FInnerIndentLeft := TLMDChartLegend(ASource).FInnerIndentLeft;
      FInnerIndentRight := TLMDChartLegend(ASource).FInnerIndentRight;
      FInnerIndentTop := TLMDChartLegend(ASource).FInnerIndentTop;
      FInnerIndentBottom := TLMDChartLegend(ASource).FInnerIndentBottom;
    end;
  end;
  inherited Assign(ASource);
end;

{ -----------------------------------------------------------------------------}

constructor TLMDChartLegend.Create(AMainOwner: TPersistent);
begin
  inherited Create(AMainOwner);
  FFont := TLMDChartFont.Create(AMainOwner);
  FEdge := TLMDChartLine.Create(AMainOwner);
  FBackground := TLMDChartBackground.Create(AMainOwner);
  //default values
  FShow := true;
  FOverlap := false;
  FSpaceAfterIcon := 2;
  FMarginEdge := 5;
  FMarginChart := 5;
  FHorizontalListing := true;
  FSpaceBtwLines := 5;
  FIconSize := 6;
  FInnerIndentLeft := 4;
  FInnerIndentRight := 4;
  FInnerIndentTop := 4;
  FInnerIndentBottom := 4;
  FAlignment := laTop;
  FAbsoluteX := 0;
  FAbsoluteY := 0;
end;

{ -----------------------------------------------------------------------------}

destructor TLMDChartLegend.Destroy;
begin
  FEdge.Free;
  FBackground.Free;
  FFont.Free;
  inherited;
end;

{ -----------------------------------------------------------------------------}

function TLMDChartLegend.Draw(ATarget: TCanvas; AArea: TRect; AVal: TLMDChartData; var ABorders: TRect): TRect;
var
  LPosX, LIconLeftFld, LTextLeftFld, LPosY: integer;
  LStringsLength, i, LLongestStr, LElemsH, LLegWidth, LLegHeight, LLegX, LLegY: integer;
  LBuffer: TBitmap;
  LTmpArea: TRect;
  LIconIsCenter: boolean;
begin
  if not FShow then
    exit;
  LBuffer := TBitmap.Create;
  //calculate legenda size
  FEdge.SetupCanvasPen(ATarget.Pen);
  LBuffer.Canvas.Font.Assign(FFont);
  if not FHorizontalListing then
  begin
    LElemsH := 0;
    LLongestStr := 0;
    for i := 0 to AVal.RowCount - 1 do
      LLongestStr := Max(LLongestStr, LBuffer.Canvas.TextWidth(AVal.GetRowsNames(i)));
    for i := 0 to AVal.RowCount - 1 do
      LElemsH := LElemsH + Max(FIconSize, LBuffer.Canvas.TextHeight(AVal.GetRowsNames(i)));
    LLegHeight := FInnerIndentTop + FInnerIndentBottom + LElemsH + (AVal.RowCount - 1) * FSpaceBtwLines;
    LLegWidth := FInnerIndentLeft + FInnerIndentRight + LLongestStr + FIconSize + FSpaceAfterIcon;
  end
  else
  begin
    LElemsH := 0;
    for i := 0 to AVal.RowCount - 1 do
      LElemsH := Max(LElemsH, Max(LBuffer.Canvas.TextHeight(AVal.GetRowsNames(i)), FIconSize));
    LStringsLength := 0;
    for i := 0 to AVal.RowCount - 1 do
      LStringsLength := LStringsLength + LBuffer.Canvas.TextWidth(AVal.GetRowsNames(i));
    LLegHeight := LElemsH + FInnerIndentTop + FInnerIndentBottom;
    LLegWidth := LStringsLength + (FIconSize + FSpaceAfterIcon) * AVal.RowCount + FInnerIndentLeft + FInnerIndentRight + (AVal.RowCount - 1) * FSpaceBtwLines;
  end;
  //setup buffer
  LBuffer.Height := LLegHeight;
  LBuffer.Width := LLegWidth;
  //legend position
  case FAlignment of
    laAbsolute:
      begin
        LLegX := FAbsoluteX;
        LLegY := FAbsoluteY;
      end;
    laRight:
      begin
        LLegX := AArea.Right - LLegWidth - MarginEdge;
        LLegY := (AArea.Bottom - AArea.Top) div 2 - (LLegHeight div 2);
      end;
    laLeft:
      begin
        LLegX := AArea.Left + MarginEdge;
        LLegY := (AArea.Bottom - AArea.Top) div 2 - (LLegHeight div 2);
      end;
    laTop:
      begin
        LLegX := (AArea.Right - AArea.Left) div 2 - (LLegWidth div 2);
        LLegY := AArea.Top + MarginEdge;
      end;
    laBottom:
      begin
        LLegX := (AArea.Right - AArea.Left) div 2 - (LLegWidth div 2);
        LLegY := AArea.Bottom - MarginEdge - LLegHeight;
      end;
    laTopRight:
      begin
        LLegX := AArea.Right - LLegWidth - MarginEdge;
        LLegY := AArea.Top + MarginEdge;
      end;
    laTopLeft:
      begin
        LLegX := AArea.Left + MarginEdge;
        LLegY := AArea.Top + MarginEdge;
      end;
    laBottomLeft:
      begin
        LLegX := AArea.Left + MarginEdge;
        LLegY := AArea.Bottom - MarginEdge - LLegHeight;
      end;
    laBottomRight:
      begin
        LLegX := AArea.Right - MarginEdge - LLegWidth;
        LLegY := AArea.Bottom - MarginEdge - LLegHeight;
      end
  else
    LLegX := 0;
    LLegY := 0;
  end;
  LTmpArea.Top := LLegX;
  LTmpArea.Left := LLegY;
  LTmpArea.Right := LLegX + LLegWidth;
  LTmpArea.Bottom := LLegY + LLegHeight;
  //draw legend
  if FBackground.Style = cbsNone then
    LBuffer.Canvas.CopyRect(LBuffer.Canvas.ClipRect,
      ATarget, rect(LLegX, LLegY, LLegX + LBuffer.Canvas.ClipRect.Right,
      LLegY + LBuffer.Canvas.ClipRect.Bottom));
  FBackground.DrawBackground(LBuffer.Canvas, LBuffer.Canvas.ClipRect);
  LBuffer.Canvas.Brush.Style := bsClear;
  FEdge.SetupCanvasPen(LBuffer.Canvas.Pen);
  LBuffer.Canvas.Rectangle(0, 0, LLegWidth, LLegHeight);
  if not FHorizontalListing then
  begin
    //draw icons
    with LBuffer.Canvas do
    begin
      LIconLeftFld := FInnerIndentLeft;
      LTextLeftFld := LIconLeftFld + FSpaceAfterIcon + FIconSize;
      LPosY := FInnerIndentTop;
      for i := 0 to AVal.RowCount - 1 do
      begin
        if FIconSize >= TextHeight(AVal.GetRowsNames(i)) then
          LIconIsCenter := true
        else
          LIconIsCenter := false;
        AVal.GetRowsLines(i).SetupCanvasPen(Pen);
        if LIconIsCenter then
        begin
          if i > 0 then
            LPosY := LPosY + FSpaceBtwLines;
          AVal.GetRowFill(i).DrawRectangle(LBuffer.Canvas, AVal.GetRowsLines(i), LIconLeftFld, LPosY, LIconLeftFld + FIconSize, LPosY + FIconSize);
          Brush.Style := bsClear;
          TextOut(LTextLeftFld, LPosY + (FIconSize - TextHeight(AVal.GetRowsNames(i))) div 2, AVal.GetRowsNames(i));
          LPosY := LPosY + FIconSize;
        end
        else
        begin
          if i > 0 then
            LPosY := LPosY + FSpaceBtwLines;
          Brush.Style := bsClear;
          TextOut(LTextLeftFld, LPosY, AVal.GetRowsNames(i));
          AVal.GetRowFill(i).DrawRectangle(LBuffer.Canvas, AVal.GetRowsLines(i),
            LIconLeftFld, LPosY + ((TextHeight(AVal.GetRowsNames(i)) - FIconSize) div 2), //x1,y1
            LIconLeftFld + FIconSize, //x2
            LPosY + ((TextHeight(AVal.GetRowsNames(i)) - FIconSize) div 2) + FIconSize); //y2
          LPosY := LPosY + TextHeight(AVal.GetRowsNames(i));
        end;
      end;
    end;
  end
  else
  begin
    //draw icons
    with LBuffer.Canvas do
    begin
      LPosX := FInnerIndentLeft;
      for i := 0 to AVal.RowCount - 1 do
      begin
        if FIconSize >= TextHeight(AVal.GetRowsNames(i)) then
          LIconIsCenter := true
        else
          LIconIsCenter := false;
        if LIconIsCenter then
        begin
          if i > 0 then
            LPosX := LPosX + FSpaceBtwLines;
          AVal.GetRowFill(i).DrawRectangle(LBuffer.Canvas, AVal.GetRowsLines(i), LPosX, FInnerIndentTop, LPosX + FIconSize, FInnerIndentTop + FIconSize);
          LPosX := LPosX + FIconSize + FSpaceAfterIcon;
          Brush.Style := bsClear;
          TextOut(LPosX, FInnerIndentTop + (FIconSize - TextHeight(AVal.GetRowsNames(i))) div 2, AVal.GetRowsNames(i));
          LPosX := LPosX + TextWidth(AVal.GetRowsNames(i));
        end
        else
        begin
          if i > 0 then
            LPosX := LPosX + FSpaceBtwLines;
          LPosY := FInnerIndentTop + (TextHeight(AVal.GetRowsNames(i)) - FIconSize) div 2;
          AVal.GetRowFill(i).DrawRectangle(LBuffer.Canvas, AVal.GetRowsLines(i), LPosX, LPosY, LPosX + FIconSize, LPosY + FIconSize);
          LPosX := LPosX + FIconSize + FSpaceAfterIcon;
          Brush.Style := bsClear;
          TextOut(LPosX, FInnerIndentTop, AVal.GetRowsNames(i));
          LPosX := LPosX + TextWidth(AVal.GetRowsNames(i));
        end;
      end;
    end;
  end;
  ABorders := LTmpArea;

  ATarget.Draw(LLegX, LLegY, LBuffer);
  LBuffer.Free;
end;

function TLMDChartLegend.SpaceLeftAfter(AArea: TRect; AVal: TLMDChartData): TRect;
var
  LBuffer: TBitmap;
  LStringsLength, i, LElemsH, LLegHeight, LLegWidth, LLongestStr: integer;
begin
  result := AArea;
  if not FShow then
    exit;
  LBuffer := TBitmap.Create;
  //calculate legenda size
  LBuffer.Canvas.Font.Assign(FFont);
  if not FHorizontalListing then
  begin
    LElemsH := 0;
    LLongestStr := 0;
    for i := 0 to AVal.RowCount - 1 do
      LLongestStr := Max(LLongestStr, LBuffer.Canvas.TextWidth(AVal.GetRowsNames(i)));
    for i := 0 to AVal.RowCount - 1 do
      LElemsH := LElemsH + Max(FIconSize, LBuffer.Canvas.TextHeight(AVal.GetRowsNames(i)));
    LLegHeight := FInnerIndentTop + FInnerIndentBottom + LElemsH + (AVal.RowCount - 1) * FSpaceBtwLines;
    LLegWidth := FInnerIndentLeft + FInnerIndentRight + LLongestStr + FIconSize + FSpaceAfterIcon;
  end
  else
  begin
    LElemsH := 0;
    for i := 0 to AVal.RowCount - 1 do
      LElemsH := Max(LElemsH, Max(LBuffer.Canvas.TextHeight(AVal.GetRowsNames(i)), FIconSize));
    LStringsLength := 0;
    for i := 0 to AVal.RowCount - 1 do
      LStringsLength := LStringsLength + LBuffer.Canvas.TextWidth(AVal.GetRowsNames(i));
    LLegHeight := LElemsH + FInnerIndentTop + FInnerIndentBottom;
    LLegWidth := LStringsLength + (FIconSize + FSpaceAfterIcon) * AVal.RowCount + FInnerIndentLeft + FInnerIndentRight + (AVal.RowCount - 1) * FSpaceBtwLines;
  end;

  if FOverlap then
    result := AArea
  else
  begin
    //legend position
    case FAlignment of
      laAbsolute:
        begin

        end;
      laRight:
        begin
          result.Right := result.Right - LLegWidth - FMarginChart - FmarginEdge;
        end;
      laLeft:
        begin
          result.Left := result.Left + LLegWidth + FMarginChart + FmarginEdge;
        end;
      laTop:
        begin
          result.Top := result.Top + LLegHeight + FMarginChart + FmarginEdge;
        end;
      laBottom:
        begin
          result.Bottom := result.Bottom - LLegHeight - FMarginChart - FmarginEdge;
        end;
      laTopRight:
        begin
          result.Top := result.Top + LLegHeight + MarginEdge + FMarginChart;
          result.Right := result.Right - LLegWidth - MarginEdge - FMarginChart;
        end;
      laTopLeft:
        begin
          result.Top := result.Top + LLegHeight + MarginEdge + FMarginChart;
          result.Left := result.Left + LLegWidth + MarginEdge + FMarginChart;
        end;
      laBottomLeft:
        begin
          result.Bottom := result.Bottom - LLegHeight - MarginEdge - FMarginChart;
          result.Left := result.Left + LLegWidth + MarginEdge + FMarginChart;
        end;
      laBottomRight:
        begin
          result.Bottom := result.Bottom - LLegHeight - MarginEdge - FMarginChart;
          result.Right := result.Right - LLegWidth - MarginEdge - FMarginChart;
        end;
    end;
  end;

end;

end.
