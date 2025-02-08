unit LMDCustomScrollBoxExt;
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

LMDCustomScrollBoxExt unit
--------------------------

Changes
-------
Release 11.0 (October 2010)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Forms, Graphics, Controls, Messages, Classes, Themes, StdCtrls,
  intfLMDBackground, LMDBase, LMDClass, LMDBevel, LMDGraph, LMDTypes, LMDCustomScrollBox, LMDBackPanel, LMDSBar;


type
  TLMDCanScrollEvent = procedure(Sender: TObject; aControl: TControl; aDeltaX, aDeltaY: integer; var aCanScroll: boolean) of object;


type
  {--------------------- TLMDScrollBoxExt ----------------------------------------}
  TLMDCustomScrollBoxExt=class(TLMDBackPanel, ILMDBackground)
  private
    FBottomRightPanel: TLMDBackPanel;
    FCanvas          : TCanvas;
    FOptScrollCodes,
    FTransparent,
    FInstantUpdate,
    FFullRepaint   : Boolean;
    FDelta,
    FInternal      : Byte;
    FOnPaint       : TNotifyEvent;
    FOnScroll      : TNotifyEvent;
    FOnCanScroll   : TLMDCanScrollEvent;

    FSaveResources : Boolean;
    FFirstTimePaint : Boolean;

    FVScroll: TLMDScrollBar;
    FHScroll: TLMDScrollBar;

    FHScrollObj: TLMDScrollBarObject;
    FVScrollObj: TLMDScrollBarObject;

    FDx, FDy: integer;

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

    procedure DestroyHandleForInvisibleControls;
    procedure SetSaveResources(const Value: boolean);
    procedure SetScrollObj(const aIndex: Integer; const aValue: TLMDScrollBarObject);
  protected
    FScrollRange: TPoint;   //Maximal right (x) and bottom (y) coordinates of
                            //controls within ScrollBoxExt
    FScrollRect: TRect;     //ClientRect minus width/height of VScroll/HScroll if any
                            //Changed in UpdateScrollBars

    procedure AdjustVScrollRect(var aRect: TRect); virtual;
    procedure AdjustHScrollRect(var aRect: TRect); virtual;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure CalcScrollRange(var aMaxX: integer; var aMaxY: integer); virtual;
    procedure ScrollByEx(DeltaX, DeltaY: Integer; aRect: TRect); virtual;

    procedure DoCheckCanScroll(aControl: TControl; aDeltaX, aDeltaY: integer; var aCanScroll: boolean); virtual;

    procedure ScrollX(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer); virtual;
    procedure ScrollY(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer); virtual;

    function BeveledRect:TRect;
    //function  CheckOptimized:Boolean;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd;override;
    procedure GetChange(Sender:TObject); override;

    procedure Loaded; override;

    procedure DefineProperties(Filer: TFiler);override;
    procedure Paint; override;

    procedure DrawThemeBevel(aTheme: TLMDThemeMode; aCanvas: TCanvas; aRect: TRect); override;

    procedure PaintBevel;
    procedure PaintWindow(DC: HDC); override;

    procedure DoThemeChanged; override;
    function UseThemeMode: TLMDThemeMode;

    procedure CreateScrollBars; virtual;
    procedure UpdateVertScrollParams(aRect: TRect); virtual;
    procedure UpdateHorzScrollParams(aRect: TRect); virtual;
    procedure UpdateScrollBars(aPosOnly: boolean = false); virtual;

    function NeedHorzScrollBar: boolean; virtual;
    function NeedVertScrollBar: boolean; virtual;

    procedure Notification(AComponent: TComponent;Operation:TOperation);override;

    // Changed 6.1
    property CtlXP:Boolean read GetCtlXP write SetCtlXP default true;  // compatibility
    //***********

    property HScroll: TLMDScrollBar read FHScroll;
    property VScroll: TLMDScrollBar read FVScroll;

    procedure CreateBevel; override;
  public
    constructor Create(AOwner : TComponent);override;
    destructor Destroy; override;
    function IsThemed: Boolean; // any other than ttmNone
    // 7.0
    //function BackBitmapCheck:Boolean;override;
    //function BackBitmap:TBitmap;virtual;
    //function BackMapPoint(const aValue:TPoint):TPoint;virtual;
    //function BackDrawArea(Canvas:TCanvas; const dest:TRect; const src:TPoint; flags:Word=0):Boolean;virtual;
    //function isTransparentSet: Boolean;
    //function BackBitmapPalette: HPalette;
    //procedure BackUpdate;
    //function BackControl (index: Integer): TControl;
    //function BackControlCount: Integer;
    // --
    property Canvas: TCanvas read FCanvas;
    property InstantUpdate:Boolean read FInstantUpdate write FInstantUpdate default True;
    property Transparent:Boolean read FTransparent write SetTransparent default false;
    property UpdateDelta:Byte read FDelta write SetDelta default 1;
    property OnPaint:TNotifyEvent read FOnPaint write FOnPaint;
    //property MouseWheelSupport:Boolean read FMouseWheel write FMouseWheel default false;
    property OptScrollCodes : Boolean read FOptScrollCodes write FOptScrollCodes default true;
    //property ThemeMode:TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    //property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;

    property HorzScrollBar : TLMDScrollBarObject index 0 read FHScrollObj write SetScrollObj;
    property VertScrollBar : TLMDScrollBarObject index 1 read FVScrollObj write SetScrollObj;

    property SaveResources : boolean read FSaveResources write SetSaveResources default false;
  published
    //property About:TLMDAboutVar read FAbout write FAbout;
    property BorderStyle:TBorderStyle read GetBorderStyle;
    property Ctl3D default true;
    property ParentCtl3D default false;

    property FullRepaint:Boolean read FFullRepaint write FFullRepaint default false;

    property OnScroll : TNotifyEvent read FOnScroll write FOnScroll;
    property OnCanScroll : TLMDCanScrollEvent read FOnCanScroll write FOnCanScroll;
  end;

implementation

uses
  Types, TypInfo, SysUtils, CommCtrl, Math, LMDProcs,
  LMDCustomControl, LMDThemes, LMDResWinControl
  {$IFDEF LMD_DEBUGTRACE}, dialogs;{$I C2.INC}{$ELSE};{$ENDIF}

{*********************** TLMDCustomScrollBoxExt **********************************}
{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.SetDelta(aValue:Byte);
begin
  if (aValue<>FDelta) and (aValue>0) then
    begin
      FDelta:=aValue;
      FInternal:=0;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.SetTransparent(aValue:Boolean);
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
procedure TLMDCustomScrollBoxExt.SetCtlXP (aValue: Boolean);
begin
  if aValue <> GetCtlXP then
    ThemeMode := LMDCtlXP[aValue];
end;

{------------------------------------------------------------------------------}
function TLMDCustomScrollBoxExt.GetBorderStyle:TBorderStyle;
begin
  result:=bsNone;
end;

{------------------------------------------------------------------------------}
function TLMDCustomScrollBoxExt.ScrollBarsVisible: Boolean;
begin
  result := false;
  if not HandleAllocated then exit;
  result := FVScroll.Visible and FHScroll.Visible;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.ReadCtlXP(Reader: TReader);
begin
  SetCtlXP(Reader.ReadBoolean);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.CMColorChanged(var Message: TMessage);
begin
  inherited;
  if FTransparent or (csLoading in ComponentState) then exit;
  Invalidate;
  if ScrollBarsVisible then Perform(WM_NCPaint, 0,0);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.CMParentColorChanged(var Message: TMessage);
begin
  inherited;
  if FTransparent or (csLoading in ComponentState) then exit;
  Invalidate;
  if ScrollBarsVisible then Perform(WM_NCPaint, 0,0);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.CMDesignHitTest(var Message: TCMDesignHitTest);
var
  //HitIndex: Integer;
  HitTestInfo: TTCHitTestInfo;
begin
  HitTestInfo.pt:=SmallPointToPoint(Message.Pos);

  {HitIndex:=}SendMessage(Handle, TCM_HITTEST, 0, LPARAM(@HitTestInfo));

end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.WMThemeChanged(var Msg:TMessage);
begin
  inherited;
  {$IFDEF LMDCOMP11}if (csDesigning in ComponentState) then exit;{$ENDIF}
  DoThemeChanged;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomScrollBoxExt.WMNCCalcSize(var Message: TWMNCCalcSize);
var
  LDL, LDR, LDB, LDT: integer;
begin
  inherited;

  if IsThemed and Ctl3D then
  begin
    LDL := -1;
    LDT := -1;
    LDR := 1;
    LDB := 1;
  end
  else
  begin
    LDL := FBevel.BevelExtend;
    LDT := FBevel.BevelExtend;
    LDR := -FBevel.BevelExtendRight;
    LDB := -FBevel.BevelExtendRight;
  end;

  with Message.CalcSize_Params^ do
    rgrc[0]:=Rect(rgrc[0].Left + LDL, rgrc[0].Top + LDT, rgrc[0].Right + LDR, rgrc[0].Bottom + LDB);

  CalcScrollRange(FScrollRange.X, FScrollRange.Y);
  UpdateScrollBars;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  if csDesigning in ComponentState then
    if Message.Result in [HTNOWHERE, HTGROWBOX] then
    Message.Result:=HTClient;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (FBevel.Mode=bmWindows) then RecreateWnd;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.WMEraseBkGnd(var Message : TWMEraseBkGnd);
begin
  if CheckOptimized then
    begin
      Message.Result:=1;
      if ControlCount < 3 then PaintWindow(Message.DC);
    end
  else
    inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.WMMOVE(var Message: TWMMOVE);
begin
  inherited;
  if CheckOptimized then BackUpdate;
  UpdateScrollBars(true);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.WMPaint(var Message: TWMPaint);
begin
  inherited;
  {if CheckOptimized then
    if ControlCount=0 then PaintWindow(Message.DC);}

  // added by HUGO to destroy handles when loading is complete
  // probably there is a better location to do this, but it must be
  // done AFTER the first paint, otherwise windows will automatically
  // recreate the handle when first painting...
  if not (FFirstTimePaint) then
    begin
      FFirstTimePaint := true;
      if Assigned(FVScroll) then
      begin
        FVScroll.ThemeMode := ttmNone;
        FVScroll.ThemeMode := Self.ThemeMode;
      end;
      if Assigned(FVScroll) then
      begin
        FHScroll.ThemeMode := ttmNone;
        FHScroll.ThemeMode := Self.ThemeMode;
      end;
      if (FVScroll.ThemeMode <> ttmNone) then
      begin
        VScroll.Bevel.Mode := bmStandard;
        VScroll.Bevel.StandardStyle := lsNone;
      end;
      if (FHScroll.ThemeMode <> ttmNone) then
      begin
        HScroll.Bevel.Mode := bmStandard;
        HScroll.Bevel.StandardStyle := lsNone;
      end;
      UpdateScrollBars;
      // RM !
      if FSaveResources then
        DestroyHandleForInvisibleControls;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.WMNCPaint(var Msg: TWMNCPaint);
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
procedure TLMDCustomScrollBoxExt.WMSIZE(var Message: TWMSIZE);
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

  UpdateScrollBars;
end;

{---------------------- Protected ---------------------------------------------}
{function TLMDCustomScrollBoxExt.CheckOptimized:Boolean;
begin
  result:=FTransparent and BackBitmapCheck;
end;}

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.CreateParams(var Params: TCreateParams);
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
procedure TLMDCustomScrollBoxExt.CreateWnd;
begin
  inherited;
  //if IsThemed then InitializeFlatSB(Handle);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.GetChange(Sender:TObject);
begin
  inherited GetChange (Sender);

  if Sender = FHScrollObj then
    if Assigned(Self.FHScroll) then
      begin
        FHScrollObj.AssignToScrollBar (FHScroll);
        FHScroll.Repaint;
      end;
  if Sender = FVScrollObj then
    if Assigned(Self.FVScroll) then
      begin
        FVScrollObj.AssignToScrollBar (FVScroll);
        FVScroll.Repaint;
      end;

 {if sender=Bevel then
    begin
      RecreateWnd;
      FBevel.SupportWindowsMode:=True;
    end
  else
    begin
      Perform(WM_NCPaint, 0,0);
      Invalidate;
    end;  }
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomScrollBoxExt.BeveledRect: TRect;
begin
  result:=ClientRect; //Bevel.ClientRect(GetClientRect); --> not correct here, Bevel is drawn in NC!!!
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.CreateScrollBars;

  procedure CreateVScroll;
  begin
    FVScroll := TLMDScrollBar.Create (self);
    FVScroll.Parent := Self;
    FVScroll.CanBeFocused := false;
    FVScroll.Kind := LMDSBar.skVertical;
    FVScroll.Width := 17;
    FVScroll.Min := 0;
    FVScroll.Max := 0;
    FVScroll.ThumbMode := tmAuto;
    FVScroll.OnScroll := ScrollY;
    FVScroll.Bevel.Mode := bmStandard;
    FVScroll.Bevel.StandardStyle := lsNone;
    FVScrollObj.AssignToScrollBar (FVScroll);
    FVScroll.Visible := false;
  end;

  procedure CreateHScroll;
  begin
    FHScroll := TLMDScrollBar.Create (self);
    FHScroll.Parent := Self;
    FHScroll.CanBeFocused := false;
    FHScroll.ThumbMode := tmAuto;
    FHScroll.Kind := LMDSBar.skHorizontal;
    FHScroll.OnScroll := ScrollX;
    FHScroll.Min := 0;
    FHScroll.Max := 0;
    FHScroll.Height := 17;
    FVScroll.Bevel.Mode := bmStandard;
    FHScroll.Bevel.StandardStyle := lsNone;
    FHScrollObj.AssignToScrollBar (FHScroll);
    FHScroll.Visible := false;
  end;

begin
  if (FVScroll = nil) then
    CreateVScroll;
  if (FHScroll = nil) then
    CreateHScroll;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty(IDS_CtlXP, ReadCtlXP, nil, false);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomScrollBoxExt.DrawThemeBevel(aTheme: TLMDThemeMode; aCanvas: TCanvas; aRect: TRect);
var
  box : TThemedEdit;
  Rgn, ExRgn:HRgn;
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
    LMDThemeServices.DrawElement(aTheme, Canvas.Handle, box, aRect);
    LMDThemeServices.ContentRect(aTheme, Canvas.Handle, ThemeServices.GetElementDetails(box), aRect);
  finally
    SelectClipRgn(Canvas.Handle,0);
    DeleteObject(Rgn);
    DeleteObject(ExRgn);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.PaintBevel;
var
  lThemeMode : TLMDThemeMode;
begin
  // note: aRect <> ClientRect!!!!
  if [csLoading, csReading, csDestroying]*ComponentState<>[] then
    exit;

  lThemeMode := UseThemeMode;
  if (lThemeMode <> ttmNone) then
    DrawThemeBevel(lThemeMode, Canvas, Rect(0,0, Width, Height))
  else
    begin
      Canvas.Brush.Color:=Self.Color;
      Bevel.PaintBevel(Canvas, Rect(0,0, Width, Height), false);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.Paint;
begin
  if Transparent and BackBitmapCheck then //added JH, 02-Oct-02
    BackDrawArea(Canvas, ClientRect, Point(0,0));
  if Assigned(FOnPaint) then FOnPaint(self);
end;


{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.PaintWindow(DC: HDC);
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
procedure TLMDCustomScrollBoxExt.DoThemeChanged;
begin
  // Delphi 2k7 fix
  if {Showing and} (ComponentState * [csLoading, csReading] = []) then
    begin
      ReCreateWnd;
      NotifyControls (CM_LMDTHEMECHANGED);
    end;
  HandleNeeded;
  if Assigned(FVScroll) then
  begin
    FVScroll.ThemeMode := ttmNone;
    FVScroll.ThemeMode := Self.ThemeMode;
  end;
  if Assigned(FHScroll) then
  begin
    FHScroll.ThemeMode := ttmNone;
    FHScroll.ThemeMode := Self.ThemeMode;
  end;
  UpdateScrollBars;
end;


procedure TLMDCustomScrollBoxExt.UpdateScrollBars(aPosOnly: boolean);
var
  aRect: TRect;
begin
  FScrollRect := ClientRect;
  if Assigned(FVScroll) and (ClientWidth > FVScroll.Width + GetBevel.BevelExtend - 1) then
  begin
    FVScroll.BeginUpdate;
    FVScroll.Left := ClientWidth - FVScroll.Width - GetBevel.BevelExtend + 1;
    FVScroll.Top := GetBevel.BevelExtend - 1;

    if not aPosOnly then
    begin
      with FVScroll do
        aRect := Rect(Left, Top, Left + Width, Top + Height);

      aRect.Bottom := aRect.Top + ClientHeight - GetBevel.BevelExtend * 2 + 2;
      if (FHScroll <> nil) and (FHScroll.Visible) then
        aRect.Bottom := aRect.Bottom - FHScroll.Height;

      AdjustVScrollRect(aRect);
      UpdateVertScrollParams(aRect);

      FScrollRect.Right := FScrollRect.Right - FVScroll.Width;
      FVScroll.Visible := NeedVertScrollBar;

      if FVScroll.Visible then
      begin
        //FVScroll.Repaint
        FVScroll.BringToFront;
      end
      else
        ScrollByEx(0, -FDy, FScrollRect);
    end;
    FVScroll.EndUpdate(True);
  end;

  if Assigned(FHScroll) and (ClientHeight > FHScroll.Height + GetBevel.BevelExtend - 1) then
  begin
    FHScroll.BeginUpdate;
    FHScroll.Left := Bevel.BevelExtend - 1;
    FHScroll.Top := ClientHeight - FHScroll.Height - GetBevel.BevelExtend + 1;

    with FHScroll do
      aRect := Rect(Left, Top, Left + Width, Top + Height);


    if not aPosOnly then
    begin
      aRect.Right := aRect.Left + ClientWidth - GetBevel.BevelExtend * 2 + 2;
      if (FVScroll <> nil) and (FVScroll.Visible) then
        aRect.Right := aRect.Right - FVScroll.Width;

      AdjustHScrollRect(aRect);
      UpdateHorzScrollParams(aRect);
      FScrollRect.Bottom := FScrollRect.Bottom - FHScroll.Height;
      FHScroll.Visible := NeedHorzScrollBar;

      if FHScroll.Visible then
      begin
        //FHScroll.Repaint
        FHScroll.BringToFront;
      end
      else
        ScrollByEx(-FDx, 0, FScrollRect);
    end;
    FHScroll.EndUpdate(True);
  end;

  if Assigned(FHScroll) and Assigned(FVScroll) and FHScroll.Visible and FVScroll.Visible then
  begin
    if FBottomRightPanel = nil then
    begin
      FBottomRightPanel := TLMDBackPanel.Create(nil);
      FBottomRightPanel.Parent := Self;
      FBottomRightPanel.ParentBackground := true;
      FBottomRightPanel.Color := Color;
      FBottomRightPanel.Visible := false;
    end;
    if not FBottomRightPanel.Visible then
      FBottomRightPanel.Visible := true;
    FBottomRightPanel.SetBounds(FScrollRect.Right + 1, FScrollRect.Bottom + 1, FVScroll.Width, FHScroll.Height);
    FBottomRightPanel.BringToFront;
  end
  else
    FreeAndNil(FBottomRightPanel);
end;

{------------------------------------------------------------------------------}
function TLMDCustomScrollBoxExt.UseThemeMode: TLMDThemeMode;
begin
  result := FThemeMode;
  if ParentThemeMode and Assigned(Parent) and IsPublishedProp(Parent, 'ThemeMode') then
    result := TLMDThemeMode(GetOrdProp(Parent, 'ThemeMode'))
  else
    if ThemeGlobalMode then
      result := LMDApplication.ThemeGlobalMode;
  result := LMDThemeServices.UseTheme(result);
end;

{------------------------------------------------------------------------------}
function TLMDCustomScrollBoxExt.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDCustomScrollBoxExt.Create(AOwner : TComponent);
begin
  inherited Create(aOwner);

  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
                   csDoubleClicks, csReplicatable];

  //FFullRepaint:=True;
  FCanvas:=TControlCanvas.Create;
  TControlCanvas(FCanvas).Control:=Self;

  FBevel.OnChange:=GetChange;

  FInstantUpdate:=True;
  FDelta:=1;

  FOptScrollCodes := true;

  Ctl3D:=True;
  FThemeMode := ttmPlatform;
  Width := 185;
  Height := 41;

  FVScrollObj := TLMDScrollBarObject.Create;
  FVScrollObj.OnChange := GetChange;
  FHScrollObj := TLMDScrollBarObject.Create;
  FHScrollObj.OnChange := GetChange;
  FFirstTimePaint := false;

  FDx := 0;
  FDy := 0;

  CreateScrollBars;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomScrollBoxExt.CreateBevel;
begin
  FBevel:=TLMDScrollBoxBevel.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomScrollBoxExt.Destroy;
begin
  FBevel.OnChange:=nil;
  FreeAndNil(FBevel);
  FreeAndNil(FCanvas);
  FreeAndNil(FVScroll);
  FreeAndNil(FHScroll);
  FHScrollObj.OnChange := nil;
  FreeAndNil(FHScrollObj);
  FVScrollObj.OnChange := nil;
  FreeAndNil(FVScrollObj);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomScrollBoxExt.DestroyHandleForInvisibleControls;
var
  i : integer;
  DummyRect : TRect;
begin
   { destroy all handles for invisible controls except the ones in view }
   for i := 0 to ControlCount-1 do
      // only one level: the destroyhandle automatically destroys childcontrol-handles
      // the current situation is that there are many panels with controls on it, so the loop
      // has about 40 iterations. If all controls are placed on the scrollbox, it would take
      // many more passes. Maybe some documentation should make sure this does not happen.
      if (Controls[i] is TWinControl) and (Controls[i] <> FHScroll) and
        (Controls[i] <> FVScroll) and (Controls[i] <> FBottomRightPanel) then
        if InterSectRect(DummyRect, Controls[i].Boundsrect, ClientRect) then // if false, there is no overlap and the control is completely invisible
           with TLMDResWinControl(Controls[i]) do
             begin
               if not HandleAllocated then // only recreate if it was destroyed.
                 begin
                   HandleNeeded; // get a handle
                   RecreateWnd; // recreate the window with the handle, otherwise it won't be
                              // displayed again
                 end;
             end
        else
          if TLMDResWinControl(Controls[i]).HandleAllocated then // only destroyhandle if not done before
            TLMDResWinControl(Controls[i]).FreeResources; // automatically includes childcontrols for this control.
           // Note that only the handle is destroyed, not the control itself (see Delphi-help) and all data is preserved
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomScrollBoxExt.SetSaveResources(const Value: boolean);
begin
  FSaveResources := Value;
  if FSaveResources then
    DestroyHandleForInvisibleControls;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomScrollBoxExt.ScrollX(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
var
  ScrollDiff : integer;
begin
  ScrollDiff := FHScroll.Position;

  case ScrollCode of
    scLineUp:     begin ScrollByEx(HScroll.SmallChange,0,FScrollRect);  end;
    scLineDown:   begin ScrollByEx(-HScroll.SmallChange,0,FScrollRect); end;
    scPageUp:     begin ScrollByEx(HScroll.LargeChange,0,FScrollRect); end;
    scPageDown:   begin ScrollByEx(-HScroll.LargeChange,0,FScrollRect);end;
    scPosition:   begin ScrollByEx(-HScroll.Delta,0,FScrollRect);end;
  end;

  if CheckOptimized then
    begin
      if FInstantUpdate then
        begin
          Inc(FInternal);
          if FInternal<FDelta then exit;
        end
      else
        if (ScrollCode<>scEndScroll) then exit;
      FInternal:=0;
      InvalidateRect(Handle, nil, false);
      NotifyControls (CM_LMDSCROLLBOXSCROLLEVENT);
   end;

 if FSaveResources then
    DestroyHandleForInvisibleControls;
 if (Assigned(FOnScroll)) and (ScrollDiff <> FHScroll.Position)
   then FOnScroll(self);
end;

procedure TLMDCustomScrollBoxExt.ScrollY(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
var
  ScrollDiff : integer;
begin
  ScrollDiff := FVScroll.Position;

  case ScrollCode of
    scLineUp:     begin ScrollByEx(0, FVScroll.SmallChange, FScrollRect);  end;
    scLineDown:   begin ScrollByEx(0, -FVScroll.SmallChange, FScrollRect); end;
    scPageUp:     begin ScrollByEx(0, FVScroll.LargeChange, FScrollRect);  end;
    scPageDown:   begin ScrollByEx(0, -FVScroll.LargeChange, FScrollRect); end;
    scPosition:   begin ScrollByEx(0, -VScroll.Delta,FScrollRect); end;
  end;

  //these ScrollCodes occur never alone or are of no interest (scTrack)
  //if FOptScrollCodes and (Message.ScrollCode in [SB_TOP, SB_BOTTOM, SB_ENDSCROLL, Ord(scTrack)]) then exit;
  if CheckOptimized then
    begin
      if FInstantUpdate then
        begin
          Inc(FInternal);
          if (FInternal<FDelta) and not (ScrollCode=scEndScroll) then exit;
        end
      else
        if (ScrollCode<>scEndScroll) then exit;
      FInternal:=0;
      InvalidateRect(Handle, nil, false);
      NotifyControls (CM_LMDSCROLLBOXSCROLLEVENT);
      //NotifyControls(CM_LMDBACKCHANGED)  //adding this will enable more than one level transp. but will start flicker as well!!
    end;

    if FSaveResources then
      DestroyHandleForInvisibleControls;
    if (assigned(FOnScroll)) and (ScrollDiff <> FVScroll.Position) then
      FOnScroll(self);

end;


procedure TLMDCustomScrollBoxExt.Loaded;
begin
  inherited;
  FVScroll.ThemeMode := Self.ThemeMode;
  FHScroll.ThemeMode := Self.ThemeMode;
end;

procedure TLMDCustomScrollBoxExt.AlignControls(AControl: TControl;
  var Rect: TRect);
begin
  inherited AlignControls (AControl,Rect);
  CalcScrollRange(FScrollRange.X, FScrollRange.Y);
end;


{ ---------------------------------------------------------------------------- }
procedure TLMDCustomScrollBoxExt.SetScrollObj (const aIndex: Integer; const aValue: TLMDScrollBarObject);
begin
  case aIndex of
    0 : begin
          FHScrollObj.Assign(aValue);
          if FHScroll <> nil then
            begin
              FHScrollObj.AssignToScrollBar(FHScroll);
              FHScroll.Repaint;
            end;
        end;
    1 : begin
          FVScrollObj.Assign (aValue);
          if FVScroll <> nil then
            begin
              FVScrollObj.AssignToScrollBar(FVScroll);
              FVScroll.Repaint;
            end;
        end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomScrollBoxExt.CalcScrollRange(var aMaxX: integer; var aMaxY: integer);
var
  i: Integer;
  LHRange, LVRange: integer;
begin
  lhrange := 0;
  lvrange := 0;
  for i := 0 to ControlCount - 1 do
  begin
    if (Controls[i] <> FVScroll) and (Controls[i] <> FHScroll) and (Controls[i] <> FBottomRightPanel) then
    begin
      lhrange := Max(lhrange, Controls[i].Left + Controls[i].Width + max(Controls[i].Width div 2, 10));
      lvrange := Max(lvrange, Controls[i].Top + Controls[i].Height + max(Controls[i].Height div 2, 10));
    end;
  end;
  aMaxX := lhrange;
  aMaxY := lvrange;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomScrollBoxExt.ScrollByEx(DeltaX, DeltaY: Integer; aRect: TRect);
var
  I: Integer;
  Control: TControl;
  LCanScroll: boolean;
begin
  if Visible then
  begin
    for I := 0 to ControlCount - 1 do
    begin
      DoCheckCanScroll(Controls[i], DeltaX, DeltaY, LCanScroll);
      if LCanScroll then
      begin
        Control := Controls[I];
        if not (Control is TWinControl) or (TWinControl(Control).Handle = 0) then
        begin
          Control.Left := Control.Left + DeltaX;
          Control.Top := Control.Top + DeltaY;
        end
        else
        with TWinControl(Control) do
          SetWindowPos(Handle, 0, Left + DeltaX, Top + DeltaY, Width, Height, SWP_NOZORDER + SWP_NOACTIVATE);
      end;
    end;
    FDx := FDx + DeltaX;
    FDy := FDy + DeltaY;
    Realign;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomScrollBoxExt.NeedHorzScrollBar: boolean;
begin
  result := (FScrollRange.X > ClientWidth);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomScrollBoxExt.NeedVertScrollBar: boolean;
begin
  result := (FScrollRange.Y > ClientHeight);
end;

procedure TLMDCustomScrollBoxExt.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
{  if Assigned(FBottomRightPanel) and FBottomRightPanel.Visible then
    FBottomRightPanel.BringToFront;
  if Assigned(FHScroll) and FHScroll.Visible then
    FHScroll.BringToFront;
  if Assigned(FVScroll) and FVScroll.Visible then
    FVScroll.BringToFront;}
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomScrollBoxExt.AdjustVScrollRect(var aRect: TRect);
begin
//do nothing here
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomScrollBoxExt.AdjustHScrollRect(var aRect: TRect);
begin
//do nothing here
end;

procedure TLMDCustomScrollBoxExt.DoCheckCanScroll(aControl: TControl; aDeltaX, aDeltaY: integer; var aCanScroll: boolean);
begin
  aCanScroll := true;
  if(aControl = FHScroll) or (aControl = FVScroll) or (aControl = FBottomRightPanel) then
    aCanScroll := false
  else
    if Assigned(FOnCanScroll) then
      FOnCanScroll(Self, aControl, aDeltaX, aDeltaY, aCanScroll);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomScrollBoxExt.UpdateHorzScrollParams;
begin
  //FHScroll.BeginUpdate;
  FHScroll.SetBounds(aRect.Left, aRect.Top, aRect.Right - aRect.Left, aRect.Bottom - aRect.Top);
  FHScroll.CalcPaintRect;
  FHScroll.CalcTrackLength;
  FHScroll.SmallChange := max(1, FHScroll.TrackLength div 50);
  FHScroll.LargeChange := max(1, FHScroll.TrackLength div 10);
  with FHScroll do
    if TrackLength > 0 then
      Max := Muldiv(FScrollRange.X - TrackLength, TrackLength, FScrollRange.X);
  //FHScroll.EndUpdate(True);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomScrollBoxExt.UpdateVertScrollParams(aRect: TRect);
begin
  //FVScroll.BeginUpdate;
  FVScroll.SetBounds(aRect.Left, aRect.Top, aRect.Right - aRect.Left, aRect.Bottom - aRect.Top);
  FVScroll.CalcPaintRect;
  FVScroll.CalcTrackLength;
  FVScroll.SmallChange := max(1, FVScroll.TrackLength div 50);
  FVScroll.LargeChange := max(1, FVScroll.TrackLength div 10);
  with FVScroll do
    if TrackLength > 0 then
      Max := Muldiv(FScrollRange.Y - TrackLength, TrackLength, FScrollRange.Y);
  //FVScroll.EndUpdate(True);
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C3.INC}
{$ENDIF}

end.
