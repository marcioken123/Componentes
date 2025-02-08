unit LMDFxGrabClass;
{$I LMDCmps.inc}

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

LMDFxGrabClass unit (RM, AH)
----------------------------

Note
----
LMD FxPack is based on code licensed from Eugene Kryukov

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Types, Classes, Windows, Messages, Graphics, Controls, Forms, StdCtrls, ExtCtrls,
  Buttons, CommCtrl, FlatSB, RichEdit, SysUtils,
  LMDFxEffect, LMDFxUtils, LMDClass, LMDFxGrab, LMDFxBitmap;

type

  { Default WinControl grabber }
  { ************************ class TLMDFxWControlGrabber ********************* }
  TLMDFxWControlGrabber = class(TLMDFxGrabber)
  private
    procedure GrabWinToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TWinControl; ARect: TRect);
  public
    procedure GrabToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TControl; ARect: TRect); override;
    class function GetGrabberClassType: TLMDFxGrabberControlClass; override;
    class function GetGrabberClassName: string; override;
  end;

  { CustomForm grabber }
  { ************************ class TLMDFxFormGrabber ************************* }
  TLMDFxFormGrabber = class(TLMDFxWControlGrabber)
  private
    procedure GrabFormToDC(DC: HDC; X, Y: integer; AControl: TCustomForm; ARect: TRect);
    procedure GrabThemedFormToDC(DC: HDC; X, Y: integer; AControl: TCustomForm; ARect: TRect);
    procedure GrabFormToWinBitmap(ABitmap: TBitmap; AControl: TCustomForm; X, Y: integer; ARect: TRect);
  public
    procedure GrabToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TControl; ARect: TRect); override;
    class function GetGrabberClassType: TLMDFxGrabberControlClass; override;
    class function GetGrabberClassName: string; override;
  end;

  { Button grabber }
  { ************************ class TLMDFxButtonGrabber *********************** }
  TLMDFxButtonGrabber = class(TLMDFxWControlGrabber)
  private
  public
    procedure GrabToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TControl; ARect: TRect); override;
    class function GetGrabberClassType: TLMDFxGrabberControlClass; override;
    class function GetGrabberClassName: string; override;
  end;

  { BitBtn grabber }
  { ************************ class TLMDFxBitBtnGrabber *********************** }
  TLMDFxBitBtnGrabber = class(TLMDFxWControlGrabber)
  private
  public
    procedure GrabToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TControl; ARect: TRect); override;
    class function GetGrabberClassType: TLMDFxGrabberControlClass; override;
    class function GetGrabberClassName: string; override;
  end;

  { CheckBox grabber }
  { ************************ class TLMDFxCheckBoxGrabber********************** }
  TLMDFxCheckBoxGrabber = class(TLMDFxWControlGrabber)
  private
  public
    procedure GrabToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TControl; ARect: TRect); override;
    class function GetGrabberClassType: TLMDFxGrabberControlClass; override;
    class function GetGrabberClassName: string; override;
  end;

  { Control with scrollbars grabber }
  { ************************ class TLMDFxScrollBoxGrabber ******************** }
  TLMDFxScrollBoxGrabber = class(TLMDFxWControlGrabber)
  private
    procedure GrabScrollBarsToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TControl; ARect: TRect);
  public
    procedure GrabToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TControl; ARect: TRect); override;
    class function GetGrabberClassType: TLMDFxGrabberControlClass; override;
    class function GetGrabberClassName: string; override;
  end;

  { ************************ class TLMDFxMemoGrabber ************************* }
  TLMDFxMemoGrabber = class(TLMDFxScrollBoxGrabber)
  private
  public
    procedure GrabToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TControl; ARect: TRect); override;
    class function GetGrabberClassType: TLMDFxGrabberControlClass; override;
    class function GetGrabberClassName: string; override;
  end;

  { ************************ class TLMDFxListBoxGrabber ********************** }
  TLMDFxListBoxGrabber = class(TLMDFxScrollBoxGrabber)
  private
  public
    procedure GrabToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TControl; ARect: TRect); override;
    class function GetGrabberClassType: TLMDFxGrabberControlClass; override;
    class function GetGrabberClassName: string; override;
  end;

implementation

uses
  UxTheme, Themes,
  LMDFxBase, LMDProcs;

var
  User32Handle: THandle;

type
  { For LMDInnovative product compatible }
  TInternalPaintToBitmap = procedure (Sender: TObject; X, Y: integer; ABitmap: TBitmap; ARect: TRect) of object;

  THackWControl = class(TWinControl);
  THackForm = class(TCustomForm);

var
  GetScrollBarInfoFunc: function (hwnd: HWND; idObject: Longint; var psbi: TScrollBarInfo): BOOL; stdcall;

function MyGetScrollBarInfo(hwnd: HWND; idObject: Longint; var psbi: TScrollBarInfo): BOOL;
begin

  if @GetScrollBarInfoFunc <> nil then
  Result := GetScrollBarInfoFunc(hwnd, idObject, psbi)

  else
    begin
      { Win95 }
      psbi.rgstate[0] := STATE_SYSTEM_INVISIBLE;
      Result := false;
    end;
end;

{ TLMDFxWControlGrabber ==========================================================}
class function TLMDFxWControlGrabber.GetGrabberClassName: string;
begin
  Result := LowerCase('TWinControl;TCustomControl');
end;

{ ---------------------------------------------------------------------------- }
class function TLMDFxWControlGrabber.GetGrabberClassType: TLMDFxGrabberControlClass;
begin
  Result := TWinControl;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxWControlGrabber.GrabToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TControl; ARect: TRect);
begin
  GrabWinToBitmap(ABitmap, X, Y, TWinControl(AControl), ARect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxWControlGrabber.GrabWinToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TWinControl; ARect: TRect);
var
  EdgeFlags, BorderFlags, SaveIndex: Integer;
  R: TRect;
  DC: HDC;
begin
  with AControl do
  begin
    DC := ABitmap.Canvas.Handle;

    SaveIndex := SaveDC(DC);
{    with ARect do
      IntersectClipRect(DC, Left, Top, Right, Bottom);}

    MoveWindowOrg(DC, X, Y);

    BorderFlags := 0;
    EdgeFlags := 0;

    if GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE <> 0 then
    begin
      EdgeFlags := EDGE_SUNKEN;
      BorderFlags := BF_RECT or BF_ADJUST
    end
    else
      if not (AControl is TCustomForm) and (GetWindowLong(Handle, GWL_STYLE) and WS_BORDER <> 0) then
      begin
        EdgeFlags := BDR_OUTER;
        BorderFlags := BF_RECT or BF_ADJUST or BF_MONO;
      end;

    if BorderFlags <> 0 then
    begin
      SetRect(R, 0, 0, Width, Height);
      Windows.DrawEdge(DC, R, EdgeFlags, BorderFlags);
      MoveWindowOrg(DC, R.Left, R.Top);
      IntersectClipRect(DC, 0, 0, R.Right - R.Left, R.Bottom - R.Top);
    end;

    Perform(WM_ERASEBKGND, DC, 0);
    Perform(WM_PAINT, DC, 0);

    RestoreDC(DC, SaveIndex);
  end;
end;

{ TLMDFxFormGrabber ==============================================================}
class function TLMDFxFormGrabber.GetGrabberClassName: string;
begin
  Result := LowerCase('TForm;TCustomForm');
end;

{ ---------------------------------------------------------------------------- }
class function TLMDFxFormGrabber.GetGrabberClassType: TLMDFxGrabberControlClass;
begin
  Result := TCustomForm;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxFormGrabber.GrabToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TControl;ARect: TRect);
begin
  GrabFormToWinBitmap(ABitmap, TCustomForm(AControl), X, Y, ARect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxFormGrabber.GrabFormToDC(DC: HDC; X, Y: integer; AControl: TCustomForm; ARect: TRect);
var
  ClientOrigin: TPoint;
  R: TRect;
  ButtonSize: TPoint;
  ButtonRect: TRect;
  Flags: Cardinal;
  MinMaxShown: boolean;
  CloseShown: boolean;
  Wnd: Cardinal;
begin
  R := GetRealBoundsRect(AControl);
  OffsetRect(R, -R.Left, -R.Top);

  OffsetRect(R, X, Y);

  { Fill BorderRect }
  Windows.FillRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));

  { Paint Border }
  if AControl.BorderStyle <> bsNone then
  begin
    Windows.DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RECT);
    InflateRect(R, -1, -1);
    Windows.DrawEdge(DC, R, BDR_RAISEDINNER, BF_RECT);
  end;

  Wnd := AControl.Handle;

  { Draw Caption }
  ClientOrigin := GetClientOrigin(AControl);

  case THackForm(AControl).BorderStyle of
  bsDialog, bsSingle, bsSizeable:
      begin
        R := Rect(ClientOrigin.X, ClientOrigin.X, RectWidth(GetRealBoundsRect(AControl)) - ClientOrigin.X, ClientOrigin.Y - 1);
        OffsetRect(R, -ARect.Left, -ARect.Top);
        DrawCaption(Wnd, DC, R, DC_ACTIVE or DC_GRADIENT or DC_ICON or DC_TEXT);

        { Caption button }
        ButtonSize := Point(GetSystemMetrics(SM_CXSIZE), GetSystemMetrics(SM_CYSIZE));
        ButtonRect := Rect(R.Right - ButtonSize.X, R.Top + 2, R.Right - 2, R.Bottom - 2);

        { Close }
        if (biSystemMenu in THackForm(AControl).BorderIcons) then
        begin
          R := ButtonRect;
          Flags := DFCS_CAPTIONCLOSE;
          DrawFrameControl(DC, R, DFC_CAPTION, Flags);
          CloseShown := true;
        end
        else
          CloseShown := false;

        if (THackForm(AControl).BorderStyle in [bsSizeable, bsSingle]) and
           (THackForm(AControl).BorderIcons * [biMaximize, biMinimize] <> []) then
        begin
          { Max }
          R := ButtonRect;
          OffsetRect(R, -ButtonSize.X, 0);
          if AControl.WindowState = wsMaximized then
            Flags := DFCS_CAPTIONRESTORE
          else
            Flags := DFCS_CAPTIONMAX;

          if not (biMaximize in THackForm(AControl).BorderIcons) then
          Flags := Flags or DFCS_INACTIVE;

          DrawFrameControl(DC, R, DFC_CAPTION, Flags);

          { Min }
          R := ButtonRect;
          OffsetRect(R, -ButtonSize.X * 2 + 2, 0);
          if AControl.WindowState = wsMaximized then
            Flags := DFCS_CAPTIONRESTORE
          else
            Flags := DFCS_CAPTIONMIN;

          if not (biMinimize in THackForm(AControl).BorderIcons) then
          Flags := Flags or DFCS_INACTIVE;

          DrawFrameControl(DC, R, DFC_CAPTION, Flags);

          MinMaxShown := true;
        end
        else
          MinMaxShown := false;

        { Help Button }
        if (THackForm(AControl).BorderStyle in [bsSizeable, bsSingle, bsDialog]) and
           (biHelp in THackForm(AControl).BorderIcons) and
        (CloseShown) then
        begin
          { Max }
          R := ButtonRect;
          if not MinMaxShown then
            OffsetRect(R, -ButtonSize.X, 0)
          else
            OffsetRect(R, -ButtonSize.X * 3, 0);
          Flags := DFCS_CAPTIONHELP;

          if not (biHelp in THackForm(AControl).BorderIcons) then
          Flags := Flags or DFCS_INACTIVE;

          DrawFrameControl(DC, R, DFC_CAPTION, Flags);
        end;
      end;
    bsSizeToolWin, bsToolWindow:
      begin
        R := Rect(ClientOrigin.X, ClientOrigin.X, AControl.Width - ClientOrigin.X, ClientOrigin.Y - 1);
        OffsetRect(R, -ARect.Left, -ARect.Top);
        DrawCaption(Wnd, DC, R, DC_ACTIVE or DC_GRADIENT or DC_ICON or DC_TEXT or DC_SMALLCAP);

        { Caption Button }
        ButtonSize := Point(GetSystemMetrics(SM_CXSMSIZE), GetSystemMetrics(SM_CYSMSIZE));
        ButtonRect := Rect(R.Right - ButtonSize.X, R.Top + 2, R.Right - 2, R.Bottom - 2);

        { Close }
        if (biSystemMenu in THackForm(AControl).BorderIcons) then
        begin
          R := ButtonRect;
          Flags := DFCS_CAPTIONCLOSE;
          DrawFrameControl(DC, R, DFC_CAPTION, Flags);
        end;
      end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxFormGrabber.GrabThemedFormToDC(DC: HDC; X, Y: integer; AControl: TCustomForm; ARect: TRect);
var
  ClientOrigin: TPoint;
  R, TempR: TRect;
  ButtonSize: TPoint;
  ButtonRect: TRect;
  MinMaxShown: boolean;
  CloseShown, SysShown: boolean;
  Wnd: Cardinal;
  Part, State: integer;
  ClientRect: TRect;
  S: WideString;
  Font: HFont;
  NonClientMetrics: TNonClientMetrics;
  begin
  SysShown:=false;
  Font := 0;
  R := GetRealBoundsRect(AControl);
  OffsetRect(R, -R.Left, -R.Top);

  OffsetRect(R, X, Y);

  ClientOrigin := GetClientOrigin(AControl);
  ClientRect := Rect(R.Left + ClientOrigin.X, R.Top + ClientOrigin.Y, R.Right - ClientOrigin.X, R.Bottom - ClientOrigin.X);

  { Fill BorderRect }
  Windows.FillRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));

  Wnd := AControl.Handle;

  { Draw Caption }

  case THackForm(AControl).BorderStyle of
  bsDialog, bsSingle, bsSizeable:
      begin
        { Paint Border }
        if AControl.BorderStyle <> bsNone then
        begin
          State := integer(CS_ACTIVE);
          { Caption }
          TempR := Classes.Rect(R.Left, R.Top, R.Right, ClientRect.Top);
          Part := integer(WP_CAPTION);
          DrawThemeBackground(ThemeServices.Theme[teWindow], DC, Part, State, TempR, nil);
          { Left }
          TempR := Classes.Rect(R.Left, ClientRect.Top, ClientRect.Left, ClientRect.Bottom);
          Part := integer(WP_FRAMELEFT);
          DrawThemeBackground(ThemeServices.Theme[teWindow], DC, Part, State, TempR, nil);
          { Right }
          TempR := Classes.Rect(ClientRect.Right, ClientRect.Top, R.Right, ClientRect.Bottom);
          Part := integer(WP_FRAMERIGHT);
          DrawThemeBackground(ThemeServices.Theme[teWindow], DC, Part, State, TempR, nil);
          { Bottom }
          TempR := Classes.Rect(ClientRect.Left, ClientRect.Bottom, R.Right, R.Bottom);
          Part := integer(WP_FRAMEBOTTOM);
          DrawThemeBackground(ThemeServices.Theme[teWindow], DC, Part, State, TempR, nil);
        end;

        { Caption button }
        ButtonSize := Point(GetSystemMetrics(SM_CXSIZE), GetSystemMetrics(SM_CYSIZE));
        ButtonRect := Rect(ClientRect.Right - ButtonSize.X, ClientOrigin.X, ClientRect.Right, ClientRect.Top - 1);
        InflateRect(ButtonRect, -2, -2);

        Dec(ButtonSize.X, 2);

        { Close }
        if (biSystemMenu in THackForm(AControl).BorderIcons) then
        begin
          { Sysmenu  }
          if (THackForm(AControl).BorderStyle <> bsDialog) then
          begin
            R := Rect(ClientRect.Left, ClientRect.Left, ClientRect.Left + 16, ClientRect.Left + 16);
            OffsetRect(R, 1, 4);
            DrawCaption(Wnd, DC, R, DC_ACTIVE or DC_ICON);
            SysShown := true;
          end
          else
            SysShown := false;

          { Close }
          R := ButtonRect;
          State := integer(SBS_NORMAL);
          Part := integer(WP_CLOSEBUTTON);
          DrawThemeBackground(ThemeServices.Theme[teWindow], DC, Part, State, R, nil);

          CloseShown := true;
        end
        else
          CloseShown := false;

        { Caption Text }
        S := THackForm(AControl).Caption;
        { !!! Optimize - bag rect calculation }
        R := Rect(ClientRect.Left, ClientRect.Left + 4, R.Right, ClientRect.Top);
        if CloseShown and SysShown then
          OffsetRect(R, 22, 0)
        else
          OffsetRect(R, 4, 0);

        Part := integer(WP_CAPTION);
        State := integer(CS_ACTIVE);

        NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
        if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
          Font := CreateFontIndirect(NonClientMetrics.lfCaptionFont);
        SelectObject(DC, Font);
        SetTextColor(DC, GetSysColor(COLOR_CAPTIONTEXT));
        SetBkMode(DC, TRANSPARENT);
        DrawThemeText(ThemeServices.Theme[teWindow], DC, Part, State, PWideChar(S), Length(S), DT_SINGLELINE, 1, R);
        DrawTextW(DC, PWideChar(S), Length(S), R, DT_SINGLELINE);
        { Draw buttons }

        if (THackForm(AControl).BorderStyle in [bsSizeable, bsSingle]) and
           (THackForm(AControl).BorderIcons * [biMaximize, biMinimize] <> []) then
           begin
          { Max }
          R := ButtonRect;
          OffsetRect(R, -ButtonSize.X, 0);

          if not (biMaximize in THackForm(AControl).BorderIcons) then
          State := integer(SBS_DISABLED)
          else
            State := integer(SBS_NORMAL);
          if AControl.WindowState = wsMaximized then
            Part := integer(WP_RESTOREBUTTON)
          else
            Part := integer(WP_MAXBUTTON);
          DrawThemeBackground(ThemeServices.Theme[teWindow], DC, Part, State, R, nil);

          { Min }
          R := ButtonRect;
          OffsetRect(R, -ButtonSize.X * 2, 0);

          if AControl.WindowState = wsMaximized then
            Part := integer(WP_RESTOREBUTTON)
          else
            Part := integer(WP_MINBUTTON);
          if not (biMinimize in THackForm(AControl).BorderIcons) then
          State := integer(SBS_DISABLED)
          else
            State := integer(SBS_NORMAL);
          DrawThemeBackground(ThemeServices.Theme[teWindow], DC, Part, State, R, nil);

          MinMaxShown := true;
        end
        else
          MinMaxShown := false;

        { Help Button }
        if (THackForm(AControl).BorderStyle in [bsSizeable, bsSingle, bsDialog]) and
           (biHelp in THackForm(AControl).BorderIcons) and
        (CloseShown) and (not MinMaxShown) then
        begin
          { Help }
          R := ButtonRect;
          if not MinMaxShown then
            OffsetRect(R, -ButtonSize.X, 0)
          else
            OffsetRect(R, -ButtonSize.X * 3, 0);

          Part := integer(WP_HELPBUTTON);
          if not (biHelp in THackForm(AControl).BorderIcons) then
          State := integer(SBS_DISABLED)
          else
            State := integer(SBS_NORMAL);
          DrawThemeBackground(ThemeServices.Theme[teWindow], DC, Part, State, R, nil);
        end;
      end;
    bsSizeToolWin, bsToolWindow:
      begin
        { Paint Border }
        if AControl.BorderStyle <> bsNone then
        begin
          State := integer(CS_ACTIVE);
          { Caption }
          TempR := Classes.Rect(R.Left, R.Top, R.Right, ClientRect.Top);
          Part := integer(WP_SMALLCAPTION);
          DrawThemeBackground(ThemeServices.Theme[teWindow], DC, Part, State, TempR, nil);
          { Left }
          TempR := Classes.Rect(R.Left, ClientRect.Top, ClientRect.Left, ClientRect.Bottom);
          Part := integer(WP_SMALLFRAMELEFT);
          DrawThemeBackground(ThemeServices.Theme[teWindow], DC, Part, State, TempR, nil);
          { Right }
          TempR := Classes.Rect(ClientRect.Right, ClientRect.Top, R.Right, ClientRect.Bottom);
          Part := integer(WP_SMALLFRAMERIGHT);
          DrawThemeBackground(ThemeServices.Theme[teWindow], DC, Part, State, TempR, nil);
          { Bottom }
          TempR := Classes.Rect(ClientRect.Left, ClientRect.Bottom, R.Right, R.Bottom);
          Part := integer(WP_SMALLFRAMEBOTTOM);
          DrawThemeBackground(ThemeServices.Theme[teWindow], DC, Part, State, TempR, nil);
        end;

        { Caption Text }
        S := THackForm(AControl).Caption;
        { !!! Optimize - bag rect calculation }
        R := Rect(ClientRect.Left, ClientRect.Left + 2, R.Right, ClientRect.Top);

        Part := integer(WP_SMALLCAPTION);
        State := integer(CS_ACTIVE);

        NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
        if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
          Font := CreateFontIndirect(NonClientMetrics.lfSmCaptionFont);
        SelectObject(DC, Font);
        SetTextColor(DC, GetSysColor(COLOR_CAPTIONTEXT));
        SetBkMode(DC, TRANSPARENT);
        DrawThemeText(ThemeServices.Theme[teWindow], DC, Part, State, PWideChar(S), Length(S), DT_SINGLELINE, 1, R);
        DrawTextW(DC, PWideChar(S), Length(S), R, DT_SINGLELINE);
        { Caption Button }
        ButtonSize := Point(GetSystemMetrics(SM_CXSMSIZE), GetSystemMetrics(SM_CYSMSIZE));
        ButtonRect := Rect(ClientRect.Right - ButtonSize.X, ClientOrigin.X, ClientRect.Right, ClientRect.Top - 1);
        InflateRect(ButtonRect, -2, -2);

        { Close }
        if (biSystemMenu in THackForm(AControl).BorderIcons) then
        begin
          R := ButtonRect;
          State := integer(SBS_NORMAL);
          Part := integer(WP_SMALLCLOSEBUTTON);
          DrawThemeBackground(ThemeServices.Theme[teWindow], DC, Part, State, R, nil);
        end;
      end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxFormGrabber.GrabFormToWinBitmap(ABitmap: TBitmap; AControl: TCustomForm; X, Y: integer; ARect: TRect);
var
  ClientOrigin: TPoint;
  B: TLMDFxBitmap;
  LMDFxForm: integer;
  SaveIndex: integer;
  begin
  ClientOrigin := GetClientOrigin(AControl);

  LMDFxForm := SendMessage(THackWControl(AControl).Handle, CM_PAINTTOBITMAP,
    WPARAM(Integer(SmallPoint(X, Y))), ABitmap.Canvas.Handle);
  if LMDFxForm = 0 then
  begin
    { Grab non client }
    B := TLMDFxBitmap.Create;
    try
      B.SetSize(ABitmap.Width, ABitmap.Height);

      if LMDApplication.XPThemesSupported then
        GrabThemedFormToDC(B.DC, X, Y, AControl, ARect)
      else
        GrabFormToDC(B.DC, X, Y, AControl, ARect);

      B.Draw(ABitmap.Canvas, 0, 0);
    finally
      B.Free;
    end;

    { Paint Client }
    GrabWinToBitmap(ABitmap, ClientOrigin.X + X, ClientOrigin.Y + Y, AControl, ARect);
  end
  else
  begin
    { KSDev Form }
    SaveIndex := SaveDC(ABitmap.Canvas.Handle);
    MoveWindowOrg(ABitmap.Canvas.Handle, ClientOrigin.X + X, ClientOrigin.Y + Y);
    AControl.Perform(WM_PAINT, ABitmap.Canvas.Handle, 0);
    RestoreDC(ABitmap.Canvas.Handle, SaveIndex);
  end;

end;

{ TLMDFxButtonGrabber ===========================================================}
class function TLMDFxButtonGrabber.GetGrabberClassName: string;
begin
  Result := LowerCase('TButton');
end;

{ ---------------------------------------------------------------------------- }
class function TLMDFxButtonGrabber.GetGrabberClassType: TLMDFxGrabberControlClass;
begin
  Result := TButton;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxButtonGrabber.GrabToBitmap(ABitmap: TBitmap; X, Y: integer;
  AControl: TControl; ARect: TRect);
var
  IsDown, IsDefault, IsFocused: Boolean;
  //State: TButtonState;
  ClientRect, R: TRect;
  Flags: Longint;
  S: string;
begin
  inherited ;

  { Draw button }
  ClientRect := Rect(0, 0, AControl.Width, AControl.Height);

  OffsetRect(ClientRect, X, Y);

  with ABitmap, ABitmap.Canvas do
  begin
    IsDown := false; // !!!
    IsDefault := TButton(AControl).Default and not THackWControl(AControl).Focused;
    {if not AControl.Enabled then State := bsDisabled
    else
      if IsDown then State := bsDown
      else
        State := bsUp;}

    Flags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
    if IsDown then Flags := Flags or DFCS_PUSHED;
    if not AControl.Enabled then
      Flags := Flags or DFCS_INACTIVE;

    IsFocused := THackWControl(AControl).Focused;
    R := ClientRect;

    { DrawFrameControl doesn't allow for drawing a button as the
        default button, so it must be done here. }
    if IsFocused or IsDefault then
    begin
      Pen.Color := clWindowFrame;
      Pen.Width := 1;
      Brush.Style := bsClear;
      Rectangle(R.Left, R.Top, R.Right, R.Bottom);

      { DrawFrameControl must draw within this border }
      InflateRect(R, -1, -1);
    end;

    { DrawFrameControl does not draw a pressed button correctly }
    if IsDown then
    begin
      Pen.Color := clBtnShadow;
      Pen.Width := 1;
      Brush.Color := clBtnFace;
      Rectangle(R.Left, R.Top, R.Right, R.Bottom);
      InflateRect(R, -1, -1);
    end
    else
      DrawFrameControl(Handle, R, DFC_BUTTON, Flags);

    if IsFocused then
    begin
      R := ClientRect;
      InflateRect(R, -1, -1);
    end;

    Font := THackWControl(AControl).Font;
    if IsDown then
      OffsetRect(R, 1, 1);

    { Draw Text }
    Brush.Style := bsClear;
    S := THackWControl(AControl).Caption;
    Flags := THackWControl(AControl).DrawTextBiDiModeFlags(DT_CENTER);
    Windows.DrawText(Handle, PChar(S), Length(S), R, Flags or DT_CALCRECT); // Calc size
    RectCenter(R, ClientRect);
    OffsetRect(R, 0, -1); // offset caption on top

    Windows.DrawText(Handle, PChar(S), Length(S), R, Flags);
    if IsFocused {and IsDefault }then // !!!
    begin
      R := ClientRect;
      InflateRect(R, -4, -4);
      Pen.Color := clWindowFrame;
      Brush.Color := clBtnFace;
      Windows.DrawFocusRect(Handle, R);
    end;
  end;
end;

{ TLMDFxBitBtnGrabber ===========================================================}
class function TLMDFxBitBtnGrabber.GetGrabberClassName: string;
begin
  Result := LowerCase('TBitBtn');
end;

{ ---------------------------------------------------------------------------- }
class function TLMDFxBitBtnGrabber.GetGrabberClassType: TLMDFxGrabberControlClass;
begin
  Result := TBitBtn;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitBtnGrabber.GrabToBitmap(ABitmap: TBitmap; X, Y: integer;
  AControl: TControl; ARect: TRect);
var
  B: TBitmap;
  Msg: TWMDrawItem;
  DrawItemStruct: TDrawItemStruct;
begin
  { Draw BitBtn }
  B := TBitmap.Create;
  try
    B.Width := AControl.Width;
    B.Height := AControl.Height;

    with DrawItemStruct do
    begin
      hDC := B.Canvas.Handle;
    end;
    Msg.Msg := CN_DRAWITEM;
    Msg.DrawItemStruct := @DrawItemStruct;
    AControl.Dispatch(Msg);

    ABitmap.Canvas.Draw(X, Y, B);
  finally
    B.Free;
  end;
end;

{ TLMDFxCheckBoxGrabber =========================================================}
class function TLMDFxCheckBoxGrabber.GetGrabberClassName: string;
begin
  Result := 'TCheckBox;TCustomCheckBox;';
end;

{ ---------------------------------------------------------------------------- }
class function TLMDFxCheckBoxGrabber.GetGrabberClassType: TLMDFxGrabberControlClass;
begin
  Result := TCustomCheckBox;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxCheckBoxGrabber.GrabToBitmap(ABitmap: TBitmap; X, Y: integer;
  AControl: TControl; ARect: TRect);
var
  R, ClientRect, BoxRect: TRect;
  CheckSize: TPoint;
  Flags: cardinal;
  S: string;
begin
  inherited;

  { Draw CheckBox }
  CheckSize := Point(13, 13);

  ClientRect := Rect(0, 0, AControl.Width, AControl.Height);
  OffsetRect(ClientRect, X, Y);

  BoxRect := Rect(0, 0, CheckSize.X, CheckSize.Y);
  RectVCenter(BoxRect, ClientRect);

  if not AControl.Enabled then
    Flags := DFCS_INACTIVE
  else
    Flags := 0;

  { Draw box }
  case TCheckBox(AControl).State of
    cbUnChecked: DrawFrameControl(ABitmap.Canvas.Handle, BoxRect, DFC_BUTTON, Flags or DFCS_BUTTONCHECK);
    cbChecked: DrawFrameControl(ABitmap.Canvas.Handle, BoxRect, DFC_BUTTON, Flags or DFCS_BUTTONCHECK or DFCS_CHECKED);
    cbGrayed: DrawFrameControl(ABitmap.Canvas.Handle, BoxRect, DFC_BUTTON, Flags or DFCS_BUTTON3STATE or DFCS_CHECKED);
  end;

  { Draw Text }
  with ABitmap.Canvas do
  begin
    Font.Assign(THackWControl(AControl).Font);
    Brush.Style := bsClear;
    S := THackWControl(AControl).Caption;
    Flags := THackWControl(AControl).DrawTextBiDiModeFlags(DT_LEFT or DT_SINGLELINE);
    R := Rect(0, 0, AControl.Width, AControl.Height);
    Windows.DrawText(Handle, PChar(S), Length(S), R, Flags or DT_CALCRECT); // Calc size
    RectVCenter(R, ClientRect);
    OffsetRect(R, CheckSize.X + 5, -1); // !!! 5 may be other
    Windows.DrawText(Handle, PChar(S), Length(S), R, Flags);
    if THackWControl(AControl).Focused then
    begin
      InflateRect(R, 1, 1);
      Inc(R.Bottom, 1); // 1 May be other
      Pen.Color := clWindowFrame;
      Brush.Color := clBtnFace;
      Windows.DrawFocusRect(Handle, R);
    end;
  end;
end;

{ TLMDFxScrollBoxGrabber =================================================}
class function TLMDFxScrollBoxGrabber.GetGrabberClassName: string;
begin
  Result := 'TScrollBox';
end;

{ ---------------------------------------------------------------------------- }
class function TLMDFxScrollBoxGrabber.GetGrabberClassType: TLMDFxGrabberControlClass;
begin
  Result := TScrollBox;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxScrollBoxGrabber.GrabScrollBarsToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TControl; ARect: TRect);
var
  Style, ExStyle, Flags: cardinal;
  SRect, R: TRect;
  ClientRect: TRect;
  ScrollSize: integer;
  ScrollInfo: TScrollInfo;
  SBInfo: TScrollBarInfo;
  BkColor: TColor;
  SBStyle: Cardinal;
  begin
  Style := GetWindowLong(THackWControl(AControl).Handle, GWL_STYLE);
  ExStyle := GetWindowLong(THackWControl(AControl).Handle, GWL_EXSTYLE);
  ClientRect := Rect(0, 0, AControl.Width, AControl.Height);
  OffsetRect(ClientRect, X, Y);

  Flags := 0;
  FillChar(ScrollInfo, SizeOf(ScrollInfo), 0);
  { Check border size }
  if (Style and WS_BORDER <> 0) or (ExStyle and WS_EX_CLIENTEDGE <> 0) then
    InflateRect(ClientRect, -2, -2);

  { Horz scrollbar }
  if WS_HSCROLL and Style <> 0 then
  begin
    ScrollSize := GetSystemMetrics(SM_CXHSCROLL);

    ScrollInfo.cbSize := SizeOf(ScrollInfo);
    ScrollInfo.fMask := SIF_ALL;
    GetScrollInfo(THackWControl(AControl).Handle, SB_HORZ, ScrollInfo);
    { Get real scrolbar info - width, pos in pixel }
    FillChar(SBInfo, SizeOf(SBInfo), 0);
    SBInfo.cbSize := SizeOf(SBInfo);
    MyGetScrollBarInfo(THackWControl(AControl).Handle, LongInt(OBJID_HSCROLL), SBInfo);
    { Get flat info }
    FlatSB_GetScrollProp(THackWControl(AControl).Handle, WSB_PROP_HSTYLE, @SBStyle);
    FlatSB_GetScrollProp(THackWControl(AControl).Handle, WSB_PROP_HBKGCOLOR, @BkColor);
    if BkColor = 0 then BkColor := clWhite;

    if SBStyle and FSB_FLAT_MODE <> 0 then
      Flags := Flags or DFCS_FLAT;

    SRect := SBInfo.rcScrollBar;
    SRect.TopLeft := AControl.ScreenToClient(SRect.TopLeft);
    SRect.BottomRight := AControl.ScreenToClient(SRect.BottomRight);
    OffsetRect(SRect, ClientRect.Left, ClientRect.Top);

    with ABitmap.Canvas do
    begin
      { Draw background }
      Brush.Handle := CreateHalftoneBrush(BkColor);
      FillRect(SRect);

      { Draw up buttons }
      R := SRect;
      R.Right := R.Left + ScrollSize;
      if SBInfo.rgstate[1] and STATE_SYSTEM_UNAVAILABLE <> 0 then
        DrawFrameControl(Handle, R, DFC_SCROLL, DFCS_SCROLLLEFT or Flags or DFCS_INACTIVE)
      else
        DrawFrameControl(Handle, R, DFC_SCROLL, DFCS_SCROLLLEFT or Flags);

      { Draw down buttons }
      R := SRect;
      R.Left := R.Right - ScrollSize;
      if SBInfo.rgstate[5] and STATE_SYSTEM_UNAVAILABLE <> 0 then
        DrawFrameControl(Handle, R, DFC_SCROLL, DFCS_SCROLLRIGHT or Flags or DFCS_INACTIVE)
      else
        DrawFrameControl(Handle, R, DFC_SCROLL, DFCS_SCROLLRIGHT or Flags);

      { Draw thumb }
      if (SBInfo.rgstate[0] and STATE_SYSTEM_UNAVAILABLE = 0) then
      begin
        R := SRect;
        R.Left := SRect.Left + SBInfo.xyThumbTop;
        R.Right := SRect.Left + SBInfo.xyThumbBottom;
        DrawFrameControl(Handle, R, DFC_BUTTON, DFCS_BUTTONPUSH or Flags);
      end;

      { Draw grip area }
      if SRect.Right <> ClientRect.Right then
      begin
        R := SRect;
        R.Left := R.Right;
        R.Right := ClientRect.Right;
        Brush.Color := clBtnFace;
        FillRect(R);
      end;
    end;

  end;

  { Vert scrollbar }
  if WS_VSCROLL and Style <> 0 then
  begin
    ScrollSize := GetSystemMetrics(SM_CXVSCROLL);
    ScrollInfo.cbSize := SizeOf(ScrollInfo);
    ScrollInfo.fMask := SIF_ALL;
    GetScrollInfo(THackWControl(AControl).Handle, SB_VERT, ScrollInfo);
    { Get real scrolbar info - width, pos in pixel }
        FillChar(SBInfo, SizeOf(SBInfo), 0);
    SBInfo.cbSize := SizeOf(SBInfo);
    MyGetScrollBarInfo(THackWControl(AControl).Handle, LongInt(OBJID_VSCROLL), SBInfo);
    { Get flat info }
    FlatSB_GetScrollProp(THackWControl(AControl).Handle, WSB_PROP_VSTYLE, @SBStyle);
    FlatSB_GetScrollProp(THackWControl(AControl).Handle, WSB_PROP_VBKGCOLOR, @BkColor);
    if BkColor = 0 then BkColor := clWhite;

    if SBStyle and FSB_FLAT_MODE <> 0 then
      Flags := Flags or DFCS_FLAT;

    SRect := SBInfo.rcScrollBar;
    SRect.TopLeft := AControl.ScreenToClient(SRect.TopLeft);
    SRect.BottomRight := AControl.ScreenToClient(SRect.BottomRight);
    OffsetRect(SRect, ClientRect.Left, ClientRect.Top);

    with ABitmap.Canvas do
    begin
      { Draw background }
      Brush.Handle := CreateHalftoneBrush(BkColor);
      FillRect(SRect);

      { Draw up buttons }
      R := SRect;
      R.Bottom := R.Top + ScrollSize;
      if SBInfo.rgstate[1] and STATE_SYSTEM_UNAVAILABLE <> 0 then
        DrawFrameControl(Handle, R, DFC_SCROLL, DFCS_SCROLLUP or Flags or DFCS_INACTIVE)
      else
        DrawFrameControl(Handle, R, DFC_SCROLL, DFCS_SCROLLUP or Flags);

      { Draw down buttons }
      R := SRect;
      R.Top := R.Bottom - ScrollSize;
      if SBInfo.rgstate[5] and STATE_SYSTEM_UNAVAILABLE <> 0 then
        DrawFrameControl(Handle, R, DFC_SCROLL, DFCS_SCROLLDOWN or Flags or DFCS_INACTIVE)
      else
        DrawFrameControl(Handle, R, DFC_SCROLL, DFCS_SCROLLDOWN or Flags);

      { Draw thumb }
      if (SBInfo.rgstate[0] and STATE_SYSTEM_UNAVAILABLE = 0) then
      begin
        R := SRect;
        R.Top := SRect.Top + SBInfo.xyThumbTop;
        R.Bottom := SRect.Top + SBInfo.xyThumbBottom;
        DrawFrameControl(Handle, R, DFC_BUTTON, DFCS_BUTTONPUSH or Flags);
      end;

      { Draw grip area }
      if SRect.Bottom <> ClientRect.Bottom then
      begin
        R := SRect;
        R.Top := R.Bottom;
        R.Bottom := ClientRect.Bottom;
        Brush.Color := clBtnFace;
        FillRect(R);
      end;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxScrollBoxGrabber.GrabToBitmap(ABitmap: TBitmap; X,
  Y: integer; AControl: TControl; ARect: TRect);
begin
  inherited;

  { Grab scrollbars }
  GrabScrollBarsToBitmap(ABitmap, X, Y, AControl, ARect);
end;

{ TLMDFxMemoGrabber =============================================================}
class function TLMDFxMemoGrabber.GetGrabberClassName: string;
begin
  Result := 'TCustomMemo;TMemo;TEdit';
end;

{ ---------------------------------------------------------------------------- }
class function TLMDFxMemoGrabber.GetGrabberClassType: TLMDFxGrabberControlClass;
begin
  Result := TCustomMemo;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxMemoGrabber.GrabToBitmap(ABitmap: TBitmap; X, Y: integer;
  AControl: TControl; ARect: TRect);
var
  R: TRect;
  {.$IFNDEF C LR}
  Flags,
  {.$ENDIF}
  Style, ExStyle: Cardinal;
  Margin: {$IFDEF LMDX64}TPoint{$ELSE}TSmallPoint{$ENDIF};
begin
  inherited ;
  { Grab memo text }
  Style := GetWindowLong(THackWControl(AControl).Handle, GWL_STYLE);
  ExStyle := GetWindowLong(THackWControl(AControl).Handle, GWL_EXSTYLE);
  R := THackWControl(AControl).ClientRect;
  if (Style and WS_BORDER <> 0) or (ExStyle and WS_EX_CLIENTEDGE <> 0) then
  begin
    Inc(R.Left, 2);
    Inc(R.Top, 2);
  end;

  Margin :=  {$IFDEF LMDX64}TPoint{$ELSE}TSmallPoint{$ENDIF}(SendMessage(THackWControl(AControl).Handle, EM_GETMARGINS, 0, 0));
  Inc(R.Left, Margin.X + 1);
  Inc(R.Top, Margin.Y + 1);

  OffsetRect(R, X, Y);

  with ABitmap.Canvas do
  begin
    Font.Assign(THackWControl(AControl).Font);
    Brush.Style := bsClear;

    Flags := DT_LEFT;
    Flags := THackWControl(AControl).DrawTextBiDiModeFlags(Flags);
    Windows.DrawText(Handle, PChar(TMemo(AControl).Text), Length(TMemo(AControl).Text), R, flags);
    end;
end;

{ ************************ class TLMDFxListBoxGrabber************************* }
{ ------------------------------ public -------------------------------------- }
class function TLMDFxListBoxGrabber.GetGrabberClassName: string;
begin
  Result := 'TCustomListBox;TListBox;TCheckListBox';
end;

{ ---------------------------------------------------------------------------- }
class function TLMDFxListBoxGrabber.GetGrabberClassType: TLMDFxGrabberControlClass;
begin
  Result := TCustomListBox;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxListBoxGrabber.GrabToBitmap(ABitmap: TBitmap; X, Y: integer;
  AControl: TControl; ARect: TRect);
begin
  inherited;
  SendMessage(THackWcontrol(AControl).Handle, WM_PAINT, ABitmap.Canvas.Handle, 0);
  end;

initialization
  User32Handle := GetModuleHandle(user32);
  if User32Handle > 0 then
    GetScrollBarInfoFunc := GetProcAddress(User32Handle, 'GetScrollBarInfo');
  LMDFxRegisterGrabber(TLMDFxFormGrabber);
  LMDFxRegisterGrabber(TLMDFxButtonGrabber);
  LMDFxRegisterGrabber(TLMDFxBitBtnGrabber);
  LMDFxRegisterGrabber(TLMDFxCheckBoxGrabber);
  LMDFxRegisterGrabber(TLMDFxScrollBoxGrabber);
  LMDFxRegisterGrabber(TLMDFxMemoGrabber);
  LMDFxRegisterGrabber(TLMDFxListBoxGrabber);

finalization
  if User32Handle > 0 then
    begin
      FreeLibrary(User32Handle);
      User32Handle:=0;
    end;
end.
