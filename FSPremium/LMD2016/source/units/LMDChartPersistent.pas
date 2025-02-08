unit LMDChartPersistent;
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
LMDChartPersistent
-----------------------------------

Changes
-------
Last (08-June-2006)

###############################################################################}

interface

uses
  Classes, LMDObject;

type
  { ********************** TLMDChartPersistent ******************************* }
  /// <summary>
  /// Represents chart persistent
  /// </summary>
  TLMDChartPersistent = class(TLMDObject)
  private
  protected
    FChanged: boolean;
    FMainOwner: TPersistent;
    procedure HighestOwnerRepaint; virtual;
  public
    constructor Create(AMainOwner: TPersistent); override;
    procedure ResetOwner(AMainOwner: TPersistent);
    function IsChanged: boolean; virtual;
    procedure NoChanged; virtual;
  end;

  TLMDChartSeriesCollectionAttribute = class(TLMDChartPersistent)
  protected
    procedure HighestOwnerRepaint; override;
  end;

implementation

uses
  LMDChartCTAreaLine3D,
  LMDChart,
  LMDChartSeriesCollection,
  LMDChartTypes;

{ ************************ TLMDChartPersistent ******************************* }
{ ------------------------- private ------------------------------------------ }

procedure TLMDChartPersistent.HighestOwnerRepaint;
begin
  if FMainOwner = nil then
    exit;
  if (FMainOwner is TLMDCustomChart) then
    TLMDCustomChart(FMainOwner).Invalidate;
  if FMainOwner is TLMDChartCTAbstract then
    TLMDChartCTAbstract(FMainOwner).HighestOwnerRepaint;
  if FMainOwner is TLMDChartCTAreaLine3D then
    TLMDChartCTAreaLine3D(FMainOwner).HighestOwnerRepaint;

end;

{ ------------------------- public ------------------------------------------- }

constructor TLMDChartPersistent.Create(AMainOwner: TPersistent);
begin
  inherited Create;
  FMainOwner := AMainOwner;
end;

{ ------------------------- public ------------------------------------------- }

procedure TLMDChartPersistent.ResetOwner(AMainOwner: TPersistent);
begin
  FMainOwner := AMainOwner;
end;

{ ---------------------------------------------------------------------------- }

function TLMDChartPersistent.IsChanged: boolean;
begin
  IsChanged := FChanged;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartPersistent.NoChanged;
begin
  FChanged := false;
end;

{ TLMDChartSeriesCollectionAttribute }

procedure TLMDChartSeriesCollectionAttribute.HighestOwnerRepaint;
begin
  inherited;
  if Self.FMainOwner is TLMDChartSeriesCollectionItem then
      (Self.FMainOwner as TLMDChartSeriesCollectionItem).RefreshParentChart;
end;

end.
