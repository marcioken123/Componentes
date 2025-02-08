unit LMDCustomExtSpinEdit;
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

LMDCustomExtSpinEdit unit (JH)
------------------------------

Extended SpinEdit control

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LMDTypes, LMDCustomMaskEdit, LMDSpinButton;

type
  TLMDOnValueChangingEvent = procedure(Sender : TObject; var Val: double; var CanModify: boolean) of object;
  TLMDOnValueChangedEvent = procedure(Sender : TObject; OldVal, NewVal: double) of object;

type
  TLMDCustomExtSpinEdit = class(TLMDCustomMaskEdit)
  private
    FAutoDisableButtons: boolean;

    FSpinBtn      : TLMDSpinButton;
    FSpinBtnWidth : Integer;
    FInfiniteMax,
    FInfiniteMin,
    FEditorEnabled: Boolean;
    FType         : TLMDNumberType;
    FValue,
    FFractionStep,
    FLargeStep,
    FStep         : Double;
    FOnUpClick: TNotifyEvent;
    FOnDownClick: TNotifyEvent;

    FOnValueChanged: TLMDOnValueChangedEvent;
    FOnValueChanging: TLMDOnValueChangingEvent;

    FCheckOnExitOnly,
    FCheckBounds: boolean;

    procedure SetInteger (index, aValue : Integer);
    procedure SetType (aValue : TLMDNumberType);
    procedure SetDouble (index : Integer; aValue : Double);
    procedure SetColor(Index:Integer; const Value: TColor);
    procedure SetDiag(const Value: Boolean);
    procedure SetInterval(const Value: Word);
    function GetColor(Index:Integer): TColor;
    function GetInterval: Word;
    function GetDiag: Boolean;
    function IsNoDefault:Boolean;
    function IsNoFractionDefault:Boolean;
    function IsNoLargeDefault:Boolean;
    procedure CMEnabledChanged (var Message : TMessage); message CM_ENABLEDCHANGED;
    procedure WMKILLFOCUS (var Message : TWMKillFocus); message WM_KILLFOCUS;
    procedure SetAutoDisableButtons(const Value: boolean);
    procedure SetCheckOnExitOnly(const Value: boolean);
    function GetSpinBtnVisible: Boolean;
    procedure SetSpinBtnVisible(const Value: Boolean);
  protected
    procedure Loaded; override;
    procedure DoInc(Sender : TObject);virtual;
    procedure DoDec(Sender : TObject);virtual;
    procedure DoValueChanging(Sender : TObject; var Val: double; var CanModify: boolean); virtual;
    procedure DoValueChanged(Sender : TObject; OldVal, NewVal: double); virtual;

    procedure  Increment (by : Double);
    procedure  Decrement (by : Double);
    procedure GetCommandKey (var KeyCode : Word; Shift : TShiftState); override;
    procedure ChangedText (At : Integer); override;
    procedure GetChange (Sender : TObject); override;
    function AllowedOperation(textToInsert : TLMDString) : Boolean; override;
    function GetOutString(aValue : Double) : String;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseExit; override;
    procedure DoThemeChanged; override;
    // 7.0
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    // ----
    procedure ModifyPaintRect; override;
    procedure UpdateSpinButtons;

    property SpinBtnVisible: Boolean  read GetSpinBtnVisible
                                      write SetSpinBtnVisible
                                      default true;

    property EditType : TLMDNumberType read FType write SetType default ntInteger;
    property Value : Double index 2 read FValue write SetDouble;
    property InfiniteMax: Boolean read FInfiniteMax write FInfiniteMax default false;
    property InfiniteMin: Boolean read FInfiniteMin write FInfiniteMin default false;
    property LargeStep : Double read FLargeStep write FLargeStep stored isNoLargeDefault;
    property FractionStep : Double read FFractionStep write FFractionStep stored isNoFractionDefault;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
  published
    property AutoSize;
    property AutoDisableButtons: boolean read FAutoDisableButtons write SetAutoDisableButtons default false;   
    property Alignment;
    property CheckOnExitOnly: boolean read FCheckOnExitOnly write SetCheckOnExitOnly default false;
    property CustomButtons;
    property CustomButtonsStyle;
    property CustomButtonWidth;
    property CustomButtonParentCtlXP;
    property ForceOverwriteMode default false;
    property Interval:Word read GetInterval write SetInterval default 100;
    property SpinBtnWidth : Integer index 0 read FSpinBtnWidth write SetInteger default -1;
    property SpinBtnColor:  TColor index 0 read GetColor write SetColor default clBtnFace;
    property SpinBtnDiag: Boolean read GetDiag write SetDiag default true;
    property SpinBtnHotColor:TColor index 1 read GetColor write SetColor default def_SPINHOTCOLOR;

    property Step : Double read FStep write FStep stored isNoDefault;
    property EditorEnabled : Boolean read FEditorEnabled write FEditorEnabled default true;

    property ReadOnly;
    // 7.0
    property OnSpinBtnUpClick:TNotifyEvent read FOnUpClick write FOnUpClick;
    property OnSpinBtnDownClick:TNotifyEvent read FOnDownClick write FOnDownClick;

    property OnValueChanged: TLMDOnValueChangedEvent read FOnValueChanged write FOnValueChanged;
    property OnValueChanging: TLMDOnValueChangingEvent read FOnValueChanging write FOnValueChanging;
    // -----
    property Options;
  end;

implementation

uses
  LMDStrings;

{ ------------------------- private ------------------------------------------ }
procedure TLMDCustomExtSpinEdit.SetAutoDisableButtons(
  const Value: boolean);
begin
  if Value <> FAutoDisableButtons then
    begin
      FAutoDisableButtons := Value;
      UpdateSpinButtons;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.SetInteger (index, aValue : Integer);
begin
  case index of
    0 : if aValue <> FSpinBtnWidth then
          begin
            FSpinBtnWidth := aValue;
            SetupRects; //added Aug 2001, JH otherwise btn size change will not be applied at once
            GetChange(nil);
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.SetType (aValue : TLMDNumberType);
begin
  if aValue <> FType then
    begin
      FType := aValue;
      case FType of
        ntInteger     : MaskType := meInteger;
        ntFloat       : MaskType := meFloat;
        ntFloatFixed  : MaskType := meFloatFixed;
        ntFloatNumber : MaskType := meFloatNumber;
        ntCurrency    : MaskType := meCurrency;
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.SetInterval(const Value: Word);
begin
  FSpinBtn.Interval:=Value;
end;

procedure TLMDCustomExtSpinEdit.SetSpinBtnVisible(const Value: Boolean);
begin
  FSpinBtn.Visible := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.SetDouble (index : Integer; aValue : Double);
var
  lCanModify: boolean;
  lOldValue: double;
begin
  case index of
    2 : if (aValue <> FValue) or (FCheckBounds and FCheckOnExitOnly) then
          begin
            lCanModify := true;
            lOldValue := FValue;
            DoValueChanging(Self, aValue, lCanModify);
            if lCanModify then
              FValue := aValue;
            if FCheckBounds or not FCheckOnExitOnly then
              begin
                if (not InfiniteMax) and (FValue > MaxValue) then
                  FValue := MaxValue;
                if (not InfiniteMin) and (FValue < MinValue) then
                  FValue := MinValue;
              end;   
            if FAutoDisableButtons then
              UpdateSpinButtons;
            Text := GetOutString (FValue);
            if FValue <> lOldValue then
              DoValueChanged(Self, lOldValue, FValue);
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.SetColor(index:Integer; const Value: TColor);
begin
  case Index of
    0: FSpinBtn.Color:=Value;
    1: FSpinBtn.HotColor:=Value;
  end;

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.SetDiag(const Value: Boolean);
begin
  FSpinBtn.OldStyle:=Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomExtSpinEdit.GetColor(Index:Integer): TColor;
begin
  case Index of
    0: result:=FSpinBtn.Color;
    1: result:=FSpinBtn.HotColor;
  else
    result:=clNone;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomExtSpinEdit.GetDiag: Boolean;
begin
  result:=FSpinBtn.OldStyle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomExtSpinEdit.GetInterval: Word;
begin
  result:=FSpinBtn.Interval;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomExtSpinEdit.IsNoDefault: Boolean;
begin
  result:=FStep<>1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomExtSpinEdit.IsNoFractionDefault: Boolean;
begin
  result:=FFractionStep<>0.1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomExtSpinEdit.IsNoLargeDefault: Boolean;
begin
  result:=FLargeStep<>10;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.WMKILLFOCUS (var Message : TWMKillFocus);
begin
  inherited;
  FCheckBounds := true; //has effect if CheckOnExitOnly = true
  case FType of
    ntInteger     : Value := AsInteger;
    ntFloat,
    ntFloatNumber,
    ntFloatFixed  : Value := AsFloat;
    ntCurrency    : begin
                      Value := AsCurrency;
                      if GetOutString (FValue) <> FText then
                        Text := GetOutString (FValue);
                    end;
  end;
  FCheckBounds := false;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.CMEnabledChanged (var Message : TMessage);
begin
  inherited;
  FSpinBtn.Enabled := Enabled; //JH April 2002
end;

{ ------------------------- protected ---------------------------------------- }
procedure TLMDCustomExtSpinEdit.DoInc(Sender : TObject);
begin
  if Showing then
    Windows.SetFocus(Handle);

  Increment (FStep);
  if Assigned(FOnUpClick) then
    FOnUpClick(self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.DoDec(Sender : TObject);
begin
  if Showing then
    Windows.SetFocus(Handle);

  Decrement (FStep);
  if Assigned(FOnDownClick) then
    FOnDownClick(self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.DoValueChanged(Sender: TObject; OldVal,
  NewVal: double);
begin
  if Assigned(FOnValueChanged) then
    FOnValueChanged(Sender, OldVal, NewVal);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.DoValueChanging(Sender: TObject;
  var Val: double; var CanModify: boolean);
begin
  if Assigned(FOnValueChanging) then
    FOnValueChanging(Sender, Val, CanModify);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.Increment (by : Double);
var
  i : Integer;
//  s : String;
begin
  if ReadOnly then exit;
  i := SelStart;
  case FType of
    ntInteger  : if InfiniteMax or (AsInteger + Round(by) < Trunc(MaxValue)) then
                   SetValue (AsInteger + Round(by))
                 else
                   SetValue (Trunc(MaxValue));
    ntFloat,
    ntFloatNumber,
    ntFloatFixed: begin
                    if (not InfiniteMin) and (AsFloat < MinValue) then
                      SetValue(MinValue);
                    if (Pos ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, FText) = 0) or
                       (CurrentChar <= Pos ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, FText)) then
                      if InfiniteMax or (AsFloat + by < MaxValue) then
                        SetValue (AsFloat + by)
                      else
                        SetValue (MaxValue)
                    else
                      if InfiniteMax or (AsFloat + FFractionStep < MaxValue) then
                        SetValue (AsFloat + FFractionStep)
                      else
                        SetValue (MaxValue);
                  end;
    ntCurrency : if (Pos ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, FText) = 0) or
                    (CurrentChar <= Pos ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, FText)) then
                   if InfiniteMax or (AsCurrency + by < MaxValue) then
                     SetValue(AsCurrency + by)
                   else
                     SetValue(MaxValue)
                 else
                   if InfiniteMax or (AsCurrency + FFractionStep < MaxValue) then
                     SetValue(AsCurrency + FFractionStep)
                   else
                     SetValue(MaxValue);
  end;
  if (Length(Text)+1 >= i) then
    CurrentChar := i;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.Decrement (by : Double);
var
  i : Integer;
begin
  if ReadOnly then exit;
  i := SelStart;
  case FType of
    ntInteger  : if InfiniteMin or (AsInteger - by > Trunc(MinValue)) then
                   SetValue (AsInteger - Round(by))
                 else
                   SetValue (Trunc(MinValue));
    ntCurrency : if (Pos ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, FText) = 0) or
                    (CurrentChar <= Pos ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, FText)) then
                   if InfiniteMin or (AsCurrency - by > MinValue) then
                     SetValue(AsCurrency - by)
                   else
                     SetValue(MinValue)
                 else
                   if InfiniteMin or (AsCurrency - FFractionStep > MinValue) then
                     SetValue(AsCurrency - FFractionStep)
                   else
                     SetValue(MinValue);
    ntFloat,
    ntFloatNumber,
    ntFloatFixed: begin
                    if not InfiniteMax and (AsFloat > MaxValue) then
                      SetValue(MaxValue);

                    if (Pos ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, FText) = 0) or
                     (CurrentChar <= Pos ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, FText)) then
                      if InfiniteMin or (asFloat - by > MinValue) then
                        SetValue (AsFloat - by)
                      else
                        SetValue (MinValue)
                    else
                      if InfiniteMin or (asFloat - FFractionStep > MinValue) then
                        SetValue (AsFloat - FFractionStep)
                      else
                        SetValue (MinValue);
                  end;
  end;

  if Length(Text)+1 >= i then
    CurrentChar := i;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.GetCommandKey (var KeyCode : Word; Shift : TShiftState);
begin
  case KeyCode of
    VK_UP : Increment (FStep);
    VK_DOWN : Decrement (FStep);
    VK_PRIOR : Increment (FLargeStep);
    VK_NEXT: Decrement (FLargeStep);
    else
      inherited GetCommandKey (KeyCode, Shift);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.ChangedText (At : Integer);
begin
  //inherited ChangedText (At); //VB Jan 2007: with this OnChange event is
                                //triggered before Value is changed for LMDDBSpinEdit
  case FType of
    ntInteger      : Value := AsInteger;
    ntFloat,
    ntFloatNumber,
    ntFloatFixed  : Value := AsFloat;
    ntCurrency     : begin
                       Value := AsCurrency;
                       if GetOutString (Value) <> FText then
                         Text := GetOutString (Value);
                     end;
  end;
  inherited ChangedText (At);  //VB Jan 2007
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.GetChange (Sender : TObject);
begin
//  if csLoading in ComponentState then exit;
  inherited GetChange (Sender);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomExtSpinEdit.AllowedOperation(textToInsert : TLMDString) : Boolean;
begin
  result := inherited AllowedOperation(textToInsert) and FEditorEnabled;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomExtSpinEdit.GetOutString (aValue : Double) : String;
begin
  case FType of
    ntInteger    : result := LMDGetBaseString (NumberBase, Trunc (aValue)); //IntToStr (Trunc(aValue));
    ntCurrency   : result := FloatToStrF(aValue, ffCurrency, 15, {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}CurrencyDecimals); {CurrencySettings.toStr(aValue); //TODO!!}
    ntFloat      : result := LMDFloatToStrF (aValue, ffGeneral, NumberBase, Decimals, 1);//FloatToStrF(aValue, ffGeneral, 15, Decimals);
    ntFloatNumber: result := LMDFloatToStrF (aValue, ffNumber, NumberBase, Decimals, 1); //FloatToStrF(aValue, ffNumber, 15, Decimals);
    ntFloatFixed : result := LMDFloatToStrF (aValue, ffFixed, NumberBase, Decimals, 1);//FloatToStrF(aValue, ffFixed, 15, Decimals);
  end;
  result := result + Suffix; //May 02, JH
end;

function TLMDCustomExtSpinEdit.GetSpinBtnVisible: Boolean;
begin
  Result := FSpinBtn.Visible;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove (Shift, X, Y);
  FSpinBtn.MouseLeave;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.MouseExit;
begin
  inherited MouseExit;
  FSpinBtn.MouseLeave;
end;

{------------------------------------------------------------------------------}
function TLMDCustomExtSpinEdit.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  inherited DoMouseWheelDown(Shift, MousePos);
  Decrement(FStep);
  result:=True;
end;

{------------------------------------------------------------------------------}
function TLMDCustomExtSpinEdit.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  inherited DoMouseWheelUp(Shift, MousePos);
  InCrement(FStep);
  result:=True;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.DoThemeChanged;
begin
  FSpinBtn.ThemeMode := self.ThemeMode;
  inherited;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDCustomExtSpinEdit.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FCheckOnExitOnly := false;
  FAutoDisableButtons := false;
  FForceOverwriteMode := false;
  FSpinBtn := TLMDSpinButton.Create (self);
  FSpinBtn.ThemeMode := FThemeMode;
  FSpinBtn.Parent := self;
  FSpinBtn.Color := clBtnFace;
  FSpinBtnWidth := -1;
  FSpinBtn.SpinButtons := [sbUp, sbDown];
  FSpinBtn.ExtStyle := seSpinEdit;
  FSpinBtn.OnTopClick := DoInc;
  FSpinBtn.OnBottomClick := DoDec;
  FSpinBtn.OnLeftClick := DoInc;
  FSpinBtn.OnRightClick := DoDec;
  FSpinBtn.Cursor := crArrow;

  FType := ntInteger;
  FMaskType := meInteger;
  FStep := 1;
  FLargeStep := 10;
  FFractionStep := 0.1;
  FInfiniteMin := false;
  FInfiniteMax := false;
  MinValue := 0;
  MaxValue := 100;
  FValue := 0;
  FEditorEnabled := true;
  BeginUpdate;
  try
    SetValue(0);
  finally
    EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomExtSpinEdit.Destroy;
begin
  if Assigned(FSpinBtn) then
    FreeAndNil(FSpinBtn);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.Loaded;
begin
  inherited Loaded;
  case FType of
    ntInteger : begin
                  MaskType := meInteger;
                  MinValue := Trunc(MinValue); //get rid of fraction
                end;
    ntFloatFixed : MaskType := meFloatFixed;
    ntFloatNumber : MaskType := meFloatNumber;
    ntFloat : MaskType := meFloat;
    ntCurrency : MaskType := meCurrency;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.ModifyPaintRect;
var
  w : Integer;
begin
  inherited ModifyPaintRect;
  w := FSpinBtnWidth;
  if w = -1 then //autosize btn
    w := FPaintRect.Bottom - FPaintRect.Top;
  //substract btn width from paintable area
  FPaintRect.Right := FPaintRect.Right - w;
  FSpinBtn.SetBounds (FPaintRect.Right {+ 1}, FPaintRect.Top, w , FPaintRect.Bottom - FPaintRect.Top); //VB March 2008
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.UpdateSpinButtons;
begin
  FSpinBtn.Perform(CM_ENABLEDCHANGED, 1, Ord(bpsNormal));
  FSpinBtn.Perform(CM_ENABLEDCHANGED, 2, Ord(bpsNormal));
  if (not InfiniteMax) then
    begin
      if (FValue >= MaxValue) and FAutoDisableButtons then
        FSpinBtn.Perform(CM_ENABLEDCHANGED, 2, Ord(bpsDisabled));
    end;
  if (not InfiniteMin) then
    begin
      if (FValue <= MinValue) and FAutoDisableButtons then
        FSpinBtn.Perform(CM_ENABLEDCHANGED, 1, Ord(bpsDisabled));
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtSpinEdit.SetCheckOnExitOnly(const Value: boolean);
begin
  FCheckOnExitOnly := Value;
end;

end.
