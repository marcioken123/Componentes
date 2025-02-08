unit LMDShMisc;
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

LMDShMisc unit (DS)
-------------------
Contains RootPath property editor.


Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  ShlObj,
  LMDShBase;

type
  TLMDShellSortDirection = (sdAscending, sdDescending, sdAsIs);

function LMDIsElement(Element, Flag: LongWord): Boolean;
function LMDConstToStr(value : integer) : string;
function LMDSafeStrToInt(const Value : string) : LongInt;
function LMDFileSizeToStr(aSize : LongInt) : string;
function LMDFileDateToStr(aDate : TDateTime) : string;
function LMDFileTimeToStr(aTime : TDateTime) : string;
function LMDFileDateTimeToStr(aDateTime : TDateTime) : string;
function LMDStrRetToStr(aPIDL: PItemIDList; var StrRet: TStrRetEx; const Flag : string=''): string;
function LMDStrRetToString(aPIDL: PItemIDList; const StrRet: TStrRetEx; const Flag : string=''): string;

function LMDStrRetToStringEx(aPIDL: PItemIDList; var StrRet: TStrRetEx; const Flag:string=''): Ansistring;
 procedure StrRetFree(var StrRet: TStrRetEx);
procedure LMDSetClipboardText(const aText:String);

implementation

uses
  ActiveX, Windows, SysUtils, TypInfo, ClipBrd, ShellAPI, LMDStrings,
  LMDShConsts;

var
  Malloc : IMalloc;

{------------------------------------------------------------------------------}
procedure LMDSetClipboardText(const aText:String);
begin
  Clipboard.Open;
  try
    Clipboard.Clear;
    Clipboard.AsText := aText;
//    Clipboard.SetTextBuf(PChar(aText));
  finally
    Clipboard.Close;
  end;
end;

{------------------------------------------------------------------------------}
function LMDIsElement(Element, Flag: LongWord): Boolean;
begin
  Result := Element and Flag <> 0;
end;

{------------------------------------------------------------------------------}
function LMDSafeStrToInt(const Value : string) : LongInt;
var
  Code : integer;
begin
  Val(Value, Result, Code);
  if Code <> 0 then Result := 0;
end;

{------------------------------------------------------------------------------}
function LMDFileSizeToStr(aSize : LongInt) : string;
begin
  Result := '';
  if aSize=0 then
    exit
  else
    Result := FormatFloat('#,##0.00 KB', aSize/1024);
end;

{------------------------------------------------------------------------------}
function LMDFileDateToStr(aDate : TDateTime) : string;
begin
  Result := '';
  if aDate < EncodeDate(1980, 1, 1) then Exit;
  Result := DateToStr(aDate);
end;

{------------------------------------------------------------------------------}
function LMDFileTimeToStr(aTime : TDateTime) : string;
begin
  Result := '';
  if aTime = 0 then Exit;
  Result := TimeToStr(aTime);
end;

{------------------------------------------------------------------------------}
function LMDFileDateTimeToStr(aDateTime : TDateTime) : string;
begin
  Result := '';
  if aDateTime < EncodeDate(1980, 1, 1) then Exit;
  Result := DateTimeToStr(aDateTime);
end;
{ ---------------------------------------------------------------------------- }

type
  TStrRetToBuf = function(
    const pstr: STRRET; // Pointer to the STRRET structure. When the function
                        // returns, this pointer will no
                        // longer be valid.
    pidl: PItemIDList;  // Pointer to the item's ITEMIDLIST structure.
    pszBuf: PAnsiChar; // Buffer to hold the display name. It will be returned
                        // as a null-terminated
                        // string. If cchBuf is too small, the name will be
                        // truncated to fit.
    cchBuf: DWORD)      // Size of pszBuf, in characters. If cchBuf is too small,
                        // the string will be
                        // truncated to fit.
    : HResult; stdcall; //external 'shlwapi.dll' name 'StrRetToBufA';

var
  StrRetToBuf: TStrRetToBuf = nil;
  hshlwapi_dll: THandle = 0;

function LMDStrRetToStr(aPIDL: PItemIDList; var StrRet: TStrRetEx; const Flag : string=''): string;
begin
  {$IFDEF LMDCOMP12}
  result := LMDStrRetToString(aPidl, StrRet, flag);
  {$ELSE}
  result := string(LMDStrRetToStringEx(aPidl, StrRet, flag));
  {$ENDIF}
end;

function LMDStrRetToString(aPIDL: PItemIDList; const StrRet: TStrRetEx; const Flag:string=''): string;
var
  P: PChar;
begin
  Result := '';
  case StrRet.uType of
    STRRET_CSTR:
      Result := String(StrRet.cStr);
//      SetString(Result, StrRet.cStr, lStrLen(StrRet.cStr));
    STRRET_OFFSET:
      if  Assigned(aPIDL)  then
        begin
          P := @aPIDL.mkid.abID[StrRet.uOffset - SizeOf(aPIDL.mkid.cb)];
          SetString(Result, P, aPIDL.mkid.cb - StrRet.uOffset - 1);
        end;
    STRRET_WSTR:
      if Assigned(StrRet.pOleStr) then
        Result := StrRet.pOleStr;
  end;

  if (Length(Result) > 1) and (Result[1] = '?') and LMDAnsiCharInSet(Result[2], ['0'..'9']) then
    Result := StringReplace(Result,'?','',[rfReplaceAll]);
end;

{ ---------------------------------------------------------------------------- }

function LMDStrRetToStringEx(aPIDL: PItemIDList; var StrRet: TStrRetEx; const Flag: string): Ansistring;
  var
    i: integer;
    Ok: Boolean;
begin
  if  Assigned(StrRetToBuf) then
    begin
      SetLength(Result, 1024);
      FillChar(PAnsiChar(Result)^, 1024, 0);
      Ok := Succeeded(StrRetToBuf(StrRet, aPIDL, PAnsiChar(Result), 1024))
    end
  else
    begin
      Ok := True;
      Result := AnsiString(LMDStrRetToString(aPIDL, StrRet, Flag));
      StrRetFree(StrRet);
    end;

  if  Ok  then
    begin
      for i := 1 to Length(Result) do
        if  Result[i] = #0 then
          begin
            SetLength(Result, i - 1);
            break;
          end;
    end
  else
    Result := '';

  StrRet.pOLEStr := nil;
end;

{------------------------------------------------------------------------------}
procedure StrRetFree(var StrRet: TStrRetEx);
begin
  if (StrRet.uType = STRRET_WSTR) and (StrRet.pOLEStr <> nil) then
    begin
      CoTaskMemFree(StrRet.pOleStr);
      StrRet.pOLEStr := nil;
    end;
end;

type
  TLMDStrRec = record
    ID  : Integer;
    Str : string;
  end;

const
  cLMDShStrArray : array [0..cMaxCode] of TLMDStrRec = (
   (ID: cErrShVersion; Str: IDSHELL_ErrShVersion),
   (ID: cErrInvalidFolder; Str: IDSHELL_ErrInvalidFolder)
   );

{------------------------------------------------------------------------------}
function LMDConstToStr(value : integer) : string;
var
  i : Integer;
begin
  Result := '';
  for i := 0 to cMaxCode do
    if cLMDShStrArray[i].ID = value then
      Result := cLMDShStrArray[i].Str;
end;

initialization
  SHGetMalloc(Malloc);

  hshlwapi_dll := LoadLibrary('shlwapi.dll');

  if  hshlwapi_dll <> 0 then
    StrRetToBuf := GetProcAddress(hshlwapi_dll, 'StrRetToBufA');

finalization
  Malloc := nil;

  if  hshlwapi_dll <> 0 then
    FreeLibrary(hshlwapi_dll);

end.

