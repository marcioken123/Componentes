unit LMDCurrencySettings;
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

LMDCurrencySettings unit (JH)
-----------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDTypes,
  LMDObject;

type
  TLMDCurrencyMode = (cmSystem, cmUser);

  TLMDCurrencySettings = class (TLMDObject)
  private
    FSystem            : TLMDCurrencyMode;
    FPosFormatStr,
    FNegFormatStr,
    FSymbol            : TLMDString;
    FGroup,
    FDigits            : Byte;
    FCurrencyGroup,
    FFractionDelim     : TLMDChar;
    FNegFormatSignature: TLMDString;
    FNegFormatContainsMinus: boolean;

    procedure SetSystemDefaults (aValue : TLMDCurrencyMode);
    function IsStored : Boolean;
    procedure SetNegativeFormatStr(const Value: TLMDString);
    procedure SetPositiveFormatStr(const Value: TLMDString);
    procedure SetSymbol(const Value: TLMDString);
  protected
    procedure UpdateNegFormatSignature;
  public
    constructor Create(Owner:TPersistent=nil); override;
    procedure LoadDefaults;
    procedure Assign (Source : TPersistent); override;
    function toStr (cur : Currency) : TLMDString; overload;
    function toStr (cur : Currency; minus:boolean) : TLMDString; overload;

    function toCur (s : TLMDString) : Currency;
    function IsNegative(s : TLMDString): boolean;
    //determine position of first digit of currency value
    function firstDigitPos (cur: Currency): Integer;
    property Digits : Byte read FDigits write FDigits stored IsStored;
    property GroupDelim : TLMDChar read FCurrencyGroup write FCurrencyGroup stored IsStored;
    property FractionDelim : TLMDChar read FFractionDelim write FFractionDelim stored IsStored;
  published
    property SystemDefaults : TLMDCurrencyMode read FSystem write SetSystemDefaults stored IsStored;
    property PositiveFormatStr : TLMDString read FPosFormatStr write SetPositiveFormatStr stored IsStored;
    property NegativeFormatStr : TLMDString read FNegFormatStr write SetNegativeFormatStr stored IsStored;
    property Symbol : TLMDString read FSymbol write SetSymbol stored IsStored;
  end;

  //build up a currency string with user defined, system independent formatting rules
  function LMDCurrToStr (cur : Currency; CurrencySymbol, PosFormatStr, NegFormatStr : TLMDString; CurrencyDelim, GroupDelim : TLMDChar; Decimals, GroupSize : Byte) : TLMDString; overload;
  function LMDCurrToStr (cur : Currency; CurrencySymbol, PosFormatStr, NegFormatStr : TLMDString; CurrencyDelim, GroupDelim : TLMDChar; Decimals, GroupSize : Byte; Minus: boolean) : TLMDString; overload;

implementation

uses
  SysUtils,
  LMDStrings,
  LMDSysIn;

//groups a floating point number according to the given parameters and returns
//the result as grouped floating pointer nubmer string
//fValue: the value to be grouped
//FloatDelim: the delimiter char used for delimiting the int part fromt he fraction
//GroupDelim: the delimiter char used for delimiting groups of numbers (usually thousands)
//GroupSize: the number of chars within one group (usually 3 - thousands)
//Decimals: Number of decimals the floating point number shall have (number of
//          existing decimals will be decreased or increased for matching this number)
function LMDGroupFloat (fValue : Double; FloatDelim, GroupDelim : TLMDChar; GroupSize, Decimals : Byte) : TLMDString;
var
  dp,
  i : LongInt;
  b : Boolean;
begin
  b := false;
  result := FloatToStr (fValue);
  dp := Length(result);

  //dp = length of result

  if (Pos ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, result) <> 0) then
    begin
      dp := Pos ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, result);
      while Length (result) - dp > Decimals do //remove decimals which are not wanted
        Delete (result, Length(result), 1);
      result [dp] := FloatDelim;
    end;

  //dp = length of result | position of decimal separator

  //check whether there are enough decimals, if not add them
  if Decimals > Length(result) - dp then
    begin
      i := Length(result) - dp;
      if Pos (FloatDelim, result) = 0 then
        begin
          result := result + FloatDelim;
          inc(dp);
        end;
      while i < Decimals do
        begin
          result := result + '0';
          inc(i);
        end;
    end;
  //if we do not have any fraction we'll move dp on the char one forward
  //usually length + 1
  if Pos (FloatDelim, result) = 0 then inc(dp);
  //if we have a negative result prepare the result for inserting the grouping char
  //remove the negative sign, decrement dp (one char less in result)
  if result[1] = '-' then
    begin
      b := true;
      Delete (result, 1, 1);
      dec (dp);
    end;
  //insert the group delimiters
  i := dp - GroupSize;
  while (i > 1) do
    begin
      Insert (GroupDelim, result, i);
      dec(i, GroupSize);
    end;
  //b was set if result is a negative number. Reinsert the previously removed
  //negative symbol
  if b then
    result := '-'+result;
end;

function LMDCurrToStr (cur : Currency; CurrencySymbol, PosFormatStr, NegFormatStr : TLMDString; CurrencyDelim, GroupDelim : TLMDChar; Decimals, GroupSize : Byte) : TLMDString;
begin
  result := LMDCurrToStr (cur, CurrencySymbol, PosFormatStr, NegFormatStr, CurrencyDelim, GroupDelim, Decimals, GroupSize, false);
end;

function LMDCurrToStr (cur : Currency; CurrencySymbol, PosFormatStr, NegFormatStr : TLMDString; CurrencyDelim, GroupDelim : TLMDChar; Decimals, GroupSize : Byte; Minus: boolean) : TLMDString; overload;
var
  hStr,
  fStr : TLMDString;
begin
  result := '';
  if cur = 0 then
    begin
      if Minus then
        fStr := NegFormatStr
      else
        fStr := PosFormatStr;
    end
  else  
  if cur > 0 then
    fStr := PosFormatStr
  else
    fStr := NegFormatStr;
  while fStr <> '' do
    begin
      case fStr[1] of
        '¤' : result := result + CurrencySymbol;
        '1' : begin
                hStr := LMDGroupFloat (cur, CurrencyDelim, GroupDelim, GroupSize, Decimals);
                //the minus will be placed through the format string !!
                if Pos ('-', hStr) <> 0 then
                  Delete (hStr, Pos ('-', hStr), 1);
                result := result + hStr;
                //delete 1,1
                Delete (fStr, 1, 2);
              end;
        else
          result := result + fStr[1];
      end;
      Delete (fStr, 1, 1);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCurrencySettings.SetSystemDefaults (aValue : TLMDCurrencyMode);
begin
  if aValue <> FSystem then
    begin
      FSystem := aValue;
      if FSystem = cmSystem then
        LoadDefaults;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCurrencySettings.IsNegative(s: TLMDString): boolean;
var
  i: integer;
  s1: TLMDString;
  d: TLMDString;
begin
  s1 := '';
  result := false;

  d := char(FCurrencyGroup) + char(FFractionDelim) + '0123456789';
  if Pos('-', FNegFormatStr) = 0 then
    d := '-' + d;

  for i := 1 to length(s) do
    if Pos(s[i], d) = 0 then
      s1 := s1 + s[i];

  if s1 = FNegFormatSignature then
    result := true;
end;

function TLMDCurrencySettings.IsStored : Boolean;
begin
  //return true if currency settings must be stored
  result := (FSystem = cmUser);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCurrencySettings.SetNegativeFormatStr(const Value: TLMDString);
begin
  if Value <> FNegFormatStr then
    begin
      FNegFormatStr := Value;
    UpdateNegFormatSignature;
      GetChange (nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCurrencySettings.SetPositiveFormatStr(const Value: TLMDString);
begin
  if Value <> FPosFormatStr then
    begin
      FPosFormatStr := Value;
      GetChange (nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCurrencySettings.SetSymbol(const Value: TLMDString);
begin
  if Value <> FSymbol then
    begin
      FSymbol := Value;
      GetChange (nil);
    end;
end;

{ --------------------------------- protected -------------------------------- }
{ ---------------------------------------------------------------------------- }
constructor TLMDCurrencySettings.Create;
begin
  inherited Create;
  FNegFormatContainsMinus := true;
  FSystem := cmSystem;
  FGroup := 3;
  LoadDefaults;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCurrencySettings.LoadDefaults;
var
  s : TLMDString;
begin
  FSymbol := LMDGetLocalInfo (13);

  // 7.0.61 RM -> StrToInt replaced by StrToIntDef (defaults taken from English (USA))
  s := LMDGetLocalInfo (8);
  case StrToIntDef (s,0) of
    0 : FNegFormatStr := '(¤1,1)';
    1 : FNegFormatStr := '-¤1,1';
    2 : FNegFormatStr := '¤-1,1';
    3 : FNegFormatStr := '¤1,1-';
    4 : FNegFormatStr := '(1,1¤)';
    5 : FNegFormatStr := '-1,1¤';
    6 : FNegFormatStr := '1,1-¤';
    7 : FNegFormatStr := '1,1¤-';
    8 : FNegFormatStr := '-1,1 ¤';
    9 : FNegFormatStr := '-¤ 1,1';
    10 : FNegFormatStr := '1,1 ¤-';
    11 : FNegFormatStr := '¤ 1,1-';
    12 : FNegFormatStr := '¤ -1,1';
    13 : FNegFormatStr := '1,1- ¤';
    14 : FNegFormatStr := '(¤ 1,1)';
    15 : FNegFormatStr := '(1,1 ¤)';
  end;

  s := LMDGetLocalInfo (2);
  case StrToIntDef (s,0) of
    0 : FPosFormatStr := '¤1,1';
    1 : FPosFormatStr := '1,1¤';
    2 : FPosFormatStr := '¤ 1,1';
    3 : FPosFormatStr := '1,1 ¤';
  end;

  s := LMDGetLocalInfo (20);
  FGroup := StrToIntDef (Copy (s, 1, Pos (';', s) -1), 3);

  s := LMDGetLocalInfo (1);
  FDigits := StrToIntDef (s, 2);

  s := LMDGetLocalInfo (15);
  FFractionDelim := s[1];

  s := LMDGetLocalInfo (21);
  FCurrencyGroup := s[1];
  
  UpdateNegFormatSignature;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCurrencySettings.Assign (Source : TPersistent);
var
  S: TLMDCurrencySettings;
begin
  if Source is TLMDCurrencySettings then
    begin
      S := TLMDCurrencySettings(Source);
      SystemDefaults := S.SystemDefaults;
      if SystemDefaults = cmUser then
        begin
          FSymbol := S.Symbol;
          FDigits := S.Digits;
          FFractionDelim := S.FractionDelim;
          FCurrencyGroup := S.GroupDelim;
          FPosFormatStr := S.PositiveFormatStr;
          FNegFormatStr := S.NegativeFormatStr;
          //FGroup := S.CurrencySymbol;
        end;
    end
  else
    inherited Assign (source);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCurrencySettings.toStr (cur : Currency; minus:boolean) : TLMDString;
begin
  result := LMDCurrToStr (cur, FSymbol, FPosFormatStr, FNegFormatStr, FFractionDelim, FCurrencyGroup, FDigits, FGroup, minus);
end;

procedure TLMDCurrencySettings.UpdateNegFormatSignature;
var
  i : integer;
  d: TLMDString;
begin
  FNegFormatSignature := '';
  d := FSymbol + FFractionDelim + '1' + '¤';
  for i := 1 to length(FNegFormatStr) do
  begin
    if Pos(FNegFormatStr[i], d) = 0 then
      FNegFormatSignature := FNegFormatSignature + FNegFormatStr[i];
    if FNegFormatStr[i] = '¤' then
      FNegFormatSignature := FNegFormatSignature + FSymbol;
  end;
  if Pos('-', FNegFormatSignature) >= 0 then
    FNegFormatContainsMinus := true
  else
    FNegFormatContainsMinus := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCurrencySettings.toStr (cur : Currency) : TLMDString;
begin
  result := LMDCurrToStr (cur, FSymbol, FPosFormatStr, FNegFormatStr, FFractionDelim, FCurrencyGroup, FDigits, FGroup, false);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCurrencySettings.toCur (s : TLMDString) : Currency;
var
   sgn,mc,i : Integer;
   lSign: integer;
begin
  if s = '' then begin result := 0; exit; end;
  lSign := 1;
  if not FNegFormatContainsMinus and IsNegative(s) then lSign := -1;
  i := 1;
  //direct removing of symbol added April 04 by JH
  if Pos (Symbol, s) <> 0 then
    Delete (s, Pos (Symbol, s), Length(Symbol));
  //<-- VB April 2006 Minus count
  mc := 0;
  //-->
  while i <= Length (s) do
    begin
      if s[i] = '-' then
        inc(mc);
      if LMDCharInSet(s[i], ['0'..'9']) then
        inc(i)
      else
        if s[i] = FractionDelim then
          begin

            s[i] := TLMDChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator);

            inc(i);
          end
        else
          Delete (s, i, 1);
    end;
  try
    if s <> '' then
      begin
        result := StrToFloat (s);
        //<-- VB April 2006 Now minus can be pressed anywhere in the text
        sgn := - 2*(mc mod 2) + 1;
        result := lSign * sgn * abs(result);
        //-->
      end
    else
      result := 0;
  except
    result := 0;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCurrencySettings.firstDigitPos(cur: Currency): Integer;
var
  s: String;
  i: Integer;
begin
  result := 0;
  if cur < 0 then
    s := FNegFormatStr
  else
    s := FPosFormatStr;
  i := 1;
  while (i <= Length(s)) and (s[i] <> '1') do inc(i);
  if (i <= Length (s)) and (s[i] = '1') then result := i;
end;

end.
