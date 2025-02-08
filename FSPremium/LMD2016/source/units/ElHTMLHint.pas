unit ElHTMLHint;
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

ElHTMLHint unit
---------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Types,
  Windows,
  Graphics,
  Controls,
  Forms,
  Messages,
  SysUtils,
  Classes,

  ElComponent,
  ElVCLUtils,
  ElHintWnd,

  LMDHTMLUnit,
  {$ifdef LMD_UNICODE}
  LMDUtils,
  {$endif}
  LMDTypes;

type
  TElHTMLHint = class(TElComponent)
  private
    FEnabled  : Boolean;
    FHintClass: THintWindowClass;
    FOnShow,
    FOnHide   : TNotifyEvent;
    FOnImageNeeded: TElHTMLImageNeededEvent;
    FOnVariableNeeded: TLMDHTMLVariableNeededEvent;
    FOnTagFound: TLMDHTMLTagFoundEvent;
  protected
    FFontName: TFontName;
    procedure SetEnabled(Value : Boolean); virtual;
    procedure SetOnHide(Value : TNotifyEvent);
    procedure SetOnShow(Value : TNotifyEvent);
    procedure SetOnImageNeeded(Value : TElHTMLImageNeededEvent);
    procedure SetOnVariableNeeded(const Value: TLMDHTMLVariableNeededEvent);
    procedure SetOnTagFound(const Value: TLMDHTMLTagFoundEvent);

    procedure SetFontName(const Value: TFontName);
    function  GetFontCharset: TFontCharset;
    procedure SetFontCharset(Value: TFontCharset);
  public
    destructor Destroy; override;
  published
    property Enabled : Boolean read FEnabled write SetEnabled;  { Published }

    property OnShow  : TNotifyEvent read FOnShow write SetOnShow;
    property OnHide  : TNotifyEvent read FOnHide write SetOnHide;

    property OnImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write SetOnImageNeeded;
    property OnVariableNeeded: TLMDHTMLVariableNeededEvent read FOnVariableNeeded write SetOnVariableNeeded;
    property OnTagFound: TLMDHTMLTagFoundEvent read FOnTagFound write SetOnTagFound;

    property FontName: TFontName read FFontName write SetFontName;
    property FontCharset: TFontCharset read GetFontCharset write SetFontCharset;
  end;

  TElHTMLHintWindow = class(TElHintWindow)
  protected
    procedure OnShow;
    procedure OnHide;
    procedure WMShowWindow(var Message: TWMShowWindow); message WM_SHOWWINDOW;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure TriggerImageNeededEvent(Sender: TObject; Src: TLMDString; var Image: TBitmap); override;
    procedure TriggerVariableNeededEvent(Sender : TObject; const aVar : TLMDString; var aVal: TLMDString); override;
    procedure TriggerTagFoundEvent(Sender : TObject; var Tag: TLMDString; var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing:boolean; aSupported: boolean); override;
    procedure SetupRightCaption(Caption: String);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    function CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect; override;
    procedure ActivateHint(Rect: TRect; const AHint: string); override;
  end;  { TElHTMLHintWindow }

implementation

var OnHintShow,
    OnHintHide   : TNotifyEvent;

    OnHintImageNeeded : TElHTMLImageNeededEvent;
    OnHintVariableNeeded : TLMDHTMLVariableNeededEvent;
    OnHintTagFound : TLMDHTMLTagFoundEvent;

    AFontName    : TFontName;
    AFontCharset : TFontCharset;

destructor TElHTMLHint.Destroy;
begin
  OnHintHide := nil;
  OnHintShow := nil;
  OnHintImageNeeded := nil;
  OnHintVariableNeeded := nil;
  OnTagFound := nil;
  Enabled := false;
  inherited;
end;

procedure TElHTMLHint.SetEnabled(Value : Boolean);
begin
  if (FEnabled <> Value) then
  begin
    FEnabled := Value;
    if (not (csDesigning in ComponentState)) and (not (csDestroying in ComponentState)) then
    begin
      Application.ShowHint := false;

      if FEnabled then
      begin
        if HintWindowClass <> TElHTMLHintWindow then
           FHintClass := HintWindowClass;
        HintWindowClass := TElHTMLHintWindow;
      end
      else
        HintWindowClass := FHintClass;

      Application.ShowHint := true;
    end;
  end;  { if }
end;  { SetEnabled }

procedure TElHTMLHint.SetOnImageNeeded(Value : TElHTMLImageNeededEvent);
begin
  OnHintImageNeeded := Value;
  FOnImageNeeded := Value;
end;

procedure TElHTMLHint.SetOnHide(Value : TNotifyEvent);
begin
  OnHintHide := Value;
  FOnHide := Value;
end;

procedure TElHTMLHint.SetOnShow(Value : TNotifyEvent);
begin
  OnHintShow := Value;
  FOnShow := Value;
end;

procedure TElHTMLHint.SetFontName(const Value: TFontName);
begin
  if FFontName <> Value then
  begin
    FFontName := Value;
    AFontName := Value;
  end;
end;

function TElHTMLHint.GetFontCharset: TFontCharset;
begin
  Result := AFontCharset;
end;

procedure TElHTMLHint.SetFontCharset(Value: TFontCharset);
begin
  AFontCharset := Value;
end;

destructor TElHTMLHintWindow.Destroy;
begin
  inherited Destroy;
end;  { Destroy }

constructor TElHTMLHintWindow.Create(AOwner : TComponent);

begin
  inherited Create(AOwner);

  with FRender.Data do
  begin
    DefaultBgColor := TElHintWindow.GetThemedHintColor;
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
end;  { Create }

procedure TElHTMLHintWindow.OnShow;
begin
  if Assigned(OnHintShow) then
    OnHintShow(Self);
end;

procedure TElHTMLHintWindow.TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; var Image : TBitmap);
begin
  if Assigned(OnHintImageNeeded) then
     OnHintImageNeeded(Self, Src, Image);
end;

procedure TElHTMLHintWindow.OnHide;
begin
  if Assigned(OnHintHide) then
    OnHintHide(Self);
end;

procedure TElHTMLHintWindow.WMShowWindow(var Message: TWMShowWindow);
begin
  if not Message.Show then
    OnHide;
  inherited;
end;

procedure TElHTMLHintWindow.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;

  if (Message.WindowPos^.flags and SWP_SHOWWINDOW = SWP_SHOWWINDOW) then

    OnShow;
end;

procedure TElHTMLHintWindow.SetupRightCaption(Caption : String);

{$ifdef LMD_UNICODE}
var
  i : integer;
{$endif}

begin
  IsHTML := Copy(Caption, 1, 6) = '<html>';
  {$ifdef LMD_UNICODE}
  FWideCaption := Caption;
  if (Length(Caption) > 4) then
  begin
    if Copy(Caption, Length(Caption) - 3, 4) = #00#00#$FE#$FF then
    begin
      i := StrLen(PChar(Caption)) + 1;
      // Caption := Copy(Caption, i, Length(Caption));
      SetLength(FWideCaption, (Length(Caption) - i - 4) div 2);
      Move(Caption[i + 1], FWideCaption[1], Length(FWideCaption) * 2);
      FWideCaption := LMDWideGetShortHint(FWideCaption);
    end
    else
    if Copy(Caption, Length(Caption) - 3, 4) = #00#00#$FF#$FF then
    begin
      if Length(Caption) mod 2 = 1 then
        Delete(Caption, 1, 1);
      SetLength(FWideCaption, (Length(Caption) - 4) div 2);
      Move(Caption[1], FWideCaption[1], Length(FWideCaption) * 2);
      //FWideCaption := GetShortHintW(FWideCaption);
    end;
  end;
  IsHTML := IsHTML or (Copy(FWideCaption, 1, 6) = '<html>');
  {$endif}
end;

function TElHTMLHintWindow.CalcHintRect;
begin
  if AFontName <> '' then
  begin
    FRender.Data.DefaultFont := AFontName;
    Font.Name := AFontName;
    Font.Charset := AFontCharset;
  end;
  SetupRightCaption(AHint);
  {$ifdef LMD_UNICODE}
  if Length(FWideCaption) > 0 then
    result := inherited CalcHintRectW(MaxWidth, FWideCaption, AData)
  else
  SetRectEmpty(Result);
  {$else}
  result := inherited CalcHintRect(MaxWidth, AHint, AData);
  {$endif}
end;

procedure TElHTMLHintWindow.ActivateHint(Rect: TRect; const AHint: string);
var
  r: TRect;
begin
  GetWindowRect(self.Handle, r);
  {$ifdef LMD_UNICODE}
  if (Length(FWideCaption)>0) and ((abs(r.Left - rect.left)>5) or (abs(r.right - rect.right)>5) or (abs(r.top - rect.top)>5) or (abs(r.bottom - rect.bottom)>5)) then
    inherited ActivateHintW(Rect, FWideCaption);
  {$else}
  inherited;
  {$endif}
end;

procedure TElHTMLHint.SetOnVariableNeeded(
  const Value: TLMDHTMLVariableNeededEvent);
begin
  OnHintVariableNeeded := Value;
  FOnVariableNeeded := Value;
end;

procedure TElHTMLHintWindow.TriggerVariableNeededEvent(Sender: TObject;
  const aVar: TLMDString; var aVal: TLMDString);
begin
  if Assigned(OnHintVariableNeeded) then
     OnHintVariableNeeded(Self, aVar, aVal);
end;

procedure TElHTMLHint.SetOnTagFound(const Value: TLMDHTMLTagFoundEvent);
begin
  OnHintTagFound := Value;
  FOnTagFound := Value;
end;

procedure TElHTMLHintWindow.TriggerTagFoundEvent(Sender: TObject;
  var Tag: TLMDString; var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing,
  aSupported: boolean);
begin
  if Assigned(OnHintTagFound) then
    OnHintTagFound(Self, Tag, Item, Params, aClosing, aSupported);
end;

end.
