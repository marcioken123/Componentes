unit LMDLogServer;
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

LMDLogServer unit (AH)
----------------------
Common ancestor for Log messages collectors

Changes
-------
Release 1.0 (1st quarter 2008)
 - Standalone release

###############################################################################}

interface

uses
  Classes, Windows, SysUtils, Messages, LMDTypes, LMDZLib, LMDFiles, LMDObjectList, LMDThreads,
  LMDLogMessage;

const
  CHeaderMarker: array[0..5] of byte = ($4C, $4D, $44, $4C, $4F, $47); // *.lgl file marker

type
  TLMDLogCollector = class(TPersistent)
  private
    FMessageList: TLMDObjectList;
    FOnControlMessageReceive: TLMDLogMessageNotify;
    FOnWatchMessageReceive: TLMDLogMessageNotify;
    FOnFlowMessageReceive: TLMDLogMessageNotify;
    FOnDataMessageReceive: TLMDLogMessageNotify;
    FLogged: Boolean;
    FOnLoadingProgress: TLMDLogCollectorProgress;
    FCriticalSection: TLMDCriticalSection;
    FNewMessageNotify: TLMDLogMessageNotify;
    FIgnorePackets: Boolean;
    FOnLoaded: TNotifyEvent;
    FIsLoading: Boolean;
    function GetIsEmpty: boolean;
  protected
    FModified: Boolean;
    procedure DispatchMessage(const ALogMsg: TLMDLogMessage); virtual;
    procedure TriggerLoadingProgress(ACount, ACurrent: Integer); virtual;
    procedure TriggerReceiveDataMessage(ALogMessage: TLMDLogMessage); virtual;
    procedure TriggerReceiveWatchMessage(ALogMessage: TLMDLogMessage); virtual;
    procedure TriggerReceiveFlowMessage(ALogMessage: TLMDLogMessage); virtual;
    procedure TriggerReceiveControlMessage(ALogMessage: TLMDLogMessage); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    class function GetName: WideString; virtual;
    procedure LoadFromFile(AFileName: TLMDString);
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToFile(AFileName: TLMDString);
    procedure SaveToStream(AStream: TStream);
    procedure ReloadQueue;
    procedure RemoveLogMessage(AMessage: TLMDLogMessage);
    procedure InsertAfterLogMessage(AAfter, ALogMessage: TLMDLogMessage);
    procedure InsertBeforeLogMessage(ABefore, ALogMessage: TLMDLogMessage);
    procedure Clear;
    property Modified: Boolean read FModified;
    property IsLoading: Boolean read FIsLoading;
    property IgnorePackets: Boolean read FIgnorePackets write FIgnorePackets;
    property MessageList: TLMDObjectList read FMessageList;
    property Logged: Boolean read FLogged write FLogged;
    property IsEmpty: boolean read GetIsEmpty;
    property OnLoadingProgress: TLMDLogCollectorProgress read FOnLoadingProgress write FOnLoadingProgress;
    property OnDataMessageReceive: TLMDLogMessageNotify read FOnDataMessageReceive write FOnDataMessageReceive;
    property OnWatchMessageReceive: TLMDLogMessageNotify read FOnWatchMessageReceive write FOnWatchMessageReceive;
    property OnFlowMessageReceive: TLMDLogMessageNotify read FOnFlowMessageReceive write FOnFlowMessageReceive;
    property OnControlMessageReceive: TLMDLogMessageNotify read FOnControlMessageReceive write FOnControlMessageReceive;
    property OnNewMessage: TLMDLogMessageNotify read FNewMessageNotify write FNewMessageNotify;
    property OnLoaded: TNotifyEvent read FOnLoaded write FOnLoaded;
  end;

implementation

{**************************** TLMDLogCollector ********************************}
{ ---------------------------------------------------------------------------- }
constructor TLMDLogCollector.Create;
begin
  inherited;
  FMessageList := TLMDObjectList.Create;
  FMessageList.AutoClearObjects := True;
  FCriticalSection := TLMDCriticalSection.Create;
  FIgnorePackets := False;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDLogCollector.Destroy;
begin
  FCriticalSection.Free;
  FreeAndNil(FMessageList);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCollector.DispatchMessage(const ALogMsg: TLMDLogMessage);
begin
  if not FIgnorePackets then
  begin
    if not FModified then
      FModified := True;
    ALogMsg.DateTimeReceived := Now; // Correct reciving time;
    if FLogged then
      FMessageList.Add(ALogMsg);

    if Assigned(FNewMessageNotify) then
      FNewMessageNotify(Self, ALogMsg);

    case ALogMsg.MessageType of
      mtControlMessage:
        TriggerReceiveControlMessage(ALogMsg);
      mtDataMessage:
        TriggerReceiveDataMessage(ALogMsg);
      mtFlowMessage:
        TriggerReceiveFlowMessage(ALogMsg);
      mtWatchMessage:
        TriggerReceiveWatchMessage(ALogMsg);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogCollector.GetIsEmpty: boolean;
begin
  Result := FLogged and (FMessageList.Count = 0);
end;

{ ---------------------------------------------------------------------------- }
class function TLMDLogCollector.GetName: WideString;
begin
  raise ELMDLogException.Create('This method must be overriden');
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCollector.LoadFromFile(AFileName: TLMDString);
var
  LStream: TLMDFileStream;
begin
  LStream := TLMDFileStream.Create(AFileName, fmOpenRead);
  try
    LoadFromStream(LStream);
  finally
    LStream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCollector.LoadFromStream(AStream: TStream);
var
  LZStr: TLMDDecompressionStream;
  LMem: TMemoryStream;
  LCount: Integer;
  i: integer;
  LMarker: array[0..5] of byte;
  LMessage: TLMDLogMessage;
  LNativeMarker: AnsiString;
begin
  FModified := False;
  FIsLoading := True;
  LMem := TMemoryStream.Create;
  try
    AStream.Read(LMarker, 6);
    SetLength(LNativeMarker, 6);
    Move(LMarker, LNativeMarker[1], 6);
    if LNativeMarker <> 'LMDLOG' then
      raise ELMDLogException.Create('Corrupted log stream');
    {.$MESSAGE WARN 'Change to flow style reading without counter'}
    AStream.Read(LCount, SizeOf(LCount));
    // Skip reserved bytes
    AStream.Seek(8, soFromCurrent);
    LMem.CopyFrom(AStream, (AStream.Size - AStream.Position));
    LZStr := TLMDDecompressionStream.Create(LMem);
    try
      LZStr.Position := 0;
      FMessageList.Clear;
      i := 0;
      while i < LCount do
      begin
        LMessage := TLMDLogMessage.Create;
        LMessage.LoadFromStream(LZStr);
        DispatchMessage(LMessage);
        TriggerLoadingProgress(LCount, i);
        inc(i);
      end;
    finally
      LZStr.Free;
    end;
  finally
    FIsLoading := False;
    LMem.Free;
  end;
  if Assigned(FOnLoaded) then
    FOnLoaded(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCollector.SaveToFile(AFileName: TLMDString);
var
  LStream: TLMDFileStream;
begin
  LStream := TLMDFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(LStream);
  finally
    LStream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCollector.SaveToStream(AStream: TStream);
var
  i: Integer;
  LZStr: TLMDCompressionStream;
  LMem: TMemoryStream;
  LReserved: Integer;
begin
  LMem := TMemoryStream.Create;
  try
    // Write header
    AStream.Write(CHeaderMarker, Length(CHeaderMarker));
    AStream.Write(FMessageList.Count, SizeOf(FMessageList.Count));
    LReserved := 0;
    // Reserved for future use
    AStream.Write(LReserved, SizeOf(LReserved));
    AStream.Write(LReserved, SizeOf(LReserved));
    LZStr := TLMDCompressionStream.Create(clDefault, LMem);
    try
      for i := 0 to FMessageList.Count - 1 do
        TLMDLogMessage(FMessageList[i]).SaveToStream(LZStr);
    finally
      LZStr.Free;
    end;
    LMem.Position := 0;
    AStream.CopyFrom(LMem, LMem.Size);
  finally
    LMem.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCollector.TriggerLoadingProgress(ACount, ACurrent: Integer);
begin
  if Assigned(FOnLoadingProgress) then
    FOnLoadingProgress(Self, ACount, ACurrent);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCollector.TriggerReceiveControlMessage(ALogMessage: TLMDLogMessage);
begin
  if Assigned(FOnControlMessageReceive) then
    FOnControlMessageReceive(Self, ALogMessage);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCollector.TriggerReceiveDataMessage(ALogMessage: TLMDLogMessage);
begin
  if Assigned(FOnDataMessageReceive) then
    FOnDataMessageReceive(Self, ALogMessage);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCollector.TriggerReceiveFlowMessage(ALogMessage: TLMDLogMessage);
begin
  if Assigned(FOnFlowMessageReceive) then
    FOnFlowMessageReceive(Self, ALogMessage);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCollector.TriggerReceiveWatchMessage(ALogMessage: TLMDLogMessage);
begin
  if Assigned(FOnWatchMessageReceive) then
    FOnWatchMessageReceive(Self, ALogMessage);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCollector.ReloadQueue();
var
  i: Integer;
  lLogMessage: TLMDLogMessage;
begin
  for i := 0 to FMessageList.Count - 1 do
  begin
     Logged := false;
     lLogMessage := TLMDLogMessage(MessageList.Items[i]);
     DispatchMessage(lLogMessage);
     Logged := true;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCollector.RemoveLogMessage(AMessage: TLMDLogMessage);
var
  Lindex: Integer;
begin
  Lindex := FMessageList.IndexOf(AMessage);
  if LIndex >= 0 then
    FMessageList.Remove(AMessage);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCollector.InsertBeforeLogMessage(ABefore, ALogMessage: TLMDLogMessage);
var
  lIndex: Integer;
begin
  FCriticalSection.Enter;
  lIndex := FMessageList.IndexOf(ABefore);
  FMessageList.Insert(lIndex, ALogMessage);
  ALogMessage.AppName := ABefore.AppName;
  ALogMessage.ProcessId := ABefore.ProcessId;
  ALogMessage.ThreadId := ABefore.ThreadId;
  FCriticalSection.Leave;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCollector.Clear;
begin
  FMessageList.Clear;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCollector.InsertAfterLogMessage(AAfter, ALogMessage: TLMDLogMessage);
var
  i, lIndex: Integer;
  lCurMsg: TLMDLogMessage;
  lFound: Boolean;
begin
    FCriticalSection.Enter;
    lIndex := FMessageList.IndexOf(Pointer(AAfter)) + 1;
    if lIndex > MessageList.Count - 1 then
      FMessageList.Add(ALogMessage)
    else
    begin
      lFound := false;
      for i := lIndex to MessageList.Count - 1 do
      begin
        lCurMsg := TLMDLogMessage(MessageList.Items[i]);
        if  not (lCurMsg.MessageSubType.Equal(mstComment)) then
        begin
          lIndex := i;
          lFound := true;
          break;
        end;
      end;
      if lFound then
        FMessageList.Insert(lIndex, ALogMessage)
      else
        FMessageList.Add(ALogMessage);
    end;
    ALogMessage.AppName := AAfter.AppName;
    ALogMessage.ProcessId := AAfter.ProcessId;
    ALogMessage.ThreadId := AAfter.ThreadId;

    FCriticalSection.Leave;
end;

end.
