unit LMDRegExpValidator;
{$I LMDCmps.inc}

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

LMDRegExpValidator unit (RS)
----------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDVldBase, LMDRegExpr, LMDTypes;

type
  TLMDCustomRegExpValidator = class(TLMDCustomValidator)
  private
    function GetOptions: TLMDRegOptions;
  protected
    FRegEx: TLMDRegExpr;
    function PerformValidation(value: string): TLMDErrorLevel; override;
    function GetRegExp: TLMDRegExString;
    procedure SetRegExp(const Value: TLMDRegExString);
    function GetIgnoreCase: boolean;
    procedure SetIgnoreCase(const Value: boolean);

    property Expression : TLMDRegExString read GetRegExp write SetRegExp;
    property Options: TLMDRegOptions read GetOptions;
    property IgnoreCase : boolean read GetIgnoreCase write SetIgnoreCase;
  public
    constructor Create(AComponent: TComponent); override;
    destructor Destroy; override;
  end;

  TLMDRegExpValidator = class(TLMDCustomRegExpValidator)
  published
    property Expression;
    property Options;
    property IgnoreCase;
  end;

implementation

{ TLMDRegExpValidator }

constructor TLMDCustomRegExpValidator.Create(AComponent: TComponent);
begin
  inherited;
  Self.FRegEx := TLMDRegExpr.Create(Self);
end;

destructor TLMDCustomRegExpValidator.Destroy;
begin
  Self.FRegEx.Free;
  inherited;
end;

function TLMDCustomRegExpValidator.GetIgnoreCase: boolean;
begin
  Result := Self.FRegEx.Options.eroCaseLess;
end;

function TLMDCustomRegExpValidator.GetOptions: TLMDRegOptions;
begin
  Result := FRegEx.Options;
end;

function TLMDCustomRegExpValidator.GetRegExp: TLMDRegExString;
begin
  if Assigned(Self.FRegEx) then
    Result := Self.FRegEx.Expression
  else
    Result := '';
end;

function TLMDCustomRegExpValidator.PerformValidation(value: string): TLMDErrorLevel;
begin
  if Self.FRegEx.Exec(value) then
    Result := 0
  else
    Result := Self.ErrorLevel;
end;

procedure TLMDCustomRegExpValidator.SetIgnoreCase(const Value: boolean);
begin
  // ToDo
  //Self.FRegEx.Options.eroCaseLess := Value;
end;

procedure TLMDCustomRegExpValidator.SetRegExp(const Value: TLMDRegExString);
begin
  Self.FRegEx.Expression := Value;
end;

end.
