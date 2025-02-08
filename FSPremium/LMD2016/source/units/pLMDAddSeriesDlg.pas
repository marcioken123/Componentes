unit pLMDAddSeriesDlg;
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
LMDChartMarker
-----------------------------------

Changes
-------
Created (July-2007)

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  LMDUtils,
  LMDChart,
  LMDChartSeries,
  LMDChartSeriesCollection;

type
  { *********************** TLMDAddSeriesDlg ********************************* }
  /// <summary>
  /// Add Series dialog used by the Chart and Series component editors
  /// </summary>
  TLMDAddSeriesDlg = class(TForm)
    btCancel: TButton;
    btOK: TButton;
    Label1: TLabel;
    ComboBox1: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
    function AddSeries(AChart: TLMDChart): boolean;
  end;

var
  LMDAddSeriesDlg: TLMDAddSeriesDlg;

implementation

{$R *.DFM}

{ ************************* TLMDAddSeriesDlg ********************************* }

function TLMDAddSeriesDlg.AddSeries(AChart: TLMDChart): boolean;
var
  LForm: TForm;
  found: boolean;
  i, j: integer;
  LSeriesList: TList;
  LSeriesItem: TLMDChartSeriesCollectionItem;
begin
  Result := false;
  if not Assigned(AChart) then
    Exit;

  LSeriesList := TList.Create;
  Self.ComboBox1.Items.Clear;
  LForm := LMDGetOwnerForm(AChart);
  if not Assigned(LForm) then
    Exit;

  for i := 0 to LForm.ComponentCount - 1 do
  begin
    if LForm.Components[i] is TLMDCustomChartSeries then
    begin
      found := false;
      j := 0;
      while (j < AChart.SeriesObjects.Count) and (not found) do
      begin
        found := AChart.SeriesObjects.Items[j].Series = LForm.Components[i];
        Inc(j);
      end;
      if not found then
      begin
        Self.ComboBox1.Items.Add(LForm.Components[i].Name);
        LSeriesList.Add(LForm.Components[i]);
      end;
    end;
  end;

  if LSeriesList.Count = 0 then
  begin
    ShowMessage('No series to add (all the series components on the form are already added to the chart)');
    Exit;
  end;

  if (Self.ShowModal = mrOK) and (Self.ComboBox1.ItemIndex >= 0) then
  begin
    LSeriesItem := AChart.SeriesObjects.Add;
    LSeriesItem.Series := TLMDCustomChartSeries(LSeriesList.Items[Self.ComboBox1.ItemIndex]);
    Result := true;
  end;

  LSeriesList.Free;
end;

end.
