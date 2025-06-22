unit IWJclDebugHook;

interface

uses
  SysUtils, Classes, IWJclDebug;

implementation

function GetExceptionStackInfoProc(P: PExceptionRecord): Pointer;
begin
  Result := TJclStackInfoList.Create(True, 0, nil);
end;

function GetStackInfoStringProc(Info: Pointer): string;
var
  xList: TStringList;
begin
  if Info = nil then begin
    Exit;
  end;
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
  FreeAndNil(TJclStackInfoList(Info));
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

initialization
  StartExceptionTracking

finalization
  StopExceptionTracking;

end.
