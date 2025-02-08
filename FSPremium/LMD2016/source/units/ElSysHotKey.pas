unit ElSysHotKey;
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

ElSysHotKey unit
----------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  SysUtils,
  Messages,
  Menus,
  LMDDebugUnit,

  Types,

  ElBaseComp;

type

  TElSysHotKey = class(TElBaseComponent)
  protected
    fID      : word;
    FOnPress : TNotifyEvent;
    FShortcut: TShortcut;
    procedure TriggerPress; virtual;
    procedure DoSetEnabled(AEnabled : boolean); override;
    procedure WMHotKey(var Message: TWMHotKey); message WM_HOTKEY;
    procedure SetShortcut(Value: TShortcut);
  public
    destructor Destroy; override;
    constructor Create(AOwner : TComponent); override;
  published
    property Enabled;
    property OnPress: TNotifyEvent read FOnPress write FOnPress;
    property Shortcut: TShortcut read FShortcut write SetShortcut;
  end; { TElOneInstance }

implementation

uses
  LMDObjectList,
  ElVCLUtils;

var
  KeyIdList : TLMDObjectList;

procedure TElSysHotKey.DoSetEnabled(AEnabled : boolean);
var i, aKey : word;
    aShift  : TShiftState;
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    if AEnabled then
    begin
      if FShortCut <> 0 then
      begin
        ShortcutToKey(FShortcut, aKey, aShift);
        i := 0;
        if ssAlt in aShift then
          i := i or MOD_ALT;
        if ssCtrl in aShift then
          i := i or MOD_CONTROL;
        if ssShift in aShift then
          i := i or MOD_SHIFT;
        RegisterHotKey(Handle, fID, i, aKey);
      end
      else
        Enabled := false;
    end
    else
      UnregisterHotKey(Handle, fID);
  end;
end;

destructor TElSysHotKey.Destroy;
begin
  Enabled := false;
  inherited;
end; { Destroy }

procedure TElSysHotKey.TriggerPress;
begin
  if assigned(FOnPress) then FOnPress(Self);
end;

procedure TElSysHotKey.WMHotKey(var Message: TWMHotKey);
begin
  inherited;
  TriggerPress;
end;

procedure TElSysHotKey.SetShortcut(Value: TShortcut);
begin
  if FShortcut <> Value then
  begin
    FShortcut := Value;
    if Enabled then
    begin
      Enabled := false;
      if FShortcut <> 0 then
        Enabled := true;
    end;
  end;
end;

constructor TElSysHotKey.Create(AOwner : TComponent);
var
  i: integer;
begin
  inherited;
  repeat
    i := Random($BFFF);
    if KeyIDList.IndexOf(Pointer(i)) = -1 then
    begin
      KeyIDList.Add(Pointer(i));
      fID := i;
      break;
    end;
  until false;
end;

initialization
  KeyIdList := TLMDObjectList.Create;

finalization
  try
    KeyIdList.Free;
  except
    on e:Exception do
    begin
      LMDDebug('ERROR finalization ElSysHotKey: ' + e.Message);
    end;
  end;

end.
