unit LMDCustomMemo;
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

LMDCustomMemo unit (JH)
-----------------------

Multiline text input control

Changes
-------
Release 8.05
 - BTS 487: ScrollBars=skAuto, WordWrap=true: showing/hiding vscrollbar fixed
 - WordWrap=true, mouse selection of a pending line was not always possible, fixed

-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Windows, Messages, Controls, stdctrls, Graphics, SysUtils, Themes,
  LMDObject, LMDTypes, LMDBaseEdit, LMDFillObject, LMDSBar, LMDVldBase;

const
  LMDMaxVisibleLines = 150;

type

  TLMDCustomMemo = class;
  TLMDMemoScrollBarKind = (skHorizontal, skVertical, skBoth, skAuto, skNone);

  { ----------------------------- TLMDMemoStrings ---------------------------- }
  TLMDMemoStrings = class (TLMDObject)
  private
    FOwnerMemo : TLMDCustomMemo;
    FAdditiveLoadFrom : Boolean;

    function GetLine (index : Integer) : TLMDString;
    procedure SetLine (index : Integer; aValue : TLMDString);
    function GetText : TLMDString;
    function GetRows : Integer;
    procedure SetText (const aValue : TLMDString);

  public
    property Owner : TLMDCustomMemo read FOwnerMemo;
    constructor CreateExt (aOwner : TLMDCustomMemo);
    procedure Assign(Source: TPersistent); override;
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToFile(const Filename : TLMDString);
    procedure LoadFromFile(const Filename : TLMDString);

    {$IFDEF LMD_UNICODE}
    procedure SaveToStreamW(Stream: TStream);
    procedure LoadFromStreamW(Stream: TStream);
    procedure SaveToFileW(const Filename : TLMDString);
    procedure LoadFromFileW(const Filename : TLMDString);
    {$ENDIF}

    procedure BeginUpdate;
    procedure EndUpdate;

    procedure Insert(Index: LongInt; const S: TLMDString);
    procedure Append (const S : TLMDString);
    function Add (const S : TLMDString) : Integer;
    procedure AddStrings (aValue : TStrings);
    procedure GetAsStrings (aValue : TStrings);
    procedure Move (CurIndex, NewIndex : Integer);
    procedure Delete (Index : Integer);
    procedure Exchange (FirstIndex, SecondIndex : Integer);
    procedure Clear;

    procedure SetTextStr (const Value : TLMDString);
    function GetTextStr : TLMDString;

    property Count : Integer read GetRows;
    property Text : TLMDString read GetText write SetText;
    property Strings[Index: Integer]: TLMDString read GetLine write SetLine; default;
    property AdditiveLoadFrom : Boolean read FAdditiveLoadFrom write FAdditiveLoadFrom default false;
  end;

  TLMDMarginAlignment = (maLeft, maRight);
  { ----------------------------- TLMDMarginObject --------------------------- }
  TLMDMarginObject = class(TLMDObject)
  private
    FWidth : Integer;
    FFillObject : TLMDFillObject;
    FAlignment : TLMDMarginAlignment;
    procedure SetFillObject (aValue : TLMDFillObject);
    procedure SetInteger (aValue : Integer);
    procedure SetAlignment (aValue : TLMDMarginAlignment);
  public
    constructor Create(Owner: TPersistent=nil); override;
    destructor Destroy; override;
  published
    property FillObject : TLMDFillObject read FFillObject write SetFillObject;
    property Width : Integer read FWidth write SetInteger default 0;
    property Alignment : TLMDMarginAlignment read FAlignment write SetAlignment
                         default maLeft;
  end;

  TLMDOnMarginRowPaint = procedure (Sender : TObject; Canvas : TCanvas;
                                    aRect : TRect;
                                    firstChar, length : Integer) of object;

  { ----------------------------- TLMDCustomMemo ----------------------------- }
  TLMDCustomMemo = class(TLMDBaseEdit)
  private
    FHScroll,
    FVScroll      : TLMDScrollBar;

    FHScrollObj,
    FVScrollObj   : TLMDScrollBarObject;

    FScrollBars   : TLMDMemoScrollBarKind;

    FStrings      : TLMDMemoStrings;

    FVScrollFactor: Single;
    FCanScrollDown: boolean;

    FOldHiddenLeft,
    FOldFirstRow,
    FOldCurrentRow, //needed for  repaint

    FRowHeight,
    FFirstRowOut,     //the first visible row (number) of the memo (cursor independend)
    FRows,            //number of rows
    FWorkRowCount,    //helper for handling of removed and inserted text, JH Oct 03
    FCurrentRow,      //currently active row number (cursor depended)
    FCursorRowStart,
    FCursorRowFirst,
    FCursorFirst,     // if the cursor is not visible it is necessary to know where the current line starts
    FHideLeftRight,   // how many pixels are hidden on a side
    FLongRow,
    FRowsDrawnCount,      //NUMBER of rows currently printed!!
    FFirstCharOut : Integer; // points to the first char out LA[1]

    FSoftLineBreak,
    FScrolled,
    FLined,
    FTextEnd,
    FWantTabs,
    FWantReturns,
    FWordWrap     : Boolean;

    FMargin       : TLMDMarginObject;
    FMarginRect   : TRect;

    FLineStyle    : TPen;
 //   FTabs         : TLMDTabObject;
    FTabChars     : Integer;

    CharWidth     : Array[0..255] of Integer; //a table which is recreated each time the font changes
                                              //it speeds up text parsing enormously
    LA            : Array[1..LMDMaxVisibleLines] of Integer; //the visible row line starts ... does anyone needs more than 150 visible lines?

    FOnMarginRowPaint : TLMDOnMarginRowPaint;
    FOnRowChange,
    FOnRowCountChange : TNotifyEvent;
    FIgnoreLastEmptyLine: boolean;
    FLineGap: integer;
    FHiddenLeft: Integer;

    procedure UpdateVScrollBar;
    procedure SetRows (index, aValue : Integer);
    procedure SetScrollBars (aValue : TLMDMemoScrollBarKind);
    procedure SetStrings (aValue : TLMDMemoStrings);
    procedure SetBoolean (index : Integer;aValue : Boolean);
    function GetRowCount : Integer;
    procedure SetIgnoreLastEmptyLine(aValue : boolean);
    procedure SetLineStyle (aValue : TPen);
    procedure SetScrollObj (index : Integer;aValue : TLMDScrollBarObject);
//    procedure SetTabs (aValue : TLMDTabObject);
    procedure SetMargin (aValue : TLMDMarginObject);
    procedure SetTabChars (aValue : Integer);
    procedure SetLineGap (aValue : Integer);

    function GetStrings : TLMDMemoStrings;

    function GetRowNr : Integer;
    function GetColumn : Integer;
    function GetColumns : Integer;

    procedure ScrollUp (Rows : Integer);
    procedure ScrollDown (Rows : Integer);
    procedure DoOnVScroll (Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure DoOnHScroll (Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);

    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure CMFontChanged (var Msg : TMessage); message CM_FONTCHANGED;
    procedure DoFontChanged;
    procedure MakeCursorVisible;
    function CalcRowNr (pos : Integer) : Integer;
    function CalcRowFromChar (pos : Integer) : Integer;
    function CalcCharRowStart (pos : Integer;var crow : Integer) : Integer;
    function CalcRowStart (row : Integer) : Integer;

    procedure GetNextLine (var LineStart : Integer; TextEnd : Integer);
    procedure GetPrevLine (var LineStart : Integer; TextStart : Integer);
    procedure PaintMargin (toCanvas : TCanvas);

    //EM_XXX message handling
    procedure EMFMTLINES (var Message : TMessage); message EM_FMTLINES;
    procedure EMGETFIRSTVISIBLELINE (var Message : TMessage); message EM_GETFIRSTVISIBLELINE;
    procedure EMGETHANDLE (var Message : TMessage); message EM_GETHANDLE;
    procedure EMGETLINE (var Message : TMessage); message EM_GETLINE;
    procedure EMGETLINECOUNT (var Message : TMessage); message EM_GETLINECOUNT;
    procedure EMGETMARGINS (var Message : TMessage); message EM_GETMARGINS;
    procedure EMGETTHUMB (var Message : TMessage); message EM_GETTHUMB;
    procedure EMLINEFROMCHAR (var Message : TMessage); message EM_LINEFROMCHAR;
    procedure EMLINEINDEX (var Message : TMessage); message EM_LINEINDEX;
    procedure EMLINELENGTH (var Message : TMessage); message EM_LINELENGTH;
    procedure EMLINESCROLL (var Message : TMessage); message EM_LINESCROLL;
    procedure EMPOSFROMCHAR (var Message : TMessage); message EM_POSFROMCHAR;
    procedure EMSCROLL (var Message : TMessage); message EM_SCROLL;
    procedure EMSCROLLCARET (var Message : TMessage); message EM_SCROLLCARET;
    procedure EMSETMARGINS (var Message : TMessage); message EM_SETMARGINS;
    procedure EMSETTABSTOPS (var Message : TMessage); message EM_SETTABSTOPS;
  protected
    function GetCharWidth(wc: TLMDChar): integer; overload;
    function GetCharWidth(oc: integer): integer; overload;
    procedure CreateBack; override;
    procedure GetChange(Sender: TObject); override;
    procedure RepaintBack(aRect: TRect); override;
    procedure ClearBack;
    procedure DoAlignmentChange; override;
    procedure InitScrollBars;
    function RowWidth (const s : TLMDString) : LongInt;
    function RowHeight (s : TLMDString) : LongInt; override;
    procedure CursorPosChanged; override;
    function getRow(ch : Integer) : Integer;
    procedure AlignControls (AControl: TControl; var Rect: TRect); override;
    function GetClientRect : TRect; override;
    function CountRows(var ctext : TLMDString) : Integer;

    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
                          MousePos: TPoint): Boolean; override;

    { abstract routines from BaseEdit }
    procedure SetCaret; override;
    procedure SetNewText; override;
    procedure GetNewText; override;
    function  GetThemedTextColor: TColor;
    procedure DrawEditText(from : Integer); override;
    function CalcMousePos(Pos : TSmallPoint) : LongInt; override;
    function CalcMouseCol(XPos : Integer) : Integer; override;
    function CalcMouseRow(YPos : Integer) : Integer; override;
    procedure ChangedText (At : Integer); override;
    procedure GetCommandKey (var KeyCode : Word; Shift : TShiftState); override;
    procedure HandleInsertText (at : Integer; var aValue : TLMDString); override;
    procedure HandleReplaceText (at : Integer; aValue : TLMDString); override;
    procedure DoThemeChanged; override;
    procedure Loaded; override;
    procedure Paint; override;
    procedure ModifyTextRect; override;
    procedure ModifyPaintRect; override;

    property IgnoreLastEmptyLine: boolean read FIgnoreLastEmptyLine write SetIgnoreLastEmptyLine default false;
    //the following 4 properties are needed to keep control of the changes made to the text concerning the output
    property RowCounter : Integer index 0 read FRows write SetRows;
    property RowFirst : Integer index 1 read FFirstRowOut write SetRows;
    property RowLength : Integer index 2 read FLongRow write SetRows;
    property RowHide : Integer index 3 read FHiddenLeft write SetRows;
    property RowCurrent : Integer index 4 read FCurrentRow write SetRows;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;

    procedure LoadFromFile (const Filename : TLMDString); {$IFDEF LMDCOMP12}overload;{$ENDIF}
  	{$IFDEF LMDCOMP12}
    procedure LoadFromFile (const Filename : TLMDString; aEncoding: TEncoding); overload;
    {$ENDIF}
    procedure SaveToFile (const Filename : TLMDString); {$IFDEF LMDCOMP12}overload;{$ENDIF}
  	{$IFDEF LMDCOMP12}
    procedure SaveToFile (const Filename : TLMDString; aEncoding: TEncoding); overload;
    {$ENDIF}

    procedure AddLine (const s : TLMDString);
    procedure InsertAtLine (Index : LongInt; S : TLMDString);
    procedure DeleteLine (Index : LongInt);
    function GetLineParas (Index : Integer; var Start, Count : Integer) : TLMDString;
    function GetLine (Index : LongInt) : TLMDString;
    function GetRowText(Index: LongInt): TLMDString;
    procedure MoveLine (CurIndex, NewIndex : LongInt);
    procedure ExchangeLines (FirstIndex, SecondIndex : Integer);
    procedure SetLine (Index : Integer; S : TLMDString);

    property Column : Integer read GetColumn;
    property Row : Integer read GetRowNr;
    property Rows : Integer read GetRowCount;
    property Columns : Integer read GetColumns;
    property FirstRow : Integer read FFirstRowOut;
    property Margin : TLMDMarginObject read FMargin write SetMargin;

    property ScrollBars : TLMDMemoScrollBarKind read FScrollBars write SetScrollBars
                          default skNone;
    property WordWrap : Boolean index 0 read FWordWrap write SetBoolean
                        default true;
    property WantTabs : Boolean index 1 read FWantTabs write SetBoolean
                        default false;
    property WantReturns : Boolean index 2 read FWantReturns write SetBoolean
                           default true;
    property Lines : TLMDMemoStrings read GetStrings write SetStrings
                     stored false;
    property LineGap: integer read FLineGap write SetLineGap default 2;

//    property Tabs : TLMDTabObject read FTabs write SetTabs;
    property TabChars : Integer read FTabChars write SetTabChars default 8;
    property Lined : Boolean index 3 read FLined write SetBoolean default false;
    property LineStyle : TPen read FLineStyle write SetLineStyle;
    property HorizScrollBar : TLMDScrollBarObject index 0 read FHScrollObj
                                                          write SetScrollObj;
    property VertScrollBar : TLMDScrollBarObject index 1 read FVScrollObj
                                                         write SetScrollObj;

    property OnMarginRowPaint : TLMDOnMarginRowPaint read FOnMarginRowPaint
                                                     write FOnMarginRowPaint;
    property OnCurrentRowChanged : TNotifyEvent read FOnRowChange
                                                write FOnRowChange;
    property OnRowCountChanged : TNotifyEvent read FOnRowCountChange
                                              write FOnRowCountChange;

  end;

implementation

uses
  Types,
  LMDProcs, LMDGraphUtils,
  LMDStrings,
  {$IFDEF LMD_UNICODE}
  LMDUnicodeStrings,
  {$ENDIF}
  LMDClass, LMDGraph;

{ ---------------------- TLMDMarginObject ------------------------------------ }
procedure TLMDMarginObject.SetFillObject (aValue : TLMDFillObject);
begin
  FFillObject.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMarginObject.SetInteger (aValue : Integer);
begin
  if aValue <> FWidth then
    begin
      FWidth := aValue;
      GetChange (nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMarginObject.SetAlignment (aValue : TLMDMarginAlignment);
begin
  if aValue <> FAlignment then
    begin
      FAlignment := aValue;
      GetChange (nil);
    end;
end;

{ ----------------------- public --------------------------------------------- }
constructor TLMDMarginObject.Create;
begin
  inherited Create;
  FFillObject := TLMDFillObject.Create;
  FFillObject.OnChange := GetChange;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDMarginObject.Destroy;
begin
  FFillObject.OnChange := nil;
  FFillObject.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.SetTextStr(const Value: TLMDString);
begin
//  inherited SetTextStr (Value);
  FOwnerMemo.Text := Value;
{  if (Length(Value) <> Length (FOwnerMemo.Text)) or (Value <> FOwnerMemo.Text) then
    FOwnerMemo.Text := Value;}
end;

{ ---------------------------------------------------------------------------- }
function TLMDMemoStrings.GetTextStr: TLMDString;
begin
//  result := inherited GetTextStr;
  result := FOwnerMemo.Text;
end;

{ ---------------------------------------------------------------------------- }
function TLMDMemoStrings.GetLine (index : Integer) : TLMDString;
begin
  result := FOwnerMemo.GetLine (index);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.SetLine (index : Integer; aValue : TLMDString);
begin
  FOwnerMemo.SetLine (index, aValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDMemoStrings.GetText : TLMDString;
begin
  result := FOwnerMemo.Text;
end;

{ ---------------------------------------------------------------------------- }
function TLMDMemoStrings.GetRows : Integer;
begin
  result := FOwnerMemo.Rows;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.SetText (const aValue : TLMDString);
begin
  FOwnerMemo.Text := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.SaveToStream(Stream: TStream);
begin
  {*}LMDAnsiStringToStream(FOwnerMemo.Text, Stream);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.Assign(Source: TPersistent);
begin
  if source=self then exit;
  if Source is TStrings then
    begin
      SetText(TStrings(Source).Text);
      exit;
    end;
  inherited Assign(Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.LoadFromStream(Stream: TStream);
var
  Size: Integer;
  S: TLMDString;
begin
//  BeginUpdate;
  try
    Size := Stream.Size - Stream.Position;
    S := TLMDString(LMDAnsiStreamToString(Stream, Size));
    if FAdditiveLoadFrom then
      FOwnerMemo.Text := FOwnerMemo.Text + {$IFDEF LMDCOMP12}String{$ENDIF}(S)
    else
      FOwnerMemo.Text := {$IFDEF LMDCOMP12}String{$ENDIF}(S);
  finally
//    EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.SaveToFile(const Filename : TLMDString);
var
  fs : TFileStream;
begin
  fs := TFileStream.Create (Filename, fmCreate);
  try
    SaveToStream (fs);
  finally
    fs.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.LoadFromFile(const Filename : TLMDString);
var
  fs : TFileStream;
begin
  fs := TFileStream.Create (Filename, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream (fs);
  finally
    fs.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.BeginUpdate;
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.EndUpdate;
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.Insert(Index: LongInt; const S: TLMDString);
begin
  FOwnerMemo.InsertAtLine (Index, S);
end;

{ ---------------------------------------------------------------------------- }
function TLMDMemoStrings.Add(const S: TLMDString) : LongInt;
begin
  Insert (FOwnerMemo.Rows, S);
  result := FOwnerMemo.Rows;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.Append(const S: TLMDString);
begin
  Insert (FOwnerMemo.Rows, S);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.AddStrings (aValue : TStrings);
begin
  Add (aValue.Text);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.GetAsStrings (aValue : TStrings);
begin
  aValue.Text := FOwnerMemo.Text;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.Delete(Index : LongInt);
begin
  FOwnerMemo.DeleteLine (Index);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.Move (CurIndex, NewIndex : Integer);
begin
  FOwnerMemo.MoveLine (CurIndex, NewIndex);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.Exchange(FirstIndex, SecondIndex : LongInt);
begin
  FOwnerMemo.ExchangeLines (FirstIndex, SecondIndex);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.Clear;
begin
  FOwnerMemo.Clear;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDMemoStrings.CreateExt (aOwner : TLMDCustomMemo);
begin
  inherited Create;
  FAdditiveLoadFrom := false;
  FOwnerMemo := aOwner;
end;

{ @@@@@@@@@@@@@@@@@@@@@@@@@@@@ class TLMDCustomMemo @@@@@@@@@@@@@@@@@@@@@@@@@@ }
{ ----------------------------------- private -------------------------------- }
procedure TLMDCustomMemo.UpdateVScrollBar;
var
  FRDC: Integer;
  FOldVisible: boolean;
begin
  if Assigned(FVScroll) then
    begin
      FRDC := (FTextRect.Bottom - FTextRect.Top) div RowHeight ('');
      FVScroll.Max := FRows - FRDC + 2; //VB april 2005
      //<-- moved here from SetRows VB Aug 2005
      if (FScrollBars = skAuto) and (FRowsDrawnCount <> 0) then
        begin
          //< March 2001: visible if FRows > FRowsDrawnCount
          //changed by JH, March 2001: visible iff FFirstRowOut <> 1
          //changed by JH, Spet 2003:
          //FWordWrap case handling added VB Feb 2008
          FOldVisible := FVScroll.Visible;

          if FWordWrap then
            FVScroll.Visible := (LA[1] > 1) or FCanScrollDown
          else
            FVScroll.Visible := (FFirstRowOut <> 1) or (FRows > FRowsDrawnCount);

           //Do not allow typing in the vert. ScrollBar's area //VB Feb 2008
          if not FOldVisible and FVScroll.Visible then
            begin
              FTextRect.Right := FTextRect.Right - FVScroll.Width;
              FPaintRect.Right := FPaintRect.Right - FVScroll.Width;
              Paint;
            end;
          if FOldVisible and not FVScroll.Visible then
            begin
              FTextRect.Right := FTextRect.Right + FVScroll.Width;
              FPaintRect.Right := FPaintRect.Right + FVScroll.Width;
              Paint;
            end;
            FVScroll.Position := FFirstRowOut;
        end;
      //-->
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.SetRows (index, aValue : Integer);
begin
  case index of
    0 : if aValue <> FRows then
          begin
            FRows := aValue;
            if Assigned (FOnRowCountChange) then FOnRowCountChange (self);
            if FVScroll <> nil then
              begin
                FVScroll.BeginUpdate;
                UpdateVScrollBar;
                FVScroll.EndUpdate(true);
              end;
          end;
    1 : if aValue <> FFirstRowOut then
          begin
            if aValue < 1 then aValue := 0 {1 -> 0 VB May 2009};
            FFirstRowOut := aValue;
            if FVScroll <> nil then
              FVScroll.Position := FFirstRowOut;
          end;
    2 : if aValue <> FLongRow then
          begin
            FLongRow := aValue;
            if FHScroll <> nil then
              begin
                FHScroll.BeginUpdate;
                FHScroll.Max := FLongRow;
                FHScroll.Position := FHideLeftRight;
                FHScroll.EndUpdate(true);

//                FHScroll.Visible := FLongRow > FTextRect.Right - FTextRect.Left;
{                if (FScrollBars = skAuto) then //always visible here
                  if FLongRow > FTextRect.Right - FTextRect.Left then
                    FHScroll.Visible := true
                  else
                    FHScroll.Visible := false;}

                if (FScrollBars = skAuto) then   //vb aug 2005
                  if aValue <> 0 then
                    FHScroll.Visible := true
                  else
                    FHScroll.Visible := false;
              end;
          end;
    3 : if aValue <> FHiddenLeft then
          begin
            FHiddenLeft := aValue;
            if FHScroll <> nil then
              begin
                FHScroll.Position := FHiddenLeft;
              end;
          end;
    4 : if aValue <> FCurrentRow then
          begin
            FCurrentRow := aValue;
            if Assigned (FOnRowChange) then FOnRowChange (self);
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.SetScrollBars (aValue : TLMDMemoScrollBarKind);

var
  aRect : TRect; //needed for the alignment of scrollbars

          procedure CreateVScroll;
          begin
            FVScroll := TLMDScrollBar.Create (self);
            FVScroll.Parent := self;
            FVScroll.CanBeFocused := false;
            FVScroll.Kind := LMDSBar.skVertical;
            FVScroll.Width := 16;
            FVScroll.Min := 0;
            FVScroll.Max := 0;
            //FVScroll.ThemeMode := self.ThemeMode;  -> moved to InitScrollBars VB May 2009
            FVScroll.ThumbMode := tmAuto;
            FVScroll.OnScroll := DoOnVScroll;
            FVScroll.Bevel.Mode := bmStandard;
            FVScroll.Bevel.StandardStyle := lsNone;  //added Sept 03, JH
            FVScrollObj.AssignToScrollBar (FVScroll);
          end;
          procedure CreateHScroll;
          begin
            FHScroll := TLMDScrollBar.Create (self);
            FHScroll.Parent := self;
            FHScroll.CanBeFocused := false;
            FHScroll.ThumbMode := tmAuto;
            FHScroll.OnScroll := DoOnHScroll;
            FHScroll.Min := 0;
            FHScroll.Max := 0;
            FHScroll.Height := 16; //added Oct 03, JH
            //FHScroll.ThemeMode := self.ThemeMode;  -> moved to InitScrollBars VB May 2009
            if (Alignment <> taLeftJustify) or not FWordWrap then
              begin
                FHScroll.Enabled := false;
                if FScrollBars = skAuto then
                  FHScroll.Visible := false;
              end;
            FHScroll.Bevel.Mode := bmStandard;
            FHScroll.Bevel.StandardStyle := lsNone; //added Sept 03, JH
            FHScrollObj.AssignToScrollBar (FHScroll);
          end;

begin
  if aValue <> FScrollBars then
    begin
      FScrollBars := aValue;
      case FScrollBars of
        skNone : begin
                   if FHScroll <> nil then
                     begin
                       FHScroll.Free;
                       FHScroll := nil;
                     end;
                   if FVScroll <> nil then
                     begin
                       FVScroll.Free;
                       FVScroll := nil;
                     end;
                 end;
        skVertical :
                 begin
                   if FHScroll <> nil then
                     begin
                       FHScroll.Free;
                       FHScroll := nil;
                     end;
                   if FVScroll = nil then
                     CreateVScroll;
                 end;
        skHorizontal :
                 begin
                   if FVScroll <> nil then
                     begin
                       FVScroll.Free;
                       FVScroll := nil;
                     end;
                   if FHScroll = nil then
                     CreateHScroll;
                 end;
        skBoth :
                 begin
                   if FHScroll = nil then
                     CreateHScroll
                   else
                     FHScroll.Visible := true;
                   if FVScroll = nil then
                     CreateVScroll
                   else
                     FVScroll.Visible := true;
                 end;
        skAuto :
                 begin
                   if FVScroll = nil then
                     CreateVScroll;

                   // < March 2001: (FRows > FRowsDrawnCount)
                   //JH March 2001: (FFirstRowOut <> 1)
                   //JH Sept 2003:
                   if FWordWrap then
                     FVScroll.Visible := (LA[1] > 1) or FCanScrollDown
                   else
                     FVScroll.Visible := (FFirstRowOut <> 1) or (FRows > FRowsDrawnCount);

                   if FHScroll = nil then
                     CreateHScroll;
                   //make the horizontal scrollbar always visible
                   // (iff it could happen that a row gets too long)
                   FHScroll.Visible := not FWordWrap;// or (ALignment <> taLeftJustify));
                 end;
      end; //end case
      if not (csDestroying in ComponentState) then
        begin
          aRect := Rect (0,0,0,0);
          AlignControls (nil, aRect);
          Paint;
        end;
    end; //end if
end; //end procedure

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.CreateBack;
var
  y:  Integer;
begin
  inherited;
  if not FOutBuffered then exit;
  try
    if Lined then
      begin
        y := FTextRect.Top + RowHeight ('');
        while y < FTextRect.Bottom do
          begin
            y := y - FLineStyle.Width div 2;
            FBack.Canvas.Pen.Assign (FLineStyle);
            FBack.Canvas.MoveTo (1, y-1);
            FBack.Canvas.LineTo (FTextRect.Right {- FTextRect.Left} - 1, y-1);
            y := y + FLineStyle.Width div 2;
            inc(y, RowHeight (''));
          end;
      end;
  finally
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.GetChange(Sender : TObject);
begin
  inherited GetChange (Sender);
  if Sender = FHScrollObj then
    if Assigned(Self.FHScroll) then FHScrollObj.AssignToScrollBar(FHScroll);
  if Sender = FVScrollObj then
    if Assigned(Self.FVScroll) then FVScrollObj.AssignToScrollBar(FVScroll);
  if Sender = FMargin then //added Oct 02, JH
    begin
      SetupRects;
      Invalidate;
    end;
end;

function TLMDCustomMemo.GetCharWidth(oc: integer): integer;
begin
  result := GetCharWidth(TLMDChar(oc));
end;

function TLMDCustomMemo.GetCharWidth(wc: TLMDChar): integer;
var
  l: TSize;
  i: integer;
  //pwc: PWideChar;
begin
  i := Ord(wc);
  if i < 256 then
    result := CharWidth[i]
  else
    begin
      {$IFDEF LMD_UNICODE}
      Windows.GetTextExtentPoint32W(Canvas.Handle, {$IFNDEF LMDCOMP12}PWideChar(@wc){$ELSE}wc{$ENDIF}, 1, l);
      {$ELSE}
      Windows.GetTextExtentPoint32A(Canvas.Handle, int_Ref(wc), 1, l);
      {$ENDIF}
      result := l.cx;
      if l.cy > FRowheight then
        FRowHeight := l.cy;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.RepaintBack (aRect : TRect);
begin
  inherited RepaintBack(aRect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.ClearBack;
var
  y: integer;
  aRect: TRect;
begin
  aRect := FTextRect;
  if Lined then
    begin
      y := aRect.Top;
      while y + RowHeight('') < FTextRect.Bottom do
        begin
          RepaintBack (Rect (aRect.Left, y, aRect.Right, y+ RowHeight('')-FLineStyle.Width));
          Inc(y, RowHeight (''));
        end
    end
  else
    RepaintBack (FTextRect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.SetStrings (aValue : TLMDMemoStrings);
begin
  //just do some settings
  FFirstCharOut := 1;
  SelLength := 0;
  CurrentChar := 1;
  RowFirst := 1;
  RowLength := 0;
  RowHide := 0;

  FOldCurrentRow := 0;
  FOldFirstRow := 0;
  FOldHiddenLeft := 0;

  //assign the new text to the edit text var (which is used in BaseEdit)
  Text := aValue.Text {FStrings.Text};
  RowCounter := countRows (FText);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMemo.GetStrings : TLMDMemoStrings;
begin
//  FStrings.Text := FText;
  result := FStrings;
end;

function TLMDCustomMemo.GetThemedTextColor: TColor;
{$IFDEF LMDCOMP16}
const
  C_STATES: array[Boolean, Boolean] of TThemedEdit = (
    (teEditTextDisabled,
     teEditTextDisabled),
    (teEditTextNormal,
     teEditTextReadOnly)
  );
var
  dtls: TThemedElementDetails;
{$ENDIF}
begin
  {$IFDEF LMDCOMP16}
  if (UseThemeMode = ttmPlatform) and StyleServices.Enabled and
     TStyleManager.IsCustomStyleActive then
  begin
    dtls := StyleServices.GetElementDetails(C_STATES[Enabled, ReadOnly]);
    if not StyleServices.GetElementColor(dtls, ecTextColor, Result) then
      Result := clWindowText;
  end
  else
  {$ENDIF}
    Result := Font.Color;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.SetBoolean (index : Integer;aValue : Boolean);
begin
  case index of
    0 : if aValue <> FWordWrap then
          begin
            FWordWrap := aValue;
            //FHiddenLeft (RowHide) should be zero for WordWrapping
            RowHide := 0;
            RowLength := 0; //longest Row
            RowCounter := CountRows(FText);

            DrawEditText (-1);

            if FScrollBars = skAuto then //added March 2001, JH
              if FHScroll <> nil then
                begin
                  FHScroll.Visible := not FWordWrap;
                end;

            SetCaret;
          end;
    1 : FWantTabs := aValue;
    2 : FWantReturns := aValue;
    3 : if aValue <> FLined then
          begin
            FLined := aValue;
            Paint;
//            DrawText(-1);
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMemo.GetRowCount : Integer;
var
 len: integer;
begin
  len := Length(FText);
  if len = 0 then
    result := 0
  else
    result := FRows + 1;
  if (len > 0) and IgnoreLastEmptyLine and (FText[len] = #10) then
    result := FRows;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.SetIgnoreLastEmptyLine(aValue : boolean);
begin
  FIgnoreLastEmptyLine := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.SetLineStyle (aValue : TPen);
begin
  FLineStyle.Assign (aValue);
  DrawEditText(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.SetScrollObj (index : Integer;
                                       aValue : TLMDScrollBarObject);
begin
  case index of
    0 : begin
          FHScrollObj.Assign (aValue);
          if FHScroll <> nil then
            begin
              FHScrollObj.AssignToScrollBar (FHScroll);
              FHScroll.Repaint;
            end;
        end;
    1 : begin
          FVScrollObj.Assign (aValue);
          if FVScroll <> nil then
            begin
              FVScrollObj.AssignToScrollBar (FVScroll);
              FVScroll.Repaint;
            end;
        end;
  end;
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDCustomMemo.SetTabs (aValue : TLMDTabObject);
begin
  FTabs.Assign (aValue);
end;}

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.SetMargin (aValue : TLMDMarginObject);
begin
  FMargin.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.SetTabChars (aValue : Integer);
begin
  if (aValue <> FTabChars) and (aValue In [1..128]) then
    begin
      FTabChars := aValue;
      PostMessage (Handle, CM_FONTCHANGED, 0, 0);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.SetLineGap (aValue : Integer);
begin
  if (aValue <> FLineGap) then
    begin
      FLineGap := aValue;
      Invalidate;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMemo.GetRowNr : Integer;
begin
  result := FCurrentRow;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMemo.GetColumn : Integer;
begin
  result := FCurrentChar - LA [getRow (FCurrentChar) + 1] + 1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMemo.GetColumns : Integer;
begin
  result := LA [getRow (FCurrentChar) + 2] - LA[getRow (FCurrentChar) + 1];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.CMFontChanged (var Msg : TMessage);
begin
  DoFontChanged;
  Caret.DestroyCaret;
  Caret.FontHeight := RowHeight (''); //returns correct value in TLMDMemo
  Caret.BuildCaret;
//  inherited; //added JH 02.11.99
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.DoFontChanged;
var
  i : Integer;
  s : TLMDString;
  l : TSize;
  aRect : TRect;
begin
  FRowHeight := -1;
  try
    Canvas.Font.Assign (Font);
    SetTextCharacterExtra (Canvas.Handle, Font3D.Tracing);

    for i := 0 to 31 do
      CharWidth[i] := 0;

    for i := 32 to 255 do
      begin
        s := TLMDChar(i);
        {$IFDEF LMD_UNICODE}
        Windows.GetTextExtentPoint32W(Canvas.Handle, {$IFNDEF LMDCOMP12}PWideChar(s){$ELSE}s{$ENDIF}, 1, l);
        {$ELSE}
        Windows.GetTextExtentPoint32A(Canvas.Handle, int_Ref(s), 1, l);
        {$ENDIF}
        CharWidth[i] := l.cx;
        if l.cy > FRowheight then
          FRowHeight := l.cy;
      end;

    s := char(9);
    aRect := Rect (0,0,0,0);
    {.$IFDEF LMDCOMP12}
    {$IFDEF LMD_UNICODE}
    Windows.DrawTextW(Canvas.Handle, PWideChar(s), 1, aRect, DT_CALCRECT or DT_EXPANDTABS or DT_LEFT);
    {$ELSE}
    Windows.DrawTextA(Canvas.Handle, int_Ref(s), 1, aRect, DT_CALCRECT or DT_EXPANDTABS or DT_LEFT);
    {$ENDIF}
    CharWidth[9] := aRect.Right;
  finally
  end;
  //inc (FRowheight, 2);  //moved to RowHeight function
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.ScrollUp (Rows : Integer);
var
  Source, SourceStart : integer;

begin
  //if the FirstChar of the text is already out exit
  if FFirstCharOut = 1 then exit;
  SourceStart := 1; //0->1  VB April 2005
  Source := SourceStart + FFirstCharOut + 1;
  dec (Source, 2); //step backward (#13#10)
  while (Rows > 0) and (Source > SourceStart) do
    begin
      GetPrevLine (Source, SourceStart);
      RowFirst := FFirstRowOut - 1;
      dec (Rows);
    end;
  FFirstCharOut := Source - SourceStart + 1;
  //BTS487 VB Feb 2008
  if FWordWrap and (ScrollBars = skAuto) then
    begin
      ClearBack;
      UpdateVScrollBar;
    end;
  DrawEditText(-1);
end;
{ ---------------------------------------------------------------------------- }
{$IFDEF LMDCOMP12}
procedure TLMDCustomMemo.SaveToFile(const Filename: TLMDString; aEncoding: TEncoding);
var
  tmp: TStringList;
begin
  tmp := TStringList.Create;
  try
    Lines.GetAsStrings(tmp);
    tmp.SaveToFile(Filename, aEncoding);
  finally
   tmp.free;
  end;
end;
{$ENDIF}

procedure TLMDCustomMemo.ScrollDown (Rows : Integer);
var
  Source, SourceEnd : Integer;
begin
  //FRowsDrawnCount - 2 changed to FRowsDrawnCount - 1
  if not FCanScrollDown then exit;  //VB Feb 2008
  if (LA[FRowsDrawnCount-1] >= Length (Text)) and
     (FRowsDrawnCount-1 <> (FTextRect.Bottom - FTextRect.Top) div RowHeight('')) then exit;

  if Rows < FRowsDrawnCount-1 then
    begin
      FFirstCharOut := LA[Rows + 1];
      RowFirst :=  FFirstRowOut + Rows
    end
  else
    begin
      Source := 1; //0->1 VB April 2005
      SourceEnd := Source + Length (FText);
      //jump over the already calculated area
      Source := Source + LA[FRowsDrawnCount-1];
      RowFirst := FFirstRowOut + Rows - 1;
      dec (Rows, FRowsDrawnCount - 1);
      while (Rows > 0) and (Source < SourceEnd) do
        begin
          GetNextLine (Source, SourceEnd);
          dec (Rows);
        end;
      FFirstCharOut := Source  + 1;
    end;
  //BTS487 VB Feb 2008
  if FWordWrap and (ScrollBars = skAuto) then
    begin
      ClearBack;
      UpdateVScrollBar;
    end;
  DrawEditText(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.DoOnVScroll (Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  case ScrollCode of
    scLineUp    : ScrollUp (1);
    scLineDown  : ScrollDown (1);
    scPageDown  : begin
                    ScrollDown (FRowsDrawnCount - 2);
                    DrawEditText (-1);
                  end;
    scPageUp    : ScrollUp (FRowsDrawnCount - 1);
    scPosition  : begin
                    RowFirst := CalcRowNr (ScrollPos);
                    DrawEditText (-1);
                  end;
    scTrack     :;
//    scTop       : FFirstCharOut := 1;
    scBottom    :;
    scEndScroll :;
  end;
  FScrolled := true;
  SetCaret;
  FScrolled := false;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.DoOnHScroll (Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  //if Alignment is center or right or if WordWrap is switched on there
  //is no horizontal scrolling necessary
  if (Alignment <> taLeftJustify) or FWordWrap or (FHiddenLeft = FHScroll.Position) then exit;
  case ScrollCode of
    scLineUp    : FHiddenLeft := FHScroll.Position;//if FHiddenLeft > 0 then Dec (FHiddenLeft) else exit;
    scLineDown  : FHiddenLeft := FHScroll.Position;//Inc (FHiddenLeft);
    scPageUp    : FHiddenLeft := FHScroll.Position;
    scPageDown  : FHiddenLeft := FHScroll.Position;
    scPosition  : begin
                    //if Alignment is center or right or if WordWrap is switched on there
                    //is no horizontal scrolling necessary
                    FHiddenLeft := FHScroll.Position;
                  end;
//    scTrack     : FHiddenLeft := FHScroll.Position;
//    scEndScroll : FHiddenLeft := FHScroll.Position;
  end;
  DrawEditText (-1);
  FScrolled := true;
  SetCaret;
  FScrolled := false;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.Loaded;
begin
  inherited Loaded;
  InitScrollBars;

  DoAlignmentChange; //16.01.01, JH, After everything has been loaded and
                     //initialized we should count the rows ...
end;

{ ------------------------------- protected ---------------------------------- }
procedure TLMDCustomMemo.DoAlignmentChange;
begin
  RowHide := 0;
  RowLength := 0; //longest Row
  RowCounter := CountRows(FText);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.InitScrollBars;
begin
  if Assigned (FHScroll) then
    FHScroll.ThemeMode := self.ThemeMode;
  if Assigned (FVScroll) then
    FVScroll.ThemeMode := self.ThemeMode;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMemo.RowWidth (const s : TLMDString) : LongInt;
var
  Source, SourceEnd : Integer;
  x     : Integer;
  CW    : integer;
  C     : TLMDChar;

begin
  Source := 1;
  SourceEnd := Source + Length(s) - 1;
  x := 0;
  while Source <= SourceEnd do  // Changed 19 Feb 05 VB ('<' -> '<=')
    begin
      C := s[Source];
      CW := GetCharWidth(C);
      if C <> #9 then
        inc (x, CW)
      else
        x := x + CW - (x mod CW);
      inc (Source);
    end;

  result := x;
end;
{ ---------------------------------------------------------------------------- }
function TLMDCustomMemo.RowHeight (s : TLMDString) : LongInt;
begin
  result := FRowHeight + FLineGap;
  if Lined then
    inc (result, FLineStyle.Width);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.CursorPosChanged;
begin
  MakeCursorVisible;
  inherited CursorPosChanged;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.MakeCursorVisible;
var
  cr,
  i : Integer;
begin
  if csDesigning in ComponentState then exit;
  if FCurrentChar < 0 then
    FCurrentChar := 1;
  if (FCurrentChar < LA[1]) then
    begin
      cr := 0;
      FFirstCharOut := CalcCharRowStart (FCurrentChar, cr);
      RowFirst := cr;
      DrawEditText (-1);
      if FFirstCharOut > FCurrentChar then
        ScrollUp(1);
    end;
  if (FRowsDrawnCount >= Low(LA)) and (FCurrentChar > LA[FRowsDrawnCount]) then
    begin
      cr := 0;
      // CalcCharRowStart places row number with given char into cr; first row is 1
      i := CalcCharRowStart (FCurrentChar, cr);

      //if (cr >= Rows) then dec(cr); //VB Oct 2005 (BTS324)
      //RowFirst's range is from 1 to FRows; dec(cr) caused invalid RowFirst
      //after pressing Ctrl+End on any non-last page (BTS324):
      if (cr > Rows) then cr := Rows;

      FFirstCharOut := i;
      FCursorRowStart := i;
      RowFirst := cr;

      //added JH Oct 03
      //without that block the last line will be placed alone on a new page
      //the number of rows could be calculated from the real content of the
      //rows as well - however this here should be somewhat faster ... but
      //if the other way round is required once it should be no problem
      if FCurrentChar >= Length(FText) then
        begin
          //scroll up one page (-1 one row)
          ScrollUp ((FTextRect.Bottom - FTextRect.Top) div RowHeight ('') - 1);
        end;
      if FWordWrap and (ScrollBars = skAuto) then
        begin
          ClearBack;
          UpdateVScrollBar; //BTS487 VB Feb 2008
        end;
      SetCaret;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMemo.getRow(ch : Integer) : Integer;
var
  i : Integer;
begin
  i := 0;
  repeat
   inc(i);
  until ((ch >= LA[i]) and (ch < LA[i+1])) or (i > FRowsDrawnCount+1) or (i = high(LA)-1 );
  //this line is needed for the case of beeing in the last line of the text and the user wants a new row
  if (FText <> '') and (FCurrentChar-1 = Length(Text)) and
     (FText[FCurrentChar - 1] = #10) then
    inc(i);
  result := i - 1;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.SetCaret;
var
  s    : TLMDString;
  r, l, i,
  x, y : Integer;

begin
  if {not Caret.Enabled or}
    (FTextRect.Right = 0) then Exit;
  //if not Focused then exit; removed 20.08.99
  //if the cursor is not in the visible area then disable it and exit
  Caret.Enable;
  s := TLMDString(System.Copy(Text, LA [getRow(FCurrentChar) + 1], LA[getRow(FCurrentChar) + 2]-LA[getRow(FCurrentChar)+1]));
  if (FRowsDrawnCount > 0) and (FCurrentChar >= LA[1])
      and (FCurrentChar < LA[FRowsDrawnCount]) then
    begin
      RowCurrent := getRow (FCurrentChar) + FFirstRowOut;
      FCursorFirst := LA[1];
      FCursorRowFirst := FFirstRowOut;
    end;
  l := 0; //to make the compiler happy ...
  case Alignment of
    taLeftJustify : l := FTextRect.Left;
    taRightJustify : l := FTextRect.Right - RowWidth (s);
    taCenter : l := FTextRect.Left + (FTextRect.Right - FTextRect.Left - RowWidth (s)) div 2;
  end;

  r := getRow (FCurrentChar);
  s := TLMDString(System.Copy(Text, LA [ r + 1], FCurrentChar - LA [ r + 1]));
  x := RowWidth (s) - FHiddenLeft + l;
  //x = text width of line start up current column minus already hidden
  //y := getRow (FCurrentChar) * RowHeight ('');

  if (Alignment = taLeftJustify) and (not FWordWrap) then
    begin

      if x > FTextRect.Right - 2 then
        begin
          if FScrolled then
            begin
              Caret.Disable;
              exit;
            end;

          // * move whole active word to the visible are, not only first char

          i := FCurrentChar;
          //search end of word cursor is currently above
          while (i < Length(FText)) and not LMDCharInSet(FText[i], Delimiters) do
            inc(i);
          //recalculate x with end of word
          x := RowWidth (System.Copy(TLMDString(Text), LA [getRow (FCurrentChar) + 1], i - LA [getRow (FCurrentChar) + 1])) - FHiddenLeft + l;

          x := x - FTextRect.Right + FTextRect.Left;
          RowHide :=  FHiddenLeft + x;
          DrawEditText(-1);
        end;
      if (x < FTextRect.Left) and (FHiddenLeft <> 0) then
        begin
          if FScrolled then
            begin
              Caret.Disable;
              exit;
            end;
          x := Abs(x) + FTextRect.Left;
          RowHide := FHiddenLeft - x;
          if FHiddenLeft < 0 then
            RowHide := 0;
          DrawEditText(-1);
        end;
    end;

  //cursor must be in the visible area (otherwise we would not be here)
  if FScrolled then
    Caret.Enable;

  s := System.Copy(TLMDString(Text), LA [getRow (FCurrentChar) + 1], FCurrentChar - LA [getRow (FCurrentChar) + 1]);
  x := RowWidth ( s ) - FHiddenLeft + l {- 1};
  y := getRow (FCurrentChar) * RowHeight ('');
  Caret.SetCaretPos (x, y + FTextRect.Top);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.SetNewText;
begin
  if not (csLoading in ComponentState) then
    RowCounter := CountRows(FText);
  ChangedText (1);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.GetNewText;
begin
//  Text := FStrings.Text;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMemo.CalcMousePos(Pos : TSmallPoint) : LongInt;
var
  s      : TLMDString;
  r, l   : Integer;
  LS     : integer;
begin
  //are we in the text rect?
  if (Pos.y < FTextRect.Bottom-3) and (Pos.y > FTextRect.Top) then
    begin
      //get row number
      Pos.Y := (Pos.Y - FTextRect.Top) div RowHeight('') + 1;

      if Pos.y > FRows+1 then Pos.y := FRows+1; //added by JH Nov 02, +1 added Oct 03

      if FRowsDrawnCount < Pos.y then
        Pos.y := FRowsDrawnCount;

      if Pos.y < 1 then Pos.y := 1; // Added Feb 05 VB
      //get text of row
      s := System.Copy(Text, LA[Pos.Y], LA[Pos.Y + 1] - LA[Pos.Y] - 1);
      r := 1;
      l := 0; //to make the compiler happy ...
      case Alignment of
        taLeftJustify : l := FTextRect.Left;
        taRightJustify : l := FTextRect.Right - RowWidth (TLMDString(s)) + r;
        taCenter : l := FTextRect.Left + (FTextRect.Right - FTextRect.Left - RowWidth (TLMDString(s)) + r) div 2;
      end;
      r := 0;
      LS := Length(s);
      //get char number inrow
      //and not(s[r] in [#10,#13]) added JH, Oct 03 (otherwise if clicked on the
      //last line with text closed with a line ending char, the cursor was
      //always set to the next row ...)
      while ((r < LS) and (Pos.X + FHiddenLeft > l + RowWidth(TLMDString(System.Copy(s,1, r))) + RowWidth(TLMDString(s[r+1])) div 2)) do
        begin
          if r>0 then
            if LMDCharInSet(s[r], [#10,#13]) then
              break;
          inc(r);
        end;
      //result is set to absolute char index of line start plus number of chars
      result := LA[Pos.Y] + r;
//      if result > Length (Text) then result := Length (Text) +1; removed by JH Nov 02
      if result > Length (FText) then result := Length (FText) + 1;
      if (FRowsDrawnCount>0) then // Added Feb 05 VB
        if (result = LA[FRowsDrawnCount]) and (result < Length(Text)) then
          ScrollDown (1);
    end
  else
    if (Pos.y >= FTextRect.Bottom-3) then
      begin
        result := LA[FRowsDrawnCount] + 1;
        ScrollDown(1);
        SetCaret;
      end
    else
      begin
        ScrollUp(1);
        result := LA[1];
        SetCaret;
      end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMemo.CalcMouseCol(XPos : Integer) : Integer;
begin
  result := 0;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMemo.CalcMouseRow(YPos : Integer) : Integer;
begin
  result := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.ChangedText (At : Integer);
begin
  if FFirstCharOut > Length (FText) then
    begin
      FFirstCharOut := 1;
      FCursorRowStart := 1;
    end;
  inherited ChangedText (At);
  MakeCursorVisible;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.GetCommandKey (var KeyCode : Word; Shift : TShiftState);
var
  i,
  oldsel,
  FOldPos : Integer;
begin
  MakeCursorVisible;
  SetCaret;
  case KeyCode of
    VK_UP   : begin
                if (getRow (FCurrentChar) = 0) and (FFirstCharOut = 1) then exit;
                oldsel := SelLength;
                //number of the current char / row
                FOldPos := FCurrentChar - LA [getRow (FCurrentChar) + 1];
                //FOldPos is 0 is we are on the last, empty line ...
                //i.e. the line before has been closed by #13/#10 and no more
                //text is entered
                if FOldPos < 0 then FOldPos := 0;
                if (getRow (FCurrentChar) = 0) and (FFirstCharOut <> 1) then
                  begin
                    ScrollUp (1);
                    SetCaret;
                  end;
                i := LA [getRow (FCurrentChar)];
                if (FOldPos <> 0) and (FOldPos > LA[getRow (i) + 2] - 2 - LA[getRow (i) + 1]) then
                  FOldPos := LA[getRow (i) + 2] - 2 - LA[getRow (i) + 1];
                CurrentChar := i + FOldPos;
                if oldsel <> SelLength then
                  DrawEditText(FCurrentChar);
              end;
    VK_DOWN : if FCurrentChar < Length(Text) then
              begin
                oldsel := SelLength;
                FOldPos := FCurrentChar - LA [getRow (FCurrentChar) + 1];
                i := LA [getRow (FCurrentChar) + 2];
                if LA[FRowsDrawnCount] = i then
                  begin
                    ScrollDown(1);
                    SetCaret;
                  end;
                if FOldPos > LA[getRow (i) + 2] - 2 - LA[getRow (i) + 1] then
                  if LA[getRow (i) + 2] <> 0 then
                    FOldPos := LA[getRow (i) + 2] - 2 - LA[getRow (i) + 1]
                  else
                    FOldPos := 0;
                if FOldPos >= 0 then
                  begin
                    CurrentChar := i + FOldPos;
                    if oldsel <> SelLength then
                      DrawEditText (FCurrentChar);
                  end;
                if FCurrentChar > Length(Text) then
                  begin
                    CurrentChar := Length(Text)+1; //+1 added Oct. 03, otherwise
                                                 //last (empty line was not
                                                 //reachable

                    //a small problem is remaining ...
                    //: if there is nothing in the last line (not closed line)
                    //the view will not scroll properly ... However the cursor
                    //is there and the input will be accepted ... :-(
                    //so its an optical problem not a "functional" one
                  end;
              end;
    VK_TAB : if FWantTabs then SelText := #9;
    VK_RETURN : if (not TabOnEnter) or (emCtrl in LMDApplication.EditMode) then
                  begin
                    //if (FCurrentchar = Length(FText)) then  //vb jul 2005
                    //  CurrentChar := CurrentChar + 1;
                    //we need to scroll
                    if (FCurrentChar+2 = LA[(FTextRect.Bottom - FTextRect.Top) div RowHeight ('')+1]) then
                      begin
                        FFirstCharOut := LA[2];
                        inc (FFirstRowOut); //added March 2001, JH
                      end;
                    //insert linebreak
                    SelText := #13+#10;
                    //do we need to scroll?
                    FCursorRowStart := LA[getRow (FCurrentChar)+1];
                    SetCaret;
                  end;
    VK_PRIOR : begin
                 oldSel := SelLength;
                 i := getRow (FCurrentChar) + 1;
                 FOldPos := FCurrentChar - LA [getRow (FCurrentChar) + 1];
                 ScrollUp (FRowsDrawnCount - 2);
                 if LA[i+1] - LA[i] < FOldPos then
                   FOldPos := LA[i+1] - LA[i] - 1;
                 CurrentChar := LA[i] + FOldPos;
                 if oldsel <> SelLength then
                   DrawEditText (FCurrentChar);
               end;
    VK_NEXT :  begin
                 oldSel := SelLength;
                 //save the current row nr
                 i := getRow (FCurrentChar) + 1;
                 //get the current column
                 FOldPos := FCurrentChar - LA [getRow (FCurrentChar) + 1];
                 //scroll down one page
                 ScrollDown (FRowsDrawnCount-2);
                 if i > FRowsDrawnCount then i := FRowsDrawnCount;
                 //if old column > length new row set column to row length
                 if LA[i+1] - LA[i] < FOldPos then
                   FOldPos := LA[i+1] - LA[i] - 1;
                 if LA[i] < Length (FText) then
                   CurrentChar := LA[i] + FOldPos
                 else
                   CurrentChar := Length(FText);
                 //if the selection has changed we need to repaint the text
                 if oldsel <> SelLength then
                   DrawEditText (FCurrentChar);
               end;
    VK_LEFT  : begin
                 if (LA[1] = FCurrentChar) and (LA[1] > 1) then
                   ScrollUp (1);
               end;
    VK_BACK : if SelLength > 0 then
                  begin //needed for deleting text above the first visible row
                    oldsel := SelLength;
                    if FSelStart < LA[1] then
                      CurrentChar := FSelStart;
                    SelLength := oldsel;
                  end
                else //there is no selected text
                  begin
                    //if we are on the first visible char
                    if (LA[1] = FCurrentChar) and (LA[1] > 1) then
                      ScrollUp (1);
                    //if we are on the first char of a row
                    if LA[getRow(FCurrentChar)+1] = FCurrentChar then
                      Rowfirst := RowFirst+1;
                  end;
    VK_RIGHT : begin
                 if FCurrentChar > Length(Text) then //vb 2008
                   CurrentChar := Length(Text);

                 if (FCurrentChar+2 >= LA[FRowsDrawnCount]) and
                    (FCurrentChar < Length(Text)) then
                   begin
                     ScrollDown(1);
                     SetCaret;
                   end;
                   FCursorRowStart := LA[getRow (FCurrentChar)+1];
               end;
    VK_END : begin
               if emCtrl in LMDApplication.EditMode then
                 begin
                   //all rows - first visible one - rows visible + 2 because of firstrow = 1
{                   ScrollDown (Rows - FFirstRowOut - FRowsDrawnCount +  2);
                   CurrentChar := LA[FRowsDrawnCount - 2];}
                   CurrentChar := Length(FText);
//                   ScrollUp ((FTextRect.Bottom - FTextRect.Top) div RowHeight ('Qp'));
                   CurrentChar := CurrentChar+1;
                   DrawEditText (-1);  // March 05 VB
                 end;
             end;
{    VK_HOME : if emCtrl in LMDApplication.EditMode then

                ScrollUp (FFirstRowOut);}
  end;

  inherited GetCommandKey (KeyCode, Shift);

  //BTS487 VB Feb 23, 2008
  if FWordWrap and (ScrollBars = skAuto) and
    (KeyCode in [VK_BACK, VK_DELETE]) then
    UpdateVScrollBar;

  // every key stroke centers the text back to actual cursor pos
  FCursorRowStart := LA[getRow (FCurrentChar)+1];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.HandleInsertText (at : Integer; var aValue : TLMDString);
var
  cs   : TLMDString;
  i, j : Integer;
begin
{  //get the text from the linestart, add the new
  cs := Copy (FText, LA [getRow(FCurrentChar) + 1], FCurrentChar - LA [getRow(FCurrentChar) + 1]) + aValue;
  //increase the number of rows by the inserted ones}

  //get the pos where the current paragraph starts
  i := at;
  j := at;
  if FText <> '' then
    begin
      while (i > 0) do
        begin
          if i <= length(FText) then // Feb 05 VB
            if (FText[i] = #10) then break;
          dec(i);
        end;
      //get the pos where the current paragraph ends
      while (j < Length(FText)) and (FText[j] <> #13) do
        inc(j);
    end;
  cs := System.Copy(FText, i, at - i) + aValue + System.Copy(FText, at, j - at);
  //FWorkRowCount instead of FRows, FWorkRowCount is calculated in
  //HandleReplaceText which is executed whenever a char has been inserted!
  RowCounter := FWorkRowCount + countRows (cs);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.HandleReplaceText (at : Integer; aValue : TLMDString);
var
  h : Integer;
  i, j : Integer;
begin
  //if there is no text replaced we do not to do something
  //if aValue = '' then exit;
{  //get the whole line (so we can see whether the replace text is longer than one line or not)
  aValue := Copy (FText, LA [getRow(FCurrentChar) + 1], FCurrentChar - LA [getRow(FCurrentChar) + 1]) + aValue;}

  if at <> 1 then
    i := at-1
  else
    i := at;
  if FText <> '' then
    begin
      while (i > 0) do
        begin
          if i <= Length(FText) then // Feb 05 VB
            if (FText[i] = #10) then break;
          dec(i);
        end;
      //if we will not stay on the prev paragraph we'll have to add one :-)
      inc(i);
    end;
  //get the pos where the current paragraph ends
  j := at + Length (aValue); //there could be more than one paragraph to be replaced
  while (j < Length(FText)) and (FText[j] <> #13) do
    inc(j);
  //get the whole paragraphs where (maybe parts) have to be replaced
  //HandleInsertText has to work on the whole paragraph too ...
  aValue := System.Copy(FText, i, j - i);

  //count the rows
  h := countRows (aValue);
  //the following line has been removed by JH, Oct 03
  //removable seems to habe no side effects, however a further problem with the
  //vertical scrollbar is removed (position problem)
  //RowFirst := FFirstRowOut - h {+ getRow (FCurrentChar)};

  //RowCounter replaced by FWorkRowCount, buffer the result otherwiese the scrollbar
  //will flicker heavily
  FWorkRowCount := FRows - h;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.DoThemeChanged;
begin
  InitScrollBars;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.AlignControls (AControl: TControl; var Rect: TRect);
var
  lDelta: integer;
begin
  inherited AlignControls (AControl,Rect);
  lDelta:= 0;
  if UseThemeMode <> ttmNative then
    lDelta := 1;
  if FVScroll <> nil then
    begin
      FVScroll.Top := GetBevel.BevelExtend + lDelta;
      FVScroll.Left := ClientWidth - FVScroll.Width - GetBevel.BevelExtend - lDelta;
      if (FHScroll <> nil) and ((FHScroll.Visible) or (csDesigning in ComponentState)) then
        FVScroll.Height := ClientHeight - GetBevel.BevelExtend * 2 - FHScroll.Height - lDelta
      else
        FVScroll.Height := ClientHeight - GetBevel.BevelExtend * 2 - lDelta;
    end;
  if FHScroll <> nil then
    begin
      FHScroll.Left := Bevel.BevelExtend + lDelta;
      FHScroll.Top := ClientHeight - FHScroll.Height - GetBevel.BevelExtend - lDelta;
      if (FVScroll <> nil) and ((FVScroll.Visible) or (csDesigning in ComponentState)) then
        FHScroll.Width := ClientWidth - FVScroll.Width - GetBevel.BevelExtend * 2 - lDelta
      else
        FHScroll.Width := ClientWidth - GetBevel.BevelExtend * 2 - lDelta;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMemo.GetClientRect : TRect;
begin
  result := inherited GetClientRect;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if FWantTabs then
    Message.Result := Message.Result or DLGC_WANTTAB
  else
    Message.Result := Message.Result and not DLGC_WANTTAB;
  if not FWantReturns then
    Message.Result := Message.Result and not DLGC_WANTALLKEYS
  else
    Message.Result := Message.Result or DLGC_WANTALLKEYS;
end;

{ -------------------------------- public ------------------------------------ }
constructor TLMDCustomMemo.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FStrings := TLMDMemoStrings.CreateExt (self);
  FVScroll := nil;
  FHScroll := nil;

  FVScrollObj := TLMDScrollBarObject.Create;
  FVScrollObj.OnChange := GetChange;
  FHScrollObj := TLMDScrollBarObject.Create;
  FHScrollObj.OnChange := GetChange;

  FScrollBars := skNone;

  FWordWrap := true;
  FCanScrollDown := false;
  FWantTabs := false;
  FWantReturns := true;

//  FTabs := TLMDTabObject.Create;

  FOldCurrentRow := 0;
  FOldFirstRow := 0;
  FOldHiddenLeft := 0;

  FHideLeftRight := 0;
  RowHide := 0;
  RowLength := 0;
  RowCounter := 0;
  RowFirst := 1;
  FFirstCharOut := 1;
  FCursorRowStart := 1;
  FTabChars := 8;

  FVScrollFactor := 0;

  FLineStyle := TPen.Create;
  FLineStyle.OnChange := GetChange;
  FLined := false;

  Delimiters := [' ',#10,#13,',',';','.','!','?',#9,'='];

  FScrolled := false;
  FSoftLineBreak := false;

  FMargin := TLMDMarginObject.Create;
  FMargin.OnChange := GetChange;
  FRowHeight := -1;
  FLineGap := 2;

  //make the control looking like a memo
  Width := 185;
  Height := 89;

end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomMemo.Destroy;
begin

  FMargin.OnChange := nil;
  FMargin.Free;
//  FTabs.Free;
  //delete scrollbars
  ScrollBars := skNone;
  FHScrollObj.OnChange := nil;
  FHScrollObj.Free;
  FVScrollObj.OnChange := nil;
  FVScrollObj.Free;
  if FHScroll <> nil then
    FHScroll.Free;
  if FVScroll <> nil then
    FVScroll.Free;
  FLineStyle.Free;
  FStrings.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.DrawEditText(from : Integer);
var
  Source,
  HelpSource,
  RowStart,
  SourceEnd   : integer;  //pointers for stepping through the text
  y, x,
  count       : Integer;
  s           : TLMDString; //the current text which has to be drawn
  aRect       : TRect;
  rh          : HRGN;
  doPaint     : Boolean;
  myCanvas    : TCanvas;
  C           : TLMDChar;
  CW          : integer;

   //OutText draws the given line of text regarding selection
   //and alignment
   procedure OutText(const s : TLMDString);
   var
     ss, se,
     x1, x2, j,
     y2 : Integer;
     hRect : TRect;
   begin
     ss := 0; se := 0; x1 := 0; x2 := 0;
     case Alignment of
       taLeftJustify : hRect.Left := aRect.Left;
       taRightJustify : hRect.Left := aRect.Right - RowWidth (s);
       taCenter : hRect.Left := aRect.Left + (aRect.Right - aRect.Left - RowWidth (s)) div 2;
     end;
     y2 := y + RowHeight ('');
     if y2 = 0 then
      y2 := RowHeight ('');

     //do not repaint the lines (avoid flicker)
     if Lined then
     begin
       y2 := y2 - FLineStyle.Width;
//         y := y - FLineStyle.Width div 2;
     end;

    //check for bottom paint border
    if y2 > aRect.Bottom then
      y2 := aRect.Bottom;

    //restore the background of the current line
    RepaintBack(Rect(aRect.Left, y, aRect.Right, y2));

    if (SelLength <> 0) and (not FNoSelection) and
        (
         ((SelStart >= LA[count]) and (SelStart < LA[count + 1]))
          or
         ((SelStart + SelLength > LA[count]) and (SelStart < LA[count]))
        ) then
    begin
       ss := 0; // Selection Start
       se := 0; //Selection End
       x1 := -1;
       x2 := -1;

       if s = '' then
       begin
         x1 := hRect.Left;
         x2 := hRect.Left+3;
       end;

       for j := 1 to Length (s) do
       begin //step through the OutputText
         if (LA[count] + j -1 >= SelStart) and (ss = 0) then
         begin
           ss := j ;
           if j <> 1 then
             x1 := RowWidth (System.Copy(s, 1, j-1)) + hRect.Left
           else
             x1 := hRect.Left;
           x2 := x1;
         end;
         if (LA[count] + j - 1 <= SelStart + SelLength - 1 ) then
         begin
           x2 := RowWidth (System.Copy(s, 1, j)) + hRect.Left;
           se := j - ss + 1;
         end;
       end;

       myCanvas.Brush.Color := HighLightBack;

       if x2 > aRect.Right then
        x2 := aRect.Right;
       if x1 <> -1 then //to avoid an error by linebreaks
         myCanvas.FillRect(Rect(x1, y, x2, y2));
     end;

     myCanvas.Font.Color := GetThemedTextColor;
     myCanvas.Refresh;
     LMDDrawTextExt(myCanvas, {$IFDEF LMDCOMP12}String{$ENDIF}(s), Font3D, Rect (hRect.Left, y, aRect.Right, y2),
                    DT_SINGLELINE or DT_EXPANDTABS or DT_NOPREFIX,
                    [TLMDDrawTextStyle(Enabled)], nil);

     if (SelLength <> 0) and not FNoSelection and (x1 <> -1) then
     begin
       myCanvas.Font.Color := HighLightText;
       LMDDrawTextExt(myCanvas, {$IFDEF LMDCOMP12}String{$ENDIF}(System.Copy(s, ss, se)), Font3D,
                      Rect (x1, y, x2, y2),
                      DT_SINGLELINE or DT_EXPANDTABS or DT_NOPREFIX,
                      [TLMDDrawTextStyle(Enabled)], nil);
     end;

     if Assigned (FOnMarginRowPaint) then
       FOnMarginRowPaint (self, myCanvas, Rect (FMarginRect.Left + 2, y,
          FMarginRect.Right -1, y2), LA[count],Length(s));
   end;

begin
  rh := 0;

  //get the right canvas to draw on
  if (FOutBuffered and (FBack <> nil)) then
    myCanvas := FBack.Canvas
  else
    myCanvas := Canvas;

  //assign the correct font for the output
  myCanvas.Font.Assign(Font);

  //reset the line starts array
  for y := 1 to LMDMaxVisibleLines do
    LA[y] := 0;

  //disable the caret (it could harm the text output)
  Caret.Disable;

  //paint the margin (if width = 0) nothing is painted
  PaintMargin(myCanvas);

  //get the rect for the text
  aRect := FTextRect;

  if (aRect.Left = 0) and (aRect.Top = 0) and(aRect.Right = 0) and(aRect.Bottom = 0)then
  begin
    if Focused then
      Caret.Enable;
    Exit;
  end;

  //if there is no text repaint back, set default values and get out
  if Length(FText) = 0 then
  begin
    //there is no text to be displayed so clear the whole visible area (excluding visible lines)
    ClearBack;

    LA[1] := 1;
    LA[2] := 3;

    if (FOutBuffered and (FBack <> nil)) then
      Canvas.CopyRect (FPaintRect, FBack.Canvas, FPaintRect);
    //just leave the DrawText procedure
    Exit;
  end;

  //just a check for the correctness of the var ...
  if FFirstCharOut = 0 then
    FFirstCharOut := 1; //otherwise the cursor willnot be where it should be

  try
    Source := FFirstCharOut;
    //FFirstCharOut is > 1 therefore we need to sub 1

    SourceEnd := Source + Length(FText) - FFirstCharOut + 1 ; // Feb 05 VB

    //get the top value of the text rect (y = rowstart)
    y := aRect.Top;

    //first row will be drawn
    count := 1;

    //save the first char out in LA[1]
    LA[1] := FFirstCharOut;

    //if there is hidden text (wordwrap = false; Alignment = taLeftJustify; line longer than visible area, cursor out of normal visible area)
    if FHiddenLeft <> 0 then
    begin
      //create a region where the text will be clipped
      with aRect do
        rh := CreateRectRgn(Left, Top, Right, Bottom);
      SelectClipRgn(myCanvas.Handle, rh);
      //set the left text border to a value (mostly < 0)
      Dec(aRect.Left, FHiddenLeft);
    end;

    // while not out of the visible area and not at the end of the text
    while (y < aRect.Bottom - RowHeight ('')) and (Source < SourceEnd) do // Changed 19 Feb 05 VB
    begin
      //remember a pointer to the first char in the new Row
      RowStart := Source;
      doPaint := true;
      x := 0;
      //search max text length or line break
      repeat
        C  := TLMDChar(FText[Source]);
        CW := GetCharWidth(C);
        if C <> #9 then
          x := x + CW
        else
          x := x + CW - (x mod CW);
        inc(Source);
      until LMDCharInSet(C, [#10]) or (Source >= SourceEnd) or //Feb 05 VB
            ((x >= aRect.Right - aRect.Left) and ((FWordWrap) or (Alignment <> taLeftJustify)));

      if Source <= Length(FText) then // Added after port to .net Feb 05 VB
        if FText[Source] = #10 then
          dec (Source);

      //if we have to break the line
      if (x >= (aRect.Right - aRect.Left)) and ((FWordWrap) or (Alignment <> taLeftJustify)) then
      begin
        dec (Source);
        //search for a delimiter to break line there
        HelpSource := Source;
        while not LMDCharInSet(FText[HelpSource], Delimiters)
            and (HelpSource > RowStart) do
          dec(HelpSource);
        if LMDCharInSet(FText[HelpSource], Delimiters) then
          inc (HelpSource);
        //if there is a delimiter then break there otherwise paint as much chars as possible
        if HelpSource > RowStart then
        begin
          Source := HelpSource;
          if Source > Length(FText) then
            Source := Length(FText);
        end;
         C := TLMDChar(FText[Source]);
        if C = #10 then
          inc(Source);
      end; // end of if WordWrapping
      s := '';
      HelpSource := RowStart;
      while HelpSource < Source do
      begin
        if FText[HelpSource] > #31 then
          s := s + TLMDString(FText[HelpSource])
        else
          if FText[HelpSource] = #9 then
            s := s + #9;
        inc (HelpSource);
      end;
      //jump over line break
      (*if Source <= Length(FText) then // Commented out March 05 VB
        if FText[Source] = #13 then
          inc(Source);  *)
      //save chars up to the current output
      LA[count+1] := Source - RowStart + LA[count];
      //paint the text
      if doPaint then
        OutText (s);
      //next output y coordinate (for next row)
      y := y + RowHeight ('');
      //inc the line counter
      inc(count);
      //if we reached the end of the text
      if Source >= SourceEnd then // VB
      begin
        inc (LA[count], 2);
        LA[count+1] := LA[count] + 2;
        inc(count);
      end;
    end; //end of while y < ...
    FCanScrollDown := (y >= aRect.Bottom - RowHeight ('')) and (Source < SourceEnd);
    FRowsDrawnCount := count;
    //are we at the end of the text (with the output) ?
    FTextEnd := (Source >= SourceEnd); // VB
    //delete the rest of the visible area (could contain text due to deleted lines)
    if FTextEnd then
      //if we have to watch out for lines
      if lined then
        //while there is space for other rows
        while y + RowHeight('') < aRect.Bottom do
        begin
          RepaintBack(Rect(aRect.Left, y, aRect.Right, y+ RowHeight('')-FLineStyle.Width));
          Inc(y, RowHeight (''));
        end
      else
        RepaintBack(Rect(aRect.Left, y, aRect.Right, aRect.Bottom));
    //if the output runs through a buffer we have to paint it on the visible canvas
    if (FOutBuffered and (FBack <> nil)) then
      Canvas.CopyRect(FPaintRect, FBack.Canvas, FPaintRect);
  finally
    //if there was FSpecialText to be hidden delete the clipping region
    if FHiddenLeft <> 0 then
    begin
      SelectClipRgn(myCanvas.Handle, 0);
      DeleteObject(rh);
    end;
  end;

  if Focused then
    Caret.Enable;

  FOldCurrentRow := FCurrentRow;
  FOldFirstRow := FFirstRowOut;
  FOldHiddenLeft := FHiddenLeft;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.PaintMargin(toCanvas : TCanvas);
begin
  if FMargin.Width <> 0 then
    begin
      if FMargin.FillObject.Style = sfNone then
        RepaintBack (FMarginRect)
      else
        FMargin.FillObject.FillCanvas (toCanvas, FMarginRect, Color);
      if FMargin.Alignment = maLeft then
        begin
          toCanvas.Pen.Color := clWhite;
          toCanvas.MoveTo (FMarginRect.Right - 2, FMarginRect.Top);
          toCanvas.LineTo (FMarginRect.Right - 2, FMarginRect.Bottom);
          toCanvas.Pen.Color := clGray;
          toCanvas.MoveTo (FMarginRect.Right - 1, FMarginRect.Top);
          toCanvas.LineTo (FMarginRect.Right - 1, FMarginRect.Bottom);
        end
      else
        begin
          toCanvas.Pen.Color := clWhite;
          toCanvas.MoveTo (FMarginRect.Left + 1, FMarginRect.Top);
          toCanvas.LineTo (FMarginRect.Left + 1, FMarginRect.Bottom);
          toCanvas.Pen.Color := clGray;
          toCanvas.MoveTo (FMarginRect.Left, FMarginRect.Top);
          toCanvas.LineTo (FMarginRect.Left, FMarginRect.Bottom);
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.EMFMTLINES (var Message : TMessage);
begin  //EM_FMTLINES
  //only affects WM_GETTEXT and EM_GETHANDLE
  //will return #13#13#10 for a linebreak due to wordwrapping
  FSoftLineBreak := Boolean (Message.wParam);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.EMGETFIRSTVISIBLELINE (var Message : TMessage);
begin  //EM_GETFIRSTVISIBLELINE
  //first (zero based) line index or first (zero based) char index (single line edits)
  //should be overwritten by descendant classes!!
  Message.result := FirstRow;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.EMGETHANDLE (var Message : TMessage);
begin //EM_GETHANDLE
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.EMGETLINE (var Message : TMessage);
var
  s : TLMDString;
  i,i2 : integer;

begin  //EM_GETLINE
  if  message.lparam = 0  then
    begin
      Message.result := 0;
      exit;
    end;
  //retrieves the content of the line given in wParam to the adress in lParam
  i := calcRowStart (Message.wParam);
  i2 := calcRowStart (Message.wParam+1);
  s := System.Copy(FText, i+1 , i2-i-1);
//  s := Lines[Message.wParam];

  CopyMemory (Pointer(message.lparam), Pointer (s), Length(s));

  //result contains the amount of chars copied
  Message.result := Length(s);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.EMGETLINECOUNT (var Message : TMessage);
begin  //EM_GETLINECOUNT
  Message.result := Rows; //16.01.00, JH +1 added, otherwise Addict will not
                              //parse the last line
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.EMGETMARGINS (var Message : TMessage);
begin  //EM_GETMARGINS
  //left margin in loResult, right margin in hiResult
  Message.result := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.EMGETTHUMB (var Message : TMessage);
begin //EM_GETTHUMB
  //returns position of scrollbar thumb
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.EMLINEFROMCHAR (var Message : TMessage);
begin  //EM_LINEFROMCHAR
  case Message.wParam of
  {$ifdef LMDCOMP16}
  $7FFFFFFF
  {$else}
  -1
  {$endif}
   : {ich} Message.result := CalcRowFromChar (SelStart)
    else
      Message.result := CalcRowFromChar (Message.wParam);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.EMLINEINDEX (var Message : TMessage);
begin  //EM_LINEINDEX
  //absolute char nr of line
  case Message.wParam of
  {$ifdef LMDCOMP16}
  $7FFFFFFF
  {$else}
  -1
  {$endif}
   : {return index of current line} Message.Result := RowCurrent;
  else //return index of line specified in wParam
    Message.Result := CalcRowStart (Message.wParam);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.EMLINELENGTH (var Message : TMessage);
begin  //EM_LINELENGTH
  case Message.wParam of
  {$ifdef LMDCOMP16}
  $7FFFFFFF
  {$else}
  -1
  {$endif}
  //amount of unselected chars in the current row
     : Message.result := 0;
   else
     Message.result := Columns;
   end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.EMLINESCROLL (var Message : TMessage);
var
  i : WPARAM;
begin  //EM_LINESCROLL
  if Message.LParam > 0 then
    ScrollDown (Message.LParam)
  else
    ScrollUp (Abs(Message.LParam));  // RM Apr 2005, Abs added
  i := 1;
  if Message.WParam > 0 then
    while (Column < RowLength) and (i < Message.WParam) do
      begin
        inc(i);
        CurrentChar := CurrentChar + 1
      end
  else
    while (Column > 1) and (i < {$IFDEF LMDCOMP16}Message.WParam{$ELSE}Abs(Message.WParam){$ENDIF}) do
      begin
        inc(i);
        CurrentChar := CurrentChar - 1
      end;
  Message.result := Integer (true);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.EMPOSFROMCHAR (var Message : TMessage);
var
  firstChar,
  inRow,
  fromPos,
  x,y : Integer;

begin  //EM_POSFROMCHAR
  y := FTextRect.Top;
  x := FTextRect.Left;
  //if (Message.lParam < LA[1]) {< first visible char}
  //    or (Message.lParam > LA[FRowsDrawnCount]) {> last visible char} then
  if Message.lParam > Length(FText) then exit; //
  //lParam should contain the value -> RichEdit behaviour
  //wParam contains result pointer!!
  fromPos := Message.lParam;
  firstChar := CalcCharRowStart (fromPos, inRow);
  inRow := inRow - FirstRow;
  //16.01.01, JH added * inRow -> before the return value was always top of the
  //text rect + font height ...
  y := y + RowHeight ('') * inRow;
  x := x + RowWidth (System.Copy(TLMDString(FText), firstChar, fromPos - FirstChar + 1)) - FHiddenLeft;
  Message.Result := MakeLong(x, y);

  if (Message.wParam <> 0) then //let's assume that we behave as RichEdit!!

//  if (Message.lParam <> 0) then //let's assume that we behave as RichEdit!!
  PPoint(Message.wParam)^ := Point(X,Y);

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.EMSCROLL (var Message : TMessage);
begin  //EM_SCROLL
  case Message.wParam of
  SB_LINEDOWN : ScrollDown (1);
    SB_LINEUP : ScrollUp (1);
    SB_PAGEDOWN : ScrollDown (5);
    SB_PAGEUP : ScrollUp (5);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.EMSCROLLCARET (var Message : TMessage);
begin  //EM_SCROLLCARET
  //makes the caret visible (if its outside the displayable area)
  MakeCursorVisible;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.EMSETMARGINS (var Message : TMessage);
begin  //EM_SETMARGINS
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.EMSETTABSTOPS (var Message : TMessage);
begin //EM_SETTABSTOPS
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.Paint;
var
  y : integer;
  myCanvas : TCanvas;
begin
  inherited Paint;

  if FRowHeight = -1 then
    doFontChanged;

{  if (FHScroll <> nil) and (FVScroll <> nil) then
    begin
      RepaintBack (Classes.Rect (FVScroll.Left, FVScroll.Top+FVScroll.Height,
                         FHScroll.Left + FHScroll.Width + FVScroll.Width, FHScroll.Top + FHScroll.Height));
    end;}

  if (FOutBuffered) and (FBack <> nil) then
    myCanvas := FBack.Canvas
  else
    myCanvas := Canvas;

  PaintMargin(myCanvas);
{  FBack.Width := FTextRect.Right - FTextRect.Left;
  FBack.Height := FTextRect.Bottom - FTextRect.Top;}

  RepaintBack(FInnerRect); //needed to avoid non - painted areas
                            //was commented out: reenabled by JH Jan 2002

  if Lined then
  begin
    y := FTextRect.Top + RowHeight ('');
    while y < FTextRect.Bottom do
    begin
      y := y - FLineStyle.Width div 2;
      myCanvas.Pen.Assign (FLineStyle);
      myCanvas.MoveTo (1, y-1);
      myCanvas.LineTo (FTextRect.Right {- FTextRect.Left} - 1, y-1);
      y := y + FLineStyle.Width div 2;
      Inc(y, RowHeight (''));
    end;
  end;

  DrawEditText(-1);
  //UpdateVScrollBar; //VB April 2005 <- removed VB Feb 2008 (causes drawing artefacts)
  SetCaret; //caret will be placed after first paint to the right pos - added 07.09.99
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.ModifyTextRect;
begin
  UpdateVScrollBar; //VB aug 2005

  if FMargin.Alignment = maLeft then
    begin
      FMarginRect := Rect (FPaintRect.Left - 2, FPaintRect.Top - 2, FPaintRect.Left + FMargin.Width - 2, FPaintRect.Bottom + 2);
      inc (FTextRect.Left, FMargin.Width);
    end
  else
    begin
      FMarginRect := Rect (FPaintRect.Right - FMargin.Width + 2, FPaintRect.Top - 2, FPaintRect.Right + 2, FPaintRect.Bottom + 2);
      dec (FTextRect.Right, FMargin.Width);
    end;

{  if (FHScroll <> nil) and (FHScroll.Visible) then
    dec (FMarginRect.Bottom, FHScroll.Height);
  if (FVScroll <> nil) and (FVScroll.Visible) then
     if FMargin.Alignment = maRight then
        OffSetRect (FMarginRect, -FVScroll.Width, 0); }

  //s.o. could load text before the memo is painted for the first time => no rows can be calculated ...
  RowLength := 0;
  RowCounter := countRows (FText);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.ModifyPaintRect;
begin
  if (FHScroll <> nil) and (FHScroll.Visible) then
    begin
      dec (FPaintRect.Bottom, FHScroll.Height{+ 4});
      FHScrollObj.AssignToScrollBar (FHScroll);
      FHScroll.RePaint;
    end;
  if (FVScroll <> nil) and (FVScroll.Visible) then
    begin
      dec (FPaintRect.Right, FVScroll.Width {+ 4});
      FVScrollObj.AssignToScrollBar (FVScroll);
      FVScroll.RePaint;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMemo.CalcCharRowStart (pos : Integer;var crow : Integer) : Integer;
var
  HelpSource,
  RowStart,
  Source,
  SourceEnd : Integer;
  breakline : Boolean;
  j, k, r   : Integer;
begin
  crow := 0;
  result := 1;
  if Length(FText) = 0 then exit;
  if pos > Length(FText) then pos := Length(FText);
  Source := 1;
  RowStart := Source;
  j := FTextRect.Right - FTextRect.Left;
  if j <= 0 then exit;
  breakline := FWordWrap or (Alignment <> taLeftJustify);
  r := 0;
  k := 0;
  SourceEnd := Source + pos;
  while Source <= SourceEnd do   // Feb 05 VB
    begin
      if (k > j) and (breakline) then
        begin
          dec (Source);
          HelpSource := Source;
          while (HelpSource > RowStart)
            and not LMDCharInSet(FText[HelpSource], Delimiters) do
            dec (HelpSource);
          if HelpSource > RowStart then
            Source := HelpSource;
          inc (r);
          k := 0;
          RowStart := Source;
        end;
      if Source <= Length(FText) then // Added March 05 VB
        if FText[Source] = #13 then
          begin
            inc(Source);
            inc(r);
            k := 0;
            Rowstart := Source;
          end;
      if Source <= Length(FText) then // Added March 05 VB
        begin
          if FText[Source] <> #9 then
            k := k + GetCharWidth(FText[source])
          else
            k := k + CharWidth[9] - k mod CharWidth[9];
        end;
      inc(Source);
    end; //while
  //return the line number of the pos
  crow := r + 1;
  result := RowStart + 1;
  if result<=length(FText) then // Added Feb 05 VB
    if (FText[result] = #10) then
      inc(result)
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMemo.CalcRowNr (pos : Integer) : Integer;
var
  RowStart,
  Source,
  SourceEnd : Integer;
  r   : Integer;
begin
  result := 0;
  if pos > Length(FText) then exit;
  Source := 0;
  RowStart := Source;
  r := 0;
//  if pos < Length (FText) div 2 then //search from top
    begin
      SourceEnd := Source + Length (FText);
      while (Source < SourceEnd) and (r < pos) do
        begin
          RowStart := Source;
          GetNextLine (Source, SourceEnd);
          inc(r);
        end;
    end;
  FFirstCharOut := RowStart;  // VB april 2005
  result := r;
end;

{ ---------------------------------------------------------------------------- }
(*
function TLMDCustomMemo.CalcRowFromChar (pos : Integer) : Integer;
var
  Source,
  SourceEnd : PChar;
  r   : Integer;
begin
  result := 0;
  if pos > Length(FText) then exit;
  Source := Pointer(FText);
  r := 0;
//  if pos < Length (FText) div 2 then //search from top
    begin
      //+1, take one char more (does not matter if we are in a line but helps if we are on the first char of the line)
      SourceEnd := Source + pos + 1;
      while (Source < SourceEnd) do
        begin
          GetNextLine (Source, SourceEnd);
          inc(r);
        end;
    end;
{  else //search from bottom
    begin
      SourceEnd := Source + cp;
      Source := Source + Length (Text);
    end;}
  result := r-1; //we need a zero based line index for the EM_XXX messages ...
end;
*)
function TLMDCustomMemo.CalcRowFromChar (pos : Integer) : Integer;
var
  Source,
  SourceEnd : Integer;
  r   : Integer;
begin
  result := 0;
  if pos > Length(FText) then exit;
  Source := 0;
  r := 0;
//  if pos < Length (FText) div 2 then //search from top
    begin
      //+1, take one char more (does not matter if we are in a line but helps if we are on the first char of the line)
      SourceEnd := Source + pos + 1;
      while (Source < SourceEnd) do
        begin
          GetNextLine (Source, SourceEnd);
          inc(r);
        end;
    end;
{  else //search from bottom
    begin
      SourceEnd := Source + cp;
      Source := Source + Length (Text);
    end;}
  result := r-1; //we need a zero based line index for the EM_XXX messages ...
end;

{ ---------------------------------------------------------------------------- }
(*
function TLMDCustomMemo.CalcRowStart (row : Integer) : Integer;
var
  i : Integer;
  Source, SourceEnd : PChar;
begin
  result := 0;
  Source := Pointer (FText);
  SourceEnd := Source + Length(FText);
  i := 0;
  while (Source < SourceEnd) and (i < row) do
    begin
      GetNextLine (Source, SourceEnd);
      inc(i);
    end;
  if i = row then
    result := Source - Pointer(FText);
end;
*)
function TLMDCustomMemo.CalcRowStart (row : Integer) : Integer;
var
  i : Integer;
  Source, SourceEnd : Integer;
begin
  result := 0;
  Source := 0;
  SourceEnd := Source + Length(FText);
  i := 0;
  while (Source < SourceEnd) and (i < row) do
    begin
      GetNextLine (Source, SourceEnd);
      inc(i);
    end;
  if i = row then
    result := Source;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.GetNextLine (var LineStart : Integer; TextEnd : Integer);
var
  breakline : Boolean;
  j, k, r   : Integer;
  RowStart,
  HelpSource : Integer;
begin
  j := FTextRect.Right - FTextRect.Left;
  if j <= 0 then exit;
  breakline := FWordWrap or (Alignment <> taLeftJustify);
  r := 0;
  k := 0;
  //RowStart := LineStart; // VB
  if linestart=0 then linestart:=1;
  RowStart := LineStart; // VB
  while (LineStart <= TextEnd) and (r < 1) do  // "<" -> "<=" VB Nov 2005
    begin
      if (k >= j) and (breakline) then
        begin
          dec (LineStart);
          //try to find a delimiter => do not cut words
          HelpSource := LineStart;
          while (HelpSource > RowStart)
              and not LMDCharInSet(FText[HelpSource], Delimiters) do
            dec (HelpSource);
          if HelpSource > RowStart then
            LineStart := HelpSource+1;
          exit;
          inc (r);
          k := 0;
        end;
      if FText[LineStart] = #13 then
        begin
          inc(LineStart, 2);
          exit;
          inc(r);
          k := 0;
        end;
      if FText[LineStart] <> #9 then
        k := k + GetCharWidth(FText[LineStart])
      else
        k := k + CharWidth[9] - (k mod CharWidth[9]);
      inc(LineStart);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.GetPrevLine (var LineStart : Integer; TextStart : Integer);
var
  j : Integer;
  RowPos,
  HelpSource2,
  HelpSource : Integer;
begin
  j := FTextRect.Right - FTextRect.Left;
  if j <= 0 then exit;
  //we have to remember the current pos because we want to get the first suitable line before it
  RowPos := LineStart;
  if (LineStart-1 > 0) and (LineStart-1 <= Length(FText)) then //March 05 VB
    if FText[LineStart-1] = #10 then
      dec (LineStart, 2);
  //first search for previous line break (starting point for calculation)
  while (LineStart > TextStart) do //Changed March 05 VB
    begin
      if (LineStart > 0) and (LineStart <= Length(FText)) then
        if (FText[LineStart] = #10) then break;
      dec(LineStart);
    end;
  if LineStart <> TextStart then
    //therefore that the cursor is on a linebreak get behind it
    inc(LineStart);
  HelpSource2 := Length (FText);
  HelpSource := LineStart;
  while (LineStart < RowPos) do //Changed March 05 VB
    begin
      if (LineStart > 0) and (LineStart <= Length(FText)) then
        if (FText[LineStart] = #13) then break;
      HelpSource := LineStart;
      GetNextLine (LineStart, HelpSource2);
    end;
  LineStart := HelpSource;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMemo.CountRows(var ctext : TLMDString) : Integer;
var
  HelpSource,
  RowStart,
  Source,
  SourceEnd : Integer;
  preLF,
  breakline : Boolean;
  j, k, r, i: Integer;
  ltext: TLMDString;

begin
  ltext := TLMDString(ctext);
  result := 0;
  //16.01.01, JH -> prevent the rows from being counted
  //if the control is currently loaded, or the font array has not yet been
  //initialized (char widths not available)
  if csLoading in ComponentState then exit;
  if FRowHeight = -1 then exit;
  if Length(ltext) = 0 then
    exit;
  Source := 1;
  SourceEnd := Length(ltext);
//  i := 1;
//  s := '';
  j := FTextRect.Right - FTextRect.Left;
  if j <= 0 then exit;
  breakline := FWordWrap or (Alignment <> taLeftJustify);
//  Rowstart := Source;
  r := 0;
  while Source <= SourceEnd do
    begin
      k := 0;
      RowStart := source;
      preLF := false;
//      if source^ = #9 then begin k := k + k mod TabSize; end;
      repeat
        if ltext[Source] <> #9 then
          k := k + GetCharWidth(ltext[source])
        else
          k := k +  CharWidth[9] - k mod CharWidth[9];
        inc(Source);
      until (Source >= SourceEnd) or (((k>= j) and breakline)
          or (ltext[Source] = #10));

      if  Source > SourceEnd  then
        break;

      if ltext[Source] = #10 then
        begin
          preLF := true;
          dec (Source);
        end;

      if (ltext[Source] <> #13) and (preLF) then //error
        begin
          HelpSource := 1;//Pointer(ltext);
          i := Source - HelpSource + 2;
          System.Insert (#13,ltext, i);
          Source := 1;//Pointer(ltext);
          SourceEnd := Length (ltext);  //vb aug 2005

          inc (Source, i - 1);
        end;

      if breakline and (k >= j) then
        begin
          dec (Source);
          HelpSource := Source;
          while (HelpSource > RowStart)
              and not LMDCharInSet(ltext[HelpSource], Delimiters) do
            dec (HelpSource);
          if LMDCharInSet(ltext[HelpSource], Delimiters) then
            inc (HelpSource);
          if HelpSource > RowStart then
            Source := HelpSource;
          inc(r);
//          RowStart := Source;
          if ltext[Source] = #10 then inc(Source);
        end;

      if (ltext[source] = #13) then
        begin
          //a new longest row may be found
          if k  - j > FLongRow then
            RowLength := k - j;
          inc(source, 2);
          inc(r);
          //Rowstart := Source;
//          inc(source);
        end;
    end;
  result := r;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMemo.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;
begin
  inherited DoMouseWheel (Shift, WheelDelta, MousePos);
  //added Feb 2002, JH
  if WheelDelta > 0 then
    ScrollUp (1)
  else
    ScrollDown (1);
  FScrolled := true;  // added VB april 2005
  SetCaret;
  FScrolled := false; // added VB april 2005
  result := true;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.LoadFromFile (const Filename : TLMDString);
begin
  FFirstCharOut := 1;
  SelLength := 0;
  FCurrentRow := 1;
  RowFirst := 1;
  CurrentChar := 1;

  FStrings.LoadFromFile (Filename);
end;

{ ---------------------------------------------------------------------------- }
{$IFDEF LMDCOMP12}
procedure TLMDCustomMemo.LoadFromFile(const Filename: TLMDString; aEncoding: TEncoding);
var
  tmp: TStringList;
begin
  tmp := TStringList.Create;
  try
    tmp.LoadFromFile(Filename, aEncoding);
    Lines.Text := tmp.Text;
  finally
   tmp.free;
  end;
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.SaveToFile (const Filename : TLMDString);
begin
//  FStrings.Text := FText;
  FStrings.SaveToFile (Filename);
//  Modified := false;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.AddLine (const S : TLMDString);
begin
  if FText <> '' then //otherwise an empty line will be inserted first
    Add (Char(13) + Char(10) + S)
  else
    Add (S);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.InsertAtLine (Index : LongInt;S : TLMDString);
var
  Source,
  SourceEnd : Integer;
  c, i : Integer;
begin
  Source := 1;
  SourceEnd := Length (FText);
  //c will be our row counter
  c := 0;
  i := 1;
  //let's run through the text and lookout for new lines
  while (c < Index) and (Source < SourceEnd) do
    begin
      inc(Source);
      inc(i);
      if FText[Source] = #10 then
        inc(c);
    end;
  //if FText[i] = #10 then
  // inc(i);
  //if we are at the end of the text i will have the number of Length[FText]
  //but we want to insert the new text behind the last character
  if Source = SourceEnd then
    inc(i); //JH April 2002
  SelStart := i;
  SelLength := 0;

  //if there is any text in the control we'll add the new text
  //as new line, otherwise it will be the first line
  if FText <> '' then
    begin
      if Index = 0 then //vb check if we are at the first(0) line
        SelText := S + #13#10
      else
        SelText := #13#10 + S;
    end
  else
    SelText := S  //no text there
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.DeleteLine (Index : LongInt);
var
  Source,
  SourceEnd : Integer;
  c, i : Integer;
begin
  Source := 1;
  SourceEnd := Length (FText);
  c := 0;
  i := 1;
  while (c < Index) and (Source < SourceEnd) do
    begin
      inc(Source);
      inc(i);
      if FText[Source] = #10 then
        inc(c);
    end;
  if FText[i] = #10 then
    inc(i); //vb jul 2005 - we must not break crlf apart
  SelStart := i;
  i := 0;
  while (c < Index+1) and (Source < SourceEnd) do
    begin
      inc(Source);
      inc(i);
      if FText[Source] = #10 then
        inc(c);
    end;
  SelLength := i;
  SelText := '';
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMemo.GetLineParas (Index : Integer;var Start, Count : Integer) : TLMDString;
var
  Source,
  SourceEnd : Integer;
  c : Integer;
begin
  if FText = '' then
    begin
      Start := 0;
      Count := 0;
      exit;
    end;
  Source := 1;
  SourceEnd := Length (FText);
  c := 0;
  Start := 1;
  //first seek to line with given index
  while (c < Index) and (Source < SourceEnd) do
    begin
      if FText[Source] = #10 then //lineend = #13#10
        inc(c);
      inc(Source);
      inc(Start);
    end;
  if (c=0) and (Index > 0) then
  begin
    Start := SourceEnd;
    Count := 0;
  end
  else
  begin
   //start contains char number of first char of line with the given index
    //source points to that char
    Count := 0;
    //lets search the end of this line (or the end of the text, whatever comes first)
    if Start <= SourceEnd then
      begin
        while (Source <= SourceEnd) do
          begin
            if FText[Source] = #10 then break;
            inc(Source);
            inc(Count);
          end;
        if FText[Source] = #10 then //do not decrement count if we are at the end of the text
          dec(count);               //otherwise the last char will be truncated! //JH March 2002
      end
    else
      inc(Start);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMemo.GetLine (Index : LongInt) : TLMDString;
var
  Start, Count : Integer;
begin
  GetLineParas (Index, Start, Count);
  result := Copy (Start, Count);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomMemo.GetRowText(Index: LongInt): TLMDString;
var
  i, j: integer;
begin
  i := CalcRowStart(index);
  j := CalcRowStart(index + 1);
  if Index = 0 then
    j := j - 1;
  result := Trim(System.Copy(FText, i, j - i));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.MoveLine (CurIndex, NewIndex : LongInt);
var
  Start, Count : Integer;
  S : TLMDString;
begin
  GetLineParas (CurIndex, Start, Count);
  S := Cut (Start, Count + 2);
  GetLineParas (NewIndex, Start, Count);
  Insert (Start, S);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.ExchangeLines (FirstIndex, SecondIndex : Integer);
var
  Start1, Count1, Start2, Count2 : Integer;
  S1, S2 : TLMDString;
begin
  GetLineParas (FirstIndex, Start1, Count1);
  S1 := Copy (Start1, Count1);
  GetLineParas (SecondIndex, Start2, Count2);
  S2 := Copy (Start2, Count2);
  Replace (Start2, Count2, S1);

  //refresh infos (which could have been changed by the exchange before if FirstIndex > SecondIndex)
  if FirstIndex > SecondIndex then
    GetLineParas (SecondIndex, Start1, Count1);
  Replace (Start1, Count1, S2);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomMemo.SetLine (Index : Integer; S : TLMDString);
var
  st, co : Integer;
begin
  GetLineParas (Index, st, co);
  //don't delete line
  //outcomented vb jul 2005 this code inserts line after crlf
  {
  if FText[st] = #13 then
    begin
      inc(st, 2);
      dec(co, 2);
    end;   }
  Replace (st, co, s);
end;

{$IFDEF LMD_UNICODE}
{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.LoadFromFileW(const Filename: TLMDString);
var
  lWText: TLMDWideStringList;
begin
  lWText := TLMDWideStringList.Create;
  {$IFNDEF LMD_NATIVEUNICODE}
  lWText.SaveUnicode := true;
  {$ENDIF}
  lWText.LoadFromFile(FileName {$IFDEF LMDCOMP12}, TEncoding.Unicode{$ENDIF});
  Text := lWText.Text;
  lWText.Clear;
  lWText.Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.LoadFromStreamW(Stream: TStream);
var
  lWText: TLMDWideStringList;
begin
  lWText := TLMDWideStringList.Create;
  {$IFNDEF LMD_NATIVEUNICODE}
  lWText.SaveUnicode := true;
  {$ENDIF}
  lWText.LoadFromStream(Stream {$IFDEF LMDCOMP12}, TEncoding.Unicode{$ENDIF});
  Text := lWText.Text;
  lWText.Clear;
  lWText.Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.SaveToFileW(const Filename: TLMDString);
var
  lWText: TLMDWideStringList;
begin
  lWText := TLMDWideStringList.Create;
  {$IFNDEF LMD_NATIVEUNICODE}
  lWText.SaveUnicode := true;
  {$ENDIF}
  lWText.Text := Text;
  lWText.SaveToFile(FileName {$IFDEF LMDCOMP12}, TEncoding.Unicode{$ENDIF});
  lWText.Clear;
  lWText.Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoStrings.SaveToStreamW(Stream: TStream);
var
  lWText: TLMDWideStringList;
begin
  lWText := TLMDWideStringList.Create;
  {$IFNDEF LMD_NATIVEUNICODE}
  lWText.SaveUnicode := true;
  {$ENDIF}
  lWText.Text := Text;
  lWText.SaveToStream(Stream {$IFDEF LMDCOMP12}, TEncoding.Unicode{$ENDIF});
  lWText.Clear;
  lWText.Free;
end;
{$ENDIF}

end.
