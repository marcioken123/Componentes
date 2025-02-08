unit LMDUnicodeCtrls;
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

LMDUnicodeCtrls unit (AH)
-------------------------
Set of unicode controls for Windows Net family OSes, for TLMDTaskDialog

Changes
-------
Release 8.0 (January 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Controls, StdCtrls, Messages, Graphics, LMDTypes,
  LMDGraphUtils, LMDUnicodeControl, intfLMDBase, LMDHTMLUnit, LMDStrings;

type
{$IFDEF _LMD_UNICODEIMPL}
  TLMDWideCheckBox = class(TCheckBox)
  private
    FCaption: TLMDString;
    function GetCaption: TLMDString;
    procedure SetCaption(const Value: TLMDString);
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DefineProperties(Filer: TFiler); override;
  published
    property Caption: TLMDString read GetCaption write SetCaption;
  end;

  TLMDWideRadioButton = class(TRadioButton)
  private
    FCaption: TLMDString;
    function GetCaption: TLMDString;
    procedure SetCaption(const Value: TLMDString);
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DefineProperties(Filer: TFiler); override;
  published
    property Caption: TLMDString read GetCaption write SetCaption;
  end;

  TLMDWideButton = class(TButton)
  private
    FCaption: TLMDString;
    function GetCaption: TLMDString;
    procedure SetCaption(const Value: TLMDString);
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DefineProperties(Filer: TFiler); override;
  published
    property Caption: TLMDString read GetCaption write SetCaption;
  end;
{$ELSE}
  TLMDWideButton = TButton;
  TLMDWideCheckBox = TCheckBox;
  TLMDWideRadioButton = TRadioButton;
{$ENDIF}

  TLMDWideLabel = class(TCustomLabel, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
    FAlreadyInSetBounds: Boolean;
    function GetOnImageNeeded: TLMDHTMLImageNeededEvent;
    procedure SetOnImageNeeded(const Value: TLMDHTMLImageNeededEvent);
  protected
    FUseXPThemes: Boolean;
    FCaption: TLMDString;

    FEndEllipsis: Boolean;
    FIsHTML: Boolean;

    FRender: TLMDHTMLRender;
    FOnLinkClick: TLMDHTMLLinkClickEvent;
    FOnImageNeeded: TLMDHTMLImageNeededEvent;

    FBorderWidth: TBorderWidth;
    procedure AdjustBounds; override;

    procedure SetAutoSize(newValue : Boolean); override;
    procedure SetUseXPThemes(Value: Boolean);

    procedure SetIsHTML(Value: Boolean);

    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure Loaded; override;
    procedure SetCaption(Value: TLMDString);
    procedure SetEndEllipsis(Value: Boolean);
    procedure SetBorderWidth(Value: TBorderWidth); virtual;
    procedure Paint; override;
    property EndEllipsis: Boolean read FEndEllipsis write SetEndEllipsis default false;
    property UseXPThemes: Boolean read FUseXPThemes write SetUseXPThemes default true;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure PrepareText; virtual;
    procedure CMFontchanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetLMDPackage: TLMDPackageID;
  published
    property AutoSize;
    property Font;
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property Caption: TLMDString read FCaption write SetCaption;

    property Color nodefault;
    property IsHTML: boolean read FIsHTML write SetIsHTML;
    property Transparent default true;
    property BorderWidth: TBorderWidth read FBorderWidth write SetBorderWidth default 0;
    property OnLinkClick: TLMDHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnImageNeeded: TLMDHTMLImageNeededEvent read GetOnImageNeeded write SetOnImageNeeded;
    property WordWrap;
  end;

implementation

{$IFDEF _LMD_UNICODEIMPL}
{ **************************** TLMDWideCheckBox ****************************** }
{------------------------------------------------------------------------------}
procedure TLMDWideCheckBox.CreateWindowHandle(const Params: TCreateParams);
begin
  LMDCreateControlHandle(Self, Params, 'BUTTON');
end;

{------------------------------------------------------------------------------}
procedure TLMDWideCheckBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{------------------------------------------------------------------------------}
function TLMDWideCheckBox.GetCaption: TLMDString;
begin
  Result := LMDGetControlText(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDWideCheckBox.SetCaption(const Value: TLMDString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetControlText(Self, Value);
  end;
end;

{ ************************** TLMDWideRadioButton ***************************** }
{------------------------------------------------------------------------------}
procedure TLMDWideRadioButton.CreateWindowHandle(const Params: TCreateParams);
begin
  LMDCreateControlHandle(Self, Params, 'BUTTON');
end;

{------------------------------------------------------------------------------}
procedure TLMDWideRadioButton.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{------------------------------------------------------------------------------}
function TLMDWideRadioButton.GetCaption: TLMDString;
begin
  Result := LMDGetControlText(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDWideRadioButton.SetCaption(const Value: TLMDString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetControlText(Self, Value);
  end;
end;

{ ************************** TLMDWideButton ********************************** }
{------------------------------------------------------------------------------}
procedure TLMDWideButton.CreateWindowHandle(const Params: TCreateParams);
begin
  LMDCreateControlHandle(Self, Params, 'BUTTON');
end;

{------------------------------------------------------------------------------}
procedure TLMDWideButton.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{------------------------------------------------------------------------------}
function TLMDWideButton.GetCaption: TLMDString;
begin
  Result := LMDGetControlText(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDWideButton.SetCaption(const Value: TLMDString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetControlText(Self, Value);
  end;
end;
{$ENDIF}

{ ****************************** TLMDWideLabel ******************************* }
{------------------------------------------------------------------------------}
procedure TLMDWideLabel.Loaded;
begin
  inherited;
  if ParentColor then
    begin
      ParentColor := False;
      ParentColor := True;
    end;
end;

{------------------------------------------------------------------------------}
constructor TLMDWideLabel.Create(AOwner: TComponent);
begin
  inherited;
  Transparent := true;
  FUseXPThemes := true;
  FRender := TLMDHTMLRender.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDWideLabel.Destroy;
begin
  inherited;
  FRender.Free;
end;

{------------------------------------------------------------------------------}
procedure TLMDWideLabel.SetUseXPThemes(Value: Boolean);
begin
  if FUseXPThemes <> Value then
  begin
    FUseXPThemes := Value;
      Invalidate;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWideLabel.SetIsHTML(Value: Boolean);
begin
  if FIsHTML <> Value then
  begin
    FIsHTML := Value;
    PrepareText;
    Repaint;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWideLabel.SetOnImageNeeded(const Value: TLMDHTMLImageNeededEvent);
begin
  FRender.OnImageNeededEx := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDWideLabel.CMTextChanged(var Message: TMessage);
begin
//  if string(Caption) <> inherited Caption then
  begin
    Caption := inherited Caption;
    PrepareText;
  end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDWideLabel.SetCaption(Value: TLMDString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    inherited Caption := Value;
    Perform(CM_TEXTCHANGED, 0, 0);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWideLabel.SetEndEllipsis(Value: Boolean);
begin
  if FEndEllipsis <> Value then
  begin
    FEndEllipsis := Value;
    Invalidate;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWideLabel.AdjustBounds;
const
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  DC: HDC;
  X: Integer;
  Rect: TRect;
begin
  if FIsHTML then
  begin
    if (not (csLoading in ComponentState)) and AutoSize then
    begin
      if (FRender.Data.TextSize.CX = 0) and (not FAlreadyInSetBounds) then
        PrepareText;
      SetBounds(Left, Top, FRender.Data.TextSize.CX + BorderWidth * 2, FRender.Data.TextSize.CY + BorderWidth * 2);
    end;
  end
  else
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

{------------------------------------------------------------------------------}
procedure TLMDWideLabel.SetBorderWidth(Value: TBorderWidth);
begin
  if FBorderWidth <> Value then
  begin
    FBorderWidth := Value;
    AdjustBounds;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWideLabel.SetAutoSize(newValue : Boolean);
{ Sets the value for the AutoSize property. }
begin
  if AutoSize <> newValue then
  begin
    inherited;
  end;
end;  { SetAutoSize }

{------------------------------------------------------------------------------}
procedure TLMDWideLabel.Paint;
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
    if FIsHTML then
      FRender.DrawText(Canvas, Point(0, 0), ClientRect, clNone)
    else
      LMDDrawText(Canvas.Handle, Caption, Length(Caption), Rect, DrawStyle);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDWideLabel.GetLMDPackage: TLMDPackageID;
begin
  result := pi_LMD_RTLX;
end;

{------------------------------------------------------------------------------}
function TLMDWideLabel.GetOnImageNeeded: TLMDHTMLImageNeededEvent;
begin
  Result := FRender.OnImageNeededEx;
end;

{------------------------------------------------------------------------------}
procedure TLMDWideLabel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  LS: TLMDString;
begin
  inherited;
  if FRender.IsCursorOverLink(Point(X, Y), Point(0, 0), ClientRect, LS) then
  begin
    Cursor := crHandPoint;
  end
  else
    Cursor := crDefault;
end;

{------------------------------------------------------------------------------}
procedure TLMDWideLabel.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  LS: TLMDString;
begin
  inherited;
  if FRender.IsCursorOverLink(Point(X, Y), Point(0, 0), ClientRect, LS) then
  begin
    if Assigned(FOnLinkClick) then
      FOnLinkClick(Self, LS);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWideLabel.PrepareText;
begin
  if csLoading in ComponentState then
    exit;
  if FIsHTML then
  begin
    FRender.Data.DefaultBgColor := Color;
    FRender.Data.DefaultColor := Font.Color;
    FRender.Data.DefaultStyle := Font.Style;
    FRender.Data.DefaultHeight := Font.Height;
    FRender.Data.DefaultFont := Font.Name;
    FRender.Data.Charset := Font.Charset;

    FRender.PrepareText(LMDReplaceStr(Caption, LMDWideCRLF, '<br>'), Width - BorderWidth * 2, WordWrap);
    FAlreadyInSetBounds := True;
    if WordWrap or AutoSize then
      AdjustBounds;
    FAlreadyInSetBounds := False;

  end;
  Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDWideLabel.CMFontchanged(var Message: TMessage);
begin
  inherited;
  PrepareText;
end;

{------------------------------------------------------------------------------}
procedure TLMDWideLabel.WMSize(var Message: TWMSize);
begin
  inherited;
  PrepareText;
end;

end.
