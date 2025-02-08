unit LMDTripleClick;
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

LMDTripleClick unit - Triple click for TWinControl descendant (AIH, AH)
-----------------------------------------------------------------------

ToDo
----

Changes
-------
Release 8.0 (July 2006)
 - Initial Release

###############################################################################}

interface

uses
  Messages, Windows, Controls, SysUtils, Classes, LMDCustomComponent;

type
  TLMDMouseSensitivity = (ctoOwner, ctoWindows);

  TLMDTripleClick = class(TLMDCustomComponent)
  private
    FControl: TControl;
    FMouseSensitivity: TLMDMouseSensitivity;
    FDoubleClickTimeout: LongWord;
    FDoubleClickCX,
    FDoubleClickCY: Integer;
    FNativeWinProc: TWndMethod;
    FLastClickTime: LongWord;
    FClickCount: Byte;
    FOnTripleClick: TNotifyEvent;
    FHideDoubleClickEvent: boolean;
    FFirstClickX,
    FFirstClickY: Integer;
    procedure SetControl(AControl: TControl);
    procedure SetMouseSensitivity(AMouseSensitivity: TLMDMouseSensitivity);
    procedure SetDoubleClickTimeout(AOwnerTimout: LongWord);
    procedure GetOSMouseSensitivity;
    procedure WindowProc(var Msg: TMessage);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
  published
    property About;
    property Control: TControl read FControl write SetControl;
    property DeltaX: Integer read FDoubleClickCX write FDoubleClickCX default 0;
    property DeltaY: Integer read FDoubleClickCY write FDoubleClickCY default 0;
    property DoubleClickTimeout: LongWord read FDoubleClickTimeout write setDoubleClickTimeout default 0;
    property HideDoubleClickEvent: Boolean read FHideDoubleClickEvent write FHideDoubleClickEvent default false;
    property MouseSensitivity: TLMDMouseSensitivity read FMouseSensitivity write SetMouseSensitivity default ctoOwner;
    property OnTripleClick: TNotifyEvent read FOnTripleClick write FOnTripleClick;
  end;

implementation

{ ********************* TLMDTripleClick ***************************************}
{-------------------------- private -------------------------------------------}
procedure TLMDTripleClick.SetControl(AControl: TControl);
begin
  if AControl <> FControl then
  begin
    // Restore old WindowProc value
    if not (csDesigning in ComponentState) and (Assigned(FControl)) then
      FControl.WindowProc := FNativeWinProc;
    if (AControl <> nil) then
      begin
        FControl := AControl;
        if not (csDesigning in ComponentState) then
          begin
            FNativeWinProc := FControl.WindowProc;
            FControl.WindowProc := WindowProc;
          end;
        FControl.FreeNotification(Self);
      end
    else
      begin
        FNativeWinProc := nil;
        FControl := nil;
      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTripleClick.setDoubleClickTimeout;
begin
  MouseSensitivity := ctoOwner;
  FDoubleClickTimeout := AOwnerTimout;
end;

{------------------------------------------------------------------------------}
procedure TLMDTripleClick.SetMouseSensitivity(AMouseSensitivity: TLMDMouseSensitivity);
begin
  FMouseSensitivity := AMouseSensitivity;
  if AMouseSensitivity = ctoWindows then
    GetOSMouseSensitivity()
  else
    FMouseSensitivity := FMouseSensitivity;
end;

{------------------------------------------------------------------------------}
procedure TLMDTripleClick.GetOSMouseSensitivity;
begin
  FDoubleClickCX := GetSystemMetrics(SM_CXDOUBLECLK);
  FDoubleClickCY := GetSystemMetrics(SM_CYDOUBLECLK);
  FDoubleClickTimeout := GetDoubleClickTime();
end;

{------------------------------------------------------------------------------}
procedure TLMDTripleClick.WindowProc(var Msg: TMessage);
var
  LClickTime: LongWord;
begin
  if (Msg.Msg <> WM_LBUTTONDBLCLK) or (not HideDoubleClickEvent) then
    FNativeWinProc(Msg);
  if (Msg.Msg = WM_LBUTTONDOWN) or (Msg.Msg = WM_LBUTTONDBLCLK) then
    begin
      LClickTime := GetTickCount();
      if (LClickTime - FLastClickTime > FDoubleClickTimeout)
        or (abs(Msg.LParamLo - FFirstClickX) > DeltaX)
          or (abs(Msg.LParamHi - FFirstClickY) > DeltaY) then
        begin
          FClickCount := 1;
          FLastClickTime := LClickTime;
        end
      else
      begin
        case FClickCount of
          0, 1:
            begin
              Inc(FClickCount);
              FLastClickTime := LClickTime;
            end;
          2:
            begin
              if Assigned(FOnTripleClick) then
                FOnTripleClick(FControl);
              FClickCount := 0;
              FLastClickTime := 0;
            end;
        end;
      end;
      if (FClickCount = 1) then
        begin
          FFirstClickX := Msg.LParamLo;
          FFirstClickY := Msg.LParamHi;
        end;
    end;
end;

{------------------------- protected ------------------------------------------}
procedure TLMDTripleClick.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FControl) then
    SetControl(nil);
end;

{-------------------------- public --------------------------------------------}
constructor TLMDTripleClick.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLastClickTime := 0;
  FClickCount := 0;
end;

{------------------------------------------------------------------------------}
destructor TLMDTripleClick.Destroy;
begin
  if (FControl <> nil) and (not (csDesigning  in ComponentState)) then
    FControl.WindowProc := FNativeWinProc;
  inherited;
end;

end.
