unit ElPowerMan;
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

ElPowerMan unit
---------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses Windows, Classes, Messages, ElBaseComp;

{$IFNDEF BCB}
const
  {$EXTERNALSYM PBT_APMQUERYSUSPEND}
  PBT_APMQUERYSUSPEND             = $0000;
  {$EXTERNALSYM PBT_APMQUERYSTANDBY}
  PBT_APMQUERYSTANDBY             = $0001;
  {$EXTERNALSYM PBT_APMQUERYSUSPENDFAILED}
  PBT_APMQUERYSUSPENDFAILED       = $0002;
  {$EXTERNALSYM PBT_APMQUERYSTANDBYFAILED}
  PBT_APMQUERYSTANDBYFAILED       = $0003;

  {$EXTERNALSYM PBT_APMSUSPEND}
  PBT_APMSUSPEND                  = $0004;
  {$EXTERNALSYM PBT_APMSTANDBY}
  PBT_APMSTANDBY                  = $0005;
  {$EXTERNALSYM PBT_APMRESUMECRITICAL}
  PBT_APMRESUMECRITICAL           = $0006;
  {$EXTERNALSYM PBT_APMRESUMESUSPEND}
  PBT_APMRESUMESUSPEND            = $0007;
  {$EXTERNALSYM PBT_APMRESUMESTANDBY}
  PBT_APMRESUMESTANDBY            = $0008;
  {$EXTERNALSYM PBTF_APMRESUMEFROMFAILURE}
  PBTF_APMRESUMEFROMFAILURE       = $00000001;

  {$EXTERNALSYM PBT_APMBATTERYLOW}
  PBT_APMBATTERYLOW               = $0009;
  {$EXTERNALSYM PBT_APMPOWERSTATUSCHANGE}
  PBT_APMPOWERSTATUSCHANGE        = $000A;
  {$EXTERNALSYM PBT_APMOEMEVENT}
  PBT_APMOEMEVENT                 = $000B;
  {$EXTERNALSYM PBT_APMRESUMEAUTOMATIC}
  PBT_APMRESUMEAUTOMATIC          = $0012;
{$ENDIF}

type

  TElPowerResumeType = (prtNormal, prtCritical, prtAutomatic, prtStandby);
  TElPowerStatus = (psUnknown, psInactive, psActive);
  TElBatteryState = (bsUnknown, bsNoBattery, bsHigh, bsLow, bsCritical, bsCharging);

  //TElPowerEvent = procedure(Sender : TObject; PowerMan : integer) of object;
  TElPowerQueryEvent = procedure(Sender : TObject; UserInterfaceAllowed : boolean; var Allowed : boolean) of object;
  TElPowerResumeEvent = procedure(Sender : TObject; ResumeAfter : TElPowerResumeType) of object;

  TElPowerManager = class(TElBaseComponent)
  protected
    FOnResume: TElPowerResumeEvent;
    //FOnPowerEvent : TElPowerEvent;
    //FOnPowerQueryEvent : TElPowerQueryEvent;
    FOnSuspend: TNotifyEvent;
    FOnBatteryLow: TNotifyEvent;
    FOnPowerStatusChange: TNotifyEvent;
    FOnQuerySuspend: TElPowerQueryEvent;
    FOnSuspendAborted: TNotifyEvent;
    FOnQueryStandby: TElPowerQueryEvent;
    FOnStandbyAborted: TNotifyEvent;
    FOnStandby: TNotifyEvent;
    procedure WndProc(var Message : TMessage); override;
    procedure DoSuspend; virtual;
    procedure DoBatteryLow; virtual;
    procedure DoQuerySuspend(UIAllowed : boolean; var SuspendAllowed : boolean); virtual;
    procedure DoPowerStatusChange; virtual;
    procedure DoSuspendAborted; virtual;
    procedure DoResume(ResumeType : TElPowerResumeType); virtual;
    function GetACPowerStatus: TElPowerStatus;
    function GetBatteryState: TElBatteryState;
    function GetBatteryLifePercent: Integer;
    procedure DoStandby; virtual;
    procedure DoStandbyAborted; virtual;
    procedure DoQueryStandby(UIAllowed : boolean; var SuspendAllowed : boolean); 
        virtual;
  public
    property ACPowerStatus: TElPowerStatus read GetACPowerStatus;
    property BatteryState: TElBatteryState read GetBatteryState;
    property BatteryLifePercent: Integer read GetBatteryLifePercent;
  published
    property OnResume: TElPowerResumeEvent read FOnResume write FOnResume;
    property OnSuspend: TNotifyEvent read FOnSuspend write FOnSuspend;
    property OnBatteryLow: TNotifyEvent read FOnBatteryLow write FOnBatteryLow;
    property OnPowerStatusChange: TNotifyEvent read FOnPowerStatusChange write
        FOnPowerStatusChange;
    property OnQuerySuspend: TElPowerQueryEvent read FOnQuerySuspend write
        FOnQuerySuspend;
    property OnQueryStandby: TElPowerQueryEvent read FOnQueryStandby write
        FOnQueryStandby;
    property OnSuspendAborted: TNotifyEvent read FOnSuspendAborted write
        FOnSuspendAborted;
    property OnStandbyAborted: TNotifyEvent read FOnStandbyAborted write
        FOnStandbyAborted;
    property OnStandby: TNotifyEvent read FOnStandby write FOnStandby;

    property Enabled;
  end;

implementation
{$IFDEF BCB}
const
  PBT_APMQUERYSUSPEND             = $0000;
  PBT_APMQUERYSTANDBY             = $0001;
  PBT_APMQUERYSUSPENDFAILED       = $0002;
  PBT_APMQUERYSTANDBYFAILED       = $0003;

  PBT_APMSUSPEND                  = $0004;
  PBT_APMSTANDBY                  = $0005;
  PBT_APMRESUMECRITICAL           = $0006;
  PBT_APMRESUMESUSPEND            = $0007;
  PBT_APMRESUMESTANDBY            = $0008;
  PBTF_APMRESUMEFROMFAILURE       = $00000001;

  PBT_APMBATTERYLOW               = $0009;
  PBT_APMPOWERSTATUSCHANGE        = $000A;
  PBT_APMOEMEVENT                 = $000B;
  PBT_APMRESUMEAUTOMATIC          = $0012;
{$ENDIF}

procedure TElPowerManager.WndProc(var Message : TMessage);
var SuspendAllowed : boolean;
    UIAllowed      : boolean;
begin
  if Message.Msg = WM_POWERBROADCAST then
  begin
    case Message.wParam of
    PBT_APMBATTERYLOW:
        DoBatteryLow;
      PBT_APMSUSPEND:
        DoSuspend;
      PBT_APMSTANDBY:
        DoStandby;
      PBT_APMQUERYSUSPEND:
        begin
          SuspendAllowed := true;
          UIAllowed := (Message.lParam and 1 = 1);
          DoQuerySuspend(UIAllowed, SuspendAllowed);
          if SuspendAllowed then
            Message.Result := 1
          else
            Message.Result := BROADCAST_QUERY_DENY;
        end;
      PBT_APMQUERYSTANDBY:
        begin
          SuspendAllowed := true;
          UIAllowed := (Message.lParam and 1 = 1);
          DoQueryStandby(UIAllowed, SuspendAllowed);
          if SuspendAllowed then
            Message.Result := 1
          else
            Message.Result := BROADCAST_QUERY_DENY;
        end;
      PBT_APMQUERYSUSPENDFAILED:
        DoSuspendAborted;
      PBT_APMQUERYSTANDBYFAILED:
        DoStandbyAborted;
      PBT_APMPOWERSTATUSCHANGE:
        DoPowerStatusChange;
      PBT_APMRESUMECRITICAL:
        DoResume(prtCritical);
      PBT_APMRESUMEAUTOMATIC:
        DoResume(prtAutomatic);
      PBT_APMRESUMESUSPEND:
        DoResume(prtNormal);
      PBT_APMRESUMESTANDBY:
        DoResume(prtStandby);
    end;
  end
  else
    inherited;
end;

procedure TElPowerManager.DoSuspend;
begin
  if assigned(FOnSuspend) then
    FOnSuspend(Self);
end;

procedure TElPowerManager.DoBatteryLow;
begin
  if Assigned(FOnBatteryLow) then
    FOnBatteryLow(Self);
end;

procedure TElPowerManager.DoQuerySuspend(UIAllowed : boolean; var
    SuspendAllowed : boolean);
begin
  if Assigned(FOnQuerySuspend) then FOnQuerySuspend(Self, UIAllowed, SuspendAllowed);
end;

procedure TElPowerManager.DoPowerStatusChange;
begin
  if assigned(FOnPowerStatusChange) then
    FOnPowerStatusChange(Self);
end;

procedure TElPowerManager.DoSuspendAborted;
begin
  if assigned(FOnSuspendAborted) then FOnSuspendAborted(Self);
end;

procedure TElPowerManager.DoResume(ResumeType : TElPowerResumeType);
begin
  if assigned(FOnResume) then
    FOnResume(Self, ResumeType);
end;

function TElPowerManager.GetACPowerStatus : TElPowerStatus;
var SPS : TSystemPowerStatus;
begin
  GetSystemPowerStatus(SPS);
  case SPS.ACLineStatus of
    0: result := psInactive;
    1: result := psActive;
    else result := psUnknown;
  end;
end;

function TElPowerManager.GetBatteryState: TElBatteryState;
var SPS : TSystemPowerStatus;
begin
  GetSystemPowerStatus(SPS);
  case SPS.BatteryFlag of
    128: result := bsNoBattery;
    1  : result := bsHigh;
    2  : result := bsLow;
    4  : result := bsCritical;
    8  : result := bsCharging;
    else result := bsUnknown;
  end;
end;

function TElPowerManager.GetBatteryLifePercent: Integer;
var SPS : TSystemPowerStatus;
begin
  GetSystemPowerStatus(SPS);
  if SPS.BatteryLifePercent = 255 then
    result := -1
  else
    result := SPS.BatteryLifePercent;
end;

procedure TElPowerManager.DoStandby;
begin
  if assigned(FOnStandby) then
    FOnStandby(Self);
end;

procedure TElPowerManager.DoStandbyAborted;
begin
  if assigned(FOnStandbyAborted) then FOnStandbyAborted(Self);
end;

procedure TElPowerManager.DoQueryStandby(UIAllowed : boolean; var 
    SuspendAllowed : boolean);
begin
  if Assigned(FOnQueryStandby) then FOnQueryStandby(Self, UIAllowed, SuspendAllowed);
end;

end.
