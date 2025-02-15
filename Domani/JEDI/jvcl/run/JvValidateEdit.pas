{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is JvValidateEdit, released on 20 February 2003,
  by Christopher Latta
Portions created by Christopher Latta are Copyright (C) 2003 Christopher Latta.
All Rights Reserved.

Contributor(s): Peter Thornqvist
                Peter Schraut (http://www.console-dev.de)

You may retrieve the latest version of this file at the Project JEDI's JVCL
home page, located at http://jvcl.sourceforge.net

Known Issues:
TJvValidateFormat uses the SysUtils.Format function to format numeric values.
While this uses the Windows regional settings for the currency symbol, decimal
separator and thousands separator, it does not format using the negative symbol,
negative number format, negative currency format and positive currency format.
This could be rectified by a custom-written formatting routine.

-----------------------------------------------------------------------------}
// $Id: JvValidateEdit.pas,v 1.43 2006/02/13 11:54:27 obones Exp $

unit JvValidateEdit;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Windows, Messages, Controls, Graphics,
  SysUtils, Classes,
  JvEdit;

type
  TJvValidateEditDisplayFormat = (dfAlphabetic, dfAlphaNumeric, dfBinary,
    dfCheckChars, dfCurrency, dfCustom, dfFloat, dfHex, dfInteger,
    dfNonCheckChars, dfNone, dfOctal, dfPercent, dfScientific, dfYear);

  TJvValidateEditCriticalPointsCheck = (cpNone, cpMinValue, cpMaxValue, cpBoth);

  TJvValidateEditCriticalPoints = class(TPersistent)
  private
    FCheckPoints: TJvValidateEditCriticalPointsCheck;
    FColorAbove: TColor;
    FColorBelow: TColor;
    FMaxValue: Double;
    FMinValue: Double;
    FOnChange: TNotifyEvent;
    FDefCheckPoints: TJvValidateEditCriticalPointsCheck;
    FDefColorAbove: TColor;
    FDefColorBelow: TColor;
    procedure DoChanged;
    procedure SetMinValue(NewValue: Double);
    procedure SetMaxValue(NewValue: Double);
    procedure SetColorAbove(NewValue: TColor);
    procedure SetColorBelow(NewValue: TColor);
    procedure SetCheckPoints(NewValue: TJvValidateEditCriticalPointsCheck);
    function IsCheckPointsStored: Boolean;
    function IsColorAboveStored: Boolean;
    function IsColorBelowStored: Boolean;
  public
    procedure Assign(Source: TPersistent); override;
    procedure SetDefaults(ACheckPoints: TJvValidateEditCriticalPointsCheck;
      AColorAbove, AColorBelow: TColor);
    constructor Create;
  published
    property CheckPoints: TJvValidateEditCriticalPointsCheck read FCheckPoints
      write SetCheckPoints stored IsCheckPointsStored;
    property ColorAbove: TColor read FColorAbove write SetColorAbove stored IsColorAboveStored;
    property ColorBelow: TColor read FColorBelow write SetColorBelow stored IsColorBelowStored;
    property MaxValue: Double read FMaxValue write SetMaxValue;
    property MinValue: Double read FMinValue write SetMinValue;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TJvCustomTextValidateEvent = procedure(Sender: TObject; Key: Char;
    const AText: string; const Pos: Integer; var IsValid: Boolean) of object;
  TJvCustomIsValidEvent = procedure(Sender: TObject; var IsValid: Boolean) of object;

  TJvCustomValidateEdit = class(TJvCustomEdit)
  private
    FSelfChange: Boolean;
    FCheckChars: string;
    FDecimalPlaces: Cardinal;
    FDisplayFormat: TJvValidateEditDisplayFormat;
    FEditText: string;
    FHasMaxValue: Boolean;
    FHasMinValue: Boolean;
    FMaxValue: Double;
    FMinValue: Double;
    FOnCustomValidate: TJvCustomTextValidateEvent;
    FOnValueChanged: TNotifyEvent;
    FZeroEmpty: Boolean;
    EnterText: string;
    FDisplayPrefix: string;
    FDisplaySuffix: string;
    FCriticalPoints: TJvValidateEditCriticalPoints;
    FStandardFontColor: TColor;
    FAutoAlignment: Boolean;
    FTrimDecimals: Boolean;
    FOldFontChange: TNotifyEvent;
    FOnIsValid: TJvCustomIsValidEvent;
    FAllowEmpty: Boolean;
    procedure DisplayText;
    function ScientificStrToFloat(SciString: string): Double;
    procedure SetHasMaxValue(NewValue: Boolean);
    procedure SetHasMinValue(NewValue: Boolean);
    procedure SetMaxValue(NewValue: Double);
    procedure SetMinValue(NewValue: Double);
    procedure SetDecimalPlaces(NewValue: Cardinal);
    procedure SetDisplayFormat(NewValue: TJvValidateEditDisplayFormat);
    procedure SetZeroEmpty(NewValue: Boolean);
    function GetAsInteger: Int64;
    procedure SetAsInteger(NewValue: Int64);
    function GetAsCurrency: Currency;
    procedure SetAsCurrency(NewValue: Currency);
    function GetAsFloat: Double;
    procedure SetAsFloat(NewValue: Double);
    function GetValue: Variant;
    procedure SetValue(NewValue: Variant);
    procedure SetCheckChars(const NewValue: string);
    function IsCheckCharsStored: Boolean;
    function CurrRangeValue(CheckValue: Currency): Currency; overload;
    function FloatRangeValue(CheckValue: Double): Double; overload;
    function IntRangeValue(CheckValue: Int64): Int64; overload;
    function GetEditText: string;
    procedure SetEditText(const NewValue: string);
    procedure ChangeText(const NewValue: string);
    function BaseToInt(const BaseValue: string; Base: Byte): Int64;
    function IntToBase(NewValue: Int64; Base: Byte): string;
    procedure DoValueChanged;
    procedure SetDisplayPrefix(const NewValue: string);
    procedure SetDisplaySuffix(const NewValue: string);
    procedure CriticalPointsChange(Sender: TObject);
    procedure SetFontColor;
    procedure FontChange(Sender: TObject);
    procedure EnforceMaxValue;
    procedure EnforceMinValue;
    procedure SetTrimDecimals(const Value: Boolean);
  protected
    function IsValidChar(const S: string; Key: Char; Posn: Integer): Boolean; virtual;
    function MakeValid(const ParseString: string): string;virtual;
    procedure Change; override;
    procedure FocusKilled(NextWnd: THandle); override;
    procedure FocusSet(PrevWnd: THandle); override;
    procedure WMPaste(var Msg: TMessage); message WM_PASTE;
    procedure SetText(const NewValue: TCaption); override;
    property CheckChars: string read FCheckChars write SetCheckChars
      stored IsCheckCharsStored;
    property TrimDecimals: Boolean read FTrimDecimals write SetTrimDecimals;
    property DecimalPlaces: Cardinal read FDecimalPlaces write SetDecimalPlaces;
    property DisplayFormat: TJvValidateEditDisplayFormat read FDisplayFormat
      write SetDisplayFormat;
    property EditText: string read GetEditText write SetEditText;
    property HasMaxValue: Boolean read FHasMaxValue write SetHasMaxValue;
    property HasMinValue: Boolean read FHasMinValue write SetHasMinValue;
    property MaxValue: Double read FMaxValue write SetMaxValue;
    property MinValue: Double read FMinValue write SetMinValue;
    property OnCustomValidate: TJvCustomTextValidateEvent
      read FOnCustomValidate write FOnCustomValidate;
    property OnValueChanged: TNotifyEvent read FOnValueChanged write FOnValueChanged;
    property Value: Variant read GetValue write SetValue stored False;
    property AllowEmpty: Boolean read FAllowEmpty write FAllowEmpty;
    property ZeroEmpty: Boolean read FZeroEmpty write SetZeroEmpty;
    property DisplayPrefix: string read FDisplayPrefix write SetDisplayPrefix;
    property DisplaySuffix: string read FDisplaySuffix write SetDisplaySuffix;
    property CriticalPoints: TJvValidateEditCriticalPoints read FCriticalPoints
      write FCriticalPoints;
    property AutoAlignment: Boolean read FAutoAlignment write FAutoAlignment;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    function DoValidate(const Key: Char; const AText: string;
      const Posn: Integer): Boolean;
    procedure Loaded; override;

    property OnIsValid: TJvCustomIsValidEvent read FOnIsValid write FOnIsValid;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function IsValid: Boolean; virtual; // fires OnIsValid if assigned

    procedure Assign(Source: TPersistent); override;
    property AsInteger: Int64 read GetAsInteger write SetAsInteger;
    property AsCurrency: Currency read GetAsCurrency write SetAsCurrency;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
  end;

  TJvValidateEdit = class(TJvCustomValidateEdit)
  published
    property AllowEmpty default False;
    property Alignment default taRightJustify;
    property Anchors;
    property AutoAlignment default True;

    property AutoSelect;
    property AutoSize;
    {$IFDEF VCL}
    property BiDiMode;
    property DragCursor;
    property DragKind;
    property ImeMode;
    property ImeName;
    property OEMConvert;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    {$ENDIF VCL}
    property BorderStyle;
    property Caret;
    property CheckChars;
    property CharCase;
    property ClipboardCommands;
    property Color;
    property Constraints;
    property CriticalPoints;
    property DisabledColor;
    property DisabledTextColor;
    property TrimDecimals default False;
    property DisplayFormat default dfInteger;
    property DecimalPlaces default 0;
    property DisplayPrefix;
    property DisplaySuffix;
    property DragMode;
    property EditText;
    property Enabled;
    property Font;
    property HasMaxValue default False;
    property HasMinValue default False;
    property HideSelection;
    property MaxLength;
    property MaxValue;
    property MinValue;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text stored False;
    property Value;
    property Visible;
    property ZeroEmpty default False;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnCustomValidate;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnValueChanged;
    property OnIsValid;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvValidateEdit.pas,v $';
    Revision: '$Revision: 1.43 $';
    Date: '$Date: 2006/02/13 11:54:27 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

uses
  Math,
  JvJCLUtils, JvResources;

//=== { TJvCustomValidateEdit } ==============================================

constructor TJvCustomValidateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSelfChange := False;
  FAutoAlignment := True;
  FCriticalPoints := TJvValidateEditCriticalPoints.Create;
  FCriticalPoints.OnChange := CriticalPointsChange;
  FDisplayFormat := dfInteger;
  FCheckChars := '01234567890';
  Alignment := taRightJustify;
  FEditText := '';
  Text := '';
  AutoSize := True;
  FMinValue := 0;
  FMaxValue := 0;
  FHasMinValue := False;
  FHasMaxValue := False;
  FZeroEmpty := False;
  FStandardFontColor := Font.Color;
  FOldFontChange := Font.OnChange;
  Font.OnChange := FontChange;
end;

destructor TJvCustomValidateEdit.Destroy;
begin
  FreeAndNil(FCriticalPoints);
  inherited Destroy;
end;

procedure TJvCustomValidateEdit.Assign(Source: TPersistent);
var
  lcSource: TJvCustomValidateEdit;
begin
  if Source is TJvCustomValidateEdit then
  begin
    lcSource := TJvCustomValidateEdit(Source);
    CriticalPoints.Assign(lcSource.CriticalPoints);
    DisplayFormat := lcSource.DisplayFormat;
    DecimalPlaces := lcSource.DecimalPlaces;
    MinValue := lcSource.MinValue;
    MaxValue := lcSource.MaxValue;
    HasMinValue := lcSource.HasMinValue;
    HasMaxValue := lcSource.HasMaxValue;
    ZeroEmpty := lcSource.ZeroEmpty;
    AllowEmpty := lcSource.AllowEmpty;
  end
  else
    inherited Assign(Source);
end;

procedure TJvCustomValidateEdit.Loaded;
begin
  inherited Loaded;
  // (obones) Why is this necessary? It overrides DecimalPlaces set to 0 by the user
{  if DisplayFormat = dfCurrency then
    if FDecimalPlaces = 0 then
      FDecimalPlaces := CurrencyDecimals;}
  EditText := FEditText;
end;

procedure TJvCustomValidateEdit.SetHasMaxValue(NewValue: Boolean);
begin
  if FHasMaxValue <> NewValue then
  begin
    FHasMaxValue := NewValue;
    if not (csLoading in ComponentState) then
      EnforceMaxValue;
  end;
end;

procedure TJvCustomValidateEdit.SetHasMinValue(NewValue: Boolean);
begin
  if FHasMinValue <> NewValue then
  begin
    FHasMinValue := NewValue;
    if not (csLoading in ComponentState) then
      EnforceMinValue;
  end;
end;

procedure TJvCustomValidateEdit.SetMaxValue(NewValue: Double);
begin
  if FMaxValue <> NewValue then
  begin
    FMaxValue := NewValue;
    { make MinValue consistent }
    if FMinValue > FMaxValue then
      FMinValue := FMaxValue;
    if not (csLoading in ComponentState) then
      EnforceMaxValue;
  end;
end;

procedure TJvCustomValidateEdit.SetMinValue(NewValue: Double);
begin
  if FMinValue <> NewValue then
  begin
    FMinValue := NewValue;
    { make MaxValue consistent }
    if FMaxValue < FMinValue then
      FMaxValue := FMinValue;
    if not (csLoading in ComponentState) then
      EnforceMinValue;
  end;
end;

procedure TJvCustomValidateEdit.SetTrimDecimals(const Value: Boolean);
begin
  if Value <> FTrimDecimals then
  begin
    FTrimDecimals := Value;
    if not (csLoading in ComponentState) then
      EditText := FEditText;
  end;
end;

procedure TJvCustomValidateEdit.SetDecimalPlaces(NewValue: Cardinal);
begin
  if ControlState = [csReadingState] then
    FDecimalPlaces := NewValue
  else
  if FDisplayFormat in [dfCurrency, dfFloat, dfScientific, dfPercent] then
    FDecimalPlaces := NewValue;
  if not (csLoading in ComponentState) then
    EditText := FEditText;
end;

procedure TJvCustomValidateEdit.SetDisplayFormat(NewValue:
  TJvValidateEditDisplayFormat);
const
  ALPHABET = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  NUMBERS = '0123456789';
var
  OldFormat: TJvValidateEditDisplayFormat;
begin
  if FDisplayFormat <> NewValue then
  begin
    OldFormat := FDisplayFormat;
    FDisplayFormat := NewValue;
    case FDisplayFormat of
      dfAlphabetic:
        begin
          FCheckChars := ALPHABET;
          if FAutoAlignment then
            Alignment := taLeftJustify;
        end;
      dfAlphaNumeric:
        begin
          FCheckChars := ALPHABET + NUMBERS;
          if FAutoAlignment then
            Alignment := taLeftJustify;
        end;
      dfBinary:
        begin
          FCheckChars := '01';
          if FAutoAlignment then
            Alignment := taRightJustify;
        end;
      dfCheckChars, dfNonCheckChars:
        if FAutoAlignment then
          Alignment := taLeftJustify;
      dfCustom, dfNone:
        begin
          FCheckChars := '';
          if FAutoAlignment then
            Alignment := taLeftJustify;
        end;
      dfCurrency:
        begin
          FCheckChars := NUMBERS + DecimalSeparator;
          if FAutoAlignment then
            Alignment := taRightJustify;
          if not (csLoading in ComponentState) then
            if FDecimalPlaces = 0 then
              FDecimalPlaces := CurrencyDecimals;
        end;
      dfFloat, dfPercent:
        begin
          FCheckChars := NUMBERS + DecimalSeparator;
          if FAutoAlignment then
            Alignment := taRightJustify;
        end;
      dfHex:
        begin
          FCheckChars := NUMBERS + 'ABCDEFabcdef';
          if FAutoAlignment then
            Alignment := taRightJustify;
        end;
      dfInteger:
        begin
          FCheckChars := NUMBERS;
          if FAutoAlignment then
            Alignment := taRightJustify;
        end;
      dfOctal:
        begin
          FCheckChars := '01234567';
          if FAutoAlignment then
            Alignment := taRightJustify;
        end;
      dfScientific:
        begin
          FCheckChars := NUMBERS + 'Ee' + DecimalSeparator;
          if FAutoAlignment then
            Alignment := taRightJustify;
        end;
      dfYear:
        begin
          FCheckChars := NUMBERS;
          if FAutoAlignment then
            Alignment := taRightJustify;
          MaxLength := 4;
        end;
    end;

    if OldFormat = dfYear then
      MaxLength := 0;

    // Convert non-base 10 numbers to base 10 and base-10 numbers to non-base 10
    if (OldFormat = dfBinary) and
      (NewValue in [dfCurrency, dfFloat, dfHex, dfInteger, dfOctal, dfPercent, dfScientific, dfYear]) then
      SetAsInteger(BaseToInt(FEditText, 2))
    else
    if (OldFormat in [dfCurrency, dfFloat, dfPercent]) and
      (NewValue in [dfBinary, dfHex, dfOctal]) then
      SetAsFloat(StrToFloatDef(FEditText, 0))
    else
    if (OldFormat = dfHex) and
      (NewValue in [dfBinary, dfCurrency, dfFloat, dfInteger, dfOctal, dfPercent, dfScientific, dfYear]) then
      SetAsInteger(BaseToInt(FEditText, 16))
    else
    if (OldFormat in [dfInteger, dfYear]) and
      (NewValue in [dfBinary, dfHex, dfOctal]) then
      SetAsInteger(StrToIntDef(FEditText, 0))
    else
    if (OldFormat = dfOctal) and
      (NewValue in [dfBinary, dfCurrency, dfFloat, dfHex, dfInteger, dfPercent, dfScientific, dfYear]) then
      SetAsInteger(BaseToInt(FEditText, 8))
    else
    begin
      // ...or just display the value
      if not (csLoading in ComponentState) then
        EditText := FEditText;
    end;
  end;
end;

procedure TJvCustomValidateEdit.SetZeroEmpty(NewValue: Boolean);
begin
  if FZeroEmpty <> NewValue then
  begin
    FZeroEmpty := NewValue;
    if not (csLoading in ComponentState) then
      EditText := FEditText;
  end;
end;

function TJvCustomValidateEdit.GetAsInteger: Int64;
begin
  case FDisplayFormat of
    dfBinary:
      Result := BaseToInt(FEditText, 2);
    dfHex:
      Result := BaseToInt(FEditText, 16);
    dfOctal:
      Result := BaseToInt(FEditText, 8);
  else
    Result := StrToInt64Def(FEditText, 0);
  end;
end;

procedure TJvCustomValidateEdit.SetAsInteger(NewValue: Int64);
begin
  case FDisplayFormat of
    dfAlphabetic, dfAlphaNumeric, dfCheckChars, dfCustom,
    dfNonCheckChars, dfNone:
      EditText := IntToStr(NewValue);
    dfBinary:
      EditText := IntToBase(NewValue, 2);
    dfHex:
      EditText := IntToBase(NewValue, 16);
    dfOctal:
      EditText := IntToBase(NewValue, 8);
    dfCurrency, dfFloat, dfInteger, dfPercent, dfScientific, dfYear:
      EditText := IntToStr(IntRangeValue(NewValue));
  end;
end;

function TJvCustomValidateEdit.GetAsCurrency: Currency;
begin
  case FDisplayFormat of
    dfBinary:
      Result := BaseToInt(FEditText, 2);
    dfHex:
      Result := BaseToInt(FEditText, 16);
    dfOctal:
      Result := BaseToInt(FEditText, 8);
  else
    Result := StrToCurrDef(FEditText, 0);
  end;
end;

procedure TJvCustomValidateEdit.SetAsCurrency(NewValue: Currency);
begin
  case FDisplayFormat of
    dfAlphabetic, dfAlphaNumeric, dfCheckChars, dfCustom,
    dfNonCheckChars, dfNone:
      EditText := CurrToStr(NewValue);
    dfBinary:
      EditText := IntToBase(Trunc(NewValue), 2);
    dfHex:
      EditText := IntToBase(Trunc(NewValue), 16);
    dfOctal:
      EditText := IntToBase(Trunc(NewValue), 8);
    dfCurrency, dfFloat, dfInteger, dfPercent, dfScientific, dfYear:
      EditText := CurrToStr(CurrRangeValue(NewValue));
  end;
end;

function TJvCustomValidateEdit.GetAsFloat: Double;
begin
  case FDisplayFormat of
    dfBinary:
      Result := BaseToInt(FEditText, 2);
    dfHex:
      Result := BaseToInt(FEditText, 16);
    dfOctal:
      Result := BaseToInt(FEditText, 8);
    dfScientific:
      Result := ScientificStrToFloat(FEditText);
  else
    Result := StrToFloatDef(FEditText, 0);
  end;
end;

procedure TJvCustomValidateEdit.SetAsFloat(NewValue: Double);
begin
  case FDisplayFormat of
    dfAlphabetic, dfAlphaNumeric, dfCheckChars, dfCustom,
    dfNonCheckChars, dfNone:
      EditText := FloatToStr(NewValue);
    dfBinary:
      EditText := IntToBase(Trunc(NewValue), 2);
    dfHex:
      EditText := IntToBase(Trunc(NewValue), 16);
    dfOctal: EditText := IntToBase(Trunc(NewValue), 8);
    dfInteger, dfYear:
      EditText := IntToStr(IntRangeValue(Trunc(NewValue)));
    dfCurrency, dfFloat, dfPercent:
      EditText := FloatToStr(FloatRangeValue(NewValue));
    dfScientific:
      EditText := Format('%e', [FloatRangeValue(NewValue)]);
  end;
end;

function TJvCustomValidateEdit.GetValue: Variant;
begin
  case FDisplayFormat of
    dfCurrency:
      Result := StrToCurrDef(FEditText, 0);
    dfFloat, dfPercent, dfScientific:
      Result := StrToFloatDef(FEditText, 0);
    dfInteger, dfYear:
      Result := StrToIntDef(FEditText, 0);
  else
    Result := inherited Text;
  end;
end;

procedure TJvCustomValidateEdit.SetValue(NewValue: Variant);
begin
  case FDisplayFormat of
    dfAlphabetic, dfAlphaNumeric, dfCheckChars, dfNonCheckChars, dfNone, dfCustom:
      EditText := NewValue;
    dfBinary, dfHex, dfInteger, dfOctal, dfYear:
      {$IFDEF COMPILER5}
      SetAsInteger(Integer(NewValue));
      {$ELSE}
      SetAsInteger(NewValue);
      {$ENDIF COMPILER5}
    dfCurrency, dfFloat, dfPercent, dfScientific:
      SetAsFloat(NewValue);
  end;
end;

procedure TJvCustomValidateEdit.SetCheckChars(const NewValue: string);
begin
  if (FDisplayFormat in [dfNone, dfCheckChars, dfNonCheckChars]) and
    (FCheckChars <> NewValue) then
  begin
    FCheckChars := NewValue;
    EditText := MakeValid(FEditText);
  end;
end;

function TJvCustomValidateEdit.IsCheckCharsStored: Boolean;
begin
  Result := (FDisplayFormat in [dfNone, dfCheckChars, dfNonCheckChars]);
end;

procedure TJvCustomValidateEdit.KeyPress(var Key: Char);
begin
  if not IsValidChar(Text, Key, SelStart + 1) and (Key >= #32) then
    Key := #0;
  inherited KeyPress(Key);
end;

procedure TJvCustomValidateEdit.WMPaste(var Msg: TMessage);
begin
  inherited;
  EditText := MakeValid(inherited Text);
end;

function TJvCustomValidateEdit.MakeValid(const ParseString: string): string;
var
  S: string;
  I: Integer;
begin
  S := '';
  for I := 1 to Length(ParseString) do
    if IsValidChar(Copy(ParseString, 1, I - 1), ParseString[I], I) then
      S := S + ParseString[I];
  Result := S;
end;

function TJvCustomValidateEdit.IsValidChar(const S: string;
  Key: Char; Posn: Integer): Boolean;
var
  iPosE: Integer;
begin
  case FDisplayFormat of
    dfBinary, dfCheckChars, dfHex, dfOctal, dfYear:
      Result := Pos(Key, FCheckChars) > 0;
    dfAlphabetic:
      Result := IsCharAlpha(Key);
    dfAlphaNumeric:
      Result := IsCharAlphaNumeric(Key);
    dfCustom:
      Result := DoValidate(Key, S, Posn);
    dfInteger:
      Result := (Pos(Key, FCheckChars) > 0) or
        ((Key = '+') and (Posn = 1) and ((Pos('+', S) = 0) or (SelLength > 0))) or
        ((Key = '-') and (Posn = 1) and ((Pos('-', S) = 0) or (SelLength > 0)));
    dfFloat, dfCurrency, dfPercent:
      Result := (Pos(Key, FCheckChars) > 0) or
        ((Key = DecimalSeparator) and (Pos(DecimalSeparator, S) = 0)) or
        ((Key = '+') and (Posn = 1) and ((Pos('+', S) = 0) or (SelLength > 0))) or
        ((Key = '-') and (Posn = 1) and ((Pos('-', S) = 0) or (SelLength > 0)));
    dfNonCheckChars:
      Result := Pos(Key, FCheckChars) = 0;
    dfNone:
      Result := True;
    dfScientific:
      begin
        Result := (Pos(Key, FCheckChars) > 0) or (Key in ['+', '-']);
        if Result then
        begin
          iPosE := Pos('e', LowerCase(S));
          if Key = DecimalSeparator then
          begin
            if iPosE = 0 then
              Result := (Pos(DecimalSeparator, S) = 0)
            else
              Result := ((Posn <= iPosE) and (Pos(DecimalSeparator, Copy(S, 1, iPosE - 1)) = 0));
               //or ((Posn > iPosE) and (Pos(DecimalSeparator, Copy(S, iPosE + 1, Length(S))) = 0));
               // (outchy) XXXeY,YY are not valid scientific numbers, Y must be an integer value
          end
          else
          if Key in ['E', 'e'] then
            Result := (iPosE = 0) and (Posn > 1)
          else
          if Key = '+' then
            Result := (Posn = 1) or (Posn = iPosE + 1)
          else
          if Key = '-' then
            Result := (Posn = 1) or (Posn = iPosE + 1);
        end;
      end;
  else
    Result := False;
  end;
end;

function TJvCustomValidateEdit.DoValidate(const Key: Char;
  const AText: string; const Posn: Integer): Boolean;
begin
  Result := True;
  if Assigned(FOnCustomValidate) then
    FOnCustomValidate(Self, Key, AText, Posn, Result);
end;

procedure TJvCustomValidateEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
// if Key = VK_DELETE then    EditText := MakeValid(inherited Text);
  if Key = VK_ESCAPE then
  begin
    Key := 0;
    EditText := EnterText;
    SelStart := 0;
    SelLength := Length(FEditText);
  end;
  inherited KeyDown(Key, Shift);
end;

function TJvCustomValidateEdit.CurrRangeValue(CheckValue: Currency): Currency;
begin
  Result := CheckValue;
  if FHasMaxValue and (CheckValue > FMaxValue) then
    Result := FMaxValue
  else
  if FHasMinValue and (CheckValue < FMinValue) then
    Result := FMinValue;
end;

function TJvCustomValidateEdit.FloatRangeValue(CheckValue: Double): Double;
begin
  Result := CheckValue;
  if FHasMaxValue and (CheckValue > FMaxValue) then
    Result := FMaxValue
  else
  if FHasMinValue and (CheckValue < FMinValue) then
    Result := FMinValue;
end;

function TJvCustomValidateEdit.IntRangeValue(CheckValue: Int64): Int64;
begin
  Result := CheckValue;
  if FHasMaxValue and (CheckValue > FMaxValue) then
    Result := Trunc(FMaxValue)
  else
  if FHasMinValue and (CheckValue < FMinValue) then
    Result := Trunc(FMinValue);
end;

function TJvCustomValidateEdit.GetEditText: string;
begin
  Result := FEditText;
end;

procedure TJvCustomValidateEdit.SetEditText(const NewValue: string);
begin
  FEditText := MakeValid(NewValue);
  if (FDisplayFormat = dfYear) and ((not FHasMaxValue) or
    (FHasMaxValue and (FMaxValue > 2000 + TwoDigitYearCenturyWindow))) and
    ((MaxLength = 0) or (MaxLength > 3)) then
    FEditText := IntToStr(MakeYear4Digit(StrToIntDef(FEditText, 0), TwoDigitYearCenturyWindow));
  if FDisplayFormat in [dfBinary, dfCurrency, dfFloat, dfHex, dfInteger,
    dfOctal, dfPercent, dfScientific, dfYear] then
  begin
    EnforceMaxValue;
    EnforceMinValue;
  end;
//  ChangeText(FEditText); 
  DisplayText;
  DoValueChanged;
end;

procedure TJvCustomValidateEdit.FocusSet(PrevWnd: THandle);
begin
  DisplayText;
  inherited FocusSet(PrevWnd);
end;

procedure TJvCustomValidateEdit.FocusKilled(NextWnd: THandle);
begin
  if not (csDestroying in ComponentState) then
    EditText := inherited Text;
  inherited FocusKilled(NextWnd);
end;

procedure TJvCustomValidateEdit.ChangeText(const NewValue: string);
var
  S, Exponent: string;
  Ps, I: Integer;
begin
  FSelfChange := True;
  try
    Ps := 0;
    if TrimDecimals then
    begin
      I := Pos('e',LowerCase(NewValue));
      if (DisplayFormat = dfScientific) and (I <> 0) then
      begin
        Exponent := Copy(NewValue,I,Length(NewValue));
        Dec(I);
      end else
      begin
        Exponent := '';
        I := Length(NewValue);
      end;
      Ps := Pos(DecimalSeparator, NewValue);
      if Ps > 0 then
      begin
        while (I > Ps) and (NewValue[I] = '0') do
          Dec(I);
        if Ps = I then
          Dec(I); // skip decimal separator (Ivo Bauer)
        S := FDisplayPrefix + Copy(NewValue, 1, I) + Exponent + FDisplaySuffix;
      end;
    end;
    if Ps = 0 then
      S := FDisplayPrefix + NewValue + FDisplaySuffix;
    if S <> inherited Text then
      inherited SetText(S);
  finally
    FSelfChange := False;
  end;
end;

procedure TJvCustomValidateEdit.DisplayText;
begin
  // The number types need to be formatted
  if FAllowEmpty and (FEditText = '') then
    ChangeText('')
  else if (FDisplayFormat in [dfBinary, dfCurrency, dfFloat, dfInteger, dfOctal, dfPercent, dfScientific, dfYear]) and
    (AsFloat = 0) and FZeroEmpty then
    ChangeText('')
  else
  begin
    case FDisplayFormat of
      dfCurrency:
        ChangeText(Format('%.*m', [FDecimalPlaces, AsCurrency]));
      dfInteger:
        ChangeText(IntToStr(AsInteger));
      dfFloat:
        ChangeText(Format('%.*n', [FDecimalPlaces, AsFloat]));
      dfScientific:
        ChangeText(Format('%.*e', [FDecimalPlaces, AsFloat]));
      dfPercent:
        ChangeText(Format('%.*n%', [FDecimalPlaces, AsFloat]));
    else
      ChangeText(FEditText);
    end;

    // This needs to be done AFTER the text has been changed so that the color
    // is directly shown correctly. (Mantis 3493)
    if (FCriticalPoints.CheckPoints <> cpNone) and
      (FDisplayFormat in [dfBinary, dfCurrency, dfFloat, dfHex, dfInteger, dfOctal, dfPercent, dfScientific, dfYear]) then
    begin
      SetFontColor;
    end;
  end;
end;

function TJvCustomValidateEdit.ScientificStrToFloat(SciString: string): Double;
var
  I: Cardinal;
  sMantissa, sExponent: string;
  bInExp: Boolean;
begin
  if Pos('E', UpperCase(SciString)) = 0 then
    Result := StrToFloatDef(SciString, 0)
  else
  begin
    sMantissa := '';
    sExponent := '';
    bInExp := False;
    for I := 1 to Length(SciString) do
    begin
      if UpperCase(SciString[I]) = 'E' then
        bInExp := True
      else
      begin
        if bInExp then
          sExponent := sExponent + SciString[I]
        else
          sMantissa := sMantissa + SciString[I];
      end;
    end;
    Result := StrToFloatDef(sMantissa, 0) * Power(10, StrToFloatDef(sExponent, 0));
  end;
end;

function TJvCustomValidateEdit.BaseToInt(const BaseValue: string; Base: Byte): Int64;
begin
  Assert(Base <= 36, RsEBaseTooBig);
  Assert(Base > 1, RsEBaseTooSmall);
  Result := Numb2Dec(BaseValue, Base);
end;

function TJvCustomValidateEdit.IntToBase(NewValue:Int64; Base: Byte): string;
begin
  Assert(Base <= 36, RsEBaseTooBig);
  Assert(Base > 1, RsEBaseTooSmall);
  Result := Dec2Numb(NewValue, 0, Base);
end;

procedure TJvCustomValidateEdit.DoValueChanged;
begin
  try
    if Assigned(FOnValueChanged) and (EnterText <> FEditText) then
      FOnValueChanged(Self);
  finally
    EnterText := FEditText;
  end;
end;

procedure TJvCustomValidateEdit.Change;
begin
  // Update FEditText for User changes, so that the AsInteger, etc,
  // functions work while editing
  if not FSelfChange then
    FEditText := inherited Text;
  inherited Change;
end;

procedure TJvCustomValidateEdit.SetText(const NewValue: TCaption);
begin
  EditText := NewValue;
  DoValueChanged;
end;

procedure TJvCustomValidateEdit.SetDisplayPrefix(const NewValue: string);
begin
  FDisplayPrefix := NewValue;
  DisplayText;
end;

procedure TJvCustomValidateEdit.SetDisplaySuffix(const NewValue: string);
begin
  FDisplaySuffix := NewValue;
  DisplayText;
end;

procedure TJvCustomValidateEdit.CriticalPointsChange(Sender: TObject);
begin
  SetFontColor;
  Invalidate;
end;

function TJvCustomValidateEdit.IsValid: Boolean;
begin
  Result := True;
  case FCriticalPoints.CheckPoints of
    cpMaxValue:
      Result := AsFloat <= FCriticalPoints.MaxValue;
    cpBoth:
      Result := (AsFloat <= FCriticalPoints.MaxValue) and
                (AsFloat >= FCriticalPoints.MinValue);
  end;
  if Assigned(FOnIsValid) then
    FOnIsValid(Self, Result);
end;

procedure TJvCustomValidateEdit.SetFontColor;
begin
  Font.OnChange := nil;
  case FCriticalPoints.CheckPoints of
    cpNone:
      Font.Color := FStandardFontColor;
    cpMinValue:
      if AsFloat < FCriticalPoints.MinValue then
        Font.Color := FCriticalPoints.ColorBelow
      else
        Font.Color := FStandardFontColor;
    cpMaxValue:
      if AsFloat > FCriticalPoints.MaxValue then
        Font.Color := FCriticalPoints.ColorAbove
      else
        Font.Color := FStandardFontColor;
    cpBoth:
      if AsFloat > FCriticalPoints.MaxValue then
        Font.Color := FCriticalPoints.ColorAbove
      else
      if AsFloat < FCriticalPoints.MinValue then
        Font.Color := FCriticalPoints.ColorBelow
      else
        Font.Color := FStandardFontColor;
  end;
  Font.OnChange := FontChange;
  Invalidate;
end;

procedure TJvCustomValidateEdit.FontChange(Sender: TObject);
begin
  FStandardFontColor := Font.Color;
  if Assigned(FOldFontChange) then
    FOldFontChange(Sender);
end;

procedure TJvCustomValidateEdit.EnforceMaxValue;
begin
  { Check the Value is within this range }
  if FHasMaxValue and (FDisplayFormat in [dfBinary, dfCurrency, dfFloat,
    dfHex, dfInteger, dfOctal, dfPercent, dfScientific, dfYear]) and
    (AsFloat > FMaxValue) then
    SetAsFloat(FMaxValue);
end;

procedure TJvCustomValidateEdit.EnforceMinValue;
begin
  { Check the Value is within this range }
  if FHasMinValue and (FDisplayFormat in [dfBinary, dfCurrency, dfFloat,
    dfHex, dfInteger, dfOctal, dfPercent, dfScientific, dfYear]) and
    (AsFloat < FMinValue) then
    SetAsFloat(FMinValue);
end;

//=== { TJvValidateEditCriticalPoints } ======================================

constructor TJvValidateEditCriticalPoints.Create;
begin
  inherited Create;
  SetDefaults(cpNone, clBlue, clRed);
end;

procedure TJvValidateEditCriticalPoints.SetCheckPoints(NewValue: TJvValidateEditCriticalPointsCheck);
begin
  if FCheckPoints <> NewValue then
  begin
    FCheckPoints := NewValue;
    DoChanged;
  end;
end;

procedure TJvValidateEditCriticalPoints.SetColorAbove(NewValue: TColor);
begin
  if FColorAbove <> NewValue then
  begin
    FColorAbove := NewValue;
    DoChanged;
  end;
end;

procedure TJvValidateEditCriticalPoints.SetColorBelow(NewValue: TColor);
begin
  if FColorBelow <> NewValue then
  begin
    FColorBelow := NewValue;
    DoChanged;
  end;
end;

procedure TJvValidateEditCriticalPoints.SetMaxValue(NewValue: Double);
begin
  if FMaxValue <> NewValue then
  begin
    FMaxValue := NewValue;
    DoChanged;
  end;
end;

procedure TJvValidateEditCriticalPoints.SetMinValue(NewValue: Double);
begin
  if FMinValue <> NewValue then
  begin
    FMinValue := NewValue;
    DoChanged;
  end;
end;

procedure TJvValidateEditCriticalPoints.DoChanged;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TJvValidateEditCriticalPoints.Assign(Source: TPersistent);
var
  LocalSource: TJvValidateEditCriticalPoints;
begin
  if Source is TJvValidateEditCriticalPoints then
  begin
    LocalSource := TJvValidateEditCriticalPoints(Source);
    CheckPoints := LocalSource.CheckPoints;
    ColorAbove := LocalSource.ColorAbove;
    ColorBelow := LocalSource.ColorBelow;
    MaxValue := LocalSource.MaxValue;
    MinValue := LocalSource.MinValue;
  end
  else
    inherited Assign(Source);
end;

function TJvValidateEditCriticalPoints.IsCheckPointsStored: Boolean;
begin
  Result := (FCheckPoints <> FDefCheckPoints);
end;

function TJvValidateEditCriticalPoints.IsColorAboveStored: Boolean;
begin
  Result := (FColorAbove <> FDefColorAbove);
end;

function TJvValidateEditCriticalPoints.IsColorBelowStored: Boolean;
begin
  Result := (FColorBelow <> FDefColorBelow);
end;

procedure TJvValidateEditCriticalPoints.SetDefaults(
  ACheckPoints: TJvValidateEditCriticalPointsCheck; AColorAbove,
  AColorBelow: TColor);
begin
  FDefCheckPoints := ACheckPoints;
  FCheckPoints := ACheckPoints;
  FDefColorAbove := AColorAbove;
  FColorAbove := AColorAbove;
  FDefColorBelow := AColorBelow;
  FColorBelow := AColorBelow;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

