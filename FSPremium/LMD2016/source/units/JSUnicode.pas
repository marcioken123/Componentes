unit JSUnicode;
interface
(*
Code Contributor: Patrick Kolla
*)

{$I lmddlgcmps.inc}

uses
    Windows
  , SysUtils
  , Graphics
  , JSTypes
  {$IFDEF UNICODE}
    {$IFDEF TNTUnicode}
    , TntSysUtils
    {$ELSE}
    , WideStrUtils
    {$ENDIF TNTUnicode}
  {$ENDIF UNICODE}
  {$IFDEF FORCEUNICODE}
  , WideStrUtils
  {$ENDIF FORCEUNICODE}
  {$IFDEF DELPHIXE2}
  , Themes
  {$ENDIF DELPHIXE2}
  ;

var
  JSSupportsUnicode: Boolean;

procedure JSDrawText(AHwnd: HDC; AStr: TJSString; const Font: TFont; var ARect: TRect; AFlags: Cardinal; NoFixedLength: Boolean = False); overload;
function JSFormat(const Format: TJSString; const Args: array of const): TJSString;
function JSStringReplace(const S, OldPattern, NewPattern: TJSString; Flags: TReplaceFlags): TJSString;
function JSTextHeight(ACanvas: TCanvas; const AStr: TJSString): Integer;
function JSTextWidth(ACanvas: TCanvas; const AStr: TJSString): Integer;
function JSLowerCase(const AStr: TJSString): TJSString;

function JSAnsiStringFromUnicodeWideString(AText: WideString; ACharset: longword): AnsiString; overload;
function JSCompilerStringFromUnicodeWideString(AText: WideString): string;
function JSUnicodeWideStringFromCompilerString(AText: string): WideString;

implementation

{$IFDEF FORCEUNICODE}
uses
  WideStrings;
{$ENDIF FORCEUNICODE}

function UnicodeFromMultiByteAndCharSet(AText: AnsiString; ACharset: UINT): widestring;
var
  CSI: TCharsetInfo;
  pcAnsi: PAnsiChar;
  pcWide: PWideChar;
  iLength: Integer;
begin
{$IFDEF DELPHI2009}
{$WARN EXPLICIT_STRING_CAST OFF}
{$ENDIF DELPHI2009}
  Result := Widestring(AText);
{$IFDEF DELPHI2009}
{$WARN EXPLICIT_STRING_CAST ON}
{$ENDIF DELPHI2009}
  if TranslateCharsetInfo(ACharset, CSI, TCI_SRCCHARSET) then
  begin
    pcWide := nil;
    pcAnsi := PAnsiChar(AText);
    iLength := MultibyteToWideChar(CSI.ciACP, 0, pcAnsi, Length(AText), pcWide, 0);
    GetMem(pcWide, iLength*2);
    try
      MultibyteToWideChar(CSI.ciACP, 0, pcAnsi, Length(pcAnsi), pcWide, iLength);
      Result := widestring(pcWide);
      SetLength(Result, iLength);
    finally
      FreeMem(pcWide, iLength*2);
    end;
  end;
end;

function JSAnsiStringFromUnicodeWideString(AText: WideString; ACharset: longword): AnsiString;
var
  CSI: TCharsetInfo;
  pcAnsi: PAnsiChar;
  pcWide: PWideChar;
  iLength: integer;
begin
  {$WARNINGS OFF}
  Result := WideString(AText);
  if TranslateCharsetInfo(ACharset, CSI, TCI_SRCCHARSET) then
  begin
    pcWide := PWideChar(AText);
    pcAnsi := nil;
    iLength := WideCharToMultiByte(CSI.ciACP, 0, pcWide, Length(pcWide)*2, pcAnsi, 0, nil, nil);
    GetMem(pcAnsi, iLength);
    try
      ZeroMemory(pcAnsi, iLength);
      iLength := WideCharToMultiByte(CSI.ciACP, 0, pcWide, Length(pcWide)*2, pcAnsi, iLength, nil, nil);
      Result := AnsiString(pcAnsi);
    finally
      FreeMem(pcAnsi, iLength);
    end;
  end;
  {$WARNINGS ON}
end;

function JSUnicodeWideStringFromCompilerString(AText: string): WideString;
begin
{$IFDEF BDS}
  // I do NOT use the UNICODE switch here, because it may be used by other
  // packages for a different decision!
  {$IFDEF DELPHI2009} //COMPILERVERSION >= 20.0} // string = WideString
  Result := WideString(AText);
  {$ELSE} // string = AnsiString
  Result := UnicodeFromMultiByteAndCharSet(AText, DefFontData.Charset);
  {$ENDIF}
{$ELSE}
  Result := UnicodeFromMultiByteAndCharSet(AText, DefFontData.Charset);
{$ENDIF BDS}
end;

function JSCompilerStringFromUnicodeWideString(AText: WideString): string;
begin
{$IFDEF BDS}
  // I do NOT use the UNICODE switch here, because it may be used by other
  // packages for a different decision!
  {$IFDEF DELPHI2009} //COMPILERVERSION >= 20.0} // string = WideString
  Result := WideString(AText);
  {$ELSE} // string = AnsiString
  Result := JSAnsiStringFromUnicodeWideString(AText, DefFontData.Charset);
  {$ENDIF}
{$ELSE}
  Result := JSAnsiStringFromUnicodeWideString(AText, DefFontData.Charset);
{$ENDIF BDS}
end;

function JSAnsiStringFromUnicodeWideString(AText: WideString): AnsiString; overload;
begin
  Result := JSAnsiStringFromUnicodeWideString(AText, DefFontData.Charset);
end;

procedure JSDrawText(AHwnd: HDC; AStr: TJSString; const Font: TFont; var ARect: TRect; AFlags: Cardinal; NoFixedLength: Boolean = False);
{$IFDEF DELPHIXE2}
var
  LDetails: TThemedElementDetails;
  LColor: TColor;
  LStyleOptions: TStyleTextOptions;
  LFormat: TTextFormatFlags;
{$ENDIF DELPHIXE2}
{$IFNDEF UNICODE}
var
  {$IFDEF FORCEUNICODE}
  LAnsiStr: AnsiString;
  {$ENDIF FORCEUNICODE}
  LLen: Integer;
  LS: WideString;
{$ENDIF UNICODE}

begin
  {$IFDEF DELPHIXE2}
    if StyleServices.Enabled then
    begin
      LDetails := StyleServices.GetElementDetails(ttlTextLabelNormal);
      if StyleServices.IsSystemStyle then
        LStyleOptions.TextColor := Font.Color
      else
      begin
        StyleServices.GetElementColor(LDetails, ecTextColor, LColor);
        LStyleOptions.TextColor := LColor;
      end;
      LStyleOptions.Flags := [stfTextColor];
      LFormat := TTextFormatFlags(AFlags);
      StyleServices.DrawText(AHwnd, LDetails, AStr, ARect, LFormat, LStyleOptions);
      Exit;
    end;
  {$ENDIF DELPHIXE2}

  {$IFDEF UNICODE}
  DrawTextW(AHwnd, PWideChar(AStr), -1, ARect, AFlags);
  {$ELSE}
  if JSSupportsUnicode then
  begin
    if NoFixedLength then
      LLen := -1
    else
      LLen := Length(AStr);
    LS := AStr;
    DrawTextW(AHwnd, PWideChar(LS), LLen, ARect, AFlags);
  end
  else
  begin
    {$IFDEF FORCEUNICODE}
    // AStr will be a WideString
	  LAnsiStr := JSAnsiStringFromUnicodeWideString(AStr, Font.Charset);
    if NoFixedLength then
      LLen := -1
    else
      LLen := Length(LAnsiStr);
    DrawTextA(AHwnd, PAnsiChar(LAnsiStr), LLen, ARect, AFlags);
    {$ELSE}
    DrawText(AHwnd, PChar(AStr), -1, ARect, AFlags);
    {$ENDIF FORCEUNICODE}
  end;
  {$ENDIF UNICODE}
end;

function JSFormat(const Format: TJSString; const Args: array of const): TJSString;
begin
{$IFDEF BDS}
  {$IFDEF UNICODE}
  Result := WideFormat(Format, Args);
  {$ELSE}
  if JSSupportsUnicode then
  begin
    Result := WideFormat(Format, Args);
  end
  else
    Result := SysUtils.Format(Format, Args);
  {$ENDIF UNICODE}
{$ELSE}
  Result := SysUtils.Format(Format, Args);
{$ENDIF BDS}
end;

function JSStringReplace(const S, OldPattern, NewPattern: TJSString; Flags: TReplaceFlags): TJSString;
begin
  {$IFDEF UNICODE}
    {$IFDEF TNTUnicode}
    Result := Tnt_WideStringReplace(S, OldPattern, NewPattern, Flags, WholeWord);
    {$ELSE}
    Result := WideStringReplace(S, OldPattern, NewPattern, Flags);
    {$ENDIF TNTUnicode}
  {$ELSE}
  {$IFDEF FORCEUNICODE}
  if JSSupportsUnicode then
  begin
    Result := WideStringReplace(S, OldPattern, NewPattern, Flags);
  end
  else
    Result := StringReplace(S, OldPattern, NewPattern, Flags);
  {$ELSE}
  Result := StringReplace(S, OldPattern, NewPattern, Flags);
  {$ENDIF FORCEUNICODE}
  {$ENDIF UNICODE}
end;

function JSTextExtent(ACanvas: TCanvas; const AStr: TJSString): TSize;
{$IFNDEF DELPHIXE2}
var
  LS: WideString;
{$ENDIF}
begin
  {$IFDEF DELPHIXE2}
  Result := ACanvas.TextExtent(AStr);
  {$ELSE}
  result.cX := 0;
  result.cY := 0;
  LS := AStr;
  Windows.GetTextExtentPoint32W(ACanvas.Handle, PWideChar(LS), Length(AStr), result);
  {$ENDIF DELPHIXE2}
end;

function JSTextHeight(ACanvas: TCanvas; const AStr: TJSString): Integer;
{$IFDEF FORCEUNICODE}
var
  LAnsiStr: AnsiString;
{$ENDIF FORCEUNICODE}
begin
  {$IFDEF UNICODE}
  result := JSTextExtent(ACanvas, AStr).cy;
  {$ELSE}
  if JSSupportsUnicode then
  begin
    result := JSTextExtent(ACanvas, AStr).cy;
  end
  else
  begin
    {$IFDEF FORCEUNICODE}
    LAnsiStr := JSAnsiStringFromUnicodeWideString(AStr, ACanvas.Font.Charset);
    result := ACanvas.TextHeight(LAnsiStr);
    {$ELSE}
    result := ACanvas.TextHeight(AStr);
    {$ENDIF FORCEUNICODE}
  end;
  {$ENDIF UNICODE}
end;

function JSTextWidth(ACanvas: TCanvas; const AStr: TJSString): Integer;
{$IFDEF FORCEUNICODE}
var
  LAnsiStr: AnsiString;
{$ENDIF FORCEUNICODE}
begin
  {$IFDEF UNICODE}
  result := JSTextExtent(ACanvas, AStr).cx;
  {$ELSE}
  if JSSupportsUnicode then
  begin
    result := JSTextExtent(ACanvas, AStr).cx
  end
  else
  begin
    {$IFDEF FORCEUNICODE}
    LAnsiStr := JSAnsiStringFromUnicodeWideString(AStr, ACanvas.Font.Charset);
    result := ACanvas.TextWidth(LAnsiStr);
    {$ELSE}
    result := ACanvas.TextWidth(AStr);
    {$ENDIF FORCEUNICODE}
  end;
  {$ENDIF UNICODE}
end;

function JSLowerCase(const AStr: TJSString): TJSString;
{$IFDEF FORCEUNICODE}
var
  LAnsiStr: AnsiString;
{$ENDIF FORCEUNICODE}
begin
{$IFDEF BDS}
  {$IFDEF UNICODE}
  result := WideLowercase(AStr);
  {$ELSE}
  if JSSupportsUnicode then
    result := WideLowercase(AStr)
  else
  begin
    {$IFDEF FORCEUNICODE}
    LAnsiStr := JSAnsiStringFromUnicodeWideString(AStr, DefFontData.Charset);
    result := Lowercase(LAnsiStr);
    {$ELSE}
    result := Lowercase(AStr);
    {$ENDIF FORCEUNICODE}
  end;
  {$ENDIF UNICODE}
{$ELSE}
  result := Lowercase(AStr);
{$ENDIF BDS}
end;

initialization
  {$IFDEF DELPHI2009}
  JSSupportsUnicode := False;
  {$ELSE}
    {$IFDEF DELPHI}
    JSSupportsUnicode := False;
    {$ELSE}
    JSSupportsUnicode := (Win32Platform = VER_PLATFORM_WIN32_NT) or (GetModuleHandle('unicows')>0);
    {$ENDIF DELPHI}
  {$ENDIF DELPHI2009}

end.
