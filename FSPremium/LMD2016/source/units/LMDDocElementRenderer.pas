unit LMDDocElementRenderer;
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

LMDDocElementRenderer unit (RS)
-----------------------------------
Renderers break out doc elements into areas (if an element doesn't fit into
the current page and is to flow over to next pages) and draws these doc element areas on page canvas.
Are used by the TLMDPageLayout manager.

Changes
-------
* Not released yet

###############################################################################}

interface

uses Classes,  Windows, Messages, Graphics, Forms,
     Controls, ExtCtrls, Contnrs,  ComCtrls, SysUtils, Dialogs,
     LMDTypes, LMDStrings, LMDPrinter,
     LMDDocModel, LMDPrintablePage, LMDPrintConst;

procedure LoadRTFLines(ADest: TRichEdit; ASrc: TLMDStrings);
procedure SaveRTFLines(ADest: TLMDStrings; ASrc: TRichEdit);

type

  TLMDPageAreasMatrix = array of array of TLMDPageArea;

  TLMDCustomDocElementRenderer = class(TPersistent)
  private
    FPageAreas: TLMDPageAreasMatrix;
    FPageCanvas: TCanvas;
    FStartPageIndex: integer;
    FPageWidth, FPageHeight: Integer;

    FMargins: TLMDMargins;
    procedure SetMargins(const Value: TLMDMargins);
  protected
    FDocElement: TLMDDocElement;

    procedure AssignFontToPrinterFont(ASourceFont, ATargetFont: TFont);
  public
    procedure FreePageAreas; virtual;
    constructor Create;
    destructor Destroy; override;
    procedure LayOut; virtual; abstract;
    procedure DrawArea(APoint: TPoint;
                       AVertIndex, AHorizIndex: integer);
                       virtual; abstract;

    property PageAreas: TLMDPageAreasMatrix read FPageAreas;
  published
    property StartPageIndex: integer read FStartPageIndex write FStartPageIndex;

    property PageWidth: Integer read FPageWidth write FPageWidth;
    property PageHeight: Integer read FPageHeight write FPageHeight;

    property PageCanvas: TCanvas read FPageCanvas write FPageCanvas;
    property DocElement: TLMDDocElement read FDocElement write FDocElement;
    property ContentMargins: TLMDMargins read FMargins write SetMargins;
  end;

  TLMDRtfChunk = record
    Start: Integer;
    Count: Integer;
    Height: Integer;
  end;
  TLMDRtfChunksArray = array of TLMDRtfChunk;

  TLMDCharTraits = class
    Ch: TLMDChar;
    PixelWidth: Integer;
    Next: TLMDCharTraits;
  end;

  TLMDCharWidthHash = class
  private
    FTraits: array[0..127] of TLMDCharTraits;

    function GetCharWidth(AChar: TLMDChar): integer;
    procedure SetCharWidth(AChar: TLMDChar; const Value: integer);
  public
    property CharWidth[AChar: TLMDChar]: integer read GetCharWidth write SetCharWidth;

    constructor Create;
    destructor Destroy; override;
  end;

  TLMDBaseTextRenderer = class (TLMDCustomDocElementRenderer)
  private
    FTabSize: Integer;
  protected
    function GetBlock: TLMDTextBlock;
    function GetAlign: TLMDTextAlignment;
    //convertion functions useful for RTF processing
    function PixelsToTwipsX(APixels: integer): integer;
    function PixelsToTwipsY(APixels: integer): integer;
    function TwipsToPixelsX(ATwips: integer): integer;
    function TwipsToPixelsY(ATwips: integer): integer;

    //plain text processing functions - implemented from scratch; sizes are in PIXELS
    function FormatStringsToArea(const AStr: TLMDString; ACanvas: TCanvas;
                                 AWidth, AHeight: integer;
                                 ASpacing: double;
                                 AEnforceExistingLineBreaks,
                                 ABreakAtAnyChar: boolean;
                                 out ALastPos: integer): TLMDStrings;

    function GetListOfFormattedStringBlocks(ACanvas: TCanvas;
                                            AWidth, AHeight, AFirstHeight: integer;
                                            ASpacing: double;
                                            AEnforceExistingLineBreaks,
                                            ABreakAtAnyChar: boolean):
                                            Contnrs.TObjectList;

    procedure DrawFormattedStrings(ACanvas: TCanvas; ARect: TRect);

    //RTF processing functions - implemented using Windows RTF support;
    //sizes are in PIXELS
    function GetListOfFormattedRTFChunksPositions(ACanvas: TCanvas;
                                                  AWidth, AHeight,
                                                  AFirstHeight: integer): TLMDRtfChunksArray;

    procedure DrawRTF(ACanvas: TCanvas; ARect: TRect);
  public
    constructor Create;

    //higher-level functions
    procedure DrawTextBlock(APoint: TPoint; ACanvas: TCanvas);
    //size is in PIXELS
    function GetTextBlockHeight(ACanvas: TCanvas; ATextBlock: TLMDTextBlock): integer;

    property TabSize: Integer read FTabSize write FTabSize;
  end;

  TLMDTextBlockRenderer = class(TLMDBaseTextRenderer)
  public
    procedure LayOut; override;

    procedure DrawArea(APoint: TPoint; AVertIndex, AHorizIndex: integer); override;
  end;

  TLMDTableRenderer = class(TLMDBaseTextRenderer)
  protected
    FTextBlocks: array of array of array of TLMDTextBlock;
    FTextRenderer: TLMDTextBlockRenderer;

    FCurRow: integer;
    FCurSubRow: integer;
    procedure DrawTableCell(AZeroPoint: TPoint;
                            ACanvas: TCanvas;
                            ACell: TLMDTableCell;
                            ATextBlock: TLMDTextBlock);
  public
    constructor Create;
    destructor Destroy; override;

    procedure LayOut; override;

    procedure DrawArea(APoint: TPoint;
                       AVertIndex, AHorizIndex: integer); override;
  end;

  TLMDDocImageRenderer = class(TLMDCustomDocElementRenderer)
  protected
    FBitmap: TBitmap;
    FBitmapCopied: boolean;
  public
    procedure FreePageAreas; override;
    procedure LayOut; override;
    procedure DrawArea(APoint: TPoint; AVertIndex, AHorizIndex: integer); override;
  end;

implementation

uses Math, RichEdit, LMDGraphUtils;

function  GetFontHeight(AFont: TFont; ACanvas: TCanvas): Integer;
var
  SaveFont: HFont;
  SysMetrics, Metrics: TTextMetric;
begin
  GetTextMetrics(ACanvas.Handle, SysMetrics);
  SaveFont := SelectObject(ACanvas.Handle, AFont.Handle);
  GetTextMetrics(ACanvas.Handle, Metrics);
  SelectObject(ACanvas.Handle, SaveFont);

  Result := Metrics.tmHeight + Metrics.tmExternalLeading;
end;

procedure TextOut(const AStr: TLMDString; X, Y: Integer; ACanvas: TCanvas);
var
    R: TRect;
begin
  R.Left := X;
  R.Top := Y;
  R.Right := X + LMDGetTextWidth(ACanvas, AStr);
  R.Bottom := Y + LMDGetTextHeight(ACanvas, AStr);

  LMDDrawText(ACanvas.Handle, AStr, Length(AStr), R,
               DT_LEFT or DT_TOP or DT_NOCLIP);
end;
{------------------------------------------------------------------------------}
procedure LoadRTFLines(ADest: TRichEdit;
                       ASrc: TLMDStrings);
var
    Strs: TStrings;
    Stream: TStream;
begin
  Strs := TStringList.Create;
  Stream := TMemoryStream.Create;
  try
    Strs.Text := ASrc.Text;
    Strs.SaveToStream(Stream);

    Stream.Position := 0;
    ADest.Lines.LoadFromStream(Stream);
  finally
    Stream.Free;
    Strs.Free;
  end;
end;

procedure SaveRTFLines(ADest: TLMDStrings;
                       ASrc: TRichEdit);
var
    Stream: TStream;
begin
  Stream := TMemoryStream.Create;
  try
    ASrc.Lines.SaveToStream(Stream);

    Stream.Position := 0;
    ADest.LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

{------------------------------------------------------------------------------}
constructor TLMDBaseTextRenderer.Create;
begin
  inherited;

  FTabSize := 8;
end;

procedure TLMDBaseTextRenderer.DrawFormattedStrings(ACanvas: TCanvas;
                                                    ARect: TRect);
var
  LWords: TLMDStrings;
  LTestString: TLMDString;
  LLeft, i, j, LSpaceWidth, LWidthDivisor: integer;
  Ly: integer;

  FontH: Integer;
  Align: TLMDTextAlignment;

  Line: TLMDCharArray;
  LineLn: Integer;

procedure ExpandLine;
begin
  Inc(LineLn);
  if LineLn > Length(Line) then
    SetLength(Line, LineLn*2);
end;

function GetOutStr(const AStr: TLMDString): TLMDString;
var
    i, j, Cnt: Integer;
begin

  if Align<>laLeft then
    Result := AStr
  else
  begin
    LineLn := 0;

    j := 0;
    for i := 1 to Length(AStr) do
    begin
      if AStr[i]<>LMDTab then
      begin
        ExpandLine;

        Line[j] := AStr[i];
        Inc(j);
      end
      else
      begin
        Cnt := (FTabSize * ((j div FTabSize)+1)) - j;
        while Cnt>0 do
        begin
          ExpandLine;
          Line[j] := LMDSpace;
          Inc(j);
          Dec(Cnt);
        end;
      end;
    end;

    Result := LMDCharArrayToString(Line, 0, LineLn);
  end;
end;

var
    S: TLMDString;
    Strings: TLMDStrings;
begin
  Align := GetAlign;

  FontH := GetFontHeight(ACanvas.Font, ACanvas);

  LWords := TLMDMemoryStrings.Create;
  Strings := GetBlock.Strings;

  try
    for i := 0 to Strings.Count - 1 do
    begin
      begin
        Ly := ARect.Top + i * FontH;
        if Align <> laWidth then
          begin
            if Align = laRight then
              LLeft := ARect.Right - LMDGetTextWidth(ACanvas, Strings.Strings[i])
            else if Align = laCenter then
              LLeft := ARect.Left + (ARect.Right - ARect.Left -
                                     LMDGetTextWidth(ACanvas, Strings.Strings[i])) div 2
            else
              LLeft := ARect.Left;

            S := GetOutStr(Strings.Strings[i]);
            TextOut(S, LLeft, Ly, ACanvas);
          end
        else
          begin
            //for the 'width' alignment we compute the average space between words...
            LWords.Clear;

            LMDParseToStrList(Strings.Strings[i], ' ', LWords);

            LTestString := '';
            for j := 0 to LWords.Count - 1 do
              LTestString := LTestString + Trim(LWords.Strings[j]);
            if LWords.Count > 1 then
              LWidthDivisor := (LWords.Count - 1)
            else
              LWidthDivisor := 1;

            LSpaceWidth := (ARect.Right - ARect.Left -
                            LMDGetTextWidth(ACanvas, LTestString)) div LWidthDivisor;

            //...and then output the text word by word with computed spaces
            LLeft := ARect.Left;
            for j := 0 to LWords.Count - 1 do
            begin
              TextOut(LWords.Strings[j], LLeft, Ly, ACanvas);

              LLeft := LLeft +
                       LMDGetTextWidth(ACanvas, LWords.Strings[j]) +
                       LSpaceWidth;
            end;
          end;
      end;
    end;
  finally
    LWords.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseTextRenderer.FormatStringsToArea(const AStr: TLMDString;
              ACanvas: TCanvas; AWidth, AHeight: integer;
              ASpacing: double;
              AEnforceExistingLineBreaks,
              ABreakAtAnyChar: boolean;
              out ALastPos: integer): TLMDStrings;
var
  Line: TLMDCharArray;
  LineLn: Integer;
  LineW: Integer;

  MaxLines: integer;
  SegStart, SegCount, SegNext: Integer;
  CharsHash: TLMDCharWidthHash;

  FontH: Integer;
  Align: TLMDTextAlignment;

function MoveToNextSeg: Boolean;
var
    LastSep: Integer;
    i: Integer;
    LineEnd: Boolean;
    Seps: TLMDString;
    LineEnds: TLMDString;
    Ch: TLMDChar;
    ChW: Integer;
    Cnt: Integer;
    Tabs: Integer;
    NextTab: Integer;
begin
  LastSep := -1;

  i := SegNext;
  LineEnd := false;
  Seps := LMDTab + ',.=-;+' + LMDSpace;
  LineEnds := LMDCR;
  LineEnds := LineEnds + LMDLF;
  LineEnds := LineEnds + LMDFF;

  while (i<=Length(AStr)) and (not LineEnd) do
  begin
    Ch := AStr[i];

    if LineW < AWidth then
    begin
      LineEnd := LMDPosEx(Ch, LineEnds, 1)<>0;
      if not LineEnd then
      begin
        if ABreakAtAnyChar or (LMDPosEx(Ch, Seps, 1)<>0) then
          LastSep := i;

        ChW := CharsHash.GetCharWidth(Ch);
        if ChW=-1 then
        begin
          ChW := ACanvas.TextWidth(Ch);
          CharsHash.SetCharWidth(Ch, ChW);
        end;

        if (Ch<>LMDTab) or (Align<>laLeft) then
          Inc(LineW, ChW)
        else
        begin
          Cnt := i - SegNext;
          Tabs := Cnt div FTabSize;

          NextTab := (Tabs+1) * FTabSize;
          Inc(LineW, (NextTab-Cnt)*CharsHash.GetCharWidth(LMDSpace));
        end;

        Inc(i);
      end;
    end
    else
    begin
      if LastSep<>-1 then
        i := LastSep;

      Break;
    end;
  end;

  SegStart := SegNext;
  SegCount := i - SegStart;

  if LineEnd then
  begin
    if AStr[i]=LMDCr then
    begin
      Inc(i);

      if (i<=Length(AStr)) and (AStr[i]=LMDLF) then
        Inc(i);
    end
    else
      Inc(i);
  end
  else if LineW > AWidth then
  begin
    while (i<=Length(AStr)) and (AStr[i]=LMDSpace) do
      Inc(i);
  end;

  SegNext := i;

  Result := (i<=Length(AStr)) and
            (LineW < AWidth) and
            (not (LineEnd and AEnforceExistingLineBreaks));
end;

procedure AddSeg;
var
    i: Integer;
begin
  if Length(Line) < (LineLn+SegCount) then
    SetLength(Line, (LineLn+SegCount)*2);

  for i := SegStart to SegStart+SegCount - 1 do
    Line[i - SegStart] := AStr[i];

  Inc(LineLn, SegCount);
end;

var
    Ok: Boolean;
begin
  FontH := GetFontHeight(ACanvas.Font, ACanvas);

  Result := TLMDMemoryStrings.Create;
  if FontH > AHeight then
    MaxLines := 0
  else
    MaxLines := Round((AHeight - FontH) / (FontH * (1 + ASpacing)));

  CharsHash := TLMDCharWidthHash.Create;
  try
    CharsHash.SetCharWidth(LMDSpace, LMDGetTextWidth(ACanvas, LMDSpace));
    SetLength(Line, 0);

    SegStart := 1;
    SegNext := 1;
    SegCount := 0;
    LineLn := 0;
    LineW := 0;

    while (SegStart+SegCount <= Length(AStr)) and
          (Result.Count < MaxLines)
    do
    begin
      repeat
        Ok := MoveToNextSeg;
        AddSeg;
      until not Ok;

      Result.Add(LMDCharArrayToString(Line, 0, LineLn));
      LineLn := 0;
      LineW := 0;
    end;
  finally
     CharsHash.Free;
  end;

  ALastPos := SegNext;
end;

{------------------------------------------------------------------------------}
function TLMDBaseTextRenderer.GetListOfFormattedStringBlocks(
  ACanvas: TCanvas; AWidth, AHeight, AFirstHeight: integer;
  ASpacing: double; AEnforceExistingLineBreaks,
  ABreakAtAnyChar: boolean): Contnrs.TObjectList;
var
  LCurStringList: TLMDStrings;

  LCurBlockNum, LCurHeight, LCurPos: integer;
  Str: TLMDString;
begin
  Result := Contnrs.TObjectList.Create;

  Str := GetBlock.Strings.Text;

  LCurBlockNum := 0;
  while Length(Str) > 0 do
  begin
    if LCurBlockNum = 0 then
      LCurHeight := AFirstHeight
    else
      LCurHeight := AHeight;

    LCurStringList := Self.FormatStringsToArea(Str, ACanvas, AWidth,
                                               LCurHeight, ASpacing,
                                               AEnforceExistingLineBreaks,
                                               ABreakAtAnyChar, LCurPos);
    Result.Add(LCurStringList);

    Str := Copy(Str, LCurPos, Length(Str)-LCurPos+1);

    Inc(LCurBlockNum);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseTextRenderer.DrawTextBlock(APoint: TPoint;
                                             ACanvas: TCanvas);
var
    R: TRect;
    Block: TLMDTextBlock;
begin
  Block := FDocElement as TLMDTextBlock;

  Self.AssignFontToPrinterFont(Block.TextFormat.Font, ACanvas.Font);

  R.Left := APoint.X + Block.Left;
  R.Top := APoint.Y + Block.Top;
  R.Right := R.Left + Block.Width;
  R.Bottom := R.Top + Block.Height;

  if Block.IsRTF then
    Self.DrawRTF(ACanvas, R)
  else
    Self.DrawFormattedStrings(ACanvas, R);
end;

function TLMDBaseTextRenderer.GetTextBlockHeight(ACanvas: TCanvas;
                                                 ATextBlock: TLMDTextBlock): integer;
var
    FontH: Integer;
begin
  FontH := GetFontHeight(ACanvas.Font, ACanvas);

  Result := ATextBlock.Strings.Count * FontH;
end;

{------------------------------------------------------------------------------}
function TLMDBaseTextRenderer.GetAlign: TLMDTextAlignment;
begin
  Result := GetBlock.TextFormat.Align;
end;

function TLMDBaseTextRenderer.GetBlock: TLMDTextBlock;
begin
  Result := FDocElement as TLMDTextBlock;
end;

function TLMDBaseTextRenderer.GetListOfFormattedRTFChunksPositions(
        ACanvas: TCanvas;
        AWidth, AHeight, AFirstHeight: integer): TLMDRtfChunksArray;
var
  LRange: TFormatRange;
  LCurPos, LNewPos, LCurBlock: integer;
  LRichEdit: TRichEdit;
  LForm: TForm;
begin
  LForm := TForm.Create(nil);
  LRichEdit := TRichEdit.Create(LForm);
  LRichEdit.Parent := LForm;

  LoadRTFLines(LRichEdit, GetBlock.Strings);

  LCurPos := 0;
  LCurBlock := 0;

  SendMessage(LRichEdit.Handle, EM_FORMATRANGE, 0, 0); { flush buffer }

  LRange.rc.Left := 0;
  LRange.rc.Top := 0;
  LRange.rc.Right := PixelsToTwipsX(AWidth);
  LRange.chrg.cpMax := -1;
  LRange.hdc := ACanvas.Handle;
  LRange.hdcTarget := ACanvas.Handle;

  try
    while LCurPos < LRichEdit.GetTextLen do
    begin
      if LCurBlock = 0 then
        LRange.rc.Bottom := PixelsToTwipsY(AFirstHeight)
      else
        LRange.rc.Bottom := PixelsToTwipsY(AHeight);

      LRange.rcPage := LRange.rc;
      Lrange.chrg.cpMin := LCurPos;

      LNewPos := SendMessage(LRichEdit.Handle, EM_FORMATRANGE,
                             0, LPARAM(@LRange));
      if LNewPos > Lrange.chrg.cpMin then
      begin
        SetLength(Result, LCurBlock + 1);

        Result[LCurBlock].Start := LCurPos;
        Result[LCurBlock].Count := LNewPos - LCurPos;
        Result[LCurBlock].Height := TwipsToPixelsY(LRange.rc.Bottom -
                                                   LRange.rc.Top);

        LCurPos := LNewPos;
        Inc(LCurBlock);
      end
      else
        LCurPos := LRichEdit.GetTextLen;
    end;
  finally
    SendMessage(LRichEdit.Handle, EM_FORMATRANGE, 0, 0); { flush buffer }

    LForm.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseTextRenderer.DrawRTF(ACanvas: TCanvas; ARect: TRect);
var
  LRange: TFormatRange;
  LRichEdit: TRichEdit;
  LForm: TForm;
  LLeft, LTop, LRight, LBottom: integer;
  Block: TLMDTextBlock;
begin
  Block := GetBlock;

  LForm := TForm.Create(nil);
  LRichEdit := TRichEdit.Create(LForm);
  LRichEdit.Parent := LForm;

  LoadRTFLines(LRichEdit, Block.Strings);

  SendMessage(LRichEdit.Handle, EM_FORMATRANGE, 0, 0); { flush buffer }

  LLeft := PixelsToTwipsX(ARect.Left);
  LTop := PixelsToTwipsY(ARect.Top);
  LRight := PixelsToTwipsX(ARect.Right);
  LBottom := PixelsToTwipsY(ARect.Bottom);
  LRange.rc := Rect(LLeft, LTop, LRight, LBottom);
  LRange.rcPage := Rect(0, 0, LRight, LBottom);

  LRange.hdc := ACanvas.Handle;
  LRange.hdcTarget := ACanvas.Handle;
  LRange.chrg.cpMin := Block.StartPos;
  LRange.chrg.cpMax := Block.EndPos;

  try
      SendMessage(LRichEdit.Handle, EM_FORMATRANGE, 1, LPARAM(@LRange));
      finally
    SendMessage(LRichEdit.Handle, EM_FORMATRANGE, 0, 0); { flush buffer }

    LForm.Free;
  end;
end;

{ TLMDTableRenderer }
{------------------------------------------------------------------------------}
constructor TLMDTableRenderer.Create;
begin
  inherited;

  FTextRenderer := TLMDTextBlockRenderer.Create;
end;

destructor TLMDTableRenderer.Destroy;
begin
  FTextRenderer.Free;

  inherited;
end;

procedure TLMDTableRenderer.DrawArea(APoint: TPoint;
                                     AVertIndex, AHorizIndex: Integer);
var
  i: integer;
  Area: TLMDPageArea;
begin
  if (AVertIndex < Length(FPageAreas)) and (AHorizIndex = 0) then
  begin
    Area := FPageAreas[AVertIndex][AHorizIndex];

    for i := 0 to Area.DocElementsCount - 1 do
      DrawTableCell(APoint, FPageCanvas,
                    Area.DocElements[i].Tag as TLMDTableCell,
                    Area.DocElements[i] as TLMDTextBlock);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTableRenderer.DrawTableCell(AZeroPoint: TPoint;
                                          ACanvas: TCanvas;
                                          ACell: TLMDTableCell;
                                          ATextBlock: TLMDTextBlock);
var
  CellFmt: TLMDTableCellFormat;
  Cell: TLMDTableCell;
  MaxHeightInSubRow: Integer;
  LeftX, TopY, RightX, BottomY: integer;
  i, j, k, H: integer;
  found: boolean;
  Block: TLMDTextBlock;
begin
  if ACell.HasSpecialFormat then
    CellFmt := ACell.CellFormat
  else
    CellFmt := (FDocElement as TLMDDocTable).DefaultCellFormat;

  //drawing cell contents
  if ATextBlock.Strings.Count<>0 then
  begin
    FTextRenderer.DocElement := ATextBlock;
    FTextRenderer.TabSize := CellFmt.TextFormat.TabSize;
    FTextRenderer.ContentMargins := ContentMargins;

    FTextRenderer.DrawTextBlock(AZeroPoint, ACanvas);
  end;

  //we need to find the maximal cell height in the subrow, to which the given cell belongs
  i := 0; k := 0; found := false;
  while (not found) and (i < Length(FTextBlocks)) do
  begin
    j := 0;
    while (not found) and (j < Length(FTextBlocks[i])) do
    begin
      k := 0;
      while (not found) and (k < Length(FTextBlocks[i][j])) do
      begin
        found := FTextBlocks[i][j][k] = ATextBlock;
        if not found then
          Inc(k);
      end;
      if not found then
        Inc(j);
    end;
    if not found then
      Inc(i);
  end;

  MaxHeightInSubRow := 0;

  for j := 0 to Length(FTextBlocks[i]) - 1 do
  begin
    Block := FTextBlocks[i][j][k];

    Cell := Block.Tag as TLMDTableCell;

    if Cell.HasSpecialFormat then
      CellFmt := Cell.CellFormat
    else
      CellFmt := (FDocElement as TLMDDocTable).DefaultCellFormat;

    H := FTextBlocks[i][j][k].Height;

    if H > MaxHeightInSubRow then
      MaxHeightInSubRow := H;
  end;

  //computing cell rectangle coordinates
  LeftX := AZeroPoint.X + ATextBlock.Left - CellFmt.Margins.Left;
  TopY := AZeroPoint.Y + ATextBlock.Top - CellFmt.Margins.Top;

  RightX := LeftX + ATextBlock.Width +
             CellFmt.Margins.Left + CellFmt.Margins.Right;

  BottomY := AZeroPoint.Y + ATextBlock.Top + MaxHeightInSubRow +
             CellFmt.Margins.Bottom;

  //drawing cell borders
  ACanvas.Pen := CellFmt.TopBorderPen;
  ACanvas.MoveTo(LeftX, TopY);
  ACanvas.LineTo(RightX, TopY);

  ACanvas.Pen := CellFmt.RightBorderPen;
  ACanvas.LineTo(RightX, BottomY);

  ACanvas.Pen := CellFmt.BottomBorderPen;
  ACanvas.LineTo(LeftX, BottomY);

  ACanvas.Pen := CellFmt.LeftBorderPen;
  ACanvas.LineTo(LeftX, TopY);
end;

procedure TLMDTableRenderer.LayOut;
var
  i, j, k, Ln: integer;
  CurPage, MaxBlocks: integer;
  CurY, MaxRowY, YTmp: Integer;
  CellFmt: TLMDTableCellFormat;
  Block: TLMDTextBlock;
  RendBlock: TLMDTextBlock;
  Rend: TLMDTextBlockRenderer;
  Area: TLMDPageArea;
  Table: TLMDDocTable;

  Margins: TRect;
  MaxMrW, MaxMrH: Integer;
begin
  FreePageAreas;

  //The table is printed row by row. Each row (depending on the amount of text in its cells)
  //can occupy (the rest of) the space on the current (first) page and, potentially, several subsequent pages
  //(the last page in the range can be occupied partially).
  //The code piece in each row cell is split into blocks using TLMDCustomPrintTask.GetListOfFormattedStringBlocks.
  //The width of such a block is the width of the respective table column (is it assumed to be given),
  //the max height is the height of the page print area.
  //The 'height' of the row (number of pages/page parts occupied by it) is determined by the max number of such blocks for a cell.
  //These blocks (TLMDTextBlock objects) are stored in the 3-d array with the following indixes: <row>, <column>, <sub-row ('paged' row part)>.
  //These blocks are then sequentially printed by the DoPrintPage method which selects blocks for the current page.
  FCurRow := 0;
  FCurSubRow := 0;
  Table := FDocElement as TLMDDocTable;
  Table.Width := FPageWidth;
  Table.Height := FPageHeight;

  //table adjustment
  Table.PrepareForPrinting(FPageCanvas, FMargins);

  //preparing the text blocks buffer - setting it size to <row count> x <col count> x 1 (assuming 1 sub row for each row so far)
  SetLength(FTextBlocks, Table.RowCount);
  for i := 0 to Length(FTextBlocks) - 1 do
  begin
    SetLength(FTextBlocks[i], Table.ColCount);
    for j := 0 to Length(FTextBlocks[i]) - 1 do
    begin
      SetLength(FTextBlocks[i][j], 1);
      FTextBlocks[i][j][0] := nil;
    end;
  end;

  //setting up the TextBlock renderer which will be used to lay out text blocks corresponding to table cells
  Rend := TLMDTextBlockRenderer.Create;
  RendBlock := TLMDTextBlock.Create;

  try
    Rend.ContentMargins := FMargins;
    Rend.PageCanvas := FPageCanvas;

    //Main layout task - creating the text blocks
    CurY := Table.Top;
    CurPage := 0;
    for i := 0 to Table.RowCount - 1 do
    begin
      MaxRowY := 0;
      MaxBlocks := 0;
      for j := 0 to Table.ColCount - 1 do
      begin
        if Table.Cell[i, j].HasSpecialFormat then
          CellFmt := Table.Cell[i, j].CellFormat
        else
          CellFmt := Table.DefaultCellFormat;

        //creating a text block for the given table cell
        RendBlock.Strings := Table.Cell[i, j].Strings;
        RendBlock.TextFormat := CellFmt.TextFormat;
        RendBlock.IsRTF := CellFmt.IsRTF;

        Rend.PageWidth := Table.Columns[j].Width;
        Rend.PageHeight := FPageHeight;
        Rend.TabSize := CellFmt.TextFormat.TabSize;

        Margins := Rect(CellFmt.Margins.Left,
                        CellFmt.Margins.Top,
                        CellFmt.Margins.Right,
                        CellFmt.Margins.Bottom);

        MaxMrW := Rend.PageWidth div 3 + 1;
        MaxMrH := (Rend.PageHeight - CurY) div 3 + 1;

        Margins.Left := Max(0, Min(Margins.Left, MaxMrW));
        Margins.Right := Max(0, Min(Margins.Right, MaxMrW));
        Margins.Top := Max(0, Min(Margins.Top, MaxMrH));
        Margins.Bottom := Max(0, Min(Margins.Bottom, MaxMrH));

        RendBlock.Top := CurY;
        RendBlock.Left := Table.GetHorizontalCellOffset(i, j) + Margins.Left;
        RendBlock.Width := Rend.PageWidth - Margins.Left - Margins.Right;

        //laying this text block out onto pages using TLMDTextBlockRenderer
        Rend.DocElement := RendBlock;
        with Rend.ContentMargins do
        begin
          Top := Margins.Top;
          Bottom := Margins.Bottom;
          Left := 0;
          Right := 0;
        end;
        Rend.LayOut;

        //Populating the cells text blocks array with blocks
        //generated by TextBlockRenderer for the given cell
        SetLength(FTextBlocks[i][j], Length(Rend.PageAreas));
        for k := 0 to Length(FTextBlocks[i][j]) - 1 do
        begin
          Area := Rend.PageAreas[k][0];

          Block := Area.DocElements[0] as TLMDTextBlock;
          Block.PageNum := CurPage + k;

          FTextBlocks[i][j][k] := Block;

          Area.DetachElements;
        end;

        if Length(FTextBlocks[i][j]) >= MaxBlocks then
        begin
          Ln := Length(FTextBlocks[i][j]);
          Block := FTextBlocks[i][j][Ln - 1];

          YTmp := Block.Height;
          //calculating the current Y pos (end of current row and start of the next row)
          //on the current page:
          //if the current number of blocks (and therefore the page number) is maximal
          //(this page was not 'reached' by provious cells),
          //then Y pos is equal to the current block height;
          //if this page already was reached, Y pos is set to the current block height
          //only if it is greater then current Y pos value
          if ((Ln = MaxBlocks) and (YTmp > MaxRowY)) or (Ln > MaxBlocks) then
            MaxRowY := YTmp;

          MaxBlocks := Ln;
        end;
      end;

      if MaxBlocks > 1 then
        CurY := MaxRowY + Margins.Bottom + Margins.Top
      else
        CurY := CurY + MaxRowY + Margins.Bottom + Margins.Top;

      CurPage := CurPage + MaxBlocks - 1;
    end;
    //grouping obtained cell text blocks into page areas
    //(group by page numbers of text blocks)
    SetLength(FPageAreas, CurPage + 1);
    for i := 0 to CurPage do
    begin
      SetLength(FPageAreas[i], 1);
      FPageAreas[i][0] := TLMDPageArea.Create;
    end;

    for i := 0 to Length(FTextBlocks) - 1 do
    begin
      for j := 0 to Length(FTextBlocks[i]) - 1 do
      begin
        for k := 0 to Length(FTextBlocks[i][j]) - 1 do
        begin
          Block := FTextBlocks[i][j][k];
          Block.Tag := Table.Cell[i, j];

          Area := FPageAreas[Block.PageNum][0];

          Area.AddDocElement(Block);
        end;
      end;
    end;

  finally
    RendBlock.Free;
    Rend.DocElement := nil;
    Rend.Free;
  end;
end;

{ TLMDTextBlockRenderer }
{------------------------------------------------------------------------------}
procedure TLMDTextBlockRenderer.DrawArea(APoint: TPoint;
                                         AVertIndex,
                                         AHorizIndex: integer);
begin
  if (AVertIndex < Length(Self.PageAreas)) and (AHorizIndex = 0) then
  begin
    FDocElement := Self.PageAreas[AVertIndex][0].DocElements[0];
    Self.DrawTextBlock(APoint, Self.PageCanvas);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTextBlockRenderer.LayOut;
var
  i: integer;
  LFormattedBlocks: Contnrs.TObjectList;
  LPositions: TLMDRtfChunksArray;
  LBlocksCount: integer;
  WholeBlock, Block: TLMDTextBlock;
  Area: TLMDPageArea;
begin

  SetLength(LPositions, 0);

  LFormattedBlocks := nil;
  WholeBlock := FDocElement as TLMDTextBlock;

  Self.TabSize := WholeBlock.TextFormat.TabSize;
  Self.AssignFontToPrinterFont(WholeBlock.TextFormat.Font, Self.PageCanvas.Font);

  if WholeBlock.IsRTF then
  begin
    LPositions := Self.GetListOfFormattedRTFChunksPositions(
                      Self.PageCanvas,
                      WholeBlock.Width,

                      Self.PageHeight -
                      Self.ContentMargins.Top -
                      Self.ContentMargins.Bottom,

                      Self.PageHeight -
                      WholeBlock.Top -
                      Self.ContentMargins.Top -
                      Self.ContentMargins.Bottom);

    LBlocksCount := Length(LPositions);

    if LBlocksCount=0 then
    begin
      SetLength(LPositions, 1);
      LPositions[0].Start := 0;
      LPositions[0].Count := 0;
      LPositions[0].Height := 0;

      LBlocksCount := 1;
    end;
  end
  else
  begin
    LFormattedBlocks := Self.GetListOfFormattedStringBlocks(
                            Self.PageCanvas,
                            WholeBlock.Width,

                            Self.PageHeight -
                            Self.ContentMargins.Top -
                            Self.ContentMargins.Bottom,

                            Self.PageHeight -
                            WholeBlock.Top -
                            Self.ContentMargins.Top -
                            Self.ContentMargins.Bottom,

                            0,
                            not WholeBlock.TextFormat.ReflowText,
                            false);

    LBlocksCount := LFormattedBlocks.Count;

    if LBlocksCount=0 then
    begin
      LFormattedBlocks.Add(TLMDMemoryStrings.Create);
      LBlocksCount := 1;
    end;
  end;

  Self.FreePageAreas;
  SetLength(Self.FPageAreas, LBlocksCount);

  for i := 0 to LBlocksCount - 1 do
  begin
    //creating a (partial) text block
    //(a part of the source text block which fits the page)

    Block := TLMDTextBlock.Create;
    Block.IsRTF := WholeBlock.IsRTF;
    if WholeBlock.IsRTF then
    begin
      Block.Strings := WholeBlock.Strings;

      Block.StartPos := LPositions[i].Start;
      Block.EndPos := Block.StartPos + LPositions[i].Count;

      Block.Height := LPositions[i].Height;
    end
    else
    begin
      Block.Strings := LFormattedBlocks[i] as TLMDStrings;
      Block.Height := Self.GetTextBlockHeight(Self.PageCanvas, Block);
    end;

    Block.TextFormat := WholeBlock.TextFormat;

    if i = 0 then
      Block.Top := WholeBlock.Top + Self.ContentMargins.Top
    else
      Block.Top := Self.ContentMargins.Top;

    Block.Left := WholeBlock.Left;
    Block.Width := WholeBlock.Width;

    Block.PageNum := WholeBlock.PageNum + i;

    //defining the page area for this partial text block
    Area := TLMDPageArea.Create;
    Area.HorizPartIndex := 0;
    Area.VertPartIndex := i;
    Area.AddDocElement(Block);
    Area.Area := Rect(Block.Left, Block.Top,
                      Block.Left + Block.Width,
                      Block.Top + Block.Height);

    SetLength(Self.PageAreas[i], 1);
    Self.PageAreas[i][0] := Area;
  end;

  LFormattedBlocks.Free;
end;

{ TLMDCustomDocElementRenderer }
{------------------------------------------------------------------------------}
procedure TLMDCustomDocElementRenderer.AssignFontToPrinterFont(ASourceFont,
                                                               ATargetFont: TFont);
begin
  ATargetFont.Assign(ASourceFont);
end;

{------------------------------------------------------------------------------}
constructor TLMDCustomDocElementRenderer.Create;
begin
  inherited;

  Self.FMargins := TLMDMargins.Create;
end;

destructor TLMDCustomDocElementRenderer.Destroy;
begin
  FreePageAreas;
  FMargins.Free;

  inherited;
 end;

procedure TLMDCustomDocElementRenderer.FreePageAreas;
var
  i, j: integer;
begin
  for i := 0 to Length(Self.PageAreas) - 1 do
  begin
    for j := 0 to Length(Self.PageAreas[i]) - 1 do
      Self.PageAreas[i][j].Free;

    SetLength(Self.PageAreas[i], 0);
  end;

  SetLength(Self.FPageAreas, 0);
end;

procedure TLMDCustomDocElementRenderer.SetMargins(
  const Value: TLMDMargins);
begin
  FMargins.Assign(Value);
end;

{ TLMDCharWidthHash }

constructor TLMDCharWidthHash.Create;
var
  i: integer;
begin
  inherited;

  for i := 0 to 127 do
    FTraits[i] := nil;
end;

destructor TLMDCharWidthHash.Destroy;
var
    i: Integer;
    tr, tmp: TLMDCharTraits;
begin
  for i := 0 to Length(FTraits) - 1 do
  begin
    tr := FTraits[i];

    while tr<>nil do
    begin
      tmp := tr;
      tr := tr.Next;

      tmp.Free;
    end;
  end;

  inherited;
end;

function TLMDCharWidthHash.GetCharWidth(AChar: TLMDChar): integer;
var
  Traits: TLMDCharTraits;
begin
  Result := -1;
  Traits := FTraits[ord(AChar) mod 128];

  while (Traits <> nil) and (Traits.Ch <> AChar) do
    Traits := Traits.Next;

  if Traits <> nil then
    Result := Traits.PixelWidth;
end;

procedure TLMDCharWidthHash.SetCharWidth(AChar: TLMDChar;
  const Value: integer);
var
  CurTr, NewTr: TLMDCharTraits;
begin
  CurTr := FTraits[ord(AChar) mod 128];

  NewTr := TLMDCharTraits.Create;
  NewTr.Ch := AChar;
  NewTr.PixelWidth := Value;
  NewTr.Next := nil;

  if CurTr=nil then
    FTraits[ord(AChar) mod 128] := NewTr
  else
  begin
    while CurTr.Next<>nil do
      CurTr := CurTr.Next;

    CurTr.Next := NewTr;
  end;

end;

function TLMDBaseTextRenderer.PixelsToTwipsX(APixels: integer): integer;
var
    PpiX: Integer;
begin
  Assert(FPageCanvas<>nil);
  Assert(FPageCanvas.Handle<>0);

  PpiX := GetDeviceCaps(FPageCanvas.Handle, LOGPIXELSX);
  Result := (APixels * 1440) div PpiX;
end;

function TLMDBaseTextRenderer.PixelsToTwipsY(APixels: integer): integer;
var
    PpiY: Integer;
begin
  Assert(FPageCanvas<>nil);
  Assert(FPageCanvas.Handle<>0);

  PpiY := GetDeviceCaps(FPageCanvas.Handle, LOGPIXELSY);
  Result := (APixels * 1440) div PpiY;
end;

function TLMDBaseTextRenderer.TwipsToPixelsX(ATwips: integer): integer;
var
    PpiX: Integer;
begin
  Assert(FPageCanvas<>nil);
  Assert(FPageCanvas.Handle<>0);

  PpiX := GetDeviceCaps(FPageCanvas.Handle, LOGPIXELSX);
  Result := (ATwips * PpiX) div 1440;
end;

function TLMDBaseTextRenderer.TwipsToPixelsY(ATwips: integer): integer;
var
    PpiY: Integer;
begin
  Assert(FPageCanvas<>nil);
  Assert(FPageCanvas.Handle<>0);

  PpiY := GetDeviceCaps(FPageCanvas.Handle, LOGPIXELSY);
  Result := (ATwips * PpiY) div 1440;
end;

{ TLMDDocImageRenderer }

procedure TLMDDocImageRenderer.DrawArea(APoint: TPoint; AVertIndex,
  AHorizIndex: integer);
var
  LPageArea: TLMDPageArea;
  LDocImage: TLMDDocImage;
begin
  if (AVertIndex < Length(Self.PageAreas)) and (AHorizIndex < Length(Self.PageAreas[AVertIndex])) then
  begin
    LPageArea := Self.PageAreas[AVertIndex][AHorizIndex];
    if LPageArea.DocElementsCount > 0 then
    begin
      LDocImage := LPageArea.DocElements[0] as TLMDDocImage;

      Self.PageCanvas.Draw(APoint.X, APoint.Y, LDocImage.Picture);
    end;
  end;
end;

procedure TLMDDocImageRenderer.FreePageAreas;
begin
  if Self.FBitmapCopied and Assigned(Self.FBitmap) then
    Self.FBitmap.Free;
  inherited;
end;

procedure TLMDDocImageRenderer.LayOut;
var
  i, j, LAreasX, LAreasY, LActivePageWidth, LActivePageHeight, LCurWidth, LCurHeight: integer;
  LWholeDocImage, LDocImage: TLMDDocImage;
  LPageArea: TLMDPageArea;
  LSourceRect, LDestRect: TRect;
begin
  LWholeDocImage := Self.DocElement as TLMDDocImage;
  if not Assigned(LWholeDocImage) then
    raise ELMDPrintPackError.Create(SLMDPrintRendererWrongType);

  if (LWholeDocImage.Width <> LWholeDocImage.Picture.Width) or
     (LWholeDocImage.Height <> LWholeDocImage.Picture.Height)
  then
  begin
    FBitmap := TBitmap.Create;
    FBitmap.PixelFormat := LWholeDocImage.Picture.PixelFormat;
    FBitmap.Width := LWholeDocImage.Width;
    FBitmap.Height := LWholeDocImage.Height;
    FBitmap.Canvas.StretchDraw(Rect(0, 0, FBitmap.Width, FBitmap.Height), LWholeDocImage.Picture);
    Self.FBitmapCopied := true;
  end
  else
  begin
    FBitmap := LWholeDocImage.Picture;
    Self.FBitmapCopied := false;
  end;

  LActivePageWidth := Self.PageWidth - Self.ContentMargins.Left - Self.ContentMargins.Right;
  LActivePageHeight := Self.PageHeight - Self.ContentMargins.Top - Self.ContentMargins.Bottom;

  LAreasX := (LWholeDocImage.Width + LWholeDocImage.Left) div LActivePageWidth;
  if LActivePageWidth * LAreasX < LWholeDocImage.Width + LWholeDocImage.Left then
    Inc(LAreasX);

  LAreasY := (LWholeDocImage.Height + LWholeDocImage.Top) div LActivePageHeight;
  if LActivePageHeight * LAreasY < LWholeDocImage.Height + LWholeDocImage.Top then
    Inc(LAreasY);

  SetLength(Self.FPageAreas, LAreasY);
  for j := 0 to LAreasY - 1 do
  begin
    SetLength(Self.FPageAreas[j], LAreasX);
    for i := 0 to LAreasX - 1 do
    begin
      LSourceRect.Left := LActivePageWidth * i;
      if i > 0 then
        LSourceRect.Left := LSourceRect.Left - LWholeDocImage.Left;

      LSourceRect.Top := LActivePageHeight * j;
      if j > 0 then
        LSourceRect.Top := LSourceRect.Top - LWholeDocImage.Top;

      if i = LAreasX - 1 then
        LCurWidth := LWholeDocImage.Width - LSourceRect.Left
      else
        LCurWidth := LActivePageWidth;
      if i = 0 then
        LCurWidth := LCurWidth - LWholeDocImage.Left;

      if j = LAreasY - 1 then
        LCurHeight := LWholeDocImage.Height - LSourceRect.Top
      else
        LCurHeight := LActivePageHeight;
       if j = 0 then
        LCurHeight := LCurHeight - LWholeDocImage.Top;

      LSourceRect.Right := LSourceRect.Left + LCurWidth;
      LSourceRect.Bottom := LSourceRect.Top + LCurHeight;

      LDestRect := Rect(0, 0, LCurWidth, LCurHeight);

      LDocImage := TLMDDocImage.Create;
      LDocImage.PictureRect := LSourceRect;
      if i = 0 then
        LDocImage.Left := LWholeDocImage.Left
      else
        LDocImage.Left := 0;
      if j = 0 then
        LDocImage.Top := LWholeDocImage.Top
      else
        LDocImage.Top := 0;
      LDocImage.Width := LDestRect.Right;
      LDocImage.Height := LDestRect.Bottom;
      //LDocImage.Picture.Canvas.CopyRect(LDestRect, FBitmap.Canvas, LSourceRect);
      LDocImage.Picture := FBitmap;
      LDocImage.Picture.Width := LDocImage.Width;
      LDocImage.Picture.Height := LDocImage.Height;

      LPageArea := TLMDPageArea.Create;
      LPageArea.HorizPartIndex := i;
      LPageArea.VertPartIndex := j;
      LPageArea.AddDocElement(LDocImage);

      LPageArea.Area :=  Rect(LDocImage.Left, LDocImage.Top,
                            LDocImage.Left + LDocImage.Width,
                            LDocImage.Top + LDocImage.Height);
      Self.PageAreas[j][i] := LPageArea;
    end;
  end;
end;

end.
