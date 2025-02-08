unit LMDChartTypes;
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
LMDChartTypes unit
-----------------------------------
This unit contain TLMDChartCTAbstract class.
TLMDChartCTAbstract - parent for all diagrams of all
types (for all TLMDChartCTxxx classes) .
CT in class name mean - ChartTypes.

Changes (09-June-2006)
-------
* added  "RemoveFromChartArea" procedure and "FChartArea" field

Changes (15-June-2007)
-------
* added reference to the LMDChartSeries object into the ChartCTAbstract
(represents the chart series being represented by this CT; MVC pattern)


###############################################################################}

interface

uses
  Windows, SysUtils, Math, Graphics, Classes, Types,
  LMDCustomComponent, intfLMDBase, LMDTypes, LMDXML, LMDXMLNodeNames,
  LMDChartData, LMDChartPersistent, LMDChartSeries;

type
  { ********************** TLMDChartCTAbstract ******************************* }
  /// <summary>
  /// Represents base chart class for inheritance
  /// </summary>
  TLMDChartCTAbstract = class(TLMDCustomComponent, ILMDComponent)
  private
    FSeries: TLMDChartSeries;
    procedure SetSeries(const Value: TLMDChartSeries);
  protected
    FChanged: boolean;

    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  public
    FMainOwner: TPersistent;
    {FMainOwner - pointer to owner, in
      complex with HighestOwnerRepaint method
      used to redraw  TLMDChart when somthing is change }
    FChartArea: TLMDChartPersistent;
    function getLMDPackage: TLMDPackageID; override;
    procedure HighestOwnerRepaint;
    procedure ResetMainOwner(AmainOwner: TPersistent); virtual;
    function IsChanged: boolean; virtual;
    procedure NoChanged; virtual;
    constructor Create(AOwner: TComponent); override;
    /// <summary>
    /// Draws object on canvas
    /// </summary>
    procedure Draw(ABuffer: TBitmap; AArea: TRect; AValues: TLMDChartData; 
      AChartArea: TLMDChartPersistent); virtual;
    /// <summary>
    /// Removes from chart area
    /// </summary>
    procedure RemoveFromChartArea;
    /// <summary>
    /// Saves inner object state to xml format
    /// </summary>
    procedure SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string); virtual;
    /// <summary>
    /// Loads inner object state from xml format
    /// </summary>
    procedure LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string); virtual;
    destructor Destroy; override;
  published
    property Series: TLMDChartSeries read FSeries write SetSeries;

    property About;
  end;

implementation

uses
  LMDChartArea,
  LMDChart;

{ ********************** TLMDChartCTAbstract ********************************* }
{ ---------------------- public ---------------------------------------------- }
function TLMDChartCTAbstract.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_Chart;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDChartCTAbstract.HighestOwnerRepaint;
begin
  if FMainOwner = nil then
    exit;
  if (FMainOwner is TLMDCustomChart) then
    TLMDCustomChart(FMainOwner).Invalidate;
end;

{ ---------------------------------------------------------------------------- }
function TLMDChartCTAbstract.IsChanged: boolean;
begin
  IsChanged := FChanged;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAbstract.ResetMainOwner(AMainOwner: TPersistent);
begin
  FMainOwner := AMainOwner;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAbstract.NoChanged;
begin
  FChanged := false;
end;
procedure TLMDChartCTAbstract.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if not (Operation = opRemove) then
    Exit;
  if AComponent = Self.FSeries then
    Self.FSeries := nil;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAbstract.SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDChartCTAbstract.SetSeries(const Value: TLMDChartSeries);
begin
  if Assigned(Self.FSeries) then
    Self.FSeries.RemoveFreeNotification(Self);
  FSeries := Value;
  if Assigned(Self.FSeries) then
    Self.FSeries.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAbstract.LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
begin
end;
{ ---------------------------------------------------------------------------- }

constructor TLMDChartCTAbstract.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMainOwner := nil;
  FChartArea := nil;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAbstract.Draw(ABuffer: TBitmap; AArea: TRect; AValues: TLMDChartData; 
  AChartArea: TLMDChartPersistent);
begin
  if FMainOwner = nil then
    exit;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAbstract.RemoveFromChartArea;
begin
  if FChartArea <> nil then
    if FChartArea is TLMDChartArea then
      TLMDChartArea(FChartArea).ChartType := nil;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDChartCTAbstract.Destroy;
begin
  RemoveFromChartArea;
  inherited;
end;

end.
