unit LMDGlobalHotKey;
{$I lmdcmps.INC}

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

LMDGlobalHotKey unit ()
-----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Messages, Menus, Controls,
  LMDCustomComponent;

type
  TLMDGlobalHotKey = class(TLMDCustomComponent)
  private
    FActive: Boolean;
    FAtom:TAtom;
    FGlobalKey:TShortcut;
    FOnKeyDown:TKeyEvent;
    FWndHandle:HWnd;
    procedure SetEnabled(aValue:Boolean);
    procedure SetHotKey(aValue:TShortcut);
    procedure NewWndProc(var Message:TMessage);
  public
    constructor Create(AOwner: TComponent);override;
    destructor Destroy;override;
  published
    property About;
    property Active:Boolean read FActive write SetEnabled default True;
    property HotKey:TShortcut read FGlobalKey write SetHotKey;
    property OnKeyDown: TKeyEvent read FOnKeyDown write FOnKeyDown;
  end;

implementation

uses
  Forms, SysUtils, 
  LMDTypes, LMDProcs;

{------------------------- Private --------------------------------------------}
procedure TLMDGlobalHotKey.SetEnabled(aValue:Boolean);
var
  sh:TShiftState;
  tmpi:Integer;
  tmp:Word;

begin
  if FActive<>aValue then
    begin
      FActive:=aValue;
      if csDesigning in ComponentState then exit;
      if FActive then
        begin
          tmpi:=0;
          ShortCutToKey(FGlobalKey, tmp, sh);
          if ssCtrl in sh then tmpi:=MOD_CONTROL;
          if ssAlt in sh then tmpi:=tmpi or MOD_ALT;
          if ssShift in sh then tmpi:=tmpi or MOD_SHIFT;
          RegisterHotKey(FWndHandle, FAtom, tmpi, tmp);
        end
      else
        if FGlobalKey<>0 then UnregisterHotKey(FWndHandle, FAtom);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDGlobalHotKey.SetHotKey(aValue:TShortcut);
var
  sh:TShiftState;
  tmpi:Integer;
  tmp:Word;

begin
  if (FGlobalKey<>aValue) then
    begin
      if (csDesigning in ComponentState) then
        begin
          FGlobalKey:=aValue;
          exit;
        end;
      if FActive then
        if aValue<>0 then
          begin
            tmpi:=0;
            ShortCutToKey(aValue, tmp, sh);
            if ssCtrl in sh then tmpi:=MOD_CONTROL;
            if ssAlt in sh then tmpi:=tmpi or MOD_ALT;
            if ssShift in sh then tmpi:=tmpi or MOD_SHIFT;
            RegisterHotKey(FWndHandle, FAtom, tmpi, tmp);
          end
        else
          if FGlobalKey<>0 then UnregisterHotKey(FWndHandle, FAtom);
      FGlobalKey:=aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDGLobalHotKey.NewWndProc(var Message:TMessage);
var
  tmp:Word;
  sh:TShiftState;
begin
  case Message.Msg of
    WM_HOTKEY: if Assigned(FOnKeyDown) then
                  try
                    ShortCutToKey(FGlobalKey, tmp, sh);
                    FOnKeyDown(self, tmp, sh);
                  except
                    Application.HandleException(Self);
                  end;
    else
      with Message do
        result := DefWindowProc(FWndHandle, Msg, wParam, lParam);
  end;
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDGlobalHotKey.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FAtom := GlobalAddAtom(PChar(IntToStr(TLMDPtrInt(Self))));

  FWndHandle:=AllocateHWnd(NewWndProc);
  FActive:=True;
end;

{------------------------------------------------------------------------------}
destructor TLMDGlobalHotKey.Destroy;
begin
  if FGlobalKey<>0 then HotKey:=0;
  DeleteAtom(FAtom);
  if FWndHandle <> 0 then
    DeallocateHWnd(FWndHandle);
  FWndHandle := 0;
  inherited Destroy;
end;

end.
