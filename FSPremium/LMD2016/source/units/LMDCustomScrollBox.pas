unit LMDCustomScrollBox;
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

LMDCustomScrollBox unit
-------------------------

ToDo: * Transparency does no longer work

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Forms, Graphics, Controls, Messages, Classes, Themes,
  intfLMDBackground, LMDBase, LMDClass, LMDBevel, LMDGraph, LMDTypes;

type

  TLMDScrollBoxBevel=class(TLMDBevel)
  public
    constructor Create(Owner:TPersistent=nil);override;
  published
    property Mode default bmWindows;
  end;

  {--------------------- TLMDScrollBox ----------------------------------------}
  TLMDCustomScrollBox=class(TScrollBox, ILMDBackground)
  private
    FAbout         : TLMDAboutVar;
    FBevel         : TLMDScrollBoxBevel;
    FCanvas        : TCanvas;
    FOptScrollCodes,
    FTransparent,
    FInstantUpdate,
    FFullRepaint   : Boolean;
    FDelta,
    FInternal      : Byte;
    FOnPaint       : TNotifyEvent;

    // added by Hugo
    FOnScroll      : TNotifyEvent; // Not used anymore. Was an event that only
                                  // occurred if a REAL scroll occurred. But I do not use
                                  // it anymore. Maybe you should implement it with the
                                  // parameters vertical or horizontal scroll, and the amount
                                  // of pixel shifted. An event is more easily altered than
                                  // overriding the class
    FSaveResources : Boolean;
    FFirstTimePaint : Boolean;
    FThemeGlobalMode: Boolean;   // don't do it everytime a paint-event occurs, but make sure
                                // it happens at least one time after loading. It would even
                                // be better to do it WHILE loading, because now the resources
                                // skyrocket and then drop to almost nothing.
    procedure SetBevel(aValue: TLMDScrollBoxBevel);
    procedure SetDelta(aValue:Byte);
    procedure SetTransparent(aValue:Boolean);
    procedure SetCtlXP (aValue: Boolean);
    function GetBorderStyle:TBorderStyle;
    function ScrollBarsVisible: Boolean;
    procedure ReadCtlXP(Reader: TReader);
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMParentColorChanged(var Message: TMessage); message CM_PARENTCOLORCHANGED;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    // 6.1
    procedure WMThemeChanged(var Msg:TMessage); message WM_THEMECHANGED;
    // RM
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure WMNCCalcSize(var Message: TWMNCCALCSIZE); message WM_NCCALCSIZE;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMEraseBkGnd(var Message : TWMEraseBkGnd);message WM_ERASEBKGND;
    procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPAINT;
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;

    // added by Hugo
    procedure DestroyHandleForInvisibleControls; // Here it all happens
    procedure SetSaveResources(const Value: boolean);
    procedure SetThemeMode(const Value: TLMDThemeMode);
    procedure SetThemeGlobalMode(const Value: Boolean); // just to set var and call DestroyHa...
    function GetCtlXP: Boolean;
    procedure SetParentThemeMode(const Value: boolean);
  protected
    FThemeMode: TLMDThemeMode;
    FParentThemeMode: boolean;
    function BeveledRect:TRect;
    function  CheckOptimized:Boolean;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd;override;
    procedure GetChange(Sender:TObject);virtual;
    procedure DefineProperties(Filer: TFiler);override;
    procedure Paint;

    function DrawThemeBevel(aTheme: TLMDThemeMode; aCanvas: TCanvas; aRect: TRect): TRect;

    procedure PaintBevel;
    procedure PaintWindow(DC: HDC); override;

    // XP-Support
    //***********
    //handle theme changes
    procedure DoThemeChanged; virtual;
    function UseThemeMode: TLMDThemeMode;

    // Changed 6.1
    property CtlXP:Boolean read GetCtlXP write SetCtlXP default true;  // compatibility
    //***********
  public
    constructor Create(AOwner : TComponent);override;
    destructor Destroy; override;
    function IsThemed: Boolean; // any other than ttmNone
    // 7.0
    function BackBitmapCheck:Boolean;virtual;
    function BackBitmap:TBitmap;virtual;
    function BackMapPoint(const aValue:TPoint):TPoint;virtual;
    function BackDrawArea(Canvas:TCanvas; const dest:TRect; const src:TPoint; flags:Word=0):Boolean;virtual;
    function isTransparentSet: Boolean;
    function BackBitmapPalette: HPalette;
    procedure BackUpdate;
    function BackControl (index: Integer): TControl;
    function BackControlCount: Integer;
    // --
    property Canvas: TCanvas read FCanvas;

    property Bevel: TLMDScrollBoxBevel read FBevel write SetBevel;
    property InstantUpdate:Boolean read FInstantUpdate write FInstantUpdate default True;
    property Transparent:Boolean read FTransparent write SetTransparent default false;
    property UpdateDelta:Byte read FDelta write SetDelta default 1;
    property OnPaint:TNotifyEvent read FOnPaint write FOnPaint;
    //property MouseWheelSupport:Boolean read FMouseWheel write FMouseWheel default false;

    property ParentThemeMode: boolean read FParentThemeMode write SetParentThemeMode;
    property ThemeMode:TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;
    property OptScrollCodes : Boolean read FOptScrollCodes write FOptScrollCodes default true;
  published
    property About:TLMDAboutVar read FAbout write FAbout;
    property BorderStyle:TBorderStyle read GetBorderStyle;
    property Ctl3D default true;
    property ParentCtl3D default false;

    property FullRepaint:Boolean read FFullRepaint write FFullRepaint default false;

    // added by Hugo
    property OnScroll : TNotifyEvent read FOnScroll write FOnScroll;
    property SaveResources : boolean read FSaveResources write SetSaveResources default false;
    // up to here
    {$IFDEF LMDCOMP14}
    property OnGesture;
    property Touch;
    {$ENDIF}
  end;

implementation

uses
  Types, SysUtils, CommCtrl, TypInfo,
  LMDCustomControl, LMDThemes, LMDResWinControl
  {$IFDEF LMD_DEBUGTRACE}, dialogs;{$I C2.INC}{$ELSE};{$ENDIF}

{*********************** TLMDScrollBoxBevel ***********************************}
{-------------------------- Private -------------------------------------------}
constructor TLMDScrollBoxBevel.Create;
begin
  inherited Create;
  SupportWindowsMode:=True;
  Mode:=bmWindows;
end;

{*********************** TLMDCustomScrollBox **********************************}
{-------------------------- Private -------------------------------------------}
procedure TLMDCustomScrollBox.SetBevel(aValue: TLMDScrollBoxBevel);
begin
  FBevel.Assign(aValue);
  Perform (CM_LMDBEVELCHANGED, 0, 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.SetDelta(aValue:Byte);
begin
  if (aValue<>FDelta) and (aValue>0) then
    begin
      FDelta:=aValue;
      FInternal:=0;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.SetParentThemeMode(const Value: boolean);
begin
  if FParentThemeMode <> Value then
  begin
    FParentThemeMode := Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
    begin
      FThemeGlobalMode := Value;
      DoThemeChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.SetThemeMode(const Value: TLMDThemeMode);
begin
   if Value <> FThemeMode then
    begin
      FThemeMode:= Value;
      if not FThemeGlobalMode then       // if we are in GlobalThemeMode, no update required
        DoThemeChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.SetTransparent(aValue:Boolean);
begin
  if aValue<>FTransparent then
    begin
      FTransparent:=aValue;
      if FTransparent then
        ControlStyle:=ControlStyle-[csOpaque]
      else
        ControlStyle:=ControlStyle+[csOpaque];
      // New 09-Dec-02
      RecreateWnd;
      Perform(CM_TRANSPARENTCHANGED,0,0);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.SetCtlXP (aValue: Boolean);
begin
  if aValue <> GetCtlXP then
    ThemeMode := LMDCtlXP[aValue];
end;

{------------------------------------------------------------------------------}
function TLMDCustomScrollBox.GetBorderStyle:TBorderStyle;
begin
  result:=bsNone;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomScrollBox.GetCtlXP: Boolean;
begin
   result := FThemeMode = ttmPlatForm;
end;

{------------------------------------------------------------------------------}
function TLMDCustomScrollBox.ScrollBarsVisible: Boolean;
begin
  result := false;
  if not HandleAllocated then exit;
  result := VertScrollBar.IsScrollBarVisible and HorzScrollBar.IsScrollBarVisible;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.ReadCtlXP(Reader: TReader);
begin
  SetCtlXP(Reader.ReadBoolean);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.CMColorChanged(var Message: TMessage);
begin
  inherited;
  if FTransparent or (csLoading in ComponentState) then exit;
  Invalidate;
  if ScrollBarsVisible then Perform(WM_NCPaint, 0,0);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.CMParentColorChanged(var Message: TMessage);
begin
  inherited;
  if FTransparent or (csLoading in ComponentState) then exit;
  Invalidate;
  if ScrollBarsVisible then Perform(WM_NCPaint, 0,0);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.CMDesignHitTest(var Message: TCMDesignHitTest);
var
  //HitIndex: Integer;
  HitTestInfo: TTCHitTestInfo;
begin
  HitTestInfo.pt:=SmallPointToPoint(Message.Pos);

  {HitIndex:=}SendMessage(Handle, TCM_HITTEST, 0, LPARAM(@HitTestInfo));

end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.WMThemeChanged(var Msg:TMessage);
begin
  inherited;
  {$IFDEF LMDCOMP11}if (csDesigning in ComponentState) then exit;{$ENDIF}
  DoThemeChanged;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomScrollBox.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
 inherited;
 if IsThemed and Ctl3D then
   begin
      with Message.CalcSize_Params^ do
       rgrc[0]:=Rect(rgrc[0].Left-1, rgrc[0].Top-1,
                rgrc[0].Right+1, rgrc[0].Bottom+1);
   end
 else
   with Message.CalcSize_Params^ do
     rgrc[0]:=Rect(rgrc[0].Left+FBevel.BevelExtend, rgrc[0].Top+FBevel.BevelExtend,
              rgrc[0].Right-FBevel.BevelExtendRight, rgrc[0].Bottom-FBevel.BevelExtendRight);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  if csDesigning in ComponentState then
    if Message.Result in [HTNOWHERE, HTGROWBOX] then
    Message.Result:=HTClient;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (FBevel.Mode=bmWindows) then RecreateWnd;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.WMEraseBkGnd(var Message : TWMEraseBkGnd);
begin
  if CheckOptimized then
    begin
      Message.Result:=1;
      if ControlCount<2 then PaintWindow(Message.DC);
    end
  else
    inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.WMMOVE(var Message: TWMMOVE);
begin
  inherited;
  if CheckOptimized then BackUpdate;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.WMPaint(var Message: TWMPaint);
begin
  inherited;
  {if CheckOptimized then
    if ControlCount=0 then PaintWindow(Message.DC);}

  // added by HUGO to destroy handles when loading is complete
  // probably there is a better location to do this, but it must be
  // done AFTER the first paint, otherwise windows will automatically
  // recreate the handle when first painting...
  if not(FFirstTimePaint) then
    begin
      FFirstTimePaint := true;
      // RM !
      if FSaveResources then
        DestroyHandleForInvisibleControls;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.WMNCPaint(var Msg: TWMNCPaint);
var
  DC:HDC;
begin
  inherited;
  if  (csDestroying in ComponentState) or ((csLoading in ComponentState) and not IsWindowVisible(Handle)) then exit;
  DC:=GetWindowDC(Handle);
  if DC<>0 then
    try
      FCanvas.Lock;
      try
        FCanvas.Handle:=DC;
        try
          PaintBevel;
        finally
          FCanvas.Handle:=0;
        end;
      finally
        FCanvas.UnLock;
      end;
    finally
      ReleaseDC(Handle, DC);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.WMSIZE(var Message: TWMSIZE);
begin
  inherited;
  // 6.1
  if FFullRepaint then
    begin
      GetChange(nil);
      //Perform(WM_NCPaint, 0,0);
    end
  else
    Perform(WM_NCPaint, 0,0);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.WMHScroll(var Message: TWMHScroll);
var
  ScrollDiff : integer; // added by HUGO
begin
  ScrollDiff := HorzScrollBar.Position; // added by HUGO
  inherited;
  //these ScrollCodes occur never alone or are of no interest (scTrack)
//  if FOptScrollCodes and (Message.ScrollCode in [SB_TOP, SB_BOTTOM, SB_ENDSCROLL, Ord(scTrack)]) then exit;
  if CheckOptimized then
    begin
      if FInstantUpdate then
        begin
          Inc(FInternal);
          if FInternal<FDelta then exit;
        end
      else
        if (Message.ScrollCode<>SB_EndScroll) then exit;
      FInternal:=0;
      InvalidateRect(Handle, nil, false);
      NotifyControls (CM_LMDSCROLLBOXSCROLLEVENT);
//      NotifyControls(CM_LMDBACKCHANGED)  //adding this will enable more than one level transp. but will start flicker as well!!
   end;
 // added by HUGO
 if FSaveResources then
    DestroyHandleForInvisibleControls;
 if (Assigned(FOnScroll)) and (ScrollDiff <> HorzScrollBar.Position) then FOnScroll(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.WMVScroll(var Message: TWMVScroll);
var
  ScrollDiff : integer; // added by HUGO
begin
  ScrollDiff := VertScrollBar.Position; // added by HUGO
  inherited;

  //these ScrollCodes occur never alone or are of no interest (scTrack)
//  if FOptScrollCodes and (Message.ScrollCode in [SB_TOP, SB_BOTTOM, SB_ENDSCROLL, Ord(scTrack)]) then exit;
  if CheckOptimized then
    begin
      if FInstantUpdate then
        begin
          Inc(FInternal);
          if (FInternal<FDelta) and not (Message.ScrollCode=SB_EndScroll) then exit;
        end
      else
        if (Message.ScrollCode<>SB_EndScroll) then exit;
      FInternal:=0;
      InvalidateRect(Handle, nil, false);
      NotifyControls (CM_LMDSCROLLBOXSCROLLEVENT);
//      NotifyControls(CM_LMDBACKCHANGED)  //adding this will enable more than one level transp. but will start flicker as well!!
    end;
    // added by HUGO
    if FSaveResources then
      DestroyHandleForInvisibleControls;
    if (assigned(FOnScroll)) and (ScrollDiff <> VertScrollBar.Position) then FOnScroll(self);
end;

{---------------------- Protected ---------------------------------------------}
function TLMDCustomScrollBox.CheckOptimized:Boolean;
begin
  result:=FTransparent and BackBitmapCheck;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    begin
      WindowClass.Style:=WindowClass.Style and not  (CS_HREDRAW or CS_VREDRAW);
      Style:=Style or WS_CLIPCHILDREN;
      if (Bevel.Mode=bmWindows) {and not UseXP} then
        begin
          if NewStyleControls and Ctl3D then
            ExStyle := ExStyle or WS_EX_CLIENTEDGE
          else
            Style := Style or WS_BORDER;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomScrollBox.CreateWnd;
begin
  inherited;
  //if IsThemed then InitializeFlatSB(Handle);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.GetChange(Sender:TObject);
begin
  if sender=Bevel then
    begin
      RecreateWnd;
      FBevel.SupportWindowsMode:=True;
    end
  else
    begin
      Perform(WM_NCPaint, 0,0);
      Invalidate;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomScrollBox.BeveledRect: TRect;
begin
  result:=ClientRect; //Bevel.ClientRect(GetClientRect); --> not correct here, Bevel is drawn in NC!!!
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty(IDS_CtlXP, ReadCtlXP, nil, false);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomScrollBox.DrawThemeBevel(aTheme: TLMDThemeMode; aCanvas: TCanvas; aRect: TRect): TRect;
var
  box : TThemedEdit;
  Rgn, ExRgn:HRgn;
  uEdge, uFlags: Cardinal;
  lDetails: TThemedElementDetails;
begin
  // limit drawing on the frame of control
  Rgn:=CreateRectRgn(0,0,Width,Height);
  SelectClipRgn(Canvas.Handle, Rgn);
  ExRgn:=CreateRectRgn(1,1,Width-1,Height-1);
  ExtSelectClipRgn(Canvas.Handle, ExRgn, RGN_DIFF);
  try
    box := teEditTextNormal;
    if Focused then box := teEditTextFocused;
    if not Enabled then box := teEditTextDisabled;
    if aTheme = ttmPlatform then
      LMDThemeServices.DrawElement(aTheme, Canvas.Handle, box, aRect);
    if aTheme = ttmNative then
    begin
      uEdge := 0;
      uFlags := BF_TOP + BF_BOTTOM + BF_LEFT + BF_RIGHT;
      LDetails := LMDThemeServices.GetDetails(teEdit, ord(box));
      LMDThemeServices.DrawThemeEdge(aTheme, aCanvas.Handle, teEdit, LDetails.Part, LDetails.State, aRect, uEdge, uFlags, nil);
    end;
    result := LMDThemeServices.ContentRect(aTheme, aCanvas.Handle, ThemeServices.GetElementDetails(box), aRect);
  finally
    SelectClipRgn(Canvas.Handle,0);
    DeleteObject(Rgn);
    DeleteObject(ExRgn);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.PaintBevel;
var
  lThemeMode : TLMDThemeMode;
begin
  // note: aRect <> ClientRect!!!!
  if [csLoading, csReading, csDestroying]*ComponentState<>[] then exit;

  lThemeMode := UseThemeMode;
  if (lThemeMode <> ttmNone) then
    DrawThemeBevel(lThemeMode, Canvas, Rect(0,0, Width, Height))
  else
    begin
      Canvas.Brush.Color:=Self.Color;
      {aRect:=}Bevel.PaintBevel(Canvas, Rect(0,0, Width, Height), false);
    end;

  exit; // drawing of inner frame of scrollbox does not work so far
  {if ScrollBarsVisible then
     begin
       if (Bevel.Mode=bmWindows) and ScrollBarsVisible then
         begin
           tmp:=1;
           if Ctl3D and not UseXP then Inc(tmp);

           aRect.Right:=aRect.Right-tmp;
           aRect.Bottom:=aRect.Bottom-tmp;
           aRect.Left:=aRect.Right-GetSystemMetrics(SM_CXVSCROLL);
           aRect.Top:=aRect.Bottom-GetSystemMetrics(SM_CYHSCROLL);
         end
       else
         if ScrollBarsVisible then
         begin
           // checken ob korrekt!
           aRect.Left:=aRect.Right-GetSystemMetrics(SM_CXVSCROLL);
           aRect.Top:=aRect.Bottom-GetSystemMetrics(SM_CYHSCROLL);
         end;

       if CheckOptimized then
         BackDrawArea(Canvas, aRect, Point(0,0)) //JH1
       else
         begin
           Canvas.Brush.Color:=Self.Color;
           Canvas.FillRect(aRect);
         end;
     end;}
end;

{------------------------------------------------------------------------------}
Procedure TLMDCustomScrollBox.Paint;
begin
  if Transparent and BackBitmapCheck then //added JH, 02-Oct-02
    BackDrawArea(Canvas, ClientRect, Point(0,0));
  if Assigned(FOnPaint) then FOnPaint(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.PaintWindow(DC: HDC);
begin
  if (csLoading in ComponentState) or (DC=0) then exit;
  FCanvas.Lock;
  try
    FCanvas.Handle:=DC;
    try
      Paint;
    finally
      FCanvas.Handle:=0;
    end;
  finally
    FCanvas.UnLock;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBox.DoThemeChanged;
begin
  // Delphi 2k7 fix
  if {Showing and} (ComponentState * [csLoading, csReading] = []) then
    begin
      ReCreateWnd;
      NotifyControls (CM_LMDTHEMECHANGED);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomScrollBox.UseThemeMode: TLMDThemeMode;
begin
  result := FThemeMode;
  if ParentThemeMode and Assigned(Parent) and IsPublishedProp(Parent, 'ThemeMode') then
    result := TLMDThemeMode(GetOrdProp(Parent, 'ThemeMode'))
  else
    if FThemeGlobalMode then
      result := LMDApplication.ThemeGlobalMode;
  result := LMDThemeServices.UseTheme(result);
end;

{------------------------------------------------------------------------------}
function TLMDCustomScrollBox.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDCustomScrollBox.Create(AOwner : TComponent);
begin
  inherited Create(aOwner);
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
                   csDoubleClicks, csReplicatable];

  //FFullRepaint:=True;
  FCanvas:=TControlCanvas.Create;
  TControlCanvas(FCanvas).Control:=Self;

  //so bleiben?
  inherited BorderStyle:=bsNone;

  FBevel:=TLMDScrollBoxBevel.Create;
  FBevel.OnChange:=GetChange;

  FInstantUpdate:=True;
  FDelta:=1;

  FOptScrollCodes := true;

  Ctl3D:=True;
  FParentThemeMode := true;
  FThemeMode := ttmPlatform;
  Width := 185;
  Height := 41;
  //RecreateWnd;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomScrollBox.Destroy;
begin
  FBevel.OnChange:=nil;
  FreeAndNil(FBevel);
  FreeAndNil(FCanvas);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDCustomScrollBox.BackBitmapCheck:Boolean;
begin
  result := LMDBackBitmapCheck (self);
end;

{------------------------------------------------------------------------------}
function TLMDCustomScrollBox.BackBitmap:TBitmap;
begin
  result := LMDBackBitmap (self);
end;

{------------------------------------------------------------------------------}
function TLMDCustomScrollBox.BackMapPoint(const aValue:TPoint):TPoint;
var
  tmp: Integer;
begin
  if BackBitmapCheck then
    begin
      result := LMDBackMapPoint (self, aValue);

      if Bevel.BevelExtend>0 then
        begin
          inc (result.x, Bevel.BevelExtend);
          inc (result.y, Bevel.BevelExtend);
        end
      else
        // this is some special behaviour, because
        // Bevel belongs here to NC area
        if (Bevel.Mode=bmWindows) then
          begin
            tmp:=1;
            if (not IsThemed) and Ctl3D then inc(tmp);
            inc (result.x, tmp);
            inc (result.y, tmp);
          end;
    end
  else
    result:=aValue;
end;

{------------------------------------------------------------------------------}
function TLMDCustomScrollBox.BackDrawArea(Canvas:TCanvas; const dest:TRect; const src:TPoint; flags:Word):Boolean;
var
  aRect : TRect;
begin
  result:=false;

  if (csLoading in ComponentState) or (csDestroying in ComponentState) then exit;

  if BackBitmap<>nil then
    begin
      aRect.TopLeft := BackMapPoint(Point (src.x, src.y));
      aRect:=Bounds(aRect.Left, aRect.Top, dest.Right-dest.Left, dest.Bottom-dest.Top);
      Canvas.CopyRect(dest, BackBitmap.Canvas, aRect);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomScrollBox.isTransparentSet: Boolean;
begin
  result := FTransparent;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomScrollBox.BackBitmapPalette: HPalette;
begin
  result := LMDBackBitmapPalette (self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomScrollBox.BackUpdate;
begin
  // repaint ourselves
  RePaint;
  // inform child controls
  LMDBackUpdate (self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomScrollBox.BackControl(index: Integer): TControl;
begin
  result := Controls[index];
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomScrollBox.BackControlCount: Integer;
begin
  result := ControlCount;
end;

{ ---------------------------------------------------------------------------- }
// added by Hugo : this is it!
procedure TLMDCustomScrollBox.DestroyHandleForInvisibleControls;
var
  x : integer;
  DummyRect : TRect;
  OldXPos, OldYPos : integer;  // keep to prevent 'scrollbar-jumps'
begin
   OldXPos := HorzScrollBar.position;
   OldYPos := VertScrollBar.position;

   { destroy all handles for invisible controls except the ones in view }
   for x := 0 to ControlCount-1 do
      // only one level: the destroyhandle automatically destroys childcontrol-handles
      // the current situation is that there are many panels with controls on it, so the loop
      // has about 40 iterations. If all controls are placed on the scrollbox, it would take
      // many more passes. Maybe some documentation should make sure this does not happen.
      if Controls[x] is TWinControl then   // modfied RM 28-Jan-2002
        if Intersectrect(DummyRect, Controls[x].Boundsrect, ClientRect) then // if false, there is no overlap and the control is completely invisible
           with TLMDResWinControl(Controls[x]) do
             begin
               if not HandleAllocated then // only recreate if it was destroyed.
                 begin
                   HandleNeeded; // get a handle
                   RecreateWnd; // recreate the window with the handle, otherwise it won't be
                              // displayed again
                 end;
             end
        else
         if TLMDResWinControl(Controls[x]).HandleAllocated then // only destroyhandle if not done before
           TLMDResWinControl(Controls[x]).FreeResources; // automatically includes childcontrols for this control.
           // Note that only the handle is destroyed, not the control itself (see Delphi-help) and all data is preserved

   // for a strange reason, the first time the scrollbar resets itself. This causes (sometimes) flicker,
   // but prevent sudden jumparounds (the source of these is yet unkown)
   if OldXPos <> HorzScrollBar.position then HorzScrollBar.position := OldXPos;
   if OldYPos <> VertScrollBar.position then VertScrollBar.position := OldYPos;

end;

// added by HUGO
{ ---------------------------------------------------------------------------- }
procedure TLMDCustomScrollBox.SetSaveResources(const Value: boolean);
begin
  FSaveResources := Value;
  if FSaveResources then
    DestroyHandleForInvisibleControls;
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C3.INC}
{$ENDIF}

end.
