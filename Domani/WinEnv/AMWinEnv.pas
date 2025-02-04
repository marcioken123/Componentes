{ TAMWinEnv 1.1 (Will only work with Windows 95/98 not with Windows NT 4.x)
  copyright © AM Software 1998-1999 by Alexander Meeder

  The idea for this component came when I decided to make an application that locks
  the PC just like the Control-Alt-Delete option with Windows NT. I found some usefull
  components on several Delphi pages but I thought it would be nice if all those features
  are assembled within one component. This is the result, use it as you like.

  I want to thank the following people for their 'freeware' components with source-code:
  - TStealth 1.1 - copyright © Amigreen Software 1998 by Janus N. Tondering (j@nus.person.dk)
  - TIconHide 1.0 - copyright © 1998 by Vit Kovalcik (vkovalcik@iname.com)
  - TWinAccess x.x - copyright © 1998 by ???

  I also want to thank
  - Alexander Krestinin (krest@lyc.schel.ac.ru) for his suggestion about the
    'DisableOption'-property and the 'KeepAfterClose'-property.

  The following options/properties are available with this component:
  * AMReg, points to my AMReg-component, used when you want to automatically save/load
                   the component-settings (see also: LoadSettings/SaveSettings-methods)
  * AppHideOption, you can hide the application button on the taskbar and the application name
                   within the task-list (the list that appears when you press Ctrl-Alt-Del)
  * AppRegistered, read-only property to get info. if this appl. is registered as 'AutoStartUp'
  * DisableMutliInstance, when true it isn't possible to start multiple instances of this program
                   (see also OnSecondInstance-event)
  * DisableScrnSaver, you can disable the screensaver with this property (only when appl. where this
                   component is used is the active appl. If this appl. loses focus then this option
                   doesn't work anymore)
  * DisableShutdown, when true you can't shutdown Windows and this application
                   (see also OnShutDown-event)
  * DisableSysKey, you can disable the system keys Control-Alt-Del, Alt-Tab, Control-Esc and the
                   special Win95/98 Start-button
  * DisableOption, with this property-set you can disable any combination of the following options:
                   - Taskbar (the bar with al the buttons of active apps)
                   - Taskbar buttons
                   - Start-button
                   - Icons on the desktop
                   (Disabling the clock or the system-tray has no effect) 
  * HideOption, with this property-set you can hide any combination of the following options:
                   - Taskbar (the bar with al the buttons of active apps)
                   - TrayClock (the clock on the system tray)
                   - System tray
                   - Taskbar buttons
                   - Start-button
                   - Icons on the desktop
  * IDName, when you want to use the 'DisableMultiInstance' property and or the
                  'Register/Unregister'-methods you have to specify this property (must be an unique
                  string)
  * RunType, when you use the 'register/unregister'-mehtods choose the run-type

  following methods are available (see also properties: RunType and IDName):
  * Register, register this application to automatically start when Windows starts
  * Unregister, unregister this application
  * LoadSettings, Load the stored settings from the register
  * SaveSettings, Saves the settings to the register

  following events are available
    (see also properties: DisableMultiInstance, DisableScrnSaver, DisableShutDown):
  * OnSecondInstance, fired when DisablMultiInstance = true and user tries to start this appl.
                   for the second time
  * OnStartScrnSaver, fired when DisableScrnSaver = true, appl. is active and system tries to start
                    screensaver
  * OnTryShutDown, fired when DisableShutDown = true and user tries to shutdown appl. or windows

  If you have some questions about, or suggestions for this component
  you can mail me at: ameeder@dds.nl

  Release info:
  1.0 First release
  1.0.1 Second release with some changes made by Alexander Krestinin (krest@lyc.schel.ac.ru)
  1.1 Third release with some major changes made by myself (Load- & Save settings, autorun etc.)
}

unit AMWinEnv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Registry, RegStr, AMReg;

type
  ENoAMRegComponentFound = class(Exception);

  TAppHideOption = (hoTaskbarButton, hoTasklistItem);
  TAppHideOptions = set of TAppHideOption;
  THackOption = (hoTrayBar, hoTrayNotify, hoStartButton, hoAppSwitchBar, hoTrayClock, hoDesktopIcons);
  THackOptions = set of THackOption;
  TDisableOptions = THackOptions;
  THideOptions = THackOptions;
  TRunType = (rtRun, rtRunOnce, rtRunOnceEx, rtRunServices, rtRunServicesOnce);

  TAMWinEnv = class(TComponent)
  private
    FSysClasses : array [0 .. 6] of PChar;

    hMutex: THandle;

    FAMReg: TAMReg;
    FAppHideOption: TAppHideOptions;
    FDisableMultiInstance: boolean;
    FDisableScrnSaver: boolean;
    FDisableShutdown: boolean;
    FDisableSysKey: boolean;
    FHideOption: THideOptions;
    FIDName: string;
    FDisableOption: TDisableOptions;
    FKeepAfterClose: boolean;
    FRunType: TRunType;

    FSecondInstance: TNotifyEvent;
    FStartScrnSaver: TNotifyEvent;
    FTryShutDown: TNotifyEvent;

    procedure SetAppHideOption(Value: TAppHideOptions);
    procedure SetDisableMultiInstance(Value: boolean);
    procedure SetDisableOption(Value: TDisableOptions);
    procedure SetDisableScrnSaver(Value: boolean);
    procedure SetDisableShutDown(Value: boolean);
    procedure SetDisableSysKey(Value: boolean);
    procedure SetHideOption(Value: THideOptions);
    procedure SetIDName(Value: string);
    procedure SetRunType(Value: TRunType);
    function GetRegistered: boolean;

    procedure AppMessage(var msg: TMsg; var Handled: boolean);
  protected
    procedure HideApplication;
    procedure ShowApplication;
    procedure HideOpt(Option: word; Hide: boolean);
    procedure DisableOpt(Option: word; Disable: boolean);
    procedure CloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function RegMe(AutoRun: boolean): boolean;
    procedure Loaded; override;
  public
    procedure LoadSettings;
    procedure SaveSettings;
    function Register: boolean;
    function Unregister: boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property AppRegistered: boolean read GetRegistered;
  published
    property AMReg: TAMReg read FAMReg write FAMReg;
    property AppHideOption: TAppHideOptions read FAppHideOption write SetAppHideOption;
    property DisableMultiInstance: boolean read FDisableMultiInstance write SetDisableMultiInstance default False;
    property DisableOption: TDisableOptions read FDisableOption write SetDisableOption;
    property DisableScrnSaver: boolean read FDisableScrnSaver write SetDisableScrnSaver default False;
    property DisableShutDown: boolean read FDisableShutDown write SetDisableShutDown default False;
    property DisableSysKey: boolean read FDisableSysKey write SetDisableSysKey default False;
    property HideOption: THideOptions read FHideOption write SetHideOption;
    property IDName: string read FIDName write SetIDName;
    property KeepAfterClose: boolean read FKeepAfterClose write FKeepAfterClose default False;
    property RunType: TRunType read FRunType write SetRunType default rtRun;

    property OnSecondInstance: TNotifyEvent read FSecondInstance write FSecondInstance;
    property OnStartScrnSaver: TNotifyEvent read FStartScrnSaver write FStartScrnSaver;
    property OnTryShutDown: TNotifyEvent read FTryShutDown write FTryShutDown;
  end;

function RegisterServiceProcess(dwProcessID, dwType: integer): integer; stdcall; external 'KERNEL32.DLL';

procedure Register;

implementation

const
  // Not available in 'RegStr'-unit
  REGSTR_PATH_RUNONCEEX = 'Software\Microsoft\Windows\CurrentVersion\RunOnceEx';

  iTRAYBAR = 0;
  iTRAYNOTIFY = 1;
  iSTARTBUTTON = 2;
  iAPPSWITCHBAR = 3;
  iTRAYCLOCK = 4;
  iDESKTOPICONS = 5;
  iPROGMAN = 6;

var
  RunKey: string;
  RunTypes : array[TRunType] of string = (REGSTR_PATH_RUN, REGSTR_PATH_RUNONCE, REGSTR_PATH_RUNONCEEX,
                                          REGSTR_PATH_RUNSERVICES, REGSTR_PATH_RUNSERVICESONCE);
  XWndLong: integer;

procedure TAMWinEnv.CloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if FDisableShutDown then
  begin
    CanClose := False;
    if Assigned(FTryShutDown) then FTryShutDown(Self);
  end
  else
  begin
    CanClose := True;
  end;
end;

procedure TAMWinEnv.LoadSettings;
begin
  if assigned(AMReg) then
  begin
    with AMReg do
    begin
      Active := True;
      try
        DisableMultiInstance := RBool('DMultiInstance');
        DisableScrnSaver := RBool('DScreenSaver');
        DisableShutDown := RBool('DShutDown');
        DisableSysKey := RBool('DSysKey');
        // AppHideOption
          if RBool('HTaskBarButton') then AppHideOption := AppHideOption + [hoTaskBarButton];
          if RBool('HTaskListItem') then AppHideOption := AppHideOption + [hoTaskListItem];
        // DisableOption property
          if RBool('DOTrayBar') then DisableOption := DisableOption + [hoTrayBar];
          if RBool('DOTrayNotify') then DisableOption := DisableOption + [hoTrayNotify];
          if RBool('DOStartButton') then DisableOption := DisableOption + [hoStartButton];
          if RBool('DOAppSwitchBar') then DisableOption := DisableOption + [hoAppSwitchBar];
          if RBool('DOTrayClock') then DisableOption := DisableOption + [hoTrayClock];
          if RBool('DODesktopIcons') then DisableOption := DisableOption + [hoDesktopIcons];
        // HideOption property
          if RBool('HOTrayBar') then HideOption := HideOption + [hoTrayBar];
          if RBool('HOTrayNotify') then HideOption := HideOption + [hoTrayNotify];
          if RBool('HOStartButton') then HideOption := HideOption + [hoStartButton];
          if RBool('HOAppSwitchBar') then HideOption := HideOption + [hoAppSwitchBar];
          if RBool('HOTrayClock') then HideOption := HideOption + [hoTrayClock];
          if RBool('HODesktopIcons') then HideOption := HideOption + [hoDesktopIcons];
        KeepAfterClose := RBool('KeepAfterClose');
        RunType := TRunType(RInteger('RunType'));
      finally
        Active := False;
      end;
    end;
  end
  else
    raise ENoAMRegComponentFound.Create('No AMReg component found...');
end;

procedure TAMWinEnv.SaveSettings;
begin
  if assigned(AMReg) then
  begin
    with AMReg do
    begin
      Active := True;
      try
        WBool('DMultiInstance', DisableMultiInstance);
        WBool('DScreenSaver', DisableScrnSaver);
        WBool('DShutDown', DisableShutDown);
        WBool('DSysKey', DisableSysKey);
        // AppHideOption
          WBool('HTaskBarButton', (hoTaskBarButton in AppHideOption));
          WBool('HTaskListItem', (hoTaskListItem in AppHideOption));
        // DisableOption property
          WBool('DOTrayBar', (hoTrayBar in DisableOption));
          WBool('DOTrayNotify', (hoTrayNotify in DisableOption));
          WBool('DOStartButton', (hoStartButton in DisableOption));
          WBool('DOAppSwitchBar', (hoAppSwitchBar in DisableOption));
          WBool('DOTrayClock', (hoTrayClock in DisableOption));
          WBool('DODesktopIcons', (hoDesktopIcons in DisableOption));
        // HideOption property
          WBool('HOTrayBar', (hoTrayBar in HideOption));
          WBool('HOTrayNotify', (hoTrayNotify in HideOption));
          WBool('HOStartButton', (hoStartButton in HideOption));
          WBool('HOAppSwitchBar', (hoAppSwitchBar in HideOption));
          WBool('HOTrayClock', (hoTrayClock in HideOption));
          WBool('HODesktopIcons', (hoDesktopIcons in HideOption));
        WBool('KeepAfterClose', KeepAfterClose);
        WInteger('RunType', Ord(RunType));
      finally
        Active := False;
      end;
    end;
  end
  else
    raise ENoAMRegComponentFound.Create('No AMReg component found...');
end;

procedure TAMWinEnv.HideApplication;
begin
  if not (csDesigning in ComponentState) then
    RegisterServiceProcess(GetCurrentProcessID, 1);
end;

procedure TAMWinEnv.ShowApplication;
begin
  if not (csDesigning in ComponentState) then
    RegisterServiceProcess(GetCurrentProcessID, 0);
end;

procedure TAMWinEnv.HideOpt(Option: word; Hide: Boolean);
var
  Wnd: THandle;
begin
  case Option of
    iTRAYBAR      : Wnd := FindWindow(FSysClasses[iTRAYBAR], nil);
    iTRAYNOTIFY   : begin
                      Wnd := FindWindow(FSysClasses[iTRAYBAR], nil);
                      Wnd := FindWindowEx(Wnd, HWND(0), FSysClasses[iTRAYNOTIFY], nil);
                    end;
    iSTARTBUTTON  : begin
                      Wnd := FindWindow(FSysClasses[iTRAYBAR], nil);
                      Wnd := FindWindowEx(Wnd, HWND(0), FSysClasses[iSTARTBUTTON], nil);
                    end;
    iAPPSWITCHBAR : begin
                      Wnd := FindWindow(FSysClasses[iTRAYBAR], nil);
                      Wnd := FindWindowEx(Wnd, HWND(0), FSysClasses[iAPPSWITCHBAR], nil);                      
                    end;
    iTRAYCLOCK    : begin
                      Wnd := FindWindow(FSysClasses[iTRAYBAR], nil);
                      Wnd := FindWindowEx(Wnd, HWND(0), FSysClasses[iTRAYNOTIFY], nil);
                      Wnd := FindWindowEx(Wnd, HWND(0), FSysClasses[iTRAYCLOCK], nil);
                    end;
    iDESKTOPICONS : begin
                      Wnd := FindWindow(FSysClasses[iPROGMAN], nil);
                      Wnd := FindWindowEx(Wnd, HWND(0), FSysClasses[iDESKTOPICONS], nil);
                    end;
    else
      Wnd := 0;
  end;

  if Wnd <> 0 then
  begin
    if Hide then
      ShowWindow(Wnd, SW_HIDE)
    else
      ShowWindow(Wnd, SW_SHOW);
  end;
end;

procedure TAMWinEnv.DisableOpt(Option: word; Disable: Boolean);
var
  Wnd: THandle;
begin
  case Option of
    iTRAYBAR      : Wnd := FindWindow(FSysClasses[iTRAYBAR], nil);
    iTRAYNOTIFY   : begin
                      Wnd := FindWindow(FSysClasses[iTRAYBAR], nil);
                      Wnd := FindWindowEx(Wnd, HWND(0), FSysClasses[iTRAYNOTIFY], nil);
                    end;
    iSTARTBUTTON  : begin
                      Wnd := FindWindow(FSysClasses[iTRAYBAR], nil);
                      Wnd := FindWindowEx(Wnd, HWND(0), FSysClasses[iSTARTBUTTON], nil);
                    end;
    iAPPSWITCHBAR : begin
                      Wnd := FindWindow(FSysClasses[iTRAYBAR], nil);
                      Wnd := FindWindowEx(Wnd, HWND(0), FSysClasses[iAPPSWITCHBAR], nil);
                    end;
    iTRAYCLOCK    : begin
                      Wnd := FindWindow(FSysClasses[iTRAYBAR], nil);
                      Wnd := FindWindowEx(Wnd, HWND(0), FSysClasses[iTRAYNOTIFY], nil);
                      Wnd := FindWindowEx(Wnd, HWND(0), FSysClasses[iTRAYCLOCK], nil);
                    end;
    iDESKTOPICONS : begin
                      Wnd := FindWindow(FSysClasses[iPROGMAN], nil);
                      Wnd := FindWindowEx(Wnd, HWND(0), FSysClasses[iDESKTOPICONS], nil);
                    end;
    else
      Wnd := 0;
  end;

  if Wnd <> 0 then EnableWindow(Wnd, not Disable);
end;

procedure TAMWinEnv.AppMessage(var msg: TMsg; var Handled: boolean);
begin
  if FDisableScrnSaver then
  begin
    if (msg.message = wm_SysCommand) and (msg.wParam = sc_ScreenSave) then
    begin
      Handled := True;
      if Assigned(FStartScrnSaver) then FStartScrnSaver(Self);
    end;
  end;  
end;

procedure TAMWinEnv.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FAMReg) then
  begin
    FAMReg := nil;
  end;
end;

procedure TAMWinEnv.SetAppHideOption(Value: TAppHideOptions);
begin
  if Value <> FAppHideOption then
  begin
    FAppHideOption := Value;

    if not (csDesigning in ComponentState) then
    begin
      ShowWindow(Application.Handle, SW_HIDE);
      if (hoTaskbarButton in AppHideOption) then
        SetWindowLong(Application.Handle, GWL_EXSTYLE, XWndLong or WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW or WS_EX_TOPMOST)
      else
        SetWindowLong(Application.Handle, GWL_EXSTYLE, XWndLong);

      if (hoTasklistItem in AppHideOption) then
        HideApplication
      else
        ShowApplication;

      ShowWindow(Application.Handle, SW_SHOW);
    end;
  end;
end;

procedure TAMWinEnv.SetRunType(Value: TRunType);
begin
  if Value <> FRunType then
  begin
    FRunType := Value;
    RunKey := RunTypes[Value];
  end;
end;

function TAMwinEnv.RegMe(AutoRun: boolean): boolean;
var
  Reg: TRegistry;
begin
  Result := False;
  if IDName = '' then Exit;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Reg.OpenKey(RunKey, True);
    case AutoRun of
      true  : if not Reg.ValueExists(IDName) then
              try
                Reg.WriteString(IDName, Application.ExeName);
                Result := True;
              except
                Result := False;
              end;
      false : if Reg.ValueExists(IDName) then
              try
                Reg.DeleteValue(IDName);
                Result := True;
              except
                Result := False;
              end;
    end;
  finally
    Reg.Free;
  end;
end;

function TAMWinEnv.Register: boolean;
begin
  Result := RegMe(True);
end;

function TAMWinEnv.Unregister: boolean;
begin
  Result := RegMe(False);
end;

function TAMWinEnv.GetRegistered: boolean;
var
  Reg: TRegistry;
begin
  Result := False;
  if IDName <> '' then
  begin
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      Reg.OpenKey(RunKey, False);
      Result := Reg.ValueExists(IDName);
    finally
      Reg.Free;
    end;
  end;
end;

procedure TAMWinEnv.SetDisableMultiInstance(Value: boolean);
begin
  if FIDName <> '' then
    if Value <> FDisableMultiInstance then
    begin
      FDisableMultiInstance := Value;

      if not (csDesigning in ComponentState) then
      begin
        if FDisableMultiInstance and (IDName <> '') then
        begin
          hMutex := CreateMutex(nil, False, PChar(IDName));
          if WaitForSingleObject(hMutex, 0) = Wait_TimeOut then
          begin
            if DisableShutDown then DisableShutDown := False;
            if Assigned(FSecondInstance) then FSecondInstance(Self);
            Halt;
          end;
        end
        else
          ReleaseMutex(hMutex);
      end;
    end
  else
    FDisableMultiInstance := False;
end;

procedure TAMWinEnv.SetDisableScrnSaver(Value: boolean);
begin
  if Value <> FDisableScrnSaver then
  begin
    FDisableScrnSaver := Value;
    if not (csDesigning in ComponentState) then
    begin
      if FDisableScrnSaver then
        Application.OnMessage := AppMessage
      else
        Application.OnMessage := nil;
    end;
  end;
end;

procedure TAMWinEnv.SetDisableShutDown(Value: boolean);
begin
  if Value <> FDisableShutDown then
  begin
    FDisableShutDown := Value;
    if FDisableShutDown then
      TForm(Owner).OnCloseQuery := CloseQuery
    else
      TForm(Owner).OnCloseQuery := nil;
  end;
end;

procedure TAMWinEnv.SetDisableSysKey(Value: boolean);
var
  Dummy: integer;
begin
  if Value <> FDisableSysKey then
  begin
    FDisableSysKey := Value;
    if FDisableSysKey then
      SystemParametersInfo(SPI_SCREENSAVERRUNNING, 1, @Dummy, 0)
    else
      SystemParametersInfo(SPI_SCREENSAVERRUNNING, 0, @Dummy, 0);
  end
end;

procedure TAMWinEnv.SetHideOption(Value: THideOptions);
begin
  if Value <> FHideOption then
  begin
    FHideOption := Value;

    if not (csDesigning in ComponentState) then
    begin
      if (hoTrayNotify in HideOption) then
        HideOpt(iTRAYNOTIFY, True)
      else
        HideOpt(iTRAYNOTIFY, False);

      if (hoAppSwitchBar in HideOption) then
        HideOpt(iAPPSWITCHBAR, True)
      else
        HideOpt(iAPPSWITCHBAR, False);

      if (hoStartButton in HideOption) then
        HideOpt(iSTARTBUTTON, True)
      else
        HideOpt(iSTARTBUTTON, False);

      if (hoTrayClock in HideOption) then
        HideOpt(iTRAYCLOCK, True)
      else
        HideOpt(iTRAYCLOCK, False);

      if (hoTrayBar in HideOption) then
        HideOpt(iTRAYBAR, True)
      else
        HideOpt(iTRAYBAR, False);

      if (hoDesktopIcons in HideOption) then
        HideOpt(iDESKTOPICONS, True)
      else
        HideOpt(iDESKTOPICONS, False);
    end;
  end;
end;

procedure TAMWinEnv.SetDisableOption(Value: TDisableOptions);
begin
  if Value <> FDisableOption then
  begin
    FDisableOption := Value;

    if not (csDesigning in ComponentState) then
    begin
      if (hoTrayNotify in DisableOption) then
        DisableOpt(iTRAYNOTIFY, True)
      else
        DisableOpt(iTRAYNOTIFY, False);

      if (hoAppSwitchBar in DisableOption) then
        DisableOpt(iAPPSWITCHBAR, True)
      else
        DisableOpt(iAPPSWITCHBAR, False);

      if (hoStartButton in DisableOption) then
        DisableOpt(iSTARTBUTTON, True)
      else
        DisableOpt(iSTARTBUTTON, False);

      if (hoTrayClock in DisableOption) then
        DisableOpt(iTRAYCLOCK, True)
      else
        DisableOpt(iTRAYCLOCK, False);

      if (hoTrayBar in DisableOption) then
        DisableOpt(iTRAYBAR, True)
      else
        DisableOpt(iTRAYBAR, False);

      if (hoDesktopIcons in DisableOption) then
        DisableOpt(iDESKTOPICONS, True)
      else
        DisableOpt(iDESKTOPICONS, False);
    end;
  end;
end;

procedure TAMWinEnv.SetIDName(Value: string);
begin
  if Value <> FIDName then
  begin
    FIDName := Value;
    if FIDName = '' then FDisableMultiInstance := False;
  end;
end;

procedure TAMWinEnv.Loaded;
begin
  inherited Loaded;

  if not (csDesigning in ComponentState) then
  begin
    if DisableMultiInstance and (IDName <> '') then
    begin
      hMutex := CreateMutex(nil, False, PChar(IDName));
      if WaitForSingleObject(hMutex, 0) = Wait_TimeOut then
      begin
        if DisableShutDown then DisableShutDown := False;
        if Assigned(FSecondInstance) then FSecondInstance(Self);
        Halt;
      end;
    end;
    RunKey := RunTypes[RunType];
  end;
end;

constructor TAMWinEnv.Create(AOwner: TComponent);
var
  I: integer;
begin
  for I := 0 to AOwner.ComponentCount - 1 do
    if AOwner.Components[I] is TAMWinEnv then
      raise Exception.Create('Cannot use more than one "TAMWinEnv" component on the same form');

  inherited Create(AOwner);

  hMutex := 0;

  FDisableMultiInstance := False;
  FDisableScrnSaver := False;
  FDisableShutDown := False;
  FDisableSysKey := False;
  FKeepAfterClose := False;
  FRunType := rtRun;

  FSysClasses[iTRAYBAR] := 'Shell_TrayWnd';
  FSysClasses[iTRAYNOTIFY] := 'TrayNotifyWnd';
  FSysClasses[iSTARTBUTTON] := 'Button';
  FSysClasses[iAPPSWITCHBAR] := 'ReBarWindow32';
  FSysClasses[iTRAYCLOCK] := 'TrayClockWClass';
  FSysClasses[iDESKTOPICONS] := 'ShellDll_DefView';
  FSysClasses[iPROGMAN] := 'Progman';
end;

destructor TAMWinEnv.Destroy;
begin
  if not FKeepAfterClose then begin
    DisableSysKey := False;
    DisableOpt(iSTARTBUTTON, False);
    DisableOpt(iTRAYCLOCK, False);
    DisableOpt(iAPPSWITCHBAR, False);
    DisableOpt(iTRAYNOTIFY, False);
    DisableOpt(iTRAYBAR, False);
    DisableOpt(iDESKTOPICONS, False);
    HideOpt(iSTARTBUTTON, False);
    HideOpt(iTRAYCLOCK, False);
    HideOpt(iAPPSWITCHBAR, False);
    HideOpt(iTRAYNOTIFY, False);
    HideOpt(iTRAYBAR, False);
    HideOpt(iDESKTOPICONS, False);
  end;
  if Assigned(Application.OnMessage) then Application.OnMessage := nil;
  if Assigned(Application.OnDeactivate) then Application.OnDeactivate := nil;
  ShowApplication;
  inherited Destroy;
end;

procedure Register;
begin
  RegisterComponents('Domani', [TAMWinEnv]);
end;

initialization
  XWndLong := GetWindowLong(Application.Handle, GWL_EXSTYLE);
end.