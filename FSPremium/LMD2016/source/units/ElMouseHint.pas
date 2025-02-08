unit ElMouseHint;
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

ElMouseHint unit
----------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}
{$J+}

interface

uses
    Windows,
    Graphics,
    Forms,
    SysUtils,
    Controls,
    Classes,
    Types,

    LMDUnicodeStrings,
    LMDUtils,
    LMDHTMLUnit,
    LMDTypes,

    ElComponent,
    ElHintWnd;

type
  TElMouseHintLocation = (hlLeftTop, hlLeftCenter, hlLeftBottom,
                          hlRightTop, hlRightCenter, hlRightBottom,
                          hlCenterTop, hlCenterBottom);

  TElMousehintLocations= set of TElMouseHintLocation;

  TElMouseHint = class(TElComponent)
  private
    FHintWindow: TElHintWindow;
  protected
    FActive: Boolean;
    FAutoSize: Boolean;
    FIsHTML: Boolean;
    FOnImageNeeded: TElHTMLImageNeededEvent;
    FUseSystemHintSettings: Boolean;
    FLines: TLMDStrings;
    FWordWrap: Boolean;
    FColor: TColor;
    FWidth: Integer;
    FHeight: Integer;
    FLocation: TElMouseHintLocation;
    FFont: TFont;
    FBoundingControl: TControl;
    FVisible : boolean;
    FDistanceToHint: Integer;
    FKeepWithinWindow: Boolean;
    FHideCount : integer;
    FLocations : TElMouseHintLocations;
    FAutoAdjustLocation: Boolean;
    procedure SetActive(Value: Boolean);
    procedure SetAutoSize(Value: Boolean);
    procedure SetCaption(Value: TLMDString);
    procedure SetIsHTML(Value: Boolean);
    procedure TriggerImageNeededEvent(Sender: TObject; Src : TLMDString; var Image:TBitmap); virtual;
    procedure SetLines(Value: TLMDStrings);
    procedure LinesChange(Sender : TObject);
    function GetCaption: TLMDString;
    procedure BuildHint;
    procedure SetWordWrap(Value: Boolean);
    procedure SetColor(Value: TColor);
    function GetVisible: Boolean;
    procedure SetWidth(Value: Integer);
    procedure SetHeight(Value: Integer);
    procedure SetLocation(Value: TElMouseHintLocation);
    procedure SetFont(Value: TFont);
    procedure FontChange(Sender : TObject);
    procedure SetBoundingControl(Value: TControl);
    function GetBoundingControl: TControl;
    procedure UpdateHintPos(MousePos : TPoint; Control : TControl);
    function DoUpdatePos(MousePos : TPoint; Location: TElMouseHintLocation): TRect;
    procedure SetDistanceToHint(Value: Integer);
    procedure SetUseSystemHintSettings(Value: Boolean);
    procedure DoShowHintWindow;
    procedure DoHideHintWindow;
    procedure Notification(AComponent : TComponent; operation : TOperation);
        override;
    procedure SetKeepWithinWindow(Value: Boolean);
    procedure SetAutoAdjustLocation(Value: Boolean);
    property Locations : TElMouseHintLocations read FLocations write FLocations;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure ShowHint;
    procedure HideHint;
    procedure Loaded; override;
    procedure ShowLines(Lines : TLMDStrings);
    procedure ShowString(Caption : TLMDString);
    property Visible: Boolean read GetVisible;
  published
    property Active: Boolean read FActive write SetActive;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default true;
    property Caption: TLMDString read GetCaption write SetCaption;
    property IsHTML: Boolean read FIsHTML write SetIsHTML;
    property OnImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property UseSystemHintSettings: Boolean read FUseSystemHintSettings write
        SetUseSystemHintSettings default true;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default false;
    property Color: TColor read FColor write SetColor;
    property Width: Integer read FWidth write SetWidth;
    property Height: Integer read FHeight write SetHeight;
    property Font: TFont read FFont write SetFont;
    property Lines: TLMDStrings read FLines write SetLines stored false;
    property BoundingControl: TControl read FBoundingControl write
        SetBoundingControl;
    property DistanceToHint: Integer read FDistanceToHint write SetDistanceToHint
        default 2;
    property KeepWithinWindow: Boolean read FKeepWithinWindow write
        SetKeepWithinWindow default false;
    property AutoAdjustLocation: Boolean read FAutoAdjustLocation write
        SetAutoAdjustLocation default false;
    property Location: TElMouseHintLocation read FLocation write SetLocation
        default hlLeftTop;
  end;

implementation

uses
  LMDObjectList, ElTimers;

type
  TElMouseHintManager = class
  private
    ATimer: TElTimer;
    FList : TLMDObjectList;
    function GetCount : integer;
    procedure OnTimer(Sender : TObject);
  protected
    constructor Create;
    destructor Destroy; override;
    procedure AddHint(AHint : TElMouseHint);
    procedure RemoveHint(AHint : TElMouseHint);

    property Count : integer read GetCount;
  public
    procedure UpdateAllHints(MousePos : TPoint; Control : TControl);
  end;

const
  Manager: TElMouseHintManager = nil;

var
  FHook : HHOOK;

function MouseHook(nCode: integer; wParam: WParam; lParam: LParam): LResult; stdcall;
var C : TControl;
    P : TPoint;
begin
  if Manager <> nil then
  begin
    GetCursorPos(P);
    C := FindDragTarget(P, true);
    Manager.UpdateAllHints(P, C);
  end;
  result := CallNextHookEx(FHook, nCode, wParam, lParam);
end;

constructor TElMouseHintManager.Create;
begin
  inherited;
  FList := TLMDObjectList.Create;
  FHook := SetWindowsHookEx(WH_MOUSE, @MouseHook, 0, GetCurrentThreadId());
  ATimer := TElTimer.Create;
  ATimer.OnTimer := OnTimer;
  ATimer.Interval := 200;
  ATimer.Enabled := true;
end;

destructor TElMouseHintManager.Destroy;
begin
  ATimer.Free;
  FList.Free;
  UnhookWindowsHookEx(FHook);
  inherited;
end;

function TElMouseHintManager.GetCount : integer;
begin
  result := FList.Count;
end;

procedure TElMouseHintManager.AddHint(AHint : TElMouseHint);
begin
  FList.Add(AHint);
end;

procedure TElMouseHintManager.RemoveHint(AHint : TElMouseHint);
begin
  FList.Remove(AHint);
end;

procedure TElMouseHintManager.OnTimer(Sender : TObject);
var P : TPoint;
    C : TControl;
begin
  GetCursorPos(P);
  C := FindDragTarget(P, true);
  if C = nil then
    UpdateAllHints(P, C);
end;

procedure TElMouseHintManager.UpdateAllHints(MousePos: TPoint; Control: TControl);

//  function IsChildComponent(AParent, AChild: TComponent): Boolean;
//  var
//    i: Integer;
//  begin
//    Result := False;
//    for i := 0 to AParent.ComponentCount - 1 do
//      if AParent.Components[i] = AChild then
//      begin
//        Result := True;
//        break;
//      end;
//  end;

var
  i : integer;
begin
  for i := 0 to FList.Count - 1 do
  begin
    if TElMouseHint(FList[i]).Active then
    begin
      if (Assigned(TElMouseHint(FList[i]).BoundingControl)) and ((TElMouseHint(FList[i]).BoundingControl <> Control) {or (IsChildComponent(TElMouseHint(FList[i]).BoundingControl, Control))}) then
        TElMouseHint(FList[i]).UpdateHintPos(MousePos, nil)
      else
        TElMouseHint(FList[i]).UpdateHintPos(MousePos, Control);
    end;
  end;
end;

procedure TElMouseHint.SetActive(Value: Boolean);
var
  P : TPoint;
  R: TRect;
begin
  if FActive <> Value then
  begin
    FActive := Value;
    if not FActive then
      HideHint
    else
      if (ComponentState * [{csDesigning, }csLoading, csReading] = []) then
      begin
        FHintWindow.Visible := False;
        BuildHint;
        GetCursorPos(P);
        FVisible := true;
        Locations := [];
        R := DoUpdatePos(P, Location);
        FHintWindow.Left := R.Left;
        FHintWindow.Top := R.Top;
      end;
  end;
end;

procedure TElMouseHint.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    if Active and (ComponentState * [{csDesigning, }csLoading, csReading] = []) then
      BuildHint;
  end;
end;

procedure TElMouseHint.SetCaption(Value: TLMDString);
begin
  FLines.Text := Value;
end;

procedure TElMouseHint.SetIsHTML(Value: Boolean);
begin
  if FIsHTML <> Value then
  begin
    FIsHTML := Value;
    if Active and (ComponentState * [{csDesigning, }csLoading, csReading] = []) then
      BuildHint;
  end;
end;

constructor TElMouseHint.Create(AOwner : TComponent);
begin
  inherited;
  FLines := TLMDMemoryStrings.Create;
  TLMDMemoryStrings(FLines).OnChange := LinesChange;
  FUseSystemHintSettings := true;
  FFont := TFont.Create;
  FFont.OnChange := FontChange;
  FDistanceToHint := 2;
  FAutoSize := true;
  FLocation := hlLeftTop;
  FHintWindow := TElHintWindow.Create(nil);
  FHintWindow.OnImageNeeded := TriggerImageNeededEvent;
  // this must be the last
  if Manager = nil then
    Manager := TElMouseHintManager.Create;
  Manager.AddHint(Self);
end;

destructor TElMouseHint.Destroy;
begin
  // this must be the first
  Manager.RemoveHint(Self);
  if Manager.Count = 0 then
  begin
    Manager.Free;
    Manager := nil;
  end;
  DoHideHintWindow;
  FHintWindow.Free;
  inherited;
  FLines.Free;
  FFont.Free;
end;

procedure TElMouseHint.TriggerImageNeededEvent(Sender: TObject; Src : TLMDString; var Image : TBitmap);
begin
  if assigned(FOnImageNeeded) then
   FOnImageNeeded(Self, Src, Image);
end;

procedure TElMouseHint.SetLines(Value: TLMDStrings);
begin
  FLines.Assign(Value);
end;

procedure TElMouseHint.LinesChange(Sender : TObject);
begin
  if Active and (ComponentState * [{csDesigning, }csLoading, csReading] = []) then
    BuildHint;
end;

function TElMouseHint.GetCaption: TLMDString;
begin
  Result := Lines.Text;
end;

procedure TElMouseHint.BuildHint;
var
  R : TRect;
  b : boolean;
  P : TPoint;
  NonClientMetrics: TNonClientMetrics;
  s : TLMDString;
begin
  b := FHintWindow.Visible;
  FHintWindow.Visible := false;
  if UseSystemHintSettings then
  begin
    FHintWindow.Color := TElHintWindow.GetThemedHintColor;

    {$IFDEF LMDCOMP14}
    NonClientMetrics.cbSize := TNonClientMetrics.SizeOf;
    {$ELSE}
    NonClientMetrics.cbSize := SizeOf(TNonClientMetrics);
    {$ENDIF}
    SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0);
    FHintWindow.Font.Name := NonClientMetrics.lfStatusFont.lfFaceName;
    FHintWindow.Font.Height := NonClientMetrics.lfStatusFont.lfHeight;
    FHintWindow.Font.Style := [];
    FHintWindow.Font.Charset := NonClientMetrics.lfStatusFont.lfCharSet;
    if NonClientMetrics.lfStatusFont.lfItalic <> 0 then
      FHintWindow.Font.Style := FHintWindow.Font.Style + [fsItalic];
    if NonClientMetrics.lfStatusFont.lfUnderline <> 0 then
      FHintWindow.Font.Style := FHintWindow.Font.Style + [fsUnderline];
    if NonClientMetrics.lfStatusFont.lfStrikeOut <> 0 then
      FHintWindow.Font.Style := FHintWindow.Font.Style + [fsStrikeout];
    if NonClientMetrics.lfStatusFont.lfWeight >= 700 then
      FHintWindow.Font.Style := FHintWindow.Font.Style + [fsBold];
  end
  else
  begin
    FHintWindow.Color := Color;
    FHintWindow.Font := Font;
  end;
  FHintWindow.IsHTML := IsHTML;
  FHintWindow.WordWrap := WordWrap;
  FHintWindow.MaxWidth := Width;

  s := Caption;
  if (length(s) > 1) and
     (Copy(s, length(s) - 1, 2) = #13#10) then
    s := Copy(s, 1, length(s) - 2);

  if AutoSize then
  begin
    if WordWrap then
      {$ifdef LMD_UNICODE}
      R := FHintWindow.CalcHintRectW(Width, s, nil)
      {$else}
      R := FHintWindow.CalcHintRect(Width, s, nil)
      {$endif}
    else
    begin
      {$ifdef LMD_UNICODE}
      R := FHintWindow.CalcHintRectW(Screen.Width, s, nil);
      {$else}
      R := FHintWindow.CalcHintRect(Screen.Width, s, nil);
      {$endif}
      if R.Right - R.Left > FHintWindow.MaxWidth then
        FHintWindow.MaxWidth := R.Right - R.Left;
    end;
  end
  else
  begin
    if (Height = 0) or (Width = 0) then
    begin
      {$ifdef LMD_UNICODE}
        R := FHintWindow.CalcHintRectW(Width, s, nil);
      {$else}
        R := FHintWindow.CalcHintRect(Width, s, nil);
      {$endif}
       if (Height = 0) then
         Height := R.Bottom;
       if (Width = 0) then
         Width := R.Right;
       FHintWindow.MaxWidth := Width;
    end;
    R := Classes.Rect(0, 0, Width, Height);
//    R := Classes.Rect(0, 0, Width, R.Bottom);
  end;
  Inc(R.Bottom, 4);
  {$ifdef LMD_UNICODE}
  FHintWindow.WideCaption := s;
  {$else}
  FHintWindow.Caption := s;
  {$endif}
  FHintWindow.Width := R.Right - R.Left;
  FHintWindow.Height := R.Bottom - R.Top;
  GetCursorPos(P);
  Locations := [];
  DoUpdatePos(P, Location);

  if (ComponentState * [{csDesigning, }csLoading, csReading] = []) then
    if b then
      DoShowHintWindow
    //else
    //  DoHideHintWindow;
end;

procedure TElMouseHint.SetWordWrap(Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    if Active and (ComponentState * [{csDesigning, }csLoading, csReading] = []) then
      BuildHint;
  end;
end;

procedure TElMouseHint.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    if Active and (ComponentState * [{csDesigning, }csLoading, csReading] = [])
      and (not UseSystemHintSettings) then
      if Visible then
        FHintWindow.Invalidate;
  end;
end;

function TElMouseHint.GetVisible: Boolean;
begin
  result := FVisible;
end;

procedure TElMouseHint.SetWidth(Value: Integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    if (not AutoSize) and Visible and (ComponentState * [{csDesigning, }csLoading, csReading] = []) then
      BuildHint;
  end;
end;

procedure TElMouseHint.SetHeight(Value: Integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    if (not AutoSize) and Visible and (ComponentState * [{csDesigning, }csLoading, csReading] = []) then
      BuildHint;
  end;
end;

procedure TElMouseHint.SetLocation(Value: TElMouseHintLocation);
var P : TPoint;
begin
  if FLocation <> Value then
  begin
    FLocation := Value;
    if Active and (ComponentState * [{csDesigning, }csLoading, csReading] = []) and Visible then
    begin
      GetCursorPos(P);
      Locations := [];
      DoUpdatePos(P, Location);
    end;
  end;
end;

procedure TElMouseHint.ShowHint;
var P : TPoint;
begin
  if not Visible then
  begin
    FActive := true;
    BuildHint;
    GetCursorPos(P);
    FVisible := true;
    Locations := [];
    DoUpdatePos(P, Location);
    DoShowHintWindow;
  end;
end;

procedure TElMouseHint.HideHint;
begin
//  if Active then
    DoHideHintWindow;
  FVisible := false;
  FActive := false;
end;

procedure TElMouseHint.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TElMouseHint.FontChange(Sender : TObject);
begin
  if Active and (not UseSystemHintSettings) then
    BuildHint;
end;

procedure TElMouseHint.SetBoundingControl(Value: TControl);
var P : TPoint;
begin
  if FBoundingControl <> Value then
  begin
    FBoundingControl := Value;
    GetCursorPos(P);
    if (not AutoSize) and Visible and (ComponentState * [{csDesigning, }csLoading, csReading] = []) then
      UpdateHintPos(P, FindDragTarget(P, true));
  end;
end;

function TElMouseHint.GetBoundingControl: TControl;
begin
  if BoundingControl = nil then
  begin
    result := LMDGetOwnerForm(Self);
    while result.Parent <> nil do
      result := result.Parent;
  end
  else
    result := BoundingControl;
end;

procedure TElMouseHint.UpdateHintPos(MousePos : TPoint; Control : TControl);
var AParent,
    ABound : TControl;
    IsVis  : boolean;

begin
  if (not FVisible) (*or (csDesigning in ComponentState) *)then exit;

  if (Control = nil) then
  begin
    DoHideHintWindow
  end
  else
  begin
    ABound := GetBoundingControl;
    AParent := Control;
    IsVis := false;
    while AParent <> nil do
    begin
      if AParent = ABound then
      begin
        IsVis := true;
        break;
      end;
      if AParent.Parent = nil then
      begin
        if ((ABound is TForm) and (TForm(ABound).FormStyle = fsMDIForm)) and
           ((AParent is TForm) and (TForm(AParent).FormStyle = fsMDIChild)) then
        begin
          IsVis := true;
          break;
        end;
      end;
      AParent := AParent.Parent;
    end;
    if IsVis <> FHintWindow.Visible then
    begin
      if not IsVis then
      begin
        FHintWindow.Visible := false;
        // DoHideHintWindow;
      end
      else
      begin
        Locations := [];
        DoUpdatePos(MousePos, Location);
        DoShowHintWindow;
        // FHintWindow.Visible := true;
      end;
    end
    else
    begin
      Locations := [];
      DoUpdatePos(MousePos, Location);
      with FHintWindow do
        SetWindowPos(FHintWindow.Handle, HWND_TOPMOST, Left, Top, Width, Height,
          SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW or SWP_NOACTIVATE);
    end;
  end;
end;

procedure SetRect(var rect : TRect; Left, Top, Width, Height : integer);
begin
  Rect.Left := Left;
  Rect.Top := Top;
  Rect.Right := Left + Width;
  Rect.Bottom := Top + Height;
end;

function TElMouseHint.DoUpdatePos(MousePos : TPoint; Location:
    TElMouseHintLocation): TRect;
var Ctl : TControl;
    R   : TRect;
    NewLocation : TElMouseHintLocation;
begin
  inc(FHideCount);

  (*
  if Location = Self.Location then
    FLocations := []
  else
  *)
  Include(FLocations, Location);

  try
    Ctl := GetBoundingControl;

    if KeepWithinWindow and (Ctl <> nil) then
      MousePos := Ctl.ScreenToClient(MousePos);

    case Location of
      hlLeftTop: SetRect(result, MousePos.X - FHintWindow.Width - DistanceToHint,
                                       MousePos.Y - FHintWindow.Height - DistanceToHint,
                                       FHintWindow.Width,
                                       FHintWindow.Height);
      hlLeftCenter: SetRect(result, MousePos.X - FHintWindow.Width - DistanceToHint,
                                          MousePos.Y - FHintWindow.Height div 2,
                                          FHintWindow.Width,
                                          FHintWindow.Height);
      hlLeftBottom: SetRect(result, MousePos.X - FHintWindow.Width - DistanceToHint,
                                           MousePos.Y + DistanceToHint,
                                           FHintWindow.Width,
                                           FHintWindow.Height);

      hlRightTop: SetRect(result, MousePos.X + DistanceToHint,
                                         MousePos.Y - FHintWindow.Height - DistanceToHint,
                                         FHintWindow.Width,
                                         FHintWindow.Height);
      hlRightCenter: SetRect(result, MousePos.X + DistanceToHint,
                                            MousePos.Y - FHintWindow.Height div 2,
                                            FHintWindow.Width,
                                            FHintWindow.Height);
      hlRightBottom: SetRect(result, MousePos.X + DistanceToHint,
                                           MousePos.Y + DistanceToHint,
                                           FHintWindow.Width,
                                           FHintWindow.Height);

      hlCenterTop: SetRect(result, MousePos.X - FHintWindow.Width div 2,
                                         MousePos.Y - FHintWindow.Height - DistanceToHint,
                                         FHintWindow.Width,
                                         FHintWindow.Height);
      hlCenterBottom: SetRect(result, MousePos.X - FHintWindow.Width div 2,
                                             MousePos.Y + DistanceToHint,
                                             FHintWindow.Width,
                                             FHintWindow.Height);
    end;
    if KeepWithinWindow and AutoAdjustLocation then
    begin
      R := Result;
      begin
        // check upper bounds
        if R.Top < 0 then
        begin
          case Location of
            hlLeftTop,
            hlLeftCenter: NewLocation := hlLeftBottom;

            hlCenterTop: NewLocation := hlCenterBottom;

            hlRightTop,
            hlRightCenter: NewLocation := hlRightBottom;
            else
              exit;
          end;
          if Ctl <> nil then
            MousePos := Ctl.ClientToScreen(MousePos);
          if (NewLocation = Self.Location) or ((NewLocation <> Self.Location) and (not (NewLocation in FLocations))) then
            Result := DoUpdatePos(MousePos, NewLocation);
          if Ctl <> nil then
            MousePos := Ctl.ScreenToClient(MousePos);
          R := Result;
        end;
        // check lower bounds
        if R.Bottom > Ctl.ClientHeight then
        begin
          case Location of
            hlLeftBottom,
            hlLeftCenter: NewLocation := hlLeftTop;

            hlCenterBottom: NewLocation := hlCenterTop;

            hlRightBottom,
            hlRightCenter: NewLocation := hlRightTop;
            else
              exit;
          end;
          if Ctl <> nil then
            MousePos := Ctl.ClientToScreen(MousePos);
          if (NewLocation = Self.Location) or ((NewLocation <> Self.Location) and (not (NewLocation in FLocations))) then
            Result := DoUpdatePos(MousePos, NewLocation);
          if Ctl <> nil then
            MousePos := Ctl.ScreenToClient(MousePos);

          R := Result;
        end;
        // check left bounds
        if R.Left < 0 then
        begin
          case Location of
            hlLeftTop,
            hlCenterTop   : NewLocation := hlRightTop;
            hlLeftCenter  : NewLocation := hlRightCenter;
            hlLeftBottom,
            hlCenterBottom: NewLocation := hlRightBottom;
            else
              exit;
          end;
          if Ctl <> nil then
            MousePos := Ctl.ClientToScreen(MousePos);
          if (NewLocation = Self.Location) or ((NewLocation <> Self.Location) and (not (NewLocation in FLocations))) then
            Result := DoUpdatePos(MousePos, NewLocation);
          if Ctl <> nil then
            MousePos := Ctl.ScreenToClient(MousePos);

          R := Result;
        end;
        // check left bounds
        if R.Right > Ctl.ClientWidth then
        begin
          case Location of
            hlRightTop,
            hlCenterTop   : NewLocation := hlLeftTop;
            hlRightCenter  : NewLocation := hlLeftCenter;
            hlRightBottom,
            hlCenterBottom: NewLocation := hlLeftBottom;
            else
              exit;
          end;
          if Ctl <> nil then
            MousePos := Ctl.ClientToScreen(MousePos);
          if (NewLocation = Self.Location) or ((NewLocation <> Self.Location) and (not (NewLocation in FLocations))) then
            Result := DoUpdatePos(MousePos, NewLocation);
          if Ctl <> nil then
            MousePos := Ctl.ScreenToClient(MousePos);
        end;
      end;
    end;
  finally
    dec(FHideCount);
    if FHideCount = 0 then
    begin
      if FHintWindow.Visible then
      begin
        if not EqualRect(Result, FHintWindow.BoundsRect) then
        begin
          //R := FHintWindow.BoundsRect;
          //LMDDebug(PChar('SetWindowPos at ' + IntToStr(GetTickCount) +
            //Format(':'#13#10'X: %d'#13#10'Y: %d', [Result.Left, Result.Top])
         //   Format(': from ((%d, %d), (%d, %d)) to ((%d, %d), (%d, %d))', [R.Left, R.Top, R.Right, R.Bottom, Result.Left, Result.Top, Result.Right, Result.Bottom])
         //   ));
          //R.TopLeft := FHintWindow.ClientToScreen(R.TopLeft);
          //R.BottomRight := FHintWindow.ClientToScreen(R.BottomRight);
          //with FHintWindow do

          with Result do
           SetWindowPos(FHintWindow.Handle, HWND_TOP, Left, Top, Right - Left, Bottom - Top, SWP_SHOWWINDOW or SWP_NOACTIVATE);
        end;
      end;
    end;
  end;
  if Location <> Self.Location then
    Exclude(FLocations, Location);
end;

procedure TElMouseHint.SetDistanceToHint(Value: Integer);
var P : TPoint;
begin
  if FDistanceToHint <> Value then
  begin
    FDistanceToHint := Value;
    if Visible and Active and (ComponentState * [{csDesigning, }csLoading, csReading] = []) then
    begin
      GetCursorPos(P);
      Locations := [];
      DoUpdatePos(P, Location);
    end;
  end;
end;

procedure TElMouseHint.SetUseSystemHintSettings(Value: Boolean);
begin
  if FUseSystemHintSettings <> Value then
  begin
    FUseSystemHintSettings := Value;
    if Active and (ComponentState * [{csDesigning, }csLoading, csReading] = []) then
      BuildHint;
  end;
end;

procedure TElMouseHint.DoShowHintWindow;
var Ctl : TControl;
//    FWnd: HWND;
begin
  // FWnd := GetActiveWindow();

  if KeepWithinWindow then
  begin
    Ctl := GetBoundingControl;
    if Ctl is TWinControl then
      FHintWindow.ParentWindow := (Ctl as TWinControl).Handle
    else
      FHintWindow.ParentWindow := Ctl.Parent.Handle;
    SetParent(FHintWindow.Handle, FHintWindow.ParentWindow);
  end
  else
    FHintWindow.ParentWindow := GetDesktopWindow;
  with FHintWindow do
    SetWindowPos(FHintWindow.Handle, HWND_TOPMOST, Left, Top, Width, Height,
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
  FHintWindow.Visible := true;
  (*
  if (GetCurrentThreadID() = GetWindowThreadProcessID(FWnd, nil)) and
     (not (csDesigning in ComponentState)) then
    SetActiveWindow(FWnd);
  *)
end;

procedure TElMouseHint.DoHideHintWindow;
begin
  if FHintWindow.HandleAllocated then
  begin
    FHintWindow.Visible := false;
    ShowWindow(FHintWindow.Handle, SW_HIDE);
  end;
end;

procedure TElMouseHint.Notification(AComponent : TComponent; operation :
    TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
  begin
    if AComponent = BoundingControl then
    begin
      BoundingControl := nil;
    end;
  end; { if }
end; { Notification }

procedure TElMouseHint.SetKeepWithinWindow(Value: Boolean);
var P : TPoint;
begin
  if FKeepWithinWindow <> Value then
  begin
    FKeepWithinWindow := Value;
    if Active and Visible and (ComponentState * [{csDesigning, }csLoading, csReading] = []) then
    begin
      GetCursorPos(P);
      Locations := [];
      DoUpdatePos(P, Location);
      DoShowHintWindow;
    end;
  end;
end;

procedure TElMouseHint.Loaded;
var
  P : TPoint;
  R: TRect;
begin
  inherited;
  if Active and (ComponentState * [{csDesigning, }csLoading, csReading] = []) then
  begin
    BuildHint;
    GetCursorPos(P);
    FVisible := true;
    Locations := [];
    R := DoUpdatePos(P, Location);
    FHintWindow.Left := R.Left;
    FHintWindow.Top := R.Top;
  end;
end;

procedure TElMouseHint.ShowLines(Lines : TLMDStrings);
begin
  FLines.Assign(Lines);
  Active := true;
end;

procedure TElMouseHint.ShowString(Caption : TLMDString);
begin
  SetCaption(Caption);
  Active := true;
end;

procedure TElMouseHint.SetAutoAdjustLocation(Value: Boolean);
var P : TPoint;
begin
  if FAutoAdjustLocation <> Value then
  begin
    FAutoAdjustLocation := Value;
    if Active and Visible then
    begin
      GetCursorPos(P);
      Locations := [];
      DoUpdatePos(P, Location);
    end;
  end;
end;

end.
