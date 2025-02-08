unit LMDUpdateAdapter;
{$I LMDCmps.inc}

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

LMDUpdateAdapter unit (AIH)
--------------------
LMDUpdateAdapter - adapter provided transport between
LMDUpdater and host application
Changes
-------
Release 1.0 (May 2008)
 - Initial Release

###############################################################################}

interface
  uses
    Classes, LMDTypes, LMDWebConfig, Windows, Messages, LMDMemoryMappedStream,
    LMDCustomComponent, LMDUpdateFrm, LMDUpdateMessage, LMDWebBase;
const
  LMD_UPDATE_TRANSPORT_NAME = '@@@LMD_UPDATE_TRANSPORT@@@';
  LMD_CHANNEL_NAME = '@@@LMD_UPDATE_CHANNEL@@@';

type
  TLMDUpdateCloseRequestEvent = procedure (var AnAllow: boolean) of object;
  TLMDUpdateProgressEvent = procedure (AProgressPercent: Byte; ACurrentFileName: TLMDString;
                               ACurrentFileSize: LongWord; ATimeEstimateElapsed: LongWord) of object;
  TLMDUpdateScriptReceiveEvent = procedure (ADbID: Integer; AScript: TLMDString) of object;
  TLMDUpdateErrorEvent = procedure (AErrCode: Integer; AComment: TLMDString) of object;
  TLMDUpdateConfirmEvent = procedure (Sender: TObject; ADesciption: TLMDString; var AResult: HRESULT) of object;
  TLMDUpdateInformationEvent = procedure (AInfo: TLMDString) of object;
  {TLMDUpdateMessageType = (umtBreakUpdate, umtError, umtScript, umtProgress, umtFinish, umtGetConfig, umtInfo, umtConfirm, umtCloseRequest);

  
  TLMDUpdateMessage = class(TObject)
  private
     FMsgType: TLMDUpdateMessageType;
     FDescr: TLMDString;
     FPercent: Byte;
     FCurFileName: TLMDString;
     FCurFileSize: LongWord;
     FTimeEstimateElapsed: LongWord;
     FErrCode: Integer;
     FDbID: Integer;
     FWebConfig: TLMDWebConfig;
     FResult: HRESULT;
  public
    procedure SaveToStream(AStream: TStream);
    procedure LoadFromStream(AStream: TStream);
    property MsgType: TLMDUpdateMessageType read FMsgType write FMsgType;
    property Descr: TLMDString read FDescr write FDescr;
    property Percent: Byte read FPercent write FPercent;
    property CurFileName: TLMDString read FCurFileName write FCurFileName;
    property CurFileSize: LongWord read FCurFileSize write FCurFileSize;
    property TimeEstimateElapsed: LongWord read FTimeEstimateElapsed write FTimeEstimateElapsed;
    property ErrCode: Integer read FErrCode write FErrCode;
    property DbID: Integer read FDbID write FDbID;
    property WebConfig: TLMDWebConfig read FWebConfig write FWebConfig;
    property Result: HRESULT read FResult write FResult;
  end;            }

  TLMDUpdateOnMessageReceive = procedure (Sender: TObject; AMessage: TLMDUpdateMessage) of object;

  TLMDUpdateTransport = class (TObject)
  private
    FIsServer: Boolean;
    FOnMessageReceive: TLMDUpdateOnMessageReceive;
    FWindow: HWND;
    FLinkedWindow: THandle;
    FMsg: LongWord;
    FChannel: TLMDMemoryMappedStream;
    procedure WndProc(var Message: TMessage); virtual;
    function GetConnected(): Boolean;
  public
    constructor Create(AServer: Boolean);
    destructor Destroy; override;
    function SendMsg(var AMsg: TLMDUpdateMessage): boolean;
    property OnMessageReceive: TLMDUpdateOnMessageReceive read FOnMessageReceive write FOnMessageReceive;
    property IsServer: Boolean read FIsServer;
    property WindowHandle: HWND read FWindow;
    class function Instance: TLMDUpdateTransport;
    class function CreateInstance(AServer: Boolean): TLMDUpdateTransport;
    property Connected: Boolean read GetConnected;
    procedure SetInstance(AnInstance: TLMDUpdateTransport);
  end;

  {*************************** TLMDCustomUpdateAdapter ************************}
  TLMDCustomUpdateAdapter = class (TLMDWebComponent)
  private
    FOnCloseRequest: TLMDUpdateCloseRequestEvent;
    FOnProgress: TLMDUpdateProgressEvent;
    FOnScriptReceive: TLMDUpdateScriptReceiveEvent;
    FOnFinish: TNotifyEvent;
    FOnError: TLMDUpdateErrorEvent;
    FOnConfirm: TLMDUpdateConfirmEvent;
    FOnInformation: TLMDUpdateInformationEvent; 
    FMakeRollback: boolean;
    FWebConfig: TLMDWebConfig;
    FUpdateFrm: TLMDUpdateForm;
    function ExtractFromResource(): boolean;

  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    procedure MessageReceive(Sender: TObject; AMessage: TLMDUpdateMessage);
    function CheckForUpdate(): boolean;
    function BreakUpdate(ARolledback: boolean): boolean;
    constructor Create (AOwner: TComponent); override;
    property MakeRollback: Boolean read FMakeRollback write FMakeRollback;
    property WebConfig: TLMDWebConfig read FWebConfig write FWebConfig;
    {events}
    property OnCloseRequest: TLMDUpdateCloseRequestEvent read FOnCloseRequest write FOnCloseRequest;
    property OnProgress: TLMDUpdateProgressEvent read FOnProgress write FOnProgress;
    property OnScriptReceive: TLMDUpdateScriptReceiveEvent read FOnScriptReceive write FOnScriptReceive;
    property OnFinish: TNotifyEvent read FOnFinish write FOnFinish;
    property OnError: TLMDUpdateErrorEvent read FOnError write FOnError;
    property OnConfirm: TLMDUpdateConfirmEvent read FOnConfirm write FOnConfirm;
    property OnInformation: TLMDUpdateInformationEvent read FOnInformation write FOnInformation;
    property UpdateForm: TLMDUpdateForm read FUpdateFrm write FUpdateFrm;
  end;

 {****************************** TLMDUpdateAdapter ****************************}
  TLMDUpdateAdapter = class (TLMDCustomUpdateAdapter)
  published
    property OnCloseRequest;
    property OnProgress;    
    property OnScriptReceive;
    property OnFinish;
    property OnError;
    property OnConfirm;
    property OnInformation;
    property UpdateForm;
    property WebConfig;
    property About;
  end;

implementation
uses
  SysUtils, LMDUtils, LMDProcs, LMDStrings, Math, Forms, StrUtils, LMDWebConst;
var
    FInstance: TLMDUpdateTransport;
(*
{***************************** TLMDUpdateMessage ******************************}
{--------------------------------- public -------------------------------------}
procedure TLMDUpdateMessage.SaveToStream(AStream: TStream);
var
  LInt: Integer;
begin
  AStream.Write(Byte(FMsgType), sizeOf(Byte));

  LInt := Length(FDescr);
  AStream.Write(LInt, sizeOf(Integer));

  LMDStringToStream(FDescr, AStream);

  AStream.Write(FPercent, sizeOf(Byte));

  LInt := Length(FCurFileName);
  AStream.Write(LInt, sizeOf(Integer));
  LMDStringToStream(FCurFileName, AStream);

  AStream.Write(FCurFileSize, sizeOf(LongWord));
  AStream.Write(FTimeEstimateElapsed, SizeOf(LongWord));
  AStream.Write(FErrCode, SizeOf(Integer));
  AStream.Write(FDbID, SizeOf(Integer));
  AStream.Write(FResult, SizeOf(HResult));
  
  LInt := IfThen(Assigned(FWebConfig), 1, 0);
  AStream.Write(LInt, SizeOf(Integer));
  if LInt = 1 then
    AStream.WriteComponent(FWebConfig);
end;

{------------------------------------------------------------------------------}
procedure TLMDUpdateMessage.LoadFromStream(AStream: TStream);
var
  LInt: Integer;
  LString: TLMDString;
  LByte: Byte;
begin
  try
    AStream.Read(LByte, SizeOf(Byte));
    FMsgType := TLMDUpdateMessageType(LByte);

    AStream.Read(LInt, SizeOf(Integer));
    SetLength(LString, LInt);
    LString := LMDStreamToString(AStream, LInt);

    FDescr := LString;
    AStream.Read(FPercent, sizeOf(Byte));
    
    AStream.Read(LInt, SizeOf(Integer));
    SetLength(LString, LInt);
    FCurFileName := LMDStreamToString(AStream, LInt);

    AStream.Read(FCurFileSize, sizeOf(LongWord));
    AStream.Read(FTimeEstimateElapsed, sizeOf(LongWord));
    AStream.Read(FErrCode, SizeOf(Integer));
    AStream.Read(FDbID, SizeOf(Integer));

    AStream.Read(FResult, SizeOf(HResult));
    AStream.Read(LInt, SizeOf(Integer));
    if LInt = 1 then
    begin
      Classes.RegisterClass(TLMDWebConfig);
      FWebConfig := TLMDWebConfig(AStream.ReadComponent(nil));
    end
  except
    raise
      EInOutError.Create('Couldn''t read from stream');
  end;
end;
        *)
        {***************************** TLMDUpdateTransport ****************************}
{---------------------------------- private -----------------------------------}
procedure TLMDUpdateTransport.WndProc(var Message: TMessage);
var
  LMsg: TLMDUpdateMessage;
  LMsgType: TLMDUpdateMessageType;
begin
  if Message.Msg = FMsg then
  begin
    FLinkedWindow := Message.WParam;
    LMsg := TLMDUpdateMessage.Create;
    FChannel.Position := 0;
    LMsg.LoadFromStream(FChannel);
    if Assigned(FOnMessageReceive) then
      FOnMessageReceive(Self, LMsg);
    FChannel.Position := 0;
    LMsg.SaveToStream(FChannel);
    LMsgType := LMsg.MsgType;
    LMsg.Free;
    if LMsgType = umtCloseRequest then
      TerminateProcess(GetCurrentProcess, 0);    
  end
  else
    Dispatch(Message);
end;

{--------------------------------- public -------------------------------------}
constructor TLMDUpdateTransport.Create(AServer: Boolean);
var
  LName: string;
  LLinked: string;
  LMsg: TLMDUpdateMessage;
begin
  inherited Create;

  LName := 'LMD_UPDATE_TRANSPORT' + IfThen(AServer, '_SERVER', '_UPDATER') ;
  FIsServer := AServer;
  LLinked := 'LMD_UPDATE_TRANSPORT' + IfThen(not AServer, '_SERVER', '_UPDATER') ;

  FMsg := RegisterWindowMessage('LMD_UPDATE_MESSAGE');
  FWindow := LMDAllocateHWND(Self, WndProc, LName,
    LName);
  if FIsServer then
    FChannel := TLMDMemoryMappedStream.Create(LMD_CHANNEL_NAME{ + IntToStr(FWindow)}, 102400)
  else
    FChannel := TLMDMemoryMappedStream.Create(LMD_CHANNEL_NAME{ + IntToStr(ALinkedWindow)}, 102400);

  FLinkedWindow := FindWindow(PChar(LLinked), PChar(LLinked));
  if FLinkedWindow <> 0 then
  begin
    LMsg := TLMDUpdateMessage.Create;
    LMsg.MsgType := umtInfo;
    LMsg.Descr := 'Open the channel';
    SendMsg(LMsg);
    LMsg.Free;
  end;

end;

{------------------------------------------------------------------------------}
destructor TLMDUpdateTransport.Destroy;
begin
  LMDDeallocateHWND(FWindow);
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDUpdateTransport.SendMsg(var AMsg: TLMDUpdateMessage): boolean;
begin
  FChannel.Position := 0;
  AMsg.SaveToStream(FChannel);
  Result := Longbool(SendMessage(FLinkedWindow, FMsg, FWindow, 0));
  FChannel.Position := 0;
  AMsg.LoadFromStream(FChannel);
  exit;
end;

class function TLMDUpdateTransport.Instance: TLMDUpdateTransport;
begin
  Result := nil;
  if Assigned(FInstance) then
    Result := FInstance;
end;

class function TLMDUpdateTransport.CreateInstance(AServer: Boolean): TLMDUpdateTransport;
begin
  FInstance := TLMDUpdateTransport.Create(AServer);
  Result := FInstance;
end;

function TLMDUpdateTransport.GetConnected(): Boolean;
begin
  Result := FLinkedWindow <> 0;
end;

procedure TLMDUpdateTransport.SetInstance(AnInstance: TLMDUpdateTransport);
begin
  FInstance := AnInstance;
end;

{**************************** TLMDCustomUpdateAdapter *************************}
{----------------------------------- private ----------------------------------}
function TLMDCustomUpdateAdapter.ExtractFromResource(): boolean;
begin
  Result := True;
  // TODO: ExtractFromResource
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomUpdateAdapter.MessageReceive(Sender: TObject; AMessage: TLMDUpdateMessage);
var
  LResult: HRESULT;
  LBoolean: Boolean;
begin
  if Assigned(FUpdateFrm) then
    FUpdateFrm.OnMessageReceive(Sender, AMessage);
  case AMessage.MsgType of
    umtError:
      begin
        if Assigned(FOnError) then
          FOnError(AMessage.ErrCode, AMessage.Descr);
        if Assigned(FUpdateFrm) then
          FUpdateFrm.SetStatus(IDS_UPDATE_ERROR + ': 0x' + IntToHex(AMessage.ErrCode, 8) + ' ' + AMessage.Descr);
      end;
      umtScript:
      begin
        if Assigned(FOnScriptReceive) then
          FOnScriptReceive(AMessage.DbID, AMessage.Descr);
        if Assigned(FUpdateFrm) then
          FUpdateFrm.SetStatus(IDS_UPDATE_SQL_SCRIPT_RECEIVE);
      end;
      umtFinish:
      begin
        if Assigned(FOnFinish) then
          FOnFinish(Self);
        if Assigned(FUpdateFrm) then
          FUpdateFrm.SetStatus(IDS_UPDATE_FINISH);
      end;
      umtProgress:
      begin
        if Assigned(FOnProgress) then
          FOnProgress(AMessage.Percent, AMessage.CurFileName, AMessage.CurFileSize,
            AMessage.TimeEstimateElapsed);
        if Assigned(FUpdateFrm) then
        begin
          FUpdateFrm.SetStatus(IDS_UPDATE_PROGRESS + ': ' + AMessage.CurFileName);
          FUpdateFrm.SetProgressiveBarValue(AMessage.Percent);
        end;
      end;
      umtGetConfig:
      begin
        if Assigned(FWebConfig) then
          if TLMDUpdateTransport.Instance <> nil  then
          begin
            AMessage.WebConfig := FWebConfig;
            AMessage.CurFileName := Application.ExeName;
          end;
        if Assigned(FUpdateFrm) then
          FUpdateFrm.SetStatus(IDS_UPDATE_GETCONFIG);
      end;
      umtConfirm:
      begin
        if Assigned(FUpdateFrm) then
          FUpdateFrm.SetStatus(IDS_UPDATE_WAITING_FOR_INTERACTIVE_CONFIRM);
          if Assigned(FOnConfirm) then
        begin
          FOnConfirm(Self, AMessage.Descr, LResult);
          AMessage.Result := LResult;
          if AMessage.Result = ID_CANCEL then
            AMessage.Result := ID_ABORT;
        end;
      end;
    umtInfo:
      begin
        if Assigned(FOnInformation) then
          FOnInformation(AMessage.Descr);

        if Assigned(FUpdateFrm) then
          FUpdateFrm.SetStatus(IDS_UPDATE_INFORMATION + ': ' + AMessage.Descr);

      end;
    umtCloseRequest:
      begin
        LBoolean := False;

        if Assigned(FUpdateFrm) then
          FUpdateFrm.SetStatus(IDS_UPDATE_CLOSEHOST);

        if Assigned(FOnCloseRequest) then
          FOnCloseRequest(LBoolean);
        AMessage.CurFileName := Application.ExeName;
        AMessage.Result := Windows.LRESULT(LBoolean);
      end;
  end;
end;
{----------------------------------- protected --------------------------------}
procedure TLMDCustomUpdateAdapter.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FUpdateFrm) then
    FUpdateFrm := nil;
end;  
{----------------------------------- public -----------------------------------}
function TLMDCustomUpdateAdapter.CheckForUpdate(): boolean;
var
  LAppPath: string;
begin
  Result := False;
  if not ExtractFromResource() then exit;
  LAppPath := GetCurrentDir + '\lmdupdate.exe';
  if not FileExists(LAppPath) then
  begin
    raise
      EPackageError.Create('Couldn''t find LMDAutoUpdate component');
      exit;
  end;
  {.$MESSAGE WARN 'Replace WinExec by CreateProcess'}
  LMDWebExecuteFile(LAppPath, False);
  (* if WinExec(PAnsiChar(LAppPath), SW_NORMAL) > 31 then *)
  Result := true;
end;

{------------------------------------------------------------------------------}
function TLMDCustomUpdateAdapter.BreakUpdate(ARolledback: boolean): boolean;
var
  LMsg: TLMDUpdateMessage;
begin
  LMsg := TLMDUpdateMessage.Create;
  LMsg.MsgType := umtBreakUpdate;
  Result := True;
  if TLMDUpdateTransport.Instance <> nil then
    TLMDUpdateTransport.Instance.SendMsg(LMsg)
end;

{------------------------------------------------------------------------------}
constructor TLMDCustomUpdateAdapter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if csDesigning in ComponentState then
     exit;
  TLMDUpdateTransport.CreateInstance(True);
//  FTransport := TLMDUpdateTransport.Create(true);
  TLMDUpdateTransport.Instance.OnMessageReceive := MessageReceive;
//  FTransport.OnMessageReceive := MessageReceive;
end;

end.
