unit LMDLogMsgConnectMMFTransport;
{$I lmdcmps.inc}
{###############################################################################

LMDLogMsgConnectMMFTransport unit (AH)
--------------------------------------
MMF transport based on EldoS MsgConnect library

Changes
-------
Release 1.0 (1st quarter 2008)
 - Standalone release

###############################################################################}

interface

uses
  Classes, LMDTypes, LMDLogMessage, LMDLogMsgConnectTransport, MCBase, MCMMF;

type
  TLMDLogMsgConnectMMFTransport = class(TLMDLogCustomMsgConnectTransport)
  protected
    function CreateTransport: TMCBaseTransport; override;
    procedure SetMessengerName(const Value: TLMDString); override;
  public
    class function GetName: WideString; override;
  end;

implementation


{ *********************** TLMDLogMsgConnectMMFTransport ********************** }
{ ---------------------------------------------------------------------------- }
function TLMDLogMsgConnectMMFTransport.CreateTransport: TMCBaseTransport;
begin
  Result := TMCMMFTransport.Create(nil);
end;

{ ---------------------------------------------------------------------------- }
class function TLMDLogMsgConnectMMFTransport.GetName: WideString;
begin
  Result := 'eldos_mmf_log';
end;

procedure TLMDLogMsgConnectMMFTransport.SetMessengerName(
  const Value: TLMDString);
begin
  inherited;
  TMCMMFTransport(FTransport).MessengerName := FMessengerName + '_Client';
end;

initialization
  LMDLogManager.RegisterTransportClass(TLMDLogMsgConnectMMFTransport);

end.
