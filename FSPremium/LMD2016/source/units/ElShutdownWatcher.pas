unit ElShutdownWatcher;
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

ElShutdownWatcher unit
----------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

var IsShuttingDown : boolean;
    WatcherActive  : boolean;

implementation

uses
  Forms, Classes, Windows, Messages, SysUtils;

type
  TShutdownThread = class(TThread)
  private
    Wnd : HWND;
    procedure WndProc(var Msg : TMessage);
    procedure CloseApp;
  protected
    procedure Execute; override;
  end;

var StopWatcherEvent : THandle;

procedure TShutdownThread.CloseApp;
begin
  if (Application.MainForm <> nil) and (not Application.Terminated) then
     Application.MainForm.Close
  else
    PostMessage(Application.Handle, WM_QUIT, 0, 0);
end;

procedure TShutdownThread.WndProc(var Msg : TMessage);
begin
  if (Msg.Msg = WM_QUERYENDSESSION) and WatcherActive then
  begin
    IsShuttingDown := true;
    Synchronize(CloseApp);
    WaitForSingleObject(StopWatcherEvent, INFINITE);
    ResetEvent(StopWatcherEvent);
    Msg.Result := 1;
  end else
    DefWindowProc(Wnd, Msg.Msg, Msg.wParam, msg.lParam);
end;

procedure TShutdownThread.Execute;
var Msg : TMsg;
    i : LongBool;
    AHandle : THandle;
begin
  StopWatcherEvent := CreateEvent(nil, true, false, nil);
  Wnd := AllocateHWND(WndProc);
  repeat
    i := GetMessage(Msg, 0, 0, 0);
    if i = TRUE then
    begin
      TranslateMessage(Msg);
      DispatchMessage(Msg);
      if WaitForSingleObject(StopWatcherEvent, 0) = WAIT_OBJECT_0 then
         break;
    end;
  until i <> TRUE;
  DeallocateHWND(Wnd);
  AHandle := StopWatcherEvent;
  StopWatcherEvent := 0;
  CloseHandle(AHandle);
end;

var
  Watcher: TShutdownThread;

initialization

  IsShuttingDown := false;
  Watcher := TShutdownThread.Create(true);
  Watcher.FreeOnTerminate := true;
  Watcher.Resume;

finalization
  if StopWatcherEvent <> 0 then
     SetEvent(StopWatcherEvent);

end.
