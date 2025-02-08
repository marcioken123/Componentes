unit LMDCustomCheckBox;
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

LMDCustomCheckBox unit (RM)
---------------------------
Extended CheckBox control.

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Messages, Controls, Graphics, StdCtrls,
  LMD3DCaption, LMDGlyphTextLayout, LMDGraph, LMDButtonControl;

type
  {----------------------- TLMDCustomCheckBox ---------------------------------}
  TLMDCustomCheckBox = class(TLMDButtonControl)
  private
    FAllowGrayed : Boolean;
    FState       : TCheckBoxState;
    FIntNumGlyphs, //internal number of glyphs, JH March 2002
    FNumGlyphs   : Byte;

    procedure SetBool(index : integer;aValue : Boolean);
    procedure SetNumGlyphs(aValue:Byte);
    procedure SetState (aValue : TCheckBoxState);
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    function  GetNumGlyphs: Byte; //JH March 2002
  protected
    procedure DoFlatChanged; override;
    procedure CreateStandardGlyph;override;
    function  GetChecked:Boolean;override;
    procedure SetChecked(aValue:Boolean);override;
    procedure Click; override;
    procedure DoEnter; override;
    procedure CreateGlyph; override;
    function  GetGlyphNumber : Integer;
    function  GetThemedTextColor: TColor;
    procedure DrawFace(aCanvas: TCanvas; const aString:String;
                       Effects:TLMD3DCaption;
                       aDest: TRect; srcCanvas: TCanvas; var srcRect:TRect;
                       aMaskCanvas: TCanvas; TransColor:TColor;
                       aLayout: TLMDGlyphTextLayout; MultiLine, Accel,
                       Transparent:Boolean; ExtFlags:TLMDDrawTextStyles;
                       flags:LongInt); override;
    function  DrawItem(target: TCanvas; toDraw: Boolean; flag: Byte): TRect; override;
    procedure DrawGlyph(Target:TCanvas=nil); override;
    procedure GetIMLChange(Sender:TObject);override;
    function  GetFieldState:TCheckBoxState; virtual;
    procedure Toggle; virtual;
    property  State:TCheckBoxState read FState write SetState default cbUnchecked;
  public
    property Checked:Boolean read GetChecked write SetChecked default false;
    constructor Create(aOwner : TComponent); override;
    destructor Destroy; override;
  published
    property About;
    property AllowGrayed:Boolean index 1 read FAllowGrayed write SetBool default false;
    property Alignment;
    property AutoSize;
    property Caption;
    property Color;
    property Ctl3D;
    property Cursor;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Flat;
    property FocusColor;
    property FocusStyle;
    property Font;
    property Font3D;
    property GlyphTransparent;
    property GlyphTransparentColor;
    property GlyphFlat;
    property GlyphNumber:Byte read FNumGlyphs write SetNumGlyphs default 3;
    property GlyphSize default 13;
    property Height;
    property HelpContext;
    property Hint;
    property ImageList;
    property ImageIndex;
    property Left;
    property ListIndex;
    // 7.1
    property MultiLine;
    // ---
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Tag;
    property Top;
    property Transparent;
    property UseBitmap;
    property UseFocusColor;
    property Visible;
    property Width;

    property OnClick;
    property OnChange;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnMouseEnter;
    property OnMouseExit;

    {4.0}
    //properties
    property Action;
    property Anchors;
    property BiDiMode;
    property DragKind;
    property Constraints;
    property ParentBiDiMode;
    //events
    property OnEndDock;
    property OnStartDock;
  end;

implementation
uses
  Types, Forms, SysUtils, UxTheme, Themes, 
  LMDClass, LMDCont, LMDProcs, LMDUtils, LMDGraphUtils, LMDCustomImageList,
  LMDThemes;

{ --------------------------------- private ---------------------------------- }
procedure TLMDCustomCheckBox.SetBool(index:integer;aValue:Boolean);
begin
  case index of
    1 : if aValue <> FAllowGrayed then FAllowGrayed := aValue;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCheckBox.SetChecked(aValue: Boolean);
begin
  if aValue<>Checked then
    begin
      if aValue then State := cbChecked else State := cbUnchecked;
      //if not (csLoading in ComponentState) then      //RM  Feb 2002
      //  if Assigned (OnChange) then OnChange (self); //JH Jan 2002,
                                                     //change of Feb 2001 seemed to
                                                     //got lost ...
      inherited Changed; //added Feb 2001 JH
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCheckBox.SetNumGlyphs(aValue:Byte);
begin
  {currently one two values are supported: 2 or 3}
  if FNumGlyphs<>aValue then
    begin
       if aValue=0 then aValue:=1;
       FNumGlyphs:=aValue;
       GetIMLChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCheckBox.SetState(aValue:TCheckBoxState);
begin
  if aValue <> FState then
    begin
      FState := aValue;
      if HandleAllocated then
        DrawGlyph; //replaced paint by JH, March 2001 -> reduces flicker if flat

      if not (csLoading in ComponentState) then      //RM 2002
        if Assigned (OnChange) then OnChange (self);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCheckBox.GetChecked: Boolean;
begin
  Result := State = cbChecked;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCheckBox.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and CanFocus then
      begin
        SetFocus;
        if Focused then Toggle;
        Result := 1;
      end
    else
      inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckBox.WMKeyDown(var Message: TWMKeyDown);
begin
  inherited;
  if (Message.CharCode=VK_SPACE) and CanModify and Focused then Toggle;
end;

{------------------------------------------------------------------------------}
function TLMDCustomCheckBox.GetNumGlyphs: Byte;
begin
  if not IMLEmpty then
    result := FNumGlyphs
  else
    result := FIntNumGlyphs;
end;

{------------------------------------------------------------------------------}
function TLMDCustomCheckBox.GetThemedTextColor: TColor;
{$IFDEF LMDCOMP16}
const
  CB_STATES: array[Boolean] of TThemedButton = (
    tbCheckBoxUncheckedDisabled,
    tbCheckBoxUncheckedNormal
  );
var
  dtls: TThemedElementDetails;
{$ENDIF}
begin
  {$IFDEF LMDCOMP16}
  if (UseThemeMode = ttmPlatform) and StyleServices.Enabled and
     TStyleManager.IsCustomStyleActive then
  begin
    dtls := StyleServices.GetElementDetails(CB_STATES[Enabled]);
    if StyleServices.GetElementColor(dtls, ecTextColor, Result) then
      Exit; // Done.
  end;
  {$ENDIF}

  Result := Font.Color;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckBox.DoFlatChanged;
begin
  if Flat then FInternal := Finternal div 2 else FInternal := FInternal * 2;
  if (not IMLEmpty) and HandleAllocated then
    Invalidate;
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDCustomCheckBox.CreateStandardGlyph;
var
  flag:UInt;
  divide,
  i: Integer;
  tmps:TSize;
  lThemeMode: TLMDThemeMode;
begin

  lThemeMode := UseThemeMode;
  if lThemeMode <> ttmNone then
    begin
      // Retrieve dimensions of checkbox buttons
      if LMDThemeServices.GetThemePartSize(lThemeMode, Canvas.Handle, teButton, BP_CHECKBOX, CBS_CHECKEDNORMAL, tmps) then
        begin
          FInternal:=tmps.cx;
          FGlyphHeight:=tmps.cy;
        end
      else
        begin
          FInternal:=FGlyphSize;
          FGlyphHeight:=FInternal;
        end;
      exit;
    end;

  divide := 1;
  FIntNumGlyphs := 3; {unchecked check mixed}
  with FGlyph do
    begin
      //setup bitmap used for storing default glyph bitmap
      if Flat then
        inc (divide); //get 6 more pics places { hot / flat states }

      Width := Width + FGlyphSize * divide * 6;
      Height:=FGlyphSize;
      //clear bitmap
      Canvas.Brush.Color:=FTransparentColor;
      Canvas.FillRect(Rect(0,0, Width, Height));
      Canvas.Brush.Style:=bsClear;

      flag:=0;
      if GlyphFlat then flag:=flag or DFCS_FLAT;
      i := -1;
      if Flat then
        begin
          //standard
          DrawFrameControl(Canvas.Handle, Bounds(LMDInc(i)*FGlyphSize,0, FGlyphSize,FGlyphSize), DFC_BUTTON, flag or DFCS_BUTTONCHECK);
          //standard disabled
          DrawFrameControl(Canvas.Handle, Bounds(LMDInc(i)*FGlyphSize,0, FGlyphSize,FGlyphSize), DFC_BUTTON, flag or DFCS_BUTTONCHECK or DFCS_INACTIVE);
          //Checked
          DrawFrameControl(Canvas.Handle, Bounds(LMDInc(i)*FGlyphSize,0, FGlyphSize,FGlyphSize), DFC_BUTTON, flag or DFCS_BUTTONCHECK or DFCS_CHECKED);
          //Checked disabled
          DrawFrameControl(Canvas.Handle, Bounds(LMDInc(i)*FGlyphSize,0, FGlyphSize,FGlyphSize), DFC_BUTTON, flag or DFCS_BUTTONCHECK or DFCS_CHECKED or DFCS_INACTIVE);
          //3 State
          DrawFrameControl(Canvas.Handle, Bounds(LMDInc(i)*FGlyphSize,0, FGlyphSize,FGlyphSize), DFC_BUTTON, flag or DFCS_BUTTON3STATE or DFCS_CHECKED);
          //3 State disabled
          DrawFrameControl(Canvas.Handle, Bounds(LMDInc(i)*FGlyphSize,0, FGlyphSize,FGlyphSize), DFC_BUTTON, flag or DFCS_BUTTON3STATE or DFCS_CHECKED or DFCS_INACTIVE);
        end;
      //standard
      DrawFrameControl(Canvas.Handle, Bounds(LMDInc(i)*FGlyphSize,0, FGlyphSize,FGlyphSize), DFC_BUTTON, flag or DFCS_BUTTONCHECK);
      //standard disabled
      DrawFrameControl(Canvas.Handle, Bounds(LMDInc(i)*FGlyphSize,0, FGlyphSize,FGlyphSize), DFC_BUTTON, flag or DFCS_BUTTONCHECK or DFCS_INACTIVE);
      //Checked
      DrawFrameControl(Canvas.Handle, Bounds(LMDInc(i)*FGlyphSize,0, FGlyphSize,FGlyphSize), DFC_BUTTON, flag or DFCS_BUTTONCHECK or DFCS_CHECKED);
      //Checked disabled
      DrawFrameControl(Canvas.Handle, Bounds(LMDInc(i)*FGlyphSize,0, FGlyphSize,FGlyphSize), DFC_BUTTON, flag or DFCS_BUTTONCHECK or DFCS_CHECKED or DFCS_INACTIVE);
      //3 State
      DrawFrameControl(Canvas.Handle, Bounds(LMDInc(i)*FGlyphSize,0, FGlyphSize,FGlyphSize), DFC_BUTTON, flag or DFCS_BUTTON3STATE or DFCS_CHECKED);
      //3 State disabled
      DrawFrameControl(Canvas.Handle, Bounds(LMDInc(i)*FGlyphSize,0, FGlyphSize,FGlyphSize), DFC_BUTTON, flag or DFCS_BUTTON3STATE or DFCS_CHECKED or DFCS_INACTIVE);
    end;
  FInternal:=FGlyph.Width div (divide * 6);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCheckBox.Click;
begin
  if CanModify then Toggle;
  inherited Changed;
  inherited Click;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCheckBox.DoEnter;
begin
  inherited DoEnter;
  Paint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCheckBox.CreateGlyph;
begin
  RemoveGlyph;

  if IsThemed then
    begin
      CreateStandardGlyph;
      exit;
    end;

  FGlyph:=TBitmap.Create;
  if not IMLEmpty then
    begin
      LMDIMLItemBitmap(ImageList, ListIndex, ImageIndex, FGlyph);
      FInternal:=FGlyph.Width div (GetNumGlyphs*2) ;
      if HasDown and flat then
        FInternal := Finternal div 3
      else
        if Flat or HasDown then
          FInternal := Finternal div 2;
    end
  else
    CreateStandardGlyph;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCheckBox.GetGlyphNumber : Integer;
var
  lThemes : Boolean;
begin
  if (csPaintCopy in ControlState) then
    result:=Ord(GetFieldState)
  else
    result:=Ord(FState);

  if result>(GetNumGlyphs-1) then result:=(GetNumGlyphs-1);

  //result = ord (unchecked checked mixed)

  result:=result*2+ord(not Enabled);

  lThemes := IsThemed;
  //jump to down section  ->> 6.1
  if Down and ( (IMLEmpty and lThemes) or ((not IMLEmpty) and HasDown) ) then
    begin
      inc(result, 6);
      if Flat then inc(result, 6);
    end;

  if Flat and not MouseAbove and not Focused then inc(result, 6); //jump to the second part of the image
  if Flat and lThemes and Focused and not MouseAbove then inc (result, 6); //not hot if focused!!

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCheckBox.DrawFace(aCanvas: TCanvas; const aString:String;
                    Effects:TLMD3DCaption;
                    aDest: TRect; srcCanvas: TCanvas; var srcRect:TRect;
                    aMaskCanvas: TCanvas; TransColor:TColor;
                    aLayout: TLMDGlyphTextLayout; MultiLine, Accel,
                    Transparent:Boolean; ExtFlags:TLMDDrawTextStyles;
                    flags:LongInt);
begin
  aCanvas.Font.Color := GetThemedTextColor;
  FItemPositions := LMDDrawTextAndGlyphExt(aCanvas, aString, Effects, aDest, srcCanvas,
                         srcRect, aMaskCanvas, TransColor, aLayout, MultiLine,
                         Accel, Transparent, ExtFlags, flags);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCheckBox.DrawItem(target:TCanvas; toDraw:Boolean; flag:Byte):TRect;
var
  tmp:Integer;
  dRect:TRect;
  ds:TLMDDrawTextStyles;
  flags:LongInt;
  lThemes : Boolean;
begin
  target.Brush.Color:=Color;
  target.Font:=self.Font;

  //get a glyph if there is currently none available
  if not Assigned(FGlyph) then CreateGlyph;

  tmp := GetGlyphNumber;
  lThemes := IsThemed;
  //get rect of glyph to be painted
  if lThemes or not Assigned(FGlyph) then
    result:=Rect(0, 0, FInternal, FGlyphHeight)
  else
    result:=Rect(tmp*FInternal, 0, (tmp+1)*FInternal, FGlyph.Height);
  dRect:=Rect(0,0, Width, Height); //GetClientrect;
  Inc(dRect.Left); {Dec(dRect.Right);}

  //if FocusStyle in [fcControl, fcGlyphText] then inc(dRect.Top, 2);

  if toDraw then
   ds:=[TLMDDrawTextStyle(Enabled), dt3DDisabled]+LMDConvertFocusStyle(FocusStyle)
  else
   ds:=[TLMDDrawTextStyle(Enabled), dt3DDisabled, dtCalculate];
  flags:=0;
  flags:=DrawTextBiDiModeFlags(flags);

  if lThemes then
  begin
    DrawFace(target, Caption, Font3D, dRect, nil,
                           result, nil, FTransparentColor, Alignment, MultiLine,
                           True, True, ds+[dtGhostGlyph], flags);
    DrawGlyph(target);
  end
  else
    DrawFace(target, Caption, Font3D, dRect, FGlyph.Canvas,
                           result, nil, FTransparentColor, Alignment, MultiLine,
                           True, GlyphTransparent, ds, flags);

  if toDraw then
    if Focused and not (FocusStyle=fcNone) then
    begin
      target.Brush.Style:=bsSolid;
      case FocusStyle of
        fcControl:
        begin
          Result := ClientRect;
          DrawFocus(target, Result);
        end;
      else
        if (FocusStyle <> fcText) or (Caption <> '') then
          DrawFocus(target, Result);
      end;
    end;

  if SaveRes then
    RemoveGlyph;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckBox.DrawGlyph;
var
  tmp:Integer;
  aRect:TRect;
  tmpCanvas:TCanvas;
  lThemeMode: TLMDThemeMode;

  procedure dtb (button:TThemedButton);
  begin
    LMDThemeServices.DrawElement(lThemeMode, tmpCanvas.Handle, ThemeServices.GetElementDetails(button), FItemPositions.GlyphRect);
  end;

begin

  // required for UseBitmap functionality
  if target<>nil then
    tmpCanvas:=Target
  else
    tmpCanvas:=self.Canvas;

  lThemeMode := UseThemeMode;
  //first restore the background of the glyph
  if CheckOptimized then
    BackDrawArea(tmpCanvas, FItemPositions.GlyphRect, Point(0,0), 0)
  else
    if not ((lThemeMode<>ttmNone) and IsNotOpaque) then
       begin
         tmpCanvas.Brush.Color:=Color;
         tmpCanvas.FillRect(FItemPositions.GlyphRect);
       end;

  tmp := GetGlyphNumber;

  // 7.0 -> ThemedMode mode may not use cached bitmap
  if lThemeMode<>ttmNone then
    begin
      if not Flat then Inc(tmp, 6);
      case tmp of
          //hot/flat states (if wanted)
         0: dtb (tbCheckBoxUncheckedHot);
         1: dtb (tbCheckBoxUncheckedDisabled);
         2: dtb (tbCheckBoxCheckedHot);
         3: dtb (tbCheckBoxCheckedDisabled);
         4: dtb (tbCheckBoxMixedHot);
         5: dtb (tbCheckBoxMixedDisabled);
          //normal states
         6: dtb (tbCheckBoxUncheckedNormal);
         7: dtb (tbCheckBoxUncheckedDisabled);
         8: dtb (tbCheckBoxCheckedNormal);
         9: dtb (tbCheckBoxCheckedDisabled);
        10: dtb (tbCheckBoxMixedNormal);
        11: dtb (tbCheckBoxMixedDisabled);
          //down states
        12: dtb (tbCheckBoxUncheckedPressed);
        13: dtb (tbCheckBoxUncheckedDisabled);
        14: dtb (tbCheckBoxCheckedPressed);
        15: dtb (tbCheckBoxCheckedDisabled);
        16: dtb (tbCheckBoxMixedPressed);
        17: dtb (tbCheckBoxMixedDisabled);
      end;
    end
  else
    begin
      //get a glyph if there is currently none available
      if not Assigned(FGlyph) then CreateGlyph;

      //get rect of glyph to be painted
      aRect:=Rect(tmp*FInternal, 0, (tmp+1)*FInternal, FGlyph.Height);

      if GlyphTransparent then
        LMDBmpDrawExt(tmpCanvas, FItemPositions.GlyphRect, FGlyph.Canvas, aRect, DSF_TRANSPARENCY, FTransparentColor, 0, nil)
      else
        LMDBmpDrawExt(tmpCanvas, FItemPositions.GlyphRect, FGlyph.Canvas, aRect, 0, FTransparentColor, 0, nil);
      //Canvas.CopyRect (FItemPositions.GlyphRect, FGlyph.Canvas, aRect);
    end;

  if (FocusStyle = fcGlyph) and Focused then
    DrawFocus(tmpCanvas, GetFocusRect);

  //if we want to save ressources we remove the glyph bitmap now
  //but is has to be refetched before the next drawing
  if SaveRes then RemoveGlyph;
end;

{------------------------------------------------------------------------------}
function TLMDCustomCheckBox.GetFieldState:TCheckBoxState;
begin
  result:=FState;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckBox.GetIMLChange(Sender:TObject);
begin
  CreateGlyph;
  GetChange(nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCheckBox.Toggle;
var
  newState:TCheckBoxState;
begin
  //oldState:=State;
  newState:=State;
  case newState of
    cbUnchecked:
      if AllowGrayed then NewState := cbGrayed else NewState := cbChecked;
    cbChecked: NewState := cbUnchecked;
    cbGrayed: NewState := cbChecked;
  end;
  if NewState<>State then
    State:=NewState;
 //   if Assigned (OnChange) then OnChange (self);
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDCustomCheckBox.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  TabStop := True;
  FGlyphSize:=13;
  FNumGlyphs:=3;
  FIntNumGlyphs:=3;
  //CreateStandardGlyph;
  //ControlStyle := ControlStyle + [csParentBackground];  
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomCheckBox.Destroy;
begin
  inherited Destroy;
end;

end.
