unit LMDChartPrintTask;
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

LMDChartPrintTask unit (RS)
-----------------------------------
Print task component for printing LMD Charts.

Changes
-------
* Not released yet

###############################################################################}

interface

uses Math, Classes, SysUtils, Windows, Printers, Graphics, Dialogs, Types,
     LMDTypes, LMDCustomComponent, LMDChart, LMDImagePrintTask, LMDDocElementRenderer;

type
  TLMDChartPrintTask = class(TLMDCustomImagePrintTask)
  private
    FChart: TLMDChart;
    procedure SetChart(const Value: TLMDChart);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure RenderTargetPicture; override;
    procedure SetExpectedPictureSize; override;
  public
    constructor Create (AOwner: TComponent); override;
    destructor Destroy; override;
    function getLMDPackage:TLMDPackageID;override;
  published
    property Chart: TLMDChart read FChart write SetChart;
  end;

implementation

{ TLMDChartPrintTask }

constructor TLMDChartPrintTask.Create(AOwner: TComponent);
begin
  inherited;
  Self.FPicture := TBitmap.Create;
end;

destructor TLMDChartPrintTask.Destroy;
begin
  if Assigned(Self.FPicture) then
    Self.FPicture.Free;
  if Assigned(Self.FChart) then
    Self.FChart.RemoveFreeNotification(Self);
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDChartPrintTask.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_CHART;
end;

procedure TLMDChartPrintTask.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then
    Exit;
  if AComponent = Self.FChart then
    Self.FChart := nil;
end;

procedure TLMDChartPrintTask.RenderTargetPicture;
begin
  if not Assigned(Self.Chart) then
    Exit;
  Self.FPicture.PixelFormat := Self.PixelFormat;
  Self.Chart.DrawTo(Self.FPicture.Canvas);
end;

procedure TLMDChartPrintTask.SetChart(const Value: TLMDChart);
begin
  if Assigned(Self.FChart) then
     Self.FChart.RemoveFreeNotification(Self);
  FChart := Value;
  if Assigned(Self.FChart) then
     Self.FChart.FreeNotification(Self);
end;

procedure TLMDChartPrintTask.SetExpectedPictureSize;
begin
  if Assigned(Self.FChart) then
  begin
    Self.FPicture.Width := Self.Chart.Width;
    Self.FPicture.Height := Self.Chart.Height;
  end;
end;

end.
