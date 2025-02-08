unit LMDWndProcComponent;
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

LMDWndProcComponent unit (RM)
-----------------------------

Special component used as ancestor component for components which need to hook
the forms wndproc

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,  Windows, Forms, Messages, Controls, LMDTypes, LMDCustomComponent;

type
  {--------- Base Classes used for Window-Hook Procedures ---------------------}
  {for (MDI-)forms}
  {new from V2.11: Application Window access}
  TLMDWndProcComponent=class(TLMDCustomComponent)
  private
    FEnabled,
    FDesignEnabled,
    FHooked,
    FSilent:Boolean;
    FMDIForm:Byte;
    FWndProcOld: TWndMethod;
    FClientWndProcOld,
    FClientInstance: TFarProc;
    function NewWndProc:Boolean;
    procedure SetDesignEnabled(aValue:Boolean);
    procedure SetHandleApp(aValue:Boolean);
  protected
    FDestroying,
    FHandleApp,
    FHandleMDI:Boolean;
    function GetOwnerForm: TForm;
    function GetOwnerHandle: HWND;
    procedure SetEnabled(aValue:Boolean); virtual;
    procedure Notification(AComponent: TComponent;
                    Operation: TOperation); override;
    function RestoreWndProc:Boolean;
    procedure CallPrevWndProc(var Message: TMessage);
    function AppWndProc(var Message: TMessage):Boolean;virtual;
    //7.01
    function ExistWndProcOld:Boolean;
    // ---
    procedure Init;virtual;
    procedure RestoreState;virtual;
    procedure Loaded;override;
    procedure WndProc(var Message: TMessage); virtual;
    procedure DesignEnabledChanged; virtual;
    procedure EnabledChanged; virtual;

    property DesignEnabled: Boolean read FDesignEnabled write SetDesignEnabled default false;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property HandleApp: Boolean read FHandleApp write SetHandleApp default false; {designtime only!}
    property MDIForm: Byte read FMDIForm;
    property PrevWndProc: TWndMethod read FWndProcOld;
  public
    constructor Create(aOwner:TComponent);override;
    destructor Destroy;override;
    function ValidOwner:Boolean;
    procedure SilentRemove;
    property WndHandle: HWND read GetOwnerHandle;
    property WndOwner: TForm read GetOwnerForm;
  end;

implementation

uses
  SysUtils;

{--------------------------- Private ------------------------------------------}
function TLMDWndProcComponent.NewWndProc: Boolean;
begin
  result:=false;
  if  not (Owner is TControl) then
    exit;

  if (GetOwnerHandle=0) or ExistWndProcOld
     or ((csDesigning in ComponentState) and (not FDesignEnabled)) then Exit;
  try
    FDestroying:=False;

    if FHandleApp then
      begin
        Application.HookMainWindow(AppWndProc);
        FHooked:=True;
      end;

    // This is only the case for MDI MainForms. If the inner area should be
    // accessed, we must subclass MDIForm.ClientHandle. Used e.g. for TLMDBack.
    if (FMDIForm>1) and not FHandleMDI then
      begin
         FClientWndProcOld:=TFarProc(GetWindowLong(WndHandle, GWL_WNDPROC));
         FClientInstance:=Classes.MakeObjectInstance(WndProc);
         SetWindowLong(GetOwnerHandle, GWL_WNDPROC, TLMDPtrInt(FClientInstance));
         end
    else
      begin
        FWndProcOld := TControl(owner).WindowProc;
        TControl(Owner).WindowProc := WndProc;
      end;
    result:=true;
  except
    on Exception do RestoreWndProc;
  end;

end;

{------------------------------------------------------------------------------}
procedure TLMDWndProcComponent.Notification(AComponent: TComponent;
                    Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if  AComponent = self  then
      RestoreWndProc;
end;

{------------------------------------------------------------------------------}
function TLMDWndProcComponent.RestoreWndProc:Boolean;
begin
  if not FSilent and ExistWndProcOld and (Owner is TControl) then
    // This is only the case for MDI MainForms. If the inner area should be
    // accessed, we must subclass MDIForm.ClientHandle. Used e.g. for TLMDBack.
    if (FMDIForm>1) and not FHandleMDI then
      begin
        SetWindowLong(GetOwnerHandle, GWL_WNDPROC, TLMDPtrInt(FClientWndProcOld));
        if FClientInstance<>nil then
          Classes.FreeObjectInstance(FClientInstance);
        FClientInstance:=nil;
        FClientWndProcOld:=nil;
        end
    else
      TControl(Owner).WindowProc := FWndProcOld;

  FWndProcOld:=nil;

  if FHandleApp and FHooked then
    begin
      Application.UnHookMainWindow(AppWndProc);
      FHooked:=False;
    end;

  FSilent:=False;
  FDestroying:=False;
  result:=True;
end;

{------------------------------------------------------------------------------}
function TLMDWndProcComponent.GetOwnerForm:TForm;
begin
  result:=TForm(Owner);
end;

{------------------------------------------------------------------------------}
function TLMDWndProcComponent.GetOwnerHandle:HWND;
var
  temp:TForm;
begin
  result:=0;
  temp:=TForm(owner);
  if (temp<>nil) then
    try
      if (FMDIForm>1) and not FHandleMDI then
        result:=temp.ClientHandle
      else
        result:=temp.Handle;
    except
      result:=0;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWndProcComponent.SetEnabled(aValue:Boolean);
begin
  if aValue<>FEnabled then
    begin
      FEnabled:=aValue;
      if not (csDesigning in ComponentState) then
        If FEnabled then Init else RestoreState;
      EnabledChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWndProcComponent.SetDesignEnabled(aValue:Boolean);
begin
  if aValue<>FDesignEnabled then
    begin
      FDesignEnabled:=aValue;
      if (csDesigning in ComponentState) then
        if FDesignEnabled then Init else RestoreState;
      DesignEnabledChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWndProcComponent.SetHandleApp(aValue:Boolean);
begin
  {designtime only property}
  if [csDesigning, csLoading]*ComponentState<>[] then FHandleApp:=aValue;
end;

{--------------------------- Protected ----------------------------------------}
function TLMDWndProcComponent.AppWndProc(var Message: TMessage):Boolean;
begin
  result:=True;
//  with TMessage(Message) do
//    Result:=CallWindowProc(FWndProcOld, Application.Handle, Msg, WParam, LParam);
end;

{------------------------------------------------------------------------------}
procedure TLMDWndProcComponent.Init;
begin
  If FEnabled and not ExistWndProcOld then
    NewWndProc;
end;

{------------------------------------------------------------------------------}
procedure TLMDWndProcComponent.RestoreState;
begin
  RestoreWndProc;
end;

{------------------------------------------------------------------------------}
procedure TLMDWndProcComponent.Loaded;
begin
  inherited Loaded;
  if not (csDesigning in ComponentState) or
    ((csDesigning in ComponentState) and FDesignEnabled) then
      begin
        Init;
        EnabledChanged;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWndProcComponent.CallPrevWndProc(var Message: TMessage);
begin
  if Assigned(FWndProcOld) then FWndProcOld(Message);
  if Assigned(FClientWndProcOld) then
     with TMessage(Message) do
       Result:=CallWindowProc(FClientWndProcOld, WndHandle, Msg, WParam, LParam);
end;

{------------------------------------------------------------------------------}
procedure TLMDWndProcComponent.WndProc(var Message: TMessage);
begin
   if FDestroying then exit;
   with Message do
     case Msg of
       WM_DESTROY:
         begin
           //FDestroying:=True; // March 05 VB
           if FMDIForm=1 then
             RestoreWndProc
           else
             CallPrevWndProc(Message);
         end;
       CM_RECREATEWND:
        begin
          CallPrevWndProc(Message);
          Init;
        end;
     else
       CallPrevWndProc(Message);
     end;

 end;

{------------------------------------------------------------------------------}
procedure TLMDWndProcComponent.DesignEnabledChanged;
begin
  //15 Jan 2001, JH: maybe overwritten by descendand classes for actions related
  //to a change of the DesignEenabled property
  if (csDesigning in ComponentState) and not DesignEnabled then
    RestoreWndProc;
end;

{------------------------------------------------------------------------------}
procedure TLMDWndProcComponent.EnabledChanged;
begin
  //05. Aug 2001, JH: maybe overwritten by descendand classes for actions related
  //to enabled state change
end;

{------------------------------------------------------------------------------}
function TLMDWndProcComponent.ExistWndProcOld:Boolean;
begin
  if (FMDIForm>1) and not FHandleMDI then
    result:=Assigned(FClientWndProcOld)
  else
    result:=Assigned(FWndProcOld)
end;

{------------------------------------------------------------------------------}
procedure TLMDWndProcComponent.SilentRemove;
begin
  FSilent:=True;
  RestoreWndProc;
  Enabled:=False;
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDWndProcComponent.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FEnabled:=True;
  FDesignEnabled := false;
  FSilent:=False;
  FHandleMDI:=False;
  FHandleApp:=False;

  FMDIForm:=0;
  if owner is TForm then
    case TForm(Owner).FormStyle of
      fsMdiChild:FMDIForm:=1;
      fsMdiForm:FMDIForm:=2;
    end
end;

{------------------------------------------------------------------------------}
destructor TLMDWndProcComponent.Destroy;
begin
  RestoreWndProc;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDWndProcComponent.ValidOwner:Boolean;
begin
  result:=false;
  if not TCustomForm(Owner).HandleAllocated or
         ([csLoading, csDestroying]*ComponentState<>[]) then exit;
  result:=True;
end;
end.
