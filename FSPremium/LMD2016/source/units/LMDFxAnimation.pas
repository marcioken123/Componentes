unit LMDFxAnimation;
{$I LMDCmps.inc}

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

LMDFxEffect unit (RM, AH)
------------------------

Note
----
LMD FxPack is based on code licensed from Eugene Kryukov

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Graphics, Controls, Forms, Classes, SysUtils,
  LMDFxUtils, LMDFxBitmap, LMDFxEffect, LMDFxBase;

type

  TLMDFxAnimationList = class;

  TLMDFxAnimationState = (asNormal, asExecuting);

  { ************************ class TLMDFxAnimation *************************** }
  TLMDFxAnimation = class(TLMDFxAnimationRec)
  private
    FDestImage: TLMDFxBitmap;
    FFreezeCanvas: TCanvas;
    FFreezeRect: TRect;
    FFreezedControl: TControl;
    FOnFinish: TNotifyEvent;
    FOnInternalChange: TNotifyEvent;
    FOnStart: TNotifyEvent;
    FParent: TLMDFxAnimationList;
    FSourceImage: TLMDFxBitmap;
    FState: TLMDFxAnimationState;
    procedure SetDestImage(const Value: TLMDFxBitmap);
    procedure SetSourceImage(const Value: TLMDFxBitmap);
    procedure SetState(const Value: TLMDFxAnimationState);
  protected
    procedure DoProgress(Percent: integer);
    procedure SetName(const NewName: TComponentName); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Execute;
    procedure ExecuteImage(const aCanvas: TCanvas; X, Y: integer);
    procedure FreezeControl(AControl: TControl; ARect: TRect; ASourceImage: TLMDFxBitmap = nil);
    procedure FreezeControlClient(AControl: TControl; ARect: TRect; ASourceImage: TLMDFxBitmap = nil);
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    function IsControlFrozen(AControl: TControl): boolean;
    procedure Restore;
    procedure SetParentComponent(Value: TComponent); override;
    function ShowDesigner:TModalResult;overload;
    function ShowDesigner(const aCaption:String;  OkCancelButtons:Boolean; NotifyProc:TNotifyEvent=nil):TModalResult;overload;
    property DestImage: TLMDFxBitmap read FDestImage write SetDestImage;
    property OnInternalChange: TNotifyEvent read FOnInternalChange write FOnInternalChange;
    property Parent: TLMDFxAnimationList read FParent;
    property SourceImage: TLMDFxBitmap read FSourceImage write SetSourceImage;
    property State: TLMDFxAnimationState read FState write SetState;
  published
    property OnFinish: TNotifyEvent read FOnFinish write FOnFinish;
    property OnStart: TNotifyEvent read FOnStart write FOnStart;
  end;

  { ********************** class TLMDFxAnimationList ************************* }
  TLMDFxAnimationList = class(TLMDFxComponent)
  private
    FAnimationList: TList;
    function GetItem(Index: Integer): TLMDFxAnimation;
    function GetCount: integer;
  protected
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Add(Item: TLMDFxAnimation);
    procedure Remove(Item: TLMDFxAnimation);
    property Count: integer read GetCount;
    property Items[Index: Integer]: TLMDFxAnimation read GetItem; default;
  published
  end;

implementation

uses
  LMDFxGrab, LMDFxAniDesignerForm, LMDFxForm, LMDProcs;

type
  THackForm = class(TCustomForm)
  end;

  TLMDFxLockControl = class(TCustomControl)
  private
    FFrozenImage: TLMDFxBitmap;
    procedure WMEraseBkgnd(var Msg: TMessage); message WM_ERASEBKGND;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
  public
    property FrozenImage: TLMDFxBitmap read FFrozenImage write FFrozenImage;
  end;

  TLMDFxLockPopup = class(TLMDFxLockControl)
  private
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Msg: TMessage); message WM_NCPAINT;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

{ TLMDFxLockControl  =============================================================}

{ ************************** TLMDFxLockControl ******************************* }
{ ------------------------------ private ------------------------------------- }
procedure TLMDFxLockControl.WMEraseBkgnd(var Msg: TMessage);
begin
  Msg.Result := 1;
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDFxLockControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxLockControl.Paint;
begin
  if FrozenImage <> nil then
    FrozenImage.Draw(Canvas, 0, 0);
end;

{ ************************** TLMDFxLockPopup ********************************* }
{ ------------------------------ private ------------------------------------- }
procedure TLMDFxLockPopup.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxLockPopup.WMNCPaint(var Msg: TMessage);
begin
  Msg.Result := 0;
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDFxLockPopup.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := (Style and not (WS_CHILD or WS_GROUP or WS_TABSTOP)) or WS_POPUP;
    ExStyle := ExStyle or WS_EX_TOOLWINDOW;
  end;
end;

{ Freeze Routines =============================================================}
type

  TFreezeItem = class(TObject)
  private
    FControl: TControl;
    FFreezeWindow: TControl;
  public
    property Control: TControl read FControl write FControl;
    property FreezeWindow: TControl read FFreezeWindow write FFreezeWindow;
  end;

var
  FreezeList: TList = nil;

{ ---------------------------------------------------------------------------- }
function FreezeControlProc(AControl: TControl; ARect: TRect; AFrozenImage: TLMDFxBitmap = nil): TCanvas;
var
  i: integer;
  Item: TFreezeItem;
  FreezeWindow: TControl;
  R: TRect;
  AniForm: TLMDFxAnimationForm;
  NewRgn, Rgn: HRGN;
begin
  Result := nil;
  { Check if control already freezed }
  for i := 0 to FreezeList.Count - 1 do
  begin
    Item := TFreezeItem(FreezeList[i]);
    if Item.Control = AControl then
      Exit;
  end;
  { Lock control update }
  if AControl.Parent <> nil then
  begin
    { Control }
    FreezeWindow := TLMDFxLockControl.Create(Application);
    with TLMDFxLockControl(FreezeWindow) do
    begin
      Visible := false;
      Parent := AControl.Parent;
      FrozenImage := AFrozenImage;
      ParentColor := false;
      ParentFont := false;
      R := ARect;
      OffsetRect(R, AControl.Left, AControl.Top);
      BoundsRect := R;

      Visible := true;
      Application.ProcessMessages;
    end
  end
  else
  begin
    { Form }
    FreezeWindow := TLMDFxLockPopup.Create(Application);
    with TLMDFxLockControl(FreezeWindow) do
    begin
      FrozenImage := AFrozenImage;
      ParentColor := false;
      ParentFont := false;
      { Copy region }
      if TCustomForm(AControl) <> nil then;
      AniForm := FindAnimationForm(TCustomForm(AControl));
      if AniForm <> nil then
      begin
        Rgn := AniForm.Region;
        if Rgn <> 0 then
        begin
          NewRgn := CreateRectRgn(0, 0, THackForm(AControl).Width, THackForm(AControl).Height);
          CombineRgn(NewRgn, NewRgn, Rgn, RGN_AND);
          SetWindowRgn(Handle, NewRgn, false);
        end;
      end;
      { Show }
      OffsetRect(ARect, AControl.Left, AControl.Top);
      with ARect do
        if (AControl is TCustomForm) and (THackForm(AControl).FormStyle = fsStayOnTop) then
        SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Right - Left, Bottom - Top, SWP_SHOWWINDOW or SWP_NOACTIVATE)
        else
          SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Right - Left, Bottom - Top, SWP_SHOWWINDOW or SWP_NOACTIVATE);

    end;

  end;
  if FreezeWindow <> nil then
    Result := TLMDFxLockControl(FreezeWindow).Canvas;
  { Add Item to FreezeList }
  Item := TFreezeItem.Create;
  Item.Control := AControl;
  Item.FreezeWindow := FreezeWindow;
  FreezeList.Add(Item);
end;

{ ---------------------------------------------------------------------------- }
procedure UnFreezeControlProc(AControl: TControl);
var
  Item: TFreezeItem;
  i: integer;
begin
  for i := 0 to FreezeList.Count - 1 do
  begin
    Item := TFreezeItem(FreezeList[i]);
    if Item.Control = AControl then
    begin
      FreezeList.Remove(Item);

      TWinControl(Item.FControl).Show;
      SetWindowPos(TWinControl(Item.FControl).Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_SHOWWINDOW or SWP_NOSIZE or SWP_NOMOVE);
      TWinControl(Item.FControl).Update;

      Item.FreezeWindow.Free;

      if THackForm(Item.FControl).FormStyle <> fsStayOnTop then
        SetWindowPos(TWinControl(Item.FControl).Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_SHOWWINDOW or SWP_NOSIZE or SWP_NOMOVE);
      Item.Free;

      Break;
    end;
  end;
end;

{ ************************ class TLMDFxAnimation ***************************** }
{ ------------------------------ private ------------------------------------- }
procedure TLMDFxAnimation.SetDestImage(const Value: TLMDFxBitmap);
begin
  FDestImage := Value;
  if FDestImage <> nil then FDestImage.SetAlpha($FF);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimation.SetSourceImage(const Value: TLMDFxBitmap);
begin
  FSourceImage := Value;
  if FSourceImage <> nil then FSourceImage.SetAlpha($FF);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimation.SetState(const Value: TLMDFxAnimationState);
begin
  FState := Value;
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDFxAnimation.DoProgress(Percent: integer);
begin
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimation.SetName(const NewName: TComponentName);
begin
  inherited;
  if Assigned(FOnInternalChange) then
    FOnInternalChange(Self);
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDFxAnimation.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

{ -----------------------------------------------------------------------------}
destructor TLMDFxAnimation.Destroy;
begin
  if FParent <> nil then
    FParent.Remove(Self);

  inherited Destroy;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimation.Assign(Source: TPersistent);
begin
  if (Source is TLMDFxAnimation) then
  begin
  end;

  inherited ;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimation.Execute;
begin
  if FFreezedControl = nil then Exit;
  if FFreezeCanvas = nil then Exit;
  ExecuteImage(FFreezeCanvas, 0, 0);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimation.ExecuteImage(const aCanvas: TCanvas; X, Y: integer);
begin
  if FSourceImage = nil then Exit;
  if FSourceImage.Width * FSourceImage.Height = 0 then Exit;
  FSourceImage.SetAlpha($FF);

  { Check }
  if FFreezeCanvas <> nil then
  begin
    Application.ProcessMessages;
    FDestImage := LMDFxGrabToKeBitmap(FFreezedControl, FFreezeRect);
    FDestImage.SetAlpha($FF);
  end;

  if FDestImage = nil then Exit;
  if FDestImage.Width * FDestImage.Height = 0 then Exit;
  if Assigned(FOnStart) then
  begin
    FOnStart(Self);
    Application.ProcessMessages;
  end;

  FState := asExecuting;
  LMDFxExecuteAnimation(aCanvas, X, Y, FSourceImage, FDestImage, Self);
  { Draw dest image }
  FDestImage.Draw(aCanvas, X, Y);
  FState := asNormal;
  if Assigned(FOnFinish) then FOnFinish(Self);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimation.FreezeControl(AControl: TControl; ARect: TRect; ASourceImage: TLMDFxBitmap = nil);
var
  ClipRect: TRect;
  Offset, ChildOrigin, ParentOrigin: TPoint;
begin
  if AControl = nil then Exit;
  if IsControlFrozen(AControl) then Exit;
  if (AControl is TGraphicControl) and (AControl.Parent <> nil) then
  begin
    { Graphics control use Parent animation }
    if AControl.Parent.Parent = nil then
      ParentOrigin := Point(AControl.Parent.Left, AControl.Parent.Top)
      else
      ParentOrigin := TWinControl(AControl.Parent.Parent).ClientToScreen(Point(AControl.Parent.Left, AControl.Parent.Top));
      ChildOrigin := TWinControl(AControl.Parent).ClientToScreen(Point(AControl.Left, AControl.Top));
    Offset.X := ChildOrigin.X - ParentOrigin.X;
    Offset.Y := ChildOrigin.Y - ParentOrigin.Y;

    OffsetRect(ARect, Offset.X, Offset.Y);
    AControl := AControl.Parent;
  end;
  FFreezedControl := AControl;
  FFreezeRect := ARect;
  { Clip FreezeRect rect }
  ClipRect := GetRealBoundsRect(AControl);
  OffsetRect(ClipRect, -ClipRect.Left, -ClipRect.Top);
  IntersectRect(FFreezeRect, FFreezeRect, ClipRect);
  { Make SourceImage screenshot }
  if ASourceImage = nil then
    FSourceImage := LMDFxGrabToKeBitmap(FFreezedControl, FFreezeRect)
  else
    FSourceImage := ASourceImage;
  { Freeze }
  FFreezeCanvas := FreezeControlProc(FFreezedControl, FFreezeRect, FSourceImage);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimation.FreezeControlClient(AControl: TControl; ARect: TRect; ASourceImage: TLMDFxBitmap = nil);
var
  ClientRect: TRect;
begin
  ClientRect := GetRealClientRect(AControl);
  with GetClientOrigin(AControl) do
    OffsetRect(ARect, X, Y);

  IntersectRect(ARect, ARect, ClientRect);

  FreezeControl(AControl, ARect, ASourceImage);
end;

{ -----------------------------------------------------------------------------}
function TLMDFxAnimation.GetParentComponent: TComponent;
begin
  Result := FParent;
end;

{ -----------------------------------------------------------------------------}
function TLMDFxAnimation.HasParent: Boolean;
begin
  Result := true;
end;

{ -----------------------------------------------------------------------------}
function TLMDFxAnimation.IsControlFrozen(AControl: TControl): boolean;
begin
  Result := (FFreezedControl <> nil) and (FFreezeCanvas <> nil);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimation.Restore;
begin
  if FFreezedControl = nil then Exit;
  if FFreezeCanvas = nil then Exit;

  { UnFreeze control }
  UnFreezeControlProc(FFreezedControl);

  FFreezeCanvas := nil;
  FFreezedControl := nil;

  FSourceImage.Free;
  FSourceImage := nil;
  FDestImage.Free;
  FDestImage := nil;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimation.SetParentComponent(Value: TComponent);
{var
  i: integer; Delete ??}
begin
  if FParent <> nil then FParent.Remove(Self);

  if Value is TLMDFxAnimationList then
    (Value as TLMDFxAnimationList).Add(Self);
end;

{ -----------------------------------------------------------------------------}
function TLMDFxAnimation.ShowDesigner: TModalResult;
begin
  result:=LMDFxShowDesignerForm(Self);
end;

{ -----------------------------------------------------------------------------}
function TLMDFxAnimation.ShowDesigner(const aCaption: String;
            OkCancelButtons: Boolean; NotifyProc: TNotifyEvent): TModalResult;
begin
  result:=LMDFxShowDesignerForm(Self, aCaption, OkCancelButtons, NotifyProc);
end;

type
  THackBitmap = class(TLMDFxBitmap);

{ ************************ class TLMDFxAnimationList ************************* }
{ ------------------------------ private ------------------------------------- }
function TLMDFxAnimationList.GetItem(Index: Integer): TLMDFxAnimation;
begin
  Result := TLMDFxAnimation(FAnimationList[Index]);
end;

{ -----------------------------------------------------------------------------}
function TLMDFxAnimationList.GetCount: integer;
begin
  Result := FAnimationList.Count;
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDFxAnimationList.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  i: integer;
begin
  for i := 0 to Count-1 do
    Proc(Items[i]);
  inherited ;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDFxAnimationList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAnimationList := TList.Create;
end;

{ -----------------------------------------------------------------------------}
destructor TLMDFxAnimationList.Destroy;
begin
  while FAnimationList.Count>0 do
    Items[FAnimationList.Count-1].Free;
  FreeAndNil(FAnimationList);
  inherited Destroy;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimationList.Add(Item: TLMDFxAnimation);
begin
  Item.FParent := Self;
  FAnimationList.Add(Item);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimationList.Remove(Item: TLMDFxAnimation);
begin
  Item.FParent := nil;
  FAnimationList.Remove(Item);
end;

initialization
  FreezeList := TList.Create;
  RegisterClass(TLMDFxAnimation);

finalization
  FreeAndNil(FreezeList);

end.
