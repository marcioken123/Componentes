unit LMDSysInfo;
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

LMDSysInfo unit ()
------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, SysUtils,
  LMDTypes, LMDSysIn, LMDCPUInfoObject, LMDCustomComponent;

type
  TLMDSysInfo = class(TLMDCustomComponent)
  private
    FEnvironment:TStringList;
    FCPUInfo:TLMDCPUInfoObject;
    procedure Dummy(index: Integer; aString:String);
    procedure DummyInt(index: Integer; AInt:LongInt);
    procedure DummyInt64(index: Integer; const AInt:Int64);
    procedure DummyByte(aByte:Byte);
    procedure DummyStrings(AList:TStringList);
    procedure DummyBool(index: Integer; aBool:Boolean);

    function GetInfoString(index : Integer):String;
    function GetInfoLongInt(index : Integer):LongInt;
    function GetInfoLongLongInt(index : Integer):Int64;

    function GetFileName:String;
    function GetFonts:TStringList;
    function GetPrinters:TStringList;

    function GetProcessorNumber:Byte;
    function GetColorDepth:Byte;

    // ver 4.
    function GetInfoBool(index: Integer):Boolean;
    procedure SetInfoBool(index: Integer; State:Boolean);
    function GetEnvString:TStringList;
    function GetKeyboardDelay:LongInt;
     procedure SetKeyboardDelay(aValue:LongInt);
    function GetKeyboardSpeed:LongInt;
     procedure SetKeyboardSpeed(aValue:LongInt);
    function GetLocalInfo (index : Integer) : String;
    procedure SetLocalInfo (index : Integer; aValue : String);
    // *-*
//    procedure SetCPUInfo (aValue : TLMDCPUInfoObject);
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;

    function FreeSys:TLMDPercent;
    function FreeGDI:TLMDPercent;
    function FreeUSR:TLMDPercent;
    property TempFileName:String read GetFileName;
    {Procedure GetModuleList(aList:TStringList);
    Procedure GetProcessList(aList:TStringList);}
    Procedure GetDriveList(aList:TStringList);
    function  GetDriveInfo(aDrive:String):TLMDDriveInfo;
    function  GetDriveTypeString(aType:UInt):String;

    // ver 4.
    function GetEnvironmentValue(aEnvironmentString:String):String;
    function SetEnvironmentValue(aEnvironmentString:String; const aValue:String):Boolean;
    procedure SetDesktopWallpaper(const aBitmapPath:TFileName);
    function GetScreenRect:TRect;
    function GetWorkRect:TRect;
    // *-*

    {only compatibility}
    property Username:String index 2 read GetInfoString;
    property UserCompany:String index 1 read GetInfoString;

  published
    property About;
    property AllFonts:TStringList read GetFonts write DummyStrings stored false;
    property AllPrinters:TStringList read GetPrinters write DummyStrings stored false;

    property CurrentUser:String index 0 read GetInfoString write Dummy stored false;
    property RegisteredCompany:String  index 1 read GetInfoString write Dummy stored false;
    property RegisteredOwner:String  index 2 read GetInfoString write Dummy stored false;

    property ScreenSaverDelay: Longint index 7 read GetInfoLongInt write DummyInt Stored false;
    property VersionWIN:String index 3 read GetInfoString write Dummy stored false;
    property WinPath:String index 4 read GetInfoString write Dummy stored false;
    property WinSysPath:String  index 5 read GetInfoString write Dummy stored false;

    property Environment:TStringList read GetEnvString write DummyStrings stored false;
    property FreeGdiRes:String index 6 read GetInfoString write Dummy stored false;
    property FreeUsrRes:String index 7 read GetInfoString write Dummy stored false;
    property FreeSysRes:String index 8 read GetInfoString write Dummy stored false;
    property BuildNumber:LongInt index 0 read GetInfoLongInt write DummyInt stored False;
    property MemPhysTotal:Int64 index 1 read GetInfoLongLongInt write DummyInt64 stored false;
    property MemPhysFree:Int64 index 2 read GetInfoLongLongInt write DummyInt64 stored false;
    property MemVirtTotal:Int64 index 3 read GetInfoLongLongInt write DummyInt64 stored false;
    property MemVirtFree:Int64 index 4 read GetInfoLongLongInt write DummyInt64 stored false;
    property MemVirtExtended:Int64 index 7 read GetInfoLongLongInt write DummyInt64 stored false;
    property MemPageTotal:Int64 index 5 read GetInfoLongLongInt write DummyInt64 stored false;
    property MemPageFree:Int64 index 6 read GetInfoLongLongInt write DummyInt64 stored false;
    property MemoryLoaded:String index 9 read GetInfoString write Dummy stored false;
    property Platform:String index 10 read GetInfoString write Dummy stored false;
    property TempPath:String index 11 read GetInfoString write Dummy stored false;
    property Computername:String index 12 read GetInfoString write Dummy stored false;
    property ProcessorNumber:Byte read GetProcessorNumber write DummyByte stored false;
    property ProcessorType:String index 13 read GetInfoString write Dummy stored false;
    property ProcessorInfo : TLMDCPUInfoObject read FCPUInfo;
    // ver 4.
    property ColorDepth: Byte read GetColorDepth write DummyByte stored false;
    property DefaultLanguageString: String index 14 read GetInfoString write Dummy stored false;
    property TimeZone: String index 15 read GetInfoString write Dummy stored false;
    property TimeZoneDiff: LongInt index 9 read GetInfoLongInt write DummyInt stored false;
    property PlusAvailable:Boolean index 9 read GetInfoBool write DummyBool stored false;
    property ScreenWidth:LongInt index 10 read GetInfoLongInt write DummyInt stored false;
    property ScreenHeight:LongInt index 11 read GetInfoLongInt write DummyInt stored false;
    property ScreenPPi:LongInt index 12 read GetInfoLongInt write DummyInt stored false;

    // changeable properties

    property LocaleCalendarType : String index 0 read GetLocalInfo write SetLocalInfo stored false; //
    property LocaleCurrencyDigits : String index 1 read GetLocalInfo write SetLocalInfo stored false; //
    property LocaleICurrency : String index 2 read GetLocalInfo write SetLocalInfo stored false;
    property LocaleDigits : String index 3 read GetLocalInfo write SetLocalInfo stored false; //
    property LocaleFirstDayOfWeek : String index 4 read GetLocalInfo write SetLocalInfo stored false;
    property LocaleFirstWeekOfYear : String index 5 read GetLocalInfo write SetLocalInfo stored false;
    property LocaleZero : String index 6 read GetLocalInfo write SetLocalInfo stored false;
    property LocaleMeasureSystem : String index 7 read GetLocalInfo write SetLocalInfo stored false;
    property LocaleNegativeCurrencyFormat : String index 8 read GetLocalInfo write SetLocalInfo stored false;
    property LocaleNegativeNumberFormat : String index 9 read GetLocalInfo write SetLocalInfo stored false;
    property LocaleTime : String index 10 read GetLocalInfo write SetLocalInfo stored false;
    property LocaleMorningSymbol: String index 11 read GetLocalInfo write SetLocalInfo stored false; //
    property LocaleAfternoonSymbol : String index 12 read GetLocalInfo write SetLocalInfo stored false; //
    property LocaleCurrencySymbol : String index 13 read GetLocalInfo write SetLocalInfo stored false; //
    property LocaleDateSeparator : String index 14 read GetLocalInfo write SetLocalInfo stored false; //
    property LocaleDecimalSeparator : String index 15 read GetLocalInfo write SetLocalInfo stored false; //
    property LocaleNumericGrouping : String index 16 read GetLocalInfo write SetLocalInfo stored false; //
    property LocaleListSeparator : String index 17 read GetLocalInfo write SetLocalInfo stored false; //
    property LocaleLongDateFormat : String index 18 read GetLocalInfo write SetLocalInfo stored false; //
    property LocaleMonthDecimalSeparator : String index 19 read GetLocalInfo write SetLocalInfo stored false;
    property LocaleCurrencyGrouping : String index 20 read GetLocalInfo write SetLocalInfo stored false; //
    property LocaleThousandSeparator : String index 21 read GetLocalInfo write SetLocalInfo stored false;
    property LocaleNegativeSign : String index 22 read GetLocalInfo write SetLocalInfo stored false; //
    property LocalePositiveSign : String index 23 read GetLocalInfo write SetLocalInfo stored false;
    property LocaleShortDateFormat : String index 24 read GetLocalInfo write SetLocalInfo stored false; //
    property LocaleThousand : String index 25 read GetLocalInfo write SetLocalInfo stored false; //
    property LocaleTimeSeparator : String index 26 read GetLocalInfo write SetLocalInfo stored false; //
    property LocaleShortTimeFormat : String index 27 read GetLocalInfo write SetLocalInfo stored false; //

    property NumLockState:Boolean index 0 read GetInfoBool write SetInfoBool stored false;
    property CapsLockState:Boolean index 1 read GetInfoBool write SetInfoBool stored false;
    property ScrollLockState:Boolean index 2 read GetInfoBool write SetInfoBool stored false;

    property DefaultLanguageID: LongInt index 8 read GetInfoLongInt stored false;

    property KeyboardDelay:LongInt read GetKeyboardDelay write SetKeyboardDelay stored false;
    property KeyboardSpeed:LongInt read GetKeyboardSpeed write SetKeyboardSpeed stored false;

    property WindowAnimation:Boolean index 3 read GetInfoBool write SetInfoBool stored false;
    property WarningBeep:Boolean index 4 read GetInfoBool write SetInfoBool stored false;
    property ScreenSaveActive:Boolean index 5 read GetInfoBool write SetInfoBool stored false;
    property FontSmoothing:Boolean index 6 read GetInfoBool write SetInfoBool stored false;
    property DragFullWindows:Boolean index 7 read GetInfoBool write SetInfoBool stored false;
    property SnapToDefaultButton:Boolean index 8 read GetInfoBool write SetInfoBool stored false;
    // *-*
  end;

implementation

uses

  Printers,
  Forms,
  LMDProcs;

{------------------------- Private --------------------------------------------}
function TLMDSysInfo.GetInfoString(index : Integer) : String;
var

  temp:array[0..255] of char;

begin
  case index of
    // GetUserName
    0: result:=LMDSIUserName;

    // GetRegisteredCompany
    1: result:=LMDSIRegisteredCompany;

    // GetRegisteredOwner
    2: result:=LMDSIRegisteredOwner;

    // GetVersionWin
    3: result:=LMDSIVersionStr;

    // GetWindowsDir
    4: result:=LMDSIWindowsDirectory;

    // GetWindowsSysDir
    5: result:=LMDSISystemDirectory;

    // GetFreeGDI
    6: result:=format('%d %%',[FreeGDI]);

    // GetFreeUsr
    7: result:=format('%d %%',[FreeUSR]);

    // GetFreeSys
    8: result:=format('%d %%',[FreeSys]);

    // GetMemLoaded
    9: result:=format('%d %%', [LMDSIMemLoaded]);

    // GetPlatform
    10: result:=LMDSIPlatformStr;

    // GetTempPath
    11: result:=LMDSITempPath;

    // GetComputername
    12: result:=LMDSIComputername;

    // GetProcessorType
    13: result:=LMDSIProcessorTypeStr;

    // GetDefaultLanguage
    14:
      begin

        VerLanguageName(LMDSISystemDefaultLanguageID, temp, 255);
        result := temp;

      end;

    // GetTimeZone
    15:
      begin
        result := LMDSIGetTimeZone;
      end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysInfo.GetInfoLongInt(index : Integer):LongInt;
begin
  result:=0;
  case index of
    // GetBuildNumber
    0: result:=LMDSIBuildNr;

    // GetSSDelay
    7: result:=LMDSIScreenSaverDelay;

    // GetLanguageID
    8: result:=LMDSISystemDefaultLanguageID;

    // TimeZoneBias
    9: result:=LMDSIGetTimeZoneBias;

    // Screenwidth
    10: result := Screen.Width;

    // Screenheight
    11: result := Screen.Height;

    // ScreeNppi
    12: result := Screen.PixelsPerInch;

  end;
end;
{ ---------------------------------------------------------------------------- }
function TLMDSysInfo.GetInfoLongLongInt(index : Integer):Int64;
begin
  case index of
    // GetMemTotal
    1: result:=Int64(LMDSIMemTotal div 1024);

    // GetMemFree
    2: result:=Int64(LMDSIMemFree div 1024);

    // GetMemVirtTotal
    3: result:=Int64(LMDSIMemVirtTotal div 1024);

    // GetMemVirtFree
    4: result:=Int64(LMDSIMemVirtFree div 1024);

    // GetMemPageTotal
    5: result:=Int64(LMDSIMemPageTotal div 1024);

    // GetMemPageFree
    6: result:=Int64(LMDSIMemPageFree div 1024);

    // GetMemPageFree
    7: result:=Int64(LMDSIMemVirtExtended div 1024);

  else
    result:=0;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysInfo.GetInfoBool(index: Integer):Boolean;
  function Bool_SystemParametersInfo(uiAction: UINT): Bool;
  begin

    SystemParametersInfo(uiAction, 0, @Result, 0);

  end;

var
  temp: TAnimationInfo;
begin
  Result := False;

  case index of
     0: result := LMDSINumLock;
     1: result := LMDSICapsLock;
     2: result := LMDSIScrollLock;

     // GetAnimation
     3:
       begin

         temp.cbSize := sizeof (TAnimationInfo);
         SystemParametersInfo(SPI_GETANIMATION, SizeOf(TAnimationInfo), @temp, 0);

         result := (temp.iMinAnimate <> 0);
       end;

     // GetBeep
     4: Result := Bool_SystemParametersInfo(SPI_GETBEEP);

     // GetScreenSave
     5: Result := Bool_SystemParametersInfo(SPI_GETSCREENSAVEACTIVE);

     // GetFontSmoothing
     6: if LMDSIWindowsExtension then
          Result := Bool_SystemParametersInfo(SPI_GETFONTSMOOTHING)
        else
          result := false;

     // GetDragFullWindows
     7: if LMDSIWindowsExtension then
          Result := Bool_SystemParametersInfo(SPI_GETDRAGFULLWINDOWS)
        else
          result:=false;

     // GetSnapToDefButton
     8: if LMDSIWindowsNT then
          Result := Bool_SystemParametersInfo(SPI_GETSNAPTODEFBUTTON)
        else
          result := false;

     // GetWindowsExtension
     9: result := LMDSIWindowsExtension;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysInfo.SetInfoBool(index: Integer; State:Boolean);
var
  keys: TKeyBoardState;
  temp: TAnimationInfo;
  aValue: Boolean;
begin
  aValue:=State;
  case index of
    0: if LMDSINumLock <> State then
         if LMDSIWindowsNT then
           begin
             keybd_event(VK_NUMLOCK, $45, KEYEVENTF_EXTENDEDKEY or 0, 0);
             keybd_event(VK_NUMLOCK, $45, KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP, 0);
           end
         else
           begin
             GetKeyBoardState (keys);
             if State = true then keys[VK_NUMLOCK] := 1
               else keys[VK_NUMLOCK] := 0;
             Windows.SetkeyboardState (keys);
           end;
    1: if LMDSICapsLock <> State then
         if LMDSIWindowsNT then
           begin
             keybd_event(VK_CAPITAL, $45, KEYEVENTF_EXTENDEDKEY or 0, 0);
             keybd_event(VK_CAPITAL, $45, KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP, 0);
           end
         else
           begin
             GetKeyBoardState (keys);
             if State = true then keys[VK_CAPITAL] := 1
               else keys[VK_CAPITAL] := 0;
             Windows.SetkeyboardState (keys);
           end;
    2: if LMDSIScrollLock <> State then
         if LMDSIWindowsNT then
           begin
             keybd_event(VK_SCROLL, $45, KEYEVENTF_EXTENDEDKEY or 0, 0);
             keybd_event(VK_SCROLL, $45, KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP, 0);
           end
         else
           begin
             GetKeyBoardState (keys);
             if State = true then keys[VK_SCROLL] := 1
               else keys[VK_SCROLL] := 0;
             Windows.SetkeyboardState (keys);
           end;

    // SetAnimation
    3: if WindowAnimation<>aValue then
        begin

          temp.cbSize := sizeof (TAnimationInfo);
          SystemParametersInfo(SPI_GETANIMATION, SizeOf(TAnimationInfo), @temp, 0);
          temp.iMinAnimate := Ord(aValue);
          SystemParametersInfo(SPI_SETANIMATION, SizeOf(TAnimationInfo), @temp, SPIF_UPDATEINIFILE or SPIF_SENDWININICHANGE);

        end;

    // SetBeep
    4: if aValue<>WarningBeep then
         SystemParametersInfo(SPI_SETBEEP, Ord(aValue), nil, SPIF_UPDATEINIFILE or SPIF_SENDWININICHANGE);

    // SetScreenSave
    5: if ScreenSaveActive<>aValue then
         SystemParametersInfo(SPI_SETSCREENSAVEACTIVE, Ord(aValue), nil, SPIF_UPDATEINIFILE or SPIF_SENDWININICHANGE);

    // SetFontSmoothing
    6: if LMDSIWindowsExtension and (FontSmoothing<>aValue) then
         SystemParametersInfo(SPI_SETFONTSMOOTHING, Ord(aValue), nil, SPIF_UPDATEINIFILE or SPIF_SENDWININICHANGE);

    // SetDragFullWindows
    7: if LMDSIWindowsExtension and (aValue<>DragFullWindows) then
         SystemParametersInfo(SPI_SETDRAGFULLWINDOWS, Ord(aValue), nil, SPIF_UPDATEINIFILE or SPIF_SENDWININICHANGE);

    // SetSnapToDefButton
    8: if LMDSIWindowsNT and (aValue<>SnapToDefaultButton) then
         SystemParametersInfo(SPI_SETSNAPTODEFBUTTON, Ord(aValue), nil , SPIF_UPDATEINIFILE or SPIF_SENDWININICHANGE);
  end;
end;

{------------------------------------------------------------------------------}

function TLMDSysInfo.GetEnvironmentValue(aEnvironmentString:String):String;
var
  R: string;

  OutputStr:array[0..255] of char;

begin

  ExpandEnvironmentStrings(PChar(aEnvironmentString), OutputStr, SizeOf(OutputStr));
  R := OutputStr;

  if R <> aEnvironmentString  then
    result := R                          // success
  else
    result := '';                          // error
end;

{------------------------------------------------------------------------------}
function TLMDSysInfo.SetEnvironmentValue(aEnvironmentString:String; const aValue:String):Boolean;
begin
  if SetEnvironmentvariable(Int_Ref(aEnvironmentString), Int_Ref(aValue))
    then result := true                                // success
  else result := false;                                // error
end;

{------------------------------------------------------------------------------}
function TLMDSysInfo.GetEnvString:TStringList;
begin
  LMDSIEnvironment(FEnvironment);
  result := FEnvironment;
end;

{------------------------------------------------------------------------------}
function TLMDSysInfo.FreeSys:TLMDPercent;
begin
  if LMDSIWindowsNT then
    result:=0
  else
    result:=LMDSIFreeSysRes;
end;

{------------------------------------------------------------------------------}
function TLMDSysInfo.GetFileName:String;
begin
 result:=LMDSITempFile;
end;

{------------------------------------------------------------------------------}
function TLMDSysInfo.GetFonts:TStringList;
begin
  result:=TStringList(screen.Fonts);
  result.sorted:=true;
end;

{------------------------------------------------------------------------------}
function TLMDSysInfo.GetPrinters:TStringList;
begin
  result:=TStringList(printer.printers);
  result.Sorted:=true;
end;

{------------------------------------------------------------------------------}
function TLMDSysInfo.FreeGDI:TLMDPercent;
begin
  if LMDSIWindowsNT then
    result:=0
  else
   result:=LMDSIFreeGDIRes;
end;

{------------------------------------------------------------------------------}
function TLMDSysInfo.FreeUSR:TLMDPercent;
begin
  if LMDSIWindowsNT then
    result := 0
  else
    result := LMDSIFreeUserRes;
end;

{------------------------------------------------------------------------------}
function TLMDSysInfo.GetProcessorNumber:Byte;
begin
  result := LMDSIProcessorCount;
end;

{------------------------------------------------------------------------------}
Procedure TLMDSysInfo.GetDriveList(aList:TStringList);
begin
  LMDSIDriveList(aList);
end;

{------------------------------------------------------------------------------}
function  TLMDSysInfo.GetDriveInfo(aDrive:String):TLMDDriveInfo;
begin
  result := LMDSIDriveInfo(aDrive);
end;

{------------------------------------------------------------------------------}
function  TLMDSysInfo.GetDriveTypeString(aType:UInt):String;
begin
  result := LMDSIDriveTypeStr(aType);
end;

{------------------------------------------------------------------------------}
{Procedure TLMDSysInfo.GetModuleList(aList:TStringList);
begin
end;

{------------------------------------------------------------------------------}
{Procedure TLMDSysInfo.GetProcessList(aList:TStringList);
begin
end;}

{--------------------- ver 4.0 ------------------------------------------------}
function TLMDSysInfo.GetColorDepth:Byte;
begin
  result := LMDSIColorDepth;
end;

{------------------------------------------------------------------------------}

procedure TLMDSysInfo.SetDesktopWallpaper(const aBitmapPath:TFileName);
begin
  SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, Int_Ref(aBitmapPath),
                       SPIF_UPDATEINIFILE or SPIF_SENDWININICHANGE)
end;

{------------------------------------------------------------------------------}
function TLMDSysInfo.GetKeyboardDelay:LongInt;
begin

  SystemParametersInfo(SPI_GETKEYBOARDDELAY, 0, @result, 0)

end;

{------------------------------------------------------------------------------}
procedure TLMDSysInfo.SetKeyboardDelay(aValue:LongInt);
begin
  if aValue<>KeyBoardDelay then
    SystemParametersInfo(SPI_SETKEYBOARDDELAY, aValue, nil, SPIF_UPDATEINIFILE or SPIF_SENDWININICHANGE)
end;

{------------------------------------------------------------------------------}
function TLMDSysInfo.GetKeyboardSpeed:LongInt;
begin

  SystemParametersInfo(SPI_GETKEYBOARDSPEED, 0, @result, 0)

end;

{------------------------------------------------------------------------------}
procedure TLMDSysInfo.SetKeyboardSpeed(aValue:LongInt);
begin
  if aValue<>KeyBoardSpeed then
    SystemParametersInfo(SPI_SETKEYBOARDSPEED, aValue, nil, SPIF_UPDATEINIFILE or SPIF_SENDWININICHANGE)
end;

{------------------------------------------------------------------------------}
function TLMDSysInfo.GetLocalInfo (index : Integer) : String;
var
  locale : Integer;
  DefaultLCID: LCID;

begin
  DefaultLCID := GetThreadLocale;
  locale := 0;
  case index of 
     0 : locale := LOCALE_ICALENDARTYPE;
     1 : locale := LOCALE_ICURRDIGITS;
     2 : locale := LOCALE_ICURRENCY;
     3 : locale := LOCALE_IDIGITS;
     4 : locale := LOCALE_IFIRSTDAYOFWEEK;
     5 : locale := LOCALE_IFIRSTWEEKOFYEAR;
     6 : locale := LOCALE_ILZERO;
     7 : locale := LOCALE_IMEASURE;
     8 : locale := LOCALE_INEGCURR;
     9 : locale := LOCALE_INEGNUMBER;
    10 : locale := LOCALE_ITIME;
    11 : locale := LOCALE_S1159;
    12 : locale := LOCALE_S2359;
    13 : locale := LOCALE_SCURRENCY;
    14 : locale := LOCALE_SDATE;
    15 : locale := LOCALE_SDECIMAL;
    16 : locale := LOCALE_SGROUPING;
    17 : locale := LOCALE_SLIST;
    18 : locale := LOCALE_SLONGDATE;
    19 : locale := LOCALE_SMONDECIMALSEP;
    20 : locale := LOCALE_SMONGROUPING;
    21 : locale := LOCALE_SMONTHOUSANDSEP;
    22 : locale := LOCALE_SNEGATIVESIGN;
    23 : locale := LOCALE_SPOSITIVESIGN;
    24 : locale := LOCALE_SSHORTDATE;
    25 : locale := LOCALE_STHOUSAND;
    26 : locale := LOCALE_STIME;
    27 : locale := LOCALE_STIMEFORMAT;
  end;

  Result := GetLocaleStr (DefaultLCID, locale, 'Hallo');

end;

{------------------------------------------------------------------------------}
procedure TLMDSysInfo.SetLocalInfo (index : Integer; aValue : String);
var
  locale : Integer;
  DefaultLCID: LCID;

  s : Array[0..2048] of Char;

begin
  DefaultLCID := GetThreadLocale;
  locale := 0;
  case index of
     0 : locale := LOCALE_ICALENDARTYPE;
     1 : locale := LOCALE_ICURRDIGITS;
     2 : locale := LOCALE_ICURRENCY;
     3 : locale := LOCALE_IDIGITS;
     4 : locale := LOCALE_IFIRSTDAYOFWEEK;
     5 : locale := LOCALE_IFIRSTWEEKOFYEAR;
     6 : locale := LOCALE_ILZERO;
     7 : locale := LOCALE_IMEASURE;
     8 : locale := LOCALE_INEGCURR;
     9 : locale := LOCALE_INEGNUMBER;
    10 : locale := LOCALE_ITIME;
    11 : locale := LOCALE_S1159;
    12 : locale := LOCALE_S2359;
    13 : locale := LOCALE_SCURRENCY;
    14 : locale := LOCALE_SDATE;
    15 : locale := LOCALE_SDECIMAL;
    16 : locale := LOCALE_SGROUPING;
    17 : locale := LOCALE_SLIST;
    18 : locale := LOCALE_SLONGDATE;
    19 : locale := LOCALE_SMONDECIMALSEP;
    20 : locale := LOCALE_SMONGROUPING;
    21 : locale := LOCALE_SMONTHOUSANDSEP;
    22 : locale := LOCALE_SNEGATIVESIGN;
    23 : locale := LOCALE_SPOSITIVESIGN;
    24 : locale := LOCALE_SSHORTDATE;
    25 : locale := LOCALE_STHOUSAND;
    26 : locale := LOCALE_STIME;
    27 : locale := LOCALE_STIMEFORMAT;
  end;

  StrPCopy (s, aValue);
  SetLocaleInfo (DefaultLCID, locale, @s);

end;

{------------------------------------------------------------------------------}
function TLMDSysInfo.GetScreenRect:TRect;
begin
  result.Left := 0;
  result.Top := 0;
  result.Right := Screen.Width;
  result.Bottom := Screen.Height;
end;

{------------------------------------------------------------------------------}
function TLMDSysInfo.GetWorkRect:TRect;
begin

  SystemParametersInfo(SPI_GETWORKAREA, 0, @result, 0)

end;

{--------------------  Public -------------------------------------------------}
constructor TLMDSysInfo.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FEnvironment:=TStringList.Create;
  FCPUInfo:=TLMDCPUInfoObject.Create;
end;

{------------------------------------------------------------------------------}
destructor  TLMDSysInfo.Destroy;
begin
  FCPUInfo.Free;
  FEnvironment.Free;
  inherited destroy;
end;

{------------------------------------------------------------------------------}
Procedure TLMDSysInfo.Dummy(index: Integer; aString:String);
begin
end;

{------------------------------------------------------------------------------}
Procedure TLMDSysInfo.DummyInt(index: Integer; AInt:LongInt);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDSysInfo.DummyInt64(index: Integer; const AInt:Int64);
begin
end;

{------------------------------------------------------------------------------}
Procedure TLMDSysInfo.DummyByte(AByte:Byte);
begin
end;

{------------------------------------------------------------------------------}
Procedure TLMDSysInfo.DummyBool(index:Integer; aBool:Boolean);
begin
end;

{------------------------------------------------------------------------------}
Procedure TLMDSysInfo.DummyStrings(aList:TStringList);
begin
end;

end.

