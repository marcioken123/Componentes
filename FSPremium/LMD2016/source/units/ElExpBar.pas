unit ElExpBar;
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

ElExpBar unit
-------------


Changes
-------
Release 6.07
  [+] TElExplorerBarGroup: property IsSpecial is added. If this property on,
      SPECIAL parts are used instead of NORMAL
      ( ex: EBP_SPECIALGROUPBACKGROUND/EBP_NORMALGROUPBACKGROUND).

Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  SysUtils,
  Graphics,
  Messages,
  StdCtrls,
  Controls,
  Math,
  Types,
  Themes,

  LMDThemes,
  LMDObjectList,
  LMDGlyphs,
  LMDGraph,
  LMDGraphUtils,
  LMDProcs,
  LMDClass,

  ElScrollBox,
  ElStrToken,
  ElPanel,
  ElIni,
  ElAdvPanel,
  ElVCLUtils;

type

    EExplorerBarError = class(Exception);

    TElExplorerBar = class;

    TElExplorerBarGroupButton = class(TElAdvCaptionButton)
    protected
      procedure DrawThemedBackground(Canvas : TCanvas); override;
      function GetDetails: TThemedElementDetails; override;
    end;

    TElExplorerBarGroup = class(TCustomElAdvancedPanel)
    private
      FDrawParent: Boolean;
    protected
      FAlign: TAlign;
      FIsSpecial: Boolean;
      procedure SetIsSpecial(const Value: boolean);
      function GetBorderAdjustment: Integer; override;
      procedure TriggerMinimizeEvent; override;
      procedure TriggerRestoreEvent; override;
      procedure Resize; override;
      procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
      procedure WMMove(var Message: TWMMove); message WM_MOVE;
      procedure DrawThemedBackground(ARect: TRect); override;
      function CreateButton: TElAdvCaptionButton; override;
      function CreatePanel: TElAdvCaptionPanel; override;
      procedure WMEraseBkGnd(var Msg : TWMEraseBkGnd); message WM_EraseBkgnd;
      procedure DoThemeChanged; override;
      procedure CreateWnd; override;
      procedure ELThemeChanged(var Message: TMessage); message WM_THEMECHANGED;
      procedure DefineProperties(Filer : TFiler); override;
//      function GetDetail: TThemedExplorerBar; reintroduce;
      function GetThemedElement: TThemedElement; override;
    public
      constructor Create(AOwner : TComponent); override;
      function GetButtonWidth: Integer; override;
      function GetCaptionHeight: Integer; override;
      property UseXPThemes;
      property Canvas;
    published
      property IsSpecial: boolean read FIsSpecial write SetIsSpecial default false;
      property Align: TAlign read FAlign write FAlign stored False default alNone;
      property ParentThemeMode default true;
      property ThemeMode;
      property ThemeGlobalMode;
      property OnImageNeeded;
      property OnLinkClick;
      property Cursor;
      property LinkColor;
      property LinkPopupMenu;
      property LinkStyle;

      property Background;
      property BackgroundType;
      property GradientEndColor;
      property GradientStartColor;
      property GradientSteps;
      property Alignment;
      property Layout;
      property ImageForm;
      property OnMove;

      property BevelInner nodefault;
      property BevelOuter nodefault;
      property BevelSpaceColor nodefault;
      property BevelWidth;
      property BorderStyle;
      property BorderWidth;
      property Color;
      property DragCursor;
      property DragMode;
      property Enabled;
      property Font;
      property Locked;
      property MouseCapture;
      property ParentColor;
      property ParentFont;
      property ParentShowHint;
      property PopupMenu;
      property ShowHint;
      property TabStop;
      property Transparent;
      property TransparentXPThemes;
      property Visible;

      property Caption;
      property OnClick;
      property OnDblClick;
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
      property OnMouseEnter;
      property OnMouseLeave;
      property OnResize;
      property DockOrientation;
      property DockSite;
      property Floating;
      property BevelKind;
      property Minimized;
      property CaptionSettings;
      property OnMinimize;
      property OnRestore;
      property OnClose;
      property OnCheckBoxClick;
      property OnCloseQuery;
    end;

    TElExplorerBar = class(TElScrollBox)
    private
      procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    protected
      FInRealign : integer;
      FUpdated   : boolean;
      FMargin: Integer;
      FSpacing: Integer;
      FGroupWidth: Integer;
      FStorage: TElIniFile;
      FStoragePath: string;
      FUseCaptionsFont: Boolean;
      procedure SetUseCaptionsFont(Value: Boolean);
      procedure RealignGroups; virtual;

      procedure CMControlChange(var Msg : TCMControlChange); message CM_CONTROLCHANGE;
      procedure CMControlListChange(var Msg : TMessage); message CM_CONTROLLISTCHANGE;

      procedure Resize; override;
      procedure SetMargin(Value: Integer);
      procedure SetSpacing(Value: Integer);
      procedure CreateWnd; override;
      procedure SetGroupWidth(Value: Integer);
//      function GetThemedElement: TThemedElement; override;
      procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
      procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
      procedure Loaded; override;
      procedure DrawThemedBackground(DC : HDC); override;
      procedure SetUseXPThemes(const Value: Boolean); override;
      procedure SetThemeGlobalMode(const Value: Boolean);override;
      procedure SetThemeMode(const Value: TLMDThemeMode);override;
    public
      constructor Create(AOwner : TComponent); override;
      function AddPanel: TElExplorerBarGroup;
      procedure BeginUpdate;
      procedure EndUpdate;
      procedure Restore;
      procedure Save;
      property UseCaptionsFont: Boolean read FUseCaptionsFont write SetUseCaptionsFont;
    published
      property Margin: Integer read FMargin write SetMargin default 4;
      property Spacing: Integer read FSpacing write SetSpacing default 8;
      property GroupWidth: Integer read FGroupWidth write SetGroupWidth default 0;
      property Storage: TElIniFile read FStorage write FStorage;
      property StoragePath: string read FStoragePath write FStoragePath;

      property TransparentXPThemes default false;
    end;

  TElExplorerBarGroupCaption = class(TElAdvCaptionPanel)
  protected
    procedure TriggerPaintEvent; override;
    procedure DrawThemedBackground(ARect: TRect); override;
    procedure WMEraseBkGnd(var Msg : TWMEraseBkGnd); message WM_EraseBkgnd;
    function GetThemedElement: TThemedElement; override;
  public
    constructor Create(AOwner : TComponent); override;
  end;

implementation
const
  Margin = 4;
  constructor TElExplorerBar.Create(AOwner : TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csAcceptsControls];
  FMargin := 4;
  VertScrollbar.Margin := 4;
  HorzScrollbar.Margin := 4;
  FGroupWidth := 0;
  FSpacing := 8;
  Width := 100;
  TransparentXPThemes := false;
  Align := alLeft;
  FUseCaptionsFont := False;
end;

procedure TElExplorerBar.RealignGroups;
var i, j : integer;
    Group : TElExplorerBarGroup;
    CurY : integer;
    L : TLMDObjectList;
    b : boolean;
    gw : integer;
    OldVertVis : boolean;
begin
  if (FInRealign > 0) then
  begin
    FUpdated := true;
    exit;
  end;
  if (not HandleAllocated) or (ComponentState * [csDestroying, csReading, csLoading] <> [])  then
    exit;
  //gw := 0;
  OldVertVis := VertScrollBar.Visible and ((GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL) <> 0);

  inc(FInRealign);
  try
    CurY := Margin - VertScrollBar.Position;
    L := TLMDObjectList.Create;
    try
      for i := 0 to ControlCount - 1 do
      begin
        Group := TElExplorerBarGroup(Controls[i]);
        b := false;
        for j := 0 to L.Count - 1 do
        begin
          if TElExplorerBarGroup(L[j]).Top > Group.Top then
          begin
            L.Insert(j, Group);
            b := true;
            break;
          end;
        end;
        if not b then
          L.Add(Group);
      end;
      gw := GroupWidth;
      if gw = 0 then
        gw := Max(ClientWidth - Margin * 2, 0);

      for i := 0 to L.Count - 1 do
      begin
        if TObject(L[i]) is TElExplorerBarGroup then
        begin
          Group := TElExplorerBarGroup(L[i]);
          if (ClientWidth < Margin) and (GroupWidth = 0) then
            Group.SetBounds(0, CurY, gw, Group.Height)
          else
            Group.SetBounds(Margin - HorzScrollBar.Position, CurY, gw, Group.Height);

          if not (Group.Visible or (csDesigning in ComponentState)) then Continue;
          inc(CurY, Group.Height + Spacing);
        end;
      end;
    finally
      L.Free;
    end;
  finally
    dec(FInRealign);
  end;

  if ((HorzScrollBar.Visible and ((GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL) <> 0)) or (OldVertVis <> (VertScrollBar.Visible and ((GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL) <> 0)))) and (GroupWidth = 0) then
    HorzScrollBar.Visible := false;
    // PostMessage(Handle, WM_SIZE, 0, 0);
end;

procedure TElExplorerBar.CMControlChange(var Msg : TCMControlChange);

begin
  inherited;
  if Msg.Inserting then
  begin
    if not (Msg.Control is TElExplorerBarGroup) then
    raise EExplorerBarError.Create('ElExplorerBar doesn''t accept controls');
    RealignGroups;
  end;
end;

procedure TElExplorerBar.CMControlListChange(var Msg : TMessage);

begin
  inherited;
  if not (csDestroying in ComponentState) then
    if not (boolean(Msg.LParam)) then RealignGroups;
    end;

function TElExplorerBar.AddPanel: TElExplorerBarGroup;
begin
  Result := TElExplorerBarGroup.Create(Self);
  Result.ThemeMode := ThemeMode;
  Result.Parent := Self;
end;

procedure TElExplorerBar.Resize;
begin
  inherited;
  RealignGroups;
end;

procedure TElExplorerBar.SetMargin(Value: Integer);
begin
  if FMargin <> Value then
  begin
    FMargin := Value;
    VertScrollBar.Margin := FMargin;
    RealignGroups;
  end;
end;

procedure TElExplorerBar.SetSpacing(Value: Integer);
begin
  if FSpacing <> Value then
  begin
    FSpacing := Value;
    RealignGroups;
  end;
end;

procedure TElExplorerBar.CreateWnd;
begin
  inherited;
  RealignGroups;
end;

procedure TElExplorerBar.SetGroupWidth(Value: Integer);
begin
  if FGroupWidth <> Value then
  begin
    FGroupWidth := Value;
    RealignGroups;
  end;
end;

{function TElExplorerBar.GetThemedElement: TThemedElement;
begin
  Result := teExplorerBar;
end;}

procedure TElExplorerBar.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
var R, R1 : TRect;
begin
  if IsThemed then
  begin
    R := ClientRect;
    GetClipBox(Msg.DC, R1);
    LMDThemeServices.DrawElement(UseThemeMode, Msg.DC, tebExplorerBarDontCare, R, LMDRectToPtr(R1));
    Msg.result := 1;
  end
  else
    inherited;
end;

procedure TElExplorerBar.BeginUpdate;
begin
  inc(FInRealign);
end;

procedure TElExplorerBar.EndUpdate;
begin
  dec(FInRealign);
  if (FInRealign = 0) and FUpdated then
    RealignGroups;
  FUpdated := false;
end;

procedure TElExplorerBar.WMVScroll(var Message: TWMVScroll);
begin
  BeginUpdate;
  inherited;
  EndUpdate;
end;

procedure TElExplorerBar.WMHScroll(var Message: TWMHScroll);
begin
  BeginUpdate;
  inherited;
  EndUpdate;
end;

procedure TElExplorerBar.Restore;
var
  SaveKey : string;
  s : string;
  Ctl : TElExplorerBarGroup;
  comp: TControl;
  Token : TElStringTokenizer;
begin
  BeginUpdate;
  if Assigned(FStorage) then
  begin
    SaveKey := FStorage.CurrentKey;
    if FStorage.OpenKey(StoragePath + FStorage.Delimiter + 'ElExplorerBar', false) then
    begin
      if FStorage.ReadString('', 'Groups', '', s) then
      begin
        Token := TElStringTokenizer.CreateStrDelim(s, ':;');
        try
          try
            while Token.HasMoreTokens do
            begin
              s := Token.NextToken;
              comp := FindChildControl(s);
              if comp is TElExplorerBarGroup then
              begin
                Ctl := TElExplorerBarGroup(Comp);
                s := Token.NextToken;
                if s = 'h' then
                  ctl.Visible := false
                else
                if s = 'v' then
                  ctl.Visible := true;
                s := Token.NextToken;
                if s = 'm' then
                  ctl.Minimized := true
                else
                if s = 'n' then
                  ctl.Minimized := false;
              end
              else
              begin
                Token.NextToken;
                Token.NextToken;
              end;
            end;
          finally
            Token.Free;
          end;
        except
        end;
      end;
      FStorage.OpenKey(SaveKey, false);
    end;
  end;
  EndUpdate;
end; {Restore}

procedure TElExplorerBar.Save;
var
  SaveKey : string;
  i : integer;
  vs, hs : string;
begin
  if Assigned(FStorage) then
  begin
    SaveKey := FStorage.CurrentKey;
    if FStorage.OpenKey(StoragePath + FStorage.Delimiter + 'ElExplorerBar', true) then
    begin
      vs := '';
      hs := '';
      for i := 0 to ControlCount - 1 do
      begin
        if i > 0 then
          vs := vs + ';';
        vs := vs + Controls[i].Name;
        if Controls[i].Visible then
          vs := vs + ':v'
        else
          vs := vs + ':h';
        if TElExplorerBarGroup(Controls[i]).Minimized then
          vs := vs + ':m'
        else
          vs := vs + ':n';
      end;
      FStorage.WriteString('', 'Groups', vs);
      FStorage.OpenKey(SaveKey, false);
    end;
  end;
end; {Save}

procedure TElExplorerBar.Loaded;
begin
  inherited;
  RealignGroups;
end;

procedure TElExplorerBar.DrawThemedBackground(DC : HDC);
begin
  // intentionally left blank
end;

procedure TElExplorerBar.SetThemeGlobalMode(const Value: Boolean);
var
  OldValue: Boolean;
  i: Integer;
begin
  OldValue := ThemeGlobalMode;
  inherited;
  if OldValue <> ThemeGlobalMode then
  begin
    for i := 0 to ControlCount - 1 do
    begin
      if Controls[i] is TElExplorerBarGroup then
        TElExplorerBarGroup(Controls[i]).ThemeGlobalMode := ThemeGlobalMode;
    end;
  end;
end;

procedure TElExplorerBar.SetThemeMode(const Value: TLMDThemeMode);
var
  OldValue: TLMDThemeMode;
  i: Integer;
begin
  OldValue := ThemeMode;
  inherited;
  if OldValue <> ThemeMode then
  begin
    for i := 0 to ControlCount - 1 do
    begin
      if Controls[i] is TElExplorerBarGroup then
        TElExplorerBarGroup(Controls[i]).ThemeMode := ThemeMode;
    end;
  end;
end;

procedure TElExplorerBar.SetUseXPThemes(const Value: Boolean);
var
  OldValue: Boolean;
  i: Integer;
begin
  OldValue := UseXPThemes;
  inherited;
  if OldValue <> UseXPThemes then
  begin
    for i := 0 to ControlCount - 1 do
    begin
      if Controls[i] is TElExplorerBarGroup then
        TElExplorerBarGroup(Controls[i]).UseXPThemes := UseXPThemes;
    end;
  end;
end;

constructor TElExplorerBarGroup.Create(AOwner : TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csOpaque];
  FCaptionSettings.ShowCloseButton := false;
  FCaptionSettings.Alignment := taLeftJustify;
  FCloseButton.ShowGlyph := false;
  FMinButton.ShowGlyph := false;
end;

procedure TElExplorerBarGroup.TriggerMinimizeEvent;
begin
  if Parent is TElExplorerBar then
    TElExplorerBar(Parent).RealignGroups;
  inherited;
end;

procedure TElExplorerBarGroup.TriggerRestoreEvent;
begin
  if Parent is TElExplorerBar then
    TElExplorerBar(Parent).RealignGroups;
  inherited;
end;

procedure TElExplorerBarGroup.Resize;
begin
  inherited;
  if Parent is TElExplorerBar then
    TElExplorerBar(Parent).RealignGroups;
end;

procedure TElExplorerBarGroup.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
  if Parent is TElExplorerBar then
    TElExplorerBar(Parent).RealignGroups;
end;

procedure TElExplorerBarGroup.WMMove(var Message: TWMMove);
begin
  inherited;
  if Parent is TElExplorerBar then
    TElExplorerBar(Parent).RealignGroups;
end;

procedure TElExplorerBarGroup.DrawThemedBackground(ARect: TRect);
begin
end;

function TElExplorerBarGroup.CreateButton: TElAdvCaptionButton;
begin
  Result := TElExplorerBarGroupButton.Create(FCaptionPanel);
end;

function TElExplorerBarGroup.CreatePanel: TElAdvCaptionPanel;
begin
  Result := TElExplorerBarGroupCaption.Create(Self);
end;

procedure TElExplorerBarGroup.WMEraseBkGnd(var Msg : TWMEraseBkGnd);
var FBar : TElExplorerBar;
    R    : TRect;
    ADC  : HDC;
begin
  if IsThemed then
  begin
    if Self.FCaptionSettings.Visible then
    begin
      ADC := GetDC(Handle);
      if (ADC = Msg.DC) or (FDrawParent) then
      begin
        R := ClientRect;
        R.Bottom := FCaptionPanel.Height;
        LMDThemeServices.DrawThemeParentBackground(UseThemeMode, Handle, Msg.DC, LMDRectToPtr(R));
    end;
      ReleaseDC(Handle, ADC);
    end;
    R := ClientRect;
    if Self.FCaptionSettings.Visible then
      R.Top := FCaptionPanel.Height - 1;
    FBar := Parent as TElExplorerBar;
    if FBar <> nil then
      LMDThemeServices.DrawElement(UseThemeMode, Msg.DC, tebNormalGroupBackground, R);
  end;
  Msg.Result := 1;
end;

procedure TElExplorerBarGroup.DoThemeChanged;
begin
  inherited DoThemeChanged;
  FCloseButton.ShowGlyph := not IsThemed;
  FMinButton.ShowGlyph := not IsThemed;
end;

procedure TElExplorerBarGroup.CreateWnd;
begin
  inherited;
  FCloseButton.ShowGlyph := not IsThemed;
  FMinButton.ShowGlyph := not IsThemed;
end;

function TElExplorerBarGroup.GetButtonWidth: Integer;
var
  S1, S2 : TSize;
  LThemeMode: TLMDThemeMode;
begin
  LThemeMode := ttmNone;
  if (Parent is TElExplorerBar) then
    LThemeMode := (Parent as TElExplorerBar).UseThemeMode;
  if (LThemeMode <> ttmNone) then
  begin
  //    function GetThemePartSize(Theme: TLMDThemeMode; DC: HDC; Details: TThemedElementDetails; var size: TSize): Boolean; overload;
    LMDThemeServices.GetThemePartSize(LThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(tebHeaderCloseNormal), S1);
    LMDThemeServices.GetThemePartSize(LThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(tebNormalGroupExpandNormal), S2);
    result := Max(Max(S1.cx, S1.cy), Max(S2.cx, S2.cy));
  end
  else
    Result := FCaptionSettings.ButtonWidth;
end;

function TElExplorerBarGroup.GetCaptionHeight: Integer;
begin
  Result := Max(FCaptionSettings.Height, GetButtonWidth + 2);
end;

procedure TElExplorerBarGroup.ELThemeChanged(var Message: TMessage);
begin
  inherited;
{ EK: check that DoThemeChanged is called
  FCloseButton.ShowGlyph := not IsThemed;
  FMinButton.ShowGlyph := not IsThemed;}
end;

procedure TElExplorerBarGroup.DefineProperties(Filer : TFiler);
begin
  inherited;
  with GetElReader do
    Filer.DefineProperty('Canvas', FakeValue, nil, False);
end;

procedure TElExplorerBarGroupButton.DrawThemedBackground;
begin
  // intentionally left blank
end;

function TElExplorerBarGroupButton.GetDetails: TThemedElementDetails;
const
  ThemeDetailsNormal: array[Boolean, Boolean] of TThemedExplorerBar = (
    (tebNormalGroupExpandNormal, tebSpecialGroupExpandSpecial),
    (tebNormalGroupCollapseNormal, tebSpecialGroupCollapseSpecial));
  ThemeDetailsHot: array[Boolean, Boolean] of TThemedExplorerBar = (
    (tebNormalGroupExpandHot, tebSpecialGroupExpandHot),
    (tebNormalGroupCollapseHot, tebSpecialGroupCollapseHot));
  ThemeDetailsPressed: array[Boolean, Boolean] of TThemedExplorerBar = (
    (tebNormalGroupExpandPressed, tebSpecialGroupExpandPressed),
    (tebNormalGroupCollapsePressed, tebSpecialGroupCollapsePressed));
var
  LMinimized: Boolean;
begin
  if Self = TElExplorerBarGroup(Parent.Parent).FCloseButton then
  begin
    if FState in [ebsDown, ebsExclusive] then
      Result := ThemeServices.GetElementDetails(tebHeaderClosePressed)
    else
      if (FMouseInControl) then
        result := ThemeServices.GetElementDetails(tebHeaderCloseHot)
      else
        result := ThemeServices.GetElementDetails(tebHeaderCloseNormal)
  end
  else
  begin
    LMinimized := TElExplorerBarGroup(Parent.Parent).Minimized xor (TElExplorerBarGroup(Parent.Parent).CaptionSettings.InvertMinButtonArrows);
    if (FState in [ebsDown, ebsExclusive]) then
      Result := ThemeServices.GetElementDetails(ThemeDetailsPressed[LMinimized, TElExplorerBarGroup(Parent.Parent).IsSpecial])
    else if (FMouseInControl) then
      Result := ThemeServices.GetElementDetails(ThemeDetailsHot[LMinimized, TElExplorerBarGroup(Parent.Parent).IsSpecial])
    else
      Result := ThemeServices.GetElementDetails(ThemeDetailsNormal[LMinimized, TElExplorerBarGroup(Parent.Parent).IsSpecial]);
  end;
end;

{
function TElExplorerBarGroupButton.GetThemeStateID: Integer;
begin
  if FState in [ebsDown, ebsExclusive] then
    result := EBHC_PRESSED
  else
  if FMouseInControl or FMouseInArrow then
    result := EBHC_HOT
  else
    result := EBHC_NORMAL;
end;
}

procedure TElExplorerBarGroupCaption.DrawThemedBackground;
begin
end;

procedure TElExplorerBarGroupCaption.WMEraseBkGnd(var Msg : TWMEraseBkGnd);
var R : TRect;
begin
  if IsThemed then
  begin
    R := ClientRect;
    // OffsetRect(R, Left, Top);

    TElExplorerBarGroup(Parent).FDrawParent := true;
    LMDThemeServices.DrawThemeParentBackground(UseThemeMode, Handle, Msg.DC, LMDRectToPtr(R));
    TElExplorerBarGroup(Parent).FDrawParent := false;
    if TElExplorerBarGroup(Parent).IsSpecial then
      LMDThemeServices.DrawElement(UseThemeMode, Msg.DC, tebSpecialGroupHead, R)
    else
      LMDThemeServices.DrawElement(UseThemeMode, Msg.DC, tebNormalGroupHead, R);
  end;
  Msg.Result := 1;
end;

constructor TElExplorerBarGroupCaption.Create(AOwner : TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csOpaque];
end;

procedure TElExplorerBarGroupCaption.TriggerPaintEvent;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  LRect: TRect;
  s: WideString;
begin
  FRender.Data.DefaultBgColor := clNone;
  FRender.Data.DefaultColor  := Canvas.Font.Color;
  FRender.Data.DefaultHeight := Canvas.Font.Height;
  FRender.Data.DefaultStyle := Canvas.Font.Style;
  FRender.Data.DefaultFont := Canvas.Font.Name;
  FRender.Data.Charset := Canvas.Font.Charset;
  FRender.Data.LinkColor := LinkColor;
  FRender.Data.LinkStyle := LinkStyle;

  if IsThemed then
  begin
    LRect := ClientRect;
    AdjustClientRect(LRect);
    InflateRect(LRect, - Margin * 2, 0);
    s := Caption;
    if not TElExplorerBar(Parent.Parent).FUseCaptionsFont then
      if TElExplorerBarGroup(Parent).IsSpecial then
        LMDThemeServices.DrawThemeText(ThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(tebSpecialGroupHead), s, Length(s), DT_SINGLELINE or DT_VCENTER or Alignments[TElExplorerBarGroup(Owner).CaptionSettings.Alignment], 0, LRect)
      else
        LMDThemeServices.DrawThemeText(ThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(tebNormalGroupHead), s, Length(s), DT_SINGLELINE or DT_VCENTER or Alignments[TElExplorerBarGroup(Owner).CaptionSettings.Alignment], 0, LRect)
    else
    begin
      Canvas.Brush.Style := bsClear;
      Canvas.Font.Assign(TElExplorerBarGroup(Owner).CaptionSettings.Font);
      LMDDrawText(Canvas.Handle, s, Length(s), LRect, DT_SINGLELINE or DT_VCENTER or Alignments[TElExplorerBarGroup(Owner).CaptionSettings.Alignment]);
    end;
  end
  else
    inherited;
end;

procedure TElExplorerBar.SetUseCaptionsFont(Value: Boolean);
begin
// this property can be used in multilingual programs where system font can't display captions properly
  if (FUseCaptionsFont <> Value) then
  begin
    FUseCaptionsFont := Value;
    if HandleAllocated then
      Invalidate;
  end;
end;

function TElExplorerBarGroup.GetBorderAdjustment: Integer;
begin
  Result := 0;
end;

procedure TElExplorerBarGroup.SetIsSpecial(const Value: boolean);
begin
  if  FIsSpecial <> Value then
  begin
    FIsSpecial := Value;
    if HandleAllocated then
    begin
      Invalidate;
      CaptionPanel.Invalidate;
    end;
  end;
end;

function TElExplorerBarGroup.GetThemedElement: TThemedElement;
begin
  Result := teExplorerBar;
end;

function TElExplorerBarGroupCaption.GetThemedElement: TThemedElement;
begin
  Result := teExplorerBar;
end;

end.
