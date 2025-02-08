unit pLMDChartCE;
{$I lmdcmps.inc}

{
###############################################################################
pLMDChartCE unit - Chart component editor
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
  DesignIntf, DesignEditors, VCLEditors,
  Classes, Sysutils, Dialogs, TypInfo, Graphics, Forms, Buttons, ExtCtrls, StdCtrls,
  Controls, Messages, Menus, ComCtrls, LMDChart, pLMDChartEditorDlg;

type
  TLMDChartComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer);  override;
    function GetVerb(Index: Integer): String;  override;
    function GetVerbCount: Integer;  override;
  end;

implementation

{ TLMDChartComponentEditor }
procedure TLMDChartComponentEditor.ExecuteVerb(Index: Integer);
var
  LChart: TLMDChart;
  LDesigner: IDesigner;
begin
  LDesigner := Designer;
  if Index = 0 then
    with TLMDChartEditor.Create(nil) do
    try
      LChart := (Component as TLMDChart);
      Edit(LChart);
      LDesigner.Modified;
      if Assigned(LChart.ChartType) then
      begin
        if LChart.ChartType.Name = '' then
          LChart.ChartType.Name := LDesigner.UniqueName(LChart.ChartType.ClassName);
      end;
    finally
      Free;
    end;
end;

function TLMDChartComponentEditor.GetVerb(Index: Integer): String;
begin
  if Index = 0 then
    Result := 'Edit Chart...';
end;

function TLMDChartComponentEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

end.
