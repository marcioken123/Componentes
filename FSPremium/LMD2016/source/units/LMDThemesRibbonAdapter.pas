unit LMDThemesRibbonAdapter;
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

LMDThemesRibbonAdapter unit (VB)
--------------------------------

ToDo
----


Changes
-------
Release 11.3 (Feb 2011)
 - Initial Release

###############################################################################}

interface

{$IFDEF _LMD_THEMESRIBBONIMPL}

uses
  ActnMan, Classes, Messages, Windows, RibbonStyleActnCtrls, Graphics, Ribbon,
  LMDWndProcComponent, LMDThemesGradientThemeBase;

type
  TLMDCustomizedRibbonElements = set of TRibbonElement;

  TLMDThemesRibbonAdapter = class(TLMDWndProcComponent)
  private
    FSkinTabFill: array[TSkinTab] of TLMDGradientThemeFillDescriptor;
    FSkinTabFrame: array[TSkinTab] of TLMDGradientThemeFrameDescriptor;
    FSkinBtnFill:  array[TSkinButton] of TLMDGradientThemeFillDescriptor;
    FSkinBtnFrame: array[TSkinButton] of TLMDGradientThemeFrameDescriptor;
    FSkinRibbonGroupFill: array[TSkinRibbonGroup] of TLMDGradientThemeFillDescriptor;
    FSkinRibbonGroupFrame: array[TSkinRibbonGroup] of TLMDGradientThemeFrameDescriptor;

    FSkinRibbonFill : array[TSkinRibbon] of TLMDGradientThemeFillDescriptor;
    FSkinRibbonFrame: array[TSkinRibbon] of TLMDGradientThemeFrameDescriptor;
    FCustomizedElements: TLMDCustomizedRibbonElements;

    FOnBeforeLoadSkin: TNotifyEvent;

    function GetSkinBtnFill(
      index: TSkinButton): TLMDGradientThemeFillDescriptor;
    function GetSkinBtnFrame(
      index: TSkinButton): TLMDGradientThemeFrameDescriptor;
    procedure SetSkinBtnFill(index: TSkinButton;
      const Value: TLMDGradientThemeFillDescriptor);
    procedure SetSkinBtnFrame(index: TSkinButton;
      const Value: TLMDGradientThemeFrameDescriptor);
    function GetSkinTabFill(index: TSkinTab): TLMDGradientThemeFillDescriptor;
    procedure SetSkinTabFill(index: TSkinTab;
      const Value: TLMDGradientThemeFillDescriptor);
    function GetSkinTabFrame(index: TSkinTab): TLMDGradientThemeFrameDescriptor;
    procedure SetSkinTabFrame(index: TSkinTab;
      const Value: TLMDGradientThemeFrameDescriptor);
    function GetSkinRibbonGroupFill(
      index: TSkinRibbonGroup): TLMDGradientThemeFillDescriptor;
    function GetSkinRibbonGroupFrame(
      index: TSkinRibbonGroup): TLMDGradientThemeFrameDescriptor;
    procedure SetSkinRibbonGroupFill(index: TSkinRibbonGroup;
      const Value: TLMDGradientThemeFillDescriptor);
    procedure SetSkinRibbonGroupFrame(index: TSkinRibbonGroup;
      const Value: TLMDGradientThemeFrameDescriptor);
    function GetSkinRibbonFill(
      index: TSkinRibbon): TLMDGradientThemeFillDescriptor;
    function GetSkinRibbonFrame(
      index: TSkinRibbon): TLMDGradientThemeFrameDescriptor;
    procedure SetSkinRibbonFill(index: TSkinRibbon;
      const Value: TLMDGradientThemeFillDescriptor);
    procedure SetSkinRibbonFrame(index: TSkinRibbon;
      const Value: TLMDGradientThemeFrameDescriptor);
    procedure SetCustomizedElements(const Value: TLMDCustomizedRibbonElements);
  protected
    procedure WndProc(var Message: TMessage);override;
    procedure RegisterAdapter; virtual;
    procedure UnregisterAdapter; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(aOwner:TComponent);override;
    destructor Destroy; override;
    procedure DoThemeChange; virtual;
    procedure ResetDescriptors; virtual;
    procedure ClearDescriptors; virtual;

    procedure Loaded; override;
    property SkinBtnFill[index: TSkinButton]: TLMDGradientThemeFillDescriptor read GetSkinBtnFill write SetSkinBtnFill;
    property SkinBtnFrame[index: TSkinButton]: TLMDGradientThemeFrameDescriptor read GetSkinBtnFrame write SetSkinBtnFrame;
    property SkinTabFill[ index: TSkinTab]: TLMDGradientThemeFillDescriptor read GetSkinTabFill write SetSkinTabFill;
    property SkinTabFrame[index: TSkinTab]: TLMDGradientThemeFrameDescriptor read GetSkinTabFrame write SetSkinTabFrame;
    property SkinRibbonGroupFill[ index: TSkinRibbonGroup]: TLMDGradientThemeFillDescriptor read GetSkinRibbonGroupFill write SetSkinRibbonGroupFill;
    property SkinRibbonGroupFrame[index: TSkinRibbonGroup]: TLMDGradientThemeFrameDescriptor read GetSkinRibbonGroupFrame write SetSkinRibbonGroupFrame;
    property SkinRibbonFill[ index: TSkinRibbon]: TLMDGradientThemeFillDescriptor  read GetSkinRibbonFill write  SetSkinRibbonFill;
    property SkinRibbonFrame[index: TSkinRibbon]: TLMDGradientThemeFrameDescriptor read GetSkinRibbonFrame write SetSkinRibbonFrame;
  published
    property Enabled;
    property CustomizedElements: TLMDCustomizedRibbonElements read FCustomizedElements write SetCustomizedElements;
    property OnBeforeLoadSkin: TNotifyEvent read FOnBeforeLoadSkin write FOnBeforeLoadSkin;
  end;


  TLMDRibbonStyleActionBars = class(TRibbonStyleActionBars)
  public
    function GetColorMapClass(ActionBar: TCustomActionBar): TCustomColorMapClass; override;
    function GetSkinClass: TCustomRibbonSkinClass; override;
    function GetStyleName: string; override;
  end;

  TLMDRibbonSkin = class(TCustomRibbonSkin)
  public
    function GetLoadTypeValue: string; override;
    function GetLoadType: TCustomRibbonSkin.TRibbonSkinLoadType; override;
    procedure LoadSkin; override;
  end;

  TLMDRibbonColorMap = class(TCustomRibbonColorMap)
  public
    procedure UpdateColors; override;
  published
    property BevelMinimizedInner default clGray;
    property BevelMinimizedOuter default $00EBE1DC;
    property BtnSelectedFont default $006E1500;
    property CaptionFontColor default $00AA6A3E;
    property ControlColor default clWindow;
    property ControlInactiveColor default $00ECEAE8;
    property ControlFrameColor default $00898989;
    property DisabledFontColor default $008D8D8D;
    property DocumentFontColor default $00797069;
    property FontColor default clBlack;
    property HighlightColor default $006E1500;
    property ActiveTabFontColor default $005C534C;
    property GroupFontColor default $00595453;
    property InactiveTabFontColor default $005C534C;
    property QuickAccessToolbarMoreColor default $00E4DADB;
    property QuickAccessToolbarMoreBorderColor default $0099797A;
  end;

var
  LMDRibbonStyle: TLMDRibbonStyleActionBars;
  LMDRibbonStyleAdapter: TLMDThemesRibbonAdapter;

{$ENDIF}

implementation

{$IFDEF _LMD_THEMESRIBBONIMPL}

uses
  ActnMenus, SysUtils, Themes, LMDProcs, LMDClass, LMDThemes,
  LMDThemesCommonTypes, LMDFillers, LMDFigures, LMDGradientframes,
  LMDThemesGradientThemeRenderer;

{----------------------- TLMDRibbonStyleActionBars ----------------------------}
function TLMDRibbonStyleActionBars.GetColorMapClass(
  ActionBar: TCustomActionBar): TCustomColorMapClass;
begin
  Result := TLMDRibbonColorMap;
end;

{------------------------------------------------------------------------------}
function TLMDRibbonStyleActionBars.GetSkinClass: TCustomRibbonSkinClass;
begin
  Result := TLMDRibbonSkin;
end;

{------------------------------------------------------------------------------}
function TLMDRibbonStyleActionBars.GetStyleName: string;
begin
  Result := 'Ribbon - LMD';
end;

{-------------------- TLMDRibbonSkin ------------------------------------------}
function TLMDRibbonSkin.GetLoadType: TCustomRibbonSkin.TRibbonSkinLoadType;
begin
  if ActionBarDesigner <> nil then
    Exit(ltResource)
  else
    Result := ltResource;//ltFile
end;

{------------------------------------------------------------------------------}
function TLMDRibbonSkin.GetLoadTypeValue: string;
begin
  case GetLoadType of
    ltResource: Result := 'RIBBON_LUNA';
    ltFile: Result := ExtractFilePath(ParamStr(0)) + 'luna.bmp';
  end;
  if Assigned(LMDGradientThemeRenderer) then
  begin
    if (LMDGradientThemeRenderer.ActiveColorSchemeName = 'Silver') or
       (LMDGradientThemeRenderer.ActiveColorSchemeName = 'Metallic') then
    case GetLoadType of
      ltResource: Result := 'RIBBON_SILVER';
      ltFile: Result := ExtractFilePath(ParamStr(0)) + 'silver.bmp';
    end;
    if (LMDGradientThemeRenderer.ActiveColorSchemeName = 'Black') then
    case GetLoadType of
      ltResource: Result := 'RIBBON_OBSIDIAN';
      ltFile: Result := ExtractFilePath(ParamStr(0)) + 'obsidian.bmp';
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRibbonSkin.LoadSkin;
var
  R: TRect;
  LOffSet: integer;
  lFillD: TLMDGradientThemeFillDescriptor;
  lFrameD: TLMDGradientThemeFrameDescriptor;
  lOldSU, lOldUC: boolean;

  procedure DrawSkinButton(sb: TSkinButton);
  begin
    InflateRect(R, 1, 1);
    with LMDGradientThemeRenderer, LMDRibbonStyleAdapter do
    begin
      lFillD := ButtonFill[tbPushButtonHot];
      lFrameD := ButtonFrame[tbPushButtonHot];
      ButtonFill[tbPushButtonHot] := SkinBtnFill[sb];
      ButtonFrame[tbPushButtonHot] := SkinBtnFrame[sb];
      LMDGradientThemeRenderer.DrawElement(Bitmap.Canvas.Handle, tbPushButtonHot, R);
      ButtonFill[tbPushButtonHot]  := lFillD;
      ButtonFrame[tbPushButtonHot] := lFrameD;
    end;
  end;

  procedure DrawSkinTab(st: TSkinTab);
  begin
    InflateRect(R, -1, 0);
    with LMDGradientThemeRenderer, LMDRibbonStyleAdapter do
    begin
      lFillD := TabFill[ttTopTabItemHot];
      lFrameD := TabFrame[ttTopTabItemHot];
      TabFill[ttTopTabItemHot] := SkinTabFill[st];
      TabFrame[ttTopTabItemHot] := SkinTabFrame[st];
      LMDGradientThemeRenderer.DrawElement(Bitmap.Canvas.Handle, ttTopTabItemHot, R);
      TabFill[ttTopTabItemHot]  := lFillD;
      TabFrame[ttTopTabItemHot] := lFrameD;
    end;
  end;

  procedure DrawSkinRibbonGroup(srg: TSkinRibbonGroup);
  begin
    InflateRect(R, 1, 1);
    with LMDGradientThemeRenderer, LMDRibbonStyleAdapter do
    begin
      lFillD := ButtonFill[tbPushButtonHot];
      lFrameD := ButtonFrame[tbPushButtonHot];
      ButtonFill[tbPushButtonHot] := SkinRibbonGroupFill[srg];
      ButtonFrame[tbPushButtonHot] := SkinRibbonGroupFrame[srg];
      LMDGradientThemeRenderer.DrawElement(Bitmap.Canvas.Handle, tbPushButtonHot, R);
      ButtonFill[tbPushButtonHot]  := lFillD;
      ButtonFrame[tbPushButtonHot] := lFrameD;
    end;
  end;

  procedure DrawSkinRibbon(srg: TSkinRibbon);
  begin
    InflateRect(R, 1, 1);
    with LMDGradientThemeRenderer, LMDRibbonStyleAdapter do
    begin
      lFillD := ToolbarFill[ttbToolBarRoot];
      lFrameD := ToolbarFrame[ttbToolBarRoot];
      ToolbarFill[ttbToolBarRoot] := SkinRibbonFill[srg];
      ToolbarFrame[ttbToolBarRoot] := SkinRibbonFrame[srg];
      LMDGradientThemeRenderer.DrawElement(Bitmap.Canvas.Handle, ttbToolBarRoot, R);
      ToolbarFill[ttbToolBarRoot] := lFillD;
      ToolbarFrame[ttbToolBarRoot] := lFrameD;
    end;
  end;


begin
  inherited;

  if Assigned(LMDGradientThemeRenderer) and Assigned(LMDRibbonStyleAdapter) and LMDRibbonStyleAdapter.Enabled then
    with LMDGradientThemeRenderer, LMDRibbonStyleAdapter do
    begin
      lOldSU := SuppressUpdate;
      lOldUC := UseCache;

      UseCache := false;
      SuppressUpdate := true;
      PixelFormat := pf32bit;

      //------------------------- SkinButton ---------------------------------//
      if reButton in CustomizedElements then
      begin
        LOffSet := 66;
        //sbLargeHover
        R := Rect(151, 207, 151 + 50, 207 + LOffset);
        DrawSkinButton(sbLargeHover);

        //sbLargePressed
        R := Rect(101, 207 + LOffset, 101 + 50, 207 + (2 * LOffset));
        DrawSkinButton(sbLargePressed);

        //sbLargeSelected
        R := Rect(151, 207 + LOffSet, 151 + 50, 207 + (2 * LOffSet));
        DrawSkinButton(sbLargeSelected);

        //sbLargeHoverSelected
        R := Rect(101, 207 + (2 * LOffSet), 101 + 50, 207 + (3 * LOffSet));
        DrawSkinButton(sbLargeHoverSelected);

        LOffSet := 22;
        //sbSmallHover
        R := Rect(99, LOffSet, 99 + 100, 2 * LOffSet);
        DrawSkinButton(sbSmallHover);

        //sbSmallPressed
        R := Rect(99, 2 * LOffSet, 99 + 100, 3 * LOffSet);
        DrawSkinButton(sbSmallPressed);

        //sbSmallSelected
        R := Rect(99, 3 * LOffSet, 99 + 100, 4 * LOffSet);
        DrawSkinButton(sbSmallSelected);

        //sbSmallHoverSelected
        R := Rect(99, 4 * LOffSet, 99 + 100, 5 * LOffSet);
        DrawSkinButton(sbSmallHoverSelected);
      end;

      //------------------------- SkinTab ------------------------------------//
      if reTab in CustomizedElements then
      begin
        R := Rect(275, 344, 369+6, 344+23);
        DrawSkinTab(stHoverSelected);

        R := Rect(275, 294, 369+6, 344+23);
        DrawSkinTab(stNormal);

        R := Rect(275, 319, 369+6, 319+22);
        DrawSkinTab(stHover);
      end;

      //------------------------- TSkinRibbonGroup ---------------------------//
      if reGroup in CustomizedElements then
      begin
        R := Rect(225, 504, 225 + 20, 504 + 86);
        DrawSkinRibbonGroup(srgBackGround);

        R := Rect(204, 504, 204 + 20, 504 + 86);
        DrawSkinRibbonGroup(srgBackGroundHover);
      end;

      //------------------------- TSkinRibbon/Page ---------------------------//
      if reRibbon in CustomizedElements then
      begin
        R := Rect(181, 497, 181 + 20, 497 + 91);
        DrawSkinRibbon(srPage);
      end;


      PixelFormat := pf24bit;
      UseCache := lOldUC;
      SuppressUpdate := lOldSU;
    end;
end;

{----------------------- TLMDRibbonColorMap -----------------------------------}
procedure TLMDRibbonColorMap.UpdateColors;
begin
  inherited;
  if Assigned(LMDGradientThemeRenderer) then
  begin
    if (LMDGradientThemeRenderer.ActiveColorSchemeName = 'Silver') or
       (LMDGradientThemeRenderer.ActiveColorSchemeName = 'Metallic') then
    begin
      BevelMinimizedInner := clGray;
      BevelMinimizedOuter := $00EBE1DC;
      BtnSelectedFont := $006E1500;
      CaptionFontColor := $00AA6A3E;
      ControlColor := clWindow;
      ControlInactiveColor := $00ECEAE8;
      ControlFrameColor := $00898989;
      DisabledFontColor := $008D8D8D;
      DocumentFontColor := $00797069;
      FontColor := clBlack;
      HighlightColor := $006E1500;
      ActiveTabFontColor := $005C534C;
      GroupFontColor := $00595453;
      InactiveTabFontColor := $005C534C;
      QuickAccessToolbarMoreColor := $00E4DADB;
      QuickAccessToolbarMoreBorderColor := $0099797A;
    end;
    if (LMDGradientThemeRenderer.ActiveColorSchemeName = 'Black') then
    begin
      BevelMinimizedInner := $004F4F4F;
      BevelMinimizedOuter := $00626262;
      BtnSelectedFont := $006E1500;
      CaptionFontColor := $00AA6A3E;
      ControlColor := clWindow;
      ControlInactiveColor := $00E8E8E8;
      ControlFrameColor := $00898989;
      DisabledFontColor := $00A7A7A7;
      DocumentFontColor := $00797069;
      FontColor := clBlack;
      HighlightColor := $006E1500;
      ActiveTabFontColor := clBlack;
      InactiveTabFontColor := clWhite;
      GroupFontColor := clWhite;
      QuickAccessToolbarMoreColor := $008E8076;
      QuickAccessToolbarMoreBorderColor := $00433C37;
    end;
  end;
end;

{------------------- TLMDThemesRibbonAdapter -----------------------------}
procedure TLMDThemesRibbonAdapter.ClearDescriptors;
var
  sb: TSkinButton;
  st: TSkinTab;
  srg: TSkinRibbonGroup;
  sr: TSkinRibbon;
begin
  if Assigned(LMDGradientThemeRenderer) then
    with LMDGradientThemeRenderer do
    begin
      for sb := low(TSkinButton) to high(TSkinButton) do
      begin
        ClearDescriptorFillers(FSkinBtnFill[sb]);
        ClearDescriptorFillers(FSkinBtnFrame[sb]);
      end;
      for st := low(TSkinTab) to high(TSkinTab) do
      begin
        ClearDescriptorFillers(FSkinTabFill[st]);
        ClearDescriptorFillers(FSkinTabFrame[st]);
      end;
      for srg := low(TSkinRibbonGroup) to high(TSkinRibbonGroup) do
      begin
        ClearDescriptorFillers(FSkinRibbonGroupFill[srg]);
        ClearDescriptorFillers(FSkinRibbonGroupFrame[srg]);
      end;
      for sr := low(TSkinRibbon) to high(TSkinRibbon) do
      begin
        ClearDescriptorFillers(FSkinRibbonFill[sr]);
        ClearDescriptorFillers(FSkinRibbonFrame[sr]);
      end;
    end;
end;

constructor TLMDThemesRibbonAdapter.Create(aOwner: TComponent);
begin
  if Assigned(LMDRibbonStyleAdapter) then
    raise ELMDOneInstError.Create(self.ClassName, 0)
  else
  begin
    inherited;
    Enabled := true;
    FCustomizedElements := [reRibbon, reTab, reGroup, reButton];
  end;
end;

{------------------------------------------------------------------------------}
destructor TLMDThemesRibbonAdapter.Destroy;
begin
  ClearDescriptors;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemesRibbonAdapter.DoThemeChange;
begin
  if Assigned(LMDGradientThemeRenderer) then
    with LMDGradientThemeRenderer do
    begin
      ResetDescriptors;
      if Assigned(OnBeforeLoadSkin) then
        OnBeforeLoadSkin(Self);
      LMDRibbonStyle.RibbonSkin.LoadSkin;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDThemesRibbonAdapter.GetSkinBtnFill(
  index: TSkinButton): TLMDGradientThemeFillDescriptor;
begin
  result := FSkinBtnFill[index];
end;

{------------------------------------------------------------------------------}
function TLMDThemesRibbonAdapter.GetSkinBtnFrame(
  index: TSkinButton): TLMDGradientThemeFrameDescriptor;
begin
  result := FSkinBtnFrame[index];
end;

{------------------------------------------------------------------------------}
function TLMDThemesRibbonAdapter.GetSkinRibbonFill(
  index: TSkinRibbon): TLMDGradientThemeFillDescriptor;
begin
  result := FSkinRibbonFill[index];
end;

function TLMDThemesRibbonAdapter.GetSkinRibbonFrame(
  index: TSkinRibbon): TLMDGradientThemeFrameDescriptor;
begin
  result := FSkinRibbonFrame[index];
end;

function TLMDThemesRibbonAdapter.GetSkinRibbonGroupFill(
  index: TSkinRibbonGroup): TLMDGradientThemeFillDescriptor;
begin
  result := FSkinRibbonGroupFill[index];
end;

{------------------------------------------------------------------------------}
function TLMDThemesRibbonAdapter.GetSkinRibbonGroupFrame(
  index: TSkinRibbonGroup): TLMDGradientThemeFrameDescriptor;
begin
  result := FSkinRibbonGroupFrame[index];
end;

{------------------------------------------------------------------------------}
function TLMDThemesRibbonAdapter.GetSkinTabFill(
  index: TSkinTab): TLMDGradientThemeFillDescriptor;
begin
  result := FSkinTabFill[index];
end;

{------------------------------------------------------------------------------}
function TLMDThemesRibbonAdapter.GetSkinTabFrame(
  index: TSkinTab): TLMDGradientThemeFrameDescriptor;
begin
  result := FSkinTabFrame[index];
end;

{------------------------------------------------------------------------------}
procedure TLMDThemesRibbonAdapter.Loaded;
begin
  inherited;
  DoThemeChange;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemesRibbonAdapter.ResetDescriptors;
var
  lSrcFD: TLMDGradientThemeFillDescriptor;
  lSrcFrD: TLMDGradientThemeFrameDescriptor;
  lf: TLMDFiller;
  R: TRect;
  sb: TSKinButton;

  procedure CloneButtonDescr(sbDst: TSkinButton; tbSrc: TThemedButton);
  begin
    with LMDGradientThemeRenderer do
    begin
      lSrcFD := ButtonFill[tbSrc];
      lSrcFrD := ButtonFrame[tbSrc];
      CloneDescriptor(FSkinBtnFill[sbDst], lSrcFD);
      CloneDescriptor(FSkinBtnFrame[sbDst], lSrcFrD);
    end;
  end;

  procedure CloneTabDescr(stDst: TSkinTab; ttSrc: TThemedTab);
  begin
    with LMDGradientThemeRenderer do
    begin
      lSrcFD := TabFill[ttSrc];
      lSrcFrD := TabFrame[ttSrc];
      CloneDescriptor(FSkinTabFill[stDst], lSrcFD);
      CloneDescriptor(FSkinTabFrame[stDst], lSrcFrD);
    end;
  end;

  procedure CloneRibbonDescr(stDst: TSkinRibbon; ttSrc: TThemedToolbar);
  begin
    with LMDGradientThemeRenderer do
    begin
      lSrcFD := ToolbarFill[ttSrc];
      lSrcFrD := ToolbarFrame[ttSrc];
      CloneDescriptor(FSkinRibbonFill[stDst], lSrcFD);
      CloneDescriptor(FSkinRibbonFrame[stDst], lSrcFrD);
    end;
  end;

  procedure ChangeFillBrightness(aFillDescr: TLMDGradientThemeFillDescriptor; aPercent: integer);
  var
    flp: TLMDGradientFillPart;
  begin
    for flp := low(TLMDGradientFillPart) to high(TLMDGradientFillPart) do
      if aFillDescr.Fillers[flp] <> nil then
        aFillDescr.Fillers[flp].ChangeColorBrightness(aPercent);
  end;

  procedure ChangeFrameBrightness(aFrameDescr: TLMDGradientThemeFrameDescriptor; aPercent: integer);
  var
    frp: TLMDGradientSimpleFramePartKind;
  begin
    for frp := low(TLMDGradientSimpleFramePartKind) to high(TLMDGradientSimpleFramePartKind) do
      if aFrameDescr.Fillers[frp] <> nil then
        aFrameDescr.Fillers[frp].ChangeColorBrightness(aPercent);
  end;

  procedure AdjustCompositeFiller(aFiller: TLMDFiller; aValue: byte);
  begin
    R := TLMDCompositeFiller(aFiller).FillerRect[0];
    R.Bottom := 30;
    TLMDCompositeFiller(aFiller).FillerRect[0] := R;
    R := TLMDCompositeFiller(aFiller).FillerRect[1];
    R.Top := 30;
    TLMDCompositeFiller(aFiller).FillerRect[1] := R;
  end;

begin
  if Assigned(LMDGradientThemeRenderer) then
    with LMDGradientThemeRenderer do
    begin
      ClearDescriptors;
      //--------------------- SkinButton -------------------------------------//
      sb := sbLargeHover;
      CloneButtonDescr(sb, tbPushButtonHot);
      if SkinBtnFill[sb].Fillers[gfpMain] is TLMDCompositeFiller then
        AdjustCompositeFiller(SkinBtnFill[sb].Fillers[gfpMain], 30);

      sb := sbLargePressed;
      CloneButtonDescr(sb, tbPushButtonPressed);
      if SkinBtnFill[sb].Fillers[gfpMain] is TLMDCompositeFiller then
        AdjustCompositeFiller(SkinBtnFill[sb].Fillers[gfpMain], 30);

      sb := sbLargeSelected;
      CloneButtonDescr(sbLargeSelected, tbPushButtonPressed);
      if SkinBtnFill[sb].Fillers[gfpMain] is TLMDCompositeFiller then
        AdjustCompositeFiller(SkinBtnFill[sb].Fillers[gfpMain], 30);

      sb := sbLargeHoverSelected;
      CloneButtonDescr(sbLargeHoverSelected, tbPushButtonPressed);
      if SkinBtnFill[sb].Fillers[gfpMain] is TLMDCompositeFiller then
        AdjustCompositeFiller(SkinBtnFill[sb].Fillers[gfpMain], 30);

      ChangeFillBrightness(SkinBtnFill[sb], -30);
      ChangeFrameBrightness(SkinBtnFrame[sb], -30);

      CloneButtonDescr(sbSmallHover, tbPushButtonHot);
      CloneButtonDescr(sbSmallPressed, tbPushButtonPressed);
      CloneButtonDescr(sbSmallSelected, tbPushButtonPressed);
      CloneButtonDescr(sbSmallHoverSelected, tbPushButtonPressed);
      ChangeFillBrightness(SkinBtnFill[sbSmallHoverSelected], -30);
      ChangeFrameBrightness(SkinBtnFrame[sbSmallHoverSelected], -30);

      //----------------- SkinTab --------------------------------------------//
      CloneTabDescr(stNormal, ttTopTabItemNormal);
      CloneTabDescr(stHover, ttTopTabItemHot);
      CloneTabDescr(stHoverSelected, ttTopTabItemSelected);
      CloneTabDescr(stHoverUnselected, ttTopTabItemSelected);

      //----------------- SkinRibbonGroup ------------------------------------//
      lSrcFrD := ToolBarFrame[ttbToolBarRoot];
      CloneDescriptor(FSkinRibbonGroupFrame[srgBackGround], lSrcFrD);
      CloneDescriptor(FSkinRibbonGroupFrame[srgBackGroundHover], lSrcFrD);
      FSkinRibbonGroupFrame[srgBackGround].Params[gfrpInnerBorderWidth] := 0;
      FSkinRibbonGroupFrame[srgBackGroundHover].Params[gfrpInnerBorderWidth] := 0;
      FSkinRibbonGroupFrame[srgBackGround].Params[gfrpOuterBorderInnerCutX] := 0;
      FSkinRibbonGroupFrame[srgBackGround].Params[gfrpOuterBorderInnerCutY] := 0;
      FSkinRibbonGroupFrame[srgBackGroundHover].Params[gfrpOuterBorderInnerCutX] := 0;
      FSkinRibbonGroupFrame[srgBackGroundHover].Params[gfrpOuterBorderInnerCutY] := 0;

      //srgBackground
      lf := TLMDCompositeFiller.Create;
      TLMDCompositeFiller(lf).UseRelativeUnits := true;
      TLMDCompositeFiller(lf).Add(TLMDVerticalGradient.Create);
      TLMDCompositeFiller(lf).Add(TLMDVerticalGradient.Create);
      TLMDCompositeFiller(lf).Add(TLMDVerticalGradient.Create);
      TLMDCompositeFiller(lf).Item[0].ColorCount := 2;
      TLMDCompositeFiller(lf).Item[1].ColorCount := 2;
      TLMDCompositeFiller(lf).Item[2].ColorCount := 2;
      if  ActiveColorSchemeName = 'Blue' then
      begin
        TLMDCompositeFiller(lf).Item[0].FixedColors[0] := $00F3E2D7;
        TLMDCompositeFiller(lf).Item[0].FixedColors[1] := $00EFDDCF;
        TLMDCompositeFiller(lf).Item[1].FixedColors[0] := $00EDD9C9;
        TLMDCompositeFiller(lf).Item[1].FixedColors[1] := $00F5E8D8;
        TLMDCompositeFiller(lf).Item[2].FixedColors[0] := $00F1D8C2;
        TLMDCompositeFiller(lf).Item[2].FixedColors[1] := $00F1D8C2;
      end;
      if (ActiveColorSchemeName = 'Silver') or (ActiveColorSchemeName = 'Metallic') then
      begin
        TLMDCompositeFiller(lf).Item[0].FixedColors[0] := $00F6F2EF;
        TLMDCompositeFiller(lf).Item[0].FixedColors[1] := $00EEE6E1;
        TLMDCompositeFiller(lf).Item[1].FixedColors[0] := $00E7DBD5;
        TLMDCompositeFiller(lf).Item[1].FixedColors[1] := $00F4F4EE;
        TLMDCompositeFiller(lf).Item[2].FixedColors[0] := $00EFE3DF;
        TLMDCompositeFiller(lf).Item[2].FixedColors[1] := $00D3C9C5;
      end;
      if  ActiveColorSchemeName = 'Black' then
      begin
        TLMDCompositeFiller(lf).Item[0].FixedColors[0] := $00D9D2CE;
        TLMDCompositeFiller(lf).Item[0].FixedColors[1] := $00CFC6C1;
        TLMDCompositeFiller(lf).Item[1].FixedColors[0] := $00C5BBB4;
        TLMDCompositeFiller(lf).Item[1].FixedColors[1] := $00EBEBE5;
        TLMDCompositeFiller(lf).Item[2].FixedColors[0] := $00B8B8B6;
        TLMDCompositeFiller(lf).Item[2].FixedColors[1] := $00A0A09E;
      end;

      TLMDCompositeFiller(lf).FillerRect[0] := Rect(0,0,100,16);
      TLMDCompositeFiller(lf).FillerRect[1] := Rect(0,16,100,84);
      TLMDCompositeFiller(lf).FillerRect[2] := Rect(0,84,100,100);

      FSkinRibbonGroupFill[srgBackGround].Fillers[gfpMain] := lf;

      //srgBackgroundHover
      lf := TLMDCompositeFiller.Create;
      TLMDCompositeFiller(lf).UseRelativeUnits := true;
      TLMDCompositeFiller(lf).Add(TLMDVerticalGradient.Create);
      TLMDCompositeFiller(lf).Add(TLMDVerticalGradient.Create);
      TLMDCompositeFiller(lf).Add(TLMDVerticalGradient.Create);
      TLMDCompositeFiller(lf).Item[0].ColorCount := 2;
      TLMDCompositeFiller(lf).Item[1].ColorCount := 2;
      TLMDCompositeFiller(lf).Item[2].ColorCount := 2;
      if  ActiveColorSchemeName = 'Blue' then
      begin
        TLMDCompositeFiller(lf).Item[0].FixedColors[0] := $00FDEFE4;
        TLMDCompositeFiller(lf).Item[0].FixedColors[1] := $00FCF0E8;
        TLMDCompositeFiller(lf).Item[1].FixedColors[0] := $00FBEADC;
        TLMDCompositeFiller(lf).Item[1].FixedColors[1] := $00F8E8DC;
        TLMDCompositeFiller(lf).Item[2].FixedColors[0] := $00FFE0C8;
        TLMDCompositeFiller(lf).Item[2].FixedColors[1] := $00FFE8D1;
      end;
      if (ActiveColorSchemeName = 'Silver') or (ActiveColorSchemeName = 'Metallic') then
      begin
        TLMDCompositeFiller(lf).Item[0].FixedColors[0] := $00FBF9F8;
        TLMDCompositeFiller(lf).Item[0].FixedColors[1] := $00F7F4F3;
        TLMDCompositeFiller(lf).Item[1].FixedColors[0] := $00F5F0EE;
        TLMDCompositeFiller(lf).Item[1].FixedColors[1] := $00F9F9F7;
        TLMDCompositeFiller(lf).Item[2].FixedColors[0] := $00EEE2DE;
        TLMDCompositeFiller(lf).Item[2].FixedColors[1] := $00CABCB6;
      end;
      if (ActiveColorSchemeName = 'Black') then
      begin
        TLMDCompositeFiller(lf).Item[0].FixedColors[0] := $00F1EFED;
        TLMDCompositeFiller(lf).Item[0].FixedColors[1] := $00ECE9E7;
        TLMDCompositeFiller(lf).Item[1].FixedColors[0] := $00E9E5E3;
        TLMDCompositeFiller(lf).Item[1].FixedColors[1] := $00F6F6F4;
        TLMDCompositeFiller(lf).Item[2].FixedColors[0] := $00A8A8A7;
        TLMDCompositeFiller(lf).Item[2].FixedColors[1] := $00787877;
      end;

      TLMDCompositeFiller(lf).FillerRect[0] := Rect(0,0,100,16);
      TLMDCompositeFiller(lf).FillerRect[1] := Rect(0,16,100,84);
      TLMDCompositeFiller(lf).FillerRect[2] := Rect(0,84,100,100);
      FSkinRibbonGroupFill[srgBackgroundHover].Fillers[gfpMain] := lf;

      //----------------- SkinRibbon -----------------------------------------//
      CloneRibbonDescr(srPage, ttbToolBarRoot);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemesRibbonAdapter.SetCustomizedElements(
  const Value: TLMDCustomizedRibbonElements);
begin
  FCustomizedElements := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemesRibbonAdapter.SetSkinBtnFill(index: TSkinButton;
  const Value: TLMDGradientThemeFillDescriptor);
begin
  FSkinBtnFill[index] := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemesRibbonAdapter.SetSkinBtnFrame(index: TSkinButton;
  const Value: TLMDGradientThemeFrameDescriptor);
begin
  FSkinBtnFrame[index] := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemesRibbonAdapter.SetSkinRibbonFill(index: TSkinRibbon;
  const Value: TLMDGradientThemeFillDescriptor);
begin
   FSkinRibbonFill[index] := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemesRibbonAdapter.SetSkinRibbonFrame(index: TSkinRibbon;
  const Value: TLMDGradientThemeFrameDescriptor);
begin
  FSkinRibbonFrame[index] := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemesRibbonAdapter.SetSkinRibbonGroupFill(
  index: TSkinRibbonGroup; const Value: TLMDGradientThemeFillDescriptor);
begin
  FSkinRibbonGroupFill[index] := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemesRibbonAdapter.SetSkinRibbonGroupFrame(
  index: TSkinRibbonGroup; const Value: TLMDGradientThemeFrameDescriptor);
begin
  FSkinRibbonGroupFrame[index] := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemesRibbonAdapter.SetSkinTabFill(index: TSkinTab;
  const Value: TLMDGradientThemeFillDescriptor);
begin
  FSkinTabFill[index] := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemesRibbonAdapter.SetSkinTabFrame(index: TSkinTab;
  const Value: TLMDGradientThemeFrameDescriptor);
begin
  FSkinTabFrame[index] := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemesRibbonAdapter.WndProc(var Message: TMessage);

  procedure Default;
  begin
    CallPrevWndProc(Message);
  end;

begin
  with Message do
    case Msg of
      CM_LMDTHEMECHANGED:
        begin
          DoThemeChange;
          Result:=0;
        end;
      else
        Default;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemesRibbonAdapter.RegisterAdapter;
begin
  LMDRibbonStyleAdapter := Self;
end;


{------------------------------------------------------------------------------}
procedure TLMDThemesRibbonAdapter.UnregisterAdapter;
begin
  LMDRibbonStyleAdapter := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemesRibbonAdapter.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (AComponent=self) then
    UnregisterAdapter;
  if (Operation=opInsert) then
    RegisterAdapter;
end;

{$ENDIF}

initialization
  {$IFDEF _LMD_THEMESRIBBONIMPL}
  LMDRibbonStyle := TLMDRibbonStyleActionBars.Create;
  RegisterActnBarStyle(LMDRibbonStyle);
  {$ENDIF}

finalization
  {$IFDEF _LMD_THEMESRIBBONIMPL}
  UnregisterActnBarStyle(LMDRibbonStyle);
  LMDRibbonStyle.Free;
  {$ENDIF}

end.
