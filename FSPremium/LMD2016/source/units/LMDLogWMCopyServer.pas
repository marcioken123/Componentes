unit LMDLogWMCopyServer;
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

LMDLogWMCopyServer unit (AH)
----------------------------
Collector for WM_COPYDATA transport

Changes
-------
Release 1.0 (1st quarter 2008)
 - Standalone release

###############################################################################}

interface

uses
  Windows, Classes, SysUtils, Messages, LMDLogServer, LMDLogMessage, LMDUtils, LMDTypes;

type
  TLMDWMCopyDataCollector = class(TLMDLogCollector)
  private
    FWindowHandle: THandle;
  protected
    procedure WndProc(var Message: TMessage); virtual;
    procedure WMCopyData(var Message: TWMCopyData); message WM_COPYDATA;
  public
    constructor Create;
    destructor Destroy; override;
    class function GetName: WideString; override;
  end;

implementation

{*************************** TLMDWMCopyDataCollector **************************}
{ ---------------------------------------------------------------------------- }
constructor TLMDWMCopyDataCollector.Create;
begin
  inherited;
  FWindowHandle := LMDAllocateHWnd(Self, WndProc, 'TLMDLogHelperWindow', 'LMDLogHelper');
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDWMCopyDataCollector.Destroy;
begin
  LMDDeallocateHWnd(FWindowHandle);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
class function TLMDWMCopyDataCollector.GetName: WideString;
begin
  // Name should the same as in corresponding transport
  Result := 'lmd_wmcopydata_log';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWMCopyDataCollector.WMCopyData(var Message: TWMCopyData);
var
  LMem: TMemoryStream;
  LLogMsg: TLMDLogMessage;
begin
  LMem := TMemoryStream.Create;
  try
    LMem.Write(Message.CopyDataStruct^.lpData^, Message.CopyDataStruct^.cbData);
    LMem.Position := 0;
    LLogMsg := TLMDLogMessage.Create;
    try
      LLogMsg.LoadFromStream(LMem);
      DispatchMessage(LLogMsg);
    except
      LLogMsg.Free;
    end;
  finally
    LMem.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWMCopyDataCollector.WndProc(var Message: TMessage);
begin
  try
    Dispatch(Message);
  except
    if Assigned(ApplicationHandleException) then
      ApplicationHandleException(Self);
  end;
end;

end.
