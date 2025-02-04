(*
  This file is a part of Audio Components Suite v 2.3,
  Copyright (c) 2002-2005 Andrei Borovsky. All rights reserved.
  See the LICENSE file for more details.
  You can contact me at acs@compiler4.net
*)

unit ACS_Classes;

interface

uses

{$IFDEF WIN32}
  Windows,
{$ENDIF}
  Classes, SysUtils;

type

  TOutputStatus = (tosPlaying, tosPaused, tosIdle);

  TFileOutputMode = (foRewrite = 0, foAppend);

  TOutputFunc = function(Abort : Boolean):Boolean of object;

  //TThreadDoneEvent = procedure of object;

  TThreadExceptionEvent = procedure(Sender : TComponent; E : Exception) of object;

  THandleThreadException = procedure(E : Exception) of object;

  TOutputDoneEvent = procedure(Sender : TComponent) of object;

  TOutputProgressEvent = procedure(Sender : TComponent) of object;

{$IFDEF LINUX}
// File access mask constants
const

  famUserRead = 64;
  famUserWrite = 128;
  famGroupRead = 8;
  famGroupWrite = 16;
  famOthersRead = 1;
  famOthersWrite = 2;

{$ENDIF}

type

  EACSException = class(Exception)
  end;

  TACSThread = class(TThread)
  private
    procedure CallOnProgress;
  public
    Parent : TObject;
    bSuspend, Terminating : Boolean;
    Stop : Boolean;
    HandleException : THandleThreadException;
    Delay : Integer;
{$IFDEF WIN32}
    CS : TRTLCriticalSection;
{$ENDIF}
    procedure Execute; override;
  end;

  TVerySmallThread = class(TThread)
  public
    FOnDone  : TOutputDoneEvent;
    Sender : TComponent;
    procedure Execute; override;
    procedure CallOnDone;
  end;

  TACSInput = class(TComponent)
  protected
    FPosition : Integer;
    FSize : Integer;
    Busy : Boolean;
    BufStart, BufEnd : Integer;
    (* We don't declare the buffer variable here
     because different descendants may need different buffer sizes *)
    function GetBPS : Integer; virtual; abstract;
    function GetCh : Integer; virtual; abstract;
    function GetSR : Integer; virtual; abstract;
    function GetTotalTime : Integer; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetData(Buffer : Pointer; BufferSize : Integer): Integer; virtual; abstract;
    procedure Reset; virtual;
    procedure Init; virtual; abstract;
    procedure Flush; virtual; abstract;
    property BitsPerSample : Integer read GetBPS;
    property Position : Integer read FPosition;
    property SampleRate : Integer read GetSR;
    property Channels : Integer read GetCh;
    property Size : Integer read FSize;
    property TotalTime : Integer read GetTotalTime;
  end;

  TACSOutput = class(TComponent)
  protected
    CanOutput : Boolean;
    CurProgr : Integer;
    Thread : TACSThread;
    FInput : TACSInput;
    FOnDone : TOutputDoneEvent;
    FOnProgress : TOutputProgressEvent;
    Busy : Boolean;  // Set to true by Run and to False by WhenDone.
    FOnThreadException : TThreadExceptionEvent;
    InputLock : Boolean;
    function GetPriority : {$IFDEF LINUX} Integer; {$ENDIF} {$IFDEF WIN32} TThreadPriority; {$ENDIF}
    function GetSuspend : Boolean;
    function GetProgress : Integer;
    procedure SetInput(vInput : TACSInput); virtual;
    procedure SetPriority(Priority : {$IFDEF LINUX} Integer {$ENDIF} {$IFDEF WIN32} TThreadPriority {$ENDIF});
    procedure SetSuspend(v : Boolean);
    procedure WhenDone;
    function GetTE : Integer;
    function GetStatus : TOutputStatus;
    function DoOutput(Abort : Boolean):Boolean; virtual; abstract;
    procedure Done; virtual; abstract; // Calls FInput.Flush
    procedure Prepare; virtual; abstract; // Calls FInput.init
    function GetDelay : Integer;
    procedure SetDelay(Value : Integer);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure HandleThreadException(E : Exception);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$IFDEF WIN32}
    procedure Abort;
    {$ENDIF}
    procedure Pause;
    procedure Resume;
    procedure Run;
    procedure Stop;
    property Delay : Integer read GetDelay write SetDelay;
    property ThreadPriority : {$IFDEF LINUX} Integer {$ENDIF} {$IFDEF WIN32} TThreadPriority {$ENDIF} read GetPriority write SetPriority;
    property Progress : Integer read GetProgress;
    property Status : TOutputStatus read GetStatus;
    property TimeElapsed : Integer read GetTE;
  published
    property Input : TACSInput read Finput write SetInput;
    property SuspendWhenIdle : Boolean read GetSuspend write SetSuspend;
    property OnDone : TOutputDoneEvent read FOnDone write FOndone;
    property OnProgress : TOutputProgressEvent read FOnProgress write FOnProgress;
    property OnThreadException : TThreadExceptionEvent read FOnThreadException write FOnThreadException;
  end;

  TACSStreamedInput = class(TACSInput)
  protected
    FStream : TStream;
    FStreamAssigned : Boolean;
    FSeekable : Boolean;
    procedure SetStream(aStream : TStream);
  public
    property Seekable : Boolean read FSeekable write FSeekable;
    property Stream : TStream read FStream write SetStream;
    constructor Create(AOwner: TComponent); override;
  end;

  TACSStreamedOutput = class(TACSOutput)
  protected
    FStream : TStream;
    FStreamAssigned : Boolean;
    procedure SetStream(aStream : TStream);
  public
    property Stream : TStream read FStream write SetStream;
  end;

  TACSFileIn = class(TACSStreamedInput)
  protected
    FFileName : TFileName;
    FOffset : Integer;
    FOpened : Integer;
    FValid : Boolean;
    FBPS, FSR, FChan : Integer;
    FTime : Integer;
    FLoop : Boolean;
    FStartSample, FEndSample : Integer;
    FTotalSamples : Integer;
    function GetBPS : Integer; override;
    function GetCh : Integer; override;
    function GetSR : Integer; override;
    function GetTime : Integer;
    function GetValid : Boolean;

    (* Note on FSize calculation:
      FSize is calculated in OpenFile method as the FULL file size.
      More precise calculations regarding StartSample/EndSample are done in Init. *)

    procedure OpenFile; virtual; abstract;
    procedure CloseFile; virtual; abstract;
    function GetTotalTime : Integer; override;
    procedure Reset; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Flush; override;
    procedure Init; override;
    function Seek(SampleNum : Integer) : Boolean; virtual; abstract;
    function SetStartTime(Minutes, Seconds : Integer) : Boolean;
    function SetEndTime(Minutes, Seconds : Integer) : Boolean;
    procedure Jump(Offs : Integer);
    property Time : Integer read GetTime;
    property TotalSamples : Integer read FTotalSamples;
    property Valid : Boolean read GetValid;
  published
    property EndSample : Integer read FEndSample write FEndSample;
    property FileName : TFileName read FFileName write FFileName stored True;
    property Loop : Boolean read FLoop write FLoop;
    property StartSample : Integer read FStartSample write FStartSample;
  end;

  TACSFileOut = class(TACSStreamedOutput)
  protected
    FFileName : TFileName;
    FFileMode : TFileOutputMode;
    FAccessMask : Integer;
    procedure SetFileMode(aMode : TFileOutputMode); virtual;
  public
    constructor Create(AOwner: TComponent); override;
{$IFDEF LINUX}
    property AccessMask : Integer read FAccessMask write FAccessMask;
{$ENDIF}
  published
    property FileMode : TFileOutputMode read FFileMode write SetFileMode;
    property FileName : TFileName read FFileName write FFileName;
  end;

  TACSConverter = class(TACSInput)
  protected
    InputLock : Boolean;
    FInput : TACSInput;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetInput(aInput : TACSInput); virtual;
  public
    procedure UnlockInput;
  published
    property Input : TACSInput read FInput write SetInput;
  end;

const

  STREAM_BUFFER_SIZE = $80000;

type

  // Circular buffer with TStream interface

  TACSBufferMode = (bmBlock, bmReport);

  TACSBufferStream = class(TStream)
  private
    Buff : array[0..STREAM_BUFFER_SIZE-1] of Byte;
    ReadCur, WriteCur : Integer;
    FBufferMode : TACSBufferMode;
    fBreak : Boolean;
    FBytesInBuffer : Integer;
    BlockEventName : String;
    LockEventName : String;
    FBytesRead : Integer;
    {$IFDEF WIN32}
    BlockEvent : THandle;
    CS : TRTLCriticalSection;
    {$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    procedure Reset;
    function Seek(Offset: Longint; Origin: Word): Longint; overload; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; overload; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    property BytesInBuffer : Integer read FBytesInBuffer;
    property BufferMode : TACSBufferMode read FBufferMode write FBufferMode;
  end;


implementation

  constructor TACSInput.Create;
  begin
    inherited Create(AOwner);
  end;

  destructor TACSInput.Destroy;
  begin
    inherited Destroy;
  end;

  procedure TACSThread.Execute;
  var
    DoneThread : TVerySmallThread;
    ParentComponent : TACSOutput;
    Res : Boolean;
  begin
    ParentComponent := TACSOutput(Parent);
    while not Terminating do
    begin
      {$IFDEF WIN32}
      EnterCriticalSection(CS);
      {$ENDIF}
      if Delay > 5 then sleep(Delay);
      try
        if ParentComponent.Progress <> ParentComponent.CurProgr then
        begin
          ParentComponent.CurProgr := ParentComponent.Progress;
          if Assigned(ParentComponent.FOnProgress) then Synchronize(CallOnProgress);
        end;
        Res := ParentComponent.DoOutput(Stop);
        if Stop or (not Res) then
        begin
          Stop := False;
          ParentComponent.WhenDone;
          // This ensures that OnDone event is called outside this thread
          DoneThread := TVerySmallThread.Create(True);
          DoneThread.Sender := ParentComponent;
          DoneThread.FOnDone := ParentComponent.FOnDone;
          DoneThread.FreeOnTerminate := True;
          DoneThread.Execute;
          if bSuspend then Self.Suspend;
        end;
      except
        on E : Exception do
        begin
          Stop := False;
          HandleException(E);
          if bSuspend then Self.Suspend;
        end;
      end;
      {$IFDEF WIN32}
      LeaveCriticalSection(CS);
      {$ENDIF}
    end;
    //DoOutput(True);  // Why I'm doing this? I don't remember :-)
    Terminating := False;
  end;

  constructor TACSOutput.Create;
  begin
    inherited Create(AOwner);
    Thread := TACSThread.Create(True);
    Thread.Parent := Self;
//    Thread.DoOutput := Self.DoOutput;
//    Thread.FOnDone := Self.WhenDone;
    Thread.FreeOnTerminate := True;
    Thread.HandleException := HandleThreadException;
    {$IFDEF WIN32}
      SetSuspend(True);
      InitializeCriticalSection(Thread.CS);
    {$ENDIF}
  end;

  destructor TACSOutput.Destroy;
  begin
//    if Thread.Suspended then
//    Thread.Resume;
    if not Thread.Suspended then
    Thread.Terminating := True;
    while Thread.Terminating do;
    {$IFDEF WIN32}
    DeleteCriticalSection(Thread.CS);
    {$ENDIF}
    inherited Destroy;
  end;

  procedure TACSOutput.WhenDone;
  begin
    if not Busy then Exit;
    CanOutput := False;
    Done;
    Busy := False;
  end;

  procedure TACSOutput.Run;
  begin
    if Busy then raise EACSException.Create('Component is Busy');
    if not Assigned(FInput) then raise EACSException.Create('Input is not assigned');
    InputLock := False;
 //   if not Thread.Suspended then Thread.Suspend;
    try
      Prepare;
      Busy := True;
      Thread.Stop := False;
      CanOutput := True;
      if Thread.Suspended then Thread.Resume;
    except
      on E : Exception do HandleThreadException(E);
    end;
  end;

  procedure TACSOutput.Stop;
  begin
    Thread.Stop := True;
  end;

  function TACSOutput.GetStatus;
  begin
    if Busy then
    begin
      if Self.Thread.Suspended then Result := tosPaused
      else Result := tosPlaying;
    end else Result := tosIdle;
  end;

  procedure TACSOutput.SetPriority;
  begin
    Thread.Priority := Priority;
  end;

  function TACSOutput.GetPriority;
  begin
    Result := Thread.Priority;
  end;

  procedure TACSOutput.SetInput;
  var
    OldInput, NewInput : TACSInput;
  begin
    if Busy then
    begin
      NewInput := vInput;
      NewInput.Init;
      OldInput := FInput;
      while InputLock do;
      InputLock := True;
      FInput := NewInput;
      InputLock := False;
      OldInput.Flush;
    end else
    FInput := vInput;
  end;

  function  TACSOutput.GetProgress;
  begin
    if not Assigned(Finput) then
    begin
      Result := 0;
      Exit;
    end;
    case Finput.Size of
      0: Result := 0;
      -1: Result := -1;
      else Result := Round((FInput.Position/FInput.Size)*100);
    end;
  end;

  procedure TACSOutput.Pause;
  begin
    If not Thread.Suspended then Thread.Suspend;
  end;

  procedure TACSOutput.Resume;
  begin
    If Thread.Suspended then Thread.Resume;
  end;

  function TACSOutput.GetSuspend;
  begin
    Result := Thread.bSuspend;
  end;

  procedure TACSOutput.SetSuspend;
  begin
    Thread.bSuspend := v;
  end;

  constructor TACSStreamedInput.Create;
  begin
    inherited Create(AOwner);
    FSeekable := True;
  end;

  function TACSFileIn.GetBPS;
  begin
    if FSeekable then
    begin
      OpenFile;
      Result := FBPS;
      CloseFile;
    end else Result := FBPS;
  end;

  function TACSFileIn.GetCh;
  begin
    if FSeekable then
    begin
      OpenFile;
      Result := FChan;
      CloseFile;
    end else Result := FChan;
  end;

  function TACSFileIn.GetSR;
  begin
    if FSeekable then
    begin
      OpenFile;
      Result := FSR;
      CloseFile;
    end else Result := FSR;
  end;

  function TACSFileIn.GetTime;
  begin
    if FSeekable then
    begin
      OpenFile;
      Result := FTime;
      CloseFile;
    end else Result := FTime;
  end;

  function TACSFileIn.GetValid;
  begin
    if (not FStreamAssigned) and (FileName = '') then
    begin
      Result := False;
    end else
    if FSeekable then
    begin
      OpenFile;
      Result := FValid;
      CloseFile;
    end else Result := FValid;
  end;

  procedure TACSFileIn.Init;
  begin
    if Busy then raise EACSException.Create('The component is Busy');
    if not FStreamAssigned then
    if FFileName = '' then raise EACSException.Create('The file name is not assigned');
    OpenFile;
    if StartSample <> 0 then Seek(StartSample);
    if (StartSample <> 0) or (FEndSample <> -1) then
    begin
      FSize := FEndSample - FStartSample;
      if FEndSample = -1 then FSize := FSize + FTotalSamples + 1;
      FSize := FSize*(BitsPerSample shr 3)*FChan;
    end;
    Busy := True;
    BufStart := 1;
    BufEnd := 0;
    FPosition := 0;
  end;

  procedure TACSFileIn.Flush;
  begin
    CloseFile;
    Busy := False;
  end;

  procedure TACSFileIn.Jump;
  begin
    FOffset := Offs;
  end;

  function TACSOutput.GetTE;
  begin
     if not Assigned(FInput) then
     Result := 0
     else
     Result := Round(FInput.Position/((FInput.BitsPerSample shr 3) *FInput.Channels*FInput.SampleRate));
  end;

  function TACSOutput.GetDelay;
  begin
    if Assigned(Thread) then Result := Thread.Delay;
  end;

  procedure TACSOutput.SetDelay;
  begin
    if Assigned(Thread) then
    if Value <= 100 then Thread.Delay := Value;
  end;

  function TACSInput.GetTotalTime;
  begin
    Result := 0;  // Default result for the streams.
  end;

  function TACSFileIn.GetTotalTime;
  begin
    OpenFile;
    if (SampleRate = 0) or (Channels = 0) or (BitsPerSample = 0) then Exit;
    Result := Round(Size/(SampleRate*Channels*(BitsPerSample shr 3)));
    CloseFile;
  end;

  procedure TACSStreamedInput.SetStream;
  begin
    FStream := aStream;
    if FStream <> nil then FStreamAssigned := True
    else FStreamAssigned := False;
  end;

  procedure TACSStreamedOutput.SetStream;
  begin
    FStream := aStream;
    if FStream <> nil then FStreamAssigned := True
    else FStreamAssigned := False;
  end;

  procedure TACSOutput.Notification;
  begin
    // Remove the following two lines if they cause troubles in your IDE
    if (AComponent = FInput) and (Operation = opRemove )
    then Input := nil;
    inherited Notification(AComponent, Operation);
  end;

  procedure TACSInput.Reset;
  begin
    try
      Flush;
    except
    end;
    Busy := False;
  end;

  procedure TACSOutput.HandleThreadException;
  var
    Conv : TACSConverter;
  begin
   InputLock := False;
   if Status <> tosIdle then
   begin
     try
      if FInput is TACSConverter then
      begin
        Conv := FInput as TACSConverter;
        Conv.UnlockInput;
      end;
     except
     end;
     try
       Done;
     except
     end;
   end;
   CanOutput := False;
   Busy := False;
   if Assigned(FOnThreadException) then FOnThreadException(Self, E);
  end;

  procedure TACSFileIn.Reset;
  begin
    inherited Reset;
    FOpened := 0;
  end;


  constructor TACSFileOut.Create;
  begin
    inherited Create(AOwner);
    {$IFDEF LINUX}
    FAccessMask := $1B6; // rw-rw-rw-
    {$ENDIF}
  end;

  procedure TACSFileOut.SetFileMode;
  begin
    FFileMode := foRewrite;
  end;

  procedure TACSConverter.Notification;
  begin
    // Remove the following two lines if they cause troubles in your IDE
    if (AComponent = FInput) and (Operation = opRemove )
    then Input := nil;
    inherited Notification(AComponent, Operation);
  end;

  procedure TACSConverter.SetInput;
  var
    OldInput, NewInput : TACSInput;
  begin
    if aInput = Self then Exit;
    if Busy then
    begin
      NewInput := aInput;
      NewInput.Init;
      OldInput := FInput;
      while InputLock do;
      InputLock := True;
      FInput := NewInput;
      InputLock := False;
      OldInput.Flush;
    end else
    FInput := aInput;
  end;

  procedure TACSConverter.UnlockInput;
  var
    Conv : TACSConverter;
  begin
    InputLock := False;
    if Assigned(FInput) then
    if FInput is TACSConverter then
    begin
      Conv := FInput as TACSConverter;
      Conv.UnlockInput;
    end;
  end;

  function TACSFileIn.SetStartTime;
  var
    Sample : Integer;
  begin
    Result := False;
    if not FSeekable then Exit;
    OpenFile;
    CloseFile;
    Sample := (Minutes*60+Seconds)*FSR;
    if Sample > FTotalSamples then Exit;
    FStartSample := Sample;
    Result := True;
  end;

  function TACSFileIn.SetEndTime;
  var
    Sample : Integer;
  begin
    Result := False;
    if not FSeekable then Exit;
    OpenFile;
    CloseFile;
    Sample := (Minutes*60+Seconds)*FSR;
    if Sample > FTotalSamples then Exit;
    FEndSample := Sample;
    Result := True;
  end;

  constructor TACSFileIn.Create;
  begin
    inherited Create(AOwner);
    FStartSample := 0;
    FEndSample := -1;
  end;

 procedure TVerySmallThread.Execute;
 begin
   Synchronize(CallOnDone);
 end;

 procedure  TVerySmallThread.CallOnDone;
 begin
   if Assigned(FOnDone) then FOnDone(Sender);
 end;

 procedure TACSThread.CallOnProgress;
  var
    ParentComponent : TACSOutput;
  begin
    ParentComponent := TACSOutput(Parent);
    ParentComponent.FOnProgress(ParentComponent);
  end;

{$IFDEF WIN32}
  procedure TACSOutput.Abort;
  begin
    TerminateThread(Thread.Handle, 0);
    WhenDone;
  end;
{$ENDIF}

  constructor TACSBufferStream.Create;
  begin
    inherited Create;
    {$IFDEF WIN32}
    BlockEventName := 'Block' + IntToStr(LongWord(Self)); // this way we guarantee that the name is unique
    BlockEvent := CreateEvent(nil, True, False, @BlockEventName[1]);
    InitializeCriticalSection(CS);
    {$ENDIF}
  end;

  destructor TACSBufferStream.Destroy;
  begin
    {$IFDEF WIN32}
    DeleteCriticalSection(CS);
    CloseHandle(BlockEvent);
    {$ENDIF}
    inherited Destroy;
  end;

  function TACSBufferStream.Write(const Buffer; Count: Longint): Longint;
  var
    addr : Pointer;
    S1, S2 : Integer;
  begin
    if WriteCur >= ReadCur then
    begin
      {$IFDEF WIN32}
      EnterCriticalSection(CS);
      {$ENDIF}
      S1 := STREAM_BUFFER_SIZE-WriteCur;
      if (Count <= S1) then
      begin
        Move(Buffer, Buff[WriteCur], Count);
        Inc(WriteCur, Count);
        Inc(FBytesInBuffer, Count);
        Result := Count;
      end else
      begin
        Move(Buffer, Buff[WriteCur], S1);
        addr := Pointer(Integer(@Buffer) + S1);
        S2 := Count - S1;
        if S2 > ReadCur then
        S2 := ReadCur;
        Move(addr^, Buff[0], S2);
        WriteCur := S2;
        Inc(FBytesInBuffer, S1+S2);
        Result := S1+S2;
      end;
    end else
    begin
      S2 := ReadCur-WriteCur;
      if Count < S2  then
      S2 := Count;
      Move(Buffer, Buff[WriteCur], S2);
      Inc(WriteCur, S2);
      Inc(FBytesInBuffer, S2);
      Result := S2;
    end;
    {$IFDEF WIN32}
    if Result <> 0 then
    if FBufferMode = bmBlock then PulseEvent(BlockEvent);
    LeaveCriticalSection(CS);
    {$ENDIF}
  end;

  function TACSBufferStream.Read(var Buffer; Count : Integer) : Integer;
  var
    addr : Pointer;
    S1, S2 : Integer;
  begin
    {$IFDEF WIN32}
    if ReadCur = WriteCur then
    if FBufferMode = bmBlock then
    begin
      WaitForSingleObject(BlockEvent, INFINITE);
      ResetEvent(BlockEvent);
    end;
    EnterCriticalSection(CS);
    {$ENDIF}
    if ReadCur <= WriteCur then
    begin
      S2 := WriteCur - ReadCur;
      if Count < S2 then S2 := Count;
      Move(Buff[ReadCur], Buffer, S2);
      Inc(ReadCur, S2);
      Dec(FBytesInBuffer, S2);
      Result := S2;
    end else
    begin
      S1 := STREAM_BUFFER_SIZE-ReadCur;
      if Count <= S1 then
      begin
        Move(Buff[ReadCur], Buffer, Count);
        Inc(ReadCur, Count);
        Dec(FBytesInBuffer, Count);
        Result := Count;
      end else
      begin
        S2 := WriteCur;
        if Count - S1 < S2 then S2 := Count;
        Move(Buff[ReadCur], Buffer, S1);
        addr := Pointer(Integer(@Buffer) + S1);
        Move(Buff[0], addr^, S2);
        ReadCur := S2;
        Dec(FBytesInBuffer, S1+S2);
        Result := S1+S2;
      end;
    end;
    Inc(FBytesRead, Result);
    {$IFDEF WIN32}
    LeaveCriticalSection(CS);
    {$ENDIF}
  end;

  procedure TACSBufferStream.Reset;
  begin
    {$IFDEF WIN32}
    EnterCriticalSection(CS);
    {$ENDIF}
    ReadCur := 0;
    WriteCur := 0;
    FBytesRead := 0;
    {$IFDEF WIN32}
    SetEvent(BlockEvent);
    LeaveCriticalSection(CS);
   {$ENDIF}
  end;

  // The following property is implemented 'cause TStreams Position property uses them

  function TACSBufferStream.Seek(Offset: Longint; Origin: Word) : Integer;
  begin
    if (Offset = 0) and (Origin = 0) then
    Result := FBytesRead
    else
    raise EACSException.Create('Seek: this method is not implemented');
  end;

  function TACSBufferStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
  begin
    if (Offset = 0) and (Origin = soCurrent) then
    Result := FBytesRead
    else
    raise EACSException.Create('Seek: this method is not implemented');
  end;

end.


