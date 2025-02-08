unit LMDControlErrorProvider;
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

LMDControlErrorProvider unit (RS)
---------------------------------

Error provider for error indication using some control which suports the 
ILMDValidationMsgControl interface

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Dialogs,
  LMDVldBase;

type

  TLMDControlErrorProvider = class(TLMDCustomErrorProvider)
  protected
    FErrMsgControl: ILMDValidatingMsgControl;
    procedure SetErrMsgControl(const Value: ILMDValidatingMsgControl);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoDisplayError(control: ILMDValidatedControl; ErrorMsg: string; ErrorLevel: TLMDErrorLevel); override;
  published
    property ErrMsgControl: ILMDValidatingMsgControl read FErrMsgControl write SetErrMsgControl;
  end;

implementation

{****************** Object TLMDControlErrorProvider ***************************}
{------------------------- Protected ------------------------------------------}
procedure TLMDControlErrorProvider.SetErrMsgControl(const Value: ILMDValidatingMsgControl);
begin
  Self.ReferenceInterface(Self.FErrMsgControl, opRemove);
  FErrMsgControl := Value;
  Self.ReferenceInterface(Self.FErrMsgControl, opInsert);
end;

{------------------------------------------------------------------------------}
procedure TLMDControlErrorProvider.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if not (Operation = opRemove) then exit;
  if Assigned(Self.FErrMsgControl) and AComponent.IsImplementorOf(Self.FErrMsgControl) then
    Self.FErrMsgControl := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDControlErrorProvider.DoDisplayError(control: ILMDValidatedControl; ErrorMsg: string; ErrorLevel: TLMDErrorLevel);
begin
  if Assigned(Self.FErrMsgControl) then
    begin
      if (ErrorLevel > 0) then
        Self.FErrMsgControl.SetErrorMessage(ErrorMsg, ErrorLevel)
      else
        Self.FErrMsgControl.SetErrorMessage(ErrorMsg, 0);
    end;
end;

end.

