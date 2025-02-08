unit ElHook;
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

ElHook unit
-----------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Forms,  Messages,  Controls, SysUtils, Classes, Types, LMDDebugUnit, ElComponent, LMDTypes;

type
  TElHookEvent = procedure(Sender : TObject; var Msg : TMessage; var Handled : boolean) of object;

type
  TElHook = class(TElComponent)
  private
    FDesignActive : Boolean;
    FOnBeforeProcess : TElHookEvent;
    FOnAfterProcess : TElHookEvent;
    FActive : Boolean;
    FControl : TControl;
    procedure SetControl(newValue : TControl);
    procedure SetActive(newValue : Boolean);
    procedure SetDesignActive(newValue : Boolean);
  protected
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    procedure TriggerBeforeProcessEvent(var Msg : TMessage; var Handled : boolean); virtual;
    procedure TriggerAfterProcessEvent(var Msg : TMessage; var Handled : boolean); virtual;
  public
    destructor Destroy; override;
  published
    property Active : Boolean read FActive write SetActive;
    property DesignActive : Boolean read FDesignActive write SetDesignActive;
    property Control : TControl read FControl write SetControl;
    property OnBeforeProcess : TElHookEvent read FOnBeforeProcess write FOnBeforeProcess;
    property OnAfterProcess : TElHookEvent read FOnAfterProcess write FOnAfterProcess;
  end;

implementation
uses
  Windows,  LMDObjectList;

const
  WM_REMOVEELHOOK = WM_USER + 115;
  WM_RECREATEELHOOK = WM_USER + 116;

type
  TWinControlHack = class(TWinControl);

type
  TCtlHook = class
  private
    FHooks : TLMDObjectList;
    FControl : TControl;
    FOldWndProc : TWndMethod;
    FElWndProc : TWndMethod;
    FDestroying : boolean;
    procedure HookWndProc(var Msg : TMessage);
  protected
    procedure RemoveHook(Hook : TElHook);
    procedure AddHook(Hook : TElHook);
//    function HooksCount : integer;
    constructor Create;
    destructor Destroy; override;
  end;

type
  TElHookList = class
  private
    FCtlHooks : TLMDObjectList;
    FHandle : THandle;
    procedure OnCtlHookDelete(Sender : TObject; var Item : Pointer);
  protected
    procedure WndProc(var Message : TMessage);
    function GetCtlHook(AControl : TControl) : TCtlHook;
    constructor Create;
    destructor Destroy; override;
  end;

var
  HookList : TElHookList;

constructor TCtlHook.Create;
begin
  inherited;
  FHooks := TLMDObjectList.Create;
  FElWndProc := HookWndProc;
end;

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

procedure TCtlHook.RemoveHook(Hook : TElHook);
begin
  FHooks.Remove(Hook);
  if FHooks.Count = 0 then
    begin
      if (FControl <> nil) and (@FOldWndProc <> nil) then
        begin
          try
            //FControl.Name := FControl.Name;
            FControl.WindowProc := FOldWndProc;
          except
            FOldWndProc := nil;
          end;
          FOldWndProc := nil;
        end;
    end;
end; {RemoveHook}

procedure TCtlHook.AddHook(Hook : TElHook);
begin
  FHooks.Add(Hook);
  if @FOldWndProc = nil then
  begin
    FOldWndProc := FControl.WindowProc;
    FControl.WindowProc := FElWndProc;
  end;
end; {AddHook}

{
function TCtlHook.HooksCount : integer;
begin
  result := FHooks.Count;
end;
}

procedure TCtlHook.HookWndProc(var Msg : TMessage);
var
  i : integer;
  Handled : boolean;
begin
  Handled := false;
  if (Msg.Msg <> WM_QUIT) and (not FDestroying) then
    for i := FHooks.Count - 1 downto 0 do // Iterate
    begin
      TElHook(FHooks[i]).TriggerBeforeProcessEvent(Msg, Handled);
      if Handled then break;
    end; // for

  if (not Handled) then
    FOldWndProc(Msg);

  Handled := false;
  for i := FHooks.Count - 1 downto 0 do // Iterate
  begin
    TElHook(FHooks[i]).TriggerAfterProcessEvent(Msg, Handled);
    if Handled then break;
  end; // for
end;

constructor TElHookList.Create;
begin
  inherited;
  FCtlHooks := TLMDObjectList.Create;
  FCtlHooks.OnDelete := OnCtlHookDelete;
  FHandle := AllocateHwnd(WndProc);
end;

destructor TElHookList.Destroy;
begin
  FCtlHooks.Free;
  if FHandle <> 0 then DeallocateHwnd(FHandle);
  FHandle := 0;
  inherited;
end;

procedure TElHookList.WndProc(var Message : TMessage);
var
  CH : TCtlHook;
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
            CH.FOldWndProc := CH.FControl.WindowProc;
            CH.FControl.WindowProc := CH.FElWndProc;
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

function TElHookList.GetCtlHook(AControl : TControl) : TCtlHook;
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

procedure TElHookList.OnCtlHookDelete(Sender : TObject; var Item : Pointer);
begin
  FreeAndNil(TCtlHook(Item));
end;

procedure TElHook.SetControl(newValue : TControl);
var
  FOldActive : boolean;
begin
  if (FControl <> newValue) then
    begin
      FOldActive := FActive;
      SetActive(false);
      if FControl <> nil then
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

procedure TElHook.SetActive(newValue : Boolean);
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
            end
          else
            if (FControl <> nil) then
              begin
                if HookList = nil then
                   HookList := TElHookList.Create;
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
              end;
          FActive := newValue;
        end;
    end; {if}
end; {SetActive}

procedure TElHook.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FControl) then Control := nil;
end; {Notification}

procedure TElHook.TriggerBeforeProcessEvent(var Msg : TMessage; var Handled : boolean);
begin
  if (assigned(FOnBeforeProcess)) then
    FOnBeforeProcess(Self, Msg, Handled);
end; {TriggerBeforeProcessEvent}

procedure TElHook.TriggerAfterProcessEvent(var Msg : TMessage; var Handled : boolean);
begin
  if (assigned(FOnAfterProcess)) then
    FOnAfterProcess(Self, Msg, Handled);
end; {TriggerAfterProcessEvent}

procedure TElHook.SetDesignActive(newValue : Boolean);
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

destructor TElHook.Destroy;
begin
  Destroying;
  Control := nil;
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
      LMDDebug('ERROR finalization ElHook: ' + e.Message);
    end;
  end;
end.
