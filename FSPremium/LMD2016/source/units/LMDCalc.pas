unit LMDCalc;
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

LMDCalculator unit (JH)
----------------------
Calculator panel control. Panel containing inout btns and output label

Changes
-------
Release 8.05 (February 2008)
+ Parentbackground property

Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, Graphics, LMDButtonBase, LMDClass, LMDFXCaption,
  LMDButtonLayout, LMDGraph, LMDLabel, LMDSpeedButton, LMDStack,
  LMDEmbeddedObject, LMDCustomMaskEdit, LMDCustomPanelFill;

type
  TLMDCalcBtns = (cb0, cb1, cb2, cb3, cb4, cb5, cb6, cb7, cb8, cb9, cbPlus,
                  cbMinus, cbMUL, cbDIV, cbFloatDiv, cbMOD, cbEqual, cbClear,
                  cbBack, cbEuler, cbPI, cbSQR, cbSQRT, cbLN, cbEXP, cbPercent,
                  cbPower, cbStore, cbRCL, cbStorePlus, cbStoreMinus, cbKehr,
                  cbFac, cbDecimalDel, cbOpenBraket, cbCloseBraket, cbSIN,
                  cbCOS, cbTAN, cbINV);

  TLMDCalcWorkEvent = procedure (Sender : TObject; repLine : String) of object;
  TLMDManualBtnSetupEvent = procedure (Sender : TObject; aFont : TFont; aFontFX : TLMDFXCaption; aBtnLayout : TLMDButtonLayout; aGlyph : TBitmap; var aCaption : String; var aColor : TColor) of object;

  TLMDCustomCalculator = class (TLMDCustomPanelFill)
  private
    FSB0,
    FSB1,
    FSB2,
    FSB3,
    FSB4,
    FSB5,
    FSB6,
    FSB7,
    FSB8,
    FSB9,
    FSB_PLUS,
    FSB_MINUS,
    FSB_MUL,
    FSB_DIV,
    FSB_PERCENT,
    FSB_SIN,
    FSB_COS,
    FSB_TAN,
    FSB_E,
    FSB_PI,
    FSB_SQRT,
    FSB_SQR,
    FSB_XY,
    FSB_BACK,
    FSB_CLEAR,
    FSB_EX,
    FSB_LN,
    FSB_STORE,
    FSB_STOREPLUS,
    FSB_STOREMINUS,
    FSB_RCL,
    FSB_FAC,
    FSB_DELIM,
    FSB_KEHR,
    FSB_INV,
    FSB_OPENBRAKET,
    FSB_CLOSEBRAKET,
    FSB_EQUAL       : TLMDSpeedButton;
    FLABEL          : TLMDLabel;
    FBtnStyle       : TLMDUserButtonStyle;
    operands,
    values          : TLMDStack;
    FFrac,
    FDel            : Boolean;
    FOnWork         : TLMDCalcWorkEvent;
    FOnCalc         : TNotifyEvent;
    FStoredValue,
    FValue          : Extended;
    FDisplaySet     : TLMDEmbeddedObject;
    FLastZero,
    FDecimals       : Integer;
    FEditType       : TLMDNumberType;
    FBtnFont        : TFont;
    FOnManualBtnSetup: TLMDManualBtnSetupEvent;
    FPrecision      : Integer;

    procedure SetTheValue (aValue : Extended);
    procedure SetBtnStyle (aValue : TLMDUserButtonStyle);
    procedure SetDisplaySet (aValue : TLMDEmbeddedObject);
    procedure SetInteger (const Index, aValue: Integer);
    procedure SetEditType (aValue : TLMDNumberType);
    procedure SetFont(aValue : TFont);
    procedure ReadOldBtnStyle(Reader:TReader);
    function  ExtractTopValue: extended;
    function  ExtractTopOperand: TLMDCalcBtns;
    procedure PushValue(aValue: extended);
    procedure PushOperand(op: TLMDCalcBtns);
  protected
    procedure DefineProperties(Filer:TFiler);override;
    procedure DoGetValueSize (Sender : TObject; Item : Pointer; var size : Integer);
    procedure DoGetOperandSize (Sender : TObject; Item : Pointer; var size : Integer);
    procedure DoFreeItem (Sender : TObject; Item : Pointer);
    procedure DoThemeChanged;override;
    function calc : Boolean;
    procedure AddOperator (op : TLMDCalcBtns);
    procedure DoClick (Sender : TObject);
    procedure DoSimpleOp (op : TLMDCalcBtns);
    function GetValue : Extended;
    procedure SetValue (aValue : Extended);
    procedure SetText (const aValue : String);
    procedure report (op : TLMDCalcBtns);
    procedure Input (inputbtn : TLMDCalcBtns);
    procedure KeyPress (var Key : Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure GetChange (Sender : TObject); override;
    function  GetEmpty : Boolean; override;
    property ButtonStyle: TLMDUserButtonStyle read FBtnStyle write SetBtnStyle default ubsWin40;
    property ThemeMode default ttmNone;
    property Decimals : Integer index 1 read FDecimals write SetInteger default 1;
    property Precision : Integer index 2 read FPrecision write SetInteger default 15;
    property DisplaySettings : TLMDEmbeddedObject read FDisplaySet write SetDisplaySet;
    property EditType : TLMDNumberType read FEditType write SetEditType default ntFloat;
    property BtnFont : TFont read FBtnFont write SetFont;
    property ParentBackground default false;
    property Value : Extended read FValue write SetTheValue;
    property OnCalc : TNotifyEvent read FOnCalc write FOnCalc;
    property OnWork : TLMDCalcWorkEvent read FOnWork write FOnWork;
    property OnManualBtnSetup : TLMDManualBtnSetupEvent read FOnManualBtnSetup write FOnManualBtnSetup;
  public
    constructor Create (aOwner : TComponent); override;
    procedure Loaded; override;
    destructor Destroy; override;
    procedure DoKey (Key : Char);
    procedure ManualBtnChange;
    property BtnStyle : TLMDUserButtonStyle read FBtnStyle write SetBtnStyle;
    property CtlXP default false;  //compatibility
  end;

implementation

uses
  Variants, SysUtils;

{ ---------------------------------------------------------------------------- }
function LMDPower(Base, Exponent: Extended): Extended;
begin
  if Exponent = 0.0 then
    result := 1.0
  else
    if (Base = 0.0) and (Exponent > 0.0) then
      result := 0.0
     else
       result := exp(Exponent * ln(Base))
end;

{ ---------------------------------------------------------------------------- }
function LMDTan (X : Extended) : Extended;
begin
  result := sin(x) / cos (x);
end;

{ ----------------------------------- private -------------------------------- }
procedure TLMDCustomCalculator.SetTheValue (aValue : Extended);
begin
  if FValue <> aValue then
    begin
      FValue := aValue;
      SetValue (FValue);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.SetBtnStyle (aValue : TLMDUserButtonStyle);
var
  i : Integer;
begin
  if FBtnStyle <> aValue then
    begin
      FBtnStyle := aValue;
      for i := 0 to ComponentCount - 1 do
        if Components[i] is TLMDSpeedButton then
          TLMDSpeedButton(Components[i]).Style := FBtnStyle;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.SetDisplaySet (aValue : TLMDEmbeddedObject);
begin
  FDisplaySet.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.SetInteger (const Index, aValue: Integer);
begin
  case Index of
    1:
        if aValue <> FDecimals then
          FDecimals := aValue;
    2:
        if aValue <> FPrecision then
          FPrecision := aValue;
  else
    Assert(false);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.SetEditType (aValue : TLMDNumberType);
begin
  if aValue <> FEditType then
    FEditType := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.SetFont(aValue : TFont);
begin
  FBtnFont.Assign (aValue);
  GetChange (FBtnFont);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.ReadOldBtnStyle(Reader: TReader);
var
  tmp : Boolean;
begin
  LMDButtonReadExtStyle(Reader, FBtnStyle, tmp);
  CtlXP := tmp;
  DoThemeChanged;
end;

{ ----------------------------------- protected ------------------------------ }
procedure TLMDCustomCalculator.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('BtnStyle', ReadOldBtnStyle, nil, false);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.DoGetValueSize (Sender : TObject; Item : Pointer; var size : Integer);
begin
  size := sizeOf (Extended);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.DoGetOperandSize (Sender : TObject; Item : Pointer; var size : Integer);
begin
  size := sizeOf (TLMDCalcBtns);
//  size := 1;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.DoFreeItem (Sender : TObject; Item:Pointer);
begin

  Dispose (Pointer(item));

end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCalculator.calc : Boolean;
var
  v1, v2,
  e : Extended;
  op : TLMDCalcBtns;
begin
  result  := false;
  if operands.Count = 0 then exit;
  if values.Count < 2 then exit;
  result := true;
  e := 0;

  v2 := ExtractTopValue;
  v1 := GetValue;

  try
    op := ExtractTopOperand;

    case op of
      cbPlus : e := v1 + v2;
      cbMinus : e := v1 - v2;
      cbMul : e := v1 * v2;
      cbFloatDiv : e := v1 / v2;
      cbDiv : e := Trunc(v1) div Trunc (v2);
      cbMod : e := Trunc(v1) mod Trunc (v2);
      cbPower : e := LMDPower (v1, v2);
    end;
  except
    FLABEL.Caption := 'error';
    values.Clear;
    operands.Clear;
    PushValue(0.0);
    exit;
  end;

  SetValue (e);  //second last item will be overwritten

  FDel := true;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.AddOperator (op : TLMDCalcBtns);

  function  TopOperand: TLMDCalcBtns;
  begin

    Result := TLMDCalcBtns(Pointer(operands.Top)^);

  end;

begin
//help := false;
    begin
      FFrac := false;
      report(op);

      FDel := false;

      if not operands.isEmpty then
        begin
          if (op in [cbEqual, cbCloseBraket]) then
            begin
              while (operands.Count > 0) and (TopOperand <> cbOpenBraket) do
                {help := }calc;
              if not operands.isEmpty and (TopOperand = cbOpenBraket) then
                begin
                  ExtractTopOperand;
                end;
            end;

          if (op in [cbPlus, cbMinus])
              and (TopOperand in [cbPlus, cbMinus, cbMul, cbDiv, cbFloatDiv, cbMod]) then
            {help := }calc;
          if (op in [cbMul, cbDiv, cbFloatDiv, cbMod])
              and (TopOperand in [cbMul, cbDiv, cbFloatDiv, cbMod]) then
            {help := }calc;
        end;

    end;
  if not (op in [cbCloseBraket, cbEqual]) then
    begin
      PushOperand(op);

      if op <> cbOpenBraket then
        begin
          FDel := false;
          PushValue(0.0);
        end;
    end;
  if (op = cbEqual) and Assigned (FOnWork) then FOnWork (self, FloatToStr(GetValue));
  if (op = cbEqual) and Assigned (FOnCalc) then FOnCalc (self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.DoClick (Sender : TObject);
begin
  Input (TLMDCalcBtns(integer(TLMDSpeedButton(Sender).Tag)));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.DoThemeChanged;
 var
  i : Integer;
begin
  inherited;
  if {Showing and} (ComponentState * [csLoading, csReading] = []) then
    for i := 0 to ComponentCount - 1 do
      if (Components[i] is TLMDSpeedButton) then
        begin
          TLMDSpeedButton(Components[i]).ThemeMode := ttmNone;
          TLMDSpeedButton(Components[i]).ThemeMode := ThemeMode;
        end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.DoSimpleOp (op : TLMDCalcBtns);
var
  v,
  e : Extended;
  i : Integer;
begin
  FFrac := false;
  FDel := false;
  report(op);
  e := GetValue;
  try
    case op of
      cbKehr: e := 1 / e;
      cbSQR : e := SQR (e);
      cbSQRT: e := SQRT (e);
      cbSIN : e := SIN (e);
      cbCOS : e := COS (e);
      cbTAN : e := LMDTan (e);
      cbFAC : begin
                v := 1;
                for i := 2 to Trunc(e) do
                  v := v * i;
                e := v;
              end;
      cbINV : e := e * -1;
      cbLN  : e := ln(e);
      cbEXP : e := exp (e);
      cbPercent : e := e / 100;
      cbStore : FStoredValue := e;
      cbRcl : e := FStoredValue;
      cbStorePlus : FStoredValue := FStoredValue + e;
      cbStoreMinus : FStoredValue := FStoredValue - e;
    end;
  except
    FLABEL.Caption := 'error';
    values.Pop;
    PushValue(0.0);
    exit;
  end;
  SetValue (e);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCalculator.GetValue : Extended;
begin
{  s := FLABEL.Caption;
  s := LMDClearOffTS (s);
  if Pos (CurrencyString, s) <> 0 then
    Delete (s, Pos (CurrencyString, s) - 1, Length (CurrencyString) + 1);
  result := StrToFloat (s)}

  result := Extended(Pointer(values.Top)^);

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.SetValue (aValue : Extended);
var
  s : String;
  i : Integer;
begin
  FValue := aValue;

  case FEditType of
    ntCurrency : s := FloatToStrF (FValue, ffCurrency, FPrecision, {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}CurrencyDecimals);
    ntFloatNumber : s := FloatToStrF (FValue, ffNumber, FPrecision, Decimals);
    ntFloatFixed : s := FloatToStrF (FValue, ffFixed, FPrecision, Decimals);
    ntFloat : s := FloatToStrF (FValue, ffGeneral, FPrecision, Decimals);
    ntInteger : s := IntToStr (Trunc(FValue));
  end;

  if FFrac and (Pos ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, s) = 0) then
    s := s + ',';

  for i := 1 to FLastZero do
    s := s + '0';

  FLABEL.Caption := s;

  values.Pop;
  PushValue(aValue);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDCustomCalculator.SetText (const aValue : String);

begin
  FLABEL.Caption := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.report(op : TLMDCalcBtns);
var
  c : String;
begin
  if Assigned (FOnWork) then
    begin
      if not FDel then
        c := FloatToStr(GetValue)
      else
        c := '';
      case op of
        cbPlus : c := c + ' +';
        cbMinus : c := c + ' -';
        cbMul : c := c + ' *';
        cbFloatDiv : c := c + ' /';
        cbDiv : c := c + ' DIV';
        cbMod : c := c + ' MOD';
        cbPower : c := c + ' ^';
        cbSQR : c := c + '²';
        cbSQRT : c := 'SQRT('+c+')';
        cbPercent : c := c + ' / 100';
        cbLN : c := 'LN('+c+')';
        cbEXP : c := 'EXP('+c+')';
        cbSIN : c := 'SIN('+c+')';
        cbCOS : c := 'COS('+c+')';
        cbTAN : c := 'TAN('+c+')';
        cbFAC : if frac(GetValue) <> 0 then
                  c := 'trunc('+FloatToStr (trunc (GetValue))+')!'
                else
                  c := c + '!';
        cbINV : c := c + '* (-1)';
        cbKehr : c := '1 / ' + c;
        cbEqual : c := c + ' = ';
        cbOpenBraket : c := '(';
        cbCloseBraket : c := c + ')';
      end;
      FOnWork (self, c);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.Input (inputbtn : TLMDCalcBtns);
var
  s : String;

  //checks for 0 after the fraction delimiter, count them, and remeber the number
  procedure checkZero;
  var
    i : Integer;
  begin
    FLastZero := 0;
    if not FFrac then exit;
    i := Length(s);
    while s[i] = '0' do
      dec (i);
    FLastZero := Length(s) - i;
  end;

  //get the current edit string, which is the currently entered numeric value
  //a possible added fraction delimiter with a 0 fraction
  //and 0 after the fraction (without a number <> 0) terminating the 0 string!
  //the last two (fraction and zero) are removed by the FloatToStr method!
  function getString : String;
  var
    i : Integer;
  begin
    result := FloatToStr (GetValue);
    if FFrac then
      if Pos ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, result) = 0 then
        result := result + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator;

    if FFrac then
      for i := 1 to FLastZero do
        result := result + '0';
  end;

begin
  case inputbtn of
    cb0..cb9 : {if FDel then
                 begin
                   FDel := false;
                   SetValue (Ord(inputbtn));
                 end
               else
                 begin
                   s := FloatToStr (GetValue);
                   s := s + IntToStr (Ord(inputbtn));
                   if FFrac then
                     if Pos (DecimalSeparator, s) = 0 then
                       Insert (DecimalSeparator, s, Length (s));
                   SetValue (StrToFloat(s));
                 end;}
              begin
                s := getString;
                //if GetValue = 0 then s := '';
                s := s + IntToStr (Ord(inputbtn));

                checkZero;

                SetValue (StrToFloat(s));
{                if (inputbtn = cb0) and (Pos (DecimalSeparator, s) <> 0) then
                  FLABEL.Caption := s;}
              end;
    cbBack  : begin
                //s := FloatToStr (GetValue);
                s := getString;

                Delete (s, Length (s), 1);

                if Pos ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, s) = 0 then
                  FFrac := false;

                checkZero;

                if s = '' then s := '0';
                SetValue (StrToFloat(s));
              end;
    cbClear : begin
                FFrac := false;
                FLastZero := 0;
                values.Clear;
                PushValue(0.0);
                operands.Clear;
                SetValue (0);
              end;
    cbDecimalDel : if FEditType <> ntInteger then
                     begin
                       FFrac := true;
                       SetValue (GetValue);
{                       if pos (DecimalSeparator, FLABEL.Caption) = 0 then
                         if not FDel then
                           setText (FLABEL.Caption + DecimalSeparator)
                         else
                           setText ('0'+ DecimalSeparator);}
                     end;
    cbStore,
    cbRcl,
    cbStorePlus,
    cbStoreMinus,
    cbINV,
    cbSQR,
    cbKehr,
    cbSQRT,
    cbFAC,
    cbEXP,
    cbLN,
    cbSIN,
    cbCOS,
    cbPercent,
    cbTAN : DoSimpleOp (inputbtn);
    cbPI : SetValue (Pi);
    cbEuler : SetValue (exp(1));
  else
    AddOperator (inputbtn);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.KeyPress (var Key : Char);
begin
  inherited KeyPress (Key);
  case key of
    '0'..'9' : input (TLMDCalcBtns(StrToInt(Key)));
    #13,
    '=' : input (cbEqual);
    '+' : input (cbPlus);
    '-' : input (cbMinus);
    '*' : input (cbMul);
    '/' : input (cbFloatDiv);
    '²' : input (cbSQR);
    '!' : input (cbFac);
    ',','.' : if key = {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator then input (cbDecimalDel);
    #8 : input (cbBack);
    '^' : input (cbPower);
    '(' : input (cbOpenBraket);
    ')' : input (cbCloseBraket);
    '%' : input (cbPercent);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown (Button, Shift, X, Y);
  SetFocus;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.GetChange (Sender : TObject);
var
  i : Integer;
begin
  if Sender = FDisplaySet then
    begin
      FLABEL.Bevel.Assign (FDisplaySet.Bevel);
      FLABEL.Color := FDisplaySet.Color;
      FLABEL.Transparent := FDisplaySet.Transparent;
      FLABEL.Font.Assign (FDisplaySet.Font);
    end;
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TLMDSpeedButton then
      with (Components[i] as TLMDSpeedButton) do
        begin
           Font.Assign (FBtnFont);
           Style := FBtnStyle;
           ThemeMode := FThemeMode;
        end;
  inherited GetChange(Sender);
end;

{ ----------------------------------- public --------------------------------- }
function TLMDCustomCalculator.GetEmpty : Boolean;
begin
  result := false;
end;

{ ----------------------------------- public --------------------------------- }
procedure TLMDCustomCalculator.Loaded;
begin
  inherited Loaded;
  GetChange (FDisplaySet);
  SetValue (FValue);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDCustomCalculator.Create (aOwner : TComponent);
const
  leftBorder = 8;
  topBorder = 32;
  btnWidth = 22;
  btnHeight = 22;

    procedure createBtn (var btn : TLMDSpeedButton; Row, Col : Integer; Cap : String; bt : TLMDCalcBtns);
    begin
      btn := TLMDSpeedButton.Create (self);
      btn.Parent := self;
      btn.Left := leftBorder + Row * btnWidth;
      btn.Top := topBorder + Col * btnHeight;
      btn.Width := btnWidth;
      btn.OnClick := DoClick;
      btn.Tag := Ord(bt);
      btn.CtlXP:=false;
      if Cap <> '=' then
        btn.Height := btnHeight
      else
        btn.Height := btnHeight * 2;
      btn.Caption := Cap;
    end;

begin
  inherited Create (aOwner);
  //ControlStyle := ControlStyle + [csOpaque]-[csParentBackground, csAcceptsControls, csSetCaption];
  ControlStyle := ControlStyle + [csOpaque]{$IFDEF LMDCOMP7}-[csParentBackground]{$ENDIF}
                               - [csAcceptsControls, csSetCaption];
  {$IFNDEF LMDCOMP7}
  ParentBackground := false;
  {$ENDIF}

  FBtnStyle:=ubsWin40;
  FDel := false;

  FBtnFont := TFont.Create;
  FBtnFont.OnChange := GetChange;

  FLABEL := TLMDLabel.Create (self);
  FLABEL.Parent := self;
//  FLABEL.Bevel.Mode := bmEdge;
  FLABEL.AutoSize := false;
  FLABEL.Alignment := agTopRight;
  FLABEL.SetBounds (leftBorder, 6, 5 * btnWidth, topBorder - 12);
  FLABEL.Caption := '0';
{  FLABEL.Transparent := false;
  FLABEL.Color := clTeal;}

  createBtn (FSB_KEHR, 0, 0, '1/x', cbKehr);
  createBtn (FSB_SQR, 1, 0, 'x²', cbSQR);
  createBtn (FSB_SQRT, 2, 0, 'sqrt', cbSQRT);
  createBtn (FSB_BACK, 3, 0, '<-', cbBack);
  createBtn (FSB_CLEAR, 4, 0, 'C', cbClear);

  createBtn (FSB_FAC, 0, 1, 'x!', cbFac);
  createBtn (FSB_SIN, 1, 1, 'sin', cbSin);
  createBtn (FSB_COS, 2, 1, 'cos', cbSin);
  createBtn (FSB_TAN, 3, 1, 'tan', cbTan);
  createBtn (FSB_XY, 4, 1, 'x^y', cbPower);

  createBtn (FSB_E, 0, 2, 'e', cbEuler);
  createBtn (FSB_EX, 1, 2, 'e^x', cbEXP);
  createBtn (FSB_LN, 3, 2, 'ln', cbLN);
  createBtn (FSB_DIV, 4, 2, '/', cbFloatDiv);

  createBtn (FSB_PI, 0, 3, 'pi', cbPI);
  createBtn (FSB_PERCENT, 1, 3, '%', cbPercent);
  createBtn (FSB_OPENBRAKET, 2, 3, '(', cbOpenBraket);
  createBtn (FSB_CLOSEBRAKET, 3, 3, ')', cbCloseBraket);
  createBtn (FSB_MUL, 4, 3, '*', cbMUL);

  createBtn (FSB_STORE, 0, 4, '>M', cbStore);
  createBtn (FSB7, 1, 4, '7', cb7);
  createBtn (FSB8, 2, 4, '8', cb8);
  createBtn (FSB9, 3, 4, '9', cb9);
  createBtn (FSB_MINUS, 4, 4, '-', cbMinus);

  createBtn (FSB_RCL, 0, 5, 'M>', cbRCL);
  createBtn (FSB4, 1, 5, '4', cb4);
  createBtn (FSB5, 2, 5, '5', cb5);
  createBtn (FSB6, 3, 5, '6', cb6);
  createBtn (FSB_PLUS, 4, 5, '+', cbPLUS);

  createBtn (FSB_STOREPLUS, 0, 6, 'M+', cbStorePlus);
  createBtn (FSB1, 1, 6, '1', cb1);
  createBtn (FSB2, 2, 6, '2', cb2);
  createBtn (FSB3, 3, 6, '3', cb3);
  createBtn (FSB_EQUAL, 4, 6, '=', cbEqual);
//  FSB_EQUAL.Height := btnHeight * 2;

  createBtn (FSB_STOREMINUS, 0, 7, 'M-', cbStoreMinus);
  createBtn (FSB0, 1, 7, '0', cb0);
  createBtn (FSB_DELIM, 2, 7, {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, cbDecimalDel);
  createBtn (FSB_INV, 3, 7, '+/-', cbINV);

  values := TLMDStack.Create;
  values.OnGetItemSize := DoGetValueSize;
  values.OnDestroyItem := DoFreeItem;
  //generate first item on stack
  PushValue(0.0);

  operands := TLMDStack.Create;
  operands.OnGetItemSize := DoGetOperandSize;
  operands.OnDestroyItem := DoFreeItem;

  FDisplaySet := TLMDEmbeddedObject.Create;
  FDisplaySet.OnChange := GetChange;

  FPrecision := 15;
  FDecimals := 1;
  FEditType := ntFloat;
  FFrac := false;
  FThemeMode := ttmNone;
  Bevel.Mode := bmStandard;
  Width := BtnWidth * 5 + leftBorder * 2;
  Height := BtnHeight * 8 + topBorder + leftBorder;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomCalculator.Destroy;

   procedure FreeBtn(var btn : TLMDSpeedButton);
   begin
     btn.OnClick := nil;
     btn.Free;
     btn := nil;
   end;

begin
  FBtnFont.OnChange := nil;
  FBtnFont.Free;

  FDisplaySet.OnChange := nil;
  FDisplaySet.Free;

  values.Clear; //clear before resetting OnDestroyItem
  values.OnGetItemSize := nil;
  values.OnDestroyItem := nil;

  operands.Clear; //clear before resetting OnDestroyItem
  operands.OnGetItemSize := nil;
  operands.OnDestroyItem := nil;
  values.Free;
  operands.Free;
  FLABEL.Free;

  FreeBtn(FSB_KEHR);
  FreeBtn(FSB_SQR);
  FreeBtn(FSB_SQRT);
  FreeBtn(FSB_BACK);
  FreeBtn(FSB_CLEAR);

  FreeBtn(FSB_FAC);
  FreeBtn(FSB_SIN);
  FreeBtn(FSB_COS);
  FreeBtn(FSB_TAN);
  FreeBtn(FSB_XY);

  FreeBtn(FSB_E);
  FreeBtn(FSB_EX);
  FreeBtn(FSB_LN);
  FreeBtn(FSB_DIV);

  FreeBtn(FSB_PI);
  FreeBtn(FSB_PERCENT);
  FreeBtn(FSB_OPENBRAKET);
  FreeBtn(FSB_CLOSEBRAKET);
  FreeBtn(FSB_MUL);

  FreeBtn(FSB_STORE);
  FreeBtn(FSB7);
  FreeBtn(FSB8);
  FreeBtn(FSB9);
  FreeBtn(FSB_MINUS);

  FreeBtn(FSB_RCL);
  FreeBtn(FSB4);
  FreeBtn(FSB5);
  FreeBtn(FSB6);
  FreeBtn(FSB_PLUS);

  FreeBtn(FSB_STOREPLUS);
  FreeBtn(FSB1);
  FreeBtn(FSB2);
  FreeBtn(FSB3);
  FreeBtn(FSB_EQUAL);

  FreeBtn(FSB_STOREMINUS);
  FreeBtn(FSB0);
  FreeBtn(FSB_DELIM);
  FreeBtn(FSB_INV);

  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.DoKey (Key : Char);
begin
  KeyPress (Key);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalculator.ManualBtnChange;
var
  i          : Integer;
  aFont      : TFont;
  aFontFX    : TLMDFXCaption;
  aBtnLayout : TLMDButtonLayout;
  aGlyph     : TBitmap;
  aCaption   : String;
  aColor     : TColor;
begin
  aFont := TFont.Create;
  aFontFX := TLMDFXCaption.Create;
  aBtnLayout := TLMDButtonLayout.Create;
  aGlyph := TBitmap.Create;
  try

   for i := 0 to ComponentCount - 1 do
     if Components[i] is TLMDSpeedButton then
       with (Components[i] as TLMDSpeedButton) do
         begin
            aFont.Assign (Font);
            aFontFX.Assign (FontFX);
            aBtnLayout.Assign (ButtonLayout);
            aGlyph.Assign (Glyph);
            aCaption := Caption;
            aColor := Color;
            FOnManualBtnSetup (self, aFont, aFontFX, aBtnLayout, aGlyph, aCaption, aColor);
            Font.Assign (aFont);
            FontFX.Assign  (aFontFX);
            ButtonLayout.Assign (aBtnLayout);
            Glyph.Assign (aGlyph);
            Caption := aCaption;
            Color := aColor;
         end;
  finally
    aFont.Free;
    aFontFX.Free;
    aBtnLayout.Free;
    aGlyph.Free;
  end;
end;

function  TLMDCustomCalculator.ExtractTopValue: extended;
var
  newE : ^Extended;
begin
  //extract the last value from the value stack
  newE := Pointer(values.extractTop);
  //get the value
  Result := newE^;
  //release the pointer
  Dispose(newE);
end;

procedure TLMDCustomCalculator.PushValue(aValue: extended);
var
  newE : ^Extended;
begin
  New(newE);
  newE^ := aValue;
  values.Push(newE);
end;

function  TLMDCustomCalculator.ExtractTopOperand: TLMDCalcBtns;
var
  p_op : ^TLMDCalcBtns;
begin
  p_op := Pointer(operands.extractTop);
  Result := p_op^;
  Dispose (p_op);
end;

procedure TLMDCustomCalculator.PushOperand(op: TLMDCalcBtns);
var
  p_op : ^TLMDCalcBtns;
begin
  New(p_op);
  p_op^ := op;
  operands.Push(p_op);
end;

end.
