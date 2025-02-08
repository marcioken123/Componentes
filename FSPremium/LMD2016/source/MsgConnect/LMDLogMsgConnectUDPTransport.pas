unit LMDLogMsgConnectUDPTransport;
{$I lmdcmps.inc}
{###############################################################################

LMDLogMsgConnectUDPTransport unit (AH)
--------------------------------------
UDP transport based on EldoS MsgConnect library

Changes
-------
Release 1.0 (1st quarter 2008)
 - Standalone release

###############################################################################}

interface

uses
  Classes, LMDTypes, LMDLogMessage, LMDLogMsgConnectTransport, MCBase, MCUDPSocket;

type
  TLMDLogMsgConnectUDPTransport = class(TLMDLogCustomMsgConnectTransport)
  protected
    function CreateTransport: TMCBaseTransport; override;
  public
    class function GetName: WideString; override;
  end;

implementation

{ *********************** TLMDLogMsgConnectMMFTransport ********************** }
{ ---------------------------------------------------------------------------- }
function TLMDLogMsgConnectUDPTransport.CreateTransport: TMCBaseTransport;
begin
  Result := TMCUDPTransport.Create(nil);
end;

{ ---------------------------------------------------------------------------- }
class function TLMDLogMsgConnectUDPTransport.GetName: WideString;
begin
  Result := 'eldos_udp_log';
end;

initialization
  LMDLogManager.RegisterTransportClass(TLMDLogMsgConnectUDPTransport);

end.
