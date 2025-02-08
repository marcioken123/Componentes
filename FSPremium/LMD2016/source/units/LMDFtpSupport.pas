unit LMDFtpSupport;
{$I LMDCmps.inc}

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

LMDFtpSupport unit (DD)
----------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  SysUtils;

type
  TLMDFTPFileInfo = packed record
    szFileName: string;
    iSize: longint;
    MTime: TDateTime;
  end;

function LMDWebParseFtpListLine(Buf: string): TLMDFTPFileInfo;

implementation

{-----------------------------------------------------------------------------}

function ConvertDateTime(year, month, mday, hour, minute: integer): TDateTime;
var
  DTyear, DTmonth, DTmday, DThour, DTminute, m, d: word;
begin
  Result:= 0;
  if year < 0 then
    Exit;
  if month < 0 then
    Exit;
  if mday < 0 then
    Exit;
  if hour < 0 then
    Exit;
  if minute < 0 then
    Exit;
  DTyear:= year;
  DTmonth:= month;
  DTmday:= mday;
  DThour:= hour;
  DTminute:= minute;
  if DTyear = 0 then
    DecodeDate(Now, DTyear, m, d);
  try
    Result:= EncodeDate(DTyear, DTmonth, DTmday) +
      EncodeTime(DThour, DTminute, 0, 0);
  except
    Result:= 0;
  end;
end;

{-----------------------------------------------------------------------------}

function Incr(var i: integer): integer;
begin
  Inc(i);
  Result:= i;
end;

{-----------------------------------------------------------------------------}

function GetString(const Buf: string; pos: integer;
  const StopChar: char): string;
var
  str: string;
begin
  Result:= '';
  if Length(Buf) < pos then
    Exit;
  while Buf[pos] <> StopChar do
    begin
      str:= str + Buf[pos];
      Inc(pos);
    end;
  Result:= str;
end;

{-----------------------------------------------------------------------------}

function GetLString(Buf: string; pos, len: integer): string;
var
  str: string;
begin
  Result:= '';
  while len > 0 do
    begin
      str:= str + Buf[pos];
      Inc(pos);
      Dec(len);
    end;
  Result:= str;
end;

{-----------------------------------------------------------------------------}

function GetLong(const Buf: string; pos: integer;
  const StopChar: char): longint;
var
  u, i, Code: longint;
begin
  Result:= -1;
  if Length(Buf) < pos then
    Exit;
  u:= 0;
  while Buf[pos] <> StopChar do
    begin
      Val(Buf[pos], i, Code);
      u:= (u * 10) + i;
      if Code <> 0 then
        begin
          Result:= -1;
          Exit;
        end;
      Inc(pos);
    end;
  Result:= u;
end;

{-----------------------------------------------------------------------------}

function GetMonth(const month: string): integer;
var
  pmonth: string;
begin
  Result:= -1;
  pmonth:= UpperCase(month);
  if pmonth = 'JAN' then
    Result:= 1;
  if pmonth = 'FEB' then
    Result:= 2;
  if pmonth = 'MAR' then
    Result:= 3;
  if pmonth = 'APR' then
    Result:= 4;
  if pmonth = 'MAY' then
    Result:= 5;
  if pmonth = 'JUN' then
    Result:= 6;
  if pmonth = 'JUL' then
    Result:= 7;
  if pmonth = 'AUG' then
    Result:= 8;
  if pmonth = 'SEP' then
    Result:= 9;
  if pmonth = 'OCT' then
    Result:= 10;
  if pmonth = 'NOV' then
    Result:= 11;
  if pmonth = 'DEC' then
    Result:= 12;
end;

{-----------------------------------------------------------------------------}

function LMDWebParseFtpListLine;
var
  len: word;
  pos, state: integer;
  year, month, mday, hour, minute: integer;
begin
  with Result do
    begin
      szFileName:= '';
      iSize:= 0;
      MTime:= 0;
    end;
  year:= 0;
  month:= 0;
  mday:= 0;
  hour:= 0;
  minute:= 0;
  len:= Length(Buf);
  if Length(Buf) < 2 then
    Exit;
  {EPLF}
  if Buf[1] = '+' then
    begin
      for pos:= 1 to len do
        begin
          if Buf[pos] = #9 then
            begin
              Result.szFileName:= GetString(Buf, pos + 1, #13);
              Exit;
            end;
          if (Buf[pos] = ',') or (Buf[pos] = '+') then
            begin
              case Buf[pos + 1] of
                's':
                  begin
                    Result.iSize:= GetLong(Buf, pos + 2, ',');
                  end;
                'm':
                  begin
                    Result.MTime:= (GetLong(Buf, pos + 2, ',') / 60 / 60 / 24) +
                      25569;
                  end;
              end;
            end;
        end;
      Exit;
    end;
  {UNIX}
  if (Buf[1] = 'b') or
    (Buf[1] = 'c') or
    (Buf[1] = 'd') or
    (Buf[1] = 'l') or
    (Buf[1] = 'p') or
    (Buf[1] = 's') or
    (Buf[1] = '-') then
    begin
      state:= 1;
      for pos:= 1 to len do
        begin
          if ((Buf[pos] <> ' ') and (Buf[pos - 1] = ' ')) then
            begin
              case state of
                1:
                  begin
                    state:= 2;
                    { skips owner id number }
                    { For NetPresenz (if parameter reads 'folder') }
                    if (Buf[pos] = 'f') and (Buf[pos + 6] = ' ') then
                      state:= 3;
                  end;
                2: state:= 3; { Skips user id }
                3:
                  begin
                    { Tries getting the size, but if this column contains
                      a group id instead of a size, that problem is fixed in the
                      next case }
                    Result.iSize:= GetLong(Buf, pos, ' ');
                    state:= 4;
                  end;
                4:
                  begin
                    { Tries getting the month, otherwise tries getting
                      the size }
                    month:= GetMonth(GetLString(Buf, pos, 3));
                    if month >= 0 then
                      state:= 5
                    else
                      Result.iSize:= GetLong(Buf, pos, ' ');
                  end;
                5:
                  begin
                    { Get the day }
                    mday:= GetLong(Buf, pos, ' ');
                    state:= 6;
                  end;
                6:
                  begin
                    if (Buf[pos + 4] = ' ') and (Buf[pos + 1] = ':') then
                      begin
                        { For time cases such as '7:30' }
                        hour:= GetLong(Buf, pos, ':');
                        minute:= GetLong(Buf, pos + 2, ' ');
                      end
                    else
                      if (Buf[pos + 5] = ' ') and (Buf[pos + 2] = ':') then
                        begin
                          { For time cases such as '10:21' or '19:00' }
                          hour:= GetLong(Buf, pos, ':');
                          minute:= GetLong(Buf, pos + 3, ' ');
                        end
                      else
                        if Buf[pos + 4] = ' ' then
                          begin
                            { Get the year, if there is no time }
                            year:= GetLong(Buf, pos, ' ');
                          end
                        else
                          Exit;
                    { Convert the minutes, hours, days, etc. to TDateTime }
                    Result.MTime:= ConvertDateTime(year, month, mday, hour,
                      minute);
                    state:= 7;
                  end; // end case '6'
                7:
                  begin
                    { Get the name }
                    Result.szFileName:= GetLString(Buf, pos, len - pos + 1);
                  end;
              end;
            end;
        end;
      Exit;
    end;
  { Microsoft NT 4.0 FTP Service                             }
  if (Buf[1] = '1') or (Buf[1] = '0') then
    begin
      { Checks to see if buf[2] is a number }
      if (Ord(Buf[2]) < 48) or (Ord(Buf[2]) > 57) then
        Exit;
      if Buf[3] <> '-' then
        Exit;
      pos:= 1;
      month:= GetLong(Buf, pos, '-');
      while Buf[pos] <> '-' do
        if (Incr(pos)) = len then
          Exit;
      inc(pos);
      mday:= GetLong(Buf, pos, '-');
      while Buf[pos] <> '-' do
        if (Incr(pos)) = len then
          Exit;
      inc(pos);
      year:= GetLong(Buf, pos, ' ') + 1900;
      { Y2K fix, but it won't last for Y2100! }
      if year < 1980 then
        year:= year + 100;
      while Buf[pos] <> ' ' do
        if (Incr(pos)) = len then
          Exit;
      while Buf[pos] = ' ' do
        if (Incr(pos)) = len then
          Exit;
      hour:= GetLong(Buf, pos, ':');
      while Buf[pos] <> ':' do
        if (Incr(pos)) = len then
          Exit;
      minute:= GetLong(Buf, pos + 1, Buf[pos + 3]);
      if Buf[pos + 3] = 'P' then
        hour:= hour + 12;
      while Buf[pos] <> ' ' do
        if (Incr(pos)) = len then
          Exit;
      while Buf[pos] = ' ' do
        if (Incr(pos)) = len then
          Exit;
      if Buf[pos] <> '<' then
        begin
          Result.iSize:= GetLong(Buf, pos, ' ');
        end;
      while Buf[pos] <> ' ' do
        if (Incr(pos)) = len then
          Exit;
      while Buf[pos] = ' ' do
        if (Incr(pos)) = len then
          Exit;
      Result.MTime:= ConvertDateTime(year, month, mday, hour, minute);
      Result.szFileName:= GetLString(Buf, pos, len - pos + 1);
      Exit;
    end;
  { MultiNet (some spaces removed from examples) }
  for pos:= 1 to len do
    if Buf[pos] = ';' then
      break;
  { Gets the name }
  if pos < len then
    begin
      if Buf[pos - 4] = '.DIR' then
        begin
          Result.szFileName:= GetString(Buf, 1, '.');
        end
      else
        Result.szFileName:= GetString(Buf, 1, ';');
      { Skip to the date }
      while Buf[pos] <> ' ' do
        if (Incr(pos)) = len then
          Exit;
      while Buf[pos] = ' ' do
        if (Incr(pos)) = len then
          Exit;
      while Buf[pos] <> ' ' do
        if (Incr(pos)) = len then
          Exit;
      while Buf[pos] = ' ' do
        if (Incr(pos)) = len then
          Exit;
      mday:= GetLong(Buf, pos, '-');
      while Buf[pos] <> '-' do
        if (Incr(pos)) = len then
          Exit;
      month:= GetMonth(GetLString(Buf, pos + 1, 3));
      while Buf[pos] <> '-' do
        if (Incr(pos)) = len then
          Exit;
      year:= GetLong(Buf, pos + 1, ' ');
      while Buf[pos] <> ' ' do
        if (Incr(pos)) = len then
          Exit;
      while Buf[pos] = ' ' do
        if (Incr(pos)) = len then
          Exit;
      hour:= GetLong(Buf, pos, ':');
      while Buf[pos] <> ':' do
        if (Incr(pos)) = len then
          Exit;
      minute:= GetLong(Buf, pos + 1, Buf[pos + 2]);
      Result.MTime:= ConvertDateTime(year, month, mday, hour, minute);
      Exit;
    end;
end;
end.
