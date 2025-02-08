unit LMDErrorProvider;
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

LMDErrorProvider unit (RS)
--------------------------

Error provider class which supports several 'standard' ways of error indication

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,  Messages, SysUtils, Variants, Classes, Graphics, Controls, StdCtrls,
  ExtCtrls, Forms, Dialogs,
  LMDVldBase, LMDInPlaceErrorProvider, LMDIconErrorProvider, LMDMessageBoxErrorProvider,
  LMDControlErrorProvider;

type

  TLMDErrorProvider = class(TLMDCustomErrorProvider)
  protected
    FLMDInPlaceErrorProvider: TLMDInPlaceErrorProvider;
    FLMDIconErrorProvider: TLMDIconErrorProvider;
    FLMDMessageBoxErrorProvider: TLMDMessageBoxErrorProvider;
    FLMDControlErrorProvider: TLMDControlErrorProvider;

    FUseMessageBox: Boolean;
    FUseInPlaceIndication: Boolean;
    FUseIcon: Boolean;
    FUseErrMsgControl: Boolean;

    procedure DoDisplayError(control: ILMDValidatedControl; ErrorMsg: string;
      ErrorLevel: TLMDErrorLevel); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property InPlaceErrorProvider: TLMDInPlaceErrorProvider read
      FLMDInPlaceErrorProvider;
    property IconErrorProvider: TLMDIconErrorProvider read
      FLMDIconErrorProvider;
    property MessageBoxErrorProvider: TLMDMessageBoxErrorProvider read
      FLMDMessageBoxErrorProvider;
    property ControlErrorProvider: TLMDControlErrorProvider read
      FLMDControlErrorProvider;

    property UseMessageBox: Boolean read FUseMessageBox write FUseMessageBox;
    property UseErrMsgControl: Boolean read FUseErrMsgControl write
      FUseErrMsgControl;
    property UseIcon: Boolean read FUseIcon write FUseIcon;
    property UseInPlaceIndication: Boolean read FUseInPlaceIndication write
      FUseInPlaceIndication;
  end;

implementation

{****************** Object TLMDErrorProvider **********************************}
{------------------------- Protected ------------------------------------------}
procedure TLMDErrorProvider.DoDisplayError(control: ILMDValidatedControl;
  ErrorMsg: string; ErrorLevel: TLMDErrorLevel);
begin
  if Self.UseErrMsgControl then
    Self.ControlErrorProvider.DisplayError(control, ErrorMsg, ErrorLevel);
  if Self.UseInPlaceIndication then
    Self.InPlaceErrorProvider.DisplayError(control, ErrorMsg, ErrorLevel);
  if Self.UseIcon then
    Self.IconErrorProvider.DisplayError(control, ErrorMsg, ErrorLevel);
  if Self.UseMessageBox then
    Self.MessageBoxErrorProvider.DisplayError(control, ErrorMsg, ErrorLevel);
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDErrorProvider.Create(AOwner: TComponent);
begin
  inherited;

  Self.FLMDInPlaceErrorProvider := TLMDInPlaceErrorProvider.Create(Self);
  Self.FLMDIconErrorProvider := TLMDIconErrorProvider.Create(Self);
  Self.FLMDMessageBoxErrorProvider := TLMDMessageBoxErrorProvider.Create(Self);
  Self.FLMDControlErrorProvider := TLMDControlErrorProvider.Create(Self);
end;

end.

