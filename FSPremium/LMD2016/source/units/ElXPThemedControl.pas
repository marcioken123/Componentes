unit ElXPThemedControl;
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

ElXPThemedControl unit
----------------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Messages, Classes, Windows, Controls, Forms, Types,
  LMDClass, LMDThemes, Themes, ElVCLUtils, ElStyleMan, LMDTypes, intfLMDBase;

type
  ILMDElParentControlInterface=interface
    ['{650B1E65-792D-4669-87D0-81666305B0C5}']
    procedure RepaintRect(ARect: TRect);
  end;

  TElXPThemedControl = class(TCustomControl, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
    FStyleMgrLink : TElStyleMgrChangeLink;
    FStyleManager: TElStyleManager;
    FStyleName: string;
    FCreating : integer;
    FThemeGlobalMode: Boolean;
    procedure SetStyleManager(Value: TElStyleManager); virtual;
    procedure SetStyleName(const Value: string); virtual;
    procedure StyleMgrChange(Sender : TObject);
    procedure ReadUseXPThemes(Reader: TReader);
    procedure WMStyleChanging(var Message: TWMStyleChanging); message WM_STYLECHANGING;
    procedure WMStyleChanged(var Message: TWMStyleChanged); message WM_STYLECHANGED;
    procedure WMSetRedraw(var Message: TWMSetRedraw); message WM_SETREDRAW;
    // procedure WMIsThemedControl(var Message: TMessage); message WM_ISTHEMEDCONTROL; required?
    procedure ELThemeChanged(var Message: TMessage); message WM_THEMECHANGED;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure SetParentThemeMode(const Value: boolean);
  protected
    FParentThemeMode : boolean;
    FThemeMode : TLMDThemeMode;
    FPreventStyleChange :Boolean;
    function GetUseXPThemes: Boolean;
    procedure BeginCreate;
    procedure EndCreate;
    procedure DefineProperties(Filer:TFiler);override;
    function GetThemedElement: TThemedElement; virtual;
    procedure SetThemeGlobalMode(const Value: Boolean);virtual;
    procedure SetThemeMode(const Value: TLMDThemeMode);virtual;
    procedure SetUseXPThemes(const Value: Boolean);virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;
    // Theme Support (> LMD2008 Series)
    procedure DoThemeChanged; virtual;
    procedure UpdateStyle;
    property ParentThemeMode: boolean read FParentThemeMode write SetParentThemeMode;
    //new V9
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
//    function IsThemeApplied: Boolean;
    function getLMDPackage:TLMDPackageID;
    function IsThemed: Boolean;
    function UseThemeMode: TLMDThemeMode;
    property UseXPThemes: Boolean read GetUseXPThemes write SetUseXPThemes;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
    {$IFDEF LMCCOMP14}
    property OnGesture;
    property Touch;
    {$ENDIF}
  end;

implementation

uses
  TypInfo, SysUtils;

{************************ TLMDObject ******************************************}
{--------------------------- private ------------------------------------------}
procedure TElXPThemedControl.SetParentThemeMode(const Value: boolean);
begin
  if FParentThemeMode <> Value then
  begin
    FParentThemeMode := Value;
    DoThemeChanged;
  end;
end;

procedure TElXPThemedControl.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
    begin
      if (FStyleManager <> nil) and (not (csDestroying in FStyleManager.ComponentState)) then
        FStyleManager.RemoveFreeNotification(Self);
      if FStyleManager <> nil then
         FStyleManager.UnregisterChanges(FStyleMgrLink);
      FStyleManager := Value;
      if FStyleManager <> nil then
        begin
          FStyleManager.FreeNotification(Self);
          FStyleManager.RegisterChanges(FStyleMgrLink);
          UpdateStyle;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TElXPThemedControl.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
  begin
    FStyleName := Value;
    UpdateStyle;
  end;
end;

{------------------------------------------------------------------------------}
procedure TElXPThemedControl.StyleMgrChange(Sender : TObject);
begin
  UpdateStyle;
end;

{------------------------------------------------------------------------------}
procedure TElXPThemedControl.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
  begin
    FThemeGlobalMode := Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
function TElXPThemedControl.GetThemedElement: TThemedElement;
begin
  Result := teEdit;
end;
{------------------------------------------------------------------------------}
procedure TElXPThemedControl.SetThemeMode(const Value: TLMDThemeMode);
begin
  if Value <> FThemeMode then
  begin
    FThemeMode:= Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
procedure TElXPThemedControl.SetUseXPThemes(const Value: Boolean);
begin
  if UseXPThemes <> Value then
  begin
    ThemeMode := LMDCtlXP[Value];
  end;
end;

{------------------------------------------------------------------------------}
function TElXPThemedControl.GetUseXPThemes: Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

{------------------------------------------------------------------------------}
procedure TElXPThemedControl.ReadUseXPThemes(Reader: TReader);
begin
  SetUseXPThemes(Reader.ReadBoolean);
end;

{------------------------------------------------------------------------------}
procedure TElXPThemedControl.WMStyleChanging(var Message: TWMStyleChanging);
begin
  if not FPreventStyleChange then
    inherited
  else
    Message.Result := 0;
end;

{------------------------------------------------------------------------------}
procedure TElXPThemedControl.WMStyleChanged(var Message: TWMStyleChanged);
begin
  if not FPreventStyleChange then
    inherited
  else
    Message.Result := 0;
end;

{------------------------------------------------------------------------------}
procedure TElXPThemedControl.WMSetRedraw(var Message: TWMSetRedraw);
var
  SI:TScrollInfo;
begin
  inherited;
  if Visible and LongBool(TWMSetRedraw(Message).Redraw)=True then
    begin
      if (GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL)<>0 then
        begin
          SI.cbSize := SizeOf(TScrollInfo);
          SI.fMask := SIF_POS;
          if GetScrollInfo( Handle, SB_HORZ, SI) then
            SetScrollInfo( Handle, SB_HORZ, SI, True);
        end;
      if (GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL)<>0 then
        begin
          SI.cbSize := SizeOf(TScrollInfo);
          SI.fMask := SIF_POS;
          if GetScrollInfo( Handle, SB_VERT, SI) then
            SetScrollInfo( Handle, SB_VERT, SI, True);
        end;
    end;
end;

procedure TElXPThemedControl.WMNCPaint(var Message: TWMNCPaint);

const
  InnerStyles: array[TBevelCut] of Integer = (0, BDR_SUNKENINNER, BDR_RAISEDINNER, 0);
  OuterStyles: array[TBevelCut] of Integer = (0, BDR_SUNKENOUTER, BDR_RAISEDOUTER, 0);
  EdgeStyles: array[TBevelKind] of Integer = (0, 0, BF_SOFT, BF_FLAT);
  Ctl3DStyles: array[Boolean] of Integer = (BF_MONO, 0);
var
  DC: HDC;
  RC, RW, SaveRW: TRect;
  EdgeSize: Integer;
  WinStyle: Longint;
  Details: TThemedElementDetails;
  lThemeMode: TLMDThemeMode;
begin
  lThemeMode := UseThemeMode;
  if lThemeMode <> ttmNone then
    begin
      Details.Element := GetThemedElement;
      Details.Part := 0;
      Details.State := 0;
      { Get window DC that is clipped to the non-client area }
      if (BevelKind <> bkNone) or (BorderWidth > 0) then
        begin
          DC := GetWindowDC(Handle);
          try
            Windows.GetClientRect(Handle, RC);
            GetWindowRect(Handle, RW);
            MapWindowPoints(0, Handle, RW, 2);
            OffsetRect(RC, -RW.Left, -RW.Top);
            ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
            { Draw borders in non-client area }
            SaveRW := RW;
            InflateRect(RC, BorderWidth, BorderWidth);
            RW := RC;
            if BevelKind <> bkNone then
              begin
                EdgeSize := 0;
                if BevelInner <> bvNone then Inc(EdgeSize, BevelWidth);
                if BevelOuter <> bvNone then Inc(EdgeSize, BevelWidth);
                with RW do
                  begin
                    WinStyle := GetWindowLong(Handle, GWL_STYLE);
                    if beLeft in BevelEdges then Dec(Left, EdgeSize);
                    if beTop in BevelEdges then Dec(Top, EdgeSize);
                    if beRight in BevelEdges then Inc(Right, EdgeSize);
                    if (WinStyle and WS_VSCROLL) <> 0 then Inc(Right, GetSystemMetrics(SM_CYVSCROLL));
                    if beBottom in BevelEdges then Inc(Bottom, EdgeSize);
                    if (WinStyle and WS_HSCROLL) <> 0 then Inc(Bottom, GetSystemMetrics(SM_CXHSCROLL));
                  end;
                LMDThemeServices.DrawThemeEdge(lThemeMode, DC, Details.Element, 0,0 , RW, InnerStyles[BevelInner] or OuterStyles[BevelOuter],
                  Byte(BevelEdges) or EdgeStyles[BevelKind] or Ctl3DStyles[Ctl3D] or BF_ADJUST);
              end;
            IntersectClipRect(DC, RW.Left, RW.Top, RW.Right, RW.Bottom);
            LMDThemeServices.DrawElement(lThemeMode, DC, Details, RC);
          finally
            ReleaseDC(Handle, DC);
          end;
        end;
      DefaultHandler(Message);
    end
  else
    inherited;
end;

{------------------------------------------------------------------------------}
{procedure TElXPThemedControl.WMIsThemedControl(var Message: TMessage);
begin
  Message.Result := Theme;
end;

{------------------------------------------------------------------------------}
procedure TElXPThemedControl.ELThemeChanged(var Message: TMessage);
begin
  DoThemeChanged;
  Message.Result := 1;
end;

{------------------------------------------------------------------------------}
procedure TElXPThemedControl.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FStyleManager) then
     StyleManager := nil;
end; { Notification }

{-------------------------- protected -----------------------------------------}
procedure TElXPThemedControl.BeginCreate;
begin
  inc(FCreating);
end;

{------------------------------------------------------------------------------}
procedure TElXPThemedControl.EndCreate;
begin
  dec(FCreating);
  if FCreating = 0 then
    begin
      if not (csDesigning in ComponentState) then
        StyleManager := DefaultStyleManager;
    end;
end;

{------------------------------------------------------------------------------}
procedure TElXPThemedControl.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('UseXPThemes', ReadUseXPThemes, nil, false);
end;

{------------------------------------------------------------------------------}
procedure TElXPThemedControl.DoThemeChanged;
begin
  // Delphi 2k7 fix
  if (UseThemeMode <> ttmNone) and HandleAllocated and not (csDestroying in ComponentState) then
  begin
    if Showing and (ComponentState * [csLoading, csReading] = []) then
      begin
        // Recalculate frame size
        SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
        // Repaint frame
        RedrawWindow(Handle, nil, 0, {RDW_FRAME or }RDW_INVALIDATE or RDW_ERASE);
      end;
  end
  else
    Invalidate;
end;

{------------------------------------------------------------------------------}
function TElXPThemedControl.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

{------------------------------------------------------------------------------}
procedure TElXPThemedControl.Loaded;
begin
  inherited;
  UpdateStyle;
end;

{------------------------------------------------------------------------------}
function TElXPThemedControl.UseThemeMode: TLMDThemeMode;
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
procedure TElXPThemedControl.UpdateStyle;
begin
  if ComponentState * [csLoading, csReading] <> [] then
    exit;
  if FStyleManager <> nil then
    begin
      if HandleAllocated and Visible then
        SendMessage(Handle, WM_SETREDRAW, 0, 0);
      FStyleManager.ApplyStyle(Self, StyleName);
      if HandleAllocated and Visible then
        begin
          SendMessage(Handle, WM_SETREDRAW, 1, 0);
          Invalidate;
        end;
    end;
end;

{--------------------------- public -------------------------------------------}
constructor TElXPThemedControl.Create(AOwner: TComponent);
begin
  BeginCreate;
  inherited;
  FParentThemeMode := true;
  FThemeMode := ttmPlatform;
  FStyleMgrLink := TElStyleMgrChangeLink.Create;
  FStyleMgrLink.OnChange := StyleMgrChange;
  EndCreate;
end;

{------------------------------------------------------------------------------}
destructor TElXPThemedControl.Destroy;
begin
  StyleManager := nil;
  FreeAndNil(FStyleMgrLink);
  inherited;
end;

{------------------------------------------------------------------------------}
{ replaced on IsThemed
function TElXPThemedControl.IsThemeApplied: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;}

{------------------------------------------------------------------------------}
function TElXPThemedControl.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_ELCORE;
end;

end.
