unit ElComponent;
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

ElComponent unit (AH)
---------------------
Base class for non-visual components

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Classes, intfLMDBase, LMDTypes;

type
  {******************* Object TElComponent ************************************}
  TElComponent = class(TComponent, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
    FOnChange : TNotifyEvent;
  protected
    procedure GetChange(Sender: TObject);dynamic;
    procedure Change;dynamic;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    function getLMDPackage:TLMDPackageID;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
  end;

  {******************* Object TElBaseDlgComponent *****************************}
  TElBaseDlgComponent = class(TElComponent)
  public
    function Execute: Boolean; virtual; abstract;
  end;

implementation
{************************** Class TElComponent ********************************}
{------------------------- Protected ------------------------------------------}
procedure TElComponent.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

{------------------------------------------------------------------------------}
procedure TElComponent.GetChange(Sender:TObject);
begin
  Change;
end;
{----------------------- public -----------------------------------------------}
function TElComponent.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_ELCORE;
end;

end.
