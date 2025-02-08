unit LMDRichEditPrintTask;
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

LMDRichEditPrintTask unit (RS)
-----------------------------------
Contains print task for printing edit controls - descendats of LMDCustomRichEdit

Changes
-------
* Not released yet

###############################################################################}

interface

uses
    Math, Classes, SysUtils, Controls, StdCtrls, ComCtrls, Grids,
    Windows, Printers, Graphics, Dialogs, Types,
    LMDTypes, LMDCustomComponent, LMDRTFRichEdit, LMDDocElementRenderer, LMDPrinter,
    LMDControlPrintTasks;

type

  TLMDRichEditPrintTask = class(TLMDCustomEditPrintTask)
  private
    FEditor: TLMDCustomRichEdit;
    procedure SetEditor(const Value: TLMDCustomRichEdit);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure GetControlText(ATargetStrings: TLMDStrings); override;
  public
    destructor Destroy; override;
    function getLMDPackage:TLMDPackageID;override;
  published
    property Editor: TLMDCustomRichEdit read FEditor write SetEditor;
  end;

implementation

{ TLMDEditControlPrintTask }

destructor TLMDRichEditPrintTask.Destroy;
begin
  SetEditor(nil);
  inherited;
end;

procedure TLMDRichEditPrintTask.GetControlText(ATargetStrings: TLMDStrings);
begin
  if Assigned(Self.Editor) then
    begin
      if Self.TextFormatOptions.IsRTF then
        ATargetStrings.Text := Self.FEditor.RTFText
      else
        ATargetStrings.Text := Self.FEditor.Text;
    end;
end;

function TLMDRichEditPrintTask.getLMDPackage: TLMDPackageID;
begin
  result := pi_LMD_RTF;
end;

procedure TLMDRichEditPrintTask.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if Operation<>opRemove then
    Exit;

  if AComponent = FEditor then
    FEditor := nil;

  inherited;
end;

procedure TLMDRichEditPrintTask.SetEditor(const Value: TLMDCustomRichEdit);
begin
  if FEditor<>nil then
    FEditor.RemoveFreeNotification(Self);

  FEditor := Value;

  if FEditor<>nil then
    FEditor.FreeNotification(Self);
end;

end.
