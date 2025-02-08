{ Summary
  Unit that registers the TJSDialog design time component editor. }
unit JSDialogDesignReg;

interface

{$I lmddlgcmps.inc}

uses
  {$IFDEF DELPHI5}DsgnIntf{$ELSE}DesignEditors{$ENDIF DELPHI5};
const
  DIALOGPACK_VERSION = '2014.0';

type
  TPreviewDialogEditor = class(TComponentEditor)
  private
    procedure PreviewHelpLinkClick(Sender: TObject; var Handled: Boolean);
  protected
    function GetComponentVersion: string; virtual;
    procedure ShowCustomise; virtual;
    procedure ShowPreview; virtual;
    procedure LoadCommandLinkColors; virtual;
    procedure SaveCommandLinkColors; virtual;
  public
    procedure Edit; override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TCheckPreviewDialogEditor = class(TPreviewDialogEditor)
  protected
    procedure ShowPreview; override;
  end;
  
{ Summary
  Registers the component editors required by the components. }
procedure Register;

implementation

uses
    CustomiseDialog
  {$IFNDEF DELPHI5}
  , DesignIntf
  {$ENDIF DELPHI5}
  , JSDialog
  , JSDialogCheck
  , SysUtils
  , Dialogs
  ;

procedure Register;
begin
  {$IFDEF BDS}
  ForceDemandLoadState(dlEnable);
  {$ENDIF BDS}
  RegisterComponentEditor(TJSDialog, TPreviewDialogEditor);
  RegisterComponentEditor(TJSDialogCheck, TCheckPreviewDialogEditor);
end;

{ TPreviewDialogEditor }

procedure TPreviewDialogEditor.Edit;
begin
  ExecuteVerb(0);
end;

procedure TPreviewDialogEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: ShowCustomise;
    1: LoadCommandLinkColors;
    2: SaveCommandLinkColors;
    3: ;
    4: ShowPreview;
    5: ;
  end;
end;

function TPreviewDialogEditor.GetComponentVersion: string;
begin
  result := DIALOGPACK_VERSION;
end;

function TPreviewDialogEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: result := 'Customise...';
    1: Result := 'Load Command Link Colors...';
    2: Result := 'Save Command Link Colors...';
    3: Result := '-';
    4: result := 'Preview';
    5: result := Format('LMD DialogPack %s', [GetComponentVersion]);
  end;
end;

function TPreviewDialogEditor.GetVerbCount: Integer;
begin
  result := 6;
end;

procedure TPreviewDialogEditor.LoadCommandLinkColors;
var
  LOpenDlg: TOpenDialog;
  LDialog: TJSDialog;
begin
  LOpenDlg := TOpenDialog.Create(nil);
  LOpenDlg.Filter := 'Command Link Color Scheme *.cbc|*.cbc';
  if LOpenDlg.Execute then
  begin
    LDialog := TJSDialog(Component);
    if LDialog <> nil then
    begin
      LDialog.Button.CommandLinkColors.LoadFromFile(LOpenDlg.Filename);
      Designer.Modified;
    end;
  end;
end;

procedure TPreviewDialogEditor.PreviewHelpLinkClick(Sender: TObject; var Handled: Boolean);
begin
  Handled := True;
end;

procedure TPreviewDialogEditor.SaveCommandLinkColors;
var
  LSaveDlg: TOpenDialog;
  LDialog: TJSDialog;
begin
  LSaveDlg := TSaveDialog.Create(nil);
  LSaveDlg.Filter := 'Command Link Color Scheme *.cbc|*.cbc';
  LSaveDlg.DefaultExt := 'cbc';
  if LSaveDlg.Execute then
  begin
    LDialog := TJSDialog(Component);
    if LDialog <> nil then
    begin
      LDialog.Button.CommandLinkColors.SaveToFile(LSaveDlg.Filename);
    end;
  end;
end;

procedure TPreviewDialogEditor.ShowCustomise;
begin
  if TfrmCustomiseDialog.Execute(Component as TJSDialog, TJSDialog, TfrmCustomiseDialog) then
    Designer.Modified;
end;

procedure TPreviewDialogEditor.ShowPreview;
var
  lComp: TJSDialog;
  lNewDialog: TJSDialog;
begin
  lComp := (Component as TJSDialog);
  lNewDialog := TJSDialog.Create(nil);
  try
    try
      lNewDialog.Assign(lComp);
      lNewDialog.OnHelpLinkClick := PreviewHelpLinkClick;
      lNewDialog.AllowCancel := True;
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

{ TCheckPreviewDialogEditor }

procedure TCheckPreviewDialogEditor.ShowPreview;
var
  lComp: TJSDialogCheck;
  lNewDialog: TJSDialogCheck;
begin
  lComp := (Component as TJSDialogCheck);
  lNewDialog := TJSDialogCheck.Create(nil);
  try
    try
      lNewDialog.Assign(lComp);
      lNewDialog.OnHelpLinkClick := PreviewHelpLinkClick;
      lNewDialog.AllowCancel := True;
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
