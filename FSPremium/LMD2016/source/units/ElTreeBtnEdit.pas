unit ElTreeBtnEdit;
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

ElTreeBtnEdit unit
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

  SysUtils,
  Classes,
  Types,
  Graphics,
  ElStyleMan,

  ElTree,
  ElHeader,
  ElBtnEdit,
  ElTreeInplaceEditors,
  LMDVldBase;

type

    TElTreeInplaceButtonEdit = class(TElTreeInplaceEditor)
    private
      SaveWndProc: TWndMethod;
      procedure EditorWndProc(var Message : TMessage);
      procedure SetStressShortCut(Value: TShortCut);
      function GetStressShortCut: TShortCut;
      function GetValidationMsgString: string;
      function GetValidator: TLMDValidationEntity;
      procedure SetValidationMsgString(const Value: string);
      procedure SetValidator(const Value: TLMDValidationEntity);
      function GetOnValidationError: TLMDValidationErrorEvent;
      procedure SetOnValidationError(const Value: TLMDValidationErrorEvent);
    protected
      FIgnoreKillFocus : boolean;
      FOnButtonClick: TNotifyEvent;
      FOnAltButtonClick: TNotifyEvent;
      procedure AdjustBounds; override;
      function GetEditor: TElButtonEdit;
      function GetVisible: Boolean; override;
      procedure TriggerAfterOperation(var Accepted : boolean; var DefaultConversion :
          boolean); override;
      procedure TriggerBeforeOperation(var DefaultConversion : boolean); override;
      procedure DoStartOperation; override;
      procedure DoStopOperation(Accepted : boolean); override;
      procedure SetEditorParent; override;
      procedure ButtonClickTransfer(Sender : TObject); virtual;
      procedure AltButtonClickTransfer(Sender : TObject); virtual;
      function GetStyleManager: TElStyleManager;
      function GetStyleName: string;
      procedure SetStyleManager(Value: TElStyleManager);
      procedure SetStyleName(const Value: string);
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      property Editor: TElButtonEdit read GetEditor;
    published
      property StyleManager: TElStyleManager read GetStyleManager write
          SetStyleManager;
      property StyleName: string read GetStyleName write SetStyleName;
      property OnButtonClick: TNotifyEvent read FOnButtonClick write FOnButtonClick;
      property OnAltButtonClick: TNotifyEvent read FOnAltButtonClick write
          FOnAltButtonClick;
      property StressShortCut: TShortCut read GetStressShortCut write SetStressShortCut default 0;
      property ValidationMsgString : string read GetValidationMsgString write SetValidationMsgString;
      property Validator: TLMDValidationEntity read GetValidator write SetValidator;
      property OnValidationError: TLMDValidationErrorEvent read GetOnValidationError write SetOnValidationError;
      property Font;
    end;

implementation

uses
  LMDProcs;

type
  THackElTree = class(TCustomElTree);
  //THackAElTree = class(TElTreeAncestor);
  THackButtonEdit = class(TElButtonEdit);

function TElTreeInplaceButtonEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElTreeInplaceButtonEdit.TriggerAfterOperation(var Accepted : boolean;
    var DefaultConversion : boolean);
begin
  Editor.OnExit := nil;
  inherited;
  if DefaultConversion then
    ValueAsText := Editor.Text;
end;

procedure TElTreeInplaceButtonEdit.TriggerBeforeOperation(var DefaultConversion
    : boolean);
begin
  AdjustBounds;
  Editor.Multiline := DataType = sftMemo;
  inherited;
  if DefaultConversion then
    Editor.Text := ValueAsText;
end;

constructor TElTreeInplaceButtonEdit.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := TElButtonEdit.Create(Self);
  FEditor.Visible := false;
  Editor.ParentCtl3D := false;
  Editor.Ctl3D := false;
  Editor.AutoSelect := true;
  Editor.AutoSize := false;
  Editor.HandleDialogKeys := true;
  Editor.Multiline := false;
  Editor.Flat := True;
  Editor.BorderSides := [];
  Editor.OnButtonClick := ButtonClickTransfer;
  Editor.OnAltButtonClick := AltButtonClickTransfer;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  FTypes := [sftText, sftMemo];
end;

destructor TElTreeInplaceButtonEdit.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElTreeInplaceButtonEdit.SetStressShortCut(Value: TShortCut);
begin
  Editor.StressShortCut := Value;
end;

function TElTreeInplaceButtonEdit.GetStressShortCut: TShortCut;
begin
  Result := Editor.StressShortCut;
end;

procedure TElTreeInplaceButtonEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElTreeInplaceButtonEdit.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElTreeInplaceButtonEdit.EditorWndProc(var Message : TMessage);
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
      ((Message.lParam = 0) or
      ((TControl(TObject(Pointer(Message.lParam))).Parent <> Editor) and
      (TObject(Pointer(Message.lParam)) <> Editor)))
      ) or
     ((Message.Msg = WM_KILLFOCUS) and (not FIgnoreKillFocus)) then
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

procedure TElTreeInplaceButtonEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElTreeInplaceButtonEdit.ButtonClickTransfer(Sender : TObject);
begin
  FIgnoreKillFocus := true;
  try
    if assigned(FOnButtonClick) then FOnButtonClick(Self);
  finally
    FIgnoreKillFocus := false;
  end;
end;

procedure TElTreeInplaceButtonEdit.AltButtonClickTransfer(Sender : TObject);
begin
  FIgnoreKillFocus := true;
  try
    if Assigned(FOnAltButtonClick) then FOnAltButtonClick(Self);
  finally
    FIgnoreKillFocus := false;
  end;
end;

function TElTreeInplaceButtonEdit.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

function TElTreeInplaceButtonEdit.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

procedure TElTreeInplaceButtonEdit.SetStyleManager(Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

procedure TElTreeInplaceButtonEdit.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;

procedure TElTreeInplaceButtonEdit.AdjustBounds;
var
  r: TRect;
begin
  r := FCellRect;
  if HorizontalLines then
    InflateRect(r, 0, 1);
  if VerticalLines then
    begin
      InflateRect(r, 1, 0);
      if not IsVistaUp then
        OffsetRect(r, -1, 0);
    end
  else
    begin
      Inc(R.Right);
      if IsVistaUp then
        OffsetRect(r, 1, 0);
    end;
  FEditor.BoundsRect := R;
end;

function TElTreeInplaceButtonEdit.GetEditor: TElButtonEdit;
begin
  Result := FEditor as TElButtonEdit;
end;

function TElTreeInplaceButtonEdit.GetValidationMsgString: string;
begin
  Result := GetEditor.ValidationMsgString;
end;

function TElTreeInplaceButtonEdit.GetValidator: TLMDValidationEntity;
begin
  Result := GetEditor.Validator;
end;

procedure TElTreeInplaceButtonEdit.SetValidationMsgString(const Value: string);
begin
  GetEditor.ValidationMsgString := value;
end;

procedure TElTreeInplaceButtonEdit.SetValidator(const Value: TLMDValidationEntity);
begin
  GetEditor.Validator := Value;
end;

function TElTreeInplaceButtonEdit.GetOnValidationError: TLMDValidationErrorEvent;
begin
  Result := GetEditor.OnValidationError;
end;

procedure TElTreeInplaceButtonEdit.SetOnValidationError(const Value: TLMDValidationErrorEvent);
begin
  GetEditor.OnValidationError := Value;
end;

end.
