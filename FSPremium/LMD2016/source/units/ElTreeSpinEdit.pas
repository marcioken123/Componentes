unit ElTreeSpinEdit;
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

ElTreeSpinEdit unit
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
  Types,

  LMDProcs,
  LMDVldBase,

  ElStyleMan,
  ElTree,
  ElHeader,
  ElSpin,
  ElTreeInplaceEditors;

type

    TElTreeInplaceSpinEdit = class(TElTreeInplaceEditor)
    private
      SaveWndProc: TWndMethod;
      procedure EditorWndProc(var Message : TMessage);
      procedure SetMaxValue(Value: Integer);
      function GetMaxValue: Integer;
      procedure SetMinValue(Value: Integer);
      function GetMinValue: Integer;
      function GetValidationMsgString: string;
      function GetValidator: TLMDValidationEntity;
      procedure SetValidationMsgString(const Value: string);
      procedure SetValidator(const Value: TLMDValidationEntity);
      function GetOnValidationError: TLMDValidationErrorEvent;
      procedure SetOnValidationError(const Value: TLMDValidationErrorEvent);
   protected
      procedure AdjustBounds; override;
      function GetEditor: TElSpinEdit;
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
      procedure TriggerValidateResult(var InputValid: boolean); override;

      property Editor: TElSpinEdit read GetEditor;
    published
      property StyleManager: TElStyleManager read GetStyleManager write
          SetStyleManager;
      property StyleName: string read GetStyleName write SetStyleName;
      property MaxValue: Integer read GetMaxValue write SetMaxValue;
      property MinValue: Integer read GetMinValue write SetMinValue;
      property Font;
      property ValidationMsgString : string read GetValidationMsgString write SetValidationMsgString;
      property Validator: TLMDValidationEntity read GetValidator write SetValidator;
      property OnValidationError: TLMDValidationErrorEvent read GetOnValidationError write SetOnValidationError;
    end;

    TElTreeInplaceFloatSpinEdit = class(TElTreeInplaceEditor)
    private
      SaveWndProc: TWndMethod;
      procedure EditorWndProc(var Message : TMessage);
      procedure SetMaxValue(Value: Double);
      function GetMaxValue: Double;
      procedure SetMinValue(Value: Double);
      function GetMinValue: Double;
      procedure SetDigits(Value: Integer);
      function GetDigits: Integer;
      function GetValidationMsgString: string;
      function GetValidator: TLMDValidationEntity;
      procedure SetValidationMsgString(const Value: string);
      procedure SetValidator(const Value: TLMDValidationEntity);
      function GetOnValidationError: TLMDValidationErrorEvent;
      procedure SetOnValidationError(const Value: TLMDValidationErrorEvent);
    protected
      procedure AdjustBounds; override;
      function GetEditor: TElFloatSpinEdit;
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
      procedure TriggerValidateResult(var InputValid: boolean); override;

      property Editor: TElFloatSpinEdit read GetEditor;
    published
      property StyleManager: TElStyleManager read GetStyleManager write
          SetStyleManager;
      property StyleName: string read GetStyleName write SetStyleName;
      property MaxValue: Double read GetMaxValue write SetMaxValue;
      property MinValue: Double read GetMinValue write SetMinValue;
      property Digits: Integer read GetDigits write SetDigits;
      property Font: TFont read FFont write SetFont stored True;
      property ValidationMsgString : string read GetValidationMsgString write SetValidationMsgString;
      property Validator: TLMDValidationEntity read GetValidator write SetValidator;
      property OnValidationError: TLMDValidationErrorEvent read GetOnValidationError write SetOnValidationError;
    end;

implementation

type
  THackSpin = class(TElSpinEdit);
  THackFloatSpin = class(TElFloatSpinEdit);
  THackElTree = class(TElTree);

constructor TElTreeInplaceSpinEdit.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := TElSpinEdit.Create(Self);
  FEditor.Visible := false;
  Editor.ParentCtl3D := false;
  Editor.Ctl3D := false;
  Editor.AutoSelect := true;
  Editor.HandleDialogKeys := true;
  DefaultValueAsText := '0';
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  FTypes := [sftNumber];
  THackSpin(Editor).FButton.TabStop := False;
  end;

destructor TElTreeInplaceSpinEdit.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElTreeInplaceSpinEdit.DoStartOperation;
begin
  FEditor.Parent := FTree.View;
  FEditor.Visible := true;
  FEditor.SetFocus;
  THackSpin(FEditor).FButton.Invalidate;
  end;

procedure TElTreeInplaceSpinEdit.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElTreeInplaceSpinEdit.EditorWndProc(var Message : TMessage);
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
    if (Message.Msg = WM_CANCELMODE) or
     ((Message.Msg = CM_CANCELMODE) and
      ((Message.lParam = 0) and
      //vAd:+
      (
        (Message.lParam=0)
        or
        ( (TControl(TObject(Pointer(Message.lParam))).Parent <> Editor) and
          (TObject(Pointer(Message.lParam)) <> Editor))
        )
      )
      //Vad:+.
     ) or
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

function TElTreeInplaceSpinEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElTreeInplaceSpinEdit.TriggerAfterOperation(var Accepted : boolean;
    var DefaultConversion : boolean);
begin
  Editor.OnExit := nil;
  inherited;
  if DefaultConversion then
    ValueAsText := IntToStr(Editor.Value);
end;

procedure TElTreeInplaceSpinEdit.TriggerBeforeOperation(var DefaultConversion :
    boolean);
begin
  AdjustBounds;
  inherited;
  if DefaultConversion then
    Editor.Value := StrToIntDef(ValueAsText, 0);
end;

procedure TElTreeInplaceSpinEdit.TriggerValidateResult(var InputValid: boolean);
begin
  if Assigned(Validator) then
    InputValid := Validator.Validate(Editor, false) = 0;
  inherited TriggerValidateResult(InputValid);
end;

function TElTreeInplaceSpinEdit.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

function TElTreeInplaceSpinEdit.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

procedure TElTreeInplaceSpinEdit.SetStyleManager(Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

procedure TElTreeInplaceSpinEdit.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;

function TElTreeInplaceSpinEdit.GetValidationMsgString: string;
begin
  Result := GetEditor.ValidationMsgString;
end;

function TElTreeInplaceSpinEdit.GetValidator: TLMDValidationEntity;
begin
  Result := GetEditor.Validator;
end;

procedure TElTreeInplaceSpinEdit.SetValidationMsgString(const Value: string);
begin
  GetEditor.ValidationMsgString := value;
end;

procedure TElTreeInplaceSpinEdit.SetValidator(const Value: TLMDValidationEntity);
begin
  GetEditor.Validator := Value;
end;

function TElTreeInplaceSpinEdit.GetOnValidationError: TLMDValidationErrorEvent;
begin
  Result := GetEditor.OnValidationError;
end;

procedure TElTreeInplaceSpinEdit.SetOnValidationError(const Value: TLMDValidationErrorEvent);
begin
  GetEditor.OnValidationError := Value;
end;

constructor TElTreeInplaceFloatSpinEdit.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := TElFloatSpinEdit.Create(Self);
  FEditor.Visible := false;
  Editor.ParentCtl3D := false;
  Editor.Ctl3D := false;
  Editor.AutoSelect := true;
  Editor.HandleDialogKeys := true;
  DefaultValueAsText := '0';
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  FTypes := [sftFloating];
  THackFloatSpin(Editor).FButton.TabStop := False;
  end;

destructor TElTreeInplaceFloatSpinEdit.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElTreeInplaceFloatSpinEdit.DoStartOperation;
begin
  FEditor.Parent := FTree.View;
  FEditor.Visible := true;
  FEditor.SetFocus;
  THackFloatSpin(FEditor).FButton.Invalidate;
  end;

procedure TElTreeInplaceFloatSpinEdit.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

type THackFloatSpinEdit = class(TElFloatSpinEdit);

procedure TElTreeInplaceFloatSpinEdit.EditorWndProc(var Message : TMessage);
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
      ((Message.lParam = 0) or
      (((TControl(TObject(Pointer(Message.lParam))).Parent <> Editor) and
      (TObject(Pointer(Message.lParam)) <> Editor))))
      ) or
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

function TElTreeInplaceFloatSpinEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElTreeInplaceFloatSpinEdit.TriggerAfterOperation(var Accepted :
    boolean; var DefaultConversion : boolean);
begin
  Editor.OnExit := nil;
  inherited;
  if DefaultConversion then
    ValueAsText := FloatToStr(Editor.Value);
end;

procedure TElTreeInplaceFloatSpinEdit.TriggerBeforeOperation(var
    DefaultConversion : boolean);
begin
  AdjustBounds;
  inherited;
  if DefaultConversion then
  try
    Editor.Value := StrToFloat(ValueAsText);
  except
    Editor.Value := Editor.MinValue;
  end;
end;

procedure TElTreeInplaceFloatSpinEdit.TriggerValidateResult(var InputValid: boolean);
begin
  if Assigned(Validator) then
    InputValid := Validator.Validate(Editor, false) = 0;
  inherited TriggerValidateResult(InputValid);
end;

function TElTreeInplaceFloatSpinEdit.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

function TElTreeInplaceFloatSpinEdit.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

procedure TElTreeInplaceFloatSpinEdit.SetStyleManager(Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

procedure TElTreeInplaceFloatSpinEdit.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;

function TElTreeInplaceSpinEdit.GetMaxValue: Integer;
begin
  Result := Editor.MaxValue;
end;

function TElTreeInplaceSpinEdit.GetMinValue: Integer;
begin
  Result := Editor.MinValue;
end;

procedure TElTreeInplaceSpinEdit.SetMaxValue(Value: Integer);
begin
  Editor.MaxValue := value;
end;

procedure TElTreeInplaceSpinEdit.SetMinValue(Value: Integer);
begin
  Editor.MinValue := value;
end;

function TElTreeInplaceFloatSpinEdit.GetMaxValue: Double;
begin
  Result := Editor.MaxValue;
end;

function TElTreeInplaceFloatSpinEdit.GetMinValue: Double;
begin
  Result := Editor.MinValue;
end;

procedure TElTreeInplaceFloatSpinEdit.SetMaxValue(Value: Double);
begin
  Editor.MaxValue := value;
end;

procedure TElTreeInplaceFloatSpinEdit.SetMinValue(Value: Double);
begin
  Editor.MinValue := value;
end;

function TElTreeInplaceFloatSpinEdit.GetDigits: Integer;
begin
  Result := Editor.Digits;
end;

procedure TElTreeInplaceFloatSpinEdit.SetDigits(Value: Integer);
begin
  Editor.Digits := value;
end;

procedure TElTreeInplaceFloatSpinEdit.AdjustBounds;
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

function TElTreeInplaceFloatSpinEdit.GetEditor: TElFloatSpinEdit;
begin
  Result := FEditor as TElFloatSpinEdit;
end;

procedure TElTreeInplaceSpinEdit.AdjustBounds;
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

function TElTreeInplaceSpinEdit.GetEditor: TElSpinEdit;
begin
  Result := FEditor as TElSpinEdit;
end;

function TElTreeInplaceFloatSpinEdit.GetValidationMsgString: string;
begin
  Result := GetEditor.ValidationMsgString;
end;

function TElTreeInplaceFloatSpinEdit.GetValidator: TLMDValidationEntity;
begin
  Result := GetEditor.Validator;
end;

procedure TElTreeInplaceFloatSpinEdit.SetValidationMsgString(const Value: string);
begin
  GetEditor.ValidationMsgString := value;
end;

procedure TElTreeInplaceFloatSpinEdit.SetValidator(const Value: TLMDValidationEntity);
begin
  GetEditor.Validator := Value;
end;

function TElTreeInplaceFloatSpinEdit.GetOnValidationError: TLMDValidationErrorEvent;
begin
  Result := GetEditor.OnValidationError;
end;

procedure TElTreeInplaceFloatSpinEdit.SetOnValidationError(const Value: TLMDValidationErrorEvent);
begin
  GetEditor.OnValidationError := Value;
end;

end.
