unit LMDControl;
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

LMDControl unit (RM)
--------------------
Implements base classes with generic LMD support functionality (ILMDComponent
interface)

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}
interface
uses
  Classes, Controls, Menus, Messages, ComCtrls, Forms, intfLMDBase, LMDClass,
  LMDTypes;

type
  { ********************* TLMDBasePopupMenu ***********************************}
  TLMDBasePopupMenu = class (TPopupMenu, ILMDComponent)
  private
    FAbout    : TLMDAboutVar;
  protected
    property About:TLMDAboutVar read FAbout write FAbout;
  public
    function getLMDPackage:TLMDPackageID;virtual;
  end;

  { ********************* TLMDBaseCustomControl *******************************}
  TLMDBaseCustomControl = class(TCustomControl, ILMDComponent)
  private
    {$IFDEF LMD_UNICODE}
    FHint: TLMDString;
    {$ENDIF}    
    FAbout: TLMDAboutVar;
    FNeedInvalidate: Boolean;
    FUpdateCount: Word;
    FOnMouseEnter,
    FOnMouseExit   : TNotifyEvent;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
  protected
    procedure GetChange(Sender: TObject); virtual;
    procedure MouseEnter; virtual;
    procedure MouseExit; virtual;
    property NeedInvalidate:Boolean read FNeedInvalidate write FNeedInvalidate default True;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseExit: TNotifyEvent read FOnMouseExit write FOnMouseExit;
    {$ifdef LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    {$endif}
  public
    constructor Create (AOwner: TComponent); override;
    procedure BeginUpdate;
    function IsUpdating:Boolean;
    procedure EndUpdate(repaint: Boolean=false);virtual;
    function getLMDPackage:TLMDPackageID;virtual;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored false;
    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$endif}
    {$IFDEF LMDCOMP14}
    property OnGesture;
    property Touch;
    {$ENDIF}
  end;

  { ********************* TLMDBaseTreeView ************************************}
  TLMDBaseTreeView = class(TCustomTreeView, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
  public
    function getLMDPackage:TLMDPackageID; virtual;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored false;
  end;

  { ********************* TLMDBaseTreeView ************************************}
  TLMDBaseListView = class(TCustomListView, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
    FThemeGlobalMode: Boolean;
    procedure SetThemeGlobalMode(const Value: Boolean);
    procedure SetThemeMode(const Value: TLMDThemeMode);
    procedure SetParentThemeMode(const Value: boolean);
  protected
    FThemeMode : TLMDThemeMode;
    FParentThemeMode : boolean;
    //---
    // Theme-Support
    //**************
    //handle theme changes
    procedure DoThemeChanged; virtual;
    // UseThemeMode returns active theme, depending on global settings etc.
    function UseThemeMode: TLMDThemeMode;
  public
    function IsThemed: Boolean; // any other than ttmNone
    function getLMDPackage:TLMDPackageID;virtual;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored false;
    property ParentThemeMode: boolean read FParentThemeMode write SetParentThemeMode;
    property ThemeMode:TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;
  end;

implementation

uses
  LMDThemes, LMDUtils, TypInfo;

{************************ TLMDBasePopupMenu ***********************************}
{------------------------------------------------------------------------------}
function TLMDBasePopupMenu.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_TOOLS;
end;

{************************ TLMDBaseCustomControl *******************************}
{ ----------------------------- private -------------------------------------- }
procedure TLMDBaseCustomControl.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  MouseEnter;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseCustomControl.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  MouseExit;
end;

{ --------------------------- protected -------------------------------------- }
procedure TLMDBaseCustomControl.GetChange(Sender:TObject);
begin
  if FNeedInvalidate then Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseCustomControl.MouseEnter;
begin
  if Assigned(FOnMouseEnter) then FOnMouseEnter(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseCustomControl.MouseExit;
begin
  if Assigned(FOnMouseExit) then FOnMouseExit(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseCustomControl.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

{$ifdef LMD_UNICODE}
procedure TLMDBaseCustomControl.SetHint(Value: TLMDString);
begin
  FHint := Value;
  //inherited Hint := LMDConvertVCLHint(FHint);
  inherited Hint := FHint;
end;

procedure TLMDBaseCustomControl.CMHintShow(var Message:TCMHintShow);
begin
  inherited;
end;
{$endif}

{---------------------------- public ------------------------------------------}
constructor TLMDBaseCustomControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FNeedInvalidate := True;
  FUpdateCount:=0;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseCustomControl.EndUpdate(repaint: Boolean);
begin
  if FUpdateCount>0 then Dec (FUpdateCount);
  if FUpdateCount = 0 then
    if repaint then GetChange(nil);
end;

{------------------------------------------------------------------------------}
function TLMDBaseCustomControl.IsUpdating:Boolean;
begin
  result:=FUpdateCount>0;
end;

{------------------------------------------------------------------------------}
function TLMDBaseCustomControl.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_TOOLS;
end;

{************************ TLMDBaseTreeView ************************************}
{---------------------------- public ------------------------------------------}
function TLMDBaseTreeView.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_TOOLS;
end;

{************************ TLMDBaseListView ************************************}
{---------------------------- public ------------------------------------------}
procedure TLMDBaseListView.DoThemeChanged;
begin
  // Delphi 2k7 fix
  {$IFDEF LMDCOMP11}if (csDesigning in ComponentState) then exit;{$ENDIF}
  // RM - Themes
  Invalidate;
  //NotifyControls(WM_THEMECHANGED);
  NotifyControls(CM_LMDTHEMECHANGED);
end;

{------------------------------------------------------------------------------}
function TLMDBaseListView.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_TOOLS;
end;

function TLMDBaseListView.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseListView.SetParentThemeMode(const Value: boolean);
begin
  if FParentThemeMode <> Value then
  begin
    FParentThemeMode := Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseListView.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
  begin
    FThemeGlobalMode := Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseListView.SetThemeMode(const Value: TLMDThemeMode);
begin
  if (FThemeMode <> Value) then
  begin
    FThemeMode := Value;
    if not FThemeGlobalMode then       // if we are in GlobalThemeMode, no update required
      DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseListView.UseThemeMode: TLMDThemeMode;
begin
  result := FThemeMode;
  if ParentThemeMode and Assigned(Parent) and IsPublishedProp(Parent, 'ThemeMode') then
    result := TLMDThemeMode(GetOrdProp(Parent, 'ThemeMode'))
  else
    if FThemeGlobalMode then
      result := LMDApplication.ThemeGlobalMode;
  result := LMDThemeServices.UseTheme(result);
end;

end.
