unit LMDLogMsgConnectHTTPTransport;
{$I lmdcmps.inc}
{###############################################################################

LMDLogMsgConnectHTTPTransport unit (AH)
---------------------------------------
HTTP transport based on EldoS MsgConnect library

Changes
-------
Release 1.0 (1st quarter 2008)
 - Standalone release

###############################################################################}

interface

uses
  Classes, LMDTypes, LMDLogMessage, LMDLogMsgConnectTransport, MCBase, MCHTTP;

type
  TLMDLogMsgConnectHTTPTransport = class(TLMDLogCustomMsgConnectTransport)
  protected
    function CreateTransport: TMCBaseTransport; override;
  public
    class function GetName: WideString; override;
  end;

implementation

{ *********************** TLMDLogMsgConnectMMFTransport ********************** }
{ ---------------------------------------------------------------------------- }
function TLMDLogMsgConnectHTTPTransport.CreateTransport: TMCBaseTransport;
begin
  Result := TMCHttpTransport.Create(nil);
end;

{ ---------------------------------------------------------------------------- }
class function TLMDLogMsgConnectHTTPTransport.GetName: WideString;
begin
  Result := 'eldos_http_log';
end;

initialization
  LMDLogManager.RegisterTransportClass(TLMDLogMsgConnectHTTPTransport);

end.
