unit pLMDTaskDialogEditor;
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

LMD-Tools Shared(X) LMDTaskDialog editor (AH)
---------------------------------------------

Changes
-------
Release 8.0 (May 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DesignIntf, DesignEditors,
  LMDTaskDlg, LMDTaskDialogDsgn;

type
  TLMDTaskDialogEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

implementation

{ ***************************** TLMDTaskDialogEditor ************************* }
{------------------------------------------------------------------------------}
procedure TLMDTaskDialogEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then
  begin
    LMDTaskDialogDesigner := TLMDTaskDialogDesigner.Create(Application);
    try
      LMDTaskDialogDesigner.TaskDialog := TLMDTaskDialog(Component);
      LMDTaskDialogDesigner.Caption := 'TaskDialog Designer: ' + LMDTaskDialogDesigner.TaskDialog.Name;
      LMDTaskDialogDesigner.ShowModal;
      if LMDTaskDialogDesigner.ModalResult = mrOk then
      begin
        TLMDTaskDialog(Component).Assign(LMDTaskDialogDesigner.TaskDialog);
        Designer.Modified;
      end;
    finally
      FreeAndNil(LMDTaskDialogDesigner);
    end;
  end;
  if Index = 1 then
  begin
    (Component as TLMDTaskDialog).Execute;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDTaskDialogEditor.GetVerb(Index: Integer): string;
begin
  case Index of
  0: Result := 'TaskDialog designer...';
  1: Result := 'Show dialog...';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDTaskDialogEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

end.
