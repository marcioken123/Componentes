{
//
// Components : TwwCustomRadioButton
//
// Copyright (c) 2001 by Woll2Woll Software
//
// 8/6/2001-  Support radiobuttons font settings.
// 9/19/2001- Radiobuttons in grid when dgAlwaysShowEditor is False and grid is still focused will have
//            their text painted black instead of the highlight text color. This corrects that problem. 
}
unit wwradiobutton;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, wwframe, grids, wwcommon, imglist;

{$i wwIfDef.pas}

type
  TwwWinButtonIndents=class(TPersistent)
  private
    FWinControl: TWinControl;
    FIndentBX: integer;
    FIndentBY: integer;
    FIndentTX: integer;
    FIndentTY: integer;
    procedure SetIndentBX(Value: integer);
    procedure SetIndentBY(Value: integer);
    procedure SetIndentTX(Value: integer);
    procedure SetIndentTY(Value: integer);
  protected
    procedure Repaint(FWinControl: TWinControl); virtual;
  public
    constructor Create(AOwner: TComponent);
    Procedure Assign(Source: TPersistent); override;
  published
    property ButtonX: integer read FIndentBX write SetIndentBX default 0;
    property ButtonY: integer read FIndentBY write SetIndentBY default 0;
    property TextX: integer read FIndentTX write SetIndentTX default 0;
    property TextY: integer read FIndentTY write SetIndentTY default 0;
  end;

  TwwTransparentRegion = (wwtrBorder, wwtrText, wwtrIcon);
  TwwTransparentRegions = Set of TwwTransparentRegion;
  TwwCustomRadioButton = class(TRadioButton)
  private
    FCanvas: TControlCanvas;
    FFrame: TwwEditFrame;
//    FIndentX: integer;
//    FIndentY: integer;
//    FIndentTextX: integer;
//    FIndentTextY: integer;
    FIndents: TwwWinButtonIndents;

    FAlwaysTransparent: boolean;
    FValueChecked: string;
    FValueUnchecked: string;
    FShowFocusRect: boolean;
    SpaceKeyPressed: boolean;
    FImages: TCustomImageList;
    FGlyphImages: TCustomImageList;
    FWordWrap: boolean;

    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;

    function isTransparentEffective: boolean;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure DrawItem(const DrawItemStruct: TDrawItemStruct); virtual;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure BMSetCheck(var Message: TMessage); message BM_SETCHECK;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;

    { Private declarations }
{    procedure SetIndentX(Value: integer);
    procedure SetIndentY(Value: integer);
    procedure SetIndentTextX(Value: integer);
    procedure SetIndentTextY(Value: integer);}
    Function IsMouseInControl: boolean;
  protected
    function GetShowText: boolean; virtual;
    procedure TransparentInvalidate(Regions: TwwTransparentRegions);
    function GetPaintCopyTextColor: TColor; virtual;
    function GetLastBrushColor: TColor; virtual;
    function GetButtonIndex: integer; virtual;
    Function GetEffectiveChecked: boolean; virtual;
    procedure CreateWnd; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; virtual;
    procedure PaintBorder;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure ComputeImageRect(var DrawRect: TRect); virtual;
    procedure ComputeTextRect(var DrawRect: TRect); virtual;
    procedure ComputeGlyphRect(var DrawRect: TRect); virtual;
    procedure Notification(AComponent: TComponent;
             Operation: TOperation); override;
    Function GetCanvas: TCanvas; virtual;
    procedure DoMouseEnter; virtual;
    procedure DoMouseLeave; virtual;
    procedure SetChecked(Value: Boolean); override;

//    procedure PaintButton; virtual;
    { Protected declarations }
  public
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
    property Canvas: TCanvas read GetCanvas;
    property Frame: TwwEditFrame read FFrame write FFrame;
  published
    property AlwaysTransparent: boolean read FAlwaysTransparent write FAlwaysTransparent;
    property Indents: TwwWinButtonIndents read FIndents write FIndents;
//    property IndentRadioButtonX: integer read FIndentX write SetIndentX;
//    property IndentRadioButtonY: integer read FIndentY write SetIndentY;
//    property IndentTextX: integer read FIndentTextX write SetIndentTextX;
//    property IndentTextY: integer read FIndentTextY write SetIndentTextY;
    property ValueChecked: string read FValueChecked write FValueChecked;
    property ValueUnchecked: string read FValueUnchecked write FValueUnchecked;
    property ShowFocusRect: boolean read FShowFocusRect write FShowFocusRect default true;
    property Images: TCustomImageList read FImages write FImages;
    property GlyphImages: TCustomImageList read FGlyphImages write FGlyphImages;

    property Action;
    property Alignment;
//    property AllowGrayed;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Checked;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
//    property State;
    property TabOrder;
    property TabStop;
    property Visible;
    property WordWrap: boolean read FWordWrap write FWordWrap default False;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnStartDock;
    property OnStartDrag;
    { Published declarations }
  end;

TwwRadioButton=class(TwwCustomRadioButton)
published
    property Action;
    property Alignment;
    property AlwaysTransparent;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Checked;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Frame;
    property Images;
    property Indents;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property ShowFocusRect;
    property TabOrder;
    property TabStop default False;
    property ValueChecked;
    property ValueUnchecked;
    property Visible;
    property WordWrap;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnStartDock;
    property OnStartDrag;
end;


implementation

uses
     {$ifdef wwDelphi7Up}
     themes,
     {$endif}
      wwradiogroup;

procedure TwwCustomRadioButton.CNDrawItem(var Message: TWMDrawItem);
begin
  DrawItem(Message.DrawItemStruct^);
end;

procedure TwwCustomRadioButton.WMPaint(var Message: TWMPaint);
  procedure CanvasNeeded;
  begin
    if FCanvas = nil then
    begin
      FCanvas := TControlCanvas.Create;
      FCanvas.Control := Self;
    end;
  end;
begin
  inherited;
  PaintBorder;

  if csPaintCopy in ControlState then
  begin
    CanvasNeeded;
    FCanvas.Handle := Message.dc;
    Paint;
    FCanvas.Handle := 0;
  end;
end;

procedure TwwCustomRadioButton.DrawItem(const DrawItemStruct: TDrawItemStruct);
  procedure CanvasNeeded;
  begin
    if FCanvas = nil then
    begin
      FCanvas := TControlCanvas.Create;
      FCanvas.Control := Self;
    end;
  end;
begin
  CanvasNeeded;
  FCanvas.Handle := DrawItemStruct.hDC;
  Paint;
  PaintBorder;
  FCanvas.Handle := 0;
end;

procedure TwwCustomRadioButton.WMEraseBkgnd(var Message: TWMEraseBkgnd);
var r: TRect;
begin
  if IsInwwObjectViewPaint(parent) or IsInwwGridPaint(parent) or
    ((IsTransparentEffective and (not Focused)) or AlwaysTransparent) then
  begin
     if not (csDesigning in ComponentState) then Message.result:= 1
     else inherited;
  end
  else if wwUseThemes(parent) then
  begin
    {$ifdef wwDelphi7Up}
    if (parent is TCustomGrid) then
    begin
       r:= ClientRect;
       if (FCanvas<>nil) then
       begin
          FCanvas.Brush.Color:= Color;
          Windows.FillRect(message.dc, r, FCanvas.brush.handle );
       end;
       message.result:=1
    end
    else begin
      { Get the parent to draw its background into the control's background. }
      ThemeServices.DrawParentBackground(Handle, Message.DC, nil, False);
      message.result:=1;
    end
    {$endif}
  end
  else inherited;

//  if Frame.enabled and not (csDesigning in ComponentState) then
//      message.result:=1
//   else inherited;
end;

procedure TwwCustomRadioButton.CreateParams(var Params: TCreateParams);
const
  Alignments: array[Boolean, TLeftRight] of DWORD =
    ((BS_LEFTTEXT, 0), (0, BS_LEFTTEXT));
begin
   inherited;
   CreateSubClass(Params, 'BUTTON');
   if IsTransparentEffective then
     Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT;  // For transparency
   with Params do begin
     Style:= Style and not BS_3STATE;
     Style := Style or BS_ownerdraw;
     WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
   end;
end;

Function TwwCustomRadioButton.GetEffectiveChecked: boolean;
begin
  result:= Checked;
end;

procedure TwwCustomRadioButton.CreateWnd;
  procedure DisableParentClipping;
  begin
     SetWindowLong(GetParent(Handle), GWL_STYLE,
      GetWindowLong(GetParent(Handle), GWL_STYLE) and not WS_CLIPCHILDREN);
  end;
begin
   inherited;
   if IsTransparentEffective then
   begin
     DisableParentClipping;
   end;
end;

destructor TwwCustomRadioButton.Destroy;
begin
   FIndents.Free;
   FCanvas.Free;
   FFrame.Free;
   inherited;
end;

procedure TwwCustomRadioButton.Paint;
var
    r: TRect;
    IsInGrid: boolean;
//    rg: TwwRadioGroup;
    {$ifdef wwDelphi7Up}
    function GetRadioButtonThemeStyle(Pressed: boolean): TThemedButton;
    begin
         if not Enabled then
         begin
            Result:= tbRadioButtonCheckedDisabled
         end
         else begin
            if GetEffectiveChecked then
            begin
              if Pressed then
//              if (DFCS_PUSHED and StateFlags <>0 ) then
                 Result:= tbRadioButtonCheckedPressed
              else begin
                 if IsMouseInControl and not (csPaintCopy in ControlState) then
                    Result:= tbRadioButtonCheckedHot
                 else
                    Result:= tbRadioButtonCheckedNormal
              end
            end
            else begin
              if Pressed  then
//              if (DFCS_PUSHED and StateFlags <> 0) then
                 Result:= tbRadioButtonUncheckedPressed
              else begin
                 if IsMouseInControl and not (csPaintCopy in ControlState) then
                   Result:= tbRadioButtonUncheckedHot
                 else
                   Result:= tbRadioButtonUncheckedNormal
              end
            end;
         end;
    end;
    {$endif}
  procedure PaintText;
  var ARect, FocusRect: TRect;
      Flags: integer;
      HaveText: boolean;
      DrawRect: TRect;
      Temp: integer;
      {$ifdef wwDelphi7Up}
      Details: TThemedElementDetails;
      CheckboxStyle: TThemedButton;
      {$endif}
  begin
    Canvas.Font.Assign(Font);  //8/6/2001-PYW Uncomment to support radiobuttons font settings.

    ComputeTextRect(ARect);

    // 6/29/02 - Bidi mode
    if UseRightToLeftAlignment then
    begin
       Temp:= ARect.Left;
       ARect.Left:= ClientWidth-ARect.Right;
       ARect.Right:= ClientWidth-Temp;
    end;

//    if (GlyphImages<>nil) and (GetButtonIndex<=GlyphImages.count-1) then
//       ARect.Left:= ARect.Left + TImageList(GlyphImages).Width+2;
    HaveText:= (Text<>'') and GetShowText;
    if Focused and ShowFocusRect and
       (HaveText or (GlyphImages<>nil)) and
       not (csPaintCopy in ControlState) then
    begin
      if HaveText then
        FocusRect:= Rect(ARect.Left - 2, ARect.Top - 2,
                     wwMin(ARect.Right+2, ARect.Left + Canvas.TextWidth(Caption) + 2),
                     ARect.Bottom + 2)
      else begin
        ComputeGlyphRect(DrawRect);
        FocusRect:= DrawRect;
      end;

      Canvas.Brush.Color := Color;
      Canvas.Font.Color := clBlack;
      Canvas.FrameRect(FocusRect);
      Canvas.Brush.Color := clWhite;
      Canvas.Font.Color := clBlack;
      Canvas.DrawFocusRect(FocusRect);
    end;

    if not HaveText then exit;

    SetBkMode(Canvas.Handle, TRANSPARENT);
    Flags:= 0;
    if WordWrap then flags:= flags or DT_EDITCONTROL or DT_WORDBREAK;

    InflateRect(ARect, 0, 2);
    ARect.Top:= ARect.Top + 2;
    Canvas.Font.Color:= Font.Color;

    //9/19/2001-Radiobuttons in grid when dgAlwaysShowEditor is False and grid is still focused will have
    //          their text painted black instead of the highlight text color. This corrects that problem. {PYW}
    if isinGrid and (parent.parent.focused) and not (csPaintCopy in ControlState) then
       Canvas.Font.Color := clHighlightText;

    if (GetPaintCopyTextColor<>clNone) then
       Canvas.Font.Color:= GetPaintCopyTextColor;

    if (not Focused) and IsTransparentEffective and
       (Frame.NonFocusTransparentFontColor<>clNone) then
        Canvas.Font.Color:= Frame.NonFocusTransparentFontColor
    // 4/15/01
    else if (not Focused) and (Frame.Enabled) and
            (Frame.NonFocusFontColor<>clNone) then
       Canvas.Font.Color:= Frame.NonFocusFontColor;

    if (not (parent.Enabled and Enabled)) and not wwUseThemes(parent) then
    begin
      OffsetRect(ARect, 1, 1);
      Canvas.Font.Color:= clBtnHighlight;
      DrawTextEx(Canvas.Handle, Pchar(caption), length(caption), ARect, Flags, nil);
      Canvas.Font.Color:= clGrayText;
      OffsetRect(ARect, -1, -1);
    end;
    
    if wwUseThemes(self.parent) then
    begin
      {$ifdef wwDelphi7Up}
      CheckboxStyle:= GetRadioButtonThemeStyle(False);
      Details := ThemeServices.GetElementDetails(CheckboxStyle);

      if Caption <> '' then
          ThemeServices.DrawText(Canvas.Handle, Details, Caption, ARect, DT_LEFT, 0);
      {$endif}
    end
    else
       DrawTextEx(Canvas.Handle, Pchar(caption), length(caption), ARect, Flags, nil);
  end;

  procedure PaintTextGlyph;
  var drawRect: TRect;
  begin
    if GlyphImages=nil then exit;

    ComputeGlyphRect(DrawRect);
    if (GlyphImages<>nil) and (GetButtonIndex<=GlyphImages.count-1) then begin
       FGlyphImages.Draw(Canvas, drawrect.left, drawrect.top, GetButtonIndex, True);
    end
  end;

  procedure PaintCheckbox;
  var
      DrawRect: TRect;
      StateFlags: integer;
      cp: TPoint;
      {$ifdef wwDelphi7Up}
      Details: TThemedElementDetails;
      CheckboxStyle: TThemedButton;
      {$endif}
      PaintRect: TRect;
  begin
    ComputeImageRect(DrawRect);

    // 6/29/02 - Bidi mode
    if UseRightToLeftAlignment then
    begin
       DrawRect.Right:= ClientWidth-DrawRect.Left;
       DrawRect.Left:= DrawRect.Right-13;
    end;

    StateFlags:= DFCS_BUTTONRADIO;
    if GetEffectiveChecked then
       StateFlags := StateFlags or DFCS_CHECKED;

    if (cslbuttondown in controlstate) and Focused and not (csPaintCopy in ControlState) then
    begin
        if IsInGrid then
        begin
           GetCursorPos(cp);
           cp:= ScreenToClient(cp);
           if PtInRect(Rect(DrawRect.Left-3, DrawRect.Top-3, DrawRect.Right+3, DrawRect.Bottom+3),cp) then
              StateFlags := StateFlags or DFCS_PUSHED;
        end
        else begin
            if IsMouseInControl then
              StateFlags := StateFlags or DFCS_PUSHED;
        end
    end;

    if SpaceKeyPressed and (GetKeyState(vk_space)<0) and Focused and not (csPaintCopy in ControlState) then
       StateFlags := StateFlags or DFCS_PUSHED;

    if GetEffectiveChecked then
    begin
       if (Images<>nil) and (Images.count>1) then begin
          FImages.Draw(Canvas, drawrect.left, drawrect.top, 1, True);
          exit;
       end
    end
    else begin
       if (Images<>nil) and (Images.count>0) then begin
          FImages.Draw(Canvas, drawrect.left, drawrect.top, 0, True);
          exit;
       end
    end;

    if not Enabled then StateFlags:= StateFlags + DFCS_INACTIVE;

    if wwUseThemes(self.parent) then
    begin
         {$ifdef wwDelphi7Up}
         CheckboxStyle:= GetRadioButtonThemeStyle((StateFlags and DFCS_PUSHED)<>0);
         Details := ThemeServices.GetElementDetails(CheckboxStyle);
         PaintRect := DrawRect;
         ThemeServices.DrawElement(Canvas.Handle, Details, PaintRect);
         PaintRect := ThemeServices.ContentRect(Canvas.Handle, Details, PaintRect);
         {$endif}
    end
    else begin
      with DrawRect do
         DrawFrameControl(Canvas.Handle, DrawRect,
             DFC_BUTTON, StateFlags);
    end
  end;

{  procedure PaintRadioButton;
  var
      DrawRect: TRect;
      StateFlags: integer;
  begin
    FCanvas.Brush.Color := clBtnShadow;

    StateFlags:= DFCS_BUTTONRADIO;

    if IsMouseInControl and Focused then
    begin
      if (cslbuttondown in controlstate) then
         StateFlags := StateFlags or DFCS_PUSHED;
    end;
    if SpaceKeyPressed and (GetKeyState(vk_space)<0) and Focused then
       StateFlags := StateFlags or DFCS_PUSHED;

//    if Checked then
    if GetEffectiveChecked then
       StateFlags := StateFlags or DFCS_CHECKED;

//    PaintButton;
    with DrawRect do
       DrawFrameControl(FCanvas.Handle, DrawRect,
           DFC_BUTTON, StateFlags);
  end;
}
  Function Max(x,y: integer): integer;
  begin
     if x>y then result:=x else result:=y
  end;

begin
//   IsInGrid:= False; //parent.parent is TCustomGrid;
   IsInGrid:= parent.parent is TCustomGrid;
   if(not IsTransparentEffective) or
     (not AlwaysTransparent) and (Focused) { or IsInGrid) }then
   begin
      if not (csPaintCopy in ControlState) then
      begin
        r:= ClientRect;

//        if not IsInGrid then
//           InflateRect(r, -2, -2);
        FCanvas.Brush.Color:= Color;
//        rg:= TwwRadioGroup(parent);

        if GetLastBrushColor<>clNone then
           FCanvas.Brush.Color:= GetLastBrushColor

        // 4/15/01 - Back-color support
        else if (not IsTransparentEffective) and
           (not Focused) and (Frame.NonFocusColor<>clNone) then
        begin
           FCanvas.Brush.Color:= Frame.NonFocusColor;
        end;
{        else if not rg.Focused and
           (rg.Frame.Enabled) and (not rg.Frame.Transparent) and
           (Frame.NonFocusColor=clNone) and (rg.Frame.NonFocusColor<>clNOne) then
           FCanvas.Brush.Color:= rg.Frame.NonFocusColor;
}
        if not wwUseThemes(self.parent) then
           FCanvas.FillRect(r);
      end
   end;

{
   RadioButtonSize:= 13;
   offset:= RadioButtonsize div 2;
   TempIndentX:= IndentRadioButtonX;
   if Frame.Enabled and
      (efLeftBorder in Frame.FocusBorders) then
   begin
      TempIndentX:= max(TempIndentX, 3);
   end;

   if Alignment = taRightJustify then
      pt.x:= offset + TempIndentX
   else
      pt.x:= Width - TempIndentX - RadioButtonsize;
   pt.y:= Height div 2;
}
(*     if (not (Frame.Enabled and Frame.Transparent)) or
       (not AlwaysTransparent) and (Focused) then
     begin
        if not (IsInGridPaint(self.parent)) then
        begin
          r:= ClientRect;
//          InflateRect(r, -2, -2); // Seems to cause glyph to not appear
          Canvas.Brush.Color:= Color;
          Canvas.FillRect(r);
        end
     end;
*)
   PaintCheckbox;
   PaintTextGlyph;
   PaintText;
end;

procedure TwwCustomRadioButton.ComputeImageRect(var DrawRect: TRect);
var offsetx, offsety: integer;
    checkboxSizeX, checkboxSizeY: integer;
    pt: TPoint;
    TempIndentCheckboxX: integer;
begin
   if (Images<>nil) and (Images.count>0) then
   begin
      checkboxSizeX:= Images.Width;
      checkboxSizeY:= Images.Height;
   end
   else begin
      checkboxSizex:= 13;
      checkboxSizey:= 13;
   end;

     offsetx:= checkboxsizex div 2;
     offsety:= checkboxsizey div 2;

     TempIndentCheckboxX:= Indents.ButtonX;
     if Frame.Enabled and
        (efLeftBorder in Frame.FocusBorders) then
     begin
        TempIndentCheckboxX:= wwmax(TempIndentCheckboxX, 1);
     end;

     if Alignment = taRightJustify then
        pt.x:= offsetx + TempIndentCheckboxX
     else
        pt.x:= ClientWidth - TempIndentCheckboxX - offsetx -2;
     pt.y:= Height div 2;

     DrawRect.Left:= pt.x - offsetx;
     DrawRect.Right:= pt.x + offsetx+1;
     DrawRect.Top:= pt.y-offsety+Indents.ButtonY;
     DrawRect.Bottom:= pt.y+offsety+1+Indents.ButtonY;

end;

procedure TwwCustomRadioButton.ComputeTextRect(var DrawRect: TRect);
var pt: TPoint;
    NewDrawRect: TRect;
    DrawFlags: integer;
begin
   ComputeImageRect(DrawRect);

   pt.y:= Height div 2;
   if Alignment = taRightJustify then
       NewDrawRect:= Rect(DrawRect.Right + 2 + Indents.TextX, 0,
                     Width, Height)
   else
      NewDrawRect:= Rect(Indents.TextX + 2, 0, DrawRect.Left, Height);
   DrawFlags:= 0;
   if WordWrap then
      DrawFlags:= DrawFlags or DT_EDITCONTROL or DT_WORDBREAK;
   if (GlyphImages<>nil) then
   begin
      NewDrawRect.Left:= NewDrawRect.Left + TImageList(GlyphImages).width +2;
   end;
   DrawTextEx(Canvas.Handle, PChar(Caption),
              Length(Caption), newdrawrect, DrawFlags or DT_CALCRECT, nil);
   DrawRect:= NewDrawRect;
   DrawRect.Top:= Indents.TextY + (ClientHeight -
                   (NewDrawRect.Bottom-NewDrawRect.Top)) div 2;
   DrawRect.Bottom:= DrawRect.Top + NewDrawRect.Bottom; //DrawRect.Bottom - (NewDrawRect.Bottom-NewDrawRect.Top) div 2;

end;

procedure TwwCustomRadioButton.ComputeGlyphRect(var DrawRect: TRect);
begin
   ComputeTextRect(DrawRect);
   if (GlyphImages<>nil) and (GetButtonIndex<=GlyphImages.count-1) then
   begin
      DrawRect.Right:= DrawRect.Left;
      DrawRect.Left:= DrawRect.Left - (TImageList(GlyphImages).Width+2);
   end;
   DrawRect.Top:= {Indents.GlyphY +} (ClientHeight-TImageList(GlyphImages).Height) div 2;
   DrawRect.Bottom:= DrawRect.Top +  TImageList(GlyphImages).Height;
end;

procedure TwwCustomRadioButton.WMLButtonDown(var Message: TWMLButtonDown);
var r: TRect;
    AnyClickToggles: boolean;
begin
   if (parent is TwwCustomRadioGroup) then
      AnyClickToggles:= TwwCustomRadioGroup(parent).AnyClickToggles
   else AnyClickToggles:= False;

   TabStop:= False;
   if (not IsInGrid(self.parent)) or (AnyClickToggles) then inherited
   else begin
      ComputeImageRect(r);
      InflateRect(r, 3, 3);
      if PtInRect(r, Point(Message.xpos,Message.ypos)) then
         inherited
      else
         if CanFocus then SetFocus;
   end
end;

procedure TwwCustomRadioButton.WMLButtonUp(var Message: TWMLButtonUp);
//var r: TRect;
begin
   inherited;

   // Problem of background
   // not getting cleared when click on radiobutton
//   if IsTransparentEffective then Parent.invalidate;

{   if not IsInGrid(self.parent) then SetChecked(not Checked)
   else begin
      ComputeGlyphRect(r);
      InflateRect(r, 3, 3);
      if PtInRect(r, Point(Message.xpos,Message.ypos)) then
         SetChecked(not Checked);
   end}
end;

procedure TwwCustomRadioButton.BMSetCheck(var Message: TMessage);
var origstyle: longint;
    r: Trect;
begin
   inherited;
   if IsTransparentEffective then
   begin
     OrigStyle:= Windows.GetWindowLong(Parent.handle, GWL_EXSTYLE);
     if (OrigStyle and WS_EX_TRANSPARENT)<>0 then
     begin
        if Focused and ShowFocusRect then
           TransparentInvalidate([wwtrText, wwtrIcon])
        else
           TransparentInvalidate([wwtrIcon]);
     end
     else begin
        r:= BoundsRect;
        InvalidateRect(Parent.handle, @r, True);
     end;
   end;

   invalidate;
end;

procedure TwwCustomRadioButton.PaintBorder;
begin
   if HandleAllocated then
   begin
     if not Frame.Enabled then exit;
     Frame.Ncpaint(Focused, AlwaysTransparent);
   end;
end;

procedure TwwCustomRadioButton.WMKillFocus(var Message: TWMKillFocus);
var r: TRect;
    OrigStyle: longint;
    Regions: TwwTransparentRegions;
begin
   inherited;

   if IsTransparentEffective then
   begin
     OrigStyle:= Windows.GetWindowLong(Parent.handle, GWL_EXSTYLE);
     if (OrigStyle and WS_EX_TRANSPARENT)<>0 then
     begin
        Regions:= [wwtrIcon];
        if ShowFocusRect then Regions:= Regions + [wwtrText];
        if Frame.IsFrameEffective then Regions:= Regions + [wwtrBorder];
        TransparentInvalidate(Regions);
     end
     else begin
        r:= BoundsRect;
        InvalidateRect(Parent.handle, @r, True);
     end;
   end;

   invalidate;
end;

procedure TwwCustomRadioButton.WMSetFocus(var Message: TWMSetFocus);
var r: TRect;
begin
   inherited;
   SpaceKeyPressed:=False;
   if IsTransparentEffective and AlwaysTransparent then
   begin
     r:= BoundsRect;
     InvalidateRect(Parent.handle, @r, False);
   end;
   invalidate;
end;

constructor TwwCustomRadioButton.Create(AOwner: TComponent);
begin
   inherited;
   FFrame:= TwwEditFrame.create(self);
//   FIndentX:=0;
//   FIndentY:=0;
   FIndents:= TwwWinButtonIndents.create(self);
   FValueChecked:= 'True';
   FValueUnchecked:= 'False';
   FShowFocusRect:= True;
   TabStop:= False;
end;

function TwwCustomRadioButton.isTransparentEffective: boolean;
begin
   result:= Frame.Transparent and Frame.IsFrameEffective
end;

{procedure TwwCustomRadioButton.SetIndentX(Value: integer);
begin
   FIndentX:= Value;
   invalidate;
end;

procedure TwwCustomRadioButton.SetIndentY(Value: integer);
begin
   FIndentY:= Value;
   invalidate;
end;
}
Function TwwCustomRadioButton.IsMouseInControl: boolean;
var p: TPoint;
    AHandle: HWND;
begin
  GetCursorPos(p);
  p:= ScreenToClient(p);
  p.x:= p.x + Left;
  p.y:= p.y + Top;
  AHandle := ChildWindowFromPoint(Parent.Handle, p);
  result:= FindControl(AHandle) = self;
end;

procedure TwwCustomRadioButton.WMMouseMove(var Message: TWMMouseMove);
begin
  inherited;
end;

procedure TwwCustomRadioButton.CMTextChanged(var Message: TMessage);
begin
  if IsTransparentEffective and
    ((not Focused) or AlwaysTransparent) then
     Frame.RefreshTransparentText(False, False);

  inherited;
end;

procedure TwwCustomRadioButton.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key=vk_space then SpaceKeyPressed:=False;
end;

procedure TwwCustomRadioButton.CNKeyDown(var Message: TWMKeyDown);
begin
  if not (csDesigning in ComponentState) then
  begin
    with Message do
       if (charcode = VK_SPACE) then SpaceKeyPressed:=True;
  end;

  inherited;
end;

procedure TwwCustomRadioButton.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = Images then Images := nil;
  end;
end;

procedure TwwCustomRadioButton.CNCommand(var Message: TWMCommand);
begin
  inherited;
  // Handle toggling ourselves instead of control
  // as when control is in inspector it does not work otherwise
  // Therefore we do not call inherited CNCommand
end;

Function TwwCustomRadioButton.GetCanvas: TCanvas;
begin
{   if Focused and (FPaintBitmap<>nil) then
      result:= FPaintCanvas
   else}
      result:= FCanvas;
end;

procedure TwwCustomRadioButton.DoMouseEnter;
begin
  try
     If Assigned( FOnMouseEnter ) Then FOnMouseEnter( self );
  except
    exit;
  end;
  if wwUseThemes(self.parent) then
  begin
     Invalidate;
  end;
  if Frame.IsFrameEffective and (not Focused) and
     Frame.MouseEnterSameAsFocus then
     wwDrawEdge(self, Frame, Canvas, True);
end;

procedure TwwCustomRadioButton.DoMouseLeave;
var
//    r: TRect;
//    OrigStyle: longint;
    Regions: TwwTransparentRegions;
begin
  try
    If Assigned( FOnMouseLeave ) Then FOnMouseLeave( self );
  except
    exit;
  end;
  if wwUseThemes(self.parent) then
  begin
     Invalidate;
  end;
  if Frame.IsFrameEffective and Frame.MouseEnterSameAsFocus then
  begin
     if Focused then exit;       //5/24/2001 - PYW - Don't invalidate if focused.
     Frame.RefreshTransparentText(False, False);
     Invalidate;
     if Frame.Transparent then begin
        Regions:= [wwtrBorder, wwtrIcon];
        TransparentInvalidate(Regions);
     end
  end;
end;

procedure TwwCustomRadioButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  DoMouseEnter;
end;

procedure TwwCustomRadioButton.CMMouseLeave(var Message: TMessage);
var r:TRect;
    pt:TPoint;
begin
  GetCursorPos(pt);
  pt := ScreenToClient(pt);
  r := ClientRect;
  if (PtInRect(r,pt)) then exit;

  inherited;
  DoMouseLeave;
end;

{procedure TwwCustomRadioButton.SetIndentTextX(Value: integer);
begin
   FIndentTextX:= Value;
   invalidate;
end;

procedure TwwCustomRadioButton.SetIndentTextY(Value: integer);
begin
   FIndentTextY:= Value;
   invalidate;
end;
}
procedure TwwWinButtonIndents.SetIndentBX(Value: integer);
begin
   FIndentBX:= Value;
   if FWinControl<>nil then Repaint(FWinControl);
end;

procedure TwwWinButtonIndents.SetIndentBY(Value: integer);
begin
   FIndentBY:= Value;
   if FWinControl<>nil then Repaint(FWinControl);
end;

procedure TwwWinButtonIndents.SetIndentTX(Value: integer);
begin
   FIndentTX:= Value;
   if FWinControl<>nil then Repaint(FWinControl);
end;

procedure TwwWinButtonIndents.SetIndentTY(Value: integer);
begin
   FIndentTY:= Value;
   if FWinControl<>nil then Repaint(FWinControl);
end;

procedure TwwWinButtonIndents.Repaint(FWinControl: TWinControl);
begin
   if FWinControl<>nil then FWinControl.Invalidate;
end;

constructor TwwWinButtonIndents.Create(AOwner: TComponent);
begin
   if AOwner is TWinControl then
      FWinControl:= TWinControl(AOwner)
end;

procedure TwwWinButtonIndents.Assign(Source: TPersistent);
begin
  if Source is TwwWinButtonIndents then with TwwWinButtonIndents(Source) do
  begin
     self.ButtonX:= ButtonX;
     self.ButtonY:= ButtonY;
     self.TextX:= TextX;
     self.TextY:= TextY;
  end
  else inherited Assign(Source);
end;

function TwwCustomRadioButton.GetButtonIndex: integer;
begin
   result:=0;
end;

function TwwCustomRadioButton.GetLastBrushColor: TColor;
begin
   result:= clNone;
end;

function TwwCustomRadioButton.GetPaintCopyTextColor: TColor;
begin
   result:= clNone;
end;

procedure TwwCustomRadioButton.TransparentInvalidate(Regions: TwwTransparentRegions);
var r,r2: TRect;
begin
   if not HandleAllocated then exit;

   if (wwtrText in Regions) then begin
     ComputeTextRect(r);
     MapWindowPoints(Handle, GetParent(Parent.Handle), r, 2);
     InflateRect(r,2,2);
     InvalidateRect(GetParent(Parent.handle), @r, False);
   end;

   if (wwtrIcon in Regions) and (Images<>nil) then begin
     ComputeImageRect(r);
     MapWindowPoints(Handle, GetParent(Parent.Handle), r, 2);
     InvalidateRect(GetParent(Parent.handle), @r, False);
   end;

   if (wwtrBorder in Regions) then
   begin
     r:= BoundsRect;
     r.Top:= r.Top + Parent.Top;
     r.Left:= r.Left + Parent.Left;
     r.Bottom:= r.Bottom + Parent.Top;
     r.Right:= r.Right + Parent.Left;
     r2:= Rect(r.left+2,r.top+2,r.right-2,r.bottom-2);
     ValidateRect(GetParent(Parent.handle),@r2);
     InvalidateRect(GetParent(Parent.handle), @r, False);
   end;

{   r:= BoundsRect;
   r.Top:= r.Top + Parent.Top;
   r.Left:= r.Left + Parent.Left;
   r.Bottom:= r.Bottom + Parent.Top;
   r.Right:= r.Right + Parent.Left;
   InvalidateRect(GetParent(Parent.handle), @r, False);
}
end;

function TwwCustomRadioButton.GetShowText: boolean;
begin
   result:= True;
end;

procedure TwwCustomRadioButton.SetChecked(Value: Boolean);
begin
   inherited;
   // inherited makes radiobutton a tabstop.
   // We do not wish to do this, as it causes problems when
   // tabbing away from radiogroup
   if (parent is TwwCustomRadioGroup) then TabStop:= False;
end;

end.
