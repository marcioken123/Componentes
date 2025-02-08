unit LMDSysIn;
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

LMDSysIn unit (RM, JH)
----------------------

Changes
-------
Release 2014 (October 2013)
 + Added Windows 8.1 + Windows Server 2012 R2 detection

Release 2013 (June 2012)
 + Added Windows 8, Windows Server 2008, Windows Server 2012 detection

Release 9.1 (June 2009)
 + Added Windows 7 determination

Release 9.0 (April 2008)
* LMDSIPlatformStr improved

Release 8.06 (March 2008)
* LMDSI[..] variables slightly changed

Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes;

const
  NC_ADJUSTRIGHT = 1;
  NC_ADJUSTLEFT = 2;
  NC_SMALLCAPTION = 4;
  NC_HASICON = 8;
  NC_ISICONIC = 16;
  NC_SINGLEBORDER = 32;

type
  { used by LMDInformationLabel }
  TLMDInfoType = (
    itUser,
    itWinDir,
    itCurrentDir32,
    itCurrentDiskFree32,
    itCurrentDiskSize32,
    itSystemDir,
    itReg_Owner32,
    itReg_Company32,
    itVersion,
    itColorDepth,
    itScreenSaverDelay,
    itMemSize,
    itFreeSysRes,
    itFreeGDIRes,
    itFreeUserRes,
    itComputerName32,
    itMajorVerNr32,
    itBuildNr32,
    itMemLoaded32,
    itMemFree32,
    itMemPageFree32,
    itMemPageTotal32,
    itMemVirtFree32,
    itMemVirtTotal32,
    itPlatformID32,
    itPlatform32,
    itProcessorCont32,
    itProcessor32,
    itTempPath32,
    itDOSVersion,
    itNumLock,
    itCapsLock,
    itScroll,
    itCurrentDateTime,
    itProgCompany,
    itProgName,
    itProgVersion,
    itFileVersion,
    itFileVersionFull,
    itFileVersionBuild,
    itProgCopyright,
    itProgTrademark,
    itProgDescription,
    itProgComments,
    itCPUSpeed,
    itTimeElapsedSinceBoot,
    itLastBootTime
    );

  TLMDVersionInfoType = (
    viCompany,
    viName,
    viVersion,
    viCopyright,
    viTrademark,
    viDescription,
    viComments,
    viFileVersion,
    viFileVersionFull,
    viFileVersionBuild
    );

{Nonclient-Area}
{------------------------------------------------------------------------------}
{Calculation}
procedure LMDNCCalcDrawingArea(Handle: HWND; var dRecT: TRect; var rText: TRect; var sflag: WORD);
{procedure LMDAddNCAreaToRect(var R: TRect);{Tobi: hinzugefügt}
{procedure LMDSubNCAreaFromRect(var R: TRect);{Tobi: hinzugefügt}

{Information}
function LMDNCBITMAPHEIGHT: Integer;
function LMDNCBITMAPWIDTH: Integer;

function LMDNCCAPTIONHEIGHT: Integer;

function LMDNCDLGBORDERWIDTH: Integer; {Dialog Border}
function LMDNCDLGBORDERHEIGHT: Integer;
function LMDNCFIXBORDERWIDTH: Integer; {Single-Line Border}
function LMDNCFIXBORDERHEIGHT: Integer;
function LMDNCSIZEBORDERWIDTH: Integer; {Thick Border}
function LMDNCSIZEBORDERHEIGHT: Integer;
function LMDNCBORDERWIDTH: Integer; {Tobi: hinzugefügt Thick Inner Border}
function LMDNCBORDERHEIGHT: Integer;

function LMDNCSMALLCAPTIONHEIGHT: Integer; {Tobi: verändert}
function LMDNCSMALLBITMAPHEIGHT: Integer;
function LMDNCSMALLBITMAPWIDTH: Integer;
function LMDNCCAPTIONICONHEIGHT: Integer;
function LMDNCCAPTIONICONWIDTH: Integer;

{------------------------------------------------------------------------------}

{General system information}
{------------------------------------------------------------------------------}
function LMDSIColorDepth: Byte;
function LMDSIScreenSaverDelay: Integer;
function LMDSIStretchBltPossible: Boolean;
function LMDSIFontSmoothing: Boolean;

function LMDSINumLock: Boolean;
function LMDSICapsLock: Boolean;
function LMDSIScrollLock: Boolean;

function LMDSIFreeSysRes: Word; {not NT!}
function LMDSIFreeGDIRes: Word;
function LMDSIFreeUserRes: Word;
function LMDSIMajorVersionNr: Word;
function LMDSIMinorVersionNr: Word;
function LMDSIBuildNr: Word;
function LMDSIVersionString: string;
function LMDSIOLDWindowsNT: Boolean;
{Memory}
function LMDSIMemTotal: Int64;
function LMDSIMemLoaded: Byte;
function LMDSIMemFree: Int64;
function LMDSIMemPageFree: Int64;
function LMDSIMemPageTotal: Int64;
function LMDSIMemVirtFree: Int64;
function LMDSIMemVirtTotal: Int64;
// only WinXP/Win2K and heigher
function LMDSIMemVirtExtended: Int64;

{other stuff}
{procedure LMDSIModuleList(aList:TStringList);}
function LMDSIPlatformID: DWORD;
function LMDSIPlatformStr: string;
function LMDSIProcessorCount: Byte;
function LMDSIProcessorTypeStr: string;
function LMDSIProductType: Word;
function LMDSIVIPlatformID: Word;

type
  {$IFNDEF LMDCOMP12}
  TOSVERSIONINFOEX = packed record
    dwOSVersionInfoSize: DWORD;
    dwMajorVersion: DWORD;
    dwMinorVersion: DWORD;
    dwBuildNumber: DWORD;
    dwPlatformId: DWORD;
    szCSDVersion: array[0..127] of Char;
    wServicePackMajor: WORD;
    wServicePackMinor: WORD;
    wSuiteMask: WORD;
    wProductType: BYTE;
    wReserved: BYTE;
  end;
  POSVersionInfo=^TOSVERSIONINFO;
  {$ELSE}
  TOSVERSIONINFOEX = packed record
    dwOSVersionInfoSize: DWORD;
    dwMajorVersion: DWORD;
    dwMinorVersion: DWORD;
    dwBuildNumber: DWORD;
    dwPlatformId: DWORD;
    szCSDVersion: array[0..127] of Char;
    wServicePackMajor: WORD;
    wServicePackMinor: WORD;
    wSuiteMask: WORD;
    wProductType: BYTE;
    wReserved: BYTE;
  end;
  POSVersionInfo=^TOSVERSIONINFO;
  {$ENDIF}

function LMDGetOSVersionInfoEx(var AVerInfo: TOSVersionInfoEx): Boolean;

{Procedure LMDSIProcessList(aList:TStringList);}

type
  TLMDSysPlatform = (pfWin95, pfWin98, pfWinME, pfWinNT, pfWin2K,
                     pfWinXP, pfWin2003Server,
                     pfWinVista, pfWin2008server,
                     pfWin7, pfWin2008R2Server,
                     pfWin8, pfWin2012Server,
                     pfWin81, pfWin2012R2Server,
                     pfWin10, pfWin2016Server);

{Drives&Files}
{------------------------------------------------------------------------------}
type

  TLMDDriveInfo = record
    ditype: UINT;
    diTotalSpace: Int64;
    diFreeSpace: Int64;
    diSectorsPerCluster: DWORD;
    diBytesPerSector: DWORD;
  end;

function LMDSIDriveInfo(const aDrive: string): TLMDDriveInfo;
procedure LMDSIDriveList(aList: TStringList);
function LMDSIDriveTypeStr(aType: UInt): string;
function LMDSITempPath: string;

{Misc}
procedure LMDSIEnvironment(aList: TStringList);
function LMDSITempFile(const prefix:String='tmp'): string;
function LMDSIWindowsDirectory: string;
function LMDSISystemDirectory: string;
function LMDSIRegisteredOwner: string;
function LMDSIRegisteredCompany: string;
function LMDSIVersionStr: string;
function LMDSIVersionNr: Extended;
function LMDSIUserName: string; {current user in the net}
function LMDSIComputerName: string;
function LMDSISystemDefaultLanguageID: Integer;
function LMDSILanguageNameFromID(AID: Integer): String;
function LMDSISystemDefaultLanguageName: String;
function LMDSIGetTimeZone: string;
function LMDSIGetTimeZoneBias: LongInt;
function LMDSIIconHeight: Integer;
function LMDSIIconWidth: Integer;
function LMDSISmallIconHeight: Integer;
function LMDSISmallIconWidth: Integer;
function LMDSISystemIconListHandle(aLarge: Boolean): DWORD;

function LMDSIDPIAwareIconSize: Integer;
function LMDSIDPIAwareSmallIconSize: Integer;
function LMDSILogPixelsX: Integer;

{ used by LMDInformationLabel }
function GetSystemInfoString(inf: TLMDInfoType; DevideBy: LongInt; DateTimeFormat: string): string;
function LMDSIVersionInfo(inf: TLMDVersionInfoType): string;
function LMDSIInfoToString(aValue: TLMDInfoType): string;

function LMDGetLocalInfo(index: Integer): string;
function LMDSIRdtsc: Int64;
function LMDSIGetCPUSpeed: Double;

function LMDSITimeElapsedSinceBoot:Double;
function LMDSILastBootTime:TDateTime;

var
  LMDSIWindows95: Boolean = false;
  LMDSIWindows98: Boolean = false;
  LMDSIWindowsNT: Boolean = false;
  LMDSIWindows2000: Boolean = false;
  LMDSIWindows2000AdvancedServer: Boolean = false;
  LMDSIWindowsME: Boolean = false;
  LMDSIWindowsXP: Boolean = false;
  LMDSIWindowsXPHome: Boolean = false;
  LMDSIWindowsXPProf: Boolean = false;
  LMDSINETServer: Boolean = false;
  LMDSIWindowsExtension: Boolean = false;
  //  7.04
  LMDSIWindowsXPServer: Boolean = false;
  LMDSIWindowsVista: Boolean = false;
  LMDSIWindows7: Boolean = false;
  LMDSIWindows8: Boolean = false;
  LMDSIWindows81: Boolean = false;
  LMDSIWindows10: Boolean = false;
  LMDSIWindowsXPTabletEdition: Boolean = false;
  LMDSIWindowXPMediaCenterEdition: Boolean = false;
  // 8.00
  LMDSIWindowsNTUp: Boolean = false;
  LMDSIWindows2000Up: Boolean = false;
  LMDSIWindowsXPUp: Boolean = false;
  LMDSIWindowsXPSP2: Boolean = false;
  LMDSIWindowsXPSP3: Boolean = false;
  LMDSIWindowsXPSP2Up: Boolean = false;
  LMDSIWindows2003Up: Boolean = false;
  LMDSIWindowsVistaUp: Boolean = false;
  LMDSIWindowsWindows7Up: Boolean = false;
  LMDSIWindowsWindows8Up: Boolean = false;
  LMDSIUnicodeDelphi: boolean = false;

var
  LMDSysPlatform: TLMDSysPlatform;

procedure LMDPlatformNotImplemented;

implementation

uses
  ShellApi, Consts, Controls, Registry, Forms, Types,
  LMDProcs, LMDRTLConst;

const
  SI_WORKSTATION    :Integer = 1;

type
  ELMDPlatformNotImplemented = class(Exception);

Type
  DWORDLONG = Int64;
  {$EXTERNALSYM DWORDLONG}
  _MEMORYSTATUSEX = packed record
    dwLength: DWORD;
    dwMemoryLoad: DWORD;
    ullTotalPhys: DWORDLONG;
    ullAvailPhys: DWORDLONG;
    ullTotalPageFile: DWORDLONG;
    ullAvailPageFile: DWORDLONG;
    ullTotalVirtual: DWORDLONG;
    ullAvailVirtual: DWORDLONG;
    ullAvailExtendedVirtual: DWORDLONG;
  end;
  {$EXTERNALSYM _MEMORYSTATUSEX}
  TMemoryStatusEx = _MEMORYSTATUSEX;
  {$ifdef LMDCOMP12}
  {$EXTERNALSYM TMemoryStatusEx}
  {$endif}
  MEMORYSTATUSEX = _MEMORYSTATUSEX;
  {$EXTERNALSYM MEMORYSTATUSEX}

procedure LMDPlatformNotImplemented;
begin
  raise ELMDPlatformNotImplemented.Create(SLMDPlatformIsNotImplemented);
end;

const
  sLMDSysPlatform:array[TLMDSysPlatform] of string=
     ('Windows 95', 'Windows 98', 'Windows ME', 'Windows NT', 'Windows 2000',
      'Windows XP', 'Windows 2003 Server',
      'Windows Vista', 'Windows 2008 Server',
      'Windows 7','Windows 2008R2 Server',
      'Windows 8', 'Windows 2012 Server',
      'Windows 8.1', 'Windows Server 2012 R2',
      'Windows 10', 'Windows Server 2016');


{Calculation-Routines}
{------------------------------------------------------------------------------}

function LMDNCCalcTextArea(Wnd: HWnd; const aRect: TRect; Style: LongInt; ExStyle: LongInt;
  var sflag: WORD): TRECT;
var
  tmp: Integer;
  fixb: Byte;
  sm: Boolean;
begin
  Result := Rect(0, 0, 0, 0);
  if not IsWindow(wnd) or not IsWindowVisible(wnd) then
    exit;

  result := aRect;

  sm := NC_SMALLCAPTION and sflag = NC_SmallCaption;
  fixb := LMDNCFIXBORDERWIDTH;
  tmp := LMDNCBitmapWidth;

  if sm then
    tmp := LMDNCSMALLBITMAPWIDTH;

  with result do
  begin
    if (WS_SYSMENU and Style = WS_SYSMENU) then
    begin

      if not NewStyleControls then
        dec(Right, 2 * fixb)
      else
        if not IsIconic(Wnd) then
          Dec(Right, tmp + 3 * fixb);

      if ((WS_SIZEBOX and Style = WS_SIZEBOX) and not sm) or
        (NC_SINGLEBORDER and sFlag = NC_SINGLEBORDER) or
        (not NewStyleControls and (WS_POPUPWINDOW and Style = WS_POPUPWINDOW))
        or (not NewStyleControls and (WS_EX_TOOLWINDOW and ExStyle = WS_EX_TOOLWINDOW)) then
      begin
        sflag := sflag or NC_HASICON;
        if NewStyleControls then
        begin
          Inc(Left, LMDNCCAPTIONICONWIDTH + LMDNCSIZEBORDERWIDTH);
          if not IsIconic(Wnd) then
            Inc(Left, fixb)
          else
            sflag := sflag or NC_ISICONIC;
        end
        else
          Inc(Left, LMDNCCAPTIONICONWIDTH + 2 * fixb);
      end;

      if (WS_MINIMIZEBOX and Style = WS_MINIMIZEBOX) or
        (WS_MAXIMIZEBOX and Style = WS_MAXIMIZEBOX) then
      begin
        if NewStyleControls then
          Dec(Right, 2 * tmp)
        else
          Dec(Right, Byte(WS_MINIMIZEBOX and Style = WS_MINIMIZEBOX) * tmp +
            Byte(WS_MAXIMIZEBOX and Style = WS_MAXIMIZEBOX) * tmp)
      end
      else
        if (WS_EX_CONTEXTHELP and EXSTYLE = WS_EX_CONTEXTHELP) then
        begin
          if NewStyleControls then
            DEC(Right, fixb);
          DEC(Right, tmp);
        end;

      if NewStyleControls and (WS_EX_TOOLWINDOW and ExStyle = WS_EX_TOOLWINDOW) then
      begin
        Inc(Left, 4 * fixb);
        Inc(Top, 3 * fixb);
        Dec(Right, 2 * fixb);
      end;
    end
    else
    begin
      inc(Left, 2 * fixb);
      if not NewStyleControls then
      begin
        Dec(right, fixb);
        Dec(Right, Byte(WS_MINIMIZEBOX and Style = WS_MINIMIZEBOX) * tmp +
          Byte(WS_MAXIMIZEBOX and Style = WS_MAXIMIZEBOX) * tmp)
      end
    end;

    if aRect.Left = Left then
      Inc(Left, 2 * fixb);
  end

end;

{------------------------------------------------------------------------------}

procedure LMDNCCalcDrawingArea(Handle: HWND; var dRect: TRect; var rText: TRect;
  var sflag: WORD);
var
  flags, extflags: LongInt;
  Internal: Byte;
begin

  flags := GetWindowLong(Handle, GWL_Style);
  extflags := GetWindowLong(Handle, GWL_EXStyle);
  Internal := 0;

  GetWindowRect(Handle, dRect);

  with dRect do
    dRect := Rect(0, 0, right - Left, LMDNCCaptionHeight);

  {Hier noch hin: SonderBehandlung für TOOL-/PalettenWindows}
  {----------------------------------------------------------------------------}
  if extflags and WS_EX_TOOLWINDOW = WS_EX_TOOLWINDOW then
    if NewStyleControls then
      with dRect do
      begin
        dRect := Rect(0, 0, dRect.Right, LMDNCSmallCaptionHeight);
        sflag := sflag or NC_SMALLCAPTION;
      end;

  if Internal = 0 then
    if not NewStyleControls and (NC_SingleBorder and sflag = NC_SingleBorder) then
    begin
      LMDAdjustRectExt(dRect, LMDNCFIXBORDERWIDTH, LMDNCFIXBORDERHEIGHT,
        -LMDNCFIXBORDERWIDTH, -LMDNCFIXBORDERWIDTH);
      Internal := 1;
    end;

  {Resizeable Window}
  if Internal = 0 then
    if flags and WS_THICKFRAME = WS_THICKFRAME then
    begin
      LMDAdjustRectExt(dRect, LMDNCSIZEBORDERWIDTH, LMDNCSIZEBORDERHEIGHT,
        -LMDNCSIZEBORDERWIDTH, LMDNCSIZEBORDERHEIGHT - LMDNCFIXBORDERHEIGHT);
      if not NewStyleControls then
        Dec(dRect.Bottom, LMDNCFIXBORDERWIDTH);
      Internal := 1;
    end;

  {we have a modal dialog frame}
  if Internal = 0 then
    if extflags and WS_EX_DLGMODALFRAME = WS_EX_DLGMODALFRAME then
    begin
      LMDAdjustRectExt(dRect, LMDNCDLGBORDERWIDTH, LMDNCDLGBORDERHEIGHT,
        -LMDNCDLGBORDERWIDTH, LMDNCDLGBORDERHEIGHT - LMDNCFIXBORDERHEIGHT);

      Internal := 1;
    end;

  if Internal = 0 then
    if not NewStyleControls and (extflags and WS_EX_TOOLWINDOW = WS_EX_TOOLWINDOW) then
    begin
      LMDAdjustRectExt(dRect, LMDNCFIXBORDERWIDTH, LMDNCFIXBORDERHEIGHT,
        -LMDNCFIXBORDERWIDTH, -LMDNCFIXBORDERWIDTH);
      Internal := 1;
    end;

  {Standard-Window}
  if Internal = 0 then
    LMDAdjustRectExt(dRect, LMDNCFIXBORDERWIDTH * 3, LMDNCFIXBORDERHEIGHT * 3,
      -LMDNCFIXBORDERWIDTH * 3, LMDNCFIXBORDERHEIGHT * 2);

  rText := LMDNCCalcTextArea(Handle, dRect, flags, extflags, sflag);
  if sflag and NC_ISICONIC = NC_ISICONIC then
    Dec(dRect.Bottom, LMDNCFIXBORDERHEIGHT);
  rText.Bottom := dRect.Bottom;

  if sflag and NC_ADJUSTRIGHT = NC_ADJUSTRIGHT then
    drect.right := rText.Right;
  if (sflag and NC_HASICON = NC_HASICON) and ((sflag and NC_ADJUSTLEFT = NC_ADJUSTLEFT)
    or not NewStyleControls) then
  begin
    drect.Left := rText.Left;
    Inc(rText.Left, 2 * LMDNCFIXBORDERWIDTH);
  end;

end;

{------------------------------------------------------------------------------}
{procedure LMDAddNCAreaToRect(var R: TRect);
var
  BorderWidth: Integer;
begin
  BorderWidth:=LMDNCBORDERWIDTH;
  Dec(R.Left, BorderWidth);
  Inc(R.Right, BorderWidth);
  Inc(R.Bottom, LMDNCSMALLCAPTIONHEIGHT + LMDNCBORDERHEIGHT*2);
end;

{------------------------------------------------------------------------------}
{procedure LMDSubNCAreaFromRect(var R: TRect);
var
  BorderWidth: Integer;
begin
  BorderWidth:=LMDNCBORDERWIDTH;
  Inc(R.Left, BorderWidth);
  Dec(R.Right, BorderWidth);
  Dec(R.Bottom, LMDNCSMALLCAPTIONHEIGHT + LMDNCBORDERHEIGHT*2);
end;

{Values for Nonclient-Area}
{------------------------------------------------------------------------------}

function LMDNCBITMAPHEIGHT: Integer; {Höhe eines EinzelBitmap in Titelzeile}
begin
  result := GetSystemMetrics(SM_CYSIZE);
end;

{------------------------------------------------------------------------------}

function LMDNCBITMAPWIDTH: Integer; {Breite eines EinzelBitmap in Titelzeile}
begin
  result := GetSystemMetrics(SM_CXSIZE);
end;

{------------------------------------------------------------------------------}

function LMDNCCaptionHeight: Integer;
begin
  result := GetSystemMetrics(SM_CYCaption);
end;

{------------------------------------------------------------------------------}

function LMDNCDLGBORDERWIDTH: Integer;
begin
  result := GetSystemMetrics(SM_CXDLGFRAME);
end;

{------------------------------------------------------------------------------}

function LMDNCDLGBORDERHEIGHT: Integer;
begin
  result := GetSystemMetrics(SM_CYDLGFRAME);
end;

{------------------------------------------------------------------------------}

function LMDNCFIXBORDERWIDTH: Integer;
begin
  result := GetSystemMetrics(SM_CXBORDER);
end;

{------------------------------------------------------------------------------}

function LMDNCFIXBORDERHEIGHT: Integer;
begin
  result := GetSystemMetrics(SM_CYBORDER);
end;

{------------------------------------------------------------------------------}

function LMDNCSIZEBORDERWIDTH: Integer;
begin
  result := GetSystemMetrics(SM_CXFRAME);
end;

{------------------------------------------------------------------------------}

function LMDNCSIZEBORDERHEIGHT: Integer;
begin
  result := GetSystemMetrics(SM_CYFRAME);
end;

{------------------------------------------------------------------------------}

function LMDNCBORDERWIDTH: Integer;
begin
  result := GetSystemMetrics(SM_CXBORDER) + GetSystemMetrics(SM_CXFRAME) - 1;
end;

{------------------------------------------------------------------------------}

function LMDNCBORDERHEIGHT: Integer;
begin
  result := GetSystemMetrics(SM_CYBORDER) + GetSystemMetrics(SM_CYFRAME) - 1;
end;

{------------------------------------------------------------------------------}

function LMDNCSMALLCAPTIONHEIGHT: Integer;
begin
  if NewStyleControls then
    result := GetSystemMetrics(SM_CYSMCAPTION)
  else
    result := LMDNCCaptionHeight;
end;

{------------------------------------------------------------------------------}

function LMDNCSMALLBITMAPHEIGHT: Integer;
begin
  if NewStyleControls then
    result := GetSystemMetrics(SM_CYSMSIZE)
  else
    result := LMDNCBITMAPHeight;
end;

{------------------------------------------------------------------------------}

function LMDNCSMALLBITMAPWIDTH: Integer;
begin
  if NewStyleControls then
    result := GetSystemMetrics(SM_CXSMSIZE)
  else
    result := LMDNCBITMAPWIDTH;
end;

{------------------------------------------------------------------------------}

function LMDNCCAPTIONICONHEIGHT: Integer;
begin
  if NewStyleControls then
    result := GetSystemMetrics(SM_CYSMICON)
  else
    result := LMDNCBitmapHeight;
end;

{------------------------------------------------------------------------------}

function LMDNCCAPTIONICONWIDTH: Integer;
begin
  if NewStyleControls then
    result := GetSystemMetrics(SM_CXSMICON)
  else
    result := LMDNCBitmapWidth;
end;

{General}
{******************************************************************************}
{------------------------------------------------------------------------------}

function LMDSIStretchBltPossible: Boolean;
var
  DC: HDC;
begin
  DC := CreateDC('Display', nil, nil, nil);
  try
    result := GetDeviceCaps(DC, RASTERCAPS) and RC_STRETCHBLT = RC_STRETCHBLT;
  finally
    DeleteDC(DC);
  end;
end;

{------------------------------------------------------------------------------}

function LMDSIFontSmoothing: Boolean;
var

  tmp: integer;

begin

  SystemParametersInfo(SPI_GETFONTSMOOTHING, 0, @tmp, 0);
  result := Boolean(tmp);

end;

{------------------------------------------------------------------------------}

function LMDSIColorDepth: Byte;
var
  DC: HDC;
begin
  DC := CreateDC('Display', nil, nil, nil);
  try
    result := GetDeviceCaps(DC, PLANES) * GETDEVICECAPS(DC, BITSPIXEL);
  finally
    DeleteDC(DC);
  end;
end;

{------------------------------------------------------------------------------}

function LMDSIScreenSaverDelay: Integer;
var
  tmp: integer;
begin
  SystemParametersInfo(SPI_GETSCREENSAVETIMEOUT, 0, @tmp, 0);
  result := tmp div 60;
end;

{------------------------------------------------------------------------------}

function LMDSINumLock: Boolean;
begin
  result := (LoByte(GetKeyState(VK_NUMLOCK)) = 1);
end;

{------------------------------------------------------------------------------}

function LMDSICapsLock: Boolean;
begin
  result := (LoByte(GetKeyState(VK_CAPITAL)) = 1);
end;

{------------------------------------------------------------------------------}

function LMDSIScrollLock: Boolean;
begin
  result := (LoByte(GetKeyState(VK_SCROLL)) = 1);
end;

type
  TLMDVersionInfoTypes = (viMajorVersion, viMinorVersion, viPlatformID, viBuildNumber,
    viSPMajor, viSPMinor, viSuiteMask, viProductType);

function LMDGetOSVersionInfoEx(var AVerInfo: TOSVersionInfoEx): Boolean;
begin
  Result := True;

  FillChar(AVerInfo, sizeof(AVerInfo),0);
  AVerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfoEx);
  if not GetVersionEx(POSVersionInfo(@AVerInfo)^) then
    Result := False;

end;
{------------------------------------------------------------------------------}
function LMDGetVersionInfo(typ: TLMDVersionInfoTypes): DWORD;
var
  os_ex: TOSVersionInfoEx;
begin
  result := 0;
  if not LMDGetOSVersionInfoEx(os_ex) then
    exit;
  case typ of
    viMajorVersion: result := os_ex.dwMajorVersion;
    viMinorVersion: result := os_ex.dwMinorVersion;
    viPlatformID: result := os_ex.dwPlatformId;
    viBuildNumber: result := os_ex.dwBuildNumber;
    viSPMajor: result := os_ex.wServicePackMajor;
    viSPMinor: result := os_ex.wServicePackMinor;
    viSuiteMask: result := os_ex.wSuiteMask;
    viProductType: result := os_ex.wProductType;
  end;
end;

{------------------------------------------------------------------------------}
procedure InitOSVersionInfo(var VI: TOSVersionInfo);
begin

  FillChar(VI, sizeof(VI), 0);
  VI.dwOSVersionInfoSize := SizeOf(VI);

end;

{------------------------------------------------------------------------------}
function LMDSIMajorVersionNr: Word;
begin
  result:=Win32MajorVersion;
end;

{------------------------------------------------------------------------------}
function LMDSIMinorVersionNr: Word;
begin
  result:=Win32MinorVersion;
end;

{------------------------------------------------------------------------------}
function LMDSIProductType: Word;
begin
  result := LMDGetVersionInfo(viProductType);
end;

{------------------------------------------------------------------------------}

function LMDSISuiteMask: Word;
begin
  result := LMDGetVersionInfo(viSuiteMask);
end;

{------------------------------------------------------------------------------}

function LMDSIVIPlatformID: Word;
begin
  result := LMDGetVersionInfo(viPlatformID);
end;

{------------------------------------------------------------------------------}
function LMDSIBuildNr: Word;
begin
  result:=Win32BuildNumber;
end;

{------------------------------------------------------------------------------}

function LMDSIVersionString: string;
begin
  result:=Win32CSDVersion;
end;

{------------------------------------------------------------------------------}

procedure GetMemoryStatus(var MS: TMemoryStatusEx);

const
  lib = 'kernel32.dll';
var
  GlobalMemoryStatusEx: function(var lpBuffer: TMemoryStatusEx): Boolean; stdcall;
  MSOld: TMemoryStatus;
  libModule: HModule;

begin

  if LMDSiWindowsNTUp then
  begin
    libModule := LoadLibrary(int_Ref(lib));
    try
      MS.dwLength := sizeof(TMemoryStatusEx);
      GlobalMemoryStatusEx := GetProcAddress(libModule, 'GlobalMemoryStatusEx');
      GlobalMemoryStatusEx(MS);
    finally
      FreeLibrary(libModule);
    end;
  end
  else
  begin
    MSOld.dwLength := sizeof(TMemoryStatus);
    GlobalMemoryStatus(MSOld);
    MS.dwMemoryLoad := MSOld.dwMemoryLoad;
    MS.ullTotalPhys := MSOld.dwTotalPhys;
    MS.ullAvailPhys := MSOld.dwAvailPhys;
    MS.ullTotalPageFile := MSOld.dwTotalPageFile;
    MS.ullAvailPageFile := MSOld.dwAvailPageFile;
    MS.ullTotalVirtual := MSOld.dwTotalVirtual;
    MS.ullAvailVirtual := MSOld.dwAvailVirtual;
    MS.ullAvailExtendedVirtual := 0;
  end;

end;

{------------------------------------------------------------------------------}

function LMDSIMemLoaded: Byte;
var
  MS: TMemoryStatusEx;
begin
  GetMemoryStatus(MS);
  result := MS.dwMemoryLoad;
end;

{------------------------------------------------------------------------------}

function LMDSIMemTotal: Int64;
var
  MS: TMemoryStatusEx;
begin
  GetMemoryStatus(MS);
  result := MS.ullTotalPhys;
end;

{------------------------------------------------------------------------------}

function LMDSIMemFree: Int64;
var
  MS: TMemoryStatusEx;
begin
  GetMemoryStatus(MS);
  result := MS.ullAvailPhys;
end;

{------------------------------------------------------------------------------}

function LMDSIMemPageFree: Int64;
var
  MS: TMemoryStatusEx;
begin
  GetMemoryStatus(MS);
  result := MS.ullAvailPageFile;
end;

{------------------------------------------------------------------------------}

function LMDSIMemPageTotal: Int64;
var
  MS: TMemoryStatusEx;
begin
  GetMemoryStatus(MS);
  result := MS.ullTotalPageFile;
end;

{------------------------------------------------------------------------------}

function LMDSIMemVirtFree: Int64;
var
  MS: TMemoryStatusEx;
begin
  GetMemoryStatus(MS);
  result := MS.ullAvailVirtual;
end;

{------------------------------------------------------------------------------}

function LMDSIMemVirtExtended: Int64;
var
  MS: TMemoryStatusEx;
begin
  GetMemoryStatus(MS);
  result := MS.ullAvailExtendedVirtual;
end;

{------------------------------------------------------------------------------}

function LMDSIMemVirtTotal: Int64;
var
  MS: TMemoryStatusEx;
begin
  GetMemoryStatus(MS);
  result := MS.ullTotalVirtual;
end;

{------------------------------------------------------------------------------}

function LMDSIOLDWINDOWSNT: Boolean;
begin
  result := LMDSIWindowsNT and (LoByte(GetVersion) < 4);
end;

{------------------------------------------------------------------------------}

function LMDSIPlatformID: DWORD;
begin
  result := SysUtils.Win32Platform;
end;

{------------------------------------------------------------------------------}
function LMDSIPlatformStr: string;
begin
  result := sLMDSysPlatform[LMDSysPlatform];
end;

{------------------------------------------------------------------------------}

function LMDSIProcessorCount: Byte;
var
  si: TSystemInfo;
begin
  GetSystemInfo(si);
  result := si.dwNumberOfProcessors;
end;

{------------------------------------------------------------------------------}

function LMDSIProcessorTypeStr: string;
var
  si: TSystemInfo;
begin
  GetSystemInfo(si);
  case si.dwProcessorType of
    386: result := 'Intel 386';
    486: result := 'Intel 486';
    586: result := 'Intel Pentium';
    2000, 3000, 4000: result := 'Mips R' + IntToStr(si.dwProcessorType);
    21064: result := 'Alpha 21064';
  else
    result := inttostr(si.dwProcessorType);
  end;
end;

{------------------------------------------------------------------------------}
function GetFreesystemResources(Mode: Integer): Integer;
var
  _MyGetFreeSystemResources32: function(Mode: Integer): Integer stdcall;
  RSRC32DLL: THandle;
begin
  Result := 100;
  RSRC32DLL := LoadLibrary('RSRC32.DLL');
  if (RSRC32DLL <> 0) then
  begin
    @_MyGetFreeSystemResources32 := GetProcAddress(RSRC32DLL, '_MyGetFreeSystemResources32@4');
    Result := _MyGetFreeSystemResources32(Mode);
    FreeLibrary(RSRC32DLL);
  end;
end;

{------------------------------------------------------------------------------}

function LMDSIFreeSysRes: Word;
begin

  result := GetFreeSystemResources(0);

end;

{------------------------------------------------------------------------------}

function LMDSIFreeGDIRes: Word;
begin

  result := GetFreeSystemResources(1);

end;

{------------------------------------------------------------------------------}

function LMDSIFreeUserRes: Word;
begin

  result := GetFreeSystemResources(2);

end;

{Drives, Files}
{------------------------------------------------------------------------------}

function LMDSIDriveInfo(const aDrive: string): TLMDDriveInfo;
var
  buffer: string;
  totcl, freecl: DWORD;
begin

  with result do
  begin
    diTotalSpace := 0;
    diFreeSpace := 0;
    diSectorsPerCluster := 0;
    diBytesPerSector := 0;
    diType := GetDriveType(int_Ref(aDrive));
    if diType > 1 then
    begin
      buffer := UpperCase(copy(aDrive, 1, 3));
      //5.02 (RM)

      GetDiskFreeSpace(PChar(buffer), diSectorsPerCluster, diBytesPerSector,
        freecl, totcl);
      diTotalSpace := DiskSize(Byte(buffer[1]) - $40);
      diFreeSpace := DiskFree(Byte(buffer[1]) - $40);

    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure LMDSIDriveList(aList: TStringList);
var

  buffer: String;
  i, le: Integer;

begin
  if aList = nil then
    exit;
  aList.Clear;

  SetLength(buffer, 255);

  le := GetLogicalDriveStrings(254, PChar(buffer));
  i := 1;
  while i < le do
    begin
      aList.add(copy(buffer, i, 3));
      Inc(i, 4);
    end;

end;

{------------------------------------------------------------------------------}

function LMDSIDriveTypeStr(aType: UInt): string;
begin
  case aType of
    DRIVE_UNKNOWN: result := srUNKNOWN;
    DRIVE_NO_ROOT_DIR: result := IDS_NOROOTDIR;
    DRIVE_REMOVABLE: result := IDS_REMOVABLE;
    DRIVE_FIXED: result := IDS_FIXEDDRIVE;
    DRIVE_REMOTE: result := IDS_REMOTE;
    DRIVE_CDROM: result := IDS_CDROM;
    DRIVE_RAMDISK: result := IDS_RAMDISK;
  else
    result := srUNKNOWN;
  end;
end;

{------------------------------------------------------------------------------}
function LMDGetLongPathName(const PathName: string): string;
 var
   Drive: String;
   Path: String;
   SearchRec: TSearchRec;
begin
 Drive:=ExtractFileDrive(PathName);
 Path:=Copy(PathName, Length(Drive)+1, Length(PathName));
 if (Path = '') or (Path = '\') then
   begin
     Result := PathName;
     if Result[Length(Result)] = '\' then
       Delete(Result, Length(Result), 1);
   end
 else
   begin
     Path := LMDGetLongPathName(ExtractFileDir(PathName));
     if FindFirst(PathName, faAnyFile, SearchRec) = 0 then
       begin
         Result := Path + '\' + SearchRec.FindData.cFileName;
         FindClose(SearchRec);
       end
     else
       Result := Path + '\' + ExtractFileName(PathName);
   end;
end;

{------------------------------------------------------------------------------}
function LMDSITempPath: string;

var
  le:Integer;

begin
  SetLength(Result, MAX_PATH);
  le := GetTempPath(MAX_PATH, PChar(Result));
  SetLength(Result,le);
  Result := LMDGetLongPathName(Result);
  end;

{Misc routines}
{------------------------------------------------------------------------------}

procedure LMDSIEnvironment(aList: TStringList);
var

  temp, old: PChar;

begin
  if aList = nil then
    exit;

  old := nil;
  aList.Clear;
  temp := GetEnvironmentStrings;
  if temp <> nil then
  begin
    old := temp;
    while temp[0] <> #0 do
    begin
      aList.add(StrPas(temp));
      inc(temp, strlen(temp) + 1);
    end;
  end;
  if old <> nil then
    FreeEnvironmentStrings(old);

end;

{------------------------------------------------------------------------------}

function LMDSIWindowsDirectory: string;
begin
  result := LMDWindowsDirectory;
end;

{------------------------------------------------------------------------------}

function LMDSISystemDirectory: string;
begin
  result := LMDSystemDirectory;
end;

{------------------------------------------------------------------------------}
function LMDSITempFile(const prefix:String='tmp'): string;

begin

  SetLength(result, 511);
  if GetTempFileName(PChar(LMDSITempPath), PChar(prefix), 0, PChar(result)) = 0 then
    result := ''
  else
    result := StrPas(PChar(result));

end;

{------------------------------------------------------------------------------}

function LMDSIRegisteredCompany: string;
var
  reg: TRegistry;
  subkey: string;
const
  Subvalue = 'RegisteredOrganization';

begin
  reg := TRegistry.Create;
  with reg do
  try
    RootKey := HKEY_LOCAL_MACHINE;

    subkey := '\SOFTWARE\Microsoft\';
    if LMDSIWindowsNT then
      subkey := subkey + 'Windows NT'
    else
      subkey := subkey + 'Windows';
    subkey := subkey + '\CurrentVersion';

    if OpenKey(Subkey, false) then
    begin
      result := ReadString(subvalue);
      CloseKey;
    end
    else
      result := srunknown;
  finally
    reg.free;
  end;
end;

{------------------------------------------------------------------------------}

function LMDSIRegisteredOwner: string;
var
  reg: TRegistry;
  subkey: string;
const
  Subvalue = 'RegisteredOwner';
begin
  reg := TRegistry.Create;
  try
    with reg do
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      subkey := '\SOFTWARE\Microsoft\';
      if LMDSIWindowsNT then
        subkey := subkey + 'Windows NT'
      else
        subkey := subkey + 'Windows';
      subkey := subkey + '\CurrentVersion';
      if OpenKey(Subkey, false) then
      begin
        result := ReadString(subvalue);
        CloseKey;
      end
      else
        result := srunknown;
    end;
  finally
    reg.free;
  end;
end;

{------------------------------------------------------------------------------}

function LMDSIVersionStr: string;
var
  os: TOSVersionInfo;
begin
  InitOSVersionInfo(os);
  GetVersionEx(os);
  result := format('%d.%d', [os.dwMajorVersion, os.dwMinorVersion]);
end;

{------------------------------------------------------------------------------}

function LMDSIVersionNr: Extended;
var
  os: TOSVersionInfo;
begin
  InitOSVersionInfo(os);
  GetVersionEx(os);
  result := os.dwMajorVersion + os.dwMinorVersion / LMDExp(10, length(IntToStr(os.dwMinorVersion)));
end;

{------------------------------------------------------------------------------}
function LMDSIComputerName: string;
var
  le: DWORD;
begin
  le := MAX_COMPUTERNAME_LENGTH + 1;
  SetLength(result, le);
  if GetComputerName(PChar(result), le) then
    SetLength(result, le)
  else
    result := SRUnknown;

end;

{------------------------------------------------------------------------------}
function LMDSIUserName: string;
var
  le: DWORD;
begin
  le := 63;
  SetLength(result, le);
  if GetUsername(PChar(result), le) then
    SetLength(result, le - 1)
  else
    result := SRUnknown;
  end;

{------------------------------------------------------------------------------}
function LMDSISystemDefaultLanguageID: Integer;
begin
  Result := GetSystemDefaultLangID;
end;

{------------------------------------------------------------------------------}
function LMDSILanguageNameFromID(AID: Integer): String;
const
  MAX_LANGNAME_CHAR = 100;

begin
  SetLength(Result, MAX_LANGNAME_CHAR);
  SetLength(Result, VerLanguageName(AID, PChar(Result), MAX_LANGNAME_CHAR));
  end;

{------------------------------------------------------------------------------}
function LMDSISystemDefaultLanguageName: String;
begin
  Result := LMDSILanguageNameFromID(GetSystemDefaultLangID);
end;

{------------------------------------------------------------------------------}
function LMDSIGetTimeZone: string;
var
  TempZone: TTimeZoneInformation;
begin
  GetTimeZoneInformation(TempZone);

  result := WideCharToString(TempZone.StandardName);

end;

{------------------------------------------------------------------------------}

function LMDSIGetTimeZoneBias: LongInt;
var
  TempZone: TTimeZoneInformation;
begin
  GetTimeZoneInformation(TempZone);
  result := TempZone.Bias;
end;

{---------------------------------------------------------------------------}

function LMDSIIconHeight: Integer;
begin
  result := GetSystemMetrics(SM_CXICON);
end;

{---------------------------------------------------------------------------}

function LMDSIIconWidth: Integer;
begin
  result := GetSystemMetrics(SM_CXICON);
end;

{---------------------------------------------------------------------------}

function LMDSISmallIconHeight: Integer;
begin
  result := GetSystemMetrics(SM_CYSMICON);
end;

{---------------------------------------------------------------------------}

function LMDSISmallIconWidth: Integer;
begin
  result := GetSystemMetrics(SM_CXSMICON);
end;

{---------------------------------------------------------------------------}
function LMDSIDPIAwareIconSize: Integer;
var
  LScale: Double;
begin
  LScale := LMDSILogPixelsX / 96;
  if (32 * LScale + 0.5) >= 64 then
    Result := 64
  else if (32 * LScale + 0.5) >= 48 then
    Result := 48
  else
    Result := 32;
end;

{---------------------------------------------------------------------------}
function LMDSIDPIAwareSmallIconSize: Integer;
var
  LScale: Double;
begin
  LScale := LMDSILogPixelsX / 96;
  if (16 * LScale + 0.5) >= 24 then
    Result := 24
  else if (16 * LScale + 0.5) >= 20 then
    Result := 20
  else
    Result := 16;
end;

{---------------------------------------------------------------------------}
function LMDSILogPixelsX: Integer;
var
  DC: HDC;
begin
  DC := CreateDC('Display', nil, nil, nil);
  try
    Result := GetDeviceCaps(DC, LOGPIXELSX);
  finally
    DeleteDC(DC);
  end;
end;

{---------------------------------------------------------------------------}
function LMDSISystemIconListHandle(aLarge: Boolean): DWORD;
var
  FileInfo: TSHFileInfo;
  Sz: integer;
  Flag: integer;
begin

  Sz := SizeOf(FileInfo);

  if aLarge then
    Flag := SHGFI_LARGEICON
  else
    Flag := SHGFI_SMALLICON;
  Result := SHGetFileInfo('', 0, FileInfo, Sz, Flag or SHGFI_SYSICONINDEX);
end;

{------------------------------------------------------------------------------}

function LMDSIVersionInfo(inf: TLMDVersionInfoType): string;
var

  InfoResSize,
    Zero: DWORD;
  VersionInfo,
    Translation,
    Info: Pointer;
  VersionInfoSize: UINT;
  InfoPath: string;

begin
  result := '';
  //retrieve the size of the version information resource, if one exists

  InfoResSize := GetFileVersionInfoSize(PChar(Application.Exename), Zero);
  if InfoResSize = 0 then
    exit;
  //if there are infos we will go on

  //allocate the needed memory for the info structure
  GetMem(VersionInfo, InfoResSize);
  try
    //Get the information of the current file
    if not GetFileVersionInfo(PChar(Application.Exename), 0, InfoResSize, VersionInfo) then
    begin
      FreeMem(VersionInfo);
      exit;
    end;

    {    VerQueryValue(VersionInfo, '\\VarFileInfo\\Translation', Translation, VersionInfoSize);

        //set the version value path string
        InfoPath :='\\StringFileInfo\\'+
                        IntToHex(LoWord(LongInt(Translation^)),4)+
                        IntToHex(HiWord(LongInt(Translation^)),4)+
                        '\\';}

    if VerQueryValue(VersionInfo, '\\VarFileInfo\\Translation', Translation, VersionInfoSize) then
    begin
      //set the version value path string
      InfoPath := '\\StringFileInfo\\' +
        IntToHex(LoWord(LongInt(Translation^)), 4) +
        IntToHex(HiWord(LongInt(Translation^)), 4) +
        '\\';
    end
    else //set Microsoft default value
    begin
      //set the version value path string
      InfoPath := '\\StringFileInfo\\040904E4\\';
    end;

    case inf of
      viCompany:
        begin
          //get the company name
          VerQueryValue(VersionInfo, PChar(InfoPath + 'CompanyName'), Info, VersionInfoSize);
          result := string(PChar(Info));
        end;
      viName:
        begin
          //productname
          VerQueryValue(VersionInfo, PChar(InfoPath + 'ProductName'), Info, VersionInfoSize);
          result := string(PChar(Info));
        end;
      viVersion:
        begin
          //productversion
          VerQueryValue(VersionInfo, PChar(InfoPath + 'ProductVersion'), Info, VersionInfoSize);
          result := string(PChar(Info));
        end;
      viCopyright:
        begin
          //legal Copyright
          VerQueryValue(VersionInfo, PChar(InfoPath + 'LegalCopyright'), Info, VersionInfoSize);
          result := string(PChar(Info));
        end;
      viTrademark:
        begin
          //legal trademarks
          if VerQueryValue(VersionInfo, PChar(InfoPath + 'LegalTradeMarks'), Info, VersionInfoSize) then
            result := string(PChar(Info))
        end;
      viDescription:
        begin
          //get the file description
          VerQueryValue(VersionInfo, PChar(InfoPath + 'FileDescription'), Info, VersionInfoSize);
          result := string(PChar(Info));
        end;
      viComments:
        begin
          //comments
          if VerQueryValue(VersionInfo, PChar(InfoPath + 'Comments'), Info, VersionInfoSize) then
            result := string(PChar(Info));
        end;
      viFileVersionFull:
        begin
          InfoPath := '\' + #0;
          if VerQueryValue(VersionInfo, PChar(InfoPath), Info, VersionInfoSize) then
            result := IntToStr(HIWORD(PVSFixedFileInfo(Info).dwFileVersionMS)) + '.' +
              IntToStr(LOWORD(PVSFixedFileInfo(Info).dwFileVersionMS)) + '.' +
              IntToStr(HIWORD(PVSFixedFileInfo(Info).dwFileVersionLS)) + '.' +
              IntToStr(LOWORD(PVSFixedFileInfo(Info).dwFileVersionLS));
        end;
      viFileVersion:
        begin
          InfoPath := '\' + #0;
          if VerQueryValue(VersionInfo, PChar(InfoPath), Info, VersionInfoSize) then
            result := IntToStr(HIWORD(PVSFixedFileInfo(Info).dwFileVersionMS)) + '.' +
              IntToStr(LOWORD(PVSFixedFileInfo(Info).dwFileVersionMS));
        end;
      viFileVersionBuild:
        begin
          InfoPath := '\' + #0;
          if VerQueryValue(VersionInfo, PChar(InfoPath), Info, VersionInfoSize) then
            result := IntToStr(HIWORD(PVSFixedFileInfo(Info).dwFileVersionMS)) + '.' +
              IntToStr(LOWORD(PVSFixedFileInfo(Info).dwFileVersionMS)) + ' (Build ' +
              IntToStr(HIWORD(PVSFixedFileInfo(Info).dwFileVersionLS)) + '.' +
              IntToStr(LOWORD(PVSFixedFileInfo(Info).dwFileVersionLS)) + ')';
        end;

    end;
  finally
    FreeMem(VersionInfo, InfoResSize);
  end;

end;

{------------------------------------------------------------------------------}

function GetSystemInfoString(inf: TLMDInfoType; DevideBy: LongInt; DateTimeFormat: string): string;
var
  //s : Array[0..2047] of char;
  //sg,
  devider: DWORD;
begin
  devider := DevideBy;
  if devider = 0 then
    devider := 1;
  //StrPCopy (s, '');
  //sg := 2047;
  case inf of
    itUser: result := LMDSIUserName;
    itWinDir: result := LMDWindowsDirectory;
    itCurrentDir32: result := GetCurrentDir;
    itCurrentDiskFree32: result := IntToStr(LMDSIDriveInfo(copy(GetCurrentDir, 1, 3)).diFreeSpace div devider);
    itCurrentDiskSize32: result := IntToStr(LMDSIDriveInfo(copy(GetCurrentDir, 1, 3)).diTotalSpace div devider);
    itComputerName32: result := LMDSIComputerName;
    itColorDepth: result := IntToStr(LMDSIColorDepth div devider);
    itScreenSaverDelay: result := IntToStr(DWord(LMDSIScreenSaverDelay) div devider);
    itMemSize: result := IntToStr(LMDSIMemTotal div devider);
    itFreeSysRes: result := IntToStr(LMDSIFreeSysRes div devider);
    itFreeGDIRes: result := IntToStr(LMDSIFreeGDIRes div devider);
    itFreeUserRes: result := IntToStr(LMDSIFreeUserRes div devider);
    itMajorVerNr32: result := IntToStr(Word(Win32MajorVersion) div devider);
    itBuildNr32: result := IntToStr(Word(Win32BuildNumber) div devider);
    itMemLoaded32: result := IntToStr(LMDSIMemLoaded div devider);
    itMemFree32: result := IntToStr(LMDSIMemFree div devider);
    itMemPageFree32: result := IntToStr(LMDSIMemPageFree div devider);
    itMemPageTotal32: result := IntToStr(LMDSIMemPageTotal div devider);
    itMemVirtFree32: result := IntToStr(LMDSIMemVirtFree div devider);
    itMemVirtTotal32: result := IntToStr(LMDSIMemVirtTotal div devider);
    itPlatformID32: result := IntToStr(LMDSIPlatformID div devider);
    itPlatform32: result := LMDSIPlatformStr;
    itProcessorCont32: result := IntToStr(LMDSIProcessorCount div devider);
    itProcessor32: result := LMDSIProcessorTypeStr;
    itSystemDir: result := LMDSISystemDirectory;
    itReg_Owner32: result := LMDSIRegisteredOwner;
    itReg_Company32: result := LMDSIRegisteredCompany;
    itVersion: result := LMDSIVersionStr;
    itDOSVersion: result := 'Win32';
    itTempPath32: result := LMDSITempPath;
    itNumLock:
      if LMDSINumLock then
        result := IDS_ON
      else
        result := IDS_OFF;
    itCapsLock:
      if LMDSICapsLock then
        result := IDS_ON
      else
        result := IDS_OFF;
    itScroll:
      if LMDSIScrollLock then
        result := IDS_ON
      else
        result := IDS_OFF;
    itCurrentDateTime: result := FormatDateTime(DateTimeFormat, now);
    itProgCompany: result := LMDSIVersionInfo(viCompany);
    itProgName: result := LMDSIVersionInfo(viName);
    itProgVersion: result := LMDSIVersionInfo(viVersion);
    itFileVersion: result := LMDSIVersionInfo(viFileVersion);
    itFileVersionFull: result := LMDSIVersionInfo(viFileVersionFull);
    itFileVersionBuild: result := LMDSIVersionInfo(vifileVersionBuild);
    itProgCopyright: result := LMDSIVersionInfo(viCopyright);
    itProgTrademark: result := LMDSIVersionInfo(viTrademark);
    itProgDescription: result := LMDSIVersionInfo(viDescription);
    itProgComments: result := LMDSIVersionInfo(viComments);
    itCPUSpeed: result := Trim(FloatToStr((LMDSIGetCPUSpeed / devider)));
    itTimeElapsedSinceBoot: result := Trim(FloatToStr(LMDSITimeElapsedSinceBoot));
    itLastBootTime: result := FormatDateTime(DateTimeFormat, LMDSILastBootTime);
  end;
end;

{------------------------------------------------------------------------------}

function LMDSIInfoToString(aValue: TLMDInfoType): string;
begin
  case aValue of
    itUser: result := IDS_USERNAME;
    itWinDir: result := IDS_WINDOWSDIR;
    itCurrentDir32: result := IDS_CURRDIR;
    itCurrentDiskFree32: result := IDS_FREESPACE;
    itCurrentDiskSize32: result := IDS_DISKSIZE;
    itSystemDir: result := IDS_SYSTEMDIR;
    itReg_Owner32: result := IDS_REGISTEREDOWNER;
    itReg_Company32: result := IDS_REGISTEREDCOMPANY;
    itVersion: result := IDS_VERSION;
    itColorDepth: result := IDS_COLORDEPTH;
    itScreenSaverDelay: result := IDS_SCREENSAVERDELAY;
    itMemSize: result := IDS_MEMORYSIZE;
    itFreeSysRes: result := IDS_FREESYSTEMRESOURCES;
    itFreeGDIRes: result := IDS_FREEGDIRES;
    itFreeUserRes: result := IDS_FREEUSERRES;
    itComputerName32: result := IDS_COMPUTERNAME;
    itMajorVerNr32: result := IDS_MAJORVERSION;
    itBuildNr32: result := IDS_BUILD;
    itMemLoaded32: result := IDS_MEMORYLOADED;
    itMemFree32: result := IDS_MEMORYFREE;
    itMemPageFree32: result := IDS_MEMORYFREEPAGES;
    itMemPageTotal32: result := IDS_MEMORYTOTALPAGES;
    itMemVirtFree32: result := IDS_MEMORYVIRTUALFREE;
    itMemVirtTotal32: result := IDS_MEMORYVIRTUALTOTAL;
    itPlatformID32: result := IDS_PLATFORMID;
    itPlatform32: result := IDS_PLATFORM;
    itProcessorCont32: result := IDS_PROCESSORNUMBER;
    itProcessor32: result := IDS_PROCESSOR;
    itTempPath32: result := IDS_TEMPPATH;
    itDOSVersion: result := IDS_DOSVERSION;
    itNumLock: result := IDS_NUMLOCK;
    itCapsLock: result := IDS_CAPSLOCK;
    itScroll: result := IDS_SCROLL;
    itCurrentDateTime: result := IDS_DATETIME;
    itProgCompany: result := IDS_COMPANYNAME;
    itProgName: result := IDS_PRODUCTNAME;
    itProgVersion,
      itFileVersion,
      itFileVersionFull,
      itFileVersionBuild: result := IDS_PRODUCTVERSION;
    itProgCopyright: result := IDS_LEGALCOPYRIGHT;
    itProgTrademark: result := IDS_TRADEMARK;
    itProgDescription: result := IDS_FILEDESCRIPTION;
    itProgComments: result := IDS_COMMENTS;
    itCPUSpeed: result := IDS_CPUSPEED;
  else
    result := '';
  end
end;

{------------------------------------------------------------------------------}

function LMDGetLocalInfo(index: Integer): string;
var
  locale: Integer;
  DefaultLCID: LCID;
begin
  DefaultLCID := GetThreadLocale;
  locale := 0;
  case index of
    0: locale := LOCALE_ICALENDARTYPE;
    1: locale := LOCALE_ICURRDIGITS;
    2: locale := LOCALE_ICURRENCY;
    3: locale := LOCALE_IDIGITS;
    4: locale := LOCALE_IFIRSTDAYOFWEEK;
    5: locale := LOCALE_IFIRSTWEEKOFYEAR;
    6: locale := LOCALE_ILZERO;
    7: locale := LOCALE_IMEASURE;
    8: locale := LOCALE_INEGCURR;
    9: locale := LOCALE_INEGNUMBER;
    10: locale := LOCALE_ITIME;
    11: locale := LOCALE_S1159;
    12: locale := LOCALE_S2359;
    13: locale := LOCALE_SCURRENCY;
    14: locale := LOCALE_SDATE;
    15: locale := LOCALE_SDECIMAL;
    16: locale := LOCALE_SGROUPING;
    17: locale := LOCALE_SLIST;
    18: locale := LOCALE_SLONGDATE;
    19: locale := LOCALE_SMONDECIMALSEP;
    20: locale := LOCALE_SMONGROUPING;
    21: locale := LOCALE_SMONTHOUSANDSEP;
    22: locale := LOCALE_SNEGATIVESIGN;
    23: locale := LOCALE_SPOSITIVESIGN;
    24: locale := LOCALE_SSHORTDATE;
    25: locale := LOCALE_STHOUSAND;
    26: locale := LOCALE_STIME;
    27: locale := LOCALE_STIMEFORMAT;
  end;
  result := GetLocaleStr(DefaultLCID, locale, '');
end;

{$ifdef LMDX86}
function LMDSIRdtsc: Int64;
var
  li: LARGE_INTEGER;
begin
  asm
    DW 310Fh // rdtsc
    MOV li.LowPart, EAX
    MOV li.HighPart, EDX
  end;
  Result := li.QuadPart;
end;
{$else}
function LMDSIRdtsc: Int64;
var
  li: LARGE_INTEGER;
asm
//  .NOFRAME
  DW 310Fh // rdtsc
  MOV li.LowPart, EAX
  MOV li.HighPart, EDX
  MOV RAX, li.QuadPart
end;
{$endif}

{ ---------------------------------------------------------------------------- }
function LMDSIGetCPUSpeed: Double;
const
  DelayTime = 500;
var
//  TimerHi: DWORD;
  TimerLo: DWORD;
  LTimer: LARGE_INTEGER;
  LNextTimer: LARGE_INTEGER;
  PriorityClass: Integer;
  Priority: Integer;
begin
  //get and save current priority
  PriorityClass := GetPriorityClass(GetCurrentProcess);
  Priority := GetThreadPriority(GetCurrentThread);
  //get the needed priority for cpu speed test
  SetPriorityClass(GetCurrentProcess, REALTIME_PRIORITY_CLASS);
  SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_TIME_CRITICAL);

  Sleep(10);

  LTimer := LARGE_INTEGER(LMDSIRdtsc());

//  asm
//    DW 310Fh // rdtsc
//    MOV TimerLo, EAX
//    MOV TimerHi, EDX
//  end;

  Sleep(DelayTime);

  LNextTimer := LARGE_INTEGER(LMDSIRdtsc());
  LTimer.QuadPart := LNextTimer.QuadPart - LTimer.QuadPart;
  TimerLo := LTimer.LowPart;

//  asm
//    DW 310Fh // rdtsc
//    SUB EAX, TimerLo
//    SBB EDX, TimerHi
//    MOV TimerLo, EAX
//    MOV TimerHi, EDX
//  end;

  //restore the original priority
  SetThreadPriority(GetCurrentThread, Priority);
  SetPriorityClass(GetCurrentProcess, PriorityClass);

  result := TimerLo / (1000.0 * DelayTime);
end;

{------------------------------------------------------------------------------}
function LMDSITimeElapsedSinceBoot:Double;
var
  Freq, CurrCount: Int64;
begin
  result:=0;
  if QueryPerformanceFrequency(Freq) then
    begin
      QueryPerformanceCounter(CurrCount);
      Result := (CurrCount / Freq / 86400);
    end;
end;

{------------------------------------------------------------------------------}
function LMDSILastBootTime:TDateTime;
var
  tmp:TDateTime;
begin
  result:=0;
  tmp:=LMDSITimeElapsedSinceBoot;
  if tmp > 0 then
    result:=Now - tmp
  else ;
end;

function CheckWin10: Boolean;
var
  version: string;
begin
  with TRegistry.Create(KEY_READ) do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKeyReadOnly('SOFTWARE\Microsoft\Windows NT\CurrentVersion');
    version := ReadString('ProductName');
    result  := (Pos(sLMDSysPlatform[pfWin10], version) <> 0) or
               (Pos(sLMDSysPlatform[pfWin2016Server], version) <> 0);
  finally
     Free;
  end;
end;

{$IFDEF LMDCOMP14}
function VerSetConditionMask(dwlConditionMask: DWORDLONG; dwTypeBitMask: DWORD; dwConditionMask: Byte): DWORDLONG; stdcall; external kernel32;

function CheckWin32Version(AMajor: Integer; AMinor: Integer = 0): Boolean;
var
   osvi             : {$IFDEF LMDCOMP20}Windows.TOSVersionInfoEx{$ELSE}TOSVersionInfo{$ENDIF};
   dwlConditionMask : DWORDLONG;
begin
   dwlConditionMask := 0;
   ZeroMemory(@osvi, sizeof({$IFDEF LMDCOMP20}Windows.TOSVersionInfoEx{$ELSE}TOSVersionInfo{$ENDIF}));
   osvi.dwOSVersionInfoSize := sizeof({$IFDEF LMDCOMP20}Windows.TOSVersionInfoEx{$ELSE}TOSVersionInfo{$ENDIF});
   osvi.dwMajorVersion := AMajor;
   osvi.dwMinorVersion := AMinor;
   dwlConditionMask := VerSetConditionMask( dwlConditionMask, VER_MAJORVERSION, 1 );
   dwlConditionMask := VerSetConditionMask( dwlConditionMask, VER_MINORVERSION, 1 );
   Result := VerifyVersionInfo(osvi,VER_MAJORVERSION OR VER_MINORVERSION, dwlConditionMask);
end;
{$ELSE}
function CheckWin81: Boolean;
var
  version: string;
begin
  with TRegistry.Create(KEY_READ) do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKeyReadOnly('SOFTWARE\Microsoft\Windows NT\CurrentVersion');
    version := ReadString('ProductName');
    result := (Pos(sLMDSysPlatform[pfWin81], version) = 1) or
              (Pos(sLMDSysPlatform[pfWin2012R2Server], version) = 1);
  finally
     Free;
  end;
end;
{$ENDIF}

{------------------------------------------------------------------------------}
procedure InitVersions;
const
  VERSUITEENTERPRISE = 2;
  VERSUITEPERSONAL = 3;
  SM_TABLETPC = 86;
  SM_MEDIACENTER = 87;
  PROCESSOR_ARCHITECTURE_IA64 = 6;
  PROCESSOR_ARCHITECTURE_AMD64 = 9;
begin
  if SysUtils.Win32PlatForm = VER_PLATFORM_WIN32_WINDOWS then
    begin
      // Detect Win9X platform
      if (Win32MajorVersion>=4) and (Win32MinorVersion>=90) then
        begin
          LMDSysPlatform:=pfWinME;
          LMDSIWindowsME:=True;
        end
      else
        if Win32MinorVersion>=10 then
          begin
            LMDSysPlatform := pfWin98;
            LMDSIWindows98:=True;
          end
        else
          begin
            LMDSysPlatform := pfWin95;
            LMDSIWindows95 := true;
          end;
      LMDSIWindowsExtension := SystemParametersInfo(SPI_GETWINDOWSEXTENSION, 1, nil, 0);
    end
  else
    begin
      LMDSIWindowsExtension := true;
      LMDSIWindowsNT := (SysUtils.Win32PlatForm = VER_PLATFORM_WIN32_NT);
      case Win32MajorVersion of
        5: if Win32MinorVersion = 0 then
             begin
               LMDSIWindows2000 := true;
               LMDSysPlatform:=pfWin2K;
               LMDSIWindows2000AdvancedServer := LMDSISuiteMask = VERSUITEENTERPRISE;
             end
           else
             begin
               LMDSIWindowsXP := True;
               LMDSIWindowsXPSP3 := Boolean(Win32CSDVersion='Service Pack 3');
               LMDSIWindowsXPSP2 := LMDSIWindowsXPSP3 or Boolean(Win32CSDVersion='Service Pack 2');
               LMDSysPlatform := pfWinXP;
               LMDSIWindowsXPServer := Win32MinorVersion > 1;
               if LMDSIWindowsXPServer then
                 begin
                   LMDSINETServer := LMDSISuiteMask = VERSUITEENTERPRISE;
                   LMDSysPlatform := pfWin2003Server;
                 end
               else //WKS
                 if LMDSISuiteMask = VERSUITEPERSONAL then
                   LMDSIWindowsXPHome := True
                 else
                   if GetSystemMetrics(SM_MEDIACENTER) <> 0 then
                     LMDSIWindowXPMediaCenterEdition := true
                   else
                     if GetSystemMetrics(SM_TABLETPC) <> 0 then
                       LMDSIWindowsXPTabletEdition := true
                     else
                       LMDSIWindowsXPProf := true;
              end;
         6: begin
              case Win32MinorVersion of
                0: begin
                     LMDSIWindowsVista := true;
                     if LMDSIProductType = SI_WORKSTATION then
                       LMDSysPlatform := pfWinVista
                     else
                       LMDSysPlatform := pfWin2008server;
                   end;
                1: begin
                     LMDSIWindows7 := true;
                     if LMDSIProductType = SI_WORKSTATION then
                       LMDSysPlatform := pfWin7
                     else
                       LMDSysPlatform := pfWin2008R2Server;
                   end;
              else  // 2
                begin
                  if CheckWin10 then
                  begin
                    LMDSIWindows10 := true;
                    if LMDSIProductType = SI_WORKSTATION then
                      LMDSysPlatform := pfWin10
                    else
                      LMDSysPlatform := pfWin2016Server;
                  end
                  else if {$IFDEF LMDCOMP14}CheckWin32Version(6,3){$ELSE}
                          CheckWin81{$ENDIF} then
                  begin
                    LMDSIWindows81 := true;
                    if LMDSIProductType = SI_WORKSTATION then
                      LMDSysPlatform := pfWin81
                    else
                      LMDSysPlatform := pfWin2012R2Server;
                  end
                  else
                  begin
                    LMDSIWindows8 := true;
                    if LMDSIProductType = SI_WORKSTATION then
                      LMDSysPlatform := pfWin8
                    else
                      LMDSysPlatform := pfWin2012Server;
                  end;
                end;

              end
         end
      else
        LMDSysPlatform := pfWinNT;
      end;
      LMDSIWindowsNTUp := LMDSIWindowsNT or LMDSIWindows2000Up;
      LMDSIWindows2000Up := Win32MajorVersion >= 5;
      LMDSIWindowsVistaUp := Win32MajorVersion >= 6;
      LMDSIWindowsXPUp := ((Win32MajorVersion >= 5) and (Win32MinorVersion >= 1)) or LMDSIWindowsVistaUp;
      LMDSIWindowsWindows7Up := ((Win32MajorVersion = 6) and (Win32MinorVersion >= 1)) or (Win32MajorVersion >= 7);
      LMDSIWindowsWindows8Up := ((Win32MajorVersion = 6) and (Win32MinorVersion >= 2)) or (Win32MajorVersion >= 7);
      LMDSIWindows2003Up:=((Win32MajorVersion >= 5) and (Win32MinorVersion >= 2)) or LMDSIWindowsVistaUp;
      LMDSIWindowsXPSP2Up := LMDSIWindowsXPSP2 or LMDSIWindows2003Up or LMDSIWindowsVistaUp;
  end;
end;

initialization
  InitVersions;
  {$ifdef LMDCOMP12}
  LMDSIUnicodeDelphi := True;
  {$endif}
end.
