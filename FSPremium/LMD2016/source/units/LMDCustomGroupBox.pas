unit LMDCustomGroupBox;
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

LMDCustomGroupBox unit (RM)
---------------------------

Changes
-------
Release 8.05 (February 2008)
 * Use of DrawThem Background eliminated

Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Controls, Messages, Graphics,
  LMDGraph, LMD3DCaption, LMDFXCaption, LMDCustomParentPanel;

type
  {--------------------- TLMDCustomGroupBox -----------------------------------}
  TLMDGroupCaptionAlign=(gcaTopLeft, gcaTopCenter, gcaTopRight,
                         gcaLeftBottom, gcaLeftCenter, gcaLeftTop,
                         gcaBottomLeft, gcaBottomCenter,
                         gcaBottomRight, gcaRightTop, gcaRightCenter,
                         gcaRightBottom);

  TLMDCustomGroupBox=class(TLMDCustomParentPanel)
  private
    FAccelChar:Boolean;
    FAlignCaption: TLMDGroupCaptionAlign;
    FCaptionOffSet: integer;
    FCaptionFont:TFont;
    FCaptionParentFont:Boolean;
    FFont3D:TLMD3DCaption;
    FCtlXPCaption:Boolean;

    {internal}
    FCaptionHeight:Integer;
    FFontFX:TLMDFXCaption;
    procedure SetAlignCaption(aValue:TLMDGroupCaptionAlign);
    procedure SetAccelChar(aValue: Boolean);
    procedure SetCaptionOffset(aValue: integer);
    procedure SetCaptionFont(aValue:TFont);
    procedure SetCaptionParentFont(aValue:Boolean);
    procedure SetFont3D(aValue:TLMD3DCaption);
    procedure SetCtlXPCaption(Value:Boolean);
    procedure SetCaptionHeight;
    function GetCaptionHeight:Integer;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMEnabledChanged(var Message: TMessage);message CM_ENABLEDCHANGED;
    procedure CMParentFontChanged(var Message: TMessage); message CM_PARENTFONTCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure AdjustClientRect(var Rect: TRect);override;
    procedure CreateParams(var Params:TCreateParams);override;
    procedure GetChange(Sender:TObject);override;
    procedure Paint; override;
    property CaptionHeight:Integer read GetCaptionHeight;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;

    property Alignment: TLMDGroupCaptionAlign read FAlignCaption write SetAlignCaption default gcaTopLeft;
    property CaptionFont:TFont read FCaptionFont write SetCaptionFont;
    property CaptionFont3D:TLMD3DCaption read FFont3D write SetFont3D;
    property CaptionOffset: integer read FCaptionOffset write SetCaptionOffset default 8;
    property CaptionParentFont: Boolean read FCaptionParentFont write SetCaptionParentFont default True;
    property CtlXP; // compatibility
    property ShowAccelChar:Boolean read FAccelChar write SetAccelChar default True;
  published
    property CtlXPCaptionColor:Boolean read FCtlXPCaption write SetCtlXPCaption default true;
    property ParentColor default true;
    property ParentBackground default true;
    property ThemeMode;
    property ThemeGlobalMode;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
  end;

implementation

uses
  Types, SysUtils, Forms, UxTheme, Themes,
  LMDBase, LMDClass, LMDStrings, LMDUtils,  LMDThemes,LMDGraphUtils;

{*************************** TLMDCustomGroupBox *******************************}
{----------------------- Private ----------------------------------------------}
procedure TLMDCustomGroupBox.SetAlignCaption(aValue:TLMDGroupCaptionAlign);
begin
  if aValue<>FAlignCaption then
    begin
      FAlignCaption:=aValue;
      GetChange(FFont3D);
      ReAlign;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGroupBox.SetCaptionOffset(aValue: integer);
begin
  if aValue<>FCaptionOffset then
    begin
      FCaptionOffset:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGroupBox.SetCaptionFont(aValue:TFont);
begin
  FCaptionFont.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGroupBox.SetFont3D(aValue:TLMD3DCaption);
begin
  FFont3D.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGroupBox.SetCtlXPCaption(Value:Boolean);
begin
  if Value<>FCtlXpCaption then
    begin
      FCtlXpCaption:=Value;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGroupBox.SetAccelChar(aValue:Boolean);
begin
  if aValue<>FAccelChar then
    begin
      FAccelChar:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGroupBox.SetCaptionHeight;
var
  oldfont:TFont;
begin
  case FAlignCaption of
    gcaTopLeft, gcaTopCenter, gcaTopRight,
    gcaBottomLeft,gcaBottomCenter, gcaBottomRight:
      FFontFX.Angle:=0;
    gcaLeftBottom,gcaLeftCenter,gcaLeftTop:
      FFontFX.Angle:=90;
    gcaRightTop,gcaRightCenter,gcaRightBottom:
      FFontFX.Angle:=270;
  end;

  oldfont:=Canvas.Font;
  Canvas.Font:=FCaptionFont;
  if (FFontFX.Angle<>0) and not LMDIsTrueTypeFontCheck(Canvas) then
    FCaptionFont.Name:=LMD_DEFAULTFONT;
  FCaptionHeight:=LMDGet3DTextHeight(FFontFx, FCaptionFont);
  Canvas.Font:=oldFont;
end;

{------------------------------------------------------------------------------}
function TLMDCustomGroupBox.GetCaptionHeight:Integer;
begin
  result:=FCaptionHeight;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGroupBox.SetCaptionParentFont(aValue: Boolean);
begin
  if FCaptionParentFont <> aValue then
    begin
      FCaptionParentFont := aValue;
      if Parent <> nil then Perform(CM_PARENTFONTCHANGED, 0, 0);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGroupBox.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and CanFocus then
      begin
        SelectFirst;
        result:=1;
      end
    else
      inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGroupBox.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Repaint;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomGroupBox.CMParentFontChanged(var Message: TMessage);
begin
  inherited;
  if FCaptionParentFont then
    begin
      if Message.wParam <> 0 then
        SetCaptionFont(TFont(Message.lParam))
      else
        SetCaptionFont(Font);
      FCaptionParentFont := True;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGroupBox.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
  Realign;
end;

{------------------------------ protected  ------------------------------------}
procedure TLMDCustomGroupBox.AlignControls(AControl: TControl; var Rect: TRect);
begin
  case FAlignCaption of
     gcaTopLeft,gcaTopCenter,gcaTopRight:Rect.Top:=Rect.Top+CaptionHeight;
     gcaBottomLeft,gcaBottomCenter,gcaBottomRight:Rect.Bottom:=Rect.Bottom-CaptionHeight;
     gcaLeftBottom,gcaLeftCenter,gcaLeftTop: Rect.Left:=Rect.Left+CaptionHeight;
     gcaRightTop,gcaRightCenter,gcaRightBottom: Rect.Right:=Rect.Right-CaptionHeight;
  end;
  inherited AlignControls(AControl, Rect);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGroupBox.AdjustClientRect(var Rect: TRect);
begin
  inherited AdjustClientRect(Rect);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGroupBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    // we always draw default GroupBox Style, undo default use of bmWindows
    if (Bevel.Mode=bmWindows) then
      begin
        ExStyle := ExStyle and not WS_EX_CLIENTEDGE;
        Style := Style and not WS_BORDER;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGroupBox.GetChange(Sender:TObject);
begin
  if sender=FFont3D then
    begin
      FFontFx.Assign(FFont3D);
      SetCaptionHeight;
      if not (csLoading in ComponentState) then Invalidate;
    end
  else
    begin
      if sender=FCaptionFont then
        FCaptionParentFont := False;
      inherited GetChange(Sender);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGroupBox.Paint;
const
  CAP_STATES: array[Boolean] of TThemedButton = (
    tbGroupBoxDisabled, tbGroupBoxNormal
  );
var
  off1, off2: Integer;
  borderRect, captionRect, bRect: TRect;
  flags: Word;
  TempAlign: TLMDAlignment;
  lThemeMode: TLMDThemeMode;
  dtls: TThemedElementDetails;
  tclr: TColor;

  procedure paintBorder;
  begin
    //parent panel sets support windows mode to true ...
    Bevel.SupportWindowsMode := false;
    if (lThemeMode <> ttmNone) and (Bevel.Mode = bmWindows) then
      LMDThemeServices.DrawElement(lThemeMode, Canvas.Handle, TThemedButton(Ord(
                                   tbGroupBoxNormal)+Ord(not Enabled)), borderRect)
    else
      if Bevel.Mode <> bmWindows then
        Bevel.PaintBevel(Canvas, borderRect, True)
      else
        LMDDrawStdFrame (Canvas, borderRect,lsFrameInset,0);
  end;

begin
  if (csLoading in ComponentState) or not HandleAllocated then
    exit;

  FillControl;
  lThemeMode := UseThemeMode;

  off1:=0;off2:=0;

  if LMDAnsiTrim(Caption)<>'' then
  begin
    case FAlignCaption of
      gcaTopRight, gcaRightTop:
        TempAlign:=agTopRight;
      gcaLeftBottom,gcaBottomLeft:
        TempAlign:=agBottomLeft;
      gcaBottomRight,gcaRightBottom:
        TempAlign:=agBottomRight;
      gcaTopCenter:
        TempAlign:=agTopCenter;
      gcaLeftCenter:
        TempAlign:=agCenterLeft;
      gcaRightCenter:
        TempAlign:=agCenterRight;
      gcaBottomCenter:
        TempAlign:=agBottomCenter
      else
        TempAlign:=agTopLeft;
    end;

    case FAlignCaption of
      gcaTopLeft, gcaLeftBottom, gcaBottomLeft, gcaRightTop: off1:=FCaptionOffset;
      gcaLeftTop, gcaTopRight, gcaBottomRight, gcaRightBottom: off2:=FCaptionOffset;
    end;

    case FAlignCaption of
      gcaTopLeft,gcaTopCenter,gcaTopRight:
      begin
        captionRect := Rect(off1, 0, Width-off2, CaptionHeight);
        borderRect := Rect(0, CaptionHeight div 2 - 1, Width, Height);
      end;
      gcaBottomLeft,gcaBottomCenter,gcaBottomRight:
      begin
        captionRect:=Rect(off1, Height-CaptionHeight, Width-off2, Height);
        borderRect := Rect(0, 0, Width, Height-(CaptionHeight div 2 -1));
      end;
      gcaLeftBottom,gcaLeftCenter,gcaLeftTop:
      begin
        captionRect:=Rect(0, off2, CaptionHeight, Height-off1);
        borderRect := Rect(CaptionHeight div 2 -1, 0, Width, Height);
      end;
      gcaRightTop,gcaRightCenter,gcaRightBottom:
      begin
        captionRect:=Rect(Width-CaptionHeight, off1+2, Width, Height-off2);
        borderRect := Rect(0, 0, Width-(CaptionHeight div 2 -1), Height);
      end;
    end;

    flags:=0;
    flags:=DrawTextBiDiModeFlags(flags);
    captionRect:=LMDAlignTextRect(TempAlign, Caption, FFontFX, captionRect,
                                  FCaptionFont, False, FAccelChar, flags);

    {Flags for DrawText}
    flags:=DT_SINGLELINE or DT_EXPANDTABS or TLMDAlignFlags[TempAlign];
    if not FAccelChar then
      Flags:=Flags or DT_NOPREFIX;

    bRect:=captionRect;
    case FAlignCaption of
      gcaTopLeft,gcaTopCenter,gcaTopRight,
      gcaBottomLeft, gcaBottomCenter,gcaBottomRight:bRect.Left:=bRect.Left-2;
      gcaLeftBottom,gcaLeftCenter,gcaLeftTop:bRect.Bottom:=bRect.Bottom+2;
      gcaRightTop,gcaRightCenter,gcaRightBottom:bRect.Top:=bRect.Top-2;
    end;

    {bRect.Left, bRect.Top}
   with CaptionRect do
     ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
   paintBorder;
   SelectClipRgn(Canvas.Handle, 0);

   Canvas.Brush.Color:=Color;
   Canvas.Font:=FCaptionFont;

   if (lThemeMode <> ttmNone) and FCtlXPCaption then
   begin
      dtls := LMDThemeServices.GetDetails(teButton, Ord(CAP_STATES[Enabled]));
      tclr := LMDThemeServices.GetThemeColor(lThemeMode, dtls, TMT_TEXTCOLOR);

      if tclr <> clNone then
        Canvas.Font.Color := tclr
      else
        Canvas.Font.Color := clWindowText;
   end;

   LMDDrawTextExt(Canvas, Caption, FFontFX, captionRect, flags,
                  [TLMDDrawTextStyle(Enabled)], nil);

   Canvas.Font:=Font;
  end
  else
  begin
    borderRect := ClientRect;
    paintBorder;
  end;
end;

{------------------------------ public ----------------------------------------}
constructor TLMDCustomGroupBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle+[csSetCaption, csAcceptsControls];
  FFont3D:=TLMD3DCaption.Create;
  FFont3D.OnChange:=GetChange;
  FBevel.SupportWindowsMode := false;

  FCaptionFont:=TFont.Create;
  FCaptionFont.OnChange:=GetChange;

  FCaptionParentFont := True;
  FFontFX:=TLMDFXCaption.Create;

  FAccelChar:=True;
  FAlignCaption:=gcaTopLeft;
  FCaptionOffset:=8;

  // changed in release 7.0
  FBevel.Mode:=bmWindows;
  //
  FCtlXPCaption:=true;
  SetCaptionHeight;
  // 8.02
  inherited ParentColor := true;
  // ---
  Width:=185;
  Height:=105;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomGroupBox.Destroy;
begin
  FCaptionFont.OnChange:=nil;
  FFont3D.OnChange:=nil;
  FCaptionFont.Free;
  FFont3D.Free;
  FFontFX.Free;
  inherited Destroy;
end;

end.
