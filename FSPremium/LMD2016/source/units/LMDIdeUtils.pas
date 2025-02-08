unit LMDIdeUtils;
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

LMDIdeUtils unit (YB)
------------------------
IDE-Tools utilities unit.

Changes
-------

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, LMDTypes, LMDSvcPvdr, LMDDsgDesigner, LMDIdeCst;

{ Simple IDE dialogs }

function LMDCreationOrderDialog(ADesigner: TLMDDesigner): Boolean;
function LMDTabOrderDialog(ADesigner: TLMDDesigner): Boolean;

implementation

uses
  LMDIdeCreationOrderDlg, LMDIdeTabOrderDlg;

{------------------------------------------------------------------------------}

function LMDCreationOrderDialog(ADesigner: TLMDDesigner): Boolean;
var
  form: TLMDCreationOrderForm;
begin
  Assert((ADesigner <> nil) and ADesigner.Active,
         'Designer should be active.');
         
  form := TLMDCreationOrderForm.Create(ADesigner);
  try
    Result := (form.ShowModal = mrOk);
  finally
    form.Free;
  end;
end;
                 
{------------------------------------------------------------------------------}

function LMDTabOrderDialog(ADesigner: TLMDDesigner): Boolean;
var
  form: TLMDTabOrderForm;
begin
  Assert((ADesigner <> nil) and ADesigner.Active,
         'Designer should be active.');
         
  form := TLMDTabOrderForm.Create(ADesigner);
  try
    Result := (form.ShowModal = mrOk);
  finally
    form.Free;
  end;
end;
  
{------------------------------------------------------------------------------}

end.
