unit LMDTrayIcon;
{$I lmdcmps.INC}

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

LMDTrayIcon unit (RM)
---------------------
TLMDTrayIcon control.

ToDo
----
--> TrayAreaRect
--> OnBallonClick event, TimeOut manually
--> HintAlerter Windows

Changes
-------
Release 8.10 (June 2008)
+ IsMinimized function
* Changes for Delphi/CRS 2007, MainFormOnTaskBar support
Release 8.06 (March 2008)
+    property BalloonHint: string;
+    property BalloonTitle: string;
+    property BalloonTimeout: Integer;   // values: 10000 -> ~ 300000
+    property BalloonFlags: TLMDBalloonFlags;
+    property Options: TLMDTrayIconOptions;
     TLMDTrayIconOptions = set of (tioAniRestoreIcon, tioAniLoop, tioDisableCloseButton,
                                   tioShowMinimizedIcon, tioRestoreOnDblClick);
+    property OnAnimate: TNotifyEvent;
+    function CanShowBallonHint:Boolean;
+    function CurrentImageIndex:Integer;
+    procedure HideBallonHint;
+    procedure HideApplication;
+    procedure ShowApplication;
+    function ShowBalloonHint:Boolean; overload;
+    function ShowBalloonHint(const aTitle, aHint: String; aFlags: TLMDBalloonFlags = bfNone; aTimeOut: Integer = 10000):Boolean; overload;
+    procedure Refresh;
+    procedure SetDefaultIcon;

Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics, Menus, Classes, Messages, Controls, ImgList, ShellApi, ExtCtrls,
  LMDBaseController, LMDCustomImageList, LMDCont, LMDClass, LMDTimer,
  LMDWndProcComponent, LMDShUtils;

type
  TLMDTrayIconOptions = set of (tioAniRestoreIcon, tioAniLoop, tioDisableCloseButton,
                                tioShowMinimizedIcon, tioRestoreOnDblClick);

const
  def_TLMDTrayIconOptions = [tioAniRestoreIcon, tioAniLoop, tioRestoreOnDblClick,
                             tioRestoreOnDblClick];

type
  TLMDTrayIcon=class(TLMDWndProcComponent)
  private
    FIconData       : TLMDNotifyIconData;
    FCancelAnimation,
    FIntClick,
    FAnimated,
    FActive         : Boolean;
    FHint           : String;
    FIcon,
    FCurrentIcon    : TIcon;
    FInternal       : TPoint;
    FPopUpMenu      : TPopUpMenu;
    FThreadPriority : TThreadPriority;
    FImageList      : TCustomImageList;
    FListIndex      : Integer;
    FTimerMode      : TLMDTimerMode;
    FInterval       : TLMDTimerInterval;
    FCounter        : Integer;
    FTimerId        : TLMDTimer;
    FTimer          : TLMDHiTimer;
    FOnNoClose,
    FOnDblClick,
    FOnClick,
    FOnPopUp        : TNotifyEvent;
    FOnMouseDown,
    FOnMouseUp      : TMouseEvent;
    FOnMouseMove    : TMouseMoveEvent;
    // 8.1 BallonHint Support
    FBalloonTitle,
    FBalloonHint    : string;
    FBalloonFlags   : TLMDBalloonFlags;
    FTimeOut        : Integer;
    FOnAnimate      : TNotifyEvent;
    FOptions        : TLMDTrayIconOptions;
    // --------
    procedure SetAnimated (aValue : Boolean);
    procedure SetBoolean(const Index: Integer; const Value: Boolean);
    procedure SetImageList (aValue:TCustomImageList);
    procedure SetActive(aValue:Boolean);
    procedure SetHint(const aValue:String);
    procedure SetIcon(aValue:TIcon);
    procedure SetPopUpMenu(aValue:TPopUpMenu);
    procedure SetTimerMode(aValue:TLMDTimerMode);
    // fake readers
    procedure  ReadNoClose(Reader:TReader);
    procedure  ReadShowMinimizedIcon(Reader:TReader);
    // getters
    function GetBoolean(const Index: Integer): Boolean;
    procedure GetTimer(Sender:TObject);
    function  NotifyIcon(aValue:Word):Boolean;
    procedure NewWndProc(var Message: TMessage);
    procedure IconChanged(Sender : TObject);
    // Timer related
    procedure ActivateTimer;
    procedure DeActivateTimer(aValue:TLMDTimerMode);
    procedure EnableTimer(aValue:Boolean);
    // 8.10
    function TaskBarHandle : HWND;
    procedure TaskBarShow(const show:Boolean);
  protected
    procedure DefineProperties(Filer:TFiler);override;
    procedure Loaded; override;
    procedure Notification(aComponent:TComponent; Operation: TOperation); override;
    function AppWndProc(var Message: TMessage):Boolean; override;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function IsMinimized:Boolean;
    function CanShowBallonHint:Boolean;
    function CurrentImageIndex:Integer;

    procedure HideBallonHint;
    procedure HideApplication;
    procedure ShowApplication;
    function ShowBalloonHint:Boolean; overload;
    function ShowBalloonHint(const aTitle, aHint: String; aFlags: TLMDBalloonFlags = bfNone; aTimeOut: Integer = 10000):Boolean; overload;
    procedure Refresh;
    procedure SetDefaultIcon;

    property NoClose:Boolean index 0 read GetBoolean write SetBoolean;
    property ShowMinimizedIcon:Boolean index 1 read GetBoolean write SetBoolean;
  published
    property About;
    property Active:Boolean read FActive write SetActive default True;
    property Hint:String read FHint write SetHint;
    property Icon:TIcon read FIcon write SetIcon;

    property PopupMenu:TPopupMenu read FPopUpMenu write SetPopUpMenu;
    property ImageList:TCustomImageList read FImageList write SetImageList;
    property ListIndex: Integer read FListIndex write FListIndex default 0;

    property TimerMode : TLMDTimerMode read FTimerMode write SetTimerMode default tmNormal;
    property ThreadPriority : TThreadPriority read FThreadPriority write FThreadPriority default tpNormal;
    property Interval : TLMDTimerInterval read FInterval write FInterval default 200;
    property Animated : Boolean read FAnimated write SetAnimated default false;

    // 8.1
    property BalloonHint: string read FBalloonHint write FBalloonHint;
    property BalloonTitle: string read FBalloonTitle write FBalloonTitle;
    property BalloonTimeout: Integer read FTimeout write FTimeOut default 10000;
    property BalloonFlags: TLMDBalloonFlags read FBalloonFlags write FBalloonFlags default bfNone;
    property Options: TLMDTrayIconOptions read FOptions write FOptions default def_TLMDTrayIconOptions;

    property OnAnimate: TNotifyEvent read FOnAnimate write FOnAnimate;

    {events}
    property OnClick:TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick:TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnMouseDown:TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove:TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp:TMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnPopUp:TNotifyEvent read FOnPopUp write FOnPopUp;
    property OnNoClose:TNotifyEvent read FOnNoClose write FOnNoClose;
  end;

implementation

uses
  Consts, Forms, SysUtils, ComCtrls,
  LMDProcs, LMDUtils, LMDGraphUtils, LMDSysIn;

var
  WM_TASKBARCREATED: Cardinal  = 0;//;
  HintSize: integer = 127; // default. before Win2k: 63
  AllowBallonHints: Boolean = true;
  NotifyIconDataSize: DWord = 0;

{------------------------------------------------------------------------------}
procedure InitConstants;
begin
  if GetComCtlVersion >= ComCtlVersionIE4 then
    WM_TASKBARCREATED := RegisterWindowMessage('TaskbarCreated');
  if LMDSIWindows2000Up then
    NotifyIconDataSize := SizeOf(TLMDNotifyIconData)
  else
    begin
      NotifyIconDataSize :=  SizeOf(TNotifyIconData);
      AllowBallonHints := false;
      HintSize := 63;
    end;
  end;

{ *********************** TLMDTrayIcon ****************************************}
{------------------------- Private --------------------------------------------}
procedure TLMDTrayIcon.SetImageList (aValue:TCustomImageList);
begin
  FImageList:=aValue;
  if FImageList<>nil then
    FImageList.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.SetActive(aValue:Boolean);
begin
  if not NewStyleControls then exit;

  if aValue<>FActive then
    begin
      FActive:=aValue;
      if [csDesigning, csReading, csLoading]*ComponentState<>[] then exit;
      if FActive then
        begin
          Enabled:=True;
          if IsIconic(TaskBarHandle) and not (tioShowMinimizedIcon in FOptions) then
            begin
              {$IFDEF LMDCOMP11}
              if not (LMDSIWindowsVistaUp and Application.MainFormOnTaskBar) then
              {$ENDIF}
                Application.ShowMainForm:=False;
              TaskBarShow(false);
            end
          else
            begin
              {$IFDEF LMDCOMP11}
              if not (LMDSIWindowsVistaUp and Application.MainFormOnTaskBar) then
              {$ENDIF}
                Application.ShowMainForm:=True;
              //TaskBarShow(true);
            end;
          //Application.ProcessMessages;
          ActivateTimer;
          if not FAnimated then
            SetDefaultIcon;
          NotifyIcon(NIM_ADD);
          EnableTimer(true);
        end
      else
        begin
          Enabled:=False;
          Application.ShowMainForm := True;
          ShowWindow(TaskBarHandle, SW_SHOWNORMAL);
          NotifyIcon(NIM_DELETE);
          DeactivateTimer(FTimerMode);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.SetHint(const aValue:String);
begin
  if (aValue<>FHint) then
    begin
      FHint:=aValue;
      StrPLCopy(FIconData.szTip, FHint, hintsize);
      if Length(FHint) > 0 then
        FIconData.uFlags := FIconData.uFlags or NIF_TIP
      else
        FIconData.uFlags := FIconData.uFlags and not NIF_TIP;
      Refresh;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.SetIcon(aValue:TIcon);
begin
  FIcon.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.SetPopUpMenu(aValue:TPopUpMenu);
begin
  if FPopUpMenu<>aValue then
    begin
      FPopupMenu:=aValue;
      if (aValue<>nil) then
        aValue.FreeNotification(self);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.SetTimerMode(aValue:TLMDTimerMode);
begin
  if FTimerMode<>aValue then
    if csLoading in ComponentState then
      FTimerMode:=aValue
    else
      begin
        DeactivateTimer(FTimerMode);
        FTimerMode:=aValue;
        ActivateTimer;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.SetAnimated (aValue : Boolean);
begin
  if aValue <> FAnimated then
    begin
      FAnimated := aValue;
      if not (csDesigning in ComponentState) then
        begin
          if FAnimated and FActive and Assigned(FImageList) and (LMDIMLCount(FImageList, FListIndex)>0) then
            begin
              FCancelAnimation := false;
              ActivateTimer;
              EnableTimer (true);
            end
          else
            begin
              DeActivateTimer(FTimerMode);
              if tioAniRestoreIcon in FOptions then
                SetDefaultIcon;
            end;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.SetBoolean(const Index: Integer; const Value: Boolean);
begin
  case index of
    0: if Value then
         Include(FOptions, tioDisableCloseButton)
       else
         Exclude(FOptions, tioDisableCloseButton);
    1: if Value then
         Include(FOptions, tioShowMinimizedIcon)
       else
         Exclude(FOptions, tioShowMinimizedIcon);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDTrayIcon.NotifyIcon(aValue:Word):Boolean;
begin
  result := false;
  if (csDesigning in ComponentState) then exit;
  result :=
            Shell_NotifyIcon(aValue, @FIconData);
            end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.NewWndProc(var Message: TMessage);
begin

   with Message do
     case Msg of
       WM_QUERYENDSESSION:
          Message.Result := 1;
       WM_ENDSESSION:
         if TWMEndSession(Message).EndSession then
           NotifyIcon(NIM_DELETE);
       WM_SYSTEM_TRAY_MESSAGE:
         case LParam of
           NIN_BALLOONHIDE, NIN_BALLOONTIMEOUT:
             FIconData.uFlags := FIconData.uFlags and not NIF_INFO;
           WM_MOUSEFIRST..WM_MOUSELAST:
             with TWMMouse(Message), FInternal do
               begin
                 GetCursorPos(FInternal);
                 case LParam of
                  WM_LBUTTONDBLCLK, WM_MBUTTONDBLCLK, WM_RBUTTONDBLCLK:
                    begin
                      if Assigned(FOnDblClick) then
                        FOnDblClick(Self);
                      if (tioRestoreOnDblClick in FOptions) and Assigned(WndOwner) then
                        ShowApplication;
                    end;
                  WM_LBUTTONDOWN:
                    begin
                      FIntClick := true;
                      if Assigned(FOnMouseDown) then
                        FOnMouseDown(Self, mbLeft, KeysToShiftState(Keys), X, Y);
                    end;
                  WM_LBUTTONUP:
                    begin
                      if Assigned(FOnClick) and FIntClick then
                        begin
                          FIntClick := false;
                          FOnClick(Self);
                        end;
                      if Assigned(FOnMouseUp) then
                        FOnMouseUp(Self, mbLeft, KeysToShiftState(Keys), X, Y);
                    end;
                  WM_MBUTTONDOWN:
                    if Assigned(FOnMouseDown) then
                      FOnMouseDown(Self, mbMiddle, KeysToShiftState(Keys), X, Y);
                  WM_MBUTTONUP:
                    if Assigned(FOnMouseUp) then
                      FOnMouseUp(Self, mbMiddle, KeysToShiftState(Keys), X, Y);
                  WM_MOUSEMOVE:
                    if Assigned(FOnMouseMove) then
                      FOnMouseMove(Self, KeysToShiftState(Keys), X, Y);
                  WM_RBUTTONDOWN:
                    begin
                      if Assigned(FOnMouseDown) then
                        FOnMouseDown(Self, mbRight, KeysToShiftState(Keys), X, Y);
                      if Assigned(FPopUpMenu) then
                        with FPopUpMenu do
                          begin
                            if Assigned(FOnPopup) then FOnPopUp(Self);
                            SetForegroundWindow(TaskBarHandle);
                            Application.ProcessMessages;
                            PopUpComponent:=self;
                            PopUp(X, Y);
                          end;
                    end;
                  WM_RBUTTONUP:
                    if Assigned(FOnMouseUp) then
                      FOnMouseUp(Self, mbRight, KeysToShiftState(Keys), X, Y);
                 end;
               end;
         end;
     else
       if (Message.Msg = WM_TASKBARCREATED) and FActive then
         NotifyIcon(NIM_ADD)
       else
         Result:= DefWindowProc(FIconData.Wnd, Msg, wParam, lParam);
     end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.IconChanged(Sender : TObject);
begin
  if csDesigning in ComponentState then exit;
  FCurrentIcon.Assign(FIcon);
  Refresh;
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.ActivateTimer;
begin
  if not FAnimated then exit;
  case FTimerMode of
    tmNormal, tmGlobalTimer:
      begin
        if Assigned(FTimerId) then exit;
        FTimerId := TLMDTimer.Create(FInterval, GetTimer, false, (FTimerMode=tmGlobalTimer));
      end;
    tmThreaded, tmHiTimer:
       begin
         if Assigned (FTimer) then exit;
         FTimer := TLMDHiTimer.Create(self);
         FTimer.OnTimer := GetTimer;
         FTimer.UseThread := FTimerMode=tmThreaded;
       end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.DeActivateTimer(aValue:TLMDTimerMode);
begin
  case aValue of
    tmNormal, tmGlobalTimer:
      if Assigned(FTimerID) then
        FreeAndNil(FTimerID);
    tmThreaded, tmHiTimer:
       begin
         If Assigned(FTimer) then FTimer.Free;
         FTimer:=nil;
       end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.EnableTimer(aValue:Boolean);
begin
  if not FAnimated then exit;
  FCounter := 0;
  case FTimerMode of
    tmNormal, tmGlobalTimer:
      begin
        if aValue then FTimerId.Interval:=FInterval;
        FTimerId.Enabled:=aValue;
      end;
    tmThreaded, tmHiTimer:
      begin
        if aValue then
          begin
            FTimer.Interval:=FInterval;
            FTimer.ThreadPriority:=FThreadPriority;
          end;
        FTimer.Enabled:=aValue;
      end;
   end;
end;

{------------------------------------------------------------------------------}
function TLMDTrayIcon.GetBoolean(const Index: Integer): Boolean;
begin
  result := false;
  case index of
    0: result := tioDisableCloseButton in FOptions;
    1: result := tioShowMinimizedIcon in FOptions;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.GetTimer(Sender:TObject);
begin
  if FCancelAnimation then
    begin
      Animated := false;
      exit;
    end;

  LMDIMLItemIcon(ImageList, FListIndex, FCounter, FCurrentIcon);
  Refresh;

  if Assigned(FOnAnimate) then
    FOnAnimate(Self);

  Inc(FCounter);
  if (FCounter >= LMDIMLCount(FImageList, FListIndex)) then
    begin
      FCounter := 0;
      if not (tioAniLoop in FOptions) then
        FCancelAnimation := true;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.ReadNoClose(Reader:TReader);
begin
  NoClose := Reader.ReadBoolean;
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.ReadShowMinimizedIcon(Reader:TReader);
begin
  ShowMinimizedIcon := Reader.ReadBoolean;
end;

{------------------------------------------------------------------------------}
function TLMDTrayIcon.TaskBarHandle : HWND;
begin
  {$IFDEF LMDCOMP11}
  if Application.MainFormOnTaskBar then
    begin
      result := Application.MainFormHandle;
      if result = 0 then
        result := Application.Handle;
    end
  else
  {$ENDIF}
    result := Application.Handle;
end;
{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.TaskBarShow(const show:Boolean);
var
  FHandle:THandle;
begin
  FHandle := TaskBarHandle;
  if FHandle = 0 then exit;
  if Show then
    ShowWindow(FHandle, SW_SHOW)
  else
    ShowWindow(FHandle, SW_HIDE);
end;

{-------------------------- Protected -----------------------------------------}
procedure TLMDTrayIcon.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty( 'NoClose', ReadNoClose, nil, false );
  Filer.DefineProperty( 'ShowMinimizedIcon', ReadShowMinimizedIcon, nil, false );
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.Loaded;
begin
  inherited Loaded;
  if FActive then
    begin
      FActive:=False;
      Active:=True;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.Notification(aComponent: TComponent;  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) then
    begin
      if (AComponent=FPopupMenu) then
        FPopupMenu:=nil;
      if (aComponent=FImageList) then
        ImageList:=nil;
    end;
end;

{--------------------------- Protected ----------------------------------------}
function TLMDTrayIcon.AppWndProc(var Message: TMessage):Boolean;
begin
  result := false;
  if not FActive then exit;
  case Message.Msg of
     WM_SYSCOMMAND:
       begin
         case TWMSysCommand(Message).CmdType
              of
           SC_MINIMIZE:
             if not (tioShowMinimizedIcon in FOptions) then
               TaskBarShow(false);
           SC_CLOSE:
             if (tioDisableCloseButton in FOptions) then
               begin
                 HideApplication;
                 if Assigned(FOnNoClose) then
                   FOnNoClose(WndOwner);
                 result := true;
               end;
         end;
       end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.WndProc(var Message: TMessage);
begin
   if FDestroying or not FActive then
     begin
       inherited WndProc(Message);
       exit;
     end;

   case Message.Msg of
     WM_SYSCOMMAND:
       begin
         case TWMSysCommand(Message).CmdType
              of
           SC_CLOSE:
             if (tioDisableCloseButton in FOptions) then
               begin
                 HideApplication;
                 if Assigned(FOnNoClose) then
                   FOnNoClose(WndOwner);
                 exit;
               end;
           SC_MINIMIZE:
             begin
               inherited WndProc(Message);
               if not (tioShowMinimizedIcon in FOptions) then
                 TaskBarShow(False);
               exit;
             end;
         end;
         inherited WndProc(Message)
       end;
   else
     inherited WndProc(Message);
   end;
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDTrayIcon.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FHandleApp := true;

  // Icons
  FIcon := TIcon.Create;
  FIcon.OnChange := IconChanged;
  FCurrentIcon:= TIcon.Create;
  // BalloonHints
  FBalloonFlags := bfNone;
  FTimeOut := 10000;
  FOptions := def_TLMDTrayIconOptions;

  FActive:=True;
  FImageList:=nil;
  FThreadPriority:=tpNormal;
  FTimerMode:=tmNormal;
  FTimerId := nil;
  FInterval:=200;
  FCounter := 0;
  FListIndex := 0;
  FAnimated := false;

  if not (csDesigning in ComponentState) then
    with FIconData do
      begin
        {$ifdef LMDCOMP15}
        ZeroMemory(@FIconData, FIconData.SizeOf());
        {$else}
        ZeroMemory(@FIconData, SizeOf(FIconData));
        {$endif}
        uFlags := NIF_MESSAGE or NIF_ICON;
        cbSize := NotifyIconDataSize;
        Wnd := AllocateHwnd(NewWndProc);
        uID := FIconData.Wnd;
        hIcon := FCurrentIcon.Handle;
        StrPLCopy(szTip, Application.Title, HintSize);
        if Length(Application.Title) > 0 then
           uFlags := uFlags or NIF_TIP;
        uTimeout := FTimeOut;
        uCallbackMessage := WM_SYSTEM_TRAY_MESSAGE;
      end;
end;

{------------------------------------------------------------------------------}
destructor TLMDTrayIcon.Destroy;
begin
  DeActivateTimer(FTimerMode);
  NotifyIcon(NIM_DELETE);
  Enabled:=False;
  LMDDeAllocateHWnd(FIconData.Wnd);
  FreeAndNil(FIcon);
  FreeAndNil(FCurrentIcon);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDTrayIcon.CanShowBallonHint:Boolean;
begin
  result := AllowBallonHints = True;
end;

{------------------------------------------------------------------------------}
function TLMDTrayIcon.CurrentImageIndex: Integer;
begin
  result := FCounter;
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.Refresh;
begin
  if (csDesigning in ComponentState) then exit;
  FIconData.hIcon := FCurrentIcon.Handle;
  if FActive then
    NotifyIcon(NIM_MODIFY);
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.SetDefaultIcon;
begin
  if not FIcon.Empty then
    FCurrentIcon.Assign(FIcon)
  else
    FCurrentIcon.Assign(Application.Icon);
  Refresh;
end;

{------------------------------------------------------------------------------}
function TLMDTrayIcon.IsMinimized: Boolean;
begin
  result := IsIconic(TaskBarHandle) or not IsWindowVisible(TaskBarHandle);// or Application;
end;
{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.HideBallonHint;
begin
  ShowBalloonHint('', '');
end;

{------------------------------------------------------------------------------}
function TLMDTrayIcon.ShowBalloonHint:Boolean;
begin
  result := ShowBalloonHint(FBalloonTitle, FBalloonHint, FBalloonFlags, FTimeOut);
end;

{------------------------------------------------------------------------------}
function TLMDTrayIcon.ShowBalloonHint(const aTitle, aHint: String; aFlags: TLMDBalloonFlags = bfNone; aTimeOut: Integer = 10000):Boolean;
begin
  //HideBallonHint;
  result := false;
  if not AllowBallonHints then exit;
  FIconData.uFlags := FIconData.uFlags or NIF_INFO;
  FIconData.dwInfoFlags := Integer(aFlags);
  if not LMDSIWindowsVistaUp then
    FIconData.uTimeout := aTimeOut;
  StrPLCopy(FIconData.szInfoTitle, aTitle, 63);
  StrPLCopy(FIconData.szInfo, aHint, 255);
  result := NotifyIcon(NIM_MODIFY);
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.HideApplication;
begin
  if not FActive then exit;
  if Assigned(Application.MainForm)
     {$IFDEF LMDCOMP11} and not Application.MainFormOnTaskBar {$ENDIF} then
    Application.MainForm.Visible := false;
  Application.Minimize;
  TaskBarShow(false);
end;

{------------------------------------------------------------------------------}
procedure TLMDTrayIcon.ShowApplication;
begin
  if not FActive then exit;
  if IsMinimized then
    begin
      if Assigned(Application.MainForm) then
        begin
          Application.MainForm.Visible := True;
          {$IFDEF LMDCOMP11}
          //if LMDSIWindowsVistaUp and Application.MainFormOnTaskBar then
          Application.MainForm.WindowState := wsNormal;
          Application.MainForm.Show;
          {$ENDIF}
        end;
      Application.Restore;
      Application.BringToFront;
    end;
end;

initialization
  InitConstants;
end.
