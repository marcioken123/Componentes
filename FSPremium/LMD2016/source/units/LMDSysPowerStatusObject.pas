unit LMDSysPowerStatusObject;
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

LMDSysPowerStatusObject unit (JH)
---------------------------------
Small class which contains info about the power supply (battery state, ...)

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  LMDSysObject,
  LMDSysBase,
  LMDSysConst;

type
  TLMDSysPowerStatusDisplayInfo=(ppidACLineStatus, ppidBatteryFlags, ppidBatterLifePercent,ppidBatteryLifeTime,ppidBatteryFullLifeTime);
  TLMDSysPowerStatusDisplayInfos=set of TLMDSysPowerStatusDisplayInfo;

const
  def_TLMDSysPowerStatusDisplayInfos=[ppidACLineStatus, ppidBatteryFlags, ppidBatterLifePercent,ppidBatteryLifeTime,ppidBatteryFullLifeTime];

  LMDSysPowerStatusProps:array[TLMDSysPowerStatusDisplayInfo] of TLMDSysProperty =(
    (Name: sLMDSysPowerStatusPropTitleACLineStatus; Description: sLMDSysPowerStatusPropDescACLineStatus),
    (Name: sLMDSysPowerStatusPropTitleBatteryFlags; Description: sLMDSysPowerStatusPropDescBatteryFlags),
    (Name: sLMDSysPowerStatusPropTitleBatteryLifePercent; Description: sLMDSysPowerStatusPropDescBatteryLifePercent),
    (Name: sLMDSysPowerStatusPropTitleBatteryLifeTime; Description: sLMDSysPowerStatusPropDescBatteryLifeTime),
    (Name: sLMDSysPowerStatusPropTitleBatteryLifeTime; Description: sLMDSysPowerStatusPropDescBatteryLifeTime));

type
  TLMDACLineStatus = (lsOffline, lsOnline, lsUnknown);
  TLMDBatteryFlag = (bfHigh, bfLow, bfCritical, bfCharging, bfNoSystemBat, bfUnknown);
  TLMDBatteryFlags = set of TLMDBatteryFlag;

  { ************************************************************************** }
  TLMDSysPowerStatusObject = class(TLMDSysObject)
  private
    FACLineStatus: TLMDACLineStatus;
    FBatteryFlags: TLMDBatteryFlags;
    FBatteryLifePercent: Byte;
    FBatteryLifeTime,
    FBatteryFullLifeTime: DWORD;
    FDisplayInfo: TLMDSysPowerStatusDisplayInfos;

    procedure SetDummyACLS(aValue: TLMDACLineStatus);
    procedure SetDummyBatF(aValue: TLMDBatteryFlags);
    procedure SetDummyLP(aValue: Byte);
    procedure SetDummyDW(index: Integer; aValue: DWORD);

    function ACLineStatusToStr(aACLineStatus : TLMDACLineStatus) : string;
    function BatteryFlagsToStr(aBatteryFlags : TLMDBatteryFlags) : string;
    procedure SetDisplayInfo(const Value: TLMDSysPowerStatusDisplayInfos);
  protected
    procedure RegisterProperties; override;
  public
    constructor Create; override;
    //    procedure GetValues(aText: TStrings); override;
    procedure Refresh; override;
    procedure Apply; override;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
  published
    property ACLineStatus: TLMDACLineStatus read FACLineStatus write SetDummyACLS stored false;
    property BatteryFlags: TLMDBatteryFlags read FBatteryFlags write SetDummyBatF stored false;
    property BatteryLifePercent: Byte read FBatteryLifePercent write SetDummyLP stored false;
    property BatteryLifeTime: DWORD index 0 read FBatteryLifeTime write SetDummyDW stored false;
    property BatteryFullLifeTime: DWORD index 1 read FBatteryFullLifeTime write SetDummyDW stored false;

    property DisplayInfo:TLMDSysPowerStatusDisplayInfos read FDisplayInfo write SetDisplayInfo default def_TLMDSysPowerStatusDisplayInfos;
  end;

implementation
uses
  Sysutils;

{ **************************************************************************** }
{ ---------------------------- private --------------------------------------- }
procedure TLMDSysPowerStatusObject.SetDisplayInfo(const Value: TLMDSysPowerStatusDisplayInfos);
begin
  if FDisplayInfo<>Value then
    begin
      FDisplayInfo := Value;
      RegisterProperties;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysPowerStatusObject.SetDummyACLS(aValue: TLMDACLineStatus);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysPowerStatusObject.SetDummyBatF(aValue: TLMDBatteryFlags);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysPowerStatusObject.SetDummyLP(aValue: Byte);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysPowerStatusObject.SetDummyDW(index: Integer; aValue: DWORD);
begin
end;

{ ---------------------------------------------------------------------------- }

{function TLMDSysPowerStatusObject.GetACLS: TLMDACLineStatus;
begin
  if FInstantUpdate then
    Refresh;
  Result:= FACLineStatus;
end;

{ ---------------------------------------------------------------------------- }

{function TLMDSysPowerStatusObject.GetBatFlags: TLMDBatteryFlags;
begin
  if FInstantUpdate then
    Refresh;
  Result:= FBatteryFlags;
end;

{ ---------------------------------------------------------------------------- }

{function TLMDSysPowerStatusObject.GetLP: Byte;
begin
  if FInstantUpdate then
    Refresh;
  Result:= FBatteryLifePercent;
end;

{ ---------------------------------------------------------------------------- }

{function TLMDSysPowerStatusObject.GetDWORD(index: Integer): DWORD;
begin
  Result:= 0;
  if FInstantUpdate then
    Refresh;
  case index of
    0: Result:= FBatteryLifeTime;
    1: Result:= FBatteryFullLifeTime;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysPowerStatusObject.ACLineStatusToStr(aACLineStatus : TLMDACLineStatus) : string;
begin
  case aACLineStatus of
    lsOffline: result := sACLineStatusOffline;
    lsOnline: result := sACLineStatusOnline;
    lsUnknown : result := sACLineStatusUnknown;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysPowerStatusObject.BatteryFlagsToStr(aBatteryFlags : TLMDBatteryFlags) : string;
begin
  result := '';
  if bfHigh in aBatteryFlags then result := result + sBatteryFlagHigh;
  if bfLow in aBatteryFlags then result := result + sBatteryFlagLow;
  if bfCritical in aBatteryFlags then result := result + sBatteryFlagCritical;
  if bfCharging in aBatteryFlags then result := result + sBatteryFlagCharging;
  if bfNoSystemBat in aBatteryFlags then result := result + sBatteryFlagNoSystemBat;
  if bfUnknown in aBatteryFlags then result := result + sBatteryFlagUnkown;
end;
{ ------------------------------- protected ---------------------------------- }
procedure TLMDSysPowerStatusObject.RegisterProperties;
var
  i:TLMDSysPowerStatusDisplayInfo;
begin
 FPropertiesDesc.Clear;
 for i:=Low(TLMDSysPowerStatusDisplayInfo) to High(TLMDSysPowerStatusDisplayInfo) do
   if i in FDisplayInfo then
     FPropertiesDesc.Add(Ord(i), LMDSysPowerStatusProps[i].Name, LMDSysPowerStatusProps[i].Description);
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDSysPowerStatusObject.Create;
begin
  FDisplayInfo:=def_TLMDSysPowerStatusDisplayInfos;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
//procedure TLMDSysPowerStatusObject.GetValues(aText: TStrings);
//begin
//end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysPowerStatusObject.Refresh;
var
  sps: _SYSTEM_POWER_STATUS;
  i:TLMDSysPowerStatusDisplayInfo;
begin
  //  if LMDSIWindowsNT then exit;
DoProgress(sLMDSysPowerStatusObjectsTitle, 100, 0);
  FPropertiesDesc.InvalidateProperties;
  GetSystemPowerStatus(sps);
DoProgress(sLMDSysPowerStatusObjectsTitle, 100, 40);
  with sps do
    begin

      case ACLineStatus of
        0: FACLineStatus:= lsOffline;
        1: FACLineStatus:= lsOnline;
      else
        FACLineStatus:= lsUnknown;
      end;

      //determine the battery status
      //we do not need to check for the missing (16, 32, 64) because they are currently not used in Win32
      FBatteryFlags:= [];
      if BatteryFlag and 1 = 1 then
        Include(FBatteryFlags, bfHigh);
      if BatteryFlag and 2 = 2 then
        Include(FBatteryFlags, bfLow);
      if BatteryFlag and 4 = 4 then
        Include(FBatteryFlags, bfCritical);
      if BatteryFlag and 8 = 8 then
        Include(FBatteryFlags, bfCharging);
      if BatteryFlag and 128 = 128 then
        Include(FBatteryFlags, bfNoSystemBat);
      if BatteryFlag and 256 = 256 then
        Include(FBatteryFlags, bfUnknown);

      FBatteryLifePercent:= BatteryLifePercent;

      FBatteryLifeTime:= BatteryLifeTime;
      FBatteryFullLifeTime:= BatteryFullLifeTime;
    end;
DoProgress(sLMDSysPowerStatusObjectsTitle, 100, 80);

   for i:=Low(TLMDSysPowerStatusDisplayInfo) to High(TLMDSysPowerStatusDisplayInfo) do
     if i in FDisplayInfo then
        with FPropertiesDesc.PropertyByID(Ord(i)) do
         case i of
            ppidACLineStatus: Text:= ACLineStatusToStr(FACLineStatus);
            ppidBatteryFlags: Text:= BatteryFlagsToStr(FBatteryFlags);
            ppidBatterLifePercent:
              if FBatteryLifePercent=$FF then
                Text:=sLMDSysUnknown
              else
                Text:=IntToStr(FBatteryLifePercent);
            ppidBatteryLifeTime:
              if FBatteryLifeTime=$FFFFFFFF then
                Text:=sLMDSysUnknown
              else
                Text:= IntToStr(FBatteryLifeTime);
            ppidBatteryFullLifeTime:
               if FBatteryLifeTime=$FFFFFFFF then
                 Text:=sLMDSysUnknown
               else
                 Text:= IntToStr(FBatteryFullLifeTime);
         end;

   DoProgress('', 100, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysPowerStatusObject.Apply;
begin
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysPowerStatusObject.GetElementTitle : string;
begin
  result := sLMDSysPowerStatusObjectsTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysPowerStatusObject.GetElementDescription : string;
begin
  result := sLMDSysPowerStatusObjectsDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysPowerStatusObject.GetElementType : TLMDSysInfoType;
begin
  result := itPowerStatus;
end;

end.
