{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           Express Cross Platform Library classes                   }
{                                                                    }
{           Copyright (c) 2000-2007 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSCROSSPLATFORMLIBRARY AND ALL   }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxDrawTextUtils;

{$I cxVer.inc}

interface

uses
  Windows, Controls,
{$IFDEF DELPHI6}
  Types,
{$ELSE}
  Classes,
{$ENDIF}
{$IFDEF CLR}
  System.Text,
{$ENDIF}
  SysUtils, Graphics;

const
  CXTO_LEFT                    = $00000000;
  CXTO_CENTER_HORIZONTALLY     = $00000001;
  CXTO_RIGHT                   = $00000002;
  CXTO_JUSTIFY_HORIZONTALLY    = $00000003;
  CXTO_DISTRIBUTE_HORIZONTALLY = $00000004;

  CXTO_TOP                     = $00000000;
  CXTO_CENTER_VERTICALLY       = $00000010;
  CXTO_BOTTOM                  = $00000020;
  CXTO_DISTRIBUTE_VERTICALLY   = $00000030;

  CXTO_PREVENT_LEFT_EXCEED     = $00000040;
  CXTO_PREVENT_TOP_EXCEED      = $00000080;

  CXTO_WORDBREAK               = $00000100;
  CXTO_SINGLELINE              = $00000200;
  CXTO_EXPANDTABS              = $00000400;
  CXTO_END_ELLIPSIS            = $00000800;

  CXTO_PATTERNEDTEXT           = $00001000;
  CXTO_EXTERNALLEADING         = $00002000;
  CXTO_EDITCONTROL             = $00004000;
  CXTO_NOCLIP                  = $00008000;

  CXTO_AUTOINDENTS             = $00010000;
  CXTO_CHARBREAK               = $00020000;

  CXTO_CALCRECT                = $00100000;
  CXTO_CALCROWCOUNT            = $00200000;

  CXTO_DEFAULT_FORMAT          = CXTO_LEFT or CXTO_TOP or CXTO_SINGLELINE;

  cxTextSpace = 2;

type
  TCaptionChar = Char;
  TcxCaptionChar = TCaptionChar;
  PcxCaptionChar = {$IFNDEF CLR}PChar{$ELSE}string{$ENDIF};
  TcxTextOutFormat = DWORD;
  TcxTextAlignX = (taLeft, taCenterX, taRight, taJustifyX, taDistributeX);
  TcxTextAlignY = (taTop, taCenterY, taBottom, taDistributeY);

  PcxTextParams = ^TcxTextParams;
  TcxTextParams = packed record
    RowHeight: Integer;
    tmExternalLeading: Integer;
    FullRowHeight: Integer;
    EndEllipsisWidth: Integer;
    BreakChar: TcxCaptionChar;
    TextAlignX: TcxTextAlignX;
    TextAlignY: TcxTextAlignY;
    WordBreak: Boolean;
    SingleLine: Boolean;
    ExpandTabs: Boolean;
    EndEllipsis: Boolean;
    ExternalLeading: Boolean;
    EditControl: Boolean;
    NoClip: Boolean;
    AutoIndents: Boolean;
    PreventLeftExceed: Boolean;
    PreventTopExceed: Boolean;
    CharBreak: Boolean;
    CalcRowCount: Boolean;
    CalcRect: Boolean;
    {$IFDEF VCL}
    MaxCharWidth: Integer;
    {$ENDIF}
    CharSet: Byte;
  end;

  TcxTextRow = record
    Text: PcxCaptionChar;
    TextLength: Integer;
    TextExtents: TSize;
    BreakCount: Integer;
    TextOriginX: Integer;
    TextOriginY: Integer;
    StartOffset: Integer;
  end;
  TcxTextRows = array of TcxTextRow;

  TCanvasHandle = {$IFDEF VCL}HDC{$ELSE}QPainterH{$ENDIF};

function cxCalcTextParams(AHandle: TCanvasHandle; AFormat: DWORD): TcxTextParams; overload;
function cxCalcTextParams(ACanvas: TCanvas; AFormat: DWORD): TcxTextParams; overload;

function cxCalcTextExtents(AHandle: TCanvasHandle; AText: PcxCaptionChar;
  ATextLength: Integer; AExpandTabs: Boolean): TSize;
function cxGetLongestTextRowWidth(const ATextRows: TcxTextRows; ARowCount: Integer): Integer;

procedure cxCalcTextRowExtents(AHandle: TCanvasHandle; var ATextRow: TcxTextRow;
  const ATextParams: TcxTextParams);

function cxMakeTextRows(AHandle: TCanvasHandle;
  AText: {$IFNDEF CLR}PcxCaptionChar{$ELSE}StringBuilder{$ENDIF}; const R: TRect;
  const ATextParams: TcxTextParams; out ATextRows: TcxTextRows;
  out ACount: Integer; AMaxLineCount: Integer = 0): Boolean; overload;
function cxMakeTextRows(ACanvas: TCanvas;
  AText: {$IFNDEF CLR}PcxCaptionChar{$ELSE}StringBuilder{$ENDIF}; const R: TRect;
  const ATextParams: TcxTextParams; out ATextRows: TcxTextRows;
  out ACount: Integer; AMaxLineCount: Integer = 0): Boolean; overload;

procedure cxPlaceTextRows(AHandle: TCanvasHandle; const R: TRect;
  var ATextParams: TcxTextParams; const ATextRows: TcxTextRows; ARowCount: Integer);

function cxMakeFormat(ATextAlignX: TcxTextAlignX; ATextAlignY: TcxTextAlignY): DWORD;

function cxPrepareRect(const R: TRect; const ATextParams: TcxTextParams;
  ALeftIndent, ARightIndent: Integer): TRect;

function cxTextOut(AHandle: TCanvasHandle; AText: PcxCaptionChar; var R: TRect;
  AFormat: TcxTextOutFormat = CXTO_DEFAULT_FORMAT; AMaxLineCount: Integer = 0;
  ALeftIndent: Integer = 0; ARightIndent: Integer = 0): Integer; overload;

function cxTextOut(AHandle: TCanvasHandle; AText: PcxCaptionChar; var R: TRect;
  AFormat: TcxTextOutFormat; ASelStart, ASelLength: Integer;
  AColor, ATextColor: TColor; AMaxLineCount: Integer = 0;
  ALeftIndent: Integer = 0; ARightIndent: Integer = 0): Integer; overload;

// for TCanvas
function cxTextOut(ACanvas: TCanvas; AText: PcxCaptionChar; var R: TRect;
  AFormat: TcxTextOutFormat = CXTO_DEFAULT_FORMAT; AMaxLineCount: Integer = 0;
  ALeftIndent: Integer = 0; ARightIndent: Integer = 0): Integer; overload;

function cxTextOut(ACanvas: TCanvas; AText: PcxCaptionChar; var R: TRect;
  AFormat: TcxTextOutFormat; ASelStart, ASelLength: Integer;
  AColor, ATextColor: TColor; AMaxLineCount: Integer = 0;
  ALeftIndent: Integer = 0; ARightIndent: Integer = 0): Integer; overload;

procedure cxTextRowsOutHighlight(AHandle: TCanvasHandle; const R: TRect;
  const ATextParams: TcxTextParams; const ATextRows: TcxTextRows; ARowCount,
  ASelStart, ASelLength: Integer; AColor, ATextColor: TColor; AForceEndEllipsis: Boolean);

implementation

uses
  Math,
{$IFDEF CLR}
  cxContainer, System.Security, System.Runtime.InteropServices,
{$ENDIF}
  cxClasses, cxGraphics;

{$IFNDEF CLR}
type
  TCanvasAccess = class(TControlCanvas);
{$ELSE}
[SuppressUnmanagedCodeSecurity, DllImport(gdi32, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetTextExtentExPoint')]
function GetTextExtentExPoint(DC: HDC; p2: string; p3, p4: Integer; p5: IntPtr;
  p6: array of Integer; out p7: TSize): BOOL; external; overload;
{$ENDIF}

const
  CXTO_VERT_ALIGN_OFFSET = 4;
  CXTO_HORZ_ALIGN_MASK   = CXTO_CENTER_HORIZONTALLY or CXTO_RIGHT or CXTO_JUSTIFY_HORIZONTALLY or CXTO_DISTRIBUTE_HORIZONTALLY;
  CXTO_VERT_ALIGN_MASK   = CXTO_CENTER_VERTICALLY or CXTO_BOTTOM or CXTO_DISTRIBUTE_VERTICALLY;

  Tab: TcxCaptionChar = #9;
  LF: TcxCaptionChar = #10;
  CR: TcxCaptionChar = #13;

  cxEndEllipsisChars: PcxCaptionChar = '...';

var
  cxEndEllipsisCharsLength: Integer;

function cxMakeFormat(ATextAlignX: TcxTextAlignX; ATextAlignY: TcxTextAlignY): DWORD;
begin
  Result := Byte(ATextAlignX) or (Byte(ATextAlignY) shl CXTO_VERT_ALIGN_OFFSET);
end;

{$IFDEF VCL}
function cxCalcTextExtents(AHandle: TCanvasHandle; AText: PcxCaptionChar;
  ATextLength: Integer; AExpandTabs: Boolean): TSize;
var
  ATextExtent: DWORD;
  {$IFDEF CLR}
  ATempArray: TIntegerDynArray;
  {$ENDIF}
  R: TRect;
begin
  if AExpandTabs then
  begin
    if ATextLength <= 4096 then
    begin
    {$IFNDEF CLR}
      ATextExtent := GetTabbedTextExtent(AHandle, AText, ATextLength, 0, Result);
    {$ELSE}
      ATempArray := nil;
      ATextExtent := GetTabbedTextExtent(AHandle, AText, ATextLength, 0, ATempArray);
    {$ENDIF}
      Result.cx := LoWord(ATextExtent);
      Result.cy := HiWord(ATextExtent);
    end
    else
    begin
      R := cxEmptyRect;
      Result.cy := DrawText(AHandle, AText, ATextLength, R,
        DT_SINGLELINE or DT_NOPREFIX or DT_CALCRECT or DT_EXPANDTABS);
      Result.cx := R.Right - R.Left;
    end;
  end
  else
    GetTextExtentPoint32(AHandle, AText, ATextLength, Result);
end;

function IntersectClipRect(AHandle: TCanvasHandle; const R: TRect): HRGN;
begin
  Result := CreateRectRgn(0, 0, 0, 0);
  if GetClipRgn(AHandle, Result) <> 1 then
  begin
    DeleteObject(Result);
    Result := 0;
  end;
  with R do
    Windows.IntersectClipRect(AHandle, Left, Top, Right, Bottom);
end;

procedure RestoreClipRgn(AHandle: TCanvasHandle; var ARgn: HRGN);
begin
  SelectClipRgn(AHandle, ARgn);
  if ARgn <> 0 then
  begin
    DeleteObject(ARgn);
    ARgn := 0
  end;
end;
{$ELSE}
function RectVisible(APainter: QPainterH; const R: TRect): Boolean;
var
  VP: TRect;
begin
  Result := False;
  QPainter_viewport(APainter, @VP);
  if not IntersectRect(VP, VP, R) then Exit;
  Result := not QPainter_hasClipping(APainter);
  if not Result then
    Result := QRegion_contains(QPainter_clipRegion(APainter), PRect(@R));
end;

procedure DrawText(AHandle: TCanvasHandle; X, Y: Integer; R: TRect; const S: string;
  ALength: Integer; AFlags: Integer = 0);
begin
  R.Top := Y;
  R.Left := X;
  QPainter_drawText(AHandle, @R, AFlags, PWideString(@S), ALength, nil, nil);
end;

function cxCalcTextExtents(AHandle: TCanvasHandle; AText: PcxCaptionChar;
  ATextLength: Integer; AExpandTabs: Boolean): TSize;
var
  R: TRect;
  S: WideString;
begin
  R := Rect(0, 0, MaxInt, MaxInt);
  S := WideString(AText);
  if AExpandTabs then
    QPainter_boundingRect(AHandle, @R, @R, 256, @S, ATextLength, nil)
  else
    QPainter_boundingRect(AHandle, @R, @R, 0, @S, ATextLength, nil);
  with R do
  begin
    Result.cx := Right - Left;
    Result.cy := Bottom - Top;
  end;
end;

function GetSymbolsInWidth(AHandle: TCanvasHandle; const S: string;
  ALength, AWidth: Integer): Integer;
var
  R: TRect;
begin
  Result := ALength;
  QPainter_boundingRect(AHandle, @R, @R, 0, PWideString(@S), Result, nil);
  // TODO Make optimization (binary search)
  while (R.Right - R.Left > AWidth) do
  begin
    Dec(Result);
    if Result = 0 then break;
    QPainter_boundingRect(AHandle, @R, @R, 0, PWideString(@S), Result, nil);
  end;
end;

function IntersectClipRect(AHandle: TCanvasHandle; const R: TRect;
  var ASaveClipping: Boolean; var AClipRgn: QRegionH): QRegionH;
begin
  ASaveClipping := QPainter_hasClipping(AHandle);
  Result := QRegion_create(QPainter_clipRegion(AHandle));
  AClipRgn := QRegion_create(@R, QRegionRegionType_Rectangle);
  if ASaveClipping then
    QRegion_intersect(AClipRgn, AClipRgn, Result);
  QPainter_setClipRegion(AHandle, AClipRgn);
end;

procedure RestoreClipRgn(AHandle: TCanvasHandle; ASaveClipping: Boolean;
  ASaveClipRgn: QRegionH);
begin
  QPainter_setClipRegion(AHandle, ASaveClipRgn);
  QPainter_setClipping(AHandle, ASaveClipping);
  QRegion_destroy(ASaveClipRgn);
end;
{$ENDIF}

procedure cxCalcTextRowExtents(AHandle: TCanvasHandle; var ATextRow: TcxTextRow; const ATextParams: TcxTextParams);
begin
  with ATextRow do
    TextExtents := cxCalcTextExtents(AHandle, Text, TextLength, ATextParams.ExpandTabs);
end;

function cxCalcMinStringLength(AHandle: TCanvasHandle; const ATextParams: TcxTextParams;
  AText: PcxCaptionChar; ATextLength, AWidth: Integer; var ATotalLength: Integer): Integer;
var
  L, H, C: Integer;
begin
  Result := 1;
  H := ATextLength;
  L := H;

  ATotalLength := cxCalcTextExtents(AHandle, AText, L, False).cx;

  if ATotalLength / AWidth > 8 then
  begin
    Result := 1;
    ATotalLength := 0;;
    Exit;
  end
  else
    ATotalLength := cxCalcTextExtents(AHandle, AText, L, ATextParams.ExpandTabs).cx;

  while (L > 1) and (ATotalLength > AWidth) do
  begin
    L := L div 2;
    ATotalLength := cxCalcTextExtents(AHandle, AText, L, ATextParams.ExpandTabs).cx;
  end;
  while L <= H do
  begin
    Result := (L + H) shr 1;
    ATotalLength := cxCalcTextExtents(AHandle, AText, Result, ATextParams.ExpandTabs).cx;
    if L = H then
      C := 0
    else
      C := ATotalLength - AWidth;
    if C < 0 then
      L := Result + 1
    else
    begin
      H := Result - 1;
      if C = 0 then
        Break;
    end;
  end;
  if (ATotalLength > AWidth) and (Result > 1) then
  begin
    Dec(Result);
    ATotalLength := cxCalcTextExtents(AHandle, AText, Result, ATextParams.ExpandTabs).cx;
  end;
end;

procedure cxGetTextRow(AHandle: TCanvasHandle;
  var S: {$IFNDEF CLR}PcxCaptionChar{$ELSE}StringBuilder{$ENDIF};
  var ALength: Integer; AWidth: Integer; AIsLastRow: Boolean;
  const ATextParams: TcxTextParams; var ATextRow: TcxTextRow);

var
  AMinStrLen, ATotalTextWidth, I, ABreakPos: Integer;
  ASize: TSize;
  ABreakByWords, ABreakByChars, AIsSpecialProcessedRow, ACRExists: Boolean;
  ACharLen: Integer;
{$IFNDEF CLR}
  AChar: PChar;
{$ENDIF}
begin
{$IFNDEF CLR}
  FillChar(ATextRow, SizeOf(ATextRow), 0);
{$ELSE}
//  ATextRow.Clear;
{$ENDIF}
  if S = nil then Exit;

  ABreakPos := -1;
  AMinStrLen := cxCalcMinStringLength(AHandle, ATextParams, {$IFNDEF CLR}S{$ELSE}S.ToString{$ENDIF},
    ALength, Max(AWidth, 1), ATotalTextWidth);

  with ATextParams do
  begin
    ABreakByWords :=
      not SingleLine and (WordBreak or (TextAlignX in [taJustifyX, taDistributeX]));
    ABreakByChars := ABreakByWords and CharBreak;
    AIsSpecialProcessedRow := not EditControl and
      not NoClip and not (TextAlignX in [taJustifyX, taDistributeX]) and AIsLastRow and EndEllipsis;
  end;
  
{$IFNDEF CLR}
  AChar := S;
{$ENDIF}
  with ATextRow do
  begin
    for I := 0 to ALength - 1 do
    begin
{$IFNDEF CLR}
      if SysLocale.FarEast then
      begin
        ACharLen := cxStrCharLength(AChar);
        if StrByteType(S, I) = mbTrailByte then Continue;
        Inc(AChar, ACharLen);
      end
      else
{$ENDIF}
        ACharLen := 1;
      TextLength := I + ACharLen;

      if (S[I] = (ATextParams.BreakChar)) or (S[I] = Tab) then
      begin
        Inc(BreakCount);
        ABreakPos := I;
      end;

      if ((S[I] = CR) or (S[I] = LF)) and not AIsSpecialProcessedRow and
        not ATextParams.SingleLine then
      begin
        Dec(TextLength);
        if ATextParams.TextAlignX = taJustifyX then BreakCount := 0;
        Break;
      end;

      if ABreakByWords or AIsSpecialProcessedRow or ATextParams.SingleLine then
      begin
        if I >= AMinStrLen then
        begin
          if ATextParams.ExpandTabs then
            ATotalTextWidth := cxCalcTextExtents(AHandle, {$IFNDEF CLR}S{$ELSE}S.ToString{$ENDIF}, TextLength, True).cx
          else
          begin
            ASize := cxCalcTextExtents(AHandle, {$IFNDEF CLR}@S[I]{$ELSE}S[I]{$ENDIF}, ACharLen, False);
            Inc(ATotalTextWidth, ASize.cx);
          end;
        end;

        if ATotalTextWidth > AWidth then
        begin
          if AIsSpecialProcessedRow or ATextParams.SingleLine then
            Break
          else
          begin
            if ABreakPos <> -1 then
            begin
              TextLength := ABreakPos + 1;
              Break;
            end
            else
              if ABreakByChars then
              begin
                if TextLength > {$IFNDEF CLR}cxStrCharLength(S){$ELSE}1{$ENDIF} then Dec(TextLength, ACharLen);
                Break;
              end;
          end;
        end;
      end;
    end;
    Text := {$IFNDEF CLR}S{$ELSE}S.ToString{$ENDIF};

    // truncate trailing spaces
    if ATextParams.TextAlignX in [taJustifyX, taDistributeX] then
      while (TextLength > 0) and
        ((S[TextLength - 1] = (ATextParams.BreakChar)) or (S[TextLength - 1] = Tab)) do
      begin
        if BreakCount > 0 then Dec(BreakCount);
        Dec(TextLength);
      end;
  end;

  cxCalcTextRowExtents(AHandle, ATextRow, ATextParams);

  ACRExists := False;
  // correct source string
{$IFNDEF CLR}
  Inc(S, ATextRow.TextLength);
{$ELSE}
  S := S.Remove(0, ATextRow.TextLength);
{$ENDIF}
  Dec(ALength, ATextRow.TextLength);

  I := 0;
  while (I < ALength) and (S[I] = ATextParams.BreakChar) do
    Inc(I);
  if (I < ALength) and (S[I] = Tab) then
    Inc(I);
  if (I < ALength) and (S[I] = CR) then
  begin
    Inc(I);
    ACRExists := True;
  end;
  if (I < ALength) and (S[I] = LF) then
    Inc(I);
{$IFNDEF CLR}
  Inc(S, I);
{$ELSE}
  S := S.Remove(0, I);
{$ENDIF}
  Dec(ALength, I);
  // doesn't justify last row  (like Excel ?)
  if ((ALength = 0) or ACRExists) and (ATextParams.TextAlignX = taJustifyX) then
   ATextRow.BreakCount := 0;
end;

function cxCalcTextParams(AHandle: TCanvasHandle; AFormat: TcxTextOutFormat): TcxTextParams;
var
  ATextMetric: TTextMetric;
begin
{$IFNDEF CLR}
  FillChar(Result, SizeOf(Result), 0);
{$ENDIF}
  with Result do
  begin
    GetTextMetrics(AHandle, ATextMetric);
    BreakChar := ATextMetric.tmBreakChar;
    MaxCharWidth := ATextMetric.tmMaxCharWidth;
    RowHeight := ATextMetric.tmHeight;
    CharSet := ATextMetric.tmCharSet;

    TextAlignX := TcxTextAlignX(AFormat and CXTO_HORZ_ALIGN_MASK);
    TextAlignY := TcxTextAlignY(AFormat and CXTO_VERT_ALIGN_MASK shr CXTO_VERT_ALIGN_OFFSET);

    AutoIndents := AFormat and CXTO_AUTOINDENTS <> 0;
    CalcRect := AFormat and CXTO_CALCRECT <> 0;
    CalcRowCount := AFormat and CXTO_CALCROWCOUNT <> 0;
    CharBreak := (AFormat and CXTO_CHARBREAK <> 0) or SysLocale.FarEast;
    EditControl := AFormat and CXTO_EDITCONTROL <> 0;
    EndEllipsis := AFormat and CXTO_END_ELLIPSIS <> 0;
    ExternalLeading := AFormat and CXTO_EXTERNALLEADING <> 0;
    ExpandTabs := AFormat and CXTO_EXPANDTABS <> 0;
    NoClip := AFormat and CXTO_NOCLIP <> 0;
    PreventLeftExceed := AFormat and CXTO_PREVENT_LEFT_EXCEED <> 0;
    PreventTopExceed := AFormat and CXTO_PREVENT_TOP_EXCEED <> 0;
    SingleLine := AFormat and CXTO_SINGLELINE <> 0;
    WordBreak := AFormat and CXTO_WORDBREAK <> 0;

    if ExternalLeading then tmExternalLeading := ATextMetric.tmExternalLeading;
    FullRowHeight := RowHeight + tmExternalLeading;
    if AFormat and CXTO_END_ELLIPSIS = CXTO_END_ELLIPSIS then
      EndEllipsisWidth := cxCalcTextExtents(AHandle, cxEndEllipsisChars, cxEndEllipsisCharsLength, False).cX
    else EndEllipsisWidth := 0;
  end;
end;

function cxCalcTextParams(ACanvas: TCanvas; AFormat: DWORD): TcxTextParams;
begin
{$IFNDEF CLR}
  TCanvasAccess(ACanvas).RequiredState([csHandleValid, csFontValid]);
{$ELSE}
  TCanvasAccess._RequiredState(ACanvas, [csHandleValid, csFontValid]);
{$ENDIF}
  Result := cxCalcTextParams(ACanvas.Handle, AFormat);
end;

function cxMakeTextRows(AHandle: TCanvasHandle;
  AText: {$IFNDEF CLR}PcxCaptionChar{$ELSE}StringBuilder{$ENDIF};
  const R: TRect; const ATextParams: TcxTextParams; out ATextRows: TcxTextRows;
  out ACount: Integer; AMaxLineCount: Integer = 0): Boolean;

  function CheckIsLastRow(ATotalHeight, H: Integer): Boolean;
  begin
    with ATextParams do
      if SingleLine then
        Result := True
      else
        if (TextAlignY = taTop) and not CalcRect then
        begin
          if (EditControl{ or EndEllipsis}) and not NoClip then
            Result := ATotalHeight + FullRowHeight > H
          else
            Result := ATotalHeight > H
        end
        else
          Result := (AMaxLineCount > 0) and (ACount = AMaxLineCount);
  end;

  procedure ExpandTextRows(var ACapacity: Integer);
  const
    Delta: Integer = 4;
  begin
    if ACount > ACapacity then
    begin
      Inc(ACapacity, Delta);
      SetLength(ATextRows, ACapacity);
    end;
  end;

var
  P: {$IFNDEF CLR}PcxCaptionChar{$ELSE}StringBuilder{$ENDIF};
  AIsLastRow, ARectIsSmall: Boolean;
  ATotalHeight, ACapacity, H, W, L, AOffset: Integer;
begin
  P := {$IFNDEF CLR}AText{$ELSE}StringBuilder.Create(AText.ToString){$ENDIF};
  ARectIsSmall := False;
  ATextRows := nil;
  ACount := 0;
  if P <> nil then
  begin
    AOffset := 0;
    if ATextParams.CalcRect and ATextParams.SingleLine then
    begin
      ACount := 1;
      SetLength(ATextRows, ACount);
      ATextRows[0].Text := {$IFNDEF CLR}P{$ELSE}P.ToString{$ENDIF};
      ATextRows[0].TextLength := {$IFNDEF CLR}Length(P){$ELSE}P.Length{$ENDIF};
      cxCalcTextRowExtents(AHandle, ATextRows[0], ATextParams);
    end
    else
    begin
      AIsLastRow := False;
      ATotalHeight := 0;
      ACapacity := 0;
      L := {$IFNDEF CLR}Length(P){$ELSE}P.Length{$ENDIF};
      W := R.Right - R.Left;
      H := R.Bottom - R.Top;
      while {$IFDEF CLR}(P.Length <> 0){$ELSE}(P^ <> #0){$ENDIF} and not AIsLastRow do
      begin
        Inc(ACount);
        ExpandTextRows(ACapacity);
        Inc(ATotalHeight, ATextParams.FullRowHeight);
        AIsLastRow := CheckIsLastRow(ATotalHeight, H);
        cxGetTextRow(AHandle, P, L, W, AIsLastRow, ATextParams, ATextRows[ACount - 1]);
        ATextRows[ACount - 1].StartOffset := AOffset;
      {$IFDEF CLR}
        AOffset := AText.Length - P.Length;
      {$ELSE}
        AOffset := Integer(Pointer(P)) - Integer(Pointer(AText));
      {$ENDIF}
        if not AIsLastRow then
          AIsLastRow := L = 0;
        if (AMaxLineCount > 0) and (ACount = AMaxLineCount) then
          Break;
      end;
      with ATextParams do
        ARectIsSmall := not SingleLine and not CalcRect and
          (AMaxLineCount > 0) and (ACount = AMaxLineCount) and (L > 0);
      if ACapacity > ACount then
        SetLength(ATextRows, ACount);
    end;
  end;
  Result := not ARectIsSmall;
end;

function cxMakeTextRows(ACanvas: TCanvas;
  AText: {$IFNDEF CLR}PcxCaptionChar{$ELSE}StringBuilder{$ENDIF};
  const R: TRect; const ATextParams: TcxTextParams; out ATextRows: TcxTextRows;
  out ACount: Integer; AMaxLineCount: Integer = 0): Boolean;
begin
  Result := cxMakeTextRows(ACanvas.Handle, AText, R, ATextParams, ATextRows,
    ACount, AMaxLineCount);
end;

procedure cxPlaceTextRows(AHandle: TCanvasHandle; const R: TRect; var ATextParams: TcxTextParams;
  const ATextRows: TcxTextRows; ARowCount: Integer);

  procedure CalcExtraAndTopRowOffset(out AExtra, ATopRowOffset: Integer);
  var
    H: Integer;
  begin
    AExtra := 0;
    with ATextParams do
    begin
      if (ARowCount > 1) and (TextAlignY = taDistributeY) then
      begin
        H := R.Bottom - R.Top;
        Dec(H, RowHeight);
        if H / (ARowCount - 1) > RowHeight then
        begin
          FullRowHeight := H div (ARowCount - 1);
          AExtra := H mod (ARowCount - 1);
        end;
      end;

      case TextAlignY of
        taCenterY:
          ATopRowOffset := R.Top + (R.Bottom - R.Top - ARowCount * FullRowHeight) div 2;
        taBottom:
          ATopRowOffset := R.Bottom - ARowCount * FullRowHeight + tmExternalLeading;
      else
        ATopRowOffset := R.Top;
      end;

      if PreventTopExceed and (ATopRowOffset < R.Top) then
        ATopRowOffset := R.Top;
    end;
  end;

  procedure PlaceRows(AExtra, ATopRowOffset: Integer);
  var
    I: Integer;
  begin
    for I := 0 to ARowCount - 1 do
      with ATextRows[I] do
      begin
        // Horizontally
        case ATextParams.TextAlignX of
          taCenterX:
            TextOriginX := R.Left + (R.Right - R.Left - TextExtents.cx) div 2;
          taRight:
            TextOriginX := R.Right - TextExtents.cx;
        else
          TextOriginX := R.Left;
        end;
        if ATextParams.PreventLeftExceed and (TextOriginX < R.Left) then
          TextOriginX := R.Left;

        // Vertically
        TextOriginY := ATopRowOffset;
        Inc(ATopRowOffset, ATextParams.FullRowHeight);
        if AExtra > 0 then
        begin
          Inc(ATopRowOffset);
          Dec(AExtra);
        end;
      end;
  end;

var
  Extra, TopRowOffset: Integer;
begin
  CalcExtraAndTopRowOffset(Extra, TopRowOffset);
  PlaceRows(Extra, TopRowOffset);
end;

function cxPrepareRect(const R: TRect; const ATextParams: TcxTextParams;
  ALeftIndent, ARightIndent: Integer): TRect;
begin
  Result := R;
  with Result do
  begin
    Inc(Left, ALeftIndent);
    Dec(Right, ARightIndent);
  end;
end;

function cxUnprepareRect(const R: TRect; const ATextParams: TcxTextParams;
  ALeftIndent: Integer = 0; ARightIndent: Integer = 0): TRect;
begin
  Result := R;
  with Result do
  begin
    Dec(Left, ALeftIndent);
    Inc(Right, ARightIndent);
  end;
end;

{$WARNINGS OFF}
procedure cxTextRowsOutHighlight(AHandle: TCanvasHandle; const R: TRect;
  const ATextParams: TcxTextParams; const ATextRows: TcxTextRows; ARowCount,
  ASelStart, ASelLength: Integer; AColor, ATextColor: TColor; AForceEndEllipsis: Boolean);

  procedure OutTextRow(const ATextRow: TcxTextRow);
  var
    Stub: {$IFDEF CLR}TIntegerDynArray{$ELSE}Integer{$ENDIF};
  begin
    with ATextRow do
      if ATextParams.ExpandTabs then
      begin
        Stub := 0;
        TabbedTextOut(AHandle, TextOriginX, TextOriginY, Text, TextLength, 0, Stub, TextOriginX);
      end
      else
        TextOut(AHandle, TextOriginX, TextOriginY, Text, TextLength);
  end;

  procedure PrepareEndEllipsis(var ATextRow: TcxTextRow; var AWidth: Integer);
  var
    ACharNumber: Integer;
    ASize: TSize;
  begin
    Dec(AWidth, ATextParams.EndEllipsisWidth);
    if AWidth < 0 then AWidth := 0;
    with ATextRow do
    begin
      if not GetTextExtentExPoint(AHandle, Text, TextLength, AWidth,
        {$IFNDEF CLR}@{$ENDIF}ACharNumber, nil, ASize) then
          ACharNumber := 0;
      if ACharNumber = 0 then
        ACharNumber := {$IFNDEF CLR}cxStrCharLength(Text){$ELSE}1{$ENDIF};
      TextLength := ACharNumber;
    end;
    cxCalcTextRowExtents(AHandle, ATextRow, ATextParams);
  end;

  procedure OutEndEllipsis(const ATextRow: TcxTextRow; var ARowRect: TRect);
  const
    ClipTexts: array[Boolean] of UINT = (0, ETO_CLIPPED);
  var
    fuOptions: UINT;
  begin
    Inc(ARowRect.Left, ATextRow.TextExtents.cx);
    if ARowRect.Left < ARowRect.Right then
    begin
      fuOptions := ClipTexts[not ATextParams.NoClip and (ARowRect.Left + ATextParams.EndEllipsisWidth > ARowRect.Right)];
      ExtTextOut(AHandle, ARowRect.Left, ATextRow.TextOriginY, fuOptions,
      {$IFNDEF CLR}
        @ARowRect, PChar(cxEndEllipsisChars),
      {$ELSE}
        ARowRect, cxEndEllipsisChars,
      {$ENDIF}
        Length(cxEndEllipsisChars), nil);
    end;
  end;

  function GetSubstringWidth(AText: PcxCaptionChar; ATextLength, ASubstringLength: Integer): Integer;
  var
    ACharExtents: array of Integer;
    ATextSize: TSize;
  begin
    if ASubstringLength = 0 then
      Result := 0
    else
    begin
      SetLength(ACharExtents, ATextLength);
    {$IFDEF CLR}
      GetTextExtentExPoint(AHandle, AText, ATextLength, 0, nil, ACharExtents, ATextSize);
    {$ELSE}
      GetTextExtentExPoint(AHandle, AText, ATextLength, 0, nil, @ACharExtents[0], ATextSize);
    {$ENDIF}
      Result := ACharExtents[ASubstringLength - 1];
    end;
  end;

var
  ARowRect, AHighlightRect: TRect;
  W, I, F, L: Integer;
  ABreakExtra: Integer;
  APrevBkMode: {$IFDEF VCL}Integer{$ELSE}BGMode{$ENDIF};
  ASaveTextColor: {$IFDEF VCL}TColor{$ELSE}QColorH{$ENDIF};
  ANeedClip, ANeedEndEllipsis: Boolean;
  ATextRow: TcxTextRow;
  AHighlightStart, AHighlightEnd: Integer;
  ARgn, ASaveClipRgn: {$IFDEF VCL}HRGN{$ELSE}QRegionH{$ENDIF};
  ABrush: {$IFDEF VCL}HBRUSH{$ELSE}QBrushH{$ENDIF};
begin
  AColor := ColorToRGB(AColor);
  ATextColor := ColorToRGB(ATextColor);
  W := R.Right - R.Left;
  ARowRect := R;
  APrevBkMode := SetBkMode(AHandle, Windows.TRANSPARENT);

  if (ASelLength > 0) and (AColor <> clNone) then
    ABrush := CreateSolidBrush(AColor);

  for I := 0 to ARowCount - 1 do
  begin
    ATextRow := ATextRows[I];
    with ATextRow do
    begin
      if TextLength <> 0 then
      begin
        ARowRect.Top := TextOriginY;
        ARowRect.Bottom := ARowRect.Top + ATextParams.FullRowHeight;
        ANeedEndEllipsis := ATextParams.EndEllipsis and (I = ARowCount - 1) and
          ((TextExtents.cx > W) or AForceEndEllipsis);
        ABreakExtra := 0;
        if (ATextParams.TextAlignX in [taJustifyX, taDistributeX]) and not ANeedEndEllipsis then
        begin
          ABreakExtra := W - TextExtents.cX;
          if (BreakCount <> 0) and (ABreakExtra > 0) then
            SetTextJustification(AHandle, ABreakExtra, BreakCount);
        end;

        ANeedClip := not ATextParams.NoClip and ((TextExtents.cX > W) or
          (ARowRect.Top < R.Top) or (ARowRect.Bottom > R.Bottom));
        if ANeedClip then
        begin
          if ARowRect.Top < R.Top then ARowRect.Top := R.Top;
          if ARowRect.Bottom > R.Bottom then ARowRect.Bottom := R.Bottom;
          ARgn := IntersectClipRect(AHandle, ARowRect);
        end;

        if ANeedEndEllipsis then
          PrepareEndEllipsis(ATextRow, W);

        if ASelLength > 0 then
        begin
          if not ((ASelStart >= StartOffset + TextLength) or
            (ASelStart + ASelLength <= StartOffset)) then
          begin
            F := Max(ASelStart, StartOffset);
            L := Min(ASelStart + ASelLength, StartOffset + TextLength);
            Dec(F, StartOffset);
            Dec(L, StartOffset);
            if L > F then
            begin
              AHighlightStart := GetSubstringWidth(Text, TextLength, F);
              AHighlightEnd := GetSubstringWidth(Text, TextLength, L);
              if cxGetWritingDirection(ATextParams.CharSet, Text) = coRightToLeft then
              begin
                AHighlightRect.Left := TextOriginX + TextExtents.cx - AHighlightEnd;
                AHighlightRect.Right := TextOriginX + TextExtents.cx - AHighlightStart;
              end
              else
              begin
                AHighlightRect.Left := TextOriginX + AHighlightStart;
                AHighlightRect.Right := TextOriginX + AHighlightEnd;
              end;
              AHighlightRect.Top := ARowRect.Top;
              AHighlightRect.Bottom := ARowRect.Bottom;
              if not IsRectEmpty(AHighlightRect) then
              begin
                ASaveClipRgn := IntersectClipRect(AHandle, AHighlightRect);
                if AColor <> clNone then
                  FillRect(AHandle, AHighlightRect, ABrush);
                ASaveTextColor := SetTextColor(AHandle, ATextColor);
                OutTextRow(ATextRow);
                SetTextColor(AHandle, ASaveTextColor);
                RestoreClipRgn(AHandle, ASaveClipRgn);
                with AHighlightRect do
                  ExcludeClipRect(AHandle, Left, Top, Right, Bottom);
                if ANeedEndEllipsis and (ASelStart + ASelLength >= StartOffset + TextLength) then
                begin
                  ANeedEndEllipsis := False;
                  ASaveTextColor := SetTextColor(AHandle, ATextColor);
                  OutEndEllipsis(ATextRow, ARowRect);
                  SetTextColor(AHandle, ASaveTextColor);
                end;
              end;
            end;
          end
        end;
        OutTextRow(ATextRow);

        if ANeedEndEllipsis then
          OutEndEllipsis(ATextRow, ARowRect);

        if ANeedClip then
          RestoreClipRgn(AHandle, ARgn);
        if ABreakExtra > 0 then SetTextJustification(AHandle, 0, 0);
      end
      else
        if AForceEndEllipsis and ATextParams.EndEllipsis and (I = ARowCount - 1) then
        begin
          ARowRect.Top := TextOriginY;
          ARowRect.Bottom := ARowRect.Top + ATextParams.FullRowHeight;
          PrepareEndEllipsis(ATextRow, W);
          OutEndEllipsis(ATextRow, ARowRect);
        end;
    end;
  end;

  if (ASelLength > 0) and (AColor <> clNone) then
    DeleteObject(ABrush);
  SetBkMode(AHandle, APrevBkMode);
end;
{$WARNINGS ON}

function cxGetLongestTextRowWidth(const ATextRows: TcxTextRows; ARowCount: Integer): Integer;
var
  I, V: Integer;
begin
  if ARowCount > Length(ATextRows) then ARowCount := Length(ATextRows);
  if ARowCount = 0 then
    Result := 0
  else
  begin
    Result := ATextRows[0].TextExtents.cx;
    for I := 1 to ARowCount - 1 do
    begin
      V := ATextRows[I].TextExtents.cx;
      if V > Result then Result := V;
    end;
  end;
end;

function cxTextOut(AHandle: TCanvasHandle; AText: PcxCaptionChar; var R: TRect;
  AFormat: TcxTextOutFormat; ASelStart, ASelLength: Integer;
  AColor, ATextColor: TColor; AMaxLineCount: Integer = 0;
  ALeftIndent: Integer = 0; ARightIndent: Integer = 0): Integer;

  function ProcessText(const ATextParams: TcxTextParams; const ATextRect: TRect): Boolean;
  begin
    if ATextParams.CalcRect then
      Result := (ATextRect.Right - ATextRect.Left) > 0
    else
      Result := not IsRectEmpty(ATextRect);
  end;

var
  ATextHeight, ARowCount, ATextLength: Integer;
  ATextParams: TcxTextParams;
  ATextRect: TRect;
  ATextRows: TcxTextRows;
  AForceEndEllipsis: Boolean;
begin
  Result := 0;
  ATextLength := {$IFNDEF CLR}StrLen(AText){$ELSE}AText.Length{$ENDIF};
  if ATextLength = 0 then Exit;
  ATextParams := cxCalcTextParams(AHandle, AFormat);
  ATextRect := cxPrepareRect(R, ATextParams, ALeftIndent, ARightIndent);

  ATextHeight := 0;
  if ProcessText(ATextParams, ATextRect) then
  begin
    ATextRows := nil;
    AForceEndEllipsis := not cxMakeTextRows(AHandle, {$IFDEF CLR}StringBuilder.Create{$ENDIF}(AText), ATextRect, ATextParams, ATextRows, ARowCount, AMaxLineCount);
    if ARowCount <> 0 then
    try
      if ATextParams.CalcRect then
      begin
        if (AMaxLineCount > 0) and (AMaxLineCount < ARowCount) then
          ARowCount := AMaxLineCount;
        ATextRect.Right := ATextRect.Left + cxGetLongestTextRowWidth(ATextRows, ARowCount);
        if not ATextParams.SingleLine then
        begin
          ATextRows := nil;
          cxMakeTextRows(AHandle, {$IFDEF CLR}StringBuilder.Create{$ENDIF}(AText), ATextRect, ATextParams, ATextRows, ARowCount, AMaxLineCount);
        end;
        cxPlaceTextRows(AHandle, ATextRect, ATextParams, ATextRows, ARowCount);
        ATextRect.Bottom := ATextRows[ARowCount - 1].TextOriginY + ATextParams.RowHeight;
        R := cxUnprepareRect(ATextRect, ATextParams, ALeftIndent, ARightIndent);
      end
      else
      begin
        if (AMaxLineCount > 0) and (ARowCount >= AMaxLineCount) then
        begin
          ARowCount := AMaxLineCount;
          with ATextParams do
            AForceEndEllipsis := AForceEndEllipsis and EndEllipsis and EditControl and not SingleLine;
        end
        else
          AForceEndEllipsis := False;

        cxPlaceTextRows(AHandle, ATextRect, ATextParams, ATextRows, ARowCount);
        if (ASelStart < 0) or (ASelStart >= ATextLength) then
          ASelLength := 0
        else
          if (ASelLength + ASelStart) > ATextLength then
            ASelLength := ATextLength - ASelStart;
        cxTextRowsOutHighlight(AHandle, ATextRect, ATextParams, ATextRows,
          ARowCount, ASelStart, ASelLength, AColor, ATextColor, AForceEndEllipsis);
      end;
      ATextHeight := ATextRows[ARowCount - 1].TextOriginY + ATextParams.RowHeight - ATextRect.Top;
    finally
      ATextRows := nil;
    end;
  end;
  if ATextParams.CalcRowCount or (ATextHeight = 0) then
    Result := ARowCount
  else
    Result := ATextHeight;
end;

function cxTextOut(ACanvas: TCanvas; AText: PcxCaptionChar; var R: TRect;
  AFormat: TcxTextOutFormat; ASelStart, ASelLength: Integer;
  AColor, ATextColor: TColor; AMaxLineCount: Integer = 0;
  ALeftIndent: Integer = 0; ARightIndent: Integer = 0): Integer;
begin
  Result := cxTextOut(ACanvas.Handle, AText, R, AFormat, ASelStart, ASelLength,
    AColor, ATextColor, AMaxLineCount, ALeftIndent, ARightIndent);
end;

function cxTextOut(ACanvas: TCanvas; AText: PcxCaptionChar; var R: TRect;
  AFormat: TcxTextOutFormat = CXTO_DEFAULT_FORMAT; AMaxLineCount: Integer = 0;
  ALeftIndent: Integer = 0; ARightIndent: Integer = 0): Integer;
begin
  Result := cxTextOut(ACanvas, AText, R, AFormat, 0, 0, ACanvas.Font.Color, clBlack,
    AMaxLineCount, ALeftIndent, ARightIndent);
end;

function cxTextOut(AHandle: TCanvasHandle; AText: PcxCaptionChar; var R: TRect;
  AFormat: TcxTextOutFormat = CXTO_DEFAULT_FORMAT; AMaxLineCount: Integer = 0;
  ALeftIndent: Integer = 0; ARightIndent: Integer = 0): Integer;
begin
  Result := cxTextOut(AHandle, AText, R, AFormat, 0, 0, GetTextColor(AHandle), clBlack,
    AMaxLineCount, ALeftIndent, ARightIndent);
end;

initialization
  cxEndEllipsisCharsLength := Length(cxEndEllipsisChars);

end.
