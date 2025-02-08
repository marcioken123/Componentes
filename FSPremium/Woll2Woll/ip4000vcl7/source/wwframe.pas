{
// Components : Framing Object defines how borders are drawn in InfoPower edit controls.
//
// Copyright (c) 1996-2001 by Woll2Woll Software
//
// 11/22/99 - Fix problem where far left pixels are not cleared
// 6/9/2000 - PYW - Correct problem where editrect is 1 pixel too large when RightBorder is showing for FrameBox.
// 7/31/01 - In certain cases the displayrect is larger than the editrect so need to fill larger rect.
//
}
unit wwframe;
{$i wwIfDef.pas}
interface


uses classes, Windows, controls, stdctrls, graphics, forms, Messages, typinfo;

type
  TwwComboButtonStyle = (cbsEllipsis, cbsDownArrow, cbsCustom);

  TwwButtonEffects = class(TPersistent)
  private
     FTransparent: boolean;
     FFlat: boolean;
     procedure SetTransparent(val: boolean);
     procedure SetFlat(val: boolean);
  protected
     Procedure Refresh; virtual;
  public
     Control: TControl;
     Button: TControl;
     constructor Create(Owner: TComponent; AButton: TControl);
     class Function Get(Control: TControl): TwwButtonEffects;
  published
     property Transparent: boolean read FTransparent write SetTransparent default false;
     property Flat: boolean read FFlat write SetFlat default false;
  end;

  TwwEditFocusStyle = (efsFrameBox, efsFrameSunken, efsFrameRaised, efsFrameEtched,
                       efsFrameBump, efsFrameSingle);
  TwwEditFrameEnabledType = (efLeftBorder, efTopBorder, efRightBorder, efBottomBorder);
  TwwEditFrameEnabledSet = set of TwwEditFrameEnabledType;
  TwwEditFrame = class(TPersistent)
  private
    Control: TWinControl;
    FEnabled: boolean;
    FNonFocusBorders: TwwEditFrameEnabledSet;
    FFocusBorders: TwwEditFrameEnabledSet;
    FFocusStyle: TwwEditFocusStyle;
    FNonFocusStyle: TwwEditFocusStyle;
    FNonFocusTextOffsetX: integer;
    FNonFocusTextOffsetY: integer;
    FTransparent: boolean;
    FTransparentClearsBackground: boolean;
    FMouseEnterSameAsFocus:boolean;
    FAutoSizeHeightAdjust: integer;
    FNonFocusTransparentFontColor: TColor;
    FNonFocusColor: TColor;
    FNonFocusFontColor: TColor;
    procedure SetFocusBorders(val: TwwEditFrameEnabledSet);
    procedure SetNonFocusBorders(val: TwwEditFrameEnabledSet);
    procedure SetNonFocusStyle(val: TwwEditFocusStyle);
    procedure SetEnabled(val: boolean);
    procedure SetTransparent(val: boolean);
    procedure CheckParentClipping;
//    procedure AdjustEditRect;
  public
    CreateTransparent: boolean;
    function NCPaint(FFocused: boolean; AlwaysTransparent: boolean = False;
      adc: HDC=0): integer;
    function IsSingleBorderStyle(Style: TwwEditFocusStyle): boolean;
    constructor Create(Owner: TComponent);
    procedure GetEditRectForFrame(var Loc: TRect);
    procedure RefreshTransparentText(InvalidateBorders: boolean=False;
         UseEditRect: boolean = True; Exiting: boolean = False);
    procedure RefreshControl;
    procedure AdjustHeight;
    Function IsFrameEffective: boolean;
    procedure GetFrameTextPosition(
       var Left, Indent: integer;
       Focused: boolean = False); virtual;
    class Function Get(Control: TControl): TwwEditFrame;

    Procedure Assign(Source: TPersistent); override;
    procedure AssignAll(Source: TPersistent; SkipOptimize : boolean = True);

    property TransparentClearsBackground: boolean
       read FTransparentClearsBackground write FTransparentClearsBackground default False;
  published
    property Enabled: boolean read FEnabled write SetEnabled default False;
    property Transparent: boolean read FTransparent write SetTransparent default False;
    property AutoSizeHeightAdjust: integer read FAutoSizeHeightAdjust write FAutoSizeHeightAdjust default 0;
    property FocusBorders : TwwEditFrameEnabledSet read FFocusBorders write SetFocusBorders
       default [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder];
    property NonFocusBorders : TwwEditFrameEnabledSet read FNonFocusBorders write SetNonFocusBorders
             default [efBottomBorder];
    property FocusStyle: TwwEditFocusStyle read FFocusStyle write FFocusStyle default efsFrameBox;
    property NonFocusStyle: TwwEditFocusStyle read FNonFocusStyle write SetNonFocusStyle default efsFrameBox;
    property NonFocusTextOffsetX: integer read FNonFocusTextOffsetX write FNonFocusTextOffsetX default 0;
    property NonFocusTextOffsetY: integer read FNonFocusTextOffsetY write FNonFocusTextOffsetY default 0;

            // Obsolete
    property NonFocusTransparentFontColor: TColor read FNonFocusTransparentFontColor write FNonFocusTransparentFontColor default clNone;
    property NonFocusColor: TColor read FNonFocusColor write FNonFocusColor default clNone;
    property NonFocusFontColor: TColor read FNonFocusFontColor write FNonFocusFontColor default clNone;
    property MouseEnterSameAsFocus: boolean
       read FMouseEnterSameAsFocus write FMouseEnterSameAsFocus default False;
  end;


procedure wwInvalidateTransparentArea2(control : TControl; Exiting: boolean;
  TransparentClearsBackground: boolean);
procedure wwInvalidateTransparentArea(control : TControl; Exiting: boolean);

procedure wwDrawEdge(
     Control: TWinControl;
     Frame: TwwEditFrame;
     DC: HDC;
     Focused: boolean); overload;

procedure wwDrawEdge(
     Control: TWinControl;
     Frame: TwwEditFrame;
     Canvas: TCanvas;
     Focused: boolean); overload;

function wwIsTransparentParent(control : TControl): boolean;

implementation

uses wwcommon, grids;

function wwIsTransparentParent(control : TControl): boolean;
var OrigStyle: longint;
    pc: TControl;
begin
   result:= false;
   pc:= control;

   // If parent is not transparent then just return
   if (pc.parent is TWinControl) and
      TWinControl(pc.parent).HandleAllocated then
   begin
      OrigStyle:= Windows.GetWindowLong(TWinControl(pc.parent).handle, GWL_EXSTYLE);
      result:= (OrigStyle and WS_EX_TRANSPARENT)<>0;
   end;
end;

constructor TwwEditFrame.Create(Owner: TComponent);
begin
   inherited Create;
   Enabled:= false;
   FNonFocusBorders:= [efBottomBorder];
   FFocusBorders:= [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder];
   if Owner is TWinControl then
     control:= TWinControl(Owner)
   else
     control:= nil;
   FFocusStyle := efsFrameBox;
   FNonFocusStyle:= efsFrameBox;
   FNonFocusTextOffsetX:=0;
   FNonFocusTextOffsetX:=0;
   FNonFocusTransparentFontColor:= clNone;
   FNonFocusColor:= clNone;
   FNonFocusFontcolor:= clNone;
   FMouseEnterSameAsFocus := False;
end;

procedure TwwEditFrame.SetNonFocusBorders(val: TwwEditFrameEnabledSet);
begin
   FNonFocusBorders:= val;
   if control is TCustomEdit then
   begin
      RefreshControl;
   end
//   control.invalidate;
end;

procedure TwwEditFrame.SetFocusBorders(val: TwwEditFrameEnabledSet);
begin
   FFocusBorders:= val;
   if control is TCustomEdit then
   begin
      control.invalidate;
   end
end;

procedure TwwEditFrame.SetNonFocusStyle(val: TwwEditFocusStyle);
begin
   if val<>FNonFocusStyle then
   begin
      FNonFocusStyle:= val;
      if control is TCustomEdit then
      begin
         control.invalidate;
      end
   end
end;

procedure TwwEditFrame.SetEnabled(val: boolean);
   Function wwGetAutoSize(ctrl: TControl): boolean;
   var PropInfo: PPropInfo;
   begin
      Result:= False;
      PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'AutoSize');
      if PropInfo<>Nil then result:= Boolean(GetOrdProp(Ctrl, PropInfo));
   end;

begin
   if val<>FEnabled then
   begin
      FEnabled:= val;
      if control is TCustomEdit then
      begin
         if val then wwSetBorder(control, False);
         if wwGetAutoSize(control) then AdjustHeight;
         control.invalidate;
      end
   end
end;


procedure wwDrawEdge(
     Control: TWinControl;
     Frame: TwwEditFrame;
     Canvas: TCanvas;
     Focused: boolean);
var cr: TRect;
//    StateFlags: Word;
    Flags: integer;
    focusStyle: TwwEditFocusStyle;
begin
   cr:= Control.ClientRect;
   if Focused then begin
      if not (efRightBorder in Frame.FocusBorders) and
         frame.transparent then cr.right:= cr.right-2;
      flags:= 0;
      if efLeftBorder in Frame.FocusBorders then flags:= flags + bf_left;
      if efBottomBorder in Frame.FocusBorders then flags:= flags + bf_bottom;
      if efTopBorder in Frame.FocusBorders then flags:= flags + bf_top;
      if efRightBorder in Frame.FocusBorders then flags:= flags + bf_right;
      focusStyle:= Frame.FocusStyle;

   end
   else begin
      if not (efRightBorder in Frame.NonFocusBorders) and
         frame.transparent then cr.right:= cr.right-2;
      flags:= 0;
      if efLeftBorder in Frame.NonFocusBorders then flags:= flags + bf_left;
      if efBottomBorder in Frame.NonFocusBorders then flags:= flags + bf_bottom;
      if efTopBorder in Frame.NonFocusBorders then flags:= flags + bf_top;
      if efRightBorder in Frame.NonFocusBorders then flags:= flags + bf_right;
      focusStyle:= Frame.NonFocusStyle;
   end;

      if (FocusStyle=efsFrameSingle) then
      begin
        DrawEdge(Canvas.Handle, cr, BDR_SUNKENOUTER, flags or bf_mono );
      end
      else if (FocusStyle=efsFrameBox) then
      begin
        DrawEdge(Canvas.Handle, cr, EDGE_SUNKEN, flags or bf_mono);
      end
      else if (FocusStyle=efsFrameSunken) then
      begin
        DrawEdge(Canvas.Handle, cr, EDGE_SUNKEN, flags);
      end
      else if (FocusStyle=efsFrameRaised) then
      begin
        DrawEdge(Canvas.Handle, cr, EDGE_RAISED, flags);
      end
      else if (FocusStyle=efsFrameEtched) then
      begin
        DrawEdge(Canvas.Handle, cr, EDGE_ETCHED, flags);
      end
      else if (FocusStyle=efsFrameBump) then
      begin
         DrawEdge(Canvas.Handle, cr, EDGE_BUMP, flags);
      end;

end;

procedure TwwEditFrame.CheckParentClipping;
var OldStyle:  longint;
begin
   if FTransparent and IsFrameEffective and (Control<>nil) and 
      not (csDesigning in Control.ComponentState) then
   begin
      if Control.HandleAllocated then
      begin
         OldStyle:= GetWindowLong(Control.Parent.Handle, GWL_STYLE);
         if OldStyle and (NOT WS_CLIPCHILDREN)<>OldStyle then
         begin
            SendMessage(Control.Handle, CM_RECREATEWND, 0, 0);
         end
      end
   end
end;

procedure TwwEditFrame.SetTransparent(val: boolean);
begin
   if val<>FTransparent then
   begin
     CreateTransparent:= val;
     FTransparent:= val;
     CheckParentClipping;
   end;

   if (Control<>nil) and Control.HandleAllocated and
      wwIsClass(Control.ClassType, 'TwwCustomRichEdit') and (Control<>nil) then
   begin
     SendMessage(control.handle, cm_recreatewnd, 0, 0);
   end;;


end;

procedure TwwEditFrame.RefreshTransparentText(InvalidateBorders: boolean=False;
   UseEditRect: boolean = True; Exiting: boolean = False);
var r,tempeditrect:TRect;
    dc: HDC;
    brush: HBRUSH;
begin
   r:= Control.BoundsRect;
   if not InvalidateBorders then
   begin
     SendMessage(Control.handle,em_getrect, 0, Integer(@tempeditrect));
     if not useEditRect then begin
       InflateRect(r,-2,-2);
       if not (efLeftBorder in nonFocusBorders) then dec(r.Left,2);
       r.bottom:= r.bottom + 2;
     end
     else if (TEdit(Control).BorderStyle=bsNone) then
     begin
       InflateRect(r,-2,-2);
       if not (efLeftBorder in nonFocusBorders) then dec(r.Left,2);

       // Allows controls with buttons to erase text on right edge
       if (TwwButtonEffects.Get(Control)<>nil) and
          (abs(tempEditRect.Right-r.right)>8) then
       begin
          r.Right := r.Left+tempeditrect.Right+3;
       end
       else r.Right := r.Left+tempeditrect.Right+1;
     end
   end;

   { If imager not in background, then need to explicitly clear background }
   if wwIsTransparentParent(Control){ or True }then
      wwInvalidateTransparentArea(Control, Exiting)
   else if (Control.Parent.ControlAtPos(  Point(Control.Left, Control.Top), True)=nil) then
   begin
      DC := GetDC(Control.Handle);
      brush:= 0;
      try
        brush:= CreateSolidBrush(ColorToRGB(TEdit(Control.parent).color));
        SelectObject(DC, brush);
        if not InvalidateBorders then
        begin
          InflateRect(tempEditRect, 1, 1);
          { 11/22/99 - Fix problem where far left pixels are not cleared }
          if not (efLeftBorder in nonFocusBorders) then
          begin
             dec(tempEditRect.Left,1);
             if tempEditRect.Left<0 then tempEditRect.left:= 0;
          end;
          // 7/31/01 - In certain cases the displayrect is larger than the editrect so need to fill larger rect.
          r:= Control.ClientRect;
          if r.bottom-tempEditRect.Bottom>=4 then
             tempEditRect.Bottom:= tempEditRect.bottom + 2;
          Windows.FillRect(DC, tempEditRect, brush);
        end
        else begin
          r:= Control.ClientRect;
          Windows.FillRect(DC, r, brush);
        end;
      finally
        ReleaseDC(Control.Handle, DC);
        DeleteObject(brush);
      end
   end
   else
//      wwInvalidateTransparentArea(Control)
      InvalidateRect(Control.parent.handle, @r, TransparentClearsBackground);

end;

procedure TwwEditFrame.RefreshControl;
var r:TRect;
begin
//   AdjustEditRect;
   r:= Control.BoundsRect;
   if Enabled and Transparent then
      InvalidateRect(Control.parent.handle, @r, false)
   else Control.Invalidate;
end;

{procedure TwwEditFrame.AdjustEditRect;
var TempEditRect:TRect;
begin
   if not Control.HandleAllocated then exit;
   SendMessage(Control.handle,em_getrect, 0, Integer(@TempEditRect));
   GetEditRectForFrame(TempEditRect);
   SendMessage(Control.Handle, EM_SETRECTNP, 0, LongInt(@TempEditRect));
end;
}

function TwwEditFrame.IsSingleBorderStyle(Style: TwwEditFocusStyle): boolean;
begin
  result:= Style in [efsFrameBox, efsFrameSingle];
end;

procedure TwwEditFrame.GetEditRectForFrame(var Loc: TRect);
begin
     if IsSingleBorderStyle(FocusStyle) then
//     if (FocusStyle = efsFrameBox) then
     begin
        Loc.Top := 2;
        Loc.Left := 2;
        //6/9/2000 - PYW - Correct problem where editrect is 1 pixel too large when RightBorder is showing for FrameBox.
        if (efRightBorder in FocusBorders) and (FocusStyle = efsFrameBox) then
          Loc.Right:= Loc.Right - 1
     end
     else begin
        Loc.Top := 3;
        if efLeftBorder in FocusBorders then
        begin
           if FocusStyle in [efsFrameSunken, efsFrameBump] then
              Loc.Left := 3
           else Loc.Left:= 2;
        end
        else Loc.Left:=1;

        Loc.Right:= Loc.Right -2
     end
end;

procedure TwwEditFrame.AdjustHeight;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, TEdit(Control).Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  if NewStyleControls then
  begin
    if TEdit(Control).Ctl3D then I := 8 else I := 6;
    I := GetSystemMetrics(SM_CYBORDER) * I;
    if TEdit(Control).BorderStyle=bsNone  then i:= 6;
    if self.enabled then i:= i + AutoSizeHeightAdjust;;
  end else
  begin
    I := SysMetrics.tmHeight;
    if I > Metrics.tmHeight then I := Metrics.tmHeight;
    I := I div 4 + GetSystemMetrics(SM_CYBORDER) * 4;
  end;
  Control.Height := Metrics.tmHeight + I;
end;

{Function GetBooleanProp(control: TControl; PropertyName: string): boolean;
var PropInfo: PPropInfo;
begin
   Result:= False;
   PropInfo:= Typinfo.GetPropInfo(Control.ClassInfo, PropertyName);
   if PropInfo<>Nil then
      result:= Boolean(GetOrdProp(Control, PropInfo));
end;
}
procedure SetBooleanProp(control: TControl; PropertyName: string; val: boolean);
var PropInfo: PPropInfo;
begin
   PropInfo:= Typinfo.GetPropInfo(Control.ClassInfo, PropertyName);
   if PropInfo<>Nil then
      SetOrdProp(control, PropInfo, ord(val));
end;

procedure TwwButtonEffects.SetTransparent(val: boolean);
begin
   if FTransparent<>val then
   begin
      FTransparent:= val;
      SetBooleanProp(Button, 'Transparent', FFlat or FTransparent);
      SetBooleanProp(Button, 'Flat', FFlat or FTransparent);
      Refresh;  //      FButton.Glyph.Handle:= LoadComboGlyph;
      Button.Invalidate;
   end;
end;

procedure TwwButtonEffects.SetFlat(val: boolean);
begin
   if FFlat<>val then
   begin
      FFlat:= val;
      SetBooleanProp(Button, 'Flat', FFlat or FTransparent);
      Refresh;  //      FButton.Glyph.Handle:= LoadComboGlyph;
      Button.Invalidate;
   end;
end;

constructor TwwButtonEffects.Create(Owner: TComponent; AButton: TControl);
begin
   inherited Create;
   button:= TControl(AButton);
   control:= TControl(Owner);
end;

Procedure TwwButtonEffects.Refresh;
begin
end;

class Function TwwEditFrame.Get(Control: TControl): TwwEditFrame;
var PropInfo: PPropInfo;
begin
   Result:= Nil;
   PropInfo:= Typinfo.GetPropInfo(Control.ClassInfo,'Frame');
   if PropInfo<>Nil then
      result:= TwwEditFrame(GetOrdProp(Control, PropInfo));
end;

class Function TwwButtonEffects.Get(Control: TControl): TwwButtonEffects;
var PropInfo: PPropInfo;
begin
   Result:= Nil;
   PropInfo:= Typinfo.GetPropInfo(Control.ClassInfo,'ButtonEffects');
   if PropInfo<>Nil then
      result:= TwwButtonEffects(GetOrdProp(Control, PropInfo));
end;

Function TwwEditFrame.IsFrameEffective: boolean;
begin
   result:= enabled and (control<>nil) and not (control.parent is TCustomGrid);
end;

procedure TwwEditFrame.Assign(Source: TPersistent);
//var s: TwwEditFrame;
begin
  if Source is TwwEditFrame then
  begin
     AssignAll(Source, False);
  end
  else inherited Assign(Source);
end;

procedure TwwEditFrame.AssignAll(Source: TPersistent; SkipOptimize : boolean = True);
var s: TwwEditFrame;
begin
  if Source is TwwEditFrame then
  begin
     s:= TwwEditFrame(source);
     Enabled:= s.Enabled;
     Transparent:= s.Transparent;
     if (not SkipOptimize) and (not Enabled) then exit; {Optimization }
     TransparentClearsBackground:= s.TransparentClearsBackground;
     MouseEnterSameAsFocus:= s.FMouseEnterSameAsFocus;
     AutoSizeHeightAdjust:= s.AutoSizeHeightAdjust;
     FocusBorders:= s.FocusBorders;
     NonFocusBorders:= s.NonFocusBorders;
     FocusStyle:= s.FocusStyle;
     NonFocusStyle:= s.NonFocusStyle;
     NonFocusTextOffsetX:= s.NonFocusTextOffsetX;
     NonFocusTextOffsetY:= s.NonFocusTextOffsetY;
     NonFocusTransparentFontColor:= s.NonFocusTransparentFontColor;
     NonFocusColor:= s.NonFocusColor;
     NonFocusFontColor:= s.NonFocusFontColor;
  end
end;

procedure TwwEditFrame.GetFrameTextPosition(
   var Left, Indent: integer;
   Focused: boolean = False);
var Borders: TwwEditFrameEnabledSet;
    FrameStyle: TwwEditFocusStyle;
begin
   if Focused then
   begin
      Borders:= FocusBorders;
      FrameStyle:= FocusStyle;
   end
   else begin
      Borders:= NonFocusBorders;
      FrameStyle:= NonFocusStyle;
   end;

   Left:= 1;
   if (efLeftBorder in Borders) then begin
//      if FrameStyle=efsFrameBox then Left:= 2
      if IsSingleBorderStyle(FrameStyle) then Left:= 2
      else Left:= 3;
   end;

   Indent:= 2;
   if (efTopBorder in Borders) and
      (not IsSingleBorderStyle(FrameStyle)) then
//      (FrameStyle<>efsFrameBox) then
      Indent:= Indent + 1;

   Left:= Left + NonFocusTextOffsetX;
   Indent:= Indent + NonFocusTextOffsetY;
end;

procedure wwDrawEdge(
     Control: TWinControl;
     Frame: TwwEditFrame;
     DC: HDC;
     Focused: boolean);
var cr: TRect;
    Flags: integer;
    focusStyle: TwwEditFocusStyle;
begin
   cr:= Control.ClientRect;
   cr.right:= Control.Width;
   cr.bottom:= Control.height;
//   inflaterect(cr, -1, -1);
   if Focused then begin
      if not (efRightBorder in Frame.FocusBorders) and
         frame.transparent then cr.right:= cr.right-2;
      flags:= 0;
      if efLeftBorder in Frame.FocusBorders then flags:= flags + bf_left;
      if efBottomBorder in Frame.FocusBorders then flags:= flags + bf_bottom;
      if efTopBorder in Frame.FocusBorders then flags:= flags + bf_top;
      if efRightBorder in Frame.FocusBorders then flags:= flags + bf_right;
      focusStyle:= Frame.FocusStyle;

   end
   else begin
      if not (efRightBorder in Frame.NonFocusBorders) and
         frame.transparent then cr.right:= cr.right-2;
      flags:= 0;
      if efLeftBorder in Frame.NonFocusBorders then flags:= flags + bf_left;
      if efBottomBorder in Frame.NonFocusBorders then flags:= flags + bf_bottom;
      if efTopBorder in Frame.NonFocusBorders then flags:= flags + bf_top;
      if efRightBorder in Frame.NonFocusBorders then flags:= flags + bf_right;
      focusStyle:= Frame.NonFocusStyle;
   end;

   if flags = 0 then exit;  // No need to paint - generates CodeWatch error if call DrawEdge with no edges

      if (FocusStyle=efsFrameSingle) then
      begin
        DrawEdge(dc, cr, BDR_SUNKENOUTER, flags or bf_mono );
      end
      else if (FocusStyle=efsFrameBox) then
      begin
        DrawEdge(dc, cr, EDGE_SUNKEN, flags or bf_mono);
      end
      else if (FocusStyle=efsFrameSunken) then
      begin
        DrawEdge(dc, cr, EDGE_SUNKEN, flags);
      end
      else if (FocusStyle=efsFrameRaised) then
      begin
        DrawEdge(dc, cr, EDGE_RAISED, flags);
      end
      else if (FocusStyle=efsFrameEtched) then
      begin
        DrawEdge(dc, cr, EDGE_ETCHED, flags);
      end
      else if (FocusStyle=efsFrameBump) then
      begin
         DrawEdge(dc, cr, EDGE_BUMP, flags);
      end;

end;


function TwwEditFrame.NCPaint(FFocused: boolean; AlwaysTransparent: boolean = False;
   adc: HDC=0): integer;
var dc: HDC;
    R: TRect;
//    i: integer;
//    SI: TScrollInfo;
    brush: HBrush;
    SpecialControl: boolean;
begin
   dc:= adc;
   result:= 1;
   if IsFrameEffective then
   begin
      try
        if dc=0 then dc:= GetWindowDC(Control.Handle);
        SpecialControl:= wwIsClass(Control.ClassType, 'TwwCheckBox') or
                         wwIsClass(Control.ClassType, 'TwwRadioButton');

        if not SpecialControl and
           ((not Transparent) or (FFocused and not AlwaysTransparent)) then
        begin
          brush:= CreateSolidBrush(ColorToRGB(TEdit(Control).Color));
          try
            SelectObject(DC, brush);
            r:= Rect(0, 0, Control.Width, Control.Height);
            Windows.FrameRect(dc, r, brush);
            r:= Rect(1, 1, Control.Width-1, Control.Height-1);
            Windows.FrameRect(dc, r, brush);
          finally
            DeleteObject(Brush);
          end
        end;
        wwDrawEdge(Control, self, dc, FFocused);
      finally
        if adc=0 then releaseDc(Control.Handle, dc)
      end;
      result:= 0; //message.result:= 0;
   end
end;

procedure wwInvalidateTransparentArea2(control : TControl; Exiting: boolean;
   TransparentClearsBackground: boolean);
var r: TRect;
   pc, oldpc: TControl;
   pt: TPoint;
   clearBackground: boolean;
begin
  { Draws any image in the background }
   with Control do  r:= Rect(Left, Top, Left+Width, Top+Height);
   r:= Control.ClientRect;
   pc:= control;
   if pc.parent=nil then exit;

   // If parent is not transparent then just return
//   if not fcIsTransparentParent(control) then exit;
   pc:= Control;
   While (pc.parent<>nil) do begin
     oldpc:= pc;
     pc:= pc.Parent;
     pt:= Point(0,0);
     // Don't invalidate area outside of control
     if Control.Left<0 then pt.x:= pt.x - Control.Left;
     if Control.Top<0 then pt.y:= pt.y - Control.Top;

     pt:= Control.ClientToScreen(pt);
     ScreenToClient(TWinControl(pc).handle, pt);
     r:= Rect(pt.X, pt.y, pt.x+Control.Width, pt.y+Control.Height);

     // Don't invalidate area outside of control
     if Control.Left<0 then r.Right:= r.Right - Control.Left;
     if Control.Top<0 then r.Top:= r.Top - Control.Top;

{     if wwIsClass(control.classtype, 'TwwNavButton') and
        (wwIsTransparentParent(oldpc)) then clearBackground:=false
     else }
     clearBackground:= TransparentClearsBackground;

     InvalidateRect(TWinControl(pc).handle, @r, ClearBackground);
     if not wwIsTransparentParent(oldpc) then exit;

      // Code seems to serve no useful purpose, but
      // it makes TwwComboBox droppedown paint wrong and not invalidate itself
(*     if not wwIsTransparentParent(pc) then
     begin
        if Exiting and (pc.parent<>nil) then pc.parent.update;
                   // Complete painting as background imager is not painted sometimes otherwise
                   // Later may need to only do this code in cmexit, instead of also
                   // in cmTextChanged
        break;
     end;
*)
(*     if pc is TCustomForm then begin
        pc.update; // Complete painting as background imager is not painted sometimes otherwise
                   // Later may need to only do this code in cmexit, instead of also
                   // in cmTextChanged
//        Application.ProcessMessages;
        break;
     end;
*)
   end;
end;

procedure wwInvalidateTransparentArea(control : TControl; Exiting: boolean);
var frame: TwwEditFrame;
    clearBackground: boolean;
begin
   Frame:= TwwEditFrame.Get(Control);

   if ((Frame<>Nil) and Frame.TransparentClearsBackground) then
      ClearBackground:=True
   else clearBackground:= false;

   wwInvalidateTransparentArea2(control, Exiting, clearBackground);
end;

end.
