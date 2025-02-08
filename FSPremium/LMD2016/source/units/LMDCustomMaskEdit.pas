unit LMDCustomMaskEdit;
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

LMDCustomMaskEdit unit (JH)
---------------------------

Masked Textinput control (for date, float, integer, masked strings input)

Changes
-------
Release 8.06 (March 2008)

 + UnMaskedText property added

-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LMDTypes, LMDBaseEdit, LMDCustomEdit, LMDClass, LMDProcs, LMDCurrencySettings,
  LMDDateFormat, LMDTimeFormat;

{$IFNDEF LMDCOMP7}
const
  HoursPerDay   = 24;
  MinsPerHour   = 60;
  SecsPerMin    = 60;
  MSecsPerSec   = 1000;
  MinsPerDay    = HoursPerDay * MinsPerHour;
  SecsPerDay    = MinsPerDay * SecsPerMin;
  MSecsPerDay   = SecsPerDay * MSecsPerSec;
{$ENDIF}


type
  //all possible mask styles
  TLMDMaskType = (meInteger, meWord, meFloat, meFloatFixed, meFloatNumber, meCurrency, meDate, meTime, meMask, meNone, meDateTime);
  //sample of mask styles, needed by some derived controls
  TLMDNumberType = (ntInteger, ntFloat, ntFloatFixed, ntFloatNumber, ntCurrency);

  TLMDNumberBase = 2..36;

  ELMDWrongDataType = class(Exception);

  { Mask (string)

    a - allows any alphabetic char (lowercased)
    A - allows any alphabetic char (uppercased)
    b - allows any alphabetic char (lowercased and uppercased)

    c - allows any alphanumeric char
    r - user rule
    v - +/-
    # - +/-/numerical including 0
    * - +/-/numerical excluding 0
    0 - allows every numerical char including 0
    9 - allows every numerical char excluding 0
    8 - allows every numerical char plus space
    1 - 0 or 1

    \x - any char to be displayed - to be displayed a literal x
    ! - permit the following kind of char
  }

  TLMDParsedMaskRecord = class//record
    chars : set of AnsiChar; // all chars allowed here
    inputallowed : boolean; //is false if there was a \x char in the Mask
    rangecheck : boolean; //if there is a group of numeric values which should not exceed a special range this is true
    top, bottom : integer; //if rangecheck is true it contains the range for the numeric group
    next, prev : TLMDParsedMaskRecord;
  end;

  {$IFDEF LMD_UNICODE}
  TLMDOnUserRule = procedure (Sender : TObject; var Ok : Boolean; c : WideChar; at : Integer) of Object;
  {$ELSE}
  TLMDOnUserRule = procedure (Sender : TObject; var Ok : Boolean; c : Char; at : Integer) of Object;
  {$ENDIF}
  TLMDOnRangeError = procedure (Sender: TObject; Lower, Upper: Double; var Value: Extended) of Object;

  TLMDCustomMaskEdit = class(TLMDCustomEdit)
  private
    FEditMode: TLMDEditModes; 
    FSuffix,
    FMask       : TLMDString;
    FNumberBase : TLMDNumberBase;
    FOnUserRule : TLMDOnUserRule;
    FForceMaskCheck,
    FRangeCheck : Boolean;
    FThousandDelim,
    FDecimalDelim: TLMDChar;
    FBlankChar  : Char;
    //if ProcessBlankChar = true then user can type in char = BlankChar and
    //OnUserRule is triggered when BlankChar is entered
    FProcessBlankChar: boolean;
    //Setting this property to true suppresses autinsert of black char when user
    //presses Delete or BackSpace. False by default
    FSuppressBlankCharOnDelete: boolean;
    FDecimals   : Integer;
    FSavedDateTime  : TDateTime;
    FDateSet    : TLMDDateFormat;
    FTimeSet    : TLMDTimeFormat;
    FCurSet     : TLMDCurrencySettings;
    FTDelims, //introd, Nov 2001
    dep_help,
    dep         : Integer;
    FMinValue,
    FMaxValue   : Double;
    FOnRangeError: TLMDOnRangeError;
    FOnError: TNotifyEvent;
    FMinus : boolean;
    FCommandKey: word;

    procedure SetMask (aValue : TLMDString);
    procedure SetMaskType (aValue : TLMDMaskType);
    procedure SetNumberBase (aValue : TLMDNumberBase);
    procedure SetBlankChar (aValue : Char);
    procedure SetProcessBlankChar (aValue : boolean);
    procedure SetInteger (index, aValue : Integer);
    procedure SetDouble (index : Integer; aValue : Double);
    procedure SetCurSet (aValue : TLMDCurrencySettings);
    procedure SetDateFormat (aValue : TLMDDateFormat);
    procedure SetTimeFormat (aValue : TLMDTimeFormat);
    procedure SetSuffix (aValue: TLMDString);
    procedure SetForceMaskCheck(const Value: boolean);
    procedure SetForceOverwriteMode(const Value: boolean);

    procedure WMChar (var Msg : TWMChar); message WM_CHAR;
    procedure WriteData (Writer : TWriter);
    procedure ReadData (Reader : TReader);

    function literalChars : TLMDString;
    function inputCharsAllowedAt (at : Integer) : Integer;
    //check whether char c is allowed
    function RealCharAllowedAt (at : Integer; c : TLMDChar) : Boolean;
    //check whether char c or blank is allowed
    function CharAllowedAt (at : Integer; c : TLMDChar) : Boolean;
    //are all chars with a ! entered?
    function NeededEntered (s : TLMDString) : Integer;
    function getCharAt (at : Integer) : TLMDChar;
    //text string s valid to mask?
    function checkText (s : TLMDString) : boolean;

    //get entered text without literals (including blanks)
//    function clearedText : String;
    //get string (matching to mask) from text retrieved by clearedText
//    function setClearText(clearText : String) : String;

    procedure WMKILLFOCUS (var Message : TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSETFOCUS (var Message : TWMSetFocus); message WM_SETFOCUS;
    function GetAsInteger : Integer;
    function GetAsCardinal : Cardinal;
    function GetAsInt64 : Int64;
    function GetAsFloat : Double;
    function GetAsDate : TDateTime;
    function GetAsTime : TDateTime;
    function GetAsDateTime : TDateTime;
    function GetAsCurrency : Double;
    function GetAsString : TLMDString;
    procedure SetAsCardinal(const Value: Cardinal);
    procedure SetAsCurrency(const Value: Double);
    procedure SetAsFloat(const Value: Double);
    procedure SetAsInt64(const Value: Int64);
    procedure SetAsInteger(const Value: Integer);
    procedure SetAsString(const Value: TLMDString);
    procedure SetAsTime(const Value: TDateTime);
    procedure SetAsDate(const Value: TDateTime);
    procedure SetAsDateTime(const Value: TDateTime);
    function GetUnMaskedText: TLMDString;
    procedure SetUnMaskedText(aValue: TLMDString);
    procedure SetSuppressBlankCharOnDelete(const aValue: boolean);
  protected
    FOldText: TLMDString;
    FMaskType : TLMDMaskType;
    function GetEmptyText: TLMDString; override;
    function GetValueToValidate: TLMDString; override;
    //is char at pos charPos in FText literal?
    function isLiteral (charPos : Integer) : Boolean;

    procedure Loaded; override;
    procedure HandleInsertText (at : Integer; var aValue : TLMDString); override;
    procedure HandleReplaceText (at : Integer; aValue : TLMDString); override;
    procedure BeforeChangeText; override;
    procedure FinishedSetSelText; override;
    procedure ChangedText (At : Integer); override;
    procedure CreateSpecialText(var s : TLMDString); override;
    procedure DefineProperties (Filer : TFiler); override;
    procedure DoValidationError;virtual;
    procedure CursorPosChanged; override;
    procedure GetCommandKey (var KeyCode : Word; Shift : TShiftState); override;
    procedure DateTimeInc(aStep: integer); virtual;
    procedure DateTimeDec(aStep: integer); virtual;

    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean; override;
    procedure ToDate (step: Integer); //aded April 02 by JH
    procedure ToTime (step: Integer);
    function AllowedOperation(textToInsert : TLMDString) : Boolean; override;
    procedure GetChange (Sender : TObject); override;
    function IsTextStored: boolean;
    function CalcMousePos(Pos : TSmallPoint) : Integer; override;

    procedure DateFormatChange (Sender : TObject);
    procedure DateFormatChanged (Sender : TObject);
    function DateTimeString(aDatetime: TDatetime): TLMDString;

    //checks whether the current numerical input is in between of MinValue and MaxValue
    procedure CheckNumberRange;
    //returns the suffix added to the edit string - will return an empty string
    //if suffix is not supported by the current masktype
    function GetSuffix: TLMDString;

    property Decimals : Integer index 0 read FDecimals write SetInteger default 1;
    //suffix can be a measure unit (as an example), will be added to the edit
    //string (supported masktypes only)
    property Suffix: TLMDString read FSuffix write SetSuffix;
    //lower border of input value -> here only checked on control exit
    property MinValue: Double index 1 read FMinValue write SetDouble;
    //upper border of input value -> here only checked on control exit
    property MaxValue: Double index 2 read FMaxValue write SetDouble;
    //if RangeCheck is disabled the control will not check a numerical input value
    //for beeing in MinValue .. MaxValue
    property RangeCheck: Boolean read FRangeCheck write FRangeCheck;
    //this event gets executed if a range error is detected
    //a programmer can return a default value for this case
    //otherwise (according) to side of bounds error MinValue or MaxValue is used
    property OnRangeError: TLMDOnRangeError read FOnRangeError write FOnRangeError;
    property ForceMaskCheck: boolean read FForceMaskCheck write SetForceMaskCheck default false;
    property ForceOverwriteMode: boolean read FForceOverwriteMode write SetForceOverwriteMode default false;
  public
    property AsInteger : Integer read GetAsInteger  write SetAsInteger;
    property AsCardinal : Cardinal read GetAsCardinal write SetAsCardinal;
    property AsInt64 : Int64 read GetAsInt64 write SetAsInt64;
    property AsFloat : Double read GetAsFloat write SetAsFloat;
    property AsDate : TDateTime read GetAsDate write SetAsDate;
    property AsTime : TDateTime read GetAsTime write SetAsTime;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsCurrency : Double read GetAsCurrency write SetAsCurrency;
    property AsString : TLMDString read GetAsString write SetAsString;

    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    function NextEditChar : Integer;
    function PrevEditChar : Integer;

    function FormatTextByMask(const AUnMaskedText: TLMDString): TLMDString;

    // 7.03
    procedure ForceMaskValidation;
    // ----

    //check cut operation -> do not cut the suffix out
    procedure CutToClipboard; override;
    //check paste operation -> do not replace the suffix
    procedure PasteFromClipboard; override;

    //returns content of Text (without suffix if present)
    function GetPureText: TLMDString;
    //sets given aValue as new text and adds the suffix
    procedure SetTextWithSuffix (aValue: TLMDString);

    //new, May 2002
    //sets the given value, using the actual formatting settings
    //this method can be used for setting integer and word values, too.
    procedure SetValue (aValue: Double);

    property CurrencySettings : TLMDCurrencySettings read FCurSet write SetCurSet;
    property DateSettings : TLMDDateFormat read FDateSet write SetDateFormat;
    property TimeSettings : TLMDTimeFormat read FTimeSet write SetTimeFormat;
    property Mask : TLMDString read FMask write SetMask;
    property MaskType : TLMDMaskType read FMaskType write SetMaskType default meMask;
    property NumberBase : TLMDNumberBase read FNumberBase write SetNumberBase default 10;
    property BlankChar : Char read FBlankChar write SetBlankChar default '_';
    property ProcessBlankChar: boolean read FProcessBlankChar write SetProcessBlankChar default false;
    property SuppressBlankCharOnDelete: boolean read FSuppressBlankCharOnDelete write SetSuppressBlankCharOnDelete default false;
    property Text stored IsTextStored;
    property UnMaskedText: TLMDString read GetUnMaskedText write SetUnMaskedText;

    property OnUserRule : TLMDOnUserRule read FOnUserRule write FOnUserRule;
  published
    property OnValidationError:TNotifyEvent read FOnError write FOnError;
  end;

  //X ^ I
  function LMDIntPower(X: Extended; I: Integer): Extended;
  //string s is a number with base -> returns decimal int value of s
  function LMDGetDecimalValue (base : Integer; s : TLMDString) : Int64;
  //string source is a floatnumber with base -> returns decimal float value of s
  function LMDGetDecimalFloatValue (base : Integer; source : TLMDString) : Double;
  //value is a 10 based int, returns value as string with base
  function LMDGetBaseString (base, value : Integer) : TLMDString;
  //clears out all thousand separators
  function LMDClearTS (s : TLMDString) : TLMDString;

  //converts a VCL mask to a LMD mask (no 1:1 conversion!!)
  function convertVCLMask2LMDMask (aMask : TLMDString) : TLMDString;
  //converts float value to a string
  //Note: LMDFloatToStrF has a number of differences with FloatToStrF
  //1. LMDFloatToStrF doesn't use scientific format when number of digits to the left
  //   of decimal part is greater than Precision param (as FloatToStrF does).
  //2. In LMDFloatToStrF, Precision param affects only fractional part
  //   (In FloatToStrF, total number of digits is confined by Precision param)
  //3. In LMDFloatToStrF, if Precision param is greater than Digits param, then
  //   Digits param doesn't affect number of digits in fractional part.
  function LMDFloatToStrF (Value: Extended; Format: TFloatFormat; Base, Precision, Digits: Integer) : TLMDString;

implementation

uses
  LMDUtils,
  LMDStrings;

const
  AllowedCharsWithZero = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
           AllowedChars = '123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';

type THReader = class(TReader);

function LMDIntPower(X: Extended; I: Integer): Extended;
var
  y : Integer;
begin
  result := 1.0;
  for y := 1 to i do
    result := result * x;
  if I < 0 then result := 1.0 / result
  //we could use some logarithmic ops instead (a^x := e ^ (x * ln(a)))
end;

//the function LMDGetDecimalValue returns the decimal value of the number string regarding the numberbase base
//e.g. base = 2; s = 101 => result = 5
function LMDGetDecimalValue (base : Integer; s : TLMDString) : Int64;
var
   i : Integer;
begin
  result := 0;
  if base = 10 then
    begin
      if s = '-' then
        result := 0
      else
        result := StrToInt64(s);
    end
  else
    begin
      i := 0;
      while (s <> '') and (s <> '-') do
        begin
          //UpCase added by JH, Nov 03
          result := result + (Pos (LMDUpperCaseChar(s[Length(s)]), allowedchars)) * Trunc(LMDIntPower (base, i));
          inc(i);
          Delete (s, Length(s), 1);
        end;
      if s = '-' then result := -result;
    end;
end;

function LMDGetDecimalFloatValue (base : Integer; source : TLMDString) : Double;
var
  s : TLMDString;
  f : Double;
  i : Integer;
  negative : boolean;
begin
  //the negative variable is needed for one special case: -0.x!!
  negative := false;

  result := 0;
  //get the string containing the number and store it in s
  s := source;
  //just catch some common errors
  if (s = '-') or (s = '') then
    s := '0';
  if (s[1] = '-') and (s[2] = TLMDChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator)) then
    Insert ('0', s, 2);
  //if there is a fraction - only store the part before the fraction
  if Pos ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, s) <> 0 then
    s := Copy (s, 1, Pos (TLMDChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator), s)-1);
  if s <> '' then
    begin
      //get the int value of the decimal value and store it into result
       result := LMDGetDecimalValue (base, s);
      //check whether the value is something like -0.x
      //if this is not done the value will be equal to abs (value)!!!
      if (result = 0) and (s[1] = '-') then
        negative := true;
      //and now the fraction ...
      s := source;
      if Pos ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, s) <> 0 then
        Delete (s, 1, Pos ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, s))
      else
        s := '';
      //if there is a fraction it's the content of s
      if s <> '' then
        begin //Hornerschema
          //0,s[1]s[1]s[2]...s[n]
          //get the last char
          f := Pos (s[Length(s)], allowedchars);{StrToInt (s[Length(s)]);}
          for i := Length(s)-1 downto 1 do
            f := f * (1/base) + Pos (s[i], allowedchars);//StrToInt (s[i]);
          f := f * (1/base); //s[0] (0,)
          if (result < 0) and (not negative) then
            result := result - f
          else
            result := result + f;
        end;
      //negative maybe false even if result < 0! In this case it must be false!!
      if negative then result := -result;
    end;
end;

//get the int (base = 10) as string with base = parameter base
//May 2002 (JH): can now handle negative numbers as well
function LMDGetBaseString (base, value : Integer) : TLMDString;
var
  neg: Boolean;
begin
  result := '';
  neg := value < 0;
  if value = 0 then result := '0';
  while abs(value) > 0 do
    begin
      if value mod base = 0 then
        result := '0' + result
      else
        result := allowedchars[abs(value) mod base] + result;
      value := value div base;
    end;
  if neg then result := '-'+result;
end;

{ ---------------------------------------------------------------------------- }
function LMDGetFloatBaseString (base, acc : Integer; value : Double) : TLMDString;
var
    f: Double;
    n: Boolean;
begin
  if base = 10 then
    //Can't use FloatToStr because scientific format is not parsed here!!!
    result := FloatToStrF (value, ffFixed, 18, acc)
  else
    begin
      n := (Pos ('-', result) = 1);
      result := LMDGetBaseString (base, trunc(Value)) + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator;
      if (Value - trunc(Value) = 0) then
        begin
          result := result + LMDAnsiFillString(acc, '0');
          exit;
        end;
      f := value - trunc(value);
      while acc > 0 do
        begin
          Dec (acc);
          f := f * base;
          result := result + AllowedCharsWithZero[trunc(f) + 1];
          f := f - trunc(f);
        end;
      if (Length(result) > 0) and (result[1] <> '-') and (n) then
        result := '-' + result;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDFloatToStrF (Value: Extended; Format: TFloatFormat; Base, Precision, Digits: Integer) : TLMDString;
var
  DSP, c : Integer;

  procedure DeleteTrailingZeroes(var s: TLMDString);
  var
    i:integer;
  begin
    i := Length(s);
    while (s[i] = '0') and (i > 1) do
      begin
        Delete(s, i, 1);
        dec(i);
      end;
    if (i > 0) and (s[i] = TLMDChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator)) then
      Delete(s, i, 1);
  end;

begin
  result := LMDGetFloatBaseString (Base, Precision, Value);
  DSP := Pos ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, result);
  case Format of
    ffGeneral  : if DSP > 0 then
                   DeleteTrailingZeroes(result);
    ffNumber : begin
                 if DSP = 0 then
                   c := Length (result) + 1
                 else
                   c := DSP;
                 dec (c, 3);
                 while c > 1 do
                   begin
                     Insert ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ThousandSeparator, result, c);
                     dec (c, 3);
                     if (c = 4) and (result[1] = '-') then dec (c);
                   end;
               end;
    ffFixed  : begin
                 if DSP = 0 then
                   begin
                     if digits > 0 then
                       result := result + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator;
                     c := Digits
                   end
                 else
                   c := Digits - (Length (result) - DSP);
                 result := result + LMDAnsiFillString (c, '0');
               end;
    ffCurrency : //missing: negative, ....
               begin
                 if DSP = 0 then
                   begin
                     result := result + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator;
                     c := 2
                   end
                 else
                   c := 2 - (Length (result) - DSP);
                 result := result + LMDAnsiFillString (c, '0') + ' ' + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}CurrencyString;
               end;

  end;
end;

//clear housand separators
function LMDClearTS (s : TLMDString) : TLMDString;
begin
  result := s;
  while Pos ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ThousandSeparator, result) <> 0 do
    Delete (result, Pos ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ThousandSeparator, result), 1);
end;

//number of thousand separators in string s
function LMDNumberOfTSUpTo (s : TLMDString; upTo: Integer) : Integer;
var
  i: Integer;
begin
  result := 0;
  if upTo > Length(s) then upTo := Length(s); //JH Dec 2001
  for i := 1 to upTo do
    if (s[i] = TLMDChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ThousandSeparator)) then inc(result);
end;

//convert a mask as used in the VCL controls to a LMD mask
//this mask conversion is neither lossless nor revertable!!
function convertVCLMask2LMDMask (aMask : TLMDString) : TLMDString;
type
  char_case = (ccUpper, ccLower, ccIgnore);
var
  cc : char_case;
begin
  result := '';
  //ignore char case
  cc := ccIgnore;
  //repeat as long as there are chars in the VCL mask to be converted
  while (aMask <> '') do
    begin
      //check for actual mask char
      case aMask[1] of
        '!' : {skip this (optional charachters position)};

        '\' : if Length(aMask) > 1 then //just to prevent avs!
                begin //literal chars, similar
                  result := result + '\'+aMask[2];
                  //two chars recognized, let's remove one here
                  Delete (aMask, 1, 1);
                end;
        'l', //allows --> permits
        'L' : begin
                case cc of
                  ccUpper : result := result + 'A';
                  ccLower : result := result + 'a';
                  ccIgnore : result := result + 'b';
                end;
              end;
        'a',  //allows --> permits , alphanumeric char
        'A' : begin
                result := result + 'c';
              end;
        'c',
        'C' : begin //arbitrary char
                result := result + 'b';
              end;
        '0' : begin
                result := result + '0';
              end;
        '9' : begin
                result := result + '8';
              end;
        '#' : begin // + or - or number
                result := result + 'v';
              end;
        ':' : begin //time delimiter
                result := result + '\' + ':'{TimeDelimiter};
              end;
        '/' : begin //date delimiter
                result := result + '\' + '/'{DateDelimiter};        
              end;
        ';' : begin
                //if we found the first occurence kill the rest of the mask
                //we ignore the second and third mask fields!!!
                Delete (aMask, 1, Length(aMask) - 1);
              end;
        '_' : begin //auto blanks
                result := result + '\ ';
              end;
        '>' : cc := ccUpper;
        '<' : if (Length (aMask) > 1) and (aMask[2] = '>') then
                begin
                  cc := ccIgnore;
                  Delete (aMask, 1, 1);
                end
              else
                cc := ccLower;
      else //literal char
        begin
          result := result +'\'+aMask[1];
        end;
      end;
      //remove one char
      Delete (aMask, 1, 1);
    end;
  //result will now contain a rough (LMD) interpretation of the VCL mask
end;

{ @@@@@@@@@@@@@@@@@@@@@@@@@@ TLMDCustomMaskEdit @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ }
{ --------------------------------- private ---------------------------------- }
procedure TLMDCustomMaskEdit.SetMask (aValue : TLMDString);
begin
  if aValue <> FMask then
    begin
      FMask := aValue;
      if FMaskType = meMask then
        Text := literalChars;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetMaskType (aValue : TLMDMaskType);
var
  LHasNumber: boolean;
  LVal: double;
  //dt: TDateTime;
  //i: integer;
  //s1, s2: string;
begin
  if aValue <> FMaskType then
    begin
      LHasNumber := FMaskType in [meWord, meInteger, meFloat, meFloatFixed, meFloatNumber, meCurrency];
      LVal := 0;
      if LHasNumber then
        case FMaskType of
          meWord:
            LVal := AsCardinal;
          meInteger:
            LVal := AsInteger;
          meFloat, meFloatFixed, meFloatNumber:
            LVal := AsFloat;
          meCurrency:
            LVal := AsCurrency;
        end;
      FMaskType := aValue;
      case FMaskType of
        meDateTime:
        begin
          //i := Pos(' ', Text);
          //s1 := Copy(Text, 1, i - 1);
          //s2 := Copy(Text, i + 1, Length(Text)-i);
          Text := DateTimeString(Now);
        end;

        meDate : begin
                   FUserSelect := false;
                   Text := FDateSet.DateToStr (Date);
                 end;
                 {try
                   FUserSelect := false;
                   if Text <> '' then
                     dt := FDateSet.StrToDate (Text)
                   else
                     dt := Date;
                   Text := FDateSet.DateToStr (Date);
                 except
                   on Exception do
                     begin
                       DoValidationError;
                       Text := FDateSet.DateToStr (Date);
                     end;
                 end;}
        meTime :
                 begin
                   FTimeSet.Offset := 0;
                   Text := FTimeSet.TimeToStr (Time);
                 end;
                 {try
                   if Text <> '' then
                     dt := FTimeSet.StrToTime (Text)
                   else
                     dt := Now;
                   Text := FTimeSet.TimeToStr (Time);
                 except
                   on Exception do
                     begin
                       DoValidationError;
                       Text := TimeToStr (Time);
                     end;
                 end;}
        meMask :
          Text := literalChars;
        meWord, meInteger,
        meCurrency,
        meFloat, meFloatFixed, meFloatNumber:
          try
            SetValue(LVal)
          except
            on Exception do DoValidationError;
          end;
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetNumberBase (aValue : TLMDNumberBase);
var
  r: double;
begin
  if aValue <> FNumberBase then
    if FMaskType <> meCurrency then
      begin
        case FMaskType of
          meWord:
            r := AsCardinal;
          meInteger:
            r := AsInteger;
          else
            r := AsFloat;
        end;
        FNumberBase := aValue;
        SetValue(r);
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetBlankChar (aValue : Char);
begin
  if aValue <> FBlankChar then
    begin
      FBlankChar := aValue;
      ChangedText (1);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetProcessBlankChar (aValue : boolean);
begin
  FProcessBlankChar := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetSuppressBlankCharOnDelete(
  const aValue: boolean);
begin
  FSuppressBlankCharOnDelete := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetInteger (index, aValue : Integer);
begin
  case index of
    0 : if aValue <> FDecimals then
          begin
            FDecimals := aValue;
            FCurSet.Digits := FDecimals;
            ChangedText (1);
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetDouble (index : Integer; aValue : Double);
begin
  case index of
    1 : if aValue <> FMinValue then
          begin
            FMinValue := aValue;
            if FMinValue > FMaxValue then FMaxValue := aValue;
          end;
    2 : if aValue <> FMaxValue then
          begin
            FMaxValue := aValue;
            if FMinValue > FMaxValue then FMinValue := aValue;
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetCurSet (aValue : TLMDCurrencySettings);
begin
  FCurSet.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetDateFormat (aValue : TLMDDateFormat);
begin
  FDateSet.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetTimeFormat (aValue : TLMDTimeFormat);
begin
  FTimeSet.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetForceMaskCheck(const Value: boolean);
begin
  if FForceMaskCheck <> Value then
    FForceMaskCheck := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetForceOverwriteMode(const Value: boolean);
begin
  FForceOverWriteMode := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetSuffix (aValue: TLMDString);
var
  s: TLMDString;
begin
  s := GetPureText;
  FSuffix := aValue;
  SetTextWithSuffix(s);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.WMChar (var Msg : TWMChar);
var
  inh, c1,c2,c3: boolean;
  CurPos,b,l:Integer;
  fc, ch: TLMDChar;
  s: TLMDString;

  procedure callInherited;
  begin
    inh := true;
    inherited;
  end;

  procedure DeleteLeadingZero(aValue: double);
  begin
    //VB Nov 2006 this overwrites zero symbol when input starts with no text selected
    if FText = '' then
      exit;
    l := Pos(FDecimalDelim, FText);
    if (((aValue = 0) and (l < 1)) or ((trunc(aValue) = 0) and (l > 1) and (CurrentChar <= l)))
      and (SelLength = 0) and (Msg.CharCode > 31) and (Msg.CharCode <> Ord(FDecimalDelim)) and (emInsert in LMDApplication.EditMode) then
      begin
        if (l = 0) then
          l := 2;
        l := l - 1;
        if FText[l] = '-' then
          inc(l);
        CurrentChar := l;
        SelStart := l;
        Delete (FText, l, 1);
      end;
  end;

  procedure ProcessMinusSign;
  var
      s: TLMDString;
    i,l: integer;
  begin
    if ReadOnly then
      exit;
    if SelLength > 0 then
      begin
        SelText := '-';
        CurrentChar := 2;
        SelStart := CurrentChar;
        SelLength := 1;
      end
    else
      begin
        l := CurrentChar;
        i := Pos('-', FText);
        if (i = 0) then
          begin
            Text := '-' + FText;
            CurrentChar := l + 1;
          end
        else
          begin
            s := FText;
            Delete (s, i, 1);
            Text := s;
            CurrentChar := l - 1;
          end;
      end;
  end;

  procedure StoreCurrentPos;
  var
     i: integer;
    cs1, cs2: TLMDString;
  begin
    cs1 := AnsiChar(FDecimalDelim) + AllowedCharsWithZero;
    cs2 := '-' + cs1;
    CurPos := 0;
    for i:= 1 to FCurrentChar do
      if Pos(FText[i], cs1) > 0 then
        inc(CurPos);
    //if CurrentChar is outside of -1,1 then it will be moved to -|1,1
    if Pos(FText[FCurrentChar], cs2) = 0 then
      CurPos := 1;
  end;

  procedure RestoreCurrentPos;
  var
     i: integer;
    cs: TLMDString;
  begin
    cs := AnsiChar(FDecimalDelim) + AllowedCharsWithZero;
    for i:= 1 to length(FText) do
      begin
        if Pos(FText[i],cs) > 0 then
          Dec(CurPos);
        if CurPos = 0 then
          begin
            CurrentChar := i;
            break;
          end;
      end;
  end;

  procedure HandleDate;
  begin
    b := SelStart;
    l := SelLength;
    if (LMDCharInSet(ch, ['0'..'9']) or (ch = TLMDChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DateSeparator))) and not ReadOnly then
    begin
      s := Trim(System.Copy(FText, FDateSet.CurrentStart(CurrentChar, FText), FDateSet.CurrentLength(CurrentChar, FText)));
      inc(dep); //a new char for current type
      case FDateSet.CurrentType(CurrentChar, FText) of
        1, 2 : begin
                 if ch = TLMDChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DateSeparator) then //JH April 2002
                   begin
                     CurrentChar := NextEditChar;
                     SelStart := CurrentChar;
                     SelLength := FDateSet.CurrentLength(CurrentChar, FText);
                     exit;
                   end;
                 //day as number
                 if dep = 1 then s := ''; //added Dec 2001, JH (we have reentered the field, not yet changed it, clear it on first change)
                 if (Length(s) = 1) and ((s[1] < '3') or ((s[1] = '3') and (ch < '2'))) then
                   SelText := s + TLMDChar(ch)
                 else
                   if (Length (s) = 2) {and (s[1] = '0') rem Dec 2001, JH + Hugo Logmans}
                      and ((s[2] < '3') or ((s[2] = '3') and LMDCharInSet(ch, ['0','1']))) then
                     SelText := s[2] + TLMDString(ch)
                   else
                     SelText := TLMDString(ch) + (' ');
                 s := '12';
                 CurrentChar := CurrentChar - Length(s);
               end;
        11,
        12   : begin
                 if ch = TLMDChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DateSeparator) then //JH April 2002
                 begin
                   CurrentChar := NextEditChar;
                   SelStart := CurrentChar;
                   SelLength := FDateSet.CurrentLength(CurrentChar, FText);
                   exit;
                 end;
                 if dep = 1 then s := ''; //added Dec 2001, JH (we have reentered the field, not yet changed it, clear it on first change)
                 if (Length(s) = 1) and ((s[1] < '1') or ((s[1] = '1') and (ch < '3'))) then
                   SelText := s + ch
                 else
                   if (Length (s) = 2) and (s[1] = '0') and (ch < '3') and (s[2] < '2') then
                     SelText := s[2] + TLMDString(ch)
                   else
                     SelText := TLMDString(ch) + ' ';
                 s := '12';
                 CurrentChar := CurrentChar - Length(s);
               end;
        13,
        14   : begin
                 if ch = TLMDChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DateSeparator) then //JH April 2002
                   begin
                     CurrentChar := NextEditChar;
                     SelStart := CurrentChar;
                     SelLength := FDateSet.CurrentLength(CurrentChar, FText);
                     exit;
                   end;
                 if dep = 3 then dep := 1;
                 if dep = 1 then dep_help := 0;
                 if dep < 3 then
                   begin
                     if dep_help = 1 then
                     dep_help := StrToInt (IntToStr (dep_help) + ch)
                     else
                     dep_help := StrToInt (ch);

                     if FDateSet.CurrentType(CurrentChar, FText) = 13 then //MMM
                       s := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortMonthNames[dep_help]
                     else
                       s := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongMonthNames[dep_help];
                     while Length(s) < l do
                       s := s + ' ';
                     SelText := s;
                     Currentchar := CurrentChar - (CurrentChar - b);
                   end;
               end;
        21,
        22,
        23,
        24   : begin
                 if ch = TLMDChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DateSeparator) then exit; //JH April 2002
                 if (Length(s) < 4) then
                   //year
                   begin
                     l := Length(s)+1;
                     SelText := s + ch;
                     if Length (s) = 3 then
                       begin
                         l := FDateSet.CurrentLength (CurrentChar, FText);
                         CurrentChar := CurrentChar - l; //jump to start
                       end;
                   end
                 else
                   begin
                     if l<>length(FText) then
                       l := 1;
                     dep := 1;
                     SelText := ch;
                   end;
               end;
        else
          callInherited;
      end;
    end;
    SelStart := b;
    SelLength := l;
  end;

  procedure HandleTime;
  begin
    b := SelStart;
    l := SelLength;
    if (LMDCharInSet(ch, ['0'..'9']) or (ch = TLMDChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimeSeparator))) and not ReadOnly then
    begin
      s := Trim(System.Copy(FText, FTimeSet.CurrentStart(CurrentChar, FText), FTimeSet.CurrentLength(CurrentChar, FText)));
      case FTimeSet.CurrentType(CurrentChar, FText) of
        1, 2 : begin
                 if ch = TLMDChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimeSeparator) then
                 begin
                   CurrentChar := NextEditChar;
                   SelStart := CurrentChar;
                   SelLength := FTimeSet.CurrentLength(CurrentChar, FText);
                   exit;
                 end;
                 if (Length(s) = 1) and ((s[1] < '2') or ((s[1] = '2') and (ch < '4'))) then
                   SelText := s + TLMDChar(ch)
                 else
                   if (Length (s) = 2)
                      and ((s[2] < '2') or ((s[2] = '2') and LMDCharInSet(ch, ['0','1','2','3']))) then
                     SelText := s[2] + TLMDString(ch)
                   else
                     SelText := TLMDString(ch) + (' ');
                 s := '12'; //todo 1,2??
                 CurrentChar := CurrentChar - Length(s);
               end;
        11,
        12,21,22   : begin
                 if ch = TLMDChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimeSeparator) then
                 begin
                   CurrentChar := NextEditChar;
                   SelStart := CurrentChar;
                   SelLength := FTimeSet.CurrentLength(CurrentChar, FText);
                   exit;
                 end;
                 if (Length(s) = 1) and ((s[1] < '5') or ((s[1] = '5') and (ch <= '9'))) then
                   SelText := s + ch
                 else
                   if (Length (s) = 2) and (s[1] = '0') and (s[2] <= '5') and (ch <= '9') then
                     SelText := s[2] + TLMDString(ch)
                   else
                     SelText := TLMDString(ch) + ' ';
                 s := '12';
                 CurrentChar := CurrentChar - Length(s);
               end
        else
          callInherited;
      end;
    end;
    SelStart := b;
    SelLength := l;
  end;

begin
  ch := TLMDChar(Msg.CharCode);

  if FMaskType = meMask then
    begin
      if SelLength > 1 then SelLength := 1;
      //VB Nov 2007 (issue rep-d in news  by Sven van Br. on Nov 09, 2007)
      if not ProcessBlankChar and (ch = TLMDChar(FBlankChar)) then
        exit;
      //-->
    end;

  //VB Dec 2006
  if FMaskType in [meFloat, meFloatFixed, meFloatNumber, meInteger, meWord] then
    begin
    ch := LMDUpperCaseChar(ch);
    Msg.CharCode := Ord(ch);
    end;
  //-->

  if FForceMaskCheck and (ch=#13) then
    begin
      ForceMaskValidation;
      exit;
    end;

  inh := false;

  // FText[FCurrentChar] is substituted with fc in the
  // following case FMaskType, March 05, VB
  if FCurrentChar <= Length(FText) then
    fc := FText[FCurrentChar]
  else
    fc := #0;

  case FMaskType of
    //UpCase Nov 03, JH
    meInteger: begin
                 DeleteLeadingZero(AsInteger);
                 if (ch='-') then
                   begin
                     ProcessMinusSign;
                     exit;
                   end;
                 if ((Pos (LMDUpperCaseChar(ch), System.Copy(AllowedCharsWithZero, 1, FNumberBase)) <> 0) and // we have an allowed number
                   ((FText = '') or (fc <> '-'))) or //we are behind the - (if one exists)
                  ((ch = '-') and (((CurrentChar = 1) and (Pos ('-', FText) = 0))
                                  or ((FSelStart = 1) and (SelLength > 0))) ) then // or we try to enter a - (if none exists, or the existing one be selected)
                   callInherited;
               end;
    meWord:   begin
                DeleteLeadingZero(AsCardinal);
                if (Pos (LMDUpperCaseChar(ch), System.Copy(AllowedCharsWithZero, 1, FNumberBase)) <> 0) then // we have an allowed number
                  callInherited;
              end;
    meFloatFixed,
    meFloatNumber,
    meFloat:   begin
                 if not FForceOverWriteMode then
                 DeleteLeadingZero(AsFloat);
                 if (ch='-') then
                   begin
                     ProcessMinusSign;
                     exit;
                   end;
                 l := Pos(FDecimalDelim, FText);
                 c1 := (((Pos (LMDUpperCaseChar(ch), System.Copy(AllowedCharsWithZero, 1, FNumberBase)) <> 0)) and // we have an allowed number
                       not ((fc=FDecimalDelim) and (FForceOverWriteMode)) and
                       ((FText = '') or (fc <> '-') or //we are behind the - (if one exists)
                       ((fc = '-') and (SelStart = 1) and (SelLength > 0) )));
                 c2 := ((ch = '-') and (CurrentChar = 1) and (Pos ('-', FText) = 0)); //JH, Dec, 2001, otherwise - cannot be replaced by keyboard input (selecting and overwriting)
                 c3 := ((ch = FDecimalDelim) and (l = 0) and (CurrentChar > Pos ('-', FText)));
                 if c1 or c2 or c3 then
                   callInherited
                 else //added by JH, Nov 02
                 begin
                   if (fc = FDecimalDelim) and (l <> 0) and not FIsDeleting then
                     CurrentChar := l + 1;
                 end;
               end;

    meCurrency:{if ((c in ['0'..'9']) and // we have an allowed number
                   (SelStart <= Pos (FCurSet.Symbol, FText)-1) and //we are at a correct pos
                   ((FText = '') or (FText[FCurrentChar] <> '-'))) or //we are behind the - (if one exists)
                  ((c = '-') and (CurrentChar = 1) and (Pos ('-', FText) = 0)) or
                  ((c = FDecimalDelim) and (Pos(FDecimalDelim, FText) = 0)) then
                  if ((Pos (FDecimalDelim, FText) = 0) and (Length(FText)-Length(FCurSet.Symbol)-1-SelStart <= 1)) or          //no separator just add the new number
                     (CurrentChar <= Pos (FDecimalDelim, FText)) or //we have got a separator (or this would not be executed) and we are before it => just add
                     ((Length(FText) -Length(FCurSet.Symbol) - 1)- Pos (FDecimalDelim, FText) < CurrencyDecimals) then //the amount of the numbers after the separator is smaller than the defined possible amount}
                begin
                  DeleteLeadingZero(AsCurrency); //VB Nov 2006
                  FMinus := (ch='-') and FCurSet.IsNegative(FText);
                  if (ch='-') and (SelLength=0) then
                    StoreCurrentPos;
                  if (ch = FDecimalDelim) and (SelLength = 0) then //added JH May 02, #02_05_27_1
                                                                  //otherwise delim char was not accepted if text was not highlighted!
                    begin
                      Delete (FText, Pos(FDecimalDelim, FText), 1);
                      callInherited;
                      exit;
                    end;
                  if (ch <> FDecimalDelim) or ((Pos(FDecimalDelim, FText) in [SelStart, SelStart + SelLength]) and (SelLength <> 0)) then // only allow input of decimal sep iff the actual one is replaced
                    callInherited;
                  if (ch='-') and (SelLength=0) then
                    RestoreCurrentPos;
                end;
    meDate:   HandleDate;
    meTime:   HandleTime;
    meDateTime:
              begin
                l := FDateSet.DateLength(FText);
                if CurrentChar < l then
                  HandleDate
                else
                begin
                  FTimeSet.Offset := l;
                  HandleTime;
                  FTimeSet.Offset := 0;
                end;
              end;
    meMask:   begin
                 LMDApplication.EditMode := LMDApplication.EditMode - [emInsert];
//                 SelLength := 1;
                 if charAllowedAt (SelStart, ch) then
                   callInherited
                 else
                   begin 
                     //This is to skip literal chars of the mask, e.g parenthesis and space for mask "(___) ____"  VB Feb 2008
                     if (CurrentChar < Length(FText)) and (Msg.CharCode <> VK_BACK) and (inputCharsAllowedAt (CurrentChar) = 0) then
                       begin
                         CurrentChar := CurrentChar + 1;
                         WmChar(Msg);
                       end;
                   end;
               end;
    meNone: callInherited;
  end;
  if not inh then DoKeyPress (Msg); //6.1 JH
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.WriteData(Writer : TWriter);
begin
  case FMaskType of
    meTime :
      Writer.WriteFloat(AsTime);
    meDate :
      Writer.WriteFloat(AsDate);
    meDateTime:
      Writer.WriteFloat(AsDateTime);
    meWord :
      Writer.WriteInteger(AsCardinal);
    meInteger:
      Writer.WriteInteger(AsInteger);
    meFloat, meFloatFixed, meFloatNumber:
      Writer.WriteFloat(AsFloat);
    meCurrency:
      Writer.WriteFloat(AsCurrency);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.ReadData(Reader : TReader);
var
  v: double;
  s: TLMDString;
begin
  v := Reader.ReadFloat;
  s := THReader(Reader).PropName;
  if (s = 'Value') or ((s = 'DateTime') and (FMaskType in [meDate, meTime, meDateTime])) then
    SetValue(v);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.literalChars : TLMDString;
var
  i : Integer;
  c : TLMDChar;
begin
  result := '';
  i := 1;
  while i <= Length(FMask) do
    begin
      c := TLMDChar(FBlankChar);
      if FMask[i] = '!' then //jump over
        inc(i);
      if FMask[i] = '\' then //literal
        begin
          inc(i);
          c := FMask[i];
        end;
      result := result+c;
      inc(i);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.GetEmptyText: TLMDString;
begin
  if (FMaskType = meMask) and not (SuppressBlankCharOnDelete and FIsDeleting) then
    result := System.Copy(literalChars, SelStart, SelLength)
  else
    result := '';
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.isLiteral (charPos : Integer) : Boolean;
var
  i, j : Integer;
  wasLit: Boolean;
begin
  Result := false;

  i := 1;
  j := 1;

  wasLit := false;

  while j <= charPos do
  begin
    if j = charPos then
      Result := (FMask[i] = '\') or ((FMask[i] = '!') and wasLit)
    else
    begin
      if FMask[i] = '\' then
      begin
        wasLit := true;
        Inc(i);
      end
      else if FMask[i] <> '!' then
        wasLit := false;
    end;

    Inc(i);
    Inc(j);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.inputCharsAllowedAt(at : Integer) : Integer;
var
  i, j : Integer;
begin
  i := 1;
  j := 0;
  result := -1;
  while (i <= Length(FMask)) and (j < at) do
    begin
      if FMask[i] = '!' then //jump over
        inc(i);
      if FMask[i] = '\' then //literal
        begin
          inc(i);
          result := 0;
        end
      else
        case FMask[i] of
          'a' : result := 1;
          'A' : result := 2;
          'b' : result := 3;
          '0' : result := 4;
          '9' : result := 5;
          'c' : result := 6;
          'r' : result := 7;
          'v' : result := 8;
          '1' : result := 9;
          '8' : result := 10;
          '#' : result := 11;
          '*' : result := 12;
        end;
      inc(i);
      inc(j);
    end;
  if (at > Length(literalChars)) then result := -1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.NeededEntered (s : TLMDString) : Integer;
var
  i, j : Integer;
  force: boolean;
begin
  result := 0;
  i := 1; j := 1;
  while (i <= Length (s)) and (result = 0) do
    begin
      force := false;
      while AnsiChar(FMask[j]) in ['!', '\'] do
        begin
          if FMask[j] = '!' then begin force := true; inc(j); end;
          if FMask[j] = '\' then
            begin
              inc(j, 2);
              force := false;  //forced a literal char ...
            end;
        end;
      if force then
        if not RealCharAllowedAt (i, FText[i]) then //blank char allowed here
          result := i;
      inc(i);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.RealCharAllowedAt (at : Integer; c : TLMDChar) : Boolean;
begin
  result := false;
  case inputCharsAllowedAt (at) of
    0 : if getCharAt (at) = c then result := true;
    1 : if LMDIsCharAlpha (c) and LMDIsCharLower(c) then result := true;
    2 : if LMDIsCharAlpha (c) and LMDIsCharUpper(c) then result := true;
    3 : if LMDIsCharAlpha (c) then result := true;
    4 : if LMDCharInSet(c, ['0'..'9']) then result := true;
    5 : if LMDCharInSet(c, ['1'..'9']) then result := true;
    6 : if LMDIsCharAlphaNumeric (c) then result := true;
    7 : begin
          if Assigned (FOnUserRule) then (FOnUserRule (self, result, {$IFDEF LMD_UNICODE}widechar(c){$ELSE}char(c){$ENDIF}, at)); //SelStart replaced by at, JH July 02
        end;
    8 : if AnsiChar(c) in ['+','-'] then result := true;
    9 : if AnsiChar(c) in ['0','1'] then result := true;
    10 : if AnsiChar(c) in ['0'..'9',' '] then result := true;
    11 : if AnsiChar(c) in ['+','-','0'..'9'] then result := true;
    12 : if AnsiChar(c) in ['+','-','1'..'9'] then result := true;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.CharAllowedAt (at : Integer; c : TLMDChar) : Boolean;
begin
  result := RealCharAllowedAt (at, c);
  if c = TLMDChar(BlankChar) then
    result := true;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.getCharAt (at : Integer) : TLMDChar;
var
  i, j : Integer;
begin
  i := 1;
  j := 0;
  result := ' ';
  while (i < Length(FMask)) and (j < at) do
    begin
      if FMask[i] = '!' then
        inc(i);
      if FMask[i] = '\' then
        inc(i);
      result := FMask[i];
      inc(i);
      inc(j);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.checkText (s : TLMDString) : boolean;
var
  ok : boolean;
  i : integer;
begin
  result := false;

  //more chars entered than allowed, but this may not always be enough to
  //reject an input (e.g. up to n chars allowed - e.g. on number input)
  if not (Length(s) = Length(literalChars)) then
    begin
      //check whether we have "not required" mask positions ...
      if Length (s) > Length (literalChars) then
        exit;
    end;
  ok := true;
  i := 1;
  while (ok) and (i <= Length(s)) do
    begin
      if i <= Length (literalChars) then
        ok := charAllowedAt (i, s[i])
      else
        begin //see above: that's not correct for a mask e.g. of 88888
          //and someone wants to set a simple string looking like "5".
          ok := false;
        end;
      inc(i);
    end;
  result := ok;
end;


{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.WMKILLFOCUS (var Message : TWMKillFocus);
var
  dt : TDateTime;
  i : Integer;

begin
  inherited;
//  if csDestroying in ComponentState then exit;
  case FMaskType of
    meDate : try
               dt := FDateSet.StrToDate (FText);
               Text := FDateSet.DateToStr (dt);
             except
               on Exception do
                 begin
                   DoValidationError;
                   if not (csDestroying in ComponentState) then SetFocus;
                 end;
             end;
    meTime : try
               dt := FTimeSet.StrToTime (FText);
               Text := FTimeSet.TimeToStr (dt);
             except
               on Exception do
                 begin
                   DoValidationError;
                   if not (csDestroying in ComponentState) then SetFocus;
                 end;
             end;
    meMask : begin
               i:= neededEntered (FText);
               if i <> 0 then
                 begin
                   SetFocus;
                   SelStart := i;
                   SelLength := 1;
                 end;
               LMDApplication.EditMode := FEditMode;
             end;
    else //new May 2002: Check upper and lower border of input value on finish editing
      CheckNumberRange;
  end;

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.WMSETFOCUS (var Message : TWMSetFocus);
var
  dt : TDateTime;
begin
  inherited;
  case FMaskType of
    meDate : if Text <> '' then
             begin
               dt := FDateSet.StrToDate (Text);
               Text := FDateSet.GetDTEditString (dt);
             end;
    meTime : if Text <> '' then
             begin
               dt := FTimeSet.StrToTime (Text);
               Text := FTimeSet.GetEditString (dt);
             end;
    meDateTime: if Text <> '' then
                begin

                end;
    meMask:
      FEditMode := LMDApplication.EditMode;
  end;
end;

{ ------------------------------------ protected ----------------------------- }
procedure TLMDCustomMaskEdit.HandleInsertText (at : Integer; var aValue : TLMDString);
var
  s: TLMDString;
  i: integer;
begin
  inherited HandleInsertText (at, aValue);
  if aValue = '' then exit;
  //backup aValue
  s := aValue;
  case FMaskType of
    meInteger:begin
               if (s[1] = '-') then
                 begin
                   //delete this char because of the number range checking below
                   Delete (s, 1, 1);
                   //if we have a - we have to make sure that there is second - (which could be already entered)
                   if (FText <> '') and (FText[1] = '-') and ((FSelStart <> 1) or (SelLength = 0)) then
                     //there is already a - and it is not selected => the new text can't be inserted
                     aValue := '';
                 end;
               //while there are allowed chars in the to be inserted text
               //UpCase added by JH, Nov 03
               while (s <> '') and (Pos(LMDUpperCaseChar(s[1]), System.Copy(AllowedCharsWithZero, 1, FNumberBase)) <> 0) do
                 Delete (s, 1, 1);
               if s <> '' then
                 aValue := '';  // wrong data found
             end;
    meWord : begin
               //while there are allowed chars
               while (s <> '') and (Pos(LMDUpperCaseChar(s[1]), System.Copy(AllowedCharsWithZero, 1, FNumberBase)) <> 0) do
                 Delete (s, 1, 1);
               if s <> '' then aValue := ''; // wrong data found
             end;
    meFloat : begin
                //are all chars to be added allowed
                while (s <> '') and ((AnsiChar(s[1]) in ['-'])
                    or (s[1] = FDecimalDelim)
                    or (Pos(LMDUpperCaseChar(s[1]), System.Copy(AllowedCharsWithZero, 1, FNumberBase)) <> 0)) do
                  Delete (s, 1, 1);
                if s <> '' then aValue := ''; //wrong data found
                //we cannot insert the - at another pos as the first :-)
                //do not allow a - somewhere in the number (e.g. 1287324-345435)
                if (Pos ('-', aValue) <> 0) and (Pos ('-',aValue) <> 1) then
                  aValue := '';
                //do not allow a - at another place than the first
                if (Pos ('-', aValue) <> 0) and (SelStart > 1) then
                  aValue := '';
                //if we have got a DecimalSeparator in the text and in the text to be inserted avoid having two of them afterwards
                if (Pos (FDecimalDelim, aValue) <> 0) and
                   (Pos (FDecimalDelim, FText) <> 0) and
                   not ((SelStart >= Pos (FDecimalDelim, FText)) and
                       (SelStart + SelLength <= Pos (FDecimalDelim, FText))) then
                  aValue := '';
                //if we have got a '-' in the text and in the text to be inserted avoid having two of them afterwards
                if (Pos ('-', aValue) <> 0) and
                   (Pos ('-', FText) <> 0) and
                   not ((SelStart >= Pos ('-', FText)) and
                       (SelStart + SelLength <= Pos ('-', FText))) then
                  aValue := '';
              end;
    meCurrency : begin
{                   if (SelStart > Pos (CurrencyString, FText) - 1) then
                     aValue := '';
                   while (s <> '') and (s[1] in ['0'..'9', FDecimalDelim, FThousandDelim]) do
                     Delete (s, 1, 1);
                   if s <> '' then aValue := ''; //wrong data found}
                 end;
    meMask : begin
//               i := SelStart;
               s := FText;

               if FIsPasting then
                 begin
                   if SelLength = 0 then
                     SelLength := Length(aValue);
                   System.Delete (s, SelStart, SelLength);
                   i := Length(literalChars) - length(s);
                   if (i < Length(aValue)) then
                     System.Delete(aValue, i + 1, Length(aValue) - i);
                 end;

               System.Insert (aValue, s, SelStart);

               if not checkText (s) then aValue := '';
             end;
{    meTime,
    meDate : aValue := '';}
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.HandleReplaceText (at : Integer; aValue : TLMDString);
begin
  FOldText := FText; //save the old text

  //VB Nov 2006 this is to allow deleting through currency symbol for prefix masks
  if (FMaskType = meCurrency) and (aValue <> '') then
    if (at <= Pos(FDecimalDelim, FText)) and (aValue[1] = FCurSet.Symbol[1]) then
      begin
        FCurrentChar := FCurSet.FirstDigitPos(AsCurrency) + length(FCurSet.Symbol) - 1;
        SelStart := FCurrentChar;
      end;
  //-->
  inherited HandleReplaceText (at, aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.BeforeChangeText;
begin
  inherited;
  FTDelims := LMDNumberOfTSUpTo (Text, CurrentChar);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.FinishedSetSelText;
var
  i: Integer;
begin
  inherited;
  //needed for currency masks like $ value
  if FMaskType = meCurrency then
    begin
      i := FCurSet.FirstDigitPos (AsCurrency);
      if (i >= CurrentChar) and (not FIsDeleting) then
        begin
          CurrentChar := i  + length(FCurSet.Symbol); // get behind the
          SelStart := i  + length(FCurSet.Symbol);    // first digit pos
        end;
    end;
  if FMaskType in [meCurrency, meFloatNumber] then
    begin
      i := LMDNumberOfTSUpTo (Text, CurrentChar);
      //VB Aug 2007:
      //condition (i > FTDelims) causes wrong caret position when deleting and backspacing
      //hence we check if symbols are being deleted
      if FIsDeleting or (i > FTDelims) then
        begin
          SelStart := SelStart + i - FTDelims;
          CurrentChar := SelStart;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.CreateSpecialText(var s : TLMDString);
begin
  inherited CreateSpecialText (s);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.ChangedText (At : Integer);
var
  v: Double;
  Y, M, D : Word;
  hr, mn, sc: byte;
  i : Integer;
  s, s2: TLMDString;
  ff: TFloatFormat;
  lCallInherited: boolean;

  //getLenLimStr (length unlimited string) : (length limited string and MaxLength <> 0)
  //                                          or (length unlimited string and MaxLength = 0)
  // created 6 July 2001, JH
  function getLenLimStr (s : TLMDString) : TLMDString;
  begin
    result := s;
    if MaxLength = 0 then exit;
    result := System.Copy(s, 1, MaxLength);
  end;

  procedure HandleDate;
  begin
    if (dep < 4) and (FDateSet.CurrentType (CurrentChar, FText) in [21..24]) then begin inherited ChangedText (At); exit; end;
    i := CurrentChar;
    FDateSet.StrToYMD (Text, Y, M, D);
    if (M in [1..12]) and (D in [1..31]) and (Y >= 1899) then
    begin
      FText := FDateSet.GetDTEditString (AsDate);
      Currentchar := i;
    end;
    SelStart := FDateSet.CurrentStart (CurrentChar, FText);
    SelLength := FDateSet.CurrentLength (CurrentChar, FText);
  end;

  procedure HandleTime;
  begin
    if (dep < 4) and (FTimeSet.CurrentType (CurrentChar, FText) in [21..22]) then
    begin
      inherited ChangedText (At);
      exit;
    end;
    i := CurrentChar;
    FTimeSet.StrToHMS (Text, hr, mn, sc);
    if (hr in [0..23]) and (mn in [0..59]) and (sc in [0..59]) then
    begin
      FText := FTimeSet.GetEditString (AsTime);
      Currentchar := i;
    end;
    SelStart := FTimeSet.CurrentStart (CurrentChar, FText);
    SelLength := FTimeSet.CurrentLength (CurrentChar, FText);
  end;

begin
  lCallInherited := true;
  case FMaskType of
    meDate : try
               if (csLoading in ComponentState) and (Text = '') then exit;
               HandleDate;
             except
                on Exception do DoValidationError;
             end;
    meTime : try
               if (csLoading in ComponentState) and (Text = '') then exit;
               HandleTime;
             except
                on Exception do DoValidationError;
             end;
    meDateTime:
             try
               if (csLoading in ComponentState) and (Text = '') then exit;
               (*dl := FDateSet.DateLength(Text);
               //i := CurrentChar;
               //FText := DateTimeString(AsDateTime);
               //CurrentChar := i;
               if CurrentChar < dl then
               begin
                 SelStart := FDateSet.CurrentStart (CurrentChar, FText);
                 SelLength := FDateSet.CurrentLength (CurrentChar, FText);
               end
               else
               begin
                 FTimeSet.Offset := dl;
                 SelStart := FTimeSet.CurrentStart (CurrentChar, FText);
                 SelLength := FTimeSet.CurrentLength (CurrentChar, FText);
                 FTimeSet.Offset := 0;
               end;  *)
             except
               on Exception do DoValidationError;
             end;
    meCurrency : begin
                   v := AsCurrency;
                   if (FText <> getLenLimStr (FCurSet.toStr (v, FMinus))) then //JH July 2001
                     begin
                       v := AsCurrency;
                       try
                         FText := FCurSet.toStr (v, FMinus); //VB Jan 2007
                         FMinus := false;
                       except
                         on Exception do DoValidationError;
                       end;
                   end;
                 end;
    meInteger:  if GetPureText = '' then
                  SetTextWithSuffix('0')
                else
                  begin
                    if Length (FText) >= 1 then
                      s:= FText[1]
                    else
                      s := ' ';
                    s2 := LMDGetBaseString (FNumberBase, Trunc (AsInteger)); //VB Dec 2006
                    if (Length (s2) > 0) and (s[1] = '-') and (s2[1] <> '-') then
                      s2 := '-'+s2;
                    SetTextWithSuffix(s2);
                    lCallInherited := (s2 = GetPureText);
                  end;
    meFloatNumber,
    meFloatFixed:   begin
                      v := AsFloat;
                      if FMaskType = meFloatNumber then
                        ff := ffNumber
                      else
                        ff := ffFixed;
                      s2 := LMDFloatToStrF (v, ff, FNumberBase, Decimals, Decimals);
                      if (FText <> getLenLimStr (s2)) then //JH July 2001
                        begin
                          try
                            if Length (FText) >= 1 then
                              s:= FText[1]
                            else
                              s := ' ';
                            if (Length (s2) > 1) and (s[1] = '-') and (s2[1] <> '-') then
                              s2 := '-'+s2;
                            SetTextWithSuffix(s2); //VB Dec 2006 Suffix issue fix
                            lCallInherited := (s2 = GetPureText);
                          except
                            on Exception do DoValidationError;
                          end;
                      end;
                    end;
    meMask : if (not checkText(FText)) then
               FText := FOldText;
  end;
  if lCallInherited then
    inherited ChangedText (At);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.DefineProperties (Filer : TFiler);
begin
  inherited DefineProperties (Filer);
  //We define special writer and reader for number, currency, date and time values
  //so that they are stored as numbers, not as text.
  //The purpose for this is that values must be correctly read on systems with
  //regional settings different from those where values were saved
  Filer.DefineProperty ('Value', ReadData, WriteData, not IsTextStored);
  Filer.DefineProperty ('DateTime', ReadData, nil, false);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.CursorPosChanged;
var
  dl: integer;
begin
  inherited CursorPosChanged;
  if FMaskType = meDate then
    SelLength := FDateSet.CurrentLength(CurrentChar, FText);
  if FMaskType = meTime then
    SelLength := FTimeSet.CurrentLength(CurrentChar, FText);
  if FMaskType = meDateTime then
  begin
    dl := FDateSet.DateLength(FText);
    if CurrentChar < dl then
      SelLength := FDateSet.CurrentLength(CurrentChar, FText)
    else
    begin
      FTimeSet.Offset := dl;
      SelLength := FTimeSet.CurrentLength(CurrentChar, FText);
      FTimeSet.Offset := 0;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.DoValidationError;
begin
  if Assigned(FOnError) then FOnError(self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.DateTimeInc(aStep: integer);
var
  dl: Integer;
begin
  if not ReadOnly then
  case FMaskType of
    meDate:  ToDate (+1);
    meTime:  ToTime (+1);
    meDateTime:
              begin
                dl := FDateSet.DateLength(FText);
                if CurrentChar < dl then
                  ToDate(1)
                else
                  ToTime(1);
              end;
  end;
end;


{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.DateTimeDec(aStep: integer);
var
  dl: Integer;
begin
  if not ReadOnly then
  case FMaskType of
    meDate:  ToDate (-1);
    meTime:  ToTime (-1);
    meDateTime:
             begin
                dl := FDateSet.DateLength(FText);
                if CurrentChar < dl then
                  ToDate (-1)
                else
                  ToTime(-1);
             end;
  end;
end;


{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.GetCommandKey (var KeyCode : Word; Shift : TShiftState);
var
  dl,i,j : Integer;
  s : TLMDString;
begin
  FCommandKey := KeyCode;
  if FMaskType = meDateTime then
    dl := FDateSet.DateLength(FText)
  else
    dl := 0;
  case KeyCode of
    VK_DELETE:
      begin
        if (GetSuffix <> '') and (SelStart + SelLength > Length(FText) - Length(GetSuffix)) then
          begin
            if SelLength > 0 then
              SelLength := Length(FText) - Length(GetSuffix) - SelStart + 1;
            if SelLength = 0 then
              exit; //prevent deleting within suffix
          end;

        case FMaskType of
          meMask:
            begin
              if SelStart <= Length(literalChars) then
                begin
                  if SelLength = 0 then
                    SelLength := 1;
                  s := '';
                  j := Currentchar;//added 7/7/00
                  for i := SelStart to SelStart+SelLength-1 do
                    if (inputCharsAllowedAt(i) <> 0) and (not SuppressBlankCharOnDelete) then
                      s := s + FBlankChar
                    else //we have got a literal char
                      s := s + getcharAt (i);
                  SelText := s;
                  CurrentChar := j;//added 7/7/00
                end
            end;
          meFloatNumber,
          meCurrency:
            begin
              if CurrentChar < Length(FText) then
                if FText[CurrentChar] = FThousandDelim then
                  CurrentChar := CurrentChar + 1;
              inherited GetCommandKey (KeyCode, Shift);
            end;
          meDate:; //do nothing ...
          //does #02_05_27_2 have any effect on one of these inout types?
          meTime,
          meFloat,
          meFloatFixed,
          meNone,
          meWord,
          meInteger : inherited GetCommandKey (KeyCode, Shift);
        end;
      end;
    VK_BACK :
      begin
        if (GetSuffix <> '') and (SelStart + SelLength > Length(FText) - Length(GetSuffix)) then
          SelLength := Length(FText) - Length(GetSuffix) - SelStart + 1;
        case FMaskType of
          meDate:; //do nothing?
          meCurrency : begin
                         //if SelStart + SelLength <= Pos (CurrencyString, FText) - 1 then removed 14.08.2001 see above
                         inherited GetCommandKey (KeyCode, Shift);
                       end;
          meFloatFixed, meFloatNumber,
          meTime, meNone,
          meFloat, meInteger, meWord : inherited GetCommandKey (KeyCode, Shift);
          meMask: if Text <> '' then //added JH, July 02
                    begin
                      i := SelLength;
                      if i = 0 then
                        begin
                          i := 1;
                          SelStart := SelStart - 1;
                        end;
                       SelLength := i;
                       j := SelStart;
                       s := '';
                       for i := SelStart to SelStart+SelLength-1 do
                         if (inputCharsAllowedAt(i) <> 0) and (not SuppressBlankCharOnDelete) then
                           s := s + FBlankChar
                         else //we have got a literal char
                           s := s + getcharAt (i);
                       SelText := s;
                       CurrentChar := j;
                     end;
        end;
      end;
    VK_UP :  DateTimeInc(1);
    VK_DOWN: DateTimeDec(1);
    VK_LEFT :
      begin
          if FMaskType in [meDate, meTime, meDateTime] then
          begin
        CurrentChar := PrevEditChar;
        case FMaskType of
          meDate: SelLength := FDateSet.CurrentLength(CurrentChar, FText);
          meTime: SelLength := FTimeSet.CurrentLength(CurrentChar, FText);
          meDateTime:
          begin
            if CurrentChar <= dl then
              SelLength := FDateSet.CurrentLength(CurrentChar, FText)
            else
            begin
              FTimeSet.Offset := dl;
              SelLength := FTimeSet.CurrentLength(CurrentChar, FText);
              FTimeSet.Offset := 0;
            end;
          end
            end
          end
        else
          inherited GetCommandKey (KeyCode, Shift);
        end;
    VK_END :
       if not (FMaskType in [meDate, meTime, meDatetime]) then
        inherited GetCommandKey (KeyCode, Shift);
    VK_HOME :
       if not (FMaskType in [meDate, meTime, meDatetime]) then
        inherited GetCommandKey (KeyCode, Shift);
    VK_RIGHT :
      begin
          if FMaskType in [meDate, meTime, meDateTime] then
          begin
        CurrentChar := NextEditChar;
        case FMaskType of
          meDate: SelLength := FDateSet.CurrentLength(CurrentChar, FText);
          meTime: SelLength := FTimeSet.CurrentLength(CurrentChar, FText);
          meDateTime:
          begin
            if CurrentChar <= dl then
              SelLength := FDateSet.CurrentLength(CurrentChar, FText)
            else
            begin
              FTimeSet.Offset := dl;
              SelLength := FTimeSet.CurrentLength(CurrentChar, FText);
              FTimeSet.Offset := 0;
                end
              end
            end
          end
        else
          inherited GetCommandKey (KeyCode, Shift);
        end
    else
      inherited GetCommandKey (KeyCode, Shift);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;

var
  dl: integer;

  function sign (aVal: Integer): ShortInt;
  begin
    result := -1;
    if aVal > 0 then result := 1;
  end;

begin
  result := inherited DoMouseWheel (Shift, WheelDelta, MousePos);
  //JH April 2002, simple increment of date with mouse wheel
  if (FMaskType = meDate) and not ReadOnly  then
    ToDate (Sign (WheelDelta));
  if (FMaskType = meTime) and not ReadOnly  then
    ToTime (Sign (WheelDelta));
  if (FMaskType = meDateTime) and not ReadOnly  then
  begin
    dl := FDateSet.DateLength(FText);
    if CurrentChar < dl then
      ToDate(Sign (WheelDelta))
    else
      ToTime(Sign (WheelDelta));
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.ToTime (step: Integer);
var
  c : Integer;
  ct, lcurdate: TDateTime;
  dl: integer;
  vl: TDateTime;
begin
  c := CurrentChar;
  ct := AsTime;

  if FMaskType = meDateTime then
  begin
    lcurdate := AsDate;
    dl := FDateSet.DateLength(FText);
    FTimeSet.Offset := dl;
  end
  else
  begin
    lcurdate := 0;
    dl := 0;
  end;

  case FTimeSet.CurrentType(CurrentChar, FText) of
    1 , 2: ct := ct + step * MinsPerHour * SecsPerMin / SecsPerDay;  //hours
    11,12: ct := ct + step * SecsPerMin * MSecsPerSec / MSecsPerDay; //minutes
    21,22: ct := ct + step * MSecsPerSec / MSecsPerDay;              //seconds
    31:    if ct > 0.040972222222 then //time less than 0:59 is always am
           begin
             if SelText = FTimeSet.AMSign then
               ct := ct + 12 * MinsPerHour * SecsPerMin / SecsPerDay  //+12 hrs am pm change
             else
               ct := ct - 12 * MinsPerHour * SecsPerMin / SecsPerDay;  //+12 hrs am pm change
           end;
  end;
  if ct < 0 then
    ct := ct + 1; //00:00 -> 23:59

  case FMaskType of
    meTime:
      Text := FTimeSet.TimeToStr(ct);
    meDateTime:
    begin
      vl := trunc(lcurdate) + ct;
      Text := DateTimeString(vl);
    end;
  end;

  CurrentChar := c;
  SelStart := CurrentChar;
  FTimeSet.Offset := dl;
  SelLength := FTimeSet.CurrentLength(CurrentChar, FText);
  FTimeSet.Offset := 0;
end;


{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.ToDate (step: Integer);
var
  y,m,d,ld: Word;
  c : Integer;
  lnewdate: TDateTime;
  lcurtime: TDateTime;
begin

  c := CurrentChar;
  if FMaskType = meDateTime then
    lcurtime := AsTime
  else
    lcurtime := 0;

  lnewdate := 0;
  case FDateSet.CurrentType(CurrentChar, FText) of
     1,2 : lnewdate := AsDate + step; //day
     11,
     12,
     13,
     14  : begin //month
             DecodeDate (AsDate, y, m, d);
             m := m + step;
             if m = 13 then m := 1;
             if m = 0 then m := 12;
             ld := FDateSet.LastMonthDay(y, m);
             if (d > ld) then
               d := ld;
             try
               lnewdate := EncodeDate (y,m,d);
             except
               on Exception do DoValidationError;
             end;
           end;
     21,
     22,
     23,
     24  : begin //year
             DecodeDate (AsDate, y, m, d);
             try
               lnewdate := EncodeDate (y + step,m,d);
             except
               on Exception do DoValidationError;
             end;

           end;
  end;
  case FMaskType of
  meDate:
    Text := FDateSet.GetDTEditString(lnewdate);
  meDateTime:
    Text := DateTimeString(trunc(lnewdate) + lcurtime);
  end;

  CurrentChar := c;
  SelStart := CurrentChar;
  SelLength := FDateSet.CurrentLength(CurrentChar, FText);  
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.AllowedOperation(textToInsert : TLMDString) : Boolean;

var
  d: byte;
  cs2,s: TLMDString;

  procedure NextChar;
  begin
    if FCommandKey <> VK_DELETE then
    begin
    if FCommandKey = VK_BACK then
      CurrentChar := CurrentChar - 1
    else
      CurrentChar := CurrentChar + 1;
    if CurrentChar < 1 then CurrentChar := 1;
    if CurrentChar >= Length(FText) then CurrentChar := Length(FText);
    end;
  end;

begin
  result := inherited AllowedOperation(textToInsert);
  //VB March 2006: bts 372 fix
  if result and (FMaskType in [meFloatFixed, meFloatNumber, meCurrency]) and (CurrentChar>=1) and (CurrentChar<=Length(FText)) then
    begin
      cs2 := AnsiChar(FDecimalDelim)+ '-' + AllowedCharsWithZero;
      if (textToInsert='') and
         (SelLength = 1) and
         (SelStart + SelLength <= Length(FText)) and
         (FText[SelStart+SelLength]=TLMDChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator)) and
         ((SelStart=1) or (SelStart>1) and (Pos(FText[SelStart-1], AllowedChars)=0)) then
        begin
          SelText := '0';
          SelLength := 0;
          NextChar;
          SelStart := CurrentChar;
          result := false;
        end
      else
    if (FText[CurrentChar]=TLMDChar(FDecimalDelim)) and (not (emInsert in LMDApplication.EditMode) or FForceOverwriteMode) then
        begin
          if (FMaskType = meCurrency) and (textToInsert='-') then
            CurrentChar := Pos(FCurSet.Symbol, FText)
          else
            begin
              NextChar;
        if (FCommandKey = VK_DELETE) then
          CurrentChar := CurrentChar + 1;
        if (CurrentChar >= length(FText)) then
                result := false;
            end;
          SelStart := CurrentChar;
          SelLength := 0;
        end
      else
      if (SelText = {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator) and (textToInsert='') then
        begin
          SelLength := 0;
          NextChar;
          SelStart := CurrentChar;
          result := false;
        end
      else
      if (Pos(FText[CurrentChar],cs2) = 0) and
         not (emInsert in LMDApplication.EditMode) and
         (FMaskType=meCurrency)
         and (CurrentChar<Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator,FText)) then
        begin
          SelLength := 0;
          NextChar;
          SelStart := CurrentChar;
          result := false;
        end
      else
      if (textToInsert='-') and not (emInsert in LMDApplication.EditMode) then
        begin
          SelLength := 0;
          CurrentChar := Pos(FCurSet.Symbol,FText);
          SelStart := CurrentChar;
        end
    end;
  if result and (TextToInsert <> '') and (FMaskType in [meInteger, meFloat, meFloatFixed, meFloatNumber]) then
    begin
      s := GetPureText;
      d := 1;
      if emInsert in LMDApplication.EditMode then
        d := 2;
      if (s <> '') then
        //if we are in the suffix we do not allow to enter anything
        if (SelLength <> Length(FText)) and (GetSuffix <> '') and (CurrentChar >= Length(FText) - Length (GetSuffix) + d) then
          result := false;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.GetChange (Sender : TObject);
begin
  inherited GetChange (Sender);
//  if (Sender is FCurSet) then
//    self.ChangedText (0);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.IsTextStored: boolean;
begin
  result := true;
  if FMaskType in [meWord, meInteger, meFloat, meFloatFixed, meFloatNumber, meCurrency, meDate, meTime] then
    result := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.CalcMousePos(Pos : TSmallPoint) : Integer;
var
  dl, s, e, t : Integer;

  procedure HandleDate;
  begin
    //date_pos (we are on pattern x)
    //fix year input, if needed
    //FDateSet.GetPatInfo (FDateSet.GetPattern (CurrentChar, FText), FText, s, e, t);
    FDateSet.GetPatInfo (FDateSet.GetPattern (result, FText), FText, s, e, t);
    result := s;
  end;

  procedure HandleTime;
  begin
    //FTimeSet.GetPatInfo (FTimeSet.GetPattern (CurrentChar, FText), FText, s, e, t);
    FTimeSet.GetPatInfo (FTimeSet.GetPattern (result, FText), FText, s, e, t);
    result := s;
  end;

begin
  result := inherited CalcMousePos (Pos);
  case FMaskType of
    meDate : HandleDate;
    meTime : HandleTime;
    meDateTime:
             begin
               dl := FDateSet.DateLength(FText);
               if result < dl then
                 HandleDate
               else
               begin
                 FTimeSet.Offset := dl;
                 HandleTime;
                 FTimeSet.Offset := 0;
               end;
             end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.DateFormatChange (Sender : TObject);
begin
  case MaskType of
    meDate: FSavedDateTime := FDateSet.StrToDate (GetPureText);
    meTime: FSavedDateTime := FTimeSet.StrToTime (GetPureText);
    meDateTime: Text := FDateSet.DateToStr (FSavedDateTime) + ' ' + FTimeSet.TimeToStr (FSavedDateTime);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.DateFormatChanged (Sender : TObject);
begin
  case MaskType of
    meDate: Text := FDateSet.DateToStr (FSavedDateTime);
    meTime: Text := FTimeSet.TimeToStr (FSavedDateTime);
    meDateTime: Text := DateTimeString (FSavedDateTime);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.DateTimeString(aDateTime: TDatetime): TLMDString;
begin
  result := FDateSet.DateToStr (trunc(aDateTime)) + ' ' + FTimeSet.TimeToStr (frac(aDateTime));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.CheckNumberRange;
var
  v: Extended;
begin
  if GetPureText = '-' then //added June 02, JH, will prevent the control
                            //from having a single - as input
    Text := '';

  if not RangeCheck then exit;
  v := FMinValue;
  case FMaskType of
    meFloat,
    meFloatFixed,
    meFloatNumber: v := AsFloat;
    meInteger,
    meWord       : v := AsInteger;
    meCurrency   : v := AsCurrency;
    meDate       : v := AsDate;
    meTime       : v := AsTime;
  end;
  if (v > FMaxValue) then
    begin
      if Assigned (FOnRangeError) then FOnRangeError (self, FMinValue, FMaxValue, v);
      if (v > FMaxValue) then v := FMaxValue;
      SetValue (v);
    end;
  if (v < FMinValue) then
    begin
      if Assigned (FOnRangeError) then FOnRangeError (self, FMinValue, FMaxValue, v);
      if (v < FMinValue) then v := FMinValue;
      SetValue (v);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.GetSuffix: TLMDString;
begin
  result := FSuffix;
  case FMaskType of
    meCurrency,
    meMask,
    meDate,
    meTime: result := '';
  end;
end;

{ ------------------------------------ public -------------------------------- }
constructor TLMDCustomMaskEdit.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FMask := '';
  FMaskType := meMask; //user defined mask
  FNumberBase := 10; // 10er System
  FBlankChar := '_';
  FProcessBlankChar := false;
  FSuppressBlankCharOnDelete := false;
  FDecimals := 1;

  FThousandDelim := TLMDChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ThousandSeparator);
  FDecimalDelim := TLMDChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator);

  FCurSet := TLMDCurrencySettings.Create;
  FCurSet.OnChange := GetChange;
  FDateSet := TLMDDateFormat.Create;
  FDateSet.OnChange := GetChange;
  FDateSet.OnFormatChange := DateFormatChange;
  FDateSet.OnFormatChanged := DateFormatChanged;
  FTimeSet := TLMDTimeFormat.Create;
  FTimeSet.OnChange := GetChange;
  FTimeSet.OnFormatChange := DateFormatChange;
  FTimeSet.OnFormatChanged := DateFormatChanged;

  FMinValue := -1;
  FMaxValue := -1;
  FRangeCheck := false;  

  //todo: add string res & raise exception instead of showmessage
  if FThousandDelim = FDecimalDelim then
    ShowMessage('Decimal and thousand separators must differ!');
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomMaskEdit.Destroy;
begin
  FDateSet.OnChange := nil;
  FDateSet.Free;
  FCurSet.OnChange := nil;
  FCurSet.Free;
  FTimeSet.OnChange := nil;
  FTimeSet.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.Loaded;
var
  i : Integer;
  c : Currency;
  lIsFloat: boolean;
begin
  inherited Loaded;
  lIsfloat := (FMaskType in [meFloat, meFloatFixed, meFloatNumber]);
  //This check is for reading older forms where Text is stored instead of Value
  //For newer Forms (lmdtools8 and higher) this check will never trigger
  if (lIsFloat) and (FText <> '') then
    begin
      i := length(FText);
      while (Pos (FText[i], System.Copy(AllowedCharsWithZero, 1, FNumberBase)) <> 0) and (i > 1) do
        dec(i);
      if (Pos (FText[i], System.Copy(AllowedCharsWithZero, 1, FNumberBase)) = 0) and (i > 1) then
        FText[i] := FDecimalDelim;
    end;
  if FMaskType = meMask then
    begin
      if not checkText(Text) then //VB Nov 2009
        Text := literalChars;
    end;
  if FMaskType = meDate then
    FUserSelect := false;
  //reload system default values, Okt 2001, JH
  if FCurSet.SystemDefaults = cmSystem then
    try
      c := 0; //and the compiler remains quiet
      //get value according to actual formatting rules
      if FMaskType = meCurrency then //added JH, Okt 2001
        c := FCurSet.toCur (Text);
      //change rules
      FCurSet.LoadDefaults;
      //reset value according to new formatting rules
      if FMaskType = meCurrency then //added JH, Okt 2001
        Text := FCurSet.toStr (c);
    except
      On Exception do ;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.NextEditChar : Integer;
var
  dl, i: Integer;

  procedure HandleDate;
  begin
    result := FDateSet.NextEditPos (Currentchar, FText);
    dep := 0;
  end;

  procedure HandleTime;
  begin
    result := FTimeSet.NextEditPos (Currentchar, FText);
    dep := 0;
  end;

begin
  result := 1;
  case FMaskType of
    meMask:
      begin
        i := CurrentChar;
        while (isLiteral (i)) and (i < Length (literalChars)) do inc(i);
        result := i;
      end;
    meDate: //next is always something like D, DD, Y, YY, YYYY, M, MM, MMM, MMMM
      HandleDate;
    //end of meDate
    meTime:
      HandleTime;
    //end of meTime
    meDateTime:
      begin
        dl := FDateSet.DateLength(FText);
        if CurrentChar < dl then
          HandleDate;
        if (CurrentChar = result) or (CurrentChar > dl) then
        begin
          FTimeSet.Offset := dl;
          HandleTime;
          FTimeSet.Offset := 0;
        end;
      end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.PrevEditChar : Integer;
var
  dl, i: Integer;

  procedure HandleDate;
  begin
    result := FDateSet.PrevEditPos (Currentchar, FText);
    dep := 0;
  end;

  procedure HandleTime;
  begin
    result := FTimeSet.PrevEditPos (Currentchar, FText);
    dep := 0;
  end;

begin
  result := 1;
  case FMaskType of
    meMask:
      begin
        i := CurrentChar;
        while (isLiteral (i)) and (i > 1) do dec(i);
        result := i;
      end;
    meDate: HandleDate;
    meTime: HandleTime;
    meDateTime:
      begin
        dl := FDateSet.DateLength(FText);
        if CurrentChar > dl then
        begin
          FTimeSet.Offset := dl;
          HandleTime;
          FTimeSet.Offset := 0;
        end;
        if (CurrentChar = result) or (CurrentChar <= dl) then
          HandleDate;
        if (CurrentChar >= dl) and (result = 1) then
        begin
          CurrentChar := dl - 1;
          HandleDate;
          result := FDateSet.NextEditPos (Currentchar, FText);
        end;
      end;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDCustomMaskEdit.FormatTextByMask(const AUnMaskedText: TLMDString): TLMDString;
var
  s, r: TLMDString;
  i, j : integer;
begin
  if MaskType <> meMask then
  begin
    Result := AUnMaskedText;

    Exit;
  end;

  r := '';
  s := literalChars;
  i := 1;
  j := 1;
  while (i <= Length(s)) and (j <= Length(AUnMaskedText)) do
    begin
      if (s[i] = TLMDChar(BlankChar)) or (s[i] = AUnMaskedText[j]) then
        begin
          r := r + AUnMaskedText[j];
          inc(j);
        end
      else
        r := r + s[i];
      inc(i);
    end;

  Result := r;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.CutToClipboard;
begin
  if GetSuffix <> '' then
    if SelStart + SelLength > Length(FText) - Length (GetSuffix) + 1 then
      exit;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.ForceMaskValidation;
begin
  Self.Perform(WM_KILLFOCUS, 0, 0);
  Self.Perform(WM_SETFOCUS,  0, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.PasteFromClipboard;
begin
  if GetSuffix <> '' then
    if SelStart + SelLength > Length(FText) - Length (GetSuffix) + 1 then
      exit;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.GetPureText: TLMDString;
var
  Suff: TLMDString;
  SuffPos: integer;
begin
  result := FText;
  Suff := GetSuffix;
  SuffPos := AnsiPos(Suff, FText);
  if (Suff <> '') and (SuffPos > 0)  then
    Delete (result, SuffPos, Length(Suff))
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.GetUnMaskedText: TLMDString;
var
  s1,s2: TLMDString;
  i : integer;
begin
  s2 := GetPureText;
  if MaskType <> meMask then
    begin
      result := s2;
      exit;
    end;
  result := '';
  s1 := literalChars;
  i := Length(S2);
  while i >= 1 do
    begin
      if s2[i] <> s1[i] then
        result := s2[i] + result;
      dec(i);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetUnMaskedText(aValue: TLMDString);
begin
  Text := FormatTextByMask(aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetTextWithSuffix (aValue: TLMDString);
begin
  Text := aValue + GetSuffix;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.GetAsInteger : Integer;
var
  LPureText: TLMDString;
  r: Int64;
begin
  result := 0;
  if not (FMaskType in [meInteger, meMask]) then
    raise ELMDWrongDataType.Create ('No integer entered');
  if FMaskType = meInteger then
    LPureText := GetPureText
  else
    LPureText := UnMaskedText;
  if LPureText <> '' then
    try
      r := LMDGetDecimalValue (FNumberBase, LPureText);
      if (r > MAXINT) or (r < -MAXINT) then
        DoValidationError
      else
        result := r;  
    except
      on Exception do DoValidationError;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.GetAsCardinal : Cardinal;
var
  LPureText: TLMDString;
begin
  result := 0;
  if FMaskType <> meWord then
    raise ELMDWrongDataType.Create ('No word entered');
  LPureText := GetPureText;
  if LPureText <> '' then
    try
      result := LMDGetDecimalValue (FNumberBase, LPureText);
    except
      on Exception do DoValidationError;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.GetAsInt64 : Int64;
var
  LPureText: TLMDString;
begin
  result := 0;
  if FMaskType <> meInteger then
    raise ELMDWrongDataType.Create ('No integer entered');
  LPureText := GetPureText;
  if LPureText <> '' then
    try
      result := LMDGetDecimalValue (FNumberBase, LPureText);
    except
      on Exception do DoValidationError;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.GetAsFloat : Double;
var
  DecimalTextLen, c: integer;
  LPureText: TLMDString;
begin
  result := 0;
  if not (FMaskType in [meFloat, meFloatFixed, meFloatNumber, meCurrency]) then //meCurrency added VB aug 2006
    raise ELMDWrongDataType.Create ('No float entered');
  LPureText := LMDClearTS(GetPureText);
  if LPureText <> '' then
    try
      DecimalTextLen := 0;
      c := AnsiPos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, LPureText);
      if c > 0 then
        DecimalTextLen := length(LPureText) - c;
      //VB Dec 2006 this is to avoid round in FloatToStrF (this check moved here from ChangedText)
      //VB Dec 2008: "(MaskType <> meFloat)" added so that AsFloat returned rounded value
      //(it also makes it impossible to enter more digits than Decimals after decimal separator)
      if (MaskType <> meFloat) and (Decimals < DecimalTextLen) then
        if c > 0 then
          LPureText := System.Copy(LPureText, 1, c + Decimals);
      result := LMDGetDecimalFloatValue (FNumberBase, LPureText);
    except
      on Exception do DoValidationError;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.GetAsDate : TDateTime;
var
  LPureText: TLMDString;
  dl: integer;
begin
  result := 0; //added June 02 by JH
  if not (FMaskType in [meDate, meDateTime]) then
    raise ELMDWrongDataType.Create ('No date entered');
  LPureText := GetPureText;
  if LPureText <> '' then
    try
      if FMaskType = meDateTime then
      begin
        dl := FDateSet.DateLength(LPureText);
        LPureText := System.Copy(LPureText, 1, dl - 1);
      end;
      result := FDateSet.StrToDate (LPureText);
      if result = 0 then
        result := FDateSet.StrToDate (FOldText);
    except
      on Exception do
        begin
          DoValidationError;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.GetAsTime : TDateTime;
var
  dl: integer;
  s: TLMDString;
begin
  result:=0;
  if not (FMaskType in [meTime, meDateTime]) then
    raise ELMDWrongDataType.Create ('No time entered');
  try
    //result := StrToTime (GetPureText);
    s := GetPureText;
    if FMaskType = meTime then
      result := FTimeSet.StrToTime (s)
    else
    begin
      dl := FDateSet.DateLength(s);
      System.Delete(s, 1, dl);
      result := FTimeSet.StrToTime (s);
    end;
  except
    on Exception do DoValidationError;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.GetAsDateTime : TDateTime;
var
  dl: integer;
  ldstr, ltstr: TLMDString;
begin
  result:=0;
  if not (FMaskType in [meDate, meTime, meDateTime]) then
    raise ELMDWrongDataType.Create ('No datetime entered');
  try
    ltstr := GetPureText;
    dl := FDateSet.DateLength(ltstr);
    ldstr := System.Copy(ltstr, 1, dl - 1);
    Delete(ltstr, 1, dl);
    result := FDateSet.StrToDate (ldstr) + FTimeSet.StrToTime (ltstr);
  except
    on Exception do DoValidationError;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.GetAsCurrency : Double;
var
  LPureText: TLMDString;
begin
  result := 0;
  LPureText := GetPureText;
  if LPureText <> '' then
  try
    result := FCurSet.toCur (LPureText);
  except
    on Exception do DoValidationError;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.GetAsString : TLMDString;
begin
  result := GetPureText;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetAsCardinal(const Value: Cardinal);
begin
  SetValue(Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetAsCurrency(const Value: Double);
begin
  SetValue(Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetAsFloat(const Value: Double);
begin
  SetValue(Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetAsInt64(const Value: Int64);
begin
  SetValue(Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetAsInteger(const Value: Integer);
begin
  SetValue(Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetAsString(const Value: TLMDString);
begin
  Text := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetAsTime(const Value: TDateTime);
begin
  SetValue(Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetAsDate(const Value: TDateTime);
begin
  SetValue(Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetAsDateTime(const Value: TDateTime);
begin
  SetValue(Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMaskEdit.SetValue (aValue: Double);
begin
  case FMaskType of
    meCurrency     : SetTextWithSuffix(FCurSet.toStr(aValue));
    meFloatNumber  : SetTextWithSuffix(LMDFloatToStrF (aValue, ffNumber, FNumberBase, Decimals, Decimals));
    meFloatFixed   : SetTextWithSuffix(LMDFloatToStrF (aValue, ffFixed, FNumberBase, Decimals, 1));
    meFloat        : SetTextWithSuffix(LMDFloatToStrF (aValue, ffGeneral, FNumberBase, Decimals, Decimals));
    meInteger      : SetTextWithSuffix(LMDGetBaseString (FNumberBase, Trunc (aValue)));
    meWord         : SetTextWithSuffix(LMDGetBaseString (FNumberBase, Abs(Trunc (aValue))));
    meDate         : SetTextWithSuffix(FDateSet.GetDTEditString(aValue));
    meTime         : SetTextWithSuffix(TimeSettings.TimeToStr (aValue));
    meDateTime     : SetTextWithSuffix(FDateSet.GetDTEditString(aValue) + ' ' + FTimeSet.TimeToStr (aValue));
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMaskEdit.GetValueToValidate: TLMDString;
begin
  result := GetPureText;
end;

end.

