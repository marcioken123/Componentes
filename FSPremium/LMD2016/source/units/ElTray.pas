unit ElTray;

{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
� by LMD Innovative
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

ElTray unit
-----------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Messages, Graphics, Classes, Controls, Math, Menus, Forms,
  ExtCtrls, ImgList, StdCtrls, ShellApi, Types,

  LMDDebugUnit, LMDProcs, LMDUtils, LMDShUtils, LMDTypes, LMDSysIn, LMDHTMLUnit,

  ElBaseComp, ElVCLUtils, ElTimers, ElTrayInfo;

type
  TElTrayExtHintShowEvent = procedure(Sender : TObject; var DoShow : boolean) of object;
  TElTrayExtHintCreateEvent = procedure(Sender : TObject; FormClass : String; var Form : TForm) of object;
  TQueryEndSessionEvent   = procedure(Sender : TObject; Action : Integer; var CanClose : boolean) of object;

  TClickInfo = record
    Button : TMouseButton;
    Shift  : TShiftState;
    X, Y : Integer;
  end;

  TElTrayIcon = class;

  TElTrayInfoSettings = class(TPersistent)
  protected
    FOwner: TElTrayIcon;
    FEnabled: Boolean;
    function GetMsgs: TElTrayMessageList;
    function GetVisualScheme: TElTrayVisualScheme;
    procedure SetMsgs(const Value: TElTrayMessageList);
    procedure SetVisualScheme(const Value: TElTrayVisualScheme);
    procedure SetColor(Value: TColor);
    procedure SetInfoType(newValue: TElTrayInfoType); virtual;
    procedure SetIsHTML(newValue: Boolean); virtual;
    function GetIsHTML: Boolean;
    procedure SetMessage(newValue: TLMDString); virtual;
    function GetColor: TColor;
    function GetInfoType: TElTrayInfoType;

    function GetMessage: TLMDString;
    procedure SetEnabled(Value: Boolean);
    function GetFont: TFont;
    procedure SetFont(Value: TFont);
  public
    constructor Create(AOwner: TPersistent);
    procedure Assign(Source : TPersistent); override;
  published
    property Color: TColor read GetColor write SetColor default clInfoBk;
    property InfoType: TElTrayInfoType read GetInfoType write SetInfoType;
    property IsHTML: Boolean read GetIsHTML write SetIsHTML default false;
    property Message: TLMDString read GetMessage write SetMessage;
    property Enabled: Boolean read FEnabled write SetEnabled default false;
    property Font: TFont read GetFont write SetFont;
    property VisualScheme: TElTrayVisualScheme read GetVisualScheme write SetVisualScheme;
    property Messages: TElTrayMessageList read GetMsgs write SetMsgs;
  end;

  TElTrayIcon = class(TElBaseComponent)
  private
    FPopupVis: Boolean;
    FExtHintWndStyle : Cardinal;
    FExtHintWndExStyle : Cardinal;
    FOnBeforeExtendedHintShow : TElTrayExtHintShowEvent;
    FOnExtHintFormCreate : TElTrayExtHintCreateEvent;
    FHideTaskBarIcon : Boolean;
    FExtendedHintDelay : Cardinal;
    FOnQueryEndSession : TQueryEndSessionEvent;
    FPopupWhenModal : Boolean;
    FHint : string;
    FStaticIcon : TIcon;
    FAnimated : Boolean;
    FIcon : TIcon;
    FIcons : TCustomImageList;
    FInterval : Integer;
    FPopupMenu : TPopupMenu;
    FClickInfo : TClickInfo;
    FClickTimer,
    FHintTimer,
    FTimer : TElTimerPoolItem;
    FTimerPool: TElTimerPool;
    FImgIdx : integer;
    FOnClick : TMouseEvent;
    FOnDblClick : TNotifyEvent;
    FOnMouseDown : TMouseEvent;
    FOnMouseUp : TMouseEvent;
    FOnMouseMove : TMouseMoveEvent;
    FOnAnimationStopped : TNotifyEvent;
    StaticChangeLink,
    MyChangeLink : TChangeLink;
    FInWndProc : boolean;
    FSet : Boolean;
    FIconData : TLMDNotifyIconData; // TNotifyIconData; //chmv
    FIconID   : Cardinal; // UINT
    FLClick   : boolean;
    FMClick   : boolean;
    FRClick   : boolean;
    FExtForm  : TForm;
    FExtFormName: string;
    FExtFormPt  : TPoint;
    FHideForm   : boolean;
    FExtFormInt : boolean;
    FNoShow     : boolean;
    FOnDblClickEx: TMouseEvent;
    FStaticIcons: TCustomImageList;
    FAnimateOnce: Boolean;
    FUseStaticIcons: Boolean;
    FStaticIconIndex: Integer;
    TrayInfoVisible : boolean;
    NewMenuProc: Pointer;
    OldMenuProc: UniPtr;
    procedure SetExtForm(newValue : String);
    procedure SetAnimated(newValue : Boolean);
    procedure SetDesignActive(newValue : Boolean);
    procedure SetIcons(newValue : TCustomImageList);
    procedure SetInterval(newValue : Integer);
    procedure SetPopupMenu(newValue : TPopupMenu);
    procedure SetStaticIcon(newValue : TIcon);
    procedure OnClickTimer(Sender : TObject);
    procedure OnTimer(Sender : TObject);
    procedure OnHintTimer(Sender : TObject);
    procedure OnImagesChange(Sender : TObject);
    procedure SetHint(newValue : string);
    function  DoPopupMenu(X, Y : integer) : boolean;
    function  DoDblClick(Perform : boolean) : boolean;
    procedure SetStaticIcons(Value: TCustomImageList);
    procedure OnStaticIconsChange(Sender : TObject);
  protected
    FTrayInfo: TElTrayInfo;
    FTrayInfoSettings: TElTrayInfoSettings;
    FOnTrayInfoImageNeeded: TElHTMLImageNeededEvent;
    FOnTrayInfoLinkClick: TElHTMLLinkClickEvent;
    procedure TriggerClickEvent(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); virtual;
    procedure TriggerDblClickEvent; virtual;
    procedure TriggerMouseDownEvent(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); virtual;
    procedure TriggerMouseUpEvent(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); virtual;
    procedure TriggerMouseMoveEvent(Shift : TShiftState; X, Y : Integer); virtual;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    procedure PopupMenuProc(var Message : TMessage);
    function HookWndProc(var Message : TMessage): Boolean;
    procedure WndProc(var Message : TMessage); override;
    procedure DoSetEnabled(AEnabled : boolean); override;
    procedure UpdateIconData(remove : boolean); virtual;
    procedure Loaded; override;
    procedure TriggerQueryEndSessionEvent(Action : Integer; var CanClose : boolean); virtual;
    procedure SetExtendedHintDelay(newValue : Cardinal); virtual;
    procedure SetHideTaskBarIcon(newValue : Boolean); virtual;
    procedure DoHideTaskBarIcon;
    procedure DoShowTaskBarIcon;
    procedure TriggerBeforeExtendedHintShowEvent(var DoShow : boolean); virtual;
    function  FindExtForm(Name : string) : TComponentClass;
    procedure TriggerDblClickExEvent(Button : TMouseButton; Shift : TShiftState; X,
        Y : Integer); virtual;
    procedure SetUseStaticIcons(Value: Boolean);
    function GetStaticIconIndex : integer;
    procedure SetStaticIconIndex(Value: Integer);
    procedure UpdateStaticIcon;
    procedure TrayInfoShowHandler(Sender : TObject);
    procedure TrayInfoHideHandler(Sender : TObject);
    procedure SetTrayInfoSettings(Value: TElTrayInfoSettings);
    function AdjustY(Y : integer): Integer;
    procedure LinkClickTransfer(Sender: TObject; HRef: TLMDString); virtual;
    procedure ImageNeededTransfer(Sender: TObject; Src: TLMDString; var Image: TBitmap); virtual;
    procedure TriggerAnimationStopped; virtual;
    procedure PerformIconHiding;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure ShowExtForm(X, Y : Integer);
    property Handle;
    property ExtendedHintForm : TForm read FExtForm;
    property ExtHintWndStyle  : Cardinal read FExtHintWndStyle write FExtHintWndStyle;  { Public }
    property ExtHintWndExStyle: Cardinal read FExtHintWndExStyle write FExtHintWndExStyle;  { Public }
    function ShowBalloonHint(const aInfoTitle, aInfo: String; aFlags: TLMDBalloonFlags = bfNone; aTimeOut: Integer = 10000) : Boolean;
  published
    property Icons : TCustomImageList read FIcons write SetIcons;
    property Animated : Boolean read FAnimated write SetAnimated default false;
    property DesignActive : Boolean read FDesignActive write SetDesignActive default false;
    property Interval : Integer read FInterval write SetInterval default 200;
    property PopupMenu : TPopupMenu read FPopupMenu write SetPopupMenu;
    property OnClick : TMouseEvent read FOnClick write FOnClick;
    property OnDblClick : TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnMouseDown : TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseUp : TMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnMouseMove : TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property StaticIcon : TIcon read FStaticIcon write SetStaticIcon;
    property Hint : string read FHint write SetHint;
    property Enabled;
    property ExtendedHint : String read FExtFormName write SetExtForm;
    property ExtendedHintInteractive : boolean read FExtFormInt write FExtFormInt default false;
    property PopupWhenModal : Boolean read FPopupWhenModal write FPopupWhenModal
      default False;
    property OnQueryEndSession : TQueryEndSessionEvent read FOnQueryEndSession write FOnQueryEndSession;
    property ExtendedHintDelay : Cardinal read FExtendedHintDelay write SetExtendedHintDelay;
    property HideTaskBarIcon : Boolean read FHideTaskBarIcon write SetHideTaskBarIcon default False;
    property OnBeforeExtendedHintShow : TElTrayExtHintShowEvent read FOnBeforeExtendedHintShow write FOnBeforeExtendedHintShow;
    property OnExtHintFormCreate : TElTrayExtHintCreateEvent read FOnExtHintFormCreate write FOnExtHintFormCreate;
    property OnDblClickEx: TMouseEvent read FOnDblClickEx write FOnDblClickEx;
    property AnimateOnce: Boolean read FAnimateOnce write FAnimateOnce default
        false;
    property StaticIcons: TCustomImageList read FStaticIcons write SetStaticIcons;
    property UseStaticIcons: Boolean read FUseStaticIcons write SetUseStaticIcons
        default false;
    property StaticIconIndex: Integer read GetStaticIconIndex write
        SetStaticIconIndex default -1;
    property TrayInfoSettings: TElTrayInfoSettings read FTrayInfoSettings write
        SetTrayInfoSettings;
    property IconID : Cardinal read FIconID write FIconID;
    property OnTrayInfoImageNeeded: TElHTMLImageNeededEvent read FOnTrayInfoImageNeeded write FOnTrayInfoImageNeeded;
    property OnTrayInfoLinkClick: TElHTMLLinkClickEvent read FOnTrayInfoLinkClick write FOnTrayInfoLinkClick;
    property OnAnimationStopped : TNotifyEvent read FOnAnimationStopped write FOnAnimationStopped;
  end;

const
  TrackInterval : integer = 100;
  HideInterval  : integer = 400;

//  FInMenu       : boolean = false;

implementation
uses
  ElMenus;

const
  EL_NOTIFYICON = WM_USER + 1368;
  EL_HIDEICON   = WM_USER + 1369;

type
  TFormHack = TCustomForm;
  TFormClass = class of TForm;

var
  WM_TaskbarRestart: UINT;

procedure TElTrayIcon.SetAnimated(newValue : Boolean);
begin
  if (FAnimated <> newValue) then
  begin
    if csLoading in ComponentState then
      FAnimated := newValue
    else
    begin
      if (newValue and (FIcons <> nil) and (FIcons.Count > 0)) or (not NewValue) then
      begin
        if newValue then
        begin
          FImgIdx := 0;
          FIcons.GetIcon(0, FIcon);
          LMDDebug('SetAnimated');
          UpdateIconData(false);
        end;
        FAnimated := newValue;
        if not FAnimated then
          FTimer.Enabled := false;
      end;
      if not FAnimated then
        UpdateStaticIcon;
      LMDDebug('SetAnimated');
      UpdateIconData(false);
      if FAnimated and FSet then
      begin
        FTimer.Interval := FInterval;
        FTimer.Enabled := true;
      end;
    end;
  end; {if}
end;

procedure TElTrayIcon.SetDesignActive(newValue : Boolean);
begin
  if (FDesignActive <> newValue) then
  begin
    FDesignActive := newValue;
    if (csDesigning in ComponentState) then
    begin
      if FAnimated then
      begin
        FAnimated := false;
        Animated := true;
      end;
      LMDDebug('SetDesignActive');
      UpdateIconData(not FDesignActive);
    end;
  end; {if}
end;

procedure TElTrayIcon.SetIcons(newValue : TCustomImageList);
begin
  if (FIcons <> newValue) then
  begin
    if FIcons <> nil then
    begin
      if not (csDestroying in FIcons.ComponentState) then
        FIcons.RemoveFreeNotification(Self);
      FIcons.UnRegisterChanges(MyChangeLink);
    end;
    FIcons := newValue;
    if NewValue <> nil then
    begin
      NewValue.FreeNotification(Self);
      NewValue.RegisterChanges(MyChangeLink);
      if Animated then
      begin
        FAnimated := false;
        Animated := true;
      end;
    end
    else
    begin
      Animated := false;
    end;
  end; {if}
end;

function TElTrayIcon.FindExtForm(Name : string) : TComponentClass;
var PersClass : TPersistentClass;
begin
  PersClass := GetClass(Name);
  if PersClass = nil then
  begin
    PersClass := GetClass('T' + Name);
    if PersClass = nil then
       raise EClassNotFound.CreateFmt('When you set ElTrayIcon.ExtendedHint to %s, be sure' +
             ' to call RegisterClass(%s) in the Initialization section ' +
             'of the unit, that contains the form.', ['T' + Name, 'T' + Name]);
  end;
  if PersClass.InheritsFrom(TForm) then
     result := TComponentClass(PersClass)
  else
     raise EInvalidCast.Create('Invalid typecast');
end;

procedure TElTrayIcon.SetExtForm(newValue : string);
begin
  if FExtFormName <> newValue then
  begin
    if (not (csDestroying in ComponentState)) and (FExtForm <> nil) and FExtForm.Visible then
    begin
      FExtForm.Hide;
      UpdateIconData(False);
    end;
    if (FExtForm <> nil) {and (newValue = '')} then
      FExtForm := nil
    else
    if (newValue <> '') then
    begin
      if (not (csDesigning in ComponentState)) and (not (csLoading in ComponentState)) then
      begin
        TrayInfoSettings.Enabled := false;
        if Assigned(OnExtHintFormCreate) then OnExtHintFormCreate(Self, newValue, FExtForm);
        if FExtForm = nil then
          FExtForm := TForm(FindExtForm(newValue).Create(Application));
      end;
    end;
    if Assigned(FExtForm) then
      if not (csDestroying in FExtForm.ComponentState) then
        FExtForm.RemoveFreeNotification(Self);
    FExtFormName := newValue;
    if Assigned(FExtForm) then
      FExtForm.FreeNotification(Self);
    if Handle <> 0 then
    begin
      LMDDebug('SetExtForm');
      UpdateIconData(false);
    end;
  end;
end;

procedure TElTrayIcon.SetInterval(newValue : Integer);
begin
  if (FInterval <> newValue) then
  begin
    FInterval := newValue;
    if FAnimated then
    begin
      FAnimated := false;
      Animated := true;
    end;
  end; {if}
end;

  type TProxyElPopupMenu = class(TElPopupMenu);

procedure TElTrayIcon.SetPopupMenu(newValue : TPopupMenu);
begin
  if (FPopupMenu <> newValue) then
  begin
    if FPopupMenu <> nil then
      if not (csDestroying in FPopupMenu.ComponentState) then
        FPopupMenu.RemoveFreeNotification(Self);
    if NewValue <> nil then
    begin
      NewValue.FreeNotification(Self);
      OldMenuProc := UniPtr(GetWindowLong(PopupList.Window, GWL_WNDPROC));
      // todo Check in future
      if NewMenuProc <> OldMenuProc then
      begin
{$warnings off}
        NewMenuProc := MakeObjectInstance(PopupMenuProc);
{$warnings on}
        SetWindowLong(PopupList.Window, GWL_WNDPROC, TLMDPtrInt(NewMenuProc));
        end;
      end else
    begin
      if Assigned(OldMenuProc) and Assigned(PopupList) then
        SetWindowLong(PopupList.Window, GWL_WNDPROC, TLMDPtrInt(OldMenuProc));
      if Assigned(NewMenuProc) then
{$warnings off}
        FreeObjectInstance(NewMenuProc);
{$warnings on}
      end;
    FPopupMenu := newValue;
    if (FPopupMenu is TElPopupMenu) then
      TProxyElPopupmenu(FPopupMenu).FMustBeInScreen := True;
      end; {if}
end;

procedure TElTrayIcon.Notification(AComponent : TComponent; Operation :
  TOperation);
begin
  inherited;
  if (Operation = opRemove) then
  begin
    if AComponent = FExtForm then
    begin
      FHintTimer.Enabled := false;

      FExtForm := nil;
      FExtFormName := '';
    end;
    if AComponent = FPopupMenu then PopupMenu := nil;
    if AComponent = FIcons then
    begin
      FIcons.UnRegisterChanges(MyChangeLink);
      Icons := nil;
    end;
    if AComponent = FStaticIcons then
    begin
      FStaticIcons.UnRegisterChanges(StaticChangeLink);
      StaticIcons := nil;
    end;
  end;
end;

procedure TElTrayIcon.WndProc(var Message : TMessage);
var
  P : TPoint;
  R : TRect;
  i : DWORD;
  CanClose : boolean;
begin
  if Message.Msg = EL_HIDEICON then
  begin
    PerformIconHiding;
  end
  else
  if Message.Msg = EL_NOTIFYICON then
  begin
    FInWndProc := true;
    i := GetMessagePos();
    P.X := LOWORD(i);
    P.Y := HIWORD(i);
    R := GetSysTrayRect;
    if not PtInRect(R, P) then
      GetCursorPos(P);
    case Message.LParam of //
    WM_LBUTTONDOWN :
        begin
          if FRClick then
          begin
            FRClick := false;
            FClickTimer.Enabled := false;
            TriggerClickEvent(FClickInfo.Button, FClickInfo.Shift, FClickInfo.X, FClickInfo.Y);
          end;
          if FMClick then
          begin
            FMClick := false;
            FClickTimer.Enabled := false;
            TriggerClickEvent(FClickInfo.Button, FClickInfo.Shift, FClickInfo.X, FClickInfo.Y);
          end;

          FClickTimer.Enabled := false;

          if FHintTimer.Enabled and ((TrayInfoSettings.Enabled and not TrayInfoVisible) or ((FExtForm <> nil) and (not FExtForm.Visible))) then
             FHintTimer.Enabled := false;
          FLClick := true;
          TriggerMouseDownEvent(mbLeft, LMDGetShiftState + [ssLeft], P.X, P.Y);
        end;
      WM_LBUTTONUP :
        begin
          FClickTimer.Enabled := false;

          if FHintTimer.Enabled and ((TrayInfoSettings.Enabled and not TrayInfoVisible) or ((FExtForm <> nil) and (not FExtForm.Visible))) then
             FHintTimer.Enabled := false;
          if FLClick then
          begin
            FLClick := false;
            if Assigned(FOnDblClick) or DoDblClick(false) then
            begin
              FClickTimer.Interval := GetDoubleClickTime;

              FClickInfo.Button := mbLeft;
              FClickInfo.Shift := LMDGetShiftState + [ssLeft];
              FClickInfo.X := P.X;
              FClickInfo.Y := P.Y;

              FClickTimer.Enabled := true;
            end else
              TriggerClickEvent(mbLeft, LMDGetShiftState + [ssLeft], P.X, P.Y);
          end;
          TriggerMouseUpEvent(mbLeft, LMDGetShiftState + [ssLeft], P.X, P.Y);
        end;
      WM_RBUTTONDOWN :
        begin
          if FLClick then
          begin
            FLClick := false;
            FClickTimer.Enabled := false;
            TriggerClickEvent(FClickInfo.Button, FClickInfo.Shift, FClickInfo.X, FClickInfo.Y);
          end;
          if FMClick then
          begin
            FMClick := false;
            FClickTimer.Enabled := false;
            TriggerClickEvent(FClickInfo.Button, FClickInfo.Shift, FClickInfo.X, FClickInfo.Y);
          end;

          FClickTimer.Enabled := false;
          if FHintTimer.Enabled and ((TrayInfoSettings.Enabled and not TrayInfoVisible) or ((FExtForm <> nil) and (not FExtForm.Visible))) then
             FHintTimer.Enabled := false;
          FRClick := true;
          TriggerMouseDownEvent(mbRight, LMDGetShiftState + [ssRight], P.X, P.Y);
        end;
      WM_RBUTTONUP :
        begin
          FClickTimer.Enabled := false;
          if FHintTimer.Enabled and ((TrayInfoSettings.Enabled and not TrayInfoVisible) or ((FExtForm <> nil) and (not FExtForm.Visible))) then
             FHintTimer.Enabled := false;
          if FRClick then
          begin
            FRClick := false;
            if not DoPopupMenu(P.X, P.Y) then
            begin
              if Assigned(FOnDblClick) or DoDblClick(false) then
              begin

                FClickTimer.Interval := GetDoubleClickTime;

                FClickInfo.Button := mbRight;
                FClickInfo.Shift := LMDGetShiftState + [ssRight];
                FClickInfo.X := P.X;
                FClickInfo.Y := P.Y;

                FClickTimer.Enabled := true;
              end
              else
                TriggerClickEvent(mbRight, LMDGetShiftState + [ssRight], P.X, P.Y);
            end
            else
              FHintTimer.Enabled := false;
          end;
          TriggerMouseUpEvent(mbRight, LMDGetShiftState + [ssRight], P.X, P.Y);
        end;
      WM_MBUTTONDOWN :
        begin
          FClickTimer.Enabled := false;
          if FRClick then
          begin
            FRClick := false;
            FClickTimer.Enabled := false;
            TriggerClickEvent(FClickInfo.Button, FClickInfo.Shift, FClickInfo.X, FClickInfo.Y);
          end;
          if FLClick then
          begin
            FLClick := false;
            FClickTimer.Enabled := false;
            TriggerClickEvent(FClickInfo.Button, FClickInfo.Shift, FClickInfo.X, FClickInfo.Y);
          end;

          if FHintTimer.Enabled and ((TrayInfoSettings.Enabled and not TrayInfoVisible) or ((FExtForm <> nil) and (not FExtForm.Visible))) then
            FHintTimer.Enabled := false;
          TriggerMouseDownEvent(mbMiddle, LMDGetShiftState + [ssMiddle], P.X, P.Y);
        end;
      WM_MBUTTONUP :
        begin
          FClickTimer.Enabled := false;
          if FHintTimer.Enabled and ((TrayInfoSettings.Enabled and not TrayInfoVisible) or ((FExtForm <> nil) and (not FExtForm.Visible))) then
            FHintTimer.Enabled := false;
          if Assigned(FOnDblClick) or DoDblClick(false) then
          begin
            FClickTimer.Interval := GetDoubleClickTime;

            FClickInfo.Button := mbMiddle;
            FClickInfo.Shift := LMDGetShiftState + [ssMiddle];
            FClickInfo.X := P.X;
            FClickInfo.Y := P.Y;

            FClickTimer.Enabled := true;

          end
          else
            TriggerClickEvent(mbMiddle, LMDGetShiftState + [ssMiddle], P.X, P.Y);

          TriggerMouseUpEvent(mbMiddle, LMDGetShiftState + [ssMiddle], P.X, P.Y);
        end;
      WM_LBUTTONDBLCLK :
        begin
          FClickTimer.Enabled := false;
          if FHintTimer.Enabled and ((TrayInfoSettings.Enabled and not TrayInfoVisible) or ((FExtForm <> nil) and (not FExtForm.Visible))) then
            FHintTimer.Enabled := false;
          if (not FPopupWhenModal) and ModalFormVisible then
          begin
          end
          else
          if not DoDblClick(true) then
          begin
            TriggerDblClickEvent;
            TriggerDblClickExEvent(mbLeft, LMDGetShiftState + [ssLeft], P.X, P.Y);
          end;
        end;
      WM_MBUTTONDBLCLK :
        begin
          FClickTimer.Enabled := false;
          TriggerDblClickEvent;
          TriggerDblClickExEvent(mbMiddle, LMDGetShiftState + [ssMiddle], P.X, P.Y);
        end;
      WM_RBUTTONDBLCLK :
        begin
          FClickTimer.Enabled := false;
          TriggerDblClickEvent;
          TriggerDblClickExEvent(mbRight, LMDGetShiftState + [ssRight], P.X, P.Y);
        end;
      WM_MOUSEMOVE :
        begin
          TriggerMouseMoveEvent(LMDGetShiftState, P.X, P.Y);
          if not (csDesigning in ComponentState) then
          begin
            FExtFormPt := P;
            if FHideForm = true then
            begin
              FHideForm := false;
              FHintTimer.Interval := TrackInterval;
            end
            else
            if ((TrayInfoSettings.Enabled) and (not FNoShow) and (not TrayInfoVisible)) or
               ((FExtForm <> nil) and (not FExtForm.Visible) and (not FNoShow)) then
            begin
              if FExtendedHintDelay = 0 then
              begin
                //if not FInMenu then
                if TrayInfoSettings.Enabled then
                  begin
                    FTrayInfo.ShowEx(P.X, AdjustY(P.Y), true);
                    FHintTimer.Interval := TrackInterval;
                    if not FPopupVis then
                       FHintTimer.Enabled := true;
                  end
                  else
                    ShowExtForm(P.X, P.Y);
              end
              else
              begin
                FHintTimer.Interval := FExtendedHintDelay;
                if not FPopupVis then
                  FHintTimer.Enabled := true;
              end;
            end;
          end;
        end;
      else
        Message.Result := DefWindowProc(FHandle, Message.Msg, Message.wParam, Message.lParam);
    end; // case
    FInWndProc := false;
  end
  else
  if Message.Msg = WM_QUERYENDSESSION then
  begin
    Message.Result := 1;
    if Assigned(FOnQueryEndSession) then
    begin
      CanClose := true;
      FOnQueryEndSession(Self, Message.LParam, CanClose);
      if not CanClose then
        Message.Result := 0;
    end;
  end
  else
  if Cardinal(Message.Msg) = WM_TaskbarRestart then
  begin
    if FSet then
    begin
      FSet := False;
      LMDDebug('TaskbarRestart');
      UpdateIconData(False);
    end;
  end
  else
    Message.Result := DefWindowProc(FHandle, Message.Msg, Message.wParam, Message.lParam);
end;

procedure TElTrayIcon.TriggerClickEvent(Button : TMouseButton; Shift :
  TShiftState; X, Y : Integer);
begin
  if (assigned(FOnClick)) then FOnClick(Self, Button, Shift, X, Y);
end;

procedure TElTrayIcon.TriggerDblClickEvent;
begin
  if (assigned(FOnDblClick)) then FOnDblClick(Self);
end;

procedure TElTrayIcon.TriggerMouseDownEvent(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
begin
  if (assigned(FOnMouseDown)) then FOnMouseDown(Self, Button, Shift, X, Y);
end;

procedure TElTrayIcon.TriggerMouseUpEvent(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
begin
  if (assigned(FOnMouseUp)) then
    FOnMouseUp(Self, Button, Shift, X, Y);
end;

procedure TElTrayIcon.TriggerMouseMoveEvent(Shift : TShiftState; X, Y : Integer);
begin
  if (assigned(FOnMouseMove)) then OnMouseMove(Self, Shift, X, Y);
end;

procedure TElTrayIcon.DoSetEnabled(AEnabled : boolean);
begin
  if Enabled <> AEnabled then
  begin
    if AEnabled then
    begin
      inherited;
      FEnabled := true;
      if FHideTaskBarIcon and IsIconic(Application.Handle) then DoHideTaskBarIcon;
      if FAnimated then
      begin
        FAnimated := false;
        Animated := true;
      end;
      LMDDebug('doSetEnabled');
      if (ComponentState * [csLoading, csReading] = []) then
        UpdateIconData(false);
    end
    else
    begin
      if FInWndProc then
      begin
        PostMessage(Self.FHandle, EL_HIDEICON, 0, 0)
      end
      else
      begin
        PerformIconHiding;
        inherited;
      end;
    end;
  end;
end;

procedure TElTrayIcon.SetStaticIcon(newValue : TIcon);
begin
  FStaticIcon.Assign(newValue);
  if not Animated then
  begin
    FIcon.Assign(FStaticIcon);
    LMDDebug('SetStaticIcon');
    UpdateIconData(false);
  end;
end;

procedure TElTrayIcon.OnImagesChange(Sender : TObject);
begin
  if Animated and (not (csLoading in ComponentState)) and ((FIcons = nil) or (FIcons.Count = 0)) then
    Animated := false;

  if (ComponentState * [csLoading, csReading] = []) then
  begin
    if not FAnimated then
      UpdateStaticIcon;
    LMDDebug('OnImagesChange');
    UpdateIconData(false);
  end;
end;

procedure TElTrayIcon.OnHintTimer(Sender : TObject);
var P : TPoint;
    b : boolean;

    function MouseOnHint : boolean;
    var Wnd : HWND;
    begin
      result := false;
      Wnd := WindowFromPoint(P);
      while Wnd <> 0 do
      begin
        if (TrayInfoSettings.Enabled and (FTrayInfo.InfoForm <> nil) and (Wnd = FTrayInfo.InfoForm.Handle)) or
           (Wnd = FExtForm.Handle) then
        begin
          result := true;
          exit;
        end;
        Wnd := GetParent(Wnd);
      end;
    end;

begin
  if (FExtForm = nil) and (not TrayInfoSettings.Enabled) then
    exit;
  if TrayInfoSettings.Enabled then
  begin
    if TrayInfoVisible then
    begin
      GetCursorPos(p);
      if FHideForm then
      begin
        FHideForm := false;
        FNoShow := true;
        FTrayInfo.Hide;
        FNoShow := false;
        FHintTimer.Enabled := false;
      end
      else
      begin

        //if (FExtFormPt.x <> P.x) or (FExtFormPt.y <> P.y) then
        if (not LMDInRange(P.x, FExtFormPt.x - 3, FExtFormPt.x + 3)) or (not LMDInRange(P.y, FExtFormPt.y - 3, FExtFormPt.y + 3)) then
        begin
          FHideForm := true;
          FHintTimer.Enabled := false;
          FHintTimer.Enabled := true;
          FHintTimer.Interval := HideInterval div 2;
        end;
      end;
    end
    else
    begin
      FHintTimer.Enabled := false;
      //if not FInMenu then
      begin
        GetCursorPos(p);
        if ((LMDInRange(P.x, FExtFormPt.x - 16, FExtFormPt.x + 16)) and (LMDInRange(P.y, FExtFormPt.y - 16, FExtFormPt.y + 16))) then
        begin
          FTrayInfo.ShowEx(P.X, AdjustY(P.Y), true);
          FHintTimer.Interval := TrackInterval;
          FHintTimer.Enabled := true;
        end;
      end;
      FNoShow := false;
    end;
  end
  else
  // extended form
  if FExtForm.Visible then
  begin
    GetCursorPos(p);
    if FHideForm then
    begin
      FHideForm := false;
      if (MouseOnHint or ((FExtForm <> nil) and ({Application.Active} (GetWindowThreadProcessID(GetForegroundWindow(), nil) = GetCurrentProcessID) and FExtForm.Active))) and FExtFormInt then
      begin
        FHintTimer.Interval := TrackInterval;
      end
      else
      begin
        FNoShow := true;
        FExtForm.Hide;
        UpdateIconData(False);
        FNoShow := false;
        FHintTimer.Enabled := false;
      end;
    end else
    if ((not LMDInRange(P.x, FExtFormPt.x - 16, FExtFormPt.x + 16)) or (not LMDInRange(P.y, FExtFormPt.y - 16, FExtFormPt.y + 16)))
    {if ((P.x <> FExtFormPt.x) or (P.y <> FExtFormPt.y)) }and (not (FExtFormInt and MouseOnHint)) then
    begin
      FHideForm := true;
      FHintTimer.Interval := HideInterval;
    end;
  end
  else
  begin
    FHintTimer.Enabled := false;
    //if not FInMenu then
    begin
      GetCursorPos(p);
      if ((LMDInRange(P.x, FExtFormPt.x - 16, FExtFormPt.x + 16)) and (LMDInRange(P.y, FExtFormPt.y - 16, FExtFormPt.y + 16))) then
      begin

        TriggerBeforeExtendedHintShowEvent(b);
        if b then
           ShowExtForm(P.X, P.Y);
      end;
    end;
    FNoShow := false;
  end;
end;

procedure TElTrayIcon.OnClickTimer(Sender : TObject);
begin
  FClickTimer.Enabled := false;
  TriggerClickEvent(FClickInfo.Button, FClickInfo.Shift, FClickInfo.X, FClickInfo.Y);
end;

procedure TElTrayIcon.OnTimer(Sender : TObject);
begin
  if FImgIdx >= (FIcons.Count - 1) then
  begin
    FImgIdx := 0;
    if AnimateOnce then
    begin
      Animated := false;
      TriggerAnimationStopped;
      exit;
    end;
  end
  else
    inc(FImgIdx);
  FIcons.GetIcon(FImgIdx, FIcon);
  LMDDebug('OnTimer');
  UpdateIconData(false);
end;

procedure TElTrayIcon.UpdateIconData;
begin
  if not Iswindow(FHandle) then
    LMDDebug('Invalid window')
  else
    LMDDebug('window OK');
  FIconData.Wnd := FHandle;
  FIconData.uID := FIconID;
  FIconData.uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;

  FIconData.uCallbackMessage := EL_NOTIFYICON;
  if FIcon <> nil then
    FIconData.hIcon := FIcon.Handle
  else
    FIconData.hIcon := 0;
  if (not TrayInfoSettings.Enabled) and ((FExtForm = nil) or ((FExtForm <> nil) and (not FExtForm.Visible))) then
    if LMDSIWindows2000Up then
      StrPLCopy(FIconData.szTip, Hint, 127)
    else
      StrPLCopy(FIconData.szTip, Hint, 63)
  else
    StrPCopy(FIconData.szTip, '');
  if FSet then
  begin
    if Remove then
    begin
      {$IFNDEF LMDCOMP10}
      Shell_NotifyIcon(NIM_DELETE, PNotifyIconData(@FIconData));
      {$ELSE}
      Shell_NotifyIcon(NIM_DELETE, @FIconData);
      {$ENDIF}
      FSet := false;
    end
    else
    begin
      LMDDebug('Updating icon');
      {$IFNDEF LMDCOMP10}
      Shell_NotifyIcon(NIM_MODIFY, PNotifyIconData(@FIconData));
      {$ELSE}
      Shell_NotifyIcon(NIM_MODIFY, @FIconData);
      {$ENDIF}
    end;
  end
  else
  begin
    if (not Remove) and FEnabled and (FDesignActive or (not (csDesigning in ComponentState))) then
    begin
      LMDDebug('Adding icon');
      {$IFNDEF LMDCOMP10}
      Shell_NotifyIcon(NIM_ADD, PNotifyIconData(@FIconData));
      {$ELSE}
      Shell_NotifyIcon(NIM_ADD, @FIconData);
      {$ENDIF}
      FSet := true;
    end;
  end;
end;

function TElTrayIcon.DoDblClick(Perform : boolean) : boolean;
var
  i : integer;
begin
  result := false;
  if Assigned(FPopupMenu) and (not (csDesigning in ComponentState)) and (FPopupMenu.Items <> nil) then
  begin
    for i := 0 to FPopupMenu.Items.Count - 1 do // Iterate
    begin
      if FPopupMenu.Items[i].Enabled and (FPopupMenu.Items[i].Default) then
      begin
        if Perform then
           FPopupMenu.Items[i].Click;
        result := true;
        exit;
      end;
    end; // for
  end;
end;

function TElTrayIcon.DoPopupMenu;
var
  F : TForm;
begin
  result := false;
  if (not FPopupWhenModal) and ModalFormVisible then exit;
  if Assigned(FPopupMenu) and (FPopupMenu.AutoPopup) and Enabled and (not (csDesigning in ComponentState)) then
  begin
    FPopupMenu.PopupComponent := Self;
    if not (csDestroying in ComponentState) then
    begin
      F := Screen.ActiveForm;
      if F = nil then F := Application.MainForm;
      if F <> nil then F.SendCancelMode(nil);
    end;
    if IsWindowEnabled(FHandle) then SetForegroundWindow(FHandle);
    Application.ProcessMessages;

    if TrayInfoSettings.Enabled then
    begin
      if not TrayInfoVisible then
        FHintTimer.Enabled := false;
    end
    else
    begin
      if (FExtForm <> nil) and (not FExtForm.Visible) then
         FHintTimer.Enabled := false;
    end;
    //FInMenu := true;
    if TrayInfoVisible then
      FTrayInfo.Hide
    else
    if (FExtForm <> nil) and FExtForm.Visible then
    begin
      FExtForm.Hide;
      UpdateIconData(False);
    end;
    // if FHintTimer <> nil then
      FHintTimer.Enabled := false;
    FPopupVis := True;
    FPopupMenu.Popup(X, Y);
    FPopupVis := False;
    if IsWindowEnabled(FHandle) then
      SetForegroundWindow(FHandle);
    result := true;
  end;
end;

procedure TElTrayIcon.SetHint(newValue : string);
begin
  if (FHint <> newValue) then
  begin
    FHint := newValue;
    LMDDebug('setHint');
    if (ComponentState * [csLoading, csReading] = []) then
      UpdateIconData(false);
  end; {if}
end;

var
  AppWndProc: Pointer;

function NoActWndProc(Window: HWND; Message, WParam: Longint;
                    LParam: Longint): Longint; stdcall;

begin
  Result := 0;
  if (Message = WM_ACTIVATEAPP) and (wParam = 1) then
  begin
    result := 0;
  end
  else
  if (Message = WM_WINDOWPOSCHANGING) then
  begin
    with PWindowPos(lParam)^ do
    if (flags and SWP_SHOWWINDOW = SWP_SHOWWINDOW) then
      begin
        flags := flags and (not SWP_SHOWWINDOW);
        Result := 0;
        end;
  end
  else
    Result := CallWindowProc(AppWndProc, Window, Message, wParam, lParam);
end;

procedure HookAppl;
begin
  AppWndProc := UniPtr(GetWindowLong(Application.Handle, GWL_WNDPROC));
  SetWindowLong(Application.Handle, GWL_WNDPROC, TLMDPtrInt(@NoActWndProc));
  end;

procedure UnHookAppl;
begin
  SetWindowLong(Application.Handle, GWL_WNDPROC, TLMDPtrInt(AppWndProc));
end;

procedure TElTrayIcon.ShowExtForm(X, Y : Integer);
var H1,
    H2,
    H3 : HWND;
    R2,
    R1,
    R3 : TRect;
    TBarAlign : TTaskBarEdge;
    DesktopWidth,
    DesktopHeight : integer;
    H3Visible : boolean;

const EnabledStyle : array[boolean] of Cardinal = (WS_DISABLED, 0);

begin
  H1 := FindWindow('Shell_TrayWnd', nil);
  if H1 <> 0 then
  begin
    H2 := FindWindowEx(H1, 0, 'TrayNotifyWnd', nil);
    if H2 <> 0 then
    begin
      // NotifyIconOverflowWindow -- window class that has window with hidden icons (chmv)
      H3 := FindWindow('NotifyIconOverflowWindow', nil);
      if H3 <> 0 then
      begin
        GetWindowRect(H3, R3);
        H3Visible := IsWindowVisible(H3);
      end
      else
        H3Visible := False;
      HookAppl;
      DesktopWidth  := GetSystemMetrics(SM_CXFULLSCREEN);
      DesktopHeight := GetSystemMetrics(SM_CYFULLSCREEN);
      TBarAlign := GetTaskbarEdge;
      GetWindowRect(H1, R1);
      GetWindowRect(H2, R2);
      case TBarAlign of
        tbeBottom: begin
             if H3Visible then
               R1.Top := R3.Top - FExtForm.Height - 2
             else
               R1.Top := R2.Top - FExtForm.Height - 2;
             R1.Left := X;
             if R1.Left + FExtForm.Width > DesktopWidth then
                R1.Left := DesktopWidth - FExtForm.Width;
           end;
        tbeLeft: begin
             if H3Visible then
               R1.Left := R3.Right + 2
             else
               R1.Left := R2.Right + 2;
             R1.Top := Y;
             if R1.Top + FExtForm.Height > DesktopHeight then
                R1.Top := DesktopHeight - FExtForm.Height;
           end;
        tbeTop: begin
             if H3Visible then
               R1.Top := R3.Bottom + 2
             else
               R1.Top := R2.Bottom + 2;
             R1.Left := X;
             if R1.Left + FExtForm.Width > DesktopWidth then
                R1.Left := DesktopWidth - FExtForm.Width;
           end;
        tbeRight: begin
             if H3Visible then
               R1.Left := R3.Left - FExtForm.Width - 2
             else
               R1.Left := R2.Left - FExtForm.Width - 2;
             R1.Top := Y;
             if R1.Top + FExtForm.Height > DesktopHeight then
               R1.Top := DesktopHeight - FExtForm.Height;
             if R1.Left + FExtForm.Width > DesktopWidth then
               R1.Left := DesktopWidth - FExtForm.Width;
           end;
      end;
      FExtForm.Left := R1.Left;
      FExtForm.Top := R1.Top;
      FExtForm.Position := poDesigned;
      FExtForm.FormStyle := fsStayOnTop;
      FExtForm.BorderStyle := bsNone;

      H1 := GetForegroundWindow;

      FExtForm.ParentWindow := Handle;
      FExtForm.HandleNeeded;
      if FExtHintWndStyle <> 0 then
         SetWindowLong(FExtForm.Handle, Integer(GWL_STYLE), FExtHintWndStyle)
      else
         SetWindowLong(FExtForm.Handle, Integer(GWL_STYLE), WS_POPUP or EnabledStyle[ExtendedHintInteractive]);
      if FExtHintWndExStyle <> 0 then
         SetWindowLong(FExtForm.Handle, GWL_EXSTYLE, FExtHintWndExStyle)
      else
         SetWindowLong(FExtForm.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW or WS_EX_TOPMOST);
      SetParent(FExtForm.Handle, 0);
      FExtForm.Visible := true;
      UpdateIconData(False);
      FHintTimer.Interval := TrackInterval;
      SetWindowPos(FExtForm.Handle, HWND_TOPMOST, 0,0,0,0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE);
      FHintTimer.Enabled := true;
      SetForegroundWindow(H1);
      UnHookAppl;
    end;
  end;
end;

procedure TElTrayIcon.Loaded;
begin
  inherited;
  if UseStaticIcons and (FStaticIcons <> nil) and (FStaticIcons.Count = 0) then
    UseStaticIcons := false;
  if Animated then
  begin
    FAnimated := false;
    Animated := true;
  end
  else
  begin
    UpdateStaticIcon;
    LMDDebug('Loaded');
    UpdateIconData(false);
  end;

  if (ExtendedHint <> '') and (not (csDesigning in ComponentState)) then
  begin
    if Assigned(OnExtHintFormCreate) then
      OnExtHintFormCreate(Self, ExtendedHint, FExtForm);
    if FExtForm = nil then
       FExtForm := TForm(FindExtForm(ExtendedHint).Create(Application));
  end;
  if Self.FHideTaskBarIcon then DoHideTaskbarIcon;
end;

procedure TElTrayIcon.TriggerQueryEndSessionEvent(Action : Integer; var CanClose : boolean);
{ Triggers the OnQueryEndSession event. This is a virtual method (descendants of this component can override it). }
begin
  if (assigned(FOnQueryEndSession)) then
    FOnQueryEndSession(Self, Action , CanClose );
end;  { TriggerQueryEndSessionEvent }

procedure TElTrayIcon.SetExtendedHintDelay(newValue : Cardinal);
{ Sets data member FExtendedHintDelay to newValue. }
begin
  if (FExtendedHintDelay <> newValue) and ((newValue = 0) or (newValue > 50)) then
    FExtendedHintDelay := newValue;
end;  { SetExtendedHintDelay }

procedure TElTrayIcon.SetHideTaskBarIcon(newValue : Boolean);
{ Sets data member FHideTaskBarIcon to newValue. }
begin
  if (FHideTaskBarIcon <> newValue) then
  begin
    FHideTaskBarIcon := newValue;
    if Enabled and IsIconic(Application.Handle) then
    begin
      if FHideTaskBarIcon then
         DoHideTaskBarIcon
       else
         DoShowTaskBarIcon;
    end;
  end;  { if }
end;  { SetHideTaskBarIcon }

procedure TElTrayIcon.PopupMenuProc(var Message : TMessage);
begin
  if not Enabled or (csDesigning in ComponentState) then
     Message.Result := CallWindowProc(OldMenuProc, PopupList.Window, Message.Msg, Message.wParam, Message.lParam)
  else
  begin
    if Message.Msg = WM_QUERYENDSESSION then
    begin
      Message.result := 1;
      exit;
    end;
    Message.Result := CallWindowProc(OldMenuProc, PopupList.Window, Message.Msg, Message.wParam, Message.lParam);
    (*
    if Message.Msg = WM_EXITMENULOOP then
       FInMenu := false;
    if Message.Msg = WM_INITMENUPOPUP then
    begin
      if Message.wParam <> Integer(FPopupMenu.Handle) then FInMenu := false;
    end;
    *)
  end;
end;

function TElTrayIcon.HookWndProc(var Message : TMessage): Boolean;
begin
  if not Enabled or (csDesigning in ComponentState) then
  else
  begin
    if FHideTaskBarIcon and (Message.Msg = WM_SIZE) and (Message.wParam = SIZE_MINIMIZED) then
       DoHideTaskBarIcon;
    if (Message.Msg = WM_SYSCOMMAND) then
    begin
      if FHideTaskBarIcon and (Message.WParam and $FFF0 = SC_RESTORE) then
         DoShowTaskBarIcon;
    end;
  end;
  result := false;
end;

procedure TElTrayIcon.DoHideTaskBarIcon;  { protected }
begin
  if not (csDesigning in ComponentState) then
     ShowWindow(Application.Handle, SW_HIDE);
end;  { DoHideTaskBarIcon }

procedure TElTrayIcon.DoShowTaskBarIcon;  { protected }
begin
  ShowWindow(Application.Handle, SW_SHOW);
end;  { DoShowTaskBarIcon }

procedure TElTrayIcon.TriggerBeforeExtendedHintShowEvent(var DoShow : boolean);

begin
  DoShow := true;
  if (assigned(FOnBeforeExtendedHintShow)) then
    FOnBeforeExtendedHintShow(Self, DoShow );
  if (DoShow) then
  begin

  end;
end;  { TriggerBeforeExtendedHintShowEvent }

destructor TElTrayIcon.Destroy;
begin
  Destroying;
  SetIcons(nil);

  FHintTimer.Enabled := false;

  FExtForm := nil;
  FExtFormName := '';

  FHintTimer.Free;
  FHintTimer := nil;
  FTimer.Free;
  FTimer := nil;
  FStaticIcon.Free;
  FStaticIcon := nil;
  FIcon.Free;
  FIcon := nil;
  PopupMenu := nil;
  MyChangeLink.Free;
  StaticChangeLink.Free;
  Application.UnhookMainWindow(HookWndProc);

  FTrayInfo.Free;
  FTrayInfoSettings.Free;
  FTimerPool.Free;
  inherited;
end;

constructor TElTrayIcon.Create(AOwner : TComponent);
begin
  inherited;
  FIconID := Random(MaxInt);
  FIcon := TIcon.Create;
  FInterval := 200;
  FStaticIcon := TIcon.Create;
  FStaticIcon.OnChange := OnImagesChange;

  FTimerPool := TElTimerPool.Create(nil);
  FTimerPool.Precise := false;
  FTimer := FTimerPool.Items.Add;
  FTimer.OnTimer := OnTimer;

  FClickTimer := FTimerPool.Items.Add;
  FClickTimer.OnTimer := OnClickTimer;

  FHintTimer := FTimerPool.Items.Add;
  FHintTimer.Interval := ExtendedHintDelay;
  FHintTimer.OnTimer  := OnHintTimer;

  MyChangeLink := TChangeLink.Create;
  MyChangeLink.OnChange := OnImagesChange;

  StaticChangeLink := TChangeLink.Create;
  StaticChangeLink.OnChange := OnStaticIconsChange;

  FTrayInfo := TElTrayInfo.Create(nil);
  FTrayInfoSettings := TElTrayInfoSettings.Create(Self);
  FTrayInfo.OnShow := TrayInfoShowHandler;
  FTrayInfo.OnHide := TrayInfoHideHandler;
  FTrayInfo.OnImageNeeded := ImageNeededTransfer;
  FTrayInfo.OnLinkClick := LinkClickTransfer;

  if LMDSIWindowsVistaUp then
    FIconData.cbSize := sizeof(FIconData)
  else
  if LMDSIWindowsXPUp then
    FIconData.cbSize := NOTIFYICONDATA_V3_SIZE
  else
  if LMDSIWindows2000Up then
    FIconData.cbSize := NOTIFYICONDATA_V2_SIZE
  else
    FIconData.cbSize := NOTIFYICONDATA_V1_SIZE;

  FPopupWhenModal := False;
  FExtendedHintDelay := Application.HintPause;
  { Initialize properties with default values: }
  FHideTaskBarIcon := False;
  Application.HookMainWindow(HookWndProc);
  FStaticIconIndex := -1;
end;

procedure TElTrayIcon.TriggerDblClickExEvent(Button : TMouseButton; Shift :
    TShiftState; X, Y : Integer);
begin
  if (assigned(FOnDblClickEx)) then FOnDblClickEx(Self, Button, Shift, X, Y);
end;

procedure TElTrayIcon.SetStaticIcons(Value: TCustomImageList);
begin
  if (FStaticIcons <> Value) then
  begin
    if FStaticIcons <> nil then
    begin
      if not (csDestroying in FStaticIcons.ComponentState) then
        FStaticIcons.RemoveFreeNotification(Self);
      FStaticIcons.UnRegisterChanges(StaticChangeLink);
    end;
    FStaticIcons := Value;
    if Value <> nil then
    begin
      Value.FreeNotification(Self);
      Value.RegisterChanges(StaticChangeLink);
      if (ComponentState * [csLoading, csReading] = []) and UseStaticIcons and (FStaticIcons <> nil) then
        UpdateStaticIcon;
    end
    else
      UseStaticIcons := false;
  end; {if}
end;

procedure TElTrayIcon.SetUseStaticIcons(Value: Boolean);
begin
  if (FUseStaticIcons <> Value) and ((FUseStaticIcons = false) or (FStaticIcons = nil) or (FStaticIcons.Count > 0)) then
  begin
    FUseStaticIcons := Value;
    if (ComponentState * [csLoading, csReading] = []) then
      UpdateStaticIcon;
  end;
end;

function TElTrayIcon.GetStaticIconIndex : integer;
begin
  result := FStaticIconIndex;
end;

procedure TElTrayIcon.SetStaticIconIndex(Value: Integer);
begin
  //assert(FStaticIconIndex = 5);
  if FStaticIconIndex <> Value then
  begin
    FStaticIconIndex := Value;
    if UseStaticIcons and (FStaticIcons <> nil) then
      UpdateStaticIcon;
  end;
end;

procedure TElTrayIcon.OnStaticIconsChange(Sender : TObject);
begin
  if UseStaticIcons and (ComponentState * [csLoading, csReading] = []) and (FStaticIcons <> nil) and (FStaticIcons.Count = 0) then
    UseStaticIcons := false;
  LMDDebug('OnStaticIconsChange');
  if (ComponentState * [csLoading, csReading] = []) then
    UpdateIconData(false);
end;

procedure TElTrayIcon.UpdateStaticIcon;
begin
  if UseStaticIcons and (FStaticIcons <> nil) and (LMDInRange(FStaticIconIndex, 0, FStaticIcons.Count - 1)) then
  begin
    FStaticIcons.GetIcon(FStaticIconIndex, FIcon)
  end
  else
    FIcon.Assign(FStaticIcon);

  LMDDebug('UpdateStaticIcon');
  if (ComponentState * [csLoading, csReading] = []) then
    UpdateIconData(false);
end;

procedure TElTrayIcon.TrayInfoShowHandler(Sender : TObject);
begin
  TrayInfoVisible := true;
end;

procedure TElTrayIcon.TrayInfoHideHandler(Sender : TObject);
begin
  TrayInfoVisible := false;
  FHideForm := false;
  FNoShow := false;
  FHintTimer.Enabled := false;
end;

procedure TElTrayIcon.SetTrayInfoSettings(Value: TElTrayInfoSettings);
begin
  FTrayInfoSettings.Assign(Value);
end;

function TElTrayIcon.AdjustY(Y : integer): Integer;

var
  IconInfo : TIconInfo;
  BitmapInfoSize : DWORD;
  BitmapBitsSize : DWORD;
  Bitmap : PBitmapInfoHeader;
  Bits : Pointer;
  BytesPerScanline, ImageSize : DWORD;

  function FindScanline(Source: Pointer; MaxLen: Cardinal; Value: Cardinal): Cardinal;
  {$ifdef LMDX64}
  var
    i: Cardinal;
  begin
    i := 0;
    while i < MaxLen do
    begin
      if PByte(TLMDPtrUInt(Source) + i)^ = Value then
        break;
      inc(i);
    end;
    Result := i;
  end;
  {$else}assembler;
  asm
    PUSH    ECX
    MOV     ECX,EDX
    MOV     EDX,EDI
    MOV     EDI,EAX
    POP     EAX
    REPE    SCASB
    MOV     EAX,ECX
    MOV     EDI,EDX
  end;
  {$endif}
  
begin
  { Default value is entire icon height }
  Result := GetSystemMetrics(SM_CYCURSOR);
  if GetIconInfo(GetCursor, IconInfo) then
  try
    GetDIBSizes(IconInfo.hbmMask, BitmapInfoSize, BitmapBitsSize);
    Bitmap := AllocMem(BitmapInfoSize + BitmapBitsSize);
    try
      Bits := Pointer(TLMDPtrUInt(Bitmap) + BitmapInfoSize);
      if GetDIB(IconInfo.hbmMask, 0, Bitmap^, Bits^) and
        (Bitmap^.biBitCount = 1) then
      begin
        { Point Bits to the end of this bottom-up bitmap }
        with Bitmap^ do
        begin
          BytesPerScanline := ((biWidth * biBitCount + 31) and not 31) div 8;
          ImageSize := Cardinal(biWidth) * BytesPerScanline;
          Bits := Pointer(TLMDPtrUInt(Bits) + BitmapBitsSize - ImageSize);
          { Use the width to determine the height since another mask bitmap
            may immediately follow }
          Result := FindScanline(Bits, ImageSize, $FF);
          { In case the and mask is blank, look for an empty scanline in the
            xor mask. }
          if (Result = 0) and (biHeight >= 2 * biWidth) then
            Result := FindScanline(Pointer(TLMDPtrUInt(Bits) - ImageSize),
              ImageSize, $00);
          Result := Result div Integer(BytesPerScanline);
        end;
        Result := Integer(IconInfo.yHotSpot) - (Integer(GetSystemMetrics(SM_CYICON)) - Result);
        // Dec(Result, IconInfo.yHotSpot);
      end;
    finally
      FreeMem(Bitmap, BitmapInfoSize + BitmapBitsSize);
    end;

  finally
    if IconInfo.hbmColor <> 0 then DeleteObject(IconInfo.hbmColor);
    if IconInfo.hbmMask <> 0 then DeleteObject(IconInfo.hbmMask);
  end;
  Result := Max(y - Result, 0);
  end;

procedure TElTrayIcon.ImageNeededTransfer(Sender: TObject; Src: TLMDString; var Image: TBitmap);
begin
  if assigned(FOnTrayInfoImageNeeded) then FOnTrayInfoImageNeeded(Self, Src, Image);
end;

procedure TElTrayIcon.LinkClickTransfer(Sender: TObject; HRef: TLMDString);
begin
  if assigned(FOnTrayInfoLinkClick) then FOnTrayInfoLinkClick(Self, HRef);
end;

procedure TElTrayIcon.TriggerAnimationStopped;
begin
  if assigned(FOnAnimationStopped) then
    FOnAnimationStopped(Self);
end;

procedure TElTrayIcon.PerformIconHiding;
begin
  if FHideTaskBarIcon then DoShowTaskBarIcon;
  LMDDebug('doSetEnabled');
  if (ComponentState * [csLoading, csReading] = []) then
    UpdateIconData(true);
end;

constructor TElTrayInfoSettings.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner as TElTrayIcon;
end;

procedure TElTrayInfoSettings.SetColor(Value: TColor);
begin
  FOwner.FTrayInfo.Color := Value;
end;

procedure TElTrayInfoSettings.SetInfoType(newValue: TElTrayInfoType);
{ Sets data member FInfoType to newValue. }
begin
  FOwner.FTrayInfo.InfoType := newValue;
end;  { SetInfoType }

procedure TElTrayInfoSettings.SetIsHTML(newValue: Boolean);
{ Sets data member FIsHTML to newValue. }
begin
  FOwner.FTrayInfo.IsHTML := newValue;
end;  { SetIsHTML }

procedure TElTrayInfoSettings.SetMessage(newValue: TLMDString);
{ Sets data member FMessage to newValue. }
begin
  FOwner.FTrayInfo.Message := newValue;
end;  { SetMessage }

function TElTrayInfoSettings.GetColor: TColor;
begin
  Result := FOwner.FTrayInfo.Color;
end;

function TElTrayInfoSettings.GetInfoType: TElTrayInfoType;
begin
  Result := FOwner.FTrayInfo.InfoType;
end;

function TElTrayInfoSettings.GetIsHTML: Boolean;
begin
  Result := FOwner.FTrayInfo.IsHTML;
end;

function TElTrayInfoSettings.GetMessage: TLMDString;
begin
  Result := FOwner.FTrayInfo.Message;
end;

procedure TElTrayInfoSettings.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
  end;
end;

procedure TElTrayInfoSettings.Assign(Source : TPersistent);
begin
  if Source is TElTrayInfoSettings then
  begin
    Color := TElTrayInfoSettings(Source).Color;
    Enabled := TElTrayInfoSettings(Source).Enabled;
    InfoType := TElTrayInfoSettings(Source).InfoType;
    IsHTML := TElTrayInfoSettings(Source).IsHTML;
    Message := TElTrayInfoSettings(Source).Message;
    VisualScheme.Assign(TElTrayInfoSettings(Source).VisualScheme);
    Messages.Assign(TElTrayInfoSettings(Source).Messages);
  end
  else
    inherited;
end;

function TElTrayInfoSettings.GetFont: TFont;
begin
  Result := FOwner.FTrayInfo.Font;
end;

procedure TElTrayInfoSettings.SetFont(Value: TFont);
begin
  FOwner.FTrayInfo.Font := Value;
end;

function TElTrayInfoSettings.GetMsgs: TElTrayMessageList;
begin
  Result := FOwner.FTrayInfo.Messages;
end;

function TElTrayInfoSettings.GetVisualScheme: TElTrayVisualScheme;
begin
  Result := FOwner.FTrayInfo.VisualScheme;
end;

procedure TElTrayInfoSettings.SetMsgs(const Value: TElTrayMessageList);
begin
  FOwner.FTrayInfo.Messages.Assign(Value);
end;

procedure TElTrayInfoSettings.SetVisualScheme(
  const Value: TElTrayVisualScheme);
begin
  FOwner.FTrayInfo.VisualScheme.Assign(Value);
end;

function TElTrayIcon.ShowBalloonHint(const aInfoTitle, aInfo: String;
  aFlags: TLMDBalloonFlags; aTimeOut: Integer): Boolean;
begin
  Result := False;
  if (not LMDSIWindows2000Up) or (csDesigning in ComponentState) or (not FSet) then exit;

  FIconData.Wnd := FHandle;
  FIconData.uID := FIconID;
  FIconData.uFlags := NIF_INFO;
  FIconData.dwInfoFlags := Integer(aFlags);
  if not LMDSIWindowsVistaUp then
    FIconData.uTimeout := aTimeOut;
  StrPLCopy(FIconData.szInfo, aInfo, 255);
  StrPLCopy(FIconData.szInfoTitle, aInfoTitle, 63);

  {$IFNDEF LMDCOMP10}
  Result := Shell_NotifyIcon(NIM_MODIFY, PNotifyIconData(@FIconData));
  {$ELSE}
  Result := Shell_NotifyIcon(NIM_MODIFY, @FIconData);
  {$ENDIF}
end;

initialization

  WM_TaskbarRestart := RegisterWindowMessage('TaskbarCreated');

end.
