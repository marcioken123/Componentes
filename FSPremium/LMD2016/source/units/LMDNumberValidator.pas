unit LMDNumberValidator;
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

LMDNumberValidator unit (AH)
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
  TLMDNumberValidator = class(TLMDCustomRegExpValidator)
  private
    FIntegerPattern: String;
    FNumberPattern: String;
    FIntegerOnly: Boolean;
    procedure SetIntegerOnly(const Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    property IntegerOnly: Boolean read FIntegerOnly write SetIntegerOnly;
  end;

implementation

{ TLMDNumberValidator }

constructor TLMDNumberValidator.Create(AOwner: TComponent);
begin
  inherited;
  FNumberPattern := '^\s*[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?\s*$';
  FIntegerPattern := '^\s*[+-]?\d+\s*$';
end;


procedure TLMDNumberValidator.SetIntegerOnly(const Value: Boolean);
begin
  if (FIntegerOnly <> Value) then
  begin
    FIntegerOnly := Value;
    if (FIntegerOnly) then
      Expression := FIntegerPattern
    else
      Expression := FNumberPattern;
  end;
end;

end.
