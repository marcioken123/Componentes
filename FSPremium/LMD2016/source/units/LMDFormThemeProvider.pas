unit LMDFormThemeProvider;
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

LMDFormThemeProvider unit (VB)
------------------------------

Changes
-------
Release 8.0 (May 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Graphics, Messages,
  UxTheme, Themes, LMDTypes, LMDThemes, LMDThemesMain,
  LMDBaseGraphicControl, LMDThemesEngine, LMDWndProcComponent;

type
  {------------------------- TLMDFormThemeProvider -----------------------------------}
  TLMDNCButtonIDs = WP_SYSBUTTON..WP_MDIHELPBUTTON;
  TLMDNCMetricIDs = WP_CAPTION..WP_SMALLFRAMEBOTTOM;
  TLMDNCMetricIDSet = set of TLMDNCMetricIDs;
  TLMDNCButtonIDSet = set of TLMDNCButtonIDs;

  TLMDFormThemeProvider = class(TLMDWndProcComponent)
  private
    FOptions: TLMDFormThemeProviderOptions;
    FUseGlobalOptions: boolean;

    FBtnRects: array[TLMDNCButtonIDs, PBS_NORMAL..PBS_DISABLED] of TRect;
    FMetrics: array[TLMDNCMetricIDs, FS_ACTIVE..FS_INACTIVE] of integer;

    FContentMargins,
    FCaptionMargins,
    FSizingMargins: TMargins;

    FFrameLeftID,
    FFrameRightID,
    FFrameBottomID,
    FCaptionID: cardinal;

    FLastPaintedBtnID: cardinal;

    FButtonSet: TLMDNCButtonIDSet;

    FWndActive: Boolean;

    FTitleBarBmp: TBitmap;
    FIconBitmap:TBitmap;

    FPainting: boolean;
    FNCDeltaRect: TRect;
    FThemeAvailableWhenCreated: boolean;

    FCanNullifyRegion: boolean;

    FNCLButtonDownAreaID: cardinal;
    FNCLButtonDown: boolean;
    FNCMouseDownPos: TPoint;
    FWindowMouseDownRect: TRect;

    procedure PrepareTitleBarBmp;
    procedure PrepareFormIconBitmap;
    procedure PaintTitleBarTo(DC: HDC);
    procedure PaintTitleBar;

    procedure PaintNCArea;
    procedure PaintNCAreaBgrTo(DC: HDC; StateID: cardinal);
    procedure PaintButton(DC:HDC; BtnID, StateID: cardinal);
    function UpdateButton(Msg: TMessage): cardinal;
    procedure UpdateRegion;

    procedure SetOptions(aValue: TLMDFormThemeProviderOptions);
    procedure SetUseGlobalOptions(aValue: boolean);
    function CurrentOptions: TLMDFormThemeProviderOptions;
    function IsEnabled: boolean;
  protected
    procedure EnabledChanged; override;
    procedure GetNCAreaThemeMetrics;
    procedure GetButtonRects;
    function GetButtonIDAtPos(x,y: integer): cardinal;
    procedure WndProc(var Message: TMessage);override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoThemeChange;
    procedure ReInit;
    procedure UpdateControls;
    procedure UpdateForm;
  published
    property About;
    property Enabled;
    property Options: TLMDFormThemeProviderOptions read FOptions write SetOptions default
      [ftpShowSysButton, ftpThemedNCArea];
    property UseGlobalOptions: boolean read FUseGlobalOptions write SetUseGlobalOptions
      default true;
  end;

implementation

uses
  Types, Controls, SysUtils, Forms,
  LMDBmp, LMDClass, LMDSysIn, intfLMDBase, LMDUtils, LMDUnicode,
  LMDGraphUtils, LMDThemesWindowsXPTypes;

const
   //Button ID subsets
   NormalBtnIDSubSet: TLMDNCButtonIDSet =
     [WP_SYSBUTTON, WP_MINBUTTON, WP_MAXBUTTON, WP_CLOSEBUTTON{, WP_RESTOREBUTTON, WP_HELPBUTTON}];
   MDIBtnIDSubSet: TLMDNCButtonIDSet =
     [WP_MDISYSBUTTON, WP_MDIMINBUTTON, WP_MDICLOSEBUTTON, WP_MDIRESTOREBUTTON, WP_MDIHELPBUTTON];
   ToolBtnIDSubSet: TLMDNCButtonIDSet = [WP_SMALLCLOSEBUTTON];
   DialogBtnIDSUbset: TLMDNCButtonIDSet = [WP_HELPBUTTON, WP_CLOSEBUTTON];
   //Metric ID subsets
   HorizontalMetricIDSubSet: TLMDNCMetricIDSet =
     [WP_FRAMELEFT, WP_FRAMERIGHT, WP_SMALLFRAMELEFT, WP_SMALLFRAMERIGHT];

{------------------------------------------------------------------------------}
procedure TLMDFormThemeProvider.PaintNCArea;
var
  WndDC   :HDC;
  StateID: cardinal;
begin
  if (csDesigning in ComponentState) or
     not LMDThemeServices.CurrentRenderer.Enabled or
     not IsEnabled or
     not(ftpThemedNCArea in CurrentOptions) or
     (IsIconic(WndHandle) and not NewStyleControls) or
     not IsWindow(WndHandle) or
     not IsWindowVisible(WndHandle) or
     not WndOwner.HandleAllocated or
     FPainting then Exit;

  WndDC := GetWindowDC(WndHandle);
  FPainting := True;
  if FWndActive then
    StateID := FS_ACTIVE
  else
    StateID := FS_INACTIVE;
  try
    PrepareTitleBarBmp;
    PaintNCAreaBgrTo(WndDC, StateID);
    PaintTitleBarTo(WndDC);
  finally
    ReleaseDC(WndHandle, WndDC);
    FPainting:=False;
  end;
end;

{--------------------------- Protected ----------------------------------------}
procedure TLMDFormThemeProvider.ReInit;
begin
  if (ComponentState * [csDestroying, csLoading, csDesigning] <> []) then
    exit;

  if Assigned(LMDThemeServices.CurrentRenderer) then
    if not LMDThemeServices.CurrentRenderer.Enabled or not IsEnabled or (LMDThemeServices.CurrentRenderer.GetCurrentThemeHandle = 0) then
    begin
      UpdateForm;
      exit;
    end;

  if WndOwner.HandleAllocated {and UxThemeLibraryAvailable} then
    begin
      if ftpThemedNCArea in CurrentOptions then
        begin
          if WndOwner.FormStyle = fsMDIChild then
            FButtonSet := MDIBtnIDSubSet
          else
            case WndOwner.BorderStyle of
              bsNone:
                FButtonSet := [];
              bsDialog:
                FButtonSet := DialogBtnIDSubSet;
              bsToolWindow,
              bsSizeToolWin:
                FButtonSet := ToolBtnIDSubSet;
              else
                FButtonSet := NormalBtnIDSubSet;
            end;

          GetNCAreaThemeMetrics;
          GetButtonRects;
          PrepareFormIconBitmap;
        end
      else
        WndOwner.Repaint;

      UpdateForm;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormThemeProvider.WndProc(var Message: TMessage);

var

  LPos: TPoint;

  procedure Default;
  begin
    CallPrevWndProc(Message);
  end;

  function CheckNCMouseMsg: boolean;
  var
    r: boolean;
  begin
    with message do
      r := ((msg = WM_NCMOUSEMOVE) and
         (wParam in [HTLEFT, HTRIGHT, HTBOTTOM, HTTOP])) or
         (wParam in [HTCAPTION])
         ;
    result := r;
  end;

  procedure UpdateWindowPos;
  var
    L, T, W, H: integer;
  begin
    L := 0;
    T := 0;
    W := 0;
    H := 0;
    if FNCLButtonDown and (WndOwner.WindowState = WSNORMAL) then
      begin
        case FNCLButtonDownAreaID of
          HTCAPTION:
             begin
               L := 1;
               T := 1;
             end;
          HTLEFT:
             begin
               L := 1;
               W := -1;
             end;
          HTRIGHT:
             W := 1;
          HTTOP:
             begin
               T := 1;
               H := -1;
             end;
          HTBOTTOM:
             begin
               H := 1;
             end;
          HTTOPLEFT:
             begin
               L := 1;
               T := 1;
               W := -1;
               H := -1;
             end;
          HTBOTTOMLEFT:
             begin
               L := 1;
               W := -1;
               H := 1;
             end;
          HTTOPRIGHT:
             begin
               T := 1;
               W := 1;
               H := -1;
             end;
          HTBOTTOMRIGHT:
             begin
               W := 1;
               H := 1;
             end;
        end;
        SetWindowPos(WndOwner.Handle, 0,
                       FWindowMouseDownRect.Left + L * (LPos.X - FNCMouseDownPos.x),
                       FWindowMouseDownRect.Top + T * (LPos.Y - FNCMouseDownPos.Y),
                       FWindowMouseDownRect.Right - FWindowMouseDownRect.Left + W * (LPos.X - FNCMouseDownPos.x),
                       FWindowMouseDownRect.Bottom - FWindowMouseDownRect.Top + H * (LPos.Y - FNCMouseDownPos.Y), 0);
      end;
  end;

begin
  //if LMDThemeService.SystemThemeIsChanging then   //check!!!!
  //  exit;

  if Assigned(LMDThemeServices.CurrentRenderer) then
    if not LMDThemeServices.CurrentRenderer.Enabled or
    not IsEnabled or (ComponentState * [csDesigning, csDestroying] <> [])
    or (LMDThemeServices.CurrentRenderer.GetCurrentThemeHandle = 0) then
    begin
      if (Message.Msg = CM_LMDTHEMECHANGED) then
        UpdateForm;
      Default;
      exit;
    end;

  if not (ftpThemedNCArea in CurrentOptions) then
    begin
      with Message do
        case Msg of
          WM_NCActivate:
             begin
               with TWMNCACTIVATE(Message) do
               FWndActive := Active;
               Default;
             end;
          CM_LMDTHEMECHANGED:
            begin
              ReInit;
              WndOwner.Invalidate;
              Result:=0;
            end;
          else
            Default;
        end;
      exit;
    end;

   with Message do
     begin
       case msg of
         CM_TEXTCHANGED:
           begin
             Default;
             PrepareTitleBarBmp;
             PaintTitleBar;
             exit;
           end;
         WM_NCCalcSize:
           begin
             if Bool(wParam) = true then
             with TWMNCCalcSize(Message).CalcSize_Params^ do
               begin
                 rgrc[0].Top := rgrc[0].Top - FNCDeltaRect.Top;
                 rgrc[0].Left := rgrc[0].Left - FNCDeltaRect.Left;
                 rgrc[0].Right := rgrc[0].Right + FNCDeltaRect.Right;
                 rgrc[0].Bottom := rgrc[0].Bottom + FNCDeltaRect.Bottom;
               end;
             end;
         WM_NCActivate:
             begin
               with TWMNCACTIVATE(Message) do
               FWndActive := Active;
               PaintNCArea;
               result := 1;
               exit;
            end;
         WM_LBUTTONUP:
            begin
              FNCLButtonDown := False;
              ReleaseCapture;
            end;
         WM_MOUSEMOVE:
           begin
             with TWMMouseMove(Message) do
             begin
                 LPos.X := XPos;
                 LPos.Y := YPos;
               end;
             ClientToScreen(WndOwner.Handle, LPos);
             UpdateWindowPos;
           end;
         WM_NCLBUTTONDOWN:
           begin
             FNCLButtonDownAreaID := wParam;
             FNCLButtonDown := True;
             with TWMNCLButtonDown(Message) do
             begin
                 FNCMouseDownPos.X := XCursor;
                 FNCMouseDownPos.Y := YCursor;
               end;
             GetWindowRect(WndOwner.Handle, FWindowMouseDownRect);
             if CheckNCMouseMsg then
               PaintTitleBar;
             if UpdateButton(Message) = 0 then
               SetCapture(WndOwner.Handle);
             Result := 0;
             Exit;
           end;
         WM_NCMOUSEMOVE:
           begin
             if CheckNCMouseMsg then
               PaintTitleBar;
             UpdateButton(Message);
             with TWMNCMouseMove(Message) do
             begin
                 LPos.X := XCursor;
                 LPos.Y := YCursor;
               end;
             UpdateWindowPos;
             Result := 0;
             Exit;
           end;
         WM_NCLBUTTONDBLCLK:
           begin
             if WndOwner.WindowState = wsNormal then
               WndOwner.WindowState := wsMaximized
             else
               WndOwner.WindowState := wsNormal;
             Result := 0;
             exit;
           end;
         WM_NCLBUTTONUP:
           begin
             FNCLButtonDown := false;
             ReleaseCapture;             
             case UpdateButton(Message) of
               WP_SMALLCLOSEBUTTON,
               WP_MDICLOSEBUTTON,
               WP_CLOSEBUTTON:
                 WndOwner.Close;
               WP_RESTOREBUTTON: WndOwner.WindowState := wsNormal;
               WP_MAXBUTTON: WndOwner.WindowState := wsMaximized;
               WP_MDIMINBUTTON,
               WP_MINBUTTON: if WndOwner = Application.MainForm then
                                ShowWindow(Application.Handle, SW_MINIMIZE)
                             else
                               if WndOwner.WindowState = wsMinimized then
                                 WndOwner.WindowState := wsNormal
                               else
                                 WndOwner.WindowState := wsMinimized;
               WP_HELPBUTTON:;
             end;
           end;
         WM_SIZE:
            begin
              FLastPaintedBtnID := 0;
              UpdateRegion;
              GetButtonRects;
              PaintNCArea;
            end;
         WM_NCPaint:
            begin
              PaintNCArea;
              result := 0;
              exit;
           end;
         CM_LMDTHEMECHANGED:
           begin
             ReInit;
             WndOwner.Invalidate;
             result:=0;
             exit;
           end;
         else
           result := 0;
       end;
       Default;
     end;
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDFormThemeProvider.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);

  FCanNullifyRegion := false;

  FUseGlobalOptions := true;
  if Assigned(LMDThemeServices.CurrentRenderer) then
    FOptions := LMDThemeServices.CurrentRenderer.FormThemeProviderOptions
  else
    FOptions := [];

  FThemeAvailableWhenCreated := Assigned(LMDThemeServices.CurrentRenderer) and (LMDThemeServices.CurrentRenderer.GetCurrentThemeHandle <> 0) and WndOwner.Visible;

  FPainting := False;

  FButtonSet := NormalBtnIDSubSet;
  FTitleBarBmp := TBitmap.Create;
  FTitleBarBmp.PixelFormat := pf32Bit;
  FIconBitmap := TBitmap.Create;
  FIconBitmap.PixelFormat := pf32Bit;

  with FNCDeltaRect do
  begin
    Left := 0;
    Top := 0;
    Right := 0;
    Bottom := 0;
  end;

  if Assigned(LMDThemeServices.CurrentRenderer) then
    LMDThemeServices.CurrentRenderer.RegisterFormThemeProvider(self);

  if csDesigning in ComponentState then
    if LMDCheckForSameClass(aOwner, self.ClassType, false) then
      raise ELMDOneInstError.Create(self.ClassName,0);
end;

{------------------------------------------------------------------------------}
destructor TLMDFormThemeProvider.Destroy;
begin
  FIconBitmap.Free;
  FTitleBarBmp.Free;
  if Assigned(LMDThemeServices.CurrentRenderer) then
    LMDThemeServices.CurrentRenderer.UnregisterFormThemeProvider(TObject(self));
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormThemeProvider.DoThemeChange;
begin
  ReInit;
  UpdateControls;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormThemeProvider.GetNCAreaThemeMetrics;
var
  tmps: TSize;
  WndDC: HDC;
  MetricID, StateID: cardinal;
  LOldNCDelta: TRect;
begin
  WndDC := GetWindowDC(WndHandle);

  if WndOwner.BorderStyle in [bsToolWindow, bsSizeToolWin] then
    begin
      FFrameLeftID := WP_SMALLFRAMELEFT;
      FFrameRightID := WP_SMALLFRAMERIGHT;
      FCaptionID := WP_SMALLCAPTION;
      FFrameBottomID := WP_SMALLFRAMEBOTTOM;
    end
  else
    begin
      FFrameLeftID := WP_FRAMELEFT;
      FFrameRightID := WP_FRAMERIGHT;
      FCaptionID := WP_CAPTION;
      FFrameBottomID := WP_FRAMEBOTTOM;
    end;

  LOldNCDelta := FNCDeltaRect;

  if not FThemeAvailableWhenCreated then
    begin
      case WndOwner.BorderStyle of
       bsToolWindow:
         begin
           FNCDeltaRect.Top :=  LMDNCSMALLCAPTIONHEIGHT + LMDNCFIXBORDERHEIGHT;
           FNCDeltaRect.Left :=  LMDNCFIXBORDERWIDTH;
           FNCDeltaRect.Right :=  LMDNCFIXBORDERWIDTH;
           FNCDeltaRect.Bottom :=  LMDNCFIXBORDERHEIGHT;
         end;
       bsSizeToolWin:
         begin
           FNCDeltaRect.Top :=  LMDNCSMALLCAPTIONHEIGHT + LMDNCBORDERHEIGHT - 2;
           FNCDeltaRect.Left := LMDNCBORDERWIDTH;
           FNCDeltaRect.Right := LMDNCBORDERWIDTH;
           FNCDeltaRect.Bottom :=  LMDNCBORDERHEIGHT;
         end;
      else
        begin
          FNCDeltaRect.Top := LMDNCCAPTIONHEIGHT + LMDNCBORDERHEIGHT - 2;
          FNCDeltaRect.Left := LMDNCBORDERWIDTH;
          FNCDeltaRect.Right := LMDNCBORDERWIDTH;
          FNCDeltaRect.Bottom :=  LMDNCBORDERHEIGHT;
        end
      end
    end
  else
    begin
      FNCDeltaRect.Top := FMetrics[FCaptionID, FS_ACTIVE];
      FNCDeltaRect.Left := FMetrics[FFrameLeftID, FS_ACTIVE];
      FNCDeltaRect.Right := FMetrics[FFrameRightID, FS_ACTIVE];
      FNCDeltaRect.Bottom := FMetrics[FFrameBottomID, FS_ACTIVE];
    end;

  try
    for MetricID := low(TLMDNCMetricIDs) to high(TLMDNCMetricIDs) do
      for StateId := FS_ACTIVE to FS_INACTIVE do
        begin
          //TODO -> TLMDThemeServices.GetThemePartSize
          LMDThemesMain.GetThemePartSize(LMDThemeEngine.Theme[teWindow], WndDC, MetricID, StateID, nil, TS_TRUE, tmps);

          if MetricID in HorizontalMetricIDSubSet then
            FMetrics[MetricID, StateId] := tmps.cx - 1
          else
            FMetrics[MetricID, StateId] := tmps.cy - 1;

          if FMetrics[MetricID, StateId] <= 0 then
            case MetricID of
              WP_FRAMELEFT,
              WP_FRAMERIGHT:
                FMetrics[MetricID, StateId] := LMDNCSIZEBORDERWIDTH;
              WP_FRAMEBOTTOM:
                FMetrics[MetricID, StateId] := LMDNCSIZEBORDERHEIGHT;
              WP_CAPTION:
                FMetrics[MetricID, StateId] := LMDNCCAPTIONHEIGHT;
              WP_SMALLFRAMELEFT,
              WP_SMALLFRAMERIGHT:
                FMetrics[MetricID, StateId] := LMDNCDLGBORDERWIDTH;
              WP_SMALLFRAMEBOTTOM:
                FMetrics[MetricID, StateId] := LMDNCDLGBORDERHEIGHT;
              WP_SMALLCAPTION:
                FMetrics[MetricID, StateId] := LMDNCSMALLCAPTIONHEIGHT;
            end;
        end;

    if (WndOwner.BorderStyle in [bsToolWindow, bsSizeToolWin]) and FThemeAvailableWhenCreated then
      FNCDeltaRect.Top := FMetrics[FCaptionID, FS_ACTIVE] + 2;

    LMDThemesMain.GetThemeMargins(LMDThemeEngine.Theme[teWindow], WndDC, FCaptionID, FS_ACTIVE, TMT_CONTENTMARGINS, FContentMargins);
    LMDThemesMain.GetThemeMargins(LMDThemeEngine.Theme[teWindow], WndDC, FCaptionID, FS_ACTIVE, TMT_CAPTIONMARGINS, FCaptionMargins);
    LMDThemesMain.GetThemeMargins(LMDThemeEngine.Theme[teWindow], WndDC, FCaptionID, FS_ACTIVE, TMT_SIZINGMARGINS, FSizingMargins);
  finally
    ReleaseDC(WndHandle, WndDC);
    if FNCDeltaRect.Top <> 0 then
      FNCDeltaRect.Top := FNCDeltaRect.Top - FMetrics[FCaptionID, FS_ACTIVE];
    if FNCDeltaRect.Left <> 0 then
      FNCDeltaRect.Left := FNCDeltaRect.Left - FMetrics[FFrameLeftID, FS_ACTIVE];
    if FNCDeltaRect.Right <> 0 then
      FNCDeltaRect.Right := FNCDeltaRect.Right - FMetrics[FFrameRightID, FS_ACTIVE];
    if FNCDeltaRect.Bottom <> 0 then
      FNCDeltaRect.Bottom := FNCDeltaRect.Bottom - FMetrics[FFrameBottomID, FS_ACTIVE];
    //if FThemeAvailableWhenCreated then
    //  begin
    //    if FNCDeltaRect = 0 then
    //      FNCDeltaRect := LOldDelta;
    //  end
    //else
    //  begin
    //    if FNCDeltaRect <= 0 then
    //      FNCDeltaRect := LOldDelta;
    //  end
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormThemeProvider.GetButtonRects;
var
  tmps:TSize;
  WndDC: HDC;
  StateID, BtnID: cardinal;
  LOrigin, LOffset: TPoint;
  RWidth, LDelta, LOffsetInt: integer;
  LOffSetType: TXPOffsetType;
  LBtnIdSet: TLMDNCButtonIDSet;
  LRestoreBtnId: cardinal;
begin

  WndDC := GetWindowDC(WndHandle);
  RWidth := WndOwner.Width;
  LDelta := 0;
  LBtnIdSet := FButtonSet;
  if (WndOwner.BorderStyle = bsSizeable) then
  begin
    if WndOwner.FormStyle = fsMDIChild then
      LRestoreBtnId := WP_MDIRESTOREBUTTON
    else
      LRestoreBtnId := WP_RESTOREBUTTON;
    if (WndOwner.WindowState = wsMaximized) then
    begin
      FButtonSet := FButtonSet - [WP_MAXBUTTON];
      FButtonSet := FButtonSet + [LRestoreBtnID];
    end
    else
    begin
      FButtonSet := FButtonSet + [WP_MAXBUTTON];
      FButtonSet := FButtonSet - [LRestoreBtnID];
    end;
  end;

  try
    for BtnID := low (TLMDNCButtonIDs) to high(TLMDNCButtonIDs) do
      if BtnID in FButtonSet then
        for StateID := PBS_NORMAL to PBS_DISABLED do
        begin
          LMDThemesMain.GetThemePartSize(LMDThemeEngine.Theme[teWindow], WndDC, BtnID, StateID, nil, TS_TRUE, tmps);
          LMDThemesMain.GetThemePosition(LMDThemeEngine.Theme[teWindow], BtnID, StateID, TMT_OFFSET, LOffset);
          LMDThemesMain.GetThemeEnumValue(LMDThemeEngine.Theme[teWindow], BtnID, StateID, TMT_OFFSETTYPE, LOffSetInt);
          LOffSetType := TXPOffsetType(LOffSetInt);

          case LOffSetType of
            otTopLeft:
              begin
                LOrigin.x := LDelta + FContentMargins.cxLeftWidth;
                LOrigin.y := FContentMargins.cyTopHeight;
              end;
            otTopRight:
              begin
                LOrigin.x := RWidth - LDelta - FContentMargins.cxRightWidth;
                LOrigin.y := FContentMargins.cyTopHeight;
                LOffset.x := - abs(LOffset.x);
              end;
            otTopMiddle:
              begin
                LOrigin.x := RWidth div 2;
                LOrigin.y := FContentMargins.cyTopHeight;
              end;
            otBottomLeft:
              begin
                LOrigin.x := LDelta + FContentMargins.cxLeftWidth;
                LOrigin.y := FMetrics[FCaptionID, FS_ACTIVE] - FContentMargins.cyBottomHeight;
                LOffset.y := - abs(LOffset.y);
              end;
            otBottomRight:
              begin
                LOrigin.x := RWidth - LDelta - FContentMargins.cxRightWidth;
                LOrigin.y := FMetrics[FCaptionID, FS_ACTIVE] - FContentMargins.cyBottomHeight;
                LOffset.x := - abs(LOffset.x);
                LOffset.y := - abs(LOffset.y);
              end;
            otBottomMiddle:
              begin
                LOrigin.x := RWidth div 2;
                LOrigin.y := FMetrics[FCaptionID, FS_ACTIVE] - FContentMargins.cyBottomHeight;
                LOffset.y := - abs(LOffset.y);
              end;
            otMiddleLeft:
              begin
                LOrigin.x := LDelta + FContentMargins.cxLeftWidth;
                LOrigin.y := FMetrics[FCaptionID, FS_ACTIVE] div 2;
              end;
            otMiddleRight:
              begin
                LOrigin.x := RWidth - LDelta - FContentMargins.cxRightWidth;
                LOrigin.y := FMetrics[FCaptionID, FS_ACTIVE] div 2;
                LOffset.x := - abs(LOffset.x);
              end;
            {otLeftOfCaption:
            otRightOfCaption:
            otLeftOfLastButton:
            otRightOfLastButton:
            otAboveLastButton:
            otBelowLastButton:}
          end;

          with FBtnRects[BtnID, StateID] do
            begin
              Top := LOrigin.y + LOffset.y;
              Left := LOrigin.x + LOffset.x;
              Right := Left + tmps.cx;
              Bottom := Top + tmps.cy;
              if Bottom > FMetrics[FCaptionID, FS_ACTIVE] then
                begin
                  Bottom := FMetrics[FCaptionID, FS_ACTIVE] - FContentMargins.cyBottomHeight;
                  Top := Bottom - tmps.cy;
                end;
              if Top <= 0 then
                begin
                  Top := FContentMargins.cyTopHeight + (FMetrics[FCaptionID, FS_ACTIVE] - FContentMargins.cyTopHeight) div 2 - tmps.cy div 2;
                  Bottom := Top + tmps.cy;
                end;
            end;

        end;

    with FBtnRects[WP_SYSBUTTON, PBS_NORMAL] do
    begin
      Left := FCaptionMargins.cxLeftWidth + 2;
      Top := 8; //LSizingMargins.cyTopHeight;
      Right := Left +15;//Left + LMDNCSmallBitmapWidth;
      Bottom := 8 + 15;//Top + LMDNCSmallBitmapHeight;
    end;

  finally
    ReleaseDC(WndHandle, WndDC);
  end;

end;

{------------------------------------------------------------------------------}
function TLMDFormThemeProvider.GetButtonIDAtPos(x, y: integer): cardinal;
var
  BtnID: cardinal;
begin
  result := 0;
  for BtnID := low (TLMDNCButtonIDs) to high (TLMDNCButtonIDs) do
    if BtnID in FButtonSet then
      if PtInRect(FBtnRects[BtnID, PBS_NORMAL],Point(x,y)) then
        begin
          result := BtnID;
          break;
        end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormThemeProvider.PaintButton(DC: HDC; BtnID, StateID: cardinal);
begin
  LMDThemesMain.DrawThemeBackground(LMDThemeEngine.Theme[teWindow], DC, BtnID, StateID, FBtnRects[BtnID, StateID], nil);
end;

{------------------------------------------------------------------------------}
function TLMDFormThemeProvider.UpdateButton(Msg: TMessage): cardinal;
var
  BtnID: cardinal;
  mPoint: {$IFDEF LMDX64}TPoint{$ELSE}TSmallPoint{$ENDIF};
  yPoint: TPoint;
  WndDC: HDC;
begin
  WndDC := GetWindowDC(WndHandle);
  {$IFDEF LMDX64}
  mPoint := TPoint (Msg.lParam);
  {$ELSE}
  mPoint := TSmallPoint (Msg.lParam);
  {$ENDIF}
  yPoint.X := mPoint.x - WndOwner.Left;
  yPoint.Y := mPoint.y - WndOwner.Top;

  BtnId := GetButtonIDAtPos(yPoint.x, yPoint.y);
  if BtnID <> 0 then
    begin
      if (FLastPaintedBtnID <> 0) and (FLastPaintedBtnID <> BtnID) then
        PaintButton(WndDC, FLastPaintedBtnID, PBS_NORMAL);
      FLastPaintedBtnID := BtnID;
      case Msg.Msg of
        WM_NCMOUSEMOVE:
          PaintButton(WndDC, BtnID, PBS_HOT);
        WM_NCLBUTTONDOWN:
          PaintButton(WndDC, BtnID, PBS_PRESSED);
        WM_NCLBUTTONUP:
          PaintButton(WndDC, BtnID, PBS_NORMAL);
      end;
    end
  else
    if FLastPaintedBtnID <> 0 then
      begin
        PaintButton(WndDC, FLastPaintedBtnID, PBS_NORMAL);
        FLastPaintedBtnID := 0;
      end;
  result := BtnID;
  ReleaseDC(WndHandle, WndDC);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormThemeProvider.PaintNCAreaBgrTo(DC: HDC; StateID: cardinal);
var
  R, Cr: TRect;
  NCRgn, CRgn: HRgn;

begin
  with WndOwner do
    begin
      //Erase border part if any
      if WndOwner.BorderWidth > 0 then
        begin
          GetWindowRect(WndOwner.Handle, R);
          OffsetRect(R, -R.Left, -R.Top);
          Inc(R.Top, FMetrics[FCaptionID, StateID]);
          GetClientRect(WndOwner.Handle, Cr);
          OffsetRect(Cr, FMetrics[FFrameLeftID, StateID] + WndOwner.BorderWidth, FMetrics[FCaptionID, StateID] + WndOwner.BorderWidth + 2);
          NCRgn := CreateRectRgn(R.Left, R.Top, R.Right, R.Bottom);
          CRgn := CreateRectRgn(Cr.Left, Cr.Top, Cr.Right, Cr.Bottom);
          CombineRgn(NCRgn, NCRgn, CRgn, RGN_DIFF);
          FillRgn(DC, NCRgn, WndOwner.Canvas.Brush.Handle);
          DeleteObject(NCRgn);
          DeleteObject(CRgn);
        end;

      //Draw NC background  
      R.Left := 0;
      R.Top := FMetrics[FCaptionID, StateID];
      R.Right := FMetrics[FFrameLeftID, StateID];
      R.Bottom := Height;

      LMDThemesMain.DrawThemeBackground(LMDThemeEngine.Theme[teWindow], DC, FFrameLeftID, StateID, R, nil);

      R.Left := Width - FMetrics[FFrameRightID, StateID];
      R.Top := FMetrics[FCaptionID, StateID];
      R.Right := Width;
      R.Bottom := Height;

      LMDThemesMain.DrawThemeBackground(LMDThemeEngine.Theme[teWindow], DC, FFrameRightID, StateID, R, nil);

      R.Right := Width;
      R.Bottom := Height;
      R.Left := 0;
      R.Top := R.Bottom - FMetrics[FFrameBottomID, StateID];
      LMDThemesMain.DrawThemeBackground(LMDThemeEngine.Theme[teWindow], DC, FFrameBottomID, StateID, R, nil);

      R.Right := Width;
      R.Bottom := FMetrics[FCaptionID, StateID] + 2;  //VB check!!!
      R.Left := 0;
      R.Top := 0;
      LMDThemesMain.DrawThemeBackground(LMDThemeEngine.Theme[teWindow], DC, FCaptionID, StateID, R, nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormThemeProvider.UpdateRegion;
var
  LBitmap: TBitmap;
  R: TRect;
  DC: HDC;
  LRgn: HRGN;
begin
  if (csDesigning in ComponentState) or
    not LMDThemeServices.CurrentRenderer.Enabled or
    not IsEnabled or
    not (ftpThemedNCArea in CurrentOptions)
    or (LMDThemeServices.CurrentRenderer.GetCurrentThemeHandle = 0) then
    begin
      if FCanNullifyRegion then
        SetWindowRgn(WndHandle, 0, true);
      FCanNullifyRegion := false;
      exit;
    end;
  LBitmap := TBitmap.Create;
  try
    with LBitmap do
      begin
        PixelFormat := pf24bit;
        Width := WndOwner.Width + 1;
        Height := WndOwner.Height;
        Canvas.Brush.Style := bsSolid;
        Canvas.Brush.Color := clBlack;
        R := Rect(0, 0, Width, Height);
        Canvas.FillRect(R);

        R := Rect(FMetrics[FFrameLeftID, FS_ACTIVE],
                  FMetrics[FCaptionID, FS_ACTIVE],
                  Width - FMetrics[FFrameRightID, FS_ACTIVE],
                  Height - FMetrics[FFrameBottomID, FS_ACTIVE]);

        Canvas.Brush.Color := clWhite;
        Canvas.FillRect(R);
      end;
    DC := LBitmap.Canvas.Handle;
    PaintNCAreaBgrTo(DC, FS_ACTIVE);
    LRgn := LMDBmpCreateRgn(LBitmap, clBlack);
    if LRgn <> 0 then
      begin
        SetWindowRgn(WndHandle, LRgn, true);
        FCanNullifyRegion := true;
      end;
  finally
    LBitmap.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormThemeProvider.PrepareTitleBarBmp;
var
  dRect, R, rText: TRect;
  DC: HDC;
  BtnID, StateID, BStateID: cardinal;
  flags: WORD;
  LCaption: TLMDString;
  LFont: TLogFontW;
  hFnt: HFONT;
  FontId: integer;
begin

  with WndOwner do
    begin
      if FWndActive then
        StateID := FS_ACTIVE
      else
        StateID := FS_INACTIVE;

      R.Right := Width;
      R.Bottom := FMetrics[FCaptionID, StateID] + 2;  //VB check!!!
      R.Left := 0;
      R.Top := 0;

      FTitleBarBmp.Width := Width;
      FTitleBarBmp.Height := R.Bottom;

      DC := FTitleBarBmp.Canvas.Handle;
      LMDThemesMain.DrawThemeBackground(LMDThemeEngine.Theme[teWindow], DC, FCaptionID, StateID, R, nil);
    end;

    if StateID = FS_INACTIVE then
      BStateID := PBS_DISABLED
    else
      BStateID := PBS_NORMAL;

    for BtnID := low (TLMDNCButtonIDs) to high(TLMDNCButtonIDs) do
      if BtnID in FButtonSet then
        PaintButton(DC, BtnID, BStateID);

    flags:=NC_ADJUSTRIGHT;
    //flags:=flags OR NC_ADJUSTLEFT;
    if WndOwner.BorderStyle=TFormBorderStyle(bsSingle) then
      flags:=flags or NC_SINGLEBORDER;

    LMDNCCalcDrawingArea(WndHandle, dRect, rText, flags);
    //dRect := Rect(0,0, WndOwner.Width, FMetrics[FCaptionID, StateID]);
    //GetThemeBackgroundContentRect(LMDThemeService.Theme[tiWindow], DC, WP_CAPTION, StateID, dRect, rText);

    if ((flags and NC_HASICON) = NC_HASICON) and (ftpShowSysButton in CurrentOptions) then
      LMDBMPDraw(FTitleBarBmp.Canvas, FBtnRects[WP_SYSBUTTON, PBS_NORMAL], FIconBitmap,
        DSF_TRANSPARENCY, clWhite)
    else
      rText.Left := FCaptionMargins.cxLeftWidth + FMetrics[FFrameLeftID, FS_ACTIVE];

    if WndOwner.BorderStyle in [bsToolWindow, bsSizeToolWin] then
      FontId := TMT_SMALLCAPTIONFONT
    else
      FontId := TMT_CAPTIONFONT;

    LMDThemesMain.GetThemeSysFont(LMDThemeEngine.Theme[teWindow], FontID, LFont);
    LFont.lfWeight := FW_BOLD;
    hFnt := CreateFontIndirectW(LFont);
    SelectObject(DC, hFnt);
    flags := DT_SINGLELINE or DT_NOPREFIX or DT_VCENTER or DT_LEFT;
    OffsetRect(rText, FCaptionMargins.cxLeftWidth, 0);
    LCaption := WndOwner.Caption;
    LMDThemesMain.DrawThemeText(LMDThemeEngine.Theme[teWindow], DC, FCaptionID, StateID, PLMDChar(LCaption), Length(LCaption), flags or DT_WORD_ELLIPSIS, 0, rText);
    DeleteObject(hFnt);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormThemeProvider.PaintTitleBarTo(DC: HDC);
var
  StateID: cardinal;
begin
 if WndOwner.Active then
   FWndActive := true;
 if FWndActive then
   StateID := FS_ACTIVE
 else
   StateID := FS_INACTIVE;
  with WndOwner do
    BitBlt(DC, 0,0, Width, FMetrics[FCaptionID, StateID] + 2, FTitleBarBmp.Canvas.Handle,
                 0, 0, SRCCOPY);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormThemeProvider.PaintTitleBar;
var
  DC: HDC;
begin
  DC := GetWindowDC(WndHandle);
  try
    PaintTitleBarTo(DC);
  finally
    ReleaseDC(WndHandle, DC);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormThemeProvider.PrepareFormIconBitmap;
var
  LIcon: TIcon;
  LBitmap: TBitmap;
begin
  LIcon := WndOwner.Icon;
  if LIcon.Empty then
    LIcon := Application.Icon;
  LBitmap := TBitmap.Create;
  try
    LBitmap.Width := LIcon.Width;
    LBitmap.Height := LIcon.Height;
    LBitmap.Canvas.Draw(0, 0, LIcon);

    with FIconBitmap do
      begin
        Width := FBtnRects[WP_SYSBUTTON, PBS_NORMAL].Right - FBtnRects[WP_SYSBUTTON, PBS_NORMAL].Left;
        Height := FBtnRects[WP_SYSBUTTON, PBS_NORMAL].Bottom - FBtnRects[WP_SYSBUTTON, PBS_NORMAL].Top;
        Canvas.StretchDraw(Rect(0, 0, Width, Height), LBitmap);
      end;
  finally
    LBitmap.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormThemeProvider.SetOptions(aValue: TLMDFormThemeProviderOptions);
begin
  if aValue <> FOptions then
    begin
      FOptions := aValue;
      ReInit;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormThemeProvider.SetUseGlobalOptions(aValue: boolean);
begin
  if aValue <> FUseGlobalOptions then
    begin
      FUseGlobalOptions := aValue;
      if FUseGlobalOptions then
        SetOptions(LMDThemeServices.CurrentRenderer.FormThemeProviderOptions)
      else
        ReInit;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDFormThemeProvider.IsEnabled: boolean;
begin
  if UseGlobalOptions then
    Result := (Assigned(LMDThemeServices.CurrentRenderer) and LMDThemeServices.CurrentRenderer.FormThemeProvidersEnabled)
  else
    result := inherited Enabled;
end;

{------------------------------------------------------------------------------}
function TLMDFormThemeProvider.CurrentOptions: TLMDFormThemeProviderOptions;
begin
  if UseGlobalOptions then
    Result := LMDThemeServices.CurrentRenderer.FormThemeProviderOptions
  else
    Result := FOptions;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormThemeProvider.EnabledChanged;
begin
  ReInit;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormThemeProvider.UpdateControls;
var
  i: integer;
begin
  for i := 0 to WndOwner.ControlCount - 1 do
    WndOwner.Controls[i].Perform(WM_THEMECHANGED, 0, 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormThemeProvider.UpdateForm;
begin
  if not LMDThemeServices.CurrentRenderer.Enabled or
    not IsEnabled or (LMDThemeServices.CurrentRenderer.GetCurrentThemeHandle = 0) then
    WndOwner.Color := clBtnFace
  else
    WndOwner.Color := GetThemeSysColor(0, TMT_BTNFACE);
  UpdateRegion;
  if WndOwner.Visible then
    begin
      WndOwner.Invalidate;
      WndOwner.Repaint;
    end;
end;

end.
