unit ElBaseComp;
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

ElBaseComp unit
---------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Controls,
  Forms,
  Types,
  LMDTypes,
  ElComponent;

type

  EBaseEnabledFailed = class(Exception)
  end;

  TElBaseComponent = class(TElComponent)
  protected
    FHandle : THandle;
    FEnabled : boolean;
    FDesignActive : boolean;
    procedure WMQueryEndSession(var Message : TMessage); message WM_QUERYENDSESSION;
    procedure WndProc(var Message : TMessage); virtual;
    procedure SetEnabled(AEnabled : boolean); virtual;
    procedure DoSetEnabled(AEnabled : boolean); virtual;
    procedure Loaded; override;
    //procedure WMDestroy(var Message: TMessage); message WM_DESTROY;
    property Handle : THandle read FHandle;
  public
    property Enabled : boolean read FEnabled write SetEnabled default false;
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  end;

implementation

 { TElBaseComponent }

// var WindowAtom : TAtom;

constructor TElBaseComponent.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FHandle := 0;
  FEnabled := false;
end;

destructor TElBaseComponent.Destroy;
begin
  Enabled := false;
  inherited Destroy;
end;

procedure TElBaseComponent.Loaded;
begin
  inherited;
  if Enabled then
  begin
    FEnabled := false;
    SetEnabled(true);
  end;
end;

procedure TElBaseComponent.WndProc(var Message : TMessage);
begin
  if Message.Msg = WM_QUERYENDSESSION then
    Message.Result := 1
  else
  try
    Dispatch(Message);
  except
    Application.HandleException(Self);
  end;
end;

procedure TElBaseComponent.WMQueryEndSession(var Message : TMessage);

begin
  try
    Enabled := false;
  except;
  end;
  inherited;
  Message.Result := TLMDPtrInt(true);
end;

procedure TElBaseComponent.SetEnabled(AEnabled : boolean);
begin
  try
    if (FDesignActive or (not (csDesigning in ComponentState))) and
      (not (csLoading in ComponentState)) and (AEnabled <> FEnabled) then DoSetEnabled(AEnabled);
    FEnabled := AEnabled;
  except
    raise;
  end;
end;

procedure TElBaseComponent.DoSetEnabled(AEnabled : boolean);
begin
  if AEnabled then
{$warnings off}
  begin
    if FHandle <> 0 then
      DeallocateHwnd(FHandle);
    FHandle := AllocateHwnd(WndProc);
    //SetProp(FHandle, MakeIntAtom(WindowAtom), THandle(Self));
  end
  else
  begin
    if FHandle <> 0 then
      DeallocateHwnd(FHandle);
{$warnings on}
    FHandle := 0;
  end;
end;

{procedure TElBaseComponent.WMDestroy(var Message: TMessage);
begin
  inherited;
  // RemoveProp(FHandle, MakeIntAtom(WindowAtom));
end;

 var
  AtomText: array[0..31] of Char;

initialization

  WindowAtom := GlobalAddAtom(StrFmt(AtomText, 'Delphi%.8X',
    [GetCurrentProcessID]));

finalization

  GlobalDeleteAtom(WindowAtom);
{}

end.
