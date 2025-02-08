unit LMDRadioButton;
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

LMDRadioButton unit (RM)
------------------------

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Controls, Classes, Graphics,
  LMDButtonControl, LMD3DCaption, LMDGlyphTextLayout, LMDGraph, LMDCustomImageList;

type
  {------------------------- TLMDRadioButton ----------------------------------}
  TLMDRadioButton=class(TLMDButtonControl)
  private
    FTurnSibling,
    FChecked:Boolean;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
  protected
    function isSibling (aControl: TControl) : Boolean; virtual;
    procedure DoFlatChanged; override;
    procedure CreateGlyph; override;
    procedure CreateStandardGlyph;override;
    function GetChecked:Boolean;override;
    procedure SetChecked(aValue:Boolean);override;
    procedure DoEnter; override;
    function GetGlyphNumber(flag: Word) : Integer;    
    function  GetThemedTextColor: TColor;
    procedure DrawFace(aCanvas: TCanvas; const aString:String;
                       Effects:TLMD3DCaption;
                       aDest: TRect; srcCanvas: TCanvas; var srcRect:TRect;
                       aMaskCanvas: TCanvas; TransColor:TColor;
                       aLayout: TLMDGlyphTextLayout; MultiLine, Accel,
                       Transparent:Boolean; ExtFlags:TLMDDrawTextStyles;
                       flags:LongInt); override;
    function DrawItem(target:TCanvas; toDraw:Boolean; flag:Byte):TRect;override;
    procedure DrawGlyph(Target:TCanvas=nil); override;
    procedure GetIMLChange(Sender:TObject);override;
  public
    constructor Create(aOwner : TComponent); override;
    destructor Destroy; override;
    property TurnSibling : Boolean read FTurnSibling write FTurnSibling default false;
  published
    property About;
    property Alignment;
    property AutoSize;
    property BackFX;
    property Caption;
    property Checked:Boolean read GetChecked write SetChecked;
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
    property GlyphTransparent default True;
    property GlyphTransparentColor;
    property GlyphFlat;
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
    property TabStop;
    property Tag;
    property Top;
    property Transparent;
    property UseBitmap;
    property UseFocusColor;
    property Visible;
    property Width;

    property OnClick;
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
    {$IFNDEF LMDCOMP3}
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
    {$ENDIF}

  end;

implementation

uses
  Types, Forms, UxTheme, Themes,
  LMDClass, LMDProcs, LMDUtils, LMDGraphUtils, LMDCont, LMDThemes;

{ --------------------------------- private ---------------------------------- }
procedure TLMDRadioButton.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(Message.CharCode, Caption) and CanFocus {and TabStop} then
      begin
        SetFocus;
        Result := 1;
      end
    else
      inherited;
end;

{ -------------------------------- protected --------------------------------- }
procedure TLMDRadioButton.SetChecked(aValue: Boolean);

  procedure TurnSiblingsOff;
  var
    i: Integer;
    Sibling: TControl;
  begin
    if Parent <> nil then
      with Parent do
        for i:=0 to Pred(ControlCount) do
          begin
            Sibling:=Controls[i];
            if isSibling (Sibling) then
              begin
                TLMDRadioButton(Sibling).SetChecked(False);
              end;
          end;
  end;

begin
  if FChecked <> aValue then
    begin
      FChecked:=aValue;
      //TabStop:=aValue; removed JH 28.10.99
      if aValue then
        begin
//          if not TurnSibling then
            begin
              TurnSiblingsOff;
              if not ClicksDisabled then Click; //5.0, RM
            end;
        end
      else
        if CanFocus and Focused and (Owner is TCustomForm) then
          TCustomForm(Owner).ActiveControl:=nil;
      DrawGlyph; //replaced paint by JH, March 2001
    end;
end;

{------------------------------------------------------------------------------}
function TLMDRadioButton.GetChecked:Boolean;
begin
  result:=FChecked;
end;

{------------------------------------------------------------------------------}
//new 8 Aug. 2001, JH
function TLMDRadioButton.isSibling (aControl: TControl) : Boolean;
begin
  result := (aControl <> Self) and (aControl is TLMDRadioButton);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRadioButton.DoFlatChanged;
begin
  if Flat then FInternal := Finternal div 2 else FInternal := FInternal * 2;
  if not IMLEmpty then
    Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRadioButton.CreateGlyph;
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
      FInternal:=FGlyph.Width div 4;
      if Flat then FInternal := Finternal div 2;
    end
  else
    CreateStandardGlyph;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRadioButton.CreateStandardGlyph;
var
  flag:UInt;
  tmp,
  i: Integer;
  tmps:TSize;
  lThemeMode: TLMDThemeMode;
begin
  flag:=0;

  lThemeMode := UseThemeMode;
  if lThemeMode <> ttmNone then
    begin
      // Retrieve dimensions of checkbox buttons
      if LMDThemeServices.GetThemePartSize(lThemeMode, Canvas.Handle, teButton, BP_RADIOBUTTON, RBS_UNCHECKEDNORMAL, tmps) then //vb themes
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

  if GlyphFlat then flag:=flag or DFCS_FLAT;
  tmp := 4;
  with FGlyph do
    begin
      //setup bitmap storing default glyph bitmap
      Width:=FGlyphSize*4;
      if Flat then
        Width := Width + FGlyphSize*4;
      Height:=FGlyphSize;
      //clear bitmap
      Canvas.Brush.Color:=FTransparentColor;
      Canvas.FillRect(Rect(0,0, Width, Height));
      Canvas.Brush.Style:=bsClear;
      Canvas.Pen.Style:=psClear;
      i := -1;

      //store glyph images in the new bitmap
      if Flat then
        begin
          tmp := 8;
          //standard
          DrawFrameControl(Canvas.Handle, Bounds(LMDInc(i) * FGlyphSize,0, FGlyphSize,FGlyphSize), DFC_BUTTON, flag or DFCS_BUTTONRADIO);
          //standard disabled
          DrawFrameControl(Canvas.Handle, Bounds(LMDInc(i) * FGlyphSize,0, FGlyphSize,FGlyphSize), DFC_BUTTON, flag or DFCS_BUTTONRADIO or DFCS_INACTIVE);
          //Checked
          DrawFrameControl(Canvas.Handle, Bounds(LMDInc(i) * FGlyphSize,0, FGlyphSize,FGlyphSize), DFC_BUTTON, flag or DFCS_BUTTONRADIO or DFCS_CHECKED);
          //Checked disabled
          DrawFrameControl(Canvas.Handle, Bounds(LMDInc(i) * FGlyphSize,0, FGlyphSize,FGlyphSize), DFC_BUTTON, flag or DFCS_BUTTONRADIO or DFCS_CHECKED or DFCS_INACTIVE);
        end;
      //standard
      DrawFrameControl(Canvas.Handle, Bounds(LMDInc(i) * FGlyphSize,0, FGlyphSize,FGlyphSize), DFC_BUTTON, flag or DFCS_BUTTONRADIO);
      //standard disabled
      DrawFrameControl(Canvas.Handle, Bounds(LMDInc(i) * FGlyphSize,0, FGlyphSize,FGlyphSize), DFC_BUTTON, flag or DFCS_BUTTONRADIO or DFCS_INACTIVE);
      //Checked
      DrawFrameControl(Canvas.Handle, Bounds(LMDInc(i) * FGlyphSize,0, FGlyphSize,FGlyphSize), DFC_BUTTON, flag or DFCS_BUTTONRADIO or DFCS_CHECKED);
      //Checked disabled
      DrawFrameControl(Canvas.Handle, Bounds(LMDInc(i) * FGlyphSize,0, FGlyphSize,FGlyphSize), DFC_BUTTON, flag or DFCS_BUTTONRADIO or DFCS_CHECKED or DFCS_INACTIVE);
    end;
  FInternal:=FGlyph.Width div tmp;
end;

{------------------------------------------------------------------------------}
procedure TLMDRadioButton.DoEnter;
begin
  inherited DoEnter;
  if FChecked or (not CanModify) then
    Paint
  else
    begin
      SetChecked(True);
      Paint; //added Aug 2001, SetChecked only redraws the glyph
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDRadioButton.GetGlyphNumber(flag: word) : Integer;
var
  lThemes: Boolean;

begin
  if flag=0 then
    result:=Ord(Checked)*2+ord(not Enabled)
  else
    result:=Ord(flag-1)*2+ord(not Enabled);

  lThemes := IsThemed;
  if Down and ((IMLEmpty and lThemes) or ((not IMLEmpty) and HasDown)) then
    begin
      inc(result, 4);
      if Flat then inc(result, 4);
      exit;
    end;

  if Flat and not MouseAbove and not Focused then inc(result, 4); //jump to the second part of the image
  if Flat and lThemes and Focused and not MouseAbove then inc (result, 4); //not hot if focused!!
end;

{------------------------------------------------------------------------------}
procedure TLMDRadioButton.DrawFace (aCanvas: TCanvas; const aString:String;
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

  if not (dtCalculate in ExtFlags) then
    begin
      if dtRectText in ExtFlags then srcRect := FItemPositions.TextRect;
      if dtRectGlyph in ExtFlags then srcRect := FItemPositions.GlyphRect;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDRadioButton.DrawItem(target:TCanvas; toDraw:Boolean; flag:Byte):TRect;
var
  tmp:LongInt;
  dRect:TRect;
  ds:TLMDDrawTextStyles;
  flags:LongInt;
  lThemes: Boolean;
begin
  target.Brush.Color:=Color;
  target.Font:=self.Font;
  tmp:=GetGlyphNumber(flag);

  //if there is no Glyph bitmap we should try tot get one ...
  if not Assigned(FGlyph) then CreateGlyph;

  lThemes := IsThemed;
  If lThemes or not Assigned(FGlyph) then
    result:=Rect(0, 0, FInternal, FInternal)
  else
    result:=Rect(tmp*FInternal, 0, (tmp+1)*FInternal, FGlyph.Height);

  dRect:=Rect(0,0, Width, Height); {GetClientrect;}
  Inc(dRect.Left); Dec(dRect.Right);

  if toDraw then
   ds:=[TLMDDrawTextStyle(Enabled), dt3DDisabled] + LMDConvertFocusStyle(FocusStyle)
  else
   ds:=[TLMDDrawTextStyle(Enabled), dt3DDisabled, dtCalculate];

  flags:=0;
  flags:=DrawTextBiDiModeFlags(flags);
  if lThemes then
    begin
      DrawFace(target, Caption, Font3D, dRect, nil,
                       result, nil, FTransparentColor, Alignment, MultiLine,
                       True, true, ds+[dtGhostGlyph], flags);
      DrawGlyph(target);
    end
  else
    DrawFace(target, Caption, Font3D, dRect, FGlyph.Canvas,
                           result, nil, FTransparentColor, Alignment, MultiLine,
                           True, FGlyphTransparent, ds, flags);

  if toDraw then
    if Focused and not (FocusStyle=fcNone) then
      begin
        case FocusStyle of
          fcControl: result:=ClientRect;
          fcText:  // some adjustements
            begin
              result.Left:=result.Left-2;
              result.Top:=result.Top-1;
            end;
        end;
        target.Brush.Style:=bsSolid;
        if result.Top < 0 then result.Top := 0; //fixes a small off by n problem
        DrawFocus(target, result);
      end;

  //if we wanna save ressources we can free the glyph bitmap now ...
  if SaveRes then RemoveGlyph;
end;

{------------------------------------------------------------------------------}
procedure TLMDRadioButton.DrawGlyph;
var
  tmp:Integer;
  aRect:TRect;
  tmpCanvas:TCanvas;
  lThemeMode : TLMDThemeMode;

  procedure dtb (button:TThemedButton);
  begin
    LMDThemeServices.DrawElement(lThemeMode, tmpCanvas.Handle, ThemeServices.GetElementDetails(button), FItemPositions.GlyphRect);
  end;

begin
  if not HandleAllocated then
    exit;

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
    if not ((lThemeMode <> ttmNone) and ParentBackground) then
      begin
        tmpCanvas.Brush.Color:=Color;
        tmpCanvas.Brush.Style:=bsSolid;
        tmpCanvas.FillRect(FItemPositions.GlyphRect);
      end;

  // Get ID of glyph
  tmp:= GetGlyphNumber(0);

  // 7.0 -> Themed mode may not use cached bitmap
  if lThemeMode <> ttmNone then
    begin
      if not Flat then Inc(tmp, 4);
      case tmp of
         //hot/flat states
         0: dtb (tbRadioButtonUncheckedHot);
         1: dtb (tbRadioButtonUncheckedDisabled);
         2: dtb (tbRadioButtonCheckedHot);
         3: dtb (tbRadioButtonCheckedDisabled);
         //normal states
         4: dtb (tbRadioButtonUncheckedNormal);
         5: dtb (tbRadioButtonUncheckedDisabled);
         6: dtb (tbRadioButtonCheckedNormal);
         7: dtb (tbRadioButtonCheckedDisabled);
         //down states
         8: dtb (tbRadioButtonUncheckedPressed);
         9: dtb (tbRadioButtonUncheckedDisabled);
        10: dtb (tbRadioButtonCheckedPressed);
        11: dtb (tbRadioButtonCheckedDisabled);
      end;
    end
  else
    begin
      //fetch a glyph bitmap if we do not have one ...
      //added here 'cause: code above will sometimes execute DrawItem ...
      if not Assigned(FGlyph) then CreateGlyph;
      //get rect of glyph to be painted
      aRect:=Rect(tmp*FInternal, 0, (tmp+1)*FInternal, FGlyph.Height);
      if GlyphTransparent then
        LMDBmpDrawExt(tmpCanvas, FItemPositions.GlyphRect, FGlyph.Canvas, aRect, DSF_TRANSPARENCY, FTransparentColor, 0, nil)
      else
        LMDBmpDrawExt(tmpCanvas, FItemPositions.GlyphRect, FGlyph.Canvas, aRect, 0, FTransparentColor, 0, nil);
    end;

  if (FocusStyle = fcGlyph) and Focused then
    DrawFocus(tmpCanvas, GetFocusRect);

  if SaveRes then RemoveGlyph;
end;

{------------------------------------------------------------------------------}
procedure TLMDRadioButton.GetIMLChange(Sender:TObject);
begin
  CreateGlyph;
  GetChange(nil);
end;

function TLMDRadioButton.GetThemedTextColor: TColor;
{$IFDEF LMDCOMP16}
const
  CB_STATES: array[Boolean] of TThemedButton = (
    tbRadioButtonUncheckedDisabled,
    tbRadioButtonUncheckedNormal
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

{ ------------------------------- public ------------------------------------- }
constructor TLMDRadioButton.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  ControlStyle:=ControlStyle + [csDoubleClicks];
  FGlyphSize:=13;
  FGlyphTransparent:=True;
  FTurnSibling := false;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDRadioButton.Destroy;
begin
  inherited Destroy;
end;

end.
