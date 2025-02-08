unit LMDLogMsgConnectTCPTransport;
{$I lmdcmps.inc}
{###############################################################################

LMDLogMsgConnectTCPTransport unit (AH)
--------------------------------------
TCP transport based on EldoS MsgConnect library

Changes
-------
Release 1.0 (1st quarter 2008)
 - Standalone release

###############################################################################}

interface

uses
  Classes, LMDTypes, LMDLogMessage, LMDLogMsgConnectTransport, MCBase, MCSocket;

type
  TLMDLogMsgConnectTCPTransport = class(TLMDLogCustomMsgConnectTransport)
  protected
    function CreateTransport: TMCBaseTransport; override;
  public
    class function GetName: WideString; override;
  end;

implementation

{ *********************** TLMDLogMsgConnectMMFTransport ********************** }
{ ---------------------------------------------------------------------------- }
function TLMDLogMsgConnectTCPTransport.CreateTransport: TMCBaseTransport;
begin
  Result := TMCSocketTransport.Create(nil);
end;

{ ---------------------------------------------------------------------------- }
class function TLMDLogMsgConnectTCPTransport.GetName: WideString;
begin
  Result := 'eldos_tcp_log';
end;

initialization
  LMDLogManager.RegisterTransportClass(TLMDLogMsgConnectTCPTransport);

end.
