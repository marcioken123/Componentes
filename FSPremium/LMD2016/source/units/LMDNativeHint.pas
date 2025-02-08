unit LMDNativeHint;
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

LMDNativeHint unit (AH)
-----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Windows,  Controls, CommCtrl, Messages, Graphics, LMDClass,
  LMDGraph, LMDCustomComponent, LMDTypes, Themes, LMDThemes;

type
  TLMDBaseHint   = class;
  TLMDNativeHint = class;

  { ************************** TLMDBaseHintWindow *****************************}

  TLMDBaseHintWindow = class(THintWindow)
  private
    FHintControl:  TLMDBaseHint;
    FIsCustom:     Boolean;
    FCreatingWith: TLMDBaseHint;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateCustom(AOwner: TComponent;
                             AHintControl: TLMDBaseHint);
    destructor  Destroy; override;
    property    HintControl: TLMDBaseHint read FHintControl;
    property    IsCustom: Boolean read FIsCustom;
  end;

  { ***************************** TLMDBaseHint ********************************}

  TLMDBaseHint = class(TLMDCustomComponent)
  private
    FHideAccelChar: Boolean;
    FMaxWidth:      Integer;
    FOldHintClass:  THintWindowClass;
    FEnabled:       Boolean;
    FHookEnabled:   Boolean;
    FWindows:       TList;

    procedure InsertWindow(AWindow: TLMDBaseHintWindow);
    procedure RemoveWindow(AWindow: TLMDBaseHintWindow);
    procedure UpdateHintHook;
    procedure SetEnabled(Value: Boolean);
    function  GetWindowCount: Integer;
    function  GetWindows(AIndex: Integer): TLMDBaseHintWindow;
  protected
    function  NeedHintHook: Boolean; virtual;
    function  GetHintClass: THintWindowClass; virtual; abstract;
    procedure Loaded; override;
    function  GetThemedHintColor: TColor;

    property  WindowCount: Integer read GetWindowCount;
    property  Windows[AIndex: Integer]: TLMDBaseHintWindow read GetWindows;
    property  Enabled: Boolean read FEnabled write SetEnabled default True;
    property  HideAccelChar: Boolean read FHideAccelChar write FHideAccelChar default True;
    property  MaxWidth: Integer read FMaxWidth write FMaxWidth default -4;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    function    RealMaxWidth: Integer;
  end;

  { ************************* TLMDNativeHintWindow ****************************}

  TLMDNativeHintWindow = class(TLMDBaseHintWindow)
  private
    FHintWindow: THandle;
    procedure WMShowWindow(var Message: TWMShowWindow); message WM_SHOWWINDOW;
  public
    procedure ActivateHint(Rect: TRect; const AHint: string); override;
    function  HintControl: TLMDNativeHint;
  end;

  { **************************** TLMDNativeHint *******************************}

  TLMDNativeHint = class(TLMDBaseHint)
  private
    FIsBalloon: Boolean;
  protected
    function GetHintClass: THintWindowClass; override;
  published
    property About;
    property Enabled;
    property HideAccelChar;
    property IsBalloon: Boolean read FIsBalloon write FIsBalloon default False;
    property MaxWidth;
  end;

implementation

uses
  Forms, SysUtils, LMDProcs, LMDUtils;

var
  GHookedHint: TLMDBaseHint;

{************************* Class TLMDBaseHint *********************************}
{------------------------------------------------------------------------------}
procedure TLMDBaseHint.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    UpdateHintHook;
  end;
end;

{-------------------------------- protected -----------------------------------}
procedure TLMDBaseHint.Loaded;
begin
  inherited;
  UpdateHintHook;
end;

function TLMDBaseHint.NeedHintHook: Boolean;
begin
  Result := True;
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDBaseHint.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);

  FWindows       := TList.Create;
  FMaxWidth      := -4;
  FHideAccelChar := True;
  FEnabled       := True;

  if (csDesigning in ComponentState) and (aOwner is TCustomForm) then
    if LMDCheckForSameClass(aOwner, self.ClassType, True) then
      raise ELMDOneInstError.Create(self.ClassName,0);
  UpdateHintHook;
end;

{------------------------------------------------------------------------------}
destructor TLMDBaseHint.Destroy;
begin
  Enabled := False; // Due to the fact that VCL creates hint windows
                    // implicitly, we can't explicitly destroy all
                    // associated hint windows, but, actually, they will
                    // be destroyed as a result of Application.CancelHint
                    // call while self disabling.
  FWindows.Free;
  inherited Destroy;
end;

function TLMDBaseHint.GetThemedHintColor: TColor;
type
  TRGB = record
    R, G, B, A: Byte;
  end;
var
  b:          TBitmap;
  r:          TRect;
  dtls:       TThemedElementDetails;
  y:          Integer;
  x:          Integer;
  cur:        TColor;
  cr, cg, cb: Integer;
  cnt:        Integer;
begin
  if not LMDThemeServices.ThemesEnabled then
  begin
    Result := clInfoBk;
    Exit;
  end;

  b := TBitmap.Create;
  try
    b.Width  := 16;
    b.Height := 16;
    r        := Rect(0, 0, b.Width, b.Height);

    dtls := LMDThemeServices.GetDetails(teToolTip, Ord(tttStandardNormal));
    LMDThemeServices.DrawElement(ttmPlatform, b.Canvas.Handle, dtls, r);

    cr  := 0;
    cg  := 0;
    cb  := 0;
    cnt := 0;

    for y := 2 to b.Height - 2 - 1 do
      for x := 2 to b.Width - 2 - 1 do
      begin
        cur := b.Canvas.Pixels[x, y];
        Inc(cr, TRGB(cur).R);
        Inc(cg, TRGB(cur).G);
        Inc(cb, TRGB(cur).B);
        Inc(cnt);
      end;

    Result := 0;
    TRGB(Result).R := Round(cr / cnt);
    TRGB(Result).G := Round(cg / cnt);
    TRGB(Result).B := Round(cb / cnt);
  finally
    b.Free;
  end;
end;

function TLMDBaseHint.GetWindowCount: Integer;
begin
  Result := FWindows.Count;
end;

function TLMDBaseHint.GetWindows(AIndex: Integer): TLMDBaseHintWindow;
begin
  Result := TLMDBaseHintWindow(FWindows[AIndex]);
end;

procedure TLMDBaseHint.InsertWindow(AWindow: TLMDBaseHintWindow);
begin
  FWindows.Add(AWindow);
  AWindow.FHintControl := Self;
end;

procedure TLMDBaseHint.UpdateHintHook;
var
  oldsh: Boolean;
begin
  if (FEnabled = FHookEnabled) or not NeedHintHook then
    Exit;
  Application.CancelHint;

  if FEnabled then
  begin
    if ([csLoading, csDesigning, csDestroying] * ComponentState <> []) then
      Exit;

    if GHookedHint <> nil then
    begin
      GHookedHint.Enabled := False;
      Assert(GHookedHint = nil);
    end;
    GHookedHint := Self;

    FOldHintClass   := HintWindowClass;
    HintWindowClass := GetHintClass;
  end
  else
  begin
    Assert(GHookedHint = Self);
    GHookedHint := nil;

    HintWindowClass := FOldHintClass;
    FOldHintClass   := nil; // For sure.
  end;

  oldsh                := Application.ShowHint;     // Force VCL to update
  Application.ShowHint := not Application.ShowHint; // hint.
  Application.ShowHint := oldsh;                    //
  FHookEnabled         := FEnabled;
end;

{------------------------------------------------------------------------------}
function TLMDBaseHint.RealMaxWidth: Integer;
begin
  Result := FMaxWidth;
  if Result > -1 then
    Exit;
  {$IFDEF LMDCOMP7}
  Result := Screen.WorkAreaWidth div Abs(Result);
  {$ELSE}
  Result := LMDRectWidth(LMDGetWorkSpaceRect) div Abs(Result);
  {$ENDIF}
end;


procedure TLMDBaseHint.RemoveWindow(AWindow: TLMDBaseHintWindow);
begin
  FWindows.Remove(AWindow);
  AWindow.FHintControl := nil;
end;

{ ************************* TLMDNativeHintWindow ******************************}
{-------------------------- private -------------------------------------------}
function TLMDNativeHintWindow.HintControl: TLMDNativeHint;
begin
  Result := (inherited HintControl) as TLMDNativeHint;
end;

procedure TLMDNativeHintWindow.WMShowWindow(var Message: TWMShowWindow);
begin
  if not Message.Show then
  begin
    if IsWindow(FHintWindow) then
      DestroyWindow(FHintWindow);
  end;
end;

{-------------------------- public --------------------------------------------}
procedure TLMDNativeHintWindow.ActivateHint(Rect: TRect; const AHint: string);
const
  TTS_NOPREFIX = $02;
  TTS_BALLOON  = $40;
var
  LHintInfo:          TOOLINFOW;
  LControlUnderMouse: THandle;
  LMousePos:          TPoint;
  LFlag:              Cardinal;
  maxW:               Integer;
begin
  if IsWindow(FHintWindow) then
  begin
    if AHint = Caption then
      exit
    else
      DestroyWindow(FHintWindow);
  end;

  if HintControl <> nil then
  begin
    LFlag := Ord(HintControl.IsBalloon) * TTS_BALLOON or
             Ord(not HintControl.HideAccelChar) * TTS_NOPREFIX;
    maxW  := HintControl.RealMaxWidth;
  end
  else
  begin
    LFlag := 0;
    maxW := High(Integer);
  end;

  FHintWindow := CreateWindowEx(WS_EX_TOPMOST, TOOLTIPS_CLASS, nil, WS_POPUP or
                                TTS_ALWAYSTIP or LFlag, 0, 0, 0, 0, 0, 0,
                                HInstance, nil);
  if FHintWindow <> 0 then
  begin
    FillChar(LHintInfo, Sizeof(LHintInfo), 0);
    LHintInfo.cbSize := SizeOf(TOOLINFOW);
    LHintInfo.uFlags := TTF_IDISHWND or TTF_SUBCLASS or TTF_TRACK or
                        TTF_ABSOLUTE or TTF_TRANSPARENT;
    LHintInfo.hwnd := FHintWindow;
    LHintInfo.uId := FHintWindow;
    LHintInfo.hInst := HInstance;
    LHintInfo.lpszText := PWideChar(WideString(AHint));
    SendMessage(FHintWindow, TTM_SETDELAYTIME, TTDT_INITIAL, 0);
    SendMessage(FHintWindow, TTM_SETMAXTIPWIDTH, 0, maxW);
    SendMessage(FHintWindow, TTM_ADDTOOLW, 1, TLMDPtrInt(@LHintInfo));
    GetCursorPos(LMousePos);
    LControlUnderMouse := WindowFromPoint(LMousePos);
    if LControlUnderMouse <> 0 then
    begin
      SendMessage(FHintWindow, TTM_TRACKPOSITION, 0, MakeLParam(LMousePos.X,
                  LMousePos.Y + 22));
      SendMessage(FHintWindow, TTM_TRACKACTIVATE, 1, TLMDPtrInt(@LHintInfo));
    end;
  end;

  ShowWindow(Handle, SW_SHOWNOACTIVATE);
end;

{ ****************************** TLMDNativeHint *******************************}
{----------------------------------- public -----------------------------------}
function TLMDNativeHint.GetHintClass: THintWindowClass;
begin
  Result := TLMDNativeHintWindow;
end;

{ TLMDBaseHintWindow }

constructor TLMDBaseHintWindow.Create(AOwner: TComponent);
var
  hc: TLMDBaseHint;
begin
  inherited;
  if FCreatingWith <> nil then
  begin
    hc        := FCreatingWith;
    FIsCustom := True;
  end
  else
  begin
    Assert(GHookedHint <> nil);
    hc := GHookedHint;
  end;
  hc.InsertWindow(Self);
end;

constructor TLMDBaseHintWindow.CreateCustom(AOwner: TComponent;
  AHintControl: TLMDBaseHint);
begin
  FCreatingWith := AHintControl;
  Create(AOwner);
end;

destructor TLMDBaseHintWindow.Destroy;
begin
  FHintControl.RemoveWindow(Self);
  inherited;
end;

end.
