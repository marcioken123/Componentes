unit ElTreeAdvEdit;
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

ElTreeAdvEdit unit
------------------


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
  Graphics,
  SysUtils,
  Classes,
  ElStyleMan,

Types,

  LMDProcs,
  ElTree,
  ElHeader,

  ElEdits,
  ElTreeInplaceEditors,
  LMDVldBase
  ;

type

    TElTreeInplaceAdvancedEdit = class(TElTreeInplaceEditor)
    private
      SaveWndProc: TWndMethod;
      procedure EditorWndProc(var Message : TMessage);
      procedure SetCharCase(Value: TElEditCharCase);
      function GetCharCase: TElEditCharCase;
      procedure SetStressShortCut(Value: TShortCut);
      function GetStressShortCut: TShortCut;
    protected
      procedure AdjustBounds; override;
      function GetEditor: TElEdit;
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
      function GetValidationMsgString: string;
      function GetValidator: TLMDValidationEntity;
      procedure SetValidationMsgString(const Value: string);
      procedure SetValidator(const Value: TLMDValidationEntity);
      function GetOnValidationError: TLMDValidationErrorEvent;
      procedure SetOnValidationError(const Value: TLMDValidationErrorEvent);
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      property Editor: TEledit read GetEditor;
    published
      property Font;
      property StyleManager: TElStyleManager read GetStyleManager write
          SetStyleManager;
      property StyleName: string read GetStyleName write SetStyleName;
      property CharCase: TElEditCharCase read GetCharCase write SetCharCase stored True;
      property StressShortCut: TShortCut read GetStressShortCut write SetStressShortCut default 0;
      property ValidationMsgString : string read GetValidationMsgString write SetValidationMsgString;
      property Validator: TLMDValidationEntity read GetValidator write SetValidator;
      property OnValidationError: TLMDValidationErrorEvent read GetOnValidationError write SetOnValidationError;
    end;

implementation

constructor TElTreeInplaceAdvancedEdit.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := TElEdit.Create(nil);
  FEditor.Visible := false;
  Editor.HandleDialogKeys := true;
  Editor.AlignBottom := false;
  Editor.Ctl3D := false;
  Editor.AutoSelect := true;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := Self.EditorWndProc;
  FTypes := [sftText];
end;

destructor TElTreeInplaceAdvancedEdit.Destroy;
begin
  FEditor.WindowProc := SaveWndProc;
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElTreeInplaceAdvancedEdit.SetStressShortCut(Value: TShortCut);
begin
  Editor.StressShortCut := Value;
end;

function TElTreeInplaceAdvancedEdit.GetStressShortCut: TShortCut;
begin
  Result := Editor.StressShortCut;
end;

procedure TElTreeInplaceAdvancedEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElTreeInplaceAdvancedEdit.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

type THackElTree = class(TCustomElTree);

procedure TElTreeInplaceAdvancedEdit.EditorWndProc(var Message : TMessage);
var
  InputValid : boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    TriggerKeyDown(TWMKey(Message));
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        InputValid := true;
        FEditing := false;
        TriggerValidateResult(InputValid);
        FEditing := true;
        if InputValid then
        begin
          CompleteOperation(true);
          TWMKey(Message).CharCode := 0;
          exit;
        end
        else
          Editor.SetFocus;
        TWMKey(Message).CharCode := 0;
        end
      else
      if TWMKey(Message).CharCode = VK_ESCAPE then
      begin
        CompleteOperation(false);
        TWMKey(Message).CharCode := 0;
        exit;
      end;
    end;
  end
  else
  if (Message.Msg = WM_CANCELMODE) or
     ((Message.Msg = CM_CANCELMODE) and
      (TObject(Pointer(Message.lParam)) <> Editor)
      ) or (Message.Msg = WM_KILLFOCUS) then
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

function TElTreeInplaceAdvancedEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElTreeInplaceAdvancedEdit.TriggerAfterOperation(var Accepted :
    boolean; var DefaultConversion : boolean);
begin
  Editor.OnExit := nil;
  inherited;
  if DefaultConversion then
    ValueAsText := Editor.Text;
end;

procedure TElTreeInplaceAdvancedEdit.TriggerBeforeOperation(var
    DefaultConversion : boolean);
begin
  AdjustBounds;
  inherited;
  if DefaultConversion then
    Editor.Text := ValueAsText;
end;

procedure TElTreeInplaceAdvancedEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

function TElTreeInplaceAdvancedEdit.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

function TElTreeInplaceAdvancedEdit.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

procedure TElTreeInplaceAdvancedEdit.SetStyleManager(
  Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

procedure TElTreeInplaceAdvancedEdit.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;

function TElTreeInplaceAdvancedEdit.GetCharCase: TElEditCharCase;
begin
  Result := Editor.CharCase;
end;

procedure TElTreeInplaceAdvancedEdit.SetCharCase(Value: TElEditCharCase);
begin
  Editor.CharCase := Value;
end;

procedure TElTreeInplaceAdvancedEdit.AdjustBounds;
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

function TElTreeInplaceAdvancedEdit.GetEditor: TElEdit;
begin
  Result := FEditor as TElEdit;
end;

function TElTreeInplaceAdvancedEdit.GetValidationMsgString: string;
begin
  Result := GetEditor.ValidationMsgString;
end;

function TElTreeInplaceAdvancedEdit.GetValidator: TLMDValidationEntity;
begin
  Result := GetEditor.Validator;
end;

procedure TElTreeInplaceAdvancedEdit.SetValidationMsgString(const Value: string);
begin
  GetEditor.ValidationMsgString := value;
end;

procedure TElTreeInplaceAdvancedEdit.SetValidator(const Value: TLMDValidationEntity);
begin
  GetEditor.Validator := Value;
end;

function TElTreeInplaceAdvancedEdit.GetOnValidationError: TLMDValidationErrorEvent;
begin
  Result := GetEditor.OnValidationError;
end;

procedure TElTreeInplaceAdvancedEdit.SetOnValidationError(const Value: TLMDValidationErrorEvent);
begin
  GetEditor.OnValidationError := Value;
end;

end.
