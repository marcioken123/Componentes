unit LMDEditActions;
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

LMDEditActions unit ()
----------------------

LMD Memo actions.

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses Classes, ActnList, StdCtrls, LMDBaseEdit, Dialogs, LMDConst;

type

  TLMDEditAction = class(TAction)
  private
    FControl: TLMDBaseEdit;
    procedure SetControl(Value: TLMDBaseEdit);
  protected
    function GetControl(Target: TObject): TLMDBaseEdit; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    property Control: TLMDBaseEdit read FControl write SetControl;
  end;

  TLMDEditCut = class(TLMDEditAction)
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TLMDEditCopy = class(TLMDEditAction)
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TLMDEditPaste = class(TLMDEditAction)
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TLMDEditSelectAll = class(TLMDEditAction)
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

  TLMDEditUndo = class(TLMDEditAction)
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

  TLMDEditRedo = class(TLMDEditAction)
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

  TLMDEditDelete = class(TLMDEditAction)
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

  TLMDEditFind = class(TLMDEditAction)
  private
    FindDialog: TFindDialog;
    procedure FindDialogFind(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

  TLMDEditReplace = class(TLMDEditFind)
  private
    ReplaceDialog: TReplaceDialog;
    procedure ReplaceDialogFind(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

implementation

uses Windows, Messages, Clipbrd, SysUtils,  Menus, LMDCustomMemo;

{ ***********************  TLMDEditAction  ****************************** }
{ ------------------------------------------------------------------------- }
function TLMDEditAction.GetControl(Target: TObject): TLMDBaseEdit;
begin
  Result := Target as TLMDBaseEdit;
end;

{ ------------------------------------------------------------------------- }
function TLMDEditAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := ((Control <> nil) and (Target = Control) or
    (Control = nil) and (Target is TLMDBaseEdit)) and TLMDBaseEdit(Target).Focused;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDEditAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Control) then Control := nil;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDEditAction.UpdateTarget(Target: TObject);
begin
  if (Self is TLMDEditCut) or (Self is TLMDEditCopy) then
    Enabled := GetControl(Target).SelLength > 0;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDEditAction.SetControl(Value: TLMDBaseEdit);
begin
  if Value <> FControl then
  begin
    FControl := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

{ ***********************  TLMDEditCopy  ****************************** }
{ ------------------------------------------------------------------------- }
constructor TLMDEditCopy.Create(AOwner: TComponent);
Begin
  inherited Create(AOwner);
  ShortCut := TextToShortCut('Ctrl+C');
  Caption := IDS_COPY;
  Hint := Caption;
End;

{ ------------------------------------------------------------------------- }
procedure TLMDEditCopy.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).CopyToClipboard;
end;

{ ***********************  TLMDEditCut  ****************************** }
{ ------------------------------------------------------------------------- }
constructor TLMDEditCut.Create(AOwner: TComponent);
Begin
  inherited Create(AOwner);
  ShortCut := TextToShortCut('Ctrl+X');
  Caption := IDS_CUT;
  Hint := Caption;
End;

{ ------------------------------------------------------------------------- }
procedure TLMDEditCut.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).CutToClipboard;
end;

{ ***********************  TLMDEditPaste  ****************************** }
{ ------------------------------------------------------------------------- }
constructor TLMDEditPaste.Create(AOwner: TComponent);
Begin
  inherited Create(AOwner);
  ShortCut := TextToShortCut('Ctrl+V');
  Caption := IDS_INSERT;
  Hint := Caption;
End;

{ ------------------------------------------------------------------------- }
procedure TLMDEditPaste.ExecuteTarget(Target: TObject);
begin
   GetControl(Target).PasteFromClipboard;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDEditPaste.UpdateTarget(Target: TObject);
begin
  Enabled := Clipboard.HasFormat(CF_TEXT);
end;

{ ***********************  TLMDEditSelectAll  ****************************** }
{ ------------------------------------------------------------------------- }
constructor TLMDEditSelectAll.Create(AOwner: TComponent);
Begin
  inherited Create(AOwner);
  ShortCut := TextToShortCut('Ctrl+A');
  Caption := IDS_SELECTALL;
  Hint := Caption;
End;

{ ------------------------------------------------------------------------- }
procedure TLMDEditSelectAll.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).SelectAll;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDEditSelectAll.UpdateTarget(Target: TObject);
begin
  Enabled := Length(GetControl(Target).Text) > 0;
end;

{ ***********************  TLMDEditUndo  ****************************** }
{ ------------------------------------------------------------------------- }
constructor TLMDEditUndo.Create(AOwner: TComponent);
Begin
  inherited Create(AOwner);
  ShortCut := TextToShortCut('Ctrl+Z');
  Caption := IDS_UNDO;
  Hint := Caption;
End;

{ ------------------------------------------------------------------------- }
procedure TLMDEditUndo.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).Undo;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDEditUndo.UpdateTarget(Target: TObject);
begin
  Enabled := True;
//  GetControl(Target).CanUndo; {CanUndo - not public)
end;

{ ***********************  TLMDEditRedo  ****************************** }
{ ------------------------------------------------------------------------- }
constructor TLMDEditRedo.Create(AOwner: TComponent);
Begin
  inherited Create(AOwner);
  ShortCut := TextToShortCut('Shift+Ctrl+Z');
  Caption := IDS_REDO;
  Hint := Caption;
End;

{ ------------------------------------------------------------------------- }
procedure TLMDEditRedo.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).Redo;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDEditRedo.UpdateTarget(Target: TObject);
begin
  Enabled := True;
//  GetControl(Target).CanRedo; {CanRedo - not public)
end;

{ ***********************  TLMDEditDelete  ****************************** }
{ ------------------------------------------------------------------------- }
constructor TLMDEditDelete.Create(AOwner: TComponent);
Begin
  inherited Create(AOwner);
  Caption := IDS_DELETE;
  Hint := Caption;
End;

{ ------------------------------------------------------------------------- }
procedure TLMDEditDelete.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).ClearSelection;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDEditDelete.UpdateTarget(Target: TObject);
begin
  Enabled := GetControl(Target).SelLength > 0;
end;

{ ***********************  TLMDEditFind  ****************************** }
{ ------------------------------------------------------------------------- }
constructor TLMDEditFind.Create(AOwner: TComponent);
Begin
  inherited Create(AOwner);
  ShortCut := TextToShortCut('Ctrl+F');
  Caption := IDS_SEARCH;
  Hint := Caption;
End;

{ ------------------------------------------------------------------------- }
procedure TLMDEditFind.ExecuteTarget(Target: TObject);
begin
  if not assigned(FindDialog) then
    FindDialog:=TFindDialog.Create(Self);
  FindDialog.OnFind := FindDialogFind;
  FControl := GetControl(Target);
  FindDialog.Execute;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDEditFind.UpdateTarget(Target: TObject);
begin
  if GetControl(Target) is TLMDCustomMemo then
    Enabled := TLMDCustomMemo(GetControl(Target)).Lines.Count>1
  else
    Enabled := GetControl(Target).Text<>'';
end;

{ ------------------------------------------------------------------------- }
procedure TLMDEditFind.FindDialogFind(Sender: TObject);
var
  sd : TLMDSearchDirection;
begin
  if frDown in FindDialog.Options then
    sd := sdDown
  else
    sd := sdUp;
  FControl.Search (FindDialog.FindText, stCursor, frMatchCase in FindDialog.Options,
               frWholeWord in FindDialog.Options, sd);
  FControl.SetFocus;
end;

{ ***********************  TLMDEditReplace  ****************************** }
{ ------------------------------------------------------------------------- }
constructor TLMDEditReplace.Create(AOwner: TComponent);
Begin
  inherited Create(AOwner);
  ShortCut := TextToShortCut('Ctrl+R');
  Caption := IDS_REPLACE;
  Hint := Caption;
End;

{ ------------------------------------------------------------------------- }
procedure TLMDEditReplace.ExecuteTarget(Target: TObject);
begin
  if not assigned(ReplaceDialog) then
    ReplaceDialog:=TReplaceDialog.Create(Self);
  ReplaceDialog.OnFind := ReplaceDialogFind;
  ReplaceDialog.OnReplace := ReplaceDialogFind;
  FControl := GetControl(Target);
  ReplaceDialog.Execute;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDEditReplace.UpdateTarget(Target: TObject);
begin
  if GetControl(Target) is TLMDCustomMemo then
    Enabled := TLMDCustomMemo(GetControl(Target)).Lines.Count>1
  else
    Enabled := GetControl(Target).Text<>'';
end;

{ ------------------------------------------------------------------------- }
procedure TLMDEditReplace.ReplaceDialogFind(Sender: TObject);
var
  sd : TLMDSearchDirection;
begin
  if frDown in ReplaceDialog.Options then
    sd := sdDown
  else
    sd := sdUp;
  fControl.SearchAndReplace (ReplaceDialog.FindText, ReplaceDialog.ReplaceText, stCursor,
                             frMatchCase in ReplaceDialog.Options,
                             frWholeWord in ReplaceDialog.Options, sd, true,
                             frReplaceAll in ReplaceDialog.Options);
end;

end.

