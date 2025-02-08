unit LMDLogWMCopyTransport;
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

LMDLogWMCopyTransport unit (AH)
-------------------------------
Log system that can help monitoring actions of application without debugger.

Changes
-------
Release 1.0 (1st quarter 2008)
 - Standalone release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, LMDProcs, LMDShUtils, LMDThreads, LMDTypes, LMDLogMessage;

type
  TLMDWMCopyDataTransport = class(TLMDLogCustomTransport, ILMDLogTransport)
  private
    FWindowClass: TLMDString;
    FWindowName: TLMDString;
  protected
    function GetParameters: WideString; override;
    procedure SetParameters(const Value: WideString); override;
    function CreateSendThread: TThread; override;
  public
    class function GetName: WideString; override;
    constructor Create; overload; override;
    constructor Create(const AWindowClass, AWindowName: TLMDString); reintroduce; overload;
    destructor Destroy; override;
    property WindowClass: TLMDString read FWindowClass write FWindowClass;
    property WindowName: TLMDString read FWindowName write FWindowName;
    property Parameters: WideString read GetParameters write SetParameters;
  end;

  TLMDWMSendThread = class(TLMDLogCustomSendThread)
  protected
    FWindowClass: TLMDString;
    FWindowName: TLMDString;

    function DoMessage(AMessage: TLMDLogMessage): Boolean; override;
  public
    constructor Create(ACreateSuspended: Boolean; AOwner: TLMDLogCustomTransport);
  end;

implementation

{ ************************ TLMDWMCopyDataTransport *************************** }
{ ---------------------------------------------------------------------------- }
constructor TLMDWMCopyDataTransport.Create;
begin
  inherited Create;
  LMDChangeWindowMessageFilter(WM_COPYDATA, True);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDWMCopyDataTransport.Create(const AWindowClass, AWindowName: TLMDString);
begin
  inherited Create;
  FWindowClass := AWindowClass;
  FWindowName := AWindowName;
  LMDChangeWindowMessageFilter(WM_COPYDATA, True);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDWMCopyDataTransport.Destroy;
begin
  LMDChangeWindowMessageFilter(WM_COPYDATA, False);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
class function TLMDWMCopyDataTransport.GetName: WideString;
begin
  Result := 'lmd_wmcopydata_log';
end;

{ ---------------------------------------------------------------------------- }
function TLMDWMCopyDataTransport.GetParameters: WideString;
begin
  Result := 'WindowClass=' + FWindowClass + #13#10 + 'WindowName=' + FWindowName;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWMCopyDataTransport.SetParameters(const Value: WideString);
var
  LStr: TLMDMemoryStrings;
begin
  LStr := TLMDMemoryStrings.Create;
  try
    try
      LStr.Text := Value;
      FWindowClass := LStr.Values['WindowClass'];
      FWindowName := LStr.Values['WindowName'];
    except
      raise ELMDLogException.CreateFmt('Parameters %s are incorrect', [Value]);
    end;
  finally
    LStr.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDWMCopyDataTransport.CreateSendThread: TThread;
begin
  Result := TLMDWMSendThread.Create(False, Self);
end;

{ ******************************** TLMDWMSendThread ************************** }
{ ---------------------------------------------------------------------------- }
constructor TLMDWMSendThread.Create(ACreateSuspended: Boolean; AOwner: TLMDLogCustomTransport);
begin
  inherited Create(ACreateSuspended, AOwner);
  FWindowClass := TLMDWMCopyDataTransport(AOwner).WindowClass;
  FWindowName := TLMDWMCopyDataTransport(AOwner).WindowName;
end;

{ ---------------------------------------------------------------------------- }
function TLMDWMSendThread.DoMessage(AMessage: TLMDLogMessage): Boolean;
var
  LMemStr: TMemoryStream;
  LData: TCopyDataStruct;
  LWindowHandle: THandle;
begin
  LMemStr := TMemoryStream.Create;
  try
    try
      AMessage.SaveToStream(LMemStr);

      LData.dwData := 0;
      LData.lpData := LMemStr.Memory;
      LData.cbData := LMemStr.Size;
      LWindowHandle := FindWindow(int_Ref(FWindowClass), int_Ref(FWindowName));
      Result := LongBool(SendMessage(LWindowHandle, WM_COPYDATA, 0, TLMDPtrInt(@LData)));
    except
      Result := False;
    end;
  finally
    FreeAndNil(AMessage);
    LMemStr.Free;
  end;
end;

// this transport registered in LMDLogMessage,pas unit

end.
