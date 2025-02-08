unit LMDExpressionEval;
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

LMDExpressionEval unit (AH)
---------------------------

Component wrapper for TLMDMathParser

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Variants,
  LMDCustomComponent, LMDUnicode, LMDMathParser, LMDTypes;

type

  TLMDExpressionEval = class(TLMDCustomComponent)
  private
    FMathParser: TLMDMathParser;
    function GetExpr: TLMDString;
    function GetArgumentDelimiters: TLMDString;
    function GetFunctionListGroups: TLMDFunctionListGroups;
    function GetOnParseError: TLMDMathErrorEvent;
    function GetResult: Variant;
    function GetVars: TStrings;
    procedure SetExpr(const Value: TLMDString);
    procedure SetArgumentDelimiters(const Value: TLMDString);
    procedure SetFunctionListGroups(const Value: TLMDFunctionListGroups);
    procedure SetOnParseError(const Value: TLMDMathErrorEvent);
    procedure SetVars(const Value: TStrings);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property FunctionListGroups: TLMDFunctionListGroups read GetFunctionListGroups write SetFunctionListGroups;
    property Result: Variant read GetResult;
  published
    property About;
    property Expression: TLMDString read GetExpr write SetExpr;
    property Variables: TStrings read GetVars write SetVars;
    property ArgumentDelimiters: TLMDString read GetArgumentDelimiters write SetArgumentDelimiters;
    property OnParseError: TLMDMathErrorEvent read GetOnParseError write SetOnParseError;
  end;

implementation

{****************** Object TLMDExpressionEval *********************************}
{------------------------- private --------------------------------------------}
function TLMDExpressionEval.GetExpr: TLMDString;
begin
  Result := '';
  if Assigned(FMathParser) then
    Result := FMathParser.Expression;
end;

{------------------------------------------------------------------------------}
function TLMDExpressionEval.GetArgumentDelimiters: TLMDString;
begin
  Result := '';
  if Assigned(FMathParser) then
    Result := FMathParser.ArgumentDelimiters;
end;

{------------------------------------------------------------------------------}
function TLMDExpressionEval.GetFunctionListGroups: TLMDFunctionListGroups;
begin
  Result := nil;
  if Assigned(FMathParser) then
    Result := FMathParser.FunctionListGroups;
end;

{------------------------------------------------------------------------------}
function TLMDExpressionEval.GetOnParseError: TLMDMathErrorEvent;
begin
  Result := nil;
  if Assigned(FMathParser) then
    Result := FMathParser.OnParseError;
end;

{------------------------------------------------------------------------------}
function TLMDExpressionEval.GetResult: Variant;
begin
  Result := Null;
  if Assigned(FMathParser) then
    Result := FMathParser.Result;
end;

{------------------------------------------------------------------------------}
function TLMDExpressionEval.GetVars: TStrings;
begin
  Result := nil;
  if Assigned(FMathParser) then
    Result := FMathParser.Variables;
end;

{------------------------------------------------------------------------------}
procedure TLMDExpressionEval.SetExpr(const Value: TLMDString);
begin
  if Assigned(FMathParser) then
    FMathParser.Expression := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDExpressionEval.SetArgumentDelimiters(const Value: TLMDString);
begin
  if Assigned(FMathParser) then
    FMathParser.ArgumentDelimiters := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDExpressionEval.SetFunctionListGroups(const Value: TLMDFunctionListGroups);
begin
  if Assigned(FMathParser) then
    FMathParser.FunctionListGroups := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDExpressionEval.SetOnParseError(const Value: TLMDMathErrorEvent);
begin
  if Assigned(FMathParser) then
    FMathParser.OnParseError := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDExpressionEval.SetVars(const Value: TStrings);
begin
  if Assigned(FMathParser) then
    FMathParser.Variables := Value;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDExpressionEval.Create(AOwner: TComponent);
begin
  inherited;
  FMathParser := TLMDMathParser.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDExpressionEval.Destroy;
begin
  FreeAndNil(FMathParser);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDExpressionEval.Assign(Source: TPersistent);
begin
  inherited;
end;

end.
