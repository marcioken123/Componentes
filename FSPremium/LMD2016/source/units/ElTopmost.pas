unit ElTopmost;
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

ElTopmost unit
--------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  SysUtils,
  Windows,
  Messages,
  Graphics,
  Controls,
  Forms,
  Menus,
  StdCtrls,
  ExtCtrls,

  Types,

  LMDDebugUnit,
  ElComponent,
  ElHook,
  LMDUtils;

type

  TElTopmost = class(TElComponent)
  private
    FTopMost : Boolean;
    FHook : TElHook;
    procedure OnHook(Sender : TObject; var Msg : TMessage; var Handled : boolean);
    procedure OnAfterHook(Sender : TObject; var Msg : TMessage; var Handled : boolean);
    procedure SetTopMost(newValue : Boolean);
    procedure UpdateTopmost;
  protected
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    procedure Loaded; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property TopMost : Boolean read FTopMost write SetTopMost;
  end;

implementation

uses LMDObjectList;

var  FormPersList : TLMDObjectList;

type
  THackForm = class(TCustomForm)
  end;

procedure TElTopmost.OnAfterHook(Sender : TObject; var Msg : TMessage; var Handled : boolean);
var
  Form : TForm;
  i : DWORD;
begin
  if Msg.Msg = WM_ACTIVATEAPP then
  begin
    if Msg.WParam = 0 then
    begin
      if FTopMost then
      begin
        Form := LMDGetOwnerForm(Self);
        if (Form <> nil) and Form.Visible then
          SetWindowPos(Form.Handle, hwnd_TopMost, 0, 0, 0, 0, swp_NoMove + swp_NoSize + swp_NoActivate);
      end;
    end;
  end;
  if Msg.Msg = CM_DEACTIVATE then
  begin
    if FTopMost then
    begin
      Form := LMDGetOwnerForm(Self);
      if (Form <> nil) and Form.Visible then
      begin
        SetWindowPos(Form.Handle, hwnd_TopMost, 0, 0, 0, 0, swp_NoMove + swp_NoSize + swp_NoActivate);
      end;
    end;
  end;
  if Msg.Msg = WM_CREATE then
  begin
    if TopMost then
    begin
      Form := LMDGetOwnerForm(Self);
      if (Form <> nil) then
      begin
        i := GetWindowLong(Form.Handle, GWL_EXSTYLE);
        i := i or WS_EX_TOPMOST;
        SetWindowLong(Form.Handle, GWL_EXSTYLE, i);
        SetWindowPos(Form.Handle, hwnd_TopMost, 0, 0, 0, 0, swp_NoMove + swp_NoSize + swp_NoActivate);
      end;
    end;
  end;
  if Msg.Msg = WM_SHOWWINDOW then
  begin
    if Msg.WParam <> 0 then
    begin
      if Topmost then
      begin
        FTopmost := false;
        TopMost := true;
      end;
    end;
  end;
end;

procedure TElTopmost.OnHook(Sender : TObject; var Msg : TMessage; var Handled : boolean);
begin
  if (Msg.Msg = WM_CREATE) then
  begin
    if Topmost then
    begin
      FTopmost := false;
      Topmost := true;
    end;
  end;
end;

procedure TElTopmost.Notification(AComponent : TComponent; Operation : TOperation);
var

  Form : THackForm;
begin
  Form := THackForm(LMDGetOwnerForm(Self));
  if (AComponent = Form) then
  begin
    if not (csDestroying in Form.ComponentState) then
      Form.RemoveFreeNotification(Self);
    end;
  inherited;
end;

procedure TElTopmost.SetTopMost(newValue : Boolean);
var
  Form : TForm;
  i    : integer;
begin
  if (FTopMost <> newValue) then
  begin
    FTopMost := newValue;
    if (not (csDesigning in ComponentState)) then
    begin
      Form := LMDGetOwnerForm(Self);
      if (Form <> nil) and (Form.HandleAllocated) then
      begin
        i := GetWindowLong(Form.Handle, GWL_EXSTYLE);
        if TopMost then
           i := i or WS_EX_TOPMOST
        else
           i := i and not WS_EX_TOPMOST;

        SetWindowLong(Form.Handle, GWL_EXSTYLE, i);
        if FTopMost then
          SetWindowPos(Form.Handle, hwnd_TopMost, 0, 0, 0, 0, swp_NoMove + swp_NoSize + swp_NoActivate)
        else
          SetWindowPos(Form.Handle, hwnd_NoTopMost, 0, 0, 0, 0, swp_NoMove + swp_NoSize + swp_NoActivate);
      end;
    end;
  end; {if}
end; {SetTopMost}

procedure TElTopmost.Loaded;
begin
  inherited;
  if Topmost then
  begin
    FTopmost := false;
    Topmost := true;
  end;
end; {Loaded}

destructor TElTopmost.Destroy;
begin
  if FormPersList <> nil then
     FormPersList.Remove(Self);
  FHook.Free;
  inherited Destroy;
end;

procedure TElTopmost.UpdateTopmost;
var
  Form : TForm;
begin
  if (not (csDesigning in ComponentState)) then
  begin
    Form := LMDGetOwnerForm(Self);
    if (Form <> nil) and (Form.HandleAllocated) and (not (csDesigning in Form.ComponentState)) and Form.Visible then
    begin
      if FTopMost then
        SetWindowPos(Form.Handle, hwnd_TopMost, 0, 0, 0, 0, swp_NoMove + swp_NoSize + swp_NoActivate);
    end;
  end;
end;

constructor TElTopmost.Create(AOwner : TComponent);
var
  Form : THackForm;
begin
  inherited Create(AOwner);
  FHook := TElHook.Create(nil);
  Form := THackForm(LMDGetOwnerForm(AOwner));
  if Assigned(Form) then
     Form.FreeNotification(Self);
  FHook.Control := Form;
  FHook.OnBeforeProcess := OnHook;
  FHook.OnAfterProcess := OnAfterHook;
  if not (csDesigning in ComponentState) then
     FHook.Active := True;
  if FormPersList <> nil then
     FormPersList.Add(Self);
end;

type
  TLMDTopWindowClass = class
    function TopWndProc(var Message: TMessage): boolean;
  end;

function TLMDTopWindowClass.TopWndProc(var Message: TMessage): boolean;
var
  i : integer;
  iVisible: Integer;
  Own: TComponent;
begin
  if (Message.Msg = WM_ACTIVATEAPP) and (Message.wParam = 0) then
  begin
    PostMessage(Application.Handle, CM_DEACTIVATE, 0, 0);
    if FormPersList.Count > 0 then
    begin
      iVisible := 0;
      for i := 0 to FormPersList.Count - 1 do
      begin
        Own := LMDGetOwnerForm(TElTopmost(FormPersList[i]));
        if (Own is TCustomForm) then
        begin
          if (Own as TCustomForm).Visible = True then
            Inc(iVisible);
        end;
      end;
      if iVisible > 0 then
      begin
        if FormPersList <> nil then
        begin
          for i := 0 to FormPersList.Count - 1 do
          begin
            Own := TElTopmost(FormPersList[i]).Owner;
            if (Own is TCustomForm) then
            begin
              if (Own as TCustomForm).Visible = True then
                TElTopmost(FormPersList[i]).UpdateTopMost;
            end;
          end;
        end;
        Message.Msg := WM_NULL;
      end;
    end;
  end;
  result := false;
end;

var
  HookTop: TLMDTopWindowClass;

initialization
  HookTop := TLMDTopWindowClass.Create;
  Application.HookMainWindow(HookTop.TopWndProc);
  FormPersList := TLMDObjectList.Create;

finalization
  try
    Application.UnhookMainWindow(HookTop.TopWndProc);
    FreeAndNil(HookTop);
    FreeAndNil(FormPersList);
  except
    on e:Exception do
    begin
      LMDDebug('ERROR finalization ElTopMost: ' + e.Message);
    end;
  end;
end.
