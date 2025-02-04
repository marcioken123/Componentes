// a FREEWARE Delphi Component
// TComPort component, version 1.5
// for Delphi 2.0, 3.0, 4.0
// written by Dejan Crnila, 1998-1999
// email: emilija.crnila@guest.arnes.si, dejan@macek.si

unit Comms;

interface

uses
  Windows, Classes, SysUtils, GenAlg;

type
  TBaudRate = (br110, br300, br600, br1200, br2400, br4800, br9600,
               br14400, br19200, br38400, br56000, br57600, br115200);
  TPortType = (COM1, COM2, COM3, COM4);
  TStopBits = (sbOneStopBit, sbOne5StopBits, sbTwoStopBits);
  TParity = (prNone, prOdd, prEven, prMark, prSpace);
  TDtrFlowControl = (dtrDisable, dtrEnable, dtrHandshake);
  TRtsFlowControl = (rtsDisable, rtsEnable, rtsHandshake, rtsToggle);
  TEvent = (evRxChar, evTxEmpty, evRxFlag, evRing, evBreak, evCTS,
            evDSR, evError, evRLSD, evRx80Full);

  TEvents = set of TEvent;

  TRxCharEvent = procedure(Sender: TObject; InQue: DWORD) of object;

  TComPort = class;

  TComThread = class(TThread)
  private
    Owner: TComPort;
    Mask: DWORD;
    StopEvent: THandle;
  protected
    procedure Execute; override;
    procedure DoEvents;
    procedure Stop;
  public
    constructor Create(AOwner: TComPort);
    destructor Destroy; override;
  end;

  TComTimeouts = class(TPersistent)
  private
    FRdIntervalTO: Integer;
    FRdTotalTOMultiplier: Integer;
    FRdTotalTOConstant: Integer;
    FWrTotalTOMultiplier: Integer;
    FWrTotalTOConstant: Integer;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create;
  published
    property RdIntervalTO: Integer read FRdIntervalTO write FRdIntervalTO;
    property RdTotalTOMultiplier: Integer
           read FRdTotalTOMultiplier write FRdTotalTOMultiplier;
    property RdTotalTOConstant: Integer
           read FRdTotalTOConstant write FRdTotalTOConstant;
    property WrTotalTOMultiplier: Integer
           read FWrTotalTOMultiplier write FWrTotalTOMultiplier;
    property WrTotalTOConstant: Integer
           read FWrTotalTOConstant write FWrTotalTOConstant;
  end;

  TFlowControl = class(TPersistent)
  private
    FOutCtsFlow: Boolean;
    FOutDsrFlow: Boolean;
    FControlDtr: TDtrFlowControl;
    FControlRts: TRtsFlowControl;
    FXonXoffOut: Boolean;
    FXonXoffIn:  Boolean;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  published
    property OutCtsFlow: Boolean read FOutCtsFlow write FOutCtsFlow;
    property OutDsrFlow: Boolean read FOutDsrFlow write FOutDsrFlow;
    property ControlDtr: TDtrFlowControl read FControlDtr write FControlDtr;
    property ControlRts: TRtsFlowControl read FControlRts write FControlRts;
    property XonXoffOut: Boolean read FXonXoffOut write FXonXoffOut;
    property XonXoffIn:  Boolean read FXonXoffIn write FXonXoffIn;
  end;

  TComPort = class(TComponent)
  private
    EventThread: TComThread;
    ThreadCreated: Boolean;
    Stack: TStack;
    FHandle: THandle;
    FConnected: Boolean;
    FBaudRate: TBaudRate;
    FPortType: TPortType;
    FParity: TParity;
    FStopBits: TStopBits;
    FDataBits: Byte;
    FEvents: TEvents;
    FWriteBufSize: DWORD;
    FReadBufSize: DWORD;
    FTimeouts: TComTimeouts;
    FFlowControl: TFlowControl;
    FOnRxChar: TRxCharEvent;
    FOnTxEmpty: TNotifyEvent;
    FOnBreak: TNotifyEvent;
    FOnRing: TNotifyEvent;
    FOnCTS: TNotifyEvent;
    FOnDSR: TNotifyEvent;
    FOnRLSD: TNotifyEvent;
    FOnError: TNotifyEvent;
    FOnRxFlag: TNotifyEvent;
    FOnOpen: TNotifyEvent;
    FOnClose: TNotifyEvent;
    FOnRx80Full: TNotifyEvent;
    procedure InitOverlapped(var PO: POverlapped);
    procedure DoneOverlapped(var PO: POverlapped);
    procedure SetDataBits(Value: Byte);
    function ComString: String;
    procedure DoOnRxChar;
    procedure DoOnTxEmpty;
    procedure DoOnBreak;
    procedure DoOnRing;
    procedure DoOnRxFlag;
    procedure DoOnCTS;
    procedure DoOnDSR;
    procedure DoOnError;
    procedure DoOnRLSD;
    procedure DoOnRx80Full;
  protected
    procedure CreateHandle;
    procedure DestroyHandle;
    procedure SetupState;
    function ValidHandle: Boolean;
  public
    property Connected: Boolean read FConnected;
    property Handle: THandle read FHandle write FHandle;
    procedure Open;
    procedure Close;
    function InQue: DWORD;
    function OutQue: DWORD;
    function ActiveCTS: Boolean;
    function ActiveDSR: Boolean;
    function ActiveRLSD: Boolean;
    function Write(var Buffer; Count: DWORD; WaitFor: Boolean): DWORD;
    function WriteString(Str: String; WaitFor: Boolean): DWORD;
    function Read(var Buffer; Count: DWORD; WaitFor: Boolean): DWORD;
    function ReadString(var Str: String; Count: DWORD; WaitFor: Boolean): DWORD;
    procedure PurgeIn;
    procedure PurgeOut;
    function PendingIO: Boolean;
    function WaitForLastIO: DWORD;
    procedure AbortAllIO;
    procedure ShowPropForm;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property BaudRate: TBaudRate read FBaudRate write FBaudRate;
    property Port: TPortType read FPortType write FPortType;
    property Parity: TParity read FParity write FParity;
    property StopBits: TStopBits read FStopBits write FStopBits;
    property DataBits: Byte read FDataBits write SetDataBits;
    property Events: TEvents read FEvents write FEvents;
    property WriteBufSize: DWORD read FWriteBufSize write FWriteBufSize;
    property ReadBufSize: DWORD read FReadBufSize write FReadBufSize;
    property FlowControl: TFlowControl read FFlowControl write FFlowControl;
    property Timeouts: TComTimeouts read FTimeouts write FTimeouts;
    property OnTxEmpty: TNotifyEvent read FOnTxEmpty write FOnTxEmpty;
    property OnBreak: TNotifyEvent read FOnBreak write FOnBreak;
    property OnRing: TNotifyEvent read FOnRing write FOnRing;
    property OnCTS: TNotifyEvent read FOnCTS write FOnCTS;
    property OnDSR: TNotifyEvent read FOnDSR write FOnDSR;
    property OnRLSD: TNotifyEvent read FOnRLSD write FOnRLSD;
    property OnRxChar: TRxCharEvent read FOnRxChar write FOnRxChar;
    property OnRxFlag: TNotifyEvent read FOnRxFlag write FOnRxFlag;
    property OnError: TNotifyEvent read FOnError write FOnError;
    property OnOpen: TNotifyEvent read FOnOpen write FOnOpen;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnRx80Full: TNotifyEvent read FOnRx80Full write FOnRx80Full;
  end;

  EComPort   = class(Exception);
  EComHandle = class(EComPort);
  EComState  = class(EComPort);
  EComIO     = class(EComPort);
  EComStatus = class(EComPort);
  EComPurge  = class(EComPort);

const
  dcb_Binary           = $00000001;
  dcb_Parity           = $00000002;
  dcb_OutxCtsFlow      = $00000004;
  dcb_OutxDsrFlow      = $00000008;
  dcb_DtrControl       = $00000030;
  dcb_DsrSensivity     = $00000040;
  dcb_TXContinueOnXOff = $00000080;
  dcb_OutX             = $00000100;
  dcb_InX              = $00000200;
  dcb_ErrorChar        = $00000400;
  dcb_Null             = $00000800;
  dcb_RtsControl       = $00003000;
  dcb_AbortOnError     = $00004000;

  NOT_FINISHED         = $FFFFFFFF;
  NO_OPERATION         = $FFFFFFFE;

procedure Register;

implementation

uses
  DesignIntf, CommForm, Controls;

type
  TComPortEditor = class(TComponentEditor)
  private
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

function LastErr: String;
begin
  Result := IntToStr(GetLastError);
end;

function GetTOValue(Value: Integer): DWORD;
begin
  if Value = -1 then
    Result := MAXDWORD
  else
    Result := Value;
end;

// TComThread

constructor TComThread.Create(AOwner: TComPort);
var
  AMask: DWORD;
begin
  inherited Create(True);
  StopEvent := CreateEvent(nil, True, False, nil);
  Owner := AOwner;
  AMask := 0;
  if evRxChar in Owner.FEvents then AMask := AMask or EV_RXCHAR;
  if evRxFlag in Owner.FEvents then AMask := AMask or EV_RXFLAG;
  if evTxEmpty in Owner.FEvents then AMask := AMask or EV_TXEMPTY;
  if evRing in Owner.FEvents then AMask := AMask or EV_RING;
  if evCTS in Owner.FEvents then AMask := AMask or EV_CTS;
  if evDSR in Owner.FEvents then AMask := AMask or EV_DSR;
  if evRLSD in Owner.FEvents then AMask := AMask or EV_RLSD;
  if evError in Owner.FEvents then AMask := AMask or EV_ERR;
  if evBreak in Owner.FEvents then AMask := AMask or EV_BREAK;
  if evRx80Full in Owner.FEvents then AMask := AMask or EV_RX80FULL;
  SetCommMask(Owner.FHandle, AMask);
  Resume;
end;

procedure TComThread.Execute;
var
  EventHandles: Array[0..1] of THandle;
  Overlapped: TOverlapped;
  Signaled, BytesTrans: DWORD;
begin
  FillChar(Overlapped, SizeOf(Overlapped), 0);
  Overlapped.hEvent := CreateEvent(nil, True, True, nil);
  EventHandles[0] := StopEvent;
  EventHandles[1] := Overlapped.hEvent;
  repeat
    WaitCommEvent(Owner.FHandle, Mask, @Overlapped);
    Signaled := WaitForMultipleObjects(2, @EventHandles, False, INFINITE);
    case Signaled of
      WAIT_OBJECT_0: Break;
      WAIT_OBJECT_0 + 1: if GetOverlappedResult(Owner.FHandle, Overlapped,
                              BytesTrans, False) then Synchronize(DoEvents);
      else Break;
    end;
  until False;
  Owner.PurgeIn;
  Owner.PurgeOut;
  CloseHandle(Overlapped.hEvent);
  CloseHandle(StopEvent);
end;

procedure TComThread.Stop;
begin
  SetEvent(StopEvent);
end;

destructor TComThread.Destroy;
begin
  Stop;
  inherited Destroy;
end;

procedure TComThread.DoEvents;
begin
  if (EV_RXCHAR and Mask) > 0 then Owner.DoOnRxChar;
  if (EV_TXEMPTY and Mask) > 0 then Owner.DoOnTxEmpty;
  if (EV_BREAK and Mask) > 0 then Owner.DoOnBreak;
  if (EV_RING and Mask) > 0 then Owner.DoOnRing;
  if (EV_CTS and Mask) > 0 then Owner.DoOnCTS;
  if (EV_DSR and Mask) > 0 then Owner.DoOnDSR;
  if (EV_RXFLAG and Mask) > 0 then Owner.DoOnRxFlag;
  if (EV_RLSD and Mask) > 0 then Owner.DoOnRLSD;
  if (EV_ERR and Mask) > 0 then Owner.DoOnError;
  if (EV_RX80FULL and Mask) > 0 then Owner.DoOnRx80Full;
end;

// TComTimeouts

constructor TComTimeouts.Create;
begin
  FRdIntervalTO := -1;
  FWrTotalTOMultiplier := 100;
  FWrTotalTOConstant := 1000;
end;

procedure TComTimeouts.AssignTo(Dest: TPersistent);
begin
  if Dest is TComTimeouts then begin
    with TComTimeouts(Dest) do begin
      FRdIntervalTO := Self.FRdIntervalTO;
      FRdTotalTOMultiplier := Self.FRdTotalTOMultiplier;
      FRdTotalTOConstant := Self.FRdTotalTOConstant;
      FWrTotalTOMultiplier := Self.FWrTotalTOMultiplier;
      FWrTotalTOConstant := Self.FWrTotalTOConstant;
    end
  end
  else
    inherited AssignTo(Dest);
end;

// TFlowControl

procedure TFlowControl.AssignTo(Dest: TPersistent);
begin
  if Dest is TFlowControl then begin
    with TFlowControl(Dest) do begin
      FOutCtsFlow := Self.FOutCtsFlow;
      FOutDsrFlow := Self.FOutDsrFlow;
      FControlDtr := Self.FControlDtr;
      FControlRts := Self.FControlRts;
      FXonXoffOut := Self.FXonXoffOut;
      FXonXoffIn  := Self.FXonXoffIn;
    end
  end
  else
    inherited AssignTo(Dest);
end;

// TComPort

constructor TComPort.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FConnected := False;
  FBaudRate := br9600;
  FParity := prNone;
  FPortType := COM1;
  FStopBits := sbOneStopBit;
  FDataBits := 8;
  FEvents := [evRxChar, evTxEmpty, evRxFlag, evRing, evBreak,
             evCTS, evDSR, evError, evRLSD, evRx80Full];
  FWriteBufSize := 1024;
  FReadBufSize := 1024;
  FHandle := INVALID_HANDLE_VALUE;
  FFlowControl := TFlowControl.Create;
  FTimeouts := TComTimeouts.Create;
  Stack := TStack.Create;
end;

destructor TComPort.Destroy;
begin
  Close;
  Stack.Free;
  FFlowControl.Free;
  FTimeouts.Free;
  inherited Destroy;
end;

procedure TComPort.CreateHandle;
begin
  FHandle := CreateFile(
    PChar(ComString),
    GENERIC_READ or GENERIC_WRITE,
    0,
    nil,
    OPEN_EXISTING,
    FILE_FLAG_OVERLAPPED,
    0);

  if not ValidHandle then
    raise EComHandle.Create('Unable to open com port: ' + LastErr);
end;

procedure TComPort.DestroyHandle;
begin
  if ValidHandle then
    CloseHandle(FHandle);
end;

function TComPort.ValidHandle: Boolean;
begin
  if FHandle = INVALID_HANDLE_VALUE then
    Result := False
  else
    Result := True;
end;

procedure TComPort.Open;
begin
  Close;
  CreateHandle;
  SetupState;
  if FEvents = [] then
    ThreadCreated := False
  else begin
    EventThread := TComThread.Create(Self);
    ThreadCreated := True;
  end;
  FConnected := True;
  if Assigned(FOnOpen) then FOnOpen(Self);
end;

procedure TComPort.Close;
begin
  if FConnected then begin
    if not Stack.IsEmpty then
      MessageBox(0, 'Hhe', 'MB_OK', MB_OK);
    AbortAllIO;
    if ThreadCreated then
      EventThread.Free;
    DestroyHandle;
    FConnected := False;
    if Assigned(FOnClose) then
      FOnClose(Self);
  end;
end;

procedure TComPort.SetupState;
var
  DCB: TDCB;
  Timeouts: TCommTimeouts;
  Temp: DWORD;
begin
  if not SetupComm(FHandle, FReadBufSize, FWriteBufSize) then
    raise EComState.Create('Unable to set com state: ' + LastErr);

  FillChar(DCB, SizeOf(DCB), 0);

  DCB.DCBlength := SizeOf(DCB);
  DCB.XonChar := #17;
  DCB.XoffChar := #19;
  DCB.XonLim := FWriteBufSize div 4;
  DCB.XoffLim := 1;

  DCB.Flags := DCB.Flags or dcb_Binary or dcb_Null;
  if FParity <> prNone then
    DCB.Flags := DCB.Flags or dcb_Parity;

  with FFlowControl do begin
    if FOutCtsFlow then
      DCB.Flags := DCB.Flags or dcb_OutxCtsFlow;
    if FOutDsrFlow then
      DCB.Flags := DCB.Flags or dcb_OutxDsrFlow;
    Temp := 0;
    case FControlDtr of
      dtrDisable:   Temp := DTR_CONTROL_DISABLE;
      dtrEnable:    Temp := DTR_CONTROL_ENABLE;
      dtrHandshake: Temp := DTR_CONTROL_HANDSHAKE;
    end;
    DCB.Flags := DCB.Flags or Integer(dcb_DtrControl and (Temp shl 4));
    case FControlRts of
      rtsDisable:   Temp := RTS_CONTROL_DISABLE;
      rtsEnable:    Temp := RTS_CONTROL_ENABLE;
      rtsHandshake: Temp := RTS_CONTROL_HANDSHAKE;
      rtsToggle:    Temp := RTS_CONTROL_TOGGLE;
    end;
    DCB.Flags := DCB.Flags or Integer((dcb_RtsControl and (Temp shl 12)));
    if FXonXoffOut then
      DCB.Flags := DCB.Flags or dcb_OutX;
    if FXonXoffIn then
      DCB.Flags := DCB.Flags or dcb_InX;
  end;

  case FParity of
    prNone:  DCB.Parity := NOPARITY;
    prOdd:   DCB.Parity := ODDPARITY;
    prEven:  DCB.Parity := EVENPARITY;
    prMark:  DCB.Parity := MARKPARITY;
    prSpace: DCB.Parity := SPACEPARITY;
  end;

  case FStopBits of
    sbOneStopBit:   DCB.StopBits := ONESTOPBIT;
    sbOne5StopBits: DCB.StopBits := ONE5STOPBITS;
    sbTwoStopBits:  DCB.StopBits := TWOSTOPBITS;
  end;

  case FBaudRate of
    br110:    DCB.BaudRate := CBR_110;
    br300:    DCB.BaudRate := CBR_300;
    br600:    DCB.BaudRate := CBR_600;
    br1200:   DCB.BaudRate := CBR_1200;
    br2400:   DCB.BaudRate := CBR_2400;
    br4800:   DCB.BaudRate := CBR_4800;
    br9600:   DCB.BaudRate := CBR_9600;
    br14400:  DCB.BaudRate := CBR_14400;
    br19200:  DCB.BaudRate := CBR_19200;
    br38400:  DCB.BaudRate := CBR_38400;
    br56000:  DCB.BaudRate := CBR_56000;
    br57600:  DCB.BaudRate := CBR_57600;
    br115200: DCB.BaudRate := CBR_115200;
  end;

  DCB.ByteSize := FDataBits;

  if not SetCommState(FHandle, DCB) then
    raise EComState.Create('Unable to set com state: ' + LastErr);

  if not GetCommTimeouts(FHandle, Timeouts) then
    raise EComState.Create('Unable to set com state: ' + LastErr);

  Timeouts.ReadIntervalTimeout := GetTOValue(FTimeouts.FRdIntervalTO);
  Timeouts.ReadTotalTimeoutMultiplier := GetTOValue(FTimeouts.FRdTotalTOMultiplier);
  Timeouts.ReadTotalTimeoutConstant := GetTOValue(FTimeouts.FRdTotalTOConstant);
  Timeouts.WriteTotalTimeoutMultiplier := GetTOValue(FTimeouts.FWrTotalTOMultiplier);
  Timeouts.WriteTotalTimeoutConstant := GetTOValue(FTimeouts.FWrTotalTOConstant);

  if not SetCommTimeouts(FHandle, Timeouts) then
    raise EComState.Create('Unable to set com state: ' + LastErr);
end;

function TComPort.InQue: DWORD;
var
  Errors: DWORD;
  ComStat: TComStat;
begin
  if not ClearCommError(FHandle, Errors, @ComStat) then
    raise EComStatus.Create('Unable to read com status: ' + LastErr);
  Result := ComStat.cbInQue;
end;

function TComPort.OutQue: DWORD;
var
  Errors: DWORD;
  ComStat: TComStat;
begin
  if not ClearCommError(FHandle, Errors, @ComStat) then
    raise EComStatus.Create('Unable to read com status: ' + LastErr);
  Result := ComStat.cbOutQue;
end;

function TComPort.ActiveCTS: Boolean;
var
  Errors: DWORD;
  ComStat: TComStat;
begin
  if not ClearCommError(FHandle, Errors, @ComStat) then
    raise EComStatus.Create('Unable to read com status: ' + LastErr);
  Result := not (fCtlHold in ComStat.Flags);
end;

function TComPort.ActiveDSR: Boolean;
var
  Errors: DWORD;
  ComStat: TComStat;
begin
  if not ClearCommError(FHandle, Errors, @ComStat) then
    raise EComStatus.Create('Unable to read com status: ' + LastErr);
  Result := not (fDsrHold in ComStat.Flags);
end;

function TComPort.ActiveRLSD: Boolean;
var
  Errors: DWORD;
  ComStat: TComStat;
begin
  if not ClearCommError(FHandle, Errors, @ComStat) then
    raise EComStatus.Create('Unable to read com status: ' + LastErr);
  Result := not (fRlsHold in ComStat.Flags);
end;

function TComPort.Write(var Buffer; Count: DWORD; WaitFor: Boolean): DWORD;
var
  Success, Pending: Boolean;
  ErrCode, BytesTrans: DWORD;
  PO: POverlapped;
begin
  InitOverlapped(PO);
  Stack.Push(PO);
  Pending := False;

  Success := WriteFile(FHandle, Buffer, Count, BytesTrans, PO);
  if not Success then begin
    ErrCode := GetLastError;
    if ErrCode = ERROR_IO_PENDING then begin
      if WaitFor then begin
        BytesTrans := WaitForLastIO;
        Success := True;
      end
      else
        Pending := True;
    end;
  end else
    if WaitFor then begin
      PO := Stack.Pop;
      DoneOverlapped(PO);
    end;

  if not (Success or Pending) then
    raise EComIO.Create('Operation failed: ' + LastErr);

  if Pending then
    Result := NOT_FINISHED
  else
    Result := BytesTrans;
end;

function TComPort.WriteString(Str: String; WaitFor: Boolean): DWORD;
var
  Success, Pending: Boolean;
  ErrCode, BytesTrans: DWORD;
  PO: POverlapped;
begin
  InitOverlapped(PO);
  Stack.Push(PO);
  Pending := False;

  Success := WriteFile(FHandle, Str[1], Length(Str), BytesTrans, PO);
  if not Success then begin
    ErrCode := GetLastError;
    if ErrCode = ERROR_IO_PENDING then begin
      if WaitFor then begin
        BytesTrans := WaitForLastIO;
        Success := True;
      end else
        Pending := True;
    end;
  end else
    if WaitFor then begin
      PO := Stack.Pop;
      DoneOverlapped(PO);
    end;

  if not (Success or Pending) then
    raise EComIO.Create('Operation failed: ' + LastErr);

  if Pending then
    Result := NOT_FINISHED
  else
    Result := BytesTrans;
end;

function TComPort.Read(var Buffer; Count: DWORD; WaitFor: Boolean): DWORD;
var
  Success, Pending: Boolean;
  ErrCode, BytesTrans: DWORD;
  PO: POverlapped;
begin
  InitOverlapped(PO);
  Stack.Push(PO);
  Pending := False;

  Success := ReadFile(FHandle, Buffer, Count, BytesTrans, PO);
  if not Success then begin
    ErrCode := GetLastError;
    if ErrCode = ERROR_IO_PENDING then begin
      if WaitFor then begin
        BytesTrans := WaitForLastIO;
        Success := True;
      end else
        Pending := True;
    end;
  end else
    if WaitFor then begin
      PO := Stack.Pop;
      DoneOverlapped(PO);
    end;

  if not (Success or Pending) then
    raise EComIO.Create('Operation failed: ' + LastErr);

  if Pending then
    Result := NOT_FINISHED
  else
    Result := BytesTrans;
end;

function TComPort.ReadString(var Str: String; Count: DWORD; WaitFor: Boolean): DWORD;
var
  Success, Pending: Boolean;
  ErrCode, BytesTrans: DWORD;
  PO: POverlapped;
begin
  SetLength(Str, Count);

  InitOverlapped(PO);
  Stack.Push(PO);
  Pending := False;

  Success := ReadFile(FHandle, Str[1], Count, BytesTrans, PO);
  if not Success then begin
    ErrCode := GetLastError;
    if ErrCode = ERROR_IO_PENDING then begin
      if WaitFor then begin
        BytesTrans := WaitForLastIO;
        Success := True;
      end else
        Pending := True;
    end;
  end else
    if WaitFor then begin
      PO := Stack.Pop;
      DoneOverlapped(PO);
    end;

  if not (Success or Pending) then
    raise EComIO.Create('Operation aborted: ' + LastErr);

  if Pending then
    Result := NOT_FINISHED
  else
    Result := BytesTrans;
end;

procedure TComPort.PurgeIn;
begin
  if not PurgeComm(FHandle, PURGE_RXABORT or PURGE_RXCLEAR) then
    raise EComPurge.Create('Unable to purge com: ' + LastErr);
end;

procedure TComPort.PurgeOut;
begin
  if not PurgeComm(FHandle, PURGE_TXABORT or PURGE_TXCLEAR) then
    raise EComPurge.Create('Unable to purge com: ' + LastErr);
end;

function TComPort.PendingIO: Boolean;
begin
  Result := not Stack.IsEmpty;
end;

function TComPort.WaitForLastIO: DWORD;
var
  Signaled, BytesTrans: DWORD;
  Success: Boolean;
  PO: POverlapped;
begin
  if PendingIO then begin
    PO := Stack.Pop;
    Signaled := WaitForSingleObject(PO^.hEvent, INFINITE);

    Success := (Signaled = WAIT_OBJECT_0) and
          (GetOverlappedResult(FHandle, PO^, BytesTrans, False));

    DoneOverlapped(PO);
    if Success then
      Result := BytesTrans
    else
      raise EComIO.Create('Operation failed: ' + LastErr);
  end else
    Result := NO_OPERATION;
end;

procedure TComPort.AbortAllIO;
var
  PO: POverlapped;
begin
  if PendingIO then begin
    try
      if not CancelIO(FHandle) then
        raise EComIO.Create('Cannot abort operation: ' + LastErr);
    finally
      while (not Stack.IsEmpty) do begin
        PO := Stack.Pop;
        DoneOverlapped(PO);
      end;
    end;
  end;
end;

procedure TComPort.ShowPropForm;
begin
  with TCommFrm.Create(nil) do begin
    ComboBox1.ItemIndex := Integer(Port);
    ComboBox2.ItemIndex := Integer(BaudRate);
    ComboBox3.ItemIndex := Integer(StopBits);
    ComboBox4.ItemIndex := DataBits - 5;
    ComboBox5.ItemIndex := Integer(Parity);
    CheckBox1.Checked := FFlowControl.FOutCtsFlow;
    CheckBox2.Checked := FFlowControl.FOutDsrFlow;
    CheckBox3.Checked := FFlowControl.FXonXoffOut;
    CheckBox4.Checked := FFlowControl.FXonXoffIn;
    RadioGroup1.ItemIndex := Integer(FFlowControl.FControlRts);
    RadioGroup2.ItemIndex := Integer(FFlowControl.FControlDtr);
    if ShowModal = mrOK then begin
      Port := TPortType(ComboBox1.ItemIndex);
      BaudRate := TBaudRate(ComboBox2.ItemIndex);
      StopBits := TStopBits(ComboBox3.ItemIndex);
      DataBits := ComboBox4.ItemIndex + 5;
      Parity := TParity(ComboBox5.ItemIndex);
      FFlowControl.FOutCtsFlow := CheckBox1.Checked;
      FFlowControl.FOutDsrFlow := CheckBox2.Checked;
      FFlowControl.FXonXoffOut := CheckBox3.Checked;
      FFlowControl.FXonXoffIn := CheckBox4.Checked;
      FFlowControl.FControlRts := TRtsFlowControl(RadioGroup1.ItemIndex);
      FFlowControl.FControlDtr := TDtrFlowControl(RadioGroup2.ItemIndex);
    end;
    Free;
  end;
end;

procedure TComPort.InitOverlapped(var PO: POverlapped);
begin
  New(PO);
  FillChar(PO^, SizeOf(TOverlapped), 0);
  PO^.hEvent := CreateEvent(nil, True, False, nil);
end;

procedure TComPort.DoneOverlapped(var PO: POverlapped);
begin
  CloseHandle(PO^.hEvent);
  Dispose(PO);
end;

procedure TComPort.SetDataBits(Value: Byte);
begin
  if Value <> FDataBits then
    if Value > 8 then FDataBits := 8 else
      if Value < 5 then FDataBits := 5 else
        FDataBits := Value;
end;

procedure TComPort.DoOnRxChar;
begin
  if Assigned(FOnRxChar) then FOnRxChar(Self, InQue);
end;

procedure TComPort.DoOnBreak;
begin
  if Assigned(FOnBreak) then FOnBreak(Self);
end;

procedure TComPort.DoOnRing;
begin
  if Assigned(FOnRing) then FOnRing(Self);
end;

procedure TComPort.DoOnTxEmpty;
begin
  if Assigned(FOnTxEmpty) then FOnTxEmpty(Self);
end;

procedure TComPort.DoOnCTS;
begin
  if Assigned(FOnCTS) then FOnCTS(Self);
end;

procedure TComPort.DoOnDSR;
begin
  if Assigned(FOnDSR) then FOnDSR(Self);
end;

procedure TComPort.DoOnRLSD;
begin
  if Assigned(FOnRLSD) then FOnRLSD(Self);
end;

procedure TComPort.DoOnError;
begin
  if Assigned(FOnError) then FOnError(Self);
end;

procedure TComPort.DoOnRxFlag;
begin
  if Assigned(FOnRxFlag) then FOnRxFlag(Self);
end;

procedure TComPort.DoOnRx80Full;
begin
  if Assigned(FOnRx80Full) then FOnRx80Full(Self);
end;

function TComPort.ComString: String;
begin
  case FPortType of
    COM1: Result := 'COM1';
    COM2: Result := 'COM2';
    COM3: Result := 'COM3';
    COM4: Result := 'COM4';
  end;
end;

// TComPortEditor;

procedure TComPortEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then begin
    (Component as TComPort).ShowPropForm;
    Designer.Modified;
  end;
end;

function TComPortEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Edit Properties';
  end;
end;

function TComPortEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

procedure Register;
begin
  RegisterComponents('Domani', [TComPort]);
  RegisterComponentEditor(TComPort, TComPortEditor);
end;

end.
