unit LMDCustomSpeedButton;
{$I lmdcmps.Inc}

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

LMDCustomSpeedButton unit (RM)
-----------------------------
Base class for all LMD SpeedButton controls.


Changes
-------
Release 8.0 (December 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, Graphics, Themes,
  LMDClass, LMDButtonBase, LMDGraph, LMDBaseGraphicButton;

type
  {---------------------- TLMDCustomSpeedButton -------------------------------}
  TLMDCustomSpeedButton = class(TLMDBaseGraphicButton)
  private
    procedure SetGlyphKind(aValue:TLMDGlyphKind);
    function  GetStyle: TLMDUserButtonStyle;
    procedure SetStyle(aValue:TLMDUserButtonStyle);
    procedure ReadExtStyle(Reader:TReader);
  protected
    FGlyphKind: TLMDGlyphKind;
    FStyle:     TLMDUserButtonStyle;
    FDesign:    Boolean; //btn gets painted differently in design time if true

    function GetXPThemedClass: TThemedElement;
    procedure DoThemeChanged; override;
    procedure SetParent(AParent: TWinControl);override;

    procedure DefineProperties(Filer:TFiler);override;
    procedure SetUnColorMain(aValue:Boolean);
    function GetUnColorMain:Boolean;
    function ActionChangeable:Boolean;override;
    function IsCustom:Boolean; override;
    function IsHotState:Boolean; override;
    function IsHotOptionsetMode:Boolean;override;
    function RepaintOnMouse: Boolean; override;
    procedure GetIMLChange(Sender:TObject); override;
    function  GetThemedTextColor: TColor; override;
    procedure Paint; override;
    procedure RequestDefaultGlyph;
    property Transparent default True;
    property Design: Boolean read FDesign write FDesign default true;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoStateChange(NewState:TLMDButtonState;ForceUpdate:Boolean=false);
    property GlyphKind: TLMDGlyphKind read FGlyphKind write SetGlyphKind default gkCustom;
    property CtlXP default True; // compatibility
    property Style:TLMDUserButtonStyle read GetStyle write SetStyle stored false;
    property ButtonStyle:TLMDUserButtonStyle read FStyle write SetStyle default ubsWin40;
    property UnColorMain:Boolean read GetUnColorMain write SetUnColorMain default True;
  published
    // 7.0
    property ButtonLayout;
    property EnterColor;
    property EnterColorChange;
    property ImageList;
    property ImageIndex;
    property ListIndex;
    property NumGlyphs;
    property Glyph;
    property Font;
    property FontFX;
    property RepeatedClick;
    property RepeatingInterval;
    property RepeatingDelay;
    property UseCaption;
    // 9.0
    property ThemeMode default ttmPlatform;
    property ThemeGlobalMode;
    property OnDropDown;
    // ---
  end;

implementation

uses
  Types, Windows, TypInfo, UxTheme, LMDBase, LMDButtonLayout, LMDCustomControl,
  LMDGlyph, LMDProcs, LMDUtils, LMDGraphUtils;

{********************** Class TLMDCustomSpeedBtn ******************************}
{------------------------- Private --------------------------------------------}
procedure TLMDCustomSpeedButton.SetGlyphKind(aValue:TLMDGlyphKind);
begin
  if aValue<>FGlyphKind then
    begin
      if not (csLoading in ComponentState) then Glyph:=nil;
      FGlyphKind:=aValue;
      if not (csLoading in ComponentState) then
        if FGlyphKind=gkCustom then
          GetIMLChange(nil)
        else
          Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSpeedButton.SetParent(AParent: TWinControl);
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSpeedButton.SetStyle(aValue:TLMDUserButtonStyle);
begin
  if aValue<>FStyle then
    begin
      if aValue in [ubsExplorer, ubsNavigator, ubsFlatUnColored] then
        TLMDGlyph(FGlyph).Style:=gsExplorer  // uncolors glyph
      else
        TLMDGlyph(FGlyph).Style:=gsStandard;

      if (aValue in [ubsExplorer, ubsExplorerColored, ubsOfficeTransp]) or IsThemed then
        begin
          FTransparent:=True;
          ControlStyle:=ControlStyle-[csOpaque];
        end
      else
        if (FStyle in [ubsExplorer, ubsExplorerColored, ubsOfficeTransp]) then
          begin
            FTransparent:=False;
            ControlStyle:=ControlStyle+[csOpaque];
          end;
      FStyle:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSpeedButton.SetUnColorMain(aValue:Boolean);
begin
  if aValue then
    TLMDGlyph(FGlyph).Style:=gsExplorer
  else
    TLMDGlyph(FGlyph).Style:=gsStandard;
  Invalidate;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSpeedButton.GetUnColorMain:Boolean;
begin
  result:=TLMDGlyph(FGlyph).Style=gsExplorer;
end;

// 7.0
{------------------------------------------------------------------------------}
procedure TLMDCustomSpeedButton.ReadExtStyle(Reader: TReader);
var
  tmp:Boolean;
begin
  tmp:=CtlXP;
  LMDButtonReadExtStyle(Reader, FStyle, tmp);
  if tmp <> CtlXP then CtlXP:=tmp;
end;

{------------------------- Protected ------------------------------------------}
function TLMDCustomSpeedButton.ActionChangeable:Boolean;
begin
  result:=FGlyphKind=gkCustom;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSpeedButton.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Style', ReadExtStyle, nil, false);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSpeedButton.GetIMLChange(Sender:TObject);
begin
  if FGlyphKind<>gkCustom then exit;
  inherited GetIMLChange(Sender);
end;

{------------------------------------------------------------------------------}
function TLMDCustomSpeedButton.GetXPThemedClass: TThemedElement;
begin
  case Style of
    {ubsAutoDetect,} ubsWin31, ubsWin40, ubsDelphi, ubsIntegrated, ubsWin40Ext:
      result := teButton;
    ubsCombo:
      result := teComboBox;
    else
      result := teToolBar;
  end; //of case
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSpeedButton.DoThemeChanged;
begin
  inherited;
  Invalidate;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSpeedButton.IsCustom:Boolean;
begin
  result:=(FGlyphKind=gkCustom);
  if result then
     if not IMLEmpty then result:=false;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSpeedButton.IsHotOptionsetMode: Boolean;
begin
  result:=(FState=bsOptionSet) and ((FStyle in [ubsOffice, ubsOfficeTransp]) or IsThemed);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSpeedButton.RequestDefaultGlyph;
var
  tmp:Graphics.TBitmap;
begin
  tmp:=Graphics.TBitmap.Create;
  try
    NumGlyphs:=1;
    LMDGetGlyphKind(tmp, FGlyphKind);
    Glyph:=tmp;
  finally
    tmp.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSpeedButton.RepaintOnMouse:Boolean;
begin
  result := (Style in [ubsFlat, ubsFlatUnColored, ubsDelphiFlat, ubsNavigator, ubsExplorer, ubsExplorerColored,
                       ubsOffice, ubsOfficeTransp, ubsWin40Ext]) or IsThemed;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSpeedButton.IsHotState:Boolean;
begin
  result:=(TLMDGlyph(FGlyph).Style=gsExplorer) {or (Style in [ubsOffice, ubsOfficeTransp])} or IsThemed;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSpeedButton.Paint;
var
  aRect, bRect:TRect;
  flag: Word;
  tmp:TLMDButtonState;
  ti:Byte;
  tmpbl:TLMDButtonLayout;
  tmpXp:Boolean;

  procedure SetRect;
  begin
    aRect:=ClientRect;
    if FUsed then
      begin
        bRect:=Rect(aRect.Right-DropDownComboWidth, aRect.Top, aRect.Right, aRect.Bottom);
        aRect.Right:=bRect.Left;
        if ti>1 then
          aRect.Right:=aRect.Right+1;
      end;
  end;

  function CheckMousePos: Boolean;
  var
    p:TPoint;
    //tmpc:Tcontrol;
  begin
    result:=false;
    if Assigned(Parent) then
    begin
      GetCursorPos(p);
      p:=Parent.ScreenToClient(p);
      if Parent.ControlAtPos(p, false)=self then result:=true;
    end;
  end;

begin
  if (csCreating in ControlState) or (csLoading in ComponentState) or
     (not Visible and not (csDesigning in ComponentState)) then
    Exit;

  ti    := LMDGetButtonBevel(FStyle, FState);
  aRect := ClientRect;

  // 7.01

  if isTransparentSet {$IFDEF LMDCOMP16} or StyleServices.Enabled {$ENDIF} then
  begin
    if CheckOptimized then
      BackDrawArea(Canvas, aRect, Point(0,0), 0)
  end
  else //not CheckOptimized => no back bitmap, no parent handle, repaint background
  begin
    Canvas.Brush.Color := Color;
    Canvas.Brush.Style := bsSolid;
    Canvas.FillRect(aRect);
  end;

  SetRect;

  flag := BDF_SPEEDBUTTON or BDF_ROUNDED;
  if FState = bsMouseOver then
    flag := flag or BDF_MOUSEOVER;

  tmpxp := IsThemed;
  if tmpxp then
    flag := flag or BDF_CTLXP;

  if (csDesigning in ComponentState) and FDesign then
  begin
    LMDDrawBtnFaceExt(self.Parent, Canvas, MouseOver, aRect,
                      FStyle, bsMouseOver, flag, Color, ThemeMode);

    if FUsed then
    begin
      aRect := bRect;
      flag  := flag or BDF_SPLITPARTTWO or BDF_SPLIT;
      LMDDrawBtnFaceExt(self.Parent, Canvas, MouseOver, aRect,
                        FStyle, bsMouseOver, flag, Color, ThemeMode);

      if not ((FStyle in [ubsCombo]) or (tmpxp and LMDIsXPToolButton(FStyle))) then
        LMDDrawTriangle(Canvas, bRect.Left+((DropDownComboWidth-3) div 2),
                        (Height-3) div 2, 3,clBlack, True, Enabled);
    end
  end
  else
  begin
    if FUsed then
    begin
      // 7.0 RM, changed display of flat buttons...
      if FState<>bsDropDownOpen then
        tmp := FState
      else if LMDIsXPToolButton(FStyle) then
        tmp := bsMouseOver
      else
        tmp := bsUp;
      // ---------
      flag := flag or BDF_SPLIT;
      LMDDrawBtnFaceExt(self.Parent, Canvas, (tmp=bsMouseOver) or MouseOver,
                        aRect, FStyle, tmp, flag, Color, ThemeMode);
      // 7.0 RM, changed display of flat buttons...
      if FState<>bsDown then
        tmp:=FState
      else if LMDIsXPToolButton(FStyle) then
        tmp:=bsMouseOver
      else
        tmp:=bsUp;

      // ---------
      aRect := bRect;
      flag  := flag or BDF_SPLITPARTTWO;
      LMDDrawBtnFaceExt(self.Parent, Canvas, (tmp=bsMouseOver), aRect,
                        FStyle, tmp, flag, Color, ThemeMode);

      if not ((FStyle in [ubsCombo]) or (tmpxp and LMDIsXPToolButton(FStyle))) then
        LMDDrawTriangle(Canvas, bRect.Left+((DropDownComboWidth-3) div 2),
                        (Height-3) div 2, 3,clBlack, True, Enabled);
    end
    else
      // bsOptionSet behaviour...
      if IsHotOptionSetMode and CheckMousePos then
        LMDDrawBtnFaceExt(self.Parent,Canvas, True, aRect, FStyle, FState,
                          flag, Color, ThemeMode)
      else
        LMDDrawBtnFaceExt(self.Parent,Canvas, MouseOver, aRect, FStyle,
                          FState, flag, Color, ThemeMode);
  end;

  SetRect;
  InflateRect(aRect,-ti ,-ti);

  if not FUsed or (FUsed and not (FState=bsDropDownOpen)) then
    if FState in [bsDown, bsOptionSet, bsDropDownOpen] then
      OffsetRect(aRect,1,1);

  // 7.0

  if (FStyle<>ubsCombo) then
  begin
    Canvas.Refresh;
    DrawGlyphAndText(Canvas, aRect);
  end
  else  // here follows custom ComboBox drawing
    if not tmpxp then
    begin
      tmpbl:=TLMDButtonLayout.Create;
      try
        tmpbl.Arrow       := true;
        tmpbl.ArrowSize   := 4;
        tmpbl.ArrowIndent := -1;

        //if  FState=bsMouseOver then
        //  tmpbl.ArrowColor:=clHighLight;
        Canvas.Refresh;
        LMDDrawTextAndGlyph(Canvas, '', FontFx, aRect, nil, nil, tmpbl,
                            false, false, false, [TLMDDrawTextStyle(Enabled),
                            dt3DDisabled], flag);
      finally
        tmpbl.Free;
      end;
    end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDCustomSpeedButton.Create(AOwner: TComponent);
begin
  inherited Create(aOwner);
  FThemeMode := ttmPlatform;
  ControlStyle:=[csCaptureMouse, csDoubleClicks, csOpaque, csReplicatable];
  AllowMouseOver:=True;
  FStyle:=ubsWin40; //ubsAutoDetect;
  FAllowTransparency:=False;
  Width:=23;
  Height:=22;
  FGlyphKind:=gkCustom;
  FDesign := true;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomSpeedButton.Destroy;
begin
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSpeedButton.DoStateChange(NewState: TLMDButtonState;
  ForceUpdate: Boolean);
begin
  StateChange(NewState, ForceUpdate);
end;

{------------------------------------------------------------------------------}
function TLMDCustomSpeedButton.GetStyle: TLMDUserButtonStyle;
begin
  case UseThemeMode of
    ttmNative:
      result := ubsWin40Ext;
  else
    result := FStyle;
  end;
end;

function TLMDCustomSpeedButton.GetThemedTextColor: TColor;
{$IFDEF LMDCOMP16}
const
  PUSH_BTNS: array[TLMDButtonState] of TThemedButton = (
    tbPushButtonNormal,   // bsUp
    tbPushButtonDisabled, // bsDisabledUp
    tbPushButtonHot,      // bsMouseOver
    tbPushButtonPressed,  // bsOptionSet
    tbPushButtonPressed,  // bsDown
    tbPushButtonHot,      // bsDragOver
    tbPushButtonPressed,  // bsDropDownOpen
    tbPushButtonDisabled, // bsDisabledDown
    tbPushButtonNormal    // bsDefaultEd
  );

  COMBO_BTNS: array[TLMDButtonState] of TThemedComboBox = (
    tcDropDownButtonNormal,   // bsUp
    tcDropDownButtonDisabled, // bsDisabledUp
    tcDropDownButtonHot,      // bsMouseOver
    tcDropDownButtonPressed,  // bsOptionSet
    tcDropDownButtonPressed,  // bsDown
    tcDropDownButtonHot,      // bsDragOver
    tcDropDownButtonPressed,  // bsDropDownOpen
    tcDropDownButtonDisabled, // bsDisabledDown
    tcDropDownButtonNormal    // bsDefaultEd
  );

  TOOL_BTNS: array[TLMDButtonState] of TThemedToolBar = (
    ttbButtonNormal,   // bsUp
    ttbButtonDisabled, // bsDisabledUp
    ttbButtonHot,      // bsMouseOver
    ttbButtonPressed,  // bsOptionSet
    ttbButtonPressed,  // bsDown
    ttbButtonHot,      // bsDragOver
    ttbButtonPressed,  // bsDropDownOpen
    ttbButtonDisabled, // bsDisabledDown
    ttbButtonNormal    // bsDefaultEd
  );
var
  dtls: TThemedElementDetails;
{$ENDIF}
begin
  {$IFDEF LMDCOMP16}
  if (UseThemeMode = ttmPlatform) and StyleServices.Enabled and
     TStyleManager.IsCustomStyleActive then
  begin
    case Style of
      ubsWin31, ubsWin40, ubsDelphi,
      ubsIntegrated, ubsWin40Ext:
        dtls := StyleServices.GetElementDetails(PUSH_BTNS[FState]);
      ubsCombo:
        dtls := StyleServices.GetElementDetails(COMBO_BTNS[FState]);
     else
       dtls := StyleServices.GetElementDetails(TOOL_BTNS[FState]);
    end;

    if not StyleServices.GetElementColor(dtls, ecTextColor, Result) then
      Result := Font.Color;
  end
  else
  {$ENDIF}
    Result := Font.Color;
end;

end.
