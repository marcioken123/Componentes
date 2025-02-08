unit ElCGControl;
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

ElCGControl unit
----------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Controls,
  LMDTypes, intfLMDBase, ElVCLUtils;

type
  {******************* Object TElCustomGraphicControl *************************}
  TElCustomGraphicControl = class(TGraphicControl, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
  protected
    procedure Loaded; override;
  public
    function getLMDPackage:TLMDPackageID;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property Color nodefault;
    {$IFDEF LMCCOMP14}
    property OnGesture;
    property Touch;
    {$ENDIF}
  end;

implementation
{******************* Object TElCustomGraphicControl ***************************}
{----------------------- protected --------------------------------------------}
procedure TElCustomGraphicControl.Loaded;
begin
  inherited;
  if ParentColor then
    begin
      ParentColor := False;
      ParentColor := True;
  end;
end;

{----------------------- public -----------------------------------------------}
function TElCustomGraphicControl.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_ELCORE;
end;

end.
