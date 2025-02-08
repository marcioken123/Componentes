unit ElFormPgCtl;
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

ElFormPgCtl unit
----------------

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
  Math,
  Messages,
  Consts,
  Graphics,
  Controls,
  Forms,
  Menus,
  CommCtrl,
  ExtCtrls,
  ElFormDisplay,
  ElPgCtl;

type

  TElFormPageControl = class(TElPageControl)
  private
    FChangeLink:TElFormDisplayChangeLink;
    FFormDisplay: TElFormDisplay;
    procedure SetFormDisplay(const Value: TElFormDisplay);
  protected
    procedure Change; override;
    procedure DoFormDisplayChange(Sender: TObject);
    public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Notification(AComponent : TComponent; operation : TOperation); override;
    published
    property FormDisplay: TElFormDisplay read FFormDisplay write SetFormDisplay;
  end;

implementation

{ TElFormPageControl }

procedure TElFormPageControl.Change;
begin
  inherited;
  if Assigned(FFormDisplay) then
  begin
    FFormDisplay.Parent := ActivePage;
    FFormDisplay.Align := alClient;
    if not (csDesigning in ComponentState) then
      FFormDisplay.ActiveFormIndex := ActivePage.PageIndex;
    FFormDisplay.Repaint;
  end;
end;

constructor TElFormPageControl.Create(AOwner: TComponent);
begin
  inherited;
  FChangeLink := TELFormDisplayChangeLink.Create;
  FChangeLink.OnChange := DoFormDisplayChange;
end;

destructor TElFormPageControl.Destroy;
begin
  if Assigned(FFormDisplay) then
    begin
      if csDesigning in ComponentState then
        begin
          FFormDisplay.Align := alNone;
          FFormDisplay.Parent := Parent;
          FFormDisplay.Left := 1;
          FFormDisplay.Top := 1;
        end
      else
        FFormDisplay.Parent := nil;
    end;
  FreeAndNil(FChangeLink);
  inherited;
end;

procedure TElFormPageControl.DoFormDisplayChange(Sender: TObject);
begin
  if [csLoading{, csDesigning}]*ComponentState<>[] then
    exit;
  Change;
end;

{ ---------------------------------------------------------------------------- }
procedure TElFormPageControl.Notification(AComponent : TComponent; operation : TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
    begin
      if (AComponent = FFormDisplay) then
        FFormDisplay := nil;
    end;
end;

procedure TElFormPageControl.SetFormDisplay(const Value: TElFormDisplay);
begin
  if FFormDisplay<>nil then
    FFormDisplay.UnRegisterChanges(FChangeLink);

  FFormDisplay := Value;

  if FFormDisplay<>nil then
    begin
      FFormDisplay.RegisterChanges(FChangeLink);
      FFormDisplay.FreeNotification(Self);
    end;
  DoFormDisplayChange(nil);
end;

end.
