unit LMDButtonControl;
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

LMDCustomRadioGroup unit (RM)
----------------------------
Base control for check and radio buttons

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Actnlist, Messages, Graphics, Classes, Controls,
  intfLMDFaceControllerEditable, intfLMDFaceControllerPressable,
  LMDCont, LMDUtils, LMDGraphUtils, LMDGlyphTextLayout, LMD3DCaption,
  LMDGraph, LMDCustomControl, LMDCustomPanel;

type
  {----------------------- TLMDButtonControl ----------------------------------}
  TLMDButtonControl = class(TLMDCustomPanel, ILMDFaceControllerEditable,
                            ILMDFaceControllerPressable)
  private
    FAlignment        : TLMDGlyphTextLayout;
    FDownCtrlState,
    FDown,
    FSaveRes,
    FAutoSize,
    FUseBitmap,
    FClicksDisabled   : Boolean;
    FGlyphFlat        : Boolean;
    FFont3D           : TLMD3DCaption;
    FFocusStyle       : TLMDGlyphTextFocusStyle;
    FFocusColor       : TColor;
    FUseFocusColor    : Boolean;
    FOnChange         : TNotifyEvent;
    FReadOnly         : Boolean;
    FMultiLine        : Boolean;
    function IsCheckedStored: Boolean;
    procedure SetAlignment(aValue:TLMDGlyphTextLayout);
    procedure SetBool(index:integer;aValue : Boolean);
    procedure SetFocusStyle(aValue:TLMDGlyphTextFocusStyle);
    procedure SetFocusColor(aValue:TColor);
    procedure SetGlyphSize(aValue:Byte);
    procedure SetUseFocusColor(aValue:Boolean);
    procedure SetFont3D (aValue : TLMD3DCaption);
    procedure SetMultiline(const Value: Boolean);
    procedure SetTransparentColor(aValue:TColor);
    procedure WMSetFocus (var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus (var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    FGlyph            : TBitmap;
    FInternal         : Integer;
    FGlyphSize        : Byte;
    // 7.0
    FGlyphHeight      : Integer;
    // ---
    FTransparentColor : TColor;
    FUpdating,
    FGlyphTransparent : Boolean;
    FItemPositions    : TLMDWhereRect; //JH March, 2. 2001

    procedure CreateHandle; override;
    function fcGetModified: Boolean; virtual;
    function fcGetReadOnly: Boolean; virtual;
    function fcGetInvalidData: Boolean; virtual;
    function fcGetPressed: Boolean; virtual;

    procedure RestoreBorderFront; override;
    procedure RestoreBorderBack; override;
    procedure WndProc(var Message: TMessage); override;
    procedure CreateStandardGlyph;virtual;
    function GetChecked:Boolean; virtual;
    procedure SetChecked(aValue:Boolean); virtual;
    procedure ActionChange(Sender:TObject;CheckDefaults: Boolean); override;
    function GetActionLinkClass:TControlActionLinkClass; override;
    procedure DoTxtChange (Sender : TObject);virtual;
    //procedure DoXPSupportChanged; override;
    function CanModify:Boolean;virtual;
    function HasDown:Boolean; virtual;
    procedure CorrectBounds; virtual;
    procedure CreateParams(var Params:TCreateParams); override;
    procedure DoThemeChanged; override;
    function GetFocusRect: TRect;
    procedure CreateGlyph; virtual;
    procedure RemoveGlyph;
    procedure DrawFocus(target:TCanvas; aRect:TRect);
    procedure DrawFace (aCanvas: TCanvas;
                        const aString:String;
                        Effects:TLMD3DCaption;
                        aDest: TRect;
                        srcCanvas: TCanvas;
                        var srcRect:TRect;
                        aMaskCanvas: TCanvas;
                        TransColor:TColor;
                        aLayout: TLMDGlyphTextLayout;
                        MultiLine,
                        Accel,
                        Transparent:Boolean;
                        ExtFlags:TLMDDrawTextStyles;
                        flags:LongInt); virtual; abstract;

    function DrawItem(target:TCanvas; toDraw:Boolean; flag:Byte):TRect;virtual;abstract;
    procedure DrawGlyph(Target:TCanvas=nil); virtual; abstract;
    procedure DoExit; override;
    procedure MouseEnter; override;
    procedure MouseExit; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure GetChange(Sender:TObject);override;
    function GetPalette:HPalette; override;
    procedure Loaded; override;
    procedure Paint; override;

    property Checked: Boolean read GetChecked write SetChecked stored IsCheckedStored default False;

    property AutoSize:Boolean index 0 read FAutoSize write SetBool default false;
    property FocusStyle:TLMDGlyphTextFocusStyle read FFocusStyle write SetFocusStyle default fcText;
    property FocusColor:TColor read FFocusColor write SetFocusColor default clGray;
    property GlyphTransparent:Boolean index 1 read FGlyphTransparent write SetBool default false;
    property GlyphTransparentColor:TColor read FTransparentColor write SetTransparentColor default clOlive;
    property UseBitmap:Boolean read FUseBitmap write FUseBitmap default false;
    property UseFocusColor:Boolean read FUseFocusColor write SetUseFocusColor default false;
    property ClicksDisabled:Boolean read FClicksDisabled;
    property SaveRes:Boolean read FSaveRes write FSaveRes default true;
    property Down:Boolean read FDown write FDown;
    // 7.1
    property MultiLine:Boolean read FMultiLine write SetMultiline default true;
    // ----
  public
    constructor Create(aOwner : TComponent); override;
    destructor Destroy; override;
    procedure PaintToControl(flag:Byte);
    procedure UpDateNow (enabled : Boolean);

    property CtlXP;  // compatbility
    property GlyphSize:Byte read FGlyphSize write SetGlyphSize;
    property GlyphFlat:Boolean index 2 read FGlyphFlat write SetBool default false;
    property Alignment:TLMDGlyphTextLayout read FAlignment write SetAlignment;
    property Flat;
    property Font;
    property Font3D:TLMD3DCaption read FFont3D write SetFont3D;
    property Transparent;
    property ImageList;
    property ImageIndex;
    property ListIndex;
    property ReadOnly:Boolean read FReadOnly write FReadOnly default false;
    property OnClick;
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
  published
    property Caption;
    property DownGlyph:Boolean read FDownCtrlState write FDownCtrlState default false;
    property ParentColor default True;
    property ParentBackground default true;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
  end;

  {--------------------- TLMDButtonActionLink ---------------------------------}
  TLMDButtonActionLink=class(TWinControlActionLink)
  protected
    FClient: TLMDButtonControl;
    procedure AssignClient(aClient: TObject); override;
    function IsCheckedLinked: Boolean; override;
    procedure SetChecked(aValue: Boolean); override;
  end;

implementation

uses
  Types, SysUtils;
{ ------------------------------- private ------------------------------------ }
procedure TLMDButtonControl.SetAlignment(aValue:TLMDGlyphTextLayout);
begin
  FAlignment.Assign(aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.SetBool(index:integer;aValue:Boolean);
begin
  case index of
    0 : if aValue <> FAutoSize then
          begin
            FAutoSize := aValue;
            if HandleAllocated then
              CorrectBounds;
          end;
    1: if aValue<>FGlyphTransparent then
         begin
           FGlyphTransparent:=aValue;

           if HandleAllocated then
            Invalidate;
         end;
    2: if aValue<>FGlyphFlat then
         begin
           FGlyphFlat:=aValue;
           if IMLEmpty then
             begin
               //CreateStandardGlyph; exch by line below, Aug 2001, JH
               CreateGlyph; //this line could be exch to RemoveGlyph (would have the same result)
               GetChange(nil);
             end;
         end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.SetFocusStyle(aValue:TLMDGlyphTextFocusStyle);
begin
  if aValue<>FFocusStyle then
    begin
      FFocusStyle:=aValue;
      If Focused then GetChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.SetFocusColor(aValue:TColor);
begin
  if aValue<>FFocusColor then
    begin
      FFocusColor:=aValue;
      If Focused then GetChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.SetGlyphSize(aValue:Byte);
begin
  if aValue<>FGlyphSize then
    begin
      FGlyphSize:=aValue;
      if IMLEmpty then
        begin
          //CreateStandardGlyph; exch by line below, Aug 2001, JH
          CreateGlyph; //this line could be replace by RemoveGlyph, would have the same result
          GetChange(nil);
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.SetMultiline(const Value: Boolean);
begin
  if Value<>FMultiLine then
    begin
      FMultiLine:=Value;
      GetChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.SetUseFocusColor(aValue:Boolean);
begin
  if aValue<>FUseFocusColor then
    begin
      FUseFocusColor:=aValue;
      If Focused then GetChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.SetFont3D (aValue:TLMD3DCaption);
begin
  FFont3D.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.SetTransparentColor(aValue:TColor);
begin
  if aValue<> FTransparentColor then
    begin
      FTransparentColor:=aValue;
      GetChange(nil);
    end
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.WMSetFocus (var Message: TWMSetFocus);
begin
  inherited;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.WMKillFocus (var Message: TWMKillFocus);
begin
  inherited;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonControl.fcGetModified: Boolean;
begin
  result := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonControl.fcGetReadOnly: Boolean;
begin
  result := ReadOnly;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonControl.fcGetInvalidData: Boolean;
begin
  result := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonControl.fcGetPressed: Boolean;
begin
  result := FDown;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.RestoreBorderFront;
begin
  //do nothing ...
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.RestoreBorderBack;
begin
  //do nothing ...
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
      if not (csDesigning in ComponentState) and not Focused then
        begin
          FClicksDisabled := True;
          If HandleAllocated then Windows.SetFocus(Handle);
          FClicksDisabled := False;
          if not Focused then Exit;
        end;
    CN_COMMAND:
      if FClicksDisabled then Exit;
  end;
  inherited WndProc(Message);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.CMFontChanged(var Message: TMessage);
begin
  inherited;
  GetChange(nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.CMTextChanged(var Message: TMessage);
begin
  inherited;
  DoTxtChange(self);
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.WMSize(var Message: TWMSize);
begin
  inherited;
  Paint;
end;

{ ------------------------------- protected ---------------------------------- }
procedure TLMDButtonControl.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
      if not CheckDefaults or (Self.Checked = False) then Self.Checked := Checked;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonControl.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TLMDButtonActionLink;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonControl.IsCheckedStored: Boolean;
begin
  Result:=(ActionLink=nil) or not TLMDButtonActionLink(ActionLink).IsCheckedLinked;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.DoTxtChange (Sender : TObject);
begin
  //VT Oct 2009. Added autosize on caption change
  CorrectBounds;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.CreateStandardGlyph;
begin

end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonControl.GetChecked: Boolean;
begin
  Result:=False;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.SetChecked(aValue: Boolean);
begin
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonControl.CanModify:Boolean;
begin
  result:=not FReadOnly;
end;

{ ---------------------------------------------------------------------------- }
// --> Jan!!
function TLMDButtonControl.HasDown: Boolean;
begin
  {manual down: replace UseXP}
  result := FDownCtrlState;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.CreateParams(var Params:TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.DoThemeChanged;
begin
  //inherited;   // RM - Themes
  RemoveGlyph; //recreate the glyphs
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.CorrectBounds;
var
  aRect:TRect;
  old:TLMDAlignment;
begin
  if FAutoSize and
     (([csLoading, csReading, csWriting, csDestroying] * ComponentState) = []) and
     HandleAllocated
  then
    begin
      FAlignment.OnChange := nil;
      old := FAlignment.Alignment;
      FAlignment.Alignment := agTopLeft;
      aRect := DrawItem(Canvas, false, 0);
      SetBounds(Left, Top, aRect.Right, aRect.Bottom);
      FAlignment.Alignment := old;
      FAlignment.OnChange := GetChange;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonControl.GetFocusRect: TRect;
begin
  result := FItemPositions.CompleteRect;
  case focusStyle of
    fcText : result := FItemPositions.TextRect;
    fcGlyph: result := FItemPositions.GlyphRect;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.CreateGlyph;
begin
  //NOTE: This method will be overwritten by descendant classes
  //lines in here are only for avoiding errors on subclassing the component
  RemoveGlyph;
  FGlyph := TBitmap.Create;
  CreateStandardGlyph;
end;

procedure TLMDButtonControl.CreateHandle;
begin
  inherited;

  if AutoSize then
    CorrectBounds;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.RemoveGlyph;
begin
  if Assigned (FGlyph) then
    FreeAndNil(FGlyph);
  FGlyphHeight:=0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.DrawFocus(target:TCanvas; aRect:TRect);
begin
  if FUseFocusColor then
    with target do
      begin
        Brush.Style:=bsClear;
        Pen.Style:=psDot;
        Pen.Width:=1;
        Pen.Color:=FFocusColor;
        with aRect do
           Rectangle(Left, Top, Right, Bottom);
        pen.Style:=psSolid;
     end
   else
     begin
       target.DrawFocusRect(aRect);
     end;

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.DoExit;
begin
  inherited DoExit;
//  FDown := false;
  Paint;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonControl.MouseEnter;
begin
  inherited MouseEnter;
  if csDesigning in ComponentState then exit;
  if Flat and (not Focused or IsThemed) then DrawGlyph; //Invalidate; rep JH March 2001
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonControl.MouseExit;
begin
  inherited MouseExit;
  if csDesigning in ComponentState then exit;
  if Flat and (not Focused or IsThemed) then DrawGlyph; //Invalidate; rep JH March 2001
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  FDown := true;
  if IsThemed then DrawGlyph;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  FDown := false;
  if IsThemed then DrawGlyph;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonControl.GetChange(Sender:TObject);
begin
  if csLoading in ComponentState then exit;
  CorrectBounds;
  if (not FUpdating) and HandleAllocated then
    Paint;
end;

{------------------------------------------------------------------------------}
function TLMDButtonControl.GetPalette: HPALETTE;
begin
  Result:=0;
  if not IMLEmpty then result:=LMDIMLPalette(ImageList, ListIndex);
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonControl.Loaded;
begin
  inherited Loaded;
  Canvas.Font:=self.Font;
  CorrectBounds;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.Paint;
begin
  if Showing and HandleAllocated then
    PaintToControl(0); // use default values
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDButtonControl.Create(aOwner:TComponent);
begin
  inherited Create (aOwner);
  ControlStyle:=ControlStyle+[csSetCaption]-[csDoubleClicks, csAcceptsControls];
  BeginUpdate;
  ParentColor:=True;
  ImeMode := imDisable;
  Width := 105;
  Height := 17;
  EndUpdate;
  FFont3D := TLMD3DCaption.Create;
  FFont3D.OnChange := GetChange;
  FAlignment:=TLMDGlyphTextLayout.Create;
  FAlignment.Spacing:=4;
  FAlignment.OnChange := GetChange;
  //FGlyph:=TBitmap.Create; -> removed Aug 2001, JH, CreateGlyph has to do the job
  //before painting ...
  FTransparentColor:=clOlive;
  FFocusStyle:=fcText;
  FFocusColor:=clGray;
  FUseFocusColor:=False;
  FUpdating:=False;
  FSaveRes:=true;
  FDown:=false;
  FDownCtrlState:=false;
  FMultiLine:=true;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDButtonControl.Destroy;
begin
  FAlignment.OnChange:=nil;
  FAlignment.Free;
  FFont3D.OnChange := nil;
  FFont3D.Free;
  RemoveGlyph; //Aug 2001, JH -> former: FGlyph.Free; (we now additionally have
               //to check whether there is a bitmap tpo be destroyed or not)
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.PaintToControl(flag:Byte);
var
  tmp:     TBitmap;
  lThemes: Boolean;
begin
  lThemes := IsThemed;

  if FUseBitmap and not (lThemes and IsNotOpaque) then
  begin
    tmp:=TBitmap.Create;
    try
      tmp.Width  := Width;
      tmp.Height := Height;
      if CheckOptimized then
        BackDrawArea(tmp.Canvas, Rect(0, 0, Width, Height), Point(0,0){(Left,Top}, 0)
      else
      begin
        tmp.Canvas.Brush.Color:=Color;
        tmp.Canvas.FillRect(Rect(0,0, Width, Height));
      end;
      DrawItem(tmp.Canvas, True, flag);
      Canvas.Draw(0,0, tmp);
    finally
      tmp.Free;
    end;
  end
  else
  begin
    if not (lThemes and {$IFNDEF LMDCOMP7}ParentBackground{$ELSE}IsNotOpaque{$ENDIF}) then
      FillControl;
    DrawItem(Canvas, True, flag);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonControl.UpDateNow (enabled : Boolean);
begin
  FUpDating := enabled;
end;

{ *********************** class TLMDButtonActionLink ************************* }
{ ------------------------------- protected ---------------------------------- }
procedure TLMDButtonActionLink.AssignClient(aClient:TObject);
begin
  inherited AssignClient(aClient);

  if  aClient is TLMDButtonControl  then
    FClient:=aClient as TLMDButtonControl;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonActionLink.IsCheckedLinked: Boolean;
begin
  Result := inherited IsCheckedLinked and (FClient.Checked=(Action as TCustomAction).Checked);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonActionLink.SetChecked(aValue: Boolean);
begin
  if IsCheckedLinked then
  begin
    FClient.FClicksDisabled:=True;
    try
      FClient.Checked:=aValue;
    finally
      FClient.FClicksDisabled:=False;
    end;
  end;
end;

end.
