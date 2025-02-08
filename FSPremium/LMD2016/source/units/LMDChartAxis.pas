unit LMDChartAxis;
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
LMDChartAxis unit
-----------------------------------
TLMDChartAxis, TLMDChartYAxis

Changes
-------
Last (06-June-2006)

###############################################################################}

interface

uses
  SysUtils, Classes, Controls, Graphics, Variants, Types, ExtCtrls,
  LMDXML, LMDXMLNodeNames, LMDChartData, LMDChartUtils, LMDChartPersistent,
  LMDChartLine, LMDChartFont, LMDChartScaleBreak;

type
  TLMDChartAxisValuesTypes = (avtDateTime, avtFloat);

  { *************************** TLMDChartAxis ******************************** }
  /// <summary>
  /// Represents chart axis
  /// </summary>
  TLMDChartAxis = class(TLMDChartPersistent)
  private
    FMajorTick: TLMDChartTickTypes;
    FMinorTick: TLMDChartTickTypes;
    FMajorTickSize: integer;
    FMinorTickSize: integer;
    FLine: TLMDChartLine;
    FFont: TLMDChartFont;
    FValuesType: TLMDChartAxisValuesTypes;
    procedure SetMajorTick(Value: TLMDChartTickTypes);
    procedure SetMajorTickSize(Value: integer);
    procedure SetMinorTick(Value: TLMDChartTickTypes);
    procedure SetMinorTickSize(Value: integer);
    procedure SetFont(Value: TLMDChartFont);
    procedure SetValuesType(Value: TLMDChartAxisValuesTypes);
  protected
  public
    procedure Assign(ASource: TPersistent); override;
    /// <summary>
    /// Saves inner object state to xml format
    /// </summary>
    procedure SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
    /// <summary>
    /// Loads inner object state from xml format
    /// </summary>
    procedure LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
  published
    property Font: TLMDChartFont read FFont write SetFont;
    //    property Line: TLMDChartLine read FLine write SetLine;
    property MajorTick: TLMDChartTickTypes read FMajorTick write SetMajorTick default ttOutside;
    property MinorTick: TLMDChartTickTypes read FMinorTick write SetMinorTick default ttOutside;
    property MajorTickSize: integer read FMajorTickSize write SetMajorTickSize default 2;
    property MinorTickSize: integer read FMinorTickSize write SetMinorTickSize default 2;
    property ValuesType: TLMDChartAxisValuesTypes read FValuesType write SetValuesType default avtFloat;
  end;

  { *************************** TLMDChartYAxis ******************************* }
  TLMDChartYAxis = class(TLMDChartAxis)
  private
    FMaxValue: variant;
    FMinValue: variant;
    FMajorStep: variant;
    FMinorStep: variant;
    FInverted: boolean;
    FInvertedChanged: boolean;
    FAutoScale: boolean;
    FSeries: TLMDChartData;
    FChartStacked: boolean;
    FScaleBreak: TLMDChartScaleBreak;
    procedure SetMaxValue(Value: variant);
    procedure SetMinValue(Value: variant);
    procedure SetMajorStep(Value: variant);
    procedure SetMinorStep(Value: variant);
    procedure SetAutoScale(Value: boolean);
    procedure SetChartStacked(Value: boolean);
    procedure SetScaleBreak(Value: TLMDChartScaleBreak);
    function GetMaxValue: variant;
    function GetMinValue: variant;
    function GetMajorStep: variant;
    function GetMinorStep: variant;
  protected
  public
    procedure Assign(ASource: TPersistent); override;
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    function CalcPosFromBottom(ASize: integer; AValue: real; var AErrorBack: integer): integer;
    procedure SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
    procedure LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
    procedure ChangeInverted();
    procedure SetData(AValue: TLMDChartData);
    function IsChanged: boolean; override;
    procedure NoChanged; override;
    property InvertedChanged: boolean read FInvertedChanged default false;
    property ChartStacked: boolean read FChartStacked write SetChartStacked default false;
  published
    property MaxValue: variant read GetMaxValue write SetMaxValue;
    property MinValue: variant read GetMinValue write SetMinValue;
    property MajorStep: variant read GetMajorStep write SetMajorStep;
    property MinorStep: variant read GetMinorStep write SetMinorStep;
    //property Inverted: boolean read FInverted write SetInverted default false;
    property AutoScale: boolean read FAutoScale write SetAutoScale default false;
    property ScaleBreak: TLMDChartScaleBreak read FScaleBreak write SetScaleBreak;
  end;

implementation

{ ***************************** TLMDChartAxis ******************************** }
{ -------------------------------- private ----------------------------------- }
{ ---------------------------------------------------------------------------- }

procedure TLMDChartAxis.SetMajorTick(Value: TLMDChartTickTypes);
begin
  if Value <> FMajorTick then
  begin
    FMajorTick := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartAxis.SetMajorTickSize(Value: integer);
begin
  if Value <> FMajorTickSize then
  begin
    FMajorTickSize := value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartAxis.SetMinorTick(Value: TLMDChartTickTypes);
begin
  if Value <> FMinorTick then
  begin
    FMinorTick := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartAxis.SetMinorTickSize(Value: integer);
begin
  if Value <> FMinorTickSize then
  begin
    FMinorTickSize := Value;
    FChanged := true;
    HighestOwnerRepaint
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartAxis.SetFont(Value: TLMDChartFont);
begin
  if Value <> FFont then
  begin
    FFont.Assign(Value);
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ -------------------------------- public ------------------------------------ }

procedure TLMDChartAxis.SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  WorkNode := BaseNode.EnsureChild(NNChartAxis + Comment);

  FLine.SaveStateToXML(WorkNode, '');
  FFont.SaveStateToXML(WorkNode, '');

  IterNode := WorkNode.AppendElement('MajorTick');
  IterNode.SetVarAttr('value', Variant(FMajorTick));

  IterNode := WorkNode.AppendElement('MinorTick');
  IterNode.SetVarAttr('value', Variant(FMinorTick));

  IterNode := WorkNode.AppendElement('MajorTickSize');
  IterNode.SetVarAttr('value', FMajorTickSize);

  IterNode := WorkNode.AppendElement('MinorTickSize');
  IterNode.SetVarAttr('value', FMinorTickSize);

  IterNode := WorkNode.AppendElement('ValuesType');
  IterNode.SetVarAttr('value', Variant(FValuesType));
end;
{ ---------------------------------------------------------------------------- }

procedure TLMDChartAxis.LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  WorkNode := BaseNode.NeedChild(NNChartAxis + Comment);

  FLine.LoadStateFromXML(WorkNode, '');
  FFont.LoadStateFromXML(WorkNode, '');

  IterNode := WorkNode.NeedChild('MajorTick');
  FMajorTick := TLMDChartTickTypes(IterNode.GetVarAttr('value', 0));

  IterNode := WorkNode.NeedChild('MinorTick');
  FMinorTick := TLMDChartTickTypes(IterNode.GetVarAttr('value', 0));

  IterNode := WorkNode.NeedChild('MajorTickSize');
  FMajorTickSize := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('MinorTickSize');
  FMinorTickSize := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('ValuesType');
  FValuesType := TLMDChartAxisValuesTypes(IterNode.GetVarAttr('value', 0));
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartAxis.Assign(ASource: TPersistent);
begin
  if ASource is TLMDChartAxis then
  begin
    try
      FMajorTickSize := TLMDChartAxis(ASource).FMajorTickSize;
      FMinorTickSize := TLMDChartAxis(ASource).FMinorTickSize;
      FMajorTick := TLMDChartAxis(ASource).FMajorTick;
      FMinorTick := TLMDChartAxis(ASource).FMinorTick;
      FLine.Assign(TLMDChartAxis(ASource).FLine);
      FFont.Assign(TLMDChartAxis(ASource).FFont);
    finally
    end;
  end;
  inherited Assign(ASource);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDChartAxis.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FLine := TLMDChartLine.Create(AOwner);
  FFont := TLMDChartFont.Create(AOwner);
  //default values
  FMajorTickSize := 2;
  FMinorTickSize := 2;
  FMajorTick := ttOutside;
  FMinorTick := ttOutside;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDChartAxis.Destroy;
begin
  FLine.Free;
  FFont.Free;
  inherited;
end;

{ **************************** TLMDChartYAxis ******************************** }

{ ---------------------------------------------------------------------------- }

procedure TLMDChartYAxis.SetScaleBreak(Value: TLMDChartScaleBreak);
begin
  if Value <> FScaleBreak then
  begin
    FScaleBreak := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ -------------------------------- private ----------------------------------- }

procedure TLMDChartYAxis.SetMaxValue(Value: variant);
begin
  if (Value <> FMaxValue) and (Value > FMinValue) then
  begin
    FMaxValue := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ -------------------------------- private ----------------------------------- }

procedure TLMDChartYAxis.SetChartStacked(Value: boolean);
begin
  if Value <> FChartStacked then
  begin
    FChanged := true;
    FChartStacked := Value;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartYAxis.SetMinValue(Value: variant);
begin
  if (Value <> FMinValue) and (Value < FMaxValue) then
  begin
    FMinValue := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartYAxis.SetAutoScale(Value: boolean);
begin
  if FAutoScale <> Value then
  begin
    FAutoScale := Value;
    if (FAutoScale) then
    begin
      FMaxValue := SmartRoundUp(FSeries.HighestValue, 10);
      FMinValue := -FMaxValue;
      FMajorStep := FMaxValue div 10;
    end;
    if not ScaleBreak.Enabled then
      FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartYAxis.SetMajorStep(Value: variant);
begin
  if (Value <> FMajorStep) then
  begin
    FMajorStep := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartYAxis.SetMinorStep(Value: variant);
begin
  if (Value <> FMinorStep) then
  begin
    FMinorStep := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartAxis.SetValuesType(Value: TLMDChartAxisValuesTypes);
begin
  if Value <> FValuesType then
  begin
    FValuesType := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ -------------------------------- public ------------------------------------ }

procedure TLMDChartYAxis.ChangeInverted();
begin
  FInvertedChanged := not FInvertedChanged;
  FChanged := true;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartYAxis.SetData(AValue: TLMDChartData);
begin
  FSeries := AValue;
end;

{ ---------------------------------------------------------------------------- }

function TLMDChartYAxis.IsChanged: boolean;
begin
  if FScaleBreak.IsChanged then
    FChanged := true;
  IsChanged := FChanged;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartYAxis.NoChanged;
begin
  FChanged := false;
  FScaleBreak.NoChanged;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartYAxis.SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  WorkNode := BaseNode.EnsureChild(NNChartAxis + Comment);

  FLine.SaveStateToXML(WorkNode, '');
  FFont.SaveStateToXML(WorkNode, '');

  IterNode := WorkNode.AppendElement('MajorTick');
  IterNode.SetVarAttr('value', Variant(FMajorTick));

  IterNode := WorkNode.AppendElement('MinorTick');
  IterNode.SetVarAttr('value', Variant(FMinorTick));

  IterNode := WorkNode.AppendElement('MajorTickSize');
  IterNode.SetVarAttr('value', FMajorTickSize);

  IterNode := WorkNode.AppendElement('MinorTickSize');
  IterNode.SetVarAttr('value', FMinorTickSize);

  IterNode := WorkNode.AppendElement('ValuesType');
  IterNode.SetVarAttr('value', Variant(FValuesType));

  IterNode := WorkNode.AppendElement('MaxValue');
  IterNode.SetVarAttr('value', FMaxValue);

  IterNode := WorkNode.AppendElement('MinValue');
  IterNode.SetVarAttr('value', FMinValue);

  IterNode := WorkNode.AppendElement('MajorStep');
  IterNode.SetVarAttr('value', FMajorStep);

  IterNode := WorkNode.AppendElement('MinorStep');
  IterNode.SetVarAttr('value', FMinorStep);

end;
{ ---------------------------------------------------------------------------- }

procedure TLMDChartYAxis.LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  WorkNode := BaseNode.NeedChild(NNChartAxis + Comment);

  FLine.LoadStateFromXML(WorkNode, '');
  FFont.LoadStateFromXML(WorkNode, '');

  IterNode := WorkNode.NeedChild('MajorTick');
  FMajorTick := TLMDChartTickTypes(IterNode.GetVarAttr('value', 0));

  IterNode := WorkNode.NeedChild('MinorTick');
  FMinorTick := TLMDChartTickTypes(IterNode.GetVarAttr('value', 0));

  IterNode := WorkNode.NeedChild('MajorTickSize');
  FMajorTickSize := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('MinorTickSize');
  FMinorTickSize := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('ValuesType');
  FValuesType := TLMDChartAxisValuesTypes(IterNode.GetVarAttr('value', 0));

  IterNode := WorkNode.NeedChild('MaxValue');
  FMaxValue := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('MinValue');
  FMinValue := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('MajorStep');
  FMajorStep := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('MinorStep');
  FMinorStep := IterNode.GetVarAttr('value', 0);

end;
{ ---------------------------------------------------------------------------- }

procedure TLMDChartYAxis.Assign(ASource: TPersistent);
begin
  if ASource is TLMDChartYAxis then
  begin
    try
      FMaxValue := TLMDChartYAxis(ASource).FMaxValue;
      FMinvalue := TLMDChartYAxis(ASource).FMinValue;
      FMajorStep := TLMDChartYAxis(ASource).FMajorStep;
      FMinorStep := TLMDChartYAxis(ASource).FMinorStep;
      FValuesType := TLMDChartYAxis(ASource).FValuesType;
      FAutoScale := TLMDChartYAxis(ASource).FAutoScale;
    finally
    end;
  end;
  inherited Assign(ASource);
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDChartYAxis.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  //default  values
  FChanged := true;
  FScaleBreak := TLMDChartScaleBreak.Create(AOwner);
  FInverted := false;
  AutoScale := false;
  FMaxValue := 100;
  FMinvalue := -100;
  FMajorStep := 10;
  FMinorStep := 5;
  FValuesType := avtFloat;
  MajorTick := ttOutside;
  MinorTick := ttOutside;
  MajorTickSize := 2;
  MinorTickSize := 2;
  ChartStacked := false;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDChartYAxis.Destroy;
begin
  FScaleBreak.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

function TLMDChartYAxis.CalcPosFromBottom(ASize: integer; AValue: real;
  var AErrorBack: integer): integer;
var
  a: real;
begin
    a := MaxValue - MinValue;
    if a <= 0 then
      a := 1;
    a := (AValue - MinValue) / a;
    result := round(ASize * a);
end;

function TLMDChartYAxis.GetMaxValue: variant;
begin
  Result := Self.FMaxValue;
  if {(VarType(Result) = 17) or} (Self.AutoScale and Assigned(Self.FSeries)) then
      Result := Self.FSeries.HighestValue;
end;

function TLMDChartYAxis.GetMinValue: variant;
begin
  Result := 0;
  if Self.AutoScale and Assigned(Self.FSeries) then
    Result := Self.FSeries.LowestValue;
end;

function TLMDChartYAxis.GetMajorStep: variant;
begin
  Result := Self.FMajorStep;
  if Result = 0 then
    Result := 1;
  //if (VarType(Result) = 17) then
    //Result := 2;
end;

function TLMDChartYAxis.GetMinorStep: variant;
begin
  Result := Self.FMinorStep;
  //if (VarType(Result) = 17) then
    //Result := 1;
end;

end.
