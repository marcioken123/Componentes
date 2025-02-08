unit LMDTimer;
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

LMDTimer unit ()
----------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  Messages,
  MMSystem,
  LMDClass,
  LMDConst,
  //dialogs,
  LMDCustomComponent;

type
  TLMDHiTimer = class;

  {------------------------------- TLMDThreadedTimer --------------------------}
  TLMDThreadedTimer=class(TThread)
  private
    FTimer:TLMDHiTimer;
    FInterval:TLMDTimerInterval;
  protected
    procedure Execute; override;
  public
    property Interval: TLMDTimerInterval read FInterval write FInterval;
    constructor Create(aOwner: TLMDHiTimer);
  end;

  TLMDHiTimer = class(TLMDCustomComponent)
  private
    FEnabled: Boolean;
    FInternalFlag: Boolean;
    FInterval: UINT;
    FTimerID: UINT;
    FTimerCaps: TTimeCaps;
    FOnTimer: TNotifyEvent;
    FWindowHandle: HWND;

    // 4.0
    FThread: TLMDThreadedTimer;
    FThreadPriority: TThreadPriority;
    FSynchronize,
    FUseThread: Boolean;
    procedure SetThreadPriority(aValue:TThreadPriority);
    procedure SetUseThread(aValue:Boolean);

    procedure SetEnabled(aValue: Boolean);
    procedure SetInterval(aValue:UINT);
    procedure SetOnTimer(aValue: TNotifyEvent);
    procedure UpdateTimer;
    procedure WndProc(var Msg: TMessage);
    function GetCaps:TTimeCaps;
    function GetInteger(index:Integer):Integer;
  protected
    procedure Timer; dynamic;
  public
    constructor Create(AOwner:TComponent);override;
    constructor CreateExt(aOwner:TComponent; Interval:TLMDTimerInterval);
    destructor Destroy;override;
    property MaxInterval: Integer index 0 read GetInteger;
    property MinInterval: Integer index 1 read GetInteger;
  published
    Property About;
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property Interval:UINT read FInterval write SetInterval default 1000;
    property OnTimer: TNotifyEvent read FOnTimer write SetOnTimer;

    property Synchronize:Boolean read FSynchronize write FSynchronize default True;
    property UseThread:Boolean read FUseThread write SetUseThread default True;
    property ThreadPriority:TThreadPriority read FThreadPriority write
                            SetThreadPriority default tpNormal;
  end;

implementation

uses

  Forms,
  SysUtils,
  Consts;

{------------------------------------------------------------------------------}

procedure TimeCallBack(uTimerID, uMessage: UINT; dwUser, dw1, dw2: {$ifdef LMDCOMP16}DWORD_PTR{$else}DWORD{$endif}); stdcall;
begin
  PostMessage(HWND(dwUser), WM_TIMER, uTimerID,0);
end;

{------------------------------------------------------------------------------}
procedure TLMDThreadedTimer.Execute;

  function ThreadClosed: Boolean;
  begin
    Result:=Terminated or Application.Terminated or (FTimer=nil);
  end;

begin
  repeat
    if not ThreadClosed then
      if SleepEx(FInterval, False) = 0 then
        begin
          if not ThreadClosed and FTimer.FEnabled then
            with FTimer do
              if FSynchronize then
                self.Synchronize(Timer)
              else
                Timer;
      end;
  until Terminated;
end;

{------------------------------------------------------------------------------}
constructor TLMDThreadedTimer.Create(aOwner:TLMDHiTimer);
begin
  inherited Create(True);
  FTimer:=aOwner;
  FInterval := 1000;
  // free Thread after Termination
  FreeOnTerminate:=True;
end;

{*************************** Class TLMDHiTimer*********************************}
{----------------------------  Private ----------------------------------------}
procedure TLMDHiTimer.SetEnabled(aValue: Boolean);
begin
 if aValue <> FEnabled then
   begin
     FEnabled:=aValue;
     UpdateTimer;
   end;
end;

{------------------------------------------------------------------------------}
procedure TLMDHiTimer.SetInterval(aValue:UINT);
begin
 if aValue <> FInterval then
   begin
     if (aValue<FTimerCaps.wPeriodMin) then
       FInterval:=FTimerCaps.wPeriodMin
     else
       if (aValue>FTimerCaps.wPeriodMax) then
         FInterval:=FTimerCaps.wPeriodMax
       else
         FInterval:=aValue;
     UpdateTimer;
   end;
end;

{------------------------------------------------------------------------------}
procedure TLMDHiTimer.SetOnTimer(aValue: TNotifyEvent);
begin
  FOnTimer:=aValue;
  UpdateTimer;
end;

{------------------------------------------------------------------------------}
procedure TLMDHiTimer.SetUseThread(aValue:Boolean);
begin
  if aValue<>FUseThread then
    begin
      FUseThread:=aValue;
      UpdateTimer;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDHiTimer.SetThreadPriority(aValue:TThreadPriority);
begin
  if aValue<>FThreadPriority then
    begin
      FThreadPriority:=aValue;
      if FUseThread then UpdateTimer;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDHiTimer.GetCaps:TTimeCaps;
var
  temp:TTimeCaps;
begin

  TimeGetDevCaps(@temp, 2*sizeof(UINT));

  result:=temp;
end;

{------------------------------------------------------------------------------}
function TLMDHiTimer.GetInteger(index:Integer):Integer;
begin
  result:=0;
  case Index of
    0: result:=FTimerCaps.wPeriodMax;
    1: result:=FTimerCaps.wPeriodMin;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDHiTimer.UpdateTimer;
begin
  if csDesigning in ComponentState then exit;

  if FThread<>nil then
    FThread.Terminate;

  {if one is active - delete it!}
  if FTimerID <> 0 then
    TimeKillEvent(FTimerID);

  if csDestroying in ComponentState then exit;

  if FUseThread then
    begin
      if FWindowHandle<>0 then
        begin
          DeallocateHWnd(FWindowHandle);
          FWindowHandle:=0;
        end;

      if FEnabled and Assigned(FOnTimer) then
        begin
          FThread:=TLMDThreadedTimer.Create(self);
          FThread.FInterval:=FInterval;
          FThread.Priority:=FThreadPriority;
          while FThread.Suspended do
            FThread.Resume;
        end;
    end
  else
    begin
      if FWindowHandle=0 then
        FWindowHandle:= AllocateHWnd(WndProc);

      if (FInterval <> 0) and FEnabled and Assigned(FOnTimer) then
        begin
          FTimerID := TimeSetEvent(FInterval, FInterval,
                                   TimeCallBack, FWindowHandle, TIME_PERIODIC);
          FInternalFlag:=False;
          If FTimerId=0 then
            raise EOutOfResources.Create(SNoTimers);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDHiTimer.WndProc(var Msg: TMessage);
begin
  with Msg do
    if (Msg = WM_TIMER) and (DWORD(WPARAM) = FTimerID) then
      try
        If FInternalFlag then exit;
        FInternalFlag:=True;
        Timer;
        FInternalFlag:=False;
        Result:=0;
      except
        Application.HandleException(Self);
      end
    else
      Result := DefWindowProc(FWindowHandle, Msg, wParam, lParam);
end;

{--------------------- Protected ----------------------------------------------}
procedure TLMDHiTimer.Timer;
begin
  if Assigned(FOnTimer) then FOnTimer(Self);
end;

{---------------------Public---------------------------------------------------}
constructor TLMDHiTimer.Create(aOwner:TComponent);
begin
  CreateExt(aOwner, 1000);
end;

{------------------------------------------------------------------------------}
constructor TLMDHiTimer.CreateExt(aOwner:TComponent; Interval:TLMDTimerInterval);
begin
  inherited Create(aOwner);
  FEnabled := False;
  FInternalFlag:=False;
  FTimerCaps:=GetCaps;
  TimeBeginPeriod(FTimerCaps.wPeriodMin);
  FInterval:=Interval;
  FWindowHandle:=0;
  //4.0
  FSynchronize:=True;
  FUseThread:=True;
  FThreadPriority:=tpNormal;
  FThread:=nil;
end;

{------------------------------------------------------------------------------}
Destructor TLMDHiTimer.Destroy;
begin
  FOnTimer:=nil;
  if FThread<>nil then
    begin
      UpdateTimer;

      //FThread.Free;
    end;
  TimeEndPeriod(FTimerCaps.wPeriodMin);
  FEnabled := False;

  if FWindowHandle <> 0 then
    DeallocateHWnd(FWindowHandle);

  inherited Destroy;
end;

end.
