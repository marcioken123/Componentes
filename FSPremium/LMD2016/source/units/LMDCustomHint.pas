unit LMDCustomHint;
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

LMDCustomHint unit (RM)
-----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Graphics, Controls, Messages,
  {$ifdef LMD_ELUNISCRIBE} LMDUsp10, LMDUnicodeStrings, {$ENDIF}
  LMDGraph, LMD3DCaption, LMDBevel, LMDNativeHint, LMDTypes, LMDHTMLUnit;

type
  {--------------------------- class TLMDHintBevel ----------------------------}
  TLMDHintBevel = class(TLMDBevel)
  public
   constructor Create(AOwner: TPersistent = nil); override;
  published
    property Mode default bmCustom;
    property StyleOuter default bvLowered;
  end;

  {------------------- class TLMDCustomHint -----------------------------------}
  TLMDCustomHint = class(TLMDBaseHint)
  private
    FColor:   TColor;
    FFont:    TFont;
    FFont3D:  TLMD3DCaption;
    FBevel:   TLMDHintBevel;
    FUseFont: Boolean;

    procedure SetBevel(aValue:TLMDHintBevel);
    procedure SetFont3d(aValue:TLMD3DCaption);
    procedure SetFont(aValue:TFont);
    function  IsCustomFont:Boolean;
  protected
    function GetHintClass: THintWindowClass; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    procedure Assign(Source: TPersistent);override;
    function  GetHintFont: TFont;
    procedure ShowHint(const Msg: string; x, y: integer; ms:Word);
    procedure ShowControlHint(const Msg:string; aControl:TControl; ms:Word);
    property  Bevel: TLMDHintBevel read FBevel write SetBevel;
    property  Color: TColor read FColor write FColor default clInfoBk;
    property  Font3D: TLMD3DCaption read FFont3D write SetFont3D;
  published
    property MaxWidth;
    property Font:TFont read FFont write SetFont stored IsCustomFont;
    property UseScreenHintFont:Boolean read FUseFont write FUseFont default true;
  end;

  { *************************** TLMDCustomHintWindow **************************}

  TLMDCustomHintWindow = class(TLMDBaseHintWindow)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DrawTextTo(Canvas : TCanvas; Caption : String; TextRect : TRect); virtual;
    procedure GetTextSize(Caption : String; var aRect : TRect); virtual;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure   ActivateHint(Rect: TRect; const AHint: string); override;
    function    HintControl: TLMDCustomHint;
  end;

  {----------------------- class TLMDCustomHTMLHint ---------------------------}

  TLMDCustomHTMLHint = class(TLMDCustomHint)
  private
    FOnShow,
    FOnHide:           TNotifyEvent;
    FOnImageNeeded:    TElHTMLImageNeededEvent;
    FOnImageNeededEx:  TLMDHTMLImageNeededEvent;
    FOnVariableNeeded: TLMDHTMLVariableNeededEvent;
    FOnLinkClick:      TLMDHTMLLinkClickEvent;
  protected
    function  GetHintClass: THintWindowClass; override;
    procedure DoShow(Sender: THintWindow); virtual;
    procedure DoHide(Sender: THintWindow); virtual;
    procedure SetOnHide(Value: TNotifyEvent);
    procedure SetOnShow(Value: TNotifyEvent);
    procedure SetOnImageNeeded(Value: TElHTMLImageNeededEvent);
    procedure SetOnImageNeededEx(Value: TLMDHTMLImageNeededEvent);
    procedure SetOnLinkClick(Value: TLMDHTMLLinkClickEvent);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  published
    property OnShow: TNotifyEvent read FOnShow write SetOnShow;
    property OnHide: TNotifyEvent read FOnHide write SetOnHide;
    property OnImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write SetOnImageNeeded;
    property OnImageNeededEx: TLMDHTMLImageNeededEvent read FOnImageNeededEx write SetOnImageNeededEx;
    property OnLinkClick: TLMDHTMLLinkClickEvent read FOnLinkClick write SetOnLinkClick;
    property OnVariableNeeded: TLMDHTMLVariableNeededEvent read FOnVariableNeeded write FOnVariableNeeded;
  end;

  { ************************ TLMDCustomHTMLHintWindow *************************}

  TLMDCustomHTMLHintWindow = class(TLMDBaseHintWindow)
  protected
    FCursor: TCursor;
    FWordWrap: Boolean;
    {$ifdef LMD_UNICODE}
    {$ifdef LMD_ELUNISCRIBE}
    FUniscribeString: TLMDUniscribeStrings;
    {$endif}
    {$endif}
    FFont : TFont;
    FActivating : boolean;
    FMaxWidth: Integer;
    {$ifdef LMD_UNICODE}
    FWideCaption : WideString;
    {$endif}

    FRender : TLMDHTMLRender;
    FTextRect: TRect;
    FIsHTML : Boolean;

    procedure SetFont(newValue : TFont);
    procedure CreateParams(var Params: TCreateParams); override;

    procedure OnShow; virtual;
    procedure OnHide; virtual;

    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMShowWindow(var Message: TWMShowWindow); message WM_SHOWWINDOW;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;

    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure SetupRightCaption(ACaption: string);

    procedure TriggerLinkClickEvent(HRef : TLMDString); virtual;

    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure SetWordWrap(Value: Boolean);
    procedure DrawTextTo(ACanvas : TCanvas; ACaption : TLMDString; TextRect : TRect); virtual;
    procedure GetTextSize (ACaption : TLMDString; var aRect : TRect); virtual;

    procedure AdjustHintRect(var aRect: TRect); virtual;
    procedure InitRenderData; virtual;

    procedure SetIsHTML(aValue: boolean);
    procedure SetHintWindowSize;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    function  HintControl: TLMDCustomHTMLHint;
    procedure ActivateHint(Rect: TRect; const AHint: string); override;
    function  CalcHintRect(MaxWidth: Integer; const AHint: string; AData: TLMDDataTag): TRect; override;

    {$ifdef LMD_UNICODE}
    function CalcHintRectW(MaxWidth: Integer; const AHint: WideString; AData: Pointer): TRect;
    procedure ActivateHintW(Rect: TRect; const AHint: WideString); virtual;
    {$endif}
    property MaxWidth: Integer read FMaxWidth write FMaxWidth;
    property Canvas;
  published
    property Font : TFont read FFont write SetFont;  { Published }
    property WordWrap: Boolean read FWordWrap write SetWordWrap default false; //***??? remove ???
    {$ifdef LMD_UNICODE}
    property WideCaption : WideString read FWideCaption write FWideCaption;
    {$endif}

    property IsHTML: boolean read FIsHTML write SetIsHTML;
  end;  { TLMDCustomHTMLHintWindow }

implementation

uses
  Forms, SysUtils, Types,
  LMDGraphUtils, LMDProcs, LMDUtils, LMDSysIn;

const
  WrapFlags: array[boolean] of Integer = (0, DT_WORDBREAK);
  HTMLRectDelta = 0;

{ **************************** TLMDHintBevel **********************************}
{-------------------------------- public --------------------------------------}
constructor TLMDHintBevel.Create(AOwner: TPersistent);
begin
  inherited;
  StyleOuter:=bvLowered;
end;

{************************* Class TLMDCustomHint *******************************}
{---------------------------- Private -----------------------------------------}
procedure TLMDCustomHint.SetBevel(aValue:TLMDHintBevel);
begin
  FBevel.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHint.SetFont(aValue:TFont);
begin
  FFont.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHint.SetFont3D(aValue:TLMD3DCaption);
begin
  FFont3D.Assign(aValue);
end;

{------------------------------------------------------------------------------}
function TLMDCustomHint.IsCustomFont: Boolean;
begin
  result := UseScreenHintFont <> true;
end;

{--------------------------- Public -------------------------------------------}
procedure TLMDCustomHint.Assign(Source: TPersistent);
begin
  inherited;
  if Assigned(Source) and  (Source is TLMDCustomHint) then
    begin
      Bevel.Assign(TLMDCustomHint(Source).Bevel);
      Color := TLMDCustomHint(Source).Color;
      Font3D.Assign(TLMDCustomHint(Source).Font3D);
      MaxWidth := TLMDCustomHint(Source).MaxWidth;
      Font.Assign(TLMDCustomHint(Source).Font);
      UseScreenHintFont := TLMDCustomHint(Source).UseScreenHintFont;
    end;
end;

{------------------------------------------------------------------------------}
constructor TLMDCustomHint.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);

  FFont:=TFont.Create;
  FFont.Name:='MS Sans Serif';
  FFont.Size:=8;

  FFont3D:=TLMD3DCaption.Create;
  FFont.Color:=clInfoText;
  FColor:=clInfoBK;

  FUseFont := True;
  FBevel   := TLMDHintBevel.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomHint.Destroy;
begin
  FreeAndNil(FBevel);
  FreeAndNil(FFont);
  FreeAndNil(FFont3D);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDCustomHint.GetHintClass: THintWindowClass;
begin
  Result := TLMDCustomHintWindow;
end;

function TLMDCustomHint.GetHintFont: TFont;
begin
  if UseScreenHintFont then
    result := Screen.HintFont
  else
    result := FFont;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHint.ShowHint(const Msg:string; x, y: integer; ms:Word);
var
  wnd: THintWindow;
begin
  wnd := GetHintClass.Create(Self);
  try
    wnd.ActivateHint(Rect(x, y, -1, -1), Msg);
    LMDWait(ms);
  finally
    FreeAndNil(wnd);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHint.ShowControlHint(const Msg:string; aControl:TControl; ms:Word);
var
  x,y:Integer;
begin
  if not Assigned(aControl) then exit;
  if (aControl.Visible) and (aControl.Parent<>nil) then
    with aControl do
      begin
        x:=Parent.ClientToScreen(Point(Left, Top)).X+ (Width Div 2);
        y:=Parent.ClientToScreen(Point(Left, Top)).Y+ (Height Div 2);
        if msg='' then
          Self.ShowHint(aControl.Hint, x,y, ms)
        else
          self.ShowHint(msg, x,y, ms);
      end
end;

{************************* Class TLMDCustomHTMLHint ***************************}
{---------------------------- Private -----------------------------------------}
procedure TLMDCustomHTMLHint.SetOnHide(Value: TNotifyEvent);
begin
  FOnHide := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHint.SetOnImageNeeded(Value: TElHTMLImageNeededEvent);
begin
  FOnImageNeeded := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHint.SetOnImageNeededEx(Value: TLMDHTMLImageNeededEvent);
begin
  FOnImageNeededEx := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHint.SetOnLinkClick(Value : TLMDHTMLLinkClickEvent);
begin
  FOnLinkClick := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHint.SetOnShow(Value: TNotifyEvent);
begin
  FOnShow := Value;
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDCustomHTMLHint.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomHTMLHint.Destroy;
begin
  FreeAndNil(FBevel);
  FreeAndNil(FFont);
  FreeAndNil(FFont3D);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHint.DoHide(Sender: THintWindow);
begin
  if Assigned(OnHide) then
    OnHide(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHint.DoShow(Sender: THintWindow);
begin
  if Assigned(OnShow) then
    OnShow(Sender);
end;

function TLMDCustomHTMLHint.GetHintClass: THintWindowClass;
begin
  Result := TLMDCustomHTMLHintWindow;
end;

{ ******************* TLMDCustomHintWindow *********************************** }
{--------------------------- Protected ----------------------------------------}
procedure TLMDCustomHintWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    begin
      Style:=WS_POPUP or WS_DISABLED;
      // LMD-Tools 6.0
      if LMDSIWindowsXPUp then
        WindowClass.Style := WindowClass.Style or $00020000;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHintWindow.DrawTextTo(Canvas: TCanvas;
  Caption: string; TextRect: TRect);
var
  flags:   LongInt;
  LCaller: TLMDCustomHint;
begin
  LCaller := HintControl;
  if not Assigned(LCaller) then exit;
  flags:=0;
  flags:=DrawTextBiDiModeFlags(flags);
  if LCaller.HideAccelChar  then
    flags := flags or DT_NOPREFIX;
  LMDDrawTextExt(Canvas, Caption, LCaller.Font3D, TextRect,
                 DT_LEFT or DT_WORDBREAK or flags,
                 [TLMDDrawTextStyle(Enabled)], nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHintWindow.GetTextSize (Caption : String; var aRect : TRect);
var
  flags : LongInt;
  LCaller: TLMDCustomHint;
begin
  LCaller := HintControl;
  if not Assigned(LCaller) then exit;
  flags:=0;
  flags:=DrawTextBiDiModeFlags(flags);
  if LCaller.HideAccelChar  then
    flags := flags or DT_NOPREFIX;
  LMDDrawTextCalc(Caption, LCaller.Font3D, aRect, LCaller.GetHintFont, true, false, LCaller.Bevel.BevelExtend, flags);
end;

function TLMDCustomHintWindow.HintControl: TLMDCustomHint;
begin
  Result := (inherited HintControl) as TLMDCustomHint;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHintWindow.Paint;
var
  R:       TRect;
  LCaller: TLMDCustomHint;
begin
  LCaller := HintControl;
  if (LCaller <> nil) then
  begin
    R := LCaller.Bevel.PaintBevel(Canvas, GetClientRect, True);
    Inc(R.Left, 2);
    Inc(R.Top, 2);
    Canvas.Brush.Color := LCaller.Color;
    Canvas.Font        := LCaller.GetHintFont;

    DrawTextTo(Canvas, Caption, R);
    Exit;
  end;
  inherited Paint;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDCustomHintWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Canvas.Brush.Style:=bsClear;
end;

{------------------------- Public ---------------------------------------------}
procedure TLMDCustomHintWindow.ActivateHint(Rect: TRect; const AHint: string);
var
  temp:TRect;
  FCaller : TLMDCustomHint;
begin
  FCaller := HintControl;
  if FCaller<>nil then
  begin
    Color:=FCaller.Color;
    temp:=Bounds(0, 0 , FCaller.RealMaxWidth, 0);
    GetTextSize(AHint, temp);
    OffsetRect(temp, Rect.Left, Rect.Top);
    Inc(temp.Right, 6);
    Inc(temp.Bottom, 2);
    Rect:=temp;
  end;

  inherited ActivateHint(Rect, AHint);
end;

{ ******************* TLMDCustomHTMLHintWindow ******************************* }
procedure TLMDCustomHTMLHintWindow.OnShow;
var
  LCaller: TLMDCustomHTMLHint;
begin
  FCursor := Screen.Cursor;
  LCaller := TLMDCustomHTMLHint(HintControl);
  if Assigned(LCaller) then
    LCaller.DoShow(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHintWindow.OnHide;
var
  LCaller: TLMDCustomHTMLHint;
begin
  Screen.Cursor := FCursor;
  LCaller := HintControl;
  if Assigned(LCaller) then
    LCaller.DoHide(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHintWindow.WMShowWindow(var Message: TWMShowWindow);
begin
  if Message.Show then
    OnShow
  else
    OnHide;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHintWindow.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  if ((Message.WindowPos^.flags and SWP_SHOWWINDOW) = SWP_SHOWWINDOW) then
    OnShow;
//  if ((Message.WindowPos^.flags and SWP_HIDEWINDOW) = SWP_HIDEWINDOW) then
//    OnHide;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHintWindow.SetupRightCaption(ACaption : string);
{$ifdef LMD_UNICODE}
var
  i : integer;
  ws: WideString;
{$endif}
begin
  FIsHTML := LMDIsHTMLText(ACaption);
  {$ifdef LMD_UNICODE}
  ws := WideString(ACaption);
  if FWideCaption <> ws  then
    FWideCaption := ws;
  if (Length(ACaption) > 4) then
    begin
      if Copy(ACaption, Length(ACaption) - 3, 4) = #00#00#$FE#$FF then
        begin
          i := StrLen(PChar(ACaption)) + 1;
          // Caption := Copy(Caption, i, Length(Caption));
          SetLength(FWideCaption, (Length(ACaption) - i - 4) div 2);
          Move(ACaption[i + 1], FWideCaption[1], Length(FWideCaption) * 2);
          FWideCaption := LMDWideGetShortHint(FWideCaption);
        end
      else
        if Copy(ACaption, Length(ACaption) - 3, 4) = #00#00#$FF#$FF then
          begin
            if Length(ACaption) mod 2 = 1 then
              Delete(ACaption, 1, 1);
            SetLength(FWideCaption, (Length(ACaption) - 4) div 2);
            Move(ACaption[1], FWideCaption[1], Length(FWideCaption) * 2);
            //FWideCaption := GetShortHintW(FWideCaption);
          end;
    end;
  //FIsHTML := FIsHTML or (Copy(FWideCaption, 1, 6) = '<html>');
  FIsHTML := FIsHTML or LMDIsHTMLText(FWideCaption);
  {$endif}
end;

{------------------------------------------------------------------------------}
function TLMDCustomHTMLHintWindow.CalcHintRect(MaxWidth: Integer;
  const AHint: String; AData: TLMDDataTag): TRect;
var
  LCaller: TLMDCustomHTMLHint;
  lFont: TFont;
begin
  LCaller := HintControl;
  if Assigned(LCaller) then
    begin
      lFont := LCaller.GetHintFont;
      if Assigned(LFont) then
      begin
        FRender.Data.DefaultFont := lFont.Name;
        Font.Assign(lFont);
      end;
    end;
  SetupRightCaption(AHint);
  {$ifdef LMD_UNICODE}
  if Length(FWideCaption) > 0 then
    result := CalcHintRectW(MaxWidth, FWideCaption, AData)
  else
    SetRectEmpty(Result);
  {$else}
  FMaxWidth := MaxWidth;
  if IsHTML then
    begin
      InitRenderData;
      {$IFDEF LMD_UNICODE}
      FRender.PrepareText(FWideCaption, MaxWidth, FWordWrap);
      {$ELSE}
      FRender.PrepareText(AHint, MaxWidth, FWordWrap);
      {$ENDIF}
      Result := Rect(0, 0, FRender.Data.TextSize.cx, FRender.Data.TextSize.cy + 2);
    end
  else
    begin
      Canvas.Font.Assign(Font);
      Result := Rect(0, 0, MaxWidth, 0);
      DrawText(Canvas.Handle, Int_Ref(AHint), Length(AHint), Result,
                DT_CALCRECT or DT_LEFT or WrapFlags[WordWrap] or DT_NOPREFIX
                or DrawTextBiDiModeFlagsReadingOnly
                );
    end;
  //->
  {$endif}
  AdjustHintRect(Result);  
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHintWindow.ActivateHint(Rect: TRect; const AHint: string);
begin
  {$ifdef LMD_UNICODE}
  if Length(FWideCaption) > 0 then
    ActivateHintW(Rect, FWideCaption);
  {$else}
  inherited;
  {$endif}
end;

{------------------------------------------------------------------------------}
{$ifdef LMD_UNICODE}
function TLMDCustomHTMLHintWindow.CalcHintRectW(MaxWidth: Integer; const AHint: WideString; AData: Pointer): TRect;
begin
  FMaxWidth := MaxWidth;
  if IsHTML then
    begin
      InitRenderData;
      FRender.PrepareText(AHint, MaxWidth, FWordWrap);
      Result := Rect(0, 0, FRender.Data.TextSize.cx, FRender.Data.TextSize.cy + 2);
    end
  else
    begin
      Canvas.Font.Assign(Font);
      Result := Rect(0, 0, MaxWidth, 0);
      LMDDrawText(Canvas.Handle, AHint, -1, Result,
                DT_CALCRECT or DT_LEFT or WrapFlags[WordWrap] or DT_NOPREFIX
                or DrawTextBiDiModeFlagsReadingOnly
                );
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHintWindow.ActivateHintW(Rect: TRect; const AHint: WideString);
begin
  FActivating := true;
  FWideCaption := AHint;

  Inc(Rect.Bottom, 4);

  UpdateBoundsRect(Rect);
  if Rect.Top + Height > Screen.DesktopHeight then
    Rect.Top := Screen.DesktopHeight - Height;
  if Rect.Left + Width > Screen.DesktopWidth then
    Rect.Left := Screen.DesktopWidth - Width;
  if Rect.Left < Screen.DesktopLeft then
    Rect.Left := Screen.DesktopLeft;
  if Rect.Bottom < Screen.DesktopTop then
    Rect.Bottom := Screen.DesktopTop;
  SetWindowPos(Handle, HWND_TOPMOST, Rect.Left, Rect.Top, Width, Height,
    SWP_SHOWWINDOW or SWP_NOACTIVATE);
  FActivating := false;
  Invalidate;
end;
{$endif LMD_UNICODE}

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHintWindow.AdjustHintRect(var aRect: TRect);
begin
  //if IsHtml then
    begin
      Inc(aRect.Right, 4);
      Inc(aRect.Bottom, 4);
    end
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHintWindow.InitRenderData;
begin
  FRender.Data.DefaultColor := Font.Color;
  FRender.Data.DefaultBgColor := clNone;
  FRender.Data.Charset := Font.Charset;
  FRender.Data.DefaultStyle := Font.Style;
  FRender.Data.DefaultHeight := Font.Height;
  FRender.Data.DefaultFont := Font.Name;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHintWindow.DrawTextTo(ACanvas : TCanvas; ACaption : TLMDString; TextRect : TRect);
var
  R: TRect;
{$ifdef LMD_UNICODE}
{$ifdef LMD_ELUNISCRIBE}
  FPlainText: TLMDString;
{$endif}
{$endif}
begin
  R := TextRect;
  FTextRect := R;
  Canvas.Font.Assign(Font);
  if IsHTML then
    begin
      OffSetRect(R, HTMLRectDelta, HTMLRectDelta);
      InitRenderData;
      {$ifdef LMD_UNICODE}
      FRender.PrepareText(FWideCaption, FMaxWidth - 4, true);
      {$else}
      FRender.PrepareText(ACaption, FMaxWidth - 4, true);
      {$endif}
      FRender.DrawText(Canvas, Point(0, 0), R, clNone);
    end
  else
    begin
      {$ifdef LMD_UNICODE}
      {$ifdef LMD_ELUNISCRIBE}
      FUniscribeString.Text := FWideCaption;
      FPlainText := FUniscribeString.PlainText;
      if ScriptIsComplex(PWideChar(FPlainText), Length(FPlainText), SIC_COMPLEX) = S_FALSE then
        begin
        {$endif}
        {$endif}
          {$ifdef LMD_UNICODE}
          LMDDrawText(Canvas.Handle, FWideCaption, -1, R, DT_LEFT or DT_NOPREFIX or WrapFlags[WordWrap]);
          {$else}
          DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_LEFT or DT_NOPREFIX or WrapFlags[WordWrap]);
          {$endif}
        {$ifdef LMD_UNICODE}
        {$ifdef LMD_ELUNISCRIBE}
        end
      else
        begin
          FUniscribeString.PrepareText(Canvas, FMaxWidth - 4, WordWrap);
          FUniscribeString.DrawText(Canvas, R, DT_LEFT or DT_NOPREFIX or WrapFlags[WordWrap]);
        end;
      {$endif}
      {$endif}
    end;
end; { DrawTextTo }

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHintWindow.GetTextSize(ACaption: TLMDString; var aRect: TRect);
var
  flags: LongInt;
  LCaller: TLMDCustomHint;
  lFont: TFont;
begin
  LCaller := HintControl;
  if not Assigned(LCaller) then exit;
  flags:=0;
  flags:=DrawTextBiDiModeFlags(flags);
  if LCaller.HideAccelChar  then
    flags := flags or DT_NOPREFIX;
  if IsHTML then
    begin
      aRect := CalcHintRect(MaxWidth, ACaption, nil);
      InflateRect(aRect, HTMLRectDelta, HTMLRectDelta);
    end
  else
    begin
      lFont := LCaller.GetHintFont;
      if not Assigned(lFont) then
        lFont := FFont;
      LMDDrawTextCalc(ACaption, LCaller.Font3D, aRect, lFont, True, false, 2, flags)
    end;
end;

function TLMDCustomHTMLHintWindow.HintControl: TLMDCustomHTMLHint;
begin
  Result := (inherited HintControl) as TLMDCustomHTMLHint;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHintWindow.CreateParams(var Params: TCreateParams);
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHintWindow.SetFont(newValue : TFont);
{ Sets data member FFont to newValue. }
begin
  FFont.Assign(newValue);
end; { SetFont }

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHintWindow.SetHintWindowSize;
var
  HRect : TRect;
begin
  {$ifdef LMD_UNICODE}
  HRect := CalcHintRectW(FMaxWidth, FWideCaption, nil);
  {$else}
  HRect := CalcHintRect(FMaxWidth, Caption, nil);
  {$endif}
  Width := HRect.Right - HRect.Left;
  Height := HRect.Bottom - HRect.Top;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHintWindow.SetIsHTML(aValue: boolean);
begin
  if aValue <> FIsHTML then
    FIsHTML := aValue;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomHTMLHintWindow.Destroy;
var
  TempClass: TWNDClass;
  lClassRegistered: boolean;
  s: string;
begin
  {$ifdef LMD_UNICODE}{$ifdef LMD_ELUNISCRIBE}
  FreeAndNil(FUniscribeString);
  {$endif}{$endif}
  FreeAndNil(FFont);
  FreeAndNil(FRender);

  s := ClassName;
  ReleaseHandle;
  lClassRegistered := GetClassInfo(hInstance, 
                                   {$IFDEF LMDCOMP12}PWideChar{$ELSE}PAnsiChar{$ENDIF}(s),
                                   TempClass);
  if lClassRegistered then
    Windows.UnregisterClass({$IFDEF LMDCOMP12}PWideChar{$ELSE}PAnsiChar{$ENDIF}(s), hInstance);
  inherited Destroy;
end;  { Destroy }

{------------------------------------------------------------------------------}
constructor TLMDCustomHTMLHintWindow.Create(AOwner : TComponent);
{ Creates an object of type TElHintWindow, and initializes properties. }
var
  FCaller: TLMDCustomHTMLHint;
begin
  inherited Create(AOwner);

 {$ifdef LMD_UNICODE}
  FWideCaption := '';
  {$endif}

  FFont := TFont.Create;
  FMaxWidth := Screen.Width - Left;
  {$ifdef LMD_UNICODE}{$ifdef LMD_ELUNISCRIBE}
  FUniscribeString := TLMDUniscribeStrings.Create;
  {$endif}{$endif}

  FRender := TLMDHTMLRender.Create;

  FCaller := HintControl;
  if Assigned(FCaller) then
  begin
    if Assigned(FCaller.OnImageNeeded) then
      FRender.OnImageNeeded := FCaller.OnImageNeeded;
    if Assigned(FCaller.OnImageNeededEx) then
      FRender.OnImageNeededEx := FCaller.OnImageNeededEx;
    if Assigned(FCaller.OnVariableNeeded) then
      FRender.OnVariableNeeded := FCaller.OnVariableNeeded;
  end;

  //<-
  with FRender.Data do
  begin
    DefaultBgColor := clInfoBk;
    DefaultColor   := clInfoText;
    DefaultStyle   := Screen.HintFont.Style;
    DefaultHeight  := Screen.HintFont.Height;
    DefaultFont    := Screen.HintFont.Name;
    Charset        := Screen.HintFont.Charset;

    Font.Name      := Screen.HintFont.Name;
    Font.Style     := Screen.HintFont.Style;
    Font.Charset   := Screen.HintFont.Charset;
    Font.Height    := Screen.HintFont.Height;
    WordWrap := True;
  end;
  //->
end;  { Create }

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHintWindow.TriggerLinkClickEvent(HRef : TLMDString);
var
  LCaller: TLMDCustomHTMLHint;
begin
  LCaller := HintControl;
  if Assigned(LCaller) and Assigned(LCaller.OnLinkClick) then
    LCaller.OnLinkClick(Self, HRef );
end;  { TriggerLinkClickEvent }

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHintWindow.WMLButtonDown(var Message: TWMLButtonDown);
var
  href : TLMDString;
begin
  if FRender.IsCursorOverLink(Point(Message.Pos.X - FTextRect.Left, Message.Pos.Y - FTextRect.Top), Point(0,0), FTextRect, href) then
    begin
      TriggerLinkClickEvent(href);
      exit;
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHintWindow.WMMouseMove(var Message: TWMMouseMove);
var
  href : TLMDString;
begin
  if FRender.IsCursorOverLink(Point(Message.Pos.X - FTextRect.Left, Message.Pos.Y - FTextRect.Top), Point(0,0), FTextRect, href) then
     Screen.Cursor := crHandPoint
  else
     Screen.Cursor := FCursor;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHintWindow.WMNCHitTest(var Message: TWMNCHitTest);
begin
   Message.Result := HTCLIENT;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHintWindow.CMTextChanged(var Message: TMessage);
begin
  if FActivating then Exit;
  SetHintWindowSize;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLHintWindow.SetWordWrap(Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    if FActivating then Exit;
    SetHintWindowSize;
  end;
end;

end.

