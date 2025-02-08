unit ElTreeComboBox;
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

ElTreeComboBox unit
-------------------


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
  StdCtrls,
  Types,
  HtmlLbx,

  ElStyleMan,
  ElTree,
  ElCombos,
  ElTreeInplaceEditors,
  ElHeader,

  LMDProcs,
  {$IFDEF LMD_UNICODE}
  LMDUnicodeStrings,
  {$endif}
  LMDVldBase;

type
    THackTrCombo = class (TCustomElComboBox);
    THackInplaceComboBox = class(TElHTMLComboBox)
    protected
      procedure ComboWndProc(var Message: TMessage; ComboWnd: THandle; ComboProc:Pointer); override;
    end;

    TElTreeInplaceComboBox = class(TElTreeInplaceEditor)
    private
      SaveWndProc: TWndMethod;
      procedure EditorWndProc(var Message : TMessage);
      {$IFDEF LMD_UNICODE}
      function GetItems: TLMDWideStrings;
      procedure SetItems(Value: TLMDWideStrings);
      {$ELSE}
      function GetItems: TStrings;
      procedure SetItems(Value: TStrings);
      {$ENDIF}
      procedure SetShowGripper(Value: Boolean);
      function GetShowGripper: Boolean;
      function GetIsHTML: Boolean;
      procedure SetIsHTML(const Value: Boolean);
      procedure SetStressShortCut(Value: TShortCut);
      function GetStressShortCut: TShortCut;
      function GetValidationMsgString: string;
      function GetValidator: TLMDValidationEntity;
      procedure SetValidationMsgString(const Value: string);
      procedure SetValidator(const Value: TLMDValidationEntity);
      function GetOnValidationError: TLMDValidationErrorEvent;
      procedure SetOnValidationError(const Value: TLMDValidationErrorEvent);
    protected
      FInitiallyDropped : boolean;
      procedure AdjustBounds; override;
      function GetEditor: TElHTMLComboBox;
      procedure SetEditorParent; override;
      procedure DoStartOperation; override;
      procedure DoStopOperation(Accepted : boolean); override;
      function GetVisible: Boolean; override;
      procedure TriggerAfterOperation(var Accepted : boolean; var DefaultConversion :
          boolean); override;
      procedure TriggerBeforeOperation(var DefaultConversion : boolean); override;
      function GetStyleManager: TElStyleManager;
      function GetStyleName: string;
      procedure SetStyleManager(Value: TElStyleManager);
      procedure SetStyleName(const Value: string);
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      property Editor: TElHTMLComboBox read GetEditor;
    published
      property StyleManager: TElStyleManager read GetStyleManager write
          SetStyleManager;
      property StyleName: string read GetStyleName write SetStyleName;
      property InitiallyDropped : boolean read FInitiallyDropped write FInitiallyDropped;
      {$IFDEF LMD_UNICODE}
      property Items: TLMDWideStrings read GetItems write SetItems stored True;
      {$ELSE}
      property Items: TStrings read GetItems write SetItems stored True;
      {$ENDIF}
      property Font;
      property ShowGripper: Boolean read GetShowGripper write SetShowGripper default false;
      property IsHTML: Boolean read GetIsHTML write SetIsHTML default true;
      property StressShortCut: TShortCut read GetStressShortCut write SetStressShortCut default 0;
      property ValidationMsgString : string read GetValidationMsgString write SetValidationMsgString;
      property Validator: TLMDValidationEntity read GetValidator write SetValidator;
      property OnValidationError: TLMDValidationErrorEvent read GetOnValidationError write SetOnValidationError;
    end;

implementation

constructor TElTreeInplaceComboBox.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := THackInplaceComboBox.Create(Self);
  FEditor.Visible := false;
  Editor.ParentCtl3D := false;
  Editor.Ctl3D := false;
  Editor.HandleDialogKeys := true;

  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  //FEditor.ListWindowProc := ListWndProc;
  //FEditor.EditWindowProc := EditWndProc;
  FTypes := [sftEnum];
end;

destructor TElTreeInplaceComboBox.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElTreeInplaceComboBox.SetStressShortCut(Value: TShortCut);
begin
  Editor.StressShortCut := Value;
end;

function TElTreeInplaceComboBox.GetStressShortCut: TShortCut;
begin
  Result := Editor.StressShortCut;
end;

procedure TElTreeInplaceComboBox.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElTreeInplaceComboBox.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
  Editor.DroppedDown := InitiallyDropped;
  if Editor.Style = csDropDownList then
    HideCaret(Editor.Handle);
end;

procedure TElTreeInplaceComboBox.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

type THackElTree = class(TCustomElTree);

procedure TElTreeInplaceComboBox.EditorWndProc(var Message : TMessage);
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
        if Editor.DroppedDown then
          THackInplaceComboBox(FEditor).CloseUp(true);
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
      end
      else
        if (Editor.Style = csDropDownList) and not (CharCode in [VK_Down, VK_Up, VK_NEXT, VK_PRIOR]) then
        begin
          CharCode := 0;
          exit;
        end;
    end;
  end
  else
  if (Message.Msg = WM_CANCELMODE) or
     ((Message.Msg = CM_CANCELMODE) and
      ((Message.lParam = 0) or
      ((TControl(TObject(Pointer(Message.lParam))).Parent <> Editor)) and
      (TObject(Pointer(Message.lParam)) <> Editor))) or
      (Message.Msg = WM_KILLFOCUS) then
  begin
    if FEditing and (not THackTrCombo(FEditor).FIgnoreFocus) then
    PostMessage(Editor.Handle, TM_CLOSEINPLACEEDITOR, 0, 0);
  end
  else
  if (Message.Msg = TM_CLOSEINPLACEEDITOR) then
    if THackElTree(Tree).ExplorerEditMode then
    begin
      EndEditWithInputChecked;
    end
    else
      CompleteOperation(false);

  SaveWndProc(Message);
end;

function TElTreeInplaceComboBox.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElTreeInplaceComboBox.TriggerAfterOperation(var Accepted : boolean;
    var DefaultConversion : boolean);
begin
  Editor.OnExit := nil;
  inherited;
  if DefaultConversion then
    ValueAsText := Editor.Text;
end;

procedure TElTreeInplaceComboBox.TriggerBeforeOperation(var DefaultConversion :
    boolean);
begin
  Editor.AutoSize := False;
  AdjustBounds;
  inherited;
  if DefaultConversion then
    Editor.Text := ValueAsText;
end;

function TElTreeInplaceComboBox.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

function TElTreeInplaceComboBox.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

procedure TElTreeInplaceComboBox.SetStyleManager(Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

procedure TElTreeInplaceComboBox.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;

procedure THackInplaceComboBox.ComboWndProc(var Message: TMessage; ComboWnd: THandle; ComboProc: Pointer);
var
  InputValid : boolean;
begin
  with TElTreeInplaceComboBox(Owner) do
  begin
    if Message.Msg = WM_KEYDOWN then
    begin
      with TWMKey(Message) do
      if KeyDataToShiftState(KeyData) = [] then
      begin
        if CharCode = VK_RETURN then
        begin
          InputValid := true;
          TriggerValidateResult(InputValid);
          if InputValid then
          begin
            CompleteOperation(true);
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
    if (Message.Msg = WM_KILLFOCUS) then
    begin
      if FEditing and (not THackTrCombo(FEditor).FIgnoreFocus) then
      PostMessage(Editor.Handle, TM_CLOSEINPLACEEDITOR, 0, 0);
    end
    else
    if (Message.Msg = TM_CLOSEINPLACEEDITOR) then
      if THackElTree(Tree).ExplorerEditMode then
      begin
        EndEditWithInputChecked;
      end
      else
        CompleteOperation(false);
  end;
  inherited;
end;

{$IFDEF LMD_UNICODE}
function TElTreeInplaceComboBox.GetItems: TLMDWideStrings;
begin
  if Assigned(FEditor) then
    Result := Editor.Items
  else
    Result := nil;
end;

procedure TElTreeInplaceComboBox.SetItems(Value: TLMDWideStrings);
begin
  if Assigned(FEditor) then
  begin
    Editor.Items.Assign(Value);
  end;
end;
{$else}
function TElTreeInplaceComboBox.GetItems: TStrings;
begin
  if Assigned(FEditor) then
    Result := Editor.Items
  else
    Result := nil;
end;

procedure TElTreeInplaceComboBox.SetItems(Value: TStrings);
begin
  if Assigned(FEditor) then
  begin
    Editor.Items.Assign(Value);
  end;
end;
{$endif}

function TElTreeInplaceComboBox.GetShowGripper: Boolean;
begin
  Result := Editor.ShowGripper;
end;

procedure TElTreeInplaceComboBox.SetShowGripper(Value: Boolean);
begin
  Editor.ShowGripper := Value;
end;

procedure TElTreeInplaceComboBox.AdjustBounds;
var
  r: TRect;
begin
  Editor.AutoSize := False;
  r := FCellRect;
  InflateRect(r, 1, 1);
  AdjustBoundsRect(r);
  FEditor.BoundsRect := r;
end;

function TElTreeInplaceComboBox.GetEditor: TElHTMLComboBox;
begin
  Result := FEditor as TElHTMLComboBox;
end;

function TElTreeInplaceComboBox.GetIsHTML: Boolean;
begin
  Result := Editor.IsHTML;
end;

procedure TElTreeInplaceComboBox.SetIsHTML(const Value: Boolean);
begin
  Editor.IsHTML := value;
end;

function TElTreeInplaceComboBox.GetValidationMsgString: string;
begin
  Result := GetEditor.ValidationMsgString;
end;

function TElTreeInplaceComboBox.GetValidator: TLMDValidationEntity;
begin
  Result := GetEditor.Validator;
end;

procedure TElTreeInplaceComboBox.SetValidationMsgString(const Value: string);
begin
  GetEditor.ValidationMsgString := value;
end;

procedure TElTreeInplaceComboBox.SetValidator(const Value: TLMDValidationEntity);
begin
  GetEditor.Validator := Value;
end;

function TElTreeInplaceComboBox.GetOnValidationError: TLMDValidationErrorEvent;
begin
  Result := GetEditor.OnValidationError;
end;

procedure TElTreeInplaceComboBox.SetOnValidationError(const Value: TLMDValidationErrorEvent);
begin
  GetEditor.OnValidationError := Value;
end;

end.
