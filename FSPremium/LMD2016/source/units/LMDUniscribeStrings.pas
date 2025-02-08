unit LMDUniscribeStrings;
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

LMDUnicodeStrings unit ()
-------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

{$IFDEF LMD_UNICODE}
uses
  {$ifdef LMD_ELUNISCRIBE} Windows, Graphics, LMDUsp10, {$ENDIF}
  Classes, SysUtils, Consts, RTLConsts, LMDUnicodeStrings;

{$ifdef LMD_ELUNISCRIBE}
type
  TLMDUniscribeStrings = class(TLMDWideStringList)
  protected
    FText: WideString;
    FScriptControl: TScriptControl;
    FScriptState: TScriptState;
    FScriptStringAnalysis: SCRIPT_STRING_ANALYSIS;
    FScriptLogAttr: SCRIPT_LOGATTR;
    function GetPlainTextStr: WideString; virtual;
    function GetTextStr: WideString; override;
    procedure SetTextStr(const Value: WideString); override;
    procedure GetStringAnalyse(ACanvas: TCanvas; AStrNo: Integer = -1);
    procedure FreeStringAnalyse;
    function GetStrSize(ACanvas: TCanvas; AStrNo: integer): TSize;
    procedure DrawStr(ACanvas: TCanvas; AX, AY: Integer; ASelStart, ASelEnd, AStrNo: Integer);
    procedure Reformat(Canvas: TCanvas; aLength: Integer; WordWrap: Boolean);
  public
    property PlainText: WideString read GetPlainTextStr;
    property Text: WideString read GetTextStr write SetTextStr;
    procedure DrawText(Canvas: TCanvas; var lpRect: TRect; uFormat: UINT);
    procedure PrepareText(Canvas:TCanvas; TextWidth: integer; WordWrap: Boolean);
  end;
{$endif}
{$ENDIF}

implementation
{$IFDEF LMD_UNICODE}
uses
  LMDFiles, LMDArray, LMDUnicode, LMDProcs, LMDStrings {$ifdef LMD_ELUNISCRIBE}, LMDSysIn{$ENDIF};

{$ifdef LMD_ELUNISCRIBE}
function TLMDUniscribeStrings.GetTextStr: WideString;
begin
  Result := FText;
end;

function TLMDUniscribeStrings.GetPlainTextStr: WideString;
var
  i: integer;
begin
  Result := '';
  for I := 0 to Count - 1 do
    Result := Result + Get(i)+ ' ';
end;

procedure TLMDUniscribeStrings.SetTextStr(const Value: WideString);
begin
  FText := Value;
  inherited SetTextStr(Value);
end;

procedure TLMDUniscribeStrings.FreeStringAnalyse;
begin
  ScriptStringFree(@FScriptStringAnalysis);
end;

procedure TLMDUniscribeStrings.GetStringAnalyse(ACanvas: TCanvas; AStrNo: Integer = -1);
var
  AText: WideString;
begin
  if AStrNo = -1 then
    AText := Text
  else
    AText := Get(AStrNo);
  ScriptStringAnalyse(ACanvas.Handle, PWideChar(AText), Length(AText),
        Length(AText) * 2,
        -1,       // Unicode string
        SSA_GLYPHS or SSA_FALLBACK,
        0,        // no clipping
        @FScriptControl,
        @FScriptState,
        nil,
        nil,
        nil,
        @FScriptStringAnalysis);
end;

procedure TLMDUniscribeStrings.DrawStr(ACanvas: TCanvas; AX, AY: Integer; ASelStart, ASelEnd, AStrNo: Integer);
begin
  GetStringAnalyse(ACanvas, AStrNo);

  if Assigned(FScriptStringAnalysis) then
  begin
    ScriptStringOut(
        FScriptStringAnalysis,
        AX,
        AY,
        0,
        nil,
        ASelStart,
        ASelEnd,
        FALSE);

    FreeStringAnalyse;
  end;
end;

function TLMDUniscribeStrings.GetStrSize(ACanvas: TCanvas; AStrNo: integer): TSize;
begin
  Result := TSize(Point(0, 0));
  GetStringAnalyse(ACanvas, AStrNo);
  if Assigned(FScriptStringAnalysis) then
  begin
    Result.cx := ScriptString_pSize(FScriptStringAnalysis).cx;
    Result.cy := ScriptString_pSize(FScriptStringAnalysis).cy;
    FreeStringAnalyse;
  end;
end;

procedure TLMDUniscribeStrings.Reformat(Canvas: TCanvas; aLength: Integer; WordWrap: Boolean);
var
  FStrings: TLMDWideStringList;
  FText, FStr: WideString;
  i, j, k, Pos: integer;
  PLogAttr: PSCRIPT_LOGATTR;
begin
  if aLength < 0 then
    exit;
  FStrings := TLMDWideStringList.Create;
  FStrings.Text := Text;
  Clear;
  for k := 0 to FStrings.Count - 1 do
  begin
    FText := FStrings[k];
    if WordWrap and (Length(FText) > 0) then
      repeat
        ScriptStringAnalyse(Canvas.Handle, PWideChar(FText), Length(FText),
              Length(FText) * 2,
              -1,       // Unicode string
              SSA_GLYPHS or SSA_FALLBACK or SSA_Break or SSA_CLIP,
              aLength,
              @FScriptControl,
              @FScriptState,
              nil,
              nil,
              nil,
              @FScriptStringAnalysis);

        Pos := ScriptString_pcOutChars(FScriptStringAnalysis)^;
        if Pos = 0 then
          Pos := 1;
        if Pos < Length(FText) then
        begin
          PLogAttr := ScriptString_pLogAttr(FScriptStringAnalysis);

          for i := Pos downto 1 do
          begin
            FScriptLogAttr := PSCRIPT_LOGATTR(TLMDPtrInt(pLogAttr) + i*SizeOf(SCRIPT_LOGATTR))^;
            if (fSoftBreak in FScriptLogAttr) or (fWhiteSpace in FScriptLogAttr) then
              Break;
          end;
          for j := i to Pos do // next string doesn't begin from space if it's possible
          begin
            FScriptLogAttr := PSCRIPT_LOGATTR(TLMDPtrInt(pLogAttr) + j*SizeOf(SCRIPT_LOGATTR))^;
            if not (fWhiteSpace in FScriptLogAttr) then
              Break;
          end;
          i := j;
          if i > 0 then
          begin
            FStr := Copy(FText, 0, i);
            Add(FStr);
            FText := Copy(FText, i + 1, length(FText) - i);
          end
          else
          begin
            FStr := Copy(FText, 0, Pos);
            Add(FStr);
            FText := Copy(FText, Pos + 1, length(Ftext) - Pos);
          end;
        end;
        FreeStringAnalyse;
      until Pos >= Length(FText);
    if Length(FText) > 0 then
      Add(FText);
  end;
  FStrings.Free;
end;

procedure TLMDUniscribeStrings.DrawText(Canvas: TCanvas; var lpRect: TRect; uFormat: UINT);
var
  i, x, y: integer;
  StrSize: TSize;
begin
  if LMDSIWindowsNTUp then
  begin
    DrawTextW(Canvas.Handle, PWideChar(Text), Length(Text), lpRect, uFormat);
  end
  else
  begin
    if (uFormat and DT_CALCRECT) = DT_CALCRECT then
    begin
      DrawTextW(Canvas.Handle, PWideChar(Text), Length(Text), lpRect, uFormat);
    end
    else
    begin
//      if (uFormat and DT_WORDBREAK) = DT_WORDBREAK then
//        Reformat(Canvas, lpRect.Right - lpRect.Left);
      x := 0;
      y := 0;
      for i := 0 to Count - 1 do
      begin
        StrSize := GetStrSize(Canvas,i);
        if (uFormat and DT_CENTER) = DT_CENTER then
          x := ((lpRect.Right - lpRect.Left) div 2) - (StrSize.cx div 2);
        if (uFormat and DT_RIGHT) = DT_RIGHT then
          x := lpRect.Right - StrSize.cx - 2;
        if x < 0 then
          x := 0;
        DrawStr(Canvas, lpRect.Left + x, lpRect.Top + y, 0, 0, i);
        y := y + StrSize.cy;
      end;
    end;
  end;
end;

procedure TLMDUniscribeStrings.PrepareText(Canvas:TCanvas; TextWidth: integer; WordWrap: Boolean);
begin
  Reformat(Canvas, TextWidth, WordWrap);
end;

{$ENDIF}
{$ENDIF}
end.
 
