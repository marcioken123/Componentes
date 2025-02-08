unit LMDSyncUnit;
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

LMDSyncUnit unit (DD)
--------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, SysUtils, Windows, SyncObjs;

type

  { **************************TLMDSyncExec**************************** }
  TLMDSyncExec = class
  private
    FID: integer;
    FSynchronizeException: TObject;
    FMethod: TThreadMethod;
  public
    Cancel: boolean;
    FreeOnExec: boolean;
  end;

  { **************************TLMDSyncThread**************************** }

  TLMDSyncThread = class(TThread)

  public
    procedure Synchronize(Method: TThreadMethod);
  end;

  { **************************TLMDSyncObject**************************** }
  TLMDSyncObject = class
  private
    SyncWindow: HWND;
    procedure FreeSyncWindow;
    procedure CheckSyncWindow;
  public
    bServerMode: boolean;
    constructor Create;
    destructor Destroy; override;
    procedure Synchronize(Method: TThreadMethod);
    procedure PostSynchronize(SE: TLMDSyncExec; Method: TThreadMethod; bFree:
      boolean = True);
    function CheckOverhead: boolean;
  end;

procedure GlobalSynchronize(Method: TThreadMethod);
procedure ProcessSyncMessages;
procedure LMDProcessMessages;

var
  GlobalLMDSyncObject: TLMDSyncObject;
  aGlobalSem: longint;
  Synchronizer: TMultiReadExclusiveWriteSynchronizer;
  CriticalSection: TCriticalSection;

implementation

uses
{$IFDEF LMD_DEBUGTRACE}
  dialogs,
{$ENDIF}

//  WinTypes

  Forms //  ???
  ;

const
  CM_EXECPROC = $8FFF;
  CM_EXECPROC_POST = $8FFD;
  c_FirstItem: integer = -99999;

var
  bServerMode: boolean;
  SyncList: TThreadList = nil;
  int_ID: integer = 1;

type
  PRaiseFrame = ^TRaiseFrame;
  TRaiseFrame = record
    NextRaise: PRaiseFrame;
    ExceptAddr: Pointer;
    ExceptObject: TObject;
    ExceptionRecord: PExceptionRecord;
  end;

{$IFDEF LMD_DEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

{-----------------------------------------------------------------------------}

procedure ProcessSyncMessages;
var
  Msg: tagMSG;
begin
  while PeekMessage(Msg, 0, CM_EXECPROC_POST, CM_EXECPROC, PM_REMOVE) do
    DispatchMessage(Msg);
  CheckSynchronize;
end;
{ **************************TLMDSyncObject**************************** }

{-----------------------------------------------------------------------------}

procedure TLMDSyncObject.FreeSyncWindow;
begin
  if SyncWindow <> 0 then
    begin
      DestroyWindow(SyncWindow);
      SyncWindow:= 0;
    end;
end;

{-----------------------------------------------------------------------------}

function  GetSyncObject(var SE: TLMDSyncExec; ID: integer): Boolean;
var
  Lst: TList;
  i: integer;
begin
  SE := nil;
  Lst := SyncList.LockList;

  try
    if  ID = c_FirstItem  then
      begin
        if  Lst.Count > 0 then
          begin
            SE := TLMDSyncExec(Lst[0]);
            Lst.Delete(0);
          end;
      end
    else
    for i := 0 to Lst.Count do
      if  TLMDSyncExec(Lst[i]).FID = ID then
      begin
        SE := TLMDSyncExec(Lst[i]);
        Lst.Delete(i);
        break;
      end;
  finally
    SyncList.UnlockList;
  end;

  Result := Assigned(SE);
end;

function SyncWndProc(Window: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
  stdcall;
var
  SE: TLMDSyncExec;
  {$ifndef STACK_BASED_EXCEPTIONS}
  LException: Pointer;
  {$endif}
begin
  Result:= 0;

  case Msg of
    CM_EXECPROC:
      if  GetSyncObject(SE, lParam) then
        begin
          try
            SE.FSynchronizeException:= nil;
            SE.FMethod;
          except
            {$ifdef STACK_BASED_EXCEPTIONS}
            if RaiseList <> nil then
              begin
                SE.FSynchronizeException:= PRaiseFrame(RaiseList).ExceptObject;
                PRaiseFrame(RaiseList).ExceptObject:= nil;
              end;
            {$else}
            LException := AcquireExceptionObject();
            try
              SE.FSynchronizeException := LException;
            finally
              ReleaseExceptionObject();
            end;
            {$endif}
          end;
        end;
    CM_EXECPROC_POST:
      if  GetSyncObject(SE, lParam) then
        begin
          try
            if not SE.Cancel then
              begin
                SE.FSynchronizeException:= nil;
                SE.FMethod;
              end;
          except
            ;
          end;
          try
            if SE.FreeOnExec then
              SE.Free;
          except
            ;
          end;
        end;
    else
      Result:= DefWindowProc(Window, Msg, wParam, lParam);
  end;
end;

var
  SyncWindowClass: TWndClass = (style: 0;
    lpfnWndProc: @SyncWndProc;
    cbClsExtra: 0;
    cbWndExtra: 0;
    hInstance: 0;
    hIcon: 0;
    hCursor: 0;
    hbrBackground: 0;
    lpszMenuName: '';//nil;
    lpszClassName: 'TSyncWindow');

  {-----------------------------------------------------------------------------}

procedure TLMDSyncObject.CheckSyncWindow;

  function AllocateWindow: HWND;
  var
    TempClass: TWndClass;
    ClassRegistered: boolean;
  begin
    SyncWindowClass.hInstance:= hInstance;
    ClassRegistered:= GetClassInfo(hInstance, SyncWindowClass.lpszClassName,
      TempClass);
    if not ClassRegistered or (TempClass.lpfnWndProc <> @SyncWndProc) then
      begin
        if ClassRegistered then
          Windows.UnregisterClass(SyncWindowClass.lpszClassName, hInstance);
        Windows.RegisterClass(SyncWindowClass);
      end;
    Result:= CreateWindowEx(WS_EX_TOOLWINDOW, SyncWindowClass.lpszClassName, '',
      WS_POPUP,
      0, 0, 0, 0, 0, 0, hInstance, nil);
  end;
begin
  if SyncWindow = 0 then
    SyncWindow:= AllocateWindow;
end;

{-----------------------------------------------------------------------------}

procedure TLMDSyncObject.Synchronize(Method: TThreadMethod);
var
  SE: TLMDSyncExec;
  Exc: TObject;
begin
  if bServerMode then
    begin
      GlobalSynchronize(Method);
    end
  else
    begin
//      Exc := nil;
      CheckSyncWindow;
      SE:= TLMDSyncExec.Create;
      try
        SE.FSynchronizeException:= nil;
        SE.FMethod:= Method;
        SE.FID := InterlockedIncrement(int_ID);
        SyncList.Add(SE);
        SendMessage(SyncWindow, CM_EXECPROC, 0, SE.FID);
        Exc:= SE.FSynchronizeException;
      finally
        SE.Free;
      end;
      if Assigned(Exc) then
        raise Exc;
    end;
end;

{ **************************TLMDSyncThread**************************** }

{-----------------------------------------------------------------------------}

procedure TLMDSyncThread.Synchronize(Method: TThreadMethod);
begin

  if GetCurrentThreadID = ThreadID then

    inherited Synchronize(Method)
  else
    GlobalLMDSyncObject.Synchronize(Method);
end;

{-----------------------------------------------------------------------------}

procedure GlobalSynchronize(Method: TThreadMethod);
begin
  WaitForSingleObject(aGlobalSem, INFINITE);
  try
    Method;
  finally
    ReleaseSemaphore(aGlobalSem, 1, nil);
  end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDSyncObject.PostSynchronize(SE: TLMDSyncExec; Method: TThreadMethod;
  bFree: boolean = True);
begin
  if bServerMode then
    begin
      GlobalSynchronize(Method);
    end
  else
    begin
      CheckSyncWindow;
      SE.FSynchronizeException:= nil;

      if  SE.FID = 0  then
        SE.FID := InterlockedIncrement(int_ID);
      SE.FMethod:= Method;
      SE.Cancel:= False;
      SE.FreeOnExec:= bFree;
      SyncList.Add(SE);
      PostMessage(SyncWindow, CM_EXECPROC_POST, 0, SE.FID);
    end;
end;

{-----------------------------------------------------------------------------}

constructor TLMDSyncObject.Create;
begin
  inherited;
  CheckSyncWindow;
  bServerMode:= LMDSyncUnit.bServerMode;
end;

{-----------------------------------------------------------------------------}

destructor TLMDSyncObject.Destroy;
begin
  FreeSyncWindow;
  inherited;
end;

{-----------------------------------------------------------------------------}

function TLMDSyncObject.CheckOverhead: boolean;
var
  Msg: TMsg;
begin
  Result:= PeekMessage(Msg, SyncWindow, CM_EXECPROC, CM_EXECPROC, PM_NOREMOVE);
end;

{-----------------------------------------------------------------------------}
procedure LMDProcessMessages;
begin
  Application.ProcessMessages;
end;

{-----------------------------------------------------------------------------}

procedure FinalizeUnit;
var
  Obj: TLMDSyncExec;
begin
  if  Assigned(SyncList)  then
    begin
      while GetSyncObject(Obj, c_FirstItem) do
        Obj.Free;

      SyncList.Free;
    end;
  CriticalSection.Free;
  Synchronizer.Free;
  CloseHandle(aGlobalSem);
  GlobalLMDSyncObject.Free;
end;

initialization
  {$IFDEF LMD_DEBUGTRACE}
    {$I C1.INC}
  {$ENDIF}
  GlobalLMDSyncObject:= TLMDSyncObject.Create;
  aGlobalSem:= CreateSemaphore(nil, 1, 1, '');
  bServerMode:= False; //IsLibrary;
  Synchronizer:= TMultiReadExclusiveWriteSynchronizer.Create;
  CriticalSection:= TCriticalSection.Create;
  SyncList := TThreadList.Create;

finalization
  FinalizeUnit;
end.
