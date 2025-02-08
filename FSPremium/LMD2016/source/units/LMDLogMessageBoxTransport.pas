unit LMDLogMessageBoxTransport;
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

LMDLogMessageBoxTransport unit (AH)
------------------------------------
Send log messages to MessageBox

Changes
-------
Release 1.0 (1st quarter 2008)
 - Standalone release

###############################################################################}

interface

uses
  Classes, Windows, LMDTypes, LMDProcs, LMDLogLayoutTransport, LMDLogMessage,
  Dialogs;

type
  TLMDLogMessageBoxTransport = class(TLMDLogLayoutTransport)
  protected
    function CreateSendThread: TThread; override;
  end;

  TLMDLogMessageBoxSendThread = class(TLMDLogCustomSendThread)
  protected
    FOwner: TLMDLogMessageBoxTransport;
    function DoMessage(AMessage: TLMDLogMessage): Boolean; override;
  public
    constructor Create(ACreateSuspended: Boolean; AOwner: TLMDLogCustomTransport);
    destructor Destroy; override;
  end;

implementation

{ ************************ TLMDLogDebugStringTransport *********************** }
{ ---------------------------------------------------------------------------- }
function TLMDLogMessageBoxTransport.CreateSendThread: TThread;
begin
  Result := TLMDLogMessageBoxSendThread.Create(False, Self);
end;

{ *********************** TLMDLogDebugStringSendThread *********************** }
{ ---------------------------------------------------------------------------- }
constructor TLMDLogMessageBoxSendThread.Create(ACreateSuspended: Boolean; AOwner: TLMDLogCustomTransport);
begin
  inherited Create(ACreateSuspended, AOwner);
  FOwner := TLMDLogMessageBoxTransport(AOwner);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDLogMessageBoxSendThread.Destroy;
begin
  inherited;
end;

function TLMDLogMessageBoxSendThread.DoMessage(AMessage: TLMDLogMessage): Boolean;
var
  LStr: TLMDString;
begin
  Result := True;
  try
    LStr := FOwner.Layout.GetMessageAsText(AMessage);
    ShowMessage(LStr);
  except
    Result := False;
  end;
end;

initialization
  LMDLogManager.RegisterTransportClass(TLMDLogMessageBoxTransport);

end.

