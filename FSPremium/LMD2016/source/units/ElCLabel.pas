unit ElCLabel;
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

ElCLabell unit
--------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Forms, Graphics, Controls, Messages, Windows, StdCtrls,
  LMDUtils, LMDGraphUtils, LMDTypes, intfLMDBase, LMDClass, LMDThemes,
  ElStyleMan;

type
  TCustomElLabel = class(TCustomLabel, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
    procedure SetParentThemeMode(const Value: boolean);
  protected
    {$ifdef LMD_UNICODE}
    FHint: TLMDString;
    {$endif}
    FCaption: TLMDString;
    FStyleMgrLink : TElStyleMgrChangeLink;
    FStyleManager: TElStyleManager;
    FStyleName: string;
    FEndEllipsis: Boolean;
    FBorderWidth: TBorderWidth;
    FParentThemeMode: boolean;
    FThemeMode : TLMDThemeMode;
    FThemeGlobalMode: Boolean;

    function GetUseXPThemes: Boolean;
    procedure ReadUseXPThemes(Reader: TReader);
    procedure SetThemeGlobalMode(const Value: Boolean);virtual;
    procedure SetThemeMode(const Value: TLMDThemeMode);virtual;
    procedure SetUseXPThemes(Value: Boolean);
    procedure DoThemeChanged; virtual;
    function UseThemeMode: TLMDThemeMode;
    procedure DefineProperties(Filer:TFiler);override;
    procedure AdjustBounds; override;
    procedure SetAutoSize(newValue : Boolean); override;
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
    procedure StyleMgrChange(Sender : TObject);
    procedure UpdateStyle;

    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    {$ifdef LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    {$endif}
    procedure Loaded; override;
    procedure SetCaption(Value: TLMDString);
    procedure SetEndEllipsis(Value: Boolean);
    procedure SetBorderWidth(Value: TBorderWidth); virtual;
    procedure Paint; override;
    property EndEllipsis: Boolean read FEndEllipsis write SetEndEllipsis default false;
    public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getLMDPackage:TLMDPackageID;
    property UseXPThemes: Boolean read GetUseXPThemes write SetUseXPThemes;
    function IsThemed: Boolean;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property ParentThemeMode: boolean read FParentThemeMode write SetParentThemeMode;
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;
    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$endif}
    property Caption: TLMDString read FCaption write SetCaption;

    property Color nodefault;
    property Transparent default true;
    property BorderWidth: TBorderWidth read FBorderWidth write SetBorderWidth default 0;
  end;

implementation
uses
  TypInfo, SysUtils;
{ TElCustomLabel }

procedure TCustomElLabel.Loaded;
begin
  inherited;
  UpdateStyle;
  if ParentColor then
  begin
    ParentColor := False;
    ParentColor := True;
  end;
end;

constructor TCustomElLabel.Create(AOwner: TComponent);
begin
  inherited;
  Transparent := true;
  FThemeMode := ttmPlatform;
  FStyleMgrLink := TElStyleMgrChangeLink.Create;
  FStyleMgrLink.OnChange := StyleMgrChange;
  if not (csDesigning in ComponentState) then
    StyleManager := DefaultStyleManager;
end;

destructor TCustomElLabel.Destroy;
begin
  StyleManager := nil;
  FreeAndNil(FStyleMgrLink);
  inherited;
end;

procedure TCustomElLabel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FStyleManager) then
     StyleManager := nil;
end; { Notification }

procedure TCustomElLabel.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
    begin
      if (FStyleManager <> nil) and (not (csDestroying in FStyleManager.ComponentState)) then
        FStyleManager.RemoveFreeNotification(Self);
      if FStyleManager <> nil then
         FStyleManager.UnregisterChanges(FStyleMgrLink);
      FStyleManager := Value;
      if FStyleManager <> nil then
        begin
          FStyleManager.FreeNotification(Self);
          FStyleManager.RegisterChanges(FStyleMgrLink);
          UpdateStyle;
        end;
    end;
end;

procedure TCustomElLabel.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
  begin
    FStyleName := Value;
    UpdateStyle;
  end;
end;

procedure TCustomElLabel.StyleMgrChange(Sender : TObject);
begin
  UpdateStyle;
end;

procedure TCustomElLabel.UpdateStyle;
begin
  if ComponentState * [csLoading, csReading] <> [] then
    exit;
  if FStyleManager <> nil then
    begin
      FStyleManager.ApplyStyle(Self, StyleName);
    end;
end;

procedure TCustomElLabel.SetUseXPThemes(Value: Boolean);
begin
  if UseXPThemes <> Value then
  begin
    ThemeMode := LMDCtlXP[Value];
  end;
end;

function TCustomElLabel.GetUseXPThemes: Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

procedure TCustomElLabel.ReadUseXPThemes(Reader: TReader);
begin
  SetUseXPThemes(Reader.ReadBoolean);
end;

procedure TCustomElLabel.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
  begin
    FThemeGlobalMode := Value;
    DoThemeChanged;
  end;
end;

procedure TCustomElLabel.SetThemeMode(const Value: TLMDThemeMode);
begin
  if Value <> FThemeMode then
  begin
    FThemeMode:= Value;
    DoThemeChanged;
  end;
end;

procedure TCustomElLabel.DoThemeChanged;
begin
  Invalidate;
end;

function TCustomElLabel.UseThemeMode: TLMDThemeMode;
begin
  result := FThemeMode;
  if ParentThemeMode and Assigned(Parent) and IsPublishedProp(Parent, 'ThemeMode') then
    result := TLMDThemeMode(GetOrdProp(Parent, 'ThemeMode'))
  else
    if FThemeGlobalMode then
      result := LMDApplication.ThemeGlobalMode;
  result := LMDThemeServices.UseTheme(result);
end;

function TCustomElLabel.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

procedure TCustomElLabel.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('UseXPThemes', ReadUseXPThemes, nil, false);
end;

procedure TCustomElLabel.CMTextChanged(var Message: TMessage);
begin
  if string(Caption) <> inherited Caption then
  begin
    Caption := inherited Caption;
    AdjustBounds;
    end;
  inherited;
end;

{$ifdef LMD_UNICODE}
procedure TCustomElLabel.CMHintShow(var Message: TCMHintShow);
begin
  inherited;
  //LMDConvertVCLHintShow(inherited Hint, FHint, Message); //outcommented VB Dec 2008
end;

procedure TCustomElLabel.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;
{$ENDIF}

procedure TCustomElLabel.SetCaption(Value: TLMDString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    inherited Caption := Value;
    Perform(CM_TEXTCHANGED, 0, 0);
  end;
end;

procedure TCustomElLabel.SetEndEllipsis(Value: Boolean);
begin
  if FEndEllipsis <> Value then
  begin
    FEndEllipsis := Value;
    Invalidate;
  end;
end;

procedure TCustomElLabel.SetParentThemeMode(const Value: boolean);
begin
  if FParentThemeMode <> Value then
  begin
    FParentThemeMode := Value;
    DoThemeChanged;
  end;
end;

procedure TCustomElLabel.AdjustBounds;
const
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  DC: HDC;
  X: Integer;
  Rect: TRect;
begin
  if not ((csReading in ComponentState) or (csLoading in ComponentState)) and AutoSize then
  begin
    Rect := ClientRect;
    DC := GetDC(0);
    Canvas.Handle := DC;
    DoDrawText(Rect, (DT_EXPANDTABS or DT_CALCRECT) or WordWraps[WordWrap]);
    if BorderWidth > 0 then
    begin
      inc(Rect.Right, BorderWidth * 2);
      inc(Rect.Bottom, BorderWidth * 2);
    end;
    Canvas.Handle := 0;
    ReleaseDC(0, DC);
    X := Left;
    if Alignment = taRightJustify then
      Inc(X, Width - Rect.Right);

    SetBounds(X, Top, Rect.Right, Rect.Bottom);
  end;
end;

procedure TCustomElLabel.SetBorderWidth(Value: TBorderWidth);
begin
  if FBorderWidth <> Value then
  begin
    FBorderWidth := Value;
    AdjustBounds;
    end;
end;

procedure TCustomElLabel.SetAutoSize(newValue : Boolean);
{ Sets the value for the AutoSize property. }
begin
  if AutoSize <> newValue then
  begin
    inherited;
    end;
end;  { SetAutoSize }

procedure TCustomElLabel.Paint;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  Rect, CalcRect: TRect;
  DrawStyle: Longint;
begin
  with Canvas do
  begin
    if not Transparent then
    begin
      Brush.Color := Self.Color;
      Brush.Style := bsSolid;
      FillRect(ClientRect);
    end;
    Brush.Style := bsClear;
    Rect := ClientRect;
    InflateRect(Rect, -BorderWidth, -BorderWidth);

    { DoDrawText takes care of BiDi alignments }
    DrawStyle := DT_EXPANDTABS or WordWraps[WordWrap] or Alignments[Alignment];
    if not ShowAccelChar then
      DrawStyle := DrawStyle or DT_NOPREFIX;

    { Calculate vertical layout }
    if Layout <> tlTop then
    begin
      CalcRect := ClientRect;
      DoDrawText(CalcRect, DrawStyle or DT_CALCRECT);
      if Layout = tlBottom then
        Rect.Top := Rect.Bottom - CalcRect.Bottom
      else
      begin
        Rect.Top := Rect.Top + ((Rect.Bottom - Rect.Top) - CalcRect.Bottom) div 2;
        Rect.Bottom := Rect.Top + CalcRect.Bottom;
      end;
    end;
    {$ifdef LMD_UNICODE}
    LMDDrawText(Canvas.Handle, Caption, Length(Caption), Rect, DrawStyle);
    {$else}
    DoDrawText(Rect, DrawStyle);
    {$endif}
  end;
end;

function TCustomElLabel.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_ELCORE;
end;

end.
