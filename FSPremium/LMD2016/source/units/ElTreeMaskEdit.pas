unit ElTreeMaskEdit;
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

ElTreemaskEdit unit
-------------------


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
  Graphics,
  SysUtils,
  Classes,
  StdCtrls,
  Types,
  // ToDo
  MaskUtils,
  Mask,

  LMDProcs,

  ElStyleMan,
  ElTree,
  ElHeader,
  ElMaskEdit,
  ElTreeInplaceEditors;

type
    TElTreeInplaceMaskEdit = class(TElTreeInplaceEditor)
    private
      SaveWndProc: TWndMethod;
      procedure EditorWndProc(var Message : TMessage);
      procedure SetCharCase(Value: TEditCharCase);
      function GetCharCase: TEditCharCase;
      // ToDo
      procedure SetEditMask(Value: TEditMask);
      function GetEditMask: TEditMask;
      function GetPasswordChar: Char;
      procedure SetPasswordChar(Value: Char);
    protected
      procedure AdjustBounds; override;
      function GetEditor: TElMaskEdit;
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
      property Editor: TElMaskEdit read GetEditor;
    published
      property Font;
      property CharCase: TEditCharCase read GetCharCase write SetCharCase stored True;
      // ToDo
      property EditMask: TEditMask read GetEditMask write SetEditMask;
      property PasswordChar: Char read GetPasswordChar write SetPasswordChar;

      property StyleManager: TElStyleManager read GetStyleManager write
          SetStyleManager;
      property StyleName: string read GetStyleName write SetStyleName;
    end;

implementation

constructor TElTreeInplaceMaskEdit.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := TElMaskEdit.Create(nil);
  Editor.ParentCtl3D := false;
  Editor.Ctl3D := false;
  FEditor.Visible := false;
  Editor.HandleDialogKeys := true;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := Self.EditorWndProc;
  FTypes := [sftText];
end;

destructor TElTreeInplaceMaskEdit.Destroy;
begin
  FEditor.WindowProc := SaveWndProc;
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElTreeInplaceMaskEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElTreeInplaceMaskEdit.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

type THackElTree = class(TCustomElTree);

procedure TElTreeInplaceMaskEdit.EditorWndProc(var Message : TMessage);
var
  InputValid : boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    TriggerKeyDown(TWMKey(Message));
    with TWMKey(Message) do
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

function TElTreeInplaceMaskEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElTreeInplaceMaskEdit.TriggerAfterOperation(var Accepted : boolean;
    var DefaultConversion : boolean);
begin
  Editor.OnExit := nil;
  inherited;
  if DefaultConversion then
    ValueAsText := Editor.EditText;
end;

procedure TElTreeInplaceMaskEdit.TriggerBeforeOperation(var DefaultConversion :
    boolean);
begin
  AdjustBounds;
  inherited;
  if DefaultConversion and (Length(ValueAsText) > 0) then
    Editor.EditText := ValueAsText;
end;

procedure TElTreeInplaceMaskEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

function TElTreeInplaceMaskEdit.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

function TElTreeInplaceMaskEdit.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

procedure TElTreeInplaceMaskEdit.SetStyleManager(Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

procedure TElTreeInplaceMaskEdit.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;

function TElTreeInplaceMaskEdit.GetCharCase: TEditCharCase;
begin
  Result := Editor.CharCase;
end;

procedure TElTreeInplaceMaskEdit.SetCharCase(Value: TEditCharCase);
begin
  Editor.CharCase := Value;
end;

function TElTreeInplaceMaskEdit.GetPasswordChar: Char;
begin
  Result := Editor.PasswordChar;
end;

procedure TElTreeInplaceMaskEdit.SetEditMask(Value: TEditMask);
begin
  Editor.EditMask := Value;
end;

function TElTreeInplaceMaskEdit.GetEditMask: TEditMask;
begin
  Result := Editor.EditMask;
end;

procedure TElTreeInplaceMaskEdit.SetPasswordChar(Value: Char);
begin
  Editor.PasswordChar := Value;
end;

procedure TElTreeInplaceMaskEdit.AdjustBounds;
var
  r: TRect;
begin
  r := FCellRect;
  if HorizontalLines then
    OffsetRect(r, 0, -1);
  InflateRect(r, 1, 0);
  AdjustBoundsRect(r);
  FEditor.BoundsRect := r;
end;

function TElTreeInplaceMaskEdit.GetEditor: TElMaskEdit;
begin
  Result := Feditor as TElMaskEdit;
end;

end.
