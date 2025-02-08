{ Summary
  Unit that contains the TJSDialogSheet component.
  Description
  While all of the sheet specific code is available in TJSCustomDialog, this component enables faster access to usage,
  as well as the setting some required properties to their Sheet expected values. }
unit JSDialogSheet;

interface

{$I lmddlgcmps.inc}

uses
  Windows, Classes, Forms, JSDialog, JSDialogs, SysUtils, Messages;

type
  TJSCustomDialogSheet = class(TJSDialog)
  private
    FOldWndProc: TWndMethod;
    FActiveForm: TCustomForm;
  protected
    procedure ActiveFormWndProc(var Message: TMessage);
  public
    constructor Create(AOwner: TComponent); override;
    function Execute(aOwner: TComponent): Integer; override;
    function Close(const AModalResult: Integer): Integer; override;
  end;

  TJSDialogSheet = class(TJSCustomDialogSheet)
  published
    property BorderStyle default bsNone;
    property Position default dpDesigned;
    property DialogStyle default dsSheet;
  end;

implementation

{ TJSCustomDialogSheet }

procedure TJSCustomDialogSheet.ActiveFormWndProc(var Message: TMessage);
begin
  if Assigned(FOldWndProc) then
    FOldWndProc(Message);

  case Message.Msg of
    WM_CLOSE:
      begin
        FActiveForm := nil;
      end;
    WM_MOVE, WM_MOVING, WM_SIZE, WM_SIZING:
      begin
        if FActiveForm <> nil then
        begin
          FForm.Top := FActiveForm.Top + GetCaptionHeight(FActiveForm);
          FForm.Top := AdjustSheetTopPosition(FForm.Top);
          FForm.Left := FActiveForm.Left + ((FActiveForm.Width - FForm.Width) div 2);
        end;
      end;
  end;
end;

function TJSCustomDialogSheet.Close(const AModalResult: Integer): Integer;
begin
  if not (doModal in DialogOptions) and (Sheet.Location = slActiveForm) then
  begin
    // unhook form for movement
    if FActiveForm <> nil then
    begin
      FActiveForm.WindowProc := FOldWndProc;
      FActiveForm := nil;
    end;
  end;
  Result := inherited Close(AModalResult);
end;

constructor TJSCustomDialogSheet.Create(AOwner: TComponent);
begin
  inherited;
  BorderStyle := bsNone;
  Position := dpDesigned;
  DialogStyle := dsSheet;
  Border.Visible := True;
end;

function TJSCustomDialogSheet.Execute(aOwner: TComponent): Integer;
begin
  if not (doModal in DialogOptions) and (Sheet.Location = slActiveForm) then
  begin
    // hook active form for movement
    FActiveForm := Screen.ActiveCustomForm;
    if FActiveForm <> nil then
    begin
      FOldWndProc := FActiveForm.WindowProc;
      FActiveForm.WindowProc := ActiveFormWndProc;
    end;
  end;
  Result := inherited Execute(AOwner);
end;

end.
