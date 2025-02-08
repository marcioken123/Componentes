unit pLMDChartSeriesEditor;
{$I lmdcmps.inc}

interface

uses
  DesignIntf, DesignEditors, VCLEditors,
  Classes, Sysutils, Dialogs, TypInfo, Graphics, Forms, Buttons, ExtCtrls, StdCtrls,
  Controls, Messages, Menus, ComCtrls, LMDChart, LMDChartSeries, pLMDChartSeriesEditorDlg;

type
  TLMDChartSeriesEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer);  override;
    function GetVerb(Index: Integer): String;  override;
    function GetVerbCount: Integer;  override;
  end;

implementation

{ TLMDChartSeriesEditor }
procedure TLMDChartSeriesEditor.ExecuteVerb(Index: Integer);
var
  LChartSeries: TLMDCustomChartSeries;
  //LTemp: String;
  LDesigner: IDesigner;
begin
  LDesigner := Designer;
  if Index = 0 then
    with TLMDChartSeriesEditorDlg.Create(nil) do
    try
      LChartSeries := (Component as TLMDCustomChartSeries);
      Edit(LChartSeries);
    finally
      Free;
    end;
end;

function TLMDChartSeriesEditor.GetVerb(Index: Integer): String;
begin
  if Index = 0 then
    Result := 'Edit Chart Series...';
end;

function TLMDChartSeriesEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

end.
