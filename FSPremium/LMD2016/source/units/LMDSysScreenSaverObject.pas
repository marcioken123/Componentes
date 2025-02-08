unit LMDSysScreenSaverObject;
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

LMDSysScreenSaverObject unit (JH, AH)
-------------------------------------
Information about screen saver settings


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  LMDSysBase,
  LMDSysObject
  ;

type
  { ************************************************************************** }
  TLMDSysScreenSaverObject = class(TLMDSysObject)
  private
    //    FOldSecure: Boolean;
    FSecure: Boolean;
    FRunning: Boolean;
    FScreenSaverActive: Boolean;
    //    FOldScreenSaverDelayCardinal;
    FScreenSaverDelay: Cardinal;
    //    FOldExeName: string;
    FExeName: string;
    FScreenSavers: TStrings;
    FPreviewProcess: THandle;

    procedure SetDummyBool(index: Integer; aValue: Boolean);
    procedure SetDummyCardinal(aValue: Cardinal);
    procedure SetDummyStrings(aValue: TStrings);
    procedure SetString(aValue: string);
    function GetBool(index: Integer): Boolean;
    function GetCardinal: Cardinal;
    function GetStrings: TStrings;
    function GetString: string;
  protected
    procedure RegisterProperties; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    //    procedure GetValues(aText: TStrings); override;
    procedure Refresh; override;
    procedure Apply; override;
    //If you want to see how the screen saver looks like if it runs you can call
    //test and the screen saver will be started.
    procedure Test;
    //Execute this method for displaying the screen savers configuration dialog.
    procedure Config;
    //Preview starts the currently selected screensaver in a small windowed
    //control specified by the aWndHandle parameter
    //Use StopPreview for freeing the system ressources allocated by this
    procedure Preview(aWndHandle: HWND);
    //Use StopPreview to stop a currently launched screensaver Preview session.
    //If Preview has not been executed before a call to this method will do nothing
    procedure StopPreview;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

  published
    //if active is false the screen saver will not be activated after the delay
    //time nor at any other time.
    property Active: Boolean index 0 read GetBool write SetDummyBool stored false;
    //Delay is the time in minutes which the system will wait for any user input
    //til it launches the screensaver
    property Delay: Cardinal read GetCardinal write SetDummyCardinal stored false;
    //Secure is true if the password option for the screen saver has been activated
    property Secure: Boolean index 1 read GetBool write SetDummyBool stored false;
    //
    property Running: Boolean index 2 read GetBool write SetDummyBool stored false;
    //currently set screensaver scr filename
    property ScreenSaver: string read GetString write SetString stored false;
    //List of screen savers available on the current system
    property ScreenSavers: TStrings read GetStrings write SetDummyStrings stored false;
  end;

  TLMDSysScreenSaverObjectClass = class of TLMDSysScreenSaverObject;

implementation

uses
  Forms,
  ShellAPI,
  SysUtils,
  LMDSysLogStrings, LMDSysConst;

const
  cpidActive            = 0;
  cpidDelay             = 1;
  cpidSecure            = 2;
  cpidRunning           = 3;
  cpidScreenSaver       = 4;
  cpidScreenSavers      = 5;

{ Helper function. The LMDStartScreenSaver function will start the specified
  executable with the given paras (parameters) and return the process handle of
  the newly created process.
}
{ ---------------------------------------------------------------------------- }

function LMDStartScreenSaver(const exeName, paras: string): THandle;
var
  LPI: PROCESS_INFORMATION;
  {$ifdef LMDCOMP12}
  SIA: _STARTUPINFOW;
  {$else}
  SIA: _STARTUPINFOA;
  {$endif} 
  begin
  LPI.hProcess:= 0;
  with SIA do
    begin
      cb:= SizeOf(SIA);
      lpReserved:= nil;
      lpDesktop:= nil;
      lpTitle:= nil;
      dwFlags:= STARTF_USESHOWWINDOW or STARTF_FORCEOFFFEEDBACK;
      wShowWindow:= SW_SHOW;
      cbReserved2:= 0;
      lpReserved2:= nil;
    end;

  CreateProcess(PChar(exeName), PChar(paras),
    nil, nil, false, NORMAL_PRIORITY_CLASS, nil, nil, SIA, LPI);
  CloseHandle(LPI.hThread);
  Result:= LPI.hProcess;
end;

{ **************************************************************************** }
{ --------------------------------- private ---------------------------------- }

procedure TLMDSysScreenSaverObject.SetDummyBool(index: Integer; aValue: Boolean);
begin
  case index of
    1:
      if aValue <> FSecure then
        begin
          RememberChange(strScreensaverSecure, BoolToStr(FSecure), BoolToStr(aValue));
          FSecure:= aValue;
          if ApplyChangesAtOnce then
            Apply;
        end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysScreenSaverObject.SetDummyCardinal(aValue: Cardinal);
begin
  if aValue <> FScreenSaverDelay then
    begin
      RememberChange(strScreensaverDelay, IntToStr(FScreenSaverDelay), IntToStr(aValue));
      FScreenSaverDelay:= aValue;
      if ApplyChangesAtOnce then
        Apply;
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysScreenSaverObject.SetDummyStrings(aValue: TStrings);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysScreenSaverObject.SetString(aValue: string);
begin
  if aValue <> FExeName then
    begin
      RememberChange(strScreensaverExeName, FExeName, aValue);
      FExeName:= aValue;
      if ApplyChangesAtOnce then
        Apply;
    end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDSysScreenSaverObject.GetBool(index: Integer): Boolean;
begin
  if FInstantUpdate then
    Refresh;
  case index of
    0: Result:= FScreenSaverActive;
    1: Result:= FSecure;
    2: Result:= FRunning;
  else
    Result:= false;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDSysScreenSaverObject.GetCardinal: Cardinal;
begin
  if FInstantUpdate then
    Refresh;
  Result:= FScreenSaverDelay;
end;

{ ---------------------------------------------------------------------------- }

function TLMDSysScreenSaverObject.GetStrings: TStrings;
begin
  if FInstantUpdate then
    Refresh;
  Result:= FScreenSavers;
end;

{ ---------------------------------------------------------------------------- }

function TLMDSysScreenSaverObject.GetString: string;
begin
  if FInstantUpdate then
    Refresh;
  Result:= FExeName;
end;

{ --------------------------------- protected -------------------------------- }
procedure TLMDSysScreenSaverObject.RegisterProperties;
begin
  FPropertiesDesc.Add(cpidActive, sLMDSysDisplayScreenSaverPropTitleActive, sLMDSysDisplayScreenSaverPropDescActive);
  FPropertiesDesc.Add(cpidDelay, sLMDSysDisplayScreenSaverPropTitleDelay, sLMDSysDisplayScreenSaverPropDescDelay);
  FPropertiesDesc.Add(cpidSecure, sLMDSysDisplayScreenSaverPropTitleSecure, sLMDSysDisplayScreenSaverPropDescSecure);
  FPropertiesDesc.Add(cpidRunning, sLMDSysDisplayScreenSaverPropTitleRunning, sLMDSysDisplayScreenSaverPropDescRunning);
  FPropertiesDesc.Add(cpidScreenSaver, sLMDSysDisplayScreenSaverPropTitleScreenSaver, sLMDSysDisplayScreenSaverPropDescScreenSaver);
  FPropertiesDesc.Add(cpidScreenSavers, sLMDSysDisplayScreenSaverPropTitleScreenSavers, sLMDSysDisplayScreenSaverPropDescScreenSavers);
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDSysScreenSaverObject.Create;
begin
  inherited Create;
  FScreenSavers:= TStringList.Create;
  ApplyChangesAtOnce:= true;
  FPreviewProcess:= 0;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDSysScreenSaverObject.Destroy;
begin
  FScreenSavers.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }

//procedure TLMDSysScreenSaverObject.GetValues(aText: TStrings);
//begin
//end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysScreenSaverObject.Refresh;
const
  sz = 1023;
var
  tmp: Integer;
  b: Boolean;
  tmpStr : string;
  tempDir: array[0..sz] of char;
  //This procedure is used for enumerating all installed screen savers
  //installed = contained in directory specified by tempDir

  procedure findEm;
  var
    sr: TSearchRec;
    s: string;
    tmp: Integer;
  begin
    s := tempDir;
    if s[Length(s)] <> '\' then s:= s + '\';
    tmp:= FindFirst(s + '*.scr', faAnyFile + faArchive + faSysFile + faHidden, sr);
    while tmp = 0 do
      begin
        FScreenSavers.Add(s + sr.Name);
        tmpStr := tmpStr + '; ' + FScreenSavers[FScreenSavers.count-1];
        tmp:= FindNext(sr);
      end;
    FindClose(sr);
  end;

begin
  DoProgress(sLMDSysDisplayScreenSaverObjectTitle, 100, 0);
  tmpStr := '';
  FPropertiesDesc.InvalidateProperties;

  SystemParametersInfo(SPI_GETSCREENSAVETIMEOUT, 0, @tmp, 0);
  FScreenSaverDelay:= tmp div 60;
    FPropertiesDesc.PropertyByID(cpidDelay).Text := IntToStr(FScreenSaverDelay);
DoProgress(sLMDSysDisplayScreenSaverObjectTitle, 100, 20);

  //  FOldScreenSaverDelay:= FScreenSaverDelay;

  SystemParametersInfo(SPI_GETSCREENSAVEACTIVE, 0, @b, 0);
  FScreenSaverActive:= b;
    FPropertiesDesc.PropertyByID(cpidActive).Text := BoolToStr(b);
DoProgress(sLMDSysDisplayScreenSaverObjectTitle, 100, 40);

  SystemParametersInfo(SPI_SCREENSAVERRUNNING, 0, @b, 0);
  FRunning:= b;
    FPropertiesDesc.PropertyByID(cpidRunning).Text := BoolToStr(b);
DoProgress(sLMDSysDisplayScreenSaverObjectTitle, 100, 60);

  //  SPI_GETSCREENSAVERRUNNING = 114;

  OpenRegistry(true);

  SetRegistryRootKey(HKEY_CURRENT_USER);

  if OpenRegistrySubKey('\Control Panel\Desktop') then
    begin
      FSecure:= Registry.ReadString('ScreenSaverSecure') = '';
        FPropertiesDesc.PropertyByID(cpidSecure).Text := BoolToStr(FSecure);
      //      FOldSecure:= FSecure;
      FExeName:= Registry.ReadString('SCRNSAVE.EXE');
        FPropertiesDesc.PropertyByID(cpidScreenSaver).Text := FExeName;
      //      FOldExeName:= FExeName;
      CloseRegistrySubKey;
    end;
DoProgress(sLMDSysDisplayScreenSaverObjectTitle, 100, 80);

  //search hard disk directories for any installed screen savers
  FScreenSavers.Clear;
  GetWindowsDirectory(tempDir, sz);
  //search in the windows directory
  findEm;
  GetSystemDirectory(tempDir, sz);
  //search in the windows/system directory
  findEm;
    FPropertiesDesc.PropertyByID(cpidScreenSavers).Text := tmpStr;

  DoProgress('', 100, 0);
  end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysScreenSaverObject.Apply;
const
  vals: array[false..true] of string = ('0', '1');
begin
  OpenRegistry(true);

  SetRegistryRootKey(HKEY_CURRENT_USER);

  if OpenRegistrySubKey('\Control Panel\Desktop') then
    begin
      if {FSecure <> FOldSecure}  PropChanged(strScreensaverSecure) then
        begin
          //          Log('Secure', vals[FOldSecure], vals[FSecure]);
          WriteToLog(strScreensaverSecure);
          Registry.WriteString('ScreenSaverSecure', vals[FSecure]);
        end;
      if {FOldExeName <> FExeName}  PropChanged(strScreensaverExeName) then
        begin
          //          Log('ScreenSaver', 'FOldExeName', FExeName);
          WriteToLog(strScreensaverExeName);
          Registry.WriteString('SCRNSAVE.EXE', FExeName);
        end;
      if {FScreenSaverDelay <> FOldScreenSaverDelay}  PropChanged(strScreensaverDelay) then
        begin
          WriteToLog(strScreensaverDelay);
          //          Log('Delay', IntToStr(FOldScreenSaverDelay), IntToStr(FScreenSaverDelay * 60));
          Registry.WriteString('ScreenSaveTimeOut', IntToStr(FScreenSaverDelay * 60));
        end;
      CloseRegistrySubKey;
    end;

  //Refresh;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysScreenSaverObject.Test;
var
  h: THandle;
begin
  h:= LMDStartScreenSaver(FExeName, ' s');
  CloseHandle(h);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysScreenSaverObject.Config;
var
  h: THandle;
begin
  //start the screensaver configuration dialog
  h:= LMDStartScreenSaver(FExeName, '');
  //wait until the configuration dialog is closed
  if h <> 0 then
    WaitForSingleObject(h, INFINITE);
  CloseHandle(h);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysScreenSaverObject.Preview(aWndHandle: HWND);
begin
  //stop a previously started preview
  StopPreview;

  //start a new preview into the control specified by aWndHandle
  FPreviewProcess:= LMDStartScreenSaver(FExeName, ' p ' + IntToStr(aWndHandle));
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysScreenSaverObject.StopPreview;
{var
  tid: Cardinal;}
begin
  //if there is a preview running
  if FPreviewProcess <> 0 then
    begin
      //terminate the preview
      TerminateProcess(FPreviewProcess, 0);
      //WaitForSingleObject (FPreviewProcess, INFINITE);
      CloseHandle(FPreviewProcess);
      FPreviewProcess:= 0;
    end;
end;

// c -> config with wnd handle
// no param -> config without wnd handle
// p -> preview with wnd handle
// a -> check pwd (win 95)
// s -> full screen

{ ---------------------------------------------------------------------------- }
function TLMDSysScreenSaverObject.GetElementTitle : string;
begin result := sLMDSysDisplayScreenSaverObjectTitle; end;

{ ---------------------------------------------------------------------------- }
function TLMDSysScreenSaverObject.GetElementDescription : string;
begin result := sLMDSysDisplayScreenSaverObjectDesc; end;

{ ---------------------------------------------------------------------------- }
function TLMDSysScreenSaverObject.GetElementType : TLMDSysInfoType;
begin result := itDisplayScreenSaver; end;

{ ---------------------------------------------------------------------------- }

end.
