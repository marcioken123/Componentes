unit LMDLogMsgConnectTransport;
{$I lmdcmps.inc}
{###############################################################################

LMDLogMsgConnectTransport unit (AH)
-----------------------------------
Transport based on EldoS MsgConnect library

Changes
-------
Release 1.0 (1st quarter 2008)
 - Standalone release

###############################################################################}

interface

uses
  Classes, SysUtils, TypInfo, LMDLogMessage, LMDTypes, LMDStrings, MCBase,
  MCZLib, MCAES, MCCRC32, MCMD5, MCAdler;

type
  TLMDLogMsgSealer = (lmsNone, lmsCRC32, lmsMD5, lmsAdler);

  TLMDLogCustomMsgConnectTransport = class(TLMDLogCustomTransport)
  private
    procedure SetCompressed(const Value: Boolean);
    procedure SetEncrypted(const Value: Boolean);
    procedure SetEncryptionKey(const Value: TLMDString);
    procedure SetSealer(const Value: TLMDLogMsgSealer);
  protected
    FCompression: TMCBaseCompression;
    FEncryptor: TMCAESEncryption;
    FSealer: TLMDLogMsgSealer;
    FTransport: TMCBaseTransport;
    FMessengerName: TLMDString;
    FQueueName: TLMDString;
    FDestination: TLMDString;
    FMessenger: TMCMessenger;
    FCompressed: Boolean;
    FEncrypted: Boolean;
    FEncryptionKey: ByteArray;
    FSealed: Boolean;
    procedure SetMessengerName(const Value: TLMDString); virtual;
    procedure SetQueueName(const Value: TLMDString); virtual;
    function CreateTransport: TMCBaseTransport; virtual; abstract;
    function CreateSendThread: TThread; override;
    function GetParameters: WideString; override;
    procedure SetParameters(const Value: WideString); override;
    function EncryptionKeyToString: TLMDString; virtual;
    procedure StringToEncryptionKey(const AString: TLMDString); virtual;
  public
    constructor Create; override;
    property Messenger: TMCMessenger read FMessenger;
    property Destination: TLMDString read FDestination;
    property MessengerName: TLMDString read FMessengerName write SetMessengerName;
    property QueueName: TLMDString read FQueueName write SetQueueName;
    property Compressed: Boolean read FCompressed write SetCompressed;
    property Sealer: TLMDLogMsgSealer read FSealer write SetSealer;
    property Encrypted: Boolean read FEncrypted write SetEncrypted;
    property EncryptionKey: TLMDString read EncryptionKeyToString write SetEncryptionKey;
  end;

  TLMDLogMsgConnectSendThread = class(TLMDLogCustomSendThread)
  protected
    FOwner: TLMDLogCustomMsgConnectTransport;
    function DoMessage(AMessage: TLMDLogMessage): Boolean; override;
  public
    constructor Create(ACreateSuspended: Boolean; AOwner: TLMDLogCustomTransport);
  end;

  TLMDMCTransport = class(TMCBaseTransport);

implementation

{ ******************** TLMDLogCustomMsgConnectTransport ********************** }
{ ---------------------------------------------------------------------------- }
constructor TLMDLogCustomMsgConnectTransport.Create;
begin
  inherited;
  FMessenger := TMCMessenger.Create(nil);
  FTransport := CreateTransport;
  FTransport.Messenger := FMessenger;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogCustomMsgConnectTransport.CreateSendThread: TThread;
begin
  Result := TLMDLogMsgConnectSendThread.Create(False, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogCustomMsgConnectTransport.EncryptionKeyToString: TLMDString;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to Length(FEncryptionKey) - 1 do
    Result := Result + IntToHex(FEncryptionKey[i], 2);
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogCustomMsgConnectTransport.GetParameters: WideString;

  function GetSealerAsString: TLMDString;
  begin
    Result := Copy(GetEnumName(TypeInfo(TLMDLogMsgSealer), Ord(FSealer)), 3, 65535);
  end;

begin
  Result := 'MessengerName=' + FMessengerName + LMDCRLF;
  Result := Result + 'QueueName=' + FQueueName + LMDCRLF;
  Result := Result + 'Compressed=' + IntToStr(Integer(FCompression)) + LMDCRLF;
  Result := Result + 'Sealer=' + GetSealerAsString + LMDCRLF;
  Result := Result + 'Encrypted=' + IntToStr(Integer(FEncrypted));
  if FEncrypted then
    Result := Result + LMDCRLF + 'AESKey=' + EncryptionKeyToString();
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCustomMsgConnectTransport.SetParameters(const Value: WideString);

  function LMDStrToBool(const AStr: TLMDString): Boolean;
  begin
    if AStr <> '' then
      Result := Boolean(StrToInt(AStr))
    else
      Result := False;
  end;

var
  LStr: TLMDMemoryStrings;
begin
  LStr := TLMDMemoryStrings.Create;
  try
    try
      LStr.Text := Value;
      QueueName := LStr.Values['QueueName'];
      MessengerName := LStr.Values['MessengerName'];
      Compressed := LMDStrToBool(LStr.Values['Compressed']);
      Sealer := TLMDLogMsgSealer(GetEnumValue(TypeInfo(TLMDLogMsgSealer), 'lms' + LStr.Values['Sealer']));
      Encrypted := LMDStrToBool(LStr.Values['Encrypted']);
      if Encrypted then
        EncryptionKey := LStr.Values['EncyptionKey'];
    except
      raise ELMDLogException.CreateFmt('Parameters %s are incorrect', [Value]);
    end;
  finally
    LStr.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCustomMsgConnectTransport.SetCompressed(const Value: Boolean);
begin
  if FCompressed <> Value then
  begin
    FCompressed := Value;
    if FCompressed then
      FCompression := TMCZLibCompression.Create(nil)
    else
      FreeAndNil(FCompression);

    FTransport.Compressor := FCompression;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCustomMsgConnectTransport.SetEncrypted(const Value: Boolean);
begin
  if FEncrypted <> Value then
  begin
    FEncrypted := Value;
    if FEncrypted then
      FEncryptor := TMCAESEncryption.Create(nil)
    else
      FreeAndNil(FEncryptor);
    FTransport.Encryptor := FEncryptor;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCustomMsgConnectTransport.SetEncryptionKey(const Value: TLMDString);
begin
  StringToEncryptionKey(Value);
  if FEncrypted then
    FEncryptor.SetKey('', FEncryptionKey);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCustomMsgConnectTransport.SetMessengerName(const Value: TLMDString);
begin
  if FMessengerName <> Value then
  begin
    FMessengerName := Value;
    FDestination := TLMDMCTransport(FTransport).RealTransportName + ':' + FMessengerName + '|' + FQueueName;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCustomMsgConnectTransport.SetQueueName(const Value: TLMDString);
begin
  if FQueueName <> Value then
  begin
    FQueueName := Value;
    FDestination := TLMDMCTransport(FTransport).RealTransportName + ':' + FMessengerName + '|' + FQueueName;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCustomMsgConnectTransport.SetSealer(const Value: TLMDLogMsgSealer);
begin
  if FSealer <> Value then
  begin
    FSealer := Value;
    case FSealer of
    lmsNone:
      begin
        if Assigned(FTransport.Sealer) then
        begin
          FTransport.Sealer.Free;
          FTransport.Sealer := nil;
        end;
      end;
    lmsCRC32:
      FTransport.Sealer := TMCCRC32Sealing.Create(nil);
    lmsMD5:
      FTransport.Sealer := TMCMD5Sealing.Create(nil);
    lmsAdler:
      FTransport.Sealer := TMCAdlerSealing.Create(nil);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCustomMsgConnectTransport.StringToEncryptionKey(const AString: TLMDString);
var
  i: Integer;
  LLen: Byte;
  LTemp: Byte;
begin
  LLen := Length(AString) div 2;
  if not (LLen in [16, 24, 32])  then
    raise ELMDLogException.CreateFmt('Length of AES key should be 16, 24 or 32 bytes. Current length is %d', [LLen]);

  SetLength(FEncryptionKey, LLen);
  LTemp := 0;
  for i := 1 to Length(AString) do
  begin
    if AnsiChar(AString[i]) in ['0'..'9'] then
      LTemp := (LTemp shl 4) + (Ord(AString[i]) - Ord('0'))
    else
      if AnsiChar(AString[i]) in ['A'..'F'] then
        LTemp := (LTemp shl 4) + (Ord(AString[i]) - Ord('A') + 10)
      else
        raise ELMDLogException.CreateFmt('AES key format is broken at position %d', [i]);
    if ((i + 1) and i > 0) then
      FEncryptionKey[(i div 2) - 1] := LTemp;
  end;
end;

{ ********************* TLMDLogMsgConnectSendThread ************************** }
{ ---------------------------------------------------------------------------- }
constructor TLMDLogMsgConnectSendThread.Create(ACreateSuspended: Boolean;
  AOwner: TLMDLogCustomTransport);
begin
  inherited Create(ACreateSuspended, AOwner);
  FOwner := TLMDLogCustomMsgConnectTransport(AOwner);
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogMsgConnectSendThread.DoMessage(AMessage: TLMDLogMessage): Boolean;
var
  LMemStream: TMemoryStream;
  LMCMessage: TMCMessage;
begin
  Result := True;
  try
    LMemStream := TMemoryStream.Create;
    try
      if not FOwner.FTransport.Active then
         FOwner.FTransport.Active := True;
      AMessage.SaveToStream(LMemStream);
      LMCMessage := FOwner.FMessenger.CreateMessageFromBinary(1, 0, 0, LMemStream.Memory, LMemStream.Size, False);
      FOwner.FMessenger.SendMessage(FOwner.Destination, LMCMessage, nil);
    finally
      LMemStream.Free;
    end;
  except
    Result := False;
  end;
end;

end.
