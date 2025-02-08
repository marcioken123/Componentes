unit LMDShConsoleView;
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

LMDConsoleCapturer unit - Handles console process IO (AH)
---------------------------------------------------------

ToDo
----
* VCL.NET port
* Unicode support

Changes
-------

###############################################################################}

interface
uses
  Classes, SysUtils, Windows,
  LMDCustomComponent, LMDUnicode, LMDUnicodeStrings, LMDThreads, LMDTypes,
  LMDShBase;

type
  TLMDShellOnNewLine = procedure(Sender: TObject; LString: String) of object;
  TLMDShellProcessPriority = (ppNormal, ppIdle, ppHigh, ppRealtime);

  TLMDShellConsoleView = class;

  { ******************* TLMDShellConsoleThread ********************************}
  TLMDShellConsoleThread = class(TThread)
  private
    FCritical: TLMDCriticalSection;
    FOnCapture: TLMDShellOnNewLine;
  protected
    FLines: TStrings;
    FInLines: TStrings;
    FWorkingDir: string;
    FProcessTimeout: Cardinal;
    FCommandLine: string;
    FPriority: Cardinal;
    function IsProcessTimeOut(AStart: Cardinal): boolean;
    procedure Execute; override;
    procedure TriggerCaptureLine(S: string); virtual;
  public
    constructor Create(ACmd: String; AProcessTimeout: Cardinal = INFINITE);
    destructor Destroy; override;
    property Lines: TStrings read FLines write FLines;
    property OnCaptureLine: TLMDShellOnNewLine read FOnCapture write FOnCapture;
  end;

  { ******************* TLMDShellConsoleView **********************************}
  TLMDShellConsoleView = class(TLMDShellComponent)
  private
    FOutput: TStrings;
    FInput: TStrings;
    FCommandLine: TLMDString;
    FTimeout: Cardinal;
    FRunningThread: TLMDShellConsoleThread;
    FWorkingDir: String;
    FPriority: TLMDShellProcessPriority;
    FOnCapture: TLMDShellOnNewLine;
    FOnTerminated: TNotifyEvent;
    procedure SetOutput(const Value: TStrings);
    procedure SetTimeout(const Value: Cardinal);
    procedure SetPriority(const Value: TLMDShellProcessPriority);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute; virtual;
    procedure Stop; virtual;
    procedure Write(S: String); virtual;
    property Output: TStrings read FOutput write SetOutput;
  published
    property CommandLine: TLMDString read FCommandLine write FCommandLine;
    property WorkingDirectory: String read FWorkingDir write FWorkingDir;
    property Timeout: Cardinal read FTimeout write SetTimeout default 0;
    property Priority: TLMDShellProcessPriority read FPriority write SetPriority default ppNormal;
    property OnLineAdd: TLMDShellOnNewLine read FOnCapture write FOnCapture;
    property OnTerminated: TNotifyEvent read FOnTerminated write FOnTerminated;
  end;

implementation
const
  LMDShellPriorityValues:array[TLMDShellProcessPriority] of Cardinal=
                        (NORMAL_PRIORITY_CLASS, IDLE_PRIORITY_CLASS,
                         HIGH_PRIORITY_CLASS, REALTIME_PRIORITY_CLASS);

{ ********************* TLMDShellConsoleThread ********************************}
{-- protected -----------------------------------------------------------------}
procedure TLMDShellConsoleThread.TriggerCaptureLine(S: string);
begin
  FOnCapture(Self, S);
end;

{------------------------------------------------------------------------------}
function TLMDShellConsoleThread.IsProcessTimeOut(AStart: Cardinal): boolean;
begin
  if FProcessTimeOut = 0 then
    Result := False
  else
    Result := (FProcessTimeout <= (GetTickCount() - AStart));
end;

{------------------------------------------------------------------------------}
procedure TLMDShellConsoleThread.Execute;

const
  LBufSize=32767;
var
  Lsa: TSecurityAttributes;
  Lsi: TStartupInfo;
  Lpi: TProcessInformation;
  LPipeReadOut: THandle; { pipe handles for redirecting STDOUT }
  LPipeWriteOut: THandle;
  LPipeReadIn: THandle; { pipe handles for redirecting STDIN }
  LPipeWriteIn: THandle;
  LResult: Boolean;
  LBytesOfRead: DWORD;
  LBytesOfWrite: DWORD;
  LBuffer: PAnsiChar;
  LExitCode: cardinal;
  i: DWORD;
  LS: String;
  LWorkDir: PChar;
  LStrBuf: PChar;
  LProcessStart: Cardinal;
  Buffer: array[0..512] of Char;

  procedure AddLine;
  begin
    OEMToChar(PAnsiChar(AnsiString(ls)), buffer);
    LS:=StrPas(buffer);
    if Assigned(FLines) then
      begin
        FCritical.Enter;
        try
          FLines.Add(LS);
        finally
          FCritical.Leave;
        end;
      end;

   // Not a thread safe call of event - all responsibility on user
    if Assigned(FOnCapture) then
      TriggerCaptureLine(LS);
    LS:='';
  end;
begin
  GetMem(LBuffer, LBufSize);
  FillChar(Lsa, SizeOf(Lsa), 0);
  Lsa.nLength := SizeOf(Lsa);
  Lsa.bInheritHandle := True;
  Lsa.lpSecurityDescriptor := nil;

  if (not CreatePipe(LPipeReadOut, LPipeWriteOut, @Lsa, 0)) or Terminated then
    begin
      RaiseLastWin32Error;
      Exit;
    end;

  if (not CreatePipe(LPipeReadIn, LPipeWriteIn, @Lsa, 0)) or Terminated then
    begin
      RaiseLastWin32Error;
      CloseHandle(LPipeReadOut);
      CloseHandle(LPipeWriteOut);
      Exit;
    end;

  FillChar(Lsi, SizeOf(Lsi), 0);
  Lsi.cb := Sizeof(Lsi);
  Lsi.dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
  Lsi.wShowWindow := SW_HIDE;
  Lsi.hStdInput := LPipeWriteIn;
  Lsi.hStdOutput := LPipeWriteOut;
  Lsi.hStdError := LPipeWriteOut;

  if FWorkingDir = '' then
    LWorkDir := nil
  else
    LWorkDir := PChar(FWorkingDir);

  if (not CreateProcess(nil, PChar(FCommandLine), nil, nil, True, CREATE_NEW_CONSOLE or FPriority, nil, LWorkDir, Lsi, Lpi)) then
    begin
      RaiseLastWin32Error;
      CloseHandle(LPipeReadOut);
      CloseHandle(LPipeWriteOut);
      CloseHandle(LPipeReadIn);
      CloseHandle(LPipeWriteIn);
      Exit;
    end;
  LProcessStart := GetTickCount();

  CloseHandle(LPipeWriteOut);
  CloseHandle(LPipeReadIn);

  repeat
    GetExitCodeProcess(Lpi.hProcess, LExitCode);

    LResult := ReadFile(LPipeReadOut, LBuffer^, LBufSize, LBytesOfRead, nil);
    if (not LResult) then
      Break;

    LS:=''; i:=0;
    while (i<LBytesOfRead) and not Terminated do
      case LBuffer[i] of
        #0: Inc(i);
       #10: begin
              AddLine;
              Inc(i);
            end;
       #13: begin
              AddLine;
              Inc(i);
              if LBuffer[i]=#10 then Inc(i);
            end;
      else
        begin
          LS := LS + Char(LBuffer[i]);
          Inc(i);
        end;
      end;

    if Assigned(FInLines)  then
      while (FInLines.Count > 0) and (not Terminated) do
        begin
          FCritical.Enter;
          try
            LStrBuf := PChar(FInLines.Strings[0] + #13 + #10 + #0);
            FInLines.Delete(0);
            // Output?
          finally
            FCritical.Leave;
          end;
          WriteFile(LPipeWriteIn, LStrBuf, Length(LStrBuf), LBytesOfWrite, nil);
        end;

    Sleep(0);

    if Terminated or IsProcessTimeout(LProcessStart) then
      begin
        TerminateProcess(Lpi.hProcess, 0);
        break;
      end;

  until (LExitCode <> STILL_ACTIVE);

  FreeMem(LBuffer);

  CloseHandle(Lpi.hProcess);
  CloseHandle(Lpi.hThread);
  CloseHandle(LPipeReadOut);
  CloseHandle(LPipeWriteIn);
end;

{-- public -------------------------------------------------------------------}
constructor TLMDShellConsoleThread.Create(ACmd: String; AProcessTimeout: Cardinal = INFINITE);
begin
  inherited Create(False);
  FCritical := TLMDCriticalSection.Create;
  FCommandLine := ACmd;
  FProcessTimeout := AProcessTimeout;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellConsoleThread.Destroy;
begin
  FCritical.Free;
  inherited;
end;

{ ********************* TLMDShellConsoleView **********************************}
{-- private -------------------------------------------------------------------}
procedure TLMDShellConsoleView.SetOutput(const Value: TStrings);
begin
  FOutput := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellConsoleView.SetPriority(const Value: TLMDShellProcessPriority);
begin
  FPriority := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellConsoleView.SetTimeout(const Value: Cardinal);
begin
  FTimeout := Value;
end;

{-- public -------------------------------------------------------------------}
constructor TLMDShellConsoleView.Create(AOwner: TComponent);
begin
  inherited;
  FTimeout := 0;
  FPriority := ppNormal;
  FInput := TStringList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellConsoleView.Destroy;
begin
  FreeAndNil(FInput);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellConsoleView.Execute;
begin
  FRunningThread := TLMDShellConsoleThread.Create(FCommandLine, FTimeout);
  FRunningThread.FreeOnTerminate := True;
  FRunningThread.OnTerminate := FOnTerminated;
  FRunningThread.FLines := FOutput;
  FRunningThread.FInLines := FInput;
  FRunningThread.FCommandLine := FCommandLine;
  FRunningThread.FProcessTimeout := FTimeout;
  FRunningThread.FWorkingDir := FWorkingDir;
  FRunningThread.FPriority := LMDShellPriorityValues[FPriority];
  FRunningThread.OnCaptureLine := FOnCapture;
  FRunningThread.Resume;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellConsoleView.Stop;
begin
  FRunningThread.DoTerminate;
  FRunningThread.WaitFor;
  FRunningThread.Free;
  FRunningThread := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellConsoleView.Write(S: String);
begin
  FInput.Add(S);
end;

end.
