unit ElGroupBox;
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

ElGroupBox unit
---------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils,
  Classes,
  Types,
  Stdctrls,
  Messages,
  Controls,
  Windows,
  Graphics,
  CommCtrl,
  ExtCtrls,
  Forms,
  ImgList,
  Math,
  Themes, UxTheme,
  LMDThemes,
  LMDProcs,
  LMDClass,
  LMDObjectList,
  LMDGraphUtils,
  LMDGraph,
  LMDHTMLUnit,
  LMDTypes,

  ElImgFrm,
  ElPanel,
  ElVCLUtils,
  ElSndMap,
  ElXPThemedControl,
  ElCheckCtl;

type

  TCustomElGroupBox = class(TCustomElPanel)
  protected
    FReading  : Boolean;
    FRender   : TLMDHTMLRender;
    FIsHTML: Boolean;
    FBorderSides: TLMDBorderSides;
    FTextRect,
    FCheckRect  : TRect;
    FCheckSound: TElSoundName;
    FGlyph: TBitmap;
    FImages: TCustomImageList;
    FAlphaImages: TCustomImageList;
    FSoundMap: TElSoundMap;
    FUseCustomGlyphs: Boolean;
    FUseImageList: Boolean;
    FChLink: TChangeLink;
    FAChLink: TChangeLink;
    FShowCheckBox: Boolean;
    FCheckBoxChecked: Boolean;
    FShowFocus: Boolean;
    FCaptionColor: TColor;
    FMouseInText,
    FMouseInCheckBox : boolean;
    FCaptured   : boolean;
    FOldCapture : HWND;
    FFlat: Boolean;
    FFlatAlways: Boolean;
    FAutoDisableChildren: Boolean;
    FMoneyFlat: Boolean;
    FMoneyFlatInactiveColor: TColor;
    FMoneyFlatActiveColor: TColor;
    FMoneyFlatDownColor: TColor;
    procedure DrawFrame;
    procedure WMNCPaint(var Msg : TWMNCPaint); message WM_NCPAINT;
    procedure SetTransparentXPThemes(Value: Boolean); override;
    procedure CMDialogChar(var Message : TCMDialogChar); message CM_DIALOGCHAR;
    procedure SetBorderSides(Value: TLMDBorderSides);
    procedure ImagesChanged(Sender: TObject);
    procedure SetIsHTML(Value: Boolean); virtual;
    procedure ReadState(Reader: TReader); override;
    function  CanModify: Boolean; virtual;
//    procedure Paint; override;
    function GetThemedElement: TThemedElement; override;
    procedure SetShowCheckBox(Value: Boolean);
    procedure SetCheckBoxChecked(Value: Boolean); virtual;
    procedure SetShowFocus(Value: Boolean);
    procedure SetCaptionColor(Value: TColor);
    procedure SetEnabled( Value: Boolean); override;
    procedure SetCheckSound(Value: TElSoundName); virtual;
    procedure SetGlyph(Value: TBitmap); virtual;
    procedure SetSoundMap(Value: TElSoundMap); virtual;
    procedure SetUseCustomGlyphs(Value: Boolean); virtual;
    procedure SetImages(Value: TCustomImageList); virtual;
    procedure SetAlphaImages(Value: TCustomImageList); virtual;
    procedure SetUseImageList(Value: Boolean); virtual;
    procedure Notification(AComponent : TComponent; operation : TOperation);
        override;
    procedure GlyphChange(Sender : TObject); virtual;
    function GetCheckBoxSize: TSize;
    procedure DrawGlyph(Canvas : TCanvas; DestRect: TRect; SrcRect: TRect); virtual;
    procedure SetFlat(newValue : boolean); virtual;
    procedure DrawFlatFrame(Canvas : TCanvas; R : TRect);
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
        override;
    procedure MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
        override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure KeyDown(var Key : Word; Shift : TShiftState); override;
    procedure AdjustClientRect(var Rect: TRect); override;
    function GetTopOffset: Integer;
    procedure WMKillFocus(var Msg : TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Msg : TWMSetFocus); message WM_SETFOCUS;
//    procedure WMEraseBkGnd(var Msg : TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure SetFlatAlways(Value: Boolean);
    function GetCaptionRect: TRect;
    function GetCheckRect: TRect;
    function GetLineTopOffset: Integer;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure SetAutoDisableChildren(Value: Boolean);
    procedure SetMoneyFlat(Value: Boolean); virtual;
    procedure SetMoneyFlatInactiveColor(Value: TColor); virtual;
    procedure SetMoneyFlatActiveColor(Value: TColor); virtual;
    procedure SetMoneyFlatDownColor(Value: TColor); virtual;
    function GetMoneyFlat: Boolean;
    property IsHTML: Boolean read FIsHTML write SetIsHTML default false;
    property BorderSides: TLMDBorderSides read FBorderSides write SetBorderSides default [ebsLeft, ebsRight, ebsTop, ebsBottom];
    property ShowCheckBox: Boolean read FShowCheckBox write SetShowCheckBox
        default false;
    property CheckBoxChecked: Boolean read FCheckBoxChecked write
        SetCheckBoxChecked default true;
    property ShowFocus: Boolean read FShowFocus write SetShowFocus default False;
    property CaptionColor: TColor read FCaptionColor write SetCaptionColor default
        clNone;
    property CheckSound: TElSoundName read FCheckSound write SetCheckSound;
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property Images: TCustomImageList read FImages write SetImages;
    property AlphaForImages: TCustomImageList read FAlphaImages write SetAlphaImages;
    property SoundMap: TElSoundMap read FSoundMap write SetSoundMap;
    property UseCustomGlyphs: Boolean read FUseCustomGlyphs write
        SetUseCustomGlyphs default false;
    property UseImageList: Boolean read FUseImageList write SetUseImageList default
        false;
    property Flat: Boolean read FFlat write SetFlat default False;
    property FlatAlways: Boolean read FFlatAlways write SetFlatAlways default False;
    property AutoDisableChildren: Boolean read FAutoDisableChildren write SetAutoDisableChildren default False;
    property MoneyFlat: Boolean read GetMoneyFlat write SetMoneyFlat default false;
    property MoneyFlatInactiveColor: TColor read FMoneyFlatInactiveColor write SetMoneyFlatInactiveColor stored GetMoneyFlat;
    property MoneyFlatActiveColor: TColor read FMoneyFlatActiveColor write
        SetMoneyFlatActiveColor stored GetMoneyFlat;
    property MoneyFlatDownColor: TColor read FMoneyFlatDownColor write
        SetMoneyFlatDownColor stored GetMoneyFlat;
    procedure Loaded; override;
    procedure RepaintRect(ARect: TRect); override;
    function GetThemedElementInState: TThemedButton; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure FlipChildren(AllLevels: Boolean); override;

  published
    property DoubleBuffered default false;
  end;

  TElGroupBox = class(TCustomElGroupBox)
  published
    property Align;

    property Anchors;
    property AutoDisableChildren;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    property BorderSides;
    property Caption;
    property CaptionColor;
    property CheckBoxChecked;
    property CheckSound;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Flat;
    property FlatAlways;
    property Font;
    property Glyph;
    property ImageForm;
    property Images;
    property AlphaForImages;
    property MoneyFlat;
    property MoneyFlatInactiveColor;
    property MoneyFlatActiveColor;
    property MoneyFlatDownColor;
    property IsHTML;
    property ParentCtl3D;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowCheckBox;
    property ShowFocus;
    property ShowHint;
    property SoundMap;
    property TabOrder;
    property TabStop;
    property Transparent;
    property TransparentXPThemes;
    property UseCustomGlyphs;
    property UseImageList;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;
    property Visible;
    property AutoSize;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;
    property OnResize;
    property OnStartDrag;

    property OnContextPopup;

  end;

implementation

const CheckBoxSize = 13;
      CheckMargin = 5;

constructor TCustomElGroupBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csOpaque, csSetCaption, csAcceptsControls, csDoubleClicks];
  FBorderSides := AllBorderSides;
  FCaptionColor := clNone;
  FCheckBoxChecked := true;
  FGlyph := TBitmap.Create;
  FGlyph.OnChange := GlyphChange;
  FChLink := TChangeLink.Create;
  FChLink.OnChange := ImagesChanged;
  FAChLink := TChangeLink.Create;
  FAChLink.OnChange := ImagesChanged;
  DoubleBuffered := false;
end;

destructor TCustomElGroupBox.Destroy;
begin

  if IsHTML then
    FRender.Free;

  FGlyph.Free;
  FGlyph := nil;
  FChLink.Free;
  FChLink := nil;
  FAChLink.Free;
  FAChLink := nil;
  inherited Destroy;
end;

procedure TCustomElGroupBox.FlipChildren(AllLevels: Boolean);
begin
end;

procedure TCustomElGroupBox.ReadState(Reader: TReader);
begin
  FReading := True;
  inherited ReadState(Reader);
  FReading := False;
end;

function TCustomElGroupBox.CanModify: Boolean;
begin
  Result := True;
end;

procedure TCustomElGroupBox.DrawFrame;
var
  R1: Trect;
begin
  if not IsThemed then
  begin
    R1 := ClientRect;
    with Canvas do
    begin
      if not IsRectEmpty(FTextRect) then
        with R1 do
          ExcludeClipRect(Canvas.Handle, FTextRect.Left, FTextRect.Top, FTextRect.Right, FTextRect.Bottom);
      begin
        inc(R1.Top, FTextRect.Bottom div 2);
        if Ctl3D and not MoneyFlat then
        begin
          Inc(R1.Left);
          Inc(R1.Top);
          DrawBevel(Canvas.Handle, R1, clBtnHighlight, clBtnHighlight, BorderSides);
          OffsetRect(R1, -1, -1);
          Brush.Color := clBtnShadow;
          end
        else
          if MoneyFlat then
            Brush.Color := MoneyFlatInactiveColor
          else
            Brush.Color := clWindowFrame;
        DrawBevel(Canvas.Handle, R1, Brush.Color, Brush.Color, BorderSides);
      end;
    end;
  end;
end;

procedure TCustomElGroupBox.WMNCPaint(var Msg: TWMNCPaint);
//var
//  R1: Trect;
begin
  exit;
  if not IsThemed then
  begin
    DrawFrame;
    Msg.Result := 1;
//    R1 := ClientRect;
//    with Canvas do
//    begin
//      with R1 do
//        ExcludeClipRect(Canvas.Handle, FTextRect.Left, FTextRect.Top, FTextRect.Right, FTextRect.Bottom);
//      begin
//        if Ctl3D and not MoneyFlat then
//        begin
//          Inc(R1.Left);
//          Inc(R1.Top);
//          DrawBevel(Canvas.Handle, R1, clBtnHighlight, clBtnHighlight, BorderSides);
//          OffsetRect(R1, -1, -1);
//          Brush.Color := clBtnShadow;
//          end
//        else
//          if MoneyFlat then
//            Brush.Color := MoneyFlatInactiveColor
//          else
//            Brush.Color := clWindowFrame;
//        DrawBevel(Canvas.Handle, R1, Brush.Color, Brush.Color, BorderSides);
//      end;
//    end;
  end;
end;

procedure TCustomElGroupBox.RepaintRect(ARect: TRect);
var
  FDefaultImageNeed: Boolean;
  H: Integer;
  Flags : Longint;
  SrcRect,
  CheckRect : TRect;
  cbh,
  cbw   : integer;
  i,
  ImgIdx: integer;
  R1,
  R,
  R2
  ,Rect
  : TRect;
  DC   : HDC;
  ACtl : TWinControl;
  P    : TPoint;
  ax,
  ay   : integer;
  RClip: TRect;
  c    : ColorRef;

  LCanvas: TCanvas;
  Bitmap: TBitmap;

  BMP : TBitmap;
  amBMP : TBitmap;
  LInst: ILMDElParentControlInterface;
  LDetail: TThemedButton;
  LThemeMode: TLMDThemeMode;

  procedure DrawGroupBevel(Canvas : TCanvas; R, R1 : TRect; Color1, Color2 : TColor; BorderSides : TLMDBorderSides);
  begin
    DrawBevel(Canvas.Handle, R, Color1, Color2, BorderSides * [ebsLeft, ebsRight, ebsBottom]);
    if ebsTop in BorderSides then
    begin
      if R1.Left > 0 then
        DrawBevel(Canvas.Handle, Classes.Rect(R.Left, R.Top, R1.Left, R.Bottom), Color1, Color2, [ebsTop]);
      if R1.Right < R.Right then
        DrawBevel(Canvas.Handle, Classes.Rect(R1.Right, R.Top, R.Right, R.Bottom), Color1, Color2, [ebsTop]);
    end;
    end;

begin
  Bitmap := TBitmap.Create;
  Bitmap.Width := Abs(Width);
  Bitmap.Height := Height;
  Bitmap.Handle := CreateCompatibleBitmap(Self.Canvas.Handle, Abs(Width), Height);
  LCanvas := Bitmap.Canvas;
  LThemeMode := UseThemeMode;
  bitblt(LCanvas.Handle, 0, 0, Bitmap.Width, Bitmap.Height, Self.Canvas.Handle, 0, 0, SRCCOPY);
  if LThemeMode = ttmNone then
  begin
    if (ImageForm <> nil) and (not (csDesigning in ImageForm.ComponentState)) then
    begin
      if (ImageForm.Control <> Self) then
      begin
        ACtl := FImgForm.GetRealControl;
        R1 := ClientRect;
        R2 := ClientRect;
        R2.TopLeft := ClientToScreen(R2.TopLeft);
        R2.BottomRight := ClientToScreen(R2.BottomRight);

        P := Parent.ClientToScreen(Point(Self.Left, Self.Top));
        ax := R2.Left - P.x;
        ay := R2.Top - P.y;

        R2.TopLeft := ACtl.ScreenToClient(R2.TopLeft);
        R2.BottomRight := ACtl.ScreenToClient(R2.BottomRight);

        FImgForm.PaintBkgnd(LCanvas.Handle, R1, Point(R2.Left - ax, R2.Top - ay), false);
        if AlphaLevel <> 0 then
        begin
          LMDAlphaFillRect(LCanvas, Classes.Rect(0, 0, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top), Color, AlphaLevel);
        end;
      end;
    end
    else
    if Transparent then
    begin
      DC := GetDC(Handle);
      R2 := ARect;
      OffsetRect(R2, Left, Top);
      if Assigned(parent) then
        if Supports(Parent, ILMDElParentControlInterface, LInst) then
          Linst.RepaintRect(R2)
        else
          RedrawWindow(Parent.Handle, @R2, 0, RDW_ERASE or RDW_INVALIDATE or RDW_NOCHILDREN or RDW_UPDATENOW);
      OffsetRect(R2, -Left, -Top);

      bitblt(LCanvas.Handle, R2.Left, R2.Top, R2.Right - R2.Left, R2.Bottom - R2.Top, DC, R2.Left, R2.Top, SRCCOPY);
      ReleaseDC(Handle, DC);
    end
    else
    begin
//      R2 := Canvas.ClipRect;
      // GetClipBox(Canvas.Handle, R2);
      LCanvas.Brush.Color := Color;
      LCanvas.FillRect(ARect);
    end;
  end;

  if IsHTML then
  begin
    if LThemeMode <> ttmNone then
    begin
      if not Enabled then
        LDetail := tbGroupBoxDisabled
      else
        LDetail := tbGroupBoxNormal;
      C := LMDThemeServices.GetThemeColor(LThemeMode, teButton, ThemeServices.GetElementDetails(LDetail).Part, ThemeServices.GetElementDetails(LDetail).State, TMT_TEXTCOLOR);
    end
    else
    C := Font.Color;

    FRender.Data.DefaultFont := Font.Name;
    FRender.Data.DefaultColor := C;
    FRender.Data.DefaultHeight := Font.Height;
    FRender.Data.DefaultStyle := Font.Style;
    FRender.Data.Charset := Font.Charset;
    FRender.Data.DefaultBgColor := clNone;

    FRender.PrepareText(Caption, 0, false);

    H := FRender.Data.TextSize.cy;
  end
  else

  begin
    with LCanvas do
    begin
      Font := Self.Font;
      H := TextHeight('0');
    end;
  end;

  if (FCaptionColor <> clNone) and (not IsThemed) then
  begin
    R := Classes.Rect(0, 0, Abs(Width), H);
    LCanvas.Brush.Color := FCaptionColor;
    LCanvas.FillRect(R);
  end;

  FDefaultImageNeed := False;
  if ShowCheckBox then
  begin
    if (LThemeMode = ttmNone) or ((FUseCustomGlyphs and (not FGlyph.Empty)) or FUseImageList) then
    begin
      i := 0;
      ImgIdx := 0;
      if FUseCustomGlyphs and (not FGlyph.Empty) then
      begin
        cbh := FGlyph.Height;
        cbw := FGlyph.Width div 6;
        if not CheckBoxChecked then
        begin
          if Enabled and (not (FPressed and (FMouseInCheckBox or FMouseInText))) then
            SrcRect := Classes.Rect(0, 0, cbw, cbh)
          else
            SrcRect := Classes.Rect(cbw, 0, cbw * 2, cbh);
        end
        else
        begin
          if Enabled and (not (FPressed and (FMouseInCheckBox or FMouseInText))) then
            SrcRect := Classes.Rect(cbw * 2, 0, cbw * 3, cbh)
          else
            SrcRect := Classes.Rect(cbw * 3, 0, cbw * 4, cbh);
        end;
      end
      else
      begin
        if FUseImageList and (Self.FImages <> nil) then
        begin
          cbw := FImages.Width;
          cbh := FImages.Height;
          if not CheckBoxChecked then
          begin
            if Enabled and (not (FPressed and (FMouseInCheckBox or FMouseInText)))
            then
              ImgIdx := 0
            else
              ImgIdx := 1;
          end
          else
          begin
            if Enabled and (not (FPressed and (FMouseInCheckBox or FMouseInText)))
            then
              ImgIdx := 2
            else
              ImgIdx := 3;
          end;
        end
        else
        begin
          cbw := GetCheckBoxSize.cx;
          cbh := GetCheckBoxSize.cy;
        end;
        if not CheckBoxChecked then
          i := DFCS_BUTTONCHECK
        else
          i := DFCS_BUTTONCHECK or DFCS_CHECKED;

        if (not Enabled) or ((FMouseInCheckBox or FMouseInText) and FPressed) then
          i := i or DFCS_INACTIVE;
        end;
      CheckRect := Classes.Rect(8, (H div 2 - cbh div 2), 8 + cbw, 0);
      CheckRect.Bottom := CheckRect.Top + cbh;

      if UseCustomGlyphs and (not FGlyph.Empty) then
        DrawGlyph(LCanvas, CheckRect, SrcRect)
      else
      begin
        if FUseImageList and (FImages <> nil) then
        begin
          if (FAlphaImages <> nil) and (FAlphaImages.Count > ImgIdx) then
          begin
            BMP := TBitmap.Create;
            BMP.Width := FImages.Width;
            BMP.Height := FImages.Height;
            ImageList_DrawEx(FImages.Handle, ImgIdx, BMP.Canvas.Handle, 0, 0, 0, 0,
              clNone, clNone, ILD_Normal);

            amBMP := TBitmap.Create;
            amBMP.Width := FAlphaImages.Width;
            amBMP.Height := FAlphaImages.Height;
            ImageList_DrawEx(FAlphaImages.Handle, ImgIdx, amBMP.Canvas.Handle, 0, 0, 0, 0,
              clNone, clNone, ILD_Normal);

            LMdAlphaCopyRect2(LCanvas.Handle, CheckRect, BMP.Canvas.Handle,
              Classes.Rect(0, 0, BMP.Width, BMP.Height), amBMP, 255);

            amBMP.Free;
            BMP.Free;
          end
          else
          FImages.Draw(LCanvas, CheckRect.Left, CheckRect.Top, ImgIdx);
        end
        else
        begin
          FDefaultImageNeed := True;
          if not IsThemed then
          begin
            DrawFrameControl(LCanvas.Handle, CheckRect, DFC_BUTTON, i);
            if MoneyFlat or ((Flat and (not (Focused or (FMouseInCheckBox or FMouseInText)))) or FlatAlways) {and Enabled} then
              DrawFlatFrame(LCanvas, CheckRect);
          end;
        end;
      end;
    end
    else // XP-style checkmarks
      FDefaultImageNeed := True;
    if (LThemeMode <> ttmNone) and FDefaultImageNeed then
    begin
      LDetail := GetThemedElementInState;
      cbw := GetCheckBoxSize.cx;
      cbh := GetCheckBoxSize.cy;

      CheckRect := Classes.Rect(8, (H div 2 - cbh div 2), 8 + cbw, 0);
      CheckRect.Bottom := CheckRect.Top + cbh;
      LMDThemeServices.DrawElement(LThemeMode, LCanvas.Handle, LDetail, CheckRect);
      end;

    FCheckRect := CheckRect;
  end
  else
    SetRectEmpty(FCheckRect);

  if IsHTML then
  begin
    R := Classes.Rect(0, H div 2, Width, Height);
    R1 := R;

    if Text <> '' then
    begin
      if FCheckRect.Right <> 0 then
        R := Classes.Rect(FCheckRect.Right + CheckMargin, 0, FCheckRect.Right + CheckMargin + FRender.Data.TextSize.cx, H)
      else
        R := Classes.Rect(8, 0, 8 + FRender.Data.TextSize.cx, H);
      FRender.DrawText(LCanvas, Point(0, 0), R, clNone);
      InflateRect(R, 1, 0);
      FTextRect := R;

      if ShowFocus and Focused then
      begin
        InflateRect(R, 1, 0);
        ElVCLUtils.DrawFocus(LCanvas, R);
//        Canvas.DrawFocusRect(R);
        InflateRect(R, -1, 0);
      end;

      if FCheckRect.Left <> 0 then
        R.Left := FCheckRect.Left;
    end
    else
      R := FCheckRect;

    with R do
       ExcludeClipRect(LCanvas.Handle, Left, Top, Right, Bottom);
    if LThemeMode <> ttmNone then
    begin
      if not Enabled then
        LDetail := tbGroupBoxDisabled
      else
        LDetail := tbGroupBoxNORMAL;

      RClip := LCanvas.ClipRect;
      if BorderSides <> [] then
      begin
        LMDThemeServices.DrawElement(LThemeMode, LCanvas.Handle, LDetail, R1);
      end;
    end
    else
    begin
      if Ctl3D and (not MoneyFlat) then
      begin
        Inc(R1.Left);
        Inc(R1.Top);
        DrawBevel(LCanvas.Handle, R1, clBtnHighlight, clBtnHighlight, BorderSides);
        OffsetRect(R1, -1, -1);
        Brush.Color := clBtnShadow;
        end
      else
        if MoneyFlat then
          Brush.Color := MoneyFlatInactiveColor
        else
          Brush.Color := clWindowFrame
      ;

      DrawBevel(LCanvas.Handle, R1, Brush.Color, Brush.Color, BorderSides);
      end;
  end
  else
  with LCanvas do
  begin
    Font := Self.Font;
    R := Classes.Rect(0, H div 2, Abs(Width), Height);
    R1 := R;

    if Caption <> '' then
    begin
      if LThemeMode <> ttmNone then
      begin
        if not Enabled then
          LDetail := tbGroupBoxDisabled
        else
          LDetail := tbGroupBoxNormal;

        Flags := DT_LEFT;
        RClip := ClientRect;
        SetRectEmpty(R);
        LMDThemeServices.GetThemeTextExtent(LThemeMode, LCanvas.Handle, ThemeServices.GetElementDetails(LDetail),
          Caption, Length(Caption), Flags, LMDRectToPtr(RClip), R);

        LCanvas.Brush.Style := bsClear;
        //R := R1;
        if FCheckRect.Left <> 0 then
          OffsetRect(R, FCheckRect.Right + CheckMargin, 0)
        else
          OffsetRect(R, 8, 0);

        LMDThemeServices.DrawThemeText(LThemeMode, LCanvas.Handle, ThemeServices.GetElementDetails(LDetail),
        PWideChar(WideString(Caption)),
        Length(WideString(Caption)), Flags, 0, R);
        InflateRect(R, 1, 0);
        FTextRect := R;

        if ShowFocus and Focused then
        begin
          InflateRect(R, 1, 0);
          ElVCLUtils.DrawFocus(LCanvas, R);
//          DrawFocusRect(R);
          InflateRect(R, -1, 0);
        end;
      end
      else
      begin
        R := Classes.Rect(0, 0, 0, H);

        Flags := DT_LEFT;
        LMDDrawText(Handle, Caption, Length(Caption), R, Flags or DT_CALCRECT);
        // Brush.Color := Color;

        if FCheckRect.Left <> 0 then
          OffsetRect(R, FCheckRect.Right + CheckMargin, 0)
        else
          OffsetRect(R, 8, 0);

        LCanvas.Brush.Style := bsClear;
        LMDDrawText(Handle, Caption, Length(Caption), R, Flags);
        InflateRect(R, 1, 0);
        FTextRect := R;

        if ShowFocus and Focused then
        begin
//          InflateRect(R, 1, 0);
          //LMDElDebug(PChar('We are focused ' + Format('%d:%d, %d:%d', [r.left, r.top, r.right, r.bottom])));
          //LMDElDebug(PChar('ClipRect is ' + Format('%d:%d, %d:%d', [r2.left, r2.top, r2.right, r2.bottom])));
          ElVCLUtils.DrawFocus(LCanvas, R);
//          Windows.DrawFocusRect(Canvas.Handle, R);
          InflateRect(R, -1, 0);
        end;
      end;
      if FCheckRect.Left <> 0 then
        R.Left := FCheckRect.Left;
    end
    else
      R := FCheckRect;
    with R do
      ExcludeClipRect(LCanvas.Handle, Left, Top, Right, Bottom);
    if LThemeMode <> ttmNone then
    begin
      if not Enabled then
        LDetail := tbGroupBoxDisabled
      else
        LDetail := tbGroupBoxNormal;
      RClip := LCanvas.ClipRect;
      if BorderSides <> [] then
      begin
        LMDThemeServices.DrawElement(LThemeMode, LCanvas.Handle, LDetail, R1, LMDRectToPtr(RClip));
      end;
    end
    else
    begin
      if Ctl3D and not MoneyFlat then
      begin
        Inc(R1.Left);
        Inc(R1.Top);
        DrawBevel(LCanvas.Handle, R1, clBtnHighlight, clBtnHighlight, BorderSides);
        OffsetRect(R1, -1, -1);
        Brush.Color := clBtnShadow;
        end
      else
        if MoneyFlat then
          Brush.Color := MoneyFlatInactiveColor
        else
          Brush.Color := clWindowFrame;

      DrawBevel(LCanvas.Handle, R1, Brush.Color, Brush.Color, BorderSides);
    end;
  end;

  bitblt(Self.Canvas.Handle, ARect.Left, ARect.Top, ARect.right - ARect.Left, ARect.Bottom - ARect.Top, Bitmap.Canvas.Handle, ARect.Left, ARect.Top, SRCCOPY);
  Bitmap.Free;
end;

//procedure TCustomElGroupBox.Paint;
//begin
//  RepaintRect(ClientRect);
//end;

//procedure TCustomElGroupBox.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
//var
//  R: TRect;
//begin
//  if not IsThemed then
//  begin
//    inherited;
//    DrawFrame;
//    Msg.Result := 1;
//  end;
//  if IsThemed then
//  begin
//      R := ClientRect;
//      DrawThemeParentBackground(Handle, Msg.DC, {$ifndef LMDDISABLE_LMDTHEMES}R{$else}@R{$endif});
//    (*
//    R1 := GetCaptionRect;
//
//    R := ClientRect;
//    H := GetLineTopOffset;
//
//    R.Top := H div 2;
//    DrawThemeBackground(Theme, Msg.DC, BP_GROUPBOX, 0, R, nil);
//    DrawThemeParentBackground(Handle, Msg.DC, R1);
//    *)
//  end;
//  Msg.Result := 1;
//end;

procedure TCustomElGroupBox.SetIsHTML(Value: Boolean);
begin
  if FIsHTML <> Value then
  begin
    FIsHTML := Value;
    if FIsHTML then
      FRender := TLMDHTMLRender.Create
    else
      FRender.Free;
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TCustomElGroupBox.SetBorderSides(Value: TLMDBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TCustomElGroupBox.SetShowCheckBox(Value: Boolean);
begin
  if FShowCheckBox <> Value then
  begin
    FShowCheckBox := Value;
    Invalidate;
  end;
end;

procedure TCustomElGroupBox.SetCheckBoxChecked(Value: Boolean);
var i : integer;
begin
  if FCheckBoxChecked <> Value then
  begin
    FCheckBoxChecked := Value;
    if ShowCheckBox then
    begin
      if FAutoDisableChildren then
        for I := 0 to ControlCount - 1 do
          Controls[i].Enabled := Enabled and ((not ShowCheckBox) or CheckboxChecked);
      InvalidateRect(Handle, @FCheckRect, true);
    end;
  end;
end;

procedure TCustomElGroupBox.SetShowFocus(Value: Boolean);
begin
  if FShowFocus <> Value then
  begin
    FShowFocus := Value;
    Invalidate;
  end;
end;

procedure TCustomElGroupBox.SetCaptionColor(Value: TColor);
begin
  if FCaptionColor <> Value then
  begin
    FCaptionColor := Value;
    Invalidate;
  end;
end;

procedure TCustomElGroupBox.SetEnabled( Value: Boolean);
var
  I: integer;
begin
  inherited;
  if FAutoDisableChildren then
    for I := 0 to ControlCount - 1 do
      Controls[i].Enabled := Enabled and ((not ShowCheckBox) or CheckboxChecked);
end;

procedure TCustomElGroupBox.SetCheckSound(Value: TElSoundName);
begin
  if FCheckSound <> Value then
  begin
    FCheckSound := Value;
  end;
end;

procedure TCustomElGroupBox.SetGlyph(Value: TBitmap);
begin
  FGlyph.Assign(Value);
end;

procedure TCustomElGroupBox.SetImages(Value: TCustomImageList);
var b : boolean;
begin
  if FImages <> Value then
  begin
    b := FImages = nil;
    if not b then
    begin
      if not (csDestroying in FImages.ComponentState) then
        FImages.RemoveFreeNotification(Self);
      FImages.UnRegisterChanges(FChLink);
    end;
    FImages := Value;
    if FImages <> nil then
    begin
      FImages.FreeNotification(Self);
      FImages.RegisterChanges(FChLink);
    end;

    if FImages = nil then
      UseImageList := false
    else
    if b and (not (csLoading in ComponentState)) then
      UseImageList := true;
  end;
end;

procedure TCustomElGroupBox.SetAlphaImages(Value: TCustomImageList);
begin
  if FAlphaImages <> Value then
  begin
    if FAlphaImages <> nil then
    begin
      if not (csDestroying in FAlphaImages.ComponentState) then
        FAlphaImages.RemoveFreeNotification(Self);
      FAlphaImages.UnRegisterChanges(FAChLink);
    end;
    FAlphaImages := Value;
    if FAlphaImages <> nil then
    begin
      FAlphaImages.FreeNotification(Self);
      FAlphaImages.RegisterChanges(FAChLink);
    end;
  end;
end;

procedure TCustomElGroupBox.SetSoundMap(Value: TElSoundMap);
begin
  if FSoundMap <> Value then
  begin
    if FSoundMap <> nil then
      if not (csDestroying in FSoundMap.ComponentState) then
        FSoundmap.RemoveFreeNotification(Self);
    FSoundMap := Value;
    if FSoundMap <> nil then
      FSoundmap.FreeNotification(Self);
  end;
end;

procedure TCustomElGroupBox.SetUseCustomGlyphs(Value: Boolean);
begin
  if FUseCustomGlyphs <> Value then
  begin
    FUseCustomGlyphs := Value;
    if ShowCheckBox then Invalidate;
  end;
end;

procedure TCustomElGroupBox.SetUseImageList(Value: Boolean);
begin
  if FUseImageList <> Value then
  begin
    FUseImageList := Value;
    if ShowCheckBox then Invalidate;
  end;
end;

procedure TCustomElGroupBox.ImagesChanged(Sender: TObject);
begin
  if FUseImageList and ShowCheckBox then
    Invalidate;
end;

procedure TCustomElGroupBox.Notification(AComponent : TComponent; operation :
    TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
  begin

    if (AComponent = FSoundMap) then SoundMap := nil;

    if AComponent = Images then
      Images := nil;
    if AComponent = AlphaForImages then
      AlphaForImages := nil;
  end; { if }
end; { Notification }

procedure TCustomElGroupBox.GlyphChange(Sender : TObject);
begin
  if UseCustomGlyphs then Invalidate;
end;

function TCustomElGroupBox.GetCheckBoxSize: TSize;
begin
  Result.cx := CheckBoxSize;
  Result.cy := CheckBoxSize;
  if IsThemed then
    LMDThemeServices.GetThemePartSize(ThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(tbCheckBoxCheckedNormal), Result);
end;

procedure TCustomElGroupBox.DrawGlyph(Canvas : TCanvas; DestRect: TRect;
    SrcRect: TRect);
begin
  LMDDrawTransparentBitmapEx(Canvas.Handle, FGlyph, DestRect.Left, DestRect.Top, SrcRect, FGlyph.Canvas.Pixels[SrcRect.Left, SrcRect.Bottom - 1]);
end;

procedure TCustomElGroupBox.SetFlat(newValue : boolean);
begin
  if (newValue <> FFlat) then
  begin
    FFlat := newValue;
    if ShowCheckBox then Invalidate;
  end;
end;

procedure TCustomElGroupBox.DrawFlatFrame(Canvas : TCanvas; R : TRect);
var AColor, Color : TColor;
begin
  if MoneyFlat then
  begin
    if Enabled and not FPressed then
      Color := clWindow
    else
      Color := clBtnFace;
    if FPressed and (FMouseInCheckBox or FMouseInText) then
      AColor := MoneyFlatDownColor
    else
    if Focused or (FMouseInCheckBox or FMouseInText) then
      AColor := MoneyFlatActiveColor
    else
      AColor := MoneyFlatInactiveColor;
    ELVCLUtils.DrawFlatFrameEx2(Canvas.Handle, R, AColor, Color, false, true, AllBorderSides, fbtColorLineBorder, clBtnFace, cl3DDkShadow, clBtnShadow, clBtnHighlight, clWindow);
  end
  else
  if Enabled and not FPressed then
    ElVCLUtils.DrawFlatFrame(Canvas.Handle, R, clWindow, false)
  else
    ElVCLUtils.DrawFlatFrame(Canvas.Handle, R, clBtnFace, false);
end;

procedure TCustomElGroupBox.CMMouseLeave(var Msg : TMessage);
begin
  inherited;
  if (Msg.LParam = 0) or (Msg.LParam = TLMDPtrInt(Self)) then
    if ShowCheckBox and (FMouseInCheckBox or FMouseInText) then
      begin
        FMouseInCheckBox := false;
        FmouseInText := false;
        InvalidateRect(Handle, @FCheckRect, true);
      end;
end; { CMMouseLeave }

procedure TCustomElGroupBox.MouseDown(Button : TMouseButton; Shift :
    TShiftState; X, Y : Integer);
begin
  if CanFocus then
    SetFocus;
  if FMouseInCheckBox or FMouseInText then
  begin
    InvalidateRect(Handle, @FCheckRect, true);
    FOldCapture := GetCapture;
    if FOldCapture = Handle then
      FOldCapture := 0;
    SetCapture(Handle);
    FCaptured := true;
  end;
  inherited;
end; { MouseDown }

procedure TCustomElGroupBox.MouseUp(Button : TMouseButton; Shift : TShiftState;
    X, Y : Integer);
begin
  if FCaptured then
  begin
    FCaptured := false;
    if FOldCapture <> 0 then
      SetCapture(FOldCapture)
    else
      ReleaseCapture;
    FOldCapture := 0;
    InvalidateRect(Handle, @FCheckRect, true);
    if FMouseInCheckBox or FMouseInText then
    begin

      if SoundMap <> nil then
        SoundMap.Play(FCheckSound);

      CheckBoxChecked := not CheckBoxChecked;
      Click;
    end;
  end;
  inherited;
end; { MouseUp }

procedure TCustomElGroupBox.WMSetFocus(var Msg : TWMSetFocus);

begin
  inherited;
  if ShowFocus then
    Invalidate;
end; { CMEnter }

procedure TCustomElGroupBox.WMKillFocus(var Msg : TWMKillFocus);

begin
  inherited;
  if ShowFocus or (ShowCheckBox and Flat and not FlatAlways) then
    Invalidate;
end; { CMExit }

procedure TCustomElGroupBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  b : boolean;
  R: TRect;
begin
  b := FMouseInCheckBox or FMouseInText;
  R := FCheckRect;
  if ShowCheckBox and (Text > '') then
    inc(R.Right, CheckMargin);
  FMouseInCheckBox := ShowCheckBox and PtInRect(R, Point(X, Y));
  FMouseInText := {ShowCheckBox and} PtInRect(FTextRect, Point(X, Y));
  inherited;
  if ((FMouseInCheckBox or FMouseInText) <> b) and (IsThemed or (Flat and (not FlatAlways) and ShowCheckbox)) then
  begin
    InvalidateRect(Handle, @FCheckRect, true);
    InvalidateRect(Handle, @FTextRect, true);
  end;
    //Invalidate;
end; { MouseMove }

procedure TCustomElGroupBox.KeyDown(var Key : Word; Shift : TShiftState);
begin
  inherited;
  if not ShowCheckBox then exit;
  if (Key = VK_SPACE) and (Shift = []) then
  begin
    if SoundMap <> nil then SoundMap.Play(FCheckSound);
    CheckBoxChecked := not CheckBoxChecked;
    Click;
  end;
end;

procedure TCustomElGroupBox.Loaded;
begin
  inherited;
  Perform(CM_SHOWINGCHANGED, 0, 0);
  SetEnabled(Enabled);
end;

{ KeyDown }

procedure TCustomElGroupBox.AdjustClientRect(var Rect: TRect);
begin
  inherited AdjustClientRect(Rect);
  Canvas.Font := Font;
  Inc(Rect.Top, GetTopOffset);
  InflateRect(Rect, -1, -1);
  if Ctl3d then
  InflateRect(Rect, -1, -1);
end;

function TCustomElGroupBox.GetTopOffset: Integer;
var
  R     : TRect;
  RClip : TRect;
  LDetail: TThemedButton;
  LThemeMode: TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;
  SetRectEmpty(R);

  if IsHTML then
  begin
    FRender.Data.DefaultFont := Font.Name;
    FRender.Data.DefaultColor := Color;
    FRender.Data.DefaultHeight := Font.Height;
    FRender.Data.DefaultStyle := Font.Style;
    FRender.Data.Charset := Font.Charset;
    FRender.Data.DefaultBgColor := clNone;

    FRender.PrepareText(Caption, 0, false);

    Result := Max(FRender.Data.TextSize.cy, GetCheckBoxSize().cy);
  end
  else

  begin
    if LThemeMode <> ttmNone then
    begin
      if not Enabled then
        LDetail := tbGroupBoxDisabled
      else
        LDetail := tbGroupBoxNormal;
      RClip := ClientRect;
      LMDThemeServices.GetThemeTextExtent(LThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(LDetail),
      Caption, Length(Caption), DT_LEFT, LMDRectToPtr(RClip), R);
      end
    else
    begin
      Canvas.Font := Font;
      SetRectEmpty(R);
      LMDDrawText(Canvas.Handle, Caption, Length(Caption), R, DT_LEFT or DT_CALCRECT);
      end;
    result := Max(R.Bottom - R.Top, GetCheckBoxSize().cy);
  end;
end;

procedure TCustomElGroupBox.SetFlatAlways(Value: Boolean);
begin
  if FFlatAlways <> Value then
  begin
    FFlatAlways := Value;
  end;
end;

function TCustomElGroupBox.GetCaptionRect: TRect;
var CheckRect,
    RClip,
    R, R1     : TRect;
    H : integer;
    Flags     : integer;
    LDetail: TThemedButton;
  LThemeMode: TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;
  CheckRect := GetCheckRect;
  H := GetLineTopOffset;

  if IsHTML then
  begin
    if Text <> '' then
    begin
      if CheckRect.Right <> 0 then
        R := Classes.Rect(CheckRect.Right + CheckMargin, 0, CheckRect.Right + CheckMargin + FRender.Data.TextSize.cx, H)
      else
        R := Classes.Rect(8, 0, 8 + FRender.Data.TextSize.cx, H);

      FRender.DrawText(Canvas, Point(0, 0), R, clNone);
      InflateRect(R, 1, 0);

      if ShowFocus and Focused then
      begin
        InflateRect(R, 1, 0);
        ElVCLUtils.DrawFocus(Canvas, R);
//        Canvas.DrawFocusRect(R);
        InflateRect(R, -1, 0);
      end;

      if CheckRect.Left <> 0 then
        R.Left := CheckRect.Left;
    end
    else
      Result := CheckRect;
  end
  else
  begin
    with Canvas do
    begin
      Font := Self.Font;
      R := Classes.Rect(0, H div 2, Abs(Width), Height);
      R1 := R;

      if (FCaptionColor <> clNone) and (LThemeMode = ttmNone) then
      begin
        R := Classes.Rect(0, 0, Abs(Width), H);
      end;

      if Caption <> '' then
      begin
        if LThemeMode <> ttmNone then
        begin
          if not Enabled then
            LDetail := tbGroupBoxDisabled
          else
            LDetail := tbGroupBoxNormal;

          Flags := DT_LEFT;
          RClip := ClientRect;
          SetRectEmpty(R);
          LMDThemeServices.GetThemeTextExtent(LThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(LDetail),
          Caption, Length(Caption), Flags, LMDRectToPtr(RClip), R);
          if CheckRect.Left <> 0 then
            OffsetRect(R, CheckRect.Right + CheckMargin, 0)
          else
            OffsetRect(R, 8, 0);

          InflateRect(R, 1, 0);
        end
        else
        begin
          R := Classes.Rect(0, 0, 0, H);

          Flags := DT_LEFT;
          LMDDrawText(Handle, Caption, Length(Caption), R, Flags or DT_CALCRECT);
          if CheckRect.Left <> 0 then
            OffsetRect(R, CheckRect.Right + CheckMargin, 0)
          else
            OffsetRect(R, 8, 0);
        end;
        if CheckRect.Left <> 0 then
          R.Left := CheckRect.Left;
        Result := R;
      end
      else
        Result := CheckRect;
    end;
  end;
end;

function TCustomElGroupBox.GetCheckRect: TRect;
var cbw,
    cbh  : integer;
    ImgIdx : integer;
    i : integer;
    SrcRect : TRect;
    CheckRect: TRect;
    H        : integer;
    BMP, amBMP : TBitmap;
    LDetail: TThemedButton;
  LThemeMode: TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;
  H := GetLineTopOffset;

  if ShowCheckBox then
  begin
    if LThemeMode = ttmNone then
    begin
      i := 0;
      ImgIdx := 0;
      if FUseCustomGlyphs and (not FGlyph.Empty) then
      begin
        cbh := FGlyph.Height;
        cbw := FGlyph.Width div 6;
        if not CheckBoxChecked then
        begin
          if Enabled and (not (FPressed and (FMouseInCheckBox or FMouseInText)))
          then
            SrcRect := Classes.Rect(0, 0, cbw, cbh)
          else
            SrcRect := Classes.Rect(cbw, 0, cbw * 2, cbh);
        end
        else
        begin
          if Enabled and (not (FPressed and (FMouseInCheckBox or FMouseInText))) then
            SrcRect := Classes.Rect(cbw * 2, 0, cbw * 3, cbh)
          else
            SrcRect := Classes.Rect(cbw * 3, 0, cbw * 4, cbh);
        end;
      end
      else
      begin
        if FUseImageList and (FImages <> nil) then
        begin
          cbw := FImages.Width;
          cbh := FImages.Height;
          if not CheckBoxChecked then
          begin
            if Enabled and (not (FPressed and (FMouseInCheckBox or FMouseInText)))
            then
              ImgIdx := 0
            else
              ImgIdx := 1;
          end
          else
          begin
            if Enabled and (not (FPressed and (FMouseInCheckBox or FMouseInText)))
            then
              ImgIdx := 2
            else
              ImgIdx := 3;
          end;
        end
        else
        begin
          cbw := GetCheckBoxSize.cx;
          cbh := GetCheckBoxSize.cy;
        end;
        if not CheckBoxChecked then
          i := DFCS_BUTTONCHECK
        else
          i := DFCS_BUTTONCHECK or DFCS_CHECKED;

        if (not Enabled) or ((FMouseInCheckBox or FMouseInText) and FPressed) then
          i := i or DFCS_INACTIVE;
        end;
      CheckRect := Classes.Rect(8, (H div 2 - cbh div 2), 8 + cbw, 0);
      CheckRect.Bottom := CheckRect.Top + cbh;

      if UseCustomGlyphs and (not FGlyph.Empty) then
        DrawGlyph(Canvas, CheckRect, SrcRect)
      else
      begin
        if FUseImageList and (FImages <> nil) then
        begin
          if (FAlphaImages <> nil) and (FAlphaImages.Count > ImgIdx) then
          begin
            BMP := TBitmap.Create;
            BMP.Width := FImages.Width;
            BMP.Height := FImages.Height;
            ImageList_DrawEx(FImages.Handle, ImgIdx, BMP.Canvas.Handle, 0, 0, 0, 0,
              clNone, clNone, ILD_Normal);

            amBMP := TBitmap.Create;
            amBMP.Width := FAlphaImages.Width;
            amBMP.Height := FAlphaImages.Height;
            ImageList_DrawEx(FAlphaImages.Handle, ImgIdx, amBMP.Canvas.Handle, 0, 0, 0, 0,
              clNone, clNone, ILD_Normal);

            LMDAlphaCopyRect2(Canvas.Handle, CheckRect, BMP.Canvas.Handle,
              rect(0, 0, BMP.Width, BMP.Height), amBMP, 255);

            amBMP.Free;
            BMP.Free;
          end
          else
          FImages.Draw(Canvas, CheckRect.Left, CheckRect.Top, ImgIdx);
        end
        else
        begin
          DrawFrameControl(Canvas.Handle, CheckRect, DFC_BUTTON, i);
          if ((Flat and (not (Focused or (FMouseInCheckBox or FMouseInText)))) or FlatAlways) and Enabled then
            DrawFlatFrame(Canvas, CheckRect);
        end;
        end;
    end
    else // XP-style checkmarks
    begin
      LDetail := GetThemedElementInState;

      cbw := GetCheckBoxSize.cx;
      cbh := GetCheckBoxSize.cy;

      CheckRect := Classes.Rect(8, (H div 2 - cbh div 2), 8 + cbw, 0);
      CheckRect.Bottom := CheckRect.Top + cbh;
      LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, LDetail, CheckRect);
    end;

    Result := CheckRect;
  end
  else
    SetRectEmpty(Result);
end;

function TCustomElGroupBox.GetLineTopOffset: Integer;
begin
  if IsHTML then
  begin
    FRender.Data.DefaultFont := Font.Name;
    FRender.Data.DefaultColor := Font.Color;
    FRender.Data.DefaultHeight := Font.Height;
    FRender.Data.DefaultStyle := Font.Style;
    FRender.Data.Charset := Font.Charset;
    FRender.Data.DefaultBgColor := clNone;

    FRender.PrepareText(Caption, 0, false);

    result := FRender.Data.TextSize.cy;
  end
  else
  begin
    with Canvas do
    begin
      Font := Self.Font;
      result := TextHeight('0');
    end;
  end;
end;

procedure TCustomElGroupBox.CMEnabledChanged(var Message: TMessage);

begin
  inherited;
  Invalidate;
end;

procedure TCustomElGroupBox.SetAutoDisableChildren(Value: Boolean);
begin
  if FAutoDisableChildren <> Value then
  begin
    FAutoDisableChildren := Value;
    SetEnabled(Enabled);
  end;
end;

procedure TCustomElGroupBox.SetMoneyFlat(Value: Boolean);
begin
  if FMoneyFlat <> Value then
  begin
    FMoneyFlat := Value;
    Invalidate;
  end;
end;

procedure TCustomElGroupBox.SetMoneyFlatInactiveColor(Value: TColor);
begin
  if FMoneyFlatInactiveColor <> Value then
  begin
    FMoneyFlatInactiveColor := Value;
    if MoneyFlat then Invalidate;
  end;
end;

procedure TCustomElGroupBox.SetMoneyFlatActiveColor(Value: TColor);
begin
  if FMoneyFlatActiveColor <> Value then
  begin
    FMoneyFlatActiveColor := Value;
    if MoneyFlat then Invalidate;
  end;
end;

procedure TCustomElGroupBox.SetMoneyFlatDownColor(Value: TColor);
begin
  if FMoneyFlatDownColor <> Value then
  begin
    FMoneyFlatDownColor := Value;
    if MoneyFlat then Invalidate;
  end;
end;

function TCustomElGroupBox.GetMoneyFlat: Boolean;
begin
  Result := FMoneyFlat;
end;

procedure TCustomElGroupBox.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and CanFocus then
    begin
      SetFocus;
      SetCheckBoxChecked(not CheckBoxChecked);
      Click;
      Result := 1;
    end
    else
      inherited;
end;

procedure TCustomElGroupBox.SetTransparentXPThemes(Value: Boolean);
var
  i: integer;
begin
  inherited;
  for I := 0 to ControlCount - 1 do
    Controls[i].Invalidate;
end;

function TCustomElGroupBox.GetThemedElement: TThemedElement;
begin
  Result := teButton;
end;

function TCustomElGroupBox.GetThemedElementInState: TThemedButton;
begin
  if not CheckBoxChecked then
  begin
    if not Enabled then
      Result := tbCheckBoxUncheckedDisabled
    else
    if FPressed and (FMouseInCheckBox or FMouseInText) then
      Result := tbCheckBoxUncheckedPressed
    else
    if FMouseInCheckBox then
      Result := tbCheckBoxUncheckedHot
    else
      Result := tbCheckBoxUncheckedNormal;
  end
  else
  begin
    if not Enabled then
      Result := tbCheckBoxCheckedDisabled
    else
    if FPressed and (FMouseInCheckBox or FMouseInText) then
      Result := tbCheckBoxCheckedPressed
    else
    if (FMouseInCheckBox or FMouseInText) then
      Result := tbCheckBoxCheckedHot
    else
      Result := tbCheckBoxCheckedNormal;
  end;
end;

end.
