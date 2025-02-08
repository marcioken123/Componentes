unit LMDTimeFormat;
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

LMDTimeFormat unit () [VB]
--------------------------

For custom formats time separator must be ":"

Custom formats can use
h for hours in 12 hour format,
H for for hours 24 hour format,
m or M for minutes,
s or S for seconds,
t for AM/PM sign if "t" is omitted, then AM/PM sign is added at the end with a
  space.

hh(mm, ss) means that leading zero is displayed,
h (m, s) means that leading zero is NOT displayed.

Examples:

h:mm:ss  - 3:34:12 am
hh:mm    - 03:34 am
hh:mmt   - 03:34am
t h:mm   - am 3:34
HH:mm:ss - 03:34:12

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

const
  cAMPMPlaceHolder: string = #7;

type
  TLMDTimeFormats = (tfShortSystem, tfLongSystem, tfCustom);

  TLMDTimeFormat = class (TLMDObject)
  private
    FFormatStr : String;
    FFormat    : TLMDTimeFormats;
    FOnFormatChanged : TNotifyEvent;
    FOnFormatChange : TNotifyEvent;
    FAMSign: TLMDString;
    FPMSign: TLMDString;
    FMSign: TLMDString;
    F12hour: boolean;
    FOffset: integer;

    procedure SetFormatStr (aValue : String);
    procedure SetFormat (aValue : TLMDTimeFormats);

  public
    function RemoveAMPM(var aTimeStr:string):string;//!!!! make private

    constructor Create(Owner:TPersistent=nil); override;
    procedure Assign (Source : TPersistent); override;
    procedure DoFormatChanged;
    procedure DoFormatChange;
    function GetFormatStr : String;
    function TimeToStr (time : TDateTime) : String;
    procedure StrToHMS (str  : String; var h, m, s : byte);
    procedure StrToHMS24 (str  : String; var h, m, s : byte);
    function StrToTime (str  : String) : TDateTime;
    function GetEditString (h, m, s : byte) : String; overload;
    function GetEditString (dt : TDateTime) : String; overload;

    function NextEditPos (current : Integer; text : String) : Integer;
    function PrevEditPos (current : Integer; text : String) : Integer;
    function CurrentLength (current : Integer; text : String) : Integer;
    function CurrentStart (current : Integer; text : String) : Integer;
    function CurrentType (current : Integer; text : String) : Integer;

    function GetPattern (current : Integer; text : String) : Integer;
    procedure GetPatInfo (pattern : Integer; text : String; var pat_start, pat_end, pat_type : Integer);

    property OnFormatChanged : TNotifyEvent read FOnFormatChanged write FOnFormatChanged;
    property OnFormatChange : TNotifyEvent read FOnFormatChange write FOnFormatChange;
    property Is12HourFormat: boolean read F12hour;
    property Offset: integer read FOffset write FOffset;
  published
    property FormatStr : String read FFormatStr write SetFormatStr;
    property Format    : TLMDTimeFormats read FFormat write SetFormat default tfShortSystem;
    property AMSign    : TLMDString read FAMSign write FAMSign;
    property PMSign    : TLMDString read FPMSign write FPMSign;
    property MSign     : TLMDString read FMSign write FMSign; //meridiem (noon, midday)
  end;

implementation

uses
  Windows,
  SysUtils;

{ ---------------------------------------------------------------------------- }
procedure TLMDTimeFormat.SetFormatStr (aValue : String);
begin
  if aValue <> FFormatStr then
    begin
      DoFormatChange;
      FFormatStr := aValue;
      if FFormat = tfCustom then
        DoFormatChanged;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTimeFormat.SetFormat (aValue : TLMDTimeFormats);
begin
  if aValue <> FFormat then
    begin
      FFormat := aValue;
      DoFormatChanged;
    end;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDTimeFormat.Create;
begin
  inherited Create;
  FFormat := tfShortSystem;
  FAMSign := 'am';
  FPMSign := 'pm';
   FMSign := 'm';
  F12hour := Pos('h', GetFormatStr) > 0;
  FOffset := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTimeFormat.Assign (Source : TPersistent);
begin
  if source is TLMDTimeFormat then
    with  TLMDTimeFormat(Source) do
      begin
        self.FFormat := Format;
        self.FFormatStr := FormatStr;
        exit;
      end;
  inherited Assign (Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTimeFormat.DoFormatChanged;
begin
  F12hour := Pos('h', FFormatStr) > 0;
  if Assigned (FOnFormatChanged) then FOnFormatChanged (self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTimeFormat.DoFormatChange;
begin
  if Assigned (FOnFormatChange) then FOnFormatChange (self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDTimeFormat.GetFormatStr : String;

   function ReplaceColon : String;
   begin
     Result := StringReplace(FFormatStr, ':', {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimeSeparator, [rfReplaceAll]);
   end;

begin
  result := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortTimeFormat;
  case FFormat of
    tfCustom : result := ReplaceColon;
    tfLongSystem : result := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongTimeFormat;
  end;
  result := StringReplace(result, 'AMPM', 't', [rfReplaceAll, rfIgnoreCase]);
end;

{ ---------------------------------------------------------------------------- }
function TLMDTimeFormat.TimeToStr (time : TDateTime) : String;
var
  h, h12, m, s, ms, i: Word;
  valstr,
  fmt_str : String;
begin
  fmt_str := GetFormatStr;

  DecodeTime (time, h, m, s, ms);

  //h12 := h;

  result := '';
  //step through the whole format string
  while fmt_str <> '' do
    begin
      //copy any chars before the first value to be added
      while (fmt_str <> '') and not (AnsiChar(fmt_str[1]) in ['h','H', 'm','M', 's', 'S', 't', 'T'])  do
        begin
          result := result + fmt_str[1];
          Delete (fmt_str, 1, 1);
        end;
      if fmt_str = '' then
        exit; //ready

      valstr := fmt_str[1];
      Delete (fmt_str, 1, 1);
      while (fmt_str <> '') and (fmt_str[1] = valstr[1]) do
        begin
          valstr := valstr + fmt_str[1];
          Delete (fmt_str, 1, 1);
        end;
      case valstr[1] of
        'H' : begin
                case Length(valstr) of
                  1 : result := result + IntToStr (h);
                  2 : if Length (IntToStr (h)) = 1 then
                        result := result + '0' + IntToStr (h)
                      else
                        result := result + IntToStr (h);
                end;
              end;
        'h' : begin
                h12 := h mod 12;
                if h12 = 0 then
                  h12 := 12;
                case Length(valstr) of
                  1 : result := result + IntToStr (h12);
                  2 : if Length (IntToStr (h12)) = 1 then
                        result := result + '0' + IntToStr (h12)
                      else
                        result := result + IntToStr (h12);
                end;
              end;
      'M','m':begin
                case Length(valstr) of
                  1 : result := result + IntToStr (m);
                  2 : if Length (IntToStr (m)) = 1 then
                        result := result + '0' + IntToStr (m)
                      else
                        result := result + IntToStr (m);
                end;
              end;
      'S','s':begin
                case Length(valstr) of
                  1 : result := result + IntToStr (s);
                  2 : if Length (IntToStr (s)) = 1 then
                        result := result + '0' + IntToStr (s)
                      else
                        result := result + IntToStr (s);
                end;
              end;
      't','T':begin
                if F12Hour then
                  result := result + cAMPMPlaceHolder;
              end;
      end; //end of case valstr[1]
    end; //end of while

   if F12Hour then
   begin
     i := Pos(cAMPMPlaceHolder, result);
//     if (h = 12) and (m = 0) and (s = 0) then
//     begin
//       if i > 0  then
//       begin
//         Delete(result, i, 1);
//         Insert(FMSign, result, i);
//       end
//       else
//         result := result + ' ' + FMSign;
//     end
//     else
//     if h12 = h then

     if h < 12 then
     begin
       if i > 0  then
       begin
         Delete(result, i, 1);
         Insert(FAMSign, result, i);
       end
       else
         result := result + ' ' + FAMSign;
     end
     else
     begin
       if i > 0  then
       begin
         Delete(result, i, 1);
         Insert(FPMSign, result, i);
       end
       else
         result := result + ' ' + FPMSign;
     end
   end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTimeFormat.StrToHMS24 (str: String; var h, m, s : byte);
var
  ls: string;
  pstart, pend, ptype: integer;
begin
  h := 0;
  m := 0;
  s := 0;
  if str <> '' then
  begin
    GetPatInfo(1, str, pstart, pend, ptype);
    if ptype < 10 then
    begin
      ls := Copy(str, pstart, pend - pstart);
      if ls <> '' then
        h := StrToInt(ls); //hours
    end;

    GetPatInfo(2, str, pstart, pend, ptype);
    if (ptype > 10) and (ptype < 20) then
    begin
      ls := Copy(str, pstart, pend - pstart);
      if ls <> '' then
        m := StrToInt(ls); //minutes
    end;

    GetPatInfo(3, str, pstart, pend, ptype);
    if (ptype > 20)  then
    begin
      ls := Copy(str, pstart, pend - pstart);
      if ls <> '' then
        s := StrToInt(ls); //seconds
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTimeFormat.StrToHMS (str: String; var h, m, s : byte);
var
  ampm: string;
begin
  ampm := RemoveAMPM(str);
  StrToHMS24 (str, h, m, s);
  if ampm = PMSign then
    h := h + 12;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTimeFormat.StrToTime (str  : String) : TDateTime;
var
  h, m, s: byte;
  ampm: string;
begin
  ampm := RemoveAMPM(str);
  StrToHMS24(str, h, m, s);

  if ampm <> '' then
  begin
    if h = 12 then
      h := 0;
    if ampm = PMSign then
      Inc(h, 12);
  end;

  Result := EncodeTime(h, m, s, 0);

//  Old implementation (wrong from my viewpoint):
//
//  ampm := RemoveAMPM(str);
//  StrToHMS24 (str, h, m, s);
//  if ampm = PMSign then
//    h := h + 12;
//  try
//    result := EncodeTime (h, m, s, 0);
//  except
//    result := -1;//!!!!!0;
//  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTimeFormat.GetEditString (h, m, s : byte) : String;
var
  dt: TDateTime;
begin
  result := '';
  dt := EncodeTime(h, m, s, 0);
  result := TimeToStr(dt);
end;

{ ---------------------------------------------------------------------------- }
function TLMDTimeFormat.GetEditString (dt : TDateTime) : String;
begin
  result := TimeToStr(dt);
end;

{ ---------------------------------------------------------------------------- }
function TLMDTimeFormat.NextEditPos (current : Integer; text : String) : Integer;
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
function TLMDTimeFormat.PrevEditPos (current : Integer; text : String) : Integer;
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
function TLMDTimeFormat.RemoveAMPM(var aTimeStr: string): string;
var
  i: integer;
begin
  i := Pos(AMSign, LowerCase(aTimeStr));
  if i > 0 then
  begin
    Delete(aTimeStr, i, Length(AMSign));
    result := AMSign;
    Exit;
  end;

  i := Pos(PMSign, LowerCase(aTimeStr));
  if i > 0 then
  begin
    Delete(aTimeStr, i, Length(PMSign));
    Result := PMSign;
    Exit;
  end;

  Result := '';
end;

{ ---------------------------------------------------------------------------- }
function TLMDTimeFormat.CurrentLength (current : Integer; text : String) : Integer;
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
function TLMDTimeFormat.CurrentStart (current : Integer; text : String) : Integer;
var i, j : Integer;
begin
  GetPatInfo (GetPattern(current, text),text,  result, i, j);
end;

{ ---------------------------------------------------------------------------- }
function TLMDTimeFormat.CurrentType (current : Integer; text : String) : Integer;
var i, j : Integer;
begin
  GetPatInfo (GetPattern(current, text),text, j, i, result);
end;

{ ---------------------------------------------------------------------------- }
function TLMDTimeFormat.GetPattern (current : Integer; text : String) : Integer;
var
  pat, s, e, t : Integer;
begin
  result := 0;
  if (current < offset) or (current > Length(text) + 1) then
    exit;
  t := 1000;
  s := 0;
  e := 0;
  pat := 0;
  while (t <> 0) and not ((current >= s) and (current <= e)) do
    begin
      inc(pat);
      GetPatInfo (pat,text, s, e, t);
      if pat > 31 then
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
procedure TLMDTimeFormat.GetPatInfo (pattern : Integer; text : String; var pat_start, pat_end, pat_type : Integer);
var
  f : String;
  pat: Integer;

  procedure SpecialDelete (var str : String; start, length : Integer);
  begin
    Delete (str, start, length);
    inc (pat_end, length);
  end;

  procedure ScanDigits;
  begin
    while (text <> '') and (AnsiChar(text[1]) in ['0'..'9']) do
      SpecialDelete (text, 1, 1);
  end;

  procedure ScanAMPM;
  begin
    if Copy(text, 1, length(AMSign)) = AMSign then
      SpecialDelete (text, 1, length(AMSign))
    else
    if Copy(text, 1, length(PMSign)) = PMSign then
      SpecialDelete (text, 1, length(PMSign))
    else
    if Copy(text, 1, length(MSign)) = MSign then
      SpecialDelete (text, 1, length(MSign));
  end;

begin
  f := GetFormatStr;
  pat_start := 0;
  pat_end := 1;
  pat_type := 0;
  pat := 0;
  if Offset > 0 then
    Delete(Text, 1, Offset);

  while (pattern > pat) and (f <> '') do
  begin
    while (text <> '') and (text[1] = ' ') and (f <> '') and (f[1] <> ' ') do
      SpecialDelete (text, 1, 1);
    pat_start := pat_end;
    case UpCase(f[1]) of
      'H': begin
             inc(pat);
             while (f <> '') and (UpCase(f[1]) = 'H') do
             begin
               inc(pat_type);
               Delete (f, 1, 1);
             end;
             ScanDigits;
           end;
      'M': begin
             inc(pat);
             while (f <> '') and (UpCase(f[1]) = 'M') do
             begin
               inc(pat_type);
               Delete (f, 1, 1);
             end;
             ScanDigits;
             inc(pat_type, 10);
           end;
      'S': begin
             inc(pat);
             while (f <> '') and (UpCase(f[1]) = 'S') do
             begin
               inc(pat_type);
               Delete (f, 1, 1);
             end;
             ScanDigits;
             inc(pat_type, 20);
           end;
      'T': begin
             inc(pat);
             Delete (f, 1, 1);
             ScanAMPM;
             pat_type := 31;
           end;
      else
      begin
        Delete (f, 1, 1);
        SpecialDelete (text, 1, 1);
        pat_type := 0;
      end;
    end; // end of case f[1]
  end; //end of while cursorPos > pat_Start
  pat_start := pat_start + Offset;
  pat_end := pat_end + Offset;
end;

end.
