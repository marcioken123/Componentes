unit LMDClass;
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

LMDClass unit (RM)
------------------
TLMDApplication and general types and constants for LMDRTL. Also global
LMDApplication variable is specified here.


Changes
-------
Release 9.0 (July 2008)
+ ThemeGlobalMode
+ ThemeUseColorProperty (-> Edit controls use Color property instead of themed colors)

Release 8.01 (October 2007)
- LMDApplication.LogMaxsize: Bug with unclosed file handles fixed

Release 8.0 (October 2006)
- Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Forms, Graphics, ExtCtrls, Controls, SysUtils, Messages, Dialogs,
  LMDTypes, LMDObject, LMDIniCtrl, LMDProcs, LMDCustomComponent;

const
  // global available constants
  IDS_DEFAULTDELIMITER: Char = ',';

  LMD_DEFINTERVAL=50;

  LMD_DEFAULTFONT  ='Arial';             // do not localize
  IDS_INTERNAL = 'Internal';             // do not localize
  IDS_CTLXP = 'CtlXP';                   // do not localize

  CM_LMDPROPCHANGE = CM_BASE + 301;
  CM_LMDCOLDESTROY = CM_BASE + 302;
  CM_DEVICECHANGE = CM_BASE + 303;

  CM_TRANSPARENTCHANGED=CM_BASE+205;           {internal message for TLMDBaseGraphicControl}

  CM_LMDBACKCHANGED=CM_BASE+206;               {TLMDBack[..] controls must redraw}
  CM_LMDAFTERENTER=CM_BASE+207;
  CM_LMDAFTEREXIT=CM_BASE+208;
  CM_LMDBEVELCHANGED=CM_BASE+209;

  // 5.0
  CM_REDOCK= CM_BASE+102;           {internal message for DockButtons}
  CM_LMDDOCKED= CM_BASE+210;
  CM_LMDSCROLLBOXSCROLLEVENT = CM_BASE + 212;

  // 6
  CM_LMDTHEMECHANGED=CM_BASE+214;
  CM_LMDPARENTCTLXPCHANGED= CM_BASE + 216;

  // 7.0
  CM_LMDBOUNDLABELCHANGE=CM_BASE + 217;

type
  // ***************************************************************************
  // * New Theme Support in LMD2008+ releases
  // ***************************************************************************
  TLMDThemeMode = (ttmNone,       // = No global themeing, use control settings
                   ttmPlatform,   // = CtlXP or UseXPThemes
                   ttmNative      // =
                   );

type
  TLMDColorScheme = (csBlue, csMetallic, csHomestead, csBlack, csVistaBasic, csCustom, csDefaultScheme, csUnknown);

const
  CBuiltInColorSchemes: array[TLMDColorScheme] of string = ('Blue', 'Metallic', 'Homestead', 'Black', 'VistaBasic', 'Custom', 'Default', 'Unknown');

const
  LMDCtlXP : array[boolean] of TLMDThemeMode = (ttmNone, ttmPlatForm);  // allows simple conversion

type
  {other typed strings}
  TLMDHTMLString=type TLMDString; //{$IFDEF LMD_UNICODE}WideString{$ELSE}String{$ENDIF};
  TLMDDateTimeFormat=type String;

  //4.0 DialogPositions
  TLMDDlgPosRel = (brScreen, brScreenWorkArea, brMainForm, brActiveWindow);
  TLMDDlgPosition = (bpCustom,
                     bpTopLeft, bpTopCenter, bpTopRight,
                     bpCenterLeft, bpCenter, bpCenterRight,
                     bpBottomLeft, bpBottomCenter, bpBottomRight);

  TLMDBoundsChangeState=(bcSize, bcPos);
  TLMDBoundsChangeStates=set of TLMDBoundsChangeState;
  TLMDDockPosition=(dpBottom, dpLeft, dpRight, dpTop);

  // 7.03
  TLMDDlgEffect=(deNone, deExplode, deExplodeExt);

  // 4.0 new timerstyles
  TLMDTimerMode=(tmNormal, tmGlobalTimer, tmHiTimer, tmThreaded);

  {----------------------------------------------------------------------------}
  TLMDCharCase=(ccNormal, ccLowerCase, ccUpperCase);

  {----------------------TLMDApplication---------------------------------------}
  TLMDTimerPool=class;
  TLMDTimerItem=class;

  TLMDApplicationOption=(aoAutoRealizePalette, aoMouseCtrlActive, aoLogAlwaysClear,
                         aoLogException, aoLogHeader, aoLogNr, aoLogTime, aoLogDate );
  TLMDApplicationOptions=set of TLMDApplicationOption;
  TLMDLogAction=(laNone, laClearLog, laBackupLog);

  TLMDExceptionEvent=procedure(Sender:TObject;E:Exception;var Cancel:Boolean) of object;

  TLMDMaxLogSizeEvent=procedure(Sender:TObject; const LogName:String; var Cancel:Boolean) of object;

  {$ifdef LMDCOMP14}
  TLMDOnHeaderWrite=procedure(Sender : TObject;const Target: TStringList) of object;
  {$else}
  TLMDOnHeaderWrite=procedure(Sender : TObject;var Target : Text) of object;
  {$endif}

  {ExitWindows Method}
  TLMDExitCode=(ecQuit, ecReboot, ecRestart);
  {**** }

  TLMDEditMode = (emInsert, emShift, emCtrl, emAlt, emCaps, emNum, emScroll);
  TLMDEditModes = Set of TLMDEditMode;

  TLMDApplication = class(TComponent)
    private
      FForceAnsi: boolean;
      {additional Infos about application}
      FMask,                               // --> used for about dialog
      FCompany,                            // --> creating proper key for registry in Win32
      FVersion:String;                     // HKEY_CURRENT_USER\CompanyName\ApplicationTitle\Version
      {global options, objects}
      FOptions:TLMDApplicationOptions;
      FIniCtrl:TLMDIniCtrl;
      { Edit Controls }
      FEditMode : TLMDEditModes;
      FOnEditModeChange : TNotifyEvent;
      {fading of forms}
      FEffectDelay:Byte;
      {global pattern brushes}
      FMonoPattern,
      FPatternBitmap:TBitmap;
      FLastColor:TColor;
      {global timer pool, used by LMD components}
      FTimerPool:TLMDTimerPool;
      {LogFile-Feature}
      FLogPrefix:TLMDPathPrefix;
      FLogName:String;
      FLogMaxSize:LongInt;
      FUpdate:Byte;
      FCounter:LongInt;
      FlogAction:TLMDLogAction;
      FOnMaxLogSize:TLMDMaxLogSizeEvent;
      FOnHeaderWrite : TLMDOnHeaderWrite; //4.51
      {StopWatch}
      FTimerFrequency,
      FStartTime:Int64;
      // 6.1
      FCheckBitmap:TBitmap;
      { LMD MessageBox }
      FMsgBoxStyle : TObject;
      {check Previous Instance feature}
      FMHandle:THandle;
      FIsPrevRunning:Boolean;
      FPreviouseAppWin: THandle;
      {Exception}
      FOnException:TLMDExceptionEvent;
      // LMD-Tools 6.0 Enhancements
      FCheckHeight, FCheckWidth:Integer;
      // Windows XP and Themes Support
      FLMDOnly,
      FUseXPThemes,
      FManifest: Boolean;
      FThemeUseColorProperty: boolean;
      FGlobalThemeMode: TLMDThemeMode;
      function GetXPThemesSupported: Boolean; //JH March 2002
      function GetUseXPThemes:Boolean;
      procedure SetXPThemeSupport (aValue: Boolean);
      procedure SetXPLMDOnly (aValue: Boolean);
      procedure SetThemeUseColorProperty(const Value: boolean);
      procedure SetGlobalThemeMode(const Value: TLMDThemeMode);
      function GetThemeModeSupported(index: TLMDThemeMode): Boolean;
      // 6.1
      function GetCheckCustomWidth:Integer;
      function GetCheckCustomHeight:Integer;
      procedure SetCheckBitmap(aValue:TBitmap);
      // --
      function GetUnicodeTitle: TLMDString;
      procedure SetUnicodeTitle(const Value: TLMDString);
      {private methods}
      procedure SetLogPrefix(aValue:TLMDPathPrefix);
      procedure SetLogName(const aValue:String);
      procedure SetEditMode (aValue:TLMDEditModes);
      function GetBitmap:TBitmap;
      {only for internal use}
      function GetTimer(Ident:Word):TLMDTimerItem;
      function GetTimerIdent:Word;
      {function GetFontList:TStrings;}
      function GetTimerFrequency:Extended;
      procedure FindPreviousInstance;
    public
      constructor Create(aOwner:TComponent);override;
      destructor Destroy;override;
      procedure DoThemeChange;
      {global Timer feature}
      function AddTimer(wInterval:Word; CallProc:TNotifyEvent):Word;
      function AddTimerExt(wInterval:Word; iCallCount:Integer;
                           bEnabled:Boolean; CallProc:TNotifyEvent):Word;
      procedure RemoveTimer(Ident:Word);

      {StopWatch feature}
      procedure STWStart;
      function STWStop:LongInt;
      //7.0
      function STWStopExt:Extended;

      {global brush pattern feature}
      function GetBrushBitmap(aColor:TColor):TBitmap;

      {uses Company and version information}
      function GetDefaultRegPath:String;

      {Exit Windows-Method}
      function QuitWindows(aValue:TLMDExitCode):Boolean;

      {for internal use and only useful after initialization}
      property IsPrevRunning:Boolean read FIsPrevRunning;
      property PreviouseAppWin: THandle read FPreviouseAppWin;

      {LogFile Feature}
      procedure HandleException(Sender:TObject; E:Exception);
      procedure LogException(Sender:TObject);
      procedure LogWrite(const aValue:String);

      // 6.1
      // specify default bitmap for TLMDCheckListBox controls
      property CheckBitmap:TBitmap read FCheckBitmap write SetCheckBitmap;
      property CheckCustomWidth:Integer read GetCheckCustomWidth;
      property CheckCustomHeight:Integer read GetCheckCustomHeight;
      // ---

      {Properties}
      property Company:String read FCompany write FCompany;
      property DlgEffectDelay:Byte read FEffectDelay write FEffectDelay;
      property Ini:TLMDIniCtrl read FIniCtrl;
      property MsgBox : TObject read FMsgBoxStyle write FMsgBoxStyle;
      property EditMode : TLMDEditModes read FEditMode write SetEditMode default [emInsert];
      property OnEditModeChange : TNotifyEvent read FOnEditModeChange write FOnEditModeChange;

      // Windows XP Support
      property UseXPThemes: Boolean read GetUseXPThemes write SetXPThemeSupport;
      property UseXPThemesLMDOnly:Boolean read FLMDOnly write SetXPLMDOnly;
      property XPThemesSupported: Boolean read GetXPThemesSupported;
      property XPManifestAvailable:Boolean read FManifest write FManifest;
      // GlobalThemeSupport
      property ThemeSupported[index:TLMDThemeMode]:Boolean read GetThemeModeSupported;

      // Unicode title support
      property UnicodeTitle: TLMDString read GetUnicodeTitle write SetUnicodeTitle;

      {LogFileFeature}
      property LogMaxsize:LongInt read FLogMaxSize write FLogMaxSize;
      property LogMaxAction:TLMDLogAction read FLogAction write FLogAction;
      property LogName:String read FLogName write SetLogName;
      property LogPrefix:TLMDPathPrefix read FLogPrefix write SetLogPrefix;
      property LogMask:String read FMask write FMask;

      property PatternBitmap:TBitmap read GetBitmap;
      property Options:TLMDApplicationOptions read FOptions write FOptions;
      property Timer[Ident:Word]:TLMDTimerItem read GetTimer;
      property Timers:TLMDTimerPool read FTimerPool;
      property Version:String read FVersion write FVersion;

      // 4.0 Timer
      property TimerFrequency:Extended read GetTimerFrequency;

      // LMD-Tools 6.0 Enhancements
      property CheckDefWidth:Integer read FCheckWidth;
      property CheckDefHeight:Integer read FCheckHeight;

      {LMD Exception Handler}
      property OnException:TLMDExceptionEvent read FOnException write FOnException;
      property OnMaxLogSize:TLMDMaxLogSizeEvent read FOnMaxLogSize write FOnMaxLogSize;
      property OnHeaderWrite : TLMDOnHeaderWrite read FOnHeaderWrite write FOnHeaderWrite;

      // 9.0
      property ThemeUseColorProperty: Boolean read FThemeUseColorProperty write SetThemeUseColorProperty;
      property ThemeGlobalMode: TLMDThemeMode read FGlobalThemeMode write SetGlobalThemeMode;  // default ttmPlatform

      property ForceANSI: boolean read FForceAnsi write FForceAnsi;
   end;

  {********************** Wrapper Class ***************************************}
  {-------------------------- TLMDTimer ---------------------------------------}
  TLMDTimer=class(TObject)
  private
    FTimer:TTimer;
    FTimerID:Word;
    FGlobalTimer: Boolean;
    FEnabled: Boolean;
    FInterval: Word;
    FOnTimer: TNotifyEvent;
    procedure SetEnabled(const Value: Boolean);
    procedure SetGlobal(const Value: Boolean);
    procedure SetInterval(const Value: Word);
    procedure RemoveTimer;
    procedure UpdateTimer;
  protected
    procedure Timer(Sender:TObject);
  public
    constructor Create(gInterval: Word; gTimer: TNotifyEvent; gEnabled: Boolean=true; gmode: Boolean=false);
    destructor Destroy;override;

    property Enabled:Boolean read FEnabled write SetEnabled;
    property Interval:Word read FInterval write SetInterval;
    property GlobalMode:Boolean read FGlobalTimer write SetGlobal;
    property OnTimer:TNotifyEvent read FOnTimer write FOnTimer;
  end;

  {**************************** TLMDTimerPool *********************************}
  {----------------------------------------------------------------------------}
  {TLMDTimerItem}
  TLMDTimerItem=class(TObject)
  private
    FCallCount : Integer;
    FCounter   : LongInt;
    FEnabled   : Boolean;       {still Enabled?}
    FIdent     : Word;
    FInterval:Word;         {Interval}
    FInternal:Integer;
    FList:TList;
    FOwner:TLMDTimerPool;
    FOnTimer:TNotifyEvent;  {The event which should fired}
    procedure SetCallCount(aValue:Integer);
    procedure SetEnabled(aValue:Boolean);
    procedure SetInterval(aValue:Word);
  public
    constructor Create(aOwner:TLMDTimerPool; aList:TList; aIndex:Word);
    destructor Destroy;override;
    procedure Timer;
    property CallCount:Integer read FCallCount write SetCallCount;
    property Counter:LongInt read FCounter;
    property Enabled:Boolean read FEnabled write SetEnabled;
    property Interval:Word read FInterval write SetInterval;
    property Ident:Word read FIdent;

    property HitValue:Integer read FInternal;   {internal used value}
    property OnTimer:TNotifyEvent read FOnTimer write FOnTimer;
  end;

  TLMDTimerInterval=1..High(Word);
  TLMDTimerPoolEvent=procedure(Sender:TObject; Ident:Word; Counter:LongInt) of object;

  {the component itself}
  TLMDTimerPool = class(TLMDCustomComponent)
  private
    FActive:Boolean;
    FFLag:Boolean;
    FHWND:HWND;
    FPCounter:LongInt;
    FInterval:TLMDTimerInterval;
    FList:TList;
    FUpdate:Byte;
    FOnTimerEvent: TLMDTimerPoolEvent;  {for all timers}
    procedure SetInterval(aValue:TLMDTimerInterval);
    function GetActiveTimers:Integer;
    function GetCount:Integer;
    function GetTimer(Ident:Word):TLMDTimerItem;
    procedure HandleTimers;
    procedure UpdateMainTimer(aValue:Boolean);
    procedure WndProc(var Msg: TMessage);
    procedure InitAttributes;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateRunTime(aOwner:TComponent; MinInterval:TLMDTimerInterval);
    destructor Destroy; override;
    function AddTimer(Ident:Word; wInterval:Word; CallProc:TNotifyEvent):Integer;
    function AddTimerExt(Ident:Word; wInterval:Word; iCallCount:Integer;
                          bEnabled:Boolean; CallProc:TNotifyEvent):Integer;
    procedure ClearTimers;
    function HasTimerProc:Boolean;
    function IndexOf(Ident:Word):Integer;
    procedure RemoveTimer(Ident:Word);

    property ActiveTimers:Integer read GetActiveTimers;
    property Count:Integer read GetCount;
    property Timer[Ident:Word]:TLMDTimerItem read GetTimer;default;
  published
    property About;
    property MinInterval:TLMDTimerInterval read FInterval write SetInterval default 1000;
    property OnTimer:TLMDTimerPoolEvent read FOnTimerEvent write FOnTimerEvent;
  end;

  ELMDOneInstError=class(Exception)
    constructor Create(const cName:String; aValue:Byte);          {general}
  end;

{helpers}

function LMDCheckForSameClass(aOwner:TComponent; aClass:TClass; AllowDataModule:Boolean):Boolean;

var
  LMDApplication:TLMDApplication;

implementation

uses
  RtlConsts, Consts, Inifiles, Registry, Themes, UxTheme, Types,
  LMDShUtils, LMDSysIn, LMDUnicode, LMDStrings, LMDRTLConst;

{$IFDEF LMD_DEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

{************************* Help functions *************************************}
{useful helper for all components with max 1 instance per form}
function LMDCheckForSameClass(aOwner:TComponent; aClass:TClass; AllowDataModule:Boolean):Boolean;
var
  i, icount:Integer;
begin
  result:=false;
  icount:=0;
  if ((aOwner=nil) or not (aOwner is TForm)) and not (AllowDataModule and (aOwner is TDataModule)) then
    result:=true
  else
    if aClass<>nil then
      with TComponent(aOwner) do
        for i:=0 to Pred(ComponentCount) do
          begin
            if Components[i] is aClass then Inc(iCount);
            if iCount>1 then
              begin
                result:=True;
                break;
              end;
          end;
end;

{************************ Object ELMDEOneInstError *****************************}
constructor ELMDOneInstError.Create(const cName:String; aValue:Byte);
begin
  case aValue of
    0: inherited Create(cName+':'#13+IDS_INVALIDOWNER);
    1: inherited Create(cName+':'#13+'Already one '+cname+' control in this project!');
  end;
end;

{************************ Object TLMDApplication ******************************}
var
  TimerField:array[1..250] of Boolean;

const
  LMDTimerStart=$FD00;

{------------------------- Private --------------------------------------------}
function TLMDApplication.GetXPThemesSupported: Boolean;
begin
  //check for availability of XP themes (dll present, theme activated (JH March 2002))
  result := ThemeServices.ThemesAvailable and Assigned(IsThemeActive) and IsThemeActive; //VB March 2009
end;

{------------------------------------------------------------------------------}
function TLMDApplication.GetUnicodeTitle: TLMDString;
{$ifdef LMD_UNICODE}
var
  LLen: Integer;
{$endif}
begin
  {$ifdef LMD_UNICODE}
  if (Application.Handle <> 0) and LMDIsUnicodePlatform then
    begin
      LLen := GetWindowTextLengthW(Application.Handle);
      SetLength(Result, LLen);
      if LLen > 0 then
        GetWindowTextW(Application.Handle, @Result[1], LLen + 1);
    end
  else
  {$else}
  Result := Application.Title;
  {$endif}
  end;

{------------------------------------------------------------------------------}
procedure TLMDApplication.SetUnicodeTitle(const Value: TLMDString);
begin
  {$ifdef LMD_UNICODE}
  if (Application.Handle <> 0) and LMDIsUnicodePlatform then
    SetWindowTextW(Application.Handle, PWideChar(Value))
  else
  {$else}
  Application.Title := Value;
  {$endif}
  end;

{------------------------------------------------------------------------------}
procedure TLMDApplication.DoThemeChange;
var
  Message: TMessage;
  i:Integer;

  procedure NotifyStandardChildren(ct:TWinControl);
  var
    j:Integer;
    tmp:TWinControl;
  begin
    for j:=0 to ct.ControlCount-1 do
      if ct.Controls[j] is TWinControl then
        begin
          tmp:=ct.Controls[j] as TWinControl;
          if tmp.HandleAllocated then
            begin
              tmp.Perform(WM_THEMECHANGED, 0, 0);
            end;
          NotifyStandardChildren(tmp);
        end;
  end;
begin
  // Rafael --> check
  //LMDThemeService.ResetList;
  Message.Msg:=CM_LMDTHEMECHANGED;
  for  i:=0 to Screen.FormCount-1 do
    begin
      Screen.Forms[i].Perform(CM_LMDTHEMECHANGED, 0, 0);
      if Screen.Forms[i].Visible then
        with Screen.Forms[i] do
           begin
             BroadCast(Message);
             NotifyStandardChildren(Screen.Forms[i]);
             If not FLMDOnly then
               Perform(WM_THEMECHANGED, 0, 0);
           end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDApplication.GetUseXPThemes:Boolean;
begin
  result := FUseXPThemes;
  if result then
    result := ThemeServices.ThemesAvailable;
  if result then
    //result := uxTheme.IsThemeActive;  //VB Sep 2009:
    result := uxTheme.UseThemes;        //BTS #736  application theme setting was ignored
end;

{------------------------------------------------------------------------------}
procedure TLMDApplication.SetXPThemeSupport(aValue: Boolean);
begin
  if aValue <> FUseXPThemes then
    begin
      //if XP look shall be supported check for availability and only enable if available
      if aValue and not GetXPThemesSupported then exit;
      //finally set variable to new value
      FUseXPThemes := aValue;
      if (csDesigning in ComponentState) or (not ThemeServices.ThemesAvailable) then exit;
      SendAppMessage(WM_THEMECHANGED, 0, 0);
      if FUseXPThemes then
        SetThemeAppProperties(STAP_ALLOW_NONCLIENT or STAP_ALLOW_CONTROLS)
      else
        if not FLMDOnly then SetThemeAppProperties(0);
      DoThemeChange;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDApplication.SetXPLMDOnly;
begin
  if aValue<>FLMDOnly then
    begin
      FLMDOnly:=aValue;
      if FLMDOnly and not (FGlobalThemeMode = ttmPlatform) then
        begin
          SetThemeAppProperties(STAP_ALLOW_NONCLIENT or STAP_ALLOW_CONTROLS);
          DoThemeChange;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDApplication.SetLogPrefix(aValue:TLMDPathPrefix);
begin
  if FLogPrefix<>aValue then
    begin
      FLogPrefix:=aValue;
      SetLogName(FLogName);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDApplication.SetThemeUseColorProperty(const Value: boolean);
begin
  FThemeUseColorProperty := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDApplication.SetLogName(const aValue:String);
var
  tmp:String;
begin
  tmp:=aValue;
  if LMDAnsiEmpty(tmp) then
    tmp:=ChangeFileExt(ParamStr(0),'.LOG')
  else
    if LMDAnsiEmpty(ExtractFileExt(tmp)) then tmp:=tmp+'.LOG';
  if FLogPrefix<>ppFixed then
    FLogName:=LMDCreatePathPrefix(FLogPrefix, True)+ExtractFileName(tmp)
  else
    FLogName:=tmp;
end;

{------------------------------------------------------------------------------}
procedure TLMDApplication.SetEditMode (aValue:TLMDEditModes);
begin
  if aValue <> FEditMode then
    begin
      FEditMode := aValue;
      if Assigned (FOnEditModeChange) then FOnEditModeChange (self);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDApplication.SetGlobalThemeMode(const Value: TLMDThemeMode);
begin
  if FGlobalThemeMode <> Value then
    begin
      FGlobalThemeMode := Value;
      DoThemeChange;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDApplication.GetCheckCustomWidth:Integer;
begin
  result:=0;
  if Assigned(FCheckBitmap) then
    result:=FCheckBitmap.Width DIV 6;
end;

{------------------------------------------------------------------------------}
function TLMDApplication.GetCheckCustomHeight:Integer;
begin
  result:=0;
  if Assigned(FCheckBitmap) then
    result:=FCheckBitmap.Height;
end;

{------------------------------------------------------------------------------}
procedure TLMDApplication.SetCheckBitmap(aValue:TBitmap);
begin
  if not Assigned(FCheckBitmap) then
    FCheckBitmap:=TBitmap.Create;
  FCheckBitmap.Assign(aValue);
end;

{------------------------------------------------------------------------------}
function TLMDApplication.GetBitmap:TBitmap;
begin
  if FMonoPattern=nil then
    begin
      FMonoPattern:=TBitmap.Create;
      FMonoPattern.Assign(GetBrushBitmap(clBlack));
    end;
  result:=FMonoPattern;
end;

{------------------------------------------------------------------------------}
function TLMDApplication.GetThemeModeSupported(index: TLMDThemeMode): Boolean;
begin
  // ToDo !! When LMDClass was moved to lmdrtlx then:
  //result := LMDThemeServices.ThemesEnabled(index);
  case index of
    ttmNone : result := true;
    ttmPlatform : result := ThemeServices.ThemesAvailable;
  else
    result := false;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDApplication.GetTimer(Ident:Word):TLMDTimerItem;
begin
  result:=FTimerPool.GetTimer(Ident);
end;

{------------------------------------------------------------------------------}
function TLMDApplication.GetTimerIdent:Word;
var
  i:Word;
begin
  result:=0;
  for i:=1 to High(Timerfield) do
    if not TimerField[i] then
      begin
        result:=i;
        break;
      end;
end;

{------------------------------------------------------------------------------}
function TLMDApplication.GetTimerFrequency:Extended;
begin
  result:=FTimerFrequency;
end;

{------------------------------------------------------------------------------}
procedure TLMDApplication.HandleException(Sender:TObject; E:Exception);
var
  tmp:Boolean;
begin
   tmp:=false;
   if Assigned(FOnException) then FOnException(Sender, E, tmp);
   if not tmp then
     begin
       if aoLogException in FOptions then LogException(Sender);
       {eigene Routinen, noch besser machen -> eigene Messagebox}
       Application.ShowException(E);
     end;
end;

{------------------------- Public ---------------------------------------------}
type
  PLMDMemMapArr = ^TLMDMemMapArr;
  TLMDMemMapArr = record
    hPrevInst,
    hPrevAppWin,
    hPrevMainWin,
    hMonWin       : THandle;
  end;

{------------------------------------------------------------------------------}
procedure TLMDApplication.FindPreviousInstance;
var
  LUniqueName: String;
  LPrevInstInfo: PLMDMemMapArr;
  begin
  {previous instance feature}
  LUniqueName := ExtractFileName(UpperCase(ParamStr(0))); // UpperCase: 6.1
  //8.07
  FMHandle := CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, SizeOf(TLMDMemMapArr), int_Ref(LUniqueName));
  //      FMHandle:=CreateMutex(nil, false, int_Ref(buffer));
  if FMHandle <> 0 then
    begin
      LPrevInstInfo := MapViewOfFile(FMHandle, FILE_MAP_ALL_ACCESS, 0, 0, SizeOf(TLMDMemMapArr));
      try
        if LPrevInstInfo <> nil then
          begin
        if GetLastError = ERROR_ALREADY_EXISTS then
              begin
                FIsPrevRunning := True;
                FPreviouseAppWin := LPrevInstInfo.hPrevAppWin;
              end
            else
              begin
                LPrevInstInfo.hPrevInst := HInstance;
                LPrevInstInfo.hPrevAppWin := Application.Handle;
                if Application.MainForm <> nil then
                  LPrevInstInfo.hPrevMainWin := Application.MainForm.Handle;
              end;
          end;
      finally
        if LPrevInstInfo <> nil then
          UnmapViewOfFile(LPrevInstInfo);
        end;
    end;
end;

{------------------------------------------------------------------------------}
constructor TLMDApplication.Create(aOwner:TComponent);
begin
  inherited Create(nil);

  ForceANSI := false;
  FOptions:=[aoMouseCtrlActive, aoLogAlwaysClear, aoLogHeader, aoLogNr];

  FThemeUseColorProperty := true;
  {LogFile Feature}
  FUpdate:=0;
  FCounter:=0;
  FLogPrefix:=ppProgram;
  FLogMaxSize:=-1;
  FStartTime:=0;
  SetLogName('');

  // check whether XP Support is possible either
  FUseXPThemes:=True;
  FGlobalThemeMode := ttmPlatform;

  FEffectDelay:=3;
  FLastColor:=clNone;
  FMsgBoxStyle := nil;
  FMask := '#tdl';

  FIsPrevRunning:=False;
  if not (csDesigning in ComponentState) and not IsLibrary then
    FindPreviousInstance;

  FTimerPool:=TLMDTimerPool.CreateRunTime(nil, LMD_DEFINTERVAL);

  FEditMode := [emInsert];

  FIniCtrl:=TLMDIniCtrl.Create(nil);

  QueryPerformanceFrequency(FTimerFrequency);

  // LMD-Tools 6.0 Enhancements
  with Graphics.TBitmap.Create do
  try
    Handle := LoadBitmap(0, PChar(32759));
    FCheckWidth := Width div 4;
    FCheckHeight := Height div 3;
  finally
    Free;
  end;
end;

{------------------------------------------------------------------------------}
destructor TLMDApplication.Destroy;
begin
  FIniCtrl.Free;
  FreeAndNil(FMonoPattern);
  FreeAndNil(FPatternBitmap);
  FreeAndNil(FTimerPool);
  FreeAndNil(FCheckBitmap);
  if not IsLibrary then
    CloseHandle(FMHandle);
  inherited Destroy;
end;

{Timerpool}
{------------------------------------------------------------------------------}
function TLMDApplication.AddTimer(wInterval:Word; CallProc:TNotifyEvent):Word;
begin
  result:=GetTimerIdent;
  if FTimerPool.AddTimer(result+LMDTimerStart, wInterval, CallProc)<>-1 then
    begin
      TimerField[result]:=True;
      Inc(result, LMDTimerStart);
    end
  else
    result:=0;
end;

{------------------------------------------------------------------------------}
function TLMDApplication.AddTimerExt(wInterval:Word; iCallCount:Integer;
                                     bEnabled:Boolean; CallProc:TNotifyEvent):Word;
begin
  result:=GetTimerIdent;
  if FTimerPool.AddTimerExt(result+LMDTimerStart, wInterval, iCallCount,
                            bEnabled, CallProc)<>-1 then
    begin
      TimerField[result]:=True;
      Inc(result, LMDTimerStart);
    end
  else
    result:=0;
end;

{------------------------------------------------------------------------------}
procedure TLMDApplication.RemoveTimer(Ident:Word);
begin
  if Ident>LMDTimerStart then
    begin
      FTimerPool.RemoveTimer(Ident);
      {TP Debug, vorläufig rausnehmen und TLMDTimerPool.RemoveTimer debuggen...}
      TimerField[Ident-LMDTimerStart]:=False;
    end;
end;

{Diverse}
{------------------------------------------------------------------------------}
function TLMDApplication.QuitWindows(aValue:TLMDExitCode):Boolean;
var
  tmp, buffer:DWord;
  tkp, tpko:TTokenPrivileges;
  hToken:THandle;

begin
  if aValue=ecRestart then
    result:=Windows.ExitWindows(0, 0)
  else
    begin
      tmp:=0;
      if LMDSIWindowsNT then
        begin
           result:=false;
           if not OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,
                                   hToken) then exit;
           LookupPrivilegeValue(nil, 'SeShutdownPrivilege', tkp.Privileges[0].Luid);
           tkp.PrivilegeCount:=1;
           tkp.Privileges[0].Attributes:=SE_PRIVILEGE_ENABLED;
           if not AdjustTokenPrivileges(hToken, FALSE, tkp, sizeof(tkp), tpko, buffer) then exit;
           end;
      case aValue of
        ecReBoot:tmp:=EWX_LOGOFF+EWX_FORCE+EWX_REBOOT;
        ecQuit:tmp:=EWX_LOGOFF+EWX_SHUTDOWN+EWX_FORCE{+EWX_POWEROFF};
      end;
      result:=ExitWindowsEx(tmp, 0);
    end;
    if result then Application.Terminate;
end;

{------------------------------------------------------------------------------}
function TLMDApplication.GetBrushBitmap(aColor:TColor):TBitmap;
var
  x,y:Integer;

begin
  if FLastColor<>aColor then
    begin
      if FPatternBitmap=nil then
        begin
          FPatternBitmap:=TBitmap.Create;
          with FPatternBitmap do
            begin
              Width:=8;
              Height:=8;
              Canvas.Brush.Color := clWhite;
              Canvas.FillRect(Types.Rect(0, 0, 8, 8));
            end;
        end;
      with FPatternBitmap.Canvas do
        begin
          for x:=0 to 7 do
            for y:=0 to 7 do
             if (x mod 2=0) xor (y mod 2=0) then
                Pixels[x,y]:=aColor;
        end;
      FLastColor:=aColor;
    end;
  result:=FPatternBitmap;
end;

{simple StopWatch functions}
{------------------------------------------------------------------------------}
procedure TLMDApplication.STWStart;
begin
  QueryPerformanceCounter(FStartTime);
end;

{------------------------------------------------------------------------------}
function TLMDApplication.STWStop:LongInt;
begin
  result:=Trunc(STWStopExt*1000); // milliseconds
end;

{------------------------------------------------------------------------------}
function TLMDApplication.STWStopExt:Extended;
var
  tmpe:Int64;
begin
  result:=0;
  if FTimerFrequency=0 then exit;

  QueryPerformanceCounter(tmpe);
  result:=(tmpe-FStartTime)/FTimerFrequency;
end;

{logs last Exception}
{------------------------------------------------------------------------------}
procedure TLMDApplication.LogException(Sender:TObject);
var
  tmp:String;
begin
  if ExceptObject<>nil then
    with Exception(ExceptObject) do
     begin
       tmp:=Format('%s, Address: %p', [Message, ExceptAddr]);
       if sender<>nil then
         begin
           if (sender is TComponent) and (TComponent(Sender).Name<>'') then
             tmp:=sender.ClassName+' (Name: '+TComponent(Sender).Name+'): '+tmp
           else
             tmp:=sender.ClassName+': '+tmp;
         end;
       LogWrite(tmp);
     end;
end;

{------------------------------------------------------------------------------}
procedure TLMDApplication.LogWrite(const aValue:String);
var
  T:Text;
  mask,
  tmp:String;
  Cancel, cl:Boolean;

  procedure WriteHeader;
  {$ifdef LMDCOMP14}
  var
    LHeader: TStringList;
  {$endif}
  begin
    Writeln(T);
    WriteLn(T, 'LogFile started: '+DateToStr(Now)+' '+TimeToStr(Now));
    WriteLn(T, 'Application    : '+Application.Title);
    Writeln(T, 'Path/ExeName   : '+Application.ExeName);
    if not LMDAnsiEmpty(Version) then
      WriteLn(T, 'Version        : '+Version);

    {$ifdef LMDCOMP14}
    LHeader := TStringList.Create;
    try
      if Assigned (FOnHeaderWrite) then
      begin
        FOnHeaderWrite (self, LHeader);
        Writeln(T, LHeader.Text);
      end;
    finally
      LHeader.Free;
    end;
    {$else}
      if Assigned (FOnHeaderWrite) then
        FOnHeaderWrite (self, T);
    {$endif}

    WriteLn(T, LMDAnsiFillString(80, '*'));
    Writeln(T);
    WriteLn(T, 'Entries:');
  end;

  function FindFileName:string;
  var
    i:Integer;
  begin
    result:='';i:=0;
    while result='' do
      if not FileExists(ChangeFileExt(FLogName, '.l'+inttostr(i))) then
        result:=ChangeFileExt(FLogName, '.l'+inttostr(i))
      else
        Inc(i);
  end;

begin
  {$I-}
  cl:=false;

  {preparation}
  if FLogMaxSize>100 then
    if LMDShUtils.LMDGetFileSize(FlogName)>FLogMaxSize then
      begin
        Cancel:=False;
        if Assigned(FOnMaxLogSize) then
          FOnMaxLogSize(self, FLogName, Cancel);
        if Cancel then exit;
        case FLogAction of
          laClearLog:cl:=True;
          laBackupLog:
            begin
              RenameFile(FLogName, FindFileName);
              cl:=True;
              Application.ProcessMessages;
            end;
         end;

      end;

  AssignFile(T, FLogName);
  if not FileExists(FLogName) or ((aoLogAlwaysClear in FOptions) and (FUpdate=0)) or cl then
    ReWrite(T)
  else
    Append(T);

  if IOResult <> 0 then // cannot open file for writing
    begin
      {$I+}
      Exit;
    end;

  try
    {Autoheader}
    if cl or (FUpdate=0) and (aoLogHeader in FOptions) then WriteHeader;

    {special operations}
    if (aValue='#Header') or (aValue='#Line') or (aValue='#CR') then
      begin
        if aValue='#CR' then WriteLn(T);
        if aValue='#Header' then WriteHeader;
        if aValue='#Line' then WriteLn(T, LMDAnsiFillString(80, '*'));
      end
    else
      begin
        tmp := '';
        mask := FMask;
        Inc(FCounter);
        while mask <> '' do
          begin
            case mask[1] of
              '#' : if aoLogNr in FOptions then tmp:=tmp+Format('%.5d', [FCounter])+': ';
              'l' : tmp:=tmp+aValue;
              't' : if aoLogTime in FOptions then tmp:=tmp+' ['+TimeToStr(Now)+']';
              'd' : if aoLogDate in FOptions then tmp:=tmp+' ['+DateToStr(Now)+']';
//              'u' : if Assigned (FOnUserLogString) then FOnUserLogString (self, tmp);
            end;
            Delete (mask, 1, 1);
          end;
        Writeln(T, tmp);
      end;
  finally
    CloseFile(T);
  end;
  if FUpdate=0 then Inc(FUpdate);
  {$I+}
end;

{only useful in Win32 environments}
{------------------------------------------------------------------------------}
function TLMDApplication.GetDefaultRegPath:String;
begin
  {we create a default path using some LMDApplication properties ...}
  result:='Software\';
  if not LMDAnsiEmpty(Company) then result:=result+LMDAnsiSlashAdd(Company);
  if not LMDAnsiEmpty(Application.Title) then
    result:=result+LMDAnsiSlashAdd(Application.Title)
  else
    result:=result+LMDAnsiSlashAdd({ChangeFileExt(ExtractFileName( }ParamStr(0){) )});
  if not LMDAnsiEmpty(Version) then result:=result+LMDAnsiSlashAdd(Version);
end;

{********************* TLMDTimer **********************************************}
{----------------------- private ----------------------------------------------}
procedure TLMDTimer.RemoveTimer;
begin
  if FGlobalTimer then
    begin
      if FTimerID=0 then exit;
      LMDApplication.Timer[FTimerID].Enabled:=False;
      LMDApplication.Timer[FTimerID].OnTimer:=nil;
      LMDApplication.RemoveTimer(FTimerID);
      FTimerID:=0;
    end
  else
    if Assigned(FTimer) then
      begin
        FTimer.Enabled:=False;
        FreeAndNil(FTimer);
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTimer.SetEnabled(const Value: Boolean);
begin
  if FEnabled<>Value then
    begin
      FEnabled := Value;
      if FGlobalTimer then
        LMDApplication.Timer[FTimerID].Enabled:=FEnabled
      else
        FTimer.Enabled:=FEnabled;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTimer.SetGlobal(const Value: Boolean);
begin
  if FGlobalTimer<>Value then
    begin
      FGlobalTimer := Value;
      UpdateTimer;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTimer.SetInterval(const Value: Word);
begin
  if Value<>FInterval then
    begin
      FInterval := Value;
      if FGlobalTimer then
        begin
          LMDApplication.Timer[FTimerID].Interval:=FInterval
        end
      else
        FTimer.Interval:=FInterval;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTimer.UpdateTimer;
var
  tmp:Word;
begin
  RemoveTimer;
  if FGlobalTimer then
    begin
      // unlike in previous releases: Perform automatic adaption to default interval
      if FInterval MOD LMD_DEFINTERVAL >0 then
        tmp:=(FInterval DIV LMD_DEFINTERVAL +1)*LMD_DEFINTERVAL
      else
        tmp:=FInterval;
      FTimerID:=LMDApplication.AddTimer(tmp, Timer);
      if FTimerId=0 then
        raise EOutOfResources.Create(SNoTimers);
      LMDApplication.Timer[FTimerID].Enabled:=FEnabled;
    end
  else
    begin
      FTimer:=TTimer.Create(nil);
      FTimer.Enabled:=FEnabled;
      FTimer.Interval:=FInterval;
      FTimer.OnTimer:=Timer;
    end;
end;

{----------------------- protected --------------------------------------------}
procedure TLMDTimer.Timer(Sender:TObject);
begin
  if Assigned(FonTimer) then FOnTimer(self);
end;

{----------------------- public -----------------------------------------------}
constructor TLMDTimer.Create(gInterval:Word; gTimer:TNotifyEvent; gEnabled:Boolean=true;gmode:Boolean=false);
begin
  inherited Create;
  FTimerID:=0;
  FGlobalTimer:=gMode;
  FOnTimer:=gTimer;
  FEnabled:=gEnabled;
  FInterval:=gInterval;
  UpdateTimer;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDTimer.Destroy;
begin
  RemoveTimer;
  inherited;
end;

{********************* TLMDTimerItem ******************************************}
{----------------------- private ----------------------------------------------}
procedure TLMDTimerItem.SetCallCount(aValue:Integer);
begin
  if aValue<>FCallCount then
    begin
      if aValue<-1 then aValue:=-1; {unlimited calls}
      FCallCount:=aValue;
      If FCallCount=0 then FEnabled:=False;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTimerItem.SetEnabled(aValue:Boolean);
begin
  if aValue<>FEnabled then
    begin
      if aValue and (FCallCount=0) then exit;
      FEnabled:=aValue;
      FCounter:=0;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTimerItem.SetInterval(aValue:Word);
begin
  if aValue<>FInterval then
    begin
      if (aValue Mod FOwner.MinInterval<>0) then exit;
      if aValue=0 then aValue:=FOwner.MinInterval;
      FInternal:=aValue div FOwner.MinInterval;
      FInterval:=aValue;
      FCounter:=0;
    end;
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDTimerItem.Create(aOwner:TLMDTimerPool; aList:TList; aIndex:Word);
begin
  inherited Create;
  if (aList=nil) or (aOwner=nil) then
    raise EInvalidOperation.Create(Classname + ': Invalid Owner or List');
  FOwner:=aOwner;
  FList:=aList;
  FIdent:=aIndex;

  FCallCount:=-1;
  FCounter:=0;
  FEnabled:=True;
  FInterval:=1000;
  FInternal:=FInterval div FOwner.MinInterval;
  FOnTimer:=nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDTimerItem.Destroy;
begin
  FEnabled:=False;
  FOnTimer:=nil;
  FList.Remove(self);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDTimerItem.Timer;
begin
  if not FEnabled then exit;
  Inc(FCounter);
  if FCounter<0 then FCounter:=0;
  {RM3.5}
  if FCounter=FCallCount then FEnabled:=False;
  {----}
  if Assigned(FOnTimer) then
    FOnTimer(FOwner)
  else
    if FOwner.HasTimerProc then FOwner.OnTimer(FOwner, FIdent, FCounter);
end;

{********************** Object TLMDTimerPool **********************************}
{----------------------- private ----------------------------------------------}
procedure TLMDTimerPool.SetInterval(aValue:TLMDTimerInterval);
begin
  {only allowed at design time or within constructor}
  if (csLoading in ComponentState) or (csDesigning in ComponentState) then
    if aValue<>FInterval then FInterval:=aValue;
end;

{------------------------------------------------------------------------------}
function TLMDTimerPool.GetActiveTimers:Integer;
var
  i:Integer;
begin
  result:=0;
  for i:=0 to FList.Count-1 do
    if TLMDTimerItem(FList[i]).Enabled then inc(result);
end;

{------------------------------------------------------------------------------}
function TLMDTimerPool.GetCount:Integer;
begin
  result:=FList.Count;
end;

{------------------------------------------------------------------------------}
function TLMDTimerPool.GetTimer(Ident:Word):TLMDTimerItem;
var
  tmp:Integer;
begin
  result:=nil;
  if FList.Count=0 then exit;
  tmp:=IndexOf(Ident);
  if tmp<>-1 then result:=TLMDTimerItem(FList[tmp]);
end;

{------------------------------------------------------------------------------}
function TLMDTimerPool.IndexOf(Ident:Word):Integer;
begin
  Result:=0;
  while (Result<FList.Count) and
        ((TLMDTimerItem(FList[Result]).Ident)<>Ident) do Inc(Result);
  if Result=FList.Count then Result:=-1;
end;

{------------------------------------------------------------------------------}
procedure TLMDTimerPool.HandleTimers;
var
  i:Integer;
begin
  if FUpdate>0 then exit;
  i:=0;
  while i<FList.Count do
    begin
      with TLMDTimerItem(FList[i]) do
        if Enabled and ((FPCounter Mod HitValue)=0) then Timer;
      inc(i);
    end;
  Inc(FPCounter);
  if FPCounter<0 then FPCounter:=0;
end;

{------------------------------------------------------------------------------}
procedure TLMDTimerPool.UpdateMainTimer(aValue:Boolean);
begin
  if (csDesigning in ComponentState) then exit;
  if (FHwnd=0) and aValue then
    FHWND := AllocateHWnd(WndProc);

  FActive:=False;

  if FHwnd<>0 then
      KillTimer(FHWND, 1);

  if aValue and (GetActiveTimers>0) then
    if SetTimer(FHwnd,1,FInterval,nil)=0 then
      raise EOutOfResources.Create(SNoTimers)
    else
      begin
        FPCounter:=1;
        FActive:=True;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTimerPool.WndProc(var Msg: TMessage);
begin
  with Msg do
    case Msg of
      WM_TIMER:try
                 if FFlag then exit;
                 FFLag:=True;
                 HandleTimers;
                 FFLag:=False;
               except
                 Application.HandleException(Self);
               end;
    else
      Result := DefWindowProc(FHwnd, Msg, wParam, lParam);
    end;
end;

{----------------------- public -----------------------------------------------}
constructor TLMDTimerPool.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  InitAttributes;
end;

{------------------------------------------------------------------------------}
constructor TLMDTimerPool.CreateRunTime(aOwner:TComponent; MinInterval:TLMDTimerInterval);
begin
  inherited Create(aOwner);
  InitAttributes;
  FInterval := MinInterval;
end;

{------------------------------------------------------------------------------}
destructor TLMDTimerPool.Destroy;
begin
  ClearTimers;
  {3.50.10}
  FList.Free;
  {-- RM}
  DeallocateHWnd(FHwnd);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDTimerPool.AddTimer(Ident:Word; wInterval:Word; CallProc:TNotifyEvent):Integer;
begin
  if (FList.Count>0) and (IndexOf(Ident)<>-1) then
    raise Exception.Create(SListIndexError);
  if (wInterval Mod FInterval<>0) or (wInterval<FInterval) then
    raise Exception.Create(IDS_INTERVALNOTFIT);
  result:=FList.Add(TLMDTimerItem.Create(self, FList, Ident));
  if result<>-1 then
    with TLMDTimerItem(FList[result]) do
      begin
        Interval:=wInterval;
        OnTimer:=CallProc;
      end;
  UpdateMainTimer(True);
end;

{------------------------------------------------------------------------------}
function TLMDTimerPool.AddTimerExt(Ident:Word; wInterval:Word; iCallCount:Integer;
                                   bEnabled:Boolean; CallProc:TNotifyEvent):Integer;
begin
  result:=AddTimer(Ident, wInterval, CallProc);
  if result<>-1 then
    with TLMDTimerItem(FList[result]) do
      begin
        CallCount:=iCallCount;
        Enabled:=bEnabled;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTimerPool.ClearTimers;
begin
  UpdateMainTimer(false);
  While FList.Count>0 do
    TLMDTimerItem(FList.Last).Free;
end;

{------------------------------------------------------------------------------}
function TLMDTimerPool.HasTimerProc:Boolean;
begin
  result:=Assigned(FOnTimerEvent);
end;

{------------------------------------------------------------------------------}
procedure TLMDTimerPool.RemoveTimer(Ident:Word);
var
  nr:Integer;
begin
  FUpdate:=1;
  try
    nr:=IndexOf(Ident);
    if nr < 0 then exit;
    TLMDTimerItem(FList[nr]).Enabled:=False;
    TLMDTimerItem(FList[nr]).OnTimer:=nil;
    TLMDTimerItem(FList[nr]).Free;

    if FList.Count=0 then UpdateMainTimer(false);
  finally
    FUpdate:=0;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTimerPool.InitAttributes;
begin
  FActive := False;
  FInterval := 1000;
  FList := TList.Create;
  FFLag := False;
  FUpdate := 0;
end;

initialization
  {$IFDEF LMD_DEBUGTRACE}
  {$I C1.INC}
  {$ENDIF}
  LMDApplication := TLMDApplication.Create(nil);

finalization
  LMDApplication.Free;
end.
