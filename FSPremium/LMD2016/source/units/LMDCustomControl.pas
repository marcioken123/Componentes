unit LMDCustomControl;
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

LMDCustomControl unit (JH, RM)
------------------------------
Ancestor class for windowed controls. Introducing transparency and imagelist support.

Comments
--------

Changes
-------
Release 9.0 (June 2008)
 - ThemeMode introduced

Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Controls, Classes, Messages, Windows, Graphics, Forms, ImgList, Themes,
  intfLMDBackground, intfLMDControlPosSize, intfLMDFaceController, 
  LMDFaceController, LMDFillObject,  LMD3DCaption, LMDBevel, LMDClass,
  LMDCont, LMDControl, LMDGraph, LMDBitmapEffectObject, LMDCustomImageList,
  LMDBaseController, LMDTypes;

const
  def_BorderSense=4;

type

  {-------------------TLMDCustomControl----------------------------------------}
  TLMDCustomControl=class(TLMDBaseCustomControl, ILMDControlPosSize, ILMDBackground,
                                                 ILMDFaceController)
  private
    FAutoBring,
    FInternalMouseAbove,
    FFwdBackFX,
    FMouseAbove,
    FEntered,
    FFlat,
    FTransparent   : Boolean;
    FImageList     : TCustomImageList;
    FIndex,
    FListIndex     : Integer;
    FChangeLink    : TChangeLink;
    {4.0}
    FOnAfterEnter,
    FOnAfterExit   : TNotifyEvent;

    {$IFNDEF LMDCOMP7}
    FParentBackground: Boolean;
    {$ENDIF}

    // 7.0 --> ILMDControlPosSize
    FAllowMove,
    FAllowSize,
    FShowGrip,
    FMoving,
    FWindowed,
    FLocked        : Boolean;
    FBorderSense   : Byte;
    FOnMove        : TNotifyEvent;

    FFaceController: TLMDFaceController;

    FBackFX        : TLMDBitmapEffectObject;
    FThemeGlobalMode: Boolean;
    procedure SetImageList(aValue:TCustomImageList);
    procedure SetIndex(index, aValue:Integer);
    procedure SetTransparent(aValue:Boolean);
    procedure SetFlat (aValue:Boolean);
    procedure SetBoolean (aValue : Boolean);
    procedure SetPassBackFX (aValue: Boolean);
    procedure SetBackFXObject (aValue : TLMDBitmapEffectObject);
    {saving}
    {----}
    procedure ReadCtlXP(Reader: TReader);
    procedure ReadIdent(Reader:TReader);
    procedure WriteIdent(Writer:TWriter);
    function  CheckCont:Boolean;
    function HasControl:Boolean;
    {----  }

    {-- 4.0}
    procedure CMLMDAfterEnter(var Message: TMessage); message CM_LMDAFTERENTER;
    procedure CMLMDAfterExit(var Message: TMessage); message CM_LMDAFTEREXIT;
    {--}

    // 6.1
    procedure CMLMDThemeChanged(var Message: TMessage); message CM_LMDTHEMECHANGED;
    procedure WMThemeChanged(var Msg:TMessage); message WM_THEMECHANGED;
    {$IFDEF LMDCOMP16}
    procedure CMStyleChanged(var Msg:TMessage); message CM_STYLECHANGED;
    {$ENDIF}
    // --

    // 7.0 ILMDControlPosSize
    procedure WMNCHitTest(var Message: TWMNCHitTest);message WM_NCHitTest;
    procedure SetShowGrip(const aValue: Boolean);
    function get_AllowMoving: Boolean;
    procedure set_AllowMoving(const aValue: Boolean);
    function get_AllowSizing: Boolean;
    procedure set_AllowSizing(const aValue: Boolean);
    function get_ControlLocked: Boolean;
    procedure set_ControlLocked(const aValue: Boolean);
    procedure set_OnMove(const aValue:TNotifyEvent);
    function get_OnMove:TNotifyEvent;
    procedure set_CtlXP (aValue: Boolean);
    function get_CtlXP: Boolean;
    procedure SetThemeMode(const Value: TLMDThemeMode);
    procedure SetThemeGlobalMode(const Value: Boolean);
    procedure SetFaceController (aValue: TLMDFaceController);

    // generated when Transparent property is changed
    procedure CMTRANSPARENTCHANGED(var Message: TMessage); message CM_TRANSPARENTCHANGED;

    procedure CMLMDSCROLLBOXSCROLLEVENT (var Message : TMessage); message CM_LMDSCROLLBOXSCROLLEVENT;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMSYSCOLORCHANGE(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure WMERASEBKGND(var Message: TWMERASEBKGND); message WM_ERASEBKGND;
    procedure WMKILLFOCUS(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMMOVE(var Message: TWMMOVE); message WM_MOVE;
    procedure WMSETFOCUS(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
    procedure WMMOUSEMOVE(var Message:TWMMouseMove); message WM_MOUSEMOVE;
    procedure SetParentThemeMode(const Value: boolean);
  protected
    FThemeMode : TLMDThemeMode;
    FParentThemeMode: boolean;
    // V8
    procedure SetParentBackground(Value: Boolean); {$IFDEF LMDCOMP7}override;{$ELSE}virtual;{$ENDIF}
    function CheckOpaqueState:Boolean;
    function IsNotOpaque:Boolean;
    //---
    // Theme-Support
    //**************
    //handle theme changes
    procedure DoThemeChanged; virtual;

    // UseThemeMode returns active theme, depending on global settings etc.
    function UseThemeMode: TLMDThemeMode;

    // 7.01
    property AutoBringToFront:Boolean read FAutoBring write FAutoBring default true;

    // 7.0 --> Move and size features
    // called when Movement feature was used
    procedure DoMove; virtual;
    function GetMoveRect:TRect;virtual;
    function GetSizeRect:TRect;virtual;

    // if Move feature is enabled: If HandleNonWindowedControls is set to true,
    // TGraphicControl descendants will handle nouseclicks.
    property HandleNonWinControls:Boolean read FWindowed write FWindowed default false;

    property AllowMoving:Boolean read get_AllowMoving write set_AllowMoving default false;
    property AllowSizing:Boolean read get_AllowSizing write set_AllowSizing default false;
    property ControlLocked:Boolean read get_ControlLocked write set_ControlLocked default false;

    property SizeGrip:Boolean read FShowGrip write SetShowGrip default false;
    property OnMove:TNotifyEvent read get_OnMove write set_OnMove;

    property BorderSensitivity:Byte read FBorderSense write FBorderSense default def_BorderSense;

    // --------------------------------------
    //helper functions for easy integration of the face controller concept

    function fcGetFocused: Boolean; virtual;
    function fcGetMouseAbove: Boolean; virtual;
    function fcGetTransparent : Boolean; virtual;
    function fcGetCtlXP : Boolean; virtual;
    function fcGetBorderCtl3D : Boolean; virtual;
    function fcGetEnabled     : Boolean; virtual;
    function fcGetBackColor   : TColor; virtual;

    //-- vb --
    procedure fcSetFaceController(aComponent:TComponent);
    //--

    function GetFont        : TFont; virtual;
    function GetFont3D      : TLMD3DCaption; virtual;
    function GetTransparent : Boolean; virtual;
    function GetCtlXP       : Boolean; virtual;
    function GetBackColor   : TColor; virtual;
    function GetFillObject  : TLMDFillObject; virtual;
    function GetBackFX      : TLMDBitmapEffectObject; virtual;
    function GetBorderCtl3D : Boolean; virtual;
    function GetBevel       : TLMDBevel; virtual;

    procedure ForceMouseAbove;
    procedure ForceMouseNotAbove;

    //end of helping functions for the face controller concept

    procedure DoForwardBackFX; virtual;
    procedure DoFlatChanged; virtual;
    procedure SetMouseAbove (aValue : Boolean);
    procedure AlignControls(AControl: TControl; var Rect : TRect); override;
    procedure CreateParams(var Params: TCreateParams); override;
    function CheckOptimized:Boolean; virtual;
    procedure DefineProperties(Filer:TFiler); override;
    procedure DrawDashedFrame;
    procedure RepBack (aRect: TRect);
    procedure FillControl; virtual;
    function GetEmpty: Boolean; virtual;
    function GetReadOnly: Boolean; virtual;
    procedure GetIMLChange(Sender: TObject); virtual;
    function GetScreenRect(aRect: TRect):TRect;
    function IMLEmpty: Boolean; virtual;
    procedure InvalidateFrame;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;

    function GetPalette: HPalette; override;
    {-- 4.0}
    procedure MouseEnter; override;
    procedure MouseExit; override;
    {------}

    {-- 7.0}
//    procedure MouseMove(Shift: TShiftState; X, Y: Integer);override;
    {------}

    procedure DoEnter; override;
    procedure DoExit; override;

    procedure RestoreBorderBack; dynamic;
    procedure RestoreBorderFront; dynamic;

    // 9.0 -> Replaces BevelXP
    procedure DrawThemeBevel(aTheme: TLMDThemeMode; aCanvas: TCanvas; aRect: TRect); virtual;

    //is true if the control or a control placed on it has the focus
    property Entered : Boolean read FEntered write SetBoolean;

    property BackFX : TLMDBitmapEffectObject read FBackFX write SetBackFXObject;
    property Flat:Boolean read FFlat write SetFlat default false;
    property ImageList:TCustomImageList read FImageList write SetImageList stored HasControl;
    property ImageIndex:Integer index 0 read FIndex write SetIndex default 0;
    property ListIndex:Integer index 1 read FListIndex write SetIndex default 0;
    property Transparent:Boolean read FTransparent write SetTransparent default false;

    // Changed 6.1
    property CtlXP:Boolean read get_CtlXP write set_CtlXP default true;

    property ParentThemeMode: boolean read FParentThemeMode write SetParentThemeMode;
    // 9.0
    property ThemeMode:TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;

    //if enabled the BackFX changes to the background will be forwarded to child controls
    //the backfx settings will be passed in anyway if the control is holding the top most background, whatever the state of this property is
    property BackFXPass: Boolean read FFwdBackFX write SetPassBackFX default false;

     {-- 4.0}
    property OnAfterEnter: TNotifyEvent read FOnAfterEnter write FOnAfterEnter;
    property OnAfterExit: TNotifyEvent read FOnAfterExit write FOnAfterExit;
    property TabStop default false;
    // 8.0
    {$IFDEF LMDCOMP7}
    property ParentBackground default true;
    {$ELSE}
    property ParentBackground: Boolean read FParentBackground write SetParentBackground default true;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent);override;
    destructor Destroy;override;
    function IsThemed: Boolean; // any other than ttmNone
    // intfLMDBackGround
    function BackBitmap: TBitmap; virtual;
    function BackBitmapCheck: Boolean; virtual;
    function BackDrawArea(Canvas: TCanvas; const dest: TRect; const src: TPoint; flags:Word=0): Boolean; virtual;
    function isTransparentSet: Boolean; virtual;
    function BackMapPoint (const aValue: TPoint): TPoint; virtual;
    function BackBitmapPalette: HPalette; virtual;
    procedure BackUpdate; virtual;
    function BackControl (index: Integer): TControl; virtual;
    function BackControlCount: Integer; virtual;
    // --

    property MouseAbove : Boolean read FMouseAbove;
    property FaceController: TLMDFaceController read FFaceController
                                                write SetFaceController;
  end;

implementation

uses
  Types, SysUtils, TypInfo,
  LMDThemes,LMDUtils{$IFDEF LMD_DEBUGTRACE}, dialogs;{$I C2.INC}{$ELSE};{$ENDIF}

{************************ Class TLMDCustomControl *****************************}
{------------------------- Private --------------------------------------------}
procedure TLMDCustomControl.SetTransparent(aValue:Boolean);
begin
  if aValue<>FTransparent then
    begin
      FTransparent:=aValue;
      if CheckOpaqueState then
        Perform(CM_TRANSPARENTCHANGED,0,0);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.CheckOpaqueState: Boolean;
var
  tmp:Boolean;
begin
  tmp := csOpaque in ControlStyle;
  if FTransparent or (IsThemed and ParentBackground) then
    ControlStyle:=ControlStyle-[csOpaque]
  else
    ControlStyle:=ControlStyle+[csOpaque];
  result := (csOpaque in ControlStyle) <> tmp;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.SetImageList(aValue:TCustomImageList);
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
procedure TLMDCustomControl.SetIndex(index, aValue:Integer);
begin
  case index of
    0: if (aValue=FIndex) or (aValue<0) then exit else FIndex:=aValue;
    1: if (aValue=FListIndex) or (aValue<0) then exit else FListIndex:=aValue;
  end;
  if FImageList<>nil then GetIMLChange(nil);
end;

{------------------------------------------------------------------------------}
Procedure TLMDCustomControl.SetFlat(aValue:Boolean);
begin
  if aValue <> FFlat then
    begin
      FFlat := aValue;
      DoFlatChanged;
      if not FFlat then RestoreBorderFront else RestoreBorderBack;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.SetBoolean (aValue : Boolean);
begin
  if FEntered <> aValue then
    begin
      FEntered := aValue;
      if not FEntered and FFlat then
        RestoreBorderBack;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.SetPassBackFX (aValue: Boolean);
begin
  if FFwdBackFX <> aValue then
    begin
      FFwdBackFX := aValue;
      DoForwardBackFX;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.SetBackFXObject (aValue : TLMDBitmapEffectObject);
begin
  FBackFX.Assign (aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.set_CtlXP (aValue: Boolean);
begin
  if aValue <> Get_CtlXP then
    ThemeMode := LMDCtlXP[aValue];
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
    begin
      FThemeGlobalMode := Value;
      DoThemeChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.SetThemeMode(const Value: TLMDThemeMode);
begin
  if (FThemeMode <> Value) then
    begin
      FThemeMode := Value;
      if not FThemeGlobalMode then       // if we are in GlobalThemeMode, no update required
        DoThemeChanged;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.get_AllowMoving: Boolean;
begin
  result:=FAllowMove;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.set_AllowMoving(const aValue: Boolean);
begin
  FAllowMove:=aValue;
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.get_AllowSizing: Boolean;
begin
  result:=FAllowSize;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomControl.get_CtlXP: Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.set_AllowSizing(const aValue: Boolean);
begin
  FAllowSize:=aValue;
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.get_ControlLocked: Boolean;
begin
  result:=FLocked;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.set_ControlLocked(const aValue: Boolean);
begin
  FLocked:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.set_OnMove(const aValue:TNotifyEvent);
begin
  FOnMove:=aValue;
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.get_OnMove:TNotifyEvent;
begin
  result:=FOnMove;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.SetFaceController (aValue: TLMDFaceController);
begin
  if Assigned (FFaceController) then
    FFaceController.UnregisterControl(self);
  FFaceController := aValue;
  if Assigned (FFaceController) then
    begin
      FFaceController.FreeNotification(Self);
      FFaceController.RegisterControl (self);
    end;
  if [csLoading, csReading, csDestroying]*Componentstate=[] then
    Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.SetShowGrip(const aValue: Boolean);
begin
  If FShowGrip<>aValue then
    begin
      FShowGrip:=aValue;
      if not (csLoading in ComponentState) then RecreateWnd; //Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.ReadIdent(Reader:TReader);
begin
  SetImageList(LMDReadGlobalIdent(Reader));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.ReadCtlXP(Reader: TReader);
begin
  Set_CtlXP(Reader.ReadBoolean);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.WriteIdent(Writer:TWriter);
begin
  LMDWriteGlobalIdent(Writer, FImageList);
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.CheckCont:Boolean;
begin
  result:=LMDIsGlobalIdent(FImageList);
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.IMLEmpty:Boolean;
begin
  result:=not ((FImageList<>nil) and LMDIMLIsValidItem(FImageList, FListIndex, FIndex));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.InvalidateFrame;
var
  tmp:TRect;
begin
  tmp:=BoundsRect;
  {InflateRect(R, 1, 1);}
  LMDInvalidateRect(Parent.Handle, tmp, True);
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.HasControl:Boolean;
begin
  result:=(FImageList<>nil) and (FImageList.Owner<>LMDContainer);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.WMNCHitTest(var Message: TWMNCHitTest);
var
  tmpr: TRect;
  tmpp:TPoint;
  ret:Longword;
begin

  inherited;
  if FLocked or (csDesigning in ComponentState) then exit;
  ret:=0;
  tmpp:=ScreenToClient(Point(Message.xPos,Message.yPos));

  if FAllowSize and (Message.Result = htClient) then
    begin
       if not FShowGrip then
        ret:=LMDControlSizingHitTest(Handle, tmpp, ClientRect, FBorderSense)
      else
        begin
          tmpr:=GetSizeRect;
          if (tmpp.x >= tmpr.Left) and (tmpp.y >= tmpr.Top) then ret:=HTBOTTOMRIGHT;
        end;

      if ret>0 then
        begin
          if FAutoBring then
            SetWindowPos(Handle, HWND_TOP,0,0,0,0,  SWP_NOMOVE or SWP_NOSIZE);
          Message.Result := ret;
          exit;
        end;
    end;

  if (Align<>alNone) then exit;

  tmpr:=GetMoveRect;
  if FAllowMove then
    if PtInRect(tmpr, tmpp) and (Message.Result = htClient) then
      begin
        if FWindowed and (ControlAtPos(tmpp, false)<>nil) then exit;
        // to be extended -> search all controls whether they have system functionality

        FMoving:=True;
        MouseMove([],tmpp.X,tmpp.Y);
        Message.Result := htCaption;
        if FAutoBring then
          SetWindowPos(Handle, HWND_TOP,0,0,0,0,  SWP_NOMOVE or SWP_NOSIZE);
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.CMLMDThemeChanged(var Message: TMessage);
begin
  DoThemeChanged;
end;

// New in 09-Dec-02, so that we can influcence what happens when Transparent
// property is set - here required to update child controls as well
{------------------------------------------------------------------------------}
procedure TLMDCustomControl.CMTRANSPARENTCHANGED(var Message: TMessage);
begin
  if Visible and HandleAllocated then
    RecreateWnd;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.CMLMDSCROLLBOXSCROLLEVENT (var Message : TMessage);
begin
  //this special msg handler is for use with the TLMDScrollBox only
  //this msg will be send to all child controls of a ScrollBox if the boxed had been scrolled
  //is this msg arrives the child controls have to be informed that they have to repaint themselves
  //this is needed because of the circumstance that the child controls of panels will not be automaticcaly been redrawn
  if CheckOptimized then NotifyControls (CM_LMDBACKCHANGED);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.CMLMDAfterEnter(var Message: TMessage);
begin
  if Assigned(FOnAfterEnter) then FOnAfterEnter(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.CMLMDAfterExit(var Message: TMessage);
begin
  if Assigned(FOnAfterExit) then FOnAfterExit(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.CMEnabledChanged(var Message: TMessage);
begin
  if Assigned(FFaceController) then
    FFaceController.StateChanged(Self);
  inherited;
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP16}
procedure TLMDCustomControl.CMStyleChanged(var Msg: TMessage);
begin
  // DoThemeChanged; YB - generally required, but adds too many flickers.
end;
{$ENDIF}

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.CMSYSCOLORCHANGE(var Message: TMessage);
begin
  inherited;
  if not FTransparent then Invalidate;
end;

{$IFNDEF LMDCOMP7}
{------------------------------------------------------------------------------}
procedure PerformEraseBackground(Control: TControl; DC: HDC);
var
  LastOrigin: TPoint;
begin
  GetWindowOrgEx(DC, LastOrigin);
  SetWindowOrgEx(DC, LastOrigin.X + Control.Left, LastOrigin.Y + Control.Top, nil);
  Control.Parent.Perform(WM_ERASEBKGND, WParam(DC), LParam(DC));
  SetWindowOrgEx(DC, LastOrigin.X, LastOrigin.Y, nil);
end;
{$ENDIF}

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.WMERASEBKGND(var Message: TWMERASEBKGND);
var
  cRect : TRect;
begin
  If IsThemed and IsNotOpaque then
    begin
      if Assigned(Parent) and Parent.DoubleBuffered then
        PerformEraseBackground(Self, Message.DC)
      else
        begin
          cRect := ClientRect;
          if UseThemeMode = ttmPlatform then
            ThemeServices.DrawParentBackground(Handle, Message.DC, nil, False, @cRect)
          else
            LMDThemeServices.DrawThemeParentBackground(ttmNative, Handle, Message.DC, @cRect);
        end;
      Message.Result:=1;
      exit;
    end;

  if CheckOptimized then
    Message.result:=1
  else
    inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  PostMessage(Handle, CM_LMDAFTEREXIT, 0, 0);
  if (FFaceController <> nil) then
    begin
      FFaceController.StateChanged(Self);
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.WMMOVE(var Message: TWMMOVE);
begin
  inherited;

  if CheckOptimized then
    begin
      if GetBackFX <> nil then
        GetBackFX.DestroyBuffer;
      RePaint;
      PaintControls(Canvas.Handle, nil);
    end;

  if FMoving then
    begin
      FMoving:=False;
      DoMove;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  PostMessage(Handle, CM_LMDAFTERENTER, 0, 0);
  if (FFaceController <> nil) then
    begin
      FFaceController.StateChanged(Self);
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.WMSIZE(var Message: TWMSIZE);
begin
  inherited;
  //
  if GetBackFX <> nil then
    GetBackFX.DestroyBuffer;

  if CheckOptimized then
    BackUpdate
  else
    Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.WMMOUSEMOVE(var Message:TWMMouseMove);
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.WMThemeChanged(var Msg:TMessage);
begin
  inherited;
  {$IFDEF LMDCOMP11}if (csDesigning in ComponentState) then exit;{$ENDIF}
  DoThemeChanged;
  //Msg.result:=1;
end;

{------------------------- Protected ------------------------------------------}
function TLMDCustomControl.BackBitmapCheck:Boolean;
begin
  result := LMDBackBitmapCheck (self);
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.BackBitmap:TBitmap;
begin
  result := nil;
  if BackBitmapCheck then
    result := LMDBackBitmap (self);
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.BackMapPoint(const aValue:TPoint):TPoint;
begin
  result:=aValue;
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.BackDrawArea(Canvas: TCanvas; const dest: TRect; const src: TPoint; flags:Word=0): Boolean;
begin
  result:=false;
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.isTransparentSet: Boolean;
begin
  result := FTransparent;
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.BackBitmapPalette:HPalette;
begin
  result := LMDBackBitmapPalette (self);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.BackUpdate;
begin
  //update self
  if (csLoading in ComponentState) or (csDestroying in ComponentState) then exit;
  if GetBackFX <> nil then
    GetBackFX.DestroyBuffer;
//  if CheckOptimized then //if included a change from fillObject to no fillObject will not be correctly handled!
  RePaint;
  //update any child controls
  LMDBackUpdate (self);
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.BackControl (index: Integer): TControl;
begin
  result := Controls[index];
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.BackControlCount: Integer;
begin
  result := ControlCount;
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.CheckOptimized:Boolean;
begin
  result:=GetTransparent and BackBitmapCheck;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    begin
      Style:=Style or WS_CLIPCHILDREN;
      WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.DrawDashedFrame;
begin
  with Canvas do
    begin
      pen.Color:=clBlack;
      Pen.Style := psDash;
      Brush.Style := bsClear;
      Rectangle(0, 0, Width, Height);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.FillControl;
begin
  // windows xp, background of parent control is used
  if IsThemed and ParentBackground then
    exit;

  if CheckOptimized and BackDrawArea(Canvas, ClientRect, Point(0,0), 0) then
    exit;

  with Canvas do
  begin
    Brush.Color := GetBackColor;
    Brush.Style := bsSolid;
    FillRect(GetClientRect);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty(IDS_INTERNAL, ReadIdent, WriteIdent, CheckCont);
  Filer.DefineProperty(IDS_CtlXP, ReadCtlXP, nil, false);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.GetIMLChange(Sender:TObject);
begin
  GetChange(sender);
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.GetEmpty:Boolean;
begin
  result:=True;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomControl.GetReadOnly: Boolean;
begin
  result := false;
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.GetScreenRect(aRect:TRect):TRect;
{converts control's aRect-coordinates in Screen-coordinates}
begin
  with aRect do
    begin
     result.TopLeft:=ClientToScreen(Point(Left,Top));
     result.BottomRight:=ClientToScreen(Point(Right,Bottom));
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.Loaded;
begin
  inherited Loaded;
  {5.0 + 7.02 fix}
  if LMDIsCollectionImageList(ImageList) or
     LMDIsGlobalIdent(ImageList) then GetIMLChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.MouseEnter;
begin
  inherited;
  if (FFaceController <> nil) and not FInternalMouseAbove then //and Flat added July 02, JH
    begin
      FFaceController.StateChanged(Self);
      FInternalMouseAbove := true;
      //RecreateWnd; VB Aug 2007 - flickering issue
      ReAlign;
      GetChange(nil);
      BackUpdate;
    end;

  FMouseAbove := true;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.MouseExit;
var
  mp: TPoint;
begin
  FMouseAbove := false;
  if ((not FEntered) and Flat) and not FInternalMouseAbove then //and Flat added July 02, JH
    RestoreBorderBack;
  GetCursorPos (mp);
  mp := self.ScreenToClient(mp);
  if (FFaceController <> nil) and not (PtInRect (ClientRect {(0,0,Width, Height)}, mp)) then
    begin
      FFaceController.StateChanged(Self);
      FInternalMouseAbove := false;
      //RecreateWnd; VB Aug 2007 - flickering issue
      ReAlign;
      GetChange(nil);
      BackUpdate;
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
{procedure TLMDCustomControl.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if FMoving then
    begin
      FMoving:=False;
      if Assigned(FOnMove) then FOnMove(self);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.DoEnter;
begin
  inherited;
  FEntered := true;
  if FFaceController <> nil then
    FFaceController.StateChanged(self);
  if FFlat or (FFaceController <> nil) then
    RestoreBorderFront;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.DoExit;
begin
  FEntered := false;
  if FFaceController <> nil then
    FFaceController.StateChanged(self);
  RestoreBorderBack;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.RepBack (aRect : TRect);
begin
  if IsThemed then exit;
  if CheckOptimized and BackDrawArea(Canvas, aRect, Point(0,0{Left+aRect.Left,Top+aRect.Top}), 0) then exit;
  Canvas.Brush.Color:= Color;
  Canvas.Brush.Style := bsSolid;
  Canvas.FillRect (aRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.RestoreBorderFront;
var
  DC : HDC;
  aRect : TRect;
  BrushBtnFace,
  BrushFrame,
  BrushFrame3D,
  BrushWindow : HBrush;
  lThemeMode : TLMDThemeMode;
begin
  lThemeMode := UseThemeMode;
  if lThemeMode <> ttmNone then
  begin
    DrawThemeBevel (lThemeMode, Canvas, ClientRect);
    exit
  end;
  BrushBtnFace := CreateSolidBrush(GetSysColor(COLOR_BTNFACE));
  BrushWindow := CreateSolidBrush(GetSysColor(COLOR_WINDOW));
  BrushFrame := CreateSolidBrush(GetSysColor(COLOR_WINDOWFRAME));
  BrushFrame3D := CreateSolidBrush(GetSysColor(COLOR_BTNSHADOW));
  DC := GetWindowDC (Handle);
  try
    //retrieves screen coordinates
    GetWindowRect (Handle, aRect);
    //"moves" rect to (0,0)
    OffsetRect (aRect, -aRect.Left, -aRect.Top);
    if Ctl3D then
      begin
        inc(aRect.Left, 1);
        inc (aRect.Top);
        FrameRect (DC, aRect, BrushFrame);
        dec(aRect.Top);
        dec(aRect.Left, 1);

        dec (aRect.Bottom);
        dec (aRect.Right);
        FrameRect (DC, aRect, BrushBTNFACE);
        inc (aRect.Right);
        inc (aRect.Bottom);

        DrawEdge (DC, aRect, BDR_SUNKENOUTER, BF_ADJUST or BF_RECT);
      end
    else
      FrameRect (DC, aRect, BrushFrame);
  finally
    ReleaseDC(Handle, DC);
    DeleteObject (BrushWindow);
    DeleteObject (BrushBtnFace);
    DeleteObject (BrushFrame);
    DeleteObject (BrushFrame3D);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.RestoreBorderBack;
var
//  r : Integer;
  DC : HDC;
  aRect : TRect;
  BrushBtnFace,
  BrushWindow : HBrush;
  lThemeMode : TLMDThemeMode;
begin
  if (not Focused) and (FFlat) and (not FMouseAbove) then
    begin

      lThemeMode := UseThemeMode;
      if lThemeMode <> ttmNone then
      begin
        DrawThemeBevel(lThemeMode, Canvas, ClientRect);
        exit
      end;

      //erase Border
//      if Ctl3D then r := 2 else r := 1;
      BrushBtnFace := CreateSolidBrush(GetSysColor(COLOR_BTNFACE));
      BrushWindow := CreateSolidBrush(GetSysColor(COLOR_WINDOW));

      DC := GetWindowDC (Handle);
      try
        //retrieves screen coordinates
        GetWindowRect (Handle, aRect);
        //"moves" rect to (0,0)
        OffsetRect (aRect, -aRect.Left, -aRect.Top);
        if GetBorderCtl3D then
          begin
            FrameRect (DC, aRect, BrushBtnFace);
            InflateRect (aRect, -1, -1);
            FrameRect (DC, aRect, BrushBtnFace);
          end
        else
          FrameRect (DC, aRect, BrushBtnFace);
      finally
        ReleaseDC(Handle, DC);
        DeleteObject (BrushWindow);
        DeleteObject (BrushBtnFace);
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomControl.DrawThemeBevel(aTheme: TLMDThemeMode;
  aCanvas: TCanvas; aRect: TRect);
var
  box: TThemedEdit;
begin
  box := teEditTextNormal;
  if Focused then     box := teEditTextFocused;
  if MouseAbove then  box := teEditTextHot;
  if GetReadOnly then box := teEditTextReadOnly;
  if not Enabled then box := teEditTextDisabled;
  LMDThemeServices.DrawElement(aTheme, aCanvas.Handle, box, aRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.Notification(aComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if (Operation=opRemove) then
  begin
    if (aComponent=FImageList) then SetImageList(nil);
    if (aComponent=FFaceController) then SetFaceController(nil);
    if not (csDestroying in ComponentState) and (aComponent=FBackFX.AlphaBlend.ImageList) then
      FBackFX.AlphaBlend.ImageList := nil;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.Paint;
begin
  if csLoading in ComponentState then exit;
  FillControl;
  if csDesigning in ComponentState then
    begin
      if GetEmpty then DrawDashedFrame;
    end
  else
    RestoreBorderBack;
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.GetPalette : HPalette;
begin
  result := inherited GetPalette;
{  if (FAlphaBlending <> nil) and (FAlphaBlending.Enabled) then
    result := FAlphaBlending.GetPalette;}
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.DoThemeChanged;
begin
  // Delphi 2k7 fix
  {$IFDEF LMDCOMP11}if (csDesigning in ComponentState) then exit;{$ENDIF}
  CheckOpaqueState;
  // RM - Themes
  Invalidate;
  //NotifyControls(WM_THEMECHANGED);
  NotifyControls(CM_LMDTHEMECHANGED);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.DoMove;
begin
  if Assigned(FOnMove) then FOnMove(self);
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.GetMoveRect;
begin
  result:=ClientRect;
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.GetSizeRect:TRect;
begin
  result:=ClientRect;
end;

{ -------- face controller support -(interface)------------------------------- }
{------------------------------------------------------------------------------}
function TLMDCustomControl.fcGetFocused: Boolean;
begin
  result := Focused;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomControl.fcGetMouseAbove: Boolean;
begin
  result := FMouseAbove;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomControl.fcGetTransparent : Boolean;
begin
  result := Transparent;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomControl.fcGetCtlXP : Boolean;
begin
  result := CtlXP;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomControl.fcGetBorderCtl3D : Boolean;
begin
  result := Ctl3D;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomControl.fcGetEnabled : Boolean;
begin
  result := Enabled;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomControl.fcGetBackColor   : TColor;
begin
  result := self.Color;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomControl.fcSetFaceController(aComponent:TComponent);
begin
  FaceController := TLMDFaceController(aComponent);
end;

{ -------- eo face controller support -(interface)---------------------------- }
{ ---------------------------------------------------------------------------- }
function TLMDCustomControl.GetFont        : TFont;
begin
  result := nil;
  if Assigned (FFaceController) then
    result := FFaceController.GetFont (self);
  if result = nil then
    result:= Font;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomControl.GetFont3D      : TLMD3DCaption;
begin
  result := nil;
  if Assigned (FFaceController) then
    result := FFaceController.GetFont3D (self);
  if result = nil then
    result:= nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomControl.GetTransparent : Boolean;
begin
  if Assigned (FFaceController) then
    result := FFaceController.GetTransparent (self)
  else
    result := Transparent;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomControl.GetBackColor: TColor;
begin
  if Assigned (FFaceController) then
    result := FFaceController.GetBackColor (self)
  else
    result := Color;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomControl.GetFillObject  : TLMDFillObject;
begin
  result := nil;
  if Assigned (FFaceController) then
    result := FFaceController.GetFillObject (self);
  if result = nil then
    result:= nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomControl.GetBackFX      : TLMDBitmapEffectObject;
begin
  result := nil;
  if Assigned (FFaceController) then
    result := FFaceController.GetBackFX (self);
  if result = nil then
    result:= FBackFX;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomControl.GetCtlXP : Boolean;
begin
  if Assigned (FFaceController) then
    result := FFaceController.GetBorderCtlXP (self)
  else
    result := CtlXP;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomControl.GetBorderCtl3D : Boolean;
begin
  if Assigned (FFaceController) then
    result := FFaceController.GetBorderCtl3D (self)
  else
    result := Ctl3D;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomControl.GetBevel:TLMDBevel;
begin
  result := nil;
  if Assigned (FFaceController) then
    result := FFaceController.GetBevel (self);
  {if result = nil then
    result:= nil;}
end;

{------------------------------------------------------------------------------}
{
this method sets the internal mouse above variable true
this method is used internally for a special issue with the face controller
concept
}
procedure TLMDCustomControl.ForceMouseAbove;
begin
  FMouseAbove := true;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.ForceMouseNotAbove;
begin
  FMouseAbove := false;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.DoForwardBackFX;
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.DoFlatChanged;
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.SetParentBackground(Value: Boolean);
begin
  if ParentBackground <> Value then
    begin
      {$IFDEF LMDCOMP7}
      if Value then
        ControlStyle := ControlStyle + [csParentBackground]
      else
        ControlStyle := ControlStyle - [csParentBackground];
      {$ELSE}
      FParentBackground := Value;
      {$ENDIF}
      if CheckOpaqueState and not isUpdating then
        Perform(CM_TRANSPARENTCHANGED,0,0);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.SetParentThemeMode(const Value: boolean);
begin
  if FParentThemeMode <> Value then
  begin
    FParentThemeMode := Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.IsNotOpaque: Boolean;
begin
  result := not (csOpaque in ControlStyle);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.SetMouseAbove (aValue : Boolean);
begin
  FMouseAbove := true;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomControl.AlignControls (AControl : TControl;var Rect : TRect);
begin
  inherited AlignControls(aControl, Rect);
end;

{------------------------------------------------------------------------------}
function TLMDCustomControl.UseThemeMode: TLMDThemeMode;
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
function TLMDCustomControl.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

{--------------------------- public -------------------------------------------}
constructor TLMDCustomControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BeginUpdate;
  FParentThemeMode := true;
  Color := clBtnFace;
  Width := 100;
  Height := 40;
  TabStop:=False;
  EndUpdate;
  FAutoBring:=true;
  FTransparent:=False;
  FListIndex:=0;
  FIndex:=0;
  FImageList:=nil;
  FChangeLink:=TChangeLink.Create;
  FChangeLink.OnChange:=GetIMLChange;
  FFlat := false;
  FEntered := false;
  FMouseAbove := false;
  FFwdBackFX := false;
  FBackFX := TLMDBitmapEffectObject.Create;
  FBackFX.OnChange := GetChange;
  // 9.0
  FThemeMode := ttmPlatForm;
  // 7.0
  FBorderSense:=def_BorderSense;
  // 8.0
  ControlStyle := ControlStyle - [csOpaque];
  {$IFDEF LMDCOMP7}
  ControlStyle := ControlStyle + [csParentBackground];
  {$ELSE}
  FParentBackground := True;
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomControl.Destroy;
begin
  SetFaceController (nil);
  FBackFX.OnChange := nil;
  FBackFX.Free;
  FChangeLink.OnChange:=nil;
  FChangeLink.Free;
  inherited Destroy;
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C3.INC}
{$ENDIF}

end.
