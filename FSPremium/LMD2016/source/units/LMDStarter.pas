unit LMDStarter;
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

LMDStarter unit (JH)
------------------------

Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, LMDClass, LMDDateTime, LMDShBase, SyncObjs;

type
  { --------------------------------- TLMD Starter --------------------------- }
  TLMDStarterOperation = (smOpen, smPrint, smExplore, smEdit, smProperties);

  TLMDStarterOptions = (soSW_HIDE, soSW_MAXIMIZE, soSW_MINIMIZE, soSW_RESTORE,
                        soSW_SHOW, soSW_SHOWMAXIMIZED,
                        soSW_SHOWMINIMIZED, soSW_SHOWMINNOACTIVE, soSW_SHOWNA,
                        soSW_SHOWNORMAL);

  TLMDStarterExtendedOption = (soxUseCreateProcess, soxRedirectOutput, soxRedirectInput, soxRedirectError);
  TLMDStarterExtendedOptions = set of TLMDStarterExtendedOption;
  TLMDStarterOutputEvent = procedure (Sender: TObject; aBuffer: string) of object;

  TLMDCustomStarter = class(TLMDShellComponent)
  protected
    FStartOperation : TLMDStarterOperation;
    FStartOption    : TLMDStarterOptions;
    FParameters,
    FFilename,
    FDirectory      : String;
    FResult         : LongInt;

    FAutoStart,
    FWait           : Boolean;

    FStart          : TLMDDateTime;
    FFinishedId,
    FTimerID        : TLMDTimer;

    FProcess        : THandle;

    FOnError,
    FOnFinished,
    FBeforeStart,
    FAfterStart     : TNotifyEvent;
    FUseGlobalTimer: Boolean;

    procedure SetStartOperation (aValue : TLMDStarterOperation);
    procedure SetStartOption (aValue : TLMDStarterOptions);
    procedure SetString (index : Integer; aValue : String);
    procedure SetWait (aValue : Boolean);
    procedure SetAutoStart (aValue : Boolean);
    procedure SetStart (aValue : TLMDDateTime);

    procedure GetTimer(Sender:TObject);
    function GetLastErrorInternal : Integer;
    procedure CheckForProcessEnd (Sender : TObject);
    procedure SetUseGlobalTimer(const Value: Boolean);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure TerminateProcess;
    property LastError:Integer read GetLastErrorInternal;
    procedure Execute; virtual;
    property Process : THandle read FProcess;

    property StartOperation : TLMDStarterOperation read FStartOperation write SetStartOperation default smOpen;
    property StartOption : TLMDStarterOptions read FStartOption write SetStartOption default soSW_SHOW;
    property Command : String index 0 read FFilename write SetString;
    property Parameters : String index 1 read FParameters write SetString;
    property DefaultDir : String index 2 read FDirectory write SetString;
    property AutoStart : Boolean read FAutoStart write SetAutoStart default false;
    property StartTime : TLMDDateTime read FStart write SetStart;
    property Wait : Boolean read FWait write SetWait default false;

    // 7.0
    property UseGlobalTimer:Boolean read FUseGlobalTimer write SetUseGlobalTimer default false;
    // ---

    property OnBeforeStart : TNotifyEvent read FBeforeStart write FBeforeStart;
    property OnAfterStart : TNotifyEvent read FAfterStart write FAfterStart;
    property OnError : TNotifyEvent read FOnError write FOnError;
    property OnFinished : TNotifyEvent read FOnFinished write FOnFinished;
  published
    property About;
  end;

  TLMDStarter = class(TLMDCustomStarter)
  published
    property StartOperation;
    property StartOption;
    property Command;
    property Parameters;
    property DefaultDir;
    property AutoStart;
    property StartTime;
    property Wait;
    property UseGlobalTimer;
    property OnBeforeStart;
    property OnAfterStart;
    property OnError;
    property OnFinished;
  end;

  TLMDGetAndSendInputThread = class;

  TLMDStarterExt = class(TLMDCustomStarter)
  private
    FExtOptions: TLMDStarterExtendedOptions;

    FWriteInputThread: TThread;

    FOutputRead, FOutputWrite,
    FInputRead, FInputWrite,
    FErrorWrite: THandle;
    FStdIn: THandle;

    FOnOutput: TLMDStarterOutputEvent;

    FInputBuffer: string;
    FLockInputBuffer : TCriticalSection;

    procedure SetExtOptions(const Value: TLMDStarterExtendedOptions);

  protected
    procedure PrepareAndRunRedirectedChild(aHChildOutput: THandle = 0;
      aHChildInput: THandle = 0; aHChildError: THandle = 0);
    procedure PrepareAndRunChild;
    procedure PreparePipes; virtual;
    procedure ReadAndHandleOutput; virtual;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Execute; override;
    procedure WriteInput(aBuffer: string);
    procedure SendInput;
  published
    property ExtStartOptions: TLMDStarterExtendedOptions read FExtOptions write SetExtOptions;
    property StartOption;
    property Command;
    property Parameters;
    property DefaultDir;
    property AutoStart;
    property StartTime;
    property Wait;
    property UseGlobalTimer;
    property OnBeforeStart;
    property OnAfterStart;
    property OnOutput: TLMDStarterOutputEvent read FOnOutput write FOnOutput;
    property OnError;
    property OnFinished;
  end;

  {--------------------- TLMDGetAndSendInputThread ----------------------------}
  TLMDGetAndSendInputThread = class (TThread)
  private
    FOwner: TLMDStarterExt;
  public
    procedure SetOwner (aOwner: TLMDStarterExt);
    procedure Execute; override;
    constructor Create(CreateSuspended: Boolean; aOwner: TLMDStarterExt);
    destructor Destroy; override;
  end;

implementation

uses
  SysUtils, ShellApi, Forms, Consts,
  LMDStrings, LMDProcs;

{ **************************** class TLMDCustomStarter ***************************** }
{ ------------------------------- private ------------------------------------ }
procedure TLMDCustomStarter.SetStartOperation (aValue : TLMDStarterOperation);
begin
  if aValue <> FStartOperation then
      FStartOperation := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStarter.SetStartOption (aValue : TLMDStarterOptions);
begin
  if aValue <> FStartOption then
      FStartOption := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStarter.SetWait (aValue : Boolean);
begin
  if aValue <> FWait then
      FWait := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStarter.SetAutoStart (aValue : Boolean);
begin
  if aValue <> FAutoStart then
    begin
      FAutoStart := aValue;
      FTimerId.Interval:=1000;
      FTimerId.Enabled := aValue;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStarter.SetString (index : Integer; aValue : String);
begin
  case index of
    0 : if aValue <> FFilename then
          begin
            FFilename := aValue;
          end;
    1 : if aValue <> FParameters then
          begin
            FParameters := aValue;
          end;
    2 : if aValue <> FDirectory then
          begin
            FDirectory := aValue;
          end;
  end; { end of case index of }
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStarter.SetStart (aValue : TLMDDateTime);
begin
  FStart.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStarter.SetUseGlobalTimer(const Value: Boolean);
begin
  if FUseGlobalTimer<>Value then
    begin
      FUseGlobalTimer := Value;
      FTimerId.GlobalMode:=FUseGlobalTimer;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStarter.GetTimer(Sender:TObject);
var
  ye, mo, da, ho, mi, se, hs : Word;
begin
  if csDesigning in ComponentState then exit;
{  if not LMDApplication.Timer[FTimerId].Enabled then exit;}
  DecodeDate (Date, ye, mo, da);
  DecodeTime (Time, ho, mi, se, hs);
  if (ye = FStart.year) and
     (mo = Fstart.month) and
     (da = FStart.day) and
     (ho = FStart.hour) and
     (mi = FStart.minute) and
     (se = FStart.second) then
    Execute;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStarter.CheckForProcessEnd(Sender : TObject);
var
  ExitCode : DWORD;
begin
  if (not GetExitCodeProcess(FProcess, ExitCode)) or
     (ExitCode <> STILL_ACTIVE) then
    begin
      CloseHandle (FProcess); {JH Feb 2001}
      FProcess := 0;
      FFinishedId.Enabled:=False;
      FFinishedId.OnTimer:=nil;
      FreeAndNil(FFinishedId);
      if Assigned (FOnFinished) then FOnFinished (self);
    end;
end;

{ -------------------------------- public ------------------------------------ }
constructor TLMDCustomStarter.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FDirectory := '';
  FParameters := '';
  FFilename := '';
  FResult := 0;
  FWait := false;
  FAutoStart := false;
  FStartOperation := smOpen;
  FStart := TLMDDateTime.Create;
  FStartOption := soSW_SHOW;
  FProcess:= 0; {JH Feb 2001}
  {get a global timer-id}
  FTimerId:=TLMDTimer.Create(1000, GetTimer, false);
  FFinishedId := nil;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomStarter.Destroy;
begin
  {free timer...}
  FreeAndNil(FTimerId);
  if Assigned(FFinishedId) then
    FreeAndNil(FFinishedId);
  FreeAndNil(FStart);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStarter.TerminateProcess;
begin
  Windows.TerminateProcess (FProcess, 1);
  FResult := GetLastError;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStarter.Execute;
var
  StartOp: String;
  fint : Integer;
  ExecInfo: TShellExecuteInfo;

begin
  if FProcess <> 0 then begin CloseHandle (FProcess); end;{JH Feb 2001}

  fint:=0;
  if Assigned(FBeforeStart) then FBeforeStart(self);

  //!! --> always fill a structure with dummy values!!

  FillChar(ExecInfo, SizeOf(ExecInfo), 0);
  ExecInfo.cbSize       := SizeOf(TShellExecuteInfo);

  case FStartOperation of
    smOpen  : StartOp:='open';
    smPrint : StartOp:='print';
    smExplore : StartOp:='explore';
//    smProperties: StartOp:='properties';
    smEdit: StartOp:='edit'
  end;

  if FStartOperation = smProperties then
    begin
      ExecInfo.lpFile       := Int_Ref(FFilename);
      ExecInfo.fMask        := SEE_MASK_INVOKEIDLIST OR SEE_MASK_DOENVSUBST;// or SEE_MASK_NOCLOSEPROCESS;
      ExecInfo.lpVerb       := 'properties';
      //ExecInfo.Wnd          := 0;
      ExecInfo.nShow        := SW_SHOWNORMAL;
    end
  else
    begin
      case FStartOption of
        soSW_SHOW : fint := SW_SHOW;
        soSW_HIDE : fint := SW_HIDE;
        soSW_MAXIMIZE : fint := SW_MAXIMIZE;
        soSW_MINIMIZE : fint := SW_MINIMIZE;
        soSW_RESTORE : fint := SW_RESTORE;
        soSW_SHOWMAXIMIZED : fint := SW_SHOWMAXIMIZED;
        soSW_SHOWMINIMIZED : fint := SW_SHOWMINIMIZED;
        soSW_SHOWMINNOACTIVE : fint := SW_SHOWMINNOACTIVE;
        soSW_SHOWNA : fint := SW_SHOWNA;
        soSW_SHOWNORMAL : fint := SW_SHOWNORMAL;
      end;

      ExecInfo.fMask        := SEE_MASK_NOCLOSEPROCESS;
      ExecInfo.Wnd          := Application.MainForm.Handle;
      ExecInfo.lpVerb       := Int_Ref(StartOp);
      if FStartOperation = smExplore then
        begin
          ExecInfo.lpFile:= Int_Ref(LMDAnsiSlashAdd(ExtractFilePath(FFilename)));
          ExecInfo.lpParameters := '';
          ExecInfo.lpDirectory  := '';
        end
      else
        begin
          ExecInfo.lpFile       := Int_Ref(FFilename);
          ExecInfo.lpParameters := Int_Ref(FParameters);
          ExecInfo.lpDirectory  := Int_Ref(FDirectory);
        end;
      ExecInfo.nShow        := fint;
    end;

  //open - execute the specified file

  ShellExecuteEx(@ExecInfo);

  FProcess := ExecInfo.hProcess;
  case ExecInfo.hInstApp of
  SE_ERR_FNF,          {File not found}
    SE_ERR_PNF,          {Path not found}
    SE_ERR_ACCESSDENIED, {Access denied}
    SE_ERR_OOM,          {Out of memory}
    SE_ERR_DLLNOTFOUND,  {Dynamic-link library not found}
    SE_ERR_SHARE,  {Cannot share open file}
    SE_ERR_ASSOCINCOMPLETE, {File association information not complete}
    SE_ERR_DDETIMEOUT,   {DDE operation timed out}
    SE_ERR_DDEFAIL,  {DDE operation failed}
    SE_ERR_DDEBUSY,  {DDE operation busy}
    SE_ERR_NOASSOC       : begin
                             FResult := ExecInfo.hInstApp;
                             if Assigned (FOnError) then
                               FOnError (nil);
                           end;
    else
      begin
        if Assigned (FOnFinished) then
          begin
            {get a global timer-id}
            FFinishedId:=TLMDTimer.Create(500, CheckForProcessEnd, true, FUseGlobalTimer);
          end;
      end;
    if FWait then
      WaitForSingleObject (FProcess, INFINITE);
  end;
  if Assigned (FAfterStart) then FAfterStart(self);
end;


{ ---------------------------------------------------------------------------- }
function TLMDCustomStarter.GetLastErrorInternal : Integer;
begin
  result := FResult;
end;

{------------------------- TLMDStarterExt -------------------------------------}

constructor TLMDStarterExt.Create(AOwner: TComponent);
begin
  inherited;
  FWriteInputThread := TLMDGetAndSendInputThread.Create ((csDesigning in ComponentState), self);
  FLockInputBuffer := TCriticalSection.Create;
end;

destructor TLMDStarterExt.Destroy;
begin
  FLockInputBuffer.Free;
  inherited;
end;

procedure TLMDStarterExt.Execute;
begin
  if soxUseCreateProcess in FExtOptions then
  begin
    if [soxRedirectOutput, soxRedirectInput, soxRedirectError] * FExtOptions <> [] then
    begin
      PreparePipes;
      PrepareAndRunRedirectedChild(FOutputWrite, FInputRead, FErrorWrite);
    end
    else
      PrepareAndRunChild;

    // Close pipe handles (do not continue to modify the parent).
    // You need to make sure that no handles to the write end of the
    // output pipe are maintained in this process or else the pipe will
    // not close when the child process exits and the ReadFile will hang.
    if (not CloseHandle(FOutputWrite)) then
      raise Exception.Create('CloseHandle');
    if (not CloseHandle(FInputRead )) then
      raise Exception.Create('CloseHandle');
    if (not CloseHandle(FErrorWrite)) then
      raise Exception.Create('CloseHandle');


    if soxRedirectInput in FExtOptions then
      FWriteInputThread.Resume;

    ReadAndHandleOutput;

    if Assigned (FOnFinished) then
      FFinishedId:=TLMDTimer.Create(500, CheckForProcessEnd, true, FUseGlobalTimer);

    if FWait then
      WaitForSingleObject (FProcess, INFINITE);

    FWriteInputThread.Terminate;

    if Assigned (FAfterStart) then FAfterStart(self);
  end
  else
    inherited;

end;

procedure TLMDStarterExt.PrepareAndRunChild;
begin
  PrepareAndRunRedirectedChild(0, 0, 0);
end;

procedure TLMDStarterExt.PrepareAndRunRedirectedChild(aHChildOutput: THandle = 0;
  aHChildInput: THandle = 0; aHChildError: THandle = 0);
var
  lStartupInfo: TStartupInfo;
  lProcessInfo: TProcessInformation;
begin

  if Assigned(FBeforeStart) then
    FBeforeStart(self);

  // Set up the start up info struct.
  FillChar(lStartupInfo, sizeof(lStartupInfo), 0);
  lStartupInfo.cb := sizeof(lStartupInfo);
  // Note that dwFlags must include STARTF_USESHOWWINDOW if you want to
  // use the wShowWindow flags below
  if (aHChildOutput = 0) and (aHChildInput = 0) and (aHChildError = 0) then
    lStartupInfo.dwFlags := STARTF_USESHOWWINDOW
  else
  begin
    lStartupInfo.dwFlags := STARTF_USESTDHANDLES + STARTF_USESHOWWINDOW;
    if (soxRedirectOutput in FExtOptions) and (aHChildOutput <> 0) then
      lStartupInfo.hStdOutput := aHChildOutput
    else
      lStartupInfo.hStdOutput := GetStdHandle(STD_OUTPUT_HANDLE);
    if (soxRedirectInput in FExtOptions) and (aHChildInput <> 0) then
      lStartupInfo.hStdInput := aHChildInput
    else
      lStartupInfo.hStdInput := GetStdHandle(STD_INPUT_HANDLE);
    if (soxRedirectError in FExtOptions) and (aHChildInput <> 0) then
      lStartupInfo.hStdError := aHChildError
    else
      lStartupInfo.hStdError := GetStdHandle(STD_ERROR_HANDLE);
  end;

  with lStartupInfo do
    case FStartOption of
      soSW_SHOW : wShowWindow := SW_SHOW;
      soSW_HIDE : wShowWindow := SW_HIDE;
      soSW_MAXIMIZE : wShowWindow := SW_MAXIMIZE;
      soSW_MINIMIZE : wShowWindow := SW_MINIMIZE;
      soSW_RESTORE : wShowWindow := SW_RESTORE;
      soSW_SHOWMAXIMIZED : wShowWindow := SW_SHOWMAXIMIZED;
      soSW_SHOWMINIMIZED : wShowWindow := SW_SHOWMINIMIZED;
      soSW_SHOWMINNOACTIVE : wShowWindow := SW_SHOWMINNOACTIVE;
      soSW_SHOWNA : wShowWindow := SW_SHOWNA;
      soSW_SHOWNORMAL : wShowWindow := SW_SHOWNORMAL;
    end;

  if (not CreateProcess(pchar(Command), pchar(Command +' '+ Parameters), nil, nil, TRUE,
                     CREATE_NEW_CONSOLE, nil, pchar(DefaultDir), lStartupInfo, lProcessInfo)) then
  begin
    FResult := GetLastError;
    if Assigned (FOnError) then
      FOnError (nil);
  end;

  FProcess := lProcessInfo.hProcess;

  if (not CloseHandle(lProcessInfo.hThread)) then
     raise Exception.Create('Could not close thread handle');
end;

procedure TLMDStarterExt.PreparePipes;
var
  lOutputReadTmp, lInputWriteTmp: THandle;
  lSecurityAttributes: TSecurityAttributes;
begin
  // Set up the security attributes struct.
  lSecurityAttributes.nLength := sizeof(TSecurityAttributes);
  lSecurityAttributes.lpSecurityDescriptor := nil;
  lSecurityAttributes.bInheritHandle := TRUE;

  // Create the child output pipe.
  if (not CreatePipe(lOutputReadTmp, FOutputWrite, @lSecurityAttributes, 0)) then
     raise Exception.Create('Error creating output pipe');

  // Create a duplicate of the output write handle for the std error
  // write handle. This is necessary in case the child application
  // closes one of its std output handles.
  if (not DuplicateHandle(GetCurrentProcess(), FOutputWrite,
                       GetCurrentProcess(), @FErrorWrite, 0,
                       TRUE, DUPLICATE_SAME_ACCESS)) then
     raise Exception.Create('Error duplicating output write pipe');

  // Create the child input pipe.
  if (not CreatePipe(FInputRead, lInputWriteTmp, @lSecurityAttributes, 0)) then
     raise Exception.Create('Error creating input pipe');

  // Create new output read handle and the input write handles. Set
  // the Properties to FALSE. Otherwise, the child inherits the
  // properties and, as a result, non-closeable handles to the pipes
  // are created.
  if (not DuplicateHandle(GetCurrentProcess(), lOutputReadTmp,
                       GetCurrentProcess(),
                       @FOutputRead, // Address of new handle.
                       0, FALSE, // Make it uninheritable.
                       DUPLICATE_SAME_ACCESS)) then
     raise Exception.Create('Error duplicating output write pipe');

  if (not DuplicateHandle(GetCurrentProcess(), lInputWriteTmp,
                       GetCurrentProcess(),
                       @FInputWrite, // Address of new handle.
                       0, FALSE, // Make it uninheritable.
                       DUPLICATE_SAME_ACCESS)) then
     raise Exception.Create('Error duplicating input write pipe');

  // Close inheritable copies of the handles you do not want to be
  // inherited.
  if (not CloseHandle(lOutputReadTmp)) then
    raise Exception.Create('Error closing output read tmp pipe');

  if (not CloseHandle(lInputWriteTmp)) then
    raise Exception.Create('Error closing input write tmp pipe');


  // Get std input handle so you can close it and force the ReadFile to
  // fail when you want the input thread to exit.
  FStdIn := GetStdHandle(STD_INPUT_HANDLE);
  if ( FStdIn = INVALID_HANDLE_VALUE ) then
     raise Exception.Create('Could not get std input handle for parent process');

end;

procedure TLMDStarterExt.ReadAndHandleOutput;
var
  lBuffer: array[0..255] of AnsiChar;
  lAvailable, lBytesRead: DWORD ;
  lPeekBuffer: array[0..31] of AnsiChar;
begin
  repeat
     if not(PeekNamedPipe(FOutputRead, @lPeekBuffer, 1, @lBytesRead, @lAvailable, nil)) then
       break;
     lBytesRead := 0;
     if lAvailable > 0 then
     begin
       if (not ReadFile(FOutputRead, lBuffer, 255, lBytesRead, nil) or (lBytesRead = 0)) then
       begin
          if (GetLastError() = ERROR_BROKEN_PIPE) then
             break // pipe done - normal exit path
          else
             raise Exception.Create('Error reading child process output'); // Something went wrong
       end
       else
       begin
         lBuffer[lBytesRead] := #0;
         if Assigned(FOnOutput) then
           FOnOutput(self, string(lBuffer));
       end;
     end;
     Application.ProcessMessages;
  until false;
end;

procedure TLMDStarterExt.SendInput;
var
  lBytesToWrite, lBytesWritten: dword;
begin
  if (FInputBuffer <> '') then
  begin
    FInputBuffer := FInputBuffer + #0;
    lBytesToWrite := length(FInputBuffer);
    if (not WriteFile(FStdIn, FInputBuffer, lBytesToWrite, lBytesWritten, nil)) then
    begin
      if (GetLastError() = ERROR_NO_DATA) then
          // Pipe was closed (normal exit path)
      else
        raise Exception.Create('Error sending input to child process');
    end;
  end;
  FLockInputBuffer.Acquire;
  FInputBuffer := '';
  FLockInputBuffer.Release;
end;

procedure TLMDStarterExt.SetExtOptions(
  const Value: TLMDStarterExtendedOptions);
begin
  FExtOptions := Value;
  if [soxRedirectOutput, soxRedirectInput] * FExtOptions <> [] then
    FExtOptions := FExtOptions + [soxUseCreateProcess];
end;

{ TLMDGetAndSendInputThread }

constructor TLMDGetAndSendInputThread.Create(CreateSuspended: Boolean;
  aOwner: TLMDStarterExt);
begin
  inherited Create (CreateSuspended);
  FOwner := aOwner;
end;

destructor TLMDGetAndSendInputThread.Destroy;
begin
  if not Terminated then Terminate;
  inherited Destroy;
end;

procedure TLMDGetAndSendInputThread.Execute;
var
  lTimeOut:integer;
begin
  lTimeOut := 100;
  while not Terminated do
  begin
    Application.ProcessMessages;
    SleepEx (lTimeOut, true);
    FOwner.SendInput;
  end;
end;

procedure TLMDGetAndSendInputThread.SetOwner(aOwner: TLMDStarterExt);
begin
  FOwner := aOwner;
end;

procedure TLMDStarterExt.WriteInput(aBuffer: string);
begin
  FLockInputBuffer.Acquire;
  FInputBuffer := aBuffer;
  FLockInputBuffer.Release;
end;

end.
