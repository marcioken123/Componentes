unit LMDHintErrorProvider;
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

LMDHintErrorProvider unit (RS)
------------------------------

Error provider for indication by a hint message

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Variants,
  Classes, Graphics, Controls, StdCtrls, ExtCtrls, Forms, Dialogs,
  LMDVldBase, LMDMessageHint;

type

  {****************** Object TLMDHintErrorProvider ****************************}
  TLMDHintErrorProvider = class(TLMDCustomErrorProvider)
  protected
    FMessageHint: TLMDMessageHint;
    procedure DoDisplayError(control: ILMDValidatedControl; ErrorMsg: string; ErrorLevel: TLMDErrorLevel); override;
    procedure SetMessageHint(aValue: TLMDMessageHint);
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property MessageHint: TLMDMessageHint read FMessageHint write SetMessageHint;
  end;

implementation

{****************** Object TLMDHintErrorProvider ******************************}
{------------------------- Protected ------------------------------------------}
procedure TLMDHintErrorProvider.DoDisplayError(control: ILMDValidatedControl; ErrorMsg: string; ErrorLevel: TLMDErrorLevel);
begin
  if ErrorLevel > 0 then
    FMessageHint.ShowControlMessage(ErrorMsg, control.Control)
  else
    FMessageHint.HideMessage;
end;

{------------------------------------------------------------------------------}
procedure TLMDHintErrorProvider.SetMessageHint(aValue: TLMDMessageHint);
begin
  if Assigned(AValue) and Assigned(FMessageHint) then
    FMessageHint.Assign(aValue);
end;

{------------------------- Public ---------------------------------------------}
procedure TLMDHintErrorProvider.Assign(Source: TPersistent);
begin
  inherited;
  if Assigned(Source) and (Source is TLMDHintErrorProvider) then
    begin
      MessageHint.Assign(TLMDHintErrorProvider(Source).MessageHint);
    end;
end;

{------------------------------------------------------------------------------}
constructor TLMDHintErrorProvider.Create(AOwner: TComponent);
begin
  inherited;
  FMessageHint := TLMDMessageHint.Create(Self);
  FMessageHint.SetSubComponent(true);
end;

{------------------------------------------------------------------------------}
destructor TLMDHintErrorProvider.Destroy;
begin
  if FMessageHint.IsDisplaying then
    FMessageHint.HideMessage;
  FreeAndNil(FMessageHint);
  inherited;
end;

end.

