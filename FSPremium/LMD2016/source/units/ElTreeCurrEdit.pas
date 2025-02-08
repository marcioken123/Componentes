unit ElTreeCurrEdit;
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

ElTreeCurrEdit unit
-------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

12 February, 2008 (EK)
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
  Types,

  LMDProcs,
  LMDTypes,
  LMDStrings,
  LMDVldBase,

  ElStyleMan,
  {$ifndef NO_CALC_IN_CURREDIT}
  ElCalc,
  {$endif}
  ElTree,
  ElHeader,
  ElCurrEdit,
  ElTreeInplaceEditors;

type
  THackInplaceCurrencyEdit = class(TElCurrencyEdit)
    procedure DoExit; override;
    procedure KeyDown(var Key : Word; ShiftState : TShiftState); override;
  end;
  TElTreeInplaceCurrencyEdit = class(TElTreeInplaceEditor)
  private
  {$ifndef NO_CALC_IN_CURREDIT}
    FCalcDlgButtonVisible: Boolean;
  {$endif}
    SaveIntWndProc : array[1..2] of TWndMethod;
    SaveWndProc: TWndMethod;
    function GetValidationMsgString: string;
    function GetValidator: TLMDValidationEntity;
    procedure SetValidationMsgString(const Value: string);
    procedure SetValidator(const Value: TLMDValidationEntity);
    function GetOnValidationError: TLMDValidationErrorEvent;
    procedure SetOnValidationError(const Value: TLMDValidationErrorEvent);
    procedure EditorWndProc(var Message : TMessage);
    procedure IntEditorWndProc2(var Message : TMessage);
    procedure IntEditorWndProc1(var Message : TMessage);
    procedure SetNegativeSignColor(Value: TColor);
    function GetNegativeSignColor: TColor;
    procedure SetSign(Value: Boolean);
    function GetSign: Boolean;
    procedure SetEnableSign(Value: Boolean);
    function GetEnableSign: Boolean;
    procedure SetNegativeValueTextColor(Value: TColor);
    function GetNegativeValueTextColor: TColor;
    procedure SetDecimalPlaces(Value: Byte);
    function GetDecimalPlaces: Byte;
    procedure SetUseSystemDecimalPlaces(Value: Boolean);
    function GetUseSystemDecimalPlaces: Boolean;
    procedure SetCurrencySymbol(Value: TLMDString);
    function GetCurrencySymbol: TLMDString ;
    procedure SetCurrencySymbolPosition(Value: TElCurrencySymbolPosition);
    function GetCurrencySymbolPosition: TElCurrencySymbolPosition;
    procedure SetUseSystemCurrencySymbol(Value: Boolean);
    function GetUseSystemCurrencySymbol: Boolean;
  protected
    FIgnoreKillFocus : boolean;
    procedure AdjustBounds; override;
    function GetEditor: TElCurrencyEdit;
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted : boolean); override;
    function GetVisible: Boolean; override;
    procedure TriggerAfterOperation(var Accepted : boolean; var DefaultConversion :
        boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion : boolean); override;
    procedure SetEditorParent; override;
    procedure RealWndProc(var Message : TMessage);
    function GetStyleManager: TElStyleManager;
    function GetStyleName: string;
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
    procedure OnCalcDlg(Sender : TObject);
    procedure OnCalcDlgClose(Sender : TObject);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property Editor: TElCurrencyEdit read GetEditor;
  published
    property StyleManager: TElStyleManager read GetStyleManager write
        SetStyleManager;
    property StyleName: string read GetStyleName write SetStyleName;
    property Font;
    property Sign: Boolean read GetSign write SetSign;
    property EnableSign: Boolean read GetEnableSign write SetEnableSign;
    property NegativeSignColor: TColor read GetNegativeSignColor write
      SetNegativeSignColor;
    property NegativeValueTextColor: TColor read GetNegativeValueTextColor write
      SetNegativeValueTextColor;
    property DecimalPlaces: Byte read GetDecimalPlaces write SetDecimalPlaces;
    property UseSystemDecimalPlaces: Boolean read GetUseSystemDecimalPlaces write
      SetUseSystemDecimalPlaces;
    property CurrencySymbol: TLMDString read GetCurrencySymbol write
    SetCurrencySymbol;
    property CurrencySymbolPosition: TElCurrencySymbolPosition read
      GetCurrencySymbolPosition write SetCurrencySymbolPosition;
    property UseSystemCurrencySymbol: Boolean read GetUseSystemCurrencySymbol write
      SetUseSystemCurrencySymbol;
  {$ifndef NO_CALC_IN_CURREDIT}
    property CalcDlgButtonVisible: Boolean read FCalcDlgButtonVisible write
      FCalcDlgButtonVisible stored True;
  {$endif}
    property ValidationMsgString : string read GetValidationMsgString write SetValidationMsgString;
    property Validator: TLMDValidationEntity read GetValidator write SetValidator;
    property OnValidationError: TLMDValidationErrorEvent read GetOnValidationError write SetOnValidationError;
  end;

implementation

type THackControl = class(TControl);

constructor TElTreeInplaceCurrencyEdit.Create(AOwner : TComponent);

begin
  inherited;
  FEditor := THackInplaceCurrencyEdit.Create(Self);
  FEditor.Visible := false;
  Editor.ParentCtl3D := false;
  Editor.Ctl3D := false;
  Editor.HandleDialogKeys := true;
  Editor.CalcDlgOnButtonClick := OnCalcDlg;
  Editor.CalcDlgOnClose := OnCalcDlgClose;
  Editor.BorderSides := [];
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  FTypes := [sftCurrency];

  SaveIntWndProc[1] := THackControl(THackInplaceCurrencyEdit(FEditor).FPartEditors[1]).WindowProc;
  SaveIntWndProc[2] := THackControl(THackInplaceCurrencyEdit(FEditor).FPartEditors[2]).WindowProc;
  THackControl(THackInplaceCurrencyEdit(FEditor).FPartEditors[1]).WindowProc := IntEditorWndProc1;
  THackControl(THackInplaceCurrencyEdit(FEditor).FPartEditors[2]).WindowProc := IntEditorWndProc2;

end;

destructor TElTreeInplaceCurrencyEdit.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElTreeInplaceCurrencyEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  {$ifndef NO_CALC_IN_CURREDIT}
  Editor.CalcDlgButtonVisible := FCalcDlgButtonVisible;
  FIgnoreKillFocus := FCalcDlgButtonVisible;
  {$endif}
  FEditor.SetFocus;
end;

procedure TElTreeInplaceCurrencyEdit.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  FIgnoreKillFocus := false;
  FEditor.Parent := nil;
  inherited;
end;

type THackElTree = class(TCustomElTree);

procedure TElTreeInplaceCurrencyEdit.EditorWndProc(var Message : TMessage);
begin
  RealWndProc(Message);
  SaveWndProc(Message);
end;

function TElTreeInplaceCurrencyEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElTreeInplaceCurrencyEdit.TriggerAfterOperation(var Accepted :
    boolean; var DefaultConversion : boolean);
begin
  Editor.OnExit := nil;
  inherited;
  if DefaultConversion then
    ValueAsText := CurrToStrF(Editor.Value, ffCurrency, {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}CurrencyDecimals);
end;

procedure TElTreeInplaceCurrencyEdit.TriggerBeforeOperation(var
    DefaultConversion : boolean);
begin
  AdjustBounds;
  inherited;
  if DefaultConversion then
    Editor.Value := LMDPrettyStrToCurr(ValueAsText);
end;

procedure TElTreeInplaceCurrencyEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElTreeInplaceCurrencyEdit.IntEditorWndProc2(var Message : TMessage);
begin
  RealWndProc(Message);
  SaveIntWndProc[2](Message);
end;

procedure TElTreeInplaceCurrencyEdit.RealWndProc(var Message : TMessage);
var InputValid : boolean;
    ACtl       : TWinControl;
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
      (((TControl(TObject(Pointer(Message.lParam))).Parent <> Editor) and
      (TObject(Pointer(Message.lParam)) <> Editor))))
      ) or
     ((Message.Msg = WM_KILLFOCUS) and (not FIgnoreKillFocus)) then
  begin
    if Message.Msg = WM_KILLFOCUS then
    begin
      ACtl := FindControl(TWMKillFocus(Message).FocusedWnd);
      if (ACtl <> nil) and (ACtl.Parent = Editor) then
      begin
        SaveWndProc(Message);
        exit;
      end;
    end;
    if FEditing then
    begin
      if THackElTree(Tree).ExplorerEditMode then
      begin
        EndEditWithInputChecked;
      end
      else
        CompleteOperation(false);
    end;
  end;
end;

procedure TElTreeInplaceCurrencyEdit.IntEditorWndProc1(var Message : TMessage);
begin
  RealWndProc(Message);
  SaveIntWndProc[1](Message);
end;

function TElTreeInplaceCurrencyEdit.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

function TElTreeInplaceCurrencyEdit.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

procedure TElTreeInplaceCurrencyEdit.SetStyleManager(Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

procedure TElTreeInplaceCurrencyEdit.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;

procedure TElTreeInplaceCurrencyEdit.OnCalcDlg(Sender : TObject);
begin
  FIgnoreKillFocus := true;
  Editor.ReadOnly := false;
end;

procedure TElTreeInplaceCurrencyEdit.OnCalcDlgClose(Sender : TObject);
begin
//  FIgnoreKillFocus := false;
end;

procedure THackInplaceCurrencyEdit.DoExit;
begin
  inherited;
  (*
  with TElTreeInplaceCurrencyEdit(Owner) do
    if FEditing then
      CompleteOperation(false);
  *)
end;

procedure THackInplaceCurrencyEdit.KeyDown;
begin
  inherited;
  (*
  with TElTreeInplaceCurrencyEdit(Owner) do
  if ShiftState = [] then
  begin
    if Key = VK_RETURN then
    begin
      InputValid := true;
      TriggerValidateResult(InputValid);
      if InputValid then
        CompleteOperation(true);
      Key := 0;
    end
    else
    if Key = VK_ESCAPE then
    begin
      CompleteOperation(false);
      Key := 0;
    end;
  end;
  *)
end;

function TElTreeInplaceCurrencyEdit.GetCurrencySymbol: TLMDString;
begin
  if Assigned(FEditor) then
    Result := Editor.CurrencySymbol
  else
    Result := '';
end;

function TElTreeInplaceCurrencyEdit.GetCurrencySymbolPosition: TElCurrencySymbolPosition;
begin
  if Assigned(FEditor) then
    Result := Editor.CurrencySymbolPosition
  else
    Result := ecsPosLeft;
end;

function TElTreeInplaceCurrencyEdit.GetDecimalPlaces: Byte;
begin
  if Assigned(FEditor) then
    Result := Editor.DecimalPlaces
  else
    Result := 0;
end;

function TElTreeInplaceCurrencyEdit.GetEnableSign: Boolean;
begin
  if Assigned(FEditor) then
    Result := Editor.EnableSign
  else
    Result := false;
end;

function TElTreeInplaceCurrencyEdit.GetNegativeSignColor: TColor;
begin
  if Assigned(FEditor) then
    Result := Editor.NegativeSignColor
  else
    Result := clNone;
end;

function TElTreeInplaceCurrencyEdit.GetNegativeValueTextColor: TColor;
begin
  if Assigned(FEditor) then
    Result := Editor.NegativeValueTextColor
  else
    Result := clNone;
end;

function TElTreeInplaceCurrencyEdit.GetSign: Boolean;
begin
  if Assigned(FEditor) then
    Result := Editor.Sign
  else
    Result := false;
end;

function TElTreeInplaceCurrencyEdit.GetUseSystemCurrencySymbol: Boolean;
begin
  if Assigned(FEditor) then
    Result := Editor.UseSystemCurrencySymbol
  else
    Result := false;
end;

function TElTreeInplaceCurrencyEdit.GetUseSystemDecimalPlaces: Boolean;
begin
  if Assigned(FEditor) then
    Result := Editor.UseSystemDecimalPlaces
  else
    Result := false;
end;

procedure TElTreeInplaceCurrencyEdit.SetCurrencySymbol(Value: TLMDString);
begin
  if Assigned(FEditor) then
    Editor.CurrencySymbol := Value;
end;

procedure TElTreeInplaceCurrencyEdit.SetCurrencySymbolPosition(
  Value: TElCurrencySymbolPosition);
begin
  if Assigned(FEditor) then
    Editor.CurrencySymbolPosition := Value;
end;

procedure TElTreeInplaceCurrencyEdit.SetDecimalPlaces(Value: Byte);
begin
  if Assigned(FEditor) then
    Editor.DecimalPlaces := Value;
end;

procedure TElTreeInplaceCurrencyEdit.SetEnableSign(Value: Boolean);
begin
  if Assigned(FEditor) then
    Editor.EnableSign := Value;
end;

procedure TElTreeInplaceCurrencyEdit.SetNegativeSignColor(Value: TColor);
begin
  if Assigned(FEditor) then
    Editor.NegativeSignColor := Value;
end;

procedure TElTreeInplaceCurrencyEdit.SetNegativeValueTextColor(
  Value: TColor);
begin
  if Assigned(FEditor) then
    Editor.NegativeValueTextColor := Value;
end;

procedure TElTreeInplaceCurrencyEdit.SetSign(Value: Boolean);
begin
  if Assigned(FEditor) then
    Editor.Sign := Value;
end;

procedure TElTreeInplaceCurrencyEdit.SetUseSystemCurrencySymbol(
  Value: Boolean);
begin
  if Assigned(FEditor) then
    Editor.UseSystemCurrencySymbol := Value;
end;

procedure TElTreeInplaceCurrencyEdit.SetUseSystemDecimalPlaces(
  Value: Boolean);
begin
  if Assigned(FEditor) then
    Editor.UseSystemDecimalPlaces := Value;
end;

procedure TElTreeInplaceCurrencyEdit.AdjustBounds;
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

function TElTreeInplaceCurrencyEdit.GetEditor: TElCurrencyEdit;
begin
  Result := FEditor as TElCurrencyEdit;
end;

function TElTreeInplaceCurrencyEdit.GetValidationMsgString: string;
begin
  Result := GetEditor.ValidationMsgString;
end;

function TElTreeInplaceCurrencyEdit.GetValidator: TLMDValidationEntity;
begin
  Result := GetEditor.Validator;
end;

procedure TElTreeInplaceCurrencyEdit.SetValidationMsgString(const Value: string);
begin
  GetEditor.ValidationMsgString := value;
end;

procedure TElTreeInplaceCurrencyEdit.SetValidator(const Value: TLMDValidationEntity);
begin
  GetEditor.Validator := Value;
end;

function TElTreeInplaceCurrencyEdit.GetOnValidationError: TLMDValidationErrorEvent;
begin
  Result := GetEditor.OnValidationError;
end;

procedure TElTreeInplaceCurrencyEdit.SetOnValidationError(const Value: TLMDValidationErrorEvent);
begin
  GetEditor.OnValidationError := Value;
end;

end.
