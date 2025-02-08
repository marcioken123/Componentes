unit LMDSysTimeZoneObject;
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

LMDSysTimeZoneObject unit (JH)
------------------------------
Retrieves system time zone settings

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
  TLMDSysTimeZoneDisplayInfo=(tpidBias, tpidTimezoneID, tpidDayLightName, tpidDayLightBias, tpidDayLightDate,
                              tpidDayLightDateString, tpidStandardName, tpidStandardBias, tpidStandardDate,
                              tpidStandardDateString);
  TLMDSysTimeZoneDisplayInfos=set of TLMDSysTimeZoneDisplayInfo;

  TLMDSysTimeZoneID=(stzStandard, stzDayLight, stzUnknown);

const
  def_TLMDSysTimeZoneDisplayInfos=[tpidBias, tpidTimezoneID, tpidDayLightBias, tpidStandardBias,
                                   tpidDayLightName, tpidStandardName, tpidDayLightDate, tpidDayLightDateString,
                                   tpidStandardDate, tpidStandardDateString];

  LMDSysTimeZoneProps:array[TLMDSysTimeZoneDisplayInfo] of TLMDSysProperty =(
    (Name: sLMDSysTimeZonePropTitleBias; Description: sLMDSysTimeZonePropDescBias),
    (Name: sLMDSysTimeZonePropTitleTimeZoneID; Description: sLMDSysTimeZonePropDescTimezoneID),
    (Name: sLMDSysTimeZonePropTitleDayLightName; Description: sLMDSysTimeZonePropDescDayLightName),
    (Name: sLMDSysTimeZonePropTitleDayLightBias; Description: sLMDSysTimeZonePropDescDayLightBias),
    (Name: sLMDSysTimeZonePropTitleDayLightDate; Description: sLMDSysTimeZonePropDescDayLightDate),
    (Name: sLMDSysTimeZonePropTitleDayLightDate; Description: sLMDSysTimeZonePropDescDayLightDate),
    (Name: sLMDSysTimeZonePropTitleStandardName; Description: sLMDSysTimeZonePropDescStandardName),
    (Name: sLMDSysTimeZonePropTitleStandardBias; Description: sLMDSysTimeZonePropDescStandardBias),
    (Name: sLMDSysTimeZonePropTitleStandardDate; Description: sLMDSysTimeZonePropDescStandardDate),
    (Name: sLMDSysTimeZonePropTitleStandardDate; Description: sLMDSysTimeZonePropDescStandardDate));

   sLMDSysTimeZoneID:array[TLMDSysTimeZoneID] of String=(sLMDSysTimeZoneStandard, sLMDSysTimeZoneDayLight, sLMDSysUnknown);

type
  { ************************************************************************** }
  TLMDSysTimeZoneObject = class(TLMDSysObject)
  private
    FStdBias,
    FDayLightBias,
    FBias: LongInt;
    FDayLightName,
    FStdName,
    FDayLightDateString,
    FStdDateString:string;
    FDayLightDate, FStdDate:TDateTime;
    FDisplayInfo:TLMDSysTimeZoneDisplayInfos;
    FTimeZoneID:TLMDSysTimeZoneID;
    procedure SetDummyLongInt(aValue: LongInt);
    procedure SetDummyDate(aValue:TDateTime);
    procedure SetDummyString(aValue: string);
    procedure SetDisplayInfo(const Value: TLMDSysTimeZoneDisplayInfos);
    function GetLocalTimeOffset:TDateTime;
  protected
    procedure RegisterProperties; override;
  public
    constructor Create; override;

    //    procedure GetValues(aText: TStrings); override;
    procedure Apply; override;
    procedure Init;override;
    procedure Refresh; override;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

    function GetCoordinatedUniversalTime: TDateTime;
    function GetLocalTimeOffsetMinutes:LongInt;

    // Use TimeZoneID specify whether DayLight/Standard Time is active
    property TimeZoneID:TLMDSysTimeZoneID read FTimeZoneID;

    // the complete offset including DayLight/Standard Time Bias
    property LocalTimeOffset:TDateTime read GetLocalTimeOffset;
  published

    {Specifies the current bias, in minutes, for local time translation on
    this computer. The bias is the difference, in minutes, between
    Coordinated Universal Time (UTC) and local time. All translations
    between UTC and local time are based on the following formula:
    UTC = local time + bias}
    property Bias: LongInt read FBias write SetDummyLongInt stored false;

    {DaylightBias
    Specifies a bias value to be used during local time translations that
    occur during daylight time. This member is ignored if a value for the
    DaylightDate member is not supplied.
    This value is added to the value of the Bias member to form the bias
    used during daylight time. In most time zones, the value of this member is  - 60.}
    property DayLightBias: LongInt read FDayLightBias write SetDummyLongInt stored false;

    {StandardBias
    Specifies a bias value to be used during local time translations that
    occur during standard time. This member is ignored if a value for the
    StandardDate member is not supplied.
    This value is added to the value of the Bias member to form the bias
    used during standard time. In most time zones, the value of this member
    is zero.}
    property StandardBias: LongInt read FStdBias write SetDummyLongInt stored false;

    property DayLightName: string read FDayLightName write SetDummyString stored false;
    property StandardName: string read FStdName write SetDummyString stored false;
    property DayLightDateExt: String read FDayLightDateString write SetDummyString stored false;
    property StandardDateExt: String read FStdDateString write SetDummyString stored false;

    property DayLightDate: TDateTime read FDayLightDate write SetDummyDate stored false;
    property StandardDate: TDateTime read FStdDate write SetDummyDate stored false;

    // Allows programmer to select which information is shown
    property DisplayInfo:TLMDSysTimeZoneDisplayInfos read FDisplayInfo write SetDisplayInfo default def_TLMDSysTimeZoneDisplayInfos;

  end;

// converts NumberdayInMonth. WeekDay in Month for current year to TDateTime
// e.g. "4th sunday in October"
function LMDSysGetDateTimeExt(NumberDayInMonth, WeekDay, Month:Word; ATime:TDateTime=0):TDateTime;

implementation
uses
  SysUtils;

{------------------------------------------------------------------------------}
function LMDSysGetDateTimeExt(NumberDayInMonth, WeekDay, Month:Word; ATime: TDateTime = 0): TDateTime;
var
  y, m, d, dummy, day:Word;
begin
  DecodeDate(Now, y, dummy, dummy);
  m:=Month;
  d:=1;
  result:=EncodeDate(y, m, d);
  day:=DayOfWeek(result);
  while day<>WeekDay do
    begin
      Inc(d);
      Inc(day);
      if day=8 then day:=0;
    end;
  d:=d+((NumberDayInMonth-1)*7);
  if d>MonthDays[IsLeapYear(y), m] then
    Dec(d, 7);
  result := EncodeDate(y, m, d) + ATime;
end;

{ **************************************************************************** }
{ --------------------------------- private ---------------------------------- }

procedure TLMDSysTimeZoneObject.SetDummyLongInt(aValue: LongInt);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysTimeZoneObject.SetDummyString(aValue: string);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDSysTimeZoneObject.SetDummyDate(aValue: TDateTime);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysTimeZoneObject.SetDisplayInfo(const Value: TLMDSysTimeZoneDisplayInfos);
begin
  if FDisplayInfo<>Value then
    begin
      FDisplayInfo := Value;
      RegisterProperties;
    end;
end;

{ ------------------------------- public ------------------------------------- }
procedure TLMDSysTimeZoneObject.RegisterProperties;
var
  i:TLMDSysTimeZoneDisplayInfo;
begin
  FPropertiesDesc.Clear;
  for i:=Low(TLMDSysTimeZoneDisplayInfo) to High(TLMDSysTimeZoneDisplayInfo) do
    if i in FDisplayInfo then
      FPropertiesDesc.Add(Ord(i), LMDSysTimeZoneProps[i].Name, LMDSysTimeZoneProps[i].Description);
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDSysTimeZoneObject.Create;
begin
  FDisplayInfo:=def_TLMDSysTimeZoneDisplayInfos;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
//procedure TLMDSysTimeZoneObject.GetValues(aText: TStrings);
//begin
//end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysTimeZoneObject.Refresh;
var
  i:TLMDSysTimeZoneDisplayInfo;

begin
  DoProgress(sLMDSysTimeZoneObjectsTitle, 100, 0);
  FPropertiesDesc.InvalidateProperties;

  Init;  // Values can change during a Windows session, so get them again
  DoProgress(sLMDSysTimeZoneObjectsTitle, 100, 50);

   for i:=Low(TLMDSysTimeZoneDisplayInfo) to High(TLMDSysTimeZoneDisplayInfo) do
    if i in FDisplayInfo then
      with FPropertiesDesc.PropertyByID(Ord(i)) do
        case i of
           tpidBias: Text:=IntToStr(FBias);
           tpidTimezoneID: Text:=sLMDSysTimeZoneID[FTimezoneID];
           tpidDayLightBias: Text:=IntToStr(FDayLightBias);
           tpidStandardBias: Text:=IntToStr(FStdBias);
           tpidDayLightName: Text:=FDayLightName;
           tpidStandardName: Text:=FStdName;
           tpidDayLightDateString: Text:=FDayLightDateString;
           tpidStandardDateString: Text:=FStdDateString;
           tpidDayLightDate: Text:=DateTimeToStr(FDayLightDate);
           tpidStandardDate: Text:=DateTimeToStr(FStdDate);
         end;

  DoProgress(sLMDSysTimeZoneObjectsTitle, 100, 100);
  DoProgress('', 100, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysTimeZoneObject.Apply;
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysTimeZoneObject.Init;
var
  tzi: TTimeZoneInformation;

  function GetDayInMonth(Value:Byte):String;
  begin
    case Value of
      1:result:=sLMDSysFirst; //1.
      2:result:=sLMDSysSecond; //2.
      3:result:=sLMDSysThird; //3.
      4:result:=sLMDSysFourth; //4.
      5:result:=sLMDSysLast; //5. = last - weekday
    else
      result:=sLMDSysUnknown;
    end;
  end;

begin

  case GetTimeZoneInformation(tzi) of
    TIME_ZONE_ID_STANDARD:
      FTimeZoneID:=stzStandard;
    TIME_ZONE_ID_DAYLIGHT:
      FTimeZoneID:=stzDayLight;
  else
    FTimeZoneID:=stzUnknown;
  end;

  with tzi do
    begin
      FBias:=tzi.Bias;

      FDayLightName:= WideCharToString(DayLightName);
      FDayLightBias:= tzi.DayLightBias;

      {To select the correct day in the month, set the wYear member to zero, the wDayOfWeek
       member to an appropriate weekday, and the wDay member to a value in the range 1 through 5.
       Using this notation, the first Sunday in April can be specified, as can the last Thursday
       in October (5 is equal to "the last").}
      if DaylightDate.wYear=0 then
        FDayLightDateString:=GetDayInMonth(DaylightDate.wDay) + ' ' +
                             {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongDayNames[1+DaylightDate.wDayofWeek] +
                             ' '+sLMDSysof+' '+
                             {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongMonthNames[DaylightDate.wMonth]
      else
        FDayLightDateString:=Format('%2.2d/%2.2d/%4.4 %2.2d:%2.2d:%2.2d ',
           [DaylightDate.wMonth, DaylightDate.wDay, DaylightDate.wYear, DaylightDate.wHour, DaylightDate.wMinute, DaylightDate.wSecond]);

      {if DaylightDate.wMonth = 0 then We in time zone without summer time}
      if DaylightDate.wMonth <> 0 then
        FDayLightDate := LMDSysGetDateTimeExt(DaylightDate.wDay, DaylightDate.wDayofWeek, DaylightDate.wMonth, EncodeTime(DaylightDate.wHour, DaylightDate.wMinute, DaylightDate.wSecond, 0))
      else
        FDayLightDate := 0;

     // Std
     FStdName:= WideCharToString(StandardName);
     FStdBias:= tzi.StandardBias;
     if StandardDate.wYear=0 then
       FStdDateString := GetDayInMonth(StandardDate.wDay) + ' ' +
                        {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongDayNames[1+StandardDate.wDayofWeek] + ' '+
                        sLMDSysof+' ' + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongMonthNames[StandardDate.wMonth]
     else
       FStdDateString:=StandardName + Format('%2.2d/%2.2d/%4.4d %2.2d:%2.2d:%2.2d ',
         [StandardDate.wMonth, StandardDate.wDay, StandardDate.wYear, StandardDate.wHour, StandardDate.wMinute, StandardDate.wSecond]);
     if StandardDate.wMonth <> 0 then
       FStdDate := LMDSysGetDateTimeExt(StandardDate.wDay, StandardDate.wDayofWeek, StandardDate.wMonth, EncodeTime(StandardDate.wHour, StandardDate.wMinute, StandardDate.wSecond,0))
     else
       FStdDate := 0;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysTimeZoneObject.GetElementTitle : string;
begin
  result := sLMDSysTimeZoneObjectsTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysTimeZoneObject.GetElementDescription : string;
begin
  result := sLMDSysTimeZoneStatusObjectsDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysTimeZoneObject.GetElementType : TLMDSysInfoType;
begin
  result := itTimeZone;
end;

{------------------------------------------------------------------------------}
function TLMDSysTimeZoneObject.GetLocalTimeOffset: TDateTime;
begin
  result:=GetLocalTimeOffsetMinutes/LMDMinutesPerDay;
end;

{------------------------------------------------------------------------------}
function TLMDSysTimeZoneObject.GetLocalTimeOffsetMinutes: LongInt;
begin
  case FTimeZoneID of
    stzStandard:result:=(FBias+FStdBias);
    stzDayLight:result:=(FBias+FDayLightBias);
  else
    result:=FBias;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysTimeZoneObject.GetCoordinatedUniversalTime: TDateTime;
begin
  Result:= Now + GetLocalTimeOffset;
end;

end.
