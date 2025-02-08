unit LMDUrlValidator;
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

LMDUrlValidator unit (AH)
----------------------------

Changes
-------
Release 2012.0 (October 2011)
 - Initial Release

###############################################################################}

interface
uses
  Classes, LMDRegExpValidator;

type
  TLMDUrlValidator = class(TLMDCustomRegExpValidator)
  private
    FSchemas: TStringList;
    procedure SetSchemas(const Value: TStringList);
  protected
    procedure BuildExpression;
    procedure Loaded; override;
  public
    constructor Create(AComponent: TComponent); override;
    destructor Destroy; override;
  published
    property Schemas: TStringList read FSchemas write SetSchemas;
    property Expression;
  end;

implementation

{ TLMDUrlValidator }

procedure TLMDUrlValidator.BuildExpression;
var
  i: Integer;
  LSchemas: String;
begin
  for i := 0 to FSchemas.Count - 1 do
    LSchemas := LSchemas + '|';
  Delete(LSchemas, Length(LSchemas) - 1, 1);
  if (LSchemas = '') then
    LSchemas := 'http|https';
  Expression := '(?:' + LSchemas + ')://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?';
end;

constructor TLMDUrlValidator.Create(AComponent: TComponent);
begin
  inherited;
  FSchemas := TStringList.Create;
  FSchemas.Text := 'http#13#10https';
  BuildExpression;
end;

destructor TLMDUrlValidator.Destroy;
begin
  FSchemas.Free;
  inherited;
end;

procedure TLMDUrlValidator.Loaded;
begin
  inherited;
  BuildExpression;
end;

procedure TLMDUrlValidator.SetSchemas(const Value: TStringList);
begin
  FSchemas.Assign(Value);
  BuildExpression;
end;

end.
