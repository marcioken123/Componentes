{ Summary
  Unit contains the TJSProgressBar control that is the default control used for displaying
  progress on the dialog. }
unit JSProgressBar;

interface

{$I lmddlgcmps.inc}

uses
  SysUtils, Classes, Controls, ExtCtrls{$IFNDEF DELPHI5}, Types{$ENDIF DELPHI5}, Windows, Graphics,
  Messages, SyncObjs, ComCtrls{$IFDEF THEMES}, Themes, UxTheme{$ENDIF THEMES}, CommCtrl;

const
{$IFDEF DELPHI}
  PBS_MARQUEE = $08;
  PBM_SETMARQUEE = WM_USER + 10;

  PBM_GETSTEP = WM_USER + 13;
  PBM_GETBKCOLOR = WM_USER + 14;
  PBM_GETBARCOLOR = WM_USER + 15;
  PBM_SETSTATE = WM_USER + 16;
  PBM_GETSTATE = WM_USER + 17;

  PBST_NORMAL = $0001;
  PBST_ERROR = $0002;
  PBST_PAUSED = $0003;
{$ENDIF DELPHI}
  // Constants for the display of progress on taskbar under Windows 7
  CLSID_TaskbarList: TGUID = '{56FDF344-FD6D-11d0-958A-006097C9A090}';
  TBPF_NOPROGRESS = 0;
  TBPF_INDETERMINATE = $1;
  TBPF_NORMAL = $2;
  TBPF_ERROR = $4;
  TBPF_PAUSED = $8;

{$IFDEF DELPHI2005}
const
  { Value to make a progress bar a marquee one. Used in conjunction with the PBM_SETMARQUEE message. }
  {$NODEFINE PBS_MARQUEE}
  PBS_MARQUEE = $08;
  { Message to send to make the progress bar display as marquee. }
  {$NODEFINE PBM_SETMARQUEE}
  PBM_SETMARQUEE = WM_USER + 10;

  { Message to send to get the step value of the progress bar. }
  {$NODEFINE PBM_GETSTEP}
  PBM_GETSTEP = WM_USER + 13;
  { Message to send to get the background colour of the progress bar. }
  {$NODEFINE PBM_GETBKCOLOR}
  PBM_GETBKCOLOR = WM_USER + 14;
  { Message to send to get the colour of the progress bar. }
  {$NODEFINE PBM_GETBARCOLOR}
  PBM_GETBARCOLOR = WM_USER + 15;
  { Message to send to set the state of the progress bar. }
  {$NODEFINE PBM_SETSTATE}
  PBM_SETSTATE = WM_USER + 16;
  { Message to send to get the state of the progress bar. }
  {$NODEFINE PBM_GETSTATE}
  PBM_GETSTATE = WM_USER + 17;

  { Value to make the progress bar in the normal state. Used in conjunction with the PBM_SETSTATE
    message.                                                                                      }
  {$NODEFINE PBST_NORMAL}
  PBST_NORMAL = $0001;
  { Value to make the progress bar in the error state. Used in conjunction with the PBM_SETSTATE message. }
  {$NODEFINE PBST_ERROR}
  PBST_ERROR = $0002;
  { Value to make the progress bar in the paused state. Used in conjunction with the PBM_SETSTATE
    message.                                                                                      }
  {$NODEFINE PBST_PAUSED}
  PBST_PAUSED = $0003;

  {$IFNDEF DELPHI2007}
  { Summary
    Horizontal marquee movement part for progress bar theming.
    Description
    Horizontal marquee movement part for progress bar theming. }
  PP_MOVEOVERLAY = 8;
  PP_FILL = 5;
  PBFS_ERROR = 2;
  PBFS_PAUSED = 3;
  PBFS_PARTIAL = 4;
  {$ENDIF DELPHI2007}

{$ENDIF DELPHI2005}

type
  { Summary
    The style of the progress bar. The default style is psNormal. }
  TProgressStyle = (psNormal { Use the normal style when you know the maximum value of the
    progress and can update it when required. },
   psMarquee { Use the marquee style to show an indeterminate progress bar.
    That is a progress bar that you do not know when it is going to finish. }
  );

  { Summary
    Set the state of the progress bar. The default state is pbstNormal. }
  TProgressBarState = (
    pbstNormal { The progress bar is drawn green/blue. },
    pbstError { The progress bar is drawn red. },
    pbstPaused { The progress bar is drawn yellow. }
  );

  TJSProgressBar = class;

  { Summary
    Thread class that is used by the TJSProgressBar class.
    Description
    Implements the thread used to update the progress bar when it is a marquee. }
  TJSMarqueeThread = class(TThread)
  private
    FClientRect: TRect;
    FInterval: integer;
    FChunkWidth: Integer;
    FUseThemes: Boolean;
    FState: TProgressBarState;
    FHwnd: THandle;
    FBitmap: TBitmap;
    FImgRect : TRect;
    FOffset: Integer;
    FX: Integer;
    FRect: TRect;
    FDC: HDC;
    {$IFDEF THEMES}
    lDetail: TThemedElementDetails;
    {$ENDIF THEMES}
  protected
    procedure Paint;
    { Summary
      Implements the threading capability of the progress bar marquee style.
      Description
      Implements the threading capability of the progress bar marquee style. }
    procedure Execute; override;
  public
    constructor Create(AProgressBar: TJSProgressBar; const Themed: Boolean);
  end;

  { Summary
    Control used when the dialog displays a progress bar.
    Description
    Default control used when doProgressBar or doProgressBarMarquee option is set in the DialogOptions
    property and is not running under Windows XP.<p />
    <p />
    Implements a progress bar from scratch. Does not inherited from the progress bar common control.<p />
    <p />
    Since the Marquee behaviour is threaded, when a process is taking a lot of CPU the marquee will still
    continue to update. This is not the case with the common control progress bar. If you have a long
    running CPU intensive process to be done while displaying a dialog, you should turn off the
    UseNativeProgressBar subproperty for the Progress property. This will allow the marquee progress to
    still be visible to your users.                                                                       }
  TJSProgressBar = class(TCustomControl)
  private
    FOnProgress: TNotifyEvent;
    FProgressColor: TColor;
    FChunkWidth: Integer;
    FStep: Integer;
    FPosition: Integer;
    FMax: Integer;
    FStyle: TProgressStyle;
    FState: TProgressBarState;
    FMarqueeThread: TJSMarqueeThread;
    FActive: Boolean;
    FInterval: Cardinal;
    FCreateThreadCS: TCriticalSection;
    procedure SetInterval(const Value: Cardinal);
    function GetInterval: Cardinal;
    function GetIsActivated: Boolean;
    procedure SetProgressColor(const Value: TColor);
    function GetActive: Boolean;
    procedure SetActive(const Value: Boolean);
    procedure SetPosition(const Value: Integer);
    procedure SetStep(const Value: Integer);
    procedure SetMax(const Value: Integer);
    procedure SetStyle(const Value: TProgressStyle);
    procedure SetChunkWidth(const Value: Integer);
    procedure SetState(const Value: TProgressBarState);
    procedure CreateMarqueeThread(const aCreate: Boolean);
  protected
    { Summary
      Calls the OnProgress event.
      Description
      Virtual so descendant classes can intercept progress messages. }
    procedure DoProgress; virtual;
    procedure InitializeStyle(const AStyle: TProgressStyle); virtual;
    procedure Paint; override;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure CreateWnd; override;
    procedure RecreateWndHandler(var Message: TMessage); message CM_RECREATEWND;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Summary
      Initiates the progress bar marquee style.
      Description
      Commences the marquee style animation for the progress bar. The aInterval parameter specifies the
      update interval for the animation.                                                                }
    procedure Activate(const aInterval: Cardinal);
    procedure Deactivate;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
    { Summary
      Increment the progress by the Step amount.
      Description
      Advances the position of the progress bar by the value of the Step property. }
    procedure StepIt;
    { Returns True if the psMarquee progress bar is currently activated. }
    property  IsActivated: Boolean read GetIsActivated;
  published
    { Set to start the psMarquee style progress bar. }
    property Active: Boolean read GetActive write SetActive default False;
    { Time it takes between painting updates to a psMarquee style
      progress bar.                                               }
    property Interval: Cardinal read GetInterval write SetInterval default 100;
    { Color of the progress bar. This value is currently set by the
      ProgressStyle property and has no effect for either psNormal
      or psMarquee style progress bars.                            }
    property ProgressColor: TColor read FProgressColor write SetProgressColor default clLime;
    { Current position of the progress bar. }
    property Position: Integer read FPosition write SetPosition default 0;
    { Maximum value for the progress bar when the style is
      psNormal. Once the position reaches the Max value, the
      progress bar is considered finished.                   }
    property Max: Integer read FMax write SetMax default 100;
    { The amount to advance the progress bar position by with
      StepIt method is called.                                }
    property Step: Integer read FStep write SetStep default 1;
    { Summary
      Sets the style of the progress bar.
      Description
      The style of the progress bar can be either psNormal or psMarquee.

      Use the psNormal style when you know how long the process is
      going to take. When the time a process is going to take is
      unknown, use the psMarquee style.                            }
    property Style: TProgressStyle read FStyle write SetStyle default psNormal;
    { Width of each of the progress bar segments. }
    property ChunkWidth: Integer read FChunkWidth write SetChunkWidth default 40;
    { The current state of the progress bar.

      The state can be one of the following pbstNormal, pbstError,
      pbstPaused.                                                  }
    property State: TProgressBarState read FState write SetState default pbstNormal;
    { Background color of the progress bar. Not used if the
      application contains a manifest file.                 }
    property Color default clBtnFace;
    { Height of the progress bar. }
    property Height default 17;
    { Width of the progress bar. }
    property Width default 145;
    { Summary
      Event fired when the progress bar position changes.
      Description
      Event triggered when the progress bars position changes. }
    property OnProgress: TNotifyEvent read FOnProgress write FOnProgress;
  end;

  { Summary
    Progress bar class that descends from the common progress bar control.
    Description
    Progress bar that fixes a repaint bug in the common progress bar control under Windows Vista. Also
    adds support for the State messages which is supported by Windows Vista.                           }
  TJSProgressBarEx = class(TProgressBar)
  private
    FActive: Boolean;
    FInterval: Integer;
    {$IFNDEF DELPHI2009}
    FState: TProgressBarState;
    {$ENDIF DELPHI2009}
    procedure SetActive(const Value: Boolean);
    procedure SetInterval(const Value: Integer);
    {$IFNDEF DELPHI2009}
    procedure SetState(const Value: TProgressBarState);
    {$ENDIF DELPHI2009}
  protected
    { Summary
      Method called when the update interval has been changed. }
    procedure IntervalChanged; virtual;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  public
    constructor Create(AOwner: TComponent); override;
  published
    { Specifies the height of the progress bar. }
    property Height default 15;
    { Summary
      Indicates whether the progress bar is showing progress when it is set to marquee style. }
    property Active: Boolean read FActive write SetActive default False;
    { Summary
      Determines the amount of time, in milliseconds, that passes before the progress bar updates when set
      to marquee style.                                                                                    }
    property Interval: Integer read FInterval write SetInterval default 100;
    { Specify the state of the progress bar. }
    {$IFNDEF DELPHI2009}
    property State: TProgressBarState read FState write SetState default pbstNormal;
    {$ENDIF DELPHI2009}
  end;

  { Summary
    Implements the Marquee functionality for a progress bar. }
  TJSProgressBarMarquee = class(TJSProgressBarEx)
  protected
    { Make sure PBS_MARQUEE style is included when the control is created. }
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure IntervalChanged; override;
  end;

type
  {$IFNDEF DELPHI2007}
  ULONGLONG = {$IFDEF VER140}Int64{$ELSE}UInt64{$ENDIF};
  {$ENDIF}

  ITaskbarList = interface(IUnknown)
    ['{56FDF342-FD6D-11D0-958A-006097C9A090}']
    function HrInit: HRESULT; stdcall;
    function AddTab(hwnd: HWND): HRESULT; stdcall;
    function DeleteTab(hwnd: HWND): HRESULT; stdcall;
    function ActivateTab(hwnd: HWND): HRESULT; stdcall;
    function SetActiveAlt(hwnd: HWND): HRESULT; stdcall;
  end;

  ITaskbarList2 = interface(ITaskbarList)
    ['{602D4995-B13A-429B-A66E-1935E44F4317}']
    function MarkFullscreenWindow(hwnd: HWND; fFullscreen: BOOL): HRESULT; stdcall;
  end;

  THUMBBUTTON = record
    dwMask: DWORD;
    iId: UINT;
    iBitmap: UINT;
    hIcon: HICON;
    szTip: packed array[0..259] of WCHAR;
    dwFlags: DWORD;
  end;
  TThumbButton = THUMBBUTTON;
  PThumbButton = ^TThumbButton;

  ITaskbarList3 = interface(ITaskbarList2)
    ['{EA1AFB91-9E28-4B86-90E9-9E9F8A5EEFAF}']
    function SetProgressValue(hwnd: HWND; ullCompleted: ULONGLONG; ullTotal: ULONGLONG): HRESULT; stdcall;
    function SetProgressState(hwnd: HWND; tbpFlags: Integer): HRESULT; stdcall;
    function RegisterTab(hwndTab: HWND; hwndMDI: HWND): HRESULT; stdcall;
    function UnregisterTab(hwndTab: HWND): HRESULT; stdcall;
    function SetTabOrder(hwndTab: HWND; hwndInsertBefore: HWND): HRESULT; stdcall;
    function SetTabActive(hwndTab: HWND; hwndMDI: HWND; tbatFlags: Integer): HRESULT; stdcall;
    function ThumbBarAddButtons(hwnd: HWND; cButtons: UINT; pButton: PThumbButton): HRESULT; stdcall;
    function ThumbBarUpdateButtons(hwnd: HWND; cButtons: UINT; pButton: PThumbButton): HRESULT; stdcall;
    function ThumbBarSetImageList(hwnd: HWND; himl: HIMAGELIST): HRESULT; stdcall;
    function SetOverlayIcon(hwnd: HWND; hIcon: HICON; pszDescription: LPCWSTR): HRESULT; stdcall;
    function SetThumbnailTooltip(hwnd: HWND; pszTip: LPCWSTR): HRESULT; stdcall;
    function SetThumbnailClip(hwnd: HWND; var prcClip: TRect): HRESULT; stdcall;
  end;

  TJSTaskBarProgressImpl = class(TObject)
  private
    FTaskbarProgressIntf: ITaskbarList3;
    function GetApplicationHandle: THandle;
  public
    constructor Create;
    destructor Destroy; override;
    function SetProgressValue(ullCompleted: ULONGLONG; ullTotal: ULONGLONG): HRESULT;
    function SetProgressState(tbpFlags: Integer): HRESULT;
  end;

implementation

uses
  Forms, ActiveX;

const
  { Constant array that maps the progress bar color to the
    progress bar state property.                           }
  StateColor: array [TProgressBarState] of TColor = (clNavy, clRed, clYellow);

function UseThemes: Boolean;{$IFDEF INLINE}inline;{$ENDIF INLINE}  
begin
  {$IFDEF THEMES}
  if {$IFNDEF DELPHIXE2}ThemeServices.ThemesEnabled{$ELSE}StyleServices.Enabled{$ENDIF} then
    result := True
  else
  {$ENDIF THEMES}
    result := False;
end;

{ Call activate to start a psMarquee style progress bar. }
procedure TJSProgressBar.Activate(const aInterval: Cardinal);
begin
  if FInterval <> aInterval then
  begin
    FActive := True;
    Interval := aInterval;
  end
  else
  begin
    if not FActive and (Style = psMarquee) then
    begin
      FActive := True;
      if FMarqueeThread = nil then
        CreateMarqueeThread(True);
    end;
  end;
end;

{$IFDEF DELPHI}
function CheckWin32Version(AMajor: Integer; AMinor: Integer = 0): Boolean;
begin
  Result := (Win32MajorVersion > AMajor) or
            ((Win32MajorVersion = AMajor) and
             (Win32MinorVersion >= AMinor));
end;
{$ENDIF DELPHI}

constructor TJSProgressBar.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csOpaque];
  FCreateThreadCS := TCriticalSection.Create;
  FInterval := 100;
  FProgressColor := clLime;
  FMax := 100;
  FStep := 1;
  FPosition := 0;
  Color := clBtnFace;
  if CheckWin32Version(5, 1) then
    Height := 17
  else
    Height := 15;
  Width := 145;
  FChunkWidth := 40;
  FState := pbstNormal;
end;

procedure TJSProgressBar.CreateWnd;
begin
  inherited;
  if Active then
  begin
    Deactivate;
    Activate(FInterval);
  end;
end;

procedure TJSProgressBar.Deactivate;
begin
  FActive := False;
  CreateMarqueeThread(FActive);
  Invalidate;
end;

destructor TJSProgressBar.Destroy;
begin
  FActive := False;
  CreateMarqueeThread(False);
  FCreateThreadCS.Free;
  inherited;
end;

procedure TJSProgressBar.DoProgress;
begin
  if Assigned(FOnProgress) then
    FOnProgress(Self);
end;

function TJSProgressBar.GetActive: Boolean;
begin
  result := IsActivated;
end;

function TJSProgressBar.GetInterval: Cardinal;
begin
  result := FInterval;
end;

function TJSProgressBar.GetIsActivated: Boolean;
begin
  result := FActive;
end;

procedure TJSProgressBar.InitializeStyle(const AStyle: TProgressStyle);
begin
  if AStyle = psNormal then
  begin
    CreateMarqueeThread(False);
    FPosition := 0;
  end
  else
  begin
  end;
end;

procedure TJSProgressBar.Paint;
var 
  {$IFDEF THEMES}
  lDetail: TThemedElementDetails;
  {$ENDIF THEMES}
  lRect: TRect;
  lWidth: Single;
  lOffSet: Integer;
//  lValue: Integer;
  lBitmap: TBitmap;
begin

  if FMarqueeThread <> nil then
    Exit;

  lBitmap := TBitmap.Create;
  try
    lBitmap.Width := Width;
    lBitmap.Height := Height;
    {$IFDEF THEMES}
    if {$IFNDEF DELPHIXE2}ThemeServices.ThemesEnabled{$ELSE}StyleServices.Enabled{$ENDIF} then
    begin
      if Win32MajorVersion > 5 then
        lOffset := 1
      else
        lOffset := 3;
    end
    else
    {$ENDIF THEMES}
      lOffset := 1;
    lRect := ClientRect;
    {$IFDEF THEMES}
    if {$IFNDEF DELPHIXE2}ThemeServices.ThemesEnabled{$ELSE}StyleServices.Enabled{$ENDIF} then
    begin
      lDetail := {$IFNDEF DELPHIXE2}ThemeServices{$ELSE}StyleServices{$ENDIF}.GetElementDetails(tpBar);
      {$IFNDEF DELPHIXE2}ThemeServices{$ELSE}StyleServices{$ENDIF}.DrawElement(lBitmap.Canvas.Handle, lDetail, lRect);
    end
    else
    {$ENDIF THEMES}
    begin
      lBitmap.Canvas.Brush.Color := Color;
      lBitmap.Canvas.Brush.Style := bsSolid;
      lBitmap.Canvas.FillRect(lRect);
      FrameRect(lBitmap.Canvas.Handle, lRect, lBitmap.Canvas.Brush.Handle);
    end;
    InflateRect(lRect, -lOffset, -lOffset);
    {$IFDEF THEMES}
    if {$IFNDEF DELPHIXE2}ThemeServices.ThemesEnabled{$ELSE}StyleServices.Enabled{$ENDIF} then
    begin
      LDetail.Element := teProgress;
      LDetail.Part := PP_FILL;
      case State of
        pbstError: LDetail.State := PBFS_ERROR;
        pbstPaused: LDetail.State := PBFS_PAUSED;
        // Partial is not supported but makes the progress bar green/blue colour
        //pbstPartial: LDetail.State := PBFS_PARTIAL;
      else
        LDetail.State := 0;
      end;
    end;
    {$ENDIF THEMES}

    if Max > 0 then
    begin
      lRect.Left := lOffset;
      lWidth := (Width - 6) / Max;
      if Position = 0 then
        lRect.Right := lOffset
      else
        lRect.Right := round(lWidth * Position);
    end;

    {$IFDEF THEMES}
    if {$IFNDEF DELPHIXE2}ThemeServices.ThemesEnabled{$ELSE}StyleServices.Enabled{$ENDIF} then
    begin
      InflateRect(LRect, 1, 1);
      {$IFNDEF DELPHIXE2}ThemeServices{$ELSE}StyleServices{$ENDIF}.DrawElement(lBitmap.Canvas.Handle, lDetail, lRect)
    end
    else
    {$ENDIF THEMES}
    begin
      lBitmap.Canvas.Pen.Color := StateColor[State];
      lBitmap.Canvas.Brush.Color := StateColor[State];
      lBitmap.Canvas.Rectangle(lRect);
    end;

    // code that draws the current progress bar position
//    Canvas.Brush.Style := bsClear;
//    Canvas.Font.Color := clBlack;
//    Canvas.Font.Style := [fsBold];
//    lRect := ClientRect;
//    if Style = psMarquee then
//      lValue := IntToStr(FX)
//    else
//      lValue := IntToStr(FPosition);
//    DrawText(Canvas.Handle, PChar(lValue), Length(lValue), lRect, DT_CENTER or DT_VCENTER or DT_SINGLELINE)

//    BitBlt(Canvas.Handle, 0, 0, Width, Height, lBitmap.Handle, 0, 0, SRCCOPY);

    Canvas.Draw(0, 0, lBitmap);
  finally
    lBitmap.Free;
  end;
end;

procedure TJSProgressBar.RecreateWndHandler(var Message: TMessage);
begin
  if Active then
  begin
    Deactivate;
    Activate(FInterval);
  end;
end;

procedure TJSProgressBar.SetActive(const Value: Boolean);
begin
  if Value then
    Activate(Interval)
  else
    Deactivate;
end;

procedure TJSProgressBar.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  lWidth: Integer;
  lHeight: Integer;
begin
  lWidth := Width;
  lHeight := Height;
  inherited;
  if (Style = psMarquee) and ((AWidth <> lWidth) or (AHeight <> lHeight)) then
    CreateMarqueeThread(FActive);
end;

procedure TJSProgressBar.SetChunkWidth(const Value: Integer);
var
  lIsActive: Boolean;
begin
  if FChunkWidth <> Value then
  begin
    lIsActive := False;
    if Style = psMarquee then
    begin
      lIsActive := Active;
      Active := False;
    end;
    FChunkWidth := Value;
    if Style = psMarquee then
    begin
      Active := lIsActive;
      Invalidate;
    end;
  end;
end;

procedure TJSProgressBar.SetInterval(const Value: Cardinal);
begin
  if FInterval <> Value then
    CreateMarqueeThread(FActive);
end;

procedure TJSProgressBar.SetMax(const Value: Integer);
begin
  if FMax <> Value then
  begin
    FMax := Value;
    Invalidate;
  end;
end;

procedure TJSProgressBar.SetPosition(const Value: Integer);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    Invalidate;
  end;
end;

procedure TJSProgressBar.SetProgressColor(const Value: TColor);
begin
  if FProgressColor <> Value then
  begin
    FProgressColor := Value;
    Invalidate;
  end;
end;

procedure TJSProgressBar.SetState(const Value: TProgressBarState);
begin
  if FState <> Value then
  begin
    FState := Value;
    if Style = psMarquee then
      Active := FState = pbstNormal;
    Invalidate;
  end;
end;

procedure TJSProgressBar.SetStep(const Value: Integer);
begin
  if FStep <> Value then
    FStep := Value;
end;

procedure TJSProgressBar.SetStyle(const Value: TProgressStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    InitializeStyle(Value);
    Invalidate;
  end;
end;

procedure TJSProgressBar.StepIt;
begin
  if Style = psNormal then
    Position := Position + Step;
end;

procedure TJSProgressBar.CreateMarqueeThread(const aCreate: Boolean);
begin
  FCreateThreadCS.Enter;
  try
    if aCreate then
      HandleNeeded; // must be called to prevent memory leak
    if FMarqueeThread <> nil then
    begin
      FMarqueeThread.Terminate;
      FMarqueeThread.WaitFor;
      FreeAndNil(FMarqueeThread);
    end;
    if aCreate then
    begin
      FMarqueeThread := TJSMarqueeThread.Create(Self, UseThemes);
      {$IFDEF DELPHI2010}
      FMarqueeThread.Start;
      {$ELSE}
      FMarqueeThread.Resume;
      {$ENDIF DELPHI2010}
    end;
  finally
    FCreateThreadCS.Leave;
  end;
end;

procedure TJSProgressBar.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

{ TMarqueeThread }

constructor TJSMarqueeThread.Create(AProgressBar: TJSProgressBar; const Themed: Boolean);
begin
  inherited Create(True);
  FClientRect := AProgressBar.ClientRect;
  FInterval := AProgressBar.Interval;
  FChunkWidth := AProgressBar.ChunkWidth;
  FState := AProgressBar.State;
  FUseThemes := Themed;
  FHwnd := AProgressBar.Handle;
  FreeOnTerminate := False;
end;

procedure TJSMarqueeThread.Execute;
begin
  FBitmap := TBitmap.Create;
  try
    FBitmap.Width := FClientRect.Right - FClientRect.Left;
    FBitmap.Height := FClientRect.Bottom - FClientRect.Top;
    FImgRect := Rect(0, 0, FBitmap.Width, FBitmap.Height);
    if Win32MajorVersion > 5 then
      FChunkWidth := 60;
    {$IFDEF THEMES}
    if FUseThemes then
    begin
      if Win32MajorVersion > 5 then
        FOffset := 1
      else
        FOffset := 3;
    end
    else
    {$ENDIF THEMES}
      FOffset := 1;
    FRect := FClientRect;
    FX := 0;
    InflateRect(FRect, -FOffset, -FOffset);
    while not Terminated do
    begin
      Synchronize(Paint);
      Sleep(FInterval);
    end;
  finally
    FBitmap.Free;
  end;
end;

procedure TJSMarqueeThread.Paint;
begin
  {$IFDEF THEMES}
  if FUseThemes then
  begin
//        if Win32MajorVersion > 5 then
//        begin
//          LDetail.Element := teProgress;
//          LDetail.Part := PP_TRANSPARENTBAR;
//          LDetail.State := 0;
//        end
//        else
      lDetail := {$IFNDEF DELPHIXE2}ThemeServices{$ELSE}StyleServices{$ENDIF}.GetElementDetails(tpBar);
    {$IFNDEF DELPHIXE2}ThemeServices{$ELSE}StyleServices{$ENDIF}.DrawElement(FBitmap.Canvas.Handle, lDetail, FClientRect);
    {$IFNDEF DELPHIXE2}
    FRect := {$IFNDEF DELPHIXE2}ThemeServices{$ELSE}StyleServices{$ENDIF}.ContentRect(FBitmap.Canvas.Handle, LDetail, FClientRect);
    {$ELSE}
    if not StyleServices.GetElementContentRect(FBitmap.Canvas.Handle, LDEtail, FClientRect, FRect) then
      FRect := FClientRect;
    {$ENDIF}
  end
  else
  {$ENDIF THEMES}
  begin
    FBitmap.Canvas.Pen.Color := clBtnFace;
    FBitmap.Canvas.Brush.Color := clBtnFace;
    FBitmap.Canvas.FillRect(FClientRect);
    Windows.FrameRect(FBitmap.Canvas.Handle, FClientRect, FBitmap.Canvas.Brush.Handle);
  end;
  if FX < FChunkWidth then
  begin
    if not FUseThemes then
      FRect.Left := FClientRect.Left + FOffset;
    FRect.Right := FRect.Left + FX;
  end
  else
  begin
    FRect.Left := FX - FChunkWidth;
    FRect.Right := FX;
  end;
  if FRect.Right > FClientRect.Right - FOffset then
    FRect.Right := FClientRect.Right - FOffset;
  inc(FX, 8);
  if FX > FClientRect.Right + FChunkWidth then
    FX := FClientRect.Left + FOffset;
  {$IFDEF THEMES}
  if FUseThemes then
  begin
    lDetail := {$IFNDEF DELPHIXE2}ThemeServices{$ELSE}StyleServices{$ENDIF}.GetElementDetails(tpChunk);
    {$IFNDEF DELPHIXE2}ThemeServices{$ELSE}StyleServices{$ENDIF}.DrawElement(FBitmap.Canvas.Handle, lDetail, FRect);
    if Win32MajorVersion > 5 then
    begin
      LDetail.Element := teProgress;
      LDetail.Part := PP_MOVEOVERLAY;
      LDetail.State := 0;
      {$IFNDEF DELPHIXE2}ThemeServices{$ELSE}StyleServices{$ENDIF}.DrawElement(FBitmap.Canvas.Handle, lDetail, FRect);
    end;
  end
  else
  {$ENDIF THEMES}
  begin
    FBitmap.Canvas.Pen.Color := StateColor[FState];
    FBitmap.Canvas.Brush.Color := StateColor[FState];
    FBitmap.Canvas.Rectangle(FRect);
  end;
  FDC := GetDC(FHwnd);
  if FDC <> 0 then
  try
    BitBlt(FDC, FClientRect.Left, FClientRect.Top, FImgRect.Right, FImgRect.Bottom, FBitmap.Canvas.Handle, 0, 0, SRCCOPY);
  finally
    ReleaseDC(FHwnd, FDC);
  end;
end;

{ TJSProgressBarEx }

constructor TJSProgressBarEx.Create(AOwner: TComponent);
begin
  inherited;
  Height := 17;
  FActive := False;
  FInterval := 100;
  {$IFNDEF DELPHI2009}
  FState := pbstNormal;
  {$ENDIF DELPHI2009}
end;

procedure TJSProgressBarEx.IntervalChanged;
begin
  if FActive then
    SendMessage(Handle, PBM_SETMARQUEE, 1, FInterval)
  else
    SendMessage(Handle, PBM_SETMARQUEE, 0, 0);
end;

procedure TJSProgressBarEx.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    IntervalChanged;
  end;
end;

procedure TJSProgressBarEx.SetInterval(const Value: Integer);
begin
  if FInterval <> Value then
  begin
    FInterval := Value;
    IntervalChanged;
  end;
end;

{$IFNDEF DELPHI2009}
procedure TJSProgressBarEx.SetState(const Value: TProgressBarState);
begin
  FState := Value;
  if CheckWin32Version(6, 0) and HandleAllocated then
    SendMessage(Handle, PBM_SETSTATE, WPARAM(Ord(FState) + 1), 0);
end;
{$ENDIF DELPHI2009}

procedure TJSProgressBarEx.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  DefaultHandler(Message);
end;

{ TJSProgressBarMarquee }

procedure TJSProgressBarMarquee.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if UseThemes and CheckWin32Version(5, 1) and not (csDesigning in ComponentState) then
    Params.Style := Params.Style or PBS_MARQUEE;
end;

procedure TJSProgressBarMarquee.CreateWnd;
var
  MarqueeEnabled: Boolean;
begin
  inherited;
  if UseThemes and CheckWin32Version(5, 1) and
     HandleAllocated and not (csDesigning in ComponentState) then
  begin
    MarqueeEnabled := True;
    SendMessage(Handle, PBM_SETMARQUEE, WPARAM(THandle(MarqueeEnabled)), LPARAM(Interval));
  end;
end;

procedure TJSProgressBarMarquee.IntervalChanged;
var
  MarqueeEnabled: Boolean;
begin
  if UseThemes and CheckWin32Version(5, 1) and
    HandleAllocated and not (csDesigning in ComponentState) then
  begin
    MarqueeEnabled := True;
    SendMessage(Handle, PBM_SETMARQUEE, WPARAM(MarqueeEnabled), LPARAM(Interval));
  end;
end;

{ TJSTaskBarProgressImpl }

constructor TJSTaskBarProgressImpl.Create;
begin
  if not CheckWin32Version(6, 1) then
    Exit;
  CoCreateInstance(CLSID_TaskbarList, nil, CLSCTX_INPROC, ITaskbarList3, FTaskbarProgressIntf);
  FTaskbarProgressIntf.HrInit;
  SetProgressState(TBPF_NOPROGRESS);
end;

destructor TJSTaskBarProgressImpl.Destroy;
begin
  SetProgressState(TBPF_NOPROGRESS);
  inherited;
end;

function TJSTaskBarProgressImpl.GetApplicationHandle: THandle;
begin
  {$IFNDEF DELPHI2007}
  Result := Application.Handle;
  {$ELSE}
  if not Application.MainFormOnTaskBar then
  begin
    Result := Application.Handle;
  end
  else
  begin
    if Application.MainForm <> nil then
      Result := Application.MainForm.Handle
    else
      Result := INVALID_HANDLE_VALUE;
  end;
  {$ENDIF}
end;

function TJSTaskBarProgressImpl.SetProgressState(tbpFlags: Integer): HRESULT;
begin
  if FTaskbarProgressIntf <> nil then
    Result := FTaskbarProgressIntf.SetProgressState(GetApplicationHandle, tbpFlags)
  else
    Result := ERROR_SUCCESS;
end;

function TJSTaskBarProgressImpl.SetProgressValue(ullCompleted, ullTotal: ULONGLONG): HRESULT;
begin
  if FTaskbarProgressIntf <> nil then
    Result := FTaskbarProgressIntf.SetProgressValue(GetApplicationHandle, ullCompleted, ullTotal)
  else
    Result := ERROR_SUCCESS;
end;

end.
