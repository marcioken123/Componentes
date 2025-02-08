{ Summary
  Unit that registers the TJSEditDialog design time component editor. }
unit JSEditDialogDesignReg;

interface

{$I lmddlgcmps.inc}

uses
    {$IFDEF DELPHI5}
    DsgnIntf
    {$ELSE}
    DesignEditors
    {$ENDIF DELPHI5}
  , JSDialogDesignReg
  ;

type
  TPreviewEditDialogEditor = class(TPreviewDialogEditor)
  private
    procedure PreviewHelpLinkClick(Sender: TObject; var Handled: Boolean);
  protected
    function GetComponentVersion: string; override;
    procedure ShowCustomise; override;
    procedure ShowPreview; override;
  end;

{ Summary
  Registers the component editors required by the components. }
procedure Register;

implementation

uses
    CustomiseEditDialog
  {$IFNDEF DELPHI5}
  , DesignIntf
  {$ENDIF DELPHI5}
  , JSEditDialog
  , SysUtils
  , Dialogs
  ;

procedure Register;
begin
  {$IFDEF BDS}
//  ForceDemandLoadState(dlDisable);
  {$ENDIF BDS}
  RegisterComponentEditor(TJSEditDialog, TPreviewEditDialogEditor);
end;

{ TPreviewDialogEditor }

function TPreviewEditDialogEditor.GetComponentVersion: string;
begin
  result := DIALOGPACK_VERSION;
end;

procedure TPreviewEditDialogEditor.PreviewHelpLinkClick(Sender: TObject; var Handled: Boolean);
begin
  Handled := True;
end;

procedure TPreviewEditDialogEditor.ShowCustomise;
begin
  if TfrmCustomiseEditDialog.Execute(Component as TJSEditDialog, TJSEditDialog, TfrmCustomiseEditDialog) then
    Designer.Modified;
end;

procedure TPreviewEditDialogEditor.ShowPreview;
var
  lComp: TJSEditDialog;
  lNewDialog: TJSEditDialog;
begin
  lComp := (Component as TJSEditDialog);
  lNewDialog := TJSEditDialog.Create(nil);
  try
    try
      lNewDialog.Assign(lComp);
      lNewDialog.OnHelpLinkClick := PreviewHelpLinkClick;
      lNewDialog.ExecutePreview;
    except
      on E: Exception do
        MessageDlg('ShowPreview raised the following exception.'#13#10 +
                   'Please report to mail@lmdsupport.com'#13#10#13#10 +
                   E.Message + #13#10#13#10 + 'You should restart your IDE now.' 
		   , mtError, [mbOK], 0);
    end;
  finally
    lNewDialog.Free;
  end;
end;

end.
