unit ElTreeCheckBoxEdit;
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

ElTreeCheckBoxEdit unit
-----------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Messages,
  Controls,
  Forms,

  SysUtils,
  Classes,
  Types,
  ElStyleMan,

  ElTree,
  ElHeader,
  ElCheckCtl,
  ElTreeInplaceEditors;

type
    TElTreeInplaceCheckBoxEdit = class(TElTreeInplaceEditor)
    private
      SaveWndProc: TWndMethod;
      procedure EditorWndProc(var Message : TMessage);
    protected
      procedure AdjustBounds; override;
      function GetEditor: TElCheckBox;
      procedure DoStartOperation; override;
      procedure DoStopOperation(Accepted : boolean); override;
      function GetVisible: Boolean; override;
      procedure TriggerAfterOperation(var Accepted : boolean; var DefaultConversion :
          boolean); override;
      procedure TriggerBeforeOperation(var DefaultConversion : boolean); override;
      procedure SetEditorParent; override;
      function GetStyleManager: TElStyleManager;
      function GetStyleName: string;
      procedure SetStyleManager(Value: TElStyleManager);
      procedure SetStyleName(const Value: string);
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      property Editor: TElCheckBox read GetEditor;
    published
      property StyleManager: TElStyleManager read GetStyleManager write
          SetStyleManager;
      property StyleName: string read GetStyleName write SetStyleName;
    end;

implementation

constructor TElTreeInplaceCheckBoxEdit.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := TElCheckBox.Create(Self);
  FEditor.Visible := false;
  Editor.AutoSize := false;
  Editor.HandleDialogKeys := true;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  FDefaultValueAsText := '';
  FTypes := [sftBool];
end;

destructor TElTreeInplaceCheckBoxEdit.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElTreeInplaceCheckBoxEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElTreeInplaceCheckBoxEdit.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

function TElTreeInplaceCheckBoxEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElTreeInplaceCheckBoxEdit.TriggerAfterOperation(var Accepted :
    boolean; var DefaultConversion : boolean);
begin
  Editor.OnExit := nil;
  inherited;
  if DefaultConversion then
  begin
    if Editor.Checked then
      ValueAsText := FDefaultValueAsText
    else
      ValueAsText := '';
  end;
end;

procedure TElTreeInplaceCheckBoxEdit.TriggerBeforeOperation(var
    DefaultConversion : boolean);
begin
  AdjustBounds;
  inherited;
  if DefaultConversion then
    Editor.Checked := ValueAsText <> '';
end;

type THackElTree = class(TCustomElTree);

procedure TElTreeInplaceCheckBoxEdit.EditorWndProc(var Message : TMessage);
var
  InputValid : boolean;
  begin
  if Message.Msg = WM_KEYDOWN then
  begin
    TriggerKeyDown(TWMKey(Message));
    with TWMKey(Message) do
    begin
      if KeyDataToShiftState(KeyData) = [] then
      begin
        if CharCode = VK_RETURN then
        begin
          InputValid := true;
          FEditing := false;
          TriggerValidateResult(InputValid);
          FEditing := true;
          if InputValid then
          begin
            CompleteOperation(true);
            CharCode := 0;
            exit;
          end
          else
            Editor.SetFocus;
          CharCode := 0;
        end
        else
        if CharCode = VK_ESCAPE then
        begin
          CompleteOperation(false);
          CharCode := 0;
          exit;
        end;
      end;
    end;
  end
  else
  if (Message.Msg = WM_CANCELMODE) or
     ((Message.Msg = CM_CANCELMODE) and
      (TObject(Pointer(Message.lParam)) <> Editor)) or
      (Message.Msg = WM_KILLFOCUS) then
    if FEditing then
    begin
      if THackElTree(Tree).ExplorerEditMode then
      begin
        EndEditWithInputChecked;
      end
      else
        CompleteOperation(false);
    end;
  SaveWndProc(Message);
end;

procedure TElTreeInplaceCheckBoxEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

function TElTreeInplaceCheckBoxEdit.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

function TElTreeInplaceCheckBoxEdit.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

procedure TElTreeInplaceCheckBoxEdit.SetStyleManager(Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

procedure TElTreeInplaceCheckBoxEdit.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;

procedure TElTreeInplaceCheckBoxEdit.AdjustBounds;
var
  r: TRect;
begin
  r := FCellRect;
  if not VerticalLines then
    Inc(r.Left, 2);
  FEditor.BoundsRect := r;
end;

function TElTreeInplaceCheckBoxEdit.GetEditor: TElCheckBox;
begin
  Result := FEditor as TElCheckBox;
end;

end.
