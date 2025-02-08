unit LMDChartCTLine;
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
LMDChartRectangular2DCT unit
-----------------------
A line chart displays series as a set of points connected by a line. Values
are represented by the height of the point as measured by the y-axis. Category labels are
displayed on the x-axis. Line charts are commonly used to compare values
over time.

The chart type is created on the basis of the newly introduced LMDChartRectangular2DCT
base class which defines the typical 2D rectangular coords chart interface and should
be used for all the chart types of this kind 

Changes
-------
Created 18 November 2007 (RS)

###############################################################################}

interface

uses
  Windows, Variants, SysUtils, Types, Math, Graphics, Classes,
  LMDXML, LMDXMLNodeNames, LMDChartData, LMDChartTypes, LMDChartPersistent,
  LMDChartUtils, LMDChartAxis, LMDChartMarker, LMDChartLine, LMDChartLabel,
  LMDChartRectangular2DCT;

type
  TLMDChartCTLine = class(TLMDChartRectangular2DCT)
  protected
    procedure DrawChartElements(ATarget: TCanvas;
      AValues: TLMDChartData; ASeriesIndex: integer; AElementsPoints: TLMDChartPoints;
        AStartX, AEndX, AStartY, AEndY: integer); override;        
  end;

implementation

{ TLMDChartCTLine }

procedure TLMDChartCTLine.DrawChartElements(ATarget: TCanvas;
  AValues: TLMDChartData; ASeriesIndex: integer;
  AElementsPoints: TLMDChartPoints; AStartX, AEndX, AStartY,
  AEndY: integer);
var
  LLine: TLMDChartLine;
begin
  LLine := AValues.GetRowsLines(ASeriesIndex);
  LLine.SetupCanvasPen(ATarget.Pen);
  ATarget.Polyline(AElementsPoints);
end;

end.
