unit LMDHookComponent;
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

LMDHook unit ()
---------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Forms, Messages, Controls, Types, SysUtils, Classes,
  LMDTypes, LMDDebugUnit, LMDCustomComponent;

type
  // for compatibility
  TLMDHookEvent = procedure(Sender: TObject; var Message: TMessage; var Handled: boolean) of object;

type
  {-------------------  TLMDCustomHookComponent -------------------------------}
  TLMDCustomHookComponent = class(TLMDCustomComponent)
  private
    FActive,
    FDesignActive,
    FEnabled: Boolean;
    FOnBeforeProcess : TLMDHookEvent;
    FOnAfterProcess : TLMDHookEvent;
    FControl : TControl;
    procedure SetEnabled(const Value: Boolean);
    procedure SetControl(newValue : TControl);
    procedure SetActive(newValue : Boolean);
    procedure SetDesignActive(newValue : Boolean);
  protected
    function HasControl:Boolean;
    procedure Init;dynamic;
    procedure RestoreState;dynamic;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    procedure TriggerBeforeProcessEvent(var Msg : TMessage; var Handled : boolean); virtual;
    procedure TriggerAfterProcessEvent(var Msg : TMessage; var Handled : boolean); virtual;
    property Enabled:Boolean read FEnabled write SetEnabled default True;
  public
    constructor Create(aOwner:TComponent);override;
    destructor Destroy; override;
    property Active: Boolean read FActive write SetActive default true;
    property DesignActive: Boolean read FDesignActive write SetDesignActive default false;
    property Control: TControl read FControl write SetControl stored HasControl;
    property OnBeforeProcess: TLMDHookEvent read FOnBeforeProcess write FOnBeforeProcess;
    property OnAfterProcess: TLMDHookEvent read FOnAfterProcess write FOnAfterProcess;
  end;

  {-------------------  TLMDHookComponent -------------------------------------}
  TLMDHookComponent=class(TLMDCustomHookComponent)
  private
    FOnMessage:TLMDHookEvent;
  protected
    procedure TriggerBeforeProcessEvent(var Msg : TMessage; var Handled : boolean); override;
  public
    constructor Create(aOwner:TComponent);override;
  published
    property About;
    property Control;
    property OnMessage:TLMDHookEvent read FOnMessage write FOnMessage;
  end;

implementation
uses
  Windows,
  LMDObjectList;

const
  WM_REMOVEELHOOK = WM_USER + 115;
  WM_RECREATEELHOOK = WM_USER + 116;

type
  TCtlHook = class
  private
    FHooks : TLMDObjectList;
    FControl : TControl;
    FOldWndProc : TWndMethod;
    FElWndProc : TWndMethod;
    FDestroying : boolean;
    procedure HookWndProc(var Msg : TMessage);
    procedure RecreateHook;
  protected
    procedure RemoveHook(Hook: TLMDCustomHookComponent);
    procedure AddHook(Hook: TLMDCustomHookComponent);
    constructor Create;
    destructor Destroy; override;
  end;

  TLMDHookList = class
  private
    FCtlHooks : TLMDObjectList;
    FHandle : THandle;
    procedure OnCtlHookDelete(Sender : TObject; var Item : TLMDDataTag);
  protected
    procedure WndProc(var Message : TMessage);
    function GetCtlHook(AControl : TControl) : TCtlHook;
    constructor Create;
    destructor Destroy; override;
  end;

var
  HookList : TLMDHookList;

{------------------------------------------------------------------------------}
constructor TCtlHook.Create;
begin
  inherited;
  FHooks := TLMDObjectList.Create;
  FElWndProc := HookWndProc;
end;

{------------------------------------------------------------------------------}
destructor TCtlHook.Destroy;
begin
  FDestroying := true;
  FHooks.Free;

  if (@FOldWndProc <> nil) then
    begin
      FControl.WindowProc := FOldWndProc;
      FOldWndProc := nil;
    end;

  FElWndProc := nil;
  inherited;
end;

procedure TCtlHook.RecreateHook;
begin
  FOldWndProc := FControl.WindowProc;
  FControl.WindowProc := FElWndProc;
end;

{------------------------------------------------------------------------------}
procedure TCtlHook.RemoveHook(Hook : TLMDCustomHookComponent);
begin
  FHooks.Remove(Hook);
  if FHooks.Count = 0 then
    begin
      if (FControl <> nil) and (@FOldWndProc <> nil) then
        begin
          try
            FControl.Name := FControl.Name;
            FControl.WindowProc := FOldWndProc;
          except
            FOldWndProc := nil;
          end;
          FOldWndProc := nil;
        end;
    end;
end; {RemoveHook}

{------------------------------------------------------------------------------}
procedure TCtlHook.AddHook(Hook : TLMDCustomHookComponent);
begin
  FHooks.Add(Hook);
  if @FOldWndProc = nil then
  begin
    FOldWndProc := FControl.WindowProc;
    FControl.WindowProc := FElWndProc;
  end;
end; {AddHook}

{------------------------------------------------------------------------------}
procedure TCtlHook.HookWndProc(var Msg : TMessage);
var
  i : integer;
  LHandled : boolean;
begin
  LHandled := false;

  if (Msg.Msg <> WM_QUIT) and (not FDestroying) then
    for i := FHooks.Count - 1 downto 0 do // Iterate
      begin
        TLMDCustomHookComponent(FHooks[i]).TriggerBeforeProcessEvent(Msg, LHandled);
        if LHandled then break;
      end; // for

  if (not LHandled) then
    FOldWndProc(Msg);

  LHandled := false;
  for i := FHooks.Count - 1 downto 0 do // Iterate
    begin
      TLMDCustomHookComponent(FHooks[i]).TriggerAfterProcessEvent(Msg, LHandled);
      if LHandled then break;
    end; // for
end;

{------------------------------------------------------------------------------}
constructor TLMDHookList.Create;
begin
  inherited;
  FCtlHooks := TLMDObjectList.Create;
  FCtlHooks.OnDelete := OnCtlHookDelete;
  FHandle := AllocateHwnd(WndProc);
end;

{------------------------------------------------------------------------------}
destructor TLMDHookList.Destroy;
begin
  FCtlHooks.Free;
  if FHandle <> 0 then
    DeallocateHwnd(FHandle);
  FHandle := 0;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDHookList.WndProc(var Message : TMessage);
var
  CH: TCtlHook;
begin
  try
    if Message.Msg = WM_REMOVEELHOOK then
    begin
      CH := TCtlHook(Message.lParam);
      if CH.FHooks.Count = 0 then
         FCtlHooks.Remove(CH);
      if FCtlHooks.Count = 0 then
      begin
        Free;
        HookList := nil;
      end;
    end
    else
      if Message.Msg = WM_RECREATEELHOOK then
      begin
        CH := TCtlHook(Message.lParam);
        try
          CH.RecreateHook;
        except
        end;
      end
      else
        if Message.Msg = WM_QUERYENDSESSION then
          Message.Result := 1
        else
          Dispatch(Message);
  except
    Application.HandleException(Self);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDHookList.GetCtlHook(AControl : TControl) : TCtlHook;
var
  i : integer;
begin
  result := nil;
  for i := 0 to FCtlHooks.Count - 1 do // Iterate
    begin
      if TCtlHook(FCtlHooks[i]).FControl = AControl then
        begin
          result := TCtlHook(FCtlHooks[i]);
          exit;
        end;
    end; // for
end;

{------------------------------------------------------------------------------}
procedure TLMDHookList.OnCtlHookDelete(Sender : TObject; var Item : TLMDDataTag);
begin
  FreeAndNil(TCtlHook(Item));
end;

{********************** TLMDCustomHookComponent *******************************}
{--------------------------- Private ------------------------------------------}
procedure TLMDCustomHookComponent.SetActive(newValue : Boolean);
var
  CH : TCtlHook;
begin
  if (FActive <> newValue) then
    begin
      if ((csDesigning in ComponentState) or
         ((Owner <> nil) and (csDesigning in Owner.ComponentState))) and
         (not FDesignActive) then
        FActive := newValue
      else
        begin
          if not NewValue then
            begin
              if HookList <> nil then
                begin
                  CH := HookList.GetCtlHook(FControl);
                  if CH <> nil then
                     CH.RemoveHook(Self);
                end;
               RestoreState;
            end
          else
            if (FControl <> nil) then
              begin
                if HookList = nil then
                   HookList := TLMDHookList.Create;
                CH := HookList.GetCtlHook(FControl);
                if CH <> nil then
                  CH.AddHook(Self)
                else
                  begin
                    CH := TCtlHook.Create;
                    HookList.FCtlHooks.Add(CH);
                    CH.FControl := FControl;
                    CH.AddHook(Self);
                  end;
                Init;
              end;
          FActive := newValue;
        end;
    end; {if}
end; {SetActive}

{------------------------------------------------------------------------------}
procedure TLMDCustomHookComponent.SetDesignActive(newValue : Boolean);
begin
  if (FDesignActive <> newValue) then
    begin
      FDesignActive := newValue;
      if (csDesigning in ComponentState) then
        begin
          if Active then
            begin
              FActive := false;
              Active := true;
            end
          else
            begin
              FActive := true;
              Active := false;
            end;
        end;
    end; {if}
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHookComponent.SetControl(newValue : TControl);
var
  FOldActive : boolean;
begin
  if (FControl <> newValue) then
    begin
      FOldActive := FActive;
      SetActive(false);
      if (FControl <> nil) then
        if not (csDestroying in FControl.ComponentState) then
          FControl.RemoveFreeNotification(Self);
      FControl := newValue;
      if FControl <> nil then
        begin
          SetActive(FOldActive);
          FControl.FreeNotification(Self);
        end;
    end; {if}
end; {SetControl}

{------------------------------------------------------------------------------}
procedure TLMDCustomHookComponent.SetEnabled(const Value: Boolean);
begin
  SetActive(Value);
end;

{----------------------- protected --------------------------------------------}
function TLMDCustomHookComponent.HasControl:Boolean;
begin
  result:=FControl<>nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHookComponent.Init;
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHookComponent.RestoreState;
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomHookComponent.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FControl) then Control := nil;
end; {Notification}

{------------------------------------------------------------------------------}
procedure TLMDCustomHookComponent.TriggerBeforeProcessEvent(var Msg : TMessage; var Handled : boolean);
begin
  if (assigned(FOnBeforeProcess)) then
    FOnBeforeProcess(Self, Msg, Handled);
end; {TriggerBeforeProcessEvent}

{------------------------------------------------------------------------------}
procedure TLMDCustomHookComponent.TriggerAfterProcessEvent(var Msg : TMessage; var Handled : boolean);
begin
  if (assigned(FOnAfterProcess)) then
    FOnAfterProcess(Self, Msg, Handled);
end; {TriggerAfterProcessEvent}

{----------------------- public -----------------------------------------------}
constructor TLMDCustomHookComponent.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FActive:=True;
  FEnabled:=True;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomHookComponent.Destroy;
begin
  Destroying;
  Control := nil;
  inherited;
end;

{******************* Object TLMDHookComponent *********************************}
{----------------------- protected --------------------------------------------}
procedure TLMDHookComponent.TriggerBeforeProcessEvent(var Msg: TMessage; var Handled: boolean);
begin
  inherited;
  if Assigned(FOnMessage) then FOnMessage(self, Msg, Handled);
end;

{----------------------- public -----------------------------------------------}
constructor TLMDHookComponent.Create(aOwner: TComponent);
begin
  inherited;
end;

initialization
  HookList := nil;

finalization
  try
    HookList.Free;
    HookList := nil;
  except
    on e:Exception do
    begin
      LMDDebug('ERROR finalization LMDHookComponent: ' + e.Message);
    end;
  end;
end.
