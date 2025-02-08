unit ElHintWnd;
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

ElHintWnd unit
--------------
TElHintWindow component.

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Types,
  Windows,
  Messages,
  Graphics,
  Controls,
  Forms,
  SysUtils,
  Classes,
  Themes,
  {$ifdef LMD_ELUNISCRIBE}
  LMDUsp10,
  LMDUniscribeStrings,
  {$ENDIF}

  LMDClass,
  LMDHTMLUnit,
  LMDTypes,
  LMDSysIn,
  LMDGraphUtils,
  LMDThemes;

type
  TElHintWindow = class(THintWindow)
  protected
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
    FIsHTML : boolean;
    FHTMLTabWidth : integer;
    FOnLinkClick: TElHTMLLinkClickEvent;
    FOnImageNeeded : TElHTMLImageNeededEvent;
    FOnVariableNeeded: TLMDHTMLVariableNeededEvent;
    FOnTagFound: TLMDHTMLTagFoundEvent;

    procedure SetFont(newValue : TFont);
    procedure SetHTMLTabWidth(Value : integer);
    procedure CreateParams(var Params: TCreateParams); override;
  protected
    FWordWrap: Boolean;

    procedure TriggerLinkClickEvent(HRef : TLMDString); virtual;
    procedure TriggerImageNeededEvent(Sender: TObject; Src : TLMDString; var Image : TBitmap); virtual;
    procedure TriggerVariableNeededEvent(Sender : TObject; const aVar : TLMDString; var aVal: TLMDString); virtual;
    procedure TriggerTagFoundEvent(Sender : TObject; var Tag: TLMDString; var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing:boolean; aSupported: boolean); virtual;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure SetWordWrap(Value: Boolean);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    function CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect; override;

    class function GetThemedHintColor: TColor;

    {$ifdef LMD_UNICODE}
    function CalcHintRectW(MaxWidth: Integer; const AHint: WideString; AData: Pointer): TRect;
    procedure ActivateHintW(Rect: TRect; const AHint: WideString); virtual;
    {$endif}
    property MaxWidth: Integer read FMaxWidth write FMaxWidth;
    property Canvas;
  published
    property Font : TFont read FFont write SetFont;  { Published }
    property WordWrap: Boolean read FWordWrap write SetWordWrap default false;
    {$ifdef LMD_UNICODE}
    property WideCaption : WideString read FWideCaption write FWideCaption;
    {$endif}

    property IsHTML : boolean read FIsHTML write FIsHTML;
    property HTMLTabWidth : integer read FHTMLTabWidth write SetHTMLTabWidth;
    property OnImageNeeded : TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnLinkClick: TElHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnVariableNeeded: TLMDHTMLVariableNeededEvent read FOnVariableNeeded write FOnVariableNeeded;
    property OnTagFound: TLMDHTMLTagFoundEvent read FOnTagFound write FOnTagFound;
  end;  { TElHintWindow }

implementation

uses
  {$IFDEF LMDCOMP16}System.UITypes,{$ENDIF}
  LMDProcs;

const
  WrapFlags: array[boolean] of Integer = (0, DT_WORDBREAK);

procedure TElHintWindow.TriggerImageNeededEvent(Sender: TObject; Src : TLMDString; var Image : TBitmap);
begin
  if assigned (FOnImageNeeded) then
    FOnImageNeeded(Self, Src, Image);
end;

{$ifdef LMD_UNICODE}
function TElHintWindow.CalcHintRectW(MaxWidth: Integer; const AHint: WideString; AData: Pointer): TRect;
begin
  FMaxWidth := MaxWidth;
  if IsHTML then
  begin
    FRender.Data.DefaultColor := Font.Color;
    FRender.Data.DefaultBgColor := Color;
    FRender.Data.Charset := Font.Charset;
    FRender.Data.DefaultStyle := Font.Style;
    FRender.Data.DefaultHeight := Font.Height;
    FRender.Data.DefaultFont := Font.Name;
    FRender.PrepareText(AHint, MaxWidth, FWordWrap);
    Result := Rect(0, 0, FRender.Data.TextSize.cx, FRender.Data.TextSize.cy + 2);
    Inc(Result.Right, 6);
    Inc(Result.Bottom, 2);
    end
  else

  begin
    Canvas.Font.Assign(Font);
    Result := Rect(0, 0, MaxWidth, 0);
    LMDDrawText(Canvas.Handle, AHint, -1, Result,
              DT_CALCRECT or DT_LEFT or WrapFlags[WordWrap] or DT_NOPREFIX
              or DrawTextBiDiModeFlagsReadingOnly
              );
    Inc(Result.Right, 6);
    Inc(Result.Bottom, 2);
  end;
end;

procedure TElHintWindow.ActivateHintW(Rect: TRect; const AHint: WideString);

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

function TElHintWindow.CalcHintRect;
begin
  FMaxWidth := MaxWidth;
  if IsHTML then
  begin
    FRender.Data.DefaultColor := Font.Color;
    FRender.Data.DefaultBgColor := Color;
    FRender.Data.Charset := Font.Charset;
    FRender.Data.DefaultStyle := Font.Style;
    FRender.Data.DefaultHeight := Font.Height;
    FRender.Data.DefaultFont := Font.Name;
    FRender.PrepareText(AHint, MaxWidth, FWordWrap);
    Result := Rect(0, 0, FRender.Data.TextSize.cx, FRender.Data.TextSize.cy + 2);
    Inc(Result.Right, 6);
    Inc(Result.Bottom, 2);
  end else

  begin
    Canvas.Font.Assign(Font);
    Result := Rect(0, 0, MaxWidth, 0);
    DrawText(Canvas.Handle, Int_Ref(AHint), Length(AHint), Result,
              DT_CALCRECT or DT_LEFT or WrapFlags[WordWrap] or DT_NOPREFIX
              or DrawTextBiDiModeFlagsReadingOnly
              );

    Inc(Result.Right, 6);
    Inc(Result.Bottom, 2);
    end;
end;

procedure TElHintWindow.Paint;  { public }
var
  R: TRect;
{$ifdef LMD_UNICODE}
{$ifdef LMD_ELUNISCRIBE}
  FPlainText: TLMDString;
{$endif}
{$endif}
begin
  R := ClientRect;
  Canvas.Font.Assign(Font);

  Inc(R.Left, 2);
  Inc(R.Top, 2);

  if IsHTML then
  begin
    FRender.Data.DefaultColor := Font.Color;
    FRender.Data.DefaultBgColor := Color;
    FRender.Data.Charset := Font.Charset;
    FRender.Data.DefaultStyle := Font.Style;
    FRender.Data.DefaultHeight := Font.Height;
    FRender.Data.DefaultFont := Font.Name;
    {$ifdef LMD_UNICODE}
    FRender.PrepareText(FWideCaption, FMaxWidth - 4, true);
    {$else}
    FRender.PrepareText(Caption, FMaxWidth - 4, true);
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
end; { Paint }

procedure TElHintWindow.CreateParams(var Params: TCreateParams);
const
  SPI_GETDROPSHADOW = $1024;
  CS_DROPSHADOW = $20000;
var
  Shadow: BOOL;
begin
  inherited;
  if LMDSIWindowsXPUp then
  begin
    Shadow := False;
    SystemParametersInfo(SPI_GETDROPSHADOW, 0, @Shadow, 0);
    if Shadow then
      Params.WindowClass.Style := Params.WindowClass.style or CS_DROPSHADOW;
  end;{}
end;

procedure TElHintWindow.SetFont(newValue : TFont);
{ Sets data member FFont to newValue. }
begin
  FFont.Assign(newValue);
end;

procedure TElHintWindow.SetHTMLTabWidth(Value: integer);
begin
  if FHTMLTabWidth <> Value then
  begin
    FHTMLTabWidth := Value;
    FRender.Data.HTMLTabWidth := Value;
  end;
end;

{ SetFont }

destructor TElHintWindow.Destroy;
begin
  {$ifdef LMD_UNICODE}
  {$ifdef LMD_ELUNISCRIBE}
  FreeAndNil(FUniscribeString);
  {$endif}
  {$endif}
  FFont.Free;
  FRender.Free;
  inherited Destroy;
end;

class function TElHintWindow.GetThemedHintColor: TColor;
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

{ Destroy }

constructor TElHintWindow.Create(AOwner : TComponent);
{ Creates an object of type TElHintWindow, and initializes properties. }
begin
  inherited Create(AOwner);
  FFont := TFont.Create;
  FMaxWidth := Screen.Width - Left;
  {$ifdef LMD_UNICODE}
  {$ifdef LMD_ELUNISCRIBE}
  FUniscribeString := TLMDUniscribeStrings.Create;
  {$endif}
  {$endif}

  FRender := TLMDHTMLRender.Create;
  FRender.OnImageNeeded := TriggerImageNeededEvent;
  FRender.OnVariableNeeded := TriggerVariableNeededEvent;
  FRender.OnTagFound := TriggerTagFoundEvent;

  HTMLTabWidth := 20;
end;  { Create }

procedure TElHintWindow.TriggerLinkClickEvent(HRef : TLMDString);
begin
  if (assigned(FOnLinkClick)) then
    FOnLinkClick(Self, HRef );
end;  { TriggerLinkClickEvent }

procedure TElHintWindow.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  href : TLMDString;
begin
  FRender.Data.DefaultColor := Font.Color;
  FRender.Data.DefaultBgColor := Color;

  FRender.Data.DefaultStyle := Font.Style;
  FRender.Data.DefaultHeight := Font.Height;
  FRender.Data.DefaultFont := Font.Name;
  if FRender.IsCursorOverLink(Point(X - 2, Y - 2), Point(0, 0), Rect(2, 2, ClientWidth - 2, ClientHeight - 2), href) then
  begin
    TriggerLinkClickEvent(href);
    exit;
  end;

  inherited;
end;

procedure TElHintWindow.CMTextChanged(var Message: TMessage);

var HRect : TRect;
begin
  if FActivating then Exit;
  {$ifdef LMD_UNICODE}
  HRect := CalcHintRectW(FMaxWidth, FWideCaption, nil);
  {$else}
  HRect := CalcHintRect(FMaxWidth, Caption, nil);
  {$endif}

  Width := HRect.Right - HRect.Left;
  Height := HRect.Bottom - HRect.Top;
end;

procedure TElHintWindow.SetWordWrap(Value: Boolean);
var HRect : TRect;
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    if FActivating then Exit;

    {$ifdef LMD_UNICODE}
    HRect := CalcHintRectW(FMaxWidth, FWideCaption, nil);
    {$else}
    HRect := CalcHintRect(FMaxWidth, Caption, nil);
    {$endif}

    Width := HRect.Right - HRect.Left;
    Height := HRect.Bottom - HRect.Top;
  end;
end;

procedure TElHintWindow.TriggerVariableNeededEvent(Sender: TObject;
  const aVar: TLMDString; var aVal: TLMDString);
begin
  if Assigned(FOnVariableNeeded) then
    FOnVariableNeeded(Self, aVar, aVal);
end;

procedure TElHintWindow.TriggerTagFoundEvent(Sender: TObject;
  var Tag: TLMDString; var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing,
  aSupported: boolean);
begin
  if Assigned(FOnTagFound) then
    FOnTagFound(Self, Tag, Item, Params, aClosing, aSupported);
end;


end.
