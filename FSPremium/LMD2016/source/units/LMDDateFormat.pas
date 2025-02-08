unit LMDDateFormat;
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

LMDDateFormat unit ()
---------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDObject;

type
  TLMDDateFormats = (dfShortSystem, dfLongSystem, dfCustom);

  TLMDDateFormat = class (TLMDObject)
  private
    FFormatStr : String;
    FFormat    : TLMDDateFormats;
    FYearDelta : ShortInt;
    FOnFormatChanged : TNotifyEvent;
    FOnFormatChange : TNotifyEvent;

    procedure SetFormatStr (aValue : String);
    procedure SetFormat (aValue : TLMDDateFormats);
  public
    constructor Create(Owner:TPersistent=nil); override;
    procedure Assign (Source : TPersistent); override;
    function LastMonthDay(y, m: word): word;
    procedure DoFormatChanged;
    procedure DoFormatChange;
    function GetFormatStr : String;
    function DateToStr (date : TDateTime) : String;
    procedure StrToYMD (str  : String; var Y, M, D : Word);
    function StrToDate (str  : String) : TDateTime;
    function GetEditString (Y, M, D : Word) : String;
    function GetDTEditString (dt : TDateTime) : String;
    function GetLongMonthExtend : Integer;
    function GetShortMonthExtend : Integer;
    function GetLongDayExtend : Integer;
    function GetShortDayExtend : Integer;
    function NextEditPos (current : Integer; text : String) : Integer;
    function PrevEditPos (current : Integer; text : String) : Integer;
    function CurrentLength (current : Integer; text : String) : Integer;
    function CurrentStart (current : Integer; text : String) : Integer;
    function CurrentType (current : Integer; text : String) : Integer;
    function DateLength(text: String): integer;
//    procedure GetPatInfo (pat : Integer; var start, ende, typ : Integer);
    function GetPattern (current : Integer; text : String) : Integer;
    procedure GetPatInfo (pattern : Integer; text : String; var pat_start, pat_end, pat_type : Integer);
    function CurrentYear: Word;
    function GetYearDelta: Word;

    property OnFormatChanged : TNotifyEvent read FOnFormatChanged write FOnFormatChanged;
    property OnFormatChange : TNotifyEvent read FOnFormatChange write FOnFormatChange;    
  published
    property FormatStr : String read FFormatStr write SetFormatStr;
    property Format    : TLMDDateFormats read FFormat write SetFormat default dfShortSystem;
    property YearDelta : ShortInt read FYearDelta write FYearDelta default -1;
  end;

implementation

uses
  Windows,
  SysUtils;

const MonthDays:array[1..12] of word = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

{ ---------------------------------------------------------------------------- }
procedure TLMDDateFormat.SetFormatStr (aValue : String);
begin
  if aValue <> FFormatStr then
    begin
      DoFormatChange;
      FFormatStr := aValue;
      if FFormat = dfCustom then
        DoFormatChanged;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDateFormat.SetFormat (aValue : TLMDDateFormats);
begin
  if aValue <> FFormat then
    begin
      FFormat := aValue;
      DoFormatChanged;
    end;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDDateFormat.Create;
begin
  inherited Create;
  FYearDelta := -1;
  FFormat := dfShortSystem;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDateFormat.Assign (Source : TPersistent);
begin
  if source is TLMDDateFormat then
    with  TLMDDateFormat(Source) do
      begin
        self.FFormat := Format;
        self.FYearDelta := YearDelta;
        self.FFormatStr := FormatStr;      
        exit;
      end;
  inherited Assign (Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDateFormat.DoFormatChanged;
begin
  if Assigned (FOnFormatChanged) then FOnFormatChanged (self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDateFormat.DoFormatChange;
begin
  if Assigned (FOnFormatChange) then FOnFormatChange (self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateFormat.GetFormatStr : String;

   function ReplaceSlash : String;
   begin
     Result := StringReplace(FFormatStr, '/', {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DateSeparator, [rfReplaceAll]);
   end;

begin
  result := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortDateFormat;
  case FFormat of
    dfCustom : result := ReplaceSlash;
    dfLongSystem : result := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongDateFormat;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateFormat.DateToStr (date : TDateTime) : String;
var
  Y, M, D : Word;
  valstr,
  fmt_str : String;
begin
  fmt_str := UpperCase(GetFormatStr);

  DecodeDate (date, Y, M, D);

  result := '';
  //step through the whole format string
  while fmt_str <> '' do
    begin
      //copy any chars before the first value to be added
      while (fmt_str <> '') and not (AnsiChar(fmt_str[1]) in ['Y','M','D'])  do
        begin
          result := result + fmt_str[1];
          Delete (fmt_str, 1, 1);
        end;
      if fmt_str = '' then exit; //ready
      //find out which format the value to be added has
      valstr := fmt_str[1];
      Delete (fmt_str, 1, 1);
      while (fmt_str <> '') and (fmt_str[1] = valstr[1]) do
        begin
          valstr := valstr + fmt_str[1]; //+valstr[1] (equal)
          Delete (fmt_str, 1, 1);
        end;
      //now valstr contains D, DD, DDD, DDDD, M, MM, MMM, MMMM, Y, YY, YYYY
      case valstr[1] of
        'D' : begin
                case Length(valstr) of
                  1 : result := result + IntToStr (D);
                  2 : if Length (IntToStr (D)) = 1 then
                        result := result + '0' + IntToStr (D)
                      else
                        result := result + IntToStr (D);
                  3 : result := result + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortDayNames[DayOfWeek(date)];
                  4 : result := result + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongDayNames[DayOfWeek(date)];
                end;
              end;
        'M' : begin
                case Length(valstr) of
                  1 : result := result + IntToStr (M);
                  2 : if Length (IntToStr (M)) = 1 then
                        result := result + '0' + IntToStr (M)
                      else
                        result := result + IntToStr (M);
                  3 : result := result + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortMonthNames[M];
                  4 : result := result + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongMonthNames[M];
                end;
              end;
        'Y' : begin
                case Length(valstr) of
                  1, 4 : result := result + IntToStr (Y); //4 digits
                  2 : if Length (IntToStr (Y mod 100)) = 1 then //2 digits
                        result := result + '0' + IntToStr (Y mod 100)
                      else
                        result := result + IntToStr (Y mod 100);
                end;
              end;
      end; //end of case valstr[1]
    end; //end of while
end;

{ ---------------------------------------------------------------------------- }
//Note: This will only work with date strings matching to the selected format!!
procedure TLMDDateFormat.StrToYMD (str  : String; var Y, M, D : Word);
var
  ys,
  i, j, n  : Integer;
  s,
  fmt_str  : String;

  function GetNextNumber : Integer;
  var
    m,
    i : Integer;
  begin
    result := 0;
    i := 1;

    m := 2; //only for format dd, mm, yy
    if Length(s) = 4 then m := 4; //yyyy
    //not possible: d, m, y, yyy

    while (str <> '') and (AnsiChar(str[1]) in ['0'..'9']) and (i <= m) do
      begin
        result := result * 10 + Ord(str[1]) - 48;
        Delete (str, 1, 1);
        inc(i);
      end;
  end;

  function GetFromMonthName(l : boolean) : Integer;
  //l = true => ShortMonthNames
  var
    s : string;

    function isIn : Integer;
    var
      i : Integer;
    begin
      i := 0;
      repeat
       inc(i);
      until (i = 13) or (l and (UpperCase({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortMonthNames[i]) = UpperCase(s)))
                     or (not l and (UpperCase({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongMonthNames[i]) = UpperCase(s)));
      result := i;
      if i = 13 then
        result := 0;
    end;

  begin
    s := '';
    while (isIn = 0) and (str <> '') do
      begin     //while the string found so far is none valid month name go on looking
        s := s + str[1];
        Delete (str, 1, 1);
      end;
    result := isIn;
  end;

  function isDayName(l : Boolean; s : String) : Boolean;
  var
    i : Integer;
  begin
    i := 0;
    repeat
     inc(i);
    until (i = 8) or (l and (UpperCase({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortDayNames[i]) = UpperCase(s)))
                  or (not l and (UpperCase({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongDayNames[i]) = UpperCase(s)));
    result := true;
    if i = 8 then
      result := false;
  end;

  procedure DeleteFurtherSpaces;
  begin
    while (str <> '') and (str[1] = ' ') do
      Delete (str, 1, 1);
  end;

begin
  //init Y, M ,D (if one part is missing in the format string it will be ignored here)
  Y := 1899;
  M := 12;
  D := 30;
  if (str <> '') then
  begin
   //two strings:
    //the format string and the date string
    fmt_str := UpperCase(GetFormatStr);

    i := 1;
    while i < Length (fmt_str) do
      begin
        //first thing to do: search for Y, M, D in the format string
        while not (AnsiChar(fmt_str[i]) in ['M', 'Y', 'D']) do
          begin
            inc(i);
            //chars at these positions can't be of interest
            //e.g. XXXX MM : this loop will terminate with i = 6, all chars up to the M will be deleted (5)
            delete (str, 1, 1);
            // 7.0.61 RM
            if str='' then exit;
            // prevents endless loops if suffix is available
          end;

        //there could be some more spaces in the str string, let's remove them
        //if this string was retrieved by oour GetEditString ...
        DeleteFurtherSpaces;

        //now we are on the first found information
        //let's extract this info
        j := i;
        s := '';
        while (j <= Length (fmt_str)) and (fmt_str[j] = fmt_str[i]) do
          begin
            s := s + fmt_str[j];
            inc(j);
          end;

        //now j is behind the pattern of YYYY, YY, Y, M, MM, MMMM, D, DD, DDDD

        s := UpperCase (s);

        if (s <> 'DDDD') and (s <> 'DDD') then //Mo, Monday, Tu, ....
          begin
            if (s <> 'MMMM') and (s <> 'MMM') then
              n := getNextNumber
            else //name of month
              begin
                if s = 'MMM' then
                  n := GetFromMonthName (true) //short
                else
                  n := GetFromMonthName (false); //long
              end;
            case UpCase(fmt_str[i]) of
              'Y' : begin
                      Y := n;
                      ys := GetYearDelta;
                      if {(s = 'YY') and} (Y < 100) then //enter whenever date < 100
                        begin
                          n := CurrentYear div 100 * 100; // actual century
                          if (Y > ys) then
                            dec(n, 100);
                          inc (y, n);
                        end;
                    end;
              'M' : begin
                      M := n;
                    end;
              'D' : begin
                      D := n;
                    end;
            end;
          end
        else //let's remove Short or LongDayName from the input string
          begin
            case Length (s) of
              3 : begin //ShortDayNames
                    s := '';
                    while (str <> '') and not isDayName (true, s) do
                      begin
                        s := s + str[1];
                        delete (str, 1, 1);
                      end;
                  end;
              4 : begin //LongDayNames
                    s := '';
                    while (str <> '') and not isDayName (false, s) do
                      begin
                        s := s + str[1];
                        delete (str, 1, 1);
                      end;
                  end;
            end;
          end; //end of s = 'DDD' or  'DDDD'
        //let's continue search at j
        i := j;
        if (i <= Length (fmt_str)) and (fmt_str[i] <> ' ') then
          DeleteFurtherSpaces;
      end; //end of while
    //encode the date: remember that not all values must be from the date string (if not present they can't)
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateFormat.StrToDate (str  : String) : TDateTime;
var
  H,
  Y, M, D : Word;
begin
  StrToYMD (str, Y, M, D);
  try
    H := 28;
    if isLeapYear (Y) then inc (H);
    if (M = 2) and (D > H) then
      D := H;
    result := EncodeDate (Y, M, D);
  except
    //raise Exception.Create ('Invalid date format!');
    result := 0;
  end;
end;

{function TLMDDateFormat.UnknownStrToDate (str  : String) : TDateTime;
begin
end;}

{ ---------------------------------------------------------------------------- }
function TLMDDateFormat.GetEditString (Y, M, D : Word) : String;

   function AddSpaces (const s : String; upTo : Integer) : String;
   begin
     result := s;
     while Length(result) < upTo do
       result := result + ' ';
   end;

var
  i,
  lme,
  lde,
  sme,
  sde : Integer;
  fmt_str : String;
begin
  lme := GetLongMonthExtend;
  sme := GetShortMonthExtend;
  lde := GetLongDayExtend;
  sde := GetShortDayExtend;

  fmt_str := GetFormatStr;
  result := '';

//  j := 0;

  while fmt_str <> '' do
    begin
//      inc(j);
      case UpCase (fmt_str[1]) of
        'D', 'M', 'Y' : begin
                          i := 1;
                          while (Length(fmt_str) > 1)
                                and (UpCase (fmt_str[2]) = UpCase (fmt_str[1])) do
                            begin
                              inc(i);
//                              inc(j);
                              Delete (fmt_str, 2, 1);
                            end;
                          //M and MM or D and DD are the same for the edit string ...
                          //usually not!! because DD means with leading zero if <10
                          //so DD => "07" and D => "7 "  !!!!!!!!!
                          case UpCase (fmt_str[1]) of
                            'D' : case i of
                                    2 : if (D < 10) then result := result + AddSpaces ('0'+IntToStr (D), 2)
                                                  else result := result + AddSpaces (IntToStr (D), 2);          //NH 20.07.2000 !!!
                                    4 : result := result + AddSpaces ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongDayNames[DayOfWeek (EncodeDate (Y, M, D))], lde);
                                    3 : result := result + AddSpaces ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortDayNames[DayOfWeek (EncodeDate (Y, M, D))], sde);
                                  else
                                    result := result + AddSpaces (IntToStr (D), 2);
                                  end;
                            'M' : case i of
                                    2 : if (M < 10) then result := result + AddSpaces ('0'+IntToStr (M), 2)
                                                  else result := result + AddSpaces (IntToStr (M), 2);          //NH 20.07.2000 !!!
                                    4 : result := result + AddSpaces ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongMonthNames[M], lme);
                                    3 : result := result + AddSpaces ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortMonthNames[M], sme);
                                  else
                                    result := result + AddSpaces (IntToStr (M), 2);
                                  end;
                            'Y' : case i of
                                    2 : if Length(IntToStr (Y mod 100)) < 2 then
                                          result := result +'0'+ IntToStr (Y mod 100)
                                        else
                                          result := result + IntToStr (Y mod 100);
                                  else
                                    result := result + IntToStr (Y);
                                  end;
                          end;
                        end;
      else
        result := result + fmt_str[1];
      end;
      Delete (fmt_str, 1, 1);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateFormat.GetDTEditString (dt : TDateTime) : String;
var
  y, m, d : Word;
begin
  DecodeDate (dt, y, m , d);
  result := GetEditString (Y, M, D);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateFormat.GetLongMonthExtend : Integer;
var
  i : Integer;
begin
  result := Length ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongMonthNames[1]);
  for i := 2 to 12 do
    if result < Length ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongMonthNames[i]) then
      result := Length ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongMonthNames[i]);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateFormat.GetLongDayExtend : Integer;
var
  i : Integer;
begin
  result := Length ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongDayNames[1]);
  for i := 2 to 7 do
    if result < Length ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongDayNames[i]) then
      result := Length ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongDayNames[i]);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateFormat.GetShortMonthExtend : Integer;
var
  i : Integer;
begin
  result := Length ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortMonthNames[1]);
  for i := 2 to 12 do
    if result < Length ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortMonthNames[i]) then
      result := Length ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortMonthNames[i]);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateFormat.GetShortDayExtend : Integer;
var
  i : Integer;
begin
  result := Length ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortDayNames[1]);
  for i := 2 to 7 do
    if result < Length ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortDayNames[i]) then
      result := Length ({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortDayNames[i]);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateFormat.NextEditPos (current : Integer; text : String) : Integer;
var
  s, e, t : Integer;
begin
  s := GetPattern(current, text);
  GetPatInfo (s + 1, text, s, e, t);
  if t = 0 then //no next pattern
    GetPatInfo (GetPattern(current, text),text,  s, e, t);
  result := s;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateFormat.PrevEditPos (current : Integer; text : String) : Integer;
var
  s, e, t,
  i : Integer;
begin
  i := GetPattern (current, text) - 1;
  if i > 0 then
    begin
      GetPatInfo (i, text, s, e, t);
      result := s;
    end
  else //no previous
    result := 1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateFormat.CurrentLength (current : Integer; text : String) : Integer;
var i, j, p : Integer;
begin
  p := GetPattern(current, text);
  if p > 0 then
    begin
      GetPatInfo (p, text, result, i, j);
      result := i - result;
    end
  else
    result := 0;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateFormat.CurrentStart (current : Integer; text : String) : Integer;
var i, j : Integer;
begin
  GetPatInfo (GetPattern(current, text),text,  result, i, j);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateFormat.CurrentType (current : Integer; text : String) : Integer;
var i, j : Integer;
begin
  GetPatInfo (GetPattern(current, text),text, j, i, result);
end;

{ ---------------------------------------------------------------------------- }
(*//start, ende beziehen sich auf den String, der von GetEditString zurückgegeben wird
procedure TLMDDateFormat.GetPatInfo (pat : Integer; var start, ende, typ : Integer);
var
  i : Integer;
  f : String;
begin
  i := 0;
  f := GetFormatStr;
  start := 1;
  ende := 1;
  typ := 0;
  while (f <> '') and (i < pat) do
    begin
      while (f <> '') and (not (UpCase(f[1]) in ['Y', 'M', 'D'])) do begin inc(start); Delete (f, 1, 1); end;
      inc(i); //pattern found
      ende := 1;
      //determine length of pattern
      while (f <> '') and (UpCase (f[1]) = UpCase (f[2])) do begin inc(ende); Delete (f, 2, 1); end;
      case UpCase(f[1]) of
        'D' : begin
                case ende of
                  1 : typ := 1;
                  2 : begin typ := 2; ende := 1 end;
                  3 : begin typ := 3; ende := GetShortDayExtend-1; end;
                  4 : begin typ := 4; ende := GetLongDayExtend-1; end;
                end;
              end;
        'M' : begin
                case ende of
                  1 : typ := 11;
                  2 : begin typ := 12; ende := 1; end;
                  3 : begin typ := 13; ende := GetShortMonthExtend-1; end;
                  4 : begin typ := 14; ende := GetLongMonthExtend-1; end;
                end;
              end;
        'Y' : begin
                case ende of
                  1 : typ := 21;
                  2 : begin typ := 22; ende := 1; end;
                  3 : begin typ := 23; ende := 3; end;
                  4 : begin typ := 24; ende := 3; end;
                end;
              end;
      end;
      Delete (f, 1, 1);
      if i < pat then //let's go on
        start := start + ende + 1;
    end;
  ende := start + ende + 1;
  if (f = '') and (i < pat) then
    begin
      typ := 0;
      start := 0;
      ende := 0;
    end;
end;*)

{ ---------------------------------------------------------------------------- }
function TLMDDateFormat.GetPattern (current : Integer; text : String) : Integer;
var
  pat, s, e, t : Integer;
begin
  result := 0;
  if current > Length(text)+1 then exit; //+1 JH 03, otherwiese year entry will
                                         //no longer work (last pattern
                                         //incremental edit)
  //we are in the edit string ...
  t := 1000;
  s := 0;
  e := 0;
  pat := 0;
  while (t <> 0) and not ((current >= s) and (current <= e)) do
    begin
      inc(pat);
      GetPatInfo (pat,text, s, e, t);
      if pat > 24 then
        begin
          t:=0;
          break;
        end;
      if (current < s) then //to far
        t := 0;
    end;
  result := pat;
  if t = 0 then  //out of range
    result := -1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateFormat.CurrentYear: Word;
var
  SystemTime: TSystemTime;
begin
  GetLocalTime(SystemTime);
  Result := SystemTime.wYear;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateFormat.GetYearDelta: Word;
begin
  if YearDelta = -1 then
    result := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TwoDigitYearCenturyWindow           // 6.0 RM
  else
    result := FYearDelta;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateFormat.LastMonthDay(y, m: word): word;
begin
  if (m >= 1) and (m <= 12) then
  begin
    result := MonthDays[m];
    if (y mod 4 = 0) then
      inc(result);
  end
  else
    result := 0;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateFormat.DateLength(text: String): integer;
var
  ps, pe, pt, oldpt, i: Integer;
begin
  i := 1;
  result := 0;
  ps := 0;
  pe := 0;
  pt := 0;
  repeat
    if pe > result then
      result := pe;
    oldpt := pt;
    GetPatInfo(i, text, ps, pe, pt);
    inc(i);
  until pt = oldpt;
end;

{ ---------------------------------------------------------------------------- }
//returns pattern params for a given string
//e.g. for input text = dd/mm/yyyy, pattern = 1
//output will be pat_start = 1, pat_end = 3 (including separator), pat_type = 2 (1 for D, 2 for DD)
//     for input text = dd/mm/yyyy, pattern = 2
//output will be pat_start = 4, pat_end = 3 (including separator), pat_type = 12 (11 for M, 12 for MM)
procedure TLMDDateFormat.GetPatInfo (pattern : Integer; text : String; var pat_start, pat_end, pat_type : Integer);
var
  f : String;
  pat,
  i : Integer;

  procedure specialDelete (var str : String; start, length : Integer);
  begin
    Delete (str, start, length);
    inc (pat_end, length);
  end;

  procedure CheckName(names:array of string);
  begin
    i := low(Names);
    while (Pos (Names[i], text) <> 1) and (i <= high(Names)) do //vb
      inc(i);
    if i <= high(Names) then
      specialDelete (text, 1, Length(Names[i]));
  end;

  procedure ScanDigits;
  begin
    while (text <> '') and (AnsiChar(text[1]) in ['0'..'9']) do
      SpecialDelete (text, 1, 1);
  end;

  procedure ScanNonDigits;
  begin
    while (text <> '') and not (AnsiChar(text[1]) in ['0'..'9']) do
      SpecialDelete (text, 1, 1);
  end;

begin
  f := GetFormatStr;
//  i := 1;
//  j := 1;
  pat_start := 0;
  pat_end := 1;
  pat_type := 0;
  pat := 0;
  while (pattern > pat) and (f <> '') do
  begin
    //remove spaces dynamically inserted for editing
    while (text <> '') and (text[1] = ' ') and (f <> '') and (f[1] <> ' ') do
      specialDelete (text, 1, 1);
    pat_start := pat_end;
    case UpCase(f[1]) of
      'D': begin
             inc(pat);
             //count 'D'
             while (f <> '') and (UpCase(f[1]) = 'D') do
               begin
                 inc(pat_type);
                 Delete (f, 1, 1);
               end;
             //remove part of real string representing D, DD, DDD or DDDD
             case pat_type of
               1..2 :  begin
                         ScanNonDigits;
                         ScanDigits;
                       end;
               3 : CheckName({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortDayNames);
               4 : CheckName({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongDayNames);
             end;
           end;
      'M': begin
             inc(pat);
             while (f <> '') and (UpCase(f[1]) = 'M') do
               begin
                 inc(pat_type);
                 Delete (f, 1, 1);
               end;
             case pat_type of
               1..2 : begin
                        ScanNonDigits;
                        ScanDigits;
                      end;
               3 : CheckName({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortMonthNames);
               4 : CheckName({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongMonthNames);
             end;
             inc(pat_type, 10);
           end;
      'Y': begin
             inc(pat);
             ScanNonDigits;
             while (f <> '') and (UpCase(f[1]) = 'Y') do
               begin
                 inc(pat_type);
                 Delete (f, 1, 1);
               end;
             ScanDigits;
             inc(pat_type, 20);
           end;
      else
      begin
        Delete (f, 1, 1);
        specialDelete (text, 1, 1);
        pat_type := 0;
      end;
    end; // end of case f[1]
  end; //end of while cursorPos > pat_Start
end;

end.
