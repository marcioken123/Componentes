unit LMDApplicationCtrl;
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

LMDApplicationCtrl unit (RM)
----------------------------

Allows programmer to set LMDApplication properties at designtime

Changes
-------
Release 8.01 (October 2007)
- LMDApplication.LogMaxsize: Bug with unclosed file handles fixed

Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Forms, Classes, Graphics, SysUtils, ActnList,
  LMDProcs, LMDClass, LMDIniCtrl, LMDCustomComponent;

type
  {this component controls almost all properties of the LMDApplication
   variable}

  TLMDSystemOption = (soSetHintFont, soSetIconFont, soSetMenuFont);
  TLMDSystemOptions=set of TLMDSystemOption;

  {------------------------ class TLMDApplicationCtrl -------------------------}
  TLMDApplicationCtrl = class(TLMDCustomComponent)
  private
    FCompany,
    FVersion:String;

    FCheckBitmap:TBitmap;

    FOptions:TLMDApplicationOptions;

    {LogFileFeature}
    FLogName:String;
    FLogPrefix:TLMDPathPrefix;
    FLogMaxSize:LongInt;
    FLogAction:TLMDLogAction;
    FMaxLogSize:TLMDMaxLogSizeEvent;
    FOnHeaderWrite : TLMDOnHeaderWrite;
    FEffectDelay:Byte;

    {global inifile}
    FIniFile,
    FRegPath:String;
    FIniPrefix:TLMDPathPrefix;
    FRootKey:TLMDRegRootKey;
    FHTarget:TLMDIniTarget;

    FOnException:TLMDExceptionEvent;

    FTitle:String;
    FHelpFile:TFileName;
    FHintColor:TColor;
    FHintPause:Integer;
    FHintHidePause:Integer;
    FHintShortPause:Integer;

    FShowHint,
    FUpdateMetricSettings,
    FUpdateFormatSettings:Boolean;

    FPicture:TPicture;
    FOnActionExecute,
    FOnActionUpdate:TActionEvent;
    FHintFont,
    FIconFont,
    FMenuFont:TFont;
    FSystemOptions:TLMDSystemOptions;

    {old TLMDApp}
    FOnActiveFormChange,
    FOnActiveControlChange,
    FOnHint,
    FOnActivate,
    FOnDeactivate,
    FOnRestore,
    FOnEditModeChange,
    FOnMinimize:TNotifyEvent;
    FOnShowHint:TShowHintEvent;
    FOnMessage:TMessageEvent;
    FOnHelp:THelpEvent;
    FOnIdle:TIdleEvent;
    procedure SetCheckBitmap(aValue:TBitmap);
    procedure SetIcon(aValue:TIcon);
    procedure SetFont(index:Integer;aValue:TFont);
    function  GetIcon:TIcon;
    procedure SetLogName(const aValue:String);
  protected
    procedure Loaded;override;
    procedure DoEditModeChange (Sender : TObject);
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  published
    property About;
    // 6.1
    property CheckBitmap:TBitmap read FCheckBitmap write SetCheckBitmap;
    property Company:String read FCompany write FCompany;
    property Options:TLMDApplicationOptions read FOptions write FOptions default [aoMouseCtrlActive, aoLogAlwaysClear, aoLogHeader, aoLogNr];
    property Version:String read FVersion write FVersion;
    {LogFileFeature, 3.01}
    property LogMaxAction:TLMDLogAction read FLogAction write FLogAction default laNone;
    property LogMaxsize:LongInt read FLogMaxSize write FLogMaxSize default -1;
    property LogPrefix:TLMDPathPrefix read FLogPrefix write FLogPrefix default ppProgram;
    property LogName:String read FLogName write SetLogName;
    {3.01}
    property DlgEffectDelay:Byte read FEffectDelay write FEffectDelay default 3;
    {global ini-Support}
    property IniFile:String read FIniFile write FIniFile;
    property IniPrefix:TLMDPathPrefix read FIniPrefix write FIniPrefix default ppWindows;
    property RegPath:String read FRegPath write FRegPath;
    property RegRoot:TLMDRegRootKey read FRootKey write FRootKey default rpCurrentUser;
    property IniTarget:TLMDIniTarget read FHTarget write FHTarget default itAuto;
    {Events}
    property OnException:TLMDExceptionEvent read FOnException write FOnException;
    property OnMaxLogSize:TLMDMaxLogSizeEvent read FMaxLogSize write FMaxLogSize;
    {old TLMDApp}
    {**************************************************************************}
    property HintColor:TColor read FHintColor write FHintColor default clInfoBk;
    property HintPause:Integer read FHintPause write FHintPause default 500;
    property HintHidePause:Integer read FHintHidePause write FHintHidePause default 2500;
    property HintShortPause:Integer read FHintShortPause write FHintShortPause default 50;
    property Icon:TIcon read GetIcon write SetIcon;
    Property HelpFile:TFilename read FHelpFile write FHelpFile;
    property ShowHint:Boolean read FShowHint write FShowHint default true;
    property Title:String read FTitle write FTitle;
    property UpdateMetricSettings: Boolean read FUpdateMetricSettings write FUpdateMetricSettings default true;
    property UpdateFormatSettings:Boolean read FUpdateFormatSettings write FUpdateFormatSettings default true;
    property HintFont:TFont index 0 read FHintFont write SetFont;
    property IconFont:TFont index 1 read FIconFont write SetFont;
    property MenuFont:TFont index 2 read FMenuFont write SetFont;
    property SystemOptions:TLMDSystemOptions read FSystemOptions write FSystemOptions default [];

    property OnActivate:TNotifyEvent read FOnActivate write FOnActivate;
    property OnDeactivate:TNotifyEvent read FOnDeactivate write FOnDeactivate;
    property OnHelp:THelpEvent read FOnHelp write FOnHelp;
    property OnIdle:TIdleEvent read FOnIdle write FOnIdle;
    property OnMessage:TMessageEvent read FOnMessage write FOnMessage;
    property OnMinimize: TNotifyEvent read FOnMinimize write FOnMinimize;
    property OnHint: TNotifyEvent read FOnHint write FOnHint;
    property OnRestore: TNotifyEvent read FOnRestore write FOnRestore;
    property OnShowHint:TShowHintEvent read FOnShowHint write FOnShowHint;
    property OnEditModeChange : TNotifyEvent read FOnEditModeChange write FOnEditModeChange;
    property OnHeaderWrite : TLMDOnHeaderWrite read FOnHeaderWrite write FOnHeaderWrite;
    property OnActiveFormChange:TNotifyEvent read FOnActiveFormChange write FOnActiveFormChange;
    property OnActiveControlChange:TNotifyEvent read FOnActiveControlChange write FOnActiveControlChange;

    property OnActionExecute: TActionEvent read FOnActionExecute write FOnActionExecute;
    property OnActionUpdate: TActionEvent read FOnActionUpdate write FOnActionUpdate;
  end;

implementation

uses
  LMDStrings;

{****************** Class TLMDApplicationCtrl *********************************}
{----------------------------  Private ----------------------------------------}
procedure TLMDApplicationCtrl.SetLogName(const aValue:String);
begin
  if aValue<>FlogName then
    begin
      FLogName:=aValue;
      if not LMDAnsiEmpty(FLogName) and LMDAnsiEmpty(ExtractFileExt(FLogName)) then
        FLogName:=FLogName+'.LOG';
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDApplicationCtrl.SetIcon(aValue:TIcon);
begin
  FPicture.Icon.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDApplicationCtrl.SetFont(index:Integer;aValue:TFont);
begin
  case Index of
    0: FHintFont.Assign(aValue);
    1: FIconFont.Assign(aValue);
    2: FMenuFont.Assign(aValue);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDApplicationCtrl.SetCheckBitmap(aValue:TBitmap);
begin
  FCheckBitmap.Assign(aValue);
end;

{------------------------------------------------------------------------------}
function  TLMDApplicationCtrl.GetIcon:TIcon;
begin
  result:=FPicture.Icon;
end;

{---------------------------- Protected ---------------------------------------}
Procedure TLMDApplicationCtrl.Loaded;
begin
  inherited Loaded;

  if not (csDesigning in ComponentState) then
    begin
      with LMDApplication do
        begin
          CheckBitmap:=FCheckBitmap;
          Options:=FOptions;
          Company:=FCompany;
          Version:=FVersion;
          DlgEffectDelay:=FEffectDelay;
          LogPrefix:=FLogPrefix;
          LogName:=FLogName;
          LogMaxSize:=FLogMaxSize;
          LogMaxAction:=FLogAction;
          Ini.IniFile:=FIniFile;
          Ini.RegPath:=FRegPath;
          Ini.IniPrefix:=FIniPrefix;
          Ini.RegRoot:=FRootKey;
          Ini.Target:=FHTarget;

          {TLMDApplicationCtrl}
          if (aoLogException in Options) or Assigned(FOnException) then
            Application.OnException:=HandleException;
          if Assigned(FOnException) then OnException:=FOnException;
          if Assigned(FMaxLogSize) then OnMaxLogSize:=FMaxLogSize;
          if Assigned(FOnHeaderWrite) then OnHeaderWrite:=FOnHeaderWrite;
        end;

      with Application do
        begin
          {old TLMDApp}
          if FileExists(FHelpFile) then
            HelpFile:=FHelpFile
          else
            Helpfile:=ExtractFileName(HelpFile);

          if not FPicture.Icon.Empty then Icon.Assign(FPicture.Icon);

          {Release object}
          FPicture.Destroy;
          FPicture:=nil;

          ShowHint:=FShowHint;
          if FTitle<>'' then Title:=FTitle;
          HintPause:=FHintPause;
          HintColor:=FHintColor;
          HintShortPause:=FHintShortPause;
          HintHidePause:=FHintHidePause;
          UpdateFormatSettings:=FUpdateFormatSettings;
          UpdateMetricSettings:=FUpdateMetricSettings;
          if Assigned(FOnHint) then OnHint:=FOnHint;
          if Assigned(FOnShowHint) then OnShowHint:=FOnShowHint;
          if Assigned(FOnActivate) then OnActivate:=FOnActivate;
          if Assigned(FOnDeactivate) then OnDeActivate:=FOnDeactivate;
          if Assigned(FOnMessage) then OnMessage:=FOnMessage;
          if Assigned(FOnHelp) then OnHelp:=FOnHelp;
          if Assigned(FOnIdle) then OnIdle:=FOnIdle;
          if Assigned(FOnRestore) then OnRestore:=FOnRestore;
          if Assigned(FOnMinimize) then OnMinimize:=FOnMinimize;
          if Assigned(FOnActionUpdate) then OnActionUpdate:=FOnActionUpdate;
          if Assigned(FOnActionExecute) then OnActionUpdate:=FOnActionExecute;
        end;

      if Assigned(FOnActiveFormChange) then  Screen.OnActiveFormChange:=FOnActiveFormChange;
      if Assigned(FOnActiveControlChange) then  Screen.OnActiveControlChange:=FOnActiveControlChange;

      if soSetIconFont in FSystemOptions then Screen.IconFont.Assign(FIconFont);
      if soSetHintFont in FSystemOptions then Screen.HintFont.Assign(FHintFont);
      if soSetMenuFont in FSystemOptions then Screen.MenuFont.Assign(FMenuFont);
     end;
end;

{------------------------------------------------------------------------------}
procedure TLMDApplicationCtrl.DoEditModeChange (Sender : TObject);
begin
  if Assigned (FOnEditModeChange) then FOnEditModeChange(self);
end;

{---------------------------- Public ------------------------------------------}
constructor TLMDApplicationCtrl.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);

  FOptions:=[aoMouseCtrlActive, aoLogAlwaysClear, aoLogHeader, aoLogNr];
  FLogPrefix:=ppProgram;
  FLogMaxSize:=-1;
  FLogAction:=laNone;
  FEffectDelay:=3;

  {global inifile}
  FIniPrefix:=ppWindows;
  FRootKey:=rpCurrentUser;
  FHTarget:=itAuto;

  {old TLMDApp}
  FCheckBitmap:=TBitmap.Create;
  FPicture:=TPicture.Create;
  FIconFont:=TFont.Create;
  FHintFont:=TFont.Create;
  FMenuFont:=TFont.Create;

  with Application do
    begin
      FShowHint:=ShowHint;
      FTitle:='';
      FHintPause:=HintPause;
      FHintColor:=HintColor;
      FHintShortPause:=HintShortPause;
      FHintHidePause:=HintHidePause;
      FUpdateFormatSettings:=UpdateFormatSettings;
      FUpdateMetricSettings:=UpdateMetricSettings;
      FIconFont.Assign(IconFont);
      FMenuFont.Assign(MenuFont);
      FHintFont.Assign(IconFont);
    end;

  if csDesigning in ComponentState then
    if LMDCheckForSameClass(aOwner, self.ClassType, True) then
      raise ELMDOneInstError.Create(self.ClassName,0);

  LMDApplication.OnEditModeChange := DoEditModeChange;
end;

{------------------------------------------------------------------------------}
destructor TLMDApplicationCtrl.Destroy;
begin
  FreeAndNil(FPicture);
  FreeAndNil(FIconFont);
  FreeAndNil(FHintFont);
  FreeAndNil(FMenuFont);
  FreeAndNil(FCheckBitmap);
  inherited Destroy;
end;

end.
