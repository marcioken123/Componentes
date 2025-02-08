unit LMDCustomButton;
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

LMDCustomButton unit (RM)
----------------------------
Base class for standard buttons which can receive focus.

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, StdCtrls, Menus, Messages, Controls, Graphics, Classes, ActnList, ImgList, Themes,
  intfLMDBackground, intfLMDBase, LMDClass, LMDCont, LMDGlyph,
  LMDButtonBase, LMDGraph, LMDFXCaption, LMDButtonLayout, LMDBase, LMDCustomImageList,
  LMDBaseController, LMDTypes;

type
  {****************************************************************************}
  {* TWinButtons}
  {****************************************************************************}
  {----------------------------------------------------------------------------}
  {$IFDEF LMDCOMP16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF}
  TLMDCustomButton=class(TButton, ILMDBackground, ILMDComponent)
  private
    FAbout         : TLMDAboutVar;
    FButtonLayout  : TLMDButtonLayout;
    FCanvas        : TCanvas;
    FDropDown      : TPopupMenu;
    FDropDownIndent: Integer;
    FDropDownRight : Boolean;
    FDropped       : Boolean;
    FFontFx        : TLMDFxCaption;
    {$IFDEF LMD_UNICODE}
    FHint: TLMDString;
    {$ENDIF}
    IsFocused      : Boolean;
    {TP}
    FMouseOver     : Boolean;
    {TP}
    FMultiLine     : Boolean;
    FRepeatedClick : Boolean;
    FRepeatingDelay,
    FRepeatingInterval: Word;

    FState         : TLMDButtonState;
    FStyle         : TLMDNormalButtonStyle;
    FExtStyle      : TLMDUserButtonStyle;
    {TP}
    FTimerID       : TLMDTimer;

    //4.01
    FHideHint      : Boolean;
    //5.0
    FUseCaption    : Boolean;
    // ---
    FOnDropDown,
    FOnMouseEnter,
    FOnMouseExit   : TNotifyEvent;

    {imagelist support}
    FImageList     : TCustomImageList;
    FIndex,
    FListIndex     : Integer;
    FChangeLink    : TChangeLink;
    FUseGlobalTimer: Boolean;
    FParentThemeMode: boolean;
    FThemeMode: TLMDThemeMode;
    FThemeGlobalMode: Boolean;
    procedure SetImageList(aValue:TCustomImageList);
    procedure SetIndex(index, aValue:Integer);
    procedure SetUseCaption(aValue:Boolean);
    procedure ReadCtlXP(Reader: TReader);
    procedure SetThemeGlobalMode(const Value: Boolean);
    {saving}
    {----}
    procedure ReadIdent(Reader:TReader);
    procedure WriteIdent(Writer:TWriter);
    procedure ReadStyle(Reader:TReader);
    procedure ReadExtStyle(Reader:TReader);
    // old theme access methods
    procedure set_CtlXP (aValue: Boolean);
    function get_CtlXP: Boolean;
    // --
    function  CheckCont:Boolean;
    function HasControl:Boolean;
    function IMLEmpty:Boolean;
    function HasIML:Boolean;
    procedure GetIMLChange(Sender:TObject);
    {----  }
    procedure SetGlyphKind(aValue:TLMDGlyphKind);
    procedure SetButtonLayout(aValue: TLMDButtonLayout);
    procedure SetDropDown(aValue: TPopupMenu);
    procedure SetDropDownIndent(aValue: Integer);
    procedure SetDropDownRight(aValue:Boolean);
    procedure SetFontFx(aValue:TLMDFxCaption);
    procedure SetMultiLine(aValue:Boolean);
    procedure SetGlyph(aValue: TBitmap);
    procedure SetRepeatedClick(aValue: Boolean);
    procedure SetRepeatingInterval(aValue: Word);
    procedure SetStyle(aValue:TLMDNormalButtonStyle);
    procedure SetExtStyle(aValue:TLMDUserButtonStyle);
    procedure SetNumGlyphs(aValue: TLMDNumGlyphs);
    procedure SetThemeMode(const Value: TLMDThemeMode);
    procedure SetVisible(aValue : Boolean);
    function GetCaption:String;
    function GetVisible : Boolean;
    function GetNumGlyphs:TLMDNumGlyphs;
    function GetGlyph:TBitmap;
    function IsCustom:Boolean;
    {TP - 3.01}
    procedure ExecuteRepeatedClick(Sender:TObject);

    // 6.1
    procedure CMLMDThemeChanged(var Message: TMessage); message CM_LMDTHEMECHANGED;
    //procedure CMLMDBackChanged(var Message: TMessage); message CM_LMDBACKCHANGED;

    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CNMeasureItem(var Message: TWMMeasureItem); message CN_MEASUREITEM;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message:TMessage);message CM_FONTCHANGED;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMEraseBackground(var Message: TWMERASEBKGND); message WM_ERASEBKGND;
    // 7.02
    procedure WMThemeChanged(var Message: TMessage); message WM_THEMECHANGED;
    procedure SetParentThemeMode(const Value: boolean);
  protected
    FGlyph         : TObject;
    FGlyphKind     : TLMDGlyphKind;
    procedure DefineProperties(Filer:TFiler);override;
    //-- vb aug 2005 -- bts 245 issue is addressed by this changes
    function  GetXPThemedClass:TThemedElement;
    //handle theme changes
    procedure DoThemeChanged; virtual;
    // UseThemeMode returns active theme, depending on global settings etc.
    function  UseThemeMode: TLMDThemeMode;
    // ---
    procedure WndProc(var Message: TMessage); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override ;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean);override;
    procedure BoundsChange(State:TLMDBoundsChangeStates);virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DrawCaptionAndGlyph (aCanvas: TCanvas;aRect: TRect; flags: LongInt); virtual;
    function  GetThemedTextColor: TColor;
    procedure DrawItem(const DrawItemStruct: TDrawItemStruct);virtual;
    procedure DoRepeatedClick;virtual;
    procedure GetChange(Sender:TObject);
    function  GetPalette: HPALETTE;  override;
    function  GetState: TLMDButtonState;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    // 6.0 --
    procedure RequestDefaultGlyph;
    // ----
    procedure FreeTimer;
    procedure SetButtonStyle(ADefault: Boolean);  override;
    {$ifdef LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    {$endif}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    // old theme access methods
    function IsThemed: Boolean; // any other than ttmNone
    // --
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer);override;
    procedure Click; override;
    procedure DropDown;
    //new V7, JH Oct 02
    function BackBitmap: TBitmap;
    function BackBitmapCheck: Boolean;
    function BackDrawArea(Canvas: TCanvas; const dest: TRect; const src: TPoint; flags:Word): Boolean;
    function isTransparentSet: Boolean;
    function BackMapPoint(const aValue: TPoint):TPoint;
    function BackBitmapPalette: HPalette;
    procedure BackUpdate;
    function BackControl (index: Integer): TControl; virtual;
    function BackControlCount: Integer; virtual;

    //new V8
    function getLMDPackage:TLMDPackageID;virtual;
    // -----
    property ParentThemeMode: boolean read FParentThemeMode write SetParentThemeMode;
    //new V9
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;    
    // compatibility types ---
    property Style:TLMDNormalButtonStyle read FStyle write SetStyle;
    property ExtStyle:TLMDUserButtonStyle read FExtStyle write SetExtStyle;
    // -------
    {$HINTS OFF}
    property CtlXP:Boolean read get_CtlXP write set_CtlXP default True;  // compatibility
    {$HINTS ON}
    property Dropped:Boolean read FDropped;
    property DropDownMenu: TPopupMenu read FDropDown write SetDropDown stored True;
    property DropDownIndent: Integer read FDropDownIndent write SetDropDownIndent default 0;
    property DropDownRight:Boolean read FDropDownRight write SetDropDownRight default false;
    property OnDropDown:TNotifyEvent read FOnDropDown write FOnDropDown;
    property GlyphKind: TLMDGlyphKind read FGlyphKind write SetGlyphKind default gkCustom;
  published
    property About:TLMDAboutVar read FAbout write FAbout stored false;
    property ButtonLayout: TLMDButtonLayout read FButtonLayout write SetButtonLayout;
    property ButtonStyle: TLMDUserButtonStyle read FExtStyle write SetExtStyle default ubsWin40;
    property Cancel;
    property Caption;
    property Color;
    property Default;
    property Enabled;
    property Font;
    property FontFX:TLMDFxCaption read FFontFx write SetFontFx;
    property Glyph: TBitmap read GetGlyph write SetGlyph stored IsCustom;
    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$endif}
    //4.01
    property HideHint:Boolean read FHideHint write FHideHint default True;
    // 5.0
    property UseCaption:Boolean read FUseCaption write SetUseCaption default True;
    //--

    property ImageList:TCustomImageList read FImageList write SetImageList stored HasControl;
    property ImageIndex:Integer index 0 read FIndex write SetIndex default 0;
    property ListIndex:Integer index 1 read FListIndex write SetIndex default 0;

    property ModalResult;
    property MultiLine:Boolean read FMultiLine write SetMultiLine default false;
    property NumGlyphs: TLMDNumGlyphs read GetNumGlyphs write SetNumGlyphs default 1;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property RepeatedClick: Boolean read FRepeatedClick write SetRepeatedClick default False;
    property RepeatingInterval: Word read FRepeatingInterval write SetRepeatingInterval default 100;
    property RepeatingDelay : Word read FRepeatingDelay write FRepeatingDelay default 500;
    property ShowHint;
    property TabOrder;
    property TabStop;
    // 7.0
    property UseGlobalTimer:Boolean read FUseGlobalTimer write FUseGlobalTimer default false;
    // ---
    property Visible : Boolean read GetVisible write SetVisible default true;

    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseExit: TNotifyEvent read FOnMouseExit write FOnMouseExit;
    {$IFDEF LMDCOMP14}
    property OnGesture;
    property Touch;
    {$ENDIF}
  end;

implementation
uses
  Types, Consts, Forms, TypInfo, SysUtils,
  LMDUtils, LMDGraphUtils, LMDThemes;

{************************ Class TLMDCustomButton ******************************}
{------------------------- Private --------------------------------------------}
procedure TLMDCustomButton.SetButtonLayout(aValue: TLMDButtonLayout);
begin
  FButtonLayout.Assign(aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomButton.set_CtlXP(aValue: Boolean);
begin
 if aValue <> Get_CtlXP then
   ThemeMode := LMDCtlXP[aValue];
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.SetDropDown(aValue: TPopupMenu);
begin
  if aValue<>FDropDown then
    begin
      FDropDown:=aValue;
      if FDropDown<>nil then FDropDown.FreeNotification(Self);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.SetDropDownIndent(aValue: Integer);
begin
  if aValue<>FDropDownIndent then FDropDownIndent:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.SetDropDownRight(aValue:Boolean);
begin
  if aValue<>FDropDownRight then FDropDownRight:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.SetFontFx(aValue:TLMDFxCaption);
begin
  FFontFx.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.SetGlyph(aValue: TBitmap);
begin
  if not (csLoading in ComponentState) then
    if FImageList<>nil then SetImageList(nil);
  TLMDGlyph(FGlyph).Glyph:=aValue;
  Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.SetGlyphKind(aValue:TLMDGlyphKind);
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
procedure TLMDCustomButton.SetMultiLine(aValue: Boolean);
begin
  if aValue<>FMultiLine then
    begin
      FMultiLine:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.SetNumGlyphs(aValue: TLMDNumGlyphs);
begin
  if aValue<>TLMDGlyph(FGlyph).NumGlyphs then
    begin
      TLMDGlyph(FGlyph).NumGlyphs:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.SetParentThemeMode(const Value: boolean);
begin
  if FParentThemeMode <> Value then
  begin
    FParentThemeMode := Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.SetVisible(aValue : Boolean);
begin
  if aValue = false then
    begin
      FMouseOver := false;
      FreeTimer;
    end;
  inherited Visible := aValue;
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.GetVisible : Boolean;
begin
  result := inherited Visible;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.SetRepeatedClick(aValue: Boolean);
begin
  if aValue<>FRepeatedClick then
    begin
      FRepeatedClick:=aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.SetRepeatingInterval(aValue: Word);
begin
  if aValue<>FRepeatingInterval then
    begin
      FRepeatingInterval:=aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.SetStyle(aValue:TLMDNormalButtonStyle);
begin
  ExtStyle := TLMDUserButtonStyle (Ord (aValue));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.SetThemeGlobalMode(const Value: Boolean);
begin
    if FThemeGlobalMode <> Value then
    begin
      FThemeGlobalMode := Value;
      DoThemeChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.SetThemeMode(const Value: TLMDThemeMode);
begin
  if (FThemeMode <> Value) then
    begin
      FThemeMode := Value;
      if not FThemeGlobalMode then       // if we are in GlobalThemeMode, no update required
        DoThemeChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.SetExtStyle(aValue:TLMDUserButtonStyle);
begin
  if aValue<>FExtStyle then
    begin
       if aValue in [ubsExplorer, ubsNavigator, ubsFlatUnColored] then
        TLMDGlyph(FGlyph).Style:=gsExplorer
       else
         TLMDGlyph(FGlyph).Style:=gsStandard;
      FExtStyle:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.SetImageList(aValue:TCustomImageList);
begin
  if FImageList<>nil then
    FImageList.UnRegisterChanges(FChangeLink);
  FImageList:=aValue;
  if FImageList<>nil then
    begin
      FImageList.RegisterChanges(FChangeLink);
      FImageList.FreeNotification(Self);
    end;
  GetIMLChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.SetIndex(index, aValue:Integer);
begin
  case index of
    0: if (aValue=FIndex) or (aValue<0) then exit else FIndex:=aValue;
    1: if (aValue=FListIndex) or (aValue<0) then exit else FListIndex:=aValue;
  end;
  if FImageList<>nil then GetIMLChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.SetUseCaption(aValue: Boolean);
begin
  if aValue<>FUseCaption then
    begin
      FUseCaption:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.ReadIdent(Reader:TReader);
begin
  SetImageList(LMDReadGlobalIdent(Reader));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.WriteIdent(Writer:TWriter);
begin
  LMDWriteGlobalIdent(Writer, FImageList);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.ReadStyle(Reader:TReader);
var
  s: String;
  i: TLMDNormalButtonStyle;
begin
  s := Reader.ReadIdent;
  if s='nbsAutoDetect' then
    FExtStyle:=ubsWin40
  else
    for i := Low(TLMDNormalButtonStyle) to High(TLMDNormalButtonStyle) do
      if s = TLMDNormalBtnStyleString[i] then
        FExtStyle := TLMDUserButtonStyle (Ord(i));
end;

// 7.0
{------------------------------------------------------------------------------}
procedure TLMDCustomButton.ReadExtStyle(Reader: TReader);
var
  tmp:Boolean;
begin
  tmp:=CtlXP;
  LMDButtonReadExtStyle(Reader, FExtStyle, tmp);
  if tmp<>CtlXP then
    CtlXP:=tmp;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.ReadCtlXP(Reader: TReader);
begin
  Set_CtlXP(Reader.ReadBoolean);
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.CheckCont:Boolean;
begin
  result:=LMDIsGlobalIdent(FImageList);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.GetIMLChange(Sender:TObject);
var
  tmp:TBitmap;
begin
  if FGlyphKind<>gkCustom then exit;
  if not IMLEmpty then
    begin
      tmp:=TBitmap.Create;
      try
        LMDIMLItemBitmap(ImageList, ListIndex, ImageIndex, tmp);
        TLMDGlyph(FGlyph).Glyph:=tmp;
      finally
        tmp.Free;
      end;
    end
  else
    TLMDGlyph(FGlyph).Glyph:=nil;
  Invalidate;
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.IMLEmpty:Boolean;
begin
  result:=not LMDIMLIsValidItem(FImageList, FListIndex, FIndex);
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.HasControl:Boolean;
begin
  result:=(FImageList<>nil) and (FImageList.Owner<>LMDContainer);
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.HasIML:Boolean;
begin
  result:=not (FImageList<>nil);
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.IsCustom:Boolean;
begin
  result:=HasIML or (FGlyphKind<>gkCustom);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.Notification(aComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if (Operation=opRemove) then
    begin
      if (aComponent=FDropDown) then FDropDown:=nil;
      if (aComponent=FImageList) then SetImageList(nil);
    end;
end ;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.RequestDefaultGlyph;
var
  tmp:TBitmap;
begin
  tmp:=TBitmap.Create;
  try
    NumGlyphs:=1;
    LMDGetGlyphKind(tmp, FGlyphKind);
    Glyph:=tmp;
  finally
    tmp.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.get_CtlXP:Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.GetCaption:string;
begin
  if FUseCaption then result:=Caption else result:='';
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.GetGlyph: TBitmap;
begin
  Result:=TLMDGlyph(FGlyph).Glyph;
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.GetNumGlyphs:TLMDNumGlyphs;
begin
  Result:=TLMDGlyph(FGlyph).NumGlyphs;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.ExecuteRepeatedClick(Sender:TObject);
begin
  if FMouseOver then DoRepeatedClick;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.CMLMDThemeChanged(var Message: TMessage);
begin
  DoThemeChanged;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if (csDesigning in ComponentState) then exit;
  if (FState=bsUp) then
    if Assigned(FOnMouseEnter) then FOnMouseEnter(self);
  if FMouseOver<>True then
    begin
      FMouseOver:=True;
      if isTransparentSet then
        Invalidate
      else
        RePaint; //invalidate for hot or flat effect
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if (csDesigning in ComponentState) then exit;
  if Assigned(FOnMouseExit) then FOnMouseExit(self);
  if FMouseOver<>False then
    begin
      FMouseOver:=False;
      FState := bsUp;
      if isTransparentSet then
        Invalidate
      else
        RePaint; //invalidate for hot or flat effect
    end;
  If FHideHint then Application.HideHint;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomButton.CNMeasureItem(var Message: TWMMeasureItem);
begin
  with Message.MeasureItemStruct^ do
    begin
      itemWidth := Width;
      itemHeight := Height;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.CNDrawItem(var Message: TWMDrawItem);
begin
  if (FGlyphKind<>gkCustom) and Glyph.Empty then
    begin
      RequestDefaultGlyph;
      exit;
    end;

  DrawItem(Message.DrawItemStruct^);

end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.CMFontChanged(var Message: TMessage);
begin
  GetChange(Font);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  Perform(WM_LBUTTONDOWN, Message.Keys, LPARAM(Integer(Message.Pos)));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.WMLButtonDown(var Message: TWMLButtonDown);
begin
  inherited;
  if not FRepeatedClick then exit;
  if Assigned(FTimerID) then exit;
  {get a global timer-id}
  FTimerID:=TLMDTimer.Create(FRepeatingDelay, ExecuteRepeatedClick, true, FUseGlobalTimer);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.WMLButtonUp(var Message: TWMLButtonUp);
begin
  inherited;
  if not FRepeatedClick then exit;
  FreeTimer;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.WMEraseBackground(var Message: TWMERASEBKGND);
begin
  if isTransparentSet then
    Message.Result := 1
  else
    inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.WMThemeChanged(var Message: TMessage);
begin
  inherited;
  {$IFDEF LMDCOMP11}if (csDesigning in ComponentState) then exit;{$ENDIF}
  DoThemeChanged;
  Message.result:=1;
end;

procedure TLMDCustomButton.WndProc(var Message: TMessage);
begin
  {$IFDEF LMDCOMP16}
  if (Message.Msg = WM_PAINT) and (UseThemeMode = ttmPlatform) and
     StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
  begin
    PaintHandler(TWMPaint(Message)); // Disable style hook drawing.
    Exit;                            //
  end;
  {$ENDIF}

  inherited;
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDCustomButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);

  procedure CopyImage(ImageList: TCustomImageList; Index: Integer);
  begin
    with Glyph do
        begin
          Width := ImageList.Width;
          Height := ImageList.Height;
          Canvas.Brush.Color := clFuchsia;
          Canvas.FillRect(Rect(0,0, Width, Height));
          ImageList.Draw(Canvas, 0, 0, Index);
        end;
  end;

begin
  inherited ActionChange(Sender, CheckDefaults);
  if FGlyphKind<>gkCustom then exit;
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
       if (Glyph.Empty) and (ActionList <> nil) and (ActionList.Images <> nil) and
         (ImageIndex >= 0) and (ImageIndex < ActionList.Images.Count) then
         CopyImage(ActionList.Images, ImageIndex)
       else
         //6.1
         if not (csLoading in ComponentState) then Glyph:=nil;

end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.BoundsChange(State:TLMDBoundsChangeStates);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do Style := Style or BS_OWNERDRAW;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty(IDS_INTERNAL, ReadIdent, WriteIdent, CheckCont);
  Filer.DefineProperty('Style', ReadStyle, nil, false);
  Filer.DefineProperty('ExtStyle', ReadExtStyle, nil, false);
  Filer.DefineProperty(IDS_CtlXP, ReadCtlXP, nil, false);
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.GetXPThemedClass:TThemedElement;
begin
  case ExtStyle of
    {ubsAutoDetect,} ubsWin31, ubsWin40, ubsDelphi, ubsIntegrated, ubsWin40Ext:
      result := teButton;
    ubsCombo:
      result := teComboBox;
    else
      result := teToolBar;
  end; //of case
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomButton.DrawCaptionAndGlyph (aCanvas: TCanvas;aRect: TRect; flags: LongInt);
begin
  TLMDGlyph(FGlyph).DrawButtonGlyphAndText(aCanvas, GetCaption, FFontFx, aRect, FState, ButtonLayout,
                                           [TLMDDrawTextStyle(Enabled), dt3DDisabled], FMultiLine, flags);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.DrawItem(const DrawItemStruct: TDrawItemStruct);
var
  IsDown, IsDefault: Boolean;
  aRect: TRect;
  tmpbl:TLMDButtonLayout;
  Flags: Longint;
  lThemeMode : TLMDThemeMode;
begin
  FCanvas.Handle := DrawItemStruct.hDC;
  try
    aRect:=ClientRect;
    with DrawItemStruct do
      begin
        IsDown:=itemState and ODS_SELECTED<>0;
        IsDefault:=itemState and ODS_FOCUS<>0;
        if not Enabled then
          FState:=bsDisabledUp
        else
          if IsDown then
            FState:=bsDown
          else
            if FMouseOver then
              FState:=bsMouseOver
            else
             FState:=bsUp;
      end;

    flags:=BDF_ROUNDED;
    if IsFocused and Enabled then
      flags:=flags or BDF_FOCUSED;
//    else
    if IsDefault then flags:=flags or BDF_DEFAULT;

    if FMouseOver then flags := flags or BDF_MOUSEOVER;

    lThemeMode := UseThemeMode;
    if lThemeMode <> ttmNone then flags:=flags or BDF_CTLXP;

    if isTransparentSet then
      if BackBitmapCheck then
        BackDrawArea (FCanvas, aRect, Point (0,0), 0)
      else
        with FCanvas do
          begin
            Brush.Color := Color;
            Brush.Style := bsSolid;
            FillRect(GetClientRect);
          end;

    LMDDrawBtnFaceExt(self, FCanvas, FMouseOver, aRect,
                      FExtStyle, FState, flags, Color, lThemeMode);

    if (FExtStyle<>ubsCombo) then
      begin
        FCanvas.Font:=Self.Font;
        FCanvas.Font.Color:=GetThemedTextColor;

        flags:=0;
        flags:=DrawTextBiDiModeFlags(flags);
        DrawCaptionAndGlyph(FCanvas, aRect, flags);
      end
    else
      if lThemeMode = ttmNone then
        begin
          tmpbl:=TLMDButtonLayout.Create;
          try
            tmpbl.Arrow := true;
            tmpbl.ArrowSize := 4;
            tmpbl.ArrowIndent := -1;
            if  FState=bsMouseOver then
              tmpbl.ArrowColor:=clHighLight;
            LMDDrawTextAndGlyph(FCanvas, '', FFontFx, aRect, nil, nil, tmpbl,
                                false, false, false, [TLMDDrawTextStyle(Enabled),
                                dt3DDisabled], flags);
          finally
            tmpbl.Free;
          end;
        end;
  finally
    {destroy handle}
    FCanvas.Handle := 0;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.DoRepeatedClick;
begin
  //after first call of this function set interval speed
  if Assigned(FTimerId) then
    FTimerId.Interval := FRepeatingInterval;
  Click;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomButton.DoThemeChanged;
begin
 if {Showing and} (ComponentState * [csLoading, csReading] = []) then
   Invalidate;
end;

{------------------------------------------------------------------------------}
Procedure TLMDCustomButton.GetChange(Sender:TObject);
begin
  if csLoading in ComponentState then exit;
  if (sender=Font) or (sender=FFontFx) then
    begin
      ParentFont:=False;
      if (FFontFx.Angle<>0) and not LMDIsTrueTypeFont(Font) then
        if Sender=Font then
          FFontFx.Angle:=0
        else
          begin
            Font.Name:=LMD_DEFAULTFONT;
            exit;
          end;
   end;
   Invalidate;
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.GetPalette: HPALETTE;
begin
  Result := Glyph.Palette;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomButton.GetState: TLMDButtonState;
begin
  result := FState;
end;

function TLMDCustomButton.GetThemedTextColor: TColor;
{$IFDEF LMDCOMP16}
const
  C_STATES: array[TLMDButtonState] of TThemedButton = (
    tbPushButtonNormal,   // bsUp
    tbPushButtonDisabled, // bsDisabledUp
    tbPushButtonHot,      // bsMouseOver
    tbPushButtonNormal,   // bsOptionSet
    tbPushButtonPressed,  // bsDown
    tbPushButtonNormal,   // bsDragOver
    tbPushButtonNormal,   // bsDropDownOpen
    tbPushButtonDisabled, // bsDisabledDown
    tbPushButtonDefaulted // bsDefaultEd
  );
var
  dtls: TThemedElementDetails;
  stt:  TLMDButtonState;
{$ENDIF}
begin
  {$IFDEF LMDCOMP16}
  if (UseThemeMode = ttmPlatform) and StyleServices.Enabled and
     TStyleManager.IsCustomStyleActive then
  begin
    stt := FState;
    if IsFocused and (stt = bsUp) then
      stt := bsDefaultEd;

    dtls := StyleServices.GetElementDetails(C_STATES[stt]);
    if not StyleServices.GetElementColor(dtls, ecTextColor, Result) then
      Result := clBtnText;
  end
  else
  {$ENDIF}
    Result := Font.Color;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.Loaded;
begin
  inherited Loaded;
  {5.0 + 7.02 fix}
  if LMDIsCollectionImageList(ImageList) or
     LMDIsGlobalIdent(ImageList) then GetIMLChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.SetButtonStyle(ADefault: Boolean);
begin
  if ADefault<>IsFocused then
    begin
      IsFocused := ADefault;
      Refresh;
    end;
end;

{ ---------------------------------------------------------------------------- }
{$ifdef LMD_UNICODE}
procedure TLMDCustomButton.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := {$IFNDEF LMDCOMP7}LMDConvertVCLHint{$ENDIF}(FHint);
end;
{$endif}

{ ---------------------------------------------------------------------------- }
function TLMDCustomButton.UseThemeMode: TLMDThemeMode;
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
function TLMDCustomButton.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.FreeTimer;
begin
  if not Assigned(FTimerID) then exit;
  FTimerId.OnTimer:=nil;
  FTimerID.Enabled:=False;
  FreeAndNil(FTimerID);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  temp:TLMDBoundsChangeStates;
  tmpR:TRect;
begin
  tmpr:=Rect(Left, Top, Width, Height);
  temp := [];
  inherited SetBounds(aLeft, aTop, aWidth, aHeight);
  with tmpr do
    begin
      if (self.Left<>Left) or (self.Top<>Top) then
        temp:=[bcPos];
      if (Width<>Right) or (Height<>Bottom) then
        temp:=temp+[bcSize];
    end;
  if (temp<>[]) and not (csLoading in ComponentState) then BoundsChange(temp);
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDCustomButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCanvas := TCanvas.Create;
  ControlStyle:=ControlStyle+[csReplicatable];
  FHideHint:=True;

  FGlyph:=TLMDGlyph.Create;
  TLMDGlyph(FGlyph).OnChange := GetChange;

  FButtonLayout:=TLMDButtonLayout.Create;
  FButtonLayout.OnChange:=GetChange;

  FChangeLink:=TChangeLink.Create;
  FChangeLink.OnChange:=GetIMLChange;
  FImageList:=nil;
  FIndex:=0;
  FListIndex:=0;

  FFontFx:=TLMDFxCaption.Create;
  FFontFx.OnChange:=GetChange;

  FDropDown := nil;
  FDropDownIndent:=0;
  FDropDownRight:=False;
  FRepeatedClick:=False;
  FRepeatingInterval:=100;
  FRepeatingDelay := 500;
  FStyle:=nbsAutoDetect;

  FExtStyle:=ubsWin40;

  FState:=bsUp;
  FTimerID:=nil;
  IsFocused:=False;
  FUseCaption:=True;
  FParentThemeMode := true;
  FThemeMode := ttmPlatForm;
  Width:=75;
  Height:=25;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomButton.Destroy;
begin
  FreeTimer; //added 22.11.

  TLMDGlyph(FGlyph).OnChange:=nil;
  FButtonLayout.OnChange:=nil;
  FFontFx.OnChange:=nil;
  FChangeLink.OnChange:=nil; //JH 05.11.

  FChangeLink.Free;
  FFontFx.Free;
  FButtonLayout.Free;
  TLMDGlyph(FGlyph).Free;

  FCanvas.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.Click;
var
  MyClick:TNotifyEvent;
begin
  if Assigned(FDropDown) and not FDropped then
    begin
      MyClick:=OnClick;
      if Assigned(MyClick) then OnClick(Self);
      DropDown;
    end
  else
    inherited Click;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.DropDown;
var
  pt:TPoint;
  tempmsg:TMsg;
begin
  if Assigned(FDropDown) and not FDropped then
    begin
      if not IsFocused then SetFocus;
      SendMessage(Handle, BM_SETSTATE, 1, 0);
      Refresh;
      FDropped:=True;
      if Assigned(FOnDropDown) then FOnDropDown(self);
      if FDropDownRight then
        begin
          pt:=ClientToScreen(Point(Width,0));
          FDropDown.Popup(pt.X,pt.Y+FDropDownIndent);
        end
      else
        begin
          pt:=ClientToScreen(Point(0,Height));
          FDropDown.Popup(pt.X+FDropDownIndent,pt.Y);
        end;
      while PeekMessage(tempMsg, Handle,WM_MOUSEFIRST,WM_MOUSELAST,PM_REMOVE) do ;
      if GetCapture<>0 then SendMessage(GetCapture,WM_CANCELMODE,0,0);
      FDropped:=False;
      FState:=bsUp;
      SendMessage(Handle, BM_SETSTATE, 0, 0);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.BackBitmap: TBitmap;
begin
  result := LMDBackBitmap (self);
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.BackBitmapCheck: Boolean;
begin
  result := LMDBackBitmapCheck (self);
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.BackDrawArea(Canvas: TCanvas; const dest: TRect; const src: TPoint; flags:Word): Boolean;
begin
  with BackMapPoint(src) do
    Canvas.CopyRect(dest, BackBitmap.Canvas, Bounds (X, Y, dest.Right-dest.Left, dest.Bottom-dest.Top));
  Result := True;
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.isTransparentSet: Boolean;
begin
  result := (FExtStyle in [ubsExplorer, ubsExplorerColored, ubsOfficeTransp]) or IsThemed;
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.BackMapPoint(const aValue: TPoint):TPoint;
begin
  result := LMDBackMapPoint (self, aValue);
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.BackBitmapPalette: HPalette;
begin
  result := LMDBackBitmapPalette(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButton.BackUpdate;
begin
  Invalidate;
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.BackControl (index: Integer): TControl;
begin
  result := nil;
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.BackControlCount: Integer;
begin
  result := 0;
end;

{------------------------------------------------------------------------------}
function TLMDCustomButton.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_TOOLS;
end;

end.
