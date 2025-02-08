unit LMDDateTime;
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

LMDDateTime unit ()
-------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, LMDObject;

type
  { ------------------------------- class TLMDDateTime ----------------------- }
  TLMDDateTime = class(TLMDObject)
  private
    FDateTime : TDateTime;
    procedure SetDay (aValue : Byte);
    procedure SetMonth (aValue : Byte);
    procedure SetYear (aValue : LongInt);
    procedure SetMinute (aValue : Byte);
    procedure SetHour (aValue : Byte);
    procedure SetSecond (aValue : Byte);
    procedure SetDateTime (aValue : TDateTime);

    function GetDay : Byte;
    function GetMonth : Byte;
    function GetYear : LongInt;
    function GetHour : Byte;
    function GetMinute : Byte;
    function GetSecond : Byte;
    function GetISO8601: String;
    function GetRFC822: String;
    procedure SetISO8601(const Value: String);
    procedure SetRFC822(const Value: String);
  public
    constructor Create(AOwner:TPersistent=nil); override;
    procedure Assign (Source : TPersistent);override;
    property DateTimeValue : TDateTime read FDateTime write SetDateTime;
    property DateISO8601: String read GetISO8601 write SetISO8601;
    property DateRFC822: String read GetRFC822 write SetRFC822;
  published
    property Day: Byte read GetDay write SetDay default 1;
    property Month: Byte read GetMonth write SetMonth default 1;
    property Year: LongInt read GetYear write SetYear default 1990;
    property Hour: Byte read GetHour write SetHour default 0;
    property Minute: Byte read GetMinute write SetMinute default 0;
    property Second: Byte read GetSecond write SetSecond default 0;
  end;

implementation

uses
  Windows, SysUtils, DateUtils;

{ ---------------------------------------------------------------------------- }
function FetchTo(aStop: Char; const s: string; var APos: Integer): Integer;
var
  i: Integer;
begin
  i := aPos;
  while (i <= Length(s)) and ((s[i] >= '0') and (s[i] <= '9')) do
    Inc(i);
  if i > aPos then
    Result := StrToInt(Copy(s, aPos, i - aPos))
  else
    Result := 0;
  if (i <= Length(s)) and (s[i] = aStop) then
    aPos := i + 1
  else
    aPos := Length(s) + 1;
end;

{ *************************** class TLMDDateTime ***************************** }
{ ----------------------------------- private -------------------------------- }
procedure TLMDDateTime.SetDay (aValue : Byte);
var
  y,m,d : Word;
begin
  DecodeDate (FDateTime, y, m, d);
  if aValue <> d then
    begin
      FDateTime := Int(EncodeDate (y, m, aValue))+Frac(EncodeTime (Hour, Minute, Second,0));
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDateTime.SetMonth (aValue : Byte);
var
  y,m,d : Word;
begin
  DecodeDate (FDateTime, y, m, d);
  if aValue <> m then
    begin
      FDateTime := Int(EncodeDate (y, aValue, d))+Frac(EncodeTime (Hour, Minute, Second,0));
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDateTime.SetRFC822(const Value: String);
var
  LStr: string;
  LPos, i, d, m, y, h, n, ss: Integer;

  procedure SkipSpaces;
  begin
    while LPos <= Length(Value) do
      if Value[LPos] = #32 then
        Inc(LPos)
      else
        break;
  end;

const
  CMonth: array [1..12] of String = ('jan', 'feb', 'mar', 'apr',
                 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec');
begin
  LPos := 1 + Pos(',', Value);
  SkipSpaces;
  d := FetchTo(' ', Value, LPos);
  SkipSpaces;
  i := LPos;
  while LPos <= Length(Value) do
    if Value[LPos] <> #32 then
      Inc(LPos)
    else
      break;
  LStr := AnsiLowerCase(Copy(Value, i, LPos - i));
  m := 1;
  for i := 1 to 12 do
    if CMonth[i] = LStr then
    begin
      m := i;
      break
    end;
  SkipSpaces;
  y := FetchTo(#32, Value, LPos);
  h := FetchTo(':', Value, LPos);
  n := FetchTo(':', Value, LPos);
  ss := FetchTo(#32, Value, LPos);

  FDateTime := EncodeDateTime(y, m, d, h, n, ss, 0)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDateTime.SetYear (aValue : LongInt);
var
  y,m,d : Word;
begin
  DecodeDate (FDateTime, y, m, d);
  if aValue <> y then
    begin
      FDateTime := Int(EncodeDate (aValue, m, d))+Frac(EncodeTime (Hour, Minute, Second,0));
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDateTime.SetMinute (aValue : Byte);
var
  h, m, s, ms : Word;
begin
  DecodeTime (FDateTime, h, m, s, ms);
  if aValue <> m then
    begin
      FDateTime := Int(FDateTime)+Frac(EncodeTime (h, aValue, s, ms));
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDateTime.SetHour (aValue : Byte);
var
  h, m, s, ms : Word;
begin
  DecodeTime (FDateTime, h, m, s, ms);
  if aValue <> h then
    begin
      FDateTime := Int(FDateTime)+Frac(EncodeTime (aValue, m, s, ms));
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDateTime.SetISO8601(const Value: String);
var
  LPos: Integer;
  y, m, d, h, n, ss: Integer;
begin
  LPos := 1;
  y := FetchTo('-', Value, LPos);
  m := FetchTo('-', Value, LPos);
  d := FetchTo('T', Value, LPos);
  h := FetchTo(':', Value, LPos);
  n := FetchTo(':', Value, LPos);
  ss := FetchTo(':', Value, LPos);
  FDateTime := EncodeDateTime(y, m, d, h, n, ss, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDateTime.SetSecond (aValue : Byte);
var
  h, m, s, ms : Word;
begin
  DecodeTime (FDateTime, h, m, s, ms);
  if aValue <> s then
    begin
      FDateTime := Int(FDateTime)+Frac(EncodeTime (h, m, aValue, ms));
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDateTime.SetDateTime (aValue : TDateTime);
begin
  if aValue <> FDateTime then
    begin
      FDateTime := aValue;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateTime.GetDay : Byte;
var
  y, m, d : Word;
begin
  DecodeDate (FDateTime, y, m, d);
  result := d;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateTime.GetMonth : Byte;
var
  y, m, d : Word;
begin
  DecodeDate (FDateTime, y, m, d);
  result := m;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateTime.GetRFC822: String;
//var
//  y, m, d, h, mn, s, ms : Word;
begin
  // TODO
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateTime.GetYear : LongInt;
var
  y, m, d : Word;
begin
  DecodeDate (FDateTime, y, m, d);
  result := y;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateTime.GetHour : Byte;
var
  h, m, s, ms : Word;
begin
  DecodeTime (FDateTime, h, m, s, ms);
  result := h;
end;

function TLMDDateTime.GetISO8601: String;
var
  y, m, d, h, mn, s, ms : Word;
  LTimeZone: TTimeZoneInformation;
  LDiv: Real;
  LDivHours: Integer;
  LDivMinutes: Integer;
  LZone: string;
begin
  DecodeDateTime(FDateTime, y, m, d, h, mn, s, ms);
  GetTimeZoneInformation(LTimeZone);
  LDiv := LTimeZone.Bias / -60;
  LDivHours := Round(Int(LDiv));
  LDivMinutes := Round(Frac(LDiv) * 6);
  LZone := Format('%.2d:%.2d', [LDivHours, LDivMinutes]);
  if LDivHours < 0 then
    LZone := '-' + LZone
  else
    LZone := '+' + LZone;
  Result := Format('%.4d-%.2d-%.2dT%.2d:%.2d:%.2d%s', [y, m, d, h, mn, s, LZone]);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateTime.GetMinute : Byte;
var
  h, m, s, ms : Word;
begin
  DecodeTime (FDateTime, h, m, s, ms);
  result := m;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateTime.GetSecond : Byte;
var
  h, m, s, ms : Word;
begin
  DecodeTime (FDateTime, h, m, s, ms);
  result := s;
end;

{ ------------------------------------ public -------------------------------- }
procedure TLMDDateTime.Assign (Source : TPersistent);
begin
  if Source is TLMDDateTime then
    begin
      FDateTime := TLMDDateTime (Source).DateTimeValue;
    end
  else
    inherited Assign (Source);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDDateTime.Create(AOwner: TPersistent = nil);
begin
  inherited Create(AOwner);
  FDateTime := EncodeDate (1990, 1, 1);
end;

end.
