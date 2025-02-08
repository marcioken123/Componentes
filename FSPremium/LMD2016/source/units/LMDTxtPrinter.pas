unit LMDTxtPrinter;
{$I lmdcmps.INC}

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

LMDTxtPrinter unit (JH)
-----------------------

Simple ASCII text printing component

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Graphics,
  Classes,
  LMDCustomComponent;

type
  TLMDGetColorEvent  = procedure (Sender : TObject; Row, PageRow : Integer; var Color : TColor) of object;
  TLMDGetRectEvent   = procedure (Sender : TObject; var getRect : TRect; printRect : TRect) of object;
  TLMDPrintRectEvent = procedure (Sender : TObject; aCanvas : TCanvas; page : Integer; var pRect : TRect) of object;
  TLMDPageStringEvent= procedure (Sender : TObject; var s : String; page : Integer) of object;
  TLMDGetIntegerEvent= procedure (Sender : Tobject; var aValue : Integer) of object;
  TLMDLineNumStringEvent= procedure (Sender : TObject; var s : String; line : Integer) of object;

  TLMDLineNumbers = (lnNone, lnPage, lnGlobal);
  TLMDPageNumbers = (pnNone, pnTopLeft, pnTopCenter, pnTopRight, pnBottomLeft, pnBottomCenter, pnBottomRight);

  TLMDTxtPrinter = class (TLMDCustomComponent)
  private
    FFont               : TFont;
    FBorder,
    FWordWrap,
    FCountWrappedLines,
    FLined              : Boolean;
    FLineStyle          : TPen;
    FLineNumbers        : TLMDLineNumbers;
    FPageNumbers        : TLMDPageNumbers;
    FPrintTitle         : String;
    FHeaderHeight,
    FFooterHeight,
    FSheetColumns,
    FSheetRows,
    FCopies             : Integer;

    FOnGetColor         : TLMDGetColorEvent;
    FOnGetPrintRect     : TLMDGetRectEvent;
    FOnPrintGFooter,
    FOnPrintGHeader,
    FOnPrintFooter,
    FOnPrintHeader      : TLMDPrintRectEvent;
    FOnGetPageString    : TLMDPageStringEvent;
    FOnGetLineNumString : TLMDLineNumStringEvent;
    FOnGetLNDigitSpace  : TLMDGetIntegerEvent;

    procedure SetFont (aValue : TFont);
    procedure SetLineStyle (aValue : TPen);
  protected
    procedure Print(const Text: string; iStart, iCount: integer);
    //    Source, SourceEnd : PChar);
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;

    procedure PrintFile (const Filename : String);
    procedure PrintText (const txt : String);
    property OnGetLineNumberString : TLMDLineNumStringEvent read FOnGetLineNumString write FOnGetLineNumString;
  published
    property About;
    property Border : Boolean read FBorder write FBorder default false;
    property Font : TFont read FFont write SetFont;
    property WordWrap : Boolean read FWordWrap write FWordWrap default true;
    property Lined : Boolean read FLined write FLined default false;
    property LineNumbers : TLMDLineNumbers read FLineNumbers write FLineNumbers default lnNone;
    property CountWrappedLines : Boolean read FCountWrappedLines write FCountWrappedLines default false;
    property PageNumbers : TLMDPageNumbers read FPageNumbers write FPageNumbers default pnNone;
    property LineStyle : TPen read FLineStyle write SetLineStyle;
    property Title : String read FPrintTitle write FPrintTitle;
    property Copies : Integer read FCopies write FCopies default 1;
    property HeaderHeight : Integer read FHeaderHeight write FHeaderHeight default 1;
    property FooterHeight : Integer read FFooterHeight write FFooterHeight default 1;
    property SheetColumns : Integer read FSheetColumns write FSheetColumns default 1;
    property SheetRows : Integer read FSheetRows write FSheetRows default 1;

    property OnGetRowColor : TLMDGetColorEvent read FOnGetColor write FOnGetColor;
    property OnGetPrintRect : TLMDGetRectEvent read FOnGetPrintRect write FOnGetPrintRect;
//    property OnGetPageFooterRect : TLMDGetRectEvent read FOnGetFooterRect write FOnGetFooterRect;
//    property OnGetPageHeaderRect : TLMDGetRectEvent read FOnGetHeaderRect write FOnGetHeaderRect;
    property OnPrintGlobalFooter : TLMDPrintRectEvent read FOnPrintGFooter write FOnPrintGFooter;
    property OnPrintGlobalHeader : TLMDPrintRectEvent read FOnPrintGHeader write FOnPrintGHeader;
    property OnPrintFooter : TLMDPrintRectEvent read FOnPrintFooter write FOnPrintFooter;
    property OnPrintHeader : TLMDPrintRectEvent read FOnPrintHeader write FOnPrintHeader;
    property OnGetPageString : TLMDPageStringEvent read FOnGetPageString write FOnGetPageString;
    property OnGetLineNumberSpace : TLMDGetIntegerEvent read FOnGetLNDigitSpace write FOnGetLNDigitSpace;
  end;

implementation

uses
  Types, Printers, SysUtils, Forms, LMDStrings,
  LMDConst, LMDProcs;

{ ----------------------------- private -------------------------------------- }
procedure TLMDTxtPrinter.SetFont (aValue : TFont);
begin
  FFont.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTxtPrinter.SetLineStyle (aValue : TPen);
begin
  FLineStyle.Assign (aValue);
end;

{ ---------------------------- protected ------------------------------------- }

procedure TLMDTxtPrinter.Print(const Text: string; iStart, iCount: integer);

//procedure TLMDTxtPrinter.Print (Source, SourceEnd : PChar);
var
  currentSheetRow,
  currentSheetColumn,
  row,
  rowOnPage,
  cr,
  l,            //left
  t,            //top
  w,            //max page width
  h,            //max page height
  lr,
  x,
  p,            //page
  lnSpace,
  tNum,
  y : Integer;  //current row
  Rowstart, helpSource : PChar;
  s : String;
  currentSheetRect,
  headerRect,
  footerRect,
  hRect,
  printRect    : TRect;
  color        : TColor;
  pr2,
  pr           : boolean;
  Source, SourceEnd : PChar;
  begin
  if  iCount <= 0  then
    exit;

  if  iStart <= 0 then
    iStart := 1;

  if  (iStart + iCount - 1) > Length(Text)  then
    iCount := Length(Text) - iStart + 1;

  if  iCount <= 0  then
    exit;

  Source := PChar(Text) + iStart - 1;
  SourceEnd := Source + iCount;
  Printer.Title := FPrintTitle;
  Printer.Copies := FCopies;
  Printer.BeginDoc;

  Printer.Canvas.Font.Assign (FFont);

  printRect := Rect (0, 0, Printer.PageWidth, Printer.PageHeight);

  //ask user for any further resizeing of the print rect
  //for example setting up a border and positioning of the rect on the sheet
  if Assigned (FOnGetPrintRect) then FOnGetPrintRect (self, printRect, printRect);

  currentSheetColumn := 1;
  currentSheetRow    := 1;

  //auto page numbers?
{  if FPageNumbers in [pnTopLeft, pnTopCenter, pnTopRight] then
    inc (printRect.Top, Printer.Canvas.TextHeight (IDS_PAGE+'0123456789'));
  if FPageNumbers in [pnBottomLeft, pnBottomCenter, pnBottomRight] then
    dec (printRect.Bottom, Printer.Canvas.TextHeight (IDS_PAGE+'0123456789'));}

  hRect := printRect;
  //if this event is assigend the user can print any global header like filename and time
  //he should return the needed size in hRect
  //if this shall be a cover sheet he should retrun an Rect (0,0,0,0) and do a Printer.NewPage before retruning
  if Assigned (FOnPrintGHeader) then FOnPrintGHeader (self, Printer.Canvas, 0, hRect)
  else
    hRect := Rect (0, 0, 0, 0); //otherwise we would loose some space

  lnSpace := 0;
  if Assigned (FOnGetLNDigitSpace) then FOnGetLNDigitSpace (self, lnSpace);

{  w := printRect.Right - printRect.Left;
  h := printRect.Bottom - printRect.Top - FHeaderHeight - FFooterHeight;

  t := headerRect.Bottom;

  l := printRect.Left;}
  p := 0;
  lr := 10;

  //make header and footer rect to rect on whole page
//  OffsetRect (headerRect, printRect.Left, printRect.Top);
//  OffsetRect (footerRect, printRect.Left, printRect.Top);

  color := clWhite;

  row := 0;
  tNum := 0; //will calm down compiler ...

  //count first line
  //pr will be switched to false if a line to print has not to be counted
  //  -> wordbreak enabled, do not count wrapped rows, currently painting wrapped line
  pr := true;

  //step through the whole text
  while Source < SourceEnd do
    begin

      //calculate the current rect to be drawn on the sheet
      //usually this is the complete sheet but not necessarily
      currentSheetRect := Rect (printRect.Left + (printRect.Right - printRect.Left) div FSheetColumns * (currentSheetColumn - 1),
                                printRect.Top + (printRect.Bottom - printRect.Top) div FSheetRows * (currentSheetRow - 1),
                                printRect.Left + (printRect.Right - printRect.Left) div FSheetColumns * currentSheetColumn,
                                printRect.Top + (printRect.Bottom - printRect.Top) div FSheetRows * currentSheetRow);

      if FBorder then
        begin
          Printer.Canvas.Pen.Style := psSolid;
          Printer.Canvas.Pen.Width := 1;
          Printer.Canvas.Pen.Color := clBlack;
          Printer.Canvas.Rectangle (currentSheetRect.Left, currentSheetRect.Top, currentSheetRect.Right, currentSheetRect.Bottom);
          //inflate the printable area by the pen width ...
          InflateRect (currentSheetRect, -1, -1);
        end;

      if FPageNumbers <> pnNone then
        begin
          if FPageNumbers in [pnTopLeft, pnTopCenter, pnTopRight] then
             inc (currentSheetRect.Top, Printer.Canvas.TextHeight (IDS_PAGE+'0123456789'))
          else // in [pnBottomLeft, pnBottomCenter, pnBottomRight] then
             dec (currentSheetRect.Bottom, Printer.Canvas.TextHeight (IDS_PAGE+'0123456789'));
        end;

      l := currentSheetRect.Left;
      t := currentSheetRect.Top;
      inc (t, FHeaderHeight);

      h := currentSheetRect.Bottom - currentSheetRect.Top - FHeaderHeight - FFooterHeight;
      w := currentSheetRect.Right - currentSheetRect.Left;

      y := t; //get start of page

      if p = 0 then //first page -> printed global header
        inc(y, hRect.Top);

      //print the header of this page
      headerRect := currentSheetRect;
      headerRect.Bottom := currentSheetRect.Top + FHeaderHeight;
      if Assigned (FOnPrintHeader) then FOnPrintHeader (self, Printer.Canvas, p + 1, headerRect);
      //reset page row counter
      rowOnPage := 0;

      //reassign the font for the text (this could have been changed in a print header before)
      Printer.Canvas.Font.Assign (FFont);

      Printer.Canvas.Pen.Assign (FLineStyle);

      //while we are on the current sheet (including complete next line [lr] and have not yet printed the whole text
      //lr = height of last row (for firstrow defined above)
      while (y + lr < h+t) and (Source < SourceEnd) do
        begin
          //we start with our row left
          x := 0;
          //remember the first char of this row
          rowStart := Source;
          //nothing tp rint out yet
          s := '';

          //we have line numbers to be drawn => we have to leave some space on the left
          if FLineNumbers <> lnNone then
            x := lnSpace;

          //get all chars to be printed in this row
          while ((x < w) or (not FWordWrap)) and not (Source^ = #10) and (Source < SourceEnd) do
          begin
              inc (x, Printer.Canvas.TextWidth (Source^));
              if not LMDAnsiCharInSet(source^, [#10, #13, #9]) and (x < w) then
                s := s + source^;
              if (Source^ = #9) and (x < w) then s := s +'  ';
              inc (Source);
            end;

          //we just cutted the line as it reached the right border -> this means that the last word could be splitted
          if (FWordWrap) and (Source^ <> #10) then
          begin
              helpSource := Source;
              while (helpSource > rowStart) and not LMDAnsiCharInSet(helpSource^, [' ', #9, ':','.',',',';','+','*','/','!','?']) do
              dec (helpSource);
              //if helpSource = rowStart there is no other possibility than cutting this word
              if helpSource <> rowStart then
                begin
{                  //decrement our x
                  dec (x, TextWidth (Copy (s, helpSource - rowStart, Source - helpSource));}
                  //delete chars we do no longer paint in this row
                  Delete (s, helpSource - rowStart + 1, Source - helpSource);
                  //set start of next line to the last word in the current line
                  Source := helpSource;
                end;
            end;

          //pr = true if row counters have to be incremented
          if pr then
            begin
              inc (row);
              inc (rowOnPage);
            end;

          //remeber pr for printing of line number
          pr2 := pr;

          //we have got a real linebreak (independet from wordwrapping)
          if Source^ = #10 then
          begin
              inc (Source);
              //increment row counter next time
              pr := true;
            end
          else //we have got a linebreak due to wordwrapping
            begin
              //if a wrapped line shall be treated like a real row inc the row counters
              if FCountWrappedLines then
                begin
                  //increment row counter next time
                  pr := true;
                end
              else
                //don't increment counter next time
                pr := false;
            end;

          //get the height of the last printed row
          cr := Printer.Canvas.TextHeight (s);
          //if it is 0 then take the last row height for this empty row
          if cr = 0 then cr := lr;

          //should there be a colored row
          if Assigned (FOnGetColor) then
            begin
              Printer.Canvas.Brush.Style := bsSolid;
              FOnGetColor (self, row, rowOnPage, color);
              Printer.Canvas.Brush.Color := color;
              Printer.Canvas.FillRect (Rect (l+1, y, l+w-2,y + cr));
            end;

          if FLineNumbers = lnNone then
            Printer.Canvas.TextOut (l, y, s)
          else
            Printer.Canvas.TextOut (l + lnSpace, y, s);

          //print line numbers - if wanted
          case FLineNumbers of
            lnPage : tNum := rowOnPage;
            lnGlobal : tNum := row;
          end;

          if pr2 and (FLineNumbers <> lnNone) then //s contains row number
            begin
              s := IntToStr (tNum) + ' : ';
              if Assigned (FOnGetLineNumString) then
                FOnGetLineNumString (self, s, tNum);
              Printer.Canvas.TextOut (l + lnSpace - Printer.Canvas.TextWidth(s), y, s);
            end;

          //inc x by row height
          inc (y, cr);

          if FLined then
            begin
              Printer.Canvas.MoveTo (l, y + 1);
              Printer.Canvas.LineTo (l + w, y + 1);
              inc (y, Printer.Canvas.Pen.Width + 1);
            end;

          //remember the last row height
          lr := cr;
        end; //end of page p while loop

      //print the user footer
      footerRect := currentSheetRect;
      footerRect.Top := currentSheetRect.Bottom - FFooterHeight;
      if Assigned (FOnPrintFooter) then FOnPrintFooter (self, Printer.Canvas, p, footerRect);

      //reassign the font - it coulds have been changed in the event before
      Printer.Canvas.Font.Assign (FFont);

      //entering next page
      inc(p);
      //if auto page numbering
      if FPageNumbers <> pnNone then
        begin
          //build up page string
          s := IDS_PAGE + IntToStr (p);

          if Assigned (FOnGetPageString) then FOnGetPageString (self, s, p);

          //x, y are of no user here; t = top of page
          if FPageNumbers in [pnTopLeft, pnTopCenter, pnTopRight] then
            y := currentSheetRect.Top - Printer.Canvas.TextHeight (s)
          else //FPageNumbers in [pnBottomLeft, pnBottomCenter, pnBottomRight]
            y := currentSheetRect.Bottom-1;
          case FPageNumbers of
            pnTopLeft,
            pnBottomLeft : x := l;
            pnTopCenter,
            pnBottomCenter : x := l + w div 2 - Printer.Canvas.TextWidth (s) div 2;
          else
            x := l + w - Printer.Canvas.TextWidth (s);
          end;
          Printer.Canvas.TextOut (x, y, s);
        end;

        if Source < SourceEnd then //otherwise we would produce one empty sheet at the end
          begin
            if (currentSheetRow = FSheetRows) and (currentSheetColumn = FSheetColumns) then
              begin //shett full
                currentSheetRow := 1;
                currentSheetColumn := 1;
                Printer.NewPage;
              end
            else
              begin //try to step to next column
                inc (currentSheetColumn);
                if currentSheetColumn > FSheetColumns then
                  begin //no more columns => take next row
                    inc(currentSheetRow);
                    currentSheetColumn := 1;
                  end;
              end;
          end;

        //if this job had been cancelled get out
        if Printer.Aborted then exit;

        //return to app for a short time (for doing immediate actions)
        Application.ProcessMessages;
      end;
  //we have printed the whole text - add any global footer?
  //note: if a page footer is drawn the last page is full ... therefore
  //the user will have to add a page with Printer.NewPage
  hRect := printRect;
  if Assigned (FOnPrintGFooter) then FOnPrintGFooter (self, Printer.Canvas, 0, hRect);

  //just end this printing job
  Printer.EndDoc;
end;

{ ----------------------------- public --------------------------------------- }
constructor TLMDTxtPrinter.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FFont := TFont.Create;
  FLineStyle := TPen.Create;
  FWordwrap := true;
  FLined := false;
  FLineNumbers := lnNone;
  FCountWrappedLines := false;
  FPageNumbers := pnNone;
  FSheetRows := 1;
  FSheetColumns := 1;
  FFooterHeight := 0;
  FHeaderHeight := 0;
  FCopies := 1;
  FBorder := false;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDTxtPrinter.Destroy;
begin
  FLineStyle.Free;
  FFont.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTxtPrinter.PrintFile (const Filename : String);
var
  Stream: TFileStream;

  Buf: string;

begin
  Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);

  try
    SetLength(Buf, Stream.Size div SizeOf(Char));
    Stream.ReadBuffer(PChar(Buf)^, Length(Buf)*SizeOf(Char));
  finally
    Stream.Free;
  end;

  if  Length(Buf) > 0 then
    Print(Buf, 1, Length(Buf));
end;
{
procedure TLMDTxtPrinter.PrintFile (const Filename : String);
var
  fs : TMemoryStream;
  s, se : PChar;
begin
  fs := TMemoryStream.Create;
  try
    fs.LoadFromFile (Filename);
    s := PChar (fs.Memory);
    se := s + fs.Size;
    Print (s, se);
  finally
    fs.Free;
  end;
end;
}
{ ---------------------------------------------------------------------------- }
procedure TLMDTxtPrinter.PrintText (const txt : String);
begin
  //init pointers to text to be printed
//  Print (Pointer(txt), PChar(Pointer(txt)) + Length (txt));
  Print (Txt, 1, Length (txt));
end;

end.
