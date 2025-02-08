unit ElExpressionEval;
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

ElExpressionEval unit
---------------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  SysUtils,
  Classes,

  Variants,

  LMDTypes,
  LMDUnicodeStrings,
  ElComponent,
  ElMathParser;

type
  TElExpressionEval = class(TElComponent)
  private
    FMathParser: TElMathParser;
    function GetExpr: TLMDString;
    function GetArgumentDelimiters: TLMDString;
    function GetFunctionListGroups: TElFunctionListGroups;
    function GetOnParseError: TElMathParserErrorEvent;
    function GetResult: Variant;
    function GetVars: TLMDStrings;
    procedure SetExpr(const Value: TLMDString);
    procedure SetArgumentDelimiters(const Value: TLMDString);
    procedure SetFunctionListGroups(const Value: TElFunctionListGroups);
    procedure SetOnParseError(const Value: TElMathParserErrorEvent);
    procedure SetVars(const Value: TLMDStrings);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

    property FunctionListGroups: TElFunctionListGroups read GetFunctionListGroups write SetFunctionListGroups;

    property Result: Variant read GetResult;
  published
    property Expression: TLMDString read GetExpr write SetExpr;
    property Variables: TLMDStrings read GetVars write SetVars;
    property ArgumentDelimiters: TLMDString read GetArgumentDelimiters write SetArgumentDelimiters;
    property OnParseError: TElMathParserErrorEvent read GetOnParseError write SetOnParseError;
  end;

implementation

{ TElExpressionEval }

procedure TElExpressionEval.Assign(Source: TPersistent);
begin
  inherited;
end;

constructor TElExpressionEval.Create(AOwner: TComponent);
begin
  inherited;
  FMathParser := TElMathParser.Create;
end;

destructor TElExpressionEval.Destroy;
begin
  FreeAndNil(FMathParser);
  inherited;
end;

function TElExpressionEval.GetExpr: TLMDString;
begin
  Result := '';
  if Assigned(FMathParser) then
    Result := FMathParser.Expression;
end;

function TElExpressionEval.GetArgumentDelimiters: TLMDString;
begin
  Result := '';
  if Assigned(FMathParser) then
    Result := FMathParser.ArgumentDelimiters;
end;

function TElExpressionEval.GetFunctionListGroups: TElFunctionListGroups;
begin
  Result := nil;
  if Assigned(FMathParser) then
    Result := FMathParser.FunctionListGroups;
end;

function TElExpressionEval.GetOnParseError: TElMathParserErrorEvent;
begin
  Result := nil;
  if Assigned(FMathParser) then
    Result := FMathParser.OnParseError;
end;

function TElExpressionEval.GetResult: Variant;
begin
  Result := Null;
  if Assigned(FMathParser) then
    Result := FMathParser.Result;
end;

function TElExpressionEval.GetVars: TLMDStrings;
begin
  Result := nil;
  if Assigned(FMathParser) then
    Result := FMathParser.Variables;
end;

procedure TElExpressionEval.SetExpr(const Value: TLMDString);
begin
  if Assigned(FMathParser) then
    FMathParser.Expression := Value;
end;

procedure TElExpressionEval.SetArgumentDelimiters(const Value: TLMDString);
begin
  if Assigned(FMathParser) then
    FMathParser.ArgumentDelimiters := Value;
end;

procedure TElExpressionEval.SetFunctionListGroups(const Value: TElFunctionListGroups);
begin
  if Assigned(FMathParser) then
    FMathParser.FunctionListGroups := Value;
end;

procedure TElExpressionEval.SetOnParseError(const Value: TElMathParserErrorEvent);
begin
  if Assigned(FMathParser) then
    FMathParser.OnParseError := Value;
end;

procedure TElExpressionEval.SetVars(const Value: TLMDStrings);
begin
  if Assigned(FMathParser) then
    FMathParser.Variables := Value;
end;

end.
