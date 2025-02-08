unit ElTreeMemoComboEdit;
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

ElTreememoComboEdit unit
------------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

 08 February, 2008 (EK)
 - Validation support added;

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
  Graphics,

  LMDProcs,
  LMDVldBase,

  ElTree,
  ElHeader,
  ElMemoCombo,
  ElTreeInplaceEditors;

type

    TElTreeInplaceMemoComboEdit = class(TElTreeInplaceEditor)
    private
      SaveWndProc: TWndMethod;
      SaveMemoWndProc: TWndMethod;
      procedure EditorWndProc(var Message : TMessage);
      procedure MemoWndProc(var Message : TMessage);
      function GetValidationMsgString: string;
      function GetValidator: TLMDValidationEntity;
      procedure SetValidationMsgString(const Value: string);
      procedure SetValidator(const Value: TLMDValidationEntity);
      function GetOnValidationError: TLMDValidationErrorEvent;
      procedure SetOnValidationError(const Value: TLMDValidationErrorEvent);
    protected
      procedure AdjustBounds; override;
      function GetEditor: TElMemoCombo;
      procedure DoStartOperation; override;
      procedure DoStopOperation(Accepted : boolean); override;
      function GetVisible: Boolean; override;
      procedure TriggerAfterOperation(var Accepted : boolean; var DefaultConversion :
          boolean); override;
      procedure TriggerBeforeOperation(var DefaultConversion : boolean); override;
      procedure SetEditorParent; override;
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      procedure TriggerValidateResult(var InputValid: boolean); override;
      property Editor: TElMemoCombo read GetEditor;
    published
      property Font;
      property ValidationMsgString : string read GetValidationMsgString write SetValidationMsgString;
      property Validator: TLMDValidationEntity read GetValidator write SetValidator;
      property OnValidationError: TLMDValidationErrorEvent read GetOnValidationError write SetOnValidationError;
    end;

implementation

constructor TElTreeInplaceMemoComboEdit.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := TElMemoCombo.Create(Self);
  FEditor.Visible := false;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := Self.EditorWndProc;
  SaveMemoWndProc := Editor.GetMemo.WindowProc;
  Editor.GetMemo.WindowProc := MemoWndProc;

  FTypes := [sftText, sftMemo];
end;

destructor TElTreeInplaceMemoComboEdit.Destroy;
begin
  Editor.GetMemo.WindowProc := SaveMemoWndProc;
  FEditor.WindowProc := SaveWndProc;
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElTreeInplaceMemoComboEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElTreeInplaceMemoComboEdit.DoStopOperation(Accepted : boolean);
begin
  Editor.Drop(false);
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

type THackElTree = class(TCustomElTree);

procedure TElTreeInplaceMemoComboEdit.MemoWndProc(var Message : TMessage);
var
  InputValid : boolean;
begin
  if (Message.Msg = WM_CANCELMODE) or
     (Message.Msg = CM_CANCELMODE) or
     (Message.Msg = WM_KILLFOCUS) then
    if FEditor.HandleAllocated and
       (TWMKillFocus(Message).FocusedWnd <> FEditor.Handle) then
       if FEditing then
    begin
      if THackElTree(Tree).ExplorerEditMode then
      begin
        InputValid := true;
        TriggerValidateResult(InputValid);
        CompleteOperation(InputValid);
      end
      else
        CompleteOperation(false);
    end;
  if Message.Msg = WM_KEYDOWN then
  begin
    TriggerKeyDown(TWMKey(Message));
    if TWMKey(Message).CharCode = VK_ESCAPE then
    begin
      CompleteOperation(false);
      TWMKey(Message).CharCode := 0;
      exit;
    end
    else
    with TWMKey(Message) do
    if CharCode = VK_RETURN then
    begin
      if KeyDataToShiftState(KeyData) = [] then
      begin
        InputValid := true;
        FEditing := false;
        TriggerValidateResult(InputValid);
        FEditing := true;
        if InputValid then
        begin
          Editor.Drop(false);
          CompleteOperation(true);
          CharCode := 0;
          exit;
        end
        else
          Editor.SetFocus;
        CharCode := 0;
      end
      else
      if KeyDataToShiftState(KeyData) = [ssCtrl] then
      begin
        //PostMessage(FEditor.GetMemo.Handle, WM_CHAR, TMessage(Message).wParam, TMessage(Message).lParam);
        CharCode := 0;
      end;
    end
  end;
  SaveMemoWndProc(Message);
end;

procedure TElTreeInplaceMemoComboEdit.EditorWndProc(var Message : TMessage);
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
        TriggerValidateResult(InputValid);
        if InputValid then
          CompleteOperation(true)
        else
          Editor.SetFocus;
        CharCode := 0;
        exit;
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
  if Message.Msg = WM_KILLFOCUS then
    if Editor.GetMemo.HandleAllocated and
       (TWMKillFocus(Message).FocusedWnd <> 0) and
       (TWMKillFocus(Message).FocusedWnd <> FEditor.Handle) and
       (TWMKillFocus(Message).FocusedWnd <> Editor.GetMemo.Handle) then
       if FEditing then
    begin
      if THackElTree(Tree).ExplorerEditMode then
      begin
        InputValid := true;
        TriggerValidateResult(InputValid);
        CompleteOperation(InputValid);
      end
      else
        CompleteOperation(false);
    end;
  SaveWndProc(Message);
end;

function TElTreeInplaceMemoComboEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElTreeInplaceMemoComboEdit.TriggerAfterOperation(var Accepted :
    boolean; var DefaultConversion : boolean);
begin
  Editor.OnExit := nil;
  inherited;
  if DefaultConversion then
    ValueAsText := Editor.Text;
end;

procedure TElTreeInplaceMemoComboEdit.TriggerBeforeOperation(var
    DefaultConversion : boolean);
begin
  AdjustBounds;
  inherited;
  if DefaultConversion then
    Editor.Text := ValueAsText;
end;

procedure TElTreeInplaceMemoComboEdit.TriggerValidateResult(
  var InputValid: boolean);
begin
  if Assigned(Validator) then
    InputValid := Validator.Validate(Editor, false) = 0;
  inherited TriggerValidateResult(InputValid);
end;

procedure TElTreeInplaceMemoComboEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElTreeInplaceMemoComboEdit.AdjustBounds;
var
  r: TRect;
begin
  r := FCellRect;
  if HorizontalLines then
    InflateRect(r, 0, 1);
  InflateRect(r, 1, 0);
  AdjustBoundsRect(r);
  FEditor.BoundsRect := r;
end;

function TElTreeInplaceMemoComboEdit.GetEditor: TElMemoCombo;
begin
  Result := FEditor as TElMemoCombo;
end;

function TElTreeInplaceMemoComboEdit.GetValidationMsgString: string;
begin
  Result := GetEditor.ValidationMsgString;
end;

function TElTreeInplaceMemoComboEdit.GetValidator: TLMDValidationEntity;
begin
  Result := GetEditor.Validator;
end;

procedure TElTreeInplaceMemoComboEdit.SetValidationMsgString(const Value: string);
begin
  GetEditor.ValidationMsgString := value;
end;

procedure TElTreeInplaceMemoComboEdit.SetValidator(const Value: TLMDValidationEntity);
begin
  GetEditor.Validator := Value;
end;

function TElTreeInplaceMemoComboEdit.GetOnValidationError: TLMDValidationErrorEvent;
begin
  Result := GetEditor.OnValidationError;
end;

procedure TElTreeInplaceMemoComboEdit.SetOnValidationError(const Value: TLMDValidationErrorEvent);
begin
  GetEditor.OnValidationError := Value;
end;

end.
