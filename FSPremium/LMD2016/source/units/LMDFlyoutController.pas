unit LMDFlyoutController;
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

LMDFlyoutController unit (VB)
-----------------------------

Changes
-------
Release 1.0 (Decemner 2012)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Messages,
  Classes,
  Controls,
  ExtCtrls,
  LMDWndProcComponent;

type
  TLMDFlyoutPosition = (fopTop, fopRight, fopBottom, fopLeft);


  {------------------------- TLMDFlyoutController --------------------------------}
  TLMDFlyoutController = class(TLMDWndProcComponent)
  private
    FActive: boolean;
    FControl:TControl;
    FTimer: TTimer;
    FHiding: boolean;
    FShowing: boolean;
    FPosition: TPoint;
    FDestination: TLMDFlyoutPosition;
    FTriggerDistance: integer;
    FControlVisible: boolean;
    FStep: integer;
    procedure SetControl(aControl:TControl);
    procedure SetDestination(const Value: TLMDFlyoutPosition);
    procedure SetTriggerDistance(const Value: integer);
    procedure SetActive(const Value: boolean);
    procedure SetStep(const Value: integer);
  protected
    function  HasControl: Boolean;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    procedure Timer(Sender: TObject);
    procedure Show; virtual;
    procedure Hide; virtual;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property About;
    property Active: boolean read FActive write SetActive;
    property Control:TControl read FControl write SetControl stored HasControl;
    property Destination: TLMDFlyoutPosition read FDestination write SetDestination;
    property Position: TPoint read FPosition write FPosition;
    property TriggerDistance: integer read FTriggerDistance write SetTriggerDistance;
    property Step: integer read FStep write SetStep;
  end;

implementation

uses
  Types, StdCtrls, Forms;

{--------------------------- Private ------------------------------------------}
procedure TLMDFlyoutController.SetControl(aControl:TControl);
begin
  if AControl<>FControl then
  begin
    FControl:=AControl;
    if FControl <> nil then FControl.FreeNotification(Self);
  end;
end;


{--------------------------- Protected ----------------------------------------}
function TLMDFlyoutController.HasControl:Boolean;
begin
  result := FControl <> nil;
end;

{---------------------------------------------------------------------------}
procedure TLMDFlyoutController.Notification(AComponent: TComponent;  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent=FControl) and (Operation = opRemove) then
    FControl := nil;
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDFlyoutController.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FStep := 10;
  FActive := true;
  FDestination := fopTop;
  FControlVisible := false;
  FShowing := false;
  FHiding := false;
  FTimer := TTimer.Create(self);
  FTimer.Enabled := false;
  FTimer.Interval := 1;
  FTimer.OnTimer := Timer;
  FTriggerDistance := 10;  
end;

{------------------------------------------------------------------------------}
destructor TLMDFlyoutController.Destroy;
begin
  FTimer.Enabled := false;
  FControl := nil;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDFlyoutController.Hide;
begin
  FShowing := false;
  FHiding := true;
  FTimer.Enabled := true;
end;

{------------------------------------------------------------------------------}
procedure TLMDFlyoutController.Show;
begin
  if not HasControl then
    exit;
  with FControl do
  begin
    case Destination of
      fopLeft:
        begin
          Left := -Width;
          Top := Position.Y;
        end;
      fopTop:
        begin
          Top := -Height;
          Left := Position.X;
        end;
      fopRight:
        begin
          Left := WndOwner.Width + Width;
          Top := Position.Y;
        end;
      fopBottom:
        begin
          Top := WndOwner.Height + Height;
          Left := Position.X;
        end;  
    end;
    Visible := true;
  end;
  FShowing := true;
  FHiding := false;
  FTimer.Enabled := true;
end;

{------------------------------------------------------------------------------}
procedure TLMDFlyoutController.Timer(Sender: TObject);

  procedure StopShowing;
  begin
    FTimer.Enabled := false;
    FShowing := false;
    FControlVisible := true;
  end;

  procedure StopHiding;
  begin
    FTimer.Enabled := false;
    FHiding := false;
    FControlVisible := false;
    FControl.Visible := false;
  end;

begin
  if not HasControl or (csDesigning in ComponentState) then
    exit;
  with FControl do
  begin
    if Align <> alNone then
      Align := alNone;

    case Destination of
      fopTop:
      begin
        if FHiding then
        begin
          Top := Top - Step;
          if (Top + Height) < 0 then
            StopHiding;
        end;
        if FShowing then
        begin
          Top := Top + Step;
          if Top > 0 then
          begin
            FControl.Top := FPosition.Y;
            StopShowing;
          end;
        end;
      end;

      fopLeft:
      begin
        if FHiding then
        begin
          Left := Left - Step;
          if (Left + Width) < 0 then
            StopHiding;
        end;
        if FShowing then
        begin
          Left := Left + Step;
          if Left > 0 then
          begin
            FControl.Left := FPosition.X;
            StopShowing;
          end;
        end;
      end;

      fopRight:
      begin
        if FHiding then
        begin
          Left := Left + Step;
          if Left > WndOwner.ClientRect.Right then
            StopHiding;
        end;
        if FShowing then
        begin
          Left := Left - Step;
          if Left < WndOwner.ClientRect.Right - FControl.Width then
          begin
            FControl.Left := WndOwner.ClientRect.Right - FControl.Width - FPosition.X;
            StopShowing;
          end;
        end;
      end;

      fopBottom:
      begin
        if FHiding then
        begin
          Top := Top + Step;
          if Top > WndOwner.ClientRect.Bottom then
            StopHiding;
        end;
        if FShowing then
        begin
          Top := Top - Step;
          if Top < WndOwner.ClientRect.Bottom - FControl.Height then
          begin
            FControl.Top := WndOwner.ClientRect.Bottom - FControl.Height - FPosition.Y;
            StopShowing;
          end;
        end;
      end;

    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFlyoutController.WndProc(var Message: TMessage);
var
  LPos: TPoint;

  procedure Default;
  begin
    CallPrevWndProc(Message);
  end;

begin
  if not FActive or not HasControl or (csDesigning in ComponentState) then
  begin
    Default;
    exit;
  end;

  with Message do
  begin
    case msg of
      WM_MOUSEMOVE:
      if not FHiding and not FShowing then
      begin
        LPos.X := TWMMouseMove(Message).XPos;
        LPos.Y := TWMMouseMove(Message).YPos;
        case Destination of
          fopLeft:
            if FControlVisible then
            begin
              if LPos.X > FControl.Left + FControl.Width + FTriggerDistance then
                Hide;
            end
            else
            begin
              if LPos.X < FControl.Width + FTriggerDistance then
                Show;
            end;
          fopTop:
            if FControlVisible then
            begin
              if LPos.Y > FControl.Top + FControl.Height + FTriggerDistance then
                Hide;
            end
            else
            begin
              if LPos.Y < FControl.Height + FTriggerDistance then
                Show;
            end;
          fopRight:
            if FControlVisible then
            begin
              if LPos.X < WndOwner.ClientRect.Right - FControl.Width - FTriggerDistance then
                Hide;
            end
            else
            begin
              if LPos.X > WndOwner.ClientRect.Right - FControl.Width - FTriggerDistance then
                Show;
            end;
          fopBottom:
            if FControlVisible then
            begin
              if LPos.Y < WndOwner.ClientRect.Bottom - FControl.Height - FTriggerDistance then
                Hide;
            end
            else
            begin
              if LPos.Y > WndOwner.ClientRect.Bottom - FControl.Height - FTriggerDistance then
                Show;
            end;

        end;
      end;
    end;
    Default;
  end;

end;

{------------------------------------------------------------------------------}
procedure TLMDFlyoutController.SetDestination(
  const Value: TLMDFlyoutPosition);
begin
  FDestination := Value;
  Hide;
end;

{------------------------------------------------------------------------------}
procedure TLMDFlyoutController.SetTriggerDistance(const Value: integer);
begin
  FTriggerDistance := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDFlyoutController.SetActive(const Value: boolean);
begin
  FActive := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDFlyoutController.SetStep(const Value: integer);
begin
  FStep := Value;
end;

end.
