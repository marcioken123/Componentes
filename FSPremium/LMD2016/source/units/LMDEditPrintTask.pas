unit LMDEditPrintTask;
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

LMDEditPrintTask unit (RS)
-----------------------------------
Contains print task for printing edit controls - descendats of LMDBaseEdit

Changes
-------
* Not released yet

###############################################################################}

interface

uses
  Math, Classes, SysUtils, Controls, StdCtrls, ComCtrls, Grids,
  Windows, Printers, Graphics, Dialogs, Types,
  LMDTypes, LMDCustomComponent, LMDBaseEdit, LMDPrinter, LMDControlPrintTasks;

type

  TLMDEditControlPrintTask = class(TLMDCustomEditPrintTask)
  private
    FEditor: TLMDBaseEdit;
    procedure SetEditor(const Value: TLMDBaseEdit);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure GetControlText(ATargetStrings: TLMDStrings); override;
  published
    property Editor: TLMDBaseEdit read FEditor write SetEditor;
  public
    destructor Destroy; override;   
  end;

implementation

{ TLMDEditControlPrintTask }

destructor TLMDEditControlPrintTask.Destroy;
begin
  SetEditor(nil);
  inherited;
end;

procedure TLMDEditControlPrintTask.GetControlText(
  ATargetStrings: TLMDStrings);
begin
  if Assigned(Self.Editor) then
    ATargetStrings.Text := Self.FEditor.Text;
end;

procedure TLMDEditControlPrintTask.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if Operation<>opRemove then
    Exit;

  if AComponent = FEditor then
    FEditor := nil;

  inherited;
end;

procedure TLMDEditControlPrintTask.SetEditor(const Value: TLMDBaseEdit);
begin
  if FEditor<>nil then
    FEditor.RemoveFreeNotification(Self);

  FEditor := Value;

  if FEditor<>nil then
    FEditor.FreeNotification(Self);
end;

end.
