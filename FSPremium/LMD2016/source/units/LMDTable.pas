unit LMDTable;
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

LMDTable unit (VO)
------------------



ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Windows, Graphics, Types, Classes,
  LMDText, LMDWriter, LMDHiddenText;

type

  TLMDVAlign = (vaTop, vaMiddle, vaBottom, vaNone);

  TLMDTable = class;

  { ********************************** TLMDCell *******************************}
  TLMDCell = class(TLMDParsedTextList)
  private
    FChanged       : boolean;
    FRow           : LongInt;
    FColumn        : LongInt;
    FDependents    : TList;
    FPrecedents    : TLMDCell;
    FRowspan       : integer;
    FColspan       : integer;
    FAlign         : TLMDParaAlign;
    FVAlign        : TLMDVAlign;
    FBgColor       : TColor;
    FWidth         : integer;
    FHeight        : integer;
    FMinCellWidth  : integer;
    FMaxCellWidth  : integer;
    FMinCellHeight : integer;
    FAdvCellWidth  : integer;
    FCellWidth     : integer;
    FCellHeight    : integer;
    function  Table : TLMDTable;
    function GetMinWidth : integer;
    function GetMaxWidth : integer;
    procedure UpdateCellSize;
  protected
    function  NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;override;
    procedure CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);override;
  public
    constructor Create(AParent: TLMDParsedTextList); overload;
    constructor Create(AParent: TLMDParsedTextList;
      aWidth : integer; aHeight : integer; aRowspan : Integer;
      aColspan : integer; aAlign : TLMDParaAlign; aVAlign : TLMDVAlign;
      aBgColor : TColor); overload;
    destructor Destroy; override;

    procedure Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
      aDefFont: TFont; aBkColor: TColor; aAutoSize: Boolean; aWordWrap: Boolean;
      aMask: Boolean); override;
    function Clone: TLMDBaseText; override;
    procedure Store(AWriter : TLMDWriter); override;

    function InGroup : boolean;
    procedure UnGroup;
    procedure GroupCell(ACell : TLMDCell);
    procedure CalcMinHeight(aCanvas: TCanvas; aDefFont: TFont);
    procedure CalcMinWidth(aCanvas: TCanvas; aDefFont: TFont);

    property Width : integer read FWidth write FWidth;
    property Height : integer read FHeight write FHeight;
    property Rowspan : Integer read FRowspan write FRowspan;
    property Colspan : integer read FColspan write FColspan;
    property Align : TLMDParaAlign read FAlign write FAlign;
    property VAlign : TLMDVAlign read FVAlign write FVAlign;
    property BgColor : TColor read  FBgColor write FBgColor;

    property Precedent : TLMDCell read FPrecedents write FPrecedents;
    property MinWidth : integer read GetMinWidth;
    property MaxWidth : integer read GetMaxWidth;
    property AdvWidth : integer read FAdvCellWidth write FAdvCellWidth;
    property MinHeight : integer read FMinCellHeight;
    property RowIndex : LongInt read FRow write FRow ;
    property ColumnIndex : LongInt read FColumn write FColumn;
  end;

  { ******************************** TLMDColumnParam **************************}
  TLMDColumnParam = class
  private
    FWidth    : integer;
    FMinWidth : integer;
//    FMaxWidth : integer;
    FAdvWidth : integer;
  public
    constructor Create; overload;
    constructor Create(aWidth, aMinWidth, aAdvWidth : integer); overload;
    property Width : integer read FWidth write FWidth;
    property MinWidth : integer read FMinWidth write FMinWidth;
    property MaxWidth : integer read FMinWidth write FMinWidth;
    property AdvWidth : integer read FAdvWidth write FAdvWidth;
  end;

  TLMDRowParam = class
  private
    FHeight : integer;
  public
    constructor Create; overload;
    constructor Create(aHeight : integer); overload;
    property Height : integer read FHeight write FHeight ;
  end;

  { ********************************** TLMDTableRow ***************************}
  TLMDTableRow = class(TLMDParsedTextList)
  private
    FHeight : integer;
    FVAlign : TLMDVAlign;
    function GetCellCount : LongInt;
    function GetCell(index : LongInt) : TLMDCell;
  public
    constructor Create(aParent: TLMDParsedTextList); overload;
    constructor Create(aParent: TLMDParsedTextList; aHeight : LongInt); overload;
    function Clone: TLMDBaseText; override;
    procedure InsertCell(aPos : LongInt);
    procedure Store(AWriter : TLMDWriter); override;
    property VAlign : TLMDVAlign read FVAlign write FVAlign;
    property Height : integer read FHeight write FHeight;
    property CellCount : LongInt read GetCellCount;
    property Cell[index : LongInt] : TLMDCell read GetCell ; default;
  end;

  { ********************************** TLMDTable ******************************}
  TLMDTable = class(TLMDParsedTextList)
  private
    FColumnParam        : TList;
    FRowParam           : TList;
    FPrepared           : boolean;

    FMinTableWidth      : integer;
    FAdvTableWidth      : integer;
    FTableWidth         : integer;
    FTableHeight        : integer;

    FWidth              : integer;
    FAlign              : TLMDParaAlign;
    FVAlign             : TLMDVAlign;
    FCellspacing        : integer;
    FCellpadding        : integer;
    FBorder             : integer;
    FBgColor            : TColor;

    FDefaultCellPadding : integer;

    function  GetColumnParam(Index : LongInt) : TLMDColumnParam;
    function  GetRowParam(Index : LongInt) : TLMDRowParam;

    function  GetColumnCount : LongInt;
    function  GetRowCount : LongInt;

    procedure SetMinColumnWidth(Index : LongInt);
    procedure SetMaxColumnWidth(Index : LongInt);
    procedure CalcMinColumnWidth(aCanvas: TCanvas; aDefFont: TFont);
    procedure CalcAdvCellWidth;
    procedure CalcAdvColumnsWidth;
    function  CheckLowWidth(AColumn : LongInt; AWidth : integer) : boolean;
    procedure RecalcColumnsWidth;
    procedure SetRowMinHeight(ARow : LongInt; aCanvas : TCanvas; aDefFont : TFont);
    procedure CalcRowsHeight(aCanvas: TCanvas; aDefFont: TFont);
    procedure UpdateTableSize(aCanvas: TCanvas; const aDisplayRect: TRect;
              aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);
    function GetRow(index : LongInt) : TLMDTableRow;
    procedure Group(AFromRow, AFromColumn, AToRow, AToColumn : LongInt);
  protected
    function  NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;override;
    procedure CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);override;
  public
    constructor Create(aParent: TLMDParsedTextList); overload;
    destructor Destroy; override;
    procedure Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
      aDefFont: TFont; aBkColor: TColor; aAutoSize: Boolean; aWordWrap: Boolean;
      aMask: Boolean); override;
    function Clone: TLMDBaseText; override;
    procedure Store(AWriter : TLMDWriter); override;
    procedure Prepare;

    function Cell(ARow, ACol : LongInt) : TLMDCell;
    property ColumnCount : LongInt read GetColumnCount;
    property RowCount : LongInt read GetRowCount;
    property ColumnParam[Index : LongInt] : TLMDColumnParam read GetColumnParam;
    property RowParam[Index : LongInt] : TLMDRowParam read GetRowParam;

    property Width : integer read FWidth write FWidth;
    property Align : TLMDParaAlign read FAlign write FAlign;
    property VAlign : TLMDVAlign read FVAlign write FVAlign;
    property Cellspacing : integer read FCellspacing write FCellspacing;
    property Cellpadding : integer read FCellpadding write FCellpadding;
    property Border : integer read FBorder write FBorder;
    property BgColor : TColor read  FBgColor write FBgColor;

    property Row[index : LongInt] : TLMDTableRow read GetRow;
    property DefaultCellPadding : integer read FDefaultCellPadding write
      FDefaultCellPadding;
  end;

function StrToLMDParaAlign(const value : string) : TLMDParaAlign;
function StrToLMDVAlign(const value : string) : TLMDVAlign;

implementation
uses
  Sysutils;

function StrToLMDParaAlign(const value : string) : TLMDParaAlign;
begin
  if SameText(value, 'LEFT') then result := paLeft
  else if SameText(value, 'RIGHT') then result := paRight
  else if SameText(value, 'CENTER') then result := paCenter
  else if SameText(value, 'JUSTIFY') then result := paJustify
  else result := paLeft;
end;

{------------------------------------------------------------------------------}

function LMDParaAlignToStr(value : TLMDParaAlign) : string;
begin
  result := 'LEFT';
  case value of
    paLeft : result := 'LEFT';
    paRight : result := 'RIGHT';
    paCenter : result := 'CENTER';
    paJustify : result := 'JUSTIFY';
  end;
end;

{------------------------------------------------------------------------------}

function StrToLMDVAlign(const value : string) : TLMDVAlign;
begin
  if SameText(value, 'TOP') then result := vaTop
  else if SameText(value, 'MIDDLE') then result := vaMiddle
  else if SameText(value, 'BOTTOM') then result := vaBottom
  else result := vaNone;
end;

{ ********************************** TLMDCell *********************************}
{------------------------------------------------------------------------------}

function  TLMDCell.Table : TLMDTable;
begin result := TLMDTable(Parent.Parent) end;

{------------------------------------------------------------------------------}

procedure TLMDCell.UpdateCellSize;
var
  I, J          : LongInt;
begin
  FCellHeight := 0;
  FCellWidth := 0;
  if (not InGroup) or assigned(FPrecedents) then begin
    FCellWidth := Table.ColumnParam[FColumn].Width;
    FCellHeight := Table.RowParam[FRow].Height;
  end
  else begin
    FCellHeight := Table.Cellspacing*(Table.Cell(FRow,FColumn).Rowspan-1);
    for I := FRow to Table.Cell(FRow,FColumn).Rowspan+FRow-1 do
      FCellHeight := FCellHeight + Table.RowParam[I].Height;
    FCellWidth := Table.Cellspacing*(Table.Cell(FRow,FColumn).Colspan-1);
    for J := FColumn to Table.Cell(FRow,FColumn).Colspan+FColumn-1 do
        FCellWidth := FCellWidth + Table.ColumnParam[J].Width;
  end;
  FChanged := False;
end;

{------------------------------------------------------------------------------}

function TLMDCell.GetMinWidth : integer;
begin
  result := FMinCellWidth;
end;

{------------------------------------------------------------------------------}

function TLMDCell.GetMaxWidth : integer;
begin
  result := FMaxCellWidth;
end;

{ ********************************** Public ***********************************}

constructor TLMDCell.Create(AParent: TLMDParsedTextList);
begin
  inherited;
  FWidth := 0;
  FHeight := 10;
  FRowspan := 1;
  FColspan := 1;
  FBgColor := clDefault;
  FDependents := TList.Create;
  FPrecedents := nil;
  FMinCellWidth := 0;
  FMaxCellWidth := 0;
  FAdvCellWidth := 0;
  FCellWidth := 0;
  FMinCellHeight := 0;
  FChanged := True;
  FCellHeight := 0;
  FAlign := paLeft;
  FVAlign := vaMiddle;
end;

constructor TLMDCell.Create(AParent: TLMDParsedTextList;
      aWidth : integer; aHeight : integer; aRowspan : Integer;
      aColspan : integer; aAlign : TLMDParaAlign; aVAlign : TLMDVAlign;
      aBgColor : TColor);
begin
  Create(aParent);
  FWidth := aWidth;
  FHeight := aHeight;
  Frowspan := aRowspan;
  FColspan := aColspan;
  FAlign := aAlign;
  FVAlign := aVAlign;
  FBgColor := aBgColor;
end;

{------------------------------------------------------------------------------}

destructor TLMDCell.Destroy;
begin
  FDependents.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

procedure TLMDCell.CalcMinHeight(aCanvas: TCanvas; aDefFont: TFont);
var
  I             : LongInt;
  R             : TRect;
//  ARow, AColumn : LongInt;
  CellRect      : TRect;
begin
  FChanged := True;
  FMinCellHeight := 1;
  if count = 0 then Exit;

  FMinCellHeight := 0;
  CellRect := Rect(0, 0, 0, 10000);

  for I := FColumn to FColumn+Colspan-1 do
    CellRect.Right := CellRect.Right+Table.ColumnParam[I].Width;

  if Table.ColumnParam[ColumnIndex].Width > CellRect.Right then
    CellRect.Right := Table.ColumnParam[ColumnIndex].Width;

  for I := 0 to count-1 do begin
      R :=SubItem[I].GetClientRect(aCanvas, CellRect, aDefFont, False, True);
      FMinCellHeight := FMinCellHeight + R.Bottom-R.Top+2;
  end;
  if FMinCellHeight = 0 then FMinCellHeight := 1;
  FMinCellHeight := FMinCellHeight;
end;

{------------------------------------------------------------------------------}

procedure TLMDCell.CalcMinWidth(aCanvas: TCanvas; aDefFont: TFont);
var
  I     : LongInt;
  R     : TRect;
begin
  FChanged := True;
  FMinCellWidth := 1;
  FMaxCellWidth := 1;
  if count = 0 then Exit;

  for I := 0 to count-1 do begin
    R :=SubItem[I].GetClientRect(aCanvas, Rect(0, 0, 1, 10000), aDefFont, False, True);
    if (R.Right-R.Left) > FMinCellWidth then FMinCellWidth := R.Right-R.Left;
  end;
  if FMinCellWidth = 0 then FMinCellWidth := 1;

(*  for I := 0 to count-1 do begin
    R :=SubItem[I].GetClientRect(aCanvas, Rect(0, 0, 1, 10000), aDefFont, True, False);
    if (R.Right-R.Left) > FMaxCellWidth then FMaxCellWidth := R.Right-R.Left;
  end;
  if FMaxCellWidth = 0 then FMaxCellWidth := 1;
*)
end;

{------------------------------------------------------------------------------}

function  TLMDCell.NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
    aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;
begin
  result :=  FChanged;
end;

procedure TLMDCell.CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
  aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);
begin
  UpdateCellSize;
  FClientWidth := FCellWidth;
  FClientHeight := FCellHeight;
end;

{------------------------------------------------------------------------------}

procedure TLMDCell.Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
  aDefFont: TFont; aBkColor: TColor; aAutoSize, aWordWrap: Boolean;
  aMask: Boolean);
var
  I        : integer;
  R        : TRect;
  CellRect : TRect;
  DataHeight : LongInt;
  DataWidth  : LongInt;
  yOffset  : integer;
  hPadding : integer;
  lBgColor : TColor;
begin
  hPadding := 0;
  lBgColor := clDefault;
  CellRect := GetClientRect(aCanvas, Rect(0,0,0,0), aDefFont, aAutoSize, aWordWrap);
  if Cellrect.right > (aRect.right-aRect.left-aOffset.x) then CellRect.right := (aRect.right-aRect.left-aOffset.X);
  if Cellrect.bottom > (aRect.bottom-aRect.top-aOffset.y) then CellRect.bottom := (aRect.bottom-aRect.top-aOffset.y);
  if Table.Cellpadding >= 0 then
    hPadding := Table.Cellpadding;

  hPadding := hPadding + Table.DefaultCellpadding+Table.Border;

  if FBgColor <> clDefault then lBgColor := FBgColor
  else if Table.BgColor <> clDefault then lBgColor := Table.BgColor;

  if aMask then
    aCanvas.Brush.Color:= clWhite
  else
    if lBgColor <> clDefault then aCanvas.Brush.Color:= lBgColor
    else aCanvas.Brush.Color:= aBkColor;

  if lBgColor <> clDefault then begin
    aCanvas.FillRect(Rect(aRect.Left + aOffset.X, aRect.Top + aOffset.Y,
      aRect.Left + aOffset.X+CellRect.Right, aRect.Top + aOffset.Y+CellRect.Bottom));
  end;

  if count > 0 then begin
    for I := 0 to count-1 do
      if (TObject(SubItem[I]) is TLMDTable) then
        TLMDTable(SubItem[I]).Align := Align
      else if (TObject(SubItem[I]) is TLMDParagraph) then
        TLMDParagraph(SubItem[I]).AlignTxt := LMDParaAlignToStr(Align);

    DataHeight := 0;
    DataWidth  := 0;
    for I := 0 to count-1 do begin
      R := subItem[I].GetClientRect(aCanvas,
        Rect(ARect.Left+AOffset.X + hPadding,
             ARect.top+ AOffset.Y+hPadding+ DataHeight,
             ARect.Left+AOffset.X+(CellRect.right-CellRect.left)-hPadding,
             ARect.top+ AOffset.Y+(CellRect.bottom-CellRect.top)-hPadding),
        aDefFont, aAutoSize, aWordWrap);
      if ((R.Right-R.Left) > DataWidth) and
         ((R.Right-R.Left) <= (CellRect.Right-CellRect.Left-hPadding*2))
      then        DataWidth := R.Right-R.Left;
      if (DataHeight + (R.Bottom-R.Top)+2) <= (CellRect.Bottom - CellRect.Top - 2*hPadding)
        then DataHeight := DataHeight + (R.Bottom-R.Top)+2
        else DataHeight := CellRect.Bottom - CellRect.Top - 2*hPadding;
    end;

    yOffset := 0;
    case VAlign of
      vaTop: yOffset := 0;
      vaMiddle: yOffset := round(((CellRect.Bottom-CellRect.top-2*hPadding)-DataHeight)/2);
      vaBottom: yOffset := ((CellRect.Bottom-CellRect.top-2*hPadding)-DataHeight);
    end;
    DataHeight := 0;
    for I := 0 to count-1 do begin
      SubItem[I].Render(aCanvas,
        Rect(ARect.Left+AOffset.X+hPadding,
             ARect.top+ AOffset.Y+hPadding+DataHeight + yOffset,
             ARect.Left+AOffset.X+(CellRect.right-CellRect.left)-hPadding,
             ARect.top+ AOffset.Y+(CellRect.bottom-CellRect.top)-hPadding),
        Point(0,0), aDefFont, lBgColor, aAutoSize, aWordWrap, aMask);
      SubItem[I].PosInParent := Point(hPadding, DataHeight+hPadding+ yOffset);
      R := subItem[I].GetClientRect(aCanvas,
        Rect(ARect.Left+AOffset.X+hPadding,
             ARect.top+ AOffset.Y+hPadding+DataHeight + yOffset,
             ARect.Left+AOffset.X+(CellRect.right-CellRect.left)-hPadding,
             ARect.top+ AOffset.Y+(CellRect.bottom-CellRect.top)-hPadding),
        aDefFont, aAutoSize, aWordWrap);
      DataHeight := DataHeight + R.Bottom-R.Top+2;
    end;
  end;

  // draw border
  if Table.Border > 0 then begin
    aCanvas.Pen.Width := Table.Border;
    aCanvas.MoveTo(aRect.Left + aOffset.X, aRect.Top + aOffset.Y);
    aCanvas.LineTo(aRect.Left + aOffset.X+CellRect.Right,aRect.Top + aOffset.Y);
    aCanvas.LineTo(aRect.Left + aOffset.X+CellRect.Right,aRect.Top + aOffset.Y+CellRect.Bottom);
    aCanvas.LineTo(aRect.Left + aOffset.X,aRect.Top + aOffset.Y+CellRect.Bottom);
    aCanvas.LineTo(aRect.Left + aOffset.X,aRect.Top + aOffset.Y);
  end;
end;

{------------------------------------------------------------------------------}

function TLMDCell.Clone: TLMDBaseText;
begin
  Result := inherited Clone;

  TLMDCell(Result).FWidth := FWidth;
  TLMDCell(Result).FHeight := FHeight;
  TLMDCell(Result).FRowspan := FRowspan;
  TLMDCell(Result).FColspan := FColspan;
  TLMDCell(Result).FBgColor := FBgColor;

  TLMDCell(Result).FMinCellWidth := FMinCellWidth;
  TLMDCell(Result).FMaxCellWidth := FMaxCellWidth;
  TLMDCell(Result).FAdvCellWidth := FAdvCellWidth;
  TLMDCell(Result).FCellWidth := FCellWidth;
  TLMDCell(Result).FMinCellHeight := FMinCellHeight;
  TLMDCell(Result).FChanged := FChanged;
  TLMDCell(Result).FCellHeight := FCellHeight;
  TLMDCell(Result).FAlign := FAlign;
  TLMDCell(Result).FVAlign := FVAlign;
  TLMDCell(Result).FChanged := FChanged;
  TLMDCell(Result).FRow := FRow;
  TLMDCell(Result).FColumn := FColumn;

  TLMDCell(Result).FDependents := TList.Create;
  TLMDCell(Result).FPrecedents := nil;
end;

{-----------------------------------------------------------------------------}

procedure TLMDCell.Store(AWriter : TLMDWriter);
var
  I : longInt;
begin
  AWriter.WriteOpenTableData(Width, Height, Rowspan, Colspan, integer(Align), integer(VAlign), BgColor);
  for I := 0 to count-1 do
    SubItem[I].Store(aWriter);
  AWriter.WriteCloseTableData;
end;

{-----------------------------------------------------------------------------}

function TLMDCell.InGroup : boolean;
begin
  if assigned(FPrecedents) or (FDependents.count > 0) then result := True
  else result := False;
end;

{------------------------------------------------------------------------------}

procedure TLMDCell.GroupCell(ACell : TLMDCell);
begin
  FDependents.Add(ACell);
  ACell.Precedent := Self;
end;

{------------------------------------------------------------------------------}

procedure TLMDCell.UnGroup;
var
  I : LongInt;
begin
  for I := 0 to FDependents.Count-1 do
    TLMDCell(FDependents[I]).UnGroup;
  FDependents.Clear;
  FPrecedents := nil;
end;

{ ********************************* TLMDColumnParam ***************************}
{------------------------------------------------------------------------------}

constructor TLMDColumnParam.Create;
begin
  inherited;
  FWidth    := 0;
  FMinWidth := 0;
  FAdvWidth := 0;
end;

{------------------------------------------------------------------------------}

constructor TLMDColumnParam.Create(aWidth, aMinWidth, aAdvWidth : integer);
begin
  inherited Create;
  FWidth    := aWidth;
  FMinWidth := aMinWidth;
  FAdvWidth := aAdvWidth;
end;

{ ********************************* TLMDRowParam ******************************}
{------------------------------------------------------------------------------}

constructor TLMDRowParam.Create;
begin
  inherited;
  FHeight := 0;
end;

constructor TLMDRowParam.Create(aHeight : integer);
begin
  inherited Create;
  FHeight := aHeight;
end;

{ ********************************** TLMDTable ********************************}
{------------------------------------------------------------------------------}

function  TLMDTable.GetColumnParam(Index : LongInt) : TLMDColumnParam;
begin
  result := nil;
  if Index >= FColumnParam.count then Exit;
  result := TLMDColumnParam(FColumnParam[Index]);
end;

{------------------------------------------------------------------------------}

function  TLMDTable.GetRowParam(Index : LongInt) : TLMDRowParam;
begin
  result := nil;
  if Index >= FRowParam.count then Exit;
  result := TLMDRowParam(FRowParam[Index]);
end;

{------------------------------------------------------------------------------}

function  TLMDTable.GetColumnCount : LongInt;
begin
  if count > 0 then result := FColumnParam.count
  else result := 0;
end;

{------------------------------------------------------------------------------}

function  TLMDTable.GetRowCount : LongInt;
var
  I : LongInt;
begin
  result := 0;
  for I := 0 to count-1 do
    if SubItem[I] is TLMDTableRow then Inc(Result);
end;

{------------------------------------------------------------------------------}

procedure TLMDTable.SetMinColumnWidth(Index : LongInt);
var
  I, J          : LongInt;
  lWidth        : integer;
begin
  ColumnParam[Index].MinWidth := 0;

  for I := 0 to RowCount-1 do begin
    lWidth := 0;
    for J := Index to Index+Cell(I,Index).Colspan-1 do
      lWidth := lWidth + ColumnParam[J].MinWidth;
    if Cell(I,Index).MinWidth > lWidth then begin
      lWidth := Cell(I,Index).MinWidth;
      for J := Index to Index+Cell(I,Index).Colspan-1 do
        lWidth := lWidth - ColumnParam[J].MinWidth;
      ColumnParam[Index].MinWidth := ColumnParam[Index].MinWidth+lWidth;
    end;
  end;
    ColumnParam[Index].MinWidth :=
    ColumnParam[Index].MinWidth + 2*(FDefaultCellpadding+FBorder);
  if FCellpadding > 0 then
    ColumnParam[Index].MinWidth :=
    ColumnParam[Index].MinWidth + 2* FCellpadding;

  for I := Index-1 downto 0 do SetMinColumnWidth(I);
end;

{------------------------------------------------------------------------------}

procedure TLMDTable.SetMaxColumnWidth(Index : LongInt);
var
  I, J          : LongInt;
  lWidth        : integer;
begin
  ColumnParam[Index].MaxWidth := 0;

  for I := 0 to RowCount-1 do begin
    lWidth := 0;
    for J := Index to Index+Cell(I,Index).Colspan-1 do
      lWidth := lWidth + ColumnParam[J].MaxWidth;
    if Cell(I,Index).MaxWidth > lWidth then begin
      lWidth := Cell(I,Index).MaxWidth;
      for J := Index to Index+Cell(I,Index).Colspan-1 do
        lWidth := lWidth - ColumnParam[J].MaxWidth;
      ColumnParam[Index].MaxWidth := ColumnParam[Index].MaxWidth+lWidth;
    end;
  end;
    ColumnParam[Index].MaxWidth :=
    ColumnParam[Index].MaxWidth + 2*(FDefaultCellpadding+FBorder);
  if FCellpadding > 0 then
    ColumnParam[Index].MaxWidth :=
    ColumnParam[Index].MaxWidth + 2* FCellpadding;

  for I := Index-1 downto 0 do SetMaxColumnWidth(I);
end;

{------------------------------------------------------------------------------}

procedure TLMDTable.CalcMinColumnWidth(aCanvas: TCanvas; aDefFont: TFont);
var
  I, J : LongInt;
begin
  // calc minimum requared horizontal size for each cell
  for I := 0 to RowCount-1 do
    for J := 0 to ColumnCount-1 do
      Cell(I,J).CalcMinWidth(aCanvas, aDefFont);

  for I := 0 to ColumnCount-1 do
    begin
      SetMinColumnWidth(I);
//      SetMaxColumnWidth(I);
    end;

  FMinTableWidth := 0;
  for I := 0 to ColumnCount-1 do
    FMinTableWidth := FMinTableWidth + ColumnParam[I].MinWidth;

  FPrepared := True;
end;

{------------------------------------------------------------------------------}

procedure TLMDTable.CalcAdvCellWidth;
var
  J,I           : LongInt;
  lWidth        : integer;
  tWidth        : integer;
  lCount        : integer;
begin
  for I := 0 to RowCount-1 do begin
    lWidth := FAdvTableWidth;

    // width for fixed
    for J := 0 to ColumnCount-1 do
      if Cell(I,J).width > 0 then
        if Cell(I,J).width <= lWidth then
        begin
          Cell(I,J).AdvWidth := Cell(I,J).width;
          lWidth := lWidth - Cell(I,J).width;
        end
        else
        begin
          Cell(I,J).AdvWidth := lWidth;
          lWidth := 0;
        end;

    // width for %
    tWidth := lWidth;
    if lWidth > 0 then
    for J := 0 to ColumnCount-1 do
      if (Cell(I,J).width < 0) and (Cell(I,J).width >= -100) then
      begin
        Cell(I,J).AdvWidth := Round(tWidth*(-1)* Cell(I,J).width/100);
        lWidth := lWidth - Cell(I,J).AdvWidth;
      end;

    // width for *
    J := 0;
    lCount := 0;
    if lWidth > 0 then
    while J < ColumnCount do
      if (Cell(I,J).width < -100) or (Cell(I,J).width = 0) then begin
        if not Cell(I,J).InGroup then begin
          if (Cell(I,J).width = 0) then inc(lCount)
          else lCount := lCount + 100 - Cell(I,J).width;
          inc(J);
        end
        else
          if not assigned(Cell(I,J).Precedent) then begin
            if (Cell(I,J).width = 0) then lCount := lCount + Cell(I,J).Colspan
            else lCount := lCount + 100 - Cell(I,J).width;
              J := J + Cell(I,J).Colspan;
          end
          else begin
            inc(lCount);
            inc(J);
          end;
      end
      else inc(J);

    if (lWidth > 0) and (lCount > 0) then
    for J := 0 to ColumnCount-1 do
      if (Cell(I,J).width < -100) or (Cell(I,J).width = 0) then
        if not Cell(I,J).InGroup then begin
          if (Cell(I,J).width = 0) then
              Cell(I,J).AdvWidth := Round(lWidth/lCount)
          else
              Cell(I,J).AdvWidth := Round((100-Cell(I,J).width)*lWidth/lCount);
        end
        else
          if not assigned(Cell(I,J).Precedent) then begin
            if (Cell(I,J).width = 0) then Cell(I,J).AdvWidth := Round(lWidth*Cell(I,J).Colspan/lCount)
            else
              Cell(I,J).AdvWidth := Round((100-Cell(I,J).width)*lWidth/lCount);
          end
   end;
end;

{------------------------------------------------------------------------------}

procedure TLMDTable.CalcAdvColumnsWidth;
var
  I, J, N, L    : LongInt;
  lWidth        : integer;
  Flag          : boolean;
begin
  CalcAdvCellWidth;

  for J := 0 to ColumnCount-1 do begin
    lWidth := 0; Flag := True;
    for I := 0 to RowCount-1 do begin
      if lWidth < Cell(I,J).AdvWidth then
        lWidth := Cell(I,J).AdvWidth;
      if (Cell(I,J).Width <> 0) or (Cell(I,J).InGroup) then begin
        Flag := False;
        break;
      end;
    end;
    if Flag then ColumnParam[J].AdvWidth := lWidth;
  end;

  for J := 0 to ColumnCount-1 do
    for I := 0 to RowCount-1 do
      if (not Cell(I,J).InGroup) and (Cell(I,J).Width <> 0) then
        if ColumnParam[J].AdvWidth < Cell(I,J).AdvWidth then
          ColumnParam[j].AdvWidth := Cell(I,J).AdvWidth;

  for J := 0 to ColumnCount-1 do
    for I := 0 to RowCount-1 do
      if Cell(I,J).InGroup and (not assigned(Cell(I,J).Precedent)) then begin
        lWidth := 0;
        for n := J to J+Cell(I,J).colspan-1 do
          lWidth := lWidth+ColumnParam[n].AdvWidth;
        if lWidth < Cell(I,J).AdvWidth then begin
          l := 0;
          for n := J to J+Cell(I,J).colspan-1 do
            if ColumnParam[n].AdvWidth = 0 then inc(l);
          for n := J to J+Cell(I,J).colspan-1 do
            if l=0 then
              ColumnParam[n].AdvWidth := round((Cell(I,J).AdvWidth-lWidth)/Cell(I,J).ColSpan)
            else if ColumnParam[n].AdvWidth = 0 then
              ColumnParam[n].AdvWidth := round(ColumnParam[n].AdvWidth+ (Cell(I,J).AdvWidth-lWidth)/l);
        end;
      end;

  lWidth := 0;
  for I := 0 to ColumnCount-1 do
    lWidth := lWidth+ColumnParam[I].AdvWidth;

  if lWidth < FAdvTableWidth then begin
    n := 0;
    for J := 0 to ColumnCount-1 do begin
      Flag := True;
      for I := 0 to RowCount-1 do
        if (Cell(I,J).Width <> 0) or (Cell(I,J).InGroup) then begin
          Flag := False;
          break;
        end;
      if Flag then inc(n);
    end;
    if (n = 0) and (ColumnCount > 0)  then
      ColumnParam[ColumnCount-1].AdvWidth := ColumnParam[ColumnCount-1].AdvWidth+FAdvTableWidth-lWidth
    else
      for J := 0 to ColumnCount-1 do begin
        Flag := True;
        for I := 0 to RowCount-1 do
          if (Cell(I,J).Width <> 0) or (Cell(I,J).InGroup) then begin
            Flag := False;
            break;
          end;
        if Flag and (ColumnCount > 0)  then
          ColumnParam[J].AdvWidth := ColumnParam[J].AdvWidth+round((FAdvTableWidth-lWidth)/n);
      end;
  end;
end;

{------------------------------------------------------------------------------}

function  TLMDTable.CheckLowWidth(AColumn : LongInt; AWidth : integer) : boolean;
var
  I, J : LongInt;
  lWidth : integer;
  lAddWidth : integer;
begin
  result := False;
  lAddWidth := 2*(FDefaultCellpadding+FBorder);
  if FCellpadding > 0 then
    lAddWidth := lAddWidth + 2* FCellpadding;

  for I := 0 to RowCount-1 do begin
     if (not Cell(I, AColumn).InGroup) and
       ((Cell(I, AColumn).MinWidth+lAddWidth) >= AWidth) then
       Exit;
     if Cell(I, AColumn).InGroup and (not assigned(Cell(I, AColumn).Precedent)) then begin
       lWidth := AWidth;
       for J := AColumn to AColumn + Cell(I, AColumn).Colspan-1 do
         lWidth := lWidth + ColumnParam[J].Width;
       if lWidth < ColumnParam[AColumn].Width then Exit;
     end;
  end;

  result := True;
  for I := 0 to AColumn-1 do
    result := result and CheckLowWidth(I, ColumnParam[I].Width);
end;

{------------------------------------------------------------------------------}

procedure TLMDTable.RecalcColumnsWidth;
var
  FDeltaWidth : integer;
  I           : LongInt;
begin
  for I := 0 to Columncount-1 do begin
    ColumnParam[I].AdvWidth := 0;
    ColumnParam[I].Width := 0;
  end;

  CalcAdvColumnsWidth;
  FDeltaWidth := FAdvTableWidth - FMinTableWidth;

  for I := 0 to ColumnCount-1 do begin
    ColumnParam[I].Width := ColumnParam[I].MinWidth;
    if (ColumnParam[I].MinWidth <= ColumnParam[I].AdvWidth) and (FDeltaWidth > 0) then
      if (ColumnParam[I].AdvWidth - ColumnParam[I].MinWidth) < FDeltaWidth then begin
        ColumnParam[I].Width := ColumnParam[I].AdvWidth;
        FDeltaWidth := FDeltaWidth - (ColumnParam[I].AdvWidth - ColumnParam[I].MinWidth);
      end
      else begin
        ColumnParam[I].Width := ColumnParam[I].MinWidth+FDeltaWidth;
        FDeltaWidth := 0;
      end;
  end;

  for I := 0 to ColumnCount-1 do begin
    if (ColumnParam[I].MinWidth > ColumnParam[I].AdvWidth) then
      if CheckLowWidth(I, ColumnParam[I].AdvWidth) then
        ColumnParam[I].Width := ColumnParam[I].AdvWidth;
  end;

  for I := 0 to ColumnCount-1 do
    if (ColumnParam[I].MinWidth > ColumnParam[I].Width) then
        ColumnParam[I].Width := ColumnParam[I].MinWidth;

  if (FDeltaWidth > 0) and (ColumnCount > 0)  then
    ColumnParam[ColumnCount-1].Width := ColumnParam[ColumnCount-1].Width + FDeltaWidth;

  FTableWidth := FCellspacing*ColumnCount;
  for I := 0 to ColumnCount-1 do
    FTableWidth := FTableWidth + ColumnParam[I].Width;
end;

{------------------------------------------------------------------------------}

procedure TLMDTable.SetRowMinHeight(ARow : LongInt; aCanvas : TCanvas; aDefFont : TFont);
var
  I, J    : LongInt;
  lHeight : integer;
begin
  RowParam[ARow].Height := 0;
  for I := 0 to ColumnCount-1 do
    if Cell(ARow, I).Height > RowParam[ARow].Height then
      RowParam[ARow].Height := Cell(ARow, I).Height;

  for I := 0 to ColumnCount-1 do begin
    lHeight := 0;
    for J := ARow to ARow+Cell(ARow, I).rowspan-1 do
      lHeight := lHeight + RowParam[J].Height;
    if Cell(ARow,I).MinHeight > lHeight then begin
      lHeight := Cell(ARow, I).MinHeight;
      for J := ARow to ARow+Cell(ARow, I).rowspan-1 do
        lHeight := lHeight - RowParam[J].height;
      RowParam[ARow].Height := RowParam[ARow].height+lHeight;
    end;
  end;

  RowParam[ARow].height := RowParam[ARow].height + 2*(FDefaultCellpadding+FBorder);
  if FCellpadding > 0 then
    RowParam[ARow].height := RowParam[ARow].Height + 2* (FCellpadding) + 9;

//  for I := ARow-1 downto 0 do SetRowMinHeight(I, aCanvas, aDefFont);
end;

{------------------------------------------------------------------------------}

procedure TLMDTable.CalcRowsHeight(aCanvas: TCanvas; aDefFont: TFont);
var
  I, J : LongInt;
begin
  for I := 0 to RowCount-1 do begin
    RowParam[I].Height := 0;
    for J := 0 to ColumnCount-1 do begin
      Cell(I,J).CalcMinHeight(aCanvas, aDefFont);
      if Cell(I,J).MinHeight > RowParam[I].Height then
        RowParam[I].Height := Cell(I,J).MinHeight;
    end;
  end;

  for I := RowCount-1 downto 0 do
    SetRowMinHeight(I,aCanvas, aDefFont);

  FTableHeight := FCellspacing*RowCount;
  for I := 0 to RowCount-1 do
    FTableHeight := FTableHeight + RowParam[I].height;
end;

{------------------------------------------------------------------------------}

procedure TLMDTable.UpdateTableSize(aCanvas: TCanvas; const aDisplayRect: TRect;
              aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);
var
//  I                     : LongInt;
  lTableWidth           : integer;
begin
  if not FPrepared then CalcMinColumnWidth(aCanvas, aDefFont);

  lTableWidth := aDisplayRect.right-aDisplayRect.left-1;

  if (FWidth <0) and (FWidth>=-100) then
      lTableWidth := round(lTableWidth*(-1)*FWidth/100)
  else if (FWidth > 0) and (FWidth <= lTableWidth) then
      lTableWidth := FWidth;

  if lTableWidth < FMinTableWidth then
    lTableWidth := FMinTableWidth;

  if lTableWidth = FAdvTableWidth then Exit;
  FAdvTableWidth := lTableWidth;

  RecalcColumnsWidth;
  CalcRowsHeight(aCanvas, aDefFont);
end;

{ ********************************** Public ***********************************}

constructor TLMDTable.Create(aParent: TLMDParsedTextList);
begin
  inherited;
  FPrepared := False;
  FMinTableWidth := 0;
  FAdvTableWidth := 0;
  FTableWidth := 0;
  FTableHeight := 0;

  FWidth := -100;
  FAlign := paCenter;
  FVAlign := vaNone;
  FCellspacing := 0;
  FCellpadding := 0;
  FBorder := 0;
  FBgColor := clDefault;
  FColumnParam := TList.Create;
  FRowParam := TList.Create;
  FDefaultCellPadding := 1;
end;

destructor TLMDTable.Destroy;
var
  I : LongInt;
begin
  for I := 0 to FRowParam.count-1 do
    TLMDRowParam(FRowParam[I]).Free;
  for I := 0 to FColumnParam.count-1 do
    TLMDColumnParam(FColumnParam[I]).Free;
  FRowParam.Free;
  FColumnParam.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

function  TLMDTable.NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
    aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;
begin
  result := True;
end;

procedure TLMDTable.CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
  aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);
begin
  UpdateTableSize(aCanvas, aDisplayRect, aDefFont, aAutoSize, aWordWrap);
  FClientWidth := FTableWidth;
  FClientHeight := FTableHeight;
end;

{------------------------------------------------------------------------------}

procedure TLMDTable.Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
  aDefFont: TFont; aBkColor: TColor; aAutoSize, aWordWrap: Boolean;
  aMask: Boolean);
var
  I, J          : LongInt;
  lOffset       : TPoint;
  AlignOffset   : LongInt;
  R             : TRect;
begin

  for I := 0 to RowCount-1 do
    for J := 0 to ColumnCount-1 do
      R := Cell(I,J).GetClientRect(aCanvas, Rect(0,0,0,0),
          aDefFont, aAutoSize, aWordWrap);
  case FAlign of
    paLeft : AlignOffset := 0;
    paCenter: AlignOffset := round(((aRect.Right - aRect.Left - aOffset.X)- FClientWidth)/2);
    paRight: AlignOffset := (aRect.Right - aRect.Left - aOffset.X)- FClientWidth;
  else
    AlignOffset:=0;
  end;

  lOffset.y := FCellspacing;
  for I := 0 to RowCount-1 do begin
    lOffset.x := 0;
    J := 0;
    while J < ColumnCount do begin
      if (not Cell(I,J).InGroup) then begin
        R := Cell(I,J).GetClientRect(aCanvas, Rect(0,0,0,0),
          aDefFont, aAutoSize, aWordWrap);
        Cell(I,J).Render(aCanvas, aRect, Point(AlignOffset+lOffset.x+aOffset.x+FCellspacing, lOffset.y+aOffset.y+FCellspacing) ,
          aDefFont, aBkColor, aAutoSize, aWordWrap, aMask);
        Cell(I,J).PosInParent := Point(AlignOffset+lOffset.x+FCellspacing, 0);
        lOffset.x := lOffset.x + R.Right-R.Left+FCellspacing;
        Inc(J);
        continue;
      end;

      if (Cell(I,J).InGroup) and (not assigned(Cell(I,J).Precedent)) then
      begin
        R := Cell(I,J).GetClientRect(aCanvas, Rect(0,0,0,0),
          aDefFont, aAutoSize, aWordWrap);
        Cell(I,J).Render(aCanvas, aRect, Point(AlignOffset+lOffset.x+aOffset.x+FCellspacing, lOffset.y+aOffset.y+FCellspacing) ,
          aDefFont, aBkColor, aAutoSize, aWordWrap, aMask);
        Cell(I,J).PosInParent := Point(AlignOffset+lOffset.x+FCellspacing, 0);
        lOffset.x := lOffset.x + R.Right-R.Left+FCellspacing;
        J := J + Cell(I,J).Colspan;
        continue;
      end;

      if (Cell(I,J).InGroup) and assigned(Cell(I,J).Precedent) then
      begin
        R := Cell(I,J).GetClientRect(aCanvas, Rect(0,0,0,0),
          aDefFont, aAutoSize, aWordWrap);
        lOffset.x := lOffset.x + R.Right-R.Left+FCellspacing;
        Inc(J);
      end;
    end;
    Row[I].PosInParent := Point(0, lOffset.y+FCellspacing);
    lOffset.y := lOffset.y + RowParam[I].height+FCellspacing;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDTable.Clone: TLMDBaseText;
var
  I     : LongInt;
  J     : LongInt;
begin
  Result:= inherited Clone;

  TLMDTable(Result).FPrepared := FPrepared;
  TLMDTable(Result).FMinTableWidth := FMinTableWidth;
  TLMDTable(Result).FAdvTableWidth := FAdvTableWidth;
  TLMDTable(Result).FTableWidth := FTableWidth;
  TLMDTable(Result).FTableHeight := FTableHeight;

  TLMDTable(Result).FWidth := FWidth;
  TLMDTable(Result).FAlign := FAlign;
  TLMDTable(Result).FVAlign := FVAlign;
  TLMDTable(Result).FCellspacing := FCellspacing;
  TLMDTable(Result).FCellpadding := FCellpadding;
  TLMDTable(Result).FBorder := FBorder;
  TLMDTable(Result).FBgColor := FBgColor;
  TLMDTable(Result).FDefaultCellPadding := FDefaultCellPadding;

  TLMDTable(Result).FColumnParam := TList.Create;
  for I := 0 to FColumnParam.count-1 do
    TLMDTable(Result).FColumnParam.Add(TLMDColumnParam.Create(
      ColumnParam[I].Width, ColumnParam[I].MinWidth, ColumnParam[I].AdvWidth));

  TLMDTable(Result).FRowParam := TList.Create;
  for I := 0 to FRowParam.count-1 do
    TLMDTable(Result).FRowParam.Add(TLMDRowParam.Create(RowParam[I].Height));

  for I := 0 to RowCount-1 do
    for J := 0 to ColumnCount-1 do
      if Cell(I,J).InGroup and not Assigned(Cell(I,J).Precedent) then
        TLMDTable(result).Group(I,J, I+Row[I].Cell[J].rowspan-1, J + Row[I].Cell[J].colspan-1);
end;

{------------------------------------------------------------------------------}

procedure TLMDTable.Store(AWriter : TLMDWriter);
var
  I{, J} : LongInt;
begin
  AWriter.WriteOpenTable(Width, integer(Align), integer(VAlign), Cellspacing, Cellpadding, Border, BgColor);
  for I := 0 to count-1 do
    if (SubItem[I] is TLMDTableRow) then
      SubItem[I].Store(aWriter);
  AWriter.WriteCloseTable;
end;

{------------------------------------------------------------------------------}

function TLMDTable.Cell(ARow, ACol : LongInt) : TLMDCell;
begin
  result := nil;
  if (ARow >= RowCount) or (ACol >= ColumnCount) then Exit;
  result := Row[aRow].Cell[aCol];
end;

{------------------------------------------------------------------------------}

procedure TLMDTable.Group(AFromRow, AFromColumn, AToRow, AToColumn : LongInt);
var
  I, J  : LongInt;
  lRoot : TLMDCell;
begin

  if (AFromRow >= RowCount) or (AToRow >= RowCount) or (AFromColumn >= ColumnCount)
    or (AToColumn >= ColumnCount) then Exit;

  if (AFromRow = AToRow) and (AFromColumn = AToColumn) then Exit;

  Cell(AFromRow, AFromColumn).Colspan := AToColumn-AFromColumn+1;
  Cell(AFromRow, AFromColumn).Rowspan := AToRow-AFromRow+1;
  for I := AFromRow to AToRow do
    for J := AFromColumn to AToColumn do begin
      lRoot := Cell(I,J);
      while assigned(lRoot.Precedent) do lRoot := lRoot.Precedent;
      lRoot.UnGroup;
    end;

  lRoot := Cell(AFromRow, AFromColumn);
  for I := AFromRow to AToRow do
    for J := AFromColumn to AToColumn do
      if (I > AFromRow) or (J > AFromColumn) then
        lRoot.GroupCell(Cell(I,J));
end;

{------------------------------------------------------------------------------}

function TLMDTable.GetRow(index : LongInt) : TLMDTableRow;
var
  I : LongInt;
  J : LongInt;
begin
  J := 0;
  result := nil;
  for I := 0 to count-1 do
    if SubItem[I] is TLMDTableRow then begin
      if Index = J then begin
        result := TLMDTableRow(SubItem[I]);
        Break;
      end;
      inc(J);
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDTable.Prepare;
var
  I, J, m, n            : LongInt;
  MaxCellCount          : LongInt;
  MaxRowCount           : LongInt;
  TmpCellCount          : LongInt;
  TmpCell               : TLMDCell;

  function CellCount(aRow : LongInt): LongInt;
  var
    cI, cJ : LongInt;
  begin
    result := 0;
    for cI := 0 to Row[aRow].CellCount - 1 do
      begin
        TmpCell := Row[aRow].Cell[cI];
        if assigned(TmpCell) then
          Result := Result + TmpCell.colspan;
      end;

    for cJ := 0 to aRow-1 do
      for cI := 0 to Row[aRow].CellCount - 1 do
        begin
          TmpCell := Row[cJ].Cell[cI];
          if assigned(TmpCell) then
            if (TmpCell.rowspan - 1 + cJ) >= aRow then
              Result := Result + TmpCell.colspan;
        end;
  end;

begin
  MaxCellCount := 0;
//  MaxRowCount := 0;

  // Вычисляем максимальное кол-во ячеек в строке
  for I := 0 to RowCount-1 do
    begin
      TmpCellCount := CellCount(I);
      if TmpCellCount > MaxCellCount then
        MaxCellCount := TmpCellCount;
    end;

   // Вычисляем требуемое кол-во строк
   MaxRowCount := RowCount;
   for J := 0 to RowCount - 1 do
     for I := 0 to Row[J].CellCount - 1 do
       begin
          TmpCell := Row[J].Cell[I];
          if assigned(TmpCell) then
            if (TmpCell.rowspan + J) > MaxRowCount then
              MaxRowCount := TmpCell.rowspan + J;
       end;

  // Добавляем строки до требуемого кол-ва
  for I := 0 to MaxRowCount - RowCount -1  do
      AddSubItem(TLMDTableRow.Create(self));

  for J := 0 to MaxRowCount - 1 do
    for I := 0 to MaxCellCount - 1 do
      begin
        TmpCell := Row[J].Cell[I];
        if assigned(TmpCell) then
          begin
            for m := I to I + TmpCell.Colspan - 1 do
              for n := J to J + TmpCell.Rowspan - 1 do
                if not ((m = I) and (n = J)) then
                  Row[n].InsertCell(m);
          end
        else
          Row[J].InsertCell(I);
      end;

  // Clear column params
  for I := 0 to FColumnParam.Count-1 do
    if assigned(FColumnParam[I]) then
      TLMDColumnParam(FColumnParam[I]).Free;
  FColumnParam.Clear;
  for I := 0 to MaxCellCount-1 do
    FColumnParam.Add(TLMDColumnParam.Create);

  // Clear Row params
  for I := 0 to FRowParam.Count-1 do
    if assigned(FRowParam[I]) then
      TLMDRowParam(FRowParam[I]).Free;
  FRowParam.Clear;
  for I := 0 to MaxRowCount-1 do
    FRowParam.Add(TLMDRowParam.Create);

  // Group Cells
  for I:= 0 to MaxRowCount - 1 do
    for J := 0 to MaxCellCount-1 do begin
      if not assigned(Row[I].Cell[J].Precedent) then
        Group(I,J, I+Row[I].Cell[J].rowspan-1, J + Row[I].Cell[J].colspan-1);
      Cell(I,J).RowIndex := I;
      Cell(I,J).ColumnIndex := J;
    end;

end;

{ ************************************ TLMDTableRow ***************************}
{------------------------------------------------------------------------------}

function TLMDTableRow.GetCellCount : LongInt;
var
  I : LongInt;
begin
  result := 0;
  for I := 0 to count-1 do
    if SubItem[I] is TLMDCell then Inc(Result);
end;

{------------------------------------------------------------------------------}

function TLMDTableRow.GetCell(index : LongInt) : TLMDCell;
var
  I, J : LongInt;
begin
  result := nil;
  J := 0;
  for I := 0 to count-1 do
    if SubItem[I] is TLMDCell then begin
      if Index = J then begin
        result := TLMDCell(SubItem[I]);
        Break;
      end;
      inc(J);
    end;
end;

{ ************************************ PUBLIC *********************************}

constructor TLMDTableRow.Create(aParent: TLMDParsedTextList);
begin
  inherited ;
  FHeight := 13;
  FVAlign := vaNone;
end;

{------------------------------------------------------------------------------}

constructor TLMDTableRow.Create(aParent: TLMDParsedTextList; aHeight : LongInt);
begin
  inherited Create(aParent);
  FHeight := aHeight;
  FVAlign := vaNone;
end;

{------------------------------------------------------------------------------}

function TLMDTableRow.Clone: TLMDBaseText;
begin
  result := inherited Clone;
  TLMDTableRow(Result).FHeight := FHeight;
  TLMDTableRow(Result).FVAlign := FVAlign;
end;

{------------------------------------------------------------------------------}

procedure TLMDTableRow.InsertCell(aPos : LongInt);
var
  I, J : LongInt;
begin
  J := 0;
  for I := 0 to count-1 do
    if SubItem[I] is TLMDCell then begin
      if aPos = J then begin
        InsertSubItem(I, TLMDCell.Create(Self));
        Exit;
      end;
      inc(J);
    end;
    for I := J to aPos do
      AddSubItem(TLMDCell.Create(Self));
end;

{------------------------------------------------------------------------------}

procedure TLMDTableRow.Store(AWriter : TLMDWriter);
var
  I : LongInt;
begin
  aWriter.WriteOpenTableRow;
  for I := 0 to count-1 do
    if SubItem[I] is TLMDCell then SubItem[I].Store(aWriter);
  aWriter.WriteCloseTableRow;
end;

end.
