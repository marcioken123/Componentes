unit IWJclStackTrace;

interface

uses
  Windows, SysUtils, Classes, IWJclDebug;

function GetStackTraceOfAllThreads: TStringList;

implementation

uses
  IW.Common.Lists, IW.Common.StrLists, {$IFDEF FPC} JwaTLHelp32, JwaPsApi, {$ELSE} TLHelp32, PsApi, {$ENDIF}
  InException, RTLConsts;  // One isolated Indy unit so we can ignore EIdConnClosedGracefully

function GetExceptionStackInfoProc(P: PExceptionRecord): Pointer;
begin
  // We don't need to create a new instance of TJclStackInfoList here.
  // JclLastExceptStackListToStrings() method already uses a intenal one.
  // This prevents a memory leak in Delphi x64 because
  // GetExceptionStackInfoProc() is called multiple times when Indy raises silent exceptions,
  // but CleanUpStackInfoProc() is called only once. Seems like a Delphi x64 bug to me!
  //Result := TJclStackInfoList.Create(True, 0, nil);
  Result := nil;
end;

function GetStackInfoStringProc(Info: Pointer): string;
var
  xList: TStringList;
begin
  xList := TStringList.Create;
  try
    JclLastExceptStackListToStrings(xList, True, True, True, True);
    Result := xList.Text;
  finally
    xList.Free;
  end;
end;

procedure CleanUpStackInfoProc(Info: Pointer);
begin
  // Don't need any cleanup here
end;

procedure StartExceptionTracking;
begin
  JclStackTrackingOptions := [stRawMode, stStack];
  if JclStartExceptionTracking then begin
    Exception.GetExceptionStackInfoProc := GetExceptionStackInfoProc;
    Exception.GetStackInfoStringProc := GetStackInfoStringProc;
    Exception.CleanUpStackInfoProc := CleanUpStackInfoProc;
  end;
end;

procedure StopExceptionTracking;
begin
  if JclExceptionTrackingActive then begin
    Exception.GetExceptionStackInfoProc := nil;
    Exception.GetStackInfoStringProc := nil;
    Exception.CleanUpStackInfoProc := nil;
    JclStopExceptionTracking;
  end;
end;

function GetThreadList: TIWListBase;
var
  SnapProcHandle: THandle;
  NextProc: Boolean;
  TThreadEntry: TThreadEntry32;
  PID: Cardinal;
begin
  Result := nil;
  SnapProcHandle := CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0); //Takes a snapshot of the all threads
  if (SnapProcHandle <> INVALID_HANDLE_VALUE) then
  try
    PID := GetCurrentProcessId;
    Result := TIWListBase.Create;
    TThreadEntry.dwSize := SizeOf(TThreadEntry);
    NextProc := Thread32First(SnapProcHandle, TThreadEntry);  //get the first Thread
    while NextProc do
    begin
      if TThreadEntry.th32OwnerProcessID = PID then //Check the owner Pid against the PID requested
      begin
        Result.Add(Pointer(TThreadEntry.th32ThreadID));
      end;

      NextProc := Thread32Next(SnapProcHandle, TThreadEntry);  //get the Next Thread
    end;
  finally
    CloseHandle(SnapProcHandle);//Close the Handle
  end;
end;

function GetStackTraceOfAllThreads: TStringList;
var
  aThreadList: TIWListBase;
  i: Integer;
  ThreadID: Cardinal;
begin
  Result := TStringList.Create;
  try
    aThreadList := GetThreadList;
    try
      for i := 0 to aThreadList.Count - 1 do begin
        ThreadID := Cardinal(aThreadList.Items[i]);
        Result.Add('ThreadID: ' + IntToStr(ThreadID));
        JclGetThreadStackListToStrings(ThreadID, Result);
        Result.Add('');
        Result.Add('');
      end;
    finally
      FreeAndNil(aThreadList);
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

initialization
  // ignore Indy silent exceptions here (including EIdConnClosedGracefully)
  // InException unit is required. We don't want to link with Indy, if not necessary
  // but there is no other way to do it, once IWJclStackTrace is also an optional unit in any
  // IW project
  AddIgnoredException(EIdSilentException);
  StartExceptionTracking;

finalization
  StopExceptionTracking;

end.
