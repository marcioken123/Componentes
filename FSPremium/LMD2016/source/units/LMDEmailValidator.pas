unit LMDEmailValidator;
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

LMDEmailValidator unit (AH)
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
  TLMDEmailValidator = class(TLMDCustomRegExpValidator)
  public
    constructor Create(AComponent: TComponent); override;
  published
    property Expression;
  end;

implementation

{ TLMDEmailValidator }

constructor TLMDEmailValidator.Create(AComponent: TComponent);
begin
  inherited;
  Expression := '^[^@]*<[a-zA-Z0-9!#$%&\''*+\\/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&\''*+\\/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?>$';
end;

end.
