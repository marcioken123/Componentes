unit LMDOneInstance;
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

LMDOneInstance unit ()
----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDCustomComponent;

type
  TLMDOneInstanceMode=(oiActivateOnly, oiDefaultMessage, oiCustom);

  TLMDOneInstance = class(TLMDCustomComponent)
  private
    FMode:TLMDOneInstanceMode;
    FEnabled:Boolean;
    FCustomEvent:TNotifyEvent;
  protected
    procedure Loaded;override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  published
    property About;
    property Enabled:Boolean read FEnabled write FEnabled default True;
    property Mode:TLMDOneInstanceMode read FMode write FMode default oiActivateOnly;
    property OnCustom:TNotifyEvent read FCustomEvent write FCustomEvent;
  end;

implementation

uses
  Forms, SysUtils, Dialogs,
  LMDUtils,
  LMDConst,
  lmdclass;

var
  LMDInstanceCounter:Byte;

{---------------------------- Protected ---------------------------------------}
procedure TLMDOneInstance.Loaded;
begin
  inherited Loaded;
  if FEnabled and not ((csDesigning in ComponentState) or IsLibrary) then
    if LMDApplication.IsPrevRunning then
      begin
        case FMode of
          oiActivateOnly:LMDActivatePrevInstance;
          oiDefaultMessage:
            begin
              MessageDlg('"'+Application.Title+'" '+IDS_ALREADYSTARTED, mtInformation, [mbOK],0);
              LMDActivatePrevInstance;
            end;
          oiCustom:
            if Assigned(FCustomEvent) then
              FCustomEvent(Self)
            else
              LMDActivatePrevInstance;
          end;
        Application.Terminate;
        //Halt;
      end;
end;

{---------------------------- Public ------------------------------------------}
constructor TLMDOneInstance.Create(aOwner:TComponent);
begin
  inherited Create(aOWner);
  Inc(LMDInstanceCounter);
  if LMDInstanceCounter>1 then
    raise ELMDOneInstError.Create(self.ClassName,1);

  FEnabled:=True;
  FMode:=oiActivateOnly;
end;

{------------------------------------------------------------------------------}
destructor TLMDOneInstance.Destroy;
begin
  Dec(LMDInstanceCounter);
  inherited Destroy;
end;

initialization
  LMDInstanceCounter:=0;
end.
